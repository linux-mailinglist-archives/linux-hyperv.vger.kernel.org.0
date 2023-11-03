Return-Path: <linux-hyperv+bounces-674-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B9F7E06E0
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837C81C20A48
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD381D52A;
	Fri,  3 Nov 2023 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQ10BXo3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4B1CAAD;
	Fri,  3 Nov 2023 16:45:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B779D44;
	Fri,  3 Nov 2023 09:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVjcU6Up5v8I/a5+1cfRO4v8w4VxFQgu1jxHQNbANJLeooeKve9Pk7Ao/7MzNzT4Yrrd4okj7zN7KtLOlh15EKN9mDJp3zlp6BLMfwM7AC3fgMGLSBFCnK2xgX8xZsgAHFaW5jOPZ9/YpsKfHd7Jtf0Sk4lSGA8Fw4uhTpwChYbBO5MFkFXU56/xCH6WYdLbIak8bfJtK8Ty13hE89ZTbX8p/t4amUENxKNmNXvO85dNeBOm+LUXGe7GtC9Rx0n3yEBrm922xwi5yHGiMs9MqdtgaIo8ivWTMiETr+GkBfebc/KzG3un6cpBa4xGfQHhH0CFgHwnc/xbnDtMrfHahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N3UjEeMLLLJeEcMRxl+2AVCyMLY2lxA+HXUiMeqqxY=;
 b=mhpYmcQ9ba0MderjArWXnfKTShp71iskCQWiyBI0ikj6aLdpgvbRrlAyG07ADOLkdby47mS3SR5ziAQtE7RlKgvIL/KdzAFC9JX9cCFLuo4b9iwVWYkdRW86ZcKBo2hUDt/ecxUe1zRQKqg+LBegQ+CPGmyCk2SXWiE+zKDz7tUSZB4f8TuX5zfYz97FstQw8pNHFtfsb7o8sAFLMBEO1Ya3KedM5H7Q6eoVJAo8cIM2Z28viqJxp1A/1qlGwI1QXBupl5VVsGoQNWaLEEkQ4YkYqKXK9rh3kO8+TO+0n9reGQ2LimURk22Zbz309KDRN4ikQCAG+WWwmTnFiTS2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N3UjEeMLLLJeEcMRxl+2AVCyMLY2lxA+HXUiMeqqxY=;
 b=nQ10BXo3foZ7VKHpk5Sd2L0jFiO6PuawDJImHvAosJlMPsMzKI4LitTjlbnebZ0pf23do2RZRbSMy6B5AaMk4RRppalAcLM0bqDPPCeQ1Ywm9UeZD9NEDN4LLkZ9RHj0+imwL/WCN0saTPErXTTIGHOW4Gj4RcNSsY+pnGZux5x0G5Hs7klcJCgChPLRAS16QUnuWSaeAot42/wPPQldk2AaTNTG1yC1vE+iQj4AFYiJDPkHCYM/SvEXkdcVeyhC7Pp63yg0IED1tJl+mEHtZWDYBGI9OnpsfGHwtx8PTqROxdBqJvpOOeJX+Uir7vnQFsbsgtbutXk9tm0fJbzcgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:09 +0000
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
Subject: [PATCH RFC 08/17] of: Do not use dev->iommu within of_iommu_configure()
Date: Fri,  3 Nov 2023 13:44:53 -0300
Message-ID: <8-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:208:178::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: b193e492-f904-4bf5-68f7-08dbdc8c3b4e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WGNJ4/KgtKqc3j37EhnHmSRXbWvOZ2e+HiNfIaDUseMKErwpQxb3d9DfCIVRg0XqKpBNgmqHTb8G8sMDTBdeXSHOq2BlV7I8O3FSffSMXg4hBCfidqgDPqYRF27ddtP3eEl6N1iSP9FSDN5J+wGUE3ehFKQK3zTD7iqIHASTkHn+dN8iYbgWMf2mhDs0K9oDLzT221WqGl+Vj/MhCtG5DSApM5skKddeDynBwP56KgaTyk3pQB4pTvpJitCF2x6du2mxvAL/RCdbpXTFmRscEY4rlAH5/GSmP+Ib3zF2Q5OdvXD4swFiVPeltoviS78y6R9TI336V9Dv0J0h8fmnnPkrpNTrqIt5CKT+KrfC1/AlhUfCU6Aszv0G8I9y2EgIA+KvioStQ0PKl8ZTPkg2iEGTr/PsA/99AzU4btdzzjnQhitxYCq03B9jsI6rMtsNm4OND94gc5mIlPhJ+GcqGoSm1C+d/2356i9yeP7Oi511jLV9edqKt3LobUQEYGAB1dKd8tJI9HC3xwwpKIpFMqEfR57tmmE+z1wivaMcuS053r2neTDOt2UBGtMfVSaOTiE0hQKKaZEkiVOWN+bbId+LtlxcleW423aw8Sq5FZ50M2rrTqWX2g/Etx8EFCYm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(66899024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQPlcrjCkzcE16zoVi0WM3h5UrmGg9Bfvr1qLp70zFSQj4L2/DlNyHUVtTsE?=
 =?us-ascii?Q?fJZgLJ48TCKo7AupYI3dvAIVg9uyAQ5q0U6FNZu72YzwVH0bXBerW3VjJOz6?=
 =?us-ascii?Q?QFMGtGHpUDN5BV9bv9v9FEWpXObHWLNAejvLDq2blLInuoJy+U0ubrDlxpMV?=
 =?us-ascii?Q?yLzMvxXNuAXmWKjR3tqI3+j38Uy3IqSkjnOvOUcmsX7q4B77eyksLIOc46k7?=
 =?us-ascii?Q?mEC4GCsKylJ69gD4Gnj6xMYOey0hiVa9tdMI/2cOJEO/xEsjBAW92nMyNAyi?=
 =?us-ascii?Q?8nCPRJJLdqc+mcrlldUTkLoUv4vASNpWdjuqvJOzGKd67kzlVSh+a9/xPaq1?=
 =?us-ascii?Q?+v2/0NHnSS5qXgdwFM4NURDYroU92gAYIruiSNHPV++ubw1M9+jAmjYaoAVP?=
 =?us-ascii?Q?Iv0WVQCk1GoS2r/XsQXZgecpEMlJIvF2ntsE8LhPI/mSRQZ97tgl2I0fEyNd?=
 =?us-ascii?Q?MCVtHYZcDjg+qmijSJFDjOXGn6ocNHZmqDah7jkUxNs4LHP7e2mgI4ud4csm?=
 =?us-ascii?Q?VJ2ZcCXu6DSqGnXdoB+UsLNKmVe7WT4ZLjO2FcSJZKprw76TMbgP++zzEa8E?=
 =?us-ascii?Q?b7eYlG9F+5hbKn5LFvyraFtKTsGS3w/0CVMMQT+KuhkQOuYckshLGJrAoZTD?=
 =?us-ascii?Q?MOokp3Taidr7VDzx7vUB5q2qUIn4wIrq5bsMC8ESh/mvVzCwGsSK/540UpL2?=
 =?us-ascii?Q?1zAPDFOrkWrFLYCyfh2opUKoegV4Z8d7yFQYOQDk8iw3QxZqkRJzkhub9Lyb?=
 =?us-ascii?Q?7mFCn/fOhv+3Tj3ga0rsNQ3sG1aSRMyMxYwJfaBM6WsGfV6I3jGlqgS3X+hW?=
 =?us-ascii?Q?E6IQbCLplslBettg1munkjc+95cHNXH5XE3kBMAoT3s+OfCJIJUgr8T7sbx4?=
 =?us-ascii?Q?sayYxJr0oOZLC3hf+UKBgR7/TJEK+2mAkqMKCSZgao2Qg7GHRb/1sb28kFKH?=
 =?us-ascii?Q?iTgc8uvM0/gRydKLV9D1mpIUZeuzgRW8V6P50EIEwqCkj/2Xzoszd24DLpEf?=
 =?us-ascii?Q?ZRhzkoDCVYcqsB3Fe1ZUcMnFdAdJ+2oIWzeYCxqQ1xQZl0siDYMRLMI6fZDn?=
 =?us-ascii?Q?r4zsBlAQUMi6KNCTFI1XIyrmThAsagypkVWK2DFhIv6BeZl0xcf5JegbZApA?=
 =?us-ascii?Q?+uQBFGNZ73lzec1PA6ilGqvk0eUXruNOBNa4Wakf9JVurPWHWl1BsLpzi/Ce?=
 =?us-ascii?Q?+KFE5zsty2j5shz5Z7DIaTXEoyl735Mwb6DQPd19PhWqzsobiY7AVnP4B/Cj?=
 =?us-ascii?Q?Cm3tpt5DoE9tUxjQjqd5JvKxLFQUY33dTHOF4NyjMOE4l4Nr+d/Hf2gJZNyj?=
 =?us-ascii?Q?Fb6Hs+pdQm6IMHZM6RJkubXC3inOMLlDZyQDkA9y8PVJIepKMBE8HswOGewK?=
 =?us-ascii?Q?kxtkUIDRinoxIquuDyyMky+GKE1vdRfExUql4CLHcHjMKrPVTlI4gpKubSxA?=
 =?us-ascii?Q?iyrhIQdBv7fBVSSZgzWr8Qg6xXfkDRjqajJY3irmTDoCLI0zO8Kby/IJExj4?=
 =?us-ascii?Q?bESHYmgBRUPU7BV3zuneJZBand1H/5hvhNDGKQG9YMUz0mW+ldaT7jVR9mnb?=
 =?us-ascii?Q?Edyp+4GxBFARqZmI9PFu1dpUcWXxO+ACETJwIxqG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b193e492-f904-4bf5-68f7-08dbdc8c3b4e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:05.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mF6DIjDPMwXyxDxk/3dMRCQ4ga1CGzLQFonP9dIq8kRfgTSBJqAUnayvoWsTHIc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c    | 29 ++++++++++++++
 drivers/iommu/of_iommu.c | 82 +++++++++++++++++-----------------------
 include/linux/iommu.h    |  3 ++
 3 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 36561c9fbf6859..ad2963d69a0538 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2990,6 +2990,35 @@ static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
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
index 4f77495a2543ea..b232a6909e0d45 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -19,40 +19,19 @@
 
 #define NO_IOMMU	-ENODEV
 
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
 		return NO_IOMMU;
 
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
@@ -63,12 +42,13 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
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
@@ -77,7 +57,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 	while (!of_parse_phandle_with_args(master_np, "iommus",
 					   "#iommu-cells",
 					   idx, &iommu_spec)) {
-		err = of_iommu_xlate(dev, &iommu_spec);
+		err = of_iommu_xlate(fwspec, dev, &iommu_spec);
 		of_node_put(iommu_spec.np);
 		idx++;
 		if (err)
@@ -90,6 +70,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 struct of_pci_iommu_alias_info {
 	struct device *dev;
 	struct device_node *np;
+	struct iommu_fwspec *fwspec;
 };
 
 static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
@@ -97,14 +78,16 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
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
@@ -117,19 +100,15 @@ static int of_iommu_configure_device(struct device_node *master_np,
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
@@ -140,27 +119,36 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
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
 	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+err_free:
+	iommu_fwspec_dealloc(fwspec);
 	return err;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 531382d692d71a..2644c61b572b8f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -685,6 +685,9 @@ struct iommu_sva {
 
 struct iommu_fwspec *iommu_fwspec_alloc(void);
 void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
+int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
+			  struct fwnode_handle *iommu_fwnode,
+			  struct of_phandle_args *iommu_spec);
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
-- 
2.42.0


