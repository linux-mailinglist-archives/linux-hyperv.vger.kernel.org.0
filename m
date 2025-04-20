Return-Path: <linux-hyperv+bounces-4977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E262EA94A00
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 01:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08EB188EA9D
	for <lists+linux-hyperv@lfdr.de>; Sun, 20 Apr 2025 23:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4B1C1F22;
	Sun, 20 Apr 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JbGJ5MZU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012008.outbound.protection.outlook.com [52.103.14.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A76EB7C;
	Sun, 20 Apr 2025 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745193528; cv=fail; b=rI6ATWjP7XUr/SmS76TG4ETqoRzUVKMn5vMf6OToWzRGEokU//Ledf8dNxQhBVXc6DgQ3ErFrBn7lvqB3TJTp6MvJbUGFLFtcnPgs5tgqz9syYRp4Ya2spJmlRCExLV1EJaanoVQjOA4ybVDkwtkXecwUKt2Y0kC8hmjhVSLNu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745193528; c=relaxed/simple;
	bh=9P2Fluek6fembtMwMYng9ATQ/dKKUHirWM8xWOGhWNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kuawEY6AfqVifvi2F0XuQzNDbTbQ1Srfqf+abo4tX4Tp9WiJYFJL0ytDNMOV7W7S/bwgv8lUbk/2qS/5KjiNpq7oli3RSzeSfv6strqKMLM+g6S+eVR5JkMDsxN1GDrOTUTn1K9p1izhQM1sKmQhMVEcjdGbgPy8lebLB3NpBBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JbGJ5MZU; arc=fail smtp.client-ip=52.103.14.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0lGCT2AoMuGpQuaBj//qWr1CsywM1VuKgmFjxJaEieDfln1ttuQ4rLIx4Fw/5Sg//nAXLgDDl3VGA5lzcV9hiolaSlTIe17v/kOp2/1MT0UFfhgHdBzi/1hgkWS4DbZWl+TGNL0FyPtWkIZfixhkMeCBNPSZxZfQQvxqdXhsKjEPiNe8v7EIAoTRnrmNScl+PyVHWubwpoAyW5ku2zg6t5rkzQ/Xl088fFHdsC/Kf/3rqWpqeNezMlQvJGaOURRaLv6egDUG549ugRJh2ToEPyzcj0N4134CAj45CitD+BF44hBen9yhjCPevZmkSmX8iLeK8b6BzMs7yT5hOt81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRKyZlxHguNR4ZUFgtJZgzkJS4M8Y/tZ1hUENgDDdlg=;
 b=ZItW+uKIL+PsFiF40FXkMyVvjmw5jaG874GwdXH6a1zJL9jzdKwMx+MvaBgOgTOBwTA2wVa79LupVidM0kJF17loE+hVNaDLHTtbxDffstwhjnILA9x9ryCQV2HuPop+mPS6DK4gaXl1qG4fYUJcJtgdoI8gKTKarTmbAch59+evrt04apyCky1Jxnd5frf2LNAyYf/DC+vK+C0aIyJ95wz2Wt2q3LGXrqHq5SYTuQI+wLdTrj5VH2pRenYPXYRSEshVKg+yyhOQwPobZzFXgDmFbXx4gheHZLwNqZl8LPgL6GrP+IG1EoBvwwAKPzO5znV9gLEYD4nOxrSMOOgnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRKyZlxHguNR4ZUFgtJZgzkJS4M8Y/tZ1hUENgDDdlg=;
 b=JbGJ5MZUSi1FBXt5FIpeyGtKOoKkG9SP8pSlq7lX2P0Vz7d5tL7SuTdN/wTCyCgHpQ5IepfNg251JNPGfjGjzXvZCV4EY0P0rRDUtCuQxN/L1G5Nf21s+JBlCjEV4srL42q89edRv6jdrIy1hbSz36/R+ULoYUOWC4UBpnvnD4+ArzKWc6l4jqltKKSuzhKr74ZVdyj/zNFEtB8Um72JZyi6tPQHF6yaiduKiR7MxT5SpP+mKE+M4PNMSJ+3XZyAO5wAnnp/Y1Y2q4sxrh3OeoSGD+e5g1Zd8a0C/x8hn3URSjJyi+s7McTOzV57DLJ6THQAqgAjzm84xXnheyAJeA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SA3PR02MB9326.namprd02.prod.outlook.com (2603:10b6:806:319::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sun, 20 Apr
 2025 23:58:44 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8678.012; Sun, 20 Apr 2025
 23:58:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Topic: [PATCH 2/2] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Index: AQHbr/r088rxYljrdES9WGx3Hu6yf7OspApg
Date: Sun, 20 Apr 2025 23:58:44 +0000
Message-ID:
 <BN7PR02MB41484C3B916A6D1DA7297277D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
 <1744936997-7844-3-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1744936997-7844-3-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SA3PR02MB9326:EE_
x-ms-office365-filtering-correlation-id: d905ff53-21c2-4c95-5466-08dd806748de
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQl3RqqletCEFdzMlpBSGXYP3ZsEZeVw/Dz+mG7PESPKTpvGFf6TykG7zM4ZyGj7HVplTSgmOMlyjas+DeLAhfeDDoVLHQgNJ5vPIso1K67GTsMTATKJP4OuanEABYf05FYYTuoi6hl1cRzFrnntekQtRi7/wjQxGYRI1wqa185dHyJVeG+JXzs2E/SsVpGQt77wqrERxBt3Zeb9cWAyUw7Kup/LfN5tgZIUnPXypc+t3lmWQhGnQed5PHa+ZXLiPciYT7/dW1cobGzs7juebfbU4y/9e9KgH5nOTomF3jKlc5ptpHepwMw8CiEQ0rBwjz5DDnUz8b0HNb3eqIzgflTvJVss1fGtoyTfYuerb2L8OsI/XtDpMiAj3N/OYwXOLveJV7qGu0WRSLnc69X7SD/Rd8rJtcV2VXBczuYfOzfPNdlU8BFZaNV5XbxY0Sob0tjux3wYrlN8YsR3WRT6h578JrD6eQeDs2iPtsJSv22OZmQpE55bkN/HyI4Is/KWRUHGkQ7d1K6ifT8N+kJ4LoC4JCmLvqEYjOEQT1dIjWHFd6fT1ow1JXSfQao4GXFpO41h0xgBPOKCtiXuG/kYbrI+Dlg6uJXSTv/K+er5tVEyOaQ/HKETxYIOfAG6qOvn/OqFfPZZCs5zeHNerVKO1jsfDy3rFxkOab33dd2hfBb/UK/y7JXpc456KS4RrWlsAIDCHoOdpWDG4iduF8hqjQzhjOt477lPt/c=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799006|8062599003|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u9Hc5wMQUpV3oYtC4FHYByBKUIFRI0RYDVBx2teA/tUv5MB0l0ZZ5oRHGF2+?=
 =?us-ascii?Q?iYQYfuil2N3Onrr/kwMbq6fR21+Pe1BdI7KovPLDJc7kdqQKZHSXDGMgdCJg?=
 =?us-ascii?Q?qwrWrABqnSW0Gjz4OfFj2oDs1RX2kLY824JkntearZ+p6BdGknPpfhvJgKtG?=
 =?us-ascii?Q?iFuSk/nXz+iTgmyq/7U+1ptSFCvAIqmbyi613ZlIZhDfuu6X1ilfEImhfSPv?=
 =?us-ascii?Q?iuPorAYfHzTPfRF7R8rYYluOLT94mAoxWh6YQ94UxT4FdDm3smHdbhYnLEiX?=
 =?us-ascii?Q?X0pWAco9fVfxgkM0MAPIbV7Fk7paqhRxfIYIMn5/iSHJjsMVNA4qpOCZYQxe?=
 =?us-ascii?Q?JSWKA8jB4nfA5+Rrov04pYGl2H3OYnWeckOMVvnNa1x7OKGk1MDe6xZ6jVxv?=
 =?us-ascii?Q?jhrTbFIBc/+1DIcrsioBcJczgSMW8q4Dcyi/WtCJ5w1t6AN101UH60Bzcyqj?=
 =?us-ascii?Q?rEv8YqPAc+d7rEVYsjxt5BzZckG/hBQENE5Kfs1uTZHPOrh5P6V3MowHbSL/?=
 =?us-ascii?Q?d6tzPd3G1ciKP0wXztK7t0eQe126B1D8eOir0avWndndQGOIVRoAJsh6zfHS?=
 =?us-ascii?Q?0Sf30sSUZp+Lf9X9UBkVPZLr2L2lML93JjqF3v/ZleNRqRvztPyTI6JouXMh?=
 =?us-ascii?Q?HopYEVaBmyIVJYolN/38a4uplV53NUx4x3PDzjSteSRgAKRPAy7jGHDRKZV8?=
 =?us-ascii?Q?NMEXfX1U8A88b0bysf/gVkIfB/1vZ6HRKvQqOD5cFLOtRTok5sHcit2fXCgz?=
 =?us-ascii?Q?GNsjHtv+c3Lc3NxsyrvTTzV8uCUGy812vgFxMm1ZKCpvxaQNy8xth4mZVsDz?=
 =?us-ascii?Q?gmwPL3qkwYhrEcYSVj6Skvgli2wY9XJqMlIcnBaNNpv+df2hsdULPeFZhYEt?=
 =?us-ascii?Q?cZqoLgSkJEnOxI/+a4wnuqPKAEWFAoUxM1KxXZRn/THPAo8lhR7apkvrew0N?=
 =?us-ascii?Q?s7nFuJvnEEprZKwh2JaT/a85yEamov08O3pWJ/nwyhAosLkX6ecFKZfrl33J?=
 =?us-ascii?Q?bY5xAx159Q+p+KQA9CehqrpXX/h5UEz1u5aGyQgPgbeuVjuJAmpU2oXfwLTY?=
 =?us-ascii?Q?UHW1d9fk1Jvq/vqVuhqtiyY/I7vpKw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SIB0RVaRNK9GzPQo37fOIifFqMtvkD8x8FV3zfZzIYrmNsgMqaUm6EJdvPbj?=
 =?us-ascii?Q?/YxThuUJavHtWon/MgdDMBGUdMyJnjFVbk/jZvLh3ksLcGx1QQSXOsNtPkeE?=
 =?us-ascii?Q?uW21k/m1goSUmSMWXZTV8s8dQJdE+wYhMO66zV9M4/GHRU2wMcQ5DQj7cAUx?=
 =?us-ascii?Q?OdNgJCJo63bV9QsMpV0MIyQxlXWUmhIQUA9Kufq8Xp45ZSMW2PyRszjw21kC?=
 =?us-ascii?Q?5560kLhZalFpGoQTMKzk3q7XOqsKCBYjVpAw/U1N2WCqZge9pQWRGenifWwf?=
 =?us-ascii?Q?Sbs9YHTP/i5wEvEKLWraebs6xmb/kPHmiIH5sRUsQx8NJH8wDo3h9r44+zHR?=
 =?us-ascii?Q?6NT/gmj52eNWWhVXkcSQXFEr7Qf7hNAhxmUmEl7B1E2J4L4+mZi/QpicIIif?=
 =?us-ascii?Q?HPJlKhGwfkk8mwUtNzdmpqYiEEa18EfSh/sqoNbKDzPT+t49cc6ZW/fxAQj/?=
 =?us-ascii?Q?Lsi0ntP+FHbOHBqq9nrXQNwQw42SPXtZP81pryRjs3D+b2PnNDKV6b5CJLlO?=
 =?us-ascii?Q?5PCc9KKl8bE/c8gQMdCwtvP55GERPQUgvrakj8EG3gsT0EpYzurUw45uPgP7?=
 =?us-ascii?Q?iiHnCu6GCZWSb+JDzf7Q61VDSsecdjhPCc+37MUlwtL65UkW72WZMzQv+o2/?=
 =?us-ascii?Q?AyNEqvaw0w7q0Iy24DypdPeKxAIGarD2jJgVX75gqXiJR96yNvlHL/UouikK?=
 =?us-ascii?Q?i62FYBdSbcpkcavu/XuOLH2tnIOst/sQsTST2q7pmlqBioKF5CQWZumbYYDP?=
 =?us-ascii?Q?UpJCiIRDtrpwbkm2Knp1Z3NpY6h9QCmYxcwEBbdzF6jlsBqWWjk4GJI7Y6ol?=
 =?us-ascii?Q?e8x8QuEN0G4CszbGMThNFG0f6pKuob2Op/0yWAqeHU3d5DKKYhksncaLPe4L?=
 =?us-ascii?Q?ocRD7qLrFhXUpO/n9MN9HxTC9tmDs8vtnhpHyuOcIsEs1H+uTnrRyqDW80eD?=
 =?us-ascii?Q?3PIJdcOCXKd7BbE8qYmAflPjxR00Fafgk2DBK8It9Q+q0yutRvJJKgf5Q31A?=
 =?us-ascii?Q?0fjqETA8roBLUPPkICV3qr11/z6avBwzVts23MMwHxQpsHNec1BAC0tQVr7j?=
 =?us-ascii?Q?dRD8dd81no+g0hO7dpwYO9uLU4xYRZYWCvfiDiuAld6NOHE1mlQBk7SLqYL2?=
 =?us-ascii?Q?/z6jo+BhmemSpCOnzo7SmJ817n5gnNxE5rWnsT33v4jyF6P4tZMkvdK+HLdv?=
 =?us-ascii?Q?Q7ksuafWXOMMMp162e28kegChKC71YzT3yuuzP3C8VQBpXZrzzrYvvruVKY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d905ff53-21c2-4c95-5466-08dd806748de
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 23:58:44.8946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9326

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
>=20
> Interrupt and monitor pages should be in Hyper-V page size (4k bytes).
> This can be different to the system page size.

I'm curious about this change. Since Patch 1 of the series changes
the allocations to be the full PAGE_SIZE, what does it mean to set
the mapping size to less than a full page (in the case PAGE_SIZE >
HV_HYP_PAGE_SIZE)? mmap can only map full PAGE_SIZE pages,
so uio_mmap() rounds up the INT_PAGE_MAP and MON_PAGE_MAP
sizes to PAGE_SIZE when checking the validity of the mmap
parameters.

The changes in this patch do ensure that the INT_PAGE_MAP and
MON_PAGE_MAP "maps" entries in sysfs always show the size as
4096 even if the full PAGE_SIZE is actually mapped, but I'm not sure
if that difference is good or bad.

Michael

>=20
> Cc: stable@vger.kernel.org
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 1b19b5647495..08385b04c4ab 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -287,13 +287,13 @@ hv_uio_probe(struct hv_device *dev,
>  	pdata->info.mem[INT_PAGE_MAP].name =3D "int_page";
>  	pdata->info.mem[INT_PAGE_MAP].addr
>  		=3D (uintptr_t)vmbus_connection.int_page;
> -	pdata->info.mem[INT_PAGE_MAP].size =3D PAGE_SIZE;
> +	pdata->info.mem[INT_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
>  	pdata->info.mem[INT_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
>=20
>  	pdata->info.mem[MON_PAGE_MAP].name =3D "monitor_page";
>  	pdata->info.mem[MON_PAGE_MAP].addr
>  		=3D (uintptr_t)vmbus_connection.monitor_pages[1];
> -	pdata->info.mem[MON_PAGE_MAP].size =3D PAGE_SIZE;
> +	pdata->info.mem[MON_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
>  	pdata->info.mem[MON_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
>=20
>  	if (channel->device_id =3D=3D HV_NIC) {
> --
> 2.34.1
>=20


