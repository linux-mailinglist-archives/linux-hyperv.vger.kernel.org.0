Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B12EB119
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAERLj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 12:11:39 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:42833 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAERLj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 12:11:39 -0500
Received: by mail-wr1-f42.google.com with SMTP id m5so36845819wrx.9;
        Tue, 05 Jan 2021 09:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJK/r8p/by9FBkOupFAoyDbfZBUjbXuGcfwcyoGTbxo=;
        b=bjG4+MEnVE71pJnAB0bk+/SQkyHuEWsF7kzjrfiUoqTxeFKj+/KkPs+fijCSkTLC6e
         gGjugJzLBtFZ96PqL0ND+hTBJyWUztgE2YbOl3NRCFBbxAcMlpJMwcdhU3oiLZ9zefKM
         HbNYyCWC4Lj40IPqEw5yTVU7O6IwsXyiz/pMESE9GKu75dGIVfFJ0jI7OA2A6Gf5wu6A
         LX51hyBhY83dusBugFVQWj4C3C97RbtZ3W7CIm2bz22hA+2q0nKt6LZ37jJ583SevBoo
         8ChPaSV1wKLm5hZWDMAnYzYpv0UMjj6DNxY3X0EzyvaIFT75U1FvAWihe+bGf1LuLI9v
         oZDw==
X-Gm-Message-State: AOAM533UV7iBKgPXMqMYgwaLPz4qA4wtHrUcyVm7mMYQj+6r7oGDQzsm
        PNaM8mOWcaBjJl2R7qe6fuw6b5TTTZc=
X-Google-Smtp-Source: ABdhPJwwQhKHTvXqjkUoaoc28eF6ttd0kJkNKYR0quC5RSyRLD0T9CFJfhAC22jsSrmEW+R9C8mVDg==
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr550774wrg.322.1609866656716;
        Tue, 05 Jan 2021 09:10:56 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g191sm155385wmg.39.2021.01.05.09.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:10:56 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:10:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Message-ID: <20210105171054.7s2ggrlbsod7pigo@liuwe-devbox-debian-v2>
References: <20201001013814.2435935-1-sashal@kernel.org>
 <87o8lm9te3.fsf@vitty.brq.redhat.com>
 <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
 <20201001130400.GE2415204@sasha-vm>
 <MW2PR2101MB105242653A8D5C7DD9DF1062D70E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20201005145851.hdyaeqo3celt2wtr@liuwe-devbox-debian-v2>
 <MWHPR21MB1593B4387204C522536F80CCD7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593B4387204C522536F80CCD7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 05, 2021 at 04:59:10PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Monday, October 5, 2020 7:59 AM
> > 
> > On Sat, Oct 03, 2020 at 05:40:15PM +0000, Michael Kelley wrote:
> > > From: Sasha Levin <sashal@kernel.org>  Sent: Thursday, October 1, 2020 6:04 AM
> > > >
> > > > On Thu, Oct 01, 2020 at 11:53:59AM +0000, Wei Liu wrote:
> > > > >On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
> > > > >> Sasha Levin <sashal@kernel.org> writes:
> > > > >>
> > > > >> > cpumask can change underneath us, which is generally safe except when we
> > > > >> > call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
> > > > >> > num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
> > > > >> > garbage. As reported by KASAN:
> > > > >> >
> > > > >> > [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others
> > > > (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> > > > >> > [   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
> > > > >> > [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
> > > > >> > [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual
> > Machine,
> > > > BIOS 090008  12/07/2018
> > > > >> > [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
> > > > >> > [   84.196669] Call Trace:
> > > > >> > [   84.196669] dump_stack (lib/dump_stack.c:120)
> > > > >> > [   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
> > > > >> > [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
> > > > >> > [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71
> > > > mm/kasan/common.c:635)
> > > > >> > [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128
> > > > arch/x86/hyperv/mmu.c:112)
> > > > >> > [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68
> > > > arch/x86/mm/tlb.c:798)
> > > > >> > [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-
> > > > generic.c:88)
> > > > >> >
> > > > >> > Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper
> > > > HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
> > > > >> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > > >> > Cc: stable@kernel.org
> > > > >> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > >> > ---
> > > > >> >  arch/x86/hyperv/mmu.c | 4 +++-
> > > > >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >> >
> > > > >> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> > > > >> > index 5208ba49c89a9..b1d6afc5fc4a3 100644
> > > > >> > --- a/arch/x86/hyperv/mmu.c
> > > > >> > +++ b/arch/x86/hyperv/mmu.c
> > > > >> > @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct cpumask
> > > > *cpus,
> > > > >> >  		 * must. We will also check all VP numbers when walking the
> > > > >> >  		 * supplied CPU set to remain correct in all cases.
> > > > >> >  		 */
> > > > >> > -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
> > > > >> > +		int last = cpumask_last(cpus);
> > > > >> > +
> > > > >> > +		if (last < num_possible_cpus() &&
> > hv_cpu_number_to_vp_number(last) >=
> > > > 64)
> > > > >> >  			goto do_ex_hypercall;
> > > > >>
> > > > >> In case 'cpus' can end up being empty (I'm genuinely suprised it can)
> > > >
> > > > I was just as surprised as you and spent the good part of a day
> > > > debugging this. However, a:
> > > >
> > > > 	WARN_ON(cpumask_empty(cpus));
> > > >
> > > > triggers at that line of code even though we check for cpumask_empty()
> > > > at the entry of the function.
> > >
> > > What does the call stack look like when this triggers?  I'm curious about
> > > the path where the 'cpus' could be changing while the flush call is in
> > > progress.
> > >
> > > I wonder if CPUs could ever be added to the mask?  Removing CPUs can
> > > be handled with some care because an unnecessary flush doesn't hurt
> > > anything.   But adding CPUs has serious correctness problems.
> > >
> > 
> > The cpumask_empty check is done before disabling irq. Is it possible
> > the mask is modified by an interrupt?
> > 
> > If there is a reliable way to trigger this bug, we may be able to test
> > the following patch.
> > 
> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> > index 5208ba49c89a..23fa08d24c1a 100644
> > --- a/arch/x86/hyperv/mmu.c
> > +++ b/arch/x86/hyperv/mmu.c
> > @@ -66,11 +66,13 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
> >         if (!hv_hypercall_pg)
> >                 goto do_native;
> > 
> > -       if (cpumask_empty(cpus))
> > -               return;
> > -
> >         local_irq_save(flags);
> > 
> > +       if (cpumask_empty(cpus)) {
> > +               local_irq_restore(flags);
> > +               return;
> > +       }
> > +
> >         flush_pcpu = (struct hv_tlb_flush **)
> >                      this_cpu_ptr(hyperv_pcpu_input_arg);
> 
> This thread died out 3 months ago without any patches being taken.
> I recently hit the problem again at random, though not in a
> reproducible way.
> 
> I'd like to take Wei Liu's latest proposal to check for an empty
> cpumask *after* interrupts are disabled.   I think this will almost
> certainly solve the problem, and in a cleaner way than Sasha's
> proposal.  I'd also suggest adding a comment in the code to note
> the importance of the ordering.
> 

Sure. Let me prepare a proper patch.

Wei.
