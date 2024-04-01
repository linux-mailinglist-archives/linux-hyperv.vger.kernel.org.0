Return-Path: <linux-hyperv+bounces-1892-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9288893CE6
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Apr 2024 17:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FC11F22A5F
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Apr 2024 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940A46420;
	Mon,  1 Apr 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JADSp+K8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2101.outbound.protection.outlook.com [40.92.48.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5253F9C5;
	Mon,  1 Apr 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985855; cv=fail; b=f6FP/L0iMISBf6CpTi6+7b0OkZeEAHw3KYnNT7AbNbUap8FHJfpSHWdo3gSgjkSS2T0ORrJ6JfLxUDR1401/auU4f++WFM3d8erLNW4JrVI32p1azLsdL/QFjoxOroCwWPPaCvn8SieE9j0KbQ/GyyTyZXE/taT2MGvqTn9cGTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985855; c=relaxed/simple;
	bh=RjN1+a0ze4yFbrlARz7hHcthnERxcsAYFvS21CoifFU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HnTzTsK78iDf0DAVsZnpqijmcJryynKBGOeuZNZB5h2cqfMg9atwTmn5qhslHU/HtOCgqv5GyLCXOL0aBeFpRB4lRoFvb2LtHb6TD+p6YePzzsLxED6w/u8SW4L9yhG5gyYJEOCvv6vNm3p3Qk2OIBWTHr/XTABPDhp0nIHWEjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JADSp+K8; arc=fail smtp.client-ip=40.92.48.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P11WrR4kpnUwWMFRREg+/3O1ncy53R0LfH/KpnlK+8+Rs7yCHkBfPutAw7xsGEy/gUpsgZXYtV/5LC0/QvFit3S0avzc19RtiVsPbLKA4U6Z3vKh4lnO3LN4lnufTZg57+yo/8Pc8p3KrCnIQ0NnlEbgRzAlOtfjTI+uf/U+kBb9Urnr0VF+kcuYSv6nvegdokW+vhB+FF4FCwIe1Koq1S4aj4Ao9UEugBUF40V1Km6CeNoYVU9zXUjzZzgFImxPcMnfjBMrX3L6kDK+uRSdyeK9kDrMVMOv3/or/7LkJD3R39zN4KBXb9xTH+UeCtuDpbk7Q268h0xflVJnBziDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4NhnsVgB+nR0/MI42aW4RkDIpRrR1MG06mVvZtxLZ4=;
 b=f7maFaEfHRoelI/ViujvQbz6WB1hUhd/zqV2yWoQjODJh08teSCuc18LYV0kWZtXhF1UF8IoCGAF2ocCrt1Z/RlFi+8dhPLIehrasijQnSQeRzXuAAYaASh5MlsJheuigE2huaGRLTm9LPC3G+JCJuS72wVBrBen54/bgPQanFALnoRbOvDd707DHi9XgOAN/PDLbyfxrtBaEt7Ajnso8ANNMK43LVbfPa1jNxbXGIuSrAKSIhAlGFO8DJeEdK77w+kos6ipD9AnC9g+IyeR+bOwFTAadSJDFqKSBB2iQocfsbCfy8sMQnV5H/wmTybBfhJqK9eh3toD3nsbVsbZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4NhnsVgB+nR0/MI42aW4RkDIpRrR1MG06mVvZtxLZ4=;
 b=JADSp+K8jVopMjcxABsyIUgOuUr+Kds1q9yC+ZxNA4WPCgpmQ4AIKF+oS0nk9gL9f0jpn1/Sx8bB1XITxcggBKkWYdn+8LLmgJdvCoC+CbP5SBsxiCV9LnTjAcKY/QkIllQ1so/7spsI2DGmFwtzDXojFVfDA1oo7CCPwuukuWQvJZuRxkkBMN0on9ZsDkVbFQp02zn1uZh+OpFUOrCO2pyZadnBONRyl8tZzyOqcTPYtSIa3C8YHmdlWA4NovlNQ/ZVdQjXjCXN83qOBxKGX1kS0XXzUOr6IuGBv0rFf72zkJpZdrVr1xtHjXLewz594JolLNYpPjzRgQvjisWvGQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAVPR02MB9891.eurprd02.prod.outlook.com (2603:10a6:102:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 15:37:29 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 15:37:29 +0000
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
Subject: [PATCH v2] RDMA/mana_ib: Add flex array to struct mana_cfg_rx_steer_req_v2
Date: Mon,  1 Apr 2024 17:37:03 +0200
Message-ID:
 <AS8PR02MB723729C5A63F24C312FC9CD18B3F2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [FCHex79N5qpriGZxlEPT84agzr8wScmQ]
X-ClientProxiedBy: MA4P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::19) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240401153703.5825-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAVPR02MB9891:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c7ad5-2494-4da9-b168-08dc5261a323
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FEYsG8lwpfYg2ZhSb2TXGs2vIwWEhU+QicVRwrjPsfisBBroSalmmyZgmyvq/mCuAmhi/dqBXJVQkTYH2QWwTXXeukaNa0KOyp71x5ZFdTw0dNtCmUJzD0fORD0ZaH39ReDM7OeIG9dPOtguZYreQjAZMQ814/Ju4IXa7EPLNRgljyZhImBSFJfiKst5b9G1V9DZ8/BRPshDBn5Kn6bbCgXSJS9zi65P2zAhHj4EIsE0HwRfn4V+UJufBLz1CjZQVYrTaoc9biQ95qRoHItkpusaEL2ZfWWDzWaVRx8/TRQpDhdLC+O6TvHTptv5FEr7venZZh7V4dh6V4WremtjHfb1Pk6LKy2K+WVgxDzc7UV8Fn44uw814df1lnSi26QF3IbTuLQNzovDV6kZSQmLW88X14Nsn5rz45EMSFzklGhMpBvXclG3lG1rn48jC4ZknGPyB7H0hMTK/dB+NwVIs3klsE4FoF6w51zUgJcpRSW4xUvPLxwccvS5xdZ21RApdCkSCze1EeHOUvxGDXumBGvLeZI8A/6gceaumNKzQkisJOyPIqiVuJe79H31sW1r6HIZ00jLLYUlownMsqAkiBwAFSS3jGD5hKvTE3hq6cZZ5Tg5x34Pubs2yvP7skW+bbrRU+Beiyo5SdcueA5+FsvXT3f9FLYwFnXRDWMeCvGZt131xrNMEqFGxwR3VWcX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1wmFSfklgBu10unlWvDB52wfRmVX1C4KcOunlGrf/4MKvup9sY6cnU1Raih5?=
 =?us-ascii?Q?UlBFoVqHm40GurLaFPB8AYrBaAFAL7jTDQ3mXH4eLqXaUE8tgymNbUde5iLJ?=
 =?us-ascii?Q?kacNeZDy3nCmiIuUu/TOZ6Ufj1/u6UT1MA6uNkWbsVngHrndG1y8iYTGXlUo?=
 =?us-ascii?Q?5XHZZ/57E1BRkvjaEriSxYDMAGt0mEP9f82E+ZNxdj0fDmshjuQ6FyoW2Dql?=
 =?us-ascii?Q?duivUWTtgRb0pxcQSKSp3EKHZn+JqfHyf4blWbotn6Xz3cTo9aUM91N9HoUA?=
 =?us-ascii?Q?FjakWhR91C0ndIrhp22PY9xtwn8hUVDzr2nbT/MRgGK4BijtvuU46PmsWjyM?=
 =?us-ascii?Q?pCZpBygew6YU3eBP4Tdpl0Z07TDOhYnzbdK4FAY+hiuoFuwOHQYIv3rV6+Nc?=
 =?us-ascii?Q?PBxD2PZUaPRhb7EIAPKx3a3wlv5v73KFqQApnMP6MZ6WxE2i/iwts2lMBjxs?=
 =?us-ascii?Q?aOYBg1Wy+vf8meVH2Gb+SEkSL0CIb4pWaA3lZgNK9LZNXsJnHcb2G88ORdy0?=
 =?us-ascii?Q?/cDcgUcdfNzdb2Q8e4E/kLMglBpIVl7KO/EsWJqlLX1kDiQ0jqpb5iv0oCv1?=
 =?us-ascii?Q?GF4WWa8nxmqEHUiR64FOdASr9RYixfIuPeG/x78y/8nyMTya7D0hknRNaOY9?=
 =?us-ascii?Q?fhd7sHPAFXNHwun/2BbKx7Znu6oMVe4451yPyHh59vm7/smkg7mPiracXO+c?=
 =?us-ascii?Q?C9Uilz1fdU9f8n7POQlPa1/OMzhXC3kMjkUcnqMCXMxTMQuK8EzQR5F2C73g?=
 =?us-ascii?Q?ltN83PAFrp/0xFzoeRl0Fk9kRFIeJ1y5QZZWvtQ08+4/L1XbZ6VTr767bXU4?=
 =?us-ascii?Q?0EzCqsnfsfdIoVCqXOYb913j4/JfEiXOJG7mWEMne8THNo1lj6utQzP7BsCq?=
 =?us-ascii?Q?zFu3wqKrK3LSGIrjaxR89EVyhuO1ZOP9slKiqXp7OvgUsWnyMYK3+4JXQT5j?=
 =?us-ascii?Q?TDrwMlDG7K/LCYsdw8sY07sabl+fpbNgkpIol4I7xj5Zuu4sKbhYqz2EtUFK?=
 =?us-ascii?Q?a9Dy5gqUoIy72PZdxvMLBZ8W6cjqT/8F4/U7aUW/+sTuxuz1akwLPARBj1LJ?=
 =?us-ascii?Q?l801EmhXgS0i5dAD+eBksTN6R3ii07P+eAvj43CpYrVuMz6r45lF8E4vi6gw?=
 =?us-ascii?Q?xP1lZhoGi4tRtLzQRD3kEGDnqc0h1e4mO9DgjbjVPCXMGPQMo6LSeNkeEjrn?=
 =?us-ascii?Q?GWAbo6JODr248rcmix0w7YaNNgpsD++O8BMvHxxioMNN9vbtVVj+PbuMtfN4?=
 =?us-ascii?Q?D26cF0vUwqaJPuxD5bSb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c7ad5-2494-4da9-b168-08dc5261a323
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:37:29.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9891

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

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Remove the "req_indir_tab" variable (Gustavo A. R. Silva).
- Update the commit message.
- Add the "__counted_by" attribute.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com/

Hi,

The Coccinelle script used to detect this code pattern is the following:

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

Regards,
Erick
---
 drivers/infiniband/hw/mana/qp.c               | 12 +++++-------
 drivers/net/ethernet/microsoft/mana/mana_en.c | 14 ++++++--------
 include/net/mana/mana.h                       |  1 +
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 6e7627745c95..258f89464c10 100644
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
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 59287c6e6cee..62bf3e5661a6 100644
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
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 76147feb0d10..46f741ebce21 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -671,6 +671,7 @@ struct mana_cfg_rx_steer_req_v2 {
 	u8 hashkey[MANA_HASH_KEY_SIZE];
 	u8 cqe_coalescing_enable;
 	u8 reserved2[7];
+	mana_handle_t indir_tab[] __counted_by(num_indir_entries);
 }; /* HW DATA */
 
 struct mana_cfg_rx_steer_resp {
-- 
2.25.1


