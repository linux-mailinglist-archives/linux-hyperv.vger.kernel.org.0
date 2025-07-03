Return-Path: <linux-hyperv+bounces-6099-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46FAF83BF
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE3E1CA08F7
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F62C3757;
	Thu,  3 Jul 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cuzDw/Bv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E052C15B2;
	Thu,  3 Jul 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582694; cv=none; b=nZ+pjblkGLmfIed1eXqcSdWu+JDa6Cb0BhG75JcpCEs+P0/CFMz5tmtAABnKskXDkQFEjolccQuIEMnDtAUGF6+urM6Jj528Z/ElgnZR1ZIEnJZ3nlLvbRNNnEl8275jaBqpkoQ8gy4m9XsCI3Oz3MMWivRxqbhOFhERkTCfIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582694; c=relaxed/simple;
	bh=HKDjMyE40VwaJ+QLHyu8orsTQnBzhgCDwZxdokg/sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B9lgzJvPhiM2yRPI+NKZGnrEyEygBhACiQg/LdhV4vaV4ZuWuFrJf+9GPnLkED1UHb3A7QawxBt9OkjQYw76vhD/fpSNovhD+E2JzrHmeFx4Wz0G9ZkyPSTQAE/wgrCdepHeRJyCcvHQofYIUhJ0VnMVdFeyxZfcg1xFHqoMrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cuzDw/Bv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id B0A3B211519B; Thu,  3 Jul 2025 15:44:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0A3B211519B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751582692;
	bh=tI8H2wX5v8zGuMwr587IEjCe4lTn+vWzbXe7WRWsg+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuzDw/BvqYiWhv4ZVvq35a121EEkTzNqbBH9zE+v3pbZSTS2nZ1rddj1qBA9zM8Es
	 4b+jEBsHQzVleQGzDcWLBJxRPpU4iDFQTag2XdvQRMn/ihcNGQpd78dlGH0YJcLqMi
	 WLMMRL0kQG0tQLLjhccZh8PTlySg+5dZ0/34LQGE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mhklinux@outlook.com,
	tglx@linutronix.de,
	bhelgaas@google.com,
	romank@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
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
Subject: [PATCH v2 4/6] x86/hyperv: Clean up hv_map/unmap_interrupt() return values
Date: Thu,  3 Jul 2025 15:44:35 -0700
Message-Id: <1751582677-30930-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix the return values of these hypercall helpers so they return
a negated errno either directly or via hv_result_to_errno().

Update the callers to check for errno instead of using
hv_status_success(), and remove redundant error printing.

While at it, rearrange some variable declarations to adhere to style
guidelines i.e. "reverse fir tree order".

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c  | 32 ++++++++++++++------------------
 drivers/iommu/hyperv-iommu.c | 33 ++++++++++++---------------------
 2 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index e28c317ac9e8..75b25724b045 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -46,7 +46,7 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	if (nr_bank < 0) {
 		local_irq_restore(flags);
 		pr_err("%s: unable to generate VP set\n", __func__);
-		return EINVAL;
+		return -EINVAL;
 	}
 	intr_desc->target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
 
@@ -66,7 +66,7 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
 	if (!hv_result_success(status))
 		hv_status_err(status, "\n");
 
-	return hv_result(status);
+	return hv_result_to_errno(status);
 }
 
 static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
@@ -88,7 +88,10 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
 	status = hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
 	local_irq_restore(flags);
 
-	return hv_result(status);
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+
+	return hv_result_to_errno(status);
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -188,12 +191,11 @@ static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi
 static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry);
 static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct msi_desc *msidesc;
-	struct pci_dev *dev;
 	struct hv_interrupt_entry out_entry, *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
-	int cpu;
-	u64 status;
+	struct msi_desc *msidesc;
+	struct pci_dev *dev;
+	int cpu, ret;
 
 	msidesc = irq_data_get_msi_desc(data);
 	dev = msi_desc_to_pci_dev(msidesc);
@@ -217,14 +219,12 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		stored_entry = data->chip_data;
 		data->chip_data = NULL;
 
-		status = hv_unmap_msi_interrupt(dev, stored_entry);
+		ret = hv_unmap_msi_interrupt(dev, stored_entry);
 
 		kfree(stored_entry);
 
-		if (status != HV_STATUS_SUCCESS) {
-			hv_status_debug(status, "failed to unmap\n");
+		if (ret)
 			return;
-		}
 	}
 
 	stored_entry = kzalloc(sizeof(*stored_entry), GFP_ATOMIC);
@@ -233,8 +233,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	status = hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
-	if (status != HV_STATUS_SUCCESS) {
+	ret = hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
+	if (ret) {
 		kfree(stored_entry);
 		return;
 	}
@@ -255,7 +255,6 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
 {
 	struct hv_interrupt_entry old_entry;
 	struct msi_msg msg;
-	u64 status;
 
 	if (!irqd->chip_data) {
 		pr_debug("%s: no chip data\n!", __func__);
@@ -268,10 +267,7 @@ static void hv_teardown_msi_irq(struct pci_dev *dev, struct irq_data *irqd)
 	kfree(irqd->chip_data);
 	irqd->chip_data = NULL;
 
-	status = hv_unmap_msi_interrupt(dev, &old_entry);
-
-	if (status != HV_STATUS_SUCCESS)
-		hv_status_err(status, "\n");
+	(void)hv_unmap_msi_interrupt(dev, &old_entry);
 }
 
 static void hv_msi_free_irq(struct irq_domain *domain,
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 761ab647f372..0961ac805944 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -193,15 +193,13 @@ struct hyperv_root_ir_data {
 static void
 hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
 {
-	u64 status;
-	u32 vector;
-	struct irq_cfg *cfg;
-	int ioapic_id;
-	const struct cpumask *affinity;
-	int cpu;
-	struct hv_interrupt_entry entry;
 	struct hyperv_root_ir_data *data = irq_data->chip_data;
+	struct hv_interrupt_entry entry;
+	const struct cpumask *affinity;
 	struct IO_APIC_route_entry e;
+	struct irq_cfg *cfg;
+	int cpu, ioapic_id;
+	u32 vector;
 
 	cfg = irqd_cfg(irq_data);
 	affinity = irq_data_get_effective_affinity_mask(irq_data);
@@ -214,23 +212,16 @@ hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
 	    && data->entry.ioapic_rte.as_uint64) {
 		entry = data->entry;
 
-		status = hv_unmap_ioapic_interrupt(ioapic_id, &entry);
-
-		if (status != HV_STATUS_SUCCESS)
-			hv_status_debug(status, "failed to unmap\n");
+		(void)hv_unmap_ioapic_interrupt(ioapic_id, &entry);
 
 		data->entry.ioapic_rte.as_uint64 = 0;
 		data->entry.source = 0; /* Invalid source */
 	}
 
 
-	status = hv_map_ioapic_interrupt(ioapic_id, data->is_level, cpu,
-					vector, &entry);
-
-	if (status != HV_STATUS_SUCCESS) {
-		hv_status_err(status, "map failed\n");
+	if (hv_map_ioapic_interrupt(ioapic_id, data->is_level, cpu,
+				    vector, &entry))
 		return;
-	}
 
 	data->entry = entry;
 
@@ -322,10 +313,10 @@ static void hyperv_root_irq_remapping_free(struct irq_domain *domain,
 			data = irq_data->chip_data;
 			e = &data->entry;
 
-			if (e->source == HV_DEVICE_TYPE_IOAPIC
-			      && e->ioapic_rte.as_uint64)
-				hv_unmap_ioapic_interrupt(data->ioapic_id,
-							&data->entry);
+			if (e->source == HV_DEVICE_TYPE_IOAPIC &&
+			    e->ioapic_rte.as_uint64)
+				(void)hv_unmap_ioapic_interrupt(data->ioapic_id,
+								&data->entry);
 
 			kfree(data);
 		}
-- 
2.34.1


