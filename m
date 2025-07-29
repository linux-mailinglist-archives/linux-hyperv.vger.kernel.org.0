Return-Path: <linux-hyperv+bounces-6439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA95B153CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 21:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCAA7B03E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F40256C8A;
	Tue, 29 Jul 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f1xoCS3D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011071.outbound.protection.outlook.com [52.103.23.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEA262BE;
	Tue, 29 Jul 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818320; cv=fail; b=GDK3Ad2Ee17Fq1GFCIv7D9wV//bTqlhaUm2QIst6RoObb9d++OLk3SI800JgrECh5ph6EdeLIphbKRHlez3IQ6jIOpSMaR+KVZahb1p+e6SsJO06Xc/yCM48tgJZdkXh7Bx0XyobJnW9mOV/ee5NIzrFB5TNgQXoapoF35oQQ8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818320; c=relaxed/simple;
	bh=5NyBDbcFydUtI+oiR6moVNVjIG7FH4EXWHBEt9R8VVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P1dKNPV9rjHT0jPUgawJzhXWGxPGryWkUMFRjvXIbvyzl6jO9/Xyl9Hq5TbFJ8sdx4Bm4MS27bRUc2EIPDBX0ivTz3PQbOv9g3sVA/stEUSRsum0p2vA6hTRKKWtFAD0q6tK0mbZPe2T6wefd98PUvTlBaN8Eesf8+/EnDJ0wqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f1xoCS3D; arc=fail smtp.client-ip=52.103.23.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaQagPl7sjeqkfKKvT45U+ia10j0RVCbgQCFx/5BU1MApfi9VVVJL3Vr8emN0ns0k7hrdlF+qsV/w6yt4sCL7gHw4OwYkpoOaFkJFDLxMkmm99htkxz+j0iodHF68tL2zH1x/zieomRhNIhg4u54n7HdzxpKv2tKxK5C3/e/zGm5+4aTAFZFAEXg4qAu2wLWkpArQ8z0cUsPSS7BueBg+mBdlqSwfNB+UrXcg+GSBsJloDrzoGnICO9fx5PjUy7LetbqS4dtMZX5AUPDGkHzjE1IEiF0qyCF+1DpZMLsQqgr1Lq2u3GErRR7ZwgsIBSvLalPZM3Zjm+qN4hJdAkcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VspVSlBj5Ak6SDzoCzDmBrpduHnZxyKFtm1Yv1AvY34=;
 b=Bduj7QuBJ/5h2QLQC1AloJTI5gy5l6rB7B2trN5zURYWJXtJqHA5kq7B2muVtIX3IG28deJ7/enAWucSeGWyXRij45Y2C4i+p9y5KPZ1QeT0TN4mY+v3wLddDqHV4hzdPOc0rJ+pqJczBg+MuHhtmVWVg5a3PxKtSVDWbbLu3YyHvkYyCikFHcC+kO9P4z/Bh1QmKAR4w+sGHS+9uHKvUUmLtxrJhmNwBjYUPwRClnC6XAuFKQmy8DV0O/8kffrdHVTv3viptVTpByS84EYQSUvvBqSXHyRIdn+odElp4mCvD9msJ9qmcRpFqlMZAUVR9CfXpp6ArpS/XdPljQxMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VspVSlBj5Ak6SDzoCzDmBrpduHnZxyKFtm1Yv1AvY34=;
 b=f1xoCS3DIrG+ZCMJuaeZV3c3PHJgVWzT3LeJdlImdey4oL+vCC+GAOHpYaAf+xpiauTrJwbBqpF3jeeM6TETNTFOUbe6b2qTJQM2grGxs6o5R5DWXUxfNZHtQs1/COBvEuPqTCm7RyclgBZrx5evvbacHh+QFKGPXOSMPxpjN3F+0uxt89oznp99IvVO++X0bD5xLveGE2YRUBh3lEArtW1Ti1gSW5Hscy2/H2fbueVKeqJa6CPglZmaEyfygYzbRGy5sTNSA1sZyZQlvDgqyNZPgpGzkKKxoFHdGvqy+pBqDPt+WeNWP1zCZE0OoH+nOk6HB7r0bdctZmEpsGRTRQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8092.namprd02.prod.outlook.com (2603:10b6:610:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 19:45:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 19:45:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
CC: Naman Jain <namjain@linux.microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Long Li <longli@microsoft.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
Thread-Topic: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
Thread-Index: AQHb+5+3htBXBucy0kuMwXQVrrilg7RJdcBAgAAFVICAAAwJkA==
Date: Tue, 29 Jul 2025 19:45:16 +0000
Message-ID:
 <SN6PR02MB415792B00B021D4DB76A6014D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250723070200.2775-1-namjain@linux.microsoft.com>
 <SN6PR02MB41579080792040E166B5EB69D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e1d394bd-93a6-4d8f-b7f9-fc01449df98a@t-8ch.de>
In-Reply-To: <e1d394bd-93a6-4d8f-b7f9-fc01449df98a@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8092:EE_
x-ms-office365-filtering-correlation-id: 7ae7dcb4-42d8-4208-0693-08ddced87110
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|15080799012|19110799012|41001999006|461199028|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WdM2hwCJEYqNjgg1oQ+rj/QcPT00YH0X/Jg7HNVNbdPnf2ZP/KrIrLoTjh?=
 =?iso-8859-1?Q?6xFldssrdmN3VcFigyfJXqUZfIGRrNJR7vPBZKUYjz+njQdCv5rfb1LUnW?=
 =?iso-8859-1?Q?moPe8hAx/zR7AyNnuSZL2LIaJn6JocOcSIWw9bzJWLtp1b1aS18yg0/fSp?=
 =?iso-8859-1?Q?4JBXnhs+1OxpBVIiSjb2RoEcXHX/m2NXScJKlPc+kcXI+rE2Ri8BLBU9DO?=
 =?iso-8859-1?Q?2MEoAoGxrkMTJmvkEjAMFn8PjONxENsvWyjn0OgtpDZF5RLZ/wz7RAIyIH?=
 =?iso-8859-1?Q?TX4yLsy8NR+fy9+RiE5SiAjM1QRavG7VNIrww8/i1FVULiIuLi0f+YRLIl?=
 =?iso-8859-1?Q?FUIq9lTBlcUvS34Utt+3GHoKhy6WlrqWTBfqZPP6tE8W6EV3b7RZjPwNCZ?=
 =?iso-8859-1?Q?GqLkeGhW5UktBl7VqLjWWNqowHBB0vYO29l5IW+2o/QRovcykbWYMoag9W?=
 =?iso-8859-1?Q?qQOSinsHs5tIEBVKflmSPxqT1MyKtrxrLJhVRAG4mDFFiCZiSTMGGeKUVr?=
 =?iso-8859-1?Q?jVa586HeYjiTBGgKDkdH+k7dViaDPW4GbNLNcIy8mfeQ78R5hPIrJeiIuP?=
 =?iso-8859-1?Q?8Our4cD9a2SJPleFrT8uSRGMisen4yABjI5BDbk9Y1bwVq1oktVsmh51Z1?=
 =?iso-8859-1?Q?FRx9qdtGYfL6972sbMDZ03xHVzslCKVofZE+RpzOai+L4pULBSN6QsHJLH?=
 =?iso-8859-1?Q?HkXxG9LkBB4TSCbn9BpzpB+/DMC9p8853wVvvxjACUaa/6HEbVoVU8BeWp?=
 =?iso-8859-1?Q?qp3hbrRkajRdkNnPe85F87VrZGMdXILk2RH+NispFTvcAvzQTkBgJZwq40?=
 =?iso-8859-1?Q?cXVIzVA1RSJ4zgtqDDJvPmVcEYaY4RQQdDjmWLfu6y0J62vDf7eWcs5Mn8?=
 =?iso-8859-1?Q?Hnekwit/iwp/ZeLO86/esPgdYjifWZUOuT+1dVH96oldmpIC+AX8Kkr3zk?=
 =?iso-8859-1?Q?fgU84GfiI9COe9ICqrHLZl7Venuv03zvx4jmGMa356SE7a4rc2PgK4TfvJ?=
 =?iso-8859-1?Q?yFkSc78cMebSfFdLLfSKe3FrP6o3HKByssZqV4MQcwy5Yeq+DhMJK4u/rU?=
 =?iso-8859-1?Q?lQsbd+2EL7ee6Zk+s2U7AfkHkCDNesXDBiIw+/g+HwHAn+s7ah6Gniq1yl?=
 =?iso-8859-1?Q?YWN0cmE0VfFkD7/klKbBVhICw0uz/EtmEYtvoLcmL6j4zM6SDLT1YqPItE?=
 =?iso-8859-1?Q?oNqkYXhgEp1lpw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q1n7iczpl+w23PIr48jf8AzcPRC86iTpWKfoLaE3sRXzT0i3nN1ZUFV4EG?=
 =?iso-8859-1?Q?izeZwhlbL5fExNbNVe02qht0Ev79Ip0KeV5UJvcF1zea87Z/2sPGJnQ5Av?=
 =?iso-8859-1?Q?X6vZJ1e38A3iPLbHBoxHCJTLwkIymKHKPizXK7Hrq28mRbx6SBFQOOzW/L?=
 =?iso-8859-1?Q?0cX7ptzVlntClBpMITGzaDEBWzMutj+HO8xEJhYBNH5IbfS9Mjc9WJ0vaf?=
 =?iso-8859-1?Q?VB3/cbEZBrpOJ8ED17+beQTjcyQWLJ3hDPbve02JT9qczJwPakqf18uU5B?=
 =?iso-8859-1?Q?aKJVL4ucOuXxCQTzyvR4tpkz9EURzA6T5CwgQindhEHXikwjcdMW3wPWq6?=
 =?iso-8859-1?Q?howoqQ5kL2hgWlLWv4mmaehglr+THCZONJ2nZQvTtjJGkpqChPOMH4ykF8?=
 =?iso-8859-1?Q?SxYsWmQY7HS6webmpT1gn74f/f1wcJKO2A+/o/YQnRG9zyqXTml43WjGZq?=
 =?iso-8859-1?Q?TvqnqM2dPeT8DZzUqP40Uy3SAfkDI/5TKyOj6rV8eRC7v+75cdooTtFLUW?=
 =?iso-8859-1?Q?RAaN9OrkbFUCdC5pmyQkxQtS0BvCPmPX1vf1SMpLgaNRx1lNdJ44b/aCHD?=
 =?iso-8859-1?Q?bj0Jn/FJ8+WsdcLtx5b+1JHHNTiwsTjnIYkxxNmxxaSGm/8BdrgdKHWKPz?=
 =?iso-8859-1?Q?QRYHTuJGmRW8/Ct2bPEz0pefmami2WUsrpMbzpEtS4a/emV2UdW+G7hlQG?=
 =?iso-8859-1?Q?6qdPSBDPq4m8c5deNIKTB23EjegSABHBHWcxT8VRjDbfP0hZTkL3hrX3c1?=
 =?iso-8859-1?Q?/a/bMTiTLJjfsbkd55P0hk5xVzRJpVDEB7ikzVOI8WnASbL0l5ixUh7rWE?=
 =?iso-8859-1?Q?15s4BYziUhmOUTBFIdDE0cO9BVixQp1GvHtZZxc9w30xb8scMtMl+J8Wqd?=
 =?iso-8859-1?Q?9Yb9DaL2YAW0tnyAgBkJESHCYl8vmRX3n90KKsYw1bZ+6TqEEKmh6FfbJv?=
 =?iso-8859-1?Q?aufO4NeRWNU/cmW/6Vo1SFEFvXDvQPmGUcw1jAKACx9qq+csSb8lFnr2Xz?=
 =?iso-8859-1?Q?WNffv1KyWILVQb8X1jMC0I5sbGD5TLQwW06O1nf2JF24OR6TPgxxkDCPVi?=
 =?iso-8859-1?Q?JCE16E02zc6YTsQV4iFwWHDeULw2RYP/4astQKnNXPq2WqC4VhsaPrpKFd?=
 =?iso-8859-1?Q?wqOR/R4Z8Dhn11kYPaFf2tCqgHO4a8oh2nj/ZO1Ev8+ioBX/WqMJ47TD2C?=
 =?iso-8859-1?Q?zv/EHaamPnGaTs2i0QN7izqtg+xBmdOYicwK4GbS+nslwbrVGTPCXMorKi?=
 =?iso-8859-1?Q?OX9BWF3Pf/0hFZiArDHQG2bQi+4PlOJzEDuJ2R6tA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae7dcb4-42d8-4208-0693-08ddced87110
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 19:45:16.1086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8092

From: Thomas Wei=DFschuh <linux@weissschuh.net> Sent: Tuesday, July 29, 202=
5 11:47 AM
>=20
> On 2025-07-29 18:39:45+0000, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, July 23=
, 2025 12:02 AM
> > >
> > > The ring buffer size varies across VMBus channels. The size of sysfs
> > > node for the ring buffer is currently hardcoded to 4 MB. Userspace
> > > clients either use fstat() or hardcode this size for doing mmap().
> > > To address this, make the sysfs node size dynamic to reflect the
> > > actual ring buffer size for each channel. This will ensure that
> > > fstat() on ring sysfs node always returns the correct size of
> > > ring buffer.
> > >
> > > This is a backport of the upstream commit
> > > 65995e97a1ca ("Drivers: hv: Make the sysfs node size for the ring buf=
fer dynamic")
> > > with modifications, as the original patch has missing dependencies on
> > > kernel v6.12.x. The structure "struct attribute_group" does not have
> > > bin_size field in v6.12.x kernel so the logic of configuring size of
> > > sysfs node for ring buffer has been moved to
> > > vmbus_chan_bin_attr_is_visible().
> > >
> > > Original change was not a fix, but it needs to be backported to fix s=
ize
> > > related discrepancy caused by the commit mentioned in Fixes tag.
> > >
> > > Fixes: bf1299797c3c ("uio_hv_generic: Align ring size to system page"=
)
> > > Cc: <stable@vger.kernel.org> # 6.12.x
> > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > ---
> > >
> > > This change won't apply on older kernels currently due to missing
> > > dependencies. I will take care of them after this goes in.
> > >
> > > I did not retain any Reviewed-by or Tested-by tags, since the code ha=
s
> > > changed completely, while the functionality remains same.
> > > Requesting Michael, Dexuan, Wei to please review again.
> > >
> > > ---
> > >  drivers/hv/vmbus_drv.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 1f519e925f06..616e63fb2f15 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -1810,7 +1810,6 @@ static struct bin_attribute chan_attr_ring_buff=
er =3D {
> > >  		.name =3D "ring",
> > >  		.mode =3D 0600,
> > >  	},
> > > -	.size =3D 2 * SZ_2M,
> > >  	.mmap =3D hv_mmap_ring_buffer_wrapper,
> > >  };
> > >  static struct attribute *vmbus_chan_attrs[] =3D {
> > > @@ -1866,6 +1865,7 @@ static umode_t vmbus_chan_bin_attr_is_visible(s=
truct kobject *kobj,
> > >  	/* Hide ring attribute if channel's ring_sysfs_visible is set to fa=
lse */
> > >  	if (attr =3D=3D  &chan_attr_ring_buffer && !channel->ring_sysfs_vis=
ible)
> > >  		return 0;
> > > +	attr->size =3D channel->ringbuffer_pagecount << PAGE_SHIFT;
> >
> > Suppose a VM has two devices using UIO, such as DPDK network device wit=
h
> > a 2MiB ring buffer, and an fcopy device with a 16KiB ring buffer. Both =
devices
> > will be referencing the same static instance of chan_attr_ring_buffer, =
and the
> > .size field it contains. The above statement will change that .size fie=
ld
> > between 2MiB and 16KiB as the /sys entries are initially populated, and=
 as
> > the visibility is changed if the devices are removed and re-instantiate=
d (which
> > is much more likely for fcopy than for netvsc). That changing of the .s=
ize
> > value will probably work most of the time, but it's racy if two devices=
 with
> > different ring buffer sizes get instantiated or re-instantiated at the =
same time.
>=20
> IIRC it works out in practice. While the global attribute instance is ind=
eed
> modified back-and-forth the size from it will be *copied* into kernfs
> after each recalculation. So each attribute should get its own correct si=
ze.

The race I see is in fs/sysfs/group.c in the create_files() function. It ca=
lls the
is_bin_visible() function, which this patch uses to set the .size field of =
the static
attribute. Then creates_files() calls sysfs_add_bin_file_mode_ns(), which r=
eads
the .size field and uses it to create the sysfs entry. But if create_files(=
) is called
in parallel on two different kobjs of the same type, but with different val=
ues
for the .size field, the second create_files() could overwrite the static .=
size
field after the first create_files() has set it, but before it has used it.=
 I don't
see any global lock that would prevent such, though maybe I'm missing
something.

>=20
> > Unfortunately, I don't see a fix, short of backporting support for the
> > .bin_size function, as this is exactly the problem that function solves=
.
>=20
> It should work out in practice. (I introduced the .bin_size function)

The race I describe is unlikely, particularly if attribute groups are creat=
ed
once and then not disturbed. But note that the Hyper-V fcopy group can
get updated in a running VM via update_sysfs_group(), which also calls
create_files(). Such an update might marginally increase the potential for
the race and for getting the wrong size. Still, I agree it should work out
in practice.

Michael

>=20
> Thomas

