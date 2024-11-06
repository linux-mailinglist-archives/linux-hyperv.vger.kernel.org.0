Return-Path: <linux-hyperv+bounces-3272-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B339D9BF57F
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9971F21F5E
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0968176AC8;
	Wed,  6 Nov 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ksoiuIut"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2070.outbound.protection.outlook.com [40.92.23.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30418FC86;
	Wed,  6 Nov 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918716; cv=fail; b=oGNEj5FuI4fHHJ79SsP/y0bylo8WxWQC8OdGRefoCQg7nIrTAU9pGG7QU9ic1SAm2Hjg+kEeBj/5EUqFVXbDKNrcth0j9sN81F419IhzHb3DmfrXkL3e4oPjCKQuXm2XmpIRsF8Eyj/A7xP5b/6La4R/vE9DvQRqHzibcELq81c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918716; c=relaxed/simple;
	bh=WzzOw+n0z/ukZulbkqQaAWScsx3ckzSPxvKuSAk32wQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+n2CXfr3UXjL2RgVQwj1CixQShIFvy6X+29NcQ5EQpOkweQhrog3BdnhvSQH+zcgzonyLVgRwQQBPOLvYGMMZzfkNqabgOtaZkevJ4wSHiM0v6BOrxmrpWloTqmcg3nV0CIxvn6IcUa6ugIeqG41lq8Awpf9V0SdefPAUW+yBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ksoiuIut; arc=fail smtp.client-ip=40.92.23.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBDtnDAcQio5FS+Meao00y5TnbcHEPkLaqKcGxaypr+YLOFJOvdPta7LuvAt6xdVbAuwdl2bZTcq8U5uNkrOFYV91Yonq8sbkD6ncaOCovawZnysR4QA8yDuO0UAMjkmghgKYxQmnLqA19sfREDYwtRNoouY0sz1GeMYA84Jhb94M4k0e6bkCq4b7J25toliXMs/8l/eVkj9NbqAX17TBmM9yuVLU+AJ7tPfkghJ/EdyVvJnG4XIvP/L2tn/0vM95ep/46U88MdxCLc+T8cEKujzYzMfz/zuWCq77vrh7GOKrPlsFmiOgkBG0jo6x4GOdyKq5vSi9nrCi4isBQ0guA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHT/d7WOswR9GavSCKJiB0RH/pKnDwWTfQNY2TRCiBE=;
 b=VE2bZzfcF15XzeMKxltPJiaSQsdjoZfxFFUYLiGryxahyoz1Emg5GufhMQHBgJ08nB3K88Tmq3ma5dsNWUa9FUvoXXpk2lcGmlDADDnRNva1XeNmT3jMaBHeDXIRVPEon+/0JRSE8tf5TFT4AGO5b/y0y59V4A3QYBw+Gak2W6LEvsc9uT1h2d/2Bde627kItyX9vVilKAdr8hg7t2wrEPB5FwD14TWhp3c4zInxebzDW+hxrVA+mHkjkd6zEWe10/tcm2YTvJH4kaxkWqZXz4cD2N+xXw3CyVtS7TO1DGRPqFNJiyiKtNa7/67nUK56G7Gnm6Z8Hi1woY0APCRuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHT/d7WOswR9GavSCKJiB0RH/pKnDwWTfQNY2TRCiBE=;
 b=ksoiuIutvxL9xKwlfaGhEPCG1EPw369sEOJevr2ya6kaOY+XJE5mASrLCpgFY/fd0VHpDJK0+bsWt+f5OKuOICISHyDnyYTS8ML4Tu3EdYjvpFWvK5oqEZCLVz4rmX1RpOSZ7BSbVyLv7jqox5zyY7m1JUx+UDMaBTdNl5t+BA29hGggWoWTfNG2zhrl+d9ZTFs+T2mVHRwn1mLI3WyRzhjRfjkmOv5Rl715a/MN2nrpeeAzHf4P5SRr1zDQ6ppXJ4Hn3ikRUBB1qYkuw+9CgA+w/kXxY0w/60cZLEoTLDqNeCKLsi/IHi9JuakisImQLUDj7KgAxN+aPBGVodRGRA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9852.namprd02.prod.outlook.com (2603:10b6:a03:547::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 18:45:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Wed, 6 Nov 2024
 18:45:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, "bentiss@kernel.org"
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: Hyper-V HID driver failure in linux-next-20241101
Thread-Topic: Hyper-V HID driver failure in linux-next-20241101
Thread-Index: Adstr2ZrOEm4RxYkTg2DxiMQTFbBGwB9txqAADUisrA=
Date: Wed, 6 Nov 2024 18:45:12 +0000
Message-ID:
 <SN6PR02MB4157F9BEEE17770136B81B85D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB41573CDE3E478455D17837DED4502@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241105171507.GA15461@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20241105171507.GA15461@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9852:EE_
x-ms-office365-filtering-correlation-id: 5f7ba9ed-0b13-43ea-f95e-08dcfe9325d6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|461199028|8060799006|15080799006|4302099013|3412199025|440099028|10035399004|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4HP9kNZJ+bLCV3QXM3FlxalFb9tnEBM82YBbD/2f/MrjzxEy7ZdHJfR6K3ch?=
 =?us-ascii?Q?3zpyJv4u99p25RvFWPZG5IKwHViyW29raGIchM9HGVKWsjkHWlTp5UE7Mp7v?=
 =?us-ascii?Q?j0IFcFLeUE9VMrbm/5fPVFANP/2+smCrP6EsM9o3U69oTin7AKtxP2tW71v0?=
 =?us-ascii?Q?eWFQAtzJUAUnsI2H8r4QVWHEoiPkf2MYM0LI2OnIcM3bAfH4ghwkZc9Z3rFM?=
 =?us-ascii?Q?XIcqPkeYmvp+ZdBboCDQFRAl9t2uP1XP4FNsxprTVHk+REcmlutYZtOCMCbw?=
 =?us-ascii?Q?Ft5LPV8lrsCRIKzynoZo0dJDYS6M3DId0H5LME14LMf+G3MtvfdR0dZR2FYk?=
 =?us-ascii?Q?UQZMEfUj+I7MkBxVNlCulTO3Pzqx/0ELmN24/OKQ00+OlNpx8tqJ14s9w603?=
 =?us-ascii?Q?Mh0kqquBjFIfT9syPEP/oTkdDgJ4rvueZg6x21G4n6wj7vmQkJUibvo8wifX?=
 =?us-ascii?Q?20Z3jtTJAoP3pMx1nb3pIdY+oq/oaWLSw//hhpdv86CUMiC2QERYA5TkzXbt?=
 =?us-ascii?Q?b0yxQCSE2Kr36wROEyBfileJdL1RVjzz6M79ediHqXUpOsKXTuwNyllpnsMI?=
 =?us-ascii?Q?t7PR5rEwqBGwniuk42yjZq4H1Xq7AD8TWFxtZgZ9XdB3g+EPsmz9klj8RDtu?=
 =?us-ascii?Q?gxw4rQqqe9A660QGYX76XMX4KrV/ItcnGGZxDdw4gZ28Ca7r4ahQ6AC5H6Lc?=
 =?us-ascii?Q?kOGBly/yoqx7fAq62cp+RsgFjqDxoK8p60NU9JseD8Wv8cpq+N6LZMijpMR4?=
 =?us-ascii?Q?UJu30SS/LliWW3DK5sxnuY9j19WWVo7NSSr8cYWa+TBm8JXAxesT/C8RTqX/?=
 =?us-ascii?Q?nOdNBFMtyr9Ac7adAy1qEyUVpD/463b+cKl9YHpW89DSMGm6ppe9SODKw/jy?=
 =?us-ascii?Q?WH+1yrAYC6iHLTkUjQasju3KT+FLSSWVNETYLOPLN0sAGJSKVTdwY7a81mO9?=
 =?us-ascii?Q?HEAtu1C8xk7dfz2fBkfPSfbZI8LiLHZXjoHf+vETkUPF2uJn2OkdDfGclYCf?=
 =?us-ascii?Q?OQLlxz0TLNIrGV7GyF/3LIfijAwljJg7zk8mnDPd9EMG7lW4VA2fVwsGUsb7?=
 =?us-ascii?Q?t3heXEa3Q0cmdDicWHOaScTlcdAFpSpl83p25sOjGnv2iNDzOWLfhMVGd0OV?=
 =?us-ascii?Q?KnsevYAJn2QOkcEEoquIHO6a0wWfNIJYjykR5G2EE+L3nkEwqQLH088=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bTonDlLIwtv2ZHuwOQmYwTnhSTLIl5yPGEIrlJTkzvz5GLfOND9pDRt3pEVK?=
 =?us-ascii?Q?G64Fv4vX1jY5iKZEbta39DZRRu507HgEYeltMauJo5KKTVMjXIwsXLLuWjwB?=
 =?us-ascii?Q?HvBIWlJKpcpY35iFwzs7K9jaGq9eBm+pXezTxUJnKjg/V22s//Bu9LQqxGZC?=
 =?us-ascii?Q?9+M+ou8iRyCI5+XcgWvWQZ9GZM4zp7W8l/Qtiymsyrr4y/nkxq9ea+VbbonP?=
 =?us-ascii?Q?dOfVzNzHJuvkucYkHSn32MZk6qzLNx/KjIlDZyv35FLRVYcNRdW9K0QIOYf/?=
 =?us-ascii?Q?/07OhByMb16Ip2qvTLtWp7buqGFgDaBJEr2lJd7ykQk1PQmAG6p6klo4uUVh?=
 =?us-ascii?Q?9xfRCuvXjYl9PJLq8rJ+Qb5OLVpqO9zieeB8YsrmoriHH1XlBybo3qetRYo4?=
 =?us-ascii?Q?+EFmgnSFHoo1K/b71tDOOeWHyMUThJEj25buqpl5TkAlR+DZaFe+TQGxmaYK?=
 =?us-ascii?Q?YAk3HXWt+vU0kJ9cSrInbMqQkA4OzhUz8CRf0fTVzJ+bTAZIvSqW/KiswPF8?=
 =?us-ascii?Q?KEdzJcyMvTX7yF2re0oww8jpH4cJJuFrWKrEkECZJP0UVxo0dNQPTGqr3ktt?=
 =?us-ascii?Q?gjTIF8Awd2o2a4NhLFGnNRHYtQPaMR24ZF6n50F12zuxQ36cN2pWwlLgj4QY?=
 =?us-ascii?Q?msooCXM/MLWRpcrLZ5G1yMU9Wpe2+lsgjzHdRzrJbXaAoYCmM7fiviJSkhks?=
 =?us-ascii?Q?+bhSgIBDwC6i6tC2IMkUF0nc1ZwWySbYmARKj6XoK4W4B+a0BI2fTKSbBton?=
 =?us-ascii?Q?eFCE0bUNpZ/GuHwOwILk6WSDk3nZXQLcbV7goDSkZ0X0bG9EuquNXvYGDBfJ?=
 =?us-ascii?Q?+RhgbMHupXtvUZKMDD5BKLzK8GfPvvdETT+riFsLw/RaNCMASSkYUNLz69SI?=
 =?us-ascii?Q?kdiHcMEm6xohUnQLT++17oAZaQTOVUuP132Wj5VvILIrnemtehyCzBl2IwFt?=
 =?us-ascii?Q?/BmSIUV3dCVpn6LRm+N8Si49DvhvUMfDDf/UWTpP3SwQZZUJkOD979NRqTOa?=
 =?us-ascii?Q?mLggTkAw0vE9oObs7i2wrrcHoavc1FnDogEy4SbvMW/COVWWSg4R3JGSi1cM?=
 =?us-ascii?Q?pTu0ss+nrVmeZ0TSeKuWlfRo1/GAAT68ib1uV6q4+vpw1dh2OTTA6aHhjCT4?=
 =?us-ascii?Q?mzuTdtR8S3IMvsozWxqUliZeVDuscT0d+SE6ZXcLFbdADYkMRyRWVlq8f3YO?=
 =?us-ascii?Q?j9vEa/xxxTFV1jG/casM9eJaipvm2cegdPCADT83amss1dFuojYsa72KEaY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7ba9ed-0b13-43ea-f95e-08dcfe9325d6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 18:45:12.7796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9852

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, Nov=
ember 5, 2024 9:15 AM
>=20
> On Sun, Nov 03, 2024 at 05:17:19AM +0000, Michael Kelley wrote:
> > I was running the linux-next-20241101 kernel in a Hyper-V guest VM toda=
y,
> > and the Hyper-V guest HID (mouse) driver is failing to probe during boo=
t.
> > I bisected the problem to commit 8b7fd6a15f8c:
> >
> >     HID: bpf: move HID-BPF report descriptor fixup earlier
> >

[snip]

> >
> > I'll do some additional debugging to try to narrow down what's going
> > wrong. I'm experienced with Linux guests on Hyper-V, but don't have
> > any existing knowledge of the hid-hyperv.c driver or how it interacts w=
ith
> > the hid-core.c code.  Nonetheless, I should be able to peel the onion a
> > bit more.
> >
> > Benjamin -- if you have thoughts on what to look for, I would appreciat=
e
> > any pointers that could save me some time. It's certainly possible that
> > there's a latent bug in how the Hyper-V HID driver interacts with the
> > HID core, so I'll look at both sides of the interaction.
> >
> > Thanks,
> >
> > Michael Kelley
>=20
> Vitaly patch seems to fix this issue:
> https://lore.kernel.org/linux-hyperv/20241105171141.GA13863@linuxonhyperv=
3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
>=20

Indeed it does! So commit 8b7fd6a15f8c is good, and the root cause
is that probing in the Hyper-V mouse HID driver is structured incorrectly.
Somehow the driver has worked the past 12 years, until commit=20
8b7fd6a15f8c came along. But the fix should be in the Hyper-V mouse
driver. I looked to see if any other HID drivers have the same problem
as the Hyper-V mouse HID driver, and I don't think there are any. So
this is truly a one-off issue.

This thread can be considered closed. We'll provide the resolution
via the above patch from Vitaly Kuznetsov.

Michael Kelley


