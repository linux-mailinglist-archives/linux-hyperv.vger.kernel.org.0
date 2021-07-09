Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36163C231E
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhGILqq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:46 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36532 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGILqn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:43 -0400
Received: by mail-wr1-f49.google.com with SMTP id v5so11777011wrt.3;
        Fri, 09 Jul 2021 04:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEDD9wpewEvqoqq6G5yrwRMxTRP5lFts3xZ7kRx42is=;
        b=giZVa/UkS50XINU4vrkRQK08wlVnCm4gYOTn5ws9UDbfcthNuz4ZqD1TK9cR8Z4rwb
         Jmf2X23qcTwuF9Ntep+0kRcHt8uWrO9en49nxAjQDqja5n5MLYEG1vAqd901B96hzQPi
         eqJHJO4eKocjY/P7TOwCA0wgaWBKqXJ9r+tqxhtUmVxRdLsGJiix6BjBNVDMtbivmaq/
         dkfBoc7+UNIdUNDqLvSE/aclB5LOm4S9vfA6WMFIMGx/bwWTrzuSHnpRBcLDD/HJg/lN
         S06MbG1zcokddCWPoWEKEBZ4kVcEdi4qvJe0kuA8mOqiFz38z2R8H9SrSIHOEd0/8qpG
         p9QQ==
X-Gm-Message-State: AOAM530bcfTk7zyiwGozLTQwfCmwBmHmhMIyy/LXwLYKCStkDWmea3Ul
        Vbw2NwMbUrTSMBkeae2zFM+OF0MvBD4=
X-Google-Smtp-Source: ABdhPJx5ghpc3+TT4EiNeuCwN7HlwYCH6Lkezlw8wSDOFz7Yh1eK9cNarbNpx0rBS81uWEKrFfYE7A==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr41052459wrt.425.1625831037773;
        Fri, 09 Jul 2021 04:43:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:57 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Wei Liu <wei.liu@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        Muminul Islam <muislam@microsoft.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [RFC v1 7/8] mshv: implement in-kernel device framework
Date:   Fri,  9 Jul 2021 11:43:38 +0000
Message-Id: <20210709114339.3467637-8-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is basically the same code adopted from KVM. The main user case is
the future MSHV-VFIO bridge device. We don't have any plan to support
in-kernel device emulation yet, but it wouldn't hurt to make the code
more flexible.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 Documentation/virt/mshv/api.rst |  12 +++
 drivers/hv/mshv_main.c          | 181 ++++++++++++++++++++++++++++++++
 include/linux/mshv.h            |  57 ++++++++++
 include/uapi/linux/mshv.h       |  36 +++++++
 4 files changed, 286 insertions(+)

diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
index 56a6edfcfe29..7d35dd589831 100644
--- a/Documentation/virt/mshv/api.rst
+++ b/Documentation/virt/mshv/api.rst
@@ -170,4 +170,16 @@ Can be used to get/set various properties of a partition.
 Some properties can only be set at partition creation. For these, there are
 parameters in MSHV_CREATE_PARTITION.
 
+3.12 MSHV_CREATE_DEVICE
+-----------------------
+:Type: partition ioctl
+:Parameters: struct mshv_create_device
+:Returns: 0 on success
+
+Can be used to create an in-kernel device.
+
+If the MSHV_CREATE_DEVICE_TEST flag is set, only test whether the
+device type is supported (not necessarily whether it can be created
+in the current vm).
 
+Currently only supports VFIO type device.
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 4cbc520471e4..84c774a561de 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -20,6 +20,8 @@
 #include <linux/random.h>
 #include <linux/mshv.h>
 #include <linux/mshv_eventfd.h>
+#include <linux/hyperv.h>
+#include <linux/nospec.h>
 #include <asm/mshyperv.h>
 
 #include "mshv.h"
@@ -33,6 +35,7 @@ static int mshv_vp_release(struct inode *inode, struct file *filp);
 static long mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
 static struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
 static void mshv_partition_put(struct mshv_partition *partition);
+static void mshv_partition_put_no_destroy(struct mshv_partition *partition);
 static int mshv_partition_release(struct inode *inode, struct file *filp);
 static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
 static int mshv_dev_open(struct inode *inode, struct file *filp);
@@ -912,6 +915,172 @@ mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
 	return ret;
 }
 
+static int mshv_device_ioctl_attr(struct mshv_device *dev,
+				 int (*accessor)(struct mshv_device *dev,
+						 struct mshv_device_attr *attr),
+				 unsigned long arg)
+{
+	struct mshv_device_attr attr;
+
+	if (!accessor)
+		return -EPERM;
+
+	if (copy_from_user(&attr, (void __user *)arg, sizeof(attr)))
+		return -EFAULT;
+
+	return accessor(dev, &attr);
+}
+
+static long mshv_device_ioctl(struct file *filp, unsigned int ioctl,
+			      unsigned long arg)
+{
+	struct mshv_device *dev = filp->private_data;
+
+	switch (ioctl) {
+	case MSHV_SET_DEVICE_ATTR:
+		return mshv_device_ioctl_attr(dev, dev->ops->set_attr, arg);
+	case MSHV_GET_DEVICE_ATTR:
+		return mshv_device_ioctl_attr(dev, dev->ops->get_attr, arg);
+	case MSHV_HAS_DEVICE_ATTR:
+		return mshv_device_ioctl_attr(dev, dev->ops->has_attr, arg);
+	default:
+		if (dev->ops->ioctl)
+			return dev->ops->ioctl(dev, ioctl, arg);
+
+		return -ENOTTY;
+	}
+}
+
+static int mshv_device_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_device *dev = filp->private_data;
+	struct mshv_partition *partition = dev->partition;
+
+	if (dev->ops->release) {
+		mutex_lock(&partition->mutex);
+		list_del(&dev->partition_node);
+		dev->ops->release(dev);
+		mutex_unlock(&partition->mutex);
+	}
+
+	mshv_partition_put(partition);
+	return 0;
+}
+
+static const struct file_operations mshv_device_fops = {
+	.unlocked_ioctl = mshv_device_ioctl,
+	.release = mshv_device_release,
+};
+
+static const struct mshv_device_ops *mshv_device_ops_table[MSHV_DEV_TYPE_MAX];
+
+int mshv_register_device_ops(const struct mshv_device_ops *ops, u32 type)
+{
+	if (type >= ARRAY_SIZE(mshv_device_ops_table))
+		return -ENOSPC;
+
+	if (mshv_device_ops_table[type] != NULL)
+		return -EEXIST;
+
+	mshv_device_ops_table[type] = ops;
+	return 0;
+}
+
+void mshv_unregister_device_ops(u32 type)
+{
+	if (type >= ARRAY_SIZE(mshv_device_ops_table))
+		return;
+	mshv_device_ops_table[type] = NULL;
+}
+
+static long
+mshv_partition_ioctl_create_device(struct mshv_partition *partition,
+	void __user *user_args)
+{
+	long r;
+	struct mshv_create_device tmp, *cd;
+	struct mshv_device *dev;
+	const struct mshv_device_ops *ops;
+	int type;
+
+	if (copy_from_user(&tmp, user_args, sizeof(tmp))) {
+		r = -EFAULT;
+		goto out;
+	}
+
+	cd = &tmp;
+
+	if (cd->type >= ARRAY_SIZE(mshv_device_ops_table)) {
+		r = -ENODEV;
+		goto out;
+	}
+
+	type = array_index_nospec(cd->type, ARRAY_SIZE(mshv_device_ops_table));
+	ops = mshv_device_ops_table[type];
+	if (ops == NULL) {
+		r = -ENODEV;
+		goto out;
+	}
+
+	if (cd->flags & MSHV_CREATE_DEVICE_TEST) {
+		r = 0;
+		goto out;
+	}
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL_ACCOUNT);
+	if (!dev) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	dev->ops = ops;
+	dev->partition = partition;
+
+	r = ops->create(dev, type);
+	if (r < 0) {
+		kfree(dev);
+		goto out;
+	}
+
+	list_add(&dev->partition_node, &partition->devices);
+
+	if (ops->init)
+		ops->init(dev);
+
+	mshv_partition_get(partition);
+	r = anon_inode_getfd(ops->name, &mshv_device_fops, dev, O_RDWR | O_CLOEXEC);
+	if (r < 0) {
+		mshv_partition_put_no_destroy(partition);
+		list_del(&dev->partition_node);
+		ops->destroy(dev);
+		goto out;
+	}
+
+	cd->fd = r;
+	r = 0;
+
+	if (copy_to_user(user_args, &tmp, sizeof(tmp))) {
+		r = -EFAULT;
+		goto out;
+	}
+out:
+	return r;
+}
+
+static void mshv_destroy_devices(struct mshv_partition *partition)
+{
+	struct mshv_device *dev, *tmp;
+
+	/*
+	 * No need to take any lock since at this point nobody else can
+	 * reference this partition.
+	 */
+	list_for_each_entry_safe(dev, tmp, &partition->devices, partition_node) {
+		list_del(&dev->partition_node);
+		dev->ops->destroy(dev);
+	}
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -965,6 +1134,9 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_GET_GPA_ACCESS_STATES:
 		ret = mshv_partition_ioctl_get_gpa_access_state(partition,
 							   (void __user *)arg);
+	case MSHV_CREATE_DEVICE:
+		ret = mshv_partition_ioctl_create_device(partition,
+							 (void __user *)arg);
 		break;
 	default:
 		ret = -ENOTTY;
@@ -1033,6 +1205,7 @@ destroy_partition(struct mshv_partition *partition)
 		vfree(region->pages);
 	}
 
+	mshv_destroy_devices(partition);
 	mshv_free_msi_routing(partition);
 	kfree(partition);
 }
@@ -1052,6 +1225,12 @@ mshv_partition_put(struct mshv_partition *partition)
 		destroy_partition(partition);
 }
 
+static void
+mshv_partition_put_no_destroy(struct mshv_partition *partition)
+{
+	WARN_ON(refcount_dec_and_test(&partition->ref_count));
+}
+
 static int
 mshv_partition_release(struct inode *inode, struct file *filp)
 {
@@ -1122,6 +1301,8 @@ mshv_ioctl_create_partition(void __user *user_arg)
 
 	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
 
+	INIT_LIST_HEAD(&partition->devices);
+
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		ret = fd;
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
index fc655b60c5cd..c557ffeec90c 100644
--- a/include/linux/mshv.h
+++ b/include/linux/mshv.h
@@ -59,6 +59,8 @@ struct mshv_partition {
 	struct srcu_struct irq_srcu;
 	struct hlist_head irq_ack_notifier_list;
 
+	struct list_head devices;
+
 	struct {
 		spinlock_t        lock;
 		struct list_head  items;
@@ -121,4 +123,59 @@ struct mshv {
 	} partitions;
 };
 
+struct mshv_device {
+	const struct mshv_device_ops *ops;
+	struct mshv_partition *partition;
+	void *private;
+	struct list_head partition_node;
+
+};
+
+/* create, destroy, and name are mandatory */
+struct mshv_device_ops {
+	const char *name;
+
+	/*
+	 * create is called holding partition->mutex and any operations not suitable
+	 * to do while holding the lock should be deferred to init (see
+	 * below).
+	 */
+	int (*create)(struct mshv_device *dev, u32 type);
+
+	/*
+	 * init is called after create if create is successful and is called
+	 * outside of holding partition->mutex.
+	 */
+	void (*init)(struct mshv_device *dev);
+
+	/*
+	 * Destroy is responsible for freeing dev.
+	 *
+	 * Destroy may be called before or after destructors are called
+	 * on emulated I/O regions, depending on whether a reference is
+	 * held by a vcpu or other mshv component that gets destroyed
+	 * after the emulated I/O.
+	 */
+	void (*destroy)(struct mshv_device *dev);
+
+	/*
+	 * Release is an alternative method to free the device. It is
+	 * called when the device file descriptor is closed. Once
+	 * release is called, the destroy method will not be called
+	 * anymore as the device is removed from the device list of
+	 * the VM. partition->mutex is held.
+	 */
+	void (*release)(struct mshv_device *dev);
+
+	int (*set_attr)(struct mshv_device *dev, struct mshv_device_attr *attr);
+	int (*get_attr)(struct mshv_device *dev, struct mshv_device_attr *attr);
+	int (*has_attr)(struct mshv_device *dev, struct mshv_device_attr *attr);
+	long (*ioctl)(struct mshv_device *dev, unsigned int ioctl,
+		      unsigned long arg);
+	int (*mmap)(struct mshv_device *dev, struct vm_area_struct *vma);
+};
+
+int mshv_register_device_ops(const struct mshv_device_ops *ops, u32 type);
+void mshv_unregister_device_ops(u32 type);
+
 #endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index cba318ee7cf5..ed110109492f 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -158,6 +158,14 @@ struct mshv_msi_routing {
 #define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
 #define MSHV_TRANSLATE_GVA	_IOWR(MSHV_IOCTL, 0x0E, struct mshv_translate_gva)
 
+/* ioctl for device fd */
+#define MSHV_CREATE_DEVICE	  _IOWR(MSHV_IOCTL, 0x13, struct mshv_create_device)
+
+/* ioctls for fds returned by MSHV_CREATE_DEVICE */
+#define MSHV_SET_DEVICE_ATTR	  _IOW(MSHV_IOCTL, 0x14, struct mshv_device_attr)
+#define MSHV_GET_DEVICE_ATTR	  _IOW(MSHV_IOCTL, 0x15, struct mshv_device_attr)
+#define MSHV_HAS_DEVICE_ATTR	  _IOW(MSHV_IOCTL, 0x16, struct mshv_device_attr)
+
 /* register page mapping example:
  * struct hv_vp_register_page *regs = mmap(NULL,
  *					   4096,
@@ -184,4 +192,32 @@ union mshv_partition_property_page_access_tracking_config {
 	__u64 as_uint64;
 } __packed;
 
+/*
+ * Device control API.
+ */
+#define MSHV_CREATE_DEVICE_TEST		1
+
+struct mshv_create_device {
+	__u32	type;	/* in: MSHV_DEV_TYPE_xxx */
+	__u32	fd;	/* out: device handle */
+	__u32	flags;	/* in: MSHV_CREATE_DEVICE_xxx */
+};
+
+#define  MSHV_DEV_VFIO_GROUP			1
+#define   MSHV_DEV_VFIO_GROUP_ADD			1
+#define   MSHV_DEV_VFIO_GROUP_DEL			2
+
+enum mshv_device_type {
+	MSHV_DEV_TYPE_VFIO,
+#define MSHV_DEV_TYPE_VFIO		MSHV_DEV_TYPE_VFIO
+	MSHV_DEV_TYPE_MAX,
+};
+
+struct mshv_device_attr {
+	__u32	flags;		/* no flags currently defined */
+	__u32	group;		/* device-defined */
+	__u64	attr;		/* group-defined */
+	__u64	addr;		/* userspace address of attr data */
+};
+
 #endif
-- 
2.30.2

