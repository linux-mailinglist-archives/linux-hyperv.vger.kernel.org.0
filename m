Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC42E13F0BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2020 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405291AbgAPSXt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jan 2020 13:23:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50229 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436604AbgAPSXs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so4826986wmb.0
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Jan 2020 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CFUXWCoU1GaVGQJCApPpzIXtOQ4n3RKVnyVBQr+vvTE=;
        b=wMg9yon3wD1KTnh/xP8Axj6tMi+eJVx/FhoC1ZjI9dE8ETWN/mmtlulIKQfMP8WpVn
         PTQoF3XpO9d6PY2vKaXlWBuTZH7vf3cinEM3Ex9mhku5Av1ZHkWr+VLCRam+apC/tJJh
         pI5HKzyjCKwvum7HFOZ+f6ebjYruIJyUE0ieZftumJR4hY2Y4neUELw9/Q2rIuBg1so9
         T9W8j0EhFA7Cce8IclcjJYgX5nc0Kg4rJw0edvi+XlAaidtqGylO/JedAnQnX/ZhqSV5
         yB+mJZezonIZRbW8njrxGu0bjZC8Avf1kpfE2PAmos+eWMHmEK1rrofgJp5/82IGh+Ij
         o62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CFUXWCoU1GaVGQJCApPpzIXtOQ4n3RKVnyVBQr+vvTE=;
        b=eR7nCh5U6akqr/CUhcCtnZFdvA0vYvmrKPlzAGMf1NW7QSMie+I9DYYa6kSxnwh7Ug
         bNhQ7KXONuUpbv5VoMZ9mb0VjvKhufKKtEEoJYadJX7KmyPUX/8chtdN0nSZlEWMV8d2
         Qr/yYwl3Ofxgw6G0iW4oXILNdfr/frac+KU5i2Lzs3HwNyEmgP73Vrxh3k3MmA3X5IXF
         Yzsf5/Xop4wUni32tuShnNRUUm10Msx0CyhtEhV+m9TMgINqryykRxMhTh5Lw8YYTqfe
         aaWQNkfigXU4usb8/IwgaxtYGIgE+BGRRVGUAC+pKSX+bhrq0O4DEo4sSFZNcJg1hjeq
         RUmQ==
X-Gm-Message-State: APjAAAWScfFwUFWXAfD12oO2f2DgpvIPY8mRdTg9Fs2MkDuLmY1ozL5J
        rVM1rkH91j7JzxJPAl9jKm6jxw==
X-Google-Smtp-Source: APXvYqz9p3x889PG53zrjvLa/vVTmAWcumWOPV54Y55x8Fvajo7aI8gThVuh+gL/YS8FgXG4QsYqwQ==
X-Received: by 2002:a1c:3dd5:: with SMTP id k204mr357176wma.92.1579199026511;
        Thu, 16 Jan 2020 10:23:46 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS)
Subject: [PATCH 16/17] clocksource/drivers/hyper-v: Untangle stimers and timesync from clocksources
Date:   Thu, 16 Jan 2020 19:23:03 +0100
Message-Id: <20200116182304.4926-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com>

hyperv_timer.c exports hyperv_cs, which is used by stimers and the
timesync mechanism.  However, the clocksource dependency is not
needed: these mechanisms only depend on the partition reference
counter (which can be read via a MSR or via the TSC Reference Page).

Introduce the (function) pointer hv_read_reference_counter, as an
embodiment of the partition reference counter read, and export it
in place of the hyperv_cs pointer.  The latter can be removed.

This should clarify that there's no relationship between Hyper-V
stimers & timesync and the Linux clocksource abstractions.  No
functional or semantic change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200109160650.16150-2-parri.andrea@gmail.com
---
 drivers/clocksource/hyperv_timer.c | 36 +++++++++++++++++++-----------
 drivers/hv/hv_util.c               |  8 +++----
 include/clocksource/hyperv_timer.h |  2 +-
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 12d75b50a317..42748adccc98 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -66,7 +66,7 @@ static int hv_ce_set_next_event(unsigned long delta,
 {
 	u64 current_tick;
 
-	current_tick = hyperv_cs->read(NULL);
+	current_tick = hv_read_reference_counter();
 	current_tick += delta;
 	hv_init_timer(0, current_tick);
 	return 0;
@@ -304,8 +304,8 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
  */
 
-struct clocksource *hyperv_cs;
-EXPORT_SYMBOL_GPL(hyperv_cs);
+u64 (*hv_read_reference_counter)(void);
+EXPORT_SYMBOL_GPL(hv_read_reference_counter);
 
 static union {
 	struct ms_hyperv_tsc_page page;
@@ -318,7 +318,7 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
+static u64 notrace read_hv_clock_tsc(void)
 {
 	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
@@ -328,9 +328,14 @@ static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 	return current_tick;
 }
 
+static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
+{
+	return read_hv_clock_tsc();
+}
+
 static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
+	return read_hv_clock_tsc() - hv_sched_clock_offset;
 }
 
 static void suspend_hv_clock_tsc(struct clocksource *arg)
@@ -359,14 +364,14 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 400,
-	.read	= read_hv_clock_tsc,
+	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
 };
 
-static u64 notrace read_hv_clock_msr(struct clocksource *arg)
+static u64 notrace read_hv_clock_msr(void)
 {
 	u64 current_tick;
 	/*
@@ -378,15 +383,20 @@ static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 	return current_tick;
 }
 
+static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
+{
+	return read_hv_clock_msr();
+}
+
 static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
+	return read_hv_clock_msr() - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
 	.rating	= 400,
-	.read	= read_hv_clock_msr,
+	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -399,7 +409,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	hyperv_cs = &hyperv_cs_tsc;
+	hv_read_reference_counter = read_hv_clock_tsc;
 	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
@@ -417,7 +427,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_tsc);
 
 	return true;
@@ -439,10 +449,10 @@ void __init hv_init_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
 		return;
 
-	hyperv_cs = &hyperv_cs_msr;
+	hv_read_reference_counter = read_hv_clock_msr;
 	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 766bd8457346..296f9098c9e4 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -211,7 +211,7 @@ static struct timespec64 hv_get_adj_host_time(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host_ts.lock, flags);
-	reftime = hyperv_cs->read(hyperv_cs);
+	reftime = hv_read_reference_counter();
 	newtime = host_ts.host_time + (reftime - host_ts.ref_time);
 	ts = ns_to_timespec64((newtime - WLTIMEDELTA) * 100);
 	spin_unlock_irqrestore(&host_ts.lock, flags);
@@ -250,7 +250,7 @@ static inline void adj_guesttime(u64 hosttime, u64 reftime, u8 adj_flags)
 	 */
 	spin_lock_irqsave(&host_ts.lock, flags);
 
-	cur_reftime = hyperv_cs->read(hyperv_cs);
+	cur_reftime = hv_read_reference_counter();
 	host_ts.host_time = hosttime;
 	host_ts.ref_time = cur_reftime;
 
@@ -315,7 +315,7 @@ static void timesync_onchannelcallback(void *context)
 					sizeof(struct vmbuspipe_hdr) +
 					sizeof(struct icmsg_hdr)];
 				adj_guesttime(timedatap->parenttime,
-					      hyperv_cs->read(hyperv_cs),
+					      hv_read_reference_counter(),
 					      timedatap->flags);
 			}
 		}
@@ -524,7 +524,7 @@ static struct ptp_clock *hv_ptp_clock;
 static int hv_timesync_init(struct hv_util_service *srv)
 {
 	/* TimeSync requires Hyper-V clocksource. */
-	if (!hyperv_cs)
+	if (!hv_read_reference_counter)
 		return -ENODEV;
 
 	spin_lock_init(&host_ts.lock);
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 553e539469f0..34eef083c988 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -30,7 +30,7 @@ extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
 #ifdef CONFIG_HYPERV_TIMER
-extern struct clocksource *hyperv_cs;
+extern u64 (*hv_read_reference_counter)(void);
 extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-- 
2.17.1

