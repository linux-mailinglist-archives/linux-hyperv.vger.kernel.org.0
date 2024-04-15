Return-Path: <linux-hyperv+bounces-1971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393A8A5E54
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Apr 2024 01:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279E71C21BEA
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 23:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E1156225;
	Mon, 15 Apr 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hT6uRnmc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2021.outbound.protection.outlook.com [40.92.22.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BD15749D;
	Mon, 15 Apr 2024 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223891; cv=fail; b=J6BaihYkwZAmw6oGwwUqV2QJGie0HLLIB3FKBaCmiiyCf2K9fKTNDirqYObxcdhYZ1Mujhp1rqHuGs0my7oVAiiDkTV5cAGb6zX/8hYiZXUBz147MqmWtHziTqyBMdmWF/SnGoy6Ljj594Gs2NT+jeYXQV8La6Mf66AyumF1cKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223891; c=relaxed/simple;
	bh=4NXn+9O9vyH0zCVATJkYt5iG+V9T8mPdnIgIxQ1vwqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=te/pBiND5gI8MFpiKp87hzagtt/ZhfJHG/B51AQ7JPcm5Wpz6wOlQ/ZMOt4cq4CpdpQL3xCZBYrl3O2pnmvnd3jTxFNPd5I1UQKvqh0HXkQNcnZIZ5SvUCEz/0WB2K5UqpGYAQiro2hzMg42dbOrQE7zt8aebCiKf4N0JiJT4/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hT6uRnmc; arc=fail smtp.client-ip=40.92.22.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQadpgpxzqs4b+FJyMWFGtGdhsg6GFpjalEK1NDuOme9PjrS0Turpbp2/8CAoIwhGKdiPeIwNf3CxsZBBRT7qxow30TyoofuQ9ti1LkSsl83yfPiqfNN2/ynNgqFZ0bHSLrOqCx3fv+sNvUh8kqYT/I4gG5L+mjZ/V6lq5PPX8Bf7skRzSdUkIiaA+IH3DVK2xpjlnMKlWMYpZNdl3JKFOx67mCPXcBw3g8OrWxxYugObiNNBALSc7MitLqN8mMgdCubxmoq34LW49U6/x01LAtrNwaI4BCMTwptn1dXabKF3jz5/3Ikks0S6xngYYEDUVOmzPA3rxJam5zdWiq3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYTJASnC7PNX0N9y7ass9w/XA0SAUqgO61RVyyx4vd8=;
 b=f4joY9ZHFCLfIoOxoYDqfQDToH+OXz6LGARJRGTD+QaU1/1W1AEXyFIGBqaIvWfXjwOnQSmku2fuiayKI0U4JJSeaQzhzAtrdPsVmsoEh2wBaewPuseRH07cxqB9opKyPCxEnNdRl0dlfx8uapKCifSWIjkRz8Wtfo+3okdFlA7UJ1X1aeVYPwoEvuhbizwpxoPbhIflk8DY0xWH0WyoYAVHYVchEcslAbybTLRRAV4wA8no93XyGDBPZuYCAJlArKGf40rRciNZDjx1pWZxjoY2VXIbIFJ63yZuaLFEkoxSnjgUz0WegJGlcHoOzIP4D4EIHUiJS6W+baVNycLR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYTJASnC7PNX0N9y7ass9w/XA0SAUqgO61RVyyx4vd8=;
 b=hT6uRnmcHg7lDiWtzdPLKGrBe7b8TofOq8KWtFU2yTlLA6uS8nmQ/oh+LK6pfoFU9I5BDAP22vuz1IO6w2x18rtV6nIxYWJlvNsBputvqsfOlfklh7nDghElNP3ahU19qBXjsQNDolQFqZFqDy9l9aWrY+n4Bauy38VjCPXzFHS1gfyy8tF6oTgk3gtgbpfzx5BHvBZx0lV13/QT3LCL+ozXoDNMqFhw0ml4WvBmT82aE7+lVlwq6HLwNQ02Gcs3FKG7rl3+rhqYebSnFKp7roMl2Nz1oYVlMrw1j0pi6f6OCCwhKdANbPSA8oAqPxa2oeRZPeHkypOms7gIIbI8qQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7703.namprd02.prod.outlook.com (2603:10b6:510:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:31:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.053; Mon, 15 Apr 2024
 23:31:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Schierl <schierlm@gmx.de>, Jean Delvare <jdelvare@suse.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Topic: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Index: AQHajaNnaKjzbQWkCEqfKgwSAQ9VW7FopBnAgAExRwCAACYysA==
Date: Mon, 15 Apr 2024 23:31:26 +0000
Message-ID:
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
In-Reply-To: <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn:
 [nKo1kY0gp+WFi/apYItOa/AUbtjcV4FbZU7sNaAUSDD0JNGuPbow5b5fycPEEN4eT/BI8uQn8Jg=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7703:EE_
x-ms-office365-filtering-correlation-id: 37d90745-0f7f-433d-6085-08dc5da42bae
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LrpW2g5RDFQ/irTQbufcIWcJs11Gn+v3f+yCzjIUk6NiQnMrY21rJY9+uxrVAKQ/p56Bnk0wC8m1GsryEg5i+/otDOm7nRBtr9YBo2qs90Qxyyx3dHHfxaTvWxXu+2mU6C1m4YWwUpgNmqm4gYogCUrY1Z8UPjl2VFfyA/v24KwJv8EdO4HXmexRv/OGkmDT0Vb0C6iXKonT6gkliz60xjcx5iyI8CZ0CyNjmZvEyUsGKvD1LMhe7jukPjab7L+znmbwhA5OMQkAudG4m39Bk3wW9a145P/rSJdYRIIIehC8xR8dOrWIKu+40VwVdbNmd32XZPcGFMzo0p7BIc0kZahaNXLn+lrAkuV1vej00mMNW/rSgtSw/KqVlNdZHBrsfOXtonYRb4qpmXrEqd+IP3FsbHKNn3YEX2tRM8APZOioGKHgazs2u+pIPENjDpVe+txtaAYR8ocZncBQSdTUYJAvz/MrYVGWrSO7vi2HU2vmQW38EiPbMd6LLPp2fU31rlTRpnpEEWR8BgPOvipkuwfndSUkoByUWNvYb49RdNXlHYXwx86NIakYS69RiPIixuHk7yVzAk7qy7TpHdLCv9/dcQKnvQdp/3igfz0Y3wKQuqI0PGu7d3xc5w9FvvOMMerG8bkBfYUWybmhfwzNuaiSY0YOY5B4flLF4n+9dQE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u8qr2Qij6n7MdY5bMMai59gkDni7/V9ntpgxsS71PZ5MdS7jkKT5k7uR0DgO?=
 =?us-ascii?Q?fVbLOdjkKtDM0Z3HHvx+EP7v5YP6cXQtk6XqhMu3vY+g/SVD+VybVWHFIWq5?=
 =?us-ascii?Q?GMjgrfKwsPfgrc94zpE8c+5st1bJTr14TK8Nk+EVFuuibpDFf2hVriuggL/L?=
 =?us-ascii?Q?35/VtF1LzoACj3H8A9R8uTt55djIXpY8WM6mzOhw5PXotmztFNu9OZ1rqk8B?=
 =?us-ascii?Q?eE13KN7JqMcVy4dZcgsC60RW13oqZ0mDaumvoSEh4kC74DKehmhvh2UUlzBs?=
 =?us-ascii?Q?kFvFZhPviJGiy+a8L4FJ2qjvFTUkj7mnVS6VKHVnW4ZV1o+EliS/nCEbzbfk?=
 =?us-ascii?Q?mkxANl8hWXoHRq2yALWICUJ3gBgrWyJV6Dpaa/9EemuXLwigyuJARfohGhQa?=
 =?us-ascii?Q?HiYA5ZBU8hOi7ViDxx8l/3kXL+HRPs1Ik+gb+DGwSlV9oBSD5Q17tJo5p/7V?=
 =?us-ascii?Q?zYnQgb4aoxTga/UjGYIdHpTQRnNFwEnvWXctzrGuwPgfOBkJ5WnPTa1DTNJN?=
 =?us-ascii?Q?wz0aj1OJr9/T8MiT1zSEmWXZ5J5rz5Cw586XMmCUFyslV+T5epbrLOCeR7w0?=
 =?us-ascii?Q?sT8ENPmzH79Cru8B6YkDSZNhNA1bkHM9HwTS5LoQUP0kEsFA0IlFFb3A7A54?=
 =?us-ascii?Q?5j8KWRAPSeGm1lXg390l0dGq3vO4J9S+AhhtUVG6XxEU7foT81pOh30nxpFt?=
 =?us-ascii?Q?DJuueAqaH07aC1ZU3gvVmlc6HfQe7HKY4WGg1Fz81lF51YfDPKRM38RVU/oN?=
 =?us-ascii?Q?iTiZshTFtFHQDQIXIOmuu57fwHJuIhuSRMmG5QF0fJ2enil1vaehMT8Vh+SE?=
 =?us-ascii?Q?O0Bj1kUPDewbioD6kjKL7iJaQ9pj459L5u91XhCz3cSPoAF8wuV4V48j1aYF?=
 =?us-ascii?Q?2w8nrRN9qWP/H5/3JrLq8OfO7oWwl/lUGNcSdAh15d8xYs72on5gkeP05hMg?=
 =?us-ascii?Q?yT+HUJen6Skx5WsONGXplcVcstXEaVKWqAlCl4BbdTrq0eh9vki7SIe09E2s?=
 =?us-ascii?Q?ImGqt/D+BI0D2c5wf++M2zvVQ74QyaUU8mCSJryCKPgyK5js15Nas3R/q3Qe?=
 =?us-ascii?Q?fcXcg57dKvIJy61xFbRA8jG2gkiFjo90b8AQI5ebM5N3YvmdsUi4UVUu0uQO?=
 =?us-ascii?Q?iMCbDlBFiuuNMrghXMNyKxtECO0BonsQP7tHJ4I2Q7icKFiFHUjgv+VFJgO3?=
 =?us-ascii?Q?XAS0Bi/015BnuPADlIBh0UwlZ3giN0grooMHGYpLEgU9jyckCbxdE2dRu8iT?=
 =?us-ascii?Q?8BV+rFIY/zHkorkeSTQcXrtRXbeE+UVEdXWa0L0baf1TL64l2V/eArXiow8E?=
 =?us-ascii?Q?sGQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d90745-0f7f-433d-6085-08dc5da42bae
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 23:31:26.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7703

From: Michael Schierl <schierlm@gmx.de> Sent: Monday, April 15, 2024 2:03 P=
M
>=20
>=20
> In any case, I see the same content for /sys/firmware/rmi/tables/DMI as
> well as /sys/firmware/dmi/tables/smbios_entry_point on 32-bit vs. 64-bit
> kernels. But I see different content when booted with 1 vs. 2 vCPU.
>=20
> So it is understandable to me why 1 vCPU behaves different from 2vCPU,
> but not clear why 32-bit behaves different from 64-bit (assuming in both
> cases the same parts of the dmi "blob" are parsed).
>=20
>=20
> > If the DMI data is exactly the same, and a
> > 64-bit kernel works, then perhaps there's a bug in the
> > DMI parsing code when the kernel is compiled in 32-bit mode.
> >
> > Also, what is the output of "dmidecode | grep type", both on your
> > patched 32-bit kernel and a working 64-bit kernel?
>=20
>=20
> On 64-bit I see output on stderr as well as stdout.
>=20
>=20
>      Invalid entry length (0). DMI table is broken! Stop.
>=20
> The output before is the same when grepping for type
>=20
> Handle 0x0000, DMI type 0, 20 bytes
> Handle 0x0001, DMI type 1, 25 bytes
> Handle 0x0002, DMI type 2, 8 bytes
> Handle 0x0003, DMI type 3, 17 bytes
> Handle 0x0004, DMI type 11, 5 bytes
>=20
>=20
> When not grepping for type, the only difference is the number of structur=
es
>=20
> 1core: 339 structures occupying 17307 bytes.
> 2core: 356 structures occupying 17307 bytes.
>=20
> I put everything (raw and hex) up at
> <https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgist.=
github.com%
> 2Fschierlm%2F4a1f38565856c49e4e4b534cf51961be&data=3D05%7C02%7C%7Ceaa9f9f=
d
> d3ac480032a808dc5d8f79ec%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C63
> 8488118016043559%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DdcWXWisnx9wwFt
> P4wucScpfQdfI3w%2Fzih%2BGZTGbheJg%3D&reserved=3D0>
>=20
> > root@mhkubun:~# dmidecode | grep type
> > Handle 0x0000, DMI type 0, 26 bytes
> > Handle 0x0001, DMI type 1, 27 bytes
> > Handle 0x0002, DMI type 3, 24 bytes
> > Handle 0x0003, DMI type 2, 17 bytes
> > Handle 0x0004, DMI type 4, 48 bytes
> > Handle 0x0005, DMI type 11, 5 bytes
> > Handle 0x0006, DMI type 16, 23 bytes
> > Handle 0x0007, DMI type 17, 92 bytes
> > Handle 0x0008, DMI type 19, 31 bytes
> > Handle 0x0009, DMI type 20, 35 bytes
> > Handle 0x000A, DMI type 17, 92 bytes
> > Handle 0x000B, DMI type 19, 31 bytes
> > Handle 0x000C, DMI type 20, 35 bytes
> > Handle 0x000D, DMI type 32, 11 bytes
> > Handle 0xFEFF, DMI type 127, 4 bytes
>=20
> That looks healthier than mine... Maybe it also depends on the host...?
>=20
> > Interestingly, there's no entry of type "10", though perhaps your
> > VM is configured differently from mine.  Try also
> >
> > dmidecode -u
> >
> > What details are provided for "type 10" (On Board Devices)?  That
> > may help identify which device(s) are causing the problem.   Then I
> > might be able to repro the problem and do some debugging myself.
>=20
> No type 10, but again the error on stderr (even with only 1 vCPU).
>=20

OK, good info.  If the "dmidecode" program in user space is also
complaining about a bad entry, then Hyper-V probably really has
created a bad entry.

Can you give me details of the Hyper-V VM configuration?  Maybe
a screenshot of the Hyper-V Manager "Settings" for the VM would
be a good starting point, though some of the details are on
sub-panels in the UI.  I'm guessing your 32-bit Linux VM is
a Generation 1 VM.   FWIW, my example was a Generation 2 VM.
When you ran a 64-bit Linux and did not have the problem, was
that with exactly the same Hyper-V VM configuration, or a different
config?  Perhaps something about the VM configuration tickles a
bug in Hyper-V and it builds a faulty DMI entry, so I'm focusing on
that aspect.  If we can figure out what aspect of the VM config
causes the bad DMI entry to be generated, there might be an
easy work-around for you in tweaking the VM config.

Michael Kelley

