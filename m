Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA8A26B915
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 02:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIPA4x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 20:56:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37872 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIOLRD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 07:17:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so3051504wmm.2;
        Tue, 15 Sep 2020 04:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hOrViQ9/e7YRFhxWzh4oAfdg10S4Mh+sHS2iw3u+aPQ=;
        b=Sn+90mqdrU3QNPs9sCDrTwjeYVTmKMofrzI+RIKaz9eiHrHnwJjsyFasSSQRILRK8B
         ioB8n6jXQ/fGWzwJO74JCQOJhzsINgdI1H6vcrnLdsxnXGbmf3xIOYhZOPWEHcotn9Aw
         l1hBP9H4JVN/nHUJNMkedTM+S/bfHbpdSC3YCaov+BTcBhpo3FP/fxYgHIWa12dtDm9w
         xQ5O353iJwEjbSi1dBkH5M+6cP+j76NaksOoUI8VDR9aKpTgAzJfBtzR3ThsxhFGAUej
         rCMfn7ssa2vPWIbgru3cqexlrUx7yu863vNwEc59tweqh3nZ9WVNoNQPp53ZS4g04pOv
         l3WQ==
X-Gm-Message-State: AOAM5326B+RyJffM6299jZjAIm9oI8mo6GJ8p/QRChDMyip18eTDfTOl
        vLdgqBY7KZN237VrEQ4xzLo=
X-Google-Smtp-Source: ABdhPJy1VFDORM4UB6MEbKPiZ2llP2YFkYLjd3Qs0Ww2nBtbDj7mZyIoMjLtJ6m0v1k2oL4yvXavKw==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr4221626wma.150.1600168619567;
        Tue, 15 Sep 2020 04:16:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 197sm25213904wme.10.2020.09.15.04.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:16:59 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:16:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup
 for root
Message-ID: <20200915111657.boa4cneqjqtmcaaq@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-9-wei.liu@kernel.org>
 <87v9gfjpoi.fsf@vitty.brq.redhat.com>
 <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
 <87pn6njob3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn6njob3.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 15, 2020 at 01:02:08PM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
> >> Wei Liu <wei.liu@kernel.org> writes:
> >> 
> >> > When Linux is running as the root partition, the hypercall page will
> >> > have already been setup by Hyper-V. Copy the content over to the
> >> > allocated page.
> >> 
> >> And we can't setup a new hypercall page by writing something different
> >> to HV_X64_MSR_HYPERCALL, right?
> >> 
> >
> > My understanding is that we can't, but Sunil can maybe correct me.
> >
> >> >
> >> > The suspend, resume and cleanup paths remain untouched because they are
> >> > not supported in this setup yet.
> >> >
> >> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> >> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> >> > Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> >> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> >> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> >> > Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> >> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >> > ---
> >> >  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
> >> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> > index 0eec1ed32023..26233aebc86c 100644
> >> > --- a/arch/x86/hyperv/hv_init.c
> >> > +++ b/arch/x86/hyperv/hv_init.c
> >> > @@ -25,6 +25,7 @@
> >> >  #include <linux/cpuhotplug.h>
> >> >  #include <linux/syscore_ops.h>
> >> >  #include <clocksource/hyperv_timer.h>
> >> > +#include <linux/highmem.h>
> >> >  
> >> >  /* Is Linux running as the root partition? */
> >> >  bool hv_root_partition;
> >> > @@ -448,8 +449,29 @@ void __init hyperv_init(void)
> >> >  
> >> >  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> >  	hypercall_msr.enable = 1;
> >> > -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> >> > -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> > +
> >> > +	if (hv_root_partition) {
> >> > +		struct page *pg;
> >> > +		void *src, *dst;
> >> > +
> >> > +		/*
> >> > +		 * Order is important here. We must enable the hypercall page
> >> > +		 * so it is populated with code, then copy the code to an
> >> > +		 * executable page.
> >> > +		 */
> >> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> > +
> >> > +		pg = vmalloc_to_page(hv_hypercall_pg);
> >> > +		dst = kmap(pg);
> >> > +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> >> > +				MEMREMAP_WB);
> >> 
> >> memremap() can fail...
> >
> > And we don't care here, if it fails, we would rather it panic or oops.
> >
> > I was relying on the fact that copying from / to a NULL pointer will
> > cause the kernel to crash. But of course it wouldn't hurt to explicitly
> > panic here.
> >
> >> 
> >> > +		memcpy(dst, src, PAGE_SIZE);
> >> > +		memunmap(src);
> >> > +		kunmap(pg);
> >> > +	} else {
> >> > +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> >> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> > +	}
> >> 
> >> Why can't we do wrmsrl() for both cases here?
> >> 
> >
> > Because the hypercall page has already been set up when Linux is the
> > root.
> 
> But you already do wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64)
> in 'if (hv_root_partition)' case above, that's why I asked.
> 

You mean extracting wrmsrl to this point?  The ordering matters. See the
comment in the root branch -- we have to enable the page before copying
the content.

What can be done is:

   if (!root) {
       /* some stuff */
   }

   wrmsrl(...)

   if (root) {
       /* some stuff */
   }

This is not looking any better than the existing code.

Wei.

> >
> > I could've tried writing to the MSR again, but because the behaviour
> > here is not documented and subject to change so I didn't bother trying.
> >
> > Wei.
> >
> >> >  
> >> >  	/*
> >> >  	 * Ignore any errors in setting up stimer clockevents
> >> 
> >> -- 
> >> Vitaly
> >> 
> >
> 
> -- 
> Vitaly
> 
