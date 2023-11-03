Return-Path: <linux-hyperv+bounces-679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1A7E06EC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EDDB21526
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB52031F;
	Fri,  3 Nov 2023 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M4n93yqE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A41D685;
	Fri,  3 Nov 2023 16:45:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E4D4F;
	Fri,  3 Nov 2023 09:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPD2QJVzrFbWfqYr2IvR+H583QfKxEYNdTSu7RXqwnqodcyIJYWM8M69mQSAHktafj/TfbiW7F+Vn9RoDkITUeR2nQKb8Yh89LtPG40oUcWqPvCv0t2BzfpD+a4uM487UjGi9N8ZzLf0bs/slreb3WmWLTT6c8UAKp+VW1GrAbPLqzCvk8Yj60zhwC9HnVJ0SbqMBdcoRO3qeMIgGcAznSAAy4wxxvoXDuF04xGqRXlsPu3HUqpAafJpODrB/I9I6/SRckhJFonSw0/AP8Nhfn1fCbIITsSV56V1zj8tsvbsnW3FPOIeO/XIi5NKDZihNQR8XD2Ka2RiEMLeS4TNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDk+Rk7r4cwKBoGlOIOvdq9eKJeO1hxpOVqu1F7DQc8=;
 b=GcFDyoqg3akVy6Fkizdj2oMHVvprPo2sWuHY+75C9bLLOKY3737Yobd1X2uUjoQoARApfq6DrhtC98FYvvCfG3Ac9vOsBPA2KLcYHouPK0cahifujcZZiN/gTreAqys/zsQKqA4teNY8pQEbg5A4GhULlVDRirKErc7OqV0LIDWD1RJZju2kdu/Qp/SCpLGkwE5sWRY8xij5MAoinuCvAKNyp4116aqXCYj1Muf5pfRL+n1oYqGgwX+yzM0x6zEcAelYEgmfcJZLWrRXWRZDRanV2KC7BdwKDe6Rl6QS3228Is81OeAhsgyD+403NiyP5Mi6pdr+ihd6bb4gl7mRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDk+Rk7r4cwKBoGlOIOvdq9eKJeO1hxpOVqu1F7DQc8=;
 b=M4n93yqEgDBEd+UDMIXCySXwAuTXWII1Op8tZqByM7O6phaSYDsp7XY+IDslEq8c4GUmrcARFrpKbHpb/B+ogS4OkDKq5veiIstIFPA6hrUo+ctN5vemJVLb5wimelXHI18OYJmaVF+rWRVG6YuKruVj/TX8NOBe1btF/uMK/o6vJdZ++1RFDU99/TunGx346JnYjauY1gKLoGu0TCXKdzFpfBG2qpKwoD7nlAoZ4JCgg2JYBpzLIh1IikIOxD74c2S1TNyBhP234mGl/qn+8sIV7sT+UhcobUo8M0ScHf/5P14maY7PCFqGeBkRxJOf/5GXptjl702xh+4yCO2bpg==
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
Subject: [PATCH RFC 17/17] iommu: Mark dev_iommu_priv_set() with a lockdep
Date: Fri,  3 Nov 2023 13:45:02 -0300
Message-ID: <17-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:208:234::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: d15c697f-2893-4e7d-1592-08dbdc8c3bbc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HOZ/oNDghyO9DyVurN1Rh1vCJh0AK8GzcnnF+GQy15v3FkvIB4DlXwTzPDDE0msYxvUQjhPd7AAtvbqljnywcMsz7UftegErpzvpIWD+qOqmcqI0Qn3jVTgmc/Hh/BKAieh/+1x/IiJPLVlegIDzvYU+ZmS3mnX7+KuELKWrgEOLtVim6uqNvf2rOEFg+pe66UJB53yRjUMdjfLOo6KWtUT0/OrV2f64WgaCGz/SzB2UmnHEorKx1K9UTvsS/s+XhRCCdLeGEDLIQ2CM9BbPkhzr+1QMI+4Zu+jJ54vnSRE4w/MsF0Jfctwd9C8zCm6qSY8irdW4fCGhTqEpckpIJv9PMKT2tD5SxCNrjlq06tEitRwoYfYY317b14dOd3uQu4qgbKeDdPevSVLrXHKolAZlZ3aXKCeh9G3aYeLOqD5lRxsbTauLhJPpwIKKVB2pPUb3BMZAbt2+t8SGrl1tC0XLnTrluqpadv+/Xvgo0jPwb+vRDTy/IO0ixfMRLcGGoSJ/eIza/ZRSzEWXW0IXo/CC4xKPXfut1Cd6CrVi+F2Y+pSI6G9m6DOptzwOZcnCr9Kq2/kJGHIDsqPqPlZ8UIR3jw/4VGlCtLjRlqogApo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/JxkA8v5hw9i1AfouZ9vWziwPOwVvMjNpABc49sUQvgxC1CNTESnydeLbnh?=
 =?us-ascii?Q?O7KtgRJHhkY7XbnqqISPdP2YGSXmVBSEBug0V3b40MCYpdb4eDrnoC3mwToO?=
 =?us-ascii?Q?c7ipwLBDk9g1eHTvQ4j/ssqYgjlRjr601oSqpBNmGLUske2cTTGfDA8Ifu9N?=
 =?us-ascii?Q?iOyI6pRj11cyckUZWRXdclaCSAJoH8Kxgebq1hhY9rs06XBmxnmsrN8Uvm4J?=
 =?us-ascii?Q?GMq7+dn4fDaoRR8u/M+ghnxHOW/Xw0veB8JOMtE7bSrEMzYUEr7P+TQM+dux?=
 =?us-ascii?Q?AbgwQ5A8ZQi6IlDSeHZnanlmupgR+ZXvHMnpnEyfKcYUI08cdPhTYhgiBpKB?=
 =?us-ascii?Q?u8d9pLrmqMfOxya07hnAsQcqG2AlJU/a2zV8g4fZqHkbWyglS2egaVPuizbL?=
 =?us-ascii?Q?d9PUYjw9UPJdCspm56riVqlkbZ2dcNFaqBpn+lrKyc7E0jkWsf112thgQtub?=
 =?us-ascii?Q?X7GrCa3Ok33sxfnQ6qSAQxXRJZw2BJwIpN3+PXhw+Ydr8RKYZjDS/9dYYTeG?=
 =?us-ascii?Q?lA35jEljydQr7wGfoesT86v8jVzKA5D7DsXoNutt1Jv1kEU4hp1M8gnlyZqX?=
 =?us-ascii?Q?VhDewNf/zUNjGoR40SoXKuZetM2V6MDkMItY67oXW1d46C9TueE/gFP08UyH?=
 =?us-ascii?Q?70rGSuQEhism+dAgjhOXmMfsq0xBvOD5/bl/0Cyz5acMtlbrOKKzPwfwiJwo?=
 =?us-ascii?Q?SEIf4S1plQkogYKlj693XcJEeetP8ehu9h/+/80mMJRaGZl0QuswgWJTUQbg?=
 =?us-ascii?Q?JaNAjge6Yn+dT9ac3xV55w7UYkiY70ZNgqi0TZN9/nrx/TiQD0TBkbNU9u2b?=
 =?us-ascii?Q?d634kyNflEC+9qLqkFutDw+eO4nuJfFFzkQLUhLR2WbvUOS0WIXZkioKj7Z5?=
 =?us-ascii?Q?rEReZcpBJjipXRMTbMQbSd23pmRzTEEqx/Ar1KmstOrAi1wo+CYEC0////Dz?=
 =?us-ascii?Q?II6JTh3lmKGRMEBpTuEU3VP1TKTJwThRbSP3oa6D7+ZiCNNbjPURhD7etyDe?=
 =?us-ascii?Q?TfcW19GHn43a1UhCUmaRLKtlrH7/5J8L4aYTLzbxiH1Jgr1k42gWC9y0XzVT?=
 =?us-ascii?Q?LaNHYoqPPs/Iu/WuW185VtHzK/aZi/YZW1dyxtluF7k1qVERl+KQccTz/4B9?=
 =?us-ascii?Q?MHylKJu8ybrISYKIRwmXBumqqTp8st/iwePLhpQWfOwaZC8K4I7Ey+Dflpzf?=
 =?us-ascii?Q?mJpqohfoYJFI7yHiHy27HuS9zDlc/2cRQr+TSSdQQ6EwiGSIUDALdWyhuvY6?=
 =?us-ascii?Q?fr5INK5GHSiWXK783AnMYHouYNbooKwkZX7Lc/BMraXZpt3JXc0+mC724pDv?=
 =?us-ascii?Q?jcHU4FI+AsN+sj3V/rs338FahxlGTZjjcbxi9v2ARbPwYBFHlaBTwHUBgXzz?=
 =?us-ascii?Q?t9uMf4lkdFJ/sShM77gM54L4jOAPzjX1W/woZPP/LSQ5c4kxBc4FB5fFmpg6?=
 =?us-ascii?Q?SJfkjGjbDw/4muR+VIubY79zT/IEm079m3U2P1UivfcmOOYC/wL7Z4Nv6Jcv?=
 =?us-ascii?Q?CGf1H/YEXqMfuaid6KEJOQvDm2Vv0zHhb290CsKoSUE8nJJEB0B1PPv9kYmK?=
 =?us-ascii?Q?6J+Mn1h6VvkwxXyb70+m1aHcnw0dgIxGUavlfgRL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15c697f-2893-4e7d-1592-08dbdc8c3bbc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:05.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLcTSHHWowrknYPLwDqRxDcr1dCbETHO0cy9t+MateMmjrpGimB1lrwTvK+xCfZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

A perfect driver would only call dev_iommu_priv_set() from its probe
callback. We've made it functionally correct to call it from the of_xlate
by adding a lock around that call.

lockdep assert that iommu_probe_device_lock is held to discourage misuse.

Exclude PPC kernels with CONFIG_FSL_PAMU turned on because FSL_PAMU uses a
global static for its priv and abuses priv for its domain.

Remove the pointless stores of NULL, all these are on paths where the core
code will free dev->iommu after the op returns.

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
index 089886485895bc..604056eb0f5f8a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -549,8 +549,6 @@ static void amd_iommu_uninit_device(struct device *dev)
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
index d5d191a71fe0d5..890c2cc9759b51 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4401,7 +4401,6 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-			dev_iommu_priv_set(dev, NULL);
 			kfree(info);
 			return ERR_PTR(ret);
 		}
@@ -4419,7 +4418,6 @@ static void intel_iommu_release_device(struct device *dev)
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
-	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1cf9f62c047c7d..254cde45bc5c1c 100644
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
index 2fac54a942af54..de52217ee4f4c0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -722,10 +722,7 @@ static inline void *dev_iommu_priv_get(struct device *dev)
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


