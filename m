Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0ED4FED29
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Apr 2022 04:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiDMCvi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Apr 2022 22:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiDMCvh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Apr 2022 22:51:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020017.outbound.protection.outlook.com [52.101.61.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F865FE;
        Tue, 12 Apr 2022 19:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlTN33B9BSnK6J4USIKtR2pwchwRr3Jl5uXVT2pBanvKbzOfi3ITNZu3kmsy48oL7EAyLGVvl0cnUHoKO5i0smxBlLjNJWiMFxMQOUAqk+jeesj15w8Sx8zUojii7FtaeOyYpj5iznOzwZWol5Jtn8HLKZ8YqDp5oBv0Qlz+1ZcxZkKk6miiHJq0nbqpY9lb8u4HQYu3cDNxTVEgn8y2Axr7kC5jsrx7A+s/hZ/Zc4YjhEpTxXyTT3xTqPoXZSfmxuEHsOn1wCu7AZeD847Y/inxKycF3Ugjm4zDDSTrVi0nppvnulG/WWZfJ5p4Wq/cBf0Ct08me2vBeNwXmWUU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oeTIng58bc0knVYXaB9Z1hBvvjYmg/Myu3R7qfT4jo=;
 b=a2jR08wAb9t+pScdlXtN9w5QZeIN90hG09c/Gn3Rn8bM/s8yf+DrApRyONYvADw9xbuUJxWXuANpuqvCxtaFYSbhEF2Y2xZGDuLSnLlDzskykW/rHF1JY9HuRSeJKSWMhbkMmizBAhkqIRzqeyEAfxFEAFFur7rB15++3U0Y0gY0h1lQ8ets2fmxeUiChM+W/pRIsisiW8RkonHnJ0k/JuxcfVlMuvHdrV/YLYhDns/mbRA2Tlo4wrcOsZm1t22gPptq2aK7N4hs+jPAbukyt7RNIjkM2TYhhTsZBKSbO61gfgTc10cnypoDATY0gnI91m1CA7AcrG/gMAQEdBkrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oeTIng58bc0knVYXaB9Z1hBvvjYmg/Myu3R7qfT4jo=;
 b=VDtwDW3LEh/ycpo7w/lgV/KIJYmsIey6V1DP+BTam19qANk26ZFkih0Uj7iAd/PrO6FEwB5mQlFeKK5agg6oZflq10oIg/SBfkfzyvyPshOzENyyDd3ZkHmGwBV6vVIFn5iKleExlnj7/aCgeZZcs/fkhca6UqAMXe2xU6jEorI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SN6PR2101MB0926.namprd21.prod.outlook.com (2603:10b6:805:a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6; Wed, 13 Apr
 2022 02:49:14 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c0ba:ab8a:5700:90f6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::c0ba:ab8a:5700:90f6%4]) with mapi id 15.20.5186.006; Wed, 13 Apr 2022
 02:49:14 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Add VMbus IMC device to unsupported list
Date:   Tue, 12 Apr 2022 19:49:00 -0700
Message-Id: <1649818140-100953-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a476caf-d9d3-47f0-6f13-08da1cf8322b
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0926:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <SN6PR2101MB09261DF129CA67FF5450EF0ED7EC9@SN6PR2101MB0926.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbVAuZ5R0Wg87Nnjvj/HV3jh1BTnDP7J0F7SF44HKS/ze0oSpfGtH5noRxc3ottCsRy0Um08x0XHANq+SZBbNdY4G7bBmTVc1l1WzyLuRUsjSoHfosk8U2itKDT6REBblK+d9YSQ3eXEek+qwIeKmzBEh07OnqGyl8IxV7DdMRq/hJI5ruusPs9aoF9lTz5+xiESvpvlOpvJ6yqstCk5MFw/ns53YNoryNwTGcLn1InW5L/Aw0DaWL1OdnJmxVwSzndgTOYhBuFXzvrEvU+fMRbRBiXB102CspJsAu+asksQ94CrbcojdKX3BLWc1JnIMqdtAlWU/EAXCSGUpbIcxkcPEszp+PIDvvogExJHnimOBE/Rriyb6oL3yXqzQgbwy8cJmJE0c8bZf0nilfv1uHkmthx47LjMnOoMTkqUzkKra92PFHd91YVpH1wV/FbFpwu7OwBW6dkFEQY4iCF90DTMKZEbp+BZSHF8cx9kYlXXMz62KLisU8GuFkizBAYeuSllrmV7wkfY8ouZ4efiq6FxGE6N2/olrgYXmPtTrgablx+T1/p8+xnRCiVxLKM9oABA27AKdQKxXCYehsrVm1U50G1gLkRu1TDx9gch/5FpbtSJ0yvWKTRgvCODa8IDaQa+JN5piKbaYcrMYIDtRR8wJ//8iDTo6Y//ATVe6YWjN80tHsoLZzS4hfrtFJgjAsHoUKEurHIy14FbP3V074LQu46V/nIu1rl64FNv3oy7BzPg3GjGnupJ2ExW34Xm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(2616005)(6512007)(186003)(86362001)(66556008)(316002)(36756003)(8936002)(6506007)(6636002)(83380400001)(107886003)(6666004)(82950400001)(508600001)(82960400001)(66476007)(2906002)(8676002)(4326008)(66946007)(5660300002)(26005)(38100700002)(38350700002)(52116002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qAiRIuvx31rjusv4eGPcSAcvYc/y3n5JOdnmjVm0Gs1uqiThvlMgW9CvRHz?=
 =?us-ascii?Q?xmqLE46YsWSPgj2Au4NYoyBfxfZbY8CrWiHJtHdiY5a+OY1ppSfufLV1/Ots?=
 =?us-ascii?Q?gRHArRyNSWnkgUnKtymkQAdI1RXTeqaqw4u5aQr9LXvk9G2a0qn12LB1XtqL?=
 =?us-ascii?Q?QJmGcX3gB1sqwXbTQ688YSAq6X4BYCnasUNtV5U9KFsmZzSjrhdSyYwmqA5Q?=
 =?us-ascii?Q?tW5f6QAihLaqqvqWi0/vMlHSBErI71QxtQPM6dJbBSkiDP+Epx0r0/sajJV+?=
 =?us-ascii?Q?CGtPRS32QF7uRHINTTd8JqMjh+ETkDSofH3JCkD5npQ1dxr5mlOGGx0Oquf7?=
 =?us-ascii?Q?ZXVt21c1bh/a63uyerKGsLxRoGiD0h3oI6yubNjEDDqz1wpOSFQ7ga5X665H?=
 =?us-ascii?Q?sx8qkSKhQ0Mi0devOSCsDAeSNm8+JtabfIMOYkgsZgP67nzW4ba24XIH8EZj?=
 =?us-ascii?Q?sJFKAQbZpE2VZzRmiJ86Htlrt2xGoyXa/c81XFiGSB9vVWMLLOptRxnhka6f?=
 =?us-ascii?Q?z6J438yXzNZUfSiHtnNnkXWDiuvr+hjDamyZHSrUqTTAjGeSb2dXjeqYpbcM?=
 =?us-ascii?Q?Nnw0F51EJGg4cImaNTqHDhL5ufOKWJHhXwf2+1zcUXDTwtcFu/GJMl4LpZuq?=
 =?us-ascii?Q?kkZXqtll54/F1bzT06bRbp/FjOIqqf0NqlyDbtWFjOVIG/jzksd73KetHaoC?=
 =?us-ascii?Q?me95Yo3hXgyCxR81Elu+MGKlAy1R0L22YrtBS5i9lNva8Zk9X67tWeUe7yCq?=
 =?us-ascii?Q?JoTN8eXPfBHpWOXEIEDAAuQF1a48wX4UKaoscLIZ7LiqjIq6/pKxo3ENarTZ?=
 =?us-ascii?Q?8s2T1l3/lQimKxLV7iI1GRTfYAmkwv3KCsKq3Gb3YukPcmwqJOWN1SLIT+0m?=
 =?us-ascii?Q?fRPs47ZkFg53E7j6Z6F7uUL1JWukkf7vCfoym0Rl0NDuXkHh9P8gt3z4jf9G?=
 =?us-ascii?Q?MFPzEN7nyNmX6Yk+WClyIF3NUuYzE4CjjDMSP+ris7m7wIbLpdXZ5XurGzQV?=
 =?us-ascii?Q?/6MJjzLmF5Z4fY/sLLL9RMNI/SQ8Rqq4CBuKJTxjwgaSkBYR1Wb7crGUF7lZ?=
 =?us-ascii?Q?9VCrH3W6T7x0VxVqZNBv+u2ZuxpO1h505h5rQpVO5NJlgIH87hJKMmq5jzWl?=
 =?us-ascii?Q?2HiPxEGhErwGPifOSjOr+PkoAETFo3zix4ijPHLlQJqLmcLhrUiycZw2aw0x?=
 =?us-ascii?Q?6ptfsl8wgAINN7zbx1sjjJdbKxnmh2XHY7lrN1YPIsu4ieIMo3Axv++dVC8T?=
 =?us-ascii?Q?P42T7AACK0Rxaoxm9dG4L7aJGgIuJpBKKZ6XKS4LdxR3Abg6yF6BBZYUsbr5?=
 =?us-ascii?Q?ubjwKvfflM+dSwIcCRmfe2zrlAUDpe/ygpWaCkVz6kfDFPbNDx6Bv/TBPdgW?=
 =?us-ascii?Q?W34p4e83ma2BdDgn/fndz3MPFf9vfkrczsKV16UZf3CPntdn+7wvuXVQ1Gtq?=
 =?us-ascii?Q?NhKQkGS6UT5Qq1Np499RV6o+ijtxbXIJICGIH1Migbmn+f9pV9NDwsfHd2SP?=
 =?us-ascii?Q?jfOTHZ8GI1NrbobEVxtX4XtMDS2UDoBE3vg1VjIVBFu7hLWJVIF8FWnK9LF+?=
 =?us-ascii?Q?a6TXRCJlMS9WlAlqICAxwEpb02AwtX6hFaLy+FOjJJysbsNhR/Bd9uiRUOUj?=
 =?us-ascii?Q?1i/BKnJp+41NrPPAtrYA2qMV49katAWYa7zN0K3uSGGLRtkcL+T5q86AoPSx?=
 =?us-ascii?Q?oWCrV1AtUAOt5GFNKzhqlJAc2DUOWb9gxgPjGCoXtCV6rcnff7qzZQaZ6oq4?=
 =?us-ascii?Q?uPEdSPQ0xNBNBGvsuCJhdwgXYklbFMk=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a476caf-d9d3-47f0-6f13-08da1cf8322b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 02:49:14.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5wHfrQrkFvA3iDp8VWAZCNPrGS6Fz0Px75rvUPuUxOnKydJbleJAM1BT6SqgybK6sQuuSL2J976EjR3T9Tm+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0926
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V may offer an Initial Machine Configuration (IMC) synthetic
device to guest VMs. The device may be used by Windows guests to get
specialization information, such as the hostname.  But the device
is not used in Linux and there is no Linux driver, so it is
unsupported.

Currently, the IMC device GUID is not recognized by the VMbus driver,
which results in an "Unknown GUID" error message during boot. Add
the GUID to the list of known but unsupported devices so that the
error message is not generated. Other than avoiding the error message,
there is no change in guest behavior.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c |  1 +
 include/linux/hyperv.h    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 6037587..37718e7 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -152,6 +152,7 @@
 	{ HV_AVMA1_GUID },
 	{ HV_AVMA2_GUID },
 	{ HV_RDV_GUID	},
+	{ HV_IMC_GUID	},
 };
 
 /*
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index fe2e017..2d085d9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1451,12 +1451,14 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			  0x80, 0x2e, 0x27, 0xed, 0xe1, 0x9f)
 
 /*
- * Linux doesn't support the 3 devices: the first two are for
- * Automatic Virtual Machine Activation, and the third is for
- * Remote Desktop Virtualization.
+ * Linux doesn't support these 4 devices: the first two are for
+ * Automatic Virtual Machine Activation, the third is for
+ * Remote Desktop Virtualization, and the fourth is Initial
+ * Machine Configuration (IMC) used only by Windows guests.
  * {f8e65716-3cb3-4a06-9a60-1889c5cccab5}
  * {3375baf4-9e15-4b30-b765-67acb10d607b}
  * {276aacf4-ac15-426c-98dd-7521ad3f01fe}
+ * {c376c1c3-d276-48d2-90a9-c04748072c60}
  */
 
 #define HV_AVMA1_GUID \
@@ -1471,6 +1473,10 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 	.guid = GUID_INIT(0x276aacf4, 0xac15, 0x426c, 0x98, 0xdd, \
 			  0x75, 0x21, 0xad, 0x3f, 0x01, 0xfe)
 
+#define HV_IMC_GUID \
+	.guid = GUID_INIT(0xc376c1c3, 0xd276, 0x48d2, 0x90, 0xa9, \
+			  0xc0, 0x47, 0x48, 0x07, 0x2c, 0x60)
+
 /*
  * Common header for Hyper-V ICs
  */
-- 
1.8.3.1

