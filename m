Return-Path: <linux-hyperv+bounces-942-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F17EC472
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96EC281443
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7C210FF;
	Wed, 15 Nov 2023 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IVhPFLV5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C5208CA;
	Wed, 15 Nov 2023 14:06:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4011D;
	Wed, 15 Nov 2023 06:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e77UutjJtK2uoNSL0JhrSh09GOFve/uwDy0qY7X9ugyGfO18F+HChWT2Yd1ySwxWtRcaw/de5HehtXd5BmZbCM9kpnKyxPCfbJ6+2g0oe4tyGhk1X+vUw6DQf30PoUhpV4p35sGgkRABVIsqQKLwHAhjLm+r4pQfKByIiuDfc7Kgf4pxu96aq2vKKkOv49ZYg9awAp+cz/ZZejkefORaTGeGYnu18iNlsQ0AnmL5976GCEUi7Ew10N4xcZE5XiEMM3tf8bgqzOEqAflsJihrXfyFRpnuc/RgKvd5kuhNumFsWMm59E/aF7pPgYsbsx2SNgUTcbleEn8CyXndDgoqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1GujaaPcQbdHtiaRGjCcNI83AftjT8Nj3eA/aJbfRg=;
 b=OK4pHeuKIoow80ktkUWHf5j449fMsilxNZPy+z62rLg7Fh5p6aAr+Sv+kLvsV9e5gstWkWap9ZW7VvoVdocgl/0PegQNqKuU8UWkTF9Rq32mS5QkXeghueRIzXUR3elkC1vQEGA+nAPTZk+LWZBWdPXuWNhXPzeWoKTqzPiqNtfjYRO+NPuG9hskZOlUVUNrHXdCt4U+lF+8NIBiOUFqz+mbJMax974lhMcw8/m+5TX6MbIIiwNcLFZI+jtORl3ctQ2l6ixFLW6c/2rDsBj5OdGRzX4RWyhTqBJ2NqfdeaG0wXm5DrYBwV3JRO0Ifxi+u6JsgqMHHYpXnV5gmV4wyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1GujaaPcQbdHtiaRGjCcNI83AftjT8Nj3eA/aJbfRg=;
 b=IVhPFLV5h8oQ5RHN73YYWym7TYHqgqfaFf8F+evXaQuwk0Ue6o3NwXlPvFLnnsqDGYHxnC1+uRZBnlY888mvsOpWO1OAmynwQVyDtwA3MmvdRcMPstLqlyeEP2OFvhUP+YRguV4RlznuAaLPxCj0Fc8KncMa/33Nzudd1rlJerMIO+WVMoPAISxB+s1uja8hl6TNPC8qDiQUJrmVTwiUPFB+y+EzmIr5JtamtvYSKKXTP+mg31KSexGZ9VMCpca3xkcBnN2wU4qpkSj34RrMjSrUpm+Mt9QhxQPsucaYnC0TuXOafoC07MdvHKs5ZIrsj5qbsj9muBbUoNyWWRn7AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:15 +0000
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
Subject: [PATCH v2 17/17] iommu: Mark dev_iommu_priv_set() with a lockdep
Date: Wed, 15 Nov 2023 10:06:08 -0400
Message-ID: <17-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:208:23b::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8cf913-e808-4457-e104-08dbe5e4051b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NBnV+3+sCeD6bpEZFjODNEbAsY7ndRKIQKbI/7waKsRhxVYz6miBgl2fhZJMAe/RXYfts7OYc7KTGyTtFSD1F6wUB0subQxNM58t59M9zcUd4Ff5GZ/0V0HCbXXN/tMw7jXWuRbxfzBNztSGFfDoXobpFTioFHaJviptZkOyr/Xq3PEmvoir8zeaFzVH9B/mpY2qm27K1ZL9VckFYShtbyAr0dz+e/mJcMA7GbINB48PizlS27YzFzKVVlSD/WiSwWllmx3JvUnxCkdQGD5MvKVRfMLBVYYhRLeNytTpNxMq3Tkc2mPZz1mLJfwTyO1TrU5CN/txqvVFFFm7aijEPPnNlCO0iAofQR60GrDDk4U0opPjUBrOpRcTSOt0xF0Rup1Je1obygi2reRgArHm246GqPyAXEvoxj+lC15zzZrSF9lXwpXS1iBQygQVic3KoEORNdzU3PLawfg8i/1STn8SQ81cyl9l6n9zbIGbKsoDwjB/iZKwL3mmhXotfdAwph2P1k2w8KOP0CW8Xl0vP4MVf6TRp2OjZ91OzvHL7/wCIwdw8/mhp81sPCyC3yHiPvfnQHR4BUDbOzHBUvFxcNOwNxicfqOysq4LWEI9NaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e0if6SP1GlB9PDzgRPtOZWHLnGvb/YeRiMRnt0KYqynBMhSZen24QMDVcB0q?=
 =?us-ascii?Q?fbxQoLAYuEMleO3c+u4yfxHV/tfbSc6HGSoqapW3ohxGJnPdeoht7LPak3Xm?=
 =?us-ascii?Q?GGtse7Aa7eX3J/faF3NP/wJS+nCKgBumkTSojcT8vrZDuPlThmw69K441S/s?=
 =?us-ascii?Q?44c29mqjIYMKzQvOA6RS36ljUkhTTXvc2h9y0uLloa1W8eoaV8KGxT0tmdru?=
 =?us-ascii?Q?FJXDCCFC44V/0C+slM66e9qBW39/QlrNF5KtUcW0NfHYHRrZNMSWu8mxr/KN?=
 =?us-ascii?Q?WphEHgfj10Rsrxg73ZMHpf4dGSo8ELaCgXjXwSIiM7OTUs1ac1mFV5ReZ6Ju?=
 =?us-ascii?Q?gObpR+y8FjH9szIw7wdumL8cL0wxG4tppkqUUZIEtDfvqc0333yDnOA6RE+a?=
 =?us-ascii?Q?HKQczKLM1PTm83DeZicz0oVtBgR49GiyZnohvYpvjKL1jYuwWxqK1/crPqwJ?=
 =?us-ascii?Q?6KscOFIjsyQV3yzE1YcHgPiOySjSMsJAtOGVCcWgu5sY8Id0JvkOwLUs7YQX?=
 =?us-ascii?Q?bgNmFRJB08cTL0VxEudjLJ59hWvYvVDmCyJjYZ4EtFgNSN9ozyiXMk7cRJHc?=
 =?us-ascii?Q?TZQSB6fxrjTLL0kxk4XKU2oeVz0ptFAuqEk/L7B8rsK5QdBrOaLtcjWstGlB?=
 =?us-ascii?Q?twfxSfrdJOoPzUHSxAmwSNcZR7Ly3fs6Pe6CZygsL7cBzx2Kwu7PhNynN69o?=
 =?us-ascii?Q?WE+WnZr3NdJvZb0mIHw+68stfW6x4YB78xpmz30s1XgBmJJlDsRSdPolU/+i?=
 =?us-ascii?Q?Ndh1rVSSuLHYzG9oJSLUNUklwYen7YuXpVRop57mRfymBvTnI0f2J/iyQe5r?=
 =?us-ascii?Q?AW6QOaRlm7orfmnN11/yUoYurBf3VWkytDCPzEe/SVf8wg9MKA0nbvv8PWuP?=
 =?us-ascii?Q?fxaNnHFha5WiwJSIVBHvGR5/05cmH7QUeLSC7aXYTwuGEWcUilxojfiJMwJi?=
 =?us-ascii?Q?RgBB3ZfLlp2GWLO5VrXusF62I34S/7aVavn78SLAQO+Aljpsls+vkMRZNyRQ?=
 =?us-ascii?Q?XS5B1fGJ+NZSMxHI6Vpux3Mg3QaKj/2Rp12dj5x+EG1zXaHJfCCVbrgoHWYh?=
 =?us-ascii?Q?4IlJ/MzhWCKEXK5vmvtta8/NjIZJS4AuT1pvmnELyQJaYZmuBbZ/XD9XrmKH?=
 =?us-ascii?Q?iYTfYY8OhQ07mwWon6r/iyWTgt3aobYvL14ztjM686zxFGM1IWegljBK+PyZ?=
 =?us-ascii?Q?if9r957gvTASIGKubBpylxDWdzHqq1xhh4Z2O88jne2HxolChUYt30kjkrK/?=
 =?us-ascii?Q?0iGjbwurSkcjyZsBhB37677N4acK1jJ0eGQjQP6iNTywPFnwS0yX8KksDrLv?=
 =?us-ascii?Q?HF0BB6OdKZWG1prHYQ7FccUamti7RXtKhRRGzO943AyYQMsabQnCmJ/pecSd?=
 =?us-ascii?Q?X+brAtv7knvU2dU9Mo86475/oaKnIwi4aS7hP/Rt/FAz+MBoOF+BnfIjeZkK?=
 =?us-ascii?Q?slSX2HXKHSmW9QwMxrHnfk5UL6vNk9mvDLq2u+K/EGC0dCCVA7+w4SOLUSm0?=
 =?us-ascii?Q?24vCbbXWHHOP/4MFXqS0G8xOqvLOGSuXJ/lYGJwXiKOdNboIGfc0prtCDjg+?=
 =?us-ascii?Q?OwX+nXxIdgvh1TK97Ps=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8cf913-e808-4457-e104-08dbe5e4051b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYB4zXZxebzO9WEXDZ4ZJaJRplN3TWVB05TDh50kBnIo457V1UZKTVQEx6vynJQn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

A perfect driver would only call dev_iommu_priv_set() from its probe
callback. We've made it functionally correct to call it from the of_xlate
by adding a lock around that call.

lockdep assert that iommu_probe_device_lock is held to discourage misuse.

Exclude PPC kernels with CONFIG_FSL_PAMU turned on because FSL_PAMU uses a
global static for its priv and abuses priv for its domain.

Remove the pointless stores of NULL, all these are on paths where the core
code will free dev->iommu after the op returns.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c                   | 2 --
 drivers/iommu/apple-dart.c                  | 1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 -
 drivers/iommu/intel/iommu.c                 | 2 --
 drivers/iommu/iommu.c                       | 9 +++++++++
 drivers/iommu/omap-iommu.c                  | 1 -
 include/linux/iommu.h                       | 5 +----
 8 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fcc987f5d4edc3..8199c678c2dc2a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -551,8 +551,6 @@ static void amd_iommu_uninit_device(struct device *dev)
 	if (dev_data->domain)
 		detach_device(dev);
 
-	dev_iommu_priv_set(dev, NULL);
-
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
 	 * device is re-plugged - not doing so would introduce a ton of races.
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index ee05f4824bfad1..56cfc33042e0b5 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -740,7 +740,6 @@ static void apple_dart_release_device(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	dev_iommu_priv_set(dev, NULL);
 	kfree(cfg);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b1309f04ebc0d9..df81fcd25a75b0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2698,7 +2698,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 err_free_master:
 	kfree(master);
-	dev_iommu_priv_set(dev, NULL);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8c4a60d8e5d522..6fc040a4168aa3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1423,7 +1423,6 @@ static void arm_smmu_release_device(struct device *dev)
 
 	arm_smmu_rpm_put(cfg->smmu);
 
-	dev_iommu_priv_set(dev, NULL);
 	kfree(cfg);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3531b956556c7d..4a5792888e6433 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4457,7 +4457,6 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-			dev_iommu_priv_set(dev, NULL);
 			kfree(info);
 			return ERR_PTR(ret);
 		}
@@ -4475,7 +4474,6 @@ static void intel_iommu_release_device(struct device *dev)
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
-	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 34c4b07a6aafae..fbfb9ba4da0ee2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -387,6 +387,15 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
 }
 
+void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+	/* FSL_PAMU does something weird */
+	if (!IS_ENABLED(CONFIG_FSL_PAMU))
+		lockdep_assert_held(&iommu_probe_device_lock);
+	dev->iommu->priv = priv;
+}
+EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
+
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed. Take ownership of fwspec, it always freed on error
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index c66b070841dd41..c9528065a59afa 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1719,7 +1719,6 @@ static void omap_iommu_release_device(struct device *dev)
 	if (!dev->of_node || !arch_data)
 		return;
 
-	dev_iommu_priv_set(dev, NULL);
 	kfree(arch_data);
 
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3495db0c3e4631..8be153a54c8ca2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -852,10 +852,7 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 		return NULL;
 }
 
-static inline void dev_iommu_priv_set(struct device *dev, void *priv)
-{
-	dev->iommu->priv = priv;
-}
+void dev_iommu_priv_set(struct device *dev, void *priv);
 
 int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec);
 static inline int iommu_probe_device(struct device *dev)
-- 
2.42.0


