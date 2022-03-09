Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6A4D28E3
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Mar 2022 07:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiCIGTr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Mar 2022 01:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiCIGTo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Mar 2022 01:19:44 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BB51EC7C;
        Tue,  8 Mar 2022 22:18:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A4A1568AFE; Wed,  9 Mar 2022 07:18:40 +0100 (CET)
Date:   Wed, 9 Mar 2022 07:18:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
Message-ID: <20220309061840.GA31435@lst.de>
References: <20220301105311.885699-1-hch@lst.de> <20220301105311.885699-12-hch@lst.de> <6a22ea1e-4823-5c3b-97ee-a29155404a0d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a22ea1e-4823-5c3b-97ee-a29155404a0d@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 08, 2022 at 04:38:21PM -0500, Boris Ostrovsky wrote:
>
> On 3/1/22 5:53 AM, Christoph Hellwig wrote:
>> Allow to pass a remap argument to the swiotlb initialization functions
>> to handle the Xen/x86 remap case.  ARM/ARM64 never did any remapping
>> from xen_swiotlb_fixup, so we don't even need that quirk.
>
>
> Any chance this patch could be split? Lots of things are happening here and it's somewhat hard to review. (Patch 7 too BTW but I think I managed to get through it)

What would be your preferred split?

>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>> index e0def4b1c3181..2f2c468acb955 100644
>> --- a/arch/x86/kernel/pci-dma.c
>> +++ b/arch/x86/kernel/pci-dma.c
>> @@ -71,15 +71,12 @@ static inline void __init pci_swiotlb_detect(void)
>>   #endif /* CONFIG_SWIOTLB */
>>     #ifdef CONFIG_SWIOTLB_XEN
>> -static bool xen_swiotlb;
>> -
>>   static void __init pci_xen_swiotlb_init(void)
>>   {
>>   	if (!xen_initial_domain() && !x86_swiotlb_enable)
>>   		return;
>
>
> Now that there is a single call site for this routine I think this check can be dropped. We are only called here for xen_initial_domain()==true.

The callsite just checks xen_pv_domain() and itself is called
unconditionally during initialization.
