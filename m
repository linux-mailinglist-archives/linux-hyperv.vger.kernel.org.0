Return-Path: <linux-hyperv+bounces-7605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB449C5FE52
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 03:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A315F4E3859
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 02:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47DD1F5846;
	Sat, 15 Nov 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BPdINZDh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE33C1F;
	Sat, 15 Nov 2025 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173736; cv=none; b=b452f2qDgPEFEtHmeo8teB0VLPjMBH4iQFmhXAoNneYg/AiUOTcaW+K2AezrEI8pV37tE6ugBWr381DwywnVfTEZ172PxsI5oSCAZS6+fIq3iTkhAioQZZSbHz/KWY3PNvkCmMhTVrWE0yTKwKi1mjeb+9GmdEJeF3KBDjP+q0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173736; c=relaxed/simple;
	bh=qKecsqXFs4vTGCYS80QsE0pZLtvsNW91EXp7ITNmhhg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tixweCH454P3XU1VtiY9PWB/QU01VQJ0N2vwAHMi29UI2t71h89yl8FD8jSLNGYfVI/fDmZ0mzr8XCb0XvszWFAuVSx2gfkuMg0r2sjstu18UHubx6AkI0NSVjAQOF6QFU00OcL0hM6CFqSuiCvmBKBWseVel2oBboXX1Kyhy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BPdINZDh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 7352E201AE66; Fri, 14 Nov 2025 18:28:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7352E201AE66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763173734;
	bh=pPZYI4wA1KsyJO4uPRkjUdepTh2HN4KGpnalTBaUpps=;
	h=From:To:Cc:Subject:Date:From;
	b=BPdINZDhjwnXJaPb+hEIZFFWNP1QDJSO+kw6I2ZBPmndxrYdhRj5g2TRyMURu8s+P
	 B174GfUvviTksgHqeT87NFIMa+QUxLLtXXwVK3USNy7mxKzYBr5VExYk6f/mt0Ss99
	 i70nm18wSwcDXOu2msXPPsgsW1YFsCCUnZNRuBHQ=
From: longli@linux.microsoft.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [patch net-next] net: mana: Handle hardware reset events when probing the device
Date: Fri, 14 Nov 2025 18:28:49 -0800
Message-Id: <1763173729-28430-1-git-send-email-longli@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

When MANA is being probed, it's possible that hardware is in recovery
mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
middle of the probe. Detect such condition and go through the recovery
service procedure.

Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 131 +++++++++++++++---
 include/net/mana/gdma.h                       |   9 +-
 2 files changed, 122 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index effe0a2f207a..1d9c2beb22b2 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -15,6 +15,12 @@
 
 struct dentry *mana_debugfs_root;
 
+static struct mana_serv_delayed_work {
+	struct delayed_work work;
+	struct pci_dev *pdev;
+	enum gdma_eqe_type type;
+} mns_delayed_wk;
+
 static u32 mana_gd_r32(struct gdma_context *g, u64 offset)
 {
 	return readl(g->bar0_va + offset);
@@ -387,6 +393,25 @@ EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
 #define MANA_SERVICE_PERIOD 10
 
+static void mana_serv_rescan(struct pci_dev *pdev)
+{
+	struct pci_bus *parent;
+
+	pci_lock_rescan_remove();
+
+	parent = pdev->bus;
+	if (!parent) {
+		dev_err(&pdev->dev, "MANA service: no parent bus\n");
+		goto out;
+	}
+
+	pci_stop_and_remove_bus_device(pdev);
+	pci_rescan_bus(parent);
+
+out:
+	pci_unlock_rescan_remove();
+}
+
 static void mana_serv_fpga(struct pci_dev *pdev)
 {
 	struct pci_bus *bus, *parent;
@@ -419,9 +444,12 @@ static void mana_serv_reset(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct hw_channel_context *hwc;
+	int ret;
 
 	if (!gc) {
-		dev_err(&pdev->dev, "MANA service: no GC\n");
+		/* Perform PCI rescan on device if GC is not set up */
+		dev_err(&pdev->dev, "MANA service: GC not setup, rescanning\n");
+		mana_serv_rescan(pdev);
 		return;
 	}
 
@@ -440,9 +468,18 @@ static void mana_serv_reset(struct pci_dev *pdev)
 
 	msleep(MANA_SERVICE_PERIOD * 1000);
 
-	mana_gd_resume(pdev);
+	ret = mana_gd_resume(pdev);
+	if (ret == -ETIMEDOUT || ret == -EPROTO) {
+		/* Perform PCI rescan on device if we failed on HWC */
+		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
+		mana_serv_rescan(pdev);
+		goto out;
+	}
 
-	dev_info(&pdev->dev, "MANA reset cycle completed\n");
+	if (ret)
+		dev_info(&pdev->dev, "MANA reset cycle failed err %d\n", ret);
+	else
+		dev_info(&pdev->dev, "MANA reset cycle completed\n");
 
 out:
 	gc->in_service = false;
@@ -454,18 +491,9 @@ struct mana_serv_work {
 	enum gdma_eqe_type type;
 };
 
-static void mana_serv_func(struct work_struct *w)
+static void mana_do_service(enum gdma_eqe_type type, struct pci_dev *pdev)
 {
-	struct mana_serv_work *mns_wk;
-	struct pci_dev *pdev;
-
-	mns_wk = container_of(w, struct mana_serv_work, serv_work);
-	pdev = mns_wk->pdev;
-
-	if (!pdev)
-		goto out;
-
-	switch (mns_wk->type) {
+	switch (type) {
 	case GDMA_EQE_HWC_FPGA_RECONFIG:
 		mana_serv_fpga(pdev);
 		break;
@@ -475,12 +503,36 @@ static void mana_serv_func(struct work_struct *w)
 		break;
 
 	default:
-		dev_err(&pdev->dev, "MANA service: unknown type %d\n",
-			mns_wk->type);
+		dev_err(&pdev->dev, "MANA service: unknown type %d\n", type);
 		break;
 	}
+}
+
+static void mana_serv_delayed_func(struct work_struct *w)
+{
+	struct mana_serv_delayed_work *dwork;
+	struct pci_dev *pdev;
+
+	dwork = container_of(w, struct mana_serv_delayed_work, work.work);
+	pdev = dwork->pdev;
+
+	if (pdev)
+		mana_do_service(dwork->type, pdev);
+
+	pci_dev_put(pdev);
+}
+
+static void mana_serv_func(struct work_struct *w)
+{
+	struct mana_serv_work *mns_wk;
+	struct pci_dev *pdev;
+
+	mns_wk = container_of(w, struct mana_serv_work, serv_work);
+	pdev = mns_wk->pdev;
+
+	if (pdev)
+		mana_do_service(mns_wk->type, pdev);
 
-out:
 	pci_dev_put(pdev);
 	kfree(mns_wk);
 	module_put(THIS_MODULE);
@@ -541,6 +593,17 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	case GDMA_EQE_HWC_RESET_REQUEST:
 		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
 
+		if (atomic_inc_return(&gc->in_probe) == 1) {
+			/*
+			 * Device is in probe and we received an hardware reset
+			 * event, probe() will detect that "in_probe" has
+			 * changed and perform service procedure.
+			 */
+			dev_info(gc->dev,
+				 "Service is to be processed in probe\n");
+			break;
+		}
+
 		if (gc->in_service) {
 			dev_info(gc->dev, "Already in service\n");
 			break;
@@ -1930,6 +1993,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
 							  mana_debugfs_root);
 
+	atomic_set(&gc->in_probe, 0);
+
 	err = mana_gd_setup(pdev);
 	if (err)
 		goto unmap_bar;
@@ -1942,8 +2007,19 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto cleanup_mana;
 
+	/*
+	 * If a hardware reset event has occurred over HWC during probe,
+	 * rollback and perform hardware reset procedure.
+	 */
+	if (atomic_inc_return(&gc->in_probe) > 1) {
+		err = -EPROTO;
+		goto cleanup_mana_rdma;
+	}
+
 	return 0;
 
+cleanup_mana_rdma:
+	mana_rdma_remove(&gc->mana_ib);
 cleanup_mana:
 	mana_remove(&gc->mana, false);
 cleanup_gd:
@@ -1967,6 +2043,25 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 disable_dev:
 	pci_disable_device(pdev);
 	dev_err(&pdev->dev, "gdma probe failed: err = %d\n", err);
+
+	/*
+	 * Hardware could be in recovery mode and the HWC returns TIMEDOUT or
+	 * EPROTO from mana_gd_setup(), mana_probe() or mana_rdma_probe(), or
+	 * we received a hardware reset event over HWC interrupt. In this case,
+	 * perform the device recovery procedure after MANA_SERVICE_PERIOD
+	 * seconds.
+	 */
+	if (err == -ETIMEDOUT || err == -EPROTO) {
+		dev_info(&pdev->dev, "Start MANA recovery mode\n");
+
+		mns_delayed_wk.pdev = pci_dev_get(pdev);
+		mns_delayed_wk.type = GDMA_EQE_HWC_RESET_REQUEST;
+
+		INIT_DELAYED_WORK(&mns_delayed_wk.work, mana_serv_delayed_func);
+		schedule_delayed_work(&mns_delayed_wk.work,
+				      secs_to_jiffies(MANA_SERVICE_PERIOD));
+	}
+
 	return err;
 }
 
@@ -2084,6 +2179,8 @@ static int __init mana_driver_init(void)
 
 static void __exit mana_driver_exit(void)
 {
+	cancel_delayed_work_sync(&mns_delayed_wk.work);
+
 	pci_unregister_driver(&mana_driver);
 
 	debugfs_remove(mana_debugfs_root);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 637f42485dba..1bb4c6ada2b6 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -430,6 +430,9 @@ struct gdma_context {
 	u64 pf_cap_flags1;
 
 	struct workqueue_struct *service_wq;
+
+	/* Count how many times we have finished probe or HWC events */
+	atomic_t		in_probe;
 };
 
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
@@ -592,6 +595,9 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
+/* Driver can handle hardware reset events during probe */
+#define GDMA_DRV_CAP_FLAG_1_RECOVER_PROBE BIT(22)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -601,7 +607,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
+	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
+	 GDMA_DRV_CAP_FLAG_1_RECOVER_PROBE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.43.0


