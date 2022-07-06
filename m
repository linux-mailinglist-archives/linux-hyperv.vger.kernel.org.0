Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0255682D7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jul 2022 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiGFJDd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiGFJD3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 05:03:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B66323;
        Wed,  6 Jul 2022 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MQARnlMToRVEqeLEMG+9wozanL3J51GC/4ROL/yqQsA=; b=tz7RGCpugBXvVFqz6jl03wLVUe
        OomVJj7+GmEelW2X4/5m9U1uYUtNL4A7HoDzyvoZZw9LUwgoC+hmtVGU0FXZEuqkn0obaHtMeKwcu
        M9unWnQmfP02x9t+LJukCtXvxQ1XRcHdQaBaU+a9NC4I3YvGujXJR/NiIfJHu1MuItdCfuhUf88xo
        lAsVQzRv7DRGqszQ6R5CqSkPoDI+uj3qnuDsmUWOD+4hYuMZ9Y9k4SE3ARyz/BR/PZs7geQ3pe5HY
        UEt/C04JWGAUB/rKxaguwIb1tbE/Te0IMAFutJM8/MlDt+TNuTYBS9gs7JGMnbWr6zfFaclgfQv4P
        YgEsPKeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o90vx-007ayM-Oy; Wed, 06 Jul 2022 09:02:57 +0000
Date:   Wed, 6 Jul 2022 02:02:57 -0700
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
Message-ID: <YsVPwYGHUoctAKjs@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
 <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
 <YsVBKgxiQKfnCjvn@infradead.org>
 <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
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

On Wed, Jul 06, 2022 at 04:57:33PM +0800, Tianyu Lan wrote:
> Swiotlb_init() is called in the mem_init() of different architects and
> memblock free pages are released to the buddy allocator just after
> calling swiotlb_init() via memblock_free_all().

Yes.

> The mem_init() is called before smp_init().

But why would that matter?  cpu_possible_map is set up from
setup_arch(), which is called before that.
