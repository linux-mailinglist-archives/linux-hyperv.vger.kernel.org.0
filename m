Return-Path: <linux-hyperv+bounces-10429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCyDIvbh8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10429-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:36:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE44890E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F3830C0E20
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8D42E01F;
	Tue, 28 Apr 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qwQWhchD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E733B6DA;
	Tue, 28 Apr 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393085; cv=fail; b=CUJD/KUJ1McTMkpZrm4rfwBZjb5NjmgMjZxJDliapcwaTaxTAfrtb7PB7Fpoz6WTR8KGjZGOXF5JhuWZVcdIUjzd/hQ/BfrEkrmmeChtWvJcGL5PJ8D2M/nf08IaoyHDLrSHbwC+xZKBICJlhu4OvN3vV6EWx3U58WY+49XGQHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393085; c=relaxed/simple;
	bh=EXgPvE5D5PTYmUpD0ik/O/3JxrVjjbZVLxU6XTUjYdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SETAFXhdQq2KlZkU+4d0CMiqsoDrHtT3/8MSen2RshkuimI3giB9peJXfxHlQr7rs/8CyiGJsxTOAXTByoqmGmRDXhPtMv90MNxICwoWySjOPI93n3WFXwu95AXcgxwVKTJSvPxW5D76ZaAUo7hvZPNRQx9AF6qFEb+9mo3HWf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qwQWhchD; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4KNxbnAyNBZ2YCQJLQUWv2Hf0JHfalafFcqV7daJ+H3D0T2F/2gF91tN4Y4cI+y+A9hHY3hjiY2bHl8kKizZJ7Nh9FOS5RKIHjEbG7blAyhQx2DnujLz4pzHOhrQDg5iEWf4Jb7c9bk0b1HgwtSy/qiZoD5xIi/J5+vQPAbxRLdjoenLLUNjiBhKYgBictxsu+GYQAEyqnkKS50XVSOJxS9778AYt8xKjolhWfPS78+8uSYxNbxBmXfOwzRsDQ0bfexoDF4z78DlsQbR5PM/3OrV0GCMByCtn7TkbYuXY+l3VKP1Ggv+33mLj4PjJEA7wmX78VO3O+RxGBn8/mcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUEIzZECl4cmTuTQbJzFEV5bvMGlAJVdrDVFlem0b9M=;
 b=a/HhA7pCL/RPeO7CR5thNdtSyIusnI3xbYutL4jWIQWRldbRSfqQNiPQWfj1/YU0o9AaUzgvFCgXV0zoNzHYzBrar0ASIAdxNFruIfw+QMyS6dwXQ1rdv/yfq5yIvRwmbaSvTjy6EttDupjY5NqS1DH8BC9EceKofFzyO9VmDPUVORDoM3DUJBwpfVQ+s7dB+agQfoZTBnVfOH1wEIsWHq38EsBh0g9N01yb+79G4u83XvFZfOQRpBe5WqQAhhrOTcn4hisuKWM3xGCRVUtAOKe3HFDXKkjPKxHVrqALwtd9Tf6WrWiP4ZQ5T4eDGrzL4rAi/a8j3rZuPQZ76IYj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUEIzZECl4cmTuTQbJzFEV5bvMGlAJVdrDVFlem0b9M=;
 b=qwQWhchDfm8VDs0u/O/5zP/FkDwDlFjF+dMvF5z6uDWFC5SkizICsMrBeIjGVe38+di3P7kijzspjP+4reiM1B4g53rhJFuffW5I6eKNt1gqtXxck0x51OjbcC4cUV7WrpYyGE4TRFS5ne2dSG+8LQPiiWKDlS0DoP7bb+JfWAbVF3nIKK4GteZEbYNCbeetEniAbPkaiMhag2aXWUPPFbYY+NqvkX9yuVuui86qeEnQnIqsq65vL1VGhLXVqnUMq3a2IHmAh/74e23ypy5YqgrNQA9lS3ZfSJsRTbjPC3bJ6mYLIMih/Uw9NL04+PvabHfZsRF4f32JoWQQYfkOsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:55 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>,
	Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: [PATCH rc 05/15] RDMA/mana: Remove user triggerable WARN_ON() in mana_ib_create_qp_rss()
Date: Tue, 28 Apr 2026 13:17:38 -0300
Message-ID: <5-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:610:56::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e10f22-6c29-4d94-6fc9-08dea541b26c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	+6Uncbya5iOC1YEKLU/RdfkoiPbQI3PnGeAIoKC6AOHvPABRSJwz8EhyqR5BfROD76xa1ABV0FsBa54vLobaf8I8581dENpX+PnUep/dG0zz7aiZr40nd+kXCywp2q3C9SnGuk0V8ZE9Qk6JHIBWOhdyzYMu3IjwqTnM4G4MgAPtLHh0Fi1KnxLEiwX+DLCSiX3o4COG+FFqkVZtpCmqQX4p/bvDIDEn13BZCMXpRJfYCMs7zK4lyvi6N7ced9Bqhw91dtWNGBaql5qZyr8UCTc1uM8JYJlMfjD+Q3gIvBr6zgC9JSxE24tVAq3xo+1Yj/9pFrevo0PFDrZr/i0+rE5gPDaf0uhMjUtEURztwQZhNn5qTd16GZcSondpc2tY5Vx6p2Iv8HicEXMENFGaQsRvGAE1yjY7Jiqm2+Z88VNGJl7XbWv/r/65xv6gZ+t/u2BhcgOC7IkWZ46c0O/4Ji0MT4u4IDHm0Z81PczlFbgyiOduw28EyGzH7d+a1jISGd71+8e4AO8MNLN0JWUb6knk8wpj+HgsGGl7xh41b9zMZyF0kGEtzA9qaph6/poc79M4RTkK1jwZKlCcvx219IuX3UUjlxOror3aDdDJN1k80p9wxvS0wsFdAPd6u+0ynMXAz/N/TTCQYx/M86BtML8rBRJHInIiEt/sjJcn3pmtKYnoXa/Gcw4LYOGJAxf4nG8hHeTow3BAfpVCV+xMRu8ghYCG03ld8r4SJ2Qg1T13tm0rWvpXX1BFsJcTYqj8fWC9rEZ82ja1BHOjX2URDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztRZNkBM1fS5qS9jOzh4VMA7iJUCbSayHuDUdoKqHVn9+6cQpuCNaubrp/FU?=
 =?us-ascii?Q?jjtMphx+XnGb5J5ZP4qw/0AgzbPDphNqrA/arj9PSd+Bct+0zPmaBhfFrxCO?=
 =?us-ascii?Q?U+KFk2XmRvb5u7gYO8AJ5dBikFzteLaUnfpOCfLXe0kGyS4+44IP7XpuFrII?=
 =?us-ascii?Q?r1VKrIgal1o2qQJa99QrU1cquIjOicBqiLfUtIxYcGgZdNs0LD+CzpxPLvgz?=
 =?us-ascii?Q?etob+SCRnmNzqlni2tNtFMd652bg/NqVonXgfS0CovHQ7vFt9UU+lERM2z3K?=
 =?us-ascii?Q?0Shhv4mcIPhF3H3rpWD+9ll5iEwAaLsAe9h6RaGhJM22KrqTX6Ro7c/0YAqL?=
 =?us-ascii?Q?ZPGPJjCO947JU8MRSBL33a7+GmvUHm0kyUnUO7rZRQuaQtt0m2eEXpIwik0D?=
 =?us-ascii?Q?qF/Z33xJ3JCZ7xp0Ve/6zGNIi/UcuWsXsw6D0NmOU0oagnHr92b2yum90tri?=
 =?us-ascii?Q?o/0S5JWwolyExIq3Nv5qGvxesskPRTjox3f4BZyI5c0Lwqz4Si+n0piDBGm9?=
 =?us-ascii?Q?W1R6JZEIJWVgFBbyRuJcX4CVdrvyHOvKy/1ybSvSSZwaBCFfQ756RFE1t/Z9?=
 =?us-ascii?Q?YCpcNg9ztRS7Uy+iypmh3jfH/t1eNKZGrZ4vuiInsgmcXr4GESc9u+JgfDqp?=
 =?us-ascii?Q?PeEqClfLXSyuKIzN6pJte0V1NbCm6qs4jRwNdgIVf91g/rsLVWYp/+JaSLg2?=
 =?us-ascii?Q?ZzOnzz40kv8sunTzpgx4c53+4pwBB5wnH8TN+TdrJSI3aSh/xXsX5bgdeE7O?=
 =?us-ascii?Q?ICxLyyUB6c43j2wcmai7aVDDoBTEnq3tqCx0GdqjUsY1FGakxxQ4OteVRSl6?=
 =?us-ascii?Q?LzDlc1i0RQoZHEIgXQYeqflc2vh/CkITLGdmP9WmE2UXuKeQI/pzDizqVF7+?=
 =?us-ascii?Q?KzPZI84K7F54tHRHgsKTjEAsLD+LKQFI4CIRThVgdk7iCWZstnaycQnk2v6X?=
 =?us-ascii?Q?B9GBl+taLoqow4v2vs3GJxWflcJ2/GGYKnv6K6ht0GPpfpK9EylwjM479EAC?=
 =?us-ascii?Q?RDrYA2aM9VLccc1JMZTZLy6rbx8ZouYzVzfXMVR/zrohMaPCc70kjqbIifc6?=
 =?us-ascii?Q?/Qb05zuQhVHK1JNLJRuIFAnU4BJ2jFJ9sjMy3R28QAtrmXQvaemnrEviRWk3?=
 =?us-ascii?Q?33R9p9FuDK9y/fwqGHQM77xDrVEDrk20OgZ+CZm5218q2VPCVA9pBUtMzXjR?=
 =?us-ascii?Q?lPG1DU7sO1cDu6DJ6bgfe5Tntn5GDB/gudD6R0UY1hUERoQQkp9u/rnpqoQj?=
 =?us-ascii?Q?e/qgGQnKBvag+K4n0QoS5Z/5nBbTpn0cVsfNY3KiVXil7yrat0KFMaCbOFiH?=
 =?us-ascii?Q?uNPz/wgMnVcTFvs3svhj9xx/Mr7wY32DgMNeEsQEklNvf524Uixu2eWHx/y+?=
 =?us-ascii?Q?iOWvxOQUvnHJs4jlnXU9WxLdXEhIuX85M76Z8Q//0w/prd4OMEZPCYoAFuVW?=
 =?us-ascii?Q?3eXomz3xs4FT02nbgRSzTYifLJtfYOppxYLfGy0DoeupUd/u/CFdPlpg1XQV?=
 =?us-ascii?Q?KhpkVGJQ+TXfytArJb+cLzqJ4ozqbp3V32sNGPqpP6DsjgaTcl7fhG8Lz80m?=
 =?us-ascii?Q?bqtVqQnBBISSnwtHt5eY8f5p6l0g8iKMaCkSi6eDhODezUHCt7gW4hLIlRGy?=
 =?us-ascii?Q?ABQHhYKWdLzAdTZthqvydTVE54zcmi8xMblw7rbzjLDHcJ/4kgVyx0+93yfx?=
 =?us-ascii?Q?qyEWqdOUTOKDz++/WwFpZK73OzM3qNb25+OP9iLGsTngHFku?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e10f22-6c29-4d94-6fc9-08dea541b26c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:52.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP2V+lPlqAuQ1XiIkoKp2ImXvIjSm4GnL7y3yxWogaDL6RM7lK6qlhXtjRFUafDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 3BBE44890E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10429-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]

Sashiko points out that the user can specify WQs sharing the same CQ as a
part of the uAPI and this will trigger the WARN_ON() then go on to corrupt
the kernel.

Just reject it outright and fail the QP creation.

Cc: stable@vger.kernel.org
Fixes: c15d7802a424 ("RDMA/mana_ib: Add CQ interrupt support for RAW QP")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=1
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/cq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index f4cbe21763bf11..2d682428ef202a 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -137,8 +137,9 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev, struct mana_ib_cq *cq)
 
 	if (cq->queue.id >= gc->max_num_cqs)
 		return -EINVAL;
-	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[cq->queue.id]);
+	/* Create CQ table entry, sharing a CQ between WQs is not supported */
+	if (gc->cq_table[cq->queue.id])
+		return -EINVAL;
 	if (cq->queue.kmem)
 		gdma_cq = cq->queue.kmem;
 	else
-- 
2.43.0


