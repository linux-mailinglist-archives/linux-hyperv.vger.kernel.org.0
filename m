Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE32B390A
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 21:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKOUWo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 15:22:44 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.175]:31836 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727375AbgKOUWn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 15:22:43 -0500
X-Greylist: delayed 1455 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 15:22:42 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 867A1400D6A84
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 13:58:26 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id eOAMkZ2Q8YLDneOAMkcg5m; Sun, 15 Nov 2020 13:58:26 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NhigeIFL55mczw6UzU0WXtL+wEWxJXwTY0ERi0zRQQM=; b=nZ7L6oUhx4nO1uuQU82dPK74Pu
        vIpYTFtAKGLkP+ThXwEIQJs6yo5+HLqZZQvn/pTwTvw2NmuV3pkwW373cvs5Kw60hKKIjJAAvrDFe
        RT8wavdCj+QI9ryPXqtWTtv/HveBpDwYnEdPPkYGEICHMH0JNmo/AbDhSe/vcav5ViGhaKJcsUXoW
        VQtlR/tiCPJKrfFvmWvpA1B2l7ypbuHwU7QiLpaEcuK9v/in70yirzZ8/vvD65MwlB12o4TUuzlcY
        3CrDXVTSyJCl+BK8SCjfwVFEcTWW0gW/YiszOLXkASHfeuEtgsGdG0w03tFU3Jm1VpccuHmdjhLbW
        rejpDewQ==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50406 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1keOAL-000kPb-Uk; Sun, 15 Nov 2020 16:58:26 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, sunilmut@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 3/6] drivers: hv: vmbus: Fix checkpatch LINE_SPACING
Date:   Sun, 15 Nov 2020 16:57:31 -0300
Message-Id: <20201115195734.8338-4-matheus@castello.eng.br>
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
X-Exim-ID: 1keOAL-000kPb-Uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50406
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 40
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fixed checkpatch warning: Missing a blank line after declarations
checkpatch(LINE_SPACING)

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/hv/vmbus_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 52c1407c1849..61d28c743263 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -156,6 +156,7 @@ static u32 channel_conn_id(struct vmbus_channel *channel,
 {
 	u8 monitor_group = channel_monitor_group(channel);
 	u8 monitor_offset = channel_monitor_offset(channel);
+
 	return monitor_page->parameter[monitor_group][monitor_offset].connectionid.u.id;
 }

@@ -550,6 +551,7 @@ static ssize_t vendor_show(struct device *dev,
 			   char *buf)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
+
 	return sprintf(buf, "0x%x\n", hv_dev->vendor_id);
 }
 static DEVICE_ATTR_RO(vendor);
@@ -559,6 +561,7 @@ static ssize_t device_show(struct device *dev,
 			   char *buf)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
+
 	return sprintf(buf, "0x%x\n", hv_dev->device_id);
 }
 static DEVICE_ATTR_RO(device);
--
2.28.0

