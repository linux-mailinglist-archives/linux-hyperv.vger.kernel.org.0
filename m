Return-Path: <linux-hyperv+bounces-5840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5AAD470F
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 01:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8486B189C571
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8824828C5A3;
	Tue, 10 Jun 2025 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g9SAmhmF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA5F28A722;
	Tue, 10 Jun 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599531; cv=none; b=naIdHfU+Kknyh1AUF+i/07LbyI0cpVzX2EEY41ndN3D27kBYaYrzoxz/gzbBZ9uyqWI0EiskJ2blEuQBq2857IxrwO33h3aiv+pcp2n04fNV6UL5vwvTGZxXqLV6zdjvuhCEgFbKbHD0PnzImlh2lczusLZqAkQsxJ/Uk/lwCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599531; c=relaxed/simple;
	bh=sXnnRz5wfs+ByvjGLJDGva9pA3vfok7mgIRKbB/IvYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dzRo9OL6DTLzgYsWJVw4aOrIjZgC/2YngAiZIQp1NBhFkEbVvCvCG8QDWkn4bpb0q5HjpM4Oq8wjlsbkpbPr6fyW4OA0gS7A2qoTfUZK+6AZGm4r83nn7fWI1UhtfO1l6LzoMWk+7ZOYmnUheHf0zVPM4KCHJi1W2+p8Zn4jUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g9SAmhmF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 728772115186; Tue, 10 Jun 2025 16:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 728772115186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749599529;
	bh=rXbxqdatFz0GsfdGns1ozciabfioI/E/Nkoi8/nxIJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9SAmhmFHhM3ZQ09+FxENRwSu11O2tcnVikLE+HVGQ4JGLCVSQGM35dwAYYi96UTJ
	 PX12+2qkKWegodX2JEMAIDCQn3c2iGcyguzb1Ub4d6WXKYgN9ck+FzLYf8BzZNl9bw
	 u7T+TCzpQHBwomT2kdAgufKzn6z/pImmakqi8+wY=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	x86@kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 3/4] x86: hyperv: Expose hv_map_msi_interrupt function
Date: Tue, 10 Jun 2025 16:52:05 -0700
Message-Id: <1749599526-19963-4-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

This patch moves a part of currently internal logic into the
hv_map_msi_interrupt function and makes it globally available helper
function, which will be used to map PCI interrupts in case of root
partition.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c     | 47 ++++++++++++++++++++++++---------
 arch/x86/include/asm/mshyperv.h |  2 ++
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 31f0d29cbc5e..82f3bafb93d6 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -169,13 +169,40 @@ static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
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
+ */
+int hv_map_msi_interrupt(struct irq_data *data,
+			 struct hv_interrupt_entry *out_entry)
 {
-	union hv_device_id device_id = hv_build_pci_dev_id(dev);
+	struct msi_desc *msidesc;
+	struct pci_dev *dev;
+	union hv_device_id device_id;
+	struct hv_interrupt_entry dummy;
+	struct irq_cfg *cfg = irqd_cfg(data);
+	const cpumask_t *affinity;
+	int cpu;
+	u64 res;
 
-	return hv_map_interrupt(device_id, false, cpu, vector, entry);
+	msidesc = irq_data_get_msi_desc(data);
+	dev = msi_desc_to_pci_dev(msidesc);
+	device_id = hv_build_pci_dev_id(dev);
+	affinity = irq_data_get_effective_affinity_mask(data);
+	cpu = cpumask_first_and(affinity, cpu_online_mask);
+
+	res = hv_map_interrupt(device_id, false, cpu, cfg->vector,
+			       out_entry ? out_entry : &dummy);
+	if (!hv_result_success(res))
+		pr_err("%s: failed to map interrupt: %s",
+		       __func__, hv_result_to_string(res));
+
+	return hv_result_to_errno(res);
 }
+EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
 
 static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
 {
@@ -190,10 +217,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct msi_desc *msidesc;
 	struct pci_dev *dev;
-	struct hv_interrupt_entry out_entry, *stored_entry;
+	struct hv_interrupt_entry *stored_entry;
 	struct irq_cfg *cfg = irqd_cfg(data);
-	const cpumask_t *affinity;
-	int cpu;
 	u64 status;
 
 	msidesc = irq_data_get_msi_desc(data);
@@ -204,9 +229,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	affinity = irq_data_get_effective_affinity_mask(data);
-	cpu = cpumask_first_and(affinity, cpu_online_mask);
-
 	if (data->chip_data) {
 		/*
 		 * This interrupt is already mapped. Let's unmap first.
@@ -235,15 +257,14 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	status = hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
+	status = hv_map_msi_interrupt(data, stored_entry);
 	if (status != HV_STATUS_SUCCESS) {
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
index 5ec92e3e2e37..843121465ddd 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -261,6 +261,8 @@ static inline void hv_apic_init(void) {}
 
 struct irq_domain *hv_create_pci_msi_domain(void);
 
+int hv_map_msi_interrupt(struct irq_data *data,
+			 struct hv_interrupt_entry *out_entry);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
-- 
2.34.1


