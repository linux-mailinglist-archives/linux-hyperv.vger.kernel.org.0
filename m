Return-Path: <linux-hyperv+bounces-5163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4348FA9DB20
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Apr 2025 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D33E3B2F44
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Apr 2025 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B99D190674;
	Sat, 26 Apr 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NZW3XoY8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012057.outbound.protection.outlook.com [52.103.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B818A95A;
	Sat, 26 Apr 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673979; cv=fail; b=JybTiDtQ+VqKbTHsVR6TceWbajHOUt6w1TudCCk81a4ctYEzLCwjVGpeUBDKSpT9ixQ9w8+eSBux+fTmd68tdMgnqHpGz8nUqNQq4JtQUwQb2BUUtbUUT825w5bqsyhmqA8FCG/zGKn8JsoX6zy0JHcJvIw6iYZbZxwNU/vY9XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673979; c=relaxed/simple;
	bh=L3W04Hm+DUaaxZo/pUAn//lLlOz12XWbERo8rr8eO0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQFtYCZxNFZYUjQfq3zYHpnwaHv7aXjtAfLu3jHkgfj3fmQhFnLKT5cokWmcY6yMLLGzU352NkDJd5iKE/wEnqymHevuiqUyaUL8EMB+kn0fQokTfbCHaYWylZyMUrGxrrHcfy3fmokLuFGGsJORHupdHOCq3XGwimx47LSHxoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NZW3XoY8; arc=fail smtp.client-ip=52.103.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXaDc1tj52SWTUQGuFN8KQKkdlUFyYidPzuBPkbXv0cwwZatsCu3V9lOyq8FEWH3VcKZQOjR8m3o+ki2A+PgsOcjDjdv+YoeObUmTk87ScaW6ApYKNSjtYasCCdAJf8Dbwm+6MfETwtsazn00ijJ6nZ16Xb4mLS/07FYPei53UJnSq+0QRQ5WTBjw278W+O9pzfUt3S7lF8XKzssh2HdE9DXlOT6E8/4cT1gG1ECKIzqceGCruhkIdG4MOt49zgbBfvxMq+LeaCCDHLh7STu4d8Nu+V5psAp3Vi+5P6waakXQoGTA3h14JcFNh522cwwL3NEa6PhJumZ+ImdABRIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atynWmraRXwnCya/a51daGKO/i8TuHTpAVBP4nCoL0c=;
 b=L9z4IJj5savW6gX/dpeGs19Pu9QMyHw8BzFSvOpIf/zRMuCWkMRALk63SR5olNdiVJJk0Fp+AeYwrF6udCca1ae7aiDQKqfmhPH+eKoxdVZW2WC06DKcWqS3UaRBw4m+ocoF7Qo18Gtz0J41l7m6RHzHf2wUh/JBc3YvFEVf/KYH9EB+CYxEzJVw1rV2XtJYuvk47Ree1VmkT0Fbg+Sj+5yx/rDeqLm61s29wQfFGbpz6QlH2q0m7hcHs2Z4ZiWu3lSxC8knn5yJxl8/WGciJeN4vn8eDJQ7p0m/wBKz4FvbPuN09JKeprdoY9uYlhMSylNks+XP9qEXEz7voM/OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atynWmraRXwnCya/a51daGKO/i8TuHTpAVBP4nCoL0c=;
 b=NZW3XoY8dLqCTNjaC4MtyoxgkPPyt7a7gAWztP0sULizGKpZiIxT/v2khDaWaiEJ1qpz96ZGGS4qvbBBDmyO6srRVRZFKNI8al2+3QRI0V2mY2dKyu65wABYvLBg199WNAB0oFwMO6eEyqNzcQPjkgQERAAW6H1m3Qk1nVFzCvp+sCe7AHhEahzH9VsHCZJYZcYhVOcsK3S8cyF2DFVmra7mcj+t6uioAlIAVweBMtAdvVQCilLzcyOallc9FuDaIWtVl1nSuHGN21qz+11IYeLE9JvEeV527ACJ59E+Yh5+W3hT+aOhRfoW5fW0LLKq+CfHU7Nbl9CyAnziDGTDrw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7871.namprd02.prod.outlook.com (2603:10b6:408:14a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.12; Sat, 26 Apr
 2025 13:26:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Sat, 26 Apr 2025
 13:26:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tiala@microsoft.com" <tiala@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v2] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
Thread-Topic: [PATCH hyperv-next v2] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
Thread-Index: AQHbtin36Lgs1J8eW0iaD8UlLPYfY7O16RDA
Date: Sat, 26 Apr 2025 13:26:14 +0000
Message-ID:
 <SN6PR02MB415714E8EAF22D01DEF6F7C4D4872@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250425213512.1837061-1-romank@linux.microsoft.com>
In-Reply-To: <20250425213512.1837061-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7871:EE_
x-ms-office365-filtering-correlation-id: 46cd1600-a534-405b-0a9a-08dd84c5eafd
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j2+rXb3faMtF+Xaa30Omw8BTVrxfo5JM85D77/ykLPYZaytxMNtxr6IIUvaKeNSqGdoAccax/GVJ7D0yNK/H2zfFEhaQ2uCZBoIQnyAd0FzxPtnY4KKZmh9edRHryUxhWzjLv0tXoEKMGY+4qJmtw0c2KV13BxsQDE//A/OxqY8WG26wAc5El1AX0mHKUmaLKct9qFckYN+98VsYIN8ShzuJ1RvhaL6p67Vj0JtA69/N8SDUCunkcB1AVcHkdDNBFANIOv6NVnSX9xgVfJTBaqcR/m6/UsvhO1B5cAgD1Y5qwXd+PckYk5++Hi7k/OVAIBlCsiSIYYB9NI8JMdux9/WH7AoWwDnMFXH3p5A2TZrMwIrOSKar12Zvm+wm13LmkG912l/jbQsYKJbgakXfWxSEybolHUyx1FpqO5kdAu483/qX+olfkBOn3dlIK60Voy/rVXELkM/5B2c7JdvefBRE47U4Xn+0zj/olgR256ioaL1Bb9msDGkyE9gbIFEEvWxtaNuDPlZ0LSY3JnluJpnlojj50b+f04fYxCBTDLyJYjrt0oUVZzdg4SbrsR8OVxNvqNQ3l5e9vMKycRzp9GIqleY+gkLQJJcZGLJklDUDARrAOusFUqJ+CQVW59UDtJN6eYFzexDWJbOqOTL4aPO93sjjd4QD7AzhU1SqQjVad1EQf98VI8Ko8LlIMdahGWbgV4hNLibieHSsBqya4o6I7pYK3KHeU/pgH24fdGd0pG+K2KFgXNb8x9ZzvwNas01EN10v0pZFjBJwIzD9um3ZTMcTHYUrFM0IFH0Kl1ALxuWraklQ3j24
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|19110799003|8060799006|15080799006|12121999004|440099028|3412199025|4302099013|10035399004|41001999003|12091999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?I0VC3eiMOacvgVlCctPMpmroMI+sVanBjKazLWpO4vNmhUFs7L2JM2B6zAvo?=
 =?us-ascii?Q?H5ttNi/nDUvXpquJW1JKw0C4EQNUTlp0DYN4c+Nqy3N8SiMCGIKP0AgNSUrk?=
 =?us-ascii?Q?gx3dPCIiWlPqIXWuHXvzSS7u3wfPY/+zwXWSJD3aJ9Ohzg2rDKSBdQaJ1b/3?=
 =?us-ascii?Q?T7LrMA0URruzmJubVWwwEv/mqvCt8tS5SVBqr7jwpR3HQ0L6U9PQ2YA0gAdO?=
 =?us-ascii?Q?NvRok26aH3zoCBn27k+7aCF7q3P2z8cSPKw6XbYYtruN1VYhwMBEJzvEzIxG?=
 =?us-ascii?Q?rqAXTblJj1mavZfv+uVVUlbIaWIyCFo/Iy7A7OehlBRzOQvkUySNDpzwqjmm?=
 =?us-ascii?Q?DO9p4fQiS9qZUGKR5RP8AD9TuIPZ6SDzHoME7kzL3Sa2OH/GntRf52TfgKtp?=
 =?us-ascii?Q?GUVlfLxf5lulfVQXglKpWzjgCSwcgviY2C9O5LBe2cNtoCKC3N5WGmW4rFqE?=
 =?us-ascii?Q?ojHUotJI3fbRpg0PCEFGKS3UuCzrvbzUy+9wyaPZ0q3m/DlNCmT+9NDVC0B5?=
 =?us-ascii?Q?fDo8MO4/DXINLh+1LbNnqG+tQqJm5hy1jP7J4tTzwWf/IO/ZKKGRLcCyhePw?=
 =?us-ascii?Q?fvaMobH2HEi+iG/oWghglUfNWdZTrdlXQiqbUfE1a/Uuhd04HGv2Nmy2swRt?=
 =?us-ascii?Q?/orjOdnc7dCEpbL7OJruZ74agTN7y26rhZqGSIthRQmkaebT6VU1DX8AEgsE?=
 =?us-ascii?Q?UME1JRjp0IlZ8w1bTiLj07UKICOveDg8Azv9soeSg9XJ6BlUESHP54zoPJeh?=
 =?us-ascii?Q?lZRSoWXti0vnGubrbp2UO5DL4pkahsP2bIfAy2yzkqVv9ODPnF+9AKTEkws/?=
 =?us-ascii?Q?ZFRinIXgRCx9eUYTf2i1t+2nWjbZWjjaz19a81sGLuqazttudAFYBmV4H/3E?=
 =?us-ascii?Q?9fXymosbjRLtxeEIOSh4RtB+orCZyMTHBpyHO77RLRo6KUxp/jTB/g1UxO0h?=
 =?us-ascii?Q?LeLVYKWhM5xCAkwthNHIALUAxS6ljZ367XQJk+slTAN0KG58jx+SYIuOJ72I?=
 =?us-ascii?Q?VykYYpoLU23FCnvSs6Ra4Zy7cKQ3j8Rfgfh9ljko0r8BnscOXgMuOpopj7ZN?=
 =?us-ascii?Q?gN3v0+HbwzYlOULEZU+AHAkJE5dIfrMfE4gIOT+E8x6wVSuYIMxPB0K9FcMX?=
 =?us-ascii?Q?mPOCd7lIS3UFqYqJEEcqlB6V0rMc78PBMMPcQC6OrZWCKkuO0ICQZ9qxxq5l?=
 =?us-ascii?Q?ifpQGpVHFsE+MzYc6b4JI/JhZ6rP0ZsM/3ry7QsRi0LyZ00KtpJ4YFQkj1jl?=
 =?us-ascii?Q?c6FdYder33WjIUrqDxJOmho1k+Nko0+fKF3FXGkmO+isNW0ud4hzrYlT5IJE?=
 =?us-ascii?Q?UuGJb2C/4BOTP1Jb7cu54cYHJiyVqt9TORdeD98bel914A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ku2IoSEAaEC3pAnIW38O4TGNC7cLVoZKkZ+US/r2GpT9TvKlzwNeqCXDB7AB?=
 =?us-ascii?Q?l9qG6d2Kc3r2DGcoxx+5UgUjEtzbRGTfAVwtglYJIY2PSaFIRycIvgHVlxYz?=
 =?us-ascii?Q?nqoewCjYqpLR9xcDBgMZNsJafg/2kcMl+VqknS/hjjocCRYOgRovEqKb4VKR?=
 =?us-ascii?Q?i3YhmZo8Ueotwq9YOdlbxy7SEy9SOqXuDdDXB/iFHSY9A4PEvStGw5NMRzaH?=
 =?us-ascii?Q?v6lJUMTH8oGU8T5Ve4BZ4B008HqSMx0XeFsDWQCGnfH5TCJ2PedKdrmL+XY8?=
 =?us-ascii?Q?3n80bopOKP+h1FTQjbCoSH61T1mXbemE4X21+cX59tfxIMRenJbDko2+xxUi?=
 =?us-ascii?Q?EHWC3V1SpIOCGeYnCDlXnIvgIVCVspnnonzn70grBJKHFijb7tQHNl2EyWhO?=
 =?us-ascii?Q?6XnByfmzM8MEUP/MAJNwKwkFRHKeUqZNf5TiKu+Cu/mPtYNU8QuqOxIGPX0G?=
 =?us-ascii?Q?oz8qJQ1up8OG0dzFCAqMNU5nobzhlp0KW2aPh59hAxYgl73SRFAWHWksXgId?=
 =?us-ascii?Q?nQSG2c8JNk9D9kwjJQUSzvI3jg3oLKt1mX3dtNHo0gBZnqo9zxK9pAcx/Z0K?=
 =?us-ascii?Q?2Vj9xGAQVkBG0aUnR+ngV55h+l65x1kUtf5gBRLcvCnLDhFr6qFlLUkOT9tH?=
 =?us-ascii?Q?H6YgBzYBIAto32H1s84GgPLJMiKK1Zb1hEM7uIUddPwP+ijx2byWLOfIj8rd?=
 =?us-ascii?Q?ibeKCQBGUOiorbjJSKOha0ThbINH6C92w6R4g53v2uIAw4qAZMFYAgjF+Zzv?=
 =?us-ascii?Q?dNcLo+sXU6Q/R/Kwii7vlwsbZarKD098zYlNSUXUKC0d5mNqgRYl3apn4Ku5?=
 =?us-ascii?Q?k0da3W1+ZI/2xMHUlt4DKthFzd0bSzwJPnrAAprCtXg0dlR2vd1ZAaFpiT3h?=
 =?us-ascii?Q?K2g1j4JbvfqYbM+kN8I0cirPJ3Urfw3TUCQbwmR7cPk6rYGG2wATgZRdBnoE?=
 =?us-ascii?Q?l685LXusqaCifOizXoN7lrTRa+skPOjBO+zXicDUSVcpy1+Ur7YExJV4vBVC?=
 =?us-ascii?Q?cCOFsko4hc0ytaWJJ+RJzqR/ikn0OzaXteQYgzatRetEg5MQCx9Adz9amykb?=
 =?us-ascii?Q?wZFjlx5FaRdi6G2uQ18AU2Qo1l6D7Y+9CmTTLxgqqfCaFCqS2lNDab5sZ8Or?=
 =?us-ascii?Q?7tH5dAqVwK4iTTkPi0YU+tkI4qpuXP1AbNaXiFxiwFbAjSX/1kSJSQnwARxx?=
 =?us-ascii?Q?nAXkqI87Gwm1+Wx9N7AA8LcS09msngKyn8323LAKvnOvUz38AFntnLmTKfw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cd1600-a534-405b-0a9a-08dd84c5eafd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2025 13:26:14.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7871

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, April 25, 2025=
 2:35 PM
>=20
> To start an application processor in SNP-isolated guest, a hypercall
> is used that takes a virtual processor index. The hv_snp_boot_ap()
> function uses that HVCALL_START_VP hypercall but passes as the VP index t=
o it
> what it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>=20
> As those two aren't generally interchangeable, that may lead to hung
> APs if the VP index and the APIC ID don't match up.
>=20
> Update the parameter names to avoid confusion as to what the parameter
> is. Use the APIC ID to the VP index conversion to provide the correct
> input to the hypercall.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
> The previous version broke the build, apologies! This version fixes
> the break and has other improvements suggested by the reviewers.
>=20
> [V2]
>     - Fixed the terminology in the patch and other code to use
>       the term "VP index" consistently
>     ** Thank you, Michael! **
>=20
>     - Missed not enabling the SNP-SEV options in the local testing,
>       and sent a patch that breaks the build.
>     ** Thank you, Saurabh! **
>=20
>     - Added comments and getting the Linux kernel CPU number from
>       the available data.
>=20
> [V1]
>=20
> https://lore.kernel.org/linux-hyperv/20250424215746.467281-1-romank@linux=
.microsoft.com/=20
> ---
>  arch/x86/hyperv/hv_init.c       | 33 +++++++++++++++++++++++++
>  arch/x86/hyperv/hv_vtl.c        | 44 +++++----------------------------
>  arch/x86/hyperv/ivm.c           | 32 ++++++++++++++++++++++--
>  arch/x86/include/asm/mshyperv.h |  6 +++--
>  include/hyperv/hvgdk_mini.h     |  2 +-
>  5 files changed, 74 insertions(+), 43 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ddeb40930bc8..611647bfff90 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -706,3 +706,36 @@ bool hv_is_hyperv_initialized(void)
>  	return hypercall_msr.enable;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +int hv_apicid_to_vp_index(u32 apic_id)
> +{
> +	u64 control;
> +	u64 status;
> +	unsigned long irq_flags;
> +	struct hv_get_vp_from_apic_id_in *input;
> +	u32 *output, ret;
> +
> +	local_irq_save(irq_flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->apic_ids[0] =3D apic_id;
> +
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
> +	status =3D hv_do_hypercall(control, input, output);
> +	ret =3D output[0];
> +
> +	local_irq_restore(irq_flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("failed to get vp id from apic id %d, status %#llx\n",

Nit:  The error message should say "vp index" instead of "vp id"

> +		       apic_id, status);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hv_apicid_to_vp_index);
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 582fe820e29c..dba10a34c180 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -205,41 +205,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, =
int cpu, u64 eip_ignored)
>  	return ret;
>  }
>=20
> -static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> -{
> -	u64 control;
> -	u64 status;
> -	unsigned long irq_flags;
> -	struct hv_get_vp_from_apic_id_in *input;
> -	u32 *output, ret;
> -
> -	local_irq_save(irq_flags);
> -
> -	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	memset(input, 0, sizeof(*input));
> -	input->partition_id =3D HV_PARTITION_ID_SELF;
> -	input->apic_ids[0] =3D apic_id;
> -
> -	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> -
> -	control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
> -	status =3D hv_do_hypercall(control, input, output);
> -	ret =3D output[0];
> -
> -	local_irq_restore(irq_flags);
> -
> -	if (!hv_result_success(status)) {
> -		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> -		       apic_id, status);
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> -}
> -
>  static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip)
>  {
> -	int vp_id, cpu;
> +	int vp_index, cpu;
>=20
>  	/* Find the logical CPU for the APIC ID */
>  	for_each_present_cpu(cpu) {
> @@ -250,18 +218,18 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, =
unsigned long start_eip)
>  		return -EINVAL;
>=20
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
> -	vp_id =3D hv_vtl_apicid_to_vp_id(apicid);
> +	vp_index =3D hv_apicid_to_vp_index(apicid);
>=20
> -	if (vp_id < 0) {
> +	if (vp_index < 0) {
>  		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
>  		return -EINVAL;
>  	}
> -	if (vp_id > ms_hyperv.max_vp_index) {
> -		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_id, apicid);
> +	if (vp_index > ms_hyperv.max_vp_index) {
> +		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_index, apicid);
>  		return -EINVAL;
>  	}
>=20
> -	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
> +	return hv_vtl_bringup_vcpu(vp_index, cpu, start_eip);
>  }
>=20
>  int __init hv_vtl_early_init(void)
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c0039a90e9e0..eb2c67e80423 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -9,6 +9,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
> +#include <linux/cpu.h>
>  #include <asm/svm.h>
>  #include <asm/sev.h>
>  #include <asm/io.h>
> @@ -288,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area =
*vmsa)
>  		free_page((unsigned long)vmsa);
>  }
>=20
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
>  {
>  	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
>  		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> @@ -297,10 +298,37 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>  	u64 ret, retry =3D 5;
>  	struct hv_enable_vp_vtl *start_vp_input;
>  	unsigned long flags;
> +	int cpu, vp_index;
>=20
>  	if (!vmsa)
>  		return -ENOMEM;
>=20
> +	/* Find the Hyper-V VP index which might be not the same as APIC ID */
> +	vp_index =3D hv_apicid_to_vp_index(apic_id);
> +	if (vp_index < 0 || vp_index > ms_hyperv.max_vp_index)
> +		return -EINVAL;
> +
> +	/*
> +	 * Find the Linux CPU number for addressing the per-CPU data, and it
> +	 * might not be the same as APIC ID.
> +	 *
> +	 * "APIC ID !=3D VP index" is rare/pathological and might be observed w=
ith
> +	 * more than 16 non power-of-two number of virtual processors. This is =
not
> +	 * something backed up by the TLFS, just a heuristic.=20

I don't understand these two sentences. Since the TLFS doesn't tell us anyt=
hing
about how Hyper-V assigns the VP index value, any comparison with the APIC
ID seems invalid. Even as a heuristic, the comparison could give a false po=
sitive
or a false negative, so it's hard to take any definite action based on the =
comparison.

Also, the condition for APIC IDs not being dense is having multiple NUMA no=
des,
and the number of vCPUs in a NUMA node is not a power of 2. The number "16"
specifically doesn't come into play except that more than 16 vCPUs might (o=
r might
not) indicate multiple NUMA nodes. And I wouldn't characterize these condit=
ions
as "rare/pathological" -- there are quite a few VM sizes in Azure that meet=
 these
conditions, and they are perfectly good and normal VMs.

> +          * We'd like to move this
> +	 * code over to the place the CPU number is known rather than has to be
> +	 * computed via the linear scan like is done here.

Again, I don't understand the statement about "moving this code over".  Cou=
ld
you clarify?

> +	 */
> +	if (unlikely(apic_id !=3D vp_index)) {
> +		for_each_present_cpu(cpu) {
> +			if (arch_match_cpu_phys_id(cpu, apic_id))
> +				break;
> +		}
> +	} else {
> +		cpu =3D apic_id;

I don't think this "else" clause is valid. Even if the apic_id and vp_index
match, that doesn't tell us anything because the match might be a false
positive, as noted above.

Unfortunately, I think we're stuck doing the linear search for the matching
apic_id in order to get the "cpu" value. However, in the bigger picture,
I would note that the caller of hv_snp_boot_ap() is do_boot_cpu(). And
do_boot_cpu() has the "cpu" value along with the "apic_id" value.=20
Unfortunately, it only passes the apic_id as a parameter. You could
consider changing the call signature to add the "cpu" as a parameter.
That change itself is a bit messy because it touches several other places,
but it would certainly clean up this code and the similar VTL code.

> +	}
> +	if (cpu >=3D nr_cpu_ids)
> +		return -EINVAL;
> +
>  	native_store_gdt(&gdtr);
>=20
>  	vmsa->gdtr.base =3D gdtr.address;
> @@ -348,7 +376,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>  	start_vp_input =3D (struct hv_enable_vp_vtl *)ap_start_input_arg;
>  	memset(start_vp_input, 0, sizeof(*start_vp_input));
>  	start_vp_input->partition_id =3D -1;
> -	start_vp_input->vp_index =3D cpu;
> +	start_vp_input->vp_index =3D vp_index;
>  	start_vp_input->target_vtl.target_vtl =3D ms_hyperv.vtl;
>  	*(u64 *)&start_vp_input->vp_context =3D __pa(vmsa) | 1;
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 07aadf0e839f..323132f5e2f0 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct
> hv_interrupt_entry *entry);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
>  #else
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { retu=
rn 0; }
> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { =
return 0; }
>  #endif
>=20
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> @@ -306,6 +306,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned in=
t reg)
>  {
>  	return __rdmsr(reg);
>  }
> +int hv_apicid_to_vp_index(u32 apic_id);
>=20
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
> @@ -327,6 +328,7 @@ static inline void hv_set_msr(unsigned int reg, u64 v=
alue) { }
>  static inline u64 hv_get_msr(unsigned int reg) { return 0; }
>  static inline void hv_set_non_nested_msr(unsigned int reg, u64 value) { =
}
>  static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
> +static inline int hv_apicid_to_vp_index(u32 apic_id) { return -EINVAL; }
>  #endif /* CONFIG_HYPERV */
>=20
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index abf0bd76e370..6f5976aca3e8 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -475,7 +475,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_CREATE_PORT				0x0095
>  #define HVCALL_CONNECT_PORT				0x0096
>  #define HVCALL_START_VP					0x0099
> -#define HVCALL_GET_VP_ID_FROM_APIC_ID			0x009a
> +#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>=20
> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
> --
> 2.43.0
>=20


