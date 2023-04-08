Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35EA6DBD23
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Apr 2023 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDHVME (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Apr 2023 17:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHVMD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Apr 2023 17:12:03 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020017.outbound.protection.outlook.com [52.101.61.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AE5594;
        Sat,  8 Apr 2023 14:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chsBCLF1hxzDbsYTjGYkV/c9JYnmCqFiu5vdwdB1H/a+FOh/ad57/1Oue6WZAIBvoev+EBBk2u5Uxjpsie1qqPLEBXRwAEZfW1k52cd9i/Z5iNTP6ubjC57ERlsgol76kmuu0iWChFDQEGVBcyd9rWDSj+8VfzXqTD3wQOG/q2ZgtRaN6Rm6CnzdNjkFPHsEk/YurWiZEWLkInahczSsUlA8Ij1oI3Ajg97SKv1fg5zNjuqSllarUWiST/miGSedafrFzHMwzSoh3H7beGI+Pm1j+lG8hFmHA9Oo9tVP0iIDKght/xHdxM7S8je55xtk1orqfx6xY4wVM+dpVvj9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r2SHJi6mMmzTP+UWPvWxGd14NXj3TOxJ6bjjLApxxM=;
 b=Z6P6EwayQMxiungA+so2Jy89a33L+yzCBCgDbQwf+VrQY6sd9jQJJyM8XxKYoumIRsBvCoOz1SVfs4zK7mAut122N4jwwAwsY9w1MCbCIQ/lz+VYOcUYHUFtzHZip/moWh4Wvoh/06Xq1QekmpusU+xCrjfadsJ+QjLnEs2io4dh8ZJCBSvhRHM3tRCFvTbekMvPpQM/xi958V4a0n1DsQW/LCjH7Jdn5f1rZQauP0SwG+HTgi4xhDygRFDuKZy3emABzzMHmGV6TAo2jviXO37ilWIsV5zfnp2lC+ovdeXGWpMe5kzAvVtqq/j2FT6iPzu4y36kd/q4QXoMlMbr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r2SHJi6mMmzTP+UWPvWxGd14NXj3TOxJ6bjjLApxxM=;
 b=iiOkaFrkykTOC/Bg3SXB6SFIRlJ+mG0xFWj7bPT1H6SEl+ZiFpEayHnQnPi1h6csCpayi0EfOieZx4wm7vOQypcn/Yhw8dYmM8w0/TizLXOgrp9+Yicka6DgoB1wgJMGLuDfOr8QSf5RuveFFDjfd8wKmWm3bm2H7PaOlGxoaaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB1858.namprd21.prod.outlook.com
 (2603:10b6:303:73::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 21:11:57 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 21:11:57 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg
Date:   Sat,  8 Apr 2023 14:11:12 -0700
Message-Id: <20230408211112.15235-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:303:8e::18) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW4PR21MB1858:EE_
X-MS-Office365-Filtering-Correlation-Id: 8403d531-74cd-4887-c05d-08db3875e29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5w3z4OmzyvUunPVSR69e1dx5tyjz9XuUEX8prgcNQghBufgqRIx90EFM3HtwLbJmX4AkBNYPOppjbku5ReOogbBihJcu8dpvD1hudfLUjBReoRzRyyZCVvQ3BDZELAyHOnvmgN3UMoneEJoEBhkhvKUYO4toylSFsb/A5fKI4GNzLOoArrfIuYs2DxVBhSDCjy4H22R2k8GWxXJEYRP4D+YpKb57iBQ/H3fyoDzwxunh4h4+iLFWgS0ORzPL7gyYHBspTuNODhmxrU33hc1lDJnOYlbsNFV8tfDb66ujXxF7SaiZN3DTm0RZLEQmpnDHQRQLuOGO+4PCwaLfci5xecffI2e7ng0C0A0Kg3YKyxTsz2dha4n1ob0+t3nBskDN3RQjMfurssgIvlp/Gb7KWI4dCNXt5LtxJxvgv8pd4+R4HDW6cjY+nnZGQorkV2nLc823zWbCd4YHZIw1O1DVDehlJmrFmzvELDyTIsTwmTBBAuMJnR8UVGZMqA7nvniCK7KkHMlwzK4Hb5JXKb73DvwyCEPF2iW9oyc5ZVN0saS/jrdJMUH+/T/JkDhvLVvzl9HSXu1D+719qL6URjU39MHvuC7U4k8aYJH7nFrpp3+DMmjRs5A0sdUAnWERmROpr0RgFsVzmD64sRcrkt/+1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199021)(10290500003)(478600001)(52116002)(6636002)(786003)(316002)(6512007)(6506007)(1076003)(186003)(6486002)(6666004)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(8936002)(5660300002)(921005)(82960400001)(82950400001)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdCkX+eOpZesoRsSHWvZ/sLiF0p8tygQNeP/AW0QEXlHpsreTWEXwTBCr2QG?=
 =?us-ascii?Q?hTno0QCjxjT9r+BBvBaonUro4ug3oI9nm4sQ/MlO/vJi2CSsga8zGmeaYX8X?=
 =?us-ascii?Q?35Lz18S2s6BoGFxRD/AXQ7aXXPVp+SwXwoqkTSv04JsxpJvG1lPfsTUYXLQz?=
 =?us-ascii?Q?uiPm4sscTtWpPFODVYuiqu3LXaFNzjlSJbXKzkImAc1/Z0cYRBzRx382cnyg?=
 =?us-ascii?Q?2Kg1D/5f8X8MUCb4A8MDeFha4QzVc5HbTMLloHjU56n+Vm0csb43DHNFtMCO?=
 =?us-ascii?Q?Rhc7tUUVjp+tJT8KCwSDb8XX4KxXWgfqXC4bt2WEDRNPV/5enLvMB9o4fvno?=
 =?us-ascii?Q?ReiaiXrPrNXIcy1Lm8x4lHr8X8Q8Fz3AMRBC//GwxcAoOc/OXhiyZLnHlXdd?=
 =?us-ascii?Q?3Zn14NevBIF7WBcIkcRGxmfbc9i8EKFS+WbjGilQbKQNEXZMqs7BVyMX1/2C?=
 =?us-ascii?Q?37dKuVr/mSw+tPVyYHXR/837LJpO49HqZqD2cGJ5cPLWM/CGuXyS0P2evG5L?=
 =?us-ascii?Q?IDBSmFyfuGbSun+1Ll2ytMMY9JsB6dxi/awR1AjizJKLq2sdU2jhe8cnMkxN?=
 =?us-ascii?Q?aZIuvXuwi1KQgdoj4ju+BhVaiLObD/t3P29T2IBP3sjPJdo9fPztCRdcAxkD?=
 =?us-ascii?Q?mZW8K2cVQOzVVke5G8ZS2OgptAnEKHihIkBH7USyUAWM4Ouq6rq6ECJ9E7ej?=
 =?us-ascii?Q?qzoK21JaodcnnsXLLsEZPMIKo21yGW7ZFslBdN2b+biPPNUB6J22J5FB0xQu?=
 =?us-ascii?Q?dijhqoJ3RhO5wZ25d5LpaGEaQYzftYM/jeSoxtAwho9xj0/cvblPbxY4f+d5?=
 =?us-ascii?Q?TEbT2N0c6kTrDxtGoCNfnX6TCXFzO+4pm6ozNpafyligGsdPJzlL7uG9Ce/W?=
 =?us-ascii?Q?vm3+GphzYscfsrPiN/uBWSCNhG9WiKJrdHMb24PjPLoVgRmGsiyR+rnRCj5D?=
 =?us-ascii?Q?5NIClv+ZOnMAzO/HAcy5D9C2vrnVylce6h/y8YO4qKrA23HJiCx8mVghxYD2?=
 =?us-ascii?Q?5I5+Tbas2TENbsvjBUF6mF6eSYiCH5bm7e4a7ePyVMZHzbH7p9F+1AECvLZ8?=
 =?us-ascii?Q?SMf4M3Q7JQGUxq9NKUcUc/RXjLhAY3a2JnlkcOWvk5nkt8vlTtTHFvZw0G8I?=
 =?us-ascii?Q?vLHKvHJxkPCworr5O4vMdmXHsVMLUjXcq+boRfHTtOBJeTjrAiPZMknf3PjU?=
 =?us-ascii?Q?JPvxdN4BNm9P5Z/1OnwiDC3GsRL46bmvjk2nSgUavvnPd/7u2e1bDCFuOVSH?=
 =?us-ascii?Q?+ByJ1ilkMt44zMoesqL01BiChQ8uUD6/qex24kBeI2oDI98uOfaWcvcaoYDo?=
 =?us-ascii?Q?E+spDIscgz01TNdnMuxJeE3cmxWKLOniKhCyqTXW+EX418G1KdK7U4y8/deE?=
 =?us-ascii?Q?0MYKt3U8ROJopppMbMqC0NtwOFaOMCWfWm6y+2at4gNbYvhJRSpfV/U8LLho?=
 =?us-ascii?Q?gKkEAgCPNykLvMAORtHLPinsNrkHIV1VMIIUAfqFAUsGha9qnfToPhgjEtUN?=
 =?us-ascii?Q?F0fPKF04vI/RGhVpXibrgp0szQxqoOTITAmi8FKWNWh+qWMy8apAT4Dai3tH?=
 =?us-ascii?Q?ndNmwJAd3gONqdYXwKNv/oX72pWZqAvzUMK1bWFAoXlq7XmWbMTH3tlh7kOr?=
 =?us-ascii?Q?mAiD8yQlL0QxWMnZ6JGoW/VCqReWHeDnfF8+VMlTQn7q?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8403d531-74cd-4887-c05d-08db3875e29e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 21:11:56.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOU6RC31KkfaUEn6U+GrY8NqDXGgOmrOihzOj0Fh/tibBlq5A+gvy1BXMZqNwSwbAeEuURw9RMex/0pOK/sWKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1858
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

4 commits are involved here:
A (2016): commit 0de8ce3ee8e3 ("PCI: hv: Allocate physically contiguous hypercall params buffer")
B (2017): commit be66b6736591 ("PCI: hv: Use page allocation for hbus structure")
C (2019): commit 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
D (2018): commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")

Patch D introduced the per-CPU hypercall input page "hyperv_pcpu_input_arg"
in 2018. With patch D, we no longer need the per-Hyper-V-PCI-bus hypercall
input page "hbus->retarget_msi_interrupt_params" that was added in patch A,
and the issue addressed by patch B is no longer an issue, and we can also
get rid of patch C.

The change here is required for PCI device assignment to work for
Confidential VMs (CVMs), because otherwise we would have to call
set_memory_decrypted() for "hbus->retarget_msi_interrupt_params" before
calling the hypercall HVCALL_RETARGET_INTERRUPT.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 48 +++++------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 337f3b4a04fc0..bc32662c6bb7f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -508,20 +508,11 @@ struct hv_pcibus_device {
 	struct msi_domain_info msi_info;
 	struct irq_domain *irq_domain;
 
-	spinlock_t retarget_msi_interrupt_lock;
-
 	struct workqueue_struct *wq;
 
 	/* Highest slot of child device with resources allocated */
 	int wslot_res_allocated;
 	bool use_calls; /* Use hypercalls to access mmio cfg space */
-
-	/* hypercall arg, must not cross page boundary */
-	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
-
-	/*
-	 * Don't put anything here: retarget_msi_interrupt_params must be last
-	 */
 };
 
 /*
@@ -645,9 +636,9 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 	int_desc = data->chip_data;
 
-	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
+	local_irq_save(flags);
 
-	params = &hbus->retarget_msi_interrupt_params;
+	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
 	memset(params, 0, sizeof(*params));
 	params->partition_id = HV_PARTITION_ID_SELF;
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
@@ -680,7 +671,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 
 		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
 			res = 1;
-			goto exit_unlock;
+			goto out;
 		}
 
 		cpumask_and(tmp, dest, cpu_online_mask);
@@ -689,7 +680,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 
 		if (nr_bank <= 0) {
 			res = 1;
-			goto exit_unlock;
+			goto out;
 		}
 
 		/*
@@ -708,8 +699,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
 			      params, NULL);
 
-exit_unlock:
-	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
+out:
+	local_irq_restore(flags);
 
 	/*
 	 * During hibernation, when a CPU is offlined, the kernel tries
@@ -3598,35 +3589,11 @@ static int hv_pci_probe(struct hv_device *hdev,
 	bool enter_d0_retry = true;
 	int ret;
 
-	/*
-	 * hv_pcibus_device contains the hypercall arguments for retargeting in
-	 * hv_irq_unmask(). Those must not cross a page boundary.
-	 */
-	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
-
 	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
 	if (!bridge)
 		return -ENOMEM;
 
-	/*
-	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
-	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
-	 * a 4KB buffer that is guaranteed to be 4KB-aligned. Here the size and
-	 * alignment of hbus is important because hbus's field
-	 * retarget_msi_interrupt_params must not cross a 4KB page boundary.
-	 *
-	 * Here we prefer kzalloc to get_zeroed_page(), because a buffer
-	 * allocated by the latter is not tracked and scanned by kmemleak, and
-	 * hence kmemleak reports the pointer contained in the hbus buffer
-	 * (i.e. the hpdev struct, which is created in new_pcichild_device() and
-	 * is tracked by hbus->children) as memory leak (false positive).
-	 *
-	 * If the kernel doesn't have 59bb47985c1d, get_zeroed_page() *must* be
-	 * used to allocate the hbus buffer and we can avoid the kmemleak false
-	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
-	 * kmemleak to track and scan the hbus buffer.
-	 */
-	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
 
@@ -3683,7 +3650,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	INIT_LIST_HEAD(&hbus->dr_list);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
-	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
-- 
2.25.1

