Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DADE6188570
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCQNZp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 09:25:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38230 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgCQNZd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 09:25:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so9630367plz.5;
        Tue, 17 Mar 2020 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kvShCFneTqNWCShSIFRg6DQFBqujhrj5sjdHfCk9weg=;
        b=r6lEtRqdkojIaCRzqksEKRqICnthfZXUavxesNwoNyv3H6rjq75b5EUE9AKoh0MhBS
         6vIFmOM73ladz7zHK1QecXEe4WqzlgEk40azox9L5gP10rqNuIQPqrQR7JQfSVl4NB4p
         j/KgRlWtwsbS8pae84BnC2RHoDTF0+7QNIu6L2qn01qtRtqP7WY+HzLP0QsMPiR4sDAk
         Lfa10fcI9uYuOgLrDvAuLyrZI6/jXq5rh6W1VMMhLFb0LKNtL1vUrTLHbCCePukZchkk
         PjNV5aD1iapF/p+z3AIbH5MR7VTaoKRY+06rIq/mjFLz58CQIBjN5bUuUTP9Mj56fSZD
         n1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kvShCFneTqNWCShSIFRg6DQFBqujhrj5sjdHfCk9weg=;
        b=kJ54M8ichXkjeP5TnBVI4NbdQxA+hXRG8M3Bv7xm53E8V3sYGQfU/VPXzn9lkqMWVY
         Bj16afPnq3KLsJ6kmzUikkGxt76u36NpA44HcB6aFz6MJhFb0rKPOqywgjyXqO35+Hu3
         wWcES+0OEkjB1U+fTjxk+hq3vmNGMzeLol81Eezt9LxSn0PqZ3UCUUP7Uuj9zZVU46ui
         kzN4a+wvVyXJ/f1I6kFNy831CEQkFXY4FhRpXdC6Hl9/kViqGmfEQnn3MGu6/z+LVWjK
         BEB3B1xxy/zUxwVvqQ1zmwubO/jxAfeyVEYgsp/2LUeb+yX8UNj+nI2Ho9Ph5XJKYJHK
         qvWw==
X-Gm-Message-State: ANhLgQ34lsbAhL3wqKtyrAw8EIViPCnc/6Oe2+bLu6l0daTKlbLoA/ko
        2dAlbuNS/serRXu5oKltHl8=
X-Google-Smtp-Source: ADFU+vteWXHd6n9nuJOFGQMBnhZ/il1kMyVw9aW2v4v52kZvfrF89ZHOa/PNnFOHez1jtvt8yhSkHQ==
X-Received: by 2002:a17:902:b208:: with SMTP id t8mr4228476plr.94.1584451532323;
        Tue, 17 Mar 2020 06:25:32 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id e30sm2910902pga.6.2020.03.17.06.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:25:31 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 3/4] x86/Hyper-V: Trigger crash enlightenment only once during system crash.
Date:   Tue, 17 Mar 2020 06:25:22 -0700
Message-Id: <20200317132523.1508-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V expects guest only triggers crash enlightenment.
The second crash notify will be ignored by Hyper-V.

Current code may trigger crash enlightenment during system
panic twice.
1) The enlightenment is triggered in hyperv_panic/die_event()
via hyperv_report_panic().
2) hv_kmsg_dump() reports kmsg to host via hyperv_report_panic_msg().

Fix it. If kmsg dump is registered successfully, just report
kmsg via hyperv_report_panic_msg() and not report register values
via hyperv_report_panic().

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b043efea092a..1787d6246251 100644
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

