Return-Path: <linux-hyperv+bounces-10762-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF9pJtBvAmrkswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10762-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F8517BE2
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B978301FFA5
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3906541754;
	Tue, 12 May 2026 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QdUMzK5n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FA42AA9;
	Tue, 12 May 2026 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544588; cv=fail; b=VS6Q5VcRl8hQePJNm02OQgRI+uOEL4xjQ7POmXE+lGemFj27DzDKi9icDXVNMajZzJomC8mXaSqmSTfjFpWMvrydem1VFkUR5TK2eLup/8HbkGU4odkBkWd1ZM64VnJ+q0aBM4OzbjvJrPCUTrn6FpANLSdOw8L+Mgr0LoBGVqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544588; c=relaxed/simple;
	bh=KUK6miW+P1jp3Snt9uoQMmDyLMjStrxXDupjS08bSrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWwiwJiufgTOWyPzUfsHh16vxfdnxhJ41Gb7I24wEPWavHC+Tlgp68j84MXriqJD1ga/8+jdGOsgPEyhtpobcazE9TgR/vO+ZDrCkdaOGSgvA4MswCfmJ0GsP1TrctU+p+IPWhO0xvAWOPpyyGSPyEAJwk2oQQlkJxmHOY+6+zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QdUMzK5n; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQdKEK6/OVLIWU+2Y3kxgLeM9pMn4gOBHfUHNIAmJ9UNLf4J34n6R6dVFqgn4OzWLnUfCt6gO7kPCdl6RcZWkparg4grdAoMKu+8GNS0hClRn+LNKnruxl638EGspg+LSICbkx0zmBE44seEwgvlSHWkE1/hDvYkzcLwva8cs2iZpROR1uRNEeLiIDwalPeFRKDVLncaZbHdEPtolfghKol1N0iChtdz0sdfOuAYRi/emwKue5hM5pVyjIvyzPKf0mCyjMHkukxA6LBg3YJiD0Nvg+r6nHXFo22hlOnN7HpD1ClI4LnCig/EKR4BmCJXadVoO1wCPvX5xXZIQiC2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJDOgXGNZtGuJKM9F4NFTTM2BDRL3pOricT3AYq4w1c=;
 b=Amag7GTzDPmKJUhGpq6guJZok2J3lGEK7I1NOYzZwQ/NdjnQJ6L+ywc1H5cx+9DWl9YAw1f3dfwuT0DDgLcro0sQuO2p5jZZsoWBlwuAeLT4glnq2+axwdiYQya2l5TIkzLiz5xAexWCT9jEZvze1gGI3W8Sf7nVKWZdVAx52nSeLSXs4r/KpkR/TEW9RiRHvphktg5VF8GccFvYYMJIm+cJlxAwk/u1heRkZoRx3R4ogUi6k2pKhimF0NGcMgvEGiNa1a9X4Li42o4IWGKbRp3ReuEWEuV5p/tbmM4D0ST0yd07gCzil1kPcv/teKRHYdDqoGoam/o2C9c2XLmGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJDOgXGNZtGuJKM9F4NFTTM2BDRL3pOricT3AYq4w1c=;
 b=QdUMzK5nyrqdFICkVcHrL/WWC8XXOv3tCvjbnr7bc5Pg7pjl2hpYeuBdns+S34Hoy3rJmvxLPu8GcvAdGTAa/FFmlud4SGMxnz1uDMTXCDgw3oGo4mufWxJpJ2HGrtjDTwXaKI+UVbPnROL7m7I13Df3HMlHKNSabmdi4SAOB7eFiZ3RV+ASTxn1Pr9+OrJXitywUMgwn9UAdNwcuv1JxvOfs4HQmlbNvI2LU+o0cy2JfuzCXuDDTLO+EnHYwoSvkDuimRMSr9kEx28jQv7fNSUXV/7c6LLntUjQVALlZt+84yBoJ9DfyD46WyNkh41ZOUSGfYy6yAbhEP8kISwJBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:41 +0000
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
Subject: [PATCH v3 07/10] RDMA/mlx: Replace response_len with ib_respond_udata()
Date: Mon, 11 May 2026 21:09:36 -0300
Message-ID: <7-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3800abb4-e660-4b96-6801-08deafbac359
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	0g+YNrJKbP6ikNbaF9mKRThVwjCIa/9GRQqtZEMqKQ5kz4J0n/LC415cEE6giE4/zfPBj+DZscG9RhmugGv92r6yYEzhQaXALfKDz8KzYNffVmGCpxY7WgMuM9NWII2gvPP9Nn94LZP9dMk6F0DcQp3dLIBtk5giN99ddA2EIWT6AKDGozPHwIZRbMgvHgqgBUX6doZ7bu3YuZa6IteET6J4r8EsBzKZ1TSTxUtz8ox8+2w1u8Bn/2ncFQdseh/nzv777hec5xIyGhyip0VfU+dheQ0FYWdqEUViFT4scFJPh2GIUH8/YSF3T8rJiizfoJiqAHYzk8n4AE6qaWChJFL51WPxzIdqXaIMFDaqj2UH0UjzVUhRX4NQjgveaKIKgm9BIBtyYHt/pjKSSMhpjqCPwpX0pUMRyQw0cHeWDsCPND/oQL6pudCMW6lRs/O7hc8pOR9LveCiP7VEbkkHGq2jzeKqyUFKune0Zte03mxtKKvyrNoooMNGWyajCi5ZmMHwxnUT1aPaAh0UPZ21HZ9gKAE8Y93lmLnc7BWX9y7nbuJ8q6JFwOGmKBTlaaq493vRamofGJOs7vb0+tc0GEjWctPeLAei+VGvCzqn8V8nnOKesrOUPRp6aru9s87MLnabYRS5aUcm7kJe0Dagmxct0R2IYUZEeESsAji2jWM+/zSok5Wj/Alavwl8VlME6d6tPX930XnM61b+HxAIpg8omPumcvQ+3VeRc1twBe4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bH+yvRZTJyeqBkZcxNRFz/CianuqhVSLb9fwHrrMDELEsLn8zvXcwlY/t3CM?=
 =?us-ascii?Q?pUU2ndjYlfDzLNZihh7Bp/h/jFHretQgf0WCtlSHYBJ1ylLjQ5QKudxid/o1?=
 =?us-ascii?Q?1Tr8QiU6895Tbqr9pMHBS/j4ooYdTl3VxxzoD6njqvFiLsob8ybOQA9Z6WWf?=
 =?us-ascii?Q?mTy2hkQR7svF6BvgKdPWRpowjmy4DodlUUi/g/ZeGuwqgn8TM+jZH+/dCFZ+?=
 =?us-ascii?Q?+txzQ5y20T/2D13+DnY/eQdLkVFQiIOzwEaY54uCuZIq6y1SGLd2TYmpuMI8?=
 =?us-ascii?Q?eo1lhgAM73oKk0lyLPh0cq3Hrqv4PTL++E4Q3JAIVwQYRfAW8rXwKG8bMM+4?=
 =?us-ascii?Q?Z+VOsa0XduPjQYvbfWNixe6+XTe9JpWuDDvGfBq3X9XVCiZDWvu15xpm96Op?=
 =?us-ascii?Q?L5/ndzDANHds9j1CICyzcN+MNWMiSrtNQ16fqNwZI0D+iIqkSKapXk7IFsyF?=
 =?us-ascii?Q?MGTYXhY3M8Pc1QTgczW3llesexuxpwR+UAvi93uSQ2/Pvx62SLOv1o+E6Ioz?=
 =?us-ascii?Q?4/qRXw26AI61mJDo43Uuu5Lp6/eO4rjZBWQzdpfZeI3JHmeS+WN+DTxBgAH7?=
 =?us-ascii?Q?ZyBM1Rev6wPy5ZUGL1RrJxbDQc0kOK5pKfCL3EiMtb/6oh4IEOg0OxxMRNpB?=
 =?us-ascii?Q?EkLEQiSZiYvlYO/abmL7abo/tG1IpPY60lIDEwXod7CbtVyeEdq6WT8O5f6f?=
 =?us-ascii?Q?XK3PpPI9r8h0DprYBMaxJZz+SudrRA33WI6T1Op1u0ZjiJKsUCdVB3kZAvqy?=
 =?us-ascii?Q?udees4itt2KlKoWhFxLe2+To9xMqW73+E8zp2eIF4W7dYr5UnV6WJSDPjDL1?=
 =?us-ascii?Q?e1gnD1aYBSQH15GIDKworVjwNs1vHK+lDriPiR84lUjLpPurpYU9NcrCWO98?=
 =?us-ascii?Q?L+0PwpOmB0LkIN2JTU6Nk3T2THQDTsvREv9yARxGHPsNQr8k1Mhdi5M7Rn9n?=
 =?us-ascii?Q?CXA1vf040y8957XgDnvQdIaff0+7RarlALdsCtT/j82MU3YXmWb+NDe4cnI6?=
 =?us-ascii?Q?DOZuStySe2Drdfwb0eESnzgr2+vbV7ocr+Mww2uEy3eb0GOr5NhN8bsL/eOk?=
 =?us-ascii?Q?N1a6OpVVIUEdc1OrQeaDEuy3k9wM5BxtrMy1VAiG72Lsu4WSbzsH8aWfqhKH?=
 =?us-ascii?Q?sR+1jF+oBwifldZaWe5CTlRV+E2eQGnu3zzVl4+wYTzFRk9o1gAplIKovF4J?=
 =?us-ascii?Q?ON/0UzWqS7cZrfAWmfhf+wp69Umu7uT9l67iOlvAYrxvbhJmggY83SBTwLyi?=
 =?us-ascii?Q?oxb3PmP1HqnH2m6L6Da0SyEwidrbxARQXXpM3yiZQTBlVZT6TJr8ZK0sKncY?=
 =?us-ascii?Q?+oSsh+euEmBusr5uYBR4oEHumR5xPXOCuw+90TJij3RTuxWSleFoz2Myzh7A?=
 =?us-ascii?Q?xsEGjMUJLwfkV3c4dlpA/y01VHCSxpxwAh69PzAGjLACzJL5pM280vDkyvwU?=
 =?us-ascii?Q?br+mrwdFmO2RcuUf5SJN0y+SwBpvpFo6Zu0T2WK0o7eNuHzxUp2Il3KQG0/7?=
 =?us-ascii?Q?zJQTFrTgcMGkIlajZR2y+QvHcZCuDB/qQveVLQ/oO3r5E45Esyow9gKDrpeW?=
 =?us-ascii?Q?UhNr4rrg3zWSHuq5dToxwvRihHCQ99uYVR0OVcgS6qPGgmVX8c169NKXP0dF?=
 =?us-ascii?Q?CEPtK7KMCtAOHM/P+JC4JjKQ028dqBiwqu2qqA3FpfDL5ebUwlAaAaFy0d5q?=
 =?us-ascii?Q?z6wgx+ZNlrwnBIh1JLGKcW6t2GjQJvhtlggBkilFKq6e+USm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3800abb4-e660-4b96-6801-08deafbac359
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:41.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjD+ozbdOz9l6kGtkbOgxE9VZmS2xWF12fHCAKcAtSi/5gc2WgUufBPuhn1tHPHN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: 009F8517BE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10762-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The Mellanox drivers have a pattern where they compute the response
length they think they need based on what the user asked for, then
blindly write that ignoring the provided size limit on the response
structure.

Drop this and just use ib_respond_udata() which caps the response
struct to the user's memory, which is fine for what mlx5 is doing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/main.c |  2 +-
 drivers/infiniband/hw/mlx4/qp.c   |  2 +-
 drivers/infiniband/hw/mlx5/ah.c   |  2 +-
 drivers/infiniband/hw/mlx5/main.c |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c   |  2 +-
 drivers/infiniband/hw/mlx5/qp.c   | 10 +++++-----
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index ce77e893065c92..4b187ec9e01738 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -626,7 +626,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	}
 
 	if (uhw->outlen) {
-		err = ib_copy_to_udata(uhw, &resp, resp.response_length);
+		err = ib_respond_udata(uhw, resp);
 		if (err)
 			goto out;
 	}
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index aca8a985ce33cd..8dc4196218bf05 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4331,7 +4331,7 @@ int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table,
 	if (udata->outlen) {
 		resp.response_length = offsetof(typeof(resp), response_length) +
 					sizeof(resp.response_length);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 	}
 
 	return err;
diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 531a57f9ee7e8b..a3aa700d08355d 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -121,7 +121,7 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		resp.response_length = min_resp_len;
 
 		memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			return err;
 	}
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0b3eda9b0ad0c4..fb9689e453bce4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1356,7 +1356,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	}
 
 	if (uhw_outlen) {
-		err = ib_copy_to_udata(uhw, &resp, resp.response_length);
+		err = ib_respond_udata(uhw, resp);
 
 		if (err)
 			return err;
@@ -2281,7 +2281,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		goto out_mdev;
 
 	resp.response_length = min(udata->outlen, sizeof(resp));
-	err = ib_copy_to_udata(udata, &resp, resp.response_length);
+	err = ib_respond_udata(udata, resp);
 	if (err)
 		goto out_mdev;
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3b6da45061a552..d7d8f3ae8b647a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1809,7 +1809,7 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	resp.response_length =
 		min(offsetofend(typeof(resp), response_length), udata->outlen);
 	if (resp.response_length) {
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto free_mkey;
 	}
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 23abea36cf71cf..6859e8ba2732ac 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3332,7 +3332,7 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		 * including MLX5_IB_QPT_DCT, which doesn't need it.
 		 * In that case, resp will be filled with zeros.
 		 */
-		err = ib_copy_to_udata(udata, &params.resp, params.outlen);
+		err = ib_respond_udata(udata, params.resp);
 	if (err)
 		goto destroy_qp;
 
@@ -4631,7 +4631,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		resp.dctn = qp->dct.mdct.mqp.qpn;
 		if (MLX5_CAP_GEN(dev->mdev, ece_support))
 			resp.ece_options = MLX5_GET(create_dct_out, out, ece);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err) {
 			mlx5_core_destroy_dct(dev, &qp->dct.mdct);
 			return err;
@@ -4790,7 +4790,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (!err && resp.response_length &&
 	    udata->outlen >= resp.response_length)
 		/* Return -EFAULT to the user and expect him to destroy QP. */
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 
 out:
 	mutex_unlock(&qp->mutex);
@@ -5490,7 +5490,7 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	if (udata->outlen) {
 		resp.response_length = offsetofend(
 			struct mlx5_ib_create_wq_resp, response_length);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto err_copy;
 	}
@@ -5581,7 +5581,7 @@ int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
 		resp.response_length =
 			offsetofend(struct mlx5_ib_create_rwq_ind_tbl_resp,
 				    response_length);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto err_copy;
 	}
-- 
2.43.0


