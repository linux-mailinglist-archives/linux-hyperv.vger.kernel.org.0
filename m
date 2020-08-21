Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52F024C9EF
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUCQk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Aug 2020 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHUCQk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Aug 2020 22:16:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0BC061385;
        Thu, 20 Aug 2020 19:16:40 -0700 (PDT)
Message-Id: <20200821002424.119492231@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=6NqCao/16SSVwxU3sscyKk1x2qrVHv19Kl/+7RncOTA=;
        b=ypwGQhEtLxJihh7WUOQQEaAMlphwrov24vksOjnplfhLD07eIrUGaOcUsnEzRKsQfyOv/i
        7w3zMDmRM2AoILgUnodia+JhCGDeEecxjS6Pu5B9VOARPg36DZQvZeo3cHLxUaeivTe+oA
        b91J3yONxQwvP86lUhhb4bjxDEGxzXuyNYzWewdtECWVYDomQWqDCXKmI2M3HSXB6Prxt7
        nLYJK526HDM/9meX7y2CpT4QepzWxd6Yg+SAMiq1YT8ZAHqO22TcuSmwUR8pFh1G1hA4Sr
        0Uyr/DE44KKYwFVw7JO1Gl05Kv5vlC356zn0ns8or6odT6MWASx99abAUFd1zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=6NqCao/16SSVwxU3sscyKk1x2qrVHv19Kl/+7RncOTA=;
        b=ModaSDKC/7KPKpfoJXwOupDLtqnQezio5NWZrrxDV9Wdr6vs4o0nJj6hFBppTFsrFMtbmR
        0BGx93AAb/NWdaDg==
Date:   Fri, 21 Aug 2020 02:24:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
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
        Jonathan Derrick <jonathan.derrick@intel.com>,
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
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch RFC 00/38] x86, PCI, XEN, genirq ...: Prepare for device MSI
Content-transfer-encoding: 8-bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

First of all, sorry for the horrible long Cc list, which was
unfortunately unavoidable as this touches the world and some more.

This patch series aims to provide a base to support device MSI (non
PCI based) in a halfways architecture independent way.

It's a mixed bag of bug fixes, cleanups and general improvements which
are worthwhile independent of the device MSI stuff. Unfortunately this
also comes with an evil abuse of the irqdomain system to coerce XEN on
x86 into compliance without rewriting XEN from scratch.

As discussed in length in this mail thread:

  https://lore.kernel.org/r/87h7tcgbs2.fsf@nanos.tec.linutronix.de

the initial attempt of piggypacking device MSI support on platform MSI
is doomed for various reasons, but creating independent interrupt
domains for these upcoming magic PCI subdevices which are not PCI, but
might be exposed as PCI devices is not as trivial as it seems.

The initially suggested and evaluated approach of extending platform
MSI turned out to be the completely wrong direction and in fact
platform MSI should be rewritten on top of device MSI or completely
replaced by it.

One of the main issues is that x86 does not support the concept of irq
domains associations stored in device::msi_domain and still relies on
the arch_*_msi_irqs() fallback implementations which has it's own set
of problems as outlined in

  https://lore.kernel.org/r/87bljg7u4f.fsf@nanos.tec.linutronix.de/

in the very same thread.

The main obstacle of storing that pointer is XEN which has it's own
historical notiion of handling PCI MSI interupts.

This series tries to address these issues in several steps:

 1) Accidental bug fixes
	iommu/amd: Prevent NULL pointer dereference

 2) Janitoring
	x86/init: Remove unused init ops

 3) Simplification of the x86 specific interrupt allocation mechanism

	x86/irq: Rename X86_IRQ_ALLOC_TYPE_MSI* to reflect PCI dependency
	x86/irq: Add allocation type for parent domain retrieval
	iommu/vt-d: Consolidate irq domain getter
	iommu/amd: Consolidate irq domain getter
	iommu/irq_remapping: Consolidate irq domain lookup

 4) Consolidation of the X86 specific interrupt allocation mechanism to be as close
    as possible to the generic MSI allocation mechanism which allows to get rid
    of quite a bunch of x86'isms which are pointless

	x86/irq: Prepare consolidation of irq_alloc_info
	x86/msi: Consolidate HPET allocation
	x86/ioapic: Consolidate IOAPIC allocation
	x86/irq: Consolidate DMAR irq allocation
	x86/irq: Consolidate UV domain allocation
	PCI: MSI: Rework pci_msi_domain_calc_hwirq()
	x86/msi: Consolidate MSI allocation
	x86/msi: Use generic MSI domain ops

  5) x86 specific cleanups to remove the dependency on arch_*_msi_irqs()

	x86/irq: Move apic_post_init() invocation to one place
	z86/pci: Reducde #ifdeffery in PCI init code
	x86/irq: Initialize PCI/MSI domain at PCI init time
	irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
	PCI: vmd: Mark VMD irqdomain with DOMAIN_BUS_VMD_MSI
	PCI: MSI: Provide pci_dev_has_special_msi_domain() helper
	x86/xen: Make xen_msi_init() static and rename it to xen_hvm_msi_init()
	x86/xen: Rework MSI teardown
	x86/xen: Consolidate XEN-MSI init
	irqdomain/msi: Allow to override msi_domain_alloc/free_irqs()
	x86/xen: Wrap XEN MSI management into irqdomain
	iommm/vt-d: Store irq domain in struct device
	iommm/amd: Store irq domain in struct device
	x86/pci: Set default irq domain in pcibios_add_device()
	PCI/MSI: Allow to disable arch fallbacks
	x86/irq: Cleanup the arch_*_msi_irqs() leftovers
	x86/irq: Make most MSI ops XEN private

    This one is paving the way to device MSI support, but it comes
    with an ugly and evil hack. The ability of overriding the default
    allocation/free functions of an MSI irq domain is useful in general as
    (hopefully) demonstrated with the device MSI POC, but the abuse
    in context of XEN is evil. OTOH without enough XENology and without
    rewriting XEN from scratch wrapping XEN MSI handling into a pseudo
    irq domain is a reasonable step forward for mere mortals with severly
    limited XENology. One day the XEN folks might make it a real irq domain.
    Perhaps when they have to support the same mess on other architectures.
    Hope dies last...

    At least the mechanism to override alloc/free turned out to be useful
    for implementing the base infrastructure for device MSI. So it's not a
    completely lost case.

  6) X86 specific preparation for device MSI

       x86/irq: Add DEV_MSI allocation type
       x86/msi: Let pci_msi_prepare() handle non-PCI MSI

  7) Generic device MSI infrastructure

       platform-msi: Provide default irq_chip:ack
       platform-msi: Add device MSI infrastructure

  8) Infrastructure for and a POC of an IMS (Interrupt Message
     Storm) irq domain and irqchip implementation

       irqdomain/msi: Provide msi_alloc/free_store() callbacks
       irqchip: Add IMS array driver - NOT FOR MERGING

The whole lot is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git device-msi

This has been tested on Intel/AMD/KVM but lacks testing on:

    - HYPERV (-ENODEV)
    - VMD enabled systems (-ENODEV)
    - XEN (-ENOCLUE)

#1 and #2 should be applied unconditionally for obvious reasons
#3-5 are wortwhile cleanups which should be done independent of device MSI

#6-7 look promising to cleanup the platform MSI implementation
     independent of #8, but I neither had cycles nor stomache to tackle that.

#8 is obviously just for the folks interested in IMS

And of course this all started with a 100 lines combo patch to figure
out whether this is possible at all with a reasonable effort. 38
patches later ...

Thanks,

	tglx
