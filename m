Return-Path: <linux-hyperv+bounces-985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4DB7F06C8
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 15:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926EF280D87
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Nov 2023 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A113012B88;
	Sun, 19 Nov 2023 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJVA7Nzl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF8CD8;
	Sun, 19 Nov 2023 06:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDJdCVQKhgHow4m9ACdREzQ3uyTiHFB0sQxyIqM3a3/aTqrZ3ucqwqm08qjHy7MQ3ukeQNYgldv38wjOyMCj5wS6JgMe4e0PF50ReysQUPxnylbHgqEoSt2GvDqN6RAj7OftPw4evMEO98rWPOQ8Ahb00hTAwsRp2XcZuHVkW7CaxqXqwwBV/rz6s6eOEItie8RoiTaqr40ItoebGsvbV2M3wkyqEnimx+b2cDjO+IIaPyE7vniIfZusYtAAeV7Dw9HHhk0B3YsJeCiGpSq8coV2wqdMrsJhBOdkRkqsn8kgILDIa0COeLlPvc8OayQeveAJzzkyRo8YWsf5MMEjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGEUo9PDUlWFAuTno779R2YJn2Bmf2Y16bplzn7RseI=;
 b=ZjbtW/3rBwQq4eY5YhWdPxuqO7LlwfnZEarEnylD9oLY6HASA9ETZrgEJ/FL/pq9uYk6kW07f8BDUJ0mFetK9ZnWSJWMAAb7uuBbapFUezMomfIncOQHMlqC61Dr1BQ3e7WrVhlEis18Yj8DvkoiYziA7YjWJHx/pPcO6co8OivhPHJbCVfn6lMp0nSUqUEzVBatenGO7rLavLNqhdyy35piaAY+pR5GV/LxW7Q/AAkl4X6c+H1kPR3A7wYPeo8/G6YZwr+WIObKOnd7fdpbDnwjTJhCpgnKy+jckqwkjBREgMt9J/WKceY5RVj6kD45Q0tirgIteiD2twKX3GX2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGEUo9PDUlWFAuTno779R2YJn2Bmf2Y16bplzn7RseI=;
 b=YJVA7NzlDtSi15RwNPkyivUij5QQTaSfhKIH3ZxFVDb0Nh0l1KXEhIU8Z0AausRAO7VUyiut0ycEOgCUsns+phf/ezPlqwa91u0DcR/tWtf0kVNta/NPjriOKsIzZTB5JDW4g+XygiIHZ9yQzqfoLwxQVOjVPGjx3G4ygmHM2neb3nZ1GfNCWcBpsHaZpyH8a7LsrOcd5yNA9HguGyIi/e92QcIp7kITqsPQfRwd5ePcjuIB/ZAzm/+VLysD0XB1i5VSTIVaelSkC8ZE7plsYElqhz8xgcc+i8cu7XCL/IZqM54gEMcwk0umZai1sMEi24IZtDUOoqV++gbeFCrQZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5455.namprd12.prod.outlook.com (2603:10b6:a03:3ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 14:13:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.026; Sun, 19 Nov 2023
 14:13:30 +0000
Date: Sun, 19 Nov 2023 10:13:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Hector Martin <marcan@marcan.st>
Cc: acpica-devel@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
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
	Palmer Dabbelt <palmer@dabbelt.com>, patches@lists.linux.dev,
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
	virtualization@lists.linux.dev, Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 06/17] iommu: Add iommu_fwspec_alloc/dealloc()
Message-ID: <20231119141329.GA6083@nvidia.com>
References: <6-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <20a7ef6d-a8ca-4bd8-ad7e-11856db617a2@marcan.st>
 <1eb12c35-e64e-4c32-af99-8743dc2ec266@marcan.st>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb12c35-e64e-4c32-af99-8743dc2ec266@marcan.st>
X-ClientProxiedBy: BLAPR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:208:32e::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e6d866-1c61-4009-4f3f-08dbe909b4e8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6D44wF75CHELzMqh2h9insgdr197qsLVOIPD4vq6Uwsri8hjkgrkoC3S0BDptP/kmh9uXtWpJZzHoH+NPfa/2uUz9nt2BPNBP/BBrcINoALmAudCl6Dnkjg+mE62RHRxOZJVY0of8F3W8FHjjohih8NKr+VXQF+TAdwzSryX6kTJX3N/DPL6xhwNvUldvVRXdlRvD31eOUAot0IMoQqDGSv2nojbbf0orVMgkGA6/bFNyOvw5qL0Vs3JwQ2yxULmkFUDmtIquCVUd+RbLySM5LPq8xxEhzhgNGxiUjsQkmjDOC03OEJ7NQUHMOYNJEiDJrqdEOoYcQAmvWBLbSEXtI+dLxkawwg+cJkxVZBwCRN8WRJW6/QIywJShPs49FWgoM2/xNGKO9pRGxBcjXQAD6I69EleT3LfoEIwKocYHe54O48frFsw9APlnWK0WKUfaAji0g4XScrEBUDiGBjIB6E20B283tDLvdCXGJQxxijpOG478oX1bqX/cX9oqyCDPgEPYWcPI9v2+7FEwyJCI74ZmqClAp1vQeLu00goPkQqe12FOx6FtgDJXqecu35o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(478600001)(6506007)(26005)(6486002)(6512007)(316002)(66476007)(66556008)(6916009)(66946007)(54906003)(2616005)(1076003)(8936002)(38100700002)(4326008)(8676002)(5660300002)(7416002)(7406005)(2906002)(33656002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xvbsrw7T3QmG5I+4QyrLfqgCvZKhW94XnnOGamieipdlbDzEHTXhVg7HM4y3?=
 =?us-ascii?Q?Ewh7DuGnplmc+d4+FxBqwWP1hebcACRbnYrLk5hF3wDCvA++2s2Zm6n5Upzi?=
 =?us-ascii?Q?KkAneJHJbdUuMwXBfXNHNd3/LuGpUEQzthbFLmHbaCPhUVigher/eGU8mC8V?=
 =?us-ascii?Q?8hP8Sd7m0PPj/hF0gO8qqcaiQySykAkp3m1KfBYuGFSYGHhXvtXNoEjYqShB?=
 =?us-ascii?Q?8qqEOL0acuzNBdKY+Vjnwslvl4kM6oAdgNC+n0ZqjVikbb74l3Y9zxic930g?=
 =?us-ascii?Q?wEYFQtuvNeOUqT1T14ofM2TXmWT4vh8KTIchDMRRox8z1PVvs7lYFmwCFZuL?=
 =?us-ascii?Q?lxBcEhvlCRw4d2LRCuT4yj0PvD1okM/5zAGth7zpNyy3Drq8J0pufiXUImTw?=
 =?us-ascii?Q?pnkdu+EdBVGPC0p0v0CP2dpKxepn7PDDLCKZBqe8TdWzt6txp6QZo/neR36j?=
 =?us-ascii?Q?0OkbFQLZkmdD253GqtgK1JFlw1Kbp6q+iYBIyOknCSixPnsg3xNpbnOYU8J3?=
 =?us-ascii?Q?wojPfxmQW88N8YfVjj9VCckcEJIV4lVMNY34/JiEDZTcIWqD3zigpHn5OA2c?=
 =?us-ascii?Q?sZ7hRLLQCo8kypqpKCg2ZLrmxbPsSWcYYmC1/hvd4q181CCsWBVpgM5wpvBp?=
 =?us-ascii?Q?+vz7yLhRgpP7W9OLDHVHVLIycqAD7jpjh51uRAy51n8vr8F6xEf76aEQYk5F?=
 =?us-ascii?Q?uDpWuMl8uXx0OWFqq6itpr3DpEA+9AM5fIB1fJiWKSht8U/lNAg586ES2pBu?=
 =?us-ascii?Q?lEg6vrzOwgBmjhej6rPslsvoUCd67y/5y1bM2eJ9lqEIFtGFC/9kDKTQN5Lk?=
 =?us-ascii?Q?YPV7loUW2PoBz2Tj1S1bspKiYV08UrFBBO48aMFF0IlSV2rfcj2JDWcre725?=
 =?us-ascii?Q?pWHJUXg6l2xZj0IMEtplBfuYp7V6y0Ynhltd8WXAR7tN4pz48iJdk/3wRPFm?=
 =?us-ascii?Q?5DpushqFFEGmCdarvzi1mcfKyjGCASngF6QeHNgiwKm1wHv1PEqSdooMAklm?=
 =?us-ascii?Q?rZweqycYLXTUWwwUtXajM9N35UlbPut56uejAKOTW6cZZkUy+b/U0idsNHNh?=
 =?us-ascii?Q?AyXmSGo4D4f6tpml5MiBGI1MwpZ0UB/0xoZvj3cNbefYJnoQquJPWjVQZm7d?=
 =?us-ascii?Q?VH7UpIneR4XDqLB7C0XNvjUlv85hgjS6GId8RpExerWyA/I9GJdLmE7tv53l?=
 =?us-ascii?Q?1aAc6rZqbMGRF0iUI0q3FDmV2+7A6lUnkeYMWw6MD21mRufj6C5ZL2EryM22?=
 =?us-ascii?Q?Ro5TDFxiCb6nTn/te5uP6AkVhwnTNcYvhbUNPikktXtq3t5DA+6DuWoDsLP6?=
 =?us-ascii?Q?RdbqQNCRbIxx5Gf9TZPDVc/f3yKKkA+V4KRe+jaf9bgD2g/rCGKnxoRIZ0SW?=
 =?us-ascii?Q?GNZPMRCBJOHhb6EsEXp24U7t8+xZRSNbvtq4uLqy4z/JeN+SJk44NFbtiFAt?=
 =?us-ascii?Q?eMAoeMmhRgFD+1oUQ7F6AiY0uMkWQzYPzHSlrsB8OfC6Ojj8vzS0Gsh8qy4Y?=
 =?us-ascii?Q?jbEeHm+kpdcV8bhGppExbBCAt63ZRW5Hn0fxl3o+g+TEAM/h8feSeK8nLhLR?=
 =?us-ascii?Q?mg2kNRBabg8N+oYqD3k1iiVFRPL6Uoc2K1KShXKH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6d866-1c61-4009-4f3f-08dbe909b4e8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 14:13:30.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt1BI/YhRelM+47lp8t3bs7HJc4kJYQv31We5/glreHyOurQngYTTbpIjbcji4H3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455

On Sun, Nov 19, 2023 at 06:19:43PM +0900, Hector Martin wrote:
> >> +static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
> >> +				     struct device *dev,
> >> +				     struct fwnode_handle *iommu_fwnode)
> >> +{
> >> +	const struct iommu_ops *ops;
> >> +
> >> +	if (fwspec->iommu_fwnode) {
> >> +		/*
> >> +		 * fwspec->iommu_fwnode is the first iommu's fwnode. In the rare
> >> +		 * case of multiple iommus for one device they must point to the
> >> +		 * same driver, checked via same ops.
> >> +		 */
> >> +		ops = iommu_ops_from_fwnode(iommu_fwnode);
> > 
> > This carries over a related bug from the original code: If a device has
> > two IOMMUs and the first one probes but the second one defers, ops will
> > be NULL here and the check will fail with EINVAL.
> > 
> > Adding a check for that case here fixes it:
> > 
> > 		if (!ops)
> > 			return driver_deferred_probe_check_state(dev);

Yes!

> > With that, for the whole series:
> > 
> > Tested-by: Hector Martin <marcan@marcan.st>
> > 
> > I can't specifically test for the probe races the series intends to fix
> > though, since that bug we only hit extremely rarely. I'm just testing
> > that nothing breaks.
> 
> Actually no, this fix is not sufficient. If the first IOMMU is ready
> then the xlate path allocates dev->iommu, which then
> __iommu_probe_device takes as a sign that all IOMMUs are ready and does
> the device init.

It doesn't.. The code there is:

	if (!fwspec && dev->iommu)
		fwspec = dev->iommu->fwspec;
	if (fwspec)
		ops = fwspec->ops;
	else
		ops = dev->bus->iommu_ops;
	if (!ops) {
		ret = -ENODEV;
		goto out_unlock;
	}

Which is sensitive only to !NULL fwspec, and if EPROBE_DEFER is
returned fwspec will be freed and dev->iommu->fwspec will be NULL
here.

In the NULL case it does a 'bus probe' with a NULL fwspec and all the
fwspec drivers return immediately from their probe functions.

Did I miss something?

> Then when the xlate comes along again after suceeding
> with the second IOMMU, __iommu_probe_device sees the device is already
> in a group and never initializes the second IOMMU, leaving the device
> with only one IOMMU.

This should be fixed by the first hunk to check every iommu and fail?

BTW, do you have a systems with same device attached to multiple
iommus?

I've noticed another bug here, many drivers don't actually support
differing iommu instances and nothing seems to check it..

Thanks,
Jason

