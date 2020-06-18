Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502841FEFB8
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 12:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFRKf3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 06:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgFRKf0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 06:35:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF205C06174E;
        Thu, 18 Jun 2020 03:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tliSKQbk7IKkXD+3sv6W4IKOfskIhBhUzC3bD3Cn3Ec=; b=DdyAOrKFtQPhPLgqdSUGoR/Pkw
        ETlLNIB3zwt3JUNas1N7hfkVOvAJg/+cvvcb7SvRYknq8Joove3g5DnH71qIUxZxP9EMUbsl5dWLC
        zM8r0ceGwzdqHzE/ZwK7uhJpHEMtzt9maVhQr0ZG+jyTDPNqy3NzR85KqeP9psQKHWE7H3MpGKjzG
        c6YNp6EtrIFK5c++jcfE8zJzmhEiH1XPjKAnPn8DknJi+BebmFwY5JubyGMmJkkOnrxEUmGRZfxMm
        lfzK49VAnUaxJzqLimyEivJmt/MtqbBl719cwHo0UEHeF6kKbXhcGkWONwWXaV83lNP1BFM+cKNme
        e/j7Fz5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlrsy-00027C-M3; Thu, 18 Jun 2020 10:35:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47CD230018A;
        Thu, 18 Jun 2020 12:35:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 338BD20C227A0; Thu, 18 Jun 2020 12:35:06 +0200 (CEST)
Date:   Thu, 18 Jun 2020 12:35:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20200618103506.GH576905@hirez.programming.kicks-ass.net>
References: <20200618064307.32739-1-hch@lst.de>
 <20200618064307.32739-3-hch@lst.de>
 <90234f58-e83a-7f20-62a7-80a4e81cde95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90234f58-e83a-7f20-62a7-80a4e81cde95@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 18, 2020 at 10:55:58AM +0200, David Hildenbrand wrote:
> On 18.06.20 08:43, Christoph Hellwig wrote:
> > Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
> > page read-only just after the allocation.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm64/kernel/probes/kprobes.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index d1c95dcf1d7833..cbe49cd117cfec 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >  
> >  void *alloc_insn_page(void)
> >  {
> > -	void *page;
> > -
> > -	page = vmalloc_exec(PAGE_SIZE);
> > -	if (page) {
> > -		set_memory_ro((unsigned long)page, 1);
> > -		set_vm_flush_reset_perms(page);
> > -	}
> > -
> > -	return page;
> > +	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > +			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > +			NUMA_NO_NODE, __func__);
> 
> I do wonder if something like vmalloc_prot(size, prot) would make this
> (and the other two users) easier to read.
> 
> So instead of ripping out vmalloc_exec(), converting it into
> vmalloc_prot() instead.
> 
> Did you consider that?

For x86 Christoph did module_alloc_prot(), which is in his more
extensive set of patches addressing this. I suspect that would be the
right thing for ARM64 as well.

