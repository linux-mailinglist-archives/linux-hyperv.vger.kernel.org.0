Return-Path: <linux-hyperv+bounces-9872-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAdQD3ZOzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9872-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:57:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2137E460
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E43E300E271
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46524779BF;
	Wed,  1 Apr 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dCstXDuN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010017.outbound.protection.outlook.com [52.103.12.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96347A0AB;
	Wed,  1 Apr 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062537; cv=fail; b=EhjvPTb6UhulPmI0LeGoObeXS1F+BDRvnzTbqFnANgrZ2xFuOAlMSkfqL8EcstAjoaH60M7zAKeQ5cHK0OQ1abPo6fjZFdBbbQS08HwXP1q1N/WNBnkI2nam+USCl6701i5vnRWoKYiGhAoGu1il1rom5aB2aCP02qbBdmznSJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062537; c=relaxed/simple;
	bh=BMqs6n0ugTE4dtBv7zo/wrZv1y70okh/p2h8dr0gvWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K/HlgSofw5gHuOvccd1DCIIFBoY3u5WO9vsRE3yfJteCHdrHphvkaIydYlVpB/viigCcWnvjYARzmZzQt1BtkZSpAg+0cQ2GUceb9hkVvcyDcTZBFHMQexKqHcaRbVGKkBjcvIOkSPLe02cLN1KqHUpGyad4XWmVtWY3cvr5Bzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dCstXDuN; arc=fail smtp.client-ip=52.103.12.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWo4hqChnA65tsIrdsFX1V871NHeBf6r7+7q2sU1CGXfUIysMRAn5WHGMGQZvC6JT0XuV6TQL3L1HBaLE4kZ620t6ndA26XVK3CdGNYkl+drtljmkKbSsZgG4oSsBBfNiSi2Ryu3sLoM60MQ2fRJ4d24Ck/1pC0ONAwfqxpSXkC2VbBmchteqmmL6jjZqEhS4Gp6NV8IeMwhNqqBCdT4grL+FQ71gvf8CP7GQvT2WTvR/pj9pSCoeSSEa/dYCDEwK7gYkkTVH9uW4dPYDetEvWBsboi0nPk8AOPUNsFlP3tuFtzIBbGsvHztbpWoJB+/llf6D4G+iDv3GaMk6SjGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPjY2lEhtVrlabGQcdKI2gpfkFsE1t0LGrbTsbtG9VA=;
 b=g03x35+Fv/dBL8WNbgPgHKs2KQNfiglblG4U8MM53CpqdGlpDjG+urZPUahtXX0ErBPv0t87xW/UfWnxZ8IgO8giuXP9i7FRs6ZsJI6LTmiFKi1TflgJYiARv7M7yyL3Urz/xbIMlNjHtQNfkHg5+AtWsFQ5VdrnNETZMrOXLsFEhd6q4IdMR49W2/MU84ID4D4Av6/BY5LlfngAbxDa0q+8kKh2XYRv7UYA0cMzxywTBnO0VLbaaTd51adcm727sM1v/s7V2TWHIM/hQiXzrsobGDOzZLmpQuLTp3TwwgyQp4E66QQbb1R5xZtJlPK8XhF24b/zJfWvUkSGPLmNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPjY2lEhtVrlabGQcdKI2gpfkFsE1t0LGrbTsbtG9VA=;
 b=dCstXDuNVfYhLT/7eukuNDs7h8YQDDEljIisLxHNjnXSq32OUXhZ9snB3ghYmvWSuDZE9/N+zRyPCtIVJ4uKDGtzrB6E7SeKycDU/4PJUiyQyBBu8CO4Ei4IzOFeHHd/m/tTuz9zsVnSgM7fQ7XFLFERpLqGtTIyhHSNj39Feri7YtiqJwN2/hyaPG4IzC2kTl0KDTAkk9G4PTkXhdUP61fVUegC05EVT+CWkX2eCKAIOD6MJKkdRZJc68NfhwpyN28XDVUHvD8rUww9ZgGA6H5YAR+HB7TlBKts0W9UkZlUGfpqEUr1QEaJ+JHbUBVLG/D8z9Z8Dg5rUPxWG2AACQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:55:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:55:32 +0000
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
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 02/11] Drivers: hv: Move hv_vp_assist_page to common files
Thread-Topic: [PATCH 02/11] Drivers: hv: Move hv_vp_assist_page to common
 files
Thread-Index: AQHctT5GdtuSbrKWekGbXgFiXJ2l57XKhjXA
Date: Wed, 1 Apr 2026 16:55:32 +0000
Message-ID:
 <SN6PR02MB415790977DA40BAD0822DA54D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-3-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: 59ae2e1d-584f-4a6f-0909-08de900f7c7c
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SjBVx3vdOE4EFMiMMFD19QGZ4BlAZ7zzl6pq5oBQbIYpBrt542dCCKBRctiJY5+p1+H8FMLKXt7Y1FO37apaX4zmIsDSpeaggPII45fNzU+U0jw+j1ILpk/E3LL0euzMCTOfMjfv0XaRoy9nuBHsyAh6zWG1JkEF9HaH6pNDYDM36t8bShg61+IEKnGH7nJg2PPUrbCdFKp2SZr+fPWMEx80X3JQYK9XVSL3uVU5d18nrcN1/SWkfrtcxoGimVXvh9tkw7BZqwncmBMn4/oI3D5eO7JLcdqtkvpyUxAc9m1ldCIQXVsi6Rk4YbrEM8/FJAHE4mxrVvv+SdcfytLavublMF4WCFaSxtawDRNwXcqmVdI4AC9tG7a03MQGTOm0GvAa4xviaJWyZDoum72/fFsDqkgulxk/kjZ5qGjawKs/zblcaKfg+WGd0ijtLDRFnbOarnNljvMi7EZJdLZ7Ee1gKnBITBwCD2KzCLrqKtxVwia++wB+BkblbTv0NoPsrLqBoj7TcFPoOq5eBRMt1f37wUjEOf8ltEVtsYRxIha3kBKF5QYVa32rCto0s52Dc59ddnsRAUvzD21F1KfrTQsZKYdpQFE98k8f0rT8lBtSRs9JSTmSwsfftB6FtFnOaRqutHqZzY9FjPvOnedyklMJt3VuXeiuL4D5sajPp3YA8zHemPmO1b6LJwLOfjICGf1pqjY7qJXLv0eXU9LZdGFWpeYwM/GbHkm5OlKJw5b8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|12121999013|37011999003|31061999003|461199028|41001999006|51005399006|15080799012|13091999003|440099028|3412199025|12091999003|26121999003|102099032|19061999003|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KpirCX3LUUW1Y652LMf+znyNp4CxjQqjZnzS3R58jiNj5k867wpJlEHe6ENy?=
 =?us-ascii?Q?t1Zfe0/M0tv3NKt9pwBuOG8ojxIw5ogzDLRASM3obpSAAbNZwWEILFHuokKk?=
 =?us-ascii?Q?RfIni57hVPzN3CT8kgbFtbbnYy5UnVYSblMCpZsaQk+gxd590w58mexLl8gT?=
 =?us-ascii?Q?4rtwC6srMD5kTyrn5Hjfj/9vo4YcAhsMj+JE1fuCBvlmGAa25BPo3Na4hgn/?=
 =?us-ascii?Q?1tq19KZzzE3A73nETgU5xvbyIp1KklO4u1kWjWl6khqgweCGXuZuuMoDxNT9?=
 =?us-ascii?Q?ZaiXWrELMIvLHhsJBWcfZCCXsTmL624Iz3dmWeNcVkySd/3Y+ceNfNOZssA1?=
 =?us-ascii?Q?2KkbcLCGKz7ig01ypgb1a1rcjzhi3nheNIzOQCGP+jnrYg+bE267ude3Y2uK?=
 =?us-ascii?Q?WZlGCk5rbpVgypZNNIbVfXKIJOJQcbB/5DAlLfAZcev/qS1CBCRZO2rLTppK?=
 =?us-ascii?Q?+2NeoAHiqCE4CPsCT4ZZdNn2bP2JpuY/MJUQvIbp7qD6epVf2yEOWMIltHfg?=
 =?us-ascii?Q?ZnbFp1lMWQYsSJZ23k2gwO+LKPP+zSWbRmJW8laREI2bT675r10MbqOmHpnQ?=
 =?us-ascii?Q?fcutzF1tBP+OsDW38LTnzd41H2tSvWRVwGS5L1T/184wmB3+aFn3XDCZF/tY?=
 =?us-ascii?Q?OinDVzyZ7168o6VhmqRITUYoyxrRyhWlwV3D6fKQa7X1okcaxovuIn69vNQt?=
 =?us-ascii?Q?mLn61MUeRPMozCf/CxW1txrPXUFG9BDzkVv71Im2nE/wOzT1MlOeWWr5LLEj?=
 =?us-ascii?Q?MtHM/Zhi8gb4WvpaMV0DHUHkK2LECqb+sp3CBX2gxq5CbUEM03AJ9yl7taIV?=
 =?us-ascii?Q?5+DY8q9jU8HaI/sRimWbXF2Elbbj/3G0PfUIhxWJdDDpEgL5WSc5UEXZDX6g?=
 =?us-ascii?Q?meC5GdUJEEq/67o2n9SIAZgYmW1eH71CPIZ7KoZ7Pp3bPEk/PFFTWDw4BtLk?=
 =?us-ascii?Q?r71WDkigMxX5PXPFvC2bLPBlj0KyFE69cPb+CfnquIZVPzQAjs8iYvgUhLZu?=
 =?us-ascii?Q?hXIEQrdpfjRiqtymN29nwP6EWV93/u7XwQ1D1EabQljd7FqJy8iceFSo072F?=
 =?us-ascii?Q?NJL6d2O+kia1e3/Uvr7Gc34pN6GI06FNBqoEEOZVCAaq10gLoKU0AvtaMQS9?=
 =?us-ascii?Q?b3Ocx5/KkjgoJzBpTp8Dvw/v5ntTbLkAeSill8e3069R0bsE7RMhCek=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XjiPKQc+9/S3HpJJE+KASQDRDJ01B8NttqL2WdiinBaERePjRwz2lNeCeiJE?=
 =?us-ascii?Q?Ml68BzkEttJuYL2MgDZLWKSSdvUTMxN0JH/ZhyP4E/JSoPdstXYRxClArHHz?=
 =?us-ascii?Q?+1ymlAmn/ZHgP7fRt4UydSWabmtUDLTovTveAZo3HQCBdj2tn7PysZkpUOdO?=
 =?us-ascii?Q?j0etVr9LLFG7zw87n5XFVCuxRfe6XtIbxmV17q3Dx5k1ixJg9ZYSgG5+ftyG?=
 =?us-ascii?Q?eYgEW2MNecjEzA5jfvr2whB+3NAzNwjaThDEApfJp3zm/BM3Goj3X26vrUA5?=
 =?us-ascii?Q?x4i29ftpwbrHiqT42fvuTnsMbKdaZc38FGtpZbGxOZKowgMFUa756VFhiKd4?=
 =?us-ascii?Q?vJFdwkzbN/SiwIx5rKtFK4gOhawkuqqsN7nic+RIDWu+EDubzvitNLRrjEOO?=
 =?us-ascii?Q?+XiogcQGrALH1PdDiMlm13ZXPpg8tdnqrbhUKvfq45mSvzptwVAuFzSm1x+b?=
 =?us-ascii?Q?tR+Q41JB0t6S1QWu7GvOxsRDzGhR1iJNIRUvHz5RnlycAmS3htHBHDevFteJ?=
 =?us-ascii?Q?E+sYHKuxizkw+9KMxrJ4zspPpMoOFVXbVNIm9GPzC9w2sUhyfRlU+So9e7G9?=
 =?us-ascii?Q?g6s9e6s3tl1ToWgwhTQurK/Jqh7AU/wKfjcvwPSSmJ0Vx+CVeKh+MAuoa0bR?=
 =?us-ascii?Q?jvU9+M0ijd5x0hpV2S45es3eiosyrgOMxFul9OLXe2sZUtdsjFGCZT+fiaOW?=
 =?us-ascii?Q?n9sv7w92zS+XTDizwa84eLE3tQOhtuOF1n5U05NwmD74x7eBih+4n3B90E3j?=
 =?us-ascii?Q?7y+dZvFbIXStNko3J7EB7zGGpRg+E+cFdWCdJzepn/KoY2A/oiQidY8ETjga?=
 =?us-ascii?Q?/SAIuBT2IaMR/x12meWprGCpvFaztNOISHu5YMLVm3tyKmhmtCBXYksuWur6?=
 =?us-ascii?Q?TWB02qkGm5UawFJ6jgRCEySoO38EyjutWDKWAfJ2XGkDHxSij2Z0XCJzfSiZ?=
 =?us-ascii?Q?aKoqvnxsuBPceHOycrYG/IZTZ6nwdxm3TOw2ib6zSVA8wtnXuLDGotDMGhlp?=
 =?us-ascii?Q?MUMt73jbWG9Thw2aTV8ovf45Dz2hXfRIxdcZvQ7CmYgdcQ8Rkw9LzAIjUsE4?=
 =?us-ascii?Q?t+rdP+GOGNrc/bFQuHQY5IN1WhONzbLNtppH+yjGPR1hRVCBUJqiJ7LJp1yi?=
 =?us-ascii?Q?yNOYlfQQddoqYgPV/Y5IQwh64uiGTXzw8B6XMmD3Gm8BLgQmi6w7yrchQIdf?=
 =?us-ascii?Q?lYPn/pJG8zPkfa3GQEPQcod4xzC8nw/P7H/hR12jut+abjtY5wTwXPk5ibde?=
 =?us-ascii?Q?cGdM7fKXlJNKJQ8W3ivDwhnYSmA9NYhnBivPLtWmW4TOs/FdeDqdKu1XXvhi?=
 =?us-ascii?Q?w4FGf2+Ya1EZ6xuCpgas4Uh9DkN2sWcvM4FQcLuqVTnnR7yV1SVbd3HJ3Jui?=
 =?us-ascii?Q?x+Ry2nI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ae2e1d-584f-4a6f-0909-08de900f7c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:55:32.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6701
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9872-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: A7D2137E460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20
> Move the logic to initialize and export hv_vp_assist_page from x86
> architecture code to Hyper-V common code to allow it to be used for
> upcoming arm64 support in MSHV_VTL driver.
> Note: This change also improves error handling - if VP assist page
> allocation fails, hyperv_init() now returns early instead of
> continuing with partial initialization.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 88 +---------------------------------
>  drivers/hv/hv_common.c         | 88 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  4 ++
>  include/hyperv/hvgdk_mini.h    |  2 +
>  4 files changed, 95 insertions(+), 87 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 323adc93f2dc..75a98b5e451b 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -81,9 +81,6 @@ union hv_ghcb * __percpu *hv_ghcb_pg;
>  /* Storage to save the hypercall page temporarily for hibernation */
>  static void *hv_hypercall_pg_saved;
>=20
> -struct hv_vp_assist_page **hv_vp_assist_page;
> -EXPORT_SYMBOL_GPL(hv_vp_assist_page);
> -
>  static int hyperv_init_ghcb(void)
>  {
>  	u64 ghcb_gpa;
> @@ -117,59 +114,12 @@ static int hyperv_init_ghcb(void)
>=20
>  static int hv_cpu_init(unsigned int cpu)
>  {
> -	union hv_vp_assist_msr_contents msr =3D { 0 };
> -	struct hv_vp_assist_page **hvp;
>  	int ret;
>=20
>  	ret =3D hv_common_cpu_init(cpu);
>  	if (ret)
>  		return ret;
>=20
> -	if (!hv_vp_assist_page)
> -		return 0;
> -
> -	hvp =3D &hv_vp_assist_page[cpu];
> -	if (hv_root_partition()) {
> -		/*
> -		 * For root partition we get the hypervisor provided VP assist
> -		 * page, instead of allocating a new page.
> -		 */
> -		rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -		*hvp =3D memremap(msr.pfn << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> -				PAGE_SIZE, MEMREMAP_WB);
> -	} else {
> -		/*
> -		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
> -		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> -		 * out to make sure we always write the EOI MSR in
> -		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
> -		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> -		 * case of CPU offlining and the VM will hang.
> -		 */
> -		if (!*hvp) {
> -			*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> -
> -			/*
> -			 * Hyper-V should never specify a VM that is a Confidential
> -			 * VM and also running in the root partition. Root partition
> -			 * is blocked to run in Confidential VM. So only decrypt assist
> -			 * page in non-root partition here.
> -			 */
> -			if (*hvp && !ms_hyperv.paravisor_present && hv_isolation_type_snp()) =
{
> -				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> -				memset(*hvp, 0, PAGE_SIZE);
> -			}
> -		}
> -
> -		if (*hvp)
> -			msr.pfn =3D vmalloc_to_pfn(*hvp);
> -
> -	}
> -	if (!WARN_ON(!(*hvp))) {
> -		msr.enable =3D 1;
> -		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -	}
> -
>  	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
>  	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
>  		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
> @@ -286,23 +236,6 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	hv_common_cpu_die(cpu);
>=20
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> -		union hv_vp_assist_msr_contents msr =3D { 0 };
> -		if (hv_root_partition()) {
> -			/*
> -			 * For root partition the VP assist page is mapped to
> -			 * hypervisor provided page, and thus we unmap the
> -			 * page here and nullify it, so that in future we have
> -			 * correct page address mapped in hv_cpu_init.
> -			 */
> -			memunmap(hv_vp_assist_page[cpu]);
> -			hv_vp_assist_page[cpu] =3D NULL;
> -			rdmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -			msr.enable =3D 0;
> -		}
> -		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -	}
> -
>  	if (hv_reenlightenment_cb =3D=3D NULL)
>  		return 0;
>=20
> @@ -460,21 +393,6 @@ void __init hyperv_init(void)
>  	if (hv_common_init())
>  		return;
>=20
> -	/*
> -	 * The VP assist page is useless to a TDX guest: the only use we
> -	 * would have for it is lazy EOI, which can not be used with TDX.
> -	 */
> -	if (hv_isolation_type_tdx())
> -		hv_vp_assist_page =3D NULL;
> -	else
> -		hv_vp_assist_page =3D kzalloc_objs(*hv_vp_assist_page, nr_cpu_ids);
> -	if (!hv_vp_assist_page) {
> -		ms_hyperv.hints &=3D ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> -
> -		if (!hv_isolation_type_tdx())
> -			goto common_free;
> -	}
> -
>  	if (ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
>  		/* Negotiate GHCB Version. */
>  		if (!hv_ghcb_negotiate_protocol())
> @@ -483,7 +401,7 @@ void __init hyperv_init(void)
>=20
>  		hv_ghcb_pg =3D alloc_percpu(union hv_ghcb *);
>  		if (!hv_ghcb_pg)
> -			goto free_vp_assist_page;
> +			goto free_ghcb_page;
>  	}
>=20
>  	cpuhp =3D cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:on=
line",
> @@ -613,10 +531,6 @@ void __init hyperv_init(void)
>  	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
>  free_ghcb_page:
>  	free_percpu(hv_ghcb_pg);
> -free_vp_assist_page:
> -	kfree(hv_vp_assist_page);
> -	hv_vp_assist_page =3D NULL;
> -common_free:
>  	hv_common_free();
>  }
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac616789..d1ebc0ebd08f 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -28,7 +28,9 @@
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/set_memory.h>
> +#include <linux/vmalloc.h>
>  #include <hyperv/hvhdk.h>
> +#include <hyperv/hvgdk.h>
>  #include <asm/mshyperv.h>

Need to add

#include <linux/io.h>

because of the memremap() and related calls that have been added.
io.h is probably being #include'd indirectly, but it is better to #include
it directly.

>=20
>  u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
> @@ -78,6 +80,8 @@ static struct ctl_table_header *hv_ctl_table_hdr;
>  u8 * __percpu *hv_synic_eventring_tail;
>  EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>=20
> +struct hv_vp_assist_page **hv_vp_assist_page;
> +EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -92,6 +96,9 @@ void __init hv_common_free(void)
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
>  		hv_kmsg_dump_unregister();
>=20
> +	kfree(hv_vp_assist_page);
> +	hv_vp_assist_page =3D NULL;
> +
>  	kfree(hv_vp_index);
>  	hv_vp_index =3D NULL;
>=20
> @@ -394,6 +401,23 @@ int __init hv_common_init(void)
>  	for (i =3D 0; i < nr_cpu_ids; i++)
>  		hv_vp_index[i] =3D VP_INVAL;
>=20
> +	/*
> +	 * The VP assist page is useless to a TDX guest: the only use we
> +	 * would have for it is lazy EOI, which can not be used with TDX.
> +	 */
> +	if (hv_isolation_type_tdx()) {
> +		hv_vp_assist_page =3D NULL;
> +	} else {
> +		hv_vp_assist_page =3D kzalloc_objs(*hv_vp_assist_page, nr_cpu_ids);
> +		if (!hv_vp_assist_page) {
> +#ifdef CONFIG_X86_64
> +			ms_hyperv.hints &=3D ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
> +#endif
> +			hv_common_free();
> +			return -ENOMEM;

Given that "failure to allocate memory" now returns an error that is
essentially fatal to hyperv_init(), is it still necessary to clear the flag=
 in
ms_hyperv.hints?  I'd love to see that #ifdef go away. It's the only
#ifdef in hv_common.c, and I had worked hard in the past to avoid
such #ifdef's. :-)

> +		}
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -471,6 +495,8 @@ void __init ms_hyperv_late_init(void)
>=20
>  int hv_common_cpu_init(unsigned int cpu)
>  {
> +	union hv_vp_assist_msr_contents msr =3D { 0 };
> +	struct hv_vp_assist_page **hvp;
>  	void **inputarg, **outputarg;
>  	u8 **synic_eventring_tail;
>  	u64 msr_vp_index;
> @@ -542,6 +568,50 @@ int hv_common_cpu_init(unsigned int cpu)
>  			ret =3D -ENOMEM;

The Sashiko AI comment here about a bug when ret is set to -ENOMEM
seems valid to me.

>  	}
>=20
> +	if (!hv_vp_assist_page)
> +		return ret;
> +
> +	hvp =3D &hv_vp_assist_page[cpu];
> +	if (hv_root_partition()) {
> +		/*
> +		 * For root partition we get the hypervisor provided VP assist
> +		 * page, instead of allocating a new page.
> +		 */
> +		msr.as_uint64 =3D hv_get_msr(HV_SYN_REG_VP_ASSIST_PAGE);
> +		*hvp =3D memremap(msr.pfn << HV_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> +				PAGE_SIZE, MEMREMAP_WB);

The Sashiko AI comment about potentially memremap'ing 64K instead of 4K can
be ignored. We know that the root partition can only run with a 4K page siz=
e,
and that is enforced in drivers/hv/Kconfig.

HV_VP_ASSIST_PAGE_ADDRESS_SHIFT is defined in asm-generic/mshyperv.h.
But there is also HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT in hvgdk_mini.h.
Is there a clean way to eliminate the duplication?

> +	} else {
> +		/*
> +		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> +		 * out to make sure we always write the EOI MSR in
> +		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> +		 * case of CPU offlining and the VM will hang.
> +		 */

Somewhere in the comment above, I'd suggest adding a short "on x86/x64"
qualifier, as the comment doesn't apply on arm64 since it doesn't support
the AutoEOI optimization.  Maybe "Here it must be zeroed out to make sure
that on x86/x64 we always write the EOI MSR in ....".  =20

> +		if (!*hvp) {
> +			*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);

The Sashiko AI comment about using "flags" instead of GFP_KERNEL seems vali=
d.

> +
> +			/*
> +			 * Hyper-V should never specify a VM that is a Confidential
> +			 * VM and also running in the root partition. Root partition
> +			 * is blocked to run in Confidential VM. So only decrypt assist
> +			 * page in non-root partition here.
> +			 */
> +			if (*hvp && !ms_hyperv.paravisor_present && hv_isolation_type_snp()) =
{
> +				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> +				memset(*hvp, 0, PAGE_SIZE);
> +			}
> +		}
> +
> +		if (*hvp)
> +			msr.pfn =3D vmalloc_to_pfn(*hvp);

The Sashiko AI comment about page size here seems valid. But what are the r=
ules
about arm64 page sizes that are supported for VTL2, and how does they relat=
e
to VTL0 allowing 4K, 16K, and 64K page size? What combinations are allowed?
For example, can a VTL2 built with 4K page size run with a VTL0 built with
64K page size? It would be nice to have the rules recorded somewhere in a
code comment, but I'm not sure of the best place.

But regardless of the rules, I'd suggest future-proofing by using
"page_to_hvpfn(vmalloc_to_page(*hvp))" so that the PFN generated is always
in terms of 4K page size as the Hyper-V host expects.

> +	}
> +	if (!WARN_ON(!(*hvp))) {
> +		msr.enable =3D 1;
> +		hv_set_msr(HV_SYN_REG_VP_ASSIST_PAGE, msr.as_uint64);
> +	}
> +
>  	return ret;
>  }
>=20
> @@ -566,6 +636,24 @@ int hv_common_cpu_die(unsigned int cpu)
>  		*synic_eventring_tail =3D NULL;
>  	}
>=20
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +		union hv_vp_assist_msr_contents msr =3D { 0 };
> +
> +		if (hv_root_partition()) {
> +			/*
> +			 * For root partition the VP assist page is mapped to
> +			 * hypervisor provided page, and thus we unmap the
> +			 * page here and nullify it, so that in future we have
> +			 * correct page address mapped in hv_cpu_init.
> +			 */
> +			memunmap(hv_vp_assist_page[cpu]);
> +			hv_vp_assist_page[cpu] =3D NULL;
> +			msr.as_uint64 =3D hv_get_msr(HV_SYN_REG_VP_ASSIST_PAGE);
> +			msr.enable =3D 0;
> +		}
> +		hv_set_msr(HV_SYN_REG_VP_ASSIST_PAGE, msr.as_uint64);
> +	}
> +
>  	return 0;
>  }
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index d37b68238c97..108f135d4fd9 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,6 +25,7 @@
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
>  #include <hyperv/hvhdk.h>
> +#include <hyperv/hvgdk.h>
>=20
>  #define VTPM_BASE_ADDRESS 0xfed40000
>=20
> @@ -299,6 +300,8 @@ do { \
>  #define hv_status_debug(status, fmt, ...) \
>  	hv_status_printk(debug, status, fmt, ##__VA_ARGS__)
>=20
> +extern struct hv_vp_assist_page **hv_vp_assist_page;

This "extern" statement is added here so it is visible to both x86/x64 and =
arm64.
And that's correct.

But there is still some VP assist page stuff that has been left in the arch=
/x86
version of mshyperv.h.  That other stuff, including the inline function
hv_get_vp_assist_page(), should also be moved to asm-generic/mshyperv.h.
Given that the VP assist page support is now fully generic and not x86/x64
specific, it shouldn't occur anywhere in the arch/x86 version of mshyperv.h=
.

> +
>  const char *hv_result_to_string(u64 hv_status);
>  int hv_result_to_errno(u64 status);
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
> @@ -377,6 +380,7 @@ static inline int hv_deposit_memory(u64 partition_id,=
 u64 status)
>  	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
>  }
>=20
> +#define HV_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  u8 __init get_vtl(void);
>  #else
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 056ef7b6b360..be697ddb211a 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -149,6 +149,7 @@ struct hv_u128 {
>  #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
>  #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
>  		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
> +#define HV_SYN_REG_VP_ASSIST_PAGE              (HV_X64_MSR_VP_ASSIST_PAG=
E)
>=20
>  /* Hyper-V Enlightened VMCS version mask in nested features CPUID */
>  #define HV_X64_ENLIGHTENED_VMCS_VERSION		0xff
> @@ -1185,6 +1186,7 @@ enum hv_register_name {
>=20
>  #define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
>  #define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
> +#define HV_SYN_REG_VP_ASSIST_PAGE    (HV_REGISTER_VP_ASSIST_PAGE)

This defines a new register name prefix "HV_SYN_REG_" that isn't used
anywhere else. The prefixes for Hyper-V register names are already complex
to account to x86/x64 and arm64 differences, and the fact the x86/x64 has
synthetic MSRs, while arm64 does not. So introducing another prefix is
undesirable. Couldn't this just be HV_MSR_VP_ASSIST_PAGE using the
same structure as HV_MSR_STIMER0_COUNT (for example)?

>=20
>  #endif /* CONFIG_ARM64 */
>=20
> --
> 2.43.0
>=20


