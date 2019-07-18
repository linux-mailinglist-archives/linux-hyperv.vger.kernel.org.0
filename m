Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB06C99E
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jul 2019 09:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfGRHBE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jul 2019 03:01:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfGRHBE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jul 2019 03:01:04 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ho0PM-00009E-Bd; Thu, 18 Jul 2019 09:00:52 +0200
Date:   Thu, 18 Jul 2019 09:00:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dexuan Cui <decui@microsoft.com>
cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
In-Reply-To: <PU1P153MB01693AB444C4A432FBA2507BBFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.1907180846290.1778@nanos.tec.linutronix.de>
References: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <alpine.DEB.2.21.1907180058210.1778@nanos.tec.linutronix.de> <PU1P153MB01693AB444C4A432FBA2507BBFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 18 Jul 2019, Dexuan Cui wrote:
> > On Thu, 4 Jul 2019, Dexuan Cui wrote:
> > This is the allocation when the CPU is brought online for the first
> > time. So what effect has zeroing at allocation time vs. offlining and
> > potentially receiving IPIs? That allocation is never freed.
> > 
> > Neither the comment nor the changelog make any sense to me.
> > 	tglx
> 
> That allocation was introduced by the commit
> a46d15cc1ae5 ("x86/hyper-v: allocate and use Virtual Processor Assist Pages").
> 
> I think it's ok to not free the page when a CPU is offlined: every
> CPU uses only 1 page and CPU offlining is not really a very usual
> operation except for the scenario of hibernation (and suspend-to-memory), 
> where the CPUs are quickly onlined again, when we resume from hibernation.
> IMO Vitaly intentionally decided to not free the page for simplicity of the
> code.
> 
> When a CPU (e.g. CPU1) is being onlined, in hv_cpu_init(), we allocate the
> VP_ASSIST_PAGE page and enable the PV EOI optimization for this CPU by
> writing the MSR HV_X64_MSR_VP_ASSIST_PAGE. From now on, this CPU
> *always* uses hvp->apic_assist (which is updated by the hypervisor) to
> decide if it needs to write the EOI MSR:
> 
> static void hv_apic_eoi_write(u32 reg, u32 val)
> {
>         struct hv_vp_assist_page *hvp = hv_vp_assist_page[smp_processor_id()];
> 
>         if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
>                 return;
> 
>         wrmsr(HV_X64_MSR_EOI, val, 0);
> }
> 
> When a CPU (e.g. CPU1) is being offlined, on this CPU, we do:
> 1. in hv_cpu_die(), we disable the PV EOI optimizaton for this CPU;
> 2. we finish the remaining work of stopping this CPU;
> 3. this CPU is completed stopped.
> 
> Between 1 and 3, this CPU can still receive interrupts (e.g. IPIs from CPU0,
> and Local APIC timer interrupts), and this CPU *must* write the EOI MSR for
> every interrupt received, otherwise the hypervisor may not deliver further
> interrupts, which may be needed to stop this CPU completely.
> 
> So we need to make sure hvp->apic_assist.bit0 is zero, after we run the line
> "wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);" in hv_cpu_die(). The easiest
> way is what I do in this patch. Alternatively, we can use the below patch:
> 
> @@ -188,8 +188,12 @@ static int hv_cpu_die(unsigned int cpu)
>         local_irq_restore(flags);
>         free_page((unsigned long)input_pg);
> 
> -       if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> +       if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +               local_irq_save(flags);
>                 wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +               hvp->apic_assist &= ~1;
> +               local_irq_restore(flags);
> +       }
> 
>         if (hv_reenlightenment_cb == NULL)
>                 return 0;
> 
> This second version needs 3+ lines, so I prefer the one-line version. :-)

Those are two different things. The GPF_ZERO allocation makes sense on it's
own but it _cannot_ prevent the following scenario:

    cpu_init()
      if (!hvp)
      	 hvp = vmalloc(...., GFP_ZERO);
    ...

    hvp->apic_assist |= 1;

#1   cpu_die()
      if (....)
           wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);

   ---> IPI
   	if (!(hvp->apic_assist & 1))	
	   wrmsr(APIC_EOI);    <- PATH not taken

#3   cpu is dead

    cpu_init()
       if (!hvp)
          hvp = vmalloc(....m, GFP_ZERO);  <- NOT TAKEN because hvp != NULL

So you have to come up with a better fairy tale why GFP_ZERO 'fixes' this.

Allocating hvp with GFP_ZERO makes sense on it's own so the allocated
memory has a defined state, but that's a different story.

The 3 liner patch above makes way more sense and you can spare the
local_irq_save/restore by moving the whole condition into the
irq_save/restore region above.

Thanks,

	tglx

