Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFDA204E9B
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2020 11:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgFWJ5n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Jun 2020 05:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731947AbgFWJ5n (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Jun 2020 05:57:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2380020771;
        Tue, 23 Jun 2020 09:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592906263;
        bh=I6FXAd+dz0PTFAbZZ7Ggg1D9VAM+5cmaOuIX+WynUXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkrUXXkMa7i2f43LSN2xaCpKDWrWjr9vOWsyZcdZfiB4wnJ0kZuDW76qe4YyJNbrA
         aEg23Q87gKOMdnDv8U0QvRrDTW7qWtqkVsfHY073/OprQW1G+a9vHKzgntu2AxnTod
         889AuqDXeVGDQuPIkRG0Lyv7qEbtZ0eDRJML51+w=
Date:   Tue, 23 Jun 2020 10:57:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jessica Yu <jeyu@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in
 alloc_insn_page
Message-ID: <20200623095737.GD3743@willie-the-truck>
References: <20200618064307.32739-1-hch@lst.de>
 <20200618064307.32739-3-hch@lst.de>
 <20200620191616.bae356186ba3329ade67bbf7@linux-foundation.org>
 <20200623090505.GA7518@lst.de>
 <20200623090757.GB3743@willie-the-truck>
 <20200623093714.GE4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623093714.GE4781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 23, 2020 at 11:37:14AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 10:07:58AM +0100, Will Deacon wrote:
> > On Tue, Jun 23, 2020 at 11:05:05AM +0200, Christoph Hellwig wrote:
> > > On Sat, Jun 20, 2020 at 07:16:16PM -0700, Andrew Morton wrote:
> > > > On Thu, 18 Jun 2020 08:43:06 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > > @@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> > > > >  
> > > > >  void *alloc_insn_page(void)
> > > > >  {
> > > > > -	void *page;
> > > > > -
> > > > > -	page = vmalloc_exec(PAGE_SIZE);
> > > > > -	if (page) {
> > > > > -		set_memory_ro((unsigned long)page, 1);
> > > > > -		set_vm_flush_reset_perms(page);
> > > > > -	}
> > > > > -
> > > > > -	return page;
> > > > > +	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > > > > +			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > > > > +			NUMA_NO_NODE, __func__);
> > > > >  }
> > > > >  
> > > > >  /* arm kprobe: install breakpoint in text */
> > > > 
> > > > But why.  I think this is just a cleanup, doesn't address any runtime issue?
> > > 
> > > It doesn't "fix" an issue - it just simplifies and speeds up the code.
> > 
> > Ok, but I don't understand the PLT comment from Peter in
> > 20200618092754.GF576905@hirez.programming.kicks-ass.net:
> > 
> >   | I think this has the exact same range issue as the x86 user. But it
> >   | might be less fatal if their PLT magic can cover the full range.
> > 
> > Peter, please could you elaborate on your concern? I feel like I'm missing
> > some context.
> 
> On x86 we can only directly call code in a (signed) 32bit immediate
> range (2G) and our kernel text and module range are constrained by that.
> 
> IIRC ARM64 has an even smaller immediate range and needs to play fixup
> games with trampolines or somesuch (there was an ARM specific name for
> it that I've misplaced again). Does that machinery cover the entire
> vmalloc space or are you only able to fix up for a smaller range?
> 
> Your arch/arm64/kernel/module.c:module_alloc() implementation seems to
> have an explicit module range different from the full vmalloc range, I'm
> thinking this is for a reason.

Ah, gotcha. In this case, we're talking about the kprobe out-of-line
buffer. We don't directly branch to that; instead we take a BRK exception
and either exception return + singlestep the OOL buffer, or we simulate
the instruction if it's doing anything PC-relative, so I don't see the
need for a PLT.

Will
