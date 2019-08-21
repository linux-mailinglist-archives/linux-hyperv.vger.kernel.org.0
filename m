Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE14B98669
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 23:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfHUVQM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 17:16:12 -0400
Received: from mail-eopbgr710134.outbound.protection.outlook.com ([40.107.71.134]:57191
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbfHUVQM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 17:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWN2TEoSfE8igSqp128TVGk/RVOix6pyz/nPHo/aW3+QTDS35s0QHqDpR6m79cJwjdPDl8sPPk6an3jle5OGKfWx1YJFZMFqAXZ5zhfYsOVQ09QEvYJljMOqtQOBp2wyesYQo8nbuB12Tf29U16fPyOCSgovy0+JeFQ44oiTANCOUACy+5DAKWrxVAmUx/NezAIVkXB12PbP6RatEuYyimo3lB727KPplCzu/xnhZzFiCEJhuTbraN6OVJWEuwkZ4T91w448PuaCG22rSeqmzngv/bMw5CoZ7IClZlwx0CAZ1aLLPMdS6P7sDBFHvAjiMevA5Dk1biHDbRCGRInFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt8qftx0rrBvKjoUAQy2lvzw5jm3uiHq7238aaOT+c0=;
 b=aqF23Y0SfLs6eFLztJijVWtEGAWwIqa27pQQIc/puEAvLrCEpO8Qi9dJZYsiRmoH5cjNqUNGMgeQ33Oe+hdmbJcY/l3K/BnmMNR3t9v+i+bvUbbcfnCpWu/4PXRBW5MBuBgQ4MTVCW9plPJVnGv6Aw9hkWCgYr/c+mswIYskkXEcUJyXEpYL7xxsf+GocUY6wnbD8Jv9lvX1UBRK30HaLaXfKRZauTV6OUrkQsTz4k4g9/FaMAMJOfg7I7XNf5YFFCYgPkyOrzp0dWnuxsiTnKfQbbKCHT7ebThbpPs3mFBZSH3USNiyXZqnShEhCXubdqhaTNgtYiMXZnh+/b/D9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt8qftx0rrBvKjoUAQy2lvzw5jm3uiHq7238aaOT+c0=;
 b=imtvD2V3Qz/YLpMiGB3OrBAXTnm+pKzDjEEwfN/ng88VRk8QbXLx8BMxxbbOjPoGwqbhDHzZ9wM5y8JzCHimseS77QTqDhvRW9AEiUltLiv3sMWXK5+mRfCq3nR4U+M+xJo8KERioAJu/1veB3XUfWfeIl72a/TKVcvmktmuHlo=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0762.namprd21.prod.outlook.com (10.173.172.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.2220.4; Wed, 21 Aug 2019 21:16:08 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Wed, 21 Aug 2019
 21:16:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH] x86/hyper-v: enable TSC page clocksource on 32bit
Thread-Topic: [PATCH] x86/hyper-v: enable TSC page clocksource on 32bit
Thread-Index: AQHVWAbGhyyHHv+f0kyOaJzPRqIeCKcGGWMQ
Date:   Wed, 21 Aug 2019 21:16:08 +0000
Message-ID: <DM5PR21MB0137D9762756109A46CBFD6AD7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190821095650.1841-1-vkuznets@redhat.com>
In-Reply-To: <20190821095650.1841-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-21T21:16:06.6066656Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=10b403f3-dad3-48aa-9286-af16ec58d835;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f1eb8b2-863e-4897-b91f-08d7267cc8ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0762;
x-ms-traffictypediagnostic: DM5PR21MB0762:|DM5PR21MB0762:|DM5PR21MB0762:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB07621C6BEE9AA69BAE80365FD7AA0@DM5PR21MB0762.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(5660300002)(22452003)(74316002)(316002)(486006)(305945005)(102836004)(26005)(8676002)(7736002)(6506007)(66066001)(229853002)(54906003)(66446008)(64756008)(8936002)(66556008)(66476007)(66946007)(53936002)(81166006)(81156014)(476003)(446003)(10290500003)(11346002)(110136005)(2906002)(99286004)(7416002)(186003)(6246003)(55016002)(86362001)(256004)(6436002)(478600001)(33656002)(7696005)(9686003)(6116002)(76116006)(8990500004)(25786009)(14454004)(10090500001)(76176011)(71190400001)(71200400001)(52536014)(4326008)(3846002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0762;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xu4Uo9nEuojn6qjRnHzhloZKz16NnDT8IQoSHsUgGwUmNhGB3NJzf5HW/nhkKM+rca//YS5zTQavZEQBm0Ot2/yyzbg0YYz+D6Eup9BRrDHvCM8cOgaWEsDUHeRAxBzI0amLMwf09Qo6LgbSwR8UKUICCMeoPbOMRvXhQ3WxPFRdohWq6EMRq2TcHFfYy5zHwNPw3X0UOAy0iqMCdd/Gr07oIxNZIEyBl3nIsBoZ2fk1RzL3vaJqf0BqTCGSPQtiWMK019JizPPJugyJhQexmF6a/aQb4tlevu94Cyj38Q2lQcGcUBl/6fymxgQpg9Hl/Nq85u2+Hr6/evf4dffG+xUZl8eQCgsnR39YhXFM0uGWbvRcJdZ5Wix3N9UzgSkVB7QNbYLDJD86Iz+CfBN5x8IrFXPeBNfNLGxTzfZzr4M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1eb8b2-863e-4897-b91f-08d7267cc8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 21:16:08.3161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puej3lKzHVkMOCGJo6siYjsL5uNJxaNeQXtoZfeg45FAAMHAr+/QQxgQezln0E4Cp6N3SfyoBLtC6EVAESieR49Ea2LzVcunpT2Ziy2eVgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0762
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, August 21, 20=
19 2:57 AM
>=20
> There is no particular reason to not enable TSC page clocksource
> on 32-bit. mul_u64_u64_shr() is available and despite the increased
> computational complexity (compared to 64bit) TSC page is still a huge
> win compared to MSR-based clocksource.
>=20
> In-kernel reads:
>   MSR based clocksource: 3361 cycles
>   TSC page clocksource: 49 cycles
>=20
> Reads from userspace (unilizing vDSO in case of TSC page):

s/unilizing/utilizing/

>   MSR based clocksource: 5664 cycles
>   TSC page clocksource: 131 cycles
>=20
> Enabling TSC page on 32bits allows us to get rid of CONFIG_HYPERV_TSCPAGE
> as it is now not any different from CONFIG_HYPERV_TIMER.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/vdso/gettimeofday.h |  6 +++---
>  drivers/clocksource/hyperv_timer.c       | 11 -----------
>  drivers/hv/Kconfig                       |  3 ---
>  include/clocksource/hyperv_timer.h       |  6 ++----
>  4 files changed, 5 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/vdso/gettimeofday.h
> b/arch/x86/include/asm/vdso/gettimeofday.h
> index ba71a63cdac4..e9ee139cf29e 100644
> --- a/arch/x86/include/asm/vdso/gettimeofday.h
> +++ b/arch/x86/include/asm/vdso/gettimeofday.h
> @@ -51,7 +51,7 @@ extern struct pvclock_vsyscall_time_info pvclock_page
>  	__attribute__((visibility("hidden")));
>  #endif
>=20
> -#ifdef CONFIG_HYPERV_TSCPAGE
> +#ifdef CONFIG_HYPERV_TIMER
>  extern struct ms_hyperv_tsc_page hvclock_page
>  	__attribute__((visibility("hidden")));
>  #endif
> @@ -228,7 +228,7 @@ static u64 vread_pvclock(void)
>  }
>  #endif
>=20
> -#ifdef CONFIG_HYPERV_TSCPAGE
> +#ifdef CONFIG_HYPERV_TIMER
>  static u64 vread_hvclock(void)
>  {
>  	return hv_read_tsc_page(&hvclock_page);
> @@ -251,7 +251,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mod=
e)
>  		return vread_pvclock();
>  	}
>  #endif
> -#ifdef CONFIG_HYPERV_TSCPAGE
> +#ifdef CONFIG_HYPERV_TIMER
>  	if (clock_mode =3D=3D VCLOCK_HVCLOCK) {
>  		barrier();
>  		return vread_hvclock();
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index ba2c79e6a0ee..b6083faab540 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -212,8 +212,6 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
>  struct clocksource *hyperv_cs;
>  EXPORT_SYMBOL_GPL(hyperv_cs);
>=20
> -#ifdef CONFIG_HYPERV_TSCPAGE
> -
>  static struct ms_hyperv_tsc_page *tsc_pg;
>=20
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
> @@ -244,7 +242,6 @@ static struct clocksource hyperv_cs_tsc =3D {
>  	.mask	=3D CLOCKSOURCE_MASK(64),
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
>  };
> -#endif
>=20
>  static u64 notrace read_hv_sched_clock_msr(void)
>  {
> @@ -271,7 +268,6 @@ static struct clocksource hyperv_cs_msr =3D {
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
>  };
>=20
> -#ifdef CONFIG_HYPERV_TSCPAGE
>  static bool __init hv_init_tsc_clocksource(void)
>  {
>  	u64		tsc_msr;
> @@ -306,13 +302,6 @@ static bool __init hv_init_tsc_clocksource(void)
>  	sched_clock_register(read_hv_sched_clock_tsc, 64, HV_CLOCK_HZ);
>  	return true;
>  }
> -#else
> -static bool __init hv_init_tsc_clocksource(void)
> -{
> -	return false;
> -}
> -#endif
> -
>=20
>  void __init hv_init_clocksource(void)
>  {
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 9a59957922d4..79e5356a737a 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -14,9 +14,6 @@ config HYPERV
>  config HYPERV_TIMER
>  	def_bool HYPERV
>=20
> -config HYPERV_TSCPAGE
> -       def_bool HYPERV && X86_64
> -
>  config HYPERV_UTILS
>  	tristate "Microsoft Hyper-V Utilities driver"
>  	depends on HYPERV && CONNECTOR && NLS
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyp=
erv_timer.h
> index a821deb8ecb2..f72e4619d0a7 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -28,12 +28,10 @@ extern void hv_stimer_cleanup(unsigned int cpu);
>  extern void hv_stimer_global_cleanup(void);
>  extern void hv_stimer0_isr(void);
>=20
> -#if IS_ENABLED(CONFIG_HYPERV)
> +#ifdef CONFIG_HYPERV_TIMER
>  extern struct clocksource *hyperv_cs;
>  extern void hv_init_clocksource(void);
> -#endif /* CONFIG_HYPERV */
>=20
> -#ifdef CONFIG_HYPERV_TSCPAGE
>  extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>=20
>  static inline notrace u64
> @@ -102,6 +100,6 @@ static inline u64 hv_read_tsc_page_tsc(const struct
> ms_hyperv_tsc_page *tsc_pg,
>  {
>  	return U64_MAX;
>  }
> -#endif /* CONFIG_HYPERV_TSCPAGE */
> +#endif /* CONFIG_HYPERV_TIMER */

There's a #else prior to the #endif that has TSCPAGE misspelled
as TSC_PAGE in the comment.  Should probably fix the comment ...

>=20
>  #endif
> --
> 2.20.1

Overall an excellent removal of unnecessary complexity.  Thx.
Two minor nits notwithstanding,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


