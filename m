Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA01A37F1
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2020 18:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDIQ0n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Apr 2020 12:26:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37659 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgDIQ0n (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Apr 2020 12:26:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so12636440wrm.4;
        Thu, 09 Apr 2020 09:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GD/oklGtk/+8gnrCm1T4EQmedNZZcJ/kYUIWVwvwJbI=;
        b=ciWTq/eOSuM/zXCsthUw/IsF0d5STlA4PlibTBJhIA698y/UNO54mY02ryNE0axFtF
         ime6dutlkip5YxYqGET2T47leWkfb1TexkPHBfNsL8ElijIShGGAkscfIfxXw2iCPv/n
         pHLx+0LHnMtK5ecGPiGHEBiVv59x45UXcMTK9LtSL71qzA30NsRBk0KkNJw6cqx9W/i2
         07K5E7hsP+YiMQpfxZakRRlqXUXT3Ka18JRbGmxDuTHNg5lQT5TbksxW5NOLq0ov+JRq
         BUq+xmjfIJs6Z48d8uaKrKOdixGLAajhnTVEmeyhqHr/q2vyP3ygIeYVnU86+hwJ4tBg
         OF6w==
X-Gm-Message-State: AGi0PuazLjn2+2XoHlwSwsgww6QUIkDYdqK2F1cS3gfa8pbdXuPrl+qG
        TCc6BwViWfg4qyD8aNbGsetZUM36xnY=
X-Google-Smtp-Source: APiQypJIlaJ2ukaIbeO0I51ccQuZ+EjYxNmqV52bwIsPNgnA3QgyA2/AJ6WcFtR2RAeOn8QReuThTA==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr14291029wrn.289.1586449602377;
        Thu, 09 Apr 2020 09:26:42 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id f3sm4578067wmj.24.2020.04.09.09.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:26:41 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:26:39 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Olaf Hering <olaf@aepfle.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v1] x86: hyperv: report value of misc_features
Message-ID: <20200409162639.x7vlj2z7h7wt5d4q@debian>
References: <20200407172739.31371-1-olaf@aepfle.de>
 <874ktu2csk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ktu2csk.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 08, 2020 at 05:54:35PM +0200, Vitaly Kuznetsov wrote:
> Olaf Hering <olaf@aepfle.de> writes:
> 
> > A few kernel features depend on ms_hyperv.misc_features, but unlike its
> > siblings ->features and ->hints, the value was never reported during boot.
> >
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index caa032ce3fe3..53706fb56433 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -227,8 +227,8 @@ static void __init ms_hyperv_init_platform(void)
> >  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
> >  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
> >  
> > -	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
> > -		ms_hyperv.features, ms_hyperv.hints);
> > +	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> > +		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> 
> Several spare thoughts:
> 
> I'm always struggling to remember what is what here as these names don't
> correspond to TLFS, could we maybe come up with better naming, e.g.
> 
> "Features.EAX", "Features.EDX", "Recommendations.EAX",...
> 
> On the other hand, there is more, e.g. nested virtualization
> features. How is it useful for all users to see this in dmesg every
> time? If we need it for development purposes, we can always run 'cpuid'
> so maybe let's drop this altogether or print only with pr_debug? 
> 
> (Honestly: no strong opinion here, deferring to Microsoft folks).

I think making them closer to TLFS is a good idea.

Leaving them always printed is not a big concern to me. Sometimes you
don't get to run `cpuid` if the kernel crashes early.

Olaf's patch is fine as-is. I'm happy to take this patch (if not already
taken by x86 maintainers) given it makes at least one developer's life
easier.

Wei.

> 
> >  
> >  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
> >  	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
> >
> 
> -- 
> Vitaly
> 
