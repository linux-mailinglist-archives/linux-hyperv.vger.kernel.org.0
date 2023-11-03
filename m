Return-Path: <linux-hyperv+bounces-680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9C7E06EB
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 17:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B807F281ED1
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621E208A7;
	Fri,  3 Nov 2023 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWEkU7cB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CE1DFC0;
	Fri,  3 Nov 2023 16:45:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD04D49;
	Fri,  3 Nov 2023 09:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SulgikAxGxFWdHASWjrcdFM+KDM/5YCK+WhxmGXhv07rQdnjwnIDkZNXstLlDrIl8QCm/i0srIKTVCPWMWEyxlw+LZhDRl06F5z69fToiCTMSXRqaGB8nXfQqBXwXFPWLmtrxPfDzVpdDK0ldwGyId/uL2QwaUAauAiexrlrCZechBLMsQ0QSmy1GzBH4ngoiEj4cxWoGtyzmvnJmh9mU66EQYJ9d5wg24pw1h9u+hwyC+75RZRZouVU68r019NKVYTTks+5hOlRjhZNZkUHByaIoTbVg1DJYIk5yBO0q24JIUvWL+xzkcn1ssWzVxM8V4imRoSQClg9s46muFQcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdsjErMszebnmFtTb6/WTM+XmGNFE0IR3PzOJuy1VLM=;
 b=kM9zIaX9NOMqi1N9woTN7hVDJ/Xi/DXcJlWbmSreq4eX3mbKaoOhxuBCFwlA9e7aVs4VHZ7Tkqxe1It9gslLtaNzrI5wbs/8rVPur1Jh2K7OtZTOtvgDlXM30ianttlWtreOw4syZGXefnEiwzbaggg0ZhGAUSmP+zQzVMF3SfIhKAp6l1YwOo0O4MFi3yj0LrSNbGCCvrBXcbSFge6FdIj90xqWY+eIO8DM9HBeGsua0tGE56ZkaW/xwR6wjjxs18QmG7alCzc58ZEroO/wsiCQ0lNtPZwZ6rdMkOvklDxauE1tzzXtU+Nmgsaa/shT+RWxk3uqUdRzw1BtTsG+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdsjErMszebnmFtTb6/WTM+XmGNFE0IR3PzOJuy1VLM=;
 b=PWEkU7cBfCPLNRnK1t8TIeVVszN78B+1/T2c8D2S8TMSqYm/xDqeSvCuUImJ+GxGD/Ru08XM3LTkwtrh16+fjXNZ3uSJb+eoCeGJd6c+s6KXiCALJ8zLJhEQ8Qgoz0BzIKO7JbqI6mTcxJl28uyoJruZLT27o7Ba2aOcTsEDsS98DggVKzdDZWphA3K8eFl93iLqZHg3WBBM9w5+SX9cY2f7ZJP+YXYfk8PN7OBDclGaJOyIOVUakhEau604I32TrPUyec1ZqqXu1GkyCufkToIsoK9ofC+3cQDRW2HXNxRA6VHVhXwQLQx4XwZlJIL+Q9zyJ0jUASmQsIawWiqM5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 16:45:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 16:45:11 +0000
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
Subject: [PATCH RFC 03/17] of: Use -ENODEV consistently in of_iommu_configure()
Date: Fri,  3 Nov 2023 13:44:48 -0300
Message-ID: <3-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:208:2be::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9eba72-d890-4244-da24-08dbdc8c3bc0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3RYW1+fdG3jYxbYkDdXxmUXuFqfWVocaDWUAtB6tD2CEPwd4nfm0gPNvw7UVtN2sD+66LygKu6K0XfEVOhtpY1YdLCh2w/1I/48hyEw4uEXSCa49VSRKuA5nzcNXw8N/UExOiz634di7tx46JscgTT5yRQseEbaMWd6RMB+VO6F0WgCgPKcA7VnZQlHpahCPwzsbOLZmbW0bwQYE3z9/MXm5JUQ3WvrUuObdJTSbF0kd1svDTqeey+noRzojXEjaS2P9dN2hvLI7kVkaIAY7C5IVrDR5r+tLljrTBKhBKgJhXSJPQctybyPQ0MZQJ910a+s2s/WuzH2ijRnQwvIcLtFSs0YlzqX64CMEK3ySLbwjsy42lv4wjZfK/FKiNH+wegWTOjGIGm24L6uOyRjBNw2HH8nygJtPhDQ9FLrmkuocdWesQ8p0zSwE11QGWKCdA+Uu0fCJcJx/TA4PgTw594lqqpJ+K2v4iEK48JrtykAlxNx6Ea6ALMrc4B+/ykMk1ZdSLsfPEDvzyi0X1PyZeq+Te6eCbROd5GqkJHSY5z5/QRZXkYlMh+ulQ7Pr0zmZPn+leCRokv32COX/JlTS8+sSp5Q3aP5F7KVLxx0w1ec9gNufJgvAhWn8KP1xIEP3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(2616005)(36756003)(26005)(921008)(8676002)(4326008)(316002)(86362001)(6486002)(478600001)(41300700001)(66556008)(66476007)(66946007)(110136005)(6512007)(6506007)(8936002)(5660300002)(6666004)(7406005)(2906002)(7416002)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKZSSwajEKH+IWShhl71mjIvz5r5QO5EBJDeJi2fKVEAG49Fkw/CH6qg1PaT?=
 =?us-ascii?Q?6GyCWcKcEhSS2FM3RymDnG+JlPH1w6jZrEmojKs0sxVd0SLboyRgyYokAwiJ?=
 =?us-ascii?Q?guU7SbeM6n011r4R8o/wzKNpRirYocXBzaqEGRwEjSG0fGJLYsJPtPO3N27c?=
 =?us-ascii?Q?ygEhBtBf/Sx/gLoDDB1Z1V6Up2B+TDpV8i+p1IvCB2KZIHn9/ZK/i7SSkSZ5?=
 =?us-ascii?Q?bhBibUTEJrLh/0Ow4GEReVj9EFDghDvb4JAfhQ+mvSqJVR10izACiXhz+X+s?=
 =?us-ascii?Q?zUoOWE3C7ohdiRlQYhl13VXss2VVB8CB0QlSmvDK+AzfNmka53CRRnJi0dWH?=
 =?us-ascii?Q?MMljI+3mYdnOkdmp401V8yWhYX7MAJOijDCS/kBrrDDh/yDgY6IscSBy0e7k?=
 =?us-ascii?Q?o5Dgd7/HfSwnqC4WWbxUpvvv7AhTESpcssKGxdwulTmvaSYYzODSAjrT3B64?=
 =?us-ascii?Q?ANx8+rPji1llkDO6k6rnY3qpNxPJl8utb+S1xwO8bGwto9autER4KEyr7URD?=
 =?us-ascii?Q?NFjZqzmEmiysmIOW4hqcbtki5nZGnO614X6ErLTt5YY17oS7j0BG4l3ghVvr?=
 =?us-ascii?Q?IfZcdqhKqkloQ1Az2oJLcxExKKqKwqqLiiHgDqyi/sb3QDkonYyXT1aLRmz8?=
 =?us-ascii?Q?Ixjvsla7Gj4s1W279yLTdzPYZ8aJh6izVZUn5AZRRbJ1FXpuZBXC34fZGGop?=
 =?us-ascii?Q?FqnR53WVqzuRuNknQ/pui3s6aQwSruqUYUI3/otC1YAAUiHnqTSUAljt0gFD?=
 =?us-ascii?Q?8H/gYUjjZFgjc/C8brZ1ZeP5p4vS+Kq9ZVNpanIlCNCnpGTSMTwVRxI9AwD6?=
 =?us-ascii?Q?YqtXm9sFCWnXL8uEFY+TUikS5erGW6Nw/Rlg0hwXMP3I/0Ailai6dTaiHZTA?=
 =?us-ascii?Q?ljd0hEb7YfNm/P9wtzGWkSaEiVxJ5oObr4RiWyQ6fGvsrfH26fLnXomx33mO?=
 =?us-ascii?Q?JTVWzf4Yu7q5E4O62SaqM7UdyY2y18fFNfNEQX1psWp4uF9CeA/1UICq6Fxn?=
 =?us-ascii?Q?ugm9C3XM0gyXlD0UHBxel01VWcdKoEOdwxToKKwWgiE2e11gOJYLW5+mIPMe?=
 =?us-ascii?Q?2fspibMSq9P1HXxXsQyzTozxkppOVwibZwxIcyGcKT99dYsgNG2xfgpsflYv?=
 =?us-ascii?Q?NO+GLTLzDVPBogQZCqtYfS9hJkZYZro8KZTUjXbqakdZyam9u/uYjDclkS1l?=
 =?us-ascii?Q?YYw2LPTAR325x8A65hScoPcLZ6YsEwcOAUmfr11Le1GkEhRxhYxSEAOaLcmr?=
 =?us-ascii?Q?bYYLsqNIVZ/PSHFfNeGULtmoIRGUzgSzUFPKa8LXBxKChytSKA0ucAPdSS9+?=
 =?us-ascii?Q?q88CORwrtoLzA6X2bse8FnypB/L3tSE1/5DctpwHd6kwV+MWYuN0wQS4HaMY?=
 =?us-ascii?Q?jmHEU1oGUOiheHXOmXjIxHm9lIzM84wilMWL4SxkvzZ3/V3FsRKUChMTrdKU?=
 =?us-ascii?Q?5CarofSIUvyZYpGnJE65N7Eqw4V4HV/xC8iUnRJNQmFXqCOUsqVwLE8fRbqy?=
 =?us-ascii?Q?vc27OGNJCoaC5uaaumMHKtJXfHT3Yqml8J64PWztHL16qPtzVbFXdDheiLpy?=
 =?us-ascii?Q?gMkDCYOLn2xnIuUS5t6kOHbTlpMsCXEePnpVXuXX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9eba72-d890-4244-da24-08dbdc8c3bc0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 16:45:06.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2FfL3N3BqymAYjHr+UAS4KUeMm1aMHFjx04VGo3x8hkAzO3iIC4QOQ51TqKrv8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Instead of returning 1 and trying to handle positive error codes just
stick to the convention of returning -ENODEV. Remove references to ops
from of_iommu_configure(), a NULL ops will already generate an error code.

There is no reason to check dev->bus, if err=0 at this point then the
called configure functions thought there was an iommu and we should try to
probe it. Remove it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 42 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e2fa29c16dd758..4f77495a2543ea 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-#define NO_IOMMU	1
+#define NO_IOMMU	-ENODEV
 
 static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
@@ -117,9 +117,8 @@ static int of_iommu_configure_device(struct device_node *master_np,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
-	const struct iommu_ops *ops = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	int err = NO_IOMMU;
+	int err;
 
 	if (!master_np)
 		return -ENODEV;
@@ -150,34 +149,19 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
 
-	/*
-	 * Two success conditions can be represented by non-negative err here:
-	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
-	 *  0 : we found an IOMMU, and dev->fwspec is initialised appropriately
-	 * <0 : any actual error
-	 */
-	if (!err) {
-		/* The fwspec pointer changed, read it again */
-		fwspec = dev_iommu_fwspec_get(dev);
-		ops    = fwspec->ops;
-	}
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * probe for dev, replay it to get things in order.
-	 */
-	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+	if (err == -ENODEV || err == -EPROBE_DEFER)
+		return err;
+	if (err)
+		goto err_log;
 
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err < 0) {
-		if (err == -EPROBE_DEFER)
-			return err;
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return -ENODEV;
-	}
-	if (!ops)
-		return -ENODEV;
+	err = iommu_probe_device(dev);
+	if (err)
+		goto err_log;
 	return 0;
+
+err_log:
+	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+	return err;
 }
 
 static enum iommu_resv_type __maybe_unused
-- 
2.42.0


