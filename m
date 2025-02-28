Return-Path: <linux-hyperv+bounces-4170-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CFEA4A46C
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 21:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA207A9CB7
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Feb 2025 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688E1B3953;
	Fri, 28 Feb 2025 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Osq17ceN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010007.outbound.protection.outlook.com [52.103.20.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46823F38F;
	Fri, 28 Feb 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776104; cv=fail; b=aTSOdNvxwqF0ZmY75AaejtL+aujVk55sL5MzeYrHz0GqyR64QgXldS9aG2H0SMHNv4nugDGJpszJLMduEaqXNCm7wn/239E9j0Q9NlatNgC/2NreLn6k7sgtst4lNneSQYdtvN3FhWb1DBhmBLLzl/kZuCaFOb8/ormDYKrUU64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776104; c=relaxed/simple;
	bh=a9ctLcfk2Tj3STZ++wgPyITUqBmtWcGnqFLiU5QQd4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKRSJyZVg3QTLAmqnwnU/ypGH+ij24VnRu/cwfcW3FPGuRPtdrIDlbOf7dXbpMW45vPkqnXFBLE4eR9TuurHnsXmBJERqReDBCuxqkZ5Xsj40FsIK4J+L0Fsv/MqKysUgECnQJYIYwFddqnRfATXcwwdv4QtBBydxxxElx5X5QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Osq17ceN; arc=fail smtp.client-ip=52.103.20.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+0MHuNgV/h/1RE72KawHWwuzfpd8gFhAgKKIxniv4rLPIBY+nxFlnSB+hUMROlEt8g3YJTlscK7gieWjEl2EfxLXi9W4AHLVgXUeZrND4CxIxhacfdsUz2GHpv1yEWTo/Q3Q2BjFT0Mw3ls3AasU6huK4mZrYgIj5lUefVyXHKI/e3vtBLsxBbAVK8Kdtx+dKViSLBX4PSt7F4agd5QrKM+IRGkPLpg0Z9KB2mNDsBtI/hKaie2HxXMGNexmZwUP9jkGbhu3IZOV2l86fo5lqHir7mQxFJgBkGXI/3ICQiiSAdSAbtU+CxkaKglbjxeJK8BObVa9MBFs514uA80SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6nVr3CKyMyh/+Gz1aTGsgWa1GaFzLqaXEZub+Q+CjY=;
 b=R+jWvHIfdkQELnGVobewAfbmGkDFX0KHAKJPEAewI4taJeZHFBbNqFoh3uPsa0dVWfDFwS124DGTeRJIpjRiKcrZFEFrVB95szv68nqF4kPCKoB82dMKfeBk9PJr8e9UemwYY6ajYiRABXwbr/F4b5P/4dh72npr1qkVe4Ys9UwMNk0AiTWtBVnRAsxo/s2KkI+TWC/6fwqdpLzgbQ3ndsdjUxTFmz73VfdwAaBlxle0pSvOxiBXp7Zck8tpqAG1IhTQl2HIUpLp5/9872rAUMpcTPkZNg6s4n9WXRC4BUe1/TWhj6VI66/l2hv4pznkOLIz5+fVkURWd0fYCITvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6nVr3CKyMyh/+Gz1aTGsgWa1GaFzLqaXEZub+Q+CjY=;
 b=Osq17ceN4Mbu+e5xOw1QOyTJrO7lqPTKKms4idOAmgOfSDY0IcwTVR06R9HtkFJxZ20RNBqRUMPNqms2Tz/cwjEgCpFHAHQTB5TlJ0Dor/usNf81D3t8xn9FYukOYGbxVnDOdZ8n4bM5AyslKBsd5eolanfaM13PdK2Biy0qBDtP9fZlGANw1dTYqeMMCKhFl+VbWDOxYtjXQ42G1lIj8X8iWT+ElegMCWOoGc4UewYpwnksqTTQnUb5A6uS49rcYHdGQ5EoVVVgrKLZZ471FqjQ3YPuFTyopcNmpivQ1QQYS0pl4ptgNcvbXrCUzwTYfBQLK09MP8W7Iw2PHFtqCA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB9346.namprd02.prod.outlook.com (2603:10b6:806:31c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 20:55:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 20:55:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status
 the hypercall status
Thread-Topic: [PATCH hyperv-next] scsi: storvsc: Don't call the packet status
 the hypercall status
Thread-Index: AQHbiW/CBMS6VYjfVkGy2I3sv9oGd7NdL2GA
Date: Fri, 28 Feb 2025 20:55:00 +0000
Message-ID:
 <SN6PR02MB4157749BCF2F3226008575E0D4CC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250227233110.36596-1-romank@linux.microsoft.com>
In-Reply-To: <20250227233110.36596-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB9346:EE_
x-ms-office365-filtering-correlation-id: 0af0234c-ba4c-403e-4743-08dd583a2a9a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|8062599003|461199028|12121999004|440099028|3412199025|13041999003|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v8EFk7ICjzehGB0wOmc51PNO6gqPFCqatetfphtoXag5mW+GRsJ+zrxq7TkC?=
 =?us-ascii?Q?lDcOLpIIcqzEPa+kBxNC7wAcpn1nWpFUeMHUJd09J8xQny8udTV88H4w0ABY?=
 =?us-ascii?Q?ZlBltkCAApKgd3kW3idxeg7zfcX0il2t14uHPsugGmgq0O0Hf/rXvGCHDP13?=
 =?us-ascii?Q?1U06H/tJz4yRgHQS19SzhjpU0BYVw+5lV6TcDNI9rDW3JIidTzB9IZOtma6w?=
 =?us-ascii?Q?Ccb1vdijRzoAazdz9AF+ygE92gKjrq/XRo0P+dTciRuV3pa1wcjPh+Glw+2p?=
 =?us-ascii?Q?Vi1DsI97Y2rIUkFLzIgxLXq4zTFbdyWgiUv3pIMhbMCUC9nSF8lAxCViOgE9?=
 =?us-ascii?Q?dy11sIpEtqpcEelc2oeJB4VsDoYFB6TpgNGizmOIyC8anxPoTc2IVpF2IHpN?=
 =?us-ascii?Q?erxtCN9SZFVf2UOsIgm0XBQxQBPSZT6MrBSmI+TZ5vceHV1x0tTgaArenK3A?=
 =?us-ascii?Q?9QbA5ti1kVEaTs0+wW1JcyFIqGFJ3e/N8gWSdgLIWGOY7e9Z3CP8m+pnWb9S?=
 =?us-ascii?Q?sk/lcvm3Kio1ICIRyFiC7aEusui7sEv99hRjJ+NiOZmBd4cXshXg9uu+CoU4?=
 =?us-ascii?Q?tTYyvNhjdpwmXIrUR9D/3BgyrxyNZqlgenrGbXCBrdExN/Ey3G+Dpqe18zfv?=
 =?us-ascii?Q?UyQkgEF7ZbHRjJPx0fbc8lfNJU65XSPVSs8lTw3pJaWlKhw/N7rBST0yVlcM?=
 =?us-ascii?Q?kSzK/vO8vPiUYGXVB8F6Oum5BnE43zI8yNjt1C/hsn57SEn7hW4wvaIryIFQ?=
 =?us-ascii?Q?zQNoWDaNTpQbuN6gx8MK4aDkJhLaDoIRKpkuaJ9ub9i7tDe/nkKQ7K/ieEHl?=
 =?us-ascii?Q?j0qpiLJRX7oEr8rMr5ZYfXCJ6NfOaOo+MpXwpV8nCm6GSK0z+tNDpChG02pv?=
 =?us-ascii?Q?Ga0xy9fowQPwV7a2E0XK2YmGediOJdA6Bju1APLda1sNyFIIpfZmoFMlLAJ2?=
 =?us-ascii?Q?ufh8JT8yhDZU6qded6OlNfIpt41jWbHmeKS2bOdXZ+uk0sghMRP3p3s9vrqQ?=
 =?us-ascii?Q?aXV0b1D2CvlyK50G7MFi8r7NpTDX8Ed63Zj7AA02tC5YevWo3uybcphHpJej?=
 =?us-ascii?Q?RoOXT5AenvXx5sK2iLQ0MNrtDIVRMML54JN0yYH5HbyIGUE4dByObuTNMhMS?=
 =?us-ascii?Q?TDCc8cDccLRPglrJ9axj8zZ9uxZF2itJJg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bTWoeXZoOxO+rzdCextrvWWLnXrIgR3LJvfi8cckMemFQhU0zsBe0fl59eNG?=
 =?us-ascii?Q?clt2Eu74+5xehZrTSJ/O0bTvWyeT4wpYGo9mMzb7ismGb3aHqisCNpyoXI1w?=
 =?us-ascii?Q?tjXN0GX1iPq2T7a9nOGkPCTx5dFlyYsj/kptFoLCeDNqS/SdMbX3wAJgfVyD?=
 =?us-ascii?Q?k4tLOS0HIUYZX8q6C1/L2FllG2VvhHIuhN5/rqUNYIk24o6ABIyoUevDeRWV?=
 =?us-ascii?Q?k0GyaTj7usnBP2aVktVZycCgf6QkQsWlArsd2IW5KNZ4ibyTmMxwuwS7Qfv+?=
 =?us-ascii?Q?pVodpx82QNdM6U5njJ5DxPXaU/TgVReKc5uKBRXqGlhPkglV/WYi3McTivBV?=
 =?us-ascii?Q?MsbVuYWVlMJWad0uZyeNiKr0O//OX1LoxSVnTW6sK7L33996Nr2xfAt4hgv8?=
 =?us-ascii?Q?iQ+XuZggOcul3BbOCoCH7XqLYwu0u39jqa0SVWgh4T3A7BiSJgCwvguxVS1y?=
 =?us-ascii?Q?FpjfIe3PG3iVOXcnMwC54yr8s1eHLOMmjPd2JMnaHunw/0SE0ZdKYAyTGIkx?=
 =?us-ascii?Q?X+CnVAAenRhMdDAa4GFHEI50b9/R28m7i52HoTKOBaZZjaNDmCcyEOhGtqVH?=
 =?us-ascii?Q?qPy/yN3Ji883YvFEv9A1FUxO3vBtBsSM6dqb1OvVHLj0nSakwzSoWUXFMGf5?=
 =?us-ascii?Q?TZhc442cjl8NzoUSZLh47VxXJhVwcADIhj15d9OXleWkGWkKH/nCbXKdMH9T?=
 =?us-ascii?Q?wefpaHWb9sfDiK/Mdhy82P6RwjbP340y1vC/62eaj/8PhyjcAMQ0P8XXdsh2?=
 =?us-ascii?Q?j4cHxjXf1C5iJWpwkGHqtkfK38DHIh6G5Kj3sT/R54fv1JjkJWDkQ5uM/5bB?=
 =?us-ascii?Q?UXkkqpZivIWLqtjIKzFGOyj1gN/ir1hiRQiHrrK5tx32DWKEInLTwLwUawT3?=
 =?us-ascii?Q?KA54WyhQBr1f04iPAVqLv/yJ2U16fvmPuQCaAwqwxc6mcMVjPgrP1h1mappq?=
 =?us-ascii?Q?UBDn0RAmFLKjgeSa85CrYxXF5IzE9Fjm0kmFzYec2CfrAtp0Dr0+y4IWRWKK?=
 =?us-ascii?Q?uRj/lAT9/7gY9yp9qQ8KDMnMNZlebEd3JuXac3xWCa0koDgzH4RTe8XW/CMb?=
 =?us-ascii?Q?bgldXICRgrJ/ngZpQGGaErUc7I+J79ly2nLJ4N/rK7BUR07k0icbbKAa6tlu?=
 =?us-ascii?Q?wJ38P/XL8lILGg9VTjvgG37/s43rF/7KXzQK0HMMKTak2GEIjXsJQuVa3L+Y?=
 =?us-ascii?Q?7nUT6+XJ++BC3+OGc923XSQMIREhe4nJ91El0iCeHY4zcnG021UYKWpUuc0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af0234c-ba4c-403e-4743-08dd583a2a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 20:55:00.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9346

From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, February 27,=
 2025 3:31 PM
>=20
> The log statement reports the packet status code as the hypercall
> status code which causes confusion when debugging.
>=20
> Fix the name of the datum being logged.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index a8614e54544e..d7ec79536d9a 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1183,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>  			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
>=20
>  		storvsc_log_ratelimited(device, loglevel,
> -			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
> +			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x sts 0x%x\n",
>  			scsi_cmd_to_rq(request->cmd)->tag,
>  			stor_pkt->vm_srb.cdb[0],
>  			vstor_packet->vm_srb.scsi_status,

FWIW, I added that last status value labelled "hv" in commit 08f76547f08d. =
And
to confirm the discussion on the other thread, it's not a hypercall status =
-- it's a
standard Windows NT status returned by the host-side VMBus or storvsp code.
The "hv" is shorthand for Hyper-V, not hypercall. Perhaps that status is
interpretable in a Windows guest, but it's not really interpretable in a Li=
nux
guest. The hex value would be useful only in the context of a support case
where someone on the host side could be engaged to help with the
interpretation.

I have no strong opinions on the label. Changing it from "hv" to "sts" or
to "host" works for me.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

