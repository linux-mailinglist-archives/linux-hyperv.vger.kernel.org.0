Return-Path: <linux-hyperv+bounces-10584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XhRHFtdE9mmMTQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10584-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 20:39:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECA54B3353
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 20:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B1C300B47B
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930103093CB;
	Sat,  2 May 2026 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gk+U9/XJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AC2417DE;
	Sat,  2 May 2026 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777747156; cv=fail; b=rhh5GQg+4A2oqqXRqC+rry0LMXedl41zB27JVLrdBK4hAP/INckvxlhBRw6awFXSX1+KFbCKRKISgkolcRipveF4BXdGlDFeOXUd5JEWc8C82MxC0kubTRpPEH11b53eJ3f5aLYWLvw+sfX2s0PzG7MQTLWSpNoYqdrZXhCHZa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777747156; c=relaxed/simple;
	bh=aMeJZVKL2YHXTxwKAEW338vmMRuqIARdEG/aK0o8q6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=efeR+Ml57MmxqL43okMmWJYhjHofZayMQHJ/t1welajyv7tjSa7agN9xsTA/q2Ip+bxyshTsS3jGlRq2mYXMvYi1YRMy2s75Fd6cWGPOPXE93g8Cuyp9nhD88A6dGXonaqxsgqYnK9DIZnBdhjORBthJVVWYV5ZcH/dUWElIg0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gk+U9/XJ; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkZdScMllNWM1oSxjTzBCKH6MDx3q6ibbaiwEFmS6JpLHyuSt7zluVM+RzVtSkuFBsDAaG3nP36UlOYJ1kTJfgnvbxWNc2F0q6Y+YVsZ6i198hYNaUkm75UnqWFKkDMm2GYAun7N+hf99kqB3sJOLOVAJDBIgtISdk3CWNfleLpQuiIiktkXFoeOGoqh+3TfNQZU/2jJCpXwkdReCp9VMsKI9fqsLluKTOiKIgY2ItXQq6EGt2QOrQxPn8OGXRDmCVIiIKs+3JqyDhLEbjlAXuVzOwGpQPi65FfVxHNP5bUnTiBlTVu9S/myvD4ih9S28fvohp8o3fUxlM/NllcdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9hlFgfd2+1GK1A/t5tEqyBrTZVG8KPvCHZ03tgKyGg=;
 b=GgrrsX4Q5C39j/d224kuuPXOnkFthI5ejQbhRrdn1CVKpRi/uW1gemvR/BVbItKU3YQg+Xfg4FVat3Ou+hVccAdbanQQu4kyxIk7Em9RCzlPNSyYo8P0GVLeZZUd5mVmQ8Cctd+6BYBePhnazPL6O2m1DarDoqJA1gJQ9J6uEYH35L0eHvqr65F0j5UN5GMRo4RYQLWkK/D62QbPCluOijaigCcbOK1rGddeLhfXPVqthg7rq70YUbAyogv6amnl0kHn2wBEtM10aPtBPcuRx+pOkrkHiF6nSVp4l4tVevBzz/+/JWh6iY88+5onyD9a4OBdfRFrYAtXtJukKdZ5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9hlFgfd2+1GK1A/t5tEqyBrTZVG8KPvCHZ03tgKyGg=;
 b=Gk+U9/XJdu0vdM6rPo7+/xs5sDYgTG2ASwsRgk90fM3daSbyTl4tCV/WhqVrXJkxi2nvQsu6VcVhKKA5lKmWQ3d7RuIQNO0xY8jv4Iqr9oJF4mMXLLXPdp8GN8zyfWo5ZUB3bBJ6edDzZoW+3KfLish0kAc4m6JSEP5eRtPfv7M0FYs0l4NE5d/W9Ivh4uST08fru8PbSvvhcDaY3km1e2YRJe/mY9B24Py7qoyeOGyxghXAu2JaniAw7D9X2O2f0gOY5YgEWWbqWVRtOUth5T7DY3gN1B9cuapBxGSeaX7DTYvqseO4Rn29Vs3QKIO3TPM+4w7WiZk4X9uKQsCd7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 18:39:10 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 18:39:09 +0000
Date: Sat, 2 May 2026 15:39:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>, Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>, Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>, Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>, patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>, Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>, stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: Re: [PATCH rc 00/15] Various bug fixes for RDMA drivers in the uapi
 functions
Message-ID: <20260502183906.GA3247628@nvidia.com>
References: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 239f062c-23e6-4438-33f8-08dea87a185f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	NCj+CReeSA3GCkycD5bI3SsMCBWfVp1SUvq/BuI5fF4H0DZuqLwFGOkHG42Bbt+5D8qB9rHQvFbQ5NRBft0+RndpufQYNqDY1GpfH0NvtGCAKtaSbQKJ4PW9oahUIk5QQMpaG5WM9AJDG/ckj8ztaD3OlhFQzuDT/P99WPwORpqScPkC6zbsgpu+IGu5uJyyz6pn/ji/ssn9tlnlSjWhMNoZcFAjIW1BUdsjT8CuYTZKlOPtux5vUS1M+UrS8LMeGRLzM4QAez97GFLxzmWm4pndUNNA0qBwF0Xyn+Z07fzlsqq/QuUOhudjzbTKfPtTO5b7MfM3hwe8J13Rc5cbIrhtLjJSIVMRseGqke+QQ3+432hnZRX2KQc9DgqnLV1OW70rjJ1kMGo592rhcS5fy4uykkVqEABPwLFv92AOJbQwN4lBuFt7pRUQiiFcu7gpXhdLLPUo//6SW4rgTUDFnnS/jnzGRro8V+mVIOjEBn3VSN8HW0OrVupJv+4dSysnUN++BOc+Dnsi2ganBnu/ChdVUn7RnD2j0uer7y6T/dewartnqo9Gjslf6l5GtSPcGYlb7IXSuM9GG+30IxB+LAVg4oCMJMWLjza0LGdzWxVQjYha23D1KX6tPPIlydtLgvCAAoZqgPKirdlg4k3PGCM1T34nKT9mYtUJQH33vorEATFN76YGUIPZAiTEcUhX6vILJDq62tMK0aWD1zFi7c3XsGUPGvR+XoFtoBtcBic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6TbJ14HENt1hp11Qs8e+45SXu7Zq4Jf0RfYcAWO+tbZQW97LtmZaeIgMh3sC?=
 =?us-ascii?Q?yDBTQh2dSh95am0wmnliZrrpwUNF86DQ9xnQdL1v3p915UMD7iHmodYS0+LM?=
 =?us-ascii?Q?3ePW0yrVrquB0r4FiACbTMZd2DJHTTfRBZ59/9iooo05EhImI+WbPWpShs4r?=
 =?us-ascii?Q?TpqNB7N7Z9KWoMoLSXEn4t6p4l/RCAsrsuknWehvdPHHnm6AEo77aAJsRFd2?=
 =?us-ascii?Q?9DZJp0z8xW4u6D1fuhDbxt7FPemNPb2HCblDDgGEioT2WTPso2XlPX3B5qjw?=
 =?us-ascii?Q?dzxrQekeh60qLVAPabaTet4FLfjRQoFs1jOi8jkVmrR5cmTjfGn53qRZYYnJ?=
 =?us-ascii?Q?NJSA1vSffOAdE3c+JgfOU50i4ilKYGW0kURRYcGs9IWaNRRnzaF9KQDMEM5j?=
 =?us-ascii?Q?xTDVvXFLboAMM8H4016GjX40kTnNkQLNrc4busLe5oOOUFgPWlp6+Jmh0muR?=
 =?us-ascii?Q?7FVgpVHHDm3MPZATL99iL+Iis8dsIekBt+2xkem8ZWKB3CC3v4unOn7QZCCE?=
 =?us-ascii?Q?8U9nGQ6mX8ocwcmdAapLymyfdJnYORebwuSiMP141inyCcqOXn45hYleIDVI?=
 =?us-ascii?Q?0dVEYxVlWPuezLKr+UG7TEKhwyZsdlcXflqFJE5kZB/MFW1SDi5QY8czQaPL?=
 =?us-ascii?Q?1TUgn1141TECOkU8wcP+DsmwE2oxaXN4rB28F2CWMmNqTRo31I9M5r7U2fWD?=
 =?us-ascii?Q?QT7rcqXKNJKLIWYqpO21+VNueeQ6aAqFigLZq4/xCesbq9BvPnRefqRAtQmZ?=
 =?us-ascii?Q?fnXVZY9sKPdf4/FZaJo/jvgpbXMhoRagUVYRfk7FrAr2XolzvOv+I/I1GlfA?=
 =?us-ascii?Q?biQenP8JH7c+f48ct+VA62zr+7Q8QI3QQyPWhfP46SfldqGJE8hiq4XSpgeC?=
 =?us-ascii?Q?aBZc3h6iQZNy3q9tn5J41GMsI2r1KgiDj6el0AldVLJKOAdZ+zhp+xs7Qg14?=
 =?us-ascii?Q?mGh6u604msDSqhjdi+2IghbKkZm6zUIzGHX5mJroYjOBZrCXHV/m7Yo2MTsW?=
 =?us-ascii?Q?M3XN1+QmgxlK0KM9FK1+mqqsLBDJbIBxg6tlDo10wDkqy1RRo5d1yRhDELWL?=
 =?us-ascii?Q?hBPYDFR1JTNZL2wqIEOLwtrt6AcYCgl9D5Wqd9CdAVb6pPHrHvxAjPLbXsOQ?=
 =?us-ascii?Q?xvIqjhmN8dsH30R2YhUaDeO+1zAVEAqYs/j0jqJKDI21cD/OTEcZGGUeJxMm?=
 =?us-ascii?Q?JPJFPVCOWCb0YP6NAeMY8jTpsaSwUAjprBQLE/FvQi+ZaHjnuMLSqjD1h90S?=
 =?us-ascii?Q?WbLUeQptJM7fwDDDWu5dpX0SKW9cwDdnls6PPzmDfV6PEIWNKH487g7zys+3?=
 =?us-ascii?Q?HEpxPTgYhsyZc5MUY5pMxGfnW4w04b/qFjduyOq/kchl1t3VhiEimg97lDuX?=
 =?us-ascii?Q?FjLAUr+/Mt/+at7iBXWQMYW4cU6HLy4xe58cccwgpv9sIaqYRXBUT7CipYOY?=
 =?us-ascii?Q?yr81MILdAc0JwiPW0nl9bKTw43tdK0EZGEMEyVz84hBN5W4lmueFxeg4M+tv?=
 =?us-ascii?Q?2gJvvg/1CyaLdbjGrvtvz+lKR7omduuyDWjBvCaZPmEcsKEkuUZhC9OzHQQZ?=
 =?us-ascii?Q?KSNc6m9GbqjgWGwWGke95oFuOnp3j396Mmb/+XlAGaCmvBng9rvZj0Ocf+oD?=
 =?us-ascii?Q?biBH1rZTpJjruK/B3mkHEJt5MV4UkUYuuRH9oDEDa/gGGrg2eYuDnLv3qBtG?=
 =?us-ascii?Q?EWhUovnlvyQz+dousrA38qvZGbcXMKb1jZYQmHFkVFmJ3VqM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239f062c-23e6-4438-33f8-08dea87a185f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 18:39:09.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ap2Y4TCVUyx64geIZP79dmoG7tS0eGupPAJedBUgB/dOiMH1eqPifhg3+meekLRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
X-Rspamd-Queue-Id: 9ECA54B3353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10584-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

On Tue, Apr 28, 2026 at 01:17:33PM -0300, Jason Gunthorpe wrote:
> All were found by Sashiko or Claude AI tools. They vary in severity, but
> are all things that shouldn't be present.
> 
> Jason Gunthorpe (15):
>   RDMA/ionic: Fix typo in format string
>   RDMA/mlx5: Restore zero-init to mlx5_ib_modify_qp() ucmd
>   RDMA/mlx5: Add missing store/release for lock elision pattern
>   RDMA/mana: Validate rx_hash_key_len
>   RDMA/mana: Remove user triggerable WARN_ON() in
>     mana_ib_create_qp_rss()
>   RDMA/mana: Fix mana_destroy_wq_obj() cleanup in
>     mana_ib_create_qp_rss()
>   RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
>   RDMA/ocrdma: Clarify the mm_head searching
>   RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
>   RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path
>   RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
>   RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()
>   RDMA/hns: Fix xarray race in hns_roce_create_srq()
>   RDMA/hns: Fix xarray race in hns_roce_create_qp_common()
>   RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
> 
>  drivers/infiniband/hw/hns/hns_roce_qp.c         | 13 ++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_srq.c        | 12 ++++++------
>  drivers/infiniband/hw/ionic/ionic_ibdev.c       |  2 +-
>  drivers/infiniband/hw/mana/cq.c                 |  5 +++--
>  drivers/infiniband/hw/mana/qp.c                 | 16 ++++++++++------
>  drivers/infiniband/hw/mlx4/srq.c                |  4 +++-
>  drivers/infiniband/hw/mlx5/main.c               |  8 ++++----
>  drivers/infiniband/hw/mlx5/qp.c                 |  2 +-
>  drivers/infiniband/hw/mlx5/umr.c                |  4 ++--
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  8 ++++----
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/srq.c        | 13 +++++++------
>  12 files changed, 52 insertions(+), 37 deletions(-)

Applied to for-rc

Jason

