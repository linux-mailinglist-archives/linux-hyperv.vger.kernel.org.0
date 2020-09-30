Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4A627E7CA
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgI3LnV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 07:43:21 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24311 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3LnU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 07:43:20 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f746f550000>; Wed, 30 Sep 2020 19:43:17 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 11:43:05 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 11:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAHVpach2WYpBrX7bBNfX2SGGy1+cnUCSq0QPfO8RqEJnTo2B6aBwe+MSQ57TGv/981kRQojIBOoMt7yuMguw2Kp5woH1njWSncI8oDfknTIJwdqH2jRA7+wTCkP2+AQVZFwNCFDvCEj1IRJK7vP/GDgwCBNJnVdSdASsdxzPcB8HCqDxR+SLRetk5qcZiPK1nhaTg67XQO/dnLp1eUj8A8ErX0r8Z1kMGv0rd26MZZnTe1hl1UwuTpVA0Tvr23leGuf19KOjyx4ZsaJcJ2DT13mzmLSkXOc1Wkv2vOcA/qNFoGKrFBVmybOi4hngZMvkglRI8qybsbWfn2RFsHGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifDjfXqbQdEToOzcs0qsNuogLb2HLWyKHTQc87/3Ewc=;
 b=GeC4vJWbfjTvUobe+GD7bOGykQaBOHH9lRECgxQuxmBz12RecnpK0daGWL/nq+UA1YjrfFHbvdi+geu9xiLDM2UFIseLWBWZYeg7EYre4CKvrFEJc/Jk0id23iLCbkpwZYjdydGccgoFaSWHhmQZekjrIUnXC6eA0yjnt5fIBL44pomxvYhSNTjTaU3GfCsB/VE3U6YoQ8JWlrPiQ9QxZC0NPmH308QDm1m2EkXgszZiBEFC/nbVG6lDlrUsipDlyAsmxlgi8wPzaI3NKn5QcGELBMWyX+7KDU2Xp7Jjn9IQWbfhb+rrutv5oJ0DZpRhhjf6na7Yl8Tjoo0tYcpwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 30 Sep
 2020 11:43:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 11:43:02 +0000
Date:   Wed, 30 Sep 2020 08:43:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Dey, Megha" <megha.dey@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-hyperv@vger.kernel.org>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Russ Anderson" <rja@hpe.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        "Kevin Tian" <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <ravi.v.shankar@intel.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
Message-ID: <20200930114301.GD816047@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
 <87v9fvix5f.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v9fvix5f.fsf@nanos.tec.linutronix.de>
X-ClientProxiedBy: BL0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:207:3c::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Wed, 30 Sep 2020 11:43:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNaVh-003vDf-1s; Wed, 30 Sep 2020 08:43:01 -0300
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601466197; bh=ifDjfXqbQdEToOzcs0qsNuogLb2HLWyKHTQc87/3Ewc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-LD-Processed;
        b=kXLhM/c+6HLgKm+6ble3lfNqOcCNe2qhFpXxYQ9VNpltIzypeid1VYh+BMxlOLlye
         0+6VDWOyOvDf07+xZGAec4Wvn8k5WI3aiZoShq7j1qgKIq7qgusR0iXtwcLQk/xdjz
         +v2330h6r9nb93xOefwM7I/qvuhlV7upcanj1FwilxBqKMT7QRH5pMZ7ET2aXWd8p8
         pK/mYHKsauGX6pIvk6Q2HPDPYGpXdDmMnGHCOc+5/StKJ5sjO489/p+d/uJSwbbRw0
         QSJd7JK+1Rwde8F4fsYoj/S1iGRvpbBC/PZ0KlECf5FCeVBwjrsxHssfpqgfmeqxU4
         fyKeGy0g3j+zQ==
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 30, 2020 at 08:41:48AM +0200, Thomas Gleixner wrote:
> On Tue, Sep 29 2020 at 16:03, Megha Dey wrote:
> > On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
> >> #9	is obviously just for the folks interested in IMS
> >>
> >
> > I see that the tip tree (as of 9/29) has most of these patches but 
> > notice that the DEV_MSI related patches
> >
> > haven't made it. I have tested the tip tree(x86/irq branch) with your
> > DEV_MSI infra patches and our IMS patches with the IDXD driver and was
> 
> Your IMS patches? Why do you need something special again?
> 
> > wondering if we should push out those patches as part of our patchset?
> 
> As I don't have any hardware to test that, I was waiting for you and
> Jason to confirm that this actually works for the two different IMS
> implementations.

How urgently do you need this? The code looked good from what I
understood. It will be a while before we have all the parts to send an
actual patch though.

We might be able to put together a mockup just to prove it

Jason
