Return-Path: <linux-hyperv+bounces-7335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031DC0E04E
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 14:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8086E1893E89
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CE28727B;
	Mon, 27 Oct 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d6fN207m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD721C9EA;
	Mon, 27 Oct 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571701; cv=none; b=ooOuF7ZNZv+ZqwiEraMHV6RWmfJ9Kv50A7x6pww35LlCyCAyr3f6qAT/7ECt5FRnC5Nf63UE+DbrLc0ktNss3EEuihtmDhdnyqOsfTYejbr3jruzO3msnBNSICWH4GB6wIRAqndiqH7dAnLpaE/MkwkApAKxm3K9+RRkRQbPTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571701; c=relaxed/simple;
	bh=WudvgY1+NjctXdMFJHM6T8W8YrXJqyy7iGoNT8yrPsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l/Gz+//YKjVqNUuNTqIlSwaV+xMp4OKesHw278tKag4AMm/Np9Lm+xZj/ydKux0CdBhMwbyFvsh/vOOMU2/nEzdM2rBIfuZMtOx3WtmaC2XTt2IHAhJx39ZCGhdqiV1fGO78NRSW1PsvvnkI/QwYilaY+qmWELHYH3CbWSgyGZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d6fN207m; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.19] (unknown [103.212.145.71])
	by linux.microsoft.com (Postfix) with ESMTPSA id 526B7201DAF0;
	Mon, 27 Oct 2025 06:28:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 526B7201DAF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761571697;
	bh=cdvGXmO2QhPla821CybL9Si45ofFWbVC4LfOQsMFj4M=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=d6fN207msQ5TU0EcZZghd6EkMO2qi3psIqq91l5JK347j/AEaxlZMFpvt6TuRON4g
	 AwIE33ZKEPdEQAflk3nwUNUliEfXfCXWyx6hCE1ZYqd8jP9qyZi8Q9F8xUvnqfnWoi
	 1l2OhBK3JOFd6E/+2ttWHGmdwevpOZv3EA93eqCU=
Message-ID: <788b4f16-2627-45d5-a23c-b69cbdc7bbac@linux.microsoft.com>
Date: Mon, 27 Oct 2025 18:58:09 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com
References: <20251022204325.GA18380@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20251022204325.GA18380@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23-10-2025 02:13, Aditya Garg wrote:
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. Exceeding this limit can cause TX failures.
> Add ndo_features_check() callback to validate SKB layout before
> transmission. For GSO SKBs that would exceed the hardware SGE limit, clear
> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
> exceed the SGE limit.
> 
> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
> send other errors to free_sgl_ptr to free resources and record the tx
> drop.
> 
> Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 48 +++++++++++++++++--
>   include/net/mana/gdma.h                       |  6 ++-
>   include/net/mana/mana.h                       |  1 +
>   3 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 0142fd98392c..8e23a87a779d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -11,6 +11,7 @@
>   #include <linux/mm.h>
>   #include <linux/pci.h>
>   #include <linux/export.h>
> +#include <linux/skbuff.h>
>   
>   #include <net/checksum.h>
>   #include <net/ip6_checksum.h>
> @@ -289,6 +290,21 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   	cq = &apc->tx_qp[txq_idx].tx_cq;
>   	tx_stats = &txq->stats;
>   
> +	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
> +	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> +		/* GSO skb with Hardware SGE limit exceeded is not expected here
> +		 * as they are handled in mana_features_check() callback
> +		 */
> +		if (skb_is_gso(skb))
> +			netdev_warn_once(ndev, "GSO enabled skb exceeds max SGE limit\n");
> +		if (skb_linearize(skb)) {
> +			netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
> +					 skb_shinfo(skb)->nr_frags,
> +					 skb_is_gso(skb));
> +			goto tx_drop_count;
> +		}
> +	}
> +
>   	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
>   	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
>   
> @@ -402,8 +418,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   		}
>   	}
>   
> -	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
> -
>   	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
>   		pkg.wqe_req.sgl = pkg.sgl_array;
>   	} else {
> @@ -438,9 +452,13 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   
>   	if (err) {
>   		(void)skb_dequeue_tail(&txq->pending_skbs);
> +		mana_unmap_skb(skb, apc);
>   		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
> -		err = NETDEV_TX_BUSY;
> -		goto tx_busy;
> +		if (err == -ENOSPC) {
> +			err = NETDEV_TX_BUSY;
> +			goto tx_busy;
> +		}
> +		goto free_sgl_ptr;
>   	}
>   
>   	err = NETDEV_TX_OK;
> @@ -478,6 +496,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   	return NETDEV_TX_OK;
>   }
>   
> +static netdev_features_t mana_features_check(struct sk_buff *skb,
> +					     struct net_device *ndev,
> +					     netdev_features_t features)
> +{
> +	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
> +	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> +		/* Exceeds HW SGE limit.
> +		 * GSO case:
> +		 *   Disable GSO so the stack will software-segment the skb
> +		 *   into smaller skbs that fit the SGE budget.
> +		 * Non-GSO case:
> +		 *   The xmit path will attempt skb_linearize() as a fallback.
> +		 */
> +		if (skb_is_gso(skb))
> +			features &= ~NETIF_F_GSO_MASK;
> +	}
> +	return features;
> +}
> +
>   static void mana_get_stats64(struct net_device *ndev,
>   			     struct rtnl_link_stats64 *st)
>   {
> @@ -838,6 +875,7 @@ static const struct net_device_ops mana_devops = {
>   	.ndo_open		= mana_open,
>   	.ndo_stop		= mana_close,
>   	.ndo_select_queue	= mana_select_queue,
> +	.ndo_features_check	= mana_features_check,
>   	.ndo_start_xmit		= mana_start_xmit,
>   	.ndo_validate_addr	= eth_validate_addr,
>   	.ndo_get_stats64	= mana_get_stats64,
> @@ -1606,7 +1644,7 @@ static int mana_move_wq_tail(struct gdma_queue *wq, u32 num_units)
>   	return 0;
>   }
>   
> -static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
> +void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
>   {
>   	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
>   	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 57df78cfbf82..b35ecc58fbab 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -591,6 +591,9 @@ enum {
>   /* Driver can self reset on FPGA Reconfig EQE notification */
>   #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
>   
> +/* Driver supports linearizing the skb when num_sge exceeds hardware limit */
> +#define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
> +
>   #define GDMA_DRV_CAP_FLAGS1 \
>   	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>   	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> @@ -599,7 +602,8 @@ enum {
>   	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
>   	 GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
>   	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
> -	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
> +	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
> +	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE)
>   
>   #define GDMA_DRV_CAP_FLAGS2 0
>   
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 0921485565c0..330e1bb088bb 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -580,6 +580,7 @@ int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
>   void mana_query_phy_stats(struct mana_port_context *apc);
>   int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
>   void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
> +void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc);
>   
>   extern const struct ethtool_ops mana_ethtool_ops;
>   extern struct dentry *mana_debugfs_root;
Hi Eric,

I hope this approach is okay. If there are no issues, I'll go ahead and 
send the patch for final review.
Let me know if you need more time for this RFC.

Regards,
Aditya

