Return-Path: <linux-hyperv+bounces-481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEBB7BD4C9
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Oct 2023 10:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12533281464
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Oct 2023 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9913FFE;
	Mon,  9 Oct 2023 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JUxaZe0n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AE11735;
	Mon,  9 Oct 2023 08:00:22 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42BBD94;
	Mon,  9 Oct 2023 01:00:21 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C11DF20B74C0;
	Mon,  9 Oct 2023 01:00:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C11DF20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696838420;
	bh=ciYxCapYU4oDZf85UphUOQ42M2gQNBx7cupu6nGUlqQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JUxaZe0nfozj3VHJpAhqgwB434gj84XxYY55KnpWkujWG26TrS5THd1uO2q93JshY
	 614VTdFg48DBEO2XjrNkIrzhC09Ij87LNruIKZ6wlpjo9x80TpZcOumQeDcgez1Aqz
	 9AHhNKIRXnggcePwHvWDedBPRywMTKBcIyqwVvsg=
From: Sonia Sharma <sosha@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	sosha@microsoft.com,
	kys@microsoft.com,
	mikelley@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v7] hv_netvsc: fix netvsc_send_completion to avoid multiple message length checks
Date: Mon,  9 Oct 2023 01:00:16 -0700
Message-Id: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Sonia Sharma <sonia.sharma@linux.microsoft.com>

The switch statement in netvsc_send_completion() is incorrectly validating
the length of incoming network packets by falling through to the next case.
Avoid the fallthrough. Instead break after a case match and then process
the complete() call.
The current code has not caused any known failures. But nonetheless, the
code should be corrected as a different ordering of the switch cases might
cause a length check to fail when it should not.

Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>

---
Changes in v3:
* added return statement in default case as pointed by Michael Kelley.
Changes in v4:
* added fixes tag
* modified commit message to explain the issue fixed by patch.
Changes in v5:
* Dropped fixes tag as suggested by Simon Horman.
* fixed indentation
Changes in v7:
* Dropped the prefix "net" from subject line.
---
 drivers/net/hyperv/netvsc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 82e9796c8f5e..0f7e4d377776 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -851,7 +851,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -860,7 +860,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -869,7 +869,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG5_TYPE_SUBCHANNEL:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -878,10 +878,6 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		/* Copy the response back */
-		memcpy(&net_device->channel_init_pkt, nvsp_packet,
-		       sizeof(struct nvsp_message));
-		complete(&net_device->channel_init_wait);
 		break;
 
 	case NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE:
@@ -904,13 +900,19 @@ static void netvsc_send_completion(struct net_device *ndev,
 
 		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
 					desc, budget);
-		break;
+		return;
 
 	default:
 		netdev_err(ndev,
 			   "Unknown send completion type %d received!!\n",
 			   nvsp_packet->hdr.msg_type);
+		return;
 	}
+
+	/* Copy the response back */
+	memcpy(&net_device->channel_init_pkt, nvsp_packet,
+	       sizeof(struct nvsp_message));
+	complete(&net_device->channel_init_wait);
 }
 
 static u32 netvsc_get_next_send_section(struct netvsc_device *net_device)
-- 
2.25.1


