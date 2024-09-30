Return-Path: <linux-hyperv+bounces-3095-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6098A934
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD5C1F23997
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D281925B3;
	Mon, 30 Sep 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDUjfwJx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276213634C;
	Mon, 30 Sep 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711704; cv=none; b=QY3mXZCSQGiAHDFUqS/lGMT2xni+cwrJ4EbnMxXvTHBuEqXcujyz5DOag9lWw6VZVQaOAB5Kj9AGvGvd6PrTMiuS5GK+oDIqywLfT4LG443oJMrbDSTuGDipK5+oOmX73s27lEQ1D6E/HtesxdUGsPxmaVJlNEFpo79IGYRUQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711704; c=relaxed/simple;
	bh=j/N2ftxrfNM4oegTjgoTIdXrzNAp+raVcE+sAQpwo2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb9ae7omoLeX5vzzUZuNhhv0oE48icpEW933+Kz9Gwl92X7VsIwWIMi050sF+iJ+oaS3Px7Y2PNJwjaHWFi7CRkn/m3JPYnNVdNz15+slG6J45WIaLN7HbKa4mi+g6MDEcIkoy4B1FfYLr55y0Rnmw21LUslR1Im1Dty9NM55Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDUjfwJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29985C4CEC7;
	Mon, 30 Sep 2024 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727711704;
	bh=j/N2ftxrfNM4oegTjgoTIdXrzNAp+raVcE+sAQpwo2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDUjfwJxgXfN89wPYZL/d1Ky7VtlfT5e45GsXNJFWd2Rld245OInOTcBiBnR7uGQ+
	 eT16htAFWee6r5X7hEnulMYBIk/UDUP2dgXqklU5FIBLXIeI8e8u/GOUsq8swa3PF9
	 +3GsrJ/JCISCjM46Yef8kcbEiGlGRVdmrdrA3VQCSYE7hgO3i2Fr46rI9aS36ImqvG
	 6evaxHxbv1l7PTYGN4ZHusYyynPvEmzdEXNxdg2Hy5/fyxbi93ToV0WAdlGtEdMSe4
	 sjipOj/Uyw70xc5yD+HyYd/aEmQ9wCVBa6bFMnIzBxxht1SHfQ6wEd0jj1LxUNHnyn
	 jz8TbxsRMOOHw==
Date: Mon, 30 Sep 2024 16:54:59 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	shradhagupta@linux.microsoft.com, leon@kernel.org,
	colin.i.king@gmail.com, ahmed.zaki@intel.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Add get_link and
 get_link_ksettings in ethtool
Message-ID: <20240930155459.GE1310185@kernel.org>
References: <1727674934-12130-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727674934-12130-1-git-send-email-ernis@linux.microsoft.com>

On Sun, Sep 29, 2024 at 10:42:14PM -0700, Erni Sri Satya Vennela wrote:
> Add support for the ethtool get_link and get_link_ksettings
> operations. Display standard port information using ethtool.
> 
> Before the change:
> $ethtool enP30832s1
> > No data available
> 
> After the change:
> $ethtool enP30832s1
> > Settings for enP30832s1:
>         Supported ports: [  ]
>         Supported link modes:   Not reported
>         Supported pause frame use: No
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  Not reported
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Full
>         Auto-negotiation: off
>         Port: Other
>         PHYAD: 0
>         Transceiver: internal
>         Link detected: yes
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> Changes in v2:
> * Remove support for displaying auto-negotiation details
> * Change PORT_DA to PORT_OTHER

Thanks, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

