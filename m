Return-Path: <linux-hyperv+bounces-9573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C7GErxbvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9573-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E42D20DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F839305C8EA
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601443F7E80;
	Thu, 19 Mar 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTF/lU3+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5B3D47BD
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951918; cv=none; b=P0Tvlyt0UPQVI1AviYKBL/mBi4jG9B/drUK6xjUbcmdUblT30rjq7jGMVNgw2yswxFSOjIXBZzCyMrT5vUGjliUH5ChHWx1PXR2sXCedyCTkGXb9GI63X22UhlFjvVaSBmAYEBZyw5eROUxT+hm+IL5v6B58Sgu4zUUg+njvie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951918; c=relaxed/simple;
	bh=guTsrnrhj+z/8raDwwr03ZX487NMzNKDJOkO2xeLXtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X780SMXydDoXg5pRHDQIchEBE6IRZfj3qn+wl0AspA20KIpKtbP7vV4jDM/XxlaiObOQyDhjb7doyWi1pXxzfGPCoyefEitrLN3extzjabD0qDsCPbUP9lFhlNOb9mUayXhXmuP9UZSqVULG1wlyWGh60Ap/u+In8LCbyhHqSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTF/lU3+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so14217365e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951914; x=1774556714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgaBnxVGpKVzavghfacsVWKIZiZMLKpPl85sTCUs9Bw=;
        b=PTF/lU3+3Cv62gG+dRyooy+sdhCLzyfs3jTHysUIAfekwD6/6HFOyWdXXF3VQqn361
         BkTYJyR8gRN0Q5zl9QItJ2jKVur6VybBS/v1lz4oup0qqyFGvHeQ1pkEM+zWDevos31C
         lxsFh8j+KTFVElvRu1MMbJ+numFW27eWN76YaVJqh5YlmVQDLc7bQMDeTfXD4PWthUe9
         zYp7Ucq8o+hv09073Gn5b4+tLMHuUBIqi2HSJ3uHxI9pAm/M2y5LxShI0HVmCUl8g47+
         /lt4oQ1W6d5QUI2bXzguE4ignzyNu7nIzYDZ5PdDYGeYORapdedEHnQ0RrCtiB0dUuwi
         Knwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951914; x=1774556714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FgaBnxVGpKVzavghfacsVWKIZiZMLKpPl85sTCUs9Bw=;
        b=eVSWqI+ISGbmgDfndDicxWatTsxjnMs75dCNWVE7aVpnYUwC4n1/DWS3aFxD+XZ9Oo
         ioZ6VsfRpFhib9N2iv/F8njDWBLY8WBjWCoZF52fRe3CtpwVwFlkusQ6moUkyJ7KyBWN
         RCBghT1PFTWjyYbvRt5oHGa06AHd4ubVBrQTtQdMDV2jS/1xntkKbg2XQxNhFAZbAfuX
         mUrr7RS6bWmvFnMWpX7Uzc2lQwFdu5OLLKwiH0qT/CuBNttEMHytjV1HL+tIeaoWACUk
         CLbFis4zMv7Fi0gPc9aUpT7FuDPgl5EyL2zgXv0qyTGojBAXz18jOIVwsIdSQjsrxrnu
         6ktQ==
X-Gm-Message-State: AOJu0YxuQf6Y2au7+PVfvqMSX4vcNuQQagEei6ndaloU/mRY4Nu4enZg
	6F6rfNiCi9eNFbdArUh5qDEEh1KCfnSGCB2l7csBSFfVwBBrDNVhpcIF6XYozPFvaZs=
X-Gm-Gg: ATEYQzwWgVzGYjKA6PyHr+FwpMk4qwJVNTxRUj4o+bQc6ffFbBob5JoPOK7ltcAtaCp
	SJCDI9PrILEU4BENnXYSkriv7RLFRj3Tq+6AGAOVCEmNQspmXSWk16rH4oT9oQs5nMG8OqKEFe6
	V90qiNyQDPoF8Zcr86WQqG1gAE8ufqMUcpRdFaXXfjmmEugZAqcQ0JRYyJBziY8diCgKFSVuwyH
	w+LCLv6bb8BQtNv0LtQpdgwF5/YlumzoMRFGI/SzSycoK+a/H35HCzbfxUw2P5ipVD5fVbPnmHx
	yRe2HAUXvKqKtd5R9v/j5MoP5Qq6kUX0PESuJhpM3Mrz0+dUSMH3Bjn989m8GrFwRnUIFLcRZBT
	ogdxH/VnBPHevYf3aqBYqDkBC3ALFsfTSjzuS9Zmc4YxYgwdjOKGpLsrvcnK8ZnINgJlXIGsEr1
	kQx0OLrhwKZ4C1a3IYdE/v8kz2IA3VkyeuW84HheHZW1av/ttR
X-Received: by 2002:a05:600c:828d:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-486ff0291ccmr7166145e9.16.1773951913713;
        Thu, 19 Mar 2026 13:25:13 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:13 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 01/55] drivers: hv: dxgkrnl: Driver initialization and loading
Date: Thu, 19 Mar 2026 20:24:15 +0000
Message-ID: <20260319202509.63802-2-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9573-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.937];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B90E42D20DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

- Create skeleton and add basic functionality for the Hyper-V
compute device driver (dxgkrnl).

- Register for PCI and VMBus driver notifications and handle
initialization of VMBus channels.

- Connect the dxgkrnl module to the drivers/hv/ Makefile and Kconfig

- Create a MAINTAINERS entry

A VMBus channel is a communication interface between the Hyper-V guest
and the host. The are two type of VMBus channels, used in the driver:
  - the global channel
  - per virtual compute device channel

A PCI device is created for each virtual compute device, projected
by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
arrival of such devices. The PCI config space of the virtual compute
device has luid of the corresponding virtual compute device VM
bus channel. This is how the compute device adapter objects are
linked to VMBus channels.

VMBus interface version is exchanged by reading/writing the PCI config
space of the virtual compute device.

The IO space is used to handle CPU accessible compute device
allocations. Hyper-V allocates IO space for the global VMBus channel.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 MAINTAINERS                    |   7 +
 drivers/hv/Kconfig             |   2 +
 drivers/hv/Makefile            |   1 +
 drivers/hv/dxgkrnl/Kconfig     |  26 ++
 drivers/hv/dxgkrnl/Makefile    |   5 +
 drivers/hv/dxgkrnl/dxgkrnl.h   | 155 ++++++++++
 drivers/hv/dxgkrnl/dxgmodule.c | 506 +++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.c  |  92 ++++++
 drivers/hv/dxgkrnl/dxgvmbus.h  |  19 ++
 include/uapi/misc/d3dkmthk.h   |  27 ++
 10 files changed, 840 insertions(+)
 create mode 100644 drivers/hv/dxgkrnl/Kconfig
 create mode 100644 drivers/hv/dxgkrnl/Makefile
 create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
 create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
 create mode 100644 include/uapi/misc/d3dkmthk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ae4c0cec5073..4fe0b3501931 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9771,6 +9771,13 @@ F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
+Hyper-V vGPU DRIVER
+M:	Iouri Tarassov <iourit@microsoft.com>
+L:	linux-hyperv@vger.kernel.org
+S:	Supported
+F:	drivers/hv/dxgkrnl/
+F:	include/uapi/misc/d3dkmthk.h
+
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 862c47b191af..b16c7701da19 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -55,4 +55,6 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+source "drivers/hv/dxgkrnl/Kconfig"
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index d76df5c8c2a9..aa1cbdb5d0d2 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_DXGKRNL)		+= dxgkrnl/
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
diff --git a/drivers/hv/dxgkrnl/Kconfig b/drivers/hv/dxgkrnl/Kconfig
new file mode 100644
index 000000000000..bcd92bbff939
--- /dev/null
+++ b/drivers/hv/dxgkrnl/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+# Configuration for the hyper-v virtual compute driver (dxgkrnl)
+#
+
+config DXGKRNL
+	tristate "Microsoft Paravirtualized GPU support"
+	depends on HYPERV
+	depends on 64BIT || COMPILE_TEST
+	help
+	  This driver supports paravirtualized virtual compute devices, exposed
+	  by Microsoft Hyper-V when Linux is running inside of a virtual machine
+	  hosted by Windows. The virtual machines needs to be configured to use
+	  host compute adapters. The driver name is dxgkrnl.
+
+	  An example of such virtual machine is a  Windows Subsystem for
+	  Linux container. When such container is instantiated, the Windows host
+	  assigns compatible host GPU adapters to the container. The corresponding
+	  virtual GPU devices appear on the PCI bus in the container. These
+	  devices are enumerated and accessed by this driver.
+
+	  Communications with the driver are done by using the Microsoft libdxcore
+	  library, which translates the D3DKMT interface
+	  <https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/>
+	  to the driver IOCTLs. The virtual GPU devices are paravirtualized,
+	  which means that access to the hardware is done in the host. The driver
+	  communicates with the host using Hyper-V VM bus communication channels.
diff --git a/drivers/hv/dxgkrnl/Makefile b/drivers/hv/dxgkrnl/Makefile
new file mode 100644
index 000000000000..76349064b60a
--- /dev/null
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for the hyper-v compute device driver (dxgkrnl).
+
+obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
+dxgkrnl-y		:= dxgmodule.o dxgvmbus.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
new file mode 100644
index 000000000000..f7900840d1ed
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Headers for internal objects
+ *
+ */
+
+#ifndef _DXGKRNL_H
+#define _DXGKRNL_H
+
+#include <linux/uuid.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/refcount.h>
+#include <linux/rwsem.h>
+#include <linux/atomic.h>
+#include <linux/spinlock.h>
+#include <linux/gfp.h>
+#include <linux/miscdevice.h>
+#include <linux/pci.h>
+#include <linux/hyperv.h>
+#include <uapi/misc/d3dkmthk.h>
+#include <linux/version.h>
+
+struct dxgadapter;
+
+/*
+ * Driver private data.
+ * A single /dev/dxg device is created per virtual machine.
+ */
+struct dxgdriver{
+	struct dxgglobal	*dxgglobal;
+	struct device 		*dxgdev;
+	struct pci_driver 	pci_drv;
+	struct hv_driver	vmbus_drv;
+};
+extern struct dxgdriver dxgdrv;
+
+#define DXGDEV dxgdrv.dxgdev
+
+struct dxgvmbuschannel {
+	struct vmbus_channel	*channel;
+	struct hv_device	*hdev;
+	spinlock_t		packet_list_mutex;
+	struct list_head	packet_list_head;
+	struct kmem_cache	*packet_cache;
+	atomic64_t		packet_request_id;
+};
+
+int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev);
+void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch);
+void dxgvmbuschannel_receive(void *ctx);
+
+/*
+ * The structure defines an offered vGPU vm bus channel.
+ */
+struct dxgvgpuchannel {
+	struct list_head	vgpu_ch_list_entry;
+	struct winluid		adapter_luid;
+	struct hv_device	*hdev;
+};
+
+struct dxgglobal {
+	struct dxgdriver	*drvdata;
+	struct dxgvmbuschannel	channel;
+	struct hv_device	*hdev;
+	u32			num_adapters;
+	u32			vmbus_ver;	/* Interface version */
+	struct resource		*mem;
+	u64			mmiospace_base;
+	u64			mmiospace_size;
+	struct miscdevice	dxgdevice;
+	struct mutex		device_mutex;
+
+	/*
+	 * List of the vGPU VM bus channels (dxgvgpuchannel)
+	 * Protected by device_mutex
+	 */
+	struct list_head	vgpu_ch_list_head;
+
+	/* protects acces to the global VM bus channel */
+	struct rw_semaphore	channel_lock;
+
+	bool			global_channel_initialized;
+	bool			async_msg_enabled;
+	bool			misc_registered;
+	bool			pci_registered;
+	bool			vmbus_registered;
+};
+
+static inline struct dxgglobal *dxggbl(void)
+{
+	return dxgdrv.dxgglobal;
+}
+
+struct dxgprocess {
+	/* Placeholder */
+};
+
+/*
+ * The convention is that VNBus instance id is a GUID, but the host sets
+ * the lower part of the value to the host adapter LUID. The function
+ * provides the necessary conversion.
+ */
+static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
+{
+	*luid = *(struct winluid *)&guid->b[0];
+}
+
+/*
+ * VM bus interface
+ *
+ */
+
+/*
+ * The interface version is used to ensure that the host and the guest use the
+ * same VM bus protocol. It needs to be incremented every time the VM bus
+ * interface changes. DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION is
+ * incremented each time the earlier versions of the interface are no longer
+ * compatible with the current version.
+ */
+#define DXGK_VMBUS_INTERFACE_VERSION_OLD		27
+#define DXGK_VMBUS_INTERFACE_VERSION			40
+#define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
+
+#ifdef DEBUG
+
+void dxgk_validate_ioctls(void);
+
+#define DXG_TRACE(fmt, ...)  do {			\
+	trace_printk(dev_fmt(fmt) "\n", ##__VA_ARGS__);	\
+}  while (0)
+
+#define DXG_ERR(fmt, ...) do {				\
+	dev_err(DXGDEV, fmt, ##__VA_ARGS__);		\
+	trace_printk("*** dxgkerror *** " dev_fmt(fmt) "\n", ##__VA_ARGS__);	\
+} while (0)
+
+#else
+
+#define DXG_TRACE(...)
+#define DXG_ERR(fmt, ...) do {			\
+	dev_err(DXGDEV, fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#endif /* DEBUG */
+
+#endif
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
new file mode 100644
index 000000000000..de02edc4d023
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Interface with Linux kernel, PCI driver and the VM bus driver
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/eventfd.h>
+#include <linux/hyperv.h>
+#include <linux/pci.h>
+#include "dxgkrnl.h"
+
+#define PCI_VENDOR_ID_MICROSOFT		0x1414
+#define PCI_DEVICE_ID_VIRTUAL_RENDER	0x008E
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+/*
+ * Interface from dxgglobal
+ */
+
+struct vmbus_channel *dxgglobal_get_vmbus(void)
+{
+	return dxggbl()->channel.channel;
+}
+
+struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void)
+{
+	return &dxggbl()->channel;
+}
+
+int dxgglobal_acquire_channel_lock(void)
+{
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	down_read(&dxgglobal->channel_lock);
+	if (dxgglobal->channel.channel == NULL) {
+		DXG_ERR("Failed to acquire global channel lock");
+		return -ENODEV;
+	} else {
+		return 0;
+	}
+}
+
+void dxgglobal_release_channel_lock(void)
+{
+	up_read(&dxggbl()->channel_lock);
+}
+
+const struct file_operations dxgk_fops = {
+	.owner = THIS_MODULE,
+};
+
+/*
+ * Interface with the PCI driver
+ */
+
+/*
+ * Part of the PCI config space of the compute device is used for
+ * configuration data. Reading/writing of the PCI config space is forwarded
+ * to the host.
+ *
+ * Below are offsets in the PCI config spaces for various configuration values.
+ */
+
+/* Compute device VM bus channel instance ID */
+#define DXGK_VMBUS_CHANNEL_ID_OFFSET	192
+
+/* DXGK_VMBUS_INTERFACE_VERSION (u32) */
+#define DXGK_VMBUS_VERSION_OFFSET	(DXGK_VMBUS_CHANNEL_ID_OFFSET + \
+					sizeof(guid_t))
+
+/* Luid of the virtual GPU on the host (struct winluid) */
+#define DXGK_VMBUS_VGPU_LUID_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
+					sizeof(u32))
+
+/* The guest writes its capabilities to this address */
+#define DXGK_VMBUS_GUESTCAPS_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
+					sizeof(u32))
+
+/* Capabilities of the guest driver, reported to the host */
+struct dxgk_vmbus_guestcaps {
+	union {
+		struct {
+			u32	wsl2		: 1;
+			u32	reserved	: 31;
+		};
+		u32 guest_caps;
+	};
+};
+
+/*
+ * A helper function to read PCI config space.
+ */
+static int dxg_pci_read_dwords(struct pci_dev *dev, int offset, int size,
+			       void *val)
+{
+	int off = offset;
+	int ret;
+	int i;
+
+	/* Make sure the offset and size are 32 bit aligned */
+	if (offset & 3 || size & 3)
+		return -EINVAL;
+
+	for (i = 0; i < size / sizeof(int); i++) {
+		ret = pci_read_config_dword(dev, off, &((int *)val)[i]);
+		if (ret) {
+			DXG_ERR("Failed to read PCI config: %d", off);
+			return ret;
+		}
+		off += sizeof(int);
+	}
+	return 0;
+}
+
+static int dxg_pci_probe_device(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	int ret;
+	guid_t guid;
+	u32 vmbus_interface_ver = DXGK_VMBUS_INTERFACE_VERSION;
+	struct winluid vgpu_luid = {};
+	struct dxgk_vmbus_guestcaps guest_caps = {.wsl2 = 1};
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (dxgglobal->vmbus_ver == 0)  {
+		/* Report capabilities to the host */
+
+		ret = pci_write_config_dword(dev, DXGK_VMBUS_GUESTCAPS_OFFSET,
+					guest_caps.guest_caps);
+		if (ret)
+			goto cleanup;
+
+		/* Negotiate the VM bus version */
+
+		ret = pci_read_config_dword(dev, DXGK_VMBUS_VERSION_OFFSET,
+					&vmbus_interface_ver);
+		if (ret == 0 && vmbus_interface_ver != 0)
+			dxgglobal->vmbus_ver = vmbus_interface_ver;
+		else
+			dxgglobal->vmbus_ver = DXGK_VMBUS_INTERFACE_VERSION_OLD;
+
+		if (dxgglobal->vmbus_ver < DXGK_VMBUS_INTERFACE_VERSION)
+			goto read_channel_id;
+
+		ret = pci_write_config_dword(dev, DXGK_VMBUS_VERSION_OFFSET,
+					DXGK_VMBUS_INTERFACE_VERSION);
+		if (ret)
+			goto cleanup;
+
+		if (dxgglobal->vmbus_ver > DXGK_VMBUS_INTERFACE_VERSION)
+			dxgglobal->vmbus_ver = DXGK_VMBUS_INTERFACE_VERSION;
+	}
+
+read_channel_id:
+
+	/* Get the VM bus channel ID for the virtual GPU */
+	ret = dxg_pci_read_dwords(dev, DXGK_VMBUS_CHANNEL_ID_OFFSET,
+				sizeof(guid), (int *)&guid);
+	if (ret)
+		goto cleanup;
+
+	if (dxgglobal->vmbus_ver >= DXGK_VMBUS_INTERFACE_VERSION) {
+		ret = dxg_pci_read_dwords(dev, DXGK_VMBUS_VGPU_LUID_OFFSET,
+					  sizeof(vgpu_luid), &vgpu_luid);
+		if (ret)
+			goto cleanup;
+	}
+
+	DXG_TRACE("Adapter channel: %pUb", &guid);
+	DXG_TRACE("Vmbus interface version: %d", dxgglobal->vmbus_ver);
+	DXG_TRACE("Host luid: %x-%x", vgpu_luid.b, vgpu_luid.a);
+
+cleanup:
+
+	mutex_unlock(&dxgglobal->device_mutex);
+
+	if (ret)
+		DXG_TRACE("err: %d",  ret);
+	return ret;
+}
+
+static void dxg_pci_remove_device(struct pci_dev *dev)
+{
+	/* Placeholder */
+}
+
+static struct pci_device_id dxg_pci_id_table[] = {
+	{
+		.vendor = PCI_VENDOR_ID_MICROSOFT,
+		.device = PCI_DEVICE_ID_VIRTUAL_RENDER,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID
+	},
+	{ 0 }
+};
+
+/*
+ * Interface with the VM bus driver
+ */
+
+static int dxgglobal_getiospace(struct dxgglobal *dxgglobal)
+{
+	/* Get mmio space for the global channel */
+	struct hv_device *hdev = dxgglobal->hdev;
+	struct vmbus_channel *channel = hdev->channel;
+	resource_size_t pot_start = 0;
+	resource_size_t pot_end = -1;
+	int ret;
+
+	dxgglobal->mmiospace_size = channel->offermsg.offer.mmio_megabytes;
+	if (dxgglobal->mmiospace_size == 0) {
+		DXG_TRACE("Zero mmio space is offered");
+		return -ENOMEM;
+	}
+	dxgglobal->mmiospace_size <<= 20;
+	DXG_TRACE("mmio offered: %llx", dxgglobal->mmiospace_size);
+
+	ret = vmbus_allocate_mmio(&dxgglobal->mem, hdev, pot_start, pot_end,
+				  dxgglobal->mmiospace_size, 0x10000, false);
+	if (ret) {
+		DXG_ERR("Unable to allocate mmio memory: %d", ret);
+		return ret;
+	}
+	dxgglobal->mmiospace_size = dxgglobal->mem->end -
+	    dxgglobal->mem->start + 1;
+	dxgglobal->mmiospace_base = dxgglobal->mem->start;
+	DXG_TRACE("mmio allocated %llx  %llx %llx %llx",
+		 dxgglobal->mmiospace_base, dxgglobal->mmiospace_size,
+		 dxgglobal->mem->start, dxgglobal->mem->end);
+
+	return 0;
+}
+
+int dxgglobal_init_global_channel(void)
+{
+	int ret = 0;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = dxgvmbuschannel_init(&dxgglobal->channel, dxgglobal->hdev);
+	if (ret) {
+		DXG_ERR("dxgvmbuschannel_init failed: %d", ret);
+		goto error;
+	}
+
+	ret = dxgglobal_getiospace(dxgglobal);
+	if (ret) {
+		DXG_ERR("getiospace failed: %d", ret);
+		goto error;
+	}
+
+	hv_set_drvdata(dxgglobal->hdev, dxgglobal);
+
+error:
+	return ret;
+}
+
+void dxgglobal_destroy_global_channel(void)
+{
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	down_write(&dxgglobal->channel_lock);
+
+	dxgglobal->global_channel_initialized = false;
+
+	if (dxgglobal->mem) {
+		vmbus_free_mmio(dxgglobal->mmiospace_base,
+				dxgglobal->mmiospace_size);
+		dxgglobal->mem = NULL;
+	}
+
+	dxgvmbuschannel_destroy(&dxgglobal->channel);
+
+	if (dxgglobal->hdev) {
+		hv_set_drvdata(dxgglobal->hdev, NULL);
+		dxgglobal->hdev = NULL;
+	}
+
+	up_write(&dxgglobal->channel_lock);
+}
+
+static const struct hv_vmbus_device_id dxg_vmbus_id_table[] = {
+	/* Per GPU Device GUID */
+	{ HV_GPUP_DXGK_VGPU_GUID },
+	/* Global Dxgkgnl channel for the virtual machine */
+	{ HV_GPUP_DXGK_GLOBAL_GUID },
+	{ }
+};
+
+static int dxg_probe_vmbus(struct hv_device *hdev,
+			   const struct hv_vmbus_device_id *dev_id)
+{
+	int ret = 0;
+	struct winluid luid;
+	struct dxgvgpuchannel *vgpuch;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (uuid_le_cmp(hdev->dev_type, dxg_vmbus_id_table[0].guid) == 0) {
+		/* This is a new virtual GPU channel */
+		guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
+		DXG_TRACE("vGPU channel: %pUb",
+			 &hdev->channel->offermsg.offer.if_instance);
+		vgpuch = kzalloc(sizeof(struct dxgvgpuchannel), GFP_KERNEL);
+		if (vgpuch == NULL) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		vgpuch->adapter_luid = luid;
+		vgpuch->hdev = hdev;
+		list_add_tail(&vgpuch->vgpu_ch_list_entry,
+			      &dxgglobal->vgpu_ch_list_head);
+	} else if (uuid_le_cmp(hdev->dev_type,
+		   dxg_vmbus_id_table[1].guid) == 0) {
+		/* This is the global Dxgkgnl channel */
+		DXG_TRACE("Global channel: %pUb",
+			 &hdev->channel->offermsg.offer.if_instance);
+		if (dxgglobal->hdev) {
+			/* This device should appear only once */
+			DXG_ERR("global channel already exists");
+			ret = -EBADE;
+			goto error;
+		}
+		dxgglobal->hdev = hdev;
+	} else {
+		/* Unknown device type */
+		DXG_ERR("Unknown VM bus device type");
+		ret = -ENODEV;
+	}
+
+error:
+
+	mutex_unlock(&dxgglobal->device_mutex);
+
+	return ret;
+}
+
+static int dxg_remove_vmbus(struct hv_device *hdev)
+{
+	int ret = 0;
+	struct dxgvgpuchannel *vgpu_channel;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (uuid_le_cmp(hdev->dev_type, dxg_vmbus_id_table[0].guid) == 0) {
+		DXG_TRACE("Remove virtual GPU channel");
+		list_for_each_entry(vgpu_channel,
+				    &dxgglobal->vgpu_ch_list_head,
+				    vgpu_ch_list_entry) {
+			if (vgpu_channel->hdev == hdev) {
+				list_del(&vgpu_channel->vgpu_ch_list_entry);
+				kfree(vgpu_channel);
+				break;
+			}
+		}
+	} else if (uuid_le_cmp(hdev->dev_type,
+		   dxg_vmbus_id_table[1].guid) == 0) {
+		DXG_TRACE("Remove global channel device");
+		dxgglobal_destroy_global_channel();
+	} else {
+		/* Unknown device type */
+		DXG_ERR("Unknown device type");
+		ret = -ENODEV;
+	}
+
+	mutex_unlock(&dxgglobal->device_mutex);
+
+	return ret;
+}
+
+MODULE_DEVICE_TABLE(vmbus, dxg_vmbus_id_table);
+MODULE_DEVICE_TABLE(pci, dxg_pci_id_table);
+
+/*
+ * Global driver data
+ */
+
+struct dxgdriver dxgdrv = {
+	.vmbus_drv.name = KBUILD_MODNAME,
+	.vmbus_drv.id_table = dxg_vmbus_id_table,
+	.vmbus_drv.probe = dxg_probe_vmbus,
+	.vmbus_drv.remove = dxg_remove_vmbus,
+	.vmbus_drv.driver = {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.pci_drv.name = KBUILD_MODNAME,
+	.pci_drv.id_table = dxg_pci_id_table,
+	.pci_drv.probe = dxg_pci_probe_device,
+	.pci_drv.remove = dxg_pci_remove_device
+};
+
+static struct dxgglobal *dxgglobal_create(void)
+{
+	struct dxgglobal *dxgglobal;
+
+	dxgglobal = kzalloc(sizeof(struct dxgglobal), GFP_KERNEL);
+	if (!dxgglobal)
+		return NULL;
+
+	mutex_init(&dxgglobal->device_mutex);
+
+	INIT_LIST_HEAD(&dxgglobal->vgpu_ch_list_head);
+
+	init_rwsem(&dxgglobal->channel_lock);
+
+	return dxgglobal;
+}
+
+static void dxgglobal_destroy(struct dxgglobal *dxgglobal)
+{
+	if (dxgglobal) {
+		mutex_lock(&dxgglobal->device_mutex);
+		dxgglobal_destroy_global_channel();
+		mutex_unlock(&dxgglobal->device_mutex);
+
+		if (dxgglobal->vmbus_registered)
+			vmbus_driver_unregister(&dxgdrv.vmbus_drv);
+
+		dxgglobal_destroy_global_channel();
+
+		if (dxgglobal->pci_registered)
+			pci_unregister_driver(&dxgdrv.pci_drv);
+
+		if (dxgglobal->misc_registered)
+			misc_deregister(&dxgglobal->dxgdevice);
+
+		dxgglobal->drvdata->dxgdev = NULL;
+
+		kfree(dxgglobal);
+		dxgglobal = NULL;
+	}
+}
+
+static int __init dxg_drv_init(void)
+{
+	int ret;
+	struct dxgglobal *dxgglobal = NULL;
+
+	dxgglobal = dxgglobal_create();
+	if (dxgglobal == NULL) {
+		pr_err("dxgglobal_init failed");
+		ret = -ENOMEM;
+		goto error;
+	}
+	dxgglobal->drvdata = &dxgdrv;
+
+	dxgglobal->dxgdevice.minor = MISC_DYNAMIC_MINOR;
+	dxgglobal->dxgdevice.name = "dxg";
+	dxgglobal->dxgdevice.fops = &dxgk_fops;
+	dxgglobal->dxgdevice.mode = 0666;
+	ret = misc_register(&dxgglobal->dxgdevice);
+	if (ret) {
+		pr_err("misc_register failed: %d", ret);
+		goto error;
+	}
+	dxgglobal->misc_registered = true;
+	dxgdrv.dxgdev = dxgglobal->dxgdevice.this_device;
+	dxgdrv.dxgglobal = dxgglobal;
+
+	ret = vmbus_driver_register(&dxgdrv.vmbus_drv);
+	if (ret) {
+		DXG_ERR("vmbus_driver_register failed: %d", ret);
+		goto error;
+	}
+	dxgglobal->vmbus_registered = true;
+
+	ret = pci_register_driver(&dxgdrv.pci_drv);
+	if (ret) {
+		DXG_ERR("pci_driver_register failed: %d", ret);
+		goto error;
+	}
+	dxgglobal->pci_registered = true;
+
+	return 0;
+
+error:
+	/* This function does the cleanup */
+	dxgglobal_destroy(dxgglobal);
+	dxgdrv.dxgglobal = NULL;
+
+	return ret;
+}
+
+static void __exit dxg_drv_exit(void)
+{
+	dxgglobal_destroy(dxgdrv.dxgglobal);
+}
+
+module_init(dxg_drv_init);
+module_exit(dxg_drv_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual compute device Driver");
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
new file mode 100644
index 000000000000..deb880e34377
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * VM bus interface implementation
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/eventfd.h>
+#include <linux/hyperv.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+#include <linux/pagemap.h>
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+#define RING_BUFSIZE (256 * 1024)
+
+/*
+ * The structure is used to track VM bus packets, waiting for completion.
+ */
+struct dxgvmbuspacket {
+	struct list_head packet_list_entry;
+	u64 request_id;
+	struct completion wait;
+	void *buffer;
+	u32 buffer_length;
+	int status;
+	bool completed;
+};
+
+int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev)
+{
+	int ret;
+
+	ch->hdev = hdev;
+	spin_lock_init(&ch->packet_list_mutex);
+	INIT_LIST_HEAD(&ch->packet_list_head);
+	atomic64_set(&ch->packet_request_id, 0);
+
+	ch->packet_cache = kmem_cache_create("DXGK packet cache",
+					     sizeof(struct dxgvmbuspacket), 0,
+					     0, NULL);
+	if (ch->packet_cache == NULL) {
+		DXG_ERR("packet_cache alloc failed");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,15,0)
+	hdev->channel->max_pkt_size = DXG_MAX_VM_BUS_PACKET_SIZE;
+#endif
+	ret = vmbus_open(hdev->channel, RING_BUFSIZE, RING_BUFSIZE,
+			 NULL, 0, dxgvmbuschannel_receive, ch);
+	if (ret) {
+		DXG_ERR("vmbus_open failed: %d", ret);
+		goto cleanup;
+	}
+
+	ch->channel = hdev->channel;
+
+cleanup:
+
+	return ret;
+}
+
+void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch)
+{
+	kmem_cache_destroy(ch->packet_cache);
+	ch->packet_cache = NULL;
+
+	if (ch->channel) {
+		vmbus_close(ch->channel);
+		ch->channel = NULL;
+	}
+}
+
+/* Receive callback for messages from the host */
+void dxgvmbuschannel_receive(void *ctx)
+{
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
new file mode 100644
index 000000000000..6cdca5e03d1f
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * VM bus interface with the host definitions
+ *
+ */
+
+#ifndef _DXGVMBUS_H
+#define _DXGVMBUS_H
+
+#define DXG_MAX_VM_BUS_PACKET_SIZE	(1024 * 128)
+
+#endif /* _DXGVMBUS_H */
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
new file mode 100644
index 000000000000..5d973604400c
--- /dev/null
+++ b/include/uapi/misc/d3dkmthk.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * User mode WDDM interface definitions
+ *
+ */
+
+#ifndef _D3DKMTHK_H
+#define _D3DKMTHK_H
+
+/*
+ * Matches the Windows LUID definition.
+ * LUID is a locally unique identifier (similar to GUID, but not global),
+ * which is guaranteed to be unique intil the computer is rebooted.
+ */
+struct winluid {
+	__u32 a;
+	__u32 b;
+};
+
+#endif /* _D3DKMTHK_H */

