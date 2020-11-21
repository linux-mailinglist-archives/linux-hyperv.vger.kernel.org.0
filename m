Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940A22BBADD
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKUAau (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:30:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51182 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgKUAau (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:50 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 82FD120B71D1;
        Fri, 20 Nov 2020 16:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82FD120B71D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918649;
        bh=MebfIyhuSjtcItZhTeTBX3QIsCHrngY2XYQqTgXCPYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLgYOBresYxJgoxN0DlBM9yVv0ko+Ri+Z7wYyu0wJUzajy77ENNnwrsyy+zTU2UTN
         HofrVvFIyualY5DXVDLEEh50nU1J7ajNzq9ceFHdeJpTmqpK3JtthIREEhsMJbOg/a
         cclk3D31Gqx67uE+z+z2q4KlWyJdD+XAbsmFQpXM=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 03/18] virt/mshv: minimal mshv module (/dev/mshv/)
Date:   Fri, 20 Nov 2020 16:30:22 -0800
Message-Id: <1605918637-12192-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Introduce a barebones module file for the mshv API.
Introduce CONFIG_HYPERV_ROOT_API for controlling compilation of mshv.

Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/Kconfig         |  2 ++
 arch/x86/hyperv/Kconfig  | 22 +++++++++++++
 arch/x86/hyperv/Makefile |  4 +++
 virt/mshv/mshv_main.c    | 70 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 arch/x86/hyperv/Kconfig
 create mode 100644 virt/mshv/mshv_main.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..8d3848eea358 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2901,3 +2901,5 @@ source "drivers/firmware/Kconfig"
 source "arch/x86/kvm/Kconfig"
 
 source "arch/x86/Kconfig.assembler"
+
+source "arch/x86/hyperv/Kconfig"
diff --git a/arch/x86/hyperv/Kconfig b/arch/x86/hyperv/Kconfig
new file mode 100644
index 000000000000..81e783ab3514
--- /dev/null
+++ b/arch/x86/hyperv/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# HYPERV_ROOT_API configuration
+#
+
+config HYPERV_ROOT_API
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
+	  To compile this as a module, choose M here: the module
+	  will be called mshv.
+
+	  If unsure, say N.
+
diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 2ebcf3969121..86f6dc1c5118 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -5,3 +5,7 @@ obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o irqdomain.o
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
 endif
+
+MSHV := ../../../virt/mshv
+mshv-y                          += $(MSHV)/mshv_main.o
+obj-$(CONFIG_HYPERV_ROOT_API)   += mshv.o
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
new file mode 100644
index 000000000000..ecb9089761fe
--- /dev/null
+++ b/virt/mshv/mshv_main.c
@@ -0,0 +1,70 @@
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
+	.mode = 600,
+};
+
+static int
+__init mshv_init(void)
+{
+	int r;
+
+	r = misc_register(&mshv_dev);
+	if (r)
+		pr_err("%s: misc device register failed\n", __func__);
+
+	return r;
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
2.25.1

