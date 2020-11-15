Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC002B3905
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 21:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgKOUUV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 15:20:21 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.219]:39191 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727184AbgKOUUS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 15:20:18 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7A4EC4BDBC
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 13:58:32 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id eOASkT3s4fgo0eOASkP5VW; Sun, 15 Nov 2020 13:58:32 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=C6X59wyPVRlF1KUI8WrlY0BS6G519N9srE9MF7rS9Mg=; b=QXk+q6y9FHie5C8vLRGSEklwL4
        cokCfFhiAO/2Nco1WiQpAA68vCwMJ0rSQxDnVnn9rByRwRvEEjLH6mUilVIZGhk2ess5cDyEocHkM
        ut1GwhuW+vv/o8gfp12+nTFwTSSpivrv7e6S3ZhzT9OiBgx+IVYTEiRW5uzU7X7e8o/q9wzZ0lMUl
        clV7PaiaPUJgfwXpkYifLAhIc1rX9p5eQFBEOcg7eEythkFe5Kf9AocvaiHIdTeGJjJ2a3nDs3S0t
        haRvxvxwoo1HlQl5DavoUWMo2rgMF0/2m9UR83HC+4i7lAvxqP+1AQUe488aechVEjY0efMJY1X9H
        5JMCUVQw==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50406 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1keOAR-000kPb-U5; Sun, 15 Nov 2020 16:58:32 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, sunilmut@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Date:   Sun, 15 Nov 2020 16:57:32 -0300
Message-Id: <20201115195734.8338-5-matheus@castello.eng.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115195734.8338-1-matheus@castello.eng.br>
References: <20201115195734.8338-1-matheus@castello.eng.br>
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
X-Exim-ID: 1keOAR-000kPb-U5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50406
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 52
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
 drivers/hv/vmbus_drv.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 61d28c743263..09d8236a51cf 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1387,6 +1387,23 @@ static struct kmsg_dumper hv_kmsg_dumper = {
 	.dump = hv_kmsg_dump,
 };

+static void hv_kmsg_dump_register(void)
+{
+	int ret;
+
+	hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
+	if (hv_panic_page) {
+		ret = kmsg_dump_register(&hv_kmsg_dumper);
+		if (ret) {
+			pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
+			hv_free_hyperv_page((unsigned long)hv_panic_page);
+			hv_panic_page = NULL;
+		}
+	} else {
+		pr_err("Hyper-V: panic message page memory allocation failed");
+	}
+}
+
 static struct ctl_table_header *hv_ctl_table_hdr;

 /*
@@ -1477,21 +1494,8 @@ static int vmbus_bus_init(void)
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
2.28.0

