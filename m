Return-Path: <linux-hyperv+bounces-2006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB28AB36C
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DC51C2139F
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326AA130A73;
	Fri, 19 Apr 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NkggnRnQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2092.outbound.protection.outlook.com [40.92.18.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11D85629;
	Fri, 19 Apr 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544574; cv=fail; b=n5vWE4e8HWcpQauB0AHOHlrG+QUpxvBDzSjCUlkvTHcamfMEc9UK7b7dTLchtJq+5OsMCKdwlB9+094Rj8Eaq4MtOIo+BlPcFsrbVlQyRoacmR0VGlNReOOaiKCIbVmbdqeQ54BVsT/kQpLKHWzZVp60p13Xl9f/QfBikAHxjjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544574; c=relaxed/simple;
	bh=vtkiSEhUKyqqQsfsxpOajjN5LKXuqC1ctH86sAa6/0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PdnDfG0tB6PWcAsSAB4JaQg91Y9twUIp8RWORfBkMI4in/O7R9fCcw1/g45helCYsISW7bSTF0I5MkTNzXqNoFd0/8xsXjqRAaM/cbskzCIKnWW//8pOmnbMIQtjC7jLL6CDBkP8fMEEmFgtFrAJxaFXKXvMvFdIIQDLBoWQNhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NkggnRnQ; arc=fail smtp.client-ip=40.92.18.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY9R/xkBY4In7nKUQi7sTnF52f3O67nYxo5OBM4yR4G3yR0B8DrcjRqLkQzBKUcAqpN0+ndZ+uoml/VrnV8gMzfNQVwOBAXkZujBuDlebg6UILY2oCvT+fS4BZZI3OtbZdH4nA2TCzweN9eY3eJbsMtnXpmWaE0UHI9i0C4qp+50PuekASJQneFPBWkLyUX+V6KZt4cETffFp2YuPqgUPsOIgqRW2onwrQlt3fLTiv8sLl1f7v+SGY3R2EqYErwO8RSVcoy1uaoqlwL7AcLGFM5IWSCxvgqiCmDG6BBuCnF0gqmF2qg5FhVO2t64GFL3apmfrP53uU1AhL3wMCCH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxEOJgb0DA6/6UHB+taOyDpW7j3MK9eJAE0UUJi3xtc=;
 b=AiA7w5szqEFe5I0+qoUd/I8CyugOcYEzNH0GQPP5NSUp/ULukv0ExwZNVWTS+YdTn/3J9ex+p19xw+CF7cWErk4kLkqXGq8I5FlXlv3fW2uyfaODEvYmjj0k6qsht3Z+j0Mnwy2jjyDDcXbzD9kcVKzDmzXYzNuwlmcItkGrf37J+rXVrllE5xPHFDY92R8W7yYiETwAafZp7BYmTazELHGf8E+7vkAfFmeeVKNBA4GLfXkxlFXALdFJQ7dwiPWE+4M5cXNeJxR+fOTGNtLuTVAifzWwg9KhGLiBiSSoLFBRhAwK7+bVfsHLjZgL/U+GoR1/snYmRRo1GftmrCftUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxEOJgb0DA6/6UHB+taOyDpW7j3MK9eJAE0UUJi3xtc=;
 b=NkggnRnQ5oVKKW9gPML4AZo+K1pW4UGInhwEyic9mn3qfnPPYTo+5ghPa3zxK/3aamovEGOPZbOTAINx1vcZ/lDxF1PJT87SE2uuWOFHqi8fvW9x3HoAwnp5/KKxN+dnJjLAuf7dfDSQ0YA0RS0sBv2nCbpDZGxba+kgGncsoM9HnMaCd1rBEjytSiDlgnVePR09gITrAJRG0o15zjQ78Q6oUEXr1vx8aPmQ0/Mwch31g9PQBV76XQFjSbeE4hEFoPbughBK9pu0+eGpZ9DcHwA3QyousRbV5/j5m3HFkkOyN0TQzeUpztybmq37wxkyq40lz1R4Y7b+uAM/M5MZiA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7614.namprd02.prod.outlook.com (2603:10b6:a03:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 16:36:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 16:36:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Michael Schierl <schierlm@gmx.de>,
	Jean DELVARE <jdelvare@suse.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Topic: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
Thread-Index:
 AQHajaNnaKjzbQWkCEqfKgwSAQ9VW7FopBnAgAExRwCAACYysIABcguAgAAcUjCAALI+AIAAvzYAgAAT/rCAAsG3QA==
Date: Fri, 19 Apr 2024 16:36:09 +0000
Message-ID:
 <SN6PR02MB415733CB1854317C980C3F18D40D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
 <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
 <3c6f9fea-6865-40da-96c5-d12bc08ba266@gmx.de>
 <SN6PR02MB4157C677FDAD6507B443A8C7D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157C677FDAD6507B443A8C7D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [DC1IZUTyTVK1WPrxen6/zSmf3d136UZz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7614:EE_
x-ms-office365-filtering-correlation-id: bf651c8b-0219-4955-7615-08dc608ed1ba
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1h7VCyh4nwaUHRDStKvfk0n/AH/B678n7qP8Y8r1ky2F3R3qwgUeV6xx9vj2bhkVpVA41Tfk9Qgw2Z7W92fs3e7w8WYjXSWuMFV6q66ZHsqSO5ROCr6ZKhmdfgX2NyC/LP0TQWRhptGUC1RYJudRbbRGZZisof8YPtLxI3bdk3QFtBq2dDNHd/g2qgJ8KcuGaUnocE5G4z5SZMaJseFLzhz2xSU2YFs1bEI/QGY6H7CgsLDJRdqffUbRQnuMVZqoN68zPsEBjMeBMl/LEoO1gz9tk/RMEPt/kNDnX+W3BRC+ZsmZqUIQFgg0SAb/U5NA1ipB9oMmzeiZVefinWo70NOfkycvPhx5lmcp1EVyhESVJGshgzDLZQyNA/5HUNxN4CCRSXg3MwFFjFL6lWCYxdLKYPrt++EYpzz1uxq0GTdMEBkW35i+O8LB71O3+9/l2c4wjLd4M7eSHX0LrSF9tKBRyHs0xTSZ+28WXxLy8q+zcBLYoy0hlLomUrUzIrMRB0FtXOnlxGWgkDYnyUdkeiu8WCtbrYf9IKwyZ20xclPIAbsj49Ey69/GPNPfzmlmUWwuSjDR6y0oY7I3LQj0Fg+A5J0HgsWjzKuAxaPVrKFJK9sYJdgLL19gcXP+ij9y
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ExNsu3CF62pI4DevhCMthK5ljXZkwfQvAJLgbvA/yyT0Y1UVHbVXCsEltu0O?=
 =?us-ascii?Q?GIDXn0Lf/SvKij/1RWkWIi5bZ4lg461GUxBTOhKuboRorh1i5xz3YXDWIbUh?=
 =?us-ascii?Q?cXBGlvqQdvPymSdQypAdG7Zv7nJTxYU5wG9DhVjFeBy9gmAr0MjxamB3ZlHB?=
 =?us-ascii?Q?dJhJVsnartTjbLbWotBb8EudwBTe1QBDJ3SyPFRsvAptDhHDNVBsvqjTfYEl?=
 =?us-ascii?Q?r/iztzmxaJvOy9MfFoaWGMc9DN8kYXZvB+rW0Mlqqw/1AxpYQ3cmj/TDT4G1?=
 =?us-ascii?Q?TWM2CVPSnlErXTFA8nQCq/ecdYta2jto/OxEmF69zEd0M4xwDQsZgv9kaRcd?=
 =?us-ascii?Q?4+3HzOalJ1d/GjVRXJlaBLulUddPzGzZjTpTGbGib+wnz3ZnYI7UiZBSHdRf?=
 =?us-ascii?Q?E2J1y6mHxPoHmuj6f9wphlWEsX5HyUCDr8SG/jLH2iT18TAVqU4HelDMZetP?=
 =?us-ascii?Q?u9e/MGE5qHoBNIEaTlUah2HnqTZaWueJuKxC/tQvc8Dqlm3Z8JVfzWMGkFoA?=
 =?us-ascii?Q?a5A8wqlJhWZCiDFKmXYGhZ/8g3kpOggPT2U5GTjl4gojx9siN5Ycc06LVNfY?=
 =?us-ascii?Q?VZ4GeQI/ShN/7yYBA4r34tuTw1/BokTb5SbtqJl4gOLWOwMlH3S01ukvdtd5?=
 =?us-ascii?Q?drnVGCn3ibg7D29ETpSeLdc82S9681a5+q6LmAwBO1hxF4n9fFdeQK5i/5zu?=
 =?us-ascii?Q?Lbn4SHNjjYGDsVkdoIhBF/fZf6EceLifRI0jyHCbWe6rhqE9JWjvJhcpP+7N?=
 =?us-ascii?Q?A+CTz1PjifEbMst0QZXS+6l0XuQx/2WcRcvVrLKen5uloO7JghbipHQCEdlL?=
 =?us-ascii?Q?YzIbAhxYVAWp+Bwb3KoXn/5rNSLdhOuw4o8PJT7UFfLLIMgohHjfPhUPGCBJ?=
 =?us-ascii?Q?LpXU51UOLEFsmq1OAEE3JBphnJ+sGY4lyqmxFXuFROlQnzM6ERanQvW/kGsF?=
 =?us-ascii?Q?eh/rBgd49Ip81zDVyTKXz8ObngowBv/A5TQR/Lxop/YfgDr9kIRX23orbjRp?=
 =?us-ascii?Q?oOstsiLpWPFLINs4ApVzIrCf0Eg2wq4WsNGHHmjuSCVMG3Aqxqp2WC4OEAyT?=
 =?us-ascii?Q?AEO2aBTjN9CZvXzddejuqGadwx7a2vWwSDHEanb8l0oC0svZCwQGjdyjMKRV?=
 =?us-ascii?Q?2XFOG6aMzu6kD2w5jHa1JhA1cVBnBTSsa96UbvIWCvxuTSEk5gSwU+UnKmdt?=
 =?us-ascii?Q?JTVPkI/WN+7eM8OizFLxxIZDCtrBQHtKFqYUQA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf651c8b-0219-4955-7615-08dc608ed1ba
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 16:36:09.9574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7614

From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, April 17, 2024=
 3:35 PM
>=20
> From: Michael Schierl <schierlm@gmx.de> Sent: Wednesday, April 17, 2024 2=
:08 PM
> >
> > > Don't let the type 10 distract you. It is entirely possible that the
> > > byte corresponding to type =3D=3D 10 is already part of the corrupted
> > > memory area. Can you check if the DMI table generated by Hyper-V is
> > > supposed to contain type 10 records at all?
> >
> > How? Hyper-V is not open source :-)
>=20
> I think that request from Jean is targeted to me or the Microsoft
> people on the thread.  :-)
>=20
> >
> > My best guess to get Linux out of the equation would be to boot my
> > trusted MS-DOS 6.2 floppy and use debug.com to dump the DMI:
> >
> > > | A:\>debug
> > > | -df000:93d0 [to inspect]
> > > | -nfromdos.dmi
> > > | -rcx
> > > | CX 0000
> > > | :439B
> > > | -w f000:93d0
> > > | -q
> >
> >
> > The result is byte-for-byte identical to the DMI dump I created from
> > sysfs and pasted earlier in this thread. Of course, it does not have to
> > be identical to the memory situation while it was parsed.
>=20
> I've been looking at the details of the DMI blob in a Linux VM on my
> local Windows 11 laptop, as well as in a Generation 1 VM in the Azure
> public cloud, which uses Hyper-V.   The overall size and layout
> of the DMI blob appears to be the same in both cases.  The blob is
> corrupted in the VM on the local laptop, but good in the Azure VM.
>=20
> I was wondering how to check if the Linux bootloaders and grub
> were somehow corrupting the DMI blob, but now you've
> answered the question by running MS-DOS and dumping the
> contents.  Excellent experiment!
>=20
> I still want to understand why 32-bit Linux is taking an oops during
> boot while 64-bit Linux does not. =20

The difference is in this statement in dmi_save_devices():

	count =3D (dm->length - sizeof(struct dmi_header)) / 2;

On a 64-bit system, count is 0xFFFFFFFE.  That's seen as a
negative value, and the "for" loop does not do any iterations. So
nothing bad happens.

But on a 32-bit system, count is 0x7FFFFFFE. That's a big
positive number, and the "for" loop iterates to non-existent
memory as Michael Schierl originally described.

I don't know the "C" rules for mixed signed and unsigned
expressions, and how they differ on 32-bit and 64-bit systems.
But that's the cause of the different behavior.

Regardless of the 32-bit vs. 64-bit behavior, the DMI blob is malformed,
almost certainly as created by Hyper-V.  I'll see if I can bring this to
the attention of one of my previous contacts on the Hyper-V team.

Michael

> During boot, I can see that 64-bit
> Linux wanders through the corrupted part of the DMI blob and
> looks at a lot of bogus entries before it gets back on track again.
> But the bogus entries don't cause an oops.  Once I figure out
> those details, we still have the corrupted DMI blob, and based on
> your MS-DOS experiment, it's looking like Hyper-V created the
> corrupted form.   I want to think more about how to debug that.
>=20
> FWIW, in comparing the Azure VM with my local VM, it looks like
> the corrupted entry is the first type 4 entry describing a CPU.
>=20
> Michael Kelley
>=20
> >
> > > You should also check the memory map (as displayed early at boot, so
> > > near the top of dmesg) and verify that the DMI table is located in a
> > > "reserved" memory area, so that area can't be used for memory
> > > allocation.
> >
> > The e820 memory map was included in the early printk output I posted
> > earlier:
> >
> > > [    0.000000] BIOS-provided physical RAM map:
> > > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]=
 usable
> > > [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]=
 reserved
> > > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]=
 reserved
> > > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffeffff]=
 usable
> > > [    0.000000] BIOS-e820: [mem 0x000000007fff0000-0x000000007fffefff]=
 ACPI data
> > > [    0.000000] BIOS-e820: [mem 0x000000007ffff000-0x000000007fffffff]=
 ACPI NVS
> >
> > And from the dmidecode I pasted earlier:
> >
> > > Table at 0x000F93D0.
> >
> > The size is 0x0000439B, so the last byte should be at 0x000FD76A, well
> > inside the third i820 entry (the second reserved one) - and accessible
> > even from DOS without requiring any extra effort.
> >
> > > So the table starts at physical address 0xba135000, which is in the
> > > following memory map segment:
> > >
> > > reserve setup_data: [mem 0x00000000b87b0000-0x00000000bb77dfff] reser=
ved
> >
> > Looks like UEFI, and well outside the 1MB range :-)
> >
> > > If the whole DMI table IS located in a "reserved" memory area, it can
> > > still get corrupted, but only by code which itself operates on data
> > > located in a reserved memory area.
> >
> >
> > > Both DMI tables are corrupted, but are they corrupted in the exact sa=
me
> > > way?
> >
> > At least the dumped tables are byte-for-byte identical on both OS
> > flavors. And (as I tested above) byte-for-byte identical to a version
> > dumped from MS-DOS.
> >
> >
> > Regards,
> >
> >
> > Michael
>=20


