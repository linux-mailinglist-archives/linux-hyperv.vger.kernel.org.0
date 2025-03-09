Return-Path: <linux-hyperv+bounces-4318-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E7A5895B
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 00:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DB7167357
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 23:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333D21DE883;
	Sun,  9 Mar 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehu3zJIz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3E1AA1C9;
	Sun,  9 Mar 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741564206; cv=none; b=EjhLQXKVzRhHlz/OY82qzDIcEwgdOGg+0Ht2Fkrb45ll7xTXaN+4DHxZtWQdl++6D/OVctoSUCC1Xl1mtVdAoT7gMvwm6mYDepzynR7Y6SZBUntgdSthhRW3jtE+xQDf2ckr6aL7MfyIgIYn5CoN7UjbUNtD7FUvVp93knEQqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741564206; c=relaxed/simple;
	bh=Z8pyKgmEXzbyqI1IrlHtstG5m3fvBXpf3yyjLA7Q4UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TthIBGEiXG8ZI0ptg08jg7zywiJ33DaGT+jbr4Aqbq8kJeQLf8KsxAXN6zYgYeIN7vElom5dwO4l/Vtd0gDNFL6ST7E21DnBPYIGVYoNHSJNxwGg9hNKwPu2/9IGk2bBO5z7qCV8iiBp0fOCJYeyOIVmSDJCmWobiV7slDu4/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehu3zJIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61149C4CEE3;
	Sun,  9 Mar 2025 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741564205;
	bh=Z8pyKgmEXzbyqI1IrlHtstG5m3fvBXpf3yyjLA7Q4UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ehu3zJIzYlGhpoEA9tgzhDEFzRGNOJT1/CS0v/RYJ3X5gWi8m5dsp9vNf1shPbqj6
	 WH3Ee8AHAt1jhp1x/qimaelhneS/dtaRUFBcq+k/hXRfbzWv7YT7FuK6wqJJHstJep
	 i3sPHFQC2eHyjZNZ39s4yyGBgYj/0c3w5L1f3ETUENCVodiIB1vRVhtTh/t+oqQCpW
	 3r2ys4XYZEa/QkvhX4VYLLDa3CwkCgTJopHCy9nSAuUe7L0I03FzhLauPtzBCAd7ow
	 l/PHmpvLa3ZbpjLzcy0qAbLnPXju7ACKEUrzQVj+SJBPxM8TiYGwoa7zR8/5ADV0qJ
	 veVCUNBC3HqTg==
Date: Sun, 9 Mar 2025 23:50:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, kys@microsoft.com, jakeo@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Don't release fb_mmio resource
 in vmbus_free_mmio()
Message-ID: <Z84pLHrwB-iTt2_V@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250211050114.1716-1-mhklinux@outlook.com>
 <20250309045012.GA14928@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309045012.GA14928@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Sat, Mar 08, 2025 at 08:50:12PM -0800, Saurabh Singh Sengar wrote:
> On Mon, Feb 10, 2025 at 09:01:14PM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > The VMBus driver manages the MMIO space it owns via the hyperv_mmio
> > resource tree. Because the synthetic video framebuffer portion of the
> > MMIO space is initially setup by the Hyper-V host for each guest, the
> > VMBus driver does an early reserve of that portion of MMIO space in the
> > hyperv_mmio resource tree. It saves a pointer to that resource in
> > fb_mmio. When a VMBus driver requests MMIO space and passes "true"
> > for the "fb_overlap_ok" argument, the reserved framebuffer space is
> > used if possible. In that case it's not necessary to do another request
> > against the "shadow" hyperv_mmio resource tree because that resource
> > was already requested in the early reserve steps.
> > 
> > However, the vmbus_free_mmio() function currently does no special
> > handling for the fb_mmio resource. When a framebuffer device is
> > removed, or the driver is unbound, the current code for
> > vmbus_free_mmio() releases the reserved resource, leaving fb_mmio
> > pointing to memory that has been freed. If the same or another
> > driver is subsequently bound to the device, vmbus_allocate_mmio()
> > checks against fb_mmio, and potentially gets garbage. Furthermore
> > a second unbind operation produces this "nonexistent resource" error
> > because of the unbalanced behavior between vmbus_allocate_mmio() and
> > vmbus_free_mmio():
> > 
> > [   55.499643] resource: Trying to free nonexistent
> > 			resource <0x00000000f0000000-0x00000000f07fffff>
> > 
> > Fix this by adding logic to vmbus_free_mmio() to recognize when
> > MMIO space in the fb_mmio reserved area would be released, and don't
> > release it. This filtering ensures the fb_mmio resource always exists,
> > and makes vmbus_free_mmio() more parallel with vmbus_allocate_mmio().
> > 
> > Fixes: be000f93e5d7 ("drivers:hv: Track allocations of children of hv_vmbus in private resource tree")
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 2892b8da20a5..7507b3641ebd 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2262,12 +2262,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
> >  	struct resource *iter;
> >  
> >  	mutex_lock(&hyperv_mmio_lock);
> > +
> > +	/*
> > +	 * If all bytes of the MMIO range to be released are within the
> > +	 * special case fb_mmio shadow region, skip releasing the shadow
> > +	 * region since no corresponding __request_region() was done
> > +	 * in vmbus_allocate_mmio().
> > +	 */
> > +	if (fb_mmio && (start >= fb_mmio->start) &&
> > +				(start + size - 1 <= fb_mmio->end))
> > +		goto skip_shadow_release;
> > +
> >  	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
> >  		if ((iter->start >= start + size) || (iter->end <= start))
> >  			continue;
> >  
> >  		__release_region(iter, start, size);
> >  	}
> > +
> > +skip_shadow_release:
> >  	release_mem_region(start, size);
> >  	mutex_unlock(&hyperv_mmio_lock);
> >  
> > -- 
> > 2.25.1
> > 
> 
> Thanks for the fix.
> There are couple of checkpatch.pl --strict CHECK, post fixing that:
> 
> Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

I will wait for a new version with the checkpatch.pl issues fixed.

Wei.

