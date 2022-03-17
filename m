Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5854DCB03
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiCQQOw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiCQQOo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 12:14:44 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501A1FA76;
        Thu, 17 Mar 2022 09:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0UOWmYjeXeP9nbSsdL4EPDUB7jifsnNtB9BUTB9CH0nU+nHMLUWLtIkfom9zdShQ6ILjKKVvgd8ipfhIh7AZ8GaAedFceH5k99HHzPY/Bzk7FkFkkMj6tMjeeHVlNJbwz55B91gXGQnXww2m8cD7DjnifjIrnwxhUgzWu4Q+0HVOTeJAspAwD9JlPPn74nNF+0NzcHdNrF9Q4Orc4weteycCi3057jYfiQp0bddmOZQ2dkUxE+OqA9xEuQZpMABY6kM3mrI9i4WyXNjzWG8yjnwh9dGf5wkgyu3vCWK12lAOyKVZpd5X9eRj3vdasXeTGdP2yQLNFFq1kBeB2v5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yDLDyXVr4lWPvqstJjFwb/JQmGOxqMwR4p51AL2DjA=;
 b=h6+XIkbi/bCBWsWoAF6tfNDrWfpWIAvcSuwxVpkpA6tWdEUHJ9tPQ+sa7j4tv5RFb/tfuSdVAHKWPi2Ib934H7ynojyAJ8kcu44qZ4ZvEF3kedd7hb4jDC+r+ui5+FK5pnGo/DbxdB+pHpqGuDEPc5QFwZHHTQn60pPAbZo5xOXtAi0dCpnRCeXgrF9z1w3VjO0SWe8JhsCnmg/HP4LmM9C6tbcLpz+R3WDFx8p1/Rl64PQuRiExKQGvs+4dcMXNsQ8xNEydN3Hs1n50/4PR/0iXuogFTjdQmNTE2HIdcNTi12UZtKuoHx/jFELMlVxy6V2D8/l+LM0XaYiGDm6rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yDLDyXVr4lWPvqstJjFwb/JQmGOxqMwR4p51AL2DjA=;
 b=WIcvQ/0q/VM9rZVkzFEG+B4z1xPDDaIs33kqB18OgPeeI85YaAwIGepIXBkGSFsV0YjLnel1l2NauMTT5s2S9e9ep7YkVOMkk2n/o8QMh+i265o01zG9RSbKxDkkeWCc5M3oDJk3XZRgFxKLW0OBI1wPI5KSCqNZaMImR+ttiB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB0995.namprd21.prod.outlook.com (2603:10b6:207:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 16:13:23 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:13:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
        lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgass@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 3/4] Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
Date:   Thu, 17 Mar 2022 09:12:42 -0700
Message-Id: <1647533563-2170-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
References: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb52f53b-986b-4294-bdf5-08da08310f12
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB09952EFD1861F9F90C31E0F8D7129@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EHNXLwFM+R8VxJ/0zskQBaT6T7uigvIqQvkJp+MGE4ZvpnyCaQIM8ZlrEOUF2BWau1LEKqPInxpw8iyUPuxHuYIfHZJdn7FHwP1m35+Oo/ZQPyUR3EcyHb0TURsNGc+Jqk7hiuHPVi/DOeHXHwLePEaZL+Aw/46PbwI8+RbZdVkc//SKXSZapJGaZhU6hC1FtJ4QuRr/XedTDXmarne/tHotLEekmhSSMy94Brta5toRa+HDl66S2v5jyVFfAKhoWiy6azsIa8Uydy4oEo7WQ2KbnJT15jZpgQ3eAaG4r4pRAnCfS0GYTKE/I6IOZIYoOuIbr2JK63LTMdWx1ncijxQeZxmCZMOKVCuK+0CXMxkLRSYTXnrmhIOb0Rcc8gmfRRdkfDLOe91ohFUXafk8bqJ04dOJo9ej1WWtq+d24pEIUsnE757+ed92/uOsWIwaXPG3UK3kUO18uHjhNDlUdarfHaSd1eYWNU8iL2zC6PeBSdXxdEeJIKIiXqwC7xwCGFkqWUBwYRszkAsBWexj2GsvCIKWco/h6pM68NtD9+RVMYnDVguqzHqzvpWU7b6bnHyBlQV2iFoquUwyY2eMZP8XPVMzVn8ddohiU9LAad8Dh0iBFMsiyM7K17SRm14Btf5z0+jLI1xhf42i7S8yRBkObwiuA7SqC9NjY9evrerdyJd3YgBYBJLBmKs17RW/PT8hIF6N6Y82uKk3Q5EUgApXg1G1zLcZMXeNtz5DsCLfnadaMFGyZOFNu0JAM9omEtY7rvQ+ymc+BNkIy5v8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(186003)(26005)(4326008)(8676002)(2616005)(8936002)(66946007)(66476007)(66556008)(107886003)(38100700002)(38350700002)(316002)(36756003)(10290500003)(6486002)(86362001)(5660300002)(921005)(6512007)(82960400001)(7416002)(82950400001)(6506007)(2906002)(508600001)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6UHLyLM3WVJ9lT05bFYn97qJVgRV+uVmD0YFVhcnZclkCpCAwfafjmem24f?=
 =?us-ascii?Q?oppDtruXtI7g7qAXIfxyYRmV9/tAJwIrH05WyJ+a7mhKyjtVAYTMQrSjvkRS?=
 =?us-ascii?Q?uWMkfjMp5knlWpPDfK5adJ2vFe8gSt7pRVxzZqjHVuscwhb8DqgUm7FM7Tp+?=
 =?us-ascii?Q?NiV6jAsCIcm0OdZBFSP9+76Tp49izfX/um/k/tfMCgV+zhnGlJp8fTpmvCcG?=
 =?us-ascii?Q?f0DBahJHF41lQpuGxwwqW/qaxswhKY0YDFbPUzPNvqPB0NnNv3gqRF1yDbQK?=
 =?us-ascii?Q?mrzei+Kze4o+3phBcKbaXVZlPZHqMf8XzEKLradwEVEfFNIYaLepzlsmIULN?=
 =?us-ascii?Q?ZAUqS17GEGDkHlQUt8AAZ8XH3etr0mDAIvPzQcwWuvoEoHrfZIe5a2J23eWA?=
 =?us-ascii?Q?7d3C/zGY6bTm/z+pKcucByZtLjwVltnRpDsO1Rjz29IsslvK7nx3JyR6hBz7?=
 =?us-ascii?Q?MbhrH2dYOhfrmruffIIw1oHwCoUiHi0haxI3hhOV8vjSLPHsoL0gF+uMPmae?=
 =?us-ascii?Q?4aeh50u/DPr8A1eQh/qrr5scSUmzHMyGrkyHRey/rReQLcK79d6O/8Q5dtMs?=
 =?us-ascii?Q?rOz4rdWrr7R0ziPABgwKizeBXouQPIjfJT/3uAv3QlPxRgo3eraOSyT43vCz?=
 =?us-ascii?Q?YjGQtP0dwRzAluX7cDtPr/vfyJ1JQnuImQ0robR/D3IcSg61fp7zH09gzdbl?=
 =?us-ascii?Q?H+et3DbrNfizkJQe0u4EtDiRfgaWhxMlZgOtZvQ33NXtXotgkXMUx6ruCREL?=
 =?us-ascii?Q?WOZWyyX5w7Msel5yNmZqHLbb7JHa4miGbxNahmCCImT/h8aZ6EU9dHN16ibC?=
 =?us-ascii?Q?NY/TeuSuf0Q5WX0xE9y5R8/e3Y1UVZLVJl5Yhw645r38A89WrYkKMnsFg0AJ?=
 =?us-ascii?Q?9lyJAQ/GgIk2XBZ/9KF1o4bbcZRD3eLBGbD35KhAMQ8TPoUiUUJ1brdOmH5s?=
 =?us-ascii?Q?7Orh+gB/ntomOVjE5YOU//9hMwnEzeUCw5oQc3rUj1P4FbCucLXAZIoFCKxp?=
 =?us-ascii?Q?FBggvyA01jSzpJa/ASmTvPLwTiyaC+Q+TxmTJoBOQWApzAOaYIVnuqcsQsUY?=
 =?us-ascii?Q?rbumHu3XUVhdB6NpxzGLdkHgzEyCI0AssDD+qO7k5bZJsgLsilRvrMcisOCL?=
 =?us-ascii?Q?Z1qHIRcSNpx5qEtsx0BAmTS4eBjpreqqWCD2lIvWsLcUS+0gYtzMfRnY4l2J?=
 =?us-ascii?Q?wurlPJ39Rk2wNpE/PwNvHrm5fKgUGfIE0yfNILJ4trIAEUzvElWC9nTYwWRb?=
 =?us-ascii?Q?o4Ds5MHo9BF40mMKLVj/ckUVsOExbIJRFpIbr5HvmLAmYs+bJzgf3Okp1NTC?=
 =?us-ascii?Q?tIWSmizfPZY6pS2gRF6sheZNqxjuGM0K9wnunGzvUeAzylC7qkq1fRCghzYx?=
 =?us-ascii?Q?t25zW1D+eQ4gdZPEbbWZ9NTCiaKmOGdZ6+zDJPkFTVnjhlJTnRMTlDVfmd15?=
 =?us-ascii?Q?jSECS+ddOQK44ine1G4sOk6WPHvgTwY9/OT/d5UWRCATV/4vqGnw/w=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb52f53b-986b-4294-bdf5-08da08310f12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:13:22.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfRB4pibcMHQ2eo2nV+doiyNol2bg7KWwTLGKiLlXqNt4xPDdBcmf83alNOrlHDI5LjdB+CK4ayY0xgWF38Gcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VMbus synthetic devices are not represented in the ACPI DSDT -- only
the top level VMbus device is represented. As a result, on ARM64
coherence information in the _CCA method is not specified for
synthetic devices, so they default to not hardware coherent.
Drivers for some of these synthetic devices have been recently
updated to use the standard DMA APIs, and they are incurring extra
overhead of unneeded software coherence management.

Fix this by propagating coherence information from the VMbus node
in ACPI to the individual synthetic devices. There's no effect on
x86/x64 where devices are always hardware coherent.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37..c0e993ad 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -904,6 +904,21 @@ static int vmbus_probe(struct device *child_device)
 			drv_to_hv_drv(child_device->driver);
 	struct hv_device *dev = device_to_hv_device(child_device);
 	const struct hv_vmbus_device_id *dev_id;
+	enum dev_dma_attr coherent;
+
+	/*
+	 * On ARM64, propagate the DMA coherence setting from the top level
+	 * VMbus ACPI device to the child VMbus device being added here.
+	 * Older Hyper-V ARM64 versions don't set the _CCA method on the
+	 * top level VMbus ACPI device as they should.  Treat these cases
+	 * as DMA coherent since that's the assumption made by Hyper-V.
+	 *
+	 * On x86/x64 these calls assume coherence and have no effect.
+	 */
+	coherent = acpi_get_dma_attr(hv_acpi_dev);
+	if (coherent == DEV_DMA_NOT_SUPPORTED)
+		coherent = DEV_DMA_COHERENT;
+	acpi_dma_configure(child_device, coherent);
 
 	dev_id = hv_vmbus_get_id(drv, dev);
 	if (drv->probe) {
-- 
1.8.3.1

