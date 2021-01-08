Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B592EF4BF
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jan 2021 16:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhAHPXE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jan 2021 10:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbhAHPXD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jan 2021 10:23:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328ED2399A;
        Fri,  8 Jan 2021 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610119341;
        bh=tPW5bEpr0HqmvYnvrUcfD/JhFnM30ms0uYvuur4C/dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXB0d0Rg4e9denrKlcQmt1bttQK1VJX/EHrAseDYIEzW0i8f4S+cSyL+QI8C+zfWI
         kLD+pghsys5E1NaUSHYaTTRmIgl0/FXcx/e3HZBYaZzYY2N8NuQVfRUrxzI4KkABzR
         VGC/lkQr8aj5eN+33Z6nm9z63AKAgfW1ow78MWeNbFwh4PjUEnmeOF9WAwUTkDTcgY
         9phTWBhCxxPwx9jRtyQfuGKE8uO1JOQlBmeA/WVkDAFoc2UrtEzByoQT0UWwdwyvWm
         18qbmks5AcTi20wNk167tzNZk0bKuANaVnnWiIg9XWFvF49cz7AkiPhrpLuUnkhjUW
         AdFwp1FliZPbA==
Date:   Fri, 8 Jan 2021 10:22:20 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
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
Message-ID: <20210108152220.GC4035784@sasha-vm>
References: <20201001013814.2435935-1-sashal@kernel.org>
 <87o8lm9te3.fsf@vitty.brq.redhat.com>
 <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
 <20201001130400.GE2415204@sasha-vm>
 <MW2PR2101MB105242653A8D5C7DD9DF1062D70E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20201005145851.hdyaeqo3celt2wtr@liuwe-devbox-debian-v2>
 <MWHPR21MB1593B4387204C522536F80CCD7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593B4387204C522536F80CCD7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 05, 2021 at 04:59:10PM +0000, Michael Kelley wrote:
>From: Wei Liu <wei.liu@kernel.org> Sent: Monday, October 5, 2020 7:59 AM
>>
>> On Sat, Oct 03, 2020 at 05:40:15PM +0000, Michael Kelley wrote:
>> > From: Sasha Levin <sashal@kernel.org>  Sent: Thursday, October 1, 2020 6:04 AM
>> > >
>> > > On Thu, Oct 01, 2020 at 11:53:59AM +0000, Wei Liu wrote:
>> > > >On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
>> > > >> Sasha Levin <sashal@kernel.org> writes:
>> > > >>
>> > > >> > cpumask can change underneath us, which is generally safe except when we
>> > > >> > call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
>> > > >> > num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
>> > > >> > garbage. As reported by KASAN:
>> > > >> >
>> > > >> > [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others
>> > > (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
>> > > >> > [   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
>> > > >> > [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
>> > > >> > [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual
>> Machine,
>> > > BIOS 090008  12/07/2018
>> > > >> > [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
>> > > >> > [   84.196669] Call Trace:
>> > > >> > [   84.196669] dump_stack (lib/dump_stack.c:120)
>> > > >> > [   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
>> > > >> > [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
>> > > >> > [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71
>> > > mm/kasan/common.c:635)
>> > > >> > [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128
>> > > arch/x86/hyperv/mmu.c:112)
>> > > >> > [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68
>> > > arch/x86/mm/tlb.c:798)
>> > > >> > [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-
>> > > generic.c:88)
>> > > >> >
>> > > >> > Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper
>> > > HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
>> > > >> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > > >> > Cc: stable@kernel.org
>> > > >> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > > >> > ---
>> > > >> >  arch/x86/hyperv/mmu.c | 4 +++-
>> > > >> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > > >> >
>> > > >> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> > > >> > index 5208ba49c89a9..b1d6afc5fc4a3 100644
>> > > >> > --- a/arch/x86/hyperv/mmu.c
>> > > >> > +++ b/arch/x86/hyperv/mmu.c
>> > > >> > @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct cpumask
>> > > *cpus,
>> > > >> >  		 * must. We will also check all VP numbers when walking the
>> > > >> >  		 * supplied CPU set to remain correct in all cases.
>> > > >> >  		 */
>> > > >> > -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
>> > > >> > +		int last = cpumask_last(cpus);
>> > > >> > +
>> > > >> > +		if (last < num_possible_cpus() &&
>> hv_cpu_number_to_vp_number(last) >=
>> > > 64)
>> > > >> >  			goto do_ex_hypercall;
>> > > >>
>> > > >> In case 'cpus' can end up being empty (I'm genuinely suprised it can)
>> > >
>> > > I was just as surprised as you and spent the good part of a day
>> > > debugging this. However, a:
>> > >
>> > > 	WARN_ON(cpumask_empty(cpus));
>> > >
>> > > triggers at that line of code even though we check for cpumask_empty()
>> > > at the entry of the function.
>> >
>> > What does the call stack look like when this triggers?  I'm curious about
>> > the path where the 'cpus' could be changing while the flush call is in
>> > progress.
>> >
>> > I wonder if CPUs could ever be added to the mask?  Removing CPUs can
>> > be handled with some care because an unnecessary flush doesn't hurt
>> > anything.   But adding CPUs has serious correctness problems.
>> >
>>
>> The cpumask_empty check is done before disabling irq. Is it possible
>> the mask is modified by an interrupt?
>>
>> If there is a reliable way to trigger this bug, we may be able to test
>> the following patch.
>>
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index 5208ba49c89a..23fa08d24c1a 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -66,11 +66,13 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
>>         if (!hv_hypercall_pg)
>>                 goto do_native;
>>
>> -       if (cpumask_empty(cpus))
>> -               return;
>> -
>>         local_irq_save(flags);
>>
>> +       if (cpumask_empty(cpus)) {
>> +               local_irq_restore(flags);
>> +               return;
>> +       }
>> +
>>         flush_pcpu = (struct hv_tlb_flush **)
>>                      this_cpu_ptr(hyperv_pcpu_input_arg);
>
>This thread died out 3 months ago without any patches being taken.
>I recently hit the problem again at random, though not in a
>reproducible way.
>
>I'd like to take Wei Liu's latest proposal to check for an empty
>cpumask *after* interrupts are disabled.   I think this will almost
>certainly solve the problem, and in a cleaner way than Sasha's
>proposal.  I'd also suggest adding a comment in the code to note
>the importance of the ordering.

I found that this syzbot reproducer:
https://syzkaller.appspot.com//bug?id=47befb59c610a69f024db20b927dea80c88fc045
is pretty good at reproducing the issue too:

BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others+0x11ea/0x17c0
Read of size 4 at addr ffff88810005db20 by task 3.c.exe/13007

CPU: 4 PID: 13007 Comm: 3.c.exe Not tainted 5.10.5 #1
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 06/17/2020
Call Trace:
  dump_stack+0xa4/0xd9
  print_address_description.constprop.0.cold+0xd4/0x509
  kasan_report.cold+0x20/0x37
  __asan_report_load4_noabort+0x14/0x20
  hyperv_flush_tlb_others+0x11ea/0x17c0
  flush_tlb_mm_range+0x1fd/0x360
  tlb_flush_mmu+0x1b5/0x510
  tlb_finish_mmu+0x89/0x360
  exit_mmap+0x24f/0x450
  mmput+0x121/0x400
  do_exit+0x8cf/0x2a70
  do_group_exit+0x100/0x300
  get_signal+0x3d7/0x1e70
  arch_do_signal+0x8c/0x2670
  exit_to_user_mode_prepare+0x154/0x1f0
  syscall_exit_to_user_mode+0x42/0x280
  do_syscall_64+0x45/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x450c2d
Code: Unable to access opcode bytes at RIP 0x450c03.
RSP: 002b:00007f6c81711d68 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000000000450c2d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000004e0428
RBP: 00007f6c81711d80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeeef33d2e
R13: 00007ffeeef33d2f R14: 00007ffeeef33dd0 R15: 00007f6c81711e80

Allocated by task 0:
  kasan_save_stack+0x23/0x50
  __kasan_kmalloc.constprop.0+0xcf/0xe0
  kasan_kmalloc+0x9/0x10
  __kmalloc+0x1c8/0x3b0
  kmalloc_array+0x12/0x14
  hyperv_init+0xd4/0x3a0
  apic_intr_mode_init+0xbb/0x1e8
  x86_late_time_init+0x96/0xa7
  start_kernel+0x317/0x3d3
  x86_64_start_reservations+0x24/0x26
  x86_64_start_kernel+0x7a/0x7e
  secondary_startup_64_no_verify+0xb0/0xbb

The buggy address belongs to the object at ffff88810005db00
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
  32-byte region [ffff88810005db00, ffff88810005db20)
The buggy address belongs to the page:
page:0000000065310ff0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10005d
flags: 0x17ffffc0000200(slab)
raw: 0017ffffc0000200 0000000000000000 0000000100000001 ffff888100043a40
raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88810005da00: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
  ffff88810005da80: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
>ffff88810005db00: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                ^
  ffff88810005db80: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
  ffff88810005dc00: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc

-- 
Thanks,
Sasha
