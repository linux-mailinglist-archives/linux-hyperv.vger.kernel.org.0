Return-Path: <linux-hyperv+bounces-8333-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD07D3354F
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 16:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FC21304D4B2
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17CF33D4FB;
	Fri, 16 Jan 2026 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e6kNZYiN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DE1AAE13;
	Fri, 16 Jan 2026 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578760; cv=none; b=sw3fzjBG5On8GEgjr0fiyyitZbtD9WcCiky8RDUkLrR60Z6e3ytDW7rMI9wbZ03PuFMwI5fbOfq7dH0Ve8UQwCTxDEKKB+9o/8xQhtrh+BllgW32pJQPkzORREZqVTB4V5WZLQ91+Cat7FHtMfYhMfPllCgRTdIZ/ig/vGPgaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578760; c=relaxed/simple;
	bh=ccgAeaYXT57mZxZmgSb8MPT61/gS42zGa89VBeKhB7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsd86bMkkeXJVcoHEkOAzQDdpaOmfgE4xb2ShcbtZTdkPg2I19DcjLaRTa3RrFeCbRIek+vYF+SsOgl9VuxQlPQmIe38gbJ8DsbMP3VDm0JrIxc4K+IUH5YTj/ULF4kb8PSw+K6I9QypUcwo3smp9ovt7abj4fuWj7mWMT00ll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e6kNZYiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D19BC116C6;
	Fri, 16 Jan 2026 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768578760;
	bh=ccgAeaYXT57mZxZmgSb8MPT61/gS42zGa89VBeKhB7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6kNZYiNpA8s32qTucoZCdBV/ZlHwH7MsAHAdESZNHgZgeL0jrrhew3Qc4nMYR+Gc
	 rbicbIAiI6NNjgCKjsH1Oh4KFChTZysPq2GpxUj06YkP0NRUoCNyfL5zxZHka2TLNd
	 Jh8qr2bKF7HagzmeIPBrWqD2Bcf6LrQhPWcSBNoU=
Date: Fri, 16 Jan 2026 16:52:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 0/2] kbuild, uapi: Mark inner unions in packed structs as
 packed
Message-ID: <2026011632-favorite-creamlike-aec6@gregkh>
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

