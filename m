Return-Path: <linux-hyperv+bounces-672-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C57E06DC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C131C210C9
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16B71D6A1;
	Fri,  3 Nov 2023 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QC5xh+sf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1741CABD;
	Fri,  3 Nov 2023 16:45:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721441A8;
	Fri,  3 Nov 2023 09:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjAVriM/lsm/EoY9+1EzOHZqQsdlKLyqyHSR5LkQ2O0PhgbXhIEGlNw3Spx6apNm095Oam0S7JVHc9g7WLcrXAROb+/8BIyLrp4K9kZcb9foq5axrLbn4LVWPpuMR6270gIb5dP8/yqYI9uYMcBIuC82Vh20KDEDZYHsb3PurmVkyOxgOee+Rw2Pvvm4Dx6PD9k4UCnKGnIH7HPJc1oufpw5YIJDqlPcex38Wv76m8eGj6HGGsesnRW4cvxpli73HwweboOyYTIoNqHcB2uNqisWXVnD8beRQgI2Jtv7a9scKYl16vO3QuQKQl71OBxulEOVwq0UHHexI81oJnEhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oUANi4ebgUezJWWXVg+fAiGxYoLyITdVw6Nq1mQQ5w=;
 b=P7u1fDoffPf8dFCVNUj+HgSoAA+DEwH+4tLv4P/yVjrXsd+8N4KFt9Fc8kS/pUyrruK+oFmEHE1/2LBRVnxmb5+ZS6FmSz854SnTWhiy1+YDwuKT7yN0tHgC5bFrrAmAOCxpbkvmislMAIRBAriT8/O+l3h8ROB5mXtQCdFMjSGECdnDt0azWnPZ7T6f1p9lub63URQqqTgBzwmNAyJJwCKoXSTTj9Cd07JxiI+gjgiopgnTh/Y5BhYBHdEVOPb+4kdiEJVKUMedIBuLGbJ4hIZL0bONEnrrq5ZsULvZPwpPSc33is1LxUlltoOUevPZQ43Oy81xhGhr6lSBoXO7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oUANi4ebgUezJWWXVg+fAiGxYoLyITdVw6Nq1mQQ5w=;
 b=QC5xh+sfEl3OKk2VBoNiDs6jVtJ2Kj/4uraHoo6MKvr//ihGzt+Ri2raN6054Qo/8FgBL5lF6rbl1dY1yI+OrqhukAFgwiUpbZlGq3Rv5y3Ft17XS3Y4iFAj0f1qk+b0u+yjDaQULn1GBo5JOR9vQGfxBE3JMqGZHScXbB+1TvuSxFzg44JHKhtkJGm+w3PharGsRadv1oRLt7glb1eABk22AJneVKoeXVJxFbWFP2V/fz3kgF1rrH7JGIUp0X+fOH4Ni5UdccbtCbY6Ui4JjWmiHZhuCbMuJJXGsdA2YtyqujpFW+zRLsOu6ddYrmKFmXknPoO1pxS+HO9OEgnS9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:05 +0000
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
Subject: [PATCH RFC 12/17] iommu: Make iommu_ops_from_fwnode() static
Date: Fri,  3 Nov 2023 13:44:57 -0300
Message-ID: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:208:234::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: c547a2bd-672e-4f02-4b9b-08dbdc8c3a6e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Asm+AZ1OK79V2uQfo2y53+C82m9HFpaMCa0WW0CUTuU3EzZfhWgSqxdvHQi0LuS180fh+/9kwgsdOpQAyY7z+Kko5par7d+2ZZWZ0hyBeSb1EWw7D7WzFsyy+4Vdzh+6zpJqsFfZM7+WUksxbLJIyzmNUxFAuen4a59mlXKy3sc53nMntjyg0/CoviRdbWf54nwUyW9A4+cdUxSj7V0P02adHgKelLM831kZIsWD9digtaYiGaVL0UvvPq+jytXwAmRv3UJDRF0s14QsR7cv8ZFUwJKrb0TZRcMaS/khlQni0RQaLgWg9R094Z3WIvIDAIIAAO5iLAi41tm2l36UrFMtOgbpZLd0Y7cgcNz7v3B2CHwY5w3lgi/uweXmgFBgLkXp6icwbRPGQ0Wz6yussBxkfJaOun2omvFMgXnD0kNs6ixPEFVFypUp4/pZgGUSqANpE79+1NMQ+jx5gXE4e/89NYIh0ZhZGkT0PEHhjevFwv1dgFJhXpZd8PUjbjRdO7aWfiXSByZS49QAejlVNiCKwlEWJXCkpXZkK1tc+MGLS7OyqF2iTf3vWe66rNXGd4ibr+0jIvU4XB3zBDjKg8kbFHJH3lP11JjQGguj86HW67wh9gc/s3WUTtZOYPcRRT7RpVeYf3vmxbx0gyVyXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(6486002)(66946007)(8936002)(66556008)(8676002)(316002)(4326008)(2906002)(7416002)(7406005)(110136005)(66476007)(5660300002)(6666004)(478600001)(6512007)(2616005)(41300700001)(26005)(6506007)(83380400001)(921008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NEkKYjvXTEFD6WOZt1iQQgUYIvDndFHtnVDLEYLO2tK43YuIXR8OJzNYAQBz?=
 =?us-ascii?Q?2R6sT18sxHsVe0oWRMLqxrF6ehVBdr9fsoR1G1/NAfjt+klIcSa/w9FEhN+U?=
 =?us-ascii?Q?9bVI12m/hxOZmeSa9KXycnrhcl/v4EG19t0V3fVMQ8mX9xe2jiD5zKol6ht2?=
 =?us-ascii?Q?Rc7JtWLuEfLFSxgu37OvxWydEd21PdggKdNioHTmGag1JWU5pxaahEbu8HI8?=
 =?us-ascii?Q?fa26krz1GY0gRx6Z8XREIkP+JKbyGZlBGrSuEvU3/z7BRHMtL5GFItH6wr8e?=
 =?us-ascii?Q?CJBvNG3OrlTyQ71rq3KuFGxWT8antrXGvwdA1anH9I/OD5HgziNrPhuEoTpT?=
 =?us-ascii?Q?Mz14CE+Kn3NzxON5b354LRHL0XEzDxUuh5i2PwnXAmdSCQT3k9uqkw7Aj27v?=
 =?us-ascii?Q?U9iz+NCHN99JanMf6zeiPNOa/w75aY+NP0AhTPy0askTi+tf09WURX0feZvS?=
 =?us-ascii?Q?4rnpfa7c0NvaFXxg7MwdGoUTO+/8iqIgyB7UmWeEPzbHVXXsIuF2ndWA9kav?=
 =?us-ascii?Q?0etaoHDWju4rgMZKrtuqOvYMaF9FuXCyDvFVW298eh0fchY/974lJcF/txfn?=
 =?us-ascii?Q?tzNUPgY0G6WccYlop0FXYQ94MGcw7G/Tdp4jDZvmNlRMBZfzlninC0dbxADF?=
 =?us-ascii?Q?Y3nVwvCWuVQHLTGzCXZfP9tNNgw1vM0PwvfPG8DgCuDzj61mLub/qubKwoF7?=
 =?us-ascii?Q?7OpDaElcMXXcxQmMWxUeVEHxnABL5xf5r/aplHrvOTiE0AHgSaTuwQrcpSPd?=
 =?us-ascii?Q?2yKh4hNBFUfHg3xKHkdkZNrdYW/u3lGI4Vri+Uld4xVFBwsraKi/JId1981P?=
 =?us-ascii?Q?hE70WUmwjSsHqU9vkEs0d+39QWg1mVLnVQSdMpLZRv6ZV0IfaamTSSmZqCIV?=
 =?us-ascii?Q?bQ/JzUktUdl5ls2F65ETHX81enGgRPisfo662eZRQlddvfdhVJpcMNjfZZUT?=
 =?us-ascii?Q?xflj2VsJg1tWa2y6cvhrydEbycT+nVP+/gAXPD/5REYjnuXMvIq41aoFeN0Q?=
 =?us-ascii?Q?p7pIqNewSw8oD2bRHs/K/RVNc/D0EvKU5gFUXOCfIVRkLPgfaPr2cSsq9oNW?=
 =?us-ascii?Q?qyc6k58JHJsvfjumAAcElkIDZ8aFqEF2+Dg0suna6j1d/xoE9EnD09bXrLum?=
 =?us-ascii?Q?YsNOfVLbRxYeULXPNNTmDd1QAuLu44wMNpUjZQqIm6PcuXHXd4JQuIqdKauT?=
 =?us-ascii?Q?Rk/vjbG7bbjVn27buH9J6+Pr0xU4Tv4QX3wnKHNj9ecAT9UamOKbjIOuK0A+?=
 =?us-ascii?Q?l5xCo/tFdkr6NzPtbO2iA5nKO/hL1o2EPu/shXw/lJNn3HsP8o+EfgddKc2j?=
 =?us-ascii?Q?sSp2C6swX20DkDxdoj5DgyDVxKxFUZv9R3ta9GSQJNn4CuI6sqIo+UYiVtjY?=
 =?us-ascii?Q?CwxHj0ClcwrhQ37sBd4527G4u7GpWPwJJ1gLZTh7v+NH2NdiKDp6HlbV6BD9?=
 =?us-ascii?Q?j5xuSq4t3h8mLOY7em8S3qQ8xpAlSO2/G0hqG24y5RqNdGu9AsO8ORWUSN1p?=
 =?us-ascii?Q?lQ77OVG1V7+VpvfReEMvNUJqSLWP2ux+tMGm18PMrwVjyZ6CWPUPU0ur3yFY?=
 =?us-ascii?Q?FQ7T6CBSzj2qw4fEnA8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c547a2bd-672e-4f02-4b9b-08dbdc8c3a6e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:03.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2KClPrhOOOdi52tcdTmoDk1RFz5h5qoBAccnpU23VJBue27qV7w617cU6W0M4OX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

There are no external callers now.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 3 ++-
 include/linux/iommu.h | 6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 62c82a28cd5db3..becd1b881e62dc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2945,7 +2945,8 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
+static const struct iommu_ops *
+iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
 	const struct iommu_ops *ops = NULL;
 	struct iommu_device *iommu;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 27e4605d498850..37948eee8d7394 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -701,7 +701,6 @@ static inline void iommu_fwspec_free(struct device *dev)
 	dev->iommu->fwspec = NULL;
 }
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
@@ -1044,11 +1043,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 }
 
 static inline
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
-{
-	return NULL;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.42.0


