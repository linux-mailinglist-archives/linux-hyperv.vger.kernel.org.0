Return-Path: <linux-hyperv+bounces-2261-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02018D4E64
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C741F227CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D931117D880;
	Thu, 30 May 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6AILQ/O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B317C230;
	Thu, 30 May 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080623; cv=none; b=kEqjWwHnIiRkSnXnApi0F9w/wi8sC5n6zqZ1lBE/fjO1M2WdS94MHGu4ktI8S7DUJMOowqWyu1rAKJ5BSh0rLdvxGN1Y/+AM7hOnrBe/7UnRKqquOyZbnVNr/3VNsM+CQOgeyE07fOC9XkDyUHcQVTf456gwgcu60xF5Yyfn4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080623; c=relaxed/simple;
	bh=uoEbranSexhBtM6sYAMs71WXTST/7oP3dHBpmZCNSSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMhy9B6vi6D01iiQriArq9t8gcvKRspHePpE/GPGaHixN5cIO8AnpKLyp/xImm+vQJ1Cj+rajTepjCbCcmvXPI0i7gX7h+sUFZ/9fmu756ZekEnh74e51CKOSnERIkPWt7QTr/cPNtYjFumoPLBMZcvE+sEbAZXG395LxvJGddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6AILQ/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D868C32782;
	Thu, 30 May 2024 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080623;
	bh=uoEbranSexhBtM6sYAMs71WXTST/7oP3dHBpmZCNSSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6AILQ/OdhAbCH4bCBit0p0BJgPiu8NdjtZGt4cN13QHqY+k8paEepb7us8U+yIQA
	 tEPcDbz0YnudqHHeljeQOGXBuz0UMIyo+Id7M5dO5thxYcPMKFlWp9o9dkB/9xs/Sh
	 dgUlHtdDzN6cu2Pep8tlaN/Nra7aGNqrrhbwqXfB/8Y7ukmO+cj1UyHxTqpRtQMCWG
	 lheAap6ieLzYtSNniRIWFvuOCa5znKmuY+eMiVGStDSlba1vlfczmdL/y5tUtsxGQD
	 FlhdrdVVUvju4MTFUTF62T2bDxIcQgyvdUk0e0cLLv3VOWOze4izw5E5gm3rd0RYvc
	 uC7nkxRG4ZrJg==
Date: Thu, 30 May 2024 17:37:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v2] net: mana: Allow variable size indirection
 table
Message-ID: <20240530143702.GB3884@unreal>
References: <1716960955-3195-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716960955-3195-1-git-send-email-shradhagupta@linux.microsoft.com>

On Tue, May 28, 2024 at 10:35:55PM -0700, Shradha Gupta wrote:
> Allow variable size indirection table allocation in MANA instead
> of using a constant value MANA_INDIRECT_TABLE_SIZE.
> The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> indirection table is allocated dynamically.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v2:
>  * Rebased to latest net-next tree
>  * Rearranged cleanup code in mana_probe_port to avoid extra operations
> ---
>  drivers/infiniband/hw/mana/qp.c               | 10 +--

Jakub,

Once you are ok with this patch, let me create shared branch for it.
It is -rc1 and Konstantin already submitted some changes to qp.c
https://lore.kernel.org/all/1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com/

This specific patch applies on top of Konstantin's changes cleanly.

Thanks

>  drivers/net/ethernet/microsoft/mana/mana_en.c | 68 ++++++++++++++++---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 20 ++++--
>  include/net/mana/gdma.h                       |  4 +-
>  include/net/mana/mana.h                       |  9 +--
>  5 files changed, 84 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index ba13c5abf8ef..2d411a16a127 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -21,7 +21,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  
>  	gc = mdev_to_gc(dev);
>  
> -	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_SIZE);
> +	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_DEF_SIZE);
>  	req = kzalloc(req_buf_size, GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> @@ -41,18 +41,18 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  	if (log_ind_tbl_size)
>  		req->rss_enable = true;
>  
> -	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
> +	req->num_indir_entries = MANA_INDIRECT_TABLE_DEF_SIZE;
>  	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
>  					 indir_tab);
>  	req->update_indir_tab = true;
>  	req->cqe_coalescing_enable = 1;
>  
>  	/* The ind table passed to the hardware must have
> -	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
> +	 * MANA_INDIRECT_TABLE_DEF_SIZE entries. Adjust the verb
>  	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
>  	 */
>  	ibdev_dbg(&dev->ib_dev, "ind table size %u\n", 1 << log_ind_tbl_size);
> -	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
> +	for (i = 0; i < MANA_INDIRECT_TABLE_DEF_SIZE; i++) {
>  		req->indir_tab[i] = ind_table[i % (1 << log_ind_tbl_size)];
>  		ibdev_dbg(&dev->ib_dev, "index %u handle 0x%llx\n", i,
>  			  req->indir_tab[i]);
> @@ -137,7 +137,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  	}
>  
>  	ind_tbl_size = 1 << ind_tbl->log_ind_tbl_size;
> -	if (ind_tbl_size > MANA_INDIRECT_TABLE_SIZE) {
> +	if (ind_tbl_size > MANA_INDIRECT_TABLE_DEF_SIZE) {
>  		ibdev_dbg(&mdev->ib_dev,
>  			  "Indirect table size %d exceeding limit\n",
>  			  ind_tbl_size);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d087cf954f75..851e1b9761b3 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -481,7 +481,7 @@ static int mana_get_tx_queue(struct net_device *ndev, struct sk_buff *skb,
>  	struct sock *sk = skb->sk;
>  	int txq;
>  
> -	txq = apc->indir_table[hash & MANA_INDIRECT_TABLE_MASK];
> +	txq = apc->indir_table[hash & (apc->indir_table_sz - 1)];
>  
>  	if (txq != old_q && sk && sk_fullsock(sk) &&
>  	    rcu_access_pointer(sk->sk_dst_cache))
> @@ -962,7 +962,16 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
>  
>  	*max_sq = resp.max_num_sq;
>  	*max_rq = resp.max_num_rq;
> -	*num_indir_entry = resp.num_indirection_ent;
> +	if (resp.num_indirection_ent > 0 &&
> +	    resp.num_indirection_ent <= MANA_INDIRECT_TABLE_MAX_SIZE &&
> +	    is_power_of_2(resp.num_indirection_ent)) {
> +		*num_indir_entry = resp.num_indirection_ent;
> +	} else {
> +		netdev_warn(apc->ndev,
> +			    "Setting indirection table size to default %d for vPort %d\n",
> +			    MANA_INDIRECT_TABLE_DEF_SIZE, apc->port_idx);
> +		*num_indir_entry = MANA_INDIRECT_TABLE_DEF_SIZE;
> +	}
>  
>  	apc->port_handle = resp.vport;
>  	ether_addr_copy(apc->mac_addr, resp.mac_addr);
> @@ -1054,14 +1063,13 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  				   bool update_default_rxobj, bool update_key,
>  				   bool update_tab)
>  {
> -	u16 num_entries = MANA_INDIRECT_TABLE_SIZE;
>  	struct mana_cfg_rx_steer_req_v2 *req;
>  	struct mana_cfg_rx_steer_resp resp = {};
>  	struct net_device *ndev = apc->ndev;
>  	u32 req_buf_size;
>  	int err;
>  
> -	req_buf_size = struct_size(req, indir_tab, num_entries);
> +	req_buf_size = struct_size(req, indir_tab, apc->indir_table_sz);
>  	req = kzalloc(req_buf_size, GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> @@ -1072,7 +1080,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  	req->hdr.req.msg_version = GDMA_MESSAGE_V2;
>  
>  	req->vport = apc->port_handle;
> -	req->num_indir_entries = num_entries;
> +	req->num_indir_entries = apc->indir_table_sz;
>  	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
>  					 indir_tab);
>  	req->rx_enable = rx;
> @@ -1111,7 +1119,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  	}
>  
>  	netdev_info(ndev, "Configured steering vPort %llu entries %u\n",
> -		    apc->port_handle, num_entries);
> +		    apc->port_handle, apc->indir_table_sz);
>  out:
>  	kfree(req);
>  	return err;
> @@ -2344,11 +2352,33 @@ static int mana_create_vport(struct mana_port_context *apc,
>  	return mana_create_txq(apc, net);
>  }
>  
> +static int mana_rss_table_alloc(struct mana_port_context *apc)
> +{
> +	if (!apc->indir_table_sz) {
> +		netdev_err(apc->ndev,
> +			   "Indirection table size not set for vPort %d\n",
> +			   apc->port_idx);
> +		return -EINVAL;
> +	}
> +
> +	apc->indir_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
> +	if (!apc->indir_table)
> +		return -ENOMEM;
> +
> +	apc->rxobj_table = kcalloc(apc->indir_table_sz, sizeof(mana_handle_t), GFP_KERNEL);
> +	if (!apc->rxobj_table) {
> +		kfree(apc->indir_table);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  static void mana_rss_table_init(struct mana_port_context *apc)
>  {
>  	int i;
>  
> -	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> +	for (i = 0; i < apc->indir_table_sz; i++)
>  		apc->indir_table[i] =
>  			ethtool_rxfh_indir_default(i, apc->num_queues);
>  }
> @@ -2361,7 +2391,7 @@ int mana_config_rss(struct mana_port_context *apc, enum TRI_STATE rx,
>  	int i;
>  
>  	if (update_tab) {
> -		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
> +		for (i = 0; i < apc->indir_table_sz; i++) {
>  			queue_idx = apc->indir_table[i];
>  			apc->rxobj_table[i] = apc->rxqs[queue_idx]->rxobj;
>  		}
> @@ -2466,7 +2496,6 @@ static int mana_init_port(struct net_device *ndev)
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  	u32 max_txq, max_rxq, max_queues;
>  	int port_idx = apc->port_idx;
> -	u32 num_indirect_entries;
>  	int err;
>  
>  	err = mana_init_port_context(apc);
> @@ -2474,7 +2503,7 @@ static int mana_init_port(struct net_device *ndev)
>  		return err;
>  
>  	err = mana_query_vport_cfg(apc, port_idx, &max_txq, &max_rxq,
> -				   &num_indirect_entries);
> +				   &apc->indir_table_sz);
>  	if (err) {
>  		netdev_err(ndev, "Failed to query info for vPort %d\n",
>  			   port_idx);
> @@ -2723,6 +2752,10 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	if (err)
>  		goto free_net;
>  
> +	err = mana_rss_table_alloc(apc);
> +	if (err)
> +		goto reset_apc;
> +
>  	netdev_lockdep_set_classes(ndev);
>  
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> @@ -2739,11 +2772,17 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  	err = register_netdev(ndev);
>  	if (err) {
>  		netdev_err(ndev, "Unable to register netdev.\n");
> -		goto reset_apc;
> +		goto free_indir;
>  	}
>  
>  	return 0;
>  
> +free_indir:
> +	apc->indir_table_sz = 0;
> +	kfree(apc->indir_table);
> +	apc->indir_table = NULL;
> +	kfree(apc->rxobj_table);
> +	apc->rxobj_table = NULL;
>  reset_apc:
>  	kfree(apc->rxqs);
>  	apc->rxqs = NULL;
> @@ -2897,6 +2936,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  {
>  	struct gdma_context *gc = gd->gdma_context;
>  	struct mana_context *ac = gd->driver_data;
> +	struct mana_port_context *apc;
>  	struct device *dev = gc->dev;
>  	struct net_device *ndev;
>  	int err;
> @@ -2908,6 +2948,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  
>  	for (i = 0; i < ac->num_ports; i++) {
>  		ndev = ac->ports[i];
> +		apc = netdev_priv(ndev);
>  		if (!ndev) {
>  			if (i == 0)
>  				dev_err(dev, "No net device to remove\n");
> @@ -2931,6 +2972,11 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  		}
>  
>  		unregister_netdevice(ndev);
> +		apc->indir_table_sz = 0;
> +		kfree(apc->indir_table);
> +		apc->indir_table = NULL;
> +		kfree(apc->rxobj_table);
> +		apc->rxobj_table = NULL;
>  
>  		rtnl_unlock();
>  
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index ab2413d71f6c..1667f18046d2 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -245,7 +245,9 @@ static u32 mana_get_rxfh_key_size(struct net_device *ndev)
>  
>  static u32 mana_rss_indir_size(struct net_device *ndev)
>  {
> -	return MANA_INDIRECT_TABLE_SIZE;
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +
> +	return apc->indir_table_sz;
>  }
>  
>  static int mana_get_rxfh(struct net_device *ndev,
> @@ -257,7 +259,7 @@ static int mana_get_rxfh(struct net_device *ndev,
>  	rxfh->hfunc = ETH_RSS_HASH_TOP; /* Toeplitz */
>  
>  	if (rxfh->indir) {
> -		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> +		for (i = 0; i < apc->indir_table_sz; i++)
>  			rxfh->indir[i] = apc->indir_table[i];
>  	}
>  
> @@ -273,8 +275,8 @@ static int mana_set_rxfh(struct net_device *ndev,
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  	bool update_hash = false, update_table = false;
> -	u32 save_table[MANA_INDIRECT_TABLE_SIZE];
>  	u8 save_key[MANA_HASH_KEY_SIZE];
> +	u32 *save_table;
>  	int i, err;
>  
>  	if (!apc->port_is_up)
> @@ -284,13 +286,17 @@ static int mana_set_rxfh(struct net_device *ndev,
>  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
>  
> +	save_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
> +	if (!save_table)
> +		return -ENOMEM;
> +
>  	if (rxfh->indir) {
> -		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> +		for (i = 0; i < apc->indir_table_sz; i++)
>  			if (rxfh->indir[i] >= apc->num_queues)
>  				return -EINVAL;
>  
>  		update_table = true;
> -		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
> +		for (i = 0; i < apc->indir_table_sz; i++) {
>  			save_table[i] = apc->indir_table[i];
>  			apc->indir_table[i] = rxfh->indir[i];
>  		}
> @@ -306,7 +312,7 @@ static int mana_set_rxfh(struct net_device *ndev,
>  
>  	if (err) { /* recover to original values */
>  		if (update_table) {
> -			for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> +			for (i = 0; i < apc->indir_table_sz; i++)
>  				apc->indir_table[i] = save_table[i];
>  		}
>  
> @@ -316,6 +322,8 @@ static int mana_set_rxfh(struct net_device *ndev,
>  		mana_config_rss(apc, TRI_STATE_TRUE, update_hash, update_table);
>  	}
>  
> +	kfree(save_table);
> +
>  	return err;
>  }
>  
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 27684135bb4d..c547756c4284 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -543,11 +543,13 @@ enum {
>   */
>  #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)
>  #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
> +#define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
>  
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>  	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> -	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG)
> +	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
> +	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
>  
>  #define GDMA_DRV_CAP_FLAGS2 0
>  
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 561f6719fb4e..59823901b74f 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -30,8 +30,8 @@ enum TRI_STATE {
>  };
>  
>  /* Number of entries for hardware indirection table must be in power of 2 */
> -#define MANA_INDIRECT_TABLE_SIZE 64
> -#define MANA_INDIRECT_TABLE_MASK (MANA_INDIRECT_TABLE_SIZE - 1)
> +#define MANA_INDIRECT_TABLE_MAX_SIZE 512
> +#define MANA_INDIRECT_TABLE_DEF_SIZE 64
>  
>  /* The Toeplitz hash key's length in bytes: should be multiple of 8 */
>  #define MANA_HASH_KEY_SIZE 40
> @@ -410,10 +410,11 @@ struct mana_port_context {
>  	struct mana_tx_qp *tx_qp;
>  
>  	/* Indirection Table for RX & TX. The values are queue indexes */
> -	u32 indir_table[MANA_INDIRECT_TABLE_SIZE];
> +	u32 *indir_table;
> +	u32 indir_table_sz;
>  
>  	/* Indirection table containing RxObject Handles */
> -	mana_handle_t rxobj_table[MANA_INDIRECT_TABLE_SIZE];
> +	mana_handle_t *rxobj_table;
>  
>  	/*  Hash key used by the NIC */
>  	u8 hashkey[MANA_HASH_KEY_SIZE];
> -- 
> 2.34.1
> 

