Return-Path: <linux-hyperv+bounces-7660-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A517BC66E35
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 02:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29A1F350384
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 01:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686BD309F1B;
	Tue, 18 Nov 2025 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aC7nRbQe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882E770FE;
	Tue, 18 Nov 2025 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430734; cv=none; b=okHi+xoeRvIJ9fqVEZenvtk0v6I2dtU51CWlq/503OF4hOrWNjBfC3NDpidwreqjzOFBvxxloZTvEfEAOW8p7s7kLRfe0+xW6KBh5gJgP6k5KJQzBN2jrTS49IK5AHWK4jTq+VzGns6e2k96rHCjnw3KVsrnWDekvp4Ag+AzR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430734; c=relaxed/simple;
	bh=rv8beW9UxDJtU0acu1M4bult0kX9RJfigpn0/Gb5+Aw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dkYzE3YVYl3oXEK2prEzM3YwYY/dlPvkSwPgJKT3lI/+Xp3qz7bmIoZmBb44ggX4QTgN0uH+3vUdRCAcgbUGJ7GuOLdGYm+/3hCp5y2c96frVpuDus+OLmYruUEC4dblN5FSIfzh2ZcJoj+K26Ipob7cRXfsZuKS3/ZLL1JtIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aC7nRbQe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 12981211CFAF; Mon, 17 Nov 2025 17:52:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12981211CFAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763430732;
	bh=VU5PuTPbzOxJsnCIylZBNdJHiBHIXTNC7e4rCuI09L8=;
	h=From:To:Cc:Subject:Date:From;
	b=aC7nRbQekG3Z2uW1g1H6SVjnx3P3XZ4eJ8h0jAhOh11i9Q6IDDcIdeNFY5XODmdPI
	 JZUW/vAxDF4/l/npnkMkluuCMIVnXcGSpM5a4RT3cFgYrMR0senRXnpylyWA+yrsPJ
	 hEXtU6AYQtsFuuZCM+/2NpvLMAgcs5VPJmSDvn1s=
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
Subject: [Patch net-next v2] net: mana: Handle hardware recovery events when probing the device
Date: Mon, 17 Nov 2025 17:52:04 -0800
Message-Id: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
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
Changes
v2: Use a list for handling multiple devices.
    Use disable_delayed_work_sync() on driver exit.
    Replace atomic_t with flags to detect if interrupt happens before probe finishes

 .../net/ethernet/microsoft/mana/gdma_main.c   | 172 ++++++++++++++++--
 include/net/mana/gdma.h                       |  12 +-
 2 files changed, 166 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index effe0a2f207a..57d58adf623a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -15,6 +15,20 @@
 
 struct dentry *mana_debugfs_root;
 
+struct mana_dev_recovery {
+	struct list_head list;
+	struct pci_dev *pdev;
+	enum gdma_eqe_type type;
+};
+
+static struct mana_dev_recovery_work {
+	struct list_head dev_list;
+	struct delayed_work work;
+
+	/* Lock for dev_list above */
+	spinlock_t lock;
+} mana_dev_recovery_work;
+
 static u32 mana_gd_r32(struct gdma_context *g, u64 offset)
 {
 	return readl(g->bar0_va + offset);
@@ -387,6 +401,25 @@ EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
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
@@ -419,9 +452,12 @@ static void mana_serv_reset(struct pci_dev *pdev)
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
 
@@ -440,9 +476,18 @@ static void mana_serv_reset(struct pci_dev *pdev)
 
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
@@ -454,18 +499,9 @@ struct mana_serv_work {
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
@@ -475,12 +511,46 @@ static void mana_serv_func(struct work_struct *w)
 		break;
 
 	default:
-		dev_err(&pdev->dev, "MANA service: unknown type %d\n",
-			mns_wk->type);
+		dev_err(&pdev->dev, "MANA service: unknown type %d\n", type);
 		break;
 	}
+}
+
+static void mana_recovery_delayed_func(struct work_struct *w)
+{
+	struct mana_dev_recovery_work *work;
+	struct mana_dev_recovery *dev, *tmp;
+	unsigned long flags;
+
+	work = container_of(w, struct mana_dev_recovery_work, work.work);
+
+	spin_lock_irqsave(&work->lock, flags);
+
+	list_for_each_entry_safe(dev, tmp, &work->dev_list, list) {
+		list_del(&dev->list);
+		spin_unlock_irqrestore(&work->lock, flags);
+
+		mana_do_service(dev->type, dev->pdev);
+		pci_dev_put(dev->pdev);
+		kfree(dev);
+
+		spin_lock_irqsave(&work->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&work->lock, flags);
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
@@ -541,6 +611,17 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 	case GDMA_EQE_HWC_RESET_REQUEST:
 		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
 
+		if (!test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
+			/*
+			 * Device is in probe and we received a hardware reset
+			 * event, the probe function will detect that the flag
+			 * has changed and perform service procedure.
+			 */
+			dev_info(gc->dev,
+				 "Service is to be processed in probe\n");
+			break;
+		}
+
 		if (gc->in_service) {
 			dev_info(gc->dev, "Already in service\n");
 			break;
@@ -1942,8 +2023,19 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto cleanup_mana;
 
+	/*
+	 * If a hardware reset event has occurred over HWC during probe,
+	 * rollback and perform hardware reset procedure.
+	 */
+	if (test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
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
@@ -1967,6 +2059,35 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
+		struct mana_dev_recovery *dev;
+		unsigned long flags;
+
+		dev_info(&pdev->dev, "Start MANA recovery mode\n");
+
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev)
+			return err;
+
+		dev->pdev = pci_dev_get(pdev);
+		dev->type = GDMA_EQE_HWC_RESET_REQUEST;
+
+		spin_lock_irqsave(&mana_dev_recovery_work.lock, flags);
+		list_add_tail(&dev->list, &mana_dev_recovery_work.dev_list);
+		spin_unlock_irqrestore(&mana_dev_recovery_work.lock, flags);
+
+		schedule_delayed_work(&mana_dev_recovery_work.work,
+				      secs_to_jiffies(MANA_SERVICE_PERIOD));
+	}
+
 	return err;
 }
 
@@ -2071,6 +2192,10 @@ static int __init mana_driver_init(void)
 {
 	int err;
 
+	INIT_LIST_HEAD(&mana_dev_recovery_work.dev_list);
+	spin_lock_init(&mana_dev_recovery_work.lock);
+	INIT_DELAYED_WORK(&mana_dev_recovery_work.work, mana_recovery_delayed_func);
+
 	mana_debugfs_root = debugfs_create_dir("mana", NULL);
 
 	err = pci_register_driver(&mana_driver);
@@ -2084,6 +2209,19 @@ static int __init mana_driver_init(void)
 
 static void __exit mana_driver_exit(void)
 {
+	struct mana_dev_recovery *dev, *tmp;
+	unsigned long flags;
+
+	disable_delayed_work_sync(&mana_dev_recovery_work.work);
+
+	spin_lock_irqsave(&mana_dev_recovery_work.lock, flags);
+	list_for_each_entry_safe(dev, tmp, &mana_dev_recovery_work.dev_list, list) {
+		list_del(&dev->list);
+		pci_dev_put(dev->pdev);
+		kfree(dev);
+	}
+	spin_unlock_irqrestore(&mana_dev_recovery_work.lock, flags);
+
 	pci_unregister_driver(&mana_driver);
 
 	debugfs_remove(mana_debugfs_root);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 637f42485dba..bf3b32540786 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -382,6 +382,10 @@ struct gdma_irq_context {
 	char name[MANA_IRQ_NAME_SZ];
 };
 
+enum gdma_context_flags {
+	GC_PROBE_SUCCEEDED	= 0,
+};
+
 struct gdma_context {
 	struct device		*dev;
 	struct dentry		*mana_pci_debugfs;
@@ -430,6 +434,8 @@ struct gdma_context {
 	u64 pf_cap_flags1;
 
 	struct workqueue_struct *service_wq;
+
+	unsigned long		flags;
 };
 
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
@@ -592,6 +598,9 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
 #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
+/* Driver can handle hardware recovery events during probe */
+#define GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY BIT(22)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
@@ -601,7 +610,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
 	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
-	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
+	 GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
+	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.43.0


