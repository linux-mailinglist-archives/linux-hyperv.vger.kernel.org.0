Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4EC255AA6
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 14:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgH1Myn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 08:54:43 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12042 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgH1Myd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 08:54:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f48fe4f0000>; Fri, 28 Aug 2020 05:53:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Aug 2020 05:54:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Aug 2020 05:54:19 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 12:54:06 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 28 Aug 2020 12:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIxyLcwohxDqu0MxMWLcbxcZb7VW4eYE2xXcH6s4ni2VIyyKj6TkIH7f2wCcrQoeM3xmFeiZ53WR2pGYgsBJWGzPpZGEvrQBc/iiaEc2pUkWda/lXxUb7Ogp6372ggFoWGp3bdHWZahwdzWSuMSsPY/FCFWw0xLOw5cddZMsiCkyNNLUeAEjfHqY0XMvY+nBwrSLqsqfevfdx+743Y78iaBecHiV4OoFyNEZ6itlgI7EakUVfESnWk9evGcNUkOB1qclzdRTlTyXif6uN5tH16nqomuWrgUdG7IUgngdR1OVGh8702pCSWI0KNNraEZ6ze3z35hkPiX8Ueitwy6YcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV68vSrNC9se5jzAxDi47xoA7ucOBEGcpYcUqXTypis=;
 b=OI/QeSDEjnfShrAMrIr9+ZIgKToGlF/BMSuyjYpmx/AbVYapqNPQXjR2+QZ6t8bVO9p+LVWHB4x2BpH0kyvg6wdLCm5B2/7T0w5m7tr4lnbUPC9H7MbB8GuMuQKGi3D+vBRpINXxMcWU53LpDMGzT2BXDZpz3i/fka/df/ZbmD0fhiz1Ry1PUDQZEZ7lYb1L0xXEA7mZ9B4SbDi3tJS9pmdN/G5UPs7uMzTQgmatJWDmjXKPxjzZY+3gMYUQVutdA88RhlNaPCCyf53CfEHWWbUcXMMGW7rNIolsoJORrCfKKV5HI/8nqxwfVONGpTq/8SsMB3bhonazHaNzPXScsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 12:54:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 12:54:05 +0000
Date:   Fri, 28 Aug 2020 09:54:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
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
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
Message-ID: <20200828125403.GR1152540@nvidia.com>
References: <20200826112333.992429909@linutronix.de>
 <20200827182040.GA2049623@bjorn-Precision-5520>
 <20200828112142.GA14208@e121166-lin.cambridge.arm.com>
 <20200828121944.GQ1152540@nvidia.com>
 <0cc8bfd9258dfc507585fd0f19a945e3@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0cc8bfd9258dfc507585fd0f19a945e3@kernel.org>
X-ClientProxiedBy: MN2PR19CA0057.namprd19.prod.outlook.com
 (2603:10b6:208:19b::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0057.namprd19.prod.outlook.com (2603:10b6:208:19b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 12:54:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBdtL-000S41-Nn; Fri, 28 Aug 2020 09:54:03 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d581baf4-370b-4be9-e186-08d84b5171d1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203C10F9A0026FA765135F7C2520@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99qg/bsIPqkeKS7ryrP4eqAxd56hw+Ylq/tweF+dab3EBvIkaLviTgN6iglzJ5OsZOKlo/5c9DaBYyV3FconsXmq0HJDTBNVszdqgHaLxrdx80gVV9RaQUC6rOvi8aXBbMUezdePcc2NOvqkjZODagPSVaMzbDVHpMx/AxOa1x6V5Ag9Wq5BpZeH6ZdFZJIWHhsbpyomPgWmdQL63/XWJR8ctcmOzF3cdkdY/Mn2uNTauTK45CE3QKDZ63adUKXhMAmpdhlCuia5v1F3OX6StyQcqf0ismuqOg40S48W5nzx9AKkZWmNCMg3bLb4TOlgo4y8r3vlH6K/5T4QIA8kQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(8676002)(66556008)(66476007)(426003)(186003)(478600001)(6916009)(7416002)(5660300002)(7406005)(9786002)(36756003)(9746002)(316002)(26005)(2616005)(4744005)(1076003)(86362001)(54906003)(66946007)(2906002)(8936002)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VsJyEC5KTaLbmpkQg6kW5X/Yid3P8Z9gSpq5BWGR/iGVLiAUD8Vso0j+6CPHoi2G+j3rV0OaO+vnv4E4AAijDXuONSZMdFkOtWoZfOEzKZwhHmetBaxh3WKUNSIfBUSEJaazsWLGXbdwqwGZP+kxwUbGsLKR025LJi4hOCRHS0hXcIFuDGhClMxryTChldEQ6WPzyt91cFKwXvS51dEvGUGpSBo/8rgyyrItvlFyWuHtwenaAQDhetEltotg2/gZtR9D+IX6SAR50x4iZGI5vwCMqRNsAtAD2rDAKIwoxYA3I2SoEp5cLF0UCsEu5TJn6ET4NEkwT/PH9b7oXYcEqna+76UbmYuu2ninY0zrv62dyWldESfiYmf9MPu5+DuFGxvlTs7sUFR4s1HHDzDJ+dpfJc4fdLbexNihzZE13gEq8f9bIkHG85ovNxfNluwc4N3YRYW5WBcyWjQ7nKNK8mvEgiD8IsZ/eIDwFQPWYpffAOLo0Ui3KBs1JavnmhK1zB1GZAIFci56uDtWFj4HYomHjatYnsFFV6dKSeo4qJVlgD8hilOjSnEJowdgxw/Y/a4rjkbC91lb7M+JTFVMgBXVoozZkJDXLhAwP+8exjh0kgQ3wKJsa2nZL5dyuKgBnQ3Vhcrck7Z94OaSF9FJ1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d581baf4-370b-4be9-e186-08d84b5171d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 12:54:04.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnNGus0RZDrUE5Se7xNKVvFs7SideYLF5oKLxSj7NaTAVEaFKVdLLcsoZRrqebIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598619215; bh=qV68vSrNC9se5jzAxDi47xoA7ucOBEGcpYcUqXTypis=;
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
        b=H3QonVVqVNaGYeE6xB/Wi1aG2QYbpmwGQd11p/xq8ciXwvdVmAQ85KXYflMU90x2Y
         uyXEIPduLJj6Sn80HH0S31oPsjAHLoNvpcI5jFUteresOmLY2GqTZHHGZEqfmGorOG
         j7odn6teWF4uj1bTGdQblWF60gBfmSrdAASdgs15hS76HaPOpCRr5ABFYPYmJR9Eu9
         x/rahSsbA4iIOfsN3gdaaFxRPNwxt3ABWvAMyNIv3gaB/SnqUNiaZEiGorgqT2cG2/
         LDL75Y767C0MJW+Fe8JriW5eMmlDKdw2pTz+Gua4UG1jxt7KfkSHNibXNa/7VCPUyz
         xJDY5yrlyCg/Q==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 28, 2020 at 01:47:59PM +0100, Marc Zyngier wrote:

> > So the arch_setup_msi_irq/etc is not really an arch hook, but some
> > infrastructure to support those 4 PCI root port drivers.
> 
> I happen to have a *really old* patch addressing Tegra [1], which
> I was never able to test (no HW). Rebasing it shouldn't be too hard,
> and maybe you can find someone internally willing to give it a spin?

Sure, that helps a bunch, I will ask internally if someone in that BU
can take a look.

Thanks,
Jason
