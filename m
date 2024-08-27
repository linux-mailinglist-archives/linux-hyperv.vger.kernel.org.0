Return-Path: <linux-hyperv+bounces-2883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A00961666
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 20:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7485289147
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D11D3637;
	Tue, 27 Aug 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Mnz9F3Tg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158B1CDFC4;
	Tue, 27 Aug 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781963; cv=none; b=Pfy6SxY6rl5gvsuX3LR2NEZc7W9cz2YPWOlUee1sWaLmhDKaInSPfQNj9TP6PiqG831ORECnxryolAi84YQIkV5FStXinUSupUb+br8N8MDTcbIent+rc11ech+6hwGeiufRJmLzSajFy/bkPSZBQfP+2sUDsSwjjdR7LuickMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781963; c=relaxed/simple;
	bh=k3RAO7qB8aCRQe9XlUzb7hquIqjNNgKZVt6CuvPzWtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnxO7snUpVLZ3hVZXZQknCLlAdZV4/pl8iz3SsQp2I88Qq5ewYQbJzgfPmJF/ByDW+E5QhnEBBzWUZLfCRc89dFRrZ9Vtf+TWOw4PibF1HXm4rD2SdvUFJWvSOolC3wKcNBDLvq6xqPO9rJ8hL3CHXf3Ak7yiVBm6dFGugmAzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Mnz9F3Tg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1387020B7165; Tue, 27 Aug 2024 11:06:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1387020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724781960;
	bh=epAskuHQXWdedz5h6LNrZI9E4i7mjmBS0JVPfhvx2gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mnz9F3Tgb8mKDyBAz8jdMd99LyUkmt2GL+UfaCRXZr1BiRNO3zvlp1M3cfdgXkKfr
	 UK9EAHsBXF+KaGW6fZerwDXRYQ3fq016FaL7BPqXnH93LTpO14dqlpj0cmlWMdv6Zw
	 ici21eaeIqeC74YLuswH6zYzI78DU52uCuLVBwgQ=
Date: Tue, 27 Aug 2024 11:06:00 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v5] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240827180600.GA30906@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1724688461-12203-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724688461-12203-1-git-send-email-shradhagupta@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 26, 2024 at 09:07:41AM -0700, Shradha Gupta wrote:
> Currently the values of WQs for RX and TX queues for MANA devices
> are hardcoded to default sizes.
> Allow configuring these values for MANA devices as ringparam
> configuration(get/set) through ethtool_ops.
> Pre-allocate buffers at the beginning of this operation, to
> prevent complete network loss in low-memory conditions.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> Changes in v5:
>  * Explained comment better about not using MANA_PAGE_ALIGN
>  * remove unnecessay MANA_PAGE_ALIGN step for cq_size
> ---
> Changes in v4:
>  * if not apower of two, find the nearest power of 2 value and
>    use it as ring parameter
>  * Skip the max value check for parameters
> ---
> Changes in v3:
>  * pre-allocate buffers before changing the queue sizes
>  * rebased to latest net-next
> ---
>  Changes in v2:
>  * Removed unnecessary validations in mana_set_ringparam()
>  * Fixed codespell error
>  * Improved error message to indicate issue with the parameter
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 27 ++++---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 74 +++++++++++++++++++
>  include/net/mana/mana.h                       | 23 +++++-
>  3 files changed, 110 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d2f07e179e86..0a97bbdd958e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -511,7 +511,7 @@ static u16 mana_select_queue(struct net_device *ndev, struct sk_buff *skb,
>  }
>  
>  /* Release pre-allocated RX buffers */
> -static void mana_pre_dealloc_rxbufs(struct mana_port_context *mpc)
> +void mana_pre_dealloc_rxbufs(struct mana_port_context *mpc)
>  {
>  	struct device *dev;
>  	int i;
> @@ -604,7 +604,7 @@ static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, u32 *alloc_size,
>  	*datasize = mtu + ETH_HLEN;
>  }
>  
> -static int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu)
> +int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu)
>  {
>  	struct device *dev;
>  	struct page *page;
> @@ -618,7 +618,7 @@ static int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu)
>  
>  	dev = mpc->ac->gdma_dev->gdma_context->dev;
>  
> -	num_rxb = mpc->num_queues * RX_BUFFERS_PER_QUEUE;
> +	num_rxb = mpc->num_queues * mpc->rx_queue_size;
>  
>  	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
>  	mpc->rxbufs_pre = kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
> @@ -1899,15 +1899,17 @@ static int mana_create_txq(struct mana_port_context *apc,
>  		return -ENOMEM;
>  
>  	/*  The minimum size of the WQE is 32 bytes, hence
> -	 *  MAX_SEND_BUFFERS_PER_QUEUE represents the maximum number of WQEs
> +	 *  apc->tx_queue_size represents the maximum number of WQEs
>  	 *  the SQ can store. This value is then used to size other queues
>  	 *  to prevent overflow.
> +	 *  Also note that the txq_size is always going to be MANA_PAGE_ALIGNED,
> +	 *  as min val of apc->tx_queue_size is 128 and that would make
> +	 *  txq_size 128*32 = 4096 and the other higher values of apc->tx_queue_size
> +	 *  are always power of two
>  	 */
> -	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
> -	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
> +	txq_size = apc->tx_queue_size * 32;
>  
> -	cq_size = MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
> -	cq_size = MANA_PAGE_ALIGN(cq_size);
> +	cq_size = apc->tx_queue_size * COMP_ENTRY_SIZE;
>  
>  	gc = gd->gdma_context;
>  
> @@ -2145,10 +2147,11 @@ static int mana_push_wqe(struct mana_rxq *rxq)
>  
>  static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
>  {
> +	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
>  	struct page_pool_params pprm = {};
>  	int ret;
>  
> -	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
> +	pprm.pool_size = mpc->rx_queue_size;
>  	pprm.nid = gc->numa_node;
>  	pprm.napi = &rxq->rx_cq.napi;
>  	pprm.netdev = rxq->ndev;
> @@ -2180,13 +2183,13 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>  
>  	gc = gd->gdma_context;
>  
> -	rxq = kzalloc(struct_size(rxq, rx_oobs, RX_BUFFERS_PER_QUEUE),
> +	rxq = kzalloc(struct_size(rxq, rx_oobs, apc->rx_queue_size),
>  		      GFP_KERNEL);
>  	if (!rxq)
>  		return NULL;
>  
>  	rxq->ndev = ndev;
> -	rxq->num_rx_buf = RX_BUFFERS_PER_QUEUE;
> +	rxq->num_rx_buf = apc->rx_queue_size;
>  	rxq->rxq_idx = rxq_idx;
>  	rxq->rxobj = INVALID_MANA_HANDLE;
>  
> @@ -2734,6 +2737,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	apc->ndev = ndev;
>  	apc->max_queues = gc->max_num_queues;
>  	apc->num_queues = gc->max_num_queues;
> +	apc->tx_queue_size = DEF_TX_BUFFERS_PER_QUEUE;
> +	apc->rx_queue_size = DEF_RX_BUFFERS_PER_QUEUE;
>  	apc->port_handle = INVALID_MANA_HANDLE;
>  	apc->pf_filter_handle = INVALID_MANA_HANDLE;
>  	apc->port_idx = port_idx;
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 146d5db1792f..d6a35fbda447 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -369,6 +369,78 @@ static int mana_set_channels(struct net_device *ndev,
>  	return err;
>  }
>  
> +static void mana_get_ringparam(struct net_device *ndev,
> +			       struct ethtool_ringparam *ring,
> +			       struct kernel_ethtool_ringparam *kernel_ring,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +
> +	ring->rx_pending = apc->rx_queue_size;
> +	ring->tx_pending = apc->tx_queue_size;
> +	ring->rx_max_pending = MAX_RX_BUFFERS_PER_QUEUE;
> +	ring->tx_max_pending = MAX_TX_BUFFERS_PER_QUEUE;
> +}
> +
> +static int mana_set_ringparam(struct net_device *ndev,
> +			      struct ethtool_ringparam *ring,
> +			      struct kernel_ethtool_ringparam *kernel_ring,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +	u32 new_tx, new_rx;
> +	u32 old_tx, old_rx;
> +	int err;
> +
> +	old_tx = apc->tx_queue_size;
> +	old_rx = apc->rx_queue_size;
> +
> +	if (ring->tx_pending < MIN_TX_BUFFERS_PER_QUEUE) {
> +		NL_SET_ERR_MSG_FMT(extack, "tx:%d less than the min:%d", ring->tx_pending,
> +				   MIN_TX_BUFFERS_PER_QUEUE);
> +		return -EINVAL;
> +	}
> +
> +	if (ring->rx_pending < MIN_RX_BUFFERS_PER_QUEUE) {
> +		NL_SET_ERR_MSG_FMT(extack, "rx:%d less than the min:%d", ring->rx_pending,
> +				   MIN_RX_BUFFERS_PER_QUEUE);
> +		return -EINVAL;
> +	}
> +
> +	new_rx = roundup_pow_of_two(ring->rx_pending);
> +	new_tx = roundup_pow_of_two(ring->tx_pending);
> +	netdev_info(ndev, "Using nearest power of 2 values for Txq:%d Rxq:%d\n",
> +		    new_tx, new_rx);
> +
> +	/* pre-allocating new buffers to prevent failures in mana_attach() later */
> +	apc->rx_queue_size = new_rx;
> +	err = mana_pre_alloc_rxbufs(apc, ndev->mtu);
> +	apc->rx_queue_size = old_rx;
> +	if (err) {
> +		netdev_err(ndev, "Insufficient memory for new allocations\n");
> +		return err;
> +	}
> +
> +	err = mana_detach(ndev, false);
> +	if (err) {
> +		netdev_err(ndev, "mana_detach failed: %d\n", err);
> +		goto out;
> +	}
> +
> +	apc->tx_queue_size = new_tx;
> +	apc->rx_queue_size = new_rx;
> +
> +	err = mana_attach(ndev);
> +	if (err) {
> +		netdev_err(ndev, "mana_attach failed: %d\n", err);
> +		apc->tx_queue_size = old_tx;
> +		apc->rx_queue_size = old_rx;
> +	}
> +out:
> +	mana_pre_dealloc_rxbufs(apc);
> +	return err;
> +}
> +
>  const struct ethtool_ops mana_ethtool_ops = {
>  	.get_ethtool_stats	= mana_get_ethtool_stats,
>  	.get_sset_count		= mana_get_sset_count,
> @@ -380,4 +452,6 @@ const struct ethtool_ops mana_ethtool_ops = {
>  	.set_rxfh		= mana_set_rxfh,
>  	.get_channels		= mana_get_channels,
>  	.set_channels		= mana_set_channels,
> +	.get_ringparam          = mana_get_ringparam,
> +	.set_ringparam          = mana_set_ringparam,
>  };
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 6439fd8b437b..80a1e53471a6 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -38,9 +38,21 @@ enum TRI_STATE {
>  
>  #define COMP_ENTRY_SIZE 64
>  
> -#define RX_BUFFERS_PER_QUEUE 512
> +/* This Max value for RX buffers is derived from __alloc_page()'s max page
> + * allocation calculation. It allows maximum 2^(MAX_ORDER -1) pages. RX buffer
> + * size beyond this value gets rejected by __alloc_page() call.
> + */
> +#define MAX_RX_BUFFERS_PER_QUEUE 8192
> +#define DEF_RX_BUFFERS_PER_QUEUE 512
> +#define MIN_RX_BUFFERS_PER_QUEUE 128
>  
> -#define MAX_SEND_BUFFERS_PER_QUEUE 256
> +/* This max value for TX buffers is derived as the maximum allocatable
> + * pages supported on host per guest through testing. TX buffer size beyond
> + * this value is rejected by the hardware.
> + */
> +#define MAX_TX_BUFFERS_PER_QUEUE 16384
> +#define DEF_TX_BUFFERS_PER_QUEUE 256
> +#define MIN_TX_BUFFERS_PER_QUEUE 128
>  
>  #define EQ_SIZE (8 * MANA_PAGE_SIZE)
>  
> @@ -285,7 +297,7 @@ struct mana_recv_buf_oob {
>  	void *buf_va;
>  	bool from_pool; /* allocated from a page pool */
>  
> -	/* SGL of the buffer going to be sent has part of the work request. */
> +	/* SGL of the buffer going to be sent as part of the work request. */
>  	u32 num_sge;
>  	struct gdma_sge sgl[MAX_RX_WQE_SGL_ENTRIES];
>  
> @@ -437,6 +449,9 @@ struct mana_port_context {
>  	unsigned int max_queues;
>  	unsigned int num_queues;
>  
> +	unsigned int rx_queue_size;
> +	unsigned int tx_queue_size;
> +
>  	mana_handle_t port_handle;
>  	mana_handle_t pf_filter_handle;
>  
> @@ -472,6 +487,8 @@ struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
>  void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
>  int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
>  void mana_query_gf_stats(struct mana_port_context *apc);
> +int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu);
> +void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
>  
>  extern const struct ethtool_ops mana_ethtool_ops;
>  
> -- 
> 2.34.1
>

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 

