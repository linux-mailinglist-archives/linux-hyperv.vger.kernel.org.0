Return-Path: <linux-hyperv+bounces-1507-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A35848478
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Feb 2024 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15356B276A7
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Feb 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275404F1E9;
	Sat,  3 Feb 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k0OfUKLR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30F4EB25;
	Sat,  3 Feb 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706947732; cv=none; b=tgvzkD806y3DRlo47+c6IxjOTYPjbcmvTc618rQVSxyfs1p7AgEaIjb8qg2vhDKJ5ye/RfHNuNFZorwD6eYhl+h1BbqxxYnxru7N185pKjAd/N3o+y9PqcOzUoCT9H1wWSOG96yxHluPaTpBbPzeDNl+hXANCKSeaAgS9e0cFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706947732; c=relaxed/simple;
	bh=XGVfjG+sAX4pMvyR7XEzs8ZfGkMlTIaJ8Nl+H+MNGAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctpWMBoLkD72BDzsX32EDuRh3WMlkHZFS05lokdA4wklPvQ/aDHsFaJxelcJeW9OYk2N+3MT0WkhXdQq7VUrDuWh4oyAEpbgoeg0SSUJIohJbo5X1OL7yo57PiZ59mZw9rvVgr8yhby1wZjmTfxMPRRI8HS/aSYwjEaLFk5jP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k0OfUKLR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1FEF220B2000; Sat,  3 Feb 2024 00:08:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FEF220B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706947730;
	bh=07vG+62V6dqAkeDJQ2J+ZqfY5Na7tXr+v+0St/Ckcu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0OfUKLRSHYVPhHV1EpWNPpWC6i1WTJcXBa2tZvc8JfqeyLHc9hXmmyjLL/7PFfog
	 jZJk6fA7GbUoUCKRkLzRxY4HXST8rtvY0yxHbkTq8Mp07BNna9WUOBpKl9iTna8PjU
	 D71g3xP55ydTQQjUHFGqhRYznWbhCF8MUzZA39ac=
Date: Sat, 3 Feb 2024 00:08:50 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	drawat.floss@gmail.com, javierm@redhat.com, deller@gmx.de,
	daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] fbdev/hyperv_fb: Fix logic error for Gen2 VMs in
 hvfb_getmem()
Message-ID: <20240203080850.GA29113@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240201060022.233666-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201060022.233666-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jan 31, 2024 at 10:00:22PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> A recent commit removing the use of screen_info introduced a logic
> error. The error causes hvfb_getmem() to always return -ENOMEM
> for Generation 2 VMs. As a result, the Hyper-V frame buffer
> device fails to initialize. The error was introduced by removing
> an "else if" clause, leaving Gen2 VMs to always take the -ENOMEM
> error path.
> 
> Fix the problem by removing the error path "else" clause. Gen 2
> VMs now always proceed through the MMIO memory allocation code,
> but with "base" and "size" defaulting to 0.
> 
> Fixes: 0aa0838c84da ("fbdev/hyperv_fb: Remove firmware framebuffers with aperture helpers")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/video/fbdev/hyperv_fb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index c26ee6fd73c9..8fdccf033b2d 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1010,8 +1010,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
>  			goto getmem_done;
>  		}
>  		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
> -	} else {
> -		goto err1;
>  	}
>  
>  	/*
> -- 
> 2.25.1
>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 

