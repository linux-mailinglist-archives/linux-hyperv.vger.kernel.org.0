Return-Path: <linux-hyperv+bounces-1689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516D876AEB
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 19:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B1F282ECE
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 18:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78EA28E22;
	Fri,  8 Mar 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cDFpGCdz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11023014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B0125DC;
	Fri,  8 Mar 2024 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923924; cv=fail; b=ExO2fO+fhdAFANGEob9p6LMfjYyozzPxR+zP/XOpDsV9uPHHTUyH4SUdVS5mgabpoGCWcT63SA4t5JutLVzp8YkBeEEsVMgJyPfW4FSTEHm3sI6PxosnQOZfqLrCLZAPI8411rnY95bSEsyzhZNf+9SvPAqMPgAZtGuJeLCaB4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923924; c=relaxed/simple;
	bh=U52M96RnkF2PcfijJnTK5nnOr/o+ylc0qNlNVqu0Euo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=acAMsT53xslZi3tYgAm9MwDwHCLa3Be1F25rZ75V+PZop3RSe07jyshabSwnTfKdQ+v0+Ewt6/lNgmkqBU8kOghggAhRJDPq1nHdOo9mf4kmegR1MGUyLE+XR6ZTOTfZbPS3LnNp64s/TONChJCQJ/qLi3w0zS7Zm+hiBh5Rpjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cDFpGCdz; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbAcQJFU81VOheA/ybNLT4FqSZM+OODvuS2OaiDjrYTvM6GQ6H8qei6HkUugh06+CwNsiG1X56Vu7r8Cy2JgIwYW8gQJN/zpa7WN5LdHuMP09mcPRutsBZb7hhUbrb/EKUAL/j5Q/6QvzqveoWeXs3PNsbKsrIWA/2KM4K6+kbvE6HqRbiPTVdA1n7RMs5Pd2mq5xNYrnCXpwCK1QDlr0argjmWfaUXq2g2TLjNg7tv+ehtWfEZCvf7aX74L76zywI5bbXls0wFZP3+nboFcdOR+yl9oCDS9G/jyYTdElCvG2Iakr47kUzzzApCyvrd/BXqpSp0EW42arfGCcn8QUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U52M96RnkF2PcfijJnTK5nnOr/o+ylc0qNlNVqu0Euo=;
 b=eowuO7WeTDGefJGQOkDFuptAmOaeBQdZhTPYRUDalG49uQTBFbgjjgAZIkRZx6nEqi+3RxtVDtLZwVpjp6iL1UaYsHVe4T43tYQGilFCqjD4zJ8LCvYY+UjmC8Kzv9v7Je845pL9LBzLlxkX5ZFuifkevbgPOawdvJHXzBIe0+oKA7T5hjfs7S4VZ6wSL8E4y0WLWUWItlTERB+6BgmDHAdWXEZvYYMy2TYoKvWRPUz/L+XxPCLR0KG/ZTrlKeJ9czrkQoo6si4pQDnoO3yHOpIb4RNvaW12yVIHKPhDXQMCruk3Vlb4PdO03/AwKAYuN+uimEN75IHoPh+EjBEZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U52M96RnkF2PcfijJnTK5nnOr/o+ylc0qNlNVqu0Euo=;
 b=cDFpGCdzVbBPpn84VkX9PSLC/7aeHKL8/duI6OdZVouob/sWazNDJIPorO2lii23VAahV+Ct0r6dJvv8M4ic/4ya6m4ZH4lU/uAIWYDv4VM7EidnVZgUgM5R8j+o2dzU7GLZCSMQhxNHvNYHlTYhHzHF1M4mCv2Jlm8uQLNh7EU=
Received: from CH2PR21MB1480.namprd21.prod.outlook.com (2603:10b6:610:87::22)
 by MN0PR21MB3532.namprd21.prod.outlook.com (2603:10b6:208:3d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Fri, 8 Mar
 2024 18:51:58 +0000
Received: from CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401]) by CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401%4]) with mapi id 15.20.7386.011; Fri, 8 Mar 2024
 18:51:58 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Shradha Gupta <shradhagupta@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>, Leon Romanovsky
	<leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Topic: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Index: AQHacJ8N8LLwvYYKc0y/h+tCzJvDjrEsZziAgAADR7CAABaHgIABr8IA
Date: Fri, 8 Mar 2024 18:51:58 +0000
Message-ID:
 <CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
References:
 <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240307090145.2fc7aa2e@kernel.org>
In-Reply-To: <20240307090145.2fc7aa2e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=66baa000-a4f2-41ac-aba7-061aa502efdf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-08T18:47:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR21MB1480:EE_|MN0PR21MB3532:EE_
x-ms-office365-filtering-correlation-id: a97457e4-70f2-4827-2ec5-08dc3fa0d559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ar34XH/qcjhC2ytFSb29cg1t5Hjw2Ws0v4817X6GPCbSZ9tqq1F87LHTzNuLCnnysomL5a12WAr6P08E5VvggiU74aa+JSjaCcZ06wxYqt5z34dJWg9Ux46OEGERpg9SLWZeqtQvCkLvEMQ96U7Q3OmpoQvWxJ8HAJJ54bJP8jtwbIRgYuZ2x3F26+74S5RJqccAvI8BLdwXwFIOcE+9vi8qerdfGWZe4E+me9mb4lNVLqSMSodWBUWmKNY61dgVc+0Y4h251pk7rKZwjcL9bkth9hfCL7OpYkp0a3WZEFAJ5M99Vm2pie9apbxoOBmuepqcghFgmndDGBx/QWiQqccL+qLT7rOeZTfAkTmA8jp7JlpIpLqlI+LMKVvy5gjZP7UhZNZ+C39Jt8ISp2SzU+7Viek+k7ZtqrMX3YR5lLI1HWjhRW1HXeRU5Nw/lVIemfhyJTS47OTs3cRb6YJU5XBtnE7FBpyVVbTM4aSMT7LgAHbSg7vcHYjYZVpGyGfX4ojTEqwiFNZhgP2CZBBvuYUp3TfN4TeVD/48mDo6W6p/1pXEZ/QPGbeZwRxlqVFY2i9WyK1aUI76K3yd4qWjH5psnzlM0f6fC4ch2IY987y27jrPsAbPwYr8GkF/MeZEmOQ9rDAu3WEWMza4fu3QfBFNJhJD/kqqakOTtnhEIiTAHw2wjKWCbTGsE4GmRtBMhU+UjqIQLRlFYZX07i+W6AqAZYZsOflzR73rsTV1rzI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1480.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m7FEnFjdWais9FT5c3VfJ3DKgUdxJOgGWn749hUPeHV5ivLjsEy4XV1Xe4mZ?=
 =?us-ascii?Q?gahIHME7wuXQ19LMWxehcWqw8cUWRF8XiNvxzCFqQC8lzM/tyDS0HCC/ZnOD?=
 =?us-ascii?Q?kPg87IEV0FePOt4INGlci8WznM8J4kz1HG/tpatsdSzyckE6wGdnAzlelVJr?=
 =?us-ascii?Q?W0yqLHKrmNA7UhTNzqh4m22N96BHkvykzAB1WGCiMgnSJnNFiJ9T5Li+DAKA?=
 =?us-ascii?Q?hM5y8HqQAQg+12SEUvuC/Z7EpgOze5F92GOQaeKOEFN/QDwpF+sAHtRdBsRb?=
 =?us-ascii?Q?A9dYj6kmyJrKFN7olM6p9JVx858lmdkBlvsdyeq4CjBKKSteHkpVgRYW+pI+?=
 =?us-ascii?Q?JrcfqpT65icxpQsq82aEKmGXqobtykrF9sJYLsTEBH9KHUT88tTJo96/EuVK?=
 =?us-ascii?Q?+bgNSnMdRWR9GrYSe3bO5H4LA0g6msjOMaobkAPHlVIXKmNsqio6APpszWj2?=
 =?us-ascii?Q?/DMcoJg/6CkUw/icrLFcHytQNSFKfRBXp5ibJ51lKHwQ9ca1O8IWQKsCVqVZ?=
 =?us-ascii?Q?oqllqDhTgqU6/pNFbP388Acj7QbwfC6FuHiepqb4Qi8xCqXdzpCaM98BmPUy?=
 =?us-ascii?Q?PL1bC1Az0Txe/1SyLMSQCmyPSphKBrRsxfqsd6cIfZ+zN1qvWn+ZQyiwRJfo?=
 =?us-ascii?Q?VTWeV5mTnVdCuEUEwWSsX9EEBTDweCfWY2VVouQEnFdYyBOrRxozw2hosGjm?=
 =?us-ascii?Q?fTxgQmdB6TKlV46A7LYzRgP8f1ku9aNJsFdKE3DTfBXjdlIOK1gbWk6z6/J+?=
 =?us-ascii?Q?mNf1+gnNkEmUh5Q31zQvQbNxedHu40MA4hBp+wSQMyQgqlkL8F5Rm/9jbjfh?=
 =?us-ascii?Q?OHuhpIf5vWxIBRpsTrUomVonPw+r0dgkqLBzAnPi7aruG0rxdaRJ+cj3SUe8?=
 =?us-ascii?Q?ww8XfxbC7YB0wIYgywrD9NpUsaalgZ1m0+nG6kMpDbU61TDMxONZ3XNnxHZ3?=
 =?us-ascii?Q?N/B4Vm74NSuCopVuxHf0T34Ib8m4ubulYR9Ixu8ZJhPRH0AafjQ4WD1er+5L?=
 =?us-ascii?Q?3yFky7xsrdSWeyMj+ihHPFslCvu1uUnMkJYlNKHVdUS9Whh8nxzNI5H4p5vt?=
 =?us-ascii?Q?UAaCGaz55VLJCRLbZUcsqJX0RBvpxaalk0Dqb/TM1Za6AN40jFnCIpKjEHWG?=
 =?us-ascii?Q?PYOfas5laIkZcUt3pBrnzFjz1osKMIH+qrvX5swpl+21mW4qwmoH4njLBzC1?=
 =?us-ascii?Q?o08sTzTC3ju8JKpiyXsxNwbuFiqSSGbzaaZmfElo5HBE12gBqXYxCT33lEfe?=
 =?us-ascii?Q?Bdx+wOQwZ/A3WpIlwDIjZ3KX0UriQM2HInotXjk57odc9uPOTuaXuwfe9e9q?=
 =?us-ascii?Q?zcOOrOgNcA5Yt5oqpRlSdvD0EG+aeDJFv0ApNewJBOmfa72KVxNIf+l5wzpj?=
 =?us-ascii?Q?IOq7nsNQl/Rw8CPN+cjaxihVbF0wqOoDoj6fzX5+ybf0LfJiAGhr9L4Cv6ln?=
 =?us-ascii?Q?RI2VJ0j9wJHy6aTAtL7dk9kD2XMF8Kbe5YhGBi8IXlSQPBPg5nmK6xQym1lq?=
 =?us-ascii?Q?xb6hjVUbGNFbtrI/OIvTnQEAQqxaHU35l0YMBxpNlc99W3SYF2X2YaV9Fupa?=
 =?us-ascii?Q?LQnSfT6X61M6GQUuQtcqUVkMZ8/isHdDOs1iptaD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1480.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97457e4-70f2-4827-2ec5-08dc3fa0d559
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 18:51:58.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xe+cmbwTP1uRnFi6Ef5QKLQ4iY8sMPFtsuqpygnVxQjnCoWnwFeOj4+ZdOhOFvACi5FClWR+ZOjEe1kpYcCxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3532



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, March 7, 2024 12:02 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; linux-rdma@vger.kernel.org;
> netdev@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Paolo Abeni
> <pabeni@redhat.com>; Ajay Sharma <sharmaajay@microsoft.com>; Leon
> Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx@linutronix.de>;
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
>=20
> On Thu, 7 Mar 2024 15:49:15 +0000 Haiyang Zhang wrote:
> > > > Extend 'ethtool -S' output for mana devices to include per-CPU
> packet
> > > > stats
> > >
> > > But why? You already have per queue stats.
> > Yes. But the q to cpu binding is dynamic, we also want the per-CPU stat
> > to analyze the CPU usage by counting the packets and bytes on each CPU.
>=20
> Dynamic is a bit of an exaggeration, right? On a well-configured system
> each CPU should use a single queue assigned thru XPS. And for manual
> debug bpftrace should serve the purpose quite well.

Some programs, like irqbalancer can dynamically change the CPU affinity,=20
so we want to add the per-CPU counters for better understanding of the CPU=
=20
usage.

Thanks,
- Haiyang


