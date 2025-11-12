Return-Path: <linux-hyperv+bounces-7502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A42C507DE
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 05:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFEC189BF21
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 04:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAAD2D0C7E;
	Wed, 12 Nov 2025 04:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ayd6slz+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012063.outbound.protection.outlook.com [52.103.2.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9C5789D;
	Wed, 12 Nov 2025 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920736; cv=fail; b=gl9StAp6Ha8BustFNTmc9u9z0D8UU1vWhVw1k+lQaOcFiU7YIxsHSxILP483DdxYqdtoOt/XKj/GGuJgfQPwqJBFn2wMlwDk+UGi51oE1hg+WQUB47Ma5C0n8OjKL2RDx/sctoEujR5k+Tve7YCwVyaDSTQQZh9h/h0wc7/GVes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920736; c=relaxed/simple;
	bh=D+Pi7t+O1rZzvn+SlzBPiQkO730qjjes1jNiR2ms8uM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5NA0SHGqb0jTeZuVjGvYtxFAP2Pv8qKcUqifQAvmqt+mFkIUDXN68NKHZBctiNIpvVwAmuCyODkAjqr2X2xZYXb/B0tDe+Uq7nsOUOwkAUTsQ4fQVJl1woBbOBtj6DaXxRvtNKUT9HaroJ0zdaTWX3G2ox355gc+dui5mNRiLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ayd6slz+; arc=fail smtp.client-ip=52.103.2.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSdWMXsLSnHrXpJjr5Png0DJXChS8fezQUjcP+FeclIFpICVlRaVLd14A0envsDbFbw/McUSDK58LSRRhhzTtB+jTymTEr+IPXT0nYwwOfOH2XuRC0f9wJjOoYxqaYnBBfBRsGZ9bcExGVQnhMPbt/4CSGZSCOcPBpHRXFlO0DwNKVx94/uslyLB+lArkkkeKP9DGyo0qZ3Rv8H3TlhE26sBCDjOQQrlHSGt0WZFd4ABZVLBrFlvSiYdHBzJdSTlg3SiQFAkFb9Jwg2dVXwqIxdD2H2COHwpxncZrJRUOOHXSyurUwV1lqJKAvwl4eF/5/tEtIRhaZG1oyXLED+PNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLoPkiU4EShQ9N4bBRDnbiRg8rnB7wwrvXMIMECndpo=;
 b=m/Rn9ILJdidtKccYaTLf58kYQT04wKnYWCRGrlcy98mkZX8I4VNfpCIA33bU0oP3lfZwiLi2mBMrHGYKKwb2LfNxphwBjtMBdMWAk7jo3csmyaPOpl/gm6rsn9SPE7IOMtxgECq7bWPVTPxCPe8SiNHacsvPC9ND6Jo9OeyyplXO6XLfNw7TLR3S86KsUu9OGqXI/EPuEXg95Pe6eDn88L/19+LR/aKvAdABnrksj1LxiIxM5SgYzQT897AaATJLfj0dlxGodpbdAGN8iV293sN/bjXmhKubY1pCFLGJ4AE1p62/B+so8GubISi0/C1KyZi9h2anMjYjgyP6YmOMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLoPkiU4EShQ9N4bBRDnbiRg8rnB7wwrvXMIMECndpo=;
 b=ayd6slz+a9cIAp3Y50+L3H2h9o+ed5G7aZ0C5StpqXxBS1v+6ACembpAET94ujyYEEJxHPZTGrR/cKv9ZRgLNwf5SDRE65NmvNOFruNa/GFtamW01UAfcOl8NUtC9vsRW16g9ODQmf4TyIvSlRy6hAcVHG8sAf56a/UP9TmSBcoxftkE5rwh+hKHvp220Yxlyis52+lg903O+d486AMIQMxmexAwZ2iSoXldrPb/GIHADl45sobtCnXR60eUa1ImfQ9HYmT6hC+kExv4j7Xyrqf4GrP4JB02iHsdzGBhs4/nrBld89to8vIas4eCT97f/jT+QZQ+cmgv9OrjijBizg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7764.namprd02.prod.outlook.com (2603:10b6:303:a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 04:12:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 04:12:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, Naman Jain
	<namjain@linux.microsoft.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Mukesh Rathor
	<mrathor@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Christoph Hellwig <hch@infradead.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, ALOK TIWARI
	<alok.a.tiwari@oracle.com>
Subject: RE: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHcUgAiXalk7wQI00S6ZbuisOapqrTr+2EAgAEREQCAABXIAIABTGhA
Date: Wed, 12 Nov 2025 04:12:08 +0000
Message-ID:
 <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net>
In-Reply-To: <20251111081352.GD278048@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7764:EE_
x-ms-office365-filtering-correlation-id: 077b5232-f760-426b-ab73-08de21a1a5c8
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6fOgpu0AmRux6KMzGkolm4jyBvFxuuAM+olS9RvXq84iNwJkmqzCYdQT8GxdSS05LSkZE2fh9v+LQ/Rfpho2oK5DDquGRrifwaCI6iG1FIVpTqHSq6IjQMLbJ0NZSGu5Bjgkk7w6LCzb47zrrmF625P953BmXUr4gHeSk9BxHkZw1nsioDk5oFmkL6O2A+EliPkB7YZWJblUPd9GhGI1mZZM1s7kLCRhvd7VelgYsvC+cYAPnzUxeSZpftI5EaMPfSBIRjrvm10chnpNsGy9FWCy+91nolBANERQqWEn5Ae87X38/pDTVRt6WN1Tjru79XH/wDqiMjh/CY4TcggxV6tLPdgOIYRBREkWs5DG11yTyOcO8IURh8rAlCH0eWMeAOCyMA4eeY7I9OYYprejYqlR00DqAFZqW2uKgRhx6Jm1KlF6huVMi3sXc6uxdpct506Xtsnzv3JUuXAWHTkSPSjIQCOjcwQFk8FebwpP+1uvqsTDPlAaW5Xh8UnNM+i/wbZGAsU/2aqv8CGLhuNfoPKNIEiC3tcKCYQ2ddEi+7KldqgKEZizwoBdP6bSj5SNNvMHVdhiVX8mH96TmR+hfdEeYcR+s+fAbnDTibz8b/OpImQxptvvF/rGaBHGzTzjX93g1h0Ci70i/5zdSGyPtExKNjo2TfhY6rUZHqD768y+HR+ip89C274Jr6hv5y3ZaXykosjoDLjfKsKVIUx6zdz4mmip0P3Ta1xBDOw0QCmlFH3nGxGGcWxqGAp6eO6ofY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799012|8060799015|13091999003|8062599012|51005399006|15080799012|461199028|31061999003|40105399003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kr2hs0Qfbpw8nz1ArhVApwcRsGZNlH39QdbwftWi2XvX9JNJha0lEzRsz9WV?=
 =?us-ascii?Q?MGL8/RYFkJsYlVgweG6R+lqvgZcdWAiQ3dgfM+7tWswZPIPDa299krklCJlO?=
 =?us-ascii?Q?oLXDqfsP1p1updMWHJb3cwdtLTim3z3sA71FavMLXtq0vkXhs//s5BuZLx7e?=
 =?us-ascii?Q?k3rwrJfyWRrp+kMFXLLHFl85IGgxENNGY+15RNi3YVMeM6KIUo2/kIc7k9DP?=
 =?us-ascii?Q?QclJcVWmOrcFrESbXtY59/aR1HPxNycg/CtRdDFuf2/AFUMgaVtL6eAiImSp?=
 =?us-ascii?Q?8qr7TK5bzlukXTk89FjOm4XbLrS0WiYmfsHEJrGzmrKN6dK7/7OXkMl7YXqm?=
 =?us-ascii?Q?8arubWfR+XHojB71s2HQ1J903hb8U9sSHi4y/pOZEc3KQ+Xh2nSN/Egt2Qnp?=
 =?us-ascii?Q?7XC54p4aSUocCQPPYHUYA53zjO3vh1OWZmHpGXAZnOePrn6suS9NIVcqD7mU?=
 =?us-ascii?Q?OAJQRGIwXH0/ya0zNimZlcwZXtmW9nsIPeN4c5hfM0naQm0V3OzMY/HfAikG?=
 =?us-ascii?Q?mNgBzL6cu03ECu+2NpHsvQC9Z9Aewp+B16K6sRjwt0RPOQZum8zbZ7og9xXK?=
 =?us-ascii?Q?JDPzdFUXG9mYHThJpkZuzCB1Ut/O7S9obQM2K+bFc7KNKCvryUa0FVWbriCt?=
 =?us-ascii?Q?WfIE5tcIMMjo06eKq9pRXuCzObvJb15Rmy8F9tIrxjede5bPRF3kmvs/8KOh?=
 =?us-ascii?Q?otTwt7MCZmkvHBe4CJbrk+NxGU0B7s+h8+nSjH5ciNqbwnvvUTe19i0f61xV?=
 =?us-ascii?Q?Cqfl1Q3tqrqdPOPzdFATyoOIj/LCuSv+jsUTKU6yvaChnTVmIwKCG8tDluRr?=
 =?us-ascii?Q?Ijwnn/8qgPw0S8++CHCwT7ElLwY0LPi3Bw0imZT4eGYqKSYq3VAyjYIEWvZZ?=
 =?us-ascii?Q?2ilsxjREBVApgxAyVBU2aaYNbWF2/BY6J5armEyt9yIapSdGm+zlqg238sk3?=
 =?us-ascii?Q?oZ8oB1JjRMDRqkSfD2d1MnAsUTmruGd0SxuOg1B6/+BFl+Xe8DaiWc1kRtfC?=
 =?us-ascii?Q?L8xsZ6nvdSiwuGlUAsswEVdiRUeqWwedbMULkW21qxt6cTGbdcCp4Cd/MKwv?=
 =?us-ascii?Q?0rul6qXxLFcx92xdX9okcX3m0Kbfp/xUr8NLpxvNNFnXvwEqjQK2oSoMBdSO?=
 =?us-ascii?Q?Fsp9RjB+oHGd4yNKFi3JKkns2yjjk4GqMpvVpmalcKmpCM6+xQl7sFmiMNba?=
 =?us-ascii?Q?n0CMKbdaCMLFBvDdJZLRGfCws0hDfpDgnSC6gCmYEGWGA2lGD5vDpRnx2dh8?=
 =?us-ascii?Q?CnDoNYztVt7wBCv4mGhMXdJVqqseCUYL/TIRP+wkdA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iH5HRHjYDnH1o4rn7rBz+WZ0ODK0rC3FfZAjQkDJT2ysenqBGkv91ZAht5vO?=
 =?us-ascii?Q?nYbZGCLq/pAHgEqgdKDs0JH1kWYi/Vj3z1UnKwvPZ/6KABvQvt4oX2bBKwiu?=
 =?us-ascii?Q?ufORE+t5LwWGo9YLFTPn4Snj9zq9yLV+EZaF+um4T3iz7jDWJjHi9/Dp/Z/2?=
 =?us-ascii?Q?wCTgl1HqS02qKx0unvwEdVUM/+ZHREWJRaokdrpCG5n1WqHRW+lY+VjBPGUo?=
 =?us-ascii?Q?8Rpt2cUlVWZHLSdZVFQWiM5CMnczSOkkowwL1ASlbG5ZsyAyPj2On0AAe6Jv?=
 =?us-ascii?Q?i38sgCBGy4p7jpnVxkwiLSxVyZGnrouBuYKAVpfaYVhVu0o901w8awLm9sev?=
 =?us-ascii?Q?m/3zEVeSr77v8QF/CUJMrf6sf9lQyGfdoMLAOGZjwpmsn//5fefPxnwpKkOb?=
 =?us-ascii?Q?22D+nNpnBubUnbeSCvr/p3js30iS2gme9tUe2BG9bNnfalLgtYSv/xPagyU/?=
 =?us-ascii?Q?ERZY7PZIBjwvlTtuf6eUEKnhfSkSg0v+jdiR9p8kbEWYnTc8F/KxFrJBfsZ2?=
 =?us-ascii?Q?EdYNnaWkaJquOD9M/Vfy/4SxO0xHGkvMlMtbSoz+kydKCEwfZwmTeYkpt4js?=
 =?us-ascii?Q?8m8zswUU+8p5hD69P2tG5T2nwi/LVI6NlMwOWemOSBH5WfklgNal9d5K+cyA?=
 =?us-ascii?Q?NqkzBhr55M59mJXqwQA5ubhf9yUoDPPFB+SuG+bSAIMMhOMzzXfmVyJRNx+K?=
 =?us-ascii?Q?OHBvGuAHKFuFnBEJenObRjPEJV0+DnOpI2QpAkQ89ZfiBeprLNZI5XvqIINk?=
 =?us-ascii?Q?4I7QJb4A8Y0SBP9yM07nrHOIW9AFQwRknEk44CReolJUymM2jSLi+p0d40f2?=
 =?us-ascii?Q?npgRCd6T4O0LOV9KwGrie5kFWC6TVSeQ6INuRVf/WMWYIUdKG7T1EBpQIOPz?=
 =?us-ascii?Q?QGV11HWcwtl2c6UNyIp+4t+ZDUW2zCll91dTZnAbX1DIsEZiLdfI5HL5HgQ4?=
 =?us-ascii?Q?ZYvepOvAdT0cpl31CYwuqPpGzLoQeOqBegTfgluHlgPCGvybVAM9fs+bg3Xt?=
 =?us-ascii?Q?1LZQ5JyxAaWhAZP7QA+fyMg3pXH+JAY0hH/wrBRLXpEhYFVTV2vN/WFnx2hm?=
 =?us-ascii?Q?GZ/oMfHdnRNmnbhr92ySAH4s6zdqSxkwUfF1Pcm4gJRnre+4ZUmuhQBJGFrP?=
 =?us-ascii?Q?AUY7dziU9Vd1UlKxJhx+P9luQMZm1O9BQ14ZXjG5H7GzQhicY8Hniu8v6nW6?=
 =?us-ascii?Q?IALMpXLCnk9O6ndKm5eYsJEB/JIdW0QQVXTPoezWJi9x5jLJRnhKKZQ0dsI?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 077b5232-f760-426b-ab73-08de21a1a5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 04:12:08.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7764

From: Peter Zijlstra <peterz@infradead.org> Sent: Tuesday, November 11, 202=
5 12:14 AM
>=20
> On Tue, Nov 11, 2025 at 12:25:54PM +0530, Naman Jain wrote:
>=20
> IBT isn't the problem, the thing is running objtool on vmlinux.o vs the
> individual translation units. vmlinux.o will have that symbol, while
> your .S file doesn't.
>=20
> >   AS      arch/x86/hyperv/mshv_vtl_asm.o
> > arch/x86/hyperv/mshv_vtl_asm.o: error: objtool: static_call: can't find
> > static_call_key symbol: __SCK____mshv_vtl_return_hypercall
>=20
> Right, and I said you had to do that ADDRESSABLE thing. So I added a
> DECLARE_STATIC_CALL() and a static_call() in hv.c, compiled it so .s and
> stole the bits.
>=20
> And then you get something like the below. See symbol 5, that's the
> entry we need.
>=20
> # readelf -sW defconfig-build/arch/x86/hyperv/mshv_vtl_asm.o
>=20
> Symbol table '.symtab' contains 8 entries:
>    Num:    Value          Size Type    Bind   Vis      Ndx Name
>      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>      1: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    6
> __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0
>      2: 0000000000000000     0 SECTION LOCAL  DEFAULT    4 .noinstr.text
>      3: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND
> __SCT____mshv_vtl_return_hypercall
>      4: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_return_t=
hunk
>      5: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND
> __SCK____mshv_vtl_return_hypercall
>      6: 0000000000000010   179 FUNC    GLOBAL DEFAULT    4 __mshv_vtl_ret=
urn_call
>      7: 0000000000000000    16 FUNC    GLOBAL DEFAULT    4
> __pfx___mshv_vtl_return_call
>=20
>=20
> ---
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -256,20 +256,6 @@ int __init hv_vtl_early_init(void)
>=20
>  DEFINE_STATIC_CALL_NULL(__mshv_vtl_return_hypercall, void (*)(void));
>=20
> -noinstr void mshv_vtl_return_hypercall(void)
> -{
> -	asm volatile ("call " STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall=
));
> -}
> -
> -/*
> - * ASM_CALL_CONSTRAINT is intentionally not used in above asm block befo=
re making a call to
> - * __mshv_vtl_return_hypercall, to avoid rbp clobbering before actual VT=
L return happens.
> - * This however leads to objtool complain about "call without frame poin=
ter save/setup".
> - * To ignore that warning, and inform objtool about this non-standard fu=
nction,
> - * STACK_FRAME_NON_STANDARD_FP is used.
> - */
> -STACK_FRAME_NON_STANDARD_FP(mshv_vtl_return_hypercall);
> -
>  void mshv_vtl_return_call_init(u64 vtl_return_offset)
>  {
>  	static_call_update(__mshv_vtl_return_hypercall,
> --- a/arch/x86/hyperv/mshv_vtl_asm.S
> +++ b/arch/x86/hyperv/mshv_vtl_asm.S
> @@ -9,6 +9,7 @@
>   */
>=20
>  #include <linux/linkage.h>
> +#include <linux/static_call_types.h>
>  #include <asm/asm.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/frame.h>
> @@ -57,7 +58,7 @@ SYM_FUNC_START(__mshv_vtl_return_call)
>  	xor %ecx, %ecx
>=20
>  	/* make a hypercall to switch VTL */
> -	call mshv_vtl_return_hypercall
> +	call STATIC_CALL_TRAMP_STR(__mshv_vtl_return_hypercall)
>=20
>  	/* stash guest registers on stack, restore saved host copies */
>  	pushq %rax
> @@ -96,3 +97,10 @@ SYM_FUNC_START(__mshv_vtl_return_call)
>  	pop %rbp
>  	RET
>  SYM_FUNC_END(__mshv_vtl_return_call)
> +
> +	.section	.discard.addressable,"aw"
> +	.align 8
> +	.type 	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0=
, @object
> +	.size 	__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0=
, 8
> +__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0:
> +	.quad	__SCK____mshv_vtl_return_hypercall

This is pretty yucky itself. Why is it better than calling out to a C funct=
ion?
Is it because in spite of the annotations, there's no guarantee the C
compiler won't generate some code that messes up a register value? Or is
there some other reason?

Does the magic "_662.0" have any significance?  Or is it just some
uniqueness salt on the symbol name?

Michael

