Return-Path: <linux-hyperv+bounces-9055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJFhKWlPomk/1wQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9055-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 03:14:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577DA1BFE9B
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 03:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 676C930D21D4
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352831A7F1;
	Sat, 28 Feb 2026 02:11:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952930B533;
	Sat, 28 Feb 2026 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772244717; cv=none; b=PlG/4UzS7U4bgFlvtnVWAZGXkzG/bSFJu/24UOpCwiBADY34HRMCVSHUBSaoBVV621YYU3ZpKFIQPUIDGWMurJMR9s2qAXyLxZblOhLFuOiErFBbOh28fhqEcT8+P3H/XS7MqI0BOxKW/+uF95xqkDY0N9pllw4aveMxq/Ngcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772244717; c=relaxed/simple;
	bh=sWtZ6BLEkojrfkC1hNIbeHIWSFDgFdLcrwi5ZjxP31k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eryfcnVPy2O0nzs5B5sK9a007VepZNGQAKF8DSoFqYisgAqz9i1ljvSm2Xczco2559B+E5Y2dyZCM/WVGVnEmSLPENU2mR+BwRUfOVPOIt57R0U83mc2saEU9AZ7dGm2w5gokCknM+pSJCoKw9rQL5Cu9ec7gCEOzPkMEUnnxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 5A9D820B6F04; Fri, 27 Feb 2026 18:11:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A9D820B6F04
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
Subject: [PATCH net-next 4/6] net: mana: Use GIC functions to allocate global EQs
Date: Fri, 27 Feb 2026 18:11:42 -0800
Message-ID: <20260228021144.85054-5-longli@microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-9055-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.100];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 577DA1BFE9B
X-Rspamd-Action: no action

Replace the GDMA global interrupt setup code with the new GIC allocation
and release functions for managing interrupt contexts.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 83 +++----------------
 1 file changed, 10 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e9b839259c01..f3dbc4881be4 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1830,30 +1830,13 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	 * further used in irq_setup()
 	 */
 	for (i = 1; i <= nvec; i++) {
-		gic = kzalloc(sizeof(*gic), GFP_KERNEL);
+		gic = mana_gd_get_gic(gc, false, &i);
 		if (!gic) {
 			err = -ENOMEM;
 			goto free_irq;
 		}
-		gic->handler = mana_gd_process_eq_events;
-		INIT_LIST_HEAD(&gic->eq_list);
-		spin_lock_init(&gic->lock);
-
-		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
-			 i - 1, pci_name(pdev));
-
-		/* one pci vector is already allocated for HWC */
-		irqs[i - 1] = pci_irq_vector(pdev, i);
-		if (irqs[i - 1] < 0) {
-			err = irqs[i - 1];
-			goto free_current_gic;
-		}
-
-		err = request_irq(irqs[i - 1], mana_gd_intr, 0, gic->name, gic);
-		if (err)
-			goto free_current_gic;
 
-		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
+		irqs[i - 1] = gic->irq;
 	}
 
 	/*
@@ -1875,19 +1858,11 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	kfree(irqs);
 	return 0;
 
-free_current_gic:
-	kfree(gic);
 free_irq:
 	for (i -= 1; i > 0; i--) {
 		irq = pci_irq_vector(pdev, i);
-		gic = xa_load(&gc->irq_contexts, i);
-		if (WARN_ON(!gic))
-			continue;
-
 		irq_update_affinity_hint(irq, NULL);
-		free_irq(irq, gic);
-		xa_erase(&gc->irq_contexts, i);
-		kfree(gic);
+		mana_gd_put_gic(gc, false, i);
 	}
 	kfree(irqs);
 	return err;
@@ -1908,34 +1883,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 	start_irqs = irqs;
 
 	for (i = 0; i < nvec; i++) {
-		gic = kzalloc(sizeof(*gic), GFP_KERNEL);
+		gic = mana_gd_get_gic(gc, false, &i);
 		if (!gic) {
 			err = -ENOMEM;
 			goto free_irq;
 		}
 
-		gic->handler = mana_gd_process_eq_events;
-		INIT_LIST_HEAD(&gic->eq_list);
-		spin_lock_init(&gic->lock);
-
-		if (!i)
-			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
-				 pci_name(pdev));
-		else
-			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
-				 i - 1, pci_name(pdev));
-
-		irqs[i] = pci_irq_vector(pdev, i);
-		if (irqs[i] < 0) {
-			err = irqs[i];
-			goto free_current_gic;
-		}
-
-		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
-		if (err)
-			goto free_current_gic;
-
-		xa_store(&gc->irq_contexts, i, gic, GFP_KERNEL);
+		irqs[i] = gic->irq;
 	}
 
 	/* If number of IRQ is one extra than number of online CPUs,
@@ -1964,19 +1918,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 	kfree(start_irqs);
 	return 0;
 
-free_current_gic:
-	kfree(gic);
 free_irq:
 	for (i -= 1; i >= 0; i--) {
 		irq = pci_irq_vector(pdev, i);
-		gic = xa_load(&gc->irq_contexts, i);
-		if (WARN_ON(!gic))
-			continue;
-
 		irq_update_affinity_hint(irq, NULL);
-		free_irq(irq, gic);
-		xa_erase(&gc->irq_contexts, i);
-		kfree(gic);
+		mana_gd_put_gic(gc, false, i);
 	}
 
 	kfree(start_irqs);
@@ -2051,26 +1997,17 @@ static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
 static void mana_gd_remove_irqs(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
-	struct gdma_irq_context *gic;
 	int irq, i;
 
 	if (gc->max_num_msix < 1)
 		return;
 
-	for (i = 0; i < gc->max_num_msix; i++) {
-		irq = pci_irq_vector(pdev, i);
-		if (irq < 0)
-			continue;
-
-		gic = xa_load(&gc->irq_contexts, i);
-		if (WARN_ON(!gic))
-			continue;
-
+	for (i = 0; i < (gc->msi_sharing ? gc->max_num_msix : 1); i++) {
 		/* Need to clear the hint before free_irq */
+		irq = pci_irq_vector(pdev, i);
 		irq_update_affinity_hint(irq, NULL);
-		free_irq(irq, gic);
-		xa_erase(&gc->irq_contexts, i);
-		kfree(gic);
+
+		mana_gd_put_gic(gc, false, i);
 	}
 
 	pci_free_irq_vectors(pdev);
-- 
2.43.0


