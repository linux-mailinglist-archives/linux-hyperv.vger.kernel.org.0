Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD626A344
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIOKhZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 06:37:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54885 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIOKhO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 06:37:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id s13so2841294wmh.4;
        Tue, 15 Sep 2020 03:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0FEvhe81Rt7AJ2NQ20nZUIPRKHUuLpPLW8xH6sCpcw=;
        b=hfRgbSGlk9jJV5G7YD2Dh6pfhkj5DAM5FZabKqOxqI1gYlYKvO3db9c1pNh98SvaQf
         nwQY9pq1rQ8uFDJFML4upMSBP0FDGrYutOx2NYB2xUsthgXNsb+HONA+H94iRbuQBVIq
         HBKp2YnZf9yiFO1zhYcJhIabpISYX4DKdjfSlxyvDpBp2wTh4j+Cz3mNDY8a99yII1xX
         TDJuWfZV2sOA6B+PK980+AGD/oKHsJZ6xl/Bg/Fs1P7xIYnU4S20gwr6dIbM1+9P0Sbg
         HVyCov59JTijbxfzRyPWIZMqHceIApWanUfyxgRJK2gGfXyTg+hJFVCRAkDx5rHq2dBd
         DHGA==
X-Gm-Message-State: AOAM532fEeNGYxj1Tkj1zk9lbRYISwSb9N71xKRsUQzqktx6TJIb05Dy
        XZvZH+8J/lyjllpSHdCzjRg=
X-Google-Smtp-Source: ABdhPJwg7n4w+itzegzVWPPOZkBcOPB0WndjT4F4m973xvzCeNDMUFYC3+o1/zUpLvG8qH84vO5ILA==
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr3863166wmr.164.1600166231873;
        Tue, 15 Sep 2020 03:37:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g12sm25361404wro.89.2020.09.15.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:37:11 -0700 (PDT)
Date:   Tue, 15 Sep 2020 10:37:10 +0000
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
Message-ID: <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-9-wei.liu@kernel.org>
 <87v9gfjpoi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9gfjpoi.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > When Linux is running as the root partition, the hypercall page will
> > have already been setup by Hyper-V. Copy the content over to the
> > allocated page.
> 
> And we can't setup a new hypercall page by writing something different
> to HV_X64_MSR_HYPERCALL, right?
> 

My understanding is that we can't, but Sunil can maybe correct me.

> >
> > The suspend, resume and cleanup paths remain untouched because they are
> > not supported in this setup yet.
> >
> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 0eec1ed32023..26233aebc86c 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/syscore_ops.h>
> >  #include <clocksource/hyperv_timer.h>
> > +#include <linux/highmem.h>
> >  
> >  /* Is Linux running as the root partition? */
> >  bool hv_root_partition;
> > @@ -448,8 +449,29 @@ void __init hyperv_init(void)
> >  
> >  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >  	hypercall_msr.enable = 1;
> > -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> > -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +
> > +	if (hv_root_partition) {
> > +		struct page *pg;
> > +		void *src, *dst;
> > +
> > +		/*
> > +		 * Order is important here. We must enable the hypercall page
> > +		 * so it is populated with code, then copy the code to an
> > +		 * executable page.
> > +		 */
> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +
> > +		pg = vmalloc_to_page(hv_hypercall_pg);
> > +		dst = kmap(pg);
> > +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> > +				MEMREMAP_WB);
> 
> memremap() can fail...

And we don't care here, if it fails, we would rather it panic or oops.

I was relying on the fact that copying from / to a NULL pointer will
cause the kernel to crash. But of course it wouldn't hurt to explicitly
panic here.

> 
> > +		memcpy(dst, src, PAGE_SIZE);
> > +		memunmap(src);
> > +		kunmap(pg);
> > +	} else {
> > +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +	}
> 
> Why can't we do wrmsrl() for both cases here?
> 

Because the hypercall page has already been set up when Linux is the
root.

I could've tried writing to the MSR again, but because the behaviour
here is not documented and subject to change so I didn't bother trying.

Wei.

> >  
> >  	/*
> >  	 * Ignore any errors in setting up stimer clockevents
> 
> -- 
> Vitaly
> 
