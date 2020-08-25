Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820B72522E4
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Aug 2020 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHYVfD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Aug 2020 17:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgHYVfD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Aug 2020 17:35:03 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431E0206EB;
        Tue, 25 Aug 2020 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598391302;
        bh=iaxjbZsBqna2sELKvW37oDWjgc6W43k1NdwaMyPOzcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZDGaYc9qhTxV2pA1wPb9Q5LqI6Ehvpg5A4GMn18E+XiEAZR/80yPJKnZPFAK8TnIU
         wAM0ZPrbbpwoW2+6rUdZWmT9bIdSAFoL0FNWWLtzM8IoOFDxGQNXUB782s5cxX+YqV
         EyEgGHhTCo7adlpsp4Rg6JWQpAi01VHvK5gPVgNM=
Date:   Tue, 25 Aug 2020 16:35:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20200825213501.GA1931388@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6yixvnl.fsf@nanos.tec.linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 25, 2020 at 11:28:30PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 25 2020 at 15:07, Bjorn Helgaas wrote:
> >> + * The arch hooks to setup up msi irqs. Default functions are implemented
> >> + * as weak symbols so that they /can/ be overriden by architecture specific
> >> + * code if needed.
> >> + *
> >> + * They can be replaced by stubs with warnings via
> >> + * CONFIG_PCI_MSI_DISABLE_ARCH_FALLBACKS when the architecture fully
> >> + * utilizes direct irqdomain based setup.

> > If not, it seems like it'd be nicer to have the burden on the arches
> > that need/want to use arch-specific code instead of on the arches that
> > do things generically.
> 
> Right, but they still share the common code there and some of them
> provide only parts of the weak callbacks. I'm not sure whether it's a
> good idea to copy all of this into each affected architecture.
> 
> Or did you just mean that those architectures should select
> CONFIG_I_WANT_THE CRUFT instead of opting out on the fully irq domain
> based ones?

Yes, that was my real question -- can we confine the cruft in the
crufty arches?  If not, no big deal.

Bjorn
