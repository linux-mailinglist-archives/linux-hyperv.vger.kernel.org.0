Return-Path: <linux-hyperv+bounces-1875-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83088892626
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Mar 2024 22:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0741F2245C
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Mar 2024 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864A13B5AE;
	Fri, 29 Mar 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fYd9G8pK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11024030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2761DFC4;
	Fri, 29 Mar 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748262; cv=fail; b=iZ9ijgBMrEzSwGtKXfCOIIz5l76jgxQxCztwzrsr2v2tWGePAS8B8YbYCP3O23qo8FYz/wSJE3g7clJOMaUxLNYVpCgfRw3Ao25ru5dRg8i4Yy3B8FeH4TvtxLNPRXNsgutNfae3/nHsP9bly8h7xlhbV2C/ix/HRJLkrVVeIS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748262; c=relaxed/simple;
	bh=S6L0aMDSpr9JXtrGomNM3mxeaZv0TjafWVbFhd/0rqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gyMEQbOJCv84m0pdHazmbwakaOv8XxjfD2pmSbQoPswacqg9FURsA6qwZWu0Hf+sqEsyw9Y3OaABpf4DKmofitkdFyagF/fpLKUormXXIbj3daiLdi8HdnRZITCLo1H7Q01Qs0yzYIJqbaUpMwmqsLhj0MOOVHTkMR5biqhYU+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fYd9G8pK; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+up8M1R6nWQO0DXaYd+wBDKKGB1/bicu40p0/YdAkv5mb6OJWhdTlP17CsBYvU1cTe2Vu1zbbW6YoTYwwd5z7S6kl6IQHUEC0jVb43ZLNW3tj7LDj2raILYWoEZYKLAH9zyXdXnOl7SOSi3sysssQobfkShSKfrG7Ryok6ZfoZRaqFJdOUtSMhassJPjrGCVm+vRhZP1yAdu4Hvy7HqUlMb1DRItidTQpQVxDQySKDKS38WWy7J186NC3WxvAIPzpVARGxDwaEZsEYY22ygnefkgr9AYW2iQBv1uoDT7TkXzNnCi8BQr5901BOXsVzNRVC6Lvxdp964ME/YMDJgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfHPjpSdpb3n5TmADUT51NotEHU/T8x/LYgaeWnszD4=;
 b=aUj3LJd3Ycvr0X8wVDCBA+o8mkkhLHtN9ZiOsnIh5olXttKBTwCbXIRoC0lcxj1hw0EqW+pqkqEN+8c1JJzbZZOEE0/7AAhxsiOgWLO+UHcuX9Js1Vlfqv3C6A8O/8l0hWiUg1iDBDAzao1x2NJAJKy/8u8Jsf2Df1QEtBzIafwlUZdCJyLIUO1dpqnbrtFXnwmCyLPFFjbr5OKs3ElFhkEqsMpxkrzN7LpbuZ+by9Wdx5f8yztSBYsoPwiZo0DODN70WlrBNZpJXqkcFghQWiSDWgY0urDSSaq17d/MtOnED8MC8FEVqXr3SQEDi/13645W+q7K/XJ4hxyxUQKEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfHPjpSdpb3n5TmADUT51NotEHU/T8x/LYgaeWnszD4=;
 b=fYd9G8pK/2EHHOyku2boMZZTEYjJil93H8Okh3VJ+6wmjgw0AN9tZ4ZdDJdGMumeTHFSqQ0bEwApO+U4Sh1kSdhCXJFwpcrEL090BWAyTVunPzM9/Y9HoAXH0hDO86WeTR0EFfigssLcFOoaZUZSVPNtGOVcFLEhnLmCB5bLOAQ=
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ1PR21MB3483.namprd21.prod.outlook.com (2603:10b6:a03:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.14; Fri, 29 Mar
 2024 21:37:36 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::6528:5de6:5ea4:c1ab]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::6528:5de6:5ea4:c1ab%6]) with mapi id 15.20.7452.015; Fri, 29 Mar 2024
 21:37:36 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	sharmaajay@microsoft.com,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Date: Fri, 29 Mar 2024 14:36:53 -0700
Message-Id: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ1PR21MB3483:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 2Ku/LBwCcqrbaEx6WajYxO2bJE1wRc1/UmkkB1NQjnCLJv/iKgt9h7GpsW+ghqYk02boFss1T8LHLMKhIRzRY/33/YzLMxLUJw3lOXSlJ9U986LDKYqhjGpDgeg2rTNL6GGV7W59dbgTAyGUmtoOhyWIJR87QK5s2Zy5yCCMnFMNPINGcyybxpNMIGU6rtfhrWUD2VhNKIZWC5uM4Hlq0U5hc2daefmZaN4u9+a0xsfB3W4PPXcKimkfQwNelA3wmi33J+yi74mq/oMcjp79R6GECaUFmxYh0W9k/rV5eNaU71QLByO2nwZROkj6u3AOd9c4q5nUJLI1GTHWbCMY6d5lVHFaU9sF5rcOwP3JLUcWuNckouUW/3ibxfUBslG9+w2aANVnFa9PvG3J8kmqEtKqOf6GAEXH6jCT7F88w0KSHA747RtIsP8KSFWLFC2r/6n0vdOGP7UdGiNUpby/OCQAyDD2yCe77C0fnFLhpEJ+yLaCXv3P7/whpDFta9pzX4QrthuFKRTo5zP3CB4IwUhUess9Wk+EUkcMq/Hww/27g++JIPQkyIhCsthN5ikSoMn9XFqXhhW0M57njmQn3ZMN/Bt4UKvs98l968yZoWZ2XXgeOSypq9OfrwVR9o7QZf+/pOA18a9pBJksxOdHI+lK6gJXL2o55PIGmH18Sgo//MXWhHoAN/8yp+PcRFkfOELKdetoyC2P2RkcgIGFUKIDljA8iVtUEx4HikFzEAw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?RRifRCih3C8HkWBa8isOeD8NZLiEjS6Sx0Ha6ACgXSDSbbudtEc4pY7tMBWP?=
 =?us-ascii?Q?AXPuUNiTlJzCDh3KZ0krvkrrmbVW6ubMf7utbQ5GdifXuPwzaj4hHTATytyY?=
 =?us-ascii?Q?wfUElHzsJgdqBlkYD2l5Z9nBQyUKVtcC9/91I9RtMEOnX/Qf7c8lb+tHd+5i?=
 =?us-ascii?Q?sdtDOAQcHI3nZqEo0/ZBCeSI+eKe4bxYqskPqpNt2EOjmoonoq+pw8Y8i5+A?=
 =?us-ascii?Q?z7gyHg+Up6p+nbetWV8Ztyq2J30/blP7zyzrxcFS624iyKQ5jN5GlKV1sJxQ?=
 =?us-ascii?Q?Yv135/UYBX7n87+EGGW/9hS7O+vOpJV2jkbWk0CPAtNi0g/o7J15TePfYppp?=
 =?us-ascii?Q?VghHsNq6ouqc8Z+Wjsyhph4Rxe5H/PDNZzRKOe+i87Wk9T9XL4UGgLz6KJvf?=
 =?us-ascii?Q?yDP5Jts6TF0jnJl0O8Y7c28SCIxJNBtpthTXQnxuruVBwtbpIWQTJjTONR07?=
 =?us-ascii?Q?Q05b/bVl4TrHIsdURrX56B+vn/t6UU+Mvc3wnH3ywN+uPzRqNu1VHlSGft2C?=
 =?us-ascii?Q?7jjoL+twQfrW6QwFSVSBJJZDqjXQHTssVD+SAJsDgkociG/hrhAz5q1V721m?=
 =?us-ascii?Q?5tIaGkClBT62EOcXnNUSrb1UpDgaA8aVbn9VxivjhiHfMO6pylv2aIK+4yMZ?=
 =?us-ascii?Q?+7LCrKz7IzdC/LtUl/s4HJ73wg0TjFXI/8LdMGaMMSDqPESbMCeHTJqTr7bM?=
 =?us-ascii?Q?0iAkVYn1BwdQvdUi1F4fCRIvDSDf/usQR8L1jGm4L8h/zW2rxmn1WtRWZZTN?=
 =?us-ascii?Q?NL6gZEYDamc+Ogd6G+PpEgBGFJ1NOJhIhNUD0L0/WLTO1iMZxoOV8aJodCgr?=
 =?us-ascii?Q?14jFdr2sIl4tetbQxXN/lnEEYKEz+neUSlyVGlOuvVZ+eE/6oPRNbj0aTCr3?=
 =?us-ascii?Q?hRkJWh/eBah/Ye3UpPgRlHgJ0+2CK/8Hcb0j3W2qMneCDNyc1Duzx30r714r?=
 =?us-ascii?Q?hVnwMM92AvBh4zqJRTd0/Sdpyud9536MHJ7NV6+5Qy6MCS7akyLFfIoW3Tth?=
 =?us-ascii?Q?qeBusz54Oh0Yv2jo2BzHfE+w//n5Ck65WwYFqY75UBO90R+UTsSatlE6Yp+z?=
 =?us-ascii?Q?VLQyccetYjE29NvHb5lODYNJ+MZVKy865+aO4VNkL/y/YMUHtSRT5wBztIZb?=
 =?us-ascii?Q?AAkd3ZIQCDQ70+53B+/GcIjZE/rLn3gJKzfHNZusXsjcSZ6BXrBMMXzV5/Xf?=
 =?us-ascii?Q?6iu/ra1IeHLp98NybXOr8osG9W35BVz1zKYVfCVuzP7+L6fi8ezyWZYXJLee?=
 =?us-ascii?Q?gfU602kWOMB3mqlAcsdpN49m/+CYiGXS79DLXkgs89ZlcxGiFN1u1p/c/QkP?=
 =?us-ascii?Q?1CAoQCb1U/Bb9DIJqmn+xjXyhbONwRwbQ/fx3fAFuzQUve1dt2g5+fs2yVP8?=
 =?us-ascii?Q?7egUEO9oLwNY3qQH+zRxTBse2w4maiFr45+/tc5DuL1tu09A0iwksVFzu7ON?=
 =?us-ascii?Q?4VItwdDsp5ScS7EQbwD8G22yOFUS8h3amjS7SWkm4Iax1LGaexrf1EjrKV90?=
 =?us-ascii?Q?ANSX8G2E3wB+LK8/jNpJbFJ+/pcYobj8762g99YqkbdQsGE5LwebyrV7Zt0E?=
 =?us-ascii?Q?90rCt/vq117uE//06IlTzmUNPqJIqchODzyFb7oG?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4d1d7b-73b5-462e-bfb8-08dc50387312
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 21:37:36.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nUR1qXP88MO1DAlmIlbknB4ftO0UuN97J7nsOcGE5t/lRakagsLUVErp3YlCGNIkfx0TlaJKjBWQsFwXnKwMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3483

mana_get_rxbuf_cfg() aligns the RX buffer's DMA datasize to be
multiple of 64. So a packet slightly bigger than mtu+14, say 1536,
can be received and cause skb_over_panic.

Sample dmesg:
[ 5325.237162] skbuff: skb_over_panic: text:ffffffffc043277a len:1536 put:1536 head:ff1100018b517000 data:ff1100018b517100 tail:0x700 end:0x6ea dev:<NULL>
[ 5325.243689] ------------[ cut here ]------------
[ 5325.245748] kernel BUG at net/core/skbuff.c:192!
[ 5325.247838] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 5325.258374] RIP: 0010:skb_panic+0x4f/0x60
[ 5325.302941] Call Trace:
[ 5325.304389]  <IRQ>
[ 5325.315794]  ? skb_panic+0x4f/0x60
[ 5325.317457]  ? asm_exc_invalid_op+0x1f/0x30
[ 5325.319490]  ? skb_panic+0x4f/0x60
[ 5325.321161]  skb_put+0x4e/0x50
[ 5325.322670]  mana_poll+0x6fa/0xb50 [mana]
[ 5325.324578]  __napi_poll+0x33/0x1e0
[ 5325.326328]  net_rx_action+0x12e/0x280

As discussed internally, this alignment is not necessary. To fix
this bug, remove it from the code. So oversized packets will be
marked as CQE_RX_TRUNCATED by NIC, and dropped.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
 include/net/mana/mana.h                       | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 59287c6e6cee..d8af5e7e15b4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -601,7 +601,7 @@ static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, u32 *alloc_size,
 
 	*alloc_size = mtu + MANA_RXBUF_PAD + *headroom;
 
-	*datasize = ALIGN(mtu + ETH_HLEN, MANA_RX_DATA_ALIGN);
+	*datasize = mtu + ETH_HLEN;
 }
 
 static int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu)
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 76147feb0d10..4eeedf14711b 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -39,7 +39,6 @@ enum TRI_STATE {
 #define COMP_ENTRY_SIZE 64
 
 #define RX_BUFFERS_PER_QUEUE 512
-#define MANA_RX_DATA_ALIGN 64
 
 #define MAX_SEND_BUFFERS_PER_QUEUE 256
 
-- 
2.34.1


