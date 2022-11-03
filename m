Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849C618586
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiKCRBN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 13:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiKCRAs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 13:00:48 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D54E813F5C;
        Thu,  3 Nov 2022 10:00:47 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C5D6205DA3F;
        Thu,  3 Nov 2022 10:00:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C5D6205DA3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667494847;
        bh=S1U3y/zGHpGk3GYTwTPkes5UtSR8HCrBbQs0tnym6N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmITrRKe7MTaMTdB2Scx5F2NAhXaboCsQ3XlE4UXPj4IzweWhMQ5SEBr9bFkScyCx
         4Gxe5dFRtoY9j8tB3TXaYXfgUX6NZetkOB7J7cE6aR4oZYsQmkYh8QL2Kle3OeiS9a
         FBXVC8b0ixjs4vWF/YoJK8yzOPK/R5rsVHAN+DEI=
Date:   Thu, 3 Nov 2022 17:00:46 +0000
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Message-ID: <Y2PzvhwbLzlq3WHm@skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net>
References: <166742670556.205987.18227942188746093700.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166742685995.205987.1519185062889413335.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB1688672E692E9B618F3B5587D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688672E692E9B618F3B5587D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

O Wed, Nov 02, 2022 at 11:36:45PM +0000, Michael Kelley (LINUX) wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednesday, November 2, 2022 3:08 PM
> > 
> > Microsoft Hypervisor root partition has to map the TSC page specified
> > by the hypervisor, instead of providing the page to the hypervisor like
> > it's done in the guest partitions.
> > 
> > However, it's too early to map the page when the clock is initialized, so, the
> > actual mapping is happening later.
> > 
> > Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > CC: Haiyang Zhang <haiyangz@microsoft.com>
> > CC: Wei Liu <wei.liu@kernel.org>
> > CC: Dexuan Cui <decui@microsoft.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Borislav Petkov <bp@alien8.de>
> > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: x86@kernel.org
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> > CC: linux-hyperv@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  arch/x86/hyperv/hv_init.c          |    2 ++
> >  drivers/clocksource/hyperv_timer.c |   37 +++++++++++++++++++++++++++---------
> >  include/clocksource/hyperv_timer.h |    1 +
> >  3 files changed, 31 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index f49bc3ec76e6..89954490af93 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -464,6 +464,8 @@ void __init hyperv_init(void)
> >  		BUG_ON(!src);
> >  		memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
> >  		memunmap(src);
> > +
> > +		hv_remap_tsc_clocksource();
> >  	} else {
> >  		hypercall_msr.guest_physical_address =
> > vmalloc_to_pfn(hv_hypercall_pg);
> >  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> > index 635c14c1e3bf..ec76303b2a76 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -508,9 +508,6 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> >  		return false;
> > 
> > -	if (hv_root_partition)
> > -		return false;
> > -
> >  	/*
> >  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
> >  	 * handles frequency and offset changes due to live migration,
> > @@ -528,16 +525,22 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	}
> > 
> >  	hv_read_reference_counter = read_hv_clock_tsc;
> > -	tsc_pfn = __phys_to_pfn(virt_to_phys(tsc_page));
> > 
> >  	/*
> > -	 * The Hyper-V TLFS specifies to preserve the value of reserved
> > -	 * bits in registers. So read the existing value, preserve the
> > -	 * low order 12 bits, and add in the guest physical address
> > -	 * (which already has at least the low 12 bits set to zero since
> > -	 * it is page aligned). Also set the "enable" bit, which is bit 0.
> > +	 * TSC page mapping works differently in root and guest partitions.
> > +	 * - In guest partition the guest PFN has to be passed to the
> > +	 *   hypervisor.
> > +	 * - In root partition it's other way around: it has to map the PFN
> > +	 *   provided by the hypervisor.
> > +	 *   But it can't be mapped right here as it's too early and MMU isn't
> > +	 *   ready yet. So, we only set the enable bit here and will remap the
> > +	 *   page later in hv_remap_tsc_clocksource().
> >  	 */
> >  	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > +	if (hv_root_partition)
> > +		tsc_pfn = tsc_msr.pfn;
> > +	else
> > +		tsc_pfn = __phys_to_pfn(virt_to_phys(tsc_page));
> 
> Same problem here with setting tsc_pfn to a guest PFN, which may be
> Different from what Hyper-V is expecting as a PFN two lines below.  I know
> the above line was just carried over from Anirudh's previous patch set,
> but I was thinking you would fix this issue. :-)
> 

Fair call. I guess Anirudh has addressed it himself, so I'm going to
rebase on his fix.

> >  	tsc_msr.enable = 1;
> >  	tsc_msr.pfn = tsc_pfn;
> >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> > @@ -572,3 +575,19 @@ void __init hv_init_clocksource(void)
> >  	hv_sched_clock_offset = hv_read_reference_counter();
> >  	hv_setup_sched_clock(read_hv_sched_clock_msr);
> >  }
> > +
> > +void __init hv_remap_tsc_clocksource(void)
> > +{
> > +	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> > +		return;
> > +
> > +	if (!hv_root_partition) {
> > +		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
> > +		     __func__);
> > +		return;
> > +	}
> > +
> > +	tsc_page = memremap(__pfn_to_phys(tsc_pfn), sizeof(tsc_pg), MEMREMAP_WB);
> 
> Note that use of __pfn_to_phys() is at risk of being wrong depending on whether
> you decide to keep a guest PFN or a Hyper-V PFN in tsc_pfn.
> 

It's Hyperv-V PFN that is stored in the variable (to match the MSR value for the root partition).
I guess this approach will workd regardless of the guest page size.

Stas
