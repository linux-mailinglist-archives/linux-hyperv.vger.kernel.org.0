Return-Path: <linux-hyperv+bounces-941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708557EC470
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 15:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934D31C20AE4
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E62027701;
	Wed, 15 Nov 2023 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k/hMNTX1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F1208BD;
	Wed, 15 Nov 2023 14:06:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8A10F;
	Wed, 15 Nov 2023 06:06:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhko5mMl7wwgTLTUrY0NjFuAcaUZCb8Me/bFaZ6MSfLcqj18msBuRFbxqWhdmG5QAyKAQXmJfT3jWzMUBSxKvTiy8nneT4EfIVqFzq8b07Kerm6103C0AaG6gYQuCrmhDZ/n2LH9RmsarDubQEy0RCJaRw/6E3hp6xACszDtHBIUQs2RQhMkPAOKd1SxAXfKtktN9kTZQWxrEWbOPKs0vxQs57QBleRHKGqlatDm4R2XPFKQwjmzVplc2NwEQpmc/whwGqzP6CUqJKZR1zdIsNQZse81jco3CzTSijRXZgbwsVLdi6hsh9kMcDbeYUdvMrja1ROVOxIIxUxnFMitWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIb6RnEaNKCn733G/9vlP7n3UZbHFQtlxgPESmxTBWY=;
 b=H49dEjiiNsS/wSr1EZeGfZo6XmEIvNcD98lb+2/hqneRHsNe/fHM9AjTUGzGAeNmj/l0OfbLHYVrhUg0AswHpKMiHE6G+EqSXtgsa8A7UNMznpngzJclAXDBvbsuDa0dOWmQwsU3V76cE+8023XV8sLV9BNEFcoVm5/WTNf10IB8pr52PlzJTdTHLl+VTzIyxHB/VkUkMN85ptOrbnwlpy0N2B3wN1QAmzGapr6lFaXr3qBHnodauOaP2eSTvp6Cq3ju3D8hLB1O1pVKvsoiF9rk2rIhkYb/5DFG9hOt+MsqOWZkmew+ddJNGWEn4e9dJOUbMaszB2AHFzFL2aA/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIb6RnEaNKCn733G/9vlP7n3UZbHFQtlxgPESmxTBWY=;
 b=k/hMNTX1ZRcLYfypCF0pXir+fz/2kC1DSbOScNBSG/FMdNVM2RL1Y6c1Tnzt4ngQ3egsFQrv8lfY3Wg6/UoolIiBZy4HTXa8YAAKd2+/L7LKdGPlsHR5TgjkbogRxutw8U5amHzpaS0tNysRuqRB2BpQ1mOvhiZ4J4SWhxWMu+Rp3qU6PLOrHoMwI4s6a4w7lxE4zV5rtTSDSkSWnHXV0125caKM09Bl5Sgbx1DEoeETsfCNAkradOPDe4thYT+fJmfPynumuw7cPQvjDlf24fVYWgJX8Ax3cAeadABwfZGBGedhT/3SR5lm/ZJ690H1dLA9I7W0C/z9RX6WEiFgpw==
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
Subject: [PATCH v2 09/17] iommu: Add iommu_fwspec_append_ids()
Date: Wed, 15 Nov 2023 10:06:00 -0400
Message-ID: <9-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:208:120::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ad3f50-13aa-4549-3376-08dbe5e404cd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rIiay2NCxliPyHXv5Jhwhak+QEYovlcgLHri+HBj/lqJ/Huss/R/N+al8tHiQlnRxqXZ4NjfGZZ1MGBHqDkiXDID+E2AsjzbvJ0xS62Lh1HW6UzqCLB9Lgm4QbsDmf2h8Amr6QRrlaIbb0AM/5b9iB4IMWFBEPfCZjaNedLZyuegJKMljY02boJWIjoUUsU0JHj9dwHU/O2efZGC5uRC9BNEpCyJ+5kDIV4+6cALC1V1wMVbvvdua1kmzgU/mjcbDzFVoZM7eLvIuw0EUCmCoRsBGlRuT3L9JcOA0D+HAfEX1NHPPAiUXi02ERy/jLWGZ/uRkgsbzWxr/g43yu5SWbX6zY8CRjEal58+yVQSApnopIx9tSW7T0ksl5QBVbgnLu5cS0bmXEM5MJ5HgOgKLCpFFSzOZsCHphdbPx7ouCWP/8bVlx2wPd7YgzVHf/Lp7hv1X5RFtxZSNjo0N+KpgtYJ3dECigyW7h6Na1w7zNpqiRPmWEhPmt9O43Wr1sJu4uQzBgeyCiytVt89+qgrBLGdxJa/OohzQftSkI4F1Liiv+ene+PXlCNLvQlFuG7ZwHl5BVF7nj1kEc+lkctetXSVRBpsB0FxsmSwkppW+dBQ8+iUnWCiTTSRuwg3QRCS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7406005)(6666004)(6506007)(2616005)(6512007)(83380400001)(7416002)(41300700001)(8676002)(5660300002)(4326008)(7366002)(8936002)(478600001)(2906002)(6486002)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(86362001)(36756003)(38100700002)(26005)(921008)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TTFO2FTfQnEJbkqUqgYbWqZACAHaI36v/Mm2uGf08oXgabC3v+jwv8d67nHd?=
 =?us-ascii?Q?AGcRYgqwdzavYTohdSde8add8Cniz6YcYsP3B2xnbxUmQ0ZfTSZl6Qs/ZzxX?=
 =?us-ascii?Q?/ZuAx2qUjcf0pVOFzNFmUSZh1osEH5TTpnnzvt10njccKIWtoIpEYik9uHI4?=
 =?us-ascii?Q?k1GQljoclmXJ7VkQEyIhbNsugDM3sJhBnt0X93RZnlCKphPwinIvXZ2IgVse?=
 =?us-ascii?Q?iwmtaOADV9FMyA4eZtDmE6wa3ZWQmEiDgiHra+OibjOktslUo8R/6eMmYmNy?=
 =?us-ascii?Q?oHESHZK0D/55ITnl1W5q/JbRt1wP1l8eiHhZrFtN31wZTPFYBFvPgXynD0sK?=
 =?us-ascii?Q?bNl/C5p2LtFsze0WvZXAOuT17WE0K4HSp2xUzfb13uu3Hnu90EmBs8hWQ/4Z?=
 =?us-ascii?Q?WX8QTLb6Ps8kqB2HjfABJrBP3NYJdvP73/nEM5J65TgsWWQyi/1V4/1tJt95?=
 =?us-ascii?Q?8Cj9CQNp684igGyd71fLVz2EfIZ/wPLMqyoekCsVqd+tadKqTiypO2yjtmZw?=
 =?us-ascii?Q?FNyvHXStdTTwj/Mlh4S8A4tF5TxjIDXCKuusIp/Da2ltYuzhoDvFf1GkiS0f?=
 =?us-ascii?Q?iz6V8iecQEVFVuvig8EEov4BAIQXDNaTyqS4DvhBCVBgBL6jmiTJjQnPOmMa?=
 =?us-ascii?Q?uZUBJGFjgnRATmxEmAQkbsEzsw9bz7hoHYqCNiax2V91jg4DLxegJJKv1mhI?=
 =?us-ascii?Q?J2VF+2ns8yeZAG/V3glnuNXFZzshR+iK83F/Z/U3QCfgoe+qg5+1Smg1ncvL?=
 =?us-ascii?Q?rGMK9H+GnOdC9eBVpezTXZ2II6yo2VIELmOiXh24MrzLrihdJ4RuNuI3QUha?=
 =?us-ascii?Q?+Gwrs8+Rz+8sCt4Lv2j0s47CS/6PYQHifEH73rlh+nZK0LSizFKCigzoEeAa?=
 =?us-ascii?Q?7XT5v61rf0grKRzxmagxJhHtAgSnJLKTST+GPtUowW34KApl9Ybfb8xXHj/S?=
 =?us-ascii?Q?5sYJ/RfgHacngV5F2gBqBXhw9jo7AH7/wVyuDvCXsYjGIw1FYw4KBK5wPGIs?=
 =?us-ascii?Q?BTdJtLTzZszzx993+7GNi3KRK3mmqdm335PPtw1NjDuYWiBTS/CmtYd2AOP7?=
 =?us-ascii?Q?lV0wbi5aVN1kKCbcCeioel+9jLxOq/A1P8TVIaaAwbVDYXm+QP/02jxzi4FA?=
 =?us-ascii?Q?/ulgFhvgndOLuaRmWXI2qNU8n/hw74IaHdJEoW5gRXoXkZLwoPvINkfM/jrv?=
 =?us-ascii?Q?qpz8jiJpZ7vvO7sm+DR6WN32xst7e0VyAHpPF6yu6eam9LA6IX3fw/hHZohN?=
 =?us-ascii?Q?g/3Ak2l397wYy4zyIE2jVgSazZ33O87Av2W/Ann2dMkYtVXSXZbWvxEacjC4?=
 =?us-ascii?Q?V3Ge8sZQBNBXswryKZDwPrvBYiDr/NYINsog0m6CJpGsKs6LBtfHVbxoadD4?=
 =?us-ascii?Q?1dS8tScxnDJB8baLbNCHf9ImN8N9zeD+yuI7VOrGLm0LPc+ISTvgHbR/9RoJ?=
 =?us-ascii?Q?kV3ksB/JAKadbwNg2153ZRkgM2/90mirwJJizPT34lEkXQAFHGJghio9vqjo?=
 =?us-ascii?Q?MgTw5ofzgI6EJA2628yJRJNs20dsTgdiFPGX5ekdtjFy2ed6k71oFX45gPSL?=
 =?us-ascii?Q?sob8LQfscJp2mPEnIDE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ad3f50-13aa-4549-3376-08dbe5e404cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:10.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUFWjpVht75NL7joEA7Pd7bn/x6kguLYegv2d8j4HF4nChVq2doVAG4uHXBIIK6V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

This is a version of iommu_fwspec_add_ids() that takes in the fwspec as an
argument instead of getting it through dev->iommu.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 17 +++++++++++------
 include/linux/iommu.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 108922829698e9..2076345d0d6653 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3050,15 +3050,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
 
-
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i, new_num;
 
-	if (!fwspec)
-		return -EINVAL;
-
 	new_num = fwspec->num_ids + num_ids;
 	if (new_num <= 1) {
 		if (fwspec->ids != &fwspec->single_id)
@@ -3080,6 +3075,16 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	fwspec->num_ids = new_num;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iommu_fwspec_append_ids);
+
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return -EINVAL;
+	return iommu_fwspec_append_ids(fwspec, ids, num_ids);
+}
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
 /*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cea65461eed01c..bbbba7d0a159ba 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -830,6 +830,7 @@ static inline void iommu_fwspec_free(struct device *dev)
 }
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
+int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
-- 
2.42.0


