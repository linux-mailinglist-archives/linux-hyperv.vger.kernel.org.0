Return-Path: <linux-hyperv+bounces-667-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B37E06C7
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6363B21500
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92A1CF8A;
	Fri,  3 Nov 2023 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J9+NTAil"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10751CA84;
	Fri,  3 Nov 2023 16:45:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD2D49;
	Fri,  3 Nov 2023 09:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTe0kPQz2GCE4r2eLGSxkb34Q/xFkyUMkq/KNOS3TY0hY89m1aGl/ga82ESetXEnX04Ztvvyz0w1S2nwdnxSypb0H1s/VmWviLzglsi60CiyiChYDDSjdwBgnIi6EgMEAPfnY7QUjH9c+DPoW9q3Twi+G8KGlM0ZVWb8Ses6ZrMPJJbGyQuU+QrVQhhHPAQN6y229fY72n5QItACR7l17e0OMSThQxApFVDmk/qOynGFUxQwEnpZJUzJ1FCrgRkKlhVjPRIdNBnCefDnp5KuTn6MdRlubunGpnygcqMNX6q0JKEc06fE/u1yYdr7vt1K+7WrByCGpsNLMDPtHCtq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP10aZ4Quqbs9zFZPRTR3Au32TdVHu3cIHkvtTh4E+8=;
 b=QhVOCOvG/4Q/pNUDZRO00g7kAsBBO86+0cbr1L5BuKP5O30IMWab6lcPmlFbQRD+t2XJoKHfnIYlAZBnQ+fNeAKW8QfWLt7E9hucOmTc/aDzUf+t5I4hxt2n+KJWU/o9Ud4cSrc18nlLbuwv3qlng/LNo//HYmWkaocRhN08FWD1J+2FRqdo3f0jvWQFhTdRAhWU9xPKmnfyJc7iIw1KOs/GeVVgdTFuBJHKbVz72GMHXZTwtY6Hl6hrENvcNzAbEw8h6KDwFtrrwpkvtnepA4Zz5eNZuv9FDyrrsLDzfI7RC8C1sY9OK+Z3DpHNNIatrtIwwJpBnYjvFbjIJ+0iPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP10aZ4Quqbs9zFZPRTR3Au32TdVHu3cIHkvtTh4E+8=;
 b=J9+NTAilQwoRv4xPnDjJGuV/J6siGnMvKC6xLsXvMQvWwAOaEunZ28w1bXLQ8fsWgE7jyie8ZWFtvvngPBzcyRP8bJvojqRLOB4YteOxL0pjjIwSZ5AT0HHrQKwGGtdQd5JPxYrfrbCRQLxWMGCSFq0qamfBYfrs+4ZgF2Hzpq40OGHdF67FFpIiPnrTPhz++7QpsxlnlUBhwuwbeC5e7bkAGGKQ8yGQl60YFnz+FF60HJL3WHCX4Ux+RLEbxkjsOhnZdi97Iw8HzlicFl0tAtu3SaMWuxC7HBNvVkZ+WRgyPQ84UfAKVJ48BS7oNTWi8EjBYTj8KM0qJtpBMbtlcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:08 +0000
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
Subject: [PATCH RFC 05/17] iommu: Make iommu_fwspec->ids a distinct allocation
Date: Fri,  3 Nov 2023 13:44:50 -0300
Message-ID: <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0322.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a95698a-8162-4109-8017-08dbdc8c3b04
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wDC1MIMMlTJ8LStmP9mU/0H4DENM15+vdwMseLSVKfhh13dGTCNVyMmLyq/2m9oH/7fmX5dVA2d5RkCuIMVa0LOtonVeauWNaNBF/8YJnNa8rMe+0ji9U9sJFlzaZRJRdObXzZ2dzlCa62Kk9Sv9YcMMbTfq5oQu4V8NwQUtHi9SAB4kpwhRAHXx84MNIXC8D9CD10UWKMKqrB53uCwxBskKhJnAfYl/takISrPl5/vGXsfsg9J7A3a3PBs6IunmBnTAEknKluJ8JIMmMSedNYRnq9HauYrQuXffVAYi1DZvflwdcWQQjd8dFJFuXlN7gUGK1HD13oapKbAH5L6cGRaebX7pYBsTpQcphQjTPUzCsBmwqbzQje18a33hCeryauX6/Bu5n13ZGhNIC/YMC6c9/XR0oMN+lc5Tmjw6tgM3TKOfE39UCAYVXcp6L0ggWg+wyWFe7po4fJU5GUP5Hpy9EEdhJ8WEn+VIJbUOVq3H7NIHrd1w+/Kv3lqgm6+JwDVI7FkHqx65VCdJRByIFng+RTpiJbTSJQpSHagGJZkalzFxCRYlytiZy73QkCmS0qrhL2S5P8aXcSIrU3L8fplh6nhQJAm0lbMSUu/2cUwIBYN3gtq47k7JJXoLJdXM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrM0UYf083pY65ufh2HCCmw4ATFnH9rqlXGXS8i3AXpihrtvVv4HRPV01aP3?=
 =?us-ascii?Q?9RoOLngH+kUCXukRP+xXiAlza+bs008MtEGY2T41xiaD2T9oPftHjBfqKmvM?=
 =?us-ascii?Q?O6bsIn+7ZVWhFAhP/kHjZcI1uTeGH2r9q7LxjlEPq4eRLCuS2PaaYoeNbmH+?=
 =?us-ascii?Q?EhT4n9TOT5sap37468EI2m2z335pSPUpVNr1RaBQkn+B1FvBNhBCOL+sml1+?=
 =?us-ascii?Q?411VuBPcWhRIWucYn9w51wxaOds1wgecZw/HaTF5DTJT8YN8uvVdZzNNgV2J?=
 =?us-ascii?Q?RHKmtVNE4nxVQa8sm6bjN0RTu3uGc1UEZl4VilNlBQRAe3LIAw7dIwrKfhfk?=
 =?us-ascii?Q?w1tAjkdzHsuIA5ogsihMDbKMBCQmOJ5EB2NZmdQ8KSJbHDNzUK3xq/B59SLd?=
 =?us-ascii?Q?lv0r+wSJVAyGOV5FyqGvVsxakkwCIKAOU1mEHiCOPkHMrsbHI2QFMyqYNmT3?=
 =?us-ascii?Q?J7/j2eL4oFxcB/s4l0b0W7sEr6cWC6cQrK3aj2x5Gv3r5b5MarITfJ7IR77F?=
 =?us-ascii?Q?WQvfp7ZDH29RE4DIkXFOwajz8bBzB+grmhTdWYmvTNNSVOGKoOT9Lkhzcfcf?=
 =?us-ascii?Q?ZXgdaes2atE9clGpZxerHDnlUzcurfSplD5BEzWap/7p0/j/zpmIe4hCAIW9?=
 =?us-ascii?Q?ItkziBM1vbG/3Z8YQ2jW2DH+y2ZNryLEFWhbNgDv05cAoepQudKwt4UuI5fW?=
 =?us-ascii?Q?cRBqiV2E5UGcEcvS5X70ArjYGFhLUv1ppiifuiHtQq40mXnBPZ+qE69ZxZV3?=
 =?us-ascii?Q?/iY1/005a5BoRKUW96SjK7GRSRIfCyPWInH6m1wIbSKpCf3KKkF82CYA8qhM?=
 =?us-ascii?Q?DDBAX75jsjYz6l3hq6FFcHSUXU/m8R96Osc5/7iC2d7Qau359Jy7bhGxJDq6?=
 =?us-ascii?Q?tBLtNY8RgKpjLYGHLqyr46kIgoCnaTVLqGUAMzejbuBXTrdyaKDezJUCA4dj?=
 =?us-ascii?Q?BkM5C0MRTVj7L+MKJwnY/fesBuB8X76lO73g0g6wEIdzS1n+O2hAc7UrJg/s?=
 =?us-ascii?Q?Qs+23uLymZ5YGat65+FZ7LGOsX595k+Zz3JREIB86ImDCUhoEJv/wW+vW+ey?=
 =?us-ascii?Q?CqLsY1V6WGZTTopGMxWpO/YXb+b4FiCFQSnpRQSwj3v9SH2qhMgIiEmysOOK?=
 =?us-ascii?Q?pymQgmV6KR3uDwPgVIc69cONMTNCa+IXXo/g2/osxybuTP8Khb/yjnUnFY7A?=
 =?us-ascii?Q?ogTWqFmUxkWPoZ8NzsBUAFRLR6EouJxhmQ5pfCPId6KkXsNVjgI8rLIm7/Vf?=
 =?us-ascii?Q?2x+SeVbKcpOx/tNAyYzuilD/eeHGxYeZDlqldRuD7ncGMhbJeVHnLdBOZWlD?=
 =?us-ascii?Q?jHVd3qpBCkb0F9XIFydHFHCOChe0gaI/WM+RGavcSDwA2S5VtUbWSlU8vcZM?=
 =?us-ascii?Q?gFYfx5y5v+0FGV2wgyc6TRSYZ/6uMcdcPSC66T6a7R1nJkblExwPA/+Pq/sc?=
 =?us-ascii?Q?xJM9DM2P644F1yb5NLFrazHGOTZ71y1MFCg1LRHpgiiSM38igGNxNPXWmpFC?=
 =?us-ascii?Q?R4dSZ5gesSHEDVAtbswyC94byvkJmDGFp3L8LTamz/zhsj0wMNiY11PGnBHC?=
 =?us-ascii?Q?F6kg8NTekEP4/sfOd4r1zV54u36Rfm0j1uOXkyNG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a95698a-8162-4109-8017-08dbdc8c3b04
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:04.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WOV/D5Z9Fty9tAglaqNpUKRwlFXvblAsQ8N85YWi+yb8En0iFWWwsOp8HSfVVUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

The optimization of kreallocing the entire fwspec only works if the fwspec
pointer is always stored in the dev->iommu. Since we want to change this
remove the optimization and make the ids array a distinct allocation.

Allow a single id to be stored inside the iommu_fwspec as a common case
optimization.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++--------
 include/linux/iommu.h |  3 ++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c9a05bb49bfa17..d5e86985f6d363 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2948,8 +2948,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
-	/* Preallocate for the overwhelmingly common case of 1 ID */
-	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
 	if (!fwspec)
 		return -ENOMEM;
 
@@ -2982,13 +2981,18 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 		return -EINVAL;
 
 	new_num = fwspec->num_ids + num_ids;
-	if (new_num > 1) {
-		fwspec = krealloc(fwspec, struct_size(fwspec, ids, new_num),
-				  GFP_KERNEL);
-		if (!fwspec)
+	if (new_num <= 1) {
+		if (fwspec->ids != &fwspec->single_id)
+			kfree(fwspec->ids);
+		fwspec->ids = &fwspec->single_id;
+	} else if (new_num > fwspec->num_ids) {
+		ids = krealloc_array(
+			fwspec->ids != &fwspec->single_id ? fwspec->ids : NULL,
+			new_num, sizeof(fwspec->ids[0]),
+			GFP_KERNEL | __GFP_ZERO);
+		if (!ids)
 			return -ENOMEM;
-
-		dev_iommu_fwspec_set(dev, fwspec);
+		fwspec->ids = ids;
 	}
 
 	for (i = 0; i < num_ids; i++)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ddc25d2391063b..66ea1d08dc3f58 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -668,7 +668,8 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
 	unsigned int		num_ids;
-	u32			ids[];
+	u32			single_id;
+	u32			*ids;
 };
 
 /* ATS is supported */
-- 
2.42.0


