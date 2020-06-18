Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8EB1FF3C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgFRNub (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 09:50:31 -0400
Received: from verein.lst.de ([213.95.11.211]:49162 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgFRNub (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 09:50:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D7846736F; Thu, 18 Jun 2020 15:50:28 +0200 (CEST)
Date:   Thu, 18 Jun 2020 15:50:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in
 alloc_insn_page
Message-ID: <20200618135027.GA23534@lst.de>
References: <20200618064307.32739-1-hch@lst.de> <20200618064307.32739-3-hch@lst.de> <90234f58-e83a-7f20-62a7-80a4e81cde95@redhat.com> <20200618103506.GH576905@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618103506.GH576905@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 18, 2020 at 12:35:06PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 18, 2020 at 10:55:58AM +0200, David Hildenbrand wrote:
> > On 18.06.20 08:43, Christoph Hellwig wrote:
> > > Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
> > > page read-only just after the allocation.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/arm64/kernel/probes/kprobes.c | 12 +++---------
> > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > index d1c95dcf1d7833..cbe49cd117cfec 100644
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
> > 
> > I do wonder if something like vmalloc_prot(size, prot) would make this
> > (and the other two users) easier to read.
> > 
> > So instead of ripping out vmalloc_exec(), converting it into
> > vmalloc_prot() instead.
> > 
> > Did you consider that?
> 
> For x86 Christoph did module_alloc_prot(), which is in his more
> extensive set of patches addressing this. I suspect that would be the
> right thing for ARM64 as well.

Yes.  The somewhat hacky way I added it cause problems for UML, so I
instead plan to do a series converting all architectures over to
module_alloc_prot, plus lots of other cleanups in the area that I
noticed.

I don't think vmalloc_prot is a good idea per se, as there only few
potential users, and I don't want too many vmalloc APIs.
