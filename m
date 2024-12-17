Return-Path: <linux-hyperv+bounces-3481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1A9F404D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 03:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55583188D872
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84245C14;
	Tue, 17 Dec 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAaU54cn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A0714A91;
	Tue, 17 Dec 2024 02:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400982; cv=none; b=p0fSDhjRvNFmQqifC34CEfhJshWaX43j69s52UKjG3xOAhWjOsYhckCE0/0i8s5RlDyxfX10sIem7OGMWmZtrGfpY1JAZ02X9zYqYx6aBE9J6rhE+eKvGXsSXvx1Ct38+XR+RHxwTGcm1ZwjwvAAbvp0GGpyGpTLHYeINu1hTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400982; c=relaxed/simple;
	bh=j1hhrwup428r+2dYZuDeMW5tzytl127XBMJIVImlO2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHUHuX2NyunWi1DqY5mwBaJZCCLDugD1Li6TQNf8ZVEbFFPy/iqKSlIxbNbjg0fLqFnVBKr97cuvzsOM9QsJup0HJLYNNWFTx5Heant/jTfRzgE55948PxfHu/juVkIER/ZKa6hD64ot4JoMicEUhaauHI7O0LxjpF8Uy44Mxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAaU54cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CB1C4CED0;
	Tue, 17 Dec 2024 02:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734400981;
	bh=j1hhrwup428r+2dYZuDeMW5tzytl127XBMJIVImlO2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OAaU54cn3SctKWq4Z8FgEJVS3gFwxJluy5VU8iSzmE3xm/Ulyq11AWv8N2ICnOm51
	 C5x5TRmScISt87Z1nFUxwIQvOqlswN+003jy4ldUFD/p4Nj5R5aUNI1aZS9URBBO5z
	 pmejIu3hMDGraJzb2KfNmxouTnuNADt3PdnuQDMzDnZAuFEf8cKRZTGxLnYq3VQECf
	 Vthba0tm3K0e3kFuJR1v1yXEZUUBAE4OU5crlL4ZPnhvvgWMZ94ILvJnBUhJTlcf8x
	 To5HNwSHVRkt7Mhm+MZKkWMIRzgX6b4Dacxa/8EUu3/mjmKHmoOo+MjU2d8LmLV9cb
	 zD2HX+bRyS0Eg==
Date: Mon, 16 Dec 2024 18:03:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Ajay
 Sharma <sharmaajay@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Stephen
 Hemminger <stephen@networkplumber.org>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch net-next v2] hv_netvsc: Set device flags for properly
 indicating bonding in Hyper-V
Message-ID: <20241216180300.23a54f27@kernel.org>
In-Reply-To: <1734120361-26599-1-git-send-email-longli@linuxonhyperv.com>
References: <1734120361-26599-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 12:06:01 -0800 longli@linuxonhyperv.com wrote:
> Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> in a master/slave bonded setup. RDMA uses those APIs extensively when
> looking for master/slave devices. Netvsc's bonding setup with its slave
> device falls into this category.
> 
> Make hv_netvsc properly indicate bonding with its slave and change the
> API to reflect this bonding setup.

This is severely lacking in terms of safety analysis.

> @@ -2204,6 +2204,10 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
>  		goto rx_handler_failed;
>  	}
>  
> +	vf_netdev->permanent_bond = 1;
> +	ndev->permanent_bond = 1;
> +	ndev->flags |= IFF_MASTER;

> @@ -2484,7 +2488,15 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
>  
>  	reinit_completion(&net_device_ctx->vf_add);
>  	netdev_rx_handler_unregister(vf_netdev);
> +
> +	/* Unlink the slave device and clear flag */
> +	vf_netdev->permanent_bond = 0;
> +	ndev->permanent_bond = 0;

> + *	@permanent_bond: device is permanently bonded to another device

I think we have been taught a definition of the word "permanent"

