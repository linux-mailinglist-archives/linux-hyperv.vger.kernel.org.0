Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9A2FD0DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbhATM6K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 07:58:10 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:33007 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388968AbhATMJh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 07:09:37 -0500
Received: by mail-wm1-f49.google.com with SMTP id s24so3177337wmj.0;
        Wed, 20 Jan 2021 04:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5A3GMg0kaUdhNbdjiZ51gEYmRqMxSWUTkm0nm29z41k=;
        b=kAAZHac1+37YvXavuj8on0rR4tqGWcXE/b111YTWJwBAjN+hVOhO5MX+bsAmn+R6Vs
         f2mRkUDxg5hu5swXPQbDY36TorPjr/gmjm8Fb/O1ok4fpqWPjwYCS7N4+i7Ad8yj5q97
         9rNfLPtvLMwG0fllkZUUzU17prYVY0dLB4OoRMdfpLvrWFt+j/m0R0Bv8BfAoCsU/dcp
         cvEsYjQA+uX58L1SJfmJWTVA+wOUGEvjF8ahY6yGXtGGJ5yJCF3St33ya7SAmWlPoigP
         2Fq4kLPGLtbceimIx+uPcGzfC5o3Fh4qGtBXm9OY5jU8x3BsvdSKmmSnw/cKf/iqaBa/
         bz5A==
X-Gm-Message-State: AOAM530O5n6uOI+Vgwn/lM2r9xVb2ra+Hb6MUp9YLXymjVRBmWgwkp6b
        IIL+3wfYFDxEZTVCWjI7fKbNJ7X3D/M=
X-Google-Smtp-Source: ABdhPJyQr6BxuZzUmIdJoHYiyF+bREIDk1LpO+epJwZJPEq8zTUSZTSI+GStFHpoGPHynTvJUbr3mw==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr4162973wmd.4.1611144066451;
        Wed, 20 Jan 2021 04:01:06 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:06 -0800 (PST)
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
Subject: [PATCH v5 05/16] clocksource/hyperv: use MSR-based access if running as root
Date:   Wed, 20 Jan 2021 12:00:47 +0000
Message-Id: <20210120120058.29138-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
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

