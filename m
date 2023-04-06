Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB56DB58A
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Apr 2023 22:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjDGU6T (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Apr 2023 16:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDGU6R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Apr 2023 16:58:17 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E6296A5A;
        Fri,  7 Apr 2023 13:58:06 -0700 (PDT)
Received: from skinsburskii.localdomain (unknown [131.107.1.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A33F213B62E;
        Fri,  7 Apr 2023 13:58:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A33F213B62E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680901085;
        bh=xX8UglqAO9D7VIeqlVY4oCyfwKnXYYeF9E8GHXwADe8=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=EBR4QqWwM+ZQqLtV4TvHcsYuZ2h/kW2CX9N2HwqasiNBonZKItJrQIHwbY/iIa9LU
         Yq+b2qJfdGikoEN5HDAlQciAAHgaHFPnoiazLeYjdnRKQ/JYglTHz6j/gq+nqaaYyN
         muYftxB+yz5U6DhigioqqwvacNI5xHPwAPJK6jN8=
Subject: [PATCH 1/2] x86/hyperv: Expose an helper to map PCI interrupts
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 09:33:13 -0700
Message-ID: <168079870998.14175.16015623662679754647.stgit@skinsburskii.localdomain>
In-Reply-To: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
References: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.2 required=5.0 tests=DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

This patch moves a part of currently internal logic into the new
hv_map_msi_interrupt function and makes it globally available helper,
which will be used to map PCI interrupts in case of root partition.

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
CC: Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-hyperv@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/hyperv/irqdomain.c     |   40 +++++++++++++++++++++++++++------------
 arch/x86/include/asm/mshyperv.h |    2 ++
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 42c70d28ef27..fd9c487726e3 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -169,13 +169,35 @@ static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
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
+	struct hv_interrupt_entry dummy, *entry;
+	struct irq_cfg *cfg = irqd_cfg(data);
+	const cpumask_t *affinity;
+	int cpu, vector;
+
+	msidesc = irq_data_get_msi_desc(data);
+	dev = msi_desc_to_pci_dev(msidesc);
+	device_id = hv_build_pci_dev_id(dev);
+	affinity = irq_data_get_effective_affinity_mask(data);
+	cpu = cpumask_first_and(affinity, cpu_online_mask);
+	entry = out_entry ? out_entry : &dummy;
+	vector = cfg->vector;
 
 	return hv_map_interrupt(device_id, false, cpu, vector, entry);
 }
+EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
 
 static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
 {
@@ -190,10 +212,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
@@ -204,9 +224,6 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		return;
 	}
 
-	affinity = irq_data_get_effective_affinity_mask(data);
-	cpu = cpumask_first_and(affinity, cpu_online_mask);
-
 	if (data->chip_data) {
 		/*
 		 * This interrupt is already mapped. Let's unmap first.
@@ -235,15 +252,14 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
index 4c4c0ec3b62e..aa0e83acacbd 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -203,6 +203,8 @@ static inline void hv_apic_init(void) {}
 
 struct irq_domain *hv_create_pci_msi_domain(void);
 
+int hv_map_msi_interrupt(struct irq_data *data,
+			 struct hv_interrupt_entry *out_entry);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);


