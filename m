Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C371906EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCXH5p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:57:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37550 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXH5a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id a32so8630504pga.4;
        Tue, 24 Mar 2020 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qB8cosFg/V+ZgSCX/jWtnk8u0ihozSaIQH9qUkXCmZ8=;
        b=LeY4fFDfriqkt5sxx21MYnnA1fiVuyC3kY+OloApYOI0aWIUd41pFoGXIZLKPqM5Ad
         9ykv2fpTvtKKa5jK+qwkr+FINX5NK80V1ll6y8M7lf+5PYIqVla9voQWwaId4nBrbR6x
         NFvVE71MLNb3pLNSELT0pmyeWJLBtY9svEHH5rGuB8ntn9mGz6uJx+/QIgbQM5ZInmYz
         dmqKxnUpFV6s4Y4RBWhQXTdxco2DxVMP+JgHH7bFbD9aVwT1HObOKR2v4CnbA6GSCBAl
         T+0qQRldKSCgluAlCzrMtMQZg6smZiWPTglz10EmNgbPhrf9IdCpU046cPTT+3Wq7OVx
         +2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qB8cosFg/V+ZgSCX/jWtnk8u0ihozSaIQH9qUkXCmZ8=;
        b=BPzs48lcIah6HAPU4Xc+v8b5NBbcuHo9rL0NOvjPjn1orhGfwwntAvA1V9nFD2sMi2
         tYwjjYZ/a+ZNBEhWgk7EcjZ38S7otrvTOVvKJ/AN5m+c2xpbEGP5OLHsBv3MfVSg3YOe
         0w+UBkVg/uxxS52f2zIrntiHyHDc8yfcxNr8DDf5DKLgaWkoTM2AsncF+4hsNAjaGjAl
         X7rtKOlYJtFb8FMZrV8dEIKiacZGs0CSdFRJU8c20v3pszlQxi/VJw5Fl3+L27qiLpT1
         XycofSxg3KnikGf+AmPZqjRyFOZfopmnmy7fo5VGm+phT8YMUbaetDNq7c2TBCNsMJ/s
         Aswg==
X-Gm-Message-State: ANhLgQ3wkV6fimKDwntmdd9PlG7W6ZE/USGU06HIMHS2iDUcPoQozvjF
        X9wI2YtKFeukzNtiIMw+88M=
X-Google-Smtp-Source: ADFU+vsRwR770XERm2dqpUS53+O2WhjY/szqYi+ItkIxiN7V57yGQAoGr0ENzncjT5r2cA1niJ/j8A==
X-Received: by 2002:a63:d143:: with SMTP id c3mr25424121pgj.171.1585036649668;
        Tue, 24 Mar 2020 00:57:29 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id x71sm15452076pfd.129.2020.03.24.00.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 00:57:29 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 3/6] x86/Hyper-V: Trigger crash enlightenment only once during  system crash.
Date:   Tue, 24 Mar 2020 00:57:17 -0700
Message-Id: <20200324075720.9462-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
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

Change since v2:
        - Update comment
---
 drivers/hv/vmbus_drv.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 00a511f15926..333dad39b1c1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -55,7 +55,13 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 
 	vmbus_initiate_unload(true);
 
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+	/*
+	 * Hyper-V should be notified only once about a panic.  If we will be
+	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
+	 * the notification here.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
+	    && !hv_panic_page) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -68,7 +74,13 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	struct die_args *die = (struct die_args *)args;
 	struct pt_regs *regs = die->regs;
 
-	hyperv_report_panic(regs, val);
+	/*
+	 * Hyper-V should be notified only once about a panic.  If we will be
+	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
+	 * the notification here.
+	 */
+	if (!hv_panic_page)
+		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
 
-- 
2.14.5

