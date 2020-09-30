Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66F27F18E
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgI3SsQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 14:48:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13008 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3SsQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 14:48:16 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f74d2e10003>; Wed, 30 Sep 2020 11:48:01 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 18:48:01 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 18:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFKFJ522L2K3NKKekbd7Xexje1LwW+tdbebuZl2r8cmn2hWq30APxFjX5SFKD9LvsqJrheeWQKyg1zBOjEZDbCYiIiGPdtsbzxsLhFd7VSIY4ldqvZyyTW/YMTpoBpGSTyebMfuiPuXEwmwZYOLSTin6OQr0iBj47zmeAM3SAEstPOAYZbcC8Muu9gnOCGnHVeJSLq8ZVCSVM4vR/d6Y1p5c4HKShXi1FH4Lv4cpkLWkUEOvOsv4+9aaq3rsmsHFylgVTrUs8wptjCLtve8LLaXLAjg7l8SqkfJ4ACmkKWpGWABmG27mBQibW3dwZcorgP9a7M9MJsc/yeAJ4piY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH2xIbjwd+K0IVVyMbcHdCkr4lTYL7oK9z/oNdMIMes=;
 b=W3N7/kizjs87GIFQsjB60Jf8BNEvRteaJWRYja9byCr/DTKPeeqAZ3vlWKs/1CwcA7a8HGt8yedODr93NLaauN1EC/h9iVNJH3irsFMwhEHzzsTwHqvABmXQr3+xkH2IfHhujrNH9dmQ9T6QxQ4cYu13j6gxexvhq9VlYQ6SpNfFgShkgT99G1zMHtUUF4aMq0Mvt1H87tYyufhk/RTrJCNlYKptZzCkeMPetreYZgNtYvYvu96TbDulBQbEuDrbPIEBvAopfJYfQmHriDDEURLfQ9fbAOmK3u0kD0NfcmBh5NMJdolmWvzA26CI63tkzKNDfEfutoMUtSA+P8fZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Wed, 30 Sep
 2020 18:47:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 18:47:57 +0000
Date:   Wed, 30 Sep 2020 15:47:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "sivanich@hpe.com" <sivanich@hpe.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lu, Baolu" <baolu.lu@intel.com>,
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
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Message-ID: <20200930184755.GS816047@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.047315047@linutronix.de>
 <20200831143940.GA1152540@nvidia.com>
 <1d284a478d4e5bf4a247ee83afa1b8b45f9e1b3f.camel@intel.com>
 <20200930125733.GI816047@nvidia.com>
 <97a8605902a7ee9f17af471458d1fe3029f2ad20.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <97a8605902a7ee9f17af471458d1fe3029f2ad20.camel@intel.com>
X-ClientProxiedBy: MN2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:208:239::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:208:239::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Wed, 30 Sep 2020 18:47:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNh8t-004KlL-BA; Wed, 30 Sep 2020 15:47:55 -0300
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601491681; bh=uH2xIbjwd+K0IVVyMbcHdCkr4lTYL7oK9z/oNdMIMes=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-LD-Processed;
        b=sEwBpB9DmrQB8hhHEgDiIP/Bn8JrOqGZyYNm8LsIuR7+p0ECMKysso2IHcXdL9Ptd
         Fyn/UoGY1QBapTDBZYrwH3LzcKDtM6AyZAWN3nOuVBPMxiQPtstC9/S6ds56SPsC0a
         GTPgmXx/303x0wa7Mub4lYqE2Q7OqdRzGTV6HuTGR2SwQsshqZgvHM+je1ZzUXXRQ8
         ZsX7iC1CxqoQqndWkp96I65Af5pXK90SqRe8I/9hkxMJE6TVFRd48HyY2vps3bD70T
         BAhL1SGLRMlb/OzTfPsBBSBYAedtcm4TbKVV4nj12E7zh8DkswOMuF5U4S4pyweOLe
         DMMtWh5SVmR4w==
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 30, 2020 at 01:08:27PM +0000, Derrick, Jonathan wrote:
> +Megha
> 
> On Wed, 2020-09-30 at 09:57 -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 30, 2020 at 12:45:30PM +0000, Derrick, Jonathan wrote:
> > > Hi Jason
> > > 
> > > On Mon, 2020-08-31 at 11:39 -0300, Jason Gunthorpe wrote:
> > > > On Wed, Aug 26, 2020 at 01:16:52PM +0200, Thomas Gleixner wrote:
> > > > > From: Thomas Gleixner <tglx@linutronix.de>
> > > > > 
> > > > > Devices on the VMD bus use their own MSI irq domain, but it is not
> > > > > distinguishable from regular PCI/MSI irq domains. This is required
> > > > > to exclude VMD devices from getting the irq domain pointer set by
> > > > > interrupt remapping.
> > > > > 
> > > > > Override the default bus token.
> > > > > 
> > > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > >  drivers/pci/controller/vmd.c |    6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > > 
> > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > @@ -579,6 +579,12 @@ static int vmd_enable_domain(struct vmd_
> > > > >  		return -ENODEV;
> > > > >  	}
> > > > >  
> > > > > +	/*
> > > > > +	 * Override the irq domain bus token so the domain can be distinguished
> > > > > +	 * from a regular PCI/MSI domain.
> > > > > +	 */
> > > > > +	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
> > > > > +
> > > > 
> > > > Having the non-transparent-bridge hold a MSI table and
> > > > multiplex/de-multiplex IRQs looks like another good use case for
> > > > something close to pci_subdevice_msi_create_irq_domain()?
> > > > 
> > > > If each device could have its own internal MSI-X table programmed
> > > > properly things would work alot better. Disable capture/remap of the
> > > > MSI range in the NTB.
> > > We can disable the capture and remap in newer devices so we don't even
> > > need the irq domain.
> > 
> > You'd still need an irq domain, it just comes from
> > pci_subdevice_msi_create_irq_domain() instead of internal to this
> > driver.
> I have this set which disables remapping and bypasses the creation of
> the IRQ domain:
> https://patchwork.ozlabs.org/project/linux-pci/list/?series=192936

After Thomas's series VMD needs to supply a hierarchical IRQ domain to
get the correct PCI originator. This instead of the x86 patch in that
series. I think that domain should be created by
pci_subdevice_msi_create_irq_domain(), at least I'd start there.

Jason
