Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56F05137B7
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbiD1PIf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348671AbiD1PIe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:08:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE52192A1;
        Thu, 28 Apr 2022 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DyT65p8JLEwgliFAAtKUa16bmBnVnf06R0IAvK3Qq+8=; b=cxd4QAK5yB3utYqNw3LEJ1Z64h
        7q/EJ9fWB0z1urAmfvR1lCEk96vihnZPspPUndgNgKA1F9vpWlArIHTIR8oMzHVhAwDY1bABEcEjY
        0jLay+38PVJ7uU0/6/FHo9I13nZEjXXqjjGik9BAxcigXOmKfnuf1So6FGpiM3S9Ssl0+9yRlSi/T
        ux/N4EApX9dSRm65GpfBU1EUnAmo38emdVnjdcvI8CKUl7A/cVT9/Ojpp0t8H5y7ec5j82GoQFHP3
        czvjO1kgb6cgysZ3Zr8rj65fGwsByl72HmzhPIMuw5hAQVGUcD1tynztPvdzTojer/FQJqmZKiKg+
        hZbd7iTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk5he-007aFM-B6; Thu, 28 Apr 2022 15:05:10 +0000
Date:   Thu, 28 Apr 2022 08:05:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tianyu Lan <ltykernel@gmail.com>, m.szyprowski@samsung.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com,
        wei.liu@kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
        iommu@lists.linux-foundation.org, andi.kleen@intel.com,
        brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Message-ID: <YmqtJr5lxDruT/9s@infradead.org>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
 <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 28, 2022 at 07:55:39AM -0700, Andi Kleen wrote:
> At least for TDX need parallelism with a single device for performance.

So find a way to make it happen without exposing details to random
drivers.
