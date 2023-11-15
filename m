Return-Path: <linux-hyperv+bounces-958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B587EC6B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 16:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238041C20A97
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA43381A8;
	Wed, 15 Nov 2023 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XPy2nhu3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845F1EB45;
	Wed, 15 Nov 2023 15:07:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5FAB8;
	Wed, 15 Nov 2023 07:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oToTNxK/3k+YwTPeOrPScCq1Ruc56U3Ttd9535IToPHv2xqc5ZJ1qd52DTz1Lay4ATEZx4DLo+IN3FcQOWXmqt459rWrgrUw+LLFzOQgNmfLQkDGeXqYTUMOAgcJI8vnaxwk0hOJ5x/twBAbcPiTt8QW0ChF1iomPnyEp0+CauqJJA28eazMCUnlulelPpQd8TPevkPdf+J9/lyQ55M4Kogj0F+SAkU707pwsEiu0TKHPxrmm1q9qRHaVZ0LQ9iWt/9mj5t2scV10UPG11rlreeXc1ci7uSoek9C87W+9huaotjgXpso6I2Uvz0xka6M8oe2lybni/KU6FbrBGyFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7HFA1wAtG0csX5SIcxeCgmNi95dTiOCE5SEtGWaiKQ=;
 b=EmtrVKzX+l/dDjm/A8uYSrOOqv9Putznm0B3z5lM3jYZVPlqoANeVjuSt54LBzDzXB7GIL2I4jYX1DGVtLkycAY9wvWjYtMUuHH28pqYtSExkgqFEguFYPujigtBQ7dPBRPyWCa9nCFcuCNnMQGpsyLBkUDRYT0cNB4VtuDlz6v3bU/L6O/rLOHLDQpwzZTAPnThHHzjYinUYcZTtNgcqq7OKsZY76IahpyOKRjzh5BBcRQ+8f1XLWZeyU7ohRSfWSfsPM0wm8BZQuWa3dLm5OumLimYbSlP5Mqx/qocP69//8cM5wLUEic0zAn2y5jO6/uVD/VsaAMVXeqiR1O9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7HFA1wAtG0csX5SIcxeCgmNi95dTiOCE5SEtGWaiKQ=;
 b=XPy2nhu3512SOLvM/FXkuKfj0O4xlLOFPILPelrJ4GJlnQOJi9yfY+HRG8PAwYh18CGANHs5Eq0FUZKV1uwzDTyo2JMcnMOJTv3y0aSrMChw/F8NZD3+Cy6D9UcNx385lhPNteRzI1e8K84flk8sOr7EOA89Hs8VVKgRc7S9KHzg+/wwSMj41fgNgf1Z+hMoURD9Nc4JUUZC1SGOy1edZ/McJsjChGterU4Pj8Cv0rB8TMd1P6OsOvj177wQgMAoKeKMKzvLnqzpB9Wx6UOgWAGSLVlcnCn2xvRXXiRrhcJ5xL4ZBkO/cLsGHo1Rd/RRKNwKRt0InG6A2WZUcx0+Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 15:07:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 15:07:51 +0000
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
Subject: [PATCH v2 12/17] iommu: Make iommu_ops_from_fwnode() static
Date: Wed, 15 Nov 2023 10:06:03 -0400
Message-ID: <12-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:335::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f368c15-69c7-45cb-f022-08dbe5eca2d2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xym5bd0OZ1BC647cc/VJVki59kPeo04QQhE0kW3PfT3GElEZO9z38lqW8DIa2WeEtPSJRYq+niFpNAsRO1q6wZ41FzNrgWy7viI5R5A268OOetoc3m+FzYA9HzKp534oZyWRiX/VITXR4a7Gegljrtbi7sPz+4t26SJh2GTi8V8+3Xy3Xl0A9JEua5cQIx7GqLdLy6HpvRKm4p3CNsHZ/AradyYxbmL/ByUviWZvml/2L9UZLsg7F3ObFViZC9C4h/0pGhg4X3PWrca9QKKc2+27YnveEdGLmoZDwBRxfXMtbW1tqW0dbZv575p+R7QpWBHOGHaTmprx40nAMjBzFMwBnLwsOSLM3IeGM/6sy9dyug+RY45Rn357pKh8QQo+naz8w5BYd6PEZ19RqI42PDTURdVi4F18nGj96tKR6kgFXX6W3unC9HPUzMihraFNA8ir9sDs4MZIy7vWmPdLJU/jrsPKCDVAeaXbQm472B5OjARtXN0oVlHQxLg8D/540VpI7m63LhWyZnznVv7TnFmIj4Cj+Dr7NsRQxPI2TKMZq7GadCZZ9s2FVwjNBxKBRZ9/UmLIT7e87egphQY61J+n248LeGYAiIGWBNd0o3PkVQoKdMrDjplIv7XhqJjNRaKeC94MipxvQmPqx5cYOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66946007)(6506007)(6666004)(26005)(2616005)(83380400001)(7406005)(6512007)(8936002)(4326008)(5660300002)(8676002)(7366002)(2906002)(7416002)(41300700001)(6486002)(316002)(110136005)(54906003)(66556008)(66476007)(478600001)(36756003)(38100700002)(86362001)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LzwSwNC3UdwlGthEtWZssfe+fIm6hPyA1Z39LEjmY07qGJ2H6OWg8VMnjcrj?=
 =?us-ascii?Q?A4t9wdgya8gKNrjp4GyMV2FC0vE90IMXKjdWpdG10ncBkZqEsUVdrChu7U8g?=
 =?us-ascii?Q?JlgSO9SfFEo6yG06TEcqU6YyCvYFsBAfoHv50063GZYW1uOvf97ua7KSs4Qz?=
 =?us-ascii?Q?Wn0KGQV19UV7tYTYgvp+OyoxJv43ygXd9c+kIy5gp2G+0cUj6wrWqY58ZjGk?=
 =?us-ascii?Q?cD7hF4AhZKQVqY53HdR660cDm8ujWWKX5zoDhMvewFf5wpjQAyK/xdvMxxrJ?=
 =?us-ascii?Q?bA4jZUrcwb8waeO5TJOvJETv+vj+WWRJheHSc74mAYRKluE8UWT1So2awa2f?=
 =?us-ascii?Q?JtH6lvXxyHgQyZtBumtQDpgHBZPql8IwMyKdZDeYiQaGnn46Y5bk9IZLDJ06?=
 =?us-ascii?Q?y922dOJ8X2MTBhUkvJ8fZtVdn/rdLI5ci7/Yroje9K9cuvqTkW6OVYNA5erk?=
 =?us-ascii?Q?fwrGi8QECfiBQGcJJcrzv45p7GZHD84BSogBoIHKogiaxvjyh0af0k9r9T8Q?=
 =?us-ascii?Q?8aL+vJFotYm8KBcLssyYYNikrCcmxiLpgl3i5Cgj9U2KoyPA38u+onDc21gi?=
 =?us-ascii?Q?Bl0VYUJqxxPRgswXMqcYtXwcbGv797gw0+VkzNi6YtZEv5mozvtqv6RXUvps?=
 =?us-ascii?Q?NGumUf2Fzic6+LpSNTKqCwaIfQvalvaJarUaAc4oGeTwwsTNRfx5sFE+J4dI?=
 =?us-ascii?Q?j0m5/af7XTHPcxeXj+lwFNh0OkZO8yOSXUQ5P6B6lTN3SeOLwVnp8SDcmpkU?=
 =?us-ascii?Q?DxLeSsbYA7U5Av09YXI3J8MwA5+H/eKroEYfP9iYD4rzhxCSKWsUfpC1N95N?=
 =?us-ascii?Q?x7ltWivXPN5kXMYMAw+XmJuHGiZhZCzS5+85dbcjerpoUNeWRMXJFMFIfQvd?=
 =?us-ascii?Q?OkytD0xW3FDabm1okZyK3xO6YB0AuP7Ym3gWPNvcSU88+dW7fg60JPyKp0io?=
 =?us-ascii?Q?HuEc5a066ajTPFM+obIs2DJlytUxIlzmu5x8huF68LpVvloD1uZr0AxrjpcX?=
 =?us-ascii?Q?1meqGyhqMWVzuGL4Hj3z3ZbNwYSZBKN0jP0yD5cPooiTEWkW6jhKCZtMKRMG?=
 =?us-ascii?Q?hJ7FPCdkiKDnqHddBja/hrvSxFEKF+v0g5nT6wk/xuVNbxHzxOD1xe28Bi4d?=
 =?us-ascii?Q?3dl8Wh2cbinh/PPVjZJEuio3dMK6o56ViZ2qfYmnysq2mBrASnf8W7dQDlwX?=
 =?us-ascii?Q?vHaJ5qV6tyPJbJQTJNp/JPI0q227CZ5L7QSArrHfXRlMuW94JmTIY2l/TFOO?=
 =?us-ascii?Q?hefFA5OZy+f1cNDdHgFOMrjRcTN1ScFqLxSMgWrVvBd+pfQ6s2kCdZ38ljXw?=
 =?us-ascii?Q?vs6td2r2E1ZdOtXy91zNPyoQeO+bbtVHDRNWrIg+A+/mtlsynjFfQypGHyrA?=
 =?us-ascii?Q?MYvK1LHoVmNqwIDKL/NX6kBixwvViZJUliVkfP/TQV/wSbt8O1d605eBKDVt?=
 =?us-ascii?Q?PC9fAaBbwFQipIulelWPJLXdiEsvNSMZ2LRj4VG5uIUgKcY878eWcO5mKgsa?=
 =?us-ascii?Q?3CDTwbueFit01W4AgJdq+ISftinyCb5lrYSJ8h5gEf8UZ22IwfLAuZlMNZXS?=
 =?us-ascii?Q?lMa23pAA4RUV3knEgGk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f368c15-69c7-45cb-f022-08dbe5eca2d2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:07:51.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuAF3swyi52gNyQ/wE2Ko+9LRO6tOxhWA7NM5NAyq5GdaIlSz0Xm8/SmvLHUeAO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

There are no external callers now.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 3 ++-
 include/linux/iommu.h | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5af98cad06f9ef..ea6aede326131e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2928,7 +2928,8 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
+static const struct iommu_ops *
+iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
 	const struct iommu_ops *ops = NULL;
 	struct iommu_device *iommu;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 72ec71bd31a376..05c5ad6bad6339 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -831,7 +831,6 @@ static inline void iommu_fwspec_free(struct device *dev)
 	dev->iommu->fwspec = NULL;
 }
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
@@ -1187,12 +1186,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
-static inline
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
-{
-	return NULL;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.42.0


