Return-Path: <linux-hyperv+bounces-1111-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8A7FC40E
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED4C1C20A7A
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107946B8C;
	Tue, 28 Nov 2023 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I5luXcq1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2087.outbound.protection.outlook.com [40.92.21.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08A1707;
	Tue, 28 Nov 2023 11:12:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzVfgAcwbE6aSrDnMb74dxCNJFntWzNeH7SZ1SDz1UH3RISx3qBZpxHMe0CPWdOi8IgsM8deOC4J9+I7Xidru4xgmTYuYOSgp+t3UxiRQO01V3cI08wifA9wU1VU07BACYfAZc871okhu1ei7xFZ/tsaeGA8L8bROTAswTEWl5vmFmAdnnLe0VuI3JZfowxCjwcXrMH88b+tZ4j5Eh6PjrjXQDUGfCGQ+s1jUMNymWs66DDHoMBGf6yec22tojDSkVFUo9TpiqtUy5zgte2nCvifZlYn27N/izZ1stpLbBlQZgozGbbzFEJSn9BvLWkRtq6T2hGqU4YlRbkSnKG/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKsGGv7KIpMrwwkHZcgPzPyNczYPg6IxevN9YGYU2Uo=;
 b=NtFbG6YgIb+gcFkWY/CpzwiBleFYIq0R4LwIO+P9EO7HAj9HKKR56CzHM7UdCkKfZKYUEgdHjP7CO/rFDVB3bkm3sErg1TurSjVTqgtv/+ce4DpjBfAHeTF47axfqlHDnf2B7QmzMyn9HJudBtgRhuvhoUVrxzonqBPP6nbLUUlFtW7Bo/yboFagdgsW3rGiO/UX7+ZcS0f3bHUzbmkBR/m2aQIzOhLkkxunk+gaMK9nh8PAAAENKAO1PRlF8FttuiWM4JDTQr94zMevtsYNfommQQrifrw/gEk990bUg90v5sOc59bPtHIkjqGl4SWbH5cyFtTQBpc+fIZYCplehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKsGGv7KIpMrwwkHZcgPzPyNczYPg6IxevN9YGYU2Uo=;
 b=I5luXcq12rzBPiEpAIxt0GTFTMJu94yo1/IvcFkU+9YbtKOeHepikzWIGTO7go585Txm1GSEZJu9uD7VDBTU8cr9a7aiARkwNNYoASSsUryHZ5rNVngAa/0VP3grnkdYCmmbNpXoZfZtCfUdcomgd6/Yb2NjQzIBY+iVRKzxeLCYbMrcPEmRSDPRaOaC8Ioi3J7iLM1KKwraBcYcFoJqSNFBvMTQVuNcMpVtIczfQ4sv5IHHaX0IC7ytZptXhPVSEW/jQ0X821Xxw4m1PBG39tAZ3KB4aMv/+0p8o1vhexAi3UBFUlowGWMOsJosLiT0KZhnJYjbuV2E+N/fC/PIOg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM3PR02MB10207.namprd02.prod.outlook.com (2603:10b6:0:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 19:12:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 19:12:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"hch@infradead.org" <hch@infradead.org>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ardb@kernel.org" <ardb@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>,
	"seanjc@google.com" <seanjc@google.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2 0/8] x86/coco: Mark CoCo VM pages not present when
 changing encrypted state
Thread-Topic: [PATCH v2 0/8] x86/coco: Mark CoCo VM pages not present when
 changing encrypted state
Thread-Index: AQHaHMCVvp/6+xDImEK+4X8HvaXRwbCJQkWAgAbY+vA=
Date: Tue, 28 Nov 2023 19:12:33 +0000
Message-ID:
 <SN6PR02MB415717E09C249A31F2A4E229D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
 <20231124100627.avltdnuhminwuzax@box>
In-Reply-To: <20231124100627.avltdnuhminwuzax@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [J/wGVSpGYeRz3Rj6poBi8W9Icwyhmj64]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM3PR02MB10207:EE_
x-ms-office365-filtering-correlation-id: 963872c1-4437-4ef8-e68d-08dbf045f9fe
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LBwc96x5VDZSRmK7/vQXWkByGAbOAa3X0xbw8i2nPy3hvPGHIFouK/GxCbMxOHCmIsGAjOVs7yrGLY4NsQeYyJebqUFPJMOk9ooCj+bnMUSbAKfbR0PFzPd/+oSU3jFcfnImkuIWuhM/zOjDlbEViJfH9aDUQhaZxaimJFGB9pQogLEY9gjHWNs+lL1/byKHnFsRJ8nAuiAk2L2yBg5LWrLGESHkGNv/YN1V7sUvY4RCSEJUTQjZXbUBFADmlcaBlrZwF3Qri73T8KKpAoZOPCzdrhkpdpdZEX3dE+h742ayXpF6h+wmd61rvz1FUiXIyrKfNrP7er0UNTU1ncH0GKtPwEcPdVpj4e8AVFLEN4pZwxKr8FIL0uCR8z7dHOSNohsXdBH1hqcBTrWGBgSOq4OI44BgAnHmCItNxkUBndCZMGaPYfS6qbsMnuHBzYDRHE3b2g0km7tiAFYhP0XTKtfaLP5SfMjd3mzXjYsvyLklh4CCBcEe8PGR5WFHEtAnXl9ylyV6aAGI/ITLAXtuVal4R1kW3xy6k4d6K6Qj8yG+4Gd3DDIwK/NFwi2JvfE4
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NCjh7/kvtj3FIm3YxOaghhhUa1UnjjqBnsiTH3Y7Lk7EAM2nNAqNzOarG2Q3?=
 =?us-ascii?Q?Ie8l7MJvNeMsJIiOGgMTWvREBEiPJN89YYLPjdDGPyRsdaHvgTesn5Qd3Nd3?=
 =?us-ascii?Q?oNPS1PfjPMjjOADL82M2K4mWamQDNL9a/TznvohiwlDnE8ON3H0Pz41QFH65?=
 =?us-ascii?Q?SwnMlw6+25HulG5g573Z2kOyxGSqKSfLlCCKFU2o57DbmrDxjiFQsPcmQwTS?=
 =?us-ascii?Q?QFv2P99kcFxSVYedAKKfpNLNQWJGzBbxAbWNbzANCHHW3yCAf1koZ7/Jen14?=
 =?us-ascii?Q?i1TfYNc69TSCjDoWESGDISpHMEJcqDiDQ3+HK9IDn+ugkBA+qYAvqLGDXYSy?=
 =?us-ascii?Q?co9KMzO9DTFYEf5iJt2jt/i7Ux5z494E58gOe5s6v7QifxDtstBXiFhWYUX1?=
 =?us-ascii?Q?DTGZ68TxsCNV9bUcUwn2B5BZMhUmWp7F9oDL39KpARTfF1Pgdbbj2+5kgffY?=
 =?us-ascii?Q?b9wIwrdqEGLoXVIk6GIx9tKRTU2t1Yt0od2si5R/W6XkeEcqVhwE+TQ+s6OA?=
 =?us-ascii?Q?aNrADg37GHycCJuJVdxvz3Io/JaMv/7tXd8V66syh+HjSk/SKn1+7bXaA5rY?=
 =?us-ascii?Q?z1ECp8YWNhGQYtCjLChFx8zsGNtTwaLPoDeRf5vvOaYQR5QCD9FpW4bqU9kT?=
 =?us-ascii?Q?BAWtWSxgbr3CoHqEoSp8t4S/V+44YIF2zarFmLc6Yq6Xk4TzfWUaQxpxoMq0?=
 =?us-ascii?Q?g9SXM+a8JJ3vARnh/irZQrte3la9N4L8t9rVzw4+no8TRgm0QgHtIGHYgqgB?=
 =?us-ascii?Q?MbkDjrP8DBt8C+m0YRBHDeR0SyLpydnAWybPxYM7w52b/BzzUhhiX0CoFEfI?=
 =?us-ascii?Q?3Y4qHoM9ItV4B0dh+Idw4VQOuWd4o9V3QHNjua3RxH0Hlyn741wDHfScdUpD?=
 =?us-ascii?Q?F1f3yfEiO1T3SfF8MgsR+YaGYcAELXeswOnfqFePHZm1PetqMTPiWZVjeGRc?=
 =?us-ascii?Q?sfwPV1dTjq5C1Bpw/kIucVIVQjxnpLzrQ6BeMdAkjqZZ8DurIztDJbcLOZ9D?=
 =?us-ascii?Q?MZCLADz9eGTiOb1KfQ/3zW4N+erZ/wYaMHOxrulL+F1IVTqwJS8KPgs6+vyg?=
 =?us-ascii?Q?Ivp3rgKA5ph+HW/4SMVLD8c176cL8n8HQNO4P6PKR4ZBGE9GdbKlarceCJ6o?=
 =?us-ascii?Q?z/Y3DVo4X8FShA3ooTJKSHr3qZyerkUS3kblOZ8uyIgpSm4yWnEtgQSgMNPQ?=
 =?us-ascii?Q?qmdHjpJgvymdybJv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 963872c1-4437-4ef8-e68d-08dbf045f9fe
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 19:12:34.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10207

From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> Sen=
t: Friday, November 24, 2023 2:06 AM
>=20
> On Tue, Nov 21, 2023 at 01:20:08PM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > In a CoCo VM when a page transitions from encrypted to decrypted, or vi=
ce
> > versa, attributes in the PTE must be updated *and* the hypervisor must
> > be notified of the change.
>=20
> Strictly speaking it is not true for TDX. Conversion to shared can be
> implicit: set shared bit and touch the page will do the conversion. MapGP=
A
> is optional.

Interesting.  Given that, is there a reason to use the explicit
hypervisor callbacks in for private->shared transitions in=20
__set_mem_enc_pgtable()?   It probably doesn't have direct relevance
to this patch series, but I'm just trying to understand the tradeoffs of
the implicit vs. explicit approach.  And am I correct that
shared->private transitions must use the explicit approach?

>=20
> > Because there are two separate steps, there's
> > a window where the settings are inconsistent.  Normally the code that
> > initiates the transition (via set_memory_decrypted() or
> > set_memory_encrypted()) ensures that the memory is not being accessed
> > during a transition, so the window of inconsistency is not a problem.
> > However, the load_unaligned_zeropad() function can read arbitrary memor=
y
> > pages at arbitrary times, which could read a transitioning page during
> > the window.  In such a case, CoCo VM specific exceptions are taken
> > (depending on the CoCo architecture in use).  Current code in those
> > exception handlers recovers and does "fixup" on the result returned by
> > load_unaligned_zeropad().  Unfortunately, this exception handling can't
> > work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode)
> > if the exceptions are routed to the paravisor.  The paravisor can't
> > do load_unaligned_zeropad() fixup, so the exceptions would need to
> > be forwarded from the paravisor to the Linux guest, but there are
> > no architectural specs for how to do that.
>=20
> Hm. Can't we inject #PF (or #GP) into L2 if #VE/#VC handler in L1 sees
> cross-page access to shared memory while no fixup entry for the page in
> L1. It would give L2 chance to handle the situation in a transparent way.
>=20
> Maybe I miss something, I donno.

I'm recounting what the Hyper-V paravisor folks say without knowing all the
details. :-(   But it seems like any kind of forwarding scheme needs to be =
a
well-defined contract that would work for both TDX and SEV-SNP.   The
paravisor in L1 might or might not be Linux-based, so the contract must be =
OS
independent.  And the L2 guest might or might not be Linux, so there's
potential for some other kind of error to be confused with a Linux
load_unaligned_zeropad() reference.

Maybe all that could be sorted out, but I come back to believing that it's
better now and in the long run to just avoid all this complexity by decoupl=
ing
private-shared page transitions and Linux load_unaligned_zeropad().
Unfortunately that decoupling hasn't been as simple as I first envisioned
because of SEV-SNP PVALIDATE needing a virtual address.  But doing the
decoupling only in the paravisor case still seems like the simpler approach=
.

Michael

>=20
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

