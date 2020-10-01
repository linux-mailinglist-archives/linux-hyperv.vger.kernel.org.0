Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A4327FD01
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Oct 2020 12:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbgJAKN3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Oct 2020 06:13:29 -0400
Received: from foss.arm.com ([217.140.110.172]:57994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgJAKN3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Oct 2020 06:13:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86802D6E;
        Thu,  1 Oct 2020 03:13:28 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00A823F70D;
        Thu,  1 Oct 2020 03:13:26 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:13:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "maz@kernel.org" <maz@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>
Subject: Re: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Message-ID: <20201001101324.GB5142@e121166-lin.cambridge.arm.com>
References: <20200908231759.13336-1-decui@microsoft.com>
 <20200928104309.GA12565@e121166-lin.cambridge.arm.com>
 <KU1P153MB01201EEC711EC37D30687940BF330@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KU1P153MB01201EEC711EC37D30687940BF330@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 30, 2020 at 12:38:04AM +0000, Dexuan Cui wrote:
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Monday, September 28, 2020 3:43 AM
> >
> > [+MarcZ - this patch needs IRQ maintainers vetting]
> 
> Sure. Hi MarkZ, please also review the patch. Thanks!
> 
> > On Tue, Sep 08, 2020 at 04:17:59PM -0700, Dexuan Cui wrote:
> > > Hyper-V doesn't trap and emulate the accesses to the MSI/MSI-X
> > > registers, and we must use hv_compose_msi_msg() to ask Hyper-V to
> > > create the IOMMU Interrupt Remapping Table Entries. This is not an issue
> > > for a lot of PCI device drivers (e.g. NVMe driver, Mellanox NIC drivers),
> > > which destroy and re-create the interrupts across hibernation, so
> > > hv_compose_msi_msg() is called automatically. However, some other
> > > PCI device drivers (e.g. the Nvidia driver) may not destroy and re-create
> > > the interrupts across hibernation, so hv_pci_resume() has to call
> > > hv_compose_msi_msg(), otherwise the PCI device drivers can no longer
> > > receive MSI/MSI-X interrupts after hibernation.
> >
> > This looks like drivers bugs and I don't think the HV controller
> > driver is where you should fix them.
> 
> IMHO this is not a PCI device driver bug, because I think a PCI device driver
> is allowed to keep and re-use the MSI/MSI-X interrupts across hibernation,
> otherwise we would not have pci_restore_msi_state() in pci_restore_state().
> 
> The in-tree open-source Nvidia GPU driver drivers/gpu/drm/nouveau is such
> a PCI device driver that re-uses the MSI-X interrupts across hibernation.
> The out-of-tree proprietary Nvidia GPU driver also does the same thing.
> It looks some other in-tree PCI device drivers also do the same thing, though
> I don't remember their names offhand.
> 
> IMO it's much better to change the pci-hyperv driver once and for all, than
> to change every such existing (and future?) PCI device driver.
> 
> pci_restore_msi_state() directly writes the MSI/MSI-X related registers
> in __pci_write_msi_msg() and msix_mask_irq(). On a physical machine, this
> works perfectly, but for a Linux VM running on a hypervisor, which typically
> enables IOMMU interrupt remapping, the hypervisor usually should trap and
> emulate the write accesses to the MSI/MSI-X registers, so the hypervisor
> is able to create the necessary interrupt remapping table entries in the
> IOMMU, and the MSI/MSI-X interrupts can work in the VM. Hyper-V is different
> from other hypervisors in that it does not trap and emulate the write
> accesses, and instead it uses a para-virtualized method, which requires
> the VM to call hv_compose_msi_msg() to notify the hypervisor of the info
> that would be passed to the hypervisor in the case of the trap-and-emulate
> method.
> 
> I mean this is a Hyper-V specific problem, so IMO we should fix the pci-hyperv
> driver rather than change the PCI device drivers, which work perfectly on a
> physical machine and on other hypervisors. Also it can be difficult or 
> impossible to ask the authors of the aforementioned PCI device drivers to
> destry and re-create MSI/MSI-X acorss hibernation, especially for the
> out-of-tree driver(s).

Good, so why did you mention PCI drivers in the commit log if they
are not related to the problem you are fixing ?

> > Regardless, this commit log does not provide the information that
> > it should.
> 
> Hi Lozenzo, I'm happy to add more info. Can you please let me know
> what extra info I should provide?

s/Lozenzo/Lorenzo

The info you describe properly below, namely what the _actual_ problem
is.

> > > Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Reviewed-by: Jake Oshins <jakeo@microsoft.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > >     Fixed a typo in the comment in hv_irq_unmask. Thanks to Michael!
> > >     Added Jake's Reviewed-by.
> > >
> > >  drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > > index fc4c3a15e570..dd21afb5d62b 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -1211,6 +1211,21 @@ static void hv_irq_unmask(struct irq_data *data)
> > >  	pbus = pdev->bus;
> > >  	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
> > >
> > > +	if (hbus->state == hv_pcibus_removing) {
> > > +		/*
> > > +		 * During hibernation, when a CPU is offlined, the kernel tries
> > > +		 * to move the interrupt to the remaining CPUs that haven't
> > > +		 * been offlined yet. In this case, the below hv_do_hypercall()
> > > +		 * always fails since the vmbus channel has been closed, so we
> > > +		 * should not call the hypercall, but we still need
> > > +		 * pci_msi_unmask_irq() to reset the mask bit in desc->masked:
> > > +		 * see cpu_disable_common() -> fixup_irqs() ->
> > > +		 * irq_migrate_all_off_this_cpu() -> migrate_one_irq().
> > > +		 */
> > > +		pci_msi_unmask_irqpci_msi_unmask_irq(data);
> >
> > This is not appropriate - it looks like a plaster to paper over an
> > issue with hyper-V hibernation code sequence. Fix that issue instead
> > of papering over it here.
> >
> > Thanks,
> > Lorenzo
> 
> IMO this patch is fixing this Hyper-V specific problem. :-)
> The probem is unique to Hyper-V because chip->irq_unmask() may fail in a
> Linux VM running on Hyper-V. 
> 
> chip->irq_unmask() can not fail on a physical machine. I guess this is why 
> the return value of irq_unmask() is defined as "void" in include/linux/irq.h:
> struct irq_chip {
> ...
>         void            (*irq_mask)(struct irq_data *data);
>         void            (*irq_unmask)(struct irq_data *data);
> 
> As I described in the comment, in a VM on Hyper-V, chip->irq_unmask()
> fails during the suspending phase of hibernation because it's called
> when the non-boot CPUs are being offlined, and at this time all the devices,
> including Hyper-V VMBus devices, have been "frozen" -- this is part of
> the standard Linux hibernation workflow. Since Hyper-V thinks the VM has
> frozen the pci-hyperv VMBus device at this moment (i.e. closed the VMBus
> channel of the VMBus device), it fails chip->irq_unmask(), i.e.
> hv_irq_unmask() -> hv_do_hypercall().
> 
> On a physical machine, unmasking an MSI/MSI-X register just means an MMIO
> write, which I think can not fail here.
> 
> So I think this patch is the correct fix, considering Hyper-V's unique
> implementation of the MSI "chip" (i.e. Hyper-V does not trap and emulate
> the MSI/MSI-X register accesses, and uses a para-virtualized method as I
> explained above), and the fact that I shouldn't and can't change the
> standard Linux hibernation workflow.
> 
> In hv_irq_unmask(), when I skip the hypercall in the case of
> hbus->state == hv_pcibus_removing, I still need the pci_msi_unmask_irq(),
> because of the sequences in kernel/irq/cpuhotplug.c:
> 
> static bool migrate_one_irq(struct irq_desc *desc)
> {
> ...
>         if (maskchip && chip->irq_mask)
>                 chip->irq_mask(d);
> ...
>         err = irq_do_set_affinity(d, affinity, false);
> ...
>         if (maskchip && chip->irq_unmask)
>                 chip->irq_unmask(d);
> 
> Here if hv_irq_unmask does not call pci_msi_unmask_irq(), the desc->masked
> remains "true", so later after hibernation, the MSI interrupt line always
> reamins masked, which is incorrect.
> 
> Here the slient failure of hv_irq_unmask() does not matter since all the
> non-boot CPUs are being offlined (meaning all the devices have been
> frozen). Note: the correct affinity info is still updated into the
> irqdata data structure in migrate_one_irq() -> irq_do_set_affinity() ->
> hv_set_affinity(), so when the VM resumes, hv_pci_resume() ->
> hv_pci_restore_msi_state() is able to correctly restore the irqs with
> the correct affinity.
> 
> I hope the explanation can help clarify things. I understand this is
> not as natual as tht case that Linux runs on a physical machine, but
> due to the unique PCI pass-through implementation of Hyper-V, IMO this
> is the only viable fix for the problem here. BTW, this patch is only
> confined to the pci-hyperv driver and I believe it can no cause any
> regression.

Understood, write this in the commit log and I won't nag you any further.

Side note: this issue is there because the hypcall failure triggers
an early return from hv_irq_unmask(). Is that early return really
correct ? Another possibility is just logging the error and let
hv_irq_unmask() continue and call pci_msi_unmask_irq() in the exit
path.

Is there a hypcall return value that you can use to detect fatal vs
non-fatal (ie hibernation) hypcall failures ?

I was confused by reading the patch since it seemed that you call
pci_msi_unmask_irq() _only_ while hibernating, which was certainly
a bug.

Thank you for explaining.

Lorenzo

> Thanks,
> -- Dexuan
> 
> 
> > > +		return;
> > > +	}
> > > +
> > >  	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
> > >
> > >  	params = &hbus->retarget_msi_interrupt_params;
> > > @@ -3372,6 +3387,33 @@ static int hv_pci_suspend(struct hv_device
> > *hdev)
> > >  	return 0;
> > >  }
> > >
> > > +static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
> > > +{
> > > +	struct msi_desc *entry;
> > > +	struct irq_data *irq_data;
> > > +
> > > +	for_each_pci_msi_entry(entry, pdev) {
> > > +		irq_data = irq_get_irq_data(entry->irq);
> > > +		if (WARN_ON_ONCE(!irq_data))
> > > +			return -EINVAL;
> > > +
> > > +		hv_compose_msi_msg(irq_data, &entry->msg);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Upon resume, pci_restore_msi_state() -> ... ->  __pci_write_msi_msg()
> > > + * re-writes the MSI/MSI-X registers, but since Hyper-V doesn't trap and
> > > + * emulate the accesses, we have to call hv_compose_msi_msg() to ask
> > > + * Hyper-V to re-create the IOMMU Interrupt Remapping Table Entries.
> > > + */
> > > +static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
> > > +{
> > > +	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
> > > +}
> > > +
> > >  static int hv_pci_resume(struct hv_device *hdev)
> > >  {
> > >  	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
> > > @@ -3405,6 +3447,8 @@ static int hv_pci_resume(struct hv_device *hdev)
> > >
> > >  	prepopulate_bars(hbus);
> > >
> > > +	hv_pci_restore_msi_state(hbus);
> > > +
> > >  	hbus->state = hv_pcibus_installed;
> > >  	return 0;
> > >  out:
> 
