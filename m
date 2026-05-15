Return-Path: <linux-hyperv+bounces-10900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADjBAWGcBmoHlQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10900-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:09:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7505E5491AC
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D60305EF13
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 04:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DE3D3CE9;
	Fri, 15 May 2026 04:05:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477B3D1CD0;
	Fri, 15 May 2026 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778817923; cv=none; b=tYQGXNsODkikGxJN/R+cSvHKE2Y7masjD6MQ0fkrtPZB/sBzigO+qvDwNu7dCeiZ2oC29h4tIqOIUUTWAPJZxoHbFxAfVBKxkeGduPj2eoBrRuLO78SUx7xy5Lhei9Uj08WAKEa68nWSZWro8/2CN1b2Hbzs13m5E5kZIMJrwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778817923; c=relaxed/simple;
	bh=nP3mrHN36auxoSmfxMpZZ0zy2j5CyUh05c+rAkpxxrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igFURtpV+hD6EHKcGVazmsX9a+U9nPH1dTrJtlIMIh1Zv8dVvVBpicI+QU6yz/tHlsD5kCIRkXgkI8el+4DPdEoMdWx5ZN2mqnYvmRwDC13iNjIbQoIYejJ233WKJPyRcEmVdsDzLKArdHJbk3h5A1pKmbT94zLHg+Ls2IW3HdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 9BC6720B716B; Thu, 14 May 2026 21:05:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BC6720B716B
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
	Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 5/6] net: mana: Allocate interrupt context for each EQ when creating vPort
Date: Thu, 14 May 2026 21:05:07 -0700
Message-ID: <20260515040508.491748-6-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260515040508.491748-1-longli@microsoft.com>
References: <20260515040508.491748-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7505E5491AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10900-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.812];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Use GIC functions to create a dedicated interrupt context or acquire a
shared interrupt context for each EQ when setting up a vPort.

The caller now owns the GIC reference across the EQ create/destroy
lifecycle: mana_create_eq() calls mana_gd_get_gic() before creating
each EQ and mana_destroy_eq() calls mana_gd_put_gic() after destroying
it. The msix_index invalidation is moved from mana_gd_deregister_irq()
to the mana_gd_create_eq() error path so that mana_destroy_eq() can
read the index before teardown.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c    |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c  | 18 +++++++++++++++++-
 include/net/mana/gdma.h                        |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 265cf32a980f..6ab7e441bd9f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -897,7 +897,6 @@ static void mana_gd_deregister_irq(struct gdma_queue *queue)
 	}
 	spin_unlock_irqrestore(&gic->lock, flags);
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	synchronize_rcu();
 }
 
@@ -1012,6 +1011,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 out:
 	dev_err(dev, "Failed to create EQ: %d\n", err);
 	mana_gd_destroy_eq(gc, false, queue);
+	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d23b856f48f6..8020089de50f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1626,6 +1626,7 @@ void mana_destroy_eq(struct mana_port_context *apc)
 	struct mana_context *ac = apc->ac;
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct gdma_queue *eq;
+	unsigned int msi;
 	int i;
 
 	if (!apc->eqs)
@@ -1639,7 +1640,9 @@ void mana_destroy_eq(struct mana_port_context *apc)
 		if (!eq)
 			continue;
 
+		msi = eq->eq.msix_index;
 		mana_gd_destroy_queue(gc, eq);
+		mana_gd_put_gic(gc, !gc->msi_sharing, msi);
 	}
 
 	kfree(apc->eqs);
@@ -1656,6 +1659,7 @@ static void mana_create_eq_debugfs(struct mana_port_context *apc, int i)
 	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, apc->mana_eqs_debugfs);
 	debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head);
 	debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail);
+	debugfs_create_u32("irq", 0400, eq.mana_eq_debugfs, &eq.eq->eq.irq);
 	debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &mana_dbg_q_fops);
 }
 
@@ -1664,7 +1668,9 @@ int mana_create_eq(struct mana_port_context *apc)
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct gdma_context *gc = gd->gdma_context;
 	struct gdma_queue_spec spec = {};
+	struct gdma_irq_context *gic;
 	int err;
+	int msi;
 	int i;
 
 	if (WARN_ON(apc->eqs))
@@ -1684,12 +1690,22 @@ int mana_create_eq(struct mana_port_context *apc)
 		debugfs_create_dir("EQs", apc->mana_port_debugfs);
 
 	for (i = 0; i < apc->num_queues; i++) {
-		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+		msi = (i + 1) % gc->num_msix_usable;
+
+		gic = mana_gd_get_gic(gc, !gc->msi_sharing, &msi);
+		if (!gic) {
+			err = -ENOMEM;
+			goto out;
+		}
+		spec.eq.msix_index = msi;
+
 		err = mana_gd_create_mana_eq(gd, &spec, &apc->eqs[i].eq);
 		if (err) {
 			dev_err(gc->dev, "Failed to create EQ %d : %d\n", i, err);
+			mana_gd_put_gic(gc, !gc->msi_sharing, msi);
 			goto out;
 		}
+		apc->eqs[i].eq->eq.irq = gic->irq;
 		mana_create_eq_debugfs(apc, i);
 	}
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index fbe3c1427b45..6c138cc77407 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -342,6 +342,7 @@ struct gdma_queue {
 			void *context;
 
 			unsigned int msix_index;
+			unsigned int irq;
 
 			u32 log2_throttle_limit;
 		} eq;
-- 
2.43.0


