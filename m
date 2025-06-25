Return-Path: <linux-hyperv+bounces-6002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC8AAE8E05
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 21:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B880B1616C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Jun 2025 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34492E0B64;
	Wed, 25 Jun 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJqxeKu4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A942E06CD;
	Wed, 25 Jun 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878323; cv=none; b=QZtpGc2496oYVUzsktziCQVSxVZYPWcZv2IOri7kadnPuf1we1xRKS8U8u3FcarlXiUwjq0zbGadVfLlkUTixVnRkYbHvICl1YGFao2x5pDvFQw1mlKk5QBeUV6QMeM6gwqkaaX0xxl3MZn9dBkoBqsZX5VB3EJX7MRmDolUVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878323; c=relaxed/simple;
	bh=F6NcfibEksUk16xLZ9aZoeLDg4FLCE0ViGkOwseLHSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgkkHRVwo1+/ALTD30hslde2x81YzKqo+Ylh4HwLEwZTXKtE2AdbtT2SGAYRV9ehxxbttWhb4Yt5bKgll0kSptk5Rx7tlFCTtdKDUQpVhEOt8i91wVR0zqjMYsZHCfSNjqVn7dzCi9Zc2XOChqU80BxgYgMaDkODqF0JbMTqMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJqxeKu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC537C4CEEA;
	Wed, 25 Jun 2025 19:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750878323;
	bh=F6NcfibEksUk16xLZ9aZoeLDg4FLCE0ViGkOwseLHSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJqxeKu4wUr6cfEms7Lm7D8RCpHIsqXBw4cjPO8V4ZfBoLUH0tFner3HnTUFAseyN
	 Wkqs3PfIRA5XWLBrSANmOLCdS1AVqqL03QAY/okgV4+Uh4TFK0oFq6yz3vLahnlYs5
	 1bEqPC7weC0Jf+EI5NJMmlOgBR4sCpB0mFnmzQZu0iGZ/xAsxEl/mz2r06hufnd9Jg
	 skYzu0svOuooWsCpqR1pvh8658VL0eV0n4QTGtQpzL5lJF2df5HywXt0CehD5GDeS4
	 Wpj6UyARpKWlFnb/jx/t9Itas79HUXNNL1xp4w6IIljeEjYmUH/OjWC2zSPRSIc63h
	 ISZgkmO2ppq8w==
Date: Wed, 25 Jun 2025 20:05:18 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Fix build errors when
 CONFIG_NET_SHAPER is disabled
Message-ID: <20250625190518.GP1562@horms.kernel.org>
References: <1750851355-8067-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750851355-8067-1-git-send-email-ernis@linux.microsoft.com>

On Wed, Jun 25, 2025 at 04:35:55AM -0700, Erni Sri Satya Vennela wrote:
> Fix build errors when CONFIG_NET_SHAPER is disabled, including:
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:804:10: error:
> 'const struct net_device_ops' has no member named 'net_shaper_ops'
> 
>      804 |         .net_shaper_ops         = &mana_shaper_ops,
> 
> drivers/net/ethernet/microsoft/mana/mana_en.c:804:35: error:
> initialization of 'int (*)(struct net_device *, struct neigh_parms *)'
> from incompatible pointer type 'const struct net_shaper_ops *'
> [-Werror=incompatible-pointer-types]
> 
>      804 |         .net_shaper_ops         = &mana_shaper_ops,
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506230625.bfUlqb8o-lkp@intel.com/
> ---
> Changes in v2:
> * Use "select NET_SHAPER" in Kconfig instead of adding multiple checks for
>   CONFIG_NET_SHAPER.

Reviewed-by: Simon Horman <horms@kernel.org>


