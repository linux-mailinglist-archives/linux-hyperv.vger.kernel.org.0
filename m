Return-Path: <linux-hyperv+bounces-9788-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIg3LFJTxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9788-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4C32C700
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B18F3027EF3
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35F738F651;
	Wed, 25 Mar 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OWNqDxEs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E4382F36;
	Wed, 25 Mar 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474045; cv=fail; b=AZBjzv29GSkaIAh8Zb6ceWO/IrXbr1bR7ZLJaqTNQmWOWcHyNHoX/xlmPWLQEsTWCOJWWTwDDWn3IYcdCTdkMogl+1H2sy10OQ0dhidm+ZCEOnNd/aBDDMOn28gtpJdyh9CmEBCHAYt2iqlZo1SGuccrchd6GpvbEybK9Uu1bhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474045; c=relaxed/simple;
	bh=NwMS4UHMNMlXktY8iQkCAV3nAUceiddhx/I5myemDnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XE3RbbWAiuUqzAIWiHnOAsHUtsSNRNTGStpFHGvUCMyEY6xKKAy6BTSe8Rt1mgp8h7K925sCDPJ+krS0L5mWUahKVtKX85lOZ+YlPh0M+B+jXjBiJDC9J0Zx6k5Sy8NwER6TjfHgNyO+/nLJu0BpY6cQ4vdWjLv+AI0EmyFIxSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OWNqDxEs; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQrKqP7Ckw5qkdNAGU24ewFXQlLM6HMO7JdpYAzCuN3BhiglqFZTKhEUnaG4aS9Qg0zCeZPpHGJxBB4o27N08KHPdFIBkczXStaG7aFSPDfF4H18cXg0kHjfTiu6utFIwFgsB/+gGSuU3if4HLAoOIxk/F/uAhM76nLtWWl0Duje+5VyKSGCA9tvq3XY6JgIqHGNSexlQPYj2k+o2x61g0WtS7vGBwJDZE0fHyfudFbmZEQx8dStJjOaSc9NnvOU4lAaApzEmnUK/VGzfRGjIoKnOMnxvB0HEpDjYh72fOiBdysWlRMFQ4SctlbhjRs2gZthbcwybo+PMGExmbSj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot76/NPFtS9qwKfYIK1ov6lNZLCrhIrUQWQCMVD/5MI=;
 b=rgevrrhlNYO8xCVbU45UHKOMAadQquDcAVXu/PsB+4yY3dgfLq0RF3ExdzrpkiF/7twmvJ1GzDk3zi+/d8hZStpmR1SC3wuROC3TkN9K730qCFqNCctdj8JHpC023ZM+BLksHu7Fx3Z2ed/ITwQUnxYPnXeXpH8WNnaidoSoLBK+DurJFjLHDS3xrrnpQmXmcoXIeZc9MCIYBQ7vflSZaSkW+y1dhec1UyhZlqiSlEeN6aZXWD5cjMvcf4tsVeRp++PR/r8A7MQsRJect7MmniHZm/fdVGVfBlx9bG4jSCUll9WJPmWrsi6EK9AA0kLLo26wZ+0VbKDJDf1zQXOipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot76/NPFtS9qwKfYIK1ov6lNZLCrhIrUQWQCMVD/5MI=;
 b=OWNqDxEs2xi2Vf6oZBODHHZZoJRRWA3KEFiNNKlKVme9DLaKvMkf3jTR9h/qm9fFXeXpep7vtm39znOJ6jL9gwUztud/kZvLxGhHvtOWP7tk3tA2QB3JZzl9qUwEX1x9Gz1LKlvwScYGNyZ3T+A3pzeFPl747rdpsk5BEWQXYIN8J+PWSooRzmOpG/ileitHSsY09LG/+X5aw3inHU+l1DCSs9TxUIas5gRdgT3f5/89bIwIFiLRrSCxufc0N63oqvhGvpuUgDIV5GS7hCsS8ku79SMzDQQaWY1hHKtFti4JcyS0QflB7Z/SMftYtgqv5J4m6HfKaIomAB86NabAlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:27:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:09 +0000
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
Subject: [PATCH v2 03/16] RDMA: Consolidate patterns with sizeof() to ib_copy_validate_udata_in()
Date: Wed, 25 Mar 2026 18:26:49 -0300
Message-ID: <3-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e809a74-be9f-4f48-79a9-08de8ab5434b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6D4AKGJbJ5iyh6WZfzHtlpl70mEH4IBAC5TlDlsYFWmIT3glHdFZa0yd8lTdwsh7TFFc5sFf3dGih0dQFzpWNLpHA6TQ3zBX+X7mKkVjxTeEzxDX6jLZPe95W5RWtN5fx0KSFVei0q9UzEpi0t2zPdczDb8HJ5sNmlHk7Yny/3qZ9Xj1DAHlizleM6b1uVMbSZKmM0TDHITkdx7mK4O8yLJlGNwBxIMXWv9Dc5uXbsttJlIvMJ2jy4FbyXHUo3CjmDKukhI7u5uEOSP/W+z7BLOQmGx9OPHNrJJQaA2VAuM6y5ZJZ20+JfSChlsFVAQoCKzPyhRhJiDrfDVIdnvn31G8dYqVgAWfnMdcK2HLU5sKtMZMRqO8z8mOoXr6ZiqsKMqTPWiRiNKbCkQ+WlzCRCHxqQh6+zLNz1xr3PgPlElXFmbNUzNuqo55Qf3oz3HV3orjJu/7PiwYihn73JMhEwyLLW7GeMGK9DFSgDBny2Uv/QCRftojhDsaNFZkAmr+9yBSeWGE9vEQ0xBCFYukExv6i7e6CW9zYHWNiL4NOaCfd8e2Oki8qLPY0PsNGIo/NNU9mKZPLUNbcz4AJ7fPaGS6bzhlXYzKFx2bjc96Q+Bdj2YOLX9MM1yUsMc8B9M3Byi8q/bI+6AOu5amgTsW/h+rjfbVULrHbUWckW98hQaa0S8UvkS4IjcWY1S4ItU7QLXiiojzWk95jDDk3t98ABvxBPGAXRq50Ndq5fr9iIOOdVmD1q6jlAUCGjfRkIpFYP4EysYXDWxC7RwCseKIzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lBkEHEhpwTw1+nbcojwO7XK46ex5pVxih1UcPvJpuzcDixX1k8JKC+aj+gul?=
 =?us-ascii?Q?eHMcL7V5iaSsVkQbJRDbEwoFbAouMAvf0dzpCZGvSJCDgN5khg7NtjkukAot?=
 =?us-ascii?Q?NIbB94YgPBz1vYh/YtMuvB2RL6sKxaHUv8TSlvUA0Uc3A0kYA24o3MqCOXlP?=
 =?us-ascii?Q?7mjFx7v48ey/41Tmz25DtXnEAxiEUCF1z8twwq63+eNf7IbK7Q0OALqkN5WF?=
 =?us-ascii?Q?3akph0VO+D/EM7LPTbUXrxmjFcNvufRVW4UVaKoa6PX8LYx1qXsqgwww2FZY?=
 =?us-ascii?Q?oUvoclBkBqEAUytN9BvkZ4SrmTRXIfL+KnNJ3hkTAWEpFnMdlHign22Q5nZK?=
 =?us-ascii?Q?JkquEmkWj0CsqUXhd//kAoMgamwO+EyxWSHLpcUJo0TDLq27ss7fwOeP6Kky?=
 =?us-ascii?Q?NqhFpGhqY5rXrGO6n9vc1D/tp/fBJ1OFMrmoieQtWk/AXLMXBxH4m3thDAR+?=
 =?us-ascii?Q?eqVxYH26ffz5PMrc2wrl7bik/46mYOn5VHg+YWVRI1YCbbfZuGiy6f3r3nJY?=
 =?us-ascii?Q?DNZzf3UpCNbJcONwGHE+FhPIMqXmNuzWxGxXsln9LIWLl6kwHLk5lYMhEkL3?=
 =?us-ascii?Q?iE/NMIOC3pVkTt7hmy8WI+LeQBzQSv0bsmFW6OwaPi9Jr7+oCZ0WmcKrKbJE?=
 =?us-ascii?Q?fZn8LsrN0scRyhqECpXoMEuskBTl4j2WwRVz+sThUw7oOGsWAG5Kk1HBh7yG?=
 =?us-ascii?Q?/AP/w6nV6pZ7uOFIKOzwx6B0nMYiqpGVn7sYCQhjxe8TALpWYuDBJU600DHp?=
 =?us-ascii?Q?G6xip07t3FU/sYddvniX+M7aULiTzmhen5RvQ1ZB1gEwLlnCDCJRkwjgx1kq?=
 =?us-ascii?Q?uH3JUBWtvfYu2hatXFMoBLR9s855lh05bkM+Mm0xLppulytn0ELgkDnhVOG+?=
 =?us-ascii?Q?Mk69jVHDwy4RoVqIEbLcP3S3Di78NFFqUUlPRlHvkzBPVWkQ4bAFKQ5OVTy4?=
 =?us-ascii?Q?82Qn+oBAWbJyg8Bdr3lsXp68IgOKUfOHtv72gnQ+04B8k9Bb5BcsZWPnE7/U?=
 =?us-ascii?Q?BdQvx58KvR00AT9ILzb0RX3pDonnrJOMMKOEvx1ZQRVcedgIG13pqMkwlRJM?=
 =?us-ascii?Q?QMAMSYeGsu0TyHOvtpZyBzABY5b1G09zbNrfvRVkiXZKQUHhGdHtUd2HAUiF?=
 =?us-ascii?Q?uqQlOXvlcm5xzDjBZfj7/S240hI9u/uMGIRQ4ZvRc5kxT31/KAEY/x+dbk6P?=
 =?us-ascii?Q?3mHbBuSzVdNL9I6ImV8vRV25Winz/i30J6ps14HHLUae+8Os00+ciAwSboR1?=
 =?us-ascii?Q?e+a5uml82Uxle+khcPljpkKSYB3v11RPI1qBoExiv3a46iMu9bKnGfZN4cz8?=
 =?us-ascii?Q?ug/ZmYvrtnA+KAup7oTFV5TDtfPe0+UZTBy6wLyeL1kDTHcxXmc/UAr4eWfh?=
 =?us-ascii?Q?BryKeUAUkyWDainzFh3ZmVSYFJDM6aaf8+B+azXuYG2SBpB9aCosPmnnJROh?=
 =?us-ascii?Q?JsiP7hddNgwixnvT3TJXIqDVTINWaxkQPp3f9jBvWVqtDzQ/iTqpbAYa64mI?=
 =?us-ascii?Q?5UOm8jSpA4gkwH2+IiANZnNix/8LlB+8M44wZn9n9Ii6lpO18VEpxLpmLWW4?=
 =?us-ascii?Q?y0NhuD2+bnXN6HIKa83TRTRq2uzn3aA94ghv86q8Zks7KJT4nrqS6bziN/P6?=
 =?us-ascii?Q?kitWNvyvLWJzUv3mIJmLWkQn0B3IvHNzx8yBoeI6K963IHiaPbXVwN7hpvwn?=
 =?us-ascii?Q?pT6jy1F0Z7GmI1PGoAF1kLLbTT++p0j3iFqrJaYBRM0I0yd3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e809a74-be9f-4f48-79a9-08de8ab5434b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:05.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDO8jVzbLY1Srq1vvCh2uksYicMej3wA/QgAIoXl0p5BlW6Ce7/jtteYR1+0o6xu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9788-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: BBB4C32C700
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the prior patch, these patterns are open coding an
offsetofend() using sizeof(), which targets the last member of the
current struct.

Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/qp.c       | 27 +++++++++------------------
 drivers/infiniband/hw/mana/wq.c       | 10 ++--------
 drivers/infiniband/hw/mlx4/main.c     |  6 ++----
 drivers/infiniband/hw/mlx5/cq.c       |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ++-----------
 drivers/infiniband/sw/siw/siw_verbs.c |  6 +-----
 6 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 82f84f7ad37a90..69c8d4f7a1f46b 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -111,16 +111,12 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 	u32 port;
 	int ret;
 
-	if (!udata || udata->inlen < sizeof(ucmd))
+	if (!udata)
 		return -EINVAL;
 
-	ret = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (ret) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed copy from udata for create rss-qp, err %d\n",
-			  ret);
+	ret = ib_copy_validate_udata_in(udata, ucmd, port);
+	if (ret)
 		return ret;
-	}
 
 	if (attr->cap.max_recv_wr > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(&mdev->ib_dev,
@@ -282,15 +278,12 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u32 port;
 	int err;
 
-	if (!mana_ucontext || udata->inlen < sizeof(ucmd))
+	if (!mana_ucontext)
 		return -EINVAL;
 
-	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to copy from udata create qp-raw, %d\n", err);
+	err = ib_copy_validate_udata_in(udata, ucmd, port);
+	if (err)
 		return err;
-	}
 
 	if (attr->cap.max_send_wr > mdev->adapter_caps.max_qp_wr) {
 		ibdev_dbg(&mdev->ib_dev,
@@ -535,17 +528,15 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 	u64 flags = 0;
 	u32 doorbell;
 
-	if (!udata || udata->inlen < sizeof(ucmd))
+	if (!udata)
 		return -EINVAL;
 
 	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext, ibucontext);
 	doorbell = mana_ucontext->doorbell;
 	flags = MANA_RC_FLAG_NO_FMR;
-	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev, "Failed to copy from udata, %d\n", err);
+	err = ib_copy_validate_udata_in(udata, ucmd, queue_size);
+	if (err)
 		return err;
-	}
 
 	for (i = 0, j = 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
 		/* skip FMR for user-level RC QPs */
diff --git a/drivers/infiniband/hw/mana/wq.c b/drivers/infiniband/hw/mana/wq.c
index 6206244f762e42..aceeea7f17b339 100644
--- a/drivers/infiniband/hw/mana/wq.c
+++ b/drivers/infiniband/hw/mana/wq.c
@@ -15,15 +15,9 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
 	struct mana_ib_wq *wq;
 	int err;
 
-	if (udata->inlen < sizeof(ucmd))
-		return ERR_PTR(-EINVAL);
-
-	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
-	if (err) {
-		ibdev_dbg(&mdev->ib_dev,
-			  "Failed to copy from udata for create wq, %d\n", err);
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved);
+	if (err)
 		return ERR_PTR(err);
-	}
 
 	wq = kzalloc_obj(*wq);
 	if (!wq)
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 73e17b4339eb60..16e4cffbd7a84d 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -50,6 +50,7 @@
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/uverbs_ioctl.h>
 
 #include <net/bonding.h>
 
@@ -445,10 +446,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	struct mlx4_clock_params clock_params;
 
 	if (uhw->inlen) {
-		if (uhw->inlen < sizeof(cmd))
-			return -EINVAL;
-
-		err = ib_copy_from_udata(&cmd, uhw, sizeof(cmd));
+		err = ib_copy_validate_udata_in(uhw, cmd, reserved);
 		if (err)
 			return err;
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 643b3b7d387834..f5e75e51c6763f 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1229,7 +1229,7 @@ static int resize_user(struct mlx5_ib_dev *dev, struct mlx5_ib_cq *cq,
 	struct ib_umem *umem;
 	int err;
 
-	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
+	err = ib_copy_validate_udata_in(udata, ucmd, reserved1);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fe41362c51444c..c9fd40bfa09eb2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -452,18 +452,9 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	int err;
 
 	if (udata) {
-		if (udata->inlen < sizeof(cmd)) {
-			err = -EINVAL;
-			rxe_dbg_srq(srq, "malformed udata\n");
+		err = ib_copy_validate_udata_in(udata, cmd, mmap_info_addr);
+		if (err)
 			goto err_out;
-		}
-
-		err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
-		if (err) {
-			err = -EFAULT;
-			rxe_dbg_srq(srq, "unable to read udata\n");
-			goto err_out;
-		}
 	}
 
 	err = rxe_srq_chk_attr(rxe, srq, attr, mask);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index ef504db8f2b48b..1e1d262a4ae2db 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1373,11 +1373,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		struct siw_uresp_reg_mr uresp = {};
 		struct siw_mem *mem = mr->mem;
 
-		if (udata->inlen < sizeof(ureq)) {
-			rv = -EINVAL;
-			goto err_out;
-		}
-		rv = ib_copy_from_udata(&ureq, udata, sizeof(ureq));
+		rv = ib_copy_validate_udata_in(udata, ureq, pad);
 		if (rv)
 			goto err_out;
 
-- 
2.43.0


