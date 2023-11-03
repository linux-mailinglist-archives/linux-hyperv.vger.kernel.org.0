Return-Path: <linux-hyperv+bounces-681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422107E06F3
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F2EB2144A
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E31D53D;
	Fri,  3 Nov 2023 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rSkGFmlM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79581CA92;
	Fri,  3 Nov 2023 16:46:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1121191;
	Fri,  3 Nov 2023 09:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqYrj4t/KJl1mSPw8Om/IcpFKp3lk7CwXeplC+LPq+MYrhGsrbKdrf+u3kLESu5kudUHk3IdbetdMikpB8QPbjgFB5jNTia/Sx5SRJuauEvc2Y2CxsBG4PYRBI2qw8/itGPQluIogQTxiXKu8VckycYJjOB4iDB/b0MRvU1n2NiHp41P8TA991KJjdtnwi+7mL0HvJTBxXvtNyXfXKyv9sViBMT+N7FtiAfwamx2LrrIYWNUmMCiH6TdFzipoqhklIiL0jsuTFSGKe7VwDDvFSIGNFvM4NyempYL1JOX7tNcc+NORRAcr0OjdRSrV7SUd1Ycq816RDuPQurENXvLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiuB3Wvk72iR9li9Kvdx0Wd/AMHJDjh4+qRdzb4+xX0=;
 b=YdpLdQ7HfWdxDimzahU/bN5lJS0jbQok4h8cDnRiSL1UH/HscvP5nZ07gFz4rLaIeYOym1YJXw1Ky/3c02RWXnZ4WI8KVmBIpM0A9l4DP+IqqvWOWVHmXra3NjJDA09VSpUDSrgtknX/2QZslNpQnB2P08t6mtdj3hs2a1fA1kaFWe6/Uq6w8GLSyUDA3FHVBTyPpkYHuddys0MBGhco0wYgTyT81Wt11HhcyJVIQFM2OjfqlMvGa/LmS2LCuJ65QtXRD76EAQojDU3qkl4TjfqWCgyTeHp9YTtbBzlk+PYo5oiuemJmxTY/s3+Io2NbFEfrKmbOJDiNEqNKKzjDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiuB3Wvk72iR9li9Kvdx0Wd/AMHJDjh4+qRdzb4+xX0=;
 b=rSkGFmlM9ePXKxq5v/5VG4NOAO0EYDcXDGhGNhUFPgxeJx65+M3CGocihlI7kEktKbol+RTI/S2wEBrvFKfjs9utLP0x88SM4p6AcskQ6kOKcnFGk628AtCLChzL56LJBIvcSSUJVqDvqIf822Re3Q9TZElkzoX+sl5IUjwz+12xxzufBk0hR1j99nxAmwJfWrOMqbqttNbYsE4LRuSTvT3+qfdMON4q6MPHUOx+KfZ80Uf2v59EJlu1EMVmMCEAJ45L87V6zXbBdR8evsAGQ7gPtBZ+AYjgxlghj4R4KEDiUgSkPjqgK1v/7l1ed1lavhDF49zZ/9cG0u0pwDi0Hg==
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
 16:46:07 +0000
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
Subject: [PATCH RFC 09/17] iommu: Add iommu_fwspec_append_ids()
Date: Fri,  3 Nov 2023 13:44:54 -0300
Message-ID: <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:208:237::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 695a2d30-ede1-4325-89a1-08dbdc8c607e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lDIDEF93zbJ/ryiGJpRub9Rftc+xGcz2QeijtaE1CHLKxQiqmZqSQA0S9/fohSI86Mdbzmm+RGSPomvl3UJbO+eqMF1H/gwk0LIyib9lyu4dONea+wuCEbvW2U5B/yMes4rWZ5cbBvLJNlOEUYM22VRRlGDx0G5MeLwl+i9RqnNNyrGgPO1nbqqqdLT4wsYICyrefEgGOOy8YLv0ZWTGMUJXAKPj5qDLOXdGX2A9EU+wGAvyseuYhd70nyInKz8If6BDOhMdORhBCmb3wc0uKlqCSQJ/W9pzxLCaJMlsLuQRoNznSYtMAhgn5XTEphb7TYp+9ay+RCURoRDVU5e8Kj0DQpY+dRSN1Ll/K740eEP1z6ymsjDnn60epmBaznn8JOTNfgXYk+2Vb1Px10vFt2Vre1aSY6Ms467yogZ8DBCGO512r5qB0G1K73V1UVSwZb2Ga8ew3i28k9gMXvSJXUaBxMsIhfGtCF0RY4wsd61sK6w5ztaRU6QVNM0lP7J065Tc7ntqyT5NTBbeRafMh60wYSQHNm9aEQFUzhTjBZovoIXNO8lo6Gf/slGbH99+/CjRQ2m/hJpAsIsdqYyHZieiqMAaw8KBiDMSmbnM8OjDinnRhJZ482yDEMULObLK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6512007)(478600001)(6486002)(6666004)(2616005)(36756003)(86362001)(38100700002)(7406005)(41300700001)(2906002)(66476007)(7416002)(5660300002)(66946007)(83380400001)(26005)(316002)(66556008)(921008)(8676002)(110136005)(4326008)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNP0yMuj2FL1kAbhQpvWnOQPeNnJIi6+p49Ld5hcE5eKbh4GaVx9xT9IEGl3?=
 =?us-ascii?Q?l9qk0M9Y6mBaRy9mrsalzYDPin3lD7zxeyAtItIHqhMXV7bLZ3OpYPiMtj1e?=
 =?us-ascii?Q?Mn8iNJhZWbfFdQ0w7Ndosk5txbgMfP7C6bKv6bFqmIlLqq0KNc8ozDv2IYxU?=
 =?us-ascii?Q?y1G4IYDF/evOH23KpFpdXJ9pJXgQ4Ui41lkioS4fPaJsPLoexetL9eHkLWXb?=
 =?us-ascii?Q?y2+F50XFOQvdD2Z4q+1p4/kRidGecYk+0EuIkj+vv4LUKvAirDkmmW/sfeSK?=
 =?us-ascii?Q?o8LR7UycEkQhRAL5yk+EXPkgM1lgNjFixvgD8f0NkWZEPWKSApLL26QJRG8C?=
 =?us-ascii?Q?nvXfhaNNcC9xa0uu+Ib2x5wuiE5x5gaSdPe2+MZV48E50A162iUAf2z/YIll?=
 =?us-ascii?Q?6xb/a2kG59JSrEhxC0G3AmPGTjvCAjIMayX3afa9rE4kqOtY6OXBSDJw7M6c?=
 =?us-ascii?Q?RCSDAnD7P2/vKbDBC2Ft7BGQ0m/371Z3ratbm+SxeHLmR6XQhhn2Q/5laW4B?=
 =?us-ascii?Q?Ftnie/+q9dWZ9u4N0RcuBdJJM+hv4zHwC+/TEReMkwDNQKsxqwpcN6OZuNys?=
 =?us-ascii?Q?GT4m3+lGO25T7A/qYeemU0phwB6YS4qt7+jRgfU75weR6AVRUiThrgtMTgie?=
 =?us-ascii?Q?H3eY6ct7CRJoyIBANxKid1tAU5cDemTOKHhdFPV4Ermf1rGof4cG5wzOYY5J?=
 =?us-ascii?Q?yGOHs0PaqzIjHpvEhS2XdyT70Lpu4sa8J9MNfg3HzE81uHH0ecoqysWT/W/W?=
 =?us-ascii?Q?Mxkev8ODDQiP2zleiOX/6MBuIn6CT0NAwbrdPR+UfxuQxxiMhXgXCf82Za8H?=
 =?us-ascii?Q?4XYKJlB5vMamLxf1/F6zd7ycKQIQsQ7827bdM24VV7Vm+UKFM38UkB5wfYfT?=
 =?us-ascii?Q?NEWgNhNFzLrCw/fI8wlyVAZqQs+fG9Tsc8+MAzCzVyGyLgwvWPi17otmjlzC?=
 =?us-ascii?Q?05bb61KL5jwZxrtK/MS6iLQgXxn4MroWQh3vXUOk6Wko4fX2c0nTWD90RQ3A?=
 =?us-ascii?Q?Uu5oOfz+x06OJCuwv+fX3+pGz0xRhHDI/o7TVA/uHozbX1bgW4pSVfb+Pu5M?=
 =?us-ascii?Q?DqGN2CEcrJdbCGiibAtafdVwbdqZi0tRThd8LrHigdVKTk8aMKd1tXZJtd77?=
 =?us-ascii?Q?qUIyTeQr31NOA4D8seNrluP26T9BoMTUVJa57+fG1wWijtP2OWs9Gj/N2iv4?=
 =?us-ascii?Q?gVxZk5Ob0aVl2zCrJKb1pZtcA29W7bquB0lC26lrXwlbuIoIu2tU9bBm4Qxn?=
 =?us-ascii?Q?dpWK+9mckKiw4LYNnye5EnK5fOlrJCW+8zSWBHbFmlz5AQuxz7IxkwJDlu0d?=
 =?us-ascii?Q?MfpuL4UwyZ45THI+VtSTd2SRHsZLTNZtxrsRFGRNPg2Kx1/tF2r8DwEyl1E4?=
 =?us-ascii?Q?fmfHCppZk+TrB4VinFm5vYjBQoKqw47Ee4y2tn4SGFd7k7AhU87zYDJtHoEv?=
 =?us-ascii?Q?HS/nIwS3H/BswWMLKYz4KmwNiksCCxXQ3qxPvXWDw5xOM4BfF6uYJ/ZHDqT1?=
 =?us-ascii?Q?/bloR4C5QmWBVCSCA1gjRNEyAY8VPp9XOkN/tYGo8Whj4SLflsOTT5BFkPlP?=
 =?us-ascii?Q?m3qtqd30PvN65xmoDRzeS83d5zfDB0MAriXTXzqy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695a2d30-ede1-4325-89a1-08dbdc8c607e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:46:07.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTeruFpAqKz0lam4hnj9Zo9qaP0yQ8+9x92wuMCk/xlbY/FccUfHBq3lGe3a3Epq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

This is a version of iommu_fwspec_add_ids() that takes in the fwspec as an
argument instead of getting it through dev->iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 17 +++++++++++------
 include/linux/iommu.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ad2963d69a0538..15dbe2d9eb24c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3067,15 +3067,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
 
-
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i, new_num;
 
-	if (!fwspec)
-		return -EINVAL;
-
 	new_num = fwspec->num_ids + num_ids;
 	if (new_num <= 1) {
 		if (fwspec->ids != &fwspec->single_id)
@@ -3097,6 +3092,16 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	fwspec->num_ids = new_num;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iommu_fwspec_append_ids);
+
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return -EINVAL;
+	return iommu_fwspec_append_ids(fwspec, ids, num_ids);
+}
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
 /*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2644c61b572b8f..c5a5e2b5e2cc2a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -700,6 +700,7 @@ static inline void iommu_fwspec_free(struct device *dev)
 }
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
+int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
-- 
2.42.0


