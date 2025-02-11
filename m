Return-Path: <linux-hyperv+bounces-3891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4FA307AC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348923A4366
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C796D1F1530;
	Tue, 11 Feb 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cDL272P7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01D1D90CD;
	Tue, 11 Feb 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267557; cv=none; b=rBGI2yClaB1NUqVotaDVrLj/4dDBmcNBjNbVg27vVpHP5/fkvNoQxH8sTRLbif1Gsf9Qc5zPJGXaereES5xn0+B+FRsPOsEDciHhm++iV60FzNcmhWovYhGKN6vpXrpbcKqeDZBu6I8hEO1sLDDbA9Qso4Rt04APKzy71BNQ8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267557; c=relaxed/simple;
	bh=VZjiZNtpP5IMd8/wK+VHsSE4QSg4aS456UZIcf1oOhQ=;
	h=From:To:Subject:Date:Message-Id; b=SE1UXs3WhKkmBH2COHNU3gwsfLOVKZQngfKmuq5EMM31uWqUbZYbjhMoGaTsnfhIPjQqhK4UiflFINIPNjOoNlotIzMD5XULR/VrW2KJ2UxNAv0NthSu0ahFcUTW/ngWzW+KY2N8UmmyTNTAKCUu5sud79HO5hzDNzovOXrvsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cDL272P7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4D0F52107A9D; Tue, 11 Feb 2025 01:52:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D0F52107A9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739267555;
	bh=eX6hHik7B3tlfUunBekW+SxFWAYILIuefRVg2mz9lu0=;
	h=From:To:Subject:Date:From;
	b=cDL272P7islw7LaH/Ar9E0KIz1WdgKYDHWfJW+2v5+vfhOxeE+LKewV/4s+scy6mj
	 lnMA7rhhbITtDQJafrgUMEb18jz6OQ3gTvOjjnaMuCDCRiDhiTYBdNc8jla4Qni8nO
	 0s+O3Czr7wFxhtI1RscDjuQOE1RL/xuQTcJC9BHM=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com,
	mlevitsk@redhat.com,
	yury.norov@gmail.com,
	shradhagupta@linux.microsoft.com,
	kotaranov@microsoft.com,
	peterz@infradead.org,
	ernis@linux.microsoft.com,
	brett.creeley@amd.com,
	mhklinux@outlook.com,
	schakrabarti@linux.microsoft.com,
	kent.overstreet@linux.dev,
	longli@microsoft.com,
	leon@kernel.org,
	erick.archer@outlook.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mana: Add debug logs in MANA network driver
Date: Tue, 11 Feb 2025 01:51:55 -0800
Message-Id: <1739267515-31187-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add debug statements to assist in debugging and monitoring
driver behaviour, making it easier to identify potential
issues  during development and testing.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 52 +++++++++++++----
 .../net/ethernet/microsoft/mana/hw_channel.c  |  6 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 58 +++++++++++++++----
 3 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index be95336ce089..f9839938f0ab 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -666,8 +666,11 @@ int mana_gd_create_hwc_queue(struct gdma_dev *gd,
 
 	gmi = &queue->mem_info;
 	err = mana_gd_alloc_memory(gc, spec->queue_size, gmi);
-	if (err)
+	if (err) {
+		dev_err(gc->dev, "GDMA queue type: %d, size: %u, gdma memory allocation err: %d\n",
+			spec->type, spec->queue_size, err);
 		goto free_q;
+	}
 
 	queue->head = 0;
 	queue->tail = 0;
@@ -688,6 +691,8 @@ int mana_gd_create_hwc_queue(struct gdma_dev *gd,
 	*queue_ptr = queue;
 	return 0;
 out:
+	dev_err(gc->dev, "Failed to create queue type %d of size %u, err: %d\n",
+		spec->type, spec->queue_size, err);
 	mana_gd_free_memory(gmi);
 free_q:
 	kfree(queue);
@@ -763,14 +768,18 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 
 	if (resp.hdr.status ||
 	    resp.dma_region_handle == GDMA_INVALID_DMA_REGION) {
-		dev_err(gc->dev, "Failed to create DMA region: 0x%x\n",
-			resp.hdr.status);
 		err = -EPROTO;
 		goto out;
 	}
 
 	gmi->dma_region_handle = resp.dma_region_handle;
+	dev_dbg(gc->dev, "Created DMA region handle 0x%llx\n",
+		gmi->dma_region_handle);
 out:
+	if (err)
+		dev_err(gc->dev,
+			"Failed to create DMA region of length: %u, page_type: %d, status: 0x%x, err: %d\n",
+			length, req->gdma_page_type, resp.hdr.status, err);
 	kfree(req);
 	return err;
 }
@@ -793,8 +802,11 @@ int mana_gd_create_mana_eq(struct gdma_dev *gd,
 
 	gmi = &queue->mem_info;
 	err = mana_gd_alloc_memory(gc, spec->queue_size, gmi);
-	if (err)
+	if (err) {
+		dev_err(gc->dev, "GDMA queue type: %d, size: %u, gdma memory allocation err: %d\n",
+			spec->type, spec->queue_size, err);
 		goto free_q;
+	}
 
 	err = mana_gd_create_dma_region(gd, gmi);
 	if (err)
@@ -815,6 +827,8 @@ int mana_gd_create_mana_eq(struct gdma_dev *gd,
 	*queue_ptr = queue;
 	return 0;
 out:
+	dev_err(gc->dev, "Failed to create queue type %d of size: %u, err: %d\n",
+		spec->type, spec->queue_size, err);
 	mana_gd_free_memory(gmi);
 free_q:
 	kfree(queue);
@@ -841,8 +855,11 @@ int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 
 	gmi = &queue->mem_info;
 	err = mana_gd_alloc_memory(gc, spec->queue_size, gmi);
-	if (err)
+	if (err) {
+		dev_err(gc->dev, "GDMA queue type: %d, size: %u, memory allocation err: %d\n",
+			spec->type, spec->queue_size, err);
 		goto free_q;
+	}
 
 	err = mana_gd_create_dma_region(gd, gmi);
 	if (err)
@@ -862,6 +879,8 @@ int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 	*queue_ptr = queue;
 	return 0;
 out:
+	dev_err(gc->dev, "Failed to create queue type %d of size: %u, err: %d\n",
+		spec->type, spec->queue_size, err);
 	mana_gd_free_memory(gmi);
 free_q:
 	kfree(queue);
@@ -1157,8 +1176,11 @@ int mana_gd_post_and_ring(struct gdma_queue *queue,
 	int err;
 
 	err = mana_gd_post_work_request(queue, wqe_req, wqe_info);
-	if (err)
+	if (err) {
+		dev_err(gc->dev, "Failed to post work req from queue type %d of size %u (err=%d)\n",
+			queue->type, queue->queue_size, err);
 		return err;
+	}
 
 	mana_gd_wq_ring_doorbell(gc, queue);
 
@@ -1435,8 +1457,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
 
 	err = mana_gd_setup_irqs(pdev);
-	if (err)
+	if (err) {
+		dev_err(gc->dev, "Failed to setup IRQs: %d\n", err);
 		return err;
+	}
 
 	err = mana_hwc_create_channel(gc);
 	if (err)
@@ -1454,12 +1478,14 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	if (err)
 		goto destroy_hwc;
 
+	dev_dbg(&pdev->dev, "mana gdma setup successful\n");
 	return 0;
 
 destroy_hwc:
 	mana_hwc_destroy_channel(gc);
 remove_irq:
 	mana_gd_remove_irqs(pdev);
+	dev_err(&pdev->dev, "%s failed (error %d)\n", __func__, err);
 	return err;
 }
 
@@ -1470,6 +1496,7 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
 	mana_hwc_destroy_channel(gc);
 
 	mana_gd_remove_irqs(pdev);
+	dev_dbg(&pdev->dev, "mana gdma cleanup successful\n");
 }
 
 static bool mana_is_pf(unsigned short dev_id)
@@ -1488,8 +1515,10 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	BUILD_BUG_ON(2 * MAX_PORTS_IN_MANA_DEV * GDMA_EQE_SIZE > EQ_SIZE);
 
 	err = pci_enable_device(pdev);
-	if (err)
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable pci device (err=%d)\n", err);
 		return -ENXIO;
+	}
 
 	pci_set_master(pdev);
 
@@ -1498,9 +1527,10 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto disable_dev;
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (err)
+	if (err) {
+		dev_err(&pdev->dev, "DMA set mask failed: %d\n", err);
 		goto release_region;
-
+	}
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 
 	err = -ENOMEM;
@@ -1575,6 +1605,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+
+	dev_dbg(&pdev->dev, "mana gdma remove successful\n");
 }
 
 /* The 'state' parameter is not used. */
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index a00f915c5188..1ba49602089b 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -440,7 +440,8 @@ static int mana_hwc_alloc_dma_buf(struct hw_channel_context *hwc, u16 q_depth,
 	gmi = &dma_buf->mem_info;
 	err = mana_gd_alloc_memory(gc, buf_size, gmi);
 	if (err) {
-		dev_err(hwc->dev, "Failed to allocate DMA buffer: %d\n", err);
+		dev_err(hwc->dev, "Failed to allocate DMA buffer size: %u, err %d\n",
+			buf_size, err);
 		goto out;
 	}
 
@@ -529,6 +530,9 @@ static int mana_hwc_create_wq(struct hw_channel_context *hwc,
 out:
 	if (err)
 		mana_hwc_destroy_wq(hwc, hwc_wq);
+
+	dev_err(hwc->dev, "Failed to create HWC queue size= %u type= %d err= %d\n",
+		queue_size, q_type, err);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..32e2c5cd7152 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -52,10 +52,12 @@ static int mana_open(struct net_device *ndev)
 {
 	struct mana_port_context *apc = netdev_priv(ndev);
 	int err;
-
 	err = mana_alloc_queues(ndev);
-	if (err)
+
+	if (err) {
+		netdev_err(ndev, "%s failed to allocate queues: %d\n", __func__, err);
 		return err;
+	}
 
 	apc->port_is_up = true;
 
@@ -64,7 +66,7 @@ static int mana_open(struct net_device *ndev)
 
 	netif_carrier_on(ndev);
 	netif_tx_wake_all_queues(ndev);
-
+	netdev_dbg(ndev, "%s successful\n", __func__);
 	return 0;
 }
 
@@ -176,6 +178,9 @@ static int mana_map_skb(struct sk_buff *skb, struct mana_port_context *apc,
 	return 0;
 
 frag_err:
+	if (net_ratelimit())
+		netdev_err(apc->ndev, "Failed to map skb of size %u to DMA\n",
+			   skb->len);
 	for (i = sg_i - 1; i >= hsg; i--)
 		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
 			       DMA_TO_DEVICE);
@@ -687,6 +692,7 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_qu
 	return 0;
 
 error:
+	netdev_err(mpc->ndev, "Failed to pre-allocate RX buffers for %d queues\n", num_queues);
 	mana_pre_dealloc_rxbufs(mpc);
 	return -ENOMEM;
 }
@@ -1304,8 +1310,10 @@ static int mana_create_eq(struct mana_context *ac)
 	for (i = 0; i < gc->max_num_queues; i++) {
 		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
 		err = mana_gd_create_mana_eq(gd, &spec, &ac->eqs[i].eq);
-		if (err)
+		if (err) {
+			dev_err(gc->dev, "Failed to create EQ %d : %d\n", i, err);
 			goto out;
+		}
 		mana_create_eq_debugfs(ac, i);
 	}
 
@@ -2080,6 +2088,8 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 	return 0;
 out:
+	netdev_err(net, "Failed to create %d TX queues, %d\n",
+		   apc->num_queues, err);
 	mana_destroy_txq(apc);
 	return err;
 }
@@ -2415,6 +2425,7 @@ static int mana_add_rx_queues(struct mana_port_context *apc,
 		rxq = mana_create_rxq(apc, i, &ac->eqs[i], ndev);
 		if (!rxq) {
 			err = -ENOMEM;
+			netdev_err(ndev, "Failed to create rxq %d : %d\n", i, err);
 			goto out;
 		}
 
@@ -2661,12 +2672,18 @@ int mana_alloc_queues(struct net_device *ndev)
 	int err;
 
 	err = mana_create_vport(apc, ndev);
-	if (err)
+	if (err) {
+		netdev_err(ndev, "Failed to create vPort %u : %d\n", apc->port_idx, err);
 		return err;
+	}
 
 	err = netif_set_real_num_tx_queues(ndev, apc->num_queues);
-	if (err)
+	if (err) {
+		netdev_err(ndev,
+			   "netif_set_real_num_tx_queues () failed for ndev with num_queues %u : %d\n",
+			   apc->num_queues, err);
 		goto destroy_vport;
+	}
 
 	err = mana_add_rx_queues(apc, ndev);
 	if (err)
@@ -2675,14 +2692,20 @@ int mana_alloc_queues(struct net_device *ndev)
 	apc->rss_state = apc->num_queues > 1 ? TRI_STATE_TRUE : TRI_STATE_FALSE;
 
 	err = netif_set_real_num_rx_queues(ndev, apc->num_queues);
-	if (err)
+	if (err) {
+		netdev_err(ndev,
+			   "netif_set_real_num_rx_queues () failed for ndev with num_queues %u : %d\n",
+			   apc->num_queues, err);
 		goto destroy_vport;
+	}
 
 	mana_rss_table_init(apc);
 
 	err = mana_config_rss(apc, TRI_STATE_TRUE, true, true);
-	if (err)
+	if (err) {
+		netdev_err(ndev, "Failed to configure RSS table: %d\n", err);
 		goto destroy_vport;
+	}
 
 	if (gd->gdma_context->is_pf) {
 		err = mana_pf_register_filter(apc);
@@ -2823,8 +2846,10 @@ int mana_detach(struct net_device *ndev, bool from_close)
 
 	if (apc->port_st_save) {
 		err = mana_dealloc_queues(ndev);
-		if (err)
+		if (err) {
+			netdev_err(ndev, "%s failed to deallocate queues: %d\n", __func__, err);
 			return err;
+		}
 	}
 
 	if (!from_close) {
@@ -2968,6 +2993,8 @@ static int add_adev(struct gdma_dev *gd)
 		goto add_fail;
 
 	gd->adev = adev;
+	dev_dbg(gd->gdma_context->dev,
+		"Auxiliary device added successfully\n");
 	return 0;
 
 add_fail:
@@ -3009,8 +3036,10 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	}
 
 	err = mana_create_eq(ac);
-	if (err)
+	if (err) {
+		dev_err(dev, "Failed to create EQs: %d\n", err);
 		goto out;
+	}
 
 	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
 				    MANA_MICRO_VERSION, &num_ports);
@@ -3066,8 +3095,14 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	err = add_adev(gd);
 out:
-	if (err)
+	if (err) {
 		mana_remove(gd, false);
+	} else {
+		dev_dbg(dev, "gd=%p, id=%u, num_ports=%d, type=%u, instance=%u\n",
+			gd, gd->dev_id.as_uint32, ac->num_ports,
+			gd->dev_id.type, gd->dev_id.instance);
+		dev_dbg(dev, "%s succeeded\n", __func__);
+	}
 
 	return err;
 }
@@ -3129,6 +3164,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	gd->driver_data = NULL;
 	gd->gdma_context = NULL;
 	kfree(ac);
+	dev_dbg(dev, "%s succeeded\n", __func__);
 }
 
 struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
-- 
2.34.1


