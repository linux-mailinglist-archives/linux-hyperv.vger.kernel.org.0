Return-Path: <linux-hyperv+bounces-8048-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9DCC6022
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 06:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E413037CEB
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 05:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE66215075;
	Wed, 17 Dec 2025 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="lPuquQ1R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE724678F;
	Wed, 17 Dec 2025 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948236; cv=pass; b=A10WuBAsPppQP7tDqsct1rfxLJpTLiEqdsbxhTua8TXjC+Hu+LlQ2kW4dHpAStOa+F8plOcGBexPPhh18NslKSCI1zQe+5rRk7ds/GVyPH/FJ2kay5415hEVXbcU6e4VS37TOiP/jjGUMyv05GJaG8tS43Nlq9Qnd5okSDHn7xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948236; c=relaxed/simple;
	bh=4AopNh3I0HvFdEeSBFgfAQAsyqJ7xmwXF6/ILaGB1Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqyHNBfyuHcNxSZMtP27TqFyTm1DfqPy6LgZuAeePxB70rJpnRQJ+7R0K6RkbtbP+ML6ATnzcxeOZP0c4LGusGXYROy0nZHwKgUMv+MTlQttd5RIl9/HxvIFbjgH+92vHhH2wwabF8obMbIsbc5lKEu0Alfot5dLDcYhjQHhbFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=lPuquQ1R; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1765948229; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KtOrn10hpeuFvCEyaKXHLNuGUH5D2J6G18mgU7+ieP8BMzUBEmoQ5hi8AXtzG1yPUTV5lv8VhbtwBSF7Aabkgi6qLu7LZ2Uj/l+wtR9i801ADzCz1HcYhjCbj/LvZM3GzXWnqtfBTfsuj0UFjXsM0XyVksZMOSOObmUd17FJkuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765948229; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ewYUX0Kn2CYWvQaom1qqxo13uFj0uxF2qfvSIoZ2GCM=; 
	b=FJxYpJ5lG0Ek25vuOJkg4mY4a4ZwxBocj9cONL9K13xqf0D6zoOZ+9CxxyS0jYbzzFFb8KN9+c0bRqvxXGG8APC76/fy8+8ZnkxxXlqLeJbzw1VuZ6d4JxyghjE28uZ5OnQI8VqCK1pP95FEtDkhGEl5ve+c9bG4/Nz6xILkGO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765948229;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ewYUX0Kn2CYWvQaom1qqxo13uFj0uxF2qfvSIoZ2GCM=;
	b=lPuquQ1R7OWx22t66FY5ZepAS4qo8fxRJhyZrOcPvG0mdRuc3N5fzkABJYjDhemC
	CBZE7WQz4wXnLeOBEAzlu5DHznoNTdJ7Ov9u75XqZlhShIVqQ+Irxa9Z1h3T6Dnhc6k
	CTXHFgHXtxtDh+NbmxXDCJQqPzOCobGN6MsSMa30=
Received: by mx.zohomail.com with SMTPS id 1765948228898671.6320003380442;
	Tue, 16 Dec 2025 21:10:28 -0800 (PST)
Date: Wed, 17 Dec 2025 10:40:21 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mshv: handle gpa intercepts for arm64
Message-ID: <k7ndsmrth5aqzefcy44kyn5azkilgjrjltciiwdkvcgld2223o@joullumtwjt5>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-3-anirudh@anirudhrb.com>
 <aUGElRga1r2g8cb-@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGElRga1r2g8cb-@skinsburskii.localdomain>
X-ZohoMailClient: External

On Tue, Dec 16, 2025 at 08:11:01AM -0800, Stanislav Kinsburskii wrote:
> On Tue, Dec 16, 2025 at 02:20:29PM +0000, Anirudh Rayabharam wrote:
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > The mshv driver now uses movable pages for guests. For arm64 guests
> > to be functional, handle gpa intercepts for arm64 too (the current
> > code implements handling only for x86). Without this, arm64 guests are
> > broken.
> > 
> > Move some arch-agnostic functions out of #ifdefs so that they can be
> > re-used.
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  drivers/hv/mshv_root_main.c | 38 ++++++++++++++++++++++++++++---------
> >  1 file changed, 29 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 9cf28a3f12fe..882605349664 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
> >  	return NULL;
> >  }
> >  
> > -#ifdef CONFIG_X86_64
> >  static struct mshv_mem_region *
> >  mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
> >  {
> > @@ -625,6 +624,34 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
> >  	return region;
> >  }
> >  
> > +#ifdef CONFIG_X86_64
> > +static u64 mshv_get_gpa_intercept_gfn(struct mshv_vp *vp)
> > +{
> > +	struct hv_x64_memory_intercept_message *msg;
> > +	u64 gfn;
> > +
> > +	msg = (struct hv_x64_memory_intercept_message *)
> > +		vp->vp_intercept_msg_page->u.payload;
> > +
> > +	gfn = HVPFN_DOWN(msg->guest_physical_address);
> > +
> > +	return gfn;
> > +}
> > +#else  /* CONFIG_X86_64 */
> 
> It's better to explicitly branch for ARM64 here for clarity as
> hv_arm64_memory_intercept_message is defined only for ARM64.

Ack.

> 
> > +static u64 mshv_get_gpa_intercept_gfn(struct mshv_vp *vp)
> > +{
> > +	struct hv_arm64_memory_intercept_message *msg;
> > +	u64 gfn;
> > +
> > +	msg = (struct hv_arm64_memory_intercept_message *)
> > +		vp->vp_intercept_msg_page->u.payload;
> > +
> > +	gfn = HVPFN_DOWN(msg->guest_physical_address);
> > +
> > +	return gfn;
> > +}
> > +#endif /* CONFIG_X86_64 */
> > +
> 
> Are these functions really needed?
> It would be clearer (and shorter) to branch directly in
> mshv_handle_gpa_intercept.

True, that might be simpler. I'll send a v2.

Thanks,
Anirudh

