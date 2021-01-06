Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1492EBCF7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbhAFLFU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 06:05:20 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46202 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbhAFLFU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 06:05:20 -0500
Received: by mail-wr1-f49.google.com with SMTP id d13so1993898wrc.13;
        Wed, 06 Jan 2021 03:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ERKXqQidLzskfZDszvErSOtk7AjjY2xYUr+92HjKwIk=;
        b=aC3gbCwm+A8U7a1vITiDwHxhTFVQFjJxC1MWNGVegBAkU40oLzsbO8G5a1G9vnS71X
         +AH51Zbg5HeGh16LemqGywLA2YfpSFKWV3DTwykbR0KtT8buaFpRVWNVfz46H5lT5Jag
         NsND9KFQmCi7NPmi7Grw/mCbOQZiYyZsaybPdXv4gt2P5ZaDsEQaXoonLu3E7FNsiM/1
         PTMry+0shYMurTp5qtQm0nKI1IsIdUbR9E9G6XurPm+QtpVGCpwSq5QwyBSe+wuaQgnY
         aMe9TubDglTlKymLVrleHtKVke2z4406a9et+X7pKjU//ZTBX0GxHlAEsAZ4ej49HjRM
         qkcw==
X-Gm-Message-State: AOAM531466CDt0pmfEtuAbqV/YhAzBmsn939YSuW/JqlecYnTo/3iSgW
        Ot3C6oubLziqM9Ng3hmRSIr2Yt8MmnM=
X-Google-Smtp-Source: ABdhPJzJ8hJ0ilfKd0qWXBunlDpf5M0T0xeks8VGNhrH4/T16tRn2NKwFDdBIjTEj2xoam/pJNnhgA==
X-Received: by 2002:a05:6000:1188:: with SMTP id g8mr3889805wrx.111.1609931077934;
        Wed, 06 Jan 2021 03:04:37 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k6sm2711898wmf.25.2021.01.06.03.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 03:04:37 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:04:35 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: check cpu mask after interrupt has been
 disabled
Message-ID: <20210106110435.cajpxwbew4t5afye@liuwe-devbox-debian-v2>
References: <20210105175043.28325-1-wei.liu@kernel.org>
 <MWHPR21MB15935E00EAEFD70E49A22667D7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15935E00EAEFD70E49A22667D7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 05, 2021 at 06:20:05PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, January 5, 2021 9:51 AM
> > 
> > We've observed crashes due to an empty cpu mask in
> > hyperv_flush_tlb_others.  Obviously the cpu mask in question is changed
> > between the cpumask_empty call at the beginning of the function and when
> > it is actually used later.
> > 
> > One theory is that an interrupt comes in between and a code path ends up
> > changing the mask. Move the check after interrupt has been disabled to
> > see if it fixes the issue.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Cc: stable@kernel.org
> > ---
> >  arch/x86/hyperv/mmu.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> > index 5208ba49c89a..2c87350c1fb0 100644
> > --- a/arch/x86/hyperv/mmu.c
> > +++ b/arch/x86/hyperv/mmu.c
> > @@ -66,11 +66,17 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
> >  	if (!hv_hypercall_pg)
> >  		goto do_native;
> > 
> > -	if (cpumask_empty(cpus))
> > -		return;
> > -
> >  	local_irq_save(flags);
> > 
> > +	/*
> > +	 * Only check the mask _after_ interrupt has been disabled to avoid the
> > +	 * mask changing under our feet.
> > +	 */
> > +	if (cpumask_empty(cpus)) {
> > +		local_irq_restore(flags);
> > +		return;
> > +	}
> > +
> >  	flush_pcpu = (struct hv_tlb_flush **)
> >  		     this_cpu_ptr(hyperv_pcpu_input_arg);
> > 
> > --
> > 2.20.1
> 
> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes.

Wei.
