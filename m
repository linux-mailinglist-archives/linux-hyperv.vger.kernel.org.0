Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80862268A90
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Sep 2020 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgINLjQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 07:39:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51180 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgINL2R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 07:28:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id e17so10265501wme.0;
        Mon, 14 Sep 2020 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6J2CzwhXftwm/TeG9EFVnDtNUf/94TE8a1c2ax2Kwg=;
        b=d8pM2i+c1tHgt18SQRb1kuFYEjUS07QWtkz4icFN4oTeKk6RKeCFx7dUMm0+vJEuUE
         /rs4MflxUfY5JL13EYIlP0sj0RnEZlVHZY8+kaR4fZc/kMDmudFyaLCT2qwJP3UGT8Gl
         WEEsRWdYx9A041h19X3ZEbQppaOQHJfNCurEjKDAeI+GJGCxuvP5wKbGuXbf/sHigg1x
         +BG/e8P+OJO+jt04OjDMFkj8DpvzZxM7qA465Zhb4E1kTxCMpvesZSocYHF8ynceHb+f
         Mkri8lqcya9k3CoIrS1v8Qppyb3mCFivF7Yew08vrAjep/nT7Ot/Qc6Ml79DZXeIlCLe
         Kf+A==
X-Gm-Message-State: AOAM532GlgVWMCZdFyKsexJyBXs293R7pCHThLWPEK8WaUiPGwQYa/zT
        ZDEmPrsBAsq0TfdRG0sqQmaybmMo940=
X-Google-Smtp-Source: ABdhPJxyG58IEEeo6bVincS3/LIJYG+JR5JSj95TDGfTR8oRCgp7Yjj46VhZJ4jq6VOuMWvHkTyFDQ==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr14220116wmc.62.1600082895118;
        Mon, 14 Sep 2020 04:28:15 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:14 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RFC v1 05/18] clocksource/hyperv: use MSR-based access if running as root
Date:   Mon, 14 Sep 2020 11:27:49 +0000
Message-Id: <20200914112802.80611-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/clocksource/hyperv_timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 09aa44cb8a91..fe96082ce85e 100644
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

