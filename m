Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FBA18F555
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 14:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgCWNJz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 09:09:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33080 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgCWNJo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so5911041plq.0;
        Mon, 23 Mar 2020 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dg0exrkEoHo78ZPEniVivraP1002Vfe0bXH02uY3wQ0=;
        b=isxygoQkQcjdj9FqpO4DKnpZYcMG/YwsFlVoandcd3y1BeftbSVw1thksLPO96ue43
         JXfD4RtDrZDaBMSzrTSzT+uKzeo3e146IZAvqAVXDDXgn+AH9bhzCvdg1Hjifaoj20Qm
         YEfXGKGtXw7XmbWdtVzlIUp0R+7cSARN5+jVUlSRh5vYCvkAmlQXTk/5e0J0g/jYv06I
         xGYnBgLAyt5XahdWX5/9J8GjK/z1IUFB8YIbXmD9o1ANXaSu2dqdi4fUzaImIhxZdUbo
         swK9tmCrqGIYW4PMJZvCrGT7dRHXV/dXn194aX+hHjwwoU7Mh82Bwc5zc4ySd7xsABL+
         k7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dg0exrkEoHo78ZPEniVivraP1002Vfe0bXH02uY3wQ0=;
        b=g4Lgqdvu2YUilYvkty9ubg4R9YOxyjgPyPMqA/bAmjp5IS1hNQ1gwFGh2Hg+Zmkjms
         yWeb5ifuAamo9oYOyb3i30+yIKThG9nZ03090pDhvZLKyXTjCaBcTiy8jsCi6+77qBk4
         xvt18ttysYD+4FTbDGePlJr/sMX31nLjjTzPbrj5RTvKAPuQisUYinTu06mX4Lrzxpl1
         38X+WpgOwn2SeaQwv7ts/B8YddoBk77SieyZ9T+WJOdG+hrFGhr3x9OP61M7AH9UJp6p
         q4glxNEYhuZdR/Ih6lGZbTxEENoScbn4a9ZFxclGZaWwEimK+WbmS0TnEaTZYpi4FxHF
         QfhQ==
X-Gm-Message-State: ANhLgQ2rEEhUjDDB7GLV9GihHLRgDOjvscaUTickiSbd79hk0zFIn7Tn
        P2CWvJErQc4MPp1vBzhVcrc=
X-Google-Smtp-Source: ADFU+vvbBMNbfCzNUGthBrNjznLtE7ty86z3O8KehDnDe7gozEG14WICAU3zqtzcu+Fxww0Vkh1jFQ==
X-Received: by 2002:a17:90a:3a8f:: with SMTP id b15mr24631399pjc.178.1584968981754;
        Mon, 23 Mar 2020 06:09:41 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id u14sm12262034pgg.67.2020.03.23.06.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:09:41 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 4/6] x86/Hyper-V: Report crash register data or ksmg before running crash kernel
Date:   Mon, 23 Mar 2020 06:09:22 -0700
Message-Id: <20200323130924.2968-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When a guest VM panics, Hyper-V should be notified only once via the
crash synthetic MSRs.  Current Linux code might write these crash MSRs
twice during a system panic:
1) hyperv_panic/die_event() calling hyperv_report_panic()
2) hv_kmsg_dump() calling hyperv_report_panic_msg()

Fix this by not calling hyperv_report_panic() if a kmsg dump has been
successfully registered.  The notification will happen later via
hyperv_report_panic_msg().

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Update commit log
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index caa032ce3fe3..5e296a7e6036 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -263,6 +263,16 @@ static void __init ms_hyperv_init_platform(void)
 			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
 	}
 
+	/*
+	 * Hyper-V expects to get crash register data or kmsg when
+	 * crash enlightment is available and system crashes. Set
+	 * crash_kexec_post_notifiers to be true to make sure that
+	 * calling crash enlightment interface before running kdump
+	 * kernel.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		crash_kexec_post_notifiers = true;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-- 
2.14.5

