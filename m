Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB24F118397
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 10:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfLJJbr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 04:31:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJJbr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 04:31:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so19204164wro.2;
        Tue, 10 Dec 2019 01:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpI+KSQjVizekLOTqRO9QHhCCkeA25xOcgVNFSMIVJ4=;
        b=a+MeZ1Vrjiw5Y7skASSivWiCZqb/XvferZcrYNnkoSGw/nmgJX645OcRxXyTPnQOWZ
         PRPo/kAAL+oGi32ezRt2Au6WjY8i35tMWo8FsQLlBwuLyHODXFSOTDw+IMhmS6QBkeko
         Pu5olkeP8uSzjS6fhX4KgBfsBhHmPZsgKQB9Cy+8JlVG25n7T4sKBREGBSPk0OdrhuQx
         /EjkcNTW5BqcIOjlEpHQPN8dxB7XuhzY4HLy1atEth0MZebZpvoOXhxbvTLte+u/AnZI
         z42tg3m6fVRKyv4lbIFSiSWjaz93D8upIY/vZZwVdO1IqMLwlmHtXmqczYwJnhhSYSJj
         7VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpI+KSQjVizekLOTqRO9QHhCCkeA25xOcgVNFSMIVJ4=;
        b=kZxzVS1LlCZl3xrboppiKca2RVCo+kRIWUFsOIJ2YKeOPAD2r1MxQFWjoSMfBSkCdy
         YnFzMFh1gFVcY0KbKdlcDbJorRsvpen0N2rO9bq/xJL96WHAZ/+BVIvnvfjLLiRZMHRT
         mUp8wCSmLo9zSQicptbXRrVY5eY/07NKtogJMr6LvEGRgQBxlEeBzXJs0PUhXjWexKOA
         TPRyYhLvURzzB5p352IxILNPl53R/3BGg08+9k6xBkYVbQDKu2CxEki8fGcpjYxozb5M
         ZJRNoHDbSfMB04Upkk94X2br0UrToWA30cm7OcA0R4bM/vjdoNp5AVzWyT1uB016U7O0
         84jw==
X-Gm-Message-State: APjAAAV9iV7WCoIom6AiZ2Q0bpqEcPiAQTARjICgvF9b/tqpH7bDMChC
        gObL81/kIJZUGeWVQ4B+b1gQRiFQqEfF285e
X-Google-Smtp-Source: APXvYqxWGiaybhCl9DlfGoAm1B5j8O5erlMSACMm9aif0qYGOKaX9NqvbLu4rN9iI1ca4/OPF4INig==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr2102243wru.150.1575970304470;
        Tue, 10 Dec 2019 01:31:44 -0800 (PST)
Received: from localhost.localdomain (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id n3sm2372611wmc.27.2019.12.10.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:31:43 -0800 (PST)
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
Subject: [PATCH 2/2] clocksource/hyperv: Set TSC clocksource as default w/ InvariantTSC
Date:   Tue, 10 Dec 2019 10:30:54 +0100
Message-Id: <20191210093054.32230-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210093054.32230-1-parri.andrea@gmail.com>
References: <20191210093054.32230-1-parri.andrea@gmail.com>
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
---
 drivers/clocksource/hyperv_timer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 0eb528db4822d..6a92f945916d4 100644
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
@@ -340,7 +348,7 @@ static u64 read_hv_sched_clock_tsc(void)
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_tsc_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -370,7 +378,7 @@ static u64 read_hv_sched_clock_msr(void)
 
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 400,
+	.rating	= 250,
 	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-- 
2.24.0

