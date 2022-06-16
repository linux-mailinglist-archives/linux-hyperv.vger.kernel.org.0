Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A054E51A
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jun 2022 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377741AbiFPOkV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jun 2022 10:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiFPOkR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jun 2022 10:40:17 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797245784;
        Thu, 16 Jun 2022 07:40:15 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:40:10 +0200
From:   Vit Kabele <vit.kabele@sysgo.com>
To:     linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        kys@microsoft.com
Subject: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
Message-ID: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
Mail-Followup-To: Vit Kabele <vit.kabele@sysgo.com>,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The Hyper-V crash reporting feature is initialized after a successful
vmbus setup. The reporting feature however does not require vmbus at all
and Windows guests can indeed use the reporting capabilities even with
the minimal Hyper-V implementation (as described in the Minimal
Requirements document).

Reorder the initialization callbacks so that the crash reporting
callbacks are registered before the vmbus initialization starts.

Nevertheless, I am not sure about following:

1/ The vmbus_initiate_unload function is called within the panic handler
even when the vmbus initialization does not finish (there might be no
vmbus at all). This should probably not be problem because the vmbus
unload function always checks for current connection state and does
nothing when this is "DISCONNECTED". For better readability, it might be
better to add separate panic notifier for vmbus and crash reporting.

2/ Wouldn't it be better to extract the whole reporting capability out
of the vmbus module, so that it stays present in the kernel even when
the vmbus module is possibly unloaded?

Signed-off-by: Vit Kabele <vit.kabele@sysgo.com>

---
 drivers/hv/vmbus_drv.c | 77 +++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 714d549b7b46..97873f03aa7a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1509,41 +1509,6 @@ static int vmbus_bus_init(void)
 	if (hv_is_isolation_supported())
 		sysctl_record_panic_msg = 0;
 
-	/*
-	 * Only register if the crash MSRs are available
-	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
-		u64 hyperv_crash_ctl;
-		/*
-		 * Panic message recording (sysctl_record_panic_msg)
-		 * is enabled by default in non-isolated guests and
-		 * disabled by default in isolated guests; the panic
-		 * message recording won't be available in isolated
-		 * guests should the following registration fail.
-		 */
-		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
-		if (!hv_ctl_table_hdr)
-			pr_err("Hyper-V: sysctl table register error");
-
-		/*
-		 * Register for panic kmsg callback only if the right
-		 * capability is supported by the hypervisor.
-		 */
-		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
-		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
-			hv_kmsg_dump_register();
-
-		register_die_notifier(&hyperv_die_block);
-	}
-
-	/*
-	 * Always register the panic notifier because we need to unload
-	 * the VMbus channel connection to prevent any VMbus
-	 * activity after the VM panics.
-	 */
-	atomic_notifier_chain_register(&panic_notifier_list,
-			       &hyperv_panic_block);
-
 	vmbus_request_offers();
 
 	return 0;
@@ -2675,6 +2640,46 @@ static struct syscore_ops hv_synic_syscore_ops = {
 	.resume = hv_synic_resume,
 };
 
+static void __init crash_reporting_init(void)
+{
+	/*
+	 * Only register if the crash MSRs are available
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		u64 hyperv_crash_ctl;
+		/*
+		 * Panic message recording (sysctl_record_panic_msg)
+		 * is enabled by default in non-isolated guests and
+		 * disabled by default in isolated guests; the panic
+		 * message recording won't be available in isolated
+		 * guests should the following registration fail.
+		 */
+		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
+		if (!hv_ctl_table_hdr)
+			pr_err("Hyper-V: sysctl table register error");
+
+		/*
+		 * Register for panic kmsg callback only if the right
+		 * capability is supported by the hypervisor.
+		 */
+		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
+		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
+			hv_kmsg_dump_register();
+
+		register_die_notifier(&hyperv_die_block);
+	}
+
+	/*
+	 * Always register the panic notifier because we need to unload
+	 * the VMbus channel connection to prevent any VMbus
+	 * activity after the VM panics.
+	 */
+	atomic_notifier_chain_register(&panic_notifier_list,
+			       &hyperv_panic_block);
+
+
+}
+
 static int __init hv_acpi_init(void)
 {
 	int ret, t;
@@ -2687,6 +2692,8 @@ static int __init hv_acpi_init(void)
 
 	init_completion(&probe_event);
 
+	crash_reporting_init();
+
 	/*
 	 * Get ACPI resources first.
 	 */
-- 
2.30.2
