Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663E6632D40
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Nov 2022 20:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiKUTtR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Nov 2022 14:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKUTtN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Nov 2022 14:49:13 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021026.outbound.protection.outlook.com [52.101.47.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F973D289F;
        Mon, 21 Nov 2022 11:49:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVP4+c7GrDznaipR8f3Z/A37XeOH4C1LU7HBQEy6mrJZdkzExTo/yfSnDqVI6XmC5Cwzo5voQaT78oaVkKomt9KLnhfUlcUgg/KfL1DZ/h8ksLkA6kNE0bORmjduyjiE6fd9RiyMQ3677IyHQl5sxvRJdJ8o4A5LsCZ++lDOcLe7YO8fXbTG9scTOwD3VHtmQl10Ly/QdoipLa1dDXj3zWjPzVSV2LnC+vD0HcTX5JASyG7RGvMNpRPt01Mj0Jxmvyns0AkJOjvMVO/zwaMlZsq7cIb1SGzp0wAKKS2UafzHseRKjxy9fnmjkksgPXl6IBmuMyqkdqDYam8/m1zaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6MB6Pj0pVdIzjvH60woIq4fdJBoIVIdkV/zFypHggI=;
 b=GzHPh8BF3JeysR/XSbv76eIun4XoezKibicoZHWMp0PeVQCo3T3wii+fH73kGPWV/2uklSByW5B7VLNfkFAiGcMEB+JTEKfcl6IhU2OODPTdQcRLt5q508rkd/+aklG97eUTj1DoPWk3uaEE8Ppn7E2zDtVmB5vD1+7aeh03J0XrdcwrGV9rE3uCPAhUoflgOtSmgGhuE1rlspxLCuG1uFI4THz/STbukTesl79Wp8epWLCdzlDWPr07YmOeIiTfCP3kcXfsb5LH1L1rU+KaHBKcHLCOw/SgY9gjI+1qscHQjO3qXKjRh/5tZuudjkIbfJGauce7WyYB1NKYO0gGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6MB6Pj0pVdIzjvH60woIq4fdJBoIVIdkV/zFypHggI=;
 b=Iw517VjoiNSoSu0+7VKOBmUXzr9seXPxTPJM+fRhxyHmlRtvQVzQz8aMPCyiVxr+oEtDi07/xlvK7dpx+hB6fV9UCnbCFC1zgdQ2Q3Edopgvq0rvqDTAaSndyenYPXrWAlg8+6LwPY7/mkDMMKrNuaacMpNBEfAOvlxRov8l9vQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:49:09 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:49:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] swiotlb: check set_memory_decrypted()'s return value
Date:   Mon, 21 Nov 2022 11:48:39 -0800
Message-Id: <20221121194839.21722-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0376.namprd04.prod.outlook.com
 (2603:10b6:303:81::21) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BL1PR21MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d1f115-b2d6-4919-4b34-08dacbf97168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jklJl5FQrkn9mopEiYW1g43jqfdTRslD1cFFYjJ9Y7wlSFAsugiM/iMWM2AJ02gKEzg5wgsjOq8CyAOsMjhPoDXnYvY6cfU6y5W43uaIcEyuXDKgoBZFD80CeFBCcVb0Oye5Jw00YCHZF3rHX81FyJqLw3OnB+GartjoAukjak7W81S95YRhKjsweNacLe8PEnVFJuvr9dsjnooEL97o4SWbL7wpLeVW178PyeF1iPIkBbOPu3by3C+x75P9mgfhJa47wUlVOWml2mHvUSlmw+2qVmzqyIZPcW2te1p+S0tILXlta4L3MXG+AWQWiKM/xHBe9XkdRkRXF2J8YzoGD1o5C1B+DfzKyJfbn3AMWr7OTI9E/y/6mxm03oor/RV1Wq66ub17rq7L1MlPoGUSpq8l2eubbKU4FJyHEE4NOdSxc3/P7E/Es38dj10tc7UpyvnEJu3J+gtcZYlBBtlkyvlDv0rUhvaDovjGTBxJUpT3ophM7TSwFHp1f+UP9wI/VgBjC5QfVd1Lh/Ig3qsE8hXm6BGRrwLmAttYtPfsoZuJ3xpG0dSbHxoXobDKfqXF42jyJzWuJTYqz2zry21Pgv8YocZMYqXbhfI/kYwtxPhDQc9TwBWndfIv8F/ppLQcmEXUo+CsxqDdiZ8Hcps+mHqojsVV9tOpZdl/l6hLld/kVdZZz1dwzmxGYgnysmm3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(82960400001)(6666004)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+mwA4ncHVsd2HS5osR9aXFSVDGKsPHC+Q2PrMsVcxZnRFq36awy5FpMb6V3p?=
 =?us-ascii?Q?FU5ZM81YooDzzj3h0pI7AU3ogw48Lhnp1pqLZvx20AeH3JHUUVY7u069oAen?=
 =?us-ascii?Q?TuA05v82OtxSoy1bUZ6qcUKk0ul/D+oLNhFTjYXUuwUwSvdUxeWNeeZVuDpy?=
 =?us-ascii?Q?FjyTFP9YOkYaPfN8szxI6XSn62twfLBhDO7egBnwhh3DzzYeYn5s7d033J3y?=
 =?us-ascii?Q?1KYKV29PM+TRkN6/UeNu2qcP5vZiRBURI5UYpWwPM9PrZbuXn9dzAaGGln5K?=
 =?us-ascii?Q?IMxYEg1zJ1ntsPqVb5v+fNpRVGI9L8/Ora0mkEh+eikV79XC4VFof3UH0Opl?=
 =?us-ascii?Q?qa+zX7FlK+tqx8ze3h3I/6gjBuN2Ve3DDQ0vJNBQFL+L6+GDs1GDk549yV+H?=
 =?us-ascii?Q?iT2WtjXfgI531M57b43oNqcbPhl2IoAOqQMY5J8FbkKyYjsgepOfbRM2qlvo?=
 =?us-ascii?Q?CZ5VySpVTBgqaoq/M3uiHa9Z8Ev1+htkVEk68WONSBwOsWolrdjQa+cHFVy2?=
 =?us-ascii?Q?r7Kzav1g9erFFrWUBNjuDorhJXmGdskGlJ2axmLUAHl+4CsrS8NKD226fgpn?=
 =?us-ascii?Q?vakaXTGXb0/yuf0YlNSzS0IYOdd6NwoC1FJ7kHVXsrFwgsjFuGf/pbuFvUeZ?=
 =?us-ascii?Q?QC9gX7ucL63o6q9IkK1lZELFxXE2/cf+7gRyR50Y6dQUrOFtiy2sdlmUdktE?=
 =?us-ascii?Q?qBpzGrvc3rImI2qvN1WJg3ndC/pud66MmHkX9JwjfuRSFho0tWFzTE/QLh00?=
 =?us-ascii?Q?KbuSnvyWRgqgw16cT42MkrR5enDNYPiMDkgZce91sTq1SXXFwefPImHNEFRE?=
 =?us-ascii?Q?Lcn4+E+EmkABlEhD7nPYzvFSDAnCYiKZrfKt6Ng1gfQGScdV70jZyt58wtyZ?=
 =?us-ascii?Q?dwR6naDp7RrYi1mD1VvCwwmKl2EZN8h4EgaVTLLpYAr3BTSNRhBmoiGtxuEk?=
 =?us-ascii?Q?cJhzEif9rY+O4RsfKupXGnE2u2xdMsJ6PnZ7LxU+CLy3yX61dCIKrVphAR+O?=
 =?us-ascii?Q?JTdBZtAKlc2HClEJCGechK3FWUQ42lLJ7oe9SZbdElYBD00fR31eXGy/b/pj?=
 =?us-ascii?Q?4ng1W1t0VVzFYY0qBWtXFn9DiP1vZpEoZ/ZVzFSxmh2lI1SqdGCtTe3i803v?=
 =?us-ascii?Q?0LsfaPJgjuvowqbJX3OKf0eVGA3JDA2vHVDboIoNz0I3MqfUEPB+YK4slRZt?=
 =?us-ascii?Q?tO3EqfxUMMLbeCtQRoXXkYBM/Az/9Hr16Wd+xIJ2b9N5f5DHPgvhBZJ/G1kR?=
 =?us-ascii?Q?TAWbX8LHwTX6eOq3trlsNKxaryM2gtDTqO/50ENZNsTWwqRUDrHGlOwps0UU?=
 =?us-ascii?Q?pwW6FvnwFpIFCV3Y7fhpEWuRPcOqh565AAn3vnAhT75dRcT3c4k+VUwtHaI7?=
 =?us-ascii?Q?s+43MH+z+9PNMZKaoV7hGq3ob2bkry53xiprDY+1YBJjOt2h9RV9lzNp8r85?=
 =?us-ascii?Q?M5AbP6jzgdjAe+znPmIkwYq4BbTiJaY1dHTTJHmAu2bLgrYgGJMfsR8M3WvK?=
 =?us-ascii?Q?lgsXfvebEmli4Z+upFcDeY5FAP4MmBwqXMl3sFvi3H3PyocbbPP+2LLFGX0b?=
 =?us-ascii?Q?2GxY/Jt1jJSweD1Z9vy49etBaoKJP+UD0zCKWuo9/Dh+7qIhnNMJ2c1epG55?=
 =?us-ascii?Q?NpOWcPQ6CZpA18Z0OpqMl9sKRdDLZaHHJwcG5UUrnSo6?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d1f115-b2d6-4919-4b34-08dacbf97168
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:49:08.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09vR3XEV7gR3cSTKc5hYciaJskBnPHAKaNimiXReSsm9PioDfq4HQ+53xYPKaRLB9wGBu1paLGgQtB5KaPtbrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

swiotlb_update_mem_attributes() is called from a system where decrypted
swiotlb bounce buffers are required. Panic the system if
set_memory_decrypted() fails.

When rmem_swiotlb_device_init() -> set_memory_decrypted(), let's try
to handle it gracefully.

Not sure how to handle the failure in swiotlb_init_late(). Add a WARN().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 kernel/dma/swiotlb.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 339a990554e7..8e26c09c625c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -248,12 +248,16 @@ void __init swiotlb_update_mem_attributes(void)
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	void *vaddr;
 	unsigned long bytes;
+	int rc;
 
 	if (!mem->nslabs || mem->late_alloc)
 		return;
 	vaddr = phys_to_virt(mem->start);
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
-	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
+
+	rc = set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
+	if (rc)
+		panic("Failed to decrypt swiotlb bounce buffers (%d)\n", rc);
 
 	mem->vaddr = swiotlb_mem_remap(mem, bytes);
 	if (!mem->vaddr)
@@ -447,8 +451,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!mem->slots)
 		goto error_slots;
 
-	set_memory_decrypted((unsigned long)vstart,
-			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+	rc = set_memory_decrypted((unsigned long)vstart,
+				  (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+	WARN(rc, "Failed to decrypt swiotlb bounce buffers (%d)\n", rc);
+
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
 				default_nareas);
 
@@ -986,6 +992,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 	/* Set Per-device io tlb area to one */
 	unsigned int nareas = 1;
+	int rc = -ENOMEM;
 
 	/*
 	 * Since multiple devices can share the same pool, the private data,
@@ -998,21 +1005,22 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			return -ENOMEM;
 
 		mem->slots = kcalloc(nslabs, sizeof(*mem->slots), GFP_KERNEL);
-		if (!mem->slots) {
-			kfree(mem);
-			return -ENOMEM;
-		}
+		if (!mem->slots)
+			goto free_mem;
 
 		mem->areas = kcalloc(nareas, sizeof(*mem->areas),
 				GFP_KERNEL);
-		if (!mem->areas) {
-			kfree(mem->slots);
-			kfree(mem);
-			return -ENOMEM;
+		if (!mem->areas)
+			goto free_slots;
+
+		rc = set_memory_decrypted(
+				(unsigned long)phys_to_virt(rmem->base),
+				rmem->size >> PAGE_SHIFT);
+		if (rc) {
+			pr_err("Failed to decrypt rmem buffer (%d)\n", rc);
+			goto free_areas;
 		}
 
-		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, SWIOTLB_FORCE,
 					false, nareas);
 		mem->for_alloc = true;
@@ -1025,6 +1033,14 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	dev->dma_io_tlb_mem = mem;
 
 	return 0;
+
+free_areas:
+	kfree(mem->areas);
+free_slots:
+	kfree(mem->slots);
+free_mem:
+	kfree(mem);
+	return rc;
 }
 
 static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
-- 
2.25.1

