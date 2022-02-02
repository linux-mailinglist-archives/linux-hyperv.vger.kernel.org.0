Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280414A6CBC
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Feb 2022 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiBBIMn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Feb 2022 03:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiBBIMm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Feb 2022 03:12:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C632C061714;
        Wed,  2 Feb 2022 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8GJ5K7tr5w0SjCFIVP9oFwV+EwJP4fhHZpV9DwIIpaE=; b=SaGPsaGm+57lnEX5wGtjbquwYs
        y8VdTUH21OF8ClB7mCR/yuaOGdMU+QSmNNGfgDNZK0aHXR2qD2kxSIwKdV/GtvONfnjYwAh9ZWHmN
        ZT2UVS034FkvfUNR/OO/aN79vJbTp4fdp7wjgCIFWiuh/5fjK3h2B24/wgGHjYf/0rne5OnZP81JP
        6CT/gjgpYnXS+wR4Rz1JLY54WPHi1DpoCsokzuS5a6YzmnkaJy9c892/Hbv1WDvBfLH2/4tMEWfBC
        FXd0ASzVCeEdjr4P1ojkJiRx6Mf+Qzu+Y0xhoY5dt8JOLPV8p+0cne7OHjfTUoRZt8U5g/D+dJB+P
        Azxf9qLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFAkT-00EX17-VS; Wed, 02 Feb 2022 08:12:17 +0000
Date:   Wed, 2 Feb 2022 00:12:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, hch@infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
Subject: Re: [PATCH 0/2] x86/hyperv/Swiotlb: Add swiotlb_alloc_from_low_pages
 switch
Message-ID: <Yfo84XYBsV7tA6Xd@infradead.org>
References: <20220126161053.297386-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126161053.297386-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I think this interface is a little too hacky.  In the end all the
non-trusted hypervisor schemes (including the per-device swiotlb one)
can allocate the memory from everywhere and want for force use of
swiotlb.  I think we need some kind of proper interface for that instead
of setting all kinds of global variables.
