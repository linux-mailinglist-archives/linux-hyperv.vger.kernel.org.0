Return-Path: <linux-hyperv+bounces-3000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9F3975FCC
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 05:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8631F2331A
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2024 03:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BF166F28;
	Thu, 12 Sep 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EqLPkh9w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010013.outbound.protection.outlook.com [52.103.11.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81641C85;
	Thu, 12 Sep 2024 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726112384; cv=fail; b=Iuy59mtqiEpE9MHgHIr27a4cNAXmscpmbVp1u95uhAfpMJiUrOhc/9AoklxNtGuio/ocS7DQtxbmO5DRdQNGumLT0pFW4czbr71MOuriVb/pfM/MQA7H2qRLYkbE4NoigqCmLI0EzJovkBtk64QtET5R7wZnqmkq+9LjIprGbRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726112384; c=relaxed/simple;
	bh=WeTAgt4sCwsO7JKxEwg45bRn24YIYstEFrytQ9qjuc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oB7M4GF8f3p80eZVCm5ZfzHb+aJ9jR7QgVKpNPxUGYDEcQ2/IHbwBh9JZHWqC+17t1cbGTv3bilvMRGPqAO840X+KtYUHkKyU0ApP7VT+/yDtvTH5gA6hou+l5ugcyu2O4z65qKyz3aZ5hVKIDQxQpSrcvFJHNx4zUqHgj4HPHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EqLPkh9w; arc=fail smtp.client-ip=52.103.11.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rhsp5IS0JJGfAvhfRMt3nfxPBXqDKhzyrOEFBtwQjvl80x6OcZ9tMx7dwgJWJ7sfaxFV9I4aZf//O9lVDh/TOL9ZmkMiN1c7itOMC4tOvETFLg/L9EHCFx6i7nGjAEgL/NtXQp28Ij72Cj7DN1yHP1b6TF+S4mkK/RZDwTlV9W1zqEnyGV5TCJ65OoStYrwMnMwysrZnh77lQa5Smp75wj/poPrZmU99HyMmnTTS0pdz38xfiUSZkr1jqKrYeDj46iO6nMpIxIV7PCdHZIACydplFRiimqZTlr2axbg2BHDwo99jlf2dadNgRVnCjJo0luMgRRGext7BDpaHksvY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xpnbLTIkGUD9D28woNrqF2MQj0EsLy2wc05HrapXB8=;
 b=HQOnVzpTneaeReeU9fVJMBkY+zbohNTDMzEWK4vtabxiGNE9FJU5edwtWcY6sPgZTgIv6jgUSz73n6nBrJzeB/HMlqwgavS/4segbe0ejwvwDqE7CT24ik4pdfHxHlykWlFQzRlDFy+RI941UoP3I5pUF/aDIy6iNQ2w1wI617TvDCC67DMRSF4Y4OtCbI9/VyB0rcN6BXCvF4HsdZ5ZP9Pkx8nUguUP3mvnTYjR2oWtm4O0w7Hl9MpIqzZypY7IgHFbWFI5HpAoQAnUMA12xlJEEODIOCFuobY8ylsDmPc6bomuT0sw3ClAqNoA9wlYkyuKzxWoP35WDwK6uutjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xpnbLTIkGUD9D28woNrqF2MQj0EsLy2wc05HrapXB8=;
 b=EqLPkh9wOFxVFCxzhETJSozbOyBtChozCo+l7ol+xvDw3e8YRXDn/KQAcPUnkH+OOkK/fSE2eukvDhZKATdkDwaitL3oCbH6sAOuOOVafU34Ng1E8OV+avgMOf2EfFNXO92zuI4R2w6oy3Gytjw9hXdZ5q6wpNHjjfPFWvlGRtdYZVcxIhXNhlRiOCtlRs9RiyZkKqOTTFcLeWCFy4wTUjhEfpBZOYcFOZe1nI6jZhkj1a3cxlAu+BGfQF3DKaDk7aGVfoAqHP3/ggQs3CpNuPVbDc4PleaYm9Ehg2k57LnkGwN/0tSbqt9FNVW4churIJsv0zIE1VCLAl1Qye7D2A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM8PR02MB8021.namprd02.prod.outlook.com (2603:10b6:8:16::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 03:39:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 03:39:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] clocksource: hyper-v: Fix hv tsc page based
 sched_clock for hibernation
Thread-Topic: [PATCH v2] clocksource: hyper-v: Fix hv tsc page based
 sched_clock for hibernation
Thread-Index: AQHbBAcBfc77nN9oek2fyQW91c8qt7JTUAQQ
Date: Thu, 12 Sep 2024 03:39:39 +0000
Message-ID:
 <SN6PR02MB415797B9F0A29B91C6117D5BD4642@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240911045632.3757-1-namjain@linux.microsoft.com>
In-Reply-To: <20240911045632.3757-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [g18wQjj91DMBtTD6Ib5N0fRJoOawzgvw]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM8PR02MB8021:EE_
x-ms-office365-filtering-correlation-id: c6d7bb6a-ad63-4bcd-cc23-08dcd2dc87c0
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|19110799003|15080799006|102099032|4302099013|440099028|3412199025|1602099012;
x-microsoft-antispam-message-info:
 o7X9HeWaSm1L0K5xrm2kRX/7eXx1wViRwnsGN9DZHd+Jc1y8VGob83As6rN7Coq8MLGmmBsLhup8pr+Um50yKYFNkYCGhLxOzExs5YegbsNZ40tMiol+3aSauIQ7SQjXpDyfbG6taocV3ZQiU94j4O4IOLcw6MtbIo3VWCKfDr0flvLvyqI8MUPvVQeuNqmBEKrIfWdGZOtWl4KjRpW+1PvL9Dte/CeGlwJE8unaZ7WgWkiQhsBZclUf9UQMhaw/cht94aknGVlM5DRYSLfbhchLXB+1jl9e/NUR7TTJetO37Y40lDEbAmt7divJFC4dYyL9rYRtnBIIdne7ojz3AuEKWt/zgEJOgj87cKBg7zfhd8ZE/byIpOyg11z0iYuqiLAW7r0jYSwQEyjbYFev2c0ybPdNOD7pqt2G8pgeVpgPkChJhTPQKXJfdN+zVyUQYc6+RQAMcH8++MN9M8/aKtGGrrzIfyXfN193AH+inNEA0rw+afQ4FFFIjbte5Lpems+AzDQjLP5cnAdB6Oob6oXCd/Ut0p5S6m5OBRHPQJgOf0bYpCKJDvGjgWZFixivIHhR6d8lH2HevwW7E71OBIcHh6QCHWH8KSxyvgT+Lc6bQEmb7mulFv1bGV8lEszEj7zN5KrJI2DyCQDSVrM2eXMdlTDIxmW9HO9bRXLT8SCfP6+rnIcL/R+jp0zNaAaOc2JOJbXHs1ZiaKpnp7sGRqa2hBXtGrHLF9UEVQCFKn/G+6rJCWj7iau2MZ5dleD09db4Y7rdqx68kU8q5NKsxOmJBllm9WEXIpIDY1EwaKYk7cUjDp7FWkM9+JyBFtVLYrEEMYFNzSCXTI+L8V+fxg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ih4wtm5hsoug/a20j+ZHMtP+YsSCfMyK7i4WXbZXzQlJKwsyEtg49NXSgQm6?=
 =?us-ascii?Q?TGMMVDvclbipcaZF85UJdQy//GJ99w287gp+G9jvoBy497zJRd1nTnD0izIS?=
 =?us-ascii?Q?6FdluZucYZr5LMttzcJzgtqjQhIwbQX85xcR94ZkDsVLQ3c4QGs3M/eOchgQ?=
 =?us-ascii?Q?Cng3Eo78zdxL1xVjxklFziPddq66/HIwgd3PH8AGCnjlMf5PQHyISiHTmYMx?=
 =?us-ascii?Q?GFR4CCiMnrnFetcfAtEDXn/Zq4/LRjxrrztzZ71ICyb5QGBaqSqR1iLFPabq?=
 =?us-ascii?Q?YkmgiWJLniPHfuTjE+UvqNnwgtgnPFFCl49HcwK8KmQMGxeJAzS51WTpM4QK?=
 =?us-ascii?Q?sYy/J2fEfw4e06AKIu+ano5WD69jPmeCzk0U0dqFW23VGIN8+5280usrGtur?=
 =?us-ascii?Q?V9bZ5+bjTrR6toPmA8iHUXjgOic2WWe+kU9XETmxDzrkPS/xm1jP/7YC4Uwt?=
 =?us-ascii?Q?3MnU14CzV7ex/5XwMHRWFGCepCYcJ4eAZhdGW4YqWD1L5y6/PcBv6CXfy3BY?=
 =?us-ascii?Q?R5Z8te+DrIye/IES7Dd0wFygdpCZYG/a6hdixBevaITlgwbTCEBaSVpxxTrN?=
 =?us-ascii?Q?NvUomvxceoglLUmjm/WQdrO5/OB1kBqyJ/OeM1zn7+bAH5ViGqYK7hydUwvf?=
 =?us-ascii?Q?JzUqKGEX+2Knfv+CQixmZE9UvAROYGCb+u3KKW/hP3YZBKFfzIueIZKG9LpA?=
 =?us-ascii?Q?i9ZtJEBcblFzBn7LE9lG5s6DT71lTo3O0bRfioysU9T3YOwc7qZ70TT8gRVf?=
 =?us-ascii?Q?jQkH+BIMtfSFoIdrFW92ec8zLquoRM6ELZTBwzjgKT70dokeq7Nebj03MFHX?=
 =?us-ascii?Q?oUjzli0HE1btaRt94ypnnT/Pp2M9+LelcceLriPK9HfNMk3MxrntLiI+k4Mb?=
 =?us-ascii?Q?/D5WZfLDze3CqBRtbEpEoidEg8gC+LOEr/gGYGP/JkM4wCDu/Wec3pPrtguD?=
 =?us-ascii?Q?vq0ahvJdWnPM8H6sj9iPow4c6JOSV/09FOKHIK3SSkhFb+Cngpl5SZQOrKkR?=
 =?us-ascii?Q?XvOAw5ZqjBOI7aNjWAGA0eQG9iDWxePIDp/+m4vWIsSYdyusuak+sd5pEItm?=
 =?us-ascii?Q?RaeJb194fr5VDQD9Fcqu3D7NoY+mC8GtjiT6zls4Q41guLgF0NFlKmJJ/iBD?=
 =?us-ascii?Q?UKb/O73MXJRWHgro2TSl2HjKd571VAz0vqCPfcWYGJr1JzaZvijHvWhtFw0M?=
 =?us-ascii?Q?eNMkQjcjB2hj9T46rR63njG0SG6CTFJWhJLzMkZFfdU49UdPeqE8s2XVwuc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d7bb6a-ad63-4bcd-cc23-08dcd2dc87c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 03:39:39.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8021

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, September 10,=
 2024 9:57 PM
>=20

This version of the patch looks good to me from the standpoint of
separating the x86 specific functionality from the arch independent
functionality. And I think the patch works as intended. But there
are parts of the description and variable naming that don't align
with my understanding of the problem and the fix. So I've added
some additional comments below.

Nit: Now that most of the code changes are in mshyperv.c, the
patch Subject: prefix should perhaps be "x86/hyperv:" instead
of "clocksource: hyperv:".

> read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
> bigger than the variable hv_sched_clock_offset, which is cached during
> early boot, but depending on the timing this assumption may be false
> when a hibernated VM starts again (the clock counter starts from 0
> again) and is resuming back (Note: hv_init_tsc_clocksource() is not
> called during hibernation/resume); consequently,
> read_hv_sched_clock_tsc() may return a negative integer (which is
> interpreted as a huge positive integer since the return type is u64)
> and new kernel messages are prefixed with huge timestamps before
> read_hv_sched_clock_tsc() grows big enough (which typically takes
> several seconds).

Just so I'm clear on the sequence, when a new VM is created to
resume the hibernated VM, I think the following happens:

1) The VM being used to resume the hibernation image boots a
fresh instance of the Linux kernel. The sched clock and sched clock
offset value are initialized as with any kernel, and kernel messages
are printed with the correct timestamps starting at zero.

2) The new Linux kernel then loads the hibernation image and
transfers control to it, whereupon the "resume" callbacks are run
in the context of the hibernation image.  At this point, any kernel
timestamps are wrong, and might even be negative, because the
sched clock value is calculated based on the new Hyper-V reference
time (which started again at zero) minus the old sched clock offset.
The goal is that the sched clock value should be continuous with
the sched clock value from the original VM. If the original VM
had been running for 1000 seconds when the hibernation was
done, the sched clock value in the resumed hibernation image
should continue, starting at ~1000 seconds.

3) The fix is to adjust the sched clock offset in the resumed
hibernation image, and make it more negative by that ~1000
seconds.

Is that all correct?  If so, then it seems like this patch is doing
more than just cleaning up the negative values for sched clock.
It's also making the sched clock values continuous with the
sched clock values in the original VM rather than restarting
near zero after hibernation image is resumed.

>=20
> Fix the issue by saving the Hyper-V clock counter just before the
> suspend, and using it to correct the hv_sched_clock_offset in
> resume. Override x86_platform.save_sched_clock_state  and
> x86_platform.restore_sched_clock_state.
>=20
> Note: if Invariant TSC is available, the issue doesn't happen because
> 1) we don't register read_hv_sched_clock_tsc() for sched clock:
> See commit e5313f1c5404 ("clocksource/drivers/hyper-v: Rework
> clocksource and sched clock setup");
> 2) the common x86 code adjusts TSC similarly: see
> __restore_processor_state() ->  tsc_verify_tsc_adjust(true) and
> x86_platform.restore_sched_clock_state().
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1349401ff1aa ("clocksource/drivers/hyper-v: Suspend/resume Hyper-V
> clocksource for hibernation")
> Co-developed-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> Changes from v1:
> https://lore.kernel.org/all/20240909053923.8512-1-namjain@linux.microsoft=
.com/
> * Reorganized code as per Michael's comment, and moved the logic to x86
> specific files, to keep hyperv_timer.c arch independent.
>=20
> ---
>  arch/x86/kernel/cpu/mshyperv.c     | 70 ++++++++++++++++++++++++++++++
>  drivers/clocksource/hyperv_timer.c |  8 +++-
>  include/clocksource/hyperv_timer.h |  8 ++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e0fd57a8ba84..d83a694e387c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -224,6 +224,75 @@ static void hv_machine_crash_shutdown(struct pt_regs
> *regs)
>  	hyperv_cleanup();
>  }
>  #endif /* CONFIG_CRASH_DUMP */
> +
> +static u64 hv_sched_clock_offset_saved;
> +static void (*old_save_sched_clock_state)(void);
> +static void (*old_restore_sched_clock_state)(void);
> +
> +/*
> + * Hyper-V clock counter resets during hibernation. Save and restore clo=
ck
> + * offset during suspend/resume, while also considering the time passed
> + * before suspend. This is to make sure that sched_clock using hv tsc pa=
ge
> + * based clocksource, proceeds from where it left off during suspend and
> + * it shows correct time for the timestamps of kernel messages after res=
ume.
> + */
> +static void save_hv_clock_tsc_state(void)
> +{
> +	hv_sched_clock_offset_saved =3D hv_read_reference_counter();

Naming this variable hv_sched_clock_offset_saved doesn't seem to match
what it actually contains. The saved value is not a sched_clock_offset. It'=
s
the value of the Hyper-V reference counter at the time the original VM
hibernates does "suspend".  The sched_clock_offset in the original VM will
typically be a pretty small value (a few seconds or even less). But the
Hyper-V reference counter value might be thousands of seconds if the
VM has been running a while before it hibernates.

> +}
> +
> +static void restore_hv_clock_tsc_state(void)
> +{
> +	/*
> +	 * hv_sched_clock_offset =3D offset that is used by hyperv_timer clocks=
ource driver
> +	 *                         to get time.
> +	 * Time passed before suspend =3D hv_sched_clock_offset_saved
> +	 *                            - hv_sched_clock_offset (old)
> +	 *
> +	 * After Hyper-V clock counter resets, hv_sched_clock_offset needs a co=
rrection.
> +	 *
> +	 * New time =3D hv_read_reference_counter() (future) - hv_sched_clock_o=
ffset (new)
> +	 * New time =3D Time passed before suspend + hv_read_reference_counter(=
) (future)
> +	 *                                       - hv_read_reference_counter() =
(now)
> +	 *
> +	 * Solving the above two equations gives:
> +	 *
> +	 * hv_sched_clock_offset (new) =3D hv_sched_clock_offset (old)
> +	 *                             - hv_sched_clock_offset_saved
> +	 *                             + hv_read_reference_counter() (now))
> +	 */
> +	hv_adj_sched_clock_offset(hv_sched_clock_offset_saved - hv_read_referen=
ce_counter());

The argument passed to hv_adj_sched_clock_offset() makes sense to me if I t=
hink
of it as:

	hv_ref_time_at_hibernate - hv_read_reference_counter()

where hv_read_reference_counter() is just "ref time now".

I think of it like this: The Hyper-V reference counter value changed undern=
eath
the resumed hibernation image when it starts running in the new VM. The adj=
ustment
changes the sched clock offset to compensate for that change so that sched =
clock
values are continuous across the suspend/resume hibernation sequence.

I don't completely understand what you've explained with the two equations =
and
solving them, though the result matches my expectations.

> +}
> +
> +/*
> + * Functions to override save_sched_clock_state and restore_sched_clock_=
state
> + * functions of x86_platform. The Hyper-V clock counter is reset during
> + * suspend-resume and the offset used to measure time needs to be
> + * corrected, post resume.
> + */
> +static void hv_save_sched_clock_state(void)
> +{
> +	old_save_sched_clock_state();
> +	save_hv_clock_tsc_state();
> +}
> +
> +static void hv_restore_sched_clock_state(void)
> +{
> +	restore_hv_clock_tsc_state();
> +	old_restore_sched_clock_state();
> +}
> +
> +static void __init x86_setup_ops_for_tsc_pg_clock(void)
> +{
> +	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> +		return;
> +
> +	old_save_sched_clock_state =3D x86_platform.save_sched_clock_state;
> +	x86_platform.save_sched_clock_state =3D hv_save_sched_clock_state;
> +
> +	old_restore_sched_clock_state =3D x86_platform.restore_sched_clock_stat=
e;
> +	x86_platform.restore_sched_clock_state =3D hv_restore_sched_clock_state=
;
> +}
>  #endif /* CONFIG_HYPERV */
>=20
>  static uint32_t  __init ms_hyperv_platform(void)
> @@ -575,6 +644,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
> +	x86_setup_ops_for_tsc_pg_clock();
>  	hv_vtl_init_platform();
>  #endif
>  	/*
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index b2a080647e41..e424892444ed 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -27,7 +27,8 @@
>  #include <asm/mshyperv.h>
>=20
>  static struct clock_event_device __percpu *hv_clock_event;
> -static u64 hv_sched_clock_offset __ro_after_init;
> +/* Note: offset can hold negative values after hibernation. */
> +static u64 hv_sched_clock_offset __read_mostly;
>=20
>  /*
>   * If false, we're using the old mechanism for stimer0 interrupts
> @@ -456,6 +457,11 @@ static void resume_hv_clock_tsc(struct clocksource *=
arg)
>  	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
> +void hv_adj_sched_clock_offset(u64 offset)
> +{
> +	hv_sched_clock_offset -=3D offset;
> +}
> +
>  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>  static int hv_cs_enable(struct clocksource *cs)
>  {
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyp=
erv_timer.h
> index 6cdc873ac907..62e2bad754c0 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -38,6 +38,14 @@ extern void hv_remap_tsc_clocksource(void);
>  extern unsigned long hv_get_tsc_pfn(void);
>  extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>=20
> +/*
> + * Called during resume from hibernation, from overridden
> + * x86_platform.restore_sched_clock_state routine. This is to adjust off=
sets
> + * used to calculate time for hv tsc page based sched_clock, to account =
for
> + * time spent before hibernation.
> + */

I would have expected this comment to be placed with the actual
function in hyperv_timer.c, not with the declaration here in the .h
file.

Michael=20

> +extern void hv_adj_sched_clock_offset(u64 offset);
> +
>  static __always_inline bool
>  hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>  		     u64 *cur_tsc, u64 *time)
>=20
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> --
> 2.25.1


