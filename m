Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99B5423CF0
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbhJFLlJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 07:41:09 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41498 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhJFLlJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 07:41:09 -0400
Received: by mail-wr1-f47.google.com with SMTP id t2so7887407wrb.8;
        Wed, 06 Oct 2021 04:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gfOhYK3sa4RchPYXkwWmSCEiGsGoKelUYKBquQ6G06A=;
        b=NH0yXv2Rl0Z2FhdxEDyCUiCPZMbPrK/naoEIs5cP8xNXedAdUdHJ40wnMik62dVMle
         6D0Zdgh5cAaRFWbksfKDqOugr/7tAjDWL94B+EKyMUGsNCoRRKHgMGu/wVCt8m2+xr34
         BmtAlJd8an2pAhhyclk6jhk0LAs3E5ERv4p5eQ+ctiDu6W3up7r7DDM+glRLZYTzo1MQ
         fenc57t8z1Su1FAVQw4ZQNLOI11IbQ4+UV29Dv3ujdE9BNXrGPDO7zOUhahkYBMcjVKA
         8HX7MzjhgxMujyJxEFOVdJZRZz1+PMo+iWt9HAy59kTSwSynV+eWSm9q4hgEz54jasLX
         xzww==
X-Gm-Message-State: AOAM531pb/rtpgymZ4I53uiYAwNUKAdwfUGJ+I2xXzH+qgh23qqf69sQ
        F9iqQxduExVw8THtVRGibIM=
X-Google-Smtp-Source: ABdhPJxyTT8QreVfiYs68z5J08WXAdEFMUL8t2ElBIrrRmHfND9oaFGN/B9YobgKZIsoXstcTuoiKQ==
X-Received: by 2002:adf:8b84:: with SMTP id o4mr23975028wra.108.1633520356102;
        Wed, 06 Oct 2021 04:39:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w5sm20427595wrq.86.2021.10.06.04.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 04:39:15 -0700 (PDT)
Date:   Wed, 6 Oct 2021 11:39:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
Message-ID: <20211006113913.c2ubc7bokgokoc6q@liuwe-devbox-debian-v2>
References: <20210910185714.299411-1-wei.liu@kernel.org>
 <20210910185714.299411-3-wei.liu@kernel.org>
 <87ee9batb5.ffs@tglx>
 <87k0ir63au.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ir63au.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas and Vitaly

Sorry for the late reply. I was buried in my other work.

On Tue, Oct 05, 2021 at 02:53:29PM +0200, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > Wei!
> >
> 
> Not Wei here but I don't see the question answered on the mailing list
> so let me give my thoughts.
> 
> > On Fri, Sep 10 2021 at 18:57, Wei Liu wrote:
> >> -static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> >> +static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
> >> +		bool exclude_self)
> >>  {
> >>  	struct hv_send_ipi_ex **arg;
> >>  	struct hv_send_ipi_ex *ipi_arg;
> >> @@ -123,7 +124,10 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> >>  
> >>  	if (!cpumask_equal(mask, cpu_present_mask)) {
> >
> > Not part of that patch, but is checking cpu_present_mask correct here?
> > If so then this really lacks a comment for the casual reader.
> 
> It seems it *was* correct prior to 'exclude_self': the idea is that for
> everything but 'cpu_present_mask' we use HV_GENERIC_SET_SPARSE_4K
> format, for 'cpu_present_mask' we just use 'all' (HV_GENERIC_SET_ALL)
> to avoid specifying individual CPUs. 

Yes, that's the intent.

It was correct before because cpumask would have been filtered to
exclude "self" when it came to this function.

> 
> >
> >>  		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> >> -		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> >> +		if (exclude_self)
> >> +			nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
> >> +		else
> >> +			nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> >>  	}
> >
> > But, what happens in the case that mask == cpu_present_mask and
> > exclude_self == true?
> >
> > AFAICT it ends up sending the IPI to all CPUs including self:
> >
> > 	if (!nr_bank)
> > 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
> >
> > Not entirely correct, right?
> 
> It's not, I think we need something like (completely untested) 
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 32a1ad356c18..80b7660208e4 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -122,17 +122,17 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>         ipi_arg->reserved = 0;
>         ipi_arg->vp_set.valid_bank_mask = 0;
>  
> -       if (!cpumask_equal(mask, cpu_present_mask)) {
> +       if (!cpumask_equal(mask, cpu_present_mask) || exclude_self) {
>                 ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>                 if (exclude_self)
>                         nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
>                 else
>                         nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> -       }
> -       if (nr_bank < 0)
> -               goto ipi_mask_ex_done;
> -       if (!nr_bank)
> +               if (nr_bank =< 0)
> +                       goto ipi_mask_ex_done;
> +       } else {
>                 ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
> +       }
>  
>         status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
>                               ipi_arg, NULL);
> 
> here. Wei, I can test and send this out if you're not on it already.
> 

Please turn this into a patch and send it out. Thank you so much for
looking into it.

Wei.

> -- 
> Vitaly
> 
