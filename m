Return-Path: <linux-hyperv+bounces-9173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AuiIWxIq2lcbwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9173-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:34:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEA22801C
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DE5A303EE9D
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814F1481FCB;
	Fri,  6 Mar 2026 21:33:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE123B5319;
	Fri,  6 Mar 2026 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832806; cv=none; b=lSVoJ79hzptV9Ykih/PQuMZoQRRnRl8tfRAKbjD7BUBLFWGEvF60nHnosfX+3g+66LDBFGKjLe8jLqWqTthsQTHtUU7AQihXFjoklPdSpFWCtiRGAABxT0AlkaDb6oQiVXm1nBi1KsdysQWOk+OjsbcRU5JrDXNioaqpM/8dyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832806; c=relaxed/simple;
	bh=xjr2JwSAqE7BLo3gkyxZMdDjnmJYhcLUIo2mfcdqatE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM6YHljpMshCcznpr/FQEilcJA9HU/7+oOsywgZmIZA5GNxmsKTiLkixLiLcyANH5cV7+lFfw2RBg6DLjZIbqFEs/D8gutTC9PYVyIhWmVDfLykqdAQVhrMgP47A5C9tTM18Kxtt4YEIbfD6ucu3ytl8wziABrFFkumflROxCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id B1C1A20B6F03; Fri,  6 Mar 2026 13:33:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1C1A20B6F03
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
Subject: [PATCH net-next v3 3/6] net: mana: Introduce GIC context with refcounting for interrupt management
Date: Fri,  6 Mar 2026 13:32:59 -0800
Message-ID: <20260306213302.544681-4-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260306213302.544681-1-longli@microsoft.com>
References: <20260306213302.544681-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2FEA22801C
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
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-9173-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.357];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

To allow Ethernet EQs to use dedicated or shared MSI-X vectors and RDMA
EQs to share the same MSI-X, introduce a GIC (GDMA IRQ Context) with
reference counting. This allows the driver to create an interrupt context
on an assigned or unassigned MSI-X vector and share it across multiple
EQ consumers.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 158 ++++++++++++++++++
 include/net/mana/gdma.h                       |  10 ++
 2 files changed, 168 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index a6ab2f053fe9..c43fd8089e77 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1559,6 +1559,163 @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
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
+	if (pci_msix_can_alloc_dyn(dev)) {
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
@@ -2044,6 +2201,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto release_region;
 
 	mutex_init(&gc->eq_test_event_mutex);
+	mutex_init(&gc->gic_mutex);
 	pci_set_drvdata(pdev, gc);
 	gc->bar0_pa = pci_resource_start(pdev, 0);
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index b744253b44e8..1a7f4abe7a8b 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -388,6 +388,10 @@ struct gdma_irq_context {
 	spinlock_t lock;
 	struct list_head eq_list;
 	char name[MANA_IRQ_NAME_SZ];
+	unsigned int msi;
+	unsigned int irq;
+	refcount_t refcount;
+	unsigned int bitmap_refs;
 };
 
 enum gdma_context_flags {
@@ -447,6 +451,9 @@ struct gdma_context {
 
 	unsigned long		flags;
 
+	/* Protect access to GIC context */
+	struct mutex		gic_mutex;
+
 	/* Indicate if this device is sharing MSI for EQs on MANA */
 	bool msi_sharing;
 
@@ -1019,6 +1026,9 @@ int mana_gd_resume(struct pci_dev *pdev);
 
 bool mana_need_log(struct gdma_context *gc, int err);
 
+struct gdma_irq_context *mana_gd_get_gic(struct gdma_context *gc, bool use_msi_bitmap,
+					 int *msi_requested);
+void mana_gd_put_gic(struct gdma_context *gc, bool use_msi_bitmap, int msi);
 int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
 			     u32 proto_minor_ver, u32 proto_micro_ver,
 			     u16 *max_num_vports, u8 *bm_hostmode);
-- 
2.43.0


