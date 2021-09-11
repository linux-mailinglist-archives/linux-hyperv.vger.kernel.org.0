Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57D64078FE
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Sep 2021 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhIKPLF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Sep 2021 11:11:05 -0400
Received: from mail-oln040093003010.outbound.protection.outlook.com ([40.93.3.10]:42453
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232333AbhIKPLF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Sep 2021 11:11:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPL+HYDYYe6CaGTw5lHT1V+HGH1djIPvN/EEh9hulM2/2Ej9zSzdftKq6gJGPH1/AsAdQHl4sYhOykHlneligEgKAOX1yvwRJZA/SWyMcLNkX7fYFwMI9+8xvJpUYLLlIeQOiCCaDIzzgXtkPF+rCU5Md6+Ij0G1w/HXfIcD0CbCyFA5UZX/O5I2HxXsZ+kvXObSybpm16y50Ned8R7X5HantW9euRglo78FE0OJuTTCCZK4yJ+musq56dGflQ1FioZEEln+jzQVpqtloqLFDbqEJyhHc5hrq9Mww0ivbwELyp4Ll8pAfLecMOdPx760uMHUCmMujFwpySjS9UNRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tEAPU9KyzXC2w/Cep3WJ5Dv+hmBmMqO2jF8HxybnUNE=;
 b=AbC6OlpFiEbdBd7NVeuYvhNCy6xon7vchACfCeu/jvsY9BcgdT+fc6g8HHwAdGouWs7SYJt/fr9VegmkzAT5zQI/cJ6lje9eKoPhWfrwDUJV1k5hlclNZObd89T8XvFhhXRj90Y9II6zZj1DG8h1KNaYD6/uHhnPUeU7aaIJxPYZZ458mbuGOwpCTp5OmJrmJbjPo8WMR6G9b5WVyRnwFzI+aYIsjOx2xuiQl0Plg1LygVzU+JNCgzBVgI0YwNkx+OHqcVNPe81iwPbt/JMuL2/UrwbAkYH2gFL7lb77NnsWI09jJi76m8IVB683ORV/rMPlclLhMSKkghcZPGS7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEAPU9KyzXC2w/Cep3WJ5Dv+hmBmMqO2jF8HxybnUNE=;
 b=Adl7EpTgZ6wYyC3zY3/fmNNTNJvFXM2yTfy0L6vwvM0hvlcg6YZG/ExTAa6IQc1XztguWClx50mfSaYRa1Dc3RM/c5alNGLVADubTThn+/SSw4mYiaKjbaQooIRmbj7JrPQHv6+tP95NR/+whuFCJ9qNzVHV34bxgTntscqjL7Y=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.7; Sat, 11 Sep
 2021 15:09:50 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202%6]) with mapi id 15.20.4523.008; Sat, 11 Sep 2021
 15:09:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
Thread-Topic: [PATCH v2 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
Thread-Index: AQHXpnWwoohHE8fEZ0OYJh+OycUITaue8Dsw
Date:   Sat, 11 Sep 2021 15:09:50 +0000
Message-ID: <MWHPR21MB1593DE9DE0A474E2539FFD1BD7D79@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210910185714.299411-1-wei.liu@kernel.org>
 <20210910185714.299411-3-wei.liu@kernel.org>
In-Reply-To: <20210910185714.299411-3-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49d69f2e-5b4b-41f7-bb68-4d69a4f0d300;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-11T15:06:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ddf85df-51d1-46ea-cde5-08d975363392
x-ms-traffictypediagnostic: MW2PR2101MB1019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB101934AB76CDD06EEF66B0F1D7D79@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ou910qr4zPj/tHcqQcgAbJZ3Rz6JcSQVJ0jm0H5jpEcC+2zseJKMxUFuWLGRcMJl1bnLH2C1bgKc4wqqYom0yCbOttodsoc5CDsPH/dSucIIQ5OcWlxcZT5Yay7AdABxXgoHH067JAdZ/Q4v8+zlez4OOxooylji/pLRzwDk+ht0s+xZjjsa9iK7JR3A3zy+U89se4WutLA+bOsQORgUkUW0i8UBrwwADTVvC3z1DFPbFmDIbd+KpQi5F23Fg1G//mdsIXPIXo/UpWcVwE7kGN0c39kTukuky+GlRyyIYXdEEqcl+Z7igVsLkFVhsSpI0URtPV/dx0t1Hy0i/xCGJcmLA/MpaQ/rELsvw5voR6EJsSLJBCjUFrDSzM8g+LG16//ReV42yNPw+SjtSGMhSsk8Grgp79WieSQ1W1FFbhzddVN5fZtRKLPDglsTgFqbWHzm0JS6QZDObNVt9u0x5FC8RQ8EzogcSCnQVbOxgrJTZmM5Wyo6OE0NkYMfj2XHj3DKPi7Fnyeo9hUewoxHaVhev1tDG/SCyi/herPFKQOafrS0pcDsyUI1E5YUZls+oHCZevgYF2Zewpcv/n7tASgLgcckN78WsGIsueqf591BBPWeiKpJttoTuk5JxFEV1vjUL5JarUzoYHhOogGF751PJI0a0Ozjzi0NwbpAjhEsF7SlI/wyFyqUfMhWzrYinw2pbVlfYv+J+y5eSPnAVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(64756008)(66446008)(9686003)(7696005)(6506007)(66476007)(8676002)(54906003)(82950400001)(8936002)(38100700002)(4326008)(55016002)(71200400001)(26005)(10290500003)(186003)(110136005)(83380400001)(33656002)(82960400001)(122000001)(66946007)(508600001)(316002)(86362001)(38070700005)(66556008)(5660300002)(2906002)(8990500004)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xGvljFonXFUWGlOGf6Y5EwqmibLzxhk5gT9SnAxWXL6KaQvLKWnYWl8F4frP?=
 =?us-ascii?Q?96sRAWBvBRXecMbOZIWisuC4l5LS5bVlSbS9L12A8KN/vp/YJsyZl2R+oMb9?=
 =?us-ascii?Q?Hws1yccs5yKc4gTwh8RIdCpM5eBbzH1IzWzpdD8e13wssUAKbyXI9yKIMw3B?=
 =?us-ascii?Q?GQtfWpStZoFOVHS1NFTbRU/Nr2Jxd1K6XgQxj/UIN1BlB5ZbjIl1A6gO2snr?=
 =?us-ascii?Q?tcQ5LG0f/nlN47oS5T0L3nunYF0pyEB7E/rqClHdsU/gJYnOYgouaDFIVqFm?=
 =?us-ascii?Q?oCGeBN6lRoKHhAVZvXLzyimt7Rh+jHaIXxWbQOiIqAkveBQ7B0ZGkEQb8dvv?=
 =?us-ascii?Q?OZhLtr4qAQvFqpx3Ck5WKbBCwGSjs1XCGHzi2dxjlNtcidui1S2ozBx0QlOF?=
 =?us-ascii?Q?VAFqttmCngyOU+oOJdCec1qVaPVlvyvhzZ2HwUNKHiwfQ5f0vUCRLoOVerik?=
 =?us-ascii?Q?Jf1vsBrCyRrGbyXI+QimwgM1lrcu3OCt8bOCKlQndwNE7s69kxC17xsWOYyg?=
 =?us-ascii?Q?I6qbfJ1rlEHnZ9IrfHT+lB0KV66C4L/+cNH5HRwvp0oe4UJCDmVFkJUb8T9j?=
 =?us-ascii?Q?yiQFqUQX1duxGm53xnVxqAUFJGfSMPgoDglcnZlKllncwgZzbTBVPiiEyL3j?=
 =?us-ascii?Q?YqMEDABHg9hd7SgZY7vsl7k9hpDSbXUE82vBm0Z0r2m8owdMXFZD/y46m0Mu?=
 =?us-ascii?Q?1f+MH9kctefrRx0FjvDHn5XM4mC3/HayWgxZk4AckBbfgXVTvpkRbjub5fJY?=
 =?us-ascii?Q?UYjyCX2TnVbT06jg/KheCci4RpH4oWw9MzDGWjHDWNT5I+rOI07HR22tByS/?=
 =?us-ascii?Q?NtjJAF7tegLkMW+twWltaau9IOcsV+fydPoqycriupryEhTOoDe2ZPgoH7JF?=
 =?us-ascii?Q?zuxGKZksEe9Zb4cU4kyTi48sC7V4IvRZQjT/BSlqaF1VxrzDIG/pyppogVxj?=
 =?us-ascii?Q?3vjSSnpLKEX4ZV4neEbFxAZsm1a+TV9hqfhjLyMar/R1NxqZrYAIYEqvZi/d?=
 =?us-ascii?Q?QvGJAn/YMPsbRSuqRd+ZWuSpLe57z/GAHCh0LO1+/8BiLrU+Iwx+jcXTy92g?=
 =?us-ascii?Q?htLLj3eay8cMLvMjUZw55rGOQT2uHLnf02znx3ALsegwIzjrWTdoOgSwHlIR?=
 =?us-ascii?Q?AzrKXJFMH+rxSJ0blZvhXPYiJLYgEZq6G9S3Y0Tt+x9ynq8aH//VeYVglmOy?=
 =?us-ascii?Q?2lQPDrPiDjjcsptsldK1YvpJGaDdOlpKTOJxS+IRlq5gjSm0xhz0pheSdna8?=
 =?us-ascii?Q?Bm9vCEilHzJOPYOzG+l33wKX0qtCTtQMB8ETk8/oZFqUgkIAahbyhjXJrRVB?=
 =?us-ascii?Q?NVn14CNnytC6WnJJ+4DpPb/Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddf85df-51d1-46ea-cde5-08d975363392
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2021 15:09:50.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKVhqYYtE9j9ginDx3BRRRbI0oHwalcC3wbHTZsKhXwugi7cafd2bZQGLrZ5WUvZQBKjhr6+eLeamzWbtBl62Zw2zuPH2zSXJvBCRcp9a3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, September 10, 2021 11:57 A=
M
>=20
> It is not a good practice to allocate a cpumask on stack, given it may
> consume up to 1 kilobytes of stack space if the kernel is configured to
> have 8192 cpus.
>=20
> The internal helper functions __send_ipi_mask{,_ex} need to loop over
> the provided mask anyway, so it is not too difficult to skip `self'
> there. We can thus do away with the on-stack cpumask in
> hv_send_ipi_mask_allbutself.
>=20
> Adjust call sites of __send_ipi_mask as needed.
>=20
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 68bb7bfb7985d ("X86/Hyper-V: Enable IPI enlightenments")
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>=20
> v2: more robust check in __send_ipi_mask
> ---
>  arch/x86/hyperv/hv_apic.c | 43 +++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 90e682a92820..48aefcea724b 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -99,7 +99,8 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
>  /*
>   * IPI implementation on Hyper-V.
>   */
> -static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> +static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
> +		bool exclude_self)
>  {
>  	struct hv_send_ipi_ex **arg;
>  	struct hv_send_ipi_ex *ipi_arg;
> @@ -123,7 +124,10 @@ static bool __send_ipi_mask_ex(const struct cpumask =
*mask, int vector)
>=20
>  	if (!cpumask_equal(mask, cpu_present_mask)) {
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
> -		nr_bank =3D cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> +		if (exclude_self)
> +			nr_bank =3D cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
> +		else
> +			nr_bank =3D cpumask_to_vpset(&(ipi_arg->vp_set), mask);
>  	}
>  	if (nr_bank < 0)
>  		goto ipi_mask_ex_done;
> @@ -138,15 +142,25 @@ static bool __send_ipi_mask_ex(const struct cpumask=
 *mask, int vector)
>  	return hv_result_success(status);
>  }
>=20
> -static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> +static bool __send_ipi_mask(const struct cpumask *mask, int vector,
> +		bool exclude_self)
>  {
> -	int cur_cpu, vcpu;
> +	int cur_cpu, vcpu, this_cpu =3D smp_processor_id();
>  	struct hv_send_ipi ipi_arg;
>  	u64 status;
> +	unsigned int weight;
>=20
>  	trace_hyperv_send_ipi_mask(mask, vector);
>=20
> -	if (cpumask_empty(mask))
> +	weight =3D cpumask_weight(mask);
> +
> +	/*
> +	 * Do nothing if
> +	 *   1. the mask is empty
> +	 *   2. the mask only contains self when exclude_self is true
> +	 */
> +	if (weight =3D=3D 0 ||
> +	    (exclude_self && weight =3D=3D 1 && cpumask_first(mask) =3D=3D this=
_cpu))

Nit:  cpumask_test_cpu(this_cpu, mask) would seem to be a better fit for th=
is
use case than cpumask_first().  But either works.

>  		return true;
>=20
>  	if (!hv_hypercall_pg)
> @@ -172,6 +186,8 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int vector)
>  	ipi_arg.cpu_mask =3D 0;
>=20
>  	for_each_cpu(cur_cpu, mask) {
> +		if (exclude_self && cur_cpu =3D=3D this_cpu)
> +			continue;
>  		vcpu =3D hv_cpu_number_to_vp_number(cur_cpu);
>  		if (vcpu =3D=3D VP_INVAL)
>  			return false;
> @@ -191,7 +207,7 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int vector)
>  	return hv_result_success(status);
>=20
>  do_ex_hypercall:
> -	return __send_ipi_mask_ex(mask, vector);
> +	return __send_ipi_mask_ex(mask, vector, exclude_self);
>  }
>=20
>  static bool __send_ipi_one(int cpu, int vector)
> @@ -208,7 +224,7 @@ static bool __send_ipi_one(int cpu, int vector)
>  		return false;
>=20
>  	if (vp >=3D 64)
> -		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
> +		return __send_ipi_mask_ex(cpumask_of(cpu), vector, false);
>=20
>  	status =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp))=
;
>  	return hv_result_success(status);
> @@ -222,20 +238,13 @@ static void hv_send_ipi(int cpu, int vector)
>=20
>  static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
>  {
> -	if (!__send_ipi_mask(mask, vector))
> +	if (!__send_ipi_mask(mask, vector, false))
>  		orig_apic.send_IPI_mask(mask, vector);
>  }
>=20
>  static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int =
vector)
>  {
> -	unsigned int this_cpu =3D smp_processor_id();
> -	struct cpumask new_mask;
> -	const struct cpumask *local_mask;
> -
> -	cpumask_copy(&new_mask, mask);
> -	cpumask_clear_cpu(this_cpu, &new_mask);
> -	local_mask =3D &new_mask;
> -	if (!__send_ipi_mask(local_mask, vector))
> +	if (!__send_ipi_mask(mask, vector, true))
>  		orig_apic.send_IPI_mask_allbutself(mask, vector);
>  }
>=20
> @@ -246,7 +255,7 @@ static void hv_send_ipi_allbutself(int vector)
>=20
>  static void hv_send_ipi_all(int vector)
>  {
> -	if (!__send_ipi_mask(cpu_online_mask, vector))
> +	if (!__send_ipi_mask(cpu_online_mask, vector, false))
>  		orig_apic.send_IPI_all(vector);
>  }
>=20
> --
> 2.30.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

