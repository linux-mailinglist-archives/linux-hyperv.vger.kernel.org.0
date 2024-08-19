Return-Path: <linux-hyperv+bounces-2782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E35956F0B
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Aug 2024 17:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E697E1C2306E
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Aug 2024 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC9762171;
	Mon, 19 Aug 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b8MxMJD1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F284A51;
	Mon, 19 Aug 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082086; cv=none; b=g3XC50mshoklOd1FQz16jQB+JlPS0VFSwMJ6m3lXst8fvnLOaU+g1bAi6GBOtipp8QiHM6F+nWFdRJ/251o8l2S0WrJ+rMRf+4QtnMBsr9jkEEeW5oayY9LYQfMiNNAEMAodsZK19n1RLtMc8eAM+uh2AMUNEVmeKtnL7SMfSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082086; c=relaxed/simple;
	bh=XD2K26LZWwKLrIemj7ZsxfN1QcYSugiu7qjybcqgCNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0C8FVGM/YEa0LGO9E3rBVzn6Tq0DPUmdvnBXoA+1NAHrC+GhBnaQ70jLFprhhkstnqFy4vXjb5uUrTHmdZi8gTWoBFGjy9ybSyewXOSvCKeyXLU6YL/nQaoetJhzY5rkk//k2Ht1TLN1/fWlx1GnMA9j1HGQzMuUT0QM12pQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b8MxMJD1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 19B1D20B7165; Mon, 19 Aug 2024 08:41:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19B1D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724082085;
	bh=SpSY08sT3dqfME7HAoWcv4Xyv5WInKZ5tv4jgeOIcRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8MxMJD19GNqtDWDIZ9mi8cG3mqVFeE6jipZjQqDQXtV5n4+YLmoQY6OBt+mEq9xP
	 3bmrNsCl9+mrehUGHcpbOFIQBsjQrxFGdBKB1zNRaOk4tbkBlKdKvVJkDqY59viSPi
	 qiFx1f0eB7qOkQx/AzNBMWOwuIYNT0glT9vBBt7Q=
Date: Mon, 19 Aug 2024 08:41:25 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240819154125.GA22003@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1723805303-11432-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240816185805.60e16145@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816185805.60e16145@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Aug 16, 2024 at 06:58:05PM -0700, Jakub Kicinski wrote:
> On Fri, 16 Aug 2024 03:48:23 -0700 Shradha Gupta wrote:
> > +	old_tx = apc->tx_queue_size;
> > +	old_rx = apc->rx_queue_size;
> > +	new_tx = clamp_t(u32, ring->tx_pending, MIN_TX_BUFFERS_PER_QUEUE, MAX_TX_BUFFERS_PER_QUEUE);
> > +	new_rx = clamp_t(u32, ring->rx_pending, MIN_RX_BUFFERS_PER_QUEUE, MAX_RX_BUFFERS_PER_QUEUE);
> 
> You can min(), the max side of clam is unnecessary. Core code won't let
> user requests above max provided by "get" thru.
>
oh okay, got it. Will change this 
> > +	if (!is_power_of_2(new_tx)) {
> > +		netdev_err(ndev, "%s:Tx:%d not supported. Needs to be a power of 2\n",
> > +			   __func__, new_tx);
> > +		return -EINVAL;
> > +	}
> 
> The power of 2 vs clamp is a bit odd.
> On one hand you clamp the values to what's supported automatically.
> On the other you hard reject values which are not power of 2.
> Why not round them up?
> 
> IDK whether checking or auto-correction is better, but mixing the two
> is odd.
> 
That seems right. I will round up the value to nearest power of two, in
the range. Thanks
> > +	if (!is_power_of_2(new_rx)) {
> > +		netdev_err(ndev, "%s:Rx:%d not supported. Needs to be a power of 2\n",
> > +			   __func__, new_rx);
> 
> Instead of printing please use the extack passed in as an argument.
sure, working on it.
> -- 
> pw-bot: cr

