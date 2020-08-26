Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8923125393D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 22:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHZUnl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 16:43:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33278 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgHZUnk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 16:43:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598474617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lj+HCAMB66c34Pt5/8qmaZU+5YodJ4K21RaNchn7Bnc=;
        b=gcH0soDHT7m1DhfNC6QQbqPGhh4sNSGm+9HSqTNzBlS+x8Z2m9573FZdMFQ3rSMEy5TjOq
        uU5srRzQ57ZK7h7gre4f2FSv4hNOipvH70zBr6ezrez6KIHQWB2c4Jxicem4nd/YollyTg
        HBaSP6ZU4VhZqvC3/BQvtKZzG9KUMJ+8PmO0gFJR3LK4HH9WPJVruFTwpCEqBu4Ccpn0iU
        J5fuAhIORUJ6LjXSEilyVzyJ0JORvLSeJT7AwOqNQvowv2+x5spObQm7K4bA8aBThzVELh
        g+dVfbSpWNtafkPkhFcVYcuzNQ8Aw1lGxua3yd3hXafDPdkQUX9TxKBSOjfEoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598474617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lj+HCAMB66c34Pt5/8qmaZU+5YodJ4K21RaNchn7Bnc=;
        b=3FfX+fa7xCYcsjOKRE6odcrU12DlAns0QXGcNpm0K0uqtnqkEn+z0OyLuyyMffuAKPHcop
        nWo4UHb9iLwwiHCw==
To:     Marc Zyngier <maz@kernel.org>
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
Subject: Re: [patch V2 19/46] x86/msi: Use generic MSI domain ops
In-Reply-To: <878se12m5n.wl-maz@kernel.org>
References: <20200826111628.794979401@linutronix.de> <20200826112332.564274859@linutronix.de> <878se12m5n.wl-maz@kernel.org>
Date:   Wed, 26 Aug 2020 22:43:36 +0200
Message-ID: <87tuwpt9xj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26 2020 at 21:21, Marc Zyngier wrote:
> On Wed, 26 Aug 2020 12:16:47 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> -void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>> -{
>> -	arg->desc = desc;
>> -	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
>> -}
>> -EXPORT_SYMBOL_GPL(pci_msi_set_desc);
>
> I think that at this stage, pci_msi_domain_calc_hwirq() can be made
> static, as it was only ever exported for this call site. Nice cleanup!

Doh indeed. Let me fix that.
