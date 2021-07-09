Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA623C2320
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhGILqr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 07:46:47 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40896 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhGILqp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 07:46:45 -0400
Received: by mail-wr1-f47.google.com with SMTP id l7so10824274wrv.7;
        Fri, 09 Jul 2021 04:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSFX3nWfJVShogn66NEseu4n0oAIrgC6+jY/JxAIvCw=;
        b=U7jLLLqG4ygTSj3+ss3PWTMv9Uuu8U9c/UW4ZlA1IbWYm4NZDyE6YCsQZgdhdCgKJj
         8qHYkLE7ZULOKv54Q+ILrdmIKH6GTs90XtNWqHz/1Itq2Y2HTFKQM0wIwW48o0p2x6Gz
         1Q2vf9TarHsEcFw7D6yjFfwBwg7M6TtOUSw/CIGu8tvcvb5/GxWHwrKoz7Q7cyxaxWAy
         8g0Sc/WaysjrYp86pM1yGBu9eP5jbTLNM2xa+7wfvXAuRa5S6GfiUPJGEY9lDeRqG8yH
         fzqYxzuFiL5ZWfIxyWoqSLL11ui2f9KpcmEAMOaSGJzeqJs3/H5zdM2/GMbCswoHSwek
         F+SQ==
X-Gm-Message-State: AOAM533aPLvMatVwaf6wLcJ/Xm4keEgLs3ssGM8zbXzVyWKMK5PwmqA2
        gcH3NyXeQXJ4/i2QBeLmmzZkkRLVSw4=
X-Google-Smtp-Source: ABdhPJz8niTl1NXXjunqhr/Y2v9ZeDNWDKscxBnQtK9A6a5Vc4+n4or5eI4NBhGSLI4kQore8Y0MWA==
X-Received: by 2002:adf:f8c5:: with SMTP id f5mr40464046wrq.420.1625831039961;
        Fri, 09 Jul 2021 04:43:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z12sm4896849wrs.39.2021.07.09.04.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:43:59 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        kumarpraveen@linux.microsoft.com, pasha.tatashin@soleen.com,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [RFC v1 8/8] mshv: add vfio bridge device
Date:   Fri,  9 Jul 2021 11:43:39 +0000
Message-Id: <20210709114339.3467637-9-wei.liu@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709114339.3467637-1-wei.liu@kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The main purpose of this device at this stage is to hold a reference to
the vfio_group to avoid it disappearing under our feet.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
Is there value in unifying with KVM?
---
 drivers/hv/Kconfig     |   4 +
 drivers/hv/Makefile    |   2 +-
 drivers/hv/mshv_main.c |   5 +
 drivers/hv/vfio.c      | 244 +++++++++++++++++++++++++++++++++++++++++
 drivers/hv/vfio.h      |  18 +++
 5 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/vfio.c
 create mode 100644 drivers/hv/vfio.h

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 3bf911aac5c7..d3542a818ede 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -2,6 +2,9 @@
 
 menu "Microsoft Hyper-V guest support"
 
+config MSHV_VFIO
+	bool
+
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
@@ -31,6 +34,7 @@ config HYPERV_ROOT_API
 	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
 	depends on HYPERV
 	select EVENTFD
+	select MSHV_VFIO
 	help
 	  Provides access to interfaces for managing guest virtual machines
 	  running under the Microsoft Hypervisor.
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 370d126252ef..c2ae17076b68 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -14,4 +14,4 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
 
 mshv-y                          += mshv_main.o hv_call.o hv_synic.o hv_portid_table.o  \
-					hv_eventfd.o mshv_msi.o
+					hv_eventfd.o mshv_msi.o vfio.o
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index 84c774a561de..49bc7442921f 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -25,6 +25,7 @@
 #include <asm/mshyperv.h>
 
 #include "mshv.h"
+#include "vfio.h"
 
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
@@ -1439,6 +1440,8 @@ __init mshv_init(void)
 	if (mshv_irqfd_wq_init())
 		mshv_irqfd_wq_cleanup();
 
+	mshv_vfio_ops_init();
+
 	return 0;
 }
 
@@ -1452,6 +1455,8 @@ __exit mshv_exit(void)
 
 	hv_port_table_fini();
 
+	mshv_vfio_ops_exit();
+
 	misc_deregister(&mshv_dev);
 }
 
diff --git a/drivers/hv/vfio.c b/drivers/hv/vfio.c
new file mode 100644
index 000000000000..281374a4386e
--- /dev/null
+++ b/drivers/hv/vfio.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VFIO-MSHV bridge pseudo device
+ *
+ * Heavily inspired by the VFIO-KVM bridge pseudo device.
+ * Copyright (C) 2013 Red Hat, Inc.  All rights reserved.
+ *     Author: Alex Williamson <alex.williamson@redhat.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#include <linux/mshv.h>
+
+#include "vfio.h"
+
+
+struct mshv_vfio_group {
+	struct list_head node;
+	struct vfio_group *vfio_group;
+};
+
+struct mshv_vfio {
+	struct list_head group_list;
+	struct mutex lock;
+};
+
+static struct vfio_group *mshv_vfio_group_get_external_user(struct file *filep)
+{
+	struct vfio_group *vfio_group;
+	struct vfio_group *(*fn)(struct file *);
+
+	fn = symbol_get(vfio_group_get_external_user);
+	if (!fn)
+		return ERR_PTR(-EINVAL);
+
+	vfio_group = fn(filep);
+
+	symbol_put(vfio_group_get_external_user);
+
+	return vfio_group;
+}
+
+static bool mshv_vfio_external_group_match_file(struct vfio_group *group,
+						struct file *filep)
+{
+	bool ret, (*fn)(struct vfio_group *, struct file *);
+
+	fn = symbol_get(vfio_external_group_match_file);
+	if (!fn)
+		return false;
+
+	ret = fn(group, filep);
+
+	symbol_put(vfio_external_group_match_file);
+
+	return ret;
+}
+
+static void mshv_vfio_group_put_external_user(struct vfio_group *vfio_group)
+{
+	void (*fn)(struct vfio_group *);
+
+	fn = symbol_get(vfio_group_put_external_user);
+	if (!fn)
+		return;
+
+	fn(vfio_group);
+
+	symbol_put(vfio_group_put_external_user);
+}
+
+static int mshv_vfio_set_group(struct mshv_device *dev, long attr, u64 arg)
+{
+	struct mshv_vfio *mv = dev->private;
+	struct vfio_group *vfio_group;
+	struct mshv_vfio_group *mvg;
+	int32_t __user *argp = (int32_t __user *)(unsigned long)arg;
+	struct fd f;
+	int32_t fd;
+	int ret;
+
+	switch (attr) {
+	case MSHV_DEV_VFIO_GROUP_ADD:
+		if (get_user(fd, argp))
+			return -EFAULT;
+
+		f = fdget(fd);
+		if (!f.file)
+			return -EBADF;
+
+		vfio_group = mshv_vfio_group_get_external_user(f.file);
+		fdput(f);
+
+		if (IS_ERR(vfio_group))
+			return PTR_ERR(vfio_group);
+
+		mutex_lock(&mv->lock);
+
+		list_for_each_entry(mvg, &mv->group_list, node) {
+			if (mvg->vfio_group == vfio_group) {
+				mutex_unlock(&mv->lock);
+				mshv_vfio_group_put_external_user(vfio_group);
+				return -EEXIST;
+			}
+		}
+
+		mvg = kzalloc(sizeof(*mvg), GFP_KERNEL_ACCOUNT);
+		if (!mvg) {
+			mutex_unlock(&mv->lock);
+			mshv_vfio_group_put_external_user(vfio_group);
+			return -ENOMEM;
+		}
+
+		list_add_tail(&mvg->node, &mv->group_list);
+		mvg->vfio_group = vfio_group;
+
+		mutex_unlock(&mv->lock);
+
+		return 0;
+
+	case MSHV_DEV_VFIO_GROUP_DEL:
+		if (get_user(fd, argp))
+			return -EFAULT;
+
+		f = fdget(fd);
+		if (!f.file)
+			return -EBADF;
+
+		ret = -ENOENT;
+
+		mutex_lock(&mv->lock);
+
+		list_for_each_entry(mvg, &mv->group_list, node) {
+			if (!mshv_vfio_external_group_match_file(mvg->vfio_group,
+								 f.file))
+				continue;
+
+			list_del(&mvg->node);
+			mshv_vfio_group_put_external_user(mvg->vfio_group);
+			kfree(mvg);
+			ret = 0;
+			break;
+		}
+
+		mutex_unlock(&mv->lock);
+
+		fdput(f);
+
+		return ret;
+	}
+
+	return -ENXIO;
+}
+
+static int mshv_vfio_set_attr(struct mshv_device *dev,
+			      struct mshv_device_attr *attr)
+{
+	switch (attr->group) {
+	case MSHV_DEV_VFIO_GROUP:
+		return mshv_vfio_set_group(dev, attr->attr, attr->addr);
+	}
+
+	return -ENXIO;
+}
+
+static int mshv_vfio_has_attr(struct mshv_device *dev,
+			      struct mshv_device_attr *attr)
+{
+	switch (attr->group) {
+	case MSHV_DEV_VFIO_GROUP:
+		switch (attr->attr) {
+		case MSHV_DEV_VFIO_GROUP_ADD:
+		case MSHV_DEV_VFIO_GROUP_DEL:
+			return 0;
+		}
+
+		break;
+	}
+
+	return -ENXIO;
+}
+
+static void mshv_vfio_destroy(struct mshv_device *dev)
+{
+	struct mshv_vfio *mv = dev->private;
+	struct mshv_vfio_group *mvg, *tmp;
+
+	list_for_each_entry_safe(mvg, tmp, &mv->group_list, node) {
+		mshv_vfio_group_put_external_user(mvg->vfio_group);
+		list_del(&mvg->node);
+		kfree(mvg);
+	}
+
+	kfree(mv);
+	kfree(dev);
+}
+
+static int mshv_vfio_create(struct mshv_device *dev, u32 type);
+
+static struct mshv_device_ops mshv_vfio_ops = {
+	.name = "mshv-vfio",
+	.create = mshv_vfio_create,
+	.destroy = mshv_vfio_destroy,
+	.set_attr = mshv_vfio_set_attr,
+	.has_attr = mshv_vfio_has_attr,
+};
+
+static int mshv_vfio_create(struct mshv_device *dev, u32 type)
+{
+	struct mshv_device *tmp;
+	struct mshv_vfio *mv;
+
+	/* Only one VFIO "device" per VM */
+	list_for_each_entry(tmp, &dev->partition->devices, partition_node)
+		if (tmp->ops == &mshv_vfio_ops)
+			return -EBUSY;
+
+	mv = kzalloc(sizeof(*mv), GFP_KERNEL_ACCOUNT);
+	if (!mv)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&mv->group_list);
+	mutex_init(&mv->lock);
+
+	dev->private = mv;
+
+	return 0;
+}
+
+int mshv_vfio_ops_init(void)
+{
+	return mshv_register_device_ops(&mshv_vfio_ops, MSHV_DEV_TYPE_VFIO);
+}
+
+void mshv_vfio_ops_exit(void)
+{
+	mshv_unregister_device_ops(MSHV_DEV_TYPE_VFIO);
+}
diff --git a/drivers/hv/vfio.h b/drivers/hv/vfio.h
new file mode 100644
index 000000000000..0544476e6629
--- /dev/null
+++ b/drivers/hv/vfio.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __MSHV_VFIO_H
+#define __MSHV_VFIO_H
+
+#ifdef CONFIG_MSHV_VFIO
+int mshv_vfio_ops_init(void);
+void mshv_vfio_ops_exit(void);
+#else
+static inline int mshv_vfio_ops_init(void)
+{
+	return 0;
+}
+static inline void mshv_vfio_ops_exit(void)
+{
+}
+#endif
+
+#endif
-- 
2.30.2

