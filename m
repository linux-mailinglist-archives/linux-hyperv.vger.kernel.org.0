Return-Path: <linux-hyperv+bounces-1989-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502308A8EE4
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 00:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067B02836B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1317640D;
	Wed, 17 Apr 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ulj68Pf9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2106.outbound.protection.outlook.com [40.92.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1979C8;
	Wed, 17 Apr 2024 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393285; cv=fail; b=jvKdbX8Iulir03J+QM+EiokCnUejkQBBypPgNVHsB1b4F/zZsGVUb2szRWkcXrG6zjyISJ/eiqcWRD09RU/IWEdK4PDXZ+8OAq57eQ1rbHe+qAMVQhD0cutXzk4OBqv0TJtOiraLmfOq0+05/pPLwy60MMGxxN4eizfCPgrDg0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393285; c=relaxed/simple;
	bh=MXIz6zBsshmOlxzDKBZMewhfnF8sfZQhoaWZewYIdqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MaS81ReiyM4AlpQZTXNuXc2Kf6bh8YV9ZsdJTAXvMd36UuWTSKdG2OHMWYRas0P5oTDhqYrjo4/YAHbcXCM5iEzXHRmg/DWNiy//1X1EbSPzJ7esO4FFCZX+EF29RsaeoPANOdm9WWyPs5v7Cd9W4SQq0JDE5TdEE6ILNmaiVrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ulj68Pf9; arc=fail smtp.client-ip=40.92.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXuHsp5X550iM4tdtR3mstf5dQL+cmy6WFJD7ZmYW3yN5vSkC8h014yxq8hR1u6MSuqR61ND8kleSFKm/JWlkJOL/SotjAnQUfHSK0YNV/NJFS6tAIDNm5GffWHmmIJPYEMhuJZE/sE7IhqL5B2Ps0Q8cZa+TTc5geGCTfM+uRflLvOHiYoLgg3afUMfXhSG9qzxSKXmrg2Jy+cN0Ff4M5AfYfEy3wJHrRadnZXW1+HFqrq7NT3MuX06MA0yrZvQ78Afw3ACH1jxX5kNDlEQttuymwAVKckoke47f9wrQiu8efWDsFPcQUyEUcFVMPg2VVXcmuJns3VXfliI09erjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=injFTVFwH/lFDREcOg7fhiy+igw9pSQxtIgI3PO9AGY=;
 b=ODrvP7qDqHHHdy8tgQbOWc5AsNixPwsBPsq2QEotLOqKta8XIiK9L11EHClSpfiQimV1h7UGpx4YqeOXh3C54d19+H7qIXjGzKlTjk1jH8RmJP508ZZjHKsuhfhUnttr81Cb3x/z0Gxjm6xiBKKQFzNPN45kWzNOQ1MirdRPCUhNCj36O8jRtyAfiq/J70vmarQbiinXjaOLiJzcKWbe6VJixBMWX1LVk+fYc0LjEwFfnHFE9PClA1XywF58azCQf2YHMd7B0kNUpjFzN+5J9fy9+EBn1N3HbH9evL8fkKcLOSduSZQGrf7UgG/ukMEZNRMv12EORwn5VPIbQqPaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=injFTVFwH/lFDREcOg7fhiy+igw9pSQxtIgI3PO9AGY=;
 b=Ulj68Pf9VC8GZTO/9lOhqwvczSHl3DDODA7IVZkn/tuNfPwWLf8rmkVrOhT/QYZ5NyFkkxJ+r2eS/dnu8hPB+f9Ka+8ZwNc6Smc1L9u4QHotxubj8HS7nFm1FQczBxFzi7CMZsovQSTaq7Uc+yhHz6l9IRp2Sfq9DH2gljSpzp6b9mTmunH2+qlVeVN9mHNsWCNqx3sR7p2ovAOurkLIZtMSy0pUYGdRJGuvdA4fjNDl17VymwSqKhOOLKyFCqKD0daJOWPPdHsT3SIc7jQzWZWH6L/FhQZeP+aCH0LiWeVXUlgPpthBR8j3hJ74l8UvXyM3Ks1If8VM+Aqbo5QAcw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8454.namprd02.prod.outlook.com (2603:10b6:510:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 22:34:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 22:34:41 +0000
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
 AQHajaNnaKjzbQWkCEqfKgwSAQ9VW7FopBnAgAExRwCAACYysIABcguAgAAcUjCAALI+AIAAvzYAgAAT/rA=
Date: Wed, 17 Apr 2024 22:34:40 +0000
Message-ID:
 <SN6PR02MB4157C677FDAD6507B443A8C7D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
 <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
 <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
In-Reply-To: <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [FSiaChceKrfaFLTIg/ZHiwE6DvQTc/Aa]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8454:EE_
x-ms-office365-filtering-correlation-id: 0a2d72ed-5e38-4fe4-38b4-08dc5f2e925d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Fq4U6OKhZm3hIIz6bNOtQFu5IBN7SVUyPiCqpPeL+wL1R1k5/XqmAaOq4Pee9wCVd6BF3WNm1uWWgnUS/IWWGDrSjv3G0NSXe5RX7VrBRpIXMI2Q5ZverMo4YpNy5F9LrH66+dy0ZK65pzRWTs/1PGQazRH6LXamqncdSEHy6UbLBrBc0Ob2vHpoR48mYmGAhXb8x8OL/px209CDU0eUXHonBwtjIpN6vo8OGVcHDq3ddhslN8wCE/XrabEZy2gwV6eEqobLjoyoGIzIb/XOwal/TZGmTCZx/O4aO3DfZr1HL7fRfjw7D24HQMo8PHXMeDqrlbIo6QpXBeWrRJye2VjW3zjm5PLyNJfPE7csyNKBDdOPvM6hnQjuTMrlMgXDPbVZyC5XB1Rsm1KrGp5vq9KZg806bV8Ty8tnl1l2e2tpIyN7q4fKTzBxD4+NGJqUArJbpcJW5C4Kjfu95COl8jUjwVaYu62/g0Vi+cwGHSr4InIcSFmDV8H4mMTGy69g7WTeROixYX8WJmJNRPCKWWnZbS+WJ1QKQmlDSqJlnNQFqU5SibEn3IVxHO0vD0VL
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tTE7vGEZ9sT8PCashtau4f8HKdW0LLlxvfXoUBGRtzDH66rRsR8aCc5vmAIU?=
 =?us-ascii?Q?HsoMd1Mne2PMmTbKZlyRLL6mE+CG54kYFScNnIgRiTtMydD+Lhu2twEVLKCB?=
 =?us-ascii?Q?LwCGkjpnRp5RBWSDlAOnh/s+0l8vVBCyO2aieRqRXKU3dBmjCE9yxc7rPMl6?=
 =?us-ascii?Q?+ER8jjQTVWEw6YqJ2sabz/OPNcDjrRL52LhDg/tnoP/ZCdFAgpUS8y1RQki6?=
 =?us-ascii?Q?WcAjQx9hAzC1wwkbG142KIlPRO/t64oTTbmxClGyPRevGy2f+6oGcDUdm0Mn?=
 =?us-ascii?Q?aYvmDwgArX7d5rmK/gQaCokg/1zmZ3Qz7BukB3xlZUorRQfEEv/tfZe2BMgK?=
 =?us-ascii?Q?k09Z1ve95zI3yviDDbiTOArCap8p4koI79tPyvLLE9PvE7a/1SpRkb+q8w5Q?=
 =?us-ascii?Q?6lGzUNjjIYW45dpuBWg+TQ8g/2Ipiw+XoPF/8zMPpHCT5a2L/DRA3Ygsae2T?=
 =?us-ascii?Q?E0joG4+iWopzzXNCzhaK4I06hviW1s1sUotRTdoHE0bvwwmcUE2Qp3TY1DyS?=
 =?us-ascii?Q?IHDO3K7uuw/leoy3LKVTaOEKyB5mDeARy15PlrxUgqKG8huKJvqNtee2rz8k?=
 =?us-ascii?Q?W2B4bbWo1N6qNwA6Bemz//QsPrcZ/Yi7ID1/tWwGrXzABNcp6Fl61Zhvy5c2?=
 =?us-ascii?Q?JowLQFUBhL5ouaV876C+gXQV4TpzU1TMOj/jQlI64+D1fz1Btva+KBsWrk5q?=
 =?us-ascii?Q?5afanG6BofuchMEV2tSVDAIUwWZGUIkA5vzTxB2jc1PhiDEF7+2dxxCBO3iS?=
 =?us-ascii?Q?AuPofmkpKpk32unZMtIEZoWg+msYQW9fs+25SCUcnmi7kUQlzcJsIjRpklEe?=
 =?us-ascii?Q?RRMRKdINjgOf65TIla8ut0VIuzjQqKgk6mOHLYfR9Hk9XKqRrdpvTe2RrYGd?=
 =?us-ascii?Q?iPiN3BMVxzGsoUNlt6EJ0Ic2YG6epFtwW1p2qXWQCVTLuJS6KHaQE8RaINn5?=
 =?us-ascii?Q?z0fsOJ8y49gNwr/SARUNE5+g1tm5RCY3X6sadFuIU4B65XqhGQpKbxvQ+RBm?=
 =?us-ascii?Q?1dcU3HZe0SYXIO82kpt+Vup1vs43ymJGG8FA5r+Uu5L0pMF4VhqBGJDOWw5E?=
 =?us-ascii?Q?JVpu+EOYgjtHsxc/1jxB06qgKfVIOCBPN1xkQNzfOrKDq3/+DWEEOfXuTeuy?=
 =?us-ascii?Q?vX100kFCtiNIxqs90SItQHR1WRLvKS2jf4pkhKDbBYXsWwrb6HNwfLsy39PD?=
 =?us-ascii?Q?oHHx2RWGicQwCBdYDLuL8Zk/G/R3hnZ80TJp3g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2d72ed-5e38-4fe4-38b4-08dc5f2e925d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 22:34:40.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8454

From: Michael Schierl <schierlm@gmx.de> Sent: Wednesday, April 17, 2024 2:0=
8 PM
>=20
> > Don't let the type 10 distract you. It is entirely possible that the
> > byte corresponding to type =3D=3D 10 is already part of the corrupted
> > memory area. Can you check if the DMI table generated by Hyper-V is
> > supposed to contain type 10 records at all?
>=20
> How? Hyper-V is not open source :-)

I think that request from Jean is targeted to me or the Microsoft
people on the thread.  :-)

>=20
> My best guess to get Linux out of the equation would be to boot my
> trusted MS-DOS 6.2 floppy and use debug.com to dump the DMI:
>=20
> > | A:\>debug
> > | -df000:93d0 [to inspect]
> > | -nfromdos.dmi
> > | -rcx
> > | CX 0000
> > | :439B
> > | -w f000:93d0
> > | -q
>=20
>=20
> The result is byte-for-byte identical to the DMI dump I created from
> sysfs and pasted earlier in this thread. Of course, it does not have to
> be identical to the memory situation while it was parsed.

I've been looking at the details of the DMI blob in a Linux VM on my
local Windows 11 laptop, as well as in a Generation 1 VM in the Azure
public cloud, which uses Hyper-V.   The overall size and layout
of the DMI blob appears to be the same in both cases.  The blob is
corrupted in the VM on the local laptop, but good in the Azure VM.

I was wondering how to check if the Linux bootloaders and grub
were somehow corrupting the DMI blob, but now you've
answered the question by running MS-DOS and dumping the
contents.  Excellent experiment!

I still want to understand why 32-bit Linux is taking an oops during
boot while 64-bit Linux does not.  During boot, I can see that 64-bit
Linux wanders through the corrupted part of the DMI blob and
looks at a lot of bogus entries before it gets back on track again.
But the bogus entries don't cause an oops.  Once I figure out
those details, we still have the corrupted DMI blob, and based on
your MS-DOS experiment, it's looking like Hyper-V created the
corrupted form.   I want to think more about how to debug that.

FWIW, in comparing the Azure VM with my local VM, it looks like
the corrupted entry is the first type 4 entry describing a CPU.

Michael Kelley

>=20
> > You should also check the memory map (as displayed early at boot, so
> > near the top of dmesg) and verify that the DMI table is located in a
> > "reserved" memory area, so that area can't be used for memory
> > allocation.
>=20
> The e820 memory map was included in the early printk output I posted
> earlier:
>=20
> > [    0.000000] BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]
> usable
> > [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]
> reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
> reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffeffff] u=
sable
> > [    0.000000] BIOS-e820: [mem 0x000000007fff0000-0x000000007fffefff] A=
CPI
> data
> > [    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff] A=
CPI NVS
>=20
> And from the dmidecode I pasted earlier:
>=20
> > Table at 0x000F93D0.
>=20
> The size is 0x0000439B, so the last byte should be at 0x000FD76A, well
> inside the third i820 entry (the second reserved one) - and accessible
> even from DOS without requiring any extra effort.
>=20
> > So the table starts at physical address 0xba135000, which is in the
> > following memory map segment:
> >
> > reserve setup_data: [mem 0x00000000b87b0000-0x00000000bb77dfff] reserve=
d
>=20
> Looks like UEFI, and well outside the 1MB range :-)
>=20
> > If the whole DMI table IS located in a "reserved" memory area, it can
> > still get corrupted, but only by code which itself operates on data
> > located in a reserved memory area.
>=20
>=20
> > Both DMI tables are corrupted, but are they corrupted in the exact same
> > way?
>=20
> At least the dumped tables are byte-for-byte identical on both OS
> flavors. And (as I tested above) byte-for-byte identical to a version
> dumped from MS-DOS.
>=20
>=20
> Regards,
>=20
>=20
> Michael


