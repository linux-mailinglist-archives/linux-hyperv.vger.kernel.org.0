Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C86255944
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgH1LXi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 07:23:38 -0400
Received: from foss.arm.com ([217.140.110.172]:46836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbgH1LWs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 07:22:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10BC931B;
        Fri, 28 Aug 2020 04:21:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03F763F66B;
        Fri, 28 Aug 2020 04:21:47 -0700 (PDT)
Date:   Fri, 28 Aug 2020 12:21:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <20200828112142.GA14208@e121166-lin.cambridge.arm.com>
References: <20200826112333.992429909@linutronix.de>
 <20200827182040.GA2049623@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827182040.GA2049623@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 27, 2020 at 01:20:40PM -0500, Bjorn Helgaas wrote:

[...]

> And I can't figure out what's special about tegra, rcar, and xilinx
> that makes them need it as well.  Is there something I could grep for
> to identify them?  Is there a way to convert them so they don't need
> it?

I think DT binding and related firmware support are needed to setup the
MSI IRQ domains correctly, there is nothing special about tegra, rcar
and xilinx AFAIK (well, all native host controllers MSI handling is
*special* just to be polite but let's gloss over this for the time
being).

struct msi_controller, to answer the first question.

I have doubts about pci_mvebu too, they do allocate an msi_controller
but without methods so it looks pretty much useless.

Hyper-V code too seems questionable, maybe there is room for more
clean-ups.

Lorenzo

> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *d
> >  void pci_msi_unmask_irq(struct irq_data *data);
> >  
> >  /*
> > - * The arch hooks to setup up msi irqs. Those functions are
> > - * implemented as weak symbols so that they /can/ be overriden by
> > - * architecture specific code if needed.
> > + * The arch hooks to setup up msi irqs. Default functions are implemented
> 
> s/msi/MSI/ to match the one below.
> 
> > + * as weak symbols so that they /can/ be overriden by architecture specific
> > + * code if needed. These hooks must be enabled by the architecture or by
> > + * drivers which depend on them via msi_controller based MSI handling.
