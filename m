Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F94560221
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jun 2022 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiF2OJf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jun 2022 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiF2OJe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jun 2022 10:09:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C842CE04;
        Wed, 29 Jun 2022 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vIUxXrfRpQPd8e40gcqC8UVMd7+p4lDNzJaouIvbYRY=; b=PmT2nEDFXm3So1eVE1/jDd8HHf
        SBr1ovtXhZNGhEX3cO3TljW/uC3u7F2rVs/Q4lNzxuv3f2n6g63cbtVdF0FT4qPSnkzoYtlB4fTqg
        EzgiixJE9MccFEPbvyjXv1iPzdKnUgK50Uh2pYgItsyr1gRT7Ue5MgiX6FI8/PsxwMCofGp1Gv2xv
        lSGsyL4aeAa83SX+OfZRPpp0ETDDXkwXHMXa+p9rRAL+eB2mAF1kh4M20vJFDw0uJiUGtaetgqJdt
        CgxAToCea/ywbU4/orOn0Q84PEghm6gYSuqpJC1Hr51fgxajTItnSpV6Ky3dp12IMeAp3BJPkP/qK
        aBg/2ENA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6YNU-00CPbk-1y; Wed, 29 Jun 2022 14:09:12 +0000
Date:   Wed, 29 Jun 2022 07:09:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     corbet@lwn.net, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vkuznets@redhat.com, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] swiotlb: Split up single swiotlb lock
Message-ID: <YrxdCHRTRS62pAON@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-2-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627153150.106995-2-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 27, 2022 at 11:31:49AM -0400, Tianyu Lan wrote:
> +/**
> + * struct io_tlb_area - IO TLB memory area descriptor
> + *
> + * This is a single area with a single lock.
> + *
> + * @used:	The number of used IO TLB block.
> + * @index:	The slot index to start searching in this area for next round.
> + * @lock:	The lock to protect the above data structures in the map and
> + *		unmap calls.
> + */
> +struct io_tlb_area {
> +	unsigned long used;
> +	unsigned int index;
> +	spinlock_t lock;
> +};

As already mentioned last time, please move this into swiotlb.c,
swiotlb.h only uses a pointer to this structure.

>  static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> -		unsigned long nslabs, unsigned int flags, bool late_alloc)
> +				    unsigned long nslabs, unsigned int flags,
> +				    bool late_alloc, unsigned int nareas)

Nit: the two tab indentation for prototype continuations is a lot easier
to maintain, so don't graciously switch away from it.

> +			alloc_size - (offset + ((i - slot_index) << IO_TLB_SHIFT));

Overly long line here.

