Return-Path: <linux-hyperv+bounces-3553-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B729FE009
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Dec 2024 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4A218824D0
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Dec 2024 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06118B464;
	Sun, 29 Dec 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NKljfn/A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2058.outbound.protection.outlook.com [40.92.23.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B79476;
	Sun, 29 Dec 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735493699; cv=fail; b=cbI+uvlgatB3Nd9bea/k1gaplIm3TL9lOeIeVBuL/5ngvU1c/WFWOtJd2RBWuk9IPkppnjPh2opxUVIZSNfqI0paL0e9NhNPWLnHlxOZRqow+yA3xJwHJ101fqnD/DQklP79omdrYFs7rki126bq8OSAiFElfkBuTw4w+oOU/ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735493699; c=relaxed/simple;
	bh=vOrpy8QoYmyCKvkN1Zd4CiEOiWlgPc3rZPToNFmGsOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I47ot/lXgJKFIVsgKgLVyYXpvm9ytTf2Bv3HfQRhraBz026M00nV2wcEe4VEVvO5tkgHNsO21WqWkk8yHwD7CuV/7W1EFliCnNtrjGV9BKXjI+PzRE23r47dezqaqp6EpP7ZKrcakdGmAdKzoyGZgb4oOmMsT8a3em0dRETReVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NKljfn/A; arc=fail smtp.client-ip=40.92.23.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxeiOokAG2Mo2+nsXTtbozfQRhNWcEZ5raBbstfOl+vumG/RiGZGindSf+WkjCGJHBSJvVUA/ltyWuTVVfnhVRzOSY386cNI93kGOlFtgsXaYnUIDZfj6okzCtOAmwRZLYiAc47tlLngr6s5/YyHoljVPOzh8+jDf0gPbC1BuzxJQYB70Jh41gCyi92a1F9+iN5u3PfQP2IlpAV9f0ek/hL+gzp0rK2P+p8pq13p7Sn8H44vuvVg6Z2pdZCAcSPWl9sk464RX/PEaNXS48NUYFhmei4YHF/hR0b6ycrkOPuZVz9paOSEJwtGZE8BGRjQ89nBFngOnx8nXEJm85Rslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sTvDezLV1LJUdBZtOVV9ZDQ/eZoW/x2/7h65wQSUiU=;
 b=fKonU7uSkvzwn3LJCFmpfg3OVKHi+GB3S4af6OMO0oXcKdg/+M38hWbmdHiD3jRiObadiadYn+ITZ/tlt3wqQuppWdF8zuxgxuuhYXOVVsE2zp7rpEmf3seWzKmydmtLSPmXFC2BFv5rjpOlVfrZM8IliiFPArWVrt6FhV8OIAW6efdVVuhnnpApl9XWlAIVk+NL552FCcBBu4yPUs6YIaV3gX+WYMoI5CycQXuf7x2c+C1rZmuGA3Ibkoij/pgwBfJlasVWmShjYp+rVdLTH0wH6GjL0rO9AeRNQ4HTFxQwXConbshG/hJzYEN9+pw4qx6aZlENQfQWuN5miUg8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sTvDezLV1LJUdBZtOVV9ZDQ/eZoW/x2/7h65wQSUiU=;
 b=NKljfn/Al2JHrhASM6Fbf+GT5f/kp9Mhd9SAp623rPPNYfCQtj6DsmHTKhSAIuff8iL4K2hxdybxeYkSQEJ7PwNI+3osJt//OXRZJjRkLSZ70WVbDg+po1ZlS8QY3fEgPd1Reinwm2rUEEPKs5MQuzHc28MO0RLPzNPvwujR2eplCyQYSAMPGjB8JgJ02fbKjB3658kP25d8nkr4AKlV/xZF94POPo7JFCwTUC1ShAXFQQ9vMDdZ8SMXFduARiOF1znq7AQYxUQi/3f82AWx0Q4NQBTG6+N3yBOoODtZUur6t9zZv4XvXxE7bPoEdbWFZ0cS3lt8Rk9AWywIZ31R4w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7706.namprd02.prod.outlook.com (2603:10b6:806:14c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Sun, 29 Dec
 2024 17:34:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.8293.000; Sun, 29 Dec 2024
 17:34:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yury Norov <yury.norov@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH 13/14] PCI: hv: switch hv_compose_multi_msi_req_get_cpu()
 to using cpumask_next_wrap()
Thread-Topic: [PATCH 13/14] PCI: hv: switch hv_compose_multi_msi_req_get_cpu()
 to using cpumask_next_wrap()
Thread-Index: AQHbWVnEyVeozSxBvUqMrmSm41Sd/7L9fB8g
Date: Sun, 29 Dec 2024 17:34:55 +0000
Message-ID:
 <SN6PR02MB415771568C1D449079456CB8D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-14-yury.norov@gmail.com>
In-Reply-To: <20241228184949.31582-14-yury.norov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7706:EE_
x-ms-office365-filtering-correlation-id: aca0ad7e-2ae8-45f5-df53-08dd282f1c3e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|8062599003|19110799003|461199028|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Dh3APDK+fEWESeAVcrZTjos+5vi6CRmnfbDz/OOaRuURKj+9baEB3+aC/W?=
 =?iso-8859-2?Q?avaOIfOyqEBbFnRUZAqtPLmdxvxT+jMJrmaldkcSpMPypMTGsKEbm6QZwd?=
 =?iso-8859-2?Q?XuDWk/8cSPEEk0vP93WNFnFk1pBQtPdcrU/6Zz30fLX1ojKHG5HI6BoWFY?=
 =?iso-8859-2?Q?mDRpVM3aqx4ZrL2fQbzm20f55tt447y0dLT7NiNtqoIhxxTptppVSeiHKG?=
 =?iso-8859-2?Q?kqYAvtJjkWc37/ZmF7HRdgAgRZEJAHvXRWEFfhBlU0NXgetrmYTgBG+DF7?=
 =?iso-8859-2?Q?zOOS7I/pM3a1S4T0Rx/7vJ+ox3/Wkdiu0tpEZeU1+3wiSFcckaR1sK6Rb4?=
 =?iso-8859-2?Q?IHF042QftDfbxEft66CgZypb8Kni838ouyP24Z3EWUEk2VQL/6Wexs1Gye?=
 =?iso-8859-2?Q?9LBify/tlOTHuOI9m7ygxqnxXnmytw2XhLacMI1jfowA+1ufPBhdNCkO07?=
 =?iso-8859-2?Q?1hdYeIIT+HMALOTaBTHMZIX6cgvQmCQkEaLUAPj+eLLakPDIcSS3FfWuCy?=
 =?iso-8859-2?Q?b27UrxskJf//qKLbryV3P/H74n7VoK5Yp24hiQG1SGFzNnWlTp3vqEpBA5?=
 =?iso-8859-2?Q?jiEldsK4LXYI7AC/GpFV0gn5apOSmIzfboNe1K2xkU6VTGXzlgmX/ScY1O?=
 =?iso-8859-2?Q?caU/89jhOqLrVU9lQSQtTjQmzwubnxF7N+FsSHOQC3uCT52Wk4+jhYkg9Y?=
 =?iso-8859-2?Q?+B/x4sspGFb6nRgaR4nnSdAuEASBq6fHywz31yqTNTP5dM22bNIQqKPSAF?=
 =?iso-8859-2?Q?p7jpL159dtzlXVyDyAnAOWxI7NUpfsfqlqcC92SPgPpNLwoiXZZoeT00wE?=
 =?iso-8859-2?Q?mooMd4RjWf5GVSk8TVpDCq56a1vTsmgYB2FGd3r4g8g3tp+Xy+Ws0ir0fZ?=
 =?iso-8859-2?Q?Ciic9TX9Fmpin+edaywMUOhhHB+2Cw2/ShOmWGlSLhh2WNvp/AurhoQwNe?=
 =?iso-8859-2?Q?PclvIERqTFvuBNmoD76haREu5L53UZ9J878h+hiak7KhaYXnclAtmWvDZL?=
 =?iso-8859-2?Q?EUlgIRjORoWiACiuFJC+1U6ojPN3Pgl8fDS4cUR1V0FwjjVQq0juirJC+0?=
 =?iso-8859-2?Q?aPl46OmCqLSPHUdF+CLgEzU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?S72U1oO5hKE77a80T9R9Lomt3AxL4dfJaGAnot51soyetIQ7uzRRzEBpGr?=
 =?iso-8859-2?Q?xpbM3utWBLB4SPSYziGu0uj9vQs5u48/sJpTaMBvtNxysoue3K0OHvtRLI?=
 =?iso-8859-2?Q?OtpFHUnT4D6RPIm0NXVMfo3Fm36zeIXvLfH0w0wl1n9rXX2Rkj33ouUvCB?=
 =?iso-8859-2?Q?Ox3jgxcHdw/+PYPgy+2KcIWhnsKi0K5Wcp4hNdDuBTDpL4VsqzIa2mt+s2?=
 =?iso-8859-2?Q?Ekyqqjs+F478FYfNX01m2HNUgkrObc4zNfOKtwsS0Y6XYuGdRSLDYYSY5x?=
 =?iso-8859-2?Q?gZMePGC15SvUTvLYW5DD7P9E2peewA0KPa3ou1kzgoGQn749kWHcmswT/V?=
 =?iso-8859-2?Q?2S0ozAKirDI4t2ElIKrDTdb/kmI6gVS/XgoO2pjBbau+B49/we4Grs/Rrc?=
 =?iso-8859-2?Q?OORDqgnvF3UtjtOcWr5TstASao0DaCLRIbRL2nnpcLomDOKnqaUBz523AQ?=
 =?iso-8859-2?Q?s/ACCMUrb4ib6m4dTeHznnYgJjPJ7OwvJdEV8vaHjqq9Ecp04IiO5F9IPm?=
 =?iso-8859-2?Q?hU+gNa1p6cmT50aywSQYuwEJ+HK+NJmY5RLmLIJ6/9rlPn423zrbvz043F?=
 =?iso-8859-2?Q?8Pm3N+4IvUWYST9JgpkVzcOFxy7ieIYyYT4JwHLeVCEFm3LgMtiPhcQJP1?=
 =?iso-8859-2?Q?2wy6f0hy2tqtsfevRYfgdwT83ewGEXYe25Dz0K2QWXZj5aSNm1leU45n1x?=
 =?iso-8859-2?Q?S0ojqVyBsmoGt7zc4bVV+fBB+Q2XFvy0xr0vGobEOkPFxcQXy5DYOk5+i0?=
 =?iso-8859-2?Q?vk2BV1P+mJED7jrrcTXQExh62B7SVbTPPBm7eM4HfGuY/X3SZBVyqr2M+C?=
 =?iso-8859-2?Q?qOwvPv8nPLHvia+mQXhBriD/Vo77oH3VW7/1eT19h47p4jleKFjFnP5Ck1?=
 =?iso-8859-2?Q?vzd2wh8mp5rNOP7bbEF5E1YVNwmHgEAG1qy2lPDTzeucPXi1vQKvzLlD7d?=
 =?iso-8859-2?Q?EAuHWHokyCY3T/pyy2LZ5tW9/H8hkH921M1+/o6pWl2TK1ylSROp0zxv9s?=
 =?iso-8859-2?Q?4VSoVCBlg7z1C2mnVyQxguo+aoAWNS1BaRRxCkWnwGBXQAsLIWURp8wHPc?=
 =?iso-8859-2?Q?AdxIboQQ0oQ6mcJGXNmIKEQSoWy7wnyllI+pS3ubNbNbC4tURQ1Utz/Onw?=
 =?iso-8859-2?Q?KPE9K+sp2Zb5xFR60uoASF0JigmKMd0/LRsg7LkxG3+97D+wCa5GfIcI2T?=
 =?iso-8859-2?Q?52Rw9jQ0pMwI1V3Q0j2jPn8zCqnEB4hitGsBmvVuR1AoUKSv57oXeGDh3A?=
 =?iso-8859-2?Q?waxPqoNxxjP9ijT41SZ4BkF5I561UavDj6elz84tk=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aca0ad7e-2ae8-45f5-df53-08dd282f1c3e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2024 17:34:55.8536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7706

From: Yury Norov <yury.norov@gmail.com> Sent: Saturday, December 28, 2024 1=
0:50 AM
>=20
> Calling cpumask_next_wrap_old() with starting CPU =3D=3D nr_cpu_ids
> is effectively the same as request to find first CPU, starting
> from a given one and wrapping around if needed.
>=20
> cpumask_next_wrap() is a proper replacement for that.
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 86d1c2be8eb5..f8ebf98248b3 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1757,8 +1757,7 @@ static int hv_compose_multi_msi_req_get_cpu(void)
>=20
>  	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
>=20
> -	cpu_next =3D cpumask_next_wrap_old(cpu_next, cpu_online_mask, nr_cpu_id=
s,
> -				     false);
> +	cpu_next =3D cpumask_next_wrap(cpu_next, cpu_online_mask);
>  	cpu =3D cpu_next;
>=20
>  	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
> --
> 2.43.0
>=20

I remember reviewing the patch that originally added this use of
cpumask_next_wrap(). The two extra parameters were really
hard to understand. Nice to see them go away!

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

