Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C63E1A7B
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhHERfo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 13:35:44 -0400
Received: from mail-bn1nam07on2137.outbound.protection.outlook.com ([40.107.212.137]:46727
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240060AbhHERfo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 13:35:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/cYYRKEDtrVnFUhox28xRHCkFW0dR7Mp7vZQ42GyNJUrqtEHecervOllk7VslGWzBQrXN7j42klxEQbZYPJnaVSSfBwPjggUvmQ1jzruzTkhwnb0hRTGKsQZyHBhoz9Ggu79PoBErFEcJ1REf+6hOPu+qS4WJJtW271jkIxnocW9yeGpizHb5gyHTSCu0+ahnEfjF8CoIqb6t6pKV2itbU5ap3DCCNdiQdKE1zIKzi1pP5VW1UtLLDIqm5lMoS1pFIeTQYiuXsq2IIzsceJfCga8q8DWIm6vsqURrnwSJtS/sIXpWIuFiqZx0r41lSjXzBi1J3yPxmPmwMGr7G8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u75OJOZg5ReGZd6Gnb6HY4dXWRqZfAPkg3afwc71Qeo=;
 b=HSM+CN3fB/ivqW0O4R9Ap6NNZJ5EzcDEKrQW82++pytUMT4KeZ5ggtVx4b/XyhsuK/3yX8mOitro8ErPMGtlW2QOzUt7qiCdwHUN/4xs9yPKqnMzqGdRvvuE+I/orXubFNBS9WRSZ7mf2n0Cym5UHWd6+QXzDkw6O7AOVA0lsH6KyLrGhMBcZU2svjH2+Zg1ekFNBTo3yL4p18Ytda5VPZ8nhMCt77iu4TmduTvKm65NQmXFhn6IOo8hN4Mx4mc71xyHKJUEz40iS+0YgozklO+xbrSHz/FlBvD/7HSzVuWwYMx2LRiWSsp7MFHGY6+oy9uX5R0Uc9pB4wIxuytJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u75OJOZg5ReGZd6Gnb6HY4dXWRqZfAPkg3afwc71Qeo=;
 b=VgjRkYG2PNi6UFczY+AUh/nAyW+DPj97AFqRSr0iFop9bt3qmz14ANOzW/7u/eP+4Z5Zfu6U/M/iw9EGKaKqE4NGSnPuDdDi3wFUv9LPH8umrJstvDlCHrmPv5n8lIqFmRGPHDUuyH7hXq2vaM09DKdmOWHPH6r6kRrRAaExrg8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2058.namprd21.prod.outlook.com (2603:10b6:303:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Thu, 5 Aug
 2021 17:35:08 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4415.005; Thu, 5 Aug 2021
 17:35:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] x86/Hyper-V: Initialize Hyper-V stimer after enabling
 lapic
Thread-Topic: [PATCH] x86/Hyper-V: Initialize Hyper-V stimer after enabling
 lapic
Thread-Index: AQHXiWFeirpd23mz0UeWjQo7kIdmNKtlKU+w
Date:   Thu, 5 Aug 2021 17:35:07 +0000
Message-ID: <MWHPR21MB1593E508E6B6DF82DF45A431D7F29@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210804184843.513524-1-ltykernel@gmail.com>
In-Reply-To: <20210804184843.513524-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d80a51a-ebb3-46bf-9721-dbd3b1be1a8f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-05T17:19:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3214e251-5e1d-4a77-3196-08d958375e94
x-ms-traffictypediagnostic: MW4PR21MB2058:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB205873E3DFFB931FE81C33C9D7F29@MW4PR21MB2058.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bx8KV96KH/lsnWvo7xun+fMAsoIZsLfhkq/6klp+dVMaxwBHyR62UOWxASyfA24uSkc45B5FC3u4G2myeNUdYRgmqQCNnxWEuCrQAavVfyGqJZWk8n5A3Rsix0pM22SWwPxjso4kWOAqhQw+8FiJyM+RcZCHdHauzN9mSQnDhjdOlno8qFXR7z352nk7Vzz1D/y8gmMcVfiI49XI7O1ECOrIjz0/UymaqoW6CjfZjrQz6nQ/KYi9HH2LTf90IHnOcHyUo1yXWHVPvmDDjKxDcEiyOk/JJbVqmZh64ZV8bDIPHmOyVEQNQS0FMgTSc8Ib+nO4JFM8NHvzYE5s2OC15jA+KMp0ptFjbpmz2AjYUrELnIgxQmrLjNmR7ca+gg1/g+XpWz3jK2/d0oDmoEdtmWHcuSHTo6HWAYi/B9PyXbPs3GojjzxhLUG8nzExa630GDfC3d0tcr7riEnsCqu5Oz5zC1vUtWDt8p3ODL8VRyStmx+IEE9MWs5WglDKdLdACaUvXh2nZYdMWkZTFzdl2pEJvzbNI2m3OKGYt4unB0c8KaK0qBvPv5WgULaYeN43vwwXxobKxNAe+EiJzcom7HspQHHcWTXwJ6zq6xYCj+UPgumiC5kGXnH90zr/Tj4P426OBJPvoe98Z7khDnXwfH7763zjnneppGX4nu4yuh1u4ZAfl22V+h1NvcdBbNITcgYagn8cKDknPqSZNK1mJVUP39V4SfiMcgC6I4/voo8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8990500004)(7416002)(38100700002)(508600001)(122000001)(54906003)(66946007)(110136005)(66476007)(76116006)(66446008)(9686003)(66556008)(316002)(55016002)(64756008)(7696005)(38070700005)(52536014)(71200400001)(86362001)(2906002)(8676002)(5660300002)(26005)(8936002)(82950400001)(83380400001)(186003)(33656002)(82960400001)(6506007)(921005)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ss+hgrXFfQVw6QDQb2CMv01ZN7vonL52P2Cr7QzrheX8ITCBzsXxc9j1DFL?=
 =?us-ascii?Q?3EAtPYehCXgwcIZyfWUH6NuhUnV5yFmOse3qfAaYWuVlJNgEz9466lltIReb?=
 =?us-ascii?Q?5/izvkE27km84Q2GOpN/1M7Cr2lZRrqE9x2SJqgrynps3F5yRhEXamvklBUB?=
 =?us-ascii?Q?XR7r/vdurNiZgx4kUhZf6iVVCpAQ6/Re3sxtM+EeUrVjW39nsfsH+OnoNyVU?=
 =?us-ascii?Q?A6CZgBsPaleCXaGCxsPwoecif59SYfXTU1lOuP4xjqgek5OPd6ZRJ6B+opOH?=
 =?us-ascii?Q?52GbL773C+hA2PvvaFdK40PXALgJphHlYIk2fsnhkDTUFDm2+zTUJSmJogkS?=
 =?us-ascii?Q?spDi9gp4tKv1lo8sr/JdJ8/I/FO170Iw3Ilxg7y2A5stXG1uz8gNE0CxcmEX?=
 =?us-ascii?Q?rbcHG/sU9sIsUUiuRqidFADEjKjf8ZzEpxRBWiSa5jnk77PwoUXAvOcZGxhs?=
 =?us-ascii?Q?O9LdHIl5WTX9O1I0gXhkdZXFdncIzBSa0IM4GwV6fYnRadfLIti2Xz3Nh3O+?=
 =?us-ascii?Q?nMOjKkjxV2wcL6+xmtkYu0ct2EX98X7rvVtemPTp9YwQcoL4FrRCcf4mKFTm?=
 =?us-ascii?Q?YkLAjKt8dVbWAo0V+9+8B97dcxp6Jxkf9CJ/DyQWtgBqV1br4i6nRsRwbktc?=
 =?us-ascii?Q?pZqpvG44mVCVNPkJweVcZ1SOrUAPreLumrXfrd3YAO4QkyTUOdXMBOKD/odp?=
 =?us-ascii?Q?yQTWehi9wsa274vSyJuG9o1Cg1Id+owhCIwQKwi/8esmxSF01+SXi9q9w2Vo?=
 =?us-ascii?Q?cEBtZR3e5asSuno1uc77at8Ipz5vFraX1Gs9l3KMvs/MR3W8/kAnm5n721Ky?=
 =?us-ascii?Q?Q/GMrCCNQRvNuhS6CxKzEGjCFt92y5Ftw6+ncWHQBH6x71NRGXRwirM+sn1C?=
 =?us-ascii?Q?k64JC6/xRHTFVUJN5c+KAGJMB3NkttMQPvLh30bh4BstLdasgVFzjdOzriuo?=
 =?us-ascii?Q?OE03oBZDgHuDhRU1hD4iMv4icBpRgEjltCvWDl9NSEishE4V6m10lIRd8HWb?=
 =?us-ascii?Q?dutqywLMeDjxtNzgOijT/gyaYg2byB9LS/YRouyhLs5Codw6UNT0wIFrOt1r?=
 =?us-ascii?Q?OFDG/uPjamYoNkoT34ome+M8UXZsyI9/u8iMXB9abOUg2n09vP7WQ9F6kKwI?=
 =?us-ascii?Q?URbsLOAG3REeDLUVjW9qi/RFlR+8bZmzeom3wf1RWAFA3e/IpWL3N89pDDi6?=
 =?us-ascii?Q?oWSw+DuUeU+4OHDgob9703KgGqQbFB2nCig/exL1YaGMWtPDph3uAmJlkfd1?=
 =?us-ascii?Q?eF6WBMwIPdUyQ0tz6tl0hVIjc5przviRhskaqIw+1OJ7W8DTv5CX9dXIhCPV?=
 =?us-ascii?Q?ptZduhknZj/8ayeYz2IhrviV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3214e251-5e1d-4a77-3196-08d958375e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 17:35:08.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOIZz4SeSnsSYrXfxJXI1fRZVyH5R07xM8yH3AWlAcJiCyKoDbA3no2Vz46jB2y6yq5BfZzUx/7l5k6oYPmUFaagauCiZ54aloh6CTC7YwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2058
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, August 4, 2021 11:4=
9 AM
>=20
> Hyper-V Isolation VM doesn't have PIT/HPET legacy timer and only
> provide stimer. Initialize Hyper-v stimer just after enabling
> lapic to avoid kernel stuck during calibrating TSC due to no
> available timer.

I'm unclear on the core reason this patch is needed. Hyper-V
Generation 2 VMs don't have PIT or HPET either, and they don't get
stuck in TSC calibration.  Instead of calibration, Hyper-V provides
guests with a synthetic MSR to directly read the TSC frequency.
Code in ms_hyperv_init_platform() sets x86_platform.calibrate_tsc
to hv_get_tsc_khz(), which reads the synthetic MSR.  Is some
part of this mechanism not available in a Hyper-V Isolated VM?

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 29 -----------------------------
>  arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f247e7e07eb..4a643a85d570 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -271,25 +271,6 @@ static struct syscore_ops hv_syscore_ops =3D {
>  	.resume		=3D hv_resume,
>  };
>=20
> -static void (* __initdata old_setup_percpu_clockev)(void);
> -
> -static void __init hv_stimer_setup_percpu_clockev(void)
> -{
> -	/*
> -	 * Ignore any errors in setting up stimer clockevents
> -	 * as we can run with the LAPIC timer as a fallback.
> -	 */
> -	(void)hv_stimer_alloc(false);
> -
> -	/*
> -	 * Still register the LAPIC timer, because the direct-mode STIMER is
> -	 * not supported by old versions of Hyper-V. This also allows users
> -	 * to switch to LAPIC timer via /sys, if they want to.
> -	 */
> -	if (old_setup_percpu_clockev)
> -		old_setup_percpu_clockev();
> -}
> -
>  static void __init hv_get_partition_id(void)
>  {
>  	struct hv_get_partition_id *output_page;
> @@ -396,16 +377,6 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
>=20
> -	/*
> -	 * hyperv_init() is called before LAPIC is initialized: see
> -	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> -	 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
> -	 * depends on LAPIC, so hv_stimer_alloc() should be called from
> -	 * x86_init.timers.setup_percpu_clockev.
> -	 */
> -	old_setup_percpu_clockev =3D x86_init.timers.setup_percpu_clockev;
> -	x86_init.timers.setup_percpu_clockev =3D hv_stimer_setup_percpu_clockev=
;
> -
>  	hv_apic_init();
>=20
>  	x86_init.pci.arch_init =3D hv_pci_init;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 6b5835a087a3..dcfbd2770d7f 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -214,6 +214,20 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  #endif
>  }
>=20
> +static void (* __initdata old_setup_initr_mode)(void);
> +
> +static void __init hv_setup_initr_mode(void)
> +{
> +	if (old_setup_initr_mode)
> +		old_setup_initr_mode();
> +
> +	/*
> +	 * The direct-mode STIMER depends on LAPIC and so allocate
> +	 * STIMER after calling initr node callback.

I'd love to see this comment have a bit more detail.  I think the
point is this:  "The direct-mode STIMER interrupt delivery depends
on the LAPIC being enabled".  The timer mechanism itself does not
depend on the LAPIC timer.  You just copied this comment from the
previous place, so making it better isn't strictly within the scope of
this patch, but if you are going to move it, let's make it a little more
precise.

> +	 */
> +	(void)hv_stimer_alloc(false);

I understood the point that Praveen Kumar was making to be that
we should not just ignore the return value from hv_stimer_alloc()
in the case of an Isolated VM.  A failure of hv_stimer_alloc() in
an Isolated VM is fatal because there is no LAPIC timer to fall
back on.  In that case, really all that can be done is BUG_ON().

> +}
> +
>  static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  #ifdef CONFIG_X86_64
> @@ -424,6 +438,7 @@ static void __init ms_hyperv_init_platform(void)
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
>  #endif
> +
>  	/*
>  	 * TSC should be marked as unstable only after Hyper-V
>  	 * clocksource has been initialized. This ensures that the
> @@ -431,6 +446,13 @@ static void __init ms_hyperv_init_platform(void)
>  	 */
>  	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>  		mark_tsc_unstable("running on Hyper-V");
> +
> +	/*
> +	 * Override initr mode callback in order to allocate STIMER
> +	 * after initalizing LAPIC.
> +	 */
> +	old_setup_initr_mode =3D x86_init.irqs.intr_mode_init;
> +	x86_init.irqs.intr_mode_init =3D hv_setup_initr_mode;

Hanging the stimer initialization on the intr_mode_init() function
is an ugly hack.  Is your goal to do the stimer initialization
after the interrupt mode has been setup, but before tsc_init() is
called in x86_late_time_init()?  Back to my initial comments,
I'm curious as to why the existing mechanism doesn't work.

Michael

>  }
>=20
>  static bool __init ms_hyperv_x2apic_available(void)
> --
> 2.25.1

