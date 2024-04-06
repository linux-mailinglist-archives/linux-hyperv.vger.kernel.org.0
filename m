Return-Path: <linux-hyperv+bounces-1924-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1589ABB8
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 17:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72190B21485
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD943A1D7;
	Sat,  6 Apr 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ttGGsH4q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2028.outbound.protection.outlook.com [40.92.74.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7E33080;
	Sat,  6 Apr 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712418259; cv=fail; b=kObzVkVcKP5tsrxFFjY0vbhNXHMH5S5lKw2HZEnzatfDhS7UjLdRoE2mIxhHlBLKiC1OK6VVdsLA6+LOFfigvX9dbTB9q1SvPcCbr7IUYnJ6p+LmeFYd1fbF+nL4AbsGk09fIRwZUmu9g3RjQA2BcsclCR738YD9DKZ9Lqfeh5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712418259; c=relaxed/simple;
	bh=muAATVnktKmhuQXw0M3TndzIes0X+Ysq/z8ox9UmZAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o2A0qGs57oQhAarMy9OC/VWH88zUvaxG9F0L8KmdDvOAWMwNgdKax193Y3ed+Ec/vKcnx8WIxMUXCY4feZk4pceAwg7JTjD2uQzVDdE30Ao+kqUJNYsGbkoQcrxo3xmGo18GiE4p8+4pBH40ymPEONa6ZJ/+bqoJV9OYNn4nOAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ttGGsH4q; arc=fail smtp.client-ip=40.92.74.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhxvRcvm5cQfeRt6nCakd/xn4c1dbbuzC/tmml59UmnmeIUG3lTmSoRCKgt2q/vKdKEFa+dCoKWEoe8mFIZDAOvJtXWQ5z140YhfKabhgADfwgUUxfKXD/k6I/AsY5D3w396E2mvzMnqNfaJrwrm4l2SI94dhAEC5iymrutTG9KRF1vWp8oik3YJgXdc2NLv9rI1AUlYxNTrfF3NNn4tGokdvPPLrzeILVzrv0airXqpQAUnovUNG6hnns9zRM8bKgtSUP15LvbcHD/c0GmxGcFr8ENbZ2MMKZefyI1LnBzb6nUX+C/toH5EKyRF1kJw0VX4joaqSKg3Mwk4OGeEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOzBCswJvl8184g//x7v9ru060DdT9pSGglnMTKJ1Kc=;
 b=ly7lluf/WNo5/tw9q0naet88N0MG3V88k7ehD2A+G+PG2m6FwkhUFHbztpMaoJHtHc+hB9zWZJeQVn4MVrtUHT0byzga1syoruC401n1oXctWdPwzTZGaaWgn6antxs474jk4n1gQ5phVKyKsrpU+3nsogQEoFutQlt2n68mY+G27v61nve7lto3DogYaqE2Key8PPfxfhqkqb57Ny9122yP/uwZPvtdzNQNUOivnkkS/OcnViGjHokZJKzTDCM8tMRRY8FFjQUVtbXdmAiMnAso0C/o2W4e4Wxn1VMpdag1orCXObPNKa9FOi7evGRFQ9dgQSvqkRsVBAp2GHDiqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOzBCswJvl8184g//x7v9ru060DdT9pSGglnMTKJ1Kc=;
 b=ttGGsH4qUa3E3a4qV52cUAM9l2Ae2OYVLzwW7/vyN01dwpZxrVeMGoRJXTjTo3/n+CFyFsUo7JI+s6H4XvPKR2AG7lxMesNM5HsUPn3jp/sGuld6ICXmj7Bb4qn2XZ8bpM0UoO7Xyxw+KyAOR5VJ5u8XKe8jqSDJTVKuD3N4kUoprVCiOq378Z2cGzArrigM92SMZsFeXcM5JDJCE8KcVzvmYwfpqgAnCVJlPr6l8S4Za60WUCIyqG/6uZjr1CacOL/2s1CNq27lkqr921sjjn0SYCKx6SYyGRY0PeAiagQFvsBhe4QTgt1DGogiztqoE6p8nESfu6s0kqUZW4HKSg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB9PR02MB9777.eurprd02.prod.outlook.com (2603:10a6:10:459::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 15:44:15 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.049; Sat, 6 Apr 2024
 15:44:14 +0000
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
Subject: [PATCH v3 2/3] RDMA/mana_ib: Prefer struct_size over open coded arithmetic
Date: Sat,  6 Apr 2024 16:23:36 +0200
Message-ID:
 <AS8PR02MB72375EB06EE1A84A67BE722E8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240406142337.16241-1-erick.archer@outlook.com>
References: <20240406142337.16241-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zNZV2QuriLTH4cBB6X+2iUPSwKagj/JV]
X-ClientProxiedBy: MA2P292CA0029.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::19)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240406142337.16241-3-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB9PR02MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de0c22b-33d4-40e4-d44a-08dc5650692c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cl9NkR8WkPL4ovw/RK971JOxEbBLk8MHksjo/92/k0mOgYfgKMqFiQhtsx6pxB7y+lsRoQRr5eJ8+2fE3qhQknx6mFLhx23ypF1ziwcdbS1RpRTY4sUnaR4ImzENUhm3U069CRUNgeBhFGCXpfze8LFvCx/yglMwDXlOYV3SJpPXifVZf3UA/NGueXcOkGPnvs4CPc+/7xMQCzzIgUiPcoDafhMFddd48Ed690VSVsaSq4zi3Ga+tffiwGehKmYsxMC/erO7UZsMYuHSQqYxOBCX3fahopvl26yDeZAR98R6f2AH0duSDByjjkhG4Irdx0k0gMsKGahDXFc4ss7bOTxm7qK59Vfa8SMIlRCzVZZPDVlqNcZMqLk4kV2VJ9Essikr8cQApM9t1SFuiTRWIfWsvQpMDe/pjqRSz+T/k6RwEzccGKobLX4EZgNGomaYcZV/AioIKuwBEgJpEkKrhDgG6RhCeoX/FfrAuHgT3mF/x68unfaE+YdSM/5HkCKzJkwW2zdTnKg/SDPgUrcO+Onl0aqE5CEuFwopjZm6wVAVPZlrAKR05bYjEeKZFvO1JrWBH8h1o6gFLxUTleRDf5zdbl1WvzEm4yR9DFVeqwCtDrOWmIIOvlt3x/dPGv3rysxzIx5p+Kev/cGfh8b3j92hbb/zl8l+VmysTvHRslCujRiSHhNvUnHC8hNnJwGEiF7SDvY6MZKX11JqLU1rgA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDlZ1JdTtLDvIhV5+zdSPMwZYrb+YhK5k1VhabhzCt+KbNkx+AN/c50xP65I?=
 =?us-ascii?Q?1ISRX7inrQT79J/j58wyEIO5Qy/Y7t0bqZPUs4wTalczkQ4N6KUMHYe4D5+i?=
 =?us-ascii?Q?ilOoMR5mTw/38w2IcGNwv4rM2WNJREGdYluqNHV6ODM5BtzoKGL0nUIGR8oF?=
 =?us-ascii?Q?NyoLeZ8U7HGUGoKV5St479LCxQhEQtI3zu74KfVDLs765YoGIjxZcsCIJPEU?=
 =?us-ascii?Q?jXCMwzgM/hXYPcLXKXSMyr7SyzfUdfRNw8u/TaXARxzYGxvOzTeuW9V18clz?=
 =?us-ascii?Q?vvjTOAiMjUlJBnCcKqv7hnyNU6ODhCfZ6U0HYPRx6D0B4XuhtqRBSo+FX3K3?=
 =?us-ascii?Q?mQWqvKB/Gh941zRqJIOI+OW/XjgNqG7sUHyPtmwKRx526iiTDU95ge5RoK5v?=
 =?us-ascii?Q?S+KatNDGwHmKXpbvBlEBS4UOzu3f2/pu0jwPbw8FDYAxZvmjEWvilWEQSxiR?=
 =?us-ascii?Q?nTGf2S+RL6ZQMtFxmeVwk8XuB7A+IvmbbSTsXH5Y5bHNPW5ANVwIM5YYNPRn?=
 =?us-ascii?Q?9CN+aKzkYBE9mYqmNKOvPpQzKaMRyEC0zUpJOfaq5poz0AfJe3xKU6zbVp+/?=
 =?us-ascii?Q?WC2BOU8IGUQvFyzNMHNhfBbTNdRq4XmaHFTewhCnDM1yLrL3m+Q7mSGaUMsz?=
 =?us-ascii?Q?ajR7DEWvsDW8J86XU2aX4i7wyqweNGa6oyLd/kbOKyE42kOaiIOQZ4JdIpyB?=
 =?us-ascii?Q?EL3uF4R4KHU7AEfUWcSi8BamkqzYl4IClcku9RGKcTo+YRDF6aCIIhGeMthk?=
 =?us-ascii?Q?7FWsLlaB5KUKdPL902+HEBK35OdR8Gveh2NSZOZqs/5OlPu7ew3xiUDxyb6b?=
 =?us-ascii?Q?CM5lStvewG6/9a2IqSIUdGxnh7MFaHBIiBBAUp1DwNHTbWic3as1zphp2Wxp?=
 =?us-ascii?Q?FcKBc3l2g3tnqUPuUf2y04fPb9+sGg/SKSXmKB9+UgTxihDh8sYj1tliPu3k?=
 =?us-ascii?Q?kwAelQsbWdifleaFCvrjZZluxSUCsHNkFTnBjLc+t7AyPCxsiXe5Ax5tHTsv?=
 =?us-ascii?Q?tQ1sCWZHZyHo6YoW6EagI26KbjMJWh3rbB2CVOcJLhAuaGm2nRfDA1I97whR?=
 =?us-ascii?Q?K+9IL0NCSOI6wVKBfIMj2OM/aKjm1dIwzLNYuWf6ppvIZXrg7lhlBeEU/jN1?=
 =?us-ascii?Q?rIoHIzclmvqJbpTg8gPTWRuwHSPv6xnQRp+kL6fucqDesGwI34zKOV9wWeZa?=
 =?us-ascii?Q?DzBpnxVgrhhRPjUFZ/l5c24D2AxqJb9vj2k0JcybYYyJjTAWwl6ENu0YOEF5?=
 =?us-ascii?Q?m/v6+f9F2WK5OaLSiBiD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de0c22b-33d4-40e4-d44a-08dc5650692c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 15:44:14.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9777

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "req" variable is a pointer to "struct mana_cfg_rx_steer_req_v2"
and this structure ends in a flexible array:

struct mana_cfg_rx_steer_req_v2 {
	[...]
        mana_handle_t indir_tab[] __counted_by(num_indir_entries);
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + size * count" in
the kzalloc() function.

Moreover, use the "offsetof" helper to get the indirect table offset
instead of the "sizeof" operator and avoid the open-coded arithmetic in
pointers using the new flex member. This new structure member also allow
us to remove the "req_indir_tab" variable since it is no longer needed.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/infiniband/hw/mana/qp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ef0a6dc664d0..4cd8f8afe80d 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -15,15 +15,13 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 	struct mana_port_context *mpc = netdev_priv(ndev);
 	struct mana_cfg_rx_steer_req_v2 *req;
 	struct mana_cfg_rx_steer_resp resp = {};
-	mana_handle_t *req_indir_tab;
 	struct gdma_context *gc;
 	u32 req_buf_size;
 	int i, err;
 
 	gc = mdev_to_gc(dev);
 
-	req_buf_size =
-		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
+	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_SIZE);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
@@ -44,20 +42,20 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 		req->rss_enable = true;
 
 	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
-	req->indir_tab_offset = sizeof(*req);
+	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
+					 indir_tab);
 	req->update_indir_tab = true;
 	req->cqe_coalescing_enable = 1;
 
-	req_indir_tab = (mana_handle_t *)(req + 1);
 	/* The ind table passed to the hardware must have
 	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
 	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
 	 */
 	ibdev_dbg(&dev->ib_dev, "ind table size %u\n", 1 << log_ind_tbl_size);
 	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
-		req_indir_tab[i] = ind_table[i % (1 << log_ind_tbl_size)];
+		req->indir_tab[i] = ind_table[i % (1 << log_ind_tbl_size)];
 		ibdev_dbg(&dev->ib_dev, "index %u handle 0x%llx\n", i,
-			  req_indir_tab[i]);
+			  req->indir_tab[i]);
 	}
 
 	req->update_hashkey = true;
-- 
2.25.1


