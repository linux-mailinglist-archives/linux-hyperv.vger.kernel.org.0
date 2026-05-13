Return-Path: <linux-hyperv+bounces-10876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FrGGrX3BGoMRAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10876-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:14:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C62A453B536
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B752B30DE87F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045A3CC30F;
	Wed, 13 May 2026 22:10:10 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872B3CAA2F;
	Wed, 13 May 2026 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710210; cv=none; b=onpkudX0gTJnxr2aEEgq9oZJ62Wr2CwqxjM2S+uV5/5fBsMz2oVzt73cFfIuyU0kwWs6wYkmELiEeloGwgcu6WzwfqWYzopLv0NhBMzZ/TpZ7ajNSmP9L57U7r4weyMA+VOuDMu4J6774EtNtBHYbNyWlBqLVX/emQiuVjtwKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710210; c=relaxed/simple;
	bh=jT+mVT1h1ke/zDmIEcTgyC8dfL5WY8sN4MFrSXiRr60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy9Yr4a3GTW4fbLtvl1F9umCUDpFYvyfpz6jcxKla0nQZ7tky/kc9Wmix71FjKGKLZt4RjcEGfXieutlafjZ7ZhykKjTZqQP8uGg0Vy7FtRuZoF0dqw0GmvTWAkrkjwMDRAcmoKse+u1cbxLUkNZ7dwwYmVtO2DXYjakkbigR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 226F120B7166; Wed, 13 May 2026 15:10:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 226F120B7166
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
Subject: [PATCH net-next v9 4/6] net: mana: Use GIC functions to allocate global EQs
Date: Wed, 13 May 2026 15:09:54 -0700
Message-ID: <20260513220956.402058-5-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260513220956.402058-1-longli@microsoft.com>
References: <20260513220956.402058-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C62A453B536
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
	TAGGED_FROM(0.00)[bounces-10876-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.788];
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
index fdd2ef24414b..e1a0e897b1b9 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1915,7 +1915,7 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
 	bool skip_first_cpu = false;
-	int *irqs, irq, err, i;
+	int *irqs, err, i;
 
 	irqs = kmalloc_objs(int, nvec);
 	if (!irqs)
@@ -1928,30 +1928,13 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
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
@@ -1973,20 +1956,9 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
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
@@ -1995,7 +1967,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	int *irqs, *start_irqs, irq;
+	int *irqs, *start_irqs;
 	unsigned int cpu;
 	int err, i;
 
@@ -2006,34 +1978,13 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
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
@@ -2062,20 +2013,9 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
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
@@ -2149,26 +2089,16 @@ static int mana_gd_setup_remaining_irqs(struct pci_dev *pdev)
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


