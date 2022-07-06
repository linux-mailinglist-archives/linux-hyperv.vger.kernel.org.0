Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5715680B0
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiGFIBT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 04:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiGFIBS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 04:01:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C8F17E26;
        Wed,  6 Jul 2022 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HiFeALskotGpN1iZvBw/0D0ZUKVzZ82kmtWfVdYRxfo=; b=TBk29vbiT7YIhM59E+b8lJL1BC
        s9vDVB+cyngWjY1b9etW2yvGet4ZQgwoKvRt/ddj4PMRpNbW2LPTnRfGMNShRZjgyI5b9D5NTssWW
        Yu1wqoef9iBvueGmVwFeekNliQ2w0m5K8tkKJWr67ZpzzE7hx9kaZwy88tLY4tywyOoy3XQgBEI04
        TlVDVkPR5vGctLPt5wbI5wowzkBAdMCMrXaamBoHdesrny/Uz+BoTzZVMRtjZIFe8DXbPGUJRNERs
        wqDEy8+Iqv4G8BTU73KHJAd+ryiZ5SkzgGvmpUNnL9qjAb1Qi2rwfVvt/l9s5A+uHzkdMNY+rQwGy
        J16yPRvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8zxi-007FVc-S9; Wed, 06 Jul 2022 08:00:42 +0000
Date:   Wed, 6 Jul 2022 01:00:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, corbet@lwn.net,
        rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vkuznets@redhat.com, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        kirill.shutemov@intel.com, andi.kleen@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number
 of lapic entry in MADT
Message-ID: <YsVBKgxiQKfnCjvn@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
 <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 01, 2022 at 01:02:21AM +0800, Tianyu Lan wrote:
> > Can we reorder that initialization?  Because I really hate having
> > to have an arch hook in every architecture.
> 
> How about using "flags" parameter of swiotlb_init() to pass area number
> or add new parameter for area number?
> 
> I just reposted patch 1 since there is just some coding style issue and area
> number may also set via swiotlb kernel parameter. We still need figure out a
> good solution to pass area number from architecture code.

What is the problem with calling swiotlb_init after nr_possible_cpus()
works?
