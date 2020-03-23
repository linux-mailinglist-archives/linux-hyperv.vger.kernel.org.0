Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99118F54D
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgCWNJn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 09:09:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35713 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgCWNJm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id g6so5905834plt.2;
        Mon, 23 Mar 2020 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izVkhfSJVvX4iA5swA8dGgujHIuHYwU5C2aqb2eYYrk=;
        b=irb5TVIoPbz6Yed8udTigBEPXhzjFOGpitYwIEPV1hbsNP5YaRO8r8Kf3/JCerbfEQ
         /ApN5AoXZESSrRO/utFd686k8rxTBNQmhFbWEYEF7VIHJhHhfaJBnUTLMLHXNTlXQQ/I
         jNUQavLbOCe4mrgFTBFh4WELLT4QkaUROCkTGHVMZxwhMgsvCDi9/eng4sZM/DEJo24j
         JhpSfZsfoC4zw0WLRXvRfur4IqwC9ji5acV/N2Y3p5JqJj9XmHWBi7IfOMJ1rV2nbAJ+
         LU2DbA65heYX7ZZt1UGjVvsyxe/GZYVEDpNVdXwcctVk0qOvkuq8yGteiMYTeH4jWIwB
         XaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izVkhfSJVvX4iA5swA8dGgujHIuHYwU5C2aqb2eYYrk=;
        b=UPauy1GZEviu7vLbXV8TyfXMpUSVbo0XbncxdOiahwtQTyxEYwxeve+ohbyG+csdh1
         RtsWHA+uVik6EG4PNlG4532TnAaGpxtaXIjYT+pupGhR1ws1h80/OWsS/Jj4gwBs6l3Q
         jIlIEFVW4yyJK+7IltNAb+lTytznoOPYX4Hwewq5HIHsMbcocr7HzRftmWmpHa5Zki0p
         EM2yWfjnDCz9wNSZc0jDWdpDmZz8WygngdTp1TyZ4fQSBbKcpUIawJu1bc1HiRNKstp7
         TRJ758p8nXZOLDKsfdO4xsoonW3iM1/TdZBHsgdiPBSRgU01HuOtayiSsIeRRa8Pxe8/
         YhPw==
X-Gm-Message-State: ANhLgQ0dAMWrrtRENBgqh0xCN7bRnDNMNRQ+6sWHsBpoo7QPXbp/QlIZ
        xaNP4TO1mtqoGUjqGJF3oHh/UNidrI4=
X-Google-Smtp-Source: ADFU+vs6gpWtDOUag62aIa46URGumGNJDOjLz1Cj10Jh1C6aWIbTITvju+Snb3dQzEQVGGlvj9FGnA==
X-Received: by 2002:a17:90a:e50e:: with SMTP id t14mr6410378pjy.98.1584968980845;
        Mon, 23 Mar 2020 06:09:40 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id u14sm12262034pgg.67.2020.03.23.06.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:09:40 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 3/6] x86/Hyper-V: Trigger crash enlightenment only once during  system crash.
Date:   Mon, 23 Mar 2020 06:09:21 -0700
Message-Id: <20200323130924.2968-4-Tianyu.Lan@microsoft.com>
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
	- Update commit log
---
 drivers/hv/vmbus_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3a0472c8b7ae..d73fa8aa00a3 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -55,7 +55,12 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 
 	vmbus_initiate_unload(true);
 
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+	/*
+	 * Crash notify only can be triggered once. If crash notify
+	 * message is available, just report kmsg to crash buffer.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
+	    && !hv_panic_page) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -68,7 +73,12 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	struct die_args *die = (struct die_args *)args;
 	struct pt_regs *regs = die->regs;
 
-	hyperv_report_panic(regs, val);
+	/*
+	 * Crash notify only can be triggered once. If crash notify
+	 * message is available, just report kmsg to crash buffer.
+	 */
+	if (!hv_panic_page)
+		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
 
-- 
2.14.5

