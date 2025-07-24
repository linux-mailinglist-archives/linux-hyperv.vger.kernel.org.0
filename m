Return-Path: <linux-hyperv+bounces-6381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB405B110AD
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 20:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58FA7AE338
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD762ECD06;
	Thu, 24 Jul 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GDue6Dsl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023094.outbound.protection.outlook.com [52.101.44.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA42EBDC9;
	Thu, 24 Jul 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380718; cv=fail; b=eB1qqcqK8QS3mvtBN1GgI//KTufhu0Z4aXZXxDvsxVazWTpwk4nPEiZvVl1gMSLY6eF9neqSBlxASO3vjIODlhSb4+sJhjegUhouUYjX2s8tFdkfDCOV2+uFfArUuWWhrUz1g8RxDtDthG226AeQHhqMxBeWdzFIiPSP/kuXVb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380718; c=relaxed/simple;
	bh=yapUEq5lKVsOXl0GcdLnzSdBHbmmVT9Z4utGm3mcNIE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bG9s8ujMlkBUwB3DXCbqffNmpmANBT67zeeu942A+l+iiEEmELJzl/0tK0zR+h5PKhaGRkHSlV2KFa44b+BIHu5NCR3js9khg0BtZ27fTj9D9c+LHLIapyHzt4piOD0943q0FijCOwkWDB804DdDr/KQcT76NZZqseoQeWNOYFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GDue6Dsl; arc=fail smtp.client-ip=52.101.44.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNRqrkMimiEZnukSdgKKAQUR5TUHCTO/r8oEmJyLbO6uhWHEktKmTVQg9qmxU95wpoCb0P6ni4Pkkw9ELJdtBn9kf2p+xbHtGU9PHtqlVEEfCjA0jtC3ANifSkLR2FdKCYcy2tD4hMOrJezWnjcMnpvXwhMQt7570U0msjDlxs1WUe5GpG/GJAeGula3PL1kGQxagEoYCjnqNCNiwwMSbiTOFPP9squ/vZeoS8Ss5bZN+GQX+VH4RbwXXIgzbPygodqYIn//fBKruBWc9wdgcP5+rLcZEQj8qMwBuK/YSmFsNPiCWD6Ltp9YgHfiIe0+m1SD/qXOHLRtHAz8+j3J1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yapUEq5lKVsOXl0GcdLnzSdBHbmmVT9Z4utGm3mcNIE=;
 b=atFcDTQnV88wy2Paa5bFfYsW2kxpK1u2sSm7jeZ991mzovCBxAo05zQ7A9qiN6gweULn5rY+jeDSLaCx4PQqg4UcqmW73I7PkqV084LuHEeYHSJlrLJq4wYw9yk2lpTTxd1E0im5KP4ywrom+RO3ywua9/TxoY2M/uuCW0bCz2NFBsWw6ind7oCudOC9t7PlpaEkUDPMrFQEIwyF6CA2uIA30kTahXcXrEV7lNATJDyDnxCoC7iGs+lLxZwnzozS5jQAsA3oFY6x+p+jB3gEtqdfltWdfhJCQ19sYR56WMtNJYo0JOGdP5WBMSH0mCCHBgvK8K2CYhHp4tEl9phKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yapUEq5lKVsOXl0GcdLnzSdBHbmmVT9Z4utGm3mcNIE=;
 b=GDue6DslTmWABd+ADbQrgakfsGGMDoi5hBlOLX/mnz/Xz4Fwn+fA9WIYk+1RTxrIrs/QkoVHEimKYxj/qsdhUanAskK7DMRUI37LySY75Ck02gH2KLNWgWU7HzdA18Wddoid5TnxbRjcthP9US9YwVVvi76BaUTID9espOtslx0=
Received: from DS2PR21MB5181.namprd21.prod.outlook.com (2603:10b6:8:2b8::22)
 by DS4PR21MB4699.namprd21.prod.outlook.com (2603:10b6:8:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Thu, 24 Jul
 2025 18:11:52 +0000
Received: from DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d]) by DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d%4]) with mapi id 15.20.8943.001; Thu, 24 Jul 2025
 18:11:52 +0000
From: Long Li <longli@microsoft.com>
To: Cindy Lu <lulu@redhat.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Kees Cook <kees@kernel.org>, Saurabh
 Sengar <ssengar@linux.microsoft.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, Joe
 Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [EXTERNAL] [PATCH v2] netvsc: transfer lower device max tso size
Thread-Topic: [EXTERNAL] [PATCH v2] netvsc: transfer lower device max tso size
Thread-Index: AQHb974fO34NVuVw5U6P5WiyldC5d7RBnUNg
Date: Thu, 24 Jul 2025 18:11:52 +0000
Message-ID:
 <DS2PR21MB518165AC2EFCCCB436DD1B23CE5EA@DS2PR21MB5181.namprd21.prod.outlook.com>
References: <20250718082909.243488-1-lulu@redhat.com>
In-Reply-To: <20250718082909.243488-1-lulu@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fda5f29f-701b-4f6c-9df1-66d1a549e8b7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-24T18:11:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR21MB5181:EE_|DS4PR21MB4699:EE_
x-ms-office365-filtering-correlation-id: 513b819e-f3cc-4b5a-b96c-08ddcadd90f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jvVokzxXN4DSBKdisDW+BLaLjyoZxfkewUpyQmhFSVykNFsLFgfiWPF7TVIp?=
 =?us-ascii?Q?X6Nq7gPsD/k0zY5D4Wa+zG+oNnHmGfjA78WyHQeMTiw4f402H35Uswwc11Q0?=
 =?us-ascii?Q?RG7ivCLsLRjK/PD93RXF9t5yZcwE5A+vTFZGFN6prgmDyQy9cyVcvLrQqB19?=
 =?us-ascii?Q?GLgEFKR1wj63H3T7RXOuLvHfbKb0NCL7EUYAVK9F4uUGdva8OxLYjf6FC3Pl?=
 =?us-ascii?Q?VpZMyv+sfjR5QQLFfoAUtdZLZpQtLeEwp9JT8X1b1ZXpdqMDn7NADwqf12+z?=
 =?us-ascii?Q?c47JVW7Q4c+WuoWBT9DroU5vig02QxAaVUTkFme4UQloQSNGsoSB7KMYPV6m?=
 =?us-ascii?Q?H0NZ+e5SOQMw8KTQqLfRSmTcrBgtx48EUauM3yHio6RlGNgSfDxKurdQ/nWz?=
 =?us-ascii?Q?smSA8SFgoRfx8oFEWt4LL3pYmInK1KLtWlE/0LpbnRQkvSnYa20fzv33DIx+?=
 =?us-ascii?Q?7sVm7ySfIozjZYtI+o9TSU5CEtSTnyMXjSPQ9XuBO01WosaGbdpd8z6ZNIfD?=
 =?us-ascii?Q?9resLxLjAQY04bfkW7gfKA0oQbvrD4gS2U1/8jOgkEQ2xW8zmlTlu7vjZSwF?=
 =?us-ascii?Q?24g6EqJGfiW/4Kl9G39M/Fme+5iuugAkFmx9T9TsNSSs5HRONBkrBqFpgNw8?=
 =?us-ascii?Q?pe7stHaFZOOwaJiuqI4NxVkRdWe6o0YQej7AXYcfDRRBY0n0TZv2SRfKP7li?=
 =?us-ascii?Q?PZbJYC8YuyBUmJX+0H4eMOG9QWwNIcQGNk+NMbsQMy7vwCoK7EHJ/9Ww8Jih?=
 =?us-ascii?Q?itlS95V6OFWI5fHHowQ2FS73nL8DvSwaKVbhAHK5NmJD/D7SvPEZLnEJPHN4?=
 =?us-ascii?Q?DnHp4pf/mfx3hezDQGXCSP+bJTwlH8uADaJMATodx6Srdd3mlKTV2L+bl3GS?=
 =?us-ascii?Q?/iQ172l9mF4sMw96J98QycLofsdeRKXyUm1vCc4kE0Z3pPNHY4I5UPMBlLjV?=
 =?us-ascii?Q?6UqNLCRmZFWNFrOGV2Z1alnti4jFBUibBQ1VeQyDPVqH1FiPZ3d58X9e63zk?=
 =?us-ascii?Q?qzSRz0HH0CY+VHX3/TWMNlUPavGj+SebGIFF9SLethTDsJ0Xvw5pwi1O/Wf8?=
 =?us-ascii?Q?w+taAftloWhTYCltxz6LZkrnD7Gpy2tDmzvXg80Ak9CUdgvfTYQyk6SeHquX?=
 =?us-ascii?Q?cUKeiGTnAzuoYa5eP9MNmP1YXl9bho6ZHWikWhWkHdcFICVZ+kdsgs6oWEcM?=
 =?us-ascii?Q?j+gnmFuC2aLMxNqpum0RGIxz9IcEUJxMzeLJm5NHDDfTz2to5h4bmlX4jHde?=
 =?us-ascii?Q?JrU0jfm52fGsE2n8SAhss5xs8NjO+GhAWpclAki2iSJUWoAivOM1GOsjFf3o?=
 =?us-ascii?Q?LEQpV7OSQg/BKEbl0Lr4onyqVxGmzLmu9JstvTUVp165993Chz8v8Vrdr7Zr?=
 =?us-ascii?Q?IwyF1jog2cQlaOmFD9HZTbArvcf8I0t4kKPWaqUldNM2G5hcQIPOBemwOUky?=
 =?us-ascii?Q?Ta1/2mApF9S/cm2Uv406ukT8rAtlZasZ6NtCiFiElN324ORODN54DCo/ILqU?=
 =?us-ascii?Q?nox98BTe/ZkeXiE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR21MB5181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z3KBIA4aKULjTdLAwV/He5DAVsp8uowpa3oFjhLONKXCnJM94vxWVeelTma5?=
 =?us-ascii?Q?MJQ4BObT950GQh+jsM2RPcLJWbpmJFBBwmT8G7gEaG4VqWmuFXgVK28Olznk?=
 =?us-ascii?Q?AsFhhOV2hXuQmo/2kqLuM8xkzr+0fUZwuL6OcJS5xLo43Np7ehxelzQKeDAl?=
 =?us-ascii?Q?wAQjZsJExBVbJ488Oxv0Mfjsy0oXo7lhxRrzjQ7uEQnXKZ50RJtcRA1p6hxY?=
 =?us-ascii?Q?vrheD99ZH8RyMB5xMINhWTPTkzkPtvAnntOhWbJacMqbm8ysFpRRHAnFaj+1?=
 =?us-ascii?Q?YtYJHii0wFLZ9HuI1BGKChGymiw1hAV6SvKc2ZeMCjXJoDz3+batMpTT/Oid?=
 =?us-ascii?Q?qgz4u860BXmRcX1KIFLnaimabj3/H8OwO7JhccIBQDUMnqJyHhdwp4dJ3pek?=
 =?us-ascii?Q?e4EVyQf8rmHdN0BlOM/o+KVKL6QIpfW/gAdu70RBQBG5fyt9/OndR79XxC4D?=
 =?us-ascii?Q?uOQbBHyoPkTWZSxfGLeybAlYNp3j9FleQITACVfCHgBHmnRzILqGtdZ/X/ne?=
 =?us-ascii?Q?sOaO1wqKMrTa7IFfvO+LuyxWo2Fh/7gpUZfqVSpefuV23n9ngl9EjFeNcww/?=
 =?us-ascii?Q?7Nm8No9IwZZF1fvUAWIOjhRTQtpA7Xo0IXf4c5yu5GXY2Lg9gxO0YAFLzwl/?=
 =?us-ascii?Q?GkmEIMAcY5L04uYGviu/Qjo0yXV0s3HZ3rP9rgaz7x9agj5G6Xe9BRM90Iov?=
 =?us-ascii?Q?NW8W+5b9I2mTqEp4jfMdsF6LRmUfbKwb07KYKaWa+1ntaoseIid3iyPO7UAO?=
 =?us-ascii?Q?AvtJN+M0rVsIJuVqWB7ttntR8nisflbDwd+F3o1KWyuhcMtVfkSP7qiSbcsU?=
 =?us-ascii?Q?S9jktwjAc+yPPjhP7SyAUjfxHHjS4cTtcqMcGVkUTHtpP3JlPwgw1W1PwfXt?=
 =?us-ascii?Q?i8zSQB+vf7+6tpkzqUDWrj3ffaAllRtp8+9/Y0/4rRntG9WhDMV2F3MqLwIl?=
 =?us-ascii?Q?W3sEl7NlsRMFqbHFiY/KjTgY0MTtc7bar3spL/m2I0QdoHNBrWOUcfrmvaTv?=
 =?us-ascii?Q?T5jiXf8oAWDMWKEmBGv9TQ4lNYr8FIkKo2UbNfllawxM0gcQagrnmBZTAegN?=
 =?us-ascii?Q?rZB4RTDTIlslrf66HgyOnwnSY7uufQF/YKa5WFzahMaN4502VdyEHaN8uWbW?=
 =?us-ascii?Q?aYputMroOY4K+vFYsy3KunbUzMEqSxgF3wGDnU7ucC9rp5rx/qPoqvvJIl2S?=
 =?us-ascii?Q?hxOzf/4D3qCvVHtT72vGrMfBYADHfn+P6In5CbRA/Yhc1kOPi1bLQ9HCOwsU?=
 =?us-ascii?Q?f7xstKsbchYx0MHHokOCzTeWG5a/Pe4/k5VCQZmeuEQLBUCaWjZaojgWSl3u?=
 =?us-ascii?Q?SjX6bXtf//2zsiYOL0ZuCJuvqzHB9CG3fMNX3Vll+opSU+xTxyV7WaHUNSyo?=
 =?us-ascii?Q?YonZ7eCKAnzDb+A/MaMx6pl6vitclCnY101XjJ1dzyTQi5YKzJmD6VB9wp+V?=
 =?us-ascii?Q?OFmmXDBB+binfMEsOcLJ64rCEs+mVWE1tr4z0uEKvFKv9VQAh8AXsanci/e/?=
 =?us-ascii?Q?QtPi2j+Fzh1XQy04PlvkX4dfAh9uLOPjwzJcJGlwn0ck5NeZYpyWot77f9Cy?=
 =?us-ascii?Q?+uDSILJcFS6WvFcDGjQIINXNWRpQ9We33pVXCtvv?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS2PR21MB5181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513b819e-f3cc-4b5a-b96c-08ddcadd90f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 18:11:52.5274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVBIMPrp5iHnOcgIktirBuZo+KK2x20iZrYi6pdxZyZIRzZGQKH7yPKbC3iaBVOxusRdibKdv9B5MJRQB/gVVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB4699



> -----Original Message-----
> From: Cindy Lu <lulu@redhat.com>
> Sent: Friday, July 18, 2025 1:29 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon Horman
> <horms@kernel.org>; Michael Kelley <mhklinux@outlook.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Kees Cook <kees@kernel.org>; Saurabh
> Sengar <ssengar@linux.microsoft.com>; Stanislav Fomichev <sdf@fomichev.me=
>;
> Kuniyuki Iwashima <kuniyu@google.com>; Alexander Lobakin
> <aleksander.lobakin@intel.com>; Guillaume Nault <gnault@redhat.com>; Joe
> Damato <jdamato@fastly.com>; Ahmed Zaki <ahmed.zaki@intel.com>; open
> list:Hyper-V/Azure CORE AND DRIVERS <linux-hyperv@vger.kernel.org>; open
> list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>; lulu@redhat.com; jasowang@redhat.com
> Subject: [EXTERNAL] [PATCH v2] netvsc: transfer lower device max tso size
>=20
> From: Jason Wang <jasowang@redhat.com>
>=20
> When netvsc is accelerated by the lower device, we can advertise the lowe=
r
> device max tso size in order to get better performance.
>=20
> One example is that when 802.3ad encap is enabled by netvsc, it has a low=
er max
> tso size than 64K. This will lead to software segmentation of forwarding =
GSO
> packet (e.g the one from VM/tap).
>=20
> This patch help to recover the performance.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Tested-by: Cindy Lu <lulu@redhat.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Reviewed-by: Long Li <longli@microsoft.com>


