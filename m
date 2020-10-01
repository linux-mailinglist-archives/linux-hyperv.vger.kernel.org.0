Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC89427FFC5
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Oct 2020 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgJANKz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Oct 2020 09:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732016AbgJANKy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Oct 2020 09:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601557852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFUnXQMv4aORWxidWComJlT9MonN8L32jYIrDxmnjB0=;
        b=JAGxRlSwjozFj7nXdaBzN2wtW/5jJcAowYVMU+sHNlgXfUS8p/1oBLvnjNKenAgjH0B6Xr
        aFJj2xFGm4YC4DK6pIuYczTZqh4iZRMIzRXzw3yl9fw46oe4xSsdF+zg5Uvc82PVpU4cV1
        ytRcL3cqoi3A1A7aan42m2l/3twsUoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-v93DxW6NOC6gZ3-wKfB6Rg-1; Thu, 01 Oct 2020 09:10:49 -0400
X-MC-Unique: v93DxW6NOC6gZ3-wKfB6Rg-1
Received: by mail-wm1-f72.google.com with SMTP id a7so1174702wmc.2
        for <linux-hyperv@vger.kernel.org>; Thu, 01 Oct 2020 06:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xFUnXQMv4aORWxidWComJlT9MonN8L32jYIrDxmnjB0=;
        b=QIpkfDxvFcvM/OLOBt4WKVBgRnJcqtXg14km+1uTsIU9b0F0v4pvpu+gIftTZN/Zya
         QD8fEri/5UZl14tC1JhuD5TcnIwkBGBf4XDVgyjGZoeFR6d96XQw0NQfnOXuLT1TP0aZ
         R6hSQxRJs9vzHJOgmUsH8f+e2wJH4KQysS6BDeVVfRpwtZvlDlHR80I+rYin4dED/b5d
         s3utuZ505+MwbZDOrkjzisUEPvJz9wPwf80IpqX4vOqoPdzJFaM3vSds2OwIAt+1ZPAU
         APF7KKvmnlrmqbSy/CV3tK7i7Z8GpYxgvYnom8Tdc7lUXUCQVQsmG73PatYtcLoEELzO
         fq6g==
X-Gm-Message-State: AOAM530JCSfSKz2CuIW9HDuw6Ot8yic430D114OCS9B4V9H3ojW32tCt
        C8Y6yfKfE5U1hph6mSwuxt6xGfDMy3tPB9jeENZ3bg+8WHcsyZ3XxFb0YIyE+qLd3g3UnvP1xVH
        vFmESSP1MOcBREPaDuJRBAPay
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr9570305wru.363.1601557848367;
        Thu, 01 Oct 2020 06:10:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5nY4zdx/I3zgIudVnED4xhXFzBZtNznZtR56A9chCs3NritAa14+llvalqigruR7QUdi/6Q==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr9570229wru.363.1601557847793;
        Thu, 01 Oct 2020 06:10:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n3sm8789121wmn.28.2020.10.01.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 06:10:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_flush_tlb_others()
In-Reply-To: <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
References: <20201001013814.2435935-1-sashal@kernel.org> <87o8lm9te3.fsf@vitty.brq.redhat.com> <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
Date:   Thu, 01 Oct 2020 15:10:44 +0200
Message-ID: <87ft6y9jmz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
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
>> the check is mandatory indeed. I would, however, just return directly in
>> this case:
>> 
>> if (last < num_possible_cpus())
>> 	return;
>
> I think you want 
>
>    last >= num_possible_cpus()
>
> here?

Of course, thanks!

>
> A more important question is, if the mask can change willy-nilly, what
> is stopping it from changing between these checks? I.e. is there still a
> windows that hv_cpu_number_to_vp_number(last) can return garbage?
>

AFAIU some CPUs can be dropped from the mask (because they switch to a
different mm?) and if we still flush there it's not a problem. The only
real problem I currently see is that we're passing cpumask_last() result
to hv_cpu_number_to_vp_number() and cpumask_last() returns
num_possible_cpus() when the mask is empty but this can't be passed to
hv_cpu_number_to_vp_number().


> Wei.
>
>> 
>> if (hv_cpu_number_to_vp_number(last) >= 64)
>> 	goto do_ex_hypercall;
>> 
>> as there's nothing to flush, no need to call into
>> hyperv_flush_tlb_others_ex().
>> 
>> Anyway, the fix seems to be correct, so
>> 
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> >  
>> >  		for_each_cpu(cpu, cpus) {
>> 
>> -- 
>> Vitaly
>> 
>

-- 
Vitaly

