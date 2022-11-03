Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424C7618CE0
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 00:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKCXh3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 19:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKCXh3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 19:37:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A62B11834;
        Thu,  3 Nov 2022 16:37:28 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 885E020B929F;
        Thu,  3 Nov 2022 16:37:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 885E020B929F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667518647;
        bh=/rfJILvAT4i/EgTl3AmpD42cdDe9dV7YPr+q0fK0ydw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJWI+qmY2K/Heu5Kedkp/BV3G8zE1b50oHWeOmdUbcK6P0aykR6yvlvBBpFT4lqPI
         3gvjdeTlk/CNMxPpzdil1FHaAxiLoD8Qm+A3ENc9RRwTz3aGGhtSt/Al2LF1uM4opX
         kfI7KfkX/L8J6y7Mwn7pbSYpoCjuktRM+qeHq38Y=
Date:   Wed, 2 Nov 2022 18:37:05 -0700
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
Subject: Re: [PATCH v3 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Message-ID: <20221103013705.GA1922@skinsburskii.localdomain>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166749834466.218190.3482871684875422987.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB1688F63C2410904F92B1F75FD7389@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688F63C2410904F92B1F75FD7389@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-18.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 03, 2022 at 08:33:40PM +0000, Michael Kelley (LINUX) wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, November 3, 2022 10:59 AM
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
> >  drivers/clocksource/hyperv_timer.c |   38 +++++++++++++++++++++++++++---------
> >  include/clocksource/hyperv_timer.h |    1 +
> >  3 files changed, 32 insertions(+), 9 deletions(-)
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
> > index 9445a1558fe9..dec7ad3b85ba 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -509,9 +509,6 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> >  		return false;
> > 
> > -	if (hv_root_partition)
> > -		return false;
> > -
> >  	/*
> >  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correctly
> >  	 * handles frequency and offset changes due to live migration,
> > @@ -529,16 +526,22 @@ static bool __init hv_init_tsc_clocksource(void)
> >  	}
> > 
> >  	hv_read_reference_counter = read_hv_clock_tsc;
> > -	tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
> > 
> >  	/*
> > -	 * The Hyper-V TLFS specifies to preserve the value of reserved
> > -	 * bits in registers. So read the existing value, preserve the
> > -	 * low order 12 bits, and add in the guest physical address
> > -	 * (which already has at least the low 12 bits set to zero since
> > -	 * it is page aligned). Also set the "enable" bit, which is bit 0.
> > +	 * TSC page mapping works differently in root compared to guest.
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
> > +		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
> >  	tsc_msr.enable = 1;
> >  	tsc_msr.pfn = tsc_pfn;
> >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> 
> There's a subtlety here that was nagging me, and I think I see it now.
> 
> At this point, the code has enabled the Reference TSC, and if we're the root
> partition, the Reference TSC Page is the page supplied by the hypervisor.
> tsc_pfn has been updated to reflect that hypervisor supplied page.
> 
> But tsc_page has not been updated to be in sync with tsc_pfn because we
> can't do the memremap() here.  tsc_page still points to tsc_pg, which is a
> global variable in Linux.  tsc_page and tsc_pfn will be out-of- sync until
> hv_remap_tsc_clocksource() is called later in the boot process.  During
> this interval, calls to get the Hyper-V Reference TSC value will use tsc_pg,
> not on the Reference TSC Page that the hypervisor is using.  Fortunately,
> the function hv_read_tsc_page_tsc(), which actually reads the Reference
> TSC Page, treats a zero value for tsc_sequence as a special case meaning
> that the Reference TSC page isn't valid.  read_hv_clock_tsc() then falls
> back to reading a hypervisor provided synthetic MSR to get the correct
> Reference TSC value.  That fallback is fine -- it's just slower because it
> traps to the hypervisor.  And the fallback will no longer be used once 
> tsc_page is updated by hv_remap_tsc_clocksource().
> 
> So the code works. Presumably this subtlety was already understood, but
> it really should be called out in a comment, as it is far from obvious.  I
> know this code pretty well and I just figured it out. :-(
> 

You are absolutely right in everything above.
Moreover, this imlementation will update the tsc_pfn early and will keep
it the same regardless of the result of the memremap call in
hv_remap_tsc_clocksource().

This in turn can lead to an interesting (although quite unprobable)
situation: kernel fails to remap TSC page (and thus use MSR registers as
fallback), while user space process can successfully map the TSC page
and use it instead.

The code can be changed to be, I'd say, more evident (by assigning
tsc_pfn to the hypervisor PFN only if remapping succeede), but the current
implementation is the most efficient from the performance point of view,
so I'd keep it as is (even so it's not very obvious).

Stas

> Michael
> 
