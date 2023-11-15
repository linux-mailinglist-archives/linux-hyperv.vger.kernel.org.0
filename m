Return-Path: <linux-hyperv+bounces-946-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E256B7EC480
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111401C20975
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BEA28DD5;
	Wed, 15 Nov 2023 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vcm7pksB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20147286B2;
	Wed, 15 Nov 2023 14:06:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CDAC;
	Wed, 15 Nov 2023 06:06:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdmHegBcy0EzF4/7tz0ElUWuZvWvVxbNxXODoqughxs1lSBXLk4mSRq5UGl/b5Zc+U6QIE6XGJIbwXXDJJheIVz3zW5N6AvuADc0qyRGCDrx0lNYha9KP/g/woiNO/hcrVnDwPSJ112r/3iN4yNuY8/ZJWONb/XdADdMgs5i4CyW6xvk6M4m4kwxGCUXRBBoqWO8fyLfKw/io6hpp2LItpXKqxOhPx/sy95q6hnQ6LaIm/XxMkNNYNeDWhi/eyE6/jLJqR7MmvrdbVFmnDMseCnpOh4NmTpcmqf8iPYLAF0bulNIw9VLLJH+WR2lyc1NPZShcgvNEvu1G3qLUZgemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ttRQdDT1iUTyxqOUZ4d5fqMjqgasJxTCJ5kIwrGzsM=;
 b=fe5l1UeLe41+A2KceTAeEKtuDMSVKCtbcutXwJhT7bUjWurn/FJ7MFu08G+ggQg2AtWWMrlw5W1U2BT8OrMI9az7fbpIkw9FmDv7lQwwZ2HdNOLAluTJekxu3vuw/MPPTUWaQfSj9ShCF0Aajp8BWmFHjWyYAmjJES8iXlkmkFrDAYR3NgpLHgzxPqcdGSU3vOpos/2qMF2gq/+87mw6XqmK8jxhLctos00c8kSPol1KP3csyJ+lz4xy/2cHKBSsd0lHawJkllpsosFy48noPbsw6U19hBtttZhIl+MNGb2ZZDamo+orbR2RpVKfqXHgZMzjPzQkEBEgIjAWkasmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ttRQdDT1iUTyxqOUZ4d5fqMjqgasJxTCJ5kIwrGzsM=;
 b=Vcm7pksBiSVh3xCEjWOXj2fGlP4FrEIAZto7e/Uu99uP7L4wjFdDiIZpLn4uVYPsHzwnSvo6IyoHr33+Rem3j15dXZl95jFbH/iq7WTzkO6n+/Iu7kitJHGpDObgqK0vMQTE+Gd5F+ERVI3jU7mEMG+JKXkvTmfZ32ydLkx3SUrA07d37ELAG7/1YiVap/DCMIj+m1bJREyydpWO3H7IC0Hk+1duboXTAI9MEQDfjQ7f1eMY1QxhHBe/JzJyJw7jFfLc/2KOMcjBF2VAFlkrZWKJx6hDINMqjyMhMbRo4jLb95/wu9deRPhxUwtp1ourTZoirW1ydUKf6BecY1qc7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:13 +0000
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
Subject: [PATCH v2 14/17] iommu: Remove pointless iommu_fwspec_free()
Date: Wed, 15 Nov 2023 10:06:05 -0400
Message-ID: <14-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ae980c-9d84-4f0b-3376-08dbe5e404cd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qNmDKqSnJLF7/mzcfUL3cdjdbWYGFSmiWcRhg3H/850VdC+MxC6XzeTI6wKOtue2Eow7mvswV5oxNoz3Q30rQQzir+DPkZT3qmQoncSburTIML1ArD/d01682Gernsf1rrK8Xoe1Ypk1X4o6WLFR7Tlr1/VJLxbg+pUo9YR3CeJh5wNCrvGYrIKbbWBd5ZQAIjs4QX0l2HuQr3Exp+1SkMO/PPJG/rXvaomlA5LFmLRvwTb64bzFTUF9i2kVaigOtAr4OXexg9DPCLqPEMFvfujBI3YTqQXjvjeoNhLCKqKxMkLxrZ7Lxb/o2zAgmA9v6bnTguhrDUztVr/ejYBSmuFtEov/ggJquauI6E3fvnAM2J8xzNCCAycOVmlrPXY+K1cA52UvkLLcLMCW8k4CMdBF55a5xETLgWRevIHXeBZv1yvP/uMxLssDQeS+Spg+DE00kQ8vDzxOjsAefV9u2Ca9DY08jPGuSCJ2OoeYmyHCeqz/Rx/2CAcfOw2sDF3ytsiumWA88sXkNlorIBAL6qijOqj3kftAUUB+ImMvVWAxa8EREqI1dNMllHpDdEMDrdsLwrcTQBfPG5SEGOeWiKaNF8hh1+29tlpqHy5X2hA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?enoFHoBcZzDseAw7me972qrcOM9YkN59Ur/T55dFTwh1YTESvUUzW882tL9+?=
 =?us-ascii?Q?3T/UwkDCLFOMHLaZYvtd54nFvHV+e/ac2pHK02bQN9Y/RQTXyDxBMr8oHrWi?=
 =?us-ascii?Q?m/5xZtmvrjsW/x07ESAp4Kgx9k1MpOozsprEmhasiFSNuO6yfcypkEpWszoO?=
 =?us-ascii?Q?qzpO6Kf/OvWOp4FqxzfrMHMjx3ES7gp8Z3u/zhUMaBsd1m60YbQUEkiV62wZ?=
 =?us-ascii?Q?GpdQZefW8dvCWUY7+/i7cpVyidT2VCi9oglNbvo3N/0o/Dger1FawsL00YV1?=
 =?us-ascii?Q?nhJh+q0NjKuT6sx8SutQVy/rEBUZn2vHGgRA5pTdIvVR8dYgIMJwzJa2cwxd?=
 =?us-ascii?Q?8F+mfhUZzmUAZHtEduL2F2Jk5DOxhbMoRfsrXk1smFtm272aKf5RWYx6xDto?=
 =?us-ascii?Q?cf0zlxtNvugvu67GW31Lms88zMxUke4gy2CKim1OydAa+c9U2qSvcHaOBfPJ?=
 =?us-ascii?Q?e94og064QuHtD5tk5E7VbIPbnyI/wnV3bNGGXSrFlZkKCjkmlqjknXYKJP0F?=
 =?us-ascii?Q?fm3aowNufDEJOwc5+L5dMGNKEQb8/y29aur0H1KoMPS0gSH9XM58u4L/5GuC?=
 =?us-ascii?Q?ebpjvU4Q5uwrWanFeu/s335kZ2S0y3J7n6szyIUABR338f5V7jWzO3qydX6c?=
 =?us-ascii?Q?IMPnm4G3Zhr9rkwVu+AFiwBWFD7JAj5OdEs1LOXaxSQAd8AO5OFdJpgSWtnR?=
 =?us-ascii?Q?r6FuswyNH/LmC51/NW+iv0gIQ4FYElDKirTWmDoGR+TpjVz4X6S3+zOdOc9q?=
 =?us-ascii?Q?d22W3qzH6zEE/js46WuuMykapplofUAKtzDOEk6w20Jfn15lJWF3ijMOjCdC?=
 =?us-ascii?Q?bH9JPR/v9y5oCSCTyAzJ2YEzs70iX/732DVrYua6w3UldVfB3aYRHPxAUh7M?=
 =?us-ascii?Q?oE/+R+EIz51sKxUC7uMVa3iHfYByS7Ualp3RKEpGG/0hsG6wmrtIN7wSHw1z?=
 =?us-ascii?Q?NETwn6IQv2TQ+mUrwYfYjVlO+Y187jnIQq9iV+kENZVOAMn9s1Sarxytk+Ok?=
 =?us-ascii?Q?vmXBKYi2QJaZcIjjbfOJpMHCclZ8rTZSwBSabM2OHMyZXKe7BuqlSCJV4L4I?=
 =?us-ascii?Q?BnLLzovDboLPj1SqFHktj64fJyI86/DzjF2nEGJIUWJ6v7C+/+shB8SHoWym?=
 =?us-ascii?Q?KWDO17q8mnqeD7z7dhsQM3+pE4YfW3+QpfPsecYdxvCULRN636zMAMLAIraZ?=
 =?us-ascii?Q?rntGnXXOfwi0GiBWyvd00BFXbSTQ80SO2tohu/+mfKzNMCgflwIiygjYWaeG?=
 =?us-ascii?Q?zHQQVnfvi410JFYWoC3LxPpB5F0SiFEER03H7xYnWULqzfCtBnGkNPPxIxv5?=
 =?us-ascii?Q?JmTrw6oaS1Xyztz7BdY6Bv5zUCW2XiMcEJ6P78t8F6+ZN67PKlwATkAQTtuL?=
 =?us-ascii?Q?gcPT6Gd2nZLig5im3hbmwX4EhsPg2uJv2v8MCsmHVZpE5yTite+Hvsx9CcpP?=
 =?us-ascii?Q?mC5Pdfq5/nmJRIQwPTvnL3zRccRR+8lA0TsUaDZELMR+gNfvb5FR+K0itQg3?=
 =?us-ascii?Q?dk9LiRwc6UAoIzTqqlJFsCgJPe/XzxJxuL43P7VoQhlY98AylstkS05PLqw9?=
 =?us-ascii?Q?UlPnKd7/3wvfCorEoVM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ae980c-9d84-4f0b-3376-08dbe5e404cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86fgSq9JBJCJJvzy4+WJNLBtVDmNvNFopwEByebpkwvow0MF4maohj/deHLFiEWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

These days the core code will free the fwspec if probe fails, no reason
for any driver to call this on a probe failure path.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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


