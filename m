Return-Path: <linux-hyperv+bounces-6935-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C02B836CE
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037FB189E037
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7FC2EF662;
	Thu, 18 Sep 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hvLKUexk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3552BE65C;
	Thu, 18 Sep 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182701; cv=none; b=aelqFQIvpvMYC0ZmfB1cswyKXAAHueN8aiLXHzcPfHNqN0ChIOD6biHVHEMpU2Dbfdx8a89TlWpRjb4TB7fTSh9LAN6ejPQfyBwPeTb0AAHz9I+8k+jSHWtYvokEKir3FGmj0gIKa+eEDlp6EjI9VylnrtRi15mYac5IaKey9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182701; c=relaxed/simple;
	bh=JWQmjkJVqasXSEL3jknfHp+w+Yg/68tfM4ww+QZFNg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ytw+j1FJe0XN64t7MN0AZlfG2r7y45mjvQSfo+RkGdwEseVzxG2JOvrzoERn5EwS5ApWmqPqxkRNA4SbbSfAy8Tr7DyYJ7Cdfv9YT8FERdW/dp5r2ujHd3Vsd3z5hZuLw/fA/fz6/coIJnYaJkQW+7gGgBkP4SB3ity751uOQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hvLKUexk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 2AEC820143D2; Thu, 18 Sep 2025 01:04:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2AEC820143D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758182693;
	bh=MOUqalofeahNoTixGAy7MlIUq0vm6rw3ZxM2+iKViC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvLKUexkKhhudfDgCiJR9/sOFaWVEWKPP9hEWMRAtraYvzA0RCdCpXdnHFHXNyUYu
	 gu8D8WyxWtIydi1/se18PBKm06RsicKFzjP0HEE8ei+uEeKox77APir+hjQCflT2Yv
	 zEtlryxBuxLW7CPYUP/xsoyah5edP4SPU3g3P+fM=
Date: Thu, 18 Sep 2025 01:04:53 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, rdunlap@infradead.org,
	bartosz.golaszewski@linaro.org, gonzalo.silvalde@gmail.com,
	arnd@arndb.de, tzimmermann@suse.de, decui@microsoft.com,
	wei.liu@kernel.org, deller@gmx.de, kys@microsoft.com,
	haiyangz@microsoft.com
Subject: Re: [PATCH 1/2] fbdev/hyperv_fb: deprecate this in favor of Hyper-V
 DRM driver
Message-ID: <20250918080453.GA17773@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <E5C2A201B1BD>
 <1758117785-20653-1-git-send-email-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758117785-20653-1-git-send-email-ptsm@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Sep 17, 2025 at 07:03:05AM -0700, Prasanna Kumar T S M wrote:
> The Hyper-V DRM driver is available since kernel version 5.14 and it
> provides full KMS support and fbdev emulation via the DRM fbdev helpers.
> Deprecate this driver in favor of Hyper-V DRM driver.
> 
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> ---
>  drivers/video/fbdev/Kconfig     | 5 ++++-
>  drivers/video/fbdev/hyperv_fb.c | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index c21484d15f0c..48c1c7417f6d 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1773,13 +1773,16 @@ config FB_BROADSHEET
>  	  a bridge adapter.
>  
>  config FB_HYPERV
> -	tristate "Microsoft Hyper-V Synthetic Video support"
> +	tristate "Microsoft Hyper-V Synthetic Video support (DEPRECATED)"
>  	depends on FB && HYPERV
>  	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
>  	select FB_IOMEM_HELPERS_DEFERRED
>  	help
>  	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
>  
> +	  This driver is deprecated, please use the Hyper-V DRM driver at
> +	  drivers/gpu/drm/hyperv (CONFIG_DRM_HYPERV) instead.
> +
>  config FB_SIMPLE
>  	tristate "Simple framebuffer support"
>  	depends on FB
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 75338ffc703f..c99e2ea4b3de 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1357,6 +1357,8 @@ static int __init hvfb_drv_init(void)
>  {
>  	int ret;
>  
> +	pr_warn("Deprecated: use Hyper-V DRM driver instead\n");
> +
>  	if (fb_modesetting_disabled("hyper_fb"))
>  		return -ENODEV;
>  
> -- 
> 2.49.0

Thanks for the patch. I hope it makes to the next LTS as planned.

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

