Return-Path: <linux-hyperv+bounces-10768-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI60CulvAmqZswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10768-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A6517C3C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5515F301F48B
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FBB14BF92;
	Tue, 12 May 2026 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rSEq3h8u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59272621;
	Tue, 12 May 2026 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544595; cv=fail; b=luK/3Cj/ynWSnQwQE6jLDJ+uYhmKr2PEY19RjxOkbjPbhPzo4WoRzEW8rmftHp5JFGnIttx22m/FCYiMgUHo01+m4h2Hs9oTyry4NEfNxT14jwW2WtdkQ2oGJ0Og+yqxWK98+ZLSFd3hWXKKNZMnwMaRewJaz8ZQt6smVICjh3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544595; c=relaxed/simple;
	bh=z69yoz+VZ31mTAsC9Wji9aqDhsgmVFGg4uUqnoRBXK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKMM+T6yjlvYvD3dPTX42A2BFdU5Jzno+vi+lE2xwwUJn1hj9xd5+4zebgfD7c4c0kAxDvj1OCeOJyPnSlX8rQSSWiPhMYHbmf/qTOiFxFSRkLnrGB+Bqif/GcAHSK5shSK8dcW+5NpSOGFbsqfD0Xrc6Y9WnMBGTg2zBivrCFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rSEq3h8u; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXBYQ2RlQZ3jcRaG9+/oSKhC1ogQaaEuk5rCkhriLIWNrv25pKqG/bQMr9uQCF3SuQr4pZkub8JbLukrw5W+i/upQvRQFwc1nA9D+PyOY402ii+NMSML9WvmnHEt3HulCyB8FJMRlxMeb0FoJ9VqWx4LiVPDCiXhDYf2REKl/ixjCw3P1b279wS1Z6TzD7NOGc3GLrfrQdIM82KnFATDGVlPSltf8onsZJNenSEdAYJy1CVOaE4GkVg3qoE8Fp0aZd/AlB6Ih6Uq7VRxldhOH3o8/TxZvBC6FSiG3D5eWZovpegJ0fEfAoGDdMUlo2jyLIWvajhFmrUW+twpux+mgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSy8w2iUlpulbsi56BfAYFsGBG7o0sG/0tk0K84qBmM=;
 b=yA7USvaZoTa5sZkf6ITi6/rT8+5l2LEAfWfNVRcKkWKQy0zqGaZLVLAJQIG8yDBDjZCMtQ0VbIRVdN3/brUsLbfMP28aYCq8MgeKqC5yNKGR/HETbDAgK3ukFXIbldWo11XZroKwraN9DWzDy7s2szxMp0fhu2mdaIQSjYBH3fw9SdA1zKA2D7pvq1afycqJ1gCfq6Qp0j86ziTK2AHH1TJEIDozFm5IpgbO6LlqmYDnjUVRFETrnxtlgT1qHGnbNDI4QFaM4zdNj8pNPjTBmr5Qr2JekLtHjzsn632BZC2aN5S+EEGKhsZC76TPItgV44EEaYIBqzX1lJAh295kMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSy8w2iUlpulbsi56BfAYFsGBG7o0sG/0tk0K84qBmM=;
 b=rSEq3h8uqiR76E1mCnRAWWCXisxEorJetK/D9EJXI0A81lnJRsX+GZG6BATyuZSQUHPLZGlEJ3kv5FZCQRl2FXwr/jCnSupcYwZn1u6XIXip3rQy2SNfes76iIqGCb5PlvytNH3oMKxQfhzpD2cvbSPDOPf//D85Nh6u7mnB2tgTMf3POSr7O9QOblPGBGHiRSh3bmtPX+xXtgicJghwOM9Fnb1rCfQJ/lq4Ox2A9nc2pk3p8LJRCWa3GjnRqkQDKLzCy2yEIxHYsUlUSuri42nEqv927uJ0Q+79Dq0oRKe/VtHW02qd+WfLtb4h3Fz72N32N/QGWg81ZACu+uUTmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 06/10] RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()
Date: Mon, 11 May 2026 21:09:35 -0300
Message-ID: <6-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: bd30de3d-e017-4bf0-c685-08deafbac49e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	eHUO/L5dTwKZhQt5A4RL6V3zzPLOHu0hXW6uuxYy24/KBgkIJI4LomgmhK4ULq13Hfav0P7GYEzsV9rJAuaPUYBkjpfSMaOR36EdNtRvvwkBUBjeqDIarcjGSV2Zi/Dy9Mrcd/lUxXz1F924LLdqtQly8Vh/ZOWg7DXVawzEi8u3WzVuCyCHced7BYO2OBbrcOiRFPCa8gVgRMREfCa0a2X7yjcZMtIvv5qk2sh52oGfnRF0HiAuZ3SMhQUV31QMRw/ofnys/hYAVlYoxZk2B9jxWq3j8OWkP0qaYzzRZOplu2WBxe0edChS+XDaUETBW4yuuYOmn9jzhVGSXekgX3POxOWmZXwxs3R0fs7a41CP9QsTw1OQPOjoNev6tKMefV2IQQXkbSoM8E9fdG53JuTaXZ15kHipItp8Yx6aEpdy6KAUibfwXbirlgZIdAMpKFobokYA6/J4wwBMu7y6KfvkCCbp0iro83eKEnhypa/XOdcnoegK50wJ9ULN4H0UzuRMqbDxguauQle/DHMCjdzb9OtzPaUcPfmsocC9oQi9OX2bEXcYRzuL8x8eVxN+yyDgbtBsYUlswQeFP7D2IsXszaHPZBBRTM4uyMUkZp0bYPJHhjGHMWWLWiGhMF/CjxqHzqphoa87FY1LZrZ/beA4KS+OLegN0ZSPaZ9SN7bwpsIapTHqVM3dHHZbuO0BuSSxSz2erZbjVLMPwNc8fuC7OjuttM3s0MfShJy+Yp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjGvuWeABl9HMKR6C8FIHk1g1X/l/DmChQi17dkitIqhCXkPCscc+IhPBb8f?=
 =?us-ascii?Q?eUjh8w9hCy2vofkLJy8oq2ZDPBirdpVPSIV2J8uUHL4vo8rUlZ+HqBmDwTr+?=
 =?us-ascii?Q?0gd+6yLgvikQ+Gt5GiDzvAIiyMvPwrMPfR7OufhUegtMZ2DHtpIltNBED7ld?=
 =?us-ascii?Q?EvRJraFsRP3dRRRFqEyhJXfBElhhKtkaWs+dszcVjChbPGp2nq7QDcLG9UFj?=
 =?us-ascii?Q?Jgyi6ZlezVub1KEJltOj9l/WJrO4AySsswdjlf4F2ncIR6jlsFT3xWRE868x?=
 =?us-ascii?Q?5xh0Ks+EcNanVvhDw4tfeqKcVpsHR+gSbz3LbKCE6Tu56pBBdha31PFRIsIM?=
 =?us-ascii?Q?OA1RhM15Fa8pezkuR45jk8ZohP11C+VTFODQ7LBXd+Y1czFtX6ikfE1zj4gi?=
 =?us-ascii?Q?9TUuV5oj5/nfNEYwLVdqZHE2pDU8WEVnNI+NBZcORhuj7rp6M7utpKF0N3FP?=
 =?us-ascii?Q?BPo0XLJJHDf2tMxB3wjV8QPJnPIuulG6q1tgYrOEzN2Qhx4mC3D/x9zrL8Ad?=
 =?us-ascii?Q?uTrQciXmpHDsDAY0jSPyEAksNqicdRxUR8MGMOeWIGqZYp1u/ajgMcNckaVJ?=
 =?us-ascii?Q?paE78hxpsxuPdBPmH9ehZE04pZ14NZ8aTwKBLEmfmsOXrNlsYAPtHK2ZEd6Z?=
 =?us-ascii?Q?FOt8MmnvBgJ3Jem8nnyQx36XZHTJ2LBroNpoMZ5CZbBDC+3/6x8ccywCv3/u?=
 =?us-ascii?Q?fkuQ88au4p9Q40Eo3SxiplR0bkHXMUVzIbdr7sfLUl8vWBl5olYNhWPiEIP3?=
 =?us-ascii?Q?C466LTxASLUbgn3cf63NFLKrfqEhX+aBSgSk+DWMtSNrISp5i+gQxWt423he?=
 =?us-ascii?Q?umLNNgeZe9M/2J76cHhKmIA/aIZWqQ7NFFCnfUNy+ag9ENQP4tDQO6wHyRDJ?=
 =?us-ascii?Q?IGhJXup54xXnTzDcCk8q8efnA5k/Q/XTJPMwa3PoYcIJOcIJVplIVhKyjkkG?=
 =?us-ascii?Q?TYTtXMcMmuKuPQnmirjWkAKTG8rNAxbMq31vdUcDYGDFuZXAS/oIWvaoKjXJ?=
 =?us-ascii?Q?va/Gw6aBvZKTC/xpUoIwwkA1fIRyqy439z2l6+UV1t5Lg5pUN2teeJURzDse?=
 =?us-ascii?Q?t6kt9+Cbvxj2pYe6XX/MDHjkB3FL8JrsepMhYvO5h4aIWt9CusCUcIJod91Z?=
 =?us-ascii?Q?3/5R82n+7UefN+lDyQRvjp7JjjvhxT8PFXQPSL5gJ36yPV6A1WI86BGZIkQ8?=
 =?us-ascii?Q?plTpZcQSdd0aTVH+iRn9UVZHM+18HyGMmYzFajdHCrcGY7niRJRBWC3V2Usp?=
 =?us-ascii?Q?McisE17dXzkFAfVIMgTI8CzKQ8v+ZvIhka0BopTbSIczxhLEtN4HuT0sHoeu?=
 =?us-ascii?Q?sJLfhMMCPRv000zFKgk2SLOhc0oQb97V2VO9gLhCHooFzFLW+cSWydO85+1T?=
 =?us-ascii?Q?ohcaSw89gAI8H9kWUyweN2oyZB4cJEvjUpvD65DJrGfCfFkT6xwwCKJc5roD?=
 =?us-ascii?Q?ueBcAmzKfW0pOlcudfB1+WEQ53zWKh1Cko5bqNtkECm6raB0TvvdIWSMtL0g?=
 =?us-ascii?Q?bsmvu0VWFJLZOj2jW0MNZWq5Zf4H8DKGCeT3h2HR+5APbiVaiEG0VK3vn7WI?=
 =?us-ascii?Q?EqnZt4jjiExDdTiqJsuWmSFwN3B+l7JAaulJsNkj9t3QrJruUfoeo4vbiGaa?=
 =?us-ascii?Q?WXt/hIfoAtupPg/yabLi+87zEy4pxU34hRslphp/D+SJpP1uFGo8yS7voiKn?=
 =?us-ascii?Q?EFBQ/ZKvMzLmLDpBktg/OyUiWgJQP3rFj7EKZUGYeO5hD0Hz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd30de3d-e017-4bf0-c685-08deafbac49e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:43.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AgSPb+ylVSKEhOkPk4zeuEOUhcPjDfnYk9iW4PmdIu+rwkCaijs0bja1S46E/HH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: C60A6517C3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10768-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is another instance of the min() pattern.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 35 +++++-------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3b86ea1cf88883..79190c5b8b50b0 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -64,14 +64,6 @@ enum {
 	QEDR_USER_MMAP_PHYS_PAGE,
 };
 
-static inline int qedr_ib_copy_to_udata(struct ib_udata *udata, void *src,
-					size_t len)
-{
-	size_t min_len = min_t(size_t, len, udata->outlen);
-
-	return ib_copy_to_udata(udata, src, min_len);
-}
-
 int qedr_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey)
 {
 	if (index >= QEDR_ROCE_PKEY_TABLE_LEN)
@@ -340,7 +332,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	uresp.sges_per_srq_wr = dev->attr.max_srq_sge;
 	uresp.max_cqes = QEDR_MAX_CQES;
 
-	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	rc = ib_respond_udata(udata, uresp);
 	if (rc)
 		goto err;
 
@@ -459,9 +451,8 @@ int qedr_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		struct qedr_ucontext *context = rdma_udata_to_drv_context(
 			udata, struct qedr_ucontext, ibucontext);
 
-		rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rc = ib_respond_udata(udata, uresp);
 		if (rc) {
-			DP_ERR(dev, "copy error pd_id=0x%x.\n", pd_id);
 			dev->ops->rdma_dealloc_pd(dev->rdma_ctx, pd_id);
 			return rc;
 		}
@@ -696,12 +687,10 @@ static void qedr_db_recovery_del(struct qedr_dev *dev,
 	dev->ops->common->db_recovery_del(dev->cdev, db_addr, db_data);
 }
 
-static int qedr_copy_cq_uresp(struct qedr_dev *dev,
-			      struct qedr_cq *cq, struct ib_udata *udata,
+static int qedr_copy_cq_uresp(struct qedr_cq *cq, struct ib_udata *udata,
 			      u32 db_offset)
 {
 	struct qedr_create_cq_uresp uresp;
-	int rc;
 
 	memset(&uresp, 0, sizeof(uresp));
 
@@ -711,11 +700,7 @@ static int qedr_copy_cq_uresp(struct qedr_dev *dev,
 		uresp.db_rec_addr =
 			rdma_user_mmap_get_offset(cq->q.db_mmap_entry);
 
-	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (rc)
-		DP_ERR(dev, "copy error cqid=0x%x.\n", cq->icid);
-
-	return rc;
+	return ib_respond_udata(udata, uresp);
 }
 
 static void consume_cqe(struct qedr_cq *cq)
@@ -994,7 +979,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
-		rc = qedr_copy_cq_uresp(dev, cq, udata, db_offset);
+		rc = qedr_copy_cq_uresp(cq, udata, db_offset);
 		if (rc)
 			goto err2;
 
@@ -1298,8 +1283,6 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 			      struct qedr_qp *qp, struct ib_udata *udata,
 			      struct qedr_create_qp_uresp *uresp)
 {
-	int rc;
-
 	memset(uresp, 0, sizeof(*uresp));
 
 	if (qedr_qp_has_sq(qp))
@@ -1311,13 +1294,7 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 	uresp->atomic_supported = dev->atomic_cap != IB_ATOMIC_NONE;
 	uresp->qp_id = qp->qp_id;
 
-	rc = qedr_ib_copy_to_udata(udata, uresp, sizeof(*uresp));
-	if (rc)
-		DP_ERR(dev,
-		       "create qp: failed a copy to user space with qp icid=0x%x.\n",
-		       qp->icid);
-
-	return rc;
+	return ib_respond_udata(udata, *uresp);
 }
 
 static void qedr_reset_qp_hwq_info(struct qedr_qp_hwq_info *qph)
-- 
2.43.0


