Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5607198ADA
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 07:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfHVFjJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 01:39:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41103 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbfHVFjJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 01:39:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so2738956pls.8;
        Wed, 21 Aug 2019 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PffswB8wLkH//GMkNj72Aq/AWOuk9sDOFYYFBy0MDFk=;
        b=jaQEeHApin3cj7B+uK4JdOwGroXhaL20ll4T5FzzWnPrhWr9ap3oxn9ZXwRRjofJJL
         zcwBG4fv/8tlD+a+04rVYv/sX5SXxlEKseqZE10Q2qw0c6QHqr6SoR0jM3CIUwNNPEs6
         ugqBjzu262o6pU/VNIhPsrgA/ngys/Ff/Qb+EUVAEBVx25rMZaxMH5YRC3LfCVg/aIuW
         Wrd38PgD74RU++fSkjcWNLXmPt/+FEir9WdY9ao29f2CpJUr/yTm6mHCgjJX3H3J1o8p
         bVg2MIGgNl/TvElW48g/KLxI9cdK3SROLU/xXEztylH8TEOQXAqkgAEKCTlRKoBmDYxI
         edAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PffswB8wLkH//GMkNj72Aq/AWOuk9sDOFYYFBy0MDFk=;
        b=gnV+qrzjBS7ME5Bc4rrCr7jKRMPsuylLfJQY8829eW7vzqk2s3kGmJz/B1J98McGqx
         jhiC/qNACWbQlpRNO2ohChqe0/TlLeCSSx6jlvUtqWSSiYcUm0HyiyfASNNH3UQaFCPv
         cYPQ2ah/v1bHRvJd8LQqo3BDnq/WkLZsR+n//m01qr0JQkefVfWiYK0+K8ZOTIq2h8s3
         Tc3WzROmo0o/QxeEHsyHSSPQK/GDeYTDqO/r6DvQsbSgAkSG45Tab1Mmsq7UG2b0eDKP
         ym/RZJYPuUch33+3EP/GyPo7CbqR0DXsJ8/4yQwfKYQNrLDlqnNErNo2NbtwDaw40sE2
         jgiw==
X-Gm-Message-State: APjAAAVgywK654x5cv+TwO+si2VfagU8/Ny/J2hb/io4lZNy+NyR3WEj
        mE2ypXZSbNNECHZvoPg9O/k=
X-Google-Smtp-Source: APXvYqyL2YhXLlLPd0qIqo0j/qX6iW4qA1lcbcnK2ZDWX10ozTy48wMLHIN1QMqWwbv4Ejh/Hjg43Q==
X-Received: by 2002:a17:902:1126:: with SMTP id d35mr6142256pla.330.1566452348778;
        Wed, 21 Aug 2019 22:39:08 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.52])
        by smtp.googlemail.com with ESMTPSA id q8sm6762482pje.2.2019.08.21.22.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 22:39:08 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
Date:   Thu, 22 Aug 2019 13:38:52 +0800
Message-Id: <20190822053852.239309-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
hv_sched_clock_offset for their sched clock callback and so
define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
This patch is based on the top of "git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
timers/core".

 drivers/clocksource/hyperv_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index dad8af198e20..c322ab4d3689 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -22,6 +22,7 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
+static u64 hv_sched_clock_offset __ro_after_init;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -215,7 +216,6 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
 #ifdef CONFIG_HYPERV_TSCPAGE
 
 static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
-static u64 hv_sched_clock_offset __ro_after_init;
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-- 
2.14.5

