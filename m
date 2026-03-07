Return-Path: <linux-hyperv+bounces-9188-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IL6HmKEq2n/dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9188-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:50:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD4B2297D6
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB72230E4946
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFD333290F;
	Sat,  7 Mar 2026 01:47:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEA32ED24;
	Sat,  7 Mar 2026 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848057; cv=none; b=PrhhtwVgewbx1PtPfes8WZlp/lMln5n3oU4E3jMtgzZFRh9eJCV2f0lgHm5FSK65Im6VMvuOp4SCSoMFyyH4kTXv3AENLCGQyZCW0oWNIC9q4INXktSk3NkKwFQdqyDwmBQnLPX77AFNnLbmCFthTTSr7U0SWwbO1kZsprmTNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848057; c=relaxed/simple;
	bh=B1kAd7tzvvgelixw6i3I30H8twYG1KH2iOY+Hc+q92c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=op3LgEQ/YPVVY4H5PCV6wT4FcSTpvI5FYycNV3+Ni73ppVw0FSplyfFfcM13AL0ecnEj9yzfJUQ5bIiTj1eEwKRPue/Z0eI3A3iYhESOjVfvFPelfIxssMqZu7dCOLMeryYZV8vNZQsmM6XqKMOnB7nYlMbb7b5YpuGPHbkkgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 62CDA20B6F02; Fri,  6 Mar 2026 17:47:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 62CDA20B6F02
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
Subject: [PATCH rdma-next 6/8] RDMA/mana_ib: Track MR per ucontext
Date: Fri,  6 Mar 2026 17:47:20 -0800
Message-ID: <20260307014723.556523-7-longli@microsoft.com>
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
X-Rspamd-Queue-Id: DCD4B2297D6
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
	TAGGED_FROM(0.00)[bounces-9188-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.687];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add per-ucontext list tracking for MR objects. Each MR is added to
the ucontext's mr_list on creation and removed on destruction. This
enables iterating over all MRs belonging to a ucontext for service
reset cleanup.

Also export mana_ib_gd_destroy_mr() for use by reset cleanup code.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    |  1 +
 drivers/infiniband/hw/mana/mana_ib.h |  3 +++
 drivers/infiniband/hw/mana/mr.c      | 21 ++++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index c6a859628ba3..f739e6da5435 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -243,6 +243,7 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 
 	mutex_init(&ucontext->lock);
 	INIT_LIST_HEAD(&ucontext->pd_list);
+	INIT_LIST_HEAD(&ucontext->mr_list);
 	INIT_LIST_HEAD(&ucontext->cq_list);
 	INIT_LIST_HEAD(&ucontext->qp_list);
 	INIT_LIST_HEAD(&ucontext->wq_list);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 9d90fda2c830..ce5c6c030fb2 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -134,6 +134,7 @@ struct mana_ib_mr {
 	struct ib_mr ibmr;
 	struct ib_umem *umem;
 	mana_handle_t mr_handle;
+	struct list_head ucontext_list;
 };
 
 struct mana_ib_dm {
@@ -208,6 +209,7 @@ struct mana_ib_ucontext {
 	/* Protects resource lists below */
 	struct mutex lock;
 	struct list_head pd_list;
+	struct list_head mr_list;
 	struct list_head cq_list;
 	struct list_head qp_list;
 	struct list_head wq_list;
@@ -665,6 +667,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 				  struct ib_udata *udata);
 
 int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
+int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle);
 
 int mana_ib_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index 9613b225dad4..559bb4f7c31d 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -87,7 +87,7 @@ static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_mr *mr,
 	return 0;
 }
 
-static int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
+int mana_ib_gd_destroy_mr(struct mana_ib_dev *dev, u64 mr_handle)
 {
 	struct gdma_destroy_mr_response resp = {};
 	struct gdma_destroy_mr_request req = {};
@@ -185,6 +185,16 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	 * as part of the lifecycle of this MR.
 	 */
 
+	INIT_LIST_HEAD(&mr->ucontext_list);
+	if (udata) {
+		struct mana_ib_ucontext *mana_ucontext =
+			rdma_udata_to_drv_context(udata,
+				struct mana_ib_ucontext, ibucontext);
+		mutex_lock(&mana_ucontext->lock);
+		list_add_tail(&mr->ucontext_list, &mana_ucontext->mr_list);
+		mutex_unlock(&mana_ucontext->lock);
+	}
+
 	return &mr->ibmr;
 
 err_dma_region:
@@ -313,6 +323,15 @@ int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 
+	if (udata) {
+		struct mana_ib_ucontext *mana_ucontext =
+			rdma_udata_to_drv_context(udata,
+				struct mana_ib_ucontext, ibucontext);
+		mutex_lock(&mana_ucontext->lock);
+		list_del_init(&mr->ucontext_list);
+		mutex_unlock(&mana_ucontext->lock);
+	}
+
 	err = mana_ib_gd_destroy_mr(dev, mr->mr_handle);
 	if (err)
 		return err;
-- 
2.43.0


