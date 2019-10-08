Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A39CFB19
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfJHNP0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 09:15:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfJHNPZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 09:15:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so3097952wmc.2;
        Tue, 08 Oct 2019 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkpF12I5oQshYFWC4o9XSkqiU1qpyK9lT1SgMd5gkK4=;
        b=Y1k4Wk9UX+Y9FRbroM6LtBWf93FOcq6kDKkBB2zP1Ah52Lg0AHcaF4VIzXzWoYT7IC
         +P30xMZV7MRbPmGKDLslptAl/YYVdrEXIIwiabicfU6Dq/MnLygAfMF48ESEZe/Ztroq
         bjzhD+XQWcWcGRoQlhFsN66f2DQ02LLmGTH2AAE03JY1yx37ncmZNo7l2agzMoZLr5Ia
         deKG5kKYS0LjvEqfK1E1ArC5is/MR6M/j3DDhA0HcZknap4HfREj72uHvE4CR2oWW6py
         DVBNk6GZkwM8t4oJ4KbsGPjeF1Dd34gcpuUxR6WBd5MVY7klDfN9Fk5jfnDBK3JwJvmy
         AUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PkpF12I5oQshYFWC4o9XSkqiU1qpyK9lT1SgMd5gkK4=;
        b=DL845Di1RHEnn0pUwZFMRVSP6HejnEECmwb5rAZeNDByaKF/qI4byHOi4DNOplgqpw
         125dKA+tvNCQgHdzhZTk0zsgMJ32n1uDA0QVtGFyzfB8Z2IpOIeItagZbg/6anbfDwZv
         zyYFtPzK+CT7Feff1ugGXs7/R0Dhwf7jkhaTQiREzqs5ECxVOXXi+ydX4Pph9MqFzPQp
         TQWC9r9G7wbsex0vyLWD9JwUA1jK3UajV3mQgGlHXh3SEoEt7iaJZRaJx+Ilrc/OiaZv
         poSwUM7keKqADhvpHEDejesQ0tv7Z2nkLE7hFmjATHz893sDvbzvN9CuhNS3TEIAYtzr
         SgrQ==
X-Gm-Message-State: APjAAAVu0XPKl2wV51xycHfeBukNRfljANMrpuqqjZ2JpGehyOjObpls
        jKBdG8QX7nc0ruXQ+sTOVwCTeWIR
X-Google-Smtp-Source: APXvYqxi2eXP5iDv1oV+9RJSekAwMNi7Dl5XfE0GwzX7za55ZRZfFZHCKBd3pI2e5P/gIz2GO+HO4A==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr3709880wmh.54.1570540523490;
        Tue, 08 Oct 2019 06:15:23 -0700 (PDT)
Received: from debian.mshome.net (207.148.159.143.dyn.plus.net. [143.159.148.207])
        by smtp.gmail.com with ESMTPSA id 79sm5485377wmb.7.2019.10.08.06.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:15:22 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
X-Google-Original-From: Wei Liu <liuw@liuw.name>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux Kconfig List <linux-kbuild@vger.kernel.org>,
        Wei Liu <liuwe@microsoft.com>
Subject: [PATCH RFC] kconfig: add hvconfig for Linux on Hyper-V
Date:   Tue,  8 Oct 2019 14:15:08 +0100
Message-Id: <20191008131508.21189-1-liuw@liuw.name>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <liuwe@microsoft.com>

Add an config file snippet which enalbes additional options useful for
running the kernel in a Hyper-V guest.

The expected use case is a user provides an existing config file then
executes `make hvconfig`. It will merge those options with the
provided config file.

Based on similar concept for Xen and KVM.

Signed-off-by: Wei Liu <liuwe@microsoft.com>
---
RFC: I only tested this on x86.  Although the config options included in
hv_guest.config don't seem to be arch-specific, we should probably
move the ones not yet implemented on Arm to an x86 specific config
file.
---
 Documentation/admin-guide/README.rst |  3 +++
 kernel/configs/hv_guest.config       | 33 ++++++++++++++++++++++++++++
 scripts/kconfig/Makefile             |  5 +++++
 3 files changed, 41 insertions(+)
 create mode 100644 kernel/configs/hv_guest.config

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index cc6151fc0845..d5f4389a7a2f 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -224,6 +224,9 @@ Configuring the kernel
      "make xenconfig"   Enable additional options for xen dom0 guest kernel
                         support.
 
+     "make hvconfig"    Enable additional options for Hyper-V guest kernel
+                        support.
+
      "make tinyconfig"  Configure the tiniest possible kernel.
 
    You can find more information on using the Linux kernel config tools
diff --git a/kernel/configs/hv_guest.config b/kernel/configs/hv_guest.config
new file mode 100644
index 000000000000..0e71e34a2d4d
--- /dev/null
+++ b/kernel/configs/hv_guest.config
@@ -0,0 +1,33 @@
+CONFIG_NET=y
+CONFIG_NET_CORE=y
+CONFIG_NETDEVICES=y
+CONFIG_BLOCK=y
+CONFIG_BLK_DEV=y
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_INET=y
+CONFIG_TTY=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_BINFMT_ELF=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_VIRTUALIZATION=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_HYPERV=y
+CONFIG_HYPERV_VSOCKETS=y
+CONFIG_PCI_HYPERV=y
+CONFIG_PCI_HYPERV_INTERFACE=y
+CONFIG_HYPERV_STORAGE=y
+CONFIG_HYPERV_NET=y
+CONFIG_HYPERV_KEYBOARD=y
+CONFIG_FB_HYPERV=y
+CONFIG_HID_HYPERV_MOUSE=y
+CONFIG_HYPERV=y
+CONFIG_HYPERV_TIMER=y
+CONFIG_HYPERV_UTILS=y
+CONFIG_HYPERV_BALLOON=y
+CONFIG_HYPERV_IOMMU=y
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ef2f2336c469..2ee46301b22e 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -104,6 +104,10 @@ PHONY += xenconfig
 xenconfig: xen.config
 	@:
 
+PHONY += hvconfig
+hvconfig: hv_guest.config
+	@:
+
 PHONY += tinyconfig
 tinyconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile allnoconfig tiny.config
@@ -138,6 +142,7 @@ help:
 	@echo  '                    default value without prompting'
 	@echo  '  kvmconfig	  - Enable additional options for kvm guest kernel support'
 	@echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
+	@echo  '  hvconfig        - Enable additional options for Hyper-V guest kernel support'
 	@echo  '  tinyconfig	  - Configure the tiniest possible kernel'
 	@echo  '  testconfig	  - Run Kconfig unit tests (requires python3 and pytest)'
 
-- 
2.20.1

