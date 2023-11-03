Return-Path: <linux-hyperv+bounces-677-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E122E7E06E4
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEE1C20D5F
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EBC1F613;
	Fri,  3 Nov 2023 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bd8jm1pI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448BB1D55E;
	Fri,  3 Nov 2023 16:45:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20233FB;
	Fri,  3 Nov 2023 09:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eML+qQPLUBIzYKjqeNChqkvQk/bjVdWlY63GPZHeETa2AIgf5ow9dGQikc5qVwzxN6vhMVmirf1OP7eUucJfbNj9P2RzzBRwd8KwFu/mCjAFifDDEjV3SGjglC1djN2rek2g/CszbUhGwFNPUgN4kdqR6R7kyM6cGJFtDB+euaNcv+V/RfH6q3B+EeELT9gOr8Y6Xi481u8w/7uMdUvaESNURponJn93bw2d8SZ8V2pW2bq7jGKyRuDPVtM9pEnW+70xKeceLoYg4QH7MyHKR/K+3LvfVID8mpKETDfIIBz7wYzTre8eQJbHgtYnzaXNrmbfyBjNcb9UeisN3ggOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDgF9LIwqGUWebF9aK0bE0A1roaQkKgVEwBQRMHhozY=;
 b=dL3W7fmm9wG87czjY9AOV4F6FA1i86QCP+BPBzawc5nWdJArPkCrSymIbBHadFwqc4h442fe6IaEOoxQMGDXONFJ0zo+SLYdRTfT+enCCTbO+txQJI07cLf1KpZ8kXhB4/noSyAbH9IAQUY/hgmWPTAilflK+ak19FL7wRlfeCGpa2ZfkLYZy/0xZWTCF8vvs1Y4M5hVhzMdWD0z/XQZesEm/Rvz80ODJBiAdEieRkMkLz1TlbQqMuLoJLj9LxizgKFEDdeBK5L9KB4nUT6W64bcOJqvuZe46QWmvc2VP8/WVrYAv1+xolw2t8pfull9OE8ghoPrQMn8KFYPDFUB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDgF9LIwqGUWebF9aK0bE0A1roaQkKgVEwBQRMHhozY=;
 b=Bd8jm1pIFNlEgAQtHWN4f6xnx9crtLLIK6klDOmF42K8dFbIl9ML+NynXfElEokDNO/WzOf6mFUCdIxY/ESZH17Ilf27WocDM788xW4RvLlkhWf9WZM1xJXSMUpgiJrhyt1XxDzIhFaEbiB2kgIB6FSwQJA6b18Ynpl6+/SBhmVAGzbRy2S25AeEgyszMq4oaj2qFv+jUfsEWyFUJm3fuzcsXB7vyIo6db6HvdlGE8vvzTBnU0gT7uW/AUckn7tr3mV6HOKP7JLr0bh4w85gGgO0scM0kKoedPAzVUHtBHWvLFOsx+QlkdHak6a5idMly7yEF4Zafu7DLQ8WJh1fUA==
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
Subject: [PATCH RFC 10/17] acpi: Do not use dev->iommu within acpi_iommu_configure()
Date: Fri,  3 Nov 2023 13:44:55 -0300
Message-ID: <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0319.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a1b4cb-74a6-49c4-ac9e-08dbdc8c3a8f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oLhatMT+O1JVGTvybEtnhV0qYUWWYZnlsM+4WJsOoDQkxRWFQHQtGClNslcPiLDbQDX/sl4SJX7IUs1Dpip4EhbjcerJ6LPy1qQ0xwoWI4JpwQqXABuRGaIIiIJGlnkIhtlGsnffCZQdn/yR0KHjvU/Z9pM1UdL+kjxBtD7xoY504mL3YzFhAP1qFsCGZgLe+Qa/QwdEE5Hxlqe/BJHWuoJMB2NhCoLKH5mVrEruIUBrRSb01KqqkCs0jia+5EkxThTg3d4FC9U63pFNnky9k7jDEdWeXjrlMLUEpTzCuVgdonHFjauauTYizIka6qX3xKW6eDgz6uMVQVUvIQaVa/xynRoaoX0ktaAPLryak+QrJ/yum2jrRb8iwJjA7l6N48+RUaNoFzwJGP7PkCCw8zd4xmm6yd8TIAsLPprjv5NOqH8J2vyBe+Yw0eGN2CUoJbhW2jJgmgDzYgIW3Hfco2awjQbsaynxd6fDGt4GiXY4lkoOikKtkR62DNRH0xx+ifb0nPXyGQUpzFHItR0+tG1hk6zlvk4RO8b55ovmpxPDBy6WlrLJo1Xaz6WL7/lwhaHGtKt0y/FVM/D207G8MQWNrjjWdsrHD2EG5wAjFaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(30864003)(6486002)(66946007)(8936002)(66556008)(8676002)(316002)(4326008)(2906002)(7416002)(7406005)(110136005)(66476007)(5660300002)(6666004)(478600001)(6512007)(2616005)(66899024)(41300700001)(26005)(6506007)(83380400001)(921008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7f8UwWBqG1rETv0WXC9f0TpB1o7DpJoHcQLj05KjDiZ5NrkvWL9Ge1g6t0wJ?=
 =?us-ascii?Q?p8+XE0wwv6MVxEqfahbyWs3JEIZmMCPfVM6YXF0+8x+apaJ1T/IQIEn5ZoD7?=
 =?us-ascii?Q?YMGugvMRqW1OHabCUKYFyLSZCFgrKKiwb5oRPBf98eC3/iX+ijT0w8KLHBuq?=
 =?us-ascii?Q?og+7yIon1ubeo4oe5/Jkk222cOW+42L4gV0PsusP21DbTtCK+Ory449cHBmR?=
 =?us-ascii?Q?ECM/4NhwrlDG+N14SUwVa+su29MGZSOyBKLGbBnAeCtACy0rywI0t6lvSSH9?=
 =?us-ascii?Q?OfLTFIF8lQp/qWROqq/jDubBBFfc5Jg0qULrTvD7xdg+8QIsSXxXm2lJdrAI?=
 =?us-ascii?Q?Doy6Hq3AonIALRN/MPxz4AerJlOJ3jBVHOhtWcSrIBamJ0oydRnm3Z5Prjv0?=
 =?us-ascii?Q?CO0dYXUPp5dEQIjChAzVwVsxfxe4vKtXTtj4aUrkNY29DjVRSyaLW0IOt4cD?=
 =?us-ascii?Q?ZLVrutaqBsdc3tBnC8u1vYeGm4Fn8cOG4WxD1A43UQFeg8sp8FZxTxh8fYzU?=
 =?us-ascii?Q?2FlhC6rd9c9weSMLPnbQGm9ErYk+DaJ2r5OOYnbIZMz2R4YnidBb5ogE1iz4?=
 =?us-ascii?Q?X/ZWRmBHM3p9Wg62J+n6TK/D4JNuFWdyU7W219f4Jp/U/a9rIIL0nRDrZSGv?=
 =?us-ascii?Q?WFFqYOsjoSE9IZ5hXYS4H1racBG0eaprz0eI7nh/jEqQkzRTu5rNEQt7YYJF?=
 =?us-ascii?Q?UljwyWuYDlfFhqFjOoY/ZzbdacGuvw8iqfW6Lnr213qw1CSrRuwcA6QIDGWs?=
 =?us-ascii?Q?YPp3nwAv37iiHqs8Os/ArKNiQD4zyOCyKTo56LG7k0qqgpw7mULN8xLowQJo?=
 =?us-ascii?Q?gC9my4WN7oY6XZtvI7bf5u18JopSw+ElSiAEaRu8f0428aFpdVqbjAjTr4cv?=
 =?us-ascii?Q?2e6ZaDgp9j16rXK35oMWD2Ia9OjAt8+9ZM+3jTFiBHmrNgguu9mll6Jmcudg?=
 =?us-ascii?Q?KsugDOSaxpUFO0b/NEDhH0JenHhHyTM/4qCCar8PLzMzO7eb3WSdx8eAqMsq?=
 =?us-ascii?Q?zsZiZc1cb02XJ58YkhB5uvl7LnNKT0YmOulZvkOh+gzYm0EQxtjma/JzNmSN?=
 =?us-ascii?Q?a0l9n4lxYDovH9df4hvxWDe3MVGOAR7Ln11dfkEP6jmtVxXaJv9kUf0IoiQJ?=
 =?us-ascii?Q?/FVgnyAlj7e8Fz0bOoFaYr42k0ONdWyh9XJPyImCB79EbwjsXT88q/6xsr2w?=
 =?us-ascii?Q?hPEUu3WivdwI1SSpHDlpoUBjUoURD4zLqJy7XD7MwEkxwuV11KJvvanfN4QK?=
 =?us-ascii?Q?7JTnqbMU1gpmETxt+gm9Zv2hTAgSbOqgafhiDqWvMKH9w/w5JA2I6Ezxiwq0?=
 =?us-ascii?Q?oLn65R+qVxdrmapk1EvUka4wN5RIhSYBX8HffCreIpz8KF2q1zZWvWoUZfIZ?=
 =?us-ascii?Q?7lUh9nH34YATNo+TkixaNuPvjVU6BpNyWH1uVE0F52vUCnpPUpX1iNUJ6d/V?=
 =?us-ascii?Q?6hN6OnCmJVceBmtXt5lXlMWuWPZ7DWeaG9jsqWL1gqycZq70Z89Lv4m0oMd2?=
 =?us-ascii?Q?s7/RJO+ukIsXeQOUyq+J1KvVz/pXCAyddCVgWtLBPsxI0XfIiU9200U2HAqP?=
 =?us-ascii?Q?byHoAoviiogzYOCAM0A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a1b4cb-74a6-49c4-ac9e-08dbdc8c3a8f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:04.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAlrJ5w6ej9UzwpGU/W6v0z8DdqqDtwFrFeXMlYFZcGIb+Ra7L+BJgvgK4+5C+yr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

This call chain is using dev->iommu->fwspec to pass around the fwspec
between the three parts (acpi_iommu_configure(), acpi_iommu_fwspec_init(),
iommu_probe_device()).

However there is no locking around the accesses to dev->iommu, so this is
all racy.

Allocate a clean, local, fwspec at the start of acpu_iommu_configure(),
pass it through all functions on the stack to fill it with data, and
finally pass it into iommu_probe_device_fwspec() which will load it into
dev->iommu under a lock.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 39 ++++++++---------
 drivers/acpi/scan.c       | 89 ++++++++++++++++++---------------------
 drivers/acpi/viot.c       | 44 ++++++++++---------
 drivers/iommu/iommu.c     |  5 +--
 include/acpi/acpi_bus.h   |  8 ++--
 include/linux/acpi_iort.h |  3 +-
 include/linux/acpi_viot.h |  5 ++-
 include/linux/iommu.h     |  2 +
 8 files changed, 97 insertions(+), 98 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6496ff5a6ba20d..accd01dcfe93f5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1218,10 +1218,9 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
 }
 
-static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
-			    u32 streamid)
+static int iort_iommu_xlate(struct iommu_fwspec *fwspec, struct device *dev,
+			    struct acpi_iort_node *node, u32 streamid)
 {
-	const struct iommu_ops *ops;
 	struct fwnode_handle *iort_fwnode;
 
 	if (!node)
@@ -1239,17 +1238,14 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 	 * in the kernel or not, defer the IOMMU configuration
 	 * or just abort it.
 	 */
-	ops = iommu_ops_from_fwnode(iort_fwnode);
-	if (!ops)
-		return iort_iommu_driver_enabled(node->type) ?
-		       -EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
+	return acpi_iommu_fwspec_init(fwspec, dev, streamid, iort_fwnode,
+				      iort_iommu_driver_enabled(node->type));
 }
 
 struct iort_pci_alias_info {
 	struct device *dev;
 	struct acpi_iort_node *node;
+	struct iommu_fwspec *fwspec;
 };
 
 static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
@@ -1260,7 +1256,7 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 
 	parent = iort_node_map_id(info->node, alias, &streamid,
 				  IORT_IOMMU_TYPE);
-	return iort_iommu_xlate(info->dev, parent, streamid);
+	return iort_iommu_xlate(info->fwspec, info->dev, parent, streamid);
 }
 
 static void iort_named_component_init(struct device *dev,
@@ -1280,7 +1276,8 @@ static void iort_named_component_init(struct device *dev,
 		dev_warn(dev, "Could not add device properties\n");
 }
 
-static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
+static int iort_nc_iommu_map(struct iommu_fwspec *fwspec, struct device *dev,
+			     struct acpi_iort_node *node)
 {
 	struct acpi_iort_node *parent;
 	int err = -ENODEV, i = 0;
@@ -1293,13 +1290,13 @@ static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
 						   i++);
 
 		if (parent)
-			err = iort_iommu_xlate(dev, parent, streamid);
+			err = iort_iommu_xlate(fwspec, dev, parent, streamid);
 	} while (parent && !err);
 
 	return err;
 }
 
-static int iort_nc_iommu_map_id(struct device *dev,
+static int iort_nc_iommu_map_id(struct iommu_fwspec *fwspec, struct device *dev,
 				struct acpi_iort_node *node,
 				const u32 *in_id)
 {
@@ -1308,7 +1305,7 @@ static int iort_nc_iommu_map_id(struct device *dev,
 
 	parent = iort_node_map_id(node, *in_id, &streamid, IORT_IOMMU_TYPE);
 	if (parent)
-		return iort_iommu_xlate(dev, parent, streamid);
+		return iort_iommu_xlate(fwspec, dev, parent, streamid);
 
 	return -ENODEV;
 }
@@ -1322,15 +1319,16 @@ static int iort_nc_iommu_map_id(struct device *dev,
  *
  * Returns: 0 on success, <0 on failure
  */
-int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
+int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *dev,
+			    const u32 *id_in)
 {
 	struct acpi_iort_node *node;
 	int err = -ENODEV;
 
 	if (dev_is_pci(dev)) {
-		struct iommu_fwspec *fwspec;
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
-		struct iort_pci_alias_info info = { .dev = dev };
+		struct iort_pci_alias_info info = { .dev = dev,
+						    .fwspec = fwspec };
 
 		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
 				      iort_match_node_callback, &bus->dev);
@@ -1341,8 +1339,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
 
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (fwspec && iort_pci_rc_supports_ats(node))
+		if (iort_pci_rc_supports_ats(node))
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 	} else {
 		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
@@ -1350,8 +1347,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 		if (!node)
 			return -ENODEV;
 
-		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
-			      iort_nc_iommu_map(dev, node);
+		err = id_in ? iort_nc_iommu_map_id(fwspec, dev, node, id_in) :
+			      iort_nc_iommu_map(fwspec, dev, node);
 
 		if (!err)
 			iort_named_component_init(dev, node);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fbabde001a23a2..1e01a8e0316867 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1543,74 +1543,67 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 }
 
 #ifdef CONFIG_IOMMU_API
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
+int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
+			   u32 id, struct fwnode_handle *fwnode,
+			   bool iommu_driver_available)
 {
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
+	int ret;
 
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &id, 1);
-
-	return ret;
-}
-
-static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return fwspec ? fwspec->ops : NULL;
+	ret = iommu_fwspec_assign_iommu(fwspec, dev, fwnode);
+	if (ret) {
+		if (ret == -EPROBE_DEFER && !iommu_driver_available)
+			return -ENODEV;
+		return ret;
+	}
+	return iommu_fwspec_append_ids(fwspec, &id, 1);
 }
 
 static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
-	const struct iommu_ops *ops;
+	struct iommu_fwspec *fwspec;
 
-	/*
-	 * If we already translated the fwspec there is nothing left to do,
-	 * return the iommu_ops.
-	 */
-	ops = acpi_iommu_fwspec_ops(dev);
-	if (ops)
-		return 0;
+	fwspec = iommu_fwspec_alloc();
+	if (IS_ERR(fwspec))
+		return PTR_ERR(fwspec);
 
-	err = iort_iommu_configure_id(dev, id_in);
-	if (err && err != -EPROBE_DEFER)
-		err = viot_iommu_configure(dev);
+	err = iort_iommu_configure_id(fwspec, dev, id_in);
+	if (err == -ENODEV)
+		err = viot_iommu_configure(fwspec, dev);
+	if (err == -ENODEV || err == -EPROBE_DEFER)
+		goto err_free;
+	if (err)
+		goto err_log;
 
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * iommu_probe_device() call for dev, replay it to get things in order.
-	 */
-	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
-
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		return err;
-	} else if (err) {
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return -ENODEV;
+	err = iommu_probe_device_fwspec(dev, fwspec);
+	if (err) {
+		/*
+		 * Ownership for fwspec always passes into
+		 * iommu_probe_device_fwspec()
+		 */
+		fwspec = NULL;
+		goto err_log;
 	}
-	if (!acpi_iommu_fwspec_ops(dev))
-		return -ENODEV;
-	return 0;
+
+err_log:
+	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+err_free:
+	iommu_fwspec_dealloc(fwspec);
+	return err;
 }
 
 #else /* !CONFIG_IOMMU_API */
 
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
+int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
+			   u32 id, struct fwnode_handle *fwnode,
+			   bool iommu_driver_available)
 {
 	return -ENODEV;
 }
 
-static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
-						       const u32 *id_in)
+static const int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
-	return NULL;
+	return -ENODEV;
 }
 
 #endif /* !CONFIG_IOMMU_API */
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index c8025921c129b2..33b511dd202d15 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -304,11 +304,9 @@ void __init acpi_viot_init(void)
 	acpi_put_table(hdr);
 }
 
-static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
-			       u32 epid)
+static int viot_dev_iommu_init(struct iommu_fwspec *fwspec, struct device *dev,
+			       struct viot_iommu *viommu, u32 epid)
 {
-	const struct iommu_ops *ops;
-
 	if (!viommu)
 		return -ENODEV;
 
@@ -316,19 +314,20 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
 	if (device_match_fwnode(dev, viommu->fwnode))
 		return -EINVAL;
 
-	ops = iommu_ops_from_fwnode(viommu->fwnode);
-	if (!ops)
-		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
-			-EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
+	return acpi_iommu_fwspec_init(fwspec, dev, epid, viommu->fwnode,
+				      IS_ENABLED(CONFIG_VIRTIO_IOMMU));
 }
 
+struct viot_pci_alias_info {
+	struct device *dev;
+	struct iommu_fwspec *fwspec;
+};
+
 static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
-	struct device *aliased_dev = data;
+	struct viot_pci_alias_info *info = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -339,14 +338,15 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(aliased_dev, ep->viommu,
-						   epid);
+			return viot_dev_iommu_init(info->fwspec, info->dev,
+						   ep->viommu, epid);
 		}
 	}
 	return -ENODEV;
 }
 
-static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
+static int viot_mmio_dev_iommu_init(struct iommu_fwspec *fwspec,
+				    struct platform_device *pdev)
 {
 	struct resource *mem;
 	struct viot_endpoint *ep;
@@ -357,8 +357,8 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
 
 	list_for_each_entry(ep, &viot_mmio_endpoints, list) {
 		if (ep->address == mem->start)
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
-						   ep->endpoint_id);
+			return viot_dev_iommu_init(fwspec, &pdev->dev,
+						   ep->viommu, ep->endpoint_id);
 	}
 	return -ENODEV;
 }
@@ -369,12 +369,16 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
  *
  * Return: 0 on success, <0 on failure
  */
-int viot_iommu_configure(struct device *dev)
+int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev)
 {
-	if (dev_is_pci(dev))
+	if (dev_is_pci(dev)) {
+		struct viot_pci_alias_info info = { .dev = dev,
+						    .fwspec = fwspec };
 		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, dev);
+					      viot_pci_dev_iommu_init, &info);
+	}
 	else if (dev_is_platform(dev))
-		return viot_mmio_dev_iommu_init(to_platform_device(dev));
+		return viot_mmio_dev_iommu_init(fwspec,
+						to_platform_device(dev));
 	return -ENODEV;
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 15dbe2d9eb24c2..9cfba9d12d1400 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2960,9 +2960,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return ops;
 }
 
-static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
-				     struct device *dev,
-				     struct fwnode_handle *iommu_fwnode)
+int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device *dev,
+			      struct fwnode_handle *iommu_fwnode)
 {
 	const struct iommu_ops *ops;
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 254685085c825c..70f97096c776e4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -12,6 +12,8 @@
 #include <linux/device.h>
 #include <linux/property.h>
 
+struct iommu_fwspec;
+
 /* TBD: Make dynamic */
 #define ACPI_MAX_HANDLES	10
 struct acpi_handle_list {
@@ -625,9 +627,9 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops);
+int acpi_iommu_fwspec_init(struct iommu_fwspec *fwspec, struct device *dev,
+			   u32 id, struct fwnode_handle *fwnode,
+			   bool iommu_driver_available);
 int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1cb65592c95dd3..80794ec45d1693 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -40,7 +40,8 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
-int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
+int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *dev,
+			    const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
index a5a12243156377..f1874cb6d43c09 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -8,11 +8,12 @@
 #ifdef CONFIG_ACPI_VIOT
 void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
-int viot_iommu_configure(struct device *dev);
+int viot_iommu_configure(struct iommu_fwspec *fwspec, struct device *dev);
 #else
 static inline void acpi_viot_early_init(void) {}
 static inline void acpi_viot_init(void) {}
-static inline int viot_iommu_configure(struct device *dev)
+static inline int viot_iommu_configure(struct iommu_fwspec *fwspec,
+				       struct device *dev)
 {
 	return -ENODEV;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c5a5e2b5e2cc2a..27e4605d498850 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -688,6 +688,8 @@ void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
 int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 			  struct fwnode_handle *iommu_fwnode,
 			  struct of_phandle_args *iommu_spec);
+int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device *dev,
+			      struct fwnode_handle *iommu_fwnode);
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
-- 
2.42.0


