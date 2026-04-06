Return-Path: <linux-hyperv+bounces-10027-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEtKDlfw02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10027-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E86AD3A5CB4
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDA9C3023E29
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E73932FD;
	Mon,  6 Apr 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kE2f3OEh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD53932E5;
	Mon,  6 Apr 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497259; cv=fail; b=mz55laeDY98OEhxvKDJek1Mqoxnj1eLTXxPeQF2rbzc4Bol4HGVxg4M5B/p0pav4evAMxPJIv6z6UJiYif4kl12KePrBwrrOUQb4fXSG9CuDdyBU0+5U7hIiPKHJ/Mz1tEO4dQgX/DABAEWqI5pGNfsdAEXaXqd8S2147gK81AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497259; c=relaxed/simple;
	bh=gT1QW5AUv7RQ+6/VVs6ArpfjkHnAMoV8eXIznvtohuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKdeommZ5qADN7TE1rzNTOPRj10LPC5tcwCOEg2dB+yv+nXVMIzlytQY59C3l29KDoUxHE6hWa4UHt+cm4gE7ph0EHinsjpo1vvTzV+t+ZVydaa4axJjVVrNwXy3ZL2jvKyQGQ4r9FGgz8QgyQuBU8qf9aAMLon04Un7GNAAgfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kE2f3OEh; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EafRCq5oUoLPyiGqOKDeaZZ+rqAgyBmkm1duh7Y5NEsCUxLuE524sOk26XudsM0JV1gAVphsNsuQPK08iQHHGv3u/q8SchJTEhVL6tMcqLOdHGa7IxBmOEt4iqgfbTYUm2VZsQJdSQBRjtOLQw99/SKBgyVMOevIcoklT3tUs1Vr2qo8fO4tl1yACeQndIpIq8WNIbOr/jGlWmmngYNa/W52QGEfdpcfUOt2skQn1wM3SEA5Q3D+XV88KttkMSrQYdJbpvRMFBDtPJnSPP5liGzo6fELw4rTarn+75LOHijnBqEbLMvRDl3CD3Tu+uFvjsEnUoQ2cLiKfPQGU2huoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUic/PP8Dc1ziSMSpKqyjSQRAQYRno6FBPBt4IvYQcI=;
 b=ZixQo9w1NgqoHmLTBeJPykWakNx3w3DE0EXPzeW/17d9Qqx6ohA9pZ9MGHjVIo1hTUBQ5D5NZ0O2Fx4b8H9O+8aUbIKfqFIFpPFP5BRzpkDxduVg9tky4Lqy4TwdjGhxcuvEBVFdJjV9CQK/RBPi9brV1IUgIWIOWZJ+Tfhhj9krTH3xW2TbClTq3YjC+Ryorx9m+lZAZcHANN1OVx3zCAbn9MD0fc+aglDw3AZpilB4EgLHZ+pRbvha2C59dB2kO61FpYx51HoLmk2ki8A2BfIbOqTZm7tPJnu5Nq/9BBAG3I4cCnoHVhrivhmuAGBTERlO6B8+ieddX6vaIqpsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUic/PP8Dc1ziSMSpKqyjSQRAQYRno6FBPBt4IvYQcI=;
 b=kE2f3OEhmcKjvzHnOgwrU0fGAWmcx1FGZmGKjmEbo2bGT/PAoEmw8j14O0NncWm6vQQms7AARYlXlZlAPVgP7MFnhZz90psuOE+kuL/MpSmAnbkMDtiSrDCcm9TKB3/HbyoZnFWZeJmExvxkOpnR56t1n+qyk4CnfZv8oouSnYnZfr45XiZXI8JzWjyuYG0yOI3mF59rv22lOhLdGNGuBTCGJkqfapcs5p3DLGzxZ4SSobqEJenhiY3JFe6uuMGiIvgI42vM+joauwiz283ZvNGDb30/3Pt8sU6s8KKghysyEBbHmJmGYtlef/UsD2PMIlBJdLnVx4iV54rxREMHfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:45 +0000
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
Cc: Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 14/16] RDMA: Use proper driver data response structs instead of open coding
Date: Mon,  6 Apr 2026 14:40:39 -0300
Message-ID: <14-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a6a933-e450-4d64-2be7-08de9403a100
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	iRd2CYfnlkMQw2KZncSJH78R9YmCpN+lVf94v0HlzKMiWroNv+vhwrhvbvG7P6iH7F8gJn0B52usbiBDEO5pEragSs9RYiUk4LKd8y4sXfWp1EYIsuPc8Pnyp2bwFqVeIAouGAkB5HV92yLtHds13xapbN1lTr/G2X7qqXhAivRW56clY/Ua6c9b1lrN2Epg7y02pj7HR6qnG1wfKMHdBFTPnNvNaTYhfQlKUv79ccOX4HiC05izjTswzmh2a06d0REUlYMjcSjnLYMyUdrO0x9b2zKrPGLXeCawKcVlv0R+q+q3rneGcv3RKG40Q9EGP/uDkJyyC1fRcfqy3+htm8wNUIdWbnTIUzLWN97Mgh5dM9ke2VGgLOhL2DOsOU/PeKoC6FIkAfu2+DrVB2hjutdic5xd3hL3fTdu0zPEARBAY+DibOhMgMsqiKCaXSkbSKcty9oChbEBQMEh2v92kP1GF2h93fbM424BMn6nH1AIf9kqk58sY0+3XGNZBOBRJ1KIw0yVFDaoOn/nkkk2Z25JaRFHFXIyCTuEx4zKRFQxWXq3wSAlfqVqgdMyKBew3nQrErY5zcaD+PyAk74zrSFpL48Uy+J92wRhob8lw9hHMAbDCRRYHFa+4jz1rkbWZ+UxRE+g8nyNA5Hq0Qd0dDTVB+NKu+OAs0aIlsbB2pHoVvsQc7ekq4f0ciiZZ9QcPqi3lwUdnd0JcOUZsgNxxzJ0jhGO79Wk0MNiXtabZM8OdThS1IiJk5ZQe/tHT2ubCQhqdhUuBdnUNSTAd4nYmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qN4a9zNiakWiCjgq+O6fLEJyCAxKqP20aHpVK9NuMKVEm1mgu1zig6CyccVH?=
 =?us-ascii?Q?1V3kycu2DbZ8fJ6u4YeRunOvjWTsTvWjGNoguyI/+UU+c1FbDpKUJeuay9co?=
 =?us-ascii?Q?qBwJDLDh88k0jfqBvi9rEge559g+/u/+6/wcho6pvx5MAeCDSfAr9YpiyJQ4?=
 =?us-ascii?Q?/ZoOhpNpCxhvoCTJdRbrQrN3YBq16VjZ2npfdniL/g10Y44HogivBYICQdrj?=
 =?us-ascii?Q?FxnSEy4aab9HIOU89O/L+4YroAAEU9QUDacBGYJWOelPGmG0RApXANut3MP0?=
 =?us-ascii?Q?tA/SsRYhtmFjajbO3SmtreOxYJ8pABrUC6Ty3Qz0SW3/BYkiN2OzVcc2YfqS?=
 =?us-ascii?Q?dBlruxLiIibAwzegMWF5ifAzXntVZ8C7ySb6A5uS39di2AI3Ibn24Efk6Oqq?=
 =?us-ascii?Q?Li0yB2sAZEjQrL0qaBR+O6qyxatixsSqG4iKX8nqWS9Yua6JYgKEWNNSJ506?=
 =?us-ascii?Q?oww99/KAS+xCmfyDcQkGXACrmDkHvAgjJL7yGfrjkH8+c/VK8mdLJJOfMG0m?=
 =?us-ascii?Q?4x8lnN+UAtnOdNHDyzr2gldShSmLGrAZj2jFT1AkN4tfrzuyvQHt5t5xlHkU?=
 =?us-ascii?Q?RH7KAEUCdRGeC63dOuLu/r4SQ67fw2UrHbwNabd98Fi64/jkeTuvKcIVrhOn?=
 =?us-ascii?Q?AmmFwxlUYZQ1tm6vxHnzI7pI0L4UbpuNW7mb0T6lRe0BDxXGNVnoShcvnZ93?=
 =?us-ascii?Q?gADSZNqv27He41GQ7CQGNRpDrQAroVPoNPa0YqQhbZluKZ4Cb6brEqHOk+HB?=
 =?us-ascii?Q?jtKGNVyNBvyUbvITZQiJUCU8+BgWZpquaQUEBs9aL6XH/VrTv2Ac4fY9oDrm?=
 =?us-ascii?Q?Mq4Tktg4+WUIeXoqqVuQNr+CotbPvViHsTcx3s238LZgPsbZRInxI1yR4Udo?=
 =?us-ascii?Q?VRPvnrfw2vSQLLnmQHl0rAskcb7nTWIo8CT5B46Som9lve+sbdYkNj1OEgcF?=
 =?us-ascii?Q?anON3oJycsDXeWJBnnt9M8R2vj+BU6hM7iQvdbB9dTw1q7oG+ADOb6VMpvK9?=
 =?us-ascii?Q?P3SDBM+QxOJ3XTW6qNt3Mq1Pw4Bul32n1mDbbjZJzbdM+wVVKoSahs2Skkqk?=
 =?us-ascii?Q?BcKQBaVZVAMF03Ge82RbRwiXybMFyBPFAK4Jk+W2cN6KaUE5VtDylvrlPOiL?=
 =?us-ascii?Q?VwjF6N1zUyPXYe8iwKlSolwjOPkXk7V9puJD94XZsYhvuT6bmLKELPdBfUR8?=
 =?us-ascii?Q?fGv1QYAB2GB6sKb5FY9rQbaJgczZo3HfFlLJrzuNQL9eJV3uqNhVm4qVJ08n?=
 =?us-ascii?Q?Y+k282QhdltWEkw3CtkFEQj0klTC6gfqaEGR7o8tkoWIO0v2/8I4NE4V3wPg?=
 =?us-ascii?Q?5TwJKp4roF6YFHuRGwmuJ8kfpGhQZ/fYyMGYKCEF+q9HJLZSYtvpGT+jtSzS?=
 =?us-ascii?Q?1aZ6DprU0vnC/oDMFvqCQv5urI1ozTLo20DltgxHMZM3A0J5IAlzxg4Ifo3Z?=
 =?us-ascii?Q?XRVO6ks/QL8LgoZDgYlp706j1Dw82UemYbwiqzy2aVANkKo6svtABozOnbRt?=
 =?us-ascii?Q?MHRbi04ab0PyrKBsjs2t0K8OeeBKcPWpyMIdvYp4MI1P0Wmn9B2QHlI8DiZC?=
 =?us-ascii?Q?liB6p4QDBNX21RWo8KVFd7u6LK/fPTGYofBm/xX1xGScU8PwwZOIw0mGLJTn?=
 =?us-ascii?Q?cmDK1ZK3M01aLs5AvHo5rC16gc9/2BW6GLj4IjOgGwQOHizAwNoivaKp2fBD?=
 =?us-ascii?Q?Wi0hzTBfAiv36aQxmnq//yVRpp94mJ5lkUtzkg+3+dzMAFXr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a6a933-e450-4d64-2be7-08de9403a100
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:44.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUPV9Di7WB1F8Eo37R31bEwCAdq8yOzG0TU+/QcnMJBAOtvWv7cztUHR20YPDr51
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10027-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: E86AD3A5CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

At some point the response structs were added and rdma-core is using
them, but the kernel was not changed to use them as well. Replace
the open-coded copy with the right struct and ib_respond_udata().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c              |  7 ++--
 drivers/infiniband/hw/mlx4/main.c            | 11 ++++--
 drivers/infiniband/hw/mlx4/srq.c             | 12 ++++---
 drivers/infiniband/hw/mlx5/cq.c              |  7 ++--
 drivers/infiniband/hw/mthca/mthca_provider.c | 35 ++++++++++++++------
 5 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index 7a6eb602d4a6de..7e4505f6c78b30 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -142,6 +142,7 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
+	struct mlx4_ib_create_cq_resp uresp = {};
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
@@ -219,10 +220,10 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	cq->mcq.event = mlx4_ib_cq_event;
 	cq->mcq.usage = MLX4_RES_USAGE_USER_VERBS;
 
-	if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof(__u32))) {
-		err = -EFAULT;
+	uresp.cqn = cq->mcq.cqn;
+	err = ib_respond_udata(udata, uresp);
+	if (err)
 		goto err_cq_free;
-	}
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 4b187ec9e01738..25f9738bd77223 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1199,9 +1199,14 @@ static int mlx4_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	if (err)
 		return err;
 
-	if (udata && ib_copy_to_udata(udata, &pd->pdn, sizeof(__u32))) {
-		mlx4_pd_free(to_mdev(ibdev)->dev, pd->pdn);
-		return -EFAULT;
+	if (udata) {
+		struct mlx4_ib_alloc_pd_resp uresp = { .pdn = pd->pdn };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
+			mlx4_pd_free(to_mdev(ibdev)->dev, pd->pdn);
+			return err;
+		}
 	}
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 767840736d583b..dd868f9b893d70 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -191,11 +191,15 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 	srq->msrq.event = mlx4_ib_srq_event;
 	srq->ibsrq.ext.xrc.srq_num = srq->msrq.srqn;
 
-	if (udata)
-		if (ib_copy_to_udata(udata, &srq->msrq.srqn, sizeof (__u32))) {
-			err = -EFAULT;
+	if (udata) {
+		struct mlx4_ib_create_srq_resp uresp = {
+			.srqn = srq->msrq.srqn
+		};
+
+		err = ib_respond_udata(udata, uresp);
+		if (err)
 			goto err_srq;
-		}
+	}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
 
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index a76b7a36087d98..c548d4dfbbc96a 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -949,6 +949,7 @@ int mlx5_ib_create_user_cq(struct ib_cq *ibcq,
 {
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct ib_device *ibdev = ibcq->device;
+	struct mlx5_ib_create_cq_resp uresp = {};
 	int entries = attr->cqe;
 	int vector = attr->comp_vector;
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
@@ -1015,10 +1016,10 @@ int mlx5_ib_create_user_cq(struct ib_cq *ibcq,
 
 	INIT_LIST_HEAD(&cq->wc_list);
 
-	if (ib_copy_to_udata(udata, &cq->mcq.cqn, sizeof(__u32))) {
-		err = -EFAULT;
+	uresp.cqn = cq->mcq.cqn;
+	err = ib_respond_udata(udata, uresp);
+	if (err)
 		goto err_cmd;
-	}
 
 	kvfree(cqb);
 	return 0;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 07c60797c86091..afa97d3801f783 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -357,9 +357,12 @@ static int mthca_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 		return err;
 
 	if (udata) {
-		if (ib_copy_to_udata(udata, &pd->pd_num, sizeof (__u32))) {
+		struct mthca_alloc_pd_resp uresp = { .pdn = pd->pd_num };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
 			mthca_pd_free(to_mdev(ibdev), pd);
-			return -EFAULT;
+			return err;
 		}
 	}
 
@@ -428,11 +431,17 @@ static int mthca_create_srq(struct ib_srq *ibsrq,
 	if (err)
 		return err;
 
-	if (context && ib_copy_to_udata(udata, &srq->srqn, sizeof(__u32))) {
-		mthca_free_srq(to_mdev(ibsrq->device), srq);
-		mthca_unmap_user_db(to_mdev(ibsrq->device), &context->uar,
-				    context->db_tab, ucmd.db_index);
-		return -EFAULT;
+	if (context) {
+		struct mthca_create_srq_resp uresp = { .srqn = srq->srqn };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
+			mthca_free_srq(to_mdev(ibsrq->device), srq);
+			mthca_unmap_user_db(to_mdev(ibsrq->device),
+					    &context->uar, context->db_tab,
+					    ucmd.db_index);
+			return err;
+		}
 	}
 
 	return 0;
@@ -631,10 +640,14 @@ static int mthca_create_cq(struct ib_cq *ibcq,
 	if (err)
 		goto err_unmap_arm;
 
-	if (udata && ib_copy_to_udata(udata, &cq->cqn, sizeof(__u32))) {
-		mthca_free_cq(to_mdev(ibdev), cq);
-		err = -EFAULT;
-		goto err_unmap_arm;
+	if (udata) {
+		struct mthca_create_cq_resp uresp = { .cqn = cq->cqn };
+
+		err = ib_respond_udata(udata, uresp);
+		if (err) {
+			mthca_free_cq(to_mdev(ibdev), cq);
+			goto err_unmap_arm;
+		}
 	}
 
 	cq->resize_buf = NULL;
-- 
2.43.0


