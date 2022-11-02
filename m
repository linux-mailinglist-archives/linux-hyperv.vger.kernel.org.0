Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C99617057
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 23:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiKBWII (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiKBWHw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 18:07:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F11D101D5;
        Wed,  2 Nov 2022 15:07:40 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0CA2020C333D;
        Wed,  2 Nov 2022 15:07:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CA2020C333D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667426860;
        bh=/w1bIAu1uE35eBnnjmkdkpZrmD4gzFMKCaktzjEiFKw=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=dkg+2GWGEEjIBEpdjNlPAVmvIfzWgFYbWZ7tlZ6KiJ2c6xQs604sNbUZsOPJ3IdUI
         quVV0ndbH7I4T0D0nF02H8a3Nakh1gPhhjLOtABbAQD+sJKyJwGBh2PRkCjTNCCbXX
         wECnftPwDFChfEWPegi4df+w/XtFPgEcrC/58g9I=
Subject: [PATCH v2 4/4] drivers/clocksource/hyper-v: Add TSC page support for
 root partition
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Nov 2022 22:07:39 +0000
Message-ID: <166742685995.205987.1519185062889413335.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166742670556.205987.18227942188746093700.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: <166742670556.205987.18227942188746093700.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

Microsoft Hypervisor root partition has to map the TSC page specified
by the hypervisor, instead of providing the page to the hypervisor like
it's done in the guest partitions.

However, it's too early to map the page when the clock is initialized, so, the
actual mapping is happening later.

Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
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
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: linux-hyperv@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/hyperv/hv_init.c          |    2 ++
 drivers/clocksource/hyperv_timer.c |   37 +++++++++++++++++++++++++++---------
 include/clocksource/hyperv_timer.h |    1 +
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f49bc3ec76e6..89954490af93 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -464,6 +464,8 @@ void __init hyperv_init(void)
 		BUG_ON(!src);
 		memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
 		memunmap(src);
+
+		hv_remap_tsc_clocksource();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 635c14c1e3bf..ec76303b2a76 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -508,9 +508,6 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	if (hv_root_partition)
-		return false;
-
 	/*
 	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
 	 * handles frequency and offset changes due to live migration,
@@ -528,16 +525,22 @@ static bool __init hv_init_tsc_clocksource(void)
 	}
 
 	hv_read_reference_counter = read_hv_clock_tsc;
-	tsc_pfn = __phys_to_pfn(virt_to_phys(tsc_page));
 
 	/*
-	 * The Hyper-V TLFS specifies to preserve the value of reserved
-	 * bits in registers. So read the existing value, preserve the
-	 * low order 12 bits, and add in the guest physical address
-	 * (which already has at least the low 12 bits set to zero since
-	 * it is page aligned). Also set the "enable" bit, which is bit 0.
+	 * TSC page mapping works differently in root and guest partitions.
+	 * - In guest partition the guest PFN has to be passed to the
+	 *   hypervisor.
+	 * - In root partition it's other way around: it has to map the PFN
+	 *   provided by the hypervisor.
+	 *   But it can't be mapped right here as it's too early and MMU isn't
+	 *   ready yet. So, we only set the enable bit here and will remap the
+	 *   page later in hv_remap_tsc_clocksource().
 	 */
 	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
+	if (hv_root_partition)
+		tsc_pfn = tsc_msr.pfn;
+	else
+		tsc_pfn = __phys_to_pfn(virt_to_phys(tsc_page));
 	tsc_msr.enable = 1;
 	tsc_msr.pfn = tsc_pfn;
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
@@ -572,3 +575,19 @@ void __init hv_init_clocksource(void)
 	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
+
+void __init hv_remap_tsc_clocksource(void)
+{
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return;
+
+	if (!hv_root_partition) {
+		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
+		     __func__);
+		return;
+	}
+
+	tsc_page = memremap(__pfn_to_phys(tsc_pfn), sizeof(tsc_pg), MEMREMAP_WB);
+	if (!tsc_page)
+		pr_err("Failed to remap Hyper-V TSC page.\n");
+}
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 3078d23faaea..783701a2102d 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -31,6 +31,7 @@ extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
 extern void hv_init_clocksource(void);
+extern void hv_remap_tsc_clocksource(void);
 
 extern unsigned long hv_get_tsc_pfn(void);
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);


