Return-Path: <linux-hyperv+bounces-2928-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E969967E3B
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 05:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148521F22491
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 03:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB873F8F7;
	Mon,  2 Sep 2024 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RQ3gVQr8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96095A32;
	Mon,  2 Sep 2024 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248743; cv=none; b=K2iEzPnvuEFUSZyzMICFIhXx9KqVPvxPpj1N+ch5DF1LEz3sgZ/rhxaXMv5+hz1Y6AT+b03c5EttMgumAGo4X/YCSsGZcBkzxCrwLMRwhWhyJ22UBLjpAdzjp6Vt4IIdRdUW9jpWIFPiappHNW8QjU9IbQkzAkVTjBJSVXgmTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248743; c=relaxed/simple;
	bh=+MBIPJtYIoiJf8QT9pP6fMzxLjVl9hSOhEt9z81QUYs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iwP2KzxSHrIW5jfWUHRC5yu7jZZAeWzZE79V2KVD2Cb0PEqvRbsCwAoH9L91AAjGJWlZ7pFjkyT4qYUrjehEgPDfURimnpoCew8+LtZusGiOhXbL94AgHEd/9T/WlaH68JeV5p17BMVnCEdjd0xWcThGcx76q/MYXM5X1n4nvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RQ3gVQr8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id F35BA20B7165; Sun,  1 Sep 2024 20:45:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F35BA20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725248735;
	bh=+wnfCgqjbsq5/x6cwBds07gGYWXxjV04gceiknVyHO0=;
	h=From:To:Cc:Subject:Date:From;
	b=RQ3gVQr8ew1PBzO1Rn7mXiFsgiG8lNjlgoNs5OKsuV6LmUlqmxpAcCvPncjV46UEH
	 enGljgeenLsMJEgl4TTnRVDPFJ7V/KtzpfzZDTCnTSjDmz3P4QXK5VvH7Ia14Su8x3
	 SXZYU/O/pvoUbrfFW3YmjBc8rFICpQf2isd43XbY=
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
Subject: [PATCH net-next v2] net: mana: Improve mana_set_channels() in low mem conditions
Date: Sun,  1 Sep 2024 20:45:34 -0700
Message-Id: <1725248734-21760-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The mana_set_channels() function requires detaching the mana
driver and reattaching it with changed channel values.
During this operation if the system is low on memory, the reattach
might fail, causing the network device being down.
To avoid this we pre-allocate buffers at the beginning of set operation,
to prevent complete network loss

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v2
 * Pass num_queues as argument in mana_pre_alloc_rxbufs()
---
 drivers/net/ethernet/microsoft/mana/mana_en.c |  6 ++--
 .../ethernet/microsoft/mana/mana_ethtool.c    | 28 ++++++++++---------
 include/net/mana/mana.h                       |  2 +-
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 3e865985340e..a174ca719aba 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -608,7 +608,7 @@ static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, u32 *alloc_size,
 	*datasize = mtu + ETH_HLEN;
 }
 
-int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu)
+int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_queues)
 {
 	struct device *dev;
 	struct page *page;
@@ -622,7 +622,7 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu)
 
 	dev = mpc->ac->gdma_dev->gdma_context->dev;
 
-	num_rxb = mpc->num_queues * mpc->rx_queue_size;
+	num_rxb = num_queues * mpc->rx_queue_size;
 
 	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
 	mpc->rxbufs_pre = kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
@@ -682,7 +682,7 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 	int err;
 
 	/* Pre-allocate buffers to prevent failure in mana_attach later */
-	err = mana_pre_alloc_rxbufs(mpc, new_mtu);
+	err = mana_pre_alloc_rxbufs(mpc, new_mtu, mpc->num_queues);
 	if (err) {
 		netdev_err(ndev, "Insufficient memory for new MTU\n");
 		return err;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index d6a35fbda447..dc3864377538 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -345,27 +345,29 @@ static int mana_set_channels(struct net_device *ndev,
 	struct mana_port_context *apc = netdev_priv(ndev);
 	unsigned int new_count = channels->combined_count;
 	unsigned int old_count = apc->num_queues;
-	int err, err2;
+	int err;
+
+	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, new_count);
+	if (err) {
+		netdev_err(ndev, "Insufficient memory for new allocations");
+		return err;
+	}
 
 	err = mana_detach(ndev, false);
 	if (err) {
 		netdev_err(ndev, "mana_detach failed: %d\n", err);
-		return err;
+		goto out;
 	}
 
 	apc->num_queues = new_count;
 	err = mana_attach(ndev);
-	if (!err)
-		return 0;
-
-	netdev_err(ndev, "mana_attach failed: %d\n", err);
-
-	/* Try to roll it back to the old configuration. */
-	apc->num_queues = old_count;
-	err2 = mana_attach(ndev);
-	if (err2)
-		netdev_err(ndev, "mana re-attach failed: %d\n", err2);
+	if (err) {
+		apc->num_queues = old_count;
+		netdev_err(ndev, "mana_attach failed: %d\n", err);
+	}
 
+out:
+	mana_pre_dealloc_rxbufs(apc);
 	return err;
 }
 
@@ -414,7 +416,7 @@ static int mana_set_ringparam(struct net_device *ndev,
 
 	/* pre-allocating new buffers to prevent failures in mana_attach() later */
 	apc->rx_queue_size = new_rx;
-	err = mana_pre_alloc_rxbufs(apc, ndev->mtu);
+	err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
 	apc->rx_queue_size = old_rx;
 	if (err) {
 		netdev_err(ndev, "Insufficient memory for new allocations\n");
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 1f869624811d..dfbf78d4e557 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -488,7 +488,7 @@ struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 void mana_query_gf_stats(struct mana_port_context *apc);
-int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu);
+int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
 extern const struct ethtool_ops mana_ethtool_ops;
-- 
2.34.1


