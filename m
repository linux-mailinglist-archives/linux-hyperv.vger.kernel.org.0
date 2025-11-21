Return-Path: <linux-hyperv+bounces-7744-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF7C7860C
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 69CE72D5FC
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F413263F54;
	Fri, 21 Nov 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OxMhB51G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8762B2D7;
	Fri, 21 Nov 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719846; cv=none; b=GKrDXRsKsLb3pIbZHvSe8XU1e1qy4w3vVf3TiFUo739yDrz37528SYamCKLyRoODDOgMUjDc1auaPkf6dF/u6cGYnBssQ43Y53pWsyH3RO59K9dsJBBcp36nP35pkQDm3R4T7fN9zEMTv3ntFzSwYjnuXFnp2XqOB8bm3NN16N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719846; c=relaxed/simple;
	bh=DG8gxGiLTDGMVfSPH5prHuw5IIa17sjz3Pk9+8I80D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxRS+GjsDKn6g2kuCQ/LKHiuzFwL5xXjljxSctVc1Jyl+huM1dtNfB+OSuOuAV+hIqKdv2mt/nBKKkQ6r0z+tHLMA0OIXG0ImOBcIUoVnRHu5DPn2n8gZYLYaq3+qQEohzH8JJpaCrE+wffHCEGSBeplF9Kg0fOeF+Dz4MhHj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OxMhB51G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334F0C4CEF1;
	Fri, 21 Nov 2025 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763719845;
	bh=DG8gxGiLTDGMVfSPH5prHuw5IIa17sjz3Pk9+8I80D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxMhB51Gt2B2raYIjZvCwsCWgqBbfAxoZ0w+CudDhPp4h2m5+dZkmOSE7y9vZ0u0n
	 jPhA6cRVBsyk+yjHWlKA7I9+do9IgovK8jZCXQ2bq8KpPPUtIX1lp/c8yYJR+CBhXu
	 pnko81y00rd7Eg1j6yGmcwa/4id/bZ9oZkwpJY+w=
Date: Fri, 21 Nov 2025 11:10:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	Peter Morrow <pdmorrow@gmail.com>
Subject: Re: [PATCH 6.6 and older] uio_hv_generic: Enable user space to
 manage interrupt_mask for subchannels
Message-ID: <2025112109-legroom-resend-643f@gregkh>
References: <20251115085937.2237-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115085937.2237-1-namjain@linux.microsoft.com>

On Sat, Nov 15, 2025 at 02:29:37PM +0530, Naman Jain wrote:
> From: Long Li <longli@microsoft.com>
> 
> Enable the user space to manage interrupt_mask for subchannels through
> irqcontrol interface for uio device. Also remove the memory barrier
> when monitor bit is enabled as it is not necessary.
> 
> This is a backport of the upstream commit
> d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
> with some modifications to resolve merge conflicts and take care of
> missing support for slow devices on older kernels.
> Original change was not a fix, but it needs to be backported to fix a
> NULL pointer crash resulting from missing interrupt mask setting.
> 
> Commit 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
> removed the default setting of interrupt_mask for channels (including
> subchannels) in the uio_hv_generic driver, as it relies on the user space
> to take care of managing it. This approach works fine when user space
> can control this setting using the irqcontrol interface provided for uio
> devices. Support for setting the interrupt mask through this interface for
> subchannels came only after commit d062463edf17 ("uio_hv_generic: Set event
> for all channels on the device"). On older kernels, this change is not
> present. With uio_hv_generic no longer setting the interrupt_mask, and
> userspace not having the capability to set it, it remains unset,
> and interrupts can come for the subchannels, which can result in a crash
> in hv_uio_channel_cb. Backport the change to older kernels, where this
> change was not present, to allow userspace to set the interrupt mask
> properly for subchannels. Additionally, this patch also adds certain
> checks for primary vs subchannels in the hv_uio_channel_cb, which can
> gracefully handle these two cases and prevent the NULL pointer crashes.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Fixes: 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")

This is a 6.12.y commit id, so a fix for 6.6.y does not make sense :(

> Closes: https://bugs.debian.org/1120602
> Cc: <stable@vger.kernel.org> # 6.6.x and older

How "old" do you want this?  Can you fix the Fixes: line up and resend
with this info?

thanks,

greg k-h

