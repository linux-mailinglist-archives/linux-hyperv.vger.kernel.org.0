Return-Path: <linux-hyperv+bounces-11171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAXEMRcLEWoVgwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11171-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:04:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B25BC726
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB8093011F62
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 02:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1C32EBB86;
	Sat, 23 May 2026 02:03:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5965727A47F;
	Sat, 23 May 2026 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501799; cv=none; b=Qwy5tHXg6oRR+zgwSYsA/JkrFTCRxgfFN+ew89PpEDfk20tMtyuRzEGKAGmiSShtkjKz0rW9Klfs7faIB9jBoXKmTLibfXlvUXI/RHczSDZPPQ6BzauoNa8TuACcg4SMpNHg6ES6EeQqnubqrwxaGTd9ArYw8C+D9xcVOU8ESyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501799; c=relaxed/simple;
	bh=UCElUD480IjCnvdnwEUw59+Jfe3MIUvK0ppnG/1p0M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsdDu3+lAc3EDwbufP7deQ5u6kA1p+PCkznWWBkF+wS8reeWnehFGgxRPy1H8dty8Q2P3AJzqs5eD+KRpzSw7sKJ61byRhQCssb/jhaeJ5jJf2YNF/3u0ucbuIm8KAnjXb8uVAGuauWt7dDpV1rWqDuu3B5MIdG66Usg7giuS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id D5E2F20B716C; Fri, 22 May 2026 19:03:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5E2F20B716C
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
Subject: [PATCH net-next v11 5/6] net: mana: Allocate interrupt context for each EQ when creating vPort
Date: Fri, 22 May 2026 19:02:55 -0700
Message-ID: <20260523020258.1107742-6-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260523020258.1107742-1-longli@microsoft.com>
References: <20260523020258.1107742-1-longli@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11171-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.534];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D68B25BC726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index fc21c7f57e23..10d394dd9653 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -912,7 +912,6 @@ static void mana_gd_deregister_irq(struct gdma_queue *queue)
 	}
 	spin_unlock_irqrestore(&gic->lock, flags);
 
-	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	synchronize_rcu();
 }
 
@@ -1027,6 +1026,7 @@ static int mana_gd_create_eq(struct gdma_dev *gd,
 out:
 	dev_err(dev, "Failed to create EQ: %d\n", err);
 	mana_gd_destroy_eq(gc, false, queue);
+	queue->eq.msix_index = INVALID_PCI_MSIX_INDEX;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 571648007378..bca381f8bc7b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1634,6 +1634,7 @@ void mana_destroy_eq(struct mana_port_context *apc)
 	struct mana_context *ac = apc->ac;
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct gdma_queue *eq;
+	unsigned int msi;
 	int i;
 
 	if (!apc->eqs)
@@ -1647,7 +1648,9 @@ void mana_destroy_eq(struct mana_port_context *apc)
 		if (!eq)
 			continue;
 
+		msi = eq->eq.msix_index;
 		mana_gd_destroy_queue(gc, eq);
+		mana_gd_put_gic(gc, !gc->msi_sharing, msi);
 	}
 
 	kfree(apc->eqs);
@@ -1664,6 +1667,7 @@ static void mana_create_eq_debugfs(struct mana_port_context *apc, int i)
 	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, apc->mana_eqs_debugfs);
 	debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head);
 	debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail);
+	debugfs_create_u32("irq", 0400, eq.mana_eq_debugfs, &eq.eq->eq.irq);
 	debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &mana_dbg_q_fops);
 }
 
@@ -1672,7 +1676,9 @@ int mana_create_eq(struct mana_port_context *apc)
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct gdma_context *gc = gd->gdma_context;
 	struct gdma_queue_spec spec = {};
+	struct gdma_irq_context *gic;
 	int err;
+	int msi;
 	int i;
 
 	if (WARN_ON(apc->eqs))
@@ -1692,12 +1698,22 @@ int mana_create_eq(struct mana_port_context *apc)
 		debugfs_create_dir("EQs", apc->mana_port_debugfs);
 
 	for (i = 0; i < apc->num_queues; i++) {
-		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+		msi = (i + 1) % gc->num_msix_usable;
+
+		gic = mana_gd_get_gic(gc, !gc->msi_sharing, &msi);
+		if (IS_ERR(gic)) {
+			err = PTR_ERR(gic);
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
index e3ee85c614ec..6a65fedae38f 100644
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


