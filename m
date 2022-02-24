Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB224C31A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiBXQkS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 11:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBXQkR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 11:40:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9714028;
        Thu, 24 Feb 2022 08:39:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DAAC68AFE; Thu, 24 Feb 2022 17:39:43 +0100 (CET)
Date:   Thu, 24 Feb 2022 17:39:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: Re: cleanup swiotlb initialization
Message-ID: <20220224163943.GA32088@lst.de>
References: <20220222153514.593231-1-hch@lst.de> <09cb4ad3-88e7-3744-b4b8-a6d745ecea9e@oracle.com> <20220224155854.GA30938@lst.de> <206ba6a3-770a-70ad-96bc-76c6380da988@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206ba6a3-770a-70ad-96bc-76c6380da988@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 24, 2022 at 11:18:33AM -0500, Boris Ostrovsky wrote:
>
> On 2/24/22 10:58 AM, Christoph Hellwig wrote:
>> Thanks.
>>
>> This looks really strange as early_amd_iommu_init should not interact much
>> with the changes.  I'll see if I can find a AMD system to test on.
>
>
> Just to be clear: this crashes only as dom0. Boots fine as baremetal.

Ah.  I can gues what this might be.  On Xen the hypervisor controls the
IOMMU and we should never end up initializing it in Linux, right?
