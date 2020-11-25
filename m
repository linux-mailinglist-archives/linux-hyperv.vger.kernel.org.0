Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC42C36A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 03:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgKYCOh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 21:14:37 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.48]:45283 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKYCOg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 21:14:36 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 0C9FC19E33
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2020 20:14:32 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hkKGkwLKCiQiZhkKGka2cq; Tue, 24 Nov 2020 20:14:32 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2wqcYIgsj+xhVUAMzlLmwMnVlrncB6FsZ9cyO+nhhGw=; b=0utgvdVQ8F/G48uxVZmxTOCij6
        w3aEo2287fRxOmKq1IHVJ3/98pFzl7Q2sL2vWQZsUcGNENq2xu+tLnimixujklGfzuBcMKJ2eRdj2
        NFYSRqfbvS2luPbBXZNwK5ABdcaGj31oJIHi/2VUbFF4BX5OI7Bk35NvwUUMp11lpaAgyJdgJTfjj
        jJnE4DAlOtItmcYVj8Ah6fweGefY7f7lLqu4cOYs642RM31rffqmSgeX+TJ+G+SuaL8yOn+BC0O5e
        mBVLvKxMnHsYs+2TNf6NEzYbaLhcmZNKL5EB01kbC1Ebi0w3TLLkdJFaS9tRMr1TOuZVI5OXmx61b
        fPvhdxXA==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50086 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1khkKF-002mQO-WD; Tue, 24 Nov 2020 23:14:32 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     mikelley@microsoft.com, wei.liu@kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        sunilmut@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Date:   Tue, 24 Nov 2020 23:14:03 -0300
Message-Id: <20201125021403.3621-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1khkKF-002mQO-WD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50086
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Checkpatch emits WARNING: quoted string split across lines.
To keep the code clean and with the 80 column length indentation the
check and registration code for kmsg_dump_register has been transferred
to a new function hv_kmsg_dump_register.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
This is the V2 of patch 4 of the series "Add improvements suggested by
checkpatch for vmbus_drv" with the changes suggested by Michael Kelley
---
 drivers/hv/vmbus_drv.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 61d28c743263..d70da8fee409 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1387,6 +1387,24 @@ static struct kmsg_dumper hv_kmsg_dumper = {
 	.dump = hv_kmsg_dump,
 };

+static void hv_kmsg_dump_register(void)
+{
+	int ret;
+
+	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
+	if (!hv_panic_page) {
+		pr_err("Hyper-V: panic message page memory allocation failed");
+		return;
+	}
+
+	ret = kmsg_dump_register(&hv_kmsg_dumper);
+	if (ret) {
+		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
+		hv_free_hyperv_page((unsigned long)hv_panic_page);
+		hv_panic_page = NULL;
+	}
+}
+
 static struct ctl_table_header *hv_ctl_table_hdr;

 /*
@@ -1477,21 +1495,8 @@ static int vmbus_bus_init(void)
 		 * capability is supported by the hypervisor.
 		 */
 		hv_get_crash_ctl(hyperv_crash_ctl);
-		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
-			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
-			if (hv_panic_page) {
-				ret = kmsg_dump_register(&hv_kmsg_dumper);
-				if (ret) {
-					pr_err("Hyper-V: kmsg dump register "
-						"error 0x%x\n", ret);
-					hv_free_hyperv_page(
-					    (unsigned long)hv_panic_page);
-					hv_panic_page = NULL;
-				}
-			} else
-				pr_err("Hyper-V: panic message page memory "
-					"allocation failed");
-		}
+		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
+			hv_kmsg_dump_register();

 		register_die_notifier(&hyperv_die_block);
 	}
--
2.29.2

