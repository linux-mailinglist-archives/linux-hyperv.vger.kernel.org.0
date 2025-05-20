Return-Path: <linux-hyperv+bounces-5564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED2ABCC5E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 03:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC713A4A2A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3D253F35;
	Tue, 20 May 2025 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jdx4qLPf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010010.outbound.protection.outlook.com [52.103.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0908AD4B;
	Tue, 20 May 2025 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704908; cv=fail; b=gzDi0tsXEcJ0qVUqF7fFRB+gnCcgpVM8VJ9BF1tm17FD6ywFhap/s/h8JBAxEkFh3E+Sd7suyLPESKsBZTd4icLSXcwBkyRnvT/gsb9xhM/xkJ0VRNbBu61OwdTGrZMesWM0209WWEtOD7dLVOPA5SHzjaVTmep1jHZtoah1qHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704908; c=relaxed/simple;
	bh=Jwhq9S/TVgBYRdJO84Cr7pKsrGJHWwpGxPieoFi26FM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgBbkMMIrRhznkeIG8kmKT6dkFbsXjjkI4hkviPMREWUwLvlHV1FG8poAEstIbvpRNmuc0azEwKAArbEfIS6KX1VdsSqO/f/dBZRZz6vku1B2vo4IW2RmWu8MM35bMOBFznXFSQ+hPv73Y+HdHnCMHd1ZjweQR3wrAYMzmYr3gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jdx4qLPf; arc=fail smtp.client-ip=52.103.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crU9YUhuyujGLV7xziks4MPCYlrnzgvrDerINIM2/XS7MEuxw/vACPWfXMqLgOm9xy1gm5tyfFR+68YO8aqdqnsgm26zqMjyj6jIH36vVAsXOOWe4JUyWCEbKD1JALhp3KEijlRMelHwFb7PeIKxUfnFt5N12O+DxPo8Ra/XZ2aveqhcRcPDIuvToRhwjP3EegSHtIidoobdRNoJFfvhtExFuBEHM2I0l/zKqyVGOEGGIhy7d9jQ/0VQPJTdrjLq6NC2LY5ETNiSLLvNLi6jVeYh+oa9F6pvaQkE92KPIXVe8n25D9H3cCgEzgkuqDVSFpwwuQTKK8zGEBHHNGRlMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saTKPlsqd7Se3tjozBZJaAQhNDonJtdwHBY9qI8eYEE=;
 b=YSmXee5Z5VR7D+N+0By0FaFtxPAotuvWKEjRycm2QaOJ2RvjFvEy70FwNVQDxase3txd9oLOazWk3bE43LolyLXJwwEXViZcirtDt94xM3YF4mlp06mg4oRKez1j8jcJYbyS+ILW8DaOyVnag/4VBT/08njrtJvYTblVfe3v5ewq+q5sa29+jci9EBIjktyxS4kQlofUZ/aSxlQ4tyqMSnp600v92FESokRg+lqLYO/MV96jSo+9OcWPzi6sGqFgoxCADYmwAQssxm9NxBNraeJgEqA/KvEwKSuzTtlIcPS9iITy5UttybjRdiNKi7ub/YR1Lhj+Lz3VSMhukQ3csQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saTKPlsqd7Se3tjozBZJaAQhNDonJtdwHBY9qI8eYEE=;
 b=Jdx4qLPfsvyA3VJfm56OvSRXzD5NMZRIPDPmiZ1d7xUyzdYEnaTDSbwhmzhcwexE++EV7PXu0XeZ/0E+EhSw3fLeOhcPGwMZYBPrFsesQjRAH9Vs0l0JwAVX3Ion8WMqzkqcmIxTFc1teIigBbqLyf7kvU4VronFo+yETmqtHkeceo3hnJlqFK5tL4E3000VMPsKpu96WIVkyBN1CitgwpNo5RNYSR1+xvyfLBy0iGhijVSxVGfCE1ZE705x8jkV488YeBKAFVN/5wWEM7XnO8vSjDdN7nhdggV14Jzfd+IIFPuGJQxtWOS8JgvuMUiLjOgsuci9lxgsOaSO9wsYGA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 01:35:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 01:35:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: RE: [PATCH v3 13/13] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Thread-Topic: [PATCH v3 13/13] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Thread-Index: AQHbvF8Dz567Ty+PMEadp9diz7En47Pa1clQ
Date: Tue, 20 May 2025 01:35:02 +0000
Message-ID:
 <SN6PR02MB4157F93812247213DFA922ECD49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-14-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-14-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7044:EE_
x-ms-office365-filtering-correlation-id: 27e47666-2a76-4150-259c-08dd973e8ae1
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQlVobdhjoRt/HQUSkoYJhJhIjBQpSR8Kc0oy9Xb6zl/PHnLS87DNiVrOnxk0kUcqb2+BmDdNoEvfAVfrV0Tb5OtgeXzi7FHEMknpROzxdPDHdlEuQpsHydeVTgz27+ALnx5szb3RAsF5G+BwnVQkjyHsGWI2xqLnEqBhr+3s6eTAwdMCrTERRIvi0ibadcZ2yex2uOmSNu4kcwD3VvtBJmw+UgofIW7bcotLsfyMu/QpOh4G2SGn+hZqBk/59mL2WtFifcj5eoN/ERYtKUFtAyfTUjiaZb6KSF128zODW/yW7KAlmVeKcLvwAaYoVTU4QqS9JDaS0c89Nk6UuYs5dYkJOfmB0P1IBkulW0BnLe8QxB4xxPkbC74GYWsGgWGjNsPxoJKz+NPk3sAWGIJy8KFGzqvkjVn342xwoZCs+VeEr+eEmp8vdG1vYTNmkr4YThNHRCCh1RDOOCME4l1DiYjSYtSusyCgumVuesnYh8ytGaRkxtrZuPdd2nPSQ31l74gqElTlytOg9+zw8k2JfzfNaRvbXUvEF2eaK5QQRkVaVVxHC9TpaGqQzACirQawWOosBoPjxH9S4a9aRh0UCMgoXClR0e9iOetnPlQwz8cv+JW/xzyAGMzhyjqOVxEOeW8ETl7lbaF7kZu3685wB6I2fbwn43CnjSILj8G8IgqcDRxPMZjCWkpxDQWLrYlveLkYnp9Ez4TbEE8V10qtDMkgqGYylkCvfw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8060799009|461199028|19110799006|12121999007|15080799009|8062599006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fl0LUaS7h/1Xq+JlAinkII9AcHMcrp2M52VYgFUbx6qSGbWXn3wNKotHOqrd?=
 =?us-ascii?Q?Yu7dl5fSM4lZIJuczNcGmVl1+GnWfy5udxoVartVeTT1aoYVQxMHMsjF9R2x?=
 =?us-ascii?Q?Gp93nppXz/dE+ATSaQVLITnAYrlmhjXqk9ZQzuL1wOnD3mnGmjIt4SkTsdkm?=
 =?us-ascii?Q?xlmwjFspN1qW7JTLQxv9aTylYUEYHjHPH6ET6HKjlwjNB1DsYchzlgPRNqMb?=
 =?us-ascii?Q?YPblHnOeKh/ZHtow6AqEhpCLTNnk0OcOvqzffDApdEvjCeSJI59l/zgORtCz?=
 =?us-ascii?Q?n9ehyrPtkBgi0kNHS+cL9IprgfCj/eJ7VDRHB7xYkxeIgvpjWaZ7QEvNwzbs?=
 =?us-ascii?Q?6OBwOxDjdGbw+XUD0V6e6F9swWxkSYyHfO9GQb5MtS863govoc1CstMPZj82?=
 =?us-ascii?Q?pyq+jOekF7S/1yaSbyvGALoPvG3tbeilNjL4dGbc2Srydmzj4XH8TZr6S6bi?=
 =?us-ascii?Q?Knri8//oLZa2O7sqdYVkU1Cg4dLhO8wYadknshAulzH4XqHwuo7Ol+zO8B/3?=
 =?us-ascii?Q?16SyT5LqNpTEFXbUxvLp+HmxXlAC1WPlgrwuJEK0F16NdvurIPCtm/YAEaYq?=
 =?us-ascii?Q?J6Lko19b2VHkKObLZEqUjghOb7rOogcn/qWfHqQIU/aUNXnObKJaQsC5/Qtb?=
 =?us-ascii?Q?itrLQcx+F8syYpzb6il17HjzO/Ms5ydctazSOSrOWi7Vp5M34KgHWlq4fhve?=
 =?us-ascii?Q?AAcFWhd+n8wp8+KEQ/227K2JjO9PvFCQoBgLwfti7vvmS34xC5xnKzVX6NE0?=
 =?us-ascii?Q?2pFtt/p4VggXYYbFxtZSxeN4tKSx1ekU3t5/kmkvOBdRXeWWokbQsEoaVUTa?=
 =?us-ascii?Q?Sxhmd7PDcVGERmm0WSFTTP+gJo94xEMg/Ysd314kW7BOEcv/AjrscVneNhCz?=
 =?us-ascii?Q?xHRy1pb146cRivnCvPHBvJjUwOB0uIsrfHweWCQPzRvpTQk/HsYwj4pbCazT?=
 =?us-ascii?Q?51jDcKrVNb1ocWPg53bUTwAyVMvI3Sop9lUCzW15iFBPeB2NoEL4y7yVoY0j?=
 =?us-ascii?Q?tuXZFjLMznAQOdFon2yp488mUVniVAT/YKEFRgPyNkADJ4X8F0lKGDbbmF3j?=
 =?us-ascii?Q?JIXlwe7KXc8FQiavvPp7IVkf2TcD60WJUEuQKVSRELLdAVYDVGfGcWXbA5gK?=
 =?us-ascii?Q?epA+pNOEbvSt1dA+J4gymGyQzV284YppQQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VR1ac+sk7eDCoY2jinmBhyPUf2VxcMZyujvIoTeFKOxaPaHI/nuIFWZR9UTZ?=
 =?us-ascii?Q?RKRAcwdPNjGCGjlFd7Nftg5knVqV+2nrEVBgNI8FtRJgFQUA83uDkeeLhzAI?=
 =?us-ascii?Q?UgzyOIc/MtRWuMCly83Bal7HKwu80adRAdcMIQESZRbZcyDCVEJZfUw889aX?=
 =?us-ascii?Q?Db8VOnDmswpslLJXirDOmmL+hCj/bZTzqrE5z/zvX9CZcwY1tXQspnfrvUM9?=
 =?us-ascii?Q?qvKEp25WMBS3fYVth/EJa/cxb2fNjwFgYs4PbxjEJBatfIhjOUA/TRQhLfIt?=
 =?us-ascii?Q?VxMSJWsVjOTQDvJEJmBoURMbl+3+nFktqvbvAsoF8QMN59u2hqRDwE0bRxVg?=
 =?us-ascii?Q?EDpeMGD6UtdwgevI+gSew8WZxm0/dLTD2zakZSnXaAJHn7NbbVCM2REdXiyV?=
 =?us-ascii?Q?vWdBv8ASU21bkWHzIFkRsTi633r8wo0Eyvg06vs2XWv3+Pt7xCsge8Thsq8h?=
 =?us-ascii?Q?dDuMUZzsVDFO06NQiO6rQHoHE/MxD02pz3W9E1D6kgJKXuF0/qQYWbkqBhoy?=
 =?us-ascii?Q?EOfPtuMrQm0eCOQCTFJ9hAFxHyzRrSUq+YCjqQjgLL6052ekZAyznkcbfMDO?=
 =?us-ascii?Q?olcx+x8MWOqlEE1VSJ9ryGONU+HuitMEGnc94Kjn1Khz3zWBwR+kO61rIF0c?=
 =?us-ascii?Q?lZeB2o0S4Rr+p19+fvN0lTr1BhjtSNrpQvxHBHoYZ7IBfg3kHs/MNk0fthsy?=
 =?us-ascii?Q?1kQ+CqD5/xTiOS437K5kXG/fTrVwyRp8FBF8FYrJYZEb2dof712RPJlWqBv6?=
 =?us-ascii?Q?pJzuLy6zuDv+4kliPcrV41sEgK3GE2fJqqrD+1fZB1j8c7Km1syMKD+r/qLU?=
 =?us-ascii?Q?owDGgvEwja6giOzEoOlXJPLplHJI0S6XxXEnkVqUk1UFjhD3I6wSLd6Qj2BB?=
 =?us-ascii?Q?eLLIa9E6DzLwIfgIF8OoDo2kSGWbHySD1D6inzyt5GcTMhCzthHhkxKx49Iu?=
 =?us-ascii?Q?xPMNQC6/EhtdwOw0ueD8uPe1spzX8Y592KQ6JQbh2g7Dv2QzymiZiBp3/7tt?=
 =?us-ascii?Q?83Y9Vnu0rYWxszex++4rNotYk/HhXDWMGU1H3ropCKjUFTfPlYqjYs4J24c8?=
 =?us-ascii?Q?m6etvPH/9mBAhjaMg4F79n34YVVH808+vQf2xcTRfAZVd3zczyrwYwaP4kG2?=
 =?us-ascii?Q?FeQB0ZdJuq1BY1IXybimQrEl0sXf/r8Zpvee65jM/Z2mspzNjwumYXKu+zbN?=
 =?us-ascii?Q?PhtWGjhUwG9gxnoN5XhOrtkLWb9KKBwiC7NNmpu/0Srv6sJKVmbuAneUzzQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e47666-2a76-4150-259c-08dd973e8ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:35:02.9670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> Sent: Saturday, =
May 3, 2025 12:15 PM
>=20
> The hypervisor is an untrusted entity for TDX guests. It cannot be used
> to boot secondary CPUs. The function hv_vtl_wakeup_secondary_cpu() cannot
> be used.
>=20
> Instead, the virtual firmware boots the secondary CPUs and places them in
> a state to transfer control to the kernel using the wakeup mailbox.
>=20
> The kernel updates the APIC callback wakeup_secondary_cpu_64() to use
> the mailbox if detected early during boot (enumerated via either an ACPI
> table or a DeviceTree node).
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Unconditionally use the wakeup mailbox in a TDX confidential VM.
>    (Michael).
>  - Edited the commit message for clarity.
>=20
> Changes since v1:
>  - None
> ---
>  arch/x86/hyperv/hv_vtl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index cd48bedd21f0..30a5a0c156c1 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -299,7 +299,15 @@ int __init hv_vtl_early_init(void)
>  		panic("XSAVE has to be disabled as it is not supported by this module.=
\n"
>  			  "Please add 'noxsave' to the kernel command line.\n");
>=20
> -	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_c=
pu);
> +	/*
> +	 * TDX confidential VMs do not trust the hypervisor and cannot use it t=
o
> +	 * boot secondary CPUs. Instead, they will be booted using the wakeup
> +	 * mailbox if detected during boot. See setup_arch().
> +	 *
> +	 * There is no paravisor present if we are here.
> +	 */
> +	if (!hv_isolation_type_tdx())
> +		apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_=
cpu);
>=20
>  	return 0;
>  }
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

