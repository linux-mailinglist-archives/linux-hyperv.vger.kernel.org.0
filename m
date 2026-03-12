Return-Path: <linux-hyperv+bounces-9330-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCO1F8gHsmkCIAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9330-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7826B997
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 01:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4AEA307A0AE
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 00:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48A32FA2E;
	Thu, 12 Mar 2026 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JgBb8jx4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F232D0F5;
	Thu, 12 Mar 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275073; cv=fail; b=S+QT2cuUuYNRUPEfTthOK/C8Mye3ZRh5xLGOuMhCyj/4OwJWzJm1kXg2wf5l7PeYshW6dBZbZiUyKaj9JhU2jBzk8Pxz3WOWpq1rmkT6onbCweKrtS8uMZ50sgHzACVMrBlLqvmexEY6/dEebWqQ3+l2hG2fD4tqUbLShKopNK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275073; c=relaxed/simple;
	bh=Z3981UpPawLdLRo8q9k5oi4KXtugvs7vb/CHsbWFdeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OIxUXuEU4JPr9dMzmVXK9COo7H0FMznDGc0AFOpOiFds2IcUR+bsyiT2kv0IsxWpr05izXPneY4FKfkNaYdRZsqCYQcSuujoX8VpQu8jviCji4Xs4M2HjlKIj4kp5tGNl+9EZa45Jn1WL/XgAzzUUdLDm7mx7du7ZaCLkOU7lro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JgBb8jx4; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6l626E4yglpJxn/cA9eepKwPsM4FygRQCr9GiHJmHhqNk0INdTZUl34TkUnLsg2Xz4POKSH8jL4TCLedTyRIWxSZwN4W4DXPktv3nP5AO+PcxCf2A30AXSySaN16u0huYmAsjrtnzHnpFgEq3rLZoxKevgYrA0ViqNRYnrdrhu9BvVDVft9VeIHkI+KAthA7PyewiFKXYTUVFwcKVOBYFP7YW/61ovTlwrVkZYOoc6c+Dg/uHD8ts/16V7EfSUoCxaonX1yXXxzNVr0ZjTd3VPWNoUEvZk7u4LrziVk9Cu+tgJ2qyXaogjMYqf0v4lrMx1GYqGsaRhCjFvYJ72xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2RS0JQBqPFdufP0F4P4JpB4bAu2ArGz507iJLQqz14=;
 b=oz3k/aYcZbH8Y6N8yE1SStITK1ukk3cNGngash9gTn1XgZwt5pm4DS/au4ktNN5uVJtLCn691OIIxzqOlRXl8wln6iNPWJGdkQUtNSgKavZFCOcWzIaZSQ0Sbjf14dwwW4J3truMfTQ+YLsDTJER34nuejHxK4KNAa81fCEZ/s0KoIX1WSHPveWBjQGtBBetbR2t5UnRdZO5QtCBeewTV91jJhv4IL6tak3njRK0jAtEfDCNLYdEj8BKSDXwLqPX71uFghsJYHUQ1/kZOlKw8fQNp46xf6gvyjT3JYP5Hy07zCXvTOM1uuvEyR7uAxNbUw8dhIH6cqm5qeQMmCuwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2RS0JQBqPFdufP0F4P4JpB4bAu2ArGz507iJLQqz14=;
 b=JgBb8jx4pdv1cm9Qd+TRV/kcyppgogYN3217JfmDZ/ml496I+08Q0ljzP+9uXpr3E2h+HBfc2dBd4oQHQdVoJshbZ8SOxK4UZ765KgzkQAtx4dv6eHxYkbiHx9mDS9DDZ0PW7X50wujISlRf37mVnxTLiS4FO+kQ9nElImJaseksbA0u9u6hIYB1/XQPKqbmcT+iC2XVafUydWB7A4myICvUZAoyTHtzN7hc30Q279/DV0vqhTcrGJQE1m58NiA7HJBLVJDxkS4O6n3lPdnbjKpKV2OTzurfGpMdy4LoSW8QxV3ebp0XWNl5gzmbL9sbsyhEg59jwPGqnMzEehhy3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 00:24:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 00:24:25 +0000
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
Subject: [PATCH 12/16] RDMA/mlx5: Pull comp_mask validation into ib_copy_validate_udata_in_cm()
Date: Wed, 11 Mar 2026 21:24:19 -0300
Message-ID: <12-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 4002bc6a-6c4d-4d40-be46-08de7fcdb699
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R8RRNc4/jY/7ZZ3NPcxzV+Jvk5pbRX8HsaYuoH0ZvCwzgewZHSV1zWBJtgEV0vRntwS6u/2vUdhJZ2TLLpnu3/sNGQLIp/+L0Dan7kwBSYWZg+cWZi1gIDaPc6kUcNlSxC4wW+mxwTX8y+ii8HuymDAnLxhNJEDb05SS23VPrjYhLGhk5hBB/HpIae7zGrtebrZxPfhLxNV1yYr1u19cm5xLuDMsDfnL4abIqukVLPupS0zjVJ/CWlHOXhzZ9hxXuIyp9vAAGyfORTkygxQz3mAlqoNgwFEiMWOfN0ftZRY5jnVUbyw/tE0mV52i9bN6h+nB2wWmOBSRq9YK1PqtEoIaAnS6sFPc28bvYZSCQYAZj5m7i1zpgd4tkxaZhSLZaiXRjbtJo8C2OXKiOqfFJPcTYJJGqoVIYFfns/CWEEBPmixcZPra3cI11sZz4AvS0nKjjEvS6Kj7lWxzq35sGerfSnKWRiPLYBNo0YI7BGZvf+p3fLkxOkRZxdt23fSGRlK7w3wbxqgwYPrrbsdYpqAZugCHm7Tov03zNksLzIGYyXbvUXfUCUPSlZzWGR+qNNbyi4j1go/eqNytB2MCSm3bAs3n4du0OzDcrqFut1StEEbrPuv789uedx7qJChbtZ1GmWgcsEes+SQzf+CNdz8M1h8Tai3+tzXz+Y1o/UtxV9C6iQVr9DxxdEw4ML0cm9wu/cJcgecs6Op6zcZDuodlgR7ADseWit8OGtMyjUoo53ZZM5oaKHo+CPbXnB2yeTEW7wJU5MvlfMY63wU2wA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpS1QvYbBvrXjaX7B68dtZRVRCndCNdohobp8QvvVspQro4hy9/kpVGDZ6n1?=
 =?us-ascii?Q?t2ySO65n9XefNMX5GILHOqdmwWel7rMaHik9rkU6/dc64Qf8m02VGHwz+oF5?=
 =?us-ascii?Q?fbmLLh9w5qpw8MYLMF/bev/SrzsP+EJM9VyeK20VsqSLfGWgOdaZijPg3rwO?=
 =?us-ascii?Q?iFXla8Lphk0zfO9Ox6fgZbEHoZURwViUpxZ+dyZOMH8oh6rpDLY/VBgza387?=
 =?us-ascii?Q?mlrKS9FNeHEi5v6w9xlABaPQffJRBMYcbAYIssnv8e3SJhBbUFBm1p6ehmjZ?=
 =?us-ascii?Q?YT7P9gU364JdGmT2a6HSyGYG/nGi6uml+8cvNHZpxw+gd9KN316xTMjoNVsT?=
 =?us-ascii?Q?nA8Pkg2Atf+5qDW8AUB/qwv/MnT6RCd14YHsmILIySH1knbZn2IEgIuWDEAe?=
 =?us-ascii?Q?akc2r0zr8G00kdep2tmVxA9Y85+I2z95dh0r/flYMhmynwdHZz04OzWGlCwZ?=
 =?us-ascii?Q?tVCgg/v2wXjVKIysFoLmqrcARGq1iyrJ0CJSRGqkZRcJOU4FfqOxnXIOvx3W?=
 =?us-ascii?Q?5pj3tVEbNjoijNovMHCsKsUkfeGYgEbHtrVuHTMGouKRo8WDlx7MU0HooEuF?=
 =?us-ascii?Q?rytSYVDgpXOhppdDQvP/ZadG+p8dPQOyLa2oqm8ZfdrmPL67Bg1CwcJ8BHp6?=
 =?us-ascii?Q?496X7wbq5Ft3lBnUmbjfAefypcxMa/rXE+Cazv+UK2ZHVuLPvF9QdKiu61j5?=
 =?us-ascii?Q?n0xt5UJCdIJgRoRhSrbhISdIAJQyTDlgrdl8i9Cxe8Ulq17PZXpySvcTVGse?=
 =?us-ascii?Q?rTpRlSjzaQ1xZcpuVEWaUQduIKGFr3BVDYKjPn8TVNTFirjg1CN9yYOv81R+?=
 =?us-ascii?Q?fSuV9s1JFihQs5vyBe173o/UjeWhto5hVXVS6tfjTJFYnDJmsZoiWEnljNL4?=
 =?us-ascii?Q?Az6VUi/WRZxnWkFYBMFl8+H/jRkNNRRlL3D7kC8yht1gTDTf10cQzF4dqgRu?=
 =?us-ascii?Q?bLwTDYUFU71vRlhVq3eGD3F7BgpNGfgHLvfmPbLtwZWx9kcVBxSRbucZrXA/?=
 =?us-ascii?Q?T5AYPe/6cMvficp4etKXwAiyYV0sUOz4Cc0g0DmjX06Rui2ATnV/3UN+ONsZ?=
 =?us-ascii?Q?hqBHo1Rl1ySwC9voRUIXPBgqcPyHxzWBoFOBawP30M1BbD5Q8EW1tu3x5JJt?=
 =?us-ascii?Q?F1UIdfSfMvc1SE3DxYSe6WKXcqNvfLc5fjxipWt7suCn2laGyEQr/Tgdrx3x?=
 =?us-ascii?Q?fMWlkofFOkvok7lCJwqbJ/V3rUSlVhIO+6e4MQqa2Lc+pUWAde5Zwz5l9IRX?=
 =?us-ascii?Q?aMDPb2OvS2a+qYwWMiuIBGc83otBWLLB7oUx7HXJBbv8//JTtraMuUeG+CH6?=
 =?us-ascii?Q?uyU8nPQYFhuiymmFOsDtvJWVYoTRpH49r9z/6GJLBF64s/R7+lb2ssblpDzP?=
 =?us-ascii?Q?p8AJm7GQA2/f2W4oW8qEzRNuXQzFoHGSFRx1mY8no1YosGspT7aocQrTpL0k?=
 =?us-ascii?Q?ztl18OLXaC0DZzIuVlhcQaX5myBaHQouEAKyDP2/HVVNfekdroYuHSp1kmbv?=
 =?us-ascii?Q?oOnB2n+FV+iINbIZbsNVZarxs2UYltb6Gcc3UPBJo3H+fzsBJ9Dvg5S6TCFy?=
 =?us-ascii?Q?6T1WJKvfHFVGxpkYSw+LTW1N94EoBj490fsXtczVrX4BnrujXJ9Y2RSSdz9Z?=
 =?us-ascii?Q?Wql2234VzwMSSbfLsRv116R5hTnrLVTaAJbS/8iCX99AUSJwEg5hIGJ3N/7L?=
 =?us-ascii?Q?d152jlBL/I0jllOUGx99xG8Ahgmf+yZKMtbfYfZrHbNKG1dcUIzBEVaQzqs7?=
 =?us-ascii?Q?Po0ZGZzhdQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4002bc6a-6c4d-4d40-be46-08de7fcdb699
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:24:24.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2+/FuAAr46XufWlMePSIwWMH1qGXrjnQu+DsbicF4w7LNfuzKffqeGDghGfqJaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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
	TAGGED_FROM(0.00)[bounces-9330-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 09E7826B997
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Directly check the supported comp_mask bitmap using
ib_copy_validate_udata_in_cm() and remove the open coding.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 68c6e107747693..3b602ed0a2dafc 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4707,12 +4707,12 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		return -ENOSYS;
 
 	if (udata && udata->inlen) {
-		err = ib_copy_validate_udata_in(udata, ucmd, ece_options);
+		err = ib_copy_validate_udata_in_cm(udata, ucmd, ece_options,
+						   MLX5_IB_MODIFY_QP_OOO_DP);
 		if (err)
 			return err;
 
-		if (ucmd.comp_mask & ~MLX5_IB_MODIFY_QP_OOO_DP ||
-		    memchr_inv(&ucmd.burst_info.reserved, 0,
+		if (memchr_inv(&ucmd.burst_info.reserved, 0,
 			       sizeof(ucmd.burst_info.reserved)))
 			return -EOPNOTSUPP;
 
@@ -5381,17 +5381,16 @@ static int prepare_user_rq(struct ib_pd *pd,
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_create_wq ucmd = {};
 	int err;
-	err = ib_copy_validate_udata_in(udata, ucmd,
-					single_stride_log_num_of_bytes);
+
+	err = ib_copy_validate_udata_in_cm(udata, ucmd,
+					   single_stride_log_num_of_bytes,
+					   MLX5_IB_CREATE_WQ_STRIDING_RQ);
 	if (err) {
 		mlx5_ib_dbg(dev, "copy failed\n");
 		return err;
 	}
 
-	if (ucmd.comp_mask & (~MLX5_IB_CREATE_WQ_STRIDING_RQ)) {
-		mlx5_ib_dbg(dev, "invalid comp mask\n");
-		return -EOPNOTSUPP;
-	} else if (ucmd.comp_mask & MLX5_IB_CREATE_WQ_STRIDING_RQ) {
+	if (ucmd.comp_mask & MLX5_IB_CREATE_WQ_STRIDING_RQ) {
 		if (!MLX5_CAP_GEN(dev->mdev, striding_rq)) {
 			mlx5_ib_dbg(dev, "Striding RQ is not supported\n");
 			return -EOPNOTSUPP;
-- 
2.43.0


