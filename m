Return-Path: <linux-hyperv+bounces-5994-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDCAE61B5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Jun 2025 12:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DD7A5955
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Jun 2025 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE62561B9;
	Tue, 24 Jun 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIIcWVgx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8773D3B8;
	Tue, 24 Jun 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759356; cv=none; b=Ad4wtbEP1cssxVgN0vzo/RPH5FMEQFIFmuatn8/TJV3yEprE4PaECDusiCXV6fpDAQRgurUDTYsMPdXJbazVzmIQltpaYtOk7VdkU+Dv8B5dDgjx6TeeZmlIlFiTxvtIMCIpd0bbTKH3qmDpoblzR3+FPsgrH57SWwcttd3TxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759356; c=relaxed/simple;
	bh=DvcAykCpBFaTzbO/UWWTGagnoDVBmQsRyB0QxIqtATQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwKrTOM1/uWGPxTMpF86gXh1UI/qfbzIUa/2sHlnBSe05gbvjAwxGjiIttxtoRqfGFs2GKoGvPCSNhMWNSX/ccgUdsIzfdP6ks0Z66HdaotU2zqpSvuOFPs5vAAS/1sKMcT/t6N8dVRQwW5fP/3sJ3F275JbntaM/AgCmMDhcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIIcWVgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCA4C4CEE3;
	Tue, 24 Jun 2025 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750759354;
	bh=DvcAykCpBFaTzbO/UWWTGagnoDVBmQsRyB0QxIqtATQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIIcWVgxhZ9QEdneshjXQUmmNoHJkp+XD/zn8WD1u0KuOhg1mK0jWIQVw2bOufaNi
	 IO3YUWS69Sk3dJtUYuq6+OFbU7gcXLauliq5yWkGASppjD7HUwgqkhCBUJQTDVwUmA
	 K+ngas9rDDrMyKAqPFx9iNAApE9dz2+ITPdMXMOzuaL3u85QHe7CCV9yRQvZPR2KuS
	 B8pYTHXO91bSVSzyAqc96VLh4WpErQ42Gsv4EDIImSpFFHAegnT4nt+Cl4Vdp+KxgB
	 8QVDCIK5+mzY/huFLFKOzM/DquMwJMtko7atpewUzLQ3O1cQTnOki8L7TC2f/Wgp/F
	 spdD5qF51tCEQ==
Date: Tue, 24 Jun 2025 11:02:28 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shradhagupta@linux.microsoft.com, longli@microsoft.com,
	kotaranov@microsoft.com, lorenzo@kernel.org,
	shirazsaleem@microsoft.com, schakrabarti@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Fix build errors when
 CONFIG_NET_SHAPER is disabled
Message-ID: <20250624100228.GC8266@horms.kernel.org>
References: <1750677241-1504-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750677241-1504-1-git-send-email-ernis@linux.microsoft.com>

On Mon, Jun 23, 2025 at 04:14:01AM -0700, Erni Sri Satya Vennela wrote:
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
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506230625.bfUlqb8o-lkp@intel.com/

Reviewed-by: Simon Horman <horms@kernel.org>


