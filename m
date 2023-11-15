Return-Path: <linux-hyperv+bounces-939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C07EC462
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BAA1C20940
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BFB23761;
	Wed, 15 Nov 2023 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OT870ieV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAB1CABB;
	Wed, 15 Nov 2023 14:06:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582AE1;
	Wed, 15 Nov 2023 06:06:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMg85ApV3yzPwnem5jB4F1qBHOoJdE3uLgImB/r871whav85uvXRzU9r0+9WAXJeI6AeZDaISnuyd/RrHZV/Bt6a8XZi353V9rBsa1+2FLfJlqkPinbbRixOFWli4E+rffYL75T0aOfal3mzzeDgD8znJhGH1NMCrj+qGZqDa6G8E4pwb2mKpT9e0jWFUsk4pptsZ2x6fQPEVbExiIuKbMdAzASqyOA6gXo7v2nVd42HrG+raQk2/yfAf0qypeob3fBAx0bjrfLg+FaFqEVLErmU55uVAzZL/O/wojKxYCmXfCWh2mG7F5qZl0VXDygU1nTdX48P8PVgGOlW4PNcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gXhMM8cpNC/Vatg733GVNojGpIsusgxeMA/9bWA1jo=;
 b=Jv2y0eBisZm718LpJvxsBSaaEAoq+z4e8NM7/oOxLAgcN+hgmM4eigJNgUZruo0F/p2m0bG61At19KSdS/lRWHji7zwTJLK/833v0gnVJGa/GEZw9w5uot3649L9EXJFVstpideI3xbo2TXIiL/G7yVfWsYW0xstAAQO36+GXlXkHj88DGBwVEGFOqnCaMFo945BtAtCW1Mg6ZKmQig87AQnoi5aV6gdDyq2cIFzwcqhWdi/WVZkdkr3ffv+WoyyjPLwN1Gyq7QmhMTjngKzjZkOE8GWp8weI3a/WUkADnY3g1LB5ZIP16uwi1EVcRsVsWyGeKLqB6MyQpKzRQqWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gXhMM8cpNC/Vatg733GVNojGpIsusgxeMA/9bWA1jo=;
 b=OT870ieVx+l4kdLmD6x9RfZCx1ofZ+DWeRWqujr4NYQ4mJ6/rrlm4KrzX/DWX/Hvm/wy2Cxcraswh+bXj2fpm+OrcBrobSK7D0/r0HR7SAKf6fD7ZYKyx00PbPQbHqqGmQj0g351XBygwqqG2RbXZOs2VCGiNuiS9U4N5kfpWXKfk0f9TT3IcgbPxXdOd7p1hILNGTu+iT7Rqlo5JL1i8b4dUSyfzngSpmt/BUEFgos7rstTAUKCgyTASbjFmnvNUpaPmoNVj10J4OhTCrHyfCQobo9lqae/2yXmajKg1RIEM9r8TLBtEwnhV/WtaKSk2EMveKNqizMVM5ltByWunw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:10 +0000
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
Subject: [PATCH v2 02/17] iommmu/of: Do not return struct iommu_ops from of_iommu_configure()
Date: Wed, 15 Nov 2023 10:05:53 -0400
Message-ID: <2-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b3794d-c7da-493b-4a9f-08dbe5e40483
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BMdSz/B6hBZaWAAOSdl1M3jgRKTNnNe/zFYo+Reeeu3cx/SCP1KpuaLWvzPpmr96R9M4+bUnbUtcxNFM9ckhHDU3gSP2ZEJmHTFD5d1E51+raq/cP5QSe9//f4qLsrHs+A9Q+53hgqGtwI3gj6PqRGXwFRY/5bVmlbPTzb/0EF44b+0r+7gyvFlKXeE/c+6Dqr6LdgvUpwZi7pVqjnsrO2dfZ+awsoubPFcYxZSbTkWWhbmyIlf+2Li7wRA3Xe3msPf4lD3su9jjOo5OvCPLUTL4IHxrKKnyIoPibKfJPrelT3zwSGQoSRHf+UKRkYNs7g/18F0//H8DhKfQ4DBTdSSeSGSkXX6Ec2rUHjeUwGn5W2jdsqun2t6Hs4qfrgK2EimwzewaoZ76AQAxuK7coXH8SNw/yNCEnYEd+1kPUwrqfHV7249Pgx7nFeCa2fnOJdymTfmO++2GXB1KOT/epW0a59auimrodXQqdrQIW0IsLSnEaN/MJLjW3q0PtIB8B5pxJGCD5qm/alkHNSescz+lsilvQaYG8h4pZNmUgiJRbJUloHRU9zx8xvP4/2Yt8OJfmaW0Q/eo/EUQVxxi9tuTkvxpnLR/40YFXQm2Z7++udFJS1f/hJpxx7JDog9h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hMYGtjx+oacwgj+16f6fhxgZnMc8b2bi580ESJ+M93DhnxDO+NDWO9i6dVL?=
 =?us-ascii?Q?PBSNY66he4/VxjN/Xv5Ff6GQ5f8hYfQAuKVPXrjF2voW4mXGmJzLByAfu9eu?=
 =?us-ascii?Q?/0tjEFClOATtwtY5TOuOuTC5foFCle0utIelGTrb0zyAfKwsYQRwffzMsa1N?=
 =?us-ascii?Q?AzNrL30wbJT5wcy65kaURR6ChHlIpqZFzwuqJAyf+qjT41ZNPlv97dSeXVoX?=
 =?us-ascii?Q?+V1qM9QyhaoQlps9EKvzfhI59inKW4L68z55Vm6GvWb+sJO2VAcN3yrV0x1Z?=
 =?us-ascii?Q?iFwTFbYZukBVKlLLM7tGBUqAkCp7JW2evl1eGVwzJWi7ID6X6Gz+NlHY+tm5?=
 =?us-ascii?Q?qWdQR8sSjs7HVRGdZ4KtprO2PqoGLuDGZZNlhTg18l7VBszAgABF57cziBtt?=
 =?us-ascii?Q?7i4PH8KCQ/pUVrpghYw/40nLiTrlBLCAkln3Vx9X50eB5obS1qWsiGflq7/F?=
 =?us-ascii?Q?WQezdHIxZI7F7a7dlrrVkw+LA6C+GY0x7crzzI2deL0nPVCWbScmfUhw0C8y?=
 =?us-ascii?Q?FZXlRR1giJUylNjENGuCs5ntLVLvozWzf1wjNjJshuYUY+LhwPGkkI8aVsWs?=
 =?us-ascii?Q?+kS2mYzb5VR+QX6BwEzVHgxPsrq2lOke65ICyGsktyhSc4oSs58NvFnGoTVA?=
 =?us-ascii?Q?QUq554VWB8eqkqfVqAmdyiqe0JpdjWux7B0B4sq++50QyPHYrcqCX/6EZ7KC?=
 =?us-ascii?Q?lzexKDb8Q6ySnFJAXinytf/28A6qHUixmUYgEAyqqRHLdQxsd1SLkQ1fitCJ?=
 =?us-ascii?Q?PvenNn6M2GAZMY8jVbWvBt84MKL1+nxgTFl8eNIH+owoqad3Ju9XdJw5ib56?=
 =?us-ascii?Q?52rx1mt18eiFupdwnnPPq8ELCAL2M4nCGMMXGqqiMecdtN0AKib8UCRuOah2?=
 =?us-ascii?Q?RvxNwB+zv6DJznkEPpwXMZV2UWJB2f6/bZ/xsTqPufGm1eqLfL4GhtpdasHF?=
 =?us-ascii?Q?ABGzW0pzSoZFxgK2Se7VP6E1W6lv5VH6PKorN4qjAJmk9RdXRnG66bhzDmnQ?=
 =?us-ascii?Q?coqYL9uEo1/E2WRvGEek8HvQ/b4yaj+kUt7Ep7L1nKN48Ec4bJTNLOmnv5oW?=
 =?us-ascii?Q?hp/iykYfIPRlcpeYsGfbJYSixFhbk+Z7F8wjs/RBL7DuqIo2uFVOJ0DMwhjp?=
 =?us-ascii?Q?s+qagAYMCyA23UeQ6xjai9YuOlpZyLEhsLKZBie0ROV0Yo3PCWaY5l8aUR5k?=
 =?us-ascii?Q?OX5kJ6SgVVoq9KYCm+uIxnyFP+9rlnX4t70DFdwYxDclGIl493MZ49Xzn/Nb?=
 =?us-ascii?Q?VzsgPMWN47XiQhKWAwudvWUVbf8JZ+LD4UUEs08yPUl/oAU6G46kASn7qw2f?=
 =?us-ascii?Q?OVxJFQCNT0c8RD+Tbs2f6Kz7ppXGUH44VTC0Er2lzq3X8A9hslcEhGi9Wrk+?=
 =?us-ascii?Q?4W7EZ4YwfMe0M18lds7CaX60lNp7LJ2i7wGeaAyvfRTGOzFHQtWG9bYu1HTx?=
 =?us-ascii?Q?dYzLENfROZ2WeodwQOZQUcBL6slEU5MJj5mK5bDmBXKq9CgN48u90Kf0svnE?=
 =?us-ascii?Q?+ubYBcSn3PBeBWe7tA3g4ak4tVLPgBztd0HPT01QAbSaOugUUxUoc0q3kC0z?=
 =?us-ascii?Q?XS2kG8CCIdJtKcd0v1s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b3794d-c7da-493b-4a9f-08dbe5e40483
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:09.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxBC5xm4tS+nONgRE/3t6mULKCxKO1nd3XFhHlv8woPsivA1cR60LaUSu1+HgDKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

Nothing needs this pointer. Return a normal error code with the usual
IOMMU semantic that ENODEV means 'there is no IOMMU driver'.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 31 +++++++++++++++++++------------
 drivers/of/device.c      | 22 +++++++++++++++-------
 include/linux/of_iommu.h | 13 ++++++-------
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf3a..b47dcb66cde98d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -107,20 +107,26 @@ static int of_iommu_configure_device(struct device_node *master_np,
 		      of_iommu_configure_dev(master_np, dev);
 }
 
-const struct iommu_ops *of_iommu_configure(struct device *dev,
-					   struct device_node *master_np,
-					   const u32 *id)
+/*
+ * Returns:
+ *  0 on success, an iommu was configured
+ *  -ENODEV if the device does not have any IOMMU
+ *  -EPROBEDEFER if probing should be tried again
+ *  -errno fatal errors
+ */
+int of_iommu_configure(struct device *dev, struct device_node *master_np,
+		       const u32 *id)
 {
 	const struct iommu_ops *ops = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int err = NO_IOMMU;
 
 	if (!master_np)
-		return NULL;
+		return -ENODEV;
 
 	if (fwspec) {
 		if (fwspec->ops)
-			return fwspec->ops;
+			return 0;
 
 		/* In the deferred case, start again from scratch */
 		iommu_fwspec_free(dev);
@@ -163,14 +169,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		ops = ERR_PTR(err);
-	} else if (err < 0) {
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		ops = NULL;
+	if (err < 0) {
+		if (err == -EPROBE_DEFER)
+			return err;
+		dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
+		return err;
 	}
-
-	return ops;
+	if (!ops)
+		return -ENODEV;
+	return 0;
 }
 
 static enum iommu_resv_type __maybe_unused
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 65c71be71a8d45..873d933e8e6d1d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -93,12 +93,12 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 int of_dma_configure_id(struct device *dev, struct device_node *np,
 			bool force_dma, const u32 *id)
 {
-	const struct iommu_ops *iommu;
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 dma_start = 0;
 	u64 mask, end, size = 0;
 	bool coherent;
+	int iommu_ret;
 	int ret;
 
 	if (np == dev->of_node)
@@ -181,21 +181,29 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu = of_iommu_configure(dev, np, id);
-	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
+	iommu_ret = of_iommu_configure(dev, np, id);
+	if (iommu_ret == -EPROBE_DEFER) {
 		/* Don't touch range map if it wasn't set from a valid dma-ranges */
 		if (!ret)
 			dev->dma_range_map = NULL;
 		kfree(map);
 		return -EPROBE_DEFER;
-	}
+	} else if (iommu_ret == -ENODEV) {
+		dev_dbg(dev, "device is not behind an iommu\n");
+	} else if (iommu_ret) {
+		dev_err(dev, "iommu configuration for device failed with %pe\n",
+			ERR_PTR(iommu_ret));
 
-	dev_dbg(dev, "device is%sbehind an iommu\n",
-		iommu ? " " : " not ");
+		/*
+		 * Historically this routine doesn't fail driver probing
+		 * due to errors in of_iommu_configure()
+		 */
+	} else
+		dev_dbg(dev, "device is behind an iommu\n");
 
 	arch_setup_dma_ops(dev, dma_start, size, coherent);
 
-	if (!iommu)
+	if (iommu_ret)
 		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 9a5e6b410dd2fb..e61cbbe12dac6f 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -8,20 +8,19 @@ struct iommu_ops;
 
 #ifdef CONFIG_OF_IOMMU
 
-extern const struct iommu_ops *of_iommu_configure(struct device *dev,
-					struct device_node *master_np,
-					const u32 *id);
+extern int of_iommu_configure(struct device *dev, struct device_node *master_np,
+			      const u32 *id);
 
 extern void of_iommu_get_resv_regions(struct device *dev,
 				      struct list_head *list);
 
 #else
 
-static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
-					 struct device_node *master_np,
-					 const u32 *id)
+static inline int of_iommu_configure(struct device *dev,
+				     struct device_node *master_np,
+				     const u32 *id)
 {
-	return NULL;
+	return -ENODEV;
 }
 
 static inline void of_iommu_get_resv_regions(struct device *dev,
-- 
2.42.0


