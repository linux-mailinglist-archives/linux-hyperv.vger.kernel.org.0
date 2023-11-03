Return-Path: <linux-hyperv+bounces-668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5089A7E06C2
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068C9281EAD
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534171CF8B;
	Fri,  3 Nov 2023 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SjAMSqVE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED771BDE3;
	Fri,  3 Nov 2023 16:45:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92654111;
	Fri,  3 Nov 2023 09:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOThym8DHMMD2SvPGpEg1LXePDhKWxWbfhZTmsCbH7gE54Gznkg6+D3Sr/0X/LvTg4PDrNzcgzY8x9LbVWGDBccWbWQFpzGHR/QVdYOJId7iM1gMWF/dNWD8avVZDKl8IDNi8q+dTj2R5/zqlNd53U97jj2rBmUcH327MdtLp/Y7OxL7J2WP99MqiExjIS3G3YMGewH3xxduRygf6B1J4sSKZPScFi1rH98RkmsNmnm7Jghwv+c3hACMNq5tvJNjaKCn7zaJp0rLMXG17z6ekJGGV2Lp3Jvw/KMPdRCL2keWgmoRqgUB+Nf0bs+9wthxEC0bzRPN8lXtAk5BWTllUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XNehcFHCv/WWEYzFVtCePx11LeVzFec8nSPjCUW5KM=;
 b=OpO/OGgvJtz67lNa4wVFNuHL20I27noJswO0UH5syPjg+25cZFildEUgxSDebTJiQHFCZ6c0eNNEtuoGUcBi5nrldKITWYcYgBl7UdfZ5pZaBC4SiSJ8xLx2PgIJmywY8rZ8OjMxDFj+Q3WlEYHIIKQl8BrlSyBgDItsQKN8O/ERtWA+5EA97ip39hbNfpL+EUQADtQmEjqaMoPz8CZBIkF97CDV0QZTlyoAeQNCtyPuLg1VSDnNX/7P28bJT+2Ix6iMKy/Qgc3XirZxBrj6lxQfI8R8qgOBRTJN6YZPxaICtkusncjnaDN+qTypsY7ODDMxfEE1Gr7d1XE2qcPMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XNehcFHCv/WWEYzFVtCePx11LeVzFec8nSPjCUW5KM=;
 b=SjAMSqVERHC9uchVXkvF4ywBqG2t28Wek+SKPF0uIofjdl+6WLtH7cHJoD2Yigh+w5HRmTdt2mtFndhTLl3HiLeWf7RyQ2apyReW0aOLcfnPP74XxMN3ErhmdtLzB7jsYtg58uTeHMmyu7bkRgP2MmEMhO3Xr3ve/p+Y5JsXhFNwKMdmYJxidZrzJpD+6UTdyEEkQKvrgBvUNGYBrrxS4HCTn5vIHFS3jQ65jbtR0c1f8ZydFxvQH6XrnVYrmf5K7DH2pXE3P8noJo6p3v4/6k077m9jm2LH1BONDy7dH3gxcofgmMpeYWUjiAFF2eiNt5GwczOirg4pB4UO2x3NoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:07 +0000
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
Subject: [PATCH RFC 07/17] iommu: Add iommu_probe_device_fwspec()
Date: Fri,  3 Nov 2023 13:44:52 -0300
Message-ID: <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f16dac-0fad-493c-3348-08dbdc8c3ad7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8nuoLIXsExwzhucVMCFHjw4v+ZaTcaqXZWBf5m6XG19N2kFuT40YpOJtKMowkxF67QKK7GAXMFxqZF7JJMWBRMqaH0UafEBQ6P3lGR9kJDlwwJ61Pv6ggy5u4Gsu1S9aiIou2y/utP01gbBRImGKCZisWklSrNRArfI34C079pRZNZql36u1iHNS4l/Puoqwy8i8GCboemiBtQXiGJtJAvQLoE66oFvKorgbbxf8zQ5WN13YboY81YLwZIuK4KXyeqaH2zrvqmNebV/JKzHjVvJOOXNPmP197wQmpwtVwLqlo/QCuEg/hmiMoynCBy5bm7a3nIV+yrTlAlXLRSoTLVt2PEHT8xa72DHuJ9lXtSLZihPYuduA8mlGc/9d30iGVXT5Yl1JSQ0PMpQgP1iBIPCIoa3koMTy/MXcgUoRDr7X0So8Y3eHyLa5og0RAxjiyJVWQOfeh7kIwuDI8F/+24bC9XIIan2N4aCXaISy5dLltJH9b0O88csvePHFT3Rsjov/pVxn7vm3Gfhp77qtyAzUrGfmFDhj/ZcwnWVkqkNCEjt5grHlGd33CtcXDqD8ca2C4JkTayO5vG5UxRPXtyWW7bprXU4eQl/jUTloCjrm5T7hV7ns+8gAjXmJ5vbz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(38100700002)(2616005)(66899024)(36756003)(86362001)(26005)(41300700001)(7406005)(2906002)(7416002)(83380400001)(8676002)(8936002)(4326008)(66556008)(66476007)(316002)(5660300002)(110136005)(478600001)(66946007)(6486002)(921008)(6512007)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FVhTH2Dlq1XjcX4ZS8xSXeP/6pZEKLdgziLafIB7IkzoyX9Tan3VnDHviW1V?=
 =?us-ascii?Q?0JM12xLMobUJv4mR1jKdO2RQpCWlbrrZY7KVVxsOQ4pFBf+8KRS1qvyn5gWF?=
 =?us-ascii?Q?f3oIoWaAQVvLNkAWBlxH7XpddOOqAgban8cTmI5JGnktLzAgt9RkaSH2Ngpt?=
 =?us-ascii?Q?FnXZuxbgbNL+FXx+Jx2Dp61+gBaFu0ERRLtMX4sVheoITW3YW7Kbuh0GhBNT?=
 =?us-ascii?Q?vpZPwUmu8/SUHp3OWC0TQ+j5IeYcd4ZKSlYm2FicDJBpGslLMnT3cL/UWUp2?=
 =?us-ascii?Q?r1OIzoDSNaydMfcAex57NZapv+IIw501nYhyBD4u8S4/dss+23COUr9ye+QR?=
 =?us-ascii?Q?/RuHMqW9Yw2FZEqvcoP3JMOLR87t6DlWhCCFvfyZJegyAU29NaGOQzuCo+y3?=
 =?us-ascii?Q?bqKxuULLQZSXOxTzT8aYZmmHQGKcnrPOHFMJ/1w6iVKvir+rdMW0yku3oVzq?=
 =?us-ascii?Q?rZPjBoXwUJD3ruaH/0Sgx2ttzYss+2R5t5SlGb83L6EKTz1+BtKl1oXs4DEd?=
 =?us-ascii?Q?6CESwEfgiVKSgJLhE2iDb/h78TqoI3HqBMDY5iJ6VN9U/wsLsR1qPRODkyWp?=
 =?us-ascii?Q?0PMvi3lAEOtVl/lpISmuGE+RRplDOGK7CvhPu/Z3JlmP1X4BhDENhbYJCUEO?=
 =?us-ascii?Q?EgxvspKdUGpWL766Pi1Cd9GbcdytdXZpA7BYb0mUO6S+RwvWxmPhAMjxv/Ej?=
 =?us-ascii?Q?WnvCdp7vxuO1/y/Dv1QUYZSO+6GslZ8I927VmtX9DaMl6IrbMF+ZLck6Kbf5?=
 =?us-ascii?Q?IotmdK0PzIZ+zf/Lq7ykJGRd9nAFS19ly0zwVWiqnQosZpjgsSnQwI8yodJX?=
 =?us-ascii?Q?sEJiQNlqwmymq8axcjs3YbDjRdTmQd4AwWA0U+DpKmLCyb6dFvpYAkvGcC25?=
 =?us-ascii?Q?rkXtvvCAGMHY/alj1NkhKLWzX6YbLgZfnVjTrBB5Os5z2+yS+fPy6kgef6Y2?=
 =?us-ascii?Q?QTm5EeuU+7JTkBKV6gj6fW+u2n5aOmvtCPHZ1ALPBiBnlvdLAI5IbvhU38MC?=
 =?us-ascii?Q?rkdCnwAXQi49g7OOJA65vPT5lTyy+JL1CRObwVHoe6888woLrddepnJpIxFX?=
 =?us-ascii?Q?gh+DZOs9QXtj/bAhPlzrujpzmwTxIvn8JoTrbUh+LNIn9MlMIBkrE5ZbKZ8b?=
 =?us-ascii?Q?4BiFjp5FC94PXpm8w+xD6vU78oVU+Vv9oqajusQROP/D/Au1a9/ssJw3OFp6?=
 =?us-ascii?Q?XFA6wxzD60m8nugD0OGhZjT2AGu6oIOJ6Vs1jDsAIEKU6ol915z3Colm1oEL?=
 =?us-ascii?Q?HL9bvd7r+DGxoko9pILhkdeK3pDZse6tr7xMk/JrxbCNyHX2rqjUlQNrQvZx?=
 =?us-ascii?Q?ChZoMgajLcgyy92Ius1+2HYqPV7bXt/E30kWh+S7d2xNCLimKDT4D+GNn8rS?=
 =?us-ascii?Q?iMxpC+5QYG5zG47izqmtLsSsM5sMO9XllVdgNX9Ot0ZH6l56scIj5HTh+5Aw?=
 =?us-ascii?Q?Qu+QkLVxCLh2EUL0o3zNn4+18S1r/2pDFh9kMe8ItoHmFZxIFRvw4h/sC9Lc?=
 =?us-ascii?Q?SxBQBNKJNpsGF8sAX3uFs2widCHkoUod6BOY2beE36SOh8sLu4pGH+bGVDGT?=
 =?us-ascii?Q?BXUgb81hUjoK+yQZdKvoLRyMIPi+geqBKGE93nZ8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f16dac-0fad-493c-3348-08dbdc8c3ad7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:04.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buYaDrN/6KAX7tG54gvdlvbFJOVI5ApI0bXCxHTtrU0Lg8lKFom8Nh0Aq7Ta6x0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

Instead of obtaining an iommu_fwspec from dev->iommu allow a caller
allocated fwspec to be passed into the probe logic. To keep the driver ops
APIs the same the fwspec is stored in dev->iommu under the
iommu_probe_device_lock.

If a fwspec is available use it to provide the ops instead of the bus.

The lifecycle logic is a bit tortured because of how the existing driver
code works. The new routine unconditionally takes ownership, even for
failure. This could be simplified we can get rid of the remaining
iommu_fwspec_init() callers someday.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++------------
 include/linux/iommu.h |  6 ++++-
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 46f3d19a1291b0..36561c9fbf6859 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -386,16 +386,24 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
- * driver probed
+ * driver probed. Take ownership of fwspec, it always freed on error
+ * or freed by iommu_deinit_device().
  */
-static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+static int iommu_init_device(struct device *dev, struct iommu_fwspec *fwspec,
+			     const struct iommu_ops *ops)
 {
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
+	if (!dev_iommu_get(dev)) {
+		iommu_fwspec_dealloc(fwspec);
 		return -ENOMEM;
+	}
+
+	if (dev->iommu->fwspec && dev->iommu->fwspec != fwspec)
+		iommu_fwspec_dealloc(dev->iommu->fwspec);
+	dev->iommu->fwspec = fwspec;
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -483,16 +491,17 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
-static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
+static int __iommu_probe_device(struct device *dev,
+				struct iommu_fwspec *caller_fwspec,
+				struct list_head *group_list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct iommu_fwspec *fwspec = caller_fwspec;
+	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -502,13 +511,25 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 */
 	mutex_lock(&iommu_probe_device_lock);
 
-	/* Device is probed already if in a group */
-	if (dev->iommu_group) {
-		ret = 0;
+	if (!fwspec && dev->iommu)
+		fwspec = dev->iommu->fwspec;
+	if (fwspec)
+		ops = fwspec->ops;
+	else
+		ops = dev->bus->iommu_ops;
+	if (!ops) {
+		ret = -ENODEV;
 		goto out_unlock;
 	}
 
-	ret = iommu_init_device(dev, ops);
+	/* Device is probed already if in a group */
+	if (dev->iommu_group) {
+		ret = 0;
+		iommu_fwspec_dealloc(caller_fwspec);
+		goto out_unlock;
+	}
+
+	ret = iommu_init_device(dev, fwspec, ops);
 	if (ret)
 		goto out_unlock;
 
@@ -566,12 +587,16 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-int iommu_probe_device(struct device *dev)
+/*
+ * Ownership of fwspec always transfers to iommu_probe_device_fwspec(), it will
+ * be free'd even on failure.
+ */
+int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec)
 {
 	const struct iommu_ops *ops;
 	int ret;
 
-	ret = __iommu_probe_device(dev, NULL);
+	ret = __iommu_probe_device(dev, fwspec, NULL);
 	if (ret)
 		return ret;
 
@@ -1820,7 +1845,7 @@ static int probe_iommu_group(struct device *dev, void *data)
 	struct list_head *group_list = data;
 	int ret;
 
-	ret = __iommu_probe_device(dev, group_list);
+	ret = __iommu_probe_device(dev, NULL, group_list);
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b827dd6a5844b0..531382d692d71a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -725,7 +725,11 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
-int iommu_probe_device(struct device *dev);
+int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec);
+static inline int iommu_probe_device(struct device *dev)
+{
+	return iommu_probe_device_fwspec(dev, NULL);
+}
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-- 
2.42.0


