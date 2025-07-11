Return-Path: <linux-hyperv+bounces-6196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D10B02489
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 21:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD6717C8DE
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE81DE4E0;
	Fri, 11 Jul 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CBNMepAW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2017.outbound.protection.outlook.com [40.92.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47FF1DDA14;
	Fri, 11 Jul 2025 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261934; cv=fail; b=L81VFyo+YuXmqQyPNJ4SzCO/NxEE89MPbc7/H06dB9/8JwAWQxV9MzEJb9b1Z1ePFzprm+VA+1uMoTUj4ccTipZdQov/1hyDnMMyCkODs4XMHljF32T621GVOpf0E1DXMLqxeyXDs37uxxCTss5K7aMH+UIVrZIA5G3QG6icmMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261934; c=relaxed/simple;
	bh=FEKB2ERtwtfn5WjNcXu29cTfK5GhaJpFTWFixspsW1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MJbW0Y80zD9uSE33qMm09GS2lgQAojMwZYDWZ+vsHoSUh0KU7BWLe35MLCxAWOoGCltEDZeXwAp6XPRz1Y+W17JUnRZwN2Gez8hQNjJ0Bk2Ax6gDfXTknVHDvCF4IdqUOjrYRGlpLpGUJ4lmdACoWT2shsD7C/QlHPCa4cBqrbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CBNMepAW; arc=fail smtp.client-ip=40.92.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pjd+7ErW53Dzat65p8aRRV9OO5mZAGnYun6isaE0i2LRfrMbRdp3eK8oGwaLlv82SuoWnb6OAFMrFhYqpn+N8DOPlnHl0rSaE2nYWb5mWrV06DENnMW02RdnDWggbdsxIaPj5Haks4RFGz82aKUt0V2jHCnLOgPQJBYwbQwmQXXW3aJ2ojuselAv0fbCFaXkAUutUiZuCMWluFcq4N7KCEqzER+N+VzgBupnTf8ibN8EN4T/AemMZ4Hw9u6XjYZFMCtEd0rI7IVH4RuNlFSGbFtpS/IhB+8o04dTNIzJCezguTUhbAinSpy5X9vfSbp388s3EFtavNjaMZF7hf02ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNvvkskXp7Cg+F+CbxxvFURzasXWU7IBDnvWLNqRbkA=;
 b=Li9BcmvBGsMtXLUQkGWckk4PJmtod6Wf20uMIzRb+jdbeVeimLaoG0dVS+mOI8jjCkl8fvPh75zyK+d4/woV5nwDbRHcEGthXMmv2f/ytcRkcCln69/h2wvGP3iJqz4WRJMlMKAS6aU7Gw8lUZKzeW/LUA3xqSh5J5WbYJVXlaCDS9lWDLyh+8D8AYqY8Mua0VbuPkqdw4R5Fdh4RY1KO+BML9R54flL1PuXMTMQLf3ZYyLbf4jYoVch0yVQMciW0CjJ7XUkHJbAKqKQHSKnTCQl1dkVG+Onl6EeXYuqPU0X11lXp4Y+3j/5KDziyiULzRf87DxXB6LQViprhGILBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNvvkskXp7Cg+F+CbxxvFURzasXWU7IBDnvWLNqRbkA=;
 b=CBNMepAWgzAflW53SQqq1/G+87TV6VhNFK9JGQPnkioUywqEfTZwyDxVgOtnN7kM3Rk5XMRSgoyLHdFJWpJo6bOW1bG24nKDtUp0awghgf0W9euZSAQNKe/WhG2fDHqCLcqgqfpJgpe34MTEc7YrOa5lUdWYC+r+LyMM3yAeZbDnn1WRKfRVpFCuYibJz7cP3CbKZNAiEy0T3cpYIaMm++L2kbXn18L58gReZM1EhvPmOog1rtg8OQcFwriHje2y6NlWhkOER77ZSDd07CwNWVFRS8PWtrZdldj7+3h35FXp1xmDlTcoRxChsVgv9GL/R1zJHZsMrIb9WQoJOJn1NQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8058.namprd02.prod.outlook.com (2603:10b6:610:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 19:25:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 19:25:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 1/3] Drivers: hv: Use nested hypercall for post message
 and signal event
Thread-Topic: [PATCH v3 1/3] Drivers: hv: Use nested hypercall for post
 message and signal event
Thread-Index: AQHb8pinAf9oVnDbFE6auSrIod2ERrQtTXZQ
Date: Fri, 11 Jul 2025 19:25:30 +0000
Message-ID:
 <SN6PR02MB41578D12A564ECC32BEFD6F1D44BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1752261532-7225-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1752261532-7225-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1752261532-7225-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8058:EE_
x-ms-office365-filtering-correlation-id: 7b56ade6-ae8d-43ea-7756-08ddc0b0b2c2
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|41001999006|440099028|40105399003|51005399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SXbPwa/dr7Zo7bNvsCmPDa3AKEdu+jsw8p7NfzDSNw8195ic8gHO0hBhtq+N?=
 =?us-ascii?Q?cZb2cXJ4PjlLg4u0p19YtGtkp87hDV3A8vkGXeecGfzmqC8YaUGcrEDWYOHj?=
 =?us-ascii?Q?rmoajJ4qS8CFFd+BRbYkJu6wGIHYBcqZoA89s+aw1avx3tJywuXoCvdDDlLw?=
 =?us-ascii?Q?KMIteGIjASI+a3uu+u08L06pzhGqUyp3Ofwfc7vjxRYjxu/ulvrAIbg4ZDMx?=
 =?us-ascii?Q?f9/QP3lnVa5B1efIL7rhL2buj7mWvYOK2AghIjmq1KcSXW4vD9JSlVgBECYL?=
 =?us-ascii?Q?LM1MXPr0gWu74W9PuOAec5L733ATChPtC3hnQdk1vjOifzZBDXuZanR2Ljf2?=
 =?us-ascii?Q?mOS+0438CWAl31I/B16qgGPyn92ZpvkiOH5VyPNdaN0cEDu6BB0wzq+jQBFx?=
 =?us-ascii?Q?h1d3gSghX0bBu4E16l1xYIxCDgACZOveCXhnnMssthV1GZG0MDxUijVZsLfI?=
 =?us-ascii?Q?saaiIg1d1e+uzkoMwH+Kqoxy2qESp8Dt63Z8HLzYjJS+XAPwUv/ZwYz6AgNW?=
 =?us-ascii?Q?Jy6l6VLE4o35PWQUwOlpZENEAjaYe70RwcbPeJjhCCMw2P83ZW4RqDvXur0L?=
 =?us-ascii?Q?KLRvouVWDiv1iOlTA7sYspjMQXY6irQz5E+vUpkP4U8osE17CKo7YiaTw8eW?=
 =?us-ascii?Q?T1JpAbMpLI4soY0inbZt5zkr/5SzFQZGE+B7NqCOi3O+AbFLKnhmb/HMNS3y?=
 =?us-ascii?Q?pMr41WMtVXWPm8/4HswI0zcts15BasHzhQX8PNcJXTyqmjgNS8al9YEVGudW?=
 =?us-ascii?Q?cY3L8NwlzBi6ctefTnFbCp7cs7RArSGEkSAKbBzHYrmfniJ4T3WS+SuA5iYf?=
 =?us-ascii?Q?MW37U9L+9I2/NQvBm+a9CL3s2suT/toJANUtKkT4vtXpv5vnf4rryde8vbYI?=
 =?us-ascii?Q?XCybKnkeZGVOPtcKsqt1MfOw0nrvHnAtvWReBo/hq5heWvtS6PaKcbuwobua?=
 =?us-ascii?Q?3kldBKnsyy35jRCev+8Db/frlKmW8+cd6uqJ73GcuDFhEzzwndTu77et1/rH?=
 =?us-ascii?Q?08riUPZYIGrpD8CS99C0LvXt7YGqLPyV24y9RzfTXh0McSlPLv+lUph8Ewzt?=
 =?us-ascii?Q?K6dCcZNJBsiivYCa8xOu9Oh9oKzv7A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yD2ocXiuq+U96AyiimJjRUkB0rMOrunxYATUDojH3ERHafO4gtDZRDC6AE9M?=
 =?us-ascii?Q?nV35Xv5LmVEMl+Ex9b5wL1yoEdSQQQb/ds1BFRmHIwGX4sORavsVYx3K6HjX?=
 =?us-ascii?Q?1ctfZAjcDU+bgAdAmVwn429W7Axf6D9I1+CKRXLSWImCXg2uQce23zHSqnwv?=
 =?us-ascii?Q?LyNPIcBpkDgI735a9uASRe2KTNRwWWMAglpq6iT8lAvLnjZXoWf5Q05AHrin?=
 =?us-ascii?Q?JF2l0XvEX/20CeyQ68nUfp8DTWPmXeAPER1rpB6yl8vZ+oM2vU0JSqnlNJAh?=
 =?us-ascii?Q?By2ILH67MfIPvomTtYrobOZMTSi3KmSKOB1sgXV2I5eHY4PFYepTfZobvJo7?=
 =?us-ascii?Q?2NogX+mpWC8AzN+cIJeLy5SC4oAaDSU4QXDDj1G+C0H7ouEfKo+F4s9xTi8z?=
 =?us-ascii?Q?O6NPKFh921n++dgnXl7JR2DdObETAN06O2IFkiZXE4RhUwrEc+w9miEfroAF?=
 =?us-ascii?Q?DgeYqgSTmsDwCeEWxmLqPJBTETLdrtkMUPjvsoETXinp5Aof0ZQviGg0vmaK?=
 =?us-ascii?Q?XM09B4EUgTdNtgflFEixQsiYfnALY31uRnVFNZt60Hyhz/0TlNNQCUhTWwXD?=
 =?us-ascii?Q?fOjYbL120E7H2zOKDPQwltlB21Ttoy/DLja5Hdzyt+ZfSEgLnZNPhcA+xhE3?=
 =?us-ascii?Q?vFD6WhJau2XgmI2N32VghGU7mF6QlDoyAmYOMH9YPtNhp3vax/EP8HQNzWVt?=
 =?us-ascii?Q?bFYg2LVfYD04dgVzg0h0TYwvIzQV7H/zRN7PIw0jJlsxQZA+2wEPOzA9c5RC?=
 =?us-ascii?Q?9EqtCb0tKA1v7K+WQiyd6cwfVloB45+Z8xOq9VWnd+htt4fuMejA9C50/Q2L?=
 =?us-ascii?Q?it44gSdUbznmsFOCi9GJWUOCGkCFghICedxmEC62+INhbT4TFe8OeRbyrNHO?=
 =?us-ascii?Q?SeL9M/PcLqJkQoVxAyFMAY1pVj59yCwX9oyg6IhgSh73jsBeRfLPH0Qsz6k0?=
 =?us-ascii?Q?VvzZoXho5oTulgvva4Rmw29hQ2QQLHzOUuGT8uJfwAC5VSWQcbMOWd8OeWJa?=
 =?us-ascii?Q?BeUic1GhXs4b4vMe6/qL/aFz1ay6G0Fun+qHQlThGdgBQirEm0m6m0kUTvTP?=
 =?us-ascii?Q?63AqpxRXoXh6kgIKp9r+gqSKUN3NMgVsqq/tvzk3sQbpSk9jKdZcpcZ2lXFw?=
 =?us-ascii?Q?bLGAA3kVwvdMWYn3yNiJvmRsph0hXH0dvVaXfitlEKYWs6TSQZD8/grILAfk?=
 =?us-ascii?Q?CzzaaHZvLWoGTjjJuEhtSui3XqIKWtg5OpSZWF86QuccZfRj37edAdMrh/8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b56ade6-ae8d-43ea-7756-08ddc0b0b2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 19:25:30.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8058

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, July =
11, 2025 12:19 PM
>=20
> When running nested, these hypercalls must be sent to the L0 hypervisor
> or VMBus will fail.
>=20
> Remove hv_do_nested_hypercall() and hv_do_fast_nested_hypercall8()
> altogether and open-code these cases, since there are only 2 and all
> they do is add the nested bit.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 20 --------------------
>  drivers/hv/connection.c         |  5 ++++-
>  drivers/hv/hv.c                 |  6 ++++--
>  3 files changed, 8 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index e1752ba47e67..ab097a3a8b75 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -112,12 +112,6 @@ static inline u64 hv_do_hypercall(u64 control, void =
*input, void *output)
>  	return hv_status;
>  }
>=20
> -/* Hypercall to the L0 hypervisor */
> -static inline u64 hv_do_nested_hypercall(u64 control, void *input, void =
*output)
> -{
> -	return hv_do_hypercall(control | HV_HYPERCALL_NESTED, input, output);
> -}
> -
>  /* Fast hypercall with 8 bytes of input and no output */
>  static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>  {
> @@ -165,13 +159,6 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u6=
4 input1)
>  	return _hv_do_fast_hypercall8(control, input1);
>  }
>=20
> -static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
> -{
> -	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> -
> -	return _hv_do_fast_hypercall8(control, input1);
> -}
> -
>  /* Fast hypercall with 16 bytes of input */
>  static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 i=
nput2)
>  {
> @@ -223,13 +210,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64 input1, u64 input2)
>  	return _hv_do_fast_hypercall16(control, input1, input2);
>  }
>=20
> -static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u6=
4 input2)
> -{
> -	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> -
> -	return _hv_do_fast_hypercall16(control, input1, input2);
> -}
> -
>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>=20
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..1fe3573ae52a 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -519,7 +519,10 @@ void vmbus_set_event(struct vmbus_channel *channel)
>  		else
>  			WARN_ON_ONCE(1);
>  	} else {
> -		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
> +		u64 control =3D HVCALL_SIGNAL_EVENT;
> +
> +		control |=3D hv_nested ? HV_HYPERCALL_NESTED : 0;
> +		hv_do_fast_hypercall8(control, channel->sig_event);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vmbus_set_event);
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..b14c5f9e0ef2 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -85,8 +85,10 @@ int hv_post_message(union hv_connection_id connection_=
id,
>  		else
>  			status =3D HV_STATUS_INVALID_PARAMETER;
>  	} else {
> -		status =3D hv_do_hypercall(HVCALL_POST_MESSAGE,
> -					 aligned_msg, NULL);
> +		u64 control =3D HVCALL_POST_MESSAGE;
> +
> +		control |=3D hv_nested ? HV_HYPERCALL_NESTED : 0;
> +		status =3D hv_do_hypercall(control, aligned_msg, NULL);
>  	}
>=20
>  	local_irq_restore(flags);
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


