Return-Path: <linux-hyperv+bounces-10430-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHk6LhLh8GmoagEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10430-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:32:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D334488FD1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCCA30D2BEF
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6F43CEF3;
	Tue, 28 Apr 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o3JO6Bsp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF7F3B38B9;
	Tue, 28 Apr 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393086; cv=fail; b=Vo8xRWA4i6ue0whxNXUp17NiTmQ7xAIO+MuPhLCnIzOM8+7pq3fkp4x+P5kAewTRypNfJUQ1LbK/UHOcwR989hXLpWhRKrC1ven90PfJBJP4I3jEAqHTW4rP7qfsqx5aZeCptTFzCKCtEPzD1E6gD5WgVq2Rvp1ADRAkHM+VdLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393086; c=relaxed/simple;
	bh=tJbT9L2NDSy24c2ZNvr7nit2B036JdmnLLgi9DOVFwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wo08AH1XUZniftxc43ySS8NxCBoEGjtPjS8kXkFcSXzzHfNTc1xAAob9Rax6kwM+ebLP6nnvo1wtltwsa18iESNWZX+q8uzTerC2/wLli8CzJpzSyRnMhD105LH+hh1AIXqM6aEhccawRKEyXlTd5GiIFzdmFC1Rj+b1KV8wlGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o3JO6Bsp; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy4bkffp0ZbZmDyoIyRoqiqQFWFPKsos83yejtaMDlBtzs87PxICbwKCb8VdJ5W05icOiLeDb2tA2ibaKDq3GuNUfEh/Ru/kPvzjdm/+oJjwwN9JW8Ie5elzU2E/gJ0ieTcaBtRGL/MNSL9HgIMBxUboWq79FWfi2QXlm8ks/WsZAb0/S4zyGCM1UAQTHogmq71ZC/nqYFHs6Tyb5y8zshbgZ7HOeFMi9VARMeh5di11cjh6YBgwxX09eFTOJlnKuDXbB6S+1HEgOKCZ7vlcisyPkoMw40mHAV8KzYnLk3e5Q3dkgchHZr9Q6OVHIKgKbHjnmr25w4rwZPZTrxMZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKkMTaucY2S/7iuLBkoHTbvWF3dT/3vomg/Sk/NsJ8g=;
 b=q2KGg5/xFEdiJ2ORzc9LfKkLjZwk8M8lUEOAT7DvYcZ6F6SnOiktlc16DSGrZu8rpxmu13d4ruxC9f9hr3zG7T2uiMx2ynh/8DRKDKhSAPciHpR14E3vtodN4JrXcPjHYHjZx7IAQ5xm4TeKFgIlZHAf6jEqOok5Edv2JsRU6iWaZkn3V9fmNnHVNfRquQty+e3LzknBLnAKttkCLi+186zCRmp6pCV7NjG+kBGImpmY221XeODOsE5mJsapJFZ2gURp4ziXIEELwDJXiy14HgWflYwe2QfOnTANEJibOwPgCNjTW/mM/5468j6VZh89Wa/TjB80tBi+aMuHxFBwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKkMTaucY2S/7iuLBkoHTbvWF3dT/3vomg/Sk/NsJ8g=;
 b=o3JO6BspNfsb6JaoQ4fLRVCvJhOVXC/N8OJA/GBI8cTiJQzs/8ixQFuYV5O1cmfoJg+oVvUbibnhy24s0LG8GquYM0onnXOd0Cs/Q1HKSFFdWERXGOdaqTqeCv6BdEZkVK8qVgSrJJ418L+8aRFrlfIC7dAVSvfmZq2NuinjYyJTunhm5A7QmvKdQqAzKpdeO6VwLuWq4X+LgNLnmdRDSwifvW7YuHNl0K7mZOqN0DusM09AQj+15gPBw4az9MWwXCywhq1eFZhKYb2cR6fOY27yo6LqsbfnYtMn8RXVD7RKb7/OG0lBQvVcbVrgqwZbAFhk+U72emzeG4h2+bYZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 16:17:56 +0000
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
Subject: [PATCH rc 11/15] RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
Date: Tue, 28 Apr 2026 13:17:44 -0300
Message-ID: <11-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:208:32a::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 6014c183-fbd2-4123-063b-08dea541b2c4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	/QcduPX1wSBRAyFESswxyPtzBSbsAKRMM198CD5I8Bq1PXhO1w1wukVZ/ImFwwG1Ajdad6icK0IqbT/sojyZvDqHIA8vciQmdtpCezjVmpFwuZ5ZkiBMY0kBBWRbXIsv7PuYVPu6Qm54Hat3/rZn0b1iy2tK3IWSKD5+u85xrgAPnykGySvs+cCkuy3hVd0C9ugNCi6xYhRiWjDvirvWVMt2S+j+sfBkadmGenyG4qCJ0MwEHQCtoOL65JMT6Ocuo2FGsFU1vFIyPXi6fzMNovu0XWKhuITZRFCYbADWho4j6EZVgydjZYD9YsLHqPwibVbttyX6fyGpAr/vRqhcMaxAFf5i5eSrdOP/ygKLWOMKMKVdsKdkFgr+GKTxgZhSxzDC3X/hXG2iiobzmhMBASFBz2i88CMTSE9lBZ5hl4EAMkX4luHQUawr+XuWOA0wKIb9BddsiyggQSQNcXrjOU84VQPTMwUoMLYFvSH/FnNNaXS++4D2x8ukUL6jO//zzt2irt1thQH6pq7gNTLFJ09Udke3zkPWDAFPS/SQKneXJD9wchfWWdZxmTXHqURm2JpQkKVck+E977IP55k6RVeT0M251b3vbYsVAA/lyZpCulnErh0Xf8iSbQL3k+5QddF8gIB9ctqOEUWCGFjGTV3OXoKkPh/FKEC36g/EJmCBmOjbewONn5fRu29PlUiwhVny0Csx7U0MDItFjYVvF0yEL/IH9yw4COguYjkgMWqJ6qCcYrvkgJuscFFwn1tGK2W+lMKAWXPlhyvErxswGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jv2OViJElbSAxKH+0+ncaIOtd+6XIfA+BaCE4ocUGvA58S6vP5PkAMZJTo+a?=
 =?us-ascii?Q?t3d7bCPtig+vB42gkjQu79yNJiDmLhrFs4m9nGc3YsgEBfPmysyT24VR68Ba?=
 =?us-ascii?Q?y6DX8bU0QfZBkOuPY5Zj3I9XIzfOr3yQqVF766021kiM9ZJ5I0jQ9MUn8WR5?=
 =?us-ascii?Q?c5o8Ktxkc99g9S/2/BT6Uhkk72dvaka6o8Yv7k9nYcAEZ3VftCStLQlMSwI8?=
 =?us-ascii?Q?kiaImxXPD4pB1dz1/b9ss8DR6/JaFXx5RFTCKelFc6ymNiLRCw41dsd3HHYb?=
 =?us-ascii?Q?IOTa1KIuqsBA2Z1Puj2v64ggc45licyK+/YxBMKvasJ+8SM0PAEOErs7+nWz?=
 =?us-ascii?Q?zU/Hc+pp17RcG7DiB/qcoz72oMCKHt26COzc1QwDoCHlgVInVyEWhVRKBpYF?=
 =?us-ascii?Q?fJQ82WsJlZ4oNb04kksV+EmOcLeCAWSg5GAp71EnGrdl+M6uEcjcMr++Ff8J?=
 =?us-ascii?Q?UbwtV9YOe//hJsowsQqL4YJmqh8TMli5paw5aF+l9Epd05RLhPMX9shPkSje?=
 =?us-ascii?Q?e8rmDT73CZ7VjsN4IiVVjGkdL+sp2gPChXATTR3vpT/Xpuf66Rztp/f31UOP?=
 =?us-ascii?Q?U1tj1GGyizB/jtGyHSJlGmlLuSB1PQui9paq9PWpXH6fH+2/LY9gIOBViGkh?=
 =?us-ascii?Q?jswSJFfap5A/GOSH5lN9L8zEuqD8JXuITWZNUSRnzTF9uCce2hxN5kB25YAB?=
 =?us-ascii?Q?/tdrnwBZhsJyy9WFhIdt2IQzc4VX+B5Bb6vyTBUooy16609HYH8uul8qKsj2?=
 =?us-ascii?Q?FptMmTP4Lld0x1K7TA0y4G6d8sPrIVJhb3ppWHrD5OEzvsV7zna/l15ws8k2?=
 =?us-ascii?Q?siRajsNQmfTzaKHSb3hQte8c1JEu3QMpbM3+1bfYdR0EEAuim14DX3vkC9V9?=
 =?us-ascii?Q?gHRJ8YoIM5ONJ3baXnzwSxz+K20DPFpQulw2UpSqVQXYFpMnYujNskJ+SXvt?=
 =?us-ascii?Q?7gPQS0hiifRabOl2GBh2XmPz+6xUgrVaB4/pgCg+Nd/XpbM3KL7dbVcC4cn+?=
 =?us-ascii?Q?Iiia0vD8n1jiDSbPt5TbSHVLQURmQGsU5NiEgLx4N2/yb/OveyQBaXoHdxlK?=
 =?us-ascii?Q?xFriAq+Odn2cHCVkxB3PlqIoyYRv6jEmT92WIRGCUPcUlzSn+kIZNxi2S5eN?=
 =?us-ascii?Q?fRxBU+EmN/XYkw8szrVTyweE1b4FoyrbW8IiGQi3MKchqd7fl8c6ca5/FapP?=
 =?us-ascii?Q?2FZdOT4olF5io9z4ma2tG0wJf3s0bEoTP3faAyUfvtQSumMBLi7ZXIHP3U9a?=
 =?us-ascii?Q?FKScM54mmUTSoPVxX78ZXq3dOqgbEX9KHsigvOwmzyFakRvRhsWhU2eTN4Ug?=
 =?us-ascii?Q?bFfR0PT5e45XwbHYKwz0ichgmArH58/np7Vkxi9vRhRpti0sVVNJj1doxFSH?=
 =?us-ascii?Q?cOMmYCrwn11SqlA1Te6rQtSrbMX0rnr0KoX985tOVt9/C42o57TulyU0eTzL?=
 =?us-ascii?Q?Uo8fkS4CzSmBlSny6kEt1QgxgsQJlzDA844GU+GJUezSkwq41GtaXPPRK9VO?=
 =?us-ascii?Q?U377yUcWcN4glDx/o3XzUNZ3aiKTrCrUCxXSOQDLMU/FB/lQriXcwZ7tgfhn?=
 =?us-ascii?Q?7v8LL3Dq5KukhZSpx1feeaajW0DyvuIpxyuMOPDXKVL2r8ntAVKyc63DeOGJ?=
 =?us-ascii?Q?9P6GfOA6sM172cvUwSMfI1Y2jgJ99ttqysGnLuap9LGHjYti7ObCNG0chSXF?=
 =?us-ascii?Q?CoxA/6h+YExiVyTxhe3CiFfLHDqbG72jGreBuDh0RPJS8lym?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6014c183-fbd2-4123-063b-08dea541b2c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:17:52.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj2ghNSwym0wC9bGHLjDeSvaOpUFS1VK7X/8fstEuYIYXS+2Lyvt/C7Ay4e4eXG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
X-Rspamd-Queue-Id: 4D334488FD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10430-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sashiko.dev:url,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Sashiko points out that mlx4_srq_alloc() was not undone during error
unwind, add the missing call to mlx4_srq_free().

Cc: stable@vger.kernel.org
Fixes: 225c7b1feef1 ("IB/mlx4: Add a driver Mellanox ConnectX InfiniBand adapters")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=8
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/srq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 5b23e5f8b84aca..767840736d583b 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -194,13 +194,15 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	if (udata)
 		if (ib_copy_to_udata(udata, &srq->msrq.srqn, sizeof (__u32))) {
 			err = -EFAULT;
-			goto err_wrid;
+			goto err_srq;
 		}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
 
 	return 0;
 
+err_srq:
+	mlx4_srq_free(dev->dev, &srq->msrq);
 err_wrid:
 	if (udata)
 		mlx4_ib_db_unmap_user(ucontext, &srq->db);
-- 
2.43.0


