Return-Path: <linux-hyperv+bounces-10780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF9BCC2LAmrVtwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10780-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:06:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDF518A84
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A2E1307938E
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB02FFDE1;
	Tue, 12 May 2026 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I0IIYF7n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8042FD1A5;
	Tue, 12 May 2026 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551411; cv=none; b=a5EltR7R4UNnBkOLm3/3rk3BEuFAXb/Y8qlwpHu4F6K25PptBvBErctfJjxcfzYQ0kSZ7DQrWDiGCr3E7a06Y9aUVJRJmhWKtEcNhPe0H2CyoMlYR1I7q0JW0XFBuSCBlZEp/Gm9qWevD8FwoQ3C/3drtQQFe2DljWqxhzHvLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551411; c=relaxed/simple;
	bh=4mr06T6EP6Cpty4TcmvEjQixPyKShwLmUzz2L06IFus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny1jWSrjiqdD6Hwcy7uGXduxvwIYENV2dAwUYArm4FirJGIzyRp4uajcqh371YKntRV5V8/pulM/L3spuqo6EgK5hhy8mh+3H25SYZgeWYOE04ppUpYWYzp2d8Q3CGA5fzWDwh6WwH067utU4mDn+DUqSo+/6CgD8O6Fpm/NXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I0IIYF7n; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 42CED20B7166;
	Mon, 11 May 2026 19:03:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42CED20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778551406;
	bh=yuGixt0awDexRy+9+alMff9Qjikz5NAcYVaGls9X8wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0IIYF7ntphGCElNlEKFw9xWXzJMyDwZpLbG8CpaqExl8xhO8TICDV8ytz7AuWcFD
	 u3tqX8k5zXoCQHkpZ98sC3N5PSZo1bqO9VlzqvuGa629tFAhviO+6d8ZggchNsF0A5
	 R5BMMP1UeVJjj4Rd6nGqKedAlqZMVntHeM1M/be4=
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
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V3 08/11] PCI: hv: VMBus and PCI device IDs for PCI passthru
Date: Mon, 11 May 2026 19:02:56 -0700
Message-ID: <20260512020259.1678627-9-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 81EDF518A84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10780-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
interrupts, etc need a device ID as a parameter. This device ID refers
to that specific device during the lifetime of passthru.

An L1VH VM only contains VMBus based devices. A device ID for a VMBus
device is slightly different in that it uses the hv_pcibus_device info
for building it to make sure it matches exactly what the hypervisor
expects. This VMBus based device ID is needed when attaching devices in
an L1VH based guest VM. Add a function to build and export it. Before
building it, a check is done to make sure the device is a valid VMBus
device.

In remaining cases, PCI device ID is used. So, also make PCI device ID
build function hv_build_devid_type_pci() public.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c         |  9 +++++----
 arch/x86/include/asm/mshyperv.h     |  6 ++++++
 drivers/pci/controller/pci-hyperv.c | 24 ++++++++++++++++++++++++
 include/asm-generic/mshyperv.h      | 11 +++++++++++
 4 files changed, 46 insertions(+), 4 deletions(-)

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
index f64393e853ee..2ef34001f8d3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -248,6 +248,12 @@ void hv_crash_asm_end(void);
 static inline void hv_root_crash_init(void) {}
 #endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
 
+#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
+u64 hv_build_devid_type_pci(struct pci_dev *pdev);
+#else
+static inline u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return 0; }
+#endif /* IS_ENABLED(CONFIG_HYPERV_IOMMU) */
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
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
index e8cbc4e3f7ad..25ac7ca0fd8b 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -204,6 +204,9 @@ extern u64 (*hv_read_reference_counter)(void);
 /* Sentinel value for an uninitialized entry in hv_vp_index array */
 #define VP_INVAL	U32_MAX
 
+/* Forward declarations */
+struct pci_dev;
+
 int __init hv_common_init(void);
 void __init hv_get_partition_id(void);
 void __init hv_common_free(void);
@@ -316,6 +319,14 @@ void hv_para_set_synic_register(unsigned int reg, u64 val);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
+
+#if IS_ENABLED(CONFIG_PCI_HYPERV)
+u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
+#else
+static inline u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
+{ return 0; }
+#endif /* IS_ENABLED(CONFIG_PCI_HYPERV) */
+
 #else /* CONFIG_HYPERV */
 static inline void hv_identify_partition_type(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
-- 
2.51.2.vfs.0.1


