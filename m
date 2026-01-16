Return-Path: <linux-hyperv+bounces-8338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B71FD3869B
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 21:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10B13046540
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C336997C;
	Fri, 16 Jan 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heY1V/MJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229834D4CB;
	Fri, 16 Jan 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593924; cv=none; b=SRaFwbSX2IQMrCKD58tTLenaRMTR4p4ha0QeDdnJcVaDUBczk3Vup1qUtnGeWWNgFgCSnW2pfo6rUrUC/me17wF/O36t6o+upQJkWrQvDSzUEWB2euMTavayrvAlO8bgfJcXxLc+Sq26khOsqwmpVX2jh8rcr5XgoRirP8XpvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593924; c=relaxed/simple;
	bh=bjjUIFDqcFJ+DD/W7NYvGudVd6jI+S34MgDyTw9LTAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBN6F82pETiHkSnQXj41hPKHbbBQRrSjrW5ODpQWwPah1/pvgIXvR8B8pgp7PKZc1PoKkBenuy7Z5g7qDvcPI46CBcjiqI3R+fHIboLkOrE5T+DgenDvMBDehYbRx/CmaXU0v5kDVbC6BDfmhDZFgPNPNWwmBRZyToorZ1XyVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heY1V/MJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D446C116C6;
	Fri, 16 Jan 2026 20:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768593924;
	bh=bjjUIFDqcFJ+DD/W7NYvGudVd6jI+S34MgDyTw9LTAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=heY1V/MJ8+av/kAMFwOpTYuSOQ+NLketMOm1sIrwOK23KQKo9tKJqrrqYZDPVlNGN
	 U5awzW8zL4pJYJgxeWps9e5HrcwQGv0mLm4bQavyyRh8ecxHh2GbBB84odcgO0f0wQ
	 WXxxWBG9LwvoMEDZk5PrUph2KsyHAbowMUqo5pAACVQImS/yqFDKiVVxtIeMWRQSJ6
	 FGx3uEwkn2DrkV+0sL+ehLkXvzWXVWfinlMdxcuRfeh6rB6zGkRHGcra6gCS2SMTT9
	 jpVQ4z25ZNZZFNWdCKDbsdSTFHjTC8yCJt3cPZ/ZI/Dt2ygEEozWPMPZWSocPc8RvM
	 AFDf+nwCjc2Cw==
Date: Fri, 16 Jan 2026 20:57:34 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Hans de Goede <hansg@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild, uapi: Mark inner unions in packed structs as
 packed
Message-ID: <aWqYLlX7nJNfJUu0@derry.ads.avm.de>
References: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115-kbuild-alignment-vbox-v1-0-076aed1623ff@linutronix.de>

Cc += linux-kbuild

On Thu, Jan 15, 2026 at 08:35:43AM +0100, Thomas Weiﬂschuh wrote:
> The unpacked unions within a packed struct generates alignment warnings
> on clang for 32-bit ARM.
> 
> With the recent changes to compile-test the UAPI headers in more cases,
> these warning in combination with CONFIG_WERROR breaks the build.
> 
> Fix the warnings.
> 
> Intended for the kbuild tree.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weiﬂschuh (2):
>       hyper-v: Mark inner union in hv_kvp_exchg_msg_value as packed
>       virt: vbox: uapi: Mark inner unions in packed structs as packed
> 
>  include/uapi/linux/hyperv.h            | 2 +-
>  include/uapi/linux/vbox_vmmdev_types.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> ---
> base-commit: e3970d77ec504e54c3f91a48b2125775c16ba4c0
> change-id: 20260115-kbuild-alignment-vbox-d0409134d335
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

Thanks!

Tested-by: Nicolas Schier <nsc@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>

Kind regards,
Nicolas

