Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004DE5601EC
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jun 2022 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiF2OFe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jun 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiF2OFd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jun 2022 10:05:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE73D2A251;
        Wed, 29 Jun 2022 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AdnOUixFaogrIHpTOlzBgm/evJyLH1AoH6sNGHs7rbw=; b=qmpdXaujtrOzhGFxHHFi13Bm1J
        gCSK8vuAHJjN+MEZ6dknO6RyA2A4rowbq52NOjL0ixWi6EHF5CcNomLJsrvDzy070xpeb+dLUwAuX
        anrkbObQPDTcRpTvJOHClFyrhy2O565MHOyNkUP5BioQ9ARaoqZQv9fKUFcHtkW5KBxDvGw01suxN
        WSl2EXInD8ayYEhgbP5c8hLQ6eIHaqkqkdary0J2Y5WrQW5kV1Ag7B27ckzI6ENiq18aRzSPvM8iJ
        ik4F+h1SzY475L2QXGEW+6hMSgDDsaIOdTEsHACLzHLCMY2M5X+9UKfDYKkRuMriM1IgWHbeQGbO3
        LZ96O5AA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6YJN-00CNma-5V; Wed, 29 Jun 2022 14:04:57 +0000
Date:   Wed, 29 Jun 2022 07:04:57 -0700
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
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number
 of lapic entry in MADT
Message-ID: <YrxcCZKvFYjxLf9n@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627153150.106995-3-ltykernel@gmail.com>
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

On Mon, Jun 27, 2022 at 11:31:50AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> When initialize swiotlb bounce buffer, smp_init() has not been
> called and cpu number can not be got from num_online_cpus().
> Use the number of lapic entry to set swiotlb area number and
> keep swiotlb area number equal to cpu number on the x86 platform.

Can we reorder that initialization?  Because I really hate having
to have an arch hook in every architecture.
