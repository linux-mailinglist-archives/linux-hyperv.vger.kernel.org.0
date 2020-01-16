Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD90B13FB7E
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2020 22:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbgAPVbJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jan 2020 16:31:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53555 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388967AbgAPVbI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jan 2020 16:31:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCjI-0001YR-HB; Thu, 16 Jan 2020 22:31:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A163B1C198E;
        Thu, 16 Jan 2020 22:31:02 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:31:02 -0000
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/hyper-v: Reserve PAGE_SIZE
 space for tsc page
Cc:     "Boqun Feng (Microsoft)" <boqun.feng@gmail.com>,
        linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191126021723.4710-1-boqun.feng@gmail.com>
References: <20191126021723.4710-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <157921026244.396.8479855058532744201.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ddc61bbc45017726a2b450350d476b4dc5ae25ce
Gitweb:        https://git.kernel.org/tip/ddc61bbc45017726a2b450350d476b4dc5ae25ce
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 26 Nov 2019 10:17:20 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 16 Jan 2020 19:07:09 +01:00

clocksource/drivers/hyper-v: Reserve PAGE_SIZE space for tsc page

Currently, the reserved size for a tsc page is 4K, which is enough for
communicating with hypervisor. However, in the case where we want to
export the tsc page to userspace (e.g. for vDSO to read the
clocksource), the tsc page should be at least PAGE_SIZE, otherwise, when
PAGE_SIZE is larger than 4K, extra kernel data will be mapped into
userspace, which means leaking kernel information.

Therefore reserve PAGE_SIZE space for tsc_pg as a preparation for the
vDSO support of ARM64 in the future. Also, while at it, replace all
reference to tsc_pg with hv_get_tsc_page() since it should be the only
interface to access tsc page.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Cc: linux-hyperv@vger.kernel.org
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191126021723.4710-1-boqun.feng@gmail.com
---
 drivers/clocksource/hyperv_timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 1aec08e..12d75b5 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -307,17 +307,20 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 struct clocksource *hyperv_cs;
 EXPORT_SYMBOL_GPL(hyperv_cs);
 
-static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
+static union {
+	struct ms_hyperv_tsc_page page;
+	u8 reserved[PAGE_SIZE];
+} tsc_pg __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-	return &tsc_pg;
+	return &tsc_pg.page;
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
 static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 {
-	u64 current_tick = hv_read_tsc_page(&tsc_pg);
+	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
 	if (current_tick == U64_MAX)
 		hv_get_time_ref_count(current_tick);
@@ -397,7 +400,7 @@ static bool __init hv_init_tsc_clocksource(void)
 		return false;
 
 	hyperv_cs = &hyperv_cs_tsc;
-	phys_addr = virt_to_phys(&tsc_pg);
+	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
