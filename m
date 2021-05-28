Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0A3948CB
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE1WpT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 May 2021 18:45:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55840 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhE1WpR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 May 2021 18:45:17 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7BF9520B800D;
        Fri, 28 May 2021 15:43:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BF9520B800D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622241822;
        bh=FXXHAA5Bq2PZuhdBNKjpNbmiIDGhfJKNfm1gwKBGkSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UnLnBxUG7ocYGYOImdLaaA/EL+yg9WztJRvV5cO/J8+sk17Llm1+DCpKlZz/q4wKi
         D0HscYGwdMsMaNKxnYvJgrZN7tMQSk5isux4Ry5sQG+8HRu/Dy0J/0trJmsyBZ1/66
         ERw/dDxKF2kJLDLyO/4TPHsa8MMCqchzDLAGAboc=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: [PATCH 04/19] drivers/hv: check extension ioctl
Date:   Fri, 28 May 2021 15:43:24 -0700
Message-Id: <1622241819-21155-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reserve ioctl number in userpsace-api/ioctl/ioctl-number.rst
Introduce MSHV_CHECK_EXTENSION ioctl.
Introduce documentation for /dev/mshv in Documentation/virt/mshv

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  2 +
 Documentation/virt/mshv/api.rst               | 60 +++++++++++++++++++
 drivers/hv/mshv_main.c                        | 23 +++++++
 include/linux/mshv.h                          | 11 ++++
 include/uapi/linux/mshv.h                     | 20 +++++++
 5 files changed, 116 insertions(+)
 create mode 100644 Documentation/virt/mshv/api.rst
 create mode 100644 include/linux/mshv.h
 create mode 100644 include/uapi/linux/mshv.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 9bfc2b510c64..585d9cc42a5a 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -350,6 +350,8 @@ Code  Seq#    Include File                                           Comments
 0xB6  all    linux/fpga-dfl.h
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
 0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
+0xB8  all    uapi/linux/mshv.h                                       Microsoft Hypervisor root partition APIs
+                                                                     <mailto:linux-hyperv@vger.kernel.org>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
new file mode 100644
index 000000000000..75c5e073ecc0
--- /dev/null
+++ b/Documentation/virt/mshv/api.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+Microsoft Hypervisor Root Partition API Documentation
+=====================================================
+
+1. Overview
+===========
+
+This document describes APIs for creating and managing guest virtual machines
+when running Linux as the root partition on the Microsoft Hypervisor.
+
+Note that this API is not yet stable!
+
+2. Glossary/Terms
+=================
+
+hv
+--
+Short for Hyper-V. This name is used in the kernel to describe interfaces to
+the Microsoft Hypervisor.
+
+mshv
+----
+Short for Microsoft Hypervisor. This is the name of the userland API module
+described in this document.
+
+Partition
+---------
+A virtual machine running on the Microsoft Hypervisor.
+
+Root Partition
+--------------
+The partition that is created and assumes control when the machine boots. The
+root partition can use mshv APIs to create guest partitions.
+
+3. API description
+==================
+
+The module is named mshv and can be configured with CONFIG_HYPERV_ROOT_API.
+
+Mshv is file descriptor-based, following a similar pattern to KVM.
+
+To get a handle to the mshv driver, use open("/dev/mshv").
+
+3.1 MSHV_CHECK_EXTENSION
+------------------------
+:Type: /dev/mshv ioctl
+:Parameters: pointer to a u32
+:Returns: 0 if extension unsupported, positive number if supported
+
+This ioctl takes a single argument corresponding to an API extension to check
+support for.
+
+If the extension is supported, MSHV_CHECK_EXTENSION will return a positive
+number. If not, it will return 0.
+
+The first extension that can be checked is MSHV_CAP_CORE_API_STABLE. This
+will be supported when the core API is stable.
+
diff --git a/drivers/hv/mshv_main.c b/drivers/hv/mshv_main.c
index c68cc84fb983..3342ea5bbd1d 100644
--- a/drivers/hv/mshv_main.c
+++ b/drivers/hv/mshv_main.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/mshv.h>
 
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
@@ -34,9 +36,30 @@ static struct miscdevice mshv_dev = {
 	.mode = 600,
 };
 
+static long
+mshv_ioctl_check_extension(void __user *user_arg)
+{
+	u32 arg;
+
+	if (copy_from_user(&arg, user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	switch (arg) {
+	case MSHV_CAP_CORE_API_STABLE:
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
 static long
 mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
+	switch (ioctl) {
+	case MSHV_CHECK_EXTENSION:
+		return mshv_ioctl_check_extension((void __user *)arg);
+	}
+
 	return -ENOTTY;
 }
 
diff --git a/include/linux/mshv.h b/include/linux/mshv.h
new file mode 100644
index 000000000000..a0982fe2c0b8
--- /dev/null
+++ b/include/linux/mshv.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_MSHV_H
+#define _LINUX_MSHV_H
+
+/*
+ * Microsoft Hypervisor root partition driver for /dev/mshv
+ */
+
+#include <uapi/linux/mshv.h>
+
+#endif
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
new file mode 100644
index 000000000000..3b84e3ea97be
--- /dev/null
+++ b/include/uapi/linux/mshv.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_MSHV_H
+#define _UAPI_LINUX_MSHV_H
+
+/*
+ * Userspace interface for /dev/mshv
+ * Microsoft Hypervisor root partition APIs
+ * NOTE: This API is not yet stable!
+ */
+
+#include <linux/types.h>
+
+#define MSHV_CAP_CORE_API_STABLE    0x0
+
+#define MSHV_IOCTL 0xB8
+
+/* mshv device */
+#define MSHV_CHECK_EXTENSION    _IOW(MSHV_IOCTL, 0x00, __u32)
+
+#endif
-- 
2.25.1

