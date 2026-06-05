Return-Path: <linux-hyperv+bounces-11498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JfKrBbYfImr3SgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11498-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 03:00:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E60644323
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 03:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11498-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11498-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6ECE305F590
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 00:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F325FA10;
	Fri,  5 Jun 2026 00:57:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A126E6E1;
	Fri,  5 Jun 2026 00:57:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621062; cv=none; b=itKIOmyIrrASL6f0gEIIlwUnTkwEMKIfQSWL5faKVR3Q7BwWmVXwynGW1AO3zT9xC6nKyYCNQdOsaOr6R0l8WFmiRY6v1/iKp8aoGazCMQWq0pLoQEJlBTo/iCK6rnnq7u5AqYWKk/0IRlFYAbFsGM6B6h2YY6sOqUIXGt12VUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621062; c=relaxed/simple;
	bh=kByVm3SHkCFxdzHWYGvIfbpsbnfoYiAcNAIVxH/SNow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT+8ge07BfbXfhOFt+GSurm2UUtX3mocTL/qhuO5jW5IQxKO0ODqT0nlEFsmJdAdDkLNowGEvpjDDVgOIbkv0y9Yovz6i6/XxBMWv9l+q7dmwXeup8jAJiTjZbN/MuFDmjFQYxB/AL6hSIrQFhoPz9HnbGbO8l5mBdwkISFNDnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 58BF120B716A; Thu,  4 Jun 2026 17:57:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58BF120B716A
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
Subject: [PATCH net-next v12 4/6] net: mana: Use GIC functions to allocate global EQs
Date: Thu,  4 Jun 2026 17:57:13 -0700
Message-ID: <20260605005717.2059954-5-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605005717.2059954-1-longli@microsoft.com>
References: <20260605005717.2059954-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11498-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72E60644323

Replace the GDMA global interrupt setup code with the new GIC allocation
and release functions for managing interrupt contexts.

This changes the per-queue interrupt names in /proc/interrupts from
mana_q0, mana_q1, ... to mana_msi1, mana_msi2, ... to reflect the
MSI-X index rather than a zero-based queue number. The HWC interrupt
name (mana_hwc) is unchanged.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 110 ++++--------------
 1 file changed, 22 insertions(+), 88 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index fd643300a427..653c091ad296 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1949,7 +1949,7 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
 	bool skip_first_cpu = false;
-	int *irqs, irq, err, i;
+	int *irqs, err, i, msi;
 
 	irqs = kmalloc_objs(int, nvec);
 	if (!irqs)
@@ -1962,30 +1962,14 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	 * further used in irq_setup()
 	 */
 	for (i = 1; i <= nvec; i++) {
-		gic = kzalloc_obj(*gic);
-		if (!gic) {
-			err = -ENOMEM;
+		msi = i;
+		gic = mana_gd_get_gic(gc, false, &msi);
+		if (IS_ERR(gic)) {
+			err = PTR_ERR(gic);
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
@@ -2007,20 +1991,9 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
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
@@ -2029,9 +2002,9 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	int *irqs, *start_irqs, irq;
+	int *irqs, *start_irqs;
 	unsigned int cpu;
-	int err, i;
+	int err, i, msi;
 
 	irqs = kmalloc_objs(int, nvec);
 	if (!irqs)
@@ -2040,34 +2013,14 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 	start_irqs = irqs;
 
 	for (i = 0; i < nvec; i++) {
-		gic = kzalloc_obj(*gic);
-		if (!gic) {
-			err = -ENOMEM;
+		msi = i;
+		gic = mana_gd_get_gic(gc, false, &msi);
+		if (IS_ERR(gic)) {
+			err = PTR_ERR(gic);
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
@@ -2096,20 +2049,9 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
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
@@ -2183,28 +2125,20 @@ static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
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
 
+	WARN_ON(!xa_empty(&gc->irq_contexts));
+
 	pci_free_irq_vectors(pdev);
 
 	bitmap_free(gc->msi_bitmap);
-- 
2.43.0


