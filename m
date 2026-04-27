Return-Path: <linux-hyperv+bounces-10382-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N3IAGL27mnT2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10382-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:38:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350646D43B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30A013002A06
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 05:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16EB27AC4D;
	Mon, 27 Apr 2026 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Keo/XI+u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010074.outbound.protection.outlook.com [52.103.2.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34E40DFA5;
	Mon, 27 Apr 2026 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268319; cv=fail; b=W6Z3x6DtqIfhNBxKG73ofr59DlZMYKhWWLA5r6MFNKnA+mWR5xijxB0LFNtc+1y9OkvHs9dRLKGnJ7JLx7Jnzk5qDEfESCN5wumKDKI/HphUJUB4BJ0JmWIjd3c3MH6xJgVAobIf1MTHSWp2JaM6OnSXr2IRBMIWX7mKUyt4AtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268319; c=relaxed/simple;
	bh=nsexESQFzzuQIUeMVEGsVW+ovf7eJs2NQMo2bY/PjYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vx3zr8q4zsV3+Dcx3jocMHEzxFuyEIlnHq5WMgQ9L5ykkAc0ZO2e713Bg2tRvGHFqsqieTOxbw6C+fA1OTuZVP+jjrYzjd18mJff+FKpQjiWJEZLC9lDpsilD39tnbWbjPFpulX5l59Tsx6gfd4O9i5lZp5t/ymvkKE1oJ076C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Keo/XI+u; arc=fail smtp.client-ip=52.103.2.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI7c7BL/cql87GbK93AlsI2ALnjn85aZcFqWbtu/j65TzMJ4vAB/pT2TtlW9zua5eTaaYkHv7oKE/uR4sjRsd9gM8cO053/l7a8WjVPjuCXAXo3I+ukb/1PWMvN5SnuF+T1ollJ1DxiQ0ftViHe42Vhm41u8rdY+gRQIv08AG7aYC+TQov0PoDGZs91bn+YqOXl4j2x//9ShslWcJ8Uh2gIO1fqvvr2k9o5SFNMbbE1ghBJeD/T2DcqrB1bPg/edHayWkBv5q3HwC+Gdc52xyw4t4flxG8uH1OMMM/afnKs049d8gC98BRi/hc0ijkBurHKGpYOM6J2iok8n6VnZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyCkDfl2b4CE7cMiZKoCxrcBKGyTdycTXlQWTkCvXDU=;
 b=K8mRYdZ7BL93PdjwaeSgP862qUuBPf/GNQkUFGrIsSRsHqCNI7Ss6RH8CeuDZwB9NhkTyXzb5VEyyyWGRytA+7vhlkbmZrcKIklpCue45/r+Wwo26TX06ahRj49B3MSxCsuOZltZ4DBsWRhRJbARXVW+BUCfOpZ37aWs+iFDu+WG1qvGjJtLr6wRZGUKyUUwxOk5KibQkLyM/OTsbBoStHwhd6ym3HKPt3IPOrLB3q/okzH9Q4vTkgf7v4ZYTRcdo+M8BsTXfk7aPg/RxhPcymArDe1TQMpjkqR5DljB3hIAqXpu086mWTmH5tlLoT1PDVEJCWl7+aw9Be4AgkSm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyCkDfl2b4CE7cMiZKoCxrcBKGyTdycTXlQWTkCvXDU=;
 b=Keo/XI+uJFFBX3nBEh77Uio3hC+1+lTEdRpZEvaF7iOeay4AWfTDTsBDmr1QkPKUf8FnBBaSOyS9nqKimePAIOku6vvt5PUF9O5gP/0OvzLbPvTR0dmJcM0nrPC68IgeSYySqlH2jjyO0IwcIk2mkJbVRAhnfQqmdZ9BuoWl0FZSiK6POwN7tnK+zHbADWcvu2LXn8Qc7Y5UXkkPY8OrDiVymJcxM3w/VhH+i7RVv2dlUjM8YrZauVljuZ7TaKvnil+sV5gEJjfacJzIaY5iECcpHDMpGxmksWwU62AT5UxLABjUTJGRPCabreeP8y9Slj0bjgR1bANJ+0CgHzGznA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7809.namprd02.prod.outlook.com (2603:10b6:303:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:38:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 05:38:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Michael Kelley
	<mhklinux@outlook.com>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sascha Bischoff
	<sascha.bischoff@arm.com>, mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "vdso@mailbox.org" <vdso@mailbox.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
Subject: RE: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
Thread-Topic: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
Thread-Index: AQHc0x7Gd+InXWMHLEisx/6viGrEn7Xyae9Q
Date: Mon, 27 Apr 2026 05:38:35 +0000
Message-ID:
 <SN6PR02MB4157C147A1B915F9B45D3B74D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-8-namjain@linux.microsoft.com>
In-Reply-To: <20260423124206.2410879-8-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7809:EE_
x-ms-office365-filtering-correlation-id: 427b9deb-6a6d-4a75-928d-08dea41f39b6
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|51005399006|55001999006|16051099003|37011999003|13091999003|19101099003|461199028|41001999006|31061999003|19110799012|15080799012|8062599012|8060799015|13041999003|40105399003|440099028|3412199025|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HTaDs4IlpRGQ0gWQKq4/r/XpgVoShUGVwedrjshdgPo7N1kcH3WUAGXLnku+?=
 =?us-ascii?Q?Ujz0S3Q6S7uFavBt6K/iVueK+CbSJAxhr/snxdTUYUFL4rew9FxQRnxi76k6?=
 =?us-ascii?Q?W50w/0Mm2Za43GIVB0623npYAXFzRDN5aAe9NBVG3oVV2kyuPByPI7ZBAEKX?=
 =?us-ascii?Q?3pqGr2LnUxs8KEJ/kZSYYKVxK7h/nQWdO24FmngX7XxMP6F+cWaEsjzuJ9yw?=
 =?us-ascii?Q?3z7wzdxqQ38hqJt5x1sIPtq92te8ZC0Gb3gNlTKH7SlSWHFhLlZSUA5zln9+?=
 =?us-ascii?Q?VJ541V08uaBsBSKZBIQG2zw2nddRBQSKPwT7jJQc/hDs3/jHOQzpyHRoQM4s?=
 =?us-ascii?Q?A4MSJP9pS3wC5Lt9ef+COuXgzx+qqk5pOUz4S54uCPJM8mqVS8+A0qAraLd7?=
 =?us-ascii?Q?6zuvECOdc31Vo3rPB7o37bijgmbM1sypuGSTFM+ivVjKLt94Mr/GtMpQI4O0?=
 =?us-ascii?Q?aGraT+OQs7T8buvcDCeovMIaFiWxRYdyKrJEaN+BSdu7LPFiNItubgfdk+KU?=
 =?us-ascii?Q?1aRUjCbMAhBXoSLY4fuu8YsNpGBN4PtdWb4m/N8dGQrf89FOo2YZkuFSzUEz?=
 =?us-ascii?Q?6X6TaKwX7rs0LRjjVFccijbv5uwyRTKIQho3CQdiIJwoj1Kqm5CmIYpOUcB1?=
 =?us-ascii?Q?Az7rCuYp1fwihuDLMGHuFx8sxO69LsZE+LttQb7vnMuPj6HLckaoLdyDuAnM?=
 =?us-ascii?Q?swaptmLFUTgGCLm98CORUntjUnM+4R1RxgNoL8box5sFTUnRX8o7gae9x4GR?=
 =?us-ascii?Q?vYdOp2vXdCvVnsEOVhXaVqJmOaHGO1S2mAoZqBiBNLOmHSNuBxfLSXTjgqFw?=
 =?us-ascii?Q?05lgJ+HepU4fw8+OWU7NKazBasPiwq3NBrPqn+ORxtRgmR1623tDsEnALESW?=
 =?us-ascii?Q?4i0TV54AcmkB+b7nDiy3aa46tBPDaHrjgi/hk4yju458+dDqlq3zFAfZZ9CD?=
 =?us-ascii?Q?QNTGS4AsvgxhXxProSDcixuJ82aRO4vNgW/5sEt7nZt0UtTivWulKzIYD4W8?=
 =?us-ascii?Q?PvjUO24G+L72Wj8NexU0Z51cNlcQsI4t/mEuDxhgau6BYoYycO2DafmfVYA7?=
 =?us-ascii?Q?XxKsn/Nmaswo0M9FVKWec6V/f+o/F8Xe6+B4RiRx5I0CW5rR6Kx5BtTer7Ii?=
 =?us-ascii?Q?AmlFy4Ox+7iMrVTOyMUeBMG3KrnGRkyg/5CPGZKMv+fdTLPhuelp8E9NIscB?=
 =?us-ascii?Q?IpPFO2hMbwvWowtf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hmOzlxiJFtWUscWH1pAlqyP47v5k5qUZHtEqT6wpHCaX2Ru4J6qtVBSZivUu?=
 =?us-ascii?Q?45lsA3mq8GJItzNgG2fO4rAUEG2DyHX0RPgC0zfcQaJ9+idv3yBoeuna3C2a?=
 =?us-ascii?Q?2haoDfB4Z78ajH7rp5gkT1A8SUmevxG1F4T0qYMnCDsD6fc4GW2fycs4Yp1t?=
 =?us-ascii?Q?VKziqPeI7Q+HzfC7+a4bM/dKckEQtnIdA87CZBueIrWHXOW+Oa1xDcmumsmj?=
 =?us-ascii?Q?0tn9rD97vqvEgD/RprHVfNWDe07k6O+ful+eevN6duNzpKXgieWgBae9jz7M?=
 =?us-ascii?Q?EKp00xFIEN60PmsPC/8cDpljJQwOllWrZlW6epFiyq2NlaCaS+t4z4249rff?=
 =?us-ascii?Q?InuzWecz+pRcCfRaTYpPQGmSi9FItdD9MmpTgi+259//3J17PwnbcKqccy+r?=
 =?us-ascii?Q?fzu4/MA/42aoQk4VlZfyrfhh8LtBaGpmusSarvsv4/Ip6KVz6sW59NnU2H1U?=
 =?us-ascii?Q?PIXe6dh5Yis+P+mPOaKRxMte4gBm/q7tl9NbKfBe1MHjFjU96iW3DfyDaFeY?=
 =?us-ascii?Q?3OARDpk+uNTSIhrhvm9jHdCgbK/MpA3WO8lwyQ6s4aOnceJropjGOLrwUBTB?=
 =?us-ascii?Q?nHjgVqmDDFY/GoXuTGRdFxrp3KSFN45F8p/KuezBmApx0uHWle0qUjVQlX8s?=
 =?us-ascii?Q?hA7yc65P8gpOtznYUQ5jmXOZV5Ylga2Ns/tkCltposdxnz/UO2Ogx8jsTx6n?=
 =?us-ascii?Q?YMhJKG4KLPELE4bdqZ8/x8WnU9QUGzJUzXM+B23AXTi+K3xmIGtlc7z3NPRP?=
 =?us-ascii?Q?YYnyBIJL82SLM7AgeVA4YXhLPX8GuK6yrzVaUisP8MkAkg1q+E6u1Ycvk5TQ?=
 =?us-ascii?Q?yS7v9JwEuJRmpjDaNaX+2wBq2Yr93E3S49wMWSzb8s+bnTrAqnteRE3qJa21?=
 =?us-ascii?Q?739se0AhQd6cC+bPWlchSWxINgVzQJ2yny4/9IatlrPWyR2ufv912/PMnTkB?=
 =?us-ascii?Q?BStsA/2SfpVD/Vvl0gTiAXrva/sKF1SEWXuQuiSmdeZN9dRWTDvft2rbZxqp?=
 =?us-ascii?Q?KnEwJXTHEBMPnCX+8X2gt4PL8V7sjhgn4VUICDyFNoSsJVXPkUpPpY487xZn?=
 =?us-ascii?Q?Mf9E95Uga97QqLOSer4DfKAjyvpqSZZqKQHoekzdKgfsCuPd4rspBS+H4kIE?=
 =?us-ascii?Q?MKchvzuhRVbNV3f4pzy548rBlDNEgg+wdlnIkt4mpeEcBezT6SlR+Xb9KtSi?=
 =?us-ascii?Q?VRvhBx5VvRtsFaZ5wvo1VTihroNNoa+6M2ybzaIayLGB9tA08K0A6EXEa0go?=
 =?us-ascii?Q?AD0U3zg7yD/8P8XuQSVv5M0rd1Wrh5pakZzSkFtRmUI18rYikw2g1K0dinhJ?=
 =?us-ascii?Q?rSF7vu3TJZdINp2NgPPF96Gd6YHVqOw8bLxLahN9KgyGY6M+cu4Lz0WM4ubI?=
 =?us-ascii?Q?oChAbr8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 427b9deb-6a6d-4a75-928d-08dea41f39b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 05:38:35.1978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7809
X-Rspamd-Queue-Id: 7350646D43B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10382-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 20=
26 5:42 AM
>=20
> Add the arm64 variant of mshv_vtl_return_call() to support the MSHV_VTL
> driver on arm64. This function enables the transition between Virtual
> Trust Levels (VTLs) in MSHV_VTL when the kernel acts as a paravisor.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Roman Kisel <vdso@mailbox.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile        |   1 +
>  arch/arm64/hyperv/hv_vtl.c        | 158 ++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h |  13 +++
>  arch/x86/include/asm/mshyperv.h   |   2 -
>  drivers/hv/mshv_vtl.h             |   3 +
>  include/asm-generic/mshyperv.h    |   2 +
>  6 files changed, 177 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
>

[snip]

> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/m=
shyperv.h
> index 585b23a26f1b..9eb0e5999f29 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -60,6 +60,18 @@ static inline u64 hv_get_non_nested_msr(unsigned int r=
eg)
>  				ARM_SMCCC_SMC_64,		\
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
> +
> +struct mshv_vtl_cpu_context {
> +/*
> + * x18 is managed by the hypervisor. It won't be reloaded from this arra=
y.
> + * It is included here for convenience in array indexing.
> + * 'rsvd' field serves as alignment padding so q[] starts at offset 32*8=
=3D256.
> + */
> +	__u64 x[31];
> +	__u64 rsvd;
> +	__uint128_t q[32];
> +};
> +
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  /*
>   * Get/Set the register. If the function returns `1`, that must be done =
via
> @@ -69,6 +81,7 @@ static inline int hv_vtl_get_set_reg(struct hv_register=
_assoc *regs,
> bool set, b
>  {
>  	return 1;
>  }
> +

This appears to be a spurious blank line being added since there
are no other changes in the vicinity.

>  #endif
>=20
>  #include <asm-generic/mshyperv.h>
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 08278547b84c..b4d80c9a673a 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -286,7 +286,6 @@ struct mshv_vtl_cpu_context {
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  void __init hv_vtl_init_platform(void);
>  int __init hv_vtl_early_init(void);
> -void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>  void mshv_vtl_return_call_init(u64 vtl_return_offset);
>  void mshv_vtl_return_hypercall(void);
>  void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
> @@ -294,7 +293,6 @@ int hv_vtl_get_set_reg(struct hv_register_assoc *regs=
, bool set,
> bool shared);
>  #else
>  static inline void __init hv_vtl_init_platform(void) {}
>  static inline int __init hv_vtl_early_init(void) { return 0; }
> -static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl=
0) {}
>  static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
>  static inline void mshv_vtl_return_hypercall(void) {}
>  static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *v=
tl0) {}
> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
> index a6eea52f7aa2..103f07371f3f 100644
> --- a/drivers/hv/mshv_vtl.h
> +++ b/drivers/hv/mshv_vtl.h
> @@ -22,4 +22,7 @@ struct mshv_vtl_run {
>  	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
>  };
>=20
> +static_assert(sizeof(struct mshv_vtl_cpu_context) <=3D 1024,
> +	      "struct mshv_vtl_cpu_context exceeds reserved space in struct
> mshv_vtl_run");
> +
>  #endif /* _MSHV_VTL_H */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index db183c8cfb95..8cdf2a9fbdfb 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -396,8 +396,10 @@ static inline int hv_deposit_memory(u64 partition_id=
, u64 status)
>=20
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  u8 __init get_vtl(void);
> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>  #else
>  static inline u8 get_vtl(void) { return 0; }
> +static inline void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl=
0) {}

Is this stub needed? Maybe I missed something, but it looks to me like none
of the code that calls this gets built unless CONFIG_HYPERV_VTL_MODE is set=
.
See further comments about stubs in Patch 8 of this series.

>  #endif
>=20
>  #endif
> --
> 2.43.0
>=20


