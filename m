Return-Path: <linux-hyperv+bounces-10436-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GiJLfXh8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10436-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:36:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AECD4890D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 308CA30EFAD6
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C24534AE;
	Tue, 28 Apr 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8E1NIN2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD6413224;
	Tue, 28 Apr 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393092; cv=fail; b=Z5/f6tuYbvsrqlNkis8hS/weeSdZrmFri4uEqZUe3fYnNsLrj+GQAb1t1UhJ2Vrg0ml2JxbK+d3AukD1uwOJ5yG/NOSp38Bj1QGMXFDADBL5hKVPE8nfbOil1jn9LegxNTrD/P/9/qw9xGq/4wtM3Rw/kBKaz1+AXTQQJelJNaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393092; c=relaxed/simple;
	bh=CvvMUeDXPEzFULHx1UYb4lws7jefmXYZA5HsCA7Lysk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5gJNLZJ8XPZFp71pR5cRna9kbN1EHiF1MTAtl9e8eepiy9YzKR7bO8o2keKKlcfb4q08xCXKeCEL7523t8/aWMzo0Y64JuQv6fiSO2rHknlab7H+eSni5aoADSqkHXyiooOCvpvVbTDJntA0hr6PoGVB+K1fydtT9a+KOSeuzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8E1NIN2; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBhWDHPsLmoMcWuDbag0YaEvhdp8zQJbZK1oxaaz45j87vlJ3DHkYHLgcAYEw+kWNGTmtiThUfy86uMU3s4YlxkudQRdWy9aTTDIBvt9ug2PM14E+Xm5dZOxZUG+rD4nyn/zIrH6A5o3HpO499WhjBD6/7XKBbk1Lw5puggLkWvDroay9rwT0NLOd9fA9d7/ojbpMfu2dEKtEvXHb/5Cm4EHa1TJJjoQboXf++6gj2pDWr+vu/YH65mu3Q9TJEcleKlz/JuB5rwX4/24pooDrR4XdekTc2L/9SzwpNpGpuHVJUaulE6ci61smKRLMznYq6g/lxGqOUEGLu+PAxuitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uShReB3YCk8lPzpURIhc+FWm5OZEeNkipqtx1iCibFM=;
 b=UP0QXEBAW/qjAA309dxnLgoEPSxywmpsvJwImsf7ZZ83Z9tHCOxTa904D829yYAHQ8he/azaw/qVKX33LJsUxzLe11HjCUlBUfoOy/7QXJ8+rvSIn4rvoRQIqyhPmyLGlj/gkaZPjYm3+cL/1zfk19SVfFaINIkYNJ3TBM2gBw21IDMyCsMtp11BvE3yDFoCXW/BTT6o10PDA1GTShLC+qtmEfNdUw/3xzlrDlNE6eME5ghFXqJ/O1/9q04PgitzVVfBHl9JqfwvoULL8k8ittjmV5lM+h0cAVSS/xt4dLAa4ytzOS71NbBAHriRPUJ02BuJ/xVgH0ycXfCp+v27aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uShReB3YCk8lPzpURIhc+FWm5OZEeNkipqtx1iCibFM=;
 b=i8E1NIN2R3PKPh5MKNCe6zId/AZI+f0rSyKDR3pszC908Wuxaiib03BlLSvwuu+w2HlR46dcdQBuWrGVukdxCqq/lcaQKD8OqTKxQ/YMxJgd3EwCgxD5twln9OlDwjMIr8q6VChu0Xa2rETzafJw5Dmnl//k9Y/vVd97ro+A01JgU+N399tIWnQlybW+6OGNBrtbKXMzCN1nsTisx6tTOKTZu7oP3Kt/C8VkEv4vK9AcTZbSJ284z4NZaeL03a1bTE0D1G5tksgsji/LE62921yx/1Z6EV2Laxt1wG/eMcFV5hLHypbH5f53BOlcvmbk0/hesPW5ZSt7+k9TzNaw4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:18:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:59 +0000
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
Subject: [PATCH rc 01/15] RDMA/ionic: Fix typo in format string
Date: Tue, 28 Apr 2026 13:17:34 -0300
Message-ID: <1-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6988de-f809-4f59-901e-08dea541b548
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	VCyd3b51qjaUKlaHdTzKNOb2z9hzghGZKIhq6z9G52KfdMalD6zGzcr5yrByxdS6g2ykKV7kzdQ8Dn0pA2jWK3UzNIi9IAMeMtEcN6n2D3sM+ePTlJ7jUfXf/rh6xAvunGWa/ysC2I8aek7rzcvwmtY/B7HbqlzShTu2WTNTT6AL6k1/8xQx/2czBgFAwf/+8RcpQ25j1rni6c3SHpXANNRkeorIwiAg/OWlVTQplNRBYapWmIzkzSjdWxZc1Q3QK64yiiETADg52/KpAnjLFRjf4r0K52kQG5Hloix3sQlvBA0x8ldLaQoDfS+Kg6Y471aXDRSe06c9sNTsdPUFBbtsjk416XmJlyD55LNISY0cydJAlCArI8WwWSSNyJcJPU1us1n3fvJUxcQh+t2OUMTs2zWAuM0HOiTI61E7/xmP2jhy5XVHM8sUDnazsUle+P9fGxkhIhtSCM2FdkA0Z3gZVqXsMDOp7uI04XQcHbK3i3zzrN+Iiy48rGdGkMRItTXMJn7QomUOMhd8Ss+OOUiQzbri/SrNI716RKyhQKe7oIa5X9F3siEsmfeLOmXhBnCFVL+wfqOKD9TruP5x/nLDYX6RQFoan4opcMN7tUo5c8oCFOZdSOGF5OMrPOMaSx40Isz207qAx0ovOnXru97w914GVZDeDhlyt3B3hcDaEQssXJmqVRLl4X+ccRyYLh+kR02YpLIAAVGq3Wn+2cZ59j+9OaBRV2433C6iv5S5CfeV3NmbAa9305wx1e/HN23XISRb4eFeJ0wYtKRgjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COg4lpgb8UdssOZrChTJ/Epy8zxjFgWwvybH3rA4onxa+uhWGvgD3IxOY0Cf?=
 =?us-ascii?Q?c45M7Lrhxx5/uAslFitEnOS0YH/R4x99DlOQR2uOr0aMtC4PIoheaj726p2U?=
 =?us-ascii?Q?jhFlK4RgLY4EbOdH4mxjjTy2xQ0yypWwlwC3LWODPAqIxGb+GuG+6PUeaMzi?=
 =?us-ascii?Q?u2LiyuQOg52gHTuvQyDzV9sCktOWlWnNpRlZlp8RM55o/WARIeBxLeKUIz1O?=
 =?us-ascii?Q?thx43ZmNEPuo1tIZPiXZWNIAeCKWYV83QK/NACJ5wN3gtB1IE3Td4fQ8ADzP?=
 =?us-ascii?Q?D4y5mkQls2Ntk0Ge6kGtQHWpoVu/678/yYt1o7JqcVLCNZLvlrwokLugRMcb?=
 =?us-ascii?Q?CEpmA+7rkp3dd4rzzlwa+adTKLRp6+z9fftIfRcPxFvYhmF0YphxVbPay534?=
 =?us-ascii?Q?yoCczDn3mQfpqwSOJFy/Io+VPEImaCj2ADML9SSR6AGV0B2uMUWEXW80ocvL?=
 =?us-ascii?Q?W5ZgSJHuvjS8QjCc08UljotPgV0rY8qJIh44f0Y2jaHgLnt7H4/78pmVebnG?=
 =?us-ascii?Q?Wl+7RpI3A5NkyE3QPPGAt1VN4HmQoyLN7MfEjDcNWt6hvIMGlhgtYM0T0lQZ?=
 =?us-ascii?Q?0fmRxfBTt6hz8pL5Aw/2pFvgOU8o20mlxJlsR9mIYt1h4cCObsW4yjb4ANkp?=
 =?us-ascii?Q?ftkKG4kyXIkrijJpIes893EKcTuiFYxk61puxIKHAMfWTThdBogYunzXA3YL?=
 =?us-ascii?Q?34A/SmoaKGWxc/d/tKBCbn2pThVdaJxvTCb6bZ102VTWhStmwn69ePcY6UMz?=
 =?us-ascii?Q?aqFY5QQStKdhZoBggpKqsR7NuTvBmCaPJkcEeVIXSqckAFwRlztk66p7s2yS?=
 =?us-ascii?Q?3nD8rxt/WgaMppWykV7Kw/upaPl/cORgBVaB/5Kqg2DbePWjslt1pXJdEHdg?=
 =?us-ascii?Q?0N4K344ddJc6ZY+qG9Fc1Ic02IHZ7c0yzr9LFucxzKYQ35BP7AN3YP1CcLu5?=
 =?us-ascii?Q?Ai96CNHXnvsmn4TPYLY0A3mC8VLzVa+lBrwXMMciaDuql7EKzqkcpsGbmmaP?=
 =?us-ascii?Q?kxYoIQbdd4rrImMS+4JCkFS9glHzWvxLCC6oM1gN1Ty130iS2MfhQlH8mvnt?=
 =?us-ascii?Q?0hyeCymYEVOoM0OdVxf+Rfnw31tsgiB4o5BuRZlST5UgLLIOrb3jwqcltw57?=
 =?us-ascii?Q?EefrYX7n1Ly7eBuYPO4oATQ01BgRQHP/qxh6YKGsk5ihpTjGc6toEz5bO//5?=
 =?us-ascii?Q?gfgP/yC6gRgkivOAXl5rI9s8c0X60efujU0ts9D1g4J1dGQ5E7jaLXubA3xM?=
 =?us-ascii?Q?KEFbuspvShFbZUUhOt5wUM8iwgqo2TDZVmn1rJV4D+AgieOaXoP6gRu6170F?=
 =?us-ascii?Q?RhugTuzwOF8CmdTLexMkQDTSy/ydzKblLGwAAkM/NW5St2VSE1XAmMP5X90W?=
 =?us-ascii?Q?sEBXL+638rFQXUnKDGgdRMn414BT1s4YFX2cGSZJEWtp0LsYnGtG3e2vx6KK?=
 =?us-ascii?Q?Y7qkEYxSEgxX2qd4ZneMIKjhIhKCGyHFFq3pqP3AjYKMJI7ucM5M5FasN7d/?=
 =?us-ascii?Q?76MkoQRyiWsop5pU+kNz2olC6XFUN5R3rQqRkQ1LlgjwVPnrmjNNr44uegw9?=
 =?us-ascii?Q?wUXQwO1kDcT8r9Y+Yrl1YhMTWMA/WJtNCqH+KpRtexIE7kDP1xVXehA39Ats?=
 =?us-ascii?Q?T3DDz35WTT58OvTRmPDGQ4/0WZO8M7glQ/pwko96ubhN3k2qwYgw5Sy6UNFg?=
 =?us-ascii?Q?RtFQZ3cXq0gSDX1kjIFloIciFVluVOTbI1uXlGRhN/1JijIg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6988de-f809-4f59-901e-08dea541b548
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:58.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1zp/wrDGQZtFPgsd+iQq0sQUcfMzXQn0uL6iHSlOgpTqI9htiVkb9sebaZzS3Dd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 4AECD4890D7
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
	TAGGED_FROM(0.00)[bounces-10436-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Applying the corrupted patch by hand mangled the format string, put the s
in the right place.

Cc: stable@vger.kernel.org
Fixes: 654a27f25530 ("RDMA/ionic: bound node_desc sysfs read with %.64s")
Reported-by: Brad Spengler <brad.spengler@opensrcsec.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 0382a64839d26a..73a616ae350236 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -185,7 +185,7 @@ static ssize_t hca_type_show(struct device *device,
 	struct ionic_ibdev *dev =
 		rdma_device_to_drv_device(device, struct ionic_ibdev, ibdev);
 
-	return sysfs_emit(buf, "%s.64\n", dev->ibdev.node_desc);
+	return sysfs_emit(buf, "%.64s\n", dev->ibdev.node_desc);
 }
 static DEVICE_ATTR_RO(hca_type);
 
-- 
2.43.0


