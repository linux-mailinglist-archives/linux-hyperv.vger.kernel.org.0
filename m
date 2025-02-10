Return-Path: <linux-hyperv+bounces-3870-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C608BA2ECBF
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FAB1633C5
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A360222589;
	Mon, 10 Feb 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OxRUHTXd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B17B222575;
	Mon, 10 Feb 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191246; cv=none; b=u0k+r2dJdzNTgrRWKlQTTUwrfjJxH9dCujU6egx6jxA03OovWau42uONzdkDiq0IPbhzDc0bNiZyDy1uCQlYtgthgysLKslPWn4fPAjIcjkCtqUcETm6dHnvM+tAg4cPcvB96JyZ0gisczuWRdNVZcIuDLIgNC0HoLxrW2xdUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191246; c=relaxed/simple;
	bh=m1dC3wAs/C8yO9cEPD+VrhTtWYrPjXjGjtcl08nIDb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg4g4xqcgtKLRtYFAC5nE4Nax486n50p4CtXgQD0HvmDbGBFJUsr3HdmMNtFzYPdvzlB6pDONQxWWPgjk3aBYrFv+JIg0xZzvbZJ9Z0CtGuY92OzJZ1q+tWcO5A8qmW5TsqUVRkDQufXNY36ACoLsXSd6B6rWJUvOUdlDdVLooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OxRUHTXd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0152B2107A86; Mon, 10 Feb 2025 04:40:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0152B2107A86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739191244;
	bh=hLZx6MVYBXXvnjTCLMRlelDAcLfnwQnhJR4gDFyvKdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxRUHTXdo4hKBQsXPqPNf/06aYINajw8CyomamMP2+qSvkuTZ1axpoHZejUQpqp0Y
	 wOgyP8rvQFOPLNo6A/bbElQSh99T4nxkzV3xkdt7lxTp+/v/+Lxld35Qj8p937mb9z
	 sqwAkGnnLb3VTphK6DGC1rWuespF43GI8DRJQEuU=
Date: Mon, 10 Feb 2025 04:40:43 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	deller@gmx.de, weh@microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] fbdev: hyperv_fb: iounmap() the correct memory when
 removing a device
Message-ID: <20250210124043.GA17819@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250209235252.2987-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209235252.2987-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Feb 09, 2025 at 03:52:52PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When a Hyper-V framebuffer device is removed, or the driver is unbound
> from a device, any allocated and/or mapped memory must be released. In
> particular, MMIO address space that was mapped to the framebuffer must
> be unmapped. Current code unmaps the wrong address, resulting in an
> error like:
> 
> [ 4093.980597] iounmap: bad address 00000000c936c05c
> 
> followed by a stack dump.
> 
> Commit d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for
> Hyper-V frame buffer driver") changed the kind of address stored in
> info->screen_base, and the iounmap() call in hvfb_putmem() was not
> updated accordingly.
> 
> Fix this by updating hvfb_putmem() to unmap the correct address.
> 
> Fixes: d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/video/fbdev/hyperv_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 7fdb5edd7e2e..363e4ccfcdb7 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1080,7 +1080,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
>  
>  	if (par->need_docopy) {
>  		vfree(par->dio_vp);
> -		iounmap(info->screen_base);
> +		iounmap(par->mmio_vp);
>  		vmbus_free_mmio(par->mem->start, screen_fb_size);
>  	} else {
>  		hvfb_release_phymem(hdev, info->fix.smem_start,
> -- 
> 2.25.1
> 

Thanks for fixing this:
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>


While we are at it, I want to mention that I also observed below WARN
while removing the hyperv_fb, but that needs a separate fix.


[   44.111220] WARNING: CPU: 35 PID: 1882 at drivers/video/fbdev/core/fb_info.c:70 framebuffer_release+0x2c/0x40
< snip >
[   44.111289] Call Trace:
[   44.111290]  <TASK>
[   44.111291]  ? show_regs+0x6c/0x80
[   44.111295]  ? __warn+0x8d/0x150
[   44.111298]  ? framebuffer_release+0x2c/0x40
[   44.111300]  ? report_bug+0x182/0x1b0
[   44.111303]  ? handle_bug+0x6e/0xb0
[   44.111306]  ? exc_invalid_op+0x18/0x80
[   44.111308]  ? asm_exc_invalid_op+0x1b/0x20
[   44.111311]  ? framebuffer_release+0x2c/0x40
[   44.111313]  ? hvfb_remove+0x86/0xa0 [hyperv_fb]
[   44.111315]  vmbus_remove+0x24/0x40 [hv_vmbus]
[   44.111323]  device_remove+0x40/0x80
[   44.111325]  device_release_driver_internal+0x20b/0x270
[   44.111327]  ? bus_find_device+0xb3/0xf0

- Saurabh


