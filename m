Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B1180F8E
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 06:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCKFNy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 01:13:54 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:42890 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726472AbgCKFNy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 01:13:54 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id CEC3318074F14;
        Wed, 11 Mar 2020 05:07:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 103FF10185974;
        Wed, 11 Mar 2020 05:07:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:857:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1542:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6261:9025:9592:10004:10848:11026:11473:11658:11914:12043:12048:12296:12297:12438:12555:12679:12895:12986:13894:14096:14181:14394:14721:21080:21433:21627:21773:21811:21939:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:0,LUA_SUMMARY:none
X-HE-Tag: dolls43_23050b1e12945
X-Filterd-Recvd-Size: 3010
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:20 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH -next 019/491] Hyper-V CORE AND DRIVERS: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:33 -0700
Message-Id: <84677022b8ec4ad14bddab57d871dcbfc0b4a1bf.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hv/hv_kvp.c             | 4 +---
 drivers/hv/vmbus_drv.c          | 2 +-
 drivers/video/fbdev/hyperv_fb.c | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index e74b144..da4686 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,9 +353,7 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 				MAX_IP_ADDR_SIZE);
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
-
-		/* fallthrough */
-
+		fallthrough;
 	case KVP_OP_GET_IP_INFO:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378..0befc0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1188,7 +1188,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 
 			case HV_CALL_BATCHED:
 				hv_begin_read(&channel->inbound);
-				/* fallthrough */
+				fallthrough;
 			case HV_CALL_DIRECT:
 				tasklet_schedule(&channel->callback_event);
 			}
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index e4c3c8b..02411d 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -648,13 +648,13 @@ static int synthvid_connect_vsp(struct hv_device *hdev)
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
 		if (!ret)
 			break;
-		/* Fallthrough */
+		fallthrough;
 	case VERSION_WIN8:
 	case VERSION_WIN8_1:
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
 		if (!ret)
 			break;
-		/* Fallthrough */
+		fallthrough;
 	case VERSION_WS2008:
 	case VERSION_WIN7:
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
-- 
2.24.0

