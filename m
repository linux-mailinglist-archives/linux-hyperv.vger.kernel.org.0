Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC914E59E3
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Mar 2022 21:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbiCWUdS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Mar 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiCWUdM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Mar 2022 16:33:12 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E148BF58;
        Wed, 23 Mar 2022 13:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCJar78Fn7oCwKUFCh0QgzZXOQOcCVj9u4DQASmgelnvvpjuicIlKzVohLjSNXHWKAYcbCAuEGP/31FxDh6o9pPORn3k8PjvuL2f48tpXTgIKDDViN0LF/wNjnt/YNFrLnp79ALeN1E5U7ZKz1O5wEOnjMFZSdCetcpjtWFj/HLGM/K4WS8idHlAKf0oW7LajCz4a3TDVrVqNa3vNJrk5G2vjPCVhnC/fM9mxPm+ZM4E8+Gljzl1/4LWo/x7U+pvd5I7aPMJ1eBRwOBVwlgPos3Og237ezRULfoDgMJMwf2aGzrFMtJ9q4zKYPQmUE37OYsF0rR+aCvGaieelCbLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnw/CDnGeI3MpXk5h9WsPYZ6xWMVJWVMcUX7OVq+iUY=;
 b=ADTTN3EWpgwvz5O5uMyMad3LLC7UBBlsOtO3fULgMozfsuy7vUSxSD6lPCJTAsOFLOPOdB8vPNnG5H1djJlxBlbqOIUy0T2omZgZ62ioTUdIWNGuDzcXj6+3DaFJKNoRxj+n4pPQEGFMZTIrlGGmDOQrgFkaKO7pPRMEcMPNmX8PbPQWQdj+pN7UgralR+KlZf6vRu/EvzgkAU6o563KlUMz1C3wtvDbbIMZ7HeJ72uWwbWWckneOF1RHB5LN86c6IQyymNqxEmNITt1Um5MbzSkoShT7+6NmLhyRdnPdCvoLUs411kpZngZOF1pQSshWsRVcUwAePGlW1+O3a8qxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnw/CDnGeI3MpXk5h9WsPYZ6xWMVJWVMcUX7OVq+iUY=;
 b=DToV2q6MV0C49SOLGvpGqCXwas+exQHywvmb2aCt2sj+cODXo4qD98e4SFJZhry7WSsWWlVOslpMMISdm/BZGW6TvsvEgeZk3PcFvJBDkM9juHI9XWpV49gikcZ9OsuDGu4ZlI3osSgxq+Mk4f+jPorZlizZH7vFJqPuMHMvxg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.8; Wed, 23 Mar
 2022 20:31:40 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b%4]) with mapi id 15.20.5123.008; Wed, 23 Mar 2022
 20:31:40 +0000
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
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
Date:   Wed, 23 Mar 2022 13:31:11 -0700
Message-Id: <1648067472-13000-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 716ac052-5893-4635-5c81-08da0d0c22a4
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0942:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <SN6PR2101MB09421661B888A1D3FAB96CCBD7189@SN6PR2101MB0942.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeo52j/nRTUYi9BIUlh8YwYp3FMk5ZuC88BJvT2rZ9OlzgEuvtnbKO1Gy7cyIjbrCI5ojOWnaockbDJscWo5A+hIVlQ5LHw8kKK8uPfJE6/ZvyjOAxFp5Qn9dwmjnCqu0cT0J0JVGDe+6yca2XnBRkVguuti8EbCPmSfdkPkolM0p9VUBj/o7Uq8gRAdragi0cX/vDRKCZGb7qyk21xU/EANHhUH/uIuXVNnKtz0/LyctLnzq1ankXBSODkxwLQrD2rgart1jdU3IOxWU4y+g82GeBapJLOddoC0JwHcw9FeAA+CxL+ckY5afwMZawuCZHeEF+u/XB4/KPSujTd2bPwYG7sUqtmsCWK7UgSOC3Z4BKZjfXGA2HiOkrtZMrtVs+DPo4P9M2L4/0k+xn2RTl575GM3f8PwiHBUTN6plsztkhwGT3gwX6IgJFnxXP0ctmirpdPUAYZ5ejyVTz1eTPANytJLj1pkKMm8kHRRJ9xfw4KHry0iZ1TGhlMHP4CGhCoucEcuQRWMAnGU9YXvGL6F3H4cGnO+pimS7f0sLMnw+x0eA7KN8alIQOxK9wwlVpoaVIrsRiUbxuIvL2iIze5FRdtgr29QkG0GBvoLp/+p8ReHIbwuEH0D3yVZVb+zVYs1evkPWICDyGm2jb69vpwwpjhx46vIzcq8M/wbLPk0FkZ6lNzPYVnv5i3ewggs+fW1ngwOaCJm7N+QKF3ZlBLEA6DScRpsT6igVUYKFE2H8w8zg5F3UHHndRmLNlHAN0BJmZL0+0HjI6nUytU+Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(921005)(5660300002)(107886003)(316002)(7416002)(36756003)(38100700002)(82950400001)(82960400001)(38350700002)(2906002)(83380400001)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(6486002)(10290500003)(8936002)(26005)(186003)(2616005)(6506007)(6512007)(508600001)(6666004)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KbkfcCUZGqsxn2WvvxKPGDWJqVmoF0DZMC1x2tGqqq+tHVcv2uUPfb6GYy7?=
 =?us-ascii?Q?ewk5GHsSacX/yplSh2GDuxxk7vEz9GuQkepupMvA8uWFx7BJEVOp3mmjBwjo?=
 =?us-ascii?Q?u2z9unEASJq8JEfyYlORm5AFqCyOJ1JS+/Wi3v6ARvG9csrNzp0/7ev8FRvW?=
 =?us-ascii?Q?hiUnBKQaa1a/qOSIOXz0FOVl5aNoX8SP/veW6BrNpRK8inndsnVdIx98nxjU?=
 =?us-ascii?Q?VwP6a9UItboBhOvnQjdiqe7txk89VmhFNimV+L+eyN4ydUGsQ2Rx8GuWotls?=
 =?us-ascii?Q?/mZYAVXkfNQwLLvohdM1gpagEUcO7gfrbleHVXVYQq596uLptyNYqLmdjyLn?=
 =?us-ascii?Q?Q3ZH8Cab8JH0Gv180JkLWCn1fsBJrLMHgHAeWXNywYK/Ah8MA2jFPhvc5IQY?=
 =?us-ascii?Q?koohfnPk6jYltRMsBLuTm8GHlq70wLwcHr9GMCuAbcamaJajZze7poT+Blzf?=
 =?us-ascii?Q?5SHDTkWa1pYwfCOtFp/XvAGlU6/nPx/cEq1vVD4P8/uy7OYYoVTrNJOK4Vuz?=
 =?us-ascii?Q?4kzLAbJDM86/mv6sFm2rum3ISIAZXrnVDKRQfAu2d2E7y2BgErcvmZxQeVM1?=
 =?us-ascii?Q?hHEzqKK60VDoSDzGzzJa493y3dVysWJlwvhvBZOtljgDFJGmTRIL8C97f/I7?=
 =?us-ascii?Q?tGasBJ0Tg4OZ+KXPh4x2deSYgDuW49Ma4T+3jBso6psUY2LhJfo3HagvDqdL?=
 =?us-ascii?Q?OV3sgKx1mBgCi+2UQFsqHs8wNg44mZOGnrf+cp7t3TbkNeHosUN8vrFAIDAz?=
 =?us-ascii?Q?+9ZsQiW5C3+hk+ZGr33WS3qMG5MP/f5TbDDis48SvV2l11tgmdoKVwyceJDO?=
 =?us-ascii?Q?quaf7nxq7Obx9xC72Cq48hYn8iiel4R/KJxBrv6jnqQrqFD61olXRaD0Mx1e?=
 =?us-ascii?Q?SQxugOnWQK2A1+ceid+ynrArcP0UlhWsEo7l30sNCjuIsUPHh/F/XORAjOqY?=
 =?us-ascii?Q?ahsQNZBdlBYVQlMN+Oi8liwXmiwDHRQUoKGcKjOKwO7AHIbZWOvPMosycJzz?=
 =?us-ascii?Q?OybKb9/16w5jNsrJPGB94zxUaPSTnZzCDlud4SOPp/EOQEiv70IVjWpTKKk6?=
 =?us-ascii?Q?rlxlZUSu2LoTTaryUThySIqXOxfyeUN86Pd+exw1wt5ZvL6T5Uo+GeaC3va8?=
 =?us-ascii?Q?IwxXuGgc4uG/iJheQcGd9WrAAzb0LnRgjDXAaIo2uZZ9CsSFAJrmMy2q43g+?=
 =?us-ascii?Q?MmPl4ub2KNgfZ3I4T563ZVofHTYu/g97LjZk09w6Ii1Ijt4ZJRIaNdjcro8w?=
 =?us-ascii?Q?eGIu1sHJpfktKRltiLJMn1ETwVBZCms9WPD/7E8xCmvLGZLiw7dhrG8iog10?=
 =?us-ascii?Q?vtA/ZKlD/JPeVD0fcY9wrQOu80A5iAaSdmXi2MQb5zfKK3hY+vNhZuu5um4K?=
 =?us-ascii?Q?PXL14htOBRAUwujKm1UfA8tvi/R5Oy8hRnML11Tv+wkpP+XI9HNyN2TGxC0m?=
 =?us-ascii?Q?+sA5VpQ2fHacfFchLJliZmmn0XrzMTvoGPskBvNXaBACtHfpPcGKq6YLsVqr?=
 =?us-ascii?Q?+pwb01Xwn5t7Teu/yWohS/9aTE3lQYGWTYhsL7yCf5TBwr0+tdgjGs/DG8no?=
 =?us-ascii?Q?Oo6j+infCi4HfiHJb3izwHAGR425tZsCEUTk1y1h32FU7OPiI5u8fmlu8SDn?=
 =?us-ascii?Q?hm62Nh6u0jlm5bETINo397hp2gJpzJFoNCo7tAfl1lJaE3lErCBAftI/PHVp?=
 =?us-ascii?Q?OYHJb40Terto48KIiYJDR0qt6Pj6evUAse0c8FQ8eR7gaXx9sR77FmWudpBa?=
 =?us-ascii?Q?NkgTJdTEXLn/NojSDc8saL4TmS6l08w=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716ac052-5893-4635-5c81-08da0d0c22a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 20:31:39.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyYxCAOnRrBwkbJBODYtbpc0Bs8hhLdnPzhy0Iplj9gaf1qWOkMvgrhi6y7MqevuYX6Bp7uuI23z9eyiUrp14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0942
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/hv/hv_common.c         | 11 +++++++++++
 drivers/hv/vmbus_drv.c         | 23 +++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 35 insertions(+)

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
index 12a2b37..2d2c54c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -905,6 +905,14 @@ static int vmbus_probe(struct device *child_device)
 	struct hv_device *dev = device_to_hv_device(child_device);
 	const struct hv_vmbus_device_id *dev_id;
 
+	/*
+	 * On ARM64, propagate the DMA coherence setting from the top level
+	 * VMbus ACPI device to the child VMbus device being added here.
+	 * On x86/x64 coherence is assumed and these calls have no effect.
+	 */
+	hv_setup_dma_ops(child_device,
+		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
+
 	dev_id = hv_vmbus_get_id(drv, dev);
 	if (drv->probe) {
 		ret = drv->probe(dev, dev_id);
@@ -2428,6 +2436,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
 
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

