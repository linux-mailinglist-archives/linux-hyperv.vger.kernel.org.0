Return-Path: <linux-hyperv+bounces-6744-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4279B44D98
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 07:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ADD1BC5679
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 05:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6C271A94;
	Fri,  5 Sep 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QTNBJdFA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2108.outbound.protection.outlook.com [40.92.18.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4681EE7B7
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Sep 2025 05:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050550; cv=fail; b=XY+dJZnTHtYdrff4jjgVKFBpw57WUKou2T7MJwn9hUOVaTsQRtDtziWT30rivFe4v2SO+jgZWVZa9Xcf4CjqIm0H5+CAOT36O11KQdiSTvjDEU05qUNWEs3rhwiwCNC3ZfxtpoNEt7BJQlsCQUWIst1rJ3x3hp8KOlV09CHaaM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050550; c=relaxed/simple;
	bh=LCW0pf/f8I8bA1mEWUhWCKsW1r9zX9W9kzLZD9VuZ7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJT37bcSk1JnxFvsN4Z4mZH7HP9hD7lAOQTxu6JmJt4FqZfPrtV1A1HWu7JSYirqJ6bGfhSzHDjZtlzbdJRYoxbMF3VaKQZ+SU2SWXgLYJCpsXqPe83Xq5W2t+YTKUfDiKD5LSFoIXlytivYQo53tYEVtfqHevtjtDx6cAdREVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QTNBJdFA; arc=fail smtp.client-ip=40.92.18.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaAtrdT+4NpJyxQcfLr3eAQGaBWPVOZBR1lFNm0gkep+OmbCcV8hL60j+SAXV8HHJFQhlzPey2pQcZM9r0jsRuYxN9ZBzyS7bEi6sKSM2iYM2ftWWmdtFrK559BvpulddaXrcFoLGuEMoWpdFImO7vhLUuAsFHfqYspY3oJ1TrgRTMAo4Q20JLmsOvzAUVvAQpwSpltdRzmO5ynBjdnhxgv/c38Yn6erPFqM+4yoGICLZjNFwJkrKKyztWe5CvdsXwCWzjGSH69v3nrys54L86FuN2XONjXucZaMIO6IQOfMqwOy9abMqm7p51BbWhyUdswetS2VOHjWIPV0mPi6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9MlCbHTD1U/6PGP0z42U+JL9ZYDSrIr+7vGKmtp3kw=;
 b=Z7QjVePnTzshvbIUSmSknGAKq87RXNjEv0VRHpBZpRewVLWEEkOEB88QnBSnR+8DLXu/MInJtYvXFT1ITpFzWEjtSLAU+LmLmJfKfXHJ5+1TAYlWyJg2xwL5VrSOFfpOgXHCBSqbwdZ/5svsTeAYOCJCFYpPVdoWSI/QNIKgvI0fXJZIKkIPDZz+unyi+iRuP+uvP0AFcqUG02e08O3sppak9YWvLSFDlp85C4jBuRDDQGxvUiDuAuIDUzc5I2dUX/Zcflb8t+FqheOneJcHjh71WfaeWftBs85Y3ffxmKJKj8vHGYJ8w3eiV8rPLNR7NvseRx0OxS3xrokx419kXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9MlCbHTD1U/6PGP0z42U+JL9ZYDSrIr+7vGKmtp3kw=;
 b=QTNBJdFAu5uY7tn2iv5N4GGDED83IN0G5mq0+mtc7YBLdHe1YkXHwQn17gij9OlqOrDb7loWNaDHheGSSJzcMR8+BZc7+lGTvoAJVnZypPl+gl32Lk9I1iPGfrPRiAsTMh09H7l7w6mgLNggsaZKFd/ZObG5QKaY47OLd/oWGnVFVwBYqFmIqBqpsrfi5UCHQ/st4DfMAgkOUgw/uxewKQMFhfHWG2+yVL2SFyaydDkhyMdO6ww0apjO2h0z2AneFzyuH0IybNi4WANqqPGgtQ2UkRUb4i6YDcnGDp+Mtb6DbcEK3l81l3ZunZlYRw4ypRloUysHHw2B1odaJmHmhQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN6PR02MB10630.namprd02.prod.outlook.com (2603:10b6:208:4f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 05:35:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.027; Fri, 5 Sep 2025
 05:35:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "louis.chauvet@bootlin.com"
	<louis.chauvet@bootlin.com>, "drawat.floss@gmail.com"
	<drawat.floss@gmail.com>, "hamohammed.sa@gmail.com"
	<hamohammed.sa@gmail.com>, "melissa.srw@gmail.com" <melissa.srw@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "airlied@gmail.com" <airlied@gmail.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
	"lyude@redhat.com" <lyude@redhat.com>, "javierm@redhat.com"
	<javierm@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 0/4] drm: Add vblank timers for devices without
 interrupts
Thread-Topic: [PATCH v3 0/4] drm: Add vblank timers for devices without
 interrupts
Thread-Index: AQHcHay/1LhJS9Qt20a/N81nkOUA8bSED7IA
Date: Fri, 5 Sep 2025 05:35:39 +0000
Message-ID:
 <SN6PR02MB4157E793515BE2B63615AD92D403A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250904145806.430568-1-tzimmermann@suse.de>
In-Reply-To: <20250904145806.430568-1-tzimmermann@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN6PR02MB10630:EE_
x-ms-office365-filtering-correlation-id: e82cbfab-b62d-465c-2f1e-08ddec3e0c23
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|13091999003|8060799015|19110799012|8062599012|31061999003|1602099012|40105399003|440099028|3412199025|4302099013|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?utP15nYZm/9jV6f052lgP4afDRcRh7gNTUaGNcyuIoy2zfC6sAQVDAjoXVL/?=
 =?us-ascii?Q?XjKv7BtELxjY4O+V5BHsEvfkKe6tylAFIRg86pQqaAfN78hByY/YYvH05EhZ?=
 =?us-ascii?Q?NfbcMlbjLczEyYIUop9DLp6f5q5hc1lXHgn56MUsU0reGlbwRd+xgrIlaDh7?=
 =?us-ascii?Q?LmSr1QKtlaj5FHT5Qxo4NWuhpSvuHg5uPYnJwIcAcfPZooSP2TMXMtY1g7YA?=
 =?us-ascii?Q?U4uvXRwqznFa0gu6Lh++xqCpIjX+P40P30sGE+i9rl2rrlHUNBQ9KUAUWwEc?=
 =?us-ascii?Q?QkotqaAPxEyYfdSSLNXwg133jvNrsT9VobWvOtKpbaLytyaigd7MWzIH8kTT?=
 =?us-ascii?Q?3foZ5/oXMU0o9lMVQpYUku0NeSbAsh8uOshUHtdIEFkUXhPUEVhcc3aVLXNy?=
 =?us-ascii?Q?iM9Soy55oAT60qc6Okb5bdVThMU16JLoWuj2OtByeBb+Aub8IuCywvF9Sn2s?=
 =?us-ascii?Q?xw/1VlrSZv1tCNPSNfbM7w+8+VkJJIXpkRqSkroK0b3PnvQtFqr+mjjtwXT4?=
 =?us-ascii?Q?Dz4j03ViCaxMGUytGi+XGTdtJPHbYtmAYKaQUMtNt8RyqUR2iMEXhyLHlt1N?=
 =?us-ascii?Q?Qea1XX3BJNyhTXsOPAnPLas5wPiWJiPtAS6qqWfEvpwgjFaeXp6wqk2KbIDx?=
 =?us-ascii?Q?tx8zKa1Dj1Jm256C2+x0fG/O1Axi9x/Njp7wdrm4ukhB+tpHSuFAdq8dI6qY?=
 =?us-ascii?Q?haXpQDQsMsRW7FSygK174MOu/3W3j+yfP3VbwWNwsTYHvyYnqTLiw0j/WdlU?=
 =?us-ascii?Q?WlJlrowjLkwvQpaI+mNUeJAdADeLZL2bOQYu0LOCN4eUvUJskV5ngiWqGkm1?=
 =?us-ascii?Q?0S3F9nR4kLdZyoet3z8KFzt89SOz/dXw0cJS+N+8L8eLwfFOmL7HMeKapOwZ?=
 =?us-ascii?Q?/6NxFAuLoM0fLpq9DQizwWdm75QgFNZiz9b5qoXv0STN2V+t4jzXK4XNowgI?=
 =?us-ascii?Q?5zcn5zRbuqhcmK9CjBoqvJ5wyhya6OSRVoZYpEvH8kBKkK5zE6qRl8z2cAqe?=
 =?us-ascii?Q?OXi2rRz7S3UD/Ud045saqIHVc8sasy8IWJUIJrPa27P+1ARXX3DMC0TqM3eF?=
 =?us-ascii?Q?gnr+kfCYesjpygx97q6mHLOXjgqwXPu/fb0n8pSvdJ0Hj6j+dCxjU/jqgYrM?=
 =?us-ascii?Q?WQiUGdMsyK1GywbfVXR4zXMe3Ea3ttZpz15GrJCTHfJDNRnxioGENrQjwpgT?=
 =?us-ascii?Q?/RfXGMI2xSSR/zMg3EWEJGO2vlDnDcLhfDQM0fLVlFtYBgZmd7SKCw9pJVX+?=
 =?us-ascii?Q?RIwVpkxUbYKqebBby8wP?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JpunazQfSTKiFoLctf8d4LKsBrQdPiTV4JLusvyR9KswC6bzBxHE5EPhoDaE?=
 =?us-ascii?Q?l67emYwKCWjFCLLGleL0eFvYHAUlddZ0zkfcxEtg6a9ZpxuR5aoIFuCMA8WZ?=
 =?us-ascii?Q?xvjIrC0N1timcU1WNNm6tncX/WrYPyensrvcjEER2fP6o0zefslNs5JicULR?=
 =?us-ascii?Q?T5riDdzPjUCaf2bPen/xGGtsrbftVGDI3tIxXp8yu4VJG9cXQbajgw5UWCYV?=
 =?us-ascii?Q?JJcM1ghQcWzrC/ZTVPhvDLwunovBgD/yBW3bs3xDRq4Jav1GUj+ZecKtxpmm?=
 =?us-ascii?Q?88zVxo+sJON0P9YUjt863hpbwTefz9T9q2tGoQS+rVShuhgy21eqp1SSm/MZ?=
 =?us-ascii?Q?xIlIzkPCPj2ygJxRGqxIo7P8lF4ev2FAlxXeT0b7/V4iNneZ3JKDZFSG7z45?=
 =?us-ascii?Q?ji+Xi2ctpx/F2vUwCOk2rdnrPD03Qhl88Rdss37dbPun1D/1MTnGwSHB8W4t?=
 =?us-ascii?Q?gHK0VCYycn+sdDD75lE8jAyCG99HHUHffbX6L5fGc8MnUQK/cffCt2ymBG9R?=
 =?us-ascii?Q?MyHqgSSlQd//OFO5/nqfaphuxFodWcTKfIxI2/525bf7CttzFJoO7BDN/ZVC?=
 =?us-ascii?Q?1phMSAirB1d6BkALyfjhHYqnZ4HM1SdQxD6v2L7CiF3EzZXEbLt+lLlsc17b?=
 =?us-ascii?Q?Slrty8khXwT0jrQSLVTYzXwkjog7Gwvbl6qKOvNxyoMpsUazIFYnwlj4VKbH?=
 =?us-ascii?Q?wvLUnNqIAyujLhNfzhKc0wE7mCYXDOae5tn0jRTBvaOBe8hCVV4FVlItkrOK?=
 =?us-ascii?Q?vWf1QsK93PgHwYq8Dnyei08zXF694m8XdfAVQZHR2ccmpg3tFPY5Z6qV5VJ6?=
 =?us-ascii?Q?snFQJOVZB3PYtqPsMEH4mIGV4+rnPyibDZ2crKaTvx9da7IbqtPz7CdUd3EF?=
 =?us-ascii?Q?scVPBmQJ7cenqUswlaTaIylg8fs6nT+jbPP3az/h067R6cUu1CPBpAQEKF0e?=
 =?us-ascii?Q?caEK94qd6Q+XnUt+3SDp6qLr2zQZOa4WZgNGe7i3f+/ISsdGRVKTqVxlQS+7?=
 =?us-ascii?Q?7vfy9CRG2Mkzxxp7H5fkSLiPC58nuKCKTxpOfbkWHoQXo5/I7cY1H6Oipb9u?=
 =?us-ascii?Q?rZXO970VdFFZjvqffafJNYDu+ypiby5TEcmldzkpnpqKVrXhgBS+PZQjrl56?=
 =?us-ascii?Q?2jFzITsfQOCJiIeZoszcL5TouTiF3PGtE9yclFvSWw59+aSp1kf9+o/Y0iyG?=
 =?us-ascii?Q?dPV10KsUjAQcKfimxFcYTRTqx0nnqIiVud9nfO8s+iew6ghfgUtwO98KS2I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e82cbfab-b62d-465c-2f1e-08ddec3e0c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 05:35:39.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10630

From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Thursday, September 4, =
2025 7:56 AM
>=20
> Compositors often depend on vblanks to limit their display-update
> rate. Without, they see vblank events ASAP, which breaks the rate-
> limit feature. This creates high CPU overhead. It is especially a
> problem with virtual devices with fast framebuffer access.
>=20
> The series moves vkms' vblank timer to DRM and converts the hyperv
> DRM driver. An earlier version of this series contains examples of
> other updated drivers. In principle, any DRM driver without vblank
> hardware can use the timer.

I've tested this patch set in a Hyper-V guest against the linux-next2025082=
9
kernel. All looks good. Results and perf are the same as reported here [4].
So far I haven't seen the "vblank timer overrun" error, which is consistent
with the changes you made since my earlier testing. I'll keep running this
test kernel for a while to see if anything anomalous occurs.

For Patches 1, 2, and 4 of the series on a Hyper-V guest,

Tested-by: Michael Kelley <mhklinux@outlook.com>

[4] https://lore.kernel.org/dri-devel/20250523161522.409504-1-mhklinux@outl=
ook.com/T/#m2e288dddaf7b3c025bbbf88da4b4c39e7aa950a7

>=20
> The series has been motivated by a recent discussion about hypervdrm [1]
> and other long-standing bug reports. [2][3]
>=20
> v3:
> - fix deadlock (Ville, Lyude)
> v2:
> - rework interfaces
>=20
> [1] https://lore.kernel.org/dri-devel/20250523161522.409504-1-mhklinux@ou=
tlook.com/T/#ma2ebb52b60bfb0325879349377738fadcd7cb7ef
> [2] https://bugzilla.suse.com/show_bug.cgi?id=3D1189174
> [3] https://invent.kde.org/plasma/kwin/-/merge_requests/1229#note_284606
>=20
> Thomas Zimmermann (4):
>   drm/vblank: Add vblank timer
>   drm/vblank: Add CRTC helpers for simple use cases
>   drm/vkms: Convert to DRM's vblank timer
>   drm/hypervdrm: Use vblank timer
>=20
>  Documentation/gpu/drm-kms-helpers.rst       |  12 ++
>  drivers/gpu/drm/Makefile                    |   3 +-
>  drivers/gpu/drm/drm_vblank.c                | 161 +++++++++++++++++-
>  drivers/gpu/drm/drm_vblank_helper.c         | 176 ++++++++++++++++++++
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  11 ++
>  drivers/gpu/drm/vkms/vkms_crtc.c            |  83 +--------
>  drivers/gpu/drm/vkms/vkms_drv.h             |   2 -
>  include/drm/drm_modeset_helper_vtables.h    |  12 ++
>  include/drm/drm_vblank.h                    |  32 ++++
>  include/drm/drm_vblank_helper.h             |  56 +++++++
>  10 files changed, 467 insertions(+), 81 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_vblank_helper.c
>  create mode 100644 include/drm/drm_vblank_helper.h
>=20
> --
> 2.50.1


