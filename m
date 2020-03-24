Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C25081906E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCXH5b (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:57:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34022 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXH5a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so8645743pgn.1;
        Tue, 24 Mar 2020 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Owh6HhA/Q9QOWdvcC38dwfeWoxaH/qECRayNHpurfWs=;
        b=tjbcyKL9KrSWYEMZ/BjPzg/a53Vesi9kEP5IRQewrCOe+AJpqOzeDAdLfr8jF8ASWe
         4EPM83OxU8uDjSU1bsLs8IzU4sZwUePlIu3adlwNWlLYr1M93t1a+dUe56M3jsxj9hEp
         c/pPtRbP+1upCdVe4o3CWfRaMYIVYGqfwX3auy81rISMqiTWspDX/GekyE8f+s/xOx+h
         rn641I9KUaivavk5QedtlPc9cZPCA7M3j2aDcsmjdMuEY5Jr6eXvJ63QPvx2X5OR2d2b
         5teUh1u4x5OtqM3nvdlbQIVMaAnOzX1+veIF0X63sDJTfbtp5siKbcmWjC+ZSAHjrpgD
         vXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Owh6HhA/Q9QOWdvcC38dwfeWoxaH/qECRayNHpurfWs=;
        b=jJAmohUD4bcgmgAZg8/XUrfRWxkxo4bW944lqkX1buhUPLb2qsJw7LsidVN4mAmlTO
         WtdOTHFQXP4tW0qvhZIf3HnSwVgcwgyJ0JlTQYDvrc2WWTBmXCxGt0oGsbfygd8FT6CU
         sKQnNsqjH9SNVsGZSDuj/g4AaufJjLU9tWZ8a8ty4Mwj4winMvyNOmWM/HtM6hCQJ48O
         ThPtAgQLHoeFeymMlMcYwMzXS6CPzYzv2RXSJq/RA6gUrsF7JP086P0xrhUUz5RcUZHt
         7Xhp0jWsZ+CeoOUtRnYQTVsXh3E6rmK+zSL9BoLrSuw9EMf8vJPR/9PkIVVWfolEyEdV
         lS7w==
X-Gm-Message-State: ANhLgQ07ZLAKxY1jY8fpqfRTi5NKDVUgN7wumFUfZktZXLkXcjLnxCxA
        o930mvbmjtEK6F5WQ7y378jnrdhwRXk=
X-Google-Smtp-Source: ADFU+vuXPBgH0kRfPgbnaTcaIb6cqSzdd3E5EhFzcD+Tj0pJkK+TgcnIxxNm0lM5rhNjRlEwQAVl0Q==
X-Received: by 2002:a63:5847:: with SMTP id i7mr25804443pgm.127.1585036648851;
        Tue, 24 Mar 2020 00:57:28 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id x71sm15452076pfd.129.2020.03.24.00.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 00:57:28 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 2/6] x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
Date:   Tue, 24 Mar 2020 00:57:16 -0700
Message-Id: <20200324075720.9462-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
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
index 6478240d11ab..00a511f15926 100644
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
@@ -1416,7 +1420,6 @@ static int vmbus_bus_init(void)
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
-	hv_free_hyperv_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
 	return ret;
-- 
2.14.5

