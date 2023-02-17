Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75669E7EA
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Feb 2023 19:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBUS4k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Feb 2023 13:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBUS4j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Feb 2023 13:56:39 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77582E830;
        Tue, 21 Feb 2023 10:56:37 -0800 (PST)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 13B9220B9C3D;
        Tue, 21 Feb 2023 10:56:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13B9220B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677005797;
        bh=33w9/E8nLQIR9b7uqoHOKw3qqtfFeHeMaFOTtXmWILo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpMSmk164P459FGr4NpJZ1O3rZZ45LFMJmMu8UwvBddDq0uGiKdXHG7n4AQwzKTC1
         9ctsIu0UzNe6IO+stBFRkOJ4JiNfrpwXN7Ze7qhxrXkQfm5IhGCte51yQ77dlpNfp3
         4sH/F8Xz5yPWKyeT9kdOE6b80UQsg3iav7xl8sTI=
Date:   Fri, 17 Feb 2023 14:07:43 -0800
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
Message-ID: <20230217220743.GA1304@skinsburskii.localdomain>
References: <167571656510.2157946.174424531449774007.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB16881C783D58F2F20B7E196DD7A29@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230216194101.GA685@skinsburskii.localdomain>
 <BYAPR21MB1688A3CB5CD51A6A6921D926D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688A3CB5CD51A6A6921D926D7A19@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 17, 2023 at 02:34:21AM +0000, Michael Kelley (LINUX) wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, February 16, 2023 11:41 AM
> > 
> > On Tue, Feb 14, 2023 at 04:19:13PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > >
> > > > And have it preset.
> > > > This change allows to significantly reduce time to bring up guest SMP
> > > > configuration as well as make sure the guest won't get inaccurate
> > > > calibration results due to "noisy neighbour" situation.
> > > >
> > > > Below are the numbers for 16 VCPU guest before the patch (~1300 msec)
> > > >
> > > > [    0.562938] x86: Booting SMP configuration:
> > > > ...
> > > > [    1.859447] smp: Brought up 1 node, 16 CPUs
> > > >
> > > > and after the patch (~130 msec):
> > > >
> > > > [    0.445079] x86: Booting SMP configuration:
> > > > ...
> > > > [    0.575035] smp: Brought up 1 node, 16 CPUs
> > > >
> > > > This change is inspired by commit 0293615f3fb9 ("x86: KVM guest: use
> > > > paravirt function to calculate cpu khz").
> > >
> > > This patch has been nagging at me a bit, and I finally did some further
> > > checking.   Looking at Linux guests on local Hyper-V and in Azure, I see
> > > a dmesg output line like this during boot:
> > >
> > > Calibrating delay loop (skipped), value calculated using timer frequency.. 5187.81
> > BogoMIPS (lpj=2593905)
> > >
> > > We're already skipping the delay loop calculation because lpj_fine
> > > is set in tsc_init(), using the results of get_loops_per_jiffy().  The
> > > latter does exactly the same calculation as hv_preset_lpj() in
> > > this patch.
> > >
> > > Is this patch arising from an environment where tsc_init() is
> > > skipped for some reason?  Just trying to make sure we fully
> > > when this patch is applicable, and when not.
> > >
> > 
> > The problem here is a bit different: "lpj_fine" is considered only for
> > the boot CPU (from init/calibrate.c):
> > 
> >         } else if ((!printed) && lpj_fine) {
> >                 lpj = lpj_fine;
> >                 pr_info("Calibrating delay loop (skipped), "
> >                         "value calculated using timer frequency.. ");
> > 
> > while all the secondary ones use the timer to calibrate.
> > 
> > With this change lpj_preset will be used for all cores (from
> > init/calbrate.c):
> > 
> >         } else if (preset_lpj) {
> >                 lpj = preset_lpj;
> >                 if (!printed)
> >                         pr_info("Calibrating delay loop (skipped) "
> >                                 "preset value.. ");
> > 
> > This lofic with lpj_fine comes from commit 3da757daf86e ("x86: use
> > cpu_khz for loops_per_jiffy calculation"), where the commit messages
> > states the following:
> > 
> >     We do this only for the boot processor because the AP's can have
> >     different base frequencies or the BIOS might boot a AP at a different
> >     frequency.
> > 
> > Hope this helps.
> > 
> 
> Indeed, you are right about lpj_fine being applied only to the boot
> CPU.  So I've looked a little closer because I don't see the 1300
> milliseconds you see for a 16 vCPU guest.
> 
> I've been experimenting with a 32 vCPU guest, and without your
> patch, it takes only 26 milliseconds to get all 32 vCPUs started.  I
> think the trick is in the call to calibrate_delay_is_known().  This
> function copies the lpj value from a CPU in the same NUMA node
> that has already been calibrated, assuming that constant_tsc is
> set, which is the case in my test VM.  So the boot CPU sets lpj
> based on lpj_fine, and all other CPUs effectively copy the value
> from the boot CPU without doing calibration.
> 
> I also experimented with multiple NUMA nodes.  In that case, it
> does take a longer.  Dividing the 32 vCPUs into 4 NUMA nodes,
> it takes about 210 miliseconds to boot all 32 vCPUs.  Presumably the
> extra time is due to timer-based calibration being done once for each
> NUMA node, plus probably some misc NUMA accounting overhead.
> With preset_lpj set, that 210 milliseconds drops to 32 milliseconds,
> which is more like the case with only 1 NUMA nodes, so there's some
> modest benefit with multiple NUMA nodes.
> 
> Could you check if constant_tsc is set in your test environment?  It
> really should be set in a Hyper-V VM.
> 

I guess I should have mentioned, that the results presented in the
commit message are from L2 guest, where there are no NUMA nodes and thus
every core is calibrated individually and thus boot time grows linearly
with the number of the cores assigned.

I'm not sure though, would NUMA emulation be a right choice here or
should this boot time penalty be left as is because we can't guarantee
all the processes are in the same numa node and thus their lpj values
have to be measured.

What do you think, Michael?

Thanks,
Stanislav

> Michael
