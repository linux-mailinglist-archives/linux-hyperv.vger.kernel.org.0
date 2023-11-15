Return-Path: <linux-hyperv+bounces-943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06377EC477
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80279B20BD0
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC15286BC;
	Wed, 15 Nov 2023 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJKRAEyU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6582770E;
	Wed, 15 Nov 2023 14:06:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ECEE1;
	Wed, 15 Nov 2023 06:06:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6ZKNyTOenZy/QS7V0tcVx8L1FlVCHzHZke536PW/nE792ULEWn9GaJBcA3iz9dKgvGNYgQ1xz4h4f8uQ9ycHGXpbbAz9szglhhLqs4IV4xMclzsIieghTkV3xZ58Pw5HpQ0bCnJAsx5u4+AxrP+jUU4GcsgSrOiKvpx/P8ZtW99pu39qk5IDV8GHHkNThshuOLPOTftGWu/K30jsKMfXSbwFnhRFV3d0XiKjSz0WswzrAJ2/1bKP0CF4mwx4I6SoVMV7yxuYc8sa0AMH5Xyf6NzmIE4BEq3z7Ps3ZkE/2DtFxGXjb4t0d5RhLUx453sYtwMUKir3O/XXHOjzwClyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bir3wJ5bE5oIcXCPzV6/tu0r5Jc8YZAdkGwzn/DI8Bw=;
 b=RiG0WdEhNMO/dRkuJt4iYzW0NFYWw4DvtIImbZzeZKbr09q/+zqJUcIxh97iVcumJB7FgTGphReb2qStPVqWVgK2XFgCfZi/rn95Fc2+KGKNX9pDpHs23bBqjq4TaLmkFzZnxUiameJUdro5eVDC/Mw9jvB5ORLA+6eCRaPxNlTFroUOP6NuaRqz3VpX1jujRJ1HiBm6sOm/3oyl4JLd9QWIYH+3cfIAHJRFB1WwWaXC/jwRV4udrSSm05dF5XYRux1jZz9aD4oyQ4/qpi9ekISvUHROhpWC4Kidpxvbp28roMsxkgbk6t0oRRL1hSnJAHAlWDMvSWb7jtpBrHPzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bir3wJ5bE5oIcXCPzV6/tu0r5Jc8YZAdkGwzn/DI8Bw=;
 b=RJKRAEyULc2Fj3ShwMj2r/X7/onN1J3KtH6k1gn2RCz/KZnD2AjQG3EzsgCGRTwK0v9O5BsBXHvAS2b4iIO6i4agzsP1COcv8b+I+tdPZicIp+GShbC7Zv+0LLw+XmrxuIQjrDC5hdOK1u6/OupY8xE4gFEH6Lwlv4NmvezUhXB5Ld12byQel6Fb/7DM08yE0uTdQ4SQ9B94U+tyLsT+qBbusLnV19CQFVonJP8RlxNHsGqfvep2hpsKbR6wcLkgeRD/JfD83YXBM81mxrWJXLSCf1xCFvReVBZcxytvw7kkDeEJLLbF0zCnqk74lJVSM+c81exAQ+cRsV81mxuULw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:15 +0000
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
Subject: [PATCH v2 13/17] iommu: Remove dev_iommu_fwspec_set()
Date: Wed, 15 Nov 2023 10:06:04 -0400
Message-ID: <13-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:208:32a::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: cd89d7f4-a005-4189-2ded-08dbe5e40549
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eRsF/Dt4+HJ45bmYjKY9aho5heb5YUbg+V6U5kyIBLb6LHovnzZ34SDbOJTAJBZuLvaubWeNHh2M4ABzp0o2asxHRJ9OxX9Bf/sxG15jmpbgmPh7XGCi5F/sjpli03dAxP9JlXcfCsdt6JT9kWw+lTTV9f/4v4y4HFClZZKq8lHm8IAg03PTtWSNOmCbKxQiF0ddQxInRAPAhYw0AdxkW+3AofwTL4u1J4zELwitQeE6Lcwj50zwvUYMe2DJd7Js7T9PYDYZNaymQgkFHbMn9LgA8s7/aCjW/3pySx9mvwMWwza9xKgTccTcdqDDsvdTchMrs65mXmUMHoj+4FnZ1b3RjkqXBoA+tI15j2AO2YkKFM1A3zfIo7mZJGZ9X9PuV+60nI30bHeZHghdNpwq2dZcw0VLWyXxeX8zu3tNq0g5SiHvYQ68Wc7eGjykUv3EoaZeO+FT/+LphB2Nf3d5moUH//tMbcN9JKQSyl25g0IwnruyaASTyhY5yiRQ4gIbJImdGizFaeokUVJWai5lEKiCddQM1ukmwMhIg/c2BmLHKpiWr+mhEHqFseaU8hDIlwxSxlDzgV1l9f154Fe29ttRFbF4sKYiTuMaMwtpgL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/8zn0V4WhrkbUndJSfWrc/9uOTwc12pIBG8vkm6KPQa14TPV5PosFq4zIE9?=
 =?us-ascii?Q?PfGLNSgsBKF9X4ae9rsMJkrHigqOb9WdH0s9wT2g1DYMAOPvHnJn1okSGaPe?=
 =?us-ascii?Q?pxbDC2kKPGV5K+H8KWwelcnRPzvNBXhreNoO74Z3eo+N7XE6FqamMMH0HYXW?=
 =?us-ascii?Q?LUwKH2colznhNMwcV4BYQ1TmtAGwAapRkXehUuGySlyTBZWvngMb0P8xknPF?=
 =?us-ascii?Q?YyipIqDBCw/wl2GYlb3h+ocARwKAT8/cK2Cyq8mFM30zBONAW/NSrGfNYDOE?=
 =?us-ascii?Q?dHUmknbLc44m0as1Vgc2e8MG5LfUVr9vg4++yVO++wOMK3qM68zJB+DEuHmF?=
 =?us-ascii?Q?OMaROfb4iqLBmbaZ9rNzYZ72OU0kO2bPnWjuozw8gUv9rUlcC6F7TFKbjMtE?=
 =?us-ascii?Q?99OMhKTVvhZ6pNmFCnhfUq+Nh9+g5lXegDvurCWi3pot80nrAbuxDWs4wFqy?=
 =?us-ascii?Q?HKy7MGLMiTnO8A+ZvLWcWU9WIdLpgAPx3iXHJTayVRTLI0bUS5lOf1b/CqyX?=
 =?us-ascii?Q?OPbdMbTP78rHtEKc+OMW0Be2NTlu5ssOiEwuKf0jACVENPR08iTUh0bEzrkT?=
 =?us-ascii?Q?fem7ENP5S1GsdmGT2XW3g48iZk0hyTnzmkjErK4yEdvBDCIMvbZbZIE2v5VH?=
 =?us-ascii?Q?wNlfDP/0NI2gaYhvHZ93JcGbedOwr0VFHfyE/N5UqNeALKKFcupWDaUvtHaV?=
 =?us-ascii?Q?IFxCgcReIqB429Z8+8dmW3vHHVn/gcKtjQGzU68H9nIi1IxnVRPG4wmYjRb7?=
 =?us-ascii?Q?Asm62I5iXMeu46cu0PkDqUl/tgiwUrxUmjkIUXg39TOiJIsF8AImppOqn8jr?=
 =?us-ascii?Q?dqA//Xb4Bb1qP1T4IWPFZVWaAZTX1bmS9VZ34h1DS5lZ7DYUsn7RhMmgIzJb?=
 =?us-ascii?Q?r7Ge3j08267xRt2fTvHc80gMQj45ilx9UM4jahcvqaV2EbAir6HdrtqsjiK7?=
 =?us-ascii?Q?mtTyrn67ISL3COpXDe/3N5hGq5tmEUjm8GFMPG+aHTRYCYtyvvTOyTS+eFfI?=
 =?us-ascii?Q?g5i5geRku2UyV2TCR7PXPevGbv7JV4dXjk4PTvovGHYd8vi2RFt9zUpqM+tQ?=
 =?us-ascii?Q?oQ6g+n/7CJhWEKxjotPg2QO85V0hHsio/TXAWmSKDc69sX9tAkKm6Ebq3/0E?=
 =?us-ascii?Q?ljMm6ayVA3nQEBsiIf3C+oU+YPV0jS6QA7eRSaVYOH5/Wgt0RCjc+oIqdj6R?=
 =?us-ascii?Q?514z7ugxOSE0ppGRuhQM9ZLcXAIxeH8dHgBl7+Z/JJVwLG9yLsx630PSv396?=
 =?us-ascii?Q?Qr3Jq16vqa3ZILfeSa0eZsfsHDn0YYNnVqOWnIW/NwRg2ebz/D5hju6+jzGg?=
 =?us-ascii?Q?4aySaF8dYsW0sZwQc3eaaAqbuEskz9U3Y8A5StdaJiVoh5dA0NWK65T9dyBl?=
 =?us-ascii?Q?/t5QW9/U/a85l+2rd8mSLowq953wvS8/wVOxy4O7Ki4Kbkyb8GY9Bn02YdUZ?=
 =?us-ascii?Q?qcmBnPbY+vamfJwaLwOTUFntPI8dAk9EnimawN9l8WJ7qQZlBV/PjY9Jor3P?=
 =?us-ascii?Q?9n7YVUc9wCEyEPLTKTvZfWTR8+ySrGWi9x3upPO63Xbqo27GyrMZvBzgfnHF?=
 =?us-ascii?Q?aeiv/9bm0oKHtvvRXhA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd89d7f4-a005-4189-2ded-08dbe5e40549
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgeO7tGFptytqnbpGROYfI+//vuQKlJcj8GG14hT8X/d5Xj1dLhtNx9cUmz4898w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

This is only used internally to iommu.c now, get rid of it to discourage
things outside iommu.c from trying to manipulate dev->iommu->fwspec.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 2 +-
 include/linux/iommu.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ea6aede326131e..8fc3d0ff881260 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3051,7 +3051,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		return ret;
 	}
 
-	dev_iommu_fwspec_set(dev, fwspec);
+	dev->iommu->fwspec = fwspec;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 05c5ad6bad6339..352070c3ab3126 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -841,12 +841,6 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 		return NULL;
 }
 
-static inline void dev_iommu_fwspec_set(struct device *dev,
-					struct iommu_fwspec *fwspec)
-{
-	dev->iommu->fwspec = fwspec;
-}
-
 static inline void *dev_iommu_priv_get(struct device *dev)
 {
 	if (dev->iommu)
-- 
2.42.0


