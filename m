Return-Path: <linux-hyperv+bounces-3046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4497C02B
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 20:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A00B1F220D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D81C57AA;
	Wed, 18 Sep 2024 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c82BXV+Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2048.outbound.protection.outlook.com [40.92.23.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30F183CB7;
	Wed, 18 Sep 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726684664; cv=fail; b=CNUkq2m7IvvKUj2QVBwbN7sglYW/aafETwlaXmzFwdyCbCLw3tEE8f9UnBLBebyj0V2ncyQ/pzkh312zyHuMTs0RNYjBhe5itGC8ZaLBM+dRaYAbnEjnOx9f8B7NydxnQzsJvrQbx1MBEfdSQlTIGEc5BkUi5TKJGXv04jDbjEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726684664; c=relaxed/simple;
	bh=59Y6RszWTFcMuqE/2NPQPX1//KWiimp3qye9tUH+TTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f8Q8AzWhogKsuJAHx10rdR7vsNOI1spYL4Is4Nqz2/8pYfCVwW+VPOCQ2LZFxze1738b+gV/WPqICyysVwEcKSH0ur52V67f4PJoce4Sph7Fteg4bDbXIyrCwSo4Az5xgaJA83XtJB4vd3j3wGyJyIKdJkvrXcFDlkamcFM5Kjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c82BXV+Y; arc=fail smtp.client-ip=40.92.23.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxk1nN3RjWbZkGXda3OC6bNhUC+cIqWebBIcBq+BO4ck+GVIOzir0PixY9BSR/sMIy+ZeeWjj5eBdCoWrymsKngOcWOn6H2VBm3SRPuVFi+H0urysOf6R7CrqXmFdFMqrVhG9VxSCY0OO9pmLqqyXCqrVsPeSHd42Ig5/It6IFT0hujA5dOTGo8imE5HBjTUIcYeLviCrVCjbA9zNPiILvOKcIxKyswL+Fd3Ey7TWSfdUnZzjmwkMybqDHPc55l1+abYUIVmIFQYYvH2enrCyYACtzjnWqsUt79gKydy7v8UW2qgFGBiLTa30euelRO3LjXfyu4SpSlWa61TdS5KKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8IubNTKD3ztTpCms2yrsWXZklgrXilik7/1z34agBM=;
 b=vuTU0UZK/hdTmp1+LT3+wcSqY3r+P+3S6iaUxqygne9SyquJ9wAqqwivyPu157tUQej0JFKwVHyJol/MOxbvsrXX5Bgg8RFbxx/x6gtXfx5ykpsrmOi1/Z4Mx6WdwdORJswGftAUkCYw7tQXKBd2MKJQzWER6k5DzjtYOygShCFo44sKwW4nzVeNXQxVwcuKUmVc0Q45EiQWz88X2xeSsBXw1g/rZoaIvJWKy+hKZBR9KFLobdOVFP1UmaTC/PpWEesVKN95oXD3Xiw6GMEv2hRhGKENezoXvCBl7gcnWfORV+A2FcP9RbM5gAPKWPkyav8W/sCQYqcj3YP/XGAfkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8IubNTKD3ztTpCms2yrsWXZklgrXilik7/1z34agBM=;
 b=c82BXV+YF7xOS0NczMel4Fb4KTwloaUDeqrDEdg0KWhNI+UfM1FffUqotZk91t4K2WI/Y/8MhLTKQPdpzUQ7bhCKFTYyzqEIj7+W4YxlKppbL4n60o73a4q89tEL+IyQNuBvIokzoHl21Ziaf06aCm3xrzv8GoAFUU2Egj/DDlR8K7GKnqiE6XXHejKb7eEuOxeBRThYnK6waqtUX5Fm7USJBz2/NQIyg6IEVgO+xLyksj42jEsjShnkrvPOuqTFlXG4NtkuelnsK6+akRJJuDCGoxlkRKmaKAByN4bvCk19uHsJ7pLM5DxuuQZm4KZEeJMcMM6eM86DXGHmOTcqaQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6583.namprd02.prod.outlook.com (2603:10b6:610:ab::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 18:37:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7939.022; Wed, 18 Sep 2024
 18:37:39 +0000
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
Subject: RE: [PATCH v3] x86/hyper-v: Fix hv tsc page based sched_clock for
 hibernation
Thread-Topic: [PATCH v3] x86/hyper-v: Fix hv tsc page based sched_clock for
 hibernation
Thread-Index: AQHbCMP6lCJy5rh89UCqz/l6Egf7g7Jd4DGA
Date: Wed, 18 Sep 2024 18:37:39 +0000
Message-ID:
 <SN6PR02MB415772CE1B1F9FC03ECD0258D4622@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240917053917.76787-1-namjain@linux.microsoft.com>
In-Reply-To: <20240917053917.76787-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [lBLhl7hIyU7MGr257vX72IeCQmy9HqdY]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6583:EE_
x-ms-office365-filtering-correlation-id: cc9fa7e7-e860-4402-7229-08dcd810f9a4
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|4302099013|440099028|3412199025|102099032|1602099012;
x-microsoft-antispam-message-info:
 x387yC1zPkq27b56e32DApk4R9UFQs/58tVpNiXzNffHp9pv/98AIupQt3jfJMohcbtHWfyej6rjIlriJTSera6N4qNfyStva6BROnrSyPdU4IqtbXdWM/h2iuchUozB5+7GmNscIIMnSisu64kjeFew4LUvsgBSZA65xZdWzNW/Amgh5EUDn+iemRawno0/+kmTr2PoOwDZPORqEYr8cnu4MjWWHCFnNWMsLEV71uHs32pMFE3YBv1pOoJJMdSF+hXrDhous9rdWfWovDo0AylvlvBW+5pm4nqOsox6c9ML7F8GgyvV9+Dzr7p6VPvEFnXT4q71HzSS9fNbjA+nvWCrSfQmsyb1uwDJ7Of6avfCcMWZJxZ3ESUfVFNtxslDoNsUpJw3lUxL5JVSkRO3ER5mnSP2PSLlKCXUPAgmjUMoEConHPVO5P3cLFQ7bHds148mKbqhlMhzEYU4Kv/YDIDN+v1teu5nl5EoKq4fuC70kOcBKkxyzATqo16/w+1wcAl1MfYuNAIMVGlIMXla3nZ14ygGWa5VNAX+EtDSIGPTmLsNqDQQq2bTm8no4xq0rla8SYYYwEA2TeQ/YqmOvDzHWTL2/3G007gxJBX3ryuqk1tl4kxxql1XVrCKft21kV5q9iUXZMFe7JN/wdRUOskAwNkA/AC9x5ouy/qVs6vsFayZrO0S4abj+TYJuIBEriE4UlOxnJsYrDBOD09X9ftecNxuHvh0ee6FW16xomrfWwwWGhlcq+pwcZJIP079+QGzy0E0TNec7wuZrS5LR9fJMt9pnTpnfa8XmRrat+puCUXs1TwCgh/MdZkbOJlmftrnHqYTHJHblYEtfH5V5HV+7YJt1ZiduAZKzeSraf4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uX9/uERphuVwyeWDRg/zvL1nbDc0eytml1GVwqHEPOA0qZnufFuRKRfySEpe?=
 =?us-ascii?Q?7nTii0B214ajMghzO5u4JODA3ADyPIGP2PVM94OalshqNEYMiiNw9/TJKKxi?=
 =?us-ascii?Q?NbAwphHCi8u+f0ZMix705OMUwlmn/qGVs+7C+IpfBMTaJmIzh7pRYaktOM2b?=
 =?us-ascii?Q?wtQbofKC5SZwG5L8eMk0D4m0/Ks05NP+DNtK1HMjhYd/9TbA5lIRPENWxCUP?=
 =?us-ascii?Q?PYvTnawh5ccwSLYVmkyN3yIChDQiCCVSX+uc/HINGRyJnYUZ41+QiNGNSdhe?=
 =?us-ascii?Q?v2k7erjipywQ7ewf15ui8Imdzy9Sxxe2tAucPSW9sbMGYYbb1lX2z2c3sLrn?=
 =?us-ascii?Q?GEX/sRHDW1KuRSGhrU+mbjY5CP0qJ9L+MoxEc/Un5XSRxhE4P3Cz0DScjf9B?=
 =?us-ascii?Q?0EDIBjjApIDoEpVXZr1MUMcBtvFwft17D1crIdGRNMXqCVI5kHkIPlkAg0ZB?=
 =?us-ascii?Q?wMZCflGVqrIJod1r+I0AX9WhkTiAlVo8VDBeG8W3Q+84TI/QuTZs0LfMc+R1?=
 =?us-ascii?Q?ciZUrwE+QDk25hZg4mY5VYEHf6yKBIEPv8hROO+P5CE9+CRmhBK7ZNe+3geG?=
 =?us-ascii?Q?g3pLwruWonXcWREiK+dpZISEMg9ZsfZDk7WYLBzCO2b1IlI7ayTqHUoHf6JY?=
 =?us-ascii?Q?zQwdWn7laDoHQLzR/6k0EIu5blN81mM4xY+pYCnqfco1FZKX2Q3X9XwU2JqC?=
 =?us-ascii?Q?1rcXPA+sFGidSCxl0pipp+eNziHCZTlCOhLVSvdBFqGRZPSvkJclYx15MKVw?=
 =?us-ascii?Q?rTpnXD+okkN0+zVIVTcOI3JOQUHCQLYTIA2jIvFTS7O6o7EuBegwUBaIs4K5?=
 =?us-ascii?Q?EwLMWo+wHO8+4J+0b3tw1ux2ABWBoAtm1JvLKSUQKleZd+sXmdnkL3XUWuXs?=
 =?us-ascii?Q?Ik/VWkEtgXPg7wsQ4/z+Rkt87Z641ahRGx825cp7F1LckJD+Abi3bpFli7TZ?=
 =?us-ascii?Q?5i2mrRd5TkmCXGoukvyaldEcswbgCBhExwaObNnX0SaXFuMX8Q6rgirnprEG?=
 =?us-ascii?Q?6BJHkRFjDGsofuomQ23RlwhH+kV+zL6VE1e6SWptcGds7Au7V20MeGRmAIaj?=
 =?us-ascii?Q?ypmOz/ugi+4qzvP70ES8eHsejIm3R1KGWnSGslMlCHfG06dc4VyYYC/SHSbZ?=
 =?us-ascii?Q?OA+ANoLuU/k3GPVbP2Uk7c0yNZqAijo+Q3AGMTurZCpoqdnvai0bNLH82B4F?=
 =?us-ascii?Q?JHNYA7rh6tsbhmJL77I6FDEW68bncy3SIONjw96d6q+E7okehOsQdXiqe+M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9fa7e7-e860-4402-7229-08dcd810f9a4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 18:37:39.8611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6583

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, September 16, =
2024 10:39 PM
>=20
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
>=20
> Fix the issue by saving the Hyper-V clock counter just before the
> suspend, and using it to correct the hv_sched_clock_offset in
> resume. This makes hv tsc page based sched_clock continuous and ensures
> that post resume, it starts from where it left off during suspend.
> Override x86_platform.save_sched_clock_state and
> x86_platform.restore_sched_clock_state routines to correct this as soon
> as possible.
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
> Changes from v2:
> https://lore.kernel.org/all/20240911045632.3757-1-namjain@linux.microsoft=
.com/
> Addressed Michael's comments:
> * Changed commit msg to include information on making timestamps
>   continuous
> * Changed subject to reflect the new file being changed
> * Changed variable name for saving offset/counters
> * Moved comment on new function introduced from header file to function
>   definition.
> * Removed the equations in comments
> * Rebased to latest linux-next tip
>=20
> Changes from v1:
> https://lore.kernel.org/all/20240909053923.8512-1-namjain@linux.microsoft=
.com/=20
> * Reorganized code as per Michael's comment, and moved the logic to x86
> specific files, to keep hyperv_timer.c arch independent.
>=20
> ---
>  arch/x86/kernel/cpu/mshyperv.c     | 58 ++++++++++++++++++++++++++++++
>  drivers/clocksource/hyperv_timer.c | 14 +++++++-
>  include/clocksource/hyperv_timer.h |  2 ++
>  3 files changed, 73 insertions(+), 1 deletion(-)

This all looks good to me now. Thanks for indulging all my comments. :-)

One minor nit: The "Subject:" prefix should not have a dash in "hyper-v".
The goal is to be consistent in the prefixes used for a particular file ins=
tead
of wandering all over the place. If you check the commit history for
arch/x86/kernel/cpu/mshyperv.c, you'll see that it is "x86/hyperv", not
"x86/hyperv-v".

This is super picky, so don't respin just for this. The maintainer can
probably fix it when accepting the patch if there are no other changes.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index ead967479fa6..e8e25d6e64cd 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -224,6 +224,63 @@ static void hv_machine_crash_shutdown(struct pt_regs
> *regs)
>  	hyperv_cleanup();
>  }
>  #endif /* CONFIG_CRASH_DUMP */
> +
> +static u64 hv_ref_counter_at_suspend;
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
> +	hv_ref_counter_at_suspend =3D hv_read_reference_counter();
> +}
> +
> +static void restore_hv_clock_tsc_state(void)
> +{
> +	/*
> +	 * Adjust the offsets used by hv tsc clocksource to
> +	 * account for the time spent before hibernation.
> +	 * adjusted value =3D reference counter (time) at suspend
> +	 *                - reference counter (time) now.
> +	 */
> +	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference=
_counter());
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
> @@ -590,6 +647,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
> +	x86_setup_ops_for_tsc_pg_clock();
>  	hv_vtl_init_platform();
>  #endif
>  	/*
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index 99177835cade..b39dee7b93af 100644
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
> @@ -470,6 +471,17 @@ static void resume_hv_clock_tsc(struct clocksource *=
arg)
>  	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
> +/*
> + * Called during resume from hibernation, from overridden
> + * x86_platform.restore_sched_clock_state routine. This is to adjust off=
sets
> + * used to calculate time for hv tsc page based sched_clock, to account =
for
> + * time spent before hibernation.
> + */
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
> index 6cdc873ac907..aa5233b1eba9 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -38,6 +38,8 @@ extern void hv_remap_tsc_clocksource(void);
>  extern unsigned long hv_get_tsc_pfn(void);
>  extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>=20
> +extern void hv_adj_sched_clock_offset(u64 offset);
> +
>  static __always_inline bool
>  hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>  		     u64 *cur_tsc, u64 *time)
>=20
> base-commit: a430d95c5efa2b545d26a094eb5f624e36732af0
> --
> 2.34.1


