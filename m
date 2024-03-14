Return-Path: <linux-hyperv+bounces-1761-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15687C3E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 21:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CCE6B230BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93D76020;
	Thu, 14 Mar 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h32EPGqp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59671750;
	Thu, 14 Mar 2024 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446490; cv=fail; b=FtSzG+VerXiV4g5fJwFiZ3DnYh3kaJ7/eJNkNU3FksMlLOnlvgEpER95Iv92HeLZRe4eMhnJFeDkKempQuPVUB6BJPDg0/So4U/E+JThjqrAGEZBKrVscynuY5qGa5uezRxUvpgAXHXFTJCyILxYBBMY3wY2Qh79gwKrhBgctvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446490; c=relaxed/simple;
	bh=1SpLRVCfEjISTYCPKjGxiTx9t3J1NNuTBs0qNEaFQPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b8AX6TawUGJRFOti/F8dXnnPK85cF0OK4Y0OBT7xKx7OVZswxQIbRBrTC0UJW34tyxkXW78YF+82u7+smQ1pqBm+cS73fsLnRxHyzraBh5ObkQq4qVEA5OYLuyL0LwIw9+rdsWZOVyOzu5ybC2sf8ff9i7c77adMQ4BhsS9PQv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=h32EPGqp; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSL5ZF2cT1h4SCSnBs8ByizX8s937XH1Zzu4erVsS6sZ3R/3mN9FJWNkZN6ytsVEd7FG+avJ8Oqsi6/dCv5pzWbtOoBT2xdLdGi8wgSk6TznD7n0viAKWp8ju9oHErfwesl3RzvwZNdWWELKD6Zdzm+4GgPW4ahUcxeIyuqid0Mbwi5hdE5/Ixw3atXj1CflMq6811DmTHtoXBdZkykolrWtEjo+03hgrv8v9VYAE3QdExBft6csValkFvO/Rnti8x1g3T6R/4UudKlV7edIMKZ3SCx0qBz/1uZdyFRrQrMWtFaSwqaWpPTYymvGfGygF2cZ+kxFQ5dXrOUXzNQGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SpLRVCfEjISTYCPKjGxiTx9t3J1NNuTBs0qNEaFQPk=;
 b=FJXJ+CVQrwtJc8kQ67syxjc2N/icNjxjazfaJHaqjKGq8nz4EV2+mBAYSEyVe0cdTKJw0vMaeMWnLZ18T7arF2P3ZT758hCc4urnw4QYvwwbxrdGriKA2nj+1tx1fztAiY7k8CvW0Hl9+/SqSIMQ9TCT5NMEaqeFTNHw+g5s1EOcQeUtdSkEdPdlLbi7WzwKvRT7jWi10pyv5hxGz6JvG8606acVVpKbJOnyVB2iP7TPpLh1p+9TZvvoieaSFS/OPbxzE4iJ9nOpKJTLzaaxBvBkWLfQc3RuUZpM21/ETaSkQHHyCKU6h1AfVtGFScRRyAtbo1OQ1+ICCbM6zc8qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SpLRVCfEjISTYCPKjGxiTx9t3J1NNuTBs0qNEaFQPk=;
 b=h32EPGqplJ6TKoYmR8Ol+xZhXaQzRTta+l3W5fqgYmA0H3BhziHKJvoC0J7jhYbgfJwkXmVwdTPHUWdlW34PVMNR8PspoozGK47vhQj95d6nJZQSeFaYCDlEy7KyDo6zOo/g1hmSu8fjBvAlGHPlvtGq53A/0UmPLCsVRXTcb0E=
Received: from SA3PR21MB3963.namprd21.prod.outlook.com (2603:10b6:806:300::10)
 by IA1PR21MB3593.namprd21.prod.outlook.com (2603:10b6:208:3e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.7; Thu, 14 Mar
 2024 20:01:25 +0000
Received: from SA3PR21MB3963.namprd21.prod.outlook.com
 ([fe80::2cef:e7c8:da89:6c9e]) by SA3PR21MB3963.namprd21.prod.outlook.com
 ([fe80::2cef:e7c8:da89:6c9e%5]) with mapi id 15.20.7409.007; Thu, 14 Mar 2024
 20:01:25 +0000
From: Alireza Dabagh <alid@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>
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
	<longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] net :mana : Add per-cpu stats for MANA
 device
Thread-Topic: [EXTERNAL] Re: [PATCH] net :mana : Add per-cpu stats for MANA
 device
Thread-Index:
 AQHacJ8N8LLwvYYKc0y/h+tCzJvDjrEsZziAgAADR7CAABaHgIABr8IAgAAJ9wCAA7q6AIAEn/IAgAED5wCAAAUH8IAABZAAgAANXkA=
Date: Thu, 14 Mar 2024 20:01:24 +0000
Message-ID:
 <SA3PR21MB39636B2DBFA00CFE3AD84845C1292@SA3PR21MB3963.namprd21.prod.outlook.com>
References:
 <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240314112734.5f1c9f7e@kernel.org>
	<DM6PR21MB14819A8CDB1431EBF88216ABCA292@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240314120528.1ac154d1@kernel.org>
In-Reply-To: <20240314120528.1ac154d1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85f577f3-c12b-42ae-92b7-529ec268a746;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-14T19:53:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3963:EE_|IA1PR21MB3593:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Kmw9wnsuHCel86xV2+EomYy1iPAwO1tDgVSvgg6Xy/SVL1jPOSmyshjDcuN05bhyQ/2kXc5PdjtgXP0eBcWM1o9rJgXEkMJZwOSqobPrEI3Ck2Nitu6u3Oox2sonimNrRQ4E4qUMRodKVlOhmadES4MTHFMn7L1NxrqXFGZWHsOjIjMBPGpi0+VLHcQZX0xEz8Bwe8g4+fXP54azcUOwnLohMuobkcAPMjaEskqGdNOTRaTcQvVIrL9JG+K4wOnyhIcY+8IfBi/9t1nIENEPlnrRDT4cM4vTzTFgwLarpGM+CH0tnBbJg6QuK7X5LKATt6OgEoDLEZh/J9I4iG8C8GVmb1o3jwSvSUReQAMpeHceVjV8jCjctgDQ3YqUSpEPRmjT/ShQ/WJ7LVPdF/Qij9ENUxqfSiuOiYseibOcyOShWxHOQ1vp24bPKe7aFK97eKNPGMC1Zj1rH/7+zqpdqWk0iJw3pxUHqkHATyC4p+6GfihblSgb4v5ZBiQW47GXZBe4FyMMpcQGyGfFNgTA2lYQHvK0k9RKVSgl7X/Lbt22qsiDOy/mdjYmBpGMsj7/nQZRQTVcB6Df72vUSCIpm4X2ZxRsEBxma53Atm7E0xGsq4PP2esb5uo38apjratBUw2caJmkBJg4/OR+vBmPqbyV28p/b4/Cqz09uw+OP9M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3963.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NwsOSez8b2ahOX6Xl8uUZ5NSHzMt05LGeUHFA+N1zcCmjOIdrnXC456Av2m1?=
 =?us-ascii?Q?QSWQv+JwwBjlaPVcHyTFOwuWj/L9QohJ7FblQVr01qf6NZL4F9Mnn+Y3NYpX?=
 =?us-ascii?Q?AYnaZm7FYSPs4FztxBU/bQGw+GoGGeTmMPw0balIfFgzfulUXztyXqDOXbaY?=
 =?us-ascii?Q?GjlYdxMDNqr58C838c+0iNLhC6XDEONMDweXWSQ3hky7qEdsR9lgK/OZnFlR?=
 =?us-ascii?Q?2iaZB/UxnmbYfNHiPfiReGVIGu3oqu31UrhWKE71fAQWKtRgAb6vcOhxLxDS?=
 =?us-ascii?Q?ghstrWkA/JVvQSAhWaaB0Kir1hO/NFQy5xGGe5fVfGBSYyKcn1nmWVmYupfD?=
 =?us-ascii?Q?/9XQYafYkqT3R8tDqfef4Gqnemt/JBeUw1bmY8jYjkBMeZ7+wI4kZlVvxGcU?=
 =?us-ascii?Q?aOYH8MG8JsMvcn2l8pWRYdwGMzhYvoaJuR+ZE+BBVhpjZecE/XFVW1qdwKSP?=
 =?us-ascii?Q?ye4nVEd2qpvn52nATCyse/ZFrXGF+lOQdu43FGAiI6+9Sj38pxjN73hxJok+?=
 =?us-ascii?Q?ykfYIMR5vwFdrcRg53tU9r7h8qWGN7dMKXsGfIf6YK537Nld7Z9L9lq8TYfM?=
 =?us-ascii?Q?nPYr9i/rKXEH9nkjQ1G9EpEreN2mRRHNgQpST0zIhIUGRlH/ugmOIm6QP8Ou?=
 =?us-ascii?Q?rYtyKK+xQqZJeRmcHK5bxPTSxgo3nWVNo5JzwXetU6gz8Lvk3rfCEoRQD0IS?=
 =?us-ascii?Q?Rh+WgI9Xk9PJ4WC+x6GToZgHQ0HnykC7dAmxj4ueiTpn5kMLB7rsYBP2mI7L?=
 =?us-ascii?Q?XGFevbwYZ8VuFiGgkh0BhAMIxFqhiMq5oAwntXCqy7QPOFSchmJq8kAKtDZA?=
 =?us-ascii?Q?0ss3jLepZTAoDkZOBkyIZsf4RzLFQ8mlLzGMEZBffqaMOUPF6QsDasakZTZo?=
 =?us-ascii?Q?2zR/OdM7mQCOR3OdI/jpzIpv0tPJ5wPx1VkbIs5nKK9319oTayS3lo9uLyz5?=
 =?us-ascii?Q?9q2bFTe7Gs3pLTr8D0KtA23QzD3IViI8GHq9ttWOJYMOPq8oVk2bWGB/4A9E?=
 =?us-ascii?Q?LnvHRYh3Tj8zonOrbdy30ONTm29334B7ogkCpdW1P0rXOGR5PnXeeA1sCla7?=
 =?us-ascii?Q?3CRMYXUNwjbmSFg1nI9MDQPlVEBN32/izVh5Ds/Cu7V/psi+JWTOtBKKQK2c?=
 =?us-ascii?Q?caYnQtbtYeshg9CK8se/q0a/wnKDzYLypmQ8aeuMRbQg81Juq9F09UKKjRWI?=
 =?us-ascii?Q?jbGYwbSBV7ZIumyYEJZgohUwz5FPgroCKrmim2DhcTbPwoVTpO6ch6/rwqhb?=
 =?us-ascii?Q?+Is2liz7shf+XwR6kVZtRSa1nqx7tcSsBhR/Fzq4WbsbG5Fr7KD/6LiDBnKO?=
 =?us-ascii?Q?LTEKN/KJslbxC+M/jXGOcNU0e5QrLAnG15LwptxYLGoKbPUAlQidhZNmaSw6?=
 =?us-ascii?Q?lz6BLCJgSoAc0LD3UqDTJgqheu4clDDIXaUI6e+lbAegkPL39I+/Quq9pl3w?=
 =?us-ascii?Q?k5tpc1OsPNLWg0XpYbIqiFdcgyKIs9FQi84J+b9UAOj1o1urrgF1G+8VNm4x?=
 =?us-ascii?Q?35iOYjEAgjT8/lPsn4xQY5TinwtcusCAdymMN/B/1UG8+4MbVLp2ybJIS8f+?=
 =?us-ascii?Q?uHrn+wNDeiL2jy3IQ4nXntMScyU/mL79Mmf+iJtzBBUUzNhzQvC0d7RC3kaa?=
 =?us-ascii?Q?7VT01pqT2UB8n4md5VDI8XqZLWecSDQAsjbDI2fSQdm+?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3963.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dde612c-1039-40d2-fe63-08dc4461871d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 20:01:24.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2y36mKU3QZK50egR5CpNHsr/W6LCQoXrkaSGU0DjzFhyfRhv8h1xlXssajc1gTfDKircBZ1A2G/Vjk50xE+hiRHteP0oxyKl4hBlu4Ssbwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3593

Per processor network stats have been supported on netvsc and Mellanox NICs=
 for years. They are also supported on Windows.

I routinely use these stats to rule in/out the issues with RSS imbalance du=
e to either NIC not handling RSS correctly, incorrect MSI-X affinity, or no=
t having enough entropy in flows.=20

And yes, I perfectly understand that there are cases that packets received =
on processor x are processed (in tcp/ip stack) on processor y. But in many =
cases, there is a correlation between individual processor utilization and =
the processor where these packets are received on by the NIC.

-thanks, ali
(some suggested that I do mention on this thread that I am one of the origi=
nal inventors of RSS. So there you have it. Personally I don't think that t=
elling people "I invented the damn thing and I know what I am talking about=
" is the right way to handle this.)=20
-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Thursday, March 14, 2024 12:05 PM
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Shradha Gupta <shradh=
agupta@microsoft.com>; linux-kernel@vger.kernel.org; linux-hyperv@vger.kern=
el.org; linux-rdma@vger.kernel.org; netdev@vger.kernel.org; Eric Dumazet <e=
dumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Ajay Sharma <sharmaaj=
ay@microsoft.com>; Leon Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx=
@linutronix.de>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srin=
ivasan <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui <decui=
@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley <mikelley@m=
icrosoft.com>; Alireza Dabagh <alid@microsoft.com>; Paul Rosswurm <paulros@=
microsoft.com>
Subject: [EXTERNAL] Re: [PATCH] net :mana : Add per-cpu stats for MANA devi=
ce

On Thu, 14 Mar 2024 18:54:31 +0000 Haiyang Zhang wrote:
> We understand irqbalance may be a "bad idea", and recommended some=20
> customers to disable it when having problems with it... But it's still=20
> enabled by default, and we cannot let all distro vendors and custom=20
> image makers to disable the irqbalance. So, our host- networking team=20
> is eager to have per-CPU stats for analyzing CPU usage related to=20
> irqbalance or other issues.

You need a use case to get the stats upstream.
"CPU usage related to irqbalance or other issues" is both too vague, and ir=
qbalance is a user space problem.

