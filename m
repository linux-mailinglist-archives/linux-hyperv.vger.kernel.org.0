Return-Path: <linux-hyperv+bounces-948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4B7EC487
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AC5280E50
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9C2D03C;
	Wed, 15 Nov 2023 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SYU2zHm+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC428DA2;
	Wed, 15 Nov 2023 14:06:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC5B3;
	Wed, 15 Nov 2023 06:06:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaclseXdBu9D1kZoJ4Zn3CwkEUNLqAmPOM0Ci8yirAlsXQRiqV6urhOkfmfvIXEzh3kschyRuhRR+3zitm/2WZh4Xxj/edzIb918NBOUG/BDhqewKrmel2H2WM8NSZXF+h+oaxJEp6DqiW7nJ4477C2RasHeqWiIFG3CxxIm/iXvtI6NSIPgH5MZDmIk0vzzQWDOFmagoBfMmmW4TUjtnyRbEip8aawlXebRBZQw6qzLfzydFZqF6V1BgUS+DQFqerpCk5GO36vVwJQZdNAoKfqj4uJxdnvNVeQVGqu6e0KP6g31O7lW8jZywWk9c4ej96pguIUdgQrL/x8BvwgHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVcTGanyYH/mgsCuvskF+0lpN3xmjBkWiXK8uEKpRhk=;
 b=kF4n45FyBfewRcPhSxRDR3QtJ3XzQWoVY+YsUiadCoZBrPcnG9AwgU7CN86gxRqwIvHbCvYSy5HwHGujeZfRTt6aYx95cOmjf/gBawDT1aWToBTiG1hqz5aDp9lJSdj3HLHya3OPysx9f/qcnytZnW+HoniHzpixcs50op0/DPdLACzyZXD6C4sI3uli2/BESNP0K0p+xEycT+SejQe+LFBWwfKRNuCFHGm9/dnswCHZNToG9zp5HbyHbuVza43zBLCs9WDZyWin6P+ylPv1a0k95zTNebGnI3qkNXNZCxV3ljZCjKGY8Lxjj9tY+OOFrCy9fVRBvG5vkOCII2yKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVcTGanyYH/mgsCuvskF+0lpN3xmjBkWiXK8uEKpRhk=;
 b=SYU2zHm+rLCm5DEkNHML0T3gZZg63E4oC4a/5hlnd17X0um3cpsno/Mz0592ZvMXzE0C2jY6T3tL9dHTFcwxIxuOyaZzbpzNuhS90f4FFZirb8e8nWztVjiSGF0ao4F9e+8ItwDCRLWLhf9SnLg56o/9nuNEbE6gWd2ClwLEEjkWZ45cIFwOiZ63E/uREDcPvlPo4SBRXDl4dqaLuru7wTc8d3nxhLSsT/0Uy0+2+52Klke7fe7ApNCK8Cz/Y3otUwqn1B0+47uT75jSGJNc3VuXCm8KUgnyik6gDjjkNQCLiOj+mbw7Yu93kUwBdkeJ7uYuXPmRG161itTojgzkUg==
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
Subject: [PATCH v2 15/17] iommu: Add ops->of_xlate_fwspec()
Date: Wed, 15 Nov 2023 10:06:06 -0400
Message-ID: <15-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c2f9f8-00a0-479c-f556-08dbe5e4050f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AuVXENTqbrGQCV1jo64LTEDBXP9j3MJFPxnDJU47drDW6sE73fS6p88avtxNclsClzrlyHs/V0nhmBbuLyyTDpiRrorZFwVBLVgnDQfmVeOLvXihhUBfAyergBUgSHpOXYhRTL6GYhBHgpSY1WnX68S8Xr8aFDiZJleHw16pa35JGNtmztODZwda8a551/ZifZTyDRFJG94Lf2a/lqLX29F2QzAjRRVnehVXAwZFqjIM3VzSajOvy6CKzMPrQd0qgD4CSbcvKU7KHZXfZ/PmCsQAO3DXBGVh9msO7trFhWhvO2QS8MMvqJOFWrXkbO4GGe7S7d7U9vi44xbj0PmfmwvNBqIHWYfu4p7ovQFZlL6GgXRxCkJVZ0GbXmtWdSbbMND3zqQW9cAcBeBuZLBGK5WVjB3gaGJG5JqSrb/HT+mCXl43UoDcr99mu7LUUcfk9jQUk14uZsMYrTDWRpGVT4bH0JKaZK+a1tL2hZoLsFftm2J9rpPQbXDn5DjW7UZ44ITqgnd52/RFeQbk3dzovrDfEfqAwIB2Yxbb5TALHaOVnhQ6BRAYiNCkOnoZDbnPy+ZmbDHo4TiFXD6nCwmsGowxG8ePTiREYL4AnouCEUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+ZxTZH4tMQT+XeOCjsnZ4kqX9jC/ju2Pxg1G6R1k60K9MyC0cD6w9CVS8mR?=
 =?us-ascii?Q?JoeHM5QYrgZCC9FLxip9JnFSvNlmpVwOVVcPUsDd5D/Dh694Nbay6gtSfKFJ?=
 =?us-ascii?Q?NLHrwB+X4dQuZQmP135EWFSdashAjZa7RBnU4vH/+z0peWKGgaZMo0zkb5s+?=
 =?us-ascii?Q?vSzF9VI/0Rcic3pxHXq4UqMfcNVOpGTo/2e2mhlJ0t0GAI+IlidxH0CMnG2P?=
 =?us-ascii?Q?x2Er+k9eTIU2wPs1UTjbnzbYW/1paeBas1puvYsoYsxDMhYUmzQNnvefao2Y?=
 =?us-ascii?Q?LAEFrSBQP1XpRp0Z3nByaKlZZutV21sFFbBLbigAzU1daBUE0KDdqQFbbnUr?=
 =?us-ascii?Q?T9VY/8XdgW4+62EXFa6rXrW5yjB71Pxi7MpJ3eRn7LA2mmABWYyDbZtF9sVQ?=
 =?us-ascii?Q?PVuQReLBLpXxh6P2gmT102Ejk6vd4YH2b5fsU36vLXRZaivUSHQqNSFseqRV?=
 =?us-ascii?Q?BiBi1GdC13MEJw2V7QK0A9MslV1pRnVVENpzWDtvDMJmvjxtxJ0YUtjEvV6N?=
 =?us-ascii?Q?/mh3Bumlbfky3eplgQ/xTzulZ9RwYW+NqPJNoWw35YnUOEScALP0cTw437YR?=
 =?us-ascii?Q?tJO/F7rE/j0dXS73EeGwqM/UBJs5VGmgOd9Ez+7J9ivabEVHRV5l6JsrbtGY?=
 =?us-ascii?Q?X+GGPWwkTFArpTrcanRidtz1calvJsx2IjcTpmbPRV8MJOBl0SPYzUvR+3t/?=
 =?us-ascii?Q?QrwrHHIL9OGG5nm0geFsVw2dY4LKAj4raQOJOzIEaCxYxp9cioR54nBDoTJY?=
 =?us-ascii?Q?c65i0C8KHUV3lmJ0/Q1Ah8E5p39X2qBgEHnqdxPBALYtOFuQ0kbgy9YOQxjN?=
 =?us-ascii?Q?+/tXYY8bnmflvO/6nYGOnRppcl4WydKJf9F7QftvQWtf89URNbljzDauBmeN?=
 =?us-ascii?Q?ZpGnbsnq8OurZNFD+brBFiwivHK5REzxfzNVDkyONV01xE9b4OW2LLSyKpc4?=
 =?us-ascii?Q?tDbTKjkcI979+dBRX5UU+twkKu/kXe3gpa+3sKpkhpAkwJjNDpXAHvxWzEhF?=
 =?us-ascii?Q?1rpxy/usfuc43wBjWQePCGQDHzRUi5OkBg8Hr2+/m2pWUP+d1rLhTaSqx6XE?=
 =?us-ascii?Q?EnWP96GR8jQgd0HVLo9ikXpBC6KFdSphnjKC7VyEVB2n0P9MWYJmvWKn7AkI?=
 =?us-ascii?Q?DmKD1+r7umCJ2QqzBeqy0X7DIKJgNW126yxAWcLjqRrFFIFo3h16bm68mamg?=
 =?us-ascii?Q?C6LmRNlMudCsEOQQ9A6WNAvyBphaFIfmGr0byf/6362nCWgSWJOAOz57tfE/?=
 =?us-ascii?Q?f5bFx/WG62tfY4K7EXRD54GvRsWt5UdzX2RjcsnipJ99hSjKJBHRqaoJAZGd?=
 =?us-ascii?Q?Rrap56vMGQNzrVCRnUG0j4pj7uhhxkbekOkCx5OY5rtz5ORA5UY2YZsPzx1R?=
 =?us-ascii?Q?b+uiKxvBYExF5M9/uqIXKGzu+Q2YrOCPPxhYrNUDX7oMDmhKIRfJxFWOtVEv?=
 =?us-ascii?Q?OTHRrx0A3iFHdgD4Uup4tZ4NusyWgt1HnZfdRAyTGglHYXYSERoFzY81iaju?=
 =?us-ascii?Q?HflFbzyxra2cs5Ej5Blmoeu2rTsi0RODnmjyF76eGs6EnL4ggWVju0RYNbgI?=
 =?us-ascii?Q?Xe+OPVNdKwv29uoturg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c2f9f8-00a0-479c-f556-08dbe5e4050f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUipwaw1jn/9ZE0o6HKl6sPblNHjYOGgLuv/Ik/MnFR9uCME0ffxG9PcqJGV1z1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

The new callback takes in the fwspec instead of retrieving it from the
dev->iommu. Provide iommu_fwspec_append_ids() to work directly on the
fwspec.

Convert SMMU, SMMUv3, and virtio to use iommu_fwspec_append_ids() and the
new entry point.

This avoids having to touch dev->iommu at all, and doesn't require the
iommu_probe_device_lock.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
index 8fc3d0ff881260..de6dcb244bff4a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2983,6 +2983,9 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
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
index 352070c3ab3126..3495db0c3e4631 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -43,6 +43,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct iommu_fwspec;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -395,6 +396,8 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 
+	int (*of_xlate_fwspec)(struct iommu_fwspec *fwspec, struct device *dev,
+			       struct of_phandle_args *args);
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
 
-- 
2.42.0


