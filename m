Return-Path: <linux-hyperv+bounces-8942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA/XMhUUnGkq/gMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8942-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 09:47:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976E17345C
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB94C301C6FE
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C034D38B;
	Mon, 23 Feb 2026 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lkbTWSB0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E134CFCC;
	Mon, 23 Feb 2026 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836432; cv=none; b=pd05RkOeWQ3XcrcHLyqRu6W086o4YjXVIu7Y7Btk1LUPTnurs8F5HKtRZjzPocFP/bkfCOdGIU/zaQkureMjPIHX8z1uKZTv825wHzkTulcRt5hjyEt9gY2CILidgYBPvivNA0MIVeluvi+PrBiUwOGmWGrUSpMh9+vbBA/8C64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836432; c=relaxed/simple;
	bh=+dHU1bptRcVz99RN7Jt1KnpbOiRfG8JJsVx1iaC+d18=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ClaTKvFGDbypL4Z4d1jPSwzaw1Qrictkm+zHwZskWlb7NFOaikHLxG4c04fakiebzoK6gWLEIMNyazwgXvAhsbez4/WOszBO1nQ5z9MvpOE4koirVG3VByJS0VbfY8rbmUpQC5KlXyC0rfkTPIzeuAHqG5dXxMIGzZ/GPrKRAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lkbTWSB0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id AA74D20B6F00; Mon, 23 Feb 2026 00:47:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA74D20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771836430;
	bh=+sMFljrbCbR3Gmuqz/2XuavaMj59idE6ZsCDEzg5qg4=;
	h=Date:From:To:Subject:From;
	b=lkbTWSB0Cxb1mjyEJoV6QWJGe8HeIzgv+uAMW1zP+Qd++KEEmCadG6PzQsIHGSkqE
	 Kl/vnJc1DSzB5ABO+EbdKG8l6stKCua3Tw34PW4z8xlGreD16exO9hEmFPOYSW9hB4
	 TnTgmkyWIe75NP0Z1revBXSzNXEMwbjI/P8wopZM=
Date: Mon, 23 Feb 2026 00:47:10 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: [PATCH, net-next] net: mana: Trigger VF reset/recovery on health
 check failure due to HWC timeout
Message-ID: <aZwUDlTkb5xunIkH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8942-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 4976E17345C
X-Rspamd-Action: no action

The GF stats periodic query is used as mechanism to monitor HWC health
check. If this HWC command times out, it is a strong indication that
the device/SoC is in a faulty state and requires recovery.

Today, when a timeout is detected, the driver marks
hwc_timeout_occurred, clears cached stats, and stops rescheduling the
periodic work. However, the device itself is left in the same failing
state.

Extend the timeout handling path to trigger the existing MANA VF
recovery service by queueing a GDMA_EQE_HWC_RESET_REQUEST work item.
This is expected to initiate the appropriate recovery flow by suspende
resume first and if it fails then trigger a bus rescan.

This change is intentionally limited to HWC command timeouts and does
not trigger recovery for errors reported by the SoC as a normal command
response.

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 14 +++-------
 drivers/net/ethernet/microsoft/mana/mana_en.c | 28 ++++++++++++++++++-
 include/net/mana/gdma.h                       | 16 +++++++++--
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 0055c231acf6..16c438d2aaa3 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -490,15 +490,9 @@ static void mana_serv_reset(struct pci_dev *pdev)
 		dev_info(&pdev->dev, "MANA reset cycle completed\n");
 
 out:
-	gc->in_service = false;
+	clear_bit(GC_IN_SERVICE, &gc->flags);
 }
 
-struct mana_serv_work {
-	struct work_struct serv_work;
-	struct pci_dev *pdev;
-	enum gdma_eqe_type type;
-};
-
 static void mana_do_service(enum gdma_eqe_type type, struct pci_dev *pdev)
 {
 	switch (type) {
@@ -542,7 +536,7 @@ static void mana_recovery_delayed_func(struct work_struct *w)
 	spin_unlock_irqrestore(&work->lock, flags);
 }
 
-static void mana_serv_func(struct work_struct *w)
+void mana_serv_func(struct work_struct *w)
 {
 	struct mana_serv_work *mns_wk;
 	struct pci_dev *pdev;
@@ -624,7 +618,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 			break;
 		}
 
-		if (gc->in_service) {
+		if (test_bit(GC_IN_SERVICE, &gc->flags)) {
 			dev_info(gc->dev, "Already in service\n");
 			break;
 		}
@@ -641,7 +635,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		}
 
 		dev_info(gc->dev, "Start MANA service type:%d\n", type);
-		gc->in_service = true;
+		set_bit(GC_IN_SERVICE, &gc->flags);
 		mns_wk->pdev = to_pci_dev(gc->dev);
 		mns_wk->type = type;
 		pci_dev_get(mns_wk->pdev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 91c418097284..8da574cf06f2 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -879,7 +879,7 @@ static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 
 	/* Already in service, hence tx queue reset is not required.*/
-	if (gc->in_service)
+	if (test_bit(GC_IN_SERVICE, &gc->flags))
 		return;
 
 	/* Note: If there are pending queue reset work for this port(apc),
@@ -3533,6 +3533,8 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
 {
 	struct mana_context *ac =
 		container_of(to_delayed_work(work), struct mana_context, gf_stats_work);
+	struct gdma_context *gc = ac->gdma_dev->gdma_context;
+	struct mana_serv_work *mns_wk;
 	int err;
 
 	err = mana_query_gf_stats(ac);
@@ -3540,6 +3542,30 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
 		/* HWC timeout detected - reset stats and stop rescheduling */
 		ac->hwc_timeout_occurred = true;
 		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
+		dev_warn(gc->dev,
+			 "Gf stats wk handler: gf stats query timed out.\n");
+
+		/* As HWC timed out, indicating a faulty HW state and needs a
+		 * reset.
+		 */
+		if (!test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
+			if (!try_module_get(THIS_MODULE)) {
+				dev_info(gc->dev, "Module is unloading\n");
+				return;
+			}
+
+			mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+			if (!mns_wk) {
+				module_put(THIS_MODULE);
+				return;
+			}
+
+			mns_wk->pdev = to_pci_dev(gc->dev);
+			mns_wk->type = GDMA_EQE_HWC_RESET_REQUEST;
+			pci_dev_get(mns_wk->pdev);
+			INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+			schedule_work(&mns_wk->serv_work);
+		}
 		return;
 	}
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index a59bd4035a99..fb946389d593 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -213,6 +213,12 @@ enum gdma_page_type {
 
 #define GDMA_INVALID_DMA_REGION 0
 
+struct mana_serv_work {
+	struct work_struct serv_work;
+	struct pci_dev *pdev;
+	enum gdma_eqe_type type;
+};
+
 struct gdma_mem_info {
 	struct device *dev;
 
@@ -384,6 +390,7 @@ struct gdma_irq_context {
 
 enum gdma_context_flags {
 	GC_PROBE_SUCCEEDED	= 0,
+	GC_IN_SERVICE		= 1,
 };
 
 struct gdma_context {
@@ -409,7 +416,6 @@ struct gdma_context {
 	u32			test_event_eq_id;
 
 	bool			is_pf;
-	bool			in_service;
 
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
@@ -471,6 +477,8 @@ int mana_gd_poll_cq(struct gdma_queue *cq, struct gdma_comp *comp, int num_cqe);
 
 void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit);
 
+void mana_serv_func(struct work_struct *w);
+
 struct gdma_wqe {
 	u32 reserved	:24;
 	u32 last_vbytes	:8;
@@ -613,6 +621,9 @@ enum {
 /* Driver can handle hardware recovery events during probe */
 #define GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY BIT(22)
 
+/* Driver supports self recovery on Hardware Channel timeouts */
+#define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY BIT(25)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -626,7 +637,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY | \
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.43.0


