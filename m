Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FAB252285
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYVL7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYVL7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 17:11:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D7C061574;
        Tue, 25 Aug 2020 14:11:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598389916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1frHZHutANeGhNvELKAlZV7ZBIw0Dqsl4tEEvrOnRU4=;
        b=rQQMWS26Jt5LaZuxdrMUZgNfuNew2mCXTFepS37C35I6xAhJ3rEo9Nx2wJCVYo9FS/Pgcj
        zMK/jubxjmgOMukHjD1+whg0AyErL8YAwjSJxzS+B1PMq4RdTvHJO6lnQ8zCroL34GT5hw
        5/rfeY4s2ADMm35tAfb/mXN9dBB+PDzSGhJTbYCAYlaBzlpg8xMguI6MXbjreLqFtXNCau
        bsIWnmpXS6t/YonQ/7LmA5QV8SpSh4TrFs2TkYIhUy6U4rcc0A8vIF1QUkDGf2mbfLYdBM
        gsUXIxYqmPwtfL3S4OeTd+L815+ua7i1Gq/tsUgXEKLDUxlqgI3fswjFMqzoNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598389916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1frHZHutANeGhNvELKAlZV7ZBIw0Dqsl4tEEvrOnRU4=;
        b=hWC9wT9/QuU4/otH2U3KHZ3pSL+StkJoqjJVoH3bzCOAJhuscP4cb126Q52YIHKMSI5RAk
        NlcAG4imPXq613BA==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [patch RFC 13/38] PCI: MSI: Rework pci_msi_domain_calc_hwirq()
In-Reply-To: <20200825200329.GA1923406@bjorn-Precision-5520>
References: <20200825200329.GA1923406@bjorn-Precision-5520>
Date:   Tue, 25 Aug 2020 23:11:56 +0200
Message-ID: <87d03exwf7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 25 2020 at 15:03, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 02:24:37AM +0200, Thomas Gleixner wrote:
>> Retrieve the PCI device from the msi descriptor instead of doing so at the
>> call sites.
>
> I'd like it *better* with "PCI/MSI: " in the subject (to match history

Duh, yes.

> and other patches in this series) and "MSI" here in the commit log,
> but nice cleanup and:
>> --- a/arch/x86/kernel/apic/msi.c
>> +++ b/arch/x86/kernel/apic/msi.c
>> @@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
>>  
>>  void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>>  {
>> -	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
>> +	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);
>
> I guess it's safe to assume that "arg->msi_dev ==
> msi_desc_to_pci_dev(desc)"?  I didn't try to verify that.

It is.

>> +irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>>  {
>> +	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
>
> If you named this "struct pci_dev *dev" (not "pdev"), the diff would
> be a little smaller and it would match other usage in the file.

Ok. I'm always happy to see pdev because that doesn't make me wonder
which type of dev it is :) But, yeah lets keep it consistent.

Thanks,

        tglx
