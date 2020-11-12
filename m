Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343662B08EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKLPva (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:51:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgKLPva (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:51:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id p8so6512486wrx.5;
        Thu, 12 Nov 2020 07:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZgjLmQmxgEDr2mbUWpkwRYMxwIwNvNfHIb6zZGhdyzM=;
        b=Bi0j/SUFlEZ8wem/BmtSdWvlHMZafg4omoQNpgPfdO9mk1bjJYkAu40GPcDO0gN+gG
         HI6yIkRaYm9670pbad4GtyZs5TMwD3vCGCgCUgkHpqUrRNpl6NcOTNfd0Ah/mr4c9oHK
         VKSQkeIc+KwcmQIqGNC5O6KNCpWG8H8Jx11WHT1xC5NnFQZjhokTA0aNhaIJw9Ckq5Ar
         6lLxRHKJUNww1zXRcVeJD4D+ot/IcyPfBQmZ6Y0fR2A7Mx4JrS7LeaBPXQ3w7nAbA0sa
         L5H8dnYpvnraSVMGHXS72PQHfk8PuNfzsIKFenbEEQ+vs8TMU7ylMgi/4wHRMtL4DD1I
         f2kg==
X-Gm-Message-State: AOAM531tXkYrlpbp8peusAeFDSAfEd0p9cCKwfvK9qtIspFd96p9NdOJ
        2u6qubBUYVd9+GTyaDMJvwObZYhB4Wg=
X-Google-Smtp-Source: ABdhPJyJENa1caPZP06hbJhvCooPcNeFXa3qQBwOxqU6qrDSyKfCeFFJJRxn4Ajz3u+aViELuJAr/Q==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr254027wrt.66.1605196286237;
        Thu, 12 Nov 2020 07:51:26 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g186sm14984945wma.1.2020.11.12.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:51:25 -0800 (PST)
Date:   Thu, 12 Nov 2020 15:51:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 02/17] x86/hyperv: detect if Linux is the root
 partition
Message-ID: <20201112155124.x35q2rg2k53mc7to@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-3-wei.liu@kernel.org>
 <87lff6y59t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lff6y59t.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 04:16:30PM +0100, Vitaly Kuznetsov wrote:
[...]
> >  /*
> >   * Virtual processor will never share a physical core with another virtual
> >   * processor, except for virtual processors that are reported as sibling SMT
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index ffc289992d1b..ac2b0d110f03 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
> >  		struct hv_guest_mapping_flush_list *flush,
> >  		u64 start_gfn, u64 end_gfn);
> >  
> > +extern bool hv_root_partition;
> 
> Eventually this is not going to be an x86 only thing I believe?

I hope so. :-)

> 
> > +
> >  #ifdef CONFIG_X86_64
> >  void hv_apic_init(void);
> >  void __init hv_init_spinlocks(void);
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 05ef1f4550cb..f7633e1e4c82 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -237,6 +237,22 @@ static void __init ms_hyperv_init_platform(void)
> >  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
> >  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
> >  
> > +	/*
> > +	 * Check CPU management privilege.
> > +	 *
> > +	 * To mirror what Windows does we should extract CPU management
> > +	 * features and use the ReservedIdentityBit to detect if Linux is the
> > +	 * root partition. But that requires negotiating CPU management
> > +	 * interface (a process to be finalized).
> > +	 *
> > +	 * For now, use the privilege flag as the indicator for running as
> > +	 * root.
> > +	 */
> > +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
> 
> We may want to cache cpuid_ebx(HYPERV_CPUID_FEATURES) somewhere but we
> already had a discussion regading naming for these caches and decided to
> wait until TLFS for ARM is out so we don't need to rename again.

Exactly.

Wei.
