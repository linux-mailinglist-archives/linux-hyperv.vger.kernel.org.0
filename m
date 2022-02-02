Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662E64A7173
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Feb 2022 14:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbiBBNXN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Feb 2022 08:23:13 -0500
Received: from foss.arm.com ([217.140.110.172]:59196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344309AbiBBNXM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Feb 2022 08:23:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49719ED1;
        Wed,  2 Feb 2022 05:23:12 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DE23F718;
        Wed,  2 Feb 2022 05:23:08 -0800 (PST)
Message-ID: <862bfda8-5c95-3743-3758-2e63faa7ac3e@arm.com>
Date:   Wed, 2 Feb 2022 13:22:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/2] x86/hyperv/Swiotlb: Add swiotlb_alloc_from_low_pages
 switch
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, m.szyprowski@samsung.com,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        parri.andrea@gmail.com, thomas.lendacky@amd.com
References: <20220126161053.297386-1-ltykernel@gmail.com>
 <Yfo84XYBsV7tA6Xd@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yfo84XYBsV7tA6Xd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-02-02 08:12, Christoph Hellwig wrote:
> I think this interface is a little too hacky.  In the end all the
> non-trusted hypervisor schemes (including the per-device swiotlb one)
> can allocate the memory from everywhere and want for force use of
> swiotlb.  I think we need some kind of proper interface for that instead
> of setting all kinds of global variables.

Right, if platform/hypervisor code knows enough to be able to set magic 
non-standard allocation flags correctly, surely it could equally just 
perform whatever non-standard allocation it needs and call 
swiotlb_init_with_tbl() instead of swiotlb_init().

Robin.
