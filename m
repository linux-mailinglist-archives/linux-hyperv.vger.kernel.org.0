Return-Path: <linux-hyperv+bounces-2991-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A710F971E69
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 17:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F071F258F4
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFF45589C;
	Mon,  9 Sep 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gS0wqA9S"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010004.outbound.protection.outlook.com [52.103.12.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362F1CF9A;
	Mon,  9 Sep 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896799; cv=fail; b=MQz4EsJeZD0A5vqKLhmddT1qpj2Bc/cHyFcgL9f2R8NjY/AAVRzqSVQPH7ub6GwAMZtBq97vJU114LIPQs1/D08Ao7vEbzpAyIo1/x0VcRgVUnIT2wuJiYdpjf0niCCwpwzFWLBNNBveXu4fb3sXlhpRw1GiH+mHGG5QuM93owI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896799; c=relaxed/simple;
	bh=jK4elwT68w1MjKMLyKRkzKF6BnU22T7LcIJ9XRzKOew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bpxVG4yr86cHisMzB81UqJX9jzhavcOmlNLXYzPW6wsCb2lZgEuGk01nR1fu1AoAjutxjyGpBWM5X8ny++wTXqxUwFyn0dGWkL+vq5SF1vb7fKe2nr23hbTZQCXjcaGYpvG+Zn+sHkBPGxN8trd8H8UUsRY40sxTDvz8xe5htqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gS0wqA9S; arc=fail smtp.client-ip=52.103.12.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaFbKFui1EPfdx81nI9hPfj40SjzSFN/ABN0JQsS02uRQ+H+/MsloMmbvG9dZbGok4oZb8w5gsj+mZCw7sxSO4holemoY+3TxisdYqcBa2WnZ7DEymCkxnJVM36ZxMdMOFaPtm7erCoE+NIh5ENXtwXd83tUKqdbH/M0GfDpmgNjxEZLGwNd7DLuUGEHfmcJrnLSfh1AGc0r5YleDgx9cP9vH1uc2KWG1SeqQ8ieGgB8SKTUJYDol+R89cgolfsshCkfoK6Ic788k4E5tZAeJ1DPG5o9NzLKIpqdDfiNLO8+3rH02C0ELtS6Nq/08u5PzKfTEl9gwQfornMRKVjlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZFzwPFEkatSGlx3+fVwAT3sqvsjQjed3mNhmnSSmec=;
 b=uoVM4+VGiMI1m6u7BLYP4aDvzkdqOcIHjVlt4ezaiQCkda0hG4Msouydw26YX589QPd14TWAuK33r+poiQpxA0HE0xK3PWGtUjoluBj4e4qEtj+uf+uDVNGPstyFSNCvvmCNoZcThGVVqoOAyIe1tpH/Pi4GFtz/p6l6UAqyfmv2/xjo5ugoNq42C0X45jlxo38QOLSLt+4W8xsqphlgRULyzFb3DzN5y4+IkLZcjQtnyz31AUrvVhcaiZ7isdZ3Q9gKoprpiGZU+1XfRgyar5NRnFQrBp6KXjxNAfqYHsD52Se12kRpJwHKo8051Ts/Yk6rlC/OtIQRWRX58CsBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZFzwPFEkatSGlx3+fVwAT3sqvsjQjed3mNhmnSSmec=;
 b=gS0wqA9S3y+gUyDHLP0U2vXbEnDswBWJqcD3pb96aBj+3TV3ZuEy24JVXwcyCzOfO2GfFgjwlxdnUDnqZ5NK27/Omli0tTVCGue2qygmSmMh+yr0zWr6MedqP+7Srwf2rqRRq2Zvj9eAHwA/D+yglEWVH9Oo1i+lvJOvwFr0zmLiSZW1SSLv9Wxj+qQHqEa/JA7ERMTsF7PjCWrSSFsYBqyPPd6sv7L8Xc+1YG3ihYjvInyQAwd4SuQz7gz2f2izzagUi2jIj3aaa4topKqQ8YUV//zBHECDNUjd9N4CF8jrQ4G+INQfZ7g7T85q44aDqVBJMmygGooU8mi7w2IBag==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9670.namprd02.prod.outlook.com (2603:10b6:303:23d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 15:46:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 15:46:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] clocksource: hyper-v: Fix hv tsc page based sched_clock
 for hibernation
Thread-Topic: [PATCH] clocksource: hyper-v: Fix hv tsc page based sched_clock
 for hibernation
Thread-Index: AQHbAnqo39EVd+BnZEugnlU7otqTyLJPlyvw
Date: Mon, 9 Sep 2024 15:46:33 +0000
Message-ID:
 <SN6PR02MB4157141DD58FD6EAE96C7CABD4992@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240909053923.8512-1-namjain@linux.microsoft.com>
In-Reply-To: <20240909053923.8512-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [4/eeJg6ZGzAHOAMAr6O6kZopZ988nJCy]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9670:EE_
x-ms-office365-filtering-correlation-id: 7250ffc5-cb3f-4853-328c-08dcd0e694d7
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|15080799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 WiyX1CUygYpyPrWeogeXFFftZRZCy4b7kBAh8GBeMwQ1/y6bAjSfzDduD2tsc96lOKYPl6N+liQ/HCPy/Z7IDLkKUX3LDqXLnGFcOacdm7X/H2YCcigoHP05R4SsM7QghImqw0/+YUogiGpnnaLZdq2+usjez6zs8nCHUj8AJC20OOsdcn5ZcJEB+JYzvAHpARPH4NzhHpzs5nYLmaxQwzHXwzN/NKmnJ74IpWiC4+6UeDNXBiq4tkKE/rTwpBSNN3OM/A4UrXygDnaR+sVNwX6FyU5VYy1YVHx6E8krrQ/yLt5c10OAxZ81N5TtaB2n6ZJT2Hba0cla+B7isv6HncT5Ms8YXjae4AJB/V0F8kZwQVvw+NX7LmQGgu49qpuggmr9Zf1vTA64o8ZmMSnqNytyFD+4cTwgfcMdfXIH1/ntEeXlw9oMsakM/OkXcX9fzv1mTf2uBzpYNp2jYtMdUC+GqNrMF2wY5AXfBzjYGKmvkv1DTCDodm7lOJNqH8wMyLk9ryBJAIDuhcAEiAZdPwuOHbJUHPaiXQC03FOufmRQwHEFdk6juc4HLWfC6usq0Xv916CUcP+3k5mjXrIL2310/V+o21q5Qb6sgszRApextRw+zANVWW+HlwuBjhqmEIpVcjKOhj0svyVfScbSU1cNafxh5kCYp9m3svXEImpBIB7yspkOcXrkrlu0aP5r
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q8W1Y0b8MrZ5g7lZOAK7e3hUk2Meb3QQ1ADHwqKeV/Bo8+J9pPEsSO+qLc7I?=
 =?us-ascii?Q?+kFS8jKT3DbBu1yzwRP8j/FYd2vVBAZwn5r85lser4/95/co9rs/+VWSryAp?=
 =?us-ascii?Q?+7ndzR7M57LgSHty2zHESa5COEoiHj+kP2uIjt+7nUKfA1wnYPzLFB3xk3/x?=
 =?us-ascii?Q?pMlChiKwQDKEhzt9aquivl2n+lmpk3IdPUnWSxPLe5u5TipoQF0cwbMhxCia?=
 =?us-ascii?Q?H+K/c3eTtw/HZ0Cn1fITPTWNnFhffZJDOzis+aU4jYjIdZuDEP228pMyOfNg?=
 =?us-ascii?Q?/xt9U+CcYV6M6Zk82ic0m9tXY9vktBtfJR1+OAPAyQpGIZUvehYM2wJZjEuS?=
 =?us-ascii?Q?Wfyjm2GG5kzeLF+AN/cbLxS8xDkcG6bg+kFpsTDipDhO7ya3lUAjm0WvjzRY?=
 =?us-ascii?Q?9ZqZ9kC+JOswqHe4VDDBezQEB/YP3qpVFfXCTEVafE9/8L/UJt0ko/xfwOot?=
 =?us-ascii?Q?HoHyZcM/lFllA85UbYfWTwvR0wnskQzEMY8RqpnjfVx8DFthKiYTt2JGB6bD?=
 =?us-ascii?Q?edgK9uQVhJfIXAfm8r+iKrr1EI+x+v/1gHcx4+bNnm163mT3gjvMFmeDsAh6?=
 =?us-ascii?Q?wH78hGxsR6HRyWTwqwHiDf9+aGLA3sCOZy32ETt1PIBTl3/Fg1fN/ZCxZyvp?=
 =?us-ascii?Q?1tHqGqfWP9hhMxgMbCwetIfYo5k48Hggw0N+IY2ginOfydy92e5iQUzCsmBk?=
 =?us-ascii?Q?ga05JFK+TQPxWYIWrYnE6o09Iov7DYo3v15SYC2Lvpo5rURbAg+pl+ttskzF?=
 =?us-ascii?Q?iOl8hEl4h/5yV7mQjym2wLvMARsKP9f3D+KlMHZdykGni5pfXYXVIJjmzMxM?=
 =?us-ascii?Q?q0EGvCJQZCLE0GXPInHTyTvuoxtHLBbYWoP1MpBqyzsbgUvS3/kPPti8+dAp?=
 =?us-ascii?Q?rLbgbtwSddWMjemC6aWppo0FFQ8N1oZhsYOjk8sBPBFWVFHKipUMNc47xTAV?=
 =?us-ascii?Q?+QkWr4VS7QWaKvUJK291/ptca5nQWrfa9H0d+U70EoIHt6760X0eTjL3ywgB?=
 =?us-ascii?Q?G3VQY2sR57Ll/4r6waoEgQWLugLbiKnnGqbhWv8YX6gQNGAhMCiP5mSY8JjF?=
 =?us-ascii?Q?n/RNaGsG0HKLZkhSq8SHJCFXNss0e8SRTziP9WzWXTXXt9/c1M97I+MuSF1x?=
 =?us-ascii?Q?1IRPU5y8udjJamxEGxaEzHLMHpsKncsO5GW+WifRqAYdyWg7gp7UjRTN8ylA?=
 =?us-ascii?Q?Tfc9yEMsspO5qksIKpx1OjfTWRo8YRYOwfv8iJ4mqMMAzzpTXykvI9YR4VA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7250ffc5-cb3f-4853-328c-08dcd0e694d7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 15:46:33.7838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9670

From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, September 8, 2=
024 10:39 PM
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
> resume. Override x86_platform.save_sched_clock_state  and
> x86_platform.restore_sched_clock_state so that we don't
> have to touch the common x86 code.
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
>  drivers/clocksource/hyperv_timer.c | 64 +++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index b2a080647e41..7aa44b8aae2e 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -27,7 +27,10 @@
>  #include <asm/mshyperv.h>
>=20
>  static struct clock_event_device __percpu *hv_clock_event;
> -static u64 hv_sched_clock_offset __ro_after_init;
> +
> +/* Can have negative values, after resume from hibernation, so keep them=
 s64 */
> +static s64 hv_sched_clock_offset __read_mostly;
> +static s64 hv_sched_clock_offset_saved;
>=20
>  /*
>   * If false, we're using the old mechanism for stimer0 interrupts
> @@ -51,6 +54,9 @@ static int stimer0_irq =3D -1;
>  static int stimer0_message_sint;
>  static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
>=20
> +static void (*old_save_sched_clock_state)(void);
> +static void (*old_restore_sched_clock_state)(void);
> +
>  /*
>   * Common code for stimer0 interrupts coming via Direct Mode or
>   * as a VMbus message.
> @@ -434,6 +440,39 @@ static u64 noinstr read_hv_sched_clock_tsc(void)
>  		(NSEC_PER_SEC / HV_CLOCK_HZ);
>  }
>=20
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
> +}
> +
> +static void restore_hv_clock_tsc_state(void)
> +{
> +	/*
> +	 * Time passed before suspend =3D hv_sched_clock_offset_saved
> +	 *                            - hv_sched_clock_offset (old)
> +	 *
> +	 * After Hyper-V clock counter resets, hv_sched_clock_offset needs a co=
rrection.
> +	 *
> +	 * New time =3D hv_read_reference_counter() (future) - hv_sched_clock_o=
ffset
> (new)
> +	 * New time =3D Time passed before suspend + hv_read_reference_counter(=
)
> (future)
> +	 *                                       - hv_read_reference_counter() =
(now)
> +	 *
> +	 * Solving the above two equations gives:
> +	 *
> +	 * hv_sched_clock_offset (new) =3D hv_sched_clock_offset (old)
> +	 *                             - hv_sched_clock_offset_saved
> +	 *                             + hv_read_reference_counter() (now))
> +	 */
> +	hv_sched_clock_offset -=3D hv_sched_clock_offset_saved -
> hv_read_reference_counter();
> +}
> +
>  static void suspend_hv_clock_tsc(struct clocksource *arg)
>  {
>  	union hv_reference_tsc_msr tsc_msr;
> @@ -456,6 +495,24 @@ static void resume_hv_clock_tsc(struct clocksource *=
arg)
>  	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
> +/*
> + * Functions to override save_sched_clock_state and restore_sched_clock_=
state
> + * functions of x86_platform. The Hyper-V clock counter is reset during
> + * suspend-resume and the offset used to measure time needs to be
> + * corrected, post resume.
> + */
> +static void hv_save_sched_clock_state(void)
> +{
> +	save_hv_clock_tsc_state();
> +	old_save_sched_clock_state();
> +}
> +
> +static void hv_restore_sched_clock_state(void)
> +{
> +	restore_hv_clock_tsc_state();
> +	old_restore_sched_clock_state();
> +}
> +
>  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>  static int hv_cs_enable(struct clocksource *cs)
>  {
> @@ -539,6 +596,11 @@ static void __init hv_init_tsc_clocksource(void)
>=20
>  	hv_read_reference_counter =3D read_hv_clock_tsc;
>=20
> +	old_save_sched_clock_state =3D x86_platform.save_sched_clock_state;
> +	x86_platform.save_sched_clock_state =3D hv_save_sched_clock_state;
> +	old_restore_sched_clock_state =3D x86_platform.restore_sched_clock_stat=
e;
> +	x86_platform.restore_sched_clock_state =3D hv_restore_sched_clock_state=
;

This Hyper-V clocksource/timer driver has intentionally been kept
instruction set architecture independent.  See the comment at the top
of the source code file. We've also avoided any "#ifdef x86" or similar, th=
ough
it's OK to have #ifdef's on specific clock-related functionality like
GENERIC_SCHED_CLOCK.

The reference to "x86_platform" violates the intended independence. The
code to save-on-suspend and update-on-resume can probably stay in this
module in generic form, but hooking the functions into the x86_platform
function call mechanism should move to x86-specific code.

Michael

> +
>  	/*
>  	 * TSC page mapping works differently in root compared to guest.
>  	 * - In guest partition the guest PFN has to be passed to the
>=20
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> --
> 2.25.1


