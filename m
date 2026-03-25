Return-Path: <linux-hyperv+bounces-9782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJaqC2xTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9782-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:28:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8679032C746
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E083C303DD17
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6138F935;
	Wed, 25 Mar 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dzrH9Wcv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414B38D001;
	Wed, 25 Mar 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474037; cv=fail; b=jr/men/nwUqKxvbBVz0QFRebh6y53XEXZB30mxuSLgwVohC7mttauDuUlB/XejftE3ml1o1szPyBorrCie+X+CBscgSULBojZU/Iqb0XgpaWjzMA5ciw+wVq1dHEAltoBSl2b3AsuH2PZ6JLzkOD7+BWrhkCfm6TnTe12T1K1fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474037; c=relaxed/simple;
	bh=QMJBhuM6mkp34x4SFO8PTgix829+nJ2nA9Jrkm5XzEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CR65FLHOgT3wooUdet3EZhBdqFu6hoqGTfBnUbnLqRcxxNUWQQhRJ6pK8uHFQfxVN2EEvfEEvHcHB10/jX0mZjTpFG6p+z/nQZJbKE5z7+mVO+MT6pgWjHJFtF4V1hicm+ImsDKVWedOVu6dIm5aOcGe+mCS4+Mrc/2eQ8GIUgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dzrH9Wcv; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGnE3EvM4zgDXguyKxoLB/UIKre/jDQ7xhZSn2wYXY9NLqhbLpq3WagJCUjuTMGffup2dx8dGjsvoMgPu1/UbBzsjCLuMV+/uX38ZLXgCNIIlOOKmbJbql8iG0PXQDOlkxPetij2Mqb4lcPXrzoY+B0eM6/ex1d+rWaTH0xR6+o6jreW4VOXeeDnV5BZ8cJj/u6KLbMtzMSPdo8hgAuLKYSvnMACqKnRbDUkQfuWUoceovIejdea9ntstMZlvssC3QPxzryXwJc4i7YZESszSF4P373aBePjjMwYdFlrJgV5QVxL5nRVP1DpE8QRs9DOBVA9/HDQVw0ss9aw9Foc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1GPij6KCN+sNkf0WMiJM2OwbtSarBjwjfJxfDcFxSg=;
 b=ybbuQO8+2J1a1yWkHCNDXUZaoHBQzg1kr04hUhkPDjAli2ZAP/4298gJC3TWft5pzejlx72bPb9vRJ9Biptwd7RGmn8JG0CqbykCOf29NZpn2h48ffDU0FStQGoNWgZvguHrqFwi2Vjj+18WgPnaERBOLqXdsZvFG2b0LlupAzEC/RgxKCZHICWr/7Sg00wr5TI9LPuHuqoPXpGWewKwZSgBG8wrPnRtYpoXDT6HL2bu/K5BDJiacXT/aASL1OGQ8v+b8KW4SMWzCnC5Y6v0K3wNmPzuXEHFHhXsOfESOTqvV3b/pb7HcxV63nA4yWN8TH4l1zAYb4wojHcyM2j/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1GPij6KCN+sNkf0WMiJM2OwbtSarBjwjfJxfDcFxSg=;
 b=dzrH9WcvT1dcMtbL8OXHeYXqzdOlgaKm137r3eMZpKdOxF8U0UkHR/5ZnQ9dae55jfjYEt98335uQoHzPZhz7MAvDYLfw+pHM8jzyYCTBacZjZuaklmps8Jk+dLdvygjdCqptzSFHmm8icx8lNI/5EioW9d2DpMffU9epl9oG4zdFraw2cB0Z4EpaFU9wRmsGABVEkpe9diJppnGDxrQv+LbdZen+yDBAWXScXYnRJIXAH0bY6HRPrkkpKKeJHPq+hhqPiM4pBQ1768NIr0G30tPm+VZFWvpkczvtliJQ2mME3inGqhii1y90aPY5mWXjulkHH0GQkKLx8Vg7+Icag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:04 +0000
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
Subject: [PATCH v2 04/16] RDMA: Use ib_copy_validate_udata_in() for implicit full structs
Date: Wed, 25 Mar 2026 18:26:50 -0300
Message-ID: <4-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6ae4f8-2ffd-4af9-5271-08de8ab541f7
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EAzbti0WOudCFbmDQ6QZ5/5eW5tQp04gXVKRbREmp49IQjd+tCGLDvzseVsyBCLD7LXVO9k8JXTJFM1vXIf4Th41YSn3qo4qxzcXPuVUEWUXnawgJMaw1V6j83YcsXKWCGA17r2g/v5V1AdBYN2UPapi/n9MAwVdsKITcLqWJeU97C25HXfOjD1qsxEMcBIKg86ly6gT2xerWLL4okmrvYPed6HsoyfrAGZqyrNBQ7XCiZAyW1luv7MM19Q6XNLXvafU4UD2W6XUtJfMUlxRMIOjwZ/OlVv8VL2HNA5+aJUoswx0sFvzS0OrYMZVmaMCRa09BqzfLg6CbIdoBQkEtyERfETEZ1HSJdxzP9uZKwbPpzxHZmIqDvuhFv+qwGTknI65UmHSdW8LHSv9r7QA61JjUW4r38vMxWPet2RU53UsN0Cl8jyetidiQLHzF0CJ8NF8QjgYKja8kmy8sdD4TV2Ou665R6yLfTq7i6wE08j5A27VDNAL2DjWaDhMZAAfCCfiakh3Zax1O+m2YyNQEKXqGFlVNAcbBRd9ScD7VeRpSANyzFTpA9ksFnhLqyh9r9n4FfyR1cHIcYOx0SRurr0mne1BmHBuZJSYwS1eLM+DmNkyAId49JlUQ8doUyCvidLcjzslsoNFXO3O/YGRXn7YLzR76fxl1AoW5dX7qdlFAXojoVmMtCTDzmGtiR9b1NVBp694ugSMiXaENE+PqEAWerYkQNvvH0k2zFbdUidx8L2YBwwGO4rmGF6W6NkEyiszVXCBfUe+DZo5ygv5Eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ny+MIOhYZnV1EcxBauOSpjNMVRfGVtimboACM6y6gGozZDsWXuadE39ZspDT?=
 =?us-ascii?Q?G1zOybR5rwjuzXVpqfh8Y+toB4t7eVT13uXINuVCksk7tP6VnL/940hn6Ook?=
 =?us-ascii?Q?/u1tzU6WkdrKbmaM8QLTAkjAxUY9NvhnghGnQSOc/BJ5BXVgMBWW76zW3nTS?=
 =?us-ascii?Q?/Vvr8Qxo/AML/pbRrevw7P0oLdw0BFXQruKALWoi5hEASgHHbpVhv0DhjwRu?=
 =?us-ascii?Q?XNRQyvfPbOexZZ0/ieKxG0ZsdFxfwW5UYqoVAbjuuLYdWTQlf/XGU6C3leIw?=
 =?us-ascii?Q?WpKuhOvtzOMoHL/9bNv5YTvJzdWyUbdvdXHSw/IUaTQ1vQy+Al72XUpZMFMw?=
 =?us-ascii?Q?68VVEdfC2b+H5F0x0GGcVGSnRCa0KFvxFn8tjJF3cdFi59y/j3s2nI0P7B6K?=
 =?us-ascii?Q?cdHgOr5T7mXOm/Vf9M8+lcr4x2Wn5g90wolDPoK/VJUX9t/5yDCyueMyrl0K?=
 =?us-ascii?Q?01wLi/U8ayvnD3ghubGdd1OB/UNWrPoyHNJOW19Qe0NhzfpPEcxPkYRSdu4c?=
 =?us-ascii?Q?wWfLSLsGbuNZHIo8cHuRSLPbCOWkO7b4SjGwyC1QZ70E7uaXNlXVi4U8vvcm?=
 =?us-ascii?Q?XRj0pKFS9sM4VBZSYQZdNGh1uhgaQI6YXhuT0QYP7aYqBtNxCfq0+uisYNBO?=
 =?us-ascii?Q?vvzcn0gxX+fluotH+M5B85tNXJVVrJyFJ1SwOkSjZ4mwb2gX74ddw33sBk7I?=
 =?us-ascii?Q?x9yrVImZgxwSQOUqg85H/NBAtFr277VxTkEq8z2iU+4D7BQ2Ajdo1JiXMflx?=
 =?us-ascii?Q?j3/pdHkKuLCn6To3eoG0HW80srAAqCIQSoBOj3AnoKeK1fwmWc7q40PLBzL/?=
 =?us-ascii?Q?C9HeEDXvy0Sn7CgEA4eJo68ziv66/D1lPMASuOayYqoo3a4Xy/wzs0Cyc6Py?=
 =?us-ascii?Q?8VtRMgxEDxMPF6t6W0RV0+pzBRncVZqd5kyKO9EdEUUVSBe38oUOkCip6rWb?=
 =?us-ascii?Q?303Tg6kcoCAMJ3/ZP1f8ulNFHavVXMbbaK8vhQU2w6h0ZTdfWGU7p33YuKUK?=
 =?us-ascii?Q?4Sh13uOWSejRbOfl2npl672FNaOe3I419TRgSHtMcebkwYDhPxE5AyvfaNL2?=
 =?us-ascii?Q?i/WDTu7EsJt4qnIYepFupV1B00CRB9LvuSOGck/El7W4WMIi1upE0/EzweeD?=
 =?us-ascii?Q?TTHLwpNEaLFroG0TjifNayGlXuUp1jWxqMpvb/5EMCqBQWSXggXVC/5i9Ftg?=
 =?us-ascii?Q?fr9jO/hH0T444q0HgamyZhCjhbRtkjbxSjvjrzcp74ZyEKELp1JXnCDHtDNa?=
 =?us-ascii?Q?U4URPA9EyzLJShcekPQwc6olHv0jBxXSHw94PhIE0qBgHcOfBDNSroL8YFgq?=
 =?us-ascii?Q?9v0QuH50RovXgJubb7OeUi2ZtIeMFZZW0auVZmGXgbWaj1IMLrnBx5FyMiDw?=
 =?us-ascii?Q?FkJ0NtkzQgJmlaaz6kJcDMrf1qHnjUFZcasIjbIjyhDUsWKeikiWFQCEyU0Z?=
 =?us-ascii?Q?jRpq1Aeduu9qRZ64CrBRSgE3N+Vr1b89EZDC5jEJlaQVVBEl75sPYdqE+JzD?=
 =?us-ascii?Q?dp0vHQufmtYe2pM24+OelbC3kx33cnqypiLw5sgmcirJOPXJKxVlxbjZETlx?=
 =?us-ascii?Q?h4lDVufycD3ZltC/nkCOM1oM+DxzDQ08BlJgnJh2Ft0hVVorfnOzimEd47GP?=
 =?us-ascii?Q?QxohOVMx1iLu4zIcGMxdURB+MVypqcFeYdiJOw7xm4krHFr2kKMEAOUGsmA0?=
 =?us-ascii?Q?1O+pRrEzgr0XkJS/YoQadasWY59lsdnI+7O3Eqx/NkdG6SDw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6ae4f8-2ffd-4af9-5271-08de8ab541f7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:03.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQvN/pzbzzkkeD23rJf5ac4V4+uhy59rytTHFVBtJS3v+mYA3tKHCPNMOVwXGfpa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
	TAGGED_FROM(0.00)[bounces-9782-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 8679032C746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All of these cases have git blames that say the entire current struct
was introduced at once, so the last member is the right choice.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 ++--
 .../infiniband/hw/ionic/ionic_controlpath.c   |  6 ++--
 drivers/infiniband/hw/mthca/mthca_provider.c  | 27 +++++++++------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 10 +++---
 drivers/infiniband/hw/qedr/verbs.c            | 34 ++++++-------------
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  6 ++--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  6 ++--
 8 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 04136a0281aa4c..5523b4e151e1ff 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1039,8 +1039,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	qp->attrs.rq_size = roundup_pow_of_two(attrs->cap.max_recv_wr);
 
 	if (uctx) {
-		ret = ib_copy_from_udata(&ureq, udata,
-					 min(sizeof(ureq), udata->inlen));
+		ret = ib_copy_validate_udata_in(udata, ureq, rsvd0);
 		if (ret)
 			goto err_out_xa;
 
@@ -1980,8 +1979,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		struct erdma_ureq_create_cq ureq;
 		struct erdma_uresp_create_cq uresp;
 
-		ret = ib_copy_from_udata(&ureq, udata,
-					 min(udata->inlen, sizeof(ureq)));
+		ret = ib_copy_validate_udata_in(udata, ureq, rsvd0);
 		if (ret)
 			goto err_out_xa;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 4842931f5316ee..cbdb0ea7782a49 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -373,7 +373,7 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	phys_addr_t db_phys = 0;
 	int rc;
 
-	rc = ib_copy_from_udata(&req, udata, sizeof(req));
+	rc = ib_copy_validate_udata_in(udata, req, rsvd);
 	if (rc)
 		return rc;
 
@@ -1223,7 +1223,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int udma_idx = 0, rc;
 
 	if (udata) {
-		rc = ib_copy_from_udata(&req, udata, sizeof(req));
+		rc = ib_copy_validate_udata_in(udata, req, rsvd);
 		if (rc)
 			return rc;
 	}
@@ -2152,7 +2152,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	int rc;
 
 	if (udata) {
-		rc = ib_copy_from_udata(&req, udata, sizeof(req));
+		rc = ib_copy_validate_udata_in(udata, req, rsvd);
 		if (rc)
 			return rc;
 	} else {
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 6a0795332616dc..7467e3dff7ebb8 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -402,8 +402,9 @@ static int mthca_create_srq(struct ib_srq *ibsrq,
 		return -EOPNOTSUPP;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-			return -EFAULT;
+		err = ib_copy_validate_udata_in(udata, ucmd, db_page);
+		if (err)
+			return err;
 
 		err = mthca_map_user_db(to_mdev(ibsrq->device), &context->uar,
 					context->db_tab, ucmd.db_index,
@@ -472,8 +473,9 @@ static int mthca_create_qp(struct ib_qp *ibqp,
 	case IB_QPT_UD:
 	{
 		if (udata) {
-			if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-				return -EFAULT;
+			err = ib_copy_validate_udata_in(udata, ucmd, rq_db_index);
+			if (err)
+				return err;
 
 			err = mthca_map_user_db(dev, &context->uar,
 						context->db_tab,
@@ -594,8 +596,9 @@ static int mthca_create_cq(struct ib_cq *ibcq,
 		return -EINVAL;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd)))
-			return -EFAULT;
+		err = ib_copy_validate_udata_in(udata, ucmd, set_db_index);
+		if (err)
+			return err;
 
 		err = mthca_map_user_db(to_mdev(ibdev), &context->uar,
 					context->db_tab, ucmd.set_db_index,
@@ -720,10 +723,9 @@ static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *uda
 			goto out;
 		lkey = cq->resize_buf->buf.mr.ibmr.lkey;
 	} else {
-		if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd)) {
-			ret = -EFAULT;
+		ret = ib_copy_validate_udata_in(udata, ucmd, reserved);
+		if (ret)
 			goto out;
-		}
 		lkey = ucmd.lkey;
 	}
 
@@ -851,8 +853,11 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		}
 		++context->reg_mr_warned;
 		ucmd.mr_attrs = 0;
-	} else if (ib_copy_from_udata(&ucmd, udata, sizeof ucmd))
-		return ERR_PTR(-EFAULT);
+	} else {
+		err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	mr = kmalloc_obj(*mr);
 	if (!mr)
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 7383b67e172312..8b285fcc638701 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -983,8 +983,9 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		return -EOPNOTSUPP;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-			return -EFAULT;
+		status = ib_copy_validate_udata_in(udata, ureq, rsvd);
+		if (status)
+			return status;
 	} else
 		ureq.dpp_cq = 0;
 
@@ -1312,8 +1313,9 @@ int ocrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 
 	memset(&ureq, 0, sizeof(ureq));
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-			return -EFAULT;
+		status = ib_copy_validate_udata_in(udata, ureq, rsvd1);
+		if (status)
+			return status;
 	}
 	ocrdma_set_qp_init_params(qp, pd, attrs);
 	if (udata == NULL)
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 2fa9e07710d31f..42d20b35ff3fe0 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -273,12 +273,9 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 		return -EFAULT;
 
 	if (udata->inlen) {
-		rc = ib_copy_from_udata(&ureq, udata,
-					min(sizeof(ureq), udata->inlen));
-		if (rc) {
-			DP_ERR(dev, "Problem copying data from user space\n");
-			return -EFAULT;
-		}
+		rc = ib_copy_validate_udata_in(udata, ureq, reserved);
+		if (rc)
+			return rc;
 		ctx->edpm_mode = !!(ureq.context_flags &
 				    QEDR_ALLOC_UCTX_EDPM_MODE);
 		ctx->db_rec = !!(ureq.context_flags & QEDR_ALLOC_UCTX_DB_REC);
@@ -949,12 +946,9 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
 
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
-							 udata->inlen))) {
-			DP_ERR(dev,
-			       "create cq: problem copying data from user space\n");
-			goto err0;
-		}
+		rc = ib_copy_validate_udata_in(udata, ureq, len);
+		if (rc)
+			return rc;
 
 		if (!ureq.len) {
 			DP_ERR(dev,
@@ -1575,12 +1569,9 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	hw_srq->max_sges = init_attr->attr.max_sge;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
-							 udata->inlen))) {
-			DP_ERR(dev,
-			       "create srq: problem copying data from user space\n");
-			goto err0;
-		}
+		rc = ib_copy_validate_udata_in(udata, ureq, srq_len);
+		if (rc)
+			return rc;
 
 		rc = qedr_init_srq_user_params(udata, srq, &ureq, 0);
 		if (rc)
@@ -1860,12 +1851,9 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	}
 
 	if (udata) {
-		rc = ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
-					udata->inlen));
-		if (rc) {
-			DP_ERR(dev, "Problem copying data from user space\n");
+		rc = ib_copy_validate_udata_in(udata, ureq, rq_len);
+		if (rc)
 			return rc;
-		}
 	}
 
 	if (qedr_qp_has_sq(qp)) {
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 16b269128f52d3..615de9c4209bf1 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -476,7 +476,7 @@ int usnic_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	if (init_attr->create_flags)
 		return -EOPNOTSUPP;
 
-	err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
+	err = ib_copy_validate_udata_in(udata, cmd, spec);
 	if (err) {
 		usnic_err("%s: cannot copy udata for create_qp\n",
 			  dev_name(&us_ibdev->ib_dev.dev));
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 98b2a0090bf2a1..16aab967a20308 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -49,6 +49,7 @@
 #include <rdma/ib_addr.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "pvrdma.h"
 
@@ -252,10 +253,9 @@ int pvrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 			dev_dbg(&dev->pdev->dev,
 				"create queuepair from user space\n");
 
-			if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-				ret = -EFAULT;
+			ret = ib_copy_validate_udata_in(udata, ucmd, qp_addr);
+			if (ret)
 				goto err_qp;
-			}
 
 			/* Userspace supports qpn and qp handles? */
 			if (dev->dsr_version >= PVRDMA_QPHANDLE_VERSION &&
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
index bdc2703532c6cc..d31fb692fcaafb 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -49,6 +49,7 @@
 #include <rdma/ib_addr.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include "pvrdma.h"
 
@@ -141,10 +142,9 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	dev_dbg(&dev->pdev->dev,
 		"create shared receive queue from user space\n");
 
-	if (ib_copy_from_udata(&ucmd, udata, sizeof(ucmd))) {
-		ret = -EFAULT;
+	ret = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	if (ret)
 		goto err_srq;
-	}
 
 	srq->umem = ib_umem_get(ibsrq->device, ucmd.buf_addr, ucmd.buf_size, 0);
 	if (IS_ERR(srq->umem)) {
-- 
2.43.0


