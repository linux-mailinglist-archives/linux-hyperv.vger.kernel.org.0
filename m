Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27E2BBAE1
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgKUAay (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:30:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51224 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgKUAaw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:52 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 10AD620B8009;
        Fri, 20 Nov 2020 16:30:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10AD620B8009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918650;
        bh=WN+BUR5H8uAftEhtX6U1Kv4M39mmahB+zK9fq8v11i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/J9D69pj905lYA2+NhTb/iBnQ5bV5i9ySj3ljsGBntCghsLOXgo33i8mJYY+D9Zs
         NLdLctcC9hTdOlWhj3RGp1VEvlQq3FMer+Ikv+c3ttL1rKmxl7Q+7CWiodw/v8k4Xt
         72DGBbBMkDA4e0coMAOsH306jpnpBtajO6qFie0M=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 09/18] virt/mshv: create vcpu ioctl
Date:   Fri, 20 Nov 2020 16:30:28 -0800
Message-Id: <1605918637-12192-10-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce ioctl for creating a virtual processor in a partition.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 Documentation/virt/mshv/api.rst |   9 +++
 include/linux/mshv.h            |  10 +++
 include/uapi/linux/mshv.h       |   5 ++
 virt/mshv/mshv_main.c           | 121 +++++++++++++++++++++++++++++++-
 4 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 530efc29d354..f997f49f8690 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -87,3 +87,12 @@ Note: In the current implementation, this memory is pinned to stop the pages
 being moved by linux and subsequently clobbered by the hypervisor. So the region
 is backed by physical memory.
 
+3.4 MSHV_CREATE_VP
+------------------
+:Type: partition ioctl
+:Parameters: struct mshv_create_vp
+:Returns: vp file descriptor, or -1 on failure
+
+Create a virtual processor in a guest partition, returning a file descriptor to
+represent the vp and perform ioctls on.
+
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
index 47be03ef4e86..1f053eae68a6 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -29,6 +29,10 @@ struct mshv_user_mem_region {
 	__u32 flags;		/* ignored on unmap */
 };
 
+struct mshv_create_vp {
+	__u32 vp_index;
+};
+
 #define MSHV_IOCTL 0xB8
 
 /* mshv device */
@@ -38,5 +42,6 @@ struct mshv_user_mem_region {
 /* partition device */
 #define MSHV_MAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
 #define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_mem_region)
+#define MSHV_CREATE_VP		_IOW(MSHV_IOCTL, 0x04, struct mshv_create_vp)
 
 #endif
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index ce480598e67f..3be9d9a468c1 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -30,6 +30,10 @@ static u32 supported_versions[] = {
 
 static struct mshv mshv = {};
 
+static int mshv_vp_release(struct inode *inode, struct file *filp);
+static long mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+
+static struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
 static void mshv_partition_put(struct mshv_partition *partition);
 static int mshv_partition_release(struct inode *inode, struct file *filp);
 static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
@@ -37,6 +41,12 @@ static int mshv_dev_open(struct inode *inode, struct file *filp);
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
@@ -370,6 +380,94 @@ hv_call_unmap_gpa_pages(u64 partition_id,
 	return ret;
 }
 
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
+	mshv_partition_put(vp->partition);
+
+	/* Rest of VP cleanup happens in destroy_partition() */
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
@@ -548,6 +646,10 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
@@ -560,6 +662,7 @@ static void
 destroy_partition(struct mshv_partition *partition)
 {
 	unsigned long flags, page_count;
+	struct mshv_vp *vp;
 	struct mshv_mem_region *region;
 	int i;
 
@@ -581,7 +684,7 @@ destroy_partition(struct mshv_partition *partition)
 	spin_unlock_irqrestore(&mshv.partitions.lock, flags);
 
 	/*
-	 * There are no remaining references to the partition or vps,
+	 * There are no remaining references to the partition,
 	 * so the remaining cleanup can be lockless
 	 */
 
@@ -591,6 +694,14 @@ destroy_partition(struct mshv_partition *partition)
 	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->id);
 
 	hv_call_delete_partition(partition->id);
+	
+	/* Remove vps */
+	for (i = 0; i < MSHV_MAX_VPS; ++i) {
+		vp = partition->vps.array[i];
+		if (!vp)
+			continue;
+		kfree(vp);
+	}
 
 	/* Remove regions and unpin the pages */
 	for (i = 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
@@ -605,6 +716,14 @@ destroy_partition(struct mshv_partition *partition)
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
-- 
2.25.1

