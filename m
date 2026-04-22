Return-Path: <linux-hyperv+bounces-10304-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Lm5Dwk36GkbHAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10304-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:48:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BC4419BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 04:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B964B30AB45A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 02:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242138F92E;
	Wed, 22 Apr 2026 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ic1yo5q3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC7383C78;
	Wed, 22 Apr 2026 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825253; cv=none; b=oIlZFYsFIShaO5roZr5r6mhp16S+/hWb/fCRYXmZgYk8iuxRrtPFfQ5ZxvyExBmCBJoSo24YNcy4d3i3j4rWGnQAoYxrhstSoZVTZUS2TrZsMA/+qt6j9GVnkffUolVA5zI2JXkgaqtqPYDJSibSxlesuRtLg+UfxbvXwT2pA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825253; c=relaxed/simple;
	bh=/Lw+KcSgHoHzffRnhyMXmnV0XRzyqvf5vEVQCn2n6FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVC760ZKSE0i22YCsCDqrjzT8ZJpmQyPe0XFxWmVlsstHs9mLq2iZBvSIM3I2xkB0wi4ECROGJ5MvoLTtgWxXLpm9Nt/B9T7Kv9dCxGjyJi9niDEIyzj3WJonxIU8ohTft/D3fkMrtNi4G6MfEV3CN8wwWT94YlhAOV7E+KbEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ic1yo5q3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4179320B6F22;
	Tue, 21 Apr 2026 19:33:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4179320B6F22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825231;
	bh=gW30GO/QQW7nzaJ7Yfwf+7LrHlL5wIbU4fBiOZJvGkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ic1yo5q3LYqOj6CnC5HptX8+MMhLYozrXi4UCdgjcq6buP3vSBaLinIDDMLVshfP6
	 CvEOskA5omxJw3fPoBPqwFFgnaHHNWpdi/V0GU4w8DMm9dy88Dzw+z1L5QFx4h7vfS
	 AKa7sd938DsJ/ipTBUDb9aIMj1Sr1zH2tafiVPNk=
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
Subject: [PATCH V1 10/13] PCI: hv: Build device id for a VMBus device, export PCI devid function
Date: Tue, 21 Apr 2026 19:32:36 -0700
Message-ID: <20260422023239.1171963-11-mrathor@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zytor.com,arm.com,kernel.org,linux.microsoft.com,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-10304-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: D24BC4419BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
interrupts, etc need a device id as a parameter. This device id refers
to that specific device during the lifetime of passthru.

An L1VH VM only contains VMBus based devices. A device id for a VMBus
device is slightly different in that it uses the hv_pcibus_device info
for building it to make sure it matches exactly what the hypervisor
expects. This VMBus based device id is needed when attaching devices in
an L1VH based guest VM. Before building it, a check is done to make sure
the device is a valid VMBus device.

In remaining cases, PCI device id is used. So, also make pci device
id build function public.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c         |  9 +++++----
 arch/x86/include/asm/mshyperv.h     |  4 ++++
 drivers/pci/controller/pci-hyperv.c | 25 +++++++++++++++++++++++++
 include/asm-generic/mshyperv.h      |  7 +++++++
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 229f986e08ea..527835b99a70 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -137,7 +137,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
+u64 hv_build_devid_type_pci(struct pci_dev *pdev)
 {
 	int pos;
 	union hv_device_id hv_devid;
@@ -197,8 +197,9 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
 	}
 
 out:
-	return hv_devid;
+	return hv_devid.as_uint64;
 }
+EXPORT_SYMBOL_GPL(hv_build_devid_type_pci);
 
 /*
  * hv_map_msi_interrupt() - Map the MSI IRQ in the hypervisor.
@@ -221,7 +222,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
 
 	msidesc = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msidesc);
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
 	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
@@ -296,7 +297,7 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
 {
 	union hv_device_id hv_devid;
 
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f64393e853ee..039e8a986be3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -271,6 +271,10 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
 static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
+u64 hv_build_devid_type_pci(struct pci_dev *pdev);
+#endif /* IS_ENABLED(CONFIG_HYPERV_IOMMU) */
+
 struct mshv_vtl_cpu_context {
 	union {
 		struct {
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ed6b399afc80..8f6b818ee09b 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -578,6 +578,8 @@ static void hv_pci_onchannelcallback(void *context);
 #define DELIVERY_MODE		APIC_DELIVERY_MODE_FIXED
 #define HV_MSI_CHIP_FLAGS	MSI_CHIP_FLAG_SET_ACK
 
+static bool hv_vmbus_pci_device(struct pci_bus *pbus);
+
 static int hv_pci_irqchip_init(void)
 {
 	return 0;
@@ -1005,6 +1007,24 @@ static struct irq_domain *hv_pci_get_root_domain(void)
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
@@ -1403,6 +1423,11 @@ static struct pci_ops hv_pcifront_ops = {
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
index e8cbc4e3f7ad..fe5ddd1c43ff 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -329,6 +329,13 @@ static inline enum hv_isolation_type hv_get_isolation_type(void)
 }
 #endif /* CONFIG_HYPERV */
 
+#if IS_ENABLED(CONFIG_PCI_HYPERV)
+u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
+#else   /* IS_ENABLED(CONFIG_PCI_HYPERV) */
+static inline u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
+{ return 0; }
+#endif /* IS_ENABLED(CONFIG_PCI_HYPERV) */
+
 #if IS_ENABLED(CONFIG_MSHV_ROOT)
 static inline bool hv_root_partition(void)
 {
-- 
2.51.2.vfs.0.1


