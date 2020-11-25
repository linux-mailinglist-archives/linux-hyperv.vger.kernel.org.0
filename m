Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C782C37D4
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Nov 2020 05:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgKYDwk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 22:52:40 -0500
Received: from gateway20.websitewelcome.com ([192.185.70.14]:21047 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbgKYDwk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 22:52:40 -0500
X-Greylist: delayed 1312 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 22:52:39 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 6A7D3400D34BC
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Nov 2020 21:27:14 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hlW0kxLwviQiZhlW0kb27x; Tue, 24 Nov 2020 21:30:45 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yYO8qL33jBwoQYbeaYVOoflNZM3NfoUNGeqnAr79P0o=; b=qh5s3HRp3cT+JMgfQAFBxyRYd9
        C3B38EarTvjWlcSpq3BIgt89Z9uoxum21Loe7Hkf5kX2+uA1jhTxusLKYC3XUfkxbByG7Ol4g1nTD
        bsOA6eWqFFBZfaOx6tGHP/2mlzVxztnl9na3FmGYJnGfMDUWZ6o5Is4LWKdJciYQewUssyHMlpwQT
        BE15ValGLi+oejac9zircQL6ohbyuDO5xacUIKiPEHfGnd9EvOh/krSI3HJbwY4I4ZB3HZl13dnjj
        PoqTZAmDhwKInk0fkNiKcFTNqQnYcJwtE8CYzo8KnmdlbKc9qT5UgYcIHMKETHvhRGrlpkkbI06wh
        Pb7gj9mQ==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50102 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1khlW0-0034pq-4W; Wed, 25 Nov 2020 00:30:44 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     mikelley@microsoft.com, wei.liu@kernel.org, joe@perches.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        sunilmut@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Date:   Wed, 25 Nov 2020 00:29:26 -0300
Message-Id: <20201125032926.17002-1-matheus@castello.eng.br>
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
X-Exim-ID: 1khlW0-0034pq-4W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50102
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 15
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
This is the V3 of patch 4 of the series "Add improvements suggested by
checkpatch for vmbus_drv" with the changes suggested by Michael Kelley and
Joe Perches. Thanks!
---
 drivers/hv/vmbus_drv.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 61d28c743263..edcc419ba328 100644
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
+		pr_err("Hyper-V: panic message page memory allocation failed\n");
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

