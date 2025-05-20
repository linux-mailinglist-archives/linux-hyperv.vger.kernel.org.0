Return-Path: <linux-hyperv+bounces-5559-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D16ABCC2E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 03:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B8416CB88
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 01:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA9C254876;
	Tue, 20 May 2025 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HxYmcDeT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2050.outbound.protection.outlook.com [40.92.18.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5D1FDE22;
	Tue, 20 May 2025 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704254; cv=fail; b=rUjJ2QjvbffXsKB58pET+XY/zI60uYBdPoohTSkHaZalHHoOBEoWJ08TJC+6Al5Xytr7mIHGc56TmWx3JXKDbBXZkyyNZcKflIQev7c0VI6V2o+cw+1AG2k2DzkbKzlf1Lu0O0AuLGCPkOe0HG+qEL4xQg1aZJ50UoZVf67osRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704254; c=relaxed/simple;
	bh=K5YyKcza3+f+Jg2INtBKj1lQJVuKVtT1jIYfZExB8r8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rT25esmZ7b2DhZxjT8CObjTMZ4kr8EHfmn3kJiAb/mt7gVsyVzQf5FEDWs+Gjr8w0JgtcKczPevKFa83WkzZFqiEUc9QYrY+5NHQTLbWwE5/G8JrOPhe2SQQRCBT3YQkHgB3+i0rSxrjkJCi6hgJyI8dFljlL/5nceOT5y+egOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HxYmcDeT; arc=fail smtp.client-ip=40.92.18.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqOzOqowEdKRui9FaBwtOGidLx5/IYVTRVzzt/7lfAGjQSvq7piiw3+lIWCV2IiqCpS5PHoGAjpZQ7Dv7TQ6fOsT/4U0pkvqhKShWwEY5fY1KAqmJVV0mGOZOR082hW9qxnFxMcijzNGBs18wtgFd8Dh4YRMKi6ZqzdyAoYr/2rGvRaVObXC4v8KMO1RvXlo4uqlzqaMZxrrr4hCLXrxMe/P+phliUAqrEFIz8CLuZrhvVLTqR/WkVgSBRB7nZcngagVmdiK1D7p/mxny8983hcZuBfSMdScz5MTco4CylRhO6MbYX4CVkq0fMEVyNwgxg3WdtE+pcL9dArytNBOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDZ15il0Rc2UVOYIQGhdotAkymzn6tJCevRHW1+2ftw=;
 b=wGs1QXi6EAMvXcGHTmshpNSRPgHCae2ZOp7p78560GhIcpfIC9ls4pZj3AWJB0JmkdBiLOtJfZwcAGKIYHV2w+FKvVvKJGNI0jgbljIZ+DA/ZPmPVRULe5z+ofMYWQlMeW6JOBAFBYFvGrffnCKormtqCFCxZiCVHYRgZgiFNdhWqmccoiYE+OvOjh85jpU0wuwq2qd9hG/HTRsr4B/Qh07eNmKAG1H9ayzXsqli3XedHM81l1P4OihVI6NrTUr94j90Fzj+ANRWePnR+9DgCpZspoXdNuNgcHiKlknctJpm7jyFbKMdE5Q/m7/IBdl3QcAGMW0E6/HxWy3svmef6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDZ15il0Rc2UVOYIQGhdotAkymzn6tJCevRHW1+2ftw=;
 b=HxYmcDeTHcVU3eGuJECpMhX4xPl7fBndP5Ls7IbsvHLjFafnrZU1EWoosSa4wpExxDKFzSra1hePpdpi8VfR8LJ4HT8OiwLlH1Tma2ZLMLG3VqX9+pzmGe3QFqXtlgaPXXqG0tvrxFo2Luf83whpKDlyyKl/PpM53qWmYzx9eA7D2gFFYPMG47tTrU583HAZoTDEytp6OzLt4TLk5lRZObw4cVcZmPfQW2mtuNWi+k1ytgdd4JNMpsgX5hRyPBn3i6n67UoJLKAxZy4wVQjD00GIDOHqL8Lgc07EugZ4b4s5bfCcK4b0WG1jL6W+zKL+msWlQn6NMYrOCayB0cNWuw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6735.namprd02.prod.outlook.com (2603:10b6:208:1d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 01:24:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 01:24:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: RE: [PATCH v3 08/13] x86/hyperv/vtl: Set real_mode_header in
 hv_vtl_init_platform()
Thread-Topic: [PATCH v3 08/13] x86/hyperv/vtl: Set real_mode_header in
 hv_vtl_init_platform()
Thread-Index: AQHbvF8BpvqGgmHy8EKG9GebT6FnprPa0rvg
Date: Tue, 20 May 2025 01:24:09 +0000
Message-ID:
 <SN6PR02MB4157071AA31B1D5AEEF36E5CD49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-9-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-9-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6735:EE_
x-ms-office365-filtering-correlation-id: 2d475b74-b864-44aa-1fec-08dd973d058b
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6eredufKlHx3shQhUbyqdtF0VDlJFDlC6yo1f/k827BDWij15lnN1CuM9LnMcIDGUOrltMFsv+7yA77lvgRKWagUf6YR+AjhdCvA4yitS4yU+KGOGwuL/Cab0y8sz5YUajRCr9C3FeJXT2sTyh6i7W5asmtPCCXCy+aMNSs/mSI0whBlN7LTKo2zf4s9Nr9wO0+INRa+y9FpoELeumqgDcqpTT9yR2JxE1sjCwaHWf2eMY7a7jwyPxevJCRtkiEVM+R3CsJW4cxYO0UUQIVDJxZo+qmqv/93btvPJOyefWVqtF8i5SOE2aMeKWYqVdIxcN0U/sl+dBWjGH89ouE95F08f4RSaiqedMxqLhTNDx17xwKsVDlhKeMLGeZR2dzT9f/gvd2rORuzcBMNbXNp7QhbCHtE9DSxdo3+LgCTofDk0qC8iOV+7PxkSBSaol56ovVzjzHwnN3DQZhW5WhlL1B2vTl6sIoyU8Lls55b+WfkSbGQ1w55iKlE4EB9UhWQIdQuyTtURpOZ6Me7JOYhJn2HVQ2dQBjJUnl4m0aAbfKlLp6t6DOWYb3mziDNFCMtHgqJWAU4g/3TkOdIDYXtWjIh4dW2Atqd1W43KqFE6lxns7OXuwgm+Hd6BUEOYbfdyOd9Ft2nzobsy3CXjzlFV6TqLiMAFKw6k6RmpY9OS77Dw3RyUTD0+8SDlVJ8pEj+x1D7B72nJkky4OHZKhaDUhGrw4PJAB/m/Fn4fv8TygeM2ZJfHOjS7iOdl/n7mItWRg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599006|19110799006|15080799009|8060799009|461199028|3412199025|440099028|12091999003|56899033|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0BtK7ijoeY+tYGhINUWy94BvWSBBf2EwBYyQlAtIPr29ubjqtRw2PmVm0haJ?=
 =?us-ascii?Q?Ua+f7aoMTWE8RJtM2soPtTRkTtNI77NMQ8EmaEjt5tpgt3I82oF22NDLjgWF?=
 =?us-ascii?Q?qIhwd7NkxINge5bUXlnutvywTY7rqAkq/dnuMpo3M2ee/3545I/4mw3BTsLP?=
 =?us-ascii?Q?Lk0k+6PS3Fv4pUgVAxPG2dkz7K/Zv4qG1MIN32WAg848GP1NWrYynPeoVxbB?=
 =?us-ascii?Q?aiwVvLxHdDlP2162+b/NsOtHACMyyVt8KGWtE+eiCyyfGOBou2k2PuEHV34w?=
 =?us-ascii?Q?c9S0E+GzXiYqF9NpB/kP01GXABHzMYYd12Hi6Q1WhOHtoCWjohf5bIxGyd/X?=
 =?us-ascii?Q?Qyml5UGtIX/t+gKkS6LE3iOPG/Qh6s3zlyoD1D2eNU+nSyKnYk9fq7CAKz7Z?=
 =?us-ascii?Q?1UHyAqVfyUDX2SDs4tcJLb0xrwVrobfeYNXl+QsNQQhYH08glTzXVkhbxXEh?=
 =?us-ascii?Q?tQL5dxf1FWYTyP0MZ4d88aKeR40rq/MXpDvAoS0YlHhdZOhuqkrBUzAEsCqS?=
 =?us-ascii?Q?Ud9dz1BXzrjJrZ1ZiaAu8xg7V5aUORJ7i0vai0VMmxMmoYfYOVJ2bdEKHAHC?=
 =?us-ascii?Q?qWKvDo0Vs7wIWtFPcKCHE7+Wgs4QdxoIcie9cEeEH7fyg5KMOUIcBQ92i0Xh?=
 =?us-ascii?Q?Oi3NStmnXEWVJGm+oLvnohcAkBf0QNvMKoSvh4S+Sr8DneCZH1iJQ4PCWXps?=
 =?us-ascii?Q?WYic3khQiYpRdNQX6bB4V3Izb3JXF1OiSwJUa/e/3p6Dnpdj0icxyZVy0jPY?=
 =?us-ascii?Q?X0Wwg/+dxxfh0RGqAm4rxSDyV4zEZ3sFEpHnG07iJmDg76zoA5CCOYQJMPnn?=
 =?us-ascii?Q?/Pq5J+8MjIYOtCc+4BjzBXbFvP1eBxoq8UvV3vJET9+QFBc7TSpX8YH/rs9s?=
 =?us-ascii?Q?/SEOYfiRAGqqrv5U9rHDEXAob4b+RNubmBhXrfInwYPuxE8oWPKk2omr4xiE?=
 =?us-ascii?Q?xATqQipFCYs/CEa/mPJKrhRUPwMh9AA24owD+wQ9PBS1m2QyKqHlfGr3m309?=
 =?us-ascii?Q?MGC0xBf/Xm11K3foQ9dUVpxz9k8vy6+FO2dVpJKEUQmGpY7Pzsk9St052Ho3?=
 =?us-ascii?Q?y7ABEzlCEjzSs+9zZeFf0SwFxj+L13cqFJi2z2TfW4ohq7TieYg9vADJLA4J?=
 =?us-ascii?Q?E01jFHIFgk+2yuRjvJzKoRGljEdb343+Tg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?huy330hrTpJjNovRlcYMGfcY0SOhw26D9WESXedjRtWQHjV2/psF1CZbzWS9?=
 =?us-ascii?Q?tSI9nx4Ei7C4enL6ejINsONEvv2+59yowlbGbPcdT7usMaa0tBEsYkFITb5l?=
 =?us-ascii?Q?BkXTfJCVfR1MC+mr/vrba9fwdkAyj2tijOhD68Bra7+Ff5TA+g+1RcI8C/Hs?=
 =?us-ascii?Q?vBMaCtB/mkcpOI58vXDuvpn9lInUQINJk2so+RpKjr2NQan8GVmOMWkoyy4W?=
 =?us-ascii?Q?vdmlJ7W04ef/I9WJwj9M4bXdk1qK/AmcQb/oFYBtvj/NcK8XsBxh4oYVHIIr?=
 =?us-ascii?Q?8Shq2tdqDeWsHlxog+zBrHTN3I5AbZrF67/8jAPXtqstRcrR1p0PKHAYsIHb?=
 =?us-ascii?Q?EvOgTsFvT3i8BW4Sv8cksCI1uIndtulauTZgZ3NgsuUplfvFDJV2nBuGLZ+0?=
 =?us-ascii?Q?VVsTRyCQyWVTfPoH97YCR6Y769wrE16O0dkmnS7AjsKN827wC67pKv0pQx8U?=
 =?us-ascii?Q?s31nftRlFAIP3CekpKdeYqdWKHOn9kJfDZ9PHlRsEfLqCBjz0jWTWGOW2P6G?=
 =?us-ascii?Q?oHRGZfqnnOh2j2UH/BjtGNCg6+IxUVUQ1oNPpYN3j0ICJ7PQu22GuJMfmrZx?=
 =?us-ascii?Q?61kqliyH0BHnzE6D8L7Hk5h+N7EK+9yOv0ITuratxEtVIrEuSHrSBRErWYpW?=
 =?us-ascii?Q?2juywJvAHMBMP1DEnUa8mZQHmfUgCHbfVI8Me0sJbxWHqN/0bdU/oKQcO7ye?=
 =?us-ascii?Q?oJB5nMpg9EOiTuYesh9fJB+AWEcwn16YQxEb5S3S2M49K7DdlBpa3TdI51Hj?=
 =?us-ascii?Q?/iuDLZhE92CzaIR0Us70WuB9h2ALvvo8FzQ33RS07Vt11qKt+iTfUjOuXhJr?=
 =?us-ascii?Q?QLQXfap/odLjLop3LxKd+ST4Zp5DYaTvroLYUv2ipbwrPx1ZYKCqBzAoX2DJ?=
 =?us-ascii?Q?rmwcFHupEeNehgTQ3kS8GersGKEgD9WfcJfVVdTHfHFXfUk13t10UvAclQso?=
 =?us-ascii?Q?UNRPWvepA3x8jSfh8SvnWzqo2H52mFsG31Op+13FaoVOPjPSyHxEoaoNSK9T?=
 =?us-ascii?Q?jrUl2lsHMuVmrVZIJ5mQ518VZY7uNov+oyLC+959E690K5FUVMUFoZcmPaK0?=
 =?us-ascii?Q?G6jMhGxTYtW4U5LAEP/an8ZFPZ5AwRi/3FCKmvD1t6f/X9fiLX4tUCS/N209?=
 =?us-ascii?Q?qf0OQP0JTZqVEpGYaA79TA5v+l72XqmPFb9A6ZK4OrnPwnZ/kAQd5oM4w9va?=
 =?us-ascii?Q?F9nGXDh6CJNC8Y7A/DrFJ2U5wIap2VfSZ/64aYTDuGwoMYOGjkTvLKL0LMw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d475b74-b864-44aa-1fec-08dd973d058b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:24:09.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6735

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> Sent: Saturday, =
May 3, 2025 12:15 PM
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>=20
> Hyper-V VTL clears x86_platform.realmode_{init(), reserve()} in
> hv_vtl_platform_init() whereas it sets real_mode_header later in
> hv_vtl_early_init(). There is no need to deal with the real mode memory
> in two places: x86_platform.realmode_init() is invoked much later via an
> early_initcall.
>=20
> Set real_mode_header in hv_vtl_init_platform() to keep all code dealing
> with memory for the real mode trampoline in one place. Besides making the
> code more readable, it prepares it for a subsequent changeset in which th=
e
> behavior needs to change to support Hyper-V VTL guests in TDX environment=
.
>=20
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Edited the commit message for clarity.
>=20
> Changes since v1:
>  - Introduced this patch.
> ---
>  arch/x86/hyperv/hv_vtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 4580936dcb03..6bd183ee484f 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -60,6 +60,7 @@ void __init hv_vtl_init_platform(void)
>=20
>  	x86_platform.realmode_reserve =3D x86_init_noop;
>  	x86_platform.realmode_init =3D x86_init_noop;
> +	real_mode_header =3D &hv_vtl_real_mode_header;
>  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
>  	x86_init.timers.timer_init =3D x86_init_noop;
>  	x86_init.resources.probe_roms =3D x86_init_noop;
> @@ -279,7 +280,6 @@ int __init hv_vtl_early_init(void)
>  		panic("XSAVE has to be disabled as it is not supported by this module.=
\n"
>  			  "Please add 'noxsave' to the kernel command line.\n");
>=20
> -	real_mode_header =3D &hv_vtl_real_mode_header;
>  	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_c=
pu);
>=20
>  	return 0;
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


