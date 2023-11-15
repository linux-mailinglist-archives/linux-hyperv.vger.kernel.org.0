Return-Path: <linux-hyperv+bounces-950-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A057EC48F
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A225A1C20840
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69902DF83;
	Wed, 15 Nov 2023 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQL00m2t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3628DB8;
	Wed, 15 Nov 2023 14:06:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3347127;
	Wed, 15 Nov 2023 06:06:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L34WIMn0L37fEP7oXaODLk3O0t8qwfb2GqkiBxPzr6ApOmU9IqV8MgEys0a1jZsAhvAtCDYa6KDGZcYKQswwMS9nHlXiz1uCVB2Bs8fomx3FgM9cljEK/l8pJKIjCcECAJz5k+y0f15gHSBGPSSWuNOT67xuN3cEOATx4ZpX+K0l1RRK+q/bumxrD8+xvtkqpVZQjvUZSXee7ENL9+UegpbucfhVBCq9qrrVSNLDaAxMW0XhrkHjZ28iDmrd3nvUhe7XdLfqTq2O8sZbsUC+UJvAEzGKBuQOMQJnYxY/uD7hIQ+ai1k9ElxGEbjVuNKtix2fjYGFJcBEydOSQDtMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lldvf71VVKZIH/vbiIeJYozAFHi6LXkixQ3WAHnPADI=;
 b=fqGCCzpc5Mn7GnNp6eqCDm5b83bRmJVYpORaxY5wBdFIIqbfsNy0YVsEg1d99Ax+KBiebQEx4aQyuMISIvnHMZvUx75eXm98XIrMICU3FcA7o+YU+suKQaOnwoTghFEiS6EiwNJ9HGRCti6y9Rd7LW3xk2Kgq8mxhfRMCGGfxicf1iuvM8VUIWozX02knjf3j3tPBl7SAgKSHVfArV5bEMcXqwrasz/hskiZ9yZrtqwiOgp6lAfcvqxO6Jmfl3IurGPZbKxAXzOT7tjhHYF2JFSXSduw2U6H8f2HDN8sNVweGOKLnpFohETZlRJmxe/IW9B9sT9yFnsrgzkXGr8NRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lldvf71VVKZIH/vbiIeJYozAFHi6LXkixQ3WAHnPADI=;
 b=GQL00m2tswBrSxrSdR3RlDBvKd5QJOrAYdqUIwq5NwwJpZ3qHlr7P/+vQbqfkw3JOerNCZUvEnIj9Lxs+Kt9AV5Hm2H7L6L6GNuO1qfOB9G7RYOGm43n+Wn4VrecEe0IkzkFwpBxD7hxN9nNcfKIn3JS8Llyc7u8ggbg2F4npDaCRyWyXs6F4/kHl8ZshiruL+Ne8Xxpf0TssY1mgQHDzVJHY3QhUHxnfg+r6Bksl9cDVNg2PUqmIJnqg/kesmqpTL1bLbjxUWbQTJEk/ZeFgmNu8g1USvNTznUPGc9hI+mLxUfc2SYoneefVjzQ8g/FTpsXpq5nCRqp9UhIIaSE3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:17 +0000
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
Subject: [PATCH v2 07/17] iommu: Add iommu_probe_device_fwspec()
Date: Wed, 15 Nov 2023 10:05:58 -0400
Message-ID: <7-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:208:32a::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: c586f63e-b4e6-4a6a-8d98-08dbe5e40589
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BXUf/SmFrdNP2K0nUEx7X6+NljQ4IDKHlXRa90X1IrI6XtdPIpKWzQtYndq7l7KzSyervLlnXUW5sLUVBila/Lp8mITk417Uv7wCwOl5krNtGLEnanWEp3ltm2Kha8JXbU8ume7fZjrHdn3qn/lIUmYJRLSGXfy+DyIDKGKZxSw+9/c63Lxyhw48q8ia1PUPmcg4AvzZ0kAgsmU5feb2wfC5TUEIqRAlfnuxSvWQntY9eOIyhEvIKB2mtrPHw4k9y77O8j3VQ81AQApfIcrd0IR3aZb876ALrTEUeVZ+I794BmuV7oQA/AfxN5LSAO0DL2lSd3Qa9RJ3iEujWgbuEt7EtHC0Gr6CreOq2hsYwVPuxxPtMLRZhN5CMMpV7KC/Urg4doNcIp1oCi5PBRRosOqywB5rhVaiX8/ykDTBpdWoDDkk2G4B2bDhqIqOQkgWOA5ze7dz5ylO3kfr0myZohnMRNpDwqKnAm4W37q9fIiBqgODxr7xw+0YyxOL5/9lIVEsAaDSx2aYlLBfJbQHfMi4jFNB2qPI+DLGF0oLWsyOHoU1F3AbSTlC6V1fhxSj6kTEofENIYdJ8p1ApuABzMjvvnd0aYFAbIXdTZhLDIhmVPhmkEVJ0dtYxa9LwU6V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66899024)(110136005)(316002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(6666004)(7366002)(86362001)(5660300002)(7406005)(7416002)(921008)(41300700001)(2906002)(36756003)(8676002)(4326008)(8936002)(2616005)(38100700002)(26005)(83380400001)(6506007)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrtZQZHWMD8kqqPCvKpXuD3uzmrOhjTHtoZoSwZ5gbClYeMNtSVsaLw98QgK?=
 =?us-ascii?Q?fy/NQ2etUkmvvZXqMyYB3VEx0GUob6tpRigD8LLkm02A1r2m0+9K3oTBfh9l?=
 =?us-ascii?Q?7EfCQOWDCQanLAiTjpJhcMrnieGhzDNH8MN1npg36hsvjoH472UKgW6bob62?=
 =?us-ascii?Q?cp6Mts8GooSDvKztNFgzdfOwKk0tDQ/nLA0QsDS6fkKCmW8flNeySGXd+zd1?=
 =?us-ascii?Q?vhsuQRViTEyBmxj0D/UDZUzGZFT55t7MAJfyY3oohUj3KCTmRFdNumrQtN4K?=
 =?us-ascii?Q?75eLZq3tYn7FfjgqgnTZXWjH/Hxpyfp1xLoEBM/WVBB+Sd01U0xldVIBHcue?=
 =?us-ascii?Q?5OeOzJSMi8RDGPHubK4D+du/QcCGFHPJ/ARlQ2ENEXGWUbRRFNpkfwhtSxkq?=
 =?us-ascii?Q?Z6mM71i5QtVbmIjfBqWLYvqZ+qkvwdzZ4sC008iOAdMm/LYTvuKUYoIQ1M/T?=
 =?us-ascii?Q?1zoBaRYM1ljH55lLDzJNVAUZ3SETnyLfdFBP6e8efv6ISgd5wV5gKLytBvLI?=
 =?us-ascii?Q?AC135oZ05yrlzE7uvfI7Fz3syGV/fpmnolMN/YISgdPkYzTNB9dSwxxFJ0nY?=
 =?us-ascii?Q?Ss2IHKuoaVDNQcor0SYvxSKLz8Uh3MKKfUrfBD3cdh+sfJifJahKbxUg1yhy?=
 =?us-ascii?Q?P8w33jZQYgKUOXICZEB74c6JWtcZyAnduJjaSf7yxUfwnqtg/m5LxCtvDGGH?=
 =?us-ascii?Q?xF5PXlVh6nAMkHiaHV5BiCAUNF0smYPI7Z7hj/pwBN8JHbHc915moEtl1Fj5?=
 =?us-ascii?Q?6WhCzRCWVj7lXoB8SzMHChOmMEIgPPS5fRT2dF4HzH0e/dWu20QMQln2dg54?=
 =?us-ascii?Q?VKfOW/OVikvs+xGjiQOIgYUzB3ZwP3569jNZY4X0/oSdockUrs+rn0j3jOl+?=
 =?us-ascii?Q?1KNdT/giQobMl1JE+VR/VLp7aoJHSKIJJD5Z0ahtmMiO3j5HuzHFIsysbkNS?=
 =?us-ascii?Q?qerBvZ4zMDvHjtnfoZHxxinNs/RKeAWzAMtty+3NPadoK0/jLja+QetlUvOp?=
 =?us-ascii?Q?6SlelTiXzwLwZ7dt1POJ3NkPHBu21TItpI6O4WphAefIomAHbMFx+zxq/c9J?=
 =?us-ascii?Q?nYsFGPGpne9PzBhm+N1MiRji4kGQKL7ayZqDvPl8vWadgQp7M/2/0VO5F0uf?=
 =?us-ascii?Q?3nysY/J1x0p/X0+MRWHlB89S0pBb/H1l47HE2CxCfcQGaoq8LYoXmLiU4MAZ?=
 =?us-ascii?Q?sxp0GRe2BTb1h7SRbAJLQlrI8qQHOMMQijGmbGFJWFAe9O74X1vm1TFhQwh3?=
 =?us-ascii?Q?7dti2mSW0UqCszJH6+neixbsf+sWC4PVo/G/VW8lSuz8ha1c59QXYFI6iQEU?=
 =?us-ascii?Q?wFon0etZ8Ztge5nLebh1GX4Wtmpv4egtt0Vzfcbh3K9HIIBbP5Cknuoa+T8C?=
 =?us-ascii?Q?Jc/BaMZLTwyWE4K6p1sX8WgPz5nJMgyrDS9YYyAivsK5Ok7LxEp0dC+LDOp2?=
 =?us-ascii?Q?HQ+3Ny1QdSdy6XN/LQdm1SCyUhrqr0iiRf3CwU+z3RmL2mxQnTKl+H+FW3Id?=
 =?us-ascii?Q?iEWMA3VN//ez7pwfV7WeF5WfDRjrAZqD4oP0UoOzjeLK7y2Ox3ylmu1i1rp9?=
 =?us-ascii?Q?K0DT7os9h5MQ35C/4V8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c586f63e-b4e6-4a6a-8d98-08dbe5e40589
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:11.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPMsRct3UdXDK1DMpHB9irJ5Gk+20sJiuiyAslPXmjUm74Z8hFSYc1wTQrTjuWH/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916

Instead of obtaining an iommu_fwspec from dev->iommu allow a caller
allocated fwspec to be passed into the probe logic. To keep the driver ops
APIs the same the fwspec is stored in dev->iommu under the
iommu_probe_device_lock.

If a fwspec is available use it to provide the ops instead of the bus.

The lifecycle logic is a bit tortured because of how the existing driver
code works. The new routine unconditionally takes ownership, even for
failure. This could be simplified we can get rid of the remaining
iommu_fwspec_init() callers someday.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++------------
 include/linux/iommu.h |  6 ++++-
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 86bbb9e75c7e03..667495faa461f7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -386,16 +386,24 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
- * driver probed
+ * driver probed. Take ownership of fwspec, it always freed on error
+ * or freed by iommu_deinit_device().
  */
-static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+static int iommu_init_device(struct device *dev, struct iommu_fwspec *fwspec,
+			     const struct iommu_ops *ops)
 {
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
+	if (!dev_iommu_get(dev)) {
+		iommu_fwspec_dealloc(fwspec);
 		return -ENOMEM;
+	}
+
+	if (dev->iommu->fwspec && dev->iommu->fwspec != fwspec)
+		iommu_fwspec_dealloc(dev->iommu->fwspec);
+	dev->iommu->fwspec = fwspec;
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -483,16 +491,17 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
-static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
+static int __iommu_probe_device(struct device *dev,
+				struct iommu_fwspec *caller_fwspec,
+				struct list_head *group_list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct iommu_fwspec *fwspec = caller_fwspec;
+	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -502,13 +511,25 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 */
 	mutex_lock(&iommu_probe_device_lock);
 
-	/* Device is probed already if in a group */
-	if (dev->iommu_group) {
-		ret = 0;
+	if (!fwspec && dev->iommu)
+		fwspec = dev->iommu->fwspec;
+	if (fwspec)
+		ops = fwspec->ops;
+	else
+		ops = dev->bus->iommu_ops;
+	if (!ops) {
+		ret = -ENODEV;
 		goto out_unlock;
 	}
 
-	ret = iommu_init_device(dev, ops);
+	/* Device is probed already if in a group */
+	if (dev->iommu_group) {
+		ret = 0;
+		iommu_fwspec_dealloc(caller_fwspec);
+		goto out_unlock;
+	}
+
+	ret = iommu_init_device(dev, fwspec, ops);
 	if (ret)
 		goto out_unlock;
 
@@ -566,12 +587,16 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-int iommu_probe_device(struct device *dev)
+/*
+ * Ownership of fwspec always transfers to iommu_probe_device_fwspec(), it will
+ * be free'd even on failure.
+ */
+int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec)
 {
 	const struct iommu_ops *ops;
 	int ret;
 
-	ret = __iommu_probe_device(dev, NULL);
+	ret = __iommu_probe_device(dev, fwspec, NULL);
 	if (ret)
 		return ret;
 
@@ -1820,7 +1845,7 @@ static int probe_iommu_group(struct device *dev, void *data)
 	struct list_head *group_list = data;
 	int ret;
 
-	ret = __iommu_probe_device(dev, group_list);
+	ret = __iommu_probe_device(dev, NULL, group_list);
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c7c68cb59aa4dc..ca86cd3fe50a82 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -855,7 +855,11 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
-int iommu_probe_device(struct device *dev);
+int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec);
+static inline int iommu_probe_device(struct device *dev)
+{
+	return iommu_probe_device_fwspec(dev, NULL);
+}
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-- 
2.42.0


