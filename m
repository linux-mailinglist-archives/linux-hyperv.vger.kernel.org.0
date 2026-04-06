Return-Path: <linux-hyperv+bounces-10030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMUJA0fw02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10030-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D02DF3A5C79
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6172300DEF4
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254033921DC;
	Mon,  6 Apr 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WeF2Jl/G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F193939AC;
	Mon,  6 Apr 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497261; cv=fail; b=LOHVmAH1AY6fMf1TkfiGgd/p1Eyde3JYUKOYrywn8PJR1FzfA9XImOzOZRbzuukSymN3n9XtWQAij+DeCmVwmOfp4nRsoJFlKyxgbJ56DQxXuidGpcqmSh7a/DmIuvliVZPVKoEGuYfLy74T2opshVki4giY4F00/HB6cZY2bAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497261; c=relaxed/simple;
	bh=tJbT9L2NDSy24c2ZNvr7nit2B036JdmnLLgi9DOVFwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H6SfS2hAuU2CV2mX0LgnA5a1KqqTIyGHFUxYZCyIdR1ril9ujDsqJ76R+lzBX3FiAwTQQh6TI/qtyPvqQ90sz8T1Bl64PZF6iIIzDf/NLTJE3JHyGRaSqR2NZ2t0sOUx9v7nVrJnpIp0jvix9Wafd5rj4mrO6mBZoAUn5K8xQdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WeF2Jl/G; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlqe/Q/GWMh3jH9H0Ki8Dd2+3kIuFXkFFwJ/JZIg95aWP9iwlSaziMHv5WGjMLxRZkgQd59aBAvH1XjGPinT1wH7eTppkBHtM+UvFoOP7NMPRrlFnbWs9oC9I0+UhTeWpewDbpCsjpNwGa0k6gO3s5Eo++507aS3Qu50Y3eOJzHtU0tXSkhBEXgIyXXdQn0ioU/66dCiE4DbsTx2p45RofKb/aM0+v/uI68Gkuqmk1jHhBApfk2CLRN3JGYw4/b78zPRNOw4nKbZhpsX7eB4vkfEfsri8giEdD7ScCIemrVnrqg3vFQ8PpmdziT1MJJPoRkfK4yv2QiFrV92q1Bxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKkMTaucY2S/7iuLBkoHTbvWF3dT/3vomg/Sk/NsJ8g=;
 b=LgicCGKml9bh5em12M+vPbW1mCcEsUAv+4AU0c9jKAgQQ+RsudmBI03yp4ZnIIzq55MRGur5RvJHkqbnYxocdx5wsWT0/WgRPY6aUGLqyUA9B1WwA/VcBwzyeEylK6XeFSWcZt/9KmX4WUa1190IUXZ6RvpDdkqIiJFXLGztL72CbX76YH4FQE/ya/goGV+6aKmFNmbR2Vyq/KmLmW71mbrqc7SJRfGe5JwSUpZkuImDvega/f8E/8Lx+5su0Ainas8AgDSYOiXmEtsBuiniFX5yE8fcU9AS+cLOu8PEpaiv5jcS541B+FAreOYMx1l5EAtnBnEABpLc3yZ0K5V4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKkMTaucY2S/7iuLBkoHTbvWF3dT/3vomg/Sk/NsJ8g=;
 b=WeF2Jl/GJ2nC3pNnQlhFW9S5UlzTw9qJjsJLE3QwQvr7bJ3W/mZDvb/7oXrknBct8WJYvtuLWto/sHimkPA0j6WVc5PaBCTv870JE3RIZRHxj6N3pXIeYlwPZdZaiF1S9jAAQbweRErdzMA692p4ww98GLk8l30JrLWGq6i5wuWGqpmdcymf/6Xvs3sfHbkjjxdfGdHqsy1dLgmVUlssUVVS7hmPDLU44D1ONCsZ189AIylm63t91KOE/4FAj4E3xNj/FHmP/3ixggv9CURkRon6OHsiTtU0YjIcQS9UhPS3FyfgiRtW38HWVrAi9dJS5BMD/qZ5Moc/HRTAEbnlSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:47 +0000
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
Cc: Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 05/16] RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
Date: Mon,  6 Apr 2026 14:40:30 -0300
Message-ID: <5-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baba877-bc88-47d4-18aa-08de9403a1ac
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	2E3X9lNoWjcHm6QlkIq1wKtqlfo0i3STP9mQctLlYG7kcNGD0t6YRKAz0KsyO+A1+FcGg02dUMRGA8FC1BQGEjEsAjuSM0fIe3oIswcrw4uzwh3FJyhqi70fxg+kaDjV6z+eyh7SEqzwjmCY0jq7aGTpMlFDp/2FbAmWPDz23rEgyk7xEQQugt/OWWKEbFSKKHpQkEGx+x2t1ENJbAe5Z//PddQ60Io4S0vcQT+CW/z1UusFoFTuEpZBDBREysw1tNKqbz9S0t1ygjf21Ucwnl3Ea3/HsOtfUCXhcafmRF5edkvL+/raSv/jth9hdv730boGwqaKZbuKxDy6s/l1nSuGd8MdwhPJ7xGow9XwRsBBjUAscT5pB4t0Me+QTvRyBZ5+6GK9EJKhlxC5IpIwoCxRTVYohv3Y1DyYZqaK6o2pXcqXwUD1GQoEk3bIFgK3/cSdwmy334466LIWP9GIGM7p0yoQDdGCMhR1yip/ktUvgXKvLw712/FC/1IiTGPvbvBWR/zLXjsvwJd6pCx3wdOzPM4lt2aAbQ6PUZBHbyRhtYpGQZzU8Y+fUvtrPJ5Wq0zpVl4Scr54hlM9ov+UfeeM7Kz0LdsVb92wNsK6WMB7Lk0D1KmVhx4Da2NB0YGt4AVlHY9aH9T6oFPLxMVT6Go0Whww0iGed2xvGVf33wrYCtKXjv5ys9EFrEAoXmZ3wrY9Lq8tt2bXtgcxsZhtMS2FA/qON6p0tj8igiz2IhOZ9D+fylQuQ6QZecU7GPH+yM8Qjw3PvKHVHtDU4qfSeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JybWBLS0RTXbIW8uyCXx6xOUiqeZCmuqI6I6n5da8eI+7UMyVebsC7S2ih8?=
 =?us-ascii?Q?QlYf8mnLTtcCy9klHGoyuvN/NFckXqrtfq1Qpg67w/el/sLPovjaNhFFHDjt?=
 =?us-ascii?Q?YWcQI/nZYsZ2QvrRRffkg8Vxo/j0jAWYkmWIr7XPPBt010+xWUVWnmGaDdFT?=
 =?us-ascii?Q?u0kglIeJc9wlnLNYZfULYW+A3sNCNvGMAfdTWv8T+uYxOQZUe9DweSRPNHLa?=
 =?us-ascii?Q?xQSgjodMb0BHhU+6YY9swNwaEO3v/dvA2xp1S0QwnYZrlfDOTHuXiDjgdAgK?=
 =?us-ascii?Q?pA1gnbeCYd11XCpvnROaF71eMYbTGDpy6hrvSaAhFBaKv/d+XBBVRho/SAZL?=
 =?us-ascii?Q?XdAIzRUjWzeDyAWDwMlk4lQyt1fC4En7uizFEWH0aUyvoC4aPRCiNUuY09cE?=
 =?us-ascii?Q?Xjiep0bVdjA2DlTBNoxtehYvkqYK2x+mljSw2bL7YRFKxeGFKFV3SJMjMgLm?=
 =?us-ascii?Q?OdwXT/bnQB6uZJyLASeYXbfmsM8nQMA1Ef235TFmqC5gqyOgoHJeXIuCJnlE?=
 =?us-ascii?Q?+SjaBHs32VzsVJCqmIf1wrpuN9RLaG9VWV0012Pch4cL1GG1FN2fapt/PgvF?=
 =?us-ascii?Q?yoqNE0laOHhiNNFlTa2IpHoGD6c3v9SB+YT6CIF4QYtGvMh+n+qQhrdD/BZG?=
 =?us-ascii?Q?/5/Cq3qT92y/D79M3KiAxQRfZY9WNin5QqEiAoeIR/I0s3ErxoobRJkcFHKn?=
 =?us-ascii?Q?4zxDT1n5GHmxwQDYK1WbxIE22fVrHWzG02BlHmRk9P6O3pOaF2qCFgpKzm/3?=
 =?us-ascii?Q?a0rDEpYYvkRGh0dfX497BjrW45TiyGJBGTb4imoowaoVBGLpCiPmY8vVeD+Y?=
 =?us-ascii?Q?FtDLh1op+jYmlXv1QFAo+OtbzRgatu8RG8RUhEK76SvEakoCLa6kCOgjT6eY?=
 =?us-ascii?Q?FfrVa/zmmQVtGllihzhdf2xwhvdBmFoxdouo1k9Go8puR+BZs1DpM08a0ceg?=
 =?us-ascii?Q?JchNmnib3X3hc2MNz3WZtWaXPW80OxV3RTOJkDMr1XefnCg3aNW1fqWxhYPI?=
 =?us-ascii?Q?vJm3+jcJnxfyoWV6tnuxNazcVI4uBVcgpXjV1AHyh0nSB+HVrVDrt3YbFlLN?=
 =?us-ascii?Q?c/wXwnz8sNUbzu0RE7z8wjzMpv8otiD0GraNtVDcFDFHl9ozQEnVzJYQ5JVJ?=
 =?us-ascii?Q?c6B2KuZuIx1ifLV3LWxCWFz61tMXP9ByFCPkahXprmg2iOiYCTsLI/tdwyuU?=
 =?us-ascii?Q?D/ztFFU81U8A+dA7oFNxErwPkbThliziLV1RYO14CQ+n7HW2UkX5V2Tdj2VR?=
 =?us-ascii?Q?B3G9jDQTUPnbAHFxDHIN2dMQ+J55RPah68fb3rVwcG9r+YhLQdjGkHK8wr2B?=
 =?us-ascii?Q?+FrpEThWSHdwNpcMmYQIJJ62as74/iZwaBk14Ytc+OY/POCXAAiz/9rfhqT4?=
 =?us-ascii?Q?dyHZQzmBkTzIQSX9GWAlzyWHw2ArJqmN+FaASzGGFw5Dt+kLRcd/XEgsm8/1?=
 =?us-ascii?Q?WdisS0CBuhbfs1V+3qlRFvFi83IK0tk2B61wNRE2+5TRBscEp1sn9q5KCHX4?=
 =?us-ascii?Q?1kd9ofUeE2QOfwG6Yj3chgtW/28RoajLTRMjvAjfJZL/uc6AHr2ylk8oEVyN?=
 =?us-ascii?Q?XZ8oye1vECo+CG2xvAqfgD+Cv7ZEnOPR21J2ARZG3UptALpDSKZLNhpP3PCm?=
 =?us-ascii?Q?TgNoq9roca1tmjsQJuAKvgwKVNqTsxglatTWW6y4NznyROuwF86GK1/yJTQK?=
 =?us-ascii?Q?IjOEFxTlCf5GvBWDjST8NRFzpOPASzKqMzlt0qqL8PVQcQI3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baba877-bc88-47d4-18aa-08de9403a1ac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:45.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1F7UCotypP0df5B0yCG3eTRukAwg0x1MBHFrvFcnXcjHiADHp7Y2zLiRaARzXPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10030-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: D02DF3A5C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko points out that mlx4_srq_alloc() was not undone during error
unwind, add the missing call to mlx4_srq_free().

Cc: stable@vger.kernel.org
Fixes: 225c7b1feef1 ("IB/mlx4: Add a driver Mellanox ConnectX InfiniBand adapters")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=8
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/srq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 5b23e5f8b84aca..767840736d583b 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -194,13 +194,15 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	if (udata)
 		if (ib_copy_to_udata(udata, &srq->msrq.srqn, sizeof (__u32))) {
 			err = -EFAULT;
-			goto err_wrid;
+			goto err_srq;
 		}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
 
 	return 0;
 
+err_srq:
+	mlx4_srq_free(dev->dev, &srq->msrq);
 err_wrid:
 	if (udata)
 		mlx4_ib_db_unmap_user(ucontext, &srq->db);
-- 
2.43.0


