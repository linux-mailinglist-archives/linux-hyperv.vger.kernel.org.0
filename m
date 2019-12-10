Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B46118395
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 10:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfLJJbk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 04:31:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJJbj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 04:31:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so19132001wrj.12;
        Tue, 10 Dec 2019 01:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwiTXl+Vx4fgI2/7qKe8sik4xPYI9QSgp6ptv5ekdHw=;
        b=qG5PPhNCpxlC2ZpXXNI0cGQtDw/I5sUr2h3jP3geq6m2gjZEr3NHNnrHzCTBeguKoL
         FGHYTm9zNAyAhPAVdNawehM5YQtVHrh+AWhliYW0dj8wiqFK65kmenl5GVDzwQUgDiem
         6wVJ7/KvKWxTVE9TXQ1DGiHmPj1XcSDbFI7skTve04n80qHjJwupo/mbWfaa3fSJeaQJ
         WKgDHcJw/tJhXEUmMROAErkSQOyTg7xMUycaxbkIfViVDU/njubFt4D6QTn6h320caDg
         uzL2EHSQb4yyecC+geBNHVa3/RSgYwICmJF3HV/ve1aITU4wv/tmGE+rErQTHlppKzxV
         9fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwiTXl+Vx4fgI2/7qKe8sik4xPYI9QSgp6ptv5ekdHw=;
        b=gyA3V8k2RNlAkme+ZFCEeQdiBo9pEZPGtU8bOjQvVUAE/dCR1Y3o78P6Bl+PuhRy5Z
         Cr8WLlWdqxX+bIWAr+jSYvkFXm0rZGTgPokZE8vP5aT5Vjzc51wsNN1sMMh70MPVvU7C
         U0QMC8f1YKh/De6t7VLImyhb858c+lcGiJZhOXs5sVnkOCd6BtqZV9oBKcKe7VV955Hg
         BQeA0OoSeKSPxF8ZfVQJHO6Fd6GydZ6Ew9wV/GuOH+om5U4/SOfQ2VO/OQh8gxuh8gvY
         CLnqwSZJvaaYxmg1bUwuk/QwPQ1YqoYAbIYnpQe6yLBbkwUVOMBNMuCO3lUlLQlPsy1c
         ltAA==
X-Gm-Message-State: APjAAAUD9ktcEtc4uQHcr1KyKHKwaZrBllOrHUg0DDB81SajRLQVaPcs
        EhRf5Efjf2YaKJ/2n/jRZz80mzdNhUHSlD+a
X-Google-Smtp-Source: APXvYqzuOogkIMPJ6MroF8oSoSnVvLU7FOuV14ayAtA2Vb0/Vu7FaTzgyvAtygVaWxUsIua+UvPr2A==
X-Received: by 2002:adf:f484:: with SMTP id l4mr2018847wro.207.1575970296337;
        Tue, 10 Dec 2019 01:31:36 -0800 (PST)
Received: from localhost.localdomain (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id n3sm2372611wmc.27.2019.12.10.01.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:31:35 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 1/2] clocksource/hyperv: Untangle stimers and timesync from clocksources
Date:   Tue, 10 Dec 2019 10:30:53 +0100
Message-Id: <20191210093054.32230-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210093054.32230-1-parri.andrea@gmail.com>
References: <20191210093054.32230-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

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
---
 drivers/clocksource/hyperv_timer.c | 36 +++++++++++++++++++-----------
 drivers/hv/hv_util.c               |  8 +++----
 include/clocksource/hyperv_timer.h |  2 +-
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b6ea3a2093c56..0eb528db4822d 100644
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
 
@@ -328,20 +328,25 @@ static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
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
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 400,
-	.read	= read_hv_clock_tsc,
+	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u64 notrace read_hv_clock_msr(struct clocksource *arg)
+static u64 notrace read_hv_clock_msr(void)
 {
 	u64 current_tick;
 	/*
@@ -353,15 +358,20 @@ static u64 notrace read_hv_clock_msr(struct clocksource *arg)
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
@@ -374,7 +384,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	hyperv_cs = &hyperv_cs_tsc;
+	hv_read_reference_counter = read_hv_clock_tsc;
 	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
@@ -392,7 +402,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_tsc);
 
 	return true;
@@ -414,10 +424,10 @@ void __init hv_init_clocksource(void)
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
index 766bd84573461..296f9098c9e46 100644
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
index 553e539469f04..34eef083c9882 100644
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
2.24.0

