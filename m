Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A237524E3FB
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Aug 2020 01:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHUXrQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 19:47:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHUXrQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 19:47:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598053632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbhUfi01Lj30oKJLzgR9lJa3kGd2iztxYrMT6AoLDA0=;
        b=B3s85JH8i/R5/bUHXE+QSDKOor6uF48pkVsyK6uj4VJC6HEXSsNdHFBzoIB/jGsr8pIr0y
        6raD4q7fb+OVjcd3qWDMvswA+1tGzMBh+pMMSl7FY9bkxZYElbiDhXVVOvmzgFyNG9Idl9
        I/2gpZVcBspfP9gSO3oXOUqFOdp7WAFEyXcCH/dUQZiDLOpxjGSEVQ3bJjbKwDvPDEhlb0
        Ouft7IK0e07fEbjTd6D6bIWVPKRSH4yQQxkVW54nInvJb2NmcPSCpV0bmnakgH871j00ti
        1YkYwDzJZpQ0MhkOprW59BXX925S3UvkhCHgh3dA9b0pVCpMEPqAoBCkG7PuSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598053632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbhUfi01Lj30oKJLzgR9lJa3kGd2iztxYrMT6AoLDA0=;
        b=l/FCY1KjHYxb9uLaLBxYm/x1XfpF9veS5xVLnD33XhQUxQbME9e/mk4EOSC7F3pHAbdsXE
        pIx+JyLFa3x98ADQ==
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
In-Reply-To: <20200821201705.GA2811871@nvidia.com>
References: <20200821002424.119492231@linutronix.de> <20200821002949.049867339@linutronix.de> <20200821124547.GY1152540@nvidia.com> <874kovsrvk.fsf@nanos.tec.linutronix.de> <20200821201705.GA2811871@nvidia.com>
Date:   Sat, 22 Aug 2020 01:47:12 +0200
Message-ID: <87pn7jr27z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21 2020 at 17:17, Jason Gunthorpe wrote:
> On Fri, Aug 21, 2020 at 09:47:43PM +0200, Thomas Gleixner wrote:
>> So if I understand correctly then the queue memory where the MSI
>> descriptor sits is in RAM.
>
> Yes, IMHO that is the whole point of this 'IMS' stuff. If devices
> could have enough on-die memory then they could just use really big
> MSI-X tables. Currently due to on-die memory constraints mlx5 is
> limited to a few hundred MSI-X vectors.

Right, that's the limit of a particular device, but nothing prevents you
to have a larger table on a new device.

The MSI-X limitation to 2048 is defined by the PCI spec and you'd need
either some non spec compliant abuse of the reserved size bits or some
extra config entry. So IMS is a way to work around that. But I
understand why you want to move them to main memory, but you have to
deal with the problems this creates upfront.

> Since MSI-X tables are exposed via MMIO they can't be 'swapped' to
> RAM.
>
> Moving away from MSI-X's MMIO access model allows them to be swapped
> to RAM. The cost is that accessing them for update is a
> command/response operation not a MMIO operation.
>
> The HW is already swapping the queues causing the interrupts to RAM,
> so adding a bit of additional data to store the MSI addr/data is
> reasonable.

Makes sense.

>> How is that supposed to work if interrupt remapping is disabled?
>
> The best we can do is issue a command to the device and spin/sleep
> until completion. The device will serialize everything internally.
>
> If the device has died the driver has code to detect and trigger a
> PCI function reset which will definitely stop the interrupt.

If that interrupt is gone into storm mode for some reason then this will
render your machine unusable before you can do that.

> So, the implementation of these functions would be to push any change
> onto a command queue, trigger the device to DMA the command, spin/sleep
> until the device returns a response and then continue on. If the
> device doesn't return a response in a time window then trigger a WQ to
> do a full device reset.

I really don't want to do that with the irq descriptor lock held or in
case of affinity from the interrupt handler as we have to do with PCI
MSI/MSI-X due to the horrors of the X86 interrupt delivery trainwreck.
Also you cannot call into command queue code from interrupt disabled and
interrupt descriptor lock held sections. You can try, but lockdep will
yell at you immediately. 

There is also CPU hotplug where we have to force migrate an interrupt
away from an outgoing CPU. This needs some serious thought.

One question is whether the device can see partial updates to that
memory due to the async 'swap' of context from the device CPU.

So we have address_lo, address_hi, data and ctrl. Each of them 32 bit.

address_hi is only relevant when the number of CPUs is > 255 which
requires X2APIC which in turn requires interrupt remapping. For all
others the address_hi value never changes. Let's ignore that case for
now, but see further down.

So what's interesting is address_lo and data. If the device sees an
partial update, i.e. address_lo is written and the device grabs the
update before data is written then the next interrupt will end up in
lala land. We have code for that in place in msi_set_affinity() in
arch/x86/kernel/apic/msi.c. Get eyecancer protection glasses before
opening that and keep beer ready to wipe out the horrors immediately
afterwards.

If the device updates the data only when a command is issued then this
is not a problem, but it causes other problems because you still cannot
access the command queue from that context. This makes it even worse for
the CPU hotplug case. But see all of the reasoning on that.

If it takes whatever it sees while grabbing the state when switching to
a different queue or at the point of actual interrupt delivery, then you
have a problem. Not only you, I'm going to have one as well because I'm
going to be the poor sod to come up with the workaround.

So we better address that _before_ you start deploying this piece of
art. I'm not really interested in another slighly different and probably
more horrible version of the same story. Don't blame me, it's the way
how Intel decided to make this "work".

There are a couple of options to ensure that the device will never see
inconsistent state:

      1) Use a locked 16 byte wide operation (cpmxchg16) which is not
         available on 32bit

      2) Order the MSG entry differently in the queue storage:

         u32 address_lo
         u32 data
         u32 address_hi
         u32 ctrl

         And then enforce an 8 byte store on 64 bit which is guaranteed
         to be atomic vs. other CPUs and bus agents, i.e. DMA.

         I said enforce because compilers are known to do stupid things.

Both are fine for me and the only caveat is that the access does not go
accross a cache line boundary. The restriction to 64bit shouldn't be a
problem either. Running such a device on 32bit causes more problems than
it solves :)

> The spin/sleep is only needed if the update has to be synchronous, so
> things like rebalancing could just push the rebalancing work and
> immediately return.

Interrupt migration is async anyway. An interrupt might have been sent
to the old vector just before the new vector was written. That's already
dealt with. The old vector is cleaned up when the first interrupt
arrives on the new vector which is the most reliable indicator that it's
done.

In that case you can avoid issuing a command, but that needs some
thought as well when the queue data is never reloaded. But you can mark
the queue that affinity has changed and let the next operation on the
queue (RX, TX, whatever) which needs to talk to the device anyway deal
with it, i.e. set some command flag in the next operation which tells
the queue to reload that message.

The only exception is CPU hotplug, but I have an idea how to deal with
that.

Aside of that some stuff want's to be synchronous though. e.g. shutdown,
startup.

irq chips have already a mechanism in place to deal with stuff which
cannot be handled from within the irq descriptor spinlock held and
interrupt disabled section.

The mechanism was invented to deal with interrupt chips which are
connected to i2c, spi, etc.. The access to an interrupt chip control
register has to queue stuff on the bus and wait for completion.
Obviously not what you can do from interrupt disabled, raw spinlock held
context either.

So we have for most operations (except affinity setting) the concept of
update on lock release. For these devices the interrupt chip which
handles all lines on that controller on the slow bus has an additional
lock, called bus lock. The core code does not know about that lock at
all. It's managed at the irq chip side.

The irqchip has two callbacks: irq_bus_lock() and irq_bus_sync_unlock().
irq_bus_lock() is invoked before interrupts are disabled and the
spinlock is taken and irq_bus_sync_unlock() after releasing the spinlock
and reenabling interrupts. The "real" chip operations like mask, unmask
etc. are operating on an chip internal state cache.

For such devices irq_bus_lock() usually takes a sleepable lock (mutex)
to protect the state cache and the update logic over the slow bus.

irq_bus_sync_unlock() releases that lock, but before doing so it checks
whether the operation has changed the state cache and if so it queues a
command on the slow bus and waits for completion.

That makes sure that the device state and the state cache are in sync
before the next operation on a maybe different irq line on the same chip
happens.

Now for your case you might just not have irq_mask()/irq_unmask() callbacks or
simple ones which just update the queue memory in RAM, but then you want
irq_disable()/irq_enable() callbacks which manipulate state cache and
then provide the irq_bus_lock() and irq_bus_sync_unlock() callbacks as
well which do not necessarily need a lock underneath, but the unlock
side implements the 'Queue command and wait for completion' part.

Now coming back to affinity setting. I'd love to avoid adding the bus
lock magic to those interfaces because until now they can be called and
are called from atomic contexts. And obviously none of the devices which
use the buslock magic support affinity setting because they all deliver
a single interrupt to a demultiplex interrupt and that one is usually
sitting at the CPU level where interrupt steering works.

If we really can get away with atomically updating the message as
outlined above and just let it happen at some point in the future then
most problems are solved, except for the nastyness of CPU hotplug.

But that's actually a non issue. Nothing prevents us from having an
early 'migrate interrupts away from the outgoing CPU hotplug state'
which runs in thread context and can therefore utilize the buslock
mechanism. Actually I was thinking about that for other reasons already.

That state would need some thought and consequently some minor changes
to the affinity mask checks to prevent that the interrupt gets migrated
back to the outgoing CPU before that CPU reaches offline state. Nothing
fundamental though.

Just to be clear: We really need to do that at the core level and not
again in some dark place in a driver as that will cause state
inconsistency and hard to debug wreckage.

>> If interrupt remapping is enabled then both are trivial because then the
>> irq chip can delegate everything to the parent chip, i.e. the remapping
>> unit.
>
> I did like this notion that IRQ remapping could avoid the overhead of
> spin/spleep. Most of the use cases we have for this will require the
> IOMMU anyhow.

You still need to support !remap scenarios I fear.

And even for the remap case you need some of that bus lock magic to
handle startup and teardown properly without the usual horrible hacks in
the driver.

If your hard^Wfirmware does the right thing then the only place you need
to worry about the command queueing is startup and teardown and the
extra bit for the early hotplug migration.

Let me summarize what I think would be the sane solution for this:

  1) Utilize atomic writes for either all 16 bytes or reorder the bytes
     and update 8 bytes atomically which is sufficient as the wide
     address is only used with irq remapping and the MSI message in the
     device is never changed after startup.

  2) No requirement for issuing a command for regular migration
     operations as they have no requirements to be synchronous.

     Eventually store some state to force a reload on the next regular
     queue operation.

  3) No requirement for issuing a command for mask and unmask operations.
     The core code uses and handles lazy masking already. So if the
     hardware causes the lazyness, so be it.

  4) Issue commands for startup and teardown as they need to be
     synchronous

  5) Have an early migration state for CPU hotunplug which issues a
     command from appropriate context. That would even allow to handle
     queue shutdown for managed interrupts when the last CPU in the
     managed affinity set goes down. Restart of such a managed interrupt
     when the first CPU in an affinity set comes online again would only
     need minor modifications of the existing code to make it work.
     
Thoughts?

Thanks,

        tglx
