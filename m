Return-Path: <linux-hyperv+bounces-4976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD54EA949FD
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 01:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27043A7384
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Apr 2025 23:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7371D86FF;
	Sun, 20 Apr 2025 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bOdpi/7g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012065.outbound.protection.outlook.com [52.103.14.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4917A302;
	Sun, 20 Apr 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745193481; cv=fail; b=e0q2eA2rD9cou6pmNhb6pPtnTc/ZjS0IxGUqC64JGe8CsVxFlwqDMjbOy8mkYASP0MwF+XEFieAc7eJr6z/JtdVSpt32BvrjcA5LSpLWcCes880xbyEH1ejKN1KK7TREK1GlfJYF23BPdUSln2CW5JSBCvJDY2MoJfSMHl9LE3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745193481; c=relaxed/simple;
	bh=G6Q8tVF4x8SXMQbj8CP8muC+cjM0OTsyEtuh377c6xw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tnQ9l+EQRU746yDga/mpL82L6ZRorcKe3WUgb02/Ftr9i4IKrGkYjtO9C//KunlnmiAaKTVSTofvivtQtncon+61JJ+dnWpZGpxLQFDnEDhJ8/yj26D3sekf2xkdFWUm6FXrRgpbtqVF0aCkJd0v8fBn/E09kfWkROYXjWl7RE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bOdpi/7g; arc=fail smtp.client-ip=52.103.14.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aH0vBkDCjzAAhtbm4mQzJ6+YBy7DzO4f5tAdQhQTrR44tBVs2M12nx+YyA2DEECYqqO7/Gh1fUjEfn6vyCw9TeE56WspppjUXd4KuumsAhnpq8WRPXxG8lc0beE3SYxdWxyfK56xhsHB6DCOLXmhBmGxyhA+OEHoE2lyMQ+OZw3uNj/ouP5b4Lffaxdv6v7Ensi0ceer4ojwTZQk6oyWkqJ9BIzgfs/k3zIdDI+S2iU8/itA85UvfT+AOR0WoKlERg8+b+jGi7WicmSWL9HtBqEVe01oSnsz28vhMbm/1SW7NkF4ZdnFyCr6rtRzQ93/P0fcrkKEATLLe6SGa5Gakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp2O7fRavFCrvYkxpEI//ljZhaeAlHBQnMY7ZACmsR8=;
 b=mN+oUZLCR2WWdFS6QqjKAr1v2QjjGuMa3E62dPAkccYt5cYuB6BFJcyy3+h+XoUJOaf10a0BE904adG5rPtVzGFlm8dNHgDsSYTIcR6305ESSsPwYkO6bL1iysfj4dA5cOpH6c2F5gu0eww23kgxomWsEUvyDVD51BbqSYPu4M+N4B/Ga2zP4NjPhP6ZvkZGsQjad9eMs5JnlosxXMimYbFoFsTSAcsGZvQcKf5jg66IvPQFHEGii7+iNVTPZyEbgaG2UrTGQGJSTzvtx+FYtkBTbv0/6upayeYlaOxIWrhOpt6kpMLNrLSer5jtcqEXREMw6gZ6vwbj2he29Vh9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp2O7fRavFCrvYkxpEI//ljZhaeAlHBQnMY7ZACmsR8=;
 b=bOdpi/7gTWirRwYMSmnPKU1z57Rr+n7zejb3cUbE5BdNP4EFp7PLoC047YJ1S62YWbVDo4hz6CWuDz8TIJI+lvA/izu5Pp0y1S80MMgybtZ33awEi7hK45EjhuUFIa/R9Kvxq6ASbgCHPPYtauuptuFeiUXQnQvDo9CWflTBOzRdt1cHdM+mOmKWFfOckdLilm+V8hqudXeSJP7I8Obycomzd1Dy3UAKm8SaKBubFAwhB73/nCLODxrLcn8axxqHV6vE1KgmHmNoyDPDkUXmJOxSEmmXLCMaMeG69fmDDe1KD1ydIes/yjKG7Ew5Hw/5uSBjlscFHq4DLNlGuz5+PQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA3PR02MB9326.namprd02.prod.outlook.com (2603:10b6:806:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sun, 20 Apr
 2025 23:57:57 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8678.012; Sun, 20 Apr 2025
 23:57:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Topic: [PATCH 1/2] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Index: AQHbr/rwXw225NB9F0670E4RtdFKXrOsoFgQ
Date: Sun, 20 Apr 2025 23:57:57 +0000
Message-ID:
 <BN7PR02MB414817742F4B15AB928450E6D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
 <1744936997-7844-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1744936997-7844-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA3PR02MB9326:EE_
x-ms-office365-filtering-correlation-id: 18e14d18-2f81-4ebc-da31-08dd80672ca6
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6dEoOZOj4tPAZubvlSTC8VXzkSi7ttfIPgzjLmrZMbrU6ZAAyxEe86i0BoVRpCSgaKzyOJRCkk4EJxyVEiuI87kFUmK1OX+fzmVOZ8YhhhgS6qHbUeS1PAn9skZa+PY4OmfBadICTdH2vKQlVDXip/MhPZS0p6IosTUwwFbnJDT/5SmFjFV2B4uJF0cwPQWflTCt6L82dAW4fgroe7LpGYr7REy2jLzflesZZ4lS9Y6yUveql9cODhIDfcoHDwbDCuznK0Q4nl33GA/xJ72BD05TfhsAx9uoT8ERMisgFbP65F6XK6iIVqROKKtmgljlP5MhKLoB+z8CcfMJrD8zGftWRo2jGLAWM/5uQrFJik1W/E+5QF9GeoS4fuFaDev8HDwmiJget7HXmmW3KTlSYk05WSml9/z1fY/4PhzyTCHhen2ZpRcrlRBjmxKA4fZinN6mivne6FVAigahd/rKlpbncOzuniMYq8HHb71OKElqWHmoQ008thC5pisPwK4irbPrR8xI6BCfmp/WDJy7W8Fkq4GIlhbgoiLhKjxTCzkFiJGos6NOwcL3jPjylI4LfE9tV0725LIdOnsGRl8ZFrgqkSI07Y+Li0rQOrtpioAHApRoRfNqBWYXFXfnOD/rU6d/G1YnNw8Aa/dMqDoSamPCrpD1D8iLoIHQopeI6+ikfvWCfVNrRtWN83ashfGMIIL5/R1LrdJWGjRsB0IYBSseDdTjvtxB/ISE7W6itaU1zXMmYLizORUUDlyqDogbUo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799006|8062599003|461199028|102099032|3412199025|440099028|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FyUYRsZRNXDQcxPe14K3svmcYuBlQwDWQBhtCgLLJHlMgw7dq7hvKJlZLn/M?=
 =?us-ascii?Q?Pn8DeQu2N9zW8oFtyCaJCkhtI3DDhzk+o9GVeAqD2yu+gwNUsb+QP1WyJg53?=
 =?us-ascii?Q?Ew38QbP+pI8ETkaEL/yHom6uL8PLafpLIo1KeQP7+rrr3JLARp7kLBx0ugyH?=
 =?us-ascii?Q?oLxSeb+YLMUarEE4CgzgNG00fZXvqWxb15xFQ0e9piuLjTbp3fFPnu1l3h4c?=
 =?us-ascii?Q?hjBSa4lBf0+82QAzWjedDrqOlisA84/KfsfFV/YUxhv0sRPgZ5i6yL+IV8Ea?=
 =?us-ascii?Q?qK06qRyCbCDuJFWnTAzTM85yGVSTxH2qNRZ3uSBon3b+O0eLIquAx1wBMPbw?=
 =?us-ascii?Q?p9XxkzGM9t7ijBg3aemfYPG7QOn/BK3Jhbc1yngYLYqj35PJA5oljeREqumk?=
 =?us-ascii?Q?pflAbL8H2HSknOK3yrrk0FVXHT2CvzzzoUoPjhgnO1F5MIeHQAj3wmHlhSvj?=
 =?us-ascii?Q?FZLF5QQ+eMnm7VqCiACKEBV8c4gziI75+86F7xgA99NxW9GuRUicn7TzOj9x?=
 =?us-ascii?Q?zbsZ9EH/8JS/8HhgiMs0OICfA+Md0tJuDEA6G3jSKLj4NVaVzAH4r3D7Ystb?=
 =?us-ascii?Q?PzLlkjGPzF0jYswTVwCc5GKPU7DPxgrnGlhxSckPgP7qhzJujxslbmB2Tgya?=
 =?us-ascii?Q?OMK538/wD8VO+qQfOpMGIg8HrfoeOCaa6rMVn98A9Rn7hyGgSy5QHNZ1Lrfe?=
 =?us-ascii?Q?HMbhk95V9B+4/j1N5Mt0ec0pa03OqejGA7d1SrWIw9bpY7h11EDN3oS85TMB?=
 =?us-ascii?Q?q66A5d35KVT2D86ijH5z30Pnl4R01ZktSht22+IY5NCwQPpF/1dxX3E5GitO?=
 =?us-ascii?Q?QR69eQ6+E5u7y3mtte+EWXnLvy6JcmwX6sj4glmmBuPuwNdy0LkNmlLSWPLq?=
 =?us-ascii?Q?zT282IbJO6fMwqXnq8AIRFE8zsEY68GcnlVKaDfaBFAEPnRY0Ulm5XtUUNVN?=
 =?us-ascii?Q?VGntXh+MTlC0tQnqwkgVSz3Zh5kMJAJ6Q/k51o0rbBGuuvK5rOvoAl0vEAC2?=
 =?us-ascii?Q?25zrSu/CVPE2uV+GIolqIbrz0UR/QaEWx//v2xhW/V/+lKL6/IhWFm/240ul?=
 =?us-ascii?Q?TpuxZPteALYar+7MgnhOnsk1udTa/rV5/X+g1eGnn6GPqnYjYsAukzSUhY0t?=
 =?us-ascii?Q?QvpQXAgqYSRatQCeIcclOqKvY55N1kqvMw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qy9srMDUguxTfjYtFey234s+QRN69NOkRDzQ3zSs1AJUhK/15OI72t7eEZP2?=
 =?us-ascii?Q?CcdtdE+v24uenEaD9N/ldfviLumFPA4JGSjJB7PuTnVf6nj6wrdlZgyZTe2L?=
 =?us-ascii?Q?tht8bigD0jIyBizQbCeWQEltPheSA6JHGakNG9yqcIKLXYBLlI+KrsPyPpr8?=
 =?us-ascii?Q?lhJ1TYbYXZLvzhCGjQgEXtAlBdwfJ8muSQKZzr4Bw4vZNeH51vDNxPhByUKp?=
 =?us-ascii?Q?UTq5s+6R5ACam/AOTbe8JGTAj0c/GaM9gDFA+3AX7HR4+XqQdkXvSzGGDpJt?=
 =?us-ascii?Q?wuERDoNKIfJIENCRz+NC6R1VMfgJfhw5hv8fnYTFY/dZos7v9PAfFfyoQcMA?=
 =?us-ascii?Q?3PN2kDb5M9qRyIsECrost0xdR7wHo2Rk+jIibzR42WIbeRE8+iKsfXjCwEGk?=
 =?us-ascii?Q?iXABuaSNjQ5qRCJs6tNCLMp7zSna6uDItV8NiIeLrqmIRXUNpCKtItgftR8z?=
 =?us-ascii?Q?I+N3Moeb+uDlM0vUOJeOpyw3DB2HhhMKK8p9ZN0/FojW55n2H1RXvj92doq2?=
 =?us-ascii?Q?GsQw0mG8bvnmGal/2byIQ4iOKGIHmG+yIrsUCnLzLrUey4tLEjcavyl5rYxw?=
 =?us-ascii?Q?BKcbnOJOK3dX8CqtrOWvRB+sf9ayRGp1p+jXtNWPZ5ohHzBpITFJNW4F1/la?=
 =?us-ascii?Q?BjGttvGu5HAMrgnAy0GNDkAohKfiUEgKa4jLSo5r09lRZWEHmun0IQ/ozwux?=
 =?us-ascii?Q?ISIGy8xEWw+LsHoJmA00jnSIkRiiB1mPCyJtMgF6C/Ctq9cPizZfGibbTgh1?=
 =?us-ascii?Q?EpAfjWU/nseC5mQvVDTrh52Lfofbdp5UfXKu1OT3DyKvVYkyGFq7j1YkBRkN?=
 =?us-ascii?Q?qn/Y0aiJD3cnQH1IxPcIOJliPtilYVSB/cMEy62v8jE0cjoQuL0yHlwDY/NT?=
 =?us-ascii?Q?+bJ+6L7f7U4PMoD7MTX1so9RiW2avOT9O/SJSwQtudpaiVwidet4a4MhbATN?=
 =?us-ascii?Q?HGqfpduPTAIe01YFjrI4OQ0kaA5XYcOXdAecq8Qa4yxqy40S/vbvwHLwZbUk?=
 =?us-ascii?Q?F+V0nmffYzXYXpIYvZkL5m6RG9QGxAV7MS/PSIMh68j7KB4k3koOXS7EpbA5?=
 =?us-ascii?Q?NBjEGEumYbxduGNmMkVJdWA/lJRIro/hnIpYlAMR5q6NBz9fhrASfmLoYLwA?=
 =?us-ascii?Q?VEr75KOhotTDWfoyD/tXO2hOzRuM2dL3feRkGThC8E48QTTlvFv3QQ+WIaYZ?=
 =?us-ascii?Q?vqOktFnvK9E6mLditfQy6/bEfwDkyxjCjuSzT+yPxrp6S3QFcnrJ7jHjC1U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e14d18-2f81-4ebc-da31-08dd80672ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 23:57:57.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9326

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Thursday, A=
pril 17, 2025 5:43 PM
>=20
> There are use cases that interrupt and monitor pages are mapped to
> user-mode through UIO, they need to be system page aligned. Some Hyper-V
> allocation APIs introduced earlier broke those requirements.
>=20
> Fix those APIs by always allocating Hyper-V page at system page boundarie=
s.

I'd suggest doing away with the hv_alloc/free_*() functions entirely since
they are now reduced to just being a wrapper around __get_free_pages(),
which doesn't add any value. Once all the arm64 support and CoCo VM
code settled out, it turned out that these functions to allocate Hyper-V
size pages had dwindling usage.

Allocation of the interrupt and monitor pages can use __get_free_pages()
directly, and that properly captures the need for those allocations to be a
full page. Just add a comment that this wastes space when PAGE_SIZE
> HV_HYP_PAGE_SIZE, but is necessary because the page may be mapped
into user space by uio_hv_generic.

The only other use is in hv_kmsg_dump_register(), and it can do
kzalloc(HV_HYP_PAGE_SIZE), since that case really is tied to the Hyper-V
page size, not PAGE_SIZE. There's no need to waste space by allocating
a full page.

Michael

>=20
> Cc: stable@vger.kernel.org
> Fixes: ca48739e59df ("Drivers: hv: vmbus: Move Hyper-V page allocator to =
arch neutral
> code")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/hv_common.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index a7d7494feaca..f426aaa9b8f9 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -106,41 +106,26 @@ void __init hv_common_free(void)
>  }
>=20
>  /*
> - * Functions for allocating and freeing memory with size and
> - * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> - * the guest page size may not be the same as the Hyper-V page
> - * size. We depend upon kmalloc() aligning power-of-two size
> - * allocations to the allocation size boundary, so that the
> - * allocated memory appears to Hyper-V as a page of the size
> - * it expects.
> + * A Hyper-V page can be used by UIO for mapping to user-space, it shoul=
d
> + * always be allocated on system page boundaries.
>   */
> -
>  void *hv_alloc_hyperv_page(void)
>  {
> -	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> -
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL);
> -	else
> -		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> +	return (void *)__get_free_page(GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
>=20
>  void *hv_alloc_hyperv_zeroed_page(void)
>  {
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -	else
> -		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> +	return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>  }
>  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
>=20
>  void hv_free_hyperv_page(void *addr)
>  {
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		free_page((unsigned long)addr);
> -	else
> -		kfree(addr);
> +	free_page((unsigned long)addr);
>  }
>  EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
>=20
> --
> 2.34.1
>=20


