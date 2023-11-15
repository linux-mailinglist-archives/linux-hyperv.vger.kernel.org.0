Return-Path: <linux-hyperv+bounces-953-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422597EC498
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443CC1C20BC0
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939728DB8;
	Wed, 15 Nov 2023 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PuP9lH3K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159D28DDB;
	Wed, 15 Nov 2023 14:06:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642BF101;
	Wed, 15 Nov 2023 06:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeFtZ2oBEnRSk6pcAbR9UPHhDr5buxBf6cvEHVlu+FXnmYmfe/iYVdIGA99I5QHCO7R3gPrCuLrlv2/BeC2csuuFOJeyn4RH10uVowqm0Sq3gmZRAQ6lCPMO4N6LsQfjMSLCMTDww0SLX1K7ejSn/cEhAqTuxoIzazPNOZUAe6Cy1nC9u52wWJBtRlzxr7zPR2OzuZo3jn3rjlvLB72xvKElY3SFy55YnfYd6J67Uv73weav8nAdF0uUUDykRIgSn2WYW0N775Z3ZsuG8MPDa/A4RBduIPHMn2yTph7JfyySkHvN0SbEVfRlxoLfXp5D85L0ZqpM7UU9Hh0ZpWY9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmGfuwpBfs0ZJ2gl8sOhab20hFl7awpkh2gd4isoKzQ=;
 b=K9wD3KaVgC9JZIQLzdxksAqwqF3BIZJq4M5I8WX5q97rsGydI41DhvYAQ3yIu6/OsCLDv2irRq+k37z7PH1m3lwgaCtMpbXTB5jzx0Z416v2ara2fTnROvOo/JxBrgN/M/i2ecel87Cwk6BdyR6Od86qOaksK3dC8YPJy3ms2h7baX/L2K5nlAVnKDIQjSN7rXNogm7cRtlQ2wxYsPeYYIY5sVoPiWMLBNAHqtjx0u/jT4rVFeR3jDUZyZWrhtDNXT+D8rZyyZRJStF2wKvsPy7HoD1KSk8IEh6wbvVMGH2Cdd+bni3ZCWafntecBjO90YPUh9w3hSj5giOz1+jSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmGfuwpBfs0ZJ2gl8sOhab20hFl7awpkh2gd4isoKzQ=;
 b=PuP9lH3K4NeaYY7XmJaMFKhttIWANqTx2kZKoNgXr/svmAO6+Wac2y8dTkIsa5bnub12R2timnIh7YL62LaBRqH0c80hN29y4W0O5Ui+E4F/Oa2gwWXutCOH2IxlRCSQffZvofCwgR/mzstYvJM0ek96fX/H5kF5KsOh+FsYEKJbbwCOc/d0eNJhIgT0Rcm+S+dfjDycp1w/64ZkvXAr9gm3JqP/k/Qbcn49Aainu297+iZEpMjPOnwUCi9elmsE1RMRpr2Qo+033hVaALrX1pixkmjQMrqyolY5qaZB7fGsEN+iQlmn5LOl5+6DUo01dKYqL4FYAaWESO5cHqQIAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:19 +0000
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
Subject: [PATCH v2 06/17] iommu: Add iommu_fwspec_alloc/dealloc()
Date: Wed, 15 Nov 2023 10:05:57 -0400
Message-ID: <6-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:208:32a::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 2479645a-7070-4d20-26fc-08dbe5e405e4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qvQIGdIbnetbXvAiA6j+3d7hEfbp/uXG3r5kcdKULkMblPlrXKIFOwVQP9t/rKPABrYGjMjix5ugjbCXkl96xGpK2wTtA/yUqfZo+IonC2jVYU1S5jb+BCOfsTYiTb7qbkOGuqjbqHg2VNVABfJ3Zq4IvP3hxHHmybJy1qguxaqckyCJuD4NDl5xqHk0RUoUliB7562reBUgGw2umeCkbTCPItMC//APp+5ljbtyzouJB0OI7Ir68SDpGHif4agRSoWFaiX3P5O3wSYwX19KP/OYle6FJ+iSk5mWYSx1LnVpQibd/LfnZslIU/RN318tTMwA00cB5MgeoovdLtDCVZeLb6o6bICBha94K3mbVDQaVDG2EEOiCmIkL3N/B1bu0Gz+iNDIQZCrK1eMADzP5luY2/KXi3dBipRYZHu97UQe9JHImtMDKeDiKuAwlUrVPfoBBZXAFPXID8F/x4zBZ6t3hMc0fnMUM3vn7mXbwYhP1S6vinLT1YgOypZtNRB0O0OvIbCDkZ0UpzGdUedMGy0hB17fivOJ/EGQ86DkG26CEuSNRllW2M5xi+OJWfS8OOFByiUfnUxgNVWc9ggtMb2qmWmZduXyYl5Nmq3i74iqABgglDCLvwupU0JBCJb4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66899024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QkYoRJepClUNE4YNwnegy7f7IidUvmYAfAYOSdSy7dysEHSP0felu1PXoan?=
 =?us-ascii?Q?Gkz7+nSXJZ9HqW2IJsgPYAdePSfh3vAciROtKGZSQBQrbYKfujqCxqeJbxTy?=
 =?us-ascii?Q?W4Np8xznCCF2mVpmo0txiEwqMkBsmkdEbkNcxFK9TTUQMrubUjbBhaJynE06?=
 =?us-ascii?Q?eUVaqWGHW8UGUd0bS0sXVHwc7RiDSQB0GwR2CTvYdGju+7sY+DL+6n2W5DT+?=
 =?us-ascii?Q?CEoSNs3xvlgU2BQ3i4EmLj8QjZ855YI1hHDGkr03XjuCllTw3PHDmIPyxn6/?=
 =?us-ascii?Q?a5Sga3zi+pdDDhuC1Bh7j/ehKi2LcTTehdPNTa0dV+8nFj0gldU6vcX+c30n?=
 =?us-ascii?Q?UNkF44OgwMvgnPHBgE9K9eyyO4atdwTfGPI3xbDce5QRDbSaH0K6Nv0d8Lrv?=
 =?us-ascii?Q?ve4P0KGKF9T83JqXMCL035Rlqbf30jGMA9P1jV03ZwZ8tmC/tVH5wP4ULFwa?=
 =?us-ascii?Q?GVA6XzyiVyMOvef/pQGcI50OEMk/ECH+Moo0ICKyNIvEB47vG4Jn9qOCptXs?=
 =?us-ascii?Q?xo93cOMGIzpEsTw6Wy8i/1Q+OzXeQE2iSVTYOU3cTAchjr9odB1QSI8p8HOz?=
 =?us-ascii?Q?aOidAucJRAFG8xEfbqTAFc9j+or15tTP/8E+GxUpax+zCbCHX4njXeDKwmiK?=
 =?us-ascii?Q?4wdEdrtPzWgHCHrDhT7QDXQYKxpQwp+93zc3f5J2vBWv68UnUERIzsrpnJ8+?=
 =?us-ascii?Q?B1yszR2JPT2OD8PghJxKjgFev1r4XL+z9aQqByHgpuxdF9a7aDqumWLNAB1t?=
 =?us-ascii?Q?BlnAlV8+eFeXFeoLglGeCYJ+4gQp+u6V2KyE8ghQM100IvoWIudCW6x4Dipd?=
 =?us-ascii?Q?LP5RUOkaHvvlYcjyWZq0pcCWqLOMKuZEe6BB4FLEggzV5PZuJeoUitKD/2cX?=
 =?us-ascii?Q?avDPgyATzpuw1Q4tj+DSmL521DXdNFtQu62AXmpHK5rt/3+n12X1i1SgBosw?=
 =?us-ascii?Q?C2LU+rocdIlqHwwvgJzqr5rysynFJebcl1lSKikE1+B4NUa7TJutp3nOpghY?=
 =?us-ascii?Q?dClvwlq0QTY/1Fxs7bJQc/ElW8pjcwC6s6LSMsQ4jwpnrqAYKe4phGa6u+a/?=
 =?us-ascii?Q?VD8cjUFDkgjZyLTULlLQgsW+bxYZDtzSfzDCNFpvsm+dNC/ADH4kDPQIZqaM?=
 =?us-ascii?Q?Twj88p/NZd+y+uoDmwI9sO32Zt6H+34iWxRv2O2IexQLCJLBGAnH6NMD5FYr?=
 =?us-ascii?Q?7ROBYt5qIFbKBzd4u1+kGaHCFrVNlwrq3KpsojvLmrYoCjqJddngHj3T9M/t?=
 =?us-ascii?Q?ZPodH0kX+kdn5u7a9z6oUuinvjMk8FqkhlUWm69oP+mEG4s/UxfXxQJpqx4N?=
 =?us-ascii?Q?bcFwQsqJ6u9BGqgLNZXdCWImLv5CbvowUb3Rteb682oLZB+u3oKR0qp8jzFV?=
 =?us-ascii?Q?dOq2PWYGi8FlzLGsyC94ktwcn9uzteiqfzYMrHbFAGFzMEqVYmkwpG66ZdMX?=
 =?us-ascii?Q?sATXOqsTL3Fmtg0FDycC44fkqprQb/wNd6um6wfpaw1E2MroJEgGJV4gQhUG?=
 =?us-ascii?Q?K8Vy6j9neXXXK45apLh8iZ0Lmy4fnpAbwLCn6yZnop7Dl9zJhdZSzjbbno7q?=
 =?us-ascii?Q?3cUv2Bbne/jHEctu1tU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2479645a-7070-4d20-26fc-08dbe5e405e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:11.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBTxd3rAglNhCUI2cE+3v3noBNm3Tz+pgAZKI7bxEYyFvTT4dJKpeuq5pnMFjkgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

Allow fwspec to exist independently from the dev->iommu by providing
functions to allow allocating and freeing the raw struct iommu_fwspec.

Reflow the existing paths to call the new alloc/dealloc functions.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 82 ++++++++++++++++++++++++++++++++-----------
 include/linux/iommu.h | 11 +++++-
 2 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 18a82a20934d53..86bbb9e75c7e03 100644
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
 
@@ -2920,10 +2918,61 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
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
@@ -2931,29 +2980,22 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
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
index e98a4ca8f536b7..c7c68cb59aa4dc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -813,9 +813,18 @@ struct iommu_sva {
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


