Return-Path: <linux-hyperv+bounces-9123-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOAAI6J2p2nyhgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9123-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:02:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEB51F89E2
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D86430B32E7
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821AC35C1B8;
	Wed,  4 Mar 2026 00:00:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7C2EDD6C;
	Wed,  4 Mar 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582431; cv=none; b=MTl9iAaVVFdGYqKCZR1MmlI64jIzrTbwmDP/QEPBhz7dQlyQZjWrbiK7+jR2nWDiNECkp9fMKUWpmsuRbc2z2BHIZ4FQLqedSF1MJYoP2j/fu8w+iLnTyA0pd9g1J5S2muFcPfIYXZTm1wSLZfAs6n4HtMYYGosaazQp1VxPcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582431; c=relaxed/simple;
	bh=MkPdrBaoLyQ3IknSFyhMo9TPKWvP7GARIYn9AhhfpO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYkNrje7j+pvVPbPaRouy4/I0W+TzYddJrpjZ6/kFW81fLZvzBcvi2hEZw6GinP04wLPLx1/CCMj7I3BYPoVNRiaSh6hHoT9WbjDjlrvrKA08N0c17AtYBMLg0XCa9gNwOwelPgWOt8YPViBcix5CLWPfjmc2l9FRf4pSOvcXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id D80F120B6F05; Tue,  3 Mar 2026 16:00:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D80F120B6F05
From: Long Li <longli@microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S . Miller" <davem@davemloft.net>,
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
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v2 net-next 5/6] net: mana: Allocate interrupt context for each EQ when creating vPort
Date: Tue,  3 Mar 2026 16:00:16 -0800
Message-ID: <20260304000017.333312-6-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260304000017.333312-1-longli@microsoft.com>
References: <20260304000017.333312-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0AEB51F89E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-9123-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.759];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[]
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
index bdc9dc437fb7..81c0be96c94b 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -809,7 +809,6 @@ static void mana_gd_deregister_irq(struct gdma_queue *queue)
 	}
 	spin_unlock_irqrestore(&gic->lock, flags);
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	synchronize_rcu();
 }
 
@@ -924,6 +923,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 out:
 	dev_err(dev, "Failed to create EQ: %d\n", err);
 	mana_gd_destroy_eq(gc, false, queue);
+	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index bfa0f354355d..8a60e7567951 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1598,6 +1598,7 @@ void mana_destroy_eq(struct mana_port_context *apc)
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct gdma_queue *eq;
 	int i;
+	unsigned int msi;
 
 	if (!apc->eqs)
 		return;
@@ -1610,7 +1611,9 @@ void mana_destroy_eq(struct mana_port_context *apc)
 		if (!eq)
 			continue;
 
+		msi = eq->eq.msix_index;
 		mana_gd_destroy_queue(gc, eq);
+		mana_gd_put_gic(gc, !gc->msi_sharing, msi);
 	}
 
 	kfree(apc->eqs);
@@ -1627,6 +1630,7 @@ static void mana_create_eq_debugfs(struct mana_port_context *apc, int i)
 	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, apc->mana_eqs_debugfs);
 	debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head);
 	debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail);
+	debugfs_create_u32("irq", 0400, eq.mana_eq_debugfs, &eq.eq->eq.irq);
 	debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &mana_dbg_q_fops);
 }
 
@@ -1637,6 +1641,7 @@ int mana_create_eq(struct mana_port_context *apc)
 	struct gdma_queue_spec spec = {};
 	int err;
 	int i;
+	struct gdma_irq_context *gic;
 
 	WARN_ON(apc->eqs);
 	apc->eqs = kzalloc_objs(struct mana_eq, apc->num_queues);
@@ -1653,12 +1658,22 @@ int mana_create_eq(struct mana_port_context *apc)
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
index 1a7f4abe7a8b..4e0278b00bbb 100644
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


