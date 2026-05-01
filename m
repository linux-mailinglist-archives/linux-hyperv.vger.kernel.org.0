Return-Path: <linux-hyperv+bounces-10537-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD4eJUH382kC9QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10537-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:43:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F24A94D6
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 02:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D2B73012B74
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6D52E6CA8;
	Fri,  1 May 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K3UGl4tS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CEF286881;
	Fri,  1 May 2026 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596144; cv=none; b=oInLzuKiJmpnn3iRGrnLXxUBWvTVDUGlgYC8c4qMEXUpzFlUojT/3nlvRsQbp7GNxsHgbwfLoptumJYVsy52Oqy9H838JvTvvdtEJ/MooN09rAZFWz/xgKHM387yRxiEs9MtKWnWmLmPztHhYxpVVkS3DlTDUoaTu7IXS0FgvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596144; c=relaxed/simple;
	bh=qaurpRd8Y2igcv7snLsj0uGGPBOguOYIkeyt5vMtkvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9YmnvY4rv44onbidEO52pUOwx6gtzB39GxwuEOraUP0fPCxCsydVIAVwDHkJyCpGQEBvAYWd4e48wQGM4ORZeahr+U/DsHOG8fi+4aKCk/1Qv8SrX/l26ZsD3EapHOSInvQ16lutHVVjqFxoQDSQxVgjATDW6Fcf7iIFZmPENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K3UGl4tS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 994D220B7167;
	Thu, 30 Apr 2026 17:42:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 994D220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777596141;
	bh=aBz7LjJu5NDw3Qs+wKs6ePt7vFQDMj33A9lKJKqgo80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3UGl4tSOrF5961qTUw0A4+YYkSgTeO9mRByOjLn0hD3oAudCRPjHdudBlDrJ7sTH
	 1Utr3VC+vLT7fK0fqPBxjwFj9cQUglz78Ac+NyWVy3gxa9WNJSBVDimXrSc4lHzpZJ
	 5U4CxiuWbxGGN4r/BdfhYEQUCNJZGYnEplg6nbcQ=
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
Subject: [PATCH V2 08/11] PCI: hv: Build device id for a VMBus device, export PCI devid function
Date: Thu, 30 Apr 2026 17:41:54 -0700
Message-ID: <20260501004157.3108202-9-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
References: <20260501004157.3108202-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 327F24A94D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10537-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
interrupts, etc need a device ID as a parameter. This device ID refers
to that specific device during the lifetime of passthru.

An L1VH VM only contains VMBus based devices. A device ID for a VMBus
device is slightly different in that it uses the hv_pcibus_device info
for building it to make sure it matches exactly what the hypervisor
expects. This VMBus based device ID is needed when attaching devices in
an L1VH based guest VM. Before building it, a check is done to make sure
the device is a valid VMBus device.

In remaining cases, PCI device ID is used. So, also make PCI device ID
build function hv_build_devid_type_pci() public.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c         |  9 +++++----
 arch/x86/include/asm/mshyperv.h     |  6 ++++++
 drivers/pci/controller/pci-hyperv.c | 24 ++++++++++++++++++++++++
 include/asm-generic/mshyperv.h      |  8 ++++++++
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index b3ad50a874dc..8780573a4332 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -112,7 +112,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
+u64 hv_build_devid_type_pci(struct pci_dev *pdev)
 {
 	int pos;
 	union hv_device_id hv_devid;
@@ -172,8 +172,9 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
 	}
 
 out:
-	return hv_devid;
+	return hv_devid.as_uint64;
 }
+EXPORT_SYMBOL_GPL(hv_build_devid_type_pci);
 
 /*
  * hv_map_msi_interrupt() - Map the MSI IRQ in the hypervisor.
@@ -196,7 +197,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
 
 	msidesc = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msidesc);
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
 	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
@@ -271,7 +272,7 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
 {
 	union hv_device_id hv_devid;
 
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f64393e853ee..9d24cafed657 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -271,6 +271,12 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
 static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
+u64 hv_build_devid_type_pci(struct pci_dev *pdev);
+#else
+u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return 0; }
+#endif /* IS_ENABLED(CONFIG_HYPERV_IOMMU) */
+
 struct mshv_vtl_cpu_context {
 	union {
 		struct {
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfc8fa403dad..50d793ca8f31 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -573,6 +573,7 @@ struct hv_pci_compl {
 };
 
 static void hv_pci_onchannelcallback(void *context);
+static bool hv_vmbus_pci_device(struct pci_bus *pbus);
 
 #ifdef CONFIG_X86
 #define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
@@ -1005,6 +1006,24 @@ static struct irq_domain *hv_pci_get_root_domain(void)
 static void hv_arch_irq_unmask(struct irq_data *data) { }
 #endif /* CONFIG_ARM64 */
 
+u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
+{
+	struct hv_pcibus_device *hbus;
+	struct pci_bus *pbus = pdev->bus;
+
+	if (!hv_vmbus_pci_device(pbus))
+		return 0;
+
+	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
+
+	return	(hbus->hdev->dev_instance.b[5] << 24) |
+		(hbus->hdev->dev_instance.b[4] << 16) |
+		(hbus->hdev->dev_instance.b[7] << 8) |
+		(hbus->hdev->dev_instance.b[6] & 0xf8) |
+		PCI_FUNC(pdev->devfn);
+}
+EXPORT_SYMBOL_GPL(hv_pci_vmbus_device_id);
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -1403,6 +1422,11 @@ static struct pci_ops hv_pcifront_ops = {
 	.write = hv_pcifront_write_config,
 };
 
+static bool hv_vmbus_pci_device(struct pci_bus *pbus)
+{
+	return pbus->ops == &hv_pcifront_ops;
+}
+
 /*
  * Paravirtual backchannel
  *
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index e8cbc4e3f7ad..a6878ab685e7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -23,6 +23,7 @@
 #include <acpi/acpi_numa.h>
 #include <linux/cpumask.h>
 #include <linux/nmi.h>
+#include <linux/pci.h>
 #include <asm/ptrace.h>
 #include <hyperv/hvhdk.h>
 
@@ -329,6 +330,13 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
 }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_PCI_HYPERV)
+u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
+#else
+static inline u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
+{ return 0; }
+#endif /* IS_ENABLED(CONFIG_PCI_HYPERV) */
+
 #if IS_ENABLED(CONFIG_MSHV_ROOT)
 static inline bool hv_root_partition(void)
 {
-- 
2.51.2.vfs.0.1


