Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD56F4D90AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Mar 2022 01:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbiCOABU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Mar 2022 20:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244433AbiCOABS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Mar 2022 20:01:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0F23BE4;
        Mon, 14 Mar 2022 17:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67599CE17D7;
        Tue, 15 Mar 2022 00:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82170C340E9;
        Tue, 15 Mar 2022 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647302404;
        bh=qF2Kiv1yBWM6zFZu7vu4vkmgVsDPPK9bUwo+CMzG77s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CxQznLVvPAMHVLObot/GbKAGNBs3wp/Zo7J//e5fa5RGl/JAcrYpHk7dFYXJ+dCyc
         yFp/t/ucQtYgdUQQRIyugjt0bw6neR65fWz4Mw2wQpqjjnNDOhxJr7SqJvB+dScWOI
         FWaPNn7YRGzQ0CCDI4WX3HGCjk3WcedTK4ZKrUhQL/ZjI62kK/fSKVT6fnNg8LwsV7
         O+N86nVOy9ALX/s25HJpQGYpv30ak+B6D/CFn8xWL4gwGSW9Q/HStnRPdXpxBq2xEr
         XfmlQm0hAt72Py8IAnH8MpwztAqekJ4fXRmnodDkCqvESbpDzlwteZaCwLl1CvtOpX
         4SrZDmHAzylBg==
Date:   Mon, 14 Mar 2022 17:00:02 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Christoph Hellwig <hch@lst.de>
cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: Re: [PATCH 13/15] swiotlb: merge swiotlb-xen initialization into
 swiotlb
In-Reply-To: <20220314073129.1862284-14-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2203141659210.3497@ubuntu-linux-20-04-desktop>
References: <20220314073129.1862284-1-hch@lst.de> <20220314073129.1862284-14-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 14 Mar 2022, Christoph Hellwig wrote:
> Reuse the generic swiotlb initialization for xen-swiotlb.  For ARM/ARM64
> this works trivially, while for x86 xen_swiotlb_fixup needs to be passed
> as the remap argument to swiotlb_init_remap/swiotlb_init_late.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For arch/arm/xen and drivers/xen/swiotlb-xen.c

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
