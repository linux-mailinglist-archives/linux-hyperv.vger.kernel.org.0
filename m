Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169ED7A531
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jul 2019 11:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfG3JuH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 05:50:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39485 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfG3JuG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 05:50:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id w190so46086697qkc.6;
        Tue, 30 Jul 2019 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wh9GNZHIrnhtg59P3tkMjaDgU4oFVpFt+1AhQYmKxJY=;
        b=S0LyAi4bvR+Ah/ZuP0WNt+qmK13B7S/0LDux7Y9b6NYcQT3N/T6y98rRm6z44Pn56u
         5x/9/0hjXbtYEbAfQu4Tj+CVz6/frS5mBKMKCk1G0VOn8SUNO8UW6jtxzgAYX0OziImD
         xitMhTzEwH8eJJs056g0MHW9Zw571845WVKTyFYrdTCwDU19E/6dRDrS1K1qHFdvkYJ1
         c2e8HzHrLi/lbHiGyRcDugETo5XtUDPk6mAhZ1y6q1ASeC2zmM1KcEuDVOSGbZtq8LKS
         XeatS3B6XSQnpip1VqRTn7EDfRkETEYTi1UbHVyZTmSLmhMgb09Dao+A64+Jc9QzwhXT
         UYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wh9GNZHIrnhtg59P3tkMjaDgU4oFVpFt+1AhQYmKxJY=;
        b=Q9ptxri3VU/U3RfWP90z4UeNffuHA9H0DWvBTinvfIhQLi1AKrVnxNqUH7ntOS/2rC
         u5a+cqskpplH0wRzT+d5GsiU0BxH1huGKptGULSR/+UcLfpj3X9JPx0kDC7+vCECuMcz
         hglB/Ua7JeY4NDbJedjuLI2nf9MY+ELxdiaY9sY9sPPht1TgvgYSQnU7RqfVqyX5z8SO
         MJJHAHawjQqSQ6xC5P4oXzhs3CEx5l39O8nViPQzDnxU1Wo+5orohnZ2uO0NqkY5JuxC
         0680VwO5swapD+joJxF4vdGd/bLjWfT2bNUcZ0TJfD4J+/UCu0qDrvGlzPXuHmMk1ipZ
         EwoQ==
X-Gm-Message-State: APjAAAUcADZnv4g7spr2yxXV2Y7lhmlKqrXew4yyra4Z/2duv4EvK/f0
        603luB157KqwYWULctCpy/c=
X-Google-Smtp-Source: APXvYqy3btStKIOM4W5XLPSWRxkXeZEVtQwFTAdkep0oSzZm81lp6S9vf0bgrX4NUhc2w1F2L/E3bg==
X-Received: by 2002:a37:6858:: with SMTP id d85mr24831807qkc.126.1564480205254;
        Tue, 30 Jul 2019 02:50:05 -0700 (PDT)
Received: from AzureHyper-V.3xjlci4r0w3u5g13o212qxlisd.bx.internal.cloudapp.net ([13.68.195.119])
        by smtp.gmail.com with ESMTPSA id d9sm28198078qke.136.2019.07.30.02.50.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:50:04 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
X-Google-Original-From: Himadri Pandya <himadri18.07@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH 2/2] Drivers: hv: vmbus: Remove dependencies on guest page size
Date:   Tue, 30 Jul 2019 09:49:44 +0000
Message-Id: <20190730094944.96007-3-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730094944.96007-1-himadri18.07@gmail.com>
References: <20190730094944.96007-1-himadri18.07@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V assumes page size to be 4K. This might not be the case for ARM64
architecture. Hence use hyper-v page size and page allocation function
to avoid conflicts between different host and guest page size on ARM64.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 drivers/hv/connection.c | 14 +++++++-------
 drivers/hv/vmbus_drv.c  |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 09829e15d4a0..dcb8f6a8c08c 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -202,7 +202,7 @@ int vmbus_connect(void)
 	 * abstraction stuff
 	 */
 	vmbus_connection.int_page =
-	(void *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, 0);
+	(void *)hv_alloc_hyperv_zeroed_page();
 	if (vmbus_connection.int_page == NULL) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -211,14 +211,14 @@ int vmbus_connect(void)
 	vmbus_connection.recv_int_page = vmbus_connection.int_page;
 	vmbus_connection.send_int_page =
 		(void *)((unsigned long)vmbus_connection.int_page +
-			(PAGE_SIZE >> 1));
+			(HV_HYP_PAGE_SIZE >> 1));
 
 	/*
 	 * Setup the monitor notification facility. The 1st page for
 	 * parent->child and the 2nd page for child->parent
 	 */
-	vmbus_connection.monitor_pages[0] = (void *)__get_free_pages((GFP_KERNEL|__GFP_ZERO), 0);
-	vmbus_connection.monitor_pages[1] = (void *)__get_free_pages((GFP_KERNEL|__GFP_ZERO), 0);
+	vmbus_connection.monitor_pages[0] = (void *)hv_alloc_hyperv_zeroed_page();
+	vmbus_connection.monitor_pages[1] = (void *)hv_alloc_hyperv_zeroed_page();
 	if ((vmbus_connection.monitor_pages[0] == NULL) ||
 	    (vmbus_connection.monitor_pages[1] == NULL)) {
 		ret = -ENOMEM;
@@ -291,12 +291,12 @@ void vmbus_disconnect(void)
 		destroy_workqueue(vmbus_connection.work_queue);
 
 	if (vmbus_connection.int_page) {
-		free_pages((unsigned long)vmbus_connection.int_page, 0);
+		hv_free_hyperv_page((unsigned long)vmbus_connection.int_page);
 		vmbus_connection.int_page = NULL;
 	}
 
-	free_pages((unsigned long)vmbus_connection.monitor_pages[0], 0);
-	free_pages((unsigned long)vmbus_connection.monitor_pages[1], 0);
+	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
+	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
 	vmbus_connection.monitor_pages[0] = NULL;
 	vmbus_connection.monitor_pages[1] = NULL;
 }
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ebd35fc35290..2ee388a23c8f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1186,7 +1186,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * Write dump contents to the page. No need to synchronize; panic should
 	 * be single-threaded.
 	 */
-	kmsg_dump_get_buffer(dumper, true, hv_panic_page, PAGE_SIZE,
+	kmsg_dump_get_buffer(dumper, true, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
 	if (bytes_written)
 		hyperv_report_panic_msg(panic_pa, bytes_written);
@@ -1290,7 +1290,7 @@ static int vmbus_bus_init(void)
 		 */
 		hv_get_crash_ctl(hyperv_crash_ctl);
 		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
-			hv_panic_page = (void *)get_zeroed_page(GFP_KERNEL);
+			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
 			if (hv_panic_page) {
 				ret = kmsg_dump_register(&hv_kmsg_dumper);
 				if (ret)
@@ -1319,7 +1319,7 @@ static int vmbus_bus_init(void)
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
-	free_page((unsigned long)hv_panic_page);
+	hv_free_hyperv_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
 	return ret;
-- 
2.17.1

