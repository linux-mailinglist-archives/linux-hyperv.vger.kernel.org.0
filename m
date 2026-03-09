Return-Path: <linux-hyperv+bounces-9195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIrVNeXbrmm/JQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9195-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 15:40:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6099B23AB18
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 15:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E6B303EB83
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Mar 2026 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56E3D34BC;
	Mon,  9 Mar 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZVFWCKMb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD53D333F;
	Mon,  9 Mar 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067169; cv=none; b=S44O9F+DWzTq2ZRWI4mvkbgvEoXMOLFfPFi4dWJhzto1GyCRO/LtF3FWhyJNerJ+JQUA1I2Y8JrXnm9WcODEyxFsfXW0bMDwLYGdZLgRGVcvEfN3riWvz2o+pcEB5GDEHPhr37iVd7YJthpf+VM8u2M69eW6ssgTIrDjNY3jcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067169; c=relaxed/simple;
	bh=vEGqJZE1lPr9QHjRXPzO2buTz3L2sa5tLp4g2Uq552w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hQzcqvYJehVz8vRAREmvg5ZwfOrN+YjpI4dh5/OuZJy5SjWGO1ug02dQ5hwcH99GuAxdr+aV3xisb/GnTXOurfZtiqIgQukLeGcBASxYn/5ovhlnt2OrliXzjSlRgBoDrho/LMa5ycEBd2Co7Lir1Bsj2cxMpuT2vx61sXJlRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZVFWCKMb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 227FD20B6F00; Mon,  9 Mar 2026 07:39:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 227FD20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773067167;
	bh=HoAderCUdnqh6fe8vbOhFK5KQ8A5DAYUy9/rXRzl4aY=;
	h=From:To:Subject:Date:From;
	b=ZVFWCKMbv1IZd5r8IbZcJdo4fu0/nNsQ0H+i53DIh6TzfQLpVY8qBGkRGrNeFA2cp
	 HxmYraxZcr40qaSF9TIbgZbySPHKI1HC9i3Xp4iDMZBmnh2zoqqyK9uZnEbN7V8M2U
	 MDUwYtcvOiCB0dVaitGOWyvjfLWSOlrX6O7LOB00=
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
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2] net: mana: Expose hardware diagnostic info via debugfs
Date: Mon,  9 Mar 2026 07:38:28 -0700
Message-ID: <20260309143840.675606-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6099B23AB18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9195-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add debugfs entries to expose hardware configuration and diagnostic
information that aids in debugging driver initialization and runtime
operations without adding noise to dmesg.

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
Changes in v2:
* Add debugfs_remove_recursice for gc>mana_pci_debugfs in
  mana_gd_suspend to handle multiple duplicates creation in
  mana_gd_setup and mana_gd_resume path.
* Move debugfs creation for num_vports and bm_hostmode out of
  if(!resuming) condition since we have to create it again even for
  resume.
* Recreate mana_pci_debugfs in mana_gd_resume.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 21 +++++++++++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 31 +++++++++++++++++++
 include/net/mana/gdma.h                       |  1 +
 include/net/mana/mana.h                       |  8 +++++
 4 files changed, 61 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aef8612b73cb..43fb366dc183 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -152,6 +152,11 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	if (gc->max_num_queues > gc->num_msix_usable - 1)
 		gc->max_num_queues = gc->num_msix_usable - 1;
 
+	debugfs_create_u32("num_msix_usable", 0400, gc->mana_pci_debugfs,
+			   &gc->num_msix_usable);
+	debugfs_create_u32("max_num_queues", 0400, gc->mana_pci_debugfs,
+			   &gc->max_num_queues);
+
 	return 0;
 }
 
@@ -1222,6 +1227,13 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
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
@@ -2128,6 +2140,9 @@ int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	mana_gd_cleanup(pdev);
 
+	debugfs_remove_recursive(gc->mana_pci_debugfs);
+	gc->mana_pci_debugfs = NULL;
+
 	return 0;
 }
 
@@ -2140,6 +2155,12 @@ int mana_gd_resume(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	int err;
 
+	if (gc->is_pf)
+		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
+	else
+		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
+							  mana_debugfs_root);
+
 	err = mana_gd_setup(pdev);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ea71de39f996..1117ae16b065 100644
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
 
@@ -1409,6 +1412,11 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 
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
@@ -3110,6 +3118,24 @@ static int mana_init_port(struct net_device *ndev)
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
@@ -3598,6 +3624,11 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	ac->bm_hostmode = bm_hostmode;
 
+	debugfs_create_u16("num_vports", 0400, gc->mana_pci_debugfs,
+			   &ac->num_ports);
+	debugfs_create_u8("bm_hostmode", 0400, gc->mana_pci_debugfs,
+			  &ac->bm_hostmode);
+
 	if (!resuming) {
 		ac->num_ports = num_ports;
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index ec17004b10c0..917945f0e3dc 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -440,6 +440,7 @@ struct gdma_context {
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
2.34.1


