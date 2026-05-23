Return-Path: <linux-hyperv+bounces-11168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOzpH+sKEWoVgwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11168-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:03:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2455BC6F1
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FAF130074C1
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 02:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8B282F10;
	Sat, 23 May 2026 02:03:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01070232395;
	Sat, 23 May 2026 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501796; cv=none; b=a6PeXJtK+5VkceBVL1r1wJOQA+jUacZjCrOQmRXIoj2IPKveNXMVywJFrkamwUm8jYWNK9Gd3mCs5d93gfY85HSmCfIfGJwvRb3TQEzlxZNqW3v6CCNOsLKKXM63G4LPXa6K990UoM7S9JOiSBI1i3rXl/s/xoB4Qmdz4sEpa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501796; c=relaxed/simple;
	bh=lquAC8/33CsC3EyHLX8f770Xra+nw+wUwLsGwF1+UPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkvzX7ey3ydE9W/qXHegXILege30QUPo7JyRIiaWPUY2MUtAGFP1lJ6JlxM+zEluR6tb/qeTlf4FIHs+q8O8R6pxuMnMjC9m/NkzLI4wt1lBfq7jZyFXJJ60owqKpck2RD29sAxY4Mntz939WZiJ3dXbov5ZJQDAOkX+OoLIIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id BA39E20B716A; Fri, 22 May 2026 19:03:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA39E20B716A
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
Subject: [PATCH net-next v11 3/6] net: mana: Introduce GIC context with refcounting for interrupt management
Date: Fri, 22 May 2026 19:02:53 -0700
Message-ID: <20260523020258.1107742-4-longli@microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-11168-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.535];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B2455BC6F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To allow Ethernet EQs to use dedicated or shared MSI-X vectors and RDMA
EQs to share the same MSI-X, introduce a GIC (GDMA IRQ Context) with
reference counting. This allows the driver to create an interrupt context
on an assigned or unassigned MSI-X vector and share it across multiple
EQ consumers.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 169 ++++++++++++++++++
 include/net/mana/gdma.h                       |  12 ++
 2 files changed, 181 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e31eeca3563d..0541d914f27d 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -864,6 +864,10 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 	}
 
 	queue->eq.msix_index = msi_index;
+	/* The caller acquired a GIC reference via mana_gd_get_gic().
+	 * That refcount prevents mana_gd_put_gic() from erasing this
+	 * irq_contexts entry concurrently.
+	 */
 	gic = xa_load(&gc->irq_contexts, msi_index);
 	if (WARN_ON(!gic))
 		return -EINVAL;
@@ -891,6 +895,10 @@ static void mana_gd_deregister_irq(struct gdma_queue *queue)
 	if (WARN_ON(msix_index >= gc->num_msix_usable))
 		return;
 
+	/* The caller releases the GIC reference via mana_gd_put_gic()
+	 * after this function returns. The refcount guarantees this
+	 * irq_contexts entry is still valid.
+	 */
 	gic = xa_load(&gc->irq_contexts, msix_index);
 	if (WARN_ON(!gic))
 		return;
@@ -1672,6 +1680,166 @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+void mana_gd_put_gic(struct gdma_context *gc, bool use_msi_bitmap, int msi)
+{
+	struct pci_dev *dev = to_pci_dev(gc->dev);
+	struct gdma_irq_context *gic;
+	struct msi_map irq_map;
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
+	irq = gic->irq;
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
+	struct pci_dev *dev = to_pci_dev(gc->dev);
+	struct gdma_irq_context *gic;
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
+			gic = ERR_PTR(-ENOSPC);
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
+			gic = ERR_PTR(err);
+			goto out;
+		}
+		irq = irq_map.virq;
+		msi = irq_map.index;
+		*msi_requested = msi;
+	}
+
+	gic = kzalloc(sizeof(*gic), GFP_KERNEL);
+	if (!gic) {
+		gic = ERR_PTR(-ENOMEM);
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
+		gic = ERR_PTR(err);
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
+		gic = ERR_PTR(err);
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
@@ -2173,6 +2341,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto release_region;
 
 	mutex_init(&gc->eq_test_event_mutex);
+	mutex_init(&gc->gic_mutex);
 	pci_set_drvdata(pdev, gc);
 	gc->bar0_pa = pci_resource_start(pdev, 0);
 	gc->bar0_size = pci_resource_len(pdev, 0);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 145cc59dfc19..e3ee85c614ec 100644
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
@@ -450,6 +455,9 @@ struct gdma_context {
 
 	unsigned long		flags;
 
+	/* Protect access to GIC context */
+	struct mutex		gic_mutex;
+
 	/* Indicate if this device is sharing MSI for EQs on MANA */
 	bool msi_sharing;
 
@@ -1027,6 +1035,10 @@ int mana_gd_resume(struct pci_dev *pdev);
 
 bool mana_need_log(struct gdma_context *gc, int err);
 
+struct gdma_irq_context *mana_gd_get_gic(struct gdma_context *gc,
+					 bool use_msi_bitmap,
+					 int *msi_requested);
+void mana_gd_put_gic(struct gdma_context *gc, bool use_msi_bitmap, int msi);
 int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
 			     u32 proto_minor_ver, u32 proto_micro_ver,
 			     u16 *max_num_vports, u8 *bm_hostmode);
-- 
2.43.0


