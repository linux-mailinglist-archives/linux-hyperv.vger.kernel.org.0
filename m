Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693A527FEAD
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Oct 2020 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgJALyH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Oct 2020 07:54:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35197 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbgJALyE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Oct 2020 07:54:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so5363908wrm.2;
        Thu, 01 Oct 2020 04:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjEMtQV4+mKov3RyEvL2p8vci/KPjj4gyXV5HFr4bPc=;
        b=b4h+AThi7lMNfqipaCF70dryQ7rghrc3kGH1kfJ6QRJ6sbselZbvESFc7c2r9ARXrS
         hvd/f09+8mFbKTppTX0Gp8WpI0fOqZ+AtHIfqe+qZzbYwWgZmsai1K1qpJMwgu4zokES
         7WWHvJ1GCbsFsJsI9v/qyfS9IsdtIF6u87ltsj7BbNHfBPeDnyknNcdvmHXi4Vg4j33I
         gNrdWb6PU6pLFZeIgu5hFxFvq3qc9s3T/vKiL5QEIh4tlU3wcOO4CvPSsg5Qkj2JTjKb
         51qvgS3DyXSkPYqP+HJKGMx+X4d3CmNv4ZCd74dTFfnQaeNRq00ilKV8cTM+Rnmgkl68
         /TMQ==
X-Gm-Message-State: AOAM530PBmLvpo1qCWXc+J4RhnhKQpRLRldKN2dJooS6H6olKBy89CKY
        L7NVomr+j6zXnFs21cWRpIw=
X-Google-Smtp-Source: ABdhPJzfEPCoC4dSc6yo8yiwrjfjgNGFM6Ov812hYIpeuIQMHakZq8GmSq7lhhZTC7m73NSlbg0kRA==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr8995115wru.423.1601553241933;
        Thu, 01 Oct 2020 04:54:01 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s19sm5286587wmc.0.2020.10.01.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 04:54:01 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:53:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Message-ID: <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
References: <20201001013814.2435935-1-sashal@kernel.org>
 <87o8lm9te3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8lm9te3.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
> Sasha Levin <sashal@kernel.org> writes:
> 
> > cpumask can change underneath us, which is generally safe except when we
> > call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
> > num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
> > garbage. As reported by KASAN:
> >
> > [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> > [   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
> > [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
> > [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> > [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
> > [   84.196669] Call Trace:
> > [   84.196669] dump_stack (lib/dump_stack.c:120)
> > [   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
> > [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
> > [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71 mm/kasan/common.c:635)
> > [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> > [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68 arch/x86/mm/tlb.c:798)
> > [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-generic.c:88)
> >
> > Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: stable@kernel.org
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  arch/x86/hyperv/mmu.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> > index 5208ba49c89a9..b1d6afc5fc4a3 100644
> > --- a/arch/x86/hyperv/mmu.c
> > +++ b/arch/x86/hyperv/mmu.c
> > @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
> >  		 * must. We will also check all VP numbers when walking the
> >  		 * supplied CPU set to remain correct in all cases.
> >  		 */
> > -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
> > +		int last = cpumask_last(cpus);
> > +
> > +		if (last < num_possible_cpus() && hv_cpu_number_to_vp_number(last) >= 64)
> >  			goto do_ex_hypercall;
> 
> In case 'cpus' can end up being empty (I'm genuinely suprised it can)
> the check is mandatory indeed. I would, however, just return directly in
> this case:
> 
> if (last < num_possible_cpus())
> 	return;

I think you want 

   last >= num_possible_cpus()

here?

A more important question is, if the mask can change willy-nilly, what
is stopping it from changing between these checks? I.e. is there still a
windows that hv_cpu_number_to_vp_number(last) can return garbage?

Wei.

> 
> if (hv_cpu_number_to_vp_number(last) >= 64)
> 	goto do_ex_hypercall;
> 
> as there's nothing to flush, no need to call into
> hyperv_flush_tlb_others_ex().
> 
> Anyway, the fix seems to be correct, so
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> >  
> >  		for_each_cpu(cpu, cpus) {
> 
> -- 
> Vitaly
> 
