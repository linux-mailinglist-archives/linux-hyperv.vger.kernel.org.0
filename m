Return-Path: <linux-hyperv+bounces-2749-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E941494B387
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 01:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74062B20C0B
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 23:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F91C155352;
	Wed,  7 Aug 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="s6mUbQgb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037EE14EC55;
	Wed,  7 Aug 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072633; cv=none; b=N+d5FQrL/fQRW/xe8A5+9qeRpvxxnV+JGRwnUb65aLdlr1xrdPHHZF3SqL2RdG8NLcEGhf3MPKCBF6UQfBDi/wucDU0bnnh3qwCQ1rJSMdg+5VRXAZP1k56QvroemKUWCN1LDDlLoqGgN9ucsmOr9u2+hjm4xRF71JEsgBsZGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072633; c=relaxed/simple;
	bh=9UvoLi5cJO00aEAElI4jIxcTmYYWVZzyvrhZaKFx6g4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qQjb/2iBWdpPkcups7O8RwqYkziJBE35Od4cZaJeFobXCaK7WaDSn+szOsLklCk1GAY2cTFdvqWBCtBOiiya6ZHy7+sOirEVaL5oQvncQgEDV5OGXlzqdhhzJxvlV5AsfjJCL8jdOXsNqVk4kVRimiuLY/l2WnTAuZiiW+qND8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=s6mUbQgb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 7DC3D20B7165; Wed,  7 Aug 2024 16:17:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DC3D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1723072631;
	bh=O7xwfu9nS3te7zal8RpgadWiWfv4YgCbtr93q45X56s=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=s6mUbQgby0seKrrQc49gyHn2eVdqBIpPn9L39Odo3ZvcYkaQ7W5PeoqciSRkW+Zuu
	 d9QG8dlLh4a6I6iAEvC8Lgt48y/xFJTGquj/iL1KbnSii+voY9kJnh8ehFmdtPYx0E
	 MHqrV3GC5It99k90qag78OUX+7c/55WEJAZTTQK4=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 net] net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings
Date: Wed,  7 Aug 2024 16:17:06 -0700
Message-Id: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

After napi_complete_done() is called when NAPI is polling in the current
process context, another NAPI may be scheduled and start running in
softirq on another CPU and may ring the doorbell before the current CPU
does. When combined with unnecessary rings when there is no need to arm
the CQ, it triggers error paths in the hardware.

This patch fixes this by calling napi_complete_done() after doorbell
rings. It limits the number of unnecessary rings when there is
no need to arm. MANA hardware specifies that there must be one doorbell
ring every 8 CQ wraparounds. This driver guarantees one doorbell ring as
soon as the number of consumed CQEs exceeds 4 CQ wraparounds. In pratical
workloads, the 4 CQ wraparounds proves to be big enough that it rarely
exceeds this limit before all the napi weight is consumed.

To implement this, add a per-CQ counter cq->work_done_since_doorbell,
and make sure the CQ is armed as soon as passing 4 wraparounds of the CQ.

Cc: stable@vger.kernel.org
Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---

change in v2:
Added more details to comments to explain the patch

 drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
 include/net/mana/mana.h                       |  1 +
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d2f07e179e86..f83211f9e737 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1788,7 +1788,6 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 {
 	struct mana_cq *cq = context;
-	u8 arm_bit;
 	int w;
 
 	WARN_ON_ONCE(cq->gdma_cq != gdma_queue);
@@ -1799,16 +1798,23 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 		mana_poll_tx_cq(cq);
 
 	w = cq->work_done;
-
-	if (w < cq->budget &&
-	    napi_complete_done(&cq->napi, w)) {
-		arm_bit = SET_ARM_BIT;
-	} else {
-		arm_bit = 0;
+	cq->work_done_since_doorbell += w;
+
+	if (w < cq->budget) {
+		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
+		cq->work_done_since_doorbell = 0;
+		napi_complete_done(&cq->napi, w);
+	} else if (cq->work_done_since_doorbell >
+		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
+		/* MANA hardware requires at least one doorbell ring every 8
+		 * wraparounds of CQ even if there is no need to arm the CQ.
+		 * This driver rings the doorbell as soon as we have exceeded
+		 * 4 wraparounds.
+		 */
+		mana_gd_ring_cq(gdma_queue, 0);
+		cq->work_done_since_doorbell = 0;
 	}
 
-	mana_gd_ring_cq(gdma_queue, arm_bit);
-
 	return w;
 }
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 6439fd8b437b..7caa334f4888 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -275,6 +275,7 @@ struct mana_cq {
 	/* NAPI data */
 	struct napi_struct napi;
 	int work_done;
+	int work_done_since_doorbell;
 	int budget;
 };
 
-- 
2.17.1


