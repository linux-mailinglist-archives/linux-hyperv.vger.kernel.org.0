Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50372C2DE0
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 18:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390686AbgKXRH5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 12:07:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38969 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390631AbgKXRHz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id s13so3619888wmh.4;
        Tue, 24 Nov 2020 09:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5A3GMg0kaUdhNbdjiZ51gEYmRqMxSWUTkm0nm29z41k=;
        b=Ke798OeulGthIouymUM9kjTbt7oiEgBB92bNnLlxeZbRWFgVSCWPFcMRRUeJ2G+STr
         50iZx7EvTNp3dUe3b2SbmTbSfvjMPb8j1pDeSxIeqyZ3ivLZzpq1/tChTH9LhxIbKN67
         PulnupHQPyrODUUUCXqZfaXmCq/09TivTq7HG+GuehzJTWW/c5nVgyWD/qY5enHUtdoA
         9gsvOWp/XpHaAJlw9BDHRdRAUrwDfVrqvugmmrHiBObJokUS+xUQKmmiUr62WtWXEeFv
         luIAYhk2j7Im8pq6f0WOrQkUFChP2BGH01S2Vc2KK2p9ESnpd8Yyw57OdRQxbjs3FY2o
         TgeQ==
X-Gm-Message-State: AOAM531fR62ThxXbaH549m66XAIHBhp0y8Vfh6XgiOfVeUOXEeZeqkra
        bN/i6hbXHCe/ztus4xvQ+7HfMrco4XI=
X-Google-Smtp-Source: ABdhPJzziczqbqRv+/m75Z5NFEIqUpd7YrBPjfHrMqO939SnayPzpy2yyiDyk17+PkmKjrSoJ+8VMg==
X-Received: by 2002:a1c:9ad0:: with SMTP id c199mr5387178wme.46.1606237672950;
        Tue, 24 Nov 2020 09:07:52 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:07:52 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 05/17] clocksource/hyperv: use MSR-based access if running as root
Date:   Tue, 24 Nov 2020 17:07:32 +0000
Message-Id: <20201124170744.112180-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
References: <20201124170744.112180-1-wei.liu@kernel.org>
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

