Return-Path: <linux-hyperv+bounces-3277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08969BFCA7
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 03:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C447F1C2093C
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E6374CB;
	Thu,  7 Nov 2024 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WDKhEKXg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2103.outbound.protection.outlook.com [40.92.40.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DCEACE;
	Thu,  7 Nov 2024 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947374; cv=fail; b=H9O9qmTNW51mGLJmGxboI5ZmzfF0YZtIs/2qieTKp3/a1/UdmfR+7utHInc/vusYc6r2CpT7pxP/Hb7p1qI2vRuX1d4/V+cVv+WETgSYGWXKqhoaLZn2ipEKplZXTnTaLYZm73PZxUEhOuBQQiUpI3nYM4H2gRBeQc5mGmgfm8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947374; c=relaxed/simple;
	bh=aalmCLZcBZTogpKG7jBRrYOQwEVyXJ4cf0jkwKk5Rl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aT6+cKgbmUtaSZP/BOuTW2BDt0Orl41d7NL2O1S0A3W/GRzD1DjvCf+BBgjpbFmasHnANxt4uQEpWWiaOaccKvR2QU/xEYI5v/70YKNNvcGHAQKKARgVJOpSp/SCq000QqKpe5NNytMpBxPWR40Vk5YZvaR1pU2smW2raRf0kOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WDKhEKXg; arc=fail smtp.client-ip=40.92.40.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkVnXb7n8+z7nWdPIfMBHzxThQnbWNy9Lsg53EswrmGs0g30Mjuhntk11lGsoXYqmVe36SJZy5YsMUEna02g+JAeu8ZlSaoHBwt3or3+spwJvEYQDKHRnGf8YPX3M3gx7x8JpUhW9zKX0Xe5xPUBo7TtfMqwkkm2Fjzku8NfLYC09pD+Fsu7rOPvgCcBDnj36dFU6IKuGIdZMEDLBxcW+OAVweuoCeGsjihHPqDfQ+gkSCWIV4dXmgFLojZFiukDFpUMpwEVX6xnJMasKsQ7OM63QUD//56OrhnXWUMxPHbzInpmiFAv9rq99IM/2Gx2S7VDcxoXlIP6I44gr6eQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSjCGPjEHUM/1tuOm7DgGhYppD0v7RN2OOuG/dBkSIc=;
 b=yPaEJjYU51oQXOU7NIR/qD3aIEH5H7qk3gyZlqNmNi+KGTlK0pf6gKHApTx1BBHOKcrPlAzqSFr476pVwqhdSVs6NzMHUInDEox+WysTczXbamLbVH0iwE4ylnifzBUIOO63lNE9H4u+y5vEaqFDkpuIB9MH9KPyjwa/+jZOvO3Li9qee4w4XsFw2gIe0iSI9MxMwjaO6S2hcqQqdf0aI8+UN0/xHxMkdeJYx40yK6UtpBUWIa/kICMlEG8RnYzbfbsEKzvHmCu6pniL+KDOIfeB64q6yeX5jtYMp4fotrj37qvCqUVjMThMn3DIL3slCigcIHQ7wF45zJIIlL6izQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSjCGPjEHUM/1tuOm7DgGhYppD0v7RN2OOuG/dBkSIc=;
 b=WDKhEKXg/TaCic/N9zC94DLCCXd1qSuWfsuSkKhosSW9e7s868noFmyORkbh9NXcJ2Z1rPwnoaUph9gkhrOTSl5EgJc951j53mh3SiaVxYwoE7MbpYKhBtlfSFdXqwABlVb1zGl905nQZWjCmnPCGdVaC6SYUIroBeDlS7pTaMuYiGnRV8bYIAM8TTm2mvyHgslM1OwB/X7/KOiSglC3PEoH3hWI8n/6cMTPVU5/Menf84TBO+ehZfhAaxH5kqdJtUIgf5QEjzFo1v/sPrvCSLjZwTUpa1VFpDg48VhM9bT6SBnsa0jQI3qoYn/Fx687eKlvJjNrnWUanuTC+MV1dg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7152.namprd02.prod.outlook.com (2603:10b6:a03:293::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 02:42:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8114.015; Thu, 7 Nov 2024
 02:42:49 +0000
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
Thread-Index: AQHbL6XJIfadeDv0d0yyLToHQBS7K7Ko9XYAgAGYDrCAAI2HIA==
Date: Thu, 7 Nov 2024 02:42:49 +0000
Message-ID:
 <SN6PR02MB415716F2A1EB3B106E685701D45C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241104164824.1213529-1-vkuznets@redhat.com>
 <20241105171141.GA13863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <877c9htw1n.fsf@redhat.com>
 <SN6PR02MB41577BB0B8724ED058E94F92D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41577BB0B8724ED058E94F92D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7152:EE_
x-ms-office365-filtering-correlation-id: 4ce6a747-6a44-4d6a-4456-08dcfed5de68
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|8060799006|19110799003|15080799006|4302099013|440099028|102099032|3412199025|10035399004|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xrMxh2NAUGqk48MjLWeRGDW4iBs1n/vLXlFTDPRFqEZ+9WMZrUDTSATX8Z5K?=
 =?us-ascii?Q?5l7nTJFiv8/UYrbXgV1hvX41YMwdpio5gznJgdOh2LBNL+y8koy3Ry3TjiPs?=
 =?us-ascii?Q?9Oqq9OQOvK6LX4UPr4t3fbJ7lcy2JmbMoEriE3MV8QIyPDs+NxxxkiNbKsEt?=
 =?us-ascii?Q?DZE5/U3qEyt1FesXkiQDRVVPwraVJz3Au/q6q16OF2LsBjwxVvlj/by0/KCR?=
 =?us-ascii?Q?PyvGTJug1ricvv0xExEdL8NMOW0YC6yYL/SPDL2PSuiz/jBuzqmPQNPhaGwP?=
 =?us-ascii?Q?9xpFaWsoZkTFP8GFEedtaEHaCEN6IvytL3tC2Xl5IMAxpqDFWgVImPtpPNWn?=
 =?us-ascii?Q?aaNfTIFFOZkVZ5VZOMVj4QptsCk9K1hmwOZccoy9JUchU8mqHEUVtQ34QQFU?=
 =?us-ascii?Q?n3vYYseRP3/9RUnBz9DCbmTmCjRSOYSW2700QaAbsNqzHRoiasPgvzG9fPdM?=
 =?us-ascii?Q?tEt1E/ppZRevFNggct+YSPyayCeswWISn2C1Pwf76o8070VnQ6+DvwE+P4UH?=
 =?us-ascii?Q?cZo21i/8T+vQgPEaR1SwqofzkQ05llJ8sGDUqBWRUpV2u9ECb6dRPFakW4hg?=
 =?us-ascii?Q?fFPYGoZdQ1soqVUxSx0zxl8JyA8irQdmxrlniw/e9GhTHhL/tMGFLvFTGRBd?=
 =?us-ascii?Q?D+C+PA5RxbHCd5UUkYv4ds3nNhBqNy1FN+5co0tLppgs7c+aS5RX9j9ZxdkM?=
 =?us-ascii?Q?fjPyNKzp4O6/dL9F1lLvbbP0x9B1+dx5K3yqhJpxWb+9Bj0CzHk1IG93/bKi?=
 =?us-ascii?Q?UbdM1vv0Grgwi3WUWU/bUcGaxfi3j9uh7NjCrtzb2aNxpzSa706S4s/7PosG?=
 =?us-ascii?Q?bC/24qmn4d0ugmq7F41RNgUhMlunj2wGU7QFZhKnexirshqeBGZAVFZ9ySWC?=
 =?us-ascii?Q?vAQnTUm56YaTACjbgSvCFgDlLbcC2nBO6RuWDB3kOPH5VqI/b9HZHDmvzab1?=
 =?us-ascii?Q?giDUKpQQPRZObe/1PXmI0qmidqDf44GSo8tCo0U7dIjlHohhadQjTlOUd8fx?=
 =?us-ascii?Q?S1ckAf+TMD/HaGo2uzYS09pLQwA434MsIs6+s2lxtRCEqq64ksnbKA03EwC6?=
 =?us-ascii?Q?hMoWEk25oryPGxzAnj3uERncKbuzMxTCmZHp1xGWnLMz/QBLEqFPmsD3Zd5n?=
 =?us-ascii?Q?uNN3WqB7QD8zx9fqIY+3RAdkl6iO+0s6cK8aoE5w7P67bEJfEzwMCAI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mLKNON519QfuIwNGiGm+071qkAwZGJLujEmbSitzdMT1kQgs3ZSp2C7vUx0C?=
 =?us-ascii?Q?3gLAyMakj6Iw4lF9kBfOVIRajlqgZ0iDkgSztiOVOND5v5+QSz3D7evXypAb?=
 =?us-ascii?Q?yaVexqFWb6JNSTQVBQP9v5WSql459c2rQqx6uPn7dul0l5sES0QLxxAMbd3v?=
 =?us-ascii?Q?cVm6H47Lj7CmtrLmT9J3gkPLPx6Yu4wVdklWmPquN+fHQgLw5TJYfM2TrFm9?=
 =?us-ascii?Q?P5yVAtkRIc6rvidVY1quK5F/pnzK76kV7CfLdzkUGxc4nkWkvsHJA3FK0EZ1?=
 =?us-ascii?Q?zLZijUSyI3yP+sqnrbvNip209hkSvov2UC2UtCfPvex7mIuLpAv0aKEQvpNv?=
 =?us-ascii?Q?JbeyG8jKQDOd7NBK/Ju3THMzYb/1xd5jzDq0vM65yxSmPRVyi+GNNBd0DEOx?=
 =?us-ascii?Q?0hDLpadhwCwXIy6RdYzVFnTj4F5kyuEFZPQESU4ktRuyY+wmQz1JWdiTUF52?=
 =?us-ascii?Q?nIADdw0YVbJsxTSpJX0ecAgwQbh+n7XLWDsPJagL2slOUmQEe4UmY865qobM?=
 =?us-ascii?Q?AXkDuNaUUDdIK6fqzcMe4rGlLXpYWoc3MH02FSQC2lYboKHkqfraVW5RwFvU?=
 =?us-ascii?Q?3jm/1122DlDhjVykWjudIdRE15hTmPGp/i8Td9rljG6hL1EILhdmZnbXUK3/?=
 =?us-ascii?Q?zgaYKgXj7lBXKtqpe0zIiNJpBfA/ZuKdULx6QDWlIVbU537hN+Kyl1gWLYju?=
 =?us-ascii?Q?yd4O6ew6n5IVmQtvwtOGcvBwU2dIT1HjFpq/JV06ZmfUHkv6ds8m+4SB7OIE?=
 =?us-ascii?Q?B4iW3038WK1J6GfPmPX5FrlnmY4lpg6oJvkevwfA9Yg5zVWygwPTi1swkJr1?=
 =?us-ascii?Q?Nh+8ShwtVez/k/dDAhi0jvKzTx+kBVn3/dcodcFHBvM+vNNv7ta+YpZKaFjG?=
 =?us-ascii?Q?8KDGpmGhfxuaYjoLrTAWMRKUk0eVT42tXl+bhtcZdYzOsPvfOXfsqAHVNIfG?=
 =?us-ascii?Q?mS+x+MWVbHXFjDgRKtdD7s1EiFZr7rQvNstgbyEUPV63Z/ETC5p4PK8g+jYN?=
 =?us-ascii?Q?qvn4q8yLflL4PfcHQ1LQx9gEAdl+6xK+1MbgdZAtIjvoyRNch/Ex3FMPC7B3?=
 =?us-ascii?Q?AP/yqeeAjrJmWGwZGUpvClksj6SmhTNIMArrhyM9TgmIaAUdUilDf8Ck3Afo?=
 =?us-ascii?Q?aAPmnvlekp4t6+h/2S5TTsnBSWH9Q9+SJcG20geQZxutPhEdWIMAGsR1zCfc?=
 =?us-ascii?Q?TxAem1iw9+T33Kidhu84uUueiNB7nhBBox6CqmvkNZQlK/SUEZ3fMtjE3kw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce6a747-6a44-4d6a-4456-08dcfed5de68
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 02:42:49.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7152

From: Michael Kelley Sent: Wednesday, November 6, 2024 10:36 AM
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, November 5, 2=
024
> 9:45 AM
> >
> > Saurabh Singh Sengar <ssengar@linux.microsoft.com> writes:
> >
> > > On Mon, Nov 04, 2024 at 05:48:24PM +0100, Vitaly Kuznetsov wrote:
> > >> It was found that unloading 'hid_hyperv' module results in a devres
> > >> complaint:
> > >>
> > >>  ...
> > >>  hv_vmbus: unregistering driver hid_hyperv
> > >>  ------------[ cut here ]------------
> > >>  WARNING: CPU: 2 PID: 3983 at drivers/base/devres.c:691
> devres_release_group+0x1f2/0x2c0
> > >>  ...
> > >>  Call Trace:
> > >>   <TASK>
> > >>   ? devres_release_group+0x1f2/0x2c0
> > >>   ? __warn+0xd1/0x1c0
> > >>   ? devres_release_group+0x1f2/0x2c0
> > >>   ? report_bug+0x32a/0x3c0
> > >>   ? handle_bug+0x53/0xa0
> > >>   ? exc_invalid_op+0x18/0x50
> > >>   ? asm_exc_invalid_op+0x1a/0x20
> > >>   ? devres_release_group+0x1f2/0x2c0
> > >>   ? devres_release_group+0x90/0x2c0
> > >>   ? rcu_is_watching+0x15/0xb0
> > >>   ? __pfx_devres_release_group+0x10/0x10
> > >>   hid_device_remove+0xf5/0x220
> > >>   device_release_driver_internal+0x371/0x540
> > >>   ? klist_put+0xf3/0x170
> > >>   bus_remove_device+0x1f1/0x3f0
> > >>   device_del+0x33f/0x8c0
> > >>   ? __pfx_device_del+0x10/0x10
> > >>   ? cleanup_srcu_struct+0x337/0x500
> > >>   hid_destroy_device+0xc8/0x130
> > >>   mousevsc_remove+0xd2/0x1d0 [hid_hyperv]
> > >>   device_release_driver_internal+0x371/0x540
> > >>   driver_detach+0xc5/0x180
> > >>   bus_remove_driver+0x11e/0x2a0
> > >>   ? __mutex_unlock_slowpath+0x160/0x5e0
> > >>   vmbus_driver_unregister+0x62/0x2b0 [hv_vmbus]
> > >>   ...
> > >>
> > >> And the issue seems to be that the corresponding devres group is not
> > >> allocated. Normally, devres_open_group() is called from
> > >> __hid_device_probe() but Hyper-V HID driver overrides 'hid_dev->driv=
er'
> > >> with 'mousevsc_hid_driver' stub and basically re-implements
> > >> __hid_device_probe() by calling hid_parse() and hid_hw_start() but n=
ot
> > >> devres_open_group(). hid_device_probe() does not call __hid_device_p=
robe()
> > >> for it. Later, when the driver is removed, hid_device_remove() calls
> > >> devres_release_group() as it doesn't check whether hdev->driver was
> > >> initially overridden or not.
> > >>
> > >> The issue seems to be related to the commit 62c68e7cee33 ("HID: ensu=
re
> > >> timely release of driver-allocated resources") but the commit itself=
 seems
> > >> to be correct.
> > >>
> > >> Fix the issue by dropping the 'hid_dev->driver' override and the
> > >> now unneeded hid_parse()/hid_hw_start() calls. One notable differenc=
e of
> > >> the change is hid_hw_start() is now called with HID_CONNECT_DEFAULT =
which
> > >> implies HID_CONNECT_HIDRAW. This doesn't seem to cause any immediate=
 issues
> > >> but 'HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV' combo was used in th=
e
> > >> driver for a long time and it is unclear whether hidraw was excluded=
 on
> > >> purpose or not.
> > >>
> > >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > >
> > > A fixme tag would be helpful.
> >
> > I concluded that it's the unusual 'hid_dev->driver' override in
> > hid-hyperv to blame and not the 62c68e7cee33 ("HID: ensure timely
> > release of driver-allocated resources") but the override was there sinc=
e
> > the inception of the driver so I'm not sure, mentioning 62c68e7cee33
> > probably makes more sense...
>=20
> I've finished looking at the linux-next issue in detail, and I agree that
> the hid_dev->driver override is the underlying cause. I was
> commenting out that line Monday night, but had not gotten as far as
> removing the the hid_parse() and hid_hw_start().  Then your patch
> came out, Vitaly, which is great!
>=20
> >
> > >
> > >> ---
> > >>  drivers/hid/hid-hyperv.c | 17 -----------------
> > >>  1 file changed, 17 deletions(-)
> > >>
> > >> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> > >> index f33485d83d24..1609a56ffa7c 100644
> > >> --- a/drivers/hid/hid-hyperv.c
> > >> +++ b/drivers/hid/hid-hyperv.c
> > >> @@ -431,8 +431,6 @@ static const struct hid_ll_driver mousevsc_ll_dr=
iver =3D {
> > >>  	.raw_request =3D mousevsc_hid_raw_request,
> > >>  };
> > >>
> > >> -static struct hid_driver mousevsc_hid_driver;
> > >> -
> > >>  static int mousevsc_probe(struct hv_device *device,
> > >>  			const struct hv_vmbus_device_id *dev_id)
> > >>  {
> > >> @@ -473,7 +471,6 @@ static int mousevsc_probe(struct hv_device *devi=
ce,
> > >>  	}
> > >>
> > >>  	hid_dev->ll_driver =3D &mousevsc_ll_driver;
> > >> -	hid_dev->driver =3D &mousevsc_hid_driver;
> > >>  	hid_dev->bus =3D BUS_VIRTUAL;
> > >>  	hid_dev->vendor =3D input_dev->hid_dev_info.vendor;
> > >>  	hid_dev->product =3D input_dev->hid_dev_info.product;
> > >> @@ -488,20 +485,6 @@ static int mousevsc_probe(struct hv_device *dev=
ice,
> > >>  	if (ret)
> > >>  		goto probe_err2;
> > >>
> > >> -
> > >> -	ret =3D hid_parse(hid_dev);
> > >> -	if (ret) {
> > >> -		hid_err(hid_dev, "parse failed\n");
> > >> -		goto probe_err2;
> > >> -	}
> > >> -
> > >> -	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT |
> HID_CONNECT_HIDDEV);
>=20
> As you noted, using HID_CONNECT_DEFAULT in the default probe function
> __hid_device_probe() ends up adding HID_CONNECT_HIDRAW and HID_CONNECT_FF=
.
> The latter is benign as it only affects devices that support force-feedba=
ck. As best I
> can tell, HID_CNNECT_HIDRAW causes /dev/hidraw0 to appear, which provides=
 a raw
> interface to the mouse device. See https://docs.kernel.org/hid/hidraw.htm=
l. It doesn't
> seem like making this interface visible hurts anything, but I'm not 100% =
sure.
>=20
> The alternative is to keep the "struct hid_driver mousevsc_hid_driver;" l=
ine
> and to populate it with a name, id_table, and an HID probe function speci=
fic
> to the Hyper-V mouse. Then instead of the incorrect assignment to
> hid_dev->driver, add a
>=20
> 	module_hid_driver(mousevsc_hid_driver);
>=20
> statement, which registers the driver. The new HID probe function does
> the hid_parse() and hid_hw_start() which have been removed from
> mousevsc_probe() as your patch does. With this arrangement, the
> hid_hw_start() can be done with the desired HID_CONNECT_*
> options so that /dev/hidraw0 won't appear. It's only a few lines
> of code.
>=20
> I can try to code up this approach if it is preferred. But I'm likely tie=
d
> up with some personal things for the next few days, so might not get
> to it for a little while. Feel free to try it yourself if you want.

Here's what I had in mind. It appears to work and preserves the
custom aspects of the current code in mousevsc_probe(). Turns
out I can't use module_hid_driver() because it conflicts with the
existing module_init() and module_exit() use, so I've directly
coded hid_register/unregister_driver().

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index f33485d83d24..98a7fa09c4ee 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -422,6 +422,25 @@ static int mousevsc_hid_raw_request(struct hid_device =
*hid,
 	return 0;
 }
=20
+static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct hid=
_device_id *id)
+{
+	int ret;
+
+	ret =3D hid_parse(hid_dev);
+	if (ret) {
+		hid_err(hid_dev, "parse failed\n");
+		return ret;
+	}
+
+	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
+	if (ret) {
+		hid_err(hid_dev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct hid_ll_driver mousevsc_ll_driver =3D {
 	.parse =3D mousevsc_hid_parse,
 	.open =3D mousevsc_hid_open,
@@ -431,7 +450,16 @@ static const struct hid_ll_driver mousevsc_ll_driver =
=3D {
 	.raw_request =3D mousevsc_hid_raw_request,
 };
=20
-static struct hid_driver mousevsc_hid_driver;
+static const struct hid_device_id mousevsc_devices[] =3D {
+	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
+	{ }
+};
+
+static struct hid_driver mousevsc_hid_driver =3D {
+	.name =3D "hid-hyperv",
+	.id_table =3D mousevsc_devices,
+	.probe =3D mousevsc_hid_probe,
+};
=20
 static int mousevsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
@@ -473,7 +501,6 @@ static int mousevsc_probe(struct hv_device *device,
 	}
=20
 	hid_dev->ll_driver =3D &mousevsc_ll_driver;
-	hid_dev->driver =3D &mousevsc_hid_driver;
 	hid_dev->bus =3D BUS_VIRTUAL;
 	hid_dev->vendor =3D input_dev->hid_dev_info.vendor;
 	hid_dev->product =3D input_dev->hid_dev_info.product;
@@ -488,20 +515,6 @@ static int mousevsc_probe(struct hv_device *device,
 	if (ret)
 		goto probe_err2;
=20
-
-	ret =3D hid_parse(hid_dev);
-	if (ret) {
-		hid_err(hid_dev, "parse failed\n");
-		goto probe_err2;
-	}
-
-	ret =3D hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
-
-	if (ret) {
-		hid_err(hid_dev, "hw start failed\n");
-		goto probe_err2;
-	}
-
 	device_init_wakeup(&device->device, true);
=20
 	input_dev->connected =3D true;
@@ -579,11 +592,21 @@ static struct  hv_driver mousevsc_drv =3D {
=20
 static int __init mousevsc_init(void)
 {
-	return vmbus_driver_register(&mousevsc_drv);
+	int ret;
+
+	ret =3D vmbus_driver_register(&mousevsc_drv);
+	if (ret)
+		return ret;
+
+	ret =3D hid_register_driver(&mousevsc_hid_driver);
+	if (ret)
+		vmbus_driver_unregister(&mousevsc_drv);
+	return ret;
 }
=20
 static void __exit mousevsc_exit(void)
 {
+	hid_unregister_driver(&mousevsc_hid_driver);
 	vmbus_driver_unregister(&mousevsc_drv);
 }

Michael





