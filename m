Return-Path: <linux-hyperv+bounces-1886-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB889320B
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Mar 2024 17:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3078B2168D
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Mar 2024 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FAF1448ED;
	Sun, 31 Mar 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ieCGqDyH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2078.outbound.protection.outlook.com [40.92.75.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7B2628C;
	Sun, 31 Mar 2024 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711897526; cv=fail; b=cKx+l4SnOBrfC9inKSqxsPrXgaKrc3y3/EhqV+mxKfx60MZqA5MB+dXh3dcNOiWCyo352qdjRQEPv7g5Eps0R9oH2k3YdCMGJeGXazUzL18plSOxEEsQLN/mQ+e7qq8heSHNnYzzDKvnY/PP6TYOTsWb6gG8O7hPXEOfmjjEM/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711897526; c=relaxed/simple;
	bh=B3OGipwb+0sVeBg2LNsYHRRypUheYKwyXM86w1Nyujk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=afiRfxXEiZUnYbD2JlR68VYSJD3MD/B1RcGc92qoek++ZIl7veAuUdGQPWKtPinNb6CQmXYpVMnZFy/3WsXxtww3BQKX5aOA3lKVXIbePbhKImuCiY+ObmyZCx/D1p3j2HmmmwagMki+GpZk7u+oWy0K/iRs2XSLvAG3ENjh0wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ieCGqDyH; arc=fail smtp.client-ip=40.92.75.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlO3PJ8M1wQi6oakfmortGMTjxaRT+K0uqGzMGDSgG5IpcBkWu40ShGYEp1kFnkEFuaCZukmcRvTSDVgfJ1gNvs/GBneuzU7tbMfzTPGWAWkOeFWkBfERvq22aj9QvI5bc2QJmEOADSqI3NAlqT4E24jYp20Z5t2aLzWkYE1QODH+Y0shjBv1Cy5U5yTo9xPkz7e6Lem0QMZ7pS2WM0kRWdeBQK8g7FdavAY39enYKJ5XQ7szFLkE5d++8pezeviUKX3UkRmXUFWyh1hXIwKzGUKBu0pIVhrbLSSyvptauLi6lgP9XcEnjLp66DkeJ64bUbwRfeEL2Owzf7GDkvm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzE0RtM1Zo7qthW93kAZAngHg9wpx8iF5BRNORZhF4c=;
 b=H+iMcCenIgzSAem3Cny/5npZ6639K3nW7bUFe/az9kN/knuXWWkr3un4f1wdbKPoap3tOqPJhRIlf7lHdmwpzXRzQSvOJFS6Pu+vFhttNhsQOVghCfH5S2AsH4vnoKOZtyLIWLSeij+I7D4rPnSv4uA8LQXZMzl7OBjUmTbvjhxznlaGWg1GTlLK7u4a6FNRoOlShBVoD0biwKKIZqve6Ylb6mdy3Rx8poVmBAYO0AIe23txJPSVgB1wKiRcy/REKzbtvVe0VUak5rc7SCsXDJvV/YJPL66bhJ0k1ztR28LZPsEuNHemqkYQ8X/Pd+NSRAvgfNUhOHPZqR4pnPS/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzE0RtM1Zo7qthW93kAZAngHg9wpx8iF5BRNORZhF4c=;
 b=ieCGqDyHIQy8aDxva7JsLFcgG8TCVTrk12Fu48OXLcC5vJ8RCwDlzhmmiMf2m7qVOnPFKB3WaXRVJY1CHkakX06XVkq1NuY29zCw80wfJT5ZizIpWQ19T79FjB/WbgP5XexvIx0DxucOqMPiWjx74JK7/szNibKGpJPeYe66OEQvP4kL2zatl90wk5Z6PA9UM8dJK++elXVvWhhBejj4HHndAjn3hNVPEKgxRpwB/BBVknIrZW1rUfNldvaB0tj3gxygwMwUNZLNM0LAGNGEWJcBlX7ibf3DwCpeJvuQZvj2KwEDXsyyi6Kc30y9203CtmKwYTq9d78Du4vUIqlOSw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DU0PR02MB8690.eurprd02.prod.outlook.com (2603:10a6:10:3ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 31 Mar
 2024 15:05:20 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 15:05:20 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] RDMA/mana_ib: Add flex array to struct mana_cfg_rx_steer_req_v2
Date: Sun, 31 Mar 2024 17:04:53 +0200
Message-ID:
 <AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ax2AMivpXtObadqhPIRt7GSws6HmSCa/]
X-ClientProxiedBy: MA3P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::11) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240331150453.5432-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DU0PR02MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 2725dda3-38b9-4383-539a-08dc5193fb94
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBsbamEakaZu1wFzLqU5ubB8EJuublZ4zULzY+Y+3WPTzZFjw0UTpAp5bJxoxVy7oJxCgKwEEr8MAOmSCvzSUbAx2Oz7j6tth9ThI4qv9rAc8i5s0UOIOu2krBdLVjUcaTosnES15mEPD5EWyBgwFliEJy73mQDRVrzJRgJ06jjDNpvgmitzplvQNPXOuOGcDcORQzq0iPohPkazZVNI+xvZomA9Csahf9LgUTR8Df9k6fhALVDkESwc6E1bJCpix2LM2aZvAHOk27Fn/iGkH/NKTKrKvH3X+UoLnHJdjGDkECaxN/cIPaTXu2TbEvODCEY1Gou9kFeirhR/GmzBkUMOrd+huc4E+eWaJVO5l8rO8eXamfTyRQlYIHZkV73xUwlONmSlDHAjo5pYyVQ4fIRzpS7bjzouS5yfGnxTwUNG7hp8QSQ38HDkL16HHb4vBymQs11MSme9T8ROU7mgcTw1OSO7Temhuwin+LQKnHYjGa2aBSZLFXtGHKQ7bgRCalmoSHDn/V4oWHA3/f0a5qZht7yviw+m7TZjSSS5x8BTGcGYfOmtJhHjhSN3pKoQIYT9BFwRWzjcSFetcwXw8SppwwsuSldjA1NyCpOm6vof5VCKbU+wAXGF27eIZLgGqpJU/ja7GxhAd12ds07nRF4EheiUqyUdVhU8BWNDjMjZf/oA2MgkbHgp/2IXSHlxybZPP1hNd7PkX/+r62Hc32SCwT8eUoYK6lbdbFpy0vEV+k1Hv8W2o/k6MsZD3+5kMGCeJwwk+9AW/SKufCvKjoeG
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XyUYUnDC+fEiim2xlTA//XPjLZpg84E1IaSysCt7WxY4iHw1ZvDSUGkOarebfnPwi15yigOAgyFApFdim9Rmw0Jf418paEctIhOQO388lkfjZ7QDe+AbUzy/HBuw2zg1rDFzFaOyl40Q/PVCxtFTJfyeMniPZ59J0Uk55CecsU5BmIKa55V+MAa+c2ZOKpqRgC0oeUFtAbvlHsxmpAD+bZ7/I0pd8UgMhOrdNksKiHO6emwtUb53kckDcoA2F6hINPbLKN5VH+4hF/L2+tcsAFTuCanGoYn7O2IChPwjfofEdXuyvSVFUv2GgQDjkHtydWqpLosJvNkUzJeIesUK1kd5QTvSyVrnne+72dXmYLfHi/nOH07hN/hqKCbE6hLRKWYOFYWkm8htNv3WFrV4kQr1JO3dmj2n3yiYhGqumUp9UKet79S0V8jyBrfK9pAvo82MeTa/CbeC80BWrcyBcm/+dS2PEJskIN6S/v2WitpXpt52NYKZxFVmPGRGapKuNtBlddW6ywHWVRGLp6i79qXmc1eTTHMTQBZZZpkY9rszpcrEr+TvbOa8mjiEgt0fpN8tPkb7ayZDhbxN869y3VLm+e5A5sMaEKF039gesjPv7YBJ/bHTstqbw/+z6xUNJYFkXh55UWHz4h9nxs8HeJsAJLBXrXK5qGD6Vw8mVfJuc1iHfvMG5nLcNqd7BMZI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJhDBq/GG/JiMVVX3Nq2evRaBJRNNGIUMYeeL9/ZxBW0eXTBt//q2wWn05jU?=
 =?us-ascii?Q?7qznjmlI7PH4ql1Tjo64uUhMdQfxsBkqm5tn762WcPF0ffLjz3D5xX7fuHOD?=
 =?us-ascii?Q?TcqA0Gg1ZjzlVOuUn+093VCUHSuKUE+8BvMQMvFDaJTbRK5R2nl/Rx4d/OFE?=
 =?us-ascii?Q?TC/JabyEtTIyhEjs4R1l5aUIpwVg1eUZxZJbS3Kl/PpaYv61uYURCDRlWbNF?=
 =?us-ascii?Q?9wjbrMTVJ0u0e//EPM7QxkwqYpO9UTfmSe5EkcrBtudYWyKtws2O4S+Dfoy+?=
 =?us-ascii?Q?4smmuU4pew+RLMFAnH/dE3zMOaZScfvuPMZyI/nlFR+FUmopwkoCspMpq4/Z?=
 =?us-ascii?Q?i605RMwx31Yv62MoCxVkJbDX24tbX+8b2aN0Htz/cjPdEweTeO8cc16rQZMC?=
 =?us-ascii?Q?mvfFR54FvBDi1ie7relhgVG+Lj6b8wWGx+Jsb5z8DebzWTTQ0JY9cbSLcBJu?=
 =?us-ascii?Q?2/+gIG6FL4yYcUIVqfHJu99MC6oKwsBb1aGur9+gW9oPfIKv8lPvtgtM+yzL?=
 =?us-ascii?Q?G2+FjyzH3kLU5OVdmP5NlaT9SJNblXlGPy5TVX/G+iop/3iD/zxTOMX6scJI?=
 =?us-ascii?Q?h/a3Mk6hKiHzSUgst1QNc3LVf4HgWplNut8C+L8HrwuUFIs2LFdb5fCLal3o?=
 =?us-ascii?Q?6vWtP6w7xdP4oimrMa6+NVPy/F3gjToBF+kt5Dv0rEhXMPTe2kFCfcS+vJ03?=
 =?us-ascii?Q?wpC7MvizUB9IOrA43YMS6EBC3qGpIOSxx+hn1Y2bC0z4lSZRC7CXMnBUbKm7?=
 =?us-ascii?Q?wBaAvy/twYYbHn1Vz0fhKbbAqk8MP22hI0u2XzaBXjyyvZEcKec40HZsJk7x?=
 =?us-ascii?Q?JmL7xHmeusGOfBTllRz4Y4/Fpng8TKA6edZSV0CGBBBJjOLWR9GmwuXI3b+M?=
 =?us-ascii?Q?B7FzWQO7j5MNyU1S8bX91Il8RoOswbNRRNHMbJNVIQN5Jo6qlNVXiQlahwbC?=
 =?us-ascii?Q?OdiLhBEP4gBkpP0hHTrVJfHQQxa0kBdSFhjk9kX+CBULsJL+Qsh75mkd0uzC?=
 =?us-ascii?Q?OgaZSHSyZii2IG1QIabskF/NKjzsvSX+1R9IE+2tuZlFLFobHB9GcHb0IYKT?=
 =?us-ascii?Q?mBU+ZadFTKFPQEOvTty3PU/X2nWwiq9Op4SuswGwrKp+BNvE06YmDeD7AkSv?=
 =?us-ascii?Q?bd/k74m1SJFJQtntZgZnjKQX6FAFV/E9lDGp5amHDgsvDtK2aR3enmuAE/DJ?=
 =?us-ascii?Q?L0rBcIvaBDUzQp2QAr02XJGsF4YzVRo0rW0yh0+1ffFj+Epvzbe3Mn4YL+pG?=
 =?us-ascii?Q?rtYig0buB88VQueXs+eI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2725dda3-38b9-4383-539a-08dc5193fb94
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2024 15:05:20.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8690

The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
trailing elements. Specifically, it uses a "mana_handle_t" array. So,
use the preferred way in the kernel declaring a flexible array [1].

Also, avoid the open-coded arithmetic in the memory allocator functions
[2] using the "struct_size" macro.

Moreover, use the "offsetof" helper to get the indirect table offset
instead of the "sizeof" operator and avoid the open-coded arithmetic in
pointers using the new flex member.

Now, it is also possible to use the "flex_array_size" helper to compute
the size of these trailing elements in the "memcpy" function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/infiniband/hw/mana/qp.c               | 8 ++++----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 9 +++++----
 include/net/mana/mana.h                       | 1 +
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 6e7627745c95..c2a39db8ef92 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -22,8 +22,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 
 	gc = mdev_to_gc(dev);
 
-	req_buf_size =
-		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
+	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_SIZE);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
@@ -44,11 +43,12 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
 		req->rss_enable = true;
 
 	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
-	req->indir_tab_offset = sizeof(*req);
+	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
+					 indir_tab);
 	req->update_indir_tab = true;
 	req->cqe_coalescing_enable = 1;
 
-	req_indir_tab = (mana_handle_t *)(req + 1);
+	req_indir_tab = req->indir_tab;
 	/* The ind table passed to the hardware must have
 	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
 	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 59287c6e6cee..04aa096c6cc4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1062,7 +1062,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	u32 req_buf_size;
 	int err;
 
-	req_buf_size = sizeof(*req) + sizeof(mana_handle_t) * num_entries;
+	req_buf_size = struct_size(req, indir_tab, num_entries);
 	req = kzalloc(req_buf_size, GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
@@ -1074,7 +1074,8 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 
 	req->vport = apc->port_handle;
 	req->num_indir_entries = num_entries;
-	req->indir_tab_offset = sizeof(*req);
+	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
+					 indir_tab);
 	req->rx_enable = rx;
 	req->rss_enable = apc->rss_state;
 	req->update_default_rxobj = update_default_rxobj;
@@ -1087,9 +1088,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
 
 	if (update_tab) {
-		req_indir_tab = (mana_handle_t *)(req + 1);
+		req_indir_tab = req->indir_tab;
 		memcpy(req_indir_tab, apc->rxobj_table,
-		       req->num_indir_entries * sizeof(mana_handle_t));
+		       flex_array_size(req, indir_tab, req->num_indir_entries));
 	}
 
 	err = mana_send_request(apc->ac, req, req_buf_size, &resp,
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 76147feb0d10..20ffcae29e1e 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -671,6 +671,7 @@ struct mana_cfg_rx_steer_req_v2 {
 	u8 hashkey[MANA_HASH_KEY_SIZE];
 	u8 cqe_coalescing_enable;
 	u8 reserved2[7];
+	mana_handle_t indir_tab[];
 }; /* HW DATA */
 
 struct mana_cfg_rx_steer_resp {
-- 
2.25.1


