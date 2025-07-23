Return-Path: <linux-hyperv+bounces-6368-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A93B0FB59
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 22:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2941C23EDE
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057CD230BEE;
	Wed, 23 Jul 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WRuaUclo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022137.outbound.protection.outlook.com [52.101.43.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD620DD42;
	Wed, 23 Jul 2025 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301888; cv=fail; b=aLMfnQGqCUsoVnkcYyBukaw+RvqyrSHJbSGK5e972bsQBOaqpzI8yNYZZ/JcuLhJbgh5gCv7wwdb8qvZPBP03bFuZeKh5XO8GKNuapiZ0y6t3nX+MdV79BXhdFqC6pk+pmKDhiQ2/ApsKAesQYDu9fP4GS2oCMZbZDxL8g3jdsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301888; c=relaxed/simple;
	bh=ybxG2ur1N7qF+zMcFc+5hZqwXngehJZ6mJarG+mWzwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A9I1I+AVfjDhP3bK3LCnw5SkKlHHamrMbiKwKs3FFZXy25nBd9Okhb0EJE0Wvbw0bsXYXXdbQ1WwM+ObyPaMLMXane03BzOtbrR8mW+hVosZnN9kAaw9+4nxoS8el/nWrlbdQ6dvRY6GUAnIuJwC4zGaMwesQ2AO4hQgDMnuPjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WRuaUclo; arc=fail smtp.client-ip=52.101.43.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXHYGdDmms+1Py2mTpKV/aFBpGB0IzJG6lXnocCeR42Eu3urH93d8ucClEEDN26Hcu5gp5bZKz0+l7QWc6N/m1nWzH1NUIrN1866TMfdlyHbZvoN8BNnhQOGuu0KOwfHRRXF6cTaS9WyGAh0sEbpcGX4wlSVCn0U1//ek9pBiTiLInrINLOQGvO8ffOhZw6HsHGRUvLV0c2mQtDCSPlUluJMNGJjapoiktvaoOxyo3FxsY9sDUUo/9+KNyBd+waaHcvfaAZff1xYQab0GJweygHJWath78/O6fnYwvM10fACpsbOLB0abAvZ6Tjh4mnOWdU90wkVywIV8fj14shSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpBdHUSP/Tg7RQUrd7+4vrfY6qcYLJxNRDoHsuwHr08=;
 b=ergUzXUYl6EJo4SyZcxN7xA28l5z6jEQO5GkwBmJt/feM4h33DHidSTmmusb4SYOn0dH/8TMFILhPSZzpQyzuV3Tnau70eElG32RUezqoHPHdK2jllm/+cl1RNPV2w8DilITLJMco7b8d9sYSWzUzEiG/bhb4UH3UF2IUes5a3dNn1ejPx4WmZpOUL5FT3+VCdJI0Nfucskkm1qAjsCsfnbA6WTpq+c3IjCSz1XQWfzgy6evHAP30NOHdEQU6uzWiBoQaxN+ZyUkifaq2VLWXkffn6xQYQvOPK88YpTu9Anv+I5U/dA/l4GF1/Yhkxa+i6g/vmVeo4Gh79ufJTGwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpBdHUSP/Tg7RQUrd7+4vrfY6qcYLJxNRDoHsuwHr08=;
 b=WRuaUclodazK7Yc3pM0St7ZA6lURs1W0//bTxPi+HYk69FXhpgvmPR6NSzhrAp8qqecTwWOiEdxfqNBzWVk36ycXUDesQYGHQSeduvmdEUeh7nY/lGd+SbWX6ynVqgRq4jqSQsnl0q6x9f/HxD0vktmarOtGkI6rF8gfvtapbL8=
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com (2603:10b6:a03:546::14)
 by SJ0PR21MB2016.namprd21.prod.outlook.com (2603:10b6:a03:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.5; Wed, 23 Jul
 2025 20:18:04 +0000
Received: from SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18]) by SJ2PR21MB4013.namprd21.prod.outlook.com
 ([fe80::3c6d:58dc:1516:f18%4]) with mapi id 15.20.8964.004; Wed, 23 Jul 2025
 20:18:04 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>
CC: Cindy Lu <lulu@redhat.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Kees Cook <kees@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>,
	Joe Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
Thread-Topic: [PATCH RESEND] netvsc: transfer lower device max tso size
Thread-Index: AQHb/A7lj9p8YfQZD0S6aQoMGZl4ug==
Date: Wed, 23 Jul 2025 20:18:03 +0000
Message-ID:
 <SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
References: <20250718061812.238412-1-lulu@redhat.com>
	<20250721162834.484d352a@kernel.org>
	<CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
	<20250721181807.752af6a4@kernel.org>
	<CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
 <20250723080532.53ecc4f1@kernel.org>
In-Reply-To: <20250723080532.53ecc4f1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d8d42eb-19f4-4e42-ab0e-bec256a81fca;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-23T20:04:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR21MB4013:EE_|SJ0PR21MB2016:EE_
x-ms-office365-filtering-correlation-id: c19a569e-d4c1-4bac-32ad-08ddca260786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?25Xt4a6LNWl4PIOGezKVgzBf12rIbMZ+4HzXu/fnYf/xvAFGg9DtFqWrvUFp?=
 =?us-ascii?Q?VrsTIFcGXNKs7394ztQW9nZ6cY4W631zeO0ciU7FRHOnDg4Cz9u37DZyJ/G9?=
 =?us-ascii?Q?on2IZCxF3GkJpuJ8WsP/hbMzXg9LwH92B+RxKbfLClDp9hhDwU0QAMOjDIzj?=
 =?us-ascii?Q?3IZWTRj7N5SFVddN9PdWsWeXsRIQoODQuDIKhlOqLJrtO64bxssqU+BYleAR?=
 =?us-ascii?Q?8C19UFwBkSGgiemPms3MhXwwnFP91TeZXRwdTZ6wRB0PzHgGghe4MUleGQK7?=
 =?us-ascii?Q?z1cIvT8A/i6vK/Ot50QfTqOIBipedlYH0Ldo3fD8N0qnGncw/wV7zXFxwniF?=
 =?us-ascii?Q?zyHyJ11YbT5mErmDVdGJxmfCWPI246mjaoIaclckvBxF6VjmCLZ2DCUtlEmx?=
 =?us-ascii?Q?ISlMsWf7wZwQzky/ClMXAvkxGYJ5pVK71DR83KpFYCTRMFOKt6apanB9H8rl?=
 =?us-ascii?Q?wJYYv9Qh5CG696eHzfL7C61KhkbNH2hcBJP/RD4T4V4w7OLVI/IgTMqoUosn?=
 =?us-ascii?Q?nGVzkIVqmEpR6LvY+1AZ2mQXQpXOYsP5gOUL1gsnVwNmZ2j1nc1FkBKhVncP?=
 =?us-ascii?Q?eT4jp2Net4VYwqbXIsLFEff2KcBkGadpLOMM4BGaxtyLe4NWQUzJMZtrFKcx?=
 =?us-ascii?Q?S1JqNkRA3moxZQMTHwALAuqKcqeaKhPc7IcXpjJPjiqIN6lSBg3hTILjX4oY?=
 =?us-ascii?Q?nGen1qHNu8jBA1oOvZeW8N1AMDt7I5GiCX6cRjIV1t+qwSUeG8ithU8iP6CV?=
 =?us-ascii?Q?w73WoRaf88mTs/ktiMAhE1lroyIjOvlcznCC9aZ7G14ptO6S8MSjmF9LU16+?=
 =?us-ascii?Q?sIFao8OCYsKs8s+LYhNpofTnkSgzXOGWvZMmKYRTjpbTdI0y1c5h1fJ1AJrx?=
 =?us-ascii?Q?yGYtVDix56vhgVM5/IfGiWZaqXz5rgdXY1WpPQTYfZDNlzQobo2w0cBw0v1j?=
 =?us-ascii?Q?rrHcTSe3jh+9VYrt6Ggu6MoP3beFBwt00JDgcPmcdgCs3tdMqJ2gTVZKkTIs?=
 =?us-ascii?Q?klgZmVyslVHoZ4YMYRV49NuJAKSP6mE/Ud9fgkEX1LiQ4RsiaidmknhDIMYO?=
 =?us-ascii?Q?TyGMmabLbRfY/+DNum/7Vu9aHjHVEt/HNK5Ip1YNgwwTMfWCFXxiNO1QblFd?=
 =?us-ascii?Q?OOAPYTps1WI7l/qmHAemzgYbont3Fx88WwBsRBw30PNjbGeGBRGH2Jk5MLOx?=
 =?us-ascii?Q?g3xTNiwkw69A1KVA1P5Uo3dh2Mvo1xRE89bc6Ph/KOa9N3f/xoix0U3I4bLd?=
 =?us-ascii?Q?SLG5DfCoX4S/PNxCJ8agAva44Zu/xtZ21E15Pix+tYF3c1k1hHyilRT+w3EH?=
 =?us-ascii?Q?uVo9w8UxH0IhkTZtrThy5dOoGOQ0/sk6n3fb6mGbCCQmqTFg4Qsu2B/R+UKe?=
 =?us-ascii?Q?SkL9hDJYrgBMXrILOZKa3P0Bud7sA2yeHgLh8kKDqo31S5++nFanpy21uhfF?=
 =?us-ascii?Q?E3hvev1DAFU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR21MB4013.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0+ia3OkqzTrrFx35H1OVl/B+s39A6FOfrcgR2siomFQ83GiDoaCval4Khewo?=
 =?us-ascii?Q?2Gw6RGs5ZCGEZmUkYul0+xOJQCQNKxeLhkzDl3WCLWrxymTiVOWxiXgURpiq?=
 =?us-ascii?Q?z2W28qm2+PAHRmbJvZYYA74zPYbqzaUoClMZd+TtGA20dvpC1H0JD2MKmcuo?=
 =?us-ascii?Q?kLY8W/8EMqpII5WFEARWN1AfhDu+/oj4UOpMsWd1+fJUnDlg/KQB8LgR6Pf7?=
 =?us-ascii?Q?j1rlFnypqbqAg/4mGBtU857GphsbH9w4ZdulO7W2lbCIuxKzR0r7A99KyyCY?=
 =?us-ascii?Q?49iuaq05cnxgRIShdv7OI+jYS8mk6XHW3SSJVemCe8hr/WzrErVSTuiK9HYP?=
 =?us-ascii?Q?AoN78fWTqbrOF7HRzZrRM0BGGOXTx5a/PSYIu0p6uTXgLWWho48OB0CZbT0C?=
 =?us-ascii?Q?hQsSrrFGN++5ivmy49SNdrOoF2aFWfz5bRceZe40GTO1H5yqSk27LnWPM7CM?=
 =?us-ascii?Q?KV/EN2v50ZDVDN/2xuBspVNC9UTG18jnR10UAPWAVGrB/mEt7+dk9lTKQWzi?=
 =?us-ascii?Q?m9BP4RGvHzv4QqjG+b8i87Qx9pQgXXYOUlBH+oi/EAG/eUf546VjLsalvJm0?=
 =?us-ascii?Q?VKzr25Tf7rX8561vy4PGcY6y72DecY+Abs+s48V+lKaFoUXQ/dPQ6gNFFuij?=
 =?us-ascii?Q?4CtBB8HFNxAGVtTTpoGL6nImi1ZNzvN+VCL8KnEqStKpBD71rGY6C+ajYh5o?=
 =?us-ascii?Q?/M0LNOAOKd5KmZ7OfN2HBj3EkeCMJoNkXrKlxTnze4uPIeYEfdA7UMzGVasz?=
 =?us-ascii?Q?QHYl+j8rKgDVVz+ocrziR4Yp3zC4ZfDrjP8zk0tJGUdajKGUpxEzLr2k7seI?=
 =?us-ascii?Q?mmSn3O+F2rXC7FtRxZ3xFtxidHLJ2ZcmBgYKf1sN/lG8lQc+JL3nodthTz8s?=
 =?us-ascii?Q?q/kLI7PJbfv/UWlIGgLlIpyVmleowOJXFQGe4d6P0TfYeUxdSY2bK1gJZ+q7?=
 =?us-ascii?Q?1pZLVqd23oDCJxSF6LTw1jHUIEP+yTrp9VeTBQv6yLd///IAQHUFPKb6WlCv?=
 =?us-ascii?Q?AOI4oFTqsINzbwBjMskwXp5N61PDjCw7tXeV+lhBhEm5DIwW/Ql75XRoyTPZ?=
 =?us-ascii?Q?mteOdnTo6imPYphZsSD1WIHtx5AdGnr5fk1xCxGZtLEf12RP3H1aDub4ahMG?=
 =?us-ascii?Q?hs2q3m9faOke88xG5w1jFyx4dsxbf494UngvMjQtoqzFr4ZEAJhJIlnjF0sj?=
 =?us-ascii?Q?zEYNVM4HsF0KLGoUfv170GXtnbklOU243OQv1T3rwIuXRHf8Wg7sbslGjeed?=
 =?us-ascii?Q?U4broZ4FX9efdif7Q94eUoqES/WPd26GyRTfMT2ZUG76dDDWJ5g33wS8+VKJ?=
 =?us-ascii?Q?sinJ+xHyQrqCCUue1KLvLFHGCAc4+8QMxEGVIetHmYW6QUH1PxOsQnagyD94?=
 =?us-ascii?Q?349wOjepyGNUlySWi0Pcjo0WbE4OvuCCT5F0nvtLrI6K6PfRB7voc2Iz64dY?=
 =?us-ascii?Q?7+kv5gqtenhk49mxCBKV5a1DBDSm9T0EjlR9EnpWOl+8nmTTAg4B9/BEVeBR?=
 =?us-ascii?Q?FQfzV+m12dq85xE/FBTJcz0p/U0R/fF7iS/Mfeq7kgA1N58cibGikYbCDhSr?=
 =?us-ascii?Q?Nf3BkienpRp3GzfDhyRl3b31X5sk0v75GnJDBi9y?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR21MB4013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19a569e-d4c1-4bac-32ad-08ddca260786
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 20:18:03.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3euMrZx9N6yZLHd3UbvAOCJyZPwv31hrIhKO9Bq1toLy2yHYu3VOheZ1U+yrWBeA6GsWxTXhKlPHUTzDb5a0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2016



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, July 23, 2025 11:06 AM
> To: Jason Wang <jasowang@redhat.com>
> Cc: Cindy Lu <lulu@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyan=
g
> Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Michael Kelle=
y
> <mhklinux@outlook.com>; Shradha Gupta <shradhagupta@linux.microsoft.com>;
> Kees Cook <kees@kernel.org>; Stanislav Fomichev <sdf@fomichev.me>;
> Kuniyuki Iwashima <kuniyu@google.com>; Alexander Lobakin
> <aleksander.lobakin@intel.com>; Guillaume Nault <gnault@redhat.com>; Joe
> Damato <jdamato@fastly.com>; Ahmed Zaki <ahmed.zaki@intel.com>; open
> list:Hyper-V/Azure CORE AND DRIVERS <linux-hyperv@vger.kernel.org>; open
> list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>
> Subject: [EXTERNAL] Re: [PATCH RESEND] netvsc: transfer lower device max
> tso size
>
> On Wed, 23 Jul 2025 14:00:47 +0800 Jason Wang wrote:
> > > > But this fixes a real problem, otherwise nested VM performance will
> be
> > > > broken due to the GSO software segmentation.
> > >
> > > Perhaps, possibly, a migration plan can be devised, away from the
> > > netvsc model, so we don't have to deal with nuggets of joy like:
> > >
> https://lore.ker/
> nel.org%2Fall%2F1752870014-28909-1-git-send-email-
> haiyangz%40linux.microsoft.com%2F&data=3D05%7C02%7Chaiyangz%40microsoft.c=
om%
> 7C27aa73c4b6e9446c7f6508ddc9fa6053%7C72f988bf86f141af91ab2d7cd011db47%7C1=
%
> 7C0%7C638888799449774753%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUs=
I
> lYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7=
C
> %7C%7C&sdata=3DHYX4dDie8QlEepzwPiiI3eYASe7WN5o%2BWTXmMGoyFOM%3D&reserved=
=3D0
> >
> > Btw, if I understand this correctly. This is for future development so
> > it's not a blocker for this patch?
>
> Not a blocker, I'm just giving an example of the netvsc auto-weirdness
> being a source of tech debt and bugs. Commit d7501e076d859d is another
> recent one off the top of my head. IIUC systemd-networkd is broadly
> deployed now. It'd be great if there was some migration plan for moving
> this sort of VM auto-bonding to user space (with the use of the common
> bonding driver, not each hypervisor rolling its own).

Actually, we had used the common bonding driver 9 years ago. But it's
replaced by this kernel/netvsc based "transparent" bonding mode. See
the patches listed below.

The user mode bonding scripts were unstable, and difficult to deliver
& update for various distros. So Stephen developed the new "transparent"
bonding mode, which greatly improves the situation.
@Stephen Hemminger <stephen@networkplumber.org>, in case he wants to
add more regarding the history.

Related patches:
author  Haiyang Zhang <haiyangz@microsoft.com>  2016-07-11 17:06:42 -0700
committer       David S. Miller <davem@davemloft.net>   2016-07-12 10:41:53=
 -0700
commit  178cd55f086629cf0bad9c66c793a7e2bcc3abb6 (patch)
tools: hv: Add a script to help bonding synthetic and VF NICs

author  stephen hemminger <stephen@networkplumber.org>  2017-08-01 19:58:55=
 -0700
committer       David S. Miller <davem@davemloft.net>   2017-08-02 16:55:33=
 -0700
commit  12aa7469d101e139b3728e540884bc7d72dca70a (patch)
netvsc: remove bonding setup script
No longer needed, now all managed by transparent VF logic.

Thanks,
- Haiyang


