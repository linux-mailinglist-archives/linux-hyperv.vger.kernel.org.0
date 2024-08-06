Return-Path: <linux-hyperv+bounces-2727-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0A94872A
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 04:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E6B1C22361
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D25B644;
	Tue,  6 Aug 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="me+pOwjO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010014.outbound.protection.outlook.com [52.103.20.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76A15E8B;
	Tue,  6 Aug 2024 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909719; cv=fail; b=GCEtSvJAKAGW87vl384Kcn8VH2CGSGj2XgzlI3kai1KYuO9amPlWeRA/GibDVlA1GwDW1kElD8RP9lXuQrsVkHaxubV8bD7rjhc+Q9djPMHJQC7vV0HhCb4gX7p5BFyrIWR+NcTt+z6egWXCU2UmkkHuG95XqFz59hlMpUC0sKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909719; c=relaxed/simple;
	bh=z78pBUhUMg4I0lpVvWQ2YZiJKEI/N7UX//XskKFBz+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nZbjhmjwizNlkByqP2FLW5Zs9416GbnnVbCXfWc7W0oCdfYmt/NwWrrfzGTKxPRfBCQcjgI7W647rcVPoelwJWARbS2PBxSJJea5QGKhZnoP3VCQuzltzOcMu8ljbQb8xIBQA0oemNtRbundixaO5zU8QP9lS5dWOgxMQl1LDyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=me+pOwjO; arc=fail smtp.client-ip=52.103.20.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1G8B9fa5H2PGqXaSyZA/57NDSkqMt0cQN2CaRDMLRsw5gDIjLXOsK5yAD0Z3JpTpe1K9qWnNzss28maejZSfHpXn45Ay1DGLD40WJ0axVHWgQoHmzX8ARjEP2ISI5Zf0EjkDpaj0MiSxUforsGS+IytrnmBS2pReuBM2tSwMKHetVlH/ug2AJiagBLx+mUZgsl5OJBARnKW0AHjAglve06/SW4suSfIkzkTtlnmR5cXLRc2sBIChnrsi7wUdCO4dBnFBb3qTRsXc9EwdVdvR0UqA8cKmgmC/CrXk+dpRObBHwK1+nxs82zmOKrIcTykzsSd/yscbtxEKsZlJc1Jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70Mne6lLrKP1xZzg45Qh8G0TeonCMd4d2S6sBrZFQ+I=;
 b=bQIdOr0ZKhCW+fOG8w2EIll1CjUfwjBgX1GMkcYLdp3qX1L4eZZQM3iZBEL8Iulu8JFecLPyh9478aPzGU+q9Lzut7nPw1jgAagmSsmK2Ru0JZlni6f90aRKjyPCNnJGrAco3bgnMBHi77jdyBxOWPT92Vh1NO3ky7uvRTOV7WJGFGYAT1k0gan95ElkT+5CG5Oa50IK4LJEY8SJ8hAUFUk4VILgWuHT1ghYHgslWM+k4iLX0lee5lUXDTEUVDN2bthIjSlOSxqB120F399moQyTA2zsVI0cl0vrT/lUA5/rZyANU9e6J5+0ZxgahWId8qaE3oVLE+uVst4GF4APWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70Mne6lLrKP1xZzg45Qh8G0TeonCMd4d2S6sBrZFQ+I=;
 b=me+pOwjOEe318IdhIMSr5QvMkWM1sKuowp304AK5+Se273Q0/+L0fSyLd0pk9RlfNPdeuFzEuogUlRLFjYtHyy3qLSU4rgs34Qt+OL3j5P/vUTRc8NzqFFWUqW1fHMH2NsgpiyWNAZ+OUcf/5XP3/TjCn0m8Gb21+HtQWJFzxrfrwBJTIQlhsCC725rkN4c/H+B51uOyaLLEbhAh1010b+W8lzXWf9jAeBs3uuHEux8jEm1FXG63VBQofVem74U82LqJVfYmxOSPq9ERWpiSOSkFe+1X5G8GcOglYy5TUmlUyAL9wKNixF2TiKWbK1VjrqNSd1KG9fU9wuz4J5E3RA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9096.namprd02.prod.outlook.com (2603:10b6:8:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 02:01:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Tue, 6 Aug 2024
 02:01:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when
 Hyper-V provides frequency
Thread-Topic: [PATCH 1/1] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when
 Hyper-V provides frequency
Thread-Index: AQHat70l6VEQWY4Q4kahuGYMS8f1uLHCrksAgFJPgYCABNrOcA==
Date: Tue, 6 Aug 2024 02:01:55 +0000
Message-ID:
 <SN6PR02MB4157E061956EF4D394E587D8D4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240606025559.1631-1-mhklinux@outlook.com>
 <226804eb-af9d-4a56-aef5-e3045e83b551@linux.microsoft.com>
 <Zq1wkyTkWCrdYx2-@liuwe-devbox-debian-v2>
In-Reply-To: <Zq1wkyTkWCrdYx2-@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [y2jMsLoJUWWCC9YLNL9mjvQ2ox+c6yGi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9096:EE_
x-ms-office365-filtering-correlation-id: d656eed7-4eda-4afa-cdf3-08dcb5bbbf3f
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 8E5N8MY7otSmjfq8m0dcbZizJcdVYZ6esZ1z/S4SAL1GViVPNo7l34kOf5EV5GsHTaAY4HVLyBqNEZWqTLUJmXKJ83/CNJ4NoLSIn0ymLKoEq82HY1wIdzjT8Y0BavnyW+jy4wjkEyMGH3mPOFEWu9sqBNTRMKGvSwxmg3QCZWGv8kbYzGhLOuqZ+tpuv2PQvlPWpOxFkT5EetWXJVvNyN8rz9qYXxl/Syd6UA0PA8PG+mXXVqo7tQIm9mjlTE1xIXHsR7rmbGuPnlSwAwsfYlRBzdCFie4atvQtMLtDQe9TZx1PRRA6qksTJgkM+c0kWhXAyY2Ge+kg/Z2a4hRM1YYCfBIZnHqPV95vz2/Uoz+QtSGwTIzDldE/c9zO1SCDxgJL/wCwudWz4NgdI/D8uXg8Jjtrs6RPT3YVg4mjUzdz0WBnB5jFanmOv1K0l4RiarIUQWUFG0mgFGCNZpqbqhmCkHucyuxrANd6kA+1GHWB3rbpJiAmhx+kdvCanBXN/OB5OR9nkhHx5/hsPmveeCinm4afINB/Yuq+gPho+0orQ2FoF0lS9bpbEA21Bf+TZT79Uz2wyzYSAIDPnH/OV/qFfBvDareiEEAPTU7nPFoBAWJ3C/tdqLmzp+qJAuxm2hMvLdxTjUI3lMfKTxp1NQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cTdgrPMGTQLTaQFS8/ecdsWfLg14eVJv3DBf3FbJILqsx2Or9pTkH9/Xru6b?=
 =?us-ascii?Q?w1QeLkkD+KRJmoOIctqSssd6NZm+O0RsQpg/UE2jzdI0whCW4dl0Saipnh8E?=
 =?us-ascii?Q?XKta51Fc3ZeWBAzWumPyk5vbRLnrHO/0VLhANbe6cE+A2nqTL/g+i1WGahDZ?=
 =?us-ascii?Q?fVd28if6W6ygZ8HcGDUm3vEUPhv9Sswxxj38/AiODwfVcjvIS3JchXsU1v3T?=
 =?us-ascii?Q?4DTsoKFM/LCqQGFefjYkv0MrF+scSDPOQjUQBytfRN5S9IzPfktYV9Xh2waN?=
 =?us-ascii?Q?crYWd3AphBwVZDLJgj4KqDmMPxUAakPthDOPxVPx0czi21IQqOiNqma80oIl?=
 =?us-ascii?Q?dBVo+pt32Xsd7/fpsDdntCIiE0QCbOC28aU6+gCKy8nkh1ZrgsrEf/L/Cls/?=
 =?us-ascii?Q?0jczQ+Pf9WnLbA7A3fAQTGWdRqxNq56bei6yOc6WY5IkUWt1GvgCVSOLG2BF?=
 =?us-ascii?Q?7Lpd5WkUhlPaWCYVcGaBmvTqknSaaPvaA9LyadtFQe4A2MgKhp8wiHzMlsRv?=
 =?us-ascii?Q?8qvDJQF0FX/LK+Mr60Nct0sQ6X/cgtQ5qsastzCBO9c+JbMkyhRxhTxYctaC?=
 =?us-ascii?Q?ouMOQ2Dqp5/P1z6wesUahuI+Lop3uzCbQiIs8ONrrwEfd5F4WQiH1kSbLlnK?=
 =?us-ascii?Q?2qCe7CLgJA0kCkH3AzPi+igHaLB235bI7QeaBl5RG39UDw4pOGtItZ1fiNMZ?=
 =?us-ascii?Q?y8CXluv72XNASUV2ldV6EOGjr5gT+oJSI6jFWMGvAvZ1V9EsYpuk5GXtuIje?=
 =?us-ascii?Q?nz/vedsNizSwQn1iavPlDADrRkuoNBin/xSq9AfChf8vmOVKclJ1z10gQoxm?=
 =?us-ascii?Q?1V4UPPFDu4MZV3Puh2TZ8iBaKk8v4itZxB5JXS4jDDAE+GkuhF+rQfiMoDzS?=
 =?us-ascii?Q?JBzVwbMpyILkNe0g4ylsmTQcWRhvJgDwroEDQWvnCfEho+Z6SvMJy+dl/slz?=
 =?us-ascii?Q?RAnhimFBuEB0UVNCWGLFPYWz0rR4EDuB6509RTH8FP+d0fGJLp+6hypwpkSJ?=
 =?us-ascii?Q?0jn7TwMOa1tkMTIG8oCdAhfY8oIg0KLb5wz793RsicCDMvTT6kQP3znAdMr0?=
 =?us-ascii?Q?sDLSbn48ILeHMUk7qc68T/DK6HWRZB0dkDtwrPd5bLA11i+3ozVCJISVQkJD?=
 =?us-ascii?Q?Tur3XV0XuVQ1Qwf0FOEBMQqyZyjmN89Qe8jLdbKfjvR5pA+NExplbCBG7BWQ?=
 =?us-ascii?Q?l650GopO8Kk1PO8KPa80VTl4qGVH4salYFNaOrA6Lp3UdMrd4si5Oc4aEgY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d656eed7-4eda-4afa-cdf3-08dcb5bbbf3f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 02:01:55.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9096

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, August 2, 2024 4:50 PM
>=20
> On Tue, Jun 11, 2024 at 07:51:48AM -0700, Roman Kisel wrote:
> >
> >
> > On 6/5/2024 7:55 PM, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > A Linux guest on Hyper-V gets the TSC frequency from a synthetic MSR,=
 if
> > > available. In this case, set X86_FEATURE_TSC_KNOWN_FREQ so that Linux
> > > doesn't unnecessarily do refined TSC calibration when setting up the =
TSC
> > > clocksource.
> > >
> > > With this change, a message such as this is no longer output during b=
oot
> > > when the TSC is used as the clocksource:
> > >
> > > [    1.115141] tsc: Refined TSC clocksource calibration: 2918.408 MHz
> > >
> > > Furthermore, the guest and host will have exactly the same view of th=
e
> > > TSC frequency, which is important for features such as the TSC deadli=
ne
> > > timer that are emulated by the Hyper-V host.
> > >
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > ---
> > >   arch/x86/kernel/cpu/mshyperv.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/msh=
yperv.c
> > > index e0fd57a8ba84..c3e38eaf6d2f 100644
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -424,6 +424,7 @@ static void __init ms_hyperv_init_platform(void)
> > >   	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE)=
 {
> > >   		x86_platform.calibrate_tsc =3D hv_get_tsc_khz;
> > >   		x86_platform.calibrate_cpu =3D hv_get_tsc_khz;
> > > +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > >   	}
> > >   	if (ms_hyperv.priv_high & HV_ISOLATION) {
> >
> > LGTM
> >
> > Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>=20
> Applied to hyperv-fixes. Thanks!

Wei --

hyperv-fixes isn't showing this patch, or any of the others that your
emails said you applied last Friday.  Hence the patches aren't in
linux-next either.  Did something go awry?

Michael

