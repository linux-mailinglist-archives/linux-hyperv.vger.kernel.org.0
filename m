Return-Path: <linux-hyperv+bounces-11170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFCyHEUMEWpJgwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11170-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:09:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACC25BC79E
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE03D304F2F2
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 02:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795B2DBF76;
	Sat, 23 May 2026 02:03:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982B27B34E;
	Sat, 23 May 2026 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501798; cv=none; b=lI8ECYbqaraCW41e7B5I64z2k+JiTFXAmUiq/jQYAI7anPD58PJ8+UkxIwJ2hjbQc9hgjO7iPlwf26W4Rw+CQ4wSS05IgrkocJsxPBSJGs2cbBz/GtdQ0qlqpJej6NqcL9C+d2NJ4pOXUvXQWrqmC5tzyZQM43tzzFMsRRGlW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501798; c=relaxed/simple;
	bh=esMVDhOhqDhb7e/enNKiUKf0CS5YFccA32hG11huw8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQU6sb3mUbTXK3SFa3W2H4wzg/LbkN3OI02D3vRGPIltAOWryLqwlQQzOx+j3qoxouydkAoZI0EX7DajYGiP+H83Ugs6SYEImbIMXnF3V939hGca0LCQUDpojTquBFa0MRDlpg9spJ2RFFpljJlSCyCNIWb3WflMgwUOWRaK4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id E2BD220B716D; Fri, 22 May 2026 19:03:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2BD220B716D
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
Subject: [PATCH net-next v11 6/6] RDMA/mana_ib: Allocate interrupt contexts on EQs
Date: Fri, 22 May 2026 19:02:56 -0700
Message-ID: <20260523020258.1107742-7-longli@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	TAGGED_FROM(0.00)[bounces-11170-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.514];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 6ACC25BC79E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the GIC functions to allocate interrupt contexts for RDMA EQs. These
interrupt contexts may be shared with Ethernet EQs when MSI-X vectors
are limited.

The driver now supports allocating dedicated MSI-X for each EQ. Indicate
this capability through driver capability bits. The RDMA EQs pass
use_msi_bitmap=false to share MSI-X vectors with Ethernet, while the
capability flag advertises that the driver supports per-vPort EQ
separation when hardware has sufficient vectors.

Populate eq.irq on all RDMA EQs for consistency with the Ethernet path.

Also relocate the GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE define to its
numeric BIT(6) position among the other capability flags.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 43 +++++++++++++++++++++++++------
 include/net/mana/gdma.h           |  7 +++--
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index f8a9013f0ca3..cefab12e2659 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -764,7 +764,8 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue_spec spec = {};
-	int err, i;
+	struct gdma_irq_context *gic;
+	int err, i, msi;
 
 	spec.type = GDMA_EQ;
 	spec.monitor_avl_buf = false;
@@ -772,11 +773,19 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.eq.callback = mana_ib_event_handler;
 	spec.eq.context = mdev;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
-	spec.eq.msix_index = 0;
+
+	msi = 0;
+	gic = mana_gd_get_gic(gc, false, &msi);
+	if (IS_ERR(gic))
+		return PTR_ERR(gic);
+	spec.eq.msix_index = msi;
 
 	err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->fatal_err_eq);
-	if (err)
+	if (err) {
+		mana_gd_put_gic(gc, false, 0);
 		return err;
+	}
+	mdev->fatal_err_eq->eq.irq = gic->irq;
 
 	mdev->eqs = kzalloc_objs(struct gdma_queue *,
 				 mdev->ib_dev.num_comp_vectors);
@@ -786,32 +795,50 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	}
 	spec.eq.callback = NULL;
 	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
-		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+		msi = (i + 1) % gc->num_msix_usable;
+
+		gic = mana_gd_get_gic(gc, false, &msi);
+		if (IS_ERR(gic)) {
+			err = PTR_ERR(gic);
+			goto destroy_eqs;
+		}
+		spec.eq.msix_index = msi;
+
 		err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->eqs[i]);
-		if (err)
+		if (err) {
+			mana_gd_put_gic(gc, false, msi);
 			goto destroy_eqs;
+		}
+		mdev->eqs[i]->eq.irq = gic->irq;
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
index 6a65fedae38f..78afd696b08b 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -616,6 +616,7 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB BIT(4)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
+#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
@@ -632,7 +633,8 @@ enum {
 /* Driver detects stalled send queues and recovers them */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
 
-#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
+/* Driver supports separate EQ/MSIs for each vPort */
+#define GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT BIT(19)
 
 /* Driver supports linearizing the skb when num_sge exceeds hardware limit */
 #define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
@@ -660,7 +662,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.43.0


