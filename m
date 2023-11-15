Return-Path: <linux-hyperv+bounces-940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2E7EC46C
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996421C2094F
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E4250F6;
	Wed, 15 Nov 2023 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWvxn6xo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE2200DE;
	Wed, 15 Nov 2023 14:06:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EE7C5;
	Wed, 15 Nov 2023 06:06:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esCQDfezoD/VowsiDoFIDFZyUy5Kvi47d3kcy88MqKuJ3iNEhpzftEv90pOsrzoIa2WaDaCbLkOly+xcp6lDpdEjHoeO3yWZmX6i42i0J8/AA7+mMOHnMpFAoDNj1fRG7mZua1Xy3IRqOAFxpSNkUF1t1v3Yojl8Zl3zrH+YzNOOsYTNLxI8UPSwcQObvpNPgyRDUw0A6NB7aHPk6rswpS/MH3XdF0VV1T8RAQHpHLYF8tfiWyo+WI9NBQBhM628I2ZZfOdcz1fdeUmlaQQP7kCE54fZHTeJjz3JPdxx1g9nIRzMY4ZGBLUBK3AG141WpQAaTGSeuYnpnaS7yHNzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnk8VZMJeEWOu5/vrLtngXrQwOVU8fsBgD1gDrSstNg=;
 b=hhL32thCbRSMBhwKhXLJBSlM/qLCqLjiwbvJwC0FICwY9AOSiH6A8T52d2MoAnp0o1jzdrTKk++GbrgiGB7T+0Cb5UKoSW4yN/FDYDEdqM3Nl5rEhEIF5c2kHDEQAXLL9Ks6VidyY+3pO8liiOf2+I5OBaiEbWlWZkoXbDO3XbM76mDL3FMwJ0xdf9C4st5yPqwArGStmgu3fihgtUrqhp/4kAcuTx0JGHe/DpKQ5NR1bH/SWjp7KJ3b++WNwGPmtAJDnZe5NW9DLV2vUGwJUhYknmbzimDhsCeVh9va7PRHSl5rrD6IvBJ7XNuBX2c+wcUacVcBF3aUfSMNZ65CCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnk8VZMJeEWOu5/vrLtngXrQwOVU8fsBgD1gDrSstNg=;
 b=PWvxn6xoAvVBp7nUkVIxZh/9XH3NFYA25gN1ORSA93SSAQw6O9ygDCQTNp4z2J2q+4wU4MBFgWF6yMs/2mkhzwZXMXdkU/v31moRm+JR1YhPImn06CieWgGjIloT+IyivxwIFOflFRmGDF7Lyxu7qzv0aOV8xfhpd/hF/9PSCPnNA9Y3RCxObljhaf8nsUVFk7rAY+/Ia0PR22kRxbEIHFbVn3daJMZixpagv3ynLgvLB9WzxBINxyUZeQyEKi91p2N1eaOqTucxFx5o2UoZjhjeCGWzzWfxuZbHaRv9cQ17svI+5VXrtz+/QZrT6yTKekVlDQAosZ2qL0vy3VHaCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:11 +0000
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
Subject: [PATCH v2 01/17] iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()
Date: Wed, 15 Nov 2023 10:05:52 -0400
Message-ID: <1-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 529d66cd-e412-498d-4a9f-08dbe5e40483
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0gCY+Ym8EtLaXF0idmv8eBZsOt0ZR2YAsRF660hQrp3EIl0O6FwmkLEeAzh9gegD1+OZViyptSfLDyCVZ8826Rth4QZlWhd+DnRy4kP/CuhXiDB/QZQEINH480RqnKTQff7ttp4NOtw0+5IH1aXRIRuBom3NfUm0fJatj6B3CfHOcHYbKJS4GyFdNVzfQN3vSNPD73aZ73Ja4Vg76QdBaKMKcCu9lL43i75SRNA0dzF3vzMJMIev0UA3oNh4A4tCyH96r7y9lKRLKfS/a1DR1KjkmfbcbaAfeK7IAPKW+1RZ4sG9wcejEwIVqFiG0QoFDhO8RL4navaXuJTgiApDtTTBt3Y+gpr8XhFXgOiwqlGwMuKKOt5wqFF3oLdtOcBMhCaNU54UJwiIiGne4QlSWd8hLLOX3oDmFyaqcOKHYHqfinluOSfKLc9qEGQLjLqIArX0J2CYFy5OmbRN2aeQeKOn+4/aM48mFhxw44hEamovQnxVB/150REIRW3RGxu4eSmTRTkx75rOmbkT+3wtG8IYfMbBhbB3r07nGac0dRDwPhC5wjsBQrbV2IFsOUK3tB0FOTYx5zK0mM2RyDjTw86EkkSUj4Td872gA/iE+ESsdJcPJeje9OhZyLXbsHHW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008)(66899024)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxicClb42zqzzbk5CRq5SS7TF8hlGviEoIfKZmp6AgFTjqC5x1+eWNO5F+1W?=
 =?us-ascii?Q?nS3wdz01ItY/EugCvFGcRQAu2TC2IbZ4m2ZBtfZ2Zm5lF2CHVtyXeisYO8kj?=
 =?us-ascii?Q?jLF8ENUZKTnoWSesByLNpqwHpEoMgodKMg0CaXWMGnEEdi4YhhkqhHB7p5+G?=
 =?us-ascii?Q?TXTrYN6VEX3wVMXKyihQ/MtJoGJfOWya6V01IYIHASaskSfSsKHxHYCwDc2/?=
 =?us-ascii?Q?KqqTVJpHd8Kwx6qcRKtwCOKNRM69hfeFDL35sk1QpHLTsjtiWetB0IpMXPyW?=
 =?us-ascii?Q?j+q6u7UUD7aB0ZFmBJRusUov6Mh/kw7H06Q1Blbhstp26d07pYLnoGJkv/VR?=
 =?us-ascii?Q?42IHhV9YKu8UO+PlbRmXO3s7FAydcESyMPVf468UnVSKXIR9f/5kd10JFa4o?=
 =?us-ascii?Q?6Sra1Dkoj/gWIQBu/kjHHpZ0Q4pnRRztX0TP4oNDu1g4hWIavPT9ZAlx8qnY?=
 =?us-ascii?Q?uvSemJ2FR44oJLXomAv/XS9AOJ2XRBEL77o/OF72yDBbSAfd6aH6RT6BQ7iO?=
 =?us-ascii?Q?1f8Vsv6U/QwNsX6FaDaEgccTjlXFtYWXGt7nfrxbBarmWGANR+fvKsI9pO26?=
 =?us-ascii?Q?STUhuPiOjT7WEQsty6ynUQVF2MJmUDjorDz4tfJHmzKwKQBGyL5kH+c87usv?=
 =?us-ascii?Q?0T/UrOFsq1PSkaiywEHKrTqCDc08IVc3dwCfrAGGMy1/xtrBAR01ZtZ5e1Dc?=
 =?us-ascii?Q?B1zX/EyApueplcWvJc7KoCD8T+Ckhi+r9LtsZjj9XK9Y5sEiTLbp1Y1TCuN8?=
 =?us-ascii?Q?w/PEjz6AOblp3G6PvhA7rj7jeAUskLYxAbffGqdJUluIAbu5mU6qGA1eZast?=
 =?us-ascii?Q?n019VYVA/Ksw878amMLRS+OEpcSTHR8Pk6UlZgR59rhhITaco7ETJ/LBL3zp?=
 =?us-ascii?Q?PubBxuF5rRm4hbjuv5Tr5bGDAXsNYq4Xt9/DDemMUu4vvB3qIko0cVLIYWpF?=
 =?us-ascii?Q?7RLiFIOypmYYOfUqCu7VauGdWITuHs93PyQAKT5Y+mwTRIIRGi2wrCobmY3L?=
 =?us-ascii?Q?VbAvjZniYQWgOBLrEzlsoKDEmZCJAUBjH4oFHwwMBlWvJ6xrtAncye6pdUn8?=
 =?us-ascii?Q?QRdZREplARwrBiioqwZPeWo4NjT3lWJ5++7V3yIWez5SZ5buENfpg8riphhQ?=
 =?us-ascii?Q?8NeR7rR9wgK8+cqEPR4cfeC6wnU6ProrTmBzgBnYhuc+cos4h+Q7zRDvieuT?=
 =?us-ascii?Q?EFyV03JT5y3sq0/C32JrKLixaQz1f3WL8vLB4fewt7bKTiuAe8wD6sBB3y27?=
 =?us-ascii?Q?g/+NdDdzXGmKUT8HirHguuE6r0DLEtSvW6550cZtodI7c/VBkWEJLvCHrTja?=
 =?us-ascii?Q?3sPePhFX5TNrePplqjO1n65CNEiyjhL1tHUCbnZIcKCqWyiMgvwLDIcDnn5A?=
 =?us-ascii?Q?UD6VeSJEUgL91FvvgfgfLszrPjOQshwSxaV1NfZYW1LtYFO0Rfn6vwGOBFjm?=
 =?us-ascii?Q?5TwjhF7yj+MsFqsXnxZSnV7dczgUcEKcg7GND92FYHLcAi2mMGKXpcWSOuqf?=
 =?us-ascii?Q?i/DJ3Z5yvfU8jj8I62ulcRWljZb9s3dxl6ShDCdxe20AjBrMItTLNtqVRZVX?=
 =?us-ascii?Q?g1pc8nrYBpCUZFXIQsY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529d66cd-e412-498d-4a9f-08dbe5e40483
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:09.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTHc7Zw1a9Fani+aerdNTNjb/5AZQI3t2tk74t7C6SUiSrPZbqsYPslwg7m2DeSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

This is not being used to pass ops, it is just a way to tell if an
iommu driver was probed. These days this can be detected directly via
device_iommu_mapped(). Call device_iommu_mapped() in the two places that
need to check it and remove the iommu parameter everywhere.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rob Herring <robh@kernel.org>
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
index 4e4e469b8dd66c..843107f834b231 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -129,7 +129,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent)
+			bool coherent)
 {
 	WARN_TAINT(!coherent && riscv_cbom_block_size > ARCH_DMA_MINALIGN,
 		   TAINT_CPU_OUT_OF_SPEC,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fa5dd71a80fad9..9682291188c49c 100644
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
index 4372f5d146ab22..0285a74363b3d1 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -488,7 +488,7 @@ void hv_setup_dma_ops(struct device *dev, bool coherent)
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


