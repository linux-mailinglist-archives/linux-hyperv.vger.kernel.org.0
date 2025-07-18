Return-Path: <linux-hyperv+bounces-6295-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89FB0A6D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 17:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234C23AB717
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7121CC55;
	Fri, 18 Jul 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g/ezC0Ep"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2087.outbound.protection.outlook.com [40.92.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DD18024;
	Fri, 18 Jul 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851239; cv=fail; b=D+NtKZbxfSYtNpvahldPtHLl/NROC0GFHXfbl0+4hqO1EFvMduB7kFqDuBTtcdrOBEJvQQlqcK6KlzHto6cBVfXQHFltTSCLTagp/8s2xVyBbTRxXiUfIHtP1RU2/VwHhrM/ta5VJIWoZvkVyNRYdRhp72WlaFRIsM1yL5GNIrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851239; c=relaxed/simple;
	bh=uJaiBQz4+RFaC3iRAVVtN1aK9otCbVANr6mkpnKildc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UuqW+yQeYEvH2mdaOay2hmmBJAd+ZaLbpL8V76Mak1zNKXATORdwACC1IidsPpkrC5yeCbJVvo6i14/OEnT0oJOKqtEW6GhE5yaQOjr3CMeL7GeAsvQrT/oOuFdwE6YYZP6M1Ra72Wl/FLQ9wIc7sLGNNDkVO9UUxMq4mGjjXl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g/ezC0Ep; arc=fail smtp.client-ip=40.92.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt7RR4sTJ855wQxUQKdNp0xkSNmGTTs3d33OllATDwGwxG8OzULii2xGx0qRPx4J9Hasf7C5Mvu1pFLBywSlUGwnfaFhHLl7LgYiVeQvTb9cfF/IFKXkGDoDIboqQFH/l5d0n69ypFW77nokk7RSMvThTU6f0FehifujBOwDSfCiGNWei1Biag4etZPDk2E8zEodI8MX1iwaLT7Qn3yYnJhSFR8utzav0Tdb+eYe6Vi3ya7XzAULX/gzSIweisJ2gvo/yPWo+Hc5ENu0q22Z3Rr2MPGkxEGBk9BSZlrQzowyBRpdPvr4Fg5mjC4cvU0eM34yqYVt5s7E8Jh7UYrSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTZqbPLp9OUr9p4JqpjJj/z+L54e0sDylhuO1lgdok0=;
 b=fyh4iEpgWYB8BeMfgWSom1Vw8pXVZFtkHLIeLcmoKkSkPEzN3Yp4NpOlf0LheLTw35SA80ZlLfSStPd1mYs8q2uTxCUIP89xVyGRxZXGWREfTwTgFHThTnROpj2Exw+rd1NEBFhNeu9qx8Qgu0xDVS7lhgC/vyvKRvEQZkSidHO4qrt9QAIXkmSbUb08sQwl4x1qKBIJIQN1PJJhnA5AeSI5F9KbRJar+CD6mD74YK4imOgbZFBxRdXxDlCRwsIKyMWU/cIdAVJ/K/1ucYWhWwR/BdhZh4gwuKdZK8cLMuxpeummDAB8uVUPb8+DVmGdmw/pKrHiv2aXX1UjhvPfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTZqbPLp9OUr9p4JqpjJj/z+L54e0sDylhuO1lgdok0=;
 b=g/ezC0Ep34gGIiddOC6vmSOBIxupQ2QkQLMPrWqhFVXBovqhqIyNEHhLY9q8ozE+pzfsHJI1yxgNapdCxHqoG3wRZ91fXwIPW0TBwStgcFaZYDRjzLOI/W9xVBN3CKO2naC9Xof/1RjhVtf1vmgvl2aKSUZsGK6+B9lH8vlDhYD9PLlyJkve3rKi/cjm5/wI191w4XqQlbrtDoPmSEMw1yeYuXJm9ooxDZhKFSPGfTz5Qmk+PaKzecw1hkMLpPK06f9QgxLm7RuR9sQIdQwsunX4UA7YUiEpX/l/Ikorb94+UH1ZD0O1f4TZxJLL3CgMHiqqtuxg4Ass54yko6CEww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10696.namprd02.prod.outlook.com (2603:10b6:806:440::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 15:07:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Fri, 18 Jul 2025
 15:07:14 +0000
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
Thread-Index: AQHb2qJWl9MJjouTb0Sl2AaDU/QSG7QN8ajQgCmUHYCAAJ0FQA==
Date: Fri, 18 Jul 2025 15:07:14 +0000
Message-ID:
 <SN6PR02MB415781ABC3D523B719BDE280D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250611072704.83199-1-namjain@linux.microsoft.com>
 <20250611072704.83199-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157F9F1F8493C74C9FCC6E4D449A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <42bc5294-219f-4c26-ad05-740f6190aff3@linux.microsoft.com>
In-Reply-To: <42bc5294-219f-4c26-ad05-740f6190aff3@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10696:EE_
x-ms-office365-filtering-correlation-id: 13252607-43b5-4089-5335-08ddc60cc76b
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|40105399003|3412199025|440099028|51005399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?81uEz8ceRsiRrR36g8dwl0m0CDNLJrrg8/ueyqcE3GTeBXkKzwwGk5LczIeN?=
 =?us-ascii?Q?Rm4nz2FqnkU8v8gul5v1crN99cOLB0WvHBJ49gudJH2C6NgdaxwpkoAK+avX?=
 =?us-ascii?Q?sG02/oJtz+t2vgh258aBkjr02xc7g6IyVV2Xpw0A/SiyuuzKxzuMuv/x0w4m?=
 =?us-ascii?Q?N8JV5IR41tK73FylX4VF5ZX89fqt39JNEhON0Q5LaLEzj3T1MCgr/xpvs3S3?=
 =?us-ascii?Q?hB6U7NT9ckxomtIn2QEsJpDvD6gaEw0eV2x0JVowbP+TMhMxndgFtNUdkt/b?=
 =?us-ascii?Q?x6K1fj+QJUdSUG+AWXUalPA0a3vvXYMG6jq2FI5EeRq351YSoBQjfgeC76Ie?=
 =?us-ascii?Q?BFySjNWSlfkGJkwuIR+CSap8hcxM3UwuNrguaUk/zIgTt1ZWj1gnQqnvhN8l?=
 =?us-ascii?Q?EYsLQBaS05Zltol7NBqjYD2OCHORCaS9xa0JENxINFbpW5l29zUxiQwDXE0l?=
 =?us-ascii?Q?3tJT1+JLJQX87YMiu8IbJKiJeby0QDAjxiG66yDFqKXoXVml1nwm1RVKTtBC?=
 =?us-ascii?Q?kRrjvGgCFFtOXBSBsusYYXoOv3PIu/VdfjmtkAkTrwUjNIc4XrKQdRd57D5Y?=
 =?us-ascii?Q?4XLnKzWTP35fn/GaxsQY87V8q0EgGPeN5A+kKjM3ycm+AV+pFdLOb10chmMC?=
 =?us-ascii?Q?P1O6QuCbfKcdMmNAz+jnZWjNRt/FisAGtEMZZW3PiyQoCmojKus5DTFkicXI?=
 =?us-ascii?Q?ulIEww+1vo0NSlRD8g8DKj3BcknEnPYmvOOi3XHNWgjEmDPbq228hnvNmiAO?=
 =?us-ascii?Q?v1XKessKENJcq8X6OT6fgtYE163Pzc1g+FNdQ2PFjGTjC2/Meacq3mrpWk1d?=
 =?us-ascii?Q?HqYXfU5fdYJkww086gS6ai0gYRW55mvyZhwkssmzqP76plkJuDwjNeNayYO2?=
 =?us-ascii?Q?PjH3N54rPjkX+ijgXdymCFnx/Grjt6NEnjGzcoACnyykCGlFdDBDvRvdAn32?=
 =?us-ascii?Q?P2TUEYOm/SS2p8iFTi7X9vleFNBt1i3V1XSjvotAhgHAeeFJoom+J2TRlwaY?=
 =?us-ascii?Q?YSG7r/ddGUt73Ket2VuO4jvZJYTpPfDPQInEpJFCdvePrO7RoLcS09DMPZ0l?=
 =?us-ascii?Q?06lhf0W3lsW0tf9L8+jcNyxl5pArRw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wltv6i1oVkTFQYTeSrd7TCGwkg3L4mfRyyDC9pUT269NkJoLiUT2u0RsCq84?=
 =?us-ascii?Q?ZtsIsRPiv6wGCtFJd01i/VgEzwr1YATdDmwBt6GGMKxU46LmIB3BINBBgzQA?=
 =?us-ascii?Q?GuQz4pliOs1JzZ6X67bbBIxDNHWCqMn+UbYg1dDKMnwq0dzTlG4u1/mQgMwN?=
 =?us-ascii?Q?yf4qVtCruT0itGbW/sOEShVB/bTvELhAkbaY8sMtW09ECcP6ceBjsdivSQUn?=
 =?us-ascii?Q?C7qjcJNClY5aTdA2g8hXVu8Kd8y5c6wBov2ZIo4GH7anidSoKUCq1RYJwTuI?=
 =?us-ascii?Q?l5YdVvTkSe+gfNnCoJ2oCs9pVcIzZ+Oa3PBnhj/sQyBcv8AkWPc+RnzCCFUR?=
 =?us-ascii?Q?XEUlQqLFmg/GjGnqZt+923FwGQgO6f2muTtL8UQ/DdugIDONgNYIJ4PghVmV?=
 =?us-ascii?Q?fvi20W5peO3UoOn/DCX85evUGKOsxD8kvWC2TDI9rocH/ZK22Q6x8kd2mtel?=
 =?us-ascii?Q?ObeGlsRSEhwVyHqSgQDIH8KPiIGFKnc6t4A+aw41P9gFU/e+X4K7hLPlNHxI?=
 =?us-ascii?Q?ST7fNGkwtu2UkFG/pbnQdUaSbQxpvEmSVEJ9Xtr1dCv7BEGzrcmvUYAF/OAL?=
 =?us-ascii?Q?Jjb04pmQ3/exkYvzOPDoCkbliamHjxF4smRJZnHP8kb7kYG6g+jkmi/plo5n?=
 =?us-ascii?Q?rIqJ6qTTCfNSCP/DROZJVhJaj8Z6ZmtWplpA8WSTYhmZO/LjGrcTXn+yOaVZ?=
 =?us-ascii?Q?Idc0r39QkbcrV8YsGPN4o9KSxUcLJa24lCgxboGaXkDyNzmCE41y/BZzHTsS?=
 =?us-ascii?Q?c56xflp/HIpJsAtikzNYq7zVy8TXHxWZxAWbpg03iHeLXbIH0rhBsQRXC5at?=
 =?us-ascii?Q?gVeTFZSiSXU1XnByqO+P5yAomI8z+MBirIMV7TTBgikcxsgZtqTTfW7yWXyX?=
 =?us-ascii?Q?PzePN5OjRUyYTDh3FNRHsbtwG1av+Ah00UjoTLxhtzhLyUlFSqaZCswueZOj?=
 =?us-ascii?Q?PFOcYp8093S5imNtmyL2l/QPHH1CrrAzv7pOqFIZmDrD5OcndPRXIZgHQlfM?=
 =?us-ascii?Q?s4iFpm+ZUfZbMTbI1D08MVO1MZH+ih6AhIX+oo8g1mp5n/6ulpyxWh3qsD0Q?=
 =?us-ascii?Q?ffhZk8XTvWnEKpX1nl/VnT+qkG+t/tv1I0Ff0sDHk130SWXmoTD+v5EsnQlB?=
 =?us-ascii?Q?sVhBzyA6BY1ViU2x0YI5dydUIbpsYtVPzGhXp92tNDVXdrj55R8IrzpYZ3Zz?=
 =?us-ascii?Q?l7xpXwb7V1moj/LfGktQBnfoAZsnaZy+O2GJqRTa0nkHFkrFMk+gp9rWV4s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13252607-43b5-4089-5335-08ddc60cc76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 15:07:14.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10696

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 17, 202=
5 9:36 PM
>=20
> On 7/9/2025 10:49 PM, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, June 11=
, 2025 12:27 AM

[snip]

>=20
> > Separately, "allow_bitmap" size is 64K bytes, or 512K bits. Is that the
> > correct size?  From looking at mshv_vtl_hvcall_is_allowed(), I think th=
is
> > bitmap is indexed by the HV call code, which is a 16 bit value. So you
> > only need 64K bits, and the size is too big by a factor of 8. In any ca=
se,
> > it seems like the size should not be expressed in terms of PAGE_SIZE.
>=20
> There are HVcall codes which are of type u16. So max(HVcall code) =3D
> 0xffff.
>=20
> For every HVcall that needs to be allowed, we are saving HVcall code
> info in a bitmap in below fashion:
> if x =3D HVCall code and bitmap is an array of u64, of size
> ((0xffff/64=3D1023) + 1)
>=20
> bitmap[x / 64] =3D (u64)1 << (x%64);
>=20
> Later on in mshv_vtl_hvcall_is_allowed(), we calculate the array index
> by dividing it by 64, and then see if call_code/64 bit is set.

I didn't add comments in mshv_vtl_hvcall_is_allowed(), but that code
can be simplified by recognizing that the Linux kernel bitmap utilities
can operate on bitmaps that are much larger than just 64 bits. Let's
assume that the allow_bitmap field in struct mshv_vtl_hvcall_fds has
64K bits, regardless of whether it is declared as an array of u64,=20
an array of u16, or an array of u8. Then mshv_vtl_hvcall_is_allowed()
can be implemented as a single line:

	return test_bit(call_code, fd->allow_bitmap);

There's no need to figure out which array element contains the bit,
or to construct a mask to select that particular bit in the array element.
And since call_code is a u16, test_bit won't access outside the allocated
64K bits.

>=20
> Coming to size of allow_bitmap[], it is independent of PAGE_SIZE, and
> can be safely initialized to 1024 (reducing by a factor of 8).
> bitmap_size's maximum value is going to be 1024 in current
> implementation, picking u64 was not mandatory, u16 will also work. Also,
> item_index is also u16, so I should make bitmap_size as u16.

The key question for me is whether bitmap_size describes the number
of bits in allow_bitmap, or whether it describes the number of array
elements in the declared allow_bitmap array. It's more typical to
describe a bitmap size as the number of bits. Then the value is
independent of the array element size, as the array element size
usually doesn't really matter anyway if using the Linux kernel's
bitmap utilities. The array element size only matters in allocating
the correct amount of space is for whatever number of bits are
needed in the bitmap.

[snip]

> >> +
> >> +	event_flags =3D (union hv_synic_event_flags *)per_cpu->synic_event_p=
age +
> >> +			VTL2_VMBUS_SINT_INDEX;
> >> +	for (i =3D 0; i < HV_EVENT_FLAGS_LONG_COUNT; i++) {
> >> +		if (READ_ONCE(event_flags->flags[i])) {
> >> +			word =3D xchg(&event_flags->flags[i], 0);
> >> +			for_each_set_bit(j, &word, BITS_PER_LONG) {
> >
> > Is there a reason for the complexity in finding and resetting bits that=
 are
> > set in the sync_event_page?  See the code in vmbus_chan_sched() that I
> > think is doing the same thing, but with simpler code.
>=20
> I am sorry, but I am not sure how this can be written similar to
> vmbus_chan_sched(). We don't have eventfd signaling mechanism there.
> Can you please share some more info/code snippet of what you were
> suggesting?

See below.

>=20
>=20
> >
> >> +				rcu_read_lock();
> >> +				eventfd =3D READ_ONCE(flag_eventfds[i * BITS_PER_LONG + j]);
> >> +				if (eventfd)
> >> +					eventfd_signal(eventfd);
> >> +				rcu_read_unlock();
> >> +			}
> >> +		}
> >> +	}

Here's what I would suggest. As with the hvcall allow_bitmap, this uses
the Linux kernel bitmap utilities' ability to operate on large bitmaps, ins=
tead
of going through each ulong in the array, and then going through each bit
in the ulong.

event_flags =3D (union hv_synic_event_flags *)per_cpu->synic_event_page + V=
TL2_VMBUS_SINT_INDEX;

for_each_set_bit(i, event_flags->flags, HV_EVENT_FLAGS_COUNT) {
	if (!sync_test_and_clear_bit(i, event_flags->flags))
		continue;
	rcu_read_lock();
	eventfd =3D READ_ONCE(flag_eventfds[i]);
	if (eventfd)
		eventfd_signal(eventfd);
	rcu_read_unlock();
}

I haven't even compile tested the above, but hopefully you get the
idea and can fix any stupid mistakes. Note that HV_EVENT_FLAGS_COUNT
is a bit count, not a count of ulong's. And with the above code, you don't
need to add a definition of HV_EVENT_FLAGS_LONG_COUNT.

[snip]

> >> +	pgmap =3D kzalloc(sizeof(*pgmap), GFP_KERNEL);
> >> +	if (!pgmap)
> >> +		return -ENOMEM;
> >> +
> >> +	pgmap->ranges[0].start =3D PFN_PHYS(vtl0_mem.start_pfn);
> >> +	pgmap->ranges[0].end =3D PFN_PHYS(vtl0_mem.last_pfn) - 1;
> >
> > Perhaps this should be
> >
> > 	pgmap->ranges[0].end =3D PFN_PHYS(vtl0_mem.last_pfn + 1) - 1
> >
> > otherwise the last page won't be included in the range. Or is excluding=
 the
> > last page intentional?
>=20
> Excluding the last page is intentional. Hence there is a check for this
> as well:
> if (vtl0_mem.last_pfn <=3D vtl0_mem.start_pfn) {
>=20

OK, this test requires that at least 2 PFNs be provided, because the
last one will be excluded.

I'd suggest adding a comment that the last page is intentionally
excluded, and why it is excluded. Somebody in future looking at this
code will appreciate the explanation. :-)

[snip]

> >
> >> +
> >> +	if (!cpu_online(input.cpu))
> >> +		return -EINVAL;
> >
> > Having tested that the target CPU is online, does anything ensure that =
the
> > CPU stays online during the completion of this function? Usually the
> > cpus_read_lock() needs to be held to ensure that an online CPU stays
> > online for the duration of an operation.
>=20
> Added cpus_read_lock() block around per_cpu_ptr operation. In general,
> CPUs are never hotplugged in kernel from our Usecase POV. I have omitted
> adding these locks at other places for now. Please let me know your
> thoughts on this, in case you feel we need to have it.
>=20

My understanding of VTL2 behavior is limited, so let me ask some clarifying
questions. If a vCPU is running in VTL0, then presumably that vCPU is also
running in VTL2. If that vCPU is then taken offline in VTL0, does it stay
online in VTL2? And then if the vCPU is brought back online in VTL0,
nothing changes in VTL2, correct?

If that is the correct understanding, and vCPUs never go offline in VTL2,
it would be more robust to enforce that. For example, in hv_vtl_setup_synic=
()
where cpuhp_setup_state() is called, the teardown argument is currently
NULL. You could provide a teardown function that just returns an error.
Then any attempts to take a vCPU offline in VTL2 would fail, and the vCPU
would stay online. However, some additional logic might be needed to
ensure that normal shutdown and the panic case work correctly -- I'm not
sure what VTL2 needs to do for these scenarios.

All that said, if you can be sure that vCPUs don't go offline in VTL2,
I would be OK with not adding the cpus_read_lock(). Perhaps a comment
would be helpful in the places where you are not using cpus_read_lock()
for this reason, assuming there is a reasonable number of such places.

[snip]

> >> +
> >> +struct mshv_vtl_hvcall_setup {
> >> +	__u64 bitmap_size;
> >
> > What are the units of "bitmap_size"?  Bits? Bytes? u64?
>=20
> It would be length of bitmap array.

To me "length of bitmap array" is still ambiguous. Is it the
number of elements in the declared array field? Per my
earlier comments, I think the number of bits in the bitmap
would be more typical.

>=20
> >
> >> +	__u64 allow_bitmap_ptr; /* pointer to __u64 */
> >> +};

Michael

