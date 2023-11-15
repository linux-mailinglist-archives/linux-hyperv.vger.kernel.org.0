Return-Path: <linux-hyperv+bounces-951-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D654B7EC491
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFEB28155A
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189F2E3F1;
	Wed, 15 Nov 2023 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNBiXw5Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D628DC3;
	Wed, 15 Nov 2023 14:06:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F773C5;
	Wed, 15 Nov 2023 06:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJp7IIyGP0dwfP2cgFJ7rN96UDEyJW42AGi7f4nSQS5Kzasoy9zzQ68ZRj6ryrv3tM3M6zpok1ZuO9ukU0E7OopiaoAmKUHrvkuNSIIfEdoIuPGIUmUcUEj8ez9N75EU2t2G8iQriLTk8WDpaRDQp1EM5y5DCg5FrD8EjY+3XkqXq5P2aRtv2E9XJMRvgcJWVcer0J0zCI3COVUBYbswdX/XgK1zH9mEfWoIyQk98RkIO7B3dNVsP6w8R6zrRWHsP6UUd2PuDf363pGfMsrXJGZY2aLgLenXmU7jjvayRnGTtG+iqHTd2OqcNp+zj1XLy6nIkVRFP0e14V0gfnXKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxtRgRD91AWOxJbKkhSS1BLtDanWicwYR99oBZY0WJY=;
 b=A13G0aCNRe1U5Ba06/Qdtxkb3XBbSglIVpeLNp54w0Yc9C/nfUANZ5qtsrmmugXW3EKaT7RTUWz1JYHvBuj0Zz//4OVKHDH+2es/1pfcMiyEZTEqTXupkN+OIlW5v+gOK3/96JP3gNSUqSHdBycb1b8sQ0BQe5JzLbVzmCiYY+7fuJ3FbB5BlTQhYRjJ93BakbVLuauXASQ2RJojmjhqmImsqmbeLr1rODknfB068tk9Okb6/v2qIuhp5d9DAAu4UaBNIyybODB4V6p2MWIF9T9o4CAzCMe6K76t1LgLh3QTToR6lGOAaf/ubIPUrhzftoKLT2M9ayis/9flHNoqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxtRgRD91AWOxJbKkhSS1BLtDanWicwYR99oBZY0WJY=;
 b=tNBiXw5QkaRBk3fvFJGDdTRs1M9aBvS4LRA1+AqHG7FWCKikNiqIWfqw/t0x0ccWYPLxeSNK5KNMZt2kLiRzKJurKQpHoS+h5rSrzNJqaeRxSyqrx6bOruS57CjVcwfTQZmn85tQfq0d6aMa1HOgu6vM1Br2zLkUIP4kPirtpeSXAGcuTkJXlfmbjCqttjdiVVPN8J1ZIF/mJj+3V0vzGVsYh3Tc8QeDwXP61OSpUIzBfK+vp4DD8DA7ia2vR+sDSmuK7PxcxkkuTSLDEWOGdNjU195DWWN8nLAgXFU5RNFsQB7AVdWDObs+ncSNfRHNm47wxkjTWe2Hw+RCFliaaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:18 +0000
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
Subject: [PATCH v2 11/17] iommu: Hold iommu_probe_device_lock while calling ops->of_xlate
Date: Wed, 15 Nov 2023 10:06:02 -0400
Message-ID: <11-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:208:120::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 30034502-39d2-49f7-9f19-08dbe5e405bb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qKoJ00Kq5CZ2mVHAIGxnEG5vMgGT8yPlYAykGDKukVtHl2dra88qrT24dDn3QSCNHs+vTVQgBQnqqjgcURQzVyWH6Q/h8FyjYCFSUQGIr3AVO8YPJlIy5CaLbCcTj9faTr94rZsq1NTyUx7R9ttZsXARlsLEQphPM82VoQvmD7hlgmzaBXIv5BVVsSeSuJkoDOKhAAVfqEEroBKS5n9pn5it9UrXNNVtYVnjGHWc9nWOYoTOClm1X+SN/FVsYSJ/FRRbW8nmVkDxrXQpQ1q+0h8nJbTF1o/NDcMbX9In2ntch/0Ow4No3R6LVBC4BB8VnReXOi+wFSRVCBX48zQU9ug1SHp1Osls26vrKwvFdaPQRTTF6inoMFKo3FhROBljyjDf8EyHElunNojjM7+g0mpppyk9y9XwdIc6s4k2Yl0pT6PF+RDgBTb1W6xbvt2qocTu9FZqejOgomGgP2WYArJMGCeqYZ937zf3a6cI9T/hL7P4xlffYr6piuX/07bej8+XcEFa2G8hOpzB4LRtLl9nLuTi/7yTaRxx+d2ncbR1Mu4/TirP6ovtptHx5HZ1pkdAwa3jISCNB0IgKDnwnFPQE2KsLYJgLgc8X3uHF975GFPUD+u5vIbqLsSSy4xHhO+1FzB5POkavCAOWbafNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(966005)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rySRiIxMGJm/2YFKWF8mJCVwoQpBp6kRUByba4rKQmAyTgtcfi3ZPg1b0Vlf?=
 =?us-ascii?Q?m7ftJuRJHBe4dNkgF4pQTEr48rSsQefCde21wPPLdaCngzy7/6vF/CF5Ll2c?=
 =?us-ascii?Q?wzA9vAlKFhiMUS7Q1e1fjDewNV0vFYDzB1mv9nwsQ02ve/uYNl/tRQpQbK0D?=
 =?us-ascii?Q?QRBsBgYZNb8hw8oUX+fCy++C0faaEmfYeavEvYLl+c/Mus0HauriQi4SHWPF?=
 =?us-ascii?Q?9J/kwBInHqtWRl3E2qG3yhNsm5mQeME1FtA7Xik433DG0vm04l44wpQr/Ldu?=
 =?us-ascii?Q?+8pay/9t12xamGmU4LsUpgdL6v7ZZNYEOrN4J6z6IG1/OzHaS32st36H6zbq?=
 =?us-ascii?Q?uUytUkUgWK8RK5JsV86yKKZcke5A6PUsIGTJ21aiUcQtI6d0O/9YW0HsgyJN?=
 =?us-ascii?Q?tWoQUbwK5nAeZ0CWaMrGi4MBvSAC5T4XTyCtk8x00Jo5ByQsUYi2hyYglEEU?=
 =?us-ascii?Q?ax9ozGLPvHNSjpge3WK679awSw8llAXO+RcMDiYTVXKrTc5n1JN19sEGCkLz?=
 =?us-ascii?Q?TOP6iX2igrV6EHvUb3r7pKSqor9QYNcJmDV27Hb5k8OYz9DiYDGqK77B5ygi?=
 =?us-ascii?Q?U3l4TYgbPIeKSOs8hbqDFaZDTmp24JzQLfkl+sm/oOVzt6LPf8Y3Vl5onNga?=
 =?us-ascii?Q?yAomp216tU+zzXJQH8mMdKlLSg/kn3c9g++DDQSPGUAeFtFsu57jrG6V2Vqz?=
 =?us-ascii?Q?dP+vCYkKu0So7ZJdJz5GEUfcCIvzMvx/xGM3fECI69rO3FZAN6CuXjN8maV6?=
 =?us-ascii?Q?/pAb5OLOYTDddbjqyale3LIWB6tRuu4ePARiOb7wjc7dPpqxJQagxsfOFLcw?=
 =?us-ascii?Q?LlTyQPhxAYT9tp5uqiVlJE6Kkj/5u14bk3DWuSZrF60AnO4QIu0bvw5ngCvU?=
 =?us-ascii?Q?W7paOQ4E/zFdFf3HRSmFYBbnf8MxIhICdB5XcmXwwZVm0Br7/EnCuyhAmuvL?=
 =?us-ascii?Q?SU8yFF2KbdJUC5N2NJf3Wa61OAQcsXQRvA+rgweX9U9LZ1E+w0KymLA0H5NA?=
 =?us-ascii?Q?YIglm7NxcgzYM/S5FL9mWdQVlL13GQEPsiX4sMbkkk8QwANYAncQFprD89Vk?=
 =?us-ascii?Q?sPyX4RfT3y+tbwnxVNhp/G6m3UBjqyJcySlnNMsm1oxRIpwB7lVQNH2DoDcU?=
 =?us-ascii?Q?tCihP9VtaKVbMdeLFtfDnBHHizKz5x3D5kjBpaZB1pB7BWNvvdro7EsWh1PR?=
 =?us-ascii?Q?Ve2OctvYL1jmGw4m6ID+QbvLpJUU8JmbxZOhFPlRhgGper89BSUFH4HAbpw/?=
 =?us-ascii?Q?SyU0xlY7M/A6wGvn7hr+ib6rDvfxuaEvuEdJ2OwMFnc5eAck23guC6ZMVfiZ?=
 =?us-ascii?Q?LCmdSEYcIk8XMUc7eEVtMRMU7I4ZMFOCfakrFjg63DkL7dfO3wuC9gzK5v7f?=
 =?us-ascii?Q?lVi0euoC5iW1LZQkoMK/7uiTpmvcjHWgQwH4IdTRR+MBZGBMQgYNrhYXKDMn?=
 =?us-ascii?Q?sM8A17RAZdl2c79XYrTFuYge3scdFvZGKsg/ZsAnt6we/ajiQVxf62mit40U?=
 =?us-ascii?Q?a4MXDURZTDhzybO0zewFWQaId2y+FVu3ciGbeQ60xR0uPCqv8qKBZvi+os3M?=
 =?us-ascii?Q?IOsmywqOh0Zg23dfzfo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30034502-39d2-49f7-9f19-08dbe5e405bb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:11.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxv/yogWBUqY8nO/7z3Pm/iRPB3M9BTC1RZPsj/xm/FUhbu5Zm2MrcmEYwCNu3zf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

This resolves the race around touching dev->iommu while generating the OF
fwspec on the of_iommu_configure() flow:

     CPU0                                     CPU1
of_iommu_configure()                iommu_device_register()
 ..                                   bus_iommu_probe()
  iommu_fwspec_of_xlate()              __iommu_probe_device()
                                        iommu_init_device()
   dev_iommu_get()
                                          .. ops->probe fails, no fwspec ..
                                          dev_iommu_free()
   dev->iommu->fwspec    *crash*

CPU1 is holding the iommu_probe_device_lock for iommu_init_device(),
holding it around the of_xlate() and its related manipulation of
dev->iommu will close it.

The approach also closes a similar race for what should be a successful
probe where the above basic construction results in ops->probe observing a
partially initialized fwspec.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20231017163337.GE282036@ziepe.ca/T/#mee0d7bdc375541934a571ae69f43b9660f8e7312
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7bda1c0959d34..5af98cad06f9ef 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -41,6 +41,7 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static DEFINE_IDA(iommu_global_pasid_ida);
+static DEFINE_MUTEX(iommu_probe_device_lock);
 
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
@@ -498,7 +499,6 @@ static int __iommu_probe_device(struct device *dev,
 	struct iommu_fwspec *fwspec = caller_fwspec;
 	const struct iommu_ops *ops;
 	struct iommu_group *group;
-	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
@@ -2985,8 +2985,11 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 	if (!fwspec->ops->of_xlate)
 		return -ENODEV;
 
-	if (!dev_iommu_get(dev))
+	mutex_lock(&iommu_probe_device_lock);
+	if (!dev_iommu_get(dev)) {
+		mutex_unlock(&iommu_probe_device_lock);
 		return -ENOMEM;
+	}
 
 	/*
 	 * ops->of_xlate() requires the fwspec to be passed through dev->iommu,
@@ -2998,6 +3001,7 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 	ret = fwspec->ops->of_xlate(dev, iommu_spec);
 	if (dev->iommu->fwspec == fwspec)
 		dev->iommu->fwspec = NULL;
+	mutex_unlock(&iommu_probe_device_lock);
 	return ret;
 }
 
@@ -3027,6 +3031,8 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int ret;
 
+	lockdep_assert_held(&iommu_probe_device_lock);
+
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
@@ -3080,6 +3086,8 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
+	lockdep_assert_held(&iommu_probe_device_lock);
+
 	if (!fwspec)
 		return -EINVAL;
 	return iommu_fwspec_append_ids(fwspec, ids, num_ids);
-- 
2.42.0


