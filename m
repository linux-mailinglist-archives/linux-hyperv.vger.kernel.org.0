Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA521906E1
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCXH5d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:57:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44650 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXH5c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so7076770plr.11;
        Tue, 24 Mar 2020 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AplELZQC2NMqasFkQFHx1BNMe2/X5HEKlb8YA1EtTZ8=;
        b=dwNP5UXJYG+TpyAxMJtG4neigvYScl2bkpF4pOAoJrSh6l4rvrdj8d3P3uk95ZxhIU
         Njgq9vKxqhgPy+jpDWrTSMsJErWPpCd9uWPh0dadd1hsdVqYVjO7fyWY9sAu5SaACOwC
         n2c1d6xlPnyCbHdcNuL7HgAzMIy8NgTKO2nMnU6xLUXi2/tMJAtmyhiO0PweBuzQ2YhW
         L4DCN0h3CfukpZ6MOJvTTCU2G9chFCgvaO/qRM6KOtxAN7t2xIlnPbPXHEaW42GcVlMb
         upue+QGcnDHiymMC2TH4eQE76a7FA5BFduB5sM22TjkqoO0s1UEJLcpXqXI7klZZo7mm
         c90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AplELZQC2NMqasFkQFHx1BNMe2/X5HEKlb8YA1EtTZ8=;
        b=gFiWuIVbBBieUwwWQrzDbLegQLyqSZJieebVb0YfqZ4oDLkPrq1QYFyAe+Gzr6+cSL
         cp7cLQ5IUDA5VyEd7acz2GjoG4vo/xIRQOQgScPcBnPB/2PUdmiSJ+gx20es7ZGWEihO
         pTHMFXx2u+SfNyw+vb+HNja4XP6r0cCBRxvxTHsLHRByPwhgLMiRsD9eoPSvoqU6yKZK
         GPO9aWS9fiQMV5CryOkr69XCDVLR4N0sfu9+V/HUpdCkcyf1wxuiYIuPieOgTwJ9M7Zb
         ICude8P+Jm7DZWubIHZOLMjeLVXpUKA9+uqMNzwK37meHpCyPszyYpbFNt5br2i2wWUx
         knLQ==
X-Gm-Message-State: ANhLgQ1u8eyPVWoTuhnZN/EbwSpuioHs6e+e/YKFxDYX7/sybt6OlNZN
        tiAzGErNuqsqCms+u4QqoeQ=
X-Google-Smtp-Source: ADFU+vuI9xhDsW1rqAOLFqf4vitf9cWQFjiky+kYMurAeHfKW+f/J7AMWAKxaHj/JK7J6fOBlaXxPQ==
X-Received: by 2002:a17:90a:35ce:: with SMTP id r72mr3903598pjb.126.1585036650443;
        Tue, 24 Mar 2020 00:57:30 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id x71sm15452076pfd.129.2020.03.24.00.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 00:57:30 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 4/6] x86/Hyper-V: Report crash register data or ksmg before running crash kernel
Date:   Tue, 24 Mar 2020 00:57:18 -0700
Message-Id: <20200324075720.9462-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

We want to notify Hyper-V when a Linux guest VM crash occurs, so
there is a record of the crash even when kdump is enabled.   But
crash_kexec_post_notifiers defaults to "false", so the kdump kernel
runs before the notifiers and Hyper-V never gets notified.  Fix this by
always setting crash_kexec_post_notifiers to be true for Hyper-V VMs.

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

