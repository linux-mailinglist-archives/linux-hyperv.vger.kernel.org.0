Return-Path: <linux-hyperv+bounces-10771-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OiEKPVvAmrkswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10771-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888A517C6B
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 051D33038AE1
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B73495E5;
	Tue, 12 May 2026 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5I1GiYg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88116DEB1;
	Tue, 12 May 2026 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544597; cv=fail; b=cpk+M3uLU6Kw9Cl0r459Wl79uo2aBKFOI9YX3wEbG4wn+1tVqXiaTdH8yYE2VwY6SzGB7F2gWt7tXw1hqieUsen/X0F5smm0jyYFd6Rx/smlXbD+1Gg/+LA5jnyGd0j45NMH+3YR7VQ9AgW4a4xDJQ6v9pe7hsbDeAJQTTdFkMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544597; c=relaxed/simple;
	bh=bBaStPK5XBV+rwBGCT4frs31RQmNQUmGhJ9KVYlm2RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYJKodNeA8jbscaMX3AXmuH3She+AIV10p9LccTyBy0NIbH4FSKaDtV9YCQAVuyQYmJbbEnZfzZDts8TqQtkXHLO0vDlstoXmTDEIO4Dm1A1oveKn9hRxc2LWYxFfQJRdbYy1ZX93m6x/KO9p1Dej9jchqsrcWnYepLiwAcHj/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5I1GiYg; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cne9BnitgYSBoGkTv0pcxy+jjpiTXpQdKpSSJVhqGX09ZK3cthk1YBZI56HGic9WeVg23vyJ0EW4iIHCphyOKbUKqK0YTGuZIE+l0glmZ2oYNauoSZ0NepR0uIqPEdYszZ9Zf3Kau0BG9fCeG7AxlngRCgPsdwjkmFwpgwATTslV/GNm/z50GCuhBP6LrERLJVWyyvPTPustFA+KocFZ6CzRB+RpIiLGc122MCtq9hxE2sOWB0pkLt/GRCR2lmUqvR/IHGuv0azoBPFrUSuhFlzQ3Pb5iSLg5RMvFuL4nQQqyUnc3j4uc6p8lk1/hiSWsa5B22sv85rI1XUgPgPSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ9zV6xQ7/qWtt8kb3g5TjtAzl9iuFscVqdlvdIT1GU=;
 b=ur8v5g7USPx90GQf2rY38RINT03unPZ/zUIq1IwjPoXY0HQ1SMhVeMiB3V2x3/DrsPCPq7XQMolGW1seW7zvUZ33Tdxkn3Ku0IpEUpvb5HsvfG1y3qibXQb6DNBVIy6Ao2kmB55+F0k4Lpcnv40CjrQQFPKQST9ccIc6gHI2Lx3iU9RNc2Fmw7kVn4P3Eb9iOHKWg3l0pnL26riapKrWWLsKLK2ODnPpGocC26fpHMWG1tlCc0WHloGzwv3tiwTMpNgQtpwapMU1foBTnP7kCCjLFCvEC6EQy2KzuRpZ8s1S+TAL7DzPfyBxr4RDRE0VHgjGD/5gLCY7oOi8Yzuhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ9zV6xQ7/qWtt8kb3g5TjtAzl9iuFscVqdlvdIT1GU=;
 b=W5I1GiYgDseoMHd84LtF0AHOLObSVcgoN8cZoELVXjxOZGoNTqGa8IQ0FlfLbwT3gLdmhMrubT2tudo+mkJektfZ0xWZIloN7m+jC1+egz6u2FqdUS2fNyi+kOzWssfD4PdUdl9RbloaNXzHx6v2gWkMOsjx0zX2r4GdABZTg0PK0ka7GWQifDs77edkWsGbM/Qa9gq9iioQnGV2yCgoNQC5ODBo9USz+i/eQN6EyzMFd+trMPYs22YGw1O48t8DqavnXRHY70rHVES+GOGc0+cunOR93Thuvr/DeS0grI13rKKONwJkt24YrXaCoOSe7hE1BG02ZDrLczPw/O5BzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:44 +0000
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
Subject: [PATCH v3 04/10] RDMA: Convert drivers using sizeof() to ib_respond_udata()
Date: Mon, 11 May 2026 21:09:33 -0300
Message-ID: <4-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4a6240-5932-4de3-e8b3-08deafbac430
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	gszHII2eoyizNos/l0mi4/AbZwNoLz2QZ20FY5bzpsDbpVYKEhxG4N0Y4bTnXvzOl31PnGlUOYRykdPjy5mRHDEAEy8R9NBd6N3xGwNRCK3YZMH2g8Asa9fjNiVFCVFyZQ4LdaFZ24rc6AascfTlFKfLhDmQZ+GBfPZm2NSe0hcoeIoq8LMxndkkH47ykLHAB1YtoQ38qGCh+EvKOtxD4jxqqRaejSV7IlaJAl2p/srw1fftoi5CK0/fa1xpyJnqdtAJZoUS7+KvfR9i0yTEStMUBB9YFdgqVurnGosX/WFVfLHqYPveFomO+lCmq3eoiWd06lyqeIz4tjSN/5n7bAxEzB5hKkjSQLR7b/RogdtiH9Qk2Zt+KMNhPLf3v+7Awl0G0Ngn6mgP8GaWHxFJqUkVPqzXTPwkZeRP2SEtJkXsBiggDj5cv1MM8ayzyF/qL35RO4MCTp/nt8XSNorYkD/QomYmFIAZk0JaPuWcG6o0IVOdGLK9vd9iFqY8bTkRi1JaxllIAoKlqVlX72V0bjBnYufNIedk88bMM32QHWhNkqATEdVVGkn5+FW2nBWvnSLi4Gy5yvnv8Kaa5elV1yzJpXtHsDs9jQTnvXUXFGwtU8oR1KVdSzLbDASZBs+7wiGQR7h1smUYilfctlXux/PghejGn/VO30cOIoW6zEcEyZmrzw3WuM9IsNct/AVrCo1PaDxf6CX6ay3vItWm0/NAuwnOqQWfiDxKwGmpdoA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOxa/ZFsdOIS2gGcLp4HmqrdL/JWXmLjUPx8sOQD+kzE60o4vns5YTcefaqS?=
 =?us-ascii?Q?e015HbDbqSt00l7pGyOagHanImnaUGfoUyuo2bxNiE4mFu2TbC4X+BWyAFGX?=
 =?us-ascii?Q?OOzePh5IGuR3IQ3fRwWsK+eMfIQ+u1UAipTNbtd39yekp5kD5jKcRg26Xi9M?=
 =?us-ascii?Q?LIPbVsWAGSTmn6gG8rfCFyOuMxIdWUXGtS26e/UGvZ7sy86uVx+DtVgGpovM?=
 =?us-ascii?Q?BRZJprut1D97POk2MKimCWdJXdd6agIaItf9ESX4nYQU9dgcGlKCktctnsNU?=
 =?us-ascii?Q?/q5a5U23EluFnBhox7ZnTHnejIVaX3wc/ZRCd1HZE6VDgR6rgSJosL0L8gR0?=
 =?us-ascii?Q?EPBvJKT92orECtoz4HTvZXvZ/aGreyh9NUeg/0/n23p8tUtZB6Ey7x8Q6+Q8?=
 =?us-ascii?Q?kRPaELEkojBUhIsRKyv1+OeCgMVcKoLzG5qr0ikCccu0CDs3WD6WlYk8CqW4?=
 =?us-ascii?Q?JxHuiDxo1F2wzHaAZP0LSOWmnxDyihbBCpxtZbRx9p3wEP6i9ZTay/CJVDFX?=
 =?us-ascii?Q?zPfBnODgIRGuIzDr3NXHHgUd8bXoVdQdPg1A2QrGXveXWuD348UDBT4bgnoy?=
 =?us-ascii?Q?De/W6GrbhMaJKyCu2G5EqsqSdT5CxKVHeGmdL0KyMod722Q31xGaSGPlz8//?=
 =?us-ascii?Q?WmdnMJeoVTaFhK/cjwe3M42Jq1vUmRJgmvIvwaWXxu3imF2kISNhm0f0jAl4?=
 =?us-ascii?Q?XYc4ySEq5zRBtw46JxojE5ne8AASoNHPZlOAHmdRWnVSHfQx9bDx1MUoRbys?=
 =?us-ascii?Q?3NXKG8179p3mFOIykLThf8QJONOeqpV5NAaILay2RG+kENPTpgtFvRiacWqa?=
 =?us-ascii?Q?UcNNcpbIzqis2/PMElfFxmCaeOvkj9ZEJ2PRP+kYtYwbqYM4fTKiA1rqFrEX?=
 =?us-ascii?Q?z7uMmldlGiG5BWc1XsNHXnRENpU2Xdm1V69bQfI5RYjBZSNIfzFH5Wy5PuIv?=
 =?us-ascii?Q?rBze4Q3dT7JztnS3s40TibJPapfSRmlnIJqkqvZMJprg1AryZzjwGa9jA79V?=
 =?us-ascii?Q?vSq0JRYIuhTZCaVjY0CDIlthc3QQaVPoSy9UjEqA4lCSdrvpXxvMF/LxorFP?=
 =?us-ascii?Q?/+lICFuePn5CtTxoWiV6xhTNabp0ulowXYz+eueXrvvjiMefJTaSIeTRMZjL?=
 =?us-ascii?Q?YB/VHO7aUyLQjVlYN73WZoLQOa35OZRUrhkFsqVA0x8dUlUOqklr0WbwZWZY?=
 =?us-ascii?Q?z+h3INKz/JKdzrKZt87sMzAE7+u25kzavb+bm1Pr4BM3xGUPqmFbmekEad7A?=
 =?us-ascii?Q?OTVS4bHMX8bLKavb3/Nc+iCgwELRHZF22F5cASzou+sp9ESr3vJFiK1WCOHm?=
 =?us-ascii?Q?oWXJ7LP0Y3HcUxUYVQ4JJUrFMzZFz4in/9LYmuoq5iORtXbLNckBI6YkzCzW?=
 =?us-ascii?Q?jSTvaZRoabAhqi92IgV2EgDTpo9E3IliIZCSuSz8xPLSYQeLt3WAVbGnWAso?=
 =?us-ascii?Q?D+/0Sx4mvYd7fHWtqBkScIYxgbbDcWki7w/zlnLsjmG3CKVyDtBVLAiFUT0g?=
 =?us-ascii?Q?gESnSDxdnLfWlCdLIbEHLUrYwcI9FjlDktRBYYMjgvX55G0f5QXO7hRn8MOh?=
 =?us-ascii?Q?Mq4XCMxD6uROwWzQt/Gojby6a5fgAY5H1O/ylz9x8628RAAavIzg49RAucKj?=
 =?us-ascii?Q?9GudeK/Yikh5rPOk0x5t1z/TqgiOp9fA6B3tWDuSL1EsdA23BYpZvJYj6kOF?=
 =?us-ascii?Q?TjBYk3WYW7yNb/E5llvY6qt0OWzYdK1Lp6q0X4OZYwWiMnMU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4a6240-5932-4de3-e8b3-08deafbac430
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:42.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3SxFljHV8b00uvgSltSCfncGDJ0JPrmkSrYsGryg+/NjmzcFj/y/ltK72MZXPC7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: 4888A517C6B
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
	TAGGED_FROM(0.00)[bounces-10771-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

Convert the pattern:

    ib_copy_to_udata(udata, &resp, sizeof(resp));

Using Coccinelle:

@@
identifier resp;
expression udata;
@@

- ib_copy_to_udata(udata, &resp, sizeof(resp))
+ ib_respond_udata(udata, resp)

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/provider.c        |  9 ++++++---
 drivers/infiniband/hw/cxgb4/qp.c              |  4 ++--
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  4 ++--
 .../infiniband/hw/ionic/ionic_controlpath.c   |  8 ++++----
 drivers/infiniband/hw/mana/qp.c               | 16 ++++------------
 drivers/infiniband/hw/mlx4/main.c             |  8 ++++----
 drivers/infiniband/hw/mlx5/main.c             |  5 +++--
 drivers/infiniband/hw/mthca/mthca_provider.c  |  5 +++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 19 +++++++------------
 drivers/infiniband/hw/qedr/verbs.c            |  7 +------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  9 ++-------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  7 +++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 +++---
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   | 11 +++++------
 drivers/infiniband/sw/rdmavt/cq.c             |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c             |  3 +--
 drivers/infiniband/sw/siw/siw_verbs.c         | 10 +++++-----
 17 files changed, 56 insertions(+), 77 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 616019ac1da501..a119e8793aef40 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -52,6 +52,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "iw_cxgb4.h"
 
@@ -209,8 +210,9 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	struct c4iw_pd *php = to_c4iw_pd(pd);
 	struct ib_device *ibdev = pd->device;
-	u32 pdid;
 	struct c4iw_dev *rhp;
+	u32 pdid;
+	int ret;
 
 	pr_debug("ibdev %p\n", ibdev);
 	rhp = (struct c4iw_dev *) ibdev;
@@ -223,9 +225,10 @@ static int c4iw_allocate_pd(struct ib_pd *pd, struct ib_udata *udata)
 	if (udata) {
 		struct c4iw_alloc_pd_resp uresp = {.pdid = php->pdid};
 
-		if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
+		ret = ib_respond_udata(udata, uresp);
+		if (ret) {
 			c4iw_deallocate_pd(&php->ibpd, udata);
-			return -EFAULT;
+			return ret;
 		}
 	}
 	mutex_lock(&rhp->rdev.stats.lock);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d9a86e4c546189..f9c7030ac6bfd0 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2280,7 +2280,7 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 			ucontext->key += PAGE_SIZE;
 		}
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_ma_sync_key;
 		sq_key_mm->key = uresp.sq_key;
@@ -2777,7 +2777,7 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 		uresp.srq_db_gts_key = ucontext->key;
 		ucontext->key += PAGE_SIZE;
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_srq_db_key_mm;
 		srq_key_mm->key = uresp.srq_key;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 9bba470c6e3257..92a65970ab6fa1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1055,7 +1055,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		uresp.qp_id = QP_ID(qp);
 		uresp.rq_offset = qp->user_qp.rq_offset;
 
-		ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_out_cmd;
 	} else {
@@ -1571,7 +1571,7 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	uresp.dev_id = dev->pdev->device;
 
-	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	ret = ib_respond_udata(udata, uresp);
 	if (ret)
 		goto err_put_mmap_entries;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 7051a81cca9420..2b01345848ddb7 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -414,7 +414,7 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	if (dev->lif_cfg.rq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_RQ;
 
-	rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	rc = ib_respond_udata(udata, resp);
 	if (rc)
 		goto err_resp;
 
@@ -752,7 +752,7 @@ int ionic_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	if (udata) {
 		resp.ahid = ah->ahid;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
@@ -1263,7 +1263,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (udata) {
 		resp.udma_mask = vcq->udma_mask;
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
@@ -2315,7 +2315,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 			resp.rq_cmb = qp->rq_cmb;
 		}
 
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc)
 			goto err_resp;
 	}
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ecf5910dbf0702..39d9cdcc5df45a 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -212,13 +212,9 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	if (ret)
 		goto fail;
 
-	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (ret) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to copy to udata create rss-qp, %d\n",
-			  ret);
+	ret = ib_respond_udata(udata, resp);
+	if (ret)
 		goto err_disable_vport_rx;
-	}
 
 	kfree(mana_ind_table);
 
@@ -353,13 +349,9 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	resp.cqid = send_cq->queue.id;
 	resp.tx_vp_offset = pd->tx_vp_offset;
 
-	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed copy udata for create qp-raw, %d\n",
-			  err);
+	err = ib_respond_udata(udata, resp);
+	if (err)
 		goto err_remove_cq_cb;
-	}
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 16e9ce8138cb30..ce77e893065c92 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1121,16 +1121,16 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	mutex_init(&context->wqn_ranges_mutex);
 
 	if (ibdev->ops.uverbs_abi_ver == MLX4_IB_UVERBS_NO_DEV_CAPS_ABI_VERSION)
-		err = ib_copy_to_udata(udata, &resp_v3, sizeof(resp_v3));
+		err = ib_respond_udata(udata, resp_v3);
 	else
-		err = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		err = ib_respond_udata(udata, resp);
 
 	if (err) {
 		mlx4_uar_free(to_mdev(ibdev)->dev, &context->uar);
-		return -EFAULT;
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static void mlx4_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 2bb5caf5a89266..0b3eda9b0ad0c4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2792,9 +2792,10 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	pd->uid = uid;
 	if (udata) {
 		resp.pdn = pd->pdn;
-		if (ib_copy_to_udata(udata, &resp, sizeof(resp))) {
+		err = ib_respond_udata(udata, resp);
+		if (err) {
 			mlx5_cmd_dealloc_pd(to_mdev(ibdev)->mdev, pd->pdn, uid);
-			return -EFAULT;
+			return err;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index e8d5d865c1f1f7..07c60797c86091 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -311,10 +311,11 @@ static int mthca_alloc_ucontext(struct ib_ucontext *uctx,
 		return err;
 	}
 
-	if (ib_copy_to_udata(udata, &uresp, sizeof(uresp))) {
+	err = ib_respond_udata(udata, uresp);
+	if (err) {
 		mthca_cleanup_user_db_tab(to_mdev(ibdev), &context->uar, context->db_tab);
 		mthca_uar_free(to_mdev(ibdev), &context->uar);
-		return -EFAULT;
+		return err;
 	}
 
 	context->reg_mr_warned = 0;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index a88cc5d84af828..2a174d0fe6ca1e 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -502,7 +502,7 @@ int ocrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	resp.dpp_wqe_size = dev->attr.wqe_size;
 
 	memcpy(resp.fw_ver, dev->attr.fw_ver, sizeof(resp.fw_ver));
-	status = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	status = ib_respond_udata(udata, resp);
 	if (status)
 		goto cpy_err;
 	return 0;
@@ -611,7 +611,7 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 		rsp.dpp_page_addr_lo = dpp_page_addr;
 	}
 
-	status = ib_copy_to_udata(udata, &rsp, sizeof(rsp));
+	status = ib_respond_udata(udata, rsp);
 	if (status)
 		goto ucopy_err;
 
@@ -945,12 +945,9 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	uresp.db_page_addr =  ocrdma_get_db_addr(dev, uctx->cntxt_pd->id);
 	uresp.db_page_size = dev->nic_info.db_page_size;
 	uresp.phase_change = cq->phase_change ? 1 : 0;
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (status) {
-		pr_err("%s(%d) copy error cqid=0x%x.\n",
-		       __func__, dev->id, cq->id);
+	status = ib_respond_udata(udata, uresp);
+	if (status)
 		goto err;
-	}
 	status = ocrdma_add_mmap(uctx, uresp.db_page_addr, uresp.db_page_size);
 	if (status)
 		goto err;
@@ -1206,11 +1203,9 @@ static int ocrdma_copy_qp_uresp(struct ocrdma_qp *qp,
 		uresp.dpp_credit = dpp_credit_lmt;
 		uresp.dpp_offset = dpp_offset;
 	}
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (status) {
-		pr_err("%s(%d) user copy error.\n", __func__, dev->id);
+	status = ib_respond_udata(udata, uresp);
+	if (status)
 		goto err;
-	}
 	status = ocrdma_add_mmap(pd->uctx, uresp.sq_page_addr[0],
 				 uresp.sq_page_size);
 	if (status)
@@ -1754,7 +1749,7 @@ static int ocrdma_copy_srq_uresp(struct ocrdma_dev *dev, struct ocrdma_srq *srq,
 		uresp.db_shift = 16;
 	}
 
-	status = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	status = ib_respond_udata(udata, uresp);
 	if (status)
 		return status;
 	status = ocrdma_add_mmap(srq->pd->uctx, uresp.rq_page_addr[0],
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 679aa6f3a63bc5..3b86ea1cf88883 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1251,15 +1251,10 @@ static int qedr_copy_srq_uresp(struct qedr_dev *dev,
 			       struct qedr_srq *srq, struct ib_udata *udata)
 {
 	struct qedr_create_srq_uresp uresp = {};
-	int rc;
 
 	uresp.srq_id = srq->srq_id;
 
-	rc = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
-	if (rc)
-		DP_ERR(dev, "create srq: problem copying data to user space\n");
-
-	return rc;
+	return ib_respond_udata(udata, uresp);
 }
 
 static void qedr_copy_rq_uresp(struct qedr_dev *dev,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 615de9c4209bf1..e887f03a84d063 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -82,7 +82,6 @@ static void usnic_ib_fw_string_to_u64(char *fw_ver_str, u64 *fw_ver)
 static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct ib_udata *udata)
 {
-	struct usnic_ib_dev *us_ibdev;
 	struct usnic_ib_create_qp_resp resp;
 	struct pci_dev *pdev;
 	struct vnic_dev_bar *bar;
@@ -92,7 +91,6 @@ static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 
 	memset(&resp, 0, sizeof(resp));
 
-	us_ibdev = qp_grp->vf->pf;
 	pdev = usnic_vnic_get_pdev(qp_grp->vf->vnic);
 	if (!pdev) {
 		usnic_err("Failed to get pdev of qp_grp %d\n",
@@ -157,12 +155,9 @@ static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct usnic_ib_qp_grp_flow, link);
 	resp.transport = default_flow->trans_type;
 
-	err = ib_copy_to_udata(udata, &resp, sizeof(resp));
-	if (err) {
-		usnic_err("Failed to copy udata for %s",
-			  dev_name(&us_ibdev->ib_dev.dev));
+	err = ib_respond_udata(udata, resp);
+	if (err)
 		return err;
-	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
index bc3adcc1ae67c2..d5bfdbfe1376d1 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -203,11 +203,10 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		cq->uar = &context->uar;
 
 		/* Copy udata back. */
-		if (ib_copy_to_udata(udata, &cq_resp, sizeof(cq_resp))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back udata\n");
+		ret = ib_respond_udata(udata, cq_resp);
+		if (ret) {
 			pvrdma_destroy_cq(&cq->ibcq, udata);
-			return -EINVAL;
+			return ret;
 		}
 	}
 
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index d31fb692fcaafb..e69eadde6c26e9 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -195,10 +195,10 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	spin_unlock_irqrestore(&dev->srq_tbl_lock, flags);
 
 	/* Copy udata back. */
-	if (ib_copy_to_udata(udata, &srq_resp, sizeof(srq_resp))) {
-		dev_warn(&dev->pdev->dev, "failed to copy back udata\n");
+	ret = ib_respond_udata(udata, srq_resp);
+	if (ret) {
 		pvrdma_destroy_srq(&srq->ibsrq, udata);
-		return -EINVAL;
+		return ret;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index c7c2b41060e526..b9c3202b9545e3 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -320,11 +320,11 @@ int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 
 	/* copy back to user */
 	uresp.qp_tab_size = vdev->dsr->caps.max_qp;
-	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	ret = ib_respond_udata(udata, uresp);
 	if (ret) {
 		/* pvrdma_dealloc_ucontext() also frees the UAR */
 		pvrdma_dealloc_ucontext(&context->ibucontext);
-		return -EFAULT;
+		return ret;
 	}
 
 	return 0;
@@ -430,11 +430,10 @@ int pvrdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	pd_resp.pdn = resp->pd_handle;
 
 	if (udata) {
-		if (ib_copy_to_udata(udata, &pd_resp, sizeof(pd_resp))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back protection domain\n");
+		ret = ib_respond_udata(udata, pd_resp);
+		if (ret) {
 			pvrdma_dealloc_pd(&pd->ibpd, udata);
-			return -EFAULT;
+			return ret;
 		}
 	}
 
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 30904c6ae852db..45404611c9ce56 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -372,7 +372,7 @@ int rvt_resize_cq(struct ib_cq *ibcq, unsigned int cqe, struct ib_udata *udata)
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		__u64 offset = 0;
 
-		ret = ib_copy_to_udata(udata, &offset, sizeof(offset));
+		ret = ib_respond_udata(udata, offset);
 		if (ret)
 			goto bail_free;
 	}
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 816624e0991a0a..70e7d08fdce692 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1192,8 +1192,7 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		if (!qp->r_rq.wq) {
 			__u64 offset = 0;
 
-			ret = ib_copy_to_udata(udata, &offset,
-					       sizeof(offset));
+			ret = ib_respond_udata(udata, offset);
 			if (ret)
 				goto bail_qpn;
 		} else {
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 1e1d262a4ae2db..b34f3d6547ffc7 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -102,7 +102,7 @@ int siw_alloc_ucontext(struct ib_ucontext *base_ctx, struct ib_udata *udata)
 		rv = -EINVAL;
 		goto err_out;
 	}
-	rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	rv = ib_respond_udata(udata, uresp);
 	if (rv)
 		goto err_out;
 
@@ -472,7 +472,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 			rv = -EINVAL;
 			goto err_out_xa;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out_xa;
 	}
@@ -1205,7 +1205,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
@@ -1386,7 +1386,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
@@ -1646,7 +1646,7 @@ int siw_create_srq(struct ib_srq *base_srq,
 			rv = -EINVAL;
 			goto err_out;
 		}
-		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+		rv = ib_respond_udata(udata, uresp);
 		if (rv)
 			goto err_out;
 	}
-- 
2.43.0


