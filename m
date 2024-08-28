Return-Path: <linux-hyperv+bounces-2899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1CE962ADE
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FE81F245BF
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0491A08DB;
	Wed, 28 Aug 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fKhBUv7e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010078.outbound.protection.outlook.com [52.103.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE051A08AF;
	Wed, 28 Aug 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856841; cv=fail; b=Rpy/VbuDHHc+lknY70tVzGyVBjTGZI55zNXSuJ9qjPkOZ59ND9bcJAAOpNTK3hBpHYq7JGgimux3yIUaesB0O15/e4XIAhtDoytyyNpKa8WdySLg9RnG6EfD8NEgRZxBzKWIhAqGBJtRSn31ec9Z0HnG8NA4PQGIXL/EqirS4YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856841; c=relaxed/simple;
	bh=vajn8yJkoGzVg0vlVLnRbf31/KNlcYrLykCaZooIuEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ca7WYGW+ggINJLfK7G8v4MGCfB2H5mv2t2BdnLZ6qx1czqKqbj7m8IFfGRT4L0yZwNEhpi+rLqZOTY27tjU1/tpqV4kSknBbNF695rRuq+dFeq5J5ET4v+lxbkir0sBgdJ9WVjCaxHIeqLZcZfDYlXgziD/S8/mVoZmIW2ip7a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fKhBUv7e; arc=fail smtp.client-ip=52.103.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kB0R4wgci/AxlDaggRjHClS12/wMLeNnvHOOhW5i7PfEPeNai8o//2jZKgsqT49waSl1WTl1wZBti4VUOOKdfM5ycocEYxQtNN2HMOhUV9hhRQlGxQ+E6kT/oXTGGu4XvCLYGCjTp4pC3AQ4ciG8N66vD36lEb8+rYIBOyjVp89UrNrTq1qNjCa5kbn56HI/U5qxFs1aymvKp+QyUhRPUJ8+gQr5uam7ubPmOUgKxLD1ejx9yDjhdA1q2OedjX57j3BMO8/gE65sb+l5ntK1Zr/K1D/kK9ly5E5Ygez+iF43i+v+FZZg9n9KiFY0ahBwI2L0qMVnwSxJr9/H2jdW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTRN/7OQzC5LXEq3b9gTqPI5kAM9cGxO3IIX6e9l/W4=;
 b=kBE00rAQR/5oJtlTPxsaDWFHw8tA3PqPCm5WRg/ekEHur/2/RU39BgoEBUSx3RUSoYSLyIwJg21f5mTxtCXtpACmU1c0Kw/AoHHA42nRHWuZlUZ5hgMJKHIHFBELCowNlnCPhgdwQzv56UifRgZM72vciGfeQEI4w+LjqM14te+uOd41yzcFb0ZS3jt7lRWMhum1NOQvkZYwFqsO38GfttokPw74Kf1TGWm7z60dGKYA1ZA0GtLwTFN4RlCEVruVXfTu7lKsctTuRIjqR1dnE1cf1ToBSKRHYEM0QAm+B/cbTm5RIGFO7poqf7Lc21UC1ovP8aIsN6wk2PmDoaCI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTRN/7OQzC5LXEq3b9gTqPI5kAM9cGxO3IIX6e9l/W4=;
 b=fKhBUv7e+tbODjEpHR/pswSO+1uMR0QZlo1K3h++q107IKKoZa+SBlNk+Y1z+JQmIgh/XAPWSgnfFs/+ocSaewsC8xDuteavnjQamhd+Kyjkt/8d0fEkotbKafz29XMgs6ZmFRxnlqXaPHLrQhckSvMr1nQaCLMJMGnMqPYt6E2LG2pX4lBxySauTYocWYfF7oRHE0oTKRGmRbjMqTGthDTwSj+RuRIse36Z9uz127AvhlCwceJ56piIBPGo5t4MHrqqcknPhav194KbYAttBLZY6cVcgGEec5LgxnhtF0XPXpG0Zu6UxSth/Fw3svF4iM5iWj8FgNj8hy5WMtbTyw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7119.namprd02.prod.outlook.com (2603:10b6:a03:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 14:53:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Wed, 28 Aug 2024
 14:53:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Stephen Hemminger <stephen@networkplumber.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Thread-Topic: [PATCH 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Thread-Index: AQHa9IPP2ZEuiKarEkiNA338VE6Og7I3SmgwgAG/A4CAAAG7YIACaGwAgAFWDYA=
Date: Wed, 28 Aug 2024 14:53:56 +0000
Message-ID:
 <SN6PR02MB4157E8227056DCA579A9E3EBD4952@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157FB898345A1A8B88D1F4DD48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a447911b-ef12-46de-ba01-13105e34b8fe@linux.microsoft.com>
 <SN6PR02MB415711F672364610BBE6861DD48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240827182406.GA32019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240827182406.GA32019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [wSEPfzpQEUw5qu0wioN6792qo7f1BKbX]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7119:EE_
x-ms-office365-filtering-correlation-id: 4c1c1182-4dfd-4ff2-13cd-08dcc7713e1d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8060799006|15080799006|56899033|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 0dt+2t07/nkrUIELV1C14bTgQqLia8tuQg6dDtXuV4TNJXKlT3xbIjHYUBpEpx49wSFNnViVXFiKKXrjqwT9WeQGupEiMISs0epRYpS6MIBXza7J9X07uINQCLbg4zjoJn2S9MehntKUbgcuUg3OQvZpxvePRP9msbaLsVsdL5z50lrJgUb0Ntx058JzSdF48n2i8qTeg2FnQk44ngP8gU+EuM+ZE86fDXcR8jQOfa2U07fZ/8lby//Dz14XesDHVba7QHmr9DzAD0zmGP0vBUrUQEH4iTtdOR+z2MJIek4n8ONMM/e7hVvutgGj/52UaNXSWM/GHAXP1mbUKRkHieVTCG0Ae9QSQdDsQtBmxa7R8cdyz7OOvlne8CCQpuQV2MYu7NkmIicMdDhtM6ayTnZOeBbInROdAKfMGAM3cOhr3RzOXwHXMMwo8qbiImBYz9//M23t638vvoorUMO9fqD2F6kt9YngJDuMejmdPA+bWqv6QA1gr3ArCRgt3CWfyTbM+/ZaeAWQJDoXxF9mPu+OYh8Bw5C2vUEBNTE0JjHIt2cxsPHWxNZ443w36r60PSIp8/+2v+Df+SpKKm4OLFFSqJ7VcMZ1On1K22BTSIrRYAyuaOoRAj+pieFiF6izgs5Zvot71EC1k1KQU6RjGzv0omeKTcWBLz0oTLzoJ8sdO2b8UsEJ0HYVhrxNMtKf
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GThzisDOOcdD5xnvfaXJvS5KkLg8MISmUoo72VJgb7mgBrbMBLGvjAo5/Mjl?=
 =?us-ascii?Q?afEcFoKsMC3Z2dxm2yjjBIN+IpBt6E38OwD1/5F49zgM042TcOjC9ivXW8K/?=
 =?us-ascii?Q?gvieYaiwP6hc5KJGIx6Y8SM2bGmck1Ko98Xs8GFI+GT5Zyw06wltM6nu++8v?=
 =?us-ascii?Q?xQ/pmdGzMxFF0B5B3g+0Ht2jKbCIhsBF1X+J67kfM+Xlokq0CphZsiStjzRC?=
 =?us-ascii?Q?gPy4HX/QNp8t3Z6hxxGVF4WD/HGwClfkm6Zy+kBxA7y0RAUL9NYUdBB4L/v+?=
 =?us-ascii?Q?xz1xhx0H9dgOixWTFmNLytuc9ggXFbz2QiEhMsTuXD2GZ8qiGHKKtBN/kLID?=
 =?us-ascii?Q?FdAmA4E0Vyj1e17EcgPNEh2UmTXVDYiB4aFFHHmv1H9+qF3lcXoUR5yQO/ST?=
 =?us-ascii?Q?J1QwD51U90iTI4GMFqgUosFVgmfx+VIYD2Ax3eFCr+bT4rExuJjR1insUq+J?=
 =?us-ascii?Q?5LQkacjZktjgkVWF8moJkIwmJoOFBmFZwmCDwe6gPGGORLcCyQrhoypF5P2E?=
 =?us-ascii?Q?AJfwT+oa47UAZsprsJtwnltmXiZ50Qb4nmqSWEav+GCGE/H2ZFhKTZgPeYug?=
 =?us-ascii?Q?pSFV4vh+lL9zrHFqzUED5IxbiBmyCrY2ifste9d+Si2DUiLFG7liUirk+UIp?=
 =?us-ascii?Q?pHF6q5Wc6btfFnugAAO6fndraplIOFL1AVSPHnDNX9YmsUrMhBaBB/W/Umbr?=
 =?us-ascii?Q?t7/BJ/uivEXgAQ+Y62hBIVTYG6PkngC23UtmoDUz9c6SOrNDMXLma5q56+rq?=
 =?us-ascii?Q?oDgX/0Y4zFaZXEegGaAKH8yoZI5JI0rH2UrzMyM6kFM9HLdXihfqMmLDqRpY?=
 =?us-ascii?Q?+0basJoXe0/ykuWQE0b2C608LW+fomxa5QVGyyFKdPnoIpnHSA8A/M0VVtrn?=
 =?us-ascii?Q?SrIHwPIdN5dHrH3JEFfcREu7uudU1AFrPxLgfjXIgLKKYObW/gYlnJcmC2gb?=
 =?us-ascii?Q?kQ32y8S+i/i5iT+kzgcrGikMgwfT/ymF+EUYS5kZjPHlEJ3+Z0dx6IPLW4qb?=
 =?us-ascii?Q?qnfycZ4HOPVW04r7BTPKB1bKewIARuQM+jwYiaW9v0HLoGGieXp6HU55T8pc?=
 =?us-ascii?Q?UmFQD5jN5Km8PI6NVOJMJIxvOC6gMyDhxv4VMaMGBlS26+eDIJWEsFomIf2A?=
 =?us-ascii?Q?5HSV9yvxTHYW+bdD4ei4y+QJ6lGIeAaqHt2SDnV0bdBIwsnKWDDDU76g7/8y?=
 =?us-ascii?Q?Psxt52QTrRemn7NzMNog8+1GPySx6WZMcfRQr6JfLS6hluMNrgg25RMM9gU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1c1182-4dfd-4ff2-13cd-08dcc7713e1d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 14:53:56.6875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7119

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, Aug=
ust 27, 2024 11:24 AM
>=20
> On Mon, Aug 26, 2024 at 05:40:37AM +0000, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Sunday, August 25,=
 2024 10:32 PM
> > >
> > > On 8/25/2024 8:27 AM, Michael Kelley wrote:
> > > > From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, Augu=
st 22, 2024 4:09 AM
> > > >>
> > > >> Rescind offer handling relies on rescind callbacks for some of the
> > > >> resources cleanup, if they are registered. It does not unregister
> > > >> vmbus device for the primary channel closure, when callback is
> > > >> registered.
> > > >> Add logic to unregister vmbus for the primary channel in rescind c=
allback
> > > >> to ensure channel removal and relid release, and to ensure rescind=
 flag
> > > >> is false when driver probe happens again.
> > > >>
> > > >> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> > > >> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > >> ---
> > > >>   drivers/hv/vmbus_drv.c       | 1 +
> > > >>   drivers/uio/uio_hv_generic.c | 7 +++++++
> > > >>   2 files changed, 8 insertions(+)
> > > >>
> > > >> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > >> index c857dc3975be..4bae382a3eb4 100644
> > > >> --- a/drivers/hv/vmbus_drv.c
> > > >> +++ b/drivers/hv/vmbus_drv.c
> > > >> @@ -1952,6 +1952,7 @@ void vmbus_device_unregister(struct hv_devic=
e *device_obj)
> > > >>   	 */
> > > >>   	device_unregister(&device_obj->device);
> > > >>   }
> > > >> +EXPORT_SYMBOL_GPL(vmbus_device_unregister);
> > > >>
> > > >>   #ifdef CONFIG_ACPI
> > > >>   /*
> > > >> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_gen=
eric.c
> > > >> index c99890c16d29..ea26c0b460d6 100644
> > > >> --- a/drivers/uio/uio_hv_generic.c
> > > >> +++ b/drivers/uio/uio_hv_generic.c
> > > >> @@ -121,6 +121,13 @@ static void hv_uio_rescind(struct vmbus_chann=
el *channel)
> > > >>
> > > >>   	/* Wake up reader */
> > > >>   	uio_event_notify(&pdata->info);
> > > >> +
> > > >> +	/*
> > > >> +	 * With rescind callback registered, rescind path will not unreg=
ister the device
> > > >> +	 * when the primary channel is rescinded. Without it, next onoff=
er msg does not come.
> > > >> +	 */
> > > >> +	if (!channel->primary_channel)
> > > >> +		vmbus_device_unregister(channel->device_obj);
> > > >
> > > > When the rescind callback is *not* set, vmbus_onoffer_rescind() mak=
es the
> > > > call to vmbus_device_unregister(). But it does so bracketed with ge=
t_device()/
> > > > put_device(). Your code here does not do the bracketing. Is there a=
 reason for
> > > > the difference? Frankly, I'm not sure why vmbus_onoffer_rescind() d=
oes the
> > > > bracketing, and I can't definitively say if it is really needed. So=
 I guess I'm
> > > > just asking if you know. :-)
> > > >
> > > > Michael
> > >
> > > IMHO, we have already NULL checked channel->device_obj and other coup=
le
> > > of things to make sure we are safe to clean this up. At other places =
as
> > > well, I don't see the use of put and get device. So I think its not
> > > required. I am open to suggestions.
> > >
> > > Regards,
> > > Naman
> >
> > OK. I'm good with what you've said, and don't have any further suggesti=
ons.
> > Go with what your patch already has. :-)
> >
> > Michael
>=20
>=20
> Michael,
>=20
> If we look at vmbus_onoffer_rescind function, hv_uio_rescind can only be =
called
> if channel->device_obj is not NULL. By this if we conclude that hv_uio_re=
scind can
> never be called for secondary channel I think we can simplify hv_uio_resc=
ind
> only for primary channel.
>=20
> In the first patch of this series, instead of this:
> +	struct hv_device *hv_dev =3D channel->primary_channel ?
> +				   channel->primary_channel->device_obj : channel->device_obj;
>=20
> We can only have
>=20
> +	struct hv_device *hv_dev =3D channel->device_obj;
>=20

Agreed. That was the intent of my previous comments on the first patch.

>=20
> In second patch, instead of this:
> +        if (!channel->primary_channel)
> +                vmbus_device_unregister(channel->device_obj);
>=20
> We can only have:
> +                vmbus_device_unregister(channel->device_obj);
>=20

Agreed.

>=20
> Possibly WARN for secondary channel is also not required as that will nev=
er happen ?
>=20

Agreed -- the WARN is optional. I'm OK with leaving it out. But please
leave a comment in both places that the function is only called for
the primary channel, so it's not necessary to do any checking of the
primary_channel field. Future readers of the code will thank you. :-)

Michael


>=20
> - Saurabh

