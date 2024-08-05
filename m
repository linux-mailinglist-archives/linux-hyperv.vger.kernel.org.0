Return-Path: <linux-hyperv+bounces-2726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F97194862F
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 01:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913AF1C22218
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Aug 2024 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19816DC02;
	Mon,  5 Aug 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="f+wx+VRe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F416D9A4;
	Mon,  5 Aug 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901120; cv=none; b=lCSJtUz9rXVARj2tZZF/Fl3xXmsf8BW3HjtJbCRxyW6ds2BySnpXO17fbF2aUQp/1Yw1jGZjiu5SCYSMPaONe0fHbdABwYVvKhizDPxbWIEKa/FRgfKqyVkbIrEy7mwlsBgdLqBLWgkqpYncOKOHDOuZ3ZMXsMIx87Qaqe9WrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901120; c=relaxed/simple;
	bh=BE2yy+dxZDCTdQqAauR/rYcRVaXPWIrQibEZm5Noy8k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lAlNXxeW2Vagr6N/+POeMGQo1VFgbUW8POUVW7bICvhEMF0P3DcZcYfMO3y1fEpC5Bt5rSl0yAls+df42Ge9DHqYk3MOW0mUnyYZfGuB7CL58B1q2V1HLeCH5ZHYVjnlfNqnOX7DvPniMomyipptuA2hCqmvwHoz4J83cAY861c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=f+wx+VRe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id A3FEE20B7165; Mon,  5 Aug 2024 16:38:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3FEE20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1722901118;
	bh=cvB29WQ8UvgjPvJddUfE9WdFQ1bn5OV46Q0AJIFbC0I=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=f+wx+VRelYsh1uVuFycK2IcwF7KrKTsqoxQ80BnnqMyBqdItwxUsU8zjnXp6gJfKw
	 lYEKUtP3A4zwWINnuD2S8yuH4tTSyjjf0ISw7g12IgROKeMvzh13LvOVtjUwU/FI2D
	 V//IHuY8KK5HoDI5tVfZuHsB7VlIoInv/nSuC4Ak=
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
Subject: [PATCH net] net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings
Date: Mon,  5 Aug 2024 16:38:08 -0700
Message-Id: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

After napi_complete_done() is called, another NAPI may be running on
another CPU and ring the doorbell before the current CPU does. When
combined with unnecessary rings when there is no need to ARM the CQ, this
triggers error paths in the hardware.

Fix this by always ring the doorbell in sequence and avoid unnecessary
rings.

Cc: stable@vger.kernel.org
Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
 include/net/mana/mana.h                       |  1 +
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d2f07e179e86..7d08e23c6749 100644
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
+		 * wraparounds of CQ even there is no need to ARM. This driver
+		 * rings the doorbell as soon as we have execceded 4
+		 * wraparounds.
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


