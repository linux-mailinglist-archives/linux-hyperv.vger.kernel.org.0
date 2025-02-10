Return-Path: <linux-hyperv+bounces-3877-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06990A2F44A
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062DE7A301F
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F23D24FBFC;
	Mon, 10 Feb 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hCtlyfve"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04592586D7;
	Mon, 10 Feb 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206343; cv=none; b=Ae6ZXmBR2mBP8cOF1X1c3nW4KA8pjDA5zccJvTqnej+w9+VN3Lbzx2Xz9CVIwBwT4p3LCGueIEc7WFqstklyNd9s+G0a3H6RhidnPznqjmwtiVEHAiLGRuGLnKsnJrL0m5kTxWemaBfx7Gpgudkf9GYSXInXPNaill4TnTLfhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206343; c=relaxed/simple;
	bh=RiMDqK8v5ymB6cNFg5jJfkHKtoa/w75xCLgD+8KIK4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC2fXSLEo7DJ/AUv4arGo5tAlNttvnxCDsbWRytA8XTR3uJPeQVKYLqP510/gsSFo5b8VSqHqo174xETCSq61Ct7MT6DP7JefHTJ4gxp/qUx9Yzm/dLsXx6ttGC7FWgXrz+BjCAlPmJ8tjtV4XIYlQilfJHE6DI77nxClxwc0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hCtlyfve; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 484732107A8B; Mon, 10 Feb 2025 08:52:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 484732107A8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739206341;
	bh=xg4lP2wNJKixLEmiZc3el6EzPCqZEJ2Rl4qEXXluYG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCtlyfveG7fVZ9XOkmRYI97qzjX4INqUxUNN8oNsnAOyHi8jNKTsn0HPnl7ANt8dU
	 k4tX/cpcxj/x/JijFIwVbrJkqLj34pVAGgm3ZTZ1aCq2iiZVHouo9SKojUa75Gqc1b
	 uvT4DF+gH36zOgGxFdUCNDfJx/WxPGbWi/tK1Qzg=
Date: Mon, 10 Feb 2025 08:52:21 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"deller@gmx.de" <deller@gmx.de>,
	"weh@microsoft.com" <weh@microsoft.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] fbdev: hyperv_fb: iounmap() the correct memory when
 removing a device
Message-ID: <20250210165221.GA3465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250209235252.2987-1-mhklinux@outlook.com>
 <20250210124043.GA17819@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157B0F36D7B99A5BF01471CD4F22@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250210145825.GA12377@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210145825.GA12377@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 10, 2025 at 06:58:25AM -0800, Saurabh Singh Sengar wrote:
> On Mon, Feb 10, 2025 at 02:28:35PM +0000, Michael Kelley wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Monday, February 10, 2025 4:41 AM
> > > 
> > > On Sun, Feb 09, 2025 at 03:52:52PM -0800, mhkelley58@gmail.com wrote:
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > >
> > > > When a Hyper-V framebuffer device is removed, or the driver is unbound
> > > > from a device, any allocated and/or mapped memory must be released. In
> > > > particular, MMIO address space that was mapped to the framebuffer must
> > > > be unmapped. Current code unmaps the wrong address, resulting in an
> > > > error like:
> > > >
> > > > [ 4093.980597] iounmap: bad address 00000000c936c05c
> > > >
> > > > followed by a stack dump.
> > > >
> > > > Commit d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for
> > > > Hyper-V frame buffer driver") changed the kind of address stored in
> > > > info->screen_base, and the iounmap() call in hvfb_putmem() was not
> > > > updated accordingly.
> > > >
> > > > Fix this by updating hvfb_putmem() to unmap the correct address.
> > > >
> > > > Fixes: d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
> > > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > > ---
> > > >  drivers/video/fbdev/hyperv_fb.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> > > > index 7fdb5edd7e2e..363e4ccfcdb7 100644
> > > > --- a/drivers/video/fbdev/hyperv_fb.c
> > > > +++ b/drivers/video/fbdev/hyperv_fb.c
> > > > @@ -1080,7 +1080,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
> > > >
> > > >  	if (par->need_docopy) {
> > > >  		vfree(par->dio_vp);
> > > > -		iounmap(info->screen_base);
> > > > +		iounmap(par->mmio_vp);
> > > >  		vmbus_free_mmio(par->mem->start, screen_fb_size);
> > > >  	} else {
> > > >  		hvfb_release_phymem(hdev, info->fix.smem_start,
> > > > --
> > > > 2.25.1
> > > >
> > > 
> > > Thanks for fixing this:
> > > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > 
> > > 
> > > While we are at it, I want to mention that I also observed below WARN
> > > while removing the hyperv_fb, but that needs a separate fix.
> > > 
> > > 
> > > [   44.111220] WARNING: CPU: 35 PID: 1882 at drivers/video/fbdev/core/fb_info.c:70 framebuffer_release+0x2c/0x40
> > > < snip >
> > > [   44.111289] Call Trace:
> > > [   44.111290]  <TASK>
> > > [   44.111291]  ? show_regs+0x6c/0x80
> > > [   44.111295]  ? __warn+0x8d/0x150
> > > [   44.111298]  ? framebuffer_release+0x2c/0x40
> > > [   44.111300]  ? report_bug+0x182/0x1b0
> > > [   44.111303]  ? handle_bug+0x6e/0xb0
> > > [   44.111306]  ? exc_invalid_op+0x18/0x80
> > > [   44.111308]  ? asm_exc_invalid_op+0x1b/0x20
> > > [   44.111311]  ? framebuffer_release+0x2c/0x40
> > > [   44.111313]  ? hvfb_remove+0x86/0xa0 [hyperv_fb]
> > > [   44.111315]  vmbus_remove+0x24/0x40 [hv_vmbus]
> > > [   44.111323]  device_remove+0x40/0x80
> > > [   44.111325]  device_release_driver_internal+0x20b/0x270
> > > [   44.111327]  ? bus_find_device+0xb3/0xf0
> > > 
> > 
> > Thanks for pointing this out. Interestingly, I'm not seeing this WARN
> > in my experiments. What base kernel are you testing with? Are you
> > testing on a local VM or in Azure? What exactly are you doing
> > to create the problem? I've been doing unbind of the driver,
> > but maybe you are doing something different.
> > 
> > FWIW, there is yet another issue where after doing two unbind/bind
> > cycles of the hyperv_fb driver, there's an error about freeing a
> > non-existent resource. I know what that problem is, and it's in
> > vmbus_drv.c. I'll be submitting a patch for that as soon as I figure out
> > a clean fix.
> > 
> > Michael
> 
> This is on local Hyper-V. Kernel: 6.14.0-rc1-next-20250205+
> I run below command to reproduce the above error:
> echo "5620e0c7-8062-4dce-aeb7-520c7ef76171" > /sys/bus/vmbus/devices/5620e0c7-8062-4dce-aeb7-520c7ef76171/driver/unbind
> 
> When hvfb_remove is called I can see the refcount for framebuffer is 2 when ,
> I expect it to be 1. After unregistering this framebuffer there is still 1 refcount
> remains, which is the reason for this WARN at the time of framebuffer_release.
> 
> I wonder who is registering/using this extra framebuffer. Its not hyperv_drm or
> hyperv_fb IIUC.
> 
> - Saurabh

Here are more details about this WARN:  

Xorg opens `/dev/fb0`, which increases the framebuffer's reference
count, as mentioned above.  As a result, when unbinding the driver,
this WARN is expected, indicating that the framebuffer is still in use.  

I am open to suggestion what could be the correct behavior in this case.
There acan be two possible options:

 1. Check the framebuffer reference count and prevent the driver from
    unbinding/removal.
OR

 2. Allow the driver to unbind while issuing this WARN. (Current scenario)

- Saurabh


