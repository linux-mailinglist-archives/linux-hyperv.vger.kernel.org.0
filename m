Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82F135DA9
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2020 17:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgAIQHd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jan 2020 11:07:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40201 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgAIQHd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so7966835wrn.7;
        Thu, 09 Jan 2020 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzdiFXa6FS9A5Vmh17F3Pjwm5GqAcPtlnzLi+OFU9zg=;
        b=Wmk0zSUR6Q8WzsuhMTvt5F5ODwgJqBBH1Jr6l6t45JmILPRJwoYcwUQ22C0a/Ztbe2
         EXzOS54ygtEAW4O7cEKLWwbLYqtyaKSquKOLUNNrnSOb6/MYkHgpZuWFdr9A0UIEYwMl
         kolOpcBEHOtw1I0hHRAMsPWhG+qtzYAMSjNbaEUGtZWnJIwaFU1JkuqfVykNHUDvRfm2
         2p7GA8AKltDztKxBalaphJEVs/2qQ4Q/dhJDpjW2Q1OnPd3oE7LMEijOVn9wqKTQyi/H
         ueDb8GIt8WazNPeMd+3tipSgqP+coiX6iVLi7z9dcerhG0N/MbAbHQzbeAgQn42CxGNO
         AyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzdiFXa6FS9A5Vmh17F3Pjwm5GqAcPtlnzLi+OFU9zg=;
        b=aI7aiWrEOnjN+ik/3jX+ZzD/lM9l1SPvrhg4AiEhUIi6iHbEdqLLtFSPw3Snm4fgN8
         3YJ++xs3sPQdYSRsWoT5ToLTIWE+pIp/Se7yI7bpQmjXruDAJARlYnzHjk6S1y+CQ4yN
         GmnNkhniwT3wbJYwovy4na5THlXkNtUmYfqA8R7Thupd5TGqzONDcLayCK8ouvFyKP2h
         LeHjrnNZtSuSMJKKtoLeNF9H0Vi1gXBq+fzNpMp5E9lCZoczvtYFra3J2+OBNJBaRMkB
         l1KvjfTPSZpTqeUqSavkXHUpZcQPLKssHCyDS/spQ9ZCVLGaBVCKHYTkD/u2Ldx23OuM
         wMKw==
X-Gm-Message-State: APjAAAVF0PTCNwzwiPvaX0X8peVYyBYYrixFYwxRCB8Ch2zi4FYNBsQs
        VxkDqYDSEBvmQ8q8PFbUCHTYnI7pXoPlVXOV
X-Google-Smtp-Source: APXvYqyz9zJXK5tZKY07/VMUZ9hfKx0LytnKmAmo2ALoHdEA2Ul4MsAo4uj8MGOfFIIP4+ZA8iT0LQ==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr11741822wrr.116.1578586050434;
        Thu, 09 Jan 2020 08:07:30 -0800 (PST)
Received: from andrea.access.network ([159.253.226.36])
        by smtp.gmail.com with ESMTPSA id d14sm8615867wru.9.2020.01.09.08.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:29 -0800 (PST)
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
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2 1/2] clocksource/hyperv: Untangle stimers and timesync from clocksources
Date:   Thu,  9 Jan 2020 17:06:49 +0100
Message-Id: <20200109160650.16150-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200109160650.16150-1-parri.andrea@gmail.com>
References: <20200109160650.16150-1-parri.andrea@gmail.com>
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 36 +++++++++++++++++++-----------
 drivers/hv/hv_util.c               |  8 +++----
 include/clocksource/hyperv_timer.h |  2 +-
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 51ff43274db7b..be98d201d585d 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -56,7 +56,7 @@ static int hv_ce_set_next_event(unsigned long delta,
 {
 	u64 current_tick;
 
-	current_tick = hyperv_cs->read(NULL);
+	current_tick = hv_read_reference_counter();
 	current_tick += delta;
 	hv_init_timer(0, current_tick);
 	return 0;
@@ -210,8 +210,8 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
  */
 
-struct clocksource *hyperv_cs;
-EXPORT_SYMBOL_GPL(hyperv_cs);
+u64 (*hv_read_reference_counter)(void);
+EXPORT_SYMBOL_GPL(hv_read_reference_counter);
 
 static union {
 	struct ms_hyperv_tsc_page page;
@@ -224,7 +224,7 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
+static u64 notrace read_hv_clock_tsc(void)
 {
 	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
@@ -234,9 +234,14 @@ static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
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
@@ -265,14 +270,14 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
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
@@ -284,15 +289,20 @@ static u64 notrace read_hv_clock_msr(struct clocksource *arg)
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
@@ -305,7 +315,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	hyperv_cs = &hyperv_cs_tsc;
+	hv_read_reference_counter = read_hv_clock_tsc;
 	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
@@ -323,7 +333,7 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_tsc);
 
 	return true;
@@ -345,10 +355,10 @@ void __init hv_init_clocksource(void)
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
index e32681ee7b9f6..ef338db3d3599 100644
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
@@ -523,7 +523,7 @@ static struct ptp_clock *hv_ptp_clock;
 static int hv_timesync_init(struct hv_util_service *srv)
 {
 	/* TimeSync requires Hyper-V clocksource. */
-	if (!hyperv_cs)
+	if (!hv_read_reference_counter)
 		return -ENODEV;
 
 	spin_lock_init(&host_ts.lock);
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 422f5e5237be4..373a3ece88121 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -29,7 +29,7 @@ extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
 #ifdef CONFIG_HYPERV_TIMER
-extern struct clocksource *hyperv_cs;
+extern u64 (*hv_read_reference_counter)(void);
 extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-- 
2.24.0

