Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758D459BE6A
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Aug 2022 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiHVL1O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiHVL1N (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 07:27:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09B32EE8;
        Mon, 22 Aug 2022 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=80Iob7m0eygDIBir23phYVn1p4Wv+1QMEBqUT1N4EkE=; b=w0XmYMb16FRlUUx5UI1bfzmXXs
        3Jftu942ei0pgarFAfjnelYfSJ1IYVx2GFd0g/XIbbbwSdYSfwVpxXxNmZZpXXf0lPRrMo860RMUe
        3XI5NdIwij0SFJuWWoFkMxB/0QS5RjtPkF546G7HiLYHm1E6ZGWlcr7PPoW2+QCq8bYfN4olg3h2u
        bw/1p2z4T/woptW0t9XxXDBhrPu8221SDDsGbUBRz0wveo2AEd+Oy0QCpYcUTj0gyGwdzJDTpx04/
        EZyi5wBHcNzpVitRKhIN+VcPL7cLqgTTEwyQjh59+1GhRK8BoF6C8AoTSusP8DZvl7FacTlY4scXh
        wJiVNl0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ5Zv-008DCF-58; Mon, 22 Aug 2022 11:26:47 +0000
Date:   Mon, 22 Aug 2022 04:26:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yu Zhao <yuzhao@google.com>, dongli.zhang@oracle.com,
        ak@linux.intel.com, akpm@linux-foundation.org,
        alexander.sverdlin@nokia.com, andi.kleen@intel.com, bp@alien8.de,
        bp@suse.de, cminyard@mvista.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, dave.hansen@linux.intel.com,
        hch@infradead.org, iommu@lists.linux-foundation.org,
        joe.jin@oracle.com, joe@perches.com, keescook@chromium.org,
        kirill.shutemov@intel.com, kys@microsoft.com,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        ltykernel@gmail.com, michael.h.kelley@microsoft.com,
        mingo@redhat.com, m.szyprowski@samsung.com, parri.andrea@gmail.com,
        paulmck@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        Tianyu.Lan@microsoft.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wei.liu@kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
Message-ID: <YwNn92WP3rP4ylZu@infradead.org>
References: <20220611082514.37112-5-dongli.zhang@oracle.com>
 <20220820012031.1285979-1-yuzhao@google.com>
 <f8c743d8-fcbe-4ef7-5f86-d63086552ffd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c743d8-fcbe-4ef7-5f86-d63086552ffd@arm.com>
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

On Mon, Aug 22, 2022 at 10:49:09AM +0100, Robin Murphy wrote:
> Hmm, it's possible this might be quietly fixed by 20347fca71a3, but either
> way I'm not sure why we would need to panic *before* we've even tried to
> allocate anything, when we could simply return with no harm done? If we've
> ended up calculating (or being told) a buffer size which is too small to be
> usable, that should be no different to disabling SWIOTLB entirely.

Hmm.  I think this might be a philosophical question, but I think
failing the boot with a clear error report for a configuration that is
supposed to work but can't is way better than just panicing later on.

> Historically, passing "swiotlb=1" on the command line has been used to save
> memory when the user knows SWIOTLB isn't needed. That should definitely not
> be allowed to start panicking.

I've never seen swiotlb=1 advertized as a way to disable swiotlb.
That's always been swiotlb=noforce, which cleanly disables it.
