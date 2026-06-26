Return-Path: <linux-hyperv+bounces-11693-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8MqKtiVPmo3IgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11693-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 17:08:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F816CE515
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 17:08:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=nrO7GdqJ;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11693-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11693-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0D4630241B4
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4FD37474E;
	Fri, 26 Jun 2026 15:04:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013094.outbound.protection.outlook.com [52.103.20.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B1374195;
	Fri, 26 Jun 2026 15:04:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486247; cv=fail; b=UbcmMmZPqlgKJoxczmO57tcUqYiFVaNa38CuvoPMgJM2a4K8FEGVUo5FkL/AQliF+c/XIe+aVVtAGVgyadK76DgLvObbT5dwWuwDtru1zaILFhhCGgkRHeMNt9IMPODoY7ugHGI8vFqcQa6z2FQQvz2ismv8B73XanZcenbtDak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486247; c=relaxed/simple;
	bh=tt4bvEcxP+PRwqht6gv385GbgA82Cl5IGVg39m9r14s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kMOJ6c84r5cJQwY+Nb1vEaINDpMCJTPdkeuEE6/aqk+cJ8ZY/8ZuSpkmXX9Y+RNVm0FT1a6RR8Dv83xBlzXxd/4X5vb+MF240ei/rG+NNv7/j5Mot+c0pZl0M1swF5ExOFb/mH31zjq+jev9+tjK87Q10mFmi7r0ibTyNLR4k10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nrO7GdqJ; arc=fail smtp.client-ip=52.103.20.94
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awy8ThVHE1mIC3MLNs3LD3ymzA5WNuhkIdTMY+4F2AhYV+0TSkjVb6ZCKOAq0KZ/KZHwadPqPZByJgjjp7++pUFfCIe5z5/Wb2wU9Vim4HroExQ8MOUXEPdcWCszlyIQMGFqSSAo9irCWRWGmmA9Tup2WvppWeMo0hj64DFfONGpIGEEv4hN3bxwLLN+JWNASCmp2sTuBZ9Jv62UabaHWfKVRdRwMLlL9bH0RP51gsQAzbgT0L48b2rYcZi5kSQfMsLpkQYXma/3dCUDtA2zwHzAUtjLOf9BTp4j/dfoHxYJlkT5i8BpE+Yv1hxZdpddNvqB4sp/Nr6qyNKAUNZiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjCQORy/yklmyO4rpJfmpSZy0BWSQ0TX7iZSaDzt5cg=;
 b=mTc6PQX5YgDB18TBTNYJnesuaqDohaUYQfhkmSatEfA/g/ldpDUan5giYD6Xg2VB+kEW+FTAcPyi/YU+xYr4kITZvsoMvaM9WgwmM9dNMecqgDEKSllxbYtH7and0/QAjfumJ5wD4iB+MN/ZlTWy32Zlp0Bdy0p3humfaY05urG24hLdb0W1aTEH0ohPMpKNCP3prq1XjO/6wpbcZOhPc5hhSm8X8LnLf2/xWm3wGDxb3zFSalio2kV1/GIx1707YRaS0OGph6zlFgS8X8Dvx04xZ36Ebw93Xur6hP+1ng9KkJO01MkqNobTn5B4vdiPbTaOEaZS/ce4nh/C4Akbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjCQORy/yklmyO4rpJfmpSZy0BWSQ0TX7iZSaDzt5cg=;
 b=nrO7GdqJfAlAm1BMl2Eg24MONz5gUHUbpgpEUfVXAIEd9nK5j5lxSIFE0itu2g63LvJzrDYzCYyx2JjI38JCeUlZ5i1GssjsM9d6LnWKp5YbKbtMjfYU3BTobfk8ej1eTWCPVx0rl4H2KDjGoXCqPD9KWpyhmg9lNP46RFtODbVSFSk3V8SBoRB4Wgj870FTEy4b2LdOY4NftUjWTXBE3ZBdTtbqEDnB24shimeFGSUW3lg0OEJC1MsfoyOpNBI/31/V00Zmcd3Hd6yUvUKYvSPJAxE1BX+aLtM5ffbkTBLBfGrAZCqBNFrQtr5QzQ2dCINcEgQFnRLOpkyE/jvQ+g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10568.namprd02.prod.outlook.com (2603:10b6:208:53b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 15:04:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 15:04:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Topic: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Thread-Index: AQHdBMj4p7vUSbVMmE+fvPgM94V6W7ZPn6qAgAEPDwCAAEG8oA==
Date: Fri, 26 Jun 2026 15:04:00 +0000
Message-ID:
 <SN6PR02MB41571AB004406F331E167203D4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
 <20260625173500.1995481-5-kameroncarr@linux.microsoft.com>
 <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <000801dd055c$2e375050$8aa5f0f0$@linux.microsoft.com>
In-Reply-To: <000801dd055c$2e375050$8aa5f0f0$@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10568:EE_
x-ms-office365-filtering-correlation-id: 43851b75-3a81-4262-b3c7-08ded39427a8
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOF1PXm9A0ZeLXlonzuv4zSh0DPHX/Zagh91CLQP2f/HTrTwwam00EMGvqxY1aol8iTUTG28Fxcc/jCN2wgI15lnDuDzz1/+MzrkQd9XsEhg5v7+rSnYPT6HZagD4Jv8YvRyak3pVRpbRKqUBKSbin52Unv+lssFam353Jf7oQ+djvlssCZNyUt6fA5ihYpZEc49xIPgdbf/uYXTGEW4+enTGfR7zNm6kpyzlkZPyAl3CH8e5aVxNlkB+ts2Pj35tvn9roqB0ZPsfKrfEY9/teerq9ZPbJemhXd5dzz3TtcjVlSOzzRLtFWW5335emp1IyIc6DKibNBhO+2FgtqbmRP9qWptydkJ4yF1k1UCopUg7Ux+5kyBX37qMXSDzvIDuP23+rsLb3FAXjZcftg692IjQ2NSCZSe5YiLZDuoJvy8VwoHQ1SEbzG52KjE9BaSjId+86fIPoHBGkKKTuUZMMETuvmEGVzEgyKaQdcI8tDdbyYTQJ+288GSv6Vc5TnYhbd3Zhy8Zv1vfa2V72HPfX+GrVt9MAhkUEEuojqKEXkoAuhGqiHz/EaUK2NpAEWzEaUM+7FncXHe+becM0aKKvrLNg/DZjbeB0KQB9iIWvo2XqY62B4k+/730mzcSAchKGZyEq6uuCiUQKniTDZsNjClx+apUbuub7dJA255qUzmnyAql7wzTbzJz67wS61bcN/6oCkOe6oBYZjQYOTTqU1FbWzLb95EgKFwcYJdt9rMw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|19101099003|8062599012|37011999003|19110799012|25010399006|8060799015|41001999006|13091999003|51005399006|15080799012|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y/te1Mpm+beqTk+nlaq4tECc24eQ6JrhnUK32OtjUCpLbq4+XK+pmlTp1JfY?=
 =?us-ascii?Q?ezMvcPfF+EcE2ghO3nMwfytKYXCiHUIRWRUJOhfRL8un8TY+XBLwu/H9IFfw?=
 =?us-ascii?Q?+qc/JGddUUqu1PYXZaf6A1kHSdabbzVpUVzJW9tEh7jPNk08V6BJdSZJVvp7?=
 =?us-ascii?Q?zzzNY+0N69mO/vmhQr/GeWkYtWSOOHoIAo+Gm/lK9CdEAbBOkpzc3HcKOECP?=
 =?us-ascii?Q?aDPeojV54Ja21CdCDuqDMKTnU7OB9+wYqozsahBRmJa2nLPX+ly/4d3K/guE?=
 =?us-ascii?Q?6ViogVPjv2oZd1CubegkxxAlIg95fOt+2ORaxGP22ifKTQwGDoyzRRZJuTqC?=
 =?us-ascii?Q?gVvb6pY5BoMTpVcgodaT1lT2qjdDphAc9wswEzjJiTS+8q/FUdewGh3s8+Xu?=
 =?us-ascii?Q?lPl5WEkt/vEFnmk2QB+EhUC4FXb52+7Pav5D2LpSQZol/pqeeqzAfqeyX4DE?=
 =?us-ascii?Q?ybS54LXGmrj5WS4TsjQgxmu8iDkBSAhQYvpOFLbkzPC31WUJ3uC1x5PwyDUM?=
 =?us-ascii?Q?LYhUYJPgmRHCnfDBmcJzRVuK6HYjGRClWbNXP+UWOC3FhqW3b1ORmI4MpM1T?=
 =?us-ascii?Q?CDUoNR7bzD5Uc1JUxSMw4HKGXnwLkFWktWfGBGEGRtCmlmFGNyRYwSiUnTXk?=
 =?us-ascii?Q?kroo7NZc25GzqayszlDbMHD5L0DSyZwTeKGp+EWEjWaIBp42TGssaiFYJwMZ?=
 =?us-ascii?Q?P5A05Cg3B22kwdInQXmQMk1N9pQT4tOMcjOb0TMeY0tCJUzs/sJDJ4Npn0Dw?=
 =?us-ascii?Q?OywvOlIw0n9ns2BZrL6l13lzDFX/hYQuFkxxgCC7ZY3Y6NmUOtiwSWufCbOn?=
 =?us-ascii?Q?5uC2AEd8PXJFL/k4IlJ1UnCSqvildYUQ8CAR5J7jEQ5feturr5HcFwxB403p?=
 =?us-ascii?Q?vhF0dtXUMi+NzM5Solyr/86zXr5deYZ9czIGmpZhhgMWgRFsMfaOGXN7ITxF?=
 =?us-ascii?Q?OJVlcVOUBbcxMJZDpMG5dY6U6sWzt1UPbfeQ04Mh2euPQSQfUO82QK8y0fkB?=
 =?us-ascii?Q?R4HMubUd88M2/PECSB8EmXUiy94VE/ZkveMKMVRcN25VaSbSFTLaOqS3KRqn?=
 =?us-ascii?Q?BQXlSok0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PW72ajV3FVzDi4M7+1qvMYsUn8Dr/ebTquIzDVfjAMBmUGPj26ih9eKCKgaN?=
 =?us-ascii?Q?uoFE1S4eHrzDTnl4hzSnaSiRUjHnLMFGuX9ea1V3DxA19rWMoSCtiUmYUvOv?=
 =?us-ascii?Q?fFnBInJjnpilvUo2Fy8wcRkp0r/vatBZspGVTMCZt9T19V0qJs6+AHvGKVr6?=
 =?us-ascii?Q?XiNOX/Yg8L2lL4BZeZIBZXuH+PoE60AL4EVhyn/y54Tg0sMub4LAnrhHtQLI?=
 =?us-ascii?Q?LjaNDkjsCxgJrkMywNc7aQ65NcesvbnVba9dyVp60j+7GNLp8voglsAaT+I4?=
 =?us-ascii?Q?BKriYPZk7frYXYxJa4mZx9XXyLi5SwDMEs1FOGDXZOqVPRnEiHoS+3XHIRT7?=
 =?us-ascii?Q?zyxiPDyAkIVmAvQ6zVoRZkfcbbIlxLhbFbTYrBLFHzrrPozP+rBEurLSxAr/?=
 =?us-ascii?Q?DB6W5PYTIQaP86MLjMQNlKVz3MSfwhAajG5oeVAGZahITZqdAUkhCnxJ2+7N?=
 =?us-ascii?Q?djoTZlJeqGL6F0rkh2Q6f4MHyPZYsVyDNWmTJT8NjxjkQ11dcbwjbH+uvXT+?=
 =?us-ascii?Q?ksOeF76Mvd40iIjKsdYjoUpEFwkqczmHEJUA/l+qv2SNbVqLdg5f0s4DeFI5?=
 =?us-ascii?Q?X67fsy7CKxk7A1tKbnfljNhQoUMoS7aLy3Ma+Ye91UTB+QszxbCNOKcAkm5+?=
 =?us-ascii?Q?QeTlU6LBY5bN0NwMAWV69cnndbznuU3AtXskRDmFvOK1jP0omT9OeHUE6dIu?=
 =?us-ascii?Q?Zll5l3OxHdTS2VMVvG1Bz3IFfqhrt1kJRGStc6vBZ2+3LaAWE68T3Y9lX6tv?=
 =?us-ascii?Q?9mbtN2GvZZL7uQuBCZPfCXeCpoaGz6vuUGjCXpc1d/a0/KlP2V1yZfrDYpWn?=
 =?us-ascii?Q?1u1G/UEt97dewTWDxTz6MlBsQ8mHt5HbblcXAlYNyNI9aJYa4/npkuvMtNR7?=
 =?us-ascii?Q?JwRU2plysL5GB8qmq29T6Ie9OQllZ0MIGtTNHm2ZuFUSKdTWM4QDg9lJLnZ8?=
 =?us-ascii?Q?pwJZjADtUPf1CeG/UmM4YnAcf7tgIksMsyBPFZVGQir/SiLHQJvRFWWNFPCi?=
 =?us-ascii?Q?WbEhtRO+guuUw0PKdcp9fwEToG+SGv4qyH+EOFErcv0JZcA9q5nILiPCcKeP?=
 =?us-ascii?Q?BNbRCZ+klXq2X6aIjcLPHKREQ3waW9umej+jrENOADtrtKFQwWoXGbgxmcCy?=
 =?us-ascii?Q?65mJHFsi8RKyufcZrSgi87IE2FOooXCaluczVyP07qOJt8bFTGTh7gtaU5km?=
 =?us-ascii?Q?Xq/bta7bpdsc4kzse6Fnq/SzKwAJ2lWuhZp1q7FAHuuDSSjnWWZdTtTRa/4T?=
 =?us-ascii?Q?ZhzRCnx/6N+rW3LYhgocyCu34IccPeO18Wf7For/OA0bCxXQaceM9/+0kN9K?=
 =?us-ascii?Q?cbU7z+J166TPodkliSbKZIxxDHG/7VWOwIguWUONkgt2S8dFvlr7cAKlkFs2?=
 =?us-ascii?Q?c0oXRD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 43851b75-3a81-4262-b3c7-08ded39427a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 15:04:00.7103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10568
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:mhklinux@outlook.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11693-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com,microsoft.com,kernel.org];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:from_mime,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14F816CE515

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Friday, June 26,=
 2026 4:09 AM
>=20
> On Thursday, June 25, 2026 11:59 AM, Michael Kelley wrote:
> > From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday,
> > June 25, 2026 10:35 AM
> > > We need to round up the memory allocated for the input/output pages t=
o
> > > the nearest PAGE_SIZE, since set_memory_decrypted() requires the size=
 to
> > > be a multiple of PAGE_SIZE. This only has an effect on ARM VMs that a=
re
> > > using PAGE_SIZE larger than 4K.
> >
> > I think this change resulted from a Sashiko comment. My understanding i=
s
> > that the ARM CCA architecture only supports CCA guests with 4 KiB page
> > size. Is that still the case, or has that restriction been lifted in a =
later version
> > of the architecture? I'm in favor of handling the larger page sizes, if=
 only for
> > future proofing. But I wondered whether your intent is to always suppor=
t
> > > 4 KiB page sizes even if CCA doesn't support them now. Another way to
> > put it: In reviewing code, should I flag issues related to page sizes >=
 4 KiB?
>=20
> I think you might be right. I'm looking at RMM spec 2.0 beta 2, and the R=
MI
> can have granule size 4KB, 16KB, 64KB, but the RSI is restricted to granu=
le size
> 4KB.
>=20
> I'm open to suggestion on best way to move forward.

The best approach probably depends on whether the 4 KiB restriction is
likely to be lifted in a future version of the CCA architecture, and I don'=
t have
any insight into that.

If it is likely to be lifted, then doing the initial implementation to supp=
ort
larger page sizes probably makes sense (which is what you've done here).
It's less work than going back and adding later. But the commit message
and/or code comments should indicate that the larger page size support
is future-proofing work, so that someone doesn't get the wrong idea that
it should work with larger page sizes now.

The alternate approach is to not do any larger page size support now,
and to explicitly state that the code is assuming the current restriction
of 4 KiB page size only.

Whichever approach is chosen should be used consistently so there's
not a mishmash.

>=20
> > > @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
> > >  		}
> > >
> > >  		if (!ms_hyperv.paravisor_present &&
> > > -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> > > -			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
> > > +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> > > +		     hv_isolation_type_cca())) {
> > > +			ret =3D set_memory_decrypted((unsigned long)kasan_reset_tag(mem),
> > > +				alloc_size >> PAGE_SHIFT);
> >
> > I don't know enough about KASAN or the tag situation on ARM64
> > to comment on this change. But this same sequence of allocating
> > memory and then decrypting it occurs in other places in Hyper-V
> > code. It seems like those places would also need the same
> > kasan_reset_tag() call.
>=20
> I'm not sure of the exact behavior of PAGE_END when there are
> KASAN tags, but it looks like tags could mess with the address
> comparison.
>=20
> I do see that __virt_to_phys_nodebug() and virt_addr_valid() in
> arch/arm64/include/asm/memory.h both reset tags before calling
> __is_lm_address().
>=20
> If there are many calls that follow this pattern, it may be better to
> add the tag reset in __set_memory_enc_dec().

I had the same thought.

>=20
> I can undo this change.
>=20

Unfortunately, I don't know whether undoing it is right or not. I
haven't taken the time to go learn about the whole scheme and its
implications.

Michael

