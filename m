Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB35B24E1FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 22:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHUURW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 16:17:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12310 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUURV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 16:17:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f402b93000b>; Fri, 21 Aug 2020 13:16:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 13:17:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 13:17:19 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Aug
 2020 20:17:08 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 21 Aug 2020 20:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR7Xpru97F6nduJ4BtQdYjdQak2cHmXTpJh6EvJQGhWdUJoGARO+FSxAWxb3HYLUYDOS2MKy2C9YskvjsA3lQ0AlNXHbFqeVCgvc7qsNUEti8pryEeKOBiwmRQxsPYC244dgkpWhuUiFLbhUTuqN1yFzpd2DFDEE1/mvuHsN7REIZDmpyqF8Ci3/cSQSXSTBPi8L14fCj923j283pSvk9D7rNwn9Iv1sh9jscv86+krgxEWfy3wHGIXPc6trUJEy6ZjIFoKS085OT+Rkct0UNAiLA2CU+VejapPdKlTTiRNOp4xktATILSQpaThSwkJu0W+wjE8rNpWWOFBL/akqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FzrAeRKkTAlshpGx4nH9RAtEQFJEfpjazIyCB62c/0=;
 b=EGFtEKb2uH/g7zSIbnWTUqLe/CZBieBrlAwiXtXmyIZZsLjhWEdzlBdQ/1hGFOJXoqB/obSBP+gi0vyJtn5MZ32I72F0nH5KEXrq71/MXXLsPWD2tK3LVKS2vGC9pGqtj5JMSyVc1BAybpmZaL3jK96wQZ5eDBYuXe/5/MY6Gf6AnfKWXkdkytNNeT0IJCZGECAFmhej894r9P+ZihU8zzQPhib4JY8vDE5gq1rC2rmu2yqiuiO0OzROj72eGm+9nBrrnqvuJMRCMGRu8s5ctbGNIyoMIpYTAUhFS8YPdJxWkdfPUWdM8dw0O8Yrm5A60xciBZ4Z4VUv/KjsiFV8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Fri, 21 Aug 2020 20:17:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Fri, 21 Aug 2020
 20:17:07 +0000
Date:   Fri, 21 Aug 2020 17:17:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Jon Derrick" <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        "Dimitri Sivanich" <sivanich@hpe.com>, Russ Anderson <rja@hpe.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
Message-ID: <20200821201705.GA2811871@nvidia.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002949.049867339@linutronix.de>
 <20200821124547.GY1152540@nvidia.com>
 <874kovsrvk.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874kovsrvk.fsf@nanos.tec.linutronix.de>
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Fri, 21 Aug 2020 20:17:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k9DTF-00BnuH-BO; Fri, 21 Aug 2020 17:17:05 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66af5ceb-021d-40f8-09fd-08d8460f2cfc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657A5DE49BB3B02838F0501C25B0@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yz1JLEaIrmGLzwVK+h/BT+vZULXC4APpFsf6OWNrVJ9E79XYAcHLwrXhZ3+OLsAl3t+0KYq2mOVWGMNnvUBSYtD7us5O2DNBJN7TWXpm+IQzV8m8gJNQ0b3fdqp8b8QFi9HO7ghstekUFOqkxx4w2h0cUmu1D6DBkUDtWF5Q3nzcznjnNdOLl2q4mJ2WmEPb3zeTcyCZP5W0OMD7pPB94Dboix4CtM2EWHXchaOWtdnWtP4thIMz1pcx2oCwOfqFl+A0jvYeLSSNPvW7w45EDXmWUgIcLnln9tXPwnM1ts7luaZ9PvzAsdu+APDEy2ZtHPT0G+dWtdmbUFf8tRSt7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(1076003)(9786002)(8936002)(54906003)(9746002)(33656002)(478600001)(36756003)(86362001)(83380400001)(8676002)(4326008)(7416002)(426003)(2906002)(5660300002)(6916009)(186003)(66946007)(66556008)(316002)(26005)(7406005)(2616005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XD65o8Ef7UIiIiSto0Mxl+9d4LqU70ECCGf/0FM1HCH8mTb3YC6xtIxC4rlM2Aa/EMnsM76Ow6I7b+fm2ptK2pCVPmRIcYkGM3/WO6UEDVsyZzF8uf4ETUwpc4c2R8AzH1UHv722xmDhN2X/CkKlw4QGdL2iN9Kbh/AJqMhhbpL5xv4JfiYm2YhgmkS5boBBBO+NyYSX6k1zOq52wBvifxX2ljhvKPXshiHHcFxqcETlEPb4TLKgXnd3n13WIokOuUHrMjiAWpIR+LFjUXdhvId21dbOP8nFSGmxpG7AwXRu6jUMdr8yyKxC6n3cwJLR30zj3rzYKr2o/FdYtK77v2xpY/GcQ6soxnElREN2SeJqTTVO128Zh8dWeQ9dZ09H4g6g+hKSB3nyZm2GpvHBvXUxRWLo2Vg6utiamZj2nRU29GihnGNXl8txeTqbDhO6j7isQCUCZCTYZL7EEreuvSjCxDvulNKy0TqdS5/tWxbaDPMw2LMl7usII1SGpiuijS8utKH3Nm4HhmxRd94pFWIEoGud7RrSljCyS8+CYzvNb3Fhb2ecLIAMuJWtDyxFg9JKvdkXPXxs/NLhIgWBfAlyCPaaWonGMu27W12ozx/4hMaLO8lOuFkhIz8ZDuAykASyZ3yi8Xj+SqV+gK68lw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66af5ceb-021d-40f8-09fd-08d8460f2cfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 20:17:07.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYDw504sAdZ0DXMFpkjZw0jIX5+3RS821w0xk2hPzhhNBXl7GWHKnNBk2qkJfpWZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598040979; bh=9FzrAeRKkTAlshpGx4nH9RAtEQFJEfpjazIyCB62c/0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-LD-Processed:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=TykZYf9a6DryhkIr2sWr1kQpzaPWT21NOCyj1+ineECIyAxd3Su4T/GWVcH2an0Ju
         WAIgRYBVw5k3581TF02HX+B/0nwfbrNwdCzI9RdoWf1AwmaVkIOKnGjpgESO7kGqyh
         OQ+vtlgWRuWGGG5dxUr/UTExgZ/8oN9fctNc9DX8FDghy2Rh4MeeYYaUzMnebGazP/
         zmAGcitmd78GNP29zIYyrxZAEksnYWLdlywH/ao94z5Q0Qz80EWkc2FJy8noCyE3OX
         9A905Rf7qQP9I0nEZTcYOMl+38dNL1mpNOgogrtoufRh8YbHSwdoOCO6WfBUVtJqyo
         WCpJEJKT4HX1w==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 09:47:43PM +0200, Thomas Gleixner wrote:
> On Fri, Aug 21 2020 at 09:45, Jason Gunthorpe wrote:
> > On Fri, Aug 21, 2020 at 02:25:02AM +0200, Thomas Gleixner wrote:
> >> +static void ims_mask_irq(struct irq_data *data)
> >> +{
> >> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> >> +	struct ims_array_slot __iomem *slot = desc->device_msi.priv_iomem;
> >> +	u32 __iomem *ctrl = &slot->ctrl;
> >> +
> >> +	iowrite32(ioread32(ctrl) & ~IMS_VECTOR_CTRL_UNMASK, ctrl);
> >
> > Just to be clear, this is exactly the sort of operation we can't do
> > with non-MSI interrupts. For a real PCI device to execute this it
> > would have to keep the data on die.
> 
> We means NVIDIA and your new device, right?

We'd like to use this in the current Mellanox NIC HW, eg the mlx5
driver. (NVIDIA acquired Mellanox recently)

> So if I understand correctly then the queue memory where the MSI
> descriptor sits is in RAM.

Yes, IMHO that is the whole point of this 'IMS' stuff. If devices
could have enough on-die memory then they could just use really big
MSI-X tables. Currently due to on-die memory constraints mlx5 is
limited to a few hundred MSI-X vectors.

Since MSI-X tables are exposed via MMIO they can't be 'swapped' to
RAM.

Moving away from MSI-X's MMIO access model allows them to be swapped
to RAM. The cost is that accessing them for update is a
command/response operation not a MMIO operation.

The HW is already swapping the queues causing the interrupts to RAM,
so adding a bit of additional data to store the MSI addr/data is
reasonable.

To give some sense, a 'working set' for the NIC device in some cases
can be hundreds of megabytes of data. System RAM is used to store
this, and precious on-die memory holds some dynamic active set, much
like a processor cache.

> How is that supposed to work if interrupt remapping is disabled?

The best we can do is issue a command to the device and spin/sleep
until completion. The device will serialize everything internally.

If the device has died the driver has code to detect and trigger a
PCI function reset which will definitely stop the interrupt.

So, the implementation of these functions would be to push any change
onto a command queue, trigger the device to DMA the command, spin/sleep
until the device returns a response and then continue on. If the
device doesn't return a response in a time window then trigger a WQ to
do a full device reset.

The spin/sleep is only needed if the update has to be synchronous, so
things like rebalancing could just push the rebalancing work and
immediately return.

> If interrupt remapping is enabled then both are trivial because then the
> irq chip can delegate everything to the parent chip, i.e. the remapping
> unit.

I did like this notion that IRQ remapping could avoid the overhead of
spin/spleep. Most of the use cases we have for this will require the
IOMMU anyhow.

> > I saw the idxd driver was doing something like this, I assume it
> > avoids trouble because it is a fake PCI device integrated with the
> > CPU, not on a real PCI bus?
> 
> That's how it is implemented as far as I understood the patches. It's
> device memory therefore iowrite32().

I don't know anything about idxd.. Given the scale of interrupt need I
assumed the idxd HW had some hidden swapping to RAM. 

Since it is on-die with the CPU there are a bunch of ways I could
imagine Intel could make MMIO triggered swapping work that are not
available to a true PCI-E device.

Jason
