Return-Path: <linux-hyperv+bounces-4569-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95669A66A37
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 07:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23EA17CD80
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 06:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2176915573F;
	Tue, 18 Mar 2025 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="StuvF/Uu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672A154425;
	Tue, 18 Mar 2025 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278574; cv=none; b=ZWQPXi+Zt6v9A38WC8r4e3pJKdcOS+73IxwnOZA8pR5AS2jfist3IydTimjRwrGvwf+wSgwgfCP5vwipx8dfXkym1ibx9ogAuu0P+Wec3r824D8W1TgnPYYDUqQQwcnI+A12Y4fV25ML+zWPMAqq6nLHOL6cseKCTRlDyrDVV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278574; c=relaxed/simple;
	bh=+Q2ZlGwKlxKB7sEMXPCQHvJ4ch4o7NSY2i8fUUc9cPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rk+spc7p3KkArydZwPRMAZs4Mv7IC9mZolUK50DnPVyiWdx4bhs6V9jnihCeEGVsA1kdDnFcExeMHmFoi6uK/7c67VKihGpUdawQKfk2SjjDtmEsTGKZ1DwFMBbvr/FiP5/H1s6wOYQNQgdQWlxSc9KzUxmSlJCp7Ooi/D3CYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=StuvF/Uu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4DBDA20DEACD;
	Mon, 17 Mar 2025 23:16:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DBDA20DEACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742278571;
	bh=XJj8rA+80+dzrpdcK/jaSfabwlyumAFVyIGUeOB5G8g=;
	h=From:To:Cc:Subject:Date:From;
	b=StuvF/Uuq6cTo+O0GAZpveGyAvSlqcufAiuAHHJ+boGZow8EbxXuImqmzU9XL4QZm
	 e4O14XaoxlLWMEmIzvTAXG0fO7/JcjdQiNk1YNGsoxhgjdHNLKTAuJj2izp2YnEFCC
	 8HWexh7uei+kLu7/oTQ9RNTpLTvGvv4oJoQqWaPY=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH v2] uio_hv_generic: Fix sysfs creation path for ring buffer
Date: Tue, 18 Mar 2025 11:45:58 +0530
Message-Id: <20250318061558.3294-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On regular bootup, devices get registered to vmbus first, so when
uio_hv_generic driver for a particular device type is probed,
the device is already initialized and added, so sysfs creation in
uio_hv_generic probe works fine. However, when device is removed
and brought back, the channel rescinds and device again gets
registered to vmbus. However this time, the uio_hv_generic driver is
already registered to probe for that device and in this case sysfs
creation is tried before the device gets initialized completely.

Fix this by moving the core logic of sysfs creation for ring buffer,
from uio_hv_generic to HyperV's vmbus driver, where rest of the sysfs
attributes for the channels are defined. While doing that, make use
of attribute groups and macros, instead of creating sysfs directly,
to ensure better error handling and code flow. While at it, configure
size of ring sysfs based on ring buffer's actual size and not 2MB default.

Problem path:
vmbus_device_register
    device_register
        uio_hv_generic probe
                    sysfs_create_bin_file (fails here)
        kset_create_and_add (dependency)
        vmbus_add_channel_kobj (dependency)

Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for primary channel")
Cc: stable@kernel.org
Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
Hi,
PFB change logs:

Changes since v1:
https://lore.kernel.org/all/20250225052001.2225-1-namjain@linux.microsoft.com/
* Fixed race condition in setting channel->mmap_ring_buffer by
  introducing a new variable for visibility of sysfs (addressed Greg's
  comments)
* Used binary attribute fields instead of regular ones for initializing attribute_group.
* Make size of ring sysfs dynamic based on actual ring buffer's size.
* Preferred to keep mmap function in uio_hv_generic to give more control over ring's
  mmap functionality, since this is specific to uio_hv_generic driver.
* Remove spurious warning during sysfs creation in uio_hv_generic probe.
* Added comments in a couple of places.

Changes since RFC patch:
https://lore.kernel.org/all/20250214064351.8994-1-namjain@linux.microsoft.com/
* Different approach to solve the problem is proposed (credits to
  Michael Kelley).
* Core logic for sysfs creation moved out of uio_hv_generic, to VMBus
  drivers where rest of the sysfs attributes for a VMBus channel
  are defined. (addressed Greg's comments)
* Used attribute groups instead of sysfs_create* functions, and bundled
  ring attribute with other attributes for the channel sysfs.  

Error logs:

[   35.574120] ------------[ cut here ]------------
[   35.574122] WARNING: CPU: 0 PID: 10 at fs/sysfs/file.c:591 sysfs_create_bin_file+0x81/0x90
[   35.574168] Workqueue: hv_pri_chan vmbus_add_channel_work
[   35.574172] RIP: 0010:sysfs_create_bin_file+0x81/0x90
[   35.574197] Call Trace:
[   35.574199]  <TASK>
[   35.574200]  ? show_regs+0x69/0x80
[   35.574217]  ? __warn+0x8d/0x130
[   35.574220]  ? sysfs_create_bin_file+0x81/0x90
[   35.574222]  ? report_bug+0x182/0x190
[   35.574225]  ? handle_bug+0x5b/0x90
[   35.574244]  ? exc_invalid_op+0x19/0x70
[   35.574247]  ? asm_exc_invalid_op+0x1b/0x20
[   35.574252]  ? sysfs_create_bin_file+0x81/0x90
[   35.574255]  hv_uio_probe+0x1e7/0x410 [uio_hv_generic]
[   35.574271]  vmbus_probe+0x3b/0x90
[   35.574275]  really_probe+0xf4/0x3b0
[   35.574279]  __driver_probe_device+0x8a/0x170
[   35.574282]  driver_probe_device+0x23/0xc0
[   35.574285]  __device_attach_driver+0xb5/0x140
[   35.574288]  ? __pfx___device_attach_driver+0x10/0x10
[   35.574291]  bus_for_each_drv+0x86/0xe0
[   35.574294]  __device_attach+0xc1/0x200
[   35.574297]  device_initial_probe+0x13/0x20
[   35.574315]  bus_probe_device+0x99/0xa0
[   35.574318]  device_add+0x647/0x870
[   35.574320]  ? hrtimer_init+0x28/0x70
[   35.574323]  device_register+0x1b/0x30
[   35.574326]  vmbus_device_register+0x83/0x130
[   35.574328]  vmbus_add_channel_work+0x135/0x1a0
[   35.574331]  process_one_work+0x177/0x340
[   35.574348]  worker_thread+0x2b2/0x3c0
[   35.574350]  kthread+0xe3/0x1f0
[   35.574353]  ? __pfx_worker_thread+0x10/0x10
[   35.574356]  ? __pfx_kthread+0x10/0x10

---
 drivers/hv/hyperv_vmbus.h    |  6 +++
 drivers/hv/vmbus_drv.c       | 82 +++++++++++++++++++++++++++++++++++-
 drivers/uio/uio_hv_generic.c | 33 +++++----------
 include/linux/hyperv.h       |  6 +++
 4 files changed, 104 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 29780f3a7478..0b450e53161e 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -477,4 +477,10 @@ static inline int hv_debug_add_dev_dir(struct hv_device *dev)
 
 #endif /* CONFIG_HYPERV_TESTING */
 
+/* Create and remove sysfs entry for memory mapped ring buffers for a channel */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma));
+int hv_remove_ring_sysfs(struct vmbus_channel *channel);
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8d3cff42bdbb..06ee2924077a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1802,6 +1802,26 @@ static ssize_t subchannel_id_show(struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR_RO(subchannel_id);
 
+static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
+				       const struct bin_attribute *attr,
+				       struct vm_area_struct *vma)
+{
+	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
+
+	/*
+	 * hv_(create|remove)_ring_sysfs implementation ensures that mmap_ring_buffer
+	 * is not NULL.
+	 */
+	return channel->mmap_ring_buffer(channel, vma);
+}
+
+static struct bin_attribute chan_attr_ring_buffer = {
+	.attr = {
+		.name = "ring",
+		.mode = 0600,
+	},
+	.mmap = hv_mmap_ring_buffer_wrapper,
+};
 static struct attribute *vmbus_chan_attrs[] = {
 	&chan_attr_out_mask.attr,
 	&chan_attr_in_mask.attr,
@@ -1821,6 +1841,11 @@ static struct attribute *vmbus_chan_attrs[] = {
 	NULL
 };
 
+static struct bin_attribute *vmbus_chan_bin_attrs[] = {
+	&chan_attr_ring_buffer,
+	NULL
+};
+
 /*
  * Channel-level attribute_group callback function. Returns the permission for
  * each attribute, and returns 0 if an attribute is not visible.
@@ -1841,9 +1866,34 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
+static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
+					      const struct bin_attribute *attr, int idx)
+{
+	const struct vmbus_channel *channel =
+		container_of(kobj, struct vmbus_channel, kobj);
+
+	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
+	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
+		return 0;
+
+	return attr->attr.mode;
+}
+
+static size_t vmbus_chan_bin_size(struct kobject *kobj,
+				  const struct bin_attribute *bin_attr, int a)
+{
+	const struct vmbus_channel *channel =
+		container_of(kobj, struct vmbus_channel, kobj);
+
+	return channel->ringbuffer_pagecount << PAGE_SHIFT;
+}
+
 static const struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
-	.is_visible = vmbus_chan_attr_is_visible
+	.bin_attrs = vmbus_chan_bin_attrs,
+	.is_visible = vmbus_chan_attr_is_visible,
+	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
+	.bin_size = vmbus_chan_bin_size,
 };
 
 static const struct kobj_type vmbus_chan_ktype = {
@@ -1851,6 +1901,36 @@ static const struct kobj_type vmbus_chan_ktype = {
 	.release = vmbus_chan_release,
 };
 
+/*
+ * hv_create_ring_sysfs - create ring sysfs entry corresponding to ring buffers for a channel
+ */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma))
+{
+	struct kobject *kobj = &channel->kobj;
+
+	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
+	channel->ring_sysfs_visible = true;
+	return sysfs_update_group(kobj, &vmbus_chan_group);
+}
+EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
+
+/*
+ * hv_remove_ring_sysfs - remove ring sysfs entry corresponding to ring buffers for a channel
+ */
+int hv_remove_ring_sysfs(struct vmbus_channel *channel)
+{
+	struct kobject *kobj = &channel->kobj;
+	int ret;
+
+	channel->ring_sysfs_visible = false;
+	ret = sysfs_update_group(kobj, &vmbus_chan_group);
+	channel->mmap_ring_buffer = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_remove_ring_sysfs);
+
 /*
  * vmbus_add_channel_kobj - setup a sub-directory under device/channels
  */
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 1b19b5647495..a398e93ed382 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -131,15 +131,12 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 	vmbus_device_unregister(channel->device_obj);
 }
 
-/* Sysfs API to allow mmap of the ring buffers
+/* Function used for mmap of ring buffer sysfs interface.
  * The ring buffer is allocated as contiguous memory by vmbus_open
  */
-static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
-			    const struct bin_attribute *attr,
-			    struct vm_area_struct *vma)
+static int
+hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
 {
-	struct vmbus_channel *channel
-		= container_of(kobj, struct vmbus_channel, kobj);
 	void *ring_buffer = page_address(channel->ringbuffer_page);
 
 	if (channel->state != CHANNEL_OPENED_STATE)
@@ -149,15 +146,6 @@ static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
 			       channel->ringbuffer_pagecount << PAGE_SHIFT);
 }
 
-static const struct bin_attribute ring_buffer_bin_attr = {
-	.attr = {
-		.name = "ring",
-		.mode = 0600,
-	},
-	.size = 2 * SZ_2M,
-	.mmap = hv_uio_ring_mmap,
-};
-
 /* Callback from VMBUS subsystem when new channel created. */
 static void
 hv_uio_new_channel(struct vmbus_channel *new_sc)
@@ -178,8 +166,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 	/* Disable interrupts on sub channel */
 	new_sc->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
-
-	ret = sysfs_create_bin_file(&new_sc->kobj, &ring_buffer_bin_attr);
+	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
 	if (ret) {
 		dev_err(device, "sysfs create ring bin file failed; %d\n", ret);
 		vmbus_close(new_sc);
@@ -350,10 +337,12 @@ hv_uio_probe(struct hv_device *dev,
 		goto fail_close;
 	}
 
-	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
-	if (ret)
-		dev_notice(&dev->device,
-			   "sysfs create ring bin file failed; %d\n", ret);
+	/*
+	 * This internally calls sysfs_update_group, which returns a non-zero value if it executes
+	 * before sysfs_create_group. This is a false alarm from this use case point of view and
+	 * thus, no need to check the return value and print warning.
+	 */
+	hv_create_ring_sysfs(channel, hv_uio_ring_mmap);
 
 	hv_set_drvdata(dev, pdata);
 
@@ -375,7 +364,7 @@ hv_uio_remove(struct hv_device *dev)
 	if (!pdata)
 		return;
 
-	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
+	hv_remove_ring_sysfs(dev->channel);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 675959fb97ba..d6ffe01962c2 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1002,6 +1002,12 @@ struct vmbus_channel {
 
 	/* The max size of a packet on this channel */
 	u32 max_pkt_size;
+
+	/* function to mmap ring buffer memory to the channel's sysfs ring attribute */
+	int (*mmap_ring_buffer)(struct vmbus_channel *channel, struct vm_area_struct *vma);
+
+	/* boolean to control visibility of sysfs for ring buffer */
+	bool ring_sysfs_visible;
 };
 
 #define lock_requestor(channel, flags)					\

base-commit: e94bd4ec45ac156616da285a0bf03056cd7430fc
-- 
2.34.1


