Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2758098A
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jul 2022 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGZCjc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jul 2022 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiGZCjb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jul 2022 22:39:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C8029833;
        Mon, 25 Jul 2022 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=BjeoFUfM5uWLnKpTPLeLk03xCXCAqBH4O+lDfmmC4Vw=; b=E3vItekmUsPIFk39AB1/s0y4vU
        ff7VQ01j/aPmw0/m7EGtHm8u47N8hsPA60jC2YhHK6hXHReJir/uQfzq7xwc8beKkw3k3ydnGGXPH
        J5q8A0fB5N3O/Yz4jn2dNaHzZe7lHSJfRA5vlsBYLmDVUcvfpPuvs3xd2T0S8Rv1QbewOzhzj0bPB
        A2UD4z7A3Ov4rqpMV7uetzyTs4yCXzinB9oL02e7O38BQOU7zsmdTjzzZxRF8dGU68ae8YYqCFNox
        x55nMieaaCY/aEPhltbFQjguV2PT8Z3aQSaxiNRwv3rINlHV7K9vV2bVcWQshjXMCi0oB7q+zZvyV
        blg1NIdw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGATh-006v7Z-Ub; Tue, 26 Jul 2022 02:39:22 +0000
Message-ID: <5ea65d3d-745e-0a16-c885-a224a20ee7ce@infradead.org>
Date:   Mon, 25 Jul 2022 19:39:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Content-Language: en-US
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        iommu@lists.linux.dev
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 7/25/22 17:53, Michael Kelley wrote:
> Recent changes to solve inconsistencies in handling IRQ masks #ifdef
> out the affinity field in irq_common_data for non-SMP configurations.
> The current code in hyperv_irq_remapping_alloc() gets a compiler error
> in that case.
> 
> Fix this by using the new irq_data_update_affinity() helper, which
> handles the non-SMP case correctly.
> 

Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/iommu/hyperv-iommu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 51bd66a..e190bb8 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -68,7 +68,6 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
>  {
>  	struct irq_alloc_info *info = arg;
>  	struct irq_data *irq_data;
> -	struct irq_desc *desc;
>  	int ret = 0;
>  
>  	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> @@ -90,8 +89,7 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
>  	 * Hypver-V IO APIC irq affinity should be in the scope of
>  	 * ioapic_max_cpumask because no irq remapping support.
>  	 */
> -	desc = irq_data_to_desc(irq_data);
> -	cpumask_copy(desc->irq_common_data.affinity, &ioapic_max_cpumask);
> +	irq_data_update_affinity(irq_data, &ioapic_max_cpumask);
>  
>  	return 0;
>  }

-- 
~Randy
