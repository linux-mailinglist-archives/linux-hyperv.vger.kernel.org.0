Return-Path: <linux-hyperv+bounces-8171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0ACFC63F
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 08:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A35DB3008546
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C703254B19;
	Wed,  7 Jan 2026 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="q5trSt+n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2727C866
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Jan 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771368; cv=pass; b=YGaZSpBtYbYO8dUujFmA0U2rh6TdrO9btguQrDGTGiz5+3UQcrvGW/DNUOUvAk6kn9vD40KW2oh0zob1n1wvAnTryl5HhvLjIdRPFQGxdMXkuYW33reEnDhhlCv8OJyW9qqYh3M3eyxnn92mJ9hPpuCIb4fekhTivSlanzFZ4xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771368; c=relaxed/simple;
	bh=Jc8f5GSp+9L5AUj8UpSd7RKjfeTe9a8yJZhh9ykSJoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC/iO1h4qTgdsMPq4sVZQnrYx+ezRMvKF1bNmMm8VSruUzVGgOsBYhWCoMeN31OMrl5Pb5HbKGhmu6uPefuEveJvV+w22G4eijdHEAs6Boc7E3OGwjEt3MK/lTWjqi/6q0zqR9Qk8QI/tx9G4lcfKQUnZsS4vx113a6ADWqOQH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=q5trSt+n; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1767771350; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WV02RcEOoBAjvl3JH6t0KINq2QQD43ll/zqxM7w09s9DbVPsnGWYNBQXwr2XRBythCIbPC94CUeSB4P8NYtgk+6cBfUzZGc0vDl1kXYJ/UMsZkPZPVJshe5wDsC1sZvBJo9ZhBYjQxt2O0XEFPMVgiMT7etE21d44pXPDD/p84E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767771350; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0jePfcBJJqIJIg7sXdXbFtV2bmEwA30Fp06aKjpEanc=; 
	b=FZ3mzpYhwzUu0ugBb8i2J0HVHfF7b8L8YONt2GcUEWlGkvvyiNsZkq0ucb46MxIq8P6hVjcFn46lmQXrxPCidKh1s5FxrANNsGD59EsbiSekQazILSktzd2CHfX+BWlQb3Na2fFfuJgfCWpyiLK+YIdvU2FC6K19wW+Ukj7GeTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767771350;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=0jePfcBJJqIJIg7sXdXbFtV2bmEwA30Fp06aKjpEanc=;
	b=q5trSt+nN/ReqG59WnnCFt7BCBJtQfS1ZvcBapTogd1BfBf53PApdTEZdgpQBiHV
	wacCnI/ReKHOVbavSY7pEzYIHh4V9NeJinhixrodJidMz5OBA20t+Uhj949qIRLqaW9
	Wi6KQpqk/XPm1Mq5G2yYjILqyLgJkYMV46xMWOaE=
Received: by mx.zohomail.com with SMTPS id 1767771348521785.4129004339576;
	Tue, 6 Jan 2026 23:35:48 -0800 (PST)
Date: Wed, 7 Jan 2026 07:35:42 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mshv: handle gpa intercepts for arm64
Message-ID: <aV4Mzj9_6lOhSU1l@anirudh-surface.localdomain>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-3-anirudh@anirudhrb.com>
 <aVvvAlsohGEdC6Wv@skinsburskii.localdomain>
 <aVy4BUk9X18KiPCO@anirudh-surface.localdomain>
 <aV05_2Lw6x8Qr_Je@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV05_2Lw6x8Qr_Je@skinsburskii.localdomain>
X-ZohoMailClient: External

On Tue, Jan 06, 2026 at 08:36:15AM -0800, Stanislav Kinsburskii wrote:
> On Tue, Jan 06, 2026 at 07:21:41AM +0000, Anirudh Rayabharam wrote:
> > On Mon, Jan 05, 2026 at 09:04:02AM -0800, Stanislav Kinsburskii wrote:
> > > On Mon, Jan 05, 2026 at 12:28:37PM +0000, Anirudh Rayabharam wrote:
> > > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > > 
> > > > The mshv driver now uses movable pages for guests. For arm64 guests
> > > > to be functional, handle gpa intercepts for arm64 too (the current
> > > > code implements handling only for x86).
> > > > 
> > > > Move some arch-agnostic functions out of #ifdefs so that they can be
> > > > re-used.
> > > > 
> > > > Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
> > > 
> > > I'm not sure that this patch needs "Fixes" tag as it introduced new
> > > functionality rather than fixing a bug.
> > 
> > This does fix a bug. The commit mentioned here regressed arm64 guests because
> > it didn't have GPA intercept handling for arm64.
> > 
> 
> Were ARM guests functional before this commit? If yes, then I agree that

Yes.

> this patch fixes a bug. If no, then this is just adding new
> functionality.
> I had an impression ARM is not yet supported in MSHV, so please clarify.

No, ARM is very much supported in MSHV. Going forward all new
code/features should be written for arm64 too. Missing arm64
implementation in way that leaves guests broken is a bug.

Thanks,
Anirudh.

> 
> Thanks,
> Stanislav
> 
> > Thanks,
> > Anirudh.
> > 
> > > 
> > > Thanks,
> > > Stanislav
> > > 
> > > > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > > ---
> > > >  drivers/hv/mshv_root_main.c | 15 ++++++++-------
> > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > > > index 9cf28a3f12fe..f8c4c2ae2cc9 100644
> > > > --- a/drivers/hv/mshv_root_main.c
> > > > +++ b/drivers/hv/mshv_root_main.c
> > > > @@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
> > > >  	return NULL;
> > > >  }
> > > >  
> > > > -#ifdef CONFIG_X86_64
> > > >  static struct mshv_mem_region *
> > > >  mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
> > > >  {
> > > > @@ -640,12 +639,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> > > >  {
> > > >  	struct mshv_partition *p = vp->vp_partition;
> > > >  	struct mshv_mem_region *region;
> > > > -	struct hv_x64_memory_intercept_message *msg;
> > > >  	bool ret;
> > > >  	u64 gfn;
> > > > -
> > > > -	msg = (struct hv_x64_memory_intercept_message *)
> > > > +#if defined(CONFIG_X86_64)
> > > > +	struct hv_x64_memory_intercept_message *msg =
> > > > +		(struct hv_x64_memory_intercept_message *)
> > > > +		vp->vp_intercept_msg_page->u.payload;
> > > > +#elif defined(CONFIG_ARM64)
> > > > +	struct hv_arm64_memory_intercept_message *msg =
> > > > +		(struct hv_arm64_memory_intercept_message *)
> > > >  		vp->vp_intercept_msg_page->u.payload;
> > > > +#endif
> > > >  
> > > >  	gfn = HVPFN_DOWN(msg->guest_physical_address);
> > > >  
> > > > @@ -663,9 +667,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> > > >  
> > > >  	return ret;
> > > >  }
> > > > -#else  /* CONFIG_X86_64 */
> > > > -static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
> > > > -#endif /* CONFIG_X86_64 */
> > > >  
> > > >  static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
> > > >  {
> > > > -- 
> > > > 2.34.1
> > > > 

