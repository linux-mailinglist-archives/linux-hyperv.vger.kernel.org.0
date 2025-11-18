Return-Path: <linux-hyperv+bounces-7673-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE308C672E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 04:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99DBD4E5C0A
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 03:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8BE23BF91;
	Tue, 18 Nov 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpseHyje"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B55149C7B;
	Tue, 18 Nov 2025 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437585; cv=none; b=Pmy+iB5M+oVjFI28FNUz4NrBYhR91OMvnfyjar9lUdMfs+J2k1aKy9irRt72s3qfOqRMc/0QIn4ac3mDrtyj0zw0Oh5TWtZ0YXUHnaajuNyu/rpx2+jIJdA3uAJKS/Ne+IghsSYD9v7UfKJtdGYrXdjSQHdhOKB2PiHk5piY6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437585; c=relaxed/simple;
	bh=NHRSkMrm5VFbMsl0bkTL+ScNduSSSzLnJ9QB5TdsNPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Di01MfONep71AjCMeN+nkdhAasvqfLbT26nFCU/aJGPashHThEr7s8UZO/5RaiHWmSyrpbCp43Cw5ma0PQ+HgBNUwy4GkgqT1+E/BmHyX1Z0S7pPDG3cZ+PbL5XM35KSDXOC0B5USPf4/BVfs7LLL2aF+G2nxfeOmkZT8gHICxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpseHyje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2BCC19421;
	Tue, 18 Nov 2025 03:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763437583;
	bh=NHRSkMrm5VFbMsl0bkTL+ScNduSSSzLnJ9QB5TdsNPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BpseHyjekH5vSE9flw1mzQvP746Mk/APq+6hu7nBut8ov+sV78qvwawpqfT3uExgQ
	 /3QGYV1Xvp4ChvQwuWXehHCkejVrxTFp5/t6tsEKvTZQb5ImyvkxXVAo10zA/WFWdv
	 im5nUZDjtUYpOVzX0Hohq9Q5CZfaPVXnbrlKOeGyS3yLa4EMCEmwicwH7duRwExYe0
	 TXyQxVjmzkyVbx26I7otc/RGCbZXVouRmmRAN709hqBYg3whiN1eX6yU7YWI7VgDkf
	 9Q+AmrYbyP78jaxr3vHgyzKx3fUeLXdwrwV13pfsHAN0ekCpDwqetHU9s/u+6pI80A
	 v4aOlvSF4RxFA==
Date: Mon, 17 Nov 2025 19:46:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, sbhatta@marvell.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com
Subject: Re: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
Message-ID: <20251117194618.33af8e98@kernel.org>
In-Reply-To: <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
	<1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 13:16:42 -0800 Aditya Garg wrote:
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. Exceeding this limit can cause TX failures.
> Add ndo_features_check() callback to validate SKB layout before
> transmission. For GSO SKBs that would exceed the hardware SGE limit, clear
> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
> exceed the SGE limit.

> +	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
> +#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> +	if (skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {

nit: please try to avoid the use of ifdef if you can. This helps to
avoid build breakage sneaking in as this code will be compiled out
on default config on all platforms.

Instead you should be able to simply add the static condition to the
if statement:

	if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES &&
	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {

and let the compiler (rather than preprocessor) eliminate this if ()
block.

> +		/* GSO skb with Hardware SGE limit exceeded is not expected here
> +		 * as they are handled in mana_features_check() callback
> +		 */
> +		if (skb_linearize(skb)) {
> +			netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
> +					 skb_shinfo(skb)->nr_frags,
> +					 skb_is_gso(skb));
> +			goto tx_drop_count;
> +		}
> +		apc->eth_stats.linear_pkt_tx_cnt++;
> +	}
> +#endif
-- 
pw-bot: cr

