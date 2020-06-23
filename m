Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10548204E19
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2020 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgFWJhj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Jun 2020 05:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbgFWJhj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Jun 2020 05:37:39 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2BC061573;
        Tue, 23 Jun 2020 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rr3b1L/FRTesaaOv4/PvWj0LHdOB3M9NfrW+uOEVYWA=; b=YzRmSVnafR71kfHBMtvsTFlor4
        R+lp5VMgL0ebzHOh+QEWTBnMhVzxPSRJSHxoDsIzRrvVxe1a7hyOEZkLFNynKT0S4zR6n9Ny4aEXD
        Xar4W98pYb2i2DeNZZEUUsaOPqH3xOSDCrwgMe01aiW8B8EbuUDcYOxLKwiXLnTfn2j2JYDvjW68F
        qeVTgtIwKZYkV8POYR+MmUm1uOYFFqlNglQVmBTKco9lFLO2Vt7VcA9opS2xLXGxq+z/3HXWD7Y9C
        g++uw7TqMk9ZEU4jy1S8OZTepUzIql6kpRloaga4DMwh4j4EUlzV3Zz3xPGj3qZNwYbT3IeWi5gf1
        ICi5L0BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnfMi-0007Fm-AT; Tue, 23 Jun 2020 09:37:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1C5C3003E5;
        Tue, 23 Jun 2020 11:37:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9947A2370F7C4; Tue, 23 Jun 2020 11:37:14 +0200 (CEST)
Date:   Tue, 23 Jun 2020 11:37:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20200623093714.GE4781@hirez.programming.kicks-ass.net>
References: <20200618064307.32739-1-hch@lst.de>
 <20200618064307.32739-3-hch@lst.de>
 <20200620191616.bae356186ba3329ade67bbf7@linux-foundation.org>
 <20200623090505.GA7518@lst.de>
 <20200623090757.GB3743@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623090757.GB3743@willie-the-truck>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 23, 2020 at 10:07:58AM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 11:05:05AM +0200, Christoph Hellwig wrote:
> > On Sat, Jun 20, 2020 at 07:16:16PM -0700, Andrew Morton wrote:
> > > On Thu, 18 Jun 2020 08:43:06 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > > 
> > > > Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
> > > > page read-only just after the allocation.
> > > > 
> > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > @@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> > > >  
> > > >  void *alloc_insn_page(void)
> > > >  {
> > > > -	void *page;
> > > > -
> > > > -	page = vmalloc_exec(PAGE_SIZE);
> > > > -	if (page) {
> > > > -		set_memory_ro((unsigned long)page, 1);
> > > > -		set_vm_flush_reset_perms(page);
> > > > -	}
> > > > -
> > > > -	return page;
> > > > +	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > > > +			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > > > +			NUMA_NO_NODE, __func__);
> > > >  }
> > > >  
> > > >  /* arm kprobe: install breakpoint in text */
> > > 
> > > But why.  I think this is just a cleanup, doesn't address any runtime issue?
> > 
> > It doesn't "fix" an issue - it just simplifies and speeds up the code.
> 
> Ok, but I don't understand the PLT comment from Peter in
> 20200618092754.GF576905@hirez.programming.kicks-ass.net:
> 
>   | I think this has the exact same range issue as the x86 user. But it
>   | might be less fatal if their PLT magic can cover the full range.
> 
> Peter, please could you elaborate on your concern? I feel like I'm missing
> some context.

On x86 we can only directly call code in a (signed) 32bit immediate
range (2G) and our kernel text and module range are constrained by that.

IIRC ARM64 has an even smaller immediate range and needs to play fixup
games with trampolines or somesuch (there was an ARM specific name for
it that I've misplaced again). Does that machinery cover the entire
vmalloc space or are you only able to fix up for a smaller range?

Your arch/arm64/kernel/module.c:module_alloc() implementation seems to
have an explicit module range different from the full vmalloc range, I'm
thinking this is for a reason.
