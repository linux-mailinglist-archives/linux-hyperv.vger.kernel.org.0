Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12B6DBD36
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Apr 2023 23:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjDHVfN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Apr 2023 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHVfM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Apr 2023 17:35:12 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AC6976D;
        Sat,  8 Apr 2023 14:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKAoL52vOSFRcBuvuNcebMlyFi8ZHAPISvnKHmjUH06l+ZBPDXclHNlktwUM9bKI3qWD3OAh1VqYLtgTy01zFSktVnEQcM6VXHc43N09CTm0UAqfd/hII236OtO92aql5JoDvx7DDPLhCWxVL6BofW7+2WF2lD/FHu4AQRqZKj1LaoUJcSCyF+x5gHQSL4uMV9obzSpfyVJjlC0fxcs1euFIcylWuOP8Sn+7D4JZkitMBIwpcc9Hq5bLYXwpUDvdtTetJIEBHEbaboD/mfU3iWzL0mJtTMvj8N6KKCi+lSLSlMVedEC4fSzP+nrXDsP9uRh1QX944P3eaDrtk8IvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AC+vTXJCLhfBzs9xVTFJ45XL8z3Zmg0jG/IXge91eQ=;
 b=hypQDTFzTlI79gSuOUBm85i2nWSNr3fHKut93kgsM7Mou2NgO9aA172kcjEnbugx7oQeeKmJZUFWSsavAHzKwZWffjgILLS9wQmDR5SX12pAultVqGQ9izOyQTvZ00B3LQ6wqSlZ7kOiWzTLyNJnIwRQwE1+jd3fyI7/4qe87O+R7mLAQlTz+g8EtbnTpVKlFOfapSY8xvpQEBVAQ97/VgWXrNThn/8LfYx/+0jE+dUfdAeY0WoG4BlUz7eu/dnY1Qlp0m3XgFE1VvJzWIfvf9I5ANTy9NxejwaXuohU1ZRZcoJ9yPXsFFCKkBLVH7jzh5MvH6bwUOdaRVX74W30lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AC+vTXJCLhfBzs9xVTFJ45XL8z3Zmg0jG/IXge91eQ=;
 b=av116LHqaytysW7rpoyoBnXLpe8PpNpEmb1e5SbqU6wagrhVe+kvp0HD1wb4M87ucwikLd+0manB+eAcecEr7DZ7P6DwZMCJ7VicWuVhMGc4MkPBUt9ytncGmDVo0ksqGJyITSDpNCjuyXKvSwsx7kFD8cZ2LOUhbJ8WwApPfIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MN0PR21MB3604.namprd21.prod.outlook.com
 (2603:10b6:208:3d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 21:35:08 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 21:35:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: [PATCH] Drivers: hv: vmbus: Remove the per-CPU post_msg_page
Date:   Sat,  8 Apr 2023 14:34:41 -0700
Message-Id: <20230408213441.15472-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::23) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MN0PR21MB3604:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0048b0-a94f-4bb7-70f4-08db38791fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1848apUVasAqYHd94W1OZPBHwIjx6eTERFEVU10OT2AYQbjMDY9dpsuyN7B6H4xGMqoMLZBoMGgEI9+/Rs3xIjTUYiplb7kJrptuVGyf94gWauWZAwYedzn3gvxs5NojBVOKKC4lAebpXffF3sU9NcCl/3f1yizScQz/eE/XTjK+mxTV4zTlf78QhoUYLlCQ5mIY4svP/Z16oEnDblO685FgLq6ekqO6hbR+hw0aa2tnJcNZA4Zwv4DZ/oQSR9iPz8CF/TKHcNlEPsJkW0w2LsMbh3C84hs0p1kEDojCud5DHRrxzXKJ7KIbcX1wf3SPmepUWHPeOgmJojvYPCykhNGp8OpYWiDo846M/aRPwMNVpleh8nS2RQvJvhoN5zGqWDPzcTziK8KBC3kEwrHKyj18AoqbQQGA0OymWSn31KFf6qlG94MiSb6KlUPp6Yle45sNddHQTWkFOc5yX4oLIv+WdauPNz5D2IbAsTDJZ6vstJwTH3jmA6efQPHJV1stXBBo7BoZYijWAzHUlTeMn7AqbGRzqjbn+uk00eQhbkvwgB55aromtV1j2jZqhr4fGiXsyyGCI+/JVkkcjnPXgdAzTU3htAGdGrpaF2/poA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(86362001)(36756003)(786003)(316002)(41300700001)(66946007)(66556008)(66476007)(8676002)(6636002)(52116002)(6486002)(478600001)(10290500003)(5660300002)(8936002)(2906002)(82960400001)(82950400001)(38100700002)(186003)(6666004)(6512007)(6506007)(1076003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PIXAPUt/fv++CXsrYBWTQ3tnT6AzGqHOvRyyHMBUwVObzTtEOJbq5AqXBfmz?=
 =?us-ascii?Q?WD4ePHTAwGQNpGYGfD5an5AIDZftBX+WHgjNWRlUV1yUKDAZHG7htAs7PxIW?=
 =?us-ascii?Q?BIFzBpcSVg6E9HaaaZckePtoTYXarnkZN4H1AwXUWqBKyMCc+77hf+wW0Nxq?=
 =?us-ascii?Q?tmMzwhPDD4u9nmW8jlCLNx1eANUKQj97Yf48zCoXUukJaL5jC31qPlA6yMM6?=
 =?us-ascii?Q?x5FOXc/b4n6aw/tiuxGEpaiNN1KiIvqGexYzQWQ6dPwYA/l0vDcEN9h7n4zt?=
 =?us-ascii?Q?a1Xee4EzZSZqtf6MHzt7PqiTxcvQT+/SmetnqXr2cbnjvJ+6vfAbVBnn4o17?=
 =?us-ascii?Q?2AxMtRotZJrEwaVzLxHQMLQMVpZASdcx7Yz+IBkQSL6g6iAbWKdEnL7aKueh?=
 =?us-ascii?Q?i1kwRdI7BYw4ufiemBhItB15kH/NbkA2YuKYZsvVTpLEojZyIhnjLtgt6Kez?=
 =?us-ascii?Q?1pX7H32PbZCMfKXf4tIxoTxYoQDYfLRaU6uxSv0ifBnMYS8TL4wISoxNhZH2?=
 =?us-ascii?Q?BOkq6xgVlLdvXFTm49l1SjLi/AxR4m5ISqi5sZiH+mx+9nFyUuccFDuaB7IY?=
 =?us-ascii?Q?zkjh9wsrUlnRGsGOhQWK9WW1DtFTKtcleoAyG+wL4XdNWYSr2IauMqEpFky+?=
 =?us-ascii?Q?qfixS8No4xXUMJUxnKTNwAOz3A7lMNegI9iKKhdK5mPsl3OYr8QsH/6ZeZeu?=
 =?us-ascii?Q?UaB0pQz0eGoSYfKRGbQnyk6d9i94XskPJkhB6zKZkadxkivWmyokEgdMae5e?=
 =?us-ascii?Q?46JuSvOkl1spfzcd3bbIv0AkjjVyp6cq4VnP1auwaPd7VVnzdQ9UnFBdHOPr?=
 =?us-ascii?Q?KkmsjjP1z7l/LX4GxnmmkZrBDVXFlHUgVw84vbNeYB9TPOYKsUrdR4IEzOJm?=
 =?us-ascii?Q?mvkbdYnVvZi0F7Dr4Ypc7p9KM3yoNKaj2MDd5cOVguKsaGrtlV18SnB5PX0S?=
 =?us-ascii?Q?slBokT+HppfDz+Ixq5AvgXEE9vPhT7RMs5KqffRdwQN5QWZWVRn+2TOhhAHg?=
 =?us-ascii?Q?9JZLMzihoH1G0yMrRsdtEmZFozelZ0MsOhUJOGn9edNmXlqSrKHsX8ZOyzzI?=
 =?us-ascii?Q?ot9c1r9ERtTHDs+GiwUxHEn91JyLoWzJfX6OCWdTJ//k4WljNl+DIC+vTbjH?=
 =?us-ascii?Q?zlJeccT0tXfQSbGcpVgvpa57xNcpgl14lBnOyVIvvqLTkW7NtxNqENaUjXH/?=
 =?us-ascii?Q?2qChPAtbHtsJTpsqDGcJ3NoCH0xMJMjhK1DbqWhHOi3f/MhDkO/6YBhjUHX+?=
 =?us-ascii?Q?mBZyxkKrLB2DAcdVKLOs6R5NyRVhUbvh7A4tCe9x01evzK+f6VmxXe5f3+p1?=
 =?us-ascii?Q?M8aZZ0y3eZt4sheCWZwSQeI0ye9bWUpy6rHeoPiQB1hKG/1m2Af81jds8o1m?=
 =?us-ascii?Q?/i693K3M7C1kkzexQ7Ty19YiiTZBSi/kl2rdlmdE8flhqd3U16X0yK/hlSlD?=
 =?us-ascii?Q?rEonfE8wPpgTvAatEplkfARGRYwxsY6YqsbMfnnnKFYE9GSETgq1DxRAlB0f?=
 =?us-ascii?Q?0bSucdUAksCicjQdQrjatg1XArnj0XZ9aQvxgjs/r4DRVKLT0DlDTdHqdh0S?=
 =?us-ascii?Q?Lkpdcsmt/i/eP7/CUQz5Eq3deLcBMJeBR5Wevkr+aRrJv3gsmqiBmS/WNpRX?=
 =?us-ascii?Q?8IBK1sUOht6s2Dy7+smSKXhDgep5CQuAckQ5FIwgKdb1?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0048b0-a94f-4bb7-70f4-08db38791fb4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 21:35:08.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x+KLuaQTdzJXuWGSxd+E+pNmSJbj49KLatGENtWiHhcVqUJvfF0Z1npwM/e5ERU2iNOGHLT7hyZXEfoubQR+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3604
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The post_msg_page was introduced in 2014 in
commit b29ef3546aec ("Drivers: hv: vmbus: Cleanup hv_post_message()")

Commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments") introduced
the hyperv_pcpu_input_arg in 2018, which can be used in hv_post_message().

Remove post_msg_page to simplify the code a little bit.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv.c           | 20 +++++---------------
 drivers/hv/hyperv_vmbus.h |  4 ----
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 8b0dd8e5244d7..30bf122a502ae 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -84,14 +84,15 @@ int hv_post_message(union hv_connection_id connection_id,
 		  void *payload, size_t payload_size)
 {
 	struct hv_input_post_message *aligned_msg;
-	struct hv_per_cpu_context *hv_cpu;
+	unsigned long flags;
 	u64 status;
 
 	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
 		return -EMSGSIZE;
 
-	hv_cpu = get_cpu_ptr(hv_context.cpu_context);
-	aligned_msg = hv_cpu->post_msg_page;
+	local_irq_save(flags);
+
+	aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
 	aligned_msg->connectionid = connection_id;
 	aligned_msg->reserved = 0;
 	aligned_msg->message_type = message_type;
@@ -106,11 +107,7 @@ int hv_post_message(union hv_connection_id connection_id,
 		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
 				aligned_msg, NULL);
 
-	/* Preemption must remain disabled until after the hypercall
-	 * so some other thread can't get scheduled onto this cpu and
-	 * corrupt the per-cpu post_msg_page
-	 */
-	put_cpu_ptr(hv_cpu);
+	local_irq_restore(flags);
 
 	return hv_result(status);
 }
@@ -162,12 +159,6 @@ int hv_synic_alloc(void)
 				goto err;
 			}
 		}
-
-		hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
-		if (hv_cpu->post_msg_page == NULL) {
-			pr_err("Unable to allocate post msg page\n");
-			goto err;
-		}
 	}
 
 	return 0;
@@ -190,7 +181,6 @@ void hv_synic_free(void)
 
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
-		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index dc673edf053c3..d8322049ecd08 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -122,10 +122,6 @@ enum {
 struct hv_per_cpu_context {
 	void *synic_message_page;
 	void *synic_event_page;
-	/*
-	 * buffer to post messages to the host.
-	 */
-	void *post_msg_page;
 
 	/*
 	 * Starting with win8, we can take channel interrupts on any CPU;
-- 
2.25.1

