Return-Path: <linux-hyperv+bounces-4248-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F28A54106
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 04:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0937D16C475
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Mar 2025 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E171E192B96;
	Thu,  6 Mar 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="enLIb8M4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010009.outbound.protection.outlook.com [52.103.11.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7872191461;
	Thu,  6 Mar 2025 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230421; cv=fail; b=JWc3uYvLj1XSpddFf++3Nz+pwOc9kvoJO1zq2stdDQPr4hAt7yUFKAGUx/fZPcKPWjxXgs3gG91QWZFsfrNjoVMWpQoFW58WLZIDPAVUug7x/HulkE5MahEEqHPSLI1/XOrEEb1/4ii7YxqtkgJvtnkuPMsdwedqZWTTZ5h/ee0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230421; c=relaxed/simple;
	bh=X89LrUz0/nKPtr4BMhMZ9kbzE0QID1obj1LiSaHpH3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1siJMOaHFOE3xWapsOPuXGq0nW0+a0fjc8OcR1Z3piXLtYEsC9EEHjlhjziLYQRAjgRIkHqcnBLa8HKMfw7rvVM1ya+16ZEvOaH94nGL2kibXWEPOBI2Tu0o5BzgsAmP6ct7ShO0UdTJbJG7b0UZ10OxXkoGgRIlwRwK9+PHYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=enLIb8M4; arc=fail smtp.client-ip=52.103.11.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onXlMcQTSN/eSdD5Lj7BR7HvNU3rDRqPcxOtuBI85PCc9/UAsTmvGFlpyq6dMH6KTIx/LfKbD82hLNxPeEhTUfvWAclfSdifAxNQUkdsO54/r/0Q4RuqlR2sYyAcVWaiFtRI82Gw9GieB1iLKkyoIAjEbBL5EyJJIqL6fxfT0fBxZrYfhk32XPhhe8lU+OJu8xwR5R1oabqaP6Q1/ejc1PDVL0dFA8CWAetgwpW+V7raodZQ6Wjeav237kWz2qxScBAkkj4+2VOsAR2y1r6OZqTt4YUwn8cjiY17rMuOhVfGqIAZdbcIkUglFryP8LGqzwlfXxVxWk3z6DiOPvoong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL7PbFmrzPeDQJB5kU4FNUT1Y7VTHaElZbQbARr5vPs=;
 b=mhbDzN4PlahCVSYz+NwpVWmv5+8xD2xYJ28CrJxQ70xKYmhM5KdDVUzz58vIfQFlCr5xIGAT2wF+F+LXcKls3nvuOZMZsLJj46QnpBAYAG0yDHuzuNYmHv93ZVouV1Qv13HGzcm/thTjrN/q0hWumE/x59aYpobGmGFio0ufYkRiquTVC5oHRv4WATu9CLdCErWFCbraojenyuE2LVtGSRwWw34lEFXR3vJuCDRIlzJB4f5JtqZcTQSP8wpBV2nlA4xUMFPtzaqBc0XU6wcWmUTQ2ZKCLkzHejLK9UXnmhhmktZ2DZOH78q5+lS+hEE3SRvk/6Zfb3DYwri97tMIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL7PbFmrzPeDQJB5kU4FNUT1Y7VTHaElZbQbARr5vPs=;
 b=enLIb8M4djFvDww+ASIEDha1uUo3tYhx9mfVVIVmp1qb5vzgkP0rtyoeR4d0jG80ZIHP4iEvFURcuqHkRzzF1qjz/idAGz7xEhqWFCwgIzC6NM1dy9gE2c9SuGOAdLGeEaHO7eoncam1AaR43tXUzm67GuIVV9vIPsaL648azyvdDGm+pMozURPyxIP8zzy6Z68r1E5xTDPXJStXtNQ19i+bLsiSrtQKxxc1srcPSkiP9BV+KNbp4O+6xz6lXkQWoqciZ5uKXcuz0e8D38g/KqfT4slwxDk6PTtuwaR9adq8MlLiR4j8Uxcp406FTDvmn/zyGB6W6DiycrJoVMLbxA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SN4PR0201MB8728.namprd02.prod.outlook.com (2603:10b6:806:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 03:06:56 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 03:06:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "deller@gmx.de" <deller@gmx.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: RE: [PATCH v3 2/2] fbdev: hyperv_fb: Allow graceful removal of
 framebuffer
Thread-Topic: [PATCH v3 2/2] fbdev: hyperv_fb: Allow graceful removal of
 framebuffer
Thread-Index: AQHbisVRnvCldUULrUOKRdfkOSEc2LNlc7WA
Date: Thu, 6 Mar 2025 03:06:54 +0000
Message-ID:
 <BN7PR02MB4148986520E4843A34300436D4CA2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>
 <1740845791-19977-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1740845791-19977-3-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SN4PR0201MB8728:EE_
x-ms-office365-filtering-correlation-id: 6e278758-faf7-4c8a-1959-08dd5c5bf341
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|461199028|8062599003|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YWdv4xnH8kofuo+anFdvy3yIbpW6AUrtrcxRPujuNZt5wfM//7uhJmH2rJbb?=
 =?us-ascii?Q?i/konjgJyoTOi8xNPdusqHZa7iPn5JpT9cGiJEoZNuEiPrL8iqdOgpsRP/Kx?=
 =?us-ascii?Q?SQHMbySYuRYUhuOMUCMeWEQyeLDoaMMxti/VqlQnL/ueg1wO3mPIcr3DE802?=
 =?us-ascii?Q?wTXgmb2lB/TiHO8yddK9ygewazs62qLhLbGCYHjNbCedIXq0weiLuWzzoFWw?=
 =?us-ascii?Q?5b+yvPtsNyZo3wOsbW4avV5bKVuknXcKyI1QqJmc3M8n8vqFQksZ+DGH7GL4?=
 =?us-ascii?Q?m+npOviQK+KYGHmgp1gCHo/i5fuIwy0qAVDgsjLTXfAYSbuqAtyeY80FAA5k?=
 =?us-ascii?Q?NL4YoQfYW9tHNkd6frfCN2bpw7QlvHmTgoz3HF32i4xKEFkjDgk9IXaV0i9y?=
 =?us-ascii?Q?NBL3kk2BFnHwOkaCaGfD+bjWSpYCNgppWI1QgVvDk39I5KZCRbPvUxWndNKm?=
 =?us-ascii?Q?FoW0RQE+AFuWhajrEfrheoCc3jCXYnTSQ6lA2fyIJ4S54YsdOHzypyNXlYOk?=
 =?us-ascii?Q?5PAEeuiUJ+kYogDuBBBX4Mf2Yw8C3PxVteYkglRNg5rgv2wNkt/Gk1idwoms?=
 =?us-ascii?Q?eTgttYUqEaeNEVVuPXE0lOThyck5IYQqe5nWWtVw+kIJOKq+NafZj5YhZJIR?=
 =?us-ascii?Q?xlG+gS0jepS5nXKjVVpb8bY5Pf2WJeAF2qOdXGZuEGS2fJERB25yGWXkjZa2?=
 =?us-ascii?Q?IIjSx0q1aRVfE9ErCNcAhLgHw2InUcLDDGZ+AhbdeBkqHSqjaFTSpfIBT38w?=
 =?us-ascii?Q?OGIDSc2GghjPVn37p+Dvpi0gKTMMVYIttXba9PBlTUbX7neBSQAQ71iCilaX?=
 =?us-ascii?Q?Hl23woxy3ecM9oxYMV2rybr3RapYoDfzOmtn5HugqKXGNS+bz/fVTVcOO6sA?=
 =?us-ascii?Q?INhOcsyr+ynzqzWLrriWslGhMb899W9+BdRjwYSFxZRp6xC/IhtIpzJT9SX2?=
 =?us-ascii?Q?J0ZrrJqm7s9xbZ3ewunehvXBsNMeuMrFMuysz8EYm0nrjd5vVGC8OrLS2c+v?=
 =?us-ascii?Q?1g91E6/duAJUNGrNQkv3PZgNm3R6XOC1w1uMutgEUSM/cWI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XcBfSZ/QQEZnx9X5Q8+oM4NbcZAZKxIZAAgp0wGjPTvsLEDbS/yatOJELgiG?=
 =?us-ascii?Q?R/3ddP5C5AZOKYpqULp4hJIx26u5j6TopH7QuWuJnZ5tqfvfdTmPv1Ru3CKG?=
 =?us-ascii?Q?KbFgqG328puhdbZieOMVoN1ULA3YCaQxqN9SZHUgV+ghuS+qvUH0dNjotnnI?=
 =?us-ascii?Q?QfEZDarjtAUUfhcp6aqbY24SoOHO96rLrUZwA5elzyjL7MQaOHOeNVdnLGWo?=
 =?us-ascii?Q?QFbM7ajPNpRGNNM9qCPfsl34IqN3xrgmskypjpklorBnGH7t0/lsDKn/P1QA?=
 =?us-ascii?Q?uHEwdMOkFvgUT3mz+yTtXNiFBYVl5OAcmb6HNxlIx//nqgATQM1sDF+33wtk?=
 =?us-ascii?Q?K+U9zyZe8bJJeQBjGVNmXReOdL3TJnkNrF0xdVAcYB3IjkUj3CagRHCpDBPI?=
 =?us-ascii?Q?Phyh1peo3HAtZQyxqReApMq8/IoLFbfnOa7GawFAR2wrn9xMPv/yARSXMfiB?=
 =?us-ascii?Q?+NEhdN0I/LO8Ew56aSIbqo1lWbKBu6rs4n/vNDrcOeNFvYXVmFXDlLfdkAoZ?=
 =?us-ascii?Q?kx3qxMh29J6xz118+wzuVG2o2vNvQ2yauFxMQ6y6W6d2pq+eaZCZsiR//ZAw?=
 =?us-ascii?Q?xSq8goZL6LrD/m0HSvelqRqavO3FP4zDcIrYPDTRBh1uCpytC9/4Jj8LC1pe?=
 =?us-ascii?Q?3AG4bq5VAFYFUauelrwuWs+80uyr8O3qmV5RnW7H0bBShfTvQyhEuRfdL2BU?=
 =?us-ascii?Q?KPD7JOalhoBdfREuhjrWDdp2/0xeRlmWC0Lk7asxt33bAfrKG7KbWhPth26E?=
 =?us-ascii?Q?9SpRmUuYJlj2eKrkLtD3721XwoJbsE7FlV7z49nlUxgC6HUUYoMR6YCCpdUT?=
 =?us-ascii?Q?ZCZsPoz/dXiZKcwx9z9uJauyc6WAEzzhMH3+qG09SeBRawnO55XN39vRRsHG?=
 =?us-ascii?Q?C+ivjSGOJbyKX+E/vy+2vEb3XQChD7XJ2gF1ivxC5+tzy6jQKRRF3G3BpoDf?=
 =?us-ascii?Q?b9j4fF9U1jTJ0aSUq3k7znCECeybhivzIQiS/bh6lz23rMAXHW6Piq7XARxT?=
 =?us-ascii?Q?2OUJJjKtaZM7bOGBBs3ccFVqvCa+O7prfj6GyaFfxymiew5x8huHWOUj2Wvy?=
 =?us-ascii?Q?V6W6ZXRJqm0LmVHozuwMNYBma+46DQzavvTETRiqQ5zhtTo0qOrQxM2kUrKw?=
 =?us-ascii?Q?2QIAz0SbdVHqxFO99glRUY1LTa2XTmAVOi2yuxsBCi4tuYVYDBpNptQu7UQ0?=
 =?us-ascii?Q?QTRxLXf3LaRwkHBCioa6XFxzjjlqkIejQYQ3JpMuqamEhMq9jMX2JuNlpG0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e278758-faf7-4c8a-1959-08dd5c5bf341
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 03:06:54.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8728

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Saturday, March 1,=
 2025 8:17 AM
>=20
> When a Hyper-V framebuffer device is unbind, hyperv_fb driver tries to
> release the framebuffer forcefully. If this framebuffer is in use it
> produce the following WARN and hence this framebuffer is never released.
>=20
> [   44.111220] WARNING: CPU: 35 PID: 1882 at drivers/video/fbdev/core/fb_=
info.c:70
> framebuffer_release+0x2c/0x40
> < snip >
> [   44.111289] Call Trace:
> [   44.111290]  <TASK>
> [   44.111291]  ? show_regs+0x6c/0x80
> [   44.111295]  ? __warn+0x8d/0x150
> [   44.111298]  ? framebuffer_release+0x2c/0x40
> [   44.111300]  ? report_bug+0x182/0x1b0
> [   44.111303]  ? handle_bug+0x6e/0xb0
> [   44.111306]  ? exc_invalid_op+0x18/0x80
> [   44.111308]  ? asm_exc_invalid_op+0x1b/0x20
> [   44.111311]  ? framebuffer_release+0x2c/0x40
> [   44.111313]  ? hvfb_remove+0x86/0xa0 [hyperv_fb]
> [   44.111315]  vmbus_remove+0x24/0x40 [hv_vmbus]
> [   44.111323]  device_remove+0x40/0x80
> [   44.111325]  device_release_driver_internal+0x20b/0x270
> [   44.111327]  ? bus_find_device+0xb3/0xf0
>=20
> Fix this by moving the release of framebuffer and assosiated memory
> to fb_ops.fb_destroy function, so that framebuffer framework handles
> it gracefully.
>=20
> While we fix this, also replace manual registrations/unregistration of
> framebuffer with devm_register_framebuffer.
>=20
> Fixes: 68a2d20b79b1 ("drivers/video: add Hyper-V Synthetic Video Frame Bu=
ffer Driver")
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V3]
>  - using simplified hvfb_putmem()
>=20
>  drivers/video/fbdev/hyperv_fb.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv=
_fb.c
> index 09fb025477f7..76a42379c8df 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -282,6 +282,8 @@ static uint screen_depth;
>  static uint screen_fb_size;
>  static uint dio_fb_size; /* FB size for deferred IO */
>=20
> +static void hvfb_putmem(struct fb_info *info);
> +
>  /* Send message to Hyper-V host */
>  static inline int synthvid_send(struct hv_device *hdev,
>  				struct synthvid_msg *msg)
> @@ -862,6 +864,17 @@ static void hvfb_ops_damage_area(struct fb_info *inf=
o, u32 x, u32 y, u32 width,
>  		hvfb_ondemand_refresh_throttle(par, x, y, width, height);
>  }
>=20
> +/*
> + * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
> + * of unregister_framebuffer() or fb_release(). Do any cleanup related t=
o
> + * framebuffer here.
> + */
> +static void hvfb_destroy(struct fb_info *info)
> +{
> +	hvfb_putmem(info);
> +	framebuffer_release(info);
> +}
> +
>  /*
>   * TODO: GEN1 codepaths allocate from system or DMA-able memory. Fix the
>   *       driver to use the _SYSMEM_ or _DMAMEM_ helpers in these cases.
> @@ -877,6 +890,7 @@ static const struct fb_ops hvfb_ops =3D {
>  	.fb_set_par =3D hvfb_set_par,
>  	.fb_setcolreg =3D hvfb_setcolreg,
>  	.fb_blank =3D hvfb_blank,
> +	.fb_destroy	=3D hvfb_destroy,
>  };
>=20
>  /* Get options from kernel paramenter "video=3D" */
> @@ -1172,7 +1186,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	if (ret)
>  		goto error;
>=20
> -	ret =3D register_framebuffer(info);
> +	ret =3D devm_register_framebuffer(&hdev->device, info);
>  	if (ret) {
>  		pr_err("Unable to register framebuffer\n");
>  		goto error;
> @@ -1220,14 +1234,10 @@ static void hvfb_remove(struct hv_device *hdev)
>=20
>  	fb_deferred_io_cleanup(info);
>=20
> -	unregister_framebuffer(info);
>  	cancel_delayed_work_sync(&par->dwork);
>=20
>  	vmbus_close(hdev->channel);
>  	hv_set_drvdata(hdev, NULL);
> -
> -	hvfb_putmem(info);
> -	framebuffer_release(info);
>  }
>=20
>  static int hvfb_suspend(struct hv_device *hdev)
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


