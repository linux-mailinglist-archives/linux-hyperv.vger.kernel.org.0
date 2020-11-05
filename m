Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE572A8451
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgKEQ71 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:59:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45974 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgKEQ6Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:58:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id p1so2576170wrf.12;
        Thu, 05 Nov 2020 08:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4IasveCaJ+y+23uuqqTJDxprJLeTqvGVHfo3rkumMU=;
        b=kyH92wUaud5clfdd7ZCNECm42Q4HuG+Zt8KNZaizCnTf3cp2sgzxAy5glwO22FZojw
         6wOnnM+M3PzV+T4dK8oiNhOVSeRKkxjWg14byp0fRBWx+xVc8VDQ/+e8oM68Vyp6wszX
         UQ//ejhujOeV2qYjdtf81O+f42VNpWoCpJb6VfATGVl2uOivoi//SMCO9Kvmc51IkV/O
         01vsFH/xMS9QE4QqMnXWY84s9fmtCnLhgw3+s2xbpOjP1Uah+NYj60M3o77ABgz+eyH7
         KLKGOpqjLkdn3YZCWDoYPYzXas83x5Gvz3uLrsDfP1/bR3XeTaJ8eoUfwBbd+S8C1Q31
         kbPw==
X-Gm-Message-State: AOAM5308kp8ujoqVHm2xT7/j0iQVL5qh5mtGYwD9apw1YoF8dxOxTxQz
        +2oWhwCFoU/VjB7UiLZe0IQD1inu9Rw=
X-Google-Smtp-Source: ABdhPJwWipEmUJ5fsk3VQywgsSTzQEXTctGLoJldGYDy2YttRYX/viUD5JwYWKbjznXWZZ3anIuvbw==
X-Received: by 2002:adf:de12:: with SMTP id b18mr4214757wrm.187.1604595502222;
        Thu, 05 Nov 2020 08:58:22 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:21 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if running as root
Date:   Thu,  5 Nov 2020 16:58:02 +0000
Message-Id: <20201105165814.29233-6-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Signed-off-by: Wei Liu <wei.liu@kernel.org>
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

