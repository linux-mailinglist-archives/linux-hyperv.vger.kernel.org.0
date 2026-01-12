Return-Path: <linux-hyperv+bounces-8221-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6411ED12B31
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 14:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15183011FBC
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85A3587D5;
	Mon, 12 Jan 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WMi/luJo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588B358D20;
	Mon, 12 Jan 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223359; cv=none; b=f5Hw0BylCGxMHN9/196/YVei5vNOVzneoK3BzXTGREwyeKGuOLhMbEYkel4D8RFXQKWbHZSSNh36dfCWZ7JKhFDDJ62uJbzd+SHRRkWpwKsF1RzVx0hEw8u4XE3Gy8lwd5LLzES4XraYf74FY9MQqWPql39vdoUgAg82H/x0EGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223359; c=relaxed/simple;
	bh=BKB9L3/szgoPtLh+SOGFMPh4uRLxohuFEDrbXrgCRdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHZfw9vfX3NP8Gkz0tKgJqbfPomVgxcyLCR46uFZcAEjOC3Ep3PtrJ8gz4cAtDlqQT6f5nDl+rSK0UOk5bFOb4d9pUcyo5wSr7+DFqMMjdn6rEcK1bIeZCBTxf0klOw2LdNplCgoyXf/m9/LCL5KA5zicTRnjzQh550VfAy+EyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WMi/luJo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id C400B201AC8B; Mon, 12 Jan 2026 05:09:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C400B201AC8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768223347;
	bh=X5c6NHQ/R9EQQOdmt1M+0D3XF7Fx/S84TCxOUPYVNvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMi/luJoDWmaez/mkmmbx9R7o583mFZxT12FblvS8QKPooGyDuzKNABAOPJZTRRpG
	 R10pdl1DvvwVCecxymFF9iInH7O74XyYz8kapjYmTrZYvw7hdX3hJKrQZ77alArZp6
	 pa0Mdeh/70A0VwB2WmofLNtgj2qPYHFtB+EnZtY0=
Date: Mon, 12 Jan 2026 05:09:07 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
	gargaditya@microsoft.com
Subject: Re: [PATCH net-next] net: hv_netvsc: reject RSS hash key programming
 without RX indirection table
Message-ID: <20260112130907.GA13088@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 12, 2026 at 02:01:33AM -0800, Aditya Garg wrote:
> RSS configuration requires a valid RX indirection table. When the device
> reports a single receive queue, rndis_filter_device_add() does not
> allocate an indirection table, accepting RSS hash key updates in this
> state leads to a hang.
> 
> Fix this by gating netvsc_set_rxfh() on ndc->rx_table_sz and return
> -EOPNOTSUPP when the table is absent. This aligns set_rxfh with the device
> capabilities and prevents incorrect behavior.
> 
> Fixes: 962f3fee83a4 ("netvsc: add ethtool ops to get/set RSS key")
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 3d47d749ef9f..cbd52cb79268 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1750,6 +1750,9 @@ static int netvsc_set_rxfh(struct net_device *dev,
>  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
>  
> +	if (!ndc->rx_table_sz)
> +		return -EOPNOTSUPP;
> +
>  	rndis_dev = ndev->extension;
>  	if (rxfh->indir) {
>  		for (i = 0; i < ndc->rx_table_sz; i++)
> -- 
> 2.43.0
>

LGTM.

Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

