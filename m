Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C212C1FADB9
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPKSh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPKSg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:18:36 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB0C08C5C2;
        Tue, 16 Jun 2020 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wquZFMN4OPMpdUiihGAlDawgg0Uvcwgrh1bbmAL+MWM=; b=XqmgLCtGPWiSfuqGwrJuMqnp8A
        s7EauU5s7sVmL/uSLUQ9e+3MKaJcTOXe10kDlyF9T1lit4Eg2pORaW+DkeBsB6FolbaaxfM+FhZ2p
        yQ2Wt3mElqKHl2Lcbyy+f2A3sTEWP2aqxm5695QKG1LjLnVhiXAsbTnSIEeEDXjb++7QI0bPDL0tj
        MDg5jLFNT5a4Bwx992bf6mWTFSjyOkUagg6WdcPK4aWkoNuknq7L+s7iudmJfMvlPBQZJ8qQgLCpa
        0U9U2ih7qM9QvqodbyAn0jdNOcmE5f7kkZj7DP3XVtpZXFuWuBjIvcq+rB2MlxSbbkoARjMmeHIUQ
        7S75g4MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl8fS-0006bT-JI; Tue, 16 Jun 2020 10:18:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C46443010C8;
        Tue, 16 Jun 2020 12:18:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6FA2203EDAB0; Tue, 16 Jun 2020 12:18:07 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:18:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dexuan Cui <decui@microsoft.com>, vkuznets <vkuznets@redhat.com>,
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
Message-ID: <20200616101807.GO2531@hirez.programming.kicks-ass.net>
References: <20200407073830.GA29279@lst.de>
 <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net>
 <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <87y2ooiv5k.fsf@vitty.brq.redhat.com>
 <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <20200616072318.GA17600@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616072318.GA17600@lst.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 09:23:18AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 15, 2020 at 07:49:41PM +0000, Dexuan Cui wrote:
> > I did this experiment:
> >   1. export vmalloc_exec and ptdump_walk_pgd_level_checkwx.
> >   2. write a test module that calls them.
> >   3. It turns out that every call of vmalloc_exec() triggers such a warning.
> > 
> > vmalloc_exec() uses PAGE_KERNEL_EXEC, which is defined as
> >    (__PP|__RW|   0|___A|   0|___D|   0|___G)
> > 
> > It looks the logic in note_page() is: for_each_RW_page, if the NX bit is unset,
> > then report the page as an insecure W+X mapping. IMO this explains the
> > warning?
> 
> It does.  But it also means every other user of PAGE_KERNEL_EXEC
> should trigger this, of which there are a few (kexec, tboot, hibernate,
> early xen pv mapping, early SEV identity mapping)

There are only 3 users in the entire tree afaict:

arch/arm64/kernel/probes/kprobes.c:     page = vmalloc_exec(PAGE_SIZE);
arch/x86/hyperv/hv_init.c:      hv_hypercall_pg = vmalloc_exec(PAGE_SIZE);
kernel/module.c:        return vmalloc_exec(size);

And that last one is a weak function that any arch that has STRICT_RWX
ought to override.

> We really shouldn't create mappings like this by default.  Either we
> need to flip PAGE_KERNEL_EXEC itself based on the needs of the above
> users, or add another define to overload vmalloc_exec as there is no
> other user of that for x86.

We really should get rid of the two !module users of this though; both
x86 and arm64 have STRICT_RWX and sufficient primitives to DTRT.

What is HV even trying to do with that page? AFAICT it never actually
writes to it, it seens to give the physica address to an MSR (which I
suspect then writes crud into the page for us from host context).

Suggesting the page really only needs to be RX.

On top of that, vmalloc_exec() gets us a page from the entire vmalloc
range, which can be outside of the 2G executable range, which seems to
suggest vmalloc_exec() is wrong too and all this works by accident.

How about something like this:


diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a54c6a401581..82a3a4a9481f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -375,12 +375,15 @@ void __init hyperv_init(void)
 	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	hv_hypercall_pg = vmalloc_exec(PAGE_SIZE);
+	hv_hypercall_pg = module_alloc(PAGE_SIZE);
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 		goto remove_cpuhp_state;
 	}
 
+	set_memory_ro((unsigned long)hv_hypercall_pg, 1);
+	set_memory_x((unsigned long)hv_hypercall_pg, 1);
+
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 1;
 	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
