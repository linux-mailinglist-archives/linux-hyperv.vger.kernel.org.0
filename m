Return-Path: <linux-hyperv+bounces-4493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C10A6027F
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC6719C5709
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED01F3FED;
	Thu, 13 Mar 2025 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JTzM+OmP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010015.outbound.protection.outlook.com [52.103.11.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099871BB6BA;
	Thu, 13 Mar 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897537; cv=fail; b=EqNRE/ogRB/bZIj4A6OnylTE6a96Q565Oy9uJ8PIve7n5vnMkefb4AQWNoCRaRpPxbb9/kTiAc0pNm4gw3OpEIj5MRYwAAeTBR+6UtNy2co5J28PCADRZ1rYNYrASeanKWREef8qPSAgWmO9EQjVyKWZkcGkHa+cWqVVeFfR9Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897537; c=relaxed/simple;
	bh=cEHElFtUNU+44+R/BcXBIsCO74WX1ylke0NxxtsHPo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LeCrrUwkXCZ5c/tAmcZHw7rsc5G8nnTvdojufNMtNbat2TdJ00fdYmOPZtBY2s+JYK96xd26ZaGUBxpHfLyz4ajnCoDUxAljEmhjcj/3AnX3o8zm3tdxEcy9Gu4UHL64La23+8T+IGMQ5WNB7ffpMQYynzChAiYX3PryHI/NRxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JTzM+OmP; arc=fail smtp.client-ip=52.103.11.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtrHzkzTvPncMBKyCOkcjtrJb1mgR+aX0+puNaQw8jnBadY8UAnqeuDlR4Arf17PsljDAwVcyKT+USiM/V/pf5nbtgmQop1OLdK/bJFM94t3noywO533aop0bJFMzQGulKqfZBBDFN+x3B0/xVjkNveiuSuIhl1s7DQd2x2kZlsQVR0c3+ilMWSpwzKnOtWpQHEFdEF9zJBif+/79VK+c+y3Ex/V2h2DfuN9fNcM0Idv4DkdBSTUJY5iuSa8HTnCcWKKl1uLrDacEZc0eWdUn66c5iYA2Q1LZveU8TwHFKxPSHS9ozaxrmN3CyG1gZFBsv7tdCeQaW74pb+qZNP8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWuxdVoQBI3b5g65YC0LxW0KeSxZ6P4YJGzDBMQ5ojo=;
 b=l4xnQmme0VuwfLThLjkKoaiX5k6cBKrEXJ40VdOsollqKFpD0hk1yfP+PNczUntBjU86YmqgwWubkrzKlOg0OL9mOe9w5vLHyb1kiVvBirwJVL1BF+gap4LXfX5ngan0a2tWTK9GceFZmzXRtpNyLp7atYWxtw7C7aWpk4TTkJ/jJehrS4gTMkywNYeQg80V31Jn3oUEG0VdL4lmt5AMgsoHOl4Uztifi/f8Blpd2e6cSc0UYv0NEG2wfX3hz5U9buUQmdrfyKDYVAgvZKPc12x5AJ8LSQquoKEMSf3+zAUBlBGzSgpvwOIDIdjRA8kVenAojrxOcD1B0G8bJSV+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWuxdVoQBI3b5g65YC0LxW0KeSxZ6P4YJGzDBMQ5ojo=;
 b=JTzM+OmPKTJTFR/zGk3v9XkV9oN9GiScIGpkSd66MIYMz7CDrfC+EZeu4Baahq9Lhjq+UtmP3cX/S+NHOTluqaHoTrJLYlbZRGtstyShUf+st2cuNHjMMw8c1eO6wwWAvn9yC8ar0Zz9zQ5T01fcdCuAvTIKEMn9Yg/PKC2V0BjXR2cKVn0gGV00QjRivhEx4AxSlk7TeIfa7n04JPfePaXgOHVbIdr9jHJ4EVod2SHlIe/COKDiQ2r5yIQQ4pgvsj3edJi5qLOAPfD3gUIk0DKZLAipdImrRc62mI5chEN4oqUyDzEJk5JmlWezxS0V97DnPuT2ErIdWUujfn6A3g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7559.namprd02.prod.outlook.com (2603:10b6:510:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 20:25:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:25:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Terry Junge <linuxhid@cosmicgizmosystems.com>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Alan Stern
	<stern@rowland.harvard.edu>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
	"syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com"
	<syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] HID: usbhid: Eliminate recurrent out-of-bounds bug in
 usbhid_parse()
Thread-Topic: [PATCH v2] HID: usbhid: Eliminate recurrent out-of-bounds bug in
 usbhid_parse()
Thread-Index: AQHbk52RqXqw8+JQMUCvyh0fnvLR/7Nxg/cg
Date: Thu, 13 Mar 2025 20:25:31 +0000
Message-ID:
 <SN6PR02MB4157BC3FE0722EC3736E75AFD4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250307045449.745634-1-linuxhid@cosmicgizmosystems.com>
 <20250312222333.2296363-1-linuxhid@cosmicgizmosystems.com>
In-Reply-To: <20250312222333.2296363-1-linuxhid@cosmicgizmosystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7559:EE_
x-ms-office365-filtering-correlation-id: df862510-6c50-431b-e258-08dd626d339a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|19110799003|15080799006|8060799006|3412199025|440099028|4302099013|102099032|10035399004|41001999003|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PytwUjHS09e2ZIe+Nv+eW52FUwwYMLSCL//qpXyPZh86/EMwnw05/NWMPnqR?=
 =?us-ascii?Q?LRLbZd/UaAxAvkl9wyGxs6vpoRSs+QvPHaRCj2Gne9bueTxBl7NJbXoDk/qh?=
 =?us-ascii?Q?bNfJG9IaS9vFCm+TTkLepwpfVJZ513lZKjyPudcu9sBc1Er/Mm/GWXK6o74v?=
 =?us-ascii?Q?U01dUH2jjbSHa2bWM31MbguJ2Y8tO0d/MgtOGadxDwvoqxIx9iAWo0ACgVCz?=
 =?us-ascii?Q?Unk1S7XaqsUGKe/hmM/IU0G8snnjaIGi4AA2bMx2bYqkYamtw//sWEp+879F?=
 =?us-ascii?Q?GoWd9imma2EWM8+z7WnuUnrKaUY69BSRT1Dx/+wsnfpIGndmsgDus8V+opa0?=
 =?us-ascii?Q?RfAPTEdlXcvy8tZ3KAxl6ofBf4EpfcL48f0WXv0Wi+NK2y3Z/V3ieVSzbD70?=
 =?us-ascii?Q?7nV2jG8SzS9mm/H8EABArSA6ZX8s8N4GbTDyVRe8pyNeFW5QdrEWODX3y2UK?=
 =?us-ascii?Q?sIiWseWB2aX/uO3eyOpbFcHog4xfBIlsmls+tGbr59IJFJvPx6GD4Vu7c7GX?=
 =?us-ascii?Q?51J6ZfbpsYlGxReKqI/4Yv2xerqLaLaHXKbX37qSkmYS0g+M5ucvBTwjC2OW?=
 =?us-ascii?Q?kTiDa40p0zsKLA15Dq/652zeUCjXZ/lO1FperWMK9Q9fji3+OiVw7q0gPpqj?=
 =?us-ascii?Q?ANI6eKDE6eILPQ3sLoQXESjOhN2HINrSoTH0hB8mmJR/GMwSjIcD5GSGkSkH?=
 =?us-ascii?Q?d0z45Nxj2JbI5GUEN30WGQthAiTJ1E3S5Qq0x09Lihz2UUTUtI3DUE3e+RpV?=
 =?us-ascii?Q?whqt31290pCuGylNgi+n5nkLJ8zuT8GI4W19DHbfPrLT4zROkX4wSHzkVAtb?=
 =?us-ascii?Q?gXvUNEQwTaeAIZwRddniaR9tHseQWjS7FNCcsOGB+lJqMfWUwz5hQQeNM06s?=
 =?us-ascii?Q?0D4M5isO+ukT1KIlKwfoGzLyGj4ULeIArsyQ+WVqs0xB30gCBgLHYhr92lF4?=
 =?us-ascii?Q?JkCVEGBQee7gGzz5kv6VDz3z+uK64aIqAjzeEh7svr+tz9xSS+MkZOX2QvJo?=
 =?us-ascii?Q?4kJVM5ef4I3JDUf3ISKRO/3Z3kYE9rNkB7kddS7463bIuoPE/d+UE59sBxHL?=
 =?us-ascii?Q?4w8H1wBW4w5xEUM6n5TpLqOCdb+aAiLDSZR/hnEtYMP+dokNbBrgO9uSGomi?=
 =?us-ascii?Q?mEj/tIYm9SiBb1efhoDy/vbbF2cTWIVQSuqK04DCLtmN/Q4GYFz7OU0h/TQG?=
 =?us-ascii?Q?ODxO3D4GJrX9ia8t?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tgWQ8PbSIxQf0Rtsu3GJaNqmuXqhTsnuxlRTzJiz+fFC5g6T0IXZV6YKLy4N?=
 =?us-ascii?Q?3/WsWCyIdbd2MtvchYHl5z/s9U82yv6YNO/Vpkg0cxPWPVnaSbqxMYPbPmuc?=
 =?us-ascii?Q?Bas5JqoQf9dgTDyycvrFSvsOSYw40repvVZq0ExY/RCusVDHXdzHV4FyrtIT?=
 =?us-ascii?Q?W2rgOJ6IpJ/NtRLinIO9eXG3desAVGIAj3z5un9mjHpSCsBYDZteT+sF1omV?=
 =?us-ascii?Q?JwFC8CrNmoUlLmehlL7HPQHeACuZjr1y5nLZkezRFr8LcDlmrQh6M2E2OzWF?=
 =?us-ascii?Q?/DP5IgH7CMHS9YLNiWdfs8dbSvQwCVJMkz2+1tDaT6I+ZjYp3VVWjjZ9r6hm?=
 =?us-ascii?Q?lwH1fHQbSkX2nWHmsAjVVmKmLHhS6CmSYWM8nI11sn9bQQwRZLpeXKzJo5dW?=
 =?us-ascii?Q?ZeDXFU8ffHgxnm7NYGpf3cwYO7FzgERxtTQo8rfqkNXWS/nzjgO+lC0Z2R5N?=
 =?us-ascii?Q?dp80LoKu2p23fRGmKxyrgshwEw4ctaIAwotP1sH/2Dl5ruydMxaQ7r9pmkmp?=
 =?us-ascii?Q?v91iGbPsddnji/ixjcKqWzcJw3mCfnlk9y5UqJ3Va1AMz2KRYawGVzM4h9ip?=
 =?us-ascii?Q?qd/XQnduiy4oif9TlpW8O4xh/mDVPVR3TzDOm0k2dGqpHLcLF9vdgLKdDCEE?=
 =?us-ascii?Q?ezvMzJqjyu93ZmlbS6f3Xqtbx+HmntWMUap0sKPFoCqtiwdAXNnyAFYupyPK?=
 =?us-ascii?Q?EhJWImx9HohmTQiGkwEhEls9BEpemcx2JntB/3IN6ubeG6EuH184ja4ohDwp?=
 =?us-ascii?Q?co4prrrZO6rrAt68oy+gcQ3ozDWPqOh/hyx5CzeTvd7Dv4jFx1YmrWiCnU63?=
 =?us-ascii?Q?IaufcbKTeDSuPdOHphZ0b1pYIZ1ag/9paARs9/tQrrM78Bl+ZoEVKM8f0Huq?=
 =?us-ascii?Q?EABtrd0E3Elc3qxeuOrWIQvON9nZciNGrUDIq+jx16Yw+cmxb2LJav2vsEXw?=
 =?us-ascii?Q?aWjVYEEPGDrX9uBWP5A8xR7pxOcAAYTnx4dGJdqa/L1FbmDozhXa9OQoWM+H?=
 =?us-ascii?Q?qp2K/dQFpSqD3xFxUAfR/KI4B9MOJnmlUhwxf+0CCX01qeJr2Cm8okw93D07?=
 =?us-ascii?Q?PHk716uEL/R5H0YdiU82TypGy9f7QE8nsq2S9UjKCaeNKz0aQwLIGF3QSvkH?=
 =?us-ascii?Q?Q9ajyK9oEX8phAcSVC1BVhoH82K71RmQ/tFxt9Nlw8PzcOndevcPXxo1eGE7?=
 =?us-ascii?Q?Ot3hBe5/NJbhc91QBmMMBOs1292RmmEQxgVxbVftJu4C1HnozlSGbivioNw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df862510-6c50-431b-e258-08dd626d339a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 20:25:31.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7559

From: Terry Junge <linuxhid@cosmicgizmosystems.com> Sent: Wednesday, March =
12, 2025 3:24 PM
>=20
> Update struct hid_descriptor to better reflect the mandatory and
> optional parts of the HID Descriptor as per USB HID 1.11 specification.
> Note: the kernel currently does not parse any optional HID class
> descriptors, only the mandatory report descriptor.
>=20
> Update all references to member element desc[0] to rpt_desc.
>=20
> Add test to verify bLength and bNumDescriptors values are valid.
>=20
> Replace the for loop with direct access to the mandatory HID class
> descriptor member for the report descriptor. This eliminates the
> possibility of getting an out-of-bounds fault.
>=20
> Add a warning message if the HID descriptor contains any unsupported
> optional HID class descriptors.
>=20
> Reported-by: syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc52569baf0c843f35495
> Fixes: f043bfc98c19 ("HID: usbhid: fix out-of-bounds bug")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
> ---
> v1: Remove unnecessary for loop searching for the report descriptor size.
> v2: Fix compiler warning.
> base-commit: 58c9bf3363e596d744f56616d407278ef5f97f5a
>=20
> P.S. This is an alternative to the solution proposed by Nikita Zhandarovi=
ch
> <n.zhandarovich@fintech.ru>
> Link: https://lore.kernel.org/all/20250131151600.410242-1-n.zhandarovich@=
fintech.ru/
>=20
>  include/linux/hid.h                 |  3 ++-
>  drivers/usb/gadget/function/f_hid.c | 12 ++++++------
>  drivers/hid/hid-hyperv.c            |  4 ++--
>  drivers/hid/usbhid/hid-core.c       | 25 ++++++++++++++-----------
>  4 files changed, 24 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index cdc0dc13c87f..7abc8c74bdd5 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -738,8 +738,9 @@ struct hid_descriptor {
>  	__le16 bcdHID;
>  	__u8  bCountryCode;
>  	__u8  bNumDescriptors;
> +	struct hid_class_descriptor rpt_desc;
>=20
> -	struct hid_class_descriptor desc[1];
> +	struct hid_class_descriptor opt_descs[];
>  } __attribute__ ((packed));
>=20
>  #define HID_DEVICE(b, g, ven, prod)					\
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/fun=
ction/f_hid.c
> index 740311c4fa24..c7a05f842745 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -144,8 +144,8 @@ static struct hid_descriptor hidg_desc =3D {
>  	.bcdHID				=3D cpu_to_le16(0x0101),
>  	.bCountryCode			=3D 0x00,
>  	.bNumDescriptors		=3D 0x1,
> -	/*.desc[0].bDescriptorType	=3D DYNAMIC */
> -	/*.desc[0].wDescriptorLenght	=3D DYNAMIC */
> +	/*.rpt_desc.bDescriptorType	=3D DYNAMIC */
> +	/*.rpt_desc.wDescriptorLength	=3D DYNAMIC */
>  };
>=20
>  /* Super-Speed Support */
> @@ -939,8 +939,8 @@ static int hidg_setup(struct usb_function *f,
>  			struct hid_descriptor hidg_desc_copy =3D hidg_desc;
>=20
>  			VDBG(cdev, "USB_REQ_GET_DESCRIPTOR: HID\n");
> -			hidg_desc_copy.desc[0].bDescriptorType =3D HID_DT_REPORT;
> -			hidg_desc_copy.desc[0].wDescriptorLength =3D
> +			hidg_desc_copy.rpt_desc.bDescriptorType =3D HID_DT_REPORT;
> +			hidg_desc_copy.rpt_desc.wDescriptorLength =3D
>  				cpu_to_le16(hidg->report_desc_length);
>=20
>  			length =3D min_t(unsigned short, length,
> @@ -1210,8 +1210,8 @@ static int hidg_bind(struct usb_configuration *c, s=
truct
> usb_function *f)
>  	 * We can use hidg_desc struct here but we should not relay
>  	 * that its content won't change after returning from this function.
>  	 */
> -	hidg_desc.desc[0].bDescriptorType =3D HID_DT_REPORT;
> -	hidg_desc.desc[0].wDescriptorLength =3D
> +	hidg_desc.rpt_desc.bDescriptorType =3D HID_DT_REPORT;
> +	hidg_desc.rpt_desc.wDescriptorLength =3D
>  		cpu_to_le16(hidg->report_desc_length);
>=20
>  	hidg_hs_in_ep_desc.bEndpointAddress =3D
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index 0fb210e40a41..9eafff0b6ea4 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -192,7 +192,7 @@ static void mousevsc_on_receive_device_info(struct mo=
usevsc_dev *input_device,
>  		goto cleanup;
>=20
>  	input_device->report_desc_size =3D le16_to_cpu(
> -					desc->desc[0].wDescriptorLength);
> +					desc->rpt_desc.wDescriptorLength);
>  	if (input_device->report_desc_size =3D=3D 0) {
>  		input_device->dev_info_status =3D -EINVAL;
>  		goto cleanup;
> @@ -210,7 +210,7 @@ static void mousevsc_on_receive_device_info(struct mo=
usevsc_dev *input_device,
>=20
>  	memcpy(input_device->report_desc,
>  	       ((unsigned char *)desc) + desc->bLength,
> -	       le16_to_cpu(desc->desc[0].wDescriptorLength));
> +	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
>=20
>  	/* Send the ack */
>  	memset(&ack, 0, sizeof(struct mousevsc_prt_msg));
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.=
c
> index a6eb6fe6130d..f8b853180680 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -983,12 +983,11 @@ static int usbhid_parse(struct hid_device *hid)
>  	struct usb_host_interface *interface =3D intf->cur_altsetting;
>  	struct usb_device *dev =3D interface_to_usbdev (intf);
>  	struct hid_descriptor *hdesc;
> +	struct hid_class_descriptor *hcdesc;
>  	u32 quirks =3D 0;
>  	unsigned int rsize =3D 0;
>  	char *rdesc;
> -	int ret, n;
> -	int num_descriptors;
> -	size_t offset =3D offsetof(struct hid_descriptor, desc);
> +	int ret;
>=20
>  	quirks =3D hid_lookup_quirk(hid);
>=20
> @@ -1010,20 +1009,19 @@ static int usbhid_parse(struct hid_device *hid)
>  		return -ENODEV;
>  	}
>=20
> -	if (hdesc->bLength < sizeof(struct hid_descriptor)) {
> -		dbg_hid("hid descriptor is too short\n");
> +	if (!hdesc->bNumDescriptors ||
> +	    hdesc->bLength !=3D sizeof(*hdesc) +
> +			      (hdesc->bNumDescriptors - 1) * sizeof(*hcdesc)) {
> +		dbg_hid("hid descriptor invalid, bLen=3D%hhu bNum=3D%hhu\n",
> +			hdesc->bLength, hdesc->bNumDescriptors);
>  		return -EINVAL;
>  	}
>=20
>  	hid->version =3D le16_to_cpu(hdesc->bcdHID);
>  	hid->country =3D hdesc->bCountryCode;
>=20
> -	num_descriptors =3D min_t(int, hdesc->bNumDescriptors,
> -	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor))=
;
> -
> -	for (n =3D 0; n < num_descriptors; n++)
> -		if (hdesc->desc[n].bDescriptorType =3D=3D HID_DT_REPORT)
> -			rsize =3D le16_to_cpu(hdesc->desc[n].wDescriptorLength);
> +	if (hdesc->rpt_desc.bDescriptorType =3D=3D HID_DT_REPORT)
> +		rsize =3D le16_to_cpu(hdesc->rpt_desc.wDescriptorLength);
>=20
>  	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
>  		dbg_hid("weird size of report descriptor (%u)\n", rsize);
> @@ -1051,6 +1049,11 @@ static int usbhid_parse(struct hid_device *hid)
>  		goto err;
>  	}
>=20
> +	if (hdesc->bNumDescriptors > 1)
> +		hid_warn(intf,
> +			"%u unsupported optional hid class descriptors\n",
> +			(int)(hdesc->bNumDescriptors - 1));
> +
>  	hid->quirks |=3D quirks;
>=20
>  	return 0;
> --
> 2.43.0
>=20

For the hid-hyperv.c changes,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

