Return-Path: <linux-hyperv+bounces-11686-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PilZHvJxPWrw3AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11686-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:22:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781486C82B9
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 20:22:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=ayqyF0N+;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11686-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11686-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E7A93001CDB
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B730EF97;
	Thu, 25 Jun 2026 18:22:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010004.outbound.protection.outlook.com [52.103.13.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81253115A2;
	Thu, 25 Jun 2026 18:22:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411745; cv=fail; b=EV4Pgo3SoV6sloEisZQQbZe/Sd2S9/AEhB60Dh1/ngqAohVViEjoa/x1r3FDSM2Trq8gA6/pirM5/GLJVX4d1nudafWse9rcgUn4EBiaKT77+a8/nIlBaR8hmDvN8ald7uIORcXkEkCdcGUW+2+MB4fhrUHvsFaLoPMjbZDX8yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411745; c=relaxed/simple;
	bh=A4FxQ8KnGub9dAa15BF1h61iJ56yGHgbwuqRdz/Ef94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2cIT5nUFwipwqSawYbwdZe/xzmIpIiqjn62avYdQ4aDubHnlZi2xN2WUxvAODdFqeyq/R0tRz2HSc6n2/zQ2QIwUIkcMS3T2zA5GOMS34keEAqcmK0e8JxbeV+mniphFqhZqya6tCM9O7aTMIzGFx9sAQpmXil4H+/TCSqD5c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ayqyF0N+; arc=fail smtp.client-ip=52.103.13.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJ4IryeZaiTsfHkQHwwltItOJsrZQ0fKUQiFRV+UGeIxrMD7iM0W2S2hJr3U3aIjFwoLH07/Ty+Hnk1+bpXi4++/fIiuir4UvFmIXVOGo1NVI88bHRuwHjPDna4qRNE8FN+nw10pDpP8oGSNJ3Zkqt2gS8bEOaFoC8UYiALE6xJJBJ8im3PO/VpE/Q7scZvfIprvlw5XmNz1S296meB/kW01RtuB1CPlWmvnNDnVgLKf/7TomEkmTPvT7Il1aljDQdonABOVWigGdqoF8lDg0O5pFKQBzEkgSk8X9OUQ7PZ8tHt1MZXQlCuKe56S55X+0V7iGJa14W2SKgdrxj5hUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Uo6T3DyV1Bn5zCYZIg7iNo7nX/8Ez0QlIA1Nbv21iM=;
 b=O1VxRJEasFFp93EcToMHwon6Ut6pCU9o1VRoffN65FhZCGDU1mfcPxq+9t6JJuqyCJIujttduNQe2lw1CzgOiFBA8m1MjBIn7zExowmGwDrqjeNz1/xnkcSFsy1EOADtcKk1/5YrpAuz485G4FQXBMKTe/lqvTdlAnoFtbnihEaVvZ3llWMBuoKrOBjCIOKSROfueTELhwBY+xCvI2Fojdnjmvkv6rP42YlKVk7Dj+2gtyXJm+LRW1jpdeAC88theL+rD5OAIGI4MJqzaTEDXyZj8Nr+KXFQe973H5TTAfIIoqU54e2GFtBBwSLiHH+vbK61epXlr5aYwtJmvHt3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Uo6T3DyV1Bn5zCYZIg7iNo7nX/8Ez0QlIA1Nbv21iM=;
 b=ayqyF0N+9COh5dMLJgz2MV326De1kImgcec+S2EBre5QeJzmhO07PwmBeBrzW4T9UXphlIReUjgFxqq1q4S1AUBRkOG19x3XhCAxHhJokmNIGbEC31vQo7KSwyV6EvUsXX4Bp1ax+2Lo1PWZt9UX+RYf4heWbeDIUtZv5tJyxuAlYLUR0rJqizTbbyoHetCHx2mu8XY++0nVw5wGQQ0G56hY3rXHA4Pu45LvNFRQ+RtkL9Bl54soZ3EcJwWLswE7mi0/QpssYKnSI1LyDAa/ia11HARXoUj+aZ0hIc8MRIrByTiGQ1KKEm8wyC09LpmtX3/i4Q1B3uSfcUBYHixzuw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7845.namprd02.prod.outlook.com (2603:10b6:510:53::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 18:22:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 18:22:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mshv_vtl: clear hypercall output before copyout
Thread-Topic: [PATCH v2] mshv_vtl: clear hypercall output before copyout
Thread-Index: AQHdBM56ZD0yw0L6SkGhQbRGpD0zILZPlNfA
Date: Thu, 25 Jun 2026 18:22:06 +0000
Message-ID:
 <SN6PR02MB4157E7169B0FECD97C9EA7A8D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260624172157.2790-1-alhouseenyousef@gmail.com>
 <20260625181314.1399-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260625181314.1399-1-alhouseenyousef@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7845:EE_
x-ms-office365-filtering-correlation-id: 9afe768d-8517-43ce-4524-08ded2e6a9ee
x-ms-exchange-slblob-mailprops:
 AlkLxVwsndm0VyxXF8Qt58maZsxVls0a/dg3SoViazO6aFF/2SaFUrhY0CaNUXD9i+nrWFH6UNmBfKb0jOp95U0hk/pzUSyGUTCSFOGcaAMKQZnteB5YNWzPdQd45iBGmbvF5xjdJ3iTzQIiv5komjVeS4QXNujjUynNOT3Y2SF05LM3lsegA50W902bnR3o+1DE0xF2CpULogpwLC33QS7sH14Z3ODo++DkyaeB3dPns3AtVUQBY9kkRKfvLUKPR0enTrti724QQIwq5A2wZP7HriX3Ts/eHNR4aA6LFmsuXmdBwecqzmD5kjToG1ez4gssbnpxZQ64V90z6GppC6wy/n3NYMoSJO18s6Co1hVxVr1Savbm4eL2ZbazYiDQQyhp8Uxe/KrKooLFOEd27eQyqhYvEvjqOljq3CT51x8DDPyDQjEXpMqqLl9uGAXZO5ilMH1ctu3QL6UKrRE+J6uaCOHIgajxiF/wqcOR7UkGGdoFCOspbOAaFr/KgyOHJmxxQj6FDir6x3LAE6C8Zc652FKos9xfu8i49e2OfRsPmLM8jsoOgITW4Vr0qtMZUmrxUGeFSjTMFUUbZ4PZdVDEqqVe7S8kppKfVqpIXEkNX78pcewFaLJ1tYeFJ+Sv+RsYECEy1SzlYRp8gV9Mqb9s+Pl9BtQANiUoyvA40HDfgvL0NN8B9ktojyTXtESqvTtVy2/wjxhfBrWAgeCScjdx/rLR5m23B30Ziw/DBsvQGU5cqYTQZmRLlRfR7rjtiB2PwAi746FHP5p/o26rW8pv8Bf9B2kI
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|25010399006|19101099003|8060799015|13091999003|37011999003|31061999003|15080799012|12121999013|51005399006|3412199025|4302099013|1602099012|102099032|440099028|40105399003|10035399007|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?A+hT7MkRBWh9vxeTV3BTrsn2WvdXl1Etwz9DmH8KN60xvL4kGgf6vDqBG1v9?=
 =?us-ascii?Q?LP4dRozGhmBxRIs7+TPqrZVK4haLkyH+T2Gr3X8yVj2dqKt8EnVoB+6tA78g?=
 =?us-ascii?Q?nqInQPhz+i6UcuXeiuMJbyuyLoo3ZCa2vIjjCpcJHfX6ZFn5OVa8uPfn3ZIj?=
 =?us-ascii?Q?/8PBJalCbOSoZPQQGAxSF2+YFqJIe22uQIcb5q4jZXhaHnn3e1phPx3843RV?=
 =?us-ascii?Q?L12djkt7sXcE9C0fWP3lzjVT5F2JVH0GxL337fNywu2duPa8lJvKR8JwcgOo?=
 =?us-ascii?Q?svDWsP+P13qgkb21fFEcdZHH0AkujPmSVa0x0LAl+sjtULNjhI1RmifH6dSd?=
 =?us-ascii?Q?JVAVBuY00lLsMDp+1uff2B/FIt8FeLvqtmAmdTgQLnsMAfuGqnSVw/BXUTKf?=
 =?us-ascii?Q?t5XXGyVWO2cP981Mgveru9EZHjfsAlX3zCl6xOV28sdIUDliOFBmYmcikk4o?=
 =?us-ascii?Q?sPEmWlkL/AdAXVZP+0SniAKHugQHtjG1zpNi6NeuGIxF+SWo1YphdFhgj5iH?=
 =?us-ascii?Q?YRGT7c8LH+BISgyB7QNKxN35/s5PovQkNK7FfLYdXbPAZ+Lxs7Prb3NHHKda?=
 =?us-ascii?Q?bFMo4VGswQNc053qbMcufMHqEZKAW6CvjowxDpY296i1A/eORf+KXobULhB7?=
 =?us-ascii?Q?ICWyoKVAcIRx8qW65aX7J2ggIil4NCy9QGlAj8h72R5eSLIaG+XU8ujRLKXa?=
 =?us-ascii?Q?Wq2zZn5YGgE94LuteIKITA8Iv+pyThsukO42atVP7rmnRcyWSKSYFlAQBNfp?=
 =?us-ascii?Q?YqSQq4K1YvABRWSWKs+K/srAWDVyMQxOkCgaT7roJAiVduI7weIUValqbQjd?=
 =?us-ascii?Q?gwrWo84TehsuGl4zzRav37jMTlZBp675VR4aOkCTiZOXEaQy+sSKFR/ktYBr?=
 =?us-ascii?Q?71ekQqu4nNPYieWLaC1Sr7UgxUa46+jvFrkQT4flXDHqOsc5zsD06KoKb7uv?=
 =?us-ascii?Q?mXCneETtIHczZ2SDUmlBxLhzREoBINvyZArgfl2EdSo9rQjIpm5ewkhoQi5h?=
 =?us-ascii?Q?d4Q59v3gqSm9+DyojoHaJYM0K+oL81iXAHD/7Nq0C/fzzxYiFFKa1dGpizma?=
 =?us-ascii?Q?QNrN7GNzxUatXHMwA/cIwB2T9iY/T4iPtqBf9F6Ey4yVkgGRUGWho/3fQR0s?=
 =?us-ascii?Q?/gKq7Z8CaZS74PviCRlxArmunND9pnbxW1uZEU6swY8Mrmq/XqxOJPc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BPJek3+K8EAve8WTSTIvUGroOZFooPMuwtfUoHxxot9rJ5AsG9p5zp6SFT+B?=
 =?us-ascii?Q?EDStoZkRl0zzTNx7cfGs8lTQvaYAVlrRn3rn6n/ub6kA3axbd8l2C6blc/PH?=
 =?us-ascii?Q?q1IQsnfb7/NNHZsq0lIHv/nKg5kA98GWoH2K2WvtW5tOKqHraTyzAMQ6ro+a?=
 =?us-ascii?Q?+Ra1qUeRYreU7G8xQdQbPS7ZtzywUKfVCKL9JPcP/vxNLqGoGakJdU7rDdYj?=
 =?us-ascii?Q?UiwoznyMTfNADSZX+fE6tjIJbREhJuWTG3jcxRdh3wJdqPpZwYjfWpiZzr5E?=
 =?us-ascii?Q?X2TcfSigfYO7TvKRz4/s9p1/ShmQu7aDJRTjnMIAc1x07Lw+ToS64YeRlcSC?=
 =?us-ascii?Q?3W+37v7OmoZbs/WFrM6VoHS46xzXeMr9xF8OPAgC2SN3WzwBeG5iEaUPKREH?=
 =?us-ascii?Q?dcZfm/u9QKukSaBp/nuZFiROWvc8GGo2kU6fru1IVdwXzUPUN1Eh3lwk7PtX?=
 =?us-ascii?Q?TbQ1IR8uG0RMIKUcyNsHGzCYY8M7EESUPsCUkwc/rVVwBCJbrjbIIf1qXZA3?=
 =?us-ascii?Q?BpCV82bor/vaZkbBkCA7/46BdbcWxiKBdkyBa5BHgxtml+9FrNWa++dkndn6?=
 =?us-ascii?Q?rc6gBKVXBF30gxHLDxbX300ZlxDCjc806CdrFqDiy++saxMY0s3ZYY2Xfo5b?=
 =?us-ascii?Q?jaiDCv6tbYMQ50QiT4oqP1t0kmv3hWImBvtCrfiUi9ay6P0HYt0OBBcn0vHW?=
 =?us-ascii?Q?Q31asCgMMRPUw5BUjsDqg1LnK+iOGO8ImREgwv96PBaKU3nPLeycchg74r3b?=
 =?us-ascii?Q?7NU1TCR2ufoFrp0U5esVWP84w3fyqReadGSqG4Pmhm/OLnKqTzChRwf7zvfT?=
 =?us-ascii?Q?SJ3XkJP2Xgs5+4OFgiEa75ZcYAGv3r/EHmOqKa/Wl5SsZp7PReCpQiBV0USt?=
 =?us-ascii?Q?ZEOpOfd6aRwWIjzLdsKkW1snpH1uUDeGD8BWZ9Vee9uANGjtQLL771GmFBXw?=
 =?us-ascii?Q?8KjHFPNEB6ZNVZ4lkng53baD4vidmPzM6pX8T9JBZmEamUQwYwjpyH4dcPfM?=
 =?us-ascii?Q?VpIx1Dtowcw2kxVTmwArFG+TeScN1Lj5JwZeMzidXK/nlXoF1T3DP/S++PgK?=
 =?us-ascii?Q?eeYFy+I1P+4HhkU9k9HvRw0NYYXiekWs5/Kon/ouIZxfh2eoZdtrkHSBoiCY?=
 =?us-ascii?Q?N1W/kYntlB9G4hDff3PD1kp5CERjX0urXYxkzgAduWsn0KqhRIMsOEMBH4u3?=
 =?us-ascii?Q?Gjow43kmq+L4LQYnlYRC3y19dBWV0w2zXugpbapDlyJOIgFR4Y0Hn3H7EF7g?=
 =?us-ascii?Q?cBNigOdwQnxliHUmhhSppnDUhvEFWqoBo4ooJYukBBjPEnIxbVki2HF5ZyE2?=
 =?us-ascii?Q?k+MNio2/aCubHxoiCgX9Iv/3GQBdtkhmCq9MlfgXY2M+0FGyTGdQvGYWXFjM?=
 =?us-ascii?Q?v+OmG20=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afe768d-8517-43ce-4524-08ded2e6a9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 18:22:06.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7845
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11686-lists,linux-hyperv=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 781486C82B9

From: Yousef Alhouseen <alhouseenyousef@gmail.com> Sent: Thursday, June 25,=
 2026 11:13 AM
>=20
> mshv_vtl_hvcall_call() copies output_size bytes to userspace.
>=20
> The output page is freshly allocated. Userspace chooses the copyout lengt=
h.
>=20
> If the hypercall writes less, the tail can contain stale page data.
>=20
> Clear the copied range before issuing the hypercall.
>=20
> Also check both bounce page allocations before either page is used.
>=20
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v2:
> - Use the mshv_vtl subject prefix.
> - Clear only the requested output byte range instead of the whole page.
> - Add a comment explaining why the output range is cleared.
> - Keep free_page() calls unconditional.
> - v1: https://lore.kernel.org/all/20260624172157.2790-1-alhouseenyousef@g=
mail.com/=20
>=20
>  drivers/hv/mshv_vtl_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d41619..dbf03b667 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -1148,12 +1148,22 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_h=
vcall_fd *fd,
>  	 */
>  	in =3D (void *)__get_free_page(GFP_KERNEL);
>  	out =3D (void *)__get_free_page(GFP_KERNEL);
> +	if (!in || !out) {
> +		ret =3D -ENOMEM;
> +		goto free_pages;
> +	}
>=20
>  	if (copy_from_user(in, (void __user *)hvcall.input_ptr, hvcall.input_si=
ze)) {
>  		ret =3D -EFAULT;
>  		goto free_pages;
>  	}
>=20
> +	/*
> +	 * The caller supplies output_size, so clear the range copied back to
> +	 * userspace in case the hypercall writes fewer bytes than requested.
> +	 */
> +	memset(out, 0, hvcall.output_size);
> +
>  	hvcall.status =3D hv_do_hypercall(hvcall.control, in, out);
>=20
>  	if (copy_to_user((void __user *)hvcall.output_ptr, out, hvcall.output_s=
ize)) {
> --
> 2.54.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

