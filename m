Return-Path: <linux-hyperv+bounces-2927-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73261967E36
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 05:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F5128185E
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Sep 2024 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0513AA27;
	Mon,  2 Sep 2024 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lHfO6xts"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012048.outbound.protection.outlook.com [52.103.2.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12714A91;
	Mon,  2 Sep 2024 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248132; cv=fail; b=GmARZ8S0Sd08H3fYHG5xtNzXrmVSsbsQCmLI5hRC5KUfQB4RqdytZH9uo8lt4nmz0rO7VT0i+vbr51LuF4sOvEyzb+e0uah+9G7Jiv3MQxf/KkyNDiAoyX2HO1hQ7BEt5B0YrxFIu7LlGSm7+T55seY5H2RY11KD5X0WSzgmxic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248132; c=relaxed/simple;
	bh=9aycErN3FUtrUeY3vq7aGxL/hcyttKuEeBn+4LiPBFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wii5HvPy02MaQDy177C3bbDSD7y52Ul2oYxKc6Z5xsK/1R924Agi/6N0I7aBbQkkCE8HcPgy4CDdLfHw4mOoL2CQiiZuP7Hx155JejtT0IzpN4cSR+T4LscXjSkGZX8Rs4abiM+R6EFSxeVK+m7nvybaP/ifiBC5Fk7SKgOt9zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lHfO6xts; arc=fail smtp.client-ip=52.103.2.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj3orrghZrRvKd4o4ePVzmDQnMUKta2NfmH29oNKah08Jf8gYZoGlOBynChgGS864EEuXRkKJLGdpsnsSZoxIZ6xuaXWzYbX5k0Hxj21SQeHG21flL5Ob7m47cS2IbJycQ6BpK3z5CURcXr3gR5w2KrYNnvL5OmRy8J8z23hXh8BQ079e9VOH9/VtaYGJTcmos6n1P+IuWW6S2N/eJpQTWCYEyK9YZsIF1obpHECw3bnTMcQRecGPlqLhHAkfUAgs8DCu32RuizEdVGyMJtukwfBwQ35lGqDtfVCCUzx5oLmfh+Tm948XUfHlWNW2fPv1Ws5HBMRaeUjnRTzQPLEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46AK7aXq19P0pccXufpruYVcRDgFbDDEhZOvFBS85sI=;
 b=Yw3rEfq1bMZaghP1sbL0bZTtL5EcSoiKjBOtC+QL7ZJhKx52Rgx6M/ykB9skef+zWr41nn7xAjyHcdJ2fgwt9VFIq9pRwxL2tMIzO2HU/kgTK8BW+sX9MdTf5K7eGGtRTdf9qAXLY66zZer3oSrME+cesQAsw/moTUzoApCJik/FCFG0nVAePQKfcBHrOLYtgm4OeuA4Q3cH67lUqqEWaHBfycbOx+jE1AT5db6RdM8bA6OuY9IAeKliAzM0i2dxKGcIdY4l8H48x3E8DsX+O3LxPwRrTEEpWZGKR+NFpvvtnQxKui1WN9xCl8nPdiIfcMqAWINTuhtq7pj87p9pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46AK7aXq19P0pccXufpruYVcRDgFbDDEhZOvFBS85sI=;
 b=lHfO6xtsU4y6Y5TNqiXVr8L+NTXlITDssEpe1FHY2UayLQuERK2k4tB/XH7igkPur3fjQloF2OA0vVQKCZfv0735SGDUdR/xVFOrucA0IyuORJ0fnImhreXFqw8KC7FECQxEbORLdNAa6rIavWszOlSS2Ps6+M7YBFP127jikz3vnXLZgF2hOb4xwIDqm0YIgN728+V1Y8nIZMDCYCp0ukclE9sCoHB9X+ryNr6qLxHYIC1rS8DpSj8mznBeBSTxL/gYQgqEYdWg/ThoqlRrhiY/UWnZX6AmtxwCT/3gVea11BvbLxhbsQsThufw+amvBJhF/bk8jTAUTILSySUS3w==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA1PR02MB8655.namprd02.prod.outlook.com (2603:10b6:806:1fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 03:35:28 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%7]) with mapi id 15.20.7875.019; Mon, 2 Sep 2024
 03:35:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 8/9] x86/hyperv: Set realmode_limit to 4G for VTL2 TDX
 guest
Thread-Topic: [PATCH v2 8/9] x86/hyperv: Set realmode_limit to 4G for VTL2 TDX
 guest
Thread-Index: AQHa9bPS4R/MiBEGtEaf0VbvD9Al97JDAi1A
Date: Mon, 2 Sep 2024 03:35:27 +0000
Message-ID:
 <BN7PR02MB4148C40929A99B9B9B47D86FD4922@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-9-yunhong.jiang@linux.intel.com>
In-Reply-To: <20240823232327.2408869-9-yunhong.jiang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Ryiz0U37ZPfn+JzzpJomfZH52/oGbyFx]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA1PR02MB8655:EE_
x-ms-office365-filtering-correlation-id: ec8051bc-80c4-4b61-70d3-08dccb0049d5
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 URTTbsfYW9pModfOnsP9RsKFnVUVsKx2IbGrM3ttkar1sPmqgv+qkKmoewpJuYyKOFNMp3JxmJqI4xYxdE8YKrRdSuu72Nah2anjjkf11OXX9QeKgzxF4Cr+CaV4JW4SA1ZZxxpmslAQzZ26LZWuZXFOjkyrabq0XZ7U4ar5U6jPpWiihKYaWgVfrmCCB9bXQUz9MNiFngQbZsVpjr15AY81EHqN3ydj4WIJTbvbnX6qtLtP0wGnWA/LWR/AXM3mvsU/oLznx+urZ+eGWycp0J7/8m5JpjLuSEIvNkxFcAG3PUkerWx7MZxGFBtd5SCSccWxRTTAj3JUK97eyGsbWhJET2V2+3IoAL/lEVBpb+QbY3dIGCti1H9vAw3lCdPI8e1pDuqU7Nz6an5gBMc8RaQ4vtx0j503KswGoxBGS2yYuJCfgKAVIBQ9PSAHPvWav60lJlCidlgU8B+QjcyTfY4CqK4kRz9udMlpY3xQvDAKTTFGl7Lhy6DM908b9i5wl8nrOKMcTPPmm+CK4ze6HxkSM9Ny8zD3IdFU430yylK0oZNloqnfhi7RpNSpGYVMrV6o+uDsXiPIYyFX1ACS/s4gJggfIXFCeFc3fHYnXDzzp8/YfZUaxkNg8XUd+5jC4ie7C0wUrd0pyY5ffquNlNcpShi7UO8FuVAnAZRvHC3LJKwpR6CbQK/OFcNEbRtS
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yQuOldNMStbTC8xnRxKWHyDhZb1Co/gGYPbURT+9oX9Rg8IOsWVtZh907Os3?=
 =?us-ascii?Q?vJl6Hzg7eInGcb9mlbwIDhXF+pAfzBUJtzR+eYGSZ19L4d7kS0Rj0RF191IF?=
 =?us-ascii?Q?Rpj1XbW3zL/uHByY35hltOvr/v/cK55rgjaQrxff7KkMofC16MH7c9o1vDNK?=
 =?us-ascii?Q?3zc2lAgeomav6lZTuS/HqQy+g7b53KiQtmS6VxXDrvY519yTm2INOrKmdNkn?=
 =?us-ascii?Q?8e04tTep2mkNiUwS44KrCUjJm6rh7+3Nt4kqTumAAs0Dfc81IMfqBkazyKn5?=
 =?us-ascii?Q?y+Rga9/vCz5eGnhHoJtKa17x3AQE3QhZNUrEKw8qr9GcGW2Et3xh3CwLxLK8?=
 =?us-ascii?Q?Eb0hXpX3AihSpt7PQVqJ6mGXVLsAyHWpypRRgVS8xE5d7TEugNEnK6c68HUM?=
 =?us-ascii?Q?EFvnKUqB3vvFiHjJWFt9a7F/INvto9+2H/DC3Dq+ZypD1KE5kwDPCOwib5A1?=
 =?us-ascii?Q?PPMI7hEOGdME5qptNYNfKN/kVBRw34WHNgeiFRj5z6T6DYjHqj3jZbl6huil?=
 =?us-ascii?Q?yE9npht6GTAW/YA16r9hV/wlhCVko6AYj9pmrHRuwhqSYNVZYSCZ94PkG1vN?=
 =?us-ascii?Q?Q7NDKOZd7zAPt2y9iQGF6yfomptP0CRAM/BqlP3YqkzHGcxl5eoQ2Zuwx+6x?=
 =?us-ascii?Q?PO4MbPbQck6YP5zUqElOsY31ro0kDyj8lCvNNPfhi8SRYBbunw5TCa9i8p3x?=
 =?us-ascii?Q?xGnXpZG74cZbXsezEttcLObF1vEhjgUbv0a5atjEhtmGC4/WvpgGD/y76W+z?=
 =?us-ascii?Q?M2JQPghIpGXgjNhNiuHEHv5To2BdxMog+NkamTxtfaiCYWjYVzsnlH4BmMJJ?=
 =?us-ascii?Q?7sP9pRpFAnqcw0gUZQjyy766zb/f+QcxaygeC6HA0OUCXdgKWeNE5oHrn183?=
 =?us-ascii?Q?GWN96hTzdF3CWWq8acBIeGO6svhkV2ZqIxIQ73v8MsdGGdyYOZdZpOgxU327?=
 =?us-ascii?Q?mv5ubRnLExErecJAcu2W3WwzsW6GHhFyYDW9wACUxSbVGF0NgcHg2hAd+le5?=
 =?us-ascii?Q?SJLcaE389zG+yKqJSifoMVvN+MULuYKd9XWjfYsu31Yc+LajWj1eWjyQBIin?=
 =?us-ascii?Q?a53JAnPXJCWUsbRW+iMBhfNdhTLqGu+x1ABFsOWCqTIgxB/v44Qj0wKxYhqe?=
 =?us-ascii?Q?i/QGek2ieAT/cvHxwlyp0OOkHT75Yh+CSNgfNHVWigh1qV6deAz+xI+BP4yc?=
 =?us-ascii?Q?sOFeSpME8MQnaESenFbfAefIa6TniVKq0DSAH+0hfNG0jeS/th8ivEIFOeI?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8051bc-80c4-4b61-70d3-08dccb0049d5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 03:35:27.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8655

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>=20
> The VTL2 TDX guest may have no sub-1M memory available, but it needs to
> invoke trampoline_start64 to wake up the APs through the wakeup mailbox
> mechanism. Set realmode_limit to 4G for the VTL2 TDX guest, so that
> reserve_real_mode allocae memory under 4G.

s/allocate/allocate/

Michael

>=20
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index e5aa2688cdd0..5829aac74f80 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -40,11 +40,15 @@ void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>=20
> -	if (hv_isolation_type_tdx())
> +	if (hv_isolation_type_tdx()) {
>  		x86_platform.hyper.is_private_mmio =3D hv_is_private_mmio_tdx;
> -	x86_platform.realmode_reserve =3D x86_init_noop;
> -	x86_platform.realmode_init =3D x86_init_noop;
> -	real_mode_header =3D &hv_vtl_real_mode_header;
> +		x86_init.resources.realmode_limit =3D SZ_4G;
> +		x86_init.resources.reserve_bios =3D 0;
> +	} else {
> +		x86_platform.realmode_reserve =3D x86_init_noop;
> +		x86_platform.realmode_init =3D x86_init_noop;
> +		real_mode_header =3D &hv_vtl_real_mode_header;
> +	}
>  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
>  	x86_init.timers.timer_init =3D x86_init_noop;
>=20
> --
> 2.25.1
>=20


