Return-Path: <linux-hyperv+bounces-2474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA8912994
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 17:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B759EB270EB
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87214F8BB;
	Fri, 21 Jun 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="soE/sBnO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2027.outbound.protection.outlook.com [40.92.23.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AE38DE1;
	Fri, 21 Jun 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983119; cv=fail; b=RXobiIr9ha7hwljajaXK2ARLAQFl0NNXOAbKn3jhUt+uynueyBAc0WU1PQhzEW12GGiLSMhiI99R6NuhrwDROz+tpi/jaB/KLQyDv7wC/5cWDD3OFvqVNymGgUz2qE7XoMEjYeWIFEi6SKjsgU1OJ8IJP3RtyZJ8qHrVgqY/Xx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983119; c=relaxed/simple;
	bh=SRHwyjZXTEaCiZnoY9QUdRUkB2ktF+ALQo37gRdq7SI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PQTckGvYGc+YwI/KSSbmgkJfnrYfZTtHOIURq6CUDhlvVhG4n0rwKyFHlpgXS5hpom3xQqvZ1dFD3NK8fm6mI7T5KpbkJy+w8Crk50CuQp9eseiqs5WNdTrYFyOT7ne7CLMCaJSCl2usHFQPTTZi7s07vkTCtt5NlFzZNKkuDMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=soE/sBnO; arc=fail smtp.client-ip=40.92.23.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH2HTfFN4k85dkdAPIilQ3XY8kBCO3X9DrdsbHyBSqVg5NgQghv1OMWXYfFGYjrlx5dbNBJKreDWpr0FyYZUjcQ4ZfGKtAzmWpCPJskLoJqmZcHHs9TexoMnYlR/JZsZOqsP8izgPkdUevX8tiDH5puyflXKfcokeuxEeduOdgtkQIuJsYBYQSKP5R5XJlAm4mle/cVC0QhFL5HV75q2Ydb/fl6kQ4SQg4ai2jmdoayWVNvVDa1bEgxMfvXeefkCsrm7JlOZkpDwlTfdieZ8tsKjxp2b1LrLX+uSbcQ6O9bMv+OZsEgy47H6kbEqmmjqroSyWMaQoDVWD38TVFx9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF1y6NiatmkPVsUBu2jZEF2IEgCXTGFfvNOsLwWzJSE=;
 b=Ivs3qy/D9kbfYFCw5NU6oYLdllLlUW878ZVbyommK8JpwfqmW+vFk31MARqQeCH2x8YjfF80P64tFovg0PDXeXLlbLKIyuS5yZLKhu+4vu2EUUsCPG5d5jftoRPRNREKAYzbcm7Rh3+LyZqaJj1WG+kSlclw94bYGbphn/ZFEBd25wH5RHyEvRb33zmzBYjhxgRsA4uuQzQ7FJVFf7GxflvBNdsT8SEDAQOK47JuH/2FAibLvurZWU+2EXreY4UIbQWZltbxs50rD1XzvmlUdL5ejzi9Wyj9l37XNObxnvMIWeZMpVIB/hvMh+9wTIa+Xd4PgWWmwMyt/FZVlsBt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF1y6NiatmkPVsUBu2jZEF2IEgCXTGFfvNOsLwWzJSE=;
 b=soE/sBnOMU+UMjbvyT1cMYc/lxp1HfOA3hjcJ6w+inwFFaVQOJSPy5OyNEK9gAZ3swvbHonGsJrkW+IKV6z3ypqFCwbFRhFfD3JRCRcnE3W0ZXfQHabj7FjT2EoGtjWrNMHU3wVPzSbyfIQ+UYQ0IPUs4gZYjmtdnzjhOAu8zseAN9gHdArNqkDHRa0taLTeQTZAvvJfrhsYg/yJdRzR8yU28zBJz22tSDrY8oCXrFmh7tMHWqaAPKuyvwYdlEtMyLDpw5OA1tFpa6wQCPi/41s7TQrXQ1dVrWh2cZ1UaRot5Iylwp1xVn2MZSQaP10adetkxyR5bzaR2M3wXsp30Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8497.namprd02.prod.outlook.com (2603:10b6:a03:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 15:18:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 15:18:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Roman Kisel
	<romank@linux.microsoft.com>
Subject: RE: [PATCH v2] clocksource: hyper-v: Use lapic timer in a TDX VM
 without paravisor
Thread-Topic: [PATCH v2] clocksource: hyper-v: Use lapic timer in a TDX VM
 without paravisor
Thread-Index: AQHaw6KqBhSJMhSVSU+BM+3i2rTULrHSVPkQ
Date: Fri, 21 Jun 2024 15:18:31 +0000
Message-ID:
 <SN6PR02MB4157A232D59ADF60CA3BD265D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240621061614.8339-1-decui@microsoft.com>
In-Reply-To: <20240621061614.8339-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [SD+EfaiptBWMiS58pP4W3G6dYj6hGzUr]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8497:EE_
x-ms-office365-filtering-correlation-id: 71a3fa82-36c5-4143-326e-08dc9205690b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|440099025|3412199022|102099029;
x-microsoft-antispam-message-info:
 dwcONAf9tdJZHH81odxkfp6q1Sotyopiu4sy74HyUBrdQ/gpTXCHPfL+XgxBuYq+uouVOz23gZfie9x8C2ROcj0aiZdjErpRwietauI6X6m9KjEaNWaocbTeHwt1TX2J5DSrIDlfzpEU7B0LQ1uUl12+4dfCrlOh/bXbWiByQuxft9mvKcNTETpCnLKYVa52GmWJxWbboPHiMDyRFqhEn8WrLxAokd11bh8uT2vhC7spSWCst/yI/WiAOlxkuQEe+dUMqquT53jqVQFSjv5n4Qzd33VBizRXCvoJtH8hCnLxjFIZhNHONCPpro1WD6T+oHXBlZN0TK6SmRXLsL57e47jaYlEWS2nJ8FV9sMO3qiy2DAGk98nf4BCk8j3uLjj29yH9JXiN880ke4XZSz1RXZdSPChSVnJJqdcwF34qFVNfYP7wmKk8bNkATuv6t5XZbLoZnE1h40vCet5ZYr31uVxdE0f7Riygj7vgQiaKDKAUibKe9vgc0b5CFqv1OuJYN4JmRGtlFL5a1bSf4b7fEq1tYlwtFtr4c3FyYEPSmZHExbg8yW88yJWwDnK2LYF
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S+sYVzWtCa5R2tn9sbM7l3Fh4BtjQN9dzX+wU7w4iWLfcRBqww7v+woMhf3H?=
 =?us-ascii?Q?BdIvTRZxo1Mf7JjNY78bSgQyaoJ4dWp0a39aV+7FsX3OBp86RWWkmFqEBe9g?=
 =?us-ascii?Q?tnP6t3s8IwT1HwGJe8zMaBUbzCUkoFR94qB7gfzEe3LREjTlVn702hJA31Ai?=
 =?us-ascii?Q?qUcgaw//HW9B3I/Hr0PxoomMdRRZQEqYjADeb0Er+PuIQSnG3nxn4drrHzD6?=
 =?us-ascii?Q?gJ57zaCZ6jd2A1Mn77R+gLzA5FBupAnQlA3rg0b32SDVTpIXCiJe56WXkZoq?=
 =?us-ascii?Q?6huHm7h7AbcAL896V78z7b7ZjRhV2uzVTS2NaZOjMqLlXI4DOrJUQ8paKvmx?=
 =?us-ascii?Q?nONiDDRAYMfhUZeojJt26YHV/v4JshSLbz9lh+iDSr1xJ3X47GXSnwwgotId?=
 =?us-ascii?Q?HZIgWSR9rVTo1mi6MbfSCanK+PAKhFsEn6f9WvEB8fskfm6Zkm2nxJRCKBXP?=
 =?us-ascii?Q?RetvnK7ryFy+eR967Gdcy0/6PJc8hHqeYErt+gV3PO8nlgKs40gCg/jPX/LP?=
 =?us-ascii?Q?qsR5wxVZsqMfTdq0sWcmsWTtVhFpSJgYxUk/efadPjBo0YU97n3wo+V7izB/?=
 =?us-ascii?Q?/6VIZeTwOurNkD5O2DgDEMSVgadTO3U70EwCC/BbHGEencOatiYeCWEYBa3u?=
 =?us-ascii?Q?NWqjc64ua0rbGAk5N6Z9fMPOIUup7Ip/anDyWfu22X8u1ShIgxKNvkNe0MkG?=
 =?us-ascii?Q?n14gr/F/1/5anb8KNng8MMV33lrWgCPjo13oyZVe2jLp86yi2od/J4faOXPf?=
 =?us-ascii?Q?LSL6dTh/zEB9E957blFnc5UdgI6UUF9IcKGb7X/iLL3Wa/a//6MT42IehqvG?=
 =?us-ascii?Q?2mV1DQK/iF6mw0O1WyoprN8yJsuCx0AWL6o+EpHhRFwiu4gnWCotpq+IzZDP?=
 =?us-ascii?Q?34yb+Bx4v+15YsKdvBve5DOYUmQjDi36kHn6ZgsvWhCWhJxFm8EZQw3MtrIj?=
 =?us-ascii?Q?JQM8e1ixqPrVUP94+2VmI9tvnxyG6ZACEB3mnnb4vT/Dm8EFflm3Oc1QJLHu?=
 =?us-ascii?Q?2A9ZhfJ2ON/cwO5W3WfZD+TWr9pUMCvcYxnNk0TxBV84mOpJafMiWmBkR10z?=
 =?us-ascii?Q?f2DW8kIyV15QdVDQGApmr5HMz9XO4lIdQHJTX6fYhYaH8cbzi4pOdGn27iRo?=
 =?us-ascii?Q?YwzrKd2T4zf6yj92HodChvq38WowUot8enBjwwmFytQmm6Mb1K+IWqz3UVg8?=
 =?us-ascii?Q?sUjs3cDw0aMdrNliDzaS0vBOmrJBkGoUQJfoZ6CMht0vJZvMWRrT284aO6A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3fa82-36c5-4143-326e-08dc9205690b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 15:18:31.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8497

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, June 20, 2024 11:16 =
PM
>=20
> In a TDX VM without paravisor, currently the default timer is the Hyper-V
> timer, which depends on the slow VM Reference Counter MSR: the Hyper-V TS=
C
> page is not enabled in such a VM because the VM uses Invariant TSC as a
> better clocksource and it's challenging to mark the Hyper-V TSC page shar=
ed
> in very early boot.
>=20
> Lower the rating of the Hyper-V timer so the local APIC timer becomes the
> the default timer in such a VM, and print a warning in case Invariant TSC
> is unavailable in such a VM. This change should cause no perceivable
> performance difference.
>=20
> Cc: stable@vger.kernel.org # 6.6+
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2:
>     Improved the comments in ms_hyperv_init_platform() [Michael Kelley]
>     Added "print a warning in case Invariant TSC  unavailable" in the cha=
ngelog.
>     Added Roman's Reviewed-by.
>=20
>  arch/x86/kernel/cpu/mshyperv.c     | 16 +++++++++++++++-
>  drivers/clocksource/hyperv_timer.c | 16 +++++++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e0fd57a8ba840..954b7cbfa2f02 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -449,9 +449,23 @@ static void __init ms_hyperv_init_platform(void)
>  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
>=20
>  			if (!ms_hyperv.paravisor_present) {
> -				/* To be supported: more work is required.  */
> +				/*
> +				 * Mark the Hyper-V TSC page feature as disabled
> +				 * in a TDX VM without paravisor so that the
> +				 * Invariant TSC, which is a better clocksource
> +				 * anyway, is used instead.
> +				 */
>  				ms_hyperv.features &=3D ~HV_MSR_REFERENCE_TSC_AVAILABLE;
>=20
> +				/*
> +				 * The Invariant TSC is expected to be available
> +				 * in a TDX VM without paravisor, but if not,
> +				 * print a warning message. The slower Hyper-V MSR-based
> +				 * Ref Counter should end up being the clocksource.
> +				 */
> +				if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> +					pr_warn("Hyper-V: Invariant TSC is unavailable\n");
> +
>  				/* HV_MSR_CRASH_CTL is unsupported. */
>  				ms_hyperv.misc_features &=3D ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index b2a080647e413..99177835cadec 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -137,7 +137,21 @@ static int hv_stimer_init(unsigned int cpu)
>  	ce->name =3D "Hyper-V clockevent";
>  	ce->features =3D CLOCK_EVT_FEAT_ONESHOT;
>  	ce->cpumask =3D cpumask_of(cpu);
> -	ce->rating =3D 1000;
> +
> +	/*
> +	 * Lower the rating of the Hyper-V timer in a TDX VM without paravisor,
> +	 * so the local APIC timer (lapic_clockevent) is the default timer in
> +	 * such a VM. The Hyper-V timer is not preferred in such a VM because
> +	 * it depends on the slow VM Reference Counter MSR (the Hyper-V TSC
> +	 * page is not enbled in such a VM because the VM uses Invariant TSC
> +	 * as a better clocksource and it's challenging to mark the Hyper-V
> +	 * TSC page shared in very early boot).
> +	 */
> +	if (!ms_hyperv.paravisor_present && hv_isolation_type_tdx())
> +		ce->rating =3D 90;
> +	else
> +		ce->rating =3D 1000;
> +
>  	ce->set_state_shutdown =3D hv_ce_shutdown;
>  	ce->set_state_oneshot =3D hv_ce_set_oneshot;
>  	ce->set_next_event =3D hv_ce_set_next_event;
> --
> 2.25.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


