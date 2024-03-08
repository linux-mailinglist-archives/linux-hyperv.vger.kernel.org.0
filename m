Return-Path: <linux-hyperv+bounces-1692-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A3D876B50
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 20:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9447B1C21005
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 19:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B245A4C0;
	Fri,  8 Mar 2024 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lm2pYwiX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3026D3C32;
	Fri,  8 Mar 2024 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927042; cv=fail; b=WTBnoLFcDyHS5rfHOubnh66rUVSH9eb/B7zGLIXWDCTj7f4TtkwgeQIBo94dzdzy/cR6v4/Lb7IVsVKijkSwjMyaaAlPzeMzZ/gF2lkv4hX0sJ1RJhF8uiEsrrBrV3yjR1KBtGqJDTpG4c9vZ7BLyDBegc0p+BDDZGHk3judRBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927042; c=relaxed/simple;
	bh=gpG/VjDao7uSUTKsUa902Vp1EZRW87XjyEH137ac7Ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RkhwrJLn38ZO/dkLK9zBi6UnWXEIVdcq2qySkvvKE7fv5JlkuMCtY3YogR3Zzzq7JZ22JHSnYOLY9TG4L50LjItPaTukVMTrKr8sSLtuZYW7m1HfRah/evQ1Rpx1+jomzY8UqFFW1kDatkfAY2YoNVgrmk0L7yn5f8+RL+2UYX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Lm2pYwiX; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkcD9vCYxqx8jhPGiYk6Bk68UQKDu6fQ3cOji/hPk7m350z3TLKj9EVMrjsQ6QVvdJLTs6aW+HFHk/CfDlGX5MFaLQLVoEpoCy78wL+SBykUuC1X+cLKKRA0eyka4kXTYgwZ9RrpYEF+rQmtLNBx1eSEHcLm2EtTkJdgCxpueK7zi/rES5sAaSGSTO/Z7o/QgCA0GELKk35XFsOvNLdCfjEjl14gnXAbauaK4BJ2c3sICIpzK7SGGj3l61m5csOq1GC3m0Cu16QjMl+eSFfqAqZnDPMnEcR58ZYkKfwwgupfARO6L72Ntgu+bfba8nrbidevheK3Tjk8FKvtYXhtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpG/VjDao7uSUTKsUa902Vp1EZRW87XjyEH137ac7Ik=;
 b=YdeSOTutmD2VX8vCP2I7+2nDpyTThNAo51t7XgN3tAB5Pz6QN2LYBhat5/suxm3Q8MTLLqfgtv7yz3b70DIBHbE9KC0cleJXEd3jIH3f8fxYhavpjoUHYJ67ePtP9rLiUok6TzQ14k0pjfzhYMOKZoFRz1akmQTZZsa6z6gK6EnPJP7lvTQN6YCrvVHZIjToBX92NF8o6fgCAX3ulfrfunwgWQScDQ5Qwo1L4n4BO6y2/cZdxK/18ebJeqoJongUfMnbhzuH+BAl1GHDhN6+2VA+eK00SAOiwl4DelloilvVVXG8uLJYWvNC1HOmZNFWCvbJaHaiRFHUk3pX45HYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpG/VjDao7uSUTKsUa902Vp1EZRW87XjyEH137ac7Ik=;
 b=Lm2pYwiXl62CD57NZpyYLGcplF4aDk7gGZAo9ywoLUAXzxXpKJnjJ+9x/FvvBMZsVOhGB44Qvx9DciD5MBePd/2N04Hxq55m5aZFpCYa9RLeK94yNgZi4I6usrt018WJ6pHiYfGPby0lasuxZgJ/W2Pw91vA71D1nX9tlIFF+DQ=
Received: from CH2PR21MB1480.namprd21.prod.outlook.com (2603:10b6:610:87::22)
 by LV2PR21MB3111.namprd21.prod.outlook.com (2603:10b6:408:178::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Fri, 8 Mar
 2024 19:43:57 +0000
Received: from CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401]) by CH2PR21MB1480.namprd21.prod.outlook.com
 ([fe80::70d6:9c52:d97e:3401%4]) with mapi id 15.20.7386.011; Fri, 8 Mar 2024
 19:43:57 +0000
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
	<longli@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>, Alireza Dabagh
	<alid@microsoft.com>, Sharath George John <sgeorgejohn@microsoft.com>
Subject: RE: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Topic: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Index:
 AQHacJ8N8LLwvYYKc0y/h+tCzJvDjrEsZziAgAADR7CAABaHgIABr8IAgAAJ9wCAAAN1sA==
Date: Fri, 8 Mar 2024 19:43:57 +0000
Message-ID:
 <CH2PR21MB1480D4AE8D329B5F00B184A7CA272@CH2PR21MB1480.namprd21.prod.outlook.com>
References:
 <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
 <20240308112244.391b3779@kernel.org>
In-Reply-To: <20240308112244.391b3779@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fbd46779-2a2f-413c-ac8e-94aaf34f5357;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-08T19:35:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR21MB1480:EE_|LV2PR21MB3111:EE_
x-ms-office365-filtering-correlation-id: 2d70e9ed-71a3-4601-0279-08dc3fa81859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fAF2fUozuELXPuILr2kjWlBY4Ccjtv3wsu+dwRHeSOjRxA8NE6f9AgzbfnKwYICd7rKLvkMJ2g7sryR3Pc3sT0dxDZDTDm02iAv2JdtqcUD1Iqb1jx7l9KE4wn1rf2X7gK82vWEljP+rSKrU7n2kXD44Fs64uYd62YRBpSMA0trxwr2d7pFZuP2wWimCVMyq/HHfIKIUjF9/6M58Pis0UOVnxLa+yFhm5LKdu4ZD2d6GFwPJxlWYSBiJkmhT8Ou/mftgJojx7lcJiZcD8YlhkXO+llozdhWnxNg6nin49ESohCJYQglDcDnGgGXiz+TBLssxyZ4uiuGjf3k6T/TT/Ur0fLxsxtgb21ZCb6vJ44Vt7tXqS10/ziGINoYjLyj19kXBHefMef05Jo7xFkaiJDQbNSBFc+BPXSU7CmEaEIFPgndqa91gXx427mtfmfG14fCK31cQszRqUiOhhUFPxCpQ9KFEcfyE3RMg1xjbLgQuw7ADN5awAjefA9ynf9SZ4XjgBh4wxCetQVZpLfPMjQ4a1qtKwDV+Fpr+d51zx0aHsAvr78dcrwDqAvaMXw4WSLYPVGKtwtARtViECLXbwG36GyYgL4+XcLGs69Sm8L+2ensRf6CMn3Lt1giuuobcezlLelACWwQ2+ge/bbTui6J0aLDggrqPmLvTtoqxRMHIOecKRvNcPGehDsXO/eTiaa5+EmbIXABaDyr+RVUXbSyBZZwnWDTouT8Bm83/RLU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1480.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4b4HoiMMZ/YA3EI+jEOZkE6lfoSSeUEjBTbWfSJU9Reh3qsgFXYmhk/GT8EJ?=
 =?us-ascii?Q?1nDsQ/Lw4Dg32Wd4Q2aN0lWJmWN1YAqwoPJBHVCDyDLnEhuDpKk7b6jojzke?=
 =?us-ascii?Q?QvJVnp/YR5pIoW3kSstAavVZF5LioHu+e0qXkuNtCZV8R0xRT+Y35waCdBKy?=
 =?us-ascii?Q?QvuQX895CSWZB1fFXg+t/7lVEfWH22yU8wpR86MwpETtI6Sp5YDWg8MtEuWQ?=
 =?us-ascii?Q?AURvu/uwUbaZlVLFV5uwxucV7WswLPnXnb31DigQM7c8xLWzDLP3hhugbYhC?=
 =?us-ascii?Q?iRUgZtN9fc0CbU3a7OUcxzsevj54Bvz9XeRW9ctMhCGkrR9L9VCqomjt8f4k?=
 =?us-ascii?Q?0pdSvhbUWBQqvlHWeZ0pWGBnmr2zgMap2rYqe2ZfsjDqDOcn0E5kALP3lK4z?=
 =?us-ascii?Q?e+1H4lPgr1yq5zS5yiro5du7H1iDbeQWZzSjFwQJFb3ZSHrK2h3NgpsNR2aB?=
 =?us-ascii?Q?ZxnPfEi27CLeXywuE5vCcjKV4mBlS8XI+C9bSz7VhJBIq6UCLJ48k26NPZUu?=
 =?us-ascii?Q?RGDt8zVNN4iiFJfGjKbKj05rAZbZsgOjeBmz/CnqhBqKoIV26+MgRf5rntHE?=
 =?us-ascii?Q?lehPGSNusXsrkqIiiWKF1nEghzspsuhkWbo5P97jfOncvVGq5I887XSIn5+5?=
 =?us-ascii?Q?crMLTYghSmD/2R+pytZvEDPlvYmHSEC3EMk77EuYvw8eypw18/TP2hiimfva?=
 =?us-ascii?Q?LYLm3hQjEBh87YkV/TtlaiJnlSP9HUz12tfqjrgmVeehJVcOs1GFjX96727L?=
 =?us-ascii?Q?cjmmLj0GQO4gG9r7BaslhL4InW7hy4P8WUfF3ogv9Vrgtaky7M5NSS7+1M7g?=
 =?us-ascii?Q?yL6D75I627A98EcP3HNBr2a5yTfXHJIrP9JQPRBEgp0+Ikub07aIZKongJny?=
 =?us-ascii?Q?X+pys7hRnPIhUwOj3Ruad4zgTaEvxdohMMQxGMkvzKjvb30XJshz4r/uXcx3?=
 =?us-ascii?Q?Cipl1oCPyWp8blrGRp+vIeUTpAjkMPLmr/h4X4R1zRgBNkgjWlUsigE2Lhch?=
 =?us-ascii?Q?47mpiK5WlgQvcGo+cuKYTGfWNLZeWQrdCeJKjDicQhyLXrox3NoZFcK9kf0n?=
 =?us-ascii?Q?rr6I5Fgf6cxNtAbF3lU2TIqAG+V4amBo47c4S0q4U+IrnYB+TiA4CnrK/X8B?=
 =?us-ascii?Q?O1h1Up5OZzbEPgB905G71d9pTRrBsFvuQW3pOO9S6ChcZ8DiGQcnZ3MForHb?=
 =?us-ascii?Q?4f4F1sJFc5xj1U5RKwO0alH/O05kUTh5GSrGrZ25mGo0xHAGwC1hPP/aK/d9?=
 =?us-ascii?Q?AAXWk150P687O6qAeA96PYPgJldw25VJDCBHm8EtuodVcH5qoeZRIX6i0LCY?=
 =?us-ascii?Q?my7qZQ0ko90HuxFqlgc3ClXROe8XUnD5n5zKE2nrqIvA5ikJWL6qn3Yc0Xak?=
 =?us-ascii?Q?7dSu/rEJ15TvSVnnIeMj6GpEsQ6Gx5gW9llICW0GXbPlNZWL69k/FcPO6t/n?=
 =?us-ascii?Q?zkGvOPfyHMNNSOX7emgU8nTuyzUdOjelo740hz8PFK9rE3Qhzzq7evhBkUS4?=
 =?us-ascii?Q?gN6yRMJO9bUSk2h+4rqgTuNHSGrPk2chN4iFnOba1WWVauxgymMWN7bB5f23?=
 =?us-ascii?Q?/R0aDXHziHPEvqSSk/RcShHjmcyXWE0aYcrmfXUk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d70e9ed-71a3-4601-0279-08dc3fa81859
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 19:43:57.4870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1j/EK6zH38REZrV+9ylUlYkIv/w89lTGakgONPAeBQDg5NPEbOmg0yKNAh5wotFRsImFF1BAGDFrB01GxT1QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3111



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, March 8, 2024 2:23 PM
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
> On Fri, 8 Mar 2024 18:51:58 +0000 Haiyang Zhang wrote:
> > > Dynamic is a bit of an exaggeration, right? On a well-configured
> system
> > > each CPU should use a single queue assigned thru XPS. And for manual
> > > debug bpftrace should serve the purpose quite well.
> >
> > Some programs, like irqbalancer can dynamically change the CPU
> affinity,
> > so we want to add the per-CPU counters for better understanding of the
> CPU
> > usage.
>=20
> Do you have experimental data showing this making a difference
> in production?
Shradha, could you please add some data before / after enabling irqbalancer=
=20
which changes cpu affinity?

>=20
> Seems unlikely, but if it does work we should enable it for all
> devices, no driver by driver.
There are some existing drivers, like mlx, rmnet, netvsc, etc. using percpu=
=20
counters. Are you suggesting we add a common API for all drivers?

Thanks,
- Haiyang


