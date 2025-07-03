Return-Path: <linux-hyperv+bounces-6100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E7AF83C6
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jul 2025 00:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410283ADBDB
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA37263F;
	Thu,  3 Jul 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oDblWI43"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CC2C15BE;
	Thu,  3 Jul 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582695; cv=none; b=UtlzrJmp4ibBDDkE6Xsdw5FY6fwm0gBBW24G1zvALBgQ7DmzQfuzgE0MfE77WsoV1iyCaBOKYexAWlU95qRnMCi8L7/L0hFLjosMLpgAexxJXh7j+R/BI0TP+kUbKUsH9QW7Wo8d9Kha3tq1no8OZL5ApOxy7wyG7aZlToFkV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582695; c=relaxed/simple;
	bh=uiQDxjJ1ZD6oxrb7AM4nf4Mj1uhvKEg0ygFnD1gzArk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mngutnTuEi7hCPJgmvjGKYXJGrJaqaPosq8G0CsTrC+imdFpwKnlRijHbypLk7UqeMBfa3iRGhoIUXRB5powdguGI4Z2iVWHdGFXG2VASCSiY6ut2TY3/EoabtGDQjNOpeTs2b7YA0AwM8Ge/gRo1E3M36Je4XNDbedzehEEWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oDblWI43; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 2C6602115816; Thu,  3 Jul 2025 15:44:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C6602115816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751582693;
	bh=yuiKy6HzLGMzTMoD6eaD/m/nf1gAtFL5nYBYhD5Qphs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDblWI43lsxH9jUfMZeRB1+emFtnDegfbB6mjKyHcpOhYrcXlgm8Gu7Am5Kmj0HpG
	 71EJOHAo+qzhsCv8jE4vWyx5qbIbcBNn3Kwbvt+zUEpaFh6H8v9KrfGVnmOWkcG6RR
	 Tqm8oVDvfAIovGG7P/VQMNewAbD17k6t4ZCEBHDA=
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
Subject: [PATCH v2 5/6] x86: hyperv: Expose hv_map_msi_interrupt function
Date: Thu,  3 Jul 2025 15:44:36 -0700
Message-Id: <1751582677-30930-6-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
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
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c     | 38 +++++++++++++++++++++++----------
 arch/x86/include/asm/mshyperv.h |  2 ++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 75b25724b045..eca015563420 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -172,13 +172,32 @@ static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
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
@@ -191,11 +210,11 @@ static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi
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
@@ -205,8 +224,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
-
 	if (data->chip_data) {
 		/*
 		 * This interrupt is already mapped. Let's unmap first.
@@ -233,15 +250,14 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
index e00a8431ef8e..42ea9c68f8c8 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -241,6 +241,8 @@ static inline void hv_apic_init(void) {}
 
 struct irq_domain *hv_create_pci_msi_domain(void);
 
+int hv_map_msi_interrupt(struct irq_data *data,
+			 struct hv_interrupt_entry *out_entry);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
-- 
2.34.1


