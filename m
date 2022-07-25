Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00845805B1
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Jul 2022 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiGYUdA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jul 2022 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiGYUc7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jul 2022 16:32:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E89FF9;
        Mon, 25 Jul 2022 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rnlk0yV/xEmk5mkTMfrgDo9BOtBzzp3QpC73Ryfd5ec=; b=HPKikqCAvKgEHwnqdDuqE567zW
        9I0eflJJVDQLqJeN5sDjyjkPPFkQz19UeuB0N1VBjR0+iM7TWuoNbBMuwtvK+4rIAs8NupJyTIxxZ
        xFm17DmL/eWtWkkzIrlBDo8pimGKcFMErN69WfLnSHhPVbHmmV6W/f1NoLejp/TXf0F3ktFPNSSY+
        DnKqAWFI0Cg5RIUWdTvgHcUV1pnKhoW+oflRtThps8RQ8pbse/6ZculnrKwfoGUYIlidU+WTwQ7qn
        rkvqlhSIhrPrnH9fSHMv2qSs+481EE7mQAEcFDLVTqNuueea5Vimm9Hdt/gofHbrmtUgFfttGS+ml
        82IvSeQg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oG4l6-0023Ol-PG; Mon, 25 Jul 2022 20:32:56 +0000
Message-ID: <af9a66b8-0ea3-5645-70bd-200cd804c5a8@infradead.org>
Date:   Mon, 25 Jul 2022 13:32:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Tree for Jul 25 (drivers/iommu/hyperv-iommu.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20220725211853.099d7016@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220725211853.099d7016@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 7/25/22 04:18, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220722:
> 

on x86_64:
when CONFIG_SMP is not set:

../drivers/iommu/hyperv-iommu.c: In function ‘hyperv_irq_remapping_alloc’:
../drivers/iommu/hyperv-iommu.c:94:43: error: ‘struct irq_common_data’ has no member named ‘affinity’
   94 |         cpumask_copy(desc->irq_common_data.affinity, &ioapic_max_cpumask);



-- 
~Randy
