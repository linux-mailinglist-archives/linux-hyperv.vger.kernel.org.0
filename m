Return-Path: <linux-hyperv+bounces-3310-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 755129C42F2
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2024 17:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062261F219E3
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50F14AD3F;
	Mon, 11 Nov 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dw5Z5Pe4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012057.outbound.protection.outlook.com [52.103.2.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EF219ED;
	Mon, 11 Nov 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343830; cv=fail; b=CJMQxoaVqFhnU5kYkF3o/H8dY/5wUct5RHpfuGd0gMzBBxTIyquITWE8GtidCtXIAOybAFGvASxLzS0etELxzONOP4yAweDAUTfTtKm+Rwvd0DdGcJ1sNwyGXrB7pCceQzM76Z9TCS3e6R6wkGJN15ciC/LsvAh64nUshHTusEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343830; c=relaxed/simple;
	bh=F9384LNsP3qxB4RKKOQJmSGOlLFkjjA+ojbUFzDNQMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SQ1ubKBlcNjJOD9wIKAUyOZS9/8M7tcu3pY3ZbTGutmhf8arzCO/pkiuiMcXA3CIRvbPm+myoKOKH8o7DCsSBsvyu0ju92Tzde/AbbXC+1Gn5/dAkc3Sc1mbKwTmJFQDqkJ5Wv7U7AwVSA9f2jp6xvy0YIow0BCaO+igor4d14Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dw5Z5Pe4; arc=fail smtp.client-ip=52.103.2.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcozDdzcA3WHcyW4xZrlh+EMKuaa+U1g+eq+TPU3pRDa94tAt5BfImUC2ALnCZ1dQMyMf84Qyj3ftiN+IsMoCSTy0bX03wJVysiePx8pDhhmJqM2bPAPtBFm5icexcm4KQg+PX4+9jz/fie4bmWh7BLcOEwO/qHYATBiWicYue+KzWaOFmL9zhni8FRQDwimpwyIPeC/tyaZvhV+f3joIVgJc04rnsceYGbyEyBAyVr128+RAoXKPH/tWMwCFITx6TPgoG9A+ghmplnf65GwpsAudRP59No7HnRRCqWthYyZqxTwaSc9ILn8AGI4ezwPKe0kX3VQokuxKhyTzoPpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTFnW0J/efHOdbAArIyqsd26AwuPk7Z4+V4TS4hkexo=;
 b=knzIfYQplDiiYzT5MJMmg5rU7P9JdV6Wl6MES2xNna5rd3smZNjp+35fH5w1mJAeVEM0si5ZVZKlnJHbNxOd1aLmJDFg9OtYCJrKBaedo20fwNeUvIlW72siDgqcWoFQGjx+4Sipkf1ezk/Gn0MvCn4VpTtarmD9YKAFaKQaPUYh73g7QWIZNJlzBYg3t6QG8Fmcr0mkhEvLC1EPM0qsPP9BZAGzmd1YPvOZHUZYNWTKgCN9IS4rLejhhNbdkmTH8QKYWVX5/aTM4r2XUIpVhJtTZD38xfHDojr/V0OTlxgvQo8lp0pxe1xPNV0sRG9SNIcdtuaFYKS013pG+Wix7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTFnW0J/efHOdbAArIyqsd26AwuPk7Z4+V4TS4hkexo=;
 b=dw5Z5Pe4GApyHl74rz46Q93AmZT0qRMQEopAh+veXc3/QgKHOf7W7ezkMxb5YDluxMmV8+PmHqQ7M3LDh/JWYfQZcBGKbuXH8/ZUEt3VrM0DE1P1Ftyk1pFYbJDGr1WqF9sE464tRIDJRTPmgPuomyxpAHoQApNyr8rI+V/Bo7evQv++LeXlaxDK6aUVkY++h9BNVjth4EeA6Jo1IbjbI6WrGnVXvodMhzG/JJtPEiqhcjLCJaOUi0ZfdzzGjhB4Xldf3sXKbPMsmdUaxT5FA1+9reysorx6Yq3GhAdXiQkBVB1nlprhsA9ZgJLgQfPWUKnv7uhUUEXVlmLzXE9OCg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9138.namprd02.prod.outlook.com (2603:10b6:610:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 16:50:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:50:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] HID: hyperv: streamline driver probe to avoid devres
 issues
Thread-Topic: [PATCH v2] HID: hyperv: streamline driver probe to avoid devres
 issues
Thread-Index: AQHbNDtrdSz4lArcmEWGXufH8jblVLKySjCA
Date: Mon, 11 Nov 2024 16:50:24 +0000
Message-ID:
 <SN6PR02MB41577C6B7BF387BEB9114A05D4582@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241111131240.35158-1-vkuznets@redhat.com>
In-Reply-To: <20241111131240.35158-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9138:EE_
x-ms-office365-filtering-correlation-id: 96adc657-93f8-4335-d59c-08dd0270f057
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|19110799003|15080799006|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IkDhBzGXWsWorcI2reWN0OQISmT46imzEoB7QP4YvlSnRUfOjZsRCfKp2egf?=
 =?us-ascii?Q?6J9FnIJ2KjP9raTKk5GPPX/7Kcx1riJk5fAIowJCRy370Wi5F3g1+ZVWcb8D?=
 =?us-ascii?Q?F+ZBDh5Jazlh3VAAIC/5o0HCDG4dXOPMgWCUWxs1+iKDZ8GN9zRjI99/g+s5?=
 =?us-ascii?Q?Uc5/mqGdhoRbGQG09Po+rOCEL4YWSz+wYo8w/VaiSPwlCIUklIA5IHjeElvK?=
 =?us-ascii?Q?z2cJ4QQBA0AOFyNX5HlGBUEHqp8+hlUUeG4hLhV05yGrLx3B7blNyVXKdrbL?=
 =?us-ascii?Q?7xlBEY89z8qFGQD02OD8+8774XniMqma+D2Jy632D0aqfhwA88LzbZWJsMNs?=
 =?us-ascii?Q?mG5QWI95A9ty7l5sX1Zslbg/gssmAFGxbep2vZumr65oSYTFa6hcguo7F7Xu?=
 =?us-ascii?Q?ZugLOCxYRtLLC8AG0+mO4Ho1LsHxfSyCdWtVVl3gKEGxzg6bijc6BzzQz1u9?=
 =?us-ascii?Q?lXX1+iNkVayfVoYm+9jA09ugFkf9HFgJIl5H54hmL+e43uuefC1HeV3CcZBf?=
 =?us-ascii?Q?6QrYyHTVq/hGCDrz0JW07pkr3/bZdNv8jV/siI43PQYEFA5txLvOFyuudsrt?=
 =?us-ascii?Q?jJXdN0+cj+6Re8m17hwltPg1CB5G4IiEHiuVAv7q1KOwAAja/gGqyoy5y6//?=
 =?us-ascii?Q?8VpzEsLj6YX8fGi2aAEPNFTYfkkbngXuihFZMbYw73gx0qmmX+b+2/fgtlT8?=
 =?us-ascii?Q?DelCrL6e9Xbn2QnwqGiEilkorttne+Ms3SRAIXxQgBRsl8QYlRr9cM/Ftx/i?=
 =?us-ascii?Q?vKKyZTkFRTIAUJelcxD+t+IoMRJDqRc4MgFI2xjSrU4GKQNjqUFAfmz+Spx4?=
 =?us-ascii?Q?E5xZGzbY0VxUUDZ6uP+1uAmeprnL+udGEoGkry0T5SijGJANGHoqdNU7HnJz?=
 =?us-ascii?Q?6Y1XbeCnI97ufDHRto87nnLyKiQS2EggPbucqGZRXFrtqZecppMmFGPc7zXo?=
 =?us-ascii?Q?ffZSD/jqeZJXBBeuf+xlO1E19EucTdh513vfL7f2m3o1uac61K924afb68wE?=
 =?us-ascii?Q?J/KcoAulchIosOwV/4oY0UCi+w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MPyUJVRCyA4slTA1Rih62f6PjxzzncDZKE8tQqQq/bsk9TvVIVXeuxng3I5H?=
 =?us-ascii?Q?qSBsYjFdNmPaCyD8kEndmj3cQ+UqoRP+fiNq53OZ8LMeQQMt5b0yFXEW4XMd?=
 =?us-ascii?Q?d/uO9JKTThnJoA/558+3gTne9mEmDspY98PNdd+mvMXGKLpHqpmUCY1Cz9Pb?=
 =?us-ascii?Q?47ya4x0FTCIjut6UUUZJfvjSdJzSo3nwMwcsezidLwfIkPov5YO7ZfWZA5Ci?=
 =?us-ascii?Q?82sbDsN1AQGCti+VdGCcjYwCS0Js3RgwG7Amyud/U8gaZQklasNTEya7T3iQ?=
 =?us-ascii?Q?aMqUiapgkGXuqkcPwfL/FWu5SiTChjeBPXQ6yJYvlYZP/HLZRXqTJZEVO3sr?=
 =?us-ascii?Q?7BgxADgitIHful99vp3e8jTy+QiN3k5xzf+vQE+pdLNX6kYL/FPe0AtL830n?=
 =?us-ascii?Q?pcKFxMwk3v/ZAlprIiTSUUXUOfuKtY6x83Jn08bUgQ27F8X2f7hyDbElOi4j?=
 =?us-ascii?Q?Mtmteq04xGOO9KRCU1599S1v/MpWa9SpG3oq+PXbyanoWuVXJJlqIsJTPA06?=
 =?us-ascii?Q?dTYcYjVKDal99z+kzXYlqGMhKJ5M+oU/tEg4oA239Uj4EJE0DPXjHJp3w217?=
 =?us-ascii?Q?mZN8xe+IzJyEcMQ6t3Rm7eEMXerQHAvlVXKYdR8ZchkeMTCH13XA9vPQY9H3?=
 =?us-ascii?Q?ykDTTAd/07uT3ypievzEb96/oFgzYnND4o4p2sJ7h4oSeCEKepwExmQKDNIw?=
 =?us-ascii?Q?XaT6s1PMMf0KaCAwF/m8+UWN2/5DmPQ2B6esTC+vYsWN2COVdF9tfbHa3wTR?=
 =?us-ascii?Q?ecaHfHmNExHDQ83g3w7h2VljrPIHPqcOF2suU5lqGNl6tAkdWRyxFcIywb2e?=
 =?us-ascii?Q?RCPiU51DQI0bcaNMMZ0boZvP1geoOYsjwKEuWyFF0/oDcfHejsrgQpl95h1c?=
 =?us-ascii?Q?c0zt0uMdV5vEhWzGw97Jn8HwYcYZ4LCcq3vEn3uhy9p9ATXuaypAkvNmo4NY?=
 =?us-ascii?Q?kTxkGbD2vFBT7UcB+zzLKJNs9cenSVxTNag228F/PlEjkOEOjFofN1XrZngO?=
 =?us-ascii?Q?DKdpRuUp3A3ywklXjLVDBWTxTI0u8BQnnpaErSJ2ETzU9ND3PzvmEpCgQaPf?=
 =?us-ascii?Q?BrlFPcN+C28WMbSkxQCeR2jsUt310cCGrbn6OZhXUwXkFRwiPjapjIm96WmT?=
 =?us-ascii?Q?VY7rOwpVTFZMjVGwnuxQ6ti3RqDh7/QSuIIb/Ps+UYUfLvAckDR2eC1kohRK?=
 =?us-ascii?Q?ntVuw1dzEL8zBptunBvDGQ3z3hYzvn1AP65QF5IWTVeCR8oGQp1havAFRlc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96adc657-93f8-4335-d59c-08dd0270f057
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 16:50:24.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9138

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, November 11, 202=
4 5:13 AM
>=20
> It was found that unloading 'hid_hyperv' module results in a devres
> complaint:
>=20
>  ...
>  hv_vmbus: unregistering driver hid_hyperv
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691
> devres_release_group+0x1f2/0x2c0
>  ...
>  Call Trace:
>   <TASK>
>   ? devres_release_group+0x1f2/0x2c0
>   ? __warn+0xd1/0x1c0
>   ? devres_release_group+0x1f2/0x2c0
>   ? report_bug+0x32a/0x3c0
>   ? handle_bug+0x53/0xa0
>   ? exc_invalid_op+0x18/0x50
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? devres_release_group+0x1f2/0x2c0
>   ? devres_release_group+0x90/0x2c0
>   ? rcu_is_watching+0x15/0xb0
>   ? __pfx_devres_release_group+0x10/0x10
>   hid_device_remove+0xf5/0x220
>   device_release_driver_internal+0x371/0x540
>   ? klist_put+0xf3/0x170
>   bus_remove_device+0x1f1/0x3f0
>   device_del+0x33f/0x8c0
>   ? __pfx_device_del+0x10/0x10
>   ? cleanup_srcu_struct+0x337/0x500
>   hid_destroy_device+0xc8/0x130
>   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
>   device_release_driver_internal+0x371/0x540
>   driver_detach+0xc5/0x180
>   bus_remove_driver+0x11e/0x2a0
>   ? __mutex_unlock_slowpath+0x160/0x5e0
>   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
>   ...
>=20
> And the issue seems to be that the corresponding devres group is not
> allocated. Normally, devres_open_group() is called from
> __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driver'
> with 'mousevsc_hid_driver' stub and basically re-implements
> __hid_device_probe() by calling hid_parse() and hid_hw_start() but not
> devres_open_group(). hid_device_probe() does not call __hid_device_probe(=
)
> for it. Later, when the driver is removed, hid_device_remove() calls
> devres_release_group() as it doesn't check whether hdev->driver was
> initially overridden or not.
>=20
> The issue seems to be related to the commit 62c68e7cee33 ("HID: ensure
> timely release of driver-allocated resources") but the commit itself seem=
s
> to be correct.
>=20
> Fix the issue by dropping the 'hid_dev->driver' override and using
> hid_register_driver()/hid_unregister_driver() instead. Alternatively, it
> would have been possible to rely on the default handling but
> HID_CONNECT_DEFAULT implies HID_CONNECT_HIDRAW and it doesn't seem to wor=
k
> for mousevsc as-is.
>=20
> Fixes: 62c68e7cee33 ("HID: ensure timely release of driver-allocated reso=
urces")
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1:
> - Keep custom HID driver for mousevsc but do it properly
> [Michael Kelley].
> - Add 'Fixes:' tag [Saurabh Singh Sengar].
> ---
>  drivers/hid/hid-hyperv.c | 58 ++++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index f33485d83d24..0fb210e40a41 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -422,6 +422,25 @@ static int mousevsc_hid_raw_request(struct hid_devic=
e *hid,
>  	return 0;
>  }
>=20
> +static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct h=
id_device_id *id)
> +{
> +	int ret;
> +
> +	ret =3D hid_parse(hid_dev);
> +	if (ret) {
> +		hid_err(hid_dev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV=
);
> +	if (ret) {
> +		hid_err(hid_dev, "hw start failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct hid_ll_driver mousevsc_ll_driver =3D {
>  	.parse =3D mousevsc_hid_parse,
>  	.open =3D mousevsc_hid_open,
> @@ -431,7 +450,16 @@ static const struct hid_ll_driver mousevsc_ll_driver=
 =3D {
>  	.raw_request =3D mousevsc_hid_raw_request,
>  };
>=20
> -static struct hid_driver mousevsc_hid_driver;
> +static const struct hid_device_id mousevsc_devices[] =3D {
> +	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
> +	{ }
> +};
> +
> +static struct hid_driver mousevsc_hid_driver =3D {
> +	.name =3D "hid-hyperv",
> +	.id_table =3D mousevsc_devices,
> +	.probe =3D mousevsc_hid_probe,
> +};
>=20
>  static int mousevsc_probe(struct hv_device *device,
>  			const struct hv_vmbus_device_id *dev_id)
> @@ -473,7 +501,6 @@ static int mousevsc_probe(struct hv_device *device,
>  	}
>=20
>  	hid_dev->ll_driver =3D &mousevsc_ll_driver;
> -	hid_dev->driver =3D &mousevsc_hid_driver;
>  	hid_dev->bus =3D BUS_VIRTUAL;
>  	hid_dev->vendor =3D input_dev->hid_dev_info.vendor;
>  	hid_dev->product =3D input_dev->hid_dev_info.product;
> @@ -488,20 +515,6 @@ static int mousevsc_probe(struct hv_device *device,
>  	if (ret)
>  		goto probe_err2;
>=20
> -
> -	ret =3D hid_parse(hid_dev);
> -	if (ret) {
> -		hid_err(hid_dev, "parse failed\n");
> -		goto probe_err2;
> -	}
> -
> -	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV=
);
> -
> -	if (ret) {
> -		hid_err(hid_dev, "hw start failed\n");
> -		goto probe_err2;
> -	}
> -
>  	device_init_wakeup(&device->device, true);
>=20
>  	input_dev->connected =3D true;
> @@ -579,12 +592,23 @@ static struct  hv_driver mousevsc_drv =3D {
>=20
>  static int __init mousevsc_init(void)
>  {
> -	return vmbus_driver_register(&mousevsc_drv);
> +	int ret;
> +
> +	ret =3D hid_register_driver(&mousevsc_hid_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D vmbus_driver_register(&mousevsc_drv);
> +	if (ret)
> +		hid_unregister_driver(&mousevsc_hid_driver);
> +
> +	return ret;
>  }
>=20
>  static void __exit mousevsc_exit(void)
>  {
>  	vmbus_driver_unregister(&mousevsc_drv);
> +	hid_unregister_driver(&mousevsc_hid_driver);
>  }
>=20
>  MODULE_LICENSE("GPL");
> --
> 2.47.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

