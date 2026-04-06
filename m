Return-Path: <linux-hyperv+bounces-10006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOC0Cvmi02mMjwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10006-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50F3A3328
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1B6300FB5F
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12376334C27;
	Mon,  6 Apr 2026 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TY/r9q0m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5493358BB;
	Mon,  6 Apr 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477494; cv=fail; b=B55F12oZY2BSc/yZBHqr9MwpSozZNcm5OIWdZ1FOQuS/fKIrbNOAAEqHRdPn7eRWaRSJdEatDu+6+mwp4iNAdJvw0atIRG0Kkyp/rZG3VzTC826g1K/DB5UsaFe2bLAOBK6oE/pbNyE8NR+ZxpmvMSMhQRsEriP12/gEuSJrghw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477494; c=relaxed/simple;
	bh=+vIWbEb4i0X1B7e1ceSA1tgnUuQfM9HizPELQbeDXs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYdpGTLHr+WJZXxLD1Ez3CyrFckeF/ZwzfbL5oRFVOfDifduhYXUUUeRvzu9lxa2AEU57OMnWa/gd+VGwAjgR6ykAGRPmymLkWCH82rCOVJxxjYT0UvDWyQhnwUFaklGzV6PS95kMW2tDTINlSkH+CtCoFuEOfRAd8Rs1lk+l1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TY/r9q0m; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bsaa6vdu8Z5hTBEGPSJ+s0cAct9cy0sSZsf9MdaXWrlxevcrCPsyeL245IlAnQCdVe3mAcXdFDg/EX12Z6oxJFNk86435IAH/SD8T88w3BXqndOR0YXR2Phiwf4N71eBbLcJNLv1An8ljMn4iYvpL39Q4m3/XV7Bz5biodXqMSHyS+BAeewGabKiMJlEdKIuE5cRXOdQ1sd90Pggk55ZEE/a0EZCswURH+e/oYtZCKhLIny9UtmjBmqVjJM3gFyIpQzz5a1AV4SKJqwkKCKqRgTwGTpPdmHetTakhab4zl5j3MN8pxltnmV2H8LhzB2bP/2m4jgI6T+PJSnCVlb2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFS+Coafl5QnAN3KWZuMFRYzrG6MinCj0uk8cEnKx/A=;
 b=SDPIkV/LfZy9/0HS4JGqbOlC9nnQmO/qvL9dLEgqyWKOf7o8QOOTsXHyRLCwCoo1cwDgZkbAobAHigBGp3MNRX1ipct+5lGerI8lUJovKo7FBzAhMIiU84xt2/mXeWPiCXAsX100Yavth9oegb+CP2y4A7rP5i49ZvJkEN2lSkwgP30wo3c0pKHSd/1t14EFwpSVm38p/y/aeFshf8Ktqy784sMqAQm0vB8ARv0flQREJ5wEXidRe8t0irI95s1gT28+24C0ZkHkJeo5s8EeD8K+WDt+gbTjmMv4djwqIHJukc87E7kL9AeO8cFd7nKOoJNF+0hko6DUiQiaKAv5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFS+Coafl5QnAN3KWZuMFRYzrG6MinCj0uk8cEnKx/A=;
 b=TY/r9q0mbWTJxSrYwbykVlESfjZf3adtDU5rWlMMDfoIwAx+kV1pUhRqvJxcufMbLPLR4/rhuu+J6HqN/XBhsrPQFYKPkG7fNwXXaXfJEbH+N5VDi3HJ2A/EQnCi4e80YdyMb5Cf7zGgcm+EQCSe8Uvghf55gYbxMv6/AQvnUBw80iTSmx4ZNKEOlR1nyo37wyrM5bj5P3ABJaqpbikWAr4VYlXzbuJAR2qIy3ySfJVdPT/+gU0+4yh6N4yw4NLJg24+5Il0LhIT/Ebx3svgwBpr7Cs0DOH1GvqKpyXxy7uW1lwPV0M8uOdhJrGyZXwGeil7sJ4Qtz+eSB98Qv1d1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 12:11:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 12:11:27 +0000
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
Subject: [PATCH 07/10] RDMA/mlx: Replace response_len with ib_respond_udata()
Date: Mon,  6 Apr 2026 09:11:21 -0300
Message-ID: <7-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v1-e911b76a94d1+65d95-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ea1652-853f-4698-d080-08de93d5a083
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	A2VYM7zs6a0J4W+PAJIP8lUmOtti1JETy3z52+K+xv5V+gwyQ8g13eKxeth6Ccrwyi6mSviIZ/VZvqEsMmP0u1RSa/KOPbqgszHAZGYoJLgdE4T6P8TAhONN1WpSZSerlIc+paGR0l5E5jxK6NR5vamsegkhZXbN5xVBshbtLlSg20eMoEstnCi4/l7+Hi+McqdTBfSPosq7ZGXBESU1z5NpKB5+NLqb2JpYRha6HxX8DnDTnyj7wTWRwaubbq16tifsvP1mrRM6fLUq4ijwKXLRljG5rrHsS8oOuO0b8zk9d3GSd5gWFwvQoLl7KmAtdHkKXFIkiHXYmCOOQsEzEJPLViVbbHDhsmemqC91A853SDpyyd/UgbBr6HR6cBd5VXoBQMzCjBU0Ex+cLMlU3kgwFDE1MA7MeBUL/Un/xl+mc8Lp/YrlfVo82mR4clVF1UN9azPCsJITcqjUkPqRWQyP8l5V2+oxp1wJr78WhryAs0eZs43KbBQ9oUk7WoR1Es4S9wXWa5QYlDecbymuTT2oyrLuVkhCjdVkTxQU6h7Zk2M1OiwZPIqUHOaZUSlaR6PjbGc5WDnemeVZ4//S0V4oiKH36wJxGsf5jvCnXCktQRFr5G3aM5v5kcICLz979fY9nG0CCQun9cvLYkvOnNfNgVUCz8LIopgW2ykXqpMSMRaa5tpYmUJoCL1HluhtrxcXduf78c/NGDD4yt1YykwzR0bGsvapvmp5GiyTt3SEyygVzwN6WvqIYuw98TxDVxUrW2MS08r77fbwbidAjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8/NXFUy7sjLCgTHi0jyADfiKoplVdI1C7irBgc6s7QLJLMcBU2PvXcYXliU?=
 =?us-ascii?Q?sTqkdi3GyyYWIUTPbFkW/kK1cHGNOoy79cDjOFrxD21/+NtyCJ/L2h/DTtOF?=
 =?us-ascii?Q?RgbA2O1xo2Dhmemq8ywBbsGeQMe0uVXqk1Oh/L1GBQCrFwrrSITRSJHc3w6X?=
 =?us-ascii?Q?h2ZpHGWXCnhjtAgxmEPcP58s222WIjaNraJtRhIySJeZf1gLxJAqA/wTkH/9?=
 =?us-ascii?Q?IhacKsYUFSHgYSBco60wIv+CnJ3M6ugJCJbbTVlH09b64JD7AXzIqa3MQf2T?=
 =?us-ascii?Q?LdeXnWysDiQ8BPfdnpoJZJI1VhYAoGPjl8I3dc3HBop5Ey6wQmSePBEfpL6z?=
 =?us-ascii?Q?5q+Ks+sn6iNkYNWiM8prR+Dh3cl9pSf4P9ga2WVi9RRcbfhgkfG50RkMNtHT?=
 =?us-ascii?Q?jknLQV4supVloRcsskba4SunEDvjXCS437vOl7A+ZUsAom7lXZ/sp0raAnw4?=
 =?us-ascii?Q?YI4qbpWlaZRcIoQWBWI30Bg5qp+12dHJzjAsZ7oZzIMfO2jIOuatP6SxITw1?=
 =?us-ascii?Q?TW4pOidKobShKbzMO/A1zpogcyskzVhV6dLAlOwSM7lZQpGmDCD1y/px9OML?=
 =?us-ascii?Q?5kh74YMOtGRR4tGnhqtOt6eOE9dzUCAotMElWj0JkAIUoNCdot0Gygq/7R8w?=
 =?us-ascii?Q?O92rdG2TWgInIFrsUJtDVkt/vimtdVKBbh0wf+WvGJfhZrTycJ03+bxHbIKw?=
 =?us-ascii?Q?oFSFOI0tAOlVVNsxuLxLLOQpoP6grZkvnnxDRVwmdb6v+lBunk5LspEqhhZ9?=
 =?us-ascii?Q?Q3K+xHQNR0/m3lbTeOcwN2vcEUMKrZ8fwcD/BtfeZpdqDZSurNEaJ8cMipXs?=
 =?us-ascii?Q?td/cbFXyxV87eP1VUElazWli2XOjhrTSNavYAlPO4Pow3T3E0JO1qeqb5WWw?=
 =?us-ascii?Q?zWxc6pss4D6opC8T+yzXPhPh3+WTpBQUaxWV3L7cpKfiBYTXqRPAymxJhRCt?=
 =?us-ascii?Q?N32XKJdwbrz2E01uhlNxPRHoBT/bKn0eVwmiNX7Y5bsB+2662rqS/4yTrSBx?=
 =?us-ascii?Q?1JLIkUidgnI43ePnlRc/zxf0M5ZW8FN75wR5tefucPPPF9mUIZOftyR4xEIB?=
 =?us-ascii?Q?RVY5yAqkThQgnjMj8d7VYfmpJBGDTMpMt7+O3tNoFk3umxyRqTy3NkZuVSKk?=
 =?us-ascii?Q?n8MlKOn84VRWoG243GIo8iE3T2MyVVAogo3sI9LDCjPDpuR9fvPtETD1ldIA?=
 =?us-ascii?Q?qq5lIwhwDMJx+/jN1urgf1ET/tKu2biVJ+H0MS+g9E5uulwwhWFjJCQIH6KB?=
 =?us-ascii?Q?SzT1MBNenVyknGcwxZl5xpoQa4sTQuhRosznAj54qSGMQumPgqCJl6ZiRG8W?=
 =?us-ascii?Q?yzX1tIUkDifv43Jow3l1qiZO4vprWl942FXLkwapGfbJPUQr574a6uBbxCU1?=
 =?us-ascii?Q?MK+fXtM2c6haDg34SELiebQDT4ARD2QWvAl0wwGXm/xsHlmFbLAAHtRoq/aX?=
 =?us-ascii?Q?Pnt8+aIvCh6PsAHUetZ+nS+xGwrblhLsJWx7BkAU+miOFU3UcNox/RT+WEm8?=
 =?us-ascii?Q?bQ+Gmd3FcaCSgHHSWHyxkwa6S+ZARabHgAmxXy7rt04HCc8WWMHFox/1AIyS?=
 =?us-ascii?Q?fyDXQq3/Pc7CGfJ4t0/z4WE/caSUWR8vKN9yqJNPgGE1LW6X5ZC0MYiUWByL?=
 =?us-ascii?Q?180ZRMV0H1AlNGT2B2hPBEAPo8UVeIhUzBB3xNY6afdiJbJYwO4DLz/WhMjC?=
 =?us-ascii?Q?F4aoIc/PSdWB0NgSGodWE25cQLjflKaHn6qIQE6UFlvXKJAp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ea1652-853f-4698-d080-08de93d5a083
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:11:26.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KyotqPT0KJjGoiDSe+CDb4OhC7PFOKz/SWz+PT1iVqufTrvUE36B/Nk+bSS+4Q1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-10006-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DE50F3A3328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 57d3b80e7550b6..84dddaded6fdef 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1355,7 +1355,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	}
 
 	if (uhw_outlen) {
-		err = ib_copy_to_udata(uhw, &resp, resp.response_length);
+		err = ib_respond_udata(uhw, resp);
 
 		if (err)
 			return err;
@@ -2280,7 +2280,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		goto out_mdev;
 
 	resp.response_length = min(udata->outlen, sizeof(resp));
-	err = ib_copy_to_udata(udata, &resp, resp.response_length);
+	err = ib_respond_udata(udata, resp);
 	if (err)
 		goto out_mdev;
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3ef467ac9e3d15..8eb922bd3b663d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1811,7 +1811,7 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	resp.response_length =
 		min(offsetofend(typeof(resp), response_length), udata->outlen);
 	if (resp.response_length) {
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto free_mkey;
 	}
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 81d98b5010f1ca..4a7363327d2a8e 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3327,7 +3327,7 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		 * including MLX5_IB_QPT_DCT, which doesn't need it.
 		 * In that case, resp will be filled with zeros.
 		 */
-		err = ib_copy_to_udata(udata, &params.resp, params.outlen);
+		err = ib_respond_udata(udata, params.resp);
 	if (err)
 		goto destroy_qp;
 
@@ -4626,7 +4626,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		resp.dctn = qp->dct.mdct.mqp.qpn;
 		if (MLX5_CAP_GEN(dev->mdev, ece_support))
 			resp.ece_options = MLX5_GET(create_dct_out, out, ece);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err) {
 			mlx5_core_destroy_dct(dev, &qp->dct.mdct);
 			return err;
@@ -4785,7 +4785,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (!err && resp.response_length &&
 	    udata->outlen >= resp.response_length)
 		/* Return -EFAULT to the user and expect him to destroy QP. */
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 
 out:
 	mutex_unlock(&qp->mutex);
@@ -5485,7 +5485,7 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	if (udata->outlen) {
 		resp.response_length = offsetofend(
 			struct mlx5_ib_create_wq_resp, response_length);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto err_copy;
 	}
@@ -5576,7 +5576,7 @@ int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
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


