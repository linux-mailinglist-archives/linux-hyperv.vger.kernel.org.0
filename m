Return-Path: <linux-hyperv+bounces-6585-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2776B33E83
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A6E1A82569
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A52E1C64;
	Mon, 25 Aug 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RQ1TbUqC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC72C15B6;
	Mon, 25 Aug 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122989; cv=none; b=LfzVfKdXfYR6tKvUkkhIEU9TpnHNkhNkt4T4NNYPccWPPRChXF/8PTbK3tprLetzKANKJUBelGZz32d/IGG7P/li62lRv4XVvFfJYht98dKFoMMAnLRXfL6RJ2Ur5S+h96pQ8w1Z7qtrKFBFUUHR5BINZpeYr6SpDfU3kICNrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122989; c=relaxed/simple;
	bh=+UyVJcftW8wy1kqNJFR4cziUxI4qiB8Q+yu4CtBFzas=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fDaxa6iVWLAVh2x9SKF5f8QJ7B4AVgz3aaK3w3tsibGqafEZV0a4oo4mCqwXpElm+9cvMgKt9Z/rpeXk6FKvM0AiUcPf7Rs0A0ICuPiIxhqksQIxosJ0t1fu5fkEvGZ5Kuzob0e0OCL6vrBzCRDSLY2ncGnl49Duna+80cXffWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RQ1TbUqC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 3B63021175A9; Mon, 25 Aug 2025 04:56:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B63021175A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756122987;
	bh=r2QJ4yqs6HxKoAH1VttKGbQwT/tvDfkSW+pvLpawz9E=;
	h=Date:From:To:Subject:From;
	b=RQ1TbUqCbRrJ7NV40HuiCbFKF24VOu3KRKqxR1bQ6UL2hipLYvx4HAL6io/E+j/dc
	 2TxennbuuLx5XX4TmTc1zk60iIkOjHKTyYo1PEnSBM+bhzqXahxHqfScxJylK+zlve
	 1siXccBAUP3TlOX7irEWiCE2tCG9T/Xq3WB3GwII=
Date: Mon, 25 Aug 2025 04:56:27 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dipayanroy@micorsoft.com,
	ssengar@linux.microsoft.com
Subject: [PATCH net] net: hv_netvsc: fix loss of early receive events from
 host during channel open.
Message-ID: <20250825115627.GA32189@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

The hv_netvsc driver currently enables NAPI after opening the primary and
subchannels. This ordering creates a race: if the Hyper-V host places data
in the host -> guest ring buffer and signals the channel before
napi_enable() has been called, the channel callback will run but
napi_schedule_prep() will return false. As a result, the NAPI poller never
gets scheduled, the data in the ring buffer is not consumed, and the
receive queue may remain permanently stuck until another interrupt happens
to arrive.

Fix this by enabling NAPI and registering it with the RX/TX queues before
vmbus channel is opened. This guarantees that any early host signal after
open will correctly trigger NAPI scheduling and the ring buffer will be
drained.

Fixes: 76bb5db5c749d ("netvsc: fix use after free on module removal")
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/hyperv/netvsc.c       | 17 ++++++++---------
 drivers/net/hyperv/rndis_filter.c | 23 ++++++++++++++++-------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 720104661d7f..60a4629fe6ba 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1812,6 +1812,11 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 	/* Enable NAPI handler before init callbacks */
 	netif_napi_add(ndev, &net_device->chan_table[0].napi, netvsc_poll);
+	napi_enable(&net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
+			     &net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
+			     &net_device->chan_table[0].napi);
 
 	/* Open the channel */
 	device->channel->next_request_id_callback = vmbus_next_request_id;
@@ -1831,12 +1836,6 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 	/* Channel is opened */
 	netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
 
-	napi_enable(&net_device->chan_table[0].napi);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
-			     &net_device->chan_table[0].napi);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
-			     &net_device->chan_table[0].napi);
-
 	/* Connect with the NetVsp */
 	ret = netvsc_connect_vsp(device, net_device, device_info);
 	if (ret != 0) {
@@ -1854,14 +1853,14 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 close:
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
-	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
-	napi_disable(&net_device->chan_table[0].napi);
 
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
 cleanup:
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	napi_disable(&net_device->chan_table[0].napi);
 	netif_napi_del(&net_device->chan_table[0].napi);
 
 cleanup2:
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 9e73959e61ee..ed67b1e1293a 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1252,17 +1252,26 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 	new_sc->rqstor_size = netvsc_rqstor_size(netvsc_ring_bytes);
 	new_sc->max_pkt_size = NETVSC_MAX_PKT_SIZE;
 
+	/* Enable napi before opening the vmbus channel to avoid races
+	 * as the host placing data on the host->guest ring may be left
+	 * out if napi was not enabled.
+	 */
+	napi_enable(&nvchan->napi);
+	netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+			     &nvchan->napi);
+	netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+			     &nvchan->napi);
+
 	ret = vmbus_open(new_sc, netvsc_ring_bytes,
 			 netvsc_ring_bytes, NULL, 0,
 			 netvsc_channel_cb, nvchan);
-	if (ret == 0) {
-		napi_enable(&nvchan->napi);
-		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
-				     &nvchan->napi);
-		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
-				     &nvchan->napi);
-	} else {
+	if (ret != 0) {
 		netdev_notice(ndev, "sub channel open failed: %d\n", ret);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+				     NULL);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
+		napi_disable(&nvchan->napi);
 	}
 
 	if (atomic_inc_return(&nvscdev->open_chn) == nvscdev->num_chn)
-- 
2.43.0


