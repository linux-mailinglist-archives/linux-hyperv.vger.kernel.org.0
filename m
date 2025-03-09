Return-Path: <linux-hyperv+bounces-4301-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B0A5808B
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 05:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BA43A9416
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 04:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514B12C499;
	Sun,  9 Mar 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r5jIQCM+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FBA1D554;
	Sun,  9 Mar 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741495820; cv=none; b=iUGdr5goWmqxPShNbWPlyDXOaX0E3qY7AiPN8GqOHP4zKBxoMPEPi5SD3ulh/b5/CYWcMQEJypDgf3SY6SQm+3y2c5RIxT9/6WY9UpKqqWqR9I0iugoY94aqkUN9ujcl03fpPv6pofeibLcobXGb+IkIYgbMDZA/pcR58o+LBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741495820; c=relaxed/simple;
	bh=zddh1ZrzZxyTo254SntkmgsZ3r6yT41PDbl8AJjBho0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIMu1UW0p52dO9uz10L33F0kua3VcWJkrpcZWsvP3MRoRh3AZkpXnyK5zox2n7uAk7hy9dyMoxxmHftYUGMOEid05Ugvbu3y4ZIn02HgY95SV5MuGIW6uQt9XVXwalf+bXv0NwjZQsY1mI5Bb30kkEZ12MXUDmIouc9S+Y5RlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r5jIQCM+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id A1A272111406; Sat,  8 Mar 2025 20:50:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1A272111406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741495812;
	bh=uDnlYrlw8dqgGid0QmMSbdigA/GmLu/A3cU6Y8+tvOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5jIQCM+EJ/pOORo/ZqO1FE3+1OMTGp+BqfqkY/Sww1cZFYo4ptHFuPgGL0d7p03q
	 4Vwh3KCz264vVSMYIG1VZ5qtoSjmT3s2R8h4xrI8ry60rQYuL6xxYhRH7d89heIw5z
	 wywlSKeGAZsVp0tFQ4FZDA6cHNzjx+yU8G6WBnjU=
Date: Sat, 8 Mar 2025 20:50:12 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	kys@microsoft.com, jakeo@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Don't release fb_mmio resource
 in vmbus_free_mmio()
Message-ID: <20250309045012.GA14928@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250211050114.1716-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211050114.1716-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 10, 2025 at 09:01:14PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The VMBus driver manages the MMIO space it owns via the hyperv_mmio
> resource tree. Because the synthetic video framebuffer portion of the
> MMIO space is initially setup by the Hyper-V host for each guest, the
> VMBus driver does an early reserve of that portion of MMIO space in the
> hyperv_mmio resource tree. It saves a pointer to that resource in
> fb_mmio. When a VMBus driver requests MMIO space and passes "true"
> for the "fb_overlap_ok" argument, the reserved framebuffer space is
> used if possible. In that case it's not necessary to do another request
> against the "shadow" hyperv_mmio resource tree because that resource
> was already requested in the early reserve steps.
> 
> However, the vmbus_free_mmio() function currently does no special
> handling for the fb_mmio resource. When a framebuffer device is
> removed, or the driver is unbound, the current code for
> vmbus_free_mmio() releases the reserved resource, leaving fb_mmio
> pointing to memory that has been freed. If the same or another
> driver is subsequently bound to the device, vmbus_allocate_mmio()
> checks against fb_mmio, and potentially gets garbage. Furthermore
> a second unbind operation produces this "nonexistent resource" error
> because of the unbalanced behavior between vmbus_allocate_mmio() and
> vmbus_free_mmio():
> 
> [   55.499643] resource: Trying to free nonexistent
> 			resource <0x00000000f0000000-0x00000000f07fffff>
> 
> Fix this by adding logic to vmbus_free_mmio() to recognize when
> MMIO space in the fb_mmio reserved area would be released, and don't
> release it. This filtering ensures the fb_mmio resource always exists,
> and makes vmbus_free_mmio() more parallel with vmbus_allocate_mmio().
> 
> Fixes: be000f93e5d7 ("drivers:hv: Track allocations of children of hv_vmbus in private resource tree")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/vmbus_drv.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2892b8da20a5..7507b3641ebd 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2262,12 +2262,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
>  	struct resource *iter;
>  
>  	mutex_lock(&hyperv_mmio_lock);
> +
> +	/*
> +	 * If all bytes of the MMIO range to be released are within the
> +	 * special case fb_mmio shadow region, skip releasing the shadow
> +	 * region since no corresponding __request_region() was done
> +	 * in vmbus_allocate_mmio().
> +	 */
> +	if (fb_mmio && (start >= fb_mmio->start) &&
> +				(start + size - 1 <= fb_mmio->end))
> +		goto skip_shadow_release;
> +
>  	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
>  		if ((iter->start >= start + size) || (iter->end <= start))
>  			continue;
>  
>  		__release_region(iter, start, size);
>  	}
> +
> +skip_shadow_release:
>  	release_mem_region(start, size);
>  	mutex_unlock(&hyperv_mmio_lock);
>  
> -- 
> 2.25.1
> 

Thanks for the fix.
There are couple of checkpatch.pl --strict CHECK, post fixing that:

Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Regards,
Saurabh

