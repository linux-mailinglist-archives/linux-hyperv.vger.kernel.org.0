Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B94CC96F
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 23:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiCCWuV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Mar 2022 17:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiCCWuU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Mar 2022 17:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFEBF5413;
        Thu,  3 Mar 2022 14:49:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF3B7B826F4;
        Thu,  3 Mar 2022 22:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF27C004E1;
        Thu,  3 Mar 2022 22:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646347770;
        bh=8T7CokGxWBKJfPW1pG0VCMscny/1l39AXb6Fw4feFiI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mDE8XGmJRPXC3FhUExxfC/Tg8r8q5kqje46aVpKcSpgATjCrTOmm8dyL5+N0ARFUl
         igEkDLka8/5AR112e4UmftTK6LTw6MIVEq72/1WbVxD/BN6jvq1CQNSmYNX2eOZkoM
         C7Y6r4k/M1DH2K4tAUOZ5dfMEE8n9On9bbDAQYejM/m/pVednlfOiQ+0ILLxk+xuq6
         0Hivc3idTv5Og15E95hL8KOwRNZ6gfWfd8YTyoWKgbowpFGJ7UwyLwEnr/Ub/zQ8kx
         OW2VcyhCSn0JN1ypiUZLYah5Kofhllw9xygmCFN3oPTfqf6bSdXRFiDe95KnoglrOU
         yMQm9xneH86Yg==
Date:   Thu, 3 Mar 2022 14:49:29 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
In-Reply-To: <20220303105931.GA15137@lst.de>
Message-ID: <alpine.DEB.2.22.394.2203031447120.3261@ubuntu-linux-20-04-desktop>
References: <20220301105311.885699-1-hch@lst.de> <20220301105311.885699-12-hch@lst.de> <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop> <20220302081500.GB23075@lst.de> <alpine.DEB.2.22.394.2203021709470.3261@ubuntu-linux-20-04-desktop>
 <20220303105931.GA15137@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 3 Mar 2022, Christoph Hellwig wrote:
> On Wed, Mar 02, 2022 at 05:25:10PM -0800, Stefano Stabellini wrote:
> > Thinking more about it we actually need to drop the xen_initial_domain()
> > check otherwise some cases won't be functional (Dom0 not 1:1 mapped, or
> > DomU 1:1 mapped).
> 
> Hmm, but that would be the case even before this series, right?

Before this series we only have the xen_swiotlb_detect() check in
xen_mm_init, we don't have a second xen_initial_domain() check.

The issue is that this series is adding one more xen_initial_domain()
check in xen_mm_init.
