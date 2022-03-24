Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B94E66C2
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Mar 2022 17:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351603AbiCXQQq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 12:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbiCXQQp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 12:16:45 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0819549F38;
        Thu, 24 Mar 2022 09:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxRJ24tuQQVj5Vu9rO6EckGweek8gyIY6STWKauZVoLDDqNKjJR/HCBJlOXO//RohXsfDdI6SlFIbfUdolUGgSVYf7lePOGPY4zyK6A2IT4eWpuoS54Kkie1FoJuRqNOox7sXnZcIwdW29WaWeavEwwlQoVbMJJRWDPFRBUtnZLZZEWsb4JA4vJkJY58/3UlofKri5byirkGLfm65U93/SbWN9yzO3gKovjEcDZLxEN4ofF5JMfCyFPUmtU56vS2uoYiXlcXuwt7l0rajQC8Giu23LXQe29uvVPM6NiusguINDVytR9r5vLvVqWOV+sqqHpvta2VyxoUrEyb6a87Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biFUfiA/jAdCiBEnXAvKTtwhAz4EgqSY6slGmCLX+BI=;
 b=n99/EIrBxHNfzv141smWCL//kAAdRgWrc2UcpXRQ12plTKv5XiKwIUjEvFTRnHzB3XNRfy2vw0OiF7b6mVwN9k3xXChUrJEqioGF8P67+a1Sslp3VGshK0PKZOwE8M6/yEkfD1jFusHHMPzowtX164EBHx6eZaQHls+z/XWs27oFcjN4fgE7GK1KfVMcJz5QFfVdvFLS1IVgJOKmPbOObTI26AXKXrvf2N8Bpe3puaYhGt0whgTNltm/BUNmtJyTdatDtyjeGofBsxkiK0eDgQ4E+rcg0sHKMN9yyO9g0ruNRhGxWW6xlntoAfzRrVGi5+xqbUG9xRdGfDeGjFG9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biFUfiA/jAdCiBEnXAvKTtwhAz4EgqSY6slGmCLX+BI=;
 b=WvniPoVcRL+khYRMMV3nYVWAVToL/VCIXgQbzh/0Tev2cAUv1Bos9tpRQ4G8q1fQYHCJGOef+08y4EAncHqcwVjQ3f1SwNkmwe1gsXJz8JnFX3HoUTJA8ZR8cR+43bhZOerbCxJhH+cDPYW1S8wK329boFx3usQ5Ahdkq+mdZbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BY5PR21MB1411.namprd21.prod.outlook.com (2603:10b6:a03:238::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.10; Thu, 24 Mar
 2022 16:15:10 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b%4]) with mapi id 15.20.5123.010; Thu, 24 Mar 2022
 16:15:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
        lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v3 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
Date:   Thu, 24 Mar 2022 09:14:51 -0700
Message-Id: <1648138492-2191-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
References: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b515034-5274-4921-22d1-08da0db17845
X-MS-TrafficTypeDiagnostic: BY5PR21MB1411:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BY5PR21MB1411C968135CBFF963A59E30D7199@BY5PR21MB1411.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sVY4gSxryuWZZbQExtFG4+84OyYgUU0EnOgkT5JWgEvAZeL94NlKlK3O2VIrGHAoSCVjvnfiVojJTDza/qPjZMn465rsSiDqV7OI1/1GcI+G+7f0wPhr7nXTqgQeuYegNmumE4lLbw4y4tX5sRgtnXNz+YdQJRT03AJxk8xsPGR3e9d7m1zbyp+zE9rLAXpxCJXSXkuKrH//gjdF73dMVjykFjNZIIQLV6GsHW9St7xAuAHylG3fo3p62o0qC04Hoa77c/7nPsEMJBjZOwYgnXAN+W4L1aikhVPEB3DckgHrIU9x4gHyH+ANvRSCwqN6U6k27WSRXmDx8lG2KsS/HJ4uAmtvsk6dAR/82nC8VpLP+e2093LIAbgxx75ae2S8CI7g2e9h/YQIq1bAyeZsxoZQFDqh3m8P5w67QPCZHR+TH7q6xK6ZJ/r2o/2jSBQlC98JFS9lsMLiXxmpiBkC9qzwN+mGk/KuyINxPshKs3ZMCQ22pyoSbp+SvBigEH/OIYi7i6wNqLhNmDw4G2vPamV8XGeZ5evyKJ7HBpXZ72vFsLLWfctss0eUJcfIObFAkufExx18VQVhv4OFpMthyElaLT+4Wt9eM9HaJCSN+iMwqIsLHHnA64oePAt6wu6UG/ui9jdiOpgq0m6zr7L+k0flv379pEcy/VqH4XrFTtobpukD9zohyNKm7fEC6Nkn1VQo1IleVxBXjp+FTFP0gJ1gxe5bGkuPLUB/2+SuZk/caBGwM764FXTnNMdLYiGiJy47zV0oQpbq89rYJVzGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(2906002)(6666004)(6506007)(52116002)(2616005)(83380400001)(6512007)(26005)(107886003)(186003)(8676002)(4326008)(10290500003)(6486002)(508600001)(66476007)(66556008)(86362001)(316002)(66946007)(36756003)(921005)(82950400001)(8936002)(7416002)(82960400001)(5660300002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cKYq/0mVEloguQpKnPIDmWvxJ/tkxdbwCCMLdYC+LfC1y/USAif9tXb1hawz?=
 =?us-ascii?Q?M75V1sDL7Rb6apSazx8lWxo7nLXPJFJYcvl3oYgqA3v7iLGaJV3WBqi9Sa36?=
 =?us-ascii?Q?Nefv7GTBPAUgS2ypZP48DVF2+YdEZYm2eKKGCfn0w4Rri3hOtQPgQ+VL83mX?=
 =?us-ascii?Q?vCgBY2VoQfWlVBRn6AeO5LpHRVbko18USk9t/03Qu1VRou7eFBDi65QwbEZU?=
 =?us-ascii?Q?UdLrNV3bJAgkSkPsF4xfVD/C6bY260SWu3XT7NP6EQPmEfDIjXGa+mY6XS+a?=
 =?us-ascii?Q?eWwLSPt9AWZnxS2fKG+83wzFT8fAMlIIbIWMmRM7yrBxvu9UvdCNwRlidqDm?=
 =?us-ascii?Q?I8W1SmWgPgznFRhvd3xsskIa6QJha4kl3yp7xqz/js10uECN2gGlIiksPSR1?=
 =?us-ascii?Q?AWbPBKxIjEt+2l1SEABCt5au2BwW8oM+TmkDmMqNsF8v/MtD6Fn+FhfAMlqu?=
 =?us-ascii?Q?7hei/BONFWOzOrVhhhkmuASPQ13kQkb+YYu+2Y0r96Q65r4mld0iF629XXjJ?=
 =?us-ascii?Q?VxMiIoP3BI/sbRzi+Y8yzxrpksnGxreOywfj/O+IxqRZZYl2QvWOfwTHhtw5?=
 =?us-ascii?Q?BdBajI8l2DhI8WpwLC7KC7vpV37VP84K/tBTlvno8+JLKAV0VkR4qDcY4YdK?=
 =?us-ascii?Q?VoE94+1q/Y8e3X1X8dKfPX7S5GOmkc75hxrHhXfQ0SIAHX0htDVCZidAYTxB?=
 =?us-ascii?Q?YDTNKgIQnuFMtONJHG9XcTV4bO/gMB8IZfofjcLa0ewCVNPkGhT/qfUMY1RS?=
 =?us-ascii?Q?XoJIb87G4O6S2Iq0vJYfnpYRsNOeN/twmSzoRnFb7k02Kj6+EZg1alWS0Lxr?=
 =?us-ascii?Q?uhNi3zJ8tPhzUb325cdoVVyW+aGI8WLZGCYbRGDiPQORtegVLqwidceXIR6/?=
 =?us-ascii?Q?Z2HJGKVwH/Jr2LyigrLFg3cIffp3m1+msj2d2EDvxG7b4jqh42mnJw4I0qhs?=
 =?us-ascii?Q?RsI2/u6R9Vn/SnO+6f19O74jx+LZfeemclGSQS+/6x6WOJstldPFCHDFswJb?=
 =?us-ascii?Q?mUFlrteZgC5htvP3z1J4LdjtUSFkccI812txbF0eD67RfOo54kZTvAgUmNIS?=
 =?us-ascii?Q?tNIX5Q7i7AlLwRmodCIdSt0mU7pm9zm3BkJJk70vJlS3KcKrfvIhWXGbTs6T?=
 =?us-ascii?Q?sJIOGkD13CUJXf8KgTwmgNSB02clRMSnv0Wae+bpcLB24zCQHG4C2T5hieFP?=
 =?us-ascii?Q?f+FniznvYTHbGR+MJ+kDVHvH1PR5dKBbLs+47ZZ/h/RQ2xx4UMeYqpxuNYJw?=
 =?us-ascii?Q?I4zey/sQWKxCorAWg3IHFZES3KbfaiSXRFmyAWzzr3DWCu4x7oZq7fTLN3o5?=
 =?us-ascii?Q?QMzkmjJ1626croS0Ojle94AQ1g6b0cZFhSQX20vpvfDlEW/AQqgeej/PBvWj?=
 =?us-ascii?Q?tYfrCv5AALM4g81rQLYO3gFCLCGRyACI//TtTSBANRvZVfbdfxrv/5RPNVNN?=
 =?us-ascii?Q?WXdJk3MnQxqe4Zen0GVvMSrgvFgAhs06CSprcdVsJYuxE+u0SzF7kGYe5eGn?=
 =?us-ascii?Q?ywA8hE6Om55rY9yli/TLBpG4fBELpNA7k0sbdqHLM9DAvAJE5byZpTp10zp8?=
 =?us-ascii?Q?MUiriNaXUz11AVrub398Dm+v+6jlq8fTZysr33Rup0bgQXxHxPkI6yRmMVrG?=
 =?us-ascii?Q?7y5Ma14YiwK2C+Ux+8iAivodmXKJm33LBX9ZFHOXkkpFFljc9+1bKW/JtcGd?=
 =?us-ascii?Q?A1L+EUOhql2nai/rjCMg4QlWdRStP/6hlQ3/fTigFyTvwQtavwXpE42iNSDr?=
 =?us-ascii?Q?JxVBzPq5j7Th34cpfwvvgFb+vl0Trgw=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b515034-5274-4921-22d1-08da0db17845
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 16:15:10.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzHAZMaghVoTkWY/g+YmJeqNFsiSskrEbM520BYLcj7rP0yxjf3PRyzvC2Q1f4itjpNk8pSiMor6qvv8uPm5dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1411
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/hv/hv_common.c         | 11 +++++++++++
 drivers/hv/vmbus_drv.c         | 31 +++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 43 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 181d16b..820e814 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -20,6 +20,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
+#include <linux/dma-map-ops.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
@@ -216,6 +217,16 @@ bool hv_query_ext_cap(u64 cap_query)
 }
 EXPORT_SYMBOL_GPL(hv_query_ext_cap);
 
+void hv_setup_dma_ops(struct device *dev, bool coherent)
+{
+	/*
+	 * Hyper-V does not offer a vIOMMU in the guest
+	 * VM, so pass 0/NULL for the IOMMU settings
+	 */
+	arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
+}
+EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
+
 bool hv_is_hibernation_supported(void)
 {
 	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37..5c3b29a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -921,6 +921,21 @@ static int vmbus_probe(struct device *child_device)
 }
 
 /*
+ * vmbus_dma_configure -- Configure DMA coherence for VMbus device
+ */
+static int vmbus_dma_configure(struct device *child_device)
+{
+	/*
+	 * On ARM64, propagate the DMA coherence setting from the top level
+	 * VMbus ACPI device to the child VMbus device being added here.
+	 * On x86/x64 coherence is assumed and these calls have no effect.
+	 */
+	hv_setup_dma_ops(child_device,
+		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
+	return 0;
+}
+
+/*
  * vmbus_remove - Remove a vmbus device
  */
 static void vmbus_remove(struct device *child_device)
@@ -1040,6 +1055,7 @@ static void vmbus_device_release(struct device *device)
 	.remove =		vmbus_remove,
 	.probe =		vmbus_probe,
 	.uevent =		vmbus_uevent,
+	.dma_configure =	vmbus_dma_configure,
 	.dev_groups =		vmbus_dev_groups,
 	.drv_groups =		vmbus_drv_groups,
 	.bus_groups =		vmbus_bus_groups,
@@ -2428,6 +2444,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
 
 	hv_acpi_dev = device;
 
+	/*
+	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
+	 * method on the top level VMbus device in the DSDT. But devices
+	 * are hardware coherent in all current Hyper-V use cases, so fix
+	 * up the ACPI device to behave as if _CCA is present and indicates
+	 * hardware coherence.
+	 */
+	ACPI_COMPANION_SET(&device->dev, device);
+	if (IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) &&
+	    device_get_dma_attr(&device->dev) == DEV_DMA_NOT_SUPPORTED) {
+		pr_info("No ACPI _CCA found; assuming coherent device I/O\n");
+		device->flags.cca_seen = true;
+		device->flags.coherent_dma = true;
+	}
+
 	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 					vmbus_walk_resources, NULL);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c08758b..c05d2ce 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -269,6 +269,7 @@ static inline int cpumask_to_vpset_noself(struct hv_vpset *vpset,
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
+void hv_setup_dma_ops(struct device *dev, bool coherent);
 void *hv_map_memory(void *addr, unsigned long size);
 void hv_unmap_memory(void *addr);
 #else /* CONFIG_HYPERV */
-- 
1.8.3.1

