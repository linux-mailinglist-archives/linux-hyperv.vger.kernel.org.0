Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7846150B1
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 18:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKARbH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 13:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKARbF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 13:31:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0C1B1C12E;
        Tue,  1 Nov 2022 10:31:04 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id BA3F720B929F;
        Tue,  1 Nov 2022 10:31:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA3F720B929F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667323864;
        bh=VzS0zv6W20Ej0nTKmhHcYF4peM529wVUYDvHRYTK7Zc=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=OyhwJotSpjmdF+Oolz000h3Z0kXNjN6e/hid2wcKbrphgqXY6so+O9uyRXTZvDsHk
         bz4agA5yLzbTOoB5abTL+ykPmlkTgFOYZRIo+MNGwnatX9ygaMEXpsdltXiTK2IJO+
         7VnnAPds0Vrvx7hWsYI/94joKNq4piiP0uOjusvQ=
Subject: [PATCH 1/4] drivers/clocksource/hyper-v: Introduce a pointer to TSC
 page
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Nov 2022 17:31:04 +0000
Message-ID: <166732386464.9827.16622091938453285710.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

Will be used later keep the address of the remapped page for the root
partition.

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
 drivers/clocksource/hyperv_timer.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 11332c82d1af..c4dbf40a3d3e 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -366,9 +366,11 @@ static union {
 	u8 reserved[PAGE_SIZE];
 } tsc_pg __aligned(PAGE_SIZE);
 
+static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
+
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-	return &tsc_pg.page;
+	return tsc_page;
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
@@ -406,7 +408,7 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
 
 static void resume_hv_clock_tsc(struct clocksource *arg)
 {
-	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
+	phys_addr_t phys_addr = virt_to_phys(tsc_page);
 	union hv_reference_tsc_msr tsc_msr;
 
 	/* Re-enable the TSC page */


