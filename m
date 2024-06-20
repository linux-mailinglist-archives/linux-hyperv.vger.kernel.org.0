Return-Path: <linux-hyperv+bounces-2463-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCAD911442
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 23:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41082283C07
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738986EB60;
	Thu, 20 Jun 2024 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aj1IXv9S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2019.outbound.protection.outlook.com [40.92.42.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893FA1C680;
	Thu, 20 Jun 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918337; cv=fail; b=Zh/jzupvveAM2ishu2hVeDZ/lli5MRmARhoXiJP8lr4PkSvuQ1U5XyyHsj7k42Knn/nyrs3SySSdBKHNCPP0I+pbGvD98/fTqPvp8BH4Qx0/M9wWYFFilMM5wj3RhXn8TllTQnI30/dX87QCwvsfq4ZjeRwV8SW5TsSgF76u0SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918337; c=relaxed/simple;
	bh=RG0EFKyBkQFjcSwe9tJrPCjAg/4g2iedLSOx7mMkIz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hvvBP11qh8d6hJ+e/p9R+M9siappJUFxIlAJZeudVMxPUiRY9Sd/tKy1QDTIbTCLnCEE4t3swsCIVSjcMfPb52Xzi4VpnSuh/+ce/iyUlUdr49HVBxkfmCaxCQCP/IAHjFo5GLctKcFAJgx07WmDTwIrUZ+UFTdxO3FlwEE3+U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aj1IXv9S; arc=fail smtp.client-ip=40.92.42.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbRCzca0UWoLkf6xhUIW0yajx09Jie3osT5Gm+N0VES1gcvpl8UDm43xqMx60kRc7O7eZMeZKxCTLQ2h7y6q+ZZQ1cRfN/JyUfvOaMdLHz4CfL67ljpXeibYVxY/ZoMeYOTzuY8KhKZN8t1uYoX2RbRH+xDN3Nah/uquLxkdbFPeB+Nk9FTj6oyCNXRKSKFJBfvu46Pg57cEjfirCGY7X8Hn4yMEKHLbkpGIuSI/k5oeIcZsM9pi0NgnzUM9FM4WsmL0qlIybzb4Xuy42xBDalJ3aa792Z10iIUg62/m4vOyQfmuDrz2JAzie99PY6WiLQqw4QyN4kr4IAQISwyWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSy9QMBNQP/U+R6aui3seFdCy+AghuNQtAA7JGI4P44=;
 b=hdCABA1HoXNWpyS0hd6YmN/aMlP4mTfVD9ERwaIzYTr7qN2NBgh7ciKrOdjQblcEMhJeWlXtGlDF8GiuQgWitsJkpoRLRMyLqPPjc1f1iwUgzU1LRZev3lba1w2erLC89QdMH6gKy3xacH5YLvketlkDF1b4zqqfs3LIekRZzjkBNwHNJPe56pHSnU4iCBLyGv/HxVyfPyLkdpXBuyLLnbqP3eR2j8mAzEmMrVZNauofGPRFZRCBlIbNXvMNhXgerUdEduXd5PY6vd77yGAYepg+OA9uK6oddnP8/mzlgARyi46aQZjN82VZ1AjwG3gD/7SLDoBMklkRriuPeFUVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSy9QMBNQP/U+R6aui3seFdCy+AghuNQtAA7JGI4P44=;
 b=aj1IXv9SqOHZZ8opQhhFc1azXcrbjNt3g5PNwBdLgDP8AWFc6vnjhFhemJ9VN5MBW4tIUfg6jEivDDLtGk2uID8RyThA/z8pKHaTirxrgmax12JmIVr2az8T+2qzFE53WgVWJqYsaCo2W9vpv7Q9kxX+/yB253ibBDvlQbYfE6iq5gHbYo/oNyAT376ieXOYU+KoyXqhpS0r55zhedH9JKor7d3340SPKwksXskZRFyAxzJEh4aSWDaAyRVBeTak/zDZOzeNwOabBQCCB0pmm8jgbiLA+7Z6t3M6Mih8lGJxduoud9JCDOwEYXhimxzr4GgdO83l/IDBK0XSf37S4A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10598.namprd02.prod.outlook.com (2603:10b6:806:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 21:18:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 21:18:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM without
 paravisor
Thread-Topic: [PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM
 without paravisor
Thread-Index: AQHawd9ON2/Wh7TteU6ShycRrBy/N7HRJy7w
Date: Thu, 20 Jun 2024 21:18:52 +0000
Message-ID:
 <SN6PR02MB4157C155D258F9DE76650E3FD4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240619002504.3652-1-decui@microsoft.com>
In-Reply-To: <20240619002504.3652-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [aN4dhZWAuLQP+BictPgnadaTKELhVCdu]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10598:EE_
x-ms-office365-filtering-correlation-id: 8df7bf81-d5b0-490c-f297-08dc916e95e5
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|3412199022|102099029|440099025;
x-microsoft-antispam-message-info:
 8eW3tPHp9vN1uOCCBRhjm2zqy+5cB4XlEuuHkItEYJCECO7wj3y+Q+CWkOBd1+AuT54MLErHEAT1zA63W3IlNSf+tAvlX1eD6b+zqfZuTIlzQ1OHPnT+vTBgol9Lwxa9Cdl4l8PM8huOTw52KMp8jKS/bW7XIsrCuzR4uiU80bp+Q4bG1SQfx/Ui/Z5CcAZc1SG7M42zgFzwixp4mI+u9lRwE+jSowwAvxR8j7H7q9kH2qg6XZ052DWZesslx+gglNqH12Wi8FHMwgfwm0gI0cWtKQ4PQdEX3PSXEyhHpt61BD8+3FDL+Lolb5f92bKAIfi5wqQ1EUlKbFGckuVYGe//d0MD7PfMNBzKDby1lBUbkY6UQkDcNi16mUw4Gfa1ckfDM3BhWOPDpacZc2BowyNg6SmQW+cvrgN54y//gdYjT6sTNU3q3QtPVHUxLvstz+mfkM4gjV9pioTahizA+ZYbQO/yMOyxCgycxMvNtA2ajSFpGhdfFLxCwcGYSbWVWZmToLZVc3VlDrfar8XWdc2Hgf1qY/DpByIgfMOXiwCWpOs9oy53JC3OxT/xXh0P
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8SimNfLz23u+YGM387F/8YPMRI7KhibASm8YKvL49CijKVcmRhTiiKMkirV3?=
 =?us-ascii?Q?+k5MXE9WV4b+Enz89zMeaMlfmtHY990J2F/Szn1XiPJcy6uJazAlHoBXtvXO?=
 =?us-ascii?Q?Xv6vDXvtEX1kZTp4MbNrKlEachfPJZA2r9P2BmpIX9guyVeSMY8SkoSB+P1X?=
 =?us-ascii?Q?xUTLjlTe4UL08kX0xnfNW3jmhNHCU92Es7WeDFPwNtdDVbDJmWzNlcwR1a9d?=
 =?us-ascii?Q?o00wCel6nC+TsgeYe9DjD8ignXrr+RQ48O1L7TN/7LO1WhQPqUJDOEa2wxtM?=
 =?us-ascii?Q?0bZxypxnHXpwr9RfRfcGXlmxWBTEfXbC1wHrXdYK4putb/DT7AX9GXA/fbX3?=
 =?us-ascii?Q?+GgUxzCdLZM33WOtJ6Elzjv1MVhB7PetG04vID8hKlgTsEIMicxLa0EhN0Ur?=
 =?us-ascii?Q?TWrikAea818LGXTMEpvMakOYd5XoJmHaI/U43em69aJyke5h9a98tFNYQVwE?=
 =?us-ascii?Q?m156eiLa3nOlFVKDw/vK9WhnVNRGVyrMC7SFRBa19dJEfr3ZrcLncPaEfOZb?=
 =?us-ascii?Q?wIMMdCO6PZbPNN0OcS+/+wKNr1cpUx72yj555EG1A9TAiS68ESe0FXrDGj+2?=
 =?us-ascii?Q?57l7sjTDGEM8uxgvefGnMTaxYgqQlXG4ki2NuNzQK2lOMM22gdMd53xVzlg6?=
 =?us-ascii?Q?B4xvm05mSHINLOj/yiwyZZFdJ9FOa5x+pti2E7rh7JH3tQFKpHQIS7MViemy?=
 =?us-ascii?Q?iKpGbinDi5y3r0zn0r2v4RMsPiYJ0MTPgVep+x6IBk4F0mgYFodH6tDZk1LP?=
 =?us-ascii?Q?TTBsY0vFobHATQRwbeLD8DoH3dMt8ml/kOaYtDQeMDn2xcRbEdG/TYlYJ8Cl?=
 =?us-ascii?Q?3YM9+8kX2K47VpCNpv7jOx/5aN5JNoiv5EMzobAtotnGxsQJAGsKPrDh9FRo?=
 =?us-ascii?Q?Ohh19ZimH30sF5oqzFcMdt7YlhR7w0QQSFGsvN5PTDAWswBzo09iJIA/7neP?=
 =?us-ascii?Q?tGxsy6853rkRhXGhSfkhvn2Sdis82oP15fY8I0k6Q1JBswMPlqf7ufo69jEs?=
 =?us-ascii?Q?ihj2Qyp3Oj+iaLH+I11NW7EF/+eQOZ3cdwI4XloQJBvjca7GHODN+TP5TRyw?=
 =?us-ascii?Q?iVpK3DJBa95+/fZYNLW+AvFZKdS2r8bJ/9/iKsPxkSQoncU1046BzE0NqQ7B?=
 =?us-ascii?Q?GPcKAT9GZW4yO34PrRzAP8bAfiPHNPZJqaaxD3etKikG5MRdMx9fBmnk73Es?=
 =?us-ascii?Q?EX98qqZBsg1zspRCSADp62S0Xi5zstAu3LTU302XqxKm4sgfBbami7Ve55Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df7bf81-d5b0-490c-f297-08dc916e95e5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 21:18:52.7055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10598

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, June 18, 2024 5:25 PM
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
> the default timer in such a VM. This change should cause no perceivable
> performance difference.
>=20
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c     |  6 +++++-
>  drivers/clocksource/hyperv_timer.c | 16 +++++++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e0fd57a8ba840..745af47ca0459 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -449,9 +449,13 @@ static void __init ms_hyperv_init_platform(void)
>  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
>=20
>  			if (!ms_hyperv.paravisor_present) {
> -				/* To be supported: more work is required.  */
> +				/* Use Invariant TSC as a better clocksource. */

I got confused by this comment, partly because I've forgotten the
meaning of the ms_hyperv.feature flags. :-( Perhaps you could be
more explicit in the comment and say "Mark the Hyper-V TSC page
feature as disabled in a TDX VM so that the Invariant TSC, which is
a better clocksource anyway, is used instead."

>  				ms_hyperv.features &=3D ~HV_MSR_REFERENCE_TSC_AVAILABLE;
>=20
> +				/* Use the Ref Counter in case Invariant TSC is unavailable. */
> +				if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> +					pr_warn("Hyper-V: Invariant TSC is unavailable\n");

The above comment was even more confusing, because the code block
doesn't do anything except print a message. The code doesn't force
the use of the Ref Counter. I'd suggest something like: "The Invariant
TSC is expected to be available, but if not, print a warning message.
The slower Hyper-V MSR-based Ref Counter should end up being
the clocksource."

Michael

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
>=20


