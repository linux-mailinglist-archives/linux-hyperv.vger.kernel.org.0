Return-Path: <linux-hyperv+bounces-5408-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D9AAE560
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 17:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE41C43836
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168D28B7E0;
	Wed,  7 May 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bid/CTmz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010023.outbound.protection.outlook.com [52.103.12.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC428B7C2;
	Wed,  7 May 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632897; cv=fail; b=ZNsmIBu1TSarptpiEC7ybc3POM3tvoJsj8XE/fuKWcq11u1kkdL8IkSKSUErBqGeDSdK6ccaE+c5kWXf7eQXE3hOzx68/m9rj1SdLgAgsXN9Xj01duMiMdLePJ9KzEiTLQZmAbTel9fNs9YFxrwJYmaEfxXHbzcXAgj1k4w/F9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632897; c=relaxed/simple;
	bh=D8Ls4h57jJTiwDMhmnxnb8Tgsr/6BmazREdS/fh5TYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrL4PoNOwtL22ZfpIMkIF041GVhFjiMG9O4ObQoKPXRxPeEXGU22lRZdWDbEUAyebFSG0VMDcRm0NZ6Kh5ImPG3EGoYIUB8gavMXH2mo4CsVdV5CxSahW7gzqNE1W8IrZCg/bLz1byHuhlq2BcxH+HsvI+5mIJbZObjoDd81iBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bid/CTmz; arc=fail smtp.client-ip=52.103.12.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymp0WZBBvLhXArfUdY2Es+GRKm2v3g3h2+CYdTdSLvBIfx1eoQAhFCMq+QHQSSwIZPO5Ok8H0GErT8XLe0qTt4bv07k4yDB/muUT8jsq2tXRNOkMtroENTT3Spw5WrQpG+BuLU0fLMCRKAOwcf+6xrDJzgFADyhZ3sCqeSm+TihTe7zTzaW9xPRXEV0NsWcLhTnYhPE7dfZA+46DO9w3Vo0belzLFz2hNXiaTZI75sBf8BZ35+DKwKk+Zsv90UyIBilS5Th/gQiw1sh2pwI7N3ZNd/xBSNJKS/mMLQ912jqitGzDd42Od7nYQqfWSts+98M58ccQTTBN2utJ+WiBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLdZUylRGe6/KXCcCaqXuy3suVL5ViM+IeCK9lHwEyA=;
 b=NV07pw/aVoH1cm/0++kfcWZKNSV4xxA0U2jsU2wQleHW54YliOeAGRWMj3oCCZrJhIO2tuZ2O79oeGLDH6xzj7UZ22YFPM6gf/M04PfFa0NV0tab/n4Cg21g5rQbdO7g3dCXt7e8kD84pnQAjXSRnHWHlr8KIRniaVdYCOl/8XQMfA8VlRzesEo0pSuT+4Vm7ZXgmg6amJePLzv8DVGN6oTeTWrNpTCwXpwEgfJg58PyuL29nSgvaZYY0R/hpOtF0wVt8tXG08qb6EEHTsRBsv9SPBMFo3SE6+QtjmI/SOYRMHknOTxeHANzbO2DEUA3P+MuMJebvuDDj8/XoSdITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLdZUylRGe6/KXCcCaqXuy3suVL5ViM+IeCK9lHwEyA=;
 b=bid/CTmz6Gy64oJexTtlnboi8qXfC6zk9b/Dzc5UZhbqtNyyA3QQ+CyYWXqQBnDWoA3NG6a1YFSxf1PyC02AwbgReOK8OKaD6OsaHhHT9o7c6yqkuynEHRk2nohTVhbXGqGxHzf8c3mBLlpKsRlTQHJXpq9aNDKFCqg533Q7osDOmsxhjvVnl31pepQARwc/TIYd2+9CTh5fiGw4rKhaAAXJbVoeFRq+NB+7kXTzuNhqHqxIkUC/TY+icGr+b1MO2zHArVIMZ34Mj2nRaAn1+oFfL13TgCUBVSmbkig9qAXX8RxcbO0gSNEmpYli9/W1Aw2z48yd9aASZ9IhlQ1aMQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8989.namprd02.prod.outlook.com (2603:10b6:930:3a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.13; Wed, 7 May
 2025 15:48:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:48:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Patch v3 3/5] uio_hv_generic: Align ring size to system page
Thread-Topic: [Patch v3 3/5] uio_hv_generic: Align ring size to system page
Thread-Index: AQHbvlFMO/MEexc3uUOtlzgIrEAnSLPHUhvw
Date: Wed, 7 May 2025 15:48:11 +0000
Message-ID:
 <SN6PR02MB4157122885FDCA366F84BF29D488A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
 <1746492997-4599-4-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746492997-4599-4-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8989:EE_
x-ms-office365-filtering-correlation-id: 547f9226-9982-4258-0cc8-08dd8d7e925c
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwVu6ov8hlKZu5ytU8AWxKlxewGGU3SoSzQ1YezVfiFzUyAbPN92HSz+kBB1uIaoJ0sSw1fyGLIcVr6ZOCosLxBkV7xTUH+Lkl+ujITCcnvdumUIYczcduB4mvm+wfslJ9Owz2cP5XIM0hFT53piSyyUHOzqTChMwLmYH6pa+ruhl/4EpWyaIVDqGIpkTTVzgu77Jylulz5QYUUJ/h1OJMQU02b9GOQmvlVLOWFb0TRC2w2k22ZtBEOmW9YehTQD4tWIhmHhUZ1RB5iG4xP7ltqz9VR7XqF3QQibLuk3Muj8FCznImcpMR1dvElWhUp4OijkAxhy+rges4WkZJXKfVedgwjNR83MqZIfOGniG/xu3GzdEwc746EQp5b2tAuRwzecy+TcbfEtR4VE8zllsctUHVp88CKW2dhIXVO3lQ8/BUG8j6joyRiSP4x5lvgmcQM5diiARjnPnWAByYKiAsJGoCRZqkIukf4NJ5YULOVFTup3UAUxm6t8qKrjIG4M3xMkEElv6a9Ebt8NcePEG9AfcMrZY38C64F8waUkQDFMAGq3hdWxa6NhFRETFkAfI/bmHqlDhwxo2g81oH0bBhfRdUwyufJqqB1GpSJT4FSxdYDf29urLT7oq2P3f/GQSlQ5RBLMhZB8ElMku7nL1wWVn1Egn6s4tiJCP+E6T4WXmgYMGVekwyacamwuhpV9ZTi2oUfrZ9D+9PpyiEiRdMprtzLiRrW7CxDkS1VzdcQ8abl92b2xQ5CKRzAm7Pwh8gE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799009|8062599006|8060799009|19110799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1HEWU0a+Dq2e0gwGw9Ohg1BPnlzRCjGbQt750/q2aYsTdE0O5So3cQhiDy10?=
 =?us-ascii?Q?ZeNCXVCVDbm//5tnxwG5LeGJHn88y/44QYauzNlc2KpMS8EJvkr9o5eSo9BS?=
 =?us-ascii?Q?Lwe2rH4LJGEZUW72r+KkdzvC0b4EnMI6NIop+Mtnb7g7Uip6TDy60KBGjUCC?=
 =?us-ascii?Q?VbP+3k5N5zwmfWeoX9V4UpHedrewcK5Ig71bKzPileeIYOZXgNVv9TW+SjzN?=
 =?us-ascii?Q?v8uM7SJsz0mFqDdepDKbBaFBbuPdpj7DUz3xPqqAIu+qyp2hei7aXALlnR1X?=
 =?us-ascii?Q?7DRhvujjNaG1/a8ZQltdWgZM+SGmuNm+cVg0/mVG2SqZFj1L/LIni5SjSdXQ?=
 =?us-ascii?Q?eIJ87DtgqaD6M6vqeBUCFHxgzTFBxtrFy8xSRQ2TiOmrhqHKbpgcLzK63LfG?=
 =?us-ascii?Q?wjZDPH+c+AU+WPPq4l89Yfatf3XZCxM9J25ED120hjBjjMbo12n0SRE5Nv5A?=
 =?us-ascii?Q?bbSIRT7RNstc3J+XweFY+4QaRcjo0SswWZ0K4mEFpmLm3LEy4JPsGRMkNXVm?=
 =?us-ascii?Q?H/KEJGeC60s+/CF2QEwmmrcwI3MQX3q6EfIaviBNsCorJFmirOcIyBKEoITt?=
 =?us-ascii?Q?IKhBVbVd+XLAAQb6Fn1pv92ApQ20QbuXPCNDoDmRVaJ86m8z7lK0b7wtX+ZC?=
 =?us-ascii?Q?4pH22TIZvOr6/+RjhcKCyBgzXwJ5eY5hRAPM8sC6Z6a7YQTZsFcB7KqrKzGw?=
 =?us-ascii?Q?3/pV6/zhQhj5qli3J0WJYjmfn/jWSodRYE36V3bMoAynOLHpO91JloV/F4Y7?=
 =?us-ascii?Q?xq4koPfUIzjFkTrkPDhnLeG3NR9Ges9KR3UX7smnQHxr1eQ5ZObcNprutJc1?=
 =?us-ascii?Q?Fo3uB6WGzxDoBW4KJtHRGR8uFvFz4Q3tZIBuO3fcIJ9Kv5TjHuxWOjK1dvTn?=
 =?us-ascii?Q?szVRnZpHENc2m3xjBgKKcrajV8bFlOvjU0VX8zNhCB3VcyWXUfo8gTwYF55w?=
 =?us-ascii?Q?ogrz7WEfbGz0zE2W20Kc/qumbxDdaZim9tvAQPt98ZKm/fr6FJHtNgEq4YgD?=
 =?us-ascii?Q?fuHYt6W6DcGmbtjbxhNlXeK7SAoFQy2uzr+u10Zsdr1Fl47bk6IC2pf86PAr?=
 =?us-ascii?Q?79OuZJ4cfjy/yK+4/noZoKGE+wPvr4iYX/n8xhDra3TI7puPnIzMOOnrSYeP?=
 =?us-ascii?Q?2hRlJRKxiGqc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?enPWKbFx3Nb3qqdfpwhhi7rbagn1MI0znU3s2OPNPzZWgOB9zzCS5PA64R57?=
 =?us-ascii?Q?9UkB8E2po0erjHO70SjatcBReh5DlJ7nyiwsEgyRym4klQmNhWuhpp8eVRkQ?=
 =?us-ascii?Q?c2MWhMRtgGIHPN6KyryUJuVVmRMRfuQjiPcmU+vCCUhgnQs8DbNm6Jd3ZN7Z?=
 =?us-ascii?Q?9s6JKyEYl4n9WSnQO3kqfLNytSymEEWBXIJjykaAu5sl21eb7CbBLg3mcZDM?=
 =?us-ascii?Q?yrdr2Fg5tYWosb00f2Jj3nYfo6wv9Z6v7GxHKJRiidT0lVuPxDErbn6dM8RC?=
 =?us-ascii?Q?4/jQQxMarZqKU8GtT61V7MEwXS8B24vbAWaoEy0mWVW+VDDtY+GRYImghvjM?=
 =?us-ascii?Q?UmkjUPCkggCAtSARHtyn6RVizKUgUFTV1I0nXNQrQja2NWakbqSxR6TA407D?=
 =?us-ascii?Q?WRwSHXtfO8kOsvnWFrcZNzygSBtP2pvdc7hp4zcjdPPaTiBW8FpZsGMjtchU?=
 =?us-ascii?Q?T0tOzCEdWuOTDfrttjYNtX6NxB/v0NNARWfF1oKpfgUIpunthfh1Xl/Tf3u/?=
 =?us-ascii?Q?90W6nvSFYn/W1My0SiRm4JEVjxHcVWSTg8QGEl3jCVj0VUp39ceR4kIhxXep?=
 =?us-ascii?Q?TvoePCFtw8k89eZm7KclPKM5qxdMGVpk3+dW/4LmrlUV3K062dwm7eM8vuN3?=
 =?us-ascii?Q?OiR72MDgQNGaoJ5zrX4SI7zxY+vdHv/l7uSdzJ6FNyx5L1JgWGk+3TCfpuQf?=
 =?us-ascii?Q?kV32fUNmh6CqEIztPZT08Vw5JaltM1NZoa5XA1xNYFnYRL5K/GTZ65NIh1/g?=
 =?us-ascii?Q?U926dARgKnIKvuv33TG1kdccQk4tUZXVbIkxjecwP85KHeXSyVdRg1ESLtkU?=
 =?us-ascii?Q?nmFi9k9nK2RdW+wgIwK8fMPtslsqQs6RnOM937Jcf+dHTaCeQYqNNOPDdMqT?=
 =?us-ascii?Q?Jo1PaIrR1FrY2rlTu5X9GQw9YJBixyBEGOpTRw9NCYV9j8aeiRedJQyJHaBz?=
 =?us-ascii?Q?XtTJvqK5uRe/SV4bFUo6FP9HxIUipuWctKeNXnEKqrULEFdrsAV6x2eJqmA7?=
 =?us-ascii?Q?kTp32dRB+v7ZYqBGSwwMM2eJyLTtv2wjYGgd+xf8zWVvRSib2Ad2HwRjzuMQ?=
 =?us-ascii?Q?JiNQlYv09FgQ70v1DAXoaIMvlYppe0M/imt9lir0CldVICHV7zrvHV3ZIG21?=
 =?us-ascii?Q?VPItJFvEfAfXBBRBTDt818RXU6UjB3Fap9xDp/aDh6PV23YUatN8+foHQLOQ?=
 =?us-ascii?Q?13XT0b1gdQ3gehBKrN63R9wIGdJeBxj/KCJX4ANG/cn5lCLB2fYIcjtK0O0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 547f9226-9982-4258-0cc8-08dd8d7e925c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 15:48:11.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8989

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, May=
 5, 2025 5:57 PM
>=20
> Following the ring header, the ring data should align to system page
> boundary. Adjust the size if necessary.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 08385b04c4ab..cb2e7e0e1540 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -256,6 +256,9 @@ hv_uio_probe(struct hv_device *dev,
>  	if (!ring_size)
>  		ring_size =3D SZ_2M;
>=20
> +	/* Adjust ring size if necessary to have it page aligned */
> +	ring_size =3D VMBUS_RING_SIZE(ring_size);
> +
>  	pdata =3D devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

