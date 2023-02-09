Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE1690880
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 13:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjBIMRZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBIMRN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 07:17:13 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02B67DBE5;
        Thu,  9 Feb 2023 04:16:53 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 09A7020C8AF4;
        Thu,  9 Feb 2023 04:15:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09A7020C8AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675944944;
        bh=tcypQPfMSnfnYp3JE6Trh1CtkCM96kzsYYRghzAy49I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bMVGNRK2D9pFEslGphWYzkl5YMZc6Ohj7OrdblC71KSHkCd3cjxa4eb3gt+Wj+Y0+
         ohsGiJ/OT2VGXVCzJ6a3EEkeP0Z5cpLWfmOSOnO8uFq0NAMMbHvjHNwSsGE0+WNwFJ
         xS/LDWhVoVX1iHsfc9Tsc+tubf5H8zqef5++b7IY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@linux.microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v5 5/5] Driver: VMBus: Add device tree support
Date:   Thu,  9 Feb 2023 04:15:39 -0800
Message-Id: <1675944939-22631-6-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Update the driver to support device tree boot as well along with ACPI.
At present the device tree parsing only provides the mmio region info
and is not the exact copy of ACPI parsing. This is sufficient to cater
all the current device tree usecases for VMBus.

Currently device tree is supported only for x86 systems.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
- Removed #else for device tree parsing code. This should help better
  test coverage.
- Fix macro '__maybe_unused' warning
- Added below options in Kconfig to enable device tree options for HYPERV
	select OF if !ACPI
	select OF_EARLY_FLATTREE if !ACPI

 drivers/hv/Kconfig     |  6 +++--
 drivers/hv/vmbus_drv.c | 60 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..1a55bf32d195 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,11 +4,13 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ARM64 && !CPU_BIG_ENDIAN))
+	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
+		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select VMAP_PFN
+	select OF if !ACPI
+	select OF_EARLY_FLATTREE if !ACPI
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 73497157a23a..02f6bab61c37 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/hyperv.h>
 #include <linux/kernel_stat.h>
+#include <linux/of_address.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/sched/isolation.h>
@@ -2152,7 +2153,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 	device_unregister(&device_obj->device);
 }
 
-
+#ifdef CONFIG_ACPI
 /*
  * VMBUS is an acpi enumerated device. Get the information we
  * need from DSDT.
@@ -2262,6 +2263,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 
 	return AE_OK;
 }
+#endif
 
 static void vmbus_mmio_remove(void)
 {
@@ -2282,7 +2284,7 @@ static void vmbus_mmio_remove(void)
 	}
 }
 
-static void vmbus_reserve_fb(void)
+static void __maybe_unused vmbus_reserve_fb(void)
 {
 	resource_size_t start = 0, size;
 	struct pci_dev *pdev;
@@ -2442,6 +2444,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
 
+#ifdef CONFIG_ACPI
 static int vmbus_acpi_add(struct platform_device *pdev)
 {
 	acpi_status result;
@@ -2494,10 +2497,50 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 		vmbus_mmio_remove();
 	return ret_val;
 }
+#endif
+
+static int vmbus_device_add(struct platform_device *pdev)
+{
+	struct resource **cur_res = &hyperv_mmio;
+	struct of_range range;
+	struct of_range_parser parser;
+	struct device_node *np;
+	int ret = 0;
+
+	hv_dev = &pdev->dev;
+	np = pdev->dev.of_node;
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret) {
+		dev_err(hv_dev, "Failed to parse resources.\n");
+		return ret;
+	}
+
+	for_each_of_range(&parser, &range) {
+		struct resource *res;
+
+		res = kzalloc(sizeof(*res), GFP_ATOMIC);
+		if (!res)
+			return -ENOMEM;
+
+		res->name = "hyperv mmio";
+		res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
+		res->start = range.pci_addr;
+		res->end = range.pci_addr + range.size;
+
+		*cur_res = res;
+		cur_res = &res->sibling;
+	}
+
+	return ret;
+}
 
 static int vmbus_platform_driver_probe(struct platform_device *pdev)
 {
+#ifdef CONFIG_ACPI
 	return vmbus_acpi_add(pdev);
+#endif
+	return vmbus_device_add(pdev);
 }
 
 static int vmbus_platform_driver_remove(struct platform_device *pdev)
@@ -2643,12 +2686,24 @@ static int vmbus_bus_resume(struct device *dev)
 #define vmbus_bus_resume NULL
 #endif /* CONFIG_PM_SLEEP */
 
+static const __maybe_unused struct of_device_id vmbus_of_match[] = {
+	{
+		.compatible = "microsoft,vmbus",
+	},
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, vmbus_of_match);
+
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id vmbus_acpi_device_ids[] = {
 	{"VMBUS", 0},
 	{"VMBus", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
+#endif
 
 /*
  * Note: we must use the "no_irq" ops, otherwise hibernation can not work with
@@ -2677,6 +2732,7 @@ static struct platform_driver vmbus_platform_driver = {
 	.driver = {
 		.name = "vmbus",
 		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
+		.of_match_table = of_match_ptr(vmbus_of_match),
 		.pm = &vmbus_bus_pm,
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	}
-- 
2.34.1

