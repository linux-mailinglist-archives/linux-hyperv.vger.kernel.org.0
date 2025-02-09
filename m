Return-Path: <linux-hyperv+bounces-3864-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3AA2DBD3
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Feb 2025 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18457A2C41
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Feb 2025 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523B13B2BB;
	Sun,  9 Feb 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKbiPCj/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D014A91;
	Sun,  9 Feb 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739094333; cv=none; b=uBT6aq5Tr90LTges4XTkbYzvWHfSFwJhTiLePuBxpt60U/i0u0o/QySBDsN748IgejPYcesdGNst+BfwqPKOZjhX3tT8iq/X8BLs+95D4KgFICIEmsjhZuVAS6p3dO4wcKl3bVfRY8Pn0DlP+qfw5+7JgLi7ShfD5lkch6pNgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739094333; c=relaxed/simple;
	bh=WcgMqs/ZwM9rIg7kqK/twtKrWUkfdn5EnRYbJxE9NiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyFmnZOnnGU2O15hvIJYnmXCweW1ZfMgwEufLzkdNRNk2V3bsElpcOWk2jlF9MYlwIa9aaNfPPvn64KIauMF6oWl7W6MuKljmFU1pghV+XzMyhX4pTKi620YAc4SkQmwtGfP9g9SlhH7P5lAUeDFxkMm+34mnodPUHG7/py6LEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKbiPCj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9A3C4CEDD;
	Sun,  9 Feb 2025 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739094332;
	bh=WcgMqs/ZwM9rIg7kqK/twtKrWUkfdn5EnRYbJxE9NiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKbiPCj/bnlGorhgWoHY+EgObj2nir8+E7QW5MkGQOUMTEmHvM2N+dtFPBBYRQvcm
	 OPjhYkD6NPdPp0lAxwPzZPGLIKV328kum/oDyYA5csdDanqK8N7Kz6O8ixLWpA1INj
	 tGazUnO7nszkrdjYVA0RK5TgJ4e03JoWxUbnWCFodUgQsvHrvXyDZM1k6YTJaxRCDk
	 iNxBEW9ncLl8dksuDg4Q9rTlywbhUMwDGW2M3U6fsbi+iXyCSIEJFiQOXPhhRyTGe9
	 5cgrpd3Mlu55Y7ZIso38CLJNW8ZJDRQhi60e4ELE06WWbGMMD/3E3VIr56l3e/U3W8
	 jFuMRfHpkh+Og==
Date: Sun, 9 Feb 2025 11:45:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v2 0/3] IB/core: Fix GID cache for bonded net devices
Message-ID: <20250209094528.GB17863@unreal>
References: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>

On Fri, Feb 07, 2025 at 01:36:15PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When populating GID cache for net devices in a bonded setup, it should use the master device's
> address whenever applicable.
> 
> The current code has some incorrect behaviors when dealing with bonded devices:
> 1. It adds IP of bonded slave to the GID cache when the device is already bonded
> 2. It adds IP of bonded slave to the GID cache when the device becomes bonded (via NETDEV_CHANGEUPPER notifier)
> 3. When a bonded slave device is unbonded, it doesn't add its IP to the default table in GID cache.

I took a look at the patches and would like to see the reasoning why
current behaviour is incorrect and need to be changed. In addition,
there is a need to add examples of what is "broken" now and will start
to work after the fixes.

Thanks


> 
> The patchset fixes those issues.
> 
> Changes log:
> v2: Added cover letter explaining the overall problem and current behaviors.
> 
> Long Li (3):
>   IB/core: Do not use netdev IP if it is a bonded slave
>   IB/core: Use upper_device_filter to add upper ips
>   IB/core: Add default IP when a slave is unlinked
> 
>  drivers/infiniband/core/roce_gid_mgmt.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1
> 

