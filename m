Return-Path: <linux-hyperv+bounces-10899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJyUDCacBmoylQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10899-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:08:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C654917C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C224307A012
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 04:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4143CF051;
	Fri, 15 May 2026 04:05:22 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDC2EB10;
	Fri, 15 May 2026 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778817922; cv=none; b=CJwguc/ncqPwQ2ZvQoM69WoJl674NtTws9HRMBfLmCqnzQn/e5FVdO4KaNwq4ajAZTmjMOknhSCFkRqAsoaJusOI9iZ6XlvnDr+xIYSgSUb6O4s3PU2e/sX/f+tKPpo6jEa14plw/8l8iL0nbs+Atvt5VvvCslS/6HJmzfv8700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778817922; c=relaxed/simple;
	bh=y4xq+CC7S/OtB9Fe0He393yZzo1C+PMsiCju/ZieNSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6Ob1IJjpCGunguiJCd8QapKtbVWO+BbWcXpSYLMuWxRVYHHPUmYMzf7EmNK7Mh+H/jO+HO6UV66ctmBd4cPl1e6uQ1sK3bHqahpOG90CZo8ZxzW3i6xq6WonfQPiynk0k4NCuRyyOceakMEQLv3zAVgMPICY92b3K7HlwuP4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 21B6420B716A; Thu, 14 May 2026 21:05:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21B6420B716A
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
Subject: [PATCH net-next v10 4/6] net: mana: Use GIC functions to allocate global EQs
Date: Thu, 14 May 2026 21:05:06 -0700
Message-ID: <20260515040508.491748-5-longli@microsoft.com>
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
X-Rspamd-Queue-Id: CC5C654917C
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
	TAGGED_FROM(0.00)[bounces-10899-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.807];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pci:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Replace the GDMA global interrupt setup code with the new GIC allocation
and release functions for managing interrupt contexts.

This changes the per-queue interrupt names in /proc/interrupts from
mana_q0, mana_q1, ... to mana_msi1, mana_msi2, ... to reflect the
MSI-X index rather than a zero-based queue number. The HWC interrupt
name (mana_hwc) is unchanged.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 96 +++----------------
 1 file changed, 13 insertions(+), 83 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index ffe293b561ff..265cf32a980f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1918,7 +1918,7 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
 	bool skip_first_cpu = false;
-	int *irqs, irq, err, i;
+	int *irqs, err, i;
 
 	irqs = kmalloc_objs(int, nvec);
 	if (!irqs)
@@ -1931,30 +1931,13 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	 * further used in irq_setup()
 	 */
 	for (i = 1; i <= nvec; i++) {
-		gic = kzalloc_obj(*gic);
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
@@ -1976,20 +1959,9 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	kfree(irqs);
 	return 0;
 
-free_current_gic:
-	kfree(gic);
 free_irq:
-	for (i -= 1; i > 0; i--) {
-		irq = pci_irq_vector(pdev, i);
-		gic = xa_load(&gc->irq_contexts, i);
-		if (WARN_ON(!gic))
-			continue;
-
-		irq_update_affinity_hint(irq, NULL);
-		free_irq(irq, gic);
-		xa_erase(&gc->irq_contexts, i);
-		kfree(gic);
-	}
+	for (i -= 1; i > 0; i--)
+		mana_gd_put_gic(gc, false, i);
 	kfree(irqs);
 	return err;
 }
@@ -1998,7 +1970,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	int *irqs, *start_irqs, irq;
+	int *irqs, *start_irqs;
 	unsigned int cpu;
 	int err, i;
 
@@ -2009,34 +1981,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 	start_irqs = irqs;
 
 	for (i = 0; i < nvec; i++) {
-		gic = kzalloc_obj(*gic);
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
@@ -2065,20 +2016,9 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 	kfree(start_irqs);
 	return 0;
 
-free_current_gic:
-	kfree(gic);
 free_irq:
-	for (i -= 1; i >= 0; i--) {
-		irq = pci_irq_vector(pdev, i);
-		gic = xa_load(&gc->irq_contexts, i);
-		if (WARN_ON(!gic))
-			continue;
-
-		irq_update_affinity_hint(irq, NULL);
-		free_irq(irq, gic);
-		xa_erase(&gc->irq_contexts, i);
-		kfree(gic);
-	}
+	for (i -= 1; i >= 0; i--)
+		mana_gd_put_gic(gc, false, i);
 
 	kfree(start_irqs);
 	return err;
@@ -2152,26 +2092,16 @@ static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
 static void mana_gd_remove_irqs(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
-	struct gdma_irq_context *gic;
-	int irq, i;
+	int i;
 
 	if (gc->max_num_msix < 1)
 		return;
 
 	for (i = 0; i < gc->max_num_msix; i++) {
-		irq = pci_irq_vector(pdev, i);
-		if (irq < 0)
-			continue;
-
-		gic = xa_load(&gc->irq_contexts, i);
-		if (WARN_ON(!gic))
+		if (!xa_load(&gc->irq_contexts, i))
 			continue;
 
-		/* Need to clear the hint before free_irq */
-		irq_update_affinity_hint(irq, NULL);
-		free_irq(irq, gic);
-		xa_erase(&gc->irq_contexts, i);
-		kfree(gic);
+		mana_gd_put_gic(gc, false, i);
 	}
 
 	pci_free_irq_vectors(pdev);
-- 
2.43.0


