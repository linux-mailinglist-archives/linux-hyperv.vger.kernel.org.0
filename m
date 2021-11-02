Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5107C442DAB
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Nov 2021 13:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhKBMUK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Nov 2021 08:20:10 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39462 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBMUK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Nov 2021 08:20:10 -0400
Received: by mail-wm1-f48.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso1721969wmd.4;
        Tue, 02 Nov 2021 05:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2ExKLs7LL5vmwi/PSEE89GN4aKAGPsL1abfgbW1qDI=;
        b=kRkpZ+LhtIuJU4VyKXFTtIgm7uroUw/Mw36vG8n5VTXSUeNy4VrbzvUUhfc0Uge1SV
         KkSU2C28I/fRXt8GKG2taOK9E1zFKCuY9QvQb4EuqTldVJQLXQn6EtWa+HEFiAITv1ho
         hL5WUk7lCpsW8dDupcQczCuAtks5qFMzDhm0LnHFArg3ys+xAINnUfhv0w21exHquKoX
         tLSffF+nvZgln7M9KBpfYWqsQ5IqYnFQy/VjChJn/GOnPW2Wiu0rZWA88FQGIfbXeEN8
         cLaYAE1Qq7/CLpc+GkrDXZ8VyX9adAy1+q3vTHCo3fLqoxmEOCLZ1BcWaC2z/hPAlCs9
         RWpQ==
X-Gm-Message-State: AOAM532/2I/mYVDuMaknO+fLKivUG9z3hGxG7Hjyn/jDH6rNaT5vlcmO
        aFGmYE/J9v0jg/WYO+bVCok=
X-Google-Smtp-Source: ABdhPJzttPxWDXUxB5q6BFsHOqq9wuhFmwVAokl4CTZ6U46+Kv0ziTEfSgOx3r4jSKWrsLNwf60rOQ==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr6470167wmc.19.1635855454583;
        Tue, 02 Nov 2021 05:17:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z135sm2947017wmc.45.2021.11.02.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:17:33 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:17:31 +0000
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
Subject: Re: [PATCH 1/2] x86/hyperv: Fix NULL deref in set_hv_tscchange_cb()
 if Hyper-V setup fails
Message-ID: <20211102121731.rveppetxyzttd26c@liuwe-devbox-debian-v2>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-2-seanjc@google.com>
 <87tuh0ry3w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuh0ry3w.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 29, 2021 at 11:14:59AM +0200, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Check for re-enlightenment support and for a valid hv_vp_index array
> > prior to derefencing hv_vp_index when setting Hyper-V's TSC change
> > callback.  If Hyper-V setup failed in hyperv_init(), e.g. because of a
> > bad VMM config that doesn't advertise the HYPERCALL MSR, the kernel will
> > still report that it's running under Hyper-V, but will have silently
> > disabled nearly all functionality.
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000010
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   PGD 0 P4D 0
> >   Oops: 0000 [#1] SMP
> >   CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc2+ #75
> >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> >   RIP: 0010:set_hv_tscchange_cb+0x15/0xa0
> >   Code: <8b> 04 82 8b 15 12 17 85 01 48 c1 e0 20 48 0d ee 00 01 00 f6 c6 08
> >   ...
> >   Call Trace:
> >    kvm_arch_init+0x17c/0x280
> >    kvm_init+0x31/0x330
> >    vmx_init+0xba/0x13a
> >    do_one_initcall+0x41/0x1c0
> >    kernel_init_freeable+0x1f2/0x23b
> >    kernel_init+0x16/0x120
> >    ret_from_fork+0x22/0x30
> >
> > Fixes: 93286261de1b ("x86/hyperv: Reenlightenment notifications support")
> > Cc: stable@vger.kernel.org
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 708a2712a516..6cc845c026d4 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -139,7 +139,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
> >  	struct hv_reenlightenment_control re_ctrl = {
> >  		.vector = HYPERV_REENLIGHTENMENT_VECTOR,
> >  		.enabled = 1,
> > -		.target_vp = hv_vp_index[smp_processor_id()]
> > +		.target_vp = -1,
> >  	};
> >  	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
> >  
> > @@ -148,6 +148,11 @@ void set_hv_tscchange_cb(void (*cb)(void))
> >  		return;
> >  	}
> >  
> > +	if (!hv_vp_index)
> > +		return;
> > +
> > +	re_ctrl.target_vp = hv_vp_index[smp_processor_id()];
> > +
> >  	hv_reenlightenment_cb = cb;
> >  
> >  	/* Make sure callback is registered before we write to MSRs */
> 
> The patch looks good, however, it needs to be applied on top of the
> already merged:
> 
> https://lore.kernel.org/linux-hyperv/20211012155005.1613352-1-vkuznets@redhat.com/

Sean, are you going to rebase?

Wei.
