Return-Path: <linux-hyperv+bounces-3309-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339E9C42FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2024 17:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3665BB2BE4F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Nov 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A914AD3F;
	Mon, 11 Nov 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HrRYv6rZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010010.outbound.protection.outlook.com [52.103.13.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460C19CC04;
	Mon, 11 Nov 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343614; cv=fail; b=mscSifue/WOlUbuH934Xwc4Tc9JrFzlN292X0ZaK4TEMhnbYftlE+z90VnymwasGrGSuPRBv27jZdXkT9Fg066+UEjdVmLnmQ0ZF4rBybyt3y9yowrDdv1eThdndFURl8XAn1c4FG3svMEz3mmd8JaLjA6LZxzJgeOKzbdBDoi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343614; c=relaxed/simple;
	bh=6tuqEnhf/TdFfNcoGHHj4UZS42UwmImRbQQJBU+M5dQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fR908C/rTSB6Dmsg2ZNi/1NGlsRs5BrQthbt1ARGjwe0GWqN/yLQHy5U/ux9hWbHGw5hLJKDZgbSaaq5skGWV+BPnTBAYfSLzdOuu0whFKQsR85zd1IJEuWVoCv96vnvdULIXYSYw8Sb9slFbMDE9yz1ExQvamZ4vGhT/B/tIdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HrRYv6rZ; arc=fail smtp.client-ip=52.103.13.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKMmWmhoSDXo4ooYyACpXaMH7BusB08tmWLCV1/XlR6LSmPFri/aREKOS5m/L7B7yObeFDkJZZtnTp4Pnvpx6mMgg5EsJlqp6sg+SbBJBfD7eJmbUxZM5hjHblaSrexFMGlAzbXYkWplQ6NhY3TPw78gi22IctpoIfnzWITDxhqY171Xa4smqzZB1oJxSV/A+N8UMGaHwde1qGlCnwSRGRahXka33wYMSPN2i6EokXvj90Cv9oiCmhDueuJPxWjZunoho12uvwXn4fzz383U206HgZoAtTGqsiVhOVXGYWoQGyvRJPC6z0XU73v/wcKYFM57jz38e93GXbc6DyZZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCb7d0vUelNQLoob4JXdJ1ZIpaYcruSjRLhSgk1T6k4=;
 b=vs9rtpmIWMW5kiaC3YEsWAL3kr9oThgMd7lYEkfdEFl8L4oqlOaWfYMQjodh1UWvDFQMuwBUYS065GhVg6OBJwKCntHz39Qy8stAWPwMic+3IJmuD4+NdupwyWeaHlEshfkdUUS9wGcZah4eS767ioTxujuOLttfVUFEUaj2RRojwyfYmG5PeZGhw4YpJQdxJrjUBJ8q/wKTEkrL3mWGAuCXgbCWWjY+i7zeepFXxwhffjgQcTWOqZ8sYbDnMFXuQeoF7rlnpUBbugqoBKXV9+V1SQ1D9tMvVOTqlC0OCM+AzfTo2t4/VecaVR9AqjcBjuc+/eDcO8W4lmApmXZA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCb7d0vUelNQLoob4JXdJ1ZIpaYcruSjRLhSgk1T6k4=;
 b=HrRYv6rZ9srstgGYxDug3eUi3/3dmbYRqtTWCO0PscpvdxFzxQvExZ2dYjc2YW+qpnA+1iLtnm8aa0Sac1O3i/Dt8tgglDIreAfcLYLI8lKKmNlx1yTvKaUkqzw80kqHl23gDaohbww7Ria8kqzETIuAsoqAm+2Eh9onSVCopqS0JEDT8HJXX11upX3RczDodagvYADt6NErD7+F3/0bg6RyHVjJb3JIW77bfUbAKLiGwq50HowsA33Lbo+OUshi5IMBnAJp7JkSwrs8T7wkJf6jdPcatKdm8FP6SRV2eJ5POwI43Y+KoNFz5wunGFH45VjmCe1vVEZACAcmQqwl/Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9138.namprd02.prod.outlook.com (2603:10b6:610:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 16:46:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:46:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>
Subject: RE: [PATCH] HID: hyperv: streamline driver probe to avoid devres
 issues
Thread-Topic: [PATCH] HID: hyperv: streamline driver probe to avoid devres
 issues
Thread-Index: AQHbL6XJIfadeDv0d0yyLToHQBS7K7Ko9XYAgAGYDrCAAI2HIIAG+UCAgAA+OXA=
Date: Mon, 11 Nov 2024 16:46:49 +0000
Message-ID:
 <SN6PR02MB41578746A3BFE79E752ADC8CD4582@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241104164824.1213529-1-vkuznets@redhat.com>
 <20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <877c9htw1n.fsf@redhat.com>
 <SN6PR02MB41577BB0B8724ED058E94F92D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415716F2A1EB3B106E685701D45C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyj1x6ua.fsf@redhat.com>
In-Reply-To: <87cyj1x6ua.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9138:EE_
x-ms-office365-filtering-correlation-id: e3b664cd-c197-443e-fee7-08dd0270700f
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|19110799003|15080799006|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7CzOpdf4JYEgyTTDlaBkaPKxjwcjMHTX/sm/hXJGOTsKNgC2Zcboo/gGfmFi?=
 =?us-ascii?Q?vDGFevyT2IA3erf3j6D+V7fBYU8DuXD5wfTRaX3h6cjTgDEZZZP3LYWOxZ2A?=
 =?us-ascii?Q?eCjyRXhrFsC+qtzZkx5vdJrU1HA8nDcVcE1RlN7GXti75o3TNqlKfdHcI8WG?=
 =?us-ascii?Q?+zBK5YbIbSU5dXGg4ZnrPM8ZIIDTKvushfmA37bAwqjxR7GGd8cQkRt6/VZd?=
 =?us-ascii?Q?fvsXrMCpI6gMGkcaRjAT3zI1uSZtkt8qLctO0zcWNjFZ5CalS3XqoTRfsgu8?=
 =?us-ascii?Q?E9CiTG1VvfkvC1oGoMBZKnh3+r4giLujaxYbcxb119EPm35EinPWb7oWEClL?=
 =?us-ascii?Q?UxFigxeyPu+oxfwUqkN7oCSznEg1BzLr7+L3kCNXVJvvgeLRwxAyjX6rkTka?=
 =?us-ascii?Q?KCySpifbZUNyzUgwVERm4TRdQlTZPKjARYy8HkiwRR5RQtjONcbNSlcXlcYf?=
 =?us-ascii?Q?Ac34JmGnwo6ikIrlp+9ogxfS7ZpKG/7yz0iTeLRv0h8A/QJRAX4P/0CMcNsZ?=
 =?us-ascii?Q?8XJbwK14GWTTqJrTiwzwaQl0P6CO3EoRc6tujHL//8MQqedUGs4CiXgYmPAE?=
 =?us-ascii?Q?oeBEA2FECTFJkVDGawDJRKeYeWrrLQy/G7GZ9iHYFN0Gon5MXd625PGYiJQK?=
 =?us-ascii?Q?MkdszRIE6JsjvWnviiz0aF3YoVYjouCVSUndvTNCQeKrv1amXpsPY57LDEAK?=
 =?us-ascii?Q?dhXMX7BRGr1fHOaGF/vVksEvnhQcqHc/k4OtQSldrq3pgsXF+O9/Y0sZuZzi?=
 =?us-ascii?Q?7bLxKtozkk/a4AwOuUVrDMFAm5girfegCShtEA/UuwE22i2VjaJry5CAXmKx?=
 =?us-ascii?Q?56gmsv7JZo6DSYqJR0NfFF8QGFmIUWdC5cyqRecdsDnPMKXIYGv9JJU8p1F0?=
 =?us-ascii?Q?SG+K79SPn4zJJ5nW+SzfNp6HdXBFdoiTJQPaVZhm7xjOvvqFnSSkVGZ8tF+Q?=
 =?us-ascii?Q?wv3YbpgJdRSrhRMi7BocObDyoNMP8mVWnFHZyBy2gcGdEEN1G+5uIaQdLsNv?=
 =?us-ascii?Q?pFr+c3+FFHXlPZiWArR/xx/ozg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qG3l8FDyZxJapzHzYu+xjEQozJwKMMth/jTAKD0tQeehxlAKSmpTkQ09DCyh?=
 =?us-ascii?Q?0pVU1Y0t+Lfgj8JpqPg2R65tFbxy/nzmOv1SuSPMqnrqTgGbvYhZRe/meYDT?=
 =?us-ascii?Q?OdzXN7a4/Vw5xBBhunDejhqXSZNHYmdkIoRsNZMj0JCZjdxExeu0HoIDfUQ3?=
 =?us-ascii?Q?qmPoGUlhCdYy+6sFSNjFmP3mkGZOkvDRsvlL1WwCeQkVYb8/iAGx0X7OQcwG?=
 =?us-ascii?Q?UF6Hrfh9QWzKYTgT3ZFn4mHI2a9u1VQhvDUt0Q0H9Rt4uvdjVrtzQYyquaAA?=
 =?us-ascii?Q?MUSoyY+ViJP/gFV7DIt+ixYWRAMcTYLBKs9VaERv6JQHKFUb1+jJYO3vOgoo?=
 =?us-ascii?Q?f/8t71xqOKW0kF3a6Bn0jQLdNQk1xjjT2zXIqrIkFGnpaAeqqQlG818LMu6w?=
 =?us-ascii?Q?i42dOOoIvnj+enLe1cCflp00lGBed4giYm+vYIL5tHUwpPDkeVXbJOnv4+zl?=
 =?us-ascii?Q?fCGnXXIcq/tOHAhB374O+enzZUG9zsQPOSz6aFrcZBleOUuh+7bqFlrGu+46?=
 =?us-ascii?Q?hTlbOJyKTA2BnA1vaN+vbSWZ8F8QKhiC2nqhRyauV80SoPy1DmxSo5UPJ/rz?=
 =?us-ascii?Q?hQCUEnK73muSGCNcHzEj8CVpXNG3xtbEu2HQniT35ra1MKQ/JkLHfEqxahX+?=
 =?us-ascii?Q?N6ED+Ov74reG1Sv9aXN2A9aDz+A/+cyyrqUHdMiStb5P7UFupFfre0zCaZJQ?=
 =?us-ascii?Q?b9HWOf7BukIpP+Pta5o++p6iMT9yV3i9HIFkIM171Gss5Sxg3mfo+WwGMv9u?=
 =?us-ascii?Q?Ox9LIbpJ2H1Mb5riu/s193sPC/RLpFCNDCoaPO+HmnaGoYIpJSFuuchtOnsC?=
 =?us-ascii?Q?k21tAxtmGDsHvU19BAEtZhKXsJ9Itxn6nwZj85JLax+K38jGNgWE987jMSio?=
 =?us-ascii?Q?lXZaRYhhv8AIDK99CsqGN/MHVf+hpBZDqfgwK+IF2JnfQBju/DTdPAJncsAo?=
 =?us-ascii?Q?4yKqyW9/o8fDVvcWsnzKbpdB0iGUtGFgsEz6YtWZpvAKvO2qwqormLLHHS5y?=
 =?us-ascii?Q?rZNwTcAVvQxNXaxgouTvNWeI4co0ezBJXRDtilnMJ2BkKcVMGhdbCtmuwS2k?=
 =?us-ascii?Q?DBJun+RL/3JY2Em0wsRF8t/BMMahWSVI4qO4pZjZmsXyyaGmkIUtfF3I/7cd?=
 =?us-ascii?Q?GOR4txrz0Zk4nRGCZEYrF4kTYwB9wtKM3qmxz19t7SWqvzlqDJ67FE78hqx4?=
 =?us-ascii?Q?Q6X3QXA/IqGpo1/xadCxZJXOPk0RESmZGW8oXBnp4OHM0+Kzx9G/o0TSOEo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b664cd-c197-443e-fee7-08dd0270700f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 16:46:49.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9138

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, November 11, 202=
4 5:01 AM
>=20
> Michael Kelley <mhklinux@outlook.com> writes:
>=20
> > From: Michael Kelley Sent: Wednesday, November 6, 2024 10:36 AM
> >> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, November 5=
, 2024 9:45 AM

[snip]

> >>
> >> The alternative is to keep the "struct hid_driver mousevsc_hid_driver;=
" line
> >> and to populate it with a name, id_table, and an HID probe function sp=
ecific
> >> to the Hyper-V mouse. Then instead of the incorrect assignment to
> >> hid_dev->driver, add a
> >>
> >> 	module_hid_driver(mousevsc_hid_driver);
> >>
> >> statement, which registers the driver. The new HID probe function does
> >> the hid_parse() and hid_hw_start() which have been removed from
> >> mousevsc_probe() as your patch does. With this arrangement, the
> >> hid_hw_start() can be done with the desired HID_CONNECT_*
> >> options so that /dev/hidraw0 won't appear. It's only a few lines
> >> of code.
> >>
> >> I can try to code up this approach if it is preferred. But I'm likely =
tied
> >> up with some personal things for the next few days, so might not get
> >> to it for a little while. Feel free to try it yourself if you want.
> >
> > Here's what I had in mind. It appears to work and preserves the
> > custom aspects of the current code in mousevsc_probe(). Turns
> > out I can't use module_hid_driver() because it conflicts with the
> > existing module_init() and module_exit() use, so I've directly
> > coded hid_register/unregister_driver().
> >
> > diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> > index f33485d83d24..98a7fa09c4ee 100644
> > --- a/drivers/hid/hid-hyperv.c
> > +++ b/drivers/hid/hid-hyperv.c
> > @@ -422,6 +422,25 @@ static int mousevsc_hid_raw_request(struct hid_dev=
ice *hid,
> >  	return 0;
> >  }
> >
> > +static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct=
 hid_device_id *id)
> > +{
> > +	int ret;
> > +
> > +	ret =3D hid_parse(hid_dev);
> > +	if (ret) {
> > +		hid_err(hid_dev, "parse failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDD=
EV);
> > +	if (ret) {
> > +		hid_err(hid_dev, "hw start failed\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct hid_ll_driver mousevsc_ll_driver =3D {
> >  	.parse =3D mousevsc_hid_parse,
> >  	.open =3D mousevsc_hid_open,
> > @@ -431,7 +450,16 @@ static const struct hid_ll_driver mousevsc_ll_driv=
er =3D {
> >  	.raw_request =3D mousevsc_hid_raw_request,
> >  };
> >
> > -static struct hid_driver mousevsc_hid_driver;
> > +static const struct hid_device_id mousevsc_devices[] =3D {
> > +	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
> > +	{ }
> > +};
> > +
> > +static struct hid_driver mousevsc_hid_driver =3D {
> > +	.name =3D "hid-hyperv",
> > +	.id_table =3D mousevsc_devices,
> > +	.probe =3D mousevsc_hid_probe,
> > +};
> >
> >  static int mousevsc_probe(struct hv_device *device,
> >  			const struct hv_vmbus_device_id *dev_id)
> > @@ -473,7 +501,6 @@ static int mousevsc_probe(struct hv_device *device,
> >  	}
> >
> >  	hid_dev->ll_driver =3D &mousevsc_ll_driver;
> > -	hid_dev->driver =3D &mousevsc_hid_driver;
> >  	hid_dev->bus =3D BUS_VIRTUAL;
> >  	hid_dev->vendor =3D input_dev->hid_dev_info.vendor;
> >  	hid_dev->product =3D input_dev->hid_dev_info.product;
> > @@ -488,20 +515,6 @@ static int mousevsc_probe(struct hv_device *device=
,
> >  	if (ret)
> >  		goto probe_err2;
> >
> > -
> > -	ret =3D hid_parse(hid_dev);
> > -	if (ret) {
> > -		hid_err(hid_dev, "parse failed\n");
> > -		goto probe_err2;
> > -	}
> > -
> > -	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDD=
EV);
> > -
> > -	if (ret) {
> > -		hid_err(hid_dev, "hw start failed\n");
> > -		goto probe_err2;
> > -	}
> > -
> >  	device_init_wakeup(&device->device, true);
> >
> >  	input_dev->connected =3D true;
> > @@ -579,11 +592,21 @@ static struct  hv_driver mousevsc_drv =3D {
> >
> >  static int __init mousevsc_init(void)
> >  {
> > -	return vmbus_driver_register(&mousevsc_drv);
> > +	int ret;
> > +
> > +	ret =3D vmbus_driver_register(&mousevsc_drv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D hid_register_driver(&mousevsc_hid_driver);
> > +	if (ret)
> > +		vmbus_driver_unregister(&mousevsc_drv);
> > +	return ret;
> >  }
> >
> >  static void __exit mousevsc_exit(void)
> >  {
> > +	hid_unregister_driver(&mousevsc_hid_driver);
> >  	vmbus_driver_unregister(&mousevsc_drv);
>=20
> This works for me with one minor issue. If we do hid_unregister_driver()
> first, the device gets pickup up by hid-generic during unload:
>=20
> [  174.988727] input: Microsoft Vmbus HID-compliant Mouse as
> /devices/0006:045E:0621.0001/input/input4
> [  174.995261] hid-generic 0006:045E:0621.0001: input,hidraw0: VIRTUAL HI=
D v0.01
> Mouse [Microsoft Vmbus HID-compliant Mouse] on
> [  174.999222] hv_vmbus: unregistering driver hid_hyperv
>=20
> so I think hid_unregister_driver() and vmbus_driver_unregister() calls
> must be swapped. It also seems logical to invert the order in
> mousevsc_init(): do hid_register_driver() first and then call
> vmbus_driver_register() to avoid the race where a mousevsc device shows
> up but the HID driver for it is not yet registered.
>=20

Yes, that makes perfect sense.

Michael

