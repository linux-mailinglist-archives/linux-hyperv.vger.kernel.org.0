Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581546186BE
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 18:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKCR65 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKCR6z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 13:58:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C152100C;
        Thu,  3 Nov 2022 10:58:54 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4986520C28B1;
        Thu,  3 Nov 2022 10:58:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4986520C28B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667498334;
        bh=2oxuhDe5kV6GjYNF8LuxN2eAqqYyKVRUxh3NgSYoyro=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=JtO1ihxob+SsrhIVYTkWVTsjV7gq4+H3B+vaZm7VECZafo13jgTiSkJMxL4eMzgxl
         ysZwGbCvQQB0vqTrvA/roMYBcVli7TiT5gtv7f0ZW5vOPO0WzdUEGo0Lyx7WZLIMjR
         2qB0HCpnLe3NKPPLYrTs6KrneWDt7cPfb1LZSZJU=
Subject: [PATCH v3 2/4] drivers/clocksource/hyper-v: Introduce TSC PFN getter
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Date:   Thu, 03 Nov 2022 17:58:54 +0000
Message-ID: <166749833420.218190.2102763345349472395.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>

And rework the code to use it instead of the physical address, which isn't
required by itself.

This is a cleanup and precursor patch for upcoming support for TSC page
mapping into Microsoft Hypervisor root partition, where TSC PFN will be
defined by the hypervisor and not by the kernel.

Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
CC: Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: linux-hyperv@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/clocksource/hyperv_timer.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b0b5df576e17..b7af19d06b51 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -368,6 +368,12 @@ static union {
 } tsc_pg __aligned(PAGE_SIZE);
 
 static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
+static unsigned long tsc_pfn;
+
+static unsigned long hv_get_tsc_pfn(void)
+{
+	return tsc_pfn;
+}
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
@@ -409,13 +415,12 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
 
 static void resume_hv_clock_tsc(struct clocksource *arg)
 {
-	phys_addr_t phys_addr = virt_to_phys(tsc_page);
 	union hv_reference_tsc_msr tsc_msr;
 
 	/* Re-enable the TSC page */
 	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
 	tsc_msr.enable = 1;
-	tsc_msr.pfn = HVPFN_DOWN(phys_addr);
+	tsc_msr.pfn = tsc_pfn;
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
@@ -499,7 +504,6 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
 static bool __init hv_init_tsc_clocksource(void)
 {
 	union hv_reference_tsc_msr tsc_msr;
-	phys_addr_t	phys_addr;
 
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
@@ -524,7 +528,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	}
 
 	hv_read_reference_counter = read_hv_clock_tsc;
-	phys_addr = virt_to_phys(hv_get_tsc_page());
+	tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
@@ -535,7 +539,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	 */
 	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
 	tsc_msr.enable = 1;
-	tsc_msr.pfn = HVPFN_DOWN(phys_addr);
+	tsc_msr.pfn = tsc_pfn;
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);


