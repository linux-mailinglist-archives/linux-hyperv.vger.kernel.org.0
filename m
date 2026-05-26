Return-Path: <linux-hyperv+bounces-11203-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFR9Nc3KFWqQbgcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11203-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:31:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D275D9B9D
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29095304FECF
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2026 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BAA3B0AE5;
	Tue, 26 May 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drg47POS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F543B0AD9;
	Tue, 26 May 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812121; cv=fail; b=pnBmfVvH7gZ1atgT0zbghQ6cdCKOfM4xwpZ6qeEkfMF1nacKVRdLYjmC/pM1nLYcymMWEiVPm/mW4wt0Ct8flfHXzloFFybOX4voEjK695tAHwFUnHHoVlplLKX6RvbNxn10Btj6XjSrPkGHjOk8HEoOrwGphmL43xVizTUjlq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812121; c=relaxed/simple;
	bh=3D589RfxnGwvqWo4h82aOKB0MO4K2F9w+zRyZtc1tKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkDkSixqYg06brpPrVP7kReNWyNgmc15FQh4H1X7FzxKCDKjBfphaFwE3B82V6hMgfi2aP2alVRnCQVlsB54iiiDQr4mWmFbPwKHgZqt97szkqRnNuCpksNTkOKMHfdUO3WMWWGiYoBshztNmzfFTUSW8MDn/1mCsvijLKvktKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drg47POS; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fchwy/IKWFWgsrBUGHbHCMZzwy8xt7IVNLCwU9zMAcBxKY+BroZTtRyI6lNJ7oLQMKqxYzfbiWWCXiULoa8j+ZG1GCa+61mKnN5KqH9uTnUcfpOfWis29+OQc/5jjUaf+oxbgJAOCC7m5O0GmzMSyrfduUz2wba6+Hx2kD4L3M8t/gzwI32KdDf1w/InmK7Fz0fcw2Jqta6IFdBvmYRR6hesjiqnHstj/i+BaWkQfUAmmcCpYtw8dhPNaCOdccE5kDt2+9ePQKwu97KLWESm/hVEJB2ev2ggpyFEmPRQec3WNrVdPJsbumMQBXJvBLRq2/VKxlacsAULzySqyicRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0E70cdv+l9pfwub3ybCdtOpn6kXoDIxWTGZb5UyAGY=;
 b=SwXSRoe0/vf3vKNAJZoqX/tqAppDKQKw7muRfNgPlL7Bp1K1DeG0cXDr02ang/fKLLxusZLKIu2iUsRL/PoI+v575mxwlmSA3oFfuVD4cI96a/8rIuQ9IrtkECqotWc2imgHmv6ITx354yZl+vJVI61jg3TD8H3HtaBP+IQ9hSdGxPZExfhQ8/7lxKS3gq/B9JoqjxUvb+7APjIW2SDwsy6LsGJKo96IGHyhLISqtErYtsyQvmuV703D04A98XvTSzkvtK/H6Xq1kvZ8hztuhpUVMW6bWl+3l+aZU6ILWD9ORU9CGxW/0Vx6hRPBDj9vdhJoGdUmgNNeSPK6nCl53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0E70cdv+l9pfwub3ybCdtOpn6kXoDIxWTGZb5UyAGY=;
 b=drg47POS82ix0gdZQn96yIKFUPN49ta4z0wTsOGc2n18jDNBNdAE+Ur6qomoBTSta7kFoDHflaz14u6DSQUGbh2PKWdqXoNSgFIytF84vx2os5j9LMHFcB2IhHuLjc/pdK2GRb0tR24a4cI6puacpyo7V9rlmOMu7X0UEizJU5Y5VYK0GOP6TsBEFYRO7DaIFnFufXtOOUi2IIDXpOSiDkhtrC+XAE7rJatyIH0/DfXA/hxEdGtqyd/2OUUWnUr5anxFD6LasT8Mzv+14Ktk0+jqMLw2HivPNiVOL9FVv6o40iIJqJy+GDMn4teW5qNHs2FuFofcpiui6Apj3P9YNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 16:15:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 16:15:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
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
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	patches@lists.linux.dev
Subject: [PATCH 2/2] RDMA: Update the query_device() op
Date: Tue, 26 May 2026 13:15:06 -0300
Message-ID: <2-v1-922fa8e828ba+f7-ib_udata_stack_jgg@nvidia.com>
In-Reply-To: <0-v1-922fa8e828ba+f7-ib_udata_stack_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0412.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 1749d0f1-9490-4de6-9f72-08debb41f481
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|56012099006|18002099003|22082099003|6133799003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	3svl/9cENuYjdgdRwVNXYoNQeSVF9gahCiyj+vw1O6N0vauMJFXnq2di7QriHdH45rz/GGg5GkVR4JXNHK0Oj0NyKGKW8Sret300ptAZWGJzjLyG/kdSzt8HlrVc4NVEu2fbwja7nUJiUeeguX8PT5O6E0tqDy3xVeBEhxkm7UwoMlObcUnDBUDDBzpcAlLQTnAEdNLlRVcgKmA6dbIJRwxqkHK8rSDd5N+sVEToObF+rkcbH65ZCDR+pwycpCKBRzXPOoAdraFd0UyG0thqehul7jLgQJqLu7MA2m0/9Is/XLKji9R9fdBIobPjJljfWB6xIuifTasbvx89QexHdHo++1IEEkXEnjz4CBhVJSXcEFikgO0Py6jEMa2Xeb4mEWz8Z4+KHD9TNxtNYjdhGL2+zRITmLrE/5qW14QyUzjhZ56i0aIKM53DL2/ienhOYaVoWeReHKFzov9Yd08zkPCW/US8T/jPh2MfQOPBMwUMeBjxx1QCx0cSi+ZbeJup2oafR4taoLu5LZ1ngFbSuD9fFxaGoL1COneLrTlnfStbtOUrgxVNMCL1+q3B9FnFG3ZO1PmOhjyj/sVY6MXwWeiseej2IshgxMRrFdYBfJqgJTUqhL5oi3UtpLzcwiX5sRqNGQ4aSdbxUm8WbR+0/jQ03qfgdw9hTP8ziv/XjXG4vo6ywigAdph9ovcuvDAEY/rBDoLFelgPb+hMvs0NIC0hUXk8aZ4VaB6t3oYY9OI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(56012099006)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tejHLdPbjNtLAZlNOsO1iWrMO9z8d+e1p/5FW62Rdfa0FF1PIlLACoj0nfFS?=
 =?us-ascii?Q?zs5ysY6g5U3UwAocuQ7MD/NoX2aAve5bVRBHIP/i3rlN8Rk2gwEWPfbXSk42?=
 =?us-ascii?Q?aDyKKJFElhCB4X4D7ZPJltjA8s36QNwiML9kNY+1YrTp8caQY37fScMly/ZO?=
 =?us-ascii?Q?xC2f0OHb13opSTVXF5J3t/TWCCktFegZmWNzdJtug/88psqXr8kNr13Q+YXE?=
 =?us-ascii?Q?i9lulO4/0K2j2pLBd4bl33F+ALdtTCE2Pbq10Gi0AUqkddjrj7Mt1rVMmZAx?=
 =?us-ascii?Q?NKAzqMoXeWWn7sJbXyU5Z4VZ0itCy8S95dp+NoXAUj+5O7ZI+BeCy7ghEFCB?=
 =?us-ascii?Q?kAthdUchbnZL3QEgoGyTaYxyoHe2wlOqlXG0RS2Y+B0vkZ1AHkZYpTSTPUUs?=
 =?us-ascii?Q?GLoogh4AXrPLZCmeoX9DcwJ3Q7Dtdrtkol8MxCb7fvFIEaQWDH9yfr4OiUst?=
 =?us-ascii?Q?UCDP3eSQteErUd50Wav5S297jVqJ4IRXq9TnPLDVGVuWQi4zXvs43T2j+fE6?=
 =?us-ascii?Q?/GvaXNM7KoKI8YztST0kE/XM3Z2liKnFYq91Ps/ep9dK9QI5UOpViwhtNph2?=
 =?us-ascii?Q?EeiMe90jVrt8kAca9CGDH2yq9vTwBVa2/FPvdSv+ZSFqiytA3fCK28bGE2nR?=
 =?us-ascii?Q?e2CAtp7lq+QBApdUD9D114daEj6sYGoq8oMHOepyaY+ixzxH7gk5+mgBRNEw?=
 =?us-ascii?Q?V1lxHW+NEpvs1Uwk3dms3HsBG8IVLnT41hCbn2oooN1nj98paNwB/dW1P7yK?=
 =?us-ascii?Q?UobDvQSPJm8QbVwEz6+mkKmnfM3w0AWdNRAoq+OX0DmbU0bVbcmkulADU525?=
 =?us-ascii?Q?V3dEFMv5nitSq39ZezVrqsG59Vs2MlHULuJ9UMPp9lN5D+fcN/pyPMo/3o4i?=
 =?us-ascii?Q?Q9q66dTgMEnWasxnt19bvSW/6ZxLJc2le+G5OBvWTmTlb2Tu2wwePpWsVuqw?=
 =?us-ascii?Q?Ld/LzGIn9MmnGyt9/9tlKpjXWdLaaa6+bKt0tR4FuBM2Cy0Zl+fTkLQDbSAQ?=
 =?us-ascii?Q?b8mpZHdoyn/Uz3gEyNgBMsNeqjo6VhC9SDV3qvAxNpmOiic3hPwFz+nTcDWx?=
 =?us-ascii?Q?BoQJ0EnVru2+xtCsFtiJ0jgT8koe2bUQVjxC35f6MGKIA5dDTZ2Vz9HALqpR?=
 =?us-ascii?Q?a0tLt61thJ/2fqClZEvTiReLAnB5Q4GEhYzyrc+N28EryhZG2RvASQM7PCBX?=
 =?us-ascii?Q?iQ5XKMbEeQ/TyDDrCIma5ve9x5zEgvuKOXtydOj2NJ0x/PGfE1iBkp7ibW4L?=
 =?us-ascii?Q?1mAOk+gacGCTtMrPweyTMFDfR/nhW3n25pWK1QMSkqnhHhQ8dI+g8LXZXzsC?=
 =?us-ascii?Q?f0sCYsNQ1IX09CarPveU7AxPCc5JkBGUkKdvPsgz3ZBF1DLqUEEYCSxzpX+y?=
 =?us-ascii?Q?wj7ppQ7DA47ttblFuteVdIOt5x++/thkdx/pWePbavtDUQAFQ2EobCojJUBT?=
 =?us-ascii?Q?B83o/t3yT9GulMH+s3HcJMW1xyFmPr+QVREdJv0PC3uI/mtMULOmNnitSNzw?=
 =?us-ascii?Q?6+HjjaTjvCiKxcCV4mMk0BHruN1dd1cSQj6UF/w5CphOTcgMbypjblMsq8zp?=
 =?us-ascii?Q?JvtPu9h7Q+JOqEt+ZxJZAtD5Vw7aKRn2d6k3zSdU4JbwG7Niy0Ca6LPpaT5f?=
 =?us-ascii?Q?LaYt+607eJKfiDW/H/a1ZSFM5i36isAv2e3rzs5NtTbuz5wazbuc3DRqNwbJ?=
 =?us-ascii?Q?dmFp63mdqgOotY4JBPPlLhu5fG2su9kvD7gD785Ufakl1cYq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1749d0f1-9490-4de6-9f72-08debb41f481
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:15:08.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfsnJ2LXngrPjJ/MvVKumzMQvOc0oWrZI+8C8vunE5zdKPAzPKCwXpcVE00n40UD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774
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
	TAGGED_FROM(0.00)[bounces-11203-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,broadcom.com,linux.dev,chelsio.com,linux.alibaba.com,cornelisnetworks.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,cisco.com,huawei.com,nvidia.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: F3D275D9B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This op hasn't followed the normal pattern of passing NULL for udata when
invoked by the kernel. Instead the kernel caller creates a dummy ib_udata
on the stack and passes that in. It does not seem to currently be a bug,
but this flow should be modernized to use the new API flow and in the
process accept NULL as well.

Only mlx4 uses an input request structure, have every other driver call
ib_is_udata_in_empty() to enforce the lack of request structs.

Use ib_respond_empty_udata() in every driver that does not use a response
struct.

Ensure a check for NULL udata before calling ib_respond_udata() in
bnxt_re, efa, and mlx5.

Make mlx4 safe to be called with NULL.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c                |  3 +--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  5 ++++-
 drivers/infiniband/hw/cxgb4/provider.c          |  8 +++++---
 drivers/infiniband/hw/erdma/erdma_verbs.c       |  9 +++++++--
 drivers/infiniband/hw/hns/hns_roce_main.c       |  7 ++++++-
 drivers/infiniband/hw/ionic/ionic_ibdev.c       |  7 ++++++-
 drivers/infiniband/hw/irdma/verbs.c             |  8 +++++---
 drivers/infiniband/hw/mana/main.c               |  7 ++++++-
 drivers/infiniband/hw/mlx4/main.c               | 13 +++++++------
 drivers/infiniband/hw/mthca/mthca_provider.c    | 13 ++++++++-----
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  8 +++++---
 drivers/infiniband/hw/qedr/verbs.c              |  7 ++++++-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  8 +++++---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  8 +++++---
 drivers/infiniband/sw/rdmavt/vt.c               |  9 ++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c           | 14 ++++----------
 drivers/infiniband/sw/siw/siw_verbs.c           |  8 +++++---
 17 files changed, 91 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b89efaaa81ec58..9f9662e9228186 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1245,7 +1245,6 @@ static int assign_name(struct ib_device *device, const char *name)
  */
 static int setup_device(struct ib_device *device)
 {
-	struct ib_udata uhw = {.outlen = 0, .inlen = 0};
 	int ret;
 
 	ib_device_check_mandatory(device);
@@ -1257,7 +1256,7 @@ static int setup_device(struct ib_device *device)
 	}
 
 	memset(&device->attrs, 0, sizeof(device->attrs));
-	ret = device->ops.query_device(device, &device->attrs, &uhw);
+	ret = device->ops.query_device(device, &device->attrs, NULL);
 	if (ret) {
 		dev_warn(&device->dev,
 			 "Couldn't query the device attributes\n");
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 94aa06e3b828ca..98d65c1b102200 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -265,7 +265,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 		resp.packet_pacing_caps.supported_qpts =
 			1 << IB_QPT_RC;
 	}
-	return ib_respond_udata(udata, resp);
+
+	if (udata)
+		return ib_respond_udata(udata, resp);
+	return 0;
 }
 
 int bnxt_re_modify_device(struct ib_device *ibdev,
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 0e3827022c63da..e1eec37ee8222a 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -259,11 +259,13 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 {
 
 	struct c4iw_dev *dev;
+	int err;
 
 	pr_debug("ibdev %p\n", ibdev);
 
-	if (uhw->inlen || uhw->outlen)
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	dev = to_c4iw_dev(ibdev);
 	addrconf_addr_eui48((u8 *)&props->sys_image_guid,
@@ -298,7 +300,7 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 	props->max_fast_reg_page_list_len =
 		t4_max_fr_depth(dev->rdev.lldi.ulptx_memwrite_dsgl && use_dsgl);
 
-	return 0;
+	return ib_respond_empty_udata(uhw);
 }
 
 static int c4iw_query_port(struct ib_device *ibdev, u32 port,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index b59c2e3a5306d1..d9eb8ae2c56fba 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -315,9 +315,14 @@ erdma_user_mmap_entry_insert(struct erdma_ucontext *uctx, void *address,
 }
 
 int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
-		       struct ib_udata *unused)
+		       struct ib_udata *udata)
 {
 	struct erdma_dev *dev = to_edev(ibdev);
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	memset(attr, 0, sizeof(*attr));
 
@@ -358,7 +363,7 @@ int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 		addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
 				    dev->netdev->dev_addr);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int erdma_query_gid(struct ib_device *ibdev, u32 port, int idx,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 77bad9f5d482bb..c6f633bd5a3402 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -221,6 +221,11 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 				 struct ib_udata *uhw)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
+	int ret;
+
+	ret = ib_is_udata_in_empty(uhw);
+	if (ret)
+		return ret;
 
 	memset(props, 0, sizeof(*props));
 
@@ -274,7 +279,7 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
 		props->device_cap_flags |= IB_DEVICE_XRC;
 
-	return 0;
+	return ib_respond_empty_udata(uhw);
 }
 
 static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 73a616ae350236..b0449c75f8938f 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -25,6 +25,11 @@ static int ionic_query_device(struct ib_device *ibdev,
 {
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
 	struct net_device *ndev;
+	int err;
+
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	ndev = ib_device_get_netdev(ibdev, 1);
 	addrconf_ifid_eui48((u8 *)&attr->sys_image_guid, ndev);
@@ -69,7 +74,7 @@ static int ionic_query_device(struct ib_device *ibdev,
 	attr->max_fast_reg_page_list_len = dev->lif_cfg.npts_per_lif / 2;
 	attr->max_pkeys = IONIC_PKEY_TBL_LEN;
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int ionic_query_port(struct ib_device *ibdev, u32 port,
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 3f4811bb5514c6..5ba2e63b51036e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -16,9 +16,11 @@ static int irdma_query_device(struct ib_device *ibdev,
 	struct irdma_pci_f *rf = iwdev->rf;
 	struct pci_dev *pcidev = iwdev->rf->pcidev;
 	struct irdma_hw_attrs *hw_attrs = &rf->sc_dev.hw_attrs;
+	int err;
 
-	if (udata->inlen || udata->outlen)
-		return -EINVAL;
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	memset(props, 0, sizeof(*props));
 	addrconf_addr_eui48((u8 *)&props->sys_image_guid,
@@ -74,7 +76,7 @@ static int irdma_query_device(struct ib_device *ibdev,
 	if (hw_attrs->uk_attrs.hw_rev >= IRDMA_GEN_3)
 		props->device_cap_flags |= IB_DEVICE_MEM_WINDOW_TYPE_2B;
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 /**
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 307ae01bf26f34..4dcd048d44b69a 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -549,6 +549,11 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 {
 	struct mana_ib_dev *dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	struct pci_dev *pdev = to_pci_dev(mdev_to_gc(dev)->dev);
+	int err;
+
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	memset(props, 0, sizeof(*props));
 	props->vendor_id = pdev->vendor;
@@ -576,7 +581,7 @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_attr *props,
 	if (!mana_ib_is_rnic(dev))
 		props->raw_packet_caps = IB_RAW_PACKET_CAP_IP_CSUM;
 
-	return 0;
+	return ib_respond_empty_udata(uhw);
 }
 
 int mana_ib_query_port(struct ib_device *ibdev, u32 port,
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index d50743f090bf21..17073e8f105aab 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -444,8 +444,9 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	struct mlx4_uverbs_ex_query_device cmd;
 	struct mlx4_uverbs_ex_query_device_resp resp = {};
 	struct mlx4_clock_params clock_params;
+	size_t uhw_outlen = uhw ? uhw->outlen : 0;
 
-	if (uhw->inlen) {
+	if (uhw && uhw->inlen) {
 		err = ib_copy_validate_udata_in_cm(uhw, cmd, reserved, 0);
 		if (err)
 			return err;
@@ -572,7 +573,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	props->cq_caps.max_cq_moderation_count = MLX4_MAX_CQ_COUNT;
 	props->cq_caps.max_cq_moderation_period = MLX4_MAX_CQ_PERIOD;
 
-	if (uhw->outlen >= resp.response_length + sizeof(resp.hca_core_clock_offset)) {
+	if (uhw_outlen >= resp.response_length + sizeof(resp.hca_core_clock_offset)) {
 		resp.response_length += sizeof(resp.hca_core_clock_offset);
 		if (!mlx4_get_internal_clock_params(dev->dev, &clock_params)) {
 			resp.comp_mask |= MLX4_IB_QUERY_DEV_RESP_MASK_CORE_CLOCK_OFFSET;
@@ -580,14 +581,14 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 		}
 	}
 
-	if (uhw->outlen >= resp.response_length +
+	if (uhw_outlen >= resp.response_length +
 	    sizeof(resp.max_inl_recv_sz)) {
 		resp.response_length += sizeof(resp.max_inl_recv_sz);
 		resp.max_inl_recv_sz  = dev->dev->caps.max_rq_sg *
 			sizeof(struct mlx4_wqe_data_seg);
 	}
 
-	if (offsetofend(typeof(resp), rss_caps) <= uhw->outlen) {
+	if (offsetofend(typeof(resp), rss_caps) <= uhw_outlen) {
 		if (props->rss_caps.supported_qpts) {
 			resp.rss_caps.rx_hash_function =
 				MLX4_IB_RX_HASH_FUNC_TOEPLITZ;
@@ -611,7 +612,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 				       sizeof(resp.rss_caps);
 	}
 
-	if (offsetofend(typeof(resp), tso_caps) <= uhw->outlen) {
+	if (offsetofend(typeof(resp), tso_caps) <= uhw_outlen) {
 		if (dev->dev->caps.max_gso_sz &&
 		    ((mlx4_ib_port_link_layer(ibdev, 1) ==
 		    IB_LINK_LAYER_ETHERNET) ||
@@ -625,7 +626,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 				       sizeof(resp.tso_caps);
 	}
 
-	if (uhw->outlen) {
+	if (uhw_outlen) {
 		err = ib_respond_udata(uhw, resp);
 		if (err)
 			goto out;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index afa97d3801f783..079c51003b24a4 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -55,16 +55,19 @@ static int mthca_query_device(struct ib_device *ibdev, struct ib_device_attr *pr
 {
 	struct ib_smp *in_mad;
 	struct ib_smp *out_mad;
-	int err = -ENOMEM;
+	int err;
 	struct mthca_dev *mdev = to_mdev(ibdev);
 
-	if (uhw->inlen || uhw->outlen)
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	in_mad = kzalloc_obj(*in_mad);
 	out_mad = kmalloc_obj(*out_mad);
-	if (!in_mad || !out_mad)
+	if (!in_mad || !out_mad) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	memset(props, 0, sizeof *props);
 
@@ -111,7 +114,7 @@ static int mthca_query_device(struct ib_device *ibdev, struct ib_device_attr *pr
 	props->max_total_mcast_qp_attach = props->max_mcast_qp_attach *
 					   props->max_mcast_grp;
 
-	err = 0;
+	err = ib_respond_empty_udata(uhw);
  out:
 	kfree(in_mad);
 	kfree(out_mad);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 383f1d9c15d151..17def9d9ce99ca 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -68,9 +68,11 @@ int ocrdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 			struct ib_udata *uhw)
 {
 	struct ocrdma_dev *dev = get_ocrdma_dev(ibdev);
+	int err;
 
-	if (uhw->inlen || uhw->outlen)
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	memset(attr, 0, sizeof *attr);
 	memcpy(&attr->fw_ver, &dev->attr.fw_ver[0],
@@ -110,7 +112,7 @@ int ocrdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	attr->local_ca_ack_delay = dev->attr.local_ca_ack_delay;
 	attr->max_fast_reg_page_list_len = dev->attr.max_pages_per_frmr;
 	attr->max_pkeys = 1;
-	return 0;
+	return ib_respond_empty_udata(uhw);
 }
 
 static inline void get_link_speed_and_width(struct ocrdma_dev *dev,
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 1af908275ca729..cf01078820d8cb 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -105,6 +105,7 @@ int qedr_query_device(struct ib_device *ibdev,
 {
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qedr_device_attr *qattr = &dev->attr;
+	int rc;
 
 	if (!dev->rdma_ctx) {
 		DP_ERR(dev,
@@ -113,6 +114,10 @@ int qedr_query_device(struct ib_device *ibdev,
 		return -EINVAL;
 	}
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	memset(attr, 0, sizeof(*attr));
 
 	attr->fw_ver = qattr->fw_ver;
@@ -155,7 +160,7 @@ int qedr_query_device(struct ib_device *ibdev,
 	attr->max_pkeys = qattr->max_pkey;
 	attr->max_ah = qattr->max_ah;
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static inline void get_link_speed_and_width(int speed, u16 *ib_speed,
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 261f18a8368543..dc355b00f61cec 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -275,10 +275,12 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 	union ib_gid gid;
 	struct ethtool_drvinfo info;
 	int qp_per_vf;
+	int err;
 
 	usnic_dbg("\n");
-	if (uhw->inlen || uhw->outlen)
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	mutex_lock(&us_ibdev->usdev_lock);
 	us_ibdev->netdev->ethtool_ops->get_drvinfo(us_ibdev->netdev, &info);
@@ -322,7 +324,7 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 	 * max_qp_wr, max_sge, max_sge_rd, max_cqe */
 	mutex_unlock(&us_ibdev->usdev_lock);
 
-	return 0;
+	return ib_respond_empty_udata(uhw);
 }
 
 int usnic_ib_query_port(struct ib_device *ibdev, u32 port,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index b9c3202b9545e3..1d29a535f76a8c 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -67,9 +67,11 @@ int pvrdma_query_device(struct ib_device *ibdev,
 			struct ib_udata *uhw)
 {
 	struct pvrdma_dev *dev = to_vdev(ibdev);
+	int err;
 
-	if (uhw->inlen || uhw->outlen)
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 
 	props->fw_ver = dev->dsr->caps.fw_ver;
 	props->sys_image_guid = dev->dsr->caps.sys_image_guid;
@@ -114,7 +116,7 @@ int pvrdma_query_device(struct ib_device *ibdev,
 	props->device_cap_flags |= IB_DEVICE_PORT_ACTIVE_EVENT |
 				   IB_DEVICE_RC_RNR_NAK_GEN;
 
-	return 0;
+	return ib_respond_empty_udata(uhw);
 }
 
 /**
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 40aa6420836470..5fa3a1f3332689 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
+#include <rdma/uverbs_ioctl.h>
 #include "vt.h"
 #include "cq.h"
 #include "trace.h"
@@ -79,14 +80,16 @@ static int rvt_query_device(struct ib_device *ibdev,
 			    struct ib_udata *uhw)
 {
 	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
+	int err;
 
-	if (uhw->inlen || uhw->outlen)
-		return -EINVAL;
+	err = ib_is_udata_in_empty(uhw);
+	if (err)
+		return err;
 	/*
 	 * Return rvt_dev_info.dparms.props contents
 	 */
 	*props = rdi->dparms.props;
-	return 0;
+	return ib_respond_empty_udata(uhw);
 }
 
 static int rvt_get_numa_node(struct ib_device *ibdev)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8edd4dd1f031f4..5815ce34d9704c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -22,19 +22,13 @@ static int rxe_query_device(struct ib_device *ibdev,
 	struct rxe_dev *rxe = to_rdev(ibdev);
 	int err;
 
-	if (udata->inlen || udata->outlen) {
-		rxe_dbg_dev(rxe, "malformed udata\n");
-		err = -EINVAL;
-		goto err_out;
-	}
+	err = ib_is_udata_in_empty(udata);
+	if (err)
+		return err;
 
 	memcpy(attr, &rxe->attr, sizeof(*attr));
 
-	return 0;
-
-err_out:
-	rxe_err_dev(rxe, "returned err = %d\n", err);
-	return err;
+	return ib_respond_empty_udata(udata);
 }
 
 static int rxe_query_port(struct ib_device *ibdev,
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index b34f3d6547ffc7..b74ac85c1b8b8b 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -130,9 +130,11 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 		     struct ib_udata *udata)
 {
 	struct siw_device *sdev = to_siw_dev(base_dev);
+	int rv;
 
-	if (udata->inlen || udata->outlen)
-		return -EINVAL;
+	rv = ib_is_udata_in_empty(udata);
+	if (rv)
+		return rv;
 
 	memset(attr, 0, sizeof(*attr));
 
@@ -165,7 +167,7 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 	addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
 			    sdev->raw_gid);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int siw_query_port(struct ib_device *base_dev, u32 port,
-- 
2.43.0


