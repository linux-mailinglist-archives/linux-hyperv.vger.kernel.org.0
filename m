Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B419F76D9FE
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 23:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHBVxW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 17:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHBVwz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 17:52:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A077526A0;
        Wed,  2 Aug 2023 14:52:48 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0D41D238C43B;
        Wed,  2 Aug 2023 14:52:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D41D238C43B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691013168;
        bh=G2LmPikrqZm4cQi6ThuFHrDV8Pbzh+pa+aBYLSIVvvE=;
        h=From:To:Cc:Subject:Date:From;
        b=XVM9Y4LP0lCSgBkL4aBH046GoXGmZNTa8+x8fnmJ7ljBzGCFRXofBIXAS5SJFw4pX
         yboDlcke1xFXS17VNQACnSDMqJ+OwxGRRuEmLclB7DsWjPaS6QdtFUvf5j81obSCfv
         C2giAzGiR3+8N2elfdWLXOhv0/eTwTS/4ccABBGk=
From:   Sonia Sharma <sosha@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        sosha@microsoft.com, kys@microsoft.com, mikelley@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Subject: [PATCH v2 net] net: hv_netvsc: fix netvsc_send_completion to avoid multiple message length checks
Date:   Wed,  2 Aug 2023 14:52:41 -0700
Message-Id: <1691013161-14054-1-git-send-email-sosha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sonia Sharma <sonia.sharma@linux.microsoft.com>

The switch statement in netvsc_send_completion() is incorrectly validating
the length of incoming network packets by falling through to the next case.
Avoid the fallthrough. Instead break after a case match and then process
the complete() call.

Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 82e9796c8f5e..347688dd2eb9 100644
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
@@ -904,13 +900,18 @@ static void netvsc_send_completion(struct net_device *ndev,
 
 		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
 					desc, budget);
-		break;
+		return;
 
 	default:
 		netdev_err(ndev,
 			   "Unknown send completion type %d received!!\n",
 			   nvsp_packet->hdr.msg_type);
 	}
+
+	/* Copy the response back */
+	memcpy(&net_device->channel_init_pkt, nvsp_packet,
+			sizeof(struct nvsp_message));
+	complete(&net_device->channel_init_wait);
 }
 
 static u32 netvsc_get_next_send_section(struct netvsc_device *net_device)
-- 
2.25.1

