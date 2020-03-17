Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2518856A
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCQNZh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 09:25:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40803 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCQNZg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 09:25:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so9623257plk.7;
        Tue, 17 Mar 2020 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3AG21iLGGAii1MHxBcHGGH0QVkwsyKzAiPYkrML9p7g=;
        b=Lbq7Fwt+tOGrVSfiXErQDRtZ4H3+lEhCS2Wgb1xuCVEJKsMKVskojybUATXrwdtHDQ
         CNsoECvA9rr53BF6kkA7aQURIV8VZsLdavBpy+pNCiSP8cYpEpRxqC59PnOSvnJHks07
         Mcim8x8TwXsZYj2PpBXO5/2Y3LefQ8yFnAdcoEbGOQQPhxdaty29tDjRCHhTS5LWSCqa
         aOmo3P7daS9amDS62Qr817UsSw1P9wj4aADvKIwiiwPAo+5xYVNn36zv6mh83Us4UKjm
         mQTvSGURlmSK+TCflKoj7mE9Qpf3g7zUxBhnhiiMXNLtC4/HiEbZNsn6uycQccajkmm+
         RvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3AG21iLGGAii1MHxBcHGGH0QVkwsyKzAiPYkrML9p7g=;
        b=Ia4YE6x42dCQ5JEe/3uPykJQmSKY6p5bG7DG7m2IR6+M9Bk+MLVK5wjjIRMAm+SP1b
         9WXc6PXKqFswxXEUk/2XihD/Jb47xRTiqU9KH8fN0qoc3p3SGnl65/mlP66ynzfuZXe+
         9RwPQGhyl1fNQ64e5Eesxi4BGEogAJvLzzr5RpST2ht+NWgQkRheJtK7R5NmdWfUqifR
         cHD/8RN9kdZKj6HVzSaafxX0hp3shh6NjLgyYI3kIRjqQJJGgvkDsxkT2d/0Mk9evs+1
         LbCD6Y1+8FUQz/IoMcj5NHJ7Vlr43ZRPZbSqWfLtAg+ZaH2+qw0O+1OFt9c+LXm3XOoq
         3hmg==
X-Gm-Message-State: ANhLgQ00pTreO+xX613Ezgmd+ZDTV0RJGmslR6dmZc4iMaaa8Bu4UF73
        VthpQIWzvuh341yQLG7sM0wsqXbhJzA=
X-Google-Smtp-Source: ADFU+vt0MPZSFVVsUS6VSUAhIpZpRDceY8i1fHN2ntd7+ZVMvXLPFJEh7gH/DuafpHJfdMGxE/lXFQ==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr4393525plr.87.1584451533250;
        Tue, 17 Mar 2020 06:25:33 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id e30sm2910902pga.6.2020.03.17.06.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:25:32 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 4/4] x86/Hyper-V: Report crash register data or ksmg before  running crash kernel
Date:   Tue, 17 Mar 2020 06:25:23 -0700
Message-Id: <20200317132523.1508-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V expects to get crash register data or kmsg via crash
enlightenment when guest crash happens. crash_kexec_post_notifiers
is default to be false and crash kernel runs before calling hv
panic callback and dumping kmsg. In this case, Hyper-V doesn't
get crash register data or kmsg from guest. Set crash_kexec_post
_notifiers to be true for Hyper-V VM and fix it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
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

