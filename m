Return-Path: <linux-hyperv+bounces-9057-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOEcAcVPomk/1wQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9057-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 03:15:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6D1BFEC6
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 03:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2B3C30F7035
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 02:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAA326944;
	Sat, 28 Feb 2026 02:11:59 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01431771E;
	Sat, 28 Feb 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772244719; cv=none; b=ESo/+Q+d3dVIWNumGzdEJu2l+cTJUe6Jh+y4KANSmbPbEq0+bf1Vx6BxBdqv1LUGIn5V9oGnzFFUYnSCwSMzFjhZOuU0OEO+2DB2NnR/GXm9sw+9qAevuT1C4nJ8Ltxe0wrwYDZ9vgnqoUDyf1/B5QB/Jj2X+ROjYxBbEHvfWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772244719; c=relaxed/simple;
	bh=Kv2Wpv6sNKUBlOMyDWFKKxyQsjyD8eSCM1sIZj9ddDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPl42HQPR5xmwZuS9nsrFjQf4fcluWuPMYGS9XKKAz0b5QgIK7ea+5vb3CxeOTcNAgoqm2PNBKIFq8lSc6Suu5x9iibsSG5aXoKCNufMz2BF5bqpG+iK4FXUL8HqxmMRu1ZVMY3MlIr5wiRWlqdm9DJx0Yj764Ghk/qBrHiQw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 7203E20B6F07; Fri, 27 Feb 2026 18:11:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7203E20B6F07
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
Subject: [PATCH net-next 6/6] RDMA/mana_ib: Allocate interrupt contexts on EQs
Date: Fri, 27 Feb 2026 18:11:44 -0800
Message-ID: <20260228021144.85054-7-longli@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9057-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.004];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BD6D1BFEC6
X-Rspamd-Action: no action

Use the GIC functions to allocate interrupt contexts for RDMA EQs. These
interrupt contexts may be shared with Ethernet EQs when MSI-X vectors
are limited.

The driver now supports allocating dedicated MSI-X for each EQ. Indicate
this capability through driver capability bits.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 33 ++++++++++++++++++++++++++-----
 include/net/mana/gdma.h           |  5 ++++-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index cfa954460585..029609fb91c5 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -787,6 +787,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue_spec spec = {};
+	struct gdma_irq_context *gic;
 	int err, i;
 
 	spec.type = GDMA_EQ;
@@ -797,9 +798,15 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 	spec.eq.msix_index = 0;
 
+	gic = mana_gd_get_gic(gc, false, &spec.eq.msix_index);
+	if (!gic)
+		return -ENOMEM;
+
 	err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->fatal_err_eq);
-	if (err)
+	if (err) {
+		mana_gd_put_gic(gc, false, 0);
 		return err;
+	}
 
 	mdev->eqs = kcalloc(mdev->ib_dev.num_comp_vectors, sizeof(struct gdma_queue *),
 			    GFP_KERNEL);
@@ -810,31 +817,47 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.eq.callback = NULL;
 	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
 		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+
+		gic = mana_gd_get_gic(gc, false, &spec.eq.msix_index);
+		if (!gic) {
+			err = -ENOMEM;
+			goto destroy_eqs;
+		}
+
 		err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->eqs[i]);
-		if (err)
+		if (err) {
+			mana_gd_put_gic(gc, false, spec.eq.msix_index);
 			goto destroy_eqs;
+		}
 	}
 
 	return 0;
 
 destroy_eqs:
-	while (i-- > 0)
+	while (i-- > 0) {
 		mana_gd_destroy_queue(gc, mdev->eqs[i]);
+		mana_gd_put_gic(gc, false, (i + 1) % gc->num_msix_usable);
+	}
 	kfree(mdev->eqs);
 destroy_fatal_eq:
 	mana_gd_destroy_queue(gc, mdev->fatal_err_eq);
+	mana_gd_put_gic(gc, false, 0);
 	return err;
 }
 
 void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
-	int i;
+	int i, msi;
 
 	mana_gd_destroy_queue(gc, mdev->fatal_err_eq);
+	mana_gd_put_gic(gc, false, 0);
 
-	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++)
+	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
 		mana_gd_destroy_queue(gc, mdev->eqs[i]);
+		msi = (i + 1) % gc->num_msix_usable;
+		mana_gd_put_gic(gc, false, msi);
+	}
 
 	kfree(mdev->eqs);
 }
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 4eb94d1df439..f0d5c873f856 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -610,6 +610,8 @@ enum {
 
 /* Driver supports dynamic MSI-X vector allocation */
 #define GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT BIT(13)
+/* Driver supports separate EQ/MSIs for each vPort */
+#define GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT BIT(19)
 
 /* Driver can self reset on EQE notification */
 #define GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE BIT(14)
@@ -644,7 +646,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY | \
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.43.0


