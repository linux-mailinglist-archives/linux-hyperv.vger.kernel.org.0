Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF362522D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 23:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHYVao (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 17:30:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHYVan (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 17:30:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598391042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laLU5yxufmnFbi5ts+Ew5ZowSakjcO5PUqgrvOPNK+M=;
        b=ZVFEoRRlNJXFUgq6mQ2rduXlE2yad4xOmO34uYv0zEgHs0EncfZCre9kecOLZD0qyCUmIm
        fK/IA91Xv4YdestP0rW84OW5ZZqMJjbjso9OohwlJurrsXdtw0ybCtY6AJQtoUHjVvlvpz
        YMUdF+VrZgCxpTtiriD1TFTT0mADfgDYfGO0mJ/ZJWuV5BgLjH+scZb6eYP5Gg6K5n8dfA
        zzArbSiNPOkDqe2ro8oObhpqB71UKiq2qGT5YKQfOuP+ihQy5K+0KcqrFFA4jQkfQoRB9K
        cLIrHEKf3zeejhobeqwNwZWz6IoWsSqpvafIyP2+XFH9zXiVQCwVctTHzYueGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598391042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=laLU5yxufmnFbi5ts+Ew5ZowSakjcO5PUqgrvOPNK+M=;
        b=x70sLQs+vhFrFlF+FHbXLrFMyKKxpeRA9gYzPYp3g2ps1QJSE2dXtMNyCBRtV1YY3fSv8d
        R8wzoviTHQJFosAw==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>,
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
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch RFC 34/38] x86/msi: Let pci_msi_prepare() handle non-PCI MSI
In-Reply-To: <20200825202419.GA1925250@bjorn-Precision-5520>
References: <20200825202419.GA1925250@bjorn-Precision-5520>
Date:   Tue, 25 Aug 2020 23:30:41 +0200
Message-ID: <877dtmxvjy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 25 2020 at 15:24, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 02:24:58AM +0200, Thomas Gleixner wrote:
>> Rename it to x86_msi_prepare() and handle the allocation type setup
>> depending on the device type.
>
> I see what you're doing, but the subject reads a little strangely

Yes :(

> ("pci_msi_prepare() handling non-PCI" stuff) since it doesn't mention
> the rename.  Maybe not practical or worthwhile to split into a rename
> + make generic, I dunno.

What about

x86/msi: Rename and rework pci_msi_prepare() to cover non-PCI MSI

Thanks,

        tglx
