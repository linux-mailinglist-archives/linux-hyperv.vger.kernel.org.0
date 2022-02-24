Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33F4C297E
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiBXK3f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 05:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiBXK3e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 05:29:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F8BC1DFDFD;
        Thu, 24 Feb 2022 02:29:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDCB91509;
        Thu, 24 Feb 2022 02:29:04 -0800 (PST)
Received: from [10.163.48.178] (unknown [10.163.48.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F68A3F70D;
        Thu, 24 Feb 2022 02:28:58 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 02/11] swiotlb: make swiotlb_exit a no-op if SWIOTLB_FORCE
 is set
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     x86@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
References: <20220222153514.593231-1-hch@lst.de>
 <20220222153514.593231-3-hch@lst.de>
Message-ID: <b769ddc8-5ba3-b7a9-b295-92507a73c0d6@arm.com>
Date:   Thu, 24 Feb 2022 15:59:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220222153514.593231-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 2/22/22 9:05 PM, Christoph Hellwig wrote:
> If force bouncing is enabled we can't release the bufffers.

typo							^^^^

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/swiotlb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f1e7ea160b433..36fbf1181d285 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -378,6 +378,9 @@ void __init swiotlb_exit(void)
>  	unsigned long tbl_vaddr;
>  	size_t tbl_size, slots_size;
>  
> +	if (swiotlb_force == SWIOTLB_FORCE)
> +		return;
> +
>  	if (!mem->nslabs)
>  		return;
>  
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
