Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5018F558
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 14:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgCWNKC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 09:10:02 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54639 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgCWNJl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:41 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so6153819pjb.4;
        Mon, 23 Mar 2020 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vVUzNb5v+z/pbpf2JJFvx1W0kPGFINM64y0EKnoFjUE=;
        b=F6ZTXoVSQU1OZ0NCDMwr8UhfpBfKbgm5c7Wz3ZKPqZzQ+0cNQfTULmlouHB8CZxKgo
         ec/hUDlSOhr4cQOUqd4BMa3uf/sLrCHrfRTPdD057Ybk9tR01bbzNa+pJB0PusxDfGu+
         84MftLwMwBzPtOgS8qRVyEbjj3rVjLX/ZA25OE3nBhFjnWZlm9DqwFxTLgPl4sezwySP
         DaldGi2xVb7ZosMUptvfuEIdJDWSv0iDWb+r4lOhSl44o9dfveDl23xMfwFOspqbuX+N
         WkoyruZ1abyhC+Sy5Me/Vv5NbnlC3rmxP9OtIaXSh54dX/JJ+cyf3B2ShuTeNgSLBi7y
         dnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vVUzNb5v+z/pbpf2JJFvx1W0kPGFINM64y0EKnoFjUE=;
        b=W3I3Z8cQ+ZnBryr64Z8iEgrDlGioZuU4Wjma+tkEd2cyvwxPPAgGPCkixUMsjPJDwJ
         t44ms+YX7+h+HJUFZ8VU5vwrt6s4STtO9eDaAk0UKxygFcwD/97hNxUCyWBStXiU5iSm
         KWP5GR49bjgcUk1pcSysX+/JpOM3cI4grG94zv7bSC0Gx2CQqaQDixMODcxQ/f58PtCA
         tS0ebIA3f/P0Sfb9pr4e0wfZaUHQfBrImIMpFlNS1s4ly6puHmM+gAoSHfGyfBEpifFr
         mIWSnAuDn+VL0ClFFLS2whWAVcmnoHqy/CojC161wLLGKv0i2H290Afws2Tzc5FEnuoX
         yF7g==
X-Gm-Message-State: ANhLgQ1ZZn108fxaY4Ktsf+f0eyAxAdQeWKoOwP3xap0wvuorP8YjpRW
        ItEZnUCwe4mslqum7DMAvGQ=
X-Google-Smtp-Source: ADFU+vsXUhp6VDVmW5vAo30YzSP0UO1cBVfz5eyx6kENY/e5YUZBMPeB9eejS87kLB1adUT/5eeKUQ==
X-Received: by 2002:a17:90a:9b06:: with SMTP id f6mr15750719pjp.76.1584968980066;
        Mon, 23 Mar 2020 06:09:40 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id u14sm12262034pgg.67.2020.03.23.06.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:09:39 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 2/6] x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
Date:   Mon, 23 Mar 2020 06:09:20 -0700
Message-Id: <20200323130924.2968-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

If kmsg_dump_register() fails, hv_panic_page will not be used
anywhere.  So free and reset it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update commit log
	- Remove hv_free_hyperv_page() in the error path
---
 drivers/hv/vmbus_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b56b9fb9bd90..3a0472c8b7ae 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1385,9 +1385,13 @@ static int vmbus_bus_init(void)
 			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
 			if (hv_panic_page) {
 				ret = kmsg_dump_register(&hv_kmsg_dumper);
-				if (ret)
+				if (ret) {
 					pr_err("Hyper-V: kmsg dump register "
 						"error 0x%x\n", ret);
+					hv_free_hyperv_page(
+					    (unsigned long)hv_panic_page);
+					hv_panic_page = NULL;
+				}
 			} else
 				pr_err("Hyper-V: panic message page memory "
 					"allocation failed");
@@ -1412,7 +1416,6 @@ static int vmbus_bus_init(void)
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
-	hv_free_hyperv_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
 	return ret;
-- 
2.14.5

