Return-Path: <linux-hyperv+bounces-6930-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D36B82D9D
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 06:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B06585451
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 04:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BB23D7C2;
	Thu, 18 Sep 2025 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Silt2gfT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010022.outbound.protection.outlook.com [52.103.2.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06623D7F4;
	Thu, 18 Sep 2025 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168390; cv=fail; b=FHZNdcSRiI/TKzz0sq9nVUo8z0ikpoVL982+pT8gQV6Qe4qh1DhvvcyxgyUfyw4vtpvkf+05Ltv3lXWg+XL24MDM0PTNGgSXRTfBwnvCPds9Sx0TfycDPNU9zwqV9D6G9Uo5SO+RbCk17b9v3j07cjv/hWJIdwsGx0ecrPJtp3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168390; c=relaxed/simple;
	bh=EpwiVef/I7PKKn7hNx3czYhKJIUQ4fIQAWEQLYfT+YQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwyDBGt+14/6mzkIfJ2QoYDaqakUt+EZZ+9CWEtLvnAySKJi0pMK1VUkRO7WY024kP/p69+TQPeH15wCXdwCrxeaD1LJ6BbILH3ePQQ16g6z1RD9DypR1fbprYlSG5AHzuDZEN2yfV85mGhD2v6gU6VXviQ1fExTEtomcVlzgaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Silt2gfT; arc=fail smtp.client-ip=52.103.2.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjisDr6aQ/RLSVmAk0HNVSh6zjcB3yb0WGFPWFA/yXO/6putNFE7wzojTvBPkZJYuCZDm2vDNWad4v/BEarzPfQKlOFXd+4IvWajWtRHzR7puZsznrIxpJJIDCv+KvOFDskZfbU0OSp4bHRjNxNg0ND1ypO7IVqEAitNgNMeQQ/zjyv0korA69Fgq0Fn8h+1ycqqsnovcauZViQ/4mzroSyxWwV4nTjkwDDjWZ4C/R5cgtyO4d+McMLgBzUWxMmS64+emo+iFOMWqlwpeEH5xKZuYFkRuJe68IzcP2o6yhAp76OVbvdi21J2XAp7YifRpQXHB4h9WgcayA8uacBMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+s2jHrJFLB0KRNKC0cA/pRTdreBpbe1iL0Mu/cP41w=;
 b=WJRwHzFrCxdHLh0n+28SItzpsVSSRo9pSOzdUwbiEifGSSt2hjCOHTmvw21tI6X1v+hkp/oqpZLh74P8Hnitw22M5Qtokhll4du4cOP8zQ6Vlu6wHeifZwD7+075DluDcgi80sB8s5dTUv0mqCYmgjtWj5n93/RmCMuOpkH60AMm2t6Tj/0S3twhtYFKgW48sjz/LKaCH5CL+8zdXvgnx17s56Cn6TtlLcYCFLXeW/dLlwhxOIP6Mv7+JgGjnbQ4DjP6xkIbKiEjWZ9SU5M8RbWucPX3j1po7pxz/nuF3pWMFrWO6omxNcP7ZvEWfoqBpiGFt1v4IzWHyYd80uWhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+s2jHrJFLB0KRNKC0cA/pRTdreBpbe1iL0Mu/cP41w=;
 b=Silt2gfTed+oAWWsAIbPu6XLRLc6PZ+7YkMqhG49MheSAmsQnEwLKtiSw1TcmxHE5Ezmuqe0R2bym+0mf5jKzB1qpRdcPtgOeMFDNw+6WRCWfXyUPVVhVr6f6T+UosLztYea7nPCefkDi6pbabUoT6KrBx/4VoJ/KeQcSkPRzS+RBaOfIRp6TgU08s4tMK2LTN3VZOsg1d1347nnUrv2V6F7hg9YPRBABcpdcFn7+5ZviTNWsafKLYZvTb5WNmzZ8A+b9F7PAH+43dHh9aQOQHndE2T9pG93Dei9xo0CESRKXFjqbeneiRYITBIEN1tvGZhzgv1ZC0cUdAb/2MoJVQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB9409.namprd02.prod.outlook.com (2603:10b6:510:277::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 04:06:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 04:06:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "open list:Hyper-V/Azure CORE AND DRIVERS"
	<linux-hyperv@vger.kernel.org>, "open list:SCSI SUBSYSTEM"
	<linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/6] scsi: storvsc: Remove redundant ternary operators
Thread-Topic: [PATCH 6/6] scsi: storvsc: Remove redundant ternary operators
Thread-Index: AQHcHA2/vwdzqAU/Z0mah1c2BU2c8rSYauYg
Date: Thu, 18 Sep 2025 04:06:24 +0000
Message-ID:
 <SN6PR02MB4157A1DF13DB4C28AAD47DA6D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250902132359.83059-1-liaoyuanhong@vivo.com>
 <20250902132359.83059-7-liaoyuanhong@vivo.com>
In-Reply-To: <20250902132359.83059-7-liaoyuanhong@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB9409:EE_
x-ms-office365-filtering-correlation-id: a3ae2de1-666a-4792-db5a-08ddf668bbf5
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|8062599012|19110799012|8060799015|13091999003|15080799012|440099028|40105399003|52005399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EXFP9rMybUooURTDutAZc9ajCqq1mcau0wEUGtij+pjBfAvq3UDFtSffFdLm?=
 =?us-ascii?Q?He6wxkXo4LLzlyskjQm1tcFjkpwyjcywsPKTpDAGSdhPIXcEHR6bXh/NPuFv?=
 =?us-ascii?Q?yvC7BZcr8lDIb/G77v0T75w5at+sapGApG6rubJvwvVa6AXi2u3qtQFXrQAI?=
 =?us-ascii?Q?37gJGp7FMeMZLnCiEZ663zN+MJ/p1HWYrMHI64xOBB9oCJ0st70JWpqPa2Q4?=
 =?us-ascii?Q?8Qyp71OXPDBlyxdYshLNf/YvuwTfA5xfmnRd/X01YfkZZoo+okwuXh+53UGX?=
 =?us-ascii?Q?PJYEVgH19LV0R87QDYGqKmpJqegXjDAX25VDvaGnUJntMaETzPaJVXYxQ3l7?=
 =?us-ascii?Q?15lT0bG9iMr79Ni5vZ8F3inugPoJMliP8hfccQy8zD+B6k7CXQQUl7QfPupI?=
 =?us-ascii?Q?GKB6VtyiumFiClzpDWHiGc/aLu+iSTI8bBLjojpu70FhISeYs2FdH8A1xXy8?=
 =?us-ascii?Q?O2fIRR695/b53lgyGxuJYDvP4vminADaoHeqsqV96ZKuyWxFdo+lntZkCRpe?=
 =?us-ascii?Q?jz0oDeyBLGILfC0BU8bbwDX8Ce6G/3YBB3fr6G9h8GPF1yZhko8pU4v3dzp3?=
 =?us-ascii?Q?v7Qjeg0eHYiw0NilFCjonwuSMyrOBFk63NdH7RqVJ0G0TjFSRF4yXvm3/VwZ?=
 =?us-ascii?Q?fNZO3DLC2KSnp5pP0QzZsbueO+ksuFRftGP9OtKTvGMMliFjYQFL6Ef05VXa?=
 =?us-ascii?Q?4qG4GFw4gpftGhaWPHFPVg/OgQk0hqPVYmiEN6T5Wu/p9n8oJiN/4GIMq1ES?=
 =?us-ascii?Q?eadjKoGRTDU0WBp3CnaHEkkSqQ5HsCSEUifp+R9atiO6xFBbdXtuAhoFvxWW?=
 =?us-ascii?Q?9YCvfgz4bed28jgKNoTw/Qi8tsgwwV0xdiRUnGDSSBgLZA68tmpHoY1YZo/Y?=
 =?us-ascii?Q?uGFJL/C8LJOpbn4fwVUjFIi/qRqAykBeagYBbSh+lmjhD56EC1/u44GLoJmn?=
 =?us-ascii?Q?JefdlQ7iwcilVgn0/33+5zAp37LGyHfBg1URl761NhyYtbK1rh2QkZZcgp8v?=
 =?us-ascii?Q?lEQ8F9p0JK6FTKHwK/NskNghxIZ/ELC3kXSHqidsZjMIq9Z81Klo0S1g1PK9?=
 =?us-ascii?Q?Gf3tSUGELKXQ8oD3uYWYJmz5BzfQ3nlh6ufItc6iKs7+v2kAlFwBRIYxjK2Z?=
 =?us-ascii?Q?hElx2BmhGHdClwV8UgRIViHWTcAwcNshfsJGi+2/3hsat9aoSdGpkF14K4To?=
 =?us-ascii?Q?fsXFwXSL/GZW4E1vZ6NlV2bAD0ht/8MkUkaKJw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S1aEv4UcCkOKx5EGxXjfJWQa94TrKD372NWqVf+02K60Sj1wIC0fh8DHTFWy?=
 =?us-ascii?Q?d6cyGwa2+7cjIGPvTeCP1ZOe/hi9VMWQlLDNakktVoUrRVF4DHBbjsecmlRA?=
 =?us-ascii?Q?PXPZeAOjoomYHH3+hSnj1lylSIOlFKpaB3XHCtm+It7Z3V6U7AnBD3Fbb7Dl?=
 =?us-ascii?Q?/OdvdviaPR5qrBtbBXki4Uy6KewW02IixWGiRtQyMZbhtNVLH1Xck23XNV3x?=
 =?us-ascii?Q?nSTHmUGYil3SPZVYrrIjAT1e+KWPmG6O6CKwdpMfkq/qJWJPBMbnWtxAQHvt?=
 =?us-ascii?Q?wslrQ5IK6rhqjiv9IT8MN5MOq+pLIBKiaB/sp4/wng0FiXz7LOj6p7AkST60?=
 =?us-ascii?Q?xUK24ntJA5NVlCjzedoz8JmuoevRT3H4vr+ydHjuLnkAZoqQ+cqfV73gluvz?=
 =?us-ascii?Q?iYyQTHgVCdBaDdkGq/uut1n10Vmizebvs02BMJXJvBEEmkyicJ1HghWCFr6B?=
 =?us-ascii?Q?rKWf9LMHIn40KrE5aFzIkkHsYqjLnq64CSncyk9ZvLhBcutq4SCZVbSO3oab?=
 =?us-ascii?Q?f0iV2WFJjn7YcWEv5MB7g8FUNm2EwY8G9PxAZMxbOycwhBTMb17DO5ce+7aN?=
 =?us-ascii?Q?pQimT/mywOS3JSgjzh1xTHGUV3db2mbC6+zKuSkOsDmjaB/2IGSk6NhU0aCp?=
 =?us-ascii?Q?+nQuIOL/h4ft4+7Qx86J6Y7Pr7vYWHe8UTPro6Be4D4omDskEMqUvJOKL7pU?=
 =?us-ascii?Q?Q7SuTNePsQdDBYpkfk5CLV5sp7Ds13Nop6NdIdJ+n8l7oY1YtmBKbk82+yTg?=
 =?us-ascii?Q?vsB8V51wxUXOcm88zpSIse7sg3T4+M1Cxzq3WTaVW6QdNWBif8wgodjE5Vhy?=
 =?us-ascii?Q?QyLNTsV8SBFFPhh6dSNXKslHQGHBBAPOCzZmZRVgtv+BVsH+U4Nv3I3/MCWU?=
 =?us-ascii?Q?oNzWwUQR+w7HTBjvvSjMCCMVjBiYdqjiHY5xFDjaUPBJ/1K4HVTSYXrD9Ljs?=
 =?us-ascii?Q?ctBE/tsQ4YKGZboIql20pW0xFoPSgZCr5G9u+HWzrXDmFQXCbjN/HoTNHMjJ?=
 =?us-ascii?Q?wdgqKhKyiOenpYJfmtwXOKmKmu+UdpmGHrtHgd/OsnhOqE5lafgYYpb4//ZN?=
 =?us-ascii?Q?zcHMfLp2CD+BKS8QJKg+uc990tZwwtTXOqn3OvbIlOrDMsuYFYDNIZoEn7ra?=
 =?us-ascii?Q?CzYkq/kBEXZH4aCU3/mzTD0M+1GyfapuUX14uJgfGKdP0AYj/ZIcJYbA2ITy?=
 =?us-ascii?Q?1/Tfz536Lcts9Zs40Au2WTufMHT1vA5oKKalJtQ0x2BQ3opdMya48d9yNiQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ae2de1-666a-4792-db5a-08ddf668bbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 04:06:24.6517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9409

From: Liao Yuanhong <liaoyuanhong@vivo.com> Sent: Tuesday, September 2, 202=
5 6:24 AM
>=20
> Remove redundant ternary operators to clean up the code.
>=20
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/scsi/storvsc_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index d9e59204a9c3..7449743930d2 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1941,8 +1941,8 @@ static int storvsc_probe(struct hv_device *device,
>  	int num_present_cpus =3D num_present_cpus();
>  	struct Scsi_Host *host;
>  	struct hv_host_device *host_dev;
> -	bool dev_is_ide =3D ((dev_id->driver_data =3D=3D IDE_GUID) ? true : fal=
se);
> -	bool is_fc =3D ((dev_id->driver_data =3D=3D SFC_GUID) ? true : false);
> +	bool dev_is_ide =3D dev_id->driver_data =3D=3D IDE_GUID;
> +	bool is_fc =3D dev_id->driver_data =3D=3D SFC_GUID;
>  	int target =3D 0;
>  	struct storvsc_device *stor_device;
>  	int max_sub_channels =3D 0;
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


