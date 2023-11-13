Return-Path: <linux-hyperv+bounces-911-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5A7EA616
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 23:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C0DB20A28
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Nov 2023 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9A2D62A;
	Mon, 13 Nov 2023 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IpI0mj9e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32F3D3A6;
	Mon, 13 Nov 2023 22:37:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C749D50;
	Mon, 13 Nov 2023 14:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITK2z5b7nAq/RO2mdzgqQw2hy/M/a9hnRVnxbZkHSf9buhjicnC4B5XrAPML+BLWbc1K5EImWjn3ge+TZYCCNdNXw1w0A9WzRdb4Xpep8m+KCxkm4ZtcveFvUI2SjFPrrldHCMU6cMRfIvfbgw9WNB8qidYgUmF7hH96RNjNxFks49uclNQUNr1RhEGdyPF602gzmbxrMNw7XS7jyoN0/k9Qsh5IYVASDOuxOod+cjzA5WtZal2K7cnQS9XaesR2AVj8tdw2fyejIKc6hmoadrCc00ph6LT7Y4Il+s3W4wb+qhHf/u7No0B4JxRlEHLLysVbTWU9VzLK3ZT+PXNm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/taJELcCg7V1wEq+GuEv/7cZ9qKRq10wVa1YAQaXE0=;
 b=hIwIVVpSuYl2XfZ/ergW6pUPi1Tz/DQcZZL/NbfpZXsvKOPBW5Hm0WRKp9trga6Fwm8x3oGx5nMgSduQfcjdHd8rtNMDGmk0AVWAmdv+ksw1Hc8xyUEOoCmZPRneQVCEaJTxhDp19L85x2vqGsTUvARjmwNV65ksEzO6z+icy9bBX4PEdKYvgCNyq+DV/FdZsTmlse/jHdASP2lF+ETYPoeL6bba1U6NLjhLA4kd55PMR4LL7YBTGmgv+Zgf4CJKht55jzzCYkmukVPMi4xRvgGfq0LNu6YWy5OX+A9uH9LUwTt66cGPs5kobT/ZlFPiWbAy1ObhJ+tPTuxPA6PIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/taJELcCg7V1wEq+GuEv/7cZ9qKRq10wVa1YAQaXE0=;
 b=IpI0mj9eoIT3uYmds/HW5kfHIqFxoj7vX1/E5k20fVnxqkkNsjgUsmVD1za6p5aYvuJ9H93/UpsaBd77awzXAuepMpPLDm5NcXRn+hUpP0n4WPwxlGuhC3BRUTAUz2mS9PccEkJtpIxaghXQ9JPmwz3evDME+h1Mfe9/H9qhlJaQToQ60FVUyGPartTcIMxMpZTYenl2ZH/wanXK9gfLybmDWBr/3eCB7fbybyO1iJvXMka9uc8bscgijCmkFQJradiv8qElMTyavHEZMKpWS2MHC77UVPhiw94nbFOdwCnAcsZeVGmmGXckg6MU/Pl6hIUM+xuJhAAEK2uRxvCW6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 22:37:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 22:37:32 +0000
Date: Mon, 13 Nov 2023 18:37:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: acpica-devel@lists.linuxfoundation.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 10/17] acpi: Do not use dev->iommu within
 acpi_iommu_configure()
Message-ID: <ZVKlK2gf7WPx4Uza@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <ZVEO8li-WnQMXaLc@archbook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVEO8li-WnQMXaLc@archbook>
X-ClientProxiedBy: MN2PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf144e2-0c33-4c80-cafa-08dbe4991fe4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	200WVAuQ1ZHc/wUHOdTsfQMTmOYGAD90mbE0R4vfRTcgO2UN7HUdDRdk4v2f7tOI/zSc8uvtiXybtlpmBIGLu8EjWYUo893xKEQnnZAcVL+hipAsgFlzDCBt38lcu+ECyKG5iJ9yjyLL/DMNckeU8OkKk4NYG7DkPfyhqm6KDmzc56d+lR6DG0q0jBMAn1+/lOlbxURZBj9y7WlFb84/KorUDvX2TDnr43C0+fH7ORnQ2pGX9HZNivUMSvIWysQ7OZ4WEJ4cVZpKAfLmADqRifDzmCCurR0QFGvMgsur5Q/ZrYnuFQVOyOzw5x0cTXpt2T5FEsR3jY+cb8BEOxo2Syw2dT6IoGsQmE4AD/pE6xJSWB4OhexMQhTF/7kX28DoQew6eU2X4WX1Uci06KVVkCBSoy6T6gSdB21eEiGVtS/RYYhO9eaF2GJSagLtA3ldKcGQBkp+EVFtTpvF7TNDG67gLZ9EmrREtK3J+mHDH4mwYnmKFL33FhNmza911zse8QlDFPbpzaTQPT2LE1vvM4uVE/O8QauzhnVdRW9nPTed68MdA3NZMtQiY5ifiH+X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66899024)(6916009)(54906003)(66946007)(66556008)(66476007)(316002)(478600001)(6486002)(30864003)(7416002)(7406005)(86362001)(5660300002)(41300700001)(36756003)(4326008)(8676002)(2906002)(8936002)(26005)(2616005)(38100700002)(83380400001)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gl8Hj8wa0GtvvrWIaYH6/eAAaqNOAwg0Mj21dLxnA2fltsxqgnCWdfefOnaB?=
 =?us-ascii?Q?CAhQ0c7zmnP1f3b6NJ4iXtX2GiMPXh+w1KdP6UKJYR1F0pyVUUcTw5H1UWGH?=
 =?us-ascii?Q?Suu/EmradJvrDtaTyhIEzj0yTJTm4DZ1sFAKVLx3ZbSjxerjeoMGmg1oaxVE?=
 =?us-ascii?Q?i11cLAsvEXMXcwMZ/882+5xMDnZdvqt9nX/kqQUas2oizyBSEczoXJuGbars?=
 =?us-ascii?Q?PqM4WbisCO/EyVOHjia0tTyzmLNzrqvwiXiWiIhfe2dbck/ijURbSMoBrDSr?=
 =?us-ascii?Q?pJeYk2AaQn89tEkCrS3DNLG6eQb2tuj2y+ni54Cl8np5PA9qgJEuP1FrOvkJ?=
 =?us-ascii?Q?SnYPCa/4zziSgw6sZSyCmMd1Ra4wyk951InX7kyskiFK3uqxbvwlnamShTlC?=
 =?us-ascii?Q?l8MoGGwAMOnvgc/j1SEzUizvbS2zDMT2tve9L40RqVpk+4fVEy2n3kDYpQwO?=
 =?us-ascii?Q?WkFbH/LOlr6y8dWMiSAMs3tw+zDm1a0JV1FCi9KPa1F7bIK3yeOVCy2dkBNO?=
 =?us-ascii?Q?yI6JcLziFgm0XthD5mfjXroygP+MwRzolzjC2n2qulwLr9QRaT85USt1Q44C?=
 =?us-ascii?Q?TQB6WSx9cn9Mg5LHdi+TEgu2ss6JcYoXQCCs+X66Q2jOKSMRMIfhV9V+5xFs?=
 =?us-ascii?Q?Dj6lBRs4ClwNzWYLVH9nu0eCyurFJNFEyDg9SyMfxCDXlV7x5FLvYQF5wP2J?=
 =?us-ascii?Q?lvhtPnh56D1d9V1zmOy1oG5+ODdKpxJM6/F/SdRLGzYjzZizh9XIROkGr8JC?=
 =?us-ascii?Q?bhUkxzl452jjUP8JeU65Ud7yF0nSX/7Eu8Avnqob6bAKrxzXvy49UDsC9BR5?=
 =?us-ascii?Q?kYH4rtXZxdH0EOTiqiO/PftgUJa1H7xeGV7BGNlEB3Phkh8kdPTjx5ZwUDSP?=
 =?us-ascii?Q?4R0w7Rcuu8Q6zCoRerEEhrS7iNBcq83EWYR5ueaaawXMq19VEipUT5QlY8En?=
 =?us-ascii?Q?h/R0X7tSc08t2vVIQbA4wQYcEndsqWVXQPFAL1nVRWo4LR0KAhg4qZYQKVEy?=
 =?us-ascii?Q?0i1KenUCTrK9E2fJcDhZAHgcpO59kwzcKwu8MxxHRspQodNntgY6lfVEq2gz?=
 =?us-ascii?Q?yjb6dxVN4KiKXnmaDmg2WXG20OtOS9Lqjs/Kzujm3WQ1/Cr3YYSUsn47TVOs?=
 =?us-ascii?Q?6pD+36XasesHL6PlNbB17bl0hu9Teowl6GjbEoIZBQDXA7sJ6MwFSZrG0Ted?=
 =?us-ascii?Q?o9i/flEuyH7rDUVZ4o3AHW9GQkEnGD8hjU4gPcWDLCNNBACNNETh7/JhM8Sa?=
 =?us-ascii?Q?wxaoY/mMPKYKNW5k+lg3kOe6NRigB+j/hJGxu9UuDH7Mb7l3UIUyaEbExl49?=
 =?us-ascii?Q?DBngk1v6emyeqTd8Fy/HqZchg3Q3OrCCzBGjj5faMV4cIQkxctYDW3SXXXmN?=
 =?us-ascii?Q?6Bx4NOs34fHMiJF56qguFSo/NYAthWSnpB9OxtTB/LQC9RZk4+PALX33hqvQ?=
 =?us-ascii?Q?mAAbR7lrILk0Zx2QFbT7BrjF0yw2QIK7O7/J/rTIOS3aFs27bFS4tw8mkP7o?=
 =?us-ascii?Q?/hP5ltg3Ame0wVL3QxoV5wssmPd1PR0V/jFUkvDTHQCfEPuNJzDkc7DkYguo?=
 =?us-ascii?Q?HHyp9tOVEWaDjxQQKSc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf144e2-0c33-4c80-cafa-08dbe4991fe4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 22:37:32.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXEgpieq49A5T323+j9ETjE8IpgN/Uir4fCsFsSAxwuOzOpwWw7kvkf5H+v/sZGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

On Sun, Nov 12, 2023 at 09:44:18AM -0800, Moritz Fischer wrote:
> On Fri, Nov 03, 2023 at 01:44:55PM -0300, Jason Gunthorpe wrote:
> > This call chain is using dev->iommu->fwspec to pass around the fwspec
> > between the three parts (acpi_iommu_configure(), acpi_iommu_fwspec_init(),
> > iommu_probe_device()).
> > 
> > However there is no locking around the accesses to dev->iommu, so this is
> > all racy.
> > 
> > Allocate a clean, local, fwspec at the start of acpu_iommu_configure(),
> Nit: s/acpu_iommu_configure/acpi_iommu_configure_id() ?

Yep

Thanks
Jason

> > pass it through all functions on the stack to fill it with data, and
> > finally pass it into iommu_probe_device_fwspec() which will load it into
> > dev->iommu under a lock.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/acpi/arm64/iort.c | 39 ++++++++---------
> >  drivers/acpi/scan.c       | 89 ++++++++++++++++++---------------------
> >  drivers/acpi/viot.c       | 44 ++++++++++---------
> >  drivers/iommu/iommu.c     |  5 +--
> >  include/acpi/acpi_bus.h   |  8 ++--
> >  include/linux/acpi_iort.h |  3 +-
> >  include/linux/acpi_viot.h |  5 ++-
> >  include/linux/iommu.h     |  2 +
> >  8 files changed, 97 insertions(+), 98 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 6496ff5a6ba20d..accd01dcfe93f5 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1218,10 +1218,9 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
> >  	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
> >  }
> >  
> > -static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
> > -			    u32 streamid)
> > +static int iort_iommu_xlate(struct iommu_fwspec *fwspec, struct device *dev,
> > +			    struct acpi_iort_node *node, u32 streamid)
> >  {
> > -	const struct iommu_ops *ops;
> >  	struct fwnode_handle *iort_fwnode;
> >  
> >  	if (!node)
> > @@ -1239,17 +1238,14 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
> >  	 * in the kernel or not, defer the IOMMU configuration
> >  	 * or just abort it.
> >  	 */
> > -	ops = iommu_ops_from_fwnode(iort_fwnode);
> > -	if (!ops)
> > -		return iort_iommu_driver_enabled(node->type) ?
> > -		       -EPROBE_DEFER : -ENODEV;
> > -
> > -	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
> > +	return acpi_iommu_fwspec_init(fwspec, dev, streamid, iort_fwnode,
> > +				      iort_iommu_driver_enabled(node->type));
> >  }
> >  
> >  struct iort_pci_alias_info {
> >  	struct device *dev;
> >  	struct acpi_iort_node *node;
> > +	struct iommu_fwspec *fwspec;
> >  };
> >  
> >  static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
> > @@ -1260,7 +1256,7 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
> >  
> >  	parent = iort_node_map_id(info->node, alias, &streamid,
> >  				  IORT_IOMMU_TYPE);
> > -	return iort_iommu_xlate(info->dev, parent, streamid);
> > +	return iort_iommu_xlate(info->fwspec, info->dev, parent, streamid);
> >  }
> >  
> >  static void iort_named_component_init(struct device *dev,
> > @@ -1280,7 +1276,8 @@ static void iort_named_component_init(struct device *dev,
> >  		dev_warn(dev, "Could not add device properties\n");
> >  }
> >  
> > -static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
> > +static int iort_nc_iommu_map(struct iommu_fwspec *fwspec, struct device *dev,
> > +			     struct acpi_iort_node *node)
> >  {
> >  	struct acpi_iort_node *parent;
> >  	int err = -ENODEV, i = 0;
> > @@ -1293,13 +1290,13 @@ static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
> >  						   i++);
> >  
> >  		if (parent)
> > -			err = iort_iommu_xlate(dev, parent, streamid);
> > +			err = iort_iommu_xlate(fwspec, dev, parent, streamid);
> >  	} while (parent && !err);
> >  
> >  	return err;
> >  }
> >  
> > -static int iort_nc_iommu_map_id(struct device *dev,
> > +static int iort_nc_iommu_map_id(struct iommu_fwspec *fwspec, struct device *dev,
> >  				struct acpi_iort_node *node,
> >  				const u32 *in_id)
> >  {
> > @@ -1308,7 +1305,7 @@ static int iort_nc_iommu_map_id(struct device *dev,
> >  
> >  	parent = iort_node_map_id(node, *in_id, &streamid, IORT_IOMMU_TYPE);
> >  	if (parent)
> > -		return iort_iommu_xlate(dev, parent, streamid);
> > +		return iort_iommu_xlate(fwspec, dev, parent, streamid);
> >  
> >  	return -ENODEV;
> >  }
> > @@ -1322,15 +1319,16 @@ static int iort_nc_iommu_map_id(struct device *dev,
> >   *
> >   * Returns: 0 on success, <0 on failure
> >   */
> > -int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> > +int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *dev,
> > +			    const u32 *id_in)
> >  {
> >  	struct acpi_iort_node *node;
> >  	int err = -ENODEV;
> >  
> >  	if (dev_is_pci(dev)) {
> > -		struct iommu_fwspec *fwspec;
> >  		struct pci_bus *bus = to_pci_dev(dev)->bus;
> > -		struct iort_pci_alias_info info = { .dev = dev };
> > +		struct iort_pci_alias_info info = { .dev = dev,
> > +						    .fwspec = fwspec };
> >  
> >  		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> >  				      iort_match_node_callback, &bus->dev);
> > @@ -1341,8 +1339,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> >  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> >  					     iort_pci_iommu_init, &info);
> >  
> > -		fwspec = dev_iommu_fwspec_get(dev);
> > -		if (fwspec && iort_pci_rc_supports_ats(node))
> > +		if (iort_pci_rc_supports_ats(node))
> >  			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> >  	} else {
> >  		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> > @@ -1350,8 +1347,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> >  		if (!node)
> >  			return -ENODEV;
> >  
> > -		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
> > -			      iort_nc_iommu_map(dev, node);
> > +		err = id_in ? iort_nc_iommu_map_id(fwspec, dev, node, id_in) :
> > +			      iort_nc_iommu_map(fwspec, dev, node);
> >  
> >  		if (!err)
> >  			iort_named_component_init(dev, node);
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index fbabde001a23a2..1e01a8e0316867 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1543,74 +1543,67 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >  }
> >  
> >  #ifdef CONFIG_IOMMU_API
> > -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> > -			   struct fwnode_handle *fwnode,
> > -			   const struct iommu_ops *ops)
> > +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
> > +			   u32 id, struct fwnode_handle *fwnode,
> > +			   bool iommu_driver_available)
> >  {
> > -	int ret = iommu_fwspec_init(dev, fwnode, ops);
> > +	int ret;
> >  
> > -	if (!ret)
> > -		ret = iommu_fwspec_add_ids(dev, &id, 1);
> > -
> > -	return ret;
> > -}
> > -
> > -static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
> > -{
> > -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > -
> > -	return fwspec ? fwspec->ops : NULL;
> > +	ret = iommu_fwspec_assign_iommu(fwspec, dev, fwnode);
> > +	if (ret) {
> > +		if (ret == -EPROBE_DEFER && !iommu_driver_available)
> > +			return -ENODEV;
> > +		return ret;
> > +	}
> > +	return iommu_fwspec_append_ids(fwspec, &id, 1);
> >  }
> >  
> >  static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
> >  {
> >  	int err;
> > -	const struct iommu_ops *ops;
> > +	struct iommu_fwspec *fwspec;
> >  
> > -	/*
> > -	 * If we already translated the fwspec there is nothing left to do,
> > -	 * return the iommu_ops.
> > -	 */
> > -	ops = acpi_iommu_fwspec_ops(dev);
> > -	if (ops)
> > -		return 0;
> > +	fwspec = iommu_fwspec_alloc();
> > +	if (IS_ERR(fwspec))
> > +		return PTR_ERR(fwspec);
> >  
> > -	err = iort_iommu_configure_id(dev, id_in);
> > -	if (err && err != -EPROBE_DEFER)
> > -		err = viot_iommu_configure(dev);
> > +	err = iort_iommu_configure_id(fwspec, dev, id_in);
> > +	if (err == -ENODEV)
> > +		err = viot_iommu_configure(fwspec, dev);
> > +	if (err == -ENODEV || err == -EPROBE_DEFER)
> > +		goto err_free;
> > +	if (err)
> > +		goto err_log;
> >  
> > -	/*
> > -	 * If we have reason to believe the IOMMU driver missed the initial
> > -	 * iommu_probe_device() call for dev, replay it to get things in order.
> > -	 */
> > -	if (!err && dev->bus)
> > -		err = iommu_probe_device(dev);
> > -
> > -	/* Ignore all other errors apart from EPROBE_DEFER */
> > -	if (err == -EPROBE_DEFER) {
> > -		return err;
> > -	} else if (err) {
> > -		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> > -		return -ENODEV;
> > +	err = iommu_probe_device_fwspec(dev, fwspec);
> > +	if (err) {
> > +		/*
> > +		 * Ownership for fwspec always passes into
> > +		 * iommu_probe_device_fwspec()
> > +		 */
> > +		fwspec = NULL;
> > +		goto err_log;
> >  	}
> > -	if (!acpi_iommu_fwspec_ops(dev))
> > -		return -ENODEV;
> > -	return 0;
> > +
> > +err_log:
> > +	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> > +err_free:
> > +	iommu_fwspec_dealloc(fwspec);
> > +	return err;
> >  }
> >  
> >  #else /* !CONFIG_IOMMU_API */
> >  
> > -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> > -			   struct fwnode_handle *fwnode,
> > -			   const struct iommu_ops *ops)
> > +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
> > +			   u32 id, struct fwnode_handle *fwnode,
> > +			   bool iommu_driver_available)
> >  {
> >  	return -ENODEV;
> >  }
> >  
> > -static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> > -						       const u32 *id_in)
> > +static const int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
> >  {
> > -	return NULL;
> > +	return -ENODEV;
> >  }
> >  
> >  #endif /* !CONFIG_IOMMU_API */
> > diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> > index c8025921c129b2..33b511dd202d15 100644
> > --- a/drivers/acpi/viot.c
> > +++ b/drivers/acpi/viot.c
> > @@ -304,11 +304,9 @@ void __init acpi_viot_init(void)
> >  	acpi_put_table(hdr);
> >  }
> >  
> > -static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
> > -			       u32 epid)
> > +static int viot_dev_iommu_init(struct iommu_fwspec *fwspec, struct device *dev,
> > +			       struct viot_iommu *viommu, u32 epid)
> >  {
> > -	const struct iommu_ops *ops;
> > -
> >  	if (!viommu)
> >  		return -ENODEV;
> >  
> > @@ -316,19 +314,20 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
> >  	if (device_match_fwnode(dev, viommu->fwnode))
> >  		return -EINVAL;
> >  
> > -	ops = iommu_ops_from_fwnode(viommu->fwnode);
> > -	if (!ops)
> > -		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
> > -			-EPROBE_DEFER : -ENODEV;
> > -
> > -	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
> > +	return acpi_iommu_fwspec_init(fwspec, dev, epid, viommu->fwnode,
> > +				      IS_ENABLED(CONFIG_VIRTIO_IOMMU));
> >  }
> >  
> > +struct viot_pci_alias_info {
> > +	struct device *dev;
> > +	struct iommu_fwspec *fwspec;
> > +};
> > +
> >  static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
> >  {
> >  	u32 epid;
> >  	struct viot_endpoint *ep;
> > -	struct device *aliased_dev = data;
> > +	struct viot_pci_alias_info *info = data;
> >  	u32 domain_nr = pci_domain_nr(pdev->bus);
> >  
> >  	list_for_each_entry(ep, &viot_pci_ranges, list) {
> > @@ -339,14 +338,15 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
> >  			epid = ((domain_nr - ep->segment_start) << 16) +
> >  				dev_id - ep->bdf_start + ep->endpoint_id;
> >  
> > -			return viot_dev_iommu_init(aliased_dev, ep->viommu,
> > -						   epid);
> > +			return viot_dev_iommu_init(info->fwspec, info->dev,
> > +						   ep->viommu, epid);
> >  		}
> >  	}
> >  	return -ENODEV;
> >  }
> >  
> > -static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
> > +static int viot_mmio_dev_iommu_init(struct iommu_fwspec *fwspec,
> > +				    struct platform_device *pdev)
> >  {
> >  	struct resource *mem;
> >  	struct viot_endpoint *ep;
> > @@ -357,8 +357,8 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
> >  
> >  	list_for_each_entry(ep, &viot_mmio_endpoints, list) {
> >  		if (ep->address == mem->start)
> > -			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
> > -						   ep->endpoint_id);
> > +			return viot_dev_iommu_init(fwspec, &pdev->dev,
> > +						   ep->viommu, ep->endpoint_id);
> >  	}
> >  	return -ENODEV;
> >  }
> > @@ -369,12 +369,16 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
> >   *
> >   * Return: 0 on success, <0 on failure
> >   */
> > -int viot_iommu_configure(struct device *dev)
> > +int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev)
> >  {
> > -	if (dev_is_pci(dev))
> > +	if (dev_is_pci(dev)) {
> > +		struct viot_pci_alias_info info = { .dev = dev,
> > +						    .fwspec = fwspec };
> >  		return pci_for_each_dma_alias(to_pci_dev(dev),
> > -					      viot_pci_dev_iommu_init, dev);
> > +					      viot_pci_dev_iommu_init, &info);
> > +	}
> >  	else if (dev_is_platform(dev))
> > -		return viot_mmio_dev_iommu_init(to_platform_device(dev));
> > +		return viot_mmio_dev_iommu_init(fwspec,
> > +						to_platform_device(dev));
> >  	return -ENODEV;
> >  }
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 15dbe2d9eb24c2..9cfba9d12d1400 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2960,9 +2960,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
> >  	return ops;
> >  }
> >  
> > -static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
> > -				     struct device *dev,
> > -				     struct fwnode_handle *iommu_fwnode)
> > +int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device *dev,
> > +			      struct fwnode_handle *iommu_fwnode)
> >  {
> >  	const struct iommu_ops *ops;
> >  
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 254685085c825c..70f97096c776e4 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -12,6 +12,8 @@
> >  #include <linux/device.h>
> >  #include <linux/property.h>
> >  
> > +struct iommu_fwspec;
> > +
> >  /* TBD: Make dynamic */
> >  #define ACPI_MAX_HANDLES	10
> >  struct acpi_handle_list {
> > @@ -625,9 +627,9 @@ struct acpi_pci_root {
> >  
> >  bool acpi_dma_supported(const struct acpi_device *adev);
> >  enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> > -int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> > -			   struct fwnode_handle *fwnode,
> > -			   const struct iommu_ops *ops);
> > +int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
> > +			   u32 id, struct fwnode_handle *fwnode,
> > +			   bool iommu_driver_available);
> >  int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
> >  int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >  			   const u32 *input_id);
> > diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> > index 1cb65592c95dd3..80794ec45d1693 100644
> > --- a/include/linux/acpi_iort.h
> > +++ b/include/linux/acpi_iort.h
> > @@ -40,7 +40,8 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
> >  		       struct list_head *head);
> >  /* IOMMU interface */
> >  int iort_dma_get_ranges(struct device *dev, u64 *size);
> > -int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> > +int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *dev,
> > +			    const u32 *id_in);
> >  void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
> >  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> >  #else
> > diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
> > index a5a12243156377..f1874cb6d43c09 100644
> > --- a/include/linux/acpi_viot.h
> > +++ b/include/linux/acpi_viot.h
> > @@ -8,11 +8,12 @@
> >  #ifdef CONFIG_ACPI_VIOT
> >  void __init acpi_viot_early_init(void);
> >  void __init acpi_viot_init(void);
> > -int viot_iommu_configure(struct device *dev);
> > +int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev);
> >  #else
> >  static inline void acpi_viot_early_init(void) {}
> >  static inline void acpi_viot_init(void) {}
> > -static inline int viot_iommu_configure(struct device *dev)
> > +static inline int viot_iommu_configure(struct iommu_fwspec *fwspec,
> > +				       struct device *dev)
> >  {
> >  	return -ENODEV;
> >  }
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index c5a5e2b5e2cc2a..27e4605d498850 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -688,6 +688,8 @@ void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
> >  int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
> >  			  struct fwnode_handle *iommu_fwnode,
> >  			  struct of_phandle_args *iommu_spec);
> > +int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device *dev,
> > +			      struct fwnode_handle *iommu_fwnode);
> >  
> >  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> >  		      const struct iommu_ops *ops);

