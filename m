Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9512A6834CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 19:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjAaSKV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 13:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjAaSKT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 13:10:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BFFF28865;
        Tue, 31 Jan 2023 10:10:18 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B2F6B20DFE14;
        Tue, 31 Jan 2023 10:10:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2F6B20DFE14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675188617;
        bh=2Oq3rLHSInRpCaH6L9jH9KNuBdNY6d/bl/THZjFDmv0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N9NFWF+FtHhqTmI33iFD7aDObg0jR3F88cvzGrZRh0vJsPIB+Dp3fERD0gCMq8gRy
         axOPqo2AgV4txx3gSALFHG/JeE3fC1yq+V4C2mZJR/LW1x+RzdlcjBXjBrx1szlEPp
         sIyOdGBEaFLYJTfYfC66wgS27ZEqqPeNMR7bAzPY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH v2 6/6] Driver: VMBus: Add device tree support
Date:   Tue, 31 Jan 2023 10:10:09 -0800
Message-Id: <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
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

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 75 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 49030e756b9f..1741f1348f9f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2152,7 +2152,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 	device_unregister(&device_obj->device);
 }
 
-
+#ifdef CONFIG_ACPI
 /*
  * VMBUS is an acpi enumerated device. Get the information we
  * need from DSDT.
@@ -2262,6 +2262,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 
 	return AE_OK;
 }
+#endif
 
 static void vmbus_mmio_remove(void)
 {
@@ -2282,7 +2283,7 @@ static void vmbus_mmio_remove(void)
 	}
 }
 
-static void vmbus_reserve_fb(void)
+static void __maybe_unused vmbus_reserve_fb(void)
 {
 	resource_size_t start = 0, size;
 	struct pci_dev *pdev;
@@ -2442,6 +2443,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
 
+#ifdef CONFIG_ACPI
 static int vmbus_acpi_add(struct platform_device *pdev)
 {
 	acpi_status result;
@@ -2496,10 +2498,68 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 		vmbus_mmio_remove();
 	return ret_val;
 }
+#else
+
+static int vmbus_device_add(struct platform_device *pdev)
+{
+	struct resource **cur_res = &hyperv_mmio;
+	struct device_node *np;
+	u32 *ranges, len;
+	u64 start;
+	int nr_ranges, child_cells = 2, cur_cell = 0, ret = 0;
+
+	hv_dev = pdev;
+	np = pdev->dev.of_node;
+
+	nr_ranges = device_property_count_u32(&pdev->dev, "ranges");
+	if (nr_ranges < 0)
+		return nr_ranges;
+	ranges = kcalloc(nr_ranges, sizeof(u32), GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+
+	if (device_property_read_u32_array(&pdev->dev, "ranges", ranges, nr_ranges)) {
+		ret =  -EINVAL;
+		goto free_ranges;
+	}
+
+	while (cur_cell < nr_ranges) {
+		struct resource *res;
+
+		/* The first u64 in the ranges description isn't used currently. */
+		cur_cell = cur_cell + child_cells;
+		start = ranges[cur_cell++];
+		start = (start << 32) | ranges[cur_cell++];
+		len = ranges[cur_cell++];
+
+		res = kzalloc(sizeof(*res), GFP_ATOMIC);
+		if (!res) {
+			ret = -ENOMEM;
+			goto free_ranges;
+		}
+
+		res->name = "hyperv mmio";
+		res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
+		res->start = start;
+		res->end = start + len;
+
+		*cur_res = res;
+		cur_res = &res->sibling;
+	}
+
+free_ranges:
+	kfree(ranges);
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
@@ -2645,6 +2705,16 @@ static int vmbus_bus_resume(struct device *dev)
 #define vmbus_bus_resume NULL
 #endif /* CONFIG_PM_SLEEP */
 
+static const struct of_device_id vmbus_of_match[] = {
+	{
+		.compatible = "msft,vmbus",
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
@@ -2679,6 +2749,7 @@ static struct platform_driver vmbus_platform_driver = {
 	.driver = {
 		.name = "vmbus",
 		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
+		.of_match_table = of_match_ptr(vmbus_of_match),
 		.pm = &vmbus_bus_pm,
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	}
-- 
2.25.1

