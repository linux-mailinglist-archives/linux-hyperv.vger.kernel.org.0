Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66397447F0B
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 12:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbhKHLoO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 06:44:14 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:44633 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhKHLoO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 06:44:14 -0500
Received: by mail-wm1-f45.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso11378982wme.3;
        Mon, 08 Nov 2021 03:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tL4nnc8V6PfYQ8KYZsXp2wASy4Mkha6Wkxc8dGxjKY4=;
        b=6qiDu5P9wcoz51fjdx1u9n34lGSn/v5OoJD53rNeRHnEGLshcRFfxeGmDcih/gyIIW
         srztbgnb2n8IUieVp28uGLdsIIf4jz2Q28mXZNPfAd3xE5FBZ4kznBhGQUII6ILxhfhi
         uDo4sSOSygi3I934ZkxSZDv8VJB1CxOJq4JbZImHidEE1/SV6gujNJOXrWWAUUsO6p35
         zM+AfUol5D32a7Kx3PZm1hvvfwE/YEPc91Z0pzII4wc0rwZu4MjE8ewHm8nFVCgnteHg
         mF2XLuVx+l0kjepfI2r/v9/vZXk+XkTQUuke/pajTqtiVfAkTcmvGk5KjsshqP+x4RXB
         Qmag==
X-Gm-Message-State: AOAM533WcEKKAiOfCEi2r1RB2Bf+wwNswMHLJJU7faIJzz0BA6RZ0ktj
        lDg/cLitmddu8cCr1zjRQHg=
X-Google-Smtp-Source: ABdhPJwhJhcBprsIPrbiuBIvlZrmM701ld2p3Ayr7kATTyzLIOPX2QxfWyeNs13iWIDQw6iF9J+ghg==
X-Received: by 2002:a05:600c:1d0e:: with SMTP id l14mr50588741wms.64.1636371688979;
        Mon, 08 Nov 2021 03:41:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j19sm16550307wra.5.2021.11.08.03.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:41:28 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:41:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 1/2] x86/hyperv: Fix NULL deref in
 set_hv_tscchange_cb() if Hyper-V setup fails
Message-ID: <20211108114127.a2axvx4stpmebogi@liuwe-devbox-debian-v2>
References: <20211104182239.1302956-1-seanjc@google.com>
 <20211104182239.1302956-2-seanjc@google.com>
 <87mtmilxg1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtmilxg1.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 05, 2021 at 11:16:14AM +0100, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Check for a valid hv_vp_index array prior to derefencing hv_vp_index when
> > setting Hyper-V's TSC change callback.  If Hyper-V setup failed in
> > hyperv_init(), the kernel will still report that it's running under
> > Hyper-V, but will have silently disabled nearly all functionality.
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
> >  arch/x86/hyperv/hv_init.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 24f4a06ac46a..7d252a58fbe4 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -177,6 +177,9 @@ void set_hv_tscchange_cb(void (*cb)(void))
> >  		return;
> >  	}
> >  
> > +	if (!hv_vp_index)
> > +		return;
> > +
> 
> Arguably, we could've merged this with 'if (!hv_reenlightenment_available())' 
> above to get a message printed:
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 24f4a06ac46a..4a2a091c2f0e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -172,7 +172,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
>         };
>         struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
>  
> -       if (!hv_reenlightenment_available()) {
> +       if (!hv_reenlightenment_available() || !hv_vp_index) {
>                 pr_warn("Hyper-V: reenlightenment support is unavailable\n");
>                 return;
>         }
> 
> just to have an indication that something is off.
> 
> >  	hv_reenlightenment_cb = cb;
> >  
> >  	/* Make sure callback is registered before we write to MSRs */
> 
> With or without the change,
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks Sean and Vitaly. Both patches look good to me. They will be taken
via hyperv-fixes after v5.16-rc1 is cut.

Wei.

> 
> -- 
> Vitaly
> 
