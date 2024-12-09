Return-Path: <linux-hyperv+bounces-3436-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65749E8D67
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 09:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E963282437
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B927A12CDAE;
	Mon,  9 Dec 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AnBZilL/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE822C6E8
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Dec 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733037; cv=none; b=t7N0GsZzo1ZKKwMG4xCe/KPzLwz5b0Ug9Hw7soDWwlAJQfboIIsr9VZdY1O4V3hd9yGXc/S6hzNkDSimy+cFnufmbFGTUgBfudclHdydbgiVRBvY4qnr18BmJN2DUEt0Is1ak2yCLO4uXKRJL6B2qkhPIEhTGha9nY13Dg68Rf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733037; c=relaxed/simple;
	bh=REHQVkUt4c7h5fKMg74AV6gAXOe73wcjLViauTvpyYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLYKTpH7LSBRqA7XacYKXtK+zAfmLtMmolVEsw4cMxBBo2hwwmFqAlclfNJ3wK5s1lsCYJebykA/QWO5Qat/Gc27J7nPofrTKYTBpHGci6DobIcxftooPsHEF9IduODwd46AoRGKIzokye5Pop7MsuCMM/6BeAwXo21BnM5SV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AnBZilL/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id A62EC2053699; Mon,  9 Dec 2024 00:30:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A62EC2053699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733733035;
	bh=Dqlv2AzoRns1z5CW7pkakxxN4aC20HZPcOSfclM8bLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnBZilL/R2IYnCCqkU3fg9BSZmNQ50YN4pAqmm99sd1leHrSxiS502+CStefT8Mpk
	 9deIRhSRxjS07Hhc8FxW0QeiDYnhK6XMv8PQERIxlH0mnQVxsRLMn20SrmOulm0HuH
	 m6OfaiZUgPf1YBReAXIqWqIsT5cvpdIVe68IaWQs=
Date: Mon, 9 Dec 2024 00:30:35 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Adrian Vladu <avladu@cloudbasesolutions.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
	Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: Re: kernel: fix hv tools build for arm64 when cross-built
Message-ID: <20241209083035.GA25242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 09, 2024 at 12:44:22AM +0000, Wei Liu wrote:
> On Wed, Oct 23, 2024 at 02:01:12PM +0000, Adrian Vladu wrote:
> > Hello,
> > 
> > While trying to build the LIS daemons for Flatcar Container Linux for
> > ARM64 (https://www.flatcar.org/), as we are doing Gentoo based
> > cross-building from X64 boxes, there was an error while building those
> > daemons, because the cross-compile scenario was not working, as ` ARCH
> > := $(shell uname -m 2>/dev/null)` always returns `x86_64`.
> > 
> > I have a working patch for the Linux kernel here that was already
> > applied in the Flatcar context and it works:
> > https://github.com/flatcar/scripts/blob/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > 
> > Raw patch link here:
> > https://raw.githubusercontent.com/flatcar/scripts/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > 
> > Sorry for the delivery method via github link, but I cannot send
> > proper patches from my work email address currently, as the email
> > server does not support it.
> > 
> > Please let me know if I need to send the patch via the recommended way
> > or if the patch can be used directly.
> > 
> > Also, maybe there is a better way to address the cross-compilation
> > issue, I just wanted to report the bug and also provide a possible
> > fix.
> 
> Saurabh added the ARCH variable. He's CCed.
> 
> BTW I think your patch can be simplified by using
>   ARCH ?= $(shell uname -m 2>/dev/null)
> instead of the ifeq test in your patch.

Agree, this is better way to handle it.

> 
> I don't think that's correct. ARCH will be set to the correct value by
> Kbuild. 

If we build locally on ARM64, there is a chance that ARCH may not be set,
leading to build failures for arm64. IMO we should provide a fallback
option for local builds when ARCH is not set.

> 
> Saurabh and Adrian, can you test the following patch?
> 
> Thanks,
> Wei.
> 
> >From e6a1827887617c08172e2d0ee0d60549f5ccad65 Mon Sep 17 00:00:00 2001
> From: Wei Liu <wei.liu@kernel.org>
> Date: Mon, 9 Dec 2024 00:32:50 +0000
> Subject: [PATCH] tools/hv: fix cross-compilation issue in hv tools
> 
> The Kbuild system sets ARCH to the correct value.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  tools/hv/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 34ffcec264ab..9008223279df 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -2,7 +2,6 @@
>  # Makefile for Hyper-V tools
>  include ../scripts/Makefile.include
>  
> -ARCH := $(shell uname -m 2>/dev/null)
>  sbindir ?= /usr/sbin
>  libexecdir ?= /usr/libexec
>  sharedstatedir ?= /var/lib
> @@ -20,7 +19,7 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>  override CFLAGS += -Wno-address-of-packed-member
>  
>  ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
> -ifneq ($(ARCH), aarch64)
> +ifneq ($(ARCH), arm64)

My understanding is ARCH could be either aarch64 or arm64.

- Saurabh


