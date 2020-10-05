Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEFF283892
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Oct 2020 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJEO65 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Oct 2020 10:58:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40182 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEO64 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Oct 2020 10:58:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id j2so9959587wrx.7;
        Mon, 05 Oct 2020 07:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=arf4WDavo4mH+NimIUSRraS6XCsUtA2SCJsUc8RhY20=;
        b=lSk5q0B9Ef+s7sW2sGAkfZ6mHMVcJkTJts3bZlIhNwpE5vdyn0dxqpgLYe0FN6zvRf
         H/p0St/fKzqyDkiLURnXXrIzPmqy4z0I6PHJWt0DMrOuW5SAlJLUA0SmjRximKe9a3Mq
         OON5R2z5dfB+KnJg7PhE5LTF5ZxSvLHFn8icT3JBmRUW7uktOGvRWdpC8KfZtoffIJie
         +ICStHwCQxxJIAcehyTdHTNmjQjSUvMOPUiE3vEhi12W6qxSiUvN9N0J0IE/RIZWCScQ
         E9KGx9xnPzws1iEDnGtHEhF0y4foHK5Qu2iUKr0FOTvK7WX1nPEzkNs3sXDsx81jqBzp
         fAcA==
X-Gm-Message-State: AOAM532Uorhy52nbt3zM7n9wwS3FGN5QiILfH7wgRCJFELRfCcrJPSMo
        oaNr2eWo+lvahrOZwlw+l4KVuAxGc9E=
X-Google-Smtp-Source: ABdhPJwsmYfIdZo5A7MWOv7wthty+N7BmpngScIGBIplUKSh8CDx3xU7kBEDNGlby8jxVEiqswcdew==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr17984801wrp.224.1601909933711;
        Mon, 05 Oct 2020 07:58:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t16sm2961wmi.18.2020.10.05.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:58:53 -0700 (PDT)
Date:   Mon, 5 Oct 2020 14:58:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, Wei Liu <wei.liu@kernel.org>,
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
Message-ID: <20201005145851.hdyaeqo3celt2wtr@liuwe-devbox-debian-v2>
References: <20201001013814.2435935-1-sashal@kernel.org>
 <87o8lm9te3.fsf@vitty.brq.redhat.com>
 <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
 <20201001130400.GE2415204@sasha-vm>
 <MW2PR2101MB105242653A8D5C7DD9DF1062D70E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB105242653A8D5C7DD9DF1062D70E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Oct 03, 2020 at 05:40:15PM +0000, Michael Kelley wrote:
> From: Sasha Levin <sashal@kernel.org>  Sent: Thursday, October 1, 2020 6:04 AM
> > 
> > On Thu, Oct 01, 2020 at 11:53:59AM +0000, Wei Liu wrote:
> > >On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
> > >> Sasha Levin <sashal@kernel.org> writes:
> > >>
> > >> > cpumask can change underneath us, which is generally safe except when we
> > >> > call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
> > >> > num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
> > >> > garbage. As reported by KASAN:
> > >> >
> > >> > [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others
> > (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> > >> > [   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
> > >> > [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
> > >> > [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine,
> > BIOS 090008  12/07/2018
> > >> > [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
> > >> > [   84.196669] Call Trace:
> > >> > [   84.196669] dump_stack (lib/dump_stack.c:120)
> > >> > [   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
> > >> > [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
> > >> > [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71
> > mm/kasan/common.c:635)
> > >> > [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128
> > arch/x86/hyperv/mmu.c:112)
> > >> > [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68
> > arch/x86/mm/tlb.c:798)
> > >> > [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-
> > generic.c:88)
> > >> >
> > >> > Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper
> > HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
> > >> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > >> > Cc: stable@kernel.org
> > >> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >> > ---
> > >> >  arch/x86/hyperv/mmu.c | 4 +++-
> > >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >> >
> > >> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> > >> > index 5208ba49c89a9..b1d6afc5fc4a3 100644
> > >> > --- a/arch/x86/hyperv/mmu.c
> > >> > +++ b/arch/x86/hyperv/mmu.c
> > >> > @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct cpumask
> > *cpus,
> > >> >  		 * must. We will also check all VP numbers when walking the
> > >> >  		 * supplied CPU set to remain correct in all cases.
> > >> >  		 */
> > >> > -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
> > >> > +		int last = cpumask_last(cpus);
> > >> > +
> > >> > +		if (last < num_possible_cpus() && hv_cpu_number_to_vp_number(last) >=
> > 64)
> > >> >  			goto do_ex_hypercall;
> > >>
> > >> In case 'cpus' can end up being empty (I'm genuinely suprised it can)
> > 
> > I was just as surprised as you and spent the good part of a day
> > debugging this. However, a:
> > 
> > 	WARN_ON(cpumask_empty(cpus));
> > 
> > triggers at that line of code even though we check for cpumask_empty()
> > at the entry of the function.
> 
> What does the call stack look like when this triggers?  I'm curious about
> the path where the 'cpus' could be changing while the flush call is in
> progress.
> 
> I wonder if CPUs could ever be added to the mask?  Removing CPUs can
> be handled with some care because an unnecessary flush doesn't hurt
> anything.   But adding CPUs has serious correctness problems.
> 

The cpumask_empty check is done before disabling irq. Is it possible
the mask is modified by an interrupt?

If there is a reliable way to trigger this bug, we may be able to test
the following patch.

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 5208ba49c89a..23fa08d24c1a 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -66,11 +66,13 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
        if (!hv_hypercall_pg)
                goto do_native;

-       if (cpumask_empty(cpus))
-               return;
-
        local_irq_save(flags);

+       if (cpumask_empty(cpus)) {
+               local_irq_restore(flags);
+               return;
+       }
+
        flush_pcpu = (struct hv_tlb_flush **)
                     this_cpu_ptr(hyperv_pcpu_input_arg);

