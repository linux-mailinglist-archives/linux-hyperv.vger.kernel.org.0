Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F94C8B23
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 12:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiCALy1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 06:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiCALy0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 06:54:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51908AE74;
        Tue,  1 Mar 2022 03:53:45 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD48368AFE; Tue,  1 Mar 2022 12:53:40 +0100 (CET)
Date:   Tue, 1 Mar 2022 12:53:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com,
        parri.andrea@gmail.com, thomas.lendacky@amd.com,
        "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Message-ID: <20220301115340.GA3077@lst.de>
References: <20220214081919.GA18337@lst.de> <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com> <20220214135834.GA30150@lst.de> <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com> <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com> <20220222080543.GA5412@lst.de> <00112505-4999-ac41-877e-49c4cc45312e@gmail.com> <20220222160039.GA13380@lst.de> <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com> <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 25, 2022 at 10:28:54PM +0800, Tianyu Lan wrote:
>      One more perspective is that one device may have multiple queues and 
> each queues should have independent swiotlb bounce buffer to avoid spin 
> lock overhead. The number of queues is only available in the device
> driver. This means new API needs to be called in the device driver 
> according to queue number.

Well, given how hell bent people are on bounce buffering we might
need some scalability work there anyway.
