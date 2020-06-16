Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A801FADD6
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgFPKYP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:24:15 -0400
Received: from verein.lst.de ([213.95.11.211]:37438 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgFPKYP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:24:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5465968AEF; Tue, 16 Jun 2020 12:24:12 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:24:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dexuan Cui <decui@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616102412.GB29684@lst.de>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <20200616072318.GA17600@lst.de> <20200616101807.GO2531@hirez.programming.kicks-ass.net> <20200616102350.GA29684@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616102350.GA29684@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:23:50PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 16, 2020 at 12:18:07PM +0200, Peter Zijlstra wrote:
> > > It does.  But it also means every other user of PAGE_KERNEL_EXEC
> > > should trigger this, of which there are a few (kexec, tboot, hibernate,
> > > early xen pv mapping, early SEV identity mapping)
> > 
> > There are only 3 users in the entire tree afaict:
> > 
> > arch/arm64/kernel/probes/kprobes.c:     page = vmalloc_exec(PAGE_SIZE);
> > arch/x86/hyperv/hv_init.c:      hv_hypercall_pg = vmalloc_exec(PAGE_SIZE);
> > kernel/module.c:        return vmalloc_exec(size);
> > 
> > And that last one is a weak function that any arch that has STRICT_RWX
> > ought to override.
> > 
> > > We really shouldn't create mappings like this by default.  Either we
> > > need to flip PAGE_KERNEL_EXEC itself based on the needs of the above
> > > users, or add another define to overload vmalloc_exec as there is no
> > > other user of that for x86.
> > 
> > We really should get rid of the two !module users of this though; both
> > x86 and arm64 have STRICT_RWX and sufficient primitives to DTRT.
> > 
> > What is HV even trying to do with that page? AFAICT it never actually
> > writes to it, it seens to give the physica address to an MSR (which I
> > suspect then writes crud into the page for us from host context).
> > 
> > Suggesting the page really only needs to be RX.
> > 
> > On top of that, vmalloc_exec() gets us a page from the entire vmalloc
> > range, which can be outside of the 2G executable range, which seems to
> > suggest vmalloc_exec() is wrong too and all this works by accident.
> > 
> > How about something like this:
> > 
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index a54c6a401581..82a3a4a9481f 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -375,12 +375,15 @@ void __init hyperv_init(void)
> >  	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> >  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
> >  
> > -	hv_hypercall_pg = vmalloc_exec(PAGE_SIZE);
> > +	hv_hypercall_pg = module_alloc(PAGE_SIZE);
> >  	if (hv_hypercall_pg == NULL) {
> >  		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> >  		goto remove_cpuhp_state;
> >  	}
> >  
> > +	set_memory_ro((unsigned long)hv_hypercall_pg, 1);
> > +	set_memory_x((unsigned long)hv_hypercall_pg, 1);
> 
> The changing of the permissions sucks.  I thought about adding
> a module_alloc_prot with an explicit pgprot_t argument.  On x86
> alone at least ftrace would also benefit from that.

The above is also missing a set_vm_flush_reset_perms.
