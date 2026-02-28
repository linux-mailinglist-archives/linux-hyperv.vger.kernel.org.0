Return-Path: <linux-hyperv+bounces-9056-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GURDZZPomk/1wQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9056-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 03:14:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6E1BFEB1
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 03:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C2130E289C
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8839325488;
	Sat, 28 Feb 2026 02:11:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B41530F95B;
	Sat, 28 Feb 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772244718; cv=none; b=m8oN+HpobpjqwihTLZccGEBCh3NJXNDXV1kVCVO4WLeSaS4oghJSaZbEAA9uawkwnfhwxeZYot9M0e+Q7raPL9P9PQv4KZGQUjRyx2/GqVNgtha0acpPlW2uEyvM6wg6Alw/lUdzlBZP+Pblhvr5uvHTz2JYb583dylU3KNalSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772244718; c=relaxed/simple;
	bh=VF9Jn9EySnXPkxQvdxFQzDyu9mJYkwtJVDHkNsFCU/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8dGKue+2fkFeN6iPq9ThQ58m1Z8kTDl0Xc41ifKG+BjXiFcFwNnYv24SxqsyIQF/d2iDa9g5gfy7qIzVtKs135P3ZlHj+JwW6ZlyGrGpTRjggkOJu+EDo5wbRpirHnwNWS5PC3xsh4vBJ6TS2KDhE9mXYrg69zuSKDyNUiZEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id E76D420B6F16; Fri, 27 Feb 2026 18:11:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E76D420B6F16
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
Subject: [PATCH net-next 5/6] net: mana: Allocate interrupt context for each EQ when creating vPort
Date: Fri, 27 Feb 2026 18:11:43 -0800
Message-ID: <20260228021144.85054-6-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260228021144.85054-1-longli@microsoft.com>
References: <20260228021144.85054-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9056-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.155];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AC6E1BFEB1
X-Rspamd-Action: no action

Use GIC functions to create a dedicated interrupt context or acquire a
shared interrupt context for each EQ when setting up a vPort.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 17 ++++++++++++++++-
 include/net/mana/gdma.h                         |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index f3dbc4881be4..61dc06dc8602 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -808,7 +808,6 @@ static void mana_gd_deregister_irq(struct gdma_queue *queue)
 	}
 	spin_unlock_irqrestore(&gic->lock, flags);
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	synchronize_rcu();
 }
 
@@ -923,6 +922,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 out:
 	dev_err(dev, "Failed to create EQ: %d\n", err);
 	mana_gd_destroy_eq(gc, false, queue);
+	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1e65670feb17..c0bd520dd54d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1600,6 +1600,7 @@ void mana_destroy_eq(struct mana_port_context *apc)
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct gdma_queue *eq;
 	int i;
+	unsigned int msi;
 
 	if (!apc->eqs)
 		return;
@@ -1612,7 +1613,9 @@ void mana_destroy_eq(struct mana_port_context *apc)
 		if (!eq)
 			continue;
 
+		msi = eq->eq.msix_index;
 		mana_gd_destroy_queue(gc, eq);
+		mana_gd_put_gic(gc, !gc->msi_sharing, msi);
 	}
 
 	kfree(apc->eqs);
@@ -1629,6 +1632,7 @@ static void mana_create_eq_debugfs(struct mana_port_context *apc, int i)
 	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, apc->mana_eqs_debugfs);
 	debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head);
 	debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail);
+	debugfs_create_u32("irq", 0400, eq.mana_eq_debugfs, &eq.eq->eq.irq);
 	debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &mana_dbg_q_fops);
 }
 
@@ -1639,6 +1643,7 @@ int mana_create_eq(struct mana_port_context *apc)
 	struct gdma_queue_spec spec = {};
 	int err;
 	int i;
+	struct gdma_irq_context *gic;
 
 	WARN_ON(apc->eqs);
 	apc->eqs = kcalloc(apc->num_queues, sizeof(struct mana_eq),
@@ -1656,12 +1661,22 @@ int mana_create_eq(struct mana_port_context *apc)
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
index be6bdd169b3d..4eb94d1df439 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -336,6 +336,7 @@ struct gdma_queue {
 			void *context;
 
 			unsigned int msix_index;
+			unsigned int irq;
 
 			u32 log2_throttle_limit;
 		} eq;
-- 
2.43.0


