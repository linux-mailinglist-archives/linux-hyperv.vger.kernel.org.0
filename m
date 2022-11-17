Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4BA62E5A3
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Nov 2022 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKQULr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Nov 2022 15:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKQULq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Nov 2022 15:11:46 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF0977DED9;
        Thu, 17 Nov 2022 12:11:45 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7798620B6C40;
        Thu, 17 Nov 2022 12:11:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7798620B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668715905;
        bh=wa9uP9wabMDKDkEi7yCMCeF3v/U9yuY0CAIcQrCpuoU=;
        h=From:To:Cc:Subject:Date:From;
        b=Gu6zLkUqn/uJuiye/UTwpFsFT0Gmrzz+J9+GgnY9QRxk4itMn63Ey1ubnmU5Xq5n0
         BaD8ysJgRDVorR4U4xN5hCpRgDlbWIWTVUr1Upxaq8O3GLO6l82xzuiLF+3JdZ7ZvW
         AcjguNhb8JmwR8/FfTgQjtQxbl7JPLa+XYvVUq8k=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com, wei.liu@kernel.org,
        kys@microsoft.com, Tianyu.Lan@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org
Subject: [PATCH v2] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Date:   Thu, 17 Nov 2022 12:11:39 -0800
Message-Id: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If x2apic is not available, hyperv-iommu skips remapping
irqs. This breaks root partition which always needs irqs
remapped.

Fix this by allowing irq remapping regardless of x2apic,
and change hyperv_enable_irq_remapping() to return
IRQ_REMAP_XAPIC_MODE in case x2apic is missing.

Tested with root and non-root hyperv partitions.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  6 ++++++
 drivers/iommu/Kconfig          |  6 +++---
 drivers/iommu/hyperv-iommu.c   | 11 ++++++++---
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92..46668e255421 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -475,6 +475,12 @@ static bool __init ms_hyperv_x2apic_available(void)
  * (logically) generates MSIs directly to the system APIC irq domain.
  * There is no HPET, and PCI MSI/MSI-X interrupts are remapped by the
  * pci-hyperv host bridge.
+ *
+ * Note: for a Hyper-V root partition, this will always return false.
+ * The hypervisor doesn't expose these HYPERV_CPUID_VIRT_STACK_* cpuids by
+ * default, they are implemented as intercepts by the Windows Hyper-V stack.
+ * Even a nested root partition (L2 root) will not get them because the
+ * nested (L1) hypervisor filters them out.
  */
 static bool __init ms_hyperv_msi_ext_dest_id(void)
 {
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..cf7433652db0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -474,13 +474,13 @@ config QCOM_IOMMU
 	  Support for IOMMU on certain Qualcomm SoCs.
 
 config HYPERV_IOMMU
-	bool "Hyper-V x2APIC IRQ Handling"
+	bool "Hyper-V IRQ Handling"
 	depends on HYPERV && X86
 	select IOMMU_API
 	default HYPERV
 	help
-	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
-	  guests to run with x2APIC mode enabled.
+	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
+	  guest and root partitions.
 
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e190bb8c225c..8302db7f783e 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -122,9 +122,12 @@ static int __init hyperv_prepare_irq_remapping(void)
 	const char *name;
 	const struct irq_domain_ops *ops;
 
+	/*
+	 * For a Hyper-V root partition, ms_hyperv_msi_ext_dest_id()
+	 * will always return false.
+	 */
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
-	    x86_init.hyper.msi_ext_dest_id() ||
-	    !x2apic_supported())
+	    x86_init.hyper.msi_ext_dest_id())
 		return -ENODEV;
 
 	if (hv_root_partition) {
@@ -170,7 +173,9 @@ static int __init hyperv_prepare_irq_remapping(void)
 
 static int __init hyperv_enable_irq_remapping(void)
 {
-	return IRQ_REMAP_X2APIC_MODE;
+	if (x2apic_supported())
+		return IRQ_REMAP_X2APIC_MODE;
+	return IRQ_REMAP_XAPIC_MODE;
 }
 
 struct irq_remap_ops hyperv_irq_remap_ops = {
-- 
2.25.1

