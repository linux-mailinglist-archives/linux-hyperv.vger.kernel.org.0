Return-Path: <linux-hyperv+bounces-3761-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185B0A19E4F
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 07:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CB51656C8
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39D1BBBF1;
	Thu, 23 Jan 2025 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MKLTL5VF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021121.outbound.protection.outlook.com [40.93.194.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACAF19A;
	Thu, 23 Jan 2025 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737612180; cv=fail; b=VfFmrQU3UdyrDFU6ysRzWT7CSImyekg/bOUkvXN17Ky/n+aWn17cooF1+y4TvL2FdVCmKcXpt2rDfB6hoOtbSVMePkJ1uul08gnjZsjdox0Xz3di5r0e9DjkCO0Mz+xyEeblx9QbN1sWZCXicRBwv/QXHrO916xtAH9DN9mQhUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737612180; c=relaxed/simple;
	bh=VK/9SFTS9v/nrxoMZTpXE6sIeEP5s1E+r8N2lA2jQGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rrErSRrzcMnW2gudHEanKDjoZss+Otutfao+pZPrzWsY5jlnt5TYK7icBkMf/lnZFvGTAwafKXhO5IM3nAABMa0jYMBhO1hQJHGAfgMeiUt283n3b/ocPxQ3NV8VyURsTCS0Vr2nKfwEmCjiU3TkHS5FX7CXWzoseHoWBw5VT/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MKLTL5VF; arc=fail smtp.client-ip=40.93.194.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egyRIEeJwEH3SHkdBOWOFKITX0NMKsrOEGnW23K326J0mqQUkszZdd04kHgdJK+/yInOCVB4VCyft2S03J5BrmB9qxti1Kh2owor/MMiuagDsFmqwJXApXv38B/TNonHsqpoSgWhsGo9GDus7m6cCH4KorlcYD8nH6tkCzVqO/SIh7SRUqcMzCUCvCs380bZiQjRPBE9ttgEzmyicUfYKHFXxBkvb7P6L+C0QYb8McH6pEs8TtaYvtoZFj1UHJhwiDwcdAPPZJPL4aroeSbg6ZhcssZ7TYuKypuzGMUvXmUp4xts1cKQcAwg4T6CpZSrsIH04HsS3TJAFbc0oIUAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXz4UPnirp7nNFa37JptvuIV1J5rvJ1ncFZ7AkEB7HU=;
 b=WimJZtoreWRlOFXMhnRfgtCL7rnjBonOTsCOwHjY8qlkxBFStTts5eADXKMX+B+bfa6ydA/SohgRtbBtD/eGAYG57SDYvfMTNgmS2CKV9MKTsrguK2uQl4/+xPEGIhdxD8uWqXIFlj2a7MZpBytIomUYAFPG59+HjTtNmd802PTc+PLWnab0kC8nlVuh4PvN9zBqsY6xnCnAhA+EHjhnJPXgpGqlbM4KmD5MoGnMayRbT/mt1ZoeR+B0KLgc2h/WZewy6xrAoaKoQSyXA5AHip9nKxtpWxVxZkHrEWaLJLTKiusNM73o+JNi1IAM8bCpywbDZn0p5cjW5yp05BARxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXz4UPnirp7nNFa37JptvuIV1J5rvJ1ncFZ7AkEB7HU=;
 b=MKLTL5VFzbK3w2Ji/FgRmsLDINyhuvOQFd8lT2mv6V+IjqerZwcZUmeJNu73YpMpml/F4kv6t3uYtwpz6pX2qs4a+KGbkCXk3Xe9tSe5L3mymaKY/Nc8dUcc/2O0q4WbCkd3JV/hAk71EpubQjEvw3h6JQQGAbXWvW9EHkosDvw=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4462.namprd21.prod.outlook.com (2603:10b6:806:427::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.7; Thu, 23 Jan
 2025 06:02:55 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 06:02:55 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 11/13] RDMA/mana_ib: extend mana QP table
Thread-Topic: [PATCH rdma-next 11/13] RDMA/mana_ib: extend mana QP table
Thread-Index: AQHba2CX1hjI8L9b2keVBXqCjUjR4bMj4hiQ
Date: Thu, 23 Jan 2025 06:02:55 +0000
Message-ID:
 <SA6PR21MB4231D6EED2D7C1D4BC7FBCC2CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-12-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To:
 <1737394039-28772-12-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=79fae83b-025f-4337-98bf-03bf1a5983d2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T06:02:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4462:EE_
x-ms-office365-filtering-correlation-id: 817a4781-c37c-4218-1f52-08dd3b73949e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mctZvyQ4sYw3upmeS169eTzQzbr4KE8yUvhYPgwGykpEpXAuB6+nKsnDdQmu?=
 =?us-ascii?Q?Q6aESq/1aDJoAQWz2g9hzBNxjZ3a6iGH9eJW2ejm2Qo3e8cPI7f7cLy2p11P?=
 =?us-ascii?Q?3UhBl+ek4L+B+QekWg5nQ7dytZGmqNo4sTOXsj4YJchmh2e5OFyDXhY5y29/?=
 =?us-ascii?Q?iaSJ1L26Px/ayMlquah1dC2QzRJqGk7bLKPDy6peZrcgNxZ8Om4vhXdFEZQd?=
 =?us-ascii?Q?tKDwO6ejmqz8bmkHJe7+v7ReK2dGpq/yExKf7f5Md1RdSoCambkNjXQ1fzcT?=
 =?us-ascii?Q?T+zeY/ZEu0SAkmWTBonlPRENatydCzn1C9x4OHq/BQ+nOYIT1VCeitC2tdbL?=
 =?us-ascii?Q?8Ng7unL8cKJ1iNtYQO7aOL2dWbv2bDJFf/ohdv23trUTjvXSyRBFX5D0UwP8?=
 =?us-ascii?Q?H2/Euc9FjzlMo2RovCixyTc8NAq2GJyW2iWw1iG47H83iiBPBLnh366c96fb?=
 =?us-ascii?Q?4KHn5Rt8rk/shbYsYnhS4FAL6HPtEQyCVuE+zqnnz/ROAx9pZHhf2JCzuiN/?=
 =?us-ascii?Q?cYnqIs3q2w3QtFCnZ4s9RoBaVjPIWYEdowIRqIth4lV62s3L8JxqTVE7fzmc?=
 =?us-ascii?Q?ALC6VGJhp7Se8Y9mFrl1rjotkifM68d2Gdg1g8kRppiwCTZ/rA5wy8bd7I2x?=
 =?us-ascii?Q?2oUmoUPtijetaKjG7H2db0DIXJAE4UAZ11wtYfwzAkrklzKpK6nGC/aQXsB9?=
 =?us-ascii?Q?TjT2pd9WUIMTwXjA/wUGjWyu6I0rxAHqmdsUbTU+xXR4mv1HvwS+vCE8TFVf?=
 =?us-ascii?Q?uUmfrJLn9mYnjcuh1fMkdn9QGOQz8JGOB3n5N5AN5j4zgod8QsUkYRFtzzjq?=
 =?us-ascii?Q?fqm9/gZU/WkOyaz133a/cZOmk0cvIlLS9D+3Lb8AUUTWDuaTN3YMW8Lthc2T?=
 =?us-ascii?Q?vQMZac13UTSl1QR6dgJKa4Hb4WIL+I7zACj5dLXY4Wuz8fH+h5az46t8zVf9?=
 =?us-ascii?Q?pRnVcIG6DRY72aJq+ClDUoqJN0CZpLpBwrCwo9q1ZQwXedLupSJiOIHf39I4?=
 =?us-ascii?Q?ZNvvBudy/+j5chUZRgQZ6eF2IYjeiW6qNhFsmqQFMlPMHswZmkE+vT/6ZILk?=
 =?us-ascii?Q?iZmNKRPD98xLqW0ZFP8JXbyb2cNu3JvAbm6pPcNWs9tv3yRn1EQorcFYziyB?=
 =?us-ascii?Q?JbmAk3xjUtqFmxJJzJP1EWnZLVT86yIU5WSpVkDzUrRR35UwHA4BCLPy4QtR?=
 =?us-ascii?Q?ezTu6En0hvKiQC1+QNIWsZHEXHZiyov+ELvLvVwqmCuiWUQYkVNeAOpmbMFo?=
 =?us-ascii?Q?CZtPkyq5i+WVREDxa2Gepi3FNymin7waXcWk80di9XbJwHlfDZzIRURz3DLp?=
 =?us-ascii?Q?vqLSqc1m7mx5gYgouObKtZmjUuYAxHydUff0Fg9pGEqCa+d+Wno+oey67eS3?=
 =?us-ascii?Q?6QWso/7ju9F9Sox5Q0vs5AKFMIvPjW9R6KvV0svaV7KOffcj1/vZbqnqXIVY?=
 =?us-ascii?Q?s/NPzaXOTZ2QeSYuEESBgoipleMwjppN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pAh3sSHILnikj0b9ioX9CCOQvK2bqgOQ6zfdlCw/m6dIHCpcogZ3tm6ozVLB?=
 =?us-ascii?Q?zAldM9UcHRI3pF6mKOuWq5a7qW2eXWDHEmWPxpd44C1mqIQ5/1FQZtO3QzNC?=
 =?us-ascii?Q?gvb3fdDFPrvIKwS0V2DOcepbGa9smyaLiD/2tGUbcX7AT05CWw9aSqQgtZq8?=
 =?us-ascii?Q?zKFWFcfKJ4rYZNRiS+yaiz1ArVDsEa73/mRSpKvYRbuS7OXLouV6pQagbHsZ?=
 =?us-ascii?Q?FHXau+gZ0avakBcs6WAaRNBQ4kNUgdjotpqFmeyHchHh5DLQsmTB2fGPEB4c?=
 =?us-ascii?Q?7hy4xQwsyrPiJc3ocbI7CUQf+aMv7BGxMdFpald384dBnd8N0RPVAOQbFm8w?=
 =?us-ascii?Q?qC2BU6E3PZyM01gBmiUXcdySoY459d1se9zUeB0we+Q3pMYVO/+9m3xdDfTv?=
 =?us-ascii?Q?Fam/+RMby9kPeKsYsBQCfZOx7Q4GSCkTX8INo+CuAmMcZxPU7ICD3mLURdmV?=
 =?us-ascii?Q?tp4V1/y4VPmhfpbpj0neOjxgD73BaexyVegfJCZemnUCz+hxfFRE3m+6jUSv?=
 =?us-ascii?Q?2ZZO4+Xu6UzDjfJ8fxJ+W63KfehM99SoDvGmaqxBLmLjUDHY3GBTrHd0ptms?=
 =?us-ascii?Q?MTUgg58kfCq+f2rT906XZWkEFfKIdmActYMGfcjpZnrvpYQNiFoHN8OpiFfh?=
 =?us-ascii?Q?sRg6SuDQTVHvDHKw4ip5dCgVDn1a+vPT3X2f2Sc3zeLUZYHNA2NzRmkv1Kye?=
 =?us-ascii?Q?xRUgX72tDEsWOWc5lcJ7clxwXsesete1V/+sqlRNlG61ogU0mCaxuyexoXod?=
 =?us-ascii?Q?wrHhQG11QKSLtdy90X5OzxFBzl9SlmzV8eK+t0ms3cM0AylQ/KLAlrhqGlNe?=
 =?us-ascii?Q?2FjUfjuCeU7MYZkn/S9jW6WqqKDnw+uP5g7MhqR5rxNdOdHDyAiAKzRLTUXp?=
 =?us-ascii?Q?wZafxZKZN/juTkR6oJ0lPZVFpVi2XDeKaYbjsHwVU8ldhyeuD7e1Liv61LBK?=
 =?us-ascii?Q?TqAolfUtw7o1uvT00vtMMcQH9goDlKdzzEDvOShgMWHY0Dz+wzhQfR9/NJqp?=
 =?us-ascii?Q?8WbdtHPlhxRPSGMHxOx0hJism+ME321Rit8cpS87+dDddI8hGpT+jFAaMAQC?=
 =?us-ascii?Q?mdRRdJw6oH34O7WXRGiqcOs4YOSg+oen/kTbomDJM8LzU7teVBrGhwMdZ1u7?=
 =?us-ascii?Q?Yv5taqA+2X76GEKSKdV6dBbnR4/mcZHfK7Fj56HrDmY9LZbGOYsqJFXAriGH?=
 =?us-ascii?Q?VWheDTTUhFar1Cn4dpaikh0pDq7rTIzL2NiTx1l2Vr1OC2uIMv+mQHPvscNS?=
 =?us-ascii?Q?SIDyyU+4fN9OEoCKy/6xaTd58RUbtMrPvoMKxiQquFqP7xO2cLKvUSLFG2nR?=
 =?us-ascii?Q?SugYM7jTsDCqmcEhMUsJQ5cS4BH9JQEGTCHNhwQJ9DW6ez9u+6dFPK4IJTf/?=
 =?us-ascii?Q?9hrJPVXJ9E/IJ/K+pYTtrR6jsDw7BpYlxcnVW7VvzOXzWesqi3pryKUf5H5R?=
 =?us-ascii?Q?NNbW6VPDNQMudz003N7MVlLs2K2oOew8j4tLo34vtpSvF0TOcAunQbqO9C8K?=
 =?us-ascii?Q?XIxcwm1GkJeYayH6BOnz4zCJxak8KEENBGvphhmAkE9CU+7D3FQu5yyPJVWA?=
 =?us-ascii?Q?tODR2pLzOFvBCb9idI5EgrMkiy11uO+TyObJYKst?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817a4781-c37c-4218-1f52-08dd3b73949e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 06:02:55.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYOl/s3iky9l1kuTC3agDeIzMnLXKeT6eazofOQJdk+Dy7z+yn8vTgSf05XbRrWEXiB0OQ/jWtHoV2kJRHuxIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4462

> Subject: [PATCH rdma-next 11/13] RDMA/mana_ib: extend mana QP table
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Enable mana QP table to store UD/GSI QPs.
> For send queues, set the most significant bit to one, as send and receive=
 WQs can
> have the same ID in mana.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c    |  2 +-
>  drivers/infiniband/hw/mana/mana_ib.h |  8 ++-
>  drivers/infiniband/hw/mana/qp.c      | 78 ++++++++++++++++++++++++++--
>  3 files changed, 83 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index b0c55cb..114e391 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -704,7 +704,7 @@ mana_ib_event_handler(void *ctx, struct gdma_queue
> *q, struct gdma_event *event)
>  	switch (event->type) {
>  	case GDMA_EQE_RNIC_QP_FATAL:
>  		qpn =3D event->details[0];
> -		qp =3D mana_get_qp_ref(mdev, qpn);
> +		qp =3D mana_get_qp_ref(mdev, qpn, false);
>  		if (!qp)
>  			break;
>  		if (qp->ibqp.event_handler) {
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index bd34ad6..5e4ca55 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -23,6 +23,9 @@
>  /* MANA doesn't have any limit for MR size */
>  #define MANA_IB_MAX_MR_SIZE	U64_MAX
>=20
> +/* Send queue ID mask */
> +#define MANA_SENDQ_MASK	BIT(31)
> +
>  /*
>   * The hardware limit of number of MRs is greater than maximum number of=
 MRs
>   * that can possibly represent in 24 bits @@ -438,11 +441,14 @@ static i=
nline
> struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev)  }
>=20
>  static inline struct mana_ib_qp *mana_get_qp_ref(struct mana_ib_dev *mde=
v,
> -						 uint32_t qid)
> +						 u32 qid, bool is_sq)
>  {
>  	struct mana_ib_qp *qp;
>  	unsigned long flag;
>=20
> +	if (is_sq)
> +		qid |=3D MANA_SENDQ_MASK;
> +
>  	xa_lock_irqsave(&mdev->qp_table_wq, flag);
>  	qp =3D xa_load(&mdev->qp_table_wq, qid);
>  	if (qp)
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 051ea03..2528046 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -444,18 +444,82 @@ static enum gdma_queue_type
> mana_ib_queue_type(struct ib_qp_init_attr *attr, u32
>  	return type;
>  }
>=20
> +static int mana_table_store_rc_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp) {
> +	return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp,
> +			     GFP_KERNEL);
> +}
> +
> +static void mana_table_remove_rc_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp) {
> +	xa_erase_irq(&mdev->qp_table_wq, qp->ibqp.qp_num); }
> +
> +static int mana_table_store_ud_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp) {
> +	u32 qids =3D qp->ud_qp.queues[MANA_UD_SEND_QUEUE].id |
> MANA_SENDQ_MASK;
> +	u32 qidr =3D qp->ud_qp.queues[MANA_UD_RECV_QUEUE].id;
> +	int err;
> +
> +	err =3D xa_insert_irq(&mdev->qp_table_wq, qids, qp, GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	err =3D xa_insert_irq(&mdev->qp_table_wq, qidr, qp, GFP_KERNEL);
> +	if (err)
> +		goto remove_sq;
> +
> +	return 0;
> +
> +remove_sq:
> +	xa_erase_irq(&mdev->qp_table_wq, qids);
> +	return err;
> +}
> +
> +static void mana_table_remove_ud_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp) {
> +	u32 qids =3D qp->ud_qp.queues[MANA_UD_SEND_QUEUE].id |
> MANA_SENDQ_MASK;
> +	u32 qidr =3D qp->ud_qp.queues[MANA_UD_RECV_QUEUE].id;
> +
> +	xa_erase_irq(&mdev->qp_table_wq, qids);
> +	xa_erase_irq(&mdev->qp_table_wq, qidr); }
> +
>  static int mana_table_store_qp(struct mana_ib_dev *mdev, struct mana_ib_=
qp
> *qp)  {
>  	refcount_set(&qp->refcount, 1);
>  	init_completion(&qp->free);
> -	return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp,
> -			     GFP_KERNEL);
> +
> +	switch (qp->ibqp.qp_type) {
> +	case IB_QPT_RC:
> +		return mana_table_store_rc_qp(mdev, qp);
> +	case IB_QPT_UD:
> +	case IB_QPT_GSI:
> +		return mana_table_store_ud_qp(mdev, qp);
> +	default:
> +		ibdev_dbg(&mdev->ib_dev, "Unknown QP type for storing in
> mana table, %d\n",
> +			  qp->ibqp.qp_type);
> +	}
> +
> +	return -EINVAL;
>  }
>=20
>  static void mana_table_remove_qp(struct mana_ib_dev *mdev,
>  				 struct mana_ib_qp *qp)
>  {
> -	xa_erase_irq(&mdev->qp_table_wq, qp->ibqp.qp_num);
> +	switch (qp->ibqp.qp_type) {
> +	case IB_QPT_RC:
> +		mana_table_remove_rc_qp(mdev, qp);
> +		break;
> +	case IB_QPT_UD:
> +	case IB_QPT_GSI:
> +		mana_table_remove_ud_qp(mdev, qp);
> +		break;
> +	default:
> +		ibdev_dbg(&mdev->ib_dev, "Unknown QP type for removing
> from mana table, %d\n",
> +			  qp->ibqp.qp_type);
> +		return;
> +	}
>  	mana_put_qp_ref(qp);
>  	wait_for_completion(&qp->free);
>  }
> @@ -586,8 +650,14 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	for (i =3D 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i)
>  		qp->ud_qp.queues[i].kmem->id =3D qp->ud_qp.queues[i].id;
>=20
> +	err =3D mana_table_store_qp(mdev, qp);
> +	if (err)
> +		goto destroy_qp;
> +
>  	return 0;
>=20
> +destroy_qp:
> +	mana_ib_gd_destroy_ud_qp(mdev, qp);
>  destroy_shadow_queues:
>  	destroy_shadow_queue(&qp->shadow_rq);
>  	destroy_shadow_queue(&qp->shadow_sq);
> @@ -770,6 +840,8 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp
> *qp, struct ib_udata *udata)
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
>  	int i;
>=20
> +	mana_table_remove_qp(mdev, qp);
> +
>  	destroy_shadow_queue(&qp->shadow_rq);
>  	destroy_shadow_queue(&qp->shadow_sq);
>=20
> --
> 2.43.0


