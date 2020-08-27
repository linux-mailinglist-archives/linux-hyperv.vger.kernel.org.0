Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBCD254CEC
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Aug 2020 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgH0SUm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 14:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgH0SUm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 14:20:42 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A730E2087E;
        Thu, 27 Aug 2020 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598552442;
        bh=m7vhbAFnI7P7AwdKlzAn0wqD1YPTHJSRQ+ZyXNR7MXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UkvStWoB1OiC87isw5L+RU0aRZ6Byn64sN6W7fqyqnYslW1VbyUto3Ot7HnJdzmV/
         BpHMqJ6kR2FuX03H7NAUtZrH7Q62VQWR+Hm7VJz4TNIG5szeBamrDedrrHkWMj3Ds6
         qwX6HCvJ0Dk2KiupyPg7/GXt0z0MFg9xlpzjsATc=
Date:   Thu, 27 Aug 2020 13:20:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <20200827182040.GA2049623@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826112333.992429909@linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[+cc Rob,
cover https://lore.kernel.org/r/20200826111628.794979401@linutronix.de/
this  https://lore.kernel.org/r/20200826112333.992429909@linutronix.de/]

On Wed, Aug 26, 2020 at 01:17:02PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The arch_.*_msi_irq[s] fallbacks are compiled in whether an architecture
> requires them or not. Architectures which are fully utilizing hierarchical
> irq domains should never call into that code.
> 
> It's not only architectures which depend on that by implementing one or
> more of the weak functions, there is also a bunch of drivers which relies
> on the weak functions which invoke msi_controller::setup_irq[s] and
> msi_controller::teardown_irq.
> 
> Make the architectures and drivers which rely on them select them in Kconfig
> and if not selected replace them by stub functions which emit a warning and
> fail the PCI/MSI interrupt allocation.

Sorry, I really don't understand this, so these are probably stupid
questions.

If CONFIG_PCI_MSI_ARCH_FALLBACKS is defined, we will supply
implementations of:

  arch_setup_msi_irq
  arch_teardown_msi_irq
  arch_setup_msi_irqs
  arch_teardown_msi_irqs
  default_teardown_msi_irqs    # non-weak

You select CONFIG_PCI_MSI_ARCH_FALLBACKS for ia64, mips, powerpc,
s390, sparc, and x86.  I see that all of those arches implement at
least one of the functions above.  But x86 doesn't and I can't figure
out why it needs to select CONFIG_PCI_MSI_ARCH_FALLBACKS.

I assume there's a way to convert these arches to hierarchical irq
domains so they wouldn't need this at all?  Is there a sample
conversion to look at?

And I can't figure out what's special about tegra, rcar, and xilinx
that makes them need it as well.  Is there something I could grep for
to identify them?  Is there a way to convert them so they don't need
it?

> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *d
>  void pci_msi_unmask_irq(struct irq_data *data);
>  
>  /*
> - * The arch hooks to setup up msi irqs. Those functions are
> - * implemented as weak symbols so that they /can/ be overriden by
> - * architecture specific code if needed.
> + * The arch hooks to setup up msi irqs. Default functions are implemented

s/msi/MSI/ to match the one below.

> + * as weak symbols so that they /can/ be overriden by architecture specific
> + * code if needed. These hooks must be enabled by the architecture or by
> + * drivers which depend on them via msi_controller based MSI handling.
