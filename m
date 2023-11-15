Return-Path: <linux-hyperv+bounces-952-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B777EC496
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B86F280E70
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB52D046;
	Wed, 15 Nov 2023 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rCE+8TMj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCED1EB5C;
	Wed, 15 Nov 2023 14:06:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A7E1;
	Wed, 15 Nov 2023 06:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyLqbV09LUBPSZSauUYeDEJksXuLvDKOwitA75fiYSi4jzpQhhTfyBaCuLFQJXgSNx3/rWFpoefd7V96Mccjkdfa45+l4LvyOzP98Y3kMGtzFtRRK41X9od525XT2TQqAitv3ZlPAuAHZP48ZJj60xzEquBoYruGnVEKHw/VppWsjngzhnQAZJmm5xUi3ItziLmYyJ8WQHjZGnlnQny4IDwEzjSI2kz87WlKVP2HSOB6JTRT/4N8r6i4J3dd5B36f3EK+0z1M8k4qdi/331pBMS4m+YNZKlxvJ9PZyPo2XWvc7aWIo9R3Cw5FNM3eN6354LCMFuB9aGsSsdRufArMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT0oaRCdHSsmf4+v0+ddHaxBeQzVTnNF6zGPPo0PbgI=;
 b=VCuojikndcIuDags3IDn/K4h0PTGo/7Ih6SgrjvMoWEYkjQukeAZR1HFH4kQBkbwR2XMshK/XCxvF+3TBKV7xBEwLb6Lm2atHDfrYHhEZeR/UV4RH2pSQxOtFaddhjvat2SDLAw/FdqxkTnVnaQeRCtnkGqIUMLAejpExPcjjgq2mgnWIM4O7pPpHDLqoSEUx3Ao+dR+MPi8yN3LsIdCu0F6HMjruD8VmzLdJuVS294O4bnfgl0iHJH6frp5vU19l3I4H1DPWd+AQ3++hj9DH6s9/n8QQZHShVlkf23YaNvx4Flr+iPhxqdoT9BNgvMFx451GtgV+o8uXkdKKTAFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT0oaRCdHSsmf4+v0+ddHaxBeQzVTnNF6zGPPo0PbgI=;
 b=rCE+8TMjWWvXiVfknLRIBcFfbAx9oVylXxGOAKN4g36LooS48GlWUNBN6uCyMi5mval1xBciKrQhSgo0/Gfs3mOtMorUONxsZVmS5YlMH5JDEByntsETj/d5dw9icxAJf/CXWD5+s2kGqcc0yZSV03ykKIJirXmP+G4N13ftq/QFEZdEpNJxQUtE0litQacptsB8TDwskH+pA04Brimbs1YNQT0Xz5Lc4qWuFzpqIb3955a2ulfaot8XotG7vxiQsVyVgU2oE2ApiVoLNWmzTJBmfJejtppSf0iT6ZpDX48jd2GyKWTh5Asq8v5WwrXgKIrk1g9nNfVrJ4t3wZGgmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:17 +0000
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
Subject: [PATCH v2 03/17] iommu/of: Use -ENODEV consistently in of_iommu_configure()
Date: Wed, 15 Nov 2023 10:05:54 -0400
Message-ID: <3-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:208:32a::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 20007c76-5aca-415a-8d98-08dbe5e40589
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IHHuA9EODUzelcV8jJpF238NtJu8OK8Pgq2dkaJN+LNIqilGug7SL2Ybvys6JC/WCCsBTU3EuypO4BRI3ycYxxbveFC648Zx7upCxC843j9aqMz/6LoSsEFxkr5SKvNomY5WbppRP1U//3R9S69uwskKCrsUFInjIf8X1hOp0Ov2qsPg43dpB7ov5CBkeeTHToS6NXA+eoSgE0arpumsI30lhm7A4Rwj9gr0eGaZbbGTSAN43qFowQ5QkG5hISFUMDMWYorym3wWovkgm2EVIArWtqf+i4M2x7P9q/GiRlKk3YfEiP97At9UDnN6ht1d/Z62ZkGNOiG3Ja+hed/Zx7pCARqstdDmFnM0NyfAMmvqQf0z42igneXpnst7fjVXpGkMeGp6Bg4p/nCRAm50ca5LiKN4bHxf5486wuyNj62qx5iDRIiqTtaMFSVplWQkWIRurYAyi1vnBHzWEH5xRnH2xKLImoSR8OzHuROlQ2Y/1wXw9AY4EHOBv98gIb+nN4f1coKH6GwtnwwMeZMqxdqWtU2X+NDpxTwgoxNV2L214Kte6HsSx3cMCjmMVA6qqOSkDqXCxonu2zp/GzxxOIu09AZi/Yf9A9nQbLUMbYBsl7XT3Ydh17Jt9LKXo3JA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XehaVCvFAMxHoIuLmOBpxBw83s8Uc0D98/WLtTOUn0G5Sjgr4linvCUJTwSH?=
 =?us-ascii?Q?XqMENNq7MgiZ/MoBiQ6Txcv7mGkbrAHoGsg1vGgEgci9ysJJqoZonMkt0q6H?=
 =?us-ascii?Q?kRNeNAqC90KDVR+LKBNW4UsF6BXXqhr5Ow5uPha1kDy5zHXdbmGPwAA8an33?=
 =?us-ascii?Q?WSpNqTJh5xc2FvTZ/3+lkaW4Qlx5ZPHsKEIt9NzuZnZ5GRsEohvYSGFzvMNc?=
 =?us-ascii?Q?WZwdjyJQCUUzHfasfaJpRourW6Sujog7BHJTebigKzTPb6ONU8bCu1I/RLgM?=
 =?us-ascii?Q?Xc1lj2oRQOfpGRrut41pw0hMa08TReONkq3rCTQ5O9p5Q6STQWcunq+K0+un?=
 =?us-ascii?Q?/Bw4We8FNqriY+gnI+mu8lfFAooCPeDUehOm+jIjOCuKKWs4z2VwWEfNaLTi?=
 =?us-ascii?Q?MmbdpMOyWsiGhX24NJuMYXRH3Id6ptG9Cr9OFOWutzuklk8jfzgnEb2OmlQZ?=
 =?us-ascii?Q?tc45V3aQwo9u/BMb+FWQxPXQpUipGDcgnzOlUEPzwAmPPok3DiXRNvlcLfks?=
 =?us-ascii?Q?DgbkzR/9xnZPwDmpQWogRlxntDzmQSq5f/mFbEJTJ+Z68h27opxxtaUYpDSF?=
 =?us-ascii?Q?DDRYP633zGbaLu+5r8BRNdtBInsJYfxqZ+g+HLFiE7dl577hyvqX09mejVuR?=
 =?us-ascii?Q?CP4a/dGXCjoGRcYEtWaJLBGf81hGhBgvzsZhnyDoj4B8FNBt7Km1irrG2rOI?=
 =?us-ascii?Q?ntuqXmy+m+ezO8XVX7+ZKkmU3jqDsop5mdtikWUeciXIRJwB5g8Q0PFjF0Al?=
 =?us-ascii?Q?mh0qgkMLk8vRlPTdlQVOeLQkDWXLr3cr2AIoXDezmBY+pY37PLUQST4L2p6z?=
 =?us-ascii?Q?CnZh0sEeB4Au6I37olImpHWhpC1P3pk60b3XLzB1rr0VrrPOLdvyhIQjazln?=
 =?us-ascii?Q?ZmppVQl8JSx2SItAsteplP0u0hq64dhMZNypM0D/YnH0e+eDI8fDOsQpJ5TS?=
 =?us-ascii?Q?D1xlYgFEH2Bn1Obm2ykq9ZCMSkpaTIwImE4X8Ju+Mr24EzNJ5L6FPCiIHywt?=
 =?us-ascii?Q?6aP0VAHYgWtUoJenVf+3OJ79aaKtOnM9qFnS8qnoXRRYrTa6XMZx4jJxJofP?=
 =?us-ascii?Q?89J5/Y5ol1dwr6h0d6/G0jT8D+4gmlCIeW+p3yrNnavzYEvB4XSoF2U5R4nh?=
 =?us-ascii?Q?FaaK/6FEuWmGaAVBnJ4pkuIvJd+FvWkI/ASA0Pvo1sgBxIaR5w4amre5+I9q?=
 =?us-ascii?Q?Rq14Lu7vHTT5Pm/+E/JbuTt2TtPdRX5wfT0OyTJSWjZtiyyp+efXXRAz6Jt/?=
 =?us-ascii?Q?sW1jMm8h/U3yqKBbPfv9RYS+ZDgZdBzD0GjSIRif5YOVAnlj2lK6vrbqSPXC?=
 =?us-ascii?Q?zO5/1dBftnUOO8Lfyj3BX24ffDfgW95abn5KAf748alC4KNbqbR2q6yAD69U?=
 =?us-ascii?Q?5iEsH3/hLhcMuipYXREbE39o3aYLatSz5adsuQg6UefehnPPoA0tdhwiJRzl?=
 =?us-ascii?Q?Az3f4l+d7qggFAF5zP1WaMyUrd1TNKzCN3Bd6Q/mtmRpOyjA7yl8dP3/+aj8?=
 =?us-ascii?Q?vnm9/tjJkxU5yiwY9c1c30JAGKEx9/kOA3/Koo5dppOdWooeVofOrAxAGn1g?=
 =?us-ascii?Q?8IyZQBFT0gMISu4kSGE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20007c76-5aca-415a-8d98-08dbe5e40589
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:11.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaesOnVJV6cSI8hK0CRBDC1o0ULfoU5uikyskLZ3qRQQWneg0TCKpN4/k0kksxdK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

Instead of returning 1 and trying to handle positive error codes just
stick to the convention of returning -ENODEV. Remove references to ops
from of_iommu_configure(), a NULL ops will already generate an error code.

There is no reason to check dev->bus, if err=0 at this point then the
called configure functions thought there was an iommu and we should try to
probe it. Remove it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 48 +++++++++++++---------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index b47dcb66cde98d..a68a4d1dc0725c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,8 +17,6 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-#define NO_IOMMU	1
-
 static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
@@ -29,7 +27,7 @@ static int of_iommu_xlate(struct device *dev,
 	ops = iommu_ops_from_fwnode(fwnode);
 	if ((ops && !ops->of_xlate) ||
 	    !of_device_is_available(iommu_spec->np))
-		return NO_IOMMU;
+		return -ENODEV;
 
 	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
 	if (ret)
@@ -61,7 +59,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 			 "iommu-map-mask", &iommu_spec.np,
 			 iommu_spec.args);
 	if (err)
-		return err == -ENODEV ? NO_IOMMU : err;
+		return err;
 
 	err = of_iommu_xlate(dev, &iommu_spec);
 	of_node_put(iommu_spec.np);
@@ -72,7 +70,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 				  struct device *dev)
 {
 	struct of_phandle_args iommu_spec;
-	int err = NO_IOMMU, idx = 0;
+	int err = -ENODEV, idx = 0;
 
 	while (!of_parse_phandle_with_args(master_np, "iommus",
 					   "#iommu-cells",
@@ -117,9 +115,8 @@ static int of_iommu_configure_device(struct device_node *master_np,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
-	const struct iommu_ops *ops = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	int err = NO_IOMMU;
+	int err;
 
 	if (!master_np)
 		return -ENODEV;
@@ -150,34 +147,19 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
 
-	/*
-	 * Two success conditions can be represented by non-negative err here:
-	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
-	 *  0 : we found an IOMMU, and dev->fwspec is initialised appropriately
-	 * <0 : any actual error
-	 */
-	if (!err) {
-		/* The fwspec pointer changed, read it again */
-		fwspec = dev_iommu_fwspec_get(dev);
-		ops    = fwspec->ops;
-	}
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * probe for dev, replay it to get things in order.
-	 */
-	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
-
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err < 0) {
-		if (err == -EPROBE_DEFER)
-			return err;
-		dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
+	if (err == -ENODEV || err == -EPROBE_DEFER)
 		return err;
-	}
-	if (!ops)
-		return -ENODEV;
+	if (err)
+		goto err_log;
+
+	err = iommu_probe_device(dev);
+	if (err)
+		goto err_log;
 	return 0;
+
+err_log:
+	dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
+	return err;
 }
 
 static enum iommu_resv_type __maybe_unused
-- 
2.42.0


