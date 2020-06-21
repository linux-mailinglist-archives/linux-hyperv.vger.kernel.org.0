Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5A2027EE
	for <lists+linux-hyperv@lfdr.de>; Sun, 21 Jun 2020 04:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgFUCQV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 Jun 2020 22:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgFUCQU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 Jun 2020 22:16:20 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E65E32186A;
        Sun, 21 Jun 2020 02:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592705779;
        bh=AmHDVslR6mKNgf2o33y0VkLCChUaTWfNm0pSDs+MYak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ocFQKCnNtHEou6r7kB9zbA1+GZl5pJ4akGjW/+mAhePiZUT4eat4WTQgjo6xEFQw8
         oW4eF04QeOHGI/AAxBdrzYJaqC1voLTCWjnrlSBHiE5f51Opg1XYlOn4CFPWKADuka
         s/ZJhpHXuIStXjWYhDQasn2LaNblO273QcPnHiAs=
Date:   Sat, 20 Jun 2020 19:16:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in
 alloc_insn_page
Message-Id: <20200620191616.bae356186ba3329ade67bbf7@linux-foundation.org>
In-Reply-To: <20200618064307.32739-3-hch@lst.de>
References: <20200618064307.32739-1-hch@lst.de>
        <20200618064307.32739-3-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 18 Jun 2020 08:43:06 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
> page read-only just after the allocation.
> 
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  
>  void *alloc_insn_page(void)
>  {
> -	void *page;
> -
> -	page = vmalloc_exec(PAGE_SIZE);
> -	if (page) {
> -		set_memory_ro((unsigned long)page, 1);
> -		set_vm_flush_reset_perms(page);
> -	}
> -
> -	return page;
> +	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> +			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> +			NUMA_NO_NODE, __func__);
>  }
>  
>  /* arm kprobe: install breakpoint in text */

But why.  I think this is just a cleanup, doesn't address any runtime issue?
