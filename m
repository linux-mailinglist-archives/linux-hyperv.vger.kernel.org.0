Return-Path: <linux-hyperv+bounces-1925-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A289AC03
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7641C20C2B
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Apr 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3B3CF73;
	Sat,  6 Apr 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MsGYFUNX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2015.outbound.protection.outlook.com [40.92.90.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA153C087;
	Sat,  6 Apr 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712420668; cv=fail; b=TFia7+9dvLY/yDa2TRH53b8Lc6InsecpafUMVkRzcMuU5D++FI9NeFVv6CTWQrOJ6UZHBhPaqwkoAZ6BTTCFaFU1Vx7k/zmWOeaTI7YCIXnJDVkWbzG4VugLw3Q1TQpw3DWsdx7FH6ivzfjbQg/R7FKBF+a1mJw4+uLC0XjUYa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712420668; c=relaxed/simple;
	bh=em0KuTuS5v17wCYbmf3zMkFaHtwR1H6btaoNK7MFnqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7jjqAf7sNuUx4n2YstigdiNAHTq4IFHZlSgtP0/sykhaHAT0D/tBsXp0DAK+ZcxT5G3wBR5OJEP3yfX5rqXF4I32S16sLPQtONpJOsRBMCriPwQhoxCO7IgYhtSid3IoovD5pErG4ifZDtpzUXQDwpoR83VFycRz+NjBGF1Gf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MsGYFUNX; arc=fail smtp.client-ip=40.92.90.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOAuPUI3GCFvdWS02y8lYX+Btl759fFtLz9XBkXpU6nc1U7x4A2adtJgW2HMOj6BmYHdZ/zzmjtEl/FaMwMYCSA7QNkx4qQYQpBO31bgo/zlpMBn4Iqb1oJxseHBIqioaHkBG4axX1fjF6cbpxlStIy7v6jKr/Qd4JDXA8pE+nV3ArBUVj8M97JU4ZOti2jnnCY/jLsDxBykGE54zkAZcVOVi6M8MvDl5QmDyIsN1MsORsUKgeMmSDB3VZmHi/F9mPPHW39Q/RSpn5Xl6/1G3R5Mo6p79EWsM+gASwIave6BCJ3BmXhawWTeTzHqRN9xyHciWGcEhS1kRtNB/DfPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78EOzeiJpMwIvqdyeb+jNXi711WZpDuzvqqWUG13Uhw=;
 b=YlR+qatxpUXpOsmAAdM8iRuaVnp1mFJ1HjV5gfLL3gzsScaI0zkykG4bEDieel81IvxdTNUkid3KcrCfPaxi+HU1eultff35hBflNmgsMg4tHE94zhKoW/rePopxiazz4XCeCoHM9t91UArZ/1pj46LzPfyu45DMgtKhj3/RSuAb05GGS1l9BvOX6si3n1NbQEhztyQ6h7weXuoofzzl5gx74WdYCxnpoX4SXxPBzNCWmsmmZ9CbaL91YK+k+QarikG4TjYfr9I929p5gjaD5biAduQesJeaLBNkTDBRyU5JnE4IUvAzZVbVyRODHVUS9QRRzFv/40ySnZ+knlpGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78EOzeiJpMwIvqdyeb+jNXi711WZpDuzvqqWUG13Uhw=;
 b=MsGYFUNX9o4ieQ4Qn3OmFt9qnPNd4LxXPzY3+VmYbMiZnQvSGOZu2rQ+Us8GvaETy+RsZ54Do9ZLf6hhfJWwp/uGUArQxv3qG80QLVY4DD0xtV+myToh+uX6aaJxqc243qe44qXb5d7MXTFthsf49k22qOgez7XbU3nZPkIgN5R56E0WnH5LuvG3nCJ2v4e2JwoxvEsoY/1sRcrzWEyLNrxSGb2sshSKEEb/2HdzDdScDxQ6INBs+OoKMSKjdRf2iizhoaHD6hX93eq578gvz/gr5xyGxpObD2t82yaWLBmQ7KghN/WZ+Xbmq3JQp7gLHxx7uI/q1eQbdXR/kFE1Qg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DU0PR02MB9121.eurprd02.prod.outlook.com (2603:10a6:10:464::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 16:24:22 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.049; Sat, 6 Apr 2024
 16:24:22 +0000
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
Subject: [PATCH v3 3/3] net: mana: Avoid open coded arithmetic
Date: Sat,  6 Apr 2024 16:23:37 +0200
Message-ID:
 <AS8PR02MB7237A21355C86EC0DCC0D83B8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240406142337.16241-1-erick.archer@outlook.com>
References: <20240406142337.16241-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IjmoCuAyloIqhvoUYW9pNGyBpZ9aP3ZY]
X-ClientProxiedBy: MA4P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240406142337.16241-4-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DU0PR02MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: a83463e9-01d5-437c-88e7-08dc5656044e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fmAByG4ma+dK8Rj55/hFD4vso/r9uC/2Bz1PS6+SQo77Bb0CnEgVXzR12W+2H2TMK6OvXWfMjf8t9RP0fuPXr8YDA1zzxjiP63yQ18gfRkf7GCSjyBoSUu4z8mCD6JxYudlL0ORmsJ8a27z3bsJxm1LPYfzv3Fhxgz1j1nY1tgQo7GdfDeksB0X4GeoJd+gNV/TU4XRZAZZNdq3BAMNhI+oHfMSu1Vdoywq8DFzkWBNbgN4q0Q1LmKYGbG5JzKaZFOJVi+SyuUhIQ0voWFjSEcFwwbN5hVuLOQT0n00JUXRRw0Gp8SEUNCARAR409DkPcbvUhCRG67gjIB6uAZ7szhafmpLlkvQDawZNzEc4wD6PpxEpziZeOcD2AvOARbOvbcOCsHQHmXCmrbYutYgGtHjqWSuDMrF8Qch5QuQOT6UWWakLqPjUgH71EwSOGVuxN64A+/KnpioHpM2gg++wkgcN/1Um4Vv4gCvYVZpY6CPcqSj639AJYeRHY2iNgee6Rj3gCtVL0rc9htXDFjbnrD6OciIOGhGI/ko1b8Z5L/CxCzUUHn7A3TT2y+tFDaySazPpETdf5oP8n22cskEp0pzCnQiSYOsKTlxWfYZuKY34Hgh9A66oNR2hLGsUTrW2bITX4Yx0WD0m1+Y5Df/8ww77xbbNtWIyuuE4CDXXVsXqMNy27lKGEv5CFjFyoz4XFhP90EtXMmsdOsUaMaPG1w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+NWygIoX/E7zdR3o15zzkhmyeh9NM3/hLj/sqpX5ZrTznHVy7G0Dd3qWURk?=
 =?us-ascii?Q?Fjrw03gGJ/vUqrk93iB8X1M9OjZd+YZ3FzbEAsN/yNS5HgsJvUkniC+6FUIq?=
 =?us-ascii?Q?VH4e6IYNJMLBWNuvIjkLYB3xRXb9QXIKCN+2rznnE5XiGFSwmnWzDp/ci+PJ?=
 =?us-ascii?Q?YdN4Wu2vDO7tcPGX/1GTkQAQcp03vLEO8jAMF+vOZnFrMR0irMGGfq18+4UI?=
 =?us-ascii?Q?aWYhrCNPqdhddaV9i1pzhkxU3WEyRqxjH4SDIi3YAJ8OQMsfWBfRGFbR/AdB?=
 =?us-ascii?Q?cPx5YsBpSaztOXBGP0JYfsK8oSjcfQsv9ebqpx41l8aI/XV85s/fesTVhoHx?=
 =?us-ascii?Q?i+LQ77LJ0fEMmkumWdWILeQ2i5KztcZENcTvL0zIjN1ICbFA3HdVZu8Hmlf9?=
 =?us-ascii?Q?Sd5x2TzBFMLwiHWd5H04exp383hrdWjc3UJkedDm94sR9CYGbaDqQ+cSSobJ?=
 =?us-ascii?Q?UVBB+Fz/GXSi6rq6+bpIJfJzrw0LwR0HClZlc5IDKWvmLOExfF9y4JKQu6sA?=
 =?us-ascii?Q?ex7QoVZUGekG4wBtyVTFx0PnT3/gAecEE7dY8620K6CABFM7h5AyLogYw/K1?=
 =?us-ascii?Q?g3S1ZgeuviP4Wg8LFAcAIWILZW/6i111xgtvqGXM4in4FoOG3nheijWC2unl?=
 =?us-ascii?Q?rWfJGXgajODKjR4lfzAk7Sdj2/RTNvq+cx9HBTe7jtMOM59N3oiWrgQYDD/D?=
 =?us-ascii?Q?DxPbWkLsmS1ePvbjpEWY0BgbwsdEhDjVmoi4V+cdB7cSDHye+kD6uUl4U47p?=
 =?us-ascii?Q?5Pgc/ivUWRkaeunOCD6L9Qh/ulScSza5LorKy/Fk7ZQULG+LoTOnq5VLnO+V?=
 =?us-ascii?Q?CIZuNz0CkV+Aje//Z6/zu/+CgpXjIJQUxQV/ZPZMU30qf/3Trmlr36jnDV7V?=
 =?us-ascii?Q?9yU8Jtonv+69USUMU4+azbHKKb2Xvbjl4gaHLf80wwCjq9TJaXp0w3bvcMxs?=
 =?us-ascii?Q?YXcw83Z1frjZ+7CVV4xVMqDRdiO5u/h/s41jmILwhRouySm6qrZsJ3akfrSW?=
 =?us-ascii?Q?6hzs2t21fN04u1ZwTFnjs+lONtvLqEY1uj1WCyiVJr8eq+20UXfFIiopgkbY?=
 =?us-ascii?Q?qFv4L3QFfL7xtuBaKNSNS9PsrYR12hqrnMDr6tkv4Qy8Z+ucYM8OAqkFIFMI?=
 =?us-ascii?Q?PjfTm5iqkE1nLAWun9PBjwrA8ZA5WzCozx39uzDit2WWOb1Z/rzIxy9GZVEi?=
 =?us-ascii?Q?gJ8RvR6odiv8/uRyVyun0JY4UJBVyX3BIfFo6MsZGgLKiN3BzK5V9TfQ8exc?=
 =?us-ascii?Q?/9kawPV6I8vrX/j7Z4bA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83463e9-01d5-437c-88e7-08dc5656044e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 16:24:22.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9121

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

Now, it is also possible to use the "flex_array_size" helper to compute
the size of these trailing elements in the "memcpy" function.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d8af5e7e15b4..f2fae659bf3b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1058,11 +1058,10 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	struct mana_cfg_rx_steer_req_v2 *req;
 	struct mana_cfg_rx_steer_resp resp = {};
 	struct net_device *ndev = apc->ndev;
-	mana_handle_t *req_indir_tab;
 	u32 req_buf_size;
 	int err;
 
-	req_buf_size = sizeof(*req) + sizeof(mana_handle_t) * num_entries;
+	req_buf_size = struct_size(req, indir_tab, num_entries);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
@@ -1074,7 +1073,8 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 
 	req->vport = apc->port_handle;
 	req->num_indir_entries = num_entries;
-	req->indir_tab_offset = sizeof(*req);
+	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
+					 indir_tab);
 	req->rx_enable = rx;
 	req->rss_enable = apc->rss_state;
 	req->update_default_rxobj = update_default_rxobj;
@@ -1086,11 +1086,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	if (update_key)
 		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
 
-	if (update_tab) {
-		req_indir_tab = (mana_handle_t *)(req + 1);
-		memcpy(req_indir_tab, apc->rxobj_table,
-		       req->num_indir_entries * sizeof(mana_handle_t));
-	}
+	if (update_tab)
+		memcpy(req->indir_tab, apc->rxobj_table,
+		       flex_array_size(req, indir_tab, req->num_indir_entries));
 
 	err = mana_send_request(apc->ac, req, req_buf_size, &resp,
 				sizeof(resp));
-- 
2.25.1


