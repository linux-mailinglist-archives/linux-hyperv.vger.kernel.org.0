Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882F418F556
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 14:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgCWNJz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 09:09:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37452 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgCWNJn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so1874982plm.4;
        Mon, 23 Mar 2020 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Jwo7X7M++QxJBzB5uNWltOkX4iegV1KZt5UpPXiKAU=;
        b=b2bZT5q3juuskK3ifBwkEK7uWO9huDxCf9KvfxZkZbU5rVjHpOhVkZhvLhJdILVHNx
         SUD4MV4hKnQUEcPajPievVU7/215AztcF+TMYIwfAwdJ3bBCLJSHKF04CT00N4C3Kgqy
         0vG3NYPBIzRGIxARMwDfyUldCO73gYsj6p6XuWe1+TZh/nX/6X6pfW1XsZGkRUfRGKGu
         tKUT0Dp4npP1c7OmONQyde5Yy20iDHJZyJZZrDhprsD4OzeEWBFW0dt00ig4RSrrybnu
         i6H/ZR1NGL/489lyDl5Nh6K6EEjBlu9/mGrh+UrifIHAKOdqSQNfqLl9zgzJgJUlvNVo
         oJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Jwo7X7M++QxJBzB5uNWltOkX4iegV1KZt5UpPXiKAU=;
        b=tf7X5iznxRZtVEK1fa3vCuum2adNL0dSejw9m/qlyPmJxGqTlDWAAJFUTVCRzX5B0A
         9D1gqxVOIY/xdS6wMdHls/UpqFyrGB9N+MvCkZ4pZC8/MvP9sv9yBo90jxQHyeDm8ZQy
         BZrtKc1DgZ3qQ9j5GkvmDWD+SH1tbOwLx+bZwPcXMXDB20QMMRUbbyw5H97No0ptG6pD
         nDJVxs9Xhafas9mhTPIFtCrTl+NRK02fLrlwu4GdC719lyaHy+7T/9HyFuZh8nYr/fyI
         zKdVS1Tuf4d7puWPH2YWQqcW5f9IkWyD4en72vSsmHebmFJGwQFsiff4d4yZEu8/emWL
         Od4g==
X-Gm-Message-State: ANhLgQ3KPDV/qcdlBkWyUfgDy4j/wuXtpkyNnebscoplXJJlWpG7Mlf8
        9BVtew9AylwL1UCn1NoR7zw201N2pkY=
X-Google-Smtp-Source: ADFU+vttpK4ks7E8c8nS5mY25N4ud2zZ+9VMyZM7FF3pDv4v2pYD3bX/VMlxAjFYnmGUwWpHqZACsg==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr21830283ple.102.1584968982430;
        Mon, 23 Mar 2020 06:09:42 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id u14sm12262034pgg.67.2020.03.23.06.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:09:42 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 5/6] x86/Hyper-V: Report crash register data when sysctl_record_panic_msg is not set
Date:   Mon, 23 Mar 2020 06:09:23 -0700
Message-Id: <20200323130924.2968-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When sysctl_record_panic_msg is not set, kmsg will
not be reported to Hyper-V. Crash register data should
be reported via hyperv_report_panic() in such case.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d73fa8aa00a3..00447175c040 100644
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
@@ -60,7 +72,7 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 	 * message is available, just report kmsg to crash buffer.
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
-	    && !hv_panic_page) {
+	    && hyperv_report_reg()) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -77,7 +89,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * Crash notify only can be triggered once. If crash notify
 	 * message is available, just report kmsg to crash buffer.
 	 */
-	if (!hv_panic_page)
+	if (hyperv_report_reg())
 		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
@@ -1265,13 +1277,6 @@ static void vmbus_isr(void)
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

