Return-Path: <linux-hyperv+bounces-1922-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7AA89AB50
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E82FB21D58
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A153381B0;
	Sat,  6 Apr 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fxS6G0qu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2019.outbound.protection.outlook.com [40.92.75.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3BB20313;
	Sat,  6 Apr 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413444; cv=fail; b=n4RKNZHCV8LaNVptZJ0tJ+XUt9YKsSWxJ6+KpBnAtjl4iufVx0CrKgmiv5mO6+F3djCtwNX8XqBHaToskCfzcVh0F0K88OUQ3NkhS6uBWhHPc30OuFfL3JM9sF+gqJxSnCQvwLmTx9l3FVJtVTPBTJBfBDcRrEjn/UhGdIFxxso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413444; c=relaxed/simple;
	bh=8+krBbLFj0a9KMu1NVr7xAyCxwjsguyRmPlBgMP2Ols=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ivs6b+F2sHAQxOMJk9U/lF9Nm+M3YHqotEA/ElquYiMMH9ZqqQo/I/If5f7Gz+0OgoS1oXES6+Rm6xdUon3NqrYGnHmo1ac2ycHIZUie0EF3dtEd9woNfBakMf6GbjcCDe/WkI8EuJSzZjHJth1Salo6xlhmxSAw/s9hciOQzaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fxS6G0qu; arc=fail smtp.client-ip=40.92.75.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsU6oaA1aH7tiiNEaP6PN8+R7V4ZBA+DjnxQQkFlPiqqXwkixqBOTgMRSoCV8W6sqxpVrOUbKOT3b8N/SeP/LvOTJk0+QysSPbovTxKX1b2DYU3GKdijfiBYA86I76vEPhguFaQS7Byq1j2pUYP/DUbQ1s6QgU75tdKnYTiDF+WvklSejYCNgGYv6rwi9Tyx2HFplK8bAfeoYFUFIx9XpaPItuFhm4vTskRSHltJJWMd3XzfcWLqTBKw0h49AFeI05IH0L+8HJTqGdYhA7vOfYcbIpAgNxgFYiXgje1sp8dDUdKYAREeZBUMWQBBuacky6awl2PH9NvDUacBoZS2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDfBJDDHGhws9RvASCHeLW947uhPvaYZPSg9kp3IHIE=;
 b=Tq4rncYDr8px/5JqZe26qSH4oU/WpOhuSk/g24gcefqWPeGnTo1TT7SgkAx81Ph45D1t+1qA0z4ffmeW7BtXGZ4ayavSOIWjkumImegTkFaPY9wGTMQVKSCgiraTTDQ/U/v1GlcZAmLbhL/pmitvr5fc5YqKB7mtVjVASfJ3+xzu60rb9SUg+u6IQedJ4nVuR4gnmZdLPVX7b2lamQLWKaSd0WSgnM1VKmJlOEHmE2oJ/LPenm8uEFE+9YPtgSycB0IerWjn5rOSffUjBW2h6VezJe1Lnm28LorxI/LSU6bDr77yPaxO4XztrsR4Dyv1S0gnSD0gQouTcuTAXOapNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDfBJDDHGhws9RvASCHeLW947uhPvaYZPSg9kp3IHIE=;
 b=fxS6G0quvhsH+fRGJF19DhOHfXpRUgcBGw2RkUUbQ3YR1FncPAn9vzm/N/SBC25io9/9/Bf3mICysi5ecenUsiPN6vvRE7raiHFz22PIz62i2lK2Zx3wvThVQH4H2Jw+pyUKD3EoM3PF2q5xvzZ8u8zlzL1uxgQJFLvYPvjnawDDEWYFcnlRbZrbg6eBdlef24194tYF2UwiBL8VKxZUJdR9uqPe/e43+cQpW9u2Fyh+KzHmL4CQnAI4bTjvoRFUC1XueF/f8OzxhIN4JrhoC0W89zbVG3VgRrfgBZ7IXuwfv/FrJT3vSoKOBoZtTMaR6IAsmBY9WsBKoCn1EGa9qA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS8PR02MB6967.eurprd02.prod.outlook.com (2603:10a6:20b:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 14:23:58 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.049; Sat, 6 Apr 2024
 14:23:57 +0000
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
Subject: [PATCH v3 0/3] RDMA/mana_ib: Add flex array to struct mana_cfg_rx_steer_req_v2
Date: Sat,  6 Apr 2024 16:23:34 +0200
Message-ID:
 <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [K7DW6bStmsUjCdMj41mLOHOK5maQoDjt]
X-ClientProxiedBy: MA4P292CA0010.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::13) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240406142337.16241-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS8PR02MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: a57313b9-651b-42e7-2775-08dc56453095
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ut24Vp4o5AQM6Th+tP0RVh2XbmGVC9hqgHIXOxmrGVcbopHo0STJhJbo6zo2A9kpmm+wEdhO3c8v3FV9/Y/T69ezQzmosxGtYY/ueRZzuyjuUhO21a6qzFuc0rMDUSD2iBKbZC3rWjxUqkpOBM1dCjCz2z1JjxytJZoZ8hoPSOoiGwrdzicJuhjJoyaCS/dvxfnWCdnaxtM0AeQLod0959t33f2ikz0vzFNj9X1PGNqXKRRPZzVbj5G7DUblq7GR5P0HHtiqR5eSnwqdU46lhPzXLcdhQW0sxZhMWHeLlgOQvB2kBzkxIEYERE7SPX3Btq7iP4Uu2HtIk2ltJ9HnO7p/Xyww4OF6JNnE5wxtKBEGHhejgc0Yyxz5M/TzCq2lXtRa60FrnNItjrNWCu/i5Qv0YD2qVU3WVZ7uvzEzP2cvEdl04xeMuta7Gbedl9R5swaAYTEe2NHm8qkmba5IdIDGKsAwNw8sJabdAklPYAX1jnOGsyaFXuoTrReY0/LHMpOSzuYSTUPKXKCWqkwNRvzopSu0+AB17SOY6dVOFqVDMLla0EFnfxqxL1m3UqiCX9QeZXzUgmIaGU849aEj/MA3t0046gC5MSpf4jncgrUwXuTg+hKbaa1fATLr7BSgXAl+K4x2WH87LJTxmGMprC0RzvUSFHoRW8Ow5osxVVVuOZ5ghJvbEh2pYqFo2Q0IWt3SkFawoZcwA+7E1PZc7Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4XFanc7FK1DSvOBD/bTTBZixWGmrdtxywfz8eMZvGXDZqt/k7qSLICoUXDU?=
 =?us-ascii?Q?7aLGGIjLDfGAUn4jfVbBx1tSE+U/P6pz6mRZFnu0QeW0dLHXwjeuwM+kBpX8?=
 =?us-ascii?Q?SC+WIbYApCpgzCuJBUyQkmiaDU25Z7qcwurgmp1cKgQ3adtMe4LqaMeXqztH?=
 =?us-ascii?Q?pV3ktqBjq92ghhn5iR3i+lrpdDUf0ss3r5sQHbF1IOHWgDFIQxtch8qKVA3A?=
 =?us-ascii?Q?1mFXMEcZu9kayUcl95ZEnsxkeH0Y2sgykuWXiTik90VApWcPwfMI08y1EVUU?=
 =?us-ascii?Q?qJkNneeE5NOYvw/u2eTJhieCafV3nKZgsp2psT2bwJDCjwGlE6CIu9vFTV9T?=
 =?us-ascii?Q?0u4dH9dvw8es+jZEfz6/8eDVCm5cPwOp5NbVHMpL9CyYa4elIYomHiyyTn2f?=
 =?us-ascii?Q?D6P89IJwIiysEETRaI2KypJCZ0w/2gTybQ0Q/ozwfzUcKXVlY3V1QaXUiLlR?=
 =?us-ascii?Q?OUk9QBxC49oTV4ulU0JMQxZck9Ii+8dExsn1kKM899fAMiPOlB9QIwBlHOks?=
 =?us-ascii?Q?PkwwIlgE9Nbb3tUO0J4y3zjPpUDqo2KAPVGU3bQNGdilWBVyKequoTrpBCx4?=
 =?us-ascii?Q?bfzTPI4+0ne7spfV8ZlIdIrh+32U/soA0nDbbOAPU9e3FVa7gD4dXtoz39ox?=
 =?us-ascii?Q?xBw4xWPa5sJVHneew9gi7rheERKKUx6KcamXIMoJpNW+chfoY2IuprU0pjRN?=
 =?us-ascii?Q?OQOZ3514tePmiryJISOkeyJAkcV2kGjMF0wFlW2tFNotdK608LUTWg1iWBcH?=
 =?us-ascii?Q?F2jAvhlcuArUT/4dMo781soOB0pgZi37N7TZctbnjClZu82xGeYYD6Qk1rkK?=
 =?us-ascii?Q?LlzTHpQNBqy4dyJQpd7bJLYln4+xxC5XlfgsK0U/XsnOiZA8Tqdg/G2hr269?=
 =?us-ascii?Q?z1y+sWgXxpDyuPf4BMS5OYYPaxfTRMKSNcvt46USx2PTV8N2y6HHigjqxe5s?=
 =?us-ascii?Q?7Yhw0CkzCbGWtgUNMXn2RAEw6WHiiVyEqz6jXEHHKCUA/8TubDjsQUBXubcE?=
 =?us-ascii?Q?fo61OgOBab84Kvu/FatqypN+H7SL3nMcqmhb/zO3eds+ED52rvwov0dT0fwp?=
 =?us-ascii?Q?GkZEbWtKUqYxCLZUw2ELes2k4UWvI4qPdxGuX4vAKc0NwUHfeeWdc4hOZdS/?=
 =?us-ascii?Q?LSXfWtCsD86wEo50YPB/uXBh7ZUonmzm0obJyWQOQ0fz2IwPgqXvjYzO9b9d?=
 =?us-ascii?Q?oNeDqJT1hMBfdeCStzZ3Rx4XdYXM1AbEzupChxRESoVqo1V4W8uI/L7X4nwL?=
 =?us-ascii?Q?++BIv9JWXE9UadALUXpF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57313b9-651b-42e7-2775-08dc56453095
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 14:23:57.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6967

The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
trailing elements. Specifically, it uses a "mana_handle_t" array. So,
use the preferred way in the kernel declaring a flexible array [1].

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions).

Also, avoid the open-coded arithmetic in the memory allocator functions
[2] using the "struct_size" macro.

Moreover, use the "offsetof" helper to get the indirect table offset
instead of the "sizeof" operator and avoid the open-coded arithmetic in
pointers using the new flex member. This new structure member also allow
us to remove the "req_indir_tab" variable since it is no longer needed.

Now, it is also possible to use the "flex_array_size" helper to compute
the size of these trailing elements in the "memcpy" function.

Specifically, the first commit adds the flex member and the patches 2 and
3 refactor the consumers of the "struct mana_cfg_rx_steer_req_v2".

This code was detected with the help of Coccinelle, and audited and
modified manually. The Coccinelle script used to detect this code pattern
is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1) + sizeof(t2) * i1;
...
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v3:
- Split the changes in various commits to simplify the acceptance process
  (Leon Romanovsky).

Changes in v2:
- Remove the "req_indir_tab" variable (Gustavo A. R. Silva).
- Update the commit message.
- Add the "__counted_by" attribute.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com/
v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB723729C5A63F24C312FC9CD18B3F2@AS8PR02MB7237.eurprd02.prod.outlook.com/
---
Erick Archer (3):
  net: mana: Add flex array to struct mana_cfg_rx_steer_req_v2
  RDMA/mana_ib: Prefer struct_size over open coded arithmetic
  net: mana: Avoid open coded arithmetic

 drivers/infiniband/hw/mana/qp.c               | 12 +++++-------
 drivers/net/ethernet/microsoft/mana/mana_en.c | 14 ++++++--------
 include/net/mana/mana.h                       |  1 +
 3 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.25.1


