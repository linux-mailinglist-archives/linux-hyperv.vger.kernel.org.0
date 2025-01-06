Return-Path: <linux-hyperv+bounces-3585-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E7A02FA9
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 19:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643927A2281
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA191DF96F;
	Mon,  6 Jan 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RaXjEwwA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2079.outbound.protection.outlook.com [40.92.41.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACD1547F3;
	Mon,  6 Jan 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187535; cv=fail; b=JhcgFR/xH0Xs3R77+yIH/Dy0ybW1L8PoZbwvceCE12kAyamBKkLVQ9ENIcF3zxnd6Jv/NDUv7A9gHl3eZM6wvbNdQr5SC2GORYmwRa060LMPhN40zhW20cxgEGxjGwGyvt/NeQL/pRfWZ40CFubLCvFaBYNOkSU1ePpjFbsBRJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187535; c=relaxed/simple;
	bh=hnqZaDazHkIhQs5/kxmZBWYXJZZEjON0PI+gMupu7WQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZ2QHufe9U4W2vDn42KEfoUnKiHxDniYkqvfYb+GKhwyCKy0s3k4dSUxVioi1jH8wcHdlGKgNt4d+1TivlOMSQSwDwGeaUskQpgwMZP25DMjqylLPsnPl4+IZncIgnhYoln1o0T3EhTR74PjPGdTRRItjFvT44edqRro39Ip7cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RaXjEwwA; arc=fail smtp.client-ip=40.92.41.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfD2MNCHuTBobeiW3gCT0W9OniJRVCNIzjEWCSjB+7R8Q/lOvLGHv3fC7O7ckXARGI6dEZKTjhlqMC4jM1eWJFFJ3XmZ0PlKgB8gJQJmxnhtpgqoXuB3/e+2Sl0TzV8BsQ2s5icu5CMhhGhbiXQ9Vt6fXD2AuiAS0qflsuBr3Ro+E0/PCtB+e09ZDDZfq90OPct2qIR3HyPGsgfLYKcAQUucLT8zGLa9UyrDQizqffZw3wdqveMTPrffh0mc5tIk4kmSiBDi6P4R+4V/JwXoJ1W0JklMOy6V6v6elPCwoTyYBk9w4CZPCk/WugPPDR9Ag+C0u/DeOGMH8gVuAsGfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc8ojYgLjNOgBnoA4SSZwaJUyfnCHIma/qKtd8Y9nAk=;
 b=QtuVqe5BjQQ71Ue/v99SzVIHzemmksEXeMyuQ/tpT4zy7AObwpKHR0oxlnzHNYOKcpG4XNBoljjaHD60TnlzD82goN3mW78I7YCcafoGS1NYEZF1H4P83tpgMdpTDGgJIpiheEj1nJGS0U+kbQHHurJaNCFRL1MjCliFBzlVxm1hF3KQAgCyljUuUwIfz4Nyp2tFwhXhXc1YylsSxbNDsoJqzDnsDmw3al7by7e/GYHTrbAtmy6GHeFpKdGbas51E2Gm/q9n4Wn1Jsc9/FTkcWtz+94gZeRVq5p0voD+UQBUdNoeygsHEcz2WDko/Cuo27j3l5opuZ9GZFLEzdUzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc8ojYgLjNOgBnoA4SSZwaJUyfnCHIma/qKtd8Y9nAk=;
 b=RaXjEwwAG/nG7sct3fquVVcdDQt1Pm6xIYCumoJpClx/qzO0BCDMxkSkUIDELpGFm5tq4nELgvGsafxaJqXz7ReW3Cf6OfWyrXCmOmRjjijYowG49C24YaoKtMVoJGsLcTM5smVmYNXPZgUj8q3zE7SdiQMJDUf1KYWupQURbBdH+gQBgrye+oMqNjW2PLMjOpRTEztP8+TmD+cJOVwlC/2527eZHlKx5nuQbbeYWIb7phsbAiUZJHPIlk20dSlTjmCF8JXmysMUCxuF5735XyegfmyesLf2rfeRCPS46QaQDicxeCoI7LoGB1jAsy1hFTR3BiJjTzo6eHsHL/pJzw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB7063.namprd02.prod.outlook.com (2603:10b6:610:83::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 18:18:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 18:18:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
	<apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Topic: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Index: AQHbWuYCjpxLpvSze0qhquwoWcqvGbMFcy0AgAAtWgCABGkAAIAABGPw
Date: Mon, 6 Jan 2025 18:18:51 +0000
Message-ID:
 <SN6PR02MB41576D6210E0270610F55DB3D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250106172312.GA18291@skinsburskii.>
In-Reply-To: <20250106172312.GA18291@skinsburskii.>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB7063:EE_
x-ms-office365-filtering-correlation-id: d9dd768b-fd12-470f-07a4-08dd2e7e923d
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|15080799006|8060799006|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N0lMqHttkJgf8JWGq7N6LKd7xY4wTiZsFIJSRPVq79oTLVbva11Yh2xW2dqP?=
 =?us-ascii?Q?jlqbnASYG2EIwmxForANBPkc/B4GCeABVGn79sdYKCOAn43VNI+LvHk7/5AB?=
 =?us-ascii?Q?p8gQQY6namkFGFANv31nNvBSiTWjJNxujfpJSsAKaATo/kQZIdnyeo6O5gcr?=
 =?us-ascii?Q?7ssjzv0gZXOltuU1gLvsECuiSU5SP/X+Iuf3i00CO/IHc0tF7bfQlKcH/ncv?=
 =?us-ascii?Q?pr1CZ3aSQP2kVrXeXrrIyYFfkE+ft6VMNbaTNbcKBbvzw6R13SPYRlwxXd69?=
 =?us-ascii?Q?QmeB4/PV8woBPdAvAW5ihBM0DCCCCKO7R+A1CPcnMWJk2ab7VN7YsLd/2lZZ?=
 =?us-ascii?Q?M/yQ40Cu0qPpHyK35uSl4NY+owE7fGX552E96p0BXqO7Gk0bSe6YSxvOOPsf?=
 =?us-ascii?Q?dzJ57CYbMcqmw0n0yK2mAiUlaMTPQO+M3qZnDC5kWRABUQgIawytp9LixL/6?=
 =?us-ascii?Q?fWM4LVnTPU33cOh0wOFEixfljoYpPGP4vtvsbWh8A6E8cS5nflwQ4eTI+w25?=
 =?us-ascii?Q?MW0iQ7FPLB7KGTgi3zbGLgSKmShDWId6fx2XS4LPyLf5juMC6MAdyCmelWWF?=
 =?us-ascii?Q?QMaAR031AOG0FYaV+01CENdGiubh9sFFUhuYJSiRZ/oR69CpuB7joQ8Ofw3K?=
 =?us-ascii?Q?PlTYNOXogvRtBCdwc/GJmR9rgrkyuKCgd8pakdzzkuzIsKNO2ZLci5axJZCr?=
 =?us-ascii?Q?yFV0hl8lRwPz7L8S2DsvI2QPcwkER7KK7bb6RFIhW38341kr6xfqN9Mh1Vk4?=
 =?us-ascii?Q?Hr9MJXkT5EpH7L9bEH3a47Cz9XKizMNRnusXgDlw+ZUDiY+QYrBTs4NnBCXz?=
 =?us-ascii?Q?6ynth0tOIJLhY6K5T2I0djL77GarxBuduYSlX6BNpCm3CeUkGrsacReJ1BaY?=
 =?us-ascii?Q?Jms0J60UZHVY46Qvgpl+ESNfTpjY05FfAX7f/Tk+H51hrS3mMSPDuTltw4d4?=
 =?us-ascii?Q?sYwYnbWchUgbh2Sp3BsusF3mDzXxfys8sfUufPMEipSGBNznRtoG/Mpq7xOZ?=
 =?us-ascii?Q?ZCqCq8KU5hVOt13B1MiFRp4R2DzviQ9+DUF8dqxjBE8lK+w=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2GTd2YbabZ06yLOizTd1GEVm1RxgcMxmM1IGppKvkq4ASu0m4CTASgA+QqUP?=
 =?us-ascii?Q?Yitwf1WVDLWotkG/DsZ6csLrmgcr41bKjlTxEJtE20n3SAkaO2xFRnSQ1dOK?=
 =?us-ascii?Q?11Z9pEUeZNWfji5YvPFoN49qFiw1zeVgeAL2dFZ7MpKX1HN3mvQlJYe/Z2l+?=
 =?us-ascii?Q?eYm/KL4ie7qEK1b0JdHOXi9OMAjTlDmLBqhL28ODjEwalFdHFzwKUqDpwEw4?=
 =?us-ascii?Q?5mEmIPhxcfMa4tuIWjW+54XVl4xfaCglzUnikE/z8j5poEd471L9J8YFmNhx?=
 =?us-ascii?Q?cf9cQ25sJfbThOAVqobYkDLRTMXcnwBebD8OyMCoIMYVtln7zf6lb3Kdc51Q?=
 =?us-ascii?Q?H71ShgrSLDo2zZ4pZ0NsarDb7XsFF+EcWiDrF0HaVAgLdChx/vZEh5Kn8yg5?=
 =?us-ascii?Q?4Z4xMFyAUfgdFSiMFYyZyaylc24z6TlgJq4Q5B4yrjhgJYKaALPl4hn6xfxR?=
 =?us-ascii?Q?z1aS7HcTUFdTeoVv79Et2KafgecALfqfACC0KiCAbwfPSZ9MtX82WwgLULwv?=
 =?us-ascii?Q?5WbSWhDPA0KIIom0HSRr11FJCWTP4f/Y4mPwlQiRxdQDOcK7Z4U7v9yVL+Uc?=
 =?us-ascii?Q?xWTC0FYAdN8tzK2q/wFyKcxG2SmvE0/DCcIY7StzJY1F4WlkqSxhRsuyHYH/?=
 =?us-ascii?Q?5Aw+puhLbJrdpXW0GytiwqA6dlsGr3lDlQHb4c6OQD6hnzJiM6SPZbAhVZgp?=
 =?us-ascii?Q?nQRVeVmjEUo+2PdXTf0GIkHR6QqxIdgVHlW61Ni8iNzSXtxtR+8ORQHbsA43?=
 =?us-ascii?Q?RVFWnfDV9FlSPGa5mPM8di1bfF0oqvNbnyfQtvAL32TYrkTlSuioaCKUpNIg?=
 =?us-ascii?Q?fo1FryHvpvbOKM5C+QWbHRdVtQQLK4J7cHStlkCdux+IM9ZU7dPwTSmMIegA?=
 =?us-ascii?Q?sP4QxxtOrEZwvXoKZ6iJSdkTOClqR9mPBO94UfGpKO1ibxwf6qOCCPOUyrmP?=
 =?us-ascii?Q?Bd3VQGoCy4KmfMDK467vIBqbtf2/m5/44rsOcE4CVku8KDIjG4q5cUrOvp8u?=
 =?us-ascii?Q?x4Yva9bX8ljqqdeb+sx3PN1ebeHY/JWBGZsZSerUfRE7S30ngfPBuaeDOre2?=
 =?us-ascii?Q?KIVpUz4CFDJtGUUu9vidCJvaGZlujznjeZSGCspw0scZQInsrP0ZChoneXnF?=
 =?us-ascii?Q?mUYDsg6UTYASOpwPXz/yktbqlF/I2esHob5jXnatpNwQ2CWs4NthnW16HGc8?=
 =?us-ascii?Q?zXvXJhQd1W/DbClikwP7gckrVqNcyQSxM7bCcrNWGnVWF70f6BmIWvvcCx0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dd768b-fd12-470f-07a4-08dd2e7e923d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 18:18:51.0157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7063

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, January 6, 2025 9:23 AM
>=20
> On Fri, Jan 03, 2025 at 10:08:05PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Fr=
iday, January
> 3, 2025 11:20 AM
> > >
> > > On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
> > > > Due to the hypercall page not being allocated in the VTL mode,
> > > > the code resorts to using a part of the input page.
> > > >
> > > > Allocate the hypercall output page in the VTL mode thus enabling
> > > > it to use it for output and share code with dom0.
> > > >
> > > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > > ---
> > > >  drivers/hv/hv_common.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > > index c6ed3ba4bf61..c983cfd4d6c0 100644
> > > > --- a/drivers/hv/hv_common.c
> > > > +++ b/drivers/hv/hv_common.c
> > > > @@ -340,7 +340,7 @@ int __init hv_common_init(void)
> > > >  	BUG_ON(!hyperv_pcpu_input_arg);
> > > >
> > > >  	/* Allocate the per-CPU state for output arg for root */
> > > > -	if (hv_root_partition) {
> > > > +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> > >
> > > This check doesn't look nice.
> > > First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that th=
is
> > > particular kernel is being booted in VTL other that VTL0.
> >
> > Actually, it does mean that. Kernels built with CONFIG_HYPERV_VTL_MODE=
=3Dy
> > will not run as a normal guest in VTL 0. See the third paragraph of the
> > "help" section for HYPERV_VTL_MODE in drivers/hv/Kconfig.
> >
>=20
> Thanks for pointing to this piece.
>=20
> This limitation looks aritificial to me and as VTL support in Linux is
> currently being extended beyond Underhill support, keeping this
> restriction makes some further development in scope of LVBS support
> complicated and error prone due to potential ABI mismatches between
> Linux kernels in different VTLs.
>=20
> IOW, making the same kernel properly bootable (or - worse - explicitly
> un-bootable) in different VTLs is a more robust way in the long run.

The reason for the limitation is the sequencing of early Hyper-V-related
initialization steps. Knowing at runtime whether you are running at
VTL0 or some other VTL requires making a hypercall in get_vtl().
Unfortunately, the machinery for making a hypercall (setting the guest
OS ID, and allocating the x86 hypercall page) is established relatively lat=
e
during initialization, in hyperv_init(). But running in other than VTL0
requires the initializations that are done in hv_vtl_init_platform(), which
must be done much earlier. There's no clear way out of this conundrum
purely on the Linux guest side.

To solve the conundrum on x86, one possibility to consider is having
Hyper-V make HV_REGISTER_VSM_VP_STATUS available as a synthetic
MSR, which can be read without making a hypercall. This register could be
read in ms_hyperv_init_platform() to know if running at VTL0 or not.
Using synthetic MSRs is how other aspects of early Hyper-V-related
initialization is done in Linux on x86.

I think there's some discussion on the x86 sequencing issues on LKML
from when the VTL code was first added. I was part of that discussion, but
don't remember all the details. There might additional issues raised in
that discussion.

The sequencing issues would also need to be sorted out on the arm64
side, as they are different from x86. We don't have an early Hyper-V
specific hook like ms_hyperv_init_platform() on the arm64 side, so
that might be problem. But on the flip side, we also don't have the
x86-specific messiness that hv_vtl_init_platform() handles. Also,
there are no synthetic MSRs on arm64, so register accesses always
use hypercalls, but there's no hypercall page needed. On balance, I
think getting VTL stuff initialized on arm64 will be easier, but I'm not su=
re.

Michael

>=20
> Thanks,
> Stas
>=20
> > Michael
> >
> > >
> > > Second, current approach is that a VTL1+ kernel is a different build =
from VTL0
> > > kernel and thus relying on the config option looks reasonable. Howeve=
r,
> > > this is not true in general case.
> > >
> > > I'd suggest one of the following three options:
> > >
> > > 1. Always allocate per-cpu output pages. This is wasteful for the VTL=
0
> > > guest case, but it might worth it for overall simplification.
> > >
> > > 2. Don't touch this code and keep the cnage in the Underhill tree.
> > >
> > > 3. Introduce a configuration option (command line or device tree or
> > > both) and use it instead of the kernel config option.
> > >
> > > Thanks,
> > > Stas
> > >
> > > >  		hyperv_pcpu_output_arg =3D alloc_percpu(void *);
> > > >  		BUG_ON(!hyperv_pcpu_output_arg);
> > > >  	}
> > > > @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
> > > >  	void **inputarg, **outputarg;
> > > >  	u64 msr_vp_index;
> > > >  	gfp_t flags;
> > > > -	int pgcount =3D hv_root_partition ? 2 : 1;
> > > > +	const int pgcount =3D (hv_root_partition ||
> > > IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
> > > >  	void *mem;
> > > >  	int ret;
> > > >
> > > > @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
> > > >  		if (!mem)
> > > >  			return -ENOMEM;
> > > >
> > > > -		if (hv_root_partition) {
> > > > +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> > > >  			outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> > > >  			*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
> > > >  		}
> > > > --
> > > > 2.34.1
> > > >

