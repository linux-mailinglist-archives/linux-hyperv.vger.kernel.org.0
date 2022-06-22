Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767AE55462A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jun 2022 14:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356163AbiFVKyj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jun 2022 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356759AbiFVKyc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jun 2022 06:54:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647563BBC1;
        Wed, 22 Jun 2022 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h6Ni4JY3NSS01Nb6TQNOQZ0HSFRdoJBUQ6dpTFFJhdY=; b=JyZxBr61+7LNv2xOpLLWy09ECs
        vXy9cu8Ppj0Kz441rbC9FXoY/AYGrnLU8edkf3+09otEtbWkxjeQdtMWfeGTao48tTp/skcnsCPhv
        YE/YhvZycdAO7sdt3v1ZmKoDyW1MLxzIhQDMzh5PcHLQlKdrTetEBnHoTfeDyAdysxXKji2UTfiOE
        uniVcOW8H52tnK/dOCU740qNa3JpbRpT0tQkKke9pJ5vlscSN3X7P+IWYvKH1ZCutvs0LYIHWz4ve
        W3eEO9m8exFyOPu6rLAGqVCJrSLKJLGAGDrFdsdANidX80xJ8bgIYFLIje0mLfJ/uJDSyq4y0r+he
        hMuBFJ3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3y03-00A1BF-EA; Wed, 22 Jun 2022 10:54:19 +0000
Date:   Wed, 22 Jun 2022 03:54:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     corbet@lwn.net, hch@infradead.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, paulmck@kernel.org,
        akpm@linux-foundation.org, bp@suse.de, tglx@linutronix.de,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC PATCH V4 1/1] swiotlb: Split up single swiotlb lock
Message-ID: <YrL02y/fYxDkDRlA@infradead.org>
References: <20220617144741.921308-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617144741.921308-1-ltykernel@gmail.com>
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

Thanks,

this looks pretty good to me.  A few comments below:

On Fri, Jun 17, 2022 at 10:47:41AM -0400, Tianyu Lan wrote:
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

This can go into swiotlb.c.

> +void __init swiotlb_adjust_nareas(unsigned int nareas);

And this should be marked static.

> +#define DEFAULT_NUM_AREAS 1

I'd drop this define, the magic 1 and a > 1 comparism seems to
convey how it is used much better as the checks aren't about default
or not, but about larger than one.

I also think that we want some good way to size the default, e.g.
by number of CPUs or memory size.

> +void __init swiotlb_adjust_nareas(unsigned int nareas)
> +{
> +	if (!is_power_of_2(nareas)) {
> +		pr_err("swiotlb: Invalid areas parameter %d.\n", nareas);
> +		return;
> +	}
> +
> +	default_nareas = nareas;
> +
> +	pr_info("area num %d.\n", nareas);
> +	/* Round up number of slabs to the next power of 2.
> +	 * The last area is going be smaller than the rest if
> +	 * default_nslabs is not power of two.
> +	 */

Please follow the normal kernel comment style with a /* on its own line.

