Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7527E165
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgI3Glv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 02:41:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3Glv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 02:41:51 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601448108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJKrDPg1zMcLHTJ9psmGJPskafubkx5uuA4rv00RWvE=;
        b=3b6vWZ3FYwgK0uGd/jHNKkzf932WR9YVcHqnMSL9hHtR4FHsBZC07JwnVnqMJT9Jed2laM
        sOmj+DtePTxNt1wmjH5DZ6o2s5opDsc8D9ifXyqbFVzXOdAfouLp4tTZLVGyMM1xzNgVNF
        SiFdV8l6tmYAgTktBPpm/Iadr8yO4O7oHnUbbnOIztDfkFXFDnrym1ArBAMUmD2E46aShM
        CD+CVsD5I4NZ1O1jmOVTRGe6+5R2FDp5MP/BP/FjqJPOUfRmKvz3lfIp+HuQ1y5Tb6Yo6V
        QtpSVxjdk4qgFUFhEUdh5DLZfdeQVjrBT9YrrBtUq7PiKVvMzZoW945MxWorVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601448108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJKrDPg1zMcLHTJ9psmGJPskafubkx5uuA4rv00RWvE=;
        b=4oScqGVN58GGowfuDE4TlRtr/G0yJIGU+gi/diGlZDZu0wervLchyWESUEEFxWNHdARjHI
        QIrbJgszY1bnCuAA==
To:     "Dey\, Megha" <megha.dey@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
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
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
        ravi.v.shankar@intel.com
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
References: <20200826111628.794979401@linutronix.de> <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
Date:   Wed, 30 Sep 2020 08:41:48 +0200
Message-ID: <87v9fvix5f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 29 2020 at 16:03, Megha Dey wrote:
> On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
>> #9	is obviously just for the folks interested in IMS
>>
>
> I see that the tip tree (as of 9/29) has most of these patches but 
> notice that the DEV_MSI related patches
>
> haven't made it. I have tested the tip tree(x86/irq branch) with your
> DEV_MSI infra patches and our IMS patches with the IDXD driver and was

Your IMS patches? Why do you need something special again?

> wondering if we should push out those patches as part of our patchset?

As I don't have any hardware to test that, I was waiting for you and
Jason to confirm that this actually works for the two different IMS
implementations.

Thanks,

        tglx
