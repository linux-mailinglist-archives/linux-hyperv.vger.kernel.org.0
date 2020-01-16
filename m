Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D713F0D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2020 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405078AbgAPSXT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Jan 2020 13:23:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33787 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404190AbgAPSXS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so20215498wrq.0
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Jan 2020 10:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9F6cbFc8MWLMRVXLq32wbzz9Kc9aRwk3yX4Xas8bss=;
        b=uM1d8VSmZZEDzRFh4G+Dl1YcFQ3A4IkT4iX5O2Q5yIdRYJ4u11XY+kKfiARvf1Dxbm
         AxWD5RspyGhLSTapb0Bk0W9/hPr3ay3FQwLPZi2P3pX3DSdldd0SZQt46Fqe3Q6fcz8Y
         vpxloEvz2j5siGPCupbKWMRVfEx1nPoJlS9iUsbOs7waxMYjdJGglZzahSb3M77AFPEH
         cWgX5YUYkOkUFzKGMrm3eWmAen/c8dGL6siCHMi0g6g4zKbCLYWqASlFDaKJzp6hO3bm
         R2mdkbSPjg/V9huALrb+01zXL8B3X9JbvoAtpp5uZQ65P2jVWbOK/AVSyRluofc+Opkc
         uFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9F6cbFc8MWLMRVXLq32wbzz9Kc9aRwk3yX4Xas8bss=;
        b=Uo8eWhdb/fh0KWdGvs13GeTnZbkOvq2DQ3B1VLFvFj9y7LYJNuGl76wQfILkaaBfbl
         byS1b1nKBoOTvwsSNQ/i+b01vrDk4ipk9bSQ9F8VIEdCg0jhJChUEs6eFXCWciy2eo3p
         CXcato1mBSoit1bxZnLNK2q6RwGYATq9zPenn5yoiMOhHi55S9tRSKFq3YAylYKxuOiL
         sv1KyQUAj5GWQ3GZ/cnfdIF+L9tbSjslupYUsn/OPeHOZ+l/m/tJQnlfd9qDPYrT/Z19
         ZRSe3GzGUxsI5G7kTKp5yVjE4YbRcvpAEwrW5mbSqcCe332pVPY/xZUcSW5GfKmw1iN2
         1YNQ==
X-Gm-Message-State: APjAAAURWfJ3cGY46Bl+Og3xsQ98n1tjMckSM5LMRMkq/z7dsiet576Y
        L/k++aQMTQgGyI3qT3pMth5Kf0ttdLu0Cg==
X-Google-Smtp-Source: APXvYqwoCn4hBCC+0/xS3tPJId3zBSKv5xWcoMMTaUBuT+gcV1DRDV3+D3pCf+Td4gXXKuNNsYYz3A==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr4809753wrp.182.1579198996620;
        Thu, 16 Jan 2020 10:23:16 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:16 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS)
Subject: [PATCH 01/17] clocksource/drivers/hyper-v: Suspend/resume Hyper-V clocksource for hibernation
Date:   Thu, 16 Jan 2020 19:22:48 +0100
Message-Id: <20200116182304.4926-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1574233946-48377-1-git-send-email-decui@microsoft.com
---
 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 287d8d58c21a..1aec08e82b7a 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -330,12 +330,37 @@ static u64 read_hv_sched_clock_tsc(void)
 	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
 
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= GENMASK_ULL(11, 0);
+	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 400,
 	.read	= read_hv_clock_tsc,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend= suspend_hv_clock_tsc,
+	.resume	= resume_hv_clock_tsc,
 };
 
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
-- 
2.17.1

