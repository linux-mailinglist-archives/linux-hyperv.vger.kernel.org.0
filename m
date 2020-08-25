Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BCD2522CD
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 23:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYV2d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 17:28:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYV2c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 17:28:32 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598390910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DM8kbYiy7ZvYakB3fMHVSwg1j58bcLwh1sILIYH/AFI=;
        b=tOoYjJYvUPFZDmOguQPFJDhQeHuqRavvHi/bJrAyTkchveyhC+en4z3ohJa6FmPIHI2vow
        qc9HQ8/FTpaHEhGVpgURbiV1lVl+XKejxCXJmH2j3Sj2h8nwPHrrK3/Kb6Do9W3PTncSXY
        TOuqFSROfKTujH662yP4shxjPWBDkywHOauPnwUWRRiR+DHAaP2psLdtuzSJtmNFJD79PB
        hjeXftohGgS9rC9Xb2dZuw6mNwzd/d9QfmdUvlkZy88Ftt7fM3r9rWu4L7KrgJ8gocSx1K
        eGa2PZEjfsTIQ/LxJMcJsM3xNXGuHKDY89giMPP0/QzKHuUEf3bJ22fUusSPsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598390910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DM8kbYiy7ZvYakB3fMHVSwg1j58bcLwh1sILIYH/AFI=;
        b=oQR1S/0DMHh75hr94qI0low3SKHVQ7r24k+kTQlDcy/nGiegnvAQmFWoo65Pv64XBO7xgV
        AXir3AUyBr42qvBg==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
        Russ Anderson <rja@hpe.com>,
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
Subject: Re: [patch RFC 30/38] PCI/MSI: Allow to disable arch fallbacks
In-Reply-To: <20200825200742.GA1924669@bjorn-Precision-5520>
References: <20200825200742.GA1924669@bjorn-Precision-5520>
Date:   Tue, 25 Aug 2020 23:28:30 +0200
Message-ID: <87a6yixvnl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 25 2020 at 15:07, Bjorn Helgaas wrote:
>> + * The arch hooks to setup up msi irqs. Default functions are implemented
>> + * as weak symbols so that they /can/ be overriden by architecture specific
>> + * code if needed.
>> + *
>> + * They can be replaced by stubs with warnings via
>> + * CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS when the architecture fully
>> + * utilizes direct irqdomain based setup.
>
> Do you expect *all* arches to eventually use direct irqdomain setup?

Ideally that happens some day. We have five left when x86 is converted:

IA64, MIPS, POWERPC, S390, SPARC

IA64 is unlikely to be fixed, but might be solved naturally by removal.

For the others I don't know, but it's not on the horizon anytime soon I
fear.

> And in that case, to remove the config option?

Yes, and all the code which depends on it.

> If not, it seems like it'd be nicer to have the burden on the arches
> that need/want to use arch-specific code instead of on the arches that
> do things generically.

Right, but they still share the common code there and some of them
provide only parts of the weak callbacks. I'm not sure whether it's a
good idea to copy all of this into each affected architecture.

Or did you just mean that those architectures should select
CONFIG_I_WANT_THE CRUFT instead of opting out on the fully irq domain
based ones?

Thanks,

        tglx


