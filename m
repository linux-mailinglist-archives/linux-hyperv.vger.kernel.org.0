Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515504C94B8
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiCATrO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbiCATrN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:13 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A72636C97B;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 50E3B20B6C50;
        Tue,  1 Mar 2022 11:46:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50E3B20B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163990;
        bh=nDepy9wB8rSWoVL308Nf1ElS27yvrRsmPKpZp5ABW8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eM0d9ZS6aXOtZd7twhrnnq8YprfJ3jH95jV0QN/MVh5P8kmwGBF+GUHvJd1Vdzz1N
         iioXRg98q9GDncpZ6R8z+5cv+5xFMDcRd1+HRFTkJ7HmdbmGRTxJYnUzVLidT+pCU+
         nEzdgCNo2HMB7/dSCAdzDBV2uKIXLB1QILEu4X28=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and loading
Date:   Tue,  1 Mar 2022 11:45:49 -0800
Message-Id: <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

- Create skeleton and add basic functionality for the
hyper-v compute device driver (dxgkrnl).

- Register for PCI and VM bus driver notifications and
handle initialization of VM bus channels.

- Connect the dxgkrnl module to the drivers/hv/ Makefile and Kconfig

- Create a MAINTAINERS entry

A VM bus channel is a communication interface between the hyper-v guest
and the host. The are two type of VM bus channels, used in the driver:
  - the global channel
  - per virtual compute device channel

A PCI device is created for each virtual compute device, projected
by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
arrival of such devices. The PCI config space of the virtual compute
device has luid of the corresponding virtual compute device VM
bus channel. This is how the compute device adapter objects are
linked to VM bus channels.

VM bus interface version is exchanged by reading/writing the PCI config
space of the virtual compute device.

The IO space is used to handle CPU accessible compute device
allocations. Hyper-v allocates IO space for the global VM bus channel.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 MAINTAINERS                    |   7 +
 drivers/hv/Kconfig             |   2 +
 drivers/hv/Makefile            |   1 +
 drivers/hv/dxgkrnl/Kconfig     |  26 ++
 drivers/hv/dxgkrnl/Makefile    |   5 +
 drivers/hv/dxgkrnl/dxgkrnl.h   | 119 ++++++++
 drivers/hv/dxgkrnl/dxgmodule.c | 531 +++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h   |  23 ++
 8 files changed, 714 insertions(+)
 create mode 100644 drivers/hv/dxgkrnl/Kconfig
 create mode 100644 drivers/hv/dxgkrnl/Makefile
 create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
 create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
 create mode 100644 include/uapi/misc/d3dkmthk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a2bd991db512..5856e09d834c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8841,6 +8841,13 @@ F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
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
index dd12af20e467..7006f7b66200 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -29,4 +29,6 @@ config HYPERV_BALLOON
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
index 000000000000..052f8bd62ad3
--- /dev/null
+++ b/drivers/hv/dxgkrnl/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for the hyper-v compute device driver (dxgkrnl).
+
+obj-$(CONFIG_DXGKRNL)	+= dxgkrnl.o
+dxgkrnl-y		:= dxgmodule.o
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
new file mode 100644
index 000000000000..6b3e9334bce8
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
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
+
+struct dxgadapter;
+
+#include <uapi/misc/d3dkmthk.h>
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
+	struct dxgvmbuschannel	channel;
+	struct delayed_work	dwork;
+	struct hv_device	*hdev;
+	u32			num_adapters;
+	u32			vmbus_ver;	/* Interface version */
+	struct resource		*mem;
+	u64			mmiospace_base;
+	u64			mmiospace_size;
+	struct miscdevice	dxgdevice;
+	struct mutex		device_mutex;
+
+	/*  list of created  processes */
+	struct list_head	plisthead;
+	struct mutex		plistmutex;
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
+	bool			dxg_dev_initialized;
+	bool			vmbus_registered;
+	bool			pci_registered;
+	bool			global_channel_initialized;
+	bool			async_msg_enabled;
+};
+
+extern struct dxgglobal		*dxgglobal;
+
+struct dxgprocess {
+	/* Placeholder */
+};
+
+void init_ioctls(void);
+long dxgk_compat_ioctl(struct file *f, unsigned int p1, unsigned long p2);
+long dxgk_unlocked_ioctl(struct file *f, unsigned int p1, unsigned long p2);
+
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
+#endif
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
new file mode 100644
index 000000000000..412c37bc592d
--- /dev/null
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
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
+
+#include "dxgkrnl.h"
+
+/*
+ * Pointer to the global device data. By design
+ * there is a single vGPU device on the VM bus and a single /dev/dxg device
+ * is created.
+ */
+struct dxgglobal *dxgglobal;
+
+#define DXGKRNL_VERSION			0x2216
+#define PCI_VENDOR_ID_MICROSOFT		0x1414
+#define PCI_DEVICE_ID_VIRTUAL_RENDER	0x008E
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
+
+//
+// Interface from dxgglobal
+//
+
+struct vmbus_channel *dxgglobal_get_vmbus(void)
+{
+	return dxgglobal->channel.channel;
+}
+
+struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void)
+{
+	return &dxgglobal->channel;
+}
+
+int dxgglobal_acquire_channel_lock(void)
+{
+	down_read(&dxgglobal->channel_lock);
+	if (dxgglobal->channel.channel == NULL) {
+		pr_err("Failed to acquire global channel lock");
+		return -ENODEV;
+	} else {
+		return 0;
+	}
+}
+
+void dxgglobal_release_channel_lock(void)
+{
+	up_read(&dxgglobal->channel_lock);
+}
+
+/*
+ * File operations for the /dev/dxg device
+ */
+
+static int dxgk_open(struct inode *n, struct file *f)
+{
+	return 0;
+}
+
+static int dxgk_release(struct inode *n, struct file *f)
+{
+	return 0;
+}
+
+static ssize_t dxgk_read(struct file *f, char __user *s, size_t len,
+			 loff_t *o)
+{
+	pr_debug("file read\n");
+	return 0;
+}
+
+static ssize_t dxgk_write(struct file *f, const char __user *s, size_t len,
+			  loff_t *o)
+{
+	pr_debug("file write\n");
+	return len;
+}
+
+const struct file_operations dxgk_fops = {
+	.owner = THIS_MODULE,
+	.open = dxgk_open,
+	.release = dxgk_release,
+	.write = dxgk_write,
+	.read = dxgk_read,
+};
+
+/*
+ * Interface with the PCI driver
+ */
+
+/*
+ * Part of the PCI config space of the vGPU device is used for vGPU
+ * configuration data. Reading/writing of the PCI config space is forwarded
+ * to the host.
+ */
+
+/* vGPU VM bus channel instance ID */
+#define DXGK_VMBUS_CHANNEL_ID_OFFSET 192
+/* DXGK_VMBUS_INTERFACE_VERSION (u32) */
+#define DXGK_VMBUS_VERSION_OFFSET	(DXGK_VMBUS_CHANNEL_ID_OFFSET + \
+					sizeof(guid_t))
+/* Luid of the virtual GPU on the host (struct winluid) */
+#define DXGK_VMBUS_VGPU_LUID_OFFSET	(DXGK_VMBUS_VERSION_OFFSET + \
+					sizeof(u32))
+/* The guest writes its capavilities to this adderss */
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
+	for (i = 0; i < size / sizeof(int); i++) {
+		ret = pci_read_config_dword(dev, off, &((int *)val)[i]);
+		if (ret) {
+			pr_err("Failed to read PCI config: %d", off);
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
+	pr_debug("Adapter channel: %pUb\n", &guid);
+	pr_debug("Vmbus interface version: %d\n",
+		dxgglobal->vmbus_ver);
+	pr_debug("Host vGPU luid: %x-%x\n",
+		vgpu_luid.b, vgpu_luid.a);
+
+cleanup:
+
+	mutex_unlock(&dxgglobal->device_mutex);
+
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static void dxg_pci_remove_device(struct pci_dev *dev)
+{
+	/* Placeholder */
+}
+
+static struct pci_device_id dxg_pci_id_table = {
+	.vendor = PCI_VENDOR_ID_MICROSOFT,
+	.device = PCI_DEVICE_ID_VIRTUAL_RENDER,
+	.subvendor = PCI_ANY_ID,
+	.subdevice = PCI_ANY_ID
+};
+
+static struct pci_driver dxg_pci_drv = {
+	.name = KBUILD_MODNAME,
+	.id_table = &dxg_pci_id_table,
+	.probe = dxg_pci_probe_device,
+	.remove = dxg_pci_remove_device
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
+		pr_debug("zero mmio space is offered\n");
+		return -ENOMEM;
+	}
+	dxgglobal->mmiospace_size <<= 20;
+	pr_debug("mmio offered: %llx\n",
+		dxgglobal->mmiospace_size);
+
+	ret = vmbus_allocate_mmio(&dxgglobal->mem, hdev, pot_start, pot_end,
+				  dxgglobal->mmiospace_size, 0x10000, false);
+	if (ret) {
+		pr_err("Unable to allocate mmio memory: %d\n", ret);
+		return ret;
+	}
+	dxgglobal->mmiospace_size = dxgglobal->mem->end -
+	    dxgglobal->mem->start + 1;
+	dxgglobal->mmiospace_base = dxgglobal->mem->start;
+	pr_info("mmio allocated %llx  %llx %llx %llx\n",
+		dxgglobal->mmiospace_base,
+		dxgglobal->mmiospace_size,
+		dxgglobal->mem->start, dxgglobal->mem->end);
+
+	return 0;
+}
+
+int dxgglobal_init_global_channel(void)
+{
+	int ret = 0;
+
+	ret = dxgvmbuschannel_init(&dxgglobal->channel, dxgglobal->hdev);
+	if (ret) {
+		pr_err("dxgvmbuschannel_init failed: %d\n", ret);
+		goto error;
+	}
+
+	ret = dxgglobal_getiospace(dxgglobal);
+	if (ret) {
+		pr_err("getiospace failed: %d\n", ret);
+		goto error;
+	}
+
+	hv_set_drvdata(dxgglobal->hdev, dxgglobal);
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
+	dxgglobal->dxg_dev_initialized = true;
+
+error:
+	return ret;
+}
+
+void dxgglobal_destroy_global_channel(void)
+{
+	down_write(&dxgglobal->channel_lock);
+
+	dxgglobal->global_channel_initialized = false;
+
+	if (dxgglobal->dxg_dev_initialized) {
+		misc_deregister(&dxgglobal->dxgdevice);
+		dxgglobal->dxg_dev_initialized = false;
+	}
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
+static const struct hv_vmbus_device_id id_table[] = {
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
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (uuid_le_cmp(hdev->dev_type, id_table[0].guid) == 0) {
+		/* This is a new virtual GPU channel */
+		guid_to_luid(&hdev->channel->offermsg.offer.if_instance, &luid);
+		pr_debug("vGPU channel: %pUb",
+			    &hdev->channel->offermsg.offer.if_instance);
+		vgpuch = vzalloc(sizeof(struct dxgvgpuchannel));
+		if (vgpuch == NULL) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		vgpuch->adapter_luid = luid;
+		vgpuch->hdev = hdev;
+		list_add_tail(&vgpuch->vgpu_ch_list_entry,
+			      &dxgglobal->vgpu_ch_list_head);
+	} else if (uuid_le_cmp(hdev->dev_type, id_table[1].guid) == 0) {
+		/* This is the global Dxgkgnl channel */
+		pr_debug("Global channel: %pUb",
+			    &hdev->channel->offermsg.offer.if_instance);
+		if (dxgglobal->hdev) {
+			/* This device should appear only once */
+			pr_err("global channel already present\n");
+			ret = -EBADE;
+			goto error;
+		}
+		dxgglobal->hdev = hdev;
+	} else {
+		/* Unknown device type */
+		pr_err("probe: unknown device type\n");
+		ret = -EBADE;
+		goto error;
+	}
+
+error:
+
+	mutex_unlock(&dxgglobal->device_mutex);
+
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+static int dxg_remove_vmbus(struct hv_device *hdev)
+{
+	int ret = 0;
+	struct dxgvgpuchannel *vgpu_channel;
+
+	mutex_lock(&dxgglobal->device_mutex);
+
+	if (uuid_le_cmp(hdev->dev_type, id_table[0].guid) == 0) {
+		pr_debug("Remove virtual GPU channel\n");
+		list_for_each_entry(vgpu_channel,
+				    &dxgglobal->vgpu_ch_list_head,
+				    vgpu_ch_list_entry) {
+			if (vgpu_channel->hdev == hdev) {
+				list_del(&vgpu_channel->vgpu_ch_list_entry);
+				vfree(vgpu_channel);
+				break;
+			}
+		}
+	} else if (uuid_le_cmp(hdev->dev_type, id_table[1].guid) == 0) {
+		pr_debug("Remove global channel device\n");
+		dxgglobal_destroy_global_channel();
+	} else {
+		/* Unknown device type */
+		pr_err("remove: unknown device type\n");
+		ret = -EBADE;
+	}
+
+	mutex_unlock(&dxgglobal->device_mutex);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+MODULE_DEVICE_TABLE(vmbus, id_table);
+
+static struct hv_driver dxg_drv = {
+	.name = KBUILD_MODNAME,
+	.id_table = id_table,
+	.probe = dxg_probe_vmbus,
+	.remove = dxg_remove_vmbus,
+	.driver = {
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		    },
+};
+
+/*
+ * Interface with Linux kernel
+ */
+
+static int dxgglobal_create(void)
+{
+	int ret = 0;
+
+	dxgglobal = vzalloc(sizeof(struct dxgglobal));
+	if (!dxgglobal)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&dxgglobal->plisthead);
+	mutex_init(&dxgglobal->plistmutex);
+	mutex_init(&dxgglobal->device_mutex);
+
+	INIT_LIST_HEAD(&dxgglobal->vgpu_ch_list_head);
+
+	init_rwsem(&dxgglobal->channel_lock);
+
+	pr_debug("dxgglobal_init end\n");
+	return ret;
+}
+
+static void dxgglobal_destroy(void)
+{
+	if (dxgglobal) {
+		if (dxgglobal->vmbus_registered)
+			vmbus_driver_unregister(&dxg_drv);
+
+		dxgglobal_destroy_global_channel();
+
+		if (dxgglobal->pci_registered)
+			pci_unregister_driver(&dxg_pci_drv);
+
+		vfree(dxgglobal);
+		dxgglobal = NULL;
+	}
+}
+
+/*
+ * Driver entry points
+ */
+
+static int __init dxg_drv_init(void)
+{
+	int ret;
+
+
+	ret = dxgglobal_create();
+	if (ret) {
+		pr_err("dxgglobal_init failed");
+		return -ENOMEM;
+	}
+
+	ret = vmbus_driver_register(&dxg_drv);
+	if (ret) {
+		pr_err("vmbus_driver_register failed: %d", ret);
+		return ret;
+	}
+	dxgglobal->vmbus_registered = true;
+
+	pr_info("%s  Version: %x", __func__, DXGKRNL_VERSION);
+
+	ret = pci_register_driver(&dxg_pci_drv);
+	if (ret) {
+		pr_err("pci_driver_register failed: %d", ret);
+		return ret;
+	}
+	dxgglobal->pci_registered = true;
+
+	init_ioctls();
+
+	return 0;
+}
+
+static void __exit dxg_drv_exit(void)
+{
+	dxgglobal_destroy();
+}
+
+module_init(dxg_drv_init);
+module_exit(dxg_drv_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual GPU Driver");
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
new file mode 100644
index 000000000000..bdb7bc325d1a
--- /dev/null
+++ b/include/uapi/misc/d3dkmthk.h
@@ -0,0 +1,23 @@
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
+/* Matches Windows LUID definition */
+struct winluid {
+	__u32 a;
+	__u32 b;
+};
+
+#endif /* _D3DKMTHK_H */
-- 
2.35.1

