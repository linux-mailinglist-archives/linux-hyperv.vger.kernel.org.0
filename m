Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC269768B
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfHUJ5A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 05:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfHUJ45 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 05:56:57 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1678A811BF
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Aug 2019 09:56:56 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i4so989364wri.1
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Aug 2019 02:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JOVqz1l35vJZ23KPBu9ziZO2Il+lGFYoleDymVgdcKA=;
        b=Q8Xq7eLsnvkhJt72CnQXikYbvHuYYImc2gUgVM7oDgRdrWY6EwZiEiEfg6VLZKOGO/
         x7URfRdFazgQdu9QnBRvyDKUeGWDttlVFSZj4fsUnf0EoOl8WiiReblHJM1YEK+opuVS
         DnZLee9pfzAMeLl+gfsrxdaOBvIz0jaSS0N2gDthd0LpU/zfDb2j0ok5DSfRXUQtoU0x
         zo5+q8kF5VwbauofEPcZWGOQBbtymU4n2wd2VVJhrY3U8XBduvn+y4WWzDXyw47Omhbe
         DKLu3guWLAJuW2WaGlz4F6jerxtLp1v+6BmE+bewkC/Ourou3a15qStcCddebUKSqagm
         YXLA==
X-Gm-Message-State: APjAAAUpnAjEKRkCOIA56AGbOpXWaUj2C1qtVR8WhtkgGRaaX9W18eT0
        zgU91MgJVb9SxMXqp3hp09Qv8eS1FT36+RhSoHpBRRh8Ldv7weLtFJsR3msPTSipgGV7j8OHPuH
        OXP0qJkyUTDLGzgnaOyfSGTvi
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr39913685wrv.155.1566381414343;
        Wed, 21 Aug 2019 02:56:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhhUql7+ZyKhnIUaI4qLrkDP5iPcpcLFTYf0YurYLpd+8qazbz3a0zv9Hd1gJ0CxdPSR6rmQ==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr39913652wrv.155.1566381414103;
        Wed, 21 Aug 2019 02:56:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id j16sm18795169wrp.62.2019.08.21.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 02:56:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/hyper-v: enable TSC page clocksource on 32bit
Date:   Wed, 21 Aug 2019 11:56:50 +0200
Message-Id: <20190821095650.1841-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no particular reason to not enable TSC page clocksource
on 32-bit. mul_u64_u64_shr() is available and despite the increased
computational complexity (compared to 64bit) TSC page is still a huge
win compared to MSR-based clocksource.

In-kernel reads:
  MSR based clocksource: 3361 cycles
  TSC page clocksource: 49 cycles

Reads from userspace (unilizing vDSO in case of TSC page):
  MSR based clocksource: 5664 cycles
  TSC page clocksource: 131 cycles

Enabling TSC page on 32bits allows us to get rid of CONFIG_HYPERV_TSCPAGE
as it is now not any different from CONFIG_HYPERV_TIMER.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/vdso/gettimeofday.h |  6 +++---
 drivers/clocksource/hyperv_timer.c       | 11 -----------
 drivers/hv/Kconfig                       |  3 ---
 include/clocksource/hyperv_timer.h       |  6 ++----
 4 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index ba71a63cdac4..e9ee139cf29e 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -51,7 +51,7 @@ extern struct pvclock_vsyscall_time_info pvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
@@ -228,7 +228,7 @@ static u64 vread_pvclock(void)
 }
 #endif
 
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 static u64 vread_hvclock(void)
 {
 	return hv_read_tsc_page(&hvclock_page);
@@ -251,7 +251,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode)
 		return vread_pvclock();
 	}
 #endif
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 	if (clock_mode == VCLOCK_HVCLOCK) {
 		barrier();
 		return vread_hvclock();
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba2c79e6a0ee..b6083faab540 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -212,8 +212,6 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 struct clocksource *hyperv_cs;
 EXPORT_SYMBOL_GPL(hyperv_cs);
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-
 static struct ms_hyperv_tsc_page *tsc_pg;
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
@@ -244,7 +242,6 @@ static struct clocksource hyperv_cs_tsc = {
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
-#endif
 
 static u64 notrace read_hv_sched_clock_msr(void)
 {
@@ -271,7 +268,6 @@ static struct clocksource hyperv_cs_msr = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-#ifdef CONFIG_HYPERV_TSCPAGE
 static bool __init hv_init_tsc_clocksource(void)
 {
 	u64		tsc_msr;
@@ -306,13 +302,6 @@ static bool __init hv_init_tsc_clocksource(void)
 	sched_clock_register(read_hv_sched_clock_tsc, 64, HV_CLOCK_HZ);
 	return true;
 }
-#else
-static bool __init hv_init_tsc_clocksource(void)
-{
-	return false;
-}
-#endif
-
 
 void __init hv_init_clocksource(void)
 {
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 9a59957922d4..79e5356a737a 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -14,9 +14,6 @@ config HYPERV
 config HYPERV_TIMER
 	def_bool HYPERV
 
-config HYPERV_TSCPAGE
-       def_bool HYPERV && X86_64
-
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
 	depends on HYPERV && CONNECTOR && NLS
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index a821deb8ecb2..f72e4619d0a7 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -28,12 +28,10 @@ extern void hv_stimer_cleanup(unsigned int cpu);
 extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
-#if IS_ENABLED(CONFIG_HYPERV)
+#ifdef CONFIG_HYPERV_TIMER
 extern struct clocksource *hyperv_cs;
 extern void hv_init_clocksource(void);
-#endif /* CONFIG_HYPERV */
 
-#ifdef CONFIG_HYPERV_TSCPAGE
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
 static inline notrace u64
@@ -102,6 +100,6 @@ static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 {
 	return U64_MAX;
 }
-#endif /* CONFIG_HYPERV_TSCPAGE */
+#endif /* CONFIG_HYPERV_TIMER */
 
 #endif
-- 
2.20.1

