Return-Path: <linux-hyperv+bounces-666-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69C7E06B9
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B87281EF5
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625EA1CA92;
	Fri,  3 Nov 2023 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SyL2cOUy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2A1CA93;
	Fri,  3 Nov 2023 16:45:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382C194;
	Fri,  3 Nov 2023 09:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI0Mogj/GOPR02KPRmqtKpI8K9BUGvC6RBKBlIOgxhzzOKTDKFP5pm0d32xVkIy0jast6UHAPuuDhXQ4S4eBzpby0/fj+48ldw+gxfMvvhpCv1Ux0A3BCc7Vp1GVu7nh7r9pLTRVFEQlq7L4f3kxdx4rhhH2t66uhlP4lU76SnRfrd9OKmoAMZCtuoaTseOVJTKm+xwuGp6lBcLkz9MAOO8Zhv6bquG1sobyb00G7x5FGHiTQrbPGxYsZw/a9ePEpwRiiDGgXdZhPp9bHE7AcPAQXisj1Pq06xRrGPMEvT/oo0F1CSBdxzQ1IoEoVosGYOrJqA90FcnSgyBINbVlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywgd3HRS4oK39R26TqVY+MWvg9q8mZK2BdG9RN/u22A=;
 b=Kz4J5CptebELn8v3T8fQLGN4i2I/C/e9bpqULDdqCZU+jOEEktGVU3kF26e4cU6bXyy0BKEC8Q3zHpl1YLT+BIWY3NEqo9ZIhY74vOHAc1LIeQV7JGtWIyIG+xmSfflZvSOtO24lKV85u00/YcBSUEfoY8xUzWU8+0PruNFvDm9TvCW2VTgzMVY0/yCS+LL0avF3Mtb0DzWBle7Mr8HDL1sVlr3+Dtn4EljT6NfTLoZ01tWjVa5pkqiSsGDyqrR+Ngwx96qSpSVNC/NV+KPGGYXhY0IU+OnOAXB61PEkIPVrkCdwBfugBRJI+SrUUdwcG+sRuAVqCxdCPU/LS0hWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywgd3HRS4oK39R26TqVY+MWvg9q8mZK2BdG9RN/u22A=;
 b=SyL2cOUyv00dS5YEl5lQ+AlGwI79I69+//iQR3SQKxsCTstWRo34Iha1tXDLYwNmWK5uQygtbgwzZa4n336qItTqK7jgvmGDoVAjpq3vPnnhn2WJSRmmWjrkiln0z/qGACjcJtDcb76TKG2orePjsRqjZPe5NcuV1stvC91HKjlvMLdwpJ5LAdMWU5XyGYuYJertb4bpR4pBIGMHi7cJ+BJe9W6peMVHviqNNQt8jNcvFv+PCABcWAajUXHu4soYbBXFNp08BphGSLauS14jlrPpTqAQv6LPwoEPZjdDqnl9jK1zr8XllFxOOKLClK3wqwKIEl/PzZ7T5QVsFaDJdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: acpica-devel@lists.linuxfoundation.org,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>,
	asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dexuan Cui <decui@microsoft.com>,
	devicetree@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
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
	virtualization@lists.linux-foundation.org,
	Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH RFC 00/17] Solve iommu probe races around iommu_fwspec
Date: Fri,  3 Nov 2023 13:44:45 -0300
Message-ID: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0035.namprd19.prod.outlook.com
 (2603:10b6:208:178::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 779b6205-240f-4de2-b8a3-08dbdc8c3b3d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pzhY0bi91NaL63rOluXhFNFQgTZfODXj2rw9BLyXzchkNnavdtHbNFY1jOGSPOUc1dJPKyuZk7lobNd32UrGqrw/sNm0+stJ6aiPLGdrlkYF6LMVZ+nwUfZB/KTu2MbqLmobNGzwgL0hu0jPHQYp2+gT/XZ1VJzCKkQzUmY1OdvEDaDie4m1kG0sWwEkKux5C1c6l7j/yb8L/kyJTOlfZME0yj5i0UfqcCFu6vFjSIE3LzlFF3JA/l2DoBP5L/G382S1vdaGthKyOpgCmZYQycuk3PJAKAE0+NS92N70E7cXgCk3Lzk0V3vbK7PWiAP8JLagp0Y2lCDml8AbuwGWFFRgHYD2J8T3dZ07Q9M8XA7Kd8qqxnDOhfIGhNscoIvJyE+jjXa69TEGcAi7nCZ+zaO6sF2OmIjFbT9bIqWo+DD/Yad8vrtC9EQLPlAPWOogUaWuMBxbpwmlDzJaxCzNv0/TzV6rPCpzGqYmfX7BeeENCaTXpPqEaWm4spUQqbM1+ULUizzjCvl4MtKq9s7TaUinuY7alTvl6OIOo/obH4QpfIB1ozD6n4meRQntCNXhSnslogKs+bCFwnmJ3yXN+rLo+mxxN8+9IZmJQegWWBOsBavCcgMh4q+mScVXf40gD9DU0kZc+I9mrMrL1wcwlw0YIyfcxJUN/uu5YY6o5HW9AldrAFqHr0lyeiBt0fA6MGW7FF7VELLVq4e35TwJtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(66899024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(966005)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVm2ZYUnbl9n/lWBNoaYszd5YmggvSFrYmXk331W8i8hO8Qm+F1vAQE71UL9?=
 =?us-ascii?Q?ysD22FAc8w0zQ3YS0QdNU7eIlP6XN5p7z7INLPn7TYW574MvSh3mBoQ9/wiF?=
 =?us-ascii?Q?9cbmbxkD+p81aedwlugHf97ALEdkRRbyM0BWpauM/Xj+4s9kV40QkFdplnR1?=
 =?us-ascii?Q?+0iLBpDsOzk8NVJgheDox7sgtFykCkwRg8oQMvnNqmhvZm4t5RgvRRUMpvtZ?=
 =?us-ascii?Q?5gdB4NppOpj2mDOQJe8EnN8PxdGPF9TijW/+QT+x2dpn0siLKOWb4ku5uTSX?=
 =?us-ascii?Q?rFASvVN+wOQqtDbYBnZeB7mFL/ty5GCLVc0fA5azxIVC0SvMA76unfP+jpGR?=
 =?us-ascii?Q?v+9HhNBR3yY3lHU1VR9aF9CkWWWIotvFPs1rfEzkxgD7wEfNgP1OygElGsRJ?=
 =?us-ascii?Q?InTkD/ZOnrzG5VQXv6HH6MMdFPBBt4vkfyrwW75kEW3LF6kFOpgDZC/tKGjy?=
 =?us-ascii?Q?8+mJM8gM8rVi1je+VEtC6XyGMABW+f/QhUeeJvbuKtNso8oByoo5nPJsfudC?=
 =?us-ascii?Q?OFclYMzmhgP4ke/5xKFc0Y00r0Nf955dxDMpiZ8dJ649NHL9FNm6hoIX9tHi?=
 =?us-ascii?Q?LaMMJO742VF80iJ991eQWvEtb8elu6ZheqsrBukQxEqWi1mFxQgTu4GlAdAP?=
 =?us-ascii?Q?EBL27SVCLkdfGezISeV6zDNoQIQvkKeFUdQ7dHPhgVGbA2FG3QABHuEYC6gb?=
 =?us-ascii?Q?xJGYIkJt69/mLPaV4BSgk52/K+U8LZdJ3f82uUPkVkFJQpbSSNUTH9iwCC2c?=
 =?us-ascii?Q?UQ+khH4N70bvpLYPkNyVRCTCNufORZd8eSjOy9pMtfLDKkpUn2dFZPDxXcNS?=
 =?us-ascii?Q?7B/kQL8EV0ZUf/IjIWHWAde9arHI+Q1BXcTb2NTKk5Nd4Fk1T1GoAzhpSQ2D?=
 =?us-ascii?Q?F4GtNgxNZlUMhX1sVEmPJqiwbYboAP7PhgVbrS1x1SGGaF2EuKr67EknG0nO?=
 =?us-ascii?Q?pX1cJo9Hn1vZZad/w075Ktu6TkM2p8uFag2+dmg03QSObD5/KCGdWbvlfSQN?=
 =?us-ascii?Q?aMUgO+74HOyAzqHoztnWLs/pHKENy/4ZNLkw2w0DB5NohZp1CF13TkEGlp7f?=
 =?us-ascii?Q?6wwYsfOzOrvBKm7uUfsLqLzQqRL3VIQUbWmKDhP/iBThlpMIm5Vrva3BIt1+?=
 =?us-ascii?Q?WMZBwGu0iJQJL5/BQGP0FAwzswwI9KHctQi+MVo2bpa3tY2vGdgEilaeLgU3?=
 =?us-ascii?Q?VwmSlf6BxJ6zFPWQtEQcjC0yYBF2HXeq9PcJndUECOsidoceiKG6bEql+mqX?=
 =?us-ascii?Q?cPbvoYNM1B5NYqTTysZ4MhKIWXwX5JlNVQVP/kKyx9zQy8agYMAN48U+zHVh?=
 =?us-ascii?Q?eUCsd7M5/Gq/aRRK1nwSaRZL9zgAqOFkW8f4G48DDNxYDuCTw3hT5jsQwf/B?=
 =?us-ascii?Q?+yLczcMTChQ8PyXTRTrZVRuoe8nyO2EW9j9JWS6g0XW6fTD/5ZKO2Pp7mLQx?=
 =?us-ascii?Q?rRiz/RIJ9CESQTpGazQCxkRBvT3cbKcUPzT6L2Keb733agxaRayXvTD9Rk/f?=
 =?us-ascii?Q?WmTMgaIoWVKd/ObJei6zdv/oUy/mN23KvRe5Aal+ZLLxjbXe7o721IptAsbf?=
 =?us-ascii?Q?3LWy3dhxyUszWURPu2WgHWg/9B72dwUYiO3kHmYt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779b6205-240f-4de2-b8a3-08dbdc8c3b3d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:05.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hL8kUi2Pm/jyf59woyMbVOrZfn/fHRZHAH/hqayEo0qAa1/SHkCMQcAUE+NRPrJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

This is a more complete solution that the first attempt here:
https://lore.kernel.org/r/1698825902-10685-1-git-send-email-quic_zhenhuah@quicinc.com

I haven't been able to test this on any HW that touches these paths, so if
some people with HW can help get it in shape it can become non-RFC.


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

Jason Gunthorpe (17):
  iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()
  of: Do not return struct iommu_ops from of_iommu_configure()
  of: Use -ENODEV consistently in of_iommu_configure()
  acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
  iommu: Make iommu_fwspec->ids a distinct allocation
  iommu: Add iommu_fwspec_alloc/dealloc()
  iommu: Add iommu_probe_device_fwspec()
  of: Do not use dev->iommu within of_iommu_configure()
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
 drivers/acpi/arm64/iort.c                   |  39 ++--
 drivers/acpi/scan.c                         | 104 +++++----
 drivers/acpi/viot.c                         |  44 ++--
 drivers/hv/hv_common.c                      |   2 +-
 drivers/iommu/amd/iommu.c                   |   2 -
 drivers/iommu/apple-dart.c                  |   1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   9 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  23 +-
 drivers/iommu/intel/iommu.c                 |   2 -
 drivers/iommu/iommu.c                       | 227 +++++++++++++++-----
 drivers/iommu/of_iommu.c                    | 129 +++++------
 drivers/iommu/omap-iommu.c                  |   1 -
 drivers/iommu/tegra-smmu.c                  |   1 -
 drivers/iommu/virtio-iommu.c                |   8 +-
 drivers/of/device.c                         |  24 ++-
 include/acpi/acpi_bus.h                     |   8 +-
 include/linux/acpi_iort.h                   |   3 +-
 include/linux/acpi_viot.h                   |   5 +-
 include/linux/dma-map-ops.h                 |   4 +-
 include/linux/iommu.h                       |  46 ++--
 include/linux/of_iommu.h                    |  13 +-
 27 files changed, 417 insertions(+), 300 deletions(-)


base-commit: ab41f1aafb43c2555b358147b14b4d7b8105b452
-- 
2.42.0


