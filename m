Return-Path: <linux-hyperv+bounces-1909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D89895CFB
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 21:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA3E286010
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04615B999;
	Tue,  2 Apr 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dJo13Rmz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11023014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126115B962;
	Tue,  2 Apr 2024 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087345; cv=fail; b=kGcQ5jgD745gQg8q7lNOxpAxCcaNI3PjM3RXjF/jh2AfU+l2JDik9eQHe2B4QpqdMIA3pPw3vQRKqamFK3SQI2mDTyVbR2EaEBdYxv+kl5pzFNgQYxWjy91RdBZ0J6PJx9mLTTjHlPB1jvlBU061pQIEeVWyc1KFY4GoeehVhXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087345; c=relaxed/simple;
	bh=4gBmlB4QnMdCB+qk9ADDH37vSQfTnSAo4LreeoM8wMs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I2YKeoHIN6mcqoRspqk8u3PxhW1c/PJP3+LlRegLEghE3mZgaXm2yXn6zkN4TiF5AOra3Ef0D7KOd6FpEtyFtplDW4895ahzcxdETF5KX2AaTcUqPJpFKpH2v0uMpTEDphA++jrEVjzao6tBafg9b3vMNpk5b6o3DTyLvBmo2WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dJo13Rmz; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMGFc0QDtCdbcN6ggkf7uVCtBk0jrj7ExFa3LOtcFwlR1lrYtQbpBSZUuy+7Ycym3JmmkGjyXbd0KmZsHL0GYT1DSXggEl863W1ywXpgRc43FDnwxA+n5F4v1irxqMEd9OPQyPfLkVRvkKA+xorXFFgZPEdDmsP5Pqqa12wfTcZfeMxDoHKxGBsMdNPeLUf6Xk2n0vDBoAzwo6SpmU2N+lAKcVhHNTUGrrWOuUB20MPN/j9QCk2VqBb2KX3temCKh8ahHas9LXIVFtXUYKuyl5svdglMCLzxGTq5wOQ19OtnSaV6YCOhA25S1YEiac2Vdf3y3Y5s5OBjlTNdNe28kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFe7qoE8AgyF+oBe3ahfOVxaBndjPKn7fevGnNeAFb8=;
 b=b+prY48cy8HUbwEcZP+krkjF/b8N9sbE2M1xBwfpbWVDntE/YuY3Ad6hHPVoQg21UPet+FtvTZusmVDqHdBfuO9q1YVHGNpYJeFIYb27LChXw+KecDXhFu9sXiNuhwJiTIDFfWG6vbsPOzZM7S0t6hVxvTFK2XezsG1Bn/2X144JitLvxS+Kq/FOsGt2+wT5GBMPsK23UndLqXWktjlJNgMQ6eaNqUN7kCNIW6ORIC158vIWrX1LcaQJfTUz8yzsBBig+UTr4pIWibOGmqu7Gz9P8SiFKkE+YJPfgU2d2e5nzd1oprY0yrwy0gZMgfa3oZgdmefSohjpy8iFhEg7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFe7qoE8AgyF+oBe3ahfOVxaBndjPKn7fevGnNeAFb8=;
 b=dJo13Rmz2hxqisS7QD3pvAYpHd9Wqm9BenVIZjPewUSQl93D/WYB+jtlisi+PnYvVusFzPYpG1+1L3F1qZT345HQOROgx0gfS99tRmI0lkuAVSSBY5S/wBLT/XBbwqzL5MUqXm0lsUQBhXulT8Qe4/xQNoQvh8KFHdp0l6iuKHk=
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by LV2PR21MB3109.namprd21.prod.outlook.com (2603:10b6:408:17a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.8; Tue, 2 Apr
 2024 19:49:01 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::6528:5de6:5ea4:c1ab]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::6528:5de6:5ea4:c1ab%6]) with mapi id 15.20.7472.007; Tue, 2 Apr 2024
 19:49:01 +0000
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
Subject: [PATCH net,v2] net: mana: Fix Rx DMA datasize and skb_over_panic
Date: Tue,  2 Apr 2024 12:48:36 -0700
Message-Id: <1712087316-20886-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|LV2PR21MB3109:EE_
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 utpIEJEpquoNgr/Kz+LkAgOs2GFghWgRYbOGS65AHSbUf83g7z7Syb0/Oo5l/BcQgXm0r2dLARvrZFWeOhr5lY6LRnZTfJgxTnllO85762DgteBhgex7dbmN0mvR1eLMFvVYSamMJ0e02C6O4WQIXckt5bqwx63L6mLlLwU9lIM8fZcLB1G2n95em0qGr8vJPQx6yV43wswHALgTUwgD3ZEEhJLnH4M48IiPUd8rshImo4MzbizanM8a/KqhvK3EbgUy4hPzNYNDpee30g+XKKHgfIDTwDFzi2tPWHHF01Od9VvbksdHMmXL+vjdkf+RCL/Y+uHht8hkSeA5sXJ4qzseWAdrVZn1y70BqgLppu7d3FJWciXP739uN5f8W3ijCa0npVTtc5KgOrU22EGBp5DOsi6e7onse41GquWafbL7aP7daFeZyx0s++S2wH4v8vGU+nwpiOGfXVd54G6IZlWxjsIp1YSUeyaFDSDY3eerbV4I8sb/VJSro3DnXgeEbWFcJxePVQvp+rvnER8zi981++Lv1JEs6Azm9vWfRR1nXTreUk9eEqr7c4rNpzrNQtT/1KoDBQbn7HumDDlKUrEup5nx+8Fd6Qr2XCNh0LLeaM0N/kCCj9ucMpyeLyiFiDQc3c/D5l7VlgrUeE7mmiFnW4xf60unc8Im5HAaeAXexbOZ+S8PC4R1cu5bwi6eDrggrf6Pw9J0pGdzO7XDpNDUCtfQPx7O/i5NE511fiA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?tfZjtemBw0aCr4zZY+T+fFYfHMBfMNq0KEfy9LQGhE2Fzsn+LCEseKWT4r2v?=
 =?us-ascii?Q?c7be/fSn8lGXAJ6mtgHwHvBgP899s+WEbhQmVQ/Y+nfroYU7elWj4xVZlLJ1?=
 =?us-ascii?Q?RAlp8VITW5Ol+m8FTku6ZAtIMHvA/j6aPZl9QSEV3eOxVvqnjvjyrmBa9/4F?=
 =?us-ascii?Q?9BokaVAH3ND3rkTfK0MOGRSwYI9xrI9DB6hEiD+Ph3vYSxbRudr9Hb601D9T?=
 =?us-ascii?Q?RH69WfuzQpqqSu3Tbc8pPn5iwvjPc9dsiM56mn6LyVo0GqV1gj6kmK8w+huu?=
 =?us-ascii?Q?VdPUkm8P7lcs6ekyR+kExhG8gYulv0CGawxxzz6tpI5wC7zdPCPQ1iI++6w4?=
 =?us-ascii?Q?C3SXovbPl9AKdrvNDTBC27JBXqjr2CiB5LEtbLEM5XLNGQb9WxIZJyHJGuHM?=
 =?us-ascii?Q?GuI/DDr6PV3httkZBdd0FS2Xx09Z7zclHUHD5ac09mYe+nGIBUxTUm/n9vbM?=
 =?us-ascii?Q?LnMwzZZtPG8vp8oeMXNJclqfaBEFXPcsbPW901D/vxx3EhWm31irh0Oihkv8?=
 =?us-ascii?Q?9wmaygTbFvt+eNj15CRe8odBgjCl2VpJ62+fptAiyojrHE+P+/01efPauiuQ?=
 =?us-ascii?Q?NxQA5A2CZhMSp2hOmDx3EK+p2Xl3BeCISZ8zb/B8zwy/rI0yhshQq1OAEo+D?=
 =?us-ascii?Q?5VoK2d9e/8Xoldc1R9VrrMT7Njn3plaMnbOt2XG0zu/DiNu9asampr7dhldy?=
 =?us-ascii?Q?MFU38jmUnbSs2o/EIozex2xP/JstCblJ3bfvcUc6eec7w34M/5+GnA+WLKfs?=
 =?us-ascii?Q?R0OvKoSGBvXi8sYnPaFxm+HboNgAzwKy0LiVQddukHNpJvUOdw6u98EFLGto?=
 =?us-ascii?Q?39nEh0P585LBpVztNrtpJiihWEWf3VxzgFhlrouRRJwhd2qX4kgyfqCDQp1k?=
 =?us-ascii?Q?Ni/W8x67v/n55QltEoBL7ithi1R7yeQ2tBmnkZDpeI+jE6ufzbH3UAARMi23?=
 =?us-ascii?Q?ij2RrJvqe0vaslz3ZyfFoov0pYBt8OBZSuRsAX8HmOtQ/veUbCAWPffXZpRc?=
 =?us-ascii?Q?rBx7FY0B73uD1BTBsBzenbpGlJg9htboUaOCibbZvBM36TP+/IW2+GAQxF8N?=
 =?us-ascii?Q?bdNcwOgDMoXBG1hx8XLZQT1L0jx85oIqaoE5oBT5097kSFvQH43AySUGE/bo?=
 =?us-ascii?Q?dHKTXg7I7TSWPzdPsGtY18LEGo0Fr6PbKzyIjeSmP7ZepfokR0EC7D0C3lzL?=
 =?us-ascii?Q?gvm/0O00PkzHw/xuMk2C3HhaGiR2sX8qO9cKdK2F94XjmFgv/dH0Ca0HsgU4?=
 =?us-ascii?Q?GelG2DcwMKnfKdAkg0spUnY644rRpSY4AmwvNdY9IdYmt7CU9qfGZydpK6NL?=
 =?us-ascii?Q?G1GT78N01Yj1CoIw2lzmAbMRzTbDr6EPY0tzJok8dN1t8fAXHH2URuvZJGIs?=
 =?us-ascii?Q?N0c2ZuyZ2nkYGQsyhL/JYLPWcTIC1PmWOuY3YW7g6ZkoOephUXibAFV1Lsk9?=
 =?us-ascii?Q?3PXJYvQ3IlfrocF/ug63vIsh3epnb/oz9Xeh8naVBtjBtG/pnALfO/p6Xesu?=
 =?us-ascii?Q?JUbKJXXDD6EF2hNMnTgHaqpSsIVEzHtdMF/UosWG7XUP+hbWlmbsCDz+/n5A?=
 =?us-ascii?Q?4Xqmqp1baT88tG0vx54e+phRnz47JAAnR2dKK36r?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2d56c1-e5b2-4da1-28cf-08dc534df08a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:49:00.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7w2inb/BBwOsuNgCWvjYjdUWsLU3sjky53PCNa9r+0Pgxngf73SubsQtkDYYjvhu9S/cdDBpz+uWDsqh1u9kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3109

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
Fixes: 2fbbd712baf1 ("net: mana: Enable RX path to handle various MTU sizes")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>

---
V2: updated the "Fixes" tag. The code change remains the same.

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


