Return-Path: <linux-hyperv+bounces-5880-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB4FAD639C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Jun 2025 01:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8957A6317
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 23:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D02F4302;
	Wed, 11 Jun 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="boFumQk/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010016.outbound.protection.outlook.com [52.103.2.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F62F4300;
	Wed, 11 Jun 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749683217; cv=fail; b=krpf5M0Wn9qbICiw8KacBwe3jrxQXnDUHRqOB0EoOlKl1NKO6IxWcgcQ/YPdBpQ8BBNr3iAOfIgkav93xKNpYSXJq/54aqV7EroNZ9uShSmlhNqFtpF560ZEZseEVjFUpdEuJ+JuKEDe6bTBOgWS13jF4d1ORKfnV1B9ku4jUD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749683217; c=relaxed/simple;
	bh=Kgc/UoDLr4vlc0nWbSO2SqJAYjB5cZmpUh2jWCpaoX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5Fq+ue2jNI1BWC7jUx19GKswLGY4fy2gDWWJsp2a6GL8hi45R7q4w/0hZga0QWybfJci02idTW+ROfxEX0dm/hHk2m++iE6Tt9uhaVZRM9fowotqFalB+a8TV23K/zSjPAvjsYXP5eSXYPaQgIU+ntRKgUoK/EByEvnreh9l9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=boFumQk/; arc=fail smtp.client-ip=52.103.2.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpslg0nE6J2j7wc665sahJGVzrbPIeDWT+Yo4WCjEJ5315SOSZfSAwwimp2vVA+KQXi7cYM5zv5YoMyd4Ed4uBrVBYhpFG0fQgiNIQ/Nogj2KYvKPPpvJE6oUAeVMwZST/KTLfbT2BGWbpTRX5qeSbRCUbMcGAwIqGY1qJ4GQ2TmOLUEPZgo6HdzIQFsBEKO0D4VAqlfJwWClX7hjqtXlJyMMGjNT0c18qi4z8DejXfazAeXjiFRMuh5OxYQChuAxSqSE88vEV3aPkpdEtrNpHxzArUndZkq8n0s0HqazQ3pcuno41G9cInZWF5c4rkGHxHUtYM3Ag2gObUR32L5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNhLbNqr8rImvxMiXanvdmmAZV30VJ7soySP2ZAGCGI=;
 b=M0gOIUJOU3lFrW4jWO2JB1jniU7diXVFwaLjnpOUzmOzUepKs86G2hxKfGT6vvl2YeV6ESMaOyEE0R6QzxvZOkqdb7h3o63Onjm9pTR//WYPJ9ne/iEbYhtcl7dMsvHSClZGj2yJ/RXkSPicEGbeoRrDCS3Sd+Fkw4eakoFh7PEeo9Bhc2s5B1295JtiHZEDEn/XVpcBf8GPTkDDGdVYsSa2uB+PfXJx8XTiVAAewDA/JiciTHafOW4WYb2cMA0H4WzC6mMPDCEvv+H/cnPvY0lKaDLJrpE84NMF53Cm4KQpiM4KXEMl2plc28p8FSwIVn+ETw5JjNm8XBMYFn07HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNhLbNqr8rImvxMiXanvdmmAZV30VJ7soySP2ZAGCGI=;
 b=boFumQk/55akP/9uE7IuMzeT0wuenHRR94BqiNdiDcs2P9MvPtzMJTWHCGvZtLdhwZx62mybLY9C25/t5+OEaBLBwJRVeKoQv1sAo57RYy2FRMSR8CkfJkjnoQPTPg2rs3qzRFyC4TRQsCJdXjhXlODZy/j8MvAGszpz9bMuOTrhWUKWNp4m5bTcHpSI3NWOHMqeYMlExuoXSjQuyZtlxgcV6fgPIPjyC4l6InndkOT2B+QV9qj60GDXi/pqQq6Ux0L1YVmNyvbDR06S0da3HV1VxoBc8H5Asnxfio8m12LfdKTVImKipaPQ2sJ/CXOJI3341NYa6FX6d5dmOJsWIg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8488.namprd02.prod.outlook.com (2603:10b6:510:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 11 Jun
 2025 23:06:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 23:06:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 2/4] Drivers: hv: Use nested hypercall for post message
 and signal event
Thread-Topic: [PATCH 2/4] Drivers: hv: Use nested hypercall for post message
 and signal event
Thread-Index: AQHb2mKvSADQTAZvpUO5ZBh/YnZlk7P9YE0w
Date: Wed, 11 Jun 2025 23:06:51 +0000
Message-ID:
 <SN6PR02MB4157ECC740A762C9C3B9EA6AD475A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1749599526-19963-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1749599526-19963-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1749599526-19963-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8488:EE_
x-ms-office365-filtering-correlation-id: 0f831739-5ea2-4b3f-f0ab-08dda93ca666
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|461199028|41001999006|8060799009|15080799009|8062599006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+59DYkQuWz0Ht9g2C9ZVdlsgSzVdVYQ193IaHAv1yfupSDXtErEMVpn4i/Ny?=
 =?us-ascii?Q?zAmwo8dF70ufdy3VCaWCYdPa28mQo3/lLhb7nc8GbWMqQgXwoD/uknpVFrtd?=
 =?us-ascii?Q?HerSctxAUott2HEMG164SHtbQDzE9wrNWjT0ZXzZ651efl1W46H7A7m4OCVD?=
 =?us-ascii?Q?xIbAa6TiVzAB37/9gJGUlR1FybUVRXvSW2w0TcNaxaACG6KRUodShpVnwnk8?=
 =?us-ascii?Q?0Fd3q+H11695b+B/bIbMUn2gEkovOsRlp7Eho0NcHycWvjXtmkrk6mYA1rVC?=
 =?us-ascii?Q?KsoUo6hqxzsBjjQHhLN3+Lhpd9XZj5M/YmdW0cnVnw3YK1nDztv6kgcS5sa7?=
 =?us-ascii?Q?yvHaF8WPzb5fe3FvRpcYCz5JkBbbu9hTcsvyylAlw10KhRSwT/Nz8LzzxEd/?=
 =?us-ascii?Q?E0f72AJrSbcsmPbzrvtKOliWiLxzeXUvmxJJJSzCwa/QTgcLpknWXNCYcwkP?=
 =?us-ascii?Q?Xp0riG5heWQBbVeQ30gAuxUyXif/FhLZqRwThpISo62vaQAtlLwOG/ey5Vcz?=
 =?us-ascii?Q?6jnTpiuFt3HPt6i4zpxZzaQtkfLcf8V3Kkt45gt6q/LfxeLEXh1ae4Kr8m8P?=
 =?us-ascii?Q?kuLkshA1+0ot5JHBvYv8MdwbjttKBlmiXHFQrEvBwIZ6CREg1F4ocsYOaIKz?=
 =?us-ascii?Q?BNTTUucU9OFOW1fPJPXLeU++NNYkaM7O8IKtpWOh11l/mx9T7nFXe+/67vOu?=
 =?us-ascii?Q?nDaZtJeCpcDr+taGFVRe+J5quZt3np8Ci700ytqacqq4vL6mdpCwJBLcuyu4?=
 =?us-ascii?Q?V05HM00iM6paEPD3gREjcAX+4BOA9IBiCF0E8sAV/BaaqPGX3UHnhbFz9DUT?=
 =?us-ascii?Q?pCIk2z128P8PM6kYEIe57FUJwAMuSBezdYZGgJ/HMfoY+wSLNEU/G4j7ba7u?=
 =?us-ascii?Q?rcfMnTqo/PY5HPKIgeOLF4AU3iKGxOxO8INKHfMtDH/PF9f4dTOVfGPEAhuu?=
 =?us-ascii?Q?h67fo4llw2x1eAIqSlHVc5NR/bEVgvvuG2O/4zyxKkairxC9gX30R1XTZ6hY?=
 =?us-ascii?Q?GimlCXUocJrHN/jxwXoArLwcf9XBUuqv+zl6sZ0ReP3uGh7NKumB58Qy8pQI?=
 =?us-ascii?Q?3H39PngWjqwoWLn6taNo7vHk3DN2WNe6Joz5GWcUoHo5jyn+SEs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+C8WIZIW2OYvLHwoK553PGkhpiIGaIR+raRhZaLDILg0GGLSfalcBgpKyaqJ?=
 =?us-ascii?Q?HSrApuo5G3ySqEsvkxSNIujlQY2q7/4s04YJjGkgfZnnSYRZh52viyKyHesG?=
 =?us-ascii?Q?qCC3FGuktK2RM8m5CfWLZ6ikZOv4anh2H9aZH3dnDHMk++wdsfP/EUuyBUFC?=
 =?us-ascii?Q?r6Y3lI0+Wh1IS360MIFhqzuGhraUyLkhQBNK4iebnoXq8U4Syx2gpNjo1wem?=
 =?us-ascii?Q?k1mZYPcaBfGFMjBymHZ28mkBVLm9cb3+q2zM/HYAAk4BK7maL+sD0RaoxRti?=
 =?us-ascii?Q?dUi+4Xlbt98Q/dkEq4PlKsK8J9W7wyJtSYA3ahY/5HtTUwUEGFpgp6tZ3WxK?=
 =?us-ascii?Q?78ltok82jy0bB+gXBlaL7EMXaorD+8dKzPdEUljLl+X/53MqsQ6u+lQX0wDo?=
 =?us-ascii?Q?HTz8DG8KA4inD/huT03i0/TYbiXPRceo8Pr3JGm0cGULBoz48YNr9ZdJ+8cE?=
 =?us-ascii?Q?3KCtjmWcwxo9eh4XA6KokgxXkVf+Tpol4MmcIjKQQey0qsY8H7440gQZ8g34?=
 =?us-ascii?Q?BpL3aNYuPytkFY6z5m/xLcf4RijZFfqCQefzr4TxxixiKqMcODEcfAYnsKdj?=
 =?us-ascii?Q?o1a6zPmODJJ5GPLQUOo6vF/kIpLkINwaJeZgBSM36y1idNXmLeS94S4uM5iu?=
 =?us-ascii?Q?pZop8sIxRYDUmftfYBJxbaySNzUH8BWZZRJZmcbdnjNSoboLyW9us/UpdKxp?=
 =?us-ascii?Q?o2bm4reGIacAxmbHg+JS0YEsqV4xR0iWPLjtmxOeeMgggW8Yp2O4z554kGGP?=
 =?us-ascii?Q?t4QC/g1IsEiADIBsD5pZ/Js0i5k0IIhlzN+J6zoyTPBnGitYsA4mANT0HvV2?=
 =?us-ascii?Q?T3Wv/fW/GOeV9dNY/58841q4f4YsTneP6k+Ykz/HBRK1pSYMlVkvOY5xaU1s?=
 =?us-ascii?Q?w8rfnF6vPBdpzNOPmatgIIJudG/KhZ8ODcGh5/ogDsdVWNlnoNxeHNpt4oVS?=
 =?us-ascii?Q?4C/ENWj/QnVeOcuEDtG8kj9GO6jQ+GF+TuIQUWDXZueAPQl/AR2psju1koU5?=
 =?us-ascii?Q?1HmiU+Fd8lIYeyjKTGL6Z1eq2HNwyYioh3XD3v/+PoSvo+btayv9ihXtz/Qk?=
 =?us-ascii?Q?3BM+7kPYac232l31f4ZvRKCWouoqnAbZrYQqZvbfIAv1b0ihwvFQN8GsnQWx?=
 =?us-ascii?Q?BoorY1bAuv8Z+h63OV2hFwXJkIi4IreYZGn0GlmtVqONv12rVtm0HJhdHHtu?=
 =?us-ascii?Q?ZNG0QSNcUpFeGujBpxgS0i+XnlA8sOWgEtEV+9wYsv2Col8sBW5RDNPONp0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f831739-5ea2-4b3f-f0ab-08dda93ca666
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 23:06:51.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8488

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, June=
 10, 2025 4:52 PM
>=20
> When running nested, these hypercalls must be sent to the L0 hypervisor
> or vmbus will fail.

s/vmbus/VMBus/

>=20
> Add ARM64 stubs for the nested hypercall helpers to not break
> compilation (nested is still only supported in x86).
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/mshyperv.h | 10 ++++++++++
>  drivers/hv/connection.c           |  3 +++
>  drivers/hv/hv.c                   |  3 +++
>  3 files changed, 16 insertions(+)
>=20
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index b721d3134ab6..893d6a2e8dab 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -53,6 +53,16 @@ static inline u64 hv_get_non_nested_msr(unsigned int r=
eg)
>  	return hv_get_msr(reg);
>  }
>=20
> +static inline u64 hv_do_nested_hypercall(u64 control, void *input, void =
*output)
> +{
> +	return U64_MAX;
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall8(u64 control, u64 input1)
> +{
> +	return U64_MAX;
> +}

I think the definitions of hv_do_nested_hypercall() and
hv_do_fast_nested_hypercall8() are architecture independent. All
they do is add the HV_HYPERCALL_NESTED flag, which when
implemented for ARM64, will presumably be the same flag as
currently defined for x86.  As such, couldn't the definitions of
hv_do_nested_hypercall() and hv_do_fast_nested_hypercall8()
be moved to asm-generic/mshyperv.h? Then stubs would not
be needed for ARM64. These two functions would never be
called on ARM64 because hv_nested is never true on ARM64
(at least for now), but the code would compile. And if either
function was erroneously called on ARM64, presumably
Hyper-V would return an error because HV_HYPERCALL_NESTED
is set.

> +
>  /* SMCCC hypercall parameters */
>  #define HV_SMCCC_FUNC_NUMBER	1
>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..992022bc770c 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -518,6 +518,9 @@ void vmbus_set_event(struct vmbus_channel *channel)
>  					 channel->sig_event, 0);
>  		else
>  			WARN_ON_ONCE(1);
> +	} else if (hv_nested) {
> +		hv_do_fast_nested_hypercall8(HVCALL_SIGNAL_EVENT,
> +					     channel->sig_event);
>  	} else {
>  		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
>  	}
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..99b73e779bf0 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -84,6 +84,9 @@ int hv_post_message(union hv_connection_id connection_i=
d,
>  						   sizeof(*aligned_msg));
>  		else
>  			status =3D HV_STATUS_INVALID_PARAMETER;
> +	} else if (hv_nested) {
> +		status =3D hv_do_nested_hypercall(HVCALL_POST_MESSAGE,
> +						aligned_msg, NULL);
>  	} else {
>  		status =3D hv_do_hypercall(HVCALL_POST_MESSAGE,
>  					 aligned_msg, NULL);

Are HVCALL_SIGNAL_EVENT and HVCALL_POST_MESSAGE the only two
hypercalls that are ever expected to need a "nested" version? I'm
wondering if the function hv_do_nested_hypercall() and
hv_do_fast_nested_hypercall8() could be dropped entirely, and just
pass the first argument to hv_do_hypercall() or hv_do_fast_hypercall8()
as <hypercall_name> | HV_HYPERCALL_NESTED. For only two cases, a
little bit of open coding might be preferable to the overhead of defining
functions just to wrap the or'ing of HV_HYPERCALL_NESTED.=20

The code above could then look like:

	} else {
		u64 control =3D HVCALL_POST_MESSAGE;

		control |=3D hv_nested ? HV_HYPERCALL_NESTED : 0;
		status =3D hv_do_hypercall(control, aligned_msg, NULL);
	}

Again, ARM64 is implicitly handled because hv_nested is never set.

This is just a suggestion. It's motivated by the fact that we already have
three flavors of hypercall for HVCALL_SIGNAL_EVENT and
HVCALL_POST_MESSAGE, and I was looking for a way to avoid adding
a fourth flavor. But it's a marginal win, and if you prefer to keep the
inline functions, I'm OK with that.

Michael

