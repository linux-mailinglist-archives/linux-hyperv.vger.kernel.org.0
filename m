Return-Path: <linux-hyperv+bounces-10303-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GIHCcU06Gk6GwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10303-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:39:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94244187D
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28F56309565A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9538A706;
	Wed, 22 Apr 2026 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Pc0TBr6d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F438737F;
	Wed, 22 Apr 2026 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825244; cv=none; b=bdlkaatiBgs1X0SuKsjs6nJO4S3d5Ke7ky8iWs/PCR7y/im9AktI7ATXgKEPdgniGvgC07v0uXupIbzmdBSiR59TuPS0tFphwmcoM7x+xUpriw9QlW2z+MYbYl7dTcOaHHLdFvN3+p6EuZhBCXSuOFbIGw0toucFi3pJUDHsfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825244; c=relaxed/simple;
	bh=3p+UYzYAVK6Oc1T3Ui1NuwCE4yM8MDdRlrXl61kkDDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrNBcvrSWcmI5ejHh0qN+42OOBIdPjWI1BVOT5HvQR+5VS8I7dofSSW+5x9sdKB+UuLefOqeoGOOgIbxJxWZQGAu5GpAGIkElfBoMXaUME3AIRqAoMJ71eEBQjeRH2AvFDffjaMcacbdSR/RbcWsXEisVfxl3DMXANGR7SPqnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Pc0TBr6d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D62C20B6F01;
	Tue, 21 Apr 2026 19:33:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D62C20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825228;
	bh=o6ztznKN0i+oDxkVKgM3YRDnCNaOjwDWRVoXxAfAsww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pc0TBr6dRCkXuecEpzOQW9DZK1BlT8DoPhItNDPwLPiilJpMdJ46A+h4qz0zVtPMs
	 m7eaU3/0fYsOx5Fo+aJzdGgMUH4F5VTXRLhFPExrpYpbyDUWJi3Wxr8+M1gkoHtj6O
	 /TaNasCwXiWRoz8aGA8N8ODVTgf6l41putV/KTAA=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Subject: [PATCH V1 08/13] PCI: hv: rename hv_compose_msi_msg to hv_vmbus_compose_msi_msg
Date: Tue, 21 Apr 2026 19:32:34 -0700
Message-ID: <20260422023239.1171963-9-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10303-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9A94244187D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Main change here is to rename hv_compose_msi_msg to
hv_vmbus_compose_msi_msg as we introduce hv_compose_msi_msg in upcoming
patches that builds MSI messages for both VMBus and non-VMBus cases. VMBus
is not used on baremetal root partition for example. While at it, replace
spaces with tabs and fix some formatting involving excessive line wraps.

There is no functional change.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 95 +++++++++++++++--------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..ed6b399afc80 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -30,7 +30,7 @@
  * function's configuration space is zero.
  *
  * The rest of this driver mostly maps PCI concepts onto underlying Hyper-V
- * facilities.  For instance, the configuration space of a function exposed
+ * facilities.	For instance, the configuration space of a function exposed
  * by Hyper-V is mapped into a single page of memory space, and the
  * read and write handlers for config space must be aware of this mechanism.
  * Similarly, device setup and teardown involves messages sent to and from
@@ -109,33 +109,33 @@ enum pci_message_type {
 	/*
 	 * Version 1.1
 	 */
-	PCI_MESSAGE_BASE                = 0x42490000,
-	PCI_BUS_RELATIONS               = PCI_MESSAGE_BASE + 0,
-	PCI_QUERY_BUS_RELATIONS         = PCI_MESSAGE_BASE + 1,
-	PCI_POWER_STATE_CHANGE          = PCI_MESSAGE_BASE + 4,
+	PCI_MESSAGE_BASE		= 0x42490000,
+	PCI_BUS_RELATIONS		= PCI_MESSAGE_BASE + 0,
+	PCI_QUERY_BUS_RELATIONS		= PCI_MESSAGE_BASE + 1,
+	PCI_POWER_STATE_CHANGE		= PCI_MESSAGE_BASE + 4,
 	PCI_QUERY_RESOURCE_REQUIREMENTS = PCI_MESSAGE_BASE + 5,
-	PCI_QUERY_RESOURCE_RESOURCES    = PCI_MESSAGE_BASE + 6,
-	PCI_BUS_D0ENTRY                 = PCI_MESSAGE_BASE + 7,
-	PCI_BUS_D0EXIT                  = PCI_MESSAGE_BASE + 8,
-	PCI_READ_BLOCK                  = PCI_MESSAGE_BASE + 9,
-	PCI_WRITE_BLOCK                 = PCI_MESSAGE_BASE + 0xA,
-	PCI_EJECT                       = PCI_MESSAGE_BASE + 0xB,
-	PCI_QUERY_STOP                  = PCI_MESSAGE_BASE + 0xC,
-	PCI_REENABLE                    = PCI_MESSAGE_BASE + 0xD,
-	PCI_QUERY_STOP_FAILED           = PCI_MESSAGE_BASE + 0xE,
-	PCI_EJECTION_COMPLETE           = PCI_MESSAGE_BASE + 0xF,
-	PCI_RESOURCES_ASSIGNED          = PCI_MESSAGE_BASE + 0x10,
-	PCI_RESOURCES_RELEASED          = PCI_MESSAGE_BASE + 0x11,
-	PCI_INVALIDATE_BLOCK            = PCI_MESSAGE_BASE + 0x12,
-	PCI_QUERY_PROTOCOL_VERSION      = PCI_MESSAGE_BASE + 0x13,
-	PCI_CREATE_INTERRUPT_MESSAGE    = PCI_MESSAGE_BASE + 0x14,
-	PCI_DELETE_INTERRUPT_MESSAGE    = PCI_MESSAGE_BASE + 0x15,
+	PCI_QUERY_RESOURCE_RESOURCES	= PCI_MESSAGE_BASE + 6,
+	PCI_BUS_D0ENTRY			= PCI_MESSAGE_BASE + 7,
+	PCI_BUS_D0EXIT			= PCI_MESSAGE_BASE + 8,
+	PCI_READ_BLOCK			= PCI_MESSAGE_BASE + 9,
+	PCI_WRITE_BLOCK			= PCI_MESSAGE_BASE + 0xA,
+	PCI_EJECT			= PCI_MESSAGE_BASE + 0xB,
+	PCI_QUERY_STOP			= PCI_MESSAGE_BASE + 0xC,
+	PCI_REENABLE			= PCI_MESSAGE_BASE + 0xD,
+	PCI_QUERY_STOP_FAILED		= PCI_MESSAGE_BASE + 0xE,
+	PCI_EJECTION_COMPLETE		= PCI_MESSAGE_BASE + 0xF,
+	PCI_RESOURCES_ASSIGNED		= PCI_MESSAGE_BASE + 0x10,
+	PCI_RESOURCES_RELEASED		= PCI_MESSAGE_BASE + 0x11,
+	PCI_INVALIDATE_BLOCK		= PCI_MESSAGE_BASE + 0x12,
+	PCI_QUERY_PROTOCOL_VERSION	= PCI_MESSAGE_BASE + 0x13,
+	PCI_CREATE_INTERRUPT_MESSAGE	= PCI_MESSAGE_BASE + 0x14,
+	PCI_DELETE_INTERRUPT_MESSAGE	= PCI_MESSAGE_BASE + 0x15,
 	PCI_RESOURCES_ASSIGNED2		= PCI_MESSAGE_BASE + 0x16,
 	PCI_CREATE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x17,
 	PCI_DELETE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x18, /* unused */
 	PCI_BUS_RELATIONS2		= PCI_MESSAGE_BASE + 0x19,
-	PCI_RESOURCES_ASSIGNED3         = PCI_MESSAGE_BASE + 0x1A,
-	PCI_CREATE_INTERRUPT_MESSAGE3   = PCI_MESSAGE_BASE + 0x1B,
+	PCI_RESOURCES_ASSIGNED3		= PCI_MESSAGE_BASE + 0x1A,
+	PCI_CREATE_INTERRUPT_MESSAGE3	= PCI_MESSAGE_BASE + 0x1B,
 	PCI_MESSAGE_MAXIMUM
 };
 
@@ -1774,20 +1774,21 @@ static u32 hv_compose_msi_req_v1(
  * via the HVCALL_RETARGET_INTERRUPT hypercall. But the choice of dummy vCPU is
  * not irrelevant because Hyper-V chooses the physical CPU to handle the
  * interrupts based on the vCPU specified in message sent to the vPCI VSP in
- * hv_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the guest,
- * but assigning too many vPCI device interrupts to the same pCPU can cause a
- * performance bottleneck. So we spread out the dummy vCPUs to influence Hyper-V
- * to spread out the pCPUs that it selects.
+ * hv_vmbus_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the
+ * guest, but assigning too many vPCI device interrupts to the same pCPU can
+ * cause a performance bottleneck. So we spread out the dummy vCPUs to influence
+ * Hyper-V to spread out the pCPUs that it selects.
  *
  * For the single-MSI and MSI-X cases, it's OK for hv_compose_msi_req_get_cpu()
  * to always return the same dummy vCPU, because a second call to
- * hv_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to choose a
- * new pCPU for the interrupt. But for the multi-MSI case, the second call to
- * hv_compose_msi_msg() exits without sending a message to the vPCI VSP, so the
- * original dummy vCPU is used. This dummy vCPU must be round-robin'ed so that
- * the pCPUs are spread out. All interrupts for a multi-MSI device end up using
- * the same pCPU, even though the vCPUs will be spread out by later calls
- * to hv_irq_unmask(), but that is the best we can do now.
+ * hv_vmbus_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to
+ * choose a new pCPU for the interrupt. But for the multi-MSI case, the second
+ * call to hv_vmbus_compose_msi_msg() exits without sending a message to the
+ * vPCI VSP, so the original dummy vCPU is used. This dummy vCPU must be
+ * round-robin'ed so that the pCPUs are spread out. All interrupts for a
+ * multi-MSI device end up using the same pCPU, even though the vCPUs will be
+ * spread out by later calls to hv_irq_unmask(), but that is the best we can do
+ * now.
  *
  * With Hyper-V in Nov 2022, the HVCALL_RETARGET_INTERRUPT hypercall does *not*
  * cause Hyper-V to reselect the pCPU based on the specified vCPU. Such an
@@ -1862,7 +1863,7 @@ static u32 hv_compose_msi_req_v3(
 }
 
 /**
- * hv_compose_msi_msg() - Supplies a valid MSI address/data
+ * hv_vmbus_compose_msi_msg() - Supplies a valid MSI address/data
  * @data:	Everything about this MSI
  * @msg:	Buffer that is filled in by this function
  *
@@ -1872,7 +1873,7 @@ static u32 hv_compose_msi_req_v3(
  * response supplies a data value and address to which that data
  * should be written to trigger that interrupt.
  */
-static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void hv_vmbus_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct hv_pcibus_device *hbus;
 	struct vmbus_channel *channel;
@@ -1954,7 +1955,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 			return;
 		}
 		/*
-		 * The vector we select here is a dummy value.  The correct
+		 * The vector we select here is a dummy value.	The correct
 		 * value gets sent to the hypervisor in unmask().  This needs
 		 * to be aligned with the count, and also not zero.  Multi-msi
 		 * is powers of 2 up to 32, so 32 will always work here.
@@ -2046,7 +2047,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 		/*
 		 * Make sure that the ring buffer data structure doesn't get
-		 * freed while we dereference the ring buffer pointer.  Test
+		 * freed while we dereference the ring buffer pointer.	Test
 		 * for the channel's onchannel_callback being NULL within a
 		 * sched_lock critical section.  See also the inline comments
 		 * in vmbus_reset_channel_cb().
@@ -2146,7 +2147,7 @@ static const struct msi_parent_ops hv_pcie_msi_parent_ops = {
 /* HW Interrupt Chip Descriptor */
 static struct irq_chip hv_msi_irq_chip = {
 	.name			= "Hyper-V PCIe MSI",
-	.irq_compose_msi_msg	= hv_compose_msi_msg,
+	.irq_compose_msi_msg	= hv_vmbus_compose_msi_msg,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
@@ -2158,8 +2159,8 @@ static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq, unsigne
 			       void *arg)
 {
 	/*
-	 * TODO: Allocating and populating struct tran_int_desc in hv_compose_msi_msg()
-	 * should be moved here.
+	 * TODO: Allocating and populating struct tran_int_desc in
+	 *	 hv_vmbus_compose_msi_msg() should be moved here.
 	 */
 	int ret;
 
@@ -2226,7 +2227,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
 /**
  * get_bar_size() - Get the address space consumed by a BAR
  * @bar_val:	Value that a BAR returned after -1 was written
- *              to it.
+ *		to it.
  *
  * This function returns the size of the BAR, rounded up to 1
  * page.  It has to be rounded up because the hypervisor's page
@@ -2580,7 +2581,7 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
  * new_pcichild_device() - Create a new child device
  * @hbus:	The internal struct tracking this root PCI bus.
  * @desc:	The information supplied so far from the host
- *              about the device.
+ *		about the device.
  *
  * This function creates the tracking structure for a new child
  * device and kicks off the process of figuring out what it is.
@@ -3105,7 +3106,7 @@ static void hv_pci_onchannelcallback(void *context)
 			 * sure that the packet pointer is still valid during the call:
 			 * here 'valid' means that there's a task still waiting for the
 			 * completion, and that the packet data is still on the waiting
-			 * task's stack.  Cf. hv_compose_msi_msg().
+			 * task's stack.  Cf. hv_vmbus_compose_msi_msg().
 			 */
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
@@ -3422,7 +3423,7 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
 	 * vmbus_allocate_mmio() gets used for allocating both device endpoint
 	 * resource claims (those which cannot be overlapped) and the ranges
 	 * which are valid for the children of this bus, which are intended
-	 * to be overlapped by those children.  Set the flag on this claim
+	 * to be overlapped by those children.	Set the flag on this claim
 	 * meaning that this region can't be overlapped.
 	 */
 
@@ -4069,7 +4070,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 		irq_data = irq_get_irq_data(entry->irq);
 		if (WARN_ON_ONCE(!irq_data))
 			return -EINVAL;
-		hv_compose_msi_msg(irq_data, &entry->msg);
+		hv_vmbus_compose_msi_msg(irq_data, &entry->msg);
 	}
 	return 0;
 }
@@ -4077,7 +4078,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 /*
  * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg()
  * directly writes the MSI/MSI-X registers via MMIO, but since Hyper-V
- * doesn't trap and emulate the MMIO accesses, here hv_compose_msi_msg()
+ * doesn't trap and emulate the MMIO accesses, here hv_vmbus_compose_msi_msg()
  * must be used to ask Hyper-V to re-create the IOMMU Interrupt Remapping
  * Table entries.
  */
-- 
2.51.2.vfs.0.1


