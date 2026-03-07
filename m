Return-Path: <linux-hyperv+bounces-9186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ASKMjOEq2n/dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9186-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:49:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED82297A2
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE89630C6925
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F5330B28;
	Sat,  7 Mar 2026 01:47:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD43290AD;
	Sat,  7 Mar 2026 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848056; cv=none; b=TsHeFp83YDsKaKUIL2X3DzIPhY+7SNWbP8GGHapRiBZYtt0MZo5ymPnI/sPm6pyu/S6C6zoYn2/QOSpyKSecwquXMibJ+Lareu6HIudi1VND0JcbQIW9gnatdOlS+OAeHlslRhASijqKZ53h2u5MMpI7Ba5DmpPzrBLvZzXdFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848056; c=relaxed/simple;
	bh=oTxIDqoEbl50fBrLylQx52l11EfdexSnz/F5QBFSeqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKGS3G5xezPsKeJVCKzYO9l2sxeJ5szAgYFj0GpqfX/6cWRd0EpRfT8v3bGmx5ZSf+gVMH2WBWVADJbukucveeIgoUZPadxfkV2c2pXc9Sj40OPHHUt9lYgjDjka3prMnHSP9LHopYbD9YYTUL/Frqxpjvw+ZHw1uh7PF8DlS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 60EBD20B6F03; Fri,  6 Mar 2026 17:47:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60EBD20B6F03
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 4/8] RDMA/mana_ib: Track WQ per ucontext
Date: Fri,  6 Mar 2026 17:47:18 -0800
Message-ID: <20260307014723.556523-5-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260307014723.556523-1-longli@microsoft.com>
References: <20260307014723.556523-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34ED82297A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9186-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.678];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add per-ucontext list tracking for WQ objects. Each WQ is added to
the ucontext's wq_list on creation and removed on destruction. This
enables iterating over all WQs belonging to a ucontext for service
reset cleanup.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    |  1 +
 drivers/infiniband/hw/mana/mana_ib.h |  2 ++
 drivers/infiniband/hw/mana/wq.c      | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 214c1d4e1548..e6da5c8400f4 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -244,6 +244,7 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	mutex_init(&ucontext->lock);
 	INIT_LIST_HEAD(&ucontext->pd_list);
 	INIT_LIST_HEAD(&ucontext->cq_list);
+	INIT_LIST_HEAD(&ucontext->wq_list);
 
 	mutex_lock(&mdev->ucontext_lock);
 	list_add_tail(&ucontext->dev_list, &mdev->ucontext_list);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 8d3edf7ba335..96b5a13470ae 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -94,6 +94,7 @@ struct mana_ib_wq {
 	int wqe;
 	u32 wq_buf_size;
 	mana_handle_t rx_object;
+	struct list_head ucontext_list;
 };
 
 struct mana_ib_pd {
@@ -207,6 +208,7 @@ struct mana_ib_ucontext {
 	struct mutex lock;
 	struct list_head pd_list;
 	struct list_head cq_list;
+	struct list_head wq_list;
 };
 
 struct mana_ib_rwq_ind_table {
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 6206244f762e..1af9869933aa 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -41,6 +41,17 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	wq->wqe = init_attr->max_wr;
 	wq->wq_buf_size = ucmd.wq_buf_size;
 	wq->rx_object = INVALID_MANA_HANDLE;
+
+	INIT_LIST_HEAD(&wq->ucontext_list);
+	if (udata) {
+		struct mana_ib_ucontext *mana_ucontext =
+			rdma_udata_to_drv_context(udata,
+				struct mana_ib_ucontext, ibucontext);
+		mutex_lock(&mana_ucontext->lock);
+		list_add_tail(&wq->ucontext_list, &mana_ucontext->wq_list);
+		mutex_unlock(&mana_ucontext->lock);
+	}
+
 	return &wq->ibwq;
 
 err_free_wq:
@@ -64,6 +75,15 @@ int mana_ib_destroy_wq(struct ib_wq *ibwq, struct ib_udata *udata)
 
 	mdev = container_of(ib_dev, struct mana_ib_dev, ib_dev);
 
+	if (udata) {
+		struct mana_ib_ucontext *mana_ucontext =
+			rdma_udata_to_drv_context(udata,
+				struct mana_ib_ucontext, ibucontext);
+		mutex_lock(&mana_ucontext->lock);
+		list_del_init(&wq->ucontext_list);
+		mutex_unlock(&mana_ucontext->lock);
+	}
+
 	mana_ib_destroy_queue(mdev, &wq->queue);
 
 	kfree(wq);
-- 
2.43.0


