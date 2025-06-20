Return-Path: <linux-hyperv+bounces-5975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD511AE110B
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 04:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B1319E2502
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145373987D;
	Fri, 20 Jun 2025 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lJGzpQQO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2047.outbound.protection.outlook.com [40.92.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790128FD;
	Fri, 20 Jun 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385921; cv=fail; b=oCSbR+iisuTWNKYc6LENHUBTNbfXms5U1SaDcKrrTO2ZM/I9LxCaZRsf5s82XNrHa4zmYHWNKpRlaSetlSl59Bqwe+mMVdvacWJr5jIKfk1S7D8N/9oIUrbMBJfC6fN3XXN/FNKPnZhE+gcZT8AFYfWw7rP5EDF2s9hzoF+8OEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385921; c=relaxed/simple;
	bh=2eSJoMnCvu0uhlkhDiVpVc7XnrWR62iIjoXumfJdMw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qs0Z1mR+cQ2+2f5EKHmPBJzOU5PYsPvE9y69lAMZKXjCtwKB03tSLUqFpc/4INzbeZXQRuLtkkhCQoVhJZEDqlwo6LcMkH4r8lz5j4BZEtYUH+pLc/OpZLqlO2cmIs9UQYpGrgGColgZtTQQIGGBq1JGjYxvRoWr787p+TkBOac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lJGzpQQO; arc=fail smtp.client-ip=40.92.15.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7Pspg1IXrfNIUSAcH7X6BLw11F3TPho30Yz92/btCk5RPlTc2fThEkpKdt9AxudNP7DuQuZkprFoItW1B0RvyQao164kTrFtLq9vR3THw4bqxSXqFzxTmW6v2GJSC+FRyIDSyFvSEXp18XOZdLL4J1jE4eYKgRS0Neki5mcu8uVJfXPNXcmRtFjaVvHv5flOZieTVYsEsfv2F+7zKZQF3dNCzQtj/xcfUz9HBZFBUujBnveeu+mDG/fotXMJPob8lbE1vL94RqXCoQLyybymt49pw7SvLfx8myrD6sjUCAhG6xo2dUIR177KEU3Jnf2p/f7MZTYEx0KbS5SNqZ/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQjrOBLRIt4Cj/NzCcA/LvhVxWJcaT0MjgS2k/7iCCc=;
 b=YwHvaqtpLgeNQwyzYju+S3LXu5j9PVF6qM1m2Cgw36bnGmNQvESuSl6rDUsG14e0CUtYS57yWqs9En/SikSePxz0G4sYfZUNecnR7TMxOF5J3pFNe0jvpzF/GkN9o9IHDu4Cjfz76Oqc+V6jMoG3fukLv0fMBZdjZEk2eWi2yxAjs++45KNAxa30RWLVcT8nvM8qLFXAeoQKtDMjVyv3e+Vdc51I3GbTMLE0g/4+Ozj5uEepD2E8CyupVuN4CMHfgt0RewEkSKkESpWCVtaZBD3D2N8krHUBj/8IASKHkbtyMapehcMO/4EX6DL71xVgCvi6GLfWi38MXP1BjcIojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQjrOBLRIt4Cj/NzCcA/LvhVxWJcaT0MjgS2k/7iCCc=;
 b=lJGzpQQOh/MCkEAwNFTVf3Jb6XlmPllbJt/UsbWjkAH3wkDJCEIf0UoGSSw00zIdJvRFW1QuG0pThZGshgeSTHxs0wBM544feFy5csmzwbXRTslfV/gr7Q8Ea5ALw6J5N0nxIm8ZFX2bsvsCD7xLnJJu3N7OGFucRNQ45NMJOtM4ZvrWTP8eZHnL1FizKcXTv88aGDwBeDeIKf0p5oYD72HWPp1tLE9GJLPFB0kko0ozX1GzSrJOnI7a5bxvQmYZA2O/bMIh6wMsLEMO41cI/4ce4gxnwtBvDIogqvNIBXEgug+hGoWQU+r6MY5K5aBuuYD7WrSZcslc7q6ec3ukzA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8206.namprd02.prod.outlook.com (2603:10b6:408:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 02:18:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 02:18:36 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com"
	<Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch v2 4/4] x86/Hyper-V: Allow Hyper-V to inject Hyper-V
 vectors
Thread-Topic: [RFC Patch v2 4/4] x86/Hyper-V: Allow Hyper-V to inject Hyper-V
 vectors
Thread-Index: AQHb3FO6yJsKf14SXEiGwa3e+GKl57QKsxDg
Date: Fri, 20 Jun 2025 02:18:36 +0000
Message-ID:
 <SN6PR02MB41573966773A82329B36E879D47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250613110829.122371-1-ltykernel@gmail.com>
 <20250613110829.122371-5-ltykernel@gmail.com>
In-Reply-To: <20250613110829.122371-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8206:EE_
x-ms-office365-filtering-correlation-id: c4c45a1e-5e80-4a15-a668-08ddafa0c37f
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvg+tg/MNoCQ4s7gWjgMwzwclk15dKnb4H6eImdj4UkGY5TYBLC6cH31Uy47scHBxDdYVR76BjQb+srBZlIJuXL78S1IP5MFMJz2emX19PJ37ArfMnhKofA1RrHVuYDih7E1+A9JKlZQyVJ9eGtpvxSf75W6NYq27/FygGlePeeSJXS8ARmFa9hO+3z/mNau5U3miiH+7CL1/RYkqXqEdk921GIUvLUm0HHSh7fZYu/Wm9WbvM5+byCToL89Wk/VGp32wU0+A/2Iwnn2o8wyaAllRmVBqsxsnlPn09Ywx6VSYUB/qaW4cW/pcBN8E6M6Fci9o7prMqVohB0BoOabpDGgljoW9COWDc2O0QCJfAO3jX5qlJ7iSqOzdH7Eht4tnqp+aGBo7oxdz8yj+AJwr+d4Pj9iMX0Cw2GGUAfFhzRCmjFXif5NbahtmUhpAGie2SCkE5+gsbV/TEGo2yhesa8EkGXh1l0Fwn42Q+FVkr2cNXzpFwHbhiPRBRuN3U6FYxtSFJN0fMVfNqwcWejEaesGi8x09NDH7R3uTFcIiCEFafDs+E+2HOtO3hcHgYnn9511NbV664Lm8y/lEwt3rfhKidT/BH6wA1WKmbXrwLNrKSGGWOb3FCFlR6tszj185Qy6YD+l0w/YQmEmONs9/GEcPR/gDXOPpEbNP3bN87WasYyx938djYnHVKFxUkhkxdBMdHSK0FZBnOVA43CwA0rOSqwpz5QbSxfr8TKOhBvEhFnuFQveaBq9UXiQJcgZrCGwcEyn/Yefks5ahXXN/Yq
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|15080799009|461199028|19110799006|8062599006|41001999006|102099032|3412199025|40105399003|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gBVFDmnM20MErNUnhN1BTqOaAq26nVS4W8laUDdaMcC1o58AbCBXliaZR9/j?=
 =?us-ascii?Q?u5JnwzsFiD7O+OLugJ7t5L9lysCI7iA8aAy1kTsddcVZFu80KNVT13JvGNYl?=
 =?us-ascii?Q?6ZSrZHVXDDuHvIcb4yXSJSVdQdG+TBJ7hpPfk0ATMHVxb0RhnTtY8JPBY8+R?=
 =?us-ascii?Q?P6lvEEqBK74NCycPRPDQ4zsLMDShjz1zqd80PBUjkaJFueHbOXoT8w6ciB3J?=
 =?us-ascii?Q?QFpUtAi7ymsn3DCMymUVqDVTM9gVqnIFHTCaBOXfjoOkVa42N9y234ua8p++?=
 =?us-ascii?Q?tGAk+cXvn9LxP2QfzEFlI5s9E6ytEMP7yk8y2GASze8lhU6Dj+wr2i6dVXXw?=
 =?us-ascii?Q?MD2AjJH0bp0jeH/qUKtBROJhhBDhCMbCEu62c1F/33eOar8ZCly0G+hrOSOq?=
 =?us-ascii?Q?7ilhlMue11PVLVUcGcaGcLLxhZh1RLxL1YFlB0i+iAGc/ngNh2Mg0Y6dCcU2?=
 =?us-ascii?Q?F/+oowwmKvW3/qwLZ6/kesRu7Ww+dPzhkpOlU/VFWTGmhphSa/YHo7yF5Hpz?=
 =?us-ascii?Q?xp9EXKlPzhjIa4SJfINBOLtCImBpWck5LjinvAZCuz6h6D2VkmPUuGoq7PD2?=
 =?us-ascii?Q?rYNNWtGAV2MOmGMELWVWUTyc1tYh8LeJocTiGqfxWeW5NOjLETSMJYAPJcnQ?=
 =?us-ascii?Q?dfm1LxAs/K8kwBGAulDgN+pRGLa4ZgPkonKrLmUIJhmmaHW3D6YVlDerL+6q?=
 =?us-ascii?Q?QcqrGVKPBlgpmCr/O1xZaXoccyAlbYSZZKWHQATeof6sX1C39TiH35rKYKzR?=
 =?us-ascii?Q?sboTP2HW19mJGmo9TFPpiktMdCWxRgrB648Q/br7Jke3cDxEzCzT2Fl0xqxP?=
 =?us-ascii?Q?gqUagyqDwEnsie2lkMw593c9A4OEbTDbOkLlOVyheEAuVTjJS/C3T9BVOJJ7?=
 =?us-ascii?Q?gzufzoWsT0e5G99sicOt61bPmof6awWKnAJ4SZNjPAOlGAQRg6eBG8TBYyya?=
 =?us-ascii?Q?6gB/BxDTv2BlUkdlDGsWuoKMKOwKotpxAsuyHIVhfiQ/h9KayvntOWwEwGgN?=
 =?us-ascii?Q?VLd1RHlpmaZWzo4tcUMFnF2WpJZFkTBMLSPknRjpoD8y3L1vPHCPqLFdI5Lm?=
 =?us-ascii?Q?A8IxvHb45Y8UWaJp8TabUop46JImO7XKTuVDAXKy7jDQy9EQFgnrRv+be8hx?=
 =?us-ascii?Q?Ahp/68vW4Myo2jm0WdnTDLwIO3u9knqAyQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cqgl7eo5DD5mhoEaof7/Mw9PBtpapacQ0DLpNkY44t/mnZUUK+5XbAV7FnIx?=
 =?us-ascii?Q?6AsLXwNY6JTbRwmQci4VW9jhg7AH9cHpbVGoXsjq+iu2jjkRv5k6uY2bsuV/?=
 =?us-ascii?Q?5VEJNyK+n1imS5amVUq+bhwqnz+S4WTAzV4fGiHjYvh1VMYk0oWbwqQaTI/e?=
 =?us-ascii?Q?15ROKeb8IIBRB1UPL68OGLhCdK9z+GVXuNMegha+ir3WenDNgFqbNIp8oPrh?=
 =?us-ascii?Q?lrSYINm44Ogv4swckA82fWrzydL+K8y0W+x6TA5cKtRVTwdme5pTdYZDDFrZ?=
 =?us-ascii?Q?4M79KNYYkqehFnP5JmPCYAsByZrUF5eIvxX8FLRKXJuUzk9uHBUtmy6CiZgG?=
 =?us-ascii?Q?TuTDrW14ofVUB9pwFVo9D7hvSR1sCPEmJLpdwWRCoJtK1qKQhQajMPL1gPk8?=
 =?us-ascii?Q?DAQG4MO6GaTwpnCyzUeBGfzlY+oywgbrmuA82x4RSzaFm/epjNkkPY99ks4H?=
 =?us-ascii?Q?9mLakH0UTTOMLK79/IAVRppWute1GQwy8K9+7KLmgatEiK3UqUIeEvf0gM1v?=
 =?us-ascii?Q?+sgc44bx7bT4KrYTECMbI/77sRvQuT6nYFPUVHrOUgI89DG8qJz0vRXMx5Wt?=
 =?us-ascii?Q?WaOdv4EdFmPlcmMyRzjQbZL9gtjjXfYHcT59EaIkh+m3jlNJsAXUS9Qo7cFN?=
 =?us-ascii?Q?yc3TEy4F32VQ7SDLqeVQbuD18S5vKUAfr+FC/iaNH8QItML83IWXI6cVr6w7?=
 =?us-ascii?Q?abUOw02yWSWdS0gv6KG7D1VZ55u/Cx0fnxTQysXrxBh1WGpq7eaV0yZfMhkA?=
 =?us-ascii?Q?Uzn8GytJ6CDTYDQkpujS2VUbL8YXRznzWZRm8stbYxyvV5oIbjEBp63jT+Bo?=
 =?us-ascii?Q?oVps+pN2VaKwlnm+Meqh/ziGfepibaqkuU5GoA9PTQdXN77IhTBVYSaTR9HX?=
 =?us-ascii?Q?bPcA9LIDFPTFIN2YIcLS5eVwIGpHPak4GIyC+mAVxsHEe/Km0CBIC6D6N7Oj?=
 =?us-ascii?Q?lqbr6A8/ffjz7PA+wwDTM3rG2akMNApzLNSZralGAA1DcCsIZqI2tvmtiJhL?=
 =?us-ascii?Q?IFXErg58bIvFzApyFX2pNPPhFrBP6HVr22hYublhqOaHfZg3OXON1nE/Vqi7?=
 =?us-ascii?Q?9i+WDOiSxqnJLpzp6SVTxNKbOOIRS4gUqFcT9SSyKguz0Ia7dh6tnRLI+mgg?=
 =?us-ascii?Q?BWUEh08mcQCVYn+oy8FV0VA8RRojlxXYPBXFammkFCxiL4Ny3iiEsaEW/4Rq?=
 =?us-ascii?Q?ixFbhi7qQ9ao7uTlMvWEKOcM6EyZPBzbsZMKFUIuPPLGQctDVE5HBG6IEyA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c45a1e-5e80-4a15-a668-08ddafa0c37f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 02:18:36.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8206

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, June 13, 2025 4:08 AM
>=20
> From: Tianyu Lan <tiala@microsoft.com>

Suggested patch Subject line:

x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts

>=20
> When Secure AVIC is enabled, call Secure AVIC
> function to allow Hyper-V to inject STIMER0 interrupt.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3d1d3547095a..3b99fffb9ffd 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -132,6 +132,10 @@ static int hv_cpu_init(unsigned int cpu)
>  		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  	}
>=20
> +	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
> +	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
> +		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
> +

Should hv_cpu_die() disable the vector so that there is symmetry?

>  	return hyperv_init_ghcb();
>  }
>=20
> --
> 2.25.1
>=20


