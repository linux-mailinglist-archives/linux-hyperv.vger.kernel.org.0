Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E846C26A423
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIOL2S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 07:28:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgIOL1o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 07:27:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id g4so2920945wrs.5;
        Tue, 15 Sep 2020 04:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKB7I8LlDcqqnISMz++E6byp1TIESzhHVmhG38fWmwk=;
        b=pyPOdpkdYRE9XkXBWct7PAzubMIds+gUFGG17CYHmYtbu38CAGW8V0jjzFVYnjHaPU
         l3VjJfjqsGeqpRB7t3EWSh2WCxMmGKo5qj0alR+/Lg7fUEBgdfzYBXjw8YWL+LxEQTy9
         zlV3G9By2i2Q6/CCMFM5rld3mgpE5MQ1CSQY7XbgA6srfoJkMOJkKOhUVPigvULeBSkH
         f97IIn0DfFA9KGk52HrAu3aaAGmC/lLMA7ZX18cgtjpRZOlT2W1KFpf/bIbAUPg0XxTK
         EgmmaIVvfaca0C5QeVAQMdQu4YWWaPn8JtnQpzMECHbUvG+BeuKyeKuDnAxJ3p9bQf5g
         Qrxw==
X-Gm-Message-State: AOAM531HU4s3mbLxsRBAO4DnLG5MXdKNe0l3nSaCKTcnrGQtl/Do65Kc
        aqoN8dvip6nHAfQtrs9V2SE=
X-Google-Smtp-Source: ABdhPJzJsnQ+QKXuYz5OlNB6UVbOooawUKhK9iCWZ/oJCFzVvTqZEGq1ExXTCMGC78gH1aB0Yi8nnQ==
X-Received: by 2002:a5d:540a:: with SMTP id g10mr19858508wrv.138.1600169261048;
        Tue, 15 Sep 2020 04:27:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 11sm24244418wmi.14.2020.09.15.04.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:27:40 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:27:39 +0000
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
Message-ID: <20200915112739.q34r3gy6zcbq5hsl@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-9-wei.liu@kernel.org>
 <87v9gfjpoi.fsf@vitty.brq.redhat.com>
 <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
 <87pn6njob3.fsf@vitty.brq.redhat.com>
 <20200915111657.boa4cneqjqtmcaaq@liuwe-devbox-debian-v2>
 <87h7rzjnax.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7rzjnax.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 15, 2020 at 01:23:50PM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > On Tue, Sep 15, 2020 at 01:02:08PM +0200, Vitaly Kuznetsov wrote:
> >> Wei Liu <wei.liu@kernel.org> writes:
> >> 
> >> > On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
> >> >> Wei Liu <wei.liu@kernel.org> writes:
> >> >> 
> >> >> > When Linux is running as the root partition, the hypercall page will
> >> >> > have already been setup by Hyper-V. Copy the content over to the
> >> >> > allocated page.
> >> >> 
> >> >> And we can't setup a new hypercall page by writing something different
> >> >> to HV_X64_MSR_HYPERCALL, right?
> >> >> 
> >> >
> >> > My understanding is that we can't, but Sunil can maybe correct me.
> >> >
> >> >> >
> >> >> > The suspend, resume and cleanup paths remain untouched because they are
> >> >> > not supported in this setup yet.
> >> >> >
> >> >> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> >> >> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> >> >> > Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> >> >> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> >> >> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> >> >> > Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> >> >> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >> >> > ---
> >> >> >  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
> >> >> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >> >> >
> >> >> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> >> > index 0eec1ed32023..26233aebc86c 100644
> >> >> > --- a/arch/x86/hyperv/hv_init.c
> >> >> > +++ b/arch/x86/hyperv/hv_init.c
> >> >> > @@ -25,6 +25,7 @@
> >> >> >  #include <linux/cpuhotplug.h>
> >> >> >  #include <linux/syscore_ops.h>
> >> >> >  #include <clocksource/hyperv_timer.h>
> >> >> > +#include <linux/highmem.h>
> >> >> >  
> >> >> >  /* Is Linux running as the root partition? */
> >> >> >  bool hv_root_partition;
> >> >> > @@ -448,8 +449,29 @@ void __init hyperv_init(void)
> >> >> >  
> >> >> >  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> >> >  	hypercall_msr.enable = 1;
> >> >> > -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> >> >> > -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> >> > +
> >> >> > +	if (hv_root_partition) {
> >> >> > +		struct page *pg;
> >> >> > +		void *src, *dst;
> >> >> > +
> >> >> > +		/*
> >> >> > +		 * Order is important here. We must enable the hypercall page
> >> >> > +		 * so it is populated with code, then copy the code to an
> >> >> > +		 * executable page.
> >> >> > +		 */
> >> >> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> >> > +
> >> >> > +		pg = vmalloc_to_page(hv_hypercall_pg);
> >> >> > +		dst = kmap(pg);
> >> >> > +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> >> >> > +				MEMREMAP_WB);
> >> >> 
> >> >> memremap() can fail...
> >> >
> >> > And we don't care here, if it fails, we would rather it panic or oops.
> >> >
> >> > I was relying on the fact that copying from / to a NULL pointer will
> >> > cause the kernel to crash. But of course it wouldn't hurt to explicitly
> >> > panic here.
> >> >
> >> >> 
> >> >> > +		memcpy(dst, src, PAGE_SIZE);
> >> >> > +		memunmap(src);
> >> >> > +		kunmap(pg);
> >> >> > +	} else {
> >> >> > +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> >> >> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >> >> > +	}
> >> >> 
> >> >> Why can't we do wrmsrl() for both cases here?
> >> >> 
> >> >
> >> > Because the hypercall page has already been set up when Linux is the
> >> > root.
> >> 
> >> But you already do wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64)
> >> in 'if (hv_root_partition)' case above, that's why I asked.
> >> 
> >
> > You mean extracting wrmsrl to this point?  The ordering matters. See the
> > comment in the root branch -- we have to enable the page before copying
> > the content.
> >
> > What can be done is:
> >
> >    if (!root) {
> >        /* some stuff */
> >    }
> >
> >    wrmsrl(...)
> >
> >    if (root) {
> >        /* some stuff */
> >    }
> >
> > This is not looking any better than the existing code.
> >
> 
> Oh, I missed the comment indeed. So Hypervisor already picked a page for
> us, however, it didn't enable it and it's not populated?

Seems to be the case.

> How can we be
> sure that we didn't use it for something else already?

It is a page deposited to the root partition and it is not going to be
used elsewhere, nor it is visible from the root. This is my
understanding. I will let Sunil correct me if I'm wrong.

> Maybe we can
> still give a different known-to-be-empty page?
> 

That's the thing I said I didn't bother trying earlier. Something to
check when I have some spare cycles.

Wei.

> -- 
> Vitaly
> 
