Return-Path: <linux-hyperv+bounces-10765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iARiOdpvAmrkswEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10765-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2AD517C0F
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F9513029E4D
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 00:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A913AD05;
	Tue, 12 May 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDcG4E2A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A186329;
	Tue, 12 May 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544592; cv=fail; b=M6noV4Sqn3wTZWZpcpF0DpktTwON5X9I4lsjNjvIivFugtLHXkSZ3PbmI6uG+rnk/f89jr9p8pQABHt9L9LbV938jz0pmD6nsE93vdB4ALHjHP96v3whDBDNd7i4aXLR8ayus9T9pLp2cMEmTsqGvNJhrVKfpyiYNG+hwWFCOi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544592; c=relaxed/simple;
	bh=xDaTiOBvqxxMswppf/clKp7ZHTLcbwvMSsRfs7cdC6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOfyTZZRO92M1YnMt1hqu+j3YRjCqXOGJLT5oYL6ikSvg9lGoELOJ8wZG42vI2PoWvQuMcuS4RESmqQ3SLsCDlWAdhJKbeJ0BOzY29EpxjBDDXto/QD8+2mNA58YlWHFuTJfHn7cZsZiVllsn4LFkyb1Z1kQR7zXmSv6gAof0K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDcG4E2A; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkJH4NGgUslV8tHAztb+atbAVZnoIi2GhQrBXcC1DXvwu9xAB2+e+rLRB0inDUEQx8D19mfgdF0vymuYYG/J41UG4ZshyUcPjrh+G18fQ4d6P3lk2vj4cqxLveb943zU/tn08MK/X6OrUqE/oxRZ9Oh1usQe4ef7kLTHsk2+PfXftx8li1Vx6rcxJdhOwTjzU8NlZWdMu0MIhE1Q7NR72SPqlkm619azRx10Deqn0kXPloOndLrZ0wnSzICUu3vqsInhnXbeSxxGI0yn7w8Brgs5beUJvXagQ+IRhdfDhs6cU7dcfttu/XxMODirzAvp1+NXXHPK5DQikIO+WDJ9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQwyAAvkd39n/2czbjHa0ovkwSSJqmNRST8sxCqm4b0=;
 b=siL/MMasMeaAbZ4Yh/wpE/cRQEyIAbOnP44Zpezu0BYcYqY+XTG6XhZM6P7w7kuB7nFcvuMYrZJjEHuU9GNRRKx7mgOX39li+0awQVP8OVVC247OTXFyLMF/boav/xj6zRsDQX2js+K2cTLs45CFIcUpcGmdbtqAAmv8QoQ261eC29nnlzGusBu3ajCLzV2YmmQmOORuNHeSs6ymMRyuFpzeeOJZ3GQrzJR8IuncIO+Ns/epPdWTLtlnbpfVWx+MXOCKPwL4yYu6ludLCgtYQdTJgOS3ynUaYPWr61dpp2QEOXWwwPqwjPQBkc1NJEJ/2Xt9uDZFPpyLiAvRNcAhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQwyAAvkd39n/2czbjHa0ovkwSSJqmNRST8sxCqm4b0=;
 b=SDcG4E2A85UmB6l9GKVnYuVORyDle2iAtPmgN0tfXBv6dJhWjBmvkNnZhKFI55MD7CDMmQPKBqMrgRh5W88cPnWuo2IMUJR9cCnKQgKOMENbdXVMuKm9rUmWy0X8RyXA15VE1k6PKyydL2Zeju/sXWhchMY4qcRH3h07HiXYjtbsx9k2QNl8l31rPBb9TuNnhS+GkJokk5TN4rUAlJW9Y7mM7wT5nsg9Fwr4MS92Pzw1gUcBVVR/YenIyiHtswG4orVKjWLsoSqpXld3O6UbgeuP41Jm5gh6IDgCQLv+enPLzGuXN1YxIDj2vcBWtcwL0C8H1qFCsqIn8ZNSPkmg9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 00:09:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 00:09:43 +0000
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
Subject: [PATCH v3 05/10] RDMA/cxgb4: Convert to ib_respond_udata()
Date: Mon, 11 May 2026 21:09:34 -0300
Message-ID: <5-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0429d46d-e89f-4c6e-d0e8-08deafbac406
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	2N0Nn6wC2AlvoJvB6bJao8UcUF43XjWitjoSrOWE6fL4TlY5/+RsDXxIpMFyn9G60X9RCvLGBPZ5nHy1jidfeNUM0Lf8E92j2jOjXfxse8pTxJ/Imzyvsr1JtS1Kzd4u+KYOD74MYu3WHBM4tliB709HzcTi1IcZQSloODJDgLlyQw2/PVRLp/jg4u5JeZyLIWs6oCSgbdUhaYAxe5yDfs1mpGsJ9KLm/7M/NAFxQCQgyB07/FpxXzTAxNFRGr7z66UqdSyAO9m1h673hZ5uAHW1ay0wdT2M+lFVIiOVv+DPrKXwVevMjLTCyt+PnPbDtwkHalVLmS1Xu7E52evY2lcIMRkCVsGFwshW6h4ZRl/PJEAI6NnAvpU1bjknn/V75INPXIzeoNqUKFLmcBU9Hn/nJnrtIeHtWi7mXgoOn2p8H5Co6YeXoLXdrtRdr/ynwQRXWYvIzjMq77fBMclSMTDgPmsgBddhhkmA02hUTAhLaL4eyXhenRBxyAKD+vy3Hx8N/U0LtxwguqICYuUHhkg047Uma+KFysIfDkXqjKlD2KLDtn1a8EzQoBnvsk9f6kXSSSPAPgfjgpFqYdqIhGICHwGNM+2Qjn6VbbRjU5d6I4b2jTf1elDTpj2ky2MvRhdkrdGzuRRfs7EuoCy5h2CUxZWViIlGcW+TGjBYzeCFzg4E0uzYi3qX4EsBn99v6CPGeS5E8O2CtzW3KwcMzLHoUUfMCtNZ0TGdX45H48s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?07/fUeXvY8+cVEHuYctMFvtiDe9xrVydrAccyyBnMkts4Ni3trkgs5cqZ86u?=
 =?us-ascii?Q?Z8en53i8Fk3soy+LD4qZlAP41EqD4KTc/vApaR6aUxYtA+MGcXdc2weZB9km?=
 =?us-ascii?Q?0sYpEaW5AJGln1xBNZUq27KkwlVzDqugyv/WZD3xxqaVkGdWDg5sKxwf1XeR?=
 =?us-ascii?Q?T2UQ3L0oKbPYys6M/moE6vJvVHrwi/sQRg/7n1KH4ljv0BjOTMIreVwHY5uz?=
 =?us-ascii?Q?JLoBzs862yg7gSXy1Fp2kl5QM7SCIYYYyaWeSCfI9lvc/Ugv3UiT34PnxIiF?=
 =?us-ascii?Q?6Kp20vwu2X6+1mZZ3PN7Md86pvI0qsnjrSvt2xKWnKA3Hw0mWzaHxe/VlVXd?=
 =?us-ascii?Q?YA9M0OeaYDpzUAWY09jZ+cXoNeOqyjmWAzX/owTIR849yr1rfQ3tRquYnLW3?=
 =?us-ascii?Q?jPLre/w1G5nl9tpJJKNAEh57Tle+5XzsimD8gP5J7UaUlADyUVYUu/6hJkPz?=
 =?us-ascii?Q?faW5bsB09GgiYZkXDP8rS/oeTpa0rpneRLOuVt6fP5w9Z5hnIhek52z85rOS?=
 =?us-ascii?Q?Uxwunm8DBt/5dYxhSXhow9CZqrOD9D+njYmXFtrgWLO/wTem1dqtboDQaiGg?=
 =?us-ascii?Q?PLS1J6XaCSSymoLEQtDA+zEmmO5MJFLE4VZrzIywXVIvgDPtnqPUEKAN62ll?=
 =?us-ascii?Q?jMgbWHM65vcQAW4HCJXKRAcPpkRXjBevH5BE3Y/w7PuZsDeUgQ0t/eoD2VoA?=
 =?us-ascii?Q?3+aSAkjnIANYFBlHcklYaatRr9vY7AA+lKl5DoPOn2Hl7ccmHHvO2lySDzPA?=
 =?us-ascii?Q?mvTPEMCcygmStxQdVdKJAEYkQ5rwXX1o/XbWc3EesGgidiVYqlgNjlPCH7Ui?=
 =?us-ascii?Q?o9SQTp/P/UT28fp5GAH++WAGpRhSJ7luR88ePqAnaVOHdxUkUwGibrfFALHh?=
 =?us-ascii?Q?Q/use78939e24oFLpNfoi4RFj1rolQiOXE39bBr8Ag+tgHzvAJ+yjP3dpOd2?=
 =?us-ascii?Q?NAJ2IscuS1xZPDG+Jl+GJvDurVCNSqfRF4VA2TDLpLu4BOG7cakOKDcn0Ldj?=
 =?us-ascii?Q?W26rK6fgtFkCuiLlxaGC5yNn9pY3KKKwZCiOPdE0aPNCHWBDXPGsxm4NLuC/?=
 =?us-ascii?Q?wkvqV9Pl0o0q1r5uYAGyMng1HVHv76xfGiRfSTjnK/GwHlKOkR4LnTRM8JQg?=
 =?us-ascii?Q?s2U3uxkKoL7rd+jx09Svv1/2fMqhjExGWauWO7M5I9QIYYBiQo38loFrYxiU?=
 =?us-ascii?Q?LZZocVeX0jTbNd4TVEsZOsXq/DRUyWi2UIpPw3TgnbET9pYAjw1KwTfeDOMy?=
 =?us-ascii?Q?rtfzcYVj69sBjYfOLoG25KmmVTu6s91Mbrw95VML36tgccD3gdq1hNSiqwYx?=
 =?us-ascii?Q?ZIPbRYKslQ8SE4vUEVpOIFf5lX9ZaPRvTqEnhGjMf+cAegAab7xdvo6L1Dol?=
 =?us-ascii?Q?sQP2nhhoFBg1cj74jWcJa4FDoBOLR2pjYGZhlIfrUVuTIt2yBUQrX1XxRAM0?=
 =?us-ascii?Q?eAjTwpym7f393apZlg7nWdFj6p3mSYdC4/dFfqsb5thwESGhzjzQURkS6slo?=
 =?us-ascii?Q?BsP9wWn3o9gAXzIb8KpJCinkJpsYmHr8xsW8i0iIhWLQ1ujD2dF8hDdOv5sw?=
 =?us-ascii?Q?N5Al5XXiavdiZW2g19NGq8r0jpnzAMP8P7ycl4xFSQsnx6zhSGTlkJyRGqlU?=
 =?us-ascii?Q?Swg9U7vsu1SOJtE4PhSsf/INMLdKgm6L67KKatneko/BW/USZJyJRrAPuG/w?=
 =?us-ascii?Q?saL4e+xdG5r9hzYib9yFDaFGK1NZ8zTa7l9B/Lix8GuAAe/V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0429d46d-e89f-4c6e-d0e8-08deafbac406
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 00:09:42.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fg5cA2lcZ81cKqlxBk2Dn3MkiD/y4JfRKNvvGSrJ/vyJMa5G3aY2LJihOC3E42P6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
X-Rspamd-Queue-Id: 8F2AD517C0F
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
	TAGGED_FROM(0.00)[bounces-10765-lists,linux-hyperv=lfdr.de];
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

These cases carefully work around 32-bit unpadded structures, but
the min integrated into ib_respond_udata() handles this
automatically. Zero-initialize data that would not have been copied.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/cq.c       | 8 +++-----
 drivers/infiniband/hw/cxgb4/provider.c | 5 ++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index e31fb9134aa818..47508df4cec023 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -1115,13 +1115,11 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		/* communicate to the userspace that
 		 * kernel driver supports 64B CQE
 		 */
-		uresp.flags |= C4IW_64B_CQE;
+		if (!ucontext->is_32b_cqe)
+			uresp.flags |= C4IW_64B_CQE;
 
 		spin_unlock(&ucontext->mmap_lock);
-		ret = ib_copy_to_udata(udata, &uresp,
-				       ucontext->is_32b_cqe ?
-				       sizeof(uresp) - sizeof(uresp.flags) :
-				       sizeof(uresp));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_mm2;
 
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index a119e8793aef40..0e3827022c63da 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -80,7 +80,7 @@ static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
 	struct ib_device *ibdev = ucontext->device;
 	struct c4iw_ucontext *context = to_c4iw_ucontext(ucontext);
 	struct c4iw_dev *rhp = to_c4iw_dev(ibdev);
-	struct c4iw_alloc_ucontext_resp uresp;
+	struct c4iw_alloc_ucontext_resp uresp = {};
 	int ret = 0;
 	struct c4iw_mm_entry *mm = NULL;
 
@@ -106,8 +106,7 @@ static int c4iw_alloc_ucontext(struct ib_ucontext *ucontext,
 		context->key += PAGE_SIZE;
 		spin_unlock(&context->mmap_lock);
 
-		ret = ib_copy_to_udata(udata, &uresp,
-				       sizeof(uresp) - sizeof(uresp.reserved));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_mm;
 
-- 
2.43.0


