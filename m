Return-Path: <linux-hyperv+bounces-2822-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF295CB7D
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA30286BFF
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B36518757A;
	Fri, 23 Aug 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OhE+8gqW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E633718754D;
	Fri, 23 Aug 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412903; cv=none; b=DAngEixBnfOAtlDK0NPylS3Yw+7JaWZ+Vvg0vv17uQOHVi7lq5WZElRYM4u8wyLPQ8C7EU8Ag+AZQElTaG8A01Q3gX/b+8MlK7WOVylRrfYDGe64YIJr85Ic47FhwH62gm0HlSfv+sT5JQTossXO9RGZzMY0Q0u1nYiAOp3u0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412903; c=relaxed/simple;
	bh=9R2mJ0I2W4Jg0eX289L1crbEK1ixUyDsCm8CGXoE+6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXVhpzMGXP89p2aubkJLRH6V/wUKr7fFzfZNjHE/03ffLnAYZm25sgsN2qcf421CisLzs1ITKG1rsf0LCVfu5O1R4QfiyVq51WqxVcmZaiYJ3aJC2hzTBzqxVt9SOXyBBMp3pbhnQgi55gd3OBC4B2GkGHebw1Y+wJ1gXSHlt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OhE+8gqW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id AFA2320B7165; Fri, 23 Aug 2024 04:34:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFA2320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724412894;
	bh=t6F22ENG7oMrjtzknISNkxqdGQEbmc77F64buEWPpTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhE+8gqWjd1EvBSzy9x6MExjxZESBWhqcMpXDv5SWNKB+WPKukJp7V3tK/6cImItY
	 ctwOFybVFq/eKOfLUr2PcJmGFfKkCSKj/eYzSRM6aHHtjnjOGHTAvK4Sik3yA36Gre
	 i+q+ZRmAXUkngsUWCVxOnpWqAQWMNz91+WJjOWXM=
Date: Fri, 23 Aug 2024 04:34:54 -0700
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
Subject: Re: [PATCH net-next v4] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240823113454.GA24427@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1724341989-27612-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724341989-27612-1-git-send-email-shradhagupta@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 22, 2024 at 08:53:09AM -0700, Shradha Gupta wrote:
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
>  Changes in v4:
>  * Roundup the ring parameter value to a power of 2
>  * Skip the max value check for parameters
>  * Use extack to log errors
> ---
>  Changes in v3:
>  * pre-allocate buffers before changing the queue sizes
>  * rebased to latest net-next
> ---
>  Changes in v2:
>  * Removed unnecessary validations in mana_set_ringparam()
>  * Fixed codespell error
>  * Improved error message to indicate issue with the parameter
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 24 +++---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 74 +++++++++++++++++++
>  include/net/mana/mana.h                       | 23 +++++-
>  3 files changed, 108 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d2f07e179e86..4e3ade5926bc 100644
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
> @@ -1899,14 +1899,15 @@ static int mana_create_txq(struct mana_port_context *apc,
>  		return -ENOMEM;
>  
>  	/*  The minimum size of the WQE is 32 bytes, hence
> -	 *  MAX_SEND_BUFFERS_PER_QUEUE represents the maximum number of WQEs
> +	 *  apc->tx_queue_size represents the maximum number of WQEs
>  	 *  the SQ can store. This value is then used to size other queues
>  	 *  to prevent overflow.
> +	 *  Also note that the txq_size is always going to be MANA_PAGE_ALIGNED,
> +	 *  as tx_queue_size is always a power of 2.
>  	 */

	MANA_PAGE_ALIGNED aligned means aligned by 0x1000. tx_queue_size being
	'power of 2' * 32 is not a sufficient condition for it to be aligned to
	0x1000. We possibly can explain more.


> -	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
> -	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
> +	txq_size = apc->tx_queue_size * 32;
>  
> -	cq_size = MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
> +	cq_size = apc->tx_queue_size * COMP_ENTRY_SIZE;
>  	cq_size = MANA_PAGE_ALIGN(cq_size);

	COMP_ENTRY_SIZE is 64, that means cq_size is double of txq_size.
	If we are certain that txq_size is always aligned to MANA_PAGE,
	that means cq_size is already aligned to MANA_PAGE as well.

- Saurabh

