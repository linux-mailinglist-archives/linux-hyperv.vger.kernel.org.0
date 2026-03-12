Return-Path: <linux-hyperv+bounces-9335-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHrcFtgHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9335-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6167926B9E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4BA8301BD70
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6EF3382C9;
	Thu, 12 Mar 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IEHzb92r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947E32C957;
	Thu, 12 Mar 2026 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275081; cv=fail; b=K0IuRnxsclRdWodGiH1Ke4cD8LDQNaePMmpdgfocTNLgiLNrmHuVC1iN5rFn4S/DiWdPO/3fVFe7UhLtCs2/QaMKiWVv9LrwnP2JC1xZIvMm0c8EwDgCRsXYb/5GtS39xjqkVeQwaFoyTfWWFJMd4a7m0HNHhuM0R43Y/RPFbhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275081; c=relaxed/simple;
	bh=bfAfzyePiqbHdYWHMoyA1rtHyOzIm9Xd0V7jZkr9ICY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4pEj/h3U4N0f7CVs9J6bFUokLLryfuq9THQbMjkdy1WXIcPuBB3gtjFXYidwjEqCeE7yyPQJG9oNQ9eDMinpJyB2jwox5awce/tZu9MC+jCCEH2Lmwuy2CGcgSdBQ0VXNWcFkTZWx2M7VUoXIytkjTe2ay1AFuibBtOD801qvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IEHzb92r; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLjErnSHAbe9t+J6eGns5P92qTWRwTH/SaYcnHiEmjgrOcAL6coJaELF0ApGK/SV8pZGYA1ZrDCLo5UmYt0y4jnULd/cdWDXXio/swPyOgtDyXfR6uICX5hrgj2yVm3LHb+kSf+kksLmnXRLLpBvh9GpjoftkmgsVKO7ML+h+ocQAx7l+sFn9YSwCZ5skz41MgpFalBQYieZ2OrDsAHVF5neheN0l0200dqj/r1rqOfrm420QDxUPIVmYrlSojT482XzLpwqzFG9CrBNs4uG8APwYrY9EWoDqdmGe7xHIQoHKwRJEo1eZfXl8RJyNh3bMQiUzGOJbrD+Oy+7b7dS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qYatVQC3hJ/172jDG0MPH20t0FfT/hn7wWK7GXDNNY=;
 b=oJaI9jV9JOmneD+JoEILiQdE/XZqJJKsl/ctLQrvihPbX72ODQduYiWTGEARInIm5elPtTwqmuZeR3fY05toSUAaO9DpnYV8FYUZRa+BPLXADkPci08IjntMXg+lJ5aDVT1+l7rl3/JWZ9eIgSLQAy46lTFt7aKpcstvEvv6st6kXZREVXt85QruyVAHDYUKLamcK655F5BEHV6Gj9iXCILPgXep8IYvCsGHj+T4cll5pGWyWMSDmrUPqKWLI0LCdJt/GnTF3+v0Zvj9Mjt5JgGWFkurT1OOAHBphLF1vfe4loDtdI0AVLpcevKplV90QwDZPA/7iBOOF/qv1htOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qYatVQC3hJ/172jDG0MPH20t0FfT/hn7wWK7GXDNNY=;
 b=IEHzb92rATgEQuD910VPBid8Dgfjqcq1ZEUyf0ltm2K8gMbsWlaJyQGhqBKoYtTVGsXJy6v8vXlcvW+b0V6yLNC+W+JkYD33p8uXSelb/M9nx5KEFc2o3CWYb4PNYojD4b92q1bpCLNB3/9nCAsh1eltsE8emqYkMcmnV0SBgL+tZtHwjHSght1OnTBZ23fpvwzSEmq3w0U1r+dA2kk1HKdH3VofGKyNy2CISUzx/1SjPf/ANYijlRMdlR7yP3F4wHE+HgS2/2Tx0JkS4ygSFTh7HLKfjK9mZ+NBzpS5NrkiHwSMms2Bh6AehGh/6ivmEq0AEhPO3phpuPqMVl2g6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 00:24:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:27 +0000
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
Subject: [PATCH 07/16] RDMA/mlx4: Use ib_copy_validate_udata_in()
Date: Wed, 11 Mar 2026 21:24:14 -0300
Message-ID: <7-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d931fc7-c0d5-4515-264b-08de7fcdb73f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YaTWD6gIy335DklZaEN6nm2WkA5YW10WXpDdHHjXvzIqUcGExzKDXaeY1rjLiXHTZFAn+eCQr1Y6BflOOEmGc1fAmONaAelZhTxRBTTJ+1hLObTlVEkNYh7v8PYmrYpM3HrbWUDzx1OhxGFcX/J/BtB1B+7p+J8gy+ba1HHKRoO6YryDHyxRZl638DEuYStf9iaUdvk8XmGQGS4doJ8GNeSu+roR/zMyk5cU09C1ohPPtwEvPLGsuY7ENGMyiohB6dAhBm3eLL6vcEChEoD1J58n62mpKOPfDXrMFbw/WZCL6/Ru8eNHvty0b2QFMwbFGCLeg11bNZA23za8ELU0FaBIjkVNspONIQgugkUBgCEyulgV8D28u10dIhiQmCxcqsaqQhKkE+mjcK91hP6WjX4OU6yt9l3Be/CG0QyixFkOq1YquP7qz3BHBWniAHl595F5SEm2Dv8uBu7MZv3yK1ytT3ZVRCLgO5skCtedk87mIa8wlna0/HtxaM4OPNEzyQ5fCEQX6xGAV2aV/kmuWsgXUd4yX950XdUg/FjyPlnFU5rGMs7xDjzEVyRcp5OyXpC/VH7keD2IGRdR9FmwtCxEVduhyq9fi2FRByFt+mGyuVLCqGpJEBs1KnY8N9Tf0RS+3GBZMFgG8Q3CSjRRYoxk1Gnnt91hAbQhF1JET0qWbZyKoX6kcoPpaM0WAg+fBl/wQrllEjLi9iGAsJeD6UqEGIOlgEe65nv67j3MfOQ0OBM1zIVS+9cXGVO2bJRxdVfRx3oF+WENEDI2iHBcIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ehPbzna0AIbLbBeHyO7Eb8C5mtkrUegZ+/OYTJ/ulBon1Pgd/xVvS02AiITI?=
 =?us-ascii?Q?5RCuIS0Qr+58MSZw4w57Di9H5LPPJXmX75gn9A41GeLxpACYxuU6cUVJYYZW?=
 =?us-ascii?Q?pkaG0zKMeBVq3CltLMSg/5jsMt5DaiWR0dzmMWnqM9A++AaRfY3ECE38U9OS?=
 =?us-ascii?Q?bpehVjxG3T4G7bKfCkkQd28OfbQ3wK0vNTnf2boY+bsV3GFZJW86sawE0m//?=
 =?us-ascii?Q?YabZGep5VcielTzjNjeUIMRUJLM/YbgIrbMpggx5jxMPZ2BSV2D0EgApjB6q?=
 =?us-ascii?Q?6H5JSX/kcY3lSHW+tcNI7ggjR3VOQpJUEmDVaAt0Tqb5D7crdPF9/M2g71rl?=
 =?us-ascii?Q?i7b5N8Mtm7+vc+QvFAQREox/jGxZ00uL456SpHsPR/uVBfGT78XAZ2pnqjk7?=
 =?us-ascii?Q?/Ii7IxPNDN8em95WR6Yol8PFq0mK5+8cAThBDHvKX6Sm9kuVuAXynRjM+13p?=
 =?us-ascii?Q?dPXnNVYt3p5fsp8DjiozVD9yfm14/5xL/Wa/FQLiMep0uFKrAWTG6sZIWuoJ?=
 =?us-ascii?Q?1rbHCbyRqomFTvEnUDPHzrvMlsn2/ZJ9Itb/zMG+HkI4IOFW6ooUF4UUDvyc?=
 =?us-ascii?Q?n5R31eKJf+DUIUV47oERgfVVeCF4d+RIWxy+Qn2Y8n37eVJVJ+yKoyVIrGTi?=
 =?us-ascii?Q?kdWzSjxc8yi9bQSd3tssMUpHOGvJ+Urg3ZZ6qvJSWUdOjzWqir9a1bk0ngJ5?=
 =?us-ascii?Q?hAhv5CEpm13Ol3NyHEu34CyPPoN0I1InnEPF3dJUMXhIwwTzH5DnkbaLVRFf?=
 =?us-ascii?Q?7JZGeXQzoIWH0WTIzs9LX8QD36gEmReQ413fGxEiVaJmKEQzT9XH9DM/DvGt?=
 =?us-ascii?Q?QhEzNWWqnJXJXP6OlipT5kWcZKc/8mo8TMxZ9MYI/5qLGlpeArOXkSsiMKp9?=
 =?us-ascii?Q?Qb8GfMBQSnhRacmuK0BqjnU7D+BaCXNZ749kiLEjzvIl/l3cyMiQL1JYch8L?=
 =?us-ascii?Q?USYWyr+7Upg8GLHXaTO9pyiaKQt+SwzyZ2r7LbGCZxqbUQyXXJshmUexOKCL?=
 =?us-ascii?Q?5/MJ1cye5lUV5WtZfOCyUHxTwD05cPbeh+0p+qpV2fQ5hhuEumomuM5VFw89?=
 =?us-ascii?Q?8MO8SDHAEXxt2DOhrxagOsz28R/oK/r3n0fownXoCCmjGWvu+eilJWCxrsV6?=
 =?us-ascii?Q?Bc5huWBkVHDNc/sh158fC8cYkOQWG50c363m89g8QN7avnzK6uOE15OytU5z?=
 =?us-ascii?Q?jMBL+BC45aGB6SNb51zszdUtwMY+ieSWOGq8MdCBc7w6Em5ok8ZKi3HzY/13?=
 =?us-ascii?Q?9KNqS2ZpHdJJ94Clio17T9R/gEJVjpC+yuiUfeFFyRSjyDieq3hCCnfZ63V0?=
 =?us-ascii?Q?0CgGU7RJFW1Ih++nmfjujlE6nrSoqwAgc7sme8deeebS2gOTcO/Tq/IpQLyS?=
 =?us-ascii?Q?AwyU/Rtrqbe/WfO60QFpYqhJ7Yti04asSPP9HXT4ISzyQZJuGTjHtY81SE2n?=
 =?us-ascii?Q?NqoPB48K0Hen8RQmkjoXcKnh6ypWLoOqUfHaAqphOL94flV4juIExcL2U/YX?=
 =?us-ascii?Q?7E1rNIVBtIDG4DSi20SUu2fm4bRih66SgrxHdlHOZmEBxl/SDIiQRkECrvfW?=
 =?us-ascii?Q?H3YuUyMMH6P4SY8aZ3CyF2tg0ze+Zus5J0OAM7g4Pa/mM5WPhdfuuXCGYKTK?=
 =?us-ascii?Q?ZMoHEfLXsCn3OOqddlbmmMlB76QWAOlLxUzxQ3PIbBKzUS+pifOlmSQGwdur?=
 =?us-ascii?Q?tUNjWzLygYz5NrmmuY6OCj0E85Ogqu9BWt6zsAdWhCoMKNeR5CudFSI37UJD?=
 =?us-ascii?Q?i7EKJ/xfnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d931fc7-c0d5-4515-264b-08de7fcdb73f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:25.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8VpPnEYyrXsP7M0TkJD9So2c+NyS3fG0fFkT8Q7ogjUX8CtXOHsEeCH68tNMJQc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9335-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 6167926B9E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Follow the last member of each struct at the point
MLX4_IB_UVERBS_ABI_VERSION was set to 4.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c  | 10 +++++-----
 drivers/infiniband/hw/mlx4/qp.c  |  8 ++------
 drivers/infiniband/hw/mlx4/srq.c |  5 +++--
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 8535fd561691d7..ed4c2e740670be 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -168,10 +168,9 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	INIT_LIST_HEAD(&cq->send_qp_list);
 	INIT_LIST_HEAD(&cq->recv_qp_list);
 
-	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-		err = -EFAULT;
+	err = ib_copy_validate_udata_in(udata, ucmd, db_addr);
+	if (err)
 		goto err_cq;
-	}
 
 	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
 
@@ -332,8 +331,9 @@ static int mlx4_alloc_resize_umem(struct mlx4_ib_dev *dev, struct mlx4_ib_cq *cq
 	if (cq->resize_umem)
 		return -EBUSY;
 
-	if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
-		return -EFAULT;
+	err = ib_copy_validate_udata_in(udata, ucmd, buf_addr);
+	if (err)
+		return err;
 
 	cq->resize_buf = kmalloc_obj(*cq->resize_buf);
 	if (!cq->resize_buf)
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index b87a4b7949a3a0..deb1b0306aa7a1 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1053,16 +1053,12 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 
 	if (udata) {
 		struct mlx4_ib_create_qp ucmd;
-		size_t copy_len;
 		int shift;
 		int n;
 
-		copy_len = sizeof(struct mlx4_ib_create_qp);
-
-		if (ib_copy_from_udata(&ucmd, udata, copy_len)) {
-			err = -EFAULT;
+		err = ib_copy_validate_udata_in(udata, ucmd, sq_no_prefetch);
+		if (err)
 			goto err;
-		}
 
 		qp->inl_recv_sz = ucmd.inl_recv_sz;
 
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index c4cf91235eee3a..5b23e5f8b84aca 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -111,8 +111,9 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	if (udata) {
 		struct mlx4_ib_create_srq ucmd;
 
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-			return -EFAULT;
+		err = ib_copy_validate_udata_in(udata, ucmd, db_addr);
+		if (err)
+			return err;
 
 		srq->umem =
 			ib_umem_get(ib_srq->device, ucmd.buf_addr, buf_size, 0);
-- 
2.43.0


