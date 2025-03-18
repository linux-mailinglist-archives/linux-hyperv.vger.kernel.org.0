Return-Path: <linux-hyperv+bounces-4568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C4A665F4
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 03:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE68171929
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 02:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89981865E5;
	Tue, 18 Mar 2025 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p5/+PcWY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010004.outbound.protection.outlook.com [52.103.10.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0807EEBD;
	Tue, 18 Mar 2025 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263515; cv=fail; b=eBWn+cT/HD5YOU5DyDNH4HHKqPpp3QxxVWQ56u+Bn7abnFjOsYr7Op1HOaFPdlpRWz/LGcb2nB2gQcJBHY0r4RrHXU0qgvDGfs610kU9NC7IFGRXMdqOiXbq17Ly9Hexix6RDxQVu1dWYkLcx9WiPfcFrhuSSQwzk8OQRxTbInY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263515; c=relaxed/simple;
	bh=vRLyz650EZTCRafO9Z6AP3heDr491czCdxzaCHCix/w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GUXiTh5QrkkYhjdXdiVteU5XchyTrdQzIXNgwUa25aFI9llUt2jdu8XtO6VgC29Y3R2NvLJ8uFytBbABSh4D9LmuFn2AXo84hFLEKTNJAlRXNF5l2vGMA6fSwQR5k68qQlexeHr5cXnqrCxNHwQFB9oT3wetR9Nttd3T7hbpv/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p5/+PcWY; arc=fail smtp.client-ip=52.103.10.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWIgyYvVJEAOQRCHgGZX2nBbY349UgBIiMRCUdEpdP2PcpuAI9HhcfRvlcaaO+SeV6Q6dzsbdGkeRsMO3NuMoMW0GlUTi06LP8xQZYWiTw1mdbB3FFq2xkVGa0zHIrGivFZC72sTPHmaBBNY6D2wOYPMz5LmtiKhTgp/1yE6MdSLOOceLoBK/stGuRCed5ytCSbyGbTlJ/5486Qfu8pzhN9yFBPz5xBW6vCbHFdUUB7FKiYxoxhhaYsy1+6DwRFNrGgB4zSWvHi6HZyCu6vDHrBFsyTmNDWKwOytj9mrOMXMMkEWHRVtYqyavIYEOzjXUWVeyCDLcdtJ7X09Vhrclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnhypWCDiz9KdfJ7YC42u6Th1gaMb/mB18o+ITAmjpE=;
 b=EW3rhduh+2utbfDqlR398SphCw+0V6D+K6hOoR7hLaKhFjN9/ZiPV8Vkeqa02igDo0HhSIwIX3e6Mz8AdLww4h+i2us9lfEChCB7a28O6uv/HbERFIjspoqwPzYBhP5CAI7/BAJxozfrfpiFMQla4gCHoRITt7Puc4xuCrBhUwQ7+g090gASMPmR0Kq+UCjfa/WIpTyAqJiihHVe8JsExjNwTFM6ZYMpzclJpCqm/Y1DvuPTJqS/zKBGJAd/jfYhUzz14JxnpKmUA6mmt80xmv81Nw4vpHEsKmYS3X5aYxDUsnXTT/rUpEXgC/mZvtChCFt3zCNpEsR66VqwF6yPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnhypWCDiz9KdfJ7YC42u6Th1gaMb/mB18o+ITAmjpE=;
 b=p5/+PcWY7tR1R4NprI8mSGQOm1/oOY45NHUyBZ81/GdidRG6svD2HWofrbg5P/yw2pdYoiYkDmyn76O4IJ+hBmh5aDIwPg6fIojwMQrp8JL4LZ9Q/7cdoYdz4cTVrtCZhNun0lov7tiMyPL+DfZf5i/q6xrVnJwsFUb5c319Yzg4/0+Heg7rQXll1tkH2v18N9U5cBtQMom4sW9GuC4kwSN5zzcJG1SzYRGN54p3Qk1MAZ/CAGAWhT4Nhh+UtCL7HGUrLgfYdhqbMoLj8Ekku+O9RZ/I4ljEZXVoHF9qiZLvmyhfSKyXQzYrjRtWhsw5nR4LUqQiypk+rstgifAMgA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10158.namprd02.prod.outlook.com (2603:10b6:510:2ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 02:05:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 02:05:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: fbdev deferred I/O broken in some scenarios
Thread-Topic: fbdev deferred I/O broken in some scenarios
Thread-Index: AduXqaeNbacCNH8yTNyrrucfCfcIpQ==
Date: Tue, 18 Mar 2025 02:05:11 +0000
Message-ID:
 <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10158:EE_
x-ms-office365-filtering-correlation-id: 874b5a01-52c3-4d83-3d68-08dd65c150ec
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8062599003|19110799003|8060799006|56899033|102099032|3412199025|440099028|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q4YXVgpMeQan2rj7ouqNi+bOvXykylaxjWHJUS6Y9ICMkT2nFD0Cpa2FHOQ0?=
 =?us-ascii?Q?wrTvacjTq1OOtMLAgZNQwdzvSH38plEbXeu99G6y/qPfB4qfcThomVGJcH6M?=
 =?us-ascii?Q?cjxGad4R+NGVDeoc4HXboeVZ79QmMRGrdJUBwwaDtm66+PUHGDMd+6ex5wpM?=
 =?us-ascii?Q?xUMuBZ7JuDppo4CqL5n+Tyzv08SpdH/qc/KZoswFQ47lfg6lnjRXLWL4lmks?=
 =?us-ascii?Q?Rp5hk+r+zfa26+7FAbWlw2GqEaxMlaYuG1uWZSM+8yYdIL9QRJOjyswqBwcQ?=
 =?us-ascii?Q?mI7Kj07OlBzQ7rLOZDtX7CS7+igYIBMY7UVyQ7Wwr1GjFtAf34xFFA3kLbfW?=
 =?us-ascii?Q?1C3pegz8agXd1vveJVzHB5vuCto2hIXXhpdFPwi3vVWn5j8g+sqrSWSlMrbg?=
 =?us-ascii?Q?1mSdbpbZ0cLr27y8egXRjL6fr1Xp8lx/XEGJ/v7ixNPe74bfC1lilHYnRoGe?=
 =?us-ascii?Q?Dyv0QT2CAFxCISP5faFLWLOyHb2PMBvXec9y/Ge5TTjh2nptMkLdj/Zch2xm?=
 =?us-ascii?Q?xjXZCg6IjeZCZ0lljux+cks9TZQRBX5qpY+ILrfgO3hI0/ygULS53qU7g7fE?=
 =?us-ascii?Q?8/8FMjilQVpfUwDCogq+E0tZQl91nESpRTLOXyR26qVUImaLrBKjI+CPijbq?=
 =?us-ascii?Q?Fh3MAF/ZXsjHmVAd9AOIa50d//ZdS6j1yb9hw6caZ/72A5pDeFnXiNCM10cO?=
 =?us-ascii?Q?SbwM3OXdVJOsaojI/hIKMrMtni0WB+Ays4/FCPpR6SdsvJhLwjc6VGrXYXVp?=
 =?us-ascii?Q?QIRXgp0chUSdt/vjDSrAdxi2SRawdO+3AI/AIOIc4V0dawRCtJHLkg3/0188?=
 =?us-ascii?Q?RslDZOBGAeH8AV1GLbNoBpN3Agjo51JkDa0Y7JuGY3G+J1Jtq5zlmkeN6nyO?=
 =?us-ascii?Q?ZBWmzB4iV1HBAY996HbQrAaZnlz8piwHM6CwysgW3WnGBgq8ZacHb2xKxKaj?=
 =?us-ascii?Q?dRLozHrsz0D4Ws2C0zJ2LyKO9MElnPoZkSTqdKeF3NxwglbJk+5hspkLKfOz?=
 =?us-ascii?Q?Jc7jwACRhH25AqOEOh1a51MQ9W5mxpB4QNuStnlS0GSil1MP/T70zw4iqdM5?=
 =?us-ascii?Q?JpuFusrDpmWXiEaFfVTIdzoH+3gRTJqLW0tdyV8JtI3gen40sg/3/a+1pnRS?=
 =?us-ascii?Q?FKfsXSsBQeL7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jGX9kZmhw6nnV5irUfnR8iqiHIePZ+98AeLSbCrriEZmMQtykUN8mp2pVOhx?=
 =?us-ascii?Q?WqNmhv+N7p3yEi9CIkidJrDQ0Lrcm1/mlvNhz3oos86hhz5fxBC9UgFQgklf?=
 =?us-ascii?Q?g2xOEkNKrKj2UTXrIrRn3T5X0cGhx/aljx4zi6xdWpibF0FjU4o1eEQFNf2U?=
 =?us-ascii?Q?J7X5Za12y55DOr9b7dh7dj8tc6SdgiN1YHKyUOoAS6LjUafDJZdgMjYcqext?=
 =?us-ascii?Q?j/fUalM9gZCDPRup1r+S9IK1RcEfJY/BDHIwnFuBEv24LKfY8uvyjWJS2V9o?=
 =?us-ascii?Q?5NQWzI7J86nbvuOEy0Zysy5hbt+jvRU6V9KcP82jE5n43zrDqbqhXklajjKl?=
 =?us-ascii?Q?1phZ3EvUOGK2GQCGc+ObT6MC+E7suZU4/ik3a795xjxNijl+45IGmioMob1w?=
 =?us-ascii?Q?LfiLFedXGu8SPaU1JIq4GKRIDsT5UyXOpPTs2NwXami52HFXFDlaZ4dcksIo?=
 =?us-ascii?Q?JcLOe6WUXI4NUygduTsf0ZyQtqQnWO41/zxrJ1MV6t53wYb3arledk93G4aB?=
 =?us-ascii?Q?Smoim/4pnv0qo5t2DLtHGvpVs2ZW7iyNiMOOZe3icYtkM+HZpLMr8nGYBVir?=
 =?us-ascii?Q?UDFAexpYF1IwE3TH43X/Y5xRTMKobXUBQx3R4ZTSMmbFHv2eoppB6ipyCiau?=
 =?us-ascii?Q?sxD6izFUT9mflOusvWXnYSLio07FimKkhzkF1N7DTImXys/szr7AyZuuwziP?=
 =?us-ascii?Q?bdLrjXBnM/63nXuxRJuUm4HifDXwK7/5sFpih9+EOwl8GPhdcaQsXB26noWW?=
 =?us-ascii?Q?8YG0Roxq9kc502BrNxqetbobcfTJTIv/G9c4qC3a5X9W1KxGsAaEdpXMOucv?=
 =?us-ascii?Q?/kv62abp0Ik5aiczxWCKkb3cwMxHC1KVlodalQd8+emTodKR7J31fC68hNDa?=
 =?us-ascii?Q?tWHa5oDjh/WVK7N1lKTRWobJJxV9c80SWttDVjUvU6qaYfZQGSKr5l9vkWSl?=
 =?us-ascii?Q?PBtdmX8F2giPsQG0r8B/YhZqG9frIHQM8l/B8hiZNEEC+BKGHe9s8ai/pklm?=
 =?us-ascii?Q?RMbNzZP9iaBnXdO5ObCyygEZu+ndPUg2mMl06e735sfAFildvmb3Ugso5rHZ?=
 =?us-ascii?Q?UjHOXAvVX/P3GJqYPMFelprq3D5P8R653eMvLeocVPs4zHaDE2vwOPTnEjEQ?=
 =?us-ascii?Q?DOP9IL9F1o7u7S2Xe/PfQcQBdsh4JFGHp1685IJ7CEzwPJHagMdVWli/e68O?=
 =?us-ascii?Q?5VPkALcjm6oYrAu6cCkPFb3yJFcfIllVfIMI828uPDD2j363yGJoSbZMA/4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 874b5a01-52c3-4d83-3d68-08dd65c150ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 02:05:11.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10158

I've been trying to get mmap() working with the hyperv_fb.c fbdev driver, w=
hich
is for Linux guests running on Microsoft's Hyper-V hypervisor. The hyperv_f=
b driver
uses fbdev deferred I/O for performance reasons. But it looks to me like fb=
dev
deferred I/O is fundamentally broken when the underlying framebuffer memory
is allocated from kernel memory (alloc_pages or dma_alloc_coherent).

The hyperv_fb.c driver may allocate the framebuffer memory in several ways,
depending on the size of the framebuffer specified by the Hyper-V host and =
the VM
"Generation".  For a Generation 2 VM, the framebuffer memory is allocated b=
y the
Hyper-V host and is assigned to guest MMIO space. The hyperv_fb driver does=
 a
vmalloc() allocation for deferred I/O to work against. This combination han=
dles mmap()
of /dev/fb<n> correctly and the performance benefits of deferred I/O are su=
bstantial.

But for a Generation 1 VM, the hyperv_fb driver allocates the framebuffer m=
emory in
contiguous guest physical memory using alloc_pages() or dma_alloc_coherent(=
), and
informs the Hyper-V host of the location. In this case, mmap() with deferre=
d I/O does
not work. The mmap() succeeds, and user space updates to the mmap'ed memory=
 are
correctly reflected to the framebuffer. But when the user space program doe=
s munmap()
or terminates, the Linux kernel free lists become scrambled and the kernel =
eventually
panics. The problem is that when munmap() is done, the PTEs in the VMA are =
cleaned
up, and the corresponding struct page refcounts are decremented. If the ref=
count goes
to zero (which it typically will), the page is immediately freed. In this w=
ay, some or all
of the framebuffer memory gets erroneously freed. From what I see, the VMA =
should
be marked VM_PFNMAP when allocated memory kernel is being used as the
framebuffer with deferred I/O, but that's not happening. The handling of de=
ferred I/O
page faults would also need updating to make this work.

The fbdev deferred I/O support was originally added to the hyperv_fb driver=
 in the
5.6 kernel, and based on my recent experiments, it has never worked correct=
ly when
the framebuffer is allocated from kernel memory. fbdev deferred I/O support=
 for using
kernel memory as the framebuffer was originally added in commit 37b4837959c=
b9
back in 2008 in Linux 2.6.29. But I don't see how it ever worked properly, =
unless
changes in generic memory management somehow broke it in the intervening ye=
ars.

I think I know how to fix all this. But before working on a patch, I wanted=
 to check
with the fbdev community to see if this might be a known issue and whether =
there
is any additional insight someone might offer. Thanks for any comments or h=
elp.

Michael Kelley

