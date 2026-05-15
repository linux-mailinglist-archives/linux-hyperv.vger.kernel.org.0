Return-Path: <linux-hyperv+bounces-10901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLeiCiqcBmoHlQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10901-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:08:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5EA54918C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9F4A3038617
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 04:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAFC3D4129;
	Fri, 15 May 2026 04:05:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20D3C09F4;
	Fri, 15 May 2026 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778817923; cv=none; b=KvyeEFenSQnqh0X2Pftku0gIKljVy1Xi3IwDupoxFpZjUoJ0obkvE759h1v5/r6lOqhX6NQLVXtMTY/bbAY5FBKHdM2unXbMNrVO44mJljYUCKvcArd4taCSZGLucXECPAcPFOTPkiG1t/lNRl6P7N96eIQ6Gna6e+lCZOYdctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778817923; c=relaxed/simple;
	bh=ww3iDhHqj2sZVRmFfdi5sIDnONKXle9ygwVgSzDwxfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwuH3n+1+fn69STOD2EPrq7KTFSeudZ9cznrvnUbmVnbqyXjsW6Vwgm/X4ZZfvkUaKbzlYs5XWiJs1wqrTvkDspVflxI9YObK+WGebMCtKcTmHxSp77vAQm4Dy7rFP7mXFtud++GX8R0aQUl0fkFtVhAmX6+Ye/KfM45YahJ9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 2967820B716C; Thu, 14 May 2026 21:05:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2967820B716C
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
Subject: [PATCH net-next v10 6/6] RDMA/mana_ib: Allocate interrupt contexts on EQs
Date: Thu, 14 May 2026 21:05:08 -0700
Message-ID: <20260515040508.491748-7-longli@microsoft.com>
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
X-Rspamd-Queue-Id: CC5EA54918C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10901-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.844];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
index f8a9013f0ca3..df465a9078c1 100644
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
+	if (!gic)
+		return -ENOMEM;
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
+		if (!gic) {
+			err = -ENOMEM;
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
index 6c138cc77407..d84e474309a3 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -615,6 +615,7 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB BIT(4)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
+#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
@@ -631,7 +632,8 @@ enum {
 /* Driver detects stalled send queues and recovers them */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
 
-#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
+/* Driver supports separate EQ/MSIs for each vPort */
+#define GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT BIT(19)
 
 /* Driver supports linearizing the skb when num_sge exceeds hardware limit */
 #define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
@@ -659,7 +661,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.43.0


