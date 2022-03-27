Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3474E886F
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Mar 2022 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiC0P1U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Mar 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiC0P1U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Mar 2022 11:27:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67913F89;
        Sun, 27 Mar 2022 08:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSwx0x/RqFfOQjey9622hSpwym3u82Jrs3dl3ODDOQuzebINcGJCgl29UU+UlAqrpSaVeA5B8Zpsd7YoF5krGln3T9tqSpWdjMnqTkQb3ZmFIvMM6Gt3pf5IHqanYLUwH5tryKhSQOPnLMVNiZESBBMfjalhDaAvS8j7DdyM1cBLJVp5M20v/2y/DOmC9vNSwxn6U3owLiHFJHLoF6W79+36iSOy1cnHD71wSeyYBEIV9xE084Oy2M6jteHWp3V94Hx7diKPio4uZxt2GjmuxM4AlUfZRgfXGvNJ2O65SMGKMG+KbvFyocEmb5VTRRJO/rQGERfImYYs2qii6lqVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xid1u31RIE5t3e5lCPz699WYlpsvDp25R6BYYMjH7s=;
 b=Uuz1DVAPX5HU2A1izIPR5RaU89I3K5y4tOFSHdxTfdgVLLOstOC8JXjbq05l1CSHvVVgIlnvVtcB909ZsauHBqRA5T9DxAomPNCVjN0OSZJ8JMPdI8w0oX/HNl9b2lxRtcFm/t1VfREqXPApEzcdnLTOziw+CKC64uveoNG/3vnnOl19bnzKeGp+O/e+83s6T6EA4R4di6szOoquFGt4vDoq5ivvanlBoDZokWrTa4pExKcyTJ+C0m4WJXaa8LtYl42wnnc4KVdc6h58rUnKCa/xbnMCkA6su0tu3A0IMfayCtDFm6qvUycJ2LJUz+tfSTjgquc+lgzuH9rHNyNPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Xid1u31RIE5t3e5lCPz699WYlpsvDp25R6BYYMjH7s=;
 b=bEMUYR74n1kPYnhfscgMTKd9khW7RUmfIlVVbX1if3Pb9A5H8WtJlnkcPIMsG8kMfUxX2JPPGI3sNpqV5y7OW3lsSzNh36rhKKOs7Biy4bT3TBT2LN5oQO8X/9E7dAL8bbYt8KBb5W++YHSyS+s+ynhCmFzhXRu3F5GkhLVsqso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by SN6PR2101MB1133.namprd21.prod.outlook.com (2603:10b6:805:4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.15; Sun, 27 Mar
 2022 15:25:38 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::f8aa:99ff:9265:bb6b%3]) with mapi id 15.20.5123.015; Sun, 27 Mar 2022
 15:25:38 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] hv: drivers: vmbus: Prevent load re-ordering when reading ring buffer
Date:   Sun, 27 Mar 2022 08:25:10 -0700
Message-Id: <1648394710-33480-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4c1f54c-1698-4b06-0428-08da10060be2
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1133:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <SN6PR2101MB11336736DC864E00B35D22B4D71C9@SN6PR2101MB1133.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VG2XeQNhK2WGP04noICO5Z2bcYlRA9n5kLEBwcpApE1zbEugem4j9Sk30ePGPz9Z8YFF7IBfe1epVZ0ltEVHeeDVHD8CPt+T0xzQAS/sEt5bwQCjviuzdstEI/JWwKZgZK6uCNvUVMwFKEJPfxZT0HK0Wryyzb1pNYGV9gQstqta9/QzTwRWBscsugYKMQ79FiGbHvnJaglgwy/Dxw1pRjAgT+ziRawVrt7yvR29uaP4KOhICA7JDa5rOQRXSeaqEOLPhcqfcl5yfQYM3Hqe4Gjzydh1eZs3wLW3cmH1gT4Men5YhYPPm+oiFVAo36EZi3iaIXG5kisqTw5NjfU4e7+NR2h4c6xxFjE2SIx4j67tX4Fz37jzF9699uK7mDKv9pGm/R7SuyuAehybBrIoI1VCOWz/OzOVhNPPXvNK04thtBumyrmbPqk/5de+5+rZ/LVj+kR+GdorJdePrqMLpqcyRPWHKoOwqWnD9x52v9TQ+BZCw2n8QemJbiSUSHqV6Wok0A0hWD0jwCHIGi/bcoWCD5M1mfzgue4y06ZbWUQJGGHWU30Fo+02SHW8JGnoUy12+QoZr4U2a5143XEwnGLT8VnbA0xorq1eWZWWJABIotPEnUYMITVk3zMGIL5mFqsw0UWnrwUxU9i7eV8E0BBHQ0RXwM6+FqbFehCAeH8niSrkvAv+xWBRduyjkUkbGxdEYo+Z6LZV87AK0j4i6E9X6q9KIIrjPv+kU6QVpKNpOPU2xtWFUSBZuaijLtFc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(38100700002)(66476007)(186003)(52116002)(38350700002)(6506007)(83380400001)(26005)(66556008)(66946007)(6666004)(6512007)(8676002)(6636002)(2906002)(8936002)(6486002)(508600001)(4326008)(10290500003)(5660300002)(316002)(86362001)(82960400001)(107886003)(82950400001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIWod7Ast9FWZ7hyaQzpLzzx/XGQmP5cGqweEQWRvv9GkR+h2GG4M5wCZT4b?=
 =?us-ascii?Q?wtl7QDFknMhKMKN1fld71RpTToUT1d2BEvD3mFPQHGPYT84+5DDJekiss+qP?=
 =?us-ascii?Q?gi+LB7pa2BekSbiTq3Pxj0FPPX8AIOLdrgTc0Dnp99Ew/K/b8sLN8E4PBP4a?=
 =?us-ascii?Q?NAiVdP09uoOv/cP2XD5YEFmXQn8zJl8SsDwzt2bAXi+ecvS0Il4cRTd0rP67?=
 =?us-ascii?Q?F7PhWd5uiJmwmekr/fi6dyAgSgoxVCa1lmsJb1zm4ATrWmgl907LOvIBuxDu?=
 =?us-ascii?Q?a1MhMVrjjelngQ9bF6EHUO4uBUTIc5yHK17f18QPFjDIaTULuPDKsF76G0vQ?=
 =?us-ascii?Q?NeAPI3EpKrl2TUQTx0795DjLqH3WXXcAvXyeAvJAwa4ACL+SWu/UBJvsod9E?=
 =?us-ascii?Q?eTJggpg2YlFfhhTFZtS4gHqfICSYd0UmyqPdMAkj4MI0pVMw0NgSPww6pEUh?=
 =?us-ascii?Q?TnClpXeQ6nUk+S4WM+xJ/CpU9BVUI7yXkHffH1EWjdN3l3jOEmJ5hiW3xi6A?=
 =?us-ascii?Q?DKDRC3ffwHj6J/1qZQBBgEwa7T2poNX4d+iHm4AObST8WA/pdLpnAXYUD9+y?=
 =?us-ascii?Q?6xWzjgoQ83mcmxwYXXs5wotexuEV4OFlrfJzga+fhnl2mA7+V8ZabOgl4/B0?=
 =?us-ascii?Q?PWYFy1a6MCUbailBgVrdU4pD3enrC9ZyU7drXwYUIw+ZxiLwNmWZsxUUVahM?=
 =?us-ascii?Q?UqDfGqHVFvTVcCqAlNGFWw5eqy5cVPbDGP/a+nI6Htmn8gdC6vI3CAhZ6mcw?=
 =?us-ascii?Q?iHuTmkh7aq0RIWXT7HlYtBDcYL4HkL8kiZCBWdjbzu9KC8VSVJjRbkI/S/Ak?=
 =?us-ascii?Q?qetg7SRulgbB+oyXb9KIEy91u6hnT3o536FWgKCKPgA7J09pu8c8pzX02B1w?=
 =?us-ascii?Q?GjdIjtqyMhBPWzKnxvV8gbUWcAoqa4KsWQ3grwNVmNMxUXoNBBPK0RX8E/Oe?=
 =?us-ascii?Q?Nbz4D28pzTRaB1+wq0gzf8LdcbVGP7eAiBUZrpjUq9WDKLvrqisxNYdM4mKC?=
 =?us-ascii?Q?B/PP7E5RG7Mk2/MKf/cyyWxq1/RK7atnOURgeUzocMNWpERkHJTzlPKEkDKW?=
 =?us-ascii?Q?xqapMJm88clQqdD7le6GxTXHwGBhAGFhhOn2+RxRzGL8CTVtwJDp2o6goRAq?=
 =?us-ascii?Q?rVMNIeVxPgi6RCcvHmSOhSMupEyYEnqHBr8U5G27B6KrO2iw24XJsPoB5IMA?=
 =?us-ascii?Q?lEkKIMzbIT4J0XCjNGQgQz1+VXDgvIQGDvRBQt+zepU9vQRc9SSXtvsCQMaK?=
 =?us-ascii?Q?q/KHAQyHo6b0EQfJf691vOVBnNdlf9pQ8FtyCbGylYyTvVySPn6no7eWUFIK?=
 =?us-ascii?Q?qmqUJlND8YVl5OruE6Z+HmZE8pGn3nxBPR71JLY4pHPxjHzA5QXG9ELQ242L?=
 =?us-ascii?Q?0262JASET3RWpVO3wHVVd3ybNX9gqjw5SZPCAAxQQQa+ffRDdxxiT0UFTx73?=
 =?us-ascii?Q?1bWOui5iiknMe6ncA2Q0ZpvZf690s+XQOIHc9f0f3tNBfDFSJLf9zW3tqUZc?=
 =?us-ascii?Q?U+EeWgYmcltPJFnwFDUxa4hhVdIalnFtHsYIcH97FAvFtDS+V3qnAAYg9w1K?=
 =?us-ascii?Q?N09Vp1hF/VKLBznCxlzyWP0ExkhxwJ4WdtRiT8DaMGzLmtUeE91jIGjijth0?=
 =?us-ascii?Q?4l4KY2S0jVCJxNpJrO/xL0ei8gq7TJuxUQzRm6oRbz48K7x9kuI0kLzEpsXt?=
 =?us-ascii?Q?uHZKBty94MF393W1J1pwuaqpxw2Pd827SrxrodREdDITg2BS3NpoTCatZTqY?=
 =?us-ascii?Q?5Ulg+8asafLrpIOANHb69MgRuO6aRT0=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c1f54c-1698-4b06-0428-08da10060be2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 15:25:38.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dlZsU6wpxWnUDdJFF5hyKWbiB6q634/jT63AKqv2ccVzZDoVveE2Gwocp2kpYlYcp91qsv7pa4OfIR3T42G+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When reading a packet from a host-to-guest ring buffer, there is no
memory barrier between reading the write index (to see if there is
a packet to read) and reading the contents of the packet. The Hyper-V
host uses store-release when updating the write index to ensure that
writes of the packet data are completed first. On the guest side,
the processor can reorder and read the packet data before the write
index, and sometimes get stale packet data. Getting such stale packet
data has been observed in a reproducible case in a VM on ARM64.

Fix this by using virt_load_acquire() to read the write index,
ensuring that reads of the packet data cannot be reordered
before it. Preventing such reordering is logically correct, and
with this change, getting stale data can no longer be reproduced.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/ring_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 71efacb..3d215d9 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -439,7 +439,16 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 static u32 hv_pkt_iter_avail(const struct hv_ring_buffer_info *rbi)
 {
 	u32 priv_read_loc = rbi->priv_read_index;
-	u32 write_loc = READ_ONCE(rbi->ring_buffer->write_index);
+	u32 write_loc;
+
+	/*
+	 * The Hyper-V host writes the packet data, then uses
+	 * store_release() to update the write_index.  Use load_acquire()
+	 * here to prevent loads of the packet data from being re-ordered
+	 * before the read of the write_index and potentially getting
+	 * stale data.
+	 */
+	write_loc = virt_load_acquire(&rbi->ring_buffer->write_index);
 
 	if (write_loc >= priv_read_loc)
 		return write_loc - priv_read_loc;
-- 
1.8.3.1

