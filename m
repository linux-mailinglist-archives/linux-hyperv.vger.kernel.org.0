Return-Path: <linux-hyperv+bounces-8161-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72896CF7053
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 08:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CA11301596F
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F0303A26;
	Tue,  6 Jan 2026 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Tqok6xab"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186B2F1FDC;
	Tue,  6 Jan 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684118; cv=pass; b=IRkCse2Tnv4H5MA8Tcok3vGebAf39kUjB7kzkdWbrp8ciHTACGUfi4IMeys553y/F1VCWBW+zJkd+2fbJLu7cZxl2pIO32l/VksTd7qmJ594RR8qeNdic9b5ioDfIQeZpasQvFEJD27wACbL33Qbf+iN+Gfd4hLfDK71vTcQSpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684118; c=relaxed/simple;
	bh=4LtIBw3IR4JPye6oImvNm2qB+2iOEuZgsJ901NT7Eew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdhicdg1r5OLxYO8lRG2DgxrvaBC/WsYdsQMaIO+nA6rtoFPMOrTN/7qFADj8gZOn2TWMLN9IuJYs7E6HAfg4FRwVa9DhmfHQuA5A5kXUGBnb14o7Yd60DDdanz//lavK98k+ty1g6ztn79Mcb1/ishFUAWBzK61o2MecrWqX98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Tqok6xab; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1767684109; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LiRv3s0fA7YqYFP/YbnnCkaX0KSyA/tggvlduuTnCE4PvcY6GgzoB6BW0xB06LMYjh5yRAndAoyx3Wa3Pi7j6is9nx7yQpH4o6G91gxcTwlaesfQo1zfDnanjhqSwxSX8t+OiLVfj5XL+KxiyKY63mAGRaZreMyaSr1MYGL5xe0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767684109; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JzL6WUAAirXw59cBSXpk0iEJLXrDch2Dk31bkGcR7u4=; 
	b=lXMc+xTi058X4R2leYNOdasqWCoWA7X2OlwY1VUYyrKJl1gwLwaS61W9aEFQOYqEQOzjVSTaLg+UnY7PplU/nKMOUQmzgbtrLQfN7NUOFXte2oZiWZPuq+v7IkoKFKc5dVh+++Ub4qwKpDBoQa5wbbSvrIhSQSYcwadDhPKfy6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767684109;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=JzL6WUAAirXw59cBSXpk0iEJLXrDch2Dk31bkGcR7u4=;
	b=Tqok6xabJOBOYao8afkF7a0EmmpaKJ98JMcvi9Wp9znbmwHCYxTtbcr1/lz4ZTI5
	qaeEtwu46p2SpQjwE9bEzsC7aVPXXeVlnDXJO2oqZR+yRBPJHi+keKWe8qSSxyE0xJ+
	N6zHbwO7gfvD4pZ5EFMqithpsNujN0x05XeVxR2A=
Received: by mx.zohomail.com with SMTPS id 176768410547447.81929866637199;
	Mon, 5 Jan 2026 23:21:45 -0800 (PST)
Date: Tue, 6 Jan 2026 07:21:41 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mshv: handle gpa intercepts for arm64
Message-ID: <aVy4BUk9X18KiPCO@anirudh-surface.localdomain>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-3-anirudh@anirudhrb.com>
 <aVvvAlsohGEdC6Wv@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVvvAlsohGEdC6Wv@skinsburskii.localdomain>
X-ZohoMailClient: External

On Mon, Jan 05, 2026 at 09:04:02AM -0800, Stanislav Kinsburskii wrote:
> On Mon, Jan 05, 2026 at 12:28:37PM +0000, Anirudh Rayabharam wrote:
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > The mshv driver now uses movable pages for guests. For arm64 guests
> > to be functional, handle gpa intercepts for arm64 too (the current
> > code implements handling only for x86).
> > 
> > Move some arch-agnostic functions out of #ifdefs so that they can be
> > re-used.
> > 
> > Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
> 
> I'm not sure that this patch needs "Fixes" tag as it introduced new
> functionality rather than fixing a bug.

This does fix a bug. The commit mentioned here regressed arm64 guests because
it didn't have GPA intercept handling for arm64.

Thanks,
Anirudh.

> 
> Thanks,
> Stanislav
> 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  drivers/hv/mshv_root_main.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 9cf28a3f12fe..f8c4c2ae2cc9 100644
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
> > @@ -640,12 +639,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> >  {
> >  	struct mshv_partition *p = vp->vp_partition;
> >  	struct mshv_mem_region *region;
> > -	struct hv_x64_memory_intercept_message *msg;
> >  	bool ret;
> >  	u64 gfn;
> > -
> > -	msg = (struct hv_x64_memory_intercept_message *)
> > +#if defined(CONFIG_X86_64)
> > +	struct hv_x64_memory_intercept_message *msg =
> > +		(struct hv_x64_memory_intercept_message *)
> > +		vp->vp_intercept_msg_page->u.payload;
> > +#elif defined(CONFIG_ARM64)
> > +	struct hv_arm64_memory_intercept_message *msg =
> > +		(struct hv_arm64_memory_intercept_message *)
> >  		vp->vp_intercept_msg_page->u.payload;
> > +#endif
> >  
> >  	gfn = HVPFN_DOWN(msg->guest_physical_address);
> >  
> > @@ -663,9 +667,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> >  
> >  	return ret;
> >  }
> > -#else  /* CONFIG_X86_64 */
> > -static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
> > -#endif /* CONFIG_X86_64 */
> >  
> >  static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
> >  {
> > -- 
> > 2.34.1
> > 

