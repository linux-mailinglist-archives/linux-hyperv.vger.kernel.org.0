Return-Path: <linux-hyperv+bounces-945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E2C7EC47B
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773161C20BA0
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8E28DBF;
	Wed, 15 Nov 2023 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OQnrHjel"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEB2511F;
	Wed, 15 Nov 2023 14:06:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C4121;
	Wed, 15 Nov 2023 06:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0xRciVx5wIb52zhoNAJFhsz2XtcORB2OjvhhXL7Q0IdjryUwZsis3apmd9YjMkLOj4SNuYh5ceM3URRkm/cbsnw3g3n3ad+cixE73ZE0EJ7ysR3J4H/ZMoM9a/oejbSEtvxZv2ao2Gvx+tu9YOMrYUDXq8jdlpFOk0wSlFlPTNPst/vGcTfpkSufcEOTIxCchUFQ5cYkQGyt8jbkVJ5i6Jp1HLQ5u3P0B1R5dzbYEzcq+ek5jBocKynfXZszR6V/H9UbGTlgYspIFzsygge0EKGGlBNamxfr1hKK6zyRGkk/Civ9Mwn3ZAEVLDLuVt/npEzUPvlVg46qDOXiAmy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UE+kSXHFC8dPzv69o9Be8MVfhBfi9mPIbzznm+uZ34=;
 b=NqWTKk+LwhP1t24sy8dleAQgEfwJIM7bnsvDt2kngyZ5WcCCsotpYSGDcvTbfkA2StcSLT8o1ScH3crFgh9qm/gYZZJAzB+cgy+FZWUSc5ZN4SkEEw/kJ+QjFoM5k0uoZmAt7LKOtNKYulGfaRUnVMOCwh5XFF6ZUE7Xx3yd06pJ5/0Ql9jiQyY2iejFEtmdvklYElKGCHmD4MSsL4dXsHhS4JecOwnNWl4Q7m8W6L2kJNdAU1Vniqw7nNVcFhV70M0+4Ob6vRT5TnDVUqj0DoylGS6IpNWLR3JEoxYGGl2nqf2V9j6zRIyo5+I9bOQWEKtfVpDJZZ2WJp4Jkqpi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UE+kSXHFC8dPzv69o9Be8MVfhBfi9mPIbzznm+uZ34=;
 b=OQnrHjelWRBJrT7THr3RPu0FeEIvzt0Yj9HZja0u23/Onm+FsfUsiZJR4rxsBhOttmYRzpBekFYevhh/NhzN1z6NR8gJ4r//ouvSarZD3Tz47ZjMi8PXmko6JYruE1LcAucJAcMbjoMXxD50L6AnTBWUyxZIvlayKn7/U4cWS83LyvS8e4GKpl3Yf/RE/jRqobI0Vc0ubJTZ3z/QVNKYLgGDAxYYAA3I8QEmVp+e19uZHImSrHZyJI8tfXL0W4glUBcO+8/mnnwJlQYy0IckqlpczrtwPbEphMTH5B+Mmk4BSfKgULYA5BaHARLeILEDioQdBlUkN50cFyT6LrsrMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:06:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:06:12 +0000
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
Subject: [PATCH v2 10/17] acpi: Do not use dev->iommu within acpi_iommu_configure()
Date: Wed, 15 Nov 2023 10:06:01 -0400
Message-ID: <10-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a99af8-b0d5-4ba6-6eb4-08dbe5e404c8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y+g5ujmOvADA+qA01aKR/BKZhSB70UQV949rqZj2tFFwXYkR+gzCxPIirJQec7pjQzenGHr1dTq4Bo2yMOd3faqHzxT1kDnekGGtoKRmn+aCYRQ+aNgFdu3Y99zE471QJ8va1G6joylQT3W1BtxBnyuGGt0qDMjpYUEeKa54HLKIn9nwFyxU9sZSTKmoKxZkjCit3eV+O08bkKLyOxLlTwjMEhhJPs5a30klalWSNbY/WPGMIBrYuvBxlGUlCw3Go2VKZysSExX70xkDnJF/dcxBBISu294RQZUWIieiI1naI4WasKbTiB5MASDYYIFH5xQQlbCHwqRLOS5Qghrg2WR04v+WkoKUnTblRjJol8AgRc/vP/s9vzt/qr2Ug2EqV89vrZk9f0BgfWkXASZjMzk6vBzymU691010PtFZRGS2B76Wki94wFkq9+/Cc7ekIw0tUIHQY85a5jSvKmOjxlyplS4oksCgZryR6s0ictADrlnp9CKocFfe/8jDqnuViHpfmkUoOXA+FnMfaVYQG+NxTZpHbgveBvy3Y+X4wSuQ3p31FUiT/uXP4RW8q91Z1kQOPUFuDag8OumrsTqRnmRlqN8DC+vhivbgQ4jvWvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(30864003)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UCuUwAAUvi/5hac/d8zjw7xI7wl+iPS6zFmKYu552PtLBq2Q9UZxv3aAWyU?=
 =?us-ascii?Q?iGILMpi5QmObIKDrdjSCqC0i3suqGqugOWzzknYDjaatKDYQ7SiUZZB4yY7B?=
 =?us-ascii?Q?6KwYopgLeDOgg9wyrNoaRfvE/P31Oag7uvdsXQ22xh+ixGMKjhOyrYBLKdPW?=
 =?us-ascii?Q?CnufalR9QSQdlEYN5iE6SIfz98kdjK4v+UujntbWdPFSZLTIxASkPc65WyBy?=
 =?us-ascii?Q?yMezeKxSUI7ZSlBRTpBbuBloVpxnJaJxaPec0lDyEU3O7j3Rr10Sasd7IAGS?=
 =?us-ascii?Q?b8hvVKw4v9u05LNCepya4lrYm+DF+2bKWhTVetoiQ7YrQLJU20B+P1miftj4?=
 =?us-ascii?Q?7+AAlINHeNShfqukvX1kbZQybLdurM5YA/bLzWSMV3vGfEBBRAlcztqoVMcy?=
 =?us-ascii?Q?/83CmiJWbnI1qguRX51AJH+d2Vbd1+QzRGwhOcfbmDlBSo+1tF8+vn5y2vEq?=
 =?us-ascii?Q?KndOAVjkzjlu/Lgbbfgqc/0DUEYDYdNSnKF5QT20V/Rq70du5cpyWOzrjn28?=
 =?us-ascii?Q?J8S/o+l5M04jK8bIjk7eMO0AEIiPltF4vTekorkzfVCHFy3CKq8I+4efRHK0?=
 =?us-ascii?Q?6g0wA6LcFuAvNbdrzedVMwTGc0PfEOo2wsPduh7lSZCMRtEWj4xNWcsyCCY4?=
 =?us-ascii?Q?PY3aPzzz8MJy0u8JfetW9+pI/hkCCaahty5VD2TMzR9wZDnBmotFxvsV+JiM?=
 =?us-ascii?Q?yH1Dx+bL7luKY3FLRaLcNLTK3GDDu5wrI118Ye0K7m7jLaTl1JwHvKpF9b4i?=
 =?us-ascii?Q?dZI+JQk+wruwi1i28iLhYUzV5vPjncE5jM4sB1hABy/NS2/Zv8/s5U+BhzV1?=
 =?us-ascii?Q?W4r52G9z/OLQzMFsRDB4j1EtfTBgn9VzcO66qN7QIp/KuH5ErlVX/lSTAbx+?=
 =?us-ascii?Q?7cDI8Tbbji+GYWTXnD792qDmHE7GulOV7/ElY9RlMu9XK+Y4jutpahHD2czl?=
 =?us-ascii?Q?bEcCP5cEYgrFqnT2nbNdjvo2hKLh/pp6h9psisxPZIGV/ceMNroVLjOU1ouP?=
 =?us-ascii?Q?t/XzxojSb9sv85kNm5O4aSDQi+4GQfVj9ZP5fOmveHhpk9nNPPYa1YHlx35n?=
 =?us-ascii?Q?vyM6qBPOnOcGIylfZ+B17VL43Q3YWxRptr3Bjw6900dtrZk8KJT+T7nF/s6Y?=
 =?us-ascii?Q?dnulS97ODBMsCGTq2yQqoEimOZFcuYesafgDI/ai52QoLqbNgOJcLkcQJGpU?=
 =?us-ascii?Q?f7MwKjQEizOZ6PEVXOpN4esqnOh/w5pB3XZGSrU4DA+UCsBF8UCujmfjZiWQ?=
 =?us-ascii?Q?3Pb6jUoiMfJU0mR49IdSDCR+Rvup2W5Dzbr+oF9QdbUVnt6PV4qOugsk17gF?=
 =?us-ascii?Q?/5p0QQixtPtjLTaH/v11i06PYyu0WRzrWzrgSWu6rYCw1/4X4njBhjXPVu29?=
 =?us-ascii?Q?bnqdGUV5IIC9Z+AUabyq9DaHYfNaK2Hb1b+05+Weekn12+z9LyihnXTPEl1R?=
 =?us-ascii?Q?ef9fusCOInvowZhVNK2FzDt3QBEgdIpMbNxOYviXqZGLnrYyhYlL2OLqO0G0?=
 =?us-ascii?Q?zJ621fiu0PViHmWTByw02zr4GYgzoNX3MaTuwz4D3q9GD5/se47uWeAqpcX2?=
 =?us-ascii?Q?MWS4H9CMqM7CKyS5pr4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a99af8-b0d5-4ba6-6eb4-08dbe5e404c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJHwmDGFKgtBAjP5g3TK/Gq5bA66/g1pHAKrclSsxUnncSaIZjZBBsCqmdG7VGi6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

This call chain is using dev->iommu->fwspec to pass around the fwspec
between the three parts (acpi_iommu_configure_id(),
acpi_iommu_fwspec_init(), iommu_probe_device()).

However there is no locking around the accesses to dev->iommu, so this is
all racy.

Allocate a clean, local, fwspec at the start of acpi_iommu_configure_id(),
pass it through all functions on the stack to fill it with data, and
finally pass it into iommu_probe_device_fwspec() which will load it into
dev->iommu under a lock.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 42 +++++++++---------
 drivers/acpi/scan.c       | 89 ++++++++++++++++++---------------------
 drivers/acpi/viot.c       | 45 +++++++++++---------
 drivers/iommu/iommu.c     |  5 +--
 include/acpi/acpi_bus.h   |  8 ++--
 include/linux/acpi_iort.h |  8 +++-
 include/linux/acpi_viot.h |  5 ++-
 include/linux/iommu.h     |  2 +
 8 files changed, 103 insertions(+), 101 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6496ff5a6ba20d..b08682282ee5a7 100644
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
@@ -1317,20 +1314,22 @@ static int iort_nc_iommu_map_id(struct device *dev,
 /**
  * iort_iommu_configure_id - Set-up IOMMU configuration for a device.
  *
+ * @fwspec: The iommu_fwspec to fill in with fw information about the device
  * @dev: device to configure
  * @id_in: optional input id const value pointer
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
@@ -1341,8 +1340,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
 
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (fwspec && iort_pci_rc_supports_ats(node))
+		if (iort_pci_rc_supports_ats(node))
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 	} else {
 		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
@@ -1350,8 +1348,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 		if (!node)
 			return -ENODEV;
 
-		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
-			      iort_nc_iommu_map(dev, node);
+		err = id_in ? iort_nc_iommu_map_id(fwspec, dev, node, id_in) :
+			      iort_nc_iommu_map(fwspec, dev, node);
 
 		if (!err)
 			iort_named_component_init(dev, node);
@@ -1363,8 +1361,6 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 #else
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
-int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
-{ return -ENODEV; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d171d193f2a51c..5d467ff58ff24b 100644
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
+static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
-	return NULL;
+	return -ENODEV;
 }
 
 #endif /* !CONFIG_IOMMU_API */
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index c8025921c129b2..1d0da99e65e6af 100644
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
@@ -357,24 +357,29 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
 
 	list_for_each_entry(ep, &viot_mmio_endpoints, list) {
 		if (ep->address == mem->start)
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
-						   ep->endpoint_id);
+			return viot_dev_iommu_init(fwspec, &pdev->dev,
+						   ep->viommu, ep->endpoint_id);
 	}
 	return -ENODEV;
 }
 
 /**
  * viot_iommu_configure - Setup IOMMU ops for an endpoint described by VIOT
+ * @fwspec: The iommu_fwspec to fill in with fw information about the device
  * @dev: the endpoint
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
index 2076345d0d6653..f7bda1c0959d34 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2943,9 +2943,8 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
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
index afeed6e72049e4..4197c0004a30b0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -12,6 +12,8 @@
 #include <linux/device.h>
 #include <linux/property.h>
 
+struct iommu_fwspec;
+
 struct acpi_handle_list {
 	u32 count;
 	acpi_handle* handles;
@@ -628,9 +630,9 @@ struct acpi_pci_root {
 
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
index 1cb65592c95dd3..7644922ecb0705 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -11,6 +11,8 @@
 #include <linux/fwnode.h>
 #include <linux/irqdomain.h>
 
+struct iommu_fwspec;
+
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
 
@@ -40,7 +42,8 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
-int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
+int iort_iommu_configure_id(struct iommu_fwspec *fwspec, struct device *dev,
+			    const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
@@ -57,7 +60,8 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *hea
 /* IOMMU interface */
 static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 { return -ENODEV; }
-static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
+static inline int iort_iommu_configure_id(struct iommu_fwspec *fwspec,
+					  struct device *dev, const u32 *id_in)
 { return -ENODEV; }
 static inline
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
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
index bbbba7d0a159ba..72ec71bd31a376 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -818,6 +818,8 @@ void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
 int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 			  struct fwnode_handle *iommu_fwnode,
 			  struct of_phandle_args *iommu_spec);
+int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec, struct device *dev,
+			      struct fwnode_handle *iommu_fwnode);
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
-- 
2.42.0


