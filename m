Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2606624E124
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 21:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHUTrs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 15:47:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgHUTrr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 15:47:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598039264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oc6rWuK4RWluEJBMD17wpMBfxGYcOFdDWSkk5lcadvw=;
        b=KiXQi33Xg/nd2cc5p/iAKtPJMeJNOzlCIzhWjWEbDdZsQcUjTDcZub6BshDwVTeuzhZGv3
        zw2QKFIaV6T0xnr0tMl0umwZIX8sVQuHMEUfRQUVCSNH+RS3Ctu3yRElL1RDrH9OSkUBvR
        Tsr3wMNO6B9xByzMz6gnGKvZsy58iZhaXxtRYkjnJJ3WTiyQxefyan9gZqT9mGBT6u+xX7
        879KRDH1ZIZQf7iaP+awji6DDAUxA8bYq12w27+m5dPt9dX2xBuAi7ENRI59fAae7fEgGi
        t8GgtNuJOLOuihUaToMYiDcn5kSYsxXPj3V4PLzYavwP+TAnb34LXNCN2fVjfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598039264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oc6rWuK4RWluEJBMD17wpMBfxGYcOFdDWSkk5lcadvw=;
        b=ZNTKZwPc7JAJl8Qd563jtK8cr0w4Fu55mv5EH+kVE+8/1HT5hcM/atj4LWnPcJrRJGhXkM
        niAVH0dbiv4S6wAA==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Marc Zyngier <maz@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
In-Reply-To: <20200821124547.GY1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de> <20200821002949.049867339@linutronix.de> <20200821124547.GY1152540@nvidia.com>
Date:   Fri, 21 Aug 2020 21:47:43 +0200
Message-ID: <874kovsrvk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21 2020 at 09:45, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2020 at 02:25:02AM +0200, Thomas Gleixner wrote:
>> +static void ims_mask_irq(struct irq_data *data)
>> +{
>> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
>> +	struct ims_array_slot __iomem *slot = desc->device_msi.priv_iomem;
>> +	u32 __iomem *ctrl = &slot->ctrl;
>> +
>> +	iowrite32(ioread32(ctrl) & ~IMS_VECTOR_CTRL_UNMASK, ctrl);
>
> Just to be clear, this is exactly the sort of operation we can't do
> with non-MSI interrupts. For a real PCI device to execute this it
> would have to keep the data on die.

We means NVIDIA and your new device, right?

So if I understand correctly then the queue memory where the MSI
descriptor sits is in RAM.

How is that supposed to work if interrupt remapping is disabled?

That means irq migration and proper disabling of an interrupt become an
interesting exercise. I'm so not looking forward to that.

If interrupt remapping is enabled then both are trivial because then the
irq chip can delegate everything to the parent chip, i.e. the remapping
unit.

Can you please explain that a bit more precise?

> I saw the idxd driver was doing something like this, I assume it
> avoids trouble because it is a fake PCI device integrated with the
> CPU, not on a real PCI bus?

That's how it is implemented as far as I understood the patches. It's
device memory therefore iowrite32().

> It is really nice to see irq_domain used properly in x86!

If you ignore the abuse in XEN :)

And to be fair proper and usable (hierarchical) irq domains originate
from x86 and happened to solve quite a few horrorshows on the ARM side.

Just back then when we converted the original maze, nobody had a good
idea and the stomach to touch XEN.

Thanks,

        tglx
