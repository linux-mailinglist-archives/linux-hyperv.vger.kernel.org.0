Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3925607D
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgH1SaB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgH1SaA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 14:30:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764DC061264;
        Fri, 28 Aug 2020 11:29:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598639398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQQ3PgkKo2hS5HQKNaJ3P1IptF/ClXfBwAd1n3Worn0=;
        b=aCTaFZU+e8x0x58wJ1oeYUMPHmUAbdjR6qrLnzUL2j3Joo6UWr9US/cCwRlh/cn/Dvl3Ea
        AvjuuOBWjpzVXAXBQyGeg3gInDAiqfY9sH0WgQWHi3NyPKyTXpj7zFsze/QeG7xMPEXKCT
        iIrXwbhXKciDtYdzmRP42PwSOTAibh/Ci9iyIDxL9JGAZZDFCWmomrS+tkBweJNjmV2kjb
        BbgDTKvuYwHkEpQDeFwqMNmNeXfaqNVEON0+suObP1Oa+wJK8Ot+NeM4+0tLDCDC/otdSb
        sRbMsWVyem66C8lTMSZznkBMUmQrRkEU4Yxl7AH+oxxHZ72nlgzHwSoX1gI+cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598639398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQQ3PgkKo2hS5HQKNaJ3P1IptF/ClXfBwAd1n3Worn0=;
        b=vXG0XUsJMIi3DkkPAd4hFW5NyIUjTPD3/KRNdL6hTZ3E1uRKkBApmbjwrrLTXyfG5+s5Mw
        6hQo8a2K/hj9JbDA==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
In-Reply-To: <20200827182040.GA2049623@bjorn-Precision-5520>
References: <20200827182040.GA2049623@bjorn-Precision-5520>
Date:   Fri, 28 Aug 2020 20:29:57 +0200
Message-ID: <873646lj2y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 27 2020 at 13:20, Bjorn Helgaas wrote:
> On Wed, Aug 26, 2020 at 01:17:02PM +0200, Thomas Gleixner wrote:
>> Make the architectures and drivers which rely on them select them in Kconfig
>> and if not selected replace them by stub functions which emit a warning and
>> fail the PCI/MSI interrupt allocation.
>
> Sorry, I really don't understand this, so these are probably stupid
> questions.
>
> If CONFIG_PCI_MSI_ARCH_FALLBACKS is defined, we will supply
> implementations of:
>
>   arch_setup_msi_irq
>   arch_teardown_msi_irq
>   arch_setup_msi_irqs
>   arch_teardown_msi_irqs
>   default_teardown_msi_irqs    # non-weak
>
> You select CONFIG_PCI_MSI_ARCH_FALLBACKS for ia64, mips, powerpc,
> s390, sparc, and x86.  I see that all of those arches implement at
> least one of the functions above.  But x86 doesn't and I can't figure
> out why it needs to select CONFIG_PCI_MSI_ARCH_FALLBACKS.

X86 still has them at that point in the series and the next patch
removes them. I wanted to have the warnings in place before doing so.

> I assume there's a way to convert these arches to hierarchical irq
> domains so they wouldn't need this at all?  Is there a sample
> conversion to look at?

For a quick and dirty step it's pretty much the wrapper I used for XEN
and then make sure that the msi_domain pointer is populated is
pci_device::device.

> And I can't figure out what's special about tegra, rcar, and xilinx
> that makes them need it as well.

Those are old drivers from the time where ARM did not use hierarchical
irq domains and nobody cared to fix them up.

> Is there something I could grep for
> to identify them?

git grep arch_setup_msi_irq
git grep arch_teardown_msi_irq

> Is there a way to convert them so they don't need it?

Sure, it just needs some work and probably hardware to test.

Thanks,

        tglx
