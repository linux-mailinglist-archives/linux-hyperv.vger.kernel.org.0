Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628B51FB491
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFPOjq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 10:39:46 -0400
Received: from verein.lst.de ([213.95.11.211]:38516 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFPOjp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 10:39:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 08C8368AEF; Tue, 16 Jun 2020 16:39:41 +0200 (CEST)
Date:   Tue, 16 Jun 2020 16:39:40 +0200
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
Message-ID: <20200616143940.GA15676@lst.de>
References: <20200616072318.GA17600@lst.de> <20200616101807.GO2531@hirez.programming.kicks-ass.net> <20200616102350.GA29684@lst.de> <20200616102412.GB29684@lst.de> <20200616103137.GQ2531@hirez.programming.kicks-ass.net> <20200616103313.GA30833@lst.de> <20200616104032.GR2531@hirez.programming.kicks-ass.net> <20200616104230.GA31314@lst.de> <20200616105200.GA32175@lst.de> <20200616112415.GT2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616112415.GT2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 01:24:15PM +0200, Peter Zijlstra wrote:
> > +void *module_alloc_prot(unsigned long size, pgprot_t prot)
> >  {
> > +	unsigned int flags = (pgprot_val(prot) & _PAGE_NX) ?
> > +			0 : VM_FLUSH_RESET_PERMS;
> >  	void *p;
> >  
> >  	if (PAGE_ALIGN(size) > MODULES_LEN)
> > @@ -75,7 +77,7 @@ void *module_alloc(unsigned long size)
> >  	p = __vmalloc_node_range(size, MODULE_ALIGN,
> >  				    MODULES_VADDR + get_module_load_offset(),
> >  				    MODULES_END, GFP_KERNEL,
> > -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > +				    prot, flags, NUMA_NO_NODE,
> >  				    __builtin_return_address(0));
> >  	if (p && (kasan_module_alloc(p, size) < 0)) {
> >  		vfree(p);
> 
> Hurmm.. Yes it would. It just doesn't feel right though. Can't we
> unconditionally set the flag? At worst it makes free a little bit more
> expensive.
> 
> The thing is, I don't think _NX is the only prot that needs restoring.
> Any prot other than the default (RW IIRC) needs restoring.

If that actually is the case I think we should just check for
a non-default permission in __vmalloc_node_range itself and handle it
there, which seems like a nice solution.
