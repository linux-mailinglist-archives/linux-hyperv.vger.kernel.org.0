Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049A713F0C1
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2020 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404275AbgAPSYA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jan 2020 13:24:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52387 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404202AbgAPSXu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so4812421wmc.2
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Jan 2020 10:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pVwlqM68NaLq0oW83NYHHXkFWXShBvMo0oSKnK8wMuo=;
        b=RKc8ugzOjzsjjVfFnB1IDrwwop0QPgA1IVze1YUH5uR4ScFD634GD24lcW0+dnMNHj
         L1b6kQFNZQ3CQGjv0YZVklOZLjnNZzSqURkcJOSGjHKauYCp3ytva5IMyBYzMhLCmnBY
         KgvDqgH8x2hWCvj+00eLhQmy/ulUwLU7JHlm917qV6FcwX92/7myhl98nbQdTXjCH09r
         qTFGYJFqVDV9B8f4rjTrXYybFFat/rSIgQcUuAinYvvAY5gaeb5B2mhhJlfLlqkzdl7m
         orzscL0pv9Xs6pkgsP2wBhuTj6zm6CVK4rTgrUFBS1m+PwVU3WEJMAyx2BZeexZNXR5J
         JjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pVwlqM68NaLq0oW83NYHHXkFWXShBvMo0oSKnK8wMuo=;
        b=dgM0XrEH18dlBgjsjp2qnaxGJ1Ti+tmdeXYLkvs0P00+B7q28qRsQn70ip8yqYfiZY
         SH/f97p0aKVjk1xiiB6e2lPjlxj06wExT9Gy0fpBJPtLupkG7Yx98Vvhhl9PkdIQFq7K
         JFDMWKcrWOGwxLVtTYH9vVbGY4/Hwx6XiPN+Pq2Jpbb8brR9tIIug5Tbfwpv/I4x/e1f
         mr3iYXOv38cDNuUBhvW6EkfjhH+00FdZU3Z00x6L6SL3bS8YSbv4cw7cA00AUteSxLuT
         n1G602DiAdodXfqkxRnR7CAPrI7Y7LCceNT+/qD1L3Pka70iBW0OopKVUEMuOw0RxBwl
         UsIw==
X-Gm-Message-State: APjAAAUW0StsgFMrLmcKvDelcUpszCxA6f462l4anllefiiwiVIqaVce
        TMgkbY/X8B0Uey02147QSQOybg==
X-Google-Smtp-Source: APXvYqzgmn1aYDt825s41tAgYAKaz3HwAeFgJJc9DZ9GCouYy0HrqiVB9wuMBSlJc58M07r/x1p+gw==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr399860wmg.16.1579199027961;
        Thu, 16 Jan 2020 10:23:47 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:47 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS)
Subject: [PATCH 17/17] clocksource/drivers/hyper-v: Set TSC clocksource as default w/ InvariantTSC
Date:   Thu, 16 Jan 2020 19:23:04 +0100
Message-Id: <20200116182304.4926-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com>

Change the Hyper-V clocksource ratings to 250, below the TSC clocksource
rating of 300.  In configurations where Hyper-V offers an InvariantTSC,
the TSC is not marked "unstable", so the TSC clocksource is available
and preferred.  With the higher rating, it will be the default.  On
older hardware and Hyper-V versions, the TSC is marked "unstable", so no
TSC clocksource is created and the selected Hyper-V clocksource will be
the default.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200109160650.16150-3-parri.andrea@gmail.com
---
 drivers/clocksource/hyperv_timer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 42748adccc98..9d808d595ca8 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -302,6 +302,14 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
  * the other that uses the TSC reference page feature as defined in the
  * TLFS.  The MSR version is for compatibility with old versions of
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
+ *
+ * The Hyper-V clocksource ratings of 250 are chosen to be below the
+ * TSC clocksource rating of 300.  In configurations where Hyper-V offers
+ * an InvariantTSC, the TSC is not marked "unstable", so the TSC clocksource
+ * is available and preferred.  With the higher rating, it will be the
+ * default.  On older hardware and Hyper-V versions, the TSC is marked
+ * "unstable", so no TSC clocksource is created and the selected Hyper-V
+ * clocksource will be the default.
  */
 
 u64 (*hv_read_reference_counter)(void);
@@ -363,7 +371,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -395,7 +403,7 @@ static u64 read_hv_sched_clock_msr(void)
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-- 
2.17.1

