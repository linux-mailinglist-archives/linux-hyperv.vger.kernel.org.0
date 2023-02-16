Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494DA69A2CE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 01:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBQABs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Feb 2023 19:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBQABq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Feb 2023 19:01:46 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D29A726AC;
        Thu, 16 Feb 2023 16:01:45 -0800 (PST)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id BDECC2045DEB;
        Thu, 16 Feb 2023 16:01:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDECC2045DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676592105;
        bh=rJO4s7yb+I/e0SJCeS53LLifVNvTtYML3fVc85K+K0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDzHu6w+Ue98HZ3RuoEtWj85rvV0mrQDHc9uroOt4rmCrnvwHRtpn8wsqXsEHGMME
         EfqjZ1+0Z38KwhAc06NcaEPpTlLiLoQRgWz8LdFH6batQw9a1bTEdarseqzI4vPOSa
         TpZ/3d+g0L8IiWKr2Plc7soYXGkL9I/8cxLvXJVc=
Date:   Thu, 16 Feb 2023 11:41:01 -0800
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
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: Pass on the lpj value from host to guest
Message-ID: <20230216194101.GA685@skinsburskii.localdomain>
References: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB16881C783D58F2F20B7E196DD7A29@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16881C783D58F2F20B7E196DD7A29@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-18.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 14, 2023 at 04:19:13PM +0000, Michael Kelley (LINUX) wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > 
> > And have it preset.
> > This change allows to significantly reduce time to bring up guest SMP
> > configuration as well as make sure the guest won't get inaccurate
> > calibration results due to "noisy neighbour" situation.
> > 
> > Below are the numbers for 16 VCPU guest before the patch (~1300 msec)
> > 
> > [    0.562938] x86: Booting SMP configuration:
> > ...
> > [    1.859447] smp: Brought up 1 node, 16 CPUs
> > 
> > and after the patch (~130 msec):
> > 
> > [    0.445079] x86: Booting SMP configuration:
> > ...
> > [    0.575035] smp: Brought up 1 node, 16 CPUs
> > 
> > This change is inspired by commit 0293615f3fb9 ("x86: KVM guest: use
> > paravirt function to calculate cpu khz").
> 
> This patch has been nagging at me a bit, and I finally did some further
> checking.   Looking at Linux guests on local Hyper-V and in Azure, I see
> a dmesg output line like this during boot:
> 
> Calibrating delay loop (skipped), value calculated using timer frequency.. 5187.81 BogoMIPS (lpj=2593905)
> 
> We're already skipping the delay loop calculation because lpj_fine
> is set in tsc_init(), using the results of get_loops_per_jiffy().  The
> latter does exactly the same calculation as hv_preset_lpj() in
> this patch.
> 
> Is this patch arising from an environment where tsc_init() is
> skipped for some reason?  Just trying to make sure we fully
> when this patch is applicable, and when not.
> 

The problem here is a bit different: "lpj_fine" is considered only for
the boot CPU (from init/calibrate.c):

        } else if ((!printed) && lpj_fine) {
                lpj = lpj_fine;
                pr_info("Calibrating delay loop (skipped), "
                        "value calculated using timer frequency.. ");

while all the secondary ones use the timer to calibrate.

With this change lpj_preset will be used for all cores (from
init/calbrate.c):

        } else if (preset_lpj) {
                lpj = preset_lpj;
                if (!printed)
                        pr_info("Calibrating delay loop (skipped) "
                                "preset value.. ");

This lofic with lpj_fine comes from commit 3da757daf86e ("x86: use
cpu_khz for loops_per_jiffy calculation"), where the commit messages
states the following:

    We do this only for the boot processor because the AP's can have
    different base frequencies or the BIOS might boot a AP at a different
    frequency.

Hope this helps.

Thanks,
Stanislav

> Michael
> 
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
> > CC: linux-hyperv@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  arch/x86/kernel/cpu/mshyperv.c |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index dedec2f23ad1..0282b2e96cc2 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -320,6 +320,21 @@ static void __init hv_smp_prepare_cpus(unsigned int
> > max_cpus)
> >  }
> >  #endif
> > 
> > +static void __init __maybe_unused hv_preset_lpj(void)
> > +{
> > +	unsigned long khz;
> > +	u64 lpj;
> > +
> > +	if (!x86_platform.calibrate_tsc)
> > +		return;
> > +
> > +	khz = x86_platform.calibrate_tsc();
> > +
> > +	lpj = ((u64)khz * 1000);
> > +	do_div(lpj, HZ);
> > +	preset_lpj = lpj;
> > +}
> > +
> >  static void __init ms_hyperv_init_platform(void)
> >  {
> >  	int hv_max_functions_eax;
> > @@ -521,6 +536,12 @@ static void __init ms_hyperv_init_platform(void)
> > 
> >  	/* Register Hyper-V specific clocksource */
> >  	hv_init_clocksource();
> > +
> > +	/*
> > +	 * Preset lpj to make calibrate_delay a no-op, which is turn helps to
> > +	 * speed up secondary cores initialization.
> > +	 */
> > +	hv_preset_lpj();
> >  #endif
> >  	/*
> >  	 * TSC should be marked as unstable only after Hyper-V
> > 
> 
