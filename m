Return-Path: <linux-hyperv+bounces-10104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL+CK8gf2GlaYAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10104-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 23:53:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB03D00A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 23:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF9B030297BE
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2026 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B97375ACB;
	Thu,  9 Apr 2026 21:52:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299CD37C0FE;
	Thu,  9 Apr 2026 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771571; cv=none; b=F5X9wga9rlBQCGFT2b+0NK89dKFaKMfnEyhYTA2A/l3OQk5pYJL7CM0HebYQuGJo38xQR5EcLLABMSPstnVfR0+rjD8Ah1c/Njjl9A2C6Z3Q2FJlLyUOWmeuhfLv/nIJNfrP5Ik6QDstpWOdPvtOBx19MZ0ncPcQ6vyT/Vp0CEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771571; c=relaxed/simple;
	bh=tFfRzLm4MwVx6uT8622X3ap+XCSlK+8946afWlhqItQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pT2AnsvUy5S3mACPF/Gun3qwheDcKdbMLJUtRTYrc7oz7brwB/yZ3o8gUCgDDr0zOeAKdHYwALNmb5KZK5/CRj1ygYG2nEd3hhFq6uXG2D9bm5kCe2duP5oYzjFckEWiX9si62L1buMOsqtoT8bxiD/Mz/rhoQgI4iMu8Sw7RDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id EA39620B7129; Thu,  9 Apr 2026 14:52:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA39620B7129
From: Dexuan Cui <decui@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mukesh Rathor <mrathor@linux.microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Export hv_vmbus_exists() and use it in pci-hyperv
Date: Thu,  9 Apr 2026 14:52:32 -0700
Message-ID: <20260409215232.399350-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10104-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28FB03D00A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With commit f84b21da3624 ("PCI: hv: Don't load the driver for baremetal root partition"),
the bare metal Linux root partition won't use the pci-hyperv driver, but
when a Linux VM runs on the Linux root partition, pci-hyperv's module_init
function init_hv_pci_drv() can still run, e.g. in the case of
CONFIG_PCI_HYPERV=y, even if the VMBus driver is not used in such a VM
(i.e. the hv_vmbus driver's init function returns -ENODEV due to
vmbus_root_device being NULL).

In such a Linux VM, init_hv_pci_drv() runs with a side effect: the 3
hvpci_block_ops callbacks are set to functions that depend on hv_vmbus.

Later, when the MLX driver in such a VM invokes the callbacks, e.g. in
drivers/net/ethernet/mellanox/mlx5/core/lib/hv.c:
mlx5_hv_register_invalidate(), hvpci_block_ops.reg_blk_invalidate() is
hv_register_block_invalidate() rather than a NULL function pointer, and
hv_register_block_invalidate() assumes that it can find a struct
hv_pcibus_device from pdev->bus->sysdata, which is false in such a VM.

Consequently, hv_register_block_invalidate() -> get_pcichild_wslot() ->
spin_lock_irqsave() may hang since it can be accessing an invalid
spinlock pointer.

Fix the issue by exporting hv_vmbus_exists() and using it in pci-hyperv:

    hv_root_partition() is true and hv_nested is false ==>
	hv_vmbus_exists() is false.

    hv_root_partition() is true and hv_nested is true ==>
	hv_vmbus_exists() is true.

    hv_root_partition() is false ==> hv_vmbus_exists() is true.

While at it, rename vmbus_exists() to hv_vmbus_exists() to follow the
convention that all public functions have the hv_ prefix; also change
the return value's type from int to bool to make the code more readable;
also move the two pr_info() calls.

Reported-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c              | 20 ++++++++------------
 drivers/pci/controller/pci-hyperv.c |  2 +-
 include/linux/hyperv.h              |  2 ++
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..2c8936efc8d1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -101,13 +101,11 @@ struct device *hv_get_vmbus_root_device(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_vmbus_root_device);
 
-static int vmbus_exists(void)
+bool hv_vmbus_exists(void)
 {
-	if (vmbus_root_device == NULL)
-		return -ENODEV;
-
-	return 0;
+	return vmbus_root_device != NULL;
 }
+EXPORT_SYMBOL_GPL(hv_vmbus_exists);
 
 static u8 channel_monitor_group(const struct vmbus_channel *channel)
 {
@@ -1582,11 +1580,10 @@ int __vmbus_driver_register(struct hv_driver *hv_driver, struct module *owner, c
 {
 	int ret;
 
-	pr_info("registering driver %s\n", hv_driver->name);
+	if (!hv_vmbus_exists())
+		return -ENODEV;
 
-	ret = vmbus_exists();
-	if (ret < 0)
-		return ret;
+	pr_info("registering driver %s\n", hv_driver->name);
 
 	hv_driver->driver.name = hv_driver->name;
 	hv_driver->driver.owner = owner;
@@ -1612,9 +1609,8 @@ EXPORT_SYMBOL_GPL(__vmbus_driver_register);
  */
 void vmbus_driver_unregister(struct hv_driver *hv_driver)
 {
-	pr_info("unregistering driver %s\n", hv_driver->name);
-
-	if (!vmbus_exists()) {
+	if (hv_vmbus_exists()) {
+		pr_info("unregistering driver %s\n", hv_driver->name);
 		driver_unregister(&hv_driver->driver);
 		vmbus_free_dynids(hv_driver);
 	}
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2c7a406b4ba8..226b8bb802f3 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -4166,7 +4166,7 @@ static int __init init_hv_pci_drv(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
-	if (hv_root_partition() && !hv_nested)
+	if (!hv_vmbus_exists())
 		return -ENODEV;
 
 	ret = hv_pci_irqchip_init();
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dfc516c1c719..5459e776ec17 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1304,6 +1304,8 @@ static inline void *hv_get_drvdata(struct hv_device *dev)
 
 struct device *hv_get_vmbus_root_device(void);
 
+bool hv_vmbus_exists(void);
+
 struct hv_ring_buffer_debug_info {
 	u32 current_interrupt_mask;
 	u32 current_read_index;
-- 
2.43.0


