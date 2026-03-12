Return-Path: <linux-hyperv+bounces-9332-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF9IBeQHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9332-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC126BA0B
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF8B63077E6E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29032FA3D;
	Thu, 12 Mar 2026 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nlCq8SPT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA7330B0B;
	Thu, 12 Mar 2026 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275077; cv=fail; b=RdoNSQ7+zSZ7O21UvsatHnTWllFaZk7hfm+QxH/K6k7hJbRKuN39lVPWHxNU7E0GCDRXHw2/lsFCedKjo3oRwlFQQRj47AWQyNMFrmMK6QVXWNghEi9bVq92qKbGpvzEYFKFs0LlPh0IBrAeAohuUIWrdNXY9bszFbq9l5MSJcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275077; c=relaxed/simple;
	bh=HAV7SXssytBgN/MrYh9C9PTJrZnOQrQ66RoVqEWkvSE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hJdbTmZg0FASF7ZU6DCinJXUrAAl1UGesl65uKP91IIuWspIOypbDZbMvD1O/vhPk5ayg/7YI+lVRCf6D7FnNPzC8CEChveQqXS6IMR3A7crPSzzfS45gijdD+10aml5CoqDZ5h3SUDepM/ywZCH9Deu+HUG8hJyGtDbpsTO64o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nlCq8SPT; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlzbkH8nTX4239lgMimGL2aT09Z8s/69GHmwKRagaRGD5vsMML+8b/ktjQCtvLYBD1aIMsil3k8lbILR0oDoZbsxAJAtX35elOdLeylfJQf9LgEidbzjSqiWP5jmUxUGHAyTM6JbO76QBhEcOtPimcBiwNUKeDuXTkFnOPgf5TPz9uxTjQ1/bPgufXE6C9ywX3as1OTc+rKgTveCAQpLaVGaRg9XRO6GwRbCmNno/T7rEW7UTOPKwPzIY8aPCp7I997v4xtJimsRC51HmIWAZbAwnn9TMmIyqZsM0huPr6Qj4fpX7GU3BVraV1+F2SdI/vfVbZNYzAHFnK1edjKNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXoDk7ficNZp2f8T4KPNP5g7xD7KvJy5LiuW4kLEg+g=;
 b=eE0SXPlqriMGheXbPVBE5s4e8Nm5Om52u0EyHqs1nLHE8LuUX25w5VxtLS/KxeAyrQ1KlgzkGpvZs4QPiHkaRN8NjC2SSJEZ2kKmwnu13S8n69QHjojW86PDBhh3/An5luxiP1GvVx7SUjOw3NW0O+RNyp7jJnv8U0dGEWmSDp2ytbAsbKs5jSrCXwwtk6YEKfSD+FufExLPznjEIdJD4dl9136ApLpSdR6tunNZSMkrRm16Kw9EGRDXZIIIOM0LaQ8SV7DSlVeMHqawXFEWTmhSINVwWB/UqLr0NPUQHhBSiPV6BQQaJ6Igx9VK50GimiRHY0UgeYmH5k/ZKMxDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXoDk7ficNZp2f8T4KPNP5g7xD7KvJy5LiuW4kLEg+g=;
 b=nlCq8SPTKxJKRalWj+R4FMpOa6OyJF1AzTKg/SjL6KTZmFM1HZGGw7i0n7oeaPWBdP/5lOtSZ/yLmuhuyOki3NT5Cka7e/c6hknvcdE5ZcNWj8K9j8qWLsClQnGF0oTcANmquQqONLhubmKNb4pGmdhQm9GMSW7mdtl7gAtumOLLvGJgTIkP9sEKz+P5s2lk/0UIEqxCIdxhhCU8qqGOaM2dBQzyFUK3FGf5myYB5Nb7TK9b648sV36snj2jG406qDkLSYrviyyz3PfIItSsVugLt3ZkwzeYmzo3ZNfE8QlMCVLzJTmgkDxtA9zNybPHKnScR8ZVMOgWD+rOrDraTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 00:24:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
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
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 00/16] Update drivers to use ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:07 -0300
Message-ID: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:208:32e::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d803633-39bd-4f6e-fea5-08de7fcdb705
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zg0Wei8nYYV+nFmrOIFEXcASKFkulVnkhhzeTdfbdvbvHXbQUtPx+sow/we88V3aoJWY4kCuv+AfXOl/cxyUZsiTrxxhy1GuE0s49rURp6pcJpuXc2NtoeNzCz9TkvvGhtQbndvKe4sWnPC1KssQQmRfKtObYX81AZeBiNTU7nmwb7FKFuKvZobwUb0u4pWpMo0YhZrzg9ppBZ4fchSVORmcAI8BiR3hlCphTTRDoKfGwHWpwrWw5wVyWO7fHO7N12ZnIzvGcqMqm+5q8fsg9VorY6mrYOmzb0X2DJzWqzGkCm+6d2Tv8p3f0/p5B5xNuf/CsGJG6o4c9cj+jv6aNjwkMRVb7r5XPVY8idsz9k/D4EwmfDqil3pHHB0uH8fPCC+LSkdJKHyb9vvh34qgiQhtuPNBLLeJm9Pfo70qAZOt9XMRT4ISloiIVIOLEf2haUbBO9RO3BEXzKvjjHKBBrsiQNVV41vohJuAszJP9cIw2GsRhWh9VNyuIXKrtejOVxQnAgRUmWFOYqQHZQ01Wro4xPNIX42ki/lG+PIRNwgLLK5ycg82pHW7jIvLPvnUnHNs2uN0PKrwpsBA3xDNK53UEV6bxkoiM+PSdaLj7p9RIIYrK7ZdqZnFJqUf7YokcfVn4yyn9BzyQBAdyYXz9NjNey2BDskAJpkiCY5hkZbbolwGEcghjg5mX5pCi6wsxbJufm8guE47Y92rkyeeY0yST34wYXqIYYL8rQmodtCQUk9dTLoylTfVMfQsSdu6jYSZQbPC+l8glnOolIpdEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0spuu5P9Bt1F4wFGJVEj1NzQHv8GkIEEDGgvZTz2jYFZgvtaz6z2tB9I0QQ5?=
 =?us-ascii?Q?0lLUXHKekF+G7ouuJni4llrFaSwV//4USmYLmaXrXK8imNyxG2sIiW4nH+VZ?=
 =?us-ascii?Q?Gw9a/OkJ8etM2ykgAc8dGIhl8dhv/hKsi0HqfYSSNZPuEUmuwmuzG0WCh8TS?=
 =?us-ascii?Q?9dOpx+xOL763ic1EHRhxSNTO0QztgciWqo868xokUlCi4DA0wzj0XGT2lWln?=
 =?us-ascii?Q?IqLTNbdhuKdhD5MWV47ORViE9r/PreoLDOaOaruIzJR9v4c/KkzNd2FY01T+?=
 =?us-ascii?Q?T8+l0PqwZgwWBOl47LHhSR7ZezDuSls44vmLzQMafCjn3oDvLUq0sZy+HQc1?=
 =?us-ascii?Q?ON8ad58Vd9Nq8EedyCU4mJt2F8/sD372VOdS/SQVS5pKKTaIQvPYXD+PEcO1?=
 =?us-ascii?Q?RSOVHDEjhn8hEQPyA2ZQlGahR/GgX4bMSufFawq/nGuwnz4uMkxCQEU4Pf5k?=
 =?us-ascii?Q?9pkEWEERGI9phiDz488PxRWlQT+WxeSwLrooOWe0oKgvkhv8pocEPOsz5NXc?=
 =?us-ascii?Q?TDgtvXqNOA+K+D4HDKXpzRU3xgeDBgJtrkVazqjkSOJTssDpksxfKIDsfCga?=
 =?us-ascii?Q?zsir6r6w0nZe3bYY1g8bOuSGTkV+nRVyvYvHHB2onesog7OtK3/hKN7wM3/a?=
 =?us-ascii?Q?ZHFjrkt+hZSVm+Zs2PTf62WwG5awFygCogbaKdh17JUFCaUkRHy5HHo4rljs?=
 =?us-ascii?Q?RELrWPXGXUn0f/vlUBHNrmB//iWVNh71C3fE5wuTZFFGIevXbXOCoiEtxBVR?=
 =?us-ascii?Q?PS3vLx1ekvSc3zxRVHmxI/fgowyEJKx0ZAPise440f8s2O+syoevj2G/5+uV?=
 =?us-ascii?Q?Uk/bdTw17uw26JbvMJW8xEsyHfjKdaVv6u/hHj5QVHvNeZfCjJXtKvXyPAvN?=
 =?us-ascii?Q?BWYmbYGBjrvakx16IeGIxQCu7FVyA+B7TX1luiVkK1NXMHavLQgiYcSItCXO?=
 =?us-ascii?Q?vjGytqLCo2f83DYN0gQPFtVlXoXg0mSUZ4ltQjrPi7/Oj6GE91v9x0z2PGHP?=
 =?us-ascii?Q?NdreXKvMnK4o/zmoYvin9lmIIP2vuluDCg7F96kRRKSEezFxMqPmbkKSgEH3?=
 =?us-ascii?Q?awHIvLCM6o7pkEogVmVj/tNMRkeYhwjVOhwGJROIkcLMHumbVjtf5B4GvSgv?=
 =?us-ascii?Q?Ca8LFzpILS+czM3erR0I4XlsYjnAO+XQn8jYpr07HS+qcS016P2jYp7N8q1q?=
 =?us-ascii?Q?89nJaPkXgDYPQjFqyl5m+cPy7Pv6sMeoTEpsXmZXLx4GFRfpR7R63oUmkv96?=
 =?us-ascii?Q?KFZS39dPthxVJURtmUX8U9dji20v1MuTPsGkmGDCs72NdOD0fqOMh237V8b8?=
 =?us-ascii?Q?I48GCUZcepVVTdT3knsje9RJrvajTn6nAcYWhadd9VCPjtdN/0exIEWrPW2a?=
 =?us-ascii?Q?3CYuQvJODvISl7NOyuKtbqd7WzO7UHCqcmVKl3qFbFBLkLyCMd3MESvIPEkQ?=
 =?us-ascii?Q?CACx4OuYQlFpndsYyqoifECLi/mDyBwfXbr3atBpeVZDp23MUJwX2y3M6he+?=
 =?us-ascii?Q?EXTHVoWblNEFw5Rov1gqM1rUIoD2zirFxrmMe4aCI+nlJ0znSA5wQhmzKEoM?=
 =?us-ascii?Q?Se430zfMT1R3hZmyE1/r3kRypk5pKB5U8nZ5qItgrOlV5EeUpona95sxx+OY?=
 =?us-ascii?Q?IUUJdKYGKc6FzehfWOXi5m6/nkJuJWSTqpP9YSpMwavj2nV63wVcOa8ktQjM?=
 =?us-ascii?Q?uVS7oP52TouoC99/LWVCy+W7RN/YAYrChSgk+GFIknPYkdik2fhazRCUD8og?=
 =?us-ascii?Q?OeV4cccz0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d803633-39bd-4f6e-fea5-08de7fcdb705
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:25.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKeDQJMOra90zhQehC5PPlymCDoJF6e7OPSsgsoELLy0yqkcTM1AA/528h65Msxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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
	TAGGED_FROM(0.00)[bounces-9332-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,nvidia.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 9BFC126BA0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Progress the uAPI work by shifting nearly all drivers to use
ib_copy_validate_udata_in() and its variations.

These helpers are easier to use and enforce a tighter uAPI protocol
for the udata.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (16):
  RDMA: Consolidate patterns with offsetofend() to
    ib_copy_validate_udata_in()
  RDMA: Consolidate patterns with offsetof() to
    ib_copy_validate_udata_in()
  RDMA: Consolidate patterns with sizeof() to
    ib_copy_validate_udata_in()
  RDMA: Use ib_copy_validate_udata_in() for implicit full structs
  RDMA/pvrdma: Use ib_copy_validate_udata_in() for srq
  RDMA/mlx5: Use ib_copy_validate_udata_in()
  RDMA/mlx4: Use ib_copy_validate_udata_in()
  RDMA/mlx4: Use ib_copy_validate_udata_in() for QP
  RDMA/hns: Use ib_copy_validate_udata_in()
  RDMA/efa: Use ib_copy_validate_udata_in_cm()
  RDMA: Use ib_copy_validate_udata_in_cm() for zero comp_mask
  RDMA/mlx5: Pull comp_mask validation into
    ib_copy_validate_udata_in_cm()
  RDMA/hns: Add missing comp_mask check in create_qp
  RDMA/irdma: Add missing comp_mask check in alloc_ucontext
  RDMA: Remove redundant = {} for udata req structs
  RDMA/hns: Remove the duplicate calls to ib_copy_validate_udata_in()

 drivers/infiniband/hw/efa/efa_verbs.c         | 69 ++++------------
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       | 16 +---
 drivers/infiniband/hw/hns/hns_roce_main.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c       | 10 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c      | 54 ++++--------
 .../infiniband/hw/ionic/ionic_controlpath.c   |  6 +-
 drivers/infiniband/hw/irdma/verbs.c           | 12 +--
 drivers/infiniband/hw/mana/cq.c               | 11 +--
 drivers/infiniband/hw/mana/qp.c               | 29 +++----
 drivers/infiniband/hw/mana/wq.c               | 12 +--
 drivers/infiniband/hw/mlx4/cq.c               | 10 +--
 drivers/infiniband/hw/mlx4/main.c             |  9 +-
 drivers/infiniband/hw/mlx4/qp.c               | 82 ++++---------------
 drivers/infiniband/hw/mlx4/srq.c              |  5 +-
 drivers/infiniband/hw/mlx5/cq.c               | 14 ++--
 drivers/infiniband/hw/mlx5/main.c             |  2 +-
 drivers/infiniband/hw/mlx5/mr.c               | 11 +--
 drivers/infiniband/hw/mlx5/qp.c               | 66 ++++-----------
 drivers/infiniband/hw/mlx5/srq.c              | 17 +---
 drivers/infiniband/hw/mthca/mthca_provider.c  | 27 +++---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 14 ++--
 drivers/infiniband/hw/qedr/verbs.c            | 42 ++++------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 13 +--
 drivers/infiniband/sw/siw/siw_verbs.c         |  6 +-
 29 files changed, 176 insertions(+), 392 deletions(-)


base-commit: eb15cffa15201bd53d1ac296645aa2bc5f726841
-- 
2.43.0


