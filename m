Return-Path: <linux-hyperv+bounces-665-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB07E06B2
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0DC1C210BA
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6C1CAAA;
	Fri,  3 Nov 2023 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fgFyWL8y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E951BDE3;
	Fri,  3 Nov 2023 16:45:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B29FFB;
	Fri,  3 Nov 2023 09:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVhdUo+X2FOY4JuB0/pPr+RnbDrEodMCH5QyfzY5NngA2YJXLBMx53Et7VcUGEcAzzsWFM0AWB2lXipYY7zL5+EO4VesaeepJOBeyYgdeMapIDoW987qOHrNjbSHpu8nPWgKnRTk3xC2SB4L6p9fxVTRUguS2A0fqq/tVJoinNva7l61GwT0HiWv3XBHtTCsS1vXAOSh3h07smWBWnqfGj1j6+jUV3ltn/7jqf4NTU32N83i66u4WdEMj8SrMnFw5xf7QHnesdqOLIvMxZT4z1VMGCJMOsGSdIpN+QWsFTopuPVl1DnFMCFGhSazJrAiGkLCO2H34MMTZwtvdGuRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnoHHRW9wGxYObBfp5jd7EnMs8P21nURFY58S4rMak0=;
 b=ca+YpUMoFGwmuSQLnpZBZWTy+JOkfEKOEVFngkR/yUo7hWLNu9//6HugxRq4ZWPJBsvNGmOdDvakptciRQOHKI7QdzFdH/sfJ9CQiL8Zz6QzipAH/7R7TCzbj8d/qb8iHbWA58bSy8YfuDTJtPt2S7YeYofw+FEWxvnNoqRW03K2/2jgTuVASLS3mnOM68z307MAKBQ3SyQXgXF7zKZ82ndNSgwdPY9UqEeqLUtcUn7zZRcRIrxx56hfdOPfncVt3IFWtMjl+d06bLIsULjTXVkbm5GLdYUU81rULtqiX2FnU4Yc5B9tX8iOy9g8w9+6y26N64CtPtB42PMKxtj5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnoHHRW9wGxYObBfp5jd7EnMs8P21nURFY58S4rMak0=;
 b=fgFyWL8y2hhCPeRB3QREn7Uuh58Tup5xgeQRI1TAYRqqv27pTe6tsY9S0SQc6yUa9BaQx/XIqo1k/RqOXF/+AkiFVPZSVYIfhdiDmnAsXFx81d2o5yCRGZ0a6eBPF8TqDMWkjqXR2m5GKehRjHva6egvNif895ewxMZ6rSmeSQfsj7TE67zwPQbQwJpD09DbSQNXLviiCBZOyBkzQYCuZ+O8TQXBG9Sf3FLGLauPLm7JLs5qbxF3RcIC+lmPk9MDwu0ZT6HhksJLU25EywFBSKDUL633ZfBYTLUkaZNI3Rm/tw2w8VkA7P4ibnDKT0koO6zlJrj0B+YCKVpj2JMqEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:03 +0000
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
Subject: [PATCH RFC 04/17] acpi: Do not return struct iommu_ops from acpi_iommu_configure_id()
Date: Fri,  3 Nov 2023 13:44:49 -0300
Message-ID: <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1627afca-1b54-4898-fd7d-08dbdc8c3a5f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e8QoeXLZ+gfP4uFtmX3rpPUEYK4aMVIdFjtnwwv0LWasitsNVPChD1F9rU/qPrILSEBI/JTl0bv2y1Ku/SEFHMeYFVcPDN0VA57mc7mu2IXzyNJ9IjFMi6hz6K5vSqgsQI63k/uxDgv5oV4thGFeoE9vWdEJOdvOzBLnG9nqdPW02mrBkVnlrYsnrwkDf7Qn1NTeFC4t+pufkZn6DAKMvxs7OBbKk+qPvbX9cgTbGt2CooJarL9xFVUCdS+DKjx48iwEAtH32MFE/MCUBmQMh5yP88yVMgVRksdBLG+IRvKr6PA9E5Kon25B+5AgNwWxyVHLg5ZJaNU+cBKNfXqYKbzrLsl64ZpbA/O1Cv7cI+p+i6w05nDql+O2pAG/Tv2NLEFMQ6zusfiVWzxKF7zpjpSTMg3aFGxAJxoc8SqE2z6DZDmX/TuVeqknPF8vdaPiHp5/Q2AN5v1c7bQSvZ0KoUWtD2cIY7FSvpIyLrpkezAIsJe/b8T0qTkCrbL9Xl9ssF8UQXO753GZJfbQu3qZ7L+jgVOGVgDqbSJL1DghBrZHuK1jOGXuS9GbOp93P+rfAyFwXF09zqWh3SzQ0KfP3CHFQNeoWCOumMxnn7ky+Ltoodco4JUJZh7bdEQPR/Ey
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(66946007)(8936002)(66556008)(8676002)(316002)(4326008)(2906002)(7416002)(7406005)(110136005)(66476007)(5660300002)(6666004)(478600001)(6512007)(2616005)(41300700001)(26005)(6506007)(83380400001)(921008)(38100700002)(86362001)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c4NbtvSKUiJgXewWvYQXS49KGtlWWqE19IrJwNq2h1/ubx5Nb6JqxpT4zitD?=
 =?us-ascii?Q?UQhqfgK0Mks20f6BmOdUIkBIu9y+S5y/VyUdgzpbTtT6XGjT6982S3kXt3CL?=
 =?us-ascii?Q?gYxsurEM8bKOEkRth6TBcWqyOX06uIM8ixvyA1DEzHSzKX35/ITqPpqFw7kB?=
 =?us-ascii?Q?wUHmXC4y/isyCAjWgTcLxnlL0YlY4CPRUvVq4diL9cR1Zv9ufyYHsonY6g5u?=
 =?us-ascii?Q?1vdYSl72Di8F10cBY9VCl3r4dqreoIhSw+fB3SgD1/8/IckbLtWQdbqL7frX?=
 =?us-ascii?Q?+NoZ+V03g0/vIhzntFvXXGOcc473e3YvofLPTw8Urt8FygI5QkjSVtcS3yI6?=
 =?us-ascii?Q?BjXbAp1n3MFY3kEQ8Y3t8bb40OQoj9ZwaEWWHXvQau45HaWNs9HvkmKA3S+v?=
 =?us-ascii?Q?Loxw7kEk91Y4oT6nEA1Bpf71kBZj+2OgZZpVPJWLq3sMYnNZBkREqvsVG42r?=
 =?us-ascii?Q?jj4uK0opw+SxGh79x0ULbTORWqweQygzIquD7C7sX3tGeY5S9kjn1IrxKQV9?=
 =?us-ascii?Q?NMsSHMqIh/Bu4kRmj8NaWh0d/N9qLNn4fbCZCeTv5ntKpLliAX3xDa5nZcgF?=
 =?us-ascii?Q?IzqLgIyHUTDo2LfTLYVbWZC58owLuE4dCw4EOvnsf//F6gJqqz82uhWTKFBC?=
 =?us-ascii?Q?hxF+TOLo+SZbuIe+oPVvHzFswLBtdOK07XS9ZQ4ZNLuTB7uzD/WcrHc7NIet?=
 =?us-ascii?Q?NxAaPRTffXek0E6TRXzlC5NEFieUvTPnB27s4DdwfGZU1Ju09Bl+/xcpo6Cl?=
 =?us-ascii?Q?AYJ5K+XDma07d7rtPHQu0dEd+7j1bTCDt/dHIIkXpEs1iwgIBXbvhIrNY+mO?=
 =?us-ascii?Q?djUVM1/dDVjWkCazY4OVk3H8Ll0EH9y0q31F7xh9zauAkL7WE1ZvZiyVGboi?=
 =?us-ascii?Q?YF6D/1Ksb0vRRtaMmcfEh2EA5h9DQnc0YsUvdPLR34E6hM16sz+g+ruXLN3S?=
 =?us-ascii?Q?/cRhSdqQuRTHv7Xh27tFJgvW3+xuEeTbscPz80JIdMf4mPxjsWDuL+4GFJv2?=
 =?us-ascii?Q?La+FSjleK/THAHJ7KT9iZSgKL8GFz7ipOodgv7MMxp9vq+nRrC0Qu6U5ZPMs?=
 =?us-ascii?Q?Hc12O6oG3IvTHc1cntZMkIIpWaBUDhRd0LbANv44I9UppD5TCbrPASTvbbOB?=
 =?us-ascii?Q?0qW7Iq/YAbreoh5BfEwRldWW1RDpmQuD44HKa6yxz1R3UUgo1mck18m0+dOf?=
 =?us-ascii?Q?fYWmq/SjZ5/SJiL/u8LTpAjaMvV/opyASuVSqHe+Xqjr4Ycnm+7m7P/aqG4V?=
 =?us-ascii?Q?yDT2TDKTM3lLFyigI8r3G9EInd/7+K0EHvrwLv1C18aq0UsXkrj78YhlUQ9z?=
 =?us-ascii?Q?Appp9+qnp1EY78NZ7siNgfLCOL0flhStbRGjNLf78/rhI5jM2ZU+dVAQnqJs?=
 =?us-ascii?Q?PoY/UWWhg706NsT87h/G0ODZrH+1yw+OpCX/bkSLj2JJpBjscEiP/5P8JBkm?=
 =?us-ascii?Q?7oimomhU4WGtCXP/DCuG65Q1lnABgaIoDRxXTx2ba6AINPfHDGwewBnvvBYk?=
 =?us-ascii?Q?td/z71X+Nc2+uUTxNyOMLaz/iY/YqLdCmiz3Yzh7w/RyFPbYDVZXkfTDcNK7?=
 =?us-ascii?Q?sq3Knk3lSukf97Fkwms=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1627afca-1b54-4898-fd7d-08dbdc8c3a5f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:03.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oat6TdcMlK87Pn45YNa4lzlJQZrxRi5y3G9EyZQgkWg2oJ8Vzvos60W26a9ynCo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

Nothing needs this pointer. Return a normal error code with the usual
IOMMU semantic that ENODEV means 'there is no IOMMU driver'.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a6891ad0ceee2c..fbabde001a23a2 100644
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
+	 * in acpi_iommu_configure()
+	 */
+
 	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);
 
 	return 0;
-- 
2.42.0


