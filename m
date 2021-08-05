Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A323E1DD4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 23:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbhHEVYu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 17:24:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46488 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhHEVYs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 17:24:48 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1C27620B36E8;
        Thu,  5 Aug 2021 14:24:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C27620B36E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628198673;
        bh=1kCDywgDuRADvI5gsC9CZilFuo5uJHSI1ptQ4VPDQn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9Xbn2Kx2cPZ2ogrzKY6LEfpqHdyYpDkUAjppUyM55+3euUd+66u7Ex3l2OZGOgMn
         LDG/7psv1d1I4Ac+C8ghVSbJgiXGfMji7Us2SZLDlcbVYkYQ/YoF/6brPHBphPqq0l
         ABUNErnB9JAWYeA5qCPHlkfkrQQ1J8einEmAYmtk=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
Date:   Thu,  5 Aug 2021 14:23:45 -0700
Message-Id: <1628198641-791-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1628198641-791-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce a barebones module file for the mshv API.
Introduce CONFIG_HYPERV_VMM_API for controlling compilation of mshv.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/Makefile |  1 +
 drivers/hv/Kconfig       | 18 ++++++++++
 drivers/hv/Makefile      |  3 ++
 drivers/hv/mshv_main.c   | 77 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 drivers/hv/mshv_main.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 48e2c51464e8..4b5a8a96ba01 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
 endif
+
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d92391..0fc3fcce3cf7 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -27,4 +27,22 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_VMM_API
+	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
+	depends on HYPERV
+	help
+	  Provides access to interfaces for managing guest virtual machines
+	  running under the Microsoft Hypervisor.
+
+	  These interfaces will only work when Linux is running as root
+	  partition on the Microsoft Hypervisor.
+
+	  The interfaces are provided via a device named /dev/mshv.
+
+	  To compile this as a module, choose M here.
+	  The module is named mshv.
+
+	  If unsure, say N.
+
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 94daf8240c95..c943fbeb70e7 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_HYPERV_ROOT_API)   += mshv.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
@@ -11,3 +12,5 @@ hv_vmbus-y := vmbus_drv.o \
 		 channel_mgmt.o ring_buffer.o hv_trace.o
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
+
+mshv-y                          += mshv_main.o
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
new file mode 100644
index 000000000000..e44adf91f660
--- /dev/null
+++ b/drivers/hv/mshv_main.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, Microsoft Corporation.
+ *
+ * Authors:
+ *   Nuno Das Neves <nudasnev@microsoft.com>
+ *   Lillian Grassin-Drake <ligrassi@microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+
+MODULE_AUTHOR("Microsoft");
+MODULE_LICENSE("GPL");
+
+static int mshv_dev_open(struct inode *inode, struct file *filp);
+static int mshv_dev_release(struct inode *inode, struct file *filp);
+static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+
+static const struct file_operations mshv_dev_fops = {
+	.owner = THIS_MODULE,
+	.open = mshv_dev_open,
+	.release = mshv_dev_release,
+	.unlocked_ioctl = mshv_dev_ioctl,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice mshv_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "mshv",
+	.fops = &mshv_dev_fops,
+	.mode = 0600,
+};
+
+static long
+mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+static int
+mshv_dev_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int
+mshv_dev_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int
+__init mshv_init(void)
+{
+	int ret;
+
+	if (!hv_is_hyperv_initialized())
+		return -ENODEV;
+
+	ret = misc_register(&mshv_dev);
+	if (ret)
+		pr_err("%s: misc device register failed\n", __func__);
+
+	return ret;
+}
+
+static void
+__exit mshv_exit(void)
+{
+	misc_deregister(&mshv_dev);
+}
+
+module_init(mshv_init);
+module_exit(mshv_exit);
-- 
2.23.4

