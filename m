Return-Path: <linux-hyperv+bounces-6356-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC52B0F4FF
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 16:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A05B169D21
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B72E719B;
	Wed, 23 Jul 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q+NuIz6X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2098.outbound.protection.outlook.com [40.92.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E042DCBF5;
	Wed, 23 Jul 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279997; cv=fail; b=LyO1MTfPT3m3phzyMrUfc2yBiEgHnQE+mke/XlGiICcMZmQvUcGCyHF8bdd9jbdE0MEQ6TpVRNxz+fixJQwUVosselt8bed4P1gHEseIJLzMuvQTmfj/EIta6N9Lr9v6Mm4dekBNGrq1dnXEpr3imEp7UIrseQMbE3D4PpCI9sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279997; c=relaxed/simple;
	bh=zZHOva/3QrRI9MggepMTuFbX7S/GYsTiVE8PeuCZ81o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KX3DcQxtPj4gmdyg4Xynu4Yqx7a7lxWoHEEA58352lfqsGQ0msjmMhG0eoIpM6ClN/k3+7woTYrL8xQeEvDEhbqwaIvfU4zv2Zz0auQ+r3rJvwLA+2/6yZnZ4SnBYu92r9AlSRhd2Y9W4swUEuJchzMkgP9oIcIik77zQ3b/8y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q+NuIz6X; arc=fail smtp.client-ip=40.92.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M947DdeP7E5UAXdtD2cdo/DVnnUHJFVSk7N/NhROINKfMoj+6MXiPJJUUeHKXKiKERstDOxIOQqqToWFG1TkyVwHcOiirCa7A9j2sAz07CGfQhl3UJ0DhMSlfvs7dWPwn5WbMIdkc0GgG1MdQvvN4GzHhKVleBa9T8qV5o38wjuP5qXicMm4ny+6b9Wy16Uh++UVWbICu0gj+FMjBW37O/hAVrEPjVdgq85mt6A2ID1l6DMNQTbcrN76bm80Vcb/PbX3uWDtcG2jxsGK0TGE7NPpkFSsVy5TXDgfHedaWHmLAHPJaWs+VonnjG2sCYbtx+g9Xv5HMMfT/ln64hcVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAbud718A9jk/9bezh1kFx1nmnak2yD4bcuqdQD0tcA=;
 b=YD9K5DbWm6SxrlnLBY10EAkvUi9VGFIg+McCE58ssZ0NjElhIJ3FPBgwfQ/YyR98ClJ8jvpF9qxkx0MzRbUdNM3xuIEhHZQDR50e8psItmgpIW+nVTge+mjzsyiEPScOdu/iRySCU/T82r5SalDNsKfy4SlmRXRrMHNxy/zYe8cAT6fxx433lwNxy9P6IPkrGuWnzkzIZhtykmO5Barn6fORpZITHvYMbCSybytxezudh6TT8H7wMf0EDLRmsdRo42magqE1HOToK/Fr1QHgjx5xTlDN2e84tHxN64HihqHTdJ86Oj7q4Lh0+bbZx4HPIlMIXAwdFQ7Cl3Qkx3gubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAbud718A9jk/9bezh1kFx1nmnak2yD4bcuqdQD0tcA=;
 b=Q+NuIz6XRX38c3x51ZPefhgIUD60XN//AIp0ZBSHEy0+sO3w8rzr4obJxAxVN9gGA4wusSnxbH95+nKZH0BSrByFflInv5Ra1sfKwjAG4wlwzaaOs9yot3hEjgCR+EaizV4ic9aZDw5D5lhKkAIBaxTeOOJUA7ulBrDbDp175HO1aPfF72PfqaJlcyxyyRH6HMGBPLjrXYyKChbYtjQe5ILYiyxibOeaxtw2yt/uGNvO11amaSYQ52BJUNFMQOQT1FvS+DC5vTTQBnZyAGIspSdYOGA6l7N+lCRUKxExstx6yOZltcEZyMlHrMat5N0kl+ZAg5dfgadaeF/UFej8dg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10423.namprd02.prod.outlook.com (2603:10b6:208:537::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 14:13:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 14:13:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v5 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index:
 AQHb2qJWl9MJjouTb0Sl2AaDU/QSG7QN8ajQgCmUHYCAAJ0FQIAGGhyAgABfntCAAR7qgIAAQ4hQ
Date: Wed, 23 Jul 2025 14:13:10 +0000
Message-ID:
 <SN6PR02MB4157592293F7501A4E5C73E4D45FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250611072704.83199-1-namjain@linux.microsoft.com>
 <20250611072704.83199-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <42bc5294-219f-4c26-ad05-740f6190aff3@linux.microsoft.com>
 <SN6PR02MB415781ABC3D523B719BDE280D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <5bf4e550-34e1-4b6b-8ee2-137681a72d42@linux.microsoft.com>
 <SN6PR02MB41578D18024EC5339690046CD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <829f0716-d2f2-449f-8f49-397a46046c69@linux.microsoft.com>
In-Reply-To: <829f0716-d2f2-449f-8f49-397a46046c69@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10423:EE_
x-ms-office365-filtering-correlation-id: 4a6435e7-0b2f-47dd-94d5-08ddc9f30e14
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|19110799012|8062599012|8060799015|3412199025|40105399003|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C7YNNnRlXur8rleUBX6erxlEfV/IYepC6VRSolUbZlxbA9Svm7c8g2NMz4nF?=
 =?us-ascii?Q?Q/gB7YJjbj3xuYD4bm/CCI+qUQhu7eh6Mu2D6RWxd8xxH5M5XISPhMgcy+yc?=
 =?us-ascii?Q?iA2ZR6UbiQkOCDeFvFRP0Fb5VmhBNn+S7cOQxo9gdOp1KlKW0pysTAPCvcWS?=
 =?us-ascii?Q?FSvnj+w0r3nBsMF6B7yd8tBbacc1oKhpZhGyLHL5jA9KA6Lx5Atw9j2kaTm8?=
 =?us-ascii?Q?YTUhCus0u5kgaoMK+2CdZIZm3/EXhc0udXW03yBHRbGXRgI1XWpioTnjLn9H?=
 =?us-ascii?Q?Oh7LMg/Ag6P+oadmolr/8V+AOpiqG9vyHyReYt4RMKJuYMe3xq3m49gePk5B?=
 =?us-ascii?Q?bzyOoKtLIy/VRnesgCwgqUTZuMogXZsiZBFe3EMExggu3sNX9zLr63QHkIGu?=
 =?us-ascii?Q?is+/s8lo2K5vShWZfNIaJ4YfvW74ZdEaVgqcKwd2syArOvtNkHYUI7YSS14h?=
 =?us-ascii?Q?RoCd1x4zkwa9q8zTS0JV/H/13+HNYZDLq3nrY2V1szt+m4gvTvJlIqPGZYRU?=
 =?us-ascii?Q?k7FUv2tg/aP4DM4RWydLyi1+J7ITd7FnHBiyXy7Np7IOIavlqDTtsGgxt2UZ?=
 =?us-ascii?Q?OhjLUuN237jgxDFxH14gf4MiGyBciT4Us0TXghbaakrIIDMdmhhGtmUfUnc3?=
 =?us-ascii?Q?AfN0tKCflFwOcwtW1ORPZAXyAuV0h+b9N6R4EmiwvtVuF+522BgWKTcDbL9l?=
 =?us-ascii?Q?YNanBpIRmaChki5O2nUBkG/UOnqFKLfPR4IPjQd8LSDk8bwmx1fyk5moVDqI?=
 =?us-ascii?Q?7gb/uKXWoXkdpFJ0fAdioosfeALeCZLsFnlU6WfnOKBQ3b8wtRsaJjRVUaxG?=
 =?us-ascii?Q?MoAdfsR4qltgjI4DYXNj5H5MMdr80/5t2OCJvnoX6kfzNbB1Vbl5CZkFo7Hx?=
 =?us-ascii?Q?U5aVjTdmA1clkl8A+iA00M48AHV43TkPl4JKBeHZYHf5edfQb7ZLZ06E9Gur?=
 =?us-ascii?Q?/fpFIvOhCMHH1tDtdcSQ60cKFFmjBewFN70Ln6imMdgWMdyoCbpQDEgvYSd+?=
 =?us-ascii?Q?/6udwJ1PfQov6De6e+QgrNThf0VnbfAjxq3s0hsAN8WeYFcVH4kEKin2Qa+T?=
 =?us-ascii?Q?qTOwYJYyunOXwMJhaNxVZ7JDJw3F7s6Ch293Neq2CzhOa0uJgebWzH+d1GeL?=
 =?us-ascii?Q?c7kNAoFxL53VCFmCGxF7I1qHUHJEStiy1G2N1CohBi1fBP+n10RPky0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t+6+QlZh5l8BHih+GjWVN/6WJvr0Iv5WsbnCJUNTtcLkAVMx07vqXNtf6UtS?=
 =?us-ascii?Q?jB9Fsg8t0CxzB2MsYKACfdHperzmBYsA8Ub3gXem+NYczbFUxSN3ZSh47060?=
 =?us-ascii?Q?HoHfQjTnz1A4GW564UW5bahd/rSb1tejcvovTZxPlkZqUGL5UKVArPvPtanI?=
 =?us-ascii?Q?KmBJFT4/f6FyY9HAlxD8phLzxlfhHajF98eeT8rbIzgWiPlQSLvq2i0Dw3Yg?=
 =?us-ascii?Q?8v/Hxt21XpIN54S6dhzPNSYTwgRIlrQssXld9RPStPpu3WgOfta6Zxcv0GMJ?=
 =?us-ascii?Q?4B2sgG6zvwR/OotfzEfIP06TJXu2o2b7k6kNzoVehJ9NZcAt3760GYmcEwm1?=
 =?us-ascii?Q?tozJULFlVV7ep8pgGiLRsMPVl2fvlXimcZB1LhMb+ZDMwYYo31aofwQqQisI?=
 =?us-ascii?Q?nUOe+9b12it986uMWJm/EnNZ5MCFTLqBCbZaRx6kwJTDFdxbD6pFLVh+OsLQ?=
 =?us-ascii?Q?NKDwEoMUbPiJntnohB31p/JYz8zZBhFANT0NoFbUYImY+hdjCuNQvwcJvs2w?=
 =?us-ascii?Q?Dq3LaddEf04t93/yIROz4eZs0m+2ZRdoQS1ml23VuLNLOohgSqlFS4VOVozY?=
 =?us-ascii?Q?ytSGD86FeFSsSVRvjKKaqpnP+rOGWNkID1KiP6i2w23zkBu01EaLhXE5+GeN?=
 =?us-ascii?Q?agxogWHFVEBk2BGYIYRpXIFjBVDV0xAzNv4h2anYHvMzQdc5peX1scr5xxim?=
 =?us-ascii?Q?DyHsTnOijKsxp1ozZFbzuK68IiDp90eNX7kNlSNvRj1GzRfhwge6LPHKpvqb?=
 =?us-ascii?Q?hKhfKppb7/mEM++aMxvQJR5ZRoD3vCwd1YmGYL/bsfOK9xE3aHUbKwctkQFA?=
 =?us-ascii?Q?mYswGI/5msZmjm9mlQusr6h9o33wbNydYSCJGkck1RQFknUUKBKjKg+teTje?=
 =?us-ascii?Q?JCK8w2EHYskhjEWe5gpDODWLKCvacxLRw+AaNpqnAEpjTdlvrhNomJrp0o9n?=
 =?us-ascii?Q?VOXnLgQLIagSg8uRDDlBSCfe//u8009XIymDb0Wr1V1i9IpVrc1TR7JHQ418?=
 =?us-ascii?Q?f5emU0Dx839IEBR8caQZoAaoNpv9tzWArykCRARYHMGulsvR1/bNfqzJ19xS?=
 =?us-ascii?Q?ft2G7+oL0d50fcb/PrtChwIdrjtHyXe756FePaAGB++TDCzWsA8tktZXeBkE?=
 =?us-ascii?Q?01icVKrAmWbfa1VKnvU7KWMPevsAHXcFUxjPY9b52+aJwJuzWzWYaY5zuUdO?=
 =?us-ascii?Q?qEUQ5TNIZcI3VC8HD3lljb125bwgpLBaCRWYfmz7MiPpkQWo7oSHybNoDt0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6435e7-0b2f-47dd-94d5-08ddc9f30e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 14:13:10.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10423

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, July 23, 20=
25 2:59 AM
>=20
> On 7/22/2025 10:39 PM, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, July 22, =
2025 4:09 AM
> >>
> >> On 7/18/2025 8:37 PM, Michael Kelley wrote:
> >>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 1=
7, 2025 9:36 PM
> >>>>
> >>>> On 7/9/2025 10:49 PM, Michael Kelley wrote:
> >>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, Jun=
e 11, 2025 12:27 AM
> >>>
> >>> [snip]
> >>>
> >>>>
> >>>>> Separately, "allow_bitmap" size is 64K bytes, or 512K bits. Is that=
 the
> >>>>> correct size?  From looking at mshv_vtl_hvcall_is_allowed(), I thin=
k this
> >>>>> bitmap is indexed by the HV call code, which is a 16 bit value. So =
you
> >>>>> only need 64K bits, and the size is too big by a factor of 8. In an=
y case,
> >>>>> it seems like the size should not be expressed in terms of PAGE_SIZ=
E.
> >>>>
> >>>> There are HVcall codes which are of type u16. So max(HVcall code) =
=3D
> >>>> 0xffff.
> >>>>
> >>>> For every HVcall that needs to be allowed, we are saving HVcall code
> >>>> info in a bitmap in below fashion:
> >>>> if x =3D HVCall code and bitmap is an array of u64, of size
> >>>> ((0xffff/64=3D1023) + 1)
> >>>>
> >>>> bitmap[x / 64] =3D (u64)1 << (x%64);
> >>>>
> >>>> Later on in mshv_vtl_hvcall_is_allowed(), we calculate the array ind=
ex
> >>>> by dividing it by 64, and then see if call_code/64 bit is set.
> >>>
> >>> I didn't add comments in mshv_vtl_hvcall_is_allowed(), but that code
> >>> can be simplified by recognizing that the Linux kernel bitmap utiliti=
es
> >>> can operate on bitmaps that are much larger than just 64 bits. Let's
> >>> assume that the allow_bitmap field in struct mshv_vtl_hvcall_fds has
> >>> 64K bits, regardless of whether it is declared as an array of u64,
> >>> an array of u16, or an array of u8. Then mshv_vtl_hvcall_is_allowed()
> >>> can be implemented as a single line:
> >>>
> >>> 	return test_bit(call_code, fd->allow_bitmap);
> >>>
> >>> There's no need to figure out which array element contains the bit,
> >>> or to construct a mask to select that particular bit in the array ele=
ment.
> >>> And since call_code is a u16, test_bit won't access outside the alloc=
ated
> >>> 64K bits.
> >>>
> >>
> >> I understood it now. This works and is much better. Will incorporate i=
t
> >> in next patch.
> >>
> >>>>
> >>>> Coming to size of allow_bitmap[], it is independent of PAGE_SIZE, an=
d
> >>>> can be safely initialized to 1024 (reducing by a factor of 8).
> >>>> bitmap_size's maximum value is going to be 1024 in current
> >>>> implementation, picking u64 was not mandatory, u16 will also work. A=
lso,
> >>>> item_index is also u16, so I should make bitmap_size as u16.
> >>>
> >>> The key question for me is whether bitmap_size describes the number
> >>> of bits in allow_bitmap, or whether it describes the number of array
> >>> elements in the declared allow_bitmap array. It's more typical to
> >>> describe a bitmap size as the number of bits. Then the value is
> >>> independent of the array element size, as the array element size
> >>> usually doesn't really matter anyway if using the Linux kernel's
> >>> bitmap utilities. The array element size only matters in allocating
> >>> the correct amount of space is for whatever number of bits are
> >>> needed in the bitmap.
> >>>
> >>
> >> I tried to put your suggestions in code. Please let me know if below
> >> works. I tested this and it works. Just that, I am a little hesitant i=
n
> >> changing things on Userspace side of it, which passes these parameters
> >> in IOCTL. This way, userspace remains the same, the confusion of names
> >> may go away, and the code becomes simpler.
> >
> > Yes, I suspected there might be constraints due to not wanting
> > to disturb existing user space code.
> >
> >>
> >> --- a/include/uapi/linux/mshv.h
> >> +++ b/include/uapi/linux/mshv.h
> >> @@ -332,7 +332,7 @@ struct mshv_vtl_set_poll_file {
> >>    };
> >>
> >>    struct mshv_vtl_hvcall_setup {
> >> -       __u64 bitmap_size;
> >> +       __u64 bitmap_array_size;
> >>           __u64 allow_bitmap_ptr; /* pointer to __u64 */
> >>    };
> >>
> >>
> >> --- a/drivers/hv/mshv_vtl_main.c
> >> +++ b/drivers/hv/mshv_vtl_main.c
> >> @@ -52,10 +52,12 @@ static bool has_message;
> >>    static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
> >>    static DEFINE_MUTEX(flag_lock);
> >>    static bool __read_mostly mshv_has_reg_page;
> >> -#define MAX_BITMAP_SIZE 1024
> >> +
> >> +/* hvcall code is of type u16, allocate a bitmap of size (1 << 16) to=
 accomodate it */
> >
> > s/accomodate/accommodate/
>=20
> Acked.
>=20
> >
> >> +#define MAX_BITMAP_SIZE (1 << 16)
> >>
> >>    struct mshv_vtl_hvcall_fd {
> >> -       u64 allow_bitmap[MAX_BITMAP_SIZE];
> >> +       u64 allow_bitmap[MAX_BITMAP_SIZE / 64];
> >
> > OK, this seems like a reasonable approach to get the correct
> > number of bits.
> >
> >>           bool allow_map_initialized;
> >>           /*
> >>            * Used to protect hvcall setup in IOCTLs
> >>
> >> @@ -1204,12 +1207,12 @@ static int mshv_vtl_hvcall_do_setup(struct msh=
v_vtl_hvcall_fd *fd,
> >>                              sizeof(struct mshv_vtl_hvcall_setup))) {
> >>                   return -EFAULT;
> >>           }
> >> -       if (hvcall_setup.bitmap_size > ARRAY_SIZE(fd->allow_bitmap)) {
> >> +       if (hvcall_setup.bitmap_array_size > ARRAY_SIZE(fd->allow_bitm=
ap)) {
> >>                   return -EINVAL;
> >>           }
> >>           if (copy_from_user(&fd->allow_bitmap,
> >>                              (void __user *)hvcall_setup.allow_bitmap_=
ptr,
> >> -                          hvcall_setup.bitmap_size)) {
> >> +                          hvcall_setup.bitmap_array_size)) {
> >
> > This still doesn't work. copy_from_user() expects a byte count as its
> > 3rd argument. If we have 64K bits in the bitmap, that means 8K bytes,
> > and 1K for bitmap_array_size. So the value of the 3rd argument
> > here is 1K, and you'll be copying 1K bytes when you want to be
> > copying 8K bytes. The 3rd argument needs to be:
> >
> > 		hv_call_setup.bitmap_array_size * sizeof(u64)
> >
> > It's a bit messy to have to add this multiply, and in the bigger
> > picture it might be cleaner to have the bitmap_array be
> > declared in units of u8 instead of u64, but that would affect
> > user space in a way that you probably want to avoid.
> >
> > Have you checked that user space is passing in the correct values
> > to the ioctl? If the kernel side code is wrong, user space might be
> > wrong as well. And if user space is wrong, then you might have
> > the flexibility to change everything to use u8 instead of u64.
> >
>=20
>=20
> This is correct in Userspace:
> https://github.com/microsoft/openvmm/blob/main/openhcl/hcl/src/ioctl.rs#L=
905
>=20

I'm not really Rust literate, but it does look like userspace is
setting the bitmap_size to the number of *bytes*. User space has
used u64 as its underlying type, which is OK as long as the ioctl
API is understood to take a byte count in the bitmap_size field,
and user space populates that field with a byte count, which it does.

> This was wrong in kernel code internally from the beginning. This did
> not get caught because we took a large array size (2 * PAGE_SIZE) which
> never failed the check
> (hvcall_setup.bitmap_array_size > ARRAY_SIZE(fd->allow_bitmap))
> and hvcall_setup.bitmap_size always had number of bytes to copy.
>=20
> We can make allow_bitmap as an array of u8 here, irrespective of how
> userspace is setting the bits in the bitmap because it is finally doing
> the same thing. I'll make the change.

Yep.  So on the kernel side, bitmap_array_size is a *byte* count,
and user space and the kernel side are in agreement. ;-)

>=20
>=20
> >>                   return -EFAULT;
> >>           }
> >>
> >> @@ -1221,11 +1224,7 @@ static int mshv_vtl_hvcall_do_setup(struct mshv=
_vtl_hvcall_fd *fd,
> >>
> >>    static bool mshv_vtl_hvcall_is_allowed(struct mshv_vtl_hvcall_fd *f=
d, u16 call_code)
> >>    {
> >> -       u8 bits_per_item =3D 8 * sizeof(fd->allow_bitmap[0]);
> >> -       u16 item_index =3D call_code / bits_per_item;
> >> -       u64 mask =3D 1ULL << (call_code % bits_per_item);
> >> -
> >> -       return fd->allow_bitmap[item_index] & mask;
> >> +       return test_bit(call_code, (unsigned long *)fd->allow_bitmap);
> >>    }
> >
> > Yes, the rest of this looks good.
> >
> > Michael
>=20
> For CPU hotplug, I checked internally and we do not support hotplug in
> VTL2 for OpenHCL. Hotplugging vCPUs in VTL0 is transparent to VTL2 and
> these CPUs remain online in VTL2. VTL2 also won't be hotplugging CPUs
> when VTL0 is running.

Good to know.

>=20
> I am planning to put a comment mentioning this in the two places where
> we check for cpu_online() in the driver. Preventing hotplug from
> happening through hotplug notifiers is a bit overkill for me, as of now,
> but if you feel that should be done, I will work on it.

I'm marginally OK with just a comment because VTL2 code is not
running general-purpose workloads.

>=20
> Since good enough changes are done in this version, I will send the next
> version soon, unless there are follow-up comments here which needs
> something to change. We can then have a fresh look at it and work
> together to enhance it.

Sounds good.

Michael

