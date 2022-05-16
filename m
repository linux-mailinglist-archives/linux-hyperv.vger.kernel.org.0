Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9DE527EA2
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 May 2022 09:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiEPHe5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 May 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiEPHe4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 May 2022 03:34:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE123166;
        Mon, 16 May 2022 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w8WGy4XS5eXPvdu5YfW76lcCrip857Hkkv2txNUtWbk=; b=cWV3k/N+6vmcSCEINsuc1SyYS3
        BfmjTHk8hKu4jUjnIDxdZHymMOVX+efbSeMcixkrZjvghh6lLqsfQn2nWR+Nb8WWuwn+519/VmTMK
        IUG1/z574qcIEOO7Efev4KCTIkmUiAMfeni4g71Gb+bS9m+oZgKGYNOqZsAxdkTo3nkIiz32hxQUz
        87ixaZ+4IKzE1q16evyHuw0NSokd0xtA76pXi+/hQe2uZj/pz4UCSiG6xFUCDrznojMQ8kyn3Jpib
        M7EpBmbbtu9OrPW/54vHY2DMtxo4uOoWAd3NQIB3mJL32X3fKzFNA+Fhx206UUIo5/cR6deYR0QJE
        LVYGJI6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqVFh-006Ubt-57; Mon, 16 May 2022 07:34:49 +0000
Date:   Mon, 16 May 2022 00:34:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, linux-hyperv@vger.kernel.org,
        andi.kleen@intel.com, kirill.shutemov@intel.com
Subject: Re: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Message-ID: <YoH+mbxQAp/2XGyG@infradead.org>
References: <20220502125436.23607-1-ltykernel@gmail.com>
 <20220502125436.23607-2-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502125436.23607-2-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I don't really understand how 'childs' fit in here.  The code also
doesn't seem to be usable without patch 2 and a caller of the
new functions added in patch 2, so it is rather impossible to review.

Also:

 1) why is SEV/TDX so different from other cases that need bounce
    buffering to treat it different and we can't work on a general
    scalability improvement
 2) per previous discussions at how swiotlb itself works, it is
    clear that another option is to just make pages we DMA to
    shared with the hypervisor.  Why don't we try that at least
    for larger I/O?
