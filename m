Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE277A44D
	for <lists+linux-hyperv@lfdr.de>; Sun, 13 Aug 2023 02:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjHMAM5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Aug 2023 20:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHMAM4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Aug 2023 20:12:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3860F1BF;
        Sat, 12 Aug 2023 17:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIupqdGUQ8izjFrrTmXGS/LlPGZ/T1C4iqlORSgCEJCBfjljhgkhO7n2FQt/5AgEMJrIV2b6o+2Y8UMLmebvH2ogD9WuCcsOnHhEFICvqtjNMhs7zxQhV2V4bjuobTBKyBNjHzB7z3srxUpma+nctEjSSGsR1miI0F25kaZunOZYbZGTppxaXLWPbKt+IEfQG//N/Jn/ubMflxQtQglFs/9Cb7Qrmekk14PhMigssbBm8BQFuggsWv/OCtFyjN108mowbWw9w3wfOJZ8J7vAQXY2UZtv4T4MUyJwZ9sgQa+9RsCkHMfsldglB3OC9jKOhwJxvFCn/3UutcKLvy1Gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qIBBAi6csLc7ibdCWGAZKtUI4PfY/ibFH4P7wpyjok=;
 b=WAnhMzrVZvutoUWhLitlHjk/WsAAGEo6F6RcjMDybVvffb/tjG1eyFB3UkuZWHkJpDvcwFtX1my3pi1/1FgqvptTTlmglO0aN7KJ+asR8IWFun4zahLfMXOXq7pE9Ut/Y38WVMQZ+QWPd04+7MSUdV0SV/F+JButFLFRL9i0YvzPB31bLRMze4+itlt0T+kXzQOC0n/06ve6AVy8qS2v5SoQdJCM8Uuv7LXblwqqEtM5uj3JdBfaPjKMZMhyXEfUW/YjRMLMhPXzryIBTbqcHGhqO5zHxMQC4A9h0XATNxcAqJ3XvX+96rzV0tXlWdtHyp1QHrEf3X0KFI7p6e//ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qIBBAi6csLc7ibdCWGAZKtUI4PfY/ibFH4P7wpyjok=;
 b=DtOgpst7CmneomZSzjtGnLSdUM312CLexDUe2xYJMLCRLxyfDELjU5zrdbKjIVMcCV+7XiutChzZug+yGtr/2s57U3s18eYn3fDVT/suPuJ3mBXIRvmlqQ6aX/Fq0/LBb7qBTIFjUxBIig0qJo/YU+1ZRwKalt1UZZzD6wM6g30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:a::15)
 by PH0PR21MB1291.namprd21.prod.outlook.com (2603:10b6:510:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Sun, 13 Aug
 2023 00:12:54 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::d793:7c2a:b49d:b58b]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::d793:7c2a:b49d:b58b%6]) with mapi id 15.20.6699.009; Sun, 13 Aug 2023
 00:12:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     tglx@linutronix.de, jgg@ziepe.ca, bhelgaas@google.com,
        haiyangz@microsoft.com, kw@linux.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, mikelley@microsoft.com, robh@kernel.org,
        wei.liu@kernel.org, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation
Date:   Sat, 12 Aug 2023 17:12:18 -0700
Message-Id: <20230813001218.19716-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:a03:40::44) To SN6PR2101MB1101.namprd21.prod.outlook.com
 (2603:10b6:805:a::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1101:EE_|PH0PR21MB1291:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d44a68f-c041-44ce-082a-08db9b920908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdHTt4hV65JyJMO1ac0MIcAuDNb5m2XWHy+lVS0/S0Ekmihqhkj11KmYWZ4IA/LESNH3mqgP7+iysG+LAdqb/T8opQQAy8YbaaA99m1pJjPzOe6fRB1/RLEMakQCG1O8rozwM8COky1jZIV3A6Qyj4/6ip2pj47J//CJIX8HH1NDMQ5PREVZCjfkficY2U7+BOMTIIXwMSrpbziRap6YRH55GWzK9eDqL9ua0olMoibhm/vuFfB/3YO+XgieFPkKihyYgtDAq2ScAON1BHjfx70yjbc18qAtTZm2uUFn8nLOMKCk25KPkUYs0+6DOkAM6aTrJuwivKlwvX/lnCSLQ373NGQuZWqmaBUcplTsWj/nSukyA5DZwLT7+ooptziQ7zKGS66TNDgYT+YEUHMrLAmYtyBgeoLprwRC0530NpxWUZVCVUxBFi3OQ7qHFEKGV361PwjRQCR/Pn6j5mLqw8oiD6PB4OIN+JXtUcoQ3jMlcoYb5C9fqYAY4ZSaXUODG9V/52WWsj0jJgLsAaOaZOzLlrk9ni144cmQy+WB4vF5O8mYuECE7juWxTXsV5ZiuC/JD+4857dMIU7s/3c95PHE28dAUmETk1FH1mU5Lr+1YoiXW9lI7boKDV+v/BHDcd1veWiZ13/5S33XQQ/zMJ80PuaZL79C08YVV42UkYCyF982bWUWSAH4dW7HR37N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(186006)(1800799006)(7416002)(8676002)(8936002)(41300700001)(5660300002)(86362001)(2906002)(83380400001)(6506007)(107886003)(2616005)(52116002)(6666004)(6512007)(6486002)(82960400001)(82950400001)(36756003)(12101799016)(66476007)(66946007)(66556008)(921005)(316002)(4326008)(478600001)(10290500003)(1076003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uh0QDX4k3drYcvxtPAMCp0A2bwFBxvVMnf62VvXfS4MtfrW+8xiK3FnPezLd?=
 =?us-ascii?Q?KJvdoMQMmgc0UT537UtEYw42eF80n1DqcpG38/tKZ5P6jFY1+n3X6qwAiOkZ?=
 =?us-ascii?Q?I+VmiXe0lPQ7PXryX4gVLGVp+fzJyaGW9JcqrxiSkuFHhobDBbn8Rl34e09N?=
 =?us-ascii?Q?irlSOXyP6hzIskfZE4NPVcMki6CxfBix0+j8zc6Fm1z5S++esYbNpZcsoW/z?=
 =?us-ascii?Q?D/7yF/+pCESabF5yThYIUqjihP4WfGGhPxkUrDYYESMNEnOA2PZAAkdLTx86?=
 =?us-ascii?Q?ATs7+EJs4MHyVeebQkiwBHJwCGsAMQW9f4f2byBU/pwZU904OMatJsakPb19?=
 =?us-ascii?Q?o3wHuBdse78bS6oRjF8V27Q28ER5vx03VRvkeyw+ka64MmO5KsMJITLZhaRv?=
 =?us-ascii?Q?HDMikwNWGvbsKKuEof57bgqCQaeKwW2Gp5b9Em1uJ9EtVer9HUsifl4HHQQk?=
 =?us-ascii?Q?z75jx+6FtGTUcTYA0/SvfGUYg63eDku9vMCVf4lhV+v+qlMYvR5BzaNfX3Lu?=
 =?us-ascii?Q?WaxrjRekaPUa31vTxFdVxKv4XKvtsu0/hIW0lm2TUwDOajijttQ8Zkn5j5Dm?=
 =?us-ascii?Q?nrJKPlnMN8HsCNRyknF2izYFuIPQGXcIHwk23oHmUd4hvZ8io9leMR0xtnOb?=
 =?us-ascii?Q?Zq52UCjh41YaXGMDIgYjtlj2q6xSYBCbji8cygaXXzn64+479A5Vdx1Lm5uW?=
 =?us-ascii?Q?uV8wOIACSwluc8W3KVYV4i3gVXp8KnIgUZCvuJ/EoYLPn/3YiCq7jcuSBIrs?=
 =?us-ascii?Q?pfdAVghGwO1qMzsxdcpq5bRA2MV0JO7ung4C3QQhRVHoBnH0LXY7UWfvnx1K?=
 =?us-ascii?Q?UAbjaFePgviRix/SmWkrx/8HMU7qbNMtXg+YW/W2vvw84I6y0udHR6F3sPHP?=
 =?us-ascii?Q?FjgIMEeobxor54xEs8PxDpWiXhNKxv2SZuOdSW2atbXoVwu3HToUD7tvdHx5?=
 =?us-ascii?Q?p3OZcIH2a9JGbBx0zx4yr8ANNypb8+9obD0AGYT4JXvYWWs336vQ/d5Frzbo?=
 =?us-ascii?Q?wqZfz4Mg1u841ts4sT+S6qenQb0G3DEsHccOiTtEXxvRs42oswm9sfGMyr40?=
 =?us-ascii?Q?G1Qrm0p3xaDcuHoOCbj/G9/kR+hMHpzCly9hQOmv+cmrringcNZAtNxVtXAP?=
 =?us-ascii?Q?UkmlILdNwWHORFVcXIJRMo73Q1aFvHE1ZdySlhggIwDagrmb5FelpYkBUIA0?=
 =?us-ascii?Q?7UAhLxsX9c6ddo/RkEbTdPhrxCi51zG5Alxc4ETwidjCA6ZNG9ILPbF5+N6T?=
 =?us-ascii?Q?biWpPABQE6rbhLZWIk0lxWqgzdWaWOfkkWTPsZoh6KN9tATAQIqiGqkp26qU?=
 =?us-ascii?Q?+vevAcf8dImBrwoshxY9lXuQxACDzNFgkDiTjwxAmwYirCVtQOSiXKvDTs6a?=
 =?us-ascii?Q?sNmJuvoiqrMhFB3sdIPFBj+tjHiOceL5rq6uWOZ4W5ZJ6p+XWsTN3aAj5wzo?=
 =?us-ascii?Q?rs0zTUZwc3la+5mRY3i5gkeJwaqthXtQvATndCJCie5MCSb3v5FfXf+LPwhB?=
 =?us-ascii?Q?CgK1joP3UHavCKY7mcodWa4So7dniS+3zlOD8G1uF2EewIUW5SSA80kUC17s?=
 =?us-ascii?Q?a5y58+yKAxq9bjcSNqFmhx2lv4g+gG2sPTkC3Nwb0lGWEc/TI7gNza3bOycb?=
 =?us-ascii?Q?fMh3XZxus93GZAAqz73ytsBQ1cqX03ehdanFIcidhZG1?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d44a68f-c041-44ce-082a-08db9b920908
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 00:12:52.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+KxpcGcgpaVbzjCEniAM4vHV8kNltiaczX1g2lemXOgnxtZNgD8hRWcxI8N4BB/cKaWnrnTZ4xiBP2camd5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For a Linux VM with a NVIDIA GPU running on Hyper-V, before the GPU driver
is installed, hibernating the VM will trigger a panic: if the GPU driver
is not installed and loaded, MSI-X/MSI is not enabled on the device, so
pdev->dev.msi.data is NULL, and msi_lock_descs(&pdev->dev) causes the
NULL pointer dereference. Fix this by checking pdev->dev.msi.data.

Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2d93d0c4f10d..fdd01bfb8e10 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 	struct msi_desc *entry;
 	int ret = 0;
 
+	if (!pdev->dev.msi.data)
+		return 0;
+
 	msi_lock_descs(&pdev->dev);
 	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data = irq_get_irq_data(entry->irq);
-- 
2.25.1

