Return-Path: <linux-hyperv+bounces-678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D77E06EA
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8F3B214F2
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0E1F95D;
	Fri,  3 Nov 2023 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brZ3lz4i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487C1CABB;
	Fri,  3 Nov 2023 16:45:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E151D4E;
	Fri,  3 Nov 2023 09:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRuBzS26uI2Ao5MX9ulmUBxHqayGRNXpBRhlrEAXE00WVvawHJeiq5D1G4kwb/Tp7B5vcbtS7nfCvV7LH1UzrEgSwPrWn3jt3voO6xiYsSe82wQ90lsoe7XOmBmLchTWM/FXr5PbQ1fQVu8diX3IlYLhobbXBqjQFEu6+d0NL7z2MARCuejYgv3YwzTvMzsseXG3alPLQcQxCtF4wGr25HTT3TghxakqdIzsBP9jhsHHgN5pJ3iwYf+avyuD2jMgqJGNGtWhX84tzCavN0x8vSSehCoibakJInLTDj/NuTLO0otWEJ5lVnPZ3mLGkyRskD7UrZFvy8oqGbhztWiCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soH1zWNK7AVR4Z/sQmplqCYXMA35gKd2FYFGGTX9220=;
 b=RkTCLnCque40WFOeX2n6u/7y45dOHG0pR+IkVD3eGsOXUivl6f5wTxn26Uu23dbtYPyFHin0XED1AYqQVcS1fGwcttlfFvGixFovudHq2vCf1xH286Jw7MtuPJ1QkNItsrLngoW4Sk8MrVDE0CYrhcSP0zBwKNME+GHnvCr6AuGyAvI4LUK9GCOD8ZvrMWScjT0BR8ZmrKVNCAdnP774cvsGch4Mcc+T0Ya5LVyDMsmLdv4bvqkCRwL4Ky9zirba34jLc715QA7UfDzIVjCIEUo3fCwJQSdXFybhi7AHr1w+vocUyqmoM1ICACww9u+U/EUw2WfvUdFSFSpaMAQl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soH1zWNK7AVR4Z/sQmplqCYXMA35gKd2FYFGGTX9220=;
 b=brZ3lz4iEEHAqgnwC4/zE1B96CqntidirXbzQpfN8fCJE753DAovErkMR3L+WbhHrXAYjdKKysTgXkQu1QOreOgzBFEgC+Sl95Gg34GSX62oO3uDA6v2jMHJxsE0D0FGEPJB3Cu3/m2l+F4TYz8VpFPw5wrCylmij9JIzAdhrX/OPXiYh2KG3kUivmuDVGOPLDokrIWZ4uEL9nG2jJnfmdPwLnvFdD4ETO6DzV74bZNi4cxYiwu1KsVL3auV8Vqz2n80zNsOMHcM33lYl2VunMVYRP4zv4w29G5ddo5dA9f26ilX9UEZ8gza5NwEMSDFuuXDEr+imGX7URhWCci34Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:06 +0000
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
Subject: [PATCH RFC 11/17] iommu: Hold iommu_probe_device_lock while calling ops->of_xlate
Date: Fri,  3 Nov 2023 13:44:56 -0300
Message-ID: <11-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0329.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f526dc-2203-4857-fab0-08dbdc8c3a9d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1lkEyVdIOF09RXaRItfkfhoiYOKxD+zVhtBxGgBgyQxH0uO76FoQ8nYMSpbqz20DOYdcoW6Wpz4i4f/vHjxs7mAtHANNHj6TOln5HWgs+UgtkrP5/mvCjsKrnw2O7+mPS6ZXXAGMg1SROBhLcel4yRVQdoGs8sksdOeDdiTJW8X0VD9oNjcCUyvapGN43ZvoeI/IULZgcoZP9ZhkGzXtACskD7c8Z0zvBFxsVVbcB4sT2QPOJ8qkl2FxEPKYIMLQlsWua/74ln6P5lct/2tz1qIoptLISQA5QV3s/xLzH1ogJi9NaWCLhksQfe07qxtXIDNHODYv62wWXYuGWh0DZS5jWCDkSo4RfPMBNSahT1cf2KJyGO1PP48G1/BnvghKpwo15sp7BG85Yq6YijUo4cEVT0z6Ge1ITILeLa3wkFYXwYU9lcWOvr/fyBDOtxIgwgd2plEW58aUGAPxaqZTsqciUCQEQpYDxBQQOV7oTde7NvEUWAEEXUPB0lhAfkVKtHdFBxHW9JJ9fPmPffdpITMICw6UYUePOrAD1+E69Iv6fWHaJJjPE/QEcPbbky15B3AmCAAQWyMjSh6A4/KYrFAqq4FRr/DrawtxNl0kObwyb9y2x2pXEDOcpq9RhKzEzxcEELrw68P64P1XZB6mpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(966005)(66946007)(8936002)(66556008)(8676002)(316002)(4326008)(2906002)(7416002)(7406005)(110136005)(66476007)(5660300002)(6666004)(478600001)(6512007)(2616005)(41300700001)(26005)(6506007)(83380400001)(921008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Af7Fn/9A9JuH8b8I73tBRAwIj3QwG2z6N2iMylRqCfQVGaSnW5TYOdr2CiWd?=
 =?us-ascii?Q?rMZ0rDuq0L2P0zMsP1Hl6naUCFE4QZb3O69CY3J1oSES6500HZvNSe3jZspP?=
 =?us-ascii?Q?5+t1gaCN2Arakl8H26m8XaIDNTLHgDzyHTWFJOURoHbo+zwLzJNUoYsA9OWf?=
 =?us-ascii?Q?JknnwVe91btkCx1KnbaJ7vs23PUe/x0U2c+YM4wbsh1e8f7Cu95pd/IjEjLT?=
 =?us-ascii?Q?9jCehQa4bxd7k91rchhqlE3rlwZEiGsl0irr7WSk4S6yERRvcJzWqvxZVz5P?=
 =?us-ascii?Q?WLqQ29JmjUJBa8JvGv6hvWxorqpV+LAtnWMCYrsd4zN3vu219zXM2SvVq5n5?=
 =?us-ascii?Q?taSmXREt72SlaLCT+vahvuY0tl0o80FPO1PnpEzofoGa0UaRobb10cTJY8Uv?=
 =?us-ascii?Q?vfI/X19wctRTWGN2xDdqeXzVD03/R+X+Qg9dXJqH/+41TRDmEZxP5EylhH4w?=
 =?us-ascii?Q?hjO1UuZKHfWWlgJlsab06fEj+lt2hmVdba8jVawVJFzKc6IaxEBL5/c1Cxmr?=
 =?us-ascii?Q?hVqQ3SOCjH1Sdv9E36B/Kuc8hWu2p2QaidyxvvdhELlg/dOADH/b8WNkctZJ?=
 =?us-ascii?Q?Jt3IME6ZoepGyNtpB345WClHTBWux+j0aQ1fUts3X2FwB3D7DEdhy4Eyy8Bm?=
 =?us-ascii?Q?7QjecFH/wrbxRcBO6TMVjP+uZnZSGbR7cZvcsxNWUKn3TWm4IZ3Gn2xKlNLI?=
 =?us-ascii?Q?YAjsg65dbW4KxXF00/pBNO0fv95QZrbXRE3vbUN6v0uLQwl9wHV6LovJA3Xz?=
 =?us-ascii?Q?IKMfTucBpiWsW54wVoQjkxRHPjsdZwSOzk1yxCYThQZDsj8SR7eLxRWcnygf?=
 =?us-ascii?Q?tyU5MyVf+nQOQpWooENi2VhaE49xWA5gGSjqqJWnacPXq9CEJXHjRlAQzXIV?=
 =?us-ascii?Q?5I8vWx30+/XeE/6dl23wiiOT/qUBPYBzF3vTrVIRnnT+sD8IyupauiKrxTBY?=
 =?us-ascii?Q?ANOaPykWLccncqyRfGGvN1jZL5dbzzhRESG1/Wnwcqv7lAciWPseU0j4OpVt?=
 =?us-ascii?Q?VicpH0hz3GEBXIWBk26rdRFLepm7UWEI3PMPmhfo19rAnFKxx7hkU0RnPIRn?=
 =?us-ascii?Q?sqe55iAfvNekox+D/ypFUQvCRFIlW4ghnLoWC85ZK/yeNV5yRPxcs28sQQY3?=
 =?us-ascii?Q?m18jFkssMuNaqcnMNDEVaOS6/r3XWmliO+MCk87y63zJ+NuRAF0JKZoRSLlB?=
 =?us-ascii?Q?ycjho++b0mKkwj3+zChDWtwJQr6Y/00EAQIdGrOCvfmBtk6e9esYLcenwId5?=
 =?us-ascii?Q?qC3hlWL2jf90bVHcxLp3Xg3eOjrxrydyFfQlMBDhrUhTJTr3v7V5f6syiKAA?=
 =?us-ascii?Q?mKnRrQ1+d8LI/5RRsi3IOJ4SzsunEtJSQoMPbLuDEKCcGVId6SdQh8G95hsS?=
 =?us-ascii?Q?l3SfSrYAxzU04AXt5tIGN1fPqW4456xPuAnVhC1vWRqz4zUlvpIlnKCXxhJ4?=
 =?us-ascii?Q?t2ZgEbqbMm48Nf5EiGO76FLgBym54m3VCgs3sYxmmjTXcWkqOmxJx7MJkj3y?=
 =?us-ascii?Q?k5KvlxCrEkCk0lsr7Rgn2++7+C2WsB/xtX3yPnjUmRm7qUAV8roKphK63PBX?=
 =?us-ascii?Q?r7nIWWANva+avbNcnIOwNZM0K8+DhPX7HVMNinDT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f526dc-2203-4857-fab0-08dbdc8c3a9d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:04.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbEszVzs+hprN+TANu3acvXks5HY+al0jaMNmCvSC+H1c+0tTPk2swn2RiUjqsbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

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

Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20231017163337.GE282036@ziepe.ca/T/#mee0d7bdc375541934a571ae69f43b9660f8e7312
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9cfba9d12d1400..62c82a28cd5db3 100644
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
 
@@ -3002,8 +3002,11 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
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
@@ -3015,6 +3018,7 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 	ret = fwspec->ops->of_xlate(dev, iommu_spec);
 	if (dev->iommu->fwspec == fwspec)
 		dev->iommu->fwspec = NULL;
+	mutex_unlock(&iommu_probe_device_lock);
 	return ret;
 }
 
@@ -3044,6 +3048,8 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int ret;
 
+	lockdep_assert_held(&iommu_probe_device_lock);
+
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
@@ -3097,6 +3103,8 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
+	lockdep_assert_held(&iommu_probe_device_lock);
+
 	if (!fwspec)
 		return -EINVAL;
 	return iommu_fwspec_append_ids(fwspec, ids, num_ids);
-- 
2.42.0


