Return-Path: <linux-hyperv+bounces-2013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD728AB744
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Apr 2024 00:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3351C20506
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8D13C3F2;
	Fri, 19 Apr 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PGelmCmi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2024.outbound.protection.outlook.com [40.92.44.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB52BAE0;
	Fri, 19 Apr 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565945; cv=fail; b=SNnzf6trYsJCQNvoNwWAWbcfXvDGND/A09bEcxMxOlgg+cPcjOOMwS8//wDaIZfY9qntT42xfkNPzOnphw5FkB1whXSnzS+IB67drvjhMsyTUR4qyApluqboClemsTWgYJppRGooRObAt8TAwLojO1V9TS+w3QnNdIpcCqdkxTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565945; c=relaxed/simple;
	bh=1/ZM3vHoDgkVeQEGDOj7eb5NuHvfITch/c+V1rA6TUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pn2N3NGcW+QVQNvkDyL4D5rPUt2vUi6IB50+zJvkq7JnlQbAZ+HzCgAwz6KFDrnA4XJrMivUipS6qL/IkHAkt4hwPZ613P7svmuNnynPLb+gtyzHugPk2YBb2ZWFO6qNy62qbDjYWHn2JWeKd0+vXH9dws06Ac3OulFtdVm1tR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PGelmCmi; arc=fail smtp.client-ip=40.92.44.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO8RdAnWw7WEOCdffcYKGjLRJb5FBjPRJ90ISuyuDG0SaEaVf0ebOnME5DLw8NH68C4ru3UG4MaxNv9wufA56PKNbN6+FcaC+mTF++wkMwcy6M1T/QIbimFKv79WCFDhQBD4cPyGKhTEttG6qXrYa5PaQKvmlZSyPd/gTDeCJ2IvJh/s0gkD6UW6TmGq7vdJL9d71sWCu8R+dwbcKWJmXBVfa6PuxHH+v3GkXmMEcyqQVpv2th7J/9O2TyV1HIf2hE9uomnPEo7AgHuAAGaIr1RyeKFAOSC7lL/JZGXFlaYOOThb15DF+29rktCtRs9GqegPAtnPQuqxPa//J1IYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5Vaq1bN+bUhPH0leylPA5KCdrPWU8YGOY2jLqb0orw=;
 b=I/clhi4Rw6n666PhLo/vE0ZGgCSpOjEYCwd+gVdNdK1isLz8qYqFkF7B0UlwkEaHvFPirlt0ayxv/Vrk7ycasgosfWY7fE0kMckZOYYUs9+FXqavTCWs2kxqxgSpB75RRC61kyKcNV7OwKt6t6dA4sF3bC2V6VqmYDAOZPLR/H6MmA9y6pRhq6/O5UOVciFBAb/43rpm9zdsHE1U5Hw5Bdf4EFBINRCsvVrpAUqbDnTKW5SuDAgAchgHf7Iu12DX7yHCxzNr8a+iyufZ+5AxfpKkAvwQ4N+DKvUgJL23EnSfJU7gehvTV9Ev+bEXMejiQFz/2A3IAoJYJOzuQ/Zsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5Vaq1bN+bUhPH0leylPA5KCdrPWU8YGOY2jLqb0orw=;
 b=PGelmCmi8c2mjSAOLFQN0U/iIjCJ6r7bqousknOSeJhaolTmsjfIM6oCV/dmQFOjN7EOPW5BA9vEU7q48PTqSkLLG8Ea0E1a6IF7BplBrHP0R9vjrrIckPiuCMW857WzZTbtEDelylD6gWbkys3yBtfwFLN/OL9DA1V9MXpYiUOVnIb+Ld3LuTnqtzCTLVxel1MKhNBN1isoP3nUoj044HERwjWE7YmQRJuRTJAmm2it/QA0TsTip64MDKeQ1M0lqWpCfGhGdZXMCOMbA7bHanVgPH+swEFB4+L8ZNeJQu+vl7wyGXaET4XvsMWl8eKApFeC3gRpA9U3CKuQnBBEQg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9432.namprd02.prod.outlook.com (2603:10b6:8:dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Fri, 19 Apr
 2024 22:32:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 22:32:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Schierl <schierlm@gmx.de>, Jean DELVARE <jdelvare@suse.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Topic: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Index:
 AQHajaNnaKjzbQWkCEqfKgwSAQ9VW7FopBnAgAExRwCAACYysIABcguAgAAcUjCAALI+AIAAvzYAgAAT/rCAAsG3QIAASRsAgAAaOFA=
Date: Fri, 19 Apr 2024 22:32:21 +0000
Message-ID:
 <SN6PR02MB4157337ED192FFBA81A9CDD0D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
 <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
 <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
 <SN6PR02MB4157C677FDAD6507B443A8C7D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415733CB1854317C980C3F18D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <938f6eda-f62c-457f-bc42-b2d12fc6e2c7@gmx.de>
In-Reply-To: <938f6eda-f62c-457f-bc42-b2d12fc6e2c7@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [4IhVyVjwlUdazfp97S/mDxIe8vdJC6bC]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9432:EE_
x-ms-office365-filtering-correlation-id: cbcbf43d-259e-4822-429b-08dc60c093e5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0sYmMcg1VpC15GuMn7PEn45GvRSnm36p3dxV7wkOEQ4YmH4Q+aSsEWd96CukjO9d15Ip89yu9ck5HBn8REKp9rPE9IOUmzv64qXUQYLOMGTbo1IkYg6twxC8o5H8Cnig092fqNDzLeXclpYeoxrgCEgcJ2o18wsLrm8jEq5xNkjUEhqgsopme7ZXaySdWCb3/yA30tfUGmAs6tZz6p7B0bLsVhyNALYlr/LPCD6QSQb4VzjAbFoUPueKKyDU/Xeb9J8kf7lkbpZ/XUwrurCX+klITeNcLve7YHP0fTqocGOqxkdn16Tk/+D/RDVH7pJnK1mGrZZS90FMAShyBNVty+IGYp4Msw+5gxgvviY5hMGBKeLcKyNwlPafM/nvUdkirqprh0k+b0+LKK65Z9DaQhm8W1knkt3mTA3bL1K779QDpxENpb4PA/+fpuJuEaE951KZ6EmdjgD+pCvFBvo7H3RaMYQTwuw2e0dsMUakD4bebO402qhlB6uqH4OJNK8tbEIB9JO/ukwhnx5nJnLTCR1v1jikGV/+RF2BwgkddSymyOjkg7d7ATSWA+mvaB0G/ki0Doiz6xqEN6VVG143pOQCC2NcyYVA8GI/rUxXSl4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OmvzfokT1Mc0ojejbK8SvjVoxvAfLRe88PuMYABJPyL20pFD9P+99R9xWl3e?=
 =?us-ascii?Q?09Aue7UDOAKIkc22wHgrOvqT+jR5UoEbXIPPYKRYpPLzAKpa5dZ1euhFNRBy?=
 =?us-ascii?Q?s+NploJ+/eQ7wv76cK7ZDh26D/7ytoo4ZUcLIvapekNnrzGHDMcG5lvt9Qhp?=
 =?us-ascii?Q?3QVB8XpDGPo+PdApJQgQsFnuZmZ7PTyA4JG7vtoaxk24hqWXsv0KxridTNNU?=
 =?us-ascii?Q?wTbWXoHkvf1Z7WxiyKe1FtODVGkfN/HpTVaXw5xW1daq4c3QVv47hgPgFP9q?=
 =?us-ascii?Q?oxHoSg/IztYy9r6GRks7oMo5mOmlRLQQ1FXk4OJoRkjAwr0XGw/f2gPNk6DC?=
 =?us-ascii?Q?Tm1EUkMmi16Vaos/Bey4lBjjF8lki2dYpdY1pqqStHQuv5u3TXcZja1zlVgN?=
 =?us-ascii?Q?Yb5wJS9iwnou/O3E6Fk7JlfptQRJ6tToqvBrLTtggUsMxBJNu/h5Wqpwuinj?=
 =?us-ascii?Q?5o5JCAmgOSZpUkaOIKEpfghzhIDD44rKHtVybmUPuUy3DRe5yHglB+Mv/jrY?=
 =?us-ascii?Q?3cen9uldMdp+/3SJgW81nxaCc/JimYSHl1lvnCjFvWCZpF3DN0IMbwluNzsq?=
 =?us-ascii?Q?InjOc6xMpK6BM52eKKwlPoE+WENzQdffrc7al39sYmJLg01WhLaOAz3noEHA?=
 =?us-ascii?Q?h6kWcijMENBuyaWg6uNMnejj393InmZU1BdXQ8MASeUhcqIBQe5kk4Xq2MOW?=
 =?us-ascii?Q?qZF1gDYFbSFWU3WQGM6DOlpoVvD4/CxU7OB8TzQvzaBcgxqPOHXW53mw1CoW?=
 =?us-ascii?Q?36jH7BfBPR/5aPxyP0rJ2iav+yXjc4dck3YRF5huWWwwnY1iuQYyNXZjZbLD?=
 =?us-ascii?Q?r9xt0/eEVRbJpJl7E3d1ZlDUJV6tpJhvwR/7MkAQwN0DCBP5iAaeYcjH75NE?=
 =?us-ascii?Q?5AYMjJrmp/kUtKSSZ4NUIWydsTaH8KgEC0f2vadVLFf4GWvQzvfJ8wwMnRmL?=
 =?us-ascii?Q?F2bzWClo640t1Ch8sUP/Fu+ix6MNWRsk9rFHvV/DIU3yDoLyp+qeD4VxJ92s?=
 =?us-ascii?Q?W/a3O8jgULVBnLVD30/T4fXKr+1ACiOHFUAF/AQeE0sdRD4mr89NwmfTIWWa?=
 =?us-ascii?Q?lv92bCtnZujj+e8zWRg3CIleFpzTySS63eih1p+QWN4o6uTDuCtd6TAhDGiG?=
 =?us-ascii?Q?IoX+C+SkhLe1E4XjTOpxxarDll/qFQoS8u2r6TM2m7ZP4y9AbUQI3hOHHo8u?=
 =?us-ascii?Q?NlLIlqdcr7fh+enMeNbmcE1iJ2FKlOVYCvYL3Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcbf43d-259e-4822-429b-08dc60c093e5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 22:32:21.0675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9432

From: Michael Schierl <schierlm@gmx.de> Sent: Friday, April 19, 2024 1:47 P=
M
> Am 19.04.2024 um 18:36 schrieb Michael Kelley:
>=20
> >> I still want to understand why 32-bit Linux is taking an oops during
> >> boot while 64-bit Linux does not.
> >
> > The difference is in this statement in dmi_save_devices():
> >
> > 	count =3D (dm->length - sizeof(struct dmi_header)) / 2;
> >
> > On a 64-bit system, count is 0xFFFFFFFE.  That's seen as a
> > negative value, and the "for" loop does not do any iterations. So
> > nothing bad happens.
> >
> > But on a 32-bit system, count is 0x7FFFFFFE. That's a big
> > positive number, and the "for" loop iterates to non-existent
> > memory as Michael Schierl originally described.
> >
> > I don't know the "C" rules for mixed signed and unsigned
> > expressions, and how they differ on 32-bit and 64-bit systems.
> > But that's the cause of the different behavior.
>=20
> Probably lots of implementation defined behaviour here. But when looking
> at gcc 12.2 for x86/amd64 architecture (which is the version in Debian),
> it is at least apparent from the assembly listing:
>=20
> https://godbolt.org/z/he7MfcWfE=20
>=20
> First of all (this gets me every time): sizeof(int) is 4 on both 32-and
> 64-bit, unlike sizeof(uintptr_t), which is 8 on 64-bit.
>=20
> Both 32-bit and 64-bit versions zero-extend the value of dm->length from
> 8 bits to 32 bits (or actually native bitlength as the upper 32 bits of
> rax get set to zero whenever eax is assigned), and then the subtraction
> and shifting (division) happen as native unsigend type, taking only the
> lowest 32 bits of the result as value for count. In the 64-bit case one
> of the extra leading 1 bits from the subtraction gets shifted into the
> MSB of the result, while in the 32-bit case it remains empty.

Yep -- makes sense.  As you said, the sub-expression
(dm->length - sizeof(struct dmi_header)) is unsigned with a size that
is the size we're compiling for.  When compiling for 32-bit, the right shif=
t
puts a zero in the upper bit (bit 31) because the value is treated as
unsigned. But when compiling for 64-bit, bits [63:32] exist and they
are all ones.  The right shift puts the zero in bit 63, and bit 32 (a "1")
gets shifted into bit 31.

Michael

