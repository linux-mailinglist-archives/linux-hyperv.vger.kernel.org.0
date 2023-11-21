Return-Path: <linux-hyperv+bounces-1002-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AFE7F3303
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F6C1C21C91
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2C5915E;
	Tue, 21 Nov 2023 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4CE7A0/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34213187;
	Tue, 21 Nov 2023 08:01:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJLUljYF0oYZ+OVERCBrXO0jNocEtLxzJsFxeh1evjDusHjFH6R3n8qH5HIpu2oM4L3IwbhHwicUEpDVrh9tZJfDfUq3qKp9i9tZ5zGT0wG6vMnf/TJ/OSEl4/t6lu7mQ35T9wW0yXOtfj1TCKFTrd8B81Be1EZccOFy5WfhfoNdAGdGiOvf53EdaOB4XM4bbgc7zILZJiiQGQLh5f7R57zgWoNnrw6r88KDeF0AlFeroyDGDgIie7M9B9gdIYtyeEW+P5uASQsRK3yL6xLtWiJu3cSW22sqT7S7U5aCI4lasNzzIp4psGqCYXAWTRKctqm2oU+HTkB17u+f3ohU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaWajGbtNv2+IFIOz3uXT43RSyWI+LMZKih8z1s/+FM=;
 b=Y7QcIQGcob65IDPY7bgnSlM5TgrYaSIY1gtlSQ8XwTCufQ7+79tAOgWiVjJyDrOkggY8VEwv5/ZQdLWi1jRC2vBxegZmgo/kYK1Ryggst3Rzag4EBRztPGG5rp/tQ5lyKAaMhZ4bMEtK+2njWNzaJqNAol4s01nKL4rIZYImovF6JbOI1CGFL6bqJ+f9D1WTlhZ84n1toBvl7N+527DruOocKzoRakaOOlNM6iU4EKlXCNItqJz6n2m2sf4uZ1KUEBspKAh7CVDOyAh1eIsjZ6qF5Xgq297MvMPKWG+6dYvmlCf/8kt9E2ffxHIw3XtVErWEA+0CbirEtgsLMweUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaWajGbtNv2+IFIOz3uXT43RSyWI+LMZKih8z1s/+FM=;
 b=F4CE7A0/1BBMYnmTbfBpKnyGbWxFjKJIs4vG9pp+K3ZkrsWjdsSZLViFxKLkfvGgg+6dt4G31Jcuhxto02n866v+Qw/10kkFc14ihKc5lfxIb07/P9QbKT/5WfRri4KZgM/D3Rj/cRv636QE48MMUTXL4Mq7KaQM2kxhNiaQNzurTPI8OEv5actnpPQWVH6mLmUlMKGGa+mFTvAJOBMcENvYjMiEjUxkfDxxpSXqNaNMh2s7MmFgxCkkEGCfqDpsCmdehEMGzM/CTUKyBXNHXv+mPo8Gh9kTybBERGzB2lqNThT9BMJ4wUdHszpYzTNHmtbqv1jAp5pWB31hsXyBeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 16:01:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 16:01:00 +0000
Date: Tue, 21 Nov 2023 12:00:58 -0400
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
Message-ID: <20231121160058.GG6083@nvidia.com>
References: <6-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <20a7ef6d-a8ca-4bd8-ad7e-11856db617a2@marcan.st>
 <1eb12c35-e64e-4c32-af99-8743dc2ec266@marcan.st>
 <20231119141329.GA6083@nvidia.com>
 <90855bbf-e845-4e4d-a713-df71d1e477d2@marcan.st>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90855bbf-e845-4e4d-a713-df71d1e477d2@marcan.st>
X-ClientProxiedBy: DS7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::18)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: b60a5d6c-a677-4371-2df0-08dbeaab0e00
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FTtJY+Zp8L/mr0DZ74nEcpNjuAuWsKl8zf3rw26PdP2lT0BoRPehDWYgg+B2J6oHQEL0AuYqsZOvWnEOzW3XGEm/KVvsSGhlfvdlOQ/5DJZ2+LQBUYZThlPOSZK0wwS3aTyrh0pE9T57M+GHd/u9DP2yUBC8z+oE1I1eA3lNiKpEz/J8XhA3n7P8GOTreR+DvQ/9qxVI/+mAolIzonibsmBgQKAfspVLECsyTW1Yv9+p+bIwwcO5rjq24HAr+ei+G4Ru+KcfIwnYR/vM2oMCTewKgox1+P6q4iNTjb8+zUMRchrEs374gIViHal+urgWclV86TwpwztTfYi4FApO9MD9XDc9vDg3g6qc6Wm9HwGumheXfGJqMHO+lTwhxC5ol33QpAS0452D232rGALwi5tQZUhLraQYz4PJJNxrsMdibmLzqcx4PSDx561eGa5Kln0yQtLwobnleumDrAhXEUECf3KOLbT79oD7Y2A0EV51286+NLSU9ltD2jr2fjtEe0QQFgY4WNup32w8m06B1a5KnG4j7yb5Sv3qd3LfxZIft6yOxVwOSaY6uRu/GgX0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(316002)(54906003)(6916009)(6506007)(6512007)(36756003)(2616005)(26005)(478600001)(6486002)(1076003)(38100700002)(83380400001)(33656002)(86362001)(5660300002)(7416002)(7406005)(2906002)(8676002)(4326008)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?65UkRiaimReLhAAAV4TyNayB+V6XJJqGoZQ356Mq7ae211pi+rtqxqBVAHrY?=
 =?us-ascii?Q?bqNkrO1IIBJ1qndaItdgk3k96WlcexQ8zo9vJ/mJyWWW1lW0PGAfEf7Z7qqn?=
 =?us-ascii?Q?QMibbdch2k7laEsW8jmtXoBsflm/e1ZBN/3ZljBhhmg82in0lcKVZwpTpmSK?=
 =?us-ascii?Q?+tvx+h6sMetLoIJYkCr7T8ykzZqg+2q0am3OXMFmmPzO7v8wp563NtV4VWk4?=
 =?us-ascii?Q?GcOiuhTZJ3Oo2iQ1p3gy13ngra+7+g0Jj4OUXT+HOvwr0Qu9o+4aFOxQIfGF?=
 =?us-ascii?Q?8cNabQgiPPUBiTxKEq1hK0DmTUtnAPBKNip3D1d+KkRgANQttKW7CqGhDiq6?=
 =?us-ascii?Q?TJUV6RG9g7ZQ8Nih740HVvrTf5V206P/JYBbqj+FcupVXBPrA5VQhrAeL7sf?=
 =?us-ascii?Q?H4vRcjEXIWa4NHlusZwpTE7I8RZqSFHmbwzbEq59O+Lia8kSsTKi9IbgdnfP?=
 =?us-ascii?Q?aiDkNscxqfbNZSQJ5FlR8fgH2UGvM2idhnKUsUD9V08VfALFTaibGjdQxmMy?=
 =?us-ascii?Q?ilskqHbysLyDwaoZG9MlqXepIexq93dgnK9SJv6dyM2S/QvywoJsGtAEQ744?=
 =?us-ascii?Q?51ewGw8gd/jes4PwCjJOHcGevXlOa+TJbeAeJ9/+BCEt+UYojas0ds43g6Fg?=
 =?us-ascii?Q?8XCENwPk/OM/oMlHxr2J6YHcT9Iax0U3C8ZK5PVsqOb/NAIg6wrbvM+jPYuo?=
 =?us-ascii?Q?HFljF7o0oRV0DGkAZiWGL9X+Q0z1v0HDBo2Ljm5mE/bnkok60wUixBQ7z2P7?=
 =?us-ascii?Q?oxnh1mNxaNfTRt6ozXxxQpzQ7coZulRE17jBu9aC4Divjo6dOZ6Xr0FKWyIQ?=
 =?us-ascii?Q?AbpO91VoGax3BTX6sZs5du3/Z0WXr8em5BfUZ6HFgrN8D9BDAeJ2CqE7M0A7?=
 =?us-ascii?Q?pT8osfSGFj+Mt5DjSdO8aYV6fB7tQl7ZNQmNji0dsMI+VY+w4yswpbAbXlOG?=
 =?us-ascii?Q?9SVLZeANVDfdDtbBQrGTNmtJZB/zEbfj5eVQ7mqre96JM3iPR13roKa24jj3?=
 =?us-ascii?Q?VXsc/bh6FGdUAhJnvkNK5K91JVT/oWDjQbPgSkQeuFW8eZYVyAehBP2qjl3e?=
 =?us-ascii?Q?IQo1etQ4lOGpexoZaxzuxdXUN3SGsF2a2zFJ+ScCccnvSoGXPI2Yit1nujmu?=
 =?us-ascii?Q?b77mVm0qHG86bBrMGXTVpvfsAwTGPp+m86x0/Wyx2OeYzZj+QHcSxRC/meDD?=
 =?us-ascii?Q?gFKYAVC2TWMH3Hp9xfYmft8rgR3PkncZjekJMUhJdamePLC0/L+nFUKyEyS0?=
 =?us-ascii?Q?Cx1F0mnA30zuoynV5ncHmUoJmKEf200u2v4b7ki60oK96zlNnJorrSc/j2aJ?=
 =?us-ascii?Q?4RVDgYmxThPxTNUkloL2BJEyzXQX97sfPaVlUqcz7df7Z3mRzHZUdMy5bOsx?=
 =?us-ascii?Q?gbrnb4l2kdyfIKgawnvNiBrB4YR4gFgBmlljH2dT3kAF1hjSjqKgBd18UqH9?=
 =?us-ascii?Q?uK+1nb5Is32O2AkvNiZ/KqrPkNRz06+QKzrVIC6pN1Iq2k1VKXngSgjkYY6M?=
 =?us-ascii?Q?KgD+KweI3Tw/LxrcbaDQqZLHSbuR5Pa6/9DPloTYXCLhL9LHHlbhxbPxT5a5?=
 =?us-ascii?Q?cxYkrH6ZBFU5B7ZU+QYo+I90vjvhgdOESUR5Ztlw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60a5d6c-a677-4371-2df0-08dbeaab0e00
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 16:00:59.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNTOnKA8Xw3mgTSwaX2a/2yBVEIInTXzKlBh6jNLABuux4SegzlAyaZGUe48Dyrp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392

On Tue, Nov 21, 2023 at 03:47:48PM +0900, Hector Martin wrote:
> > Which is sensitive only to !NULL fwspec, and if EPROBE_DEFER is
> > returned fwspec will be freed and dev->iommu->fwspec will be NULL
> > here.
> > 
> > In the NULL case it does a 'bus probe' with a NULL fwspec and all the
> > fwspec drivers return immediately from their probe functions.
> > 
> > Did I miss something?
> 
> apple_dart is not a fwspec driver and doesn't do that :-)

It implements of_xlate that makes it a driver using the fwspec probe
path.

The issue is in apple-dart. Its logic for avoiding bus probe vs
fwspec probe is not correct.

It does:

static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
{
 [..]
 	dev_iommu_priv_set(dev, cfg);


Then:

static struct iommu_device *apple_dart_probe_device(struct device *dev)
{
	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
	struct apple_dart_stream_map *stream_map;
	int i;

	if (!cfg)
		return ERR_PTR(-ENODEV);

Which leaks the cfg memory on rare error cases and wrongly allows the
driver to probe without a fwspec, which I think is what you are
hitting.

It should be

       if (!dev_iommu_fwspec_get(dev) || !cfg)
		return ERR_PTR(-ENODEV);

To ensure the driver never probes on the bus path.

Clearing the dev->iommu in the core code has the side effect of
clearing (and leaking) the cfg which would hide this issue.

Jason

