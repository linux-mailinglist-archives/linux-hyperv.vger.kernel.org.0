Return-Path: <linux-hyperv+bounces-3136-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1553994063
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2024 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63242283112
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14141F9438;
	Tue,  8 Oct 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p2V3GAlU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3901D4342;
	Tue,  8 Oct 2024 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371179; cv=none; b=j0Ld/Pxw4eU6VyeKWzwNKN99+X3GuZqQBDzOltpbu8h533QbPDX/rhQuv3gEPRRS5LppoS6QYmjOjdi+9Zky9sUlzNL1hZLaZUuFbeNKrsSCv/HyrCzmaq0pdF3fsFO5nY7R+6WqmrhDZH0wtl9cL1OLC9W1+eneRXQbGtJz1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371179; c=relaxed/simple;
	bh=6vU35ptvt7YtEoyGQoBU8gSnLFMHDD8oHXpmlhg1G9s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=irrikxOdFNN9TYCZWFHpaxpRqS2fDwZzIwP8cFPzVmjfWUfyP/tzMNviuxwzlvhfhfmODJAjikGSU6l7nKj+T+VJmdxV3TGV/2z6y5d2HrXOh/I7S/acz1lBZMHwINjPB4GgaZ9Rj7PUKtbdRmwnG3fcaXfivs4UpxN0pXFW+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p2V3GAlU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 831A620DEA66; Tue,  8 Oct 2024 00:06:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 831A620DEA66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728371176;
	bh=BLrAaiaPWvB6wLCqZv6y8KAWOoOJzZiZ0wVvwUj7RAs=;
	h=From:To:Cc:Subject:Date:From;
	b=p2V3GAlUkeoEnyr7pVCU5RW46MCKpVkn6oesZnV0kXmht3lfYOgsvYPVkYvibrSeE
	 cpxH185MFAtJvOFEEQTSKFCfPu6u9i/se6MGPlm8I6ZgvD5Df5OvEDfDVWsF87lTFa
	 Dd+nzqcReXz8HNHlOskaU5qQ/GS+0PMMYezv+dsU=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH net-next v2] net: mana: Enable debugfs files for MANA device
Date: Tue,  8 Oct 2024 00:06:15 -0700
Message-Id: <1728371175-906-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Implement debugfs in MANA driver to be able to view RX,TX,EQ queue
specific attributes and dump their gdma queues.
These dumps can be used by other userspace utilities to improve
debuggability and troubleshooting

Following files are added in debugfs:

/sys/kernel/debug/mana/
|-------------- 1
    |--------------- EQs
    |                 |------- eq0
    |                 |          |---head
    |                 |          |---tail
    |                 |          |---eq_dump
    |                 |------- eq1
    |                 .
    |                 .
    |
    |--------------- adapter-MTU
    |--------------- vport0
                      |------- RX-0
                      |          |---cq_budget
                      |          |---cq_dump
                      |          |---cq_head
                      |          |---cq_tail
                      |          |---rq_head
                      |          |---rq_nbuf
                      |          |---rq_tail
                      |          |---rxq_dump
                      |------- RX-1
                      .
                      .
                      |------- TX-0
                      |          |---cq_budget
                      |          |---cq_dump
                      |          |---cq_head
                      |          |---cq_tail
                      |          |---sq_head
                      |          |---sq_pend_skb_qlen
                      |          |---sq_tail
                      |          |---txq_dump
                      |------- TX-1
                      .
                      .

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
Changes in v2:
 * remove brackets around single statements
 * remove extra newlines
 * Add new include files alphabetically
 * maintain RCT for new variable declarations
---
 .../net/ethernet/microsoft/mana/gdma_main.c   |  43 ++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 105 +++++++++++++++++-
 include/net/mana/gdma.h                       |   6 +-
 include/net/mana/mana.h                       |   8 ++
 4 files changed, 159 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index ca4ed58f1206..e97af7ac2bb2 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /* Copyright (c) 2021, Microsoft Corporation. */
 
+#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/utsname.h>
@@ -8,6 +9,8 @@
 
 #include <net/mana/mana.h>
 
+struct dentry *mana_debugfs_root;
+
 static u32 mana_gd_r32(struct gdma_context *g, u64 offset)
 {
 	return readl(g->bar0_va + offset);
@@ -1516,6 +1519,12 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	gc->bar0_va = bar0_va;
 	gc->dev = &pdev->dev;
 
+	if (gc->is_pf)
+		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
+	else
+		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
+							  mana_debugfs_root);
+
 	err = mana_gd_setup(pdev);
 	if (err)
 		goto unmap_bar;
@@ -1529,6 +1538,13 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 cleanup_gd:
 	mana_gd_cleanup(pdev);
 unmap_bar:
+	/*
+	 * at this point we know that the other debugfs child dir/files
+	 * are either not yet created or are already cleaned up.
+	 * The pci debugfs folder clean-up now, will only be cleaning up
+	 * adapter-MTU file and apc->mana_pci_debugfs folder.
+	 */
+	debugfs_remove_recursive(gc->mana_pci_debugfs);
 	pci_iounmap(pdev, bar0_va);
 free_gc:
 	pci_set_drvdata(pdev, NULL);
@@ -1549,6 +1565,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 
 	mana_gd_cleanup(pdev);
 
+	debugfs_remove_recursive(gc->mana_pci_debugfs);
+
 	pci_iounmap(pdev, gc->bar0_va);
 
 	vfree(gc);
@@ -1600,6 +1618,8 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 
 	mana_gd_cleanup(pdev);
 
+	debugfs_remove_recursive(gc->mana_pci_debugfs);
+
 	pci_disable_device(pdev);
 }
 
@@ -1619,7 +1639,28 @@ static struct pci_driver mana_driver = {
 	.shutdown	= mana_gd_shutdown,
 };
 
-module_pci_driver(mana_driver);
+static int __init mana_driver_init(void)
+{
+	int err;
+
+	mana_debugfs_root = debugfs_create_dir("mana", NULL);
+
+	err = pci_register_driver(&mana_driver);
+	if (err)
+		debugfs_remove(mana_debugfs_root);
+
+	return err;
+}
+
+static void __exit mana_driver_exit(void)
+{
+	debugfs_remove(mana_debugfs_root);
+
+	pci_unregister_driver(&mana_driver);
+}
+
+module_init(mana_driver_init);
+module_exit(mana_driver_exit);
 
 MODULE_DEVICE_TABLE(pci, mana_id_table);
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index c47266d1c7c2..57ac732e7707 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3,6 +3,7 @@
 
 #include <uapi/linux/bpf.h>
 
+#include <linux/debugfs.h>
 #include <linux/inetdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -30,6 +31,21 @@ static void mana_adev_idx_free(int idx)
 	ida_free(&mana_adev_ida, idx);
 }
 
+static ssize_t mana_dbg_q_read(struct file *filp, char __user *buf, size_t count,
+			       loff_t *pos)
+{
+	struct gdma_queue *gdma_q = filp->private_data;
+
+	return simple_read_from_buffer(buf, count, pos, gdma_q->queue_mem_ptr,
+				       gdma_q->queue_size);
+}
+
+static const struct file_operations mana_dbg_q_fops = {
+	.owner  = THIS_MODULE,
+	.open   = simple_open,
+	.read   = mana_dbg_q_read,
+};
+
 /* Microsoft Azure Network Adapter (MANA) functions */
 
 static int mana_open(struct net_device *ndev)
@@ -721,6 +737,13 @@ static const struct net_device_ops mana_devops = {
 
 static void mana_cleanup_port_context(struct mana_port_context *apc)
 {
+	/*
+	 * at this point all dir/files under the vport directory
+	 * are already cleaned up.
+	 * We are sure the apc->mana_port_debugfs remove will not
+	 * cause any freed memory access issues
+	 */
+	debugfs_remove(apc->mana_port_debugfs);
 	kfree(apc->rxqs);
 	apc->rxqs = NULL;
 }
@@ -943,6 +966,8 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	else
 		gc->adapter_mtu = ETH_FRAME_LEN;
 
+	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
+
 	return 0;
 }
 
@@ -1228,6 +1253,8 @@ static void mana_destroy_eq(struct mana_context *ac)
 	if (!ac->eqs)
 		return;
 
+	debugfs_remove_recursive(ac->mana_eqs_debugfs);
+
 	for (i = 0; i < gc->max_num_queues; i++) {
 		eq = ac->eqs[i].eq;
 		if (!eq)
@@ -1240,6 +1267,18 @@ static void mana_destroy_eq(struct mana_context *ac)
 	ac->eqs = NULL;
 }
 
+static void mana_create_eq_debugfs(struct mana_context *ac, int i)
+{
+	struct mana_eq eq = ac->eqs[i];
+	char eqnum[32];
+
+	sprintf(eqnum, "eq%d", i);
+	eq.mana_eq_debugfs = debugfs_create_dir(eqnum, ac->mana_eqs_debugfs);
+	debugfs_create_u32("head", 0400, eq.mana_eq_debugfs, &eq.eq->head);
+	debugfs_create_u32("tail", 0400, eq.mana_eq_debugfs, &eq.eq->tail);
+	debugfs_create_file("eq_dump", 0400, eq.mana_eq_debugfs, eq.eq, &mana_dbg_q_fops);
+}
+
 static int mana_create_eq(struct mana_context *ac)
 {
 	struct gdma_dev *gd = ac->gdma_dev;
@@ -1260,11 +1299,14 @@ static int mana_create_eq(struct mana_context *ac)
 	spec.eq.context = ac->eqs;
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 
+	ac->mana_eqs_debugfs = debugfs_create_dir("EQs", gc->mana_pci_debugfs);
+
 	for (i = 0; i < gc->max_num_queues; i++) {
 		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
 		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
 		if (err)
 			goto out;
+		mana_create_eq_debugfs(ac, i);
 	}
 
 	return 0;
@@ -1871,6 +1913,8 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		return;
 
 	for (i = 0; i < apc->num_queues; i++) {
+		debugfs_remove_recursive(apc->tx_qp[i].mana_tx_debugfs);
+
 		napi = &apc->tx_qp[i].tx_cq.napi;
 		if (apc->tx_qp[i].txq.napi_initialized) {
 			napi_synchronize(napi);
@@ -1889,6 +1933,31 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 	apc->tx_qp = NULL;
 }
 
+static void mana_create_txq_debugfs(struct mana_port_context *apc, int idx)
+{
+	struct mana_tx_qp *tx_qp = &apc->tx_qp[idx];
+	char qnum[32];
+
+	sprintf(qnum, "TX-%d", idx);
+	tx_qp->mana_tx_debugfs = debugfs_create_dir(qnum, apc->mana_port_debugfs);
+	debugfs_create_u32("sq_head", 0400, tx_qp->mana_tx_debugfs,
+			   &tx_qp->txq.gdma_sq->head);
+	debugfs_create_u32("sq_tail", 0400, tx_qp->mana_tx_debugfs,
+			   &tx_qp->txq.gdma_sq->tail);
+	debugfs_create_u32("sq_pend_skb_qlen", 0400, tx_qp->mana_tx_debugfs,
+			   &tx_qp->txq.pending_skbs.qlen);
+	debugfs_create_u32("cq_head", 0400, tx_qp->mana_tx_debugfs,
+			   &tx_qp->tx_cq.gdma_cq->head);
+	debugfs_create_u32("cq_tail", 0400, tx_qp->mana_tx_debugfs,
+			   &tx_qp->tx_cq.gdma_cq->tail);
+	debugfs_create_u32("cq_budget", 0400, tx_qp->mana_tx_debugfs,
+			   &tx_qp->tx_cq.budget);
+	debugfs_create_file("txq_dump", 0400, tx_qp->mana_tx_debugfs,
+			    tx_qp->txq.gdma_sq, &mana_dbg_q_fops);
+	debugfs_create_file("cq_dump", 0400, tx_qp->mana_tx_debugfs,
+			    tx_qp->tx_cq.gdma_cq, &mana_dbg_q_fops);
+}
+
 static int mana_create_txq(struct mana_port_context *apc,
 			   struct net_device *net)
 {
@@ -2000,6 +2069,8 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		gc->cq_table[cq->gdma_id] = cq->gdma_cq;
 
+		mana_create_txq_debugfs(apc, i);
+
 		netif_napi_add_tx(net, &cq->napi, mana_poll);
 		napi_enable(&cq->napi);
 		txq->napi_initialized = true;
@@ -2027,6 +2098,8 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (!rxq)
 		return;
 
+	debugfs_remove_recursive(rxq->mana_rx_debugfs);
+
 	napi = &rxq->rx_cq.napi;
 
 	if (napi_initialized) {
@@ -2308,6 +2381,28 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	return NULL;
 }
 
+static void mana_create_rxq_debugfs(struct mana_port_context *apc, int idx)
+{
+	struct mana_rxq *rxq;
+	char qnum[32];
+
+	rxq = apc->rxqs[idx];
+
+	sprintf(qnum, "RX-%d", idx);
+	rxq->mana_rx_debugfs = debugfs_create_dir(qnum, apc->mana_port_debugfs);
+	debugfs_create_u32("rq_head", 0400, rxq->mana_rx_debugfs, &rxq->gdma_rq->head);
+	debugfs_create_u32("rq_tail", 0400, rxq->mana_rx_debugfs, &rxq->gdma_rq->tail);
+	debugfs_create_u32("rq_nbuf", 0400, rxq->mana_rx_debugfs, &rxq->num_rx_buf);
+	debugfs_create_u32("cq_head", 0400, rxq->mana_rx_debugfs,
+			   &rxq->rx_cq.gdma_cq->head);
+	debugfs_create_u32("cq_tail", 0400, rxq->mana_rx_debugfs,
+			   &rxq->rx_cq.gdma_cq->tail);
+	debugfs_create_u32("cq_budget", 0400, rxq->mana_rx_debugfs, &rxq->rx_cq.budget);
+	debugfs_create_file("rxq_dump", 0400, rxq->mana_rx_debugfs, rxq->gdma_rq, &mana_dbg_q_fops);
+	debugfs_create_file("cq_dump", 0400, rxq->mana_rx_debugfs, rxq->rx_cq.gdma_cq,
+			    &mana_dbg_q_fops);
+}
+
 static int mana_add_rx_queues(struct mana_port_context *apc,
 			      struct net_device *ndev)
 {
@@ -2326,6 +2421,8 @@ static int mana_add_rx_queues(struct mana_port_context *apc,
 		u64_stats_init(&rxq->stats.syncp);
 
 		apc->rxqs[i] = rxq;
+
+		mana_create_rxq_debugfs(apc, i);
 	}
 
 	apc->default_rxobj = apc->rxqs[0]->rxobj;
@@ -2518,14 +2615,19 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 static int mana_init_port(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
+	struct gdma_dev *gd = apc->ac->gdma_dev;
 	u32 max_txq, max_rxq, max_queues;
 	int port_idx = apc->port_idx;
+	struct gdma_context *gc;
+	char vport[32];
 	int err;
 
 	err = mana_init_port_context(apc);
 	if (err)
 		return err;
 
+	gc = gd->gdma_context;
+
 	err = mana_query_vport_cfg(apc, port_idx, &max_txq, &max_rxq,
 				   &apc->indir_table_sz);
 	if (err) {
@@ -2542,7 +2644,8 @@ static int mana_init_port(struct net_device *ndev)
 		apc->num_queues = apc->max_queues;
 
 	eth_hw_addr_set(ndev, apc->mac_addr);
-
+	sprintf(vport, "vport%d", port_idx);
+	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
 	return 0;
 
 reset_apc:
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index de47fa533b15..90f56656b572 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -267,7 +267,8 @@ struct gdma_event {
 struct gdma_queue;
 
 struct mana_eq {
-	struct gdma_queue *eq;
+	struct gdma_queue	*eq;
+	struct dentry		*mana_eq_debugfs;
 };
 
 typedef void gdma_eq_callback(void *context, struct gdma_queue *q,
@@ -365,6 +366,7 @@ struct gdma_irq_context {
 
 struct gdma_context {
 	struct device		*dev;
+	struct dentry		*mana_pci_debugfs;
 
 	/* Per-vPort max number of queues */
 	unsigned int		max_num_queues;
@@ -878,5 +880,7 @@ int mana_gd_send_request(struct gdma_context *gc, u32 req_len, const void *req,
 			 u32 resp_len, void *resp);
 
 int mana_gd_destroy_dma_region(struct gdma_context *gc, u64 dma_region_handle);
+void mana_register_debugfs(void);
+void mana_unregister_debugfs(void);
 
 #endif /* _GDMA_H */
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index f2a5200d8a0f..5ca4941f15ef 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -350,6 +350,7 @@ struct mana_rxq {
 	int xdp_rc; /* XDP redirect return code */
 
 	struct page_pool *page_pool;
+	struct dentry *mana_rx_debugfs;
 
 	/* MUST BE THE LAST MEMBER:
 	 * Each receive buffer has an associated mana_recv_buf_oob.
@@ -363,6 +364,8 @@ struct mana_tx_qp {
 	struct mana_cq tx_cq;
 
 	mana_handle_t tx_object;
+
+	struct dentry *mana_tx_debugfs;
 };
 
 struct mana_ethtool_stats {
@@ -407,6 +410,7 @@ struct mana_context {
 	u16 num_ports;
 
 	struct mana_eq *eqs;
+	struct dentry *mana_eqs_debugfs;
 
 	struct net_device *ports[MAX_PORTS_IN_MANA_DEV];
 };
@@ -468,6 +472,9 @@ struct mana_port_context {
 	bool port_st_save; /* Saved port state */
 
 	struct mana_ethtool_stats eth_stats;
+
+	/* Debugfs */
+	struct dentry *mana_port_debugfs;
 };
 
 netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev);
@@ -494,6 +501,7 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
+extern struct dentry *mana_debugfs_root;
 
 /* A CQ can be created not associated with any EQ */
 #define GDMA_CQ_NO_EQ  0xffff
-- 
2.34.1


