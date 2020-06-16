Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0871FAF14
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPLYm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 07:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPLYl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 07:24:41 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AAC08C5C2;
        Tue, 16 Jun 2020 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dx/XDzmerQqHyMbNLBn+Q6s8VjrBl9v+6BnDFssdgrQ=; b=tUKMMmlm3EnU2lxXAKbz3w9Qbs
        59yhwU6FOtCCroQoFjW2uNXAffoPEwewaugQRiFECn4Go7fy5R9RyPsgm008fHygRH/vFPTiCnWM2
        g06WevqHZ5+lFlV6Uk3TyBPWkeEV1JJ5r8rh4L+K4f0d+jB2gk6+L0eKldWP0tx+Ql8B8kSerMRkT
        qRTVHZ4xX2bVgF8m4F1mJ3VJOWV1KTZZGi1FrazYSZx0V2UkQPDpGcC3lohSD3ltpDcx0VebstcP2
        Iz2Xx4sbeKvL0k2aimmLl0hEo112ZaNqWPH5w3lnpS+q+CUvxoFLPTQMpMGTnBrIspklKjAQx7j2S
        Y6fh647g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl9hS-0008PC-8L; Tue, 16 Jun 2020 11:24:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8721306089;
        Tue, 16 Jun 2020 13:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 993442BECAD2D; Tue, 16 Jun 2020 13:24:15 +0200 (CEST)
Date:   Tue, 16 Jun 2020 13:24:15 +0200
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
Message-ID: <20200616112415.GT2531@hirez.programming.kicks-ass.net>
References: <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <20200616072318.GA17600@lst.de>
 <20200616101807.GO2531@hirez.programming.kicks-ass.net>
 <20200616102350.GA29684@lst.de>
 <20200616102412.GB29684@lst.de>
 <20200616103137.GQ2531@hirez.programming.kicks-ass.net>
 <20200616103313.GA30833@lst.de>
 <20200616104032.GR2531@hirez.programming.kicks-ass.net>
 <20200616104230.GA31314@lst.de>
 <20200616105200.GA32175@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616105200.GA32175@lst.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:52:00PM +0200, Christoph Hellwig wrote:

> I think something like this should solve the issue:
> 
> --
> diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
> index e988bac0a4a1c3..716e4de44a8e78 100644
> --- a/arch/x86/include/asm/module.h
> +++ b/arch/x86/include/asm/module.h
> @@ -13,4 +13,6 @@ struct mod_arch_specific {
>  #endif
>  };
>  
> +void *module_alloc_prot(unsigned long size, pgprot_t prot);
> +
>  #endif /* _ASM_X86_MODULE_H */
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 34b153cbd4acb4..4db6e655120960 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -65,8 +65,10 @@ static unsigned long int get_module_load_offset(void)
>  }
>  #endif
>  
> -void *module_alloc(unsigned long size)
> +void *module_alloc_prot(unsigned long size, pgprot_t prot)
>  {
> +	unsigned int flags = (pgprot_val(prot) & _PAGE_NX) ?
> +			0 : VM_FLUSH_RESET_PERMS;
>  	void *p;
>  
>  	if (PAGE_ALIGN(size) > MODULES_LEN)
> @@ -75,7 +77,7 @@ void *module_alloc(unsigned long size)
>  	p = __vmalloc_node_range(size, MODULE_ALIGN,
>  				    MODULES_VADDR + get_module_load_offset(),
>  				    MODULES_END, GFP_KERNEL,
> -				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				    prot, flags, NUMA_NO_NODE,
>  				    __builtin_return_address(0));
>  	if (p && (kasan_module_alloc(p, size) < 0)) {
>  		vfree(p);

Hurmm.. Yes it would. It just doesn't feel right though. Can't we
unconditionally set the flag? At worst it makes free a little bit more
expensive.

The thing is, I don't think _NX is the only prot that needs restoring.
Any prot other than the default (RW IIRC) needs restoring.
