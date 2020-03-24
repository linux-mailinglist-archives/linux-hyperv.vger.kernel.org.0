Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30981906E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCXH5c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:57:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37901 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgCXH5c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so7089947plz.5;
        Tue, 24 Mar 2020 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3NREOU6FK3nr+j2R5crx0apdf66/jFQFjfcexYbogM=;
        b=PQ3h39DfnX6jjzOUNlM38M0hq++p0X6WL+L0zGuhvfWdFcxwpdjexfYhC11oVAawOJ
         CbwyGAlT34Qh0mTSfjK4uwpDWVl91wJ0i7qE2c7JBfldfmlMAZsfjGWg5louZtmoW3YC
         jwqsMDsVzjxtQmgPy9EAfwxUykMTHG8nU7BuTQcM8bWZAZeFlk3cByRmalRcbOwSK+IU
         q4VkILK3dcfiJKWg0gbBzuEDNzSNqRnbNm1ROqyqU6ha8VYvtPe3cYAyQcnzfK8HC9VW
         q270/74fcYsXAvNyBcagQDVf/RfD1GY4b/Z9RtnRSuB4GDGcg5cObrBwPPBg0VTJnJnG
         He4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3NREOU6FK3nr+j2R5crx0apdf66/jFQFjfcexYbogM=;
        b=gR9AVjkpp302dol6tZmtqxWMKck3QBmwwemvCw0O8gnO5GIYp13RwW0b+Wup+G1L1E
         oQB9INxL0IB886oiSNZsFcROZo4kHK7TiLK2JSzBCXplJYLkfWtywsg7cix39P6/bGNL
         h2Kh9MhFYB0SREy+piQM7ROLbDeyOYvXGWiyUbYlwVZLULeSeZrQ2i5nSzPxR+V6CxWY
         /fIAYvokeYUHJN3ulRXTD2M+g3Kh4JBkHkL7MPd1TJiSJbB7sR96v8tR0qmdQKDtWL3i
         qN4HK3MO+r+6M6mrC8cvmpsbMZG4bLCNzz8l4D5Y1ccqdpVJ2Njed8kOUP4rBV2PNMhs
         ACBA==
X-Gm-Message-State: ANhLgQ03BWsXGJgsnfAop/qm8ExtcmXaFpAVjqv3l5ITqMyQBJdOh55R
        G4OOKDPal3MxxpjWQjimuu0=
X-Google-Smtp-Source: ADFU+vsZaTBTf2YcxS56FAlB9q5pxPCsBnHGsiNPhOAg2axLvhCMVCeluxUp45eL2LNjIzjsZgc7oQ==
X-Received: by 2002:a17:90a:ab0a:: with SMTP id m10mr3697941pjq.173.1585036651116;
        Tue, 24 Mar 2020 00:57:31 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id x71sm15452076pfd.129.2020.03.24.00.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 00:57:30 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 5/6] x86/Hyper-V: Report crash register data when sysctl_record_panic_msg is not set
Date:   Tue, 24 Mar 2020 00:57:19 -0700
Message-Id: <20200324075720.9462-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When sysctl_record_panic_msg is not set, the panic will
not be reported to Hyper-V via hyperv_report_panic_msg().
So the crash should be reported via hyperv_report_panic().

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 333dad39b1c1..172ceae69abb 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -48,6 +48,18 @@ static int hyperv_cpuhp_online;
 
 static void *hv_panic_page;
 
+/*
+ * Boolean to control whether to report panic messages over Hyper-V.
+ *
+ * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
+ */
+static int sysctl_record_panic_msg = 1;
+
+static int hyperv_report_reg(void)
+{
+	return !sysctl_record_panic_msg || !hv_panic_page;
+}
+
 static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 			      void *args)
 {
@@ -61,7 +73,7 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 	 * the notification here.
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
-	    && !hv_panic_page) {
+	    && hyperv_report_reg()) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -79,7 +91,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
 	 * the notification here.
 	 */
-	if (!hv_panic_page)
+	if (hyperv_report_reg())
 		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
@@ -1267,13 +1279,6 @@ static void vmbus_isr(void)
 	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
 }
 
-/*
- * Boolean to control whether to report panic messages over Hyper-V.
- *
- * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
- */
-static int sysctl_record_panic_msg = 1;
-
 /*
  * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
  * buffer and call into Hyper-V to transfer the data.
-- 
2.14.5

