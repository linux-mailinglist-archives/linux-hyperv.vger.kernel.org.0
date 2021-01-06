Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3002EC519
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhAFUel (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:34:41 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52222 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbhAFUek (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:40 -0500
Received: by mail-wm1-f48.google.com with SMTP id v14so3451016wml.1;
        Wed, 06 Jan 2021 12:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5A3GMg0kaUdhNbdjiZ51gEYmRqMxSWUTkm0nm29z41k=;
        b=bPx+Dy5+JxdJok+SaaNykOQfsG1BaOxDD3Bl1K/Nwp9fQSixGMV4c846MH+/MV4CDY
         bosOFtvB/Ehq+h71OBL2qm2Boi/vXx1pNhJJ58mrNEqew/caYC/5XT9PZ43yCRc8S9co
         Al7rzYgRCXE1HqYOeOFGFvBJtMbwN+2Djy52tov7CRErc/+V924FQ1Sts7cbrHobWZ5F
         qgE2n/+d5qZk8I8TMR4k0l3uxpJUQRni4E+w6R/qysDlKCbGVQKvuImjILBGUucyy+eY
         DZR6AzZZmXA464N6Ks917z5vwSAbn1b2pnLXfPnd3wDt2lR4O7+wwpG5PMBUV731WZKi
         y3nw==
X-Gm-Message-State: AOAM533CaMVa9xza+bVoTV31QR5pU4s7pW/fwjSZL7IKswtKW0ljfeFZ
        1XWELXo/uXd20fXjeS3W0cHbV+OxcrI=
X-Google-Smtp-Source: ABdhPJwvCl2JxTR3uAY3juzC/plKXrLUA6gXmSQcGD7Ug/XAUohd/w+1qW3+VYuqND3FQHgpIY08Cg==
X-Received: by 2002:a1c:a9c8:: with SMTP id s191mr5224786wme.89.1609965238215;
        Wed, 06 Jan 2021 12:33:58 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:33:57 -0800 (PST)
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
Subject: [PATCH v4 05/17] clocksource/hyperv: use MSR-based access if running as root
Date:   Wed,  6 Jan 2021 20:33:38 +0000
Message-Id: <20210106203350.14568-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
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

