Return-Path: <linux-hyperv+bounces-5510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F081FAB71F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E57860A6D
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4859B27A137;
	Wed, 14 May 2025 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gOkLwfsH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2037.outbound.protection.outlook.com [40.92.23.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453619AD89;
	Wed, 14 May 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241672; cv=fail; b=F6rcy41uUhm13v6LoIwPC4lsVh44DO4yuWan8jOkuV/wfDFynn121unaPV1mvtgxRvMuMPWZZUf4cCdxL38KbkXd3fZsoXSfJtyjvYmgh0GNFegpJ0w5XgRBUBuIx3TjDe1i8U+8sIkEauuKH9v7M0hprx14LX7FA4LqikkV+wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241672; c=relaxed/simple;
	bh=sBRStE1jcfziyN596gXMsUE6jVhI31a2IYiHfegJz/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZ9BHf2yA7jxi3x0YeQ4FadwNINp77/lKUcUww7k68XzABKVYSF7jjdCVbFd5io6LQn50FZlrwcA8KQkZx8ZZOLH5OvquhDxPo2ENFuzMmvrxOYI5TctsFtB+ic0HNixsHvtCESNr3oobDG+LT4eCssnwrSX7oxNlWDVFVkGLxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gOkLwfsH; arc=fail smtp.client-ip=40.92.23.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7w9rvBYVnlqUrMm2lbuz8ksth1WwsvsTM9XhT2dM4PWogMZVFrA6C501XtZcgMNrmjK0OTbG8LxojEvWOuKR4PQoyADCWw0OFo2WkDt1YCK7iEXW7RBKPDIq0h+g//O6MGS0kbmrL6wNFwx71xvdmy7JWI2+CHoxLrxq+YdvUS2gnP2zGv7qWTXVNr+4kdayqoCMFhoUL7nVBsMEN31PxjVfBuwqBBJVV7b1wo2uxlhwk8BHJ7fCpy/lQEceBJey9geK2/B1FFnRfrAkeazcuGPS73liIjLwBrX9lQwurjoWrMOVaI++RtV69t2Sc5IToggxGQf8TMIS1xZMu3p3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8+ppy/N6aS4m5JAlIxiE59eCRlj8gtGMDpPss4Z1Os=;
 b=x9OQ2DahFF99XQWU0sxNm5d2D8g5KbWrIIhSdjw8yGu+gVYfgTBSlVLgw+fmkrHP4Ic9xzh6iV3IWdlr2lKOdZIH4EiHWx9tLQMiogp5MEdDCCk0Ym3QuWcGcE/QAWA0n0IMJaUKBw6uce+HABgLylyTmBlkAZcokgcbUMGzKVUQRFNS9tu/Qr+YX8ztn/flpmKnICdty2Fnrj2DfqK29rB/DmOEK/q+K65vLiU07dzJmCP0+amV6vnGuzX888lSWkVnhEc2wV+3Vd1Gw8pi5iiMATbMedYi6JcHaYw6oOX1FbBP2nxu8V77//ZcYUcfsDdeTMaqA85lkJeX4ZiVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8+ppy/N6aS4m5JAlIxiE59eCRlj8gtGMDpPss4Z1Os=;
 b=gOkLwfsHm+C+mhWFqjOUrwtMFYPyg3eoUCa+HiVssZo7lTw5IJzSwk3kFXZTuNZsRKbvD2pxb2V9iTdDY9gxtXoD7+7dV0vXmjIgH1fP0uQjh4yGxAO03qkztlS4YYruyKquPZ4JP8t+OB+vSaBPcvq24dc0SXO/5dfsG3LtyvFtYslgaKTCdsLP0C2DLA5XBgQgIuYAYKlz22eW2pdbr1PSHK5W+CBv9qVVPzfIyk6ZqnNELdD9wMrgW8Q5nrHq1G4HooOTTAJOCgT4T2y+0lauSuoE8dEKnSmM+6lEfCjKey8DVAeXcBtiI22DWmUYufX88FC+ggY+VAYWdNX9rw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 16:54:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:54:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com"
	<Neeraj.Upadhyay@amd.com>, "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"kvijayab@amd.com" <kvijayab@amd.com>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"tiala@microsoft.com" <tiala@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/6] x86/Hyper-V: Not use hv apic driver when Secure
 AVIC is available
Thread-Topic: [RFC PATCH 1/6] x86/Hyper-V: Not use hv apic driver when Secure
 AVIC is available
Thread-Index: AQHbvofZRwtip1I4Y0+zmT6dbhMyl7PSVU/w
Date: Wed, 14 May 2025 16:54:27 +0000
Message-ID:
 <SN6PR02MB4157A5928B486CF5D43C50F8D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250506130712.156583-1-ltykernel@gmail.com>
 <20250506130712.156583-2-ltykernel@gmail.com>
In-Reply-To: <20250506130712.156583-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: 6558af0e-93ed-4903-e10e-08dd9307fcb9
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmoaApi1aWVt9ILKZbGoHsd6wSJ5uOOt2lFzslGmPI2/f9yFU/hdeFdQO6OEYbJBzcvI2oJbxokctH3oFlXVlOInNKryMLei4+cZBYIqxdZiihHRPiVVxJ/hckeTkBlHYxbOLFC5WPEcZhvKcXW8WFR28paGbCO7xyUVUwzr6Uv3rxvMfVa5o8gcpd0QgxBfElFdmYGE/Ud9sJxKMb4R+e+S5FDsTDysYCNe9fdAgms6OB2ggAYf3uG4JE8ZO2PfUNxde6oE8H1t0p1gbzo7Cbf9mM+hU3KEZOnNp4S9tcUZVMmXlHRKfnnURMXlHtIjVRnKoO4NBX+AOeDoDOtYPTOO8OQQWWtHuC/KSsU8nLi3ASFiEkTQg0pGwMMqiZm5uemg7MWc1jtBjov5WaHqrDVXqj3N4qK9CNVeH9w/dr7DoCEPL8zas11VhrP9iJIoBWfscyrG+FE1SLgKJVclfe4D0WQRbichoNsnaALjCgOrwBvtiP9gnG3mh+TP1668E7UUPNgz2kMbgTCybXZlhAVgyZurpaXldCnOZzFpWkBv+Ra0zg1xDWhsXCM4onYb7xIAlnVwdx8JWzzXuAw3bSOuT1Zz1UrelZAT92j8WEK6ZIl9o9L2CR/U3R/ZRYNfDmJUFTiILnvMNS5PDr0jPhyRENEvX7nZg/8CWq8lgPzA+gXILMYfSPqRdoAkk6JJnNdExKRQYlMHe4kXO0HnszwKn3UifFHYOSwsmq9LOi6oz0tGiP8v05niWYVcATu9HXs=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799009|8060799009|19110799006|8062599006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7QRTAnaND1i7oJ93Hn3SIbpG0+oH4ofA3mceJBxC3RaL9Tw2SpO9U2qfubxz?=
 =?us-ascii?Q?p9o+2/8uqZgD5WhXze0PzugKY0PyMugRt/RWq9952mIs3H86bW7IANkbU30c?=
 =?us-ascii?Q?oKyzljii5bZHWgk1Dhq23yaoM1Cq79089JcYMnq42OogwAov/yubqss/wfQ+?=
 =?us-ascii?Q?Ab10c+C8VjnpIgsi0uUC7vf6AudDflwZApyMYPCwLo5SrobZ8HaH2/QzLbfA?=
 =?us-ascii?Q?dS+UTSrSVLUDnYrBFkHfeviW4S72kS5nI6j70m/6TcK+taWanFRBkERF9+zc?=
 =?us-ascii?Q?Ukk+4crA3STNOmQ3VDDGfduLrpaaj4JsMnCs1jUGEdvRhA/K2Udwl0ucBFwi?=
 =?us-ascii?Q?2KvLjMpLZaXzhk80jFV7MyrU4aFNZICHdretjl9eC9tl9C0nhuh6wN1ZGO/M?=
 =?us-ascii?Q?mL+OpDcwdymAlEe4ujSGR6Y+pruz8TBq/4bqLcDncP3lWZveuhHR1eFzhNY6?=
 =?us-ascii?Q?JTyM4Dw1K/1zDM7RDAq/zsd18so5S3zzXL3k69ET9oMuhzJHSuzZTy878XLZ?=
 =?us-ascii?Q?ob5QSf0qDEQVkGC/VYXCiUsTaZ3PLFZLpC8A1/4JPXeRHXStx9URIx3medBi?=
 =?us-ascii?Q?k8cQs82keaJW11pFm0EOt4NpXvuvA1Uh6nPIksHpXwgI9PWxd2mrR9rcVcu4?=
 =?us-ascii?Q?kB4dZR0KmqVD+ycEB8Zbvc01bvHkBHennsgeagSYIKkVWt7J0XaUKrdsXG/3?=
 =?us-ascii?Q?TJAw45dKOgqYh64M2WKndKYwNFr8KE3zgAW/g6pQculiXNtmpNbRXr81WiDJ?=
 =?us-ascii?Q?5X3Nub4OL7HkD/1DjtIi4g0ZzT19g/bYwrT8MQGnLi+ai4myZL8TVlo0J97f?=
 =?us-ascii?Q?sThrH3ajpskET+RsfZ/gkdMXHAHUlEPPRnbWKS7XaLpuOzhoF/7gLZoZ3gDB?=
 =?us-ascii?Q?mbTNMaiBi1ascSNviJ1/fFS2WsRRGSfGFaDqyFe7mFKlg8/Vbg8jp3XSLE9+?=
 =?us-ascii?Q?fiRrG0MvIqF89ALj5wX4/W46puKMYgaBvnTeE42ZSsdiDjStYTkDDVkWOQ9L?=
 =?us-ascii?Q?bx1pMrDfX1W+umUNkOfJTgFa7S5Dokp+Vvek8qvAwlGxGv5vlmLlTG2Bk6qw?=
 =?us-ascii?Q?9ljeS+OsvFW39O8yzROXZAB8YVHFui4AbBqPb/GvAsUXPEGUPmU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TD7hWCJnUiUkt9ErvnFQ7i0mIv73DNf+4jORTkFibe/WTvcQJ01dmr4V7How?=
 =?us-ascii?Q?yJP01FhK33tFtci0FJVIGwn6ATnaQ0yuv4JZ8sSOfAK8OzFyXpu2T7rKMYVP?=
 =?us-ascii?Q?mEUzT2VqdFfp0eg22pmI9nQ5g5T9l6+1NnLFKwMCzLQC+EWN9yu4o7qyGpXi?=
 =?us-ascii?Q?bx9xfgwIw+lD3sERixvrT5KuGeyf28Y0WiL/gXUh8C3AR5muI4+HCIE7uH4z?=
 =?us-ascii?Q?AMrxBOblTzJQrIoWTTwMoDKM0A9ZCFnhVg67xu2L2mFcp2hk0xkw9QqU3OmZ?=
 =?us-ascii?Q?tsf7/yadDbY61r1v8aDlDp8xgHQzJlG5g0P7wH6vYwQO9uKw3Hn7+CLsRfK7?=
 =?us-ascii?Q?pDKpfojFF+yWHO3bW0YCVE+Y7XeRfwIQ/R40a0x4gNhCqarvD61Ra9/j5AuG?=
 =?us-ascii?Q?OiYCVV8MqpCRdAtwyjk/ZUDW4aK7Zl0Z9jXCh5F6EWHKiM+t4hb9iiq9NoYj?=
 =?us-ascii?Q?qU6U9tcL2b53adc/rST1+skdC2K8BKoQoI3ItTY6LYXnN4PgcGKx9a+NE3bQ?=
 =?us-ascii?Q?e08qt70COiDr1PGFEcI97o7xtHp4Nxzx+XXIJqIo4FA3om1yjzUY3PRWBuTl?=
 =?us-ascii?Q?cZ6Sg89KCLUCab71T6iL63qEm76LcsZipdqisQIJmkzGEUJUxDhFwvLnURZG?=
 =?us-ascii?Q?5SZBmb0Xc/U86r7bYxhDfSDrWF2f62aiESt5CRRrgvlCx241gOXpmGjIwNV8?=
 =?us-ascii?Q?OLIokIHIATqJGpD69DN2nkgB0dCHfNy5RkVxDh98Dt95yLrXrhXNTzqf5vpy?=
 =?us-ascii?Q?9DDX3fZTU21w+Id1f3W4C0B6TRH1/K4v+9Kz3LiSqs6FZ2K5HsN3XhsEUPZP?=
 =?us-ascii?Q?2FLioeeFs3MmipLq5h3Nc/6aKDWS7Wx3Cjr53vFdcbjS20ywkzHtYIvPTmcj?=
 =?us-ascii?Q?ZSWabFQi7fht9SaE9HH66/a7l2v7UX0vuz4iFbxywrJKZUCLgr9XW+oDEgy2?=
 =?us-ascii?Q?F1lcjx62S/zx44z2y2wF617rTrq0tR0y2lzwYXvLt4y0kE3+dP+Zq3ZBIsdN?=
 =?us-ascii?Q?dPpGpDwS+JLAP1fbmKXZs2/jp9d4C14a4ybFARrol44TalIDnMz/17uUiMjP?=
 =?us-ascii?Q?fPlepc6UFMQT/OF1Yq7CP3k0tIN4M7w8WmtsNKfJGbIWJXmOEbQkeegNoruY?=
 =?us-ascii?Q?kEXp5ePmKcYtUzQzYfMHvpWY643SzYZN+GjtSJmwjuew2ByV5K1ODcTrM82b?=
 =?us-ascii?Q?HCAZZx+J2ae5XvpW/5yao557V72Rj+S3SX5F7H/TjQO0NCECyzJV6Tfg6gk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6558af0e-93ed-4903-e10e-08dd9307fcb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 16:54:27.0153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, May 6, 2025 6:07 AM
>=20

Suggested Subject line:

x86/hyperv: Don't use hv apic driver when Secure AVIC is available

> When Secure AVIC is available, AMD x2apic Secure
> AVIC driver should be selected and return directly
> in the hv_apic_init().

Suggested wording:

When Secure AVIC is available, the AMD x2apic Secure AVIC
driver will be selected. So skip initialization of the
Hyper-V apic driver.

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 6d91ac5f9836..bd8f83923305 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -292,6 +292,9 @@ static void hv_send_ipi_self(int vector)
>=20
>  void __init hv_apic_init(void)
>  {
> +	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		return;
> +
>  	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
>  		pr_info("Hyper-V: Using IPI hypercalls\n");
>  		/*

It seems like this patch will cause a bisect problem if a bisect includes
this patch but none of the subsequent patches in this series. The
Hyper-V guest VM could see Secure AVIC is enabled, but the VM
wouldn't boot because the code to allow Hyper-V to inject an interrupt
haven't been added yet.

This patch probably should come later in the patch series after Secure
AVIC can be functional in a Hyper-V guest.

Michael

