Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D0F4CA149
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiCBJvR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 04:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbiCBJvO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 04:51:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67ED8BA75B;
        Wed,  2 Mar 2022 01:50:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E4B1042;
        Wed,  2 Mar 2022 01:50:31 -0800 (PST)
Received: from lpieralisi (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732AB3F66F;
        Wed,  2 Mar 2022 01:50:28 -0800 (PST)
Date:   Wed, 2 Mar 2022 09:50:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] PCI: hv: Avoid the retarget interrupt hypercall
 in irq_unmask() on ARM64
Message-ID: <Yh893bdBf7P2z+nY@lpieralisi>
References: <20220217034525.1687678-1-boqun.feng@gmail.com>
 <MWHPR21MB1593A265118977A57FF3B329D7369@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220221175600.gxbphsnbytgytcpz@liuwe-devbox-debian-v2>
 <Yh7gwaAcfVvQzoND@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh7gwaAcfVvQzoND@boqun-archlinux>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 11:13:05AM +0800, Boqun Feng wrote:
> On Mon, Feb 21, 2022 at 05:56:00PM +0000, Wei Liu wrote:
> > On Thu, Feb 17, 2022 at 04:31:06PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 16, 2022 7:45 PM
> > > > 
> > > > On ARM64 Hyper-V guests, SPIs are used for the interrupts of virtual PCI
> > > > devices, and SPIs can be managed directly via GICD registers. Therefore
> > > > the retarget interrupt hypercall is not needed on ARM64.
> > > > 
> > > > An arch-specific interface hv_arch_irq_unmask() is introduced to handle
> > > > the architecture level differences on this. For x86, the behavior
> > > > remains unchanged, while for ARM64 no hypercall is invoked when
> > > > unmasking an irq for virtual PCI devices.
> > > > 
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > ---
> > > > v1 -> v2:
> > > > 
> > > > *	Introduce arch-specific interface hv_arch_irq_unmask() as
> > > > 	suggested by Bjorn
> > > > 
> > > >  drivers/pci/controller/pci-hyperv.c | 233 +++++++++++++++-------------
> > > >  1 file changed, 122 insertions(+), 111 deletions(-)
> > > 
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > 
> > I expect this to go through the PCI tree. Let me know if I should pick
> > this up.
> > 
> 
> I also expect the same.
> 
> Lorenzo, let me know if there is more work needed for this patch.
> Thanks!

It is tagged as an RFC that's why I have not considered it for v5.18,
I will have a look shortly.

Thanks,
Lorenzo
