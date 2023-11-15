Return-Path: <linux-hyperv+bounces-949-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC87EC48C
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C392B20BA2
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB032D7A5;
	Wed, 15 Nov 2023 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mx5OC8Cq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C224218;
	Wed, 15 Nov 2023 14:06:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A4E7;
	Wed, 15 Nov 2023 06:06:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l85rMPXxu0CEkW54IQ/kXLxJRCa2o+e1/uqxWaekjg/pvXKzDGeiPzTsUfGcqCeqeehN2bZpk5zDEMUpdv6YdyXtYq0AdJNP/R9AygSinBi74Cv39xu1mdmNA7gm3EdIXgYVVZCCWl3G0eNn4ZE4lm72mw8/v0d0JgjD7PPLcqpQeCqm4DsBKc/DhgRZrWTrZ0TgMmuuk4DQCBcnys64OtBYYbxl0eRIpqZRatMUnM7eww49hqhOZbzNbb9fdkPI826DDlvFOimVn52Z7wn7gpxxqcMj96CeQI6+BcJGZFXTQ+BJRSrlxY/SrCB2Qw994u/GXLLC3cpD8GN+Qd4P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MHRCRiPhNmFqggXLPVePsPQB+cwguJd6ZEu5Bq2G9M=;
 b=YkAxsb42/+f7PAyeZ43NGOkzf88zdEFU/ruSyoLTnFTQOn3CBjeBklK6CUPev+0AcbNYz6ld0w3TQI17t2p2VoiV0WjThaNyJRMUzTrhvXzCpKNd+Nk4gV+ZxZDG+LN9CW1lJkUN7PQtSFKgrnTQZX/sTLB9tqmtBlqNjQn+8nIj4mDF56krC6VnfzcW2jaRVdYMM9xmRS+pg3T8+v4Uh9140vTTOjokYTUYqNbPYzHEg1ZKNxIssO8nS8en9rmCV4dw3EL52HNU4E+hc79SCNTAJxd746xdUOQCyG4uivnCuA+LhHbA7t7HiihFsxkZJZ+QiEhhCLDqb4oXAQOJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MHRCRiPhNmFqggXLPVePsPQB+cwguJd6ZEu5Bq2G9M=;
 b=Mx5OC8CqH+e5iyQ3LRuCjMKUXvAK5rz/Gjawyit6NaHdnhog8Z+fUw7ZI37ICe61oLsCmtM2OQxKHrXrvvutGZoH+aCXfQ3GA0aj2hs5rJ/utplV8tKHylodG46Maupg9dmfha7su5FX8XNZeJ7uJxGwL1aKyctnjjLlLf0qihFH/zcrifYaMaf/U50fY7aV3zojU2U4jdVpHow3hYfj9ZRfdE9JKmCxpUnDD+ihj6vWFsarqimVzDKnDLQPizFwp1p4e3KpYjoc5kPhFH8Flbh/Z8EMss61PqyYZh1oyEQ3RLLFgjGUcYPbFoSFMijLpZddUteSrDhc++KpzLC4VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:16 +0000
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
Subject: [PATCH v2 08/17] iommu/of: Do not use dev->iommu within of_iommu_configure()
Date: Wed, 15 Nov 2023 10:05:59 -0400
Message-ID: <8-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b546f9f-75a5-40b1-de54-08dbe5e40559
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G6AMEZMitEvuaiglcTrwQIg/qcWtzDKp/3NTt0iKX4S/QPpuEm7UCf4O7xK/X9/MYvEW7hGdtcmwRvRWQ1qo4oA8Z6/GiWl81qByLjhIbdsO1TYEMCqYKFnYu2oo/j+csefd00ijBma24Kj8VpohyTCnEoqtF5+Nk5GvYe421x1we25+5ST94BW7fe3pzCByCmlPq3yt2kCKeDxDeT+ZRQSt6hbm9S3OZqODbEKHJzn+vgtk/ilozM4X20upylFnhwmOsurBjisQhpo0j+oLHF6GnBG8hrif5s7ijjzgldZd3d14vypzpsXmQfh60vCikvRWKU/OnUdsv3MDQhJiW/MWkTaAteM2P+qyq1MLMVndJsPt7JvSvcQxfIlPFKDqzggRl4ZjUtQV9ItaY0AXzymyVkXiXoz2i1lZbTpRX8M7dEj19jaSMR4CcreK6+LExwN5//hiRkTxSpMtkFC/Uj/xmLOKLdBOqC6JUULId8JJZnuaRZ3eLn7UadWEdEGm/p+e1hnd/4gBWIYbvl/poIlA6UwLcL7HWDgy3lgyx120KzvcADJTA7C/jTSKpJ/DlFUo95tPaFjEGfiLmsCK9IyTVRXHBun/pIEBxhLfFwCeljii8KQWoFlPf7MXEljY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66899024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u9H+duPL6lk0TD2IL8f0Z/ZYWd6OEapJOGkD9V8aULhQXjMGHrXIrCbKtoru?=
 =?us-ascii?Q?qObCPKS+bDMxTOCkY3zYdLv5/2lljnBg+CL4O2M8Jksslxs7bpJJjGhXmgwU?=
 =?us-ascii?Q?dQ6t+FU/l4Sj93BcLiVFLF8AYwzbJDQu2sDJ+y8ihV283GkvIc1bay/Tb6yS?=
 =?us-ascii?Q?05EycEqR1TASehYh18stm1OqK20S1u2QVtjOKuyX4vEWyixgwMqrp3R0Ws3W?=
 =?us-ascii?Q?b5YE7SFkWwxy2wu9Wt8GhPplmGRGcacS4NHJVl+T6FeROCqswaoS9hr6BNl1?=
 =?us-ascii?Q?TlIH9k5mOvNWAHxIVzc8slG846M/lSOASBfLjvpEFp1X7hv9XRpzsm/Wc+Oo?=
 =?us-ascii?Q?i02D6/0Zg8vObXD7f8Q8314HeNLiOhGQ9hm+dFTvSeDfdlDAnWkXaaiVbSFy?=
 =?us-ascii?Q?chrb9b0zlpr+e5w0teGRj4Y9IZKmtI9m+bPWdiATL1UuhSckGedO8W/goNtO?=
 =?us-ascii?Q?rbpMJHCmVB+3Y78PYTN4qm9uygW3S8xT8IIib63kteWUuy8PinPh0GJDqbPE?=
 =?us-ascii?Q?bsMHDxcLmc3wmc2cLOY+MAR17v7OC0gA6CW+uA6btX2IqT1KN6Btb0GYUMDt?=
 =?us-ascii?Q?XHzcuC4MjuVz5ffdc1fvjayZYriRnzByMCTI1EVHAsw8FuPtVpSwmTDaVoOD?=
 =?us-ascii?Q?FHIahws0q+xMbYsngETrhE7aObzNOEbkF46e/Qb3qM5UOOs6IZhOH9fFxhuH?=
 =?us-ascii?Q?FqK0luHFEWr0gTabFhybeLOjpnZhyNuAsL12b3WJGCcU7Sndth3gSUXgEV7p?=
 =?us-ascii?Q?OwvcQNadIruWiypN9DfOhNIbhrkx8puLFU2nxXiOPmG7Edw4FVWFk5c0hxs6?=
 =?us-ascii?Q?rZDjSOn9uYyOu8O7xz+R8DtuH+rl7RaEk320cyj9PQI1wBJ7pkTd+LiBnBGf?=
 =?us-ascii?Q?V78JNS/wpw2gN5IrbQaI1fZwmLlTEEsE8D465aXRostPQnQiTPnkk0S7+7ii?=
 =?us-ascii?Q?25THyHJZK0MYgV4gcRm/q7Pf2m1XVUeNS2GZVsF/52tkyYdEd8iCdLYMIVwI?=
 =?us-ascii?Q?IDfaZZo1BqCUUCOCX/fTmBE1q+52UV7CosA6j+SBidDs5PGsUjF3mGQijDXX?=
 =?us-ascii?Q?AWXoXkeGaghQDs3uus14nuwQt5NHn+7z2BHuL8M0hI8WaYRRAu2LBe528x1Q?=
 =?us-ascii?Q?zDXhSBGVnfBYVML7cJS22sovaVmP6RwiUuP72kCfxMkgRe69TBdViJaLXzee?=
 =?us-ascii?Q?NH2IYANS8fDV97fvlqDkkGkrzJbGc5+riH1iPl6ZtvR5upR7RI1+s1n2rSK4?=
 =?us-ascii?Q?EEg1bMQIhW/AWW5GcgEkgTbFvYBybJzCflt/3BDq+gNq7wto6l0VaBrlCZoS?=
 =?us-ascii?Q?KHyVSj0uKsau+7myQ+IiDioE4oFGHpsj5uY1RPLOnm6W6nEy/oAyGlHOgrOU?=
 =?us-ascii?Q?ClUevycjKL4CiL9xyiBtc8r3BRukf0G/iD6/9H8COynw+85c3QZVVa03HLSC?=
 =?us-ascii?Q?SgRWSU6wEv/ApgewUtRDJ6hWOjcuuW/x2a0YJoEHOLycSepfVlV5b6aaW/8n?=
 =?us-ascii?Q?dG0OBPx4Icrm/exyBIuRWsNcm2AkRZROArLY8qfXKkZsJV1dAgXHgb5zPxDd?=
 =?us-ascii?Q?7K91rF2M/kyOPK1k3x0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b546f9f-75a5-40b1-de54-08dbe5e40559
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:11.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBQdEHb0DsdPChlKoXRg7HRrAXEqsVp+aFmehwFP3AdGiVBCmcRmM38CeHfhb59C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

This call chain is using dev->iommu->fwspec to pass around the fwspec
between the three parts (of_iommu_configure(), of_iommu_xlate(),
iommu_probe_device()).

However there is no locking around the accesses to dev->iommu, so this is
all racy.

Allocate a clean, local, fwspec at the start of of_iommu_configure(), pass
it through all functions on the stack to fill it with data, and finally
pass it into iommu_probe_device_fwspec() which will load it into
dev->iommu under a lock.

Move the actual call to ops->of_xlate into the core code under
iommu_fwspec_of_xlate().

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c    | 29 ++++++++++++++
 drivers/iommu/of_iommu.c | 82 +++++++++++++++++-----------------------
 include/linux/iommu.h    |  3 ++
 3 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 667495faa461f7..108922829698e9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2973,6 +2973,35 @@ static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
 	return 0;
 }
 
+int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
+			  struct fwnode_handle *iommu_fwnode,
+			  struct of_phandle_args *iommu_spec)
+{
+	int ret;
+
+	ret = iommu_fwspec_assign_iommu(fwspec, dev, iommu_fwnode);
+	if (ret)
+		return ret;
+
+	if (!fwspec->ops->of_xlate)
+		return -ENODEV;
+
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
+	/*
+	 * ops->of_xlate() requires the fwspec to be passed through dev->iommu,
+	 * set it temporarily.
+	 */
+	if (dev->iommu->fwspec && dev->iommu->fwspec != fwspec)
+		iommu_fwspec_dealloc(dev->iommu->fwspec);
+	dev->iommu->fwspec = fwspec;
+	ret = fwspec->ops->of_xlate(dev, iommu_spec);
+	if (dev->iommu->fwspec == fwspec)
+		dev->iommu->fwspec = NULL;
+	return ret;
+}
+
 struct iommu_fwspec *iommu_fwspec_alloc(void)
 {
 	struct iommu_fwspec *fwspec;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a68a4d1dc0725c..e611cb7455417f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,40 +17,19 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-static int of_iommu_xlate(struct device *dev,
+static int of_iommu_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
-	const struct iommu_ops *ops;
-	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
-	int ret;
-
-	ops = iommu_ops_from_fwnode(fwnode);
-	if ((ops && !ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np))
+	if (!of_device_is_available(iommu_spec->np))
 		return -ENODEV;
 
-	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
-	if (ret)
-		return ret;
-	/*
-	 * The otherwise-empty fwspec handily serves to indicate the specific
-	 * IOMMU device we're waiting for, which will be useful if we ever get
-	 * a proper probe-ordering dependency mechanism in future.
-	 */
-	if (!ops)
-		return driver_deferred_probe_check_state(dev);
-
-	if (!try_module_get(ops->owner))
-		return -ENODEV;
-
-	ret = ops->of_xlate(dev, iommu_spec);
-	module_put(ops->owner);
-	return ret;
+	return iommu_fwspec_of_xlate(fwspec, dev, &iommu_spec->np->fwnode,
+				     iommu_spec);
 }
 
-static int of_iommu_configure_dev_id(struct device_node *master_np,
-				     struct device *dev,
-				     const u32 *id)
+static int of_iommu_configure_dev_id(struct iommu_fwspec *fwspec,
+				     struct device_node *master_np,
+				     struct device *dev, const u32 *id)
 {
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
@@ -61,12 +40,13 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 	if (err)
 		return err;
 
-	err = of_iommu_xlate(dev, &iommu_spec);
+	err = of_iommu_xlate(fwspec, dev, &iommu_spec);
 	of_node_put(iommu_spec.np);
 	return err;
 }
 
-static int of_iommu_configure_dev(struct device_node *master_np,
+static int of_iommu_configure_dev(struct iommu_fwspec *fwspec,
+				  struct device_node *master_np,
 				  struct device *dev)
 {
 	struct of_phandle_args iommu_spec;
@@ -75,7 +55,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 	while (!of_parse_phandle_with_args(master_np, "iommus",
 					   "#iommu-cells",
 					   idx, &iommu_spec)) {
-		err = of_iommu_xlate(dev, &iommu_spec);
+		err = of_iommu_xlate(fwspec, dev, &iommu_spec);
 		of_node_put(iommu_spec.np);
 		idx++;
 		if (err)
@@ -88,6 +68,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 struct of_pci_iommu_alias_info {
 	struct device *dev;
 	struct device_node *np;
+	struct iommu_fwspec *fwspec;
 };
 
 static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
@@ -95,14 +76,16 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_pci_iommu_alias_info *info = data;
 	u32 input_id = alias;
 
-	return of_iommu_configure_dev_id(info->np, info->dev, &input_id);
+	return of_iommu_configure_dev_id(info->fwspec, info->np, info->dev,
+					 &input_id);
 }
 
-static int of_iommu_configure_device(struct device_node *master_np,
+static int of_iommu_configure_device(struct iommu_fwspec *fwspec,
+				     struct device_node *master_np,
 				     struct device *dev, const u32 *id)
 {
-	return (id) ? of_iommu_configure_dev_id(master_np, dev, id) :
-		      of_iommu_configure_dev(master_np, dev);
+	return (id) ? of_iommu_configure_dev_id(fwspec, master_np, dev, id) :
+		      of_iommu_configure_dev(fwspec, master_np, dev);
 }
 
 /*
@@ -115,19 +98,15 @@ static int of_iommu_configure_device(struct device_node *master_np,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_fwspec *fwspec;
 	int err;
 
 	if (!master_np)
 		return -ENODEV;
 
-	if (fwspec) {
-		if (fwspec->ops)
-			return 0;
-
-		/* In the deferred case, start again from scratch */
-		iommu_fwspec_free(dev);
-	}
+	fwspec = iommu_fwspec_alloc();
+	if (IS_ERR(fwspec))
+		return PTR_ERR(fwspec);
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
@@ -138,27 +117,36 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		struct of_pci_iommu_alias_info info = {
 			.dev = dev,
 			.np = master_np,
+			.fwspec = fwspec,
 		};
 
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else {
-		err = of_iommu_configure_device(master_np, dev, id);
+		err = of_iommu_configure_device(fwspec, master_np, dev, id);
 	}
 
 	if (err == -ENODEV || err == -EPROBE_DEFER)
-		return err;
+		goto err_free;
 	if (err)
 		goto err_log;
 
-	err = iommu_probe_device(dev);
-	if (err)
+	err = iommu_probe_device_fwspec(dev, fwspec);
+	if (err) {
+		/*
+		 * Ownership for fwspec always passes into
+		 * iommu_probe_device_fwspec()
+		 */
+		fwspec = NULL;
 		goto err_log;
+	}
 	return 0;
 
 err_log:
 	dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
+err_free:
+	iommu_fwspec_dealloc(fwspec);
 	return err;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ca86cd3fe50a82..cea65461eed01c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -815,6 +815,9 @@ struct iommu_sva {
 
 struct iommu_fwspec *iommu_fwspec_alloc(void);
 void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
+int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
+			  struct fwnode_handle *iommu_fwnode,
+			  struct of_phandle_args *iommu_spec);
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
-- 
2.42.0


