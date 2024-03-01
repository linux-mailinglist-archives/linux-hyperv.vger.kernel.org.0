Return-Path: <linux-hyperv+bounces-1636-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06E786E918
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1742876EE
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF63F8C7;
	Fri,  1 Mar 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e2uHwiS9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2091.outbound.protection.outlook.com [40.92.22.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BD3B289;
	Fri,  1 Mar 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319687; cv=fail; b=O8r3xlGIPqOx2RKdZoJjghiYK0rF+hQa65VqE3J6x8XGYRQD8qD2hnVnNQnDdDT+7nKn8V6wFDdibqA+K5EsKwju9/Yt0zmdnyozuYxdsKtxDBH8NMHImb2J/0fnxfiBDcYrITcZdo3Hjghno3foPJqXwC273QrnFlllxuBJBbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319687; c=relaxed/simple;
	bh=szgzdxaenommhi880KnJX54BhWQ/in16mT53b5BURN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/5NVNTM4pe4pxEA6to260KrWGBLS/iVyWnneaImR1zCvwoN4wYQa4PdUCRZ95DKNWYMHZnaIH+ek3a1qCuCVYYo2xcZhWtEGBnywSntIO/z2Cv1R9BqCfFINi01DlYi2NVR6cVcBSqhsUMRJ7wmTLsEfkMw/UxkIvGXnq7bBhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e2uHwiS9; arc=fail smtp.client-ip=40.92.22.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP8bjFSGFqHNOt3Lpc+C2vCABSaTLFrlrtq9lT690uFLuLkECYg/PT3CHDK//gAFqu4oIiKWHirHGV8R+4oNtfcdoAZB3f8Go9OfedKXa/TEKKJCs+ssgdAhqznE39fTAPnowXTmYMYxhU2r7wvhg8wAMk9LNh22IIKwenUpVJzNpMe5Rlk89OuDxG1WZlWmx8vIN3x2V04LlD0JmK0boJABXWpaFFflMxkpUQRKHajqVhHhjezSzGsDAGeX76hNbxkfBO9lePI8t9GAFLMNPZkvWunQQfgWKxgIhz1aBWikRL17jtGX3f7Ci5rvPzL+U1KKJMcgAx4mW2WZm9i6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDDroaFsOxjF/Ql1TU5s/Z/CTnO28YFIxdNmj/YhTKY=;
 b=QSAN45jdyb9Q5bZUlmWeXF2SejvULHHh5XHIlhBa/8IyATErqnSnVVrn45etZZPb674ZtWgSROCq8jf+z9DRTy1jcOU6xRhnTJVOK+R24pNZF0UYLtaR8EbfJOU/ipI+kyFZ1a6U3GtnTsbOVctG9lQOvoJZNe/j/cJVtMzgO/S0vkSmUbPfezDVV0CqGqPwVOq5CsdycfZKbI7dySfPws4eP0arAmO8QROa1uROTd5BwC5uLJ/35qIeO39AlbJUJDdA06QuzlcxU7xSABlHBL8MTn+kPT4OgadW7AvwY4DyEv6H0dV7PbtAHrpxSB8fjIyLDUljN15Ubo3ILe+1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDDroaFsOxjF/Ql1TU5s/Z/CTnO28YFIxdNmj/YhTKY=;
 b=e2uHwiS92qjQOIoLK8xhtPLG924uS5dpmgdNIvPtFl2/05jHz8Djj5noEAPjeYUcgPFKg0JOZcqIKcH7JXHj7/r0yiVw8Bu7gw7HENmQ8XC3ZF+bCph6q7HkDC4o4UjwDDZJONoC1zhLCsTev/+HUUJp/zhtqt+R8p5DFCe2pbnNkSjeTISnjdAdXCoy8EDmoba4XAGt105scWem2BpUUoP0tf26/FxrSo/fnlzoDtzPtKK75SM/osUjrEmpgTFF2SRDbE+f18dlYzss/9aB2dVwcvybPon5PjLUjcZhsL8W7sYfHLIryrmfwShvl9WOKtyiIP4wGrPP8jmC3ni5oA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8941.namprd02.prod.outlook.com (2603:10b6:930:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 19:01:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 19:01:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 4/4] uio_hv_generic: Don't free decrypted memory
Thread-Topic: [RFC RFT PATCH 4/4] uio_hv_generic: Don't free decrypted memory
Thread-Index: AQHaZTRZ+J40st6LSE20mDImXtxcVbEjRXAw
Date: Fri, 1 Mar 2024 19:01:22 +0000
Message-ID:
 <SN6PR02MB4157F9E6E2464B09A839F4F9D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
 <20240222021006.2279329-5-rick.p.edgecombe@intel.com>
In-Reply-To: <20240222021006.2279329-5-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [wlha+3nr38lm2PNtkKIMunnq7T2VKM2u]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8941:EE_
x-ms-office365-filtering-correlation-id: ef11614d-aa21-4f4f-f710-08dc3a21fcb8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0yDObYohAhYR3GFJdZuCAVo0KoEDBHU5mGr4OBNvRFprSWQ70xgnqBlDBMWup5Wbeh0EHtrsbOgclQkh//ocrlkiLlnO9d/qfKQmpSd+KuGuHyUV7nBMaKxgJU9msZYjECscoz24aD9PQhTkJM2xfeX1asgPsy6tMR5QxshBD7vX1FUGz4vEA64RBKPuHzPDrbcU6hbDVo81av8GElYD59+uZ2zPiDWVxqryokTbgNcJS97zkL/Yba20trIi7KUzG06lmDE8M75wy2FG41TTZqMf+MqzD4+opjXCAqXUv5pL6cSG/XCzBdJIrNP4DvU45z6rRl1hPD5TPGdol582GUYDfflnL6RiSzIa4NwkQy3NFOADjco5+1OKzKzKrqM8Ns+wde+YtagbPn7/A97ITuIVX3j+eGUS6sz5GHUph9QXFhRsrsU4j/ezRInFb5C311Ds7q1bf5mvOBsqW9lzSGsgGSNS831UT2gtmEH4+344FA42my96L1m3KdPAoVrQkPMS+jScK1A4t6DCIWcRQEAj4pR3ErgADsrbRqcfTosEPbQ5lLMWxm+nZOgBY+ay
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OAZfUWdLF3ift40dY69gsEGsx62a0NM/Pz5JhvxVrBZ3px61vWcQB/DI/kXa?=
 =?us-ascii?Q?z4daItyToR7S/bsiki95i0lcO1ycUn+2ivSJ1lnAiNzyeF1Uw/BcxN8KYFkg?=
 =?us-ascii?Q?zE8ktGee/jIWMdVO6lKK3TSeT0jHlZX+6m5x3E0JAbAG2UoLi+Z6Orxlpv7K?=
 =?us-ascii?Q?ncVX6J5nWvQWOwLMbQRzSZykEe/G8uMWUVg4SPw7bm/q3TXNQ/epzAmKWi5f?=
 =?us-ascii?Q?ZmycM2xupDjExWFWc0LTFlmV3rZsfIk3e3kBUN3ytLHpEjSDzk87qlVAIWro?=
 =?us-ascii?Q?gst2vreno9L6n9B558QiFIei4HXJIYfzScSENo71bbAbDeHfH+4thEp+3SDA?=
 =?us-ascii?Q?scG1OwY/v/EYCJtfhKPbJIgZQpumyGuhd9xP7yI2cyEsHmTFnOPgjzzqFEY5?=
 =?us-ascii?Q?29sMUgYF/nRtbQ2VJNQG2IEZH/JpVce6ioJgjmFDkR8ImOZ1OpJ+PcT8usde?=
 =?us-ascii?Q?+46Eqf3cRNc8UNpqxsOUDebz6E1PPzvx4tFqfk5/9T5GqRnWLJkbb7oJpeW2?=
 =?us-ascii?Q?48EKRMpzlu7w9WPjVd69h5z0RHI2v4lVK4bq5Y2j4YZkBLarY0Ag+0Y5FXw3?=
 =?us-ascii?Q?CZ/mVHNfMZCz2iOaKlCl+V6mc7jZFMeSks6Q/eqFtrKN3qw/Maly+ulOm4hc?=
 =?us-ascii?Q?iGYF7XElUZOjhxjzZqfIh4XxvcRGDMmC54wa5jqpSFLGl02Bwo22cxPvRHTj?=
 =?us-ascii?Q?hLuCNGhRrGKBSq4jSqJpZpG8BJrDx7Ra+Hpg1NLG6WfkT9et8bNc1QXV+Yht?=
 =?us-ascii?Q?uNa0h1I4YS0Guo7FeUuUJ+xwVXdSjlAQfLdPgcVE9byx63zJfDnXhHv3ZgI2?=
 =?us-ascii?Q?pp4Iij71EjFkMtmeTaPGg75ZbOwM5Ly3ve9yzFId+DebD036QWfjSyRplINY?=
 =?us-ascii?Q?zIhxl11lYtWqz/aOzyptIUmfrvflLkK/Wc7PkvHq5W7fl0E/nPXZZw6rPUyJ?=
 =?us-ascii?Q?uWpa+fFjWkJB+GTPsDA7sGQIspBKv76z8WP3N/TIYaxCYpg1DGoIbU+HBDG2?=
 =?us-ascii?Q?oe9l5xAa37VIFidAnHMgPiot9CbIiOztQsGXvRzHG/QYzyXUDAm/kiCtm7ez?=
 =?us-ascii?Q?+M3YSyGesONC0ZzHZFNGTQAYS4JVo/S0CPXeEezjSalUPpfCyMqjQsd2Xm3I?=
 =?us-ascii?Q?xwfEaT3RoWFNGWu5MTWVVNUwkjW1B+MTH3XMAWJgI098fj0Vb8dJ5PMhJ9Ef?=
 =?us-ascii?Q?ju+S3o/ZLYQD9xsqqtuKoAPRh5q5X1m5gQ66fg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef11614d-aa21-4f4f-f710-08dc3a21fcb8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:01:22.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8941

From: Rick Edgecombe <rick.p.edgecombe@intel.com> Sent: Wednesday, February=
 21, 2024 6:10 PM
>=20
> On TDX it is possible for the untrusted host to cause

Same comment about TDX vs. CoCo VM.

> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to tak=
e
> care to handle these errors to avoid returning decrypted (shared) memory =
to
> the page allocator, which could lead to functional or security issues.
>=20
> uio_hv_generic could free decrypted/shared pages if
> set_memory_decrypted() fails.
>=20
> Check the decrypted field in the gpadl before freeing in order to not
> leak the memory.
>=20
> Only compile tested.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  drivers/uio/uio_hv_generic.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 20d9762331bd..6be3462b109f 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -181,12 +181,14 @@ hv_uio_cleanup(struct hv_device *dev, struct
> hv_uio_private_data *pdata)
>  {
>  	if (pdata->send_gpadl.gpadl_handle) {
>  		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
> -		vfree(pdata->send_buf);
> +		if (!pdata->send_gpadl.decrypted)
> +			vfree(pdata->send_buf);
>  	}
>=20
>  	if (pdata->recv_gpadl.gpadl_handle) {
>  		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
> -		vfree(pdata->recv_buf);
> +		if (!pdata->recv_gpadl.decrypted)
> +			vfree(pdata->recv_buf);
>  	}
>  }
>=20
> @@ -295,7 +297,8 @@ hv_uio_probe(struct hv_device *dev,
>  	ret =3D vmbus_establish_gpadl(channel, pdata->recv_buf,
>  				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
>  	if (ret) {
> -		vfree(pdata->recv_buf);
> +		if (!pdata->recv_gpadl.decrypted)
> +			vfree(pdata->recv_buf);
>  		goto fail_close;
>  	}
>=20
> @@ -317,7 +320,8 @@ hv_uio_probe(struct hv_device *dev,
>  	ret =3D vmbus_establish_gpadl(channel, pdata->send_buf,
>  				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
>  	if (ret) {
> -		vfree(pdata->send_buf);
> +		if (!pdata->send_gpadl.decrypted)
> +			vfree(pdata->send_buf);
>  		goto fail_close;
>  	}
>=20
> --
> 2.34.1


