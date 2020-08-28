Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49F255A8D
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgH1MuA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 08:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbgH1MsC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 08:48:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623062086A;
        Fri, 28 Aug 2020 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598618881;
        bh=Tmg6hNWVmQSJS0uP7afJ4MMWpAN7NReRjmWywe3CvWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1+w8OFAyaU/aWlYarVXfqLN9fIBCmKiNEB0Jq48rpTVBQjoDoRWSuL+fHLBf6YsVQ
         0jHKOc8fYAOkqjR2KhMCnoFrwVZYEYkuA5zRP2QSVxlGQweX4oXyTrY5Fp6mL5LaJq
         JXGC+7f0QfgyXvjiWKhAg1/Bko+ABpmHB9iTJxFE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kBdnT-007Pl5-Sa; Fri, 28 Aug 2020 13:48:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Aug 2020 13:47:59 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
In-Reply-To: <20200828121944.GQ1152540@nvidia.com>
References: <20200826112333.992429909@linutronix.de>
 <20200827182040.GA2049623@bjorn-Precision-5520>
 <20200828112142.GA14208@e121166-lin.cambridge.arm.com>
 <20200828121944.GQ1152540@nvidia.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <0cc8bfd9258dfc507585fd0f19a945e3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jgg@nvidia.com, lorenzo.pieralisi@arm.com, helgaas@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, haiyangz@microsoft.com, jonathan.derrick@intel.com, baolu.lu@linux.intel.com, wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com, steve.wahl@hpe.com, sivanich@hpe.com, rja@hpe.com, linux-pci@vger.kernel.org, bhelgaas@google.com, konrad.wilk@oracle.com, xen-devel@lists.xenproject.org, jgross@suse.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, megha.dey@intel.com, dave.jiang@intel.com, alex.williamson@redhat.com, jacob.jun.pan@intel.com, baolu.lu@intel.com, kevin.tian@intel.com, dan.j.williams@intel.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Jason,

On 2020-08-28 13:19, Jason Gunthorpe wrote:
> On Fri, Aug 28, 2020 at 12:21:42PM +0100, Lorenzo Pieralisi wrote:
>> On Thu, Aug 27, 2020 at 01:20:40PM -0500, Bjorn Helgaas wrote:
>> 
>> [...]
>> 
>> > And I can't figure out what's special about tegra, rcar, and xilinx
>> > that makes them need it as well.  Is there something I could grep for
>> > to identify them?  Is there a way to convert them so they don't need
>> > it?
>> 
>> I think DT binding and related firmware support are needed to setup 
>> the
>> MSI IRQ domains correctly, there is nothing special about tegra, rcar
>> and xilinx AFAIK (well, all native host controllers MSI handling is
>> *special* just to be polite but let's gloss over this for the time
>> being).
>> 
>> struct msi_controller, to answer the first question.
>> 
>> I have doubts about pci_mvebu too, they do allocate an msi_controller
>> but without methods so it looks pretty much useless.
> 
> Oh, I did once know things about mvebu..
> 
> I suspect the msi controller pointer assignment is dead code at this
> point. The only implementation of MSI with that PCI root port is
> drivers/irqchip/irq-armada-370-xp.c which looks like it uses
> irq_domain.
> 
> Actually looks like things are very close to eliminating
> msi_controller.
> 
> This is dead code, can't find a setter for hw_pci->msi_ctrl:
> 
> arch/arm/include/asm/mach/pci.h:        struct msi_controller 
> *msi_ctrl;
> arch/arm/kernel/bios32.c:                               bridge->msi =
> hw->msi_ctrl;
> 
> This is probably just copying NULL from one place to another:
> 
> drivers/pci/controller/pci-mvebu.c:     struct msi_controller *msi;
> 
> These need conversion to irq_domain (right?):
> 
> drivers/pci/controller/pci-hyperv.c:    struct msi_controller msi_chip;
> drivers/pci/controller/pci-tegra.c:     struct msi_controller chip;
> drivers/pci/controller/pcie-rcar-host.c:        struct msi_controller 
> chip;
> drivers/pci/controller/pcie-xilinx.c:static struct msi_controller
> xilinx_pcie_msi_chip = {
> 
> Then the stuff in drivers/pci/msi.c can go away.
> 
> So the arch_setup_msi_irq/etc is not really an arch hook, but some
> infrastructure to support those 4 PCI root port drivers.

I happen to have a *really old* patch addressing Tegra [1], which
I was never able to test (no HW). Rebasing it shouldn't be too hard,
and maybe you can find someone internally willing to give it a spin?

That'd be a good start towards the removal of this cruft.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/kill-msi-controller&id=83b3602fcee7972b9d549ed729b56ec28de16081
-- 
Jazz is not dead. It just smells funny...
