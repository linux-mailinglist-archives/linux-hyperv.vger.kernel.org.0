Return-Path: <linux-hyperv+bounces-9187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJwrEk+Eq2n/dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9187-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:50:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BF2297C0
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B09A30401BC
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEFA332615;
	Sat,  7 Mar 2026 01:47:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1D322A3F;
	Sat,  7 Mar 2026 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848057; cv=none; b=Bv316MteF5GAqzX2tDw74+dY9yPoZiDMFjzbAHEQLYcpld0rnjy+dgVn6Cyu1Jveq7tf3/EphgHE+381ddrFVb8yH7Vspsb6ZT1HCa6/t5KeZZDT7f0DAK7hxKOXy5/4krlFCwcsjE552ojmx+fiOH5YKcp68cUxL2WhbDqBK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848057; c=relaxed/simple;
	bh=+E6tUNVLg6Z07+L3m8UPDVdE0xwQVknhfinpmyWAJ40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1Epg0hLW3SnbVCLZXaNhb7wfJeEzS3URzF4Q9H+PUN3KM2jNv5JenDEVN/O9hh2+QWdJYfdn+vZPvODalSoHXX91WJaFCgqrOl3Zq4r/jZd3zwPnU172RrwEwGhpGk6a+ZUWDq/um+MxmKZVkDwxc7nWHwzj0twpkdWofn2tBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id E08DA20B6F07; Fri,  6 Mar 2026 17:47:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E08DA20B6F07
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
Subject: [PATCH rdma-next 5/8] RDMA/mana_ib: Track QP per ucontext
Date: Fri,  6 Mar 2026 17:47:19 -0800
Message-ID: <20260307014723.556523-6-longli@microsoft.com>
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
X-Rspamd-Queue-Id: CE9BF2297C0
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
	TAGGED_FROM(0.00)[bounces-9187-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.691];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add per-ucontext list tracking for QP objects. Only RAW_PACKET QPs
are tracked since they persist across reset events. RC, UD and GSI
QPs are removed and re-added during reset by IB core and do not
need tracking.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    |  1 +
 drivers/infiniband/hw/mana/mana_ib.h |  2 ++
 drivers/infiniband/hw/mana/qp.c      | 47 ++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index e6da5c8400f4..c6a859628ba3 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -244,6 +244,7 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	mutex_init(&ucontext->lock);
 	INIT_LIST_HEAD(&ucontext->pd_list);
 	INIT_LIST_HEAD(&ucontext->cq_list);
+	INIT_LIST_HEAD(&ucontext->qp_list);
 	INIT_LIST_HEAD(&ucontext->wq_list);
 
 	mutex_lock(&mdev->ucontext_lock);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index 96b5a13470ae..9d90fda2c830 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -198,6 +198,7 @@ struct mana_ib_qp {
 
 	refcount_t		refcount;
 	struct completion	free;
+	struct list_head	ucontext_list;
 };
 
 struct mana_ib_ucontext {
@@ -208,6 +209,7 @@ struct mana_ib_ucontext {
 	struct mutex lock;
 	struct list_head pd_list;
 	struct list_head cq_list;
+	struct list_head qp_list;
 	struct list_head wq_list;
 };
 
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad37a..315bc54d8ae6 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -700,14 +700,31 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		      struct ib_udata *udata)
 {
+	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
+	int err;
+
+	INIT_LIST_HEAD(&qp->ucontext_list);
+
 	switch (attr->qp_type) {
 	case IB_QPT_RAW_PACKET:
 		/* When rwq_ind_tbl is used, it's for creating WQs for RSS */
 		if (attr->rwq_ind_tbl)
-			return mana_ib_create_qp_rss(ibqp, ibqp->pd, attr,
-						     udata);
+			err = mana_ib_create_qp_rss(ibqp, ibqp->pd, attr,
+						    udata);
+		else
+			err = mana_ib_create_qp_raw(ibqp, ibqp->pd, attr,
+						    udata);
+
+		if (!err && udata) {
+			struct mana_ib_ucontext *mana_ucontext =
+				rdma_udata_to_drv_context(udata,
+					struct mana_ib_ucontext, ibucontext);
+			mutex_lock(&mana_ucontext->lock);
+			list_add_tail(&qp->ucontext_list, &mana_ucontext->qp_list);
+			mutex_unlock(&mana_ucontext->lock);
+		}
 
-		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
+		return err;
 	case IB_QPT_RC:
 		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
 	case IB_QPT_UD:
@@ -716,9 +733,8 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	default:
 		ibdev_dbg(ibqp->device, "Creating QP type %u not supported\n",
 			  attr->qp_type);
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
@@ -898,14 +914,26 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
 int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
+	int ret = -ENOENT;
 
 	switch (ibqp->qp_type) {
 	case IB_QPT_RAW_PACKET:
+		if (udata) {
+			struct mana_ib_ucontext *mana_ucontext =
+				rdma_udata_to_drv_context(udata,
+					struct mana_ib_ucontext, ibucontext);
+			mutex_lock(&mana_ucontext->lock);
+			list_del_init(&qp->ucontext_list);
+			mutex_unlock(&mana_ucontext->lock);
+		}
+
 		if (ibqp->rwq_ind_tbl)
-			return mana_ib_destroy_qp_rss(qp, ibqp->rwq_ind_tbl,
-						      udata);
+			ret = mana_ib_destroy_qp_rss(qp, ibqp->rwq_ind_tbl,
+						     udata);
+		else
+			ret = mana_ib_destroy_qp_raw(qp, udata);
 
-		return mana_ib_destroy_qp_raw(qp, udata);
+		return ret;
 	case IB_QPT_RC:
 		return mana_ib_destroy_rc_qp(qp, udata);
 	case IB_QPT_UD:
@@ -914,7 +942,6 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	default:
 		ibdev_dbg(ibqp->device, "Unexpected QP type %u\n",
 			  ibqp->qp_type);
+		return ret;
 	}
-
-	return -ENOENT;
 }
-- 
2.43.0


