Return-Path: <linux-hyperv+bounces-3060-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169C97E2B1
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Sep 2024 19:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1F91F216F8
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Sep 2024 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3572940B;
	Sun, 22 Sep 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb+9EgtL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD917C64;
	Sun, 22 Sep 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727025709; cv=none; b=EMPyE7jazQDLuEhAFJ7KGJSOHFTbWgu6XfRqXaRT6AK1FnNF/rma4cuMMxELcJw6hZ+zWvUB8/Y2A/8nQyZyo/YTfu6LewedadEk17mZMgtO0ot0cOJvEAZvdXd0wm4c9edAuuJh2K3ABhbXwEdyZwSrP5Tbviyk5TW1VpdTWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727025709; c=relaxed/simple;
	bh=7pKcc7GpsW8tmnEy7weHXD0ST3IevhpacWw79bD/TYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQlU1QU4w4r5BK8WxBv8yLRn8gBR9RjwffjC829rIBhQmRN3L2UwjSVkju65j8EhViK6tgzcQHBHtpMGwUfEEUA/Gf8ZnlC1/MXImUPZge7Lxyumf5nUj21PKVCH5nM4R7g5xnpl3YIUUsGfe4LYV9aah3T8EAp2VNG80MwRrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb+9EgtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACECEC4CEC3;
	Sun, 22 Sep 2024 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727025709;
	bh=7pKcc7GpsW8tmnEy7weHXD0ST3IevhpacWw79bD/TYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nb+9EgtL43OXnf6rYLrlo/HWfZ14nOLLmY4iua7TvMO387RLLJQ8wRNtFcfxyNtsV
	 s+3nsZVC7j6OWB+URexMvupe6yRubJZO/3tHIiuLVPzCJOX3J1BiEJyzzXUdS5QAoF
	 /32UJvFA1rALzHP8s2ddlvUV5JF2OBFHSVb5AvJeQHKErtfpOXOPOW4WQBLtcYxRIV
	 P6Jy11o6jvqOH6KFiIn/Wbzwz2viTzBxREwPOazWjUKyPd1NGGk8dphqTD4zJzlzkc
	 JU0LDRSU+uyWQVpJGTgxcCwu0BxT/0Sx4TNIj+RmtNW10pJKRwsgslpi32v9J4gcfT
	 8eSUgT8e1Kzzg==
Date: Sun, 22 Sep 2024 18:21:43 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	shradhagupta@linux.microsoft.com, ahmed.zaki@intel.com,
	leon@kernel.org, colin.i.king@gmail.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ernis@microsoft.com
Subject: Re: [PATCH v2] net: mana: Add get_link and get_link_ksettings in
 ethtool
Message-ID: <20240922172143.GF3426578@kernel.org>
References: <1726867103-19295-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726867103-19295-1-git-send-email-ernis@linux.microsoft.com>

On Fri, Sep 20, 2024 at 02:18:23PM -0700, Erni Sri Satya Vennela wrote:
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

Hi Erni, Haiyang, all

Thanks for the update, it looks like it addresses the review of v1 by Jakub.
However, I am assuming that as a non-bug-fix, this is targeted at net-next.
And net-next is currently closed for the v6.12 merge window.  Please
consider reposting this patch once net-next reopens.  That will occur after
v6.12-rc1 has been released.  Which I expect to be about a week from now.

Also, for networking patches please tag non-bug fixes for
net-next (and bug fixes for net, being sure to include a Fixes tag).

	Subject: [PATCH net-next] ...

Please see https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer

