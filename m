Return-Path: <linux-hyperv+bounces-9778-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBEKCjlTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9778-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE732C698
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E33373036091
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A50390215;
	Wed, 25 Mar 2026 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y+EhT1tw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F438F94F;
	Wed, 25 Mar 2026 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474033; cv=fail; b=g6uYXOkKfTRIQuPZhOdyJlzcUAY3x6FVisnYLsIxLkpF1VqdHP66phL4+DIp7JVx9TrnchUl3NcVC2N+vGnfBD4ZuYnryof/o+g7FJiJs8BT/GwFDg/hoeA2k6Ek3Mz80oBImQUUzWqWeN45u83/9znJ5GlEAAazlEete/ixSrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474033; c=relaxed/simple;
	bh=7UgrRYNnviSz44jOc6/c+4Kl+a6IFziWwO5kLh7xb44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oU4npVh+pLHWBZswBTmRkwhBtJx4zUpM+Gcw782Ap5aY9bz6Nd4CPmB6Jo/ftOHoUnpG8aETxBFcNj7zNxXF1W0r/SjapvcwFUgbnFWBH5SQgllDsuO/KgqUQ50UoJkISEq12NTc2sZmtY43Y4MPZssmG5Wso0utlH92n9rXRNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y+EhT1tw; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BENEqt+9wIJrtDrLHe1Hx+LmgIN46oYmOFKjAHIn2pB5XM+S68HYLZvoBsQdVLY4svncfudBd/b9cj/fAD76zANgNClUr1UO0+6oVCkt2PHv9sC0GXXCb1mbBGcSNFhxjd+uCBSN2Xpod88RSV5tLqlKu4poAoDojstYaAcXvqM/ElAek/L5sLjBJruv8e6r7lxRF4kGoCtftzU32YsxT1xivWy87sxnRJM1kN/Axddlz9k4HHyj7KWtsn8b+PsnCEhvwq2n97qva037ovFgs6bBsUpbcCgFLleV4B1lXDyWWpyU10S+++7Fp5/PxYrIfvpJ95qHkYdCw+ZCdPE8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmed6jWsrQxdF7KkkOWcUVmvnDP1R+b046UvAa8pzOI=;
 b=aGKJHi3aPqXA4juXF9fdcg8NWU1mWsyIXvEft5tNr4K6Eybn8MKG7eZXJSD86VFs9NNbKBGXWc8YrozEMnCbN7W+3wUtqMgd1eYd0XyecehvNMON1i4D2gpqwmwJBP/GNXHg27NMqAj+0WmHjlP2mf0lKc+FtD+/5x4Ni4FTBL+4GdpvVSY/wBjq9XZbftgNzP/kiNrmxY4zpd21yKau31rjLoRK8RZuRwIMeoXz6Le1mNjs+pwR299PSK/o5+BNsXNhQaaUD6Hj8g3moEe0UedgJMr7FM3tc3Jds0kySKFNUU667SA0c9hQW1GYDcH9ytQNSnHrpsGmiK7V0kfq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmed6jWsrQxdF7KkkOWcUVmvnDP1R+b046UvAa8pzOI=;
 b=Y+EhT1twDnBZkrvryHxpSol+bJlaiOOC45YMMULN49nf4o36cIQq+UjJ7MZ/YxZrQl90rh83l9dgYGLjs323dgiMcc5onb1EurQGEvpIb0LL4MnGruCTXRKaZe4kW6v+U3GH4VzOiKlWy+JqPa/DRfpavtwdRc5PqNez9B2hsjsvRcl8g89EzWDKWlQfcF8q83YYkMUGFx05z4bptJLmcaTHYCuIezYf4Nsy7USd/s7RwDosLnv1Rp5dRKVWt2eVurYcAgvFgWuRobUPTX/7bXx5m33KdSaR5oGa1KdyPgwco1n/8SiFbjRdKPKGmjlW9eH/DyU/jYfBxD/iahSgNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:03 +0000
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
Cc: Long Li <longli@microsoft.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 06/16] RDMA/mlx5: Use ib_copy_validate_udata_in() for SRQ
Date: Wed, 25 Mar 2026 18:26:52 -0300
Message-ID: <6-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:208:32f::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6ecdb8-428c-41d5-f258-08de8ab541f5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dK2RJwSNeMotHoIk9aJlKq+JFYFxkhd8CyjBakJbKV1ZxJ29JuXZ80sIZH0QPDJRs1CcnO8LcOrquxe5ew6m1ofnW6775yx7IVJaW0QVDGqqRAj3OFLJh2Brnz50+uzOByQ2ChY0E5OLRyF9iM2HLNI4HJm3tU55ZFJKQqD6BR1bFwyg/TX0cgV4sjNgmsHquGUgnKW0DGVw4lWYmkSnR7KBWorjyPrV5WK7886vGJdWYusNcYhYSOdNrDDupyB0tSs1zNvvPFwxZxiswFIjR/pJdbkf+p5agc4Na+dwLOP1gMLO05w8MeTXJKqSgrp54c7xCuelFyr9+u1r4Xe8/e3SUMtN9pHfdD7rU7hXbX2BQW4VG8POMy9EStBZ4hjwTt7Eaht18l4txdbpmdHs+TLUgi4SB9yufd3NsID24G20zVIWppWIk2M0NWh+JeQPYFc6MFLyQQ00COdMoIEccDcPhMC+IDDbiswtUIAIfpGhvd2v+abjT5ypGcR2LpK3FXjLrmTqDDRt1jJkmsVKBVUa8EWlMPokpk6Z5z0mWzD6d0O/7hD2V6/irxkuCYa9hXm8G6cSXpcklZS+3eZyqgTOequGn/UZA/uWZ+iNwlm9S0ekhJ9L6d1hXp8CzByVzqjFvHMlh7qmw5chtWzKETp2bf93vDG6soR+whY8UUosnna/CiJypwJDDRU1nYkVlk4f1ezJZU7OjGkF6aYGfIHSEXOHuRww84VubWToMH8jdowCoLC5Cxyx9LiV7TnD3GS2upxAtXu8bHiVa53x3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TFudAQiFx43OdxMLpt8Hxid9XK35+fYMW1XgYrRJCMBPRUWdKxe18vk7liIr?=
 =?us-ascii?Q?1JGztQNXL9hKWw5keWLVlgDHhJ/6eUyJ2PbKLe3bzAPNFqhVmiYRCxXnciyn?=
 =?us-ascii?Q?IBSYxjWu3wV+7ex76iEChKk/HRnZ1NavfifPYh+tVmzgMBNj0dE0ierRLrEa?=
 =?us-ascii?Q?KSi7n4/BOqiQTNS0mz4c5BmKJHKqLNtTjkcAqcsgsSTx2XA+abBkCcTTgbi3?=
 =?us-ascii?Q?9cZwn7CuW5RVTLdybwsKC/YBJ4M+1RBl21NWbGtwalyu+a9Y5dd9CSFHQB0T?=
 =?us-ascii?Q?4Pk6mk43ERp+hxqd6jYR4Mtcm+yHRpaZOGI081pPyRiax8RRaDCotfuuIjI/?=
 =?us-ascii?Q?vxymWcy8JUFALfMreFA3yTPzjGc9aSW6oy6+TUk2+vGj8uHq+wPBIbRrgsCS?=
 =?us-ascii?Q?zsaYWJKDhCc/0dDVa+xiFlszlH3Qi6y7DyKIw1Y5BwI0ddKznlzZH74lqxhQ?=
 =?us-ascii?Q?j4YgqRqFJNKD0zpIoVoSyU3rRJMgX0UntK0G9Ioba3ZH1EFglRerK0dL1Acj?=
 =?us-ascii?Q?7h5q/Xx+lJTK7w8lAGJNsPlj+UhL2iBvBTX8GiUp2cdY+roY7sqSHDEDEY0v?=
 =?us-ascii?Q?URsiILv7SzOnfW9v9Z9Gt4BamWQKPqGAC9l3TL/99JAs1riTTvbcsVFdBise?=
 =?us-ascii?Q?2odSHcbgJ9RQsvIJ5mX/fVZq8oe2P5QxTAWhnLK/E950huNGbhNVe9aSytao?=
 =?us-ascii?Q?RiA91+cyTqPBiFaiIhTkLVOFU2iqqM1wJLpHN7vQJmCZ9eFWtmUkrwcctZv6?=
 =?us-ascii?Q?OUVaDaOqLzzWar4Sa+qOavtHoFFh0s8hy2DrT0cXjTlz45aYuHgKMf0aZpVY?=
 =?us-ascii?Q?0+6IoufE14WQxRqZ6H/9G4XBu5w4b2Nwo6VoLQINbjZdRB/No7bx3BcVhsD7?=
 =?us-ascii?Q?tiD33tUdDF3LWDdxIfh5Q+kJvuSnAmQjNTKLLxkTICajhWc/x5SPH+/NRPDz?=
 =?us-ascii?Q?V88fO9Qcze8dNhfzyWULkwRv44HbF4ySQN6i1appzQWszb1Xuq1bVE3EL4TY?=
 =?us-ascii?Q?GOnQ68QJDFD3MP2C3w8Lnev9J19TdC+ChhYmNvLAoT7GHStlIGhU5xLRC6Gb?=
 =?us-ascii?Q?mSifaGPKDxD5mBewaIKLSuwRyckd2F431MRFlKEzprUUJIqC/N0IGM9wzite?=
 =?us-ascii?Q?0xKC7BdB54V1wyF/Jpohen5it/DIdoDmwGVxVtHQwLh44MC/a4woXp66dJVq?=
 =?us-ascii?Q?SdReMQZiY4QIBD2K4t8hq0dWgu0kToix00D5BXPPaiysqX0U54jP4hQEq3b+?=
 =?us-ascii?Q?eWceLjFytdtdeLqH3tmPJgInvGw1Xyo9aJWMweXcFj8ZGLzAuzuz0jo8klO2?=
 =?us-ascii?Q?WDL8y6dJMvIUA7AIo7oD9KrPL2cLIMi4qL4vTtFPqyao6VSu8HOYZT0lJd6K?=
 =?us-ascii?Q?Cx/ZL1vv1qwBlt82vfw6Z9eM8sHXXIP9AaH2O0hYXJw8So4Ia94xErbl3guH?=
 =?us-ascii?Q?+waI5fp0tedoszO1ex6pW961vziN3G/EQIRp1LADbbD8AMtuZlYob6+TJSPP?=
 =?us-ascii?Q?/9uWJr7Svs4C9wOZRTJxqjUnuOsksteJH258kltNrc8U9WDw1/VKNo3kKUqq?=
 =?us-ascii?Q?EVuN1yqskvK8EeGhcAxd4XYrbx8C6cP88No6Ha/EYPeGWO5PTSo2MnJ716hu?=
 =?us-ascii?Q?VMyFdRNSO5+sQAksnCQNo899pASisvlUoX0gQcGJ/ZlbNRmfI2o7wsgF0s/l?=
 =?us-ascii?Q?9Uo2ZgTCSmkgUeXuWqHOJTIf6b8ECc+4kgSANl8outAy6YpK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6ecdb8-428c-41d5-f258-08de8ab541f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:03.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyLj5VIR3gtYob7bJRDJtIws9eOVItCQfOP07ngU2R5kI2DAUVWZLQPbWCgNhYJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9778-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 93FE732C698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

flags is the last member for mlx5_ib_create_srq, the uidx is a
later extension.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/srq.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 17e018554d81d5..6d89c0242cab61 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -48,25 +48,16 @@ static int create_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
 	struct mlx5_ib_create_srq ucmd = {};
 	struct mlx5_ib_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
-	size_t ucmdlen;
 	int err;
 	u32 uidx = MLX5_IB_DEFAULT_UIDX;
 
-	ucmdlen = min(udata->inlen, sizeof(ucmd));
-
-	if (ib_copy_from_udata(&ucmd, udata, ucmdlen)) {
-		mlx5_ib_dbg(dev, "failed copy udata\n");
-		return -EFAULT;
-	}
+	err = ib_copy_validate_udata_in(udata, ucmd, flags);
+	if (err)
+		return err;
 
 	if (ucmd.reserved0 || ucmd.reserved1)
 		return -EINVAL;
 
-	if (udata->inlen > sizeof(ucmd) &&
-	    !ib_is_udata_cleared(udata, sizeof(ucmd),
-				 udata->inlen - sizeof(ucmd)))
-		return -EINVAL;
-
 	if (in->type != IB_SRQT_BASIC) {
 		err = get_srq_user_index(ucontext, &ucmd, udata->inlen, &uidx);
 		if (err)
-- 
2.43.0


