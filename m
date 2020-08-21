Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4525724D54B
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHUMqJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 08:46:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1294 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUMqF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 08:46:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3fc1d10000>; Fri, 21 Aug 2020 05:45:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 05:46:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Aug 2020 05:46:04 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Aug
 2020 12:45:50 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 21 Aug 2020 12:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py9ewiDH8EpfOU/AGCbhXdH876ONWFt9/IJp2y78uyzcc9bvi/OYw3HhLNdbHgPnDtT46XJSkhQ/EnIToSrGgwbfbVHR7EGZAJai+9wk8XMHMnFeQVycyzKeCmRQxqGrp2hku5bm+jHrxdlltkJt1XJ38s+JSK6S216wZuLChNij4WjdqjSw1NuJGOgQzfWfJdukKRbplhwIZMXHXdbUiB3Il6vVZq4Hfmk4f9Szuc9G6xpR5s/skhU1O+a1FzYabtKzL6i6k8V22Rg2y5XTF0MtxvAU11cUjafthVS7hyz5ocAApuPjiuZuW7OSeU4SP2DGrmraRtN2FpEw4aYr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/r45NtRV2mWSwf7qjxe4p+L5bNQhEDLKcj6MRy1GZY=;
 b=evGBf2zmiTrwkGakIKRpLZJIavBoMH/xJQ39k33OJVN1lh3Hvvjn/d/KY4Mv9mvNYkWF1nF/MagKkRb6sNsBooTvNQClCHGNqkbye6CId663c0ZyAfdtL0qX1GVDzDG1zBpyHvHN0llyeHvOGLoIOO0VUOz6hEvQakPIbrpjZ1w74piCh4qur1OBvQk1CyPc0WaPvj51NuZG4WPcoZd520XlcRxv0QlpB0oxEA4U8ZFqpVODyvecbtX55w7tnj9sg3HNmapAps1B74E3ebBy1Erxq1QpjYhqw0DOg6cvxTdvEktzgQ4FabWV/tfDDenWkrQpv/lqRsS0pazwilVl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 12:45:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Fri, 21 Aug 2020
 12:45:49 +0000
Date:   Fri, 21 Aug 2020 09:45:47 -0300
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
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch RFC 38/38] irqchip: Add IMS array driver - NOT FOR MERGING
Message-ID: <20200821124547.GY1152540@nvidia.com>
References: <20200821002424.119492231@linutronix.de>
 <20200821002949.049867339@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200821002949.049867339@linutronix.de>
X-ClientProxiedBy: MN2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:208:239::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 12:45:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k96QV-00Ayig-6v; Fri, 21 Aug 2020 09:45:47 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde6f1d1-43e6-42ec-314e-08d845d02124
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB2937FEC575829A8FF4C2E77DC25B0@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTZmBqehfqmaqXdboT4a5dPhpMPqxQMk3nzOKj8aoHxyw/uxQ6H7ffv7wBIIUDVU1HNXZkFZoieh+fH87lKdrgC75kmAJ/p6BHTuv6HvwrLF0w+oAN48RL3waxEyGYBLTToRWXoLrrdEkUcyoWiKobqZfCur/80bhIY000+FmgO9lWys6XFnuEgIWSzEaDEu9S2xekROonudt36Y5PFPmUzLKH9UYFeUWhJai90MF+18P0EVLD2VQsbxbC9tOLZPmhkL7Rg1Szb527BPdKqs2y5ttw1fqLNdgqEveGhrqPK2fCNo1ZreOlAhPxbHWCr9jxO+RtbrOBHpktXjgzbIiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(54906003)(2906002)(66556008)(66476007)(5660300002)(66946007)(316002)(7416002)(9786002)(7406005)(9746002)(478600001)(6916009)(36756003)(33656002)(1076003)(4744005)(26005)(426003)(8936002)(4326008)(186003)(2616005)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xdfQ1ln1+gknfpqk+yefyLuDMQezgwh8sAvdLDdi3bRnR9+EVySYjZ32sLbqTPr3GOPyr2GT7iS4Dot4AbjnjgJiEmP6towdnAiD90MllKn4HEU0CI9vbS/IiRJ9Y5Uj7ZCewdUzQZsyvVa4N+o+mXMoXDXxxsCWAvDuW1lHlqXVitL8d+uot4qj/KDDj/NX3rGOLpGspy0+TiR2rBhNwyi4+I4NX4v3trjuqlnOUsoZwQ9zJ9cI6uK128NHu22PlGmxOLrwFwYhRR15+mXNQSxKZiaPTavOaara5mqcj3/t0gcTyqe9fi2qea3PhIBc6FKMPbaBKpjD1cV1OLyG7Z8izrwg/TZIgb19a5CsXx3aXmu3+JFz/iAJ/z5BAbQbLARTh4MoDbbLzHgf5BBTTFU6OTJGmkR02cu6F32/EaLTelFzw4DmzIcSmhr5X+RTcElJjxMf5s+VpAH8I7IGwd0HJc1ebcUNKjx/Hzzx1DCCXgEDKBlTHN2pa5de3QWsZtWS/axV4Z/IGTISH0FySR+bLt3z7n1D3JcrI+SxefwDWHO6nIa68s9a5P1ttiloCxQXclMERvpqk9vIhicgkcEQy6a55DgJusQ9Ec0KWtq1l7IVlc0NEYNpj0A+vEJw/g1NHbVzt0A/KeNwI75iZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bde6f1d1-43e6-42ec-314e-08d845d02124
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 12:45:49.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3TlBq1PIsLScvIyK33fZSmTrweg157FP0Uo29a0R88+Ej7tjaTpI2E2O9tgD4wU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598013905; bh=S/r45NtRV2mWSwf7qjxe4p+L5bNQhEDLKcj6MRy1GZY=;
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
        b=OoFeZ3zwH31c6dazGymdvgknGb81DFgIUSnvLMAkOno9B8E4DhKLCoS0MgbbVvXGX
         HsLgjVI15O7wL2ODd192xH5XW5S12JBdDBdrhSuU6gmiKlHH3S2NJ0Qh2U0d6CyxwI
         9lRB6TTzy7ndUAmLBzM0d361sx6un9I+9AYXs2HBEwvGbEguEgqg8VSGg3ITw98Xfo
         pgt0+WmMkc1o7O+088ROFed4xB30u7ERE+RJXVCPAsTe4ZEE7nmEMSMUhZaQh0F6B/
         BRpGKkqOCUX2TJkzDJrEptjte0H2deVnD1rBVn4Dz3VgQj3qlpnJ8PPrIC58AX+Xgt
         VRdvBp+7mtNWw==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 02:25:02AM +0200, Thomas Gleixner wrote:
> +static void ims_mask_irq(struct irq_data *data)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +	struct ims_array_slot __iomem *slot = desc->device_msi.priv_iomem;
> +	u32 __iomem *ctrl = &slot->ctrl;
> +
> +	iowrite32(ioread32(ctrl) & ~IMS_VECTOR_CTRL_UNMASK, ctrl);

Just to be clear, this is exactly the sort of operation we can't do
with non-MSI interrupts. For a real PCI device to execute this it
would have to keep the data on die.

I saw the idxd driver was doing something like this, I assume it
avoids trouble because it is a fake PCI device integrated with the
CPU, not on a real PCI bus?

It is really nice to see irq_domain used properly in x86!

Thanks,
Jason
