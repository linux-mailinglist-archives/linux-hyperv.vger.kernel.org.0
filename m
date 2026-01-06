Return-Path: <linux-hyperv+bounces-8162-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65235CF968C
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 17:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0BF301B803
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF02264AA;
	Tue,  6 Jan 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iarBhat2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E13217723;
	Tue,  6 Jan 2026 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717385; cv=none; b=kWcPwZqnnlW+2c9MNublXQoEC4V0LVazm35sMD9pzxbEdLAqVQ/mFhYJ0ZE+LxqTLsjCuOsuUCUtF34CDZcPhGKdvQKhFPfkSpS+DF1EyuNA8/aWNHxhFdyc1zNm+3f/qAIc1w2qL0WK4onJri68g4CtoPrmTn0bQwhqH8MUPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717385; c=relaxed/simple;
	bh=6k0zrYstOzq5YhOnLZqPhHM6nBX2M4I0QepJOWM4vr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU+1+gcrf6FTyVi2mn+lNwxwI/uQFE4Chfz6Q/zBrZwM+HFan/UWoJr0xnDXvQZMH90cl5A/w5viMYKMx6VpAsGMZNs+HS/yr60qu+yVRNfnSuDPb8jZ1GlSThCCzSTEO3hQksq9lqMTq5Y5/PWJ5XnKxOd5cUbVzne02eJrs40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iarBhat2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id ABC4A2016FEB;
	Tue,  6 Jan 2026 08:36:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABC4A2016FEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767717377;
	bh=K2g4hqCbVfw5LedrN+ICxyvqtMqO4DyqQbnkYaYVxwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iarBhat2Hfa6Q8b/YHMYymO+vj3l7q0F7txSwrzjjW5PmKkSdpn2OH8/BHsOoJbiE
	 Yv7FYl/Pn1/Jw83Pw2ahE5/X79TYv/pkLn6D79KhcJYn5J0UAGLMjQyuubCKFW6QsM
	 9yspQ2dYRjoY5wUCi4Hghbc5PGjPUvaRReMI/UFk=
Date: Tue, 6 Jan 2026 08:36:15 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mshv: handle gpa intercepts for arm64
Message-ID: <aV05_2Lw6x8Qr_Je@skinsburskii.localdomain>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-3-anirudh@anirudhrb.com>
 <aVvvAlsohGEdC6Wv@skinsburskii.localdomain>
 <aVy4BUk9X18KiPCO@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVy4BUk9X18KiPCO@anirudh-surface.localdomain>

On Tue, Jan 06, 2026 at 07:21:41AM +0000, Anirudh Rayabharam wrote:
> On Mon, Jan 05, 2026 at 09:04:02AM -0800, Stanislav Kinsburskii wrote:
> > On Mon, Jan 05, 2026 at 12:28:37PM +0000, Anirudh Rayabharam wrote:
> > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > 
> > > The mshv driver now uses movable pages for guests. For arm64 guests
> > > to be functional, handle gpa intercepts for arm64 too (the current
> > > code implements handling only for x86).
> > > 
> > > Move some arch-agnostic functions out of #ifdefs so that they can be
> > > re-used.
> > > 
> > > Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
> > 
> > I'm not sure that this patch needs "Fixes" tag as it introduced new
> > functionality rather than fixing a bug.
> 
> This does fix a bug. The commit mentioned here regressed arm64 guests because
> it didn't have GPA intercept handling for arm64.
> 

Were ARM guests functional before this commit? If yes, then I agree that
this patch fixes a bug. If no, then this is just adding new
functionality.
I had an impression ARM is not yet supported in MSHV, so please clarify.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > 
> > Thanks,
> > Stanislav
> > 
> > > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > ---
> > >  drivers/hv/mshv_root_main.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > > index 9cf28a3f12fe..f8c4c2ae2cc9 100644
> > > --- a/drivers/hv/mshv_root_main.c
> > > +++ b/drivers/hv/mshv_root_main.c
> > > @@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
> > >  	return NULL;
> > >  }
> > >  
> > > -#ifdef CONFIG_X86_64
> > >  static struct mshv_mem_region *
> > >  mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
> > >  {
> > > @@ -640,12 +639,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> > >  {
> > >  	struct mshv_partition *p = vp->vp_partition;
> > >  	struct mshv_mem_region *region;
> > > -	struct hv_x64_memory_intercept_message *msg;
> > >  	bool ret;
> > >  	u64 gfn;
> > > -
> > > -	msg = (struct hv_x64_memory_intercept_message *)
> > > +#if defined(CONFIG_X86_64)
> > > +	struct hv_x64_memory_intercept_message *msg =
> > > +		(struct hv_x64_memory_intercept_message *)
> > > +		vp->vp_intercept_msg_page->u.payload;
> > > +#elif defined(CONFIG_ARM64)
> > > +	struct hv_arm64_memory_intercept_message *msg =
> > > +		(struct hv_arm64_memory_intercept_message *)
> > >  		vp->vp_intercept_msg_page->u.payload;
> > > +#endif
> > >  
> > >  	gfn = HVPFN_DOWN(msg->guest_physical_address);
> > >  
> > > @@ -663,9 +667,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> > >  
> > >  	return ret;
> > >  }
> > > -#else  /* CONFIG_X86_64 */
> > > -static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
> > > -#endif /* CONFIG_X86_64 */
> > >  
> > >  static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
> > >  {
> > > -- 
> > > 2.34.1
> > > 

