Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8127F115
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgI3SLp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 14:11:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58484 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SLp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 14:11:45 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601489503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXtBXXhiMVMdTYSCyK9KnC71AtIKQfsWx/V0UzZjSqs=;
        b=aalLhxTTFAUQOEA4S+jPMN0XZ7VE8ERlzT82B+AOWxenX32nsqgLWa/bYiqvfiOxx0w1Dc
        sV9R+Hp52bFesJRNB+HmHnqCYvBJXznlZPPdx+d9EwYl8ewLltm1Hcym/Ph1xDZyzKjJhL
        ZVs5Cw93bo+IiNxdmuCp3JcjzVSx6XSx551yPOrwgtVK/KEsPd0HKXZqyH23xMbaok4fD5
        my8dTS5Y90I/giCW/fia+Yn5S/NE4gRRwcr5l+mByPUetyDTSTO15kuyfJ0C1TdjqTXL+l
        vicJtFiTWlmeiyaxl2Tbjh5IEvtXABQE3fDj45VcPymN9gXwFrPKlNHV6tPRrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601489503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXtBXXhiMVMdTYSCyK9KnC71AtIKQfsWx/V0UzZjSqs=;
        b=+0cpSGl+ZP0wOxBV5o33UW0ETwb2OixJ9wUOzToxF/4Yxscw/i8EIRz4QPlc5qG84wdWZD
        QI0HtoTSaEP0J8Dg==
To:     "Dey\, Megha" <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        ravi.v.shankar@intel.com
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <e07aa723-12cd-7eb7-392a-642f96b98f79@intel.com>
References: <20200826111628.794979401@linutronix.de> <10b5d933-f104-7699-341a-0afb16640d54@intel.com> <87v9fvix5f.fsf@nanos.tec.linutronix.de> <20200930114301.GD816047@nvidia.com> <87k0wbi94b.fsf@nanos.tec.linutronix.de> <e07aa723-12cd-7eb7-392a-642f96b98f79@intel.com>
Date:   Wed, 30 Sep 2020 20:11:43 +0200
Message-ID: <878scri17k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Megha,

On Wed, Sep 30 2020 at 10:25, Megha Dey wrote:
> On 9/30/2020 8:20 AM, Thomas Gleixner wrote:
>>>> Your IMS patches? Why do you need something special again?
>
> By IMS patches, I meant your IMS driver patch that was updated (as it 
> was untested, it had some compile errors and we removed the IMS_QUEUE
> parts) :

Ok.

> The whole patchset can be found here:
>
> https://lore.kernel.org/lkml/f4a085f1-f6de-2539-12fe-c7308d243a4a@intel.com/
>
> It would be great if you could review the IMS patches :)

It somehow slipped through the cracks. I'll have a look.

> We were hoping to get IMS in the 5.10 merge window :)

Hope dies last, right?

>>> We might be able to put together a mockup just to prove it
>> If that makes Megha's stuff going that would of course be appreciated,
>> but we can defer the IMS_QUEUE part for later. It's orthogonal to the
>> IMS_ARRAY stuff.
>
> In our patch series, we have removed the IMS_QUEUE stuff and retained 
> only the IMS_ARRAY parts > as that was sufficient for us.

That works. We can add that back when Jason has his puzzle pieces
sorted.

Thanks,

        tglx
