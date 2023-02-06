Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33E68C53C
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Feb 2023 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBFRye (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Feb 2023 12:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjBFRyb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Feb 2023 12:54:31 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FAB61F5C8;
        Mon,  6 Feb 2023 09:54:30 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D541120C7E22;
        Mon,  6 Feb 2023 09:54:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D541120C7E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675706068;
        bh=kv/i0skTIQvHGuOqg6IvE4yvIUe6D8o/sc/yx8wo9AU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BVltVqViESplLS404Ok1Qrd5iAX1ruwM2n6LtmSJgotsz/yEYoGnyHy/m6Hq1GTyy
         Xp0ER8LUH1tTpMykd+Nhhpji+bYaK3Y76F09nc5APehvUv1Q5E7q4C8CU6ZAlNnsao
         PkFl7FLs71r1RVwAfer35+pvhgzSqsilt7JCsAUk=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v3 6/6] Driver: VMBus: Add device tree support
Date:   Mon,  6 Feb 2023 09:54:20 -0800
Message-Id: <1675706060-22361-7-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675706060-22361-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675706060-22361-1-git-send-email-ssengar@linux.microsoft.com>
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
[V3]
- Changed the logic to use generic api (for_each_of_range) for parsing "ranges".
- Remove dependency of ACPI for HYPERV in case of x86.

 drivers/hv/Kconfig     |  4 +--
 drivers/hv/vmbus_drv.c | 60 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..7e44d4246d8d 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,8 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ARM64 && !CPU_BIG_ENDIAN))
+	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
+		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select VMAP_PFN
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 9d6e0d02b834..5cbc541a20b5 100644
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
 
 static int vmbus_mmio_remove(void)
 {
@@ -2282,7 +2284,7 @@ static int vmbus_mmio_remove(void)
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
@@ -2494,10 +2497,52 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 		vmbus_mmio_remove();
 	return ret_val;
 }
+#else
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
+#endif
 
 static int vmbus_platform_driver_probe(struct platform_device *pdev)
 {
+#ifdef CONFIG_ACPI
 	return vmbus_acpi_add(pdev);
+#else
+	return vmbus_device_add(pdev);
+#endif
 }
 
 static int vmbus_platform_driver_remove(struct platform_device *pdev)
@@ -2643,6 +2688,16 @@ static int vmbus_bus_resume(struct device *dev)
 #define vmbus_bus_resume NULL
 #endif /* CONFIG_PM_SLEEP */
 
+static const struct of_device_id vmbus_of_match[] = {
+	{
+		.compatible = "microsoft,vmbus",
+	},
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, vmbus_of_match);
+
 static const struct acpi_device_id vmbus_acpi_device_ids[] = {
 	{"VMBUS", 0},
 	{"VMBus", 0},
@@ -2677,6 +2732,7 @@ static struct platform_driver vmbus_platform_driver = {
 	.driver = {
 		.name = "vmbus",
 		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
+		.of_match_table = of_match_ptr(vmbus_of_match),
 		.pm = &vmbus_bus_pm,
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	}
-- 
2.25.1

