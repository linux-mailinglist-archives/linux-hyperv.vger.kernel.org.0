Return-Path: <linux-hyperv+bounces-1923-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635B889AB81
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 17:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C212821AF
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79BD38DCD;
	Sat,  6 Apr 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E2K1vBBB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2036.outbound.protection.outlook.com [40.92.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B53A26E;
	Sat,  6 Apr 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712415852; cv=fail; b=MsWZzGa+733lplkntNpEregfKXlxhim4s29SmEAmmcz+Vt4WjHYjBzOBlhJ6O4pMD3ynuskMUmKr4eWbGfwTWU2oTwyY1b/8XRUUdFcxH8ByHClHqJR0P8+6VF+WpCLCoAMrIPeTqx+0hu5TRJmedhG6DH9zdr6W4pEGi3S5OoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712415852; c=relaxed/simple;
	bh=udZQWB1iHSON6Jy81Rcxx1SaFbiMLHb7BiHTM1xVLi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6OVISqp9NpTIEgP11ul7i4FAY//npie8EK/PZfwUGTccR8+m1tp16z91kvhagSYi3HkhAjXKB53rS1HLqZGkOKzUIe+n1vuGfofrmvizDZtP1ZrqQGrwOeBzs98CG4E/ExpQMfzrMJjayL55rvbHkzYYxEChPOR/B2LAM7dLJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E2K1vBBB; arc=fail smtp.client-ip=40.92.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHGH1Br6HzWSxEdHWI92YrBuQVyfY/Je698qMyH480P+O7i51z/tIWtJYGHtTQOzj9T6+iBVuZBSd+dQC0y2eGXNc0ceRARHU9V/aeHCFixkzTQ4Zl9LTKTn4VnK8joHZCY0lXgiBpNnFLYDZYbxy9ICC2Eu23+25jwZIDZTJw/JpSS88g4yw7v02BviUKFLfEonHJqJXUahYamznz5qlAo8/gDYQ/wxyQSQoqBxvYRU8WdJIIDEaGyCuDSkTb4dizrwVq7rUAVCQChws4gJszvlYW2+j9/OpTVPv/uDio3+AfftH9Ji00tfFAURb9L/yj8CSqO6ETuNxUyUXrIj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcUvGjwt8FmHE1+S5Uzrvv3iKz9VISom3sZL+jmw/TE=;
 b=X8J6md71OA8+7KJiocvEMszohe1C+NCOYxX9vsilNFvCNb52emXBinTwQucpVUrHwo8wDp+rZqEqhdvSBrOa7KeRfso24oxbZpO8vPZNWi7VoN6vMA97kcCgDP0O6B1u3nkCs+b2PNxbRw79BxEw/IxOo5QX4YCjupCc2LHF90kJOqg42yfxVfMbi3VqFXibwfbekUFl1OH6uwxotObxbgJJKFT+iOBvbbtR4vyDrVXRSppPmo9J038kUmvR2O7ctGiWuRf2ru5zS5JTK7jH1blc7uwYwns3bKEFbKGmwo9/OHxS0yPXCkNbSjkMU0fKLNb+pHM7IZdqfE/S5XM1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcUvGjwt8FmHE1+S5Uzrvv3iKz9VISom3sZL+jmw/TE=;
 b=E2K1vBBBPPVJluTL6dqq/enfmyjAvYUQ1Vz8X7fuCSioo65EJ1P0lIjb29JobjLUHw7gQKsXmfl/1Xbw6LBbroIp9fk1FxQbBFEAFr42UdG3AHMy/owEMExDttLBFRDz7Oj+3yg3sZyPANVNOt0BVgXixxDMBCufEH13yBZCzRGtA7SZrB5IgNpYDpYa582J+HBVdoYUMHSQXRnVNw2QKZoYiH+k/yyCX5/b59Cxa5YOF3jsR4dIZEIw/ZDkmwD5WPVJ2dd2Icvy7x9kZH3fqMW5iV0VAPUSjiRmcXz7Fp8MqBFvVRM4gse9HHpb10YlMwAAgDrlF26gjBQsxIJblQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM9PR02MB7266.eurprd02.prod.outlook.com (2603:10a6:20b:3e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 15:04:07 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.049; Sat, 6 Apr 2024
 15:04:07 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 1/3] net: mana: Add flex array to struct mana_cfg_rx_steer_req_v2
Date: Sat,  6 Apr 2024 16:23:35 +0200
Message-ID:
 <AS8PR02MB7237E2900247571C9CB84C678B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240406142337.16241-1-erick.archer@outlook.com>
References: <20240406142337.16241-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cTg0LrlH6ACousoX0jF5CgRxh1dEokR/]
X-ClientProxiedBy: MA3P292CA0012.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::16) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240406142337.16241-2-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM9PR02MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f12e0ca-08f7-4b5f-25c6-08dc564acd3e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/4aTcYp7k7nikUlGYBpBZx1qLMZpfQhqIRP1EC78ndgUZuRwUt4e4U5oMly93ETM2h7N+E+ae3tXEFt3qCsB/+ChSP9XfNGxjCah6/6W0q4lHL/J/9oyeK/xKwajwhaocqm3ApC+A8Dq9f9ZyE+1GPbGSKVKRWythvKO9lkjDq6wb7JMK4zmNo2H2vDFTOYiOKqXHw/ukbvAfqWhXxn3gsT7v23t4+s+5XXLWhHuroWW0M0P1REtVWyDjidIm+cl1wDFhuURMq3RJeO7KYE5sfbv4SLAkPblvWszNxRPlvWfMZGHNJI9fC2E/EObqytkUiNcEeHIa9PZOC38xhixnc7PVsx28PQyDthZwc5My0NZY0mnf/hBKdHlomKm9q30wfWqmf18MPlBKZJ81zsGT5YLjJGUx3ZKKCVBgE8Q/mp5XNdBvYk0xmSzQpYtRje43za0SOaRURtMjwYQM1Xw/E7Nn1whgOLEBm9KJoxNXAxKKfoaMKC3qgnyVpY5NKBxSmGQhgEpZrpbgydYJd5nOZ0iWVNUeI9+fIvhYQeS4u96cbvkb6sAXciKIa6DjWF6mr9/XPqr6S3Xc4wNFBfNz/UxgCBn6yG4bY9fsWvhYa9LmwQgYqNJYxAIzNWwqI4/i1Vfkb3Bsanhslxbk/t4/vElZigHyrn9BiyPb/pdSM2li4wmi5zFT4sal1wpHrW1mWggkk8VSmxnJ7+oqgqOA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQbppk0oKvl5s3FOyogTIEqoeBd9xKzBcUJbHDj4YHOehtSe8nhzb+joVGO1?=
 =?us-ascii?Q?a1Gg9eShJ8fXI4EedotXOUrR0VehyErhAVGrDSUv8ZGuWQsZgbgDqH7Yba/N?=
 =?us-ascii?Q?EPU5ntRBbzJEfmwVlPMLCpcjj4g8OJUK/XHvZjiqbTndYcQn92dnBDn0Ggbz?=
 =?us-ascii?Q?ItOxPVBntQQfhNMXTMnDVjPChw2rMlBIdzu2nlXzeNnZjm0QtaLC3Y+W9+OX?=
 =?us-ascii?Q?uyGO/4pmJSNgN3t86+wOF2j/kt32o4o52HpLj6urYXp7J/l+U0NvBjiR+Wj9?=
 =?us-ascii?Q?DR0PWM+yRE9y/1H+dPAUnAZKueDHg4Rnpp+6WJtPJ0LbsYo1EzoIzg0yButY?=
 =?us-ascii?Q?vbl41TKh4Zia1E6WvRCmKkMZqSLIRhQQUquUyR0vExF0MswZbEa7qe3d6RWy?=
 =?us-ascii?Q?0UPkHZwWQ0dfZeVd/Xy25oGy9KCQUkfbL3i3F/dPgZv4yxhYrviNT1dT8w8X?=
 =?us-ascii?Q?ZLMYX73y7lpUbma0UGgo0AzYNdc4mAnhPASzOHc9MJQ9aEEgD09smZ8tFhkG?=
 =?us-ascii?Q?K0M3pM9wElWEDCZIQXL03t/PktCGZDr7glaslvwo7PiIhGsW7fwSHzrS7fn/?=
 =?us-ascii?Q?aveszDxUi508zz9NpOhHqfmPjEc1Q/z9+yji9MQcUuuPT9sazshCiqQgK7c2?=
 =?us-ascii?Q?1KcWO8/0xsHJOvXHIVfCp+OjagDKPqk84K9VBatSUv2E7aCV2RCMGl7h1lIc?=
 =?us-ascii?Q?qacEpopoX0hhpSoSDGChVhlUaL2pxcbODJY1YkzAv9NxlqaBt3gk42/hP0Fo?=
 =?us-ascii?Q?ygAPiLNMIycEqy4Raj1G2n9k9JI+Zm7u59G0j74ExKWFpBo2+dWrqgaxfXRz?=
 =?us-ascii?Q?PE6TTAPTCv4BCTsh5VSxUCh04gT+c5GaXZxwBKGTwWuKenFJZC+9qJUlnMjo?=
 =?us-ascii?Q?4uCXvpuXSGtKjqxdM4UaOfvpwq8pgTcdk7splTudf4ya2JaBIoCfej/zghSp?=
 =?us-ascii?Q?KoTUsQAKHNpFlK+b3B1yRCeoDPYOkVK7bW1MGxcJrsz2XzwtZ1I5y4/2+V8J?=
 =?us-ascii?Q?buV6THSVCaB+63QJBGV0GzqI9yCw9BQAGicsWtUNK5tFCr2HoN/pIwJeCis3?=
 =?us-ascii?Q?rlCtSTgUdsnihCWvaip8NJzbL0lo8T9lOYdEEPRfNNGoLRqkT1LVdhb2gnFj?=
 =?us-ascii?Q?CFeMTVwsSLDeW8XVl1WO+6M73iUHQ/KwO8Ny5s062A9o2qfqHxrTRzMv7VZb?=
 =?us-ascii?Q?5YSAO7g3X50XhfqL2dogA7CgCVMHmjimgxLvtoJHlXknI3QAc8qc9RMh1Htd?=
 =?us-ascii?Q?W014SDWFocyBBJX3NIA+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f12e0ca-08f7-4b5f-25c6-08dc564acd3e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 15:04:06.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7266

The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
trailing elements. Specifically, it uses a "mana_handle_t" array. So,
use the preferred way in the kernel declaring a flexible array [1].

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions).

This is a previous step to refactor the two consumers of this structure.

 drivers/infiniband/hw/mana/qp.c
 drivers/net/ethernet/microsoft/mana/mana_en.c

The ultimate goal is to avoid the open-coded arithmetic in the memory
allocator functions [2] using the "struct_size" macro.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 include/net/mana/mana.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 4eeedf14711b..561f6719fb4e 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -670,6 +670,7 @@ struct mana_cfg_rx_steer_req_v2 {
 	u8 hashkey[MANA_HASH_KEY_SIZE];
 	u8 cqe_coalescing_enable;
 	u8 reserved2[7];
+	mana_handle_t indir_tab[] __counted_by(num_indir_entries);
 }; /* HW DATA */
 
 struct mana_cfg_rx_steer_resp {
-- 
2.25.1


