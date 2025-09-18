Return-Path: <linux-hyperv+bounces-6927-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4636B82D3A
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 05:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EDA7BB4A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 03:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A423BF9C;
	Thu, 18 Sep 2025 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="so1WRwXc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010077.outbound.protection.outlook.com [52.103.2.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8A23C4E0;
	Thu, 18 Sep 2025 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167605; cv=fail; b=c680kbZcE8F1qNbfIV+B9HHeWlGFuiHA14k/nBWN1lLEkygObatxd/jvl6odRAvJJcxK0ZsuqXK2+Vos0bYwr7ygbm9l6u1k0w3scj31+bkhwsJH+FYMw3jQ0wcO31Ve7BcO2uzv9/j9Oct+IWZpk9D8MGukxuhAccNNjOaerts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167605; c=relaxed/simple;
	bh=NAP71ikuLK981fQXcSJH1qF9GvzL/4KCiuafX5iT9KE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dj1+GxMjID5yoeDt6vFW72Kw6gaYb2d7GHfluKFsPRRwgh8ndhph+53kR9Plo6+id8/wnONXxwgHfJasGj2zwBPwEWgajd6Oher01Iwz1hWCtZu0zbK4l7cr8NR6LkUJnJx1LSpnkbAl6vwoJJ44CH5wtEBScfP2t5odJV1fQKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=so1WRwXc; arc=fail smtp.client-ip=52.103.2.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKD4NuEEQUlN0tIkidIh4YFvsDVTisdVwKgJj9/X4ooRykdZ7jsgDH8sWPX6ld1ELNp5hboFSrbUSBYuRZK7361TTZ5tjVG3Ejcqw0x57chmYojBfWqiv1JOnhGXO08rJjdtFVieuVdAm0tRKy1S/z8cG0tCOhoRHq+PB2SVFC9WGbKsZKYPjYtFu9ZzCl1niFbYRgLE8YnwxNVBgdPSmVGiLIavwikwUhkNul1Xaz21HV4kF7oUaQzYSil51P9BKRX8p72NpFlOR+yKzlslQYh59szxblDyt1fo6GaY9QNYZ736utHGBElQjclUGRflbP/VQLis0Tn/2pCyW67OBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO+dR9gXxjbNvrj6YgWRxzVlejGtrlB3tgrBC67j6BI=;
 b=R2w33dJIrdx622V/rcyfw2aTmPqkbY4kaOhWIQgA58ia2fa1gvvnWQy6klEfzdxfSUeBLHhxR7ov6fep3WWzkgGtACD87qpUDDrviib+/+AuU7iXj+KfY7VAVt77TpO0fD41BOxkrsIcsWyP9h6vi1Is7smot0/QVDoY0FX16dflZgCAePEjvuaiFEYJW7JasqB7OY17hTQo0IsxdQ8aoLah6q7jn7Zqgt4GYUToqsgXJ3ZPDX6v+ceyJlkTcCtCK6gfYg3PBtyGDE8quqdwb+H7d675tTjMPrfz1P1QG8T6ypVo566GHdE20Iumy8iN08qU9CxEYMzvMrrOFJ9Jzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO+dR9gXxjbNvrj6YgWRxzVlejGtrlB3tgrBC67j6BI=;
 b=so1WRwXcjqjWgYrGPT1kf8sAc1ZQog9NXL71z2SHSMQzS6Yb4pg2Rd7Kyl00cu6gcUlLgCF+Zi0eB1d4zndC1FT2hrGyNey6+RpKC2mxIFE7JW/79qmpLj6u56s93L4/8nDm50PWjWVpuUK7YugCXixCmCzoWL1t4EF5JyQDH/6tgNwTuIaEHZKZdbtCB1Ezp+b0t6XK0nygKyxCS2uBZrpDw4nUD46dd319rH/uC8F2fyhiQD8EzB7lIq+1aWV9V/KtUANRIKfFjsPAnnBWBzFvwQv3GzqJCJ2zZxYkGYeVSGZmmLRsKyqBgX46nzmGYmFd7r4oLYcl8nFHymi71g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6694.namprd02.prod.outlook.com (2603:10b6:610:ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 03:53:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:53:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] drivers: hv: vmbus: Fix typos in vmbus_drv.c
Thread-Topic: [PATCH 3/3] drivers: hv: vmbus: Fix typos in vmbus_drv.c
Thread-Index: AQHcJOQ8m/oamQAjuka/ZYwsob+x9LSYVWag
Date: Thu, 18 Sep 2025 03:53:21 +0000
Message-ID:
 <SN6PR02MB415746FCD52B7D03B83DB095D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
 <20250913192450.4134957-3-alok.a.tiwari@oracle.com>
In-Reply-To: <20250913192450.4134957-3-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6694:EE_
x-ms-office365-filtering-correlation-id: a4468eb6-a99a-45aa-4a23-08ddf666e8fe
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8060799015|8062599012|13091999003|31061999003|461199028|19110799012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b4p49hDmk/8YpSauPLBo5lqiMRglVJYCLDq0nhEBhY6HKvvPdwIR8SyawjzB?=
 =?us-ascii?Q?xxTGGDjR99PjBT9B2+fFQFtmn76hJ4MW7EJ6EPq2FFgRLPVTaQ1FUCeapjao?=
 =?us-ascii?Q?/dVLJylLs6Sid7vesAZP9RHUzDX/xkfWuYyXWB2sPWOZbiAU5AMnqDcQUzg4?=
 =?us-ascii?Q?l2C1I5LOCnT4I1IOuhlKiL+DKm8R8hg/3qh9k2LQGMzaT2wNBWyENvlCP69x?=
 =?us-ascii?Q?cQvh9Z4Xr6Dp8rn0p+0B/RoJbBIa8K1sfE7FB2exgymbU+mcgAnYAd99PQ27?=
 =?us-ascii?Q?iz8zG8l4LA4VpHxjwB9bcMl06SfzyCqAU1FlnLQigltwyBwNmUdQ7Wd9cCjd?=
 =?us-ascii?Q?ywhmAGm84hUN3R3KaDhbrGTLvVAkDUVoNtnHYqXImSh4VijExnWOO4mwvFEd?=
 =?us-ascii?Q?lzQdtkPgVE6DW6B1x5VKkvKT11Erl3PGvKkSvWdGNj1QKQyJrlOaj00PHA+4?=
 =?us-ascii?Q?EZnvDBbCiXajBgMZgc5dSvsE+eoV/w1s+U3SguDMi5hoHrLuXMrx4jn2kq/i?=
 =?us-ascii?Q?FjAdlvlT6TfAkHYDJw1HCoRUz6BQ6RxFf0sQPABxly21U3iRK9nHgGmmVC+A?=
 =?us-ascii?Q?14ffD2iZejPR0q6TkKfuVfmWxUsmzI6n1p0LM7Enn2bTQz+uvn2WmS+alIeV?=
 =?us-ascii?Q?oeHGFxcpJ1REUxBSSljZdH8zdqgs/gYtR/PFPssc6FSzsUv9WvSuWoCFrROo?=
 =?us-ascii?Q?OZ/dhLboquXVbhwlZAYzfflwap97iQbXd1GH0nQaX2ZjoLOXMA9o3ZwQRCb0?=
 =?us-ascii?Q?QeUuFN0PnqCVqIav9g/TYdESgRPecKuCRs0roWJqmSHYyJUsJSwnzp63J5Tr?=
 =?us-ascii?Q?KrO6hBcDsa7x3pmwwEnL+SXJeqIHligiNSNMC1HlD1s9ZdzWCqgdV50nCcZ0?=
 =?us-ascii?Q?v7TbRXjYLjHNBNKLWJPCEG01wxn67r6NlJ4q4QtTxewX0y3BA9h3lSxU9/M+?=
 =?us-ascii?Q?wAQe10iOjP4yybfsx2Vw6bWhbumZDHYjQ+mk5wU9cT7NedDsM+3InWnQgLi4?=
 =?us-ascii?Q?e0jTcjiTu75t5OBTDJQ+8xr8Cn8QjdOPOAbCvEGGZ7FXYv1uDOdvAkdleoWh?=
 =?us-ascii?Q?c6bEwtYqI7Xht91eZZ0oS0NcsjGVGZkhNHQdrFHIWwtmvbwF1ZS2NtO2iGgk?=
 =?us-ascii?Q?XEiUA6JUucBtkEZJaAWBhx6QXN+htutqLAiD+Sm6ep5fFwh8KYj+mF5GByYn?=
 =?us-ascii?Q?t8kU4ZQwA0obnKzy?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EjsKusVkQFs80Si0uUzCL9EZ/5rzatyONezH9L0s1v7JoB/ygp8i5jHqL7AD?=
 =?us-ascii?Q?zOHH98WIvXSWgOnXUXeRH2MFArOH28YA+X28Y8G5BSXbCoSlPf3i37qg7u7R?=
 =?us-ascii?Q?0Nyg83KYa7hAUsirzzdOoDroMJeEsIIxvs5p2+km6MJVjsy2BqPT9AyxcAUr?=
 =?us-ascii?Q?QngwLHeLUoskL/6rlm2KDJTi7bhWBx6Tz9qNn8+8wIfmkdol+pbj4UNBz9CV?=
 =?us-ascii?Q?kAP3XRzmCCX6SmjEHEHZKEY6nyxYwcubUhYgfmBqlPGpmcg8exmJSInhkeJE?=
 =?us-ascii?Q?Vf4dkihhcQcWUOGhcoHBLrJMq156XhuBhT7bCib1PzN8VyEU6Dg3eFtTGG+E?=
 =?us-ascii?Q?mOUl4X+M2VKRpT5Cp1WlgPpjtq2ste32VJeZlPLkthJjcHHSz4Phb0DCZY+D?=
 =?us-ascii?Q?JdtiJ6Hi+w5kphVGQdOZrDyS6zlO0aLgYVWhLzNICUtnU3cIqrMLwKEME+LV?=
 =?us-ascii?Q?D6GetzMZ9YJkHqTWc9wd+ZtXLsSSfedBg5QliR3Mge1YQA4pg2KvWClBPy03?=
 =?us-ascii?Q?P0XB6RkPmgmCN9gqkHdQx8cIapbDIpknPjYgu3M8Wt7bj6EjEHLeWk/PJrfP?=
 =?us-ascii?Q?VNLv3V5rvzXHbl5fydpQQkwGK/womtGA/jS6Jy6i7BMJ48sDkhKuP/0w2dXI?=
 =?us-ascii?Q?lP0kDYsIzIohqRw7lvNJYxIP3pSdLhIrPdUnGkC3eQWsn1Hwy8Xem8XTV7xn?=
 =?us-ascii?Q?CRcmG4VSLBVzAXoR/rmmCAV4vmP9FPEHoTshsuzKawGoMODI8j2zcRUxKoMX?=
 =?us-ascii?Q?v080hxZaaFw/UVcJ0MJyLupcEwE8SPQFCbQf1fXRaEfKHcrAxrNsKeN+aspI?=
 =?us-ascii?Q?lbLcFoz4kX8A5pvyZwMjTy/htGHkd/2GQe4Hj5JmxUxq6WAG08oQSLSplto2?=
 =?us-ascii?Q?wZMZhpeV4T9P8juzaC2zOsxfBoZzsElf4xa7uph7AY8HBy4WFHY0QubhPBiy?=
 =?us-ascii?Q?Kg/xm0ckaZ5RtoTB9IfEjcDYl25Gggmjdx8xuaA2GvsQW9wFnCd2po4KzDBH?=
 =?us-ascii?Q?vEMeCtlEH57WZi4xEDhMiH4BnZ7PpUIr6+ezKVgAXaK5tmUsLFlEuJuzVzQ9?=
 =?us-ascii?Q?b9opqr9bBj1RLnxRwAkEU3FU2mQVGxAn2s1/QCCw8ghjNuWz+wF7LfX3Ki6R?=
 =?us-ascii?Q?2iUtEFns+2VpQzuGrz18RZ6rTRG6kXg64UGNhTV4Ih+LyLyPSLw1d2y9D+dw?=
 =?us-ascii?Q?Z2VM9eQj1fO7sBvxIhTDR/9UfpfkdyasuCuGPn+gyNZc+khXNQ3OCzEpm2g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4468eb6-a99a-45aa-4a23-08ddf666e8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 03:53:21.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6694

From: Alok Tiwari <alok.a.tiwari@oracle.com> Sent: Saturday, September 13, =
2025 12:25 PM
> To: kys@microsoft.com; haiyangz@microsoft.com; wei.liu@kernel.org;
> decui@microsoft.com; linux-hyperv@vger.kernel.org
> Cc: alok.a.tiwari@oracle.com; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/3] drivers: hv: vmbus: Fix typos in vmbus_drv.c
>=20
> Fix two minor typos in vmbus_drv.c:
> - Correct "reponsible" -> "responsible" in a comment.
> - Add missing newline in pr_err() message ("channeln" -> "channel\n").
>=20
> These are cosmetic changes only and do not affect functionality.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/hv/vmbus_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index fbab9f2d7fa6..69591dc7bad2 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1947,7 +1947,7 @@ static const struct kobj_type vmbus_chan_ktype =3D =
{
>   * is running.
>   * For example, HV_NIC device is used either by uio_hv_generic or hv_net=
vsc at any given point of
>   * time, and "ring" sysfs is needed only when uio_hv_generic is bound to=
 that device. To avoid
> - * exposing the ring buffer by default, this function is reponsible to e=
nable visibility of
> + * exposing the ring buffer by default, this function is responsible to =
enable visibility of
>   * ring for userspace to use.
>   * Note: Race conditions can happen with userspace and it is not encoura=
ged to create new
>   * use-cases for this. This was added to maintain backward compatibility=
, while solving
> @@ -2110,7 +2110,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  	ret =3D vmbus_add_channel_kobj(child_device_obj,
>  				     child_device_obj->channel);
>  	if (ret) {
> -		pr_err("Unable to register primary channeln");
> +		pr_err("Unable to register primary channel\n");
>  		goto err_kset_unregister;
>  	}
>  	hv_debug_add_dev_dir(child_device_obj);
> --
> 2.50.1
>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
=20


