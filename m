Return-Path: <linux-hyperv+bounces-9675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMIgJTTfvWk1DAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9675-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:58:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC32E2666
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16DE030AB8F1
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270D3F7871;
	Fri, 20 Mar 2026 23:54:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98183E3DA2;
	Fri, 20 Mar 2026 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774050880; cv=none; b=N3GooKY2IbtQdO5PkZjjDBbFlzPuQJlOYgzGNjq11vYsmBdCwrOZd7BwZpc+1fjt7o6jF3wDdUKA830x69oPt6jZ+AOIlfkmvgw2/NU9N8PZkVr5bnJsVHMTBYRfWnn407mrr8CsBiom/AGVRmyJdbpbfze8nX+8cGgaJPDzGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774050880; c=relaxed/simple;
	bh=RxYE/so7PkVMrNqNg4s1usnrGJ7/UNL8lShLCvr5o1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzmM2S7DlOD0FCpo+j3MhI1HNAsd0uSmB3MVOqKRXZEVuYqAVavRRLnbsi32WrUy3R+9dyNATr+1rDeY6u/LwlvYVpc6GZfbsrlzvaodpDufOWCQSRhktDqxxWQ9f11wrURPfbxVdX/mKpVe4HDOBeaTivEWAl5AUFDWs/1DRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id ACBF020B6F01; Fri, 20 Mar 2026 16:54:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACBF020B6F01
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
Subject: [PATCH net-next v4 5/6] net: mana: Allocate interrupt context for each EQ when creating vPort
Date: Fri, 20 Mar 2026 16:54:18 -0700
Message-ID: <11396c357c4ec2777da89951ca73ed239e265760.1774049761.git.longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1774049761.git.longli@microsoft.com>
References: <cover.1774049761.git.longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-9675-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36FC32E2666
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use GIC functions to create a dedicated interrupt context or acquire a
shared interrupt context for each EQ when setting up a vPort.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 17 ++++++++++++++++-
 include/net/mana/gdma.h                         |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e7d5e589a217..34b19e0740e1 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -826,7 +826,6 @@ static void mana_gd_deregister_irq(struct gdma_queue *queue)
 	}
 	spin_unlock_irqrestore(&gic->lock, flags);
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	synchronize_rcu();
 }
 
@@ -941,6 +940,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 out:
 	dev_err(dev, "Failed to create EQ: %d\n", err);
 	mana_gd_destroy_eq(gc, false, queue);
+	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 87a444a6c297..22444c7530a5 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1606,6 +1606,7 @@ void mana_destroy_eq(struct mana_port_context *apc)
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct gdma_queue *eq;
 	int i;
+	unsigned int msi;
 
 	if (!apc->eqs)
 		return;
@@ -1618,7 +1619,9 @@ void mana_destroy_eq(struct mana_port_context *apc)
 		if (!eq)
 			continue;
 
+		msi = eq->eq.msix_index;
 		mana_gd_destroy_queue(gc, eq);
+		mana_gd_put_gic(gc, !gc->msi_sharing, msi);
 	}
 
 	kfree(apc->eqs);
@@ -1635,6 +1638,7 @@ static void mana_create_eq_debugfs(struct mana_port_context *apc, int i)
 	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, apc->mana_eqs_debugfs);
 	debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head);
 	debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail);
+	debugfs_create_u32("irq", 0400, eq.mana_eq_debugfs, &eq.eq->eq.irq);
 	debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &mana_dbg_q_fops);
 }
 
@@ -1645,6 +1649,7 @@ int mana_create_eq(struct mana_port_context *apc)
 	struct gdma_queue_spec spec = {};
 	int err;
 	int i;
+	struct gdma_irq_context *gic;
 
 	WARN_ON(apc->eqs);
 	apc->eqs = kzalloc_objs(struct mana_eq, apc->num_queues);
@@ -1661,12 +1666,22 @@ int mana_create_eq(struct mana_port_context *apc)
 	apc->mana_eqs_debugfs = debugfs_create_dir("EQs", apc->mana_port_debugfs);
 
 	for (i = 0; i < apc->num_queues; i++) {
-		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+		if (gc->msi_sharing)
+			spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+
+		gic = mana_gd_get_gic(gc, !gc->msi_sharing, &spec.eq.msix_index);
+		if (!gic) {
+			err = -ENOMEM;
+			goto out;
+		}
+
 		err = mana_gd_create_mana_eq(gd, &spec, &apc->eqs[i].eq);
 		if (err) {
 			dev_err(gc->dev, "Failed to create EQ %d : %d\n", i, err);
+			mana_gd_put_gic(gc, !gc->msi_sharing, spec.eq.msix_index);
 			goto out;
 		}
+		apc->eqs[i].eq->eq.irq = gic->irq;
 		mana_create_eq_debugfs(apc, i);
 	}
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 4614a6a7271b..84f85b2299b4 100644
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


