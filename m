Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE12B3900
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 21:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgKOUUQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 15:20:16 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.219]:12528 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727518AbgKOUUQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 15:20:16 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C374252FC5
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 13:58:37 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id eOAXkCIZgosA0eOAXknGvJ; Sun, 15 Nov 2020 13:58:37 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hU4JV4gLkk7rZIZMvWlSeTTTfhejLWb1vrcon+YhLR0=; b=jUxU36SkS7RxT53SPP9DjnuHoi
        Xhswf1yWEQsNI6bDcWYAWWbxfjl9qBQLWrjKhVqwbNYoGq5GZskCnUP1LbGhl9fhThmyh9TJ71OY1
        rcVGYsZSOCYO8XE3TGMAhPclTdTihl06bg5S1V1jfkYnkYVw4eqQpdU0Q44q8fFmmoqUlBmbrll/R
        UofbfOYpVnZyUDoA6pt0K3ALqGLf5kNGfxe+g0QKIv9z3ajgGnfgk1n4BT+irBS13/8ZewV6wnZ+k
        dt1xo2QVm1fmn8JHWGRCVnuAyHRZBDQU0uzMD8+pa4elTAvAjGZGoRldI47pVOUU9P7tyOOP2UzmG
        XuW3Z+fg==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50406 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1keOAX-000kPb-82; Sun, 15 Nov 2020 16:58:37 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, sunilmut@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 5/6] drivers: hv: vmbus: Fix unnecessary OOM_MESSAGE
Date:   Sun, 15 Nov 2020 16:57:33 -0300
Message-Id: <20201115195734.8338-6-matheus@castello.eng.br>
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
X-Exim-ID: 1keOAX-000kPb-82
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50406
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 64
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixed checkpatch warning: Possible unnecessary 'out of memory' message
checkpatch(OOM_MESSAGE)

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/hv/vmbus_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 09d8236a51cf..774b88dd0e15 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1989,10 +1989,8 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	struct hv_device *child_device_obj;

 	child_device_obj = kzalloc(sizeof(struct hv_device), GFP_KERNEL);
-	if (!child_device_obj) {
-		pr_err("Unable to allocate device object for child device\n");
+	if (!child_device_obj)
 		return NULL;
-	}

 	child_device_obj->channel = channel;
 	guid_copy(&child_device_obj->dev_type, type);
--
2.28.0

