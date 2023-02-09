Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29F690873
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 13:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBIMQu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 07:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBIMQt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 07:16:49 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DF365581;
        Thu,  9 Feb 2023 04:16:31 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id CC66120C8AF0;
        Thu,  9 Feb 2023 04:15:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC66120C8AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675944943;
        bh=QxjlMrs+k3GOIkNUqosnD/bWRotR9RtKp6Ub3/+UnTo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ObGN+su83uYpy2i07SF/nG9zaP4ZhVn+SdyQ6XViFKBANhShXzMjtUrCPwsdOUH8a
         ZTa9Rf6+VdsZun52aBXdAZJbZnWoWQxzE5eCiy6fbBimTUisfuhZ90E0ViAxfdz77w
         nAAb08FzD7FZAU+cf7wRX4NR6u06te2Tw/bjCsiY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@linux.microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v5 3/5] Drivers: hv: vmbus: Convert acpi_device to more generic platform_device
Date:   Thu,  9 Feb 2023 04:15:37 -0800
Message-Id: <1675944939-22631-4-git-send-email-ssengar@linux.microsoft.com>
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

VMBus driver code currently has direct dependency on ACPI and struct
acpi_device.  As a staging step toward optionally configuring based on
device tree instead of ACPI, use a more generic platform device to reduce
the dependency on ACPI where possible, though the dependency on ACPI
is not completely removed.  Also rename the function vmbus_acpi_remove()
to the more generic vmbus_mmio_remove().

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 58 +++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d24dd65b33d4..73497157a23a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/sysctl.h>
 #include <linux/slab.h>
@@ -44,7 +45,7 @@ struct vmbus_dynid {
 	struct hv_vmbus_device_id id;
 };
 
-static struct acpi_device  *hv_acpi_dev;
+static struct device  *hv_dev;
 
 static int hyperv_cpuhp_online;
 
@@ -143,7 +144,7 @@ static DEFINE_MUTEX(hyperv_mmio_lock);
 
 static int vmbus_exists(void)
 {
-	if (hv_acpi_dev == NULL)
+	if (hv_dev == NULL)
 		return -ENODEV;
 
 	return 0;
@@ -932,7 +933,7 @@ static int vmbus_dma_configure(struct device *child_device)
 	 * On x86/x64 coherence is assumed and these calls have no effect.
 	 */
 	hv_setup_dma_ops(child_device,
-		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
+		device_get_dma_attr(hv_dev) == DEV_DMA_COHERENT);
 	return 0;
 }
 
@@ -2090,7 +2091,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		     &child_device_obj->channel->offermsg.offer.if_instance);
 
 	child_device_obj->device.bus = &hv_bus;
-	child_device_obj->device.parent = &hv_acpi_dev->dev;
+	child_device_obj->device.parent = hv_dev;
 	child_device_obj->device.release = vmbus_device_release;
 
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
@@ -2262,7 +2263,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 	return AE_OK;
 }
 
-static void vmbus_acpi_remove(struct acpi_device *device)
+static void vmbus_mmio_remove(void)
 {
 	struct resource *cur_res;
 	struct resource *next_res;
@@ -2441,13 +2442,14 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
 
-static int vmbus_acpi_add(struct acpi_device *device)
+static int vmbus_acpi_add(struct platform_device *pdev)
 {
 	acpi_status result;
 	int ret_val = -ENODEV;
 	struct acpi_device *ancestor;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
-	hv_acpi_dev = device;
+	hv_dev = &device->dev;
 
 	/*
 	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
@@ -2489,10 +2491,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
 
 acpi_walk_err:
 	if (ret_val)
-		vmbus_acpi_remove(device);
+		vmbus_mmio_remove();
 	return ret_val;
 }
 
+static int vmbus_platform_driver_probe(struct platform_device *pdev)
+{
+	return vmbus_acpi_add(pdev);
+}
+
+static int vmbus_platform_driver_remove(struct platform_device *pdev)
+{
+	vmbus_mmio_remove();
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int vmbus_bus_suspend(struct device *dev)
 {
@@ -2658,15 +2671,15 @@ static const struct dev_pm_ops vmbus_bus_pm = {
 	.restore_noirq	= vmbus_bus_resume
 };
 
-static struct acpi_driver vmbus_acpi_driver = {
-	.name = "vmbus",
-	.ids = vmbus_acpi_device_ids,
-	.ops = {
-		.add = vmbus_acpi_add,
-		.remove = vmbus_acpi_remove,
-	},
-	.drv.pm = &vmbus_bus_pm,
-	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
+static struct platform_driver vmbus_platform_driver = {
+	.probe = vmbus_platform_driver_probe,
+	.remove = vmbus_platform_driver_remove,
+	.driver = {
+		.name = "vmbus",
+		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
+		.pm = &vmbus_bus_pm,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+	}
 };
 
 static void hv_kexec_handler(void)
@@ -2750,12 +2763,11 @@ static int __init hv_acpi_init(void)
 	/*
 	 * Get ACPI resources first.
 	 */
-	ret = acpi_bus_register_driver(&vmbus_acpi_driver);
-
+	ret = platform_driver_register(&vmbus_platform_driver);
 	if (ret)
 		return ret;
 
-	if (!hv_acpi_dev) {
+	if (!hv_dev) {
 		ret = -ENODEV;
 		goto cleanup;
 	}
@@ -2785,8 +2797,8 @@ static int __init hv_acpi_init(void)
 	return 0;
 
 cleanup:
-	acpi_bus_unregister_driver(&vmbus_acpi_driver);
-	hv_acpi_dev = NULL;
+	platform_driver_unregister(&vmbus_platform_driver);
+	hv_dev = NULL;
 	return ret;
 }
 
@@ -2839,7 +2851,7 @@ static void __exit vmbus_exit(void)
 
 	cpuhp_remove_state(hyperv_cpuhp_online);
 	hv_synic_free();
-	acpi_bus_unregister_driver(&vmbus_acpi_driver);
+	platform_driver_unregister(&vmbus_platform_driver);
 }
 
 
-- 
2.34.1

