Return-Path: <linux-hyperv+bounces-963-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1107EC989
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 18:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37B7B20BD5
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2328DB6;
	Wed, 15 Nov 2023 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HGnbFEl3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2027.outbound.protection.outlook.com [40.92.47.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD284127;
	Wed, 15 Nov 2023 09:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STfGdAa8/GNC35B0ua8ifkCKqRmursLlQ6DgUsMRIiPZ1mTPHSkxWB2keNUfXy3ypVyTxuNblCD0D/MEq0gmLmaYFH7pYSez7mSYdByCtEPLVMkgJVrtRCSwKtpXTQi8Jt/gLDj7jHpiKPruEeqayqTYkkVz6fPBZ6i9EskplCSWAzMBtUhOe1lbAKoLuKVRIkSvuJ/pLWhI01kWAPbsMEd5mAgKz/UntE0CmmCsbn5ayQ0rIihl1Dxbbg6OVBYGNsovRuiCI1bgHiLhK9jhwZbh54KA7y8hESanqIqBQ3Dc9ppSBOO5csrxhSO9+6sEhgPME5Z52+Jlj4+5ywqXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2oooVuK9YUa7fIlkeQbkrfqJKLga6LCD+pg6msVTv4=;
 b=l9Gf/ZRHzDfQmyk7qeBlZ2HAaaN//awXQE/j6gsfdVoWvd+AGsjeRFx3Qw2tDVArdlzK3YopCOkJg7cty2z+/Vs7zq9CB1ioV2reymwlWCoeXxWVT2QyvoZbab++xcDnJ/I647/p74yrPxwlEmtvsqhrz4MbuQqdPxqwDof1abaR3Tkl6dqfg49uzsZkJUWp8iczPk/6XPLcVI1KcGjM8EQ/fBaWVXgMg4ZFwa7WwtpzXL26v9geoR8F35PfFlDxS1wAlpX7HTZrhZHDTgGXva6N0kfpwXH2I3I6o3kHbpE/crM7OI2WTQZhmuUBGkfU6XpXkSQSwFOPDE+z7tW76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2oooVuK9YUa7fIlkeQbkrfqJKLga6LCD+pg6msVTv4=;
 b=HGnbFEl32HAfI7MfqCqDaSjOM4NEPJ2VEyVdrI9crixvaATDGzqq0doKa6zy4m51WLXXVV+6Yr7Vum0lzFmhzrPgCNHqg+zwMUKRIfSs7H1NVlcVt6WFaBpmn8MIYJFsFQDNZ1SFOFWCLJB8XPXGZWHbgWo2DJjqZsMugoWgm4wd1C8mnOO56VSvOgmTRlw7RzTDwljK06BgCRyOUPSK97Md+hVuSVKq91ay+qd+bdOOv92CzzJyav6CA8neoU/wgMpTSC+EtYh3JZ9+CZnJVdZJrrS05sTxG9Yl2YgXj1aAe2dfUO4rfuTZSdlf6zEzpX+WonOsrjD3ziD3z+hM0Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9209.namprd02.prod.outlook.com (2603:10b6:610:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 17:19:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 17:19:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Uros Bizjak <ubizjak@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH] x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize
 hv_nmi_unknown()
Thread-Topic: [PATCH] x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize
 hv_nmi_unknown()
Thread-Index: AQHaFxwmvIq1AgDxz0+8P8PcuNcfxbB7nX2A
Date: Wed, 15 Nov 2023 17:19:04 +0000
Message-ID:
 <SN6PR02MB41570168279C428D385ADCB0D4B1A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20231114170038.381634-1-ubizjak@gmail.com>
In-Reply-To: <20231114170038.381634-1-ubizjak@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [VNS/wgPS4ChRS3eQx9q+T3h7cMt00jMy]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9209:EE_
x-ms-office365-filtering-correlation-id: 86165ba8-f85a-4917-f8a6-08dbe5fef793
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MChRegLD8IICQiNXit7dab8wS5EWNNBPt2eNVK1YlPKxM+u6G6r2Aq7H/0agN5sKhIWOuulEYnB6EYVS8TGn2ctFvXQgiaWH0jjJcu3ynhcOQfLL8kR+34KA2UE1aCOhNW2XHowPIGPb2LqV9MGklxVVsBXhDimg4kLaxfjJQd5SZ/dauxzGU8I/1+gR/JBXtn6i02NFfjBMGDMh8kwYvpnCxiTxW7/Jbzhd6LeguvztYFr6E6t1y80Q1Edh4xRQP3dPIV2V5wYPRpCItB85Su2vsStdhx8EZobhifSu7Y7h6x8cIUWyTpAizgpdaBbFfcX7hpm9KYG0R4GLr9SFbwILhqnszrGtbg/4EWWfSSUeI2ksQCsa4QdLlC0/X1MIDn1lbZisDsEUd5ChmFdDFdv8c0sEt6C1U/MVa7yQXEpbTGm3wIN42eHUARWPtq0VFNuZEqWKhiej5S79cPcsWM25tQxAzOUJy3GiUr9MCQwzoq6Qewususk4PMvjrw1uSUN+JzC1klP3SYN8PcS+WcbDdJMGb3473Je/97kwpJGd79BJIb0DCou/zgm+KRT6
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3+LfY6zz6VB0puxRKAX69GQs8yhYnUVtm4NrO4lsXauMnRKGStESncJtuL0z?=
 =?us-ascii?Q?jip31zZy1yKYHCA23G5bESfzXMb/Ostk2LrXBJQgEpPoZ/P8UyI0IGVDvDAB?=
 =?us-ascii?Q?uiWOgnke91zJFbNMs+XykA8zO/loGtlklL/NM9ADtDs294Zn0NojCT0oyd5m?=
 =?us-ascii?Q?V7sBs6Go3kMPJIAPbXCTisV9J5pA0EI3MhlwyAwKS9PYV3h9ZuS6Za80stvV?=
 =?us-ascii?Q?if4/GATy/RKGysm27N6idxQufISyJADwF+mcuLX5X+JGFhDJhzEUP8Ryqq3y?=
 =?us-ascii?Q?vSaZIoLtYyJUbSoz9yQx6CWfTyyWT6jqUoV0GH/1G/nfpwQBtxElJg6ER5H5?=
 =?us-ascii?Q?P/Z9uOjbOuMOEm4fPsq7U29ZjnQFaLvS5reZt7AOY4krgdy9AZqwFv6Rmmf8?=
 =?us-ascii?Q?+uH6TRuUnnHr8qlrzqIJj0KFynsug4RGIiMB9+Lrx3Gjq7QghGaYcJxxgI3i?=
 =?us-ascii?Q?jBb4fshPRsFWzLittblhGDXKWAGKb+CQGxx5+ytSQ420VH3SdMXFuoVRKxPr?=
 =?us-ascii?Q?4Bv7AKGYmfzNjgL992+A6iae/If/oEytw9Q7DAfNs7mOpoO76oz0TJGn5qk8?=
 =?us-ascii?Q?9avXtVRFW+pFmgIKzvqIkV6WiLaO8PYKga/xcpdjntbX8l3FJ1qtWlYrFEhD?=
 =?us-ascii?Q?SPUSOdE6OLXIzJlRKToYoY93Nkga6jyFcl2KQsr27qS5WM8E9OK0MWt4XLyu?=
 =?us-ascii?Q?e23RpB4jCvBEjFhHiPKZfpEfKo1uSk1AOXA+XV7UoRvaDw5COOnvCDD8YFwr?=
 =?us-ascii?Q?TNCufbzLXuUX8m7vWD2Td6XBjFGnIeGlp3GtFJW8XQDLYZnpU58QQkVsGFgT?=
 =?us-ascii?Q?R/OcKmLR2RK86jEGlTwQg2O3DO3mz7KVnHt8KRXiRh50e7rHR2Xr3F+UJKGL?=
 =?us-ascii?Q?ryndMwMzeuF1M6QhWCjz7VpHtjbafUmDCND9UfJEvgShNM9un50Ndlvo0/SZ?=
 =?us-ascii?Q?eMLf0344a/ShvYctAoJ2UMSIbMttEbmIUiTypto+fJm6IkPMRFg5LZznDsty?=
 =?us-ascii?Q?w8zrLN5cz3whQj7RqazudV20TefUzErAbUYkxW5Oud3j2W+0z9OatJkuLm8o?=
 =?us-ascii?Q?6Txcq3/DxweDclZS2S/UFZ4xG3hUSfHL3QXfCW7g2A5zR7XPrzQMfjxzqsvJ?=
 =?us-ascii?Q?JUGsuo0vuGQqeSuGRnNtZzZo+btG0go2178QBYsujoQlTNLLU/EG7lP/IO9g?=
 =?us-ascii?Q?5ZG6z60U5CmZ4cqB/oYMDeJrR/zCC7lI5elsqg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86165ba8-f85a-4917-f8a6-08dbe5fef793
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 17:19:04.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9209

From: Uros Bizjak <ubizjak@gmail.com> Sent: Tuesday, November 14, 2023 8:59=
 AM
>=20
> Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) =3D=3D=
 old
> in hv_nmi_unknown(). On x86 the CMPXCHG instruction returns success in
> the ZF flag, so this change saves a compare after CMPXCHG. The generated
> asm code improves from:
>=20
>   3e:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx
>   45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
>   4a:	f0 0f b1 15 00 00 00 	lock cmpxchg %edx,0x0(%rip)
>   51:	00
>   52:	83 f8 ff             	cmp    $0xffffffff,%eax
>   55:	0f 95 c0             	setne  %al
>=20
> to:
>=20
>   3e:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx
>   45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
>   4a:	f0 0f b1 15 00 00 00 	lock cmpxchg %edx,0x0(%rip)
>   51:	00
>   52:	0f 95 c0             	setne  %al
>=20
> No functional change intended.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c
> b/arch/x86/kernel/cpu/mshyperv.c index e6bba12c759c..01fa06dd06b6
> 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -262,11 +262,14 @@ static uint32_t  __init ms_hyperv_platform(void)
> static int hv_nmi_unknown(unsigned int val, struct pt_regs *regs)  {
>  	static atomic_t nmi_cpu =3D ATOMIC_INIT(-1);
> +	unsigned int old_cpu, this_cpu;
>=20
>  	if (!unknown_nmi_panic)
>  		return NMI_DONE;
>=20
> -	if (atomic_cmpxchg(&nmi_cpu, -1, raw_smp_processor_id()) !=3D -1)
> +	old_cpu =3D -1;
> +	this_cpu =3D raw_smp_processor_id();
> +	if (!atomic_try_cmpxchg(&nmi_cpu, &old_cpu, this_cpu))
>  		return NMI_HANDLED;
>=20
>  	return NMI_DONE;
> --
> 2.41.0

The change looks correct to me.  But is there any motivation other
than saving 3 bytes of generated code?  This is not a performance
sensitive path.  And the change adds 3 lines of source code.  So
I wonder if the change is worth the churn.

In any case,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

