Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E861941B64A
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 20:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbhI1SdL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 14:33:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbhI1SdB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 14:33:01 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8AED320B56BB;
        Tue, 28 Sep 2021 11:31:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AED320B56BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632853881;
        bh=Sf0Xgmxj1TUqobHufSsj1ZT26c6OLch3E2k0TLS45XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggsIHzgFDidWB7r/ERkB0YJw7yhxde2dXkHB18PXtlAvKVdbUEBd1zf7NXDXlwMx1
         v6xBt/HvNFe+HOoDX72KbIyNN0sWqCrege+ey1RTKwhypDAidwEtr6NAd2LD1/a6Id
         U6GNO7T5pgdvyIXZ4FG0bAvMqQ4uT2TDz0Pby8T0=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH v3 09/19] drivers/hv: create vcpu ioctl
Date:   Tue, 28 Sep 2021 11:31:05 -0700
Message-Id: <1632853875-20261-10-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctl for creating a virtual processor in a partition.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst |   9 +++
 drivers/hv/mshv_main.c          | 119 +++++++++++++++++++++++++++++++-
 include/linux/mshv.h            |  10 +++
 include/uapi/linux/mshv.h       |   5 ++
 4 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 71c93b73e999..2538756bc86b 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -87,3 +87,12 @@ memory to stop the pages being moved by Linux in the root partition,
 and subsequently being clobbered by the hypervisor. So the region is backed
 by real physical memory.
 
+3.4 MSHV_CREATE_VP
+------------------
+:Type: partition ioctl
+:Parameters: struct mshv_create_vp
+:Returns: vp file descriptor, or -1 on failure
+
+Create a virtual processor in a guest partition, returning a file descriptor to
+represent the vp and perform ioctls on.
+
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index c5c18826a38f..c3ac8c371d0f 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -25,6 +25,9 @@ MODULE_LICENSE("GPL");
 
 struct mshv mshv = {};
 
+static int mshv_vp_release(struct inode *inode, struct file *filp);
+static long mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+static struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
 static void mshv_partition_put(struct mshv_partition *partition);
 static int mshv_partition_release(struct inode *inode, struct file *filp);
 static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
@@ -32,6 +35,12 @@ static int mshv_dev_open(struct inode *inode, struct file *filp);
 static int mshv_dev_release(struct inode *inode, struct file *filp);
 static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
 
+static const struct file_operations mshv_vp_fops = {
+	.release = mshv_vp_release,
+	.unlocked_ioctl = mshv_vp_ioctl,
+	.llseek = noop_llseek,
+};
+
 static const struct file_operations mshv_partition_fops = {
 	.release = mshv_partition_release,
 	.unlocked_ioctl = mshv_partition_ioctl,
@@ -53,6 +62,94 @@ static struct miscdevice mshv_dev = {
 	.mode = 0600,
 };
 
+static long
+mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+static int
+mshv_vp_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_vp *vp = filp->private_data;
+
+	/* Rest of VP cleanup happens in destroy_partition() */
+	mshv_partition_put(vp->partition);
+	return 0;
+}
+
+static long
+mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
+			       void __user *arg)
+{
+	struct mshv_create_vp args;
+	struct mshv_vp *vp;
+	struct file *file;
+	int fd;
+	long ret;
+
+	if (copy_from_user(&args, arg, sizeof(args)))
+		return -EFAULT;
+
+	if (args.vp_index >= MSHV_MAX_VPS)
+		return -EINVAL;
+
+	if (partition->vps.array[args.vp_index])
+		return -EEXIST;
+
+	vp = kzalloc(sizeof(*vp), GFP_KERNEL);
+
+	if (!vp)
+		return -ENOMEM;
+
+	vp->index = args.vp_index;
+	vp->partition = mshv_partition_get(partition);
+	if (!vp->partition) {
+		ret = -EBADF;
+		goto free_vp;
+	}
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto put_partition;
+	}
+
+	file = anon_inode_getfile("mshv_vp", &mshv_vp_fops, vp, O_RDWR);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto put_fd;
+	}
+
+	ret = hv_call_create_vp(
+			NUMA_NO_NODE,
+			partition->id,
+			args.vp_index,
+			0 /* Only valid for root partition VPs */
+			);
+	if (ret)
+		goto release_file;
+
+	/* already exclusive with the partition mutex for all ioctls */
+	partition->vps.count++;
+	partition->vps.array[args.vp_index] = vp;
+
+	fd_install(fd, file);
+
+	return fd;
+
+release_file:
+	file->f_op->release(file->f_inode, file);
+put_fd:
+	put_unused_fd(fd);
+put_partition:
+	mshv_partition_put(partition);
+free_vp:
+	kfree(vp);
+
+	return ret;
+}
+
 static long
 mshv_partition_ioctl_map_memory(struct mshv_partition *partition,
 				struct mshv_user_mem_region __user *user_mem)
@@ -228,6 +325,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		ret = mshv_partition_ioctl_unmap_memory(partition,
 							(void __user *)arg);
 		break;
+	case MSHV_CREATE_VP:
+		ret = mshv_partition_ioctl_create_vp(partition,
+							(void __user *)arg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
@@ -240,6 +341,7 @@ static void
 destroy_partition(struct mshv_partition *partition)
 {
 	unsigned long flags, page_count;
+	struct mshv_vp *vp;
 	struct mshv_mem_region *region;
 	int i;
 
@@ -269,9 +371,16 @@ destroy_partition(struct mshv_partition *partition)
 	hv_call_finalize_partition(partition->id);
 	/* Withdraw and free all pages we deposited */
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
-
 	hv_call_delete_partition(partition->id);
 
+	/* Remove vps */
+	for (i = 0; i < MSHV_MAX_VPS; ++i) {
+		vp = partition->vps.array[i];
+		if (!vp)
+			continue;
+		kfree(vp);
+	}
+
 	/* Remove regions and unpin the pages */
 	for (i = 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
 		region = &partition->regions.slots[i];
@@ -285,6 +394,14 @@ destroy_partition(struct mshv_partition *partition)
 	kfree(partition);
 }
 
+static struct
+mshv_partition *mshv_partition_get(struct mshv_partition *partition)
+{
+	if (refcount_inc_not_zero(&partition->ref_count))
+		return partition;
+	return NULL;
+}
+
 static void
 mshv_partition_put(struct mshv_partition *partition)
 {
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index 91a742f37440..50521c5f7948 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -12,6 +12,12 @@
 
 #define MSHV_MAX_PARTITIONS		128
 #define MSHV_MAX_MEM_REGIONS		64
+#define MSHV_MAX_VPS			256
+
+struct mshv_vp {
+	u32 index;
+	struct mshv_partition *partition;
+};
 
 struct mshv_mem_region {
 	u64 size; /* bytes */
@@ -28,6 +34,10 @@ struct mshv_partition {
 		u32 count;
 		struct mshv_mem_region slots[MSHV_MAX_MEM_REGIONS];
 	} regions;
+	struct {
+		u32 count;
+		struct mshv_vp *array[MSHV_MAX_VPS];
+	} vps;
 };
 
 struct mshv {
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 7ead5f1c8b14..251976348441 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -30,6 +30,10 @@ struct mshv_user_mem_region {
 	__u32 flags;		/* ignored on unmap */
 };
 
+struct mshv_create_vp {
+	__u32 vp_index;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -39,5 +43,6 @@ struct mshv_user_mem_region {
 /* partition device */
 #define MSHV_MAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
 #define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_mem_region)
+#define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
 
 #endif
-- 
2.23.4

