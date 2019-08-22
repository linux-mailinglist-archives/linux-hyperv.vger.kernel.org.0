Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E098DDF
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfHVIgg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 04:36:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731368AbfHVIgg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 04:36:36 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66D10882FB
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Aug 2019 08:36:35 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i4so2852086wri.1
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Aug 2019 01:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/CA3yJBePJIOa2lwtouHU0Vi+UpQ8uKRx7RlTCtpQc=;
        b=ByJsXu4+ASioJCZbj/q4jjqhWCu7MnwLRPMue2Ut3LOAv595jZfiHmkq0oNvaj49cF
         PSi3JfAlPN5Xk5nQTCtEi+nNY0y6SBtOitVMEwh4dNbiG8C9MsaBmE9Lfc//DDaJ9ag3
         zHcsNel26jJpU0KNnWfyjMVXMPrv9gfkQ4w0qTwz/5065pESfpXJFdvPnR8s2METMQ4M
         sSBxcp9gh9YWl5FYaJpgcWnnKXA460LocOT4DSaULTrMndZhJDiL6ThFOF4W1rgYhv+D
         u6qaj7aa+IZIf+G9de4Zc3eAoukiS88n6he0//WeM1Vd0HtjIEX43xteSK8p0MGbMwOK
         morw==
X-Gm-Message-State: APjAAAXyg4BxC2ny2pm9qQkCrvAZrkVM0Givc9mel4lvi71H6bcXduxt
        EzgCATq8aKd+sbrwNg/qyhrm+R501OYHjl/jgwpunPHdBKP74wwh61s5GjfKOHuGrh0HBUKO7nF
        Aozw8qJ3oAU2zWpbUDbUwgFkD
X-Received: by 2002:a1c:c747:: with SMTP id x68mr5100315wmf.14.1566462993324;
        Thu, 22 Aug 2019 01:36:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzo+mdWWH//qKkrO86S0TTLfrmI6kauAkuHQ1kwBBRtM296AcoVn/38wmJCRR23uW6v9EcHYQ==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr5100274wmf.14.1566462992973;
        Thu, 22 Aug 2019 01:36:32 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t198sm6138656wmt.39.2019.08.22.01.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 01:36:32 -0700 (PDT)
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
Subject: [PATCH v2] x86/hyper-v: enable TSC page clocksource on 32bit
Date:   Thu, 22 Aug 2019 10:36:30 +0200
Message-Id: <20190822083630.17059-1-vkuznets@redhat.com>
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

Reads from userspace (utilizing vDSO in case of TSC page):
  MSR based clocksource: 5664 cycles
  TSC page clocksource: 131 cycles

Enabling TSC page on 32bits allows to get rid of CONFIG_HYPERV_TSCPAGE as
it is now not any different from CONFIG_HYPERV_TIMER.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v1:
- Fix a couple of nits in changelog [Michael Kelley, Thomas Gleixner]
- Fixed a comment with CONFIG_HYPERV_TSC_PAGE [Michael Kelley]
- Added Michael's Reviewed-by: tag
- Rebased on timers/core [Thomas Gleixner]
---
 arch/x86/include/asm/vdso/gettimeofday.h |  6 +++---
 drivers/clocksource/hyperv_timer.c       | 11 -----------
 drivers/hv/Kconfig                       |  3 ---
 include/clocksource/hyperv_timer.h       |  8 +++-----
 4 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index ae91429129a6..bcbf901befbe 100644
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
@@ -192,7 +192,7 @@ static u64 vread_pvclock(void)
 }
 #endif
 
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 static u64 vread_hvclock(void)
 {
 	return hv_read_tsc_page(&hvclock_page);
@@ -215,7 +215,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode)
 		return vread_pvclock();
 	}
 #endif
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 	if (clock_mode == VCLOCK_HVCLOCK) {
 		barrier();
 		return vread_hvclock();
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index dad8af198e20..51b4d7ba959c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -212,8 +212,6 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 struct clocksource *hyperv_cs;
 EXPORT_SYMBOL_GPL(hyperv_cs);
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-
 static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
 static u64 hv_sched_clock_offset __ro_after_init;
 
@@ -245,7 +243,6 @@ static struct clocksource hyperv_cs_tsc = {
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
-#endif
 
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 {
@@ -272,7 +269,6 @@ static struct clocksource hyperv_cs_msr = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-#ifdef CONFIG_HYPERV_TSCPAGE
 static bool __init hv_init_tsc_clocksource(void)
 {
 	u64		tsc_msr;
@@ -304,13 +300,6 @@ static bool __init hv_init_tsc_clocksource(void)
 
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
index a821deb8ecb2..422f5e5237be 100644
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
@@ -91,7 +89,7 @@ hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
 	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
 }
 
-#else /* CONFIG_HYPERV_TSC_PAGE */
+#else /* CONFIG_HYPERV_TIMER */
 static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
 	return NULL;
@@ -102,6 +100,6 @@ static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 {
 	return U64_MAX;
 }
-#endif /* CONFIG_HYPERV_TSCPAGE */
+#endif /* CONFIG_HYPERV_TIMER */
 
 #endif
-- 
2.20.1

