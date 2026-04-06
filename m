Return-Path: <linux-hyperv+bounces-10032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PwgE2bw02lBoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10032-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD443A5CF0
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19855300B451
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA3D3939AB;
	Mon,  6 Apr 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZ3z3v3q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B933932C8;
	Mon,  6 Apr 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497261; cv=fail; b=q/3saQ1BmEpOQrfsgDbagGi1xNOwgaZ3djeXq/o949oCFLpIy8Tx1JsjcTG8Joi/Zk2x5qNGPCqti6v5AIA1aplW9R1sxh7D+WbjQfOxnLR5D6ct8IDzhvkwQNrM6+cqZPLXy1Oz/ms/tPOyFzTTuCA046bMqRIShF7sVCnrqJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497261; c=relaxed/simple;
	bh=+vIWbEb4i0X1B7e1ceSA1tgnUuQfM9HizPELQbeDXs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEkV3v5Nx9P1hweCpnqaecfwLai/349r1S1P1k7W+Wmdk11om3qt2hgf6s+LsCcY0fPTAZHTAKzzdrTlZtnyImbbSKDcrLY/Df3iuEjNKCJPti8fRlKXb6FxaZPkxzRJ0rV454VWhmgDx65a0JbIYeId6NmRUxpxeuBKi6yqnsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WZ3z3v3q; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqxWIKWbt5byzqbJR/592gGd03gg47qdF6eguYvU2G8DjHwU8uwmhf3FYsGvi7sQFO1cIVxSPxOpTkJFTGFs3cbDJf8ybm3YYepBXqIcc+anidio3cZEzfIyJlJp+CyK0FfEuK++W48G1MhmI3R7yFZ+8G0PE05VqgQmBtNtj8dlgiVQr46VxTTqeSmxOQPvWB3OHsq7zrsUGhxKzp8sSfLgQsIuYhkRe+ljOKMD4nWQ/LPpymZ5ASU7pjuXF+pafurYJ1Y2k1SusFNgedny2vz6+BAe5XXBdjE+5yMBK87FA5+fK6hQR8RIVrfaguTq4PvM0ovaIaiQdtId26w96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFS+Coafl5QnAN3KWZuMFRYzrG6MinCj0uk8cEnKx/A=;
 b=x62ghw2kQswQ0ACApbosUT0Q5SJwHK8WPSMSYnQG+HTZFG1qmqzKdp7xdWiUyJ3mbA19ErWBYqxwqCeqCC4QZMSS7e0rf+T8o6nCsH4Iur3hPGLnCBWjAD5TtDNPFENaN4QSnMPssZefEqVD/4z4Py4cRF9lmInS7hBoPMsBGPjgazSW5tR4lMzz3O4Mm73aPKpvP3CFDvTpS0WLtqDsLZat0h8gYmpAGLnr88bjyHf19kSOpmqGd3Vr4nDhK0QypFBwPw6kjBa6XF3TPAsCdbkMjXNtMiguxWLAJbiWhrfEWATRoQ24aIe7Zm8FxjmX8wXbTRKlETh+ZgxcXOzm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFS+Coafl5QnAN3KWZuMFRYzrG6MinCj0uk8cEnKx/A=;
 b=WZ3z3v3qYs1RnuaS7muH2lyWiJg337zqhrJfGAKtk83K1xHs7iw6PdrV9VxWnm9lR5iAhWAwtsr+8mNTVqru4LaOrlC+oTSwrdPV4wAOoWFPnxP+JJ2qbTC5g1Qjmu7bwupbnhlSeaDfGVTQ4f41Zbj9ODWpyur9MrA17m9tjhGoPdGzppO67rn1ZL8vOUuc3L301SVmA9WnKJkZyVwVquoUZ9NyGsJJHc4d0n2oiOoS/VdtG8LKErnpTnkuzhu6c8te2lL9f3oZBJDhyZ0RYzvJoSIryfqBjT9MqMoY+xliPiLmh76Y5/4yGiLQzgEHTavvkHZBdfSai8xIo8hmpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 17:40:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:48 +0000
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
Subject: [PATCH v2 13/16] RDMA/mlx: Replace response_len with ib_respond_udata()
Date: Mon,  6 Apr 2026 14:40:38 -0300
Message-ID: <13-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 92abe962-4067-49c0-a010-08de9403a258
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X2HZfc03zFhLUT52/TB3w67/9dVLnf5ZeNqxSqVA8uR07wJklo0bxBJsw4bdlpGJ6zmaq0/4gCFvSMqgHZX5JSA+QKMMTOjjzRsKtMU4MBWAKYc+CVRdl+dJwv3Yz+0i7arpydJtTN+AggRz2y41QucF1GXsqOEyf0bcvzh6uNWQ/JJ2KuIScIM0O+0ZE64CMrFUVjUK671RT0+mMkNyO+uq2JPoVwLg84MQVQ9Fxx+6uyQSeKK3liAj/p6CMj2BRzgkGe/VZgNlyr8hEtnRkIwsK5c9+IkE4+Is74uccDMyXeksk28WdkaEVHqZvy3rv4ICvHlN5ZlBPHJWgCDJXYNT3uFJ0ydCdVkWnSWvMSg9RPJs4iG/xk6e9t94MPv423zaWau40X78pe0YLl9YAxGP5thGO+2sVPNzZVTrEJXwqudEJF6HvHAdnPvD437TI/0eN0ftNmOpJfzkCaZ79njJ8y6Ih/wv+e85rNdqEeboSlbQ9lkLDTGiSQnW/Mwd0k5EoJrFpQxNERbbaUgcmH2ftDuOJd9e7SOJ+JBgXLLUU2x2sgwaCwb2bCb54LykRVr6/qy9QAaeDJr+njztqmL8AEce/fTvQa506ci+cPpwd5rjr+I5TlIgAZ65LGdEDS0v/Fj7XPFQ0eVdyi7A4m6yO4O43iMGbIzGr6QkoVBIbG339yfv7+H7imycV4r+p//HqCV3zva7TR3czTWsXlrNwlM/6y9siKF6haOZ4cPivsiG5M2p6hVM3p6Q+MoDf+b6fo779dy6eAJYZSN60A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSgP1jnz7I7gE6KnTQZDdHI976Ctd374LOzBwfDI8s6R5c5YHyPdVCZGJbKw?=
 =?us-ascii?Q?f4B1Sj+3R6VTRwyRXdOpYyZSiO2P/tV0sckQcQi+rDe0iOxY2jqk38qeG0IC?=
 =?us-ascii?Q?zHXwIj4aYsHow1NSF0lAALKDryq0DyErVxbkfJbEvvtZUdFcn77C6NuLMsJg?=
 =?us-ascii?Q?q2VnegZzLSg/lYmqIlFweBK9Mkp2Z9ldljiXencHFBscnjQ+7pgKH9ypzMUB?=
 =?us-ascii?Q?6shqyCCjjnpvoId2YuQkwzKMb1qpxRCGmgqtnJILhiCl12sMLwo3sieEqcZi?=
 =?us-ascii?Q?zbNrfSb3spryrvWDmc/u9cDxxwxGuXWVkgRH2ILFbuBQIYEb68sNZq0n6nUF?=
 =?us-ascii?Q?EH/Z8Nu+zCqHumRxs3utImfFZj/udaLF7nnWe5N9+KNZ8HaIMj/ga/wP9oge?=
 =?us-ascii?Q?Tyu58K356Dw+xn1lIqmH+XMIIZAc7T+ltt32VflovM43doT4jucoA/IXP6dr?=
 =?us-ascii?Q?NTp9Bcvg8DM+dcTUtjWPdECI3db+yBfjWSdRcILZ6kMOhkhqmY6xApN6KYJd?=
 =?us-ascii?Q?ZjyTUnWW5dKPHzdAR9znHKl/1rd2i1StlFXrgS+HWFsTQ7VBtq6juM7bMLd8?=
 =?us-ascii?Q?QVc/qjZsbkvyrxODfiuQWatJ+I9zCM5hiGlssRQRhscqh7hoeXWlPzCgKB3N?=
 =?us-ascii?Q?1gAPTduTDShDLDprpHbkvrZ+k7B4RBSpnjJAtoUWARiMOpQsSYB4Ctmrzf2F?=
 =?us-ascii?Q?GUtiKQR9kEqdC5O2EMiga19dqXwWf5JL7trPbtIy1Viy7CqCW7dtmA8ZyhJp?=
 =?us-ascii?Q?06L6rSysG6AH+ZmzJbMZvQZ9Tk5Ub/AOj0ZpXILHmqH4J6XYWAa/Gx1qKEm5?=
 =?us-ascii?Q?KEEhy/A7gCTOvdlAZc606bBVeQTB0VVz0mV55YQ766Mkx8odl87cWbv6TSr8?=
 =?us-ascii?Q?N59Ew8gOO2XN5fD4AYn/8lLU2o/cqYZ7G1j56RGm+KkUi1gWPMKnmw9RoDJH?=
 =?us-ascii?Q?4Ymj8qpPF5/zC/+ggwekZWRMNUwMPnoDQxylZOIbzcIaFFOgFV6kiF96Annq?=
 =?us-ascii?Q?2atadgXQ7xHwIyXp+06IuL07acurn+Alxb+nMNbtxC4UcsI8TVnbTF4o8kk3?=
 =?us-ascii?Q?rp8SxAtlIW6XTpLZw0KJ+7IzFLTfWX7xpqysrtEffgOkG+7prwHn6poCHNZE?=
 =?us-ascii?Q?/h+EnvgzVYgisFl/QWX93KSn2QHDLpisViahnJFvLyfQPgK+a0EwbuHYKvkK?=
 =?us-ascii?Q?6Jok3slTQbhi5m9LQLMXwR9M8T45jvb9BW1bN0XYzZmoonk1OdeC6nKFme9X?=
 =?us-ascii?Q?JkiHoS0Y91mWeaqc+94BBvPAL3SnwEUTTznIXNTqUtQP9Ylf9qkjbLUOc8M3?=
 =?us-ascii?Q?e6nW97upcxjm2td2UEp/gAZmBYg6Bzs6AmOihoy8XDztvkbq7ZmVHwZpP+xb?=
 =?us-ascii?Q?PAFaCbtUPZkNWLiF9P1XYWu/vQMjwTPuXipYhXlLLgZFt5qJ8jAFsJ8JA231?=
 =?us-ascii?Q?RiWj0K3vjadb/TNYxciO6uGbBHGEwGYMWrqdV3a4DQdEylUA0EF9KRQgbZIf?=
 =?us-ascii?Q?RNIBRdbcQJyIICxbR8TDqmHxMFkiVceEMsLVcjLU3CXUcNU0YE4RSU1wcRT0?=
 =?us-ascii?Q?DUQKQk6M496XdBDXCxIE4LGQx0CUIcG28/0NM9186bvsgJf3H0gTzpbQpwyS?=
 =?us-ascii?Q?4evkE1RxUZs4juqcrB7HMOllDentP6+s6LHlbijmaLVRk3YHhU/uupHNpr3t?=
 =?us-ascii?Q?pvCStu2sUT199BRnJLyNcCDZk+nk91ngboNOJUbbHvglEtjC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92abe962-4067-49c0-a010-08de9403a258
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:46.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbwzCNyHcXGDpMeioNefTvXimfor2ucnqoRQBr/udwGpQuDxl6TNPTd+OFL/AXPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10032-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BD443A5CF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Mellanox drivers have a pattern where they compute the response
length they think they need based on what the user asked for, then
blindly write that ignoring the provided size limit on the response
structure.

Drop this and just use ib_respond_udata() which caps the response
struct to the user's memory, which is fine for what mlx5 is doing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx4/main.c |  2 +-
 drivers/infiniband/hw/mlx4/qp.c   |  2 +-
 drivers/infiniband/hw/mlx5/ah.c   |  2 +-
 drivers/infiniband/hw/mlx5/main.c |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c   |  2 +-
 drivers/infiniband/hw/mlx5/qp.c   | 10 +++++-----
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index ce77e893065c92..4b187ec9e01738 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -626,7 +626,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	}
 
 	if (uhw->outlen) {
-		err = ib_copy_to_udata(uhw, &resp, resp.response_length);
+		err = ib_respond_udata(uhw, resp);
 		if (err)
 			goto out;
 	}
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index aca8a985ce33cd..8dc4196218bf05 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4331,7 +4331,7 @@ int mlx4_ib_create_rwq_ind_table(struct ib_rwq_ind_table *rwq_ind_table,
 	if (udata->outlen) {
 		resp.response_length = offsetof(typeof(resp), response_length) +
 					sizeof(resp.response_length);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 	}
 
 	return err;
diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 531a57f9ee7e8b..a3aa700d08355d 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -121,7 +121,7 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		resp.response_length = min_resp_len;
 
 		memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			return err;
 	}
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 57d3b80e7550b6..84dddaded6fdef 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1355,7 +1355,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	}
 
 	if (uhw_outlen) {
-		err = ib_copy_to_udata(uhw, &resp, resp.response_length);
+		err = ib_respond_udata(uhw, resp);
 
 		if (err)
 			return err;
@@ -2280,7 +2280,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		goto out_mdev;
 
 	resp.response_length = min(udata->outlen, sizeof(resp));
-	err = ib_copy_to_udata(udata, &resp, resp.response_length);
+	err = ib_respond_udata(udata, resp);
 	if (err)
 		goto out_mdev;
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3ef467ac9e3d15..8eb922bd3b663d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1811,7 +1811,7 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	resp.response_length =
 		min(offsetofend(typeof(resp), response_length), udata->outlen);
 	if (resp.response_length) {
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto free_mkey;
 	}
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 81d98b5010f1ca..4a7363327d2a8e 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3327,7 +3327,7 @@ int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		 * including MLX5_IB_QPT_DCT, which doesn't need it.
 		 * In that case, resp will be filled with zeros.
 		 */
-		err = ib_copy_to_udata(udata, &params.resp, params.outlen);
+		err = ib_respond_udata(udata, params.resp);
 	if (err)
 		goto destroy_qp;
 
@@ -4626,7 +4626,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		resp.dctn = qp->dct.mdct.mqp.qpn;
 		if (MLX5_CAP_GEN(dev->mdev, ece_support))
 			resp.ece_options = MLX5_GET(create_dct_out, out, ece);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err) {
 			mlx5_core_destroy_dct(dev, &qp->dct.mdct);
 			return err;
@@ -4785,7 +4785,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (!err && resp.response_length &&
 	    udata->outlen >= resp.response_length)
 		/* Return -EFAULT to the user and expect him to destroy QP. */
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 
 out:
 	mutex_unlock(&qp->mutex);
@@ -5485,7 +5485,7 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	if (udata->outlen) {
 		resp.response_length = offsetofend(
 			struct mlx5_ib_create_wq_resp, response_length);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto err_copy;
 	}
@@ -5576,7 +5576,7 @@ int mlx5_ib_create_rwq_ind_table(struct ib_rwq_ind_table *ib_rwq_ind_table,
 		resp.response_length =
 			offsetofend(struct mlx5_ib_create_rwq_ind_tbl_resp,
 				    response_length);
-		err = ib_copy_to_udata(udata, &resp, resp.response_length);
+		err = ib_respond_udata(udata, resp);
 		if (err)
 			goto err_copy;
 	}
-- 
2.43.0


