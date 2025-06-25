Return-Path: <linux-hyperv+bounces-5998-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CAAE807A
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E329B188CD71
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FC29E0EE;
	Wed, 25 Jun 2025 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WsgxWtZx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8067E1C07C4;
	Wed, 25 Jun 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849127; cv=none; b=Imhsi/B3/dRWSOPvjgcbNDjs4+pWCXOOs3176gmK6iUElOAmxoT+QkXksdk9zTAIVIu46bD6z1cqJFZGOmeJuA/Cs4jtjolDOz0deNJl01+E8lKmXplOfk90GZdbsNiJNsuNq4dVkPVBELfEfLMliIQ8Ym5rxxAemeStnVMUyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849127; c=relaxed/simple;
	bh=ZY+V9ETqtQ7xBCDXlGu+YAnuNgGnkCkuN5ZD2SpoFS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ0YtgrPJa2cVxBJJ2B81l3u3Z7UdQtRXwXPkIppa0VbfSrJBtv4F6tii/f+IbWAggpm+gPA8Us5Xb95g+44tHfQ1uzNjU0Keer8TX0d7CQ6sHxT1rknjW9DRauOiznTPAEa5tTk0QDLp4IBUemaM4njX8qV6wQ6GhBtXDQMmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WsgxWtZx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3906C20432EF; Wed, 25 Jun 2025 03:58:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3906C20432EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750849120;
	bh=YJj7YWAnr4bRCxbUz724CV8Ufk+ceOfRXVJBFPkSL8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsgxWtZxX2v+DUP8USqCG6m7xs33qLvU6Z4fY3TJgq2P137I5sDwaZHJafEopxYqb
	 KPZ5EnunusVGbXePmPWqOe/TBXhGG7D1+KtqaDh1jEnbdt42I+9tmeA3Fg419sRJGX
	 srd6WZOmBITdybpD2bH22ajsvL5aQGWtK6agDscA=
Date: Wed, 25 Jun 2025 03:58:40 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	shradhagupta@linux.microsoft.com, longli@microsoft.com,
	kotaranov@microsoft.com, lorenzo@kernel.org,
	shirazsaleem@microsoft.com, schakrabarti@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Fix build errors when
 CONFIG_NET_SHAPER is disabled
Message-ID: <20250625105840.GA32155@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1750677241-1504-1-git-send-email-ernis@linux.microsoft.com>
 <20250624163342.754f5b64@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624163342.754f5b64@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jun 24, 2025 at 04:33:42PM -0700, Jakub Kicinski wrote:
> On Mon, 23 Jun 2025 04:14:01 -0700 Erni Sri Satya Vennela wrote:
> > Fix build errors when CONFIG_NET_SHAPER is disabled, including:
> > 
> > drivers/net/ethernet/microsoft/mana/mana_en.c:804:10: error:
> > 'const struct net_device_ops' has no member named 'net_shaper_ops'
> > 
> >      804 |         .net_shaper_ops         = &mana_shaper_ops,
> > 
> > drivers/net/ethernet/microsoft/mana/mana_en.c:804:35: error:
> > initialization of 'int (*)(struct net_device *, struct neigh_parms *)'
> > from incompatible pointer type 'const struct net_shaper_ops *'
> > [-Werror=incompatible-pointer-types]
> > 
> >      804 |         .net_shaper_ops         = &mana_shaper_ops,
> 
> You have to add
> 
> 	select NET_SHAPER
> 
> to kconfig dependencies for the driver. This symbol cannot be selected
> by the user, its hidden from the menus.
Thankyou for pointing it out Jakub.
I'll make this change in the next version of this patch.

- Vennela
> -- 
> pw-bot: cr

