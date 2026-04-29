Return-Path: <linux-hyperv+bounces-10499-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF64D6OD8mnLsAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10499-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:18:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5F49ADBC
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BB9303CE20
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 22:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB22639C65E;
	Wed, 29 Apr 2026 22:16:40 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23D42EEB9;
	Wed, 29 Apr 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500999; cv=none; b=dCpjrYlTKpSzApvIgei5yjtGkmRnDfS78fb6dQLdIP0uKDHvyQdQqNFUPdXzmXe3MJttrDXi2ksDx2EYbBOfYvd0KWSY8sWZwslS8/JgIlyjoaCeZfgN5uq2BFIC3s61Eh/SgAnADf61hrn5jUZxMs4zwiGBfC5NkFL2IY6t4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500999; c=relaxed/simple;
	bh=2/LaGN85OaFL0QSnOwbJt7bSCsZfUJPu/srA9NCWWdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMz/4SgU6122tYV+emThAQX0dO6Ct1lDoWsYKAAEmprAeqnzqorK06fBeRrnQeMoRaDWpwHU+unCgp7k3rOr6zmKJyvhwww2VfEi0xsFGgWAgrRFjLaJcrGypMNqcEJGL8OYczlzGMFLighQ0XGJUeUOtT6/n6URILNaiYHhios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 9581320B716C; Wed, 29 Apr 2026 15:16:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9581320B716C
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
Subject: [PATCH net-next v6 3/6] net: mana: Introduce GIC context with refcounting for interrupt management
Date: Wed, 29 Apr 2026 15:16:22 -0700
Message-ID: <20260429221625.1841150-4-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260429221625.1841150-1-longli@microsoft.com>
References: <20260429221625.1841150-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7CF5F49ADBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10499-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.682];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

To allow Ethernet EQs to use dedicated or shared MSI-X vectors and RDMA
EQs to share the same MSI-X, introduce a GIC (GDMA IRQ Context) with
reference counting. This allows the driver to create an interrupt context
on an assigned or unassigned MSI-X vector and share it across multiple
EQ consumers.

Signed-off-by: Long Li <longli@microsoft.com>
---
Changes in v4:
- Track dyn_msix in GIC context instead of re-checking
  pci_msix_can_alloc_dyn() on each call; improved remove_irqs
  iteration to skip unallocated entries

Changes in v2:
- Fixed spelling typo ("difference" -> "different")

 .../net/ethernet/microsoft/mana/gdma_main.c   | 159 ++++++++++++++++++
 include/net/mana/gdma.h                       |  11 ++
 2 files changed, 170 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index b96859e0aec9..3b6711355002 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1612,6 +1612,164 @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+void mana_gd_put_gic(struct gdma_context *gc, bool use_msi_bitmap, int msi)
+{
+	struct pci_dev *dev = to_pci_dev(gc->dev);
+	struct msi_map irq_map;
+	struct gdma_irq_context *gic;
+	int irq;
+
+	mutex_lock(&gc->gic_mutex);
+
+	gic = xa_load(&gc->irq_contexts, msi);
+	if (WARN_ON(!gic)) {
+		mutex_unlock(&gc->gic_mutex);
+		return;
+	}
+
+	if (use_msi_bitmap)
+		gic->bitmap_refs--;
+
+	if (use_msi_bitmap && gic->bitmap_refs == 0)
+		clear_bit(msi, gc->msi_bitmap);
+
+	if (!refcount_dec_and_test(&gic->refcount))
+		goto out;
+
+	irq = pci_irq_vector(dev, msi);
+
+	irq_update_affinity_hint(irq, NULL);
+	free_irq(irq, gic);
+
+	if (gic->dyn_msix) {
+		irq_map.virq = irq;
+		irq_map.index = msi;
+		pci_msix_free_irq(dev, irq_map);
+	}
+
+	xa_erase(&gc->irq_contexts, msi);
+	kfree(gic);
+
+out:
+	mutex_unlock(&gc->gic_mutex);
+}
+EXPORT_SYMBOL_NS(mana_gd_put_gic, "NET_MANA");
+
+/*
+ * Get a GIC (GDMA IRQ Context) on a MSI vector
+ * a MSI can be shared between different EQs, this function supports setting
+ * up separate MSIs using a bitmap, or directly using the MSI index
+ *
+ * @use_msi_bitmap:
+ * True if MSI is assigned by this function on available slots from bitmap.
+ * False if MSI is passed from *msi_requested
+ */
+struct gdma_irq_context *mana_gd_get_gic(struct gdma_context *gc,
+					 bool use_msi_bitmap,
+					 int *msi_requested)
+{
+	struct gdma_irq_context *gic;
+	struct pci_dev *dev = to_pci_dev(gc->dev);
+	struct msi_map irq_map = { };
+	int irq;
+	int msi;
+	int err;
+
+	mutex_lock(&gc->gic_mutex);
+
+	if (use_msi_bitmap) {
+		msi = find_first_zero_bit(gc->msi_bitmap, gc->num_msix_usable);
+		if (msi >= gc->num_msix_usable) {
+			dev_err(gc->dev, "No free MSI vectors available\n");
+			gic = NULL;
+			goto out;
+		}
+		*msi_requested = msi;
+	} else {
+		msi = *msi_requested;
+	}
+
+	gic = xa_load(&gc->irq_contexts, msi);
+	if (gic) {
+		refcount_inc(&gic->refcount);
+		if (use_msi_bitmap) {
+			gic->bitmap_refs++;
+			set_bit(msi, gc->msi_bitmap);
+		}
+		goto out;
+	}
+
+	irq = pci_irq_vector(dev, msi);
+	if (irq == -EINVAL) {
+		irq_map = pci_msix_alloc_irq_at(dev, msi, NULL);
+		if (!irq_map.virq) {
+			err = irq_map.index;
+			dev_err(gc->dev,
+				"Failed to alloc irq_map msi %d err %d\n",
+				msi, err);
+			gic = NULL;
+			goto out;
+		}
+		irq = irq_map.virq;
+		msi = irq_map.index;
+	}
+
+	gic = kzalloc(sizeof(*gic), GFP_KERNEL);
+	if (!gic) {
+		if (irq_map.virq)
+			pci_msix_free_irq(dev, irq_map);
+		goto out;
+	}
+
+	gic->handler = mana_gd_process_eq_events;
+	gic->msi = msi;
+	gic->irq = irq;
+	INIT_LIST_HEAD(&gic->eq_list);
+	spin_lock_init(&gic->lock);
+
+	if (!gic->msi)
+		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_hwc@pci:%s",
+			 pci_name(dev));
+	else
+		snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_msi%d@pci:%s",
+			 gic->msi, pci_name(dev));
+
+	err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
+	if (err) {
+		dev_err(gc->dev, "Failed to request irq %d %s\n",
+			irq, gic->name);
+		kfree(gic);
+		gic = NULL;
+		if (irq_map.virq)
+			pci_msix_free_irq(dev, irq_map);
+		goto out;
+	}
+
+	gic->dyn_msix = !!irq_map.virq;
+	refcount_set(&gic->refcount, 1);
+	gic->bitmap_refs = use_msi_bitmap ? 1 : 0;
+
+	err = xa_err(xa_store(&gc->irq_contexts, msi, gic, GFP_KERNEL));
+	if (err) {
+		dev_err(gc->dev, "Failed to store irq context for msi %d: %d\n",
+			msi, err);
+		free_irq(irq, gic);
+		kfree(gic);
+		gic = NULL;
+		if (irq_map.virq)
+			pci_msix_free_irq(dev, irq_map);
+		goto out;
+	}
+
+	if (use_msi_bitmap)
+		set_bit(msi, gc->msi_bitmap);
+
+out:
+	mutex_unlock(&gc->gic_mutex);
+	return gic;
+}
+EXPORT_SYMBOL_NS(mana_gd_get_gic, "NET_MANA");
+
 int mana_gd_alloc_res_map(u32 res_avail, struct gdma_resource *r)
 {
 	r->map = bitmap_zalloc(res_avail, GFP_KERNEL);
@@ -2101,6 +2259,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto release_region;
 
 	mutex_init(&gc->eq_test_event_mutex);
+	mutex_init(&gc->gic_mutex);
 	pci_set_drvdata(pdev, gc);
 	gc->bar0_pa = pci_resource_start(pdev, 0);
 	gc->bar0_size = pci_resource_len(pdev, 0);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 9c05b1e15c3e..690208a26121 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -388,6 +388,11 @@ struct gdma_irq_context {
 	spinlock_t lock;
 	struct list_head eq_list;
 	char name[MANA_IRQ_NAME_SZ];
+	unsigned int msi;
+	unsigned int irq;
+	refcount_t refcount;
+	unsigned int bitmap_refs;
+	bool dyn_msix;
 };
 
 enum gdma_context_flags {
@@ -449,6 +454,9 @@ struct gdma_context {
 
 	unsigned long		flags;
 
+	/* Protect access to GIC context */
+	struct mutex		gic_mutex;
+
 	/* Indicate if this device is sharing MSI for EQs on MANA */
 	bool msi_sharing;
 
@@ -1026,6 +1034,9 @@ int mana_gd_resume(struct pci_dev *pdev);
 
 bool mana_need_log(struct gdma_context *gc, int err);
 
+struct gdma_irq_context *mana_gd_get_gic(struct gdma_context *gc, bool use_msi_bitmap,
+					 int *msi_requested);
+void mana_gd_put_gic(struct gdma_context *gc, bool use_msi_bitmap, int msi);
 int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
 			     u32 proto_minor_ver, u32 proto_micro_ver,
 			     u16 *max_num_vports, u8 *bm_hostmode);
-- 
2.43.0


