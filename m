Return-Path: <linux-hyperv+bounces-10425-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dBdnN+zg8GnZagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10425-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:31:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E57488F85
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B7230C522D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A733D515;
	Tue, 28 Apr 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jc21VXSk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB933A718;
	Tue, 28 Apr 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393081; cv=fail; b=p+8Z+RTovkU8hK791PngPd0WDIESQs5B0o8L9t4IUqs2Glw6SIyB7xX19UxDQTGUyYJVeOzRIV7DWRKBLxtkg+5fQDl+dZEJ9Q+ur86Oqj1cma014eoXfNeYdbObOljAq2d3mDKZUZtTRiPCVaBCjnMRFCHQl6fg9dXP/3dZrZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393081; c=relaxed/simple;
	bh=QZRj0N7PeYaA+JqV/kKyVqOdqle2g2GtMam4sgFJwBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sw9C6e6uHjSW67b8wjweSBpjpk0PI686Aey5Ke6eFkgxACKGfRfNut2rnUpAgFyMHFann/O96ThFBCUob1V0zqFD+fR2on0yet1WPBqADnyzoY5mf0bjSrtysXUiBUtsE6Ok6MqebsDfK5LQjpHm2uqh1e4EVeiCO4X9iFmOgCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jc21VXSk; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATUCGKpRluTcPagp3D3RdgW2R62tCh+tSY6PYgZfAJrwFsitj+wrtu8xz7S9/3sOJ0fV0o6obbGUTHOIBwOYOf+YukBdu3YIo7eir9xqJtxx6uJSfYPve/Phz7wnxVBkurOJZ62/LqM7OVapSntgVW91H10Fk/uzpBja4m4H/gpGLMKtRRkGxE3suwa9dHAxRkCtbZVXuLxQQGqQjDjjI67EmIDWBHlCV6BDHGg8cKcaHQ+36vrbLJTyDeaooG/vMTY23RIsmOd1460INxGy50ExXwhfvzHU2gyndLpjjIqABHzUTWZrmBW0XwmA9BG7N3rNleVqUu8nSLTZClv3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU3kJwpIcqxi7FgzHlFcCOOaJitPYFX4GXDtqz+62MQ=;
 b=hLkZS77iB3L+XuVBf8D5JuS5VYsfQObCNHuFcWHGdDcRyeRxq5eaJpzloJquZwXj0bgWAiWZQWd15ZMNYew7qu3irBtotAlwP0MclESBEe/30ohFeupa7Tc70jncbHZi04yWgikHRQth1ZlFp0d2b1jTFsjJE7fZqf3PBKaZMjv657EJ7dfAvQb7P++ZwORAs0nbeJZFY1JLBMyjopdAM0dd0vfV6LhGeSbfRIrgvVxEHLVlll/rG7pawsqdLLTD21cWiOGf8xG/We+6Jhl2KnMYPsIZg0qcN9poJwJAOlgDq3WLtFHtGnk0Lm0fxo5rg4vFQoWZIkoz9UOEtpcsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU3kJwpIcqxi7FgzHlFcCOOaJitPYFX4GXDtqz+62MQ=;
 b=jc21VXSk5vjhMuTt1KwHn34WLNoVcfSQyQG1hJ2DAq6snBFnX9H2ji594T2McYZn3DQk4FcACNLpQjC2RfGV+6SPcrIXgn/JC4LrdWmPTX+uYXfsUBPYMYpvb4nPfimDHGJt8HTBzxMNpgwLynwOa7f+ASv0+Z/nv9Ky81X50VaDLenzjx21jZOgYyVdCtzaTqaE+fWj9Xd3jQydppBRNql/uuSyjlB3X/IbOv559bWg45KzMk8PjPG3pDYcN3MawwoEotFRVV3UayNrbCiTdQVpNpZb5tDioXxP8Odmk0VIbsOeCtf/dJyQqUG/kGu1U37XpaF5MIf6umkR3NYHUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Eric Dumazet <edumazet@google.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Adit Ranadive <aditr@vmware.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Andrew Boyer <andrew.boyer@amd.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Bryan Tan <bryantan@vmware.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Kai Aizen <kai.aizen.dev@gmail.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yixian Liu <liuyixian@huawei.com>,
	Long Li <longli@microsoft.com>,
	Lijun Ou <oulijun@huawei.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org,
	Tariq Toukan <tariqt@mellanox.com>,
	"Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
	Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
Subject: [PATCH rc 07/15] RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
Date: Tue, 28 Apr 2026 13:17:40 -0300
Message-ID: <7-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:208:32a::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0ce07c-7065-4c0c-872b-08dea541b1fc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Xh1JME6f3NrVJttS52qjVHqk1q2eWv2zwKm+YjtYhDnFgxZqg9DTur0Z7dKuko5YJUyD0pBanteQ1aPg08GQGFzp3kkEh9X7V6fL67rSpEQTjMvwE3HNHPG7pvPZWUIK+CrA8AKu7OXXT0RiioR5izloZU6gSgtMJM9g0TZwAt0RSvaGmo+uPyNkckTKaALpl2udkpedUS9T1VCvCGTU7+5An6oUzVJJj7XebrlcZi6SOehovRw2hTptPQGnQ1H9nuAq2VfpBEoSIvF3ud7R+Dsb25eDqM4tvg3Rf8MMjbHRCB2z5uanc+hZB8vr39b6jiN4NZ+kshT1rnJTBo2b8KkEe+G8fQkeXiEjXP8ZVR/1xi4UJFI6jkVChFqkPffyX+sei2mv4IF1/jgUT7vEwTD6INXlvsLQzYnELr5S9jThiahD/QcjRQeK5NSIiyRoxRNBD672XC7707Y6YClX94OJ9woQCgGaYiQ5ATrn4c/BRmvLu90ivDHryiSxG7WtNIJfu2ixy+6aRoPKqlIEPHuZ1a+OxLviIxsCQmzFKuvXmGHGEeA+uz07KeGwPb/uYyVC3gvA/0NMujS6B5fNl9NcnGdWi7RzzEJ+H81ZUns2h41sUMihwhp5yfScNoFRC/KjAbrxRIgmrJVZVMLKh4slu2hJB61TEsnri5PeIMAYTTwPNGt6AQ2C4BL3fRQtpBMB8rbpfsrTW7TabbuKgPAOitnI9H8RUn9cgh9VHgyyWJlRwhkrjkLPY2YpjBI3Pr/xa5sfjvAletw012hL9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hwx2p/IdnQ7Cdj+RmZugfmt+c86vpRjkOaE7f2Lbui2ozO9CbkP0b5pstAtg?=
 =?us-ascii?Q?JvAijcxOghwl+5PXygWAPszd5RteBDTvjg9+d81EbHRg49a5WYU6+aUCW1ZR?=
 =?us-ascii?Q?/ziukzHscw8FYmcoeD/PjDfGlsKoe0Bl9sNU2YYDl0hr5oAsjc86WuEC+mJU?=
 =?us-ascii?Q?cgRK4kAiWUsu/DrvGks/0fa2qg7BHiwUGCTCf8pe8blRGMYCSfnJCb2WgMmh?=
 =?us-ascii?Q?2itAyoqoUm1Qbsh/I4lHP7bexOvFlKVGSUQ2x8AWG/Ed13BmXiSFHUlRhjhh?=
 =?us-ascii?Q?N1CAX2sFF+Itx3lXhzc33mbtMUHcixTJOfxJGJ4zvEkIIGJe2L9+r2FWkEmM?=
 =?us-ascii?Q?9Lmmn1G/ElMt9GaGKY+3ZcbHeb3m8JVh+IKpJlMmmBfNvdT31qrR7tPwZpGQ?=
 =?us-ascii?Q?g0PACIs5zZBp8siE3MgYb9uP5ORNfiDyxRZccD8HoccKpPxmIDTtQN0qlgKN?=
 =?us-ascii?Q?tnba5nBdZlXA4DaT8Q/D0rwHsTIM81mORKsJc0LUmwZ8e3G/W3KAq3DEF0wn?=
 =?us-ascii?Q?0J6y+qkYZhPS6Ek1BmgG/2WG2RQHeDCklCOlBW/NxwHcFslX+Vmge3f2OTsw?=
 =?us-ascii?Q?29aRD3Gnz0cVphyyWMzf1KrBA3cT5oMYchlsWyZd4FSoHyAXlJWrDNKhfcho?=
 =?us-ascii?Q?oi/RUjGU8aYZwKinrss72NKS/VeWchYwinkXEelRxOz7+LmEJE6QG9unv995?=
 =?us-ascii?Q?ngbPN7m56b4GAM+bb5zBx5TU+b3eNr4LZ0L7owm82FAOKxUJ3PUunS2fwgdg?=
 =?us-ascii?Q?+TvpANn3P/ETlvM72H946DEmeMY3sKhW51qko/iLreyWd3IxBJ/tTkkUlMBx?=
 =?us-ascii?Q?BbkpTgTmjYsvlFJm4tqijMhtFXowtwjoGOpNQr/4uUWG3JcR0fziWgn9bJr+?=
 =?us-ascii?Q?iCILRec/FZYc/zzO0yZpelDpa+ZOA9Sud07bNuCg7ymGS3pdaEAn6x0WIHES?=
 =?us-ascii?Q?0nEIibTRHPqRNK4DHGAyI9yrIqA9XR2XZdzK7HTngaQ9S2k2msOpVHOc13H0?=
 =?us-ascii?Q?Kbg4MwQvv1VqJcb1POYSYfnYYnK7h4cP6sYvQopl7P8DtPk+SmSjwJ6xK5Hs?=
 =?us-ascii?Q?tPNA/VfpJ2N1gtxEy8hEhDaljEgoptDnZBT0pI6mmR4dL5yQn14z387WYmln?=
 =?us-ascii?Q?W29co/aSS3mDAwCf3wyJFv2G0BMmmShqOobEi1GbCfH10eJOQqy340tSzhuU?=
 =?us-ascii?Q?UDcd5VhnioYOowiHhDI6geB3Fbq0fmg6fxfpPnMOFlnbfCK4OV9qpIXHyQ7i?=
 =?us-ascii?Q?kQLJce/iRiwALrhfeDQUJcywKfaNqwv25MVmbUldxBE15OCQR4u5hWhnC4+A?=
 =?us-ascii?Q?tYgFvF7IWkSUpgKuW3UAbrpSKwEz0WyOCEAVJonbP0S3PMrjS+QcbhlnwUjb?=
 =?us-ascii?Q?IOvtB7uZZYuBgcdgIJAsgi5s63Yhby1mqBCph+PhuP7mHeibrF+Rwrq23hjN?=
 =?us-ascii?Q?O9FwWmNLMgZJj/wUYxeHyeLbWl/ejEQBrGRx/av+2tzHUuRhEap16eHSny02?=
 =?us-ascii?Q?UxppKQ7nD6nlX3NvqHE8rTl/POkh9XM9E3drd1DzrCumquLWZbgGzvWdOgra?=
 =?us-ascii?Q?/POktEgqhI9H6V32hAaCPS5LYkHA8HhZFy/+aqnMv6FQYhxD2dLrsuC18ve6?=
 =?us-ascii?Q?4id/vEZIVU3LLnyvkzI1dOf+Wo9BfXcIHKAF8Wy+cO3hQh0je73wYpgAkBdt?=
 =?us-ascii?Q?D0zZnbDOHSneStVv6j6ggVnvW2t+kuK158iMa+HmH4md9+8f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0ce07c-7065-4c0c-872b-08dea541b1fc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:51.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnO+wtyaWFjuNANqZCxi5rOLe89MFGWO/+JP/HYTqSiqGj+dUjO/cvFLygs3pjOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: B5E57488F85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10425-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,sashiko.dev:url]

Sashiko points out that mana_ib_cfg_vport_steering() is leaked, the normal
destroy path cleans it up.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 8e1f052d0ec976..0fbcf449c134b5 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -217,13 +217,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to copy to udata create rss-qp, %d\n",
 			  ret);
-		goto fail;
+		goto err_disable_vport_rx;
 	}
 
 	kfree(mana_ind_table);
 
 	return 0;
 
+err_disable_vport_rx:
+	mana_disable_vport_rx(mpc);
 fail:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];
-- 
2.43.0


