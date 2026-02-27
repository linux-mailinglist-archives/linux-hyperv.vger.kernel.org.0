Return-Path: <linux-hyperv+bounces-9023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKvDA4tSoWkfsAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9023-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:15:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4451B4564
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 09:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70833301BA74
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320137BE63;
	Fri, 27 Feb 2026 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OZbhvfz8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36636E46B;
	Fri, 27 Feb 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180104; cv=none; b=HeSRVrE/NLSdyC/EBIHnjx18kgD7ot1Rm/ClDApLN40z3sZjel4qmB2HSYNeseeJ91BZ2BLePWuF+TJs5WHwPPPqKGvKMtFg4DKabNP5gE+1LiWXZlIIzZy+1IuKm8AI2NHTXMJugjCMFdW/Im1+Iuc3WeSakPfnta+uymZDohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180104; c=relaxed/simple;
	bh=2bxa/GNfxH37kEAfxhUGoEJSQnU9bLrykRAZ963D8uE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g8+WttgpI5KeUSv87vHoqzUqPnkY/Dds9NmFBycADMwp9so+in7/dJQUksOrZ7nxr6QFBY04pD7GhFaDJTX8LdNS4L+IiPLZqqu/qlfxqIMupT44hq6wNoem/H3w7p+AUGQgvjG3xckG9MEPXL7MMirHEmQ01Ta6g9xIyhhipJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OZbhvfz8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id B674A20B6F02; Fri, 27 Feb 2026 00:15:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B674A20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772180102;
	bh=f6kjGf+6SmYvSYhEaVCQKRvHv84N5G5n7QGsPjGevtg=;
	h=Date:From:To:Subject:From;
	b=OZbhvfz8eKR/k8aHJ5l+0a4TqNxdPqvVTCFoXjvdUieY5CNYXRXuCFWQkudU0wonp
	 SZacUBk6H1nEq1FIzIAB7XSuqo19A3jj55rs9bLnPJceTPut1oMBjAb1Db4BwvcUHT
	 AiSOWOCn1Q1NKgGcu9SonU8Fr1HHFtsxeNNtLBK8=
Date: Fri, 27 Feb 2026 00:15:02 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
Subject: [PATCH net-next, v2] net: mana: Trigger VF reset/recovery on health
 check failure due to HWC timeout
Message-ID: <aaFShvKnwR5FY8dH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9023-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22]
X-Rspamd-Queue-Id: 7B4451B4564
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
Changes in v2:
  - Added common helper, proper clearing of gc flags.
---
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 65 ++++++++++---------
 drivers/net/ethernet/microsoft/mana/mana_en.c |  9 ++-
 include/net/mana/gdma.h                       | 16 ++++-
 3 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 37d2f108a839..aef8612b73cb 100644
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
@@ -558,12 +552,42 @@ static void mana_serv_func(struct work_struct *w)
 	module_put(THIS_MODULE);
 }
 
+int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type)
+{
+	struct mana_serv_work *mns_wk;
+
+	if (test_and_set_bit(GC_IN_SERVICE, &gc->flags)) {
+		dev_info(gc->dev, "Already in service\n");
+		return -EBUSY;
+	}
+
+	if (!try_module_get(THIS_MODULE)) {
+		dev_info(gc->dev, "Module is unloading\n");
+		clear_bit(GC_IN_SERVICE, &gc->flags);
+		return -ENODEV;
+	}
+
+	mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+	if (!mns_wk) {
+		module_put(THIS_MODULE);
+		clear_bit(GC_IN_SERVICE, &gc->flags);
+		return -ENOMEM;
+	}
+
+	dev_info(gc->dev, "Start MANA service type:%d\n", type);
+	mns_wk->pdev = to_pci_dev(gc->dev);
+	mns_wk->type = type;
+	pci_dev_get(mns_wk->pdev);
+	INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+	schedule_work(&mns_wk->serv_work);
+	return 0;
+}
+
 static void mana_gd_process_eqe(struct gdma_queue *eq)
 {
 	u32 head = eq->head % (eq->queue_size / GDMA_EQE_SIZE);
 	struct gdma_context *gc = eq->gdma_dev->gdma_context;
 	struct gdma_eqe *eq_eqe_ptr = eq->queue_mem_ptr;
-	struct mana_serv_work *mns_wk;
 	union gdma_eqe_info eqe_info;
 	enum gdma_eqe_type type;
 	struct gdma_event event;
@@ -623,30 +647,7 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 				 "Service is to be processed in probe\n");
 			break;
 		}
-
-		if (gc->in_service) {
-			dev_info(gc->dev, "Already in service\n");
-			break;
-		}
-
-		if (!try_module_get(THIS_MODULE)) {
-			dev_info(gc->dev, "Module is unloading\n");
-			break;
-		}
-
-		mns_wk = kzalloc_obj(*mns_wk, GFP_ATOMIC);
-		if (!mns_wk) {
-			module_put(THIS_MODULE);
-			break;
-		}
-
-		dev_info(gc->dev, "Start MANA service type:%d\n", type);
-		gc->in_service = true;
-		mns_wk->pdev = to_pci_dev(gc->dev);
-		mns_wk->type = type;
-		pci_dev_get(mns_wk->pdev);
-		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
-		schedule_work(&mns_wk->serv_work);
+		mana_schedule_serv_work(gc, type);
 		break;
 
 	default:
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 933e9d681ded..56ee993e3a43 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -875,7 +875,7 @@ static void mana_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 
 	/* Already in service, hence tx queue reset is not required.*/
-	if (gc->in_service)
+	if (test_bit(GC_IN_SERVICE, &gc->flags))
 		return;
 
 	/* Note: If there are pending queue reset work for this port(apc),
@@ -3525,6 +3525,7 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
 {
 	struct mana_context *ac =
 		container_of(to_delayed_work(work), struct mana_context, gf_stats_work);
+	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	int err;
 
 	err = mana_query_gf_stats(ac);
@@ -3532,6 +3533,12 @@ static void mana_gf_stats_work_handler(struct work_struct *work)
 		/* HWC timeout detected - reset stats and stop rescheduling */
 		ac->hwc_timeout_occurred = true;
 		memset(&ac->hc_stats, 0, sizeof(ac->hc_stats));
+		dev_warn(gc->dev,
+			 "Gf stats wk handler: gf stats query timed out.\n");
+		/* As HWC timed out, indicating a faulty HW state and needs a
+		 * reset.
+		 */
+		mana_schedule_serv_work(gc, GDMA_EQE_HWC_RESET_REQUEST);
 		return;
 	}
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 766f4fb25e26..ec17004b10c0 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -215,6 +215,12 @@ enum gdma_page_type {
 
 #define GDMA_INVALID_DMA_REGION 0
 
+struct mana_serv_work {
+	struct work_struct serv_work;
+	struct pci_dev *pdev;
+	enum gdma_eqe_type type;
+};
+
 struct gdma_mem_info {
 	struct device *dev;
 
@@ -386,6 +392,7 @@ struct gdma_irq_context {
 
 enum gdma_context_flags {
 	GC_PROBE_SUCCEEDED	= 0,
+	GC_IN_SERVICE		= 1,
 };
 
 struct gdma_context {
@@ -411,7 +418,6 @@ struct gdma_context {
 	u32			test_event_eq_id;
 
 	bool			is_pf;
-	bool			in_service;
 
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
@@ -473,6 +479,8 @@ int mana_gd_poll_cq(struct gdma_queue *cq, struct gdma_comp *comp, int num_cqe);
 
 void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit);
 
+int mana_schedule_serv_work(struct gdma_context *gc, enum gdma_eqe_type type);
+
 struct gdma_wqe {
 	u32 reserved	:24;
 	u32 last_vbytes	:8;
@@ -615,6 +623,9 @@ enum {
 /* Driver can handle hardware recovery events during probe */
 #define GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY BIT(22)
 
+/* Driver supports self recovery on Hardware Channel timeouts */
+#define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY BIT(25)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -628,7 +639,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_PERIODIC_STATS_QUERY | \
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.34.1


