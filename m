Return-Path: <linux-hyperv+bounces-9155-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKADAlHtqWm7IAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9155-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 21:53:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2D2184FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 21:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32663008A53
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2026 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81918347FED;
	Thu,  5 Mar 2026 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ntONq8im"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C612BD587;
	Thu,  5 Mar 2026 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744013; cv=none; b=l9EZLGLOSmSU05qA7agwvrlj+B1kZacymmKv1xZR/4k4W0V0nNIySe3btGQTz+z+vxssYYxiP17lYRot0ZVnBl/lvueboj0Z6g9WS59juHRoXYz0b95nxdkqDphlqS45b9EkbwUn/x/9Y3WBIPVOBOrEQar5UladCu+7iVFj7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744013; c=relaxed/simple;
	bh=oNZlJ3Mw1Msk7wT/dnaky+PJUNff5MaDBxB7UaS8nTw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qeX+JsjI8pXPn6rBXMsnjwJlBgcclgpkaqJ3uZOAL4BTROkdMCzOxXKYSGtXnXkZOTj0x916qWhW5MxF+i0VxYIsPVgGl4n2FdDGTAd3QYitpyTuAroeQ4/wieXEiDYzJ2nyP5JNtdtYU+/TVq+Nsuo9HUtOffc/h+5vP8WUoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ntONq8im; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7A7D420B6F02; Thu,  5 Mar 2026 12:53:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A7D420B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772744006;
	bh=2MY91EkhhZj+9+e/zU397N5SGWS5fOlEBgxPK104L4w=;
	h=From:To:Subject:Date:From;
	b=ntONq8imgaGjpWipnVi8duM3X1uOPXU0LHbTrjdScYgkxSTjM8plGngN664DHrd3m
	 QcdldcLcaLTlzM8dlG75NZkhJ3C9JSFLD8adsob1pDqW6syIZ/U0Oji+zRX53mAG9n
	 v31qaBt67kAjHQ10M9iLB/IjJHaFu22BCdOlZ7LA=
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
	ssengar@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net: mana: Expose hardware diagnostic info via debugfs
Date: Thu,  5 Mar 2026 12:52:40 -0800
Message-ID: <20260305205252.470089-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FD2D2184FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9155-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add debugfs entries to expose hardware configuration and diagnostic
information that aids in debugging driver initialization and runtime
operations without adding noise to dmesg.

Device-level entries (under /sys/kernel/debug/mana/<slot>/):
  - num_msix_usable, max_num_queues: Max resources from hardware
  - gdma_protocol_ver, pf_cap_flags1: VF version negotiation results
  - num_vports, bm_hostmode: Device configuration

  - port_handle: Hardware vPort handle
  - max_sq, max_rq: Max queues from vPort config
  - indir_table_sz: Indirection table size
  - steer_rx, steer_rss, steer_update_tab, steer_cqe_coalescing:
    Last applied steering configuration parameters

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 12 +++++++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 31 +++++++++++++++++++
 include/net/mana/gdma.h                       |  1 +
 include/net/mana/mana.h                       |  8 +++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 0055c231acf6..2ba8d224fd26 100644
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
 
@@ -1221,6 +1226,13 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
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
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 53f24244de75..25ce81283e92 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1265,6 +1265,9 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
 	apc->port_handle = resp.vport;
 	ether_addr_copy(apc->mac_addr, resp.mac_addr);
 
+	apc->vport_max_sq = *max_sq;
+	apc->vport_max_rq = *max_rq;
+
 	return 0;
 }
 
@@ -1411,6 +1414,11 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 
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
@@ -3102,6 +3110,24 @@ static int mana_init_port(struct net_device *ndev)
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
@@ -3587,6 +3613,11 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		ac->num_ports = num_ports;
 
 		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
+
+		debugfs_create_u16("num_vports", 0400, gc->mana_pci_debugfs,
+				   &ac->num_ports);
+		debugfs_create_u8("bm_hostmode", 0400, gc->mana_pci_debugfs,
+				  &ac->bm_hostmode);
 	} else {
 		if (ac->num_ports != num_ports) {
 			dev_err(dev, "The number of vPorts changed: %d->%d\n",
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 766f4fb25e26..9bbb7fb0c964 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -434,6 +434,7 @@ struct gdma_context {
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

