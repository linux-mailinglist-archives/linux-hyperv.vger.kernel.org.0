Return-Path: <linux-hyperv+bounces-673-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82507E06DE
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6659B281F52
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3191B1DA39;
	Fri,  3 Nov 2023 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r9ozleM2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F131CABB;
	Fri,  3 Nov 2023 16:45:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E96FD4C;
	Fri,  3 Nov 2023 09:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE91x4+Am+FPOgJPTPlX/YgVF5yvm17P9aFIg7jmhAxVpjV2YJbFmA9/ti4CBT2GwKylNTL8OmLxFQr7z+w5RsxPHUmY7sB5kQkYdcV4HTQsv+W4M2oqLLxJoCdMUHoSFr7EGPbScIVLve3ly2IIUhOF7Ecv/0TTsatDhB/6bHxGQoJReYDIoN+4Bppr25p8QSwwbOarodnJixqr37y+XBlbeHnzbVBMrim0vMr6Z0kqHEsb7rrOwCF1kzg8bTI4xDihznHzH2MXQc9qQr4DlwRNx04m5Z5JaD5m01/PVVDPXi1QzCCrYRsK2jHKlNFqvukuVPsGaVvMd0rCLkiTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PPs0isl+3c2oxqrW7MT5Ff1zFSIMTNVaxMmUPjPXsc=;
 b=cXygRVN4+QlRVPGBuNwgx1l77U9arLr0cz5T17KosOPYp9i5ogORob2jrUdGHXbkoIU7AI9y4azOIY+XI374syiWAebICD0K2lVeV1yQd4+wZWSPQdcDMKEWCw5kO/ywu4R4UF3BY7i+LJZEgWWjaTu1MIESLobGTLI/Vo89ajRjqhrJlYsRXzwJ9VkCsyq5uIV7G8Wa104RaQ56PSkLERLrgqNy+bpz9V7MMkfHI6bYcwRDrlsZW9+iaJl1SkURBK2hSiV4qXc4mOhhuiJ2oNwwNzanmiGUYBq3nfxl+ywZg0WbXCo+vN0uczyZilI39OdTIVr8lif1t+BKD/cjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PPs0isl+3c2oxqrW7MT5Ff1zFSIMTNVaxMmUPjPXsc=;
 b=r9ozleM2+soDLIOUHJ4VZtKEei+18qw1cnd1jP48P4Xf3cyChHTROFexg/DccaPi/LzTjijwyITf7mVjnelT+vYXFpL0/IILmKLeKr5xnFTi9HxJ9H55W8lgQw2G11yfQFgr8GryROJknh/PM7+MjgMpXMs+bXtpFYb8LY2f62dbyVKAa+1P89IA9jpomdIJK4hursykynwHu7OfGe0liCEpmORGpJCpaUCnuMEhw39lNEHaY+r56+wlzc5pfX3ucTt97O4hIZ0TD6OlJtdVVDlqAXHHW2UfDfxs1AXlFYeh/lUHD2cp9W74VPwx2GNYvYcZQSNqwrsYpRaeuvl77A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:10 +0000
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
Subject: [PATCH RFC 13/17] iommu: Remove dev_iommu_fwspec_set()
Date: Fri,  3 Nov 2023 13:44:58 -0300
Message-ID: <13-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0307.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 40df1e92-dea4-46f8-2dea-08dbdc8c3b53
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F7VCOiRIvbj1z+rEa07HUjg0l0wtX6ZG2HrI5bsNuWZvILG7yYFuDJ2KqdSmEUpnNh2RwMWATbgpvP5FAVyDb16zhMXDdorxSRNzfMCUVzXTsJeGoXcMloBRK0uCwpZk9a0Ht+/MyT6jxvWcNP+O+v+ilgMlHdg34MmSnZSEooX4wdQivrR1tBll/HFP6MOh1kVHaKQYSLTZpL5axEQBHaqp7B/Ga6n9lbzD/TMsty1GKaeP2HsUyNkEfCYE9NmXLk2G32Fv6h3toCXiy62IS8uO9Ww5Dl/CVRz8blCgUP89CHX80BdmaVP7sqaadWTSCaMSsl0jtPCkDPgw84vu9SZUnXc+f3cjX+OHG7B+MfrxcgCK6JiQOx/zizrWKvPzfrJk/XHUI/ViiXu941gyon4nyZc3nLVn1obliWLlG5UOf53VKUVG+JEvVvja5mBm8w1p24kmvcjFkyIp4ARRRL4u+unvAuFXRrtzR70+vaGnYpCl62CPgCYDXGZA9YMj9mI73jPY1ZG1TKp8utBUHRXi4EQOZYUhaa4y6sBZmWehXz2vmQR7ccr+Mp8Zng3JCqIUMpo1+ZxKaXNT8NApo48LUPm4QLSPoKUAvX/dk4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjXApk0YhMlio2FBA/thCG9JFkSZvVh8sruK5y2sDYNzw81579bTtzOwjdMQ?=
 =?us-ascii?Q?uXzfvyLzZjnguzktba52wWoTiWRDrHFjOFHPVMCRYg/8xiT5YazQwDvqgISG?=
 =?us-ascii?Q?9eZwHXg7Qx+nBJ86WCTKEyQlIOMWhRcegGGiXRSBsqqGqE9WUU85Ppycr+nb?=
 =?us-ascii?Q?3B1wNCEaFaDkIyOLkwwQsCYAK1U0VEUdM0YhaZs8SCNdvFgglyeyob0Gg/6q?=
 =?us-ascii?Q?gPO3er3lzd0GmP16gzdDPdK7++DkD51oBaAs06E6Pn+J1iMI3a5u0kTCEURc?=
 =?us-ascii?Q?8LypgwjfV9R6JLkcT7KY4xS9/6DBdXgcFFH1UrfsQIekEo5jnhDKdf8v/1+w?=
 =?us-ascii?Q?oicQiWYYz9wTs/MWznCxjLM7+0IYWlKBmSKz3mMFDa/W3InLlOoiXD3rG/yy?=
 =?us-ascii?Q?ZnljPB/Fj16VCWIFJCiS3yWDZ1dnaLZdmj1lzY/hEHJjYIEN9EQkh3XJDex6?=
 =?us-ascii?Q?u3+uPQrZjsDsatt0tOS6DdeIj/wnSI1vT8gjuy06NF9FTBBGYsw9z59Pz/Ii?=
 =?us-ascii?Q?E35v0I6Wm06WDszGPu1qZcqSn6GC0fOX3BObqnBoYG+5feHWhon146fSTcG9?=
 =?us-ascii?Q?tVfpI5qV9PsISYbHDU3hQwA+QksWC7MyysDc2PQ1EQY5JwkfCYX33E4wmQ5S?=
 =?us-ascii?Q?AK0i6IhDPtGtJRBCPtCdHcU2wbKMBmd3TuJGfmeY000b83P3Ym4PkrfUsL4v?=
 =?us-ascii?Q?iRGBZ2qjiaER6GMxHcp4DixbALLPHDGQtgQya9lAoLf6tNTakrMWu65Cmdsj?=
 =?us-ascii?Q?rp3l7HMQJHnDiEErl5ePKzQ+9s4sFOHwvAp8PbVHhxW2So6BW9Z8LtQ/UXz4?=
 =?us-ascii?Q?X4BjNkiRhmUb4NDI4su6MIIfHVYbjwPryudw38mvHOpOyefjUb4Gnhl3j2k+?=
 =?us-ascii?Q?JpmAeSxdtbDYeiKpkadRie1lpI19TARrfbVolmowK15KniLSYaRTSJTAyBPc?=
 =?us-ascii?Q?v0TMs1W2Ti3OuHBv9TwtC4edcbYVzdUY/CFpwYQzb9OAPOAbJQhZ0DQOwStc?=
 =?us-ascii?Q?2XTQz9o8txQ+R2GicJYEZsUD16LXCGg/tB5q93gexOiRmHW7+gwuWoRJs6nw?=
 =?us-ascii?Q?VBo8rtVg0hQ7uyas1AxfHBH+kL+W4l/aXMY6Etz48c7E7rRiASOaG3n8pWvB?=
 =?us-ascii?Q?4djHyOry9xmjEUI+h2bnGk5OuCAtT90GPvezurxBzl7PNTFyCq4qbCjlNwwx?=
 =?us-ascii?Q?3fiwfahMfq3BybT2EyrADgwhm+ELlQ1AUTIVdWSrR7GXKkJFMLghVKYYzvpn?=
 =?us-ascii?Q?GkmhmrUezms8eQdwQqINwLS0MUDcBuYPtD4M33ccqR8XEmlzAqSLnSY+LBKh?=
 =?us-ascii?Q?aGIeBpwuDaiZQBubN11OTs/Y2figzGUAo9eiHPxsMCXD2i13uuARrzzkYkO7?=
 =?us-ascii?Q?ab8EDEU/I+HV216UG+APECSQ89blD8upB0WUnpAjAIt1HsfnMP148B+7vWVa?=
 =?us-ascii?Q?8YtK5Xo8BHQyhm2PAVqIPffje+DC/+EgB7lIHQM9Euc/D0+u2OeCue/hf2OX?=
 =?us-ascii?Q?X/7+TIh0U4GvOlZwoZRfpoEBclwssNUfQWcmVF3SryXbe9qbQUtwDBBhG9i8?=
 =?us-ascii?Q?ORF48vD5wGZXSPPggnMvb/32KOPy3H0frriI6NN7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df1e92-dea4-46f8-2dea-08dbdc8c3b53
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:05.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BP4MkmbtvnzoB7iQYnLqzP7ccBRksd4WSAZKjwbfJS5gHmBSMiSsgFdeNEATntGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

This is only used internally to iommu.c now, get rid of it to discourage
things outside iommu.c from trying to manipulate dev->iommu->fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 2 +-
 include/linux/iommu.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index becd1b881e62dc..d14438ffb0feb7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3068,7 +3068,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		return ret;
 	}
 
-	dev_iommu_fwspec_set(dev, fwspec);
+	dev->iommu->fwspec = fwspec;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 37948eee8d7394..5e1f9222bde856 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -711,12 +711,6 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
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


