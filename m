Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6592EB1CD
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbhAERv3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 12:51:29 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44195 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAERv3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 12:51:29 -0500
Received: by mail-wr1-f43.google.com with SMTP id w5so20440wrm.11;
        Tue, 05 Jan 2021 09:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JIQuW/4RpxsmZTrmBPjCy0e3BYyOVCHG2XSMv9AGbhM=;
        b=NxIo9zIxrafnEJ1eOpBYYdpu5RdiQffsDQuPEK1GwJ6zZH+4lnVjts415nXLuoWC8l
         bJnWLaVzVkNXygwA180gXTw+znEEwmC2oB4LR9Rqki9Bnu04AMSmuSOsPFMx0HwPa1sl
         CjuNHmg1r+keoZ8CIcFPXeXkfTanGo0xovhY0aLoM/6E5OccEODnSpJCwiok17kk1mk2
         5ZDax1rg1b1RRJ/XrZrbgTE9K68CNMQSfwv8iryMx1RcXyJh4yyR+bkzwXjvLC4MXdkw
         syCFya+CRbMZ/LUg+yj2ImzJJt/7GViDcjKrbdUqoAtCJWUFO/Df9P//SgWtD3BJRw6k
         +I1Q==
X-Gm-Message-State: AOAM5334TmzYu4q6b1Q0Km7YFBjkoQx2br6pPfbDjbhgU62OUrFWBLuK
        uBa6ZDDgy2Z0X8t/SvHrcKFaHGoR4BI=
X-Google-Smtp-Source: ABdhPJyAEkNelFFT15/GLep1blSMItUti0XTeZeTXbg2s8XQRKEC+3xjT/4ML40CtyeCmZDbHWgbFg==
X-Received: by 2002:adf:8290:: with SMTP id 16mr670660wrc.27.1609869047148;
        Tue, 05 Jan 2021 09:50:47 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r20sm285596wmh.15.2021.01.05.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:50:46 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, stable@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] x86/hyperv: check cpu mask after interrupt has been disabled
Date:   Tue,  5 Jan 2021 17:50:43 +0000
Message-Id: <20210105175043.28325-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We've observed crashes due to an empty cpu mask in
hyperv_flush_tlb_others.  Obviously the cpu mask in question is changed
between the cpumask_empty call at the beginning of the function and when
it is actually used later.

One theory is that an interrupt comes in between and a code path ends up
changing the mask. Move the check after interrupt has been disabled to
see if it fixes the issue.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Cc: stable@kernel.org
---
 arch/x86/hyperv/mmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 5208ba49c89a..2c87350c1fb0 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -66,11 +66,17 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	if (!hv_hypercall_pg)
 		goto do_native;
 
-	if (cpumask_empty(cpus))
-		return;
-
 	local_irq_save(flags);
 
+	/*
+	 * Only check the mask _after_ interrupt has been disabled to avoid the
+	 * mask changing under our feet.
+	 */
+	if (cpumask_empty(cpus)) {
+		local_irq_restore(flags);
+		return;
+	}
+
 	flush_pcpu = (struct hv_tlb_flush **)
 		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
-- 
2.20.1

