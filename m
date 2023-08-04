Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6743076FAC7
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Aug 2023 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjHDHKG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Aug 2023 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjHDHKE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Aug 2023 03:10:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C04230E1;
        Fri,  4 Aug 2023 00:10:00 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id EB8DD207F5BC;
        Fri,  4 Aug 2023 00:09:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB8DD207F5BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691133000;
        bh=tK3oD7odpa1w807rL/Yujw4yRVLIILGtNOd6SFw2Qyw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gl9saf4Jcc1BAVdSPN5Z1rQ5GFyPvnLlbwHHJYlbJFFSj9aMjgeOn9BLoXoFdq9zR
         3f++lEdc5veyqqqfh2IzxxtIhf7rtnTSGpjSHwPEbaU/YYlQZGZmvPwVSZdB11aXXA
         sL4Gdp5iTqab8v+1/eAqxq9nesF95WiigW7Ermpg=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 1/3] uio: Add hv_vmbus_client driver
Date:   Fri,  4 Aug 2023 00:09:54 -0700
Message-Id: <1691132996-11706-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
References: <1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add a new UIO-based driver that generically supports low speed Hyper-V
VMBus devices. This driver can be bound to VMBus devices by user space
drivers that provide device-specific management.

The new driver provides the following core functionality, which is
suitable for low speed devices:
* A single VMBus channel for each device
* Ability to specify the VMBus channel ring buffer size for each device
* Host notification via a hypercall instead of monitor bits

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
[V4]
- Added Reviewed-by

[V3]
- Removed ringbuffer sysfs entry and used uio framework for mmap
- Remove ".id_table = NULL"
- kasprintf -> devm_kasprintf
- Change global variable ring_size to per device
- More checks on value which can be set for ring_size
- Remove driverctl, and used echo command instead for driver documentation
- Remove unnecessary one time use macros
- Change kernel version and date for sysfs documentation
- Update documentation
- Better commit message

[V2]
- Update driver info in Documentation/driver-api/uio-howto.rst
- Update ring_size sysfs info in Documentation/ABI/stable/sysfs-bus-vmbus
- Remove DRIVER_VERSION
- Remove refcnt
- scnprintf -> sysfs_emit
- sysfs_create_file -> ATTRIBUTE_GROUPS + ".driver.groups";
- sysfs_create_bin_file -> device_create_bin_file
- dev_notice -> dev_err
- remove MODULE_VERSION

 Documentation/ABI/stable/sysfs-bus-vmbus |  10 ++
 Documentation/driver-api/uio-howto.rst   |  54 ++++++
 drivers/uio/Kconfig                      |  12 ++
 drivers/uio/Makefile                     |   1 +
 drivers/uio/uio_hv_vmbus_client.c        | 218 +++++++++++++++++++++++
 5 files changed, 295 insertions(+)
 create mode 100644 drivers/uio/uio_hv_vmbus_client.c

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index 3066feae1d8d..7e77eda77be3 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -153,6 +153,16 @@ Contact:	Stephen Hemminger <sthemmin@microsoft.com>
 Description:	Binary file created by uio_hv_generic for ring buffer
 Users:		Userspace drivers
 
+What:		/sys/bus/vmbus/devices/<UUID>/ring_size
+Date:		September 2023
+KernelVersion:	6.6
+Contact:	Saurabh Sengar <ssengar@microsoft.com>
+Description:	File created by uio_hv_vmbus_client for setting device ring
+		buffer size. The value specified within the file denotes the
+		total memory allocation for the one complete ring buffer, which
+		includes the ring buffer header, of size PAGE_SIZE.
+Users:		Userspace drivers
+
 What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_full
 Date:           February 2019
 KernelVersion:  5.0
diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
index 907ffa3b38f5..625c2bda369f 100644
--- a/Documentation/driver-api/uio-howto.rst
+++ b/Documentation/driver-api/uio-howto.rst
@@ -722,6 +722,60 @@ For example::
 
 	/sys/bus/vmbus/devices/3811fe4d-0fa0-4b62-981a-74fc1084c757/channels/21/ring
 
+Generic Hyper-V driver for low speed devices
+============================================
+
+The generic driver is a kernel module named uio_hv_vmbus_client. It
+supports slow devices on the Hyper-V VMBus similar to uio_hv_generic
+for faster devices. This driver also gives flexibility of customized
+ring buffer sizes.
+
+Making the driver recognize the device
+--------------------------------------
+
+Since the driver does not declare any device GUID's, it will not get
+loaded automatically and will not automatically bind to any devices. You
+must load it and allocate id to the driver yourself. For example, to use
+the fcopy device class GUID::
+
+        modprobe uio_hv_vmbus_client
+        echo "34d14be3-dee4-41c8-9ae7-6b174977c192" > /sys/bus/vmbus/drivers/uio_hv_vmbus_client/new_id
+
+If there already is a hardware specific kernel driver for the device,
+the generic driver still won't bind to it. In this case if you want to
+use the generic driver for a userspace library you'll have to manually unbind
+the hardware specific driver and bind the generic driver, using the device
+instance GUID like this::
+
+          echo "eb765408-105f-49b6-b4aa-c123b64d17d4" > /sys/bus/vmbus/drivers/uio_hv_vmbus_client/unbind
+          echo "eb765408-105f-49b6-b4aa-c123b64d17d4" > /sys/bus/vmbus/drivers/uio_hv_vmbus_client/bind
+
+You can verify that the device has been bound to the driver by looking
+for it in sysfs, for example like the following::
+
+        ls -l /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/driver
+
+Which if successful should print::
+
+      .../eb765408-105f-49b6-b4aa-c123b64d17d4/driver -> ../../../bus/vmbus/drivers/uio_hv_vmbus_client
+
+Things to know about uio_hv_vmbus_client
+----------------------------------------
+
+The uio_hv_vmbus_client driver maps the Hyper-V device ring buffer to userspace
+and offers an interface to manage it.
+
+The userspace API for mapping and performing read/write operations on the device
+ring buffer is implemented in tools/hv/vmbus_bufring.c. Userspace applications
+should use this file as a library and build their logic on top of it.
+
+Additionally, the uio_hv_vmbus_client driver offers the "ring_size" sysfs entry
+for setting the device ring buffer size before opening the device.
+
+For example::
+
+        /sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/ring_size
+
 Further information
 ===================
 
diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 2e16c5338e5b..bd4d27ecfc9a 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -166,6 +166,18 @@ config UIO_HV_GENERIC
 
 	  If you compile this as a module, it will be called uio_hv_generic.
 
+config UIO_HV_SLOW_DEVICES
+	tristate "Generic driver for low speed VMBus devices"
+	depends on HYPERV
+	help
+	  Generic driver that you can dynamically bind to low speed Hyper-V
+	  VMBus devices to allow a user space driver to manage the device.
+	  The driver provides a single VMBus channel and uses a hypercall
+	  instead of monitor bits to interrupt the host. The driver provides
+	  a configurable per-device ring buffer size.
+
+	  If you compile this as a module, it will be called uio_hv_vmbus_client.
+
 config UIO_DFL
 	tristate "Generic driver for DFL (Device Feature List) bus"
 	depends on FPGA_DFL
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index f2f416a14228..44be0f96da34 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
 obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
 obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
+obj-$(CONFIG_UIO_HV_SLOW_DEVICES)	+= uio_hv_vmbus_client.o
 obj-$(CONFIG_UIO_DFL)	+= uio_dfl.o
diff --git a/drivers/uio/uio_hv_vmbus_client.c b/drivers/uio/uio_hv_vmbus_client.c
new file mode 100644
index 000000000000..68e5aec92a13
--- /dev/null
+++ b/drivers/uio/uio_hv_vmbus_client.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * uio_hv_vmbus_client - UIO driver for low speed VMBus devices
+ *
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Authors:
+ *   Saurabh Sengar <ssengar@microsoft.com>
+ *
+ * Since the driver does not declare any device ids, userspace code must
+ * allocate an id and bind the device to the driver.
+ *
+ * For example, to associate the fcopy service with this driver:
+ * # echo "34d14be3-dee4-41c8-9ae7-6b174977c192" > /sys/bus/vmbus/drivers/uio_hv_vmbus_client/new_id
+ *
+ * If there already is a hardware specific kernel driver for the device,
+ * the generic driver still won't bind to it. In this case if you want to
+ * use the generic driver for a userspace library you'll have to manually unbind
+ * the hardware specific driver and bind the generic driver, using the device
+ * instance GUID like this:
+ * # echo "eb765408-105f-49b6-b4aa-c123b64d17d4" > /sys/bus/vmbus/drivers/uio_hv_vmbus_client/unbind
+ * # echo "eb765408-105f-49b6-b4aa-c123b64d17d4" > /sys/bus/vmbus/drivers/uio_hv_vmbus_client/bind
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/uio_driver.h>
+#include <linux/hyperv.h>
+
+struct uio_hv_vmbus_dev {
+	struct uio_info info;
+	struct hv_device *device;
+	int ring_size;
+};
+
+/*
+ * This is the irqcontrol callback to be registered to uio_info.
+ * It can be used to disable/enable interrupt from user space processes.
+ *
+ * @param info
+ *  pointer to uio_info.
+ * @param irq_state
+ *  state value. 1 to enable interrupt.
+ */
+static int uio_hv_vmbus_irqcontrol(struct uio_info *info, s32 irq_state)
+{
+	struct uio_hv_vmbus_dev *pdata = info->priv;
+	struct hv_device *hv_dev = pdata->device;
+
+	/* Issue a full memory barrier before triggering the notification */
+	virt_mb();
+
+	if (irq_state == 1)
+		vmbus_setevent(hv_dev->channel);
+
+	return 0;
+}
+
+/*
+ * Callback from vmbus_event when something is in inbound ring.
+ */
+static void uio_hv_vmbus_channel_cb(void *context)
+{
+	struct uio_hv_vmbus_dev *pdata = context;
+
+	/* Issue a full memory barrier before sending the event to userspace */
+	virt_mb();
+
+	uio_event_notify(&pdata->info);
+}
+
+static int uio_hv_vmbus_open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_hv_vmbus_dev *pdata = container_of(info, struct uio_hv_vmbus_dev, info);
+	struct hv_device *hv_dev = pdata->device;
+	struct vmbus_channel *channel = hv_dev->channel;
+	void *ring_buffer;
+	int ret;
+
+	ret = vmbus_open(channel, pdata->ring_size, pdata->ring_size, NULL, 0,
+			 uio_hv_vmbus_channel_cb, pdata);
+	if (ret) {
+		dev_err(&hv_dev->device, "error %d when opening the channel\n", ret);
+		return ret;
+	}
+	channel->inbound.ring_buffer->interrupt_mask = 0;
+	set_channel_read_mode(channel, HV_CALL_ISR);
+
+	/* set the mem pointer */
+	info->mem[0].name = "txrx_rings";
+	ring_buffer = page_address(channel->ringbuffer_page);
+	info->mem[0].addr = (uintptr_t)virt_to_phys(ring_buffer);
+	info->mem[0].size = channel->ringbuffer_pagecount << PAGE_SHIFT;
+	info->mem[0].memtype = UIO_MEM_IOVA;
+
+	return ret;
+}
+
+static int uio_hv_vmbus_release(struct uio_info *info, struct inode *inode)
+{
+	struct uio_hv_vmbus_dev *pdata = container_of(info, struct uio_hv_vmbus_dev, info);
+	struct hv_device *hv_dev = pdata->device;
+
+	vmbus_close(hv_dev->channel);
+
+	/* restore the mem pointer to its original state */
+	info->mem[0].name = NULL;
+	info->mem[0].addr = 0;
+	info->mem[0].size = 1;
+	info->mem[0].memtype = UIO_MEM_NONE;
+
+	return 0;
+}
+
+static ssize_t ring_size_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct uio_info *info = dev_get_drvdata(dev);
+	struct uio_hv_vmbus_dev *pdata = container_of(info, struct uio_hv_vmbus_dev, info);
+
+	return sysfs_emit(buf, "%d\n", pdata->ring_size);
+}
+
+static ssize_t ring_size_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	unsigned int val;
+	struct uio_info *info = dev_get_drvdata(dev);
+	struct uio_hv_vmbus_dev *pdata = container_of(info, struct uio_hv_vmbus_dev, info);
+
+	if (kstrtouint(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val < 2 * PAGE_SIZE || val % PAGE_SIZE)
+		return -EINVAL;
+
+	pdata->ring_size = val;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(ring_size);
+
+static struct attribute *uio_hv_vmbus_client_attrs[] = {
+	&dev_attr_ring_size.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(uio_hv_vmbus_client);
+
+static int uio_hv_vmbus_probe(struct hv_device *dev, const struct hv_vmbus_device_id *dev_id)
+{
+	struct uio_hv_vmbus_dev *pdata;
+	int ret;
+	char *name = NULL;
+
+	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	name = devm_kasprintf(&dev->device, GFP_KERNEL, "%pUl", &dev->dev_instance);
+
+	/* Fill general uio info */
+	pdata->info.name = name; /* /sys/class/uio/uioX/name */
+	pdata->info.version = "1";
+	pdata->info.irqcontrol = uio_hv_vmbus_irqcontrol;
+	pdata->info.open = uio_hv_vmbus_open;
+	pdata->info.release = uio_hv_vmbus_release;
+	pdata->info.irq = UIO_IRQ_CUSTOM;
+	pdata->info.priv = pdata;
+	pdata->ring_size = VMBUS_RING_SIZE(3 * HV_HYP_PAGE_SIZE); /* Default ringbuffer size */
+	pdata->device = dev;
+
+	/* dummy value to register the mem pointers which will be updated by open */
+	pdata->info.mem[0].size = 1;
+
+	ret = uio_register_device(&dev->device, &pdata->info);
+	if (ret) {
+		dev_err(&dev->device, "uio_hv_vmbus register failed\n");
+		return ret;
+	}
+
+	hv_set_drvdata(dev, pdata);
+
+	return 0;
+}
+
+static void uio_hv_vmbus_remove(struct hv_device *dev)
+{
+	struct uio_hv_vmbus_dev *pdata = hv_get_drvdata(dev);
+
+	if (pdata)
+		uio_unregister_device(&pdata->info);
+}
+
+static struct hv_driver uio_hv_vmbus_drv = {
+	.driver.dev_groups = uio_hv_vmbus_client_groups,
+	.name = "uio_hv_vmbus_client",
+	.probe = uio_hv_vmbus_probe,
+	.remove = uio_hv_vmbus_remove,
+};
+
+static int __init uio_hv_vmbus_init(void)
+{
+	return vmbus_driver_register(&uio_hv_vmbus_drv);
+}
+
+static void __exit uio_hv_vmbus_exit(void)
+{
+	vmbus_driver_unregister(&uio_hv_vmbus_drv);
+}
+
+module_init(uio_hv_vmbus_init);
+module_exit(uio_hv_vmbus_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Saurabh Sengar <ssengar@microsoft.com>");
+MODULE_DESCRIPTION("Generic UIO driver for low speed VMBus devices");
-- 
2.34.1

