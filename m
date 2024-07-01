Return-Path: <linux-hyperv+bounces-2508-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B742291D6B5
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 05:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D3B1F21D2F
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 03:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531AC13B;
	Mon,  1 Jul 2024 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BOmMeONI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2042.outbound.protection.outlook.com [40.92.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5712F29;
	Mon,  1 Jul 2024 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805651; cv=fail; b=br6lMAu6QPluNOxMNpemS1xUxshwdKPS+klm8rAAyp3lxmcJwfVz4W/qqAs1EUVCfOGpE70zBC4NCMNSPzXYj3tR4S4G7cwLxbig6cGg8UC6zZLJtehmHfR4bXRziRNu92HmzMG/MqSAo14aS0SzcmTb3PGlSi9REOCkcNLJ2GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805651; c=relaxed/simple;
	bh=O3P27ztj6LPLXhflcOkmnZLQr5c+HUNssIN70/Itur0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kn1cyrR5bbBZrNybeqIqtPyQZumJHxG822HKT/rR9ZUUBs23qOA4qUxT+Jq7/OgWeauhuWp02apd50t98V9umqJAH++P/lgiLV532QbT6E0nPb4iG0/7VDDEErXxqeccJzKVw5BA9K5HEoGNpmtETLuX/prHMcBZMaQPOtVSwBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BOmMeONI; arc=fail smtp.client-ip=40.92.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOMnevaQG4HXRm+GKEhTRmsXrecDlzCe+igfQChSa1+N3h2/cKp77kR9IlVRg/bstRTtsjCL0+AJqc8gRAeja+OmSYPthTkQUiNcaf4K0rA/7Winv7tisxZGkZlVq5TTCUWdpTTLtIHA+iRx/KQJIfsXe/WKSJAVY0Q2K3dZwkAHqoroIyfZkIsW5CAlXhGcBtfev4giAUV1JicGxUuzbu/dzjhFyfBAhwg0o0taiYRGcg80noXie38pUrRWJH1ocwU4f6GsCvKPP/mnRzo9iNer0Wz0GKeNSpb0/oLRyD01Ml6fhDUhu7Uzo1YhbZO895qt1cP7IzUkQDdbOX3nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSaU33PgLzRdKTtQbFbjf5xSX6BS4CH9bFuRhFp+Bck=;
 b=Xl/LJrJwOBG5eGab1aueyDBfem+dpiShj01yRvkCbP+m4+0zsr0s/oYMvreCUntnadE71aDJFG/+7sJ8VKIIcOmCUS3+0DsUplAEagQ5vJqosSHtPXGCbpbFKhqxPyiJkubOJfPgoPT7yj7hlQ8tasOFGozWN48o0tvd2xGslVrq5PI9QWiZ3/60Y8S1d3kXKT5rTi1NXl7FC2Hhy5dX8bHSoDyBb4BWsAeVcriutDMtvUZQu1Xc3prT4iK868L4E5RcAr1eLT5BOoxlUrJ8I2uDY6KMmi6VYskcmy2IKCTzmsKUCcPPd+/RU1z7sr3Pm3qWSI4Le04dgTNuil8mZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSaU33PgLzRdKTtQbFbjf5xSX6BS4CH9bFuRhFp+Bck=;
 b=BOmMeONIOd85V9CF405WwAPa8YiOFxP3KV/kmOfhyaOkQyMZfFz5a8GEtmMqrTbVh4EP0uGE65ZIZPHNmCs3VIltNlBusSvUnUFoCfZIoSj3Ik/U1bb0OpIKaYYjKzk1DB0LrljAH4b9RohleKzfsekj+FZz3wOdGFHMYc2bzKWRddAl16AqY+WNlcUPx29hWkYWyh7v1Ng5xjfo6+MUw6cMaxqmudPVBseeYaktEqakqfzfOgUpnhQ4P7KBLahBn2rT8dqidwingbIDKwMEbZZE08Q9ZIIJ1EcUcvYj093gP+Hsp0VbjUu/8idNQffHkqk4NhOnp2dmaPA0dSiUyQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8379.namprd02.prod.outlook.com (2603:10b6:303:152::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 03:47:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 03:47:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Haoxiang Li <make24@iscas.ac.cn>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"parri.andrea@gmail.com" <parri.andrea@gmail.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add missing check for dma_set_mask in
 vmbus_device_register()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add missing check for dma_set_mask
 in vmbus_device_register()
Thread-Index: AQHay17QYRsWN8zyVEyQBpcHekFhUrHhN1FA
Date: Mon, 1 Jul 2024 03:47:14 +0000
Message-ID:
 <SN6PR02MB41576B119D0FDC7C5D1448D1D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240701023059.83616-1-make24@iscas.ac.cn>
In-Reply-To: <20240701023059.83616-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [FuNrNQ4Y33A2BgdO+NB43B4EvgXScO/N]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8379:EE_
x-ms-office365-filtering-correlation-id: e744c1c0-6647-4f5b-7580-08dc99807f21
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|102099032|4302099013|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 U+KciF86DVJ1BZiKGvZFVb+SQp6RP8p/+5YKHtwyDUJWMVlihmdVqrLpDcMo3Bw5sd0E+vyGtZAnHQbBBEz3e/BTy+HUNXU3xN92UHndS1lsmIMmYBj6CS6upNqbV0vDvsH6CcSDEZQK91VvC1fzc99TttJESZIjZDeTqVtlkp3HoGavLNJRxQ/WOPWfyJbhRFkpi18/sdYSpdaEZEnZPsiaq2lDi96GI4S84UJahtHy1D4N4Jx5lAnJnqf0DGQWFCNvyIpem8BMlgqXzqfNQVOkt2CjTuGOSCIsI3TTD+twEd0p9KIUZdzZKJvWxjvCyif6XZSvl70fOTTYvoxeCo3Fv2MHl93kMygM6vm+ehSPPcDq0/QKAKMp1mmMCSCDxbvv9md7s1Mz2UsrS31rrMab0eoE5RidWg06D7e+fsxzig9nq1UCYvZEZ3X9b7I7dpEGMKYTOVEe1A2+DumFH663JpJfqYv5uUe/RMOcPFhb1ineGrBld6keFaNlczmW2s0jllXSaNMd7QDBvwZvPsLZUSNNzak5DwDqvItoBQv8rhlJeozBMxYC2NBhNfkfWAF8pd3Wj/nxEPXOaZdw7nfqTG0S49NSsSn1Uwbke5uFO3G8XVj899p5LP9pNC4MRwydNQaX8Gc9CSeNsRyw9PBr6oYQVYD+khhxdUxVxCrMpNvUsrO43KW8QzTACV3bFI1wfH6UFa1rvOnMfGi7LHcvl5137T4pRQogpn2X57w=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AMRcpN9WVttlsnVInveTnA+TP8dhvXve5TU8q6cS6Bi2MBM4+b5161Jyi7Xi?=
 =?us-ascii?Q?Q/wjr7nSieIa3LQviyM/zjfmO1fJGEfXUQmxUQ3h1BI9YNIJvKUSvYFXpIfx?=
 =?us-ascii?Q?5VyAL5JrYeSX0nYa055AewZHhv2YfPOx7HsYlhLZRVJzSZaZ9J1HHnXFu5Nd?=
 =?us-ascii?Q?1lhOmqetM5++mJrp+KkrBH0HJO8iioxqfvgk9IJFvK9zfGTojPyGlOiiqb+D?=
 =?us-ascii?Q?3gursmqfN7A/LBFv3a8RcXrWlEwv9ghmstEv1xKu3AGpEZAHyuhHsnsq7AYo?=
 =?us-ascii?Q?sIlh/9X1+58Zp+kw5DS0qa5HOf7lGO3FnPz8qKZamRwew9VgUvYZbt0NzIUQ?=
 =?us-ascii?Q?kePwUw1LufB+WiNC9bPfobTDN/Mq9Pq1YczrXEMKLMIPfT0m7NnFBVXe0eQD?=
 =?us-ascii?Q?WweCLxcynJ64VVu1RqD5CN5pTCa543H+15piohDzeXeXG1A2GRxVSle8VDXz?=
 =?us-ascii?Q?alm/6tgtZ0ZUDU3unDRuzJcOyraynBAYiTsWFyUefUUjNW1h8zzJu4ve5PrL?=
 =?us-ascii?Q?pj3yZkjj5ShuQ/vHNa6zLDRfWjUbCjFwFma4wUFwTHpxl+wF9V/NKdtQJmno?=
 =?us-ascii?Q?olBKSKTfvWx1zGPSpMU+sbdqmqyrsh3BKwkfu5OqIwgag9R39NQmQCzPdQX9?=
 =?us-ascii?Q?JIq7R0NuoNKy2gYFo0IuPUqlesfcBX4ZBY58cVJBK+7JqlEdf41L0xARXZD7?=
 =?us-ascii?Q?XFJrHsvx4HqwCprKqc1PrCDKyLDuxc36xhlxDCuzhocvffhJH3UufS2N2ixD?=
 =?us-ascii?Q?3QwRzfQ158Rpy9s/OKhx0wtIrAJbOYOwDySKfXgSwSBZ5trktQGNfXO1hevx?=
 =?us-ascii?Q?8pAj6eHzVv1WuXnbD2f/H3oywKHw88zhPoafuLuHiOv2nQqCrSsB/q/lDq9T?=
 =?us-ascii?Q?gJ1YtN8xLWALZB/tlL2e+cr9CgdkvO8MvS3sdfqjv4KG0OpnYkzHcNVj4Sa+?=
 =?us-ascii?Q?jKVB78BjbptdPJoWHhtrtpyexXd0ShC56swj3PoG7WqvdBSs2J47daR3NhKJ?=
 =?us-ascii?Q?Xg7thaSSexJZI0BVpE1ePyAWAudXDTjMnPOImVCi9bOsysPTlJKGfhh/78p5?=
 =?us-ascii?Q?891Xytb6U90CFUdkLX4sYaq1R5gTH1EPZps7QGc6S/jxcDkkOJV+ig2G9nt1?=
 =?us-ascii?Q?HHH5c4QIVG+cHB3omzizV46AH1E20us8hcPDKG/n+IJRZY3tyEMIYQgcMJLO?=
 =?us-ascii?Q?PBaL6Vcidlk670eCXEd4mAXUQE0Kro2CEJ2BxDdIvvelHkg51c2+XbOn7Es?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e744c1c0-6647-4f5b-7580-08dc99807f21
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 03:47:14.7098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8379

From: Haoxiang Li <make24@iscas.ac.cn> Sent: Sunday, June 30, 2024 7:31 PM
>=20
> child_device_obj->device cannot perform DMA properly if dma_set_mask()
> returns non-zero. Add check for dma_set_mask() and return the error if it
> fails. child_device_obj->device is not initialized here, so use kfree() t=
o
> free child_device_obj->device.
>=20
> Fixes: 3a5469582c24 ("Drivers: hv: vmbus: Fix initialization of device ob=
ject in
> vmbus_device_register()")
> Signed-off-by: Haoxiang Li <make24@iscas.ac.cn>
> ---
>  drivers/hv/vmbus_drv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 12a707ab73f8..daa584eaa2af 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1897,7 +1897,13 @@ int vmbus_device_register(struct hv_device
> *child_device_obj)
>=20
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
>  	child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask;
> -	dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +	ret =3D dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> +
> +	if (ret) {
> +		pr_err("64-bit DMA enable failed\n");
> +		kfree(&child_device_obj->device);
> +		return ret;
> +	}

I commented on a previous attempt to check the return value from
dma_set_mask(). See [1]. See also commit f92a4b50f0bd that adds
some detail about the error handling in vmbus_device_register(). It's
all rather messy. I have not personally worked through the details, so
I'm not sure of what the right cleanup is. But I don't think it is
sufficient to just do the kfree() as your patch proposes. Or if I'm wrong,
and that *is* sufficient, please provides details on the reasoning
why, and let's make sure to record that for future reference! :-)

Michael

[1] https://lore.kernel.org/linux-hyperv/20230607014310.19850-1-jiasheng@is=
cas.ac.cn/

