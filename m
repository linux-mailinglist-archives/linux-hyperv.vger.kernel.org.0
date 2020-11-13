Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B022B1F50
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 16:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKMP4j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 10:56:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56299 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKMP4i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 10:56:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id c9so8527280wml.5;
        Fri, 13 Nov 2020 07:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6hyMVEFfMlo0q95MNqmUfjlLkrSXFwE1LaCrXDrf1U=;
        b=T7GlhVgQg1AiqMBL5AxD8kXFbzWQbAmSuPZCfSo0A8EkuVLrlJ0ifWX652KFtdMPAc
         5uRrKQhTQ2rQ1Oy7zIQvyD6H6eIwNVhrW2HIu4tFMCE7HzwPEOuFa50oJmgy36GxHa4K
         B1Xgn0mhxHJmO4re6AGPMZl1CSoUFq50/yahdNG908uC2In/piy8H21Cxy7LUpe60BKM
         49UzKynUQXiCFabc7wmgXXm6uHkxIMFmSjP+koGasjsMIN/RcL+7DXMvVbJJPmO3UXZB
         uTGB3/V3hAvapO1ym9TxyxU/2kZXOVOBFhdjH3oxYqf5Tfd907vuXzwJeIa9ZrbLdBeS
         6EyQ==
X-Gm-Message-State: AOAM531aY59mXvySawSFjRp+tZFqo4xe2QmOzHd84n8LTSbAD26hOdRC
        Ek1E8jJGz+yAlPEFrMtJeNA=
X-Google-Smtp-Source: ABdhPJwxmDHIqC3YZFsvlTECTSLwSAi65CsT4dZPk+I9eWtnFzWgSXA34nI1Jw+q43SYi23eyToExQ==
X-Received: by 2002:a1c:2643:: with SMTP id m64mr3286089wmm.28.1605282992030;
        Fri, 13 Nov 2020 07:56:32 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m18sm9567357wru.37.2020.11.13.07.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:56:31 -0800 (PST)
Date:   Fri, 13 Nov 2020 15:56:29 +0000
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
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 10/17] x86/hyperv: implement and use
 hv_smp_prepare_cpus
Message-ID: <20201113155629.bkw45kcuqhr6puck@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-11-wei.liu@kernel.org>
 <87y2j6wmm7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2j6wmm7.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 05:44:48PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > Microsoft Hypervisor requires the root partition to make a few
> > hypercalls to setup application processors before they can be used.
> >
> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> > CPU hotplug and unplug is not yet supported in this setup, so those
> > paths remain untouched.
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index f7633e1e4c82..4795e54550e6 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -31,6 +31,7 @@
> >  #include <asm/reboot.h>
> >  #include <asm/nmi.h>
> >  #include <clocksource/hyperv_timer.h>
> > +#include <asm/numa.h>
> >  
> >  struct ms_hyperv_info ms_hyperv;
> >  EXPORT_SYMBOL_GPL(ms_hyperv);
> > @@ -208,6 +209,30 @@ static void __init hv_smp_prepare_boot_cpu(void)
> >  	hv_init_spinlocks();
> >  #endif
> >  }
> > +
> > +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> > +{
> > +#if defined(CONFIG_X86_64)
> 
> '#ifdef CONFIG_X86_64' is equally good as you can't compile x86_64
> support as a module :-)
> 
> > +	int i;
> > +	int ret;
> > +
> > +	native_smp_prepare_cpus(max_cpus);
> > +
> 
> So hypotetically, if hv_root_partition is true but 'ifdef CONFIG_X86_64'
> is false, we won't even be doing native_smp_prepare_cpus()? This doesn't
> sound right. Either move it outside of #ifdef or put the #ifdef around
> 'smp_ops.smp_prepare_cpus' assignment too.
> 

Fixed. Thanks.

Wei.
