Return-Path: <linux-hyperv+bounces-2677-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCA9460B6
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 17:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51207282BB0
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B365175D4B;
	Fri,  2 Aug 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pK07G6RM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2099.outbound.protection.outlook.com [40.92.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD36175D20;
	Fri,  2 Aug 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613455; cv=fail; b=H/1RBpjUPv9/dm47bYAcGRpBEjP2Y4rI28YXDGMo8G+472ylLHbEzDbFIcf+EriedjXWf++i6UX9QzA8Mn+ahnkiNF2b8hFuJJxrM83ow/eSUp9lJePUE3fj5XvP+Tqvz53GarVaVLwi8I8fuu50ubRwCqXIGg8/+ek3O3Gxvv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613455; c=relaxed/simple;
	bh=j2Md8h7bbOJjDAQ/XB+Q7/RNoZ+aROH3QaFHHdAXoNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvX3Fjt2DqzK4ZpEyjGINWMDs3GQFw1SLRqG08gHHy0TQd+YiR99wsjKINJS5isQW2lj3I0RbVCrHzYjkJECj5LvCZlrEX4mHFIBegdw35A81uKpnouaFyXqIn7JKRmx3F2ykrC9xj99DG2cyuLG17MFTWSp0nCrb6pTA9hlVnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pK07G6RM; arc=fail smtp.client-ip=40.92.22.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUqz5hx+ee4O7Au+o2Yq7X/SY1sJwTlk9radIEak5ye8pcKFd3OpAdnd8LJwVTRrnMASIIeo8qEwhTAk9d82jL+OMRvKPTd4MjiQA1OiEcrefHrReFFeHipCxs5RSMWBoaS5l1Kl9lvGfFu/rOBwU+MnPLSn9TsQR/mHcgMh6f8mehFXpYXHiy8Nf536Amc6YAvXw8dlIEU97rSebNf6qIkNl0BtNN27SHDevaNhGfaOFry4sdZrPakXH6BO3SPSs5+3OJJjs3olgWST4zc+i8VcEAGj2xM+h4eMO/A0K8N1kCY678xvxoI+tLDps/FhrG9WKh7bL3yTuAS44lsHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9LtmVXz7F1oPXN9h2WiHMd2bQQzLP34Nv9x5nUbOks=;
 b=M8d0dxZHcH6h/WbwcufZxpsZHuwW7rsM0jKhM8bJ5Ku+DAD8cfqom+kracp/6cq1Vcy0PAgj4GIezSXiCIk3KQWaiyvvTHOwve7RVOBSp8qR+HFT1KtLNy4LID38XEQv92ivgRM/8B/MGmg+c7fIG7UOlfjmnnLJEm7+OO+g6kkvZ7x84o6Dn+ZceJT74E7PhDT0ORkNLWy0czAPTLFbohwGj5r2mbQJ57nlGPl9tm3f9ob/AJrtySNKENSrHxn8KECnFWXdtzA4wafLNn6t05LzmnPNlzHhErZSMnb3Z9Dy9cGAgJnogp10W5JpdalaQZ17xHlwGtap6P27BzlC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9LtmVXz7F1oPXN9h2WiHMd2bQQzLP34Nv9x5nUbOks=;
 b=pK07G6RMma2QOMZ7Rax835OsyAqwLC2W2E0Vle1IyX71WFFEbWjIgOAKfJ+5IQQTyoueLOC7pQYt1E0U0ZEYb9lPnnKx8epKGjbtSsOiy/QLmfUaC36T8+hkFioBNaRTjeUFBLoAL1YE1/LGCDA8JsM5ElQKqq/U3fqBmzqcYTZ+qKLmWvMChpPIUw1AtI/sGOLq/FFuACHHj0FhgTxQgOYDQTknfNGUZGm0zEshGPgz0ldvei2ddiEtVs5DzYvYr4SxRsCFUbJkWrRcs8WDDOfhp8FET+L9An9flS52SQsF1quGjwiuyYPZpuTdxRT/UNhYXXLNwLMUKY5nVMpKxg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9022.namprd02.prod.outlook.com (2603:10b6:8:c6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Fri, 2 Aug 2024 15:44:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 15:44:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: David Woodhouse <dwmw2@infradead.org>, "tglx@linuxtronix.de"
	<tglx@linuxtronix.de>, "x86@kernel.org" <x86@kernel.org>
CC: "lirongqing@baidu.com" <lirongqing@baidu.com>, "seanjc@google.com"
	<seanjc@google.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>
Subject: RE: [PATCH 1/2] i8253: Disable PIT timer 0 when not in use
Thread-Topic: [PATCH 1/2] i8253: Disable PIT timer 0 when not in use
Thread-Index: AQHa5OO/mm8Sev7m2k2ajrwKMJYE+LIUGLfg
Date: Fri, 2 Aug 2024 15:44:10 +0000
Message-ID:
 <SN6PR02MB41576EAA0B95887BF9777645D4B32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240802135555.564941-1-dwmw2@infradead.org>
In-Reply-To: <20240802135555.564941-1-dwmw2@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [voVXgGxQbn3jRBGiHFlFMnuOKuNRS2h6]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9022:EE_
x-ms-office365-filtering-correlation-id: 419dd6c0-9d0e-496e-5da2-08dcb309f3f3
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 75tp0fbo1l7+QSRHuklfl/kgArnKAatkZ+WxfM4RvkjjNcCnOzuJdPmh6vuYppagHrgWyv5yC+ofPNwbnvjoxugST8yte6rH4rcMs1ob6Xbdw0IjNlKuWDefgJemr5q3U9K6uLw3DY7TzhGO26tGXpkfIdfhhPouyBshqnyjJOQ7DpzQdmL7TYoQuHc4Owa2p56tRrdqQwFvk6pc13RlvKYbEWON1ChWPqN0sXXMPgHpZQL9MhULtrXqKnrS+YH/5q0H65GLE/MC5lyPeHY6vnDoErMWeKtvcDWGynNdHpQpXArregce0o1ixYZjdLLemc1HO8yoSTUPSuDuCBD24f0nMOt2sgCeA9bih/NrE9ifNS2eZoRC3QySF5ikmYJylHE9h0LhM3IkCFNGd8K9YSE/JdVWuf8q3Vor3og5f4E33z3fH1UL76zviO0T2oo/iRsjuFLjC/V1PvRlybzYXJbsi88qot/R99xe2JYzsLxxNNKhE1VrxoKj8aZvnwzu1ldPa6ffTDv6doSB+VE7/qPOo2ri18/GScxY9Q3/Jk7ojkbBIPMcKN/S0jTfhNO6vKAXEC5EfGFJvAtwTvAxlcKn0kscwUCrB09SRWhbvu5/l/LEioPmWxeXcJxHx/IV4a6QaCIa8cP0+tjd5p3Bpg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TOrxxWICp5z3Xo0zgGNcKJeybsucoOE+BG3awyMsvl7S8Fl2DpM74Ek4gLD6?=
 =?us-ascii?Q?gpPO++RilJr8XrLy/p1CRfBRs+cc80XJqMW3bdb/B2LkbNLf1H0BRfICenl9?=
 =?us-ascii?Q?QKtRCS70/kElFmGwMGrdVdYs8jS8uN74O2lTMDhjmSNEFJPz9Rk4E01F/Fp6?=
 =?us-ascii?Q?UL8XD3VK/mHx4qQUY+52spxTYSPsBARdfWd+9ELYmVCc6w2nYZ4oZ5UVDEyR?=
 =?us-ascii?Q?DsBJx5MwIy3qa2u+SW3DISIS45RzS3VIy5E5DWI72zwilIZUGL4MRCZKFlMi?=
 =?us-ascii?Q?7C6cAsaRjuvKd7X0sAwaVsC7+BZQ8XCqLh4/K/9UvQHNZaAHZHyzEoS0Jl3B?=
 =?us-ascii?Q?uZvlLwp5gcGZKuMGV3jP7gvV6tg6zPlytmPlDM9xTJEHONpcOywlAfl3J1BH?=
 =?us-ascii?Q?K9RJWgIvq8jTUV62Rs7hg7DU65jq3l+kd/lmHA4y9oA+dk6z9U8qK2yGfDSS?=
 =?us-ascii?Q?j5itYDSL3kQM3m/DsN3qZumMEiB6ByjyuAwV98xnrjOuxnZpZ5WCDOJmoWEA?=
 =?us-ascii?Q?c3mDjUDhdE4zIPU9erD8xAz/9+M2HqwpHHRDzdhARCqy30H+ab+0kXJNCcj2?=
 =?us-ascii?Q?pNiR0dvsQdJ/YM8048Sib5jdGWIMNIQLeT9RTMC4F6GUGvFHeiq79+tsANPV?=
 =?us-ascii?Q?oUP0wBfW8tctP8AieXULBFeA2JpWzmPDvJm2+OQGVyrPwB0g3GoZoEQdVN5H?=
 =?us-ascii?Q?86+cspNNpFqeIkkg9wbCNW+kERY1OctE9+DhlJI/5m7ed2gupwN1fvNeS72+?=
 =?us-ascii?Q?3Lr0lAQO8WrCA5FrChGS5RLpVox16jnyzyZ5Fa11XZEUO3pgdt/0eICFx6rT?=
 =?us-ascii?Q?8Do3+JPKk2Mi8DS12cYSjPhp0JAMkBYoAHglqzitHqNU7LdImXV7jpLgZt5q?=
 =?us-ascii?Q?8inDQiwXFWvM22zgmvIAejuESE6PoR4mlYaR+3Nz5nKhoDRn/DmUF57bURzt?=
 =?us-ascii?Q?WIVEm+o3RM4/pBWjqhgSwceeTxClDKM11GnCqyAQUYpndewPHN/IBdLYXG0U?=
 =?us-ascii?Q?LqcvWRkrG1gXW0Pj48mf4WYT10KkDYo/hruG7FCaf1ulK1I70d3wwy++GEeF?=
 =?us-ascii?Q?xX/3JUCn0B0vg7rqnNWx/ULkrtONQRpgdVpZtsg+1Go58EDZOQ7bMZGTBCk5?=
 =?us-ascii?Q?XmbYtiHgrcKydFxreRtccqExQV/60M/8LzHqVyMMyGuPqv32WgUpRrHyC67b?=
 =?us-ascii?Q?MhHu/N8BEzJmlB3+5PMxZf+ZKL3hsBcKltP9M62vLUQ1Xq1I17krS4rXUfc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 419dd6c0-9d0e-496e-5da2-08dcb309f3f3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 15:44:10.8034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9022

From: David Woodhouse <dwmw2@infradead.org> Sent: Friday, August 2, 2024 6:=
56 AM
>=20
> Leaving the PIT interrupt running can cause noticeable steal time for
> virtual guests. The VMM generally has a timer which toggles the IRQ input
> to the PIC and I/O APIC, which takes CPU time away from the guest. Even
> on real hardware, running the counter may use power needlessly (albeit
> not much).
>=20
> Make sure it's turned off if it isn't going to be used.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/i8253.c     | 11 +++++++++--
>  drivers/clocksource/i8253.c | 13 +++++++++----
>  include/linux/i8253.h       |  1 +
>  3 files changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
> index 2b7999a1a50a..80e262bb627f 100644
> --- a/arch/x86/kernel/i8253.c
> +++ b/arch/x86/kernel/i8253.c
> @@ -8,6 +8,7 @@
>  #include <linux/timex.h>
>  #include <linux/i8253.h>
>=20
> +#include <asm/hypervisor.h>
>  #include <asm/apic.h>
>  #include <asm/hpet.h>
>  #include <asm/time.h>
> @@ -39,9 +40,15 @@ static bool __init use_pit(void)
>=20
>  bool __init pit_timer_init(void)
>  {
> -	if (!use_pit())
> +	if (!use_pit()) {
> +		/*
> +		 * Don't just ignore the PIT. Ensure it's stopped, because
> +		 * VMMs otherwise steal CPU time just to pointlessly waggle
> +		 * the (masked) IRQ.
> +		 */
> +		clockevent_i8253_disable();
>  		return false;
> -
> +	}
>  	clockevent_i8253_init(true);
>  	global_clock_event =3D &i8253_clockevent;
>  	return true;
> diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
> index d4350bb10b83..cb215e6f2e83 100644
> --- a/drivers/clocksource/i8253.c
> +++ b/drivers/clocksource/i8253.c
> @@ -108,11 +108,8 @@ int __init clocksource_i8253_init(void)
>  #endif
>=20
>  #ifdef CONFIG_CLKEVT_I8253
> -static int pit_shutdown(struct clock_event_device *evt)
> +void clockevent_i8253_disable(void)
>  {
> -	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
> -		return 0;
> -
>  	raw_spin_lock(&i8253_lock);
>=20
>  	outb_p(0x30, PIT_MODE);
> @@ -123,6 +120,14 @@ static int pit_shutdown(struct clock_event_device *e=
vt)
>  	}
>=20
>  	raw_spin_unlock(&i8253_lock);
> +}
> +
> +static int pit_shutdown(struct clock_event_device *evt)
> +{
> +	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
> +		return 0;
> +
> +	clockevent_i8253_disable();
>  	return 0;
>  }
>=20
> diff --git a/include/linux/i8253.h b/include/linux/i8253.h
> index 8336b2f6f834..bf169cfef7f1 100644
> --- a/include/linux/i8253.h
> +++ b/include/linux/i8253.h
> @@ -24,6 +24,7 @@ extern raw_spinlock_t i8253_lock;
>  extern bool i8253_clear_counter_on_shutdown;
>  extern struct clock_event_device i8253_clockevent;
>  extern void clockevent_i8253_init(bool oneshot);
> +extern void clockevent_i8253_disable(void);
>=20
>  extern void setup_pit_timer(void);
>=20
> --
> 2.44.0

Did a basic smoke test of this two-patch series on a Hyper-V Gen 1
VM and on a Gen 2 VM. All looks good and behaves as expected.

On the Gen 1 VM, the PIT is used briefly at boot (takes ~35 interrupts)
before the Hyper-V synthetic timer takes over and the PIT is shutdown.
As expected, no further interrupts are received from the PIT.

On a Gen 2 VM, apic_needs_pit() returns true because
X86_FEATURE_ARAT isn't present. The PIT doesn't exist in a
Gen 2 VM, but the code paths handle this situation with no
problems, just as before the patch series.

For the two-patch series on Hyper-V,
Tested-by: Michael Kelley <mhkelley@outlook.com>

