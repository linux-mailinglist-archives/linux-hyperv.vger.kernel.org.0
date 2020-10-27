Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B352A29ADBE
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Oct 2020 14:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbgJ0NsC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Oct 2020 09:48:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36591 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbgJ0NsB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Oct 2020 09:48:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id x7so1997919wrl.3;
        Tue, 27 Oct 2020 06:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diH4Qyyrxt/LqWd3OIkJtTdBzvG7EXgB+/Xt8ERCqVs=;
        b=A5bh76/eXMAIJH585LuBugLfDzFEpeeu4S7BOLNaT1GWsOduL9rqHAohezfKY7mBff
         4ioYU6/LbJ/uk+CetTA8JqpRYK1hmKy3WIbEHdhfxnar6Jxwg23PTNUGPS6Br2CQWHz5
         Wp2yxBXRTvKidlH325/00rZF+1n5I7kNl9Xs9h1hRoUe1wvmO9d9F4f0QM295BVLncP/
         V3w9jg0HZdOBYpjfGYMbGuzZkONRCmX2sABhoLQLh1hwvH91IWJDvr6jXE3rxpPip8g5
         KkxwY61UioTKC0S4eMFNoV0NLHG/kZB5giCmTAinvnZyyUI58QxDNZ9R9mnQ0IbcuEdj
         rFGQ==
X-Gm-Message-State: AOAM533TWr4d3NM91wnwzGKoT366DypyyrGyj12HNPWSO1GwhiS8vIX1
        5paC1b8b7vU0e+o5wcEYUN8=
X-Google-Smtp-Source: ABdhPJx8OOpIBT1DcnUIgGb3JPeTpY0jIxx8c6XIJB4bw8P4p7ZZtSl32f4yKOGacunhNiQ0yxDoQA==
X-Received: by 2002:adf:de0c:: with SMTP id b12mr2158089wrm.266.1603806479620;
        Tue, 27 Oct 2020 06:47:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h128sm1987316wme.38.2020.10.27.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:47:59 -0700 (PDT)
Date:   Tue, 27 Oct 2020 13:47:57 +0000
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
Subject: Re: [PATCH RFC v1 10/18] x86/hyperv: implement and use
 hv_smp_prepare_cpus
Message-ID: <20201027134757.k2hjvcmq3ezqo4mm@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-2-wei.liu@kernel.org>
 <87mu1rjnqv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu1rjnqv.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 15, 2020 at 01:14:16PM +0200, Vitaly Kuznetsov wrote:
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
> > index 1bf57d310f78..7522cae02759 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -203,6 +203,31 @@ static void __init hv_smp_prepare_boot_cpu(void)
> >  	hv_init_spinlocks();
> >  #endif
> >  }
> > +
> > +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> > +{
> > +#if defined(CONFIG_X86_64)
> 
> I think it makes little sense to try to make Linux work as Hyper-V root
> partition when !CONFIG_X86_64. If we still care about Hyper-V enablement
> for !CONFIG_X86_64 we can probably introduce something like
> CONFIG_HYPERV_ROOT and enable it automatically, e.g.
> 
> config HYPERV_ROOT
>         def_bool HYPERV && X86_64
> 
> and use it instead.
> 

We have a patch for such a config option in the /dev/mshv patch set. But
that's not yet included here so I will keep this as-is.

> > +	int i;
> > +	int vp_index = 1;
> > +	int ret;
> > +
> > +	native_smp_prepare_cpus(max_cpus);
> > +
> > +	for_each_present_cpu(i) {
> > +		if (i == 0)
> > +			continue;
> > +		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
> > +		BUG_ON(ret);
> > +	}
> > +
> > +	for_each_present_cpu(i) {
> > +		if (i == 0)
> > +			continue;
> > +		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, vp_index++, i);
> 
> So vp_index variable is needed here to make sure there are no gaps? (or
> we could've just used 'i')?

Not sure. I didn't write the original code in this function. The last
argument (i) is the logical processor index.

I don't see a reason why vp_index and lp_index can't be the same. I will
try dropping vp_index. If that works then great; if not, I will keep the
code as-is.

Sunil, if you have more insight, please chime in.

Wei.

> 
> > +		BUG_ON(ret);
> > +	}
> > +#endif
> > +}
> >  #endif
> >  
> >  static void __init ms_hyperv_init_platform(void)
> > @@ -359,6 +384,8 @@ static void __init ms_hyperv_init_platform(void)
> >  
> >  # ifdef CONFIG_SMP
> >  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> > +	if (hv_root_partition)
> > +		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
> >  # endif
> >  
> >  	/*
> 
> -- 
> Vitaly
> 
