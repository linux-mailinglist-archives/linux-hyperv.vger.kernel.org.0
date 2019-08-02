Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15F8029D
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Aug 2019 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfHBWPm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 18:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbfHBWPm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 18:15:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FAC92087C;
        Fri,  2 Aug 2019 22:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564784141;
        bh=0VIAzOo4zb+swZnODQr4hpD7QckO3wZdHQ/+75GTF1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKqTme8pWjp2pFS3sAbNjLV/ACQVZk5uy3e4F7mchlG8JEQKkiMhiZALaWbrk9dTF
         PIZ+QsF9kwvw77M+BSZBGxYm/mPQD5HFsDY/DsHx0F1SVUB4RXpIp0jCG2gTlP88Gv
         KFks3NVPUOXw2b//d5n6Fhj08gxat8oPs+x8imWQ=
Date:   Fri, 2 Aug 2019 17:15:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Stephen Hemminger <sthemmin@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: Re: [PATCH] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Message-ID: <20190802221540.GN151852@google.com>
References: <PU1P153MB0169DBCFEE7257F5BB93580ABFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190802194053.GL151852@google.com>
 <PU1P153MB01698F51FE22C39086CC8353BFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01698F51FE22C39086CC8353BFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 02, 2019 at 08:31:26PM +0000, Dexuan Cui wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Friday, August 2, 2019 12:41 PM
> > The subject line only describes the mechanical code change, which is
> > obvious from the patch.  It would be better if we could say something
> > about *why* we need this.
> 
> Hi Bjorn,
> Sorry. I'll try to write a better changelog in v2. :-)
>  
> > On Fri, Aug 02, 2019 at 01:32:28AM +0000, Dexuan Cui wrote:
> > >
> > > When a slot is removed, the pci_dev must still exist.
> > >
> > > pci_remove_root_bus() removes and free all the pci_devs, so
> > > hv_pci_remove_slots() must be called before pci_remove_root_bus(),
> > > otherwise a general protection fault can happen, if the kernel is built
> > 
> > "general protection fault" is an x86 term that doesn't really say what
> > the issue is.  I suspect this would be a "use-after-free" problem.
> 
> Yes, it's use-after-free. I'll fix the the wording.
>  
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -2757,8 +2757,8 @@ static int hv_pci_remove(struct hv_device *hdev)
> > >  		/* Remove the bus from PCI's point of view. */
> > >  		pci_lock_rescan_remove();
> > >  		pci_stop_root_bus(hbus->pci_bus);
> > > -		pci_remove_root_bus(hbus->pci_bus);
> > >  		hv_pci_remove_slots(hbus);
> > > +		pci_remove_root_bus(hbus->pci_bus);
> > 
> > I'm curious about why we need hv_pci_remove_slots() at all.  None of
> > the other callers of pci_stop_root_bus() and pci_remove_root_bus() do
> > anything similar to hv_pci_remove_slots().
> > 
> > Surely some of those callers also support slots, so there must be some
> > other path that calls pci_destroy_slot() in those cases.  Can we use a
> > similar strategy here?
> 
> Originally Stephen Heminger added the slot code for pci-hyperv.c:
> a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
> So he may know this better. My understanding is: we can not use the similar
> stragegy used in the 2 other users of pci_create_slot():
> 
> drivers/pci/hotplug/pci_hotplug_core.c calls pci_create_slot().
> It looks drivers/pci/hotplug/ is quite different from pci-hyperv.c because
> pci-hyper-v uses a simple *private* hot-plug protocol, making it impossible
> to use the API pci_hp_register() and pci_hp_destroy() -> pci_destroy_slot().
> 
> drivers/acpi/pci_slot.c calls pci_create_slot(), and saves the created slots in
> the static "slot_list" list in the same file. Again, since pci-hyper-v uses a private
> PCI-device-discovery protocol (which is based on VMBus rather the emulated
> ACPI and PCI), acpi_pci_slot_enumerate() can not find the PCI devices that are
> discovered by pci-hyperv, so we can not use the standard register_slot() ->
> pci_create_slot() to create the slots and hence acpi_pci_slot_remove() -> 
> pci_destroy_slot() can not work for pci-hyperv.

Hmm, ok.  This still doesn't seem right to me, but I think the bottom
line will be that the current slot registration interfaces just don't
work quite right for all the cases we want them to.

Maybe it would be a good project for somebody to rethink them, but it
doesn't seem practical for *this* patch.  Thanks for looking into it
this far!

> I think I can use this as the v2 changelog:
> 
> The slot must be removed before the pci_dev is removed, otherwise a panic
> can happen due to use-after-free.

Sounds good.

Bjorn
