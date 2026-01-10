Return-Path: <linux-hyperv+bounces-8205-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C5D0CC90
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 02:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4A833031355
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448E23D2B1;
	Sat, 10 Jan 2026 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Njd3KL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704062046BA;
	Sat, 10 Jan 2026 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010182; cv=none; b=n5CcxCtPEbGght3Q/Watt55+Bxw4b1/VqXamoAGVBDqO7019TC5Tehg4386NxvU5znso541FhGyGnVw6ScD8NUAeuHXhTc8Swyz0Y6wtkepG1QfjCXEZltWnd1HeKi2LeS9CIi5cOaiCNH6yeivYrjw1gZhy4b+EZuyezapKo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010182; c=relaxed/simple;
	bh=jwmu+2tBWEfRGT9/QOU7iFtSqqIMZknjwLpSIvf2i0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QY9yiCNxaJ9AzVuvlIID481Mn0mMAr/gQ1NrD/ZC+sXeMGvwUMMWnmwbWhihe49Duky6A5MH0bDZ0lwwbBRDwjjZ8EicHCBG49XgSOJOwbotxEs+ZM6V3A3bHBZa6LMjpaT0frdxlyWZaWoNSe9rFgqwp5jivN+D03/rihFL6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Njd3KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0B8C4CEF1;
	Sat, 10 Jan 2026 01:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768010182;
	bh=jwmu+2tBWEfRGT9/QOU7iFtSqqIMZknjwLpSIvf2i0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g6Njd3KLRJ5SL+h61z33gsmvRHVC+Et3ZvRaNgRE4LZZ3aS3RlY3oRq1T1ah69eey
	 omZSz/vhd8g58vEHHn4mOgVz0jmM9oCKO9TkruR/FsPpvOWvJZ/YR1P4NuW7ShBXYB
	 ExVhaW+uZIIM4p2QoEDJWWIhwa/UVpQH4AB4dyiZzEBscCHY9Gtnk+blXF4wGdWvDt
	 WFsrHu6Qyn2gQopL40uDudw82MONuD+IwdUpMgxndqkskFUcRq1nYXVyR2ienSfJ2E
	 GRzllAy1b+GHTERWdaR/zLBugBektmNs/d/vXFQ0XTSwL0FsXB+vOz7laC8cqS751o
	 2O7wk2sBZPy2Q==
Date: Fri, 9 Jan 2026 17:56:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>,
 Simon Horman <horms@kernel.org>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, Dipayaan Roy
 <dipayanroy@linux.microsoft.com>, Shiraz Saleem
 <shirazsaleem@microsoft.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, paulros@microsoft.com
Subject: Re: [PATCH V2,net-next, 2/2] net: mana: Add ethtool counters for RX
 CQEs in coalesced type
Message-ID: <20260109175620.3e461176@kernel.org>
In-Reply-To: <1767732407-12389-3-git-send-email-haiyangz@linux.microsoft.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-3-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 12:46:47 -0800 Haiyang Zhang wrote:
> @@ -227,8 +232,6 @@ struct mana_rxcomp_perpkt_info {
>  	u32 pkt_hash;
>  }; /* HW DATA */
>  
> -#define MANA_RXCOMP_OOB_NUM_PPI 4
> -
>  /* Receive completion OOB */
>  struct mana_rxcomp_oob {
>  	struct mana_cqe_header cqe_hdr;
> @@ -378,7 +381,6 @@ struct mana_ethtool_stats {
>  	u64 tx_cqe_err;
>  	u64 tx_cqe_unknown_type;
>  	u64 tx_linear_pkt_cnt;
> -	u64 rx_coalesced_err;
>  	u64 rx_cqe_unknown_type;
>  };

This should be deleted in the previous patch already

