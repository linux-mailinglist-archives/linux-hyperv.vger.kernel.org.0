Return-Path: <linux-hyperv+bounces-3578-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD9A01012
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 23:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A8164316
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593171B394B;
	Fri,  3 Jan 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s4tNxm8K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010017.outbound.protection.outlook.com [52.103.2.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B317FE;
	Fri,  3 Jan 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735942092; cv=fail; b=Z4N3UlmAbkCMTOaZcfYROmc51UNOfKETlJYgGzQ0QSCR4V28y3mySvfaedd3MKjHIIBH7GTaHVeNyozrT53qszzG0y6/7KcMGQvcI4nGczBvNQnfcG9onyFL7M65c60xajGmh4xJsmzpXqhXDf0Q+SQ+3AzgMmdqWqWA/7PBE8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735942092; c=relaxed/simple;
	bh=xMzfKF3d4ROjeDEkBozhiBHXdhXCokrKVrQ6VvDJPIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RySkNcuSVnfmGXKMaSy1E0jBBCjdqqWlrRKJYxsGky1TlR7kXsBNggVS6UpVHm4xYe+odJjdHzhN+MAQy7j4Vnk/TsXt8GV7mccB8xmm7KPHFgyiXM1g003wG00hE1Rzzt3YMLWNKY2kWawfRgWapwoqyrIFtkj+x24+DCTUSEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s4tNxm8K; arc=fail smtp.client-ip=52.103.2.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1qLKQla5w0ahtpRBk3p3Yv3GfPGzEf5Zc4C/Frs+YWWxaQ1n383JQJvMcxulr1x1KhFN5ekjgZb/X1+RuMhQ6zGcFfWAB9LQHVLBkVOctzufmiDUJ8KD4TejMhpjx9FMNMumJQM5dxFWC98sH74N2bOYJultnpENmte1CkwHhyDCim7vjjc0U7uS0xy/D8utG3oel73UHs/DZyCokrxQ1BrZ9J6xQvp4Ko0Cn8VH0J0kAgFxUGjoWbNJ4HcVlL+CZ2LdJDGkgmgKY2j5K6sqbR157DH7aMRHLZLql/n09+BkghmpP/sVDzXA9YdmRQ4pz/87++pOapNICFFL/3qIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjReT75N5U7kMbtzMPQLa1WSJxIK/jfh86Ikx7nYXQ4=;
 b=YzswGlwYK6dOQN1qe+Av5EPS5eshmoIy8qvys9W5S6GY72Yg3qkiVHh37e8US0jdUwp3bOaQa/wcQplYXpU1jWHKklJUGG49oU5Dl3+MZs4ciyM/lZ53PBMzPTQ82tK4YYOk5xcwK6b7+l7scOhaI65evY35F7U9C2ODQSUuib8lDoiK1pXL+s8TXW3LixP3+Kb81CDp8YwUii147liHjZkGmp8jipJcu5ObB5dep4oNyqtAJv4fYV0V5JTB1KjpYTyupN0ORmINRwzrwR2lfd6SYKD3Q2u+IMa9+KDW9WZ7g7GW8mJBoFCGadbVSQe25+MV9x5u3eTYVhRMi9X4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjReT75N5U7kMbtzMPQLa1WSJxIK/jfh86Ikx7nYXQ4=;
 b=s4tNxm8KPKedxIoF0R7XsF/29fZ8zHkCNDjGSxqOdLkY9hs5Td0M5XlDFQjO7aKeSfB9pDX96u4tOybtl1qRLibxLr2Efr/grReT3Pf9vAj9gEW2CMryVOEbUrmaIzuolEv/7XLIa0wkAo8CtU218tppu3nH0vKMcJa2bQNyhREvV3p7kDC4Ebj6AeIlI+/Iz8cHtOPdQOhYyLbGmoPnTyIUnWGt7wV7ynhY2EhhuR5Q5Mj1FMx5Oe5cKu37n5gS0egoU4DQ9xUZ+qLPvgzw1ufI8329ZjWhvBWJT8lz+DpGG2LUjDsyAlyZJolxnx7lk2tWFDhOqCkcaUQ2NtU8TA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7352.namprd02.prod.outlook.com (2603:10b6:510:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 22:08:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 22:08:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Roman Kisel
	<romank@linux.microsoft.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Topic: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Index: AQHbWuYCjpxLpvSze0qhquwoWcqvGbMFcy0AgAAtWgA=
Date: Fri, 3 Jan 2025 22:08:05 +0000
Message-ID:
 <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
In-Reply-To: <20250103192002.GA22059@skinsburskii.>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7352:EE_
x-ms-office365-filtering-correlation-id: 10562f55-e7f9-4920-d3f4-08dd2c431993
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|8062599003|15080799006|19110799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J/daArJ8mwo1fxKUDuEx8SyXLLjR/uyajnxq8c8DYOVQKBQ9MAdMD2tyLDmK?=
 =?us-ascii?Q?s3jbk5PI9V+EaUfm7uvlCTE0UtYjN0j9B/UbohICYgfdmSgykucZbdqXnN5r?=
 =?us-ascii?Q?+IDVCouXQqvd1dtkGU/vCdoJWCt3JoL9DaueHjS/uHyaaq3gF5pPOdolspYN?=
 =?us-ascii?Q?4dRqr8u5o54tO1ETUVpUNtfMSJMMI5rYzW8pAl9gLf1Qkz/LNS/hiiEcuW3C?=
 =?us-ascii?Q?T77VWsFamqBTGbaQL2KhMOufL5UeMhNKZJR6xiitn1vwSf7zM0uNZsFgUETr?=
 =?us-ascii?Q?GGMc+wYEzfEz4PowQlK/iTxVdA9mxAZRFUoUhmi0qF6VBEl1tjdRnPQzs3as?=
 =?us-ascii?Q?jsHtsxGj54C0kO3XG2cO79yDXDjwZU+HvG1NkkK1l8zfRmCcT3Zxmfom67LY?=
 =?us-ascii?Q?QPoXl0yZIxpHuMD7FUo8vuP2bxOkNo6iGJBQELiMw9AcaQuwRLdKGdanSC0/?=
 =?us-ascii?Q?ann2YCTcpmYuag7FCErf3xXHpSI24o2WcLI1kS9kbzKDb4eHeb7CV3lxdl/i?=
 =?us-ascii?Q?3ixZbRlIj2F6iC0j85Uyj6Vlncb5+VwH3u4PwIEi6TuWy+UQeMz/xzjqQINE?=
 =?us-ascii?Q?63PNJ5zsYW0hFz2L3KYjPxpBH/hpBp9TB13X7emq/TdfC6OW4a2Q7nkeibQg?=
 =?us-ascii?Q?kKu1s2WuhA+2lXMCtUJD8PXro1SEmUVHZCJBt5VLTyQfytC26gbx4RI31Pp7?=
 =?us-ascii?Q?4tNSymkp4jM74GSqw+c/SahbieWimGj6yc+dxOFos3WJV5Uq+mC+y2KEU/r5?=
 =?us-ascii?Q?OSEzi0Y6CUXfC60T49L/M68XeSQdOwBtZGAB68u2qnZvVMg3GRNR6B5RX6iE?=
 =?us-ascii?Q?AuOgy3BbpKzIUg9Z029KfAPhbDIM3zn4DT/7voZ77ifWY3aUvew1e8kYeQT3?=
 =?us-ascii?Q?If3rnM2c41RKOTyVuar0QXuvpVmpU/8SeN/UQdib2kOWpRPmdPsyzxZHvwpx?=
 =?us-ascii?Q?zwv3uxIyN3MLJjkxAPg1M8nTigfx8JYy7Hfn0cquXQLd7QgTnByl6GT3nNo2?=
 =?us-ascii?Q?sMryzl6R5NKScVGq3GBD9Ynp1MBNc5icDoDW2xae/d6feR8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lpm/FvQVQGG/0r57j+AVoh2mHjVOIeKkW2/mbIOAY9YFhgPYhRhNEXa+F1dX?=
 =?us-ascii?Q?o2XkvBj0mZCkT1LO3OAurocF3UG217z1ty5mSt8kX1HGfSEq5I35hZAP1tVH?=
 =?us-ascii?Q?9IVqPe46NZJE9QHLi87/0sSN4fmU5vlzlHxnPHS7MmW5T3xnGCwOVp/ZHHWf?=
 =?us-ascii?Q?d7rofxREijRiy59j9qgCX6dzU4fZtWnHxMknpZouMPx5a5gJQP1v31MvDTBF?=
 =?us-ascii?Q?9CrPJhqLfJy/I+mKMIbW5cGdN4pnYw0Tdb1JYmKURE2MqaTcoCzx6k5vdl3g?=
 =?us-ascii?Q?kIZtywfpLu6JpSE3QrxcQ/H1DNOFXWa8jKD56bZiKaiv2ewCGV/77nJ/a0Jx?=
 =?us-ascii?Q?tZlsnNlEWv8raMDC+oxy8QVUypUFmTtrOMqOo8/HDOLGH+xbWd4liOMK86KX?=
 =?us-ascii?Q?Zn7JDpKy9GqQfxhHqJ5A5bO7U/oXItAQKXAoQlLD93mf0ixYN6zyBD8FpRYx?=
 =?us-ascii?Q?9QHZxqEz21+epF7oIQvvPGldbHDeIjfz/UuM8p7g2HnURyzEqT+BrBuFk8mh?=
 =?us-ascii?Q?8TO9PixhRfF2X/fnpK+Piu5TfuF576e4gSOiXZa7SsryoQTKeGt/UWGyKEXN?=
 =?us-ascii?Q?Y8jtHZ2oTYTfC2kzwTQTq7OJ2C9nfjnrzES6HE74dShknCOQLSntnzjP3xIj?=
 =?us-ascii?Q?qJRIiALCPaaKwE5YPeYb+b5Is19THcdrAzntBmF/LqSJxcifMQnoLtykFf/4?=
 =?us-ascii?Q?olNF7NOlc7SbHEKQTAXTXGjZZ1ThGc6ktSjRbHVpjXv95bGey9VSrKfqmpRh?=
 =?us-ascii?Q?xwkC4GfrqHCotEb9Os8E11d+jzoH+YgFu5cApmDAZLgBmqUh6Z199EOJtd8c?=
 =?us-ascii?Q?UkFnyK8T1fzxukto+OKULIbNrAW8F8GHW89fGU23pvj3yUKX6hntlGMhPWPC?=
 =?us-ascii?Q?N8MlXOFz+6xWopEDy9cA4HcFk27tiGXDlIiXo7rbGQuvAGFzKPpPP/P+ZE/y?=
 =?us-ascii?Q?F/G0P0qIv92hHQafV136LUeQHyoHO7UH7lLKoUnx1bXf4nU2UfMfQ2zFfjtP?=
 =?us-ascii?Q?hlwCd4KWTdBKujy7fZj5OYz/cO48Fxu5XrvhL9eL9Y/xA0AZgyy94Xq04bc9?=
 =?us-ascii?Q?SW/hr9E0BIB3blXyYX1nLSTJrKCKANkGz3//l70MGWEtJ8Rcgp77SojhtNI0?=
 =?us-ascii?Q?UNVCpUbh1NI6KKx3HIZ3QJoISnLn1PkK6b70Axg/qnWIuUeRltyEk3UNjwnM?=
 =?us-ascii?Q?7p2Rpv7MY3l1ue8WgINZO+o/dB2seNIqmkcUbTrXhsr3jXllJppOQ5g84qQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10562f55-e7f9-4920-d3f4-08dd2c431993
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 22:08:05.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7352

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Friday=
, January 3, 2025 11:20 AM
>=20
> On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
> > Due to the hypercall page not being allocated in the VTL mode,
> > the code resorts to using a part of the input page.
> >
> > Allocate the hypercall output page in the VTL mode thus enabling
> > it to use it for output and share code with dom0.
> >
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index c6ed3ba4bf61..c983cfd4d6c0 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -340,7 +340,7 @@ int __init hv_common_init(void)
> >  	BUG_ON(!hyperv_pcpu_input_arg);
> >
> >  	/* Allocate the per-CPU state for output arg for root */
> > -	if (hv_root_partition) {
> > +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>=20
> This check doesn't look nice.
> First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean that this
> particular kernel is being booted in VTL other that VTL0.

Actually, it does mean that. Kernels built with CONFIG_HYPERV_VTL_MODE=3Dy
will not run as a normal guest in VTL 0. See the third paragraph of the
"help" section for HYPERV_VTL_MODE in drivers/hv/Kconfig.

Michael

>=20
> Second, current approach is that a VTL1+ kernel is a different build from=
 VTL0
> kernel and thus relying on the config option looks reasonable. However,
> this is not true in general case.
>=20
> I'd suggest one of the following three options:
>=20
> 1. Always allocate per-cpu output pages. This is wasteful for the VTL0
> guest case, but it might worth it for overall simplification.
>=20
> 2. Don't touch this code and keep the cnage in the Underhill tree.
>=20
> 3. Introduce a configuration option (command line or device tree or
> both) and use it instead of the kernel config option.
>=20
> Thanks,
> Stas
>=20
> >  		hyperv_pcpu_output_arg =3D alloc_percpu(void *);
> >  		BUG_ON(!hyperv_pcpu_output_arg);
> >  	}
> > @@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
> >  	void **inputarg, **outputarg;
> >  	u64 msr_vp_index;
> >  	gfp_t flags;
> > -	int pgcount =3D hv_root_partition ? 2 : 1;
> > +	const int pgcount =3D (hv_root_partition ||
> IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
> >  	void *mem;
> >  	int ret;
> >
> > @@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
> >  		if (!mem)
> >  			return -ENOMEM;
> >
> > -		if (hv_root_partition) {
> > +		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
> >  			outputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> >  			*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
> >  		}
> > --
> > 2.34.1
> >

