Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3DD30DDD7
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 16:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhBCPPy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 10:15:54 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:34608 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhBCPFX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:23 -0500
Received: by mail-wm1-f46.google.com with SMTP id o10so4135554wmc.1;
        Wed, 03 Feb 2021 07:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHy0KwnAzp3tkRfraJo+vCO/BYi9ytTwN+69RhVts4k=;
        b=Vc8AohlEHewBGdLv3V7QW7miM9vYCcYWqhhpE1B7OElXmYEb11vIZBfuXQYb8IYRdI
         WgSb5Og2mzcCFhgAujRjFiXXJWK5nbMlR/14JvTCAtj0MSrL+ur7LdUTVOUj0aGH4Cvl
         oJa4c4DqfYLhDqgi2A+FeTf6RMbPIXdJLv/CiSvSn9jWV/E5zeexLMXpgL165AywmKka
         vRkydIelhlEuUcIvsMPxZ99sg5qk8eUGrMT6Y4v25DAAH0SxWQssJOtui48JdIL5vsn2
         5whoaYuB19LGEqtZNfVKibP8jTGYrfsytlK7usdoRegDw4B/MuHT5nN5tYWDE6J93qfR
         YX3A==
X-Gm-Message-State: AOAM533i19YRKzr6D8mPw3cY309xDuR+3MGOBHav8EWxWCutYvFRgHyB
        ci3Wvr992BxMO1XDaskHCCNDMfARLsk=
X-Google-Smtp-Source: ABdhPJwP1J6Y96OIC3cFuSvN2yxsRs3rdExvqldf5IEQ8TJSlwZSi/Id/hxQ064kwhNtqwNaIMdEKw==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr3214517wmg.154.1612364681630;
        Wed, 03 Feb 2021 07:04:41 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:41 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v6 04/16] clocksource/hyperv: use MSR-based access if running as root
Date:   Wed,  3 Feb 2021 15:04:23 +0000
Message-Id: <20210203150435.27941-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Linux runs as the root partition, the setup required for TSC page
is different. Luckily Linux also has access to the MSR based
clocksource. We can just disable the TSC page clocksource if Linux is
the root partition.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba04cb381cd3..269a691bd2c4 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
+	if (hv_root_partition)
+		return false;
+
 	hv_read_reference_counter = read_hv_clock_tsc;
 	phys_addr = virt_to_phys(hv_get_tsc_page());
 
-- 
2.20.1

