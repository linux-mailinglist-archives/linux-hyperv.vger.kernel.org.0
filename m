Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3EE27FFAD
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Oct 2020 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbgJANED (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Oct 2020 09:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731952AbgJANEC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Oct 2020 09:04:02 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED5C207FB;
        Thu,  1 Oct 2020 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601557441;
        bh=jv+eF8Q2btStYdRPVW0DsLC9P3eBMViIk17Uwk3FEc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqowF1t5A5t0LeZbkZhqNFujAECPtAY7YX9872OUb5Ve8uYAkY/1dbMWMjKBi+ehX
         e+QewqcKFVprGK/Dju6vBqHZsJF6oi+4teTwoFk+q5Kty5UPfYX0YjmNHl4EKeG/8j
         zj/cvltNUCIN39WPyCtVBZnAEQbNo/pKi2l3zUEY=
Date:   Thu, 1 Oct 2020 09:04:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Message-ID: <20201001130400.GE2415204@sasha-vm>
References: <20201001013814.2435935-1-sashal@kernel.org>
 <87o8lm9te3.fsf@vitty.brq.redhat.com>
 <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 01, 2020 at 11:53:59AM +0000, Wei Liu wrote:
>On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
>> Sasha Levin <sashal@kernel.org> writes:
>>
>> > cpumask can change underneath us, which is generally safe except when we
>> > call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
>> > num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
>> > garbage. As reported by KASAN:
>> >
>> > [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
>> > [   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
>> > [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
>> > [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
>> > [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
>> > [   84.196669] Call Trace:
>> > [   84.196669] dump_stack (lib/dump_stack.c:120)
>> > [   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
>> > [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
>> > [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71 mm/kasan/common.c:635)
>> > [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
>> > [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68 arch/x86/mm/tlb.c:798)
>> > [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-generic.c:88)
>> >
>> > Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
>> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > Cc: stable@kernel.org
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > ---
>> >  arch/x86/hyperv/mmu.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> > index 5208ba49c89a9..b1d6afc5fc4a3 100644
>> > --- a/arch/x86/hyperv/mmu.c
>> > +++ b/arch/x86/hyperv/mmu.c
>> > @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
>> >  		 * must. We will also check all VP numbers when walking the
>> >  		 * supplied CPU set to remain correct in all cases.
>> >  		 */
>> > -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
>> > +		int last = cpumask_last(cpus);
>> > +
>> > +		if (last < num_possible_cpus() && hv_cpu_number_to_vp_number(last) >= 64)
>> >  			goto do_ex_hypercall;
>>
>> In case 'cpus' can end up being empty (I'm genuinely suprised it can)

I was just as surprised as you and spent the good part of a day
debugging this. However, a:

	WARN_ON(cpumask_empty(cpus));

triggers at that line of code even though we check for cpumask_empty()
at the entry of the function.

>> the check is mandatory indeed. I would, however, just return directly in
>> this case:

Makes sense.

>> if (last < num_possible_cpus())
>> 	return;
>
>I think you want
>
>   last >= num_possible_cpus()
>
>here?
>
>A more important question is, if the mask can change willy-nilly, what
>is stopping it from changing between these checks? I.e. is there still a
>windows that hv_cpu_number_to_vp_number(last) can return garbage?

It's not that hv_cpu_number_to_vp_number() returns garbage, the issue is
that we feed it garbage.

hv_cpu_number_to_vp_number() expects that the input would be in the
range of 0 <= X < num_possible_cpus(), and here if 'cpus' was empty we
would pass in X==num_possible_cpus() making it read out of bound.

Maybe it's worthwhile to add a WARN_ON() into
hv_cpu_number_to_vp_number() to assert as well.

-- 
Thanks,
Sasha
