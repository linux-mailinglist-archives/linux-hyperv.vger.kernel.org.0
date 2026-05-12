Return-Path: <linux-hyperv+bounces-10767-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG2gHeNvAmqZswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10767-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF20517C25
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73ADF302F70A
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4614BF92;
	Tue, 12 May 2026 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Arp//xnT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCD54763;
	Tue, 12 May 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544594; cv=fail; b=IQLnmZlImGT8RaFtGXY1MozsppV8HVTVUdQPCh+/ZOmFrDfeKv4P9RWBBJMx6kIpYx2pkR2MHUZeytyQ+vZ2Mc5W0hX1fFkQMdIWL2WbdUdV+kCnauE8GWL2d1LPzrYkI9ynZcVvKe2kLyr0ZCDUpWt1tQcv+iUKF6onC5U+LyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544594; c=relaxed/simple;
	bh=DchDDj6Wk89RTdSccEstGY1SwKHVStqk6Pq6P8llGcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plFxAuMuzRdLGma++eTjkpckTFGZDV2jrueQckNRo/+ORYZFV1Gw7Gu3wjiiH0WkyAquy3XsRUzVcFZC1JBuMTg/6FD+W75sfStixzLm5iln1pUvv/sGdsKr3x4361VlXK6njpw9e6X+hu41lo9eMBMc7Xj6lQp+twltFVS99xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Arp//xnT; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imwWxxOzkQJGGsIABZIIRCoPZiPsFD77oHP2/PVWSLfnMaLiqrNj+iOcSA3E5Qt4VDp+jwoomLPvsUEwUGoVh8TdBnXXMnS/4ECNCfOAy91Ydhhyey0xJsX/4U4oP9ESD0kgLEZcfk7FxNFrwmv59mW4ZLJbFlJKl9pbvWGC7ydnWL3Q1ABbVihKTAli11r0PENg5iXWf10VYcjTQ96Z7GEr1kgrU6wdRRtFaUvAjq/y8s6899i2bHifq6ljBjKEDSOpyu5Rc/ZqnR6FkkYR7hliXLnQhPzjhkza9CuVLIw2HKva2LN35J9fa4fNUtRn2U13hLxU+chgDkrX2qT8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBPE76Jd7GCkqbZZ02TH8kdJJCOMj2wyKwRvgON2uTo=;
 b=NxiZ+FZRZf6ulEP4XfCBeV9xBRc2DJD+rGPA6tmUIhIWo9QfnJeOLMryr9tDYqlY9rVnsbwF5P9QrWiAAwCf6E9sIsHie0OA8pSOumdDTFDWQE31TZf3damA1qbEhJ3oPu75PIP3Mv/vTAmLr4WCPvXvE08tJn2RU9eMxL5O76zWjcTBVh/bCh3ZzQ6oFGud2hY9HxD/woGdlPWuhChiTGGOU+U+C0V265WPaGV3JNsiWAgHLTJ0d9ScNbgGLCgnEmJpAhA6ZMbJqEWQxGB0iJ7atN7ZFSrc+sc+Mai3y9zlxdVX0r7j3TAkwU3Ie4W6HG/fysULpAwpo2gv0FIVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBPE76Jd7GCkqbZZ02TH8kdJJCOMj2wyKwRvgON2uTo=;
 b=Arp//xnT26HlUM8/xAcOQhO9y4ZJ0olo3vBsJVjTOnl5EaXf7kjqQGJz8/Cb3J3NzJdW6vimWHJRhu250G5X2h2iVYffMaSnOiCa6IgLJ0Q8smuT0hwDAZRPNCkFjP7yhcXQWLwKCMpQ/7WI6L53EfvaCGlIfxl0nyiPzIFno+jz4+8jFYsym0iwlMbmstJXX9bEJ3r9el0FgBS2glkrEQsGRITMZi9KWdRMQUYmv80KeYn5sv7zDGQ/AxLLWv4jHDTDLL38J4xHsv2X1T7XYdYixfxPBsHObI8TODDF4FIvP/U4f1fLgRJWnLe4MYUGXMDyzf8koTO19/p+XHap9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:44 +0000
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
Subject: [PATCH v3 10/10] RDMA: Replace memset with = {} pattern for ib_respond_udata()
Date: Mon, 11 May 2026 21:09:39 -0300
Message-ID: <10-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4f328b-3890-4370-fe54-08deafbac430
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	9WcR5hF1b0mjvDoDfZsA02N3ZjSrvgteOZZ4XyfmoRaq3dGHNlDo9t0As4cE1uvf2tBc/NaJRbUM5VVae5UkxgbhMJRdV7lwZPeLwmG9aI393QdFT86k9U3IMqGLY0+DAcSxk+ZXu+Dh2h/39xOgeMQoo0d4SC/QZdVRYkkpidK0GiLuCbw5eIwsdzbvtmcIgRLOS1QCiftpeC0JwcwDYuVg5UGvuN8iaReHQ0QNE6fLqOmOZ55MXzesnm+Wl+kSyGEY25YjX9jdAzabypQQDk/OFqLIjFFnk5r78t/M4dsjWyR5rXcv44rIqXZBbDV7S+Q6wb1iOoDdQzFKCIRcDfjlqykXV++x6kd63YIZMwJtnM2yREW/YX41sMWeWVpcFdkMvMA9FdXZQZGY4guInHKTzyJ3trzEkdDXBRX2py5QX1GTEdgQFMv1aEX7YnKqymGtmnvqK/wvuA81gmkUsT2VmqwQilRlP4FqNvBtIHrggAHRYJfkDdiI8BVFpKTTn2pqZxOAApq+oJZabImG51VdYzY+pRuTTTmy+uBQRMIrqFflXIBP1Vtc+g+F9lnVHqfsHG5d4qU5EbpQQe5WP7Drv2sM8eJiM5c/u5ykdZCssIcGUDXL8hHEmmHFiSX7S3EbAAC/aY5ofWzQCn9ceo7iaq+KeV9P8FYyOQlnNXwzEqEq1ulEY6PwKz6rZQmaVXoNarHaunq2mLDbzlzxZPwv7BsJ5pHoSfdtE4qAjSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKIiXvV7sTJQD3Qm690pWxhoeNBU8+Otryx/T8SkW18rgq27CED4CEHvZqV8?=
 =?us-ascii?Q?+9kQHYzHf/K9jscdZtFuIZEu4fveL2VYzXXtGhypFWTiiXnS90RAC6oZUltI?=
 =?us-ascii?Q?ARbzQ9ird8iMyfKbZAmSghwSsHy/Mh2GIPZPBkLlUJTUd4VKG3ed89iuksqg?=
 =?us-ascii?Q?bQfr6+QHaMUATacpCfILhpB0i5cLEPkQZqgNKJjHJFSWMgv27Qtyd0MOuIAm?=
 =?us-ascii?Q?sbYUtSR+fS91n1yiUU/X5e+lxvfksvELgcaEMTuQuPZDaPkizRXgyNL1gdKP?=
 =?us-ascii?Q?OquSr6Sf3THlcEOrmfk8ibVdBg8u4xn44bY3hvP1NSkEcMTKJNgLMrOmMejW?=
 =?us-ascii?Q?ywg+4QqGu5oMx652bi7bVQ+X8RlnJ/g3EEPd/rgH15Rz9J3zhOL/Djzk1Mjg?=
 =?us-ascii?Q?ylbkQvbW1BLSbUqV7kek8kfY+CLUko4ZIPMnj4WmaSFo74zSp4tL6RNMyriY?=
 =?us-ascii?Q?CGLs9r9ValuPIQXC8GT7oqgzD3+P96NRXfdQAKLX3FDb1rkm/mKzVUu2vMCO?=
 =?us-ascii?Q?e0NjFYEObtO0FAkQYeDQIp+ea36kJy+S3cQ9TPjh8B3LwCKaZ992G9OITuXA?=
 =?us-ascii?Q?u8dOPS7wrtnrw9emN7ZYe4RCY7W1yA7xFySP3AfrG/scjaEPnmMgx/x607dl?=
 =?us-ascii?Q?RLUnSwWIS1wixLkRGFExzKu+coMmLGoaekkXM3EN3bvTOl4Sb1QEbegRV98H?=
 =?us-ascii?Q?vSQYHMKw++QK+n1sSuQICoVkPsKOujemCHRopQRgl7XF83abgZFamZhKctH3?=
 =?us-ascii?Q?IduvmrjxEcN+qJ66uh/woAiQZaPeoDRsVO38RGBOO8/v7/ApYbpBf993Hu9p?=
 =?us-ascii?Q?Bq/Rz5pr/UFlm6QfwiDSjG0OCsVrXkiDbQaoxl4nsmu1gKVNtyiNkuSqsLjR?=
 =?us-ascii?Q?zCmUNUYppzdmz7eskmwAuUJJbWXowC8XvQxkptCF4yJt5C62C1WOcsFi2oAQ?=
 =?us-ascii?Q?iFBOc+4mpOBIf0g/YrsH72mxrt9n86wQuwp2Fksa7eBb8Y21CrsRf7CHPI9a?=
 =?us-ascii?Q?sW1gDak7pTPnPVsfV52zA/IwslpJOr68a2NKH8P1kLb5PqYHXMR/kKDdbgCq?=
 =?us-ascii?Q?iMVqjHTyCOjbBhVo5XyeMoiGZ5H16qZZOVL836RkRVdssSc0DjA/IUWUamiB?=
 =?us-ascii?Q?btNat618cWqQbVgs3BHAemQ2Mz4nm3nDPXw3kZFtJvOHyaBXEoc6JgkohVpz?=
 =?us-ascii?Q?2TclUY2HCAWw68pmMTrW5vxZHy4TGHW9WzKwhUGZBWk134D4qIJa7UDiVon5?=
 =?us-ascii?Q?v7W4kZeHwMIRfcvONjRb/KMbhr1Gz2N9NNcZrVFsVAku0tmveH/2+wnoqQ3W?=
 =?us-ascii?Q?NHsRrRsQ8b4meMIigV66YzedTpYFfL1WkxsTjvlpTS99BJJmaQCTwGAnPZn0?=
 =?us-ascii?Q?4iYG6obC+5+7fXXJ/HjIYQ9avUjwhkwwMgPmhJv8MPWZF1OrKzZLTHT3cmZG?=
 =?us-ascii?Q?D7echhR11LfwLQVs7KodF8WWOlU6ifWt9Jce3wbpMWrH0nfDVgKsFpo0pBw1?=
 =?us-ascii?Q?iCVqJdbJBzbbyojiEFvzbnWU/6u6LyFzj/mtDvZNdj3Nc/tZ8LzEhhfG+/7Z?=
 =?us-ascii?Q?UOaAGWmQAZ2lK8OEw8XN2LobSiCAizqZCmQhKDsQu3CnV7ZZFztoNABzAU8M?=
 =?us-ascii?Q?g2gPTFKhKE6Db8X4CNjCgbotUU/cnv/x3rvgcg19md/teXeka1ZLVOcw/kuE?=
 =?us-ascii?Q?HPHf2VoE+sILbNIIEOfR1BeV94XSry8gK7doEC1mDuPgdbjR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4f328b-3890-4370-fe54-08deafbac430
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:42.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1047ouh8EdhiBxtaK3aZ3TPw9pRwdKg71PjRiR3jDDr23cgjGL/0jprHcCnZnU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: EEF20517C25
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10767-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Most drivers do this already, but some open-code a memset. Switch
all instances found. qedr_copy_qp_uresp() is already called with
zeroed memory so that memset is redundant.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/cq.c             |  3 +--
 drivers/infiniband/hw/cxgb4/qp.c             |  6 ++----
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  4 +---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 12 ++++--------
 drivers/infiniband/hw/qedr/verbs.c           |  6 +-----
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  4 +---
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 47508df4cec023..d1517f2560b981 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1004,7 +1004,7 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct c4iw_dev *rhp = to_c4iw_dev(ibcq->device);
 	struct c4iw_cq *chp = to_c4iw_cq(ibcq);
 	struct c4iw_create_cq ucmd;
-	struct c4iw_create_cq_resp uresp;
+	struct c4iw_create_cq_resp uresp = {};
 	int ret, wr_len;
 	size_t memsize, hwentries;
 	struct c4iw_mm_entry *mm, *mm2;
@@ -1102,7 +1102,6 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		if (!mm2)
 			goto err_free_mm;
 
-		memset(&uresp, 0, sizeof(uresp));
 		uresp.qid_mask = rhp->rdev.cqmask;
 		uresp.cqid = chp->cq.cqid;
 		uresp.size = chp->cq.size;
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index f9c7030ac6bfd0..e295f79e0cd3e5 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2120,7 +2120,7 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 	struct c4iw_pd *php;
 	struct c4iw_cq *schp;
 	struct c4iw_cq *rchp;
-	struct c4iw_create_qp_resp uresp;
+	struct c4iw_create_qp_resp uresp = {};
 	unsigned int sqsize, rqsize = 0;
 	struct c4iw_ucontext *ucontext = rdma_udata_to_drv_context(
 		udata, struct c4iw_ucontext, ibucontext);
@@ -2242,7 +2242,6 @@ int c4iw_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
 				goto err_free_sq_db_key;
 			}
 		}
-		memset(&uresp, 0, sizeof(uresp));
 		if (t4_sq_onchip(&qhp->wq.sq)) {
 			ma_sync_key_mm = kmalloc_obj(*ma_sync_key_mm);
 			if (!ma_sync_key_mm) {
@@ -2686,7 +2685,7 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 	struct c4iw_dev *rhp;
 	struct c4iw_srq *srq = to_c4iw_srq(ib_srq);
 	struct c4iw_pd *php;
-	struct c4iw_create_srq_resp uresp;
+	struct c4iw_create_srq_resp uresp = {};
 	struct c4iw_ucontext *ucontext;
 	struct c4iw_mm_entry *srq_key_mm, *srq_db_key_mm;
 	int rqsize;
@@ -2764,7 +2763,6 @@ int c4iw_create_srq(struct ib_srq *ib_srq, struct ib_srq_init_attr *attrs,
 			ret = -ENOMEM;
 			goto err_free_srq_key_mm;
 		}
-		memset(&uresp, 0, sizeof(uresp));
 		uresp.flags = srq->flags;
 		uresp.qid_mask = rhp->rdev.qpmask;
 		uresp.srqid = srq->wq.qid;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index c8a35337ba51e8..b59c2e3a5306d1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -996,7 +996,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	struct erdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct erdma_ucontext, ibucontext);
 	struct erdma_ureq_create_qp ureq;
-	struct erdma_uresp_create_qp uresp;
+	struct erdma_uresp_create_qp uresp = {};
 	void *old_entry;
 	int ret = 0;
 
@@ -1048,8 +1048,6 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		if (ret)
 			goto err_out_xa;
 
-		memset(&uresp, 0, sizeof(uresp));
-
 		uresp.num_sqe = qp->attrs.sq_size;
 		uresp.num_rqe = qp->attrs.rq_size;
 		uresp.qp_id = QP_ID(qp);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 2a174d0fe6ca1e..383f1d9c15d151 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -586,11 +586,10 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 	u64 db_page_addr;
 	u64 dpp_page_addr = 0;
 	u32 db_page_size;
-	struct ocrdma_alloc_pd_uresp rsp;
+	struct ocrdma_alloc_pd_uresp rsp = {};
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
 
-	memset(&rsp, 0, sizeof(rsp));
 	rsp.id = pd->id;
 	rsp.dpp_enabled = pd->dpp_enabled;
 	db_page_addr = ocrdma_get_db_addr(dev, pd->id);
@@ -930,13 +929,12 @@ static int ocrdma_copy_cq_uresp(struct ocrdma_dev *dev, struct ocrdma_cq *cq,
 	int status;
 	struct ocrdma_ucontext *uctx = rdma_udata_to_drv_context(
 		udata, struct ocrdma_ucontext, ibucontext);
-	struct ocrdma_create_cq_uresp uresp;
+	struct ocrdma_create_cq_uresp uresp = {};
 
 	/* this must be user flow! */
 	if (!udata)
 		return -EINVAL;
 
-	memset(&uresp, 0, sizeof(uresp));
 	uresp.cq_id = cq->id;
 	uresp.page_size = PAGE_ALIGN(cq->len);
 	uresp.num_pages = 1;
@@ -1173,11 +1171,10 @@ static int ocrdma_copy_qp_uresp(struct ocrdma_qp *qp,
 {
 	int status;
 	u64 usr_db;
-	struct ocrdma_create_qp_uresp uresp;
+	struct ocrdma_create_qp_uresp uresp = {};
 	struct ocrdma_pd *pd = qp->pd;
 	struct ocrdma_dev *dev = get_ocrdma_dev(pd->ibpd.device);
 
-	memset(&uresp, 0, sizeof(uresp));
 	usr_db = dev->nic_info.unmapped_db +
 			(pd->id * dev->nic_info.db_page_size);
 	uresp.qp_id = qp->id;
@@ -1730,9 +1727,8 @@ static int ocrdma_copy_srq_uresp(struct ocrdma_dev *dev, struct ocrdma_srq *srq,
 				struct ib_udata *udata)
 {
 	int status;
-	struct ocrdma_create_srq_uresp uresp;
+	struct ocrdma_create_srq_uresp uresp = {};
 
-	memset(&uresp, 0, sizeof(uresp));
 	uresp.rq_dbid = srq->rq.dbid;
 	uresp.num_rq_pages = 1;
 	uresp.rq_page_addr[0] = virt_to_phys(srq->rq.va);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 79190c5b8b50b0..1af908275ca729 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -690,9 +690,7 @@ static void qedr_db_recovery_del(struct qedr_dev *dev,
 static int qedr_copy_cq_uresp(struct qedr_cq *cq, struct ib_udata *udata,
 			      u32 db_offset)
 {
-	struct qedr_create_cq_uresp uresp;
-
-	memset(&uresp, 0, sizeof(uresp));
+	struct qedr_create_cq_uresp uresp = {};
 
 	uresp.db_offset = db_offset;
 	uresp.icid = cq->icid;
@@ -1283,8 +1281,6 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 			      struct qedr_qp *qp, struct ib_udata *udata,
 			      struct qedr_create_qp_uresp *uresp)
 {
-	memset(uresp, 0, sizeof(*uresp));
-
 	if (qedr_qp_has_sq(qp))
 		qedr_copy_sq_uresp(dev, uresp, qp);
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index e887f03a84d063..261f18a8368543 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -82,15 +82,13 @@ static void usnic_ib_fw_string_to_u64(char *fw_ver_str, u64 *fw_ver)
 static int usnic_ib_fill_create_qp_resp(struct usnic_ib_qp_grp *qp_grp,
 					struct ib_udata *udata)
 {
-	struct usnic_ib_create_qp_resp resp;
+	struct usnic_ib_create_qp_resp resp = {};
 	struct pci_dev *pdev;
 	struct vnic_dev_bar *bar;
 	struct usnic_vnic_res_chunk *chunk;
 	struct usnic_ib_qp_grp_flow *default_flow;
 	int i, err;
 
-	memset(&resp, 0, sizeof(resp));
-
 	pdev = usnic_vnic_get_pdev(qp_grp->vf->vnic);
 	if (!pdev) {
 		usnic_err("Failed to get pdev of qp_grp %d\n",
-- 
2.43.0


