Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA44452C0
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Nov 2021 13:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKDMQE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Nov 2021 08:16:04 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:44744 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDMQC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Nov 2021 08:16:02 -0400
Received: by mail-wm1-f45.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso4092978wme.3;
        Thu, 04 Nov 2021 05:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iw6B3dHc7fqb73Z9j/6O73BwxisTEKPWaJnYtXissaM=;
        b=e5h8rOz+Lv4ig7InJDtKVKEDIu9FRo1yuE5/HSKtZkwvEsNAEt440SFasiZ46n59Em
         VMRjXZTOikVTFRsa5hQnGpLjndKgkYIc9jHtRvperEgsZ/0/Dtyl66i3tVjLg4jm2hBU
         lIYOmfils+/2WKGP1aSbQKqgb8FugpciwGOtiQTu0AEVQ2AignwP7EGMVV6Oxm6zlsKn
         H0Os+B1zmbr8iXdP6p1+CwdbJbi1150o7rNLPLAxPd/usQMnrR9DNvwTLVvwYLFecoeB
         aThdL/dxd5/Bu9xNlKe8ztaIuekk0cf/wtj3CVdQs9rUQyOgcSGBvWWQdnN8HP46dxT6
         3Fiw==
X-Gm-Message-State: AOAM530lgJDkWZrDZCrSRTvVDS/g08pZH/hFc6e3Ymy5E1W7gYEY49Dm
        cPErvbWp3oOEBsqQ6oe+kz8=
X-Google-Smtp-Source: ABdhPJzgWJgz7gVXmqEgv+2orYt+J3Kg1hsMrqSRkcTE6umbybYlFN7yGGD7dXHm3xQVz5CbcB16Sw==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr23432402wmn.93.1636028003905;
        Thu, 04 Nov 2021 05:13:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z135sm10408173wmc.45.2021.11.04.05.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 05:13:23 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:13:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] x86/hyperv: Move required MSRs check to initial
 platform probing
Message-ID: <20211104121322.b4jco5u2wukv54fm@liuwe-devbox-debian-v2>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-3-seanjc@google.com>
 <87r1c4rxu6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1c4rxu6.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 29, 2021 at 11:20:49AM +0200, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Explicitly check for MSR_HYPERCALL and MSR_VP_INDEX support when probing
> > for running as a Hyper-V guest instead of waiting until hyperv_init() to
> > detect the bogus configuration.  Add messages to give the admin a heads
> > up that they are likely running on a broken virtual machine setup.
> >
> > At best, silently disabling Hyper-V is confusing and difficult to debug,
> > e.g. the kernel _says_ it's using all these fancy Hyper-V features, but
> > always falls back to the native versions.  At worst, the half baked setup
> > will crash/hang the kernel.
> >
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/hyperv/hv_init.c      |  9 +--------
> >  arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
> >  2 files changed, 16 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 6cc845c026d4..abfb09610e22 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -347,20 +347,13 @@ static void __init hv_get_partition_id(void)
> >   */
> >  void __init hyperv_init(void)
> >  {
> > -	u64 guest_id, required_msrs;
> > +	u64 guest_id;
> >  	union hv_x64_msr_hypercall_contents hypercall_msr;
> >  	int cpuhp;
> >  
> >  	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
> >  		return;
> >  
> > -	/* Absolutely required MSRs */
> > -	required_msrs = HV_MSR_HYPERCALL_AVAILABLE |
> > -		HV_MSR_VP_INDEX_AVAILABLE;
> > -
> > -	if ((ms_hyperv.features & required_msrs) != required_msrs)
> > -		return;
> > -
> >  	if (hv_common_init())
> >  		return;
> >  
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index e095c28d27ae..ef6316fef99f 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -163,12 +163,22 @@ static uint32_t  __init ms_hyperv_platform(void)
> >  	cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS,
> >  	      &eax, &hyp_signature[0], &hyp_signature[1], &hyp_signature[2]);
> >  
> > -	if (eax >= HYPERV_CPUID_MIN &&
> > -	    eax <= HYPERV_CPUID_MAX &&
> > -	    !memcmp("Microsoft Hv", hyp_signature, 12))
> > -		return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
> > +	if (eax < HYPERV_CPUID_MIN || eax > HYPERV_CPUID_MAX ||
> > +	    memcmp("Microsoft Hv", hyp_signature, 12))
> > +		return 0;
> >  
> > -	return 0;
> > +	/* HYPERCALL and VP_INDEX MSRs are mandatory for all features. */
> > +	eax = cpuid_eax(HYPERV_CPUID_FEATURES);
> > +	if (!(eax & HV_MSR_HYPERCALL_AVAILABLE)) {
> > +		pr_warn("x86/hyperv: HYPERCALL MSR not available.\n");
> > +		return 0;
> > +	}
> > +	if (!(eax & HV_MSR_VP_INDEX_AVAILABLE)) {
> > +		pr_warn("x86/hyperv: VP_INDEX MSR not available.\n");
> > +		return 0;
> > +	}
> > +
> > +	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
> >  }
> >  
> >  static unsigned char hv_get_nmi_reason(void)
> 
> In theory, we can get away without VP_INDEX MSR as e.g. PV spinlocks
> don't need it but it will require us to add the check to all other
> features which actually need it and disable them so it's probably not
> worth the effort (and unless we're running on KVM/QEMU which actually
> *can* create such configuration, it's likely impossible to meet such
> setup in real life).
> 

Indeed. There is no need to make things more complicated than necessary.

> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks for reviewing.

Wei.


> 
> -- 
> Vitaly
> 
