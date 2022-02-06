Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D274AB1BC
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Feb 2022 20:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiBFThP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Feb 2022 14:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiBFThO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Feb 2022 14:37:14 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF5C06173B;
        Sun,  6 Feb 2022 11:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeGtVqlHWGlLrMSn/2WjDjKPBm2hNLEpKxovQWTSCQv5S5nR54FNojlp7JMMS4TPbezHosALOKFaOhbsSyH9/AWJmHsjm6T9y0zn1Hkn5dxL2yXmRl1ZTuRwb95nGBOEWcyWLvCinNZ6Gunv3ftw5kYYUr3Q3s97fcSd5vhqjXrb3S5mOnS5UJ+Bn0B4y1Db+Oo0oneHZ7xYr+h2qhqojmaB0PLDFHtFimNzYmp3VcSGP4jhUOUhuEWJ7R9SBaICTwaXS8Wa+jgoO2xA3HKHuuLlieNzFoaJKolXkH3gcrghnFFgnV7691yJ6m0dZFCip4rQQ5/kwQ/s2WC1PiRJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHZ5CsyWDTR9InSrJZH2HQglYNEUZLW1TDAB5/j6G6U=;
 b=R4bhGhmyfOCSPY6IAAMVM3LMzaOtiHh4Cg/cZuIy3KUWmev2gmBRy1g64zTnJbDBRK1nAwOcr1d9t/yDXqgdjPkDDHTRi6TsMlZVEQbdkwbpx8ErVhls96WcEBS1QnAJCNg8PsDl7KFm0cFy3YVwpwRhdg6MZWlozuJuX+gkIGZEteg3fGDJja1FqiFFMtQCSeIGKd3yFQXWwwtqpGUIltQYzl2FPnldMWwY3jr/YuP8pS9T5mf47soZcpUQJBrBhEYqyxTYgI6wtHeJIBUre3R2M6nRYU52121ZGa69e9Mh5YF0YReeOZ/9tq7+l9yhKZ0T0D+Y9wVQ96ulOrU1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHZ5CsyWDTR9InSrJZH2HQglYNEUZLW1TDAB5/j6G6U=;
 b=Ya3tY6vSqZggRSzR3lilF/QVzFmJYGCeMDipbQP8YKFkzZkXx4jWhVArWwFwclDc8ZKxJRXbZr9GQ08dLAV7WFpiIZjG/rmLeYL/LgGLHkHO6NoLjm3u1ZJKlgKhy2jkhFTAvV0EFwtvnhDFP5yov3Nv+AfbNP17TxBVm+mK2ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by MW4PR21MB1953.namprd21.prod.outlook.com (2603:10b6:303:74::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.3; Sun, 6 Feb
 2022 19:37:10 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::5598:8419:b821:a519]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::5598:8419:b821:a519%3]) with mapi id 15.20.4995.003; Sun, 6 Feb 2022
 19:37:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tianyu.lan@microsoft.com, longli@microsoft.com,
        nathan@kernel.org, ndesaulniers@google.com, vt@altlinux.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, llvm@lists.linux.dev
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Rework use of DMA_BIT_MASK(64)
Date:   Sun,  6 Feb 2022 11:36:56 -0800
Message-Id: <1644176216-12531-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CO1PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:101:1f::21) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 090971b6-b39f-43f1-bb0e-08d9e9a810d6
X-MS-TrafficTypeDiagnostic: MW4PR21MB1953:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MW4PR21MB195344739764EA70A21C270FD72B9@MW4PR21MB1953.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dluHeqGxmdMPLISNBfU2hDyRxyphc5Zpbvx5O4QsOYNLu0q1f9zJB9R0L9TBhYywbmpjg5H9XZc1Eki2ICZ647l4/9frN0LhYd7AHmXpvkQ6VvFixDbR5ySLrTFQuBWhCnBDnBwreuWjXnVSwd3W9AfIMxTNB/O2YEbM1BScboi5q8WnkcmRJBDO/FyNJT0d1GdhVprY47kOjw64Mh7/MGGGbPd5fvhaG1IVJjQUOsz7lDK2RYxRiVmIkB0iPgNbrRuCCaEwPW04ftOGDyc9Fp3+rPh8Rz5jh2d1plsFMDo5BKPTRpgj7weEChw4pB5thwEn6txmnbr7rLH/2Bqi+UATSW7a+SlPG3bJ0YlUxyFee891VFxZ4rX7bZtptWtxzE7ZfjII526g4HfLKY5B8Hylz6pol6wv95uFUQNvLEMhv/2VIZ4lQD+pBjXha2PdOE4WjpHhqgS89YhBDcrDzFzT5oW/AUnVdvYL8Vg9nQrIHAb4HU2adWWWIVxXJE5x2d5pJzbI21Krb8x/5mIKd3QcEOR+4zO0ig6qrL8fjce+DuHIWACJfpdaJBtPiS1qC9au+xnfnXPrLkO+p58RfQZe/19IdEgGF0RTgvxiF3GWkrRaqUC5/xHG7+AOU4tY/BCJn0wz+llKEHHxFoaNfTXTFmXV12tqmSWkDOCUXT/55Vgvo86LmjEomM5OyG3zujXda0x4aekySrXkzqTpR+199/BM9uonl5eHbtdxeghmBdsFHR8QGYXW5Czy16NC357stLnNppD0hWVBo0ydrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4326008)(8676002)(107886003)(66556008)(66476007)(86362001)(66946007)(38100700002)(26005)(5660300002)(38350700002)(2906002)(921005)(82960400001)(82950400001)(186003)(2616005)(6486002)(83380400001)(52116002)(6512007)(6666004)(6506007)(10290500003)(508600001)(316002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odKCHEl2SdFhoqF81CyiQMUYLOalQ28gKVUlNzZ9MzmuBP9I6iWQtYDcX3Vc?=
 =?us-ascii?Q?anqku706CdpeB9V605mp5E521fD9nJMEOy1hyi+RUB2EtQh6x1WRHYX504pd?=
 =?us-ascii?Q?XX9zFem8uU/XI/YC/PbjdxUkSW/mq2HFRQ7GpmLgnXTzHzHZEI5AY6XLTS2X?=
 =?us-ascii?Q?7sfcq+pMaR6VT3Sf+36wo/rzCiGkbDbqvMvYoVPXHAxmaJha0e4pJ/GNNufb?=
 =?us-ascii?Q?XO0jTUW0vr7jKdyr6ctRtkT6yx43cYXQFrwer18tVDhHUvnMgHK3mXjMe97T?=
 =?us-ascii?Q?O55y3CGfuZxDe+4tZX2MdjWZHRN/n8GpvDrgMQFu62sSu64x2R1TJ6KayWxV?=
 =?us-ascii?Q?CW3Jxpj2OrK4kIPDWf9Z2ALH8TZHRLtwvNc0FSih5cpW8TW3cpbZXP3xNGHI?=
 =?us-ascii?Q?aoK1+HhvZEdwKxKFJj8wFGpY/bZEuGu0M2QsnAnl+4pe1iR9zfyfkBzFyVBR?=
 =?us-ascii?Q?cj6wGPiSOY7t99+/HyxScWwyYkVWV4FYvJmfUzMyWJ2yiFk22b4B3DzIgHmP?=
 =?us-ascii?Q?f+/3kkSLSKaLCDt3QyGPN2/K8V5BEz/IZkPCxX9XVAc3LBBA5ab/rYWaw+LE?=
 =?us-ascii?Q?rsnHNQozCWM88A8YgKEjw8tLkm19fLQHI4EU3Myg7F1aTWAt60zFUJmrpWFC?=
 =?us-ascii?Q?va5o/hzqar1P9S9feiojh57Ks2IQ4pC0yElOFXM34AzjqiNHTVtCgFj3Gsno?=
 =?us-ascii?Q?+jqw+xPgaNGcKoU5N5W4RvYb+cOfmrEt5T8vdWjWmJWPNZ1VlKxNFspN6xTR?=
 =?us-ascii?Q?y3DLLuHCUDwAm1rgn2mKBQhzhX757RX993ofDCKvJmLKLBd0Arp1tWEC/M2H?=
 =?us-ascii?Q?XY4cTYLQtlBBvd2IuGA4QI42CMbI+qT0/sFD9P0+WBj10h6mbYg3ipGtdLOQ?=
 =?us-ascii?Q?CScd5I4HainQTOHd6YKs4R9J7M9XuRolqVoL7YOgAHYr9IEFk2AVL1weLCM+?=
 =?us-ascii?Q?nMpaeNRO5Jwrft9dcSw3yKeESbAm0NXILzKC6WWEpAoIsQJ/UFG10Xz4mrx1?=
 =?us-ascii?Q?9UlEI/GagmJtdRg8jppKB4w87j5vjIG2k/gFg4ILAAp8mfVaSFYvhGnudyqh?=
 =?us-ascii?Q?4Sk+hWz3m9ew+Rc1oLiT2itMepav15LT1wui/WwfSOFgdj3mDxKnZlNq2/BL?=
 =?us-ascii?Q?lkw40XGMd2FCgPFlNm3zNU2rHA2gUmfGywHE0IF5DyAfNCS6JhzYfrkIfrIZ?=
 =?us-ascii?Q?PmnwvVgENoL+7KyhO9kX9zECkO70Ly2rZ8Nc/dlvBM6KNPD6wj1UWZd9s49+?=
 =?us-ascii?Q?vr/lM9xT9/OKuM/2e1FqSkyWjMsL8tB+h2IERllbQzTb/HlgasbkY/DoMgQ7?=
 =?us-ascii?Q?B9VXZd1JEd+84hjDl9E8naAwmET7gNT/wiLcxHxfYTiDoRNykw5LwSk9+JPm?=
 =?us-ascii?Q?eSSfXiqAITBT2ejCoauRRcBx0hO6vhSw2HDCMMoDEUJfcXj3XibrpdSWhSo+?=
 =?us-ascii?Q?fk66dsim8djMop/Ipd/qsExZTyaYg/H4xCc+3soa0E1k7UxQbuVnBoAGbhBv?=
 =?us-ascii?Q?GD+Z7PjfffFjcjgdK6OZu5oymQPQOTwSG8tiAsevrJAiDfcjg9IoyKh7VD9K?=
 =?us-ascii?Q?fPRe4F/fBO6HtWGtXi9o7XMtO7cPF4g1xEbnmpSC+FaKsDMbEZ4gP/08orBk?=
 =?us-ascii?Q?cGKM16Ys2UpkDZmqT1Nwt68=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090971b6-b39f-43f1-bb0e-08d9e9a810d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 19:37:09.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxaFBWvOVS5aNTtL2sKquduzccayUyvggh6Ss+r6tOzft92ZX4FKd26XR8D5ZitCj4m8ne/IBQdhkqDBgv6xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1953
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Using DMA_BIT_MASK(64) as an initializer for a global variable
causes problems with Clang 12.0.1. The compiler doesn't understand
that value 64 is excluded from the shift at compile time, resulting
in a build error.

While this is a compiler problem, avoid the issue by setting up
the dma_mask memory as part of struct hv_device, and initialize
it using dma_set_mask().

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Vitaly Chikunov <vt@altlinux.org>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 include/linux/hyperv.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55f..0d96634 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2079,7 +2079,6 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	return child_device_obj;
 }
 
-static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
 /*
  * vmbus_device_register - Register the child device
  */
@@ -2120,8 +2119,9 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	}
 	hv_debug_add_dev_dir(child_device_obj);
 
-	child_device_obj->device.dma_mask = &vmbus_dma_mask;
 	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
+	child_device_obj->device.dma_mask = &child_device_obj->dma_mask;
+	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
 	return 0;
 
 err_kset_unregister:
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f565a89..fe2e017 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1262,6 +1262,7 @@ struct hv_device {
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
 	struct device_dma_parameters dma_parms;
+	u64 dma_mask;
 
 	/* place holder to keep track of the dir for hv device in debugfs */
 	struct dentry *debug_dir;
-- 
1.8.3.1

