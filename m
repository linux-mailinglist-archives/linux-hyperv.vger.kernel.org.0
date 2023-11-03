Return-Path: <linux-hyperv+bounces-682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546917E06F4
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEDEB20F94
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D81CAAD;
	Fri,  3 Nov 2023 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tqLtCRAw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C091CAB6;
	Fri,  3 Nov 2023 16:46:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0AFB;
	Fri,  3 Nov 2023 09:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp/BgbhOnrSE8fhXsJ1T9DA1maR0awF2fBLmEkRc/dK43hySNCmogkGB51ShI9MhDLPmFH02Ohms6eGhF5ZQg/Gnl89o/5ciSSgATId92iKHhGT/y4sjsJJni6iK6WRTIh6a7JRz2ZM/skD9DOVt2JoenyDkiQ9qOmi5IlS9dWVaKoLhT7sUvFMHYiKe48aTQGskpCNKE438a4XRDnsm18TBPsDZEWIsH2W7wmb7sl39rv+e96Y+pNnRil7eKwePNzjbyZaSXWfXJ6H9APLNiGwYuKMMhRLfh0FJctmzb/hu8PJvSL/xTn5doiKoL14/tElPaIGWRLFqFfTKjwBtHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NI7RAIKRcJ5qH/Il69MCPxVy1cLdUTnarPzV/9bS8I=;
 b=YgtR9/yMoO92Qhx7YIMtfyhT0nC71IyUf5E26GMsMuoa5TdW/FpAsVrKlW2RA/whAh8cPFyZCzMeBgdbSMogb6Auv+2suDO+WsPwdffOlaIr5ujeG99+OHjMwR278MP+0UG9TLxnpeHtb3u6Bf3Qp5Q7o6jSZ5zj11+VlfIR+k70p6qGT3OQoKYcf3HBaM7ah1Pa/9uLFqhbKrX92FnGxJ6MQi1xa4T+3eCVGjC/72hMlCioDawzK2amMmaiUMckeNXoyZ3PvsBUXQPK+yGm405L0tU8PY09w+Pp97Uef1GcrVWeu0K0+RTJs0Fav1OFQd7ZVKdRCa1sX0QvRCXuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NI7RAIKRcJ5qH/Il69MCPxVy1cLdUTnarPzV/9bS8I=;
 b=tqLtCRAwe6sfgccaKzIHotgmbvBLI4baib7Tt1tmNyfR0kG80I93uGUn4WsP657356RbxWl0v+k/tpZkz0HDOCwf0CN3YgTdpuJu8QuAcezPsQyz4p2XrYnqelsCL3ApB6bG3oaXzS6eL14uW+mLmtfQ+nMs/dVuXs/f6xyqrmhEUG2BnTqm3YZZtgMDfeIMuQvkwAbK4AZBgZ+PCrH+iDiI8AVakOifI+rxfQDte6KQpN20+DbBvsxaKtIQ6pMbfpO66zdrQiuf4L64dPFy/F7g3QT56j1BuaQmo3DTNoYbJq/7g2XguqaYXPPLl2blKNHLdbX6buhN6d9K55AiLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:46:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:46:08 +0000
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
Subject: [PATCH RFC 02/17] of: Do not return struct iommu_ops from of_iommu_configure()
Date: Fri,  3 Nov 2023 13:44:47 -0300
Message-ID: <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:207:3c::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f44cb4e-9749-4318-5bad-08dbdc8c6112
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wKDfJz75vZ6K07dlPQy+cN6eHj6+UQOourTvqDQlp02i074OziluTkaKeEZNqk1gLTe5Su66BtbkfsDXSSfCNv1PS609M+4F7bv1DCG26rTKjD3mTd1hFDXe+4msNT9wDY4AjpLNkl/VmWgV7Vb1NHmPu8T66rGbmYB+rEIUX+Hc3WYURGj2BJkud2TfgunyqT15oR33Me8HjO0S1oMKELODwlqtWt5czulh7seN0FBja7qjF3ItwYoPk6jLzh7cLlLUfYUN8Pbvzz8j8ZiBqdlYU4l6LzujSwpYQ36cXm+dSDPLADzcofQLaBhEH7tVas2AURIqFk7Xwt7XgdQDy9sydEhiOEZyqOoFYt53TaayVAXXA+MC6duREPZB1J3i4jEeWb+5MLqqDT4eX4rn0HbU4rWYUFSY2KT+44YQhunhifk0XLuxFs6WmxhnIxZUHS20EsNpibPO+7/8Hku043GvN+G8NkAK/nYZrkccYPhnCDwdCnlSJVZ79PhJQDNsbQ8GUbNzXc+ZrInDTONh36kN6LOcrg2BLtJ1OypbZZrxmlRxsz89sijL8QGxCNI3mL1M89kBEkFaYMoYx7StAQ8LyLgimWaFax0PhhFvVAQPV40H79QRoxwODuCJvV5d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6512007)(478600001)(6486002)(6666004)(2616005)(36756003)(86362001)(38100700002)(7406005)(41300700001)(2906002)(66476007)(7416002)(5660300002)(66946007)(83380400001)(26005)(316002)(66556008)(921008)(8676002)(110136005)(4326008)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbhry8USMVVIDLyhKXP2eIUkihMIiHH7MZEYrSTv9MPYbvQhKmMrfSCPdHYv?=
 =?us-ascii?Q?D5qWzURu3pBlbl9dZHxjbtYDIYypanBDUHxeyzmYHzzcpK9dHhX/FIuaTYK0?=
 =?us-ascii?Q?tmC6DP2WMqox0cp/vwMmqRfiK2AH4NtGftoXjEfyLCqlfmeUxKFqVbholJ3A?=
 =?us-ascii?Q?3EygMZm3DyEm8ZTTWuTEzsIQXF6osjf7Xzn0armPR+RPr/7TAc7ym06Z5G/R?=
 =?us-ascii?Q?ezZxwvnHKGnPZDbfUumgRhyLl2YiS+iSRZOyiJGRyzL8z6/3umXkrY42Mvaa?=
 =?us-ascii?Q?9uTnIKvwQkpb1CRzUY4eNpqXc06cAkGHTduaaJVXipxy8tgyH6JgjPVHo03F?=
 =?us-ascii?Q?TUfkOtUmQJoIXNkPd3trESJ865XkCaZFNCLbSFF9dnS25XcYyVpeobMJFI3B?=
 =?us-ascii?Q?Oef6goGwykRnhyZObnYd03W0pYH6oPIKGDy39C9vQEGvI7FoIQkwx6JVPYNS?=
 =?us-ascii?Q?+8TNQFRyABiRfAR8nLkrNdJLGLbBCcPWUv2bmAwgbhNmFbB2KHbdQ4OHtRJD?=
 =?us-ascii?Q?vHoP8Dd1BdroAXhxXtI/gVByxATWC5fT5BzlMD6xOB9nMs8V4HA2N57dRAZJ?=
 =?us-ascii?Q?rLJtfFky6Eef3BpVoTIFfwNSC54hqBbwRa2NHAFpTQntdOixYX10t1j1GUc4?=
 =?us-ascii?Q?ly3EU5Ca9mOo6gUlYmIuX/HNiwdV07BpjQQMajP5pejuFRK/T3isuzEFQ406?=
 =?us-ascii?Q?YYkppjye1kbju7izL/4W+PZJGrcH4QgCuA/lbkfuC2Ex2NL1hDSpglo/YWSu?=
 =?us-ascii?Q?dIEjsEAyKC5OiOJsMv3TqD2LSzlYYPXM5xQp7D+8+N4+JtEumhsCTNXrgfwA?=
 =?us-ascii?Q?1kQ/fcDduTh5gYI38ilUH0n8PUXfsdmZS7UM+Zyuz/HcT8RH/+DOdDJm2gjP?=
 =?us-ascii?Q?3JBFuOLzL1lv8TjVomQ2Msv/cA6lfjnmLrzpa36GDe9/1NbpELcazZu2N588?=
 =?us-ascii?Q?fma9fdRi8PdYc1O7UPtHKDWylII4w5BdzR9rwQXRzKe8ypc3J5xXjKms5Cqh?=
 =?us-ascii?Q?Er937Nr7PCznL9sED6U4coWtZYxetSeCTnwB3aAnwgF1Pf6NB91aW9CiSS+f?=
 =?us-ascii?Q?spXCC5IeZSS94uuPxqxQesaKwg5MKYe4elBS+Sc1jOteVp12l1iy2k5KZy+0?=
 =?us-ascii?Q?jONxPWGTtMEdA49UpAvGvf0O3R4herc7a+OIaYYf01UIODdA/3ZmIQ/9uwvU?=
 =?us-ascii?Q?pgZsXdaZrc3DsDvgG477w4VuuvAHk2DqJUwCdTNCoJE38/Bq1bMkm5g8nUwL?=
 =?us-ascii?Q?qHFw3u0k0/OGnFiK4MsT9lMrm8rcsvOLt0V8UaBL4jjtfROD+pEj65nGX5Vx?=
 =?us-ascii?Q?2JWPDifs47bYwNFLym5JoHwjyqn+40e96nYOmUB3w/pCp4+iaw/iDVfynHeP?=
 =?us-ascii?Q?kjxq7yZDtjEYk8lBYrSJD9vEF0epEDMME6dq3NpsGAp3qd41VeP+Z9Iq81Ci?=
 =?us-ascii?Q?CGorhSnKzgR/+443grDgzvsQ13CRHJO1WeO1gbDFKcGz3oRVJsZGdfCqunM1?=
 =?us-ascii?Q?xeKIic6yOujPDrjw0ma4GIuJGaozcl8Br5kIEquPhu0zAHt1U2z1ZZbJIJya?=
 =?us-ascii?Q?B6IYwkXeSP6jCp+XHgMS2Z01NLahrLcG8ReZjDZY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f44cb4e-9749-4318-5bad-08dbdc8c6112
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:46:08.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc+wSvqmvTR399YTxwhqrCAaKpwbsX1ccviwKlrroVGfa093QyzzMvOCfCcuHXMQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

Nothing needs this pointer. Return a normal error code with the usual
IOMMU semantic that ENODEV means 'there is no IOMMU driver'.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 29 ++++++++++++++++++-----------
 drivers/of/device.c      | 22 +++++++++++++++-------
 include/linux/of_iommu.h | 13 ++++++-------
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf3a..e2fa29c16dd758 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -107,20 +107,26 @@ static int of_iommu_configure_device(struct device_node *master_np,
 		      of_iommu_configure_dev(master_np, dev);
 }
 
-const struct iommu_ops *of_iommu_configure(struct device *dev,
-					   struct device_node *master_np,
-					   const u32 *id)
+/*
+ * Returns:
+ *  0 on success, an iommu was configured
+ *  -ENODEV if the device does not have any IOMMU
+ *  -EPROBEDEFER if probing should be tried again
+ *  -errno fatal errors
+ */
+int of_iommu_configure(struct device *dev, struct device_node *master_np,
+		       const u32 *id)
 {
 	const struct iommu_ops *ops = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int err = NO_IOMMU;
 
 	if (!master_np)
-		return NULL;
+		return -ENODEV;
 
 	if (fwspec) {
 		if (fwspec->ops)
-			return fwspec->ops;
+			return 0;
 
 		/* In the deferred case, start again from scratch */
 		iommu_fwspec_free(dev);
@@ -163,14 +169,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		ops = ERR_PTR(err);
-	} else if (err < 0) {
+	if (err < 0) {
+		if (err == -EPROBE_DEFER)
+			return err;
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		ops = NULL;
+		return -ENODEV;
 	}
-
-	return ops;
+	if (!ops)
+		return -ENODEV;
+	return 0;
 }
 
 static enum iommu_resv_type __maybe_unused
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 65c71be71a8d45..873d933e8e6d1d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -93,12 +93,12 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 int of_dma_configure_id(struct device *dev, struct device_node *np,
 			bool force_dma, const u32 *id)
 {
-	const struct iommu_ops *iommu;
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 dma_start = 0;
 	u64 mask, end, size = 0;
 	bool coherent;
+	int iommu_ret;
 	int ret;
 
 	if (np == dev->of_node)
@@ -181,21 +181,29 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu = of_iommu_configure(dev, np, id);
-	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
+	iommu_ret = of_iommu_configure(dev, np, id);
+	if (iommu_ret == -EPROBE_DEFER) {
 		/* Don't touch range map if it wasn't set from a valid dma-ranges */
 		if (!ret)
 			dev->dma_range_map = NULL;
 		kfree(map);
 		return -EPROBE_DEFER;
-	}
+	} else if (iommu_ret == -ENODEV) {
+		dev_dbg(dev, "device is not behind an iommu\n");
+	} else if (iommu_ret) {
+		dev_err(dev, "iommu configuration for device failed with %pe\n",
+			ERR_PTR(iommu_ret));
 
-	dev_dbg(dev, "device is%sbehind an iommu\n",
-		iommu ? " " : " not ");
+		/*
+		 * Historically this routine doesn't fail driver probing
+		 * due to errors in of_iommu_configure()
+		 */
+	} else
+		dev_dbg(dev, "device is behind an iommu\n");
 
 	arch_setup_dma_ops(dev, dma_start, size, coherent);
 
-	if (!iommu)
+	if (iommu_ret)
 		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 9a5e6b410dd2fb..e61cbbe12dac6f 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -8,20 +8,19 @@ struct iommu_ops;
 
 #ifdef CONFIG_OF_IOMMU
 
-extern const struct iommu_ops *of_iommu_configure(struct device *dev,
-					struct device_node *master_np,
-					const u32 *id);
+extern int of_iommu_configure(struct device *dev, struct device_node *master_np,
+			      const u32 *id);
 
 extern void of_iommu_get_resv_regions(struct device *dev,
 				      struct list_head *list);
 
 #else
 
-static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
-					 struct device_node *master_np,
-					 const u32 *id)
+static inline int of_iommu_configure(struct device *dev,
+				     struct device_node *master_np,
+				     const u32 *id)
 {
-	return NULL;
+	return -ENODEV;
 }
 
 static inline void of_iommu_get_resv_regions(struct device *dev,
-- 
2.42.0


