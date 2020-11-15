Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0B2B3907
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 21:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgKOUUh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 15:20:37 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.162]:15790 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727553AbgKOUUh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 15:20:37 -0500
X-Greylist: delayed 1340 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 15:20:36 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0115B20B40
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 13:58:15 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id eOAAkQyHvmi4BeOAAkRo9w; Sun, 15 Nov 2020 13:58:14 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rah/S8YAQ7saare3sIo3uqQ/44a3rofOOnXnbQNuukM=; b=GDfZl0r9Ej6WjFTovf0Yh/cv1n
        Qc83Djfx+XmDt6x8+FkI6z9JsvQJCeKFuE6RON6R5BLzCnKuprAQqhSKM/Fvji7ShpX2VHCBUxpZa
        lBEFj8tYZt5YcyrckoOwNEkZn6UQst2Npt85DpHRZNW4QgtYKGe/KAmApnSrB92Babi02mWrybNB3
        bwtfxEkSrIl2IPUQqyeO6BJw+PQeMj+4qqqRxVvpGVcN2d1BXWIYGkvA5HOHoeb+xWgmnJYmCc8d2
        p4L+eNinxrb1aNJAGJnQQVU8zqGPvvtfV3fmpc+zWq1vWvTwh5sgqy2m5ygnYZ5Azco7K5uCXYY4L
        hgYInIHQ==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50406 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1keOAA-000kPb-DE; Sun, 15 Nov 2020 16:58:14 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, sunilmut@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 2/6] drivers: hv: vmbus: Replace symbolic permissions by octal permissions
Date:   Sun, 15 Nov 2020 16:57:30 -0300
Message-Id: <20201115195734.8338-3-matheus@castello.eng.br>
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
X-Exim-ID: 1keOAA-000kPb-DE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50406
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 28
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This fixed the below checkpatch issue:
WARNING: Symbolic permissions 'S_IRUGO' are not preferred.
Consider using octal permissions '0444'.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/hv/vmbus_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 9ed7e3b1d654..52c1407c1849 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1812,7 +1812,7 @@ static ssize_t channel_pending_show(struct vmbus_channel *channel,
 		       channel_pending(channel,
 				       vmbus_connection.monitor_pages[1]));
 }
-static VMBUS_CHAN_ATTR(pending, S_IRUGO, channel_pending_show, NULL);
+static VMBUS_CHAN_ATTR(pending, 0444, channel_pending_show, NULL);

 static ssize_t channel_latency_show(struct vmbus_channel *channel,
 				    char *buf)
@@ -1821,19 +1821,19 @@ static ssize_t channel_latency_show(struct vmbus_channel *channel,
 		       channel_latency(channel,
 				       vmbus_connection.monitor_pages[1]));
 }
-static VMBUS_CHAN_ATTR(latency, S_IRUGO, channel_latency_show, NULL);
+static VMBUS_CHAN_ATTR(latency, 0444, channel_latency_show, NULL);

 static ssize_t channel_interrupts_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%llu\n", channel->interrupts);
 }
-static VMBUS_CHAN_ATTR(interrupts, S_IRUGO, channel_interrupts_show, NULL);
+static VMBUS_CHAN_ATTR(interrupts, 0444, channel_interrupts_show, NULL);

 static ssize_t channel_events_show(struct vmbus_channel *channel, char *buf)
 {
 	return sprintf(buf, "%llu\n", channel->sig_events);
 }
-static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
+static VMBUS_CHAN_ATTR(events, 0444, channel_events_show, NULL);

 static ssize_t channel_intr_in_full_show(struct vmbus_channel *channel,
 					 char *buf)
@@ -1872,7 +1872,7 @@ static ssize_t subchannel_monitor_id_show(struct vmbus_channel *channel,
 {
 	return sprintf(buf, "%u\n", channel->offermsg.monitorid);
 }
-static VMBUS_CHAN_ATTR(monitor_id, S_IRUGO, subchannel_monitor_id_show, NULL);
+static VMBUS_CHAN_ATTR(monitor_id, 0444, subchannel_monitor_id_show, NULL);

 static ssize_t subchannel_id_show(struct vmbus_channel *channel,
 				  char *buf)
--
2.28.0

