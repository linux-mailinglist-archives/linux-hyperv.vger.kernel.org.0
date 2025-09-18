Return-Path: <linux-hyperv+bounces-6936-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B5DB836EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555FA1C81FB1
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF22EFDA4;
	Thu, 18 Sep 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bB8r9c7k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B32EFD8A;
	Thu, 18 Sep 2025 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182720; cv=none; b=I4g8qhWC0ATlSzB9BiyrfKQx8TKMDfC2dkxEPrhjJguLTEJ/r/b1e+s7htcj3B9eQLBbNCqAK5mPAyawQqvzD/JKvE1DCjaQpk7N6JdY30TxqoqS4lByfLAY+SiCOIDpYDNyoo28353AXIgaM1wFPXLWdRNSH2s9eGuScL+7pR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182720; c=relaxed/simple;
	bh=3hIYTT1ZcNliMeoFx5ijfiEzeNg3UJdkWLLfOB2jAYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4cgQr0jcQ/vkW9ZVDKMMBl+slI4TVuDBXQdInHEO4x+pQMU/DY1KA9v9EeQotfON2Bi+cdeICFSncS57v+7zhpoPMFBG/gXztpl4a/6UM8eXytO7Cu30A06Dxyism+NdEVhE1OPhZSKYHa+KO5V3l5z/RssBBQNmwYcqI8wceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bB8r9c7k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1068720143C5; Thu, 18 Sep 2025 01:05:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1068720143C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758182719;
	bh=f6Xq/qzmkWBxkjsonhrjIu+AIDazg4cml5u/EGCUwPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bB8r9c7kBJIUWPHkehFORLxOvLjCwkQvqm41saev5ohf3b+kUXL/Gx4VuOq6LMbuy
	 yS1ADesr3o3mUX/a+66BzjrpR4rzSdtPCFJWm5xOnSWgmQxUNtob0h9Hi6QaoGqPZ8
	 81O13NsLhzqA+eU/+wzr0zOawJT+t5vR3k4zt7go=
Date: Thu, 18 Sep 2025 01:05:19 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, rdunlap@infradead.org,
	bartosz.golaszewski@linaro.org, gonzalo.silvalde@gmail.com,
	arnd@arndb.de, tzimmermann@suse.de, decui@microsoft.com,
	wei.liu@kernel.org, deller@gmx.de, kys@microsoft.com,
	haiyangz@microsoft.com
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark hyperv_fb driver Obsolete
Message-ID: <20250918080519.GB17773@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <E5C2A201B1BD>
 <1758117804-20798-1-git-send-email-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758117804-20798-1-git-send-email-ptsm@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Sep 17, 2025 at 07:03:24AM -0700, Prasanna Kumar T S M wrote:
> The hyperv_fb driver is deprecated in favor of Hyper-V DRM driver. Split
> the hyperv_fb entry from the hyperv drivers list, mark it obsolete.
> 
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6206963efbf..aa9d0fa6020b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11424,7 +11424,6 @@ F:	drivers/pci/controller/pci-hyperv-intf.c
>  F:	drivers/pci/controller/pci-hyperv.c
>  F:	drivers/scsi/storvsc_drv.c
>  F:	drivers/uio/uio_hv_generic.c
> -F:	drivers/video/fbdev/hyperv_fb.c
>  F:	include/asm-generic/mshyperv.h
>  F:	include/clocksource/hyperv_timer.h
>  F:	include/hyperv/hvgdk.h
> @@ -11438,6 +11437,16 @@ F:	include/uapi/linux/hyperv.h
>  F:	net/vmw_vsock/hyperv_transport.c
>  F:	tools/hv/
>  
> +HYPER-V FRAMEBUFFER DRIVER
> +M:	"K. Y. Srinivasan" <kys@microsoft.com>
> +M:	Haiyang Zhang <haiyangz@microsoft.com>
> +M:	Wei Liu <wei.liu@kernel.org>
> +M:	Dexuan Cui <decui@microsoft.com>
> +L:	linux-hyperv@vger.kernel.org
> +S:	Obsolete
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> +F:	drivers/video/fbdev/hyperv_fb.c
> +
>  HYPERBUS SUPPORT
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
>  R:	Tudor Ambarus <tudor.ambarus@linaro.org>
> -- 
> 2.49.0

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

