Return-Path: <linux-hyperv+bounces-669-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A77E06CC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8CB281F4A
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1D1D52F;
	Fri,  3 Nov 2023 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMyAI9kX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B102B18626;
	Fri,  3 Nov 2023 16:45:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5DC1BF;
	Fri,  3 Nov 2023 09:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5ly61nduGWPPv2wNonYiuQ658O4jOJ1FUdsmI5I1gvh6E+8RAG6MLs7WKlDHuzTVLf5Qn72T8RIy82+8O1PJvK0AV7TlQAo+ml7sjLr/kUQF2zMRMmdx2kNQSFCmTcl+y1sdt33neIsJr+ieEA1nzXwIxAq8cbJMd4fM8eCqPL+VRsusKH0auH52COq+IuaQo9vmBs8fyRdxvkF6I/bUstbt/H1XGhWN563+rmyjXaSeMzYe/3s5HbHB3I8nTcbc8ysEypdwcD/BnTD2sl9gL/n4fBZmEc1LcN1RkiXqq/0mSSvyrdDRzf37AMOcCt/b5ifLTcxu9f8os520IgF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JQ35AEWNWv/xnhSZvoDLuDgdERnHhd761qmfhbRcko=;
 b=JInBHGCaIUF7JXq+Qls3q3/p9P2r5mu7WkzQmaA4CAwWoSM8aDExpYxLHzXQgiESBAwcS4sOLaxkfBTzMK/szmBPvSEXt5bmm8FaebiI8QuwiJdZaUz+0g2QseyreKrvoyC0TCOEzKwy8/1ZPrsLgtg/GSqHmMgB4C5KcqyaWs2cHBmpmBN0sTNwWsnoFUgLsLRe/BC+tlO/f4TBqKby9ldPci9bLBzYUg2MCk0nW/yvm2GIru0E+RxTXwyLzXgRTMrZHP1qfBh1EDR9EMduTzK54QRQJzbpDmeVU5D8GHmLo+LqgwQ1/lsHFSsyw8mKz/FFr7jK8FmRVF7hDkQ/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JQ35AEWNWv/xnhSZvoDLuDgdERnHhd761qmfhbRcko=;
 b=uMyAI9kXWURKRrrES7AJYqdKq2xNWc/zSYnSL4zOW6qu+Qe57xhdcvwwjr62jOq5LsSviMt/OGuS2FujKBC6DylhIKtpw36e9j8OMSxWcnXY1Pnw6ZIAPUGquvOC+ecNBKMeb2nDmembE/LkVD6S01x+GW19OyWLqnFUx48Vchw2VuFIbjUAruXYr3kKh/En0j3cdQQaGHm73/4ocznuSzJ6X3uJaRfh6LQ3G2sANuKffVftVsBF7zV5c+UAiHazmeeq4hQezIQj+EDW4hCgxxBq2paPF6RA92rU5gNgBXCDVram7FzgGKf2DQUxDPiOHKLgnilytk5+uHomP1FNYw==
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
 16:45:04 +0000
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
Subject: [PATCH RFC 06/17] iommu: Add iommu_fwspec_alloc/dealloc()
Date: Fri,  3 Nov 2023 13:44:51 -0300
Message-ID: <6-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:208:2be::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: d81a03e4-0a39-45b7-247b-08dbdc8c3a67
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hMxufcn8eIpvH8EkGexy+3DJk2NE68QzETwlc4p7IvVBEVelsOiaZvdA+K2dyR4RBVoDi29HrvD8u9e8XqO91GeUUBLkWGMNBJjdwxgPmly7gWh3UPplPqfI8J3OD0th0gylYN9EOZyPIJbgdtCuoRroxhGok4h8B8o98xPn+OayNkpXxciAjHwQNgAnUiFS0X886V7dz6cFs66E7qAWyDE3H9/8/RB1itbCaUbSsTj2UFFw0TOXTGKMMpfWs8+sHhqwOJ8iuBDVXc+Yqi6lQih2Y5H8NboWtF7y4zBQbM4dPkKZHV+hobGyDTYZ2kv21EdIXmSkV8B5tBWBGOX2O+OKiKQxVtQ50IFXfADrz+d9oYlXPTXQJuwEbCE2iaY1NiVltMQWJGy1HsRGBWaDxBg4lWDOEWjvI2YKyxOJEJC5iZFGyT/qw2CP5rCkXx8pzCOMH9jLuNBkvMDWluIgp8sJ6oPNDJcw6XU63iLpFN8wRTUt+ZuAqirF/ighE88iH1uOhi24T6GWMzOYAGl0B2SSfGy6/ouK5BSexQetLzqyYvKyHrRRDJVNNtpaMYau4fLYVxTQfWRNbCkKBS26/2J9UyawViEmz0CnbjprU7RORgoQYkf7PlU3x2QC9rz+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(66946007)(8936002)(66556008)(8676002)(316002)(4326008)(2906002)(7416002)(7406005)(110136005)(66476007)(5660300002)(6666004)(478600001)(6512007)(2616005)(66899024)(41300700001)(26005)(6506007)(83380400001)(921008)(38100700002)(86362001)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01d1opg+buZNlBzg2anRCsqFBnwDekSNwt0HrL9KptJW6lMZD27x1ob8G9rT?=
 =?us-ascii?Q?9d5kn9ub+0+InHlYLY6YmoVjS4FzXokvyUfHcy3HVkyCt01tNweSRidPkTvF?=
 =?us-ascii?Q?t98ykf3XFQc37FnqkZ1WqL+RCjD1GLRQ+m9D0s2Ag1jdjRDCCJ89twyeai5Q?=
 =?us-ascii?Q?Oi9KXgrsommjAI6QGS2gp/RVF5RD/hDWfoh3n41u0+5UnR5pma7odoCcsEJe?=
 =?us-ascii?Q?c99VjHVOGFEGRp5habKWdjK9LYB54CLiK95s45rBvhjU0lCBOh4c6Pi05iUs?=
 =?us-ascii?Q?fSMi2itdvr5hv5UQ1iwwOspMa3+rRiYUNwkmKLEDIeXtkCrKTijc6wh3DV+Z?=
 =?us-ascii?Q?KhGE0r9ugH1uaHxXNIk43/TWDCMzmkZDjLu1yFwDju/Hnr6lneeTxjTRHY6S?=
 =?us-ascii?Q?s7OHkGXdE7tsZk5krBS+zpC6KYBkrznqsgXfIW8fS1xVJSH8ktHb4E6TXcoj?=
 =?us-ascii?Q?gaTOYLHTV1epywxoPbUFliSdW2ek1/U7WF4l9G9WM/r5WaHt8uHB+fFqqXye?=
 =?us-ascii?Q?kiDFd3EhU9BUEj8YRnILYcDd3llLohUAQ++RaciHQS15oKQi7Ogt2o8jggS9?=
 =?us-ascii?Q?o9tNR1Di2/9H9rvttuU0XcoR1837EbTbzxEdhKRoqCdAErhKvdTQgyhhw8zg?=
 =?us-ascii?Q?DuVkU9GmQBjBJJGQamQtRYUUw1lcD9wGydQyiHps79Lx7tZc18DoR4da4Ge4?=
 =?us-ascii?Q?5DzfsQeliH8NvvNF7rOfOIWoZeRufZeO9w7cOGzTUF3kZrj4bpa6H+wIa54n?=
 =?us-ascii?Q?T2yjDJcUHvYR2YFwUDZ3QBXicgXz78mJPrHGA+mnC96Je3AzKDKHW+PH/9za?=
 =?us-ascii?Q?/15P3HweG+oExs+S5ngEN0wjY9G2YYTcXJqXhHz0e3DQvmwOeHs4++4iDkK7?=
 =?us-ascii?Q?93lHp8pFeo6OovHHBO/z7/+uKoQV6UaSlO41HpleOLbinvasOU8PeXq2cu7L?=
 =?us-ascii?Q?UvCbOE/7cim6nAVL/pWGMf+zkkdRbv8dWYX/Kr5bWBRASdg9suLQ3jNy4Srx?=
 =?us-ascii?Q?VSDT6XApCO1QiWNjmZ3hjuis1UA1e4V18FRGN2bJWm4u+86PNGBbsmTwB9uT?=
 =?us-ascii?Q?nS2rvk2z3cqeUgEvXzA3sIOqu33wYR/SgRotz7LLnEE5kbUpYBqyQH5DeqnJ?=
 =?us-ascii?Q?DNUYDasJMiDz5PghrlQkzL/twFtyfVCx3U69SFAdUsphQLlmJOAaDaul4Gpw?=
 =?us-ascii?Q?WdCqpqLiw6A56NDh6z4lfYLnrHQJKE81ZND8VGFv+E9JUrQcMZyovSVQB0vk?=
 =?us-ascii?Q?Xr8DvYoQoFTeSYgHY+1iiidQJPT36jGNBsHpt1cb40k84agQmI6pnHgpBpd0?=
 =?us-ascii?Q?wuXczQHTOkU1vXzEMvKWLnXcVN6PidbRcGnfJ8mYPIOalFjvTDhuhxL+vS7x?=
 =?us-ascii?Q?aaUaS8a6acvuhBOPjNKe/HvIfJPgZC6TjHdYlUyioE7B2LCK/rAil3cEqAiu?=
 =?us-ascii?Q?uMJyJuGIWze1scVWN5htPQNhvsTwf/UaCUH4ZXbixyxzCjrnzhFdWXx6wt17?=
 =?us-ascii?Q?N8BZtrK1tQpE6AvydNWwbIpwLwmj2AZr4isatpAVKL/0iz1Mmq5cTB3m6qi6?=
 =?us-ascii?Q?4R9R2m0K+IXCErMJZTs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81a03e4-0a39-45b7-247b-08dbdc8c3a67
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:03.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tkz6zRTvjhrvHWPRshig6XyCvmAvnw88KGyDw/g/5swsN29ynfMWzkY6g9C1HP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

Allow fwspec to exist independently from the dev->iommu by providing
functions to allow allocating and freeing the raw struct iommu_fwspec.

Reflow the existing paths to call the new alloc/dealloc functions.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 82 ++++++++++++++++++++++++++++++++-----------
 include/linux/iommu.h | 11 +++++-
 2 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d5e86985f6d363..46f3d19a1291b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -361,10 +361,8 @@ static void dev_iommu_free(struct device *dev)
 	struct dev_iommu *param = dev->iommu;
 
 	dev->iommu = NULL;
-	if (param->fwspec) {
-		fwnode_handle_put(param->fwspec->iommu_fwnode);
-		kfree(param->fwspec);
-	}
+	if (param->fwspec)
+		iommu_fwspec_dealloc(param->fwspec);
 	kfree(param);
 }
 
@@ -2937,10 +2935,61 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return ops;
 }
 
+static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
+				     struct device *dev,
+				     struct fwnode_handle *iommu_fwnode)
+{
+	const struct iommu_ops *ops;
+
+	if (fwspec->iommu_fwnode) {
+		/*
+		 * fwspec->iommu_fwnode is the first iommu's fwnode. In the rare
+		 * case of multiple iommus for one device they must point to the
+		 * same driver, checked via same ops.
+		 */
+		ops = iommu_ops_from_fwnode(iommu_fwnode);
+		if (fwspec->ops != ops)
+			return -EINVAL;
+		return 0;
+	}
+
+	if (!fwspec->ops) {
+		ops = iommu_ops_from_fwnode(iommu_fwnode);
+		if (!ops)
+			return driver_deferred_probe_check_state(dev);
+		fwspec->ops = ops;
+	}
+
+	of_node_get(to_of_node(iommu_fwnode));
+	fwspec->iommu_fwnode = iommu_fwnode;
+	return 0;
+}
+
+struct iommu_fwspec *iommu_fwspec_alloc(void)
+{
+	struct iommu_fwspec *fwspec;
+
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	if (!fwspec)
+		return ERR_PTR(-ENOMEM);
+	return fwspec;
+}
+
+void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec)
+{
+	if (!fwspec)
+		return;
+
+	if (fwspec->iommu_fwnode)
+		fwnode_handle_put(fwspec->iommu_fwnode);
+	kfree(fwspec);
+}
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int ret;
 
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
@@ -2948,29 +2997,22 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
-	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return -ENOMEM;
+	fwspec = iommu_fwspec_alloc();
+	if (IS_ERR(fwspec))
+		return PTR_ERR(fwspec);
 
-	of_node_get(to_of_node(iommu_fwnode));
-	fwspec->iommu_fwnode = iommu_fwnode;
 	fwspec->ops = ops;
+	ret = iommu_fwspec_assign_iommu(fwspec, dev, iommu_fwnode);
+	if (ret) {
+		iommu_fwspec_dealloc(fwspec);
+		return ret;
+	}
+
 	dev_iommu_fwspec_set(dev, fwspec);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
 
-void iommu_fwspec_free(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec) {
-		fwnode_handle_put(fwspec->iommu_fwnode);
-		kfree(fwspec);
-		dev_iommu_fwspec_set(dev, NULL);
-	}
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 66ea1d08dc3f58..b827dd6a5844b0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -683,9 +683,18 @@ struct iommu_sva {
 	struct iommu_domain		*domain;
 };
 
+struct iommu_fwspec *iommu_fwspec_alloc(void);
+void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
-void iommu_fwspec_free(struct device *dev);
+static inline void iommu_fwspec_free(struct device *dev)
+{
+	if (!dev->iommu)
+		return;
+	iommu_fwspec_dealloc(dev->iommu->fwspec);
+	dev->iommu->fwspec = NULL;
+}
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
-- 
2.42.0


