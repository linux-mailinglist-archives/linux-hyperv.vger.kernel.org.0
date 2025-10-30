Return-Path: <linux-hyperv+bounces-7381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B6C1F2CF
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2219D34CB13
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC253375C2;
	Thu, 30 Oct 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q98e3fyT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A22BFC85;
	Thu, 30 Oct 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815091; cv=none; b=eNL+ENJfAhzBIIgKZif7CjbQes5DkB2DyTaWXQoZwWvQkt9+dsgNspjQTzw3wz9tAr4i6XEKCEtEgiUl917BfRoKPqoQZxqZyymu/RBCphJwj+1SjjVDabqbbT4l8ooCfk+/ffkMv5RMbJGFpEoRF5Chyynsil/cg+hN4kTwlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815091; c=relaxed/simple;
	bh=a4b7pcEFWNkC27iTktg9YRlC8Ldupk1RfbsxDwDDIw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9CYIKPTjvvglnHPQnn4JXD5qICXntaU6kGeVd0ywjrCZPd/CIgGzv1Mj4INo74kOx0cewXg+akRmx9XOK/gCDlCmVdqTvN9DcMzVVnwmbMhn0f5SNtlkkZt/aflf1EznCK/jPlpbuFw919ZW8unmno/tLJMUkcXMbO7AS0o+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q98e3fyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634EFC4CEF1;
	Thu, 30 Oct 2025 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761815090;
	bh=a4b7pcEFWNkC27iTktg9YRlC8Ldupk1RfbsxDwDDIw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q98e3fyT6ngukxgtjVm+ar7nHCpxBlIZIk2KEeSFHwnVYks3ZbRnZHL0eztvAAUEA
	 0iSi5J6F76Od4TT1uhw33Tl+EV7lWdnLApwPBNudO5VjUc3YBIEutO5NRaqOXf55b2
	 zZHwCKYPcpg9KaOFM8HkSNFRCVEdX7ee0WzO15ZWUenZhqS52/+lqNO3vCy7bjQaXY
	 SE/Y6Diryw4u6g4VF61G4gV2RvxOlo5dLnPmg6ok+y6eWcdKHrcee/mgIbDmWP0kvx
	 v1/gDEKmtVSnvmAqEkZPpMWpF3dgl6NaOKU5UBQ/uUijmYGLTKGG4gy9suz4Tk3O6I
	 kZXFtDjE4vPyw==
Date: Thu, 30 Oct 2025 09:04:44 +0000
From: Simon Horman <horms@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
Message-ID: <aQMqLN0FRmNU3_ke@horms.kernel.org>
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Oct 29, 2025 at 06:12:35AM -0700, Aditya Garg wrote:
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

...

> @@ -289,6 +290,21 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	cq = &apc->tx_qp[txq_idx].tx_cq;
>  	tx_stats = &txq->stats;
>  
> +	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
> +	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> +		/* GSO skb with Hardware SGE limit exceeded is not expected here
> +		 * as they are handled in mana_features_check() callback
> +		 */

Hi,

I'm curious to know if we actually need this code.
Are there cases where the mana_features_check() doesn't
handle things and the kernel will reach this line?

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
>  	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
>  	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
>  

...

