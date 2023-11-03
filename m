Return-Path: <linux-hyperv+bounces-671-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0AD7E06D8
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED2B1C2109C
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB841CAB1;
	Fri,  3 Nov 2023 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/OsCeKG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F01CF82;
	Fri,  3 Nov 2023 16:45:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51FC1BC;
	Fri,  3 Nov 2023 09:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLnkdNDUhe6sSiRX/hKITZxDyEMPE52fp+aQsco/UMGRldTKgOwY2AK6A4776fJ2e/2/9DIQ7Zu6C/5CbtxiD4I+9aO6TTmrogLI/LW3NY9JOlg5OIvOr620xgzcd9vy6oakKDqT+SEWGIyZMlxF4l/MLaQ3J2zt1aY7etplq5C3igbTfjiwNtrrL3qx/ch46VXYjpOJysI+qKMCEOFaqsiV33nIqMWOW2Z/MRBWoF4FRqh+QBmqrTbBzrPZkUp6qgpzq9ApGjVCYFtvpoQmWnGzhkavBPpvXS64coSsqw0GGD7KiduX08bG65F+0u9MX0zK6Z//Em7bJUVa8rTchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmE0NhIPVyfgk5oqoV569KUNfHY8bHemcOTponDtm+w=;
 b=B/OiKWX3xPwMBuSWYVJfVkfyDobbvjPhE/mAvfXGYBBkaPlt8tT2HQzV2sBqHNzPejS5ohgmCfUXyJrXzB1BpR5C/Zh2W6LNRl8yFai7ORjXM6lbWlontTaamzCI2nsqtdhqfY0FMo4JHYY5JPMcWtBk25CJOUfjLtajeIvdlj+e4EnOugkHpoiwA1AGpaXrQaUD+jPhD0H8yJ7MkupT2xMVKKObXyktzjcr3hmiPOFWmenJqn4c7ZQAluK7qU/ZRMA42dA1F5WcPu2HKg1W9yQlMJWZNEc/alDmioT1F7oWACrCPNbYU06sgGHzt4hekgubTRHF7B7arXsO8UUF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmE0NhIPVyfgk5oqoV569KUNfHY8bHemcOTponDtm+w=;
 b=L/OsCeKGNV/oDH+CnJPsnhvvLVq/l2ywYQbUZ3Q28jaMMKyVzG5LdPah6G+LR4z1WW6WzCMnb8uBN4JDbMKyCzeThgtG7v2rJuii1qbc1hoPY5Yqo5oJwM4cDyhKgSWtBm0qo7jdXfBWFR6irJ7QQAHbDqS9JUhY/B+h6UzZWjlOkqbOfMqu221KZKI2WDgQZk5dE+NQggXCUu45cDK6tCmqEp69n/KGZ3w0Xw2O17uDMLhs18YTlA/HiI+0WIsAosyKRno8FEzQCoZvj+FpZ2kMUz4FjLXlY8ZYTFVEOOe+hkuLNQ2Tcw8smJCQW8qarg3jR08WFk+lY0o5HOfoLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:07 +0000
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
Subject: [PATCH RFC 15/17] iommu: Add ops->of_xlate_fwspec()
Date: Fri,  3 Nov 2023 13:45:00 -0300
Message-ID: <15-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:208:234::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: ff239b23-fe73-4c29-3348-08dbdc8c3ad7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QQaLaRWBr7IY/OOb8TX5+dzTh6nuj4g2Y9jAcdXBB3NFa1WZYb3Z+Hwe7bAeY7eCHLFz3CP6oyClLj82ub3UyLqfQdSTCbj/BWFnVhLCfWx1r0ajBHfpPyxFpvJtD+2EQ7AG3ze8QEUNH1sJSX0BUuhJeZXj3fPJOxok9x/diHhcz1enB1ADZ9dYJUJIuiWbfkYbkZqbvRHTT0aCj5ia/sDLK09YTgJNzv9XfBEhJ2ABcieeo1j5XeY/ov9NeWFE7n4FKXPi0oy8MoGPlQPBBJu2uSatXHvWVpAtkdG+Hl4Ul3hJzbN79fYX9GDjMv753Jw/+7MEEyfbrvALxsN0bz5w+vWPrZOCKFsGGyhb4kfYC2BTfiqDaZLxFkn7A5H0J96P7vtAF5VizaWKAZYGQ4RQuStA4VUaDpiMm7hBb0jg/vbSDQVPiDHvjDSQHCOXadprMqkAyovKbyvAgP1MH/G6/Nli8Jno3PeWMlL9ba+nBDvQUpQRZ/rVmZ94HPfg8FYANHaeBc1jGA28fa2kdwCqYhZPuhDzqQda9pBrI/k+i9h58PufFrBoF32+4/ZhtQmy6sCUnoprnm7c8xU3ZFiJ7pc1LzPgi78tfO+GGx8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(38100700002)(2616005)(36756003)(86362001)(26005)(41300700001)(7406005)(2906002)(7416002)(83380400001)(8676002)(8936002)(4326008)(66556008)(66476007)(316002)(5660300002)(110136005)(478600001)(66946007)(6486002)(921008)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cAVU1gLjit9nMW/NCvVrYENNumxYpu8A4Ru9pz7+O15IwhWfRGKKEBmlqaxs?=
 =?us-ascii?Q?lIIKKnWCJSogPAg6KYVSp43SW5VhzSgKE4AZLCzfCUvzqrsf1jPpNHLPuZ6S?=
 =?us-ascii?Q?AOXqu/CWfMk2a9IPD2XTqLhfvKXL38jw892xFPiJxqG640UdUvkOn+1NEVvT?=
 =?us-ascii?Q?ijrQ90K5gIZQE3rI8Igv3jMxWEQaPA+0oFvRetyj8/4YNfESVyJuQdq7X6Fz?=
 =?us-ascii?Q?ar5KTidfip+82P0y0Z9VOsj3B3a9GxB9P6V6G6EIuMPjLVoFaRR/M8pJ2e+p?=
 =?us-ascii?Q?yLVG2W4eBRFiyEzl39QlD40AhQjJKjU7wBBoZTp238/ozq5S0tqkYUgm0Ok+?=
 =?us-ascii?Q?mY3TCHO5WMHqoiXcZ6uXqQCw1nC8F3ZuEhPwcEG4Q9gHKuhUXBJmDgj+C466?=
 =?us-ascii?Q?/tBja6Q3xFmm7VNk6O3MDBh6GfTcKds0L6A0tJU2e7HXt4DE6kjawo5YjxnG?=
 =?us-ascii?Q?ILlZPNZ1aUSdNa351M7619RaGrUj8DW3VeWPEdUB9brunq89D9hiN+ORWZrd?=
 =?us-ascii?Q?azTRq7mBk51RhwTpUkWhpertx77TVOnzeb+8AIZiEn10f8wYUBBLMHsiocMd?=
 =?us-ascii?Q?cIWAzqmzQ8BK/oqsY8VH2KfKzAKRYglF203NtQZrUT74Kt7BImEwBrRlmoE4?=
 =?us-ascii?Q?BBE5XuGDtfRSsWAJ0ayPMenykMuPu/4/2SBAJvICvKkupF7I4S4l2a3fZ553?=
 =?us-ascii?Q?JXD+84OOwUJxXq0kATUpGMyuJjjPSG+BKYywOTUYIucUoTZcA7Bz7gPf/YEw?=
 =?us-ascii?Q?+MLzvryUioA6dOMcTLm2ouYNGs4Xg7ivwT0uubW+z0xergoa0C9ifDmD+Bgh?=
 =?us-ascii?Q?Prj6V6Dpf112csoew/vBwkDRc/tT0T7OaQTzP5UF1TUrm0JDDDXXR4BSTeoy?=
 =?us-ascii?Q?l8aNjZDTWwDcrcIU/W9Dci6FQ8VVm1GcwIkXV6tp4eZhDuC3abnSc2JEflUM?=
 =?us-ascii?Q?ti45BP5ZzVMcJqDIMzJ4ESEe1opw3VgXp7Fh2kyLF783IMMZlNy203iTX7I3?=
 =?us-ascii?Q?skapxb5TWuUzKBxU5QqfgE0C6FDArJryqzmqfJY4prK4KIVTsT3x6VBIBkUn?=
 =?us-ascii?Q?p+6HJn6o8Penm1NNcW1D0EGCBdbDmITxtlNM3nFpoLR3dohlze0PECnct2uJ?=
 =?us-ascii?Q?Oitkrf7zSX/dqMgSsBrdXXl1Td141uCbAIgxo5KqiAD/OO12sX1+geLZtOaQ?=
 =?us-ascii?Q?FHnVHM89baBEKFEqOy8ByvknZ/YZZt+UkXuzuEuJYNXXyxnPEG/wDUkpujiv?=
 =?us-ascii?Q?zVJ4cjYeaLzo3ZlA6glL7Ezx68IO426GE8IYpqS+FuK/+7OWSUvAweR3bTaC?=
 =?us-ascii?Q?LbVEQqVHOHx1EdT+/wO6AoW6Wsp8Z5Xm1eg3esfs9D/3iVc65cOsgv2X8HAJ?=
 =?us-ascii?Q?S1lTIgulRpQkgsJkHT6UYVcpNgkFj92FJfZ4ZxBKqRl6/nDBYoo0LIE9wwSM?=
 =?us-ascii?Q?En8039zcKnEvwYHS/K1eAjdZFgLhtehmQ/RKVlre3Cy+9zOqDS3tdZOGBjM6?=
 =?us-ascii?Q?0MQwIda7rOF8AaVdblMGI3SUP90Q87ssIQdMjjMQSsxBT+SAtsnwg4SSA4mi?=
 =?us-ascii?Q?I+BaXs4kMHPhXKPKeHj6SFk3O11tyzelA5hQml0u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff239b23-fe73-4c29-3348-08dbdc8c3ad7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:04.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0Qw02wNFYpBZkFKEQZGiJKDdQdPClZqngoZEbUhJfy14DilRykbJyXsRgnJZfBl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

The new callback takes in the fwspec instead of retrieving it from the
dev->iommu. Provide iommu_fwspec_append_ids() to work directly on the
fwspec.

Convert SMMU, SMMUv3, and virtio to use iommu_fwspec_append_ids() and the
new entry point.

This avoids having to touch dev->iommu at all, and doesn't require the
iommu_probe_device_lock.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 8 +++++---
 drivers/iommu/iommu.c                       | 3 +++
 drivers/iommu/virtio-iommu.c                | 8 +++++---
 include/linux/iommu.h                       | 3 +++
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7445454c2af244..b1309f04ebc0d9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2748,9 +2748,11 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate_fwspec(struct iommu_fwspec *fwspec,
+				    struct device *dev,
+				    struct of_phandle_args *args)
 {
-	return iommu_fwspec_add_ids(dev, args->args, 1);
+	return iommu_fwspec_append_ids(fwspec, args->args, 1);
 }
 
 static void arm_smmu_get_resv_regions(struct device *dev,
@@ -2858,7 +2860,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate_fwspec	= arm_smmu_of_xlate_fwspec,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 854efcb1b84ddf..8c4a60d8e5d522 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1510,7 +1510,9 @@ static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate_fwspec(struct iommu_fwspec *fwspec,
+				    struct device *dev,
+				    struct of_phandle_args *args)
 {
 	u32 mask, fwid = 0;
 
@@ -1522,7 +1524,7 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
 		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, mask);
 
-	return iommu_fwspec_add_ids(dev, &fwid, 1);
+	return iommu_fwspec_append_ids(fwspec, &fwid, 1);
 }
 
 static void arm_smmu_get_resv_regions(struct device *dev,
@@ -1562,7 +1564,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate_fwspec	= arm_smmu_of_xlate_fwspec,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14438ffb0feb7..9f23e113f46bc7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3000,6 +3000,9 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fwspec->ops->of_xlate_fwspec)
+		return fwspec->ops->of_xlate_fwspec(fwspec, dev, iommu_spec);
+
 	if (!fwspec->ops->of_xlate)
 		return -ENODEV;
 
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 379ebe03efb6d4..2283f1d1155981 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1027,9 +1027,11 @@ static struct iommu_group *viommu_device_group(struct device *dev)
 		return generic_device_group(dev);
 }
 
-static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int viommu_of_xlate_fwspec(struct iommu_fwspec *fwspec,
+				  struct device *dev,
+				  struct of_phandle_args *args)
 {
-	return iommu_fwspec_add_ids(dev, args->args, 1);
+	return iommu_fwspec_append_ids(fwspec, args->args, 1);
 }
 
 static bool viommu_capable(struct device *dev, enum iommu_cap cap)
@@ -1050,7 +1052,7 @@ static struct iommu_ops viommu_ops = {
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.of_xlate		= viommu_of_xlate,
+	.of_xlate_fwspec	= viommu_of_xlate_fwspec,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e1f9222bde856..2fac54a942af54 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct iommu_fwspec;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -287,6 +288,8 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 
+	int (*of_xlate_fwspec)(struct iommu_fwspec *fwspec, struct device *dev,
+			       struct of_phandle_args *args);
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
 
-- 
2.42.0


