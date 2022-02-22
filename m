Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C54BF320
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Feb 2022 09:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiBVIGN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Feb 2022 03:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBVIGM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Feb 2022 03:06:12 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D9148929;
        Tue, 22 Feb 2022 00:05:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B968768AA6; Tue, 22 Feb 2022 09:05:43 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:05:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, hch@infradead.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Message-ID: <20220222080543.GA5412@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com> <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de> <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com> <20220214135834.GA30150@lst.de> <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com> <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 21, 2022 at 11:14:58PM +0800, Tianyu Lan wrote:
> Sorry. The boot failure is not related with these patches and the issue
> has been fixed in the latest upstream code.
>
> There is a performance bottleneck due to io tlb mem's spin lock during
> performance test. All devices'io queues uses same io tlb mem entry
> and the spin lock of io tlb mem introduce overheads. There is a fix patch 
> from Andi Kleen in the github. Could you have a look?
>
> https://github.com/intel/tdx/commit/4529b5784c141782c72ec9bd9a92df2b68cb7d45

Please post these things to the list.

But I suspect the right answer for the "secure" hypervisor case is to
use the per-device swiotlb regions that we've recently added.
