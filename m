Return-Path: <linux-hyperv+bounces-938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF57EC45A
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BF51C20355
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862E219E9;
	Wed, 15 Nov 2023 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gw/2BqJh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D3200DE;
	Wed, 15 Nov 2023 14:06:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C40B3;
	Wed, 15 Nov 2023 06:06:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2m3n1lAzivhQlx99aJdx8OKn0X5RfjZFcdS6VhdsmpHLsiaUlJ0Bdde4++CPvs8+laAAZWslyZ+JNTocLBuwWxu8vAFthSMryHF3f5i2YDzsdhJ44x7q4uN6blVI/DlkkgXth3r0cbbOqF2VS1VKcyBr+aURPWLj9lAjwNCKTHhLoQPayD3bbNwJjrPeap5c9oXgFSOGENJ+P+ggiVIMXSuZpVTgqrBmwE2Mob+zIeqeiDUgRL/JafA5APrr4TVd96P3sMST8vrmqzXatx+Mig23pdUAL0/NQIsAWB4eInNUhTJsygcZGEua8aat2Q35yFU6e5/0zLqsLPUYskE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Cg0L7AKccOs0U4ZynPRAV7esL8tk+X5jnUDyQcs/B8=;
 b=Cs8DAY0SiTOzKhKB2P+jAWgffrKr/syAe9YnBPugk/CoC5R7U6REnoA+TbEZctwz69M/pRP9uwrDrLlWvpbM5C0oIkN54TRv/mg6LawbdLQya2t/t6kmAkfPDhaJ5YX4CRuxlfxcCEpRkkFRpwV1y4WnixkqTdztL8usAxbJIQPUx82qj6cTvFjCg2KSV4Yo2ya6MjdnoiBTTZWvCI7axugfhGEhjxiZoHzeY0NkrJCxv0+JGMyvTY3MvbLjXHmHxkvTzJfPhw7G9aewQ1mgBMX/h9ID0A7gcmx/dCM6z9O5S0Y9X7HiQoxP07UIPetr1FkCzpokCI8VWFh5nEBwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Cg0L7AKccOs0U4ZynPRAV7esL8tk+X5jnUDyQcs/B8=;
 b=gw/2BqJhTByyrCGvW46kx8CVO//kuFJFfUC9RFW+tYgx+/yw2zWpykJ7i0pz95DmAsO42eCXjFYFAmMmJr9G+F58K+U2dzvYW0i9yLMfJU/PQWEzPsd/PYg8tFKgSkGBXuPgT5puGSXZlYrDCGWKtm2K5vLXxC8cQbpXlpQSj3CcGhmiMq7ryk0AArWcRh3JXH+dUVbm8VFZgPigEgH06zM/MzQT2eRL+uyOdALE+8NcroFOu2sABz8D7iammWfSn5zS8+a1pBiI5AfqMENqqmUAa0aU+NwFOeiG46wdjCbSFlnMFFId8NRdaAOqEADwVZXFvieAloxkFLpv4MJeGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:09 +0000
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
Subject: [PATCH v2 04/17] acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
Date: Wed, 15 Nov 2023 10:05:55 -0400
Message-ID: <4-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:208:32a::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7309fe-f1c9-4419-4a9f-08dbe5e40483
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ePTi3F+oZbUMQCUcsp2v6wREhVh00swp1NKNuUMA+WByeY6evt7aCVb5o7P+kKM+17tuVIcqtnhkfc/s9UviyPhvZjIGoq+dVwV3dSnIX/mAhnHLgbWFHX4aUcs/ikXVaDRVzhFRZSSjViTy1KYNYtvzAVrwPYThjo3EblJVfb6X+w8cCbzBh8Q9jIC3btPT0DqCAQ4SCHzkOBEESoBI+vjIcAU5Rp8QZ2eeVGHQOqz4/tLeAe+bFTtTq/LTq3rlfE8P4RKFg+58FUYpOAnzKS1VLTk8ARWSSs31+zZbCCiK/UPlH1XFKRBcETqDyzb3JNaX6FKbe6sgRpdIg2D3EFulaqE/9ICeNLdVoGpdiHK/6nW+8nA5uRXPG0Gs+w60xK6xgyI+R2SpRWF2Uq/9xcSLeHDLwH18JwWIVFtVcjpe0wmMoGFnCJTzH+7fIYP3aj1gtVhETh9V2svW9ui/0unvRrDbxndthSrMFiQ2Y0jZP1mARSgiAE+Wp3lhwcrt6EJibDEryo4PpXFTmpsIhI3/nvt3PNu8DTp/FJGy4eOUbUlEPfsjo4kCyASFVUECQy8nlW+ufAsQHB9BsYiBt5aO+MsPNEanlUSsdmNTNouA4AV9k8ArzArid/Bys72z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YRGOVSeiGcR8haEtk0a6r13M2MCGQQsWdOny4DOIvVSG9ekISERiqrl+BlI1?=
 =?us-ascii?Q?Ae+gJE8O1HTogKTeSHzE6OTE0p2AkumI8sIcY+iTSTITfyLr7lVSpVUSbBMy?=
 =?us-ascii?Q?C6H87OGYuQmjc8EYjrzoAJScq09BHnia1WL45L8MZSyUfEJ0hu8xwnh+pqRE?=
 =?us-ascii?Q?KcmYbiEjG//ahYcTUgBo7uGGI26okf0sUM8+3+pDA6pImrzgxPgLOkWwKaR/?=
 =?us-ascii?Q?a/0MR83StkkZd4ihyV4sqT4TcqJdFdSHo+25KBvLMX4Kq6KoTaZB36LpOrEw?=
 =?us-ascii?Q?3XSlkFwiML4H0hdmmwoeOtiO3YIwYPy56yJRtF/a5VOIIS0Bm5nwGmdwQidE?=
 =?us-ascii?Q?8g6VnqJTc1n2DdCFVsZdCQeWpcd1x3Y8OA+W2geb4DMNuz26atSMxDcEwEzf?=
 =?us-ascii?Q?S5r/GP84o1pCWe6E2awafcnCvNIxXt1SkhTW3Yq2ISnG6Hu2QzGb7X2u5kzd?=
 =?us-ascii?Q?23wV+HO698CtKN+31tUtypC1YPkGKEvBwplgwKOH+Mwidxx4BKL1D0YNhn+o?=
 =?us-ascii?Q?pephCQmnNRTEbITJAPig09IKMMvz9uT4A7DNaDZDy/gTGqtQo4QU3qmGABAg?=
 =?us-ascii?Q?d4MtLW81p8xMmX+HEtwlogNS8LdtfxeKf0VCfMXblq11+wfrsFOVJ1rJN3/S?=
 =?us-ascii?Q?tH4ENxSXoh4M9k1rkm5WCPnydV+mghKHpp3R1eGpkpo6hbAjjapQAWuhX/7H?=
 =?us-ascii?Q?McF5EHUC4G+jcl+/KSf7TWUAyse243nOgFaa9D43GXy/CaHwJbYXv3BoegqB?=
 =?us-ascii?Q?qQQlE0Y319KErjlvD1tGDyKrfAFyP3fgTiwXfEXTxV+bGa3S7EvihU/WPPXd?=
 =?us-ascii?Q?gBdX/2HH0DMzV7yny3tOqZLR7TgYq3uv68McslMtdU6CJbVP7Vn/HiP7QL8A?=
 =?us-ascii?Q?5d7QJhf6a0RJqrnmga+kPimv/aOsY6WUSciPxevPUH+bBwm74k35PfG2bQfN?=
 =?us-ascii?Q?A0nbr1J6Jjx3ONzS6oY9OPtSnywOLZLaW/g9XcYmNBSBEP099YYLpwBAEltq?=
 =?us-ascii?Q?s3Xl/vInVXNbge40xVHxbHnE6azBbHSVtow2A0lBnSkNN30oawDIDxtuwL9F?=
 =?us-ascii?Q?3EWcugJ1y42MiNBCN2TwsKKlhUbC1079un9s5gZpFNiBjVnDTZ1X0WlEiftb?=
 =?us-ascii?Q?JpZGFmO19fVaXmkjexrUbC20yQI4Rv/2TWGFgP6WmZUITxwYEAaRssI62nU5?=
 =?us-ascii?Q?W+HLDJa6eRv1xvH4ay+4GSZ7MXB61Wa6raAXbRslTAKSuERkoDDxDN/mZT1S?=
 =?us-ascii?Q?tAfxd0Fhln8mOK9i9cBGT+Or4AjCI8/upadts+ETqz8PA0/RcRDZFqJAe1c5?=
 =?us-ascii?Q?lalq0t2Rc9P+2U8jwgUBGeqk20B842DwLzyvDjXs89oLnNdR1yfEYjZaxyh/?=
 =?us-ascii?Q?S2NE+pwBFXUXUNRpaz44ddQ2Um94KcnKCiMtLJtS9lUDEiQZkLlNDr0M92O0?=
 =?us-ascii?Q?kR5uC55ICGSocsKBCDQ9lvUq99D3cPWBfcupepb/diJlN8CZ/l5NJQqfJRyC?=
 =?us-ascii?Q?ZX6diU345QGBnl5QYvH7LFOdyKC647XMVcUpNrdpSaDNfj8eQfO/jH81usxX?=
 =?us-ascii?Q?F+LlrXAdBO0HJ7DGb+4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7309fe-f1c9-4419-4a9f-08dbe5e40483
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:09.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYuiPds6pWGE/2wRJv4qtFqt3GYu5J5zYrSN0uxlcZZflI5NSJ/YZMpaAd6xWKg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

Nothing needs this pointer. Return a normal error code with the usual
IOMMU semantic that ENODEV means 'there is no IOMMU driver'.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9682291188c49c..d171d193f2a51c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1562,8 +1562,7 @@ static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
 	return fwspec ? fwspec->ops : NULL;
 }
 
-static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
-						       const u32 *id_in)
+static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
 	const struct iommu_ops *ops;
@@ -1574,7 +1573,7 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 	 */
 	ops = acpi_iommu_fwspec_ops(dev);
 	if (ops)
-		return ops;
+		return 0;
 
 	err = iort_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
@@ -1589,12 +1588,14 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
-		return ERR_PTR(err);
+		return err;
 	} else if (err) {
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return NULL;
+		return -ENODEV;
 	}
-	return acpi_iommu_fwspec_ops(dev);
+	if (!acpi_iommu_fwspec_ops(dev))
+		return -ENODEV;
+	return 0;
 }
 
 #else /* !CONFIG_IOMMU_API */
@@ -1623,7 +1624,7 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			  const u32 *input_id)
 {
-	const struct iommu_ops *iommu;
+	int ret;
 
 	if (attr == DEV_DMA_NOT_SUPPORTED) {
 		set_dma_ops(dev, &dma_dummy_ops);
@@ -1632,10 +1633,15 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 
 	acpi_arch_dma_setup(dev);
 
-	iommu = acpi_iommu_configure_id(dev, input_id);
-	if (PTR_ERR(iommu) == -EPROBE_DEFER)
+	ret = acpi_iommu_configure_id(dev, input_id);
+	if (ret == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
+	/*
+	 * Historically this routine doesn't fail driver probing due to errors
+	 * in acpi_iommu_configure_id()
+	 */
+
 	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);
 
 	return 0;
-- 
2.42.0


