Return-Path: <linux-hyperv+bounces-10431-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KCrL73k8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10431-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:47:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F04894A7
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 529003056EC4
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC344D686;
	Tue, 28 Apr 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WoFAHFp9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20342EEC9;
	Tue, 28 Apr 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393087; cv=fail; b=cRVKpRljVyImwTOfv73ShKYcjqaT+cv8ci/FbEPtig5d3nq/Sa1MQXhMQZe5HtbF3KJoZT8H7y/+Cwt7qS5PgY9XA+vcPzWDYbVyLFS9cT/Hsoe81rdwH7rPMqgy86st46we+FXyVMC57qetZKAHd0IbNgABq81Eyx71pPA068M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393087; c=relaxed/simple;
	bh=OXxEkxquuC8vB+2XM4YZrreu4oJBZqtqwjV3J6duogg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZz2g0broryBqJeduarF65ty0NDDe3Y2bjQaOnBWEoDHhPm+ET26Vtwh/Q+iuuLCIn04MEKkhAmBlYlTInH8NDDNuavOddwV2sSVaJceCc1g2R1IjMBSeLM4cJ+nIs2kso2MYLFAHn0rM7Y6p5zeaY7qUy04049TNgbzc2FX43U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WoFAHFp9; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YajL6CEovmJW/w8ZdZ3VSrGoYqM6DFJyWTGaur2Crncxw4ZNpvv/QMF5+C+BJJAVZC3JYhrmrqrH8beHNEUQ7PwWVi7FGmz3xygSJZC7u9+HQdJMi60FHqNYQpoDc/7bMNHv5S3f8EVYIf8KA6qxXuUYwpZoXVFdW+IjnHPZ0W9av8ri/uJhrijU6i+Mj6YMh+5UxdhEou6WygKbWJmSZerUjdxu+s4xLdhozFfk7prx3NF3kSjMAOE59n3lhHU3RF1U+rN+L7Bk6veVrUUDZnVW8VCOZa3edr1mSByBsL/gnTFvRr9PVBUxkKoggHtrRAKpoi4PBVRit71rc5u5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdGW8WZOaQ6MQDdR/hPwo1B2yB6FWy/Qj21f18okCr0=;
 b=yBFyLj1jAJ82RiXsiFLNVnourzfObP8xeeJZslvTBVFoxMVgq6kAQ12ESQftz4k7FPLJ8ImOkwjeXP2gep+MkGlM1RHd6/qdClwRRFLZm7BkVQXjBXbneNE3FhH3qJqsrMzVIVulyd4DWYowkOTwBAnMd12TTLnv6NNLa5Hb9m2pOqhwtx9+BGAFhs6f3+6pexfzDmyLwuAQ4UZ3Bo4E3y7orsUepkFGORJi/SxxNBzM5NGzeUfNnYiBTPZ57TzlgKmgGzKZL47/PrY/576DiyrKD2Q54FGNgFsStI7ZmWHnVFjCsOAK30z4liVtEKRknUM7MgJh9Z2/4F4DJiCDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdGW8WZOaQ6MQDdR/hPwo1B2yB6FWy/Qj21f18okCr0=;
 b=WoFAHFp9oMje/SosPlaZW1NtGhDeCumUqN79X241Q13fjB67/VLZUEJAAqhhumpdYLZbfcruiioKQyXLCn9gB9aH17V9iExNqW8VeQsXoyy8bqOhLT5JEmlmh1FrOdFRKqqSkZTDd9MZ4xQ7+E2ZAEMO1dQGcs1iPqm6NVuP+MtNUcBHcFpZqDcKoncI+AdigTcBPCQp3GTsXqL1vbjCB+KXAosJdt3FusOlDIywr1PeMkjucEElWmlk7kJhlaYE/U/XEqzO9CF6d04R7YuZ/CQI0R4ZgfYeiNEsFJOM5JfqlSQcVQvaQj7umsmqeAlXxNyEOO/DadUrpiWKzOgcJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 16:17:56 +0000
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
Subject: [PATCH rc 03/15] RDMA/mlx5: Add missing store/release for lock elision pattern
Date: Tue, 28 Apr 2026 13:17:36 -0300
Message-ID: <3-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:208:32e::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3f9246-0f6b-40dd-e9f7-08dea541b2e1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	bh6kd7M1m2fumGgz40yVSoaW/TpZvx1JMkzp+nu3fEAPvvG9BY2s89rMQFOZFpi4Ct8fWSGtWVmwxg2BgTN2KFrBVuyq6athE8Y0O8IUSCcjq1Oa8PIJ6m2BxELM5jhzW7i59NM7PygV/8/HaThyXS9VTpmGJcpfZ0FLlEFmSUTqDK/0Elr8xpHoZjpo2fAQ3M49HGbQQJbTMrtPAH3Uud5sXMI2YfCikDQEECxD6H6xR6LfzPCpCGgACHKAIo9dXJmBmurvgZonnw/RJHOtYNNxgMhiior2j7Io7iL6UrFsCVTZEv9L8o93yCTN2JXPn56DOd6uH0mlhNLldWJjhrJm1H3qFKsohRIMkhuSokWXXdEfa9NEnEQmKmNBReMoMBEoByhNVuSgPAqMi9di0uhHVUtTUoCg5px9usc49AQAXGV1ublRiBt1I0o64LKHZmhtOtQ1l7zPV2tMgAvwtYasAkGQ3aekw3d7NWJBzQy4BIyL2TxUMstMO31eKn43YGy2cDi4oUxw/TUvpaSxYcmXYSMugcJRv7nPET29zx/o+J+3VoTGTntZP1wNI3nrGrR4uSowiS69pPmMV0gf2nv3isq3BANFA5vX1znUecs5m5at21ihd3K0lG3ecQLzS3EitE9qb8cIsDA9uu33yswsqqvYkHsfeFuz0aiIqldrEsv2glMdzkFAv+Uc2K0VVa6dA0yf5Nrma4S68OLr3b+kfXwWD2UpJelF+ehBtkRsad5Fs6dc177pJR7bPkADlgW5IJ0NmMlHatkQ1gWQLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dYQWupMh2cxgOO5psKRB9vb0jGHThVbj6nBhAQ2apvknrE2Izt24ZXl/wXSx?=
 =?us-ascii?Q?uAzDSgoDlHWXTrGzDbt7v3AN3xv3qSmnwe+ItwXI33Sxmwv0TEXQqP8tC99e?=
 =?us-ascii?Q?rciMZM+Ur+aCwFTl3avQMzVF2VeJ1WS3jPUSQKgrWHvZoiRLuijBjDAoEZk6?=
 =?us-ascii?Q?QeMaFyOo9UnYKgi7FBHbFsP2ZTCucr7nZjQsAhVNIg7ODzxCs4YkUZcxrGYw?=
 =?us-ascii?Q?COInHrxvdzRaLgD4/kNPIzGLpCbxhtoBuik2vde0G8NgGlCO9E6AN5hFYDnT?=
 =?us-ascii?Q?qYM5jUyq1X3n58P+Lc+GEhM8lxjFvsGC/Xn6T+LCOT0SzylxZOhArX/TeKKl?=
 =?us-ascii?Q?a4hE/kGTQ7x5MUnNCba52kapX8KAgApyWhZzpmDYWMAMf2y/s1KKuR8CTYZt?=
 =?us-ascii?Q?dhgaLmPkpxcnVlYdCqn2cf7wnoFIjdBDSn70B7GTs6mIHsxuUi2THukq+WcW?=
 =?us-ascii?Q?pNfDQvprFSzzbPLYihZVAcmOd0l4gKopPhgfv7a8BbtotSCN3Wh2QsZXCoM7?=
 =?us-ascii?Q?1va9BIkSjJHOyE15qw2kkYKR0sCSQvlHpqETMWPMrWALdgvJQ7HX209AkzkB?=
 =?us-ascii?Q?AWdN5j99GWZdfQBbBgveq08qjVf5OaBQgTmogcnJhkYvt6CIVGa1d1cBnl2I?=
 =?us-ascii?Q?fzZnncyHGMiGqU1psZPyBPnJ3fbB3BtVwaIE2MiDTM3pE7u8QK1n53IW3w+T?=
 =?us-ascii?Q?ckxmzSh6QLFQ94xBF+QiqRaUYDbSHiM8x9BPGQYSqTbYZH4WZMMN3LaNq8Zk?=
 =?us-ascii?Q?FjkmXYal7IROq1SHCL57fqI2Qn6U251TbLBxdA8aicADmSAo+VgcmYpKJX77?=
 =?us-ascii?Q?oulruF+bdqgn9xUagWYKvYXK+xNTZ3PDVJQDERuQoVq9J3Sa49GQ77b/kAhQ?=
 =?us-ascii?Q?elUPmxmtxsim/E7PcbNPKTHbKV62jKRtewS+P+Hni2K5LJFuSDMZhuu0K8B8?=
 =?us-ascii?Q?HUOrG7SeGZflY86EgSlS4JITFVfvhJVQ9y87T/dOoq6lSt7ujVIwSyj1MYyf?=
 =?us-ascii?Q?+Q4ANqJGVm+DZ67h/fv8h1HqtlsPGrh2ByXwVyTgcyzU+PCSkPxI6BZYfmoW?=
 =?us-ascii?Q?0T0Iv6IzSFpb0nY+3SQJ2udksNLM5zlyKtI1hScxb63tgt97Rdg/bBPlzcOB?=
 =?us-ascii?Q?fiAv+9aJme2tD9E9IcUolgh2VeQczWeuevKa/qhqGMGir2ujzjJbadtHmIOy?=
 =?us-ascii?Q?++rS/kvRLfnhAFdv/3bm8kjzS6OZyp8k5gQk8ijBu+k2hKbYZxKwtMKxgoiI?=
 =?us-ascii?Q?k3IX2dAS2h4LYcezepiojSR9iby+qbzSFrRchstIEvHwkje4JvRUv6iegj7O?=
 =?us-ascii?Q?7oPLGl40+bEuBob8jaDX2KezNXwyaaHWMRiV8oH6PRLcSZCV+vXI1ZN66bbE?=
 =?us-ascii?Q?lu1ZDdGSEcJMT4/Johw8XwbbKaebSHHUqBPfyXExoXNIGf93h9ohsCQl+36P?=
 =?us-ascii?Q?FrloXxoTfroyt/RbyyQgmdhS1qjs6sYE+O5WDgSfueoUcNaVCHxpQZeIBuCL?=
 =?us-ascii?Q?45pIazfpJ1aEgAnAjQb+Ax5HIdmwD6uFEgDkJuH+LyDvbMsXHDiGCM9dv9+z?=
 =?us-ascii?Q?IpcpQFh8N1F4vBUlwp6zG/K5r1q853uKO9GBF4NHs/1JJiz0UKeMPSxK+KT6?=
 =?us-ascii?Q?QT/+xg0NNYtnx3ROuAf+hDMhOC3CPoW5tmEcQkD2XM2b++aaArDz2ZvBZXCr?=
 =?us-ascii?Q?i85apCJMEatWNW77UzR+hUfts3Qq06iPx0yfLTCA2JUIZ1HL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3f9246-0f6b-40dd-e9f7-08dea541b2e1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:52.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n01gCogxUFFuIfLO1WYcT8cAlNO6V+JbAFoYdmffATN5lLfM4rBsPwBNaHK7FR3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 574F04894A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10431-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

mlx5 has a common pattern implementing a device-global singleton resource
where it checks the resource pointer for !NULL and then skips obtaining
the lock.

This is not ordered properly as observing !NULL doesn't mean that all the
data under that pointer is also visible on this CPU when the lock is not
taken.

Use a release/acquire pairing to explicitly manage this.

Pointed out by sashiko, Codex found more cases.

Fixes: 5895e70f2e6e ("IB/mlx5: Allocate resources just before first QP/SRQ is created")
Fixes: 638420115cc4 ("IB/mlx5: Create UMR QP just before first reg_mr occurs")
Link: https://sashiko.dev/#/patchset/SYBPR01MB7881E1E0970268BD69C0BA75AF2B2%40SYBPR01MB7881.ausprd01.prod.outlook.com
Assisted-by: Codex:GPT-5.5
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 8 ++++----
 drivers/infiniband/hw/mlx5/umr.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 109661c2ac12b0..73fab8a376933d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3310,7 +3310,7 @@ int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev)
 	 * devr->c0 is set once, never changed until device unload.
 	 * Avoid taking the mutex if initialization is already done.
 	 */
-	if (devr->c0)
+	if (smp_load_acquire(&devr->c0))
 		return 0;
 
 	mutex_lock(&devr->cq_lock);
@@ -3336,7 +3336,7 @@ int mlx5_ib_dev_res_cq_init(struct mlx5_ib_dev *dev)
 	}
 
 	devr->p0 = pd;
-	devr->c0 = cq;
+	smp_store_release(&devr->c0, cq);
 
 unlock:
 	mutex_unlock(&devr->cq_lock);
@@ -3354,7 +3354,7 @@ int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev)
 	 * devr->s1 is set once, never changed until device unload.
 	 * Avoid taking the mutex if initialization is already done.
 	 */
-	if (devr->s1)
+	if (smp_load_acquire(&devr->s1))
 		return 0;
 
 	mutex_lock(&devr->srq_lock);
@@ -3395,7 +3395,7 @@ int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev)
 	}
 
 	devr->s0 = s0;
-	devr->s1 = s1;
+	smp_store_release(&devr->s1, s1);
 
 unlock:
 	mutex_unlock(&devr->srq_lock);
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 29488fba21a034..f2139474be3751 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -147,7 +147,7 @@ int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev)
 	 * UMR qp is set once, never changed until device unload.
 	 * Avoid taking the mutex if initialization is already done.
 	 */
-	if (dev->umrc.qp)
+	if (smp_load_acquire(&dev->umrc.qp))
 		return 0;
 
 	mutex_lock(&dev->umrc.init_lock);
@@ -185,7 +185,7 @@ int mlx5r_umr_resource_init(struct mlx5_ib_dev *dev)
 	sema_init(&dev->umrc.sem, MAX_UMR_WR);
 	mutex_init(&dev->umrc.lock);
 	dev->umrc.state = MLX5_UMR_STATE_ACTIVE;
-	dev->umrc.qp = qp;
+	smp_store_release(&dev->umrc.qp, qp);
 
 	mutex_unlock(&dev->umrc.init_lock);
 	return 0;
-- 
2.43.0


