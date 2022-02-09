Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060E54AF631
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiBIQLp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Feb 2022 11:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiBIQLl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Feb 2022 11:11:41 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2103.outbound.protection.outlook.com [40.107.96.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1691C0613C9;
        Wed,  9 Feb 2022 08:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHXqBxa9rfEyB5QhR3hdIiXui89fGXwDS/EqwLAzzG7o2Yjhgx79ps9wO4FHKCbFSQuxN9VHH3QzPYc5Bh+ycJssJwI40S9wvYpIjjkdt4ZXSmyiprqxGjEeiZy/XxmBQyOhHPmtE+YGzfYMX2g8vo8lnifj/EayWl6CPX0kc+lEnJgoZAWCe2r8yc+ut1kS0b05N49tX90vL+AqULUMf4x2UWoeN75rraXFiOxGwXizC95c8zMASyzZVc0gTlhpQIKNuICtfkbUZA0NNay/UK5ODr1rjeabFrhNJQnFdzIhjKHlTr+pI/MF/L5hp28NaX/CZTRw6aPLiIzpiIjXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm5TDr4juKDhNFIYSzECJ96NqTCT09/B1jl4u5HVFBQ=;
 b=gXZdLcBz/LcCMI3aLFlVlrDa/eS+Rii3+jN6tuarRdCT7OLQseAzdkuUIh2wl0j7XtQlic/OfqtOdo28Q2wqydEybtUmlT9RmzZFaWvRPhhP+4R+3dAGKIo9C+J9Vod60wE7Fw0ULCvKKXSy/vLeHTGk/zXTpm0jlP/1CdqukwtHMNq4bQBU2/ugQNToaNlqskend5IVXZwOEQyw9fNM+YIPfqwAqpGkUAdBbH/HobZGzsvIVo87mIuFI2suwO7/RC2gza5VHKbWm269naJLt8h1rddmFYmIgfU6/e6Ea9vEj6CXUucHZu6byeynpGt245gdLSd5C/SKqxNTu3ouGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm5TDr4juKDhNFIYSzECJ96NqTCT09/B1jl4u5HVFBQ=;
 b=CvoWUcfpV6wG/vD5zn3LFNeqan6rbqRAPUMfZVjt0m/MzGdmm82nza0OzWQo+PZgbVYvzXzzfmqXi9x8Gu72ucM3DqjMsAbfGWPMnPFmS2u8k8AfAOuUajExyP8wYS9+wMr+iyNQ+K3oblGFC7FxWysL0DcuvgnZUZxrh6cTlow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BYAPR21MB1351.namprd21.prod.outlook.com (2603:10b6:a03:115::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.6; Wed, 9 Feb
 2022 16:11:40 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::5598:8419:b821:a519]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::5598:8419:b821:a519%3]) with mapi id 15.20.4995.004; Wed, 9 Feb 2022
 16:11:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] hv_utils: Add comment about max VMbus packet size in VSS driver
Date:   Wed,  9 Feb 2022 08:11:10 -0800
Message-Id: <1644423070-75125-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR10CA0067.namprd10.prod.outlook.com
 (2603:10b6:300:2c::29) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356ee230-076d-4993-5963-08d9ebe6db8b
X-MS-TrafficTypeDiagnostic: BYAPR21MB1351:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BYAPR21MB13517F0C1F16D6C664D19BE2D72E9@BYAPR21MB1351.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIBOwZb96P5ZE61N9e6G0NsYw/+n83ItsQD5a+5Re3v8pbOn19ZXQie5sketWpvN528BLs5GF4NybUOLtSX/l2vZqqzQsorIov+UTSt/4iLyouf2EgMdm+Es7L1GJ2Fwq7fthTh/vfGx0IBBMQmOYGk12sFoxGjWvcznKLKO77JzIrfvbthj4X+EVdY6Tl+UPfwsXAlQkmBv8RFuARPguUWEtVZYkAIastC5ibAgb9St+fXvvLE1HqL/qe1Dxmdrwof3GQVWMPKKVnIopI6+rOVoWc2X68zbgyIzHkbQg74Gm/McYppOYJDnKueEImTs6IAEagcGZSWKbZngrsfJOlDTARJVvGtb/RhXNrzSaKqs7DxuhNT45DFAQ/T9BaC9o3g1F8o0pf3QszYuiXi3uLjZGw7p+ttFLsH+HpLEUjliCAvHYIwA6lMVTqQQTUtmlcYxeMev22eSMITVFbI6oE6iUBaAkUqp0/Sd3Zi9fwXKCAAx4QueZHJqVcyBH6v+6MK2iy/o1WdDEAa5OxRTVx+pZgQHvgr8IwvB8FWTARvAxUslYf0Qb/qtjldwkZhEjVhpm/TShIgFsQrnGVwnbdiipo3NNn+DRdwqza0IkSkvqzToXFkYgpAGA/N7HHKlx3HJlx9S1BSSnSWoxec4IBKyzpWzrV2ltLiZNOIPW06As3RiDEwklulYphxzalpbS2m3qM5mvzjKaYM9uoIDWma/skdtqdv72yNVi+XFH9f1kPKwQvmWqf94IWPt02XK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(86362001)(107886003)(6506007)(36756003)(26005)(186003)(6512007)(66946007)(8676002)(66476007)(66556008)(52116002)(6666004)(2906002)(6486002)(82950400001)(82960400001)(508600001)(38100700002)(10290500003)(2616005)(4326008)(316002)(5660300002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPiGm/+43NhjecBahEAXBiK4PE/a/4B6sO6r9PO5fWAm64/zRek/ve/bIDal?=
 =?us-ascii?Q?x6IT52UL1qqfa8Bzx8WxKDT6ZCgG8NhddHAQ3SLptn+zg//6uQ4jlXWiPkRS?=
 =?us-ascii?Q?y8wMJ3Hf2DgqD/gHJJsWtc71jyXCO1TuUmIUHR6mreTaCaTTyCf3tA+NpM+I?=
 =?us-ascii?Q?krckL+IkovuMssmi11Dqdvkx/jyIv7mdGqvFtgIJqxdmufkQ8/105IUAUafv?=
 =?us-ascii?Q?ueX5y+dIwC4h+uygpb0QPUHGouPegf7T3KmQ1NFBKkc3MNZ6gUL/dLBvFXvS?=
 =?us-ascii?Q?E/UFB0vx7qq+vq1wVhW4v/y77VmZPWZ9c4KmExGw+JXtKCy2gXijdxejdRJX?=
 =?us-ascii?Q?k+Qks3AUuiEOkWbGIKwRwU4/6ARwNwY1akB2Q1hiJ52jL+ZslMrDhtghhG94?=
 =?us-ascii?Q?TCHpOo7ZFRZzP2e0i7680kDhS3tMKm70TpZS3b4nPaGuXIOdaAtkuBp5ZAIa?=
 =?us-ascii?Q?jn2RBGHcTalmNqI+FDTxqQKr1tpzVPqwtPG9e68lIxhN0ceLc4ivFXAh+pw7?=
 =?us-ascii?Q?yj3vNooUGyXkX5JSB/SdxQYeBa/u4r5dSOmT3rKzJ+c1HI7w5U5JLOyEuaP2?=
 =?us-ascii?Q?fsQlYJ+GrzRMvTm86F8UGADgqJyUZCni90WMLM88+RKOpBDzTD7ORXsQ6kq4?=
 =?us-ascii?Q?aqq7X9zvHIRg1MckeXK+TJpu2nCfIdg5tJKj+ICxxPPohhT9WRY+MsYl1xWP?=
 =?us-ascii?Q?5IrB+qq/iM9oEpN/E45B+JEqsa7zld/4zfrjplTGSFNSDIHxO0+VHTSdbLcn?=
 =?us-ascii?Q?tHh2zNWKD3/XeOyAouluFtTIxAefmzUARYvUpjxc1NWKm/0RBQFUJti5aYgm?=
 =?us-ascii?Q?XEWHzSFBRomO3melc/ew4QiBXEG30dngGpazx5dIZxgJZGXK0WxLa50iCCvN?=
 =?us-ascii?Q?tauUmPu1hhw2XIQJFjKszvT/LMyNXQbWVWGc/6nEmPZ8XkOLqWH7WLeoVweq?=
 =?us-ascii?Q?SBgpJ9jvJFGdgABYB3C0e7LAHlZ/s89swG7usk5PEcO0VSwZny+ISDK3GOq6?=
 =?us-ascii?Q?pftzfK4q39V/T9H5UEAhnx1aeI10jmDHAsAzWvqJnnaR9slboxf/G6WXEmyH?=
 =?us-ascii?Q?iWAeqbZldqXqPUgR3kOUBDPeG53yt5RClteYHPpPnFxmqxcxux2BFfademYJ?=
 =?us-ascii?Q?7iNzAZNhEiGZjqkSofc3sYhzNdtFbeK9+KztJmeGTeKk3DhLolRyLNq+0rDq?=
 =?us-ascii?Q?bnLLbFGk6a2UWc+hWrFrpWPgcZRBMlU7y/pxxQi2B2VONp+M9fugIfhbdVvt?=
 =?us-ascii?Q?dc6Dql3XKd46fANEowXb8xgDJMCdy9jPfZNSKh+kjLpevbbhp80JFPf0P5iC?=
 =?us-ascii?Q?pYV+9J8NlT6UggYKMjZvQEPhIN/OYtyKIydB67trfSwHTJ5dIcjIrY4jIA0G?=
 =?us-ascii?Q?zOW+CqzADWjLUXrfoNGHiCTGa6BA3TpbnE4C2ewvneY1l5JJjig88S0Deq7K?=
 =?us-ascii?Q?qftYO6Wr2jntZx49Egp/FaHRGS7RyvVzyRCdy4gmmTzhdvqPmpSD2IpfD+sb?=
 =?us-ascii?Q?26mfXJhn9iELfATTjQY0RqgKAvxGtGPxljEWPG89zKczz74xVuzsMv4RGPBN?=
 =?us-ascii?Q?qwoAUeH9Sdu/qtduVbJshyewzQCa9zdYsGY1OOwlVjfX7RdOwCWqE87QULQo?=
 =?us-ascii?Q?jGVoJU05mXDTOiWhpusG3uI=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356ee230-076d-4993-5963-08d9ebe6db8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 16:11:40.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3UpJyC2bLP+Aj2fxuzbG9vmI0U1JWmlhjcAujA+0emb7RV/KR6/9kRNEkQ6hhEZsAA8nnU2etI/X23r2Dq/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1351
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The VSS driver allocates a VMbus receive buffer significantly
larger than sizeof(hv_vss_msg), with no explanation. To help
prevent future mistakes, add a #define and comment about why
this is done.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/hv_snapshot.c    |  7 +++++--
 include/uapi/linux/hyperv.h | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 6018b9d..0d2184b 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -31,6 +31,9 @@
 	UTIL_FW_VERSION
 };
 
+/* See comment with struct hv_vss_msg regarding the max VMbus packet size */
+#define VSS_MAX_PKT_SIZE (HV_HYP_PAGE_SIZE * 2)
+
 /*
  * Timeout values are based on expecations from host
  */
@@ -298,7 +301,7 @@ void hv_vss_onchannelcallback(void *context)
 	if (vss_transaction.state > HVUTIL_READY)
 		return;
 
-	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen, &requestid)) {
+	if (vmbus_recvpacket(channel, recv_buffer, VSS_MAX_PKT_SIZE, &recvlen, &requestid)) {
 		pr_err_ratelimited("VSS request received. Could not read into recv buf\n");
 		return;
 	}
@@ -375,7 +378,7 @@ static void vss_on_reset(void)
 	}
 	recv_buffer = srv->recv_buffer;
 	vss_transaction.recv_channel = srv->channel;
-	vss_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+	vss_transaction.recv_channel->max_pkt_size = VSS_MAX_PKT_SIZE;
 
 	/*
 	 * When this driver loads, the user level daemon that
diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
index daf82a2..aaa502a 100644
--- a/include/uapi/linux/hyperv.h
+++ b/include/uapi/linux/hyperv.h
@@ -90,6 +90,17 @@ struct hv_vss_check_dm_info {
 	__u32 flags;
 } __attribute__((packed));
 
+/*
+ * struct hv_vss_msg encodes the fields that the Linux VSS
+ * driver accesses. However, FREEZE messages from Hyper-V contain
+ * additional LUN information that Linux doesn't use and are not
+ * represented in struct hv_vss_msg. A received FREEZE message may
+ * be as large as 6,260 bytes, so the driver must allocate at least
+ * that much space, not sizeof(struct hv_vss_msg). Other messages
+ * such as AUTO_RECOVER may be as large as 12,500 bytes. However,
+ * because the Linux VSS driver responds that it doesn't support
+ * auto-recovery, it should not receive such messages.
+ */
 struct hv_vss_msg {
 	union {
 		struct hv_vss_hdr vss_hdr;
-- 
1.8.3.1

