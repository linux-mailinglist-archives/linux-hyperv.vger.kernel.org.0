Return-Path: <linux-hyperv+bounces-947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB17EC483
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3B21C20940
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED028DD8;
	Wed, 15 Nov 2023 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="spoip7No"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BB224D0;
	Wed, 15 Nov 2023 14:06:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47310F;
	Wed, 15 Nov 2023 06:06:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dec5KNPWLTZBlJo3slguzdy42p6L7HvSRtwSQzmW3lO7lHJptWUDB8ltY66CDWbUZMghSmDa5j9blIfs+s+FHCtS7nJjB1zwx+TCW9tKjEPxppNHKT/inJq9loIytnqLX/+GxW5EEGlZxPUhH+xOaxaYqLK4FGz8Uy/ZFu5rcbdetAZpEc8sZi2ULpB3ltBI81DO8SzzUElfC/cqtpFU9oLpTWaYGqJ8FGLo+659RhCCQXVpM84GIdc6LkijbeomhVrS+r3WmFwN7UNgV0hYVSdVguktbwDj7EJpy66cre/Nk1fs9J24lZEt9D/zpoEnhJJPvSUWhRIWDuT8rn2LqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hg4yf8nUNucd21oqK6S2A8uRXCBE9JcavexElx/9TQ=;
 b=h4CLhG5wckZwr/EMiKS7cz9RVki18t4hVYBTxVG8FagF1uRNENzZxbMaNa/WQMUvrZJ8H5POwqwK+9ZXY75pxyeFTmq2AL29MrCuiGVkn9/mNBAh9VlDt4ktZi94/YpJrQDJLV3PI7D2oz/suGrzj0vV7UJT66tASpTq0nPeRgFIMuFBaETY8+Fwm/19WBFOGZ7Lo8iRMTxJ20farur2l9R0w2M6WrAYJeTuOXVsSPltzcG2tEskg+LovoccfjJerFmHCuQtt/13i/CSEXzU8H9bTFl6WtP4vod/CrEMg4GeSbtL3glTxwEDNbAk8OteKrJ2yMk6tD5dDriFSrwe2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hg4yf8nUNucd21oqK6S2A8uRXCBE9JcavexElx/9TQ=;
 b=spoip7NosW2BPLdJT3HiJvrla6H2FikiN+Wyf/9dkf5207jsLluOn58XE/azzSagBE6+kagZKli4KTofGhV4dBHAxGHA+Qi9zPVWdDiFy+5IVPHeIq4pDOy22bjMqqlNko9QAsIbID0Lj4uFk56z/zjY7wLh9B4Y/651o+zStSe12u66SUPGxzWs+ZkIkXJH41RcVq0ew0agbIKJ938kRJZ0pzHvU5/nCBS8BUuTcVabU3s+T1NSt6JgX09QHqy9i7vksIz8/hpZOk7hUlNMq723maAjwW6AeJuB0DhRYmUDTxpkA2+PTqaWc2h80MAd1y2R5y7ymfK1Bvt8+HDLFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:14 +0000
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
Subject: [PATCH v2 05/17] iommu: Make iommu_fwspec->ids a distinct allocation
Date: Wed, 15 Nov 2023 10:05:56 -0400
Message-ID: <5-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: ee058122-8022-4a80-f556-08dbe5e4050f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W6CMbmioqyjiSGYWJfc9PqlfMlO3AXk7XEGRtmmOsYLNGx/n9tewVmkAIJRUWrz9BeXtqFLS8yeseODoaXIQf+m9dSbuNYc/3py5wnWNAQzJBY/1V6Oaf47qedLltDOd/N8zx9L3A5emCStmxGETmRniXX2mVl6/hyWuIB1vg55MlsspcxkOupuwcv1p9NA+8xvAZJzosdpKkrx7WOf26WmdlC3p7uz+P8IO5rs7d96xLTFC6/+wotedkkpeXHuiLxr5Dp8ZSr34neTgyevJZT8vicOfycJXNqiBoNFEkVxN3NStHTsNDYzvApbmgi0HyxqO4tmJW1DO4ss4w8AdJKBJ4vIEHf6/me7XMDsbbT2CuzwSO730ssxduwAwqJf1ZLnfTAKC3A0N3BgaCaWh231+AzPejBwLA5+SVklFJpBNVZa57gfioVLJDohENaUAljX81o5LMOYxzy6tksIlg07g00So+FG99wbHfYyHI68TC5lQCdOOSr+quNDJ31QsC1BVtAJ0616DQ3jCuwa5E88W2fNFdsOCcO+jU2aNeuBPfM6UO9aarlDdbdfSGSV3Np7YyRnjvvFueVD9uvi3ExGxofwt8L/JXLVUYJ5HC9chYn115E5ky9QOnu/E+L+c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6X2JMKqSHzDrJ78DtAE7TzMnYfdbnxODPlK7rnDDhlz+0Wu/cL+lQoeES1a6?=
 =?us-ascii?Q?AYcx1nHLBDz6KrswYmO+wnuEczYFG2H03sw0HPS5DXJp3cIl3b0Vauj73Tm7?=
 =?us-ascii?Q?MgF8SGSXPJDlsAPigxqHnOJbXClRKyW1DpiqHErtvJbGs1O/zsaCepIRZ9ni?=
 =?us-ascii?Q?lEhG5POAlB+rwjPxVlxqwdERH2qRevfFdL+syFJTkUGz04yY/i5VdZvCLs8p?=
 =?us-ascii?Q?57A8K41GyPmgcxEljwyv2Tn3ZHhSvnSQUk4kSeVeWfT5ZcPSvmFXgYCTxzqn?=
 =?us-ascii?Q?rVl8kzIuWweK5lbD+WyKxw1BPspDunHDC2n0AjZAsKdtDeOK+Qaq7PGTXPEG?=
 =?us-ascii?Q?FkzyRdk878SwOEl+d4I6SVdgAscLW12srej5wr8b3yRyX3AYyU1pTBfkRXNc?=
 =?us-ascii?Q?pUTk7daT6hPj64hZRYgJ/+PeziHxW9mhmNqOqo6YbWpG9bTMQwzvRvfSoZYr?=
 =?us-ascii?Q?HwgQVz/iGPtOZtQGZhFQblTxQfUgojWR5eCx+MnvvlC9YjyvbcumDw8T0zdc?=
 =?us-ascii?Q?vIrhDXnbYxmBU9Ayy3hg4L9FAs4AqNxBBgYEhgg+Q/LwuXoF/49b4g4AETsD?=
 =?us-ascii?Q?+q5KI8RoUtrCuBNk6LkGOfeqt4KRhOrkPwbKUEZNL0eAb2VMulaDqP9L3ouX?=
 =?us-ascii?Q?OL7aSLfQQogtuUKRZXx6v+Okx6EDDS0/tmOiDMEIJExiZh96dRVNwp412G8G?=
 =?us-ascii?Q?G2DNYaXWIzswu7xlWG8qZDAwRqEmqT4zLWMsqyFMWcloAD7a8OjdEskdxYW1?=
 =?us-ascii?Q?DnFJIpiLy918IbLkE+P08UZuuup78vd1rC2osProDkSazTuYCLpeMRHmXQfV?=
 =?us-ascii?Q?9YlqzXhTC7cc9SMPUGK4dhrQM9E3fy+GXbFnWXgMjDCNxVNmI99QVXFL7D4m?=
 =?us-ascii?Q?vYizebvY9cRz0TSBcpNv4Ejp6ZyeguteC9whaozGhleyaENcFMhIJKjwXixx?=
 =?us-ascii?Q?FkMmDZ8Ammfi1c92nAzMtKvxWJeBygT51YA+GZcH1Dj4hvIbRa4CX0bHSE99?=
 =?us-ascii?Q?xUVRzcg25cjz8Uy9WCdOptg/Azxd5c886IIF5KBmatw7S+R5m/ZNynXwEzyU?=
 =?us-ascii?Q?hmfAJR2igWRe1McS38ydeVtCY8Nvc8jcjV3RByKLIv8NC83a4LBYeLth+snU?=
 =?us-ascii?Q?aQAXfSE+Tdu0RNc5BkNe4eQ0PaPz7iXAnGh1p2SHysQgBx0BqbjVYakvP62+?=
 =?us-ascii?Q?jtQXaaT7FSLm9JAip70PRC0R/DxLzakPN800gVFKFAgZecm2IcWSujeNI5nB?=
 =?us-ascii?Q?nbUeOe+1PUPSuoV5G18DmABrQov/aGiaSGsbMgvKaGTcnkwEdvP+DB5dfQ8C?=
 =?us-ascii?Q?3HApGPz2D2UzhBKlHApuCm5iQHIlsJL/BabbNBvSJvSRersRqkXmCm36/GIr?=
 =?us-ascii?Q?WxOwU1wz48GcQNU1qcgUKzI+1w5BFXQ8U/N7g1vitGtUmDd5dOIVt3906VnY?=
 =?us-ascii?Q?PlfFJRTTUVVGe3IGxviFSAg0Lz5zH0+fKLED2kVvZAhxOLoKIP9Yi/ViL/mh?=
 =?us-ascii?Q?63Ec+p/4ZAr9amMJTusxWloefIKm+4jHHUWqTFvQsjnko7reIKYk6QC+BNta?=
 =?us-ascii?Q?55rJ5DpDEIOnnKVS2Ws=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee058122-8022-4a80-f556-08dbe5e4050f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0gGaxX4BIqwi2WRHAi7DsbX6MGO+ovYQ9g7Nskhb+7lX+2dJyzg8gWZRTuDedoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

The optimization of kreallocing the entire fwspec only works if the fwspec
pointer is always stored in the dev->iommu. Since we want to change this
remove the optimization and make the ids array a distinct allocation.

Allow a single id to be stored inside the iommu_fwspec as a common case
optimization.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++--------
 include/linux/iommu.h |  3 ++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f17a1113f3d6a3..18a82a20934d53 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2931,8 +2931,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
-	/* Preallocate for the overwhelmingly common case of 1 ID */
-	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
 	if (!fwspec)
 		return -ENOMEM;
 
@@ -2965,13 +2964,18 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
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
index ec289c1016f5f2..e98a4ca8f536b7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -798,7 +798,8 @@ struct iommu_fwspec {
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


