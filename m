Return-Path: <linux-hyperv+bounces-4634-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3889A69A44
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D96C3BD108
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E842046B2;
	Wed, 19 Mar 2025 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DT6QvF8a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010011.outbound.protection.outlook.com [52.103.10.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF61A7046;
	Wed, 19 Mar 2025 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416685; cv=fail; b=A6Nu+eXJkZpt7E1+va5NMCGb1yXTIzTTVpuMiGjB19p30798cC6j3f3WeMrVeT0Elkj+gfS11+TtA9PUehJmkaIT+a4uVE8oDVwhZBd0O/uEX+0v3I11Mtn0ClRqgTnWv5QLOpv+JqjywHdXO//5HfJ/Rl6cvRvLoaCycObv/Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416685; c=relaxed/simple;
	bh=aZVMCHMm2lDev3q3b9adWhnhFMlZSdcPeqiyvWmnooY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQNi0g04KSGnfR+tuFnJ37Zwz3Oqy/SNr3d/XCP8lOuRNQEn/TxtqmXmmDj422YIB7sUHUd0BNbi2f0XnydXdLeUV/zLkZ/SUAj1XSb/1Z7Gpf9EvIm6O7mqhJ5IQmjCi1ho5oFIlZT4iWUUA0nKyO6cVlCxxds2AkBk9kUJj7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DT6QvF8a; arc=fail smtp.client-ip=52.103.10.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uln6lQwnQLnWpFwK+X/8y9RqAMBKUbx2KTvm+GrZVl2NPdcKimxtuuNqtjbgQeJ/0dBmYLEY9QGttPNmqjjYGIoLjyWpUnd3nibdne94lZmNS1wJZAYuNkeIoQ+yctk6hD6BjO5Jmge+n+j4EhfAKMuErqz4WSfFkCu3SjJ1tmKvvH7HxgqQ2XI12VOxhT08SnoyIsIXAFlX2z2q/m+uyq6Ak5VvPpXaljurOBIFGgVK+jA59lOLCkZ/t7PWLLrMgV4zeR3nm8760SS/bkG3EHeqDaUQIulazekZ06uhcGl6ou+M5elm7qZ13QakLjVM+/NW6mW1b8XCY1lPuN6SVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3a1IdKvQOUlnK76olcJAHqAdRYnXt2TWsArw5A5/4Y=;
 b=kasGml+w6czmzgXaXELSv2Wuw3stx8zEZ6nzykQ/sGl5w4xLSJkW4jDDxi/LcUF5nz2UwR0Uqsw5egL7TiQ2FH4iiaQ2kzRiFhsiB8ReWDy4gfIzjZhMcBmA2yxPa0IBqu/ciiJxnF7106xSI/AsGCTWBfj4PUL/BCrZ2GtQS5PxjF1SQxIxN/gwAb1Oa3y7aE8tqVIWrTe67WLNvsaDPjVnggdrd1eV5769DrBO4uaywwkWBdc2fFQm/V+CLSkXSFGZL9/TzGU/P4wbCKyQn1KYQMw0wJMBPFOVdWCIP53lWE0xDfrqyOlT8V8IP/QU3ivH18da5cc4+bouFn/7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3a1IdKvQOUlnK76olcJAHqAdRYnXt2TWsArw5A5/4Y=;
 b=DT6QvF8aNgNe9ky6iKSEYu8osfypA/tzCfDnab46RbowzfNOBt6XC1Yj/2k+jjkTN9Of+GPtm+DbbguD2BrHxfVtFvOswq0McquB233cfCLRPGTILFNpDAQhTzuvaWDof/Ba1nOcBsVYLTcGfqassdXQGd1LEUskU5htDN1sRAXviN8x20onz+L/S2cihnzbByQMgRWn6kmCrZUCoaWebEXtamomfYrPTuCOA/7HgRuPFwyCPlmTPs7HJwgUpUw0z/4PxjqQLNfzgtWPwJi3Wy3wUIUzyA+pyfhBh6GTxSc6vUlh8eeNkn/C1DOXXeIYExGFWge5bmmiJjBXnPZGQA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA0PR02MB7419.namprd02.prod.outlook.com (2603:10b6:806:ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 20:38:02 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 20:38:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: fbdev deferred I/O broken in some scenarios
Thread-Topic: fbdev deferred I/O broken in some scenarios
Thread-Index: AduXqaeNbacCNH8yTNyrrucfCfcIpQANa9qAAEuI+tA=
Date: Wed, 19 Mar 2025 20:38:02 +0000
Message-ID:
 <BN7PR02MB4148864DDB065271B79FD3E4D4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a4fa1dbb-4989-4fc2-acbc-055f786e9b48@suse.de>
In-Reply-To: <a4fa1dbb-4989-4fc2-acbc-055f786e9b48@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA0PR02MB7419:EE_
x-ms-office365-filtering-correlation-id: b59f31f1-54c4-4ecd-7f50-08dd6725f1a5
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPgu9FUvYZ88hunKvKD6srSaZYtcnzA+1vl/i56xdtnYLFRgd6wQQNcl/d8BcGsJerE8eueQvdkkb/bano1hTn0xOreRfj3KKVyDQJE3mS16EjE6XNOT0rDPlxp+0o+QIdB8UqIDgBlZ8X2YTsflGiDuiD9t1l6vw4SVkkjkTAXgirA0Nysn4tc9nAvFqaiRE+1AlkW9lp+zzeJgsFY0HmwyUnWsqs2QAj3lacR2B/ETH3ngailf0WrDaiY+EtlOr+Qmm/EzvyC3DDMmfis3HqeFnSYMlAlKIEHJiIqVTJ2CCyhLsf/691lxBFcShGrrQKO0Iw/B/9Vvys7S3ebaA8pP+phRxOXvVq4GRPM/Ydd2xLannWpP7fr9/NfkFXazUOf956Ddv1UCQ8Kt7Suls5+cjQPg7Q/GtU7qTa5IToyixFoFPeRXHs1Q/tUB1otPk2ZesdkIskr2cZWvLBDefs343SFwb64XVo04Dw77sr99H3g19qKOd+C2VXu5UkZR78a/knNyTbvyaOkAUF8Rrx3UQ5NkdIT9glAjjYRp5gqRfjYHapl8hLMbGqdqb1capc1qz+4gaE3bABPK+qWFyq4Y8IfKN2DrealgVMXWLlbzoOQYBLQ6lB1B4EGnhfr7Xh5aesHovOFpOHT1UnbwiKGTvqjDsnsqvGrinzOiNplI93/+TqUa+PQ5496fBSdgAcFpf7dvYu0ofvPdqlvFXgcXTQmAQuLljTQyupOvRq4mC6W+gjaCq9oOcmjNDVDTDg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|15080799006|461199028|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ayA5OiFd1CktjNafQYW9lNfUFJ1abkEdkmopfg9jAu3entOcwQA4xyokG/y7?=
 =?us-ascii?Q?cgaT9n7qZc1v0tPtE55Ew+eCmMbD66DRlu5fx0xCXpS7lGy2tXHo+awpLUta?=
 =?us-ascii?Q?c1LTzL/GAb4mbzMW9JHn+8JbC7X9XpWrii+e2vcLqyaUaIjVLCL/EjojxtTE?=
 =?us-ascii?Q?WBGDmcMDhxIEtZ9cqO6ZvoPEtcYGdGAi/Nx1BlA3rLvzHb88xp4e71rOGlkh?=
 =?us-ascii?Q?TJt9HjL1AUHRzxDUJHcdVxT3N1+FRd3LRl9T+z3y3i4lW1nt8pnv58TDIJ0C?=
 =?us-ascii?Q?87QzV/X8Uqd+vNedvb1I6uy0RY8AuqpgpFiWaBRATiGNroDFhW4mgc8y7mcZ?=
 =?us-ascii?Q?gXNj7GUJWhi4dVHMeCL0OBOxiYIdVlSTP4rzzFOmNAuozYrbrOpms+YiDOnf?=
 =?us-ascii?Q?pUE4nrXgSXEPE7yL7nnEITvyuxH+8O2vDgCCzjTQVU2LXKRoZozE098znSUm?=
 =?us-ascii?Q?mp+HhCz+flIcwmmYyW2U8cTb5eWwSAYZp7MJsEOULp8YarJwsq7guKddWDTQ?=
 =?us-ascii?Q?kRhOor44xQ5Wfwq73Hmm15TUCXzfBBugZA/8ArFL/zyKd2cNoVhX5eAzaLt0?=
 =?us-ascii?Q?JJ5msZ3h2HkLsgOqtawR43mBCgU0gYWqhKxEjFm7JKBmefkMnvKxbAebxNAc?=
 =?us-ascii?Q?jS76eX8x4aqxIRrvokP58Uby6AHSV/EgMWO+sUIzeLY4GPNmEmMbcSpkWUo2?=
 =?us-ascii?Q?BgEf3hsqkf/lbh+t/I+Y438fazYyundfLebMFpXQzGMhtlHqPcuvB3+AYRqk?=
 =?us-ascii?Q?j/aU99Z97KxlYPDCH7oKXOKV3Iy1p+CZVNsx9gSAVZuHjF5o5TkaSbkdU+qh?=
 =?us-ascii?Q?UUkSoFe25Z9hWrLsBJbBaDHjsNkVYG7vSRvAA92yINVGwcmbxX16hcZ2tnzZ?=
 =?us-ascii?Q?kU4JQBdY0CMTtJg/XhoeMSN2SIx8aoM79WPme47CK2RZDF8BxfGvAZ3IlOBD?=
 =?us-ascii?Q?9sRqRIWj/FUsVXozFJrxv5vkWlfUouEmZN93ZED5KqwXdqeQ+pCSkamKaBHS?=
 =?us-ascii?Q?1EXznW3acPRmrs1xb5ez8g7QIgSm8wceXWsGSFevg78zaTeiEw9q3UXfHkLt?=
 =?us-ascii?Q?jx+AsvclNU7wsYJnaFSZx8L6AUv2UbWFWH9pKNLzTpgprfaKj1bpvRWXuWbw?=
 =?us-ascii?Q?pUoVDaSGMCBO?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LL30lG1qO850XpywtpOzH+Gu6O3l69yuKrTA8PEeJMHD/4OkoYGvtRmjeTKE?=
 =?us-ascii?Q?z5cMGVv/j6S3tqOtVb67f4d3vsdzC2TahB3TvYzUPd8Bs0GYVV2q2ykbILrK?=
 =?us-ascii?Q?XBlm9T/QOfdUr1VhMeYUNO2IYy4Fvm93lKiENm909zcmcDy2qR+zlsRV65HN?=
 =?us-ascii?Q?xzhAeqMJ528sQyw+qXOZQeXyTCDebvaF7Gcbo+UiMQstWrBtl5HUH5Gw1mVS?=
 =?us-ascii?Q?Fq9n66C1p25wY9nUSSAtg/1gePRKH8BxxjPUHRCE1CV0j/9StSADgpiOly0Z?=
 =?us-ascii?Q?e+Kc8ehlsEDJDUl3lb8j/NRJUvtwc83lS9tb/aNT4SAQKEC6QyVLyYWLe3aM?=
 =?us-ascii?Q?NHbB7ukhsds7B/RP86Btt++T58nLmpZwq2m7SGmhS9TJnqPTC/vqUuLhY3kl?=
 =?us-ascii?Q?O5/uuirPPjw5tlC4B0zdC05+TdCpJqMYKhhrZ9BtDgntjTA83P5MEgMlXq7P?=
 =?us-ascii?Q?dhAWcJvrrLTDTMGa2calcute5NJzS5ecwlKVDFsulSNkNVwxMd4dbca1yylW?=
 =?us-ascii?Q?YtxosIeL2quMweosMPANrS2ve7ZUT+1z5W0bKXtTGkUVnm0ko3XTGfivxIMy?=
 =?us-ascii?Q?pIm8Js/a12i3TaaneYuSkaz0HAY9Ya7nUYAJPuRwvE1hgkS40HArw3pmcgSm?=
 =?us-ascii?Q?ynFHIohk1valGVD+WiwYzzxN5u1U3+hHh2gRMIps75DeRf4bQ+sncZuWhp54?=
 =?us-ascii?Q?9P7GBgLmgJiWNG7/8xM1810A15PC8IZto6GAB+TGu08/8YHa3xAwoip/kWEe?=
 =?us-ascii?Q?1youBrkphHmAiYUS542mQSB+PsBToTdfEBPUvJHF0Vdy98Ywp9NtgvFxwIOI?=
 =?us-ascii?Q?/JLToChpGMAkthHemYMakKTLzsEjK59j+DocpIp3GRXNuDp2GJHemwEQ8SAY?=
 =?us-ascii?Q?Dl/XCicEVxxT4wfv/cYxxrG9zgUmJh+UMd4G98Hz0erIi2HJMxAX4wiIlgmD?=
 =?us-ascii?Q?UOXOIHd+CUK9eAfyDuYYyfFlxwcfWC+NsolVYzVGt4hb4CoF9xW3lNBB4E++?=
 =?us-ascii?Q?t4uXxnQl9b/U2ZzE9sxUbcgCV9van/Yc2+OqqwBBlH6Ci0nnXmKx8wRfSAju?=
 =?us-ascii?Q?gbFqFO8FMi8lodPuu6FWgGjH2ZiS8KahObFdJWnUo6n1jjL2jPfDUrbfooHh?=
 =?us-ascii?Q?/0vdsFsJi5DzQ94enyJ11VWXTRD7rqi3i92jrwzUcI3Up2NH9VNhO02VrScv?=
 =?us-ascii?Q?WH/+o3WFIOzvuQvXAe3StHU6DK2GqxuGuyvr3aY1fJYIzrDi548CU2IHTGE?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b59f31f1-54c4-4ecd-7f50-08dd6725f1a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 20:38:02.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7419

From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Tuesday, March 18, 2025=
 1:26 AM
>=20
> Am 18.03.25 um 03:05 schrieb Michael Kelley:
> > I've been trying to get mmap() working with the hyperv_fb.c fbdev drive=
r, which
> > is for Linux guests running on Microsoft's Hyper-V hypervisor. The hype=
rv_fb driver
> > uses fbdev deferred I/O for performance reasons. But it looks to me lik=
e fbdev
> > deferred I/O is fundamentally broken when the underlying framebuffer me=
mory
> > is allocated from kernel memory (alloc_pages or dma_alloc_coherent).
> >
> > The hyperv_fb.c driver may allocate the framebuffer memory in several w=
ays,
> > depending on the size of the framebuffer specified by the Hyper-V host =
and the VM
> > "Generation".  For a Generation 2 VM, the framebuffer memory is allocat=
ed by the
> > Hyper-V host and is assigned to guest MMIO space. The hyperv_fb driver =
does a
> > vmalloc() allocation for deferred I/O to work against. This combination=
 handles mmap()
> > of /dev/fb<n> correctly and the performance benefits of deferred I/O ar=
e substantial.
> >
> > But for a Generation 1 VM, the hyperv_fb driver allocates the framebuff=
er memory in
> > contiguous guest physical memory using alloc_pages() or dma_alloc_coher=
ent(), and
> > informs the Hyper-V host of the location. In this case, mmap() with def=
erred I/O does
> > not work. The mmap() succeeds, and user space updates to the mmap'ed me=
mory are
> > correctly reflected to the framebuffer. But when the user space program=
 does munmap()
> > or terminates, the Linux kernel free lists become scrambled and the ker=
nel eventually
> > panics. The problem is that when munmap() is done, the PTEs in the VMA =
are cleaned
> > up, and the corresponding struct page refcounts are decremented. If the=
 refcount goes
> > to zero (which it typically will), the page is immediately freed. In th=
is way, some or all
> > of the framebuffer memory gets erroneously freed. From what I see, the =
VMA should
> > be marked VM_PFNMAP when allocated memory kernel is being used as the
> > framebuffer with deferred I/O, but that's not happening. The handling o=
f deferred I/O
> > page faults would also need updating to make this work.
>=20
> I cannot help much with HyperV, but there's a get_page callback in
> struct fb_deferred_io. [1] It'll allow you to provide a custom page on
> each page fault. We use it in DRM to mmap SHMEM-backed pages. [2] Maybe
> this helps with hyperv_fb as well.
>=20

Thanks for your input. See also my reply to Helge.

Unfortunately, using a custom get_page() callback doesn't help. In the prob=
lematic
case, the standard deferred I/O get_page() function works correctly for get=
ting the
struct page.  My current thinking is that the problem is in fb_deferred_io_=
mmap()
where the vma needs to have the VM_PFNMAP flag set when the framebuffer
memory is a direct kernel allocation and not through vmalloc(). And there m=
ay be
some implications on the mkwrite function as well, but I'll need to sort th=
at out
once I start coding.

For the DRM code using SHMEM-backed pages, do you know where the shared
memory comes from? Is that ultimately a kernel vmalloc() allocation?

Michael=20

