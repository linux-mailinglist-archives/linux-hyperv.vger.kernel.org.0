Return-Path: <linux-hyperv+bounces-10423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM9ALHnk8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10423-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:46:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF7348942D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4642B312A230
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FF33B6CB;
	Tue, 28 Apr 2026 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uLV1dBmj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096D332608;
	Tue, 28 Apr 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393080; cv=fail; b=AiAIhX9LWeTeoprbrwj35Hvc6639ZivaVM0QXTvXSdtqp5rs0Hn0T+3e+/NLfoUS/bl4Sv0Vt/GlTfIDyMZaXMcpVcDNUiIlIDXMXeW+ON7LLiSm2d+pJzhhwU9b4ZskmpNFcjH+NEqTwAZ8mVoW9fGYNzkVtTxx52NJ4EsX0yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393080; c=relaxed/simple;
	bh=p8emCnUq3WpCNcjS4pFxrUtqorXVGP16uRBENgyXnes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=moBkfd4ELWx8nnhcmbkk7fn2z59DQQdNvHnQ2CyVttCGIEz75cpLWekrV9D+t9mLZh+OGpn/m0hZJXsdrNMgzPaZHc85/49BIedxzUIDYm1eD2B3oHZrNWgu34YCfnfwaTrNyIqxc0mmOUIkq/pBCqrMg5AnNMBemrX5Xhs3Do4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uLV1dBmj; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3LGQJAm69stdOUWmlXbn039LxTtJ7nyCknks9P0JVr+8cFzRxfLn7jS8xUAJ+mVD3nK6Wpx0Xb6ec5LzxA1EonMc37+9y6xcb3XPte/uoqjyx+CStmHGgDsDRpbDy2vJreIX5SRYijfe2yeNmoSlmE3NqqMO16Vb34o5Y9+DLGS1V/dXTfOqOkqnfI9Wgfn8tQw1unDubMDcartB7F89wipd/W/o5A2qAdUrL1KTZZTAoWjRlqtPVPJRJcMEBWtCYS2n94Hgs00gzoV+yTMX1bHb2v6HNKz5t5X6V3RxKWrnV1T+REjzyreBAhbi8xgKpXRO+vnOziG3I6udTi0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm0P78S8drFHn4XL08PMqT30NTSZVH+itsjI4+zuyPU=;
 b=W2HZWjJrguiukbBu/uj4Vwnkjfn156nsPFZymAFqR/19IK/wru4MZI2vxO9sQm4Mi5cPX+0hIVkU7jzbrSKuRrLwKGO/w6BIutVW5Son3/zYwq2tcmKT6nUw0+Uv+z188PrmyOgajLMfHVduUTGAnd5K3hvhwFLt3EnkTv0kV8kAwZt2IUoJJJ24UDFf2CYTtfmIfnv63d+klmYANq8zvkcFM2I2Zu5cGSuohYHgeMtukjQldCNr1Uzz9zKk9cHJwBI6oSOdIcgy+UWlLYCl8jSQ3IcTPNgg8NnrnWonKyHfTcYvJotRIGopJO3c7EDBPEKzcaCFMHhzlZyTFiG5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm0P78S8drFHn4XL08PMqT30NTSZVH+itsjI4+zuyPU=;
 b=uLV1dBmjAqdx+wdpmZ4RIz5gX6nDbQPm9qCxEe6q7mZwA2f0qFSO8c3r37KunB3bbTeUAvIGIFXFrk1eBbLPUJX47mOMRsrTNTYGB+C0SwRkap2ZJpVhJH8gHyYDC0rdJkNrJ9oBFiWcTDqVTOsYObmwkfffInZa11yzDxKu6Xo6/bi0jvN0YW/vcwMi+LawYAdxCXY/bqzqwbiWCmnbwld5PcgjLWIouPFRya3ZFC9+kmoCqRcKWFfc107PdBASN9wO0r08ixTuXEGm0Uvw01juxl9XGjvvadyY2MyMTXNnpSZnNmA+Yrm0Ek9kL2q6dr1yftTJCwX3GJ2DT3CMdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:52 +0000
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
Subject: [PATCH rc 06/15] RDMA/mana: Fix mana_destroy_wq_obj() cleanup in mana_ib_create_qp_rss()
Date: Tue, 28 Apr 2026 13:17:39 -0300
Message-ID: <6-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: d269a8c8-17e6-405c-0c28-08dea541b1f3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	wrL1hn90r03P2BrbumaCUaKiIFsOB/NgfZmrC5drFMQ4y2TIK/0BUek49dN7tgNRYNjmCXcfQQzEY7CcZh19vMP9ZKLowi1ZxwH+gDrcqiIc2eHVJ0LhSDxUuEMgQWvE3W2/pI5O3p8O6jrORFkh7H5CBwexVHuTgxR+IuY4mSIDblNXPsXhm2F4FfQd8k3qz9YXSqCmNgDNGx56APjmEaE1r53epYw/bcEUT9qIzTCwTJyiBwICjkJFF5CgbfJIlAB+jyzJNlvQFQMrBbgRsP/wRDTG2/0eHftf8AFzEhT57et5KQSXrTuKm1rlKwkEbUgF9DkwJePP7sedpjWYUisKpUBTMRuPuBvvczeqaqjLCYWitwvVoADg0baTtwFAVkc/EDQ64fyQVTXIYXLrnaf+aFdmyjjECCcgP7Yt+hL7StT1LwPIO2EoEUEM/LnRxrBqZkNGfCjlzDQX+KTdtASuuvNqBZYHbk43pisPnZy9VhhFEQUVzmchaEvn7rHx9vnyOKLHa5sYiLWvLR1VzkHtk5jLcnDWt5H/nNNj1PJ6KioHs8MGZrB08GPwILMgl/m1MHEqR+U2vDyfC2GQe1DkxDQNBUoz63ibaAG6kovKijQUoBxqrXzFCwB48nBDZ68+nOXey570JmhpzUxO6zLk1jlBeTBG47d62Cj4Uu7M78oLmWt8n1C83A9S36FlYaTX8MTY6z/6mU3xxhBmKJoY6MOH9/7GV/CFP42ICiDlZDQ3eaZWGQdPpIJ/X8AynXm/5DPG1La6j++0wfFAtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkVSDWi6PQKJ16bUKQM94L4Ia7G+lvjfLq0L7dwIOjfNBlWDfm0vqguHX+gX?=
 =?us-ascii?Q?ohk+LqdgNFusM8PU9ltNf8Fea82J8e9HPIVFUTHJieowdifktCXGkpumPtWD?=
 =?us-ascii?Q?nImL25rhLzWkMwWqtQ0Cht9qXWumLY4PcdtRg4PbP9FhPL99Y8hzRK/C/qZF?=
 =?us-ascii?Q?w/KuL06FvltCa16quoRqSWz4uIYHgQCof9znxk1NERb/SDbWAuL+0xE97VqS?=
 =?us-ascii?Q?hu3S10wSzl5+4zaOzQ+7OBHCfjB7w7lV5tBI8jYGkHVp+F6C5K20GBRcphy2?=
 =?us-ascii?Q?NN7On87/gENI5WJ1fnyiUH8PJQ2C8uhBNrvy6pDS8KA6fHP8YPdoo9EAMNFz?=
 =?us-ascii?Q?DFMdDDQKcIlhjlxfGIypSoje8AeMjhn5gxYBWnh+fZzHAaWRpkEqbk254xyl?=
 =?us-ascii?Q?G+hYzNharXtCvsmvLkBaAA5npvFO22lOitYPV93MP6I/VH6JKj8rnMNxLEBz?=
 =?us-ascii?Q?ZIvUiFQcWACjtB81UpWYdMLeQgan05tOOgWgW1baWDHsKmLRw9the+ASBy/I?=
 =?us-ascii?Q?MHYztJLqVdWnMLiT3h6jgPVRAKrWW2PeQX2t/Uo+dCiU9eqzD8R1r5FxIT8p?=
 =?us-ascii?Q?/ifozZ81YZKHXppMnr8eT6a2rERZH3w3OgIPg7FTaSiPNmYCoXqEMAbHtO23?=
 =?us-ascii?Q?4MoLXollFoX+UTlWb//wB/avlzzPUPuy8RQWgmgbeTVq6Uk6tLAYRkEVuynY?=
 =?us-ascii?Q?4SJ1jU/hVuE7fdX3bbj2ryQFoJVeInPJ1r8Wlr0uqdEWQEfVL4iSqyK9SXED?=
 =?us-ascii?Q?8xaYaEgpaMFoUwC866bz7cf9QtNoQLf8ZoPjeYSS79FMOvJ7vH2DTs+0UPQM?=
 =?us-ascii?Q?gvTnA8Ie93VmOVUj3uQexshcUSrCoMLYVnfOx+nNuUAUVNYsZRqgXE9p0ZCh?=
 =?us-ascii?Q?A72uOnANfNGsH1CERHUjFgi3wuoMUO0OWFd+AAWsXeMrsL8rzQBTKFbzaWvk?=
 =?us-ascii?Q?HwpPuQAxptHwByvJhi/FsRoAaBm9tHnxCjxh4vz4xht781vb2+VlzC63F13V?=
 =?us-ascii?Q?3DYxEebiTa9tscgNKoe92Yw3RTA0Sbr5rF+X7v8WwNOE1LCo1OpNAseNdSge?=
 =?us-ascii?Q?DFn4GdScjui+QICEBApPHt6zg/xlGqINl1/xJD1W1ZTLm+SMoVj5y0QOc/qV?=
 =?us-ascii?Q?aAebiqWG9SiMaguj4ObuaDyqR52pUpSBgNYuLNWs9G239nRpuynkjEGpETRM?=
 =?us-ascii?Q?5pR4lS4ikFhHvP2/0HhlV9p6RNXORCh5Y/9eFHrQNM3YpJZcTYb+qcHzRuIx?=
 =?us-ascii?Q?Y0e0cBwIjT27fS6PY6E/3KJ+Pwc2ZjzmVpiDnHOv3SrEu5a5aB2eRUgGcVuc?=
 =?us-ascii?Q?4ED1FObpMU4zrr41BA4RNW7P2VAebvuMqbaDP6E1R5gDW/SS/JNBQJezFXZl?=
 =?us-ascii?Q?8/h+ruD9uf9yKeBFH0CpxF/ZkylDXiM8LkHDdKOtnsADs9YiSAq4/aqhgXh0?=
 =?us-ascii?Q?5S8dGyk1GpDorfXtvTPNw+B69+xGmtH+9Xc/VBdbkyH99Cd3A4ng2jXQWI3f?=
 =?us-ascii?Q?GeJPttV6T58jcIDsDv4hDZZz1sQjV/lpKkyICmDZ3D2U593yz47acAcoTZVl?=
 =?us-ascii?Q?aSwgF61tfQVTuR65h0w2FO/izFbLudYsFiC1jvt+nOn59bVaeMbPvo0BbQDF?=
 =?us-ascii?Q?eRARZuj5ZEgcxMaI/SRNpo6n1/IfivBB5ctPrEiHzodZMa/tuFWefm8cON+v?=
 =?us-ascii?Q?3z4puvfmAKC8rB+i0jjUxBqbPk6AMFA7DYqP2KkkNdaggMgX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d269a8c8-17e6-405c-0c28-08dea541b1f3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:51.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp3GMxt/xZBHzR01V4nG5WTwCOl1A96x7Ve/3U2/c6zy9ahilYHO4h63YNGelmg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 2DF7348942D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10423-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Sashiko points out there are two bugs here in the error unwind flow, both
related to how the WQ table is unwound.

First there is a double i-- on the first failure path due to the while loop
having a i--, remove it.

Second if mana_ib_install_cq_cb() fails then mana_create_wq_obj() is not
undone due to the above i--.

Cc: stable@vger.kernel.org
Fixes: c15d7802a424 ("RDMA/mana_ib: Add CQ interrupt support for RAW QP")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=1
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mana/qp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index f7bb0d1f0f8034..8e1f052d0ec976 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -176,11 +176,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
 					 &wq_spec, &cq_spec, &wq->rx_object);
-		if (ret) {
-			/* Do cleanup starting with index i-1 */
-			i--;
+		if (ret)
 			goto fail;
-		}
 
 		/* The GDMA regions are now owned by the WQ object */
 		wq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
@@ -200,8 +197,10 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 
 		/* Create CQ table entry */
 		ret = mana_ib_install_cq_cb(mdev, cq);
-		if (ret)
+		if (ret) {
+			mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 			goto fail;
+		}
 	}
 	resp.num_entries = i;
 
-- 
2.43.0


