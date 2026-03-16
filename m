Return-Path: <linux-hyperv+bounces-9423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKd3Iqnot2mzWwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9423-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 12:25:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CC298A1B
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5744C300A26C
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB6338586;
	Mon, 16 Mar 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AjT4mVDI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6A28B4FD;
	Mon, 16 Mar 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660323; cv=none; b=N5B70n99HzsvZoWVi/4CSQUXdetpuSgOwo8eaGOm8DCaxQA3L7sDYKmXsSO8IjTnsdgISoZjX85l8TDlQ8jneYqLO7HHMC6PgsngBgWK6TUzKSnCArF18zYKVFoul/kDr8M2yDHwHIrWK7HKDtZ3UrkzvM7vy2ZcFtiTk/9kjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660323; c=relaxed/simple;
	bh=FpbdmlFt+vohy+22OJXoMhDgdQGspq+e2GwxjeL+cl4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ekNpRL64QbgoA+6sv6cS+35XH5QtDzru7nXMY61L1eYDSYM4MI72VbUbv0kSgZStxqohVK2zV8vyU5whDW7WnazGFK+W+q63Hurbbr3ZEq9djMQAJvdl8eVH2oEuGLkzg2vbqQCSHdgjouJ4GbvSszeoPwg0WZvjVlUvVm4xj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AjT4mVDI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 6CE9D20B710C; Mon, 16 Mar 2026 04:25:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CE9D20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773660316;
	bh=uiIk9O4DnQlGJjCUlsecxsBWSKHWacv/bDOYe+d95sY=;
	h=From:To:Subject:Date:From;
	b=AjT4mVDIC/wEiZ47mdXvS0ixggNq7wEiiDT5xco4GIwDD7cURU9dkc2SswlDpRMOP
	 FCvRU7kdQXz5IDd3kH04v/wSmhu707ZdAAzzwkfx9dh4/qXMHZiU5+lElutZmZ6Hl6
	 ubXIT7ZAgiMGoLWBcAJLTOry+mH9JQ+fw0kOY3y4=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	yury.norov@gmail.com,
	kees@kernel.org,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3] net: mana: Expose hardware diagnostic info via debugfs
Date: Mon, 16 Mar 2026 04:23:27 -0700
Message-ID: <20260316112339.1208155-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9423-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 923CC298A1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add debugfs entries to expose hardware configuration and diagnostic
information that aids in debugging driver initialization and runtime
operations without adding noise to dmesg.

The debugfs directory creation and removal for each PCI device is
integrated into mana_gd_setup() and mana_gd_cleanup_device()
respectively, so that all callers (probe, remove, suspend, resume,
shutdown) share a single code path.

Device-level entries (under /sys/kernel/debug/mana/<slot>/):
  - num_msix_usable, max_num_queues: Max resources from hardware
  - gdma_protocol_ver, pf_cap_flags1: VF version negotiation results
  - num_vports, bm_hostmode: Device configuration

Per-vPort entries (under /sys/kernel/debug/mana/<slot>/vportN/):
  - port_handle: Hardware vPort handle
  - max_sq, max_rq: Max queues from vPort config
  - indir_table_sz: Indirection table size
  - steer_rx, steer_rss, steer_update_tab, steer_cqe_coalescing:
    Last applied steering configuration parameters

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3:
* Rename mana_gd_cleanup to mana_gd_cleanup_device.
* Add creation of debugfs entries in mana_gd_setup.
* Add removal of debugfs entries in mana_gd_cleanup_device.
* Remove bm_hostmode and num_vports from debugfs in mana_remove itself,
  because "ac" gets freed before debugfs_remove_recursive, to avoid
  Use-After-Free error.
* Add "goto out:" in mana_cfg_vport_steering to avoid populating apc
  values when resp.hdr.status is not NULL.
Changes in v2:
* Add debugfs_remove_recursice for gc>mana_pci_debugfs in
  mana_gd_suspend to handle multiple duplicates creation in
  mana_gd_setup and mana_gd_resume path.
* Move debugfs creation for num_vports and bm_hostmode out of
  if(!resuming) condition since we have to create it again even for
  resume.
* Recreate mana_pci_debugfs in mana_gd_resume.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 65 ++++++++++---------
 drivers/net/ethernet/microsoft/mana/mana_en.c | 35 ++++++++++
 include/net/mana/gdma.h                       |  1 +
 include/net/mana/mana.h                       |  8 +++
 4 files changed, 79 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index ef0dbfaac8f4..4d77e7fa565a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -169,6 +169,11 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	if (gc->max_num_queues > gc->num_msix_usable - 1)
 		gc->max_num_queues = gc->num_msix_usable - 1;
 
+	debugfs_create_u32("num_msix_usable", 0400, gc->mana_pci_debugfs,
+			   &gc->num_msix_usable);
+	debugfs_create_u32("max_num_queues", 0400, gc->mana_pci_debugfs,
+			   &gc->max_num_queues);
+
 	return 0;
 }
 
@@ -1239,6 +1244,13 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
 		return err ? err : -EPROTO;
 	}
 	gc->pf_cap_flags1 = resp.pf_cap_flags1;
+	gc->gdma_protocol_ver = resp.gdma_protocol_ver;
+
+	debugfs_create_x64("gdma_protocol_ver", 0400, gc->mana_pci_debugfs,
+			   &gc->gdma_protocol_ver);
+	debugfs_create_x64("pf_cap_flags1", 0400, gc->mana_pci_debugfs,
+			   &gc->pf_cap_flags1);
+
 	if (resp.pf_cap_flags1 & GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG) {
 		err = mana_gd_query_hwc_timeout(pdev, &hwc->hwc_timeout);
 		if (err) {
@@ -1918,15 +1930,23 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	int err;
 
+	if (gc->is_pf)
+		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
+	else
+		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
+							  mana_debugfs_root);
+
 	err = mana_gd_init_registers(pdev);
 	if (err)
-		return err;
+		goto remove_debugfs;
 
 	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
 
 	gc->service_wq = alloc_ordered_workqueue("gdma_service_wq", 0);
-	if (!gc->service_wq)
-		return -ENOMEM;
+	if (!gc->service_wq) {
+		err = -ENOMEM;
+		goto remove_debugfs;
+	}
 
 	err = mana_gd_setup_hwc_irqs(pdev);
 	if (err) {
@@ -1966,11 +1986,14 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	mana_gd_remove_irqs(pdev);
 free_workqueue:
 	destroy_workqueue(gc->service_wq);
+remove_debugfs:
+	debugfs_remove_recursive(gc->mana_pci_debugfs);
+	gc->mana_pci_debugfs = NULL;
 	dev_err(&pdev->dev, "%s failed (error %d)\n", __func__, err);
 	return err;
 }
 
-static void mana_gd_cleanup(struct pci_dev *pdev)
+static void mana_gd_cleanup_device(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
@@ -1982,6 +2005,10 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
 		destroy_workqueue(gc->service_wq);
 		gc->service_wq = NULL;
 	}
+
+	debugfs_remove_recursive(gc->mana_pci_debugfs);
+	gc->mana_pci_debugfs = NULL;
+
 	dev_dbg(&pdev->dev, "mana gdma cleanup successful\n");
 }
 
@@ -2039,12 +2066,6 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	gc->dev = &pdev->dev;
 	xa_init(&gc->irq_contexts);
 
-	if (gc->is_pf)
-		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
-	else
-		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
-							  mana_debugfs_root);
-
 	err = mana_gd_setup(pdev);
 	if (err)
 		goto unmap_bar;
@@ -2073,16 +2094,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 cleanup_mana:
 	mana_remove(&gc->mana, false);
 cleanup_gd:
-	mana_gd_cleanup(pdev);
+	mana_gd_cleanup_device(pdev);
 unmap_bar:
-	/*
-	 * at this point we know that the other debugfs child dir/files
-	 * are either not yet created or are already cleaned up.
-	 * The pci debugfs folder clean-up now, will only be cleaning up
-	 * adapter-MTU file and apc->mana_pci_debugfs folder.
-	 */
-	debugfs_remove_recursive(gc->mana_pci_debugfs);
-	gc->mana_pci_debugfs = NULL;
 	xa_destroy(&gc->irq_contexts);
 	pci_iounmap(pdev, bar0_va);
 free_gc:
@@ -2132,11 +2145,7 @@ static void mana_gd_remove(struct pci_dev *pdev)
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, false);
 
-	mana_gd_cleanup(pdev);
-
-	debugfs_remove_recursive(gc->mana_pci_debugfs);
-
-	gc->mana_pci_debugfs = NULL;
+	mana_gd_cleanup_device(pdev);
 
 	xa_destroy(&gc->irq_contexts);
 
@@ -2158,7 +2167,7 @@ int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, true);
 
-	mana_gd_cleanup(pdev);
+	mana_gd_cleanup_device(pdev);
 
 	return 0;
 }
@@ -2197,11 +2206,7 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, true);
 
-	mana_gd_cleanup(pdev);
-
-	debugfs_remove_recursive(gc->mana_pci_debugfs);
-
-	gc->mana_pci_debugfs = NULL;
+	mana_gd_cleanup_device(pdev);
 
 	pci_disable_device(pdev);
 }
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ea71de39f996..3beaddb1d585 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1263,6 +1263,9 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
 	apc->port_handle = resp.vport;
 	ether_addr_copy(apc->mac_addr, resp.mac_addr);
 
+	apc->vport_max_sq = *max_sq;
+	apc->vport_max_rq = *max_rq;
+
 	return 0;
 }
 
@@ -1405,10 +1408,16 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 		netdev_err(ndev, "vPort RX configuration failed: 0x%x\n",
 			   resp.hdr.status);
 		err = -EPROTO;
+		goto out;
 	}
 
 	netdev_info(ndev, "Configured steering vPort %llu entries %u\n",
 		    apc->port_handle, apc->indir_table_sz);
+
+	apc->steer_rx = rx;
+	apc->steer_rss = apc->rss_state;
+	apc->steer_update_tab = update_tab;
+	apc->steer_cqe_coalescing = req->cqe_coalescing_enable;
 out:
 	kfree(req);
 	return err;
@@ -3110,6 +3119,24 @@ static int mana_init_port(struct net_device *ndev)
 	eth_hw_addr_set(ndev, apc->mac_addr);
 	sprintf(vport, "vport%d", port_idx);
 	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
+
+	debugfs_create_u64("port_handle", 0400, apc->mana_port_debugfs,
+			   &apc->port_handle);
+	debugfs_create_u32("max_sq", 0400, apc->mana_port_debugfs,
+			   &apc->vport_max_sq);
+	debugfs_create_u32("max_rq", 0400, apc->mana_port_debugfs,
+			   &apc->vport_max_rq);
+	debugfs_create_u32("indir_table_sz", 0400, apc->mana_port_debugfs,
+			   &apc->indir_table_sz);
+	debugfs_create_u32("steer_rx", 0400, apc->mana_port_debugfs,
+			   &apc->steer_rx);
+	debugfs_create_u32("steer_rss", 0400, apc->mana_port_debugfs,
+			   &apc->steer_rss);
+	debugfs_create_u32("steer_update_tab", 0400, apc->mana_port_debugfs,
+			   &apc->steer_update_tab);
+	debugfs_create_u32("steer_cqe_coalescing", 0400, apc->mana_port_debugfs,
+			   &apc->steer_cqe_coalescing);
+
 	return 0;
 
 reset_apc:
@@ -3598,6 +3625,11 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	ac->bm_hostmode = bm_hostmode;
 
+	debugfs_create_u16("num_vports", 0400, gc->mana_pci_debugfs,
+			   &ac->num_ports);
+	debugfs_create_u8("bm_hostmode", 0400, gc->mana_pci_debugfs,
+			  &ac->bm_hostmode);
+
 	if (!resuming) {
 		ac->num_ports = num_ports;
 
@@ -3738,6 +3770,9 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 
 	mana_gd_deregister_device(gd);
 
+	debugfs_lookup_and_remove("num_vports", gc->mana_pci_debugfs);
+	debugfs_lookup_and_remove("bm_hostmode", gc->mana_pci_debugfs);
+
 	if (suspending)
 		return;
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 7fe3a1b61b2d..c4e3ce5147f7 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -442,6 +442,7 @@ struct gdma_context {
 	struct gdma_dev		mana_ib;
 
 	u64 pf_cap_flags1;
+	u64 gdma_protocol_ver;
 
 	struct workqueue_struct *service_wq;
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index a078af283bdd..83f6de67c0cc 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -563,6 +563,14 @@ struct mana_port_context {
 
 	/* Debugfs */
 	struct dentry *mana_port_debugfs;
+
+	/* Cached vport/steering config for debugfs */
+	u32 vport_max_sq;
+	u32 vport_max_rq;
+	u32 steer_rx;
+	u32 steer_rss;
+	u32 steer_update_tab;
+	u32 steer_cqe_coalescing;
 };
 
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
-- 
2.43.0


