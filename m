Return-Path: <linux-hyperv+bounces-9352-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELJtJX2hsmkOOQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9352-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 12:20:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E488270C6D
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D373060BD8
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9B396D16;
	Thu, 12 Mar 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BAgY2/mO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0123BD06;
	Thu, 12 Mar 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314426; cv=fail; b=u5U9UNc2CAJjNjxHPFDPkOnROWxUPeE5OeLJ9BUFy3L0ZkFMacdOaPcVZ1DcKLkij1LT229ZrzU3aV7SZbsrRLo0pYX7zUaqk4a2+ckvOk3ghLOueEaUCs6OL8LsPw0HF8DdaAfsjXKH/bAEVdu1TFA/KBaCnVxtLM9GYKVFHvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314426; c=relaxed/simple;
	bh=+I0DgYvu/kAsNZzktFcvCKTj6W4Pxiw7nbtvStIcn0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CSGgJSjKrM2PfrwHBuPu8Sm+YFqnWlZLbu9Zb9l6RXF+RTyQSi2rpJByvtIq2a1X8U83PHgJVyqGMd6m+3LiUmctCIvp1onN1KUyt5vLQmjCi5BfiCgbvoE2DMqMPCAaOHIqcYs1wHuQvo/RL7mQhF0QBrfwgSbYmkvZOKtZl58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BAgY2/mO; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAdh8KL/ji9lzfAImv1VRfGb5+SNQZ/wwjVX5ldLpLAyccss7UZtN0T1UpTS3vcccKIJOyyDcfw5fHCLpxggGNkCxx3h9Tz5/yi/H+MVw9jlF1Eklj2s3pa0eqr3xPWULBKxIo3gTKl3jx07xVS5PopNMo/X0+JH48iM80Ny+2Mw84AHio5aZNH16Yz/wh8PtQcbM2a0bmkCjEqB3Exze6pOBc+JHpoPEpLhasbCfHFlNiPVQX+cQQCvyv7IAdhjvgdCMW8KIs5euObMouX/rwDmFMpoxM+SiBKQw5E2wgZ7iK0kLHKRbLKmS4LnJ4iGTUNFYFtMVNJAriBFiLQsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnQHDZS4FUszDdVgscji8hggYdFWRVPWp9tvW0wip2k=;
 b=OVNfJC9a2/p4msSQDAKOowHdml4O/BBuygl0on/d4p1A4PC0N+jDIK73nc2udZDPoHABAM85b9xMttTyI3cYqwteFshlRE6Jh1K1ieHIT8fQmBcW5XJ0wimYcmYWUPanpFrZ9dcBxr0N+QF1IFRJLPBk1fmb+mueuORUmQSUchpgM28vxYm3KQrGQ0RPY/RLnKpWHWdC86y3iHELTA9uarxnCeLodsMH0Q/9dTMtkmtsb+/EM1Wfpqw6/MrpbEjVhvU+dWbed4kZsQ0XhyRN2CNCgZa7F2BZTRiPEN7CsW+SUcKElnrfcLM2CyZt2QyAt7ABb/6Y48PaGsBWnIoFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnQHDZS4FUszDdVgscji8hggYdFWRVPWp9tvW0wip2k=;
 b=BAgY2/mOnP+dZc5Za8LaHp/s3qiKV9s6nvXtmR26NmTlxiFZbvxJiXG1O723xbv1CGMcvWRDYbFFneuvF511AAi/E3KzHiVnDJqXLXEVxYGwPnb6C5y/CDs2T3Il4jqt1q/XRr7itnr6OP0cv2ibt1SWl0Sq2Bb502tsMWaP7683iyUDau9jQZnslrJMdjRAoYR/6UXAHz6Fd92glMR/3DjccTM8KxCHJ2zZ0xBSoEwY/7/BadQ27gPxFQeL68ka4MTnSSK40nf9M92e9UPA2IaHGiiXMtamaxibhr8bMDQXLLjfkuHjicDzBtSkhVR13GLmItB4R/ibqmAiFe8LnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 11:20:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 11:20:21 +0000
Date: Thu, 12 Mar 2026 08:20:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
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
	Zhu Yanjun <zyjzyj2000@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 10/16] RDMA/efa: Use ib_copy_validate_udata_in_cm()
Message-ID: <20260312112020.GE1448102@nvidia.com>
References: <10-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
 <cf3bbf89-0bb1-4c58-b78f-37afdb2ff99c@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3bbf89-0bb1-4c58-b78f-37afdb2ff99c@linux.dev>
X-ClientProxiedBy: BL1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:256::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7f8bd8-b53e-4c96-be78-08de80295976
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H1jU/SjOv1FMWIYsXgqv7qHIBFvbQMsHxm8kqDpi1ZH/EY5zFq8OJrnAbXT8+ItJrHpDTGt71w6uH7GoUnsLX2cFQiw3S3Gz1rUtH9/01XW5w34I6Cl+qJhAdT+TRTOmrI8X2aRV/HiykkgjQzLYaz1tgs3WRHqLPMtKDE4y+5+/c97K6DNudWdyLew4sK/MT7Aqfg0KvZr8VXpv5ycvhGemHkbaiyYNGEcyB5Ka5XM/ShuNJFUx4Ew4o0XwnI0rcHgm2ni+w19o9J20fH4UyzZmOZs8AHlQjlsz1+pDrIfxjC769JM/Ra2ncd8GDUib7h3BHmBzt940FVVr55qTN3ygyqpogxxYPHKdQVY8M+/NmQHrGypeVnLdf9QiJ8PAl1L0XyIRNNRMY6/REUhnptskbgkCFje3LvUCpUw6WwR8dprgiGvTs0RCzv+PG5pyy6JFYYCe85F52bGm2i4S5O5EhY5eL+JUfYH/RnTc2Pt6wvY21cU582kTiwjSt21dF1UXK2mQKLj0k6lWnOot9FG/uc3Evq27yxAlRI4CzqvnopHmR6E33r1Ndr9g7hngWniJmlNU82vzDPs4w7lwAcWi4M1xaijm85NBOFRDeWkV32c9z98gXYy7UYN/wKD8g9pGKGWODtw8k5USFQWZqUeQOtnsd1gT/99pNBP/zDiC5vE5S48fgLOolMnQJi7f8gwqxCMNPGBj/gY4D3fQ/N4N5octQrnliH2lXUmqOf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJprxtGej2GwWKRMCThDR5Mx44yTU7e8NFMKxwrHJ4XQUJVoTBgDtdLuy8jQ?=
 =?us-ascii?Q?9qny1IZGv00PmA+STPL1ymdHtKnmCE5JXGwQp82qVczRzCtmgQc/7R2NiZsf?=
 =?us-ascii?Q?+/Zt3P60MaVKCTM+96kcAKt1jsFmuoKqWAH8B8Wbs1b6oD7oUkkTWY9q29TB?=
 =?us-ascii?Q?UeihRrVWAQk0vPGc85bcoFjUWqECqSDahgJM4bdJ4E3FfObVDYoK50izmeuP?=
 =?us-ascii?Q?QwJ3wal+CS3P2xKQj5iez/ey0eIUVc28HI6B4RCIIiR/BteEmxuEAn9+EM84?=
 =?us-ascii?Q?NDxtjVh8Px7ggc6HzYfjDp4lPo4SkHz8HL5bb0z4YPhXPt4gE3vadSpx4qek?=
 =?us-ascii?Q?3PIaFJ69EOmKQ5F+yQBicB+ebLo3kJsLUCKBfG1p8dEBWdwI0kmuqnwlLhsy?=
 =?us-ascii?Q?pVs7qF59CaW3ARee6uihkLdITUFszeqxfrz+YlvZoqKJjrEBcInWpsqf4Rpd?=
 =?us-ascii?Q?skxbMnybC8tGHEF+7BWknWnhsy/wkXoM26dDgj4FrY5ubUpD691lzM3QSEeJ?=
 =?us-ascii?Q?e4HpvKCdPuqc8/4KowXxyaiGqTd+DiNKD316ThuKTxOPzK78HkVzA9B+6J8B?=
 =?us-ascii?Q?tV5RYPJ6zLs+RWqVB27M2ZHkabC2SkDPp39yN416RC+ybLI2A9vPK0ptsx7L?=
 =?us-ascii?Q?mFqort2Nx9QEcsUgVvmS8U8PiM3G8rbVqFpl/h6FoWQdOYzcocNSrMP0j164?=
 =?us-ascii?Q?fiKFyxTXhbeLArtJ34kqYsDD7YyezOJ/f54yAef4+n51GZOzxtmecwpnI6u4?=
 =?us-ascii?Q?nrUuqajIiUC/mNcPnwdW++A4mDf1/DB+yV+q4JpPQNp6NIG2A768b9keCujP?=
 =?us-ascii?Q?hC9/HghIBuo9+PCTUQ6CKaCTTif4VVlwdlxCNT3F9xxGjFIXxvj0Y98gRSuV?=
 =?us-ascii?Q?ljdi3D32sR1gdz5SjZBu9F0WW5IoqfD5fPh2ZrffBm+L294eRRqijGSOx943?=
 =?us-ascii?Q?HQPWpzLKRKzTptbn57IGE1UmvzJzoGYMs9O94NgXf4d6DDKqKx2jkr6M6ERq?=
 =?us-ascii?Q?it/MONOedQHxQ8aWZ/mtiDOsJ+X2L2LEuaGlXOzJFCFVrBYaxRigR3fxlC67?=
 =?us-ascii?Q?4i/cMG5OUpB7gfTQ5cCvUSB9W4LR25PXCeui7IaAjgHA4baqh6FE8ewOcPut?=
 =?us-ascii?Q?E9chVcKXXGKEKWvGQHvlZUuoV51Ds+s++nZ4sl7NrmYggkuXFN8mPhfQqj7m?=
 =?us-ascii?Q?Xg7Nplw5WXXJFCTRtE2oiX9jKrf8GKt8u2mVvg2v+yySP3tEjsYOQqxZ/Rrq?=
 =?us-ascii?Q?4ImkHeV78Q989a3r2DbIixDNLF1TTuGwRdTZHXn0fFcZLbRJ0FcVpG8scniC?=
 =?us-ascii?Q?OWpBP1ryRMc2Mw3pkuudFgkuTOdHyD2cUDg4DFH81BUJCAjdlkGqKiZ7bZHG?=
 =?us-ascii?Q?3O+Eg6nj/1JJtxqrBYgy1HvHVYyAb3bxxbLWtROZmEv3ry9rIk9kIr51vDdC?=
 =?us-ascii?Q?iSnzkkkkuFTrxXlN92F49xvtz31HeyrMoSZVhLwfbOF81x8v6NmMGDnAB4+k?=
 =?us-ascii?Q?wNb/aRwEdpsRbfwzh91/xP/InlvWVX71iJzLdHFs8pSg6xQtKO0NQdbsDCkc?=
 =?us-ascii?Q?MIeLmITchFHNPwuDUiTcKES9P6xe1ZPLoyEBQSRGzPmD9K2KsJ1Wa7NjBEgO?=
 =?us-ascii?Q?TINKxNWcYvaujMFrNvMF9m59oomNB44cpwOG1pDxHGJe9AqxnuHDG7uZMfdP?=
 =?us-ascii?Q?uZT+FauwFnvyqd93cUCo2uk//foBWWFxbepam1pFK1URlMuyT6PhhtI9MXVc?=
 =?us-ascii?Q?wxB2FOWOhQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f8bd8-b53e-4c96-be78-08de80295976
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:20:21.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jR3PDcG3qPJvRgiJpBl7iLakQEg2JfMpacc/OvrZHhuG8NixhzWMMPwHfZa8+imB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,nvidia.com,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-9352-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E488270C6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 01:03:59PM +0200, Gal Pressman wrote:
> On 12/03/2026 2:24, Jason Gunthorpe wrote:
> > Add the missed check for unsupported comp_mask bits.
> 
> Is it really missed? IIRC, it's intended.
> 
> See the comment above your hunk, and efa_user_comp_handshake()?

No, that is an illegal way to use a field called comp_mask.

If the driver wants that it needs a new field "suggested feature flags
to enable"

comp_mask is strictly to say that new fields are present and must be
processed by the kernel, and nothing else.

Jason

