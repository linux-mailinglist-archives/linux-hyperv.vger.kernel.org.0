Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF6D135DAB
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2020 17:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbgAIQHj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jan 2020 11:07:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgAIQHj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so7982237wrt.6;
        Thu, 09 Jan 2020 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AWQiS1Zy6xD+kqiY62PtsMGlLIsVKYglepV2PLY5WE=;
        b=uh+CBswbvtCPNh1hlhVkH/Ph0wRPSugaz3YEurZK7cKbqGkvIZOnmtmDQ4wyajpVx2
         EN6geoDbJMy8H0Io+wBme/w/7Y274SxrNJOuVtaCJeIB5EXP0UsTbigVuH9T/rN83c1Y
         Ga4FZDhVH935YvDlD+ihmHAqgT16gUuzWHde78h1A9wpd1mwpDaH/oH8IPeI/g5AE541
         kW1s4B6bsh0Kijdiz3R6nEoNKabLnTDVllJO3ut2wq5TcCCyHMLCMWfLo5jfZeCCi0iZ
         jJrMyDYIXC+bnIu5MI3kkGKo4x7/UmuGygs0F/JuMN9BT2CM1Rlo8AYwG3THr2NqQB/L
         W09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AWQiS1Zy6xD+kqiY62PtsMGlLIsVKYglepV2PLY5WE=;
        b=ruN+yfSrtWIUSPt0sFFyqAslOy01/YRW8s9xlishp753e0fseuIQIPxQSs2IW3Tomr
         OpE2gJXqKgOxQwm4JRbSvUsxn9HcSl6mgigDU4DVcXufKlk7YpUTH+k2lhayesio4UCm
         +pjl1/kq36PEWIdbMffTVKJdGJ3jMyMT5JACf6V1QtvK2/fF5NJU9a2YZdkp+BFKz+Zc
         wC/EwTfNw8n2NTfugZhN6pa4OWmm1BmVZqGH422YzUTq3ufsYXeF/tPXz0gmi3clNs6J
         r81UWADPntvVfRoxTnNfWDATcv80J5wmvcChnGQEaSx1SyIYJ+WzErmlOKnh7y2P/dV2
         CoNw==
X-Gm-Message-State: APjAAAWutNiHoB0TnVK9GFMxenXJY85tlIP7rokYSTqiMF82rjZdVz43
        ccALDYXxdnmfBhc9C2ZYl/dWXLHiv/rIwHsk
X-Google-Smtp-Source: APXvYqxurew2u5x1QxhGzoQaJcd/oK2QHCo+4OOqk9SbHR/tmT8N9goDItJsbNGkGarjVVGtJrWIEA==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr11416827wrn.351.1578586057318;
        Thu, 09 Jan 2020 08:07:37 -0800 (PST)
Received: from andrea.access.network ([159.253.226.36])
        by smtp.gmail.com with ESMTPSA id d14sm8615867wru.9.2020.01.09.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:36 -0800 (PST)
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
Subject: [PATCH v2 2/2] clocksource/hyperv: Set TSC clocksource as default w/ InvariantTSC
Date:   Thu,  9 Jan 2020 17:06:50 +0100
Message-Id: <20200109160650.16150-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200109160650.16150-1-parri.andrea@gmail.com>
References: <20200109160650.16150-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Change the Hyper-V clocksource ratings to 250, below the TSC clocksource
rating of 300.  In configurations where Hyper-V offers an InvariantTSC,
the TSC is not marked "unstable", so the TSC clocksource is available
and preferred.  With the higher rating, it will be the default.  On
older hardware and Hyper-V versions, the TSC is marked "unstable", so no
TSC clocksource is created and the selected Hyper-V clocksource will be
the default.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index be98d201d585d..3881c2bf987e4 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -208,6 +208,14 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
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
@@ -269,7 +277,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -301,7 +309,7 @@ static u64 read_hv_sched_clock_msr(void)
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-- 
2.24.0

