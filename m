Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209E83E0836
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Aug 2021 20:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhHDStC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Aug 2021 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhHDStC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Aug 2021 14:49:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89FC061799;
        Wed,  4 Aug 2021 11:48:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e5so4016036pld.6;
        Wed, 04 Aug 2021 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4a7Bei7o1KC7VPD+FPgXj8rKANsZk7Dtmy+dqLdqQ0=;
        b=Na8zJeTGmfyPfIl5yXh/YhNP81bw+jRCfXL/tqIhwoa2Imxmtx7IlQGUl2xONijLvg
         Qqlq9tZrw+CAYpQLh2nD0cb1vNe4ohM1yF/A15EyyTnm+yywBvmWbyvypxlj3kB8COv+
         FcZvEl459iDM41LJfG2H5RJ5LuazCDCQpUde6BqVaQuUw6m0Ws0XUjmwtoYdxioTs2MU
         vzVKia2gyJ8ZbMYCHIWMDQDb6XSgL8ZfT1LX5pZW3ZOQiRUarMynP2YEQ2F24C/9So36
         XA3jbvIEF4BYgwcqEnCi9RaF0I9CrvFwgFz3tdqh94eJPUSUPEOYpSgV+jNd3k+5XuEq
         gW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S4a7Bei7o1KC7VPD+FPgXj8rKANsZk7Dtmy+dqLdqQ0=;
        b=GSrOr/PDYCRkT84sar8rIVXKB3ex0HevRmKD3iGn7S4ItCNpapTPfx/RMTut9/3QsP
         6IZ/kp7xlMS9Trtkkomi1e+8pErIeJAgy5TPTFhXb6JfeS/+vlE7TRgXEtSKCCqPMqjN
         f7zPxUg7bVd8T3btNGJQRxwINHiLCAUTWOR8K/Xmxfqo7PrEVrowa9ZFInm2zmSS+Yck
         avyg9uzamw9kpl7L5Zw/MtN+RV7A90pDBXYcQJYYMS+iBcqzP5FRNnzL9ZMB/ay2gL0Z
         4FI8w59fkbOA/QQApMDuLICG+sed52TwhTRK2oMLUx8JECmgSd99C/Qi6xzm+AQ1uG+n
         ZySg==
X-Gm-Message-State: AOAM5328FLNM2QHktAQyAly7GzRMs3WaxJAkNX6wyF6t02D3h8TyAuYW
        bblv+dCNIBejS28KQ7LiQEw=
X-Google-Smtp-Source: ABdhPJz6VHK4a/cMxFqm9pe6FoV3BLeCK1H/pOxFm7ctorQ8X3eRKxzjPcE3vctLy4+qTFtLj1HovA==
X-Received: by 2002:a17:90a:e647:: with SMTP id ep7mr11175384pjb.145.1628102928959;
        Wed, 04 Aug 2021 11:48:48 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:194c:6842:b8a8:6f83])
        by smtp.gmail.com with ESMTPSA id a22sm3739411pfa.137.2021.08.04.11.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 11:48:48 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH] x86/Hyper-V: Initialize Hyper-V stimer after enabling lapic
Date:   Wed,  4 Aug 2021 14:48:43 -0400
Message-Id: <20210804184843.513524-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V Isolation VM doesn't have PIT/HPET legacy timer and only
provide stimer. Initialize Hyper-v stimer just after enabling
lapic to avoid kernel stuck during calibrating TSC due to no
available timer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 29 -----------------------------
 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6f247e7e07eb..4a643a85d570 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -271,25 +271,6 @@ static struct syscore_ops hv_syscore_ops = {
 	.resume		= hv_resume,
 };
 
-static void (* __initdata old_setup_percpu_clockev)(void);
-
-static void __init hv_stimer_setup_percpu_clockev(void)
-{
-	/*
-	 * Ignore any errors in setting up stimer clockevents
-	 * as we can run with the LAPIC timer as a fallback.
-	 */
-	(void)hv_stimer_alloc(false);
-
-	/*
-	 * Still register the LAPIC timer, because the direct-mode STIMER is
-	 * not supported by old versions of Hyper-V. This also allows users
-	 * to switch to LAPIC timer via /sys, if they want to.
-	 */
-	if (old_setup_percpu_clockev)
-		old_setup_percpu_clockev();
-}
-
 static void __init hv_get_partition_id(void)
 {
 	struct hv_get_partition_id *output_page;
@@ -396,16 +377,6 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
 
-	/*
-	 * hyperv_init() is called before LAPIC is initialized: see
-	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
-	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
-	 * depends on LAPIC, so hv_stimer_alloc() should be called from
-	 * x86_init.timers.setup_percpu_clockev.
-	 */
-	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
-	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
-
 	hv_apic_init();
 
 	x86_init.pci.arch_init = hv_pci_init;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 6b5835a087a3..dcfbd2770d7f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -214,6 +214,20 @@ static void __init hv_smp_prepare_boot_cpu(void)
 #endif
 }
 
+static void (* __initdata old_setup_initr_mode)(void);
+
+static void __init hv_setup_initr_mode(void)
+{
+	if (old_setup_initr_mode)
+		old_setup_initr_mode();
+
+	/*
+	 * The direct-mode STIMER depends on LAPIC and so allocate
+	 * STIMER after calling initr node callback.
+	 */
+	(void)hv_stimer_alloc(false);
+}
+
 static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 {
 #ifdef CONFIG_X86_64
@@ -424,6 +438,7 @@ static void __init ms_hyperv_init_platform(void)
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
 #endif
+
 	/*
 	 * TSC should be marked as unstable only after Hyper-V
 	 * clocksource has been initialized. This ensures that the
@@ -431,6 +446,13 @@ static void __init ms_hyperv_init_platform(void)
 	 */
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
+
+	/*
+	 * Override initr mode callback in order to allocate STIMER
+	 * after initalizing LAPIC.
+	 */
+	old_setup_initr_mode = x86_init.irqs.intr_mode_init;
+	x86_init.irqs.intr_mode_init = hv_setup_initr_mode;
 }
 
 static bool __init ms_hyperv_x2apic_available(void)
-- 
2.25.1

