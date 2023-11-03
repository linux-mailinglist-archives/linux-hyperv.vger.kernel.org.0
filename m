Return-Path: <linux-hyperv+bounces-675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262507E06E2
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490781C2106E
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35E1D53F;
	Fri,  3 Nov 2023 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cs4ItXs1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160571D559;
	Fri,  3 Nov 2023 16:45:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8CAD4D;
	Fri,  3 Nov 2023 09:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mahylpz52DFhI16dTIWrr8zgpziSsvJ7/HMCSav+Ko4DI31knDL4Gj89E72gIUvTnkch/oif4VpsVXMKLhRC0LEEaWCwLbn1c7QnE9JAXlPQztvLuSMoCQf5jm1G2A51uMpfMh1hoGo1soop5k+LQm+B9SNd04Ls0E5VFYSmcDVxVYkcgpa4Gb6rLzaFATiZQLGobMlEvW2NDAJvnQnIy8x5vuHlRa4zimGnwx42lI8NuItc1EsvdSj+tU7Pgoe3AdDcKpN/1/pA+XDTw9PuvosARvfxCZKIraJ0ROBMxF7MoaXU3IzR3Q94Y3MimtLsucVlw4RP/6UkjVGKh+JKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amWEmLVGHcqZlQAIojeO7Vy3AmHrjvzfegrj+mYY+d0=;
 b=IUxHfrZ8E/ym/2amQK6dJb2HCmMUEafzU+IHpeCzY3rJvO5yQoFxSVIhxQWk5E79mLPJ8UTXE17SWOY8w0DEbuxH6FOsusYmjVJZa8VP+kV54G6sqKHF5N68iGrRHVXBzSzF/ixF+sZjDpMf1zpCnPJYmd6+6Vnm6cm5KLu9NGMd28lXFBhuFPAJP1MijYNZMFfOYOVoZ2HmN321JBgyH+IGMVbInajBRL2/GO2niGKfRYrKw+eC34K7lxisLCOO8CEqoEOaMEQ954svp200UhherPgFVw0dFvJuDgNqHbbpqKYULEEJtWcPyoF6WCtnVml5VzAfrMoViXLw582cBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amWEmLVGHcqZlQAIojeO7Vy3AmHrjvzfegrj+mYY+d0=;
 b=Cs4ItXs1Wq+hxCZk4+j1cz4TsykKvVS3gEPeRmjhkw58h+L1jv9L4ZI3zCndmJVMxOKhf7DSW7Lfou7y1gtdjb6ZiZNYGM26r5jF2oAIrczKyIg+Ns46G+WgkKOr7ogMJzJMUTHbtB4FIugJjQwxEVVtwMsINifvZONDQzPqZ/OHDtN2ELMKzC1EcBJ0O54w6Mlzr6ZWIdgzOlG6fDFeez2yf5gD2IL/FP3yyjbwLWcqa6boDgkeZjNMbqPjNkkfzfwWyQAxiRn+zRlHjYGtBJEUQLW3tDyro7KzxzNjf76PCgX/v0RJlvi8Zma+SCjbbuxRbwmC5Pyk8typVcQt6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:10 +0000
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
Subject: [PATCH RFC 14/17] iommu: Remove pointless iommu_fwspec_free()
Date: Fri,  3 Nov 2023 13:44:59 -0300
Message-ID: <14-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 05205c05-1bb4-4825-54dd-08dbdc8c3b5a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fmEQmmP9grP2QMwE0KA26zE4UXz4QIwNTqLTRkQBOtuDu/Yz192mKNZjnbBezigbCbu0yFdt4dQWyteutEiMzUqzMEskCHycXCzqn+5Wzj9TcKKYIyd0fDJxwg4BDbTrAdhGKBVh1owYapc+KNnRd1zcXwt4fVt/hWlphbAGxRI9LN3Wbi/ProYtx3rZacmXaWwiSpmZaSLV+DfLT+NMzTdsgT2eaIyNqQb311PKmUsPXpE6dy43Jm/O5QpoDUQ5sqAaJFf3pN5/D/1gXs54oaF0i5wc25RVtKVglvGD9dxEn4DrBVJowFG2hfauPRrrAq0FK9RKLmY+p1WzfQzrYFvTqX6KMw1zqYg5wdqrHmyNCixUn+B65175lHBu14YV8somcX4KkfW7kUTxDKztQSreS3CYXNWUSnGVev8yl44ye/7TMpdy+bjSJJVPAVR3RQA3YzMpNzV78Y4Md1e6BhEuNb4hx6eROrHojuWnIoXHAURLdVxiJDdWNi0gqpyqx/KIcwxqGayn0GslNOalcfhmmxL7Wuk5+RE15ozn53mpiCQh/1klfAdUr1AYr8Vpy6fGap4tIYXglw/ULOt+3O/RjvMklfMaNNFlurVwCS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+JRanyxqooHX4QiVwBe0a29nounRKsKhgKimAAy9zuxrcgtrUgKqQJS0AfSk?=
 =?us-ascii?Q?dWlUgaWD/YyNXSQzn2hqrvpIeRNZ9lb1kLHYMm75V1vhsdc13KmSWLIsCV7x?=
 =?us-ascii?Q?U+R+IsnFGAz+rRbSCs0nTAIc0hnwvXmqdvfupqGPqH6GR6Kfixo8xfNdEuC3?=
 =?us-ascii?Q?jNyTlFZAUgHsdovpnHpFvlYuCO9tU9Nv0qq14+vK6vtrWVAETh03zqky/Lvc?=
 =?us-ascii?Q?ULKxhj8Toar+4ZM4GYhFdrXIVoPeIXgb9+F5xS5YCwYdJVaB0W9GwywO8imG?=
 =?us-ascii?Q?VHgR+uJ8q1iD8x66rUu7zMvfQnU4TiXxTw0ox8uiVTYdlc4MAdkoFVbVEmTL?=
 =?us-ascii?Q?df9GdMMPLAyCotaIOoBPSFuJPfFjaC98cmN9cTCfFNcjgqiOBF9Fj4LY7X+2?=
 =?us-ascii?Q?XByWZNAbzKvryMcsJA+1Na4oMUhAv3nZ7qQRawGn/vnzeID5w9D8sU4O9Rxc?=
 =?us-ascii?Q?TRmGxqMnH9AYo4Uc1Fm4Halc1D3okfs6+swcLk68ujy81JrgJ/2lMfVJ3jai?=
 =?us-ascii?Q?9hJ8N86vEJxE354QjlXyrUvnb8nQWjgZSYz7WKRRNvjP1cP5RgrX37qfHTcc?=
 =?us-ascii?Q?Oz7kmHO2BNrlc/2gG31RvAPf5gdg3thlLfhedTQd+29z7rGtQtwUy6FRCqpG?=
 =?us-ascii?Q?9GTkj2D5Fxw54kicag3ZyeRKjIwwOPRSs6KLRs6ZXAC8GVA8NWpH43YN6y5L?=
 =?us-ascii?Q?7tsAuJCrednRZoaeZJVbcQjgKDUXlvkMNwlCzv/PqVfQQb/WU96z06VlC06M?=
 =?us-ascii?Q?INPs5kLsIRKhwtdBKgZCK1uBSsCmlBtMwZPcAGFuMEs34hwyksWR6TGoUtDi?=
 =?us-ascii?Q?i22XYsVejNdZLXz9Mo9efj9/S4d0sKqWKBgKW13rO85L/OhNRnEo68G/fgay?=
 =?us-ascii?Q?l7JtKJeeUJ8J4KblVinHMauGVEyLQVUzpTm/vVk1Nhdo62nuIHFX2P9yK/aN?=
 =?us-ascii?Q?jo8u2ysvHYpcZUzNEyopHI+563y9Xr//aBXcQk5WVucuNMJ07eLVyw8nZ86L?=
 =?us-ascii?Q?d3+xTFVxVXgoVTIl0+ZsNNu//ddSIIFNTZVyO35PEy0FbxX2M6H19cl4XaIT?=
 =?us-ascii?Q?Nx23Evp7VVz7ik+/UzarIrFfNa6yS+ZG6ygVfoZbXL0vbGTgIMVyYqVQ+t80?=
 =?us-ascii?Q?3lHOs0rAO4JORRZdMSe8ozZ0KMJmXG5mYAXTbTiQMmv59l5Or4Fpv12HSk7c?=
 =?us-ascii?Q?MAfEq8LlxDz+Cr7SjJDqrsGHmlPiRiDH5WsxkwxZAGvFHcgk47H+V3PNeJ5d?=
 =?us-ascii?Q?Z3cc0J4YaAnuh1PTYu4Wdt92MahALAg9hxuKMSSXLYpYuzUFI5jrAj6LdoFH?=
 =?us-ascii?Q?w3wbeapXYwCSCgSoz8c+ZHrzF4zt5rsuNKRZV43t8Jv8oWPAHgx/XJntUxSs?=
 =?us-ascii?Q?b0Ta/8MLFqNLkZ7eCi3rRkIgrtQfZeU88FiFYUSn0sTOaxsqd2plXkrwQc9K?=
 =?us-ascii?Q?w2uptV2YoQm53KdEbxHVTmzNtA+0ukQYfe9MUq7ubNQxCoCzkp8TtpIvm7iO?=
 =?us-ascii?Q?zeKZFNYVP9xyK1l75+OJMrulkEq9AYrUsfcgykZXOyMaEV7H3HmiK66NGSVp?=
 =?us-ascii?Q?a3HuctSM31b6I+13vlOCIIoUL49+Cgpa5qEG1psT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05205c05-1bb4-4825-54dd-08dbdc8c3b5a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:05.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udVtLTt/aWa8SKh55Z9pQlk49l014PZRGCE1+6iYzvp9uzkCjvol/Y3RhRKldbdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

These days the core code will free the fwspec if probe fails, no reason
for any driver to call this on a probe failure path.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 14 +++++---------
 drivers/iommu/tegra-smmu.c            |  1 -
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d6d1a2a55cc069..854efcb1b84ddf 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1348,6 +1348,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	if (using_legacy_binding) {
 		ret = arm_smmu_register_legacy_master(dev, &smmu);
+		if (ret)
+			return ERR_PTR(ret);
 
 		/*
 		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
@@ -1355,15 +1357,12 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		 * later use.
 		 */
 		fwspec = dev_iommu_fwspec_get(dev);
-		if (ret)
-			goto out_free;
 	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	} else {
 		return ERR_PTR(-ENODEV);
 	}
 
-	ret = -EINVAL;
 	for (i = 0; i < fwspec->num_ids; i++) {
 		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
 		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
@@ -1371,20 +1370,19 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		if (sid & ~smmu->streamid_mask) {
 			dev_err(dev, "stream ID 0x%x out of range for SMMU (0x%x)\n",
 				sid, smmu->streamid_mask);
-			goto out_free;
+			return ERR_PTR(-EINVAL);
 		}
 		if (mask & ~smmu->smr_mask_mask) {
 			dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
 				mask, smmu->smr_mask_mask);
-			goto out_free;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
-	ret = -ENOMEM;
 	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
 		      GFP_KERNEL);
 	if (!cfg)
-		goto out_free;
+		return ERR_PTR(-ENOMEM);
 
 	cfg->smmu = smmu;
 	dev_iommu_priv_set(dev, cfg);
@@ -1408,8 +1406,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 out_cfg_free:
 	kfree(cfg);
-out_free:
-	iommu_fwspec_free(dev);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 310871728ab4b6..e3101aa2f35689 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -844,7 +844,6 @@ static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
 	err = ops->of_xlate(dev, args);
 	if (err < 0) {
 		dev_err(dev, "failed to parse SW group ID: %d\n", err);
-		iommu_fwspec_free(dev);
 		return err;
 	}
 
-- 
2.42.0


