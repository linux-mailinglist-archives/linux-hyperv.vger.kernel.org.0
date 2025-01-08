Return-Path: <linux-hyperv+bounces-3603-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82EA05299
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 06:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4AD165994
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 05:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E82E1A01CC;
	Wed,  8 Jan 2025 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="otIZIW/C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2026.outbound.protection.outlook.com [40.92.21.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7D70838;
	Wed,  8 Jan 2025 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314024; cv=fail; b=CTOQEhOtcrgQeJvxTqSYyjgSYVSdjlD4Z0bOhb+yfjBu3F1dkQ84KqttHSYJBtZvG1AiW6r6JzKT6K1WJP1m3q84pWLZnO2bb8e0iNYjNSEKpsoDRIDDfbCXpMQ15BFLzVkBjpp56yrlViQOC9QhsUrfjm+VKTRVUiB0xJXV+fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314024; c=relaxed/simple;
	bh=MfmXazh/Eqj0a2eEtUzv/yU12Sfz4oyLJZyu1zvKOYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VpG4gsAc1N4tHGZqfWkc/y1GFs6QSkVtXKduxpys18f68CjvQKQkSMB/brery94PA/Jyt6kCfoxO3wlJVHxJGX7Vqcvc/fHsDa3l1hI4k/Wp4x3qOnE3vh6pcBULBCarTntKgg8dTHzhJE0pZnXRDPXM1dvGReHiDATjj5CJTw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=otIZIW/C; arc=fail smtp.client-ip=40.92.21.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMc3rMUJqvyGdMIYOKOSAzKQWh1wKipXXzhM2jvaT9XWPjxxIpYDihqMQVrEAeudFhG+ku6RibS0DrE87yR0R/DXBB32zxII7HZIgU3Oygs/+4p7NjvCeYy/oiBmbs6WGqLRnz0oGDElQvJCEDlKabY6j0HvLZAU7SsPRHkcI7M9w8rxifPDhgP+QcDQWD1rIMoLqgHEL5pjDTBhVG1rpscwq5kgJ/MkHkAm8ymbjs9S1xIQ8KMqPPnxVVAk3pN/s6V+8R6ejfWamxwfnehiRmjjb/WwJrR/OgorsSIlYlqTYOblcxkm5DLaDO774+FOA7M03f6wjc1a/p8/KJBiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5coPKnr+O3PJgQ5VsU/y8wa9yOn7NIMdhrHh4QqXaA=;
 b=LHINkI47Fr2ef4PUWqMVvSMOVGAgHShSnlwGJ84oHWUJ4r6wLfzGamNO8AgRK3BI2DLFXTuOK7KoNZqFjXkphBvPk9jJBEWXntoapItv2pjctrotmy6lItYKhLclgLa5lfq3D0B8JP9XGoN0PyOKP2a1qEETaqekQAUgTmX070W1vno7CTpQGyWzsBvEtxytpe+29qf3m0sSq3FOH8yJcE3KFR+luNLsc/TDiJ8tKek4ezPyyBAHPVhxI5yDFB9Vs7Pg5Phr0bsG7bwX4q1ykvlouswDVOAW9TQ9kjRJTk6xRkfYeZI9J/tjEQs9Tu9bmaTbsLC2m+JySiVRuybfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5coPKnr+O3PJgQ5VsU/y8wa9yOn7NIMdhrHh4QqXaA=;
 b=otIZIW/CpjJKQimWJXKpgzYpG7lPMWbhWp3NEHoDiIkdgFmEz0bR8Fa+nQ3L82pfPOMLLaObRi22LeneQgClDYp1TFYLYqerqkcKwY+mqV0WBIY6fXvd4sY/fPiW57Zt6bP6xOi3hQeaaok/eQP9o7UgpDMdCUmaFDyV+ui1G9HuJvHhBSoqclG4PZ9TU5Ygqqzs1bv1CzJSK4lDj6E+vqgatBct4L5aRZQx41zA5TyUQijTrl+ysLvpE1ua0IoTHfRNPy+QipgDkc4lnvIcj/LYv6yb4HA071ry4/VLgmQUIEC/DbGKdRL2nt9q6KrWXDy0/z/0FCApHi1JmgZZ/g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6648.namprd02.prod.outlook.com (2603:10b6:610:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 05:26:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 05:26:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>
Subject: RE: [PATCH v2] uio_hv_generic: Add a check for HV_NIC for send,
 receive buffers setup
Thread-Topic: [PATCH v2] uio_hv_generic: Add a check for HV_NIC for send,
 receive buffers setup
Thread-Index: AQHbXSYJygord6OPnE+DqQg/mpErALMMYB3Q
Date: Wed, 8 Jan 2025 05:26:58 +0000
Message-ID:
 <SN6PR02MB415727CA0BD7ECE337BD1E12D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250102145243.2088-1-namjain@linux.microsoft.com>
In-Reply-To: <20250102145243.2088-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6648:EE_
x-ms-office365-filtering-correlation-id: 962ec33f-79b9-4e40-df04-08dd2fa51292
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8062599003|8060799006|15080799006|1602099012|10035399004|102099032|3412199025|4302099013|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qD0JDwdsMkAuEVbI+64kZzIrrBS2j2NyZ9+mmPQZbwroQjTlfpFJqtzINYky?=
 =?us-ascii?Q?NJutp05pHyFyEES1BfmCIYs4vdK6fep6JwW3wk/KCI14X6u+igNHYcR9sn2c?=
 =?us-ascii?Q?Jcpp0pCy6tlJEoxjtgUsFcOUhPJmnFEbgSoK1DaAT0EJzKaUBi7hM/yEz7Lv?=
 =?us-ascii?Q?pRj8LbNjpZEos0nYJzgXbMhUWau+bl3kWa+bVWIV/adZxwKP0No+GulOS7AV?=
 =?us-ascii?Q?47mgUj/GNc9mQgf3rA0UTqNU3uPjQLfQi6TYKTGg/Vs1AplbH354h/dhcEU1?=
 =?us-ascii?Q?ITtR7sPPfH+u8+jTMf03uPBOvFSXQPa/XoUiAumJuQfuF2m+8d2rP71b2kMS?=
 =?us-ascii?Q?idGjRW05v8o17MobTEm3IUWAIFVhS6I80WY3HIBGyJUgap3fWBpT/NtjkyRT?=
 =?us-ascii?Q?URVtRqd85GzWAEvsyzNfuOqV6n7xXQiCR+jmCHu84rTb3ElW38QyrlJ0LTH0?=
 =?us-ascii?Q?iLtD0Qmtoe0pM+nfJCGUxh6SoZ9n5A/kM37TpSQuFuKrRSdqHRnbfzPoGvA3?=
 =?us-ascii?Q?Mr8sR8Kc6tJhgXQoeArPEJoy0/FfXHqxb4hfu9b3WtbvHl4SCilcqT6YdMmy?=
 =?us-ascii?Q?VEnWo5S0gcGN1nowKWAesiX1d5N6NoTEQ1rHxjY9UIQb33jx0TQ8TEUVRmrR?=
 =?us-ascii?Q?fBmNKvhE0mo5CoTOL5ASlaxFSVd30Pu3g30AjYstHfbpvVf9BbOuNYXPtfCi?=
 =?us-ascii?Q?JJ6lnPccRMWN4P8JnGj4z+DisrqPfForOSgkILVZBTUPbO8CgkwLj6QF4SJ0?=
 =?us-ascii?Q?AewT56LsJh8m3dYKUeYmtxri7+1hMa0iQ364ywbvXt2nYOvBL/RnphSNclDP?=
 =?us-ascii?Q?VMUBIoAun7qTrxuobVusUCC4Ltzd5vz4vz6jvDSMX61lsUyu2g+i55FGNCa+?=
 =?us-ascii?Q?db8Ua6RpQ+QrN3niGUZmHN0nwt5Ji5yEDf7Vv2NGQtS4iFdbHvrw4nesWQ76?=
 =?us-ascii?Q?LLNE10Slc38qSWlX+M7pJGl5iv7youGKuJXv/TNMz+JFqKNqFU8gZCporQjf?=
 =?us-ascii?Q?da4VgN6AkuySh44pxjNdqnNcFYj/H8cm/6oMCdhSO4xL5nT+F8w/T3kFYyjJ?=
 =?us-ascii?Q?NIXR5ILa44RII8ch11T4PYq9ArDgrKulRge4SiVwKLHtiAje1NPmxJJ37NGT?=
 =?us-ascii?Q?TQhc+dNj/IBehyWU/IK0yh4RVhEIlOnxepGtpuQAalEuQxirvIw79ngXfklb?=
 =?us-ascii?Q?2+MCNgigHNH8xttO1BU2mwlX/S9WdqWk1kfKOA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5BaZrElXnW1FE1foY6ysIRyk0Rz18RySu7CUHQFkVq/bPnsm35V0QfB+d6cF?=
 =?us-ascii?Q?akx9jINThmYAGgDP5WJ4qIdtzVq6jbXT12whNcv/bBRqnbE0XDqVjz0atYaV?=
 =?us-ascii?Q?TofABrUjrIlYs7IVTowEc0ra8j1VH57kMZq+00b5DhpYcYNb28OFUm6Gbi+H?=
 =?us-ascii?Q?ygUyzB36OXhy4i6V/47YuKnpc8BuVE0QsFhBHOVke6JFWYhrWzwxX74VZ/WQ?=
 =?us-ascii?Q?bDAxm4WvjkwqKB2C9Ih1cZ5T41g7vUaCz9YjIJ2cbAr7NGoUWfk1teY/4sct?=
 =?us-ascii?Q?huhlkkkexCsfVH3QXHrmvBIoLdw3lV1PS+IYnmRATfsOKy4ZSPR8cgxCAXQJ?=
 =?us-ascii?Q?Aum4rmZ98XN00OzXTv5xsewsaCWlz/fM/e8EjPoz9vleiGSUUudOGLYUgxCD?=
 =?us-ascii?Q?ePWTSuBuRpkGMvNZRAHCmjtT447tYEUJ7VXVBuuiw9Pxo012qIs6oMKnuQNt?=
 =?us-ascii?Q?wSfW5+1jSSlI98oP0tuuZKD2HALu0SuAunAmFmFsSUUIrGzKwCb/QBAMv55N?=
 =?us-ascii?Q?0E8d0YRY/pgakERXivFOUiiEdj/kDzSJRwIBmYXEbtWwJXA5kErEQchdumD8?=
 =?us-ascii?Q?/onLetqJIZq3J0r8chsut3/57mghJpFdpcKFgGc5cYlIGlz8VJcqWhM2uB0K?=
 =?us-ascii?Q?sXi0EYSZoS3Ob+/Cdn/MUQLl+rIm/6YzYs9Ir/pJ+Thvex+lVYauzr5pOjMW?=
 =?us-ascii?Q?vlGoZsLmwjpurZN0QZrk0Nkl17gUIRB23/4u0GjRP0GtFZfpcdeJ2O/sqj7K?=
 =?us-ascii?Q?NLQoWJaG1HF8plKSpXX0Ldx6cF+baSXSvx32kObU87IJ6PzAixxZd45IW3ph?=
 =?us-ascii?Q?I5sZ8EqLpzMRYiOPinYkS096c8P+gWGf9ZE5/p35CIC5rUvku7cM74tYzFT8?=
 =?us-ascii?Q?8kZNg2bFery4M12ioQM4CIxCJJ5JQBKMaTNJKDTl9hg4k32cMzDNVxkiISN/?=
 =?us-ascii?Q?2fjJo2WhrqGIh+Fr+kcVh/WbwHtfj1oNMe8xEkL8BBc7nTjmK5aswcBGZdRg?=
 =?us-ascii?Q?e7e546X9A1HwRlQsu9MkEjuUYbltIBDouaqFKiU3asHlSt3Ygt6QxeIuBt5a?=
 =?us-ascii?Q?xvtoaXZd4PbnZER7O/uZ6rKVO9jlvmkijDkXYnLsuI+8zyK6vP1G+sWXzkwj?=
 =?us-ascii?Q?yKdVF1Cf2/neOgezX8cPOvhTz/7KlZv73cAri+MnY/7/Ag4OcmRCsbHTcKha?=
 =?us-ascii?Q?jYDw5RgtHpCIS6VwZTXdyaBFL4+rinS75asENozs5AYbvJ6WPLIDGvgB6lI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 962ec33f-79b9-4e40-df04-08dd2fa51292
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 05:26:58.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6648

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, January 2, 2=
025 6:53 AM
>=20
> Receive and send buffer allocation was originally introduced to support
> DPDK's networking use case. These buffer sizes were further increased to
> meet DPDK performance requirements. However, these large buffers are
> unnecessary for any other UIO use cases.
> Restrict the allocation of receive and send buffers only for HV_NIC devic=
e
> type, saving 47 MB of memory per device.
>=20
> While at it, fix some of the syntax related issues in the touched code
> which are reported by "--strict" option of checkpatch.
>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20241125125015.1500-1-namjain@linux.microsoft=
.com/
> Rephrased commit msg as per Saurabh's suggestion.
> ---
>  drivers/uio/uio_hv_generic.c | 86 ++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 3976360d0096..1b19b5647495 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -296,51 +296,51 @@ hv_uio_probe(struct hv_device *dev,
>  	pdata->info.mem[MON_PAGE_MAP].size =3D PAGE_SIZE;
>  	pdata->info.mem[MON_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
>=20
> -	pdata->recv_buf =3D vzalloc(RECV_BUFFER_SIZE);
> -	if (pdata->recv_buf =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> -		goto fail_free_ring;
> +	if (channel->device_id =3D=3D HV_NIC) {
> +		pdata->recv_buf =3D vzalloc(RECV_BUFFER_SIZE);
> +		if (!pdata->recv_buf) {
> +			ret =3D -ENOMEM;
> +			goto fail_free_ring;
> +		}
> +
> +		ret =3D vmbus_establish_gpadl(channel, pdata->recv_buf,
> +					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> +		if (ret) {
> +			if (!pdata->recv_gpadl.decrypted)
> +				vfree(pdata->recv_buf);
> +			goto fail_close;
> +		}
> +
> +		/* put Global Physical Address Label in name */
> +		snprintf(pdata->recv_name, sizeof(pdata->recv_name),
> +			 "recv:%u", pdata->recv_gpadl.gpadl_handle);
> +		pdata->info.mem[RECV_BUF_MAP].name =3D pdata->recv_name;
> +		pdata->info.mem[RECV_BUF_MAP].addr =3D (uintptr_t)pdata->recv_buf;
> +		pdata->info.mem[RECV_BUF_MAP].size =3D RECV_BUFFER_SIZE;
> +		pdata->info.mem[RECV_BUF_MAP].memtype =3D UIO_MEM_VIRTUAL;
> +
> +		pdata->send_buf =3D vzalloc(SEND_BUFFER_SIZE);
> +		if (!pdata->send_buf) {
> +			ret =3D -ENOMEM;
> +			goto fail_close;
> +		}
> +
> +		ret =3D vmbus_establish_gpadl(channel, pdata->send_buf,
> +					    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> +		if (ret) {
> +			if (!pdata->send_gpadl.decrypted)
> +				vfree(pdata->send_buf);
> +			goto fail_close;
> +		}
> +
> +		snprintf(pdata->send_name, sizeof(pdata->send_name),
> +			 "send:%u", pdata->send_gpadl.gpadl_handle);
> +		pdata->info.mem[SEND_BUF_MAP].name =3D pdata->send_name;
> +		pdata->info.mem[SEND_BUF_MAP].addr =3D (uintptr_t)pdata-
> >send_buf;
> +		pdata->info.mem[SEND_BUF_MAP].size =3D SEND_BUFFER_SIZE;
> +		pdata->info.mem[SEND_BUF_MAP].memtype =3D UIO_MEM_VIRTUAL;
>  	}
>=20
> -	ret =3D vmbus_establish_gpadl(channel, pdata->recv_buf,
> -				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> -	if (ret) {
> -		if (!pdata->recv_gpadl.decrypted)
> -			vfree(pdata->recv_buf);
> -		goto fail_close;
> -	}
> -
> -	/* put Global Physical Address Label in name */
> -	snprintf(pdata->recv_name, sizeof(pdata->recv_name),
> -		 "recv:%u", pdata->recv_gpadl.gpadl_handle);
> -	pdata->info.mem[RECV_BUF_MAP].name =3D pdata->recv_name;
> -	pdata->info.mem[RECV_BUF_MAP].addr
> -		=3D (uintptr_t)pdata->recv_buf;
> -	pdata->info.mem[RECV_BUF_MAP].size =3D RECV_BUFFER_SIZE;
> -	pdata->info.mem[RECV_BUF_MAP].memtype =3D UIO_MEM_VIRTUAL;
> -
> -	pdata->send_buf =3D vzalloc(SEND_BUFFER_SIZE);
> -	if (pdata->send_buf =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> -		goto fail_close;
> -	}
> -
> -	ret =3D vmbus_establish_gpadl(channel, pdata->send_buf,
> -				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> -	if (ret) {
> -		if (!pdata->send_gpadl.decrypted)
> -			vfree(pdata->send_buf);
> -		goto fail_close;
> -	}
> -
> -	snprintf(pdata->send_name, sizeof(pdata->send_name),
> -		 "send:%u", pdata->send_gpadl.gpadl_handle);
> -	pdata->info.mem[SEND_BUF_MAP].name =3D pdata->send_name;
> -	pdata->info.mem[SEND_BUF_MAP].addr
> -		=3D (uintptr_t)pdata->send_buf;
> -	pdata->info.mem[SEND_BUF_MAP].size =3D SEND_BUFFER_SIZE;
> -	pdata->info.mem[SEND_BUF_MAP].memtype =3D UIO_MEM_VIRTUAL;
> -
>  	pdata->info.priv =3D pdata;
>  	pdata->device =3D dev;
>=20
>=20
> base-commit: 3d6fbc065983fabd3fcfef4d66c9cf8a587f9ddc
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

