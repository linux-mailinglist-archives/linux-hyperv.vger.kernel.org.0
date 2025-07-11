Return-Path: <linux-hyperv+bounces-6194-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE5B02469
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 21:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601E017A1B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E5B280A3B;
	Fri, 11 Jul 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IfUwr2/B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBE1DE4E0;
	Fri, 11 Jul 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261542; cv=none; b=LnWdzdmaSZ39SfDXe6KIwvImCDEHfAQsTHds0KZYCXQwuo/jOvzF2SkXSacPqPjgODP8xEfj+kXDwjS4a3MG8DBBGaJIJFAzOXCxc7C3Eci8vHEvZO68L9e0tYOhkMbyNd6ilm8zUv9GOqUyvTw1o4I8N7kXPbLqacuzsAFWdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261542; c=relaxed/simple;
	bh=1tQI5GBVNvc/GU3PlrZZV3y33641kuBLyR9oIhCjq3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eF14Ib5oB51EFxLxiSaY2tbHDn4nXuiZWBlEj9Uc0EUec9F1dMVJww/0cTOBo/CAq3T8Zc84XlPXdJvMB8RGe/yg64Aj466j8DT9qS/tmJ2ohAgk6/SXmqAbVAelBTZQQaBmRDBwfEDHf36qgFvZityqT7Rwt7CG3BRKWX0iVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IfUwr2/B; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id A457E2115803; Fri, 11 Jul 2025 12:18:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A457E2115803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752261535;
	bh=sFZ1PcBMw9jT/La9cSdzjaxoBiffb+KtiJHzK65ieQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfUwr2/BEJV/P4zK1EjlNTEelPgd1NC6Ma6c441y229FZuK4SpVs/JIOZubMCVfIn
	 X9TfP/crS1nj2rMG21JWMTRSBs71bAZy6OzatcO0AFosl9oi0+zThIbtvrLQ8OZDKR
	 LfOAzdrs3Wo5lwcITYz1E96de0zkpiUX7FHk4YeM=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v3 2/3] x86/hyperv: Expose hv_map_msi_interrupt()
Date: Fri, 11 Jul 2025 12:18:51 -0700
Message-Id: <1752261532-7225-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Move some of the logic of hv_irq_compose_irq_message() into
hv_map_msi_interrupt(). Make hv_map_msi_interrupt() a globally-available
helper function, which will be used to map PCI interrupts when running
in the root partition.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c     | 40 ++++++++++++++++++++++++---------
 arch/x86/include/asm/mshyperv.h |  2 ++
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index ad4dff48cf14..090f5ac9f492 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -173,13 +173,34 @@ static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
 	return dev_id;
 }
 
-static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector,
-				struct hv_interrupt_entry *entry)
+/**
+ * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.
+ * @data:      Describes the IRQ
+ * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
+ *
+ * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hypercall.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int hv_map_msi_interrupt(struct irq_data *data,
+			 struct hv_interrupt_entry *out_entry)
 {
-	union hv_device_id device_id = hv_build_pci_dev_id(dev);
+	struct irq_cfg *cfg = irqd_cfg(data);
+	struct hv_interrupt_entry dummy;
+	union hv_device_id device_id;
+	struct msi_desc *msidesc;
+	struct pci_dev *dev;
+	int cpu;
 
-	return hv_map_interrupt(device_id, false, cpu, vector, entry);
+	msidesc = irq_data_get_msi_desc(data);
+	dev = msi_desc_to_pci_dev(msidesc);
+	device_id = hv_build_pci_dev_id(dev);
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
+
+	return hv_map_interrupt(device_id, false, cpu, cfg->vector,
+				out_entry ? out_entry : &dummy);
 }
+EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
 
 static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
 {
@@ -192,11 +213,11 @@ static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi
 static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry);
 static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct hv_interrupt_entry out_entry, *stored_entry;
+	struct hv_interrupt_entry *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct msi_desc *msidesc;
 	struct pci_dev *dev;
-	int cpu, ret;
+	int ret;
 
 	msidesc = irq_data_get_msi_desc(data);
 	dev = msi_desc_to_pci_dev(msidesc);
@@ -206,8 +227,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
-
 	if (data->chip_data) {
 		/*
 		 * This interrupt is already mapped. Let's unmap first.
@@ -234,15 +253,14 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	ret = hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
+	ret = hv_map_msi_interrupt(data, stored_entry);
 	if (ret) {
 		kfree(stored_entry);
 		return;
 	}
 
-	*stored_entry = out_entry;
 	data->chip_data = stored_entry;
-	entry_to_msi_msg(&out_entry, msg);
+	entry_to_msi_msg(data->chip_data, msg);
 
 	return;
 }
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ab097a3a8b75..abc4659f5809 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -242,6 +242,8 @@ static inline void hv_apic_init(void) {}
 
 struct irq_domain *hv_create_pci_msi_domain(void);
 
+int hv_map_msi_interrupt(struct irq_data *data,
+			 struct hv_interrupt_entry *out_entry);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
-- 
2.34.1


