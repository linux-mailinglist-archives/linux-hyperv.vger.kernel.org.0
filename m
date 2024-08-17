Return-Path: <linux-hyperv+bounces-2781-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60179554BB
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Aug 2024 03:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B39F1F21E7B
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Aug 2024 01:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D1A4C97;
	Sat, 17 Aug 2024 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6MS3zhy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F804C6C;
	Sat, 17 Aug 2024 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723859888; cv=none; b=g8RQkH5cY8iGacrry3KXPOW7DtG5/tWFDjaEgYfHgqsjWmPJL7O5dESrbJwHgQX4xDQ1mTKtf1kzI2LfE9ulMm5Z6M/Eglm+MDtD2qelbjwIDen+brIVTQarbvl14N8LJpopo2gQG83ZzcQJxPjC3T+xLuNSAY98bvUfXPWKXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723859888; c=relaxed/simple;
	bh=qeg1lNzgCoGHgx7lqLL7Clol+O0nlePey0hI9eo5tck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQPKKWw/UYGVEhS1/OpULnerq38F3cys4vZLqkaY3vrFP4VoHnK97Cyei79bFA5JVsHfCCKXJJuIrRyiydbQzuN1/ll+zGUKhPrHMkYZR+vO/sLa/sZwbgzUQVQMRUXDJyU92g8IRUbzqQfLhUJmMaF+VqRHUP4ko+AlHQKgR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6MS3zhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6546BC32782;
	Sat, 17 Aug 2024 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723859887;
	bh=qeg1lNzgCoGHgx7lqLL7Clol+O0nlePey0hI9eo5tck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R6MS3zhyw3BOOjdZ2XR01k6LCgAYN3e9FdCum/gCdfAoxbtG3nAQOXV6aIY0iR4wJ
	 5gXdmxELH+4G2fOrEQVpdguSg6bQvxvIv3bRDwHMUwcBujB1F0t4XNHrNru0yvEJ4L
	 0AKhJZdegLYZzWhvH588vwLNhdsOnPjhakcEp+rgEkmWEULdutdJ0SvraMhlq80OC7
	 fjoQMz/VodQTPUxju2wUpoWpaN531ebskyXbZud5WmTg58aEVTMwGXUkkufLxzORvx
	 XIhxhxf/fOpT5Q+NkwUNE2FWyU50/FAuu3V9hyQfA1f5Glcet6BGTAKXzJu++nmwfe
	 jzHZYi093XgMw==
Date: Fri, 16 Aug 2024 18:58:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Long Li <longli@microsoft.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Simon Horman <horms@kernel.org>, Konstantin
 Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>,
 Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240816185805.60e16145@kernel.org>
In-Reply-To: <1723805303-11432-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1723805303-11432-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 03:48:23 -0700 Shradha Gupta wrote:
> +	old_tx = apc->tx_queue_size;
> +	old_rx = apc->rx_queue_size;
> +	new_tx = clamp_t(u32, ring->tx_pending, MIN_TX_BUFFERS_PER_QUEUE, MAX_TX_BUFFERS_PER_QUEUE);
> +	new_rx = clamp_t(u32, ring->rx_pending, MIN_RX_BUFFERS_PER_QUEUE, MAX_RX_BUFFERS_PER_QUEUE);

You can min(), the max side of clam is unnecessary. Core code won't let
user requests above max provided by "get" thru.

> +	if (!is_power_of_2(new_tx)) {
> +		netdev_err(ndev, "%s:Tx:%d not supported. Needs to be a power of 2\n",
> +			   __func__, new_tx);
> +		return -EINVAL;
> +	}

The power of 2 vs clamp is a bit odd.
On one hand you clamp the values to what's supported automatically.
On the other you hard reject values which are not power of 2.
Why not round them up?

IDK whether checking or auto-correction is better, but mixing the two
is odd.

> +	if (!is_power_of_2(new_rx)) {
> +		netdev_err(ndev, "%s:Rx:%d not supported. Needs to be a power of 2\n",
> +			   __func__, new_rx);

Instead of printing please use the extack passed in as an argument.
-- 
pw-bot: cr

