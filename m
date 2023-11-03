Return-Path: <linux-hyperv+bounces-676-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984CE7E06E3
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBADD1C2110D
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261011F611;
	Fri,  3 Nov 2023 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nlq80e3f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D61CF88;
	Fri,  3 Nov 2023 16:45:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC9D51;
	Fri,  3 Nov 2023 09:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDPDVpbr5doNJVZk/fM//KB50KeHjKP1kxalmL/as68EVdDUzukRBnpUAMbToxRe9GyLaMsCv3Ba22wUN5/Hps3bJ87yjEfiExmj2HMSgCytPgh+U8kuLd3NF0lhyHo4XnAje5kefHlMvYuyHpu9wTpZ+EcICowBGH4VgriqOFRhHSJxFR39PZIQRQq/1vxRbIgebOOjc7S6iUc/aQpvWK3Y2mMiesd6FC5WqYPsIscB4uulrWLlse60W3MlS4GJ4aLF1XNwkUy8Eql7ylM8eeslr8kMs7fVpT+o/iCP6RzyMaYXIt3n/Qu9cdZMWIfcFasilh05BBlCl522GTS2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AB4XZWXesZljoZIzaAPOyY4SdYQcAv21kuxw4Ljpng=;
 b=k32vBmV2mGE6JjNaFFllDUWxV8ugfPjrb8VUgmLroZtnaasssoSgfJq+SNnwCRyoDxtIoV/sFGMGJy8fX7K7b68OmZHn1UJt8uxsEoQv6jEGHWD+AbCvqYHUQdurkXw+yDJGlbg4U6J2k9fLS5s2/blOlrN0b4jDF9mgrU0DeUrdsB3DcLN7fg5SZM6RWtBXnJMGoDsc9Jd3XTIzKSUZk+cJE0jfsNJDDugPPm0JjUEbcQJdf6/y5bM+zmMr+7tPN0ruBXFVfCwrnAVAtaKPb3/M98xYeC6rpW5V9pCXcgGCSsUDEKss2fifsVEnW6Kvede9iV3T1bl9IUnU5q1iNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AB4XZWXesZljoZIzaAPOyY4SdYQcAv21kuxw4Ljpng=;
 b=Nlq80e3fwHFDsk8g9tjdXTGiXs1bV6/bh7NRGw7NL6dx00lj31zRihXGkIHGu4Oaf49f6Vaa16GPSO62S7x9VYB1fyXipHfxh70qK6U+rOQeKt9Qfy9bz7OR9BLl/SHyAqfekkADBYwJurjhD285F0JhfY3YM3edqPa4MbQXBHOuoHCb04FHKlrztgufmQkR1cUFXF71myBJWC9/YtTqvYL02IIc/I3sGACRIAFwaZ0yTvaTl2g+6bz0uX+h5vi4P4T+kOa32ZeBJz/pSxr2pe1JBAZXLBzxRHi3Aki6ysBsk72ywnlNbDR7w4UcX9Iak0n8v7l7c1DESGuJqxBUBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:11 +0000
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
Subject: [PATCH RFC 01/17] iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()
Date: Fri,  3 Nov 2023 13:44:46 -0300
Message-ID: <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9e9e7f-648f-470d-b1aa-08dbdc8c3bd8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eTi816eQSb7d+B6xW15ZuNHsA3uVIYI8wZOw27r/44a0juzIJ99hfs4das++ha7jT3b0UoOHot7jNoPXsv2IfTr4EjT7/d3mSmsR332X1JQl+sueFvs7Fa4skAop/7nWZJjb/Ar+f2HNgVhQNPrtHrZq4iamHwhl8M6m6j2NvHqafOLdIEZAfOAYV0C0B4d+FHgE8Ff2GYwQ5bEJjgxXiiuUNNGYUqgc83MhE3Z4koTZ6GkZYyRF+N/pG5jqM6qs1ZSGfPUCpT/lbcOuLVpL7hmg2OKJLXmlWEGYuzGsOTw7+FgGoehbkap6Jyxa5vqqNLgkPYAQCmfnOcvy2lPh2DJyD8W0mnxCJj+3E1A7SRoLkWUGtJXmk8UYaCei93+hctYJtfYq7XIeyLIM3E1mQGGEgY4r43cfGt3+/TwvpclkSHyCe4pFNuLv3lKDk/uQ0yFaAkzGY0sNTP4Z6MiHheBDP/71IFLTiNsxY+wuDG7nYxRD1trwUA7204VUx1dA2rhfF2437pR9eZh/E3FaD/vkD6HEhX1bhYqhdjm9jAnQwHQErRBrWxFPNuOrKPaFd53aR0rZUnSKAJQXjmLDthLNJqUEg9mFIVB2KJtvEzj0/1WJShWSOv78thyM0Ylj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(66899024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cGtJBt6kMx8KH8E/UqSQmdkj23PzbHA2EXeXh33FPyHz9fXpIX5TBnJ7JhTP?=
 =?us-ascii?Q?p+rJWISv39Ky2uO9h/hD2etV+9FCQsuWSbA6HgkZ/0t7KB4pmRovJA8X6YN4?=
 =?us-ascii?Q?nO0seOCILmEm4+LOa1mCiUzkBneKFEW4xpKK69++fcBudXdk9ZlnIiVwgVeO?=
 =?us-ascii?Q?ohev0FrvzpcKVUNMdRGIjioIffVpIpi/haANh4xlWFPz21m+QXZFYHi8wLq0?=
 =?us-ascii?Q?YoX5dKAgl7k4sxiJ4cwc6Hefpcg/TZveydjePXEYTV4dFRSABE+PRGef5akW?=
 =?us-ascii?Q?UnfX+aFN2hDQM/zTewGxwvBg7KUOMXos9zBFperzrhlb7+wEe76MTvdHpsD1?=
 =?us-ascii?Q?oVZe/bmtyMZqHw8L81unaJam05SMgXHg8wE3VnIMM4/BaRXsSGfvrJMalrTA?=
 =?us-ascii?Q?hS1YVDGcnCVF6oHDSaM4H6AreLYvDOMv1ZB2MdbsNMnUxhyeP35gyR0HxIzU?=
 =?us-ascii?Q?iZvcdENCKcLeFV4xTitkiYGFjc+CZZN7+b6c5OXTNK2k118NKwBZyxrWvWiM?=
 =?us-ascii?Q?31YzDHI3vehpC1axCuoz42Py7uE0El7/L4+8fUdu0VbozbjCeaO+nLZFlPmh?=
 =?us-ascii?Q?NuEMKKYfLGGtaMuyOn8nzf6hHGYgsrO5HD+0QBR37z9polO00Zv2P/O7ujKt?=
 =?us-ascii?Q?J3QVeou/z1/mXmqux7SKUPYrxMsQn3KOJ8cvKNcUOX5++V3mJ6UQ/O8Zt0ln?=
 =?us-ascii?Q?bz2rt26+IcD3/KL3VzSbMLiXqpclFU9IeWdeqIa5oJDapGT2lOhIdyZLcDOg?=
 =?us-ascii?Q?2HYX4AmBRgWM8IiKu4rQcJ9/H3CsKFJhunh6BvkxfvbW1mF45BdQTvW547T0?=
 =?us-ascii?Q?qrp987AXIaVrxvp1oJUvLyVfZygFAGPeyuDNCZD8zEhq1QHcm5n+GJgAg88Q?=
 =?us-ascii?Q?jicHt7/XQFZBuwu8FaKoGPHc3vCqVZgRoltk45MFLDms7/+wLm5n36lUKTId?=
 =?us-ascii?Q?AINFrbS89mxB0OEupWTdgNGWzcDejlo07beiyxmajnoNMLtFMeQPA9aIqj1w?=
 =?us-ascii?Q?icre78ndL92Y51DlT+US5RELXf2Y8aAw70aEhZkmSofFXLZuaTqJM+ywJQH+?=
 =?us-ascii?Q?evOCNak3DWzl2UZkfoL6VMmYtbIioWusC6TIQ9Dg4cFy7Q+HZHYHiAqy31l0?=
 =?us-ascii?Q?6UcRevGqMjbkhQWCF/vjzmi1ixJHsatXSiERl+lZZFPslSF311FojSFFge4B?=
 =?us-ascii?Q?xKIYBLKChyIIxPaCXU6eyGpZFpfF/IUf3GAy8qx9u3zblMEoBvC8IvTFuL+T?=
 =?us-ascii?Q?geqobkj1d8PHXTr4URM6ISP36uXfPX7FJAxb+ZQBtdJfSRKQty6iDv/Qu+uL?=
 =?us-ascii?Q?eviw6qCeTxgAQ7s+59svgNH5yVk4sutTTTks6OfCbxrOoxw7NBa0q2He59ys?=
 =?us-ascii?Q?9ZTZfNexaBV4J0F9QWU1bIqYaLgz632FQmKdrkLH5QeFeg48P4T5Tuoxi09K?=
 =?us-ascii?Q?2jrt33S2w57JyHAcuY1soGgXPw5zKYsUDTN+0ABcYd0LBXtBTtv59PH3Rvg5?=
 =?us-ascii?Q?7LFndkIcqz78YM3rd9vT7IgWKO25DCExjnVy1B2XMvb7bXpRTyYhUjW0ubkw?=
 =?us-ascii?Q?krZj3MlM1QfksBCLQpU9pWotMnwHYsXK5rXQalkt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9e9e7f-648f-470d-b1aa-08dbdc8c3bd8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:06.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKk6cWIfsJ54ovrx2UL1qkgRDtLr8U4AdtaNGR7Sq6cnnm4GxyweVBSHgc2VGN7h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

This is not being used to pass ops, it is just a way to tell if an
iommu driver was probed. These days this can be detected directly via
device_iommu_mapped(). Call device_iommu_mapped() in the two places that
need to check it and remove the iommu parameter everywhere.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/arc/mm/dma.c               |  2 +-
 arch/arm/mm/dma-mapping-nommu.c |  2 +-
 arch/arm/mm/dma-mapping.c       | 10 +++++-----
 arch/arm64/mm/dma-mapping.c     |  4 ++--
 arch/mips/mm/dma-noncoherent.c  |  2 +-
 arch/riscv/mm/dma-noncoherent.c |  2 +-
 drivers/acpi/scan.c             |  3 +--
 drivers/hv/hv_common.c          |  2 +-
 drivers/of/device.c             |  2 +-
 include/linux/dma-map-ops.h     |  4 ++--
 10 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 2a7fbbb83b7056..197707bc765889 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -91,7 +91,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
  * Plug in direct dma map ops.
  */
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+			bool coherent)
 {
 	/*
 	 * IOC hardware snoops all DMA traffic keeping the caches consistent
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index cfd9c933d2f09c..b94850b579952a 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -34,7 +34,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+			bool coherent)
 {
 	if (IS_ENABLED(CONFIG_CPU_V7M)) {
 		/*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5409225b4abc06..6c359a3af8d9c7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1713,7 +1713,7 @@ void arm_iommu_detach_device(struct device *dev)
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    const struct iommu_ops *iommu, bool coherent)
+				    bool coherent)
 {
 	struct dma_iommu_mapping *mapping;
 
@@ -1748,7 +1748,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 #else
 
 static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    const struct iommu_ops *iommu, bool coherent)
+				    bool coherent)
 {
 }
 
@@ -1757,7 +1757,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+			bool coherent)
 {
 	/*
 	 * Due to legacy code that sets the ->dma_coherent flag from a bus
@@ -1776,8 +1776,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (dev->dma_ops)
 		return;
 
-	if (iommu)
-		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
+	if (device_iommu_mapped(dev))
+		arm_setup_iommu_dma_ops(dev, dma_base, size, coherent);
 
 	xen_setup_dma_ops(dev);
 	dev->archdata.dma_ops_setup = true;
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3cb101e8cb29ba..61886e43e3a10f 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -47,7 +47,7 @@ void arch_teardown_dma_ops(struct device *dev)
 #endif
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+			bool coherent)
 {
 	int cls = cache_line_size_of_cpu();
 
@@ -58,7 +58,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		   ARCH_DMA_MINALIGN, cls);
 
 	dev->dma_coherent = coherent;
-	if (iommu)
+	if (device_iommu_mapped(dev))
 		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
 
 	xen_setup_dma_ops(dev);
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 3c4fc97b9f394b..0f3cec663a12cd 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -138,7 +138,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent)
+		bool coherent)
 {
 	dev->dma_coherent = coherent;
 }
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index b76e7e192eb183..f91fa741c41211 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -135,7 +135,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent)
+			bool coherent)
 {
 	WARN_TAINT(!coherent && riscv_cbom_block_size > ARCH_DMA_MINALIGN,
 		   TAINT_CPU_OUT_OF_SPEC,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee7e..a6891ad0ceee2c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1636,8 +1636,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	arch_setup_dma_ops(dev, 0, U64_MAX,
-				iommu, attr == DEV_DMA_COHERENT);
+	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);
 
 	return 0;
 }
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ccad7bca3fd3da..fd938b6dfa7ed4 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -489,7 +489,7 @@ void hv_setup_dma_ops(struct device *dev, bool coherent)
 	 * Hyper-V does not offer a vIOMMU in the guest
 	 * VM, so pass 0/NULL for the IOMMU settings
 	 */
-	arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
+	arch_setup_dma_ops(dev, 0, 0, coherent);
 }
 EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1ca42ad9dd159d..65c71be71a8d45 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -193,7 +193,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
+	arch_setup_dma_ops(dev, dma_start, size, coherent);
 
 	if (!iommu)
 		of_dma_set_restricted_buffer(dev, np);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1a2..2cb98a12c50348 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -426,10 +426,10 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent);
+		bool coherent);
 #else
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-		u64 size, const struct iommu_ops *iommu, bool coherent)
+		u64 size, bool coherent)
 {
 }
 #endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
-- 
2.42.0


