Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A689F6FDE
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2019 09:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKKIpS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Nov 2019 03:45:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40342 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKIpR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Nov 2019 03:45:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so10223324pfl.7;
        Mon, 11 Nov 2019 00:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aoNsXrqb/4m251g26a9JnAvsvd+FQZ6xqhju3XhJrIw=;
        b=EbVbNdoiiY9078yEneNR4t9k1ZvvZhAdnTZydsMhAA10u8k8uzLa0sTOTisqlZB2Wl
         EDKSuORWt+WQ+R52MKozTXNks+gAeMByfRUZxxNVvT8vpyh9oDEYAKluFbfaoPnL6FcM
         aSXUspT/jAFEMhDt3BYjzv7EOL/KM1g16N7DxkBwMvqVDGTDne/1YvkbML5Hs+HgNtp4
         eXTTVbvYt9uzVitQ886V+DemCEZH2w5vPlOJvk1L7lZNTai2YZ4KmVRIsqps9XBHsbrX
         BUsbsn2FEdnmusRSHqKl7jHuLRAZ1bXC+iMHsJ5AaZxgBQsq4BfsE8dWJLopBVwT3wYF
         xigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aoNsXrqb/4m251g26a9JnAvsvd+FQZ6xqhju3XhJrIw=;
        b=JlsoOzGNpkZlW0GHzuFb4SWmTU7sSU3UUyZujGq0+k8fJHMTuZllxZYc7naFP1GeQ+
         azHs9jHGjjPeGVrZAqX4EhEGwTqSejFOuGGrJenb1fjznBdOYjyDTPMXxs3sDGgl2qKX
         ev4me43UMrA+I7jrPkNTQedzlRikSqoffjVtnEzRjUOtHak59r7urz/1wnipCBdigd80
         IHt1Af/3lAQr9fvGJ2sPpORXvgtApyTCNudtWWm8V9PBrRg9FsznfRTm55dqFwwSkKbs
         UN2R0yDb1SlgVIul5kp/Co0nZIZQgfDIYNcxC2nN64+XR3c9l8HFyGgH09koA9qLljsj
         F1vw==
X-Gm-Message-State: APjAAAWOYt8YrDIXEzpcNWxE7Rzp7/yLsV1gLClqTnStQNUX8UWuGpwY
        bbdPRLictLKFmKhUzlqT7cY=
X-Google-Smtp-Source: APXvYqxfF87VnZCZ3h3mE1UM/Hs6U59rWnYNg+94zrR6b9Dw2eLKBjZXKlWQ4dSNddoUonF53yaScA==
X-Received: by 2002:a63:2c3:: with SMTP id 186mr27460715pgc.166.1573461916560;
        Mon, 11 Nov 2019 00:45:16 -0800 (PST)
Received: from dell.guest.corp.microsoft.com ([167.220.255.69])
        by smtp.googlemail.com with ESMTPSA id z16sm15642656pge.55.2019.11.11.00.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 00:45:15 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     alex.williamson@redhat.com, cohuck@redhat.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, paulmck@linux.ibm.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH] VFIO/VMBUS: Add VFIO VMBUS driver support
Date:   Mon, 11 Nov 2019 16:45:07 +0800
Message-Id: <20191111084507.9286-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patch is to add VFIO VMBUS driver support in order to expose
VMBUS devices to user space drivers(Reference Hyper-V UIO driver).
DPDK now has netvsc PMD driver support and it may get VMBUS resources
via VFIO interface with new driver support.

So far, Hyper-V doesn't provide virtual IOMMU support and so this
driver needs to be used with VFIO noiommu mode.

Current netvsc PMD driver in DPDK doesn't have IRQ mode support.
This driver version skips IRQ control part and adds later when
there is a real request.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 MAINTAINERS                     |   1 +
 drivers/vfio/Kconfig            |   1 +
 drivers/vfio/Makefile           |   1 +
 drivers/vfio/vmbus/Kconfig      |   9 +
 drivers/vfio/vmbus/vfio_vmbus.c | 407 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  12 ++
 6 files changed, 431 insertions(+)
 create mode 100644 drivers/vfio/vmbus/Kconfig
 create mode 100644 drivers/vfio/vmbus/vfio_vmbus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef7fa74..6f61fb351a5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7574,6 +7574,7 @@ F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
 F:	drivers/iommu/hyperv-iommu.c
+F:	drivers/vfio/vmbus/
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/clocksource/hyperv_timer.h
 F:	include/linux/hyperv.h
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index fd17db9b432f..f4e075fcedbe 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -47,4 +47,5 @@ menuconfig VFIO_NOIOMMU
 source "drivers/vfio/pci/Kconfig"
 source "drivers/vfio/platform/Kconfig"
 source "drivers/vfio/mdev/Kconfig"
+source "drivers/vfio/vmbus/Kconfig"
 source "virt/lib/Kconfig"
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index de67c4725cce..acef916cba7f 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
 obj-$(CONFIG_VFIO_PCI) += pci/
 obj-$(CONFIG_VFIO_PLATFORM) += platform/
 obj-$(CONFIG_VFIO_MDEV) += mdev/
+obj-$(CONFIG_VFIO_VMBUS) += vmbus/
diff --git a/drivers/vfio/vmbus/Kconfig b/drivers/vfio/vmbus/Kconfig
new file mode 100644
index 000000000000..27a85daae55a
--- /dev/null
+++ b/drivers/vfio/vmbus/Kconfig
@@ -0,0 +1,9 @@
+config VFIO_VMBUS
+	tristate "VFIO support for vmbus devices"
+	depends on VFIO && HYPERV
+	help
+	  Support for the VMBUS VFIO bus driver. Expose VMBUS
+	  resources to user space drivers(e.g, DPDK and SPDK).
+
+	  If you don't know what to do here, say N.
+
diff --git a/drivers/vfio/vmbus/vfio_vmbus.c b/drivers/vfio/vmbus/vfio_vmbus.c
new file mode 100644
index 000000000000..25d9cafa2c0a
--- /dev/null
+++ b/drivers/vfio/vmbus/vfio_vmbus.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * VFIO VMBUS driver.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vfio.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/hyperv.h>
+
+#include "../../hv/hyperv_vmbus.h"
+
+
+#define DRIVER_VERSION	"0.0.1"
+#define DRIVER_AUTHOR	"Tianyu Lan <Tianyu.Lan@microsoft.com>"
+#define DRIVER_DESC	"VFIO driver for VMBus devices"
+
+#define HV_RING_SIZE	 (512 * HV_HYP_PAGE_SIZE) /* 2M Ring size */
+#define SEND_BUFFER_SIZE (16 * 1024 * 1024)
+#define RECV_BUFFER_SIZE (31 * 1024 * 1024)
+
+struct vmbus_mem {
+	phys_addr_t		addr;
+	resource_size_t		size;
+};
+
+struct vfio_vmbus_device {
+	struct hv_device *hdev;
+	atomic_t refcnt;
+	struct  vmbus_mem mem[VFIO_VMBUS_MAX_MAP_NUM];
+
+	void	*recv_buf;
+	void	*send_buf;
+};
+
+static void vfio_vmbus_channel_cb(void *context)
+{
+	struct vmbus_channel *chan = context;
+
+	/* Disable interrupts on channel */
+	chan->inbound.ring_buffer->interrupt_mask = 1;
+
+	/* Issue a full memory barrier after masking interrupt */
+	virt_mb();
+}
+
+static int vfio_vmbus_ring_mmap(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *attr,
+			    struct vm_area_struct *vma)
+{
+	struct vmbus_channel *channel
+		= container_of(kobj, struct vmbus_channel, kobj);
+	void *ring_buffer = page_address(channel->ringbuffer_page);
+
+	if (channel->state != CHANNEL_OPENED_STATE)
+		return -ENODEV;
+
+	return vm_iomap_memory(vma, virt_to_phys(ring_buffer),
+			       channel->ringbuffer_pagecount << PAGE_SHIFT);
+}
+
+static const struct bin_attribute ring_buffer_bin_attr = {
+	.attr = {
+		.name = "ring",
+		.mode = 0600,
+	},
+	.size = 2 * HV_RING_SIZE,
+	.mmap = vfio_vmbus_ring_mmap,
+};
+
+static void
+vfio_vmbus_new_channel(struct vmbus_channel *new_sc)
+{
+	struct hv_device *hv_dev = new_sc->primary_channel->device_obj;
+	struct device *device = &hv_dev->device;
+	int ret;
+
+	/* Create host communication ring */
+	ret = vmbus_open(new_sc, HV_RING_SIZE, HV_RING_SIZE, NULL, 0,
+			 vfio_vmbus_channel_cb, new_sc);
+	if (ret) {
+		dev_err(device, "vmbus_open subchannel failed: %d\n", ret);
+		return;
+	}
+
+	/* Disable interrupts on sub channel */
+	new_sc->inbound.ring_buffer->interrupt_mask = 1;
+	set_channel_read_mode(new_sc, HV_CALL_ISR);
+
+	ret = sysfs_create_bin_file(&new_sc->kobj, &ring_buffer_bin_attr);
+	if (ret)
+		dev_notice(&hv_dev->device,
+			   "sysfs create ring bin file failed; %d\n", ret);
+}
+
+static int vfio_vmbus_open(void *device_data)
+{
+	struct vfio_vmbus_device *vdev = device_data;
+	struct hv_device *dev = vdev->hdev;
+	int ret;
+
+	vmbus_set_sc_create_callback(dev->channel, vfio_vmbus_new_channel);
+
+	ret = vmbus_connect_ring(dev->channel,
+			vfio_vmbus_channel_cb, dev->channel);
+	if (ret == 0)
+		dev->channel->inbound.ring_buffer->interrupt_mask = 1;
+
+	return 0;
+}
+
+static long vfio_vmbus_ioctl(void *device_data, unsigned int cmd,
+			 unsigned long arg)
+{
+	struct vfio_vmbus_device *vdev = device_data;
+	unsigned long minsz;
+
+	if (cmd == VFIO_DEVICE_GET_INFO) {
+		struct vfio_device_info info;
+
+		minsz = offsetofend(struct vfio_device_info, num_irqs);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		info.flags = VFIO_DEVICE_FLAGS_VMBUS;
+		info.num_regions = VFIO_VMBUS_MAX_MAP_NUM;
+
+		return copy_to_user((void __user *)arg, &info, minsz) ?
+			-EFAULT : 0;
+	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
+		struct vfio_region_info info;
+
+		minsz = offsetofend(struct vfio_region_info, offset);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		if (info.index >= VFIO_VMBUS_MAX_MAP_NUM)
+			return -EINVAL;
+
+		info.offset = vdev->mem[info.index].addr;
+		info.size = vdev->mem[info.index].size;
+		info.flags = VFIO_REGION_INFO_FLAG_READ
+			| VFIO_REGION_INFO_FLAG_WRITE
+			| VFIO_REGION_INFO_FLAG_MMAP;
+
+		return copy_to_user((void __user *)arg, &info, minsz) ?
+			-EFAULT : 0;
+	}
+
+	return -ENOTTY;
+}
+
+static void vfio_vmbus_release(void *device_data)
+{
+	struct vfio_vmbus_device *vdev = device_data;
+
+	vmbus_disconnect_ring(vdev->hdev->channel);
+}
+
+static vm_fault_t vfio_vma_fault(struct vm_fault *vmf)
+{
+	struct vfio_vmbus_device *vdev = vmf->vma->vm_private_data;
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page;
+	unsigned long offset;
+	void *addr;
+	int index;
+
+	index = vma->vm_pgoff;
+
+	/*
+	 * Page fault should only happen on mmap regiones
+	 * and bypass GPADL indexes here.
+	 */
+	if (index >= VFIO_VMBUS_MAX_MAP_NUM - 2)
+		return VM_FAULT_SIGBUS;
+
+	offset = (vmf->pgoff - index) << PAGE_SHIFT;
+	addr = (void *)(vdev->mem[index].addr + offset);
+
+	if (index == VFIO_VMBUS_SEND_BUF_MAP ||
+	    index == VFIO_VMBUS_RECV_BUF_MAP)
+		page = vmalloc_to_page(addr);
+	else
+		page = virt_to_page(addr);
+
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
+}
+
+static const struct vm_operations_struct vfio_logical_vm_ops = {
+	.fault = vfio_vma_fault,
+};
+
+static const struct vm_operations_struct vfio_physical_vm_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
+static int vfio_vmbus_mmap(void *device_data, struct vm_area_struct *vma)
+{
+	struct vfio_vmbus_device *vdev = device_data;
+	int index;
+
+	if (vma->vm_end < vma->vm_start)
+		return -EINVAL;
+
+	/*
+	 * Mmap should only happen on map regions
+	 * and bypass GPADL index here.
+	 */
+	if (vma->vm_pgoff >= VFIO_VMBUS_MAX_MAP_NUM - 2)
+		return -EINVAL;
+
+	index = vma->vm_pgoff;
+	vma->vm_private_data = vdev;
+
+	if (index == VFIO_VMBUS_TXRX_RING_MAP) {
+		u64 addr;
+
+		addr = vdev->mem[VFIO_VMBUS_TXRX_RING_MAP].addr;
+		vma->vm_ops = &vfio_physical_vm_ops;
+		return remap_pfn_range(vma,
+			       vma->vm_start,
+			       addr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+	} else {
+		vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
+		vma->vm_ops = &vfio_logical_vm_ops;
+		return 0;
+	}
+}
+
+static const struct vfio_device_ops vfio_vmbus_ops = {
+	.name		= "vfio-vmbus",
+	.open		= vfio_vmbus_open,
+	.release	= vfio_vmbus_release,
+	.mmap		= vfio_vmbus_mmap,
+	.ioctl		= vfio_vmbus_ioctl,
+};
+
+static int vfio_vmbus_probe(struct hv_device *dev,
+			 const struct hv_vmbus_device_id *dev_id)
+{
+	struct vmbus_channel *channel = dev->channel;
+	struct vfio_vmbus_device *vdev;
+	struct iommu_group *group;
+	u32 gpadl;
+	void *ring_buffer;
+	int ret;
+
+	group = vfio_iommu_group_get(&dev->device);
+	if (!group)
+		return -EINVAL;
+
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev) {
+		vfio_iommu_group_put(group, &dev->device);
+		return -ENOMEM;
+	}
+
+	ret = vfio_add_group_dev(&dev->device, &vfio_vmbus_ops, vdev);
+	if (ret)
+		goto free_vdev;
+
+	vdev->hdev = dev;
+	ret = vmbus_alloc_ring(channel, HV_RING_SIZE, HV_RING_SIZE);
+	if (ret)
+		goto del_group_dev;
+
+	set_channel_read_mode(channel, HV_CALL_ISR);
+
+	ring_buffer = page_address(channel->ringbuffer_page);
+	vdev->mem[VFIO_VMBUS_TXRX_RING_MAP].addr
+		= virt_to_phys(ring_buffer);
+	vdev->mem[VFIO_VMBUS_TXRX_RING_MAP].size
+		= channel->ringbuffer_pagecount << PAGE_SHIFT;
+
+	vdev->mem[VFIO_VMBUS_INT_PAGE_MAP].addr
+		= (phys_addr_t)vmbus_connection.int_page;
+	vdev->mem[VFIO_VMBUS_INT_PAGE_MAP].size = PAGE_SIZE;
+
+	vdev->mem[VFIO_VMBUS_MON_PAGE_MAP].addr
+		= (phys_addr_t)vmbus_connection.monitor_pages[1];
+	vdev->mem[VFIO_VMBUS_MON_PAGE_MAP].size = PAGE_SIZE;
+
+	vdev->recv_buf = vzalloc(RECV_BUFFER_SIZE);
+	if (vdev->recv_buf == NULL) {
+		ret = -ENOMEM;
+		goto free_ring;
+	}
+
+	ret = vmbus_establish_gpadl(channel, vdev->recv_buf,
+				    RECV_BUFFER_SIZE, &gpadl);
+	if (ret)
+		goto free_recv_buf;
+
+	vdev->mem[VFIO_VMBUS_RECV_BUF_MAP].addr
+		= (phys_addr_t)vdev->recv_buf;
+	vdev->mem[VFIO_VMBUS_RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
+
+	/* Expose Recv GPADL via region info. */
+	vdev->mem[VFIO_VMBUS_RECV_GPADL].addr = gpadl;
+
+	vdev->send_buf = vzalloc(SEND_BUFFER_SIZE);
+	if (vdev->send_buf == NULL) {
+		ret = -ENOMEM;
+		goto free_recv_gpadl;
+	}
+
+	ret = vmbus_establish_gpadl(channel, vdev->send_buf,
+				    SEND_BUFFER_SIZE, &gpadl);
+	if (ret)
+		goto free_send_buf;
+
+	vdev->mem[VFIO_VMBUS_SEND_BUF_MAP].addr
+		= (phys_addr_t)vdev->send_buf;
+	vdev->mem[VFIO_VMBUS_SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
+
+	/* Expose Send GPADL via region info. */
+	vdev->mem[VFIO_VMBUS_SEND_GPADL].addr = gpadl;
+
+	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
+	if (ret)
+		dev_notice(&dev->device,
+			   "sysfs create ring bin file failed; %d\n", ret);
+
+	return 0;
+
+ free_send_buf:
+	vfree(vdev->send_buf);
+ free_recv_gpadl:
+	vmbus_teardown_gpadl(channel, vdev->mem[VFIO_VMBUS_RECV_GPADL].addr);
+ free_recv_buf:
+	vfree(vdev->recv_buf);
+ free_ring:
+	vmbus_free_ring(channel);
+ del_group_dev:
+	vfio_del_group_dev(&dev->device);
+ free_vdev:
+	vfio_iommu_group_put(group, &dev->device);
+	kfree(vdev);
+	return -EINVAL;
+}
+
+static int vfio_vmbus_remove(struct hv_device *hdev)
+{
+	struct vfio_vmbus_device *vdev = vfio_del_group_dev(&hdev->device);
+	struct vmbus_channel *channel = hdev->channel;
+
+	if (!vdev)
+		return 0;
+
+	sysfs_remove_bin_file(&channel->kobj, &ring_buffer_bin_attr);
+
+	vmbus_teardown_gpadl(channel, vdev->mem[VFIO_VMBUS_SEND_GPADL].addr);
+	vmbus_teardown_gpadl(channel, vdev->mem[VFIO_VMBUS_RECV_GPADL].addr);
+	vfree(vdev->recv_buf);
+	vfree(vdev->send_buf);
+	vmbus_free_ring(channel);
+	vfio_iommu_group_put(hdev->device.iommu_group, &hdev->device);
+	kfree(vdev);
+
+	return 0;
+}
+
+static struct hv_driver hv_vfio_drv = {
+	.name = "hv_vfio",
+	.id_table = NULL,
+	.probe = vfio_vmbus_probe,
+	.remove = vfio_vmbus_remove,
+};
+
+static int __init vfio_vmbus_init(void)
+{
+	return vmbus_driver_register(&hv_vfio_drv);
+}
+
+static void __exit vfio_vmbus_exit(void)
+{
+	vmbus_driver_unregister(&hv_vfio_drv);
+}
+
+module_init(vfio_vmbus_init);
+module_exit(vfio_vmbus_exit);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 9e843a147ead..611baf7a30e4 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -201,6 +201,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
 #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
 #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
+#define VFIO_DEVICE_FLAGS_VMBUS  (1 << 6)	/* vfio-vmbus device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -564,6 +565,17 @@ enum {
 	VFIO_PCI_NUM_IRQS
 };
 
+enum {
+	VFIO_VMBUS_TXRX_RING_MAP = 0,
+	VFIO_VMBUS_INT_PAGE_MAP,
+	VFIO_VMBUS_MON_PAGE_MAP,
+	VFIO_VMBUS_RECV_BUF_MAP,
+	VFIO_VMBUS_SEND_BUF_MAP,
+	VFIO_VMBUS_RECV_GPADL,
+	VFIO_VMBUS_SEND_GPADL,
+	VFIO_VMBUS_MAX_MAP_NUM,
+};
+
 /*
  * The vfio-ccw bus driver makes use of the following fixed region and
  * IRQ index mapping. Unimplemented regions return a size of zero.
-- 
2.14.5

