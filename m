Return-Path: <linux-hyperv+bounces-11202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP1HOBLIFWqMbAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11202-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:19:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 988315D98CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4152D3042981
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246C3B0AC7;
	Tue, 26 May 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iqHcLcfT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C63B0AD3;
	Tue, 26 May 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812119; cv=fail; b=slbl/lcUp/DbEcOJ30Uhtl2nrvHWc+kZ+ErT05uSF60VeAWHRRMvCTNbpZldjWqdW32ez9TSeRqQS+GS8D3ZZGf74SN/835oiS7RnHM8vKFobmBPsV0i1gVChuzUE+ySJNu3NxpopbK6XVqhLRw1QfZIqnRgIRwBqisHDrR5PEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812119; c=relaxed/simple;
	bh=7FENOqRda6rDEU3xJD20UCZB7q+W6OP6Frt7BrEXn1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SShn7ygXZVPV2HeRZZlgWvFBeSl4ICxLGU/BBPyVrIUE8VCFc0jsVKyfW4Rq7+BMUd5TCEwsYpPA5bEdiit6zmkSRczhNrLe2VwPw223Q+M6A6VDBS8ixS10TZDXGaADQs5c2SXGJzMjok+cIjkw6NOT5oP+J0QUPFSqE2cGqSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iqHcLcfT; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVrmeSXGsIQBbId7XMQ2dnba5mH4+HjeHp+Xhdhmp3/zqzkr+wxdqBM1+BhGMskLRvGP2V2cKJJ9loKWJuHHU0cR1sq9BlbskaY+/NhTTziFBjgyH3YXb7Npw+0ht0Jhve8CqONeQbBRXtukV6JQEm250iBXNBfPxQd6UHS2oKvZiTCOHQJL/aUDqQSDDNyrpAIiMIOeaFDcy8Z2OAipRuon59TxR8YSLlxtfzHeUXhg6QwE9QXPKPX6i0k65dBscqWIw+rWwreodHRZw5QgUYGXdTy0FljvIFRdpOfARJ0sBWRhyeRj3Fj6CqlknNBOZUwkDaQzuZBcgP13WA69XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87xMRSkCRnBMmgAF6gIUaX+jQLlKzvFa7PU19d8iaIc=;
 b=X0Lw1ht3xW6O2bZtAUS6XMmraY2Q5Yy3SEBvhdpx1h25NyoRWgoo/wqgIuo59Jr7Hj2x/SKhmnPPHJqWw8v104KhfN/p5IsV3Ft/gHdYKuWwGv0I7B0iVloF9Ks8cxuKzQcdi0OrKwPjVfUH+P+VwYyXR4qbvE9k/k+TnB2zROEjbjFa7YYINnQNh1oYdOQdwOXxDIRGPkKW1DQgpeoqeRPl6HuFfNbhCXpjj0/2SWmsDDwhWTCRWzErUzzw/x4ZD61aAbjL/aIHo70ThdQFYTtTB4p/oLO8U8K+tKvTz6jUv89A2IaOnkro+Lp5MeWR0BXrcTCeMEWvH/cUs7RHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87xMRSkCRnBMmgAF6gIUaX+jQLlKzvFa7PU19d8iaIc=;
 b=iqHcLcfTSOoFb/5JGZiT5FJm+392G4gQKKCcHKF0yBv46x1UhWX+94CxaRxCZX1m+5WCCZem7HJ5CQ2fJ54LXhfRsu6As85Xkh3QOCJ2HayhmujKOhjURx+RoIV8xJh3N3ZBmO2/3ZcfocpYjfdomHK6VITLts87TewcgEqCgNuszq1J7xc0Bd/tP/DvXcdZ6izTvDfspkh2CQM20W8Xzovh4qsD0w8QFbL+QRJU1syQdR4GkXwmF082hODOzmWr3105/o5RoYxLZIqruwoxhezvbMa7UddgeqoSmiC8dqo2DXiGEMCEBnGFuGGhjzFQyCG9h5KQRsOWE6EJ+ga2sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 16:15:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:15:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
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
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	patches@lists.linux.dev
Subject: [PATCH 1/2] RDMA/core: Don't make a dummy ib_udata on the stack in create_qp
Date: Tue, 26 May 2026 13:15:05 -0300
Message-ID: <1-v1-922fa8e828ba+f7-ib_udata_stack_jgg@nvidia.com>
In-Reply-To: <0-v1-922fa8e828ba+f7-ib_udata_stack_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: caebc9d3-5c0d-4620-fd3f-08debb41f520
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|56012099006|18002099003|22082099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	BNQ+jvTLKIHtS8CurtiMPNpQYxDAVGZdIZZ/f5leu5ebxTVt6m3FrBZ/ShyPWhojBnMWYoKlUsXnskgB68+CuExaJ9Gk/bvAnrtB+UV3fH+DnnIgOEAXLz50XANyvps20y8q85l8i70hP5SEJ4yjzXEhofzSgA2xmn8fzS7ZXj2XcKAcatcFfWFtPbsrgWih4JiuBD5AMNAexHFWkIv3Mbl7q2XhTa70IfbaX+E9hrfy1lT8PzfOF7TBNSmMFqcmAeltsXYzsUC20W65zE+mfPfYikmt5saO0SW0K9Zkcgja+OF2drznWdZoi8A5ZORiIpxMCziSWG1aXcg0Ci2E7MEdaSg74yNegx/TDz62ZKl49djeybvG4T4vEJl9KcNOMpgigrJaUZyVtHsbCi/BqKDFZgFXjHwdQMOxsIeJKXP5I9Aq91FrVci6CDxKrvt4E1GiYGjo7Rh/bDyGkDcoRDUg1oPsz35TirPJn2/ksvBJLUi+u4qNwP9cBXRi8RrZt+i2mW3Y2rRQUd2cOsB8hBWaGj+V+zcBY0eoii+Ph2uKXiembDIq2LvnpSdMMXiHsPMAxQw3hnhh1wOeaelrWupYvQ7v8vl79Kd7jlyJgL4VYtuXeYqAQiz5BaM8RadeF73gDbH0tqygIxlHSMQDvdpjtWR6HdzHf0sndmT1yqmciI52kUg8TFUXXkpMBbpqlSdMiL7zHj3/79pe/yGZpu9z3vJZFEipp/5ESaXRItU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eifRj56wPibj3QHbEXvuEqStOFnUpv+zcxCyoetRvPw+j8d906fKGMgCJiiR?=
 =?us-ascii?Q?6RGA6XLUjxFD3xXBpqItSeemvODvZKjNHi4ga7FmCDiKKtuwBNc53B/5TXHt?=
 =?us-ascii?Q?8ITfWlgVSMQdSaqSYxp07NC2bhpxY/WH2/T7EbedQ7KRpeCaFRp4tBE9kZJk?=
 =?us-ascii?Q?LHvc49UjWw6SfKsTvGJtd1wpIVbtTzv5LiVki0WGy+BAUrnZGMPzdfholBKZ?=
 =?us-ascii?Q?umSjna1fBtht3RO2zedjA8nwmzlZ0uU764wUOcnJoUNmvcZ5ptctGODPJ/ZR?=
 =?us-ascii?Q?OaUwhdJdasX54r3M/Jy5q9qV6IKKcHlnQD21fwiuTTTVKXZ9+HcZP5J3DEDc?=
 =?us-ascii?Q?rHobZbrZcrpu650UofYgjUsiRecIkKC612GGWCzUnVg4KI8+rDsrefyWNa9Y?=
 =?us-ascii?Q?TdY/uuWX5PQrjMgsNssEdJK0pfcSgtHaImufQp0FffP/6DSBc23Dk7ECXKeo?=
 =?us-ascii?Q?sPj87ERbLTE9HYE3No+Iul7yuoY6I3s0l8y23iayIAoOlDJCzrxiCctYMvbw?=
 =?us-ascii?Q?fPcfFvLW8Km5A/WqmQqYZWlQ2WLxoNWnqZrKo4m0ALsxtyeJRsUku13D/Jod?=
 =?us-ascii?Q?IHDmCxuK0ryUS+Mznr7P6MvDwYK+aFLr5OAQc0s9No+Y8+oT8bIQKL/7V7wo?=
 =?us-ascii?Q?Dlc67yhXhAxFSIk51/x5Ah/looBAzgh+8ja/NhqULC+9c9XDamK9sEgljwBr?=
 =?us-ascii?Q?+lG7LHiExzZ7nT4mNUZ40RO6vz+tvk4RMovX8BmHAEmNUnQKFXAYxFPxzGOB?=
 =?us-ascii?Q?u4fXogrCrfn+HboQA0ttlNctfG0XoUj7KvGJKErQfLGVVen9J2/DASEuIlf7?=
 =?us-ascii?Q?I2vZKseQQ4DcuqKoAJvid6oXqpxdSDTecQ+TC17HsV5BZShJnTfFZDohl1ZF?=
 =?us-ascii?Q?b8lFvCIs+j75BmPrr9CY5xq/Q+2DKa1zp84hf8Q5n8CeDkJ1bRGn4jqLMWAP?=
 =?us-ascii?Q?+zoh5DA0tOJyRerXCN1n6Sm0yAl1lYslPtBv9foc/y42Ayr65rVCblAVS5Rp?=
 =?us-ascii?Q?y35X3rbksY0j8zwO8viV6hGKEQSYOfI/nNh54KP3gwsapZO8IBF6T+fJKiRJ?=
 =?us-ascii?Q?jfxb3bBJJUGi4rHvZDLQm5hBHtVby04nCen9OKX6HsMuQRsrUkeJngtX0AB3?=
 =?us-ascii?Q?/7iDC46jD4tWAcPOTsWbGyj/SykLMKOAg21Tkq8Q3ROt6xoUek6fWRKwBbIj?=
 =?us-ascii?Q?4Z0iepQv68/5zoIX5/yhrb2BQO87cZiLrRhteXkHFtG01olfr7aMZgXvUNLY?=
 =?us-ascii?Q?feO9af7NK7hnSqzskgNGvI9WRJNQss+dGDQgwqJ/R6O28+VIQqYRVkukvPIq?=
 =?us-ascii?Q?OvVhkdBfad7Hjy/VE3vGsJmnyrCy1kUopslVUNpDdkyoOGEFEu01oWB6MUfg?=
 =?us-ascii?Q?dHZNFZHisi3mcuBQsMu6NaHLn8RRJgSqZs8vMvdpCRW1i315/FzC/PFP6LKO?=
 =?us-ascii?Q?g0S7p/shhvovHjmo0Yd5vJqDDbX3ekw6Cw1mcz5Rq6bEERbP7PBmTeT1i6M1?=
 =?us-ascii?Q?mT6cdtZ955eyJSgih1Wp4o2UmfOVGSTbeoZbcXKIrqt5xAp/PQoz2b2UPNGC?=
 =?us-ascii?Q?/hDEQdceOS6097vjgRTDYQrfwvA1bQC5zI24geEJ7Qfw+TNIuLO2+X22+/ZA?=
 =?us-ascii?Q?FYIAh6/+a56ZG25PucE0/2gwRc9yut0fg0K27ylEkZTs4kcMW+TZI1e2bryB?=
 =?us-ascii?Q?kSVdHX5+j0TBI9FvyUeP3Vbt9+YTOBp7F02v8xGkdwcEZ/k7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caebc9d3-5c0d-4620-fd3f-08debb41f520
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:15:09.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vvf++YMO71jjmSJ5Zn/nslr4jt+jh+i530qonHdcaOJF9EnO26A9meC8HM6wLkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11202-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,broadcom.com,linux.dev,chelsio.com,linux.alibaba.com,cornelisnetworks.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,cisco.com,huawei.com,nvidia.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 988315D98CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko points out the udata for destruction has to be created using
uverbs_get_cleared_udata(). Move it to ib_core_uverbs.c so that the core
qp code can call it. Rework the call chain to pass the struct
uverbs_attr_bundle right up to the driver op callback.

Fixes a possible wild stack reference in drivers during error unwinding,
mlx5 can call rdma_udata_to_drv_context() from destroy_qp() when
destroying a QP.

Fixes: 00a79d6b996d ("RDMA/core: Configure selinux QP during creation")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/core_priv.h           |  2 +-
 drivers/infiniband/core/ib_core_uverbs.c      | 12 +++++++++++
 drivers/infiniband/core/rdma_core.h           |  7 +++++++
 drivers/infiniband/core/uverbs_cmd.c          | 14 +------------
 drivers/infiniband/core/uverbs_std_types_qp.c |  3 +--
 drivers/infiniband/core/verbs.c               | 20 ++++++++++---------
 6 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index a2c36666e6fcb9..19104c542b270d 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -321,7 +321,7 @@ void nldev_exit(void);
 
 struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 				struct ib_qp_init_attr *attr,
-				struct ib_udata *udata,
+				struct uverbs_attr_bundle *uattrs,
 				struct ib_uqp_object *uobj, const char *caller);
 
 void ib_qp_usecnt_inc(struct ib_qp *qp);
diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index b4fc693a3bd8b7..6c3bc9ca1d58ef 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -532,6 +532,18 @@ int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
 }
 EXPORT_SYMBOL(uverbs_destroy_def_handler);
 
+/*
+ * When calling a destroy function during an error unwind we need to pass in
+ * the udata that is sanitized of all user arguments. Ie from the driver
+ * perspective it looks like no udata was passed.
+ */
+struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs)
+{
+	attrs->driver_udata = (struct ib_udata){};
+	return &attrs->driver_udata;
+}
+EXPORT_SYMBOL_NS_GPL(uverbs_get_cleared_udata, "rdma_core");
+
 /**
  * _uverbs_alloc() - Quickly allocate memory for use with a bundle
  * @bundle: The bundle
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index b626d3d24d087d..56121103e9f4f5 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -71,7 +71,14 @@ int uverbs_output_written(const struct uverbs_attr_bundle *bundle, size_t idx);
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile);
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs);
+#else
+static inline struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs)
+{
+	return NULL;
+}
+#endif
 
 /*
  * This is the runtime description of the uverbs API, used by the syscall
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 32914007bae66f..41ad11ae1123b7 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -163,17 +163,6 @@ static int uverbs_request_finish(struct uverbs_req_iter *iter)
 	return 0;
 }
 
-/*
- * When calling a destroy function during an error unwind we need to pass in
- * the udata that is sanitized of all user arguments. Ie from the driver
- * perspective it looks like no udata was passed.
- */
-struct ib_udata *uverbs_get_cleared_udata(struct uverbs_attr_bundle *attrs)
-{
-	attrs->driver_udata = (struct ib_udata){};
-	return &attrs->driver_udata;
-}
-
 static struct ib_uverbs_completion_event_file *
 _ib_uverbs_lookup_comp_file(s32 fd, struct uverbs_attr_bundle *attrs)
 {
@@ -1462,8 +1451,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		attr.source_qpn = cmd->source_qpn;
 	}
 
-	qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata, obj,
-			       KBUILD_MODNAME);
+	qp = ib_create_qp_user(device, pd, &attr, attrs, obj, KBUILD_MODNAME);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
 		goto err_put;
diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index be0730e8509ed9..fd617903ffcf49 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -248,8 +248,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	set_caps(&attr, &cap, true);
 	mutex_init(&obj->mcast_lock);
 
-	qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata, obj,
-			       KBUILD_MODNAME);
+	qp = ib_create_qp_user(device, pd, &attr, attrs, obj, KBUILD_MODNAME);
 	if (IS_ERR(qp)) {
 		ret = PTR_ERR(qp);
 		goto err_put;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc6735..1500bc09bdc915 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -53,6 +53,7 @@
 #include <rdma/rw.h>
 #include <rdma/lag.h>
 
+#include "rdma_core.h"
 #include "core_priv.h"
 #include <trace/events/rdma_core.h>
 
@@ -1265,10 +1266,9 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
 
 static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 			       struct ib_qp_init_attr *attr,
-			       struct ib_udata *udata,
+			       struct uverbs_attr_bundle *uattrs,
 			       struct ib_uqp_object *uobj, const char *caller)
 {
-	struct ib_udata dummy = {};
 	struct ib_qp *qp;
 	int ret;
 
@@ -1301,9 +1301,10 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->recv_cq = attr->recv_cq;
 
 	rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
-	WARN_ONCE(!udata && !caller, "Missing kernel QP owner");
-	rdma_restrack_set_name(&qp->res, udata ? NULL : caller);
-	ret = dev->ops.create_qp(qp, attr, udata);
+	WARN_ONCE(!uattrs && !caller, "Missing kernel QP owner");
+	rdma_restrack_set_name(&qp->res, uattrs ? NULL : caller);
+	ret = dev->ops.create_qp(qp, attr,
+				 uattrs ? &uattrs->driver_udata : NULL);
 	if (ret)
 		goto err_create;
 
@@ -1322,7 +1323,8 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	return qp;
 
 err_security:
-	qp->device->ops.destroy_qp(qp, udata ? &dummy : NULL);
+	qp->device->ops.destroy_qp(
+		qp, uattrs ? uverbs_get_cleared_udata(uattrs) : NULL);
 err_create:
 	rdma_restrack_put(&qp->res);
 	kfree(qp);
@@ -1338,13 +1340,13 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
  * @attr: A list of initial attributes required to create the
  *   QP.  If QP creation succeeds, then the attributes are updated to
  *   the actual capabilities of the created QP.
- * @udata: User data
+ * @uattrs: User ioctl attributes and udata
  * @uobj: uverbs obect
  * @caller: caller's build-time module name
  */
 struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 				struct ib_qp_init_attr *attr,
-				struct ib_udata *udata,
+				struct uverbs_attr_bundle *uattrs,
 				struct ib_uqp_object *uobj, const char *caller)
 {
 	struct ib_qp *qp, *xrc_qp;
@@ -1352,7 +1354,7 @@ struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
 	if (attr->qp_type == IB_QPT_XRC_TGT)
 		qp = create_qp(dev, pd, attr, NULL, NULL, caller);
 	else
-		qp = create_qp(dev, pd, attr, udata, uobj, NULL);
+		qp = create_qp(dev, pd, attr, uattrs, uobj, NULL);
 	if (attr->qp_type != IB_QPT_XRC_TGT || IS_ERR(qp))
 		return qp;
 
-- 
2.43.0


