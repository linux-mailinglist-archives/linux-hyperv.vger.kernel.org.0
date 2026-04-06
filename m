Return-Path: <linux-hyperv+bounces-10025-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNKuDUTw02kjoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10025-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951673A5C56
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DD5D300B8D1
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DE3932F0;
	Mon,  6 Apr 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJQy9lrK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD3391514;
	Mon,  6 Apr 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497258; cv=fail; b=CztdeWezjKzeKgfGG6gpqBo66uY8ovtxHVy4PhniV9cx5ql0FHBLfFmf9xxdpp1bmqRJ0mu1q7gNEc7BA2gAYmwdBVku0dqqM8zoAjoa2hApp8Q+pRKGOSO2Mi+VVilhMdjGqSRwHhhp4aOnME+6Qn0wtRXX4bwOfQaqghyQdTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497258; c=relaxed/simple;
	bh=Wxx/Hacxx/mTqEyGamd8QF5UwwQbLtqQhG+aHiDHCgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0EIGXwkuTXPSx7q+H+oZ4Ap5TMZ2D0nLCCtG65ePN8LhuYgtyBg2usu6f+clD6eGzDeoRQGlw3lc4GEaQAyGtkPL5V90XI37z1BWfZUovz17I6X5DQJ6Qqfz2Z5pvIJt79sTQ7d2FDX1Z/mnJxMp4OiaQzjK3MUVlXoY7te6Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJQy9lrK; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhdcVujUbjjNS63GCaM6AoXdqH9KzjnsJOYndrksHJHwh9dPJz/EwB1MEh+WsA4ZVKjEIVV+sLJeo3/uY4z7isgSn5IlgSMRyRRz5JqNNa/GWhfaqSacp87b41aV9gCfpzpFxxKZI0U9lGAB2CF4cOlxD9ZVIxbv++wGmvtQOy6745ol+yxe7Wn7PIH1jKM+ZfazkHB8uNZ3DRLgaeWiJLNUlgmIbsv8tf098WQSXpda3L+0hvty0vfxIJdLC8vz/hcZ3pX27B4YUoivjluor+hkRerCQWcE3taiksqz/5iAX5AxKQ2Dhwq1cASIIVt2j0HwZPprCY0wLTLlkLgUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXvdJUEvzoSeJDBIFfwBpuhRoQhUvbdHUaBrjQ7zBkA=;
 b=vu0eSP0lvXzZ5L5rpHjXPEbqLCIuLVm7BY/3LQX17D81//O7RYwYaR218InyaODV/ihaAUy1Q30es/Zgp+NtgBNzSEoyasEkeNkNV5i/LilsvDhr8dehqB5XalAz0WJS1VaOGcV/ORQizgYU3gmktVVQdQk1i2A85ZTeV6619cligeDPcehnOP0VQ12QSeBfbWihl+HLtOn1G/UfHWN0LRacaAi35gmst/bkgG5mkuw6uuTtKKrw175w4pgmTHIrWuuyLhQDSyQWvORq1Hjm+YWJe+L3ViLZ2RYl/nYvukQRs+WAep6DMLCb+CoUdosevwKWqgI81la2mkls8JHr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXvdJUEvzoSeJDBIFfwBpuhRoQhUvbdHUaBrjQ7zBkA=;
 b=tJQy9lrKsv1V1md0+jwvqUR0Kpp1M2ecBoYXouXdLFCe8mNIwdLxidTEwKgpgHJ208J8TEvg75pu+xGuGOzCTT7JYbKFKIozP8yVGzaq2IH8rdGjBViEEHS9MKEwcLY5ZvJ1/36aRqus8NU8OiCebTNISNmmm8fRa9khHdFMURNtsA5/mgdzUBgzqeclYsw0+baz4zIBja9HnAY/e8/kVbLOkGBUEIQf0Q58y8ZFZ///mgh9c1qMOPGEdwyK+tHu81jIdhtGQm/zNvaiEEtbBBiu9fwjlmmi9RTNOnfuSSoURfmJTpJfMf5wo9nQ1tBz18k33FQczqFw35VUMLW9KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:44 +0000
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
Subject: [PATCH v2 15/16] RDMA: Add missed = {} initialization to uresp structs
Date: Mon,  6 Apr 2026 14:40:40 -0300
Message-ID: <15-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a77e00f-bd5c-4bfb-fa28-08de9403a0a9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	0l1J1Cxlvr1TF5ItfYPqIEczPT1qMQPEJRYgsNZPaXj0b55CFLQdV/uVXC72Nbe/0Qu2bF7JwKUMiUFdOkShGFmeYIZswegQYLwybSgz5X70oAt5FgmCG4Mn8kK1W95DqSTiTXNZxwnSJ8He9/xoWsUfS1jF9xz8Z0pM2U7seFjdpmXaFPjwAiU1XwU+HyY6c85W5SD6xt9YIocnVYsz7AN+aULRiPczr57jYJ+sgnbr2gNSlCq0t3+80ai4XwXjizGBtcryGN0bf1bjzkCl3eyF6a62hh8mun55IiZVOoH6AFxYZ2YGWmQQwQ3mw+Hl48nIQfw1AjmS5bhj7levf2lQNwcAOTYefGncynIwtGCZo6+7HagRKAdL61u/1vcFEnkTIu1MigSXMCI4CMdNpaqfRo6FDo51kEDDA9S5eyNlfShnupgSSHFl880ZeDnttfhgNMtnq34ba54tHRvYcaEVp+hqrVJ/qr4+bngyw4FOIz1VmC/08mosO3bnyfGb6HHgrX1RPXYQUdQroLDisfmjZoojF87NIaeWPvLpZkm9WOo4mBRRsKbyrgvhsM2l5PExkV8/2uCAbmUnhfFBez3UP1J6XkHY6FK1JwUFLS3iFFWgSCZbBK8eF6m25oPfzCLPoG2tqSvSZf54V5DewBIPGLMnTIzn7BjYByg5/+3mHaatxcjNYUQG9XWNmM25bGGaGKI/KjK3WBG/C+5eRtoUb3Tsj80qBLG+Dbzd/1TCw6ic2neo7e8smvRxP8ztdJ1Dza4vM87CLIIbpq4ytw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F0oyDUNBuwELfDFSJch2MK0v7Ff34kxcUIkrUk028/mzULyBb2J88CoFbLVR?=
 =?us-ascii?Q?sQTWcR9QgBLfQLc2GVgKPmKYb+ja/stN6lb4xsTh9orsgm/2u/cQiAUK/N9r?=
 =?us-ascii?Q?jIapB66TJ2MkIalm7sTpBCMySjc884RA3zQ1plsan37iqI3+RSZBJ6F5Zne9?=
 =?us-ascii?Q?NE1YTIBnhNoHrANvUhEXtCykCPOBRbdLykfMhGUpcFc/37E5Sr02/TsP2Mjt?=
 =?us-ascii?Q?qLxQjAcij8WEs8/KLLnCxWdYDWt9EkhGxubO+cVz5Ym8ich/IKKgiX1RNGFN?=
 =?us-ascii?Q?PEhFZ7ckEdFDTM+E/5ixBwtlI99N9EeHWpQ9dGjGQDK773l/jI1dIEvUV2LM?=
 =?us-ascii?Q?km+4TjelW+Frie6njZ9xrtAd0VzpoTrtCJ/HGp9AdwrGnSQgTena+b6OYDxq?=
 =?us-ascii?Q?rF6fFEwcPlvIPc3+jafDZQWDIGmu1A1Z9WX9b70j7QTE64UCWx2Ez0uCYe3h?=
 =?us-ascii?Q?B4EBvGZyHiPS6oKe3SNkAsu7Bl22aBfhMJn5ACV0+l1HETn+gV+bXPqSwVVP?=
 =?us-ascii?Q?nA5tytRgTcbtVVkDfOrZMw6vHJoCSL/Q97W0OgjKoVgu5cp4qB/VD8xQYzES?=
 =?us-ascii?Q?p7TaBTrQbKO6lzkiISUXQPmuZC3LojUvGCWrOk01FBTaZt5wHl/zSz+pVv4Q?=
 =?us-ascii?Q?KL4whAPdtJyxqmSL+MFBb0aYY07llTfFm5xtdPhEEehcm7r8AaaItl6xJ45q?=
 =?us-ascii?Q?HYHwxME3WZFNekW7UBn56p/Juz8Se/gw2YYNC7udRHSpGDAEv1I8WJXhIyCw?=
 =?us-ascii?Q?kucmQHGnWxpfFwnpL1WQ2shTi95A+k1MMZ8fd6tMzqCQG/4nNBox/lCyUbe0?=
 =?us-ascii?Q?227wea+r95lGYdLieUKSKlOn/fLjJlZ1bnNQi7ssaQGG7IyC1ut/9hcRSeCP?=
 =?us-ascii?Q?Mmy60VjDjFZVpb6DM6WA20KhnE2PJSJe1JgZtF1GT8F2XYDX9dXnfEm+YtlY?=
 =?us-ascii?Q?kpV3ohOOQLUg9/iiWDlwiWpKAY0YBQkLiuA60HnA8kXNAel4GEcGV0XtRAc0?=
 =?us-ascii?Q?jcNxixQRoMCQ4aV8c3+ZHa7Wip/aiijPQITbQuAHX4VIzWFGY8nJx/wzvdj3?=
 =?us-ascii?Q?Jd4hwuFRAt0ZYjwEbdiDyILi2A4Ltn84sEzvXQK/qlhnG1EhDrg2Jnulta42?=
 =?us-ascii?Q?5WwLhOU01Hre2DoEmQ6XsFx1SiEw4Cj8EidLkzYNgdWzuxrdfdE+wKV3PZ1p?=
 =?us-ascii?Q?4VH+JJMqgJ2A1fwwW0UIycnjuGdzMmaDAUrgsbxVC8gTd5QFnre9ZKQ3pzOW?=
 =?us-ascii?Q?08Y5OEzZaqpMjMUxyhE488hN4QngtNZIlyxW44m8/7jvDvxCg+aazWgu/ziI?=
 =?us-ascii?Q?tY+M14pO0MmQQfaJkuyIaX7x3sMyhfx7CrJUcN9If8NMs+F3PcIhJXA3lSwP?=
 =?us-ascii?Q?aBwvPVVIVimGsdYdihNzmfX83bYoa42ASum8BubGL77rK5c6V20LJz3aheCQ?=
 =?us-ascii?Q?Ptgld5KxuN1/HEnfv2hu+3bPVQtUpusb1LOAWDqb5LNJDA23gYdEi6HqyWf6?=
 =?us-ascii?Q?NHgrJmB2OGfY8AuzYhNIY9Ikc5g8uN+P+p/naubVTHXxDGrH13vyaWPVnGGE?=
 =?us-ascii?Q?H1E2LRKIvBrxX3QdxaicCx8jOf8IAo+/J99NF+Dw4vNG1ZPMhS+kZs0SOfBt?=
 =?us-ascii?Q?rHd2gSvGK7hRqfX3nP5gTr1TS9Vun7kAtyDjU9EwxP/vZ5o++3zY63vnHR/g?=
 =?us-ascii?Q?TFg/F5Bq0PG0ABQUCJlg3ofzulJFQxWb+7c4W9M8HwIqk1Iw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a77e00f-bd5c-4bfb-fa28-08de9403a0a9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:43.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EawGetO7hAMGRVuFAdG05Kew0BhfPGosZ7TWUn5AdEzO4ydMK/+yU/ynIL0mkwEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10025-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 951673A5C56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All of these are fully initialized so no bugs are being fixed. Add
the missing initializer as a precaution against future changes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
 drivers/infiniband/hw/mlx4/main.c         | 4 ++--
 drivers/infiniband/hw/mlx5/main.c         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7ed294516b7edb..ccb362d6d2e669 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1884,7 +1884,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		}
 
 		if (udata) {
-			struct bnxt_re_qp_resp resp;
+			struct bnxt_re_qp_resp resp = {};
 
 			resp.qpid = qp->qplib_qp.id;
 			resp.rsvd = 0;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 92a65970ab6fa1..c8a35337ba51e8 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1977,7 +1977,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (!rdma_is_kernel_res(&ibcq->res)) {
 		struct erdma_ureq_create_cq ureq;
-		struct erdma_uresp_create_cq uresp;
+		struct erdma_uresp_create_cq uresp = {};
 
 		ret = ib_copy_validate_udata_in(udata, ureq, rsvd0);
 		if (ret)
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 25f9738bd77223..d50743f090bf21 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1090,8 +1090,8 @@ static int mlx4_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	struct ib_device *ibdev = uctx->device;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
 	struct mlx4_ib_ucontext *context = to_mucontext(uctx);
-	struct mlx4_ib_alloc_ucontext_resp_v3 resp_v3;
-	struct mlx4_ib_alloc_ucontext_resp resp;
+	struct mlx4_ib_alloc_ucontext_resp_v3 resp_v3 = {};
+	struct mlx4_ib_alloc_ucontext_resp resp = {};
 	int err;
 
 	if (!dev->ib_active)
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 84dddaded6fdef..a6a696864f9e0a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2772,7 +2772,7 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct mlx5_ib_pd *pd = to_mpd(ibpd);
 	struct ib_device *ibdev = ibpd->device;
-	struct mlx5_ib_alloc_pd_resp resp;
+	struct mlx5_ib_alloc_pd_resp resp = {};
 	int err;
 	u32 out[MLX5_ST_SZ_DW(alloc_pd_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(alloc_pd_in)] = {};
-- 
2.43.0


