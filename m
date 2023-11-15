Return-Path: <linux-hyperv+bounces-954-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E47EC49B
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82ADA2815FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3028DDF;
	Wed, 15 Nov 2023 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gB3Gz+2H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6228E2D;
	Wed, 15 Nov 2023 14:06:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA76E6;
	Wed, 15 Nov 2023 06:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwDPFjd4tyi1tA4mvdODqzOj+Ctr18cTVQiSz05LWqPi0xR6xBNIxNmhE5qUkr2xlviCWnfNbjhEzxEADi38TD8u4/qIT6EsUPmpEfU9KdyhESFXsaJ/wB50p73PST/Cgd/rPjHsROFBAch/N+c7xGwMC0yik0KBY+7cg8EWsb4juHOx1aBAQnsvNX3hx/6CIl59y5CMNHsqeHYzlhAEUxY/lu+8U64JW6e1Q/2C2py93azgfNo0hLzw39421wq1VshMAjT3Qp9GOCWz/tUuaxJy99wd2lvoz8fFfxJxggD0scfLmiXYfZhRlsXqYFl66jOAAZie4VJRr2NCRnKZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yae0axYTjjI3f8FfwNnUGvRehogAE1Le791efG4bDNk=;
 b=J9SUk3teMaLL1svuoBRLyDOQg6ZW5UkoWPUK8IDN7AuRKPdAPm4iHb45gQBMkIEd+YsTrUoepNdM85NgeD9ZBiCggUJnQJgHQ++YUC1/MomZBpEqTVyZgqGdsXL6VIFw4BtDBMq9bt5O1lsccOwHM/C/1fiLikOYXiiTSHvMnPe/vsNyTnFeXv7uOKa40BPOwvsY0Tzf93PvkAeLTsp0imRbluP0zD2pM/4lpRQ9fbcGtWyDZlQtPN74AEg24gfyjlX2IVBSaMlfUfY8wwjjrnwzSwJBbYvH78vqD8kflmHbF1cAe7/13xEfWjpYdDmPzGWS0J8bMk74IkWfCVxokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yae0axYTjjI3f8FfwNnUGvRehogAE1Le791efG4bDNk=;
 b=gB3Gz+2Hn4xEakX9114IFbam+pz7MocFqlOAwjERwSXYLb0OfIesLurYwXx/4UiZC/T6t7jIvs3Of7bwpSKBtnLs0oQQCVywYdUehIh7or0/PSXFLBOmMmKR88G6T7N7jUXWF91swQuQq384bIwKHgKcX1m3hqdeyRpnYmT0BU209zL6otAvukQ8mYFLajEl1roHSQhlh0BgRos4aWOt8911HWdudPZkXmr3K8PrNwoEJb1m50xHBRSP2QsQBedOKLyfaYq40xsoH1JbgVZKzjNIATls4XTYyJXiy8j9N5ABR6pEPfarK6j3xJXSQ4ZF/CQOf9kt4qH/qOtMVXHfzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linux.dev,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>,
	asahi@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>,
	devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	patches@lists.linux.dev,
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
	Krishna Reddy <vdumpa@nvidia.com>,
	Vineet Gupta <vgupta@kernel.org>,
	virtualization@lists.linux.dev,
	Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 00/17] Solve iommu probe races around iommu_fwspec
Date: Wed, 15 Nov 2023 10:05:51 -0400
Message-ID: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:208:32a::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c37773-3b43-4181-8ada-08dbe5e405c7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vqP7gzN8dhcntTssb7BQJnZ/EShUBY/7GFvwp1B0OS55Oj+cA2Xz3ecEEjTaFSf6FB/SLiXlnHCJLs/fH8NlxpC3+H5BQFMByj8rPH338k9ZeohlOZV60t33rCiEpWbsZipsVlNGBfPu6WbXuC6EDFEnfXoiXPqRe1OvrcQ1N5jdJ9b8roPYQaznyKymQuLGjaeqlb0worSK1TLD6XLCfK9E+z/sHeTlPsqVXXhVSvCW2KO4IoI1yku6IIbeqyxnTpeTxGwyJ331BqMwbnoD+2wKM0qe4RPDFumn3VeSn2IqqUcQKoVnk+e4xDnBEkDTCNX/AIZ8FBHvnl/WDS2m3ujGjmvKGZJXa7nQPx9m1ApvJHCSeqnooLEe9Q5M+GtcniIecPX2LHe0zcOLH/5pRlNCMOnHXdJ//EjtHSYQhcwAJuLMOkK9W7PCsea3A2wXPv+0JpS6xdmWXdVNKCXdn9luA9LjbjXPRCFnATKNrCozNNnktGc4OkKrPYfc8Yr2wnqKPjBkP8T16qiYbCYiQImkMgRcg2SQ6MwBibxFP/JNIeQ1qnRBjfURJG8j/GU/lr7Um5jy1Wc78j4r6kwtTMpnab6nAXGltsxcKUPhrxHXOlW2Ez3cUMAqqzyG9gKRJAU+5TkeWX+Ma+IMbXwD4Tka/A+dNWzgqXKC6FtSSxSIM2cNMBQlo3rBomdzTJP7aYEpZPNWzms0YWrqvKmiWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66899024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(966005)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LBiUIfQe/e2en+AdPyrAol3At1noN5fI4lyJlA0pVzxNYxVeA1IHLf82cqf?=
 =?us-ascii?Q?qjtSGM6YYYsWgogH5yDdvDXVH6oKS8jEUSoRah1WEN62OUDfrwLVx+qD3+di?=
 =?us-ascii?Q?2n+55NPDf2ayOSMUrGE+lF2HOMhDzAlQtWiSKtCPc8RwOhCGtileC5y7pNDK?=
 =?us-ascii?Q?uJXiT3bpnU9jhrCDuzkqSVcadAq/uqrsji6+ohWZPPvguGD7WYpbX667wOkl?=
 =?us-ascii?Q?fkzKmQIeH+jBck+2Ye3jaxRAHyhMVqAO/LBpHrrNtPJiaYUAr77OPLf82TXu?=
 =?us-ascii?Q?nVr0z2YQlp261WiI+3FklN1uW9sgAmlC8BzvFhD+GyghvURebuvLJIK9qkOU?=
 =?us-ascii?Q?O04++3devfhMxBZNXPPafi9SiJlYoZJoMip24xIm1WCqfqlsnTFWltwmslQR?=
 =?us-ascii?Q?Nw6S2vi2Qt4EEiXLT3ZZVnXMcID7hmJsnvUmBk7/NNocVCXSl+r07sj+/d2b?=
 =?us-ascii?Q?BXlX+xci3qU/qIAw4el6NaBek7wQv6hWjbYkyO+RjQ+fkj8Ufhw2s8bi8DQ3?=
 =?us-ascii?Q?DLczUkSLV5hDC0B0UPv03bra/uIccrmHJw9Nna8WZomZuu2LKIChC76wuzXh?=
 =?us-ascii?Q?uJB13wJgCFjDr8DlZ5ee95eSJYjMd6Ahm7MkrDMCFLytqUDikWjbWPluOqcJ?=
 =?us-ascii?Q?PAEJHV9adOWH1Zzvfs1QJ+tGa2PugAC+zh2wMbS0RaH6tuO46JmsPwJfQQ23?=
 =?us-ascii?Q?nKRkyzoObTF5sU9RbZzzvyM96pLNQw5V07E5Iy9pcagbKfFvyvoKj0uy0OeX?=
 =?us-ascii?Q?OnvKhYdTvwvFVgTSdiRxxbPv7q0esYJZJKg/O0K26ZdAxVbRFQk2pXTh84Ed?=
 =?us-ascii?Q?PNhWL8Lu8LN3fsHny+AuPxQcOCGStWZ6ZaPIrVk+rAKvWvt9NPtuxSZcFqiT?=
 =?us-ascii?Q?3jt113aYDKD1Fwn/1tHrx3qCaeIfpVkXgNFL0Hi3FhWgxlDjCnYfrOwHSsDd?=
 =?us-ascii?Q?ndjIJmC2tWJX1jBpwcxQ2f5OBXO/KhXDrA2AnFTN/2zsf9+y8UHrx54hoEmd?=
 =?us-ascii?Q?OGB74e3wXcMjq4AJXw7FO/4HmUpmsxHx7M2odLJYFVr/0szb9KX0XKpx98Uf?=
 =?us-ascii?Q?nBbx1V1SwPCxAPp4GwpM6ye9NRivOL91ikgpdZtCv3qKf/rxWq2i2xfGsZMX?=
 =?us-ascii?Q?XBbLHSN7iU4WQYqpxXW5uFqsPSsh99q+qSaAa1P4ugUaQ7seKTmGSJA2VekW?=
 =?us-ascii?Q?CNALKGWNZxwuYMtDyBUFjfR/1Qw0+l/wasTsbkNMZ41uK4G9bd7JUUnYM+cP?=
 =?us-ascii?Q?2DAE9VDQdcjNRoeBusnVPuMPGtluH5gg0XMZA235DSek9B8zfIYK7dlcU06B?=
 =?us-ascii?Q?EzeEDHTGtmGyxdxMZk1L7Pkq0mJ4tDk1QOx3saY/ReD0NksUc/sENOKFaRlS?=
 =?us-ascii?Q?Bns/65Ar5yReChOyoZmIn+p0VJmqPjXNx9cK0HNKURbJZHRpVT2uW34cU+4i?=
 =?us-ascii?Q?4h/GNEF/Ltvo4QSsz2Hy6/U1w3HnWnOwNBLSt9pJvrBakVQDxLwxSbaytxGd?=
 =?us-ascii?Q?RjTlEWcJRb7xM+zauyeAdrhAlr2rIBAHkPVKQkfJ7CTVE469ArSXW3eSnziX?=
 =?us-ascii?Q?VEe2X/3p5Iy+ZY8rldE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c37773-3b43-4181-8ada-08dbe5e405c7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:11.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH+csO4uyGrhwph4n5wHL5+Pv3LLoPnrZOodHTNl6LXelklzK9WkEW2Xe9QPfkrK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

[Several people have tested this now, so it is something that should sit in
linux-next for a while]

The iommu subsystem uses dev->iommu to store bits of information about the
attached iommu driver. This has been co-opted by the ACPI/OF code to also
be a place to pass around the iommu_fwspec before a driver is probed.

Since both are using the same pointers without any locking it triggers
races if there is concurrent driver loading:

     CPU0                                     CPU1
of_iommu_configure()                iommu_device_register()
 ..                                   bus_iommu_probe()
  iommu_fwspec_of_xlate()              __iommu_probe_device()
                                        iommu_init_device()
   dev_iommu_get()
                                          .. ops->probe fails, no fwspec ..
                                          dev_iommu_free()
   dev->iommu->fwspec    *crash*

My first attempt get correct locking here was to use the device_lock to
protect the entire *_iommu_configure() and iommu_probe() paths. This
allowed safe use of dev->iommu within those paths. Unfortuately enough
drivers abuse the of_iommu_configure() flow without proper locking and
this approach failed.

This approach removes touches of dev->iommu from the *_iommu_configure()
code. The few remaining required touches are moved into iommu.c and
protected with the existing iommu_probe_device_lock.

To do this we change *_iommu_configure() to hold the iommu_fwspec on the
stack while it is being built. Once it is fully formed the core code will
install it into the dev->iommu when it calls probe.

This also removes all the touches of iommu_ops from
the *_iommu_configure() paths and makes that mechanism private to the
iommu core.

A few more lockdep assertions are added to discourage future mis-use.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_fwspec

v2:
 - Fix all the kconfig randomization 0-day stuff
 - Add missing kdoc parameters
 - Remove NO_IOMMU, replace it with ENODEV
 - Use PTR_ERR to print errno in the new/moved logging
v1: https://lore.kernel.org/r/0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com

Jason Gunthorpe (17):
  iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()
  iommmu/of: Do not return struct iommu_ops from of_iommu_configure()
  iommu/of: Use -ENODEV consistently in of_iommu_configure()
  acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
  iommu: Make iommu_fwspec->ids a distinct allocation
  iommu: Add iommu_fwspec_alloc/dealloc()
  iommu: Add iommu_probe_device_fwspec()
  iommu/of: Do not use dev->iommu within of_iommu_configure()
  iommu: Add iommu_fwspec_append_ids()
  acpi: Do not use dev->iommu within acpi_iommu_configure()
  iommu: Hold iommu_probe_device_lock while calling ops->of_xlate
  iommu: Make iommu_ops_from_fwnode() static
  iommu: Remove dev_iommu_fwspec_set()
  iommu: Remove pointless iommu_fwspec_free()
  iommu: Add ops->of_xlate_fwspec()
  iommu: Mark dev_iommu_get() with lockdep
  iommu: Mark dev_iommu_priv_set() with a lockdep

 arch/arc/mm/dma.c                           |   2 +-
 arch/arm/mm/dma-mapping-nommu.c             |   2 +-
 arch/arm/mm/dma-mapping.c                   |  10 +-
 arch/arm64/mm/dma-mapping.c                 |   4 +-
 arch/mips/mm/dma-noncoherent.c              |   2 +-
 arch/riscv/mm/dma-noncoherent.c             |   2 +-
 drivers/acpi/arm64/iort.c                   |  42 ++--
 drivers/acpi/scan.c                         | 104 +++++----
 drivers/acpi/viot.c                         |  45 ++--
 drivers/hv/hv_common.c                      |   2 +-
 drivers/iommu/amd/iommu.c                   |   2 -
 drivers/iommu/apple-dart.c                  |   1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   9 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  23 +-
 drivers/iommu/intel/iommu.c                 |   2 -
 drivers/iommu/iommu.c                       | 227 +++++++++++++++-----
 drivers/iommu/of_iommu.c                    | 133 +++++-------
 drivers/iommu/omap-iommu.c                  |   1 -
 drivers/iommu/tegra-smmu.c                  |   1 -
 drivers/iommu/virtio-iommu.c                |   8 +-
 drivers/of/device.c                         |  24 ++-
 include/acpi/acpi_bus.h                     |   8 +-
 include/linux/acpi_iort.h                   |   8 +-
 include/linux/acpi_viot.h                   |   5 +-
 include/linux/dma-map-ops.h                 |   4 +-
 include/linux/iommu.h                       |  47 ++--
 include/linux/of_iommu.h                    |  13 +-
 27 files changed, 424 insertions(+), 307 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.0


