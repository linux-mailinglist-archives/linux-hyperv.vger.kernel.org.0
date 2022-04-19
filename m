Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407B507C50
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Apr 2022 00:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358156AbiDSWD0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiDSWD0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 18:03:26 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7AF3BF96;
        Tue, 19 Apr 2022 15:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDg4yN1IR6ZYYFJv+U8Mlsf1WHhrjRqlJQUmiSU+ROpnMnrJfP2Op4rAOOg+mqDaXnaiFjvUXjYrj7ixkIAYO2dqPlJZoIU5g3kYm6XhjtN/amSOxiM0ecmYa+ggAfdg3OXFTme4Pi0A6VJ8fbbjmQGOLWSbtF7wmYfKyrB7eHFU5TdS24SybsKPEvUtNq2t18zNOJGRrS8vCs44XHWQrMR7hpj4uU7RJ8nGBmyiMNvXEk9GF13cE9++nMZ33H+xiPZqzOotLnGtepYzxVN8DoNpiKgtIfR+lwjKR/z5GPs/Ls19Ol9FsQLNHGCLkCqZoFwcPL9iF91XccOeKC4XLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsatelTigLxf0TzDixsIBDWSmTj5M5+XJXRPpldBrAA=;
 b=SG9gG+cPcXOCuObl82Pr5E2RTeWwWENnkhr03544KhKEhb71BuY5p3nMGo9F28vmgcSySfc1RksqGoNc4S+/D9IsOcbbtYK2q9XiAk7BmHrHVFu0w+nfBFS0AXDcW3shwHpUGLr8QEuXOH4hpVAw14WMfjqmEhYC1BpjvU1HqjNR4H5XftqWrCSmk0/Mr6o2OHDM7DZQjWHO8DH3kMcPIiV6Ki6+1GpYy05A66q/nZyg4FiMy1IfWS6ghdqKfPtGwKLGbvS4WkFvsq5Dsy3dkly/i2A6tJF9v2yhjix0zKkIhB7G4bcn9eaUqWxpiR7W2QvQYKCi5SM0x/EpchWIAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsatelTigLxf0TzDixsIBDWSmTj5M5+XJXRPpldBrAA=;
 b=jTiWaSkD8qfhzodS7uUj43oBc0gFZEVS1kDBw3dVrzAY8q9QbpuBgY1A/ysap7toumzS/p4eZfXcMgaTa4HakXo8JtX5CNqr+jGql39WsR/Hb8GKho5D933p/0Lv3OXgdTRDHrq68ku/qimojHAJErhfKkJn8rP7kYVwjZDnbFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26) by MN2PR21MB1485.namprd21.prod.outlook.com
 (2603:10b6:208:205::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.4; Tue, 19 Apr
 2022 22:00:39 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::c45a:9279:12d9:eca1]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::c45a:9279:12d9:eca1%7]) with mapi id 15.20.5206.004; Tue, 19 Apr 2022
 22:00:39 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, robh@kernel.org, kw@linux.com
Cc:     jakeo@microsoft.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot time
Date:   Tue, 19 Apr 2022 15:00:07 -0700
Message-Id: <20220419220007.26550-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bed6b83-ae7e-45b2-21af-08da225009ef
X-MS-TrafficTypeDiagnostic: MN2PR21MB1485:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR21MB1485E551B0AF0D0AAD741767BFF29@MN2PR21MB1485.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fAGT2coUpk/ABhJ1/IPovAiStoMy1OuP77oMpj/iVjCDq7PXiAu1cUVj/7Uc7zCw4IL7lbNW/xFVrG6u9Fd1q62bM2Y5R9BFPALRgp2lvsP83WQ618VoYxbqIEcQ1++YOxi8HasMw0U2HQwugkpr1kzhBO14td8eXqZnMDSS6PuHypBcYmv4K64pHMroD3dbwh6pFYxEaUoMM3G6ef+qENbkrOYdjRwU0WQW0Pp5kYsMsSq+EqaZMD3exrfofdt/VBU7JKaOUBfG4wPtjnWpENSjC1IW8vuOnmQXtDo2XE4In+yNTC06CBqvhYycI/xmteu5p6b9GeBEX4W8QcmTp0WR5dPobFCK7FW27zeX443OhTX8yDpZbWDdh2qviiHyYLZFnwKgEBddIFvg8Irct+vdP7eNFSDEFFtLVvPFTdqUmcI2hUAyOLZ2pMZ/CQat72J6mAAI0+ly+u+i5xDUJ5D6eLh8gXyMNjWqGM2O46UnaPiPi0jQ4dBSSph0qJM//5P1kGrHznuXLf7448yFaLW/5X2Vui6E7pFnv/i9ZcY2hiIyPD6O+IH4FBex30vomcjDykfLpvy3jg/k1Viw1P1Ii6YVGT2v7LRyeLyxPcXCECwsxTrzSMk42afxMSXtGf7ybLN5F6FYtVtrxhurCmpiXJHJ6New0M7l5g6HjBcN2zX/uqrsaBa+JZZ/u4pdCLKUUxPGq4r6fu6tgeArQL9c7nUFkh7LhVU3OUSE8+3qDOcK5WqMg5zydv23SB2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(66946007)(66556008)(921005)(36756003)(6506007)(38100700002)(2906002)(6486002)(508600001)(6512007)(4326008)(8676002)(52116002)(8936002)(66476007)(5660300002)(186003)(6666004)(2616005)(316002)(86362001)(82960400001)(83380400001)(82950400001)(10290500003)(107886003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZ03qNpPw63zjQGCF0s6kaCsWRJV6RCEVZ+G8LBpiNzVhW2LtLn5LxwI1fEu?=
 =?us-ascii?Q?Xr8oKYqZGdQOkj/WM4Js78UGhrhr3gmP/iqjkWlHegQAublu8FXMq0Q/zhnd?=
 =?us-ascii?Q?D7JoqbNus9Ri8xkFmiL/Fb45vQiH2o8oi3OP7AdoopwkL/12bl3ALkng0scP?=
 =?us-ascii?Q?X5P1EZnyJotcARS4cVqg/4u2gd7e1bYNIbUtsjhn3yc847eEO6dasPaP1c2f?=
 =?us-ascii?Q?A+MSJbIKO8zeP6w3RIqNVbHn9Rb5OE6jDNNuhaqzxeBSHsvpHKBw7XLpcL78?=
 =?us-ascii?Q?J8iU7qRYx5UvivKU2BYSbj+bJlxEYjI1pJA/PnxcTTdSRZrgcLpoxeUVtjFs?=
 =?us-ascii?Q?xlPaLCj6JmKiEB02B8LpfCXVLsP+uQADp8yVGldXr9DGT1lh4GI7Tb8cdJBp?=
 =?us-ascii?Q?97FPJiR2xL8DkdBJBsmkwtfNDWjJo1vENilkVbJt20S9pWHAkkHaeE0s34gW?=
 =?us-ascii?Q?juCD2YXsRvbojwC7eKhK1VAR3/dAzmtBGiHxl+xw81w4dzKpPQ131aGwN/AQ?=
 =?us-ascii?Q?8sM3QXXWz4DRQ9mJtB5CLlSY+9eWSdgbvOYS0N8ax3OfE/uWNfvm0aboblHr?=
 =?us-ascii?Q?5W77ojVPlMd1sWT/aEcgOQNQ0g6zy0Jmd0KwaebPgtDaN2EOfJnkW9290say?=
 =?us-ascii?Q?LW+qwAtItift8b9MlZ8ZOqPdG2m7hD1HdIuxMyfqUfzGfSD8nECC0vWnMEOk?=
 =?us-ascii?Q?4FVX2oHTpMFKiwT8PYuXNs2HlLFcjGzyOS5LBHb0DG2Wm3hWwNgdTuKZ31q1?=
 =?us-ascii?Q?dMwToL0ZZUjj3TCtV/Nec88Rlz0frZjYeqoDRPSe/ZJMsvDAY7Sgx31K3Au6?=
 =?us-ascii?Q?+ypjVImiqG9A3WdF7Q4JKP8IBvtpbsmWUUItSYQz3xbm2p1C39e3VHhvo3ZL?=
 =?us-ascii?Q?DzNwEUZMFblBM6tMQuQckKhgeE9dtlyZKzX9hlrgIeMSbKjWmT+UfS2Mraqh?=
 =?us-ascii?Q?yhKGtDMM1rfUWC8wiXOt13MQfv8xwpj2AXRfIhbbNUbCGI+1PxjbMcKj3WEd?=
 =?us-ascii?Q?LnftlgGBoj3UMltN0qY4TANW7zFOKJjvn1K7QFv2t9c35JMNiq6RwFmyVWYZ?=
 =?us-ascii?Q?2o1Ow7+P/zTf1dcywKLGeyFXVxla6MVRIS54ylLuPgs+elbmNZVAan/uK4br?=
 =?us-ascii?Q?+XyORGHZpfjM0Y6otyW927CHNd91AoRrjmso17we2I+umFWZQcucw0LRz+R/?=
 =?us-ascii?Q?lmPTuXLdG9WnU/JJae16HXgEIbZOYsyx+gw0o/m8/lwDyh7Fvxq/d+apvl6A?=
 =?us-ascii?Q?dQF4H6fZIaauczaMWxspgzkzM6RM02qDbgnHUwzQFwM69XuTeXkqz3A+W2NP?=
 =?us-ascii?Q?nqGH977N/s/sP/AmxUc5OJ4irMLuygfFUS7rjznIyX03UqV4e2XBLGgxDGhq?=
 =?us-ascii?Q?CxgVZ/Gn6ORcyk4oxpuxZ5O5zWSrg01iQPQPcqCzBDMazr7uqqsjQYGWOuxX?=
 =?us-ascii?Q?UBCkkLP90ib0zC9w/nzZbP0vdyMyfMZGXcpbuikKvHAhWIjOh/mLn0MuoGAD?=
 =?us-ascii?Q?3WPaioeVEgkoF6L6VT79o9HrBJW32UzsEcSvrkDemciwVWthTka2//awo2LL?=
 =?us-ascii?Q?LcOoQvwx6Mf2NyPGrHAQMQbtKBiYUL2OIqoLRajEgxpp2JK+qrQTR+Z/oc+R?=
 =?us-ascii?Q?Vr9nhkx1lXodWjfkjLPIE8q3DtHYde/HQP1DKGE3nWoAw69zvGduAbbgvafU?=
 =?us-ascii?Q?FdR8jbcNgZpd5Zysj6DnlxOJWnCZVuMSkLQae/uoKGUDGRtS5nMxbxDe0EAY?=
 =?us-ascii?Q?IXvf5HFw7OLaE0M4QxjKsOh6tllvvLUvdLIxmaZ+2MSKQZla5F9H3ZGj7Ebb?=
X-MS-Exchange-AntiSpam-MessageData-1: FBabgacrsblaew==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bed6b83-ae7e-45b2-21af-08da225009ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 22:00:39.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCj8S+30zi2YGojWem99u0A4CrAvBUEB6Ysvo4joCMW70XUhxkRNzd2J+eDdRPvfpQgd/c6tHVc36dXPqcOgzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1485
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A VM on Azure can have 14 GPUs, and each GPU may have a huge MMIO BAR,
e.g. 128 GB. Currently the boot time of such a VM can be 4+ minutes, and
most of the time is used by the host to unmap/map the vBAR from/to pBAR
when the VM clears and sets the PCI_COMMAND_MEMORY bit: each unmap/map
operation for a 128GB BAR needs about 1.8 seconds, and the pci-hyperv
driver and the Linux PCI subsystem flip the PCI_COMMAND_MEMORY bit
eight times (see pci_setup_device() -> pci_read_bases() and
pci_std_update_resource()), increasing the boot time by 1.8 * 8 = 14.4
seconds per GPU, i.e. 14.4 * 14 = 201.6 seconds in total.

Fix the slowness by not turning on the PCI_COMMAND_MEMORY in pci-hyperv.c,
so the bit stays in the off state before the PCI device driver calls
pci_enable_device(): when the bit is off, pci_read_bases() and
pci_std_update_resource() don't cause Hyper-V to unmap/map the vBARs.
With this change, the boot time of such a VM is reduced by
1.8 * (8-1) * 14 = 176.4 seconds.

Tested-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index d270a204324e..f9fbbd8d94db 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2082,12 +2082,17 @@ static void prepopulate_bars(struct hv_pcibus_device *hbus)
 				}
 			}
 			if (high_size <= 1 && low_size <= 1) {
-				/* Set the memory enable bit. */
-				_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2,
-							 &command);
-				command |= PCI_COMMAND_MEMORY;
-				_hv_pcifront_write_config(hpdev, PCI_COMMAND, 2,
-							  command);
+				/*
+				 * No need to set the PCI_COMMAND_MEMORY bit as
+				 * the core PCI driver doesn't require the bit
+				 * to be pre-set. Actually here we intentionally
+				 * keep the bit off so that the PCI BAR probing
+				 * in the core PCI driver doesn't cause Hyper-V
+				 * to unnecessarily unmap/map the virtual BARs
+				 * from/to the physical BARs multiple times.
+				 * This reduces the VM boot time significantly
+				 * if the BAR sizes are huge.
+				 */
 				break;
 			}
 		}
-- 
2.17.1

