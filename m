Return-Path: <linux-hyperv+bounces-5860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D1AD5364
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 13:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77EF61C2372D
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7D276054;
	Wed, 11 Jun 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UMo9AtHj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3C2528F3;
	Wed, 11 Jun 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639834; cv=none; b=OCf88kY1uvjOItNSlw40x4iEZmiUctBHWAQpo615fXOwgXjsz057dSxsqrfJhZKgpnznIcfSsyVqmKAXD/gdNlTS2lKo8CPVPJsIdEGLq7weqKEQcH+sQFN/i3nxxoMoSUioqR+OM7tviov9ITKacpIVAgZvAZ6lzK9MxGN2TsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639834; c=relaxed/simple;
	bh=nTdr2YuMMa9V0HwwyZrdkmee+oPqvCIbhsYJD8YpNCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSj3prEMYR8K8+nFYjtilP8gq5HTBp98aH0b5vuUZe7NqTYQvBu+cbleeeLS4OIECzfUNM/e7C9FpiHvP2EufjXLlJWR79k1766tB2B9S4UBQYLLQ91CH47aDpp582XwVt8OKf9vA9YLV9mqeD/5lzq1I9EU+s8ztWfQWP56134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UMo9AtHj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id BDB112115190; Wed, 11 Jun 2025 04:03:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDB112115190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749639832;
	bh=2AMfXxOQB+XCP0ckN4VqEkyDLcKkN5LJc6Z0NVpoSTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMo9AtHji3Jd8ZjOC5cnzWJLB4OJdOfQAfsk66I39FJiMYpPLiOKcWXa0LwjlPy+X
	 sOOjO6FrPsD81XWVT4M/cu8CQQ6hjbgSdqgUQf9k0Uh9mL5X9DExAn4euEY0Qw47lV
	 YXQFTRjrR7EpqTzhblnZzn5YUM1oc995+nz1Lb0M=
Date: Wed, 11 Jun 2025 04:03:52 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kotaranov@microsoft.com, longli@microsoft.com, horms@kernel.org,
	shirazsaleem@microsoft.com, leon@kernel.org,
	shradhagupta@linux.microsoft.com, schakrabarti@linux.microsoft.com,
	rosenp@gmail.com, sdf@fomichev.me, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: mana: Fix potential deadlocks in mana
 napi ops
Message-ID: <20250611110352.GA31913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
 <1749631576-2517-2-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749631576-2517-2-git-send-email-ernis@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 11, 2025 at 01:46:13AM -0700, Erni Sri Satya Vennela wrote:
> When net_shaper_ops are enabled for MANA, netdev_ops_lock
> becomes active.
> 
> The netvsc sets up MANA VF via following call chain:
> 
> netvsc_vf_setup()
>         dev_change_flags()
> 		...
>          __dev_open() OR __dev_close()
> 
> dev_change_flags() holds the netdev mutex via netdev_lock_ops.
> 
> During this process, mana_create_txq() and mana_create_rxq()
> invoke netif_napi_add_tx(), netif_napi_add_weight(), and napi_enable(),
> all of which attempt to acquire the same lock,
> leading to a potential deadlock.

commit message could be better oriented.

> 
> Similarly, mana_destroy_txq() and mana_destroy_rxq() call
> netif_napi_disable() and netif_napi_del(), which also contend
> for the same lock.
> 
> Switch to the _locked variants of these APIs to avoid deadlocks
> when the netdev_ops_lock is held.
> 
> Fixes: d4c22ec680c8 ("net: hold netdev instance lock during ndo_open/ndo_stop")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 39 ++++++++++++++-----
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index ccd2885c939e..3c879d8a39e3 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1911,8 +1911,13 @@ static void mana_destroy_txq(struct mana_port_context *apc)
>  		napi = &apc->tx_qp[i].tx_cq.napi;
>  		if (apc->tx_qp[i].txq.napi_initialized) {
>  			napi_synchronize(napi);
> -			napi_disable(napi);
> -			netif_napi_del(napi);
> +			if (netdev_need_ops_lock(napi->dev)) {
> +				napi_disable_locked(napi);
> +				netif_napi_del_locked(napi);
> +			} else {
> +				napi_disable(napi);
> +				netif_napi_del(napi);
> +			}

Instead of using if-else, we can used netdev_lock_ops(), followed by *_locked api-s.
Same for rest of the patch.

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh


