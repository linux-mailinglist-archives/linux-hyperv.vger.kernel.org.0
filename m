Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4E12BBAE0
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Nov 2020 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgKUAaw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Nov 2020 19:30:52 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51186 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgKUAav (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Nov 2020 19:30:51 -0500
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 988A620B71D2;
        Fri, 20 Nov 2020 16:30:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 988A620B71D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605918649;
        bh=AMCVyNM/KQMdcwb7yqpx4jg4oyDZyHKU8w+wvG6tLp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLm3bJ2XtR2DjfXPWMTOC2WS19idt8F8b791ILPt7MUASV0C3AoqmnJhfzliLyWQ/
         u+nV2iGn+h4S25WrF+hFiRw+mCIxdCqyiLfoVpxNjIayVpb8HPBmWn9dPek9yjvMT+
         JE1qw5rbzGb433Pr3PpdqP1UYjKLVP+GwupF/URg=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH 04/18] virt/mshv: request version ioctl
Date:   Fri, 20 Nov 2020 16:30:23 -0800
Message-Id: <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Reserve ioctl number in userpsace-api/ioctl/ioctl-number.rst
Introduce MSHV_REQUEST_VERSION ioctl.
Introduce documentation for /dev/mshv in Documentation/virt/mshv

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  2 +
 Documentation/virt/mshv/api.rst               | 62 +++++++++++++++++++
 include/linux/mshv.h                          | 11 ++++
 include/uapi/linux/mshv.h                     | 19 ++++++
 virt/mshv/mshv_main.c                         | 49 +++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 Documentation/virt/mshv/api.rst
 create mode 100644 include/linux/mshv.h
 create mode 100644 include/uapi/linux/mshv.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 55a2d9b2ce33..13a4d3ecafca 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -343,6 +343,8 @@ Code  Seq#    Include File                                           Comments
 0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
 0xB6  all    linux/fpga-dfl.h
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
+0xB8  all    uapi/linux/mshv.h                                       Microsoft Hypervisor root partition APIs
+                                                                     <mailto:linux-hyperv@vger.kernel.org>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/api.rst
new file mode 100644
index 000000000000..82e32de48d03
--- /dev/null
+++ b/Documentation/virt/mshv/api.rst
@@ -0,0 +1,62 @@
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
+This API is not yet stable.
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
+3.1 MSHV_REQUEST_VERSION
+------------------------
+:Type: /dev/mshv ioctl
+:Parameters: pointer to a u32
+:Returns: 0 on success
+
+Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be called to
+establish the interface version with the kernel module.
+
+The caller should pass the MSHV_VERSION as an argument.
+
+The kernel module will check which interface versions it supports and return 0
+if one of them matches.
+
+This /dev/mshv file descriptor will remain 'locked' to that version as long as
+it is open - this ioctl can only be called once per open.
+
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
index 000000000000..dd30fc2f0a80
--- /dev/null
+++ b/include/uapi/linux/mshv.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_MSHV_H
+#define _UAPI_LINUX_MSHV_H
+
+/*
+ * Userspace interface for /dev/mshv
+ * Microsoft Hypervisor root partition APIs
+ */
+
+#include <linux/types.h>
+
+#define MSHV_VERSION	0x0
+
+#define MSHV_IOCTL 0xB8
+
+/* mshv device */
+#define MSHV_REQUEST_VERSION	_IOW(MSHV_IOCTL, 0x00, __u32)
+
+#endif
diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
index ecb9089761fe..62f631f85301 100644
--- a/virt/mshv/mshv_main.c
+++ b/virt/mshv/mshv_main.c
@@ -11,25 +11,74 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/mshv.h>
 
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
 
+#define MSHV_INVALID_VERSION	0xFFFFFFFF
+#define MSHV_CURRENT_VERSION	MSHV_VERSION
+
+static u32 supported_versions[] = {
+	MSHV_CURRENT_VERSION,
+};
+
+static long
+mshv_ioctl_request_version(u32 *version, void __user *user_arg)
+{
+	u32 arg;
+	int i;
+
+	if (copy_from_user(&arg, user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	for (i = 0; i < ARRAY_SIZE(supported_versions); ++i) {
+		if (supported_versions[i] == arg) {
+			*version = supported_versions[i];
+			return 0;
+		}
+	}
+	return -ENOTSUPP;
+}
+
 static long
 mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
+	u32 *version = (u32 *)filp->private_data;
+
+	if (ioctl == MSHV_REQUEST_VERSION) {
+		/* Version can only be set once */
+		if (*version != MSHV_INVALID_VERSION)
+			return -EBADFD;
+
+		return mshv_ioctl_request_version(version, (void __user *)arg);
+	}
+
+	/* Version must be set before other ioctls can be called */
+	if (*version == MSHV_INVALID_VERSION)
+		return -EBADFD;
+
+	/* TODO other ioctls */
+
 	return -ENOTTY;
 }
 
 static int
 mshv_dev_open(struct inode *inode, struct file *filp)
 {
+	filp->private_data = kmalloc(sizeof(u32), GFP_KERNEL);
+	if (!filp->private_data)
+		return -ENOMEM;
+	*(u32 *)filp->private_data = MSHV_INVALID_VERSION;
+
 	return 0;
 }
 
 static int
 mshv_dev_release(struct inode *inode, struct file *filp)
 {
+	kfree(filp->private_data);
 	return 0;
 }
 
-- 
2.25.1

