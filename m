Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53751257B66
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Aug 2020 16:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaOj7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Aug 2020 10:39:59 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6317 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaOjz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Aug 2020 10:39:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d0b8d0000>; Mon, 31 Aug 2020 07:39:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 07:39:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 07:39:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 14:39:44 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 14:39:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmr++x5+Vbf5vD1kJspOAz7AdYDTLrEq7qaDUqws1rzgSTRfHnEcCbKwKvhs5GentmccuIjW5+ilxbCygykL7wDwCg/Qc5vXO2kKvv3jWD6bVwwe0ErpAWkmmdNobnRmbfC9h/U4Rr1Anrhc6I5zI3W0zPgZDeRkvhbJyiH8Ourt8OiWocc58a94Cgj64kOtiHp9rt/8ABiebpXEUVfVN7Vv1EOVlDZUwHfYZG0RNvSfy/VmEEgBfVn4vwer8yMvG6u0dFB0VZbaAAet1qcEnngFE9VQIebeV8SuZV8T7wQYDsoBF/p/QG4IiTHjZl0vryRS3FhGygwMTT5RO+/+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtpMo07Km2SIPag4AslKp4fwjafs5NXGuZAuwMjt+fg=;
 b=B/JQ2qSnNNMvGrRuxA/sCR9ef+9jYfnMupo5CorXHvdARN1MEZz+Hb0DyIMRHE9GM9qrXhyIqgYhSNU7kDH7/Q/GBeTkVMUOYEM3FxY4KN6iY+JAJ1YCHVt19k7ISFVGnIHi6JkAd6U3DmfLn5pMQrpk2SCqEhW9t7jzP8jOIGsjjIpjmeXdJuHdzPsySvV4KQ+UqKXillP5SO/Vlvx28UvGXTY90dNwlBt+LvgcMsCZeLwAcBZmuLaZO4U2OaH27zTBJ1KRNEfSwlchfLTisXAEfzal3zek+c9dQfMFHckImwUlUKzPj0PbXQKXtMvC0Sjizey2R2ySO2FMnFaeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 14:39:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 14:39:42 +0000
Date:   Mon, 31 Aug 2020 11:39:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>, <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
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
        "Megha Dey" <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Message-ID: <20200831143940.GA1152540@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.047315047@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200826112333.047315047@linutronix.de>
X-ClientProxiedBy: BL0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:207:3d::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:207:3d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 14:39:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kCkyC-002PdM-Iv; Mon, 31 Aug 2020 11:39:40 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be9ffedb-3468-418b-02f9-08d84dbbb257
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR12MB12422A1A6F712F44B286D45BC2510@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uk16JUfslcI0kmV58qp2qxXucnTazEqlQ48EoOZFJGBmBm7AP1CXgkRLTd1erKIm2mVQ1n51956OkmtDqfMzcN1uWte6s/X5DW/Kd1G7jhQ0SnHUM42dM+bMir/OxzlT/gg2xf3v4EgYbp8dTbegrRJJ/885Cd6T3zIjGJhsBQNRcJmhWThulw3k4V6YGSVsSszKH3x63W8h6ymgeqaJ9vZ6u3XSBJMceywxBKoFrolsJAMV23YcbkpjPDB7AGAkn+McbZ+iNCPsoiBqCNtIyTNdBymo81FmScmtgg92bA3nEkwW+XHEqV6OuV/ZAmNWwFS1la8QsEseHuChw/juWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(7416002)(186003)(2906002)(4326008)(8936002)(9786002)(7406005)(9746002)(33656002)(8676002)(478600001)(36756003)(1076003)(54906003)(110136005)(26005)(66946007)(2616005)(426003)(5660300002)(66476007)(66556008)(83380400001)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: spbfQ0GQp+zMhXQ8hEtknnASP2zVAJ/yzj2o957++J3ENP/+uziF5gWpUXXdGPzgy1XG4N2koOMgvy9qIQ5dj61H7D9QoN3E5rgR5fLjRBCkkOduEko/U5ZPZYPBkzM/yrI1hx6xA0Ioii49hwUz/2muzZLVgXIm2Ovz8H4347MJba2fvbDfELRMXNA1096LInsEw8zJwUcZi0rW9UNyKh1VsNE93du99SU51qd2qHlC+SvbO9WH/ur6ev30MuPCN9fmckRp8PYXDD97BcYAu01uFwIVYU5wDRd1mD0LLYaf6h9NLPsTY/GsV2uli9xxyAlRp46MS/JwhWaf8MlIMs4zE9kt99I9VNhTRJzR86vxAC0q9A7VnCLYlsY/Pdn5X5KKx92gEbEdxBGFZJOudNOI0RJ0RkcjY/GniZ/83UdniOI93WRp3Ij/HcL0oPTDTBqqT9N3noNCI1a5HQRwaOdtGjBn8PH2e0l9GCunsX08zMtp/LQgsgDBQNWNVUscZ1mlOEazIZ/3NbS6oh2IkKYbqoEue15tzeiS/MsZbziMBVyLLDe2i5uUw5HmKJPUQMwxFk/E6x+mzHRAw/Mb0a/qjx7c8PxIR6ZjYoUnmZxrPJqGTNC6iASbVgO68G6JaQjUNJFpRYsXEMDDUEfhSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: be9ffedb-3468-418b-02f9-08d84dbbb257
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:39:42.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqLtL18jBG5zGvqm6J8O/WuT/CP52glkHZAeq4W8lA+IOD2RhvR+U4RT9CJdc3yK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598884749; bh=CtpMo07Km2SIPag4AslKp4fwjafs5NXGuZAuwMjt+fg=;
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
        b=jnuDORv6yIJSuAq1yn5XdAk7UHVLehs5OHxMMifKRFHUljG++BY2rH5/UwjMi4eVa
         SUNIFwrq+5yBTbLV+Ihii+1yAofOBU4RLoJgzwZTCffltNZ6NFhadaQPUJTrO76b3h
         rbjBP5bG5+7zdB4qJD+4FGtNRk9mqF/6LtpYnAUbm1Bonl4kTjVEdoHCa3I/zYpbkK
         stI9wpatUsH4Rjge8Dnzw2W+lEhuzOmQm5vHI+Amhpf0ENUM29Pzrliz4sgyOAp/Lc
         zZCtQ1tgkDyPqHhUbUKVjKf6fcTUNYySsOdJqz86h9jqy2fgaInUSHVyX08g5ukg4b
         IDpCeszqT7FNA==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 26, 2020 at 01:16:52PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Devices on the VMD bus use their own MSI irq domain, but it is not
> distinguishable from regular PCI/MSI irq domains. This is required
> to exclude VMD devices from getting the irq domain pointer set by
> interrupt remapping.
> 
> Override the default bus token.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>  drivers/pci/controller/vmd.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> +++ b/drivers/pci/controller/vmd.c
> @@ -579,6 +579,12 @@ static int vmd_enable_domain(struct vmd_
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * Override the irq domain bus token so the domain can be distinguished
> +	 * from a regular PCI/MSI domain.
> +	 */
> +	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
> +

Having the non-transparent-bridge hold a MSI table and
multiplex/de-multiplex IRQs looks like another good use case for
something close to pci_subdevice_msi_create_irq_domain()?

If each device could have its own internal MSI-X table programmed
properly things would work alot better. Disable capture/remap of the
MSI range in the NTB.

Then each device could have a proper non-multiplexed interrupt
delivered to the CPU.. Affinity would work properly, no need to share
IRQs (eg vmd_irq() goes away)/etc.

Something for the VMD maintainers to think about at least.

As I hear more about NTB these days a full MSI scheme for NTB seems
interesting to have in the PCI-E core code..

Jason
