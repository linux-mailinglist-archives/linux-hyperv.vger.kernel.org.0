Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF0453E0BF
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jun 2022 08:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiFFF2z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jun 2022 01:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiFFF2R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jun 2022 01:28:17 -0400
X-Greylist: delayed 167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jun 2022 22:10:19 PDT
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B513C1EE;
        Sun,  5 Jun 2022 22:10:18 -0700 (PDT)
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-02.nifty.com with ESMTP id 256547AF021526;
        Mon, 6 Jun 2022 14:04:19 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 25652gOh011474;
        Mon, 6 Jun 2022 14:02:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 25652gOh011474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654491764;
        bh=fe9PsgfIFxKcSrvbsk+3O4QEH1o6xyD9G98e0hlENu4=;
        h=From:To:Cc:Subject:Date:From;
        b=J4idJDLliOL/8DeR5nGQQ2niDlZAIc3RakMevfSYF1S8fMMDf7vJXp/Kod69RdRBu
         pebb1wNXk2zWAyp6pjp0FCsor4vevekziwRM1BKBt283vZTSOOQA0B6W9zbFOYog/P
         IaKkq2XWMkrVdugNWkzXMtxkc3JgSeUFvieNwLy5VL/PWabzoc+yj+B0qbspiTzWGQ
         MS7+Jy/D+ymgiPz/0LlbBbLPG5l5E2TTUrSNfIRTrfb3H2xTTQ1oBL0N9CFQJGqCdL
         y1VFBCFOqgaOWSvaDzUg89R4VffE1o17U6tTlMB8iTXvyIXRFnF28ZlUMLByeU2HfA
         Uu3y5YIzO0zUg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: hyper-v: unexport __init-annotated hv_init_clocksource()
Date:   Mon,  6 Jun 2022 14:02:38 +0900
Message-Id: <20220606050238.4162200-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

EXPORT_SYMBOL and __init is a bad combination because the .init.text
section is freed up after the initialization. Hence, modules cannot
use symbols annotated __init. The access to a freed symbol may end up
with kernel panic.

modpost used to detect it, but it has been broken for a decade.

Recently, I fixed modpost so it started to warn it again, then this
showed up in linux-next builds.

There are two ways to fix it:

  - Remove __init
  - Remove EXPORT_SYMBOL

I chose the latter for this case because the only in-tree call-site,
arch/x86/kernel/cpu/mshyperv.c is never compiled as modular.
(CONFIG_HYPERVISOR_GUEST is boolean)

Fixes: dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/clocksource/hyperv_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ff188ab68496..bb47610bbd1c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -565,4 +565,3 @@ void __init hv_init_clocksource(void)
 	hv_sched_clock_offset = hv_read_reference_counter();
 	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
-EXPORT_SYMBOL_GPL(hv_init_clocksource);
-- 
2.32.0

