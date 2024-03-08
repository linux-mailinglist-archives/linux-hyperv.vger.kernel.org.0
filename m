Return-Path: <linux-hyperv+bounces-1693-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB7876B6E
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AA51C214EC
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 19:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8608F5B03B;
	Fri,  8 Mar 2024 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3+Ws3i/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C27FF;
	Fri,  8 Mar 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927709; cv=fail; b=Prr1cAF40JPJhILjUe39vaC+dKYc5FEWTmYg5cnx3G4g3qCj0CcLN8RuUQ3NW+I3eh9pa+yqOGZc9J+Y+VtVpTMqOKMFgxOtw2KwtzQh5c+Bpupb4UOPGVjimd0VvquSLVLMarGoDX/bqWXLfQUr8VHHhidfbZiKqSV/yp/q2T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927709; c=relaxed/simple;
	bh=IAW/F4+ksBlf+kSMb8uanXSufXyq0IQ+a7qMPEVXbaY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=MtMOYHK5dMj71++NTTaog1dwwY8ex2Yg+WQLMhPEBuLSwgVeA5g3b5cwDrhkxYN2SKj3e1W28KeZXGXaQZZpJdASYC6dStomeAM3yHbIN9hqCqn89qWtLxFmf1ZjBZjTwM/b+KHW+wUh3i5MV9PrC0HUy65ZiWVVKjxaKCpSM84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3+Ws3i/; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRD3j86aQj8188ArWz5ShlFZS1c6/tZqNPIxZL2040IlrLS+QRkhuweqYuhsWmm8FsqLNFgSGGeCq77vKHf+Jj5qactq9Xm2TYx8nR+dIBKIAqMtNk/oaYN03gG4KN4bLGGf4FH+Sp66ito0Dv8ww7pGjYYYO1d2ZTR3RxTUUVxsrTZc93yy94QuibTvD4N+yW/SKcEVKaHpZptukTP2653DY68hd0ocGgl558rPYu2I71fqHU6U/0XexnRwfxw2orfQBkgdA5NM5lSOgzouKh89d51sD7sQzEBygHAfAxRHON5+bWKOlKKV7E0sonuHUnp8PE/6PPV337CY+IGRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQhKF1eYw/OKjJb5dVKND974TxYXMdDGfSrregLDhFc=;
 b=TIJ2p6Z2Tnc5fXXAmsdHI/2CDDAMuKxew9Dz1SDEtXcuiAf/VUcXs/QRuYq+Lh8twzWFbgvU2Mdj5Mofg20TkBFPmk9wmFh6VpH8e5wygujKhz2jqlPHnd/lKEJa/c1BnMKdD9Q4oKqsBGQmZK2xplLfdyZdmNgGuKas2Rd5pIZYlspPsij9jRn57hr4HQ2l1kfAOoZ6h1MK07pMLHP6uHT+RSzX/DV0bVoCqpYOp5A/58pg0SrpwxKxCfLxc4mKAKsKRosiWy33Hu9BH8S+1RvNxXHkfAJOmMbPwg/QyZE8N5mtI1pbZLy8iKsUWW0WgKzfGA+y7pZ5Tc4pgB2/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQhKF1eYw/OKjJb5dVKND974TxYXMdDGfSrregLDhFc=;
 b=P3+Ws3i/ppqTe1MVpiYAsB082nke7/SZ/K7ZuYnb1lgaSWDq3dJN7r6xGMf9ABFbGDbjiLFDey/5HaxsPAyFrXxQxF9CFj0+J3j/qLY8+iPjS+FxEjnhlbVtkZ/QILljKG2/XBvwHoMl9KnX15TuPD3WQSFnhuDK3k3d7AT3Ub8z+cCNI0LDYK7xnC9QOUXUbq0Sb45SKeFn7D4/tg6qNvi4E2QxhWeqBdBOh10MlfO/k2ULqCHmE5rlYJS10+/xjmpN4JZ25Vz1OlwZRriGHi0JEWlPRTfedvUs5rVSWoZoDBfPRlqRSMEi7FOGLd7PN+9GVYAyrUmUhtciwl/9iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 19:55:04 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:55:04 +0000
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240307072923.6cc8a2ba@kernel.org>
 <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240307090145.2fc7aa2e@kernel.org>
 <CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
 <20240308112244.391b3779@kernel.org>
 <CH2PR21MB1480D4AE8D329B5F00B184A7CA272@CH2PR21MB1480.namprd21.prod.outlook.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>, Leon
 Romanovsky <leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej  Siewior <bigeasy@linutronix.de>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Paul Rosswurm
 <paulros@microsoft.com>, Alireza Dabagh <alid@microsoft.com>, Sharath
 George John <sgeorgejohn@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Date: Fri, 08 Mar 2024 11:52:42 -0800
In-reply-to: <CH2PR21MB1480D4AE8D329B5F00B184A7CA272@CH2PR21MB1480.namprd21.prod.outlook.com>
Message-ID: <87bk7oebxk.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: b47b1b9d-1acd-41f9-ea71-08dc3fa9a57a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4/TUrpBXuZBQ/mk3LfaoavvF2LtKVec202u4BiB3LWss6mgHPCMqMWNHEm2pmElF/Xqj7tCOBoPUl1XIpCECN2zCg2cMrCsik0+r7K7c1bM0QgTOM7Ps65h0sjKQ7jIIT9lg4uWALE08x+zs8DQMCoY0a0vgpafXMi6luSSCTIfFqx8IaNr/bnwTQi5u4JyKvfrXAk0JtZsRvyryWwRagbA1nM3HPNmvMu3xHtDEvoekunf/5aG8HlUJJ/0kxZzYd3e6eebSkWm4ylMHs0MgzQDEhR+KJqZLr1GyJX3U/fTCwKko0STfFFrv+wT0zimOxrIXLKc1gn3M+tFRQQg5hDEfJsEDhTce4FDl/MSFPcgCxOl/w/yTZzkPmK1BwZTGfK3fUg8m1/nBjYzUHvfLnl1+RrejycfJd6psWJsp84ND7hYnun6HvX41JCD41sOWJqar83Ps2CE4BietmlN6LlOJm51jDomN6t+HqJyCpGt8W3KdfwNXc/nMXMI+O1ywK6ZvvQoAaDgQ0KXvQejcOC0b/XiqCbU7EPIXnKTCX2vBEIP98y2aUNRux9sk1ehkG05l3DUHX1wwMFaF/Q0a+x8q7wFC/RUjrQMeNT/141KzVcOZqQRpz/Tc0mwpTTlYdCIa9DEFaZ7UPXsGoOYFZ4trijc+jvUgr7E2JoTWSjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lR3sw8s2Whs4DCEkdzYThy1XpEcT9gKufKAePC7KdNpGyXaOU7WlNzITNDl8?=
 =?us-ascii?Q?VuDsiwwBF+k0mV4iUhJkyeTG/YnWF6kFaVY9yEmFFkkrb4rTS6ItG3hdEakU?=
 =?us-ascii?Q?BdV2f24LflyLAYp+lZ8rZXwdn5ZE9wdLm7X4yyNYC93deyQ7++Yf77pNQ4nL?=
 =?us-ascii?Q?9MQ13giEw7FR2BeZxUHsajiihOhJak0u0ToHUJHepjt+LTu4bjJJSEINJ8gt?=
 =?us-ascii?Q?kk+AqHXO8YWKrP7v9YcmnoD0R4Km3UPnmdzUm8SNbbxdG40kp+IqAvkZ95rR?=
 =?us-ascii?Q?nTXlAIkfHQP+RkMogyi4TansEqdL1LVHspFdIjo4X3JHYwneZkE2biNntWDW?=
 =?us-ascii?Q?+SrZU0nqm5VDNAp8h2n/QBOgQa4LScmW5ZCCFTTygM/0MBeOPoGPY/bOtSP7?=
 =?us-ascii?Q?g8zoSZg/VLIaJx0YrGeUBfGbnK5gqf2spwxaajbSGWWF882JxAzWrcT2kbEa?=
 =?us-ascii?Q?j3oIjB2MZ7hp/iye6bWysmgtJPm8XM5+OAw6QJx67EZbPDCJ2Nu3VuYMNxmf?=
 =?us-ascii?Q?kLUS/8klAf+RkYw8yt/eLUDPFAI4fR5/hdcvFMbtFKicHJ4tNwSBiPI76ILo?=
 =?us-ascii?Q?8sdJ5YOHHt2dOJQDkKhkzJTfx45iwRzoDPCxy/uSr9bVwcPYlAyzB48/sqQt?=
 =?us-ascii?Q?5L4DHpiSv8aUvIfpNXrxcV8E7bC8FACwLm4pbB5D6LjmkzOdF5jXfSfgaGbs?=
 =?us-ascii?Q?UXjek5q/R3j3C/ocTFLJikHjof0bJ3iZYbYUKHONGGEJ6qaX8BMMLQ1nlzGr?=
 =?us-ascii?Q?qeaHIoI9ymY0wIEszgu98cq0O5dd/twedd+RLOf0h4Epl9LMSmfox7syjvdu?=
 =?us-ascii?Q?TveegeOIdo4IALDQFrgc3moRgJprZVwqFpZjJXBgBADoYrDf9ctQBPaO5bSE?=
 =?us-ascii?Q?yqui+/QJENM+rjFqJ629tkFPqKaX+3XOgOmodTs52BsEiVH7M+hvecqj9aV7?=
 =?us-ascii?Q?D2LuxC1OHsbdaXF3zS+SqT9U8oe85YOXWKx5msD/KvByChAbS5QrRdePanOn?=
 =?us-ascii?Q?tbIK9oMiXXikg7WMFF1Ly+r6jXTCkLkSAtnaO/IrioULSt43+BsKs5qClWQt?=
 =?us-ascii?Q?A9aV/PekmPtn5nudqWC8jEofwIQ1lfTuhJEoo+B8NdFfxTl1K9VoLd3jJHb+?=
 =?us-ascii?Q?z1F7iPFLmFOfY57mhzQOvMVzwk5hhhBco+fFns+/XXt1f1L75yrtwIjCHABH?=
 =?us-ascii?Q?PVadLOjqAhl5N2aqgPuZRDPBFPqWgFfQ2CUUqhYg+p2ZNLEarvVdkiPkIbF4?=
 =?us-ascii?Q?i8l+pCHs4MlsYvXPZ5nicaV3WaIeUKTHQPUXMJfR9uYGfLVKN24doVT/tUDm?=
 =?us-ascii?Q?GwUeJ3ufnw8nqG7STw1bfyh0zwys26HpoSsFfsx8NgwOXm/cBhykm1AX0vIj?=
 =?us-ascii?Q?+slJZO6GuaF2fIjnbZchGRGqSeZeC6yqAx77ME4QCJ0bz7tYLsou9nzRMYl7?=
 =?us-ascii?Q?midHsnwwOeo/nD82lGUuZGuQHCTP3PEpls3cxCb1RDl6n4vcCz0k/RERDG+H?=
 =?us-ascii?Q?XNp1LTSncr2gUINwDKNhmjzsqmnRz+PEJ+piybyhUdXSB/xAVaEejD9whm9t?=
 =?us-ascii?Q?G2SzKzq6/PxiqLSHyKViBnWFwaP1xRWPl8MxLRHA+iE0rPWaGY65D86bvT2g?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47b1b9d-1acd-41f9-ea71-08dc3fa9a57a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:55:03.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7IrEigsTSzqZjpm2Cp5kRImpPLPlnd6r4LACK3tnvm5o3rLvTEKoaR/o4QBPxxxvezYVCtIL2jfc/IQi5WOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407


On Fri, 08 Mar, 2024 19:43:57 +0000 Haiyang Zhang <haiyangz@microsoft.com> wrote:
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Friday, March 8, 2024 2:23 PM
>> To: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Shradha Gupta
>> <shradhagupta@microsoft.com>; linux-kernel@vger.kernel.org; linux-
>> hyperv@vger.kernel.org; linux-rdma@vger.kernel.org;
>> netdev@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Paolo Abeni
>> <pabeni@redhat.com>; Ajay Sharma <sharmaajay@microsoft.com>; Leon
>> Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx@linutronix.de>;
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srinivasan
>> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
>> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
>> <mikelley@microsoft.com>
>> Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
>> 
>> On Fri, 8 Mar 2024 18:51:58 +0000 Haiyang Zhang wrote:
>> > > Dynamic is a bit of an exaggeration, right? On a well-configured
>> system
>> > > each CPU should use a single queue assigned thru XPS. And for manual
>> > > debug bpftrace should serve the purpose quite well.
>> >
>> > Some programs, like irqbalancer can dynamically change the CPU
>> affinity,
>> > so we want to add the per-CPU counters for better understanding of the
>> CPU
>> > usage.
>> 
>> Do you have experimental data showing this making a difference
>> in production?
> Shradha, could you please add some data before / after enabling irqbalancer 
> which changes cpu affinity?
>
>> 
>> Seems unlikely, but if it does work we should enable it for all
>> devices, no driver by driver.
> There are some existing drivers, like mlx, rmnet, netvsc, etc. using percpu 
> counters. Are you suggesting we add a common API for all drivers?

Wanted to chime in with regards to mlx. You might be conflating per-cpu
with per-queue. When we run ethtool -S, we present counters per netdev
queue rather than per-cpu. The number of queues we instantiate is
related to CPUs but it not always 1-1.

Jakub just recently supported a proper interface for per-queue stats
counters that we are interested in supporting.

  https://lore.kernel.org/netdev/20240222223629.158254-1-kuba@kernel.org/

--
Thanks,

Rahul Rameshbabu

