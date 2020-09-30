Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3D27E90B
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 14:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgI3M54 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 08:57:56 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:57378 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3M54 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 08:57:56 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7480d10000>; Wed, 30 Sep 2020 20:57:53 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 12:57:38 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 12:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjpbJ1re4W/9wjakAEdLliBAhIS7pf5Q5JGD5OgKeU/xsXuufIHTsAIqNWVC3hFhp2bHFEZjB9Jx8YqbXbA3kBSBmyXz+IEepXO64I2x5GC2y0S63sd1FaJVn7DEPIKHdSsSPFoZTTHYfA8noAxpVGsmAmouHtREEx7qVzj0Hh/lOaBQoFbUuRMn3IYZbxnMhxgNVEhzmlEb9zwAhDBxRbeJ1KR7Oqn475Y8rlvAWSyiwEQzxbpTPeAy+OBbY0Lfbql9xTXvBXIXgbM2QtihuoMtCoS6nVVZGetrBSKUn4B/+vW1x6doREhxK/2yFmwEJytFxSoh3k6JQUrQd6nOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUH51rA3HlHLJikqE7iyQmhXDVNQppUQ5K9nEJCgL5c=;
 b=bHLxeNeEd5yreVY5bWEPVBzjz/N8kto8yHsB2Pni3Ev3qLkaP0jScx7dCJMZJKyxNcQwbZw+kdgfD/g6bwML5lBlBm1PVaZB1sKDRGqZFJavvYvbR4Zcu28jLuIDmJSXjwZ5RQyFQtjVuz5u4f1754SRED/IDMLA8mBUyAhCVDtdD8bkjh0QFeHeEq2w+XzHlt9k6fejiJ8V8WMWVfomOLCuiSyb5b4Q+HwHHRy2LPTkdQSDDUHwxVPgyN+GSbitbFe7abYnsZImhiVyZ6nobzfBdDsYFkKi/tQQCpsEDPI98wCqH+IUpQj/hOD47r2OSDWrmlGp5+TWpFTDC1myFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 30 Sep
 2020 12:57:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 12:57:35 +0000
Date:   Wed, 30 Sep 2020 09:57:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "sivanich@hpe.com" <sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rja@hpe.com" <rja@hpe.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Message-ID: <20200930125733.GI816047@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.047315047@linutronix.de>
 <20200831143940.GA1152540@nvidia.com>
 <1d284a478d4e5bf4a247ee83afa1b8b45f9e1b3f.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d284a478d4e5bf4a247ee83afa1b8b45f9e1b3f.camel@intel.com>
X-ClientProxiedBy: MN2PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:208:e8::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:208:e8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Wed, 30 Sep 2020 12:57:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNbfp-003wyO-G7; Wed, 30 Sep 2020 09:57:33 -0300
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601470673; bh=xUH51rA3HlHLJikqE7iyQmhXDVNQppUQ5K9nEJCgL5c=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-LD-Processed;
        b=fPKN+2fo1SWx2AFfe5Sod7f9GcDofAGU4IIDgZh0mVcj3B1tjR7IeNneStA1aOGzC
         NOGoR1HZLm7J4/GUqSByIVkuXKWqM7TZt1zIYQ0XN1nvDf1IEjZrBQuIRxASftKi5w
         l7dwWIEpLXdcJ18SDsti6YtKpaSGriuCPFH6FN5rMZ9jlBfxXSFfF1ULUhe5ETStkN
         UxSB9/A6OUo8Yi+1YdkuzuDfor8d+BSwbitLNqtZNlhWHXwyMsuon3UNFWr12sRDv8
         bmpsocyTHzbsSzP3naiUDslkYVwp2kFLDVW5WWjVPp6H1clZUbMP4lLuVKM+P7kzof
         /zTQVFzW2Vwdw==
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 30, 2020 at 12:45:30PM +0000, Derrick, Jonathan wrote:
> Hi Jason
> 
> On Mon, 2020-08-31 at 11:39 -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 26, 2020 at 01:16:52PM +0200, Thomas Gleixner wrote:
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > Devices on the VMD bus use their own MSI irq domain, but it is not
> > > distinguishable from regular PCI/MSI irq domains. This is required
> > > to exclude VMD devices from getting the irq domain pointer set by
> > > interrupt remapping.
> > > 
> > > Override the default bus token.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >  drivers/pci/controller/vmd.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -579,6 +579,12 @@ static int vmd_enable_domain(struct vmd_
> > >  		return -ENODEV;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Override the irq domain bus token so the domain can be distinguished
> > > +	 * from a regular PCI/MSI domain.
> > > +	 */
> > > +	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
> > > +
> > 
> > Having the non-transparent-bridge hold a MSI table and
> > multiplex/de-multiplex IRQs looks like another good use case for
> > something close to pci_subdevice_msi_create_irq_domain()?
> > 
> > If each device could have its own internal MSI-X table programmed
> > properly things would work alot better. Disable capture/remap of the
> > MSI range in the NTB.

> We can disable the capture and remap in newer devices so we don't even
> need the irq domain.

You'd still need an irq domain, it just comes from
pci_subdevice_msi_create_irq_domain() instead of internal to this
driver.

> I would however like to determine if the MSI data bits could be used
> for individual devices to have the IRQ domain subsystem demultiplex the
> virq from that and eliminate the IRQ list iteration.

Yes, exactly. This new pci_subdevice_msi_create_irq_domain() creates
*proper* fully functional interrupts, no need for any IRQ handler in
this driver.

> A concern I have about that scheme is virtualization as I think those
> bits are used to route to the virtual vector.

It should be fine with this patch series, consult with Megha how
virtualization is working with IDXD/etc

Jason
