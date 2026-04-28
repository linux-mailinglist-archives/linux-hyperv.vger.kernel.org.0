Return-Path: <linux-hyperv+bounces-10428-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK2BGcXw8Gn9bAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10428-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:39:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B13FB48A172
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FA3B3154DE1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E33C6A57;
	Tue, 28 Apr 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kiDzbI18"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D233F377;
	Tue, 28 Apr 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393084; cv=fail; b=KT3xtGVUBAlK10PR91RUv+Yp3sSpsWMpwUuw+Arsh/UTgl3kW4xrmfh2hGAnesc7EdW4st5VmFFfNIfE5g1Ur8IsmVOtSX/I/asFIs5StzvolEqoGdia72JPfCDeWJfzztYYzSObJw8iTretkE053a0hNJa1AInMeP7PenWH6Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393084; c=relaxed/simple;
	bh=3jF+hxsOsiw735KjZ3jP11AA7Qq0F8gk0PsJzkhaPBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/SRbdAIvWVUlR4zjDR5hQ+gfNaOZx4+nMdTI5dCcELYusQR44qyYzRgMYeKx05ZgbMDH4Wk5B7znGg3g4KDCpnYOgAGSZ6l3bdixVGrtVb2SqUC0LuaDbvDWPrfeegxPSK27tz96RL8++rXCOoMGkZPQ+mlwIn4ycwSL7dv/nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kiDzbI18; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/hYX/f27E1JNFobERMdthtg4kTSmIqZhPhmUW319sTRkArZ8k35kfOwcw7rUYaiACgeLFewi6El/ckUKfNJkzRTvUi28DKfQsjPMncqdFYNihzwKI5lwgxNfnNM50KL/HSDxkCawbHeJeT9YtmorHQos5R3ru8maJBMdUUAJaGj7OHb6oKJpriNuiffP141fliGW3MjL9WHExd4Bt0UbolneeX+85Kgr78qSPoGTysYRV1Lei4Ow/E60KpP78IEuaAjDisRD2U5tbGiRuwFMd+Ds6smBnD5LSMB0tmouEVOqsimuOFrRb/X0WI0752WH9TNvA2wsL5XYuQFMQFL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctNWeDhrTPRueU1MjxlvkkWhWkL7qB9h2H583SgkrTg=;
 b=adozBNEfOXBDkWWVMUMcvQPk8GKr0OqqFmq5YRkGw71Jyxxxjkqr+zG3mV7NlWBzgUbwY0Cz4rGdTgYkoA/FN0f9LrITl0CU5PSMPoP70cF7cBHQGuKj9U8qfzSmrHFwWaJ1J+2X+zblj5PWi70i3VoekhbdX17kaBjQdPSKmDAuO8Jg+xpn+RT3j8gHJT0OJsI26Wr91Bi8wEzPLaP5Pa/R1q611sJ7gwPXbS8+hcETPw68UWEtDK5SMwC/pUulPvOto62rRkoqa38FxBBVd8OEoj0rq+tbWNcpjHGatkT6k2cTdCfOJCoHLuGoxwI3DoRhpLIu0SrmWRXfpw/Ovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctNWeDhrTPRueU1MjxlvkkWhWkL7qB9h2H583SgkrTg=;
 b=kiDzbI183qcm33phFZJI7AAY/sz6Zt1UmKgtu1pSzUIYYFYBXMrA7BjQmXr0hTk0rWz5pMdndB6UlUjZ7wXsZT3SuweKX3z8XRW/pSCzbjtw8LRSCiin0Uq9Dh6fpto//gfiaWYyFJzfPIK83WvK4JhuHIe4ID7glxPkBWRW7SqZ3wD8+vdDGv689chv4mW9WBXTGU9GYphrcKy4VJpXfrcCw6msEn16sw3j1mW32Nf96Kt8tz7pzdg+dEM3qHpxsX+zUY8XC4YTyaLokeiADgVAeLNwyBgHJdc+YPJH31Tjiz4D9PPIvSBlUdsKGcdGH1wMedSOecCNpXKr2s+TPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:55 +0000
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
Subject: [PATCH rc 15/15] RDMA/hns: Fix unlocked call to hns_roce_qp_remove()
Date: Tue, 28 Apr 2026 13:17:48 -0300
Message-ID: <15-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: fd041f86-218b-46a8-8cc8-08dea541b25f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Hqy5hWqJy2ZE4dNreRZJgkxVgXW1rTBmy7/+4Bbx1+4hQsXLFcpyopNDuwleWOE/JzDxINDfNKZfNl0WoR458NnvD+75krWYcyWhYF87mlA/QJPPAHpjcDSFfcwSdGPhhIj3JvUqXOpNrFstFPXgqCZkHJ4Kgip7mNRr7qXIdfNP+j/ToDx0fVqMcRn2lXYVvOyeqvIveuWGFqADJ7u6+U8d+9jrjbM1t2sdqw284jyJQGjEUJFKn1H98fCAivyM1OnjlVh/RqCOkyQ52jbzI2pq0hUZju32NvGVu429LqOT25jbqkxeUP0pOfVPe2EZjsyvjIHRY2+BRYbFMOVWTcaeDO7SxOGX+e4sB6TNYonrsmOmwF4MFpNRmMdo5LYrMWXyyAAwCIKFG0/AYQE1v5X8ogJTGPLzcRaEFRVVU09dNL+vtqmZWk7JQdyQsdfd+HGsvexsOMwLfwzV7dsdMfe1t/ac9lxh3JoK/iGT1qFfwitLHJTJ2wjfZY4FJrjADAMJOJP3pkywbO+VMml5wGoddeVFIfRJJYvoaU1Z9xDl/NC41WFviymLOrjO9RwsVk2VbOPrrCHiRT5t0WwEFflHBRmBcY3mujrRZ4b6QY2uMTAxh/VIjOLzGgdK3uk+pUUswCY4qc8VXNZpudj01mnesjuoHqSUIrQfGB0gj9ndxjY6XicwFj6vSUF5ln8BE5rCgunfSC/YoUDZkX2JNq4hKKSzZdA5Cquhn5FPeyhRGlBlpteNkavMXWaAlBUER04goj+GTcgNKv+As2yftA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhVzUueTrW88XztLwr6QzOQauWjRvfgq1mAl4l3nqPeHwAWwHOmAMRVHI+1M?=
 =?us-ascii?Q?bGfB8I1hKB0SIoMCjOfn0rxp2xUGVDUncHuCtnRo04iOny+ibPi13GXNLyJ+?=
 =?us-ascii?Q?VSAyy43dRlk7W/GS3A0/XpVC8wH/IDDrY7p7hQnR8L09z6QKiwB4VkMe3Iav?=
 =?us-ascii?Q?PutpmSka/JQcGW4r1u/RYmVovnBXLSB1/yrR8p63YQ28VH2GecNelcuLu7B0?=
 =?us-ascii?Q?vmP/uFY4k444aWy77UjU0zXhRuFFTRhUa93gNF4knuJHkwB9fkaVcNWFZXpG?=
 =?us-ascii?Q?i56gyWuIrZIepkDjjHBkxU0bGlN2MERmp+Iqv1d5s4kHipSzvyqjbf2rRu0J?=
 =?us-ascii?Q?7MloNU5bJmHPoUYq+5KHTOu+WiMKXFDesWJDQbTV8lkiyT/bEJOAglHgOk1W?=
 =?us-ascii?Q?IiM11iO9n/ba919sNgoYCvvu+cd9ME0NDL7uGrDHeYdI69Mb2HXqGtpl8dl3?=
 =?us-ascii?Q?LoZQyNniPTxJk3A3vJSkBB/Akk8jrpYs5/gaO2ZmSZ+ic584FwadZePOidgM?=
 =?us-ascii?Q?9slsSxsmBVLQXFnmILWgPA5oN4X1tHOT2ymYtRAI3ZBukUoYOo6Z3TOmIJBo?=
 =?us-ascii?Q?hmGDxLqXujcXzJyHiS7l4BgeBpjXwuMZ8menl8QM4sMLI4PhOKN7NnrQ3jpq?=
 =?us-ascii?Q?BS4FlLbqTuYWeCNPW7gJllpGILzVF6wmC3H/hDiM4n/vrSi0sp7bqCrmS2+7?=
 =?us-ascii?Q?SNcLcssnO4OfWrNZr7QdDbJxx4O3iNYE6zrEdeIAfG1iKBsz7+9BZbVwQu7w?=
 =?us-ascii?Q?IGtCML9w7Vyr6BAq7hNP+Vl6q0VX/pOFZ5mgdXOfrmt7Iuuu/5hAlRO+nAMt?=
 =?us-ascii?Q?eHzCaq8jHMztVTX8iE2aJUG7X/+BwwiH+BIvw0CQiPSTdqj92ZP9O8FMpUqT?=
 =?us-ascii?Q?7mpMT2Jdaih77RQBCbe7cQkV+bbVvaAGlgsHCugiZGHWLOOB+otWDx2eOEmY?=
 =?us-ascii?Q?ENeAvSAO7IFm04lz1oWoC14LSvoICbFNkIhagBv3/tXBoJa8SxE7LqvtOR+d?=
 =?us-ascii?Q?rYo2hOeqgqHZvrrRz8tlT87ndG8w2jkaiBR4pyAEW1ut4lx2YqNnI+JZjqub?=
 =?us-ascii?Q?oKbm/pLeCJfjnCPr7YxTQwbAsKKSWTguxHJyrGtufk6dMmI585aR66Lh2/k+?=
 =?us-ascii?Q?QyXS9gXjuqhK2yIGJnMrdiTMAobg0hAkawzly46HqnRkVNSvdpcVRVefANU2?=
 =?us-ascii?Q?GWKOsUK5V3UbAoTwVR1BSAVo7BdZX/7K6SyxBMUT6Ub/L0egI7ISf3j85OHF?=
 =?us-ascii?Q?WpazFG2NQ/wym6fHCzuKJZpLX8p4Hch99/kdCv73/VCwf4ba8oAZWq1XYILF?=
 =?us-ascii?Q?yplBCnjUItgL9jlpJjF/mYCk8C5IIRufReQruz47Ne5RBzQTVpzaUygPzfcW?=
 =?us-ascii?Q?M+xeXDw1gc5Nc6JsdzaQoPDi6ncwIJEg1WaGMT+rH3cJ2hYAPn3mnQQi4r0O?=
 =?us-ascii?Q?crkKYhrnEa9KOhBsEQ9p/LOt0zptwulSdK7Tyi2Z3zmVLBeYMhNFoK2e+Glo?=
 =?us-ascii?Q?JAZetisokO3BEtiSzjFSGvjxf0Y4V3wIjteVvv1tXjadxqn45yW9YM6Fjc8y?=
 =?us-ascii?Q?Daxkx8vYRL++qjBcdKNNqlxbNB5IFyWoLNvHSuBTi42qfRDM+2XSQsrQCEWn?=
 =?us-ascii?Q?ASHHVs6EpHZWhMdsgpHR6Q+poZNYff/tlxkszxMyj09nd4L3xlpmgE18BBq1?=
 =?us-ascii?Q?LC5TG8BRB7K+Z7vXps3p/GslQ5+2C35D5EfGKwFryhRqv1Rc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd041f86-218b-46a8-8cc8-08dea541b25f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:52.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6B4NblScRwHeTfvY+uYwXQhrm6jBeE7IQTBsTAY0Z/ACsQctQix6uzd8hvDcukT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: B13FB48A172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10428-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]

Sashiko points out that hns_roce_qp_remove() requires the caller to hold
locks.  The error flow in hns_roce_create_qp_common() doesn't hold those
locks for the error unwind so it risks corrupting memory.

Grab the same locks the other two callers use.

Cc: stable@vger.kernel.org
Fixes: e088a685eae9 ("RDMA/hns: Support rq record doorbell for the user space")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=9
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index f94ba98871f0d0..bf04ee84a94392 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1171,6 +1171,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_qp ucmd = {};
+	unsigned long flags;
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
@@ -1257,7 +1258,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_flow_ctrl:
+	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
+	hns_roce_lock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			  init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
 	hns_roce_qp_remove(hr_dev, hr_qp);
+	hns_roce_unlock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			    init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
+	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 err_store:
 	free_qpc(hr_dev, hr_qp);
 err_qpc:
-- 
2.43.0


