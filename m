Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDC204D85
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2020 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbgFWJID (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Jun 2020 05:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731921AbgFWJID (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Jun 2020 05:08:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48AE2072E;
        Tue, 23 Jun 2020 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592903282;
        bh=4D4etCCkvCMI5PLH239PBNnalPiuS1ItXNUo7xWS8Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHdOSaDzsWU/azllZeEMWUI6XHlYmLBCYddZDxOHLkPSw/+CWIZoY1DrnbQbVo9rf
         sj6A9ATSHe9ypb2epOcvDg6I/jGPqB3DptqgPA4Uqws0tJkbOpNjRL+VIVWM0CtYFp
         6OkFh2UgQjvP55uFoeTooceRYxYVpoULiM5EbXFI=
Date:   Tue, 23 Jun 2020 10:07:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jessica Yu <jeyu@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in
 alloc_insn_page
Message-ID: <20200623090757.GB3743@willie-the-truck>
References: <20200618064307.32739-1-hch@lst.de>
 <20200618064307.32739-3-hch@lst.de>
 <20200620191616.bae356186ba3329ade67bbf7@linux-foundation.org>
 <20200623090505.GA7518@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623090505.GA7518@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 23, 2020 at 11:05:05AM +0200, Christoph Hellwig wrote:
> On Sat, Jun 20, 2020 at 07:16:16PM -0700, Andrew Morton wrote:
> > On Thu, 18 Jun 2020 08:43:06 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
> > > page read-only just after the allocation.
> > > 
> > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > @@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> > >  
> > >  void *alloc_insn_page(void)
> > >  {
> > > -	void *page;
> > > -
> > > -	page = vmalloc_exec(PAGE_SIZE);
> > > -	if (page) {
> > > -		set_memory_ro((unsigned long)page, 1);
> > > -		set_vm_flush_reset_perms(page);
> > > -	}
> > > -
> > > -	return page;
> > > +	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > > +			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > > +			NUMA_NO_NODE, __func__);
> > >  }
> > >  
> > >  /* arm kprobe: install breakpoint in text */
> > 
> > But why.  I think this is just a cleanup, doesn't address any runtime issue?
> 
> It doesn't "fix" an issue - it just simplifies and speeds up the code.

Ok, but I don't understand the PLT comment from Peter in
20200618092754.GF576905@hirez.programming.kicks-ass.net:

  | I think this has the exact same range issue as the x86 user. But it
  | might be less fatal if their PLT magic can cover the full range.

Peter, please could you elaborate on your concern? I feel like I'm missing
some context.

Cheers,

Will
