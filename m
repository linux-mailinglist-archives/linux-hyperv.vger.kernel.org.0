Return-Path: <linux-hyperv+bounces-4046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229ADA45435
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2025 04:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464163A9806
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Feb 2025 03:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1225D537;
	Wed, 26 Feb 2025 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h8E64SGI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D884253F05;
	Wed, 26 Feb 2025 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542335; cv=none; b=CtQsyCBGXGM1r9h1bc7Lhz/xau8PWXZnfTZT/dZNcAnfY5rB9j+gkP5fLPklP/6GJCntX7cd7CZGFdUc1MHG7rMOlMZg6/nZ0hIqC7sLdcoayc4FSrnA8mrOJ08VcHjn5KtwIneTzhaeMsuKWuNxvmvZsBYwtXrWiLjpe/mGhwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542335; c=relaxed/simple;
	bh=IOgnrycr1WyDhdThwz2plkVF4tNNBF3gbfroVg94MOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGyf/X/UJ4/+f8BSKfb/x9kJpJ1t7aoJbS0aDSUbRqyeAm4cl9RXzkQGyAettJK3XrlCdIEtLeng3OdYYT3JGxE9pBtSwAhULK8ecOLyavYrMgmtJ357AG0Wrcwsd6+ORQRWSUG8kQg1Adc93+VBSAEIG5T6VVOQE2UHVWH5GPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h8E64SGI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 1B46E20460A8; Tue, 25 Feb 2025 19:58:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B46E20460A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740542333;
	bh=yNYyjztGjtuVPk6nvoez8iotd+cHNDaVQ/pzCQ1fHfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8E64SGIHyZ7T5uwofjtEDo4Iq1vLHvis+riAuwYNAxQKG9QyytbxNa6cgmrHeHhf
	 GulGYp9LNgQARRep3PiPJt0yIl8BLlCZOEM5LFisdSaEQXMbML6JXdKDCrp3WBJSFM
	 lKPV2Z9QliBXrIKjHLjNmpbbE6t+l8G3qZXPqGUI=
Date: Tue, 25 Feb 2025 19:58:53 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"deller@gmx.de" <deller@gmx.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: Re: [PATCH v2] fbdev: hyperv_fb: Allow graceful removal of
 framebuffer
Message-ID: <20250226035853.GA19981@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740473808-9754-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB41574CD095A292D20AD6C84ED4C32@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574CD095A292D20AD6C84ED4C32@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 25, 2025 at 04:46:12PM +0000, Michael Kelley wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> > 
> > When a Hyper-V framebuffer device is unbind, hyperv_fb driver tries to
> > release the framebuffer forcefully. If this framebuffer is in use it
> > produce the following WARN and hence this framebuffer is never released.
> > 
> > [   44.111220] WARNING: CPU: 35 PID: 1882 at drivers/video/fbdev/core/fb_info.c:70
> > framebuffer_release+0x2c/0x40
> > < snip >
> > [   44.111289] Call Trace:
> > [   44.111290]  <TASK>
> > [   44.111291]  ? show_regs+0x6c/0x80
> > [   44.111295]  ? __warn+0x8d/0x150
> > [   44.111298]  ? framebuffer_release+0x2c/0x40
> > [   44.111300]  ? report_bug+0x182/0x1b0
> > [   44.111303]  ? handle_bug+0x6e/0xb0
> > [   44.111306]  ? exc_invalid_op+0x18/0x80
> > [   44.111308]  ? asm_exc_invalid_op+0x1b/0x20
> > [   44.111311]  ? framebuffer_release+0x2c/0x40
> > [   44.111313]  ? hvfb_remove+0x86/0xa0 [hyperv_fb]
> > [   44.111315]  vmbus_remove+0x24/0x40 [hv_vmbus]
> > [   44.111323]  device_remove+0x40/0x80
> > [   44.111325]  device_release_driver_internal+0x20b/0x270
> > [   44.111327]  ? bus_find_device+0xb3/0xf0
> > 
> > Fix this by moving the release of framebuffer and assosiated memory
> > to fb_ops.fb_destroy function, so that framebuffer framework handles
> > it gracefully.
> > 
> > While we fix this, also replace manual registrations/unregistration of
> > framebuffer with devm_register_framebuffer.
> > 
> > Fixes: 68a2d20b79b1 ("drivers/video: add Hyper-V Synthetic Video Frame Buffer
> > Driver")
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > V2 : Move hvfb_putmem into destroy()
> > 
> >  drivers/video/fbdev/hyperv_fb.c | 28 ++++++++++++++++++++++------
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> > index 363e4ccfcdb7..89ee49f1c3dc 100644
> > --- a/drivers/video/fbdev/hyperv_fb.c
> > +++ b/drivers/video/fbdev/hyperv_fb.c
> > @@ -282,6 +282,8 @@ static uint screen_depth;
> >  static uint screen_fb_size;
> >  static uint dio_fb_size; /* FB size for deferred IO */
> > 
> > +static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info);
> > +
> >  /* Send message to Hyper-V host */
> >  static inline int synthvid_send(struct hv_device *hdev,
> >  				struct synthvid_msg *msg)
> > @@ -862,6 +864,24 @@ static void hvfb_ops_damage_area(struct fb_info *info, u32 x,
> > u32 y, u32 width,
> >  		hvfb_ondemand_refresh_throttle(par, x, y, width, height);
> >  }
> > 
> > +/*
> > + * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
> > + * of unregister_framebuffer() or fb_release(). Do any cleanup related to
> > + * framebuffer here.
> > + */
> > +static void hvfb_destroy(struct fb_info *info)
> > +{
> > +	struct hv_device *hdev;
> > +	struct device *dev;
> > +	void *driver_data = (void *)info;
> > +
> > +	dev = container_of(driver_data, struct device, driver_data);
> 
> I don't think the above is right. The struct fb_info was allocated
> with kzalloc() in framebuffer_alloc(). You would use container_of()
> if fb_info was embedded in a struct device, but that's not the case
> here. The driver_data field within the struct device is a pointer to the
> fb_info, but that doesn't help find the struct device.

Thanks for catching this. I should have been more careful.

> 
> What does help is that info->device (not to be confused with info->dev,
> which is a different struct device) points to the struct device that
> you need here. That "device" field is set in framebuffer_alloc().
> So that's an easy fix.

Right, thanks.

> 
> > +	hdev = container_of(dev, struct hv_device, device);
> > +
> > +	hvfb_putmem(hdev, info);
> 
> Another observation: The interface to hvfb_putmem() is more
> complicated than it needs to be. The hdev argument could be
> dropped because it is used only to get the device pointer,
> which is already stored in info->device. hvfb_release_phymem()
> would also need to be updated to take a struct device instead of
> struct hv_device. But if you made those changes, then the
> container_of() to get the hdev wouldn't be needed either.

Make sense.

> 
> A similar simplification could be applied to hvfb_getmem().
> 
> Maybe do two patches -- the first to simplify the interfaces,
> and the second to do this patch but with reduced
> complexity because of the simpler interfaces.

Agree, let me do it in V3.

- Saurabh

> 
> Michael  
>

<snip> 

