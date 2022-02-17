Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5872E4B96DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Feb 2022 04:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiBQDqW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Feb 2022 22:46:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiBQDqV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Feb 2022 22:46:21 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA19329C139;
        Wed, 16 Feb 2022 19:46:05 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z2so2190601iow.8;
        Wed, 16 Feb 2022 19:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1R18AGiSwApI4eXpLjrh2DkJUUPo0dvzIC8FGVasZV8=;
        b=U93OEC24yCY+TYbpRhYFv3MLRWeYS/xvEGaG3K2WR/v0Ri51LipUDhJ+9GbRhmj96s
         IMWECK+n6E8kizMKTtzjmQkfH2fGBnMOJm8QnkG84irEbetsHPr/kYcFziyuMWQI+U/h
         7+JHCHMic4ev8BnfQ+6ijHHeaPh1ltCu95V6kavnR2JA82W9pLKds6AXx+5BiLFgfXTh
         Fz8xInOwnJLxlJNcsR75Mi9zX+m2hEB2UoHe1JdZujaQ1FT2Z/qyH95NULY7wrdTzFb1
         ty9nNfSVWKTjdc3FrMscCmvrR3w3XxoIDl6oq6VAyK32rtBWHNn1ino280+mzFxmeUed
         XtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1R18AGiSwApI4eXpLjrh2DkJUUPo0dvzIC8FGVasZV8=;
        b=UM7nSVBZOCOem9MyKtkbBvWWaYGtLR9erKw/lw9nWu59baZRdfyNLZgV/H2i2hjUSb
         DWtNyM6JuvGYvEfSXbeEzlpXxn1c13KKMFhoqkrcnS4Iqgip792dCDnxDYpqMWm//lND
         Gsj7NX9Fd90ETUIU/QKPoxyC3pFLFRnSMdbU/z4tPe/2S4kmh/hGtpdiPWw/AobQBw8s
         +TfyT/TCdzm9cgdI2DpxxmmTu/FCJAmpU6RgHXNNCn7GOHSRlw41GRw3vbXqcxKgZ0GS
         QeL8AQiJF7jvcYDalSM977wv34qG6SP16a8+zdGoGSeCFErYsUVMh59NKx/n1u+ygApO
         xHRw==
X-Gm-Message-State: AOAM530KRtcFhtwE0qhR1s+WfmZfhbURZJ5rLJ/Q/cIlgvDvqkUEkpaO
        ED+LpxPFBBUmh2WIBMGKF+Q=
X-Google-Smtp-Source: ABdhPJxydsb8QgECa8OdKaLf9RgsF/uPX/mwnXlNZwPmZrP6DEgMUFV+HSXGKqZ33NEaYXLcxt9Puw==
X-Received: by 2002:a05:6638:d91:b0:30e:345:a0d2 with SMTP id l17-20020a0566380d9100b0030e0345a0d2mr698768jaj.257.1645069564564;
        Wed, 16 Feb 2022 19:46:04 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u8sm1048601ilb.39.2022.02.16.19.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:46:03 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id F164427C0054;
        Wed, 16 Feb 2022 22:46:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Feb 2022 22:46:01 -0500
X-ME-Sender: <xms:-cQNYmwDbjMZhTZ3BbO6vgmRjiiDxmttyR_ziHBClg3Lxu1Znb1Z4w>
    <xme:-cQNYiSZcNT9nyj2OWYBO_CJgWnfce0Of6cgjrs8AiiMUKr9LPDVSeujs_OE-wzHw
    WasUAhcyWkkI4byFQ>
X-ME-Received: <xmr:-cQNYoXkF_pIy_cSFCZoEXOFrYdv2Bng3rZndwOptIiU-y6MRWZaG7zM9Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeejgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeijefhledvtdegudfhffeugeetveeluefgkeevhfeuudeuudfgveevhfetvdeuvden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvg
X-ME-Proxy: <xmx:-cQNYsg2-zjlemF-5_R56w1ArtLl2ds_v1Igf6ZRal6qD5c3VjskLA>
    <xmx:-cQNYoDH0SKSzN37qAwvnR0OHUdfgU_qQtVwBT9cWmu2OFaYXyRavA>
    <xmx:-cQNYtKNdbe-lpXSbTmnlEy0aWHvymfQr7-oOUBTkvHUPAXRbomHUg>
    <xmx:-cQNYk58wSyNGHCQLUdr7UAFgpqXvmxpDpBRhJ8XFqiTkQ0PDKDsvRH2OaM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 22:45:59 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64
Date:   Thu, 17 Feb 2022 11:45:19 +0800
Message-Id: <20220217034525.1687678-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
devices, and SPIs can be managed directly via GICD registers. Therefore
the retarget interrupt hypercall is not needed on ARM64.

An arch-specific interface hv_arch_irq_unmask() is introduced to handle
the architecture level differences on this. For x86, the behavior
remains unchanged, while for ARM64 no hypercall is invoked when
unmasking an irq for virtual PCI devices.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 -> v2:

*	Introduce arch-specific interface hv_arch_irq_unmask() as
	suggested by Bjorn

 drivers/pci/controller/pci-hyperv.c | 233 +++++++++++++++-------------
 1 file changed, 122 insertions(+), 111 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 20ea2ee330b8..2a1481a52489 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -616,6 +616,121 @@ static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	return pci_msi_prepare(domain, dev, nvec, info);
 }
+
+/**
+ * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
+ * affinity.
+ * @data:	Describes the IRQ
+ *
+ * Build new a destination for the MSI and make a hypercall to
+ * update the Interrupt Redirection Table. "Device Logical ID"
+ * is built out of this PCI bus's instance GUID and the function
+ * number of the device.
+ */
+static void hv_arch_irq_unmask(struct irq_data *data)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
+	struct hv_retarget_device_interrupt *params;
+	struct hv_pcibus_device *hbus;
+	struct cpumask *dest;
+	cpumask_var_t tmp;
+	struct pci_bus *pbus;
+	struct pci_dev *pdev;
+	unsigned long flags;
+	u32 var_size = 0;
+	int cpu, nr_bank;
+	u64 res;
+
+	dest = irq_data_get_effective_affinity_mask(data);
+	pdev = msi_desc_to_pci_dev(msi_desc);
+	pbus = pdev->bus;
+	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
+
+	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
+
+	params = &hbus->retarget_msi_interrupt_params;
+	memset(params, 0, sizeof(*params));
+	params->partition_id = HV_PARTITION_ID_SELF;
+	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
+	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
+	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
+			   (hbus->hdev->dev_instance.b[4] << 16) |
+			   (hbus->hdev->dev_instance.b[7] << 8) |
+			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
+			   PCI_FUNC(pdev->devfn);
+	params->int_target.vector = hv_msi_get_int_vector(data);
+
+	/*
+	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
+	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
+	 * spurious interrupt storm. Not doing so does not seem to have a
+	 * negative effect (yet?).
+	 */
+
+	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
+		/*
+		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
+		 * HVCALL_RETARGET_INTERRUPT hypercall, which also coincides
+		 * with >64 VP support.
+		 * ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED
+		 * is not sufficient for this hypercall.
+		 */
+		params->int_target.flags |=
+			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
+
+		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
+			res = 1;
+			goto exit_unlock;
+		}
+
+		cpumask_and(tmp, dest, cpu_online_mask);
+		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
+		free_cpumask_var(tmp);
+
+		if (nr_bank <= 0) {
+			res = 1;
+			goto exit_unlock;
+		}
+
+		/*
+		 * var-sized hypercall, var-size starts after vp_mask (thus
+		 * vp_set.format does not count, but vp_set.valid_bank_mask
+		 * does).
+		 */
+		var_size = 1 + nr_bank;
+	} else {
+		for_each_cpu_and(cpu, dest, cpu_online_mask) {
+			params->int_target.vp_mask |=
+				(1ULL << hv_cpu_number_to_vp_number(cpu));
+		}
+	}
+
+	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
+			      params, NULL);
+
+exit_unlock:
+	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
+
+	/*
+	 * During hibernation, when a CPU is offlined, the kernel tries
+	 * to move the interrupt to the remaining CPUs that haven't
+	 * been offlined yet. In this case, the below hv_do_hypercall()
+	 * always fails since the vmbus channel has been closed:
+	 * refer to cpu_disable_common() -> fixup_irqs() ->
+	 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
+	 *
+	 * Suppress the error message for hibernation because the failure
+	 * during hibernation does not matter (at this time all the devices
+	 * have been frozen). Note: the correct affinity info is still updated
+	 * into the irqdata data structure in migrate_one_irq() ->
+	 * irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
+	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
+	 * the interrupt with the correct affinity.
+	 */
+	if (!hv_result_success(res) && hbus->state != hv_pcibus_removing)
+		dev_err(&hbus->hdev->device,
+			"%s() failed: %#llx", __func__, res);
+}
 #elif defined(CONFIG_ARM64)
 /*
  * SPI vectors to use for vPCI; arch SPIs range is [32, 1019], but leaving a bit
@@ -839,6 +954,12 @@ static struct irq_domain *hv_pci_get_root_domain(void)
 {
 	return hv_msi_gic_irq_domain;
 }
+
+/*
+ * SPIs are used for interrupts of PCI devices and SPIs is managed via GICD
+ * registers which Hyper-V already supports, so no hypercall needed.
+ */
+static void hv_arch_irq_unmask(struct irq_data *data) { }
 #endif /* CONFIG_ARM64 */
 
 /**
@@ -1456,119 +1577,9 @@ static void hv_irq_mask(struct irq_data *data)
 		irq_chip_mask_parent(data);
 }
 
-/**
- * hv_irq_unmask() - "Unmask" the IRQ by setting its current
- * affinity.
- * @data:	Describes the IRQ
- *
- * Build new a destination for the MSI and make a hypercall to
- * update the Interrupt Redirection Table. "Device Logical ID"
- * is built out of this PCI bus's instance GUID and the function
- * number of the device.
- */
 static void hv_irq_unmask(struct irq_data *data)
 {
-	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
-	struct hv_retarget_device_interrupt *params;
-	struct hv_pcibus_device *hbus;
-	struct cpumask *dest;
-	cpumask_var_t tmp;
-	struct pci_bus *pbus;
-	struct pci_dev *pdev;
-	unsigned long flags;
-	u32 var_size = 0;
-	int cpu, nr_bank;
-	u64 res;
-
-	dest = irq_data_get_effective_affinity_mask(data);
-	pdev = msi_desc_to_pci_dev(msi_desc);
-	pbus = pdev->bus;
-	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
-
-	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
-
-	params = &hbus->retarget_msi_interrupt_params;
-	memset(params, 0, sizeof(*params));
-	params->partition_id = HV_PARTITION_ID_SELF;
-	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
-	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
-	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
-			   (hbus->hdev->dev_instance.b[4] << 16) |
-			   (hbus->hdev->dev_instance.b[7] << 8) |
-			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
-			   PCI_FUNC(pdev->devfn);
-	params->int_target.vector = hv_msi_get_int_vector(data);
-
-	/*
-	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
-	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
-	 * spurious interrupt storm. Not doing so does not seem to have a
-	 * negative effect (yet?).
-	 */
-
-	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
-		/*
-		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
-		 * HVCALL_RETARGET_INTERRUPT hypercall, which also coincides
-		 * with >64 VP support.
-		 * ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED
-		 * is not sufficient for this hypercall.
-		 */
-		params->int_target.flags |=
-			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
-
-		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
-			res = 1;
-			goto exit_unlock;
-		}
-
-		cpumask_and(tmp, dest, cpu_online_mask);
-		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
-		free_cpumask_var(tmp);
-
-		if (nr_bank <= 0) {
-			res = 1;
-			goto exit_unlock;
-		}
-
-		/*
-		 * var-sized hypercall, var-size starts after vp_mask (thus
-		 * vp_set.format does not count, but vp_set.valid_bank_mask
-		 * does).
-		 */
-		var_size = 1 + nr_bank;
-	} else {
-		for_each_cpu_and(cpu, dest, cpu_online_mask) {
-			params->int_target.vp_mask |=
-				(1ULL << hv_cpu_number_to_vp_number(cpu));
-		}
-	}
-
-	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
-			      params, NULL);
-
-exit_unlock:
-	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
-
-	/*
-	 * During hibernation, when a CPU is offlined, the kernel tries
-	 * to move the interrupt to the remaining CPUs that haven't
-	 * been offlined yet. In this case, the below hv_do_hypercall()
-	 * always fails since the vmbus channel has been closed:
-	 * refer to cpu_disable_common() -> fixup_irqs() ->
-	 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
-	 *
-	 * Suppress the error message for hibernation because the failure
-	 * during hibernation does not matter (at this time all the devices
-	 * have been frozen). Note: the correct affinity info is still updated
-	 * into the irqdata data structure in migrate_one_irq() ->
-	 * irq_do_set_affinity() -> hv_set_affinity(), so later when the VM
-	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
-	 * the interrupt with the correct affinity.
-	 */
-	if (!hv_result_success(res) && hbus->state != hv_pcibus_removing)
-		dev_err(&hbus->hdev->device,
-			"%s() failed: %#llx", __func__, res);
+	hv_arch_irq_unmask(data);
 
 	if (data->parent_data->chip->irq_unmask)
 		irq_chip_unmask_parent(data);
-- 
2.35.1

