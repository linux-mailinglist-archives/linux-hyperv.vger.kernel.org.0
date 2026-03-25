Return-Path: <linux-hyperv+bounces-9794-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GJUNqZUxGljyAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9794-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:33:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8A32C812
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 572853031820
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A8390200;
	Wed, 25 Mar 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YuTh+6Yk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9B38F64E;
	Wed, 25 Mar 2026 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474114; cv=fail; b=MPx1j4Rbny88+hl4SHQSMN58xLeWb6iSq0Te6vUFMJQrmZcigoJ2D1nCwXP2Uwn2MzksRZVY2u4Fy8i9wAL0dhWSiD3YK00ZWOLYiTb4xtLoiOdzQf79nVk89aN9yA2SZ1g4aNHYVQt6nZ4oDM7ec+KKCtg2jQt4Gzn1jSJmYJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474114; c=relaxed/simple;
	bh=bfAfzyePiqbHdYWHMoyA1rtHyOzIm9Xd0V7jZkr9ICY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BCLsCOwb1PHtuynV9maVlmNOEBK33kr6zEIa1oLtrjI21ZsigkjJwKJh84NhOCaOBuk9Ao7GTBcGoktVSMT4ZK69D5Wg2rwRsGs5LJy+Ja+shoveGQ+6YL1DZ2YZCd/W3LI5acBzIHSMJLMfcTNDm4P7m6FFVSmHBXu3mnnAeXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YuTh+6Yk; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGAbgHF2tvtRZFVx7lHV+NpKAfXxEec+/zKGMCwl4C94O+y27tYuL+m8mRin5E0AtHHtbXJHIK0kTJ4lFwAgMbdwRPnDIof4ltzOR3YWXayZTqZzXOPO1Z49lLCkICmwPRfSoHgk6YUROLTQ1hdvhQayIjtK8zK2npxRZBWC80ZKfmP+SgzOvJrFcOX8xWjWY3x+P5ZqujCaFO5Ssrdi5F/sCI6zpYgQrhxVHAgLeqK544GlLyfzB1PtxAklIkAIYfo79dQumKuVrHzH8xN665eyovq+y1Dw0/VykjXKxJMeqf/JTxIPVKSufbcPe38Laek6rkP6mI6BzwJqTSmeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qYatVQC3hJ/172jDG0MPH20t0FfT/hn7wWK7GXDNNY=;
 b=Fybyxdh2nxMiCnxt5eNG3j2TF3W8qDtblWHii71267lvvbRAjlMkOGFxUYmsD76WCowKMJxZoh99bJ5hxf9leebsfAnU4yC1o7+6HVlRHo00f3jWWozBImaueoTnFDiAhJQz9twHFVoQIw1fRsTJpTz9GSEPltDtnngCn0+Ifwig1WAu9yt/+uifVrmtI1aHPiFZpDFLBSq1AnVgd7JzRMFeajmrWQ/0xQcKYZC4SzEiTN49aNt/yY+8PiYKLVoOI9PoSkJU8fT2CQKGr+wOCnFMsUZUkClumED4Oc8zGZSlsxkS97JfXU8xt2wziHoS2rWuuqEvOCy4p9kdKnbAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qYatVQC3hJ/172jDG0MPH20t0FfT/hn7wWK7GXDNNY=;
 b=YuTh+6YkXNFFXFuJIXX1oCSH5Ktct7ew/Vkrlx/jogUovewWbzdY3A8EHNQ0C7lAwWctKvJ7TV1N1VmmNjwp32p5G+LTFPhD6FxvZIGqoJYQ9bE88jwVIhzOe8eUBQ1MJ+JPKVAp2w+zFoQDyZz7KYSag32jHcORzuZSRsAevTx9XoSp3zG76tXMgP+R3FV1QAmdtsWb5GtzfKjhdOBeq9w7omoentSsiKVgWQJ8RqponfY25QPiuSUd/cIR06k26BYQ9NVp/2roj/FsaXgFuvDRU5AilOzwVzrZUT1KkvUMS+25mWckaVxgK7V8D2wAoputj3nYezKoC8clLW4/9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 25 Mar
 2026 21:27:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:27:13 +0000
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
Subject: [PATCH v2 08/16] RDMA/mlx4: Use ib_copy_validate_udata_in()
Date: Wed, 25 Mar 2026 18:26:54 -0300
Message-ID: <8-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <0-v2-f4ac6f418bd6+12c5-rdma_udata_req_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:208:32f::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 71351a45-3265-46d0-06f3-08de8ab5449f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SXAv9swUgAjyvOtplpB+VStJ8t+yGzblps5tEtGGF41X4ulkbEbvD9tyNQlvTG97IqA764ahCMjDZO0b0GBSEe1ai2Pzovx664P3luFWCyHfpRwATaVsVmrDP8KZ3pN4gV4Gsrzzdk7AWvooi8l2J/wSj/u2SIt1C9YzbDRd8kcDHn2kEP63nKHys3XBo9h2iPeQ9ARIAWY0dXrt0IyqAFnieCD8OacwKES97H+lBGlECwNgVHZ6KLi8wUs4ZSYJJHUDdRDCKsoLQ24wPY0JvHkNX5r3Wn7RYIxcghB4j2rmZuiN6kz07fMu0oOhF0LfG3YWF66mAxMSZ87JtXditFC1VdUQygcap4Rdu6qmJNGlLy4vIYa8G+epPuybyX5sDy0A0aHJAwbUTVOedo38e4x3WP8C7LnokT28MKWyE5XDTDf6LIceiXY9QoVzgiXU/mKlafXpSDRiJNnRgtI0+AAtCIpguL8Rc8AFkjMgJ/njXyeMXFzx9sEb2uDbDgSyn+UYI8JeOExRmsPLcZiubEiAS+tNUJsEwH87rnIBwTcet5Sqh/cBghuvxkAiAX96RkjNKWMkY2yyTmRzjmgUEQRFyDFVEIHyMWNuY2E3oPRdW8PleNQS8qHWqcDKcF8Ksk4sOfNbJmIz/Lh+tGkc/50QTXgjncX4xzlCpVPY7vLh2ySgFSAL4deUKhD4HhXH2ec0Xk6WGmDseSgLK9Uquzf9laQFlpOk65i1HSFKc9KZ9wjEWq8MfwGhiGzGcG5HcofPybw5Y6FDI7kVkGMi4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qV/0UT97pFc7w78unlbuEFJBpEMRQJJJQns6zuquBQwqALzavUGUfIY4ubtO?=
 =?us-ascii?Q?RhLc6orA/g9f6FqbfWr9GSPHYLTFGd8INdHLuHmzhSDXp+JRxcW0hAsT3mh3?=
 =?us-ascii?Q?qHx3kPpwdQgD2A3TWBgHNXHg4y9sOjFprEXkspcqXSME8jXjURKfmjNYGBAs?=
 =?us-ascii?Q?/nuKhVLCIBFNqEGrBMGfb+kpXZpVJTY35gk7UbCDEx1oWGauIEG9i2kJhFth?=
 =?us-ascii?Q?wfyWZ9sWZxxxGoAm3BrYvMkxda/NW4aVaruSrO2DMrFOYnZgiNk2ZY2ZobsZ?=
 =?us-ascii?Q?s7v0IJ+XVC/fDc+oZAFSMuMiUcmE2A5Q8JPidwKFtZH35NKBxh5E/bqiVMvW?=
 =?us-ascii?Q?LTUNLr7GYWxmC0h6k6xwcd7yLIITKUDZ/nS1NXtEEUIASbAbKvR4PutWK++F?=
 =?us-ascii?Q?KiHkk9EKxF2Mfe+sHBVKZ2m0i/ItHCnI6Wpxx3Qj4HHZY+CGmwnukSQB1nVv?=
 =?us-ascii?Q?n9PjnG51JnMiR5E1L4AbzZxa+jwSC7wPMdtOxBpATSRFrReqsGuchUCeAqpG?=
 =?us-ascii?Q?HCFTIkh7m1kHSbDwXuSwurx349LxpxrUUm9uxzL0SSxB0sqHIc0FsrI5TnwY?=
 =?us-ascii?Q?41cuTN8trfQmubRuQDFo/aQ2g25gL8DSxcb6PCZthXryRINQOSxhZo6pUCqA?=
 =?us-ascii?Q?I5NBX/OP00MFHaAlsWwdS+1JQ6QcSCdtOmMKYhKVLGId5xEF2+mXj3PCNlYI?=
 =?us-ascii?Q?HfFLUN6baGrq5aL/llDpX7rhgefZ1obkNl9aa5WVmHjIEmzFd/alvRG6z0E/?=
 =?us-ascii?Q?gEiY4JuCMcihQO8fbxuPojp9HDOp5QWxVd09bkIm6rJ0tUPyLirvKTDiWOHK?=
 =?us-ascii?Q?3vjzVKundMmrmqQ6adZH6v1RBJ8aLjY1onXERvxA0vsxZghDGivqGrkYqztR?=
 =?us-ascii?Q?seWmN0t8xcYxZGNYi73hs5Fy/WtS7V2NkLoEFCc8w3fxAa92LWd9pc6v+n5N?=
 =?us-ascii?Q?41ehV1i1PmC8H4PxKFsaN3zaO1fWAAEVgWHV/zB1gn1QNeV/waQTrrDAvnm1?=
 =?us-ascii?Q?l/TtRo5djfCUzzKVJT+XGZgaKBthfujlRvcAWnYvIHc9mc9Fr/gCqmq/HHUg?=
 =?us-ascii?Q?Lp/eMo2Mo9/iwxmu0JAAMxv4pTB8MZlvWHxbSIk8mECrqGL6YgL2IvsF+yL3?=
 =?us-ascii?Q?yupBjc3xsQlyhSDgRys7oU2o2QdI/fvE2bVFLHkI5sL7KXbzTv7fJJNcbiIS?=
 =?us-ascii?Q?eLsIoNaE9dYYmT3kZl9yBK8C2gmS2Q/6V25D5roB89Z75S/AZhNdkX6etsN+?=
 =?us-ascii?Q?VAkI8waiNDttlwkcmEiUYomwXHi0VFv7erq3ZwCI+B9Ch2W7YcUwAM+7asux?=
 =?us-ascii?Q?yD9PYWqVEEaGe84/+oykD+itXnzPiJRzN+o+i38n0jwyvXjfn4cWUknPX/cu?=
 =?us-ascii?Q?yDsnTfjSKNhDD8yTxSnh0UrAB/2E9HLbWaEIpcN2of4f1jHGWRr/OpnM82Pf?=
 =?us-ascii?Q?ZUSY7QFlZfG7Ozo5AxxIOg2egVSit3Mu24Fu2nvqX0u+Wqf5iVLF8DeeGgp3?=
 =?us-ascii?Q?P2uiEWDeTh4Umzk3KbAQYGBslaR/9txEaNucZOdLMJO30IgilnGQdkbPtg9r?=
 =?us-ascii?Q?NIBPJ9Mv9DILxq0ZaniX8nFhl1UNmOhLaJQRBY1g+aZDXgRs2O2GH4jKyynS?=
 =?us-ascii?Q?ewuLErpkwPnaJsuJdeQFjY/3pcFMqhQ1jfIWfZ772VG7xkPCBCv6vM+I24oN?=
 =?us-ascii?Q?KmehT/Txa+LKxgPUp9qMg/z4Tca7eNHmrlju27rlgJVfrgTI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71351a45-3265-46d0-06f3-08de8ab5449f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:27:08.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb4iA3cITmUp7KrxgzcUrMaBRjtKoF4fUTMIWFGIInRQPBWtEsvmo7zq8qLUoEXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9794-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AA8A32C812
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


