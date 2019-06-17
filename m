Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E420F478DD
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 05:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfFQD7Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 16 Jun 2019 23:59:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41104 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfFQD7Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 16 Jun 2019 23:59:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so4885882pff.8;
        Sun, 16 Jun 2019 20:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zkZocmIy2nM4Zonb/tOptWrSoVmluNaywc50q2sTUtA=;
        b=s+C7YoZ91NgGTEDf8Me/8kwPO5Mk7qRXJKdcC4TMTanNGBdfALj1QqTZdnf3CZzrXg
         Yc07bLF2jE4IHvI0GT8X4ufzjbEhhQLJk6UEJ0C5kTvrvjhvFVfpSkauoc2o1t3Ct5gf
         KkHrDb5aaUXWRNTyaypR2IOWTrHiaiaD11ovX4xplsMQ5oTLOiV0rnf2DJAgV3JPHZso
         BXMdzqeYnUFOGuYJxqG6DJdHlr5+OFyyhvZc3HZuH1POsNsJuMDT1ds6stDtwZPM143u
         4q9iTSdz9OHHRwd/XNNg1oGNfbZfyZnrNl+tCWGbh1TXpAZc5JHraGOCh1fSg/bPtfNA
         ct6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zkZocmIy2nM4Zonb/tOptWrSoVmluNaywc50q2sTUtA=;
        b=krPk1tysgpj1FBpiHP94dWzLL7gCBtbMORR+aGoUjYAmK3mzR0qJp0Ye+svsHZlqjw
         0N+Jmlg3Jz4TerEdxgEX1dICBYHvqrYeiHWIDkfJ0Wu+59X/DaqYLDnr6KckOWsQ8W1E
         Aom9YwpSAABd5tg8q8nXKAkxDzPb4UvGuzPUA/VKuKpmHOeErr1+D+BBFgLAE1M96228
         OlpFAmEuzY0DtkOlJRcAq1DTBbtb7hfDfv09huusS2mvg9i/98dT2fyh7KmLfScdJSZb
         0eCQZEygdS3qwxnZdUA70lDuNuWWsVTTlxL/aNFaWmx3ud9WCT0r8IE/0EEod+1R/EYA
         swFw==
X-Gm-Message-State: APjAAAVTuJS03C2mmCXT50vBsSVTwaorLtEiC0jkv6k5tzfGBJ6ZzkAD
        LX1BFwCiR5wSprwUfDKxjo4=
X-Google-Smtp-Source: APXvYqyGsTJ6fst3wGAXG8LzupVa/RwDiDCgvy+HZkE1qQ/mj89ubW1rem8srR97zCjotSdjASqeiA==
X-Received: by 2002:a63:e018:: with SMTP id e24mr46758408pgh.361.1560743955359;
        Sun, 16 Jun 2019 20:59:15 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id l1sm10023297pgj.67.2019.06.16.20.59.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 20:59:15 -0700 (PDT)
Date:   Mon, 17 Jun 2019 03:59:14 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 2/5] x86: hv: hv_init.c: Add functions to
 allocate/deallocate page for Hyper-V
Message-ID: <20190617035913.GA91412@maya190131.isni1t2eisqetojrdim5hhf1se.xx.internal.cloudapp.net>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com>
 <5cf4ad6f3fae8dec33e364b367b99cbb5b0f2ba4.1559807514.git.m.maya.nakamura@gmail.com>
 <87muindr9c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muindr9c.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 12, 2019 at 12:36:47PM +0200, Vitaly Kuznetsov wrote:
> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
> 
> > Introduce two new functions, hv_alloc_hyperv_page() and
> > hv_free_hyperv_page(), to allocate/deallocate memory with the size and
> > alignment that Hyper-V expects as a page. Although currently they are
> > not used, they are ready to be used to allocate/deallocate memory on x86
> > when their ARM64 counterparts are implemented, keeping symmetry between
> > architectures with potentially different guest page sizes.
> >
> > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index e4ba467a9fc6..84baf0e9a2d4 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -98,6 +98,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> >  u32 hv_max_vp_index;
> >  EXPORT_SYMBOL_GPL(hv_max_vp_index);
> >  
> > +void *hv_alloc_hyperv_page(void)
> > +{
> > +	BUILD_BUG_ON(!(PAGE_SIZE == HV_HYP_PAGE_SIZE));
> 
> (nit)
> 
> PAGE_SIZE != HV_HYP_PAGE_SIZE ?
> 
> > +
> > +	return (void *)__get_free_page(GFP_KERNEL);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> > +
> > +void hv_free_hyperv_page(unsigned long addr)
> > +{
> > +	free_page(addr);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> > +
> >  static int hv_cpu_init(unsigned int cpu)
> >  {
> >  	u64 msr_vp_index;
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> -- 
> Vitaly

Agreed. I will resubmit the patch set with this correction.
