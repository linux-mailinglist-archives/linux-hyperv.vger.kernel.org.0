Return-Path: <linux-hyperv+bounces-5560-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C7ABCC4A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 03:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310A53A88CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 01:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E662550B2;
	Tue, 20 May 2025 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JYFahXKc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2052.outbound.protection.outlook.com [40.92.19.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D32254862;
	Tue, 20 May 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704639; cv=fail; b=dq0Qsvl341Ldgjp9NdlQ6i0X1fpzL2ypjxeOFYRTTd2c8IysBpEFcnKRxl8A//O5CxShTqeXBcDvFBAwisutuxpusuSw+yoITwZ2UxNBZuc+hTHanFp3vl0VYhU2WopzNY/cIgvBseMh25osQVuHakH9AsiRQaKFZCmqn/5hPec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704639; c=relaxed/simple;
	bh=UCAfhhllTKdvfUw1+29i/Tm8IZVXm5v9ff1y8FGjATc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fuvT0D2wEgxj0lryxFLh5znfRDRWi+AnqyMYXiNAH7JokdBa6/sYb0dey1nrdp9YE4QOS+ZXEUyF5ogXRaWZrj8F5Jl5TFrtTq16FpzFl8EyEQOH8sPr5fwTXsS2Xcuv7YNM1mXKVe9lUwvSeNjzzpH6XzuZ0jGS9c7/nOyF554=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JYFahXKc; arc=fail smtp.client-ip=40.92.19.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llBcw2lGO9flBbIvvf1ajqJfzwslBMk3HiSQQDqp6aXikACGtDSYLiug9yF7cEtE1foyMOhaL/At2PIdXQWZiSKoU1RwPjCFsy+KJGNfdf6mg1weQykPjFSZQ6ozn7UHaJ89rQarxvovyaArbRe+BTimOyv3SiOdmARXuY8GHUOb8ygEGtvKHd39940hMsZQhikA8Y1zKoc2aT4nhr66t32a06vut4XfnjpBLRGLUoYSHf8S5S5U2Mwxxa8ELv0XMD8TJFSb45bfZTXCoOoVVeG+q8PSrVUumyMZIobOETDjg87EDQBG4MfENK4LOWHeMbZZYS8n97m/dD+VdguuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qPlNTVLqRHc6K8nWyyWb22comJgPsfBL1KcbYrpoK0=;
 b=qwJtyJ8Rr+ixCZr/KTLAAHaAV7+GHidfX1KiZpUqPgfKUtQrKKpS2gEaaVf2KN7MtuKfXGUtsTvsPjQR+QzDv0twkadjfZc5PkmeMkPduubmEoO2N+7ekkAILgacxCSXuD2jfh5Ds6mz89f4L7FrUgDaGKDAZR5kUAiYEjhXaH+0pGBX2NrIuKeBCbXA5naOepHXBx4Yb8SjlHDwjAyxjZ+uNZI32dXOkf9/Ky4LCJSAORbyHu3/gEPocWcso7eZ764rrfWx7ItxoNlZ4FGQHV4ADTHNAhZvtNREgSIW+3FSPPXE3uvXl9giIo99Cssd8Bupg9NG6OE+sfPX1T01WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qPlNTVLqRHc6K8nWyyWb22comJgPsfBL1KcbYrpoK0=;
 b=JYFahXKcVoInB8UyptPtmsRq+8F8a48QEwtQJSx6HlKaPfTHyqCz7J3yNH/rPoqhtEX7H4+F4Nla5lJ5BBd+Q3JR3gs2rYSLauY5ywJ4sC0Poo0RYREGS/wWdMzg7O0jFOiAotBq3MmgoV72/MjUFIAODqUAo/r8HHC90mPF9m3VQM3oft1ytcSIzHB0mPulO/XzNEHOENx7gRntK2QmamO2UnAzI1+q0t3Gy+9sdOqNDOo/M4qyFuhjOpY0hfb30qGj1eTojYobFOjgZDrcBVPdIhqnRSFMWumKYL98MNRjFLircU2Ofyct7XofyH5jYBg06vqwL2GX8gBhnnBiIg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6735.namprd02.prod.outlook.com (2603:10b6:208:1d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 01:30:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 01:30:34 +0000
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
Subject: RE: [PATCH v3 09/13] x86/realmode: Make the location of the
 trampoline configurable
Thread-Topic: [PATCH v3 09/13] x86/realmode: Make the location of the
 trampoline configurable
Thread-Index: AQHbvF8B167Wsf+rMkSCm0MmFE/4aLPa0xQg
Date: Tue, 20 May 2025 01:30:33 +0000
Message-ID:
 <SN6PR02MB4157B62D4DAB55DBFDB72315D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-10-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-10-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6735:EE_
x-ms-office365-filtering-correlation-id: 9c7da805-d9e6-46fa-1760-08dd973dea7a
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j28Dg8hDNbkP9M7l+NSvtbXKZ1t6tqR8fkA+hM6LaU//1DXxz6AHs0CxSHtwAo4sV/lq4iqaGr6p9g+YDKlSyH6YjhHF+lagkieK3D+dFZOaaiXV6GtksVA5qNcAxeUYtEsWj0oC868wGbbUfeYdaerOyeMt5dg5ZpogHPWp/sxGd4Id7JYvQUIxLSj+/X2sK/0uu3HgRMZeKUWuWE+r5LaQ6/VlVg6Emh7Ej0DkmpgTx0duJ//dV3LEKndRu8x2r28KJnCGXfDphFkM92WZJbcS0gjuVs7WKAAyq1jOqOGjOMboq0HJ4FKPe98iLR7V7yCZAzG47mOgopxluDwM4NqnhSDeKNADVmNDQo82NuXMTfvxo6lQ1C9+ZIPdE+h/eHDilWXbK5LRRoTPNJjpBxalTcRyrb4PenZ7FYoJeWYt5+S/IKn2ckxCeHADWJeqj+l2zRU5bIcCu4uHPWuFH2/UdNCnVZ62BCdQhW6ECMC9C350mceWoI/n3c2LnrEV7VKJ+wKCXTew5n/K4b7Eeu1qP9RV8jKHW0iVtoVmNuu6N2/vMw0xatcAvJr4kh8I46V1DgFFV274MihA7LXJwEEMDyeG/g3C4v2fETSVt3Jp+7Ng9wx93UWR2qZWvTLvpaaZHIJDi49Y50x7JQFWns4n7YJ2MrZfxFqNYfynU7/awegRFTQix2LUdKFFRMVm+yy7NFEsLpkVtykZLeAimOTTfaNcInNrvvPI1XkExesqsMRnUd3a7A4GN7xNyZe1zcHXgwValjqR1Rf8REaQJBlmNPcv9WsJ31aEIuzhSQHeFSHnrT+Htwnd
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599006|19110799006|15080799009|8060799009|461199028|3412199025|4302099013|440099028|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zH0IQpCaODDExoNpsBWxeHFTTYJxI5+owBQdX1ETOWYXY7m9EKwTadn2hHpk?=
 =?us-ascii?Q?PKntco4sbMM4IOJntJZ/cmE7Y+yaC73qyE1t90/IuHiW5P8rjZtpdjPMnw0C?=
 =?us-ascii?Q?pxg49nc/+pfSI6qWUR/MUYNF/IqDCxsfatw/hTEHRd3Zrc78SA5t8dFIoDyp?=
 =?us-ascii?Q?aLQYJE3blu2STzKy38MDCM3xiH5kFQnXlYPQNrhb9/u0gZts78DcI2gSJSiP?=
 =?us-ascii?Q?xUcJVqAdTDAvPhMAtq1jqY6f8uUX6l4f2w2WSEifflyGipKGZKNypReb7P3J?=
 =?us-ascii?Q?uOl9LWI7oYhEsiUWn1YjXTHtD8dLwypeHVJ+NlUyX3MH5JtwyJMA1mv2kIDt?=
 =?us-ascii?Q?lliwnHvWP7WSc4lGb6XRtRWitjE3BaY2dd+8K6btGyEJpO0OVnRJJMMos6dv?=
 =?us-ascii?Q?P++ftEYjVcbZ//YWgj/5FaF0wjaxZuuS11C1gWkz2ZZAj92G+EVYUf2HKret?=
 =?us-ascii?Q?utK8ejz7V3W9FRpn0D2c5a58d5QUAtCpCwq6cU9eEcxiGzvfVarCWzXnksHs?=
 =?us-ascii?Q?+Yhcx8k9HYNzAiktvFjk72kA2IgGYGyc6Y3irv8G4BNDRO2QcPfmwh96nflt?=
 =?us-ascii?Q?qzCFpTRNUmXXUlt702Ca13uL/CoR1KYBdGFwsgslZVnUYZwbAjGtu2cFcdRK?=
 =?us-ascii?Q?brPlOU1vpdoTzWWELvbn6M8yfMauK6heXqPcRQuQKpa379DPQ8kdNN6N9gGA?=
 =?us-ascii?Q?dI8htPISCjtDDch8QTRFerg/PzgKUeZbAAJZbtuyqzGnjPOYvpKyNc7DfeQ+?=
 =?us-ascii?Q?d2qzC0xIvcB+pi2Ux7uWkuLAcwcsexOVE8RhQxO/hDShc+S9TbgO5iz0+b4K?=
 =?us-ascii?Q?7SuzLE8Rn0PZqtkITwQBQQpS1xY0nEP9pSfjEPvSEVL0f+3tXfpRH6FLgJCk?=
 =?us-ascii?Q?Z1/jHqEQD26Sp89k/3C2Rii9oXT3E50858a/afbbhEbG13I6lsxMeLtBF+nd?=
 =?us-ascii?Q?GCuZ81xE5dRwvSZ6Py5SaZhMJJ/oPsN014fAOF/i56zct5FMfG8hOllWp+g3?=
 =?us-ascii?Q?SodcDcWGbQsQn00sdUKBnPtqaLh1vJ78UL5uu3ZA8M94dCOtE+MhyFFPScF+?=
 =?us-ascii?Q?1TuJxj8x11VyomyxryR9IdLTFh2Hvr+mE5R4AsZ54zQmYfgpgKZHvNiRqoL3?=
 =?us-ascii?Q?VV0KsZD5OzEKhDZdc5HNoegZ/cEsw6PjJ2n5HWuS8im0MyxqCXm9/1mluTxS?=
 =?us-ascii?Q?F64qHmDej9sQrsIBGkdgd71BEaBep6o6df/Kodbt18c7RFv8UYV64RhCORM?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Axeh2VF+caz4DEPWVKMetlcpKdOljLXRNr4cvOfCmBfDZOJcDqp14tJQns3N?=
 =?us-ascii?Q?QOV89DrHQuCvwf05iqujqY2lyzjWNasyHV22WLPq3XcOlAuZCyyFA05xkClE?=
 =?us-ascii?Q?JR80xDXKz8aDSsBkLUvNBwi52Q6fEjmpu/8XhmtfGZhY9PuoLrohDTetpAQ8?=
 =?us-ascii?Q?fmLskl+xqfHbUjnW3nv/LWEZ/rRZrGSlTawNPkbT8dQRmWU0cI1pLrRrrQEc?=
 =?us-ascii?Q?xr7+Nb5u61swlyjL4JxA/mB0zx+xZWMZFSb9Cjcgt+yzPBCTmJJLLrRodbpV?=
 =?us-ascii?Q?WWyVLMFwfXAehNooVsBFzCsGFMicGgAWYH7HL+xjePPfXmyVxkQAnlkZ1P5Y?=
 =?us-ascii?Q?1Sls+ZtyMKUoHq5x6nwEZcCYSnpwG1j1cYXiSvFL+eql88N9VdKx9kaVbN5P?=
 =?us-ascii?Q?uFn/ZVgi4uKvuznWOSXAUKs+ROXnkSV0czSHI+P3J8h5/yrudThTp5IwTm58?=
 =?us-ascii?Q?kJpiQdqI+XA5nlwhKwheUhcZuNJRrUTeSq4FPxXKnIwh45dFnaD6TvM9agj0?=
 =?us-ascii?Q?Dg57IKITryf2FEQwylM6Ob+Zo5C5Onde9VY9nG/moXHWUadaYShAD7Js4sEf?=
 =?us-ascii?Q?6wSjdVP2DBBlMH9A5kJn9bEOkXyXXLCjsH1fBGmntBUMcipb8QE0NEscpMvO?=
 =?us-ascii?Q?h1gTHjelicSTy5KuuCl841ljJFcOoqyLmis+jU+UXG9yCAiJuWQ8GKIO+DUX?=
 =?us-ascii?Q?khxCjMsSvv1qHtYhzrYVXU+rof10bNi0AS1Rx6zLG99pg9Isi3xPYl4rlshT?=
 =?us-ascii?Q?hK5NhO3HbjO+MX7ecyBR/+hoH6+M5DimukcmHJOwsHAZ8E2ep/OpQnMVr5Xb?=
 =?us-ascii?Q?kZog4cm3SDR3IE2kq6OLVIbZF0utMoQi4QQaKY0h0+5871I/gyZEZvJHdBHm?=
 =?us-ascii?Q?LxP6Jyn85sHmHT+d7Sig+0Ml5kSNM6ADhx0umuTTRupyf8Ttvj5PC7nKcOlp?=
 =?us-ascii?Q?2t181cnQm1GY0DkTJ3cAqphUqGgQUlykIFUOJTAUt6UuHQFgGuyBTpmKKejP?=
 =?us-ascii?Q?Oj3Ks8RJvxBC+3Xxqt9bHj9U4j2+sF0PNUQ3mYgKHDnW1TqtUkN7ZSExLtkD?=
 =?us-ascii?Q?R8u5pK+xXeg7tq6ii/ndNxSsC3nHlfPCKuMpgZl/Ns7Fh9UmoK8uBxnfT926?=
 =?us-ascii?Q?FSgmiLt+Rq/ipIxgBH9VfnHR3Zu+UgT4M9RI6cml0ly7rQcJa8XY50M22dlz?=
 =?us-ascii?Q?Hgvl2/3s14xlzNnmkJK1RWFXhYiEyV+GI7ROyrHKDHKJ5jaSmuBC4t37x8w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7da805-d9e6-46fa-1760-08dd973dea7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:30:33.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6735

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> Sent: Saturday, =
May 3, 2025 12:15 PM
>=20
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>=20
> x86 CPUs boot in real mode. This mode uses 20-bit memory addresses (16-bi=
t
> registers plus 4-bit segment selectors). This implies that the trampoline
> must reside under the 1MB memory boundary.
>=20
> There are platforms in which the firmware boots the secondary CPUs,
> switches them to long mode and transfers control to the kernel. An exampl=
e
> of such mechanism is the ACPI Multiprocessor Wakeup Structure.
>=20
> In this scenario there is no restriction to locate the trampoline under 1=
MB
> memory. Moreover, certain platforms (for example, Hyper-V VTL guests) may
> not have memory available for allocation under 1MB.
>=20
> Add a new member to struct x86_init_resources to specify the upper bound
> for the location of the trampoline memory. Keep the default upper bound o=
f
> 1MB to conserve the current behavior.
>=20
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Edited the commit message for clarity.
>  - Minor tweaks to comments.
>  - Removed the option to not reserve the first 1MB of memory as it is
>    not needed.
>=20
> Changes since v1:
>  - Added this patch using code that Thomas suggested:
>    https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/
> ---
>  arch/x86/include/asm/x86_init.h | 3 +++
>  arch/x86/kernel/x86_init.c      | 3 +++
>  arch/x86/realmode/init.c        | 7 +++----
>  3 files changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_i=
nit.h
> index 36698cc9fb44..e770ce507a87 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -31,12 +31,15 @@ struct x86_init_mpparse {
>   *				platform
>   * @memory_setup:		platform specific memory setup
>   * @dmi_setup:			platform specific DMI setup
> + * @realmode_limit:		platform specific address limit for the real mode t=
rampoline
> + *				(default 1M)
>   */
>  struct x86_init_resources {
>  	void (*probe_roms)(void);
>  	void (*reserve_resources)(void);
>  	char *(*memory_setup)(void);
>  	void (*dmi_setup)(void);
> +	unsigned long realmode_limit;
>  };
>=20
>  /**
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 0a2bbd674a6d..a25fd7282811 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
> +#include <linux/sizes.h>
>=20
>  #include <asm/acpi.h>
>  #include <asm/bios_ebda.h>
> @@ -69,6 +70,8 @@ struct x86_init_ops x86_init __initdata =3D {
>  		.reserve_resources	=3D reserve_standard_io_resources,
>  		.memory_setup		=3D e820__memory_setup_default,
>  		.dmi_setup		=3D dmi_setup,
> +		/* Has to be under 1M so we can execute real-mode AP code. */
> +		.realmode_limit		=3D SZ_1M,
>  	},
>=20
>  	.mpparse =3D {
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index ed5c63c0b4e5..01155f995b2b 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -46,7 +46,7 @@ void load_trampoline_pgtable(void)
>=20
>  void __init reserve_real_mode(void)
>  {
> -	phys_addr_t mem;
> +	phys_addr_t mem, limit =3D x86_init.resources.realmode_limit;
>  	size_t size =3D real_mode_size_needed();
>=20
>  	if (!size)
> @@ -54,10 +54,9 @@ void __init reserve_real_mode(void)
>=20
>  	WARN_ON(slab_is_available());
>=20
> -	/* Has to be under 1M so we can execute real-mode AP code. */
> -	mem =3D memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
> +	mem =3D memblock_phys_alloc_range(size, PAGE_SIZE, 0, limit);
>  	if (!mem)
> -		pr_info("No sub-1M memory is available for the trampoline\n");
> +		pr_info("No memory below %pa for the real-mode trampoline\n", &limit);
>  	else
>  		set_real_mode_mem(mem);
>=20
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


