Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3546B2B3936
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgKOUqq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 15:46:46 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.206]:32472 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727317AbgKOUqq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 15:46:46 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 566CA1457
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 13:58:06 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id eOA2kcedrAAk4eOA2kAQAz; Sun, 15 Nov 2020 13:58:06 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bOKpAE0u0OIU1AWwoNGyT/a5tbhFD6D8zYEC/nbjwFA=; b=NP9U+VssBLQ2ltBAlZ66Nc91Tm
        tLTowkwv50JdPJgEZDNOjT4CBQJaGkd0uCzVgfa+hH25BvondKIU0mKeut+af5Xb9vi2ttw4G5Pu0
        gK79/hvg7a9A09KZGXU7vKJPIR5nKcGFFZdANkZRTMEW3tYVEfw2E7oz3vJOpjrpx89Lk9jru0Wv9
        bX/SL6u7qeFXIRtFM+2Fp7LS8YSIWGdXVptpjYTKEbx37ZMk+SsFaFkyHjVLT7jNSwGwP3V3gHsRZ
        ZG8Bydv7ySwIbdDqeEGYRrQrNXrzuFa6XWwnBd1/rE3SMRKvW/Z+OuveQL8KpjYvtCUqY1DJtlw8+
        gsM0+Lrw==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50406 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1keOA1-000kPb-Pl; Sun, 15 Nov 2020 16:58:06 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, sunilmut@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 1/6] drivers: hv: Fix hyperv_record_panic_msg path on comment
Date:   Sun, 15 Nov 2020 16:57:29 -0300
Message-Id: <20201115195734.8338-2-matheus@castello.eng.br>
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
X-Exim-ID: 1keOA1-000kPb-Pl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50406
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 16
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix the kernel parameter path in the comment, in the documentation the
parameter is correct but if someone who is studying the code and see
this first can get confused and try to access the wrong path/parameter

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4fad3e6745e5..9ed7e3b1d654 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -55,7 +55,7 @@ int vmbus_interrupt;
 /*
  * Boolean to control whether to report panic messages over Hyper-V.
  *
- * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
+ * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
  */
 static int sysctl_record_panic_msg = 1;

--
2.28.0

