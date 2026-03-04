Return-Path: <linux-hyperv+bounces-9136-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPCSJg1+qGluvAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9136-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 19:46:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1600D206976
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 19:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 578B6300F7BD
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5879F3D75C4;
	Wed,  4 Mar 2026 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kj6e3H40"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010004.outbound.protection.outlook.com [52.103.12.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD223D75B5;
	Wed,  4 Mar 2026 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649920; cv=fail; b=b/dWLF1Z5ncGdFNlgWPZPsvS8qeF9I8hNBeYMNPYIqEDVUIhdTZYHPNLKHb2y12xb7yHGwH0ye4Laz5W7eH5IZXG+P+AylAE/QIPKKUSSdJ06dlNyBjq0xv/C8GZf+TuSgOdutq0b1d35IkcB7/oiEWC2cG5F9MseUQ9H5f7LvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649920; c=relaxed/simple;
	bh=EkzaaHX/AHxY896u0/lUfTkgeuyM8MyLOfqkUEWizZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u0azKxGJ+sIoDxsJ9zeHbzHTpI07X7CjptlF2Zr9JAcTU8nWRgBIX9QHCLhAQ7tTJOiMfiRxSrGZN9y5VSx62GfmcLzbt82B0n1cf8cPeHhdGhBf9hHqzw6Jvi/uOqyKwPVUK428CPZ1UT2tP4Z8D8L7NmjIcTBtMWCQoEy/g3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kj6e3H40; arc=fail smtp.client-ip=52.103.12.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBL9kZFe9v/ERATgMcWpJoWIZSI5mhwCsmJ2f521AoNhwH/MMPhNsM2r2Gkj4s6KcWRcfPxGA02A8zCOWg4pXcJohRfT90GPd1eZVz4bPyeup2EPPOkw4PncobZQEuLr2blOkJ2rQio1gDyP35vab4xfX7cN6Fp9Ls/dr3nILwuNIfhGxqRBPjdNKCB7gKg1EK0dVqQsJPi+Y9BV9e53rahX7ND1SrhQd+aC/OEElKY/eVH7DepR59hDqouTAq6/9s1LzvQhIW2ml4+nG42oj6RNvIK1R2uJt3vG1T2nfPicFUalQ+DhV4qeDOoEFVwPHBD6yt5+TwZh4wrGvBpKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXMi0OsjSHVzgpNtDr9lHhNyAtguHT56MqHkSVE6buw=;
 b=XE94xISwQFh3DuKnqrzhiwaV2EyO4B4vLKeouh65OndifnV76Hse7oMA50DKe6TXkyrMVLUzSUNxGlW3HK1TaNeb/E9+IWx5f2bY/lDqCWeOBgG2QjnIjbGojJ8EVrR9anEb6BWVOnYVvWx2T7k02gWep3x1FbGLJKDc3oyIqFo3+saqcMgondNQ2Zrd8a4KgX31XE0kNy3uYUJFhY7XX6m+NH6on6B9ReOOLdbnvq+QwshdYkFUV4LC2SEF+sKPZGaVURpn6K8aNesAIBgwkY9obNNMQf/h0mPOE8k+QC7ihp/+MvwGjHnQ0rAdmGKyho+FfrRNXi74MIp+lvFTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXMi0OsjSHVzgpNtDr9lHhNyAtguHT56MqHkSVE6buw=;
 b=kj6e3H40wDjwLncloiKYltVqZ7NdEg4I5isQgcA45kjQNE3s7lI+BWut+e9qKNJ/644oDoB46EXppoKQVWZKjtntcRfDNiQcO8yKwv9THZQCexwTEU4Us/3YlxAntHch8XnTmeh7t3+nBR0di7/rPRFoV183ivIrq8uFr/zt2utQaRV4FNPQUdhAvv15+OAubowPAiT6onofRU3G1mS8tOZVV+AyiREAo6mKPXDY+zcURXeynkk370DZlJHPj6NqFaywptMQFxmqObaLMg2Bo7cqI2MNVXV4eI9cmb6Q2mNzDd45e8R0Q1pRxEsnkK8SDDVlab28WMT5MuLP2fG1QA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10209.namprd02.prod.outlook.com (2603:10b6:408:21e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 18:45:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 18:45:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH V0] mshv: pass struct mshv_user_mem_region by reference
Thread-Topic: [PATCH V0] mshv: pass struct mshv_user_mem_region by reference
Thread-Index: AQMByg9D4osO/ttNVfoyFp/nxg6l4bNUeYoQ
Date: Wed, 4 Mar 2026 18:45:12 +0000
Message-ID:
 <SN6PR02MB4157FBAE767E7563898DA0BDD47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260304000251.2625375-1-mrathor@linux.microsoft.com>
In-Reply-To: <20260304000251.2625375-1-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10209:EE_
x-ms-office365-filtering-correlation-id: 9134f9fd-8fe0-4000-8e3c-08de7a1e2b29
x-ms-exchange-slblob-mailprops:
 5fu/r660v9OFyJ+CxyO6ueseEO2yHaMVQvc9jkqSN7cFkqYKyooJZui0ge4ZlLfsMD6kzd0gpZVtXTnerBKgqyY7ofIvCBfX2Of+GoYxuL6h1j5KRtM88sSKXsNm1b21byLAGS1CF3EZpbnO4uiixiLgN2Tl0XDgtInrN75U3DLb6Y/2Czkx28nVnFehljlDZdIIzeEkPuqioPmiAYHP7kcqTP1yu9LRfzfPm41hwPas95CYygo+BLXvaK+2xQ6fDblionYBqNbgH9PPUDusLuGT47L5/1VNO/v/pR8t6PnpU9JY3yC1FbFw5y/EL8fnpFCupDzm+MyCGQwbOJpjZGzvQRRBcgevHzpjVso3VWQ0COO1ahthrgggZ3dQ5tGvx0DftLVQlb/+ftnnjaiQ/KR/Bm6/oveWGYCS5XNeJ0OpgQpsAB+8ZiX6/31nutbwrqoH5ZWJ6xhodPqnp30KZZ1ZPP5VPf4N/uhcBQPhVqixfXuBZke4yAEnk0fW76XPU3kDi38dN5Ra1up5JIG68NBl/2inuapoy85hqJhSVPZbrtaqPUGlwwMA0LlMXkHUSvjSEHpnWEyIYphDFXU7vTFUX9fQJG/BwXYkZbSImwetbF+yOeZlcNmimh7iHIO5VU4vSIgkACF9EApyCKDiJYTXD+mfq43zYYtCHjVBWitLuypQ1LNiq7s/sRKrXeheCkRYElnqtEGye/OxZ8vUWqMwxig7YHVAyeHGPTgvk8U=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|51005399006|12121999013|8062599012|8060799015|19110799012|13091999003|15080799012|41001999006|19061999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?epQK4I+96D/KOptE++sTRdCCMizOfngI928wQSppTzNV+Iym5uU1n3Iwtdcm?=
 =?us-ascii?Q?h9OU7ZeMknXWSVQbXGWU37ywmpwx5fyyj6LtWjAep4UYqSsfO7azTRXsx9HI?=
 =?us-ascii?Q?VvEutxiZZFr1mwTQugXRr3EVj3nPGMB5JrdVfqxSzUaVYi920Xwt8X/vTAdS?=
 =?us-ascii?Q?Zk4GXvsyMAMEIwJTxuEORAufoNatGxt1pcxDME2kxJNaDBUieS3pA25j9rzH?=
 =?us-ascii?Q?mmGa/cUQu93/B+nJUQOVMBv2U9/XbqcndXqNQyyTI7gO4Yt4sU3hF1l6kB7v?=
 =?us-ascii?Q?SlHQXqXZo0hL6lJGQW0EncL77yxP/kUJwktpHgzlrgKBfZficq3UK0sPxd8I?=
 =?us-ascii?Q?WZZJgoho0fnWPh8MKJBcXpg20Xr2sOxTpUxHIZYn0eQTpO7f7C53sFx9IRjP?=
 =?us-ascii?Q?GVH9OLTLh/RXrkPtRrvvthCRBhBdOz2t+gJzf/z9dAxF0Goois6qOzKT61JZ?=
 =?us-ascii?Q?EHzdtyvZNjYyC5b4z4M4NHnYfuhFlOaDzW8wgZju5vBmrRjD0ixAbGwjn5cq?=
 =?us-ascii?Q?Exxp4T+loqCLIuAEygbjQWZpYyGnDdSdoWPh5krIcKKd1TE7nvU/gKwTRJqz?=
 =?us-ascii?Q?iukAk/FZnUTB3ufKlpDSgAUcj8aDO5Tdss5mwRrBcsU6PgA8VT0INfgkx5x9?=
 =?us-ascii?Q?QeSn6h/r1LSa44ZMTtQYoOYc+UgXY9ZPa/SuOYwPVSBPHqfabx94LDecmsLI?=
 =?us-ascii?Q?4aDmL0n8tF9yPQNeF2lSPLD7EuTUNXGiQJF4rsmMrB0KeQICuVspyzVa6ziT?=
 =?us-ascii?Q?Skmt+v/myM+BuWLrGHsGrS9cSVU2MkjG6cT5rDpfM/IE0mghk1OUMlwNvLU7?=
 =?us-ascii?Q?YGrUAV2kx9ramm6DfMVUYGwOVhEOUZZwz1adpSQssokrM6TzC1t9yWIiDLRv?=
 =?us-ascii?Q?CAf8Mu0LrNRo7ZItpyou9VGoPVomD8u/EQMHn2TG/5Wm1dN3wju9H7W/UiX8?=
 =?us-ascii?Q?BqBSc4kpbnrJNCCZq7qm9Nuu0YRR7GU/fQhSoqa4uXMpT2r9CN6qhGi33N5/?=
 =?us-ascii?Q?cxXCQmTa0u++KbMe7xlyK2tyubUJpN8G2al8b8DInLBJ26E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1JWcbONctu9cofMYVkxdbUG6Xp3nbbb0cZwAuS/Z4l1GI0+CL5fUB3xcRjIc?=
 =?us-ascii?Q?XGFkcFCjhxq/lNi+Tdk8+r1byvSlQ0uUgvxfP56/vISTn3En9hGJEBW4gjYm?=
 =?us-ascii?Q?SRCmYMjiR0t5XhtVQbOBp6+bhv7xAsQ/1W9hrJqLEQ33+ay3gvqJSam8tcJx?=
 =?us-ascii?Q?227vSmcacT3FuCPC+v4S/N3h7zih9amRlwx7e0bQBS6Ly+uObtXfaPDedqhk?=
 =?us-ascii?Q?KS2ft0C0VvXTWdgOziE9d6y7JvtS8VuH7b9ywdowMpcmD+ro10Zi6tIHlJfy?=
 =?us-ascii?Q?0V5749F9o9KqwIeveIxu6Tcgztuy8EZPPHvzYX93R/ufPqLkWVMILSnOvms2?=
 =?us-ascii?Q?/7LWsJ+dZw9hKmDhetqAfq3ntXkyE1T6/hhqdPQvQCTZPi/uOZLQ6BcbNNv7?=
 =?us-ascii?Q?8guLB4oQcCaOU9abW4a9VRXClq0vI4v5a+in7qPOAbCknVNcu1n4cDrnAcOL?=
 =?us-ascii?Q?spXxKBZZnrJNaL5QJqsDOeu4SSf9dipM0lvnED2XCeX+J3EZY6HmBfMV8YpJ?=
 =?us-ascii?Q?mAv3Aq1REbjZqzHjoikCInamX0kRKJvQ2vWse5aIS4uMCX6fSDWk2CSN0n7S?=
 =?us-ascii?Q?dfdkXPlbQ3JqXKDtFjWm2iEzw9g4MNi1uHLrbmDNi6q70vKQHG+RKC2dHph7?=
 =?us-ascii?Q?61TNZQ4vtrtLPwEFzAkt9irWdZwfzJ+YxJNzNAid358YFt43vMmU5NIkEVE2?=
 =?us-ascii?Q?8sZUiZ3jIujXhA1Ys8pABAkVtBBdpDErAYdYypBCYAWOWRSI/F0zNiYALJrl?=
 =?us-ascii?Q?U4FcevWVdF5pFieZN4x/snyp/tH/0tjMWVq2pSVIi4xmlAQB2sU1NqUO4r01?=
 =?us-ascii?Q?QMKeziNS5D2aHwj5uei+FLk0dqp7ELSgbq/mW5680mqp5CMF5MLmZn6r4BAH?=
 =?us-ascii?Q?4TaAX9zt2a13opo3IPR8j6bS8hRw0ohY/Rv0YwXPYePCMjQ/CrrgBzlr6MXS?=
 =?us-ascii?Q?jxUiRFARQHXPbA42WFWZIlfh5d03rr+0FxFLHZ4EU5kjMVrzaqputlT30szT?=
 =?us-ascii?Q?DVlHAidnw8tAp/ODFQNorv1nmhNQoOb4F9pAovqnuInsUaxLmp63XqXPiApz?=
 =?us-ascii?Q?f62TqRdY9er2l25LlVHaYBhQH0TG9xWQhs3Xu9mCrhEyfvnkQmAoZbjUnxFC?=
 =?us-ascii?Q?+vJmNlnX2RqAf+92lSdwxSxr1GrGLosb/u4re8aNt+8U/G8Bh4hTQ1SHf8V1?=
 =?us-ascii?Q?oZAFi77PZVizFMOL8XAc6FqQmWeArtmFBsA/t7frLijO7wRW8P7rHLdbfMxF?=
 =?us-ascii?Q?htoctY3KptDE2IVWwsba39UNdI4NefL365CgwVlxn2IiRsQbDcmBCPzItmep?=
 =?us-ascii?Q?cqZ0iSPCyDFHeo6QnjL15TjMz74izrvJaX5PSguFI9Ym2tRaaryU/nadBqNk?=
 =?us-ascii?Q?QUX/si4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9134f9fd-8fe0-4000-8e3c-08de7a1e2b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 18:45:12.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10209
X-Rspamd-Queue-Id: 1600D206976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9136-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:dkim,outlook.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, March 3, 2026 4=
:03 PM
>=20
> For unstated reasons, function mshv_partition_ioctl_set_memory passes
> struct mshv_user_mem_region by value instead of by reference. Change
> it to pass by reference.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/mshv_root_main.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e6509c980763..87c5ffd2528d 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1289,7 +1289,7 @@ static int mshv_prepare_pinned_region(struct mshv_m=
em_region *region)
>   */
>  static long
>  mshv_map_user_memory(struct mshv_partition *partition,
> -		     struct mshv_user_mem_region mem)
> +		     struct mshv_user_mem_region *mem)
>  {
>  	struct mshv_mem_region *region;
>  	struct vm_area_struct *vma;
> @@ -1297,12 +1297,12 @@ mshv_map_user_memory(struct mshv_partition *parti=
tion,
>  	ulong mmio_pfn;
>  	long ret;
>=20
> -	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> -	    !access_ok((const void __user *)mem.userspace_addr, mem.size))
> +	if (mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> +	    !access_ok((const void __user *)mem->userspace_addr, mem->size))
>  		return -EINVAL;
>=20
>  	mmap_read_lock(current->mm);
> -	vma =3D vma_lookup(current->mm, mem.userspace_addr);
> +	vma =3D vma_lookup(current->mm, mem->userspace_addr);
>  	is_mmio =3D vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
>  	mmio_pfn =3D is_mmio ? vma->vm_pgoff : 0;
>  	mmap_read_unlock(current->mm);
> @@ -1310,7 +1310,7 @@ mshv_map_user_memory(struct mshv_partition *partiti=
on,
>  	if (!vma)
>  		return -EINVAL;
>=20
> -	ret =3D mshv_partition_create_region(partition, &mem, &region,
> +	ret =3D mshv_partition_create_region(partition, mem, &region,
>  					   is_mmio);
>  	if (ret)
>  		return ret;
> @@ -1355,25 +1355,25 @@ mshv_map_user_memory(struct mshv_partition *parti=
tion,
>  /* Called for unmapping both the guest ram and the mmio space */
>  static long
>  mshv_unmap_user_memory(struct mshv_partition *partition,
> -		       struct mshv_user_mem_region mem)
> +		       struct mshv_user_mem_region *mem)
>  {
>  	struct mshv_mem_region *region;
>=20
> -	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
> +	if (!(mem->flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
>  		return -EINVAL;
>=20
>  	spin_lock(&partition->pt_mem_regions_lock);
>=20
> -	region =3D mshv_partition_region_by_gfn(partition, mem.guest_pfn);
> +	region =3D mshv_partition_region_by_gfn(partition, mem->guest_pfn);
>  	if (!region) {
>  		spin_unlock(&partition->pt_mem_regions_lock);
>  		return -ENOENT;
>  	}
>=20
>  	/* Paranoia check */
> -	if (region->start_uaddr !=3D mem.userspace_addr ||
> -	    region->start_gfn !=3D mem.guest_pfn ||
> -	    region->nr_pages !=3D HVPFN_DOWN(mem.size)) {
> +	if (region->start_uaddr !=3D mem->userspace_addr ||
> +	    region->start_gfn !=3D mem->guest_pfn ||
> +	    region->nr_pages !=3D HVPFN_DOWN(mem->size)) {
>  		spin_unlock(&partition->pt_mem_regions_lock);
>  		return -EINVAL;
>  	}
> @@ -1404,9 +1404,9 @@ mshv_partition_ioctl_set_memory(struct mshv_partiti=
on *partition,
>  		return -EINVAL;
>=20
>  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
> -		return mshv_unmap_user_memory(partition, mem);
> +		return mshv_unmap_user_memory(partition, &mem);
>=20
> -	return mshv_map_user_memory(partition, mem);
> +	return mshv_map_user_memory(partition, &mem);
>  }
>=20
>  static long
> --
> 2.51.2.vfs.0.1
>=20


