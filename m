Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCA66CADA
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jan 2023 18:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjAPRIK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjAPRHo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 12:07:44 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29B954521A;
        Mon, 16 Jan 2023 08:48:14 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2C2C220DFE7A;
        Mon, 16 Jan 2023 08:48:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C2C220DFE7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673887693;
        bh=/erGmO9YBydy1+czkGczqNFZxOgb8gfFMFeWHJ3yvbM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kRkQECdyTuQedMcWTjlxERbl4mTCPSNyziAnxJTFHgzad4olzatgmysPgcb9OV8JB
         OZ3vDKrVg/7lV6ZfkowN6jqB/M8C5N/trKeNCH7RZcd7TIfMW9KS2JggGEYJBmxSP1
         gr5475MRiSItTAMBjiY0vOWjZnIBE6A9TCdHNW8U=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH 3/4] Drivers: hv: vmbus: Device Tree support
Date:   Mon, 16 Jan 2023 08:48:07 -0800
Message-Id: <1673887688-19151-4-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Update the driver to use vmbus_root_dev device instead of acpi_device,
which can be assigned to either ACPI or OF device, making VMBus agnostic
to whether the device is using ACPI or device tree.

When built for OF, the driver registers as a platform driver and includes
a 'of' probe function that is alternate to the existing ACPI registration
and probe when built for ACPI. The VMBus driver maintains its registration
as the bus that other VMBus devices plug into, regardless of whether it is
initially probed and initialized via ACPI or OF.

This change also introduce vmbus_remove_mmio function, which helps removing
the duplicate code for mmio cleanup between APIC and OF driver.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 190 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 155 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1901556..894b360 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -11,11 +11,13 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/sysctl.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/completion.h>
 #include <linux/hyperv.h>
 #include <linux/kernel_stat.h>
@@ -44,14 +46,14 @@ struct vmbus_dynid {
 	struct hv_vmbus_device_id id;
 };
 
-static struct acpi_device  *hv_acpi_dev;
-
 static int hyperv_cpuhp_online;
 
 static void *hv_panic_page;
 
 static long __percpu *vmbus_evt;
 
+static struct device *vmbus_root_dev;
+
 /* Values parsed from ACPI DSDT */
 int vmbus_irq;
 int vmbus_interrupt;
@@ -136,17 +138,13 @@ static int hv_die_panic_notify_crash(struct notifier_block *self,
 	return NOTIFY_DONE;
 }
 
-static const char *fb_mmio_name = "fb_range";
 static struct resource *fb_mmio;
 static struct resource *hyperv_mmio;
 static DEFINE_MUTEX(hyperv_mmio_lock);
 
 static int vmbus_exists(void)
 {
-	if (hv_acpi_dev == NULL)
-		return -ENODEV;
-
-	return 0;
+	return vmbus_root_dev ? 0 : -ENODEV;
 }
 
 static u8 channel_monitor_group(const struct vmbus_channel *channel)
@@ -932,7 +930,7 @@ static int vmbus_dma_configure(struct device *child_device)
 	 * On x86/x64 coherence is assumed and these calls have no effect.
 	 */
 	hv_setup_dma_ops(child_device,
-		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
+		device_get_dma_attr(vmbus_root_dev) == DEV_DMA_COHERENT);
 	return 0;
 }
 
@@ -2090,7 +2088,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		     &child_device_obj->channel->offermsg.offer.if_instance);
 
 	child_device_obj->device.bus = &hv_bus;
-	child_device_obj->device.parent = &hv_acpi_dev->dev;
+	child_device_obj->device.parent = vmbus_root_dev;
 	child_device_obj->device.release = vmbus_device_release;
 
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
@@ -2151,7 +2149,26 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 	device_unregister(&device_obj->device);
 }
 
+static void vmbus_remove_mmio(void)
+{
+	struct resource *cur_res;
+	struct resource *next_res;
+
+	if (hyperv_mmio) {
+		if (fb_mmio) {
+			__release_region(hyperv_mmio, fb_mmio->start,
+					 resource_size(fb_mmio));
+			fb_mmio = NULL;
+		}
+
+		for (cur_res = hyperv_mmio; cur_res; cur_res = next_res) {
+			next_res = cur_res->sibling;
+			kfree(cur_res);
+		}
+	}
+}
 
+#ifdef CONFIG_ACPI
 /*
  * VMBUS is an acpi enumerated device. Get the information we
  * need from DSDT.
@@ -2264,21 +2281,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 
 static void vmbus_acpi_remove(struct acpi_device *device)
 {
-	struct resource *cur_res;
-	struct resource *next_res;
-
-	if (hyperv_mmio) {
-		if (fb_mmio) {
-			__release_region(hyperv_mmio, fb_mmio->start,
-					 resource_size(fb_mmio));
-			fb_mmio = NULL;
-		}
-
-		for (cur_res = hyperv_mmio; cur_res; cur_res = next_res) {
-			next_res = cur_res->sibling;
-			kfree(cur_res);
-		}
-	}
+	vmbus_remove_mmio();
 }
 
 static void vmbus_reserve_fb(void)
@@ -2319,8 +2322,9 @@ static void vmbus_reserve_fb(void)
 	 * reserving a larger area and make it smaller until it succeeds.
 	 */
 	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
-		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
+		fb_mmio = __request_region(hyperv_mmio, start, size, "fb_range", 0);
 }
+#endif /* CONFIG_ACPI */
 
 /**
  * vmbus_allocate_mmio() - Pick a memory-mapped I/O range.
@@ -2441,13 +2445,14 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
 
+#ifdef CONFIG_ACPI
 static int vmbus_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
 	int ret_val = -ENODEV;
 	struct acpi_device *ancestor;
 
-	hv_acpi_dev = device;
+	vmbus_root_dev = &device->dev;
 
 	/*
 	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
@@ -2492,6 +2497,72 @@ static int vmbus_acpi_add(struct acpi_device *device)
 		vmbus_acpi_remove(device);
 	return ret_val;
 }
+#endif
+
+#ifdef CONFIG_OF
+static int vmbus_of_driver_probe(struct platform_device *dev)
+{
+	struct resource **cur_res = &hyperv_mmio;
+	struct device_node *np;
+	const __be32 *ranges;
+	u32 nr_addr, nr_size, nr_parent_addr_cells, nr_ranges;
+	u32 range_len, range_size;
+	int i;
+
+	vmbus_root_dev = &dev->dev;
+	np = vmbus_root_dev->of_node;
+
+	if (of_property_read_u32(np, "#address-cells", &nr_addr))
+		return -ENOENT;
+	if (of_property_read_u32(np, "#size-cells", &nr_size))
+		return -ENOENT;
+	nr_parent_addr_cells = of_n_addr_cells(np);
+
+	if (nr_parent_addr_cells != 2 || nr_addr != 2 || nr_size != 1) {
+		pr_err("Address format is not supported\n");
+		return -EINVAL;
+	}
+
+	ranges = of_get_property(np, "ranges", &range_len);
+	if (!ranges)
+		return -ENOENT;
+
+	range_size = nr_parent_addr_cells + nr_addr + nr_size; // in cells
+	nr_ranges = range_len / sizeof(__be32) / range_size;
+
+	for (i = 0; i < nr_ranges; ++i, ranges += range_size) {
+		struct resource *res;
+		/*
+		 * The first u64 in the ranges description isn't used currently.
+		 * u64 _ = of_read_number(ranges, nr_parent_addr_cells);
+		 */
+		u64 start = of_read_number(ranges + nr_parent_addr_cells, nr_addr);
+		u32 len = of_read_number(ranges + nr_parent_addr_cells + nr_addr, nr_size);
+
+		pr_debug("VMBUS DeviceTree MMIO region start %#llx, %#x\n", start, len);
+
+		res = kzalloc(sizeof(*res), GFP_ATOMIC);
+		if (!res)
+			return -ENOMEM;
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
+	return 0;
+}
+
+static int vmbus_of_driver_remove(struct platform_device *dev)
+{
+	vmbus_remove_mmio();
+	return 0;
+}
+#endif
 
 #ifdef CONFIG_PM_SLEEP
 static int vmbus_bus_suspend(struct device *dev)
@@ -2630,6 +2701,9 @@ static int vmbus_bus_resume(struct device *dev)
 #define vmbus_bus_resume NULL
 #endif /* CONFIG_PM_SLEEP */
 
+#define DRV_NAME "vmbus"
+
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id vmbus_acpi_device_ids[] = {
 	{"VMBUS", 0},
 	{"VMBus", 0},
@@ -2659,7 +2733,7 @@ static int vmbus_bus_resume(struct device *dev)
 };
 
 static struct acpi_driver vmbus_acpi_driver = {
-	.name = "vmbus",
+	.name = DRV_NAME,
 	.ids = vmbus_acpi_device_ids,
 	.ops = {
 		.add = vmbus_acpi_add,
@@ -2669,6 +2743,7 @@ static int vmbus_bus_resume(struct device *dev)
 	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
 };
 
+#endif
 static void hv_kexec_handler(void)
 {
 	hv_stimer_global_cleanup();
@@ -2737,7 +2812,32 @@ static void hv_synic_resume(void)
 	.resume = hv_synic_resume,
 };
 
-static int __init hv_acpi_init(void)
+#ifdef CONFIG_OF
+static const struct of_device_id vmbus_of_match[] = {
+	{
+		.name = "msft,vmbus",
+		.compatible = "msft,vmbus",
+		.data = NULL
+	},
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, vmbus_of_match);
+
+static struct platform_driver vmbus_platform_driver = {
+	.probe = vmbus_of_driver_probe,
+	.remove = vmbus_of_driver_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(vmbus_of_match),
+		.pm = &vmbus_pm,
+		.bus = &hv_bus,
+	}
+};
+#endif
+
+static int __init vmbus_init(void)
 {
 	int ret;
 
@@ -2747,18 +2847,27 @@ static int __init hv_acpi_init(void)
 	if (hv_root_partition && !hv_nested)
 		return 0;
 
+#ifdef CONFIG_ACPI
 	/*
-	 * Get ACPI resources first.
+	 * Request ACPI resources and wait for the completion
 	 */
 	ret = acpi_bus_register_driver(&vmbus_acpi_driver);
 
 	if (ret)
 		return ret;
 
-	if (!hv_acpi_dev) {
-		ret = -ENODEV;
+	if (!vmbus_root_dev) {
+		ret = -ETIMEDOUT;
 		goto cleanup;
 	}
+#endif
+#ifdef CONFIG_OF
+	ret = platform_driver_register(&vmbus_platform_driver);
+	if (ret) {
+		pr_err("Error registering platform resources: %d\n", ret);
+		goto cleanup;
+	}
+#endif
 
 	/*
 	 * If we're on an architecture with a hardcoded hypervisor
@@ -2785,8 +2894,14 @@ static int __init hv_acpi_init(void)
 	return 0;
 
 cleanup:
+#ifdef CONFIG_ACPI
 	acpi_bus_unregister_driver(&vmbus_acpi_driver);
-	hv_acpi_dev = NULL;
+#endif
+#ifdef CONFIG_OF
+	platform_driver_unregister(&vmbus_platform_driver);
+#endif
+	vmbus_root_dev = NULL;
+
 	return ret;
 }
 
@@ -2839,12 +2954,17 @@ static void __exit vmbus_exit(void)
 
 	cpuhp_remove_state(hyperv_cpuhp_online);
 	hv_synic_free();
+#ifdef CONFIG_ACPI
 	acpi_bus_unregister_driver(&vmbus_acpi_driver);
+#endif
+#ifdef CONFIG_OF
+	platform_driver_unregister(&vmbus_platform_driver);
+#endif
+	vmbus_root_dev = NULL;
 }
 
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V VMBus Driver");
 
-subsys_initcall(hv_acpi_init);
+subsys_initcall(vmbus_init);
 module_exit(vmbus_exit);
-- 
1.8.3.1

