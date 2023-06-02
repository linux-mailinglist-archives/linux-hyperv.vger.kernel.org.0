Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B529371FB6C
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjFBH5Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjFBH5P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 03:57:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C170123;
        Fri,  2 Jun 2023 00:57:14 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A1A8C20FCD4D;
        Fri,  2 Jun 2023 00:57:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1A8C20FCD4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685692633;
        bh=xweCRTiW3hahg7UxRBMHRfmmZJYxJk/Dy0v8DvGysDg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IA69ptjFpAXEItAJRuguQg6gJmeSqjrXbHPZWCPxWoeKx9mahvBefnU6HxmjDf7tB
         /npcHrvFC9Q+30GWOlRwwXQ0TVmRL8LwEKEp6eov/i0DyshJdAmEAIFYBmzTsmUj1T
         6hSkD3mdv+WOj7WS7Sa5Iff6RUnhjbPavh5yx5X8=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH 1/5] uio: Add hv_vmbus_client driver
Date:   Fri,  2 Jun 2023 00:57:05 -0700
Message-Id: <1685692629-31351-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1685692629-31351-1-git-send-email-ssengar@linux.microsoft.com>
References: <1685692629-31351-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Generic VMBus driver that can be dynamically bound, to any simple
low speed Hyper-V VMBus device. This driver supports single
channel and uses hypercall instead of monitor bits to interrupt
host, which is suitable for low speed devices. Additionally, the
driver also provide the flexibility of custom ring buffer sizes and
avoid memory allocation for gpadl to offer memory optimization.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/uio/Kconfig               |  12 ++
 drivers/uio/Makefile              |   1 +
 drivers/uio/uio_hv_vmbus_client.c | 232 ++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/uio/uio_hv_vmbus_client.c

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 2e16c5338e5b..dcc727e6fd3f 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -166,6 +166,18 @@ config UIO_HV_GENERIC
 
 	  If you compile this as a module, it will be called uio_hv_generic.
 
+config UIO_HV_SLOW_DEVICES
+	tristate "Generic driver for low speed VMBus devices"
+	depends on HYPERV
+	help
+	  Generic driver that you can bind, dynamically, to any simple
+	  Hyper-V VMBus device with single channel and these devices
+	  uses hypercall instead of monitor bits to interrupt host. This
+	  driver also provide the flexibility of custom ring buffer sizes.
+	  It is useful for slower VMbus devices.
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
index 000000000000..a5a47caeffe1
--- /dev/null
+++ b/drivers/uio/uio_hv_vmbus_client.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * uio_hv_vmbus_client - UIO driver for low speed VMBus devices
+ *
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Authors:
+ *   Saurabh Sengar <ssengar@microsoft.com>
+ *
+ * Since the driver does not declare any device ids, you must allocate
+ * id and bind the device to the driver yourself.  For example:
+ * driverctl -b vmbus set-override <dev uuid> uio_hv_vmbus_client
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/uio_driver.h>
+#include <linux/hyperv.h>
+#include <linux/vmalloc.h>
+#include <linux/sysfs.h>
+
+#define DRIVER_VERSION	"0.0.1"
+#define DRIVER_AUTHOR	"Saurabh Sengar <ssengar@microsoft.com>"
+#define DRIVER_DESC	"Generic UIO driver for low speed VMBus devices"
+
+#define DEFAULT_HV_RING_SIZE	VMBUS_RING_SIZE(3 * HV_HYP_PAGE_SIZE)
+static int ring_size = DEFAULT_HV_RING_SIZE;
+
+struct uio_hv_vmbus_dev {
+	struct uio_info info;
+	struct hv_device *device;
+	atomic_t refcnt;
+};
+
+/* Sysfs API to allow mmap of the ring buffers
+ * The ring buffer is allocated as contiguous memory by vmbus_open
+ */
+static int uio_hv_vmbus_mmap(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, struct vm_area_struct *vma)
+{
+	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
+	void *ring_buffer = page_address(channel->ringbuffer_page);
+
+	return vm_iomap_memory(vma, virt_to_phys(ring_buffer),
+			       channel->ringbuffer_pagecount << PAGE_SHIFT);
+}
+
+static const struct bin_attribute ring_buffer_bin_attr = {
+	.attr = {
+		.name = "ringbuffer",
+		.mode = 0600,
+	},
+	.mmap = uio_hv_vmbus_mmap,
+};
+
+/*
+ * This is the irqcontrol callback to be registered to uio_info.
+ * It can be used to disable/enable interrupt from user space processes.
+ *
+ * @param info
+ *  pointer to uio_info.
+ * @param irq_state
+ *  state value. 1 to enable interrupt, 0 to disable interrupt.
+ */
+static int uio_hv_vmbus_irqcontrol(struct uio_info *info, s32 irq_state)
+{
+	struct uio_hv_vmbus_dev *pdata = info->priv;
+	struct hv_device *hv_dev = pdata->device;
+
+	/* Issue a full memory barrier before triggering the notification */
+	virt_mb();
+
+	vmbus_setevent(hv_dev->channel);
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
+	int ret = 0;
+
+	if (atomic_inc_return(&pdata->refcnt) != 1)
+		return 0;
+
+	ret = vmbus_open(channel, ring_size, ring_size, NULL, 0,
+			 uio_hv_vmbus_channel_cb, pdata);
+	if (ret) {
+		dev_err(&hv_dev->device, "error %d when opening the channel\n", ret);
+		goto done;
+	}
+	channel->inbound.ring_buffer->interrupt_mask = 0;
+	set_channel_read_mode(channel, HV_CALL_ISR);
+
+	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
+	if (ret)
+		dev_notice(&hv_dev->device, "sysfs create ring bin file failed; %d\n", ret);
+
+	return 0;
+
+done:
+	atomic_dec(&pdata->refcnt);
+	return ret;
+}
+
+/* VMbus primary channel is closed on last close */
+static int uio_hv_vmbus_release(struct uio_info *info, struct inode *inode)
+{
+	struct uio_hv_vmbus_dev *pdata = container_of(info, struct uio_hv_vmbus_dev, info);
+	struct hv_device *hv_dev = pdata->device;
+	struct vmbus_channel *channel = hv_dev->channel;
+
+	sysfs_remove_bin_file(&channel->kobj, &ring_buffer_bin_attr);
+
+	if (atomic_dec_and_test(&pdata->refcnt))
+		vmbus_close(channel);
+
+	return 0;
+}
+
+static ssize_t ring_size_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ring_size);
+}
+
+static ssize_t ring_size_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	unsigned int val;
+
+	if (kstrtouint(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val < HV_HYP_PAGE_SIZE)
+		return -EINVAL;
+
+	ring_size = val;
+
+	return count;
+}
+static DEVICE_ATTR_RW(ring_size);
+
+static int uio_hv_vmbus_probe(struct hv_device *dev, const struct hv_vmbus_device_id *dev_id)
+{
+	struct uio_hv_vmbus_dev *pdata;
+	int ret = 0;
+	char *name = NULL;
+
+	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	name = kasprintf(GFP_KERNEL, "%pUl", &dev->dev_instance);
+
+	/* Fill general uio info */
+	pdata->info.name = name; /* /sys/class/uio/uioX/name */
+	pdata->info.version = DRIVER_VERSION;
+	pdata->info.irqcontrol = uio_hv_vmbus_irqcontrol;
+	pdata->info.open = uio_hv_vmbus_open;
+	pdata->info.release = uio_hv_vmbus_release;
+	pdata->info.irq = UIO_IRQ_CUSTOM;
+	pdata->info.priv = pdata;
+	pdata->device = dev;
+
+	ret = uio_register_device(&dev->device, &pdata->info);
+	if (ret) {
+		dev_err(&dev->device, "uio_hv_vmbus register failed\n");
+		goto fail;
+	}
+
+	ret = sysfs_create_file(&dev->device.kobj, &dev_attr_ring_size.attr);
+	if (ret)
+		dev_notice(&dev->device, "sysfs create ring size file failed; %d\n", ret);
+
+	hv_set_drvdata(dev, pdata);
+	return 0;
+
+fail:
+	kfree(pdata);
+	return ret;
+}
+
+static void
+uio_hv_vmbus_remove(struct hv_device *dev)
+{
+	struct uio_hv_vmbus_dev *pdata = hv_get_drvdata(dev);
+
+	sysfs_remove_file(&dev->device.kobj, &dev_attr_ring_size.attr);
+	if (pdata)
+		uio_unregister_device(&pdata->info);
+}
+
+static struct hv_driver uio_hv_vmbus_drv = {
+	.name = "uio_hv_vmbus_client",
+	.id_table = NULL, /* only dynamic id's */
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
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.34.1

