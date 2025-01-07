Return-Path: <linux-hyperv+bounces-3592-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B5A03417
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 01:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96AA3A15B9
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504AF208A9;
	Tue,  7 Jan 2025 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p2Bo8o8G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2027.outbound.protection.outlook.com [40.92.19.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763151372;
	Tue,  7 Jan 2025 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210352; cv=fail; b=k7I+ddfeeY+SJCB4udQwsrOGe6TMll/5aRHOACdxEggJdpM0kzUqfEoA7ooG1PuDeBGRi2JUNTI8cnBB4TPQVbUC7KHdK+AN/rZOUpPWf+q6TGedZRTMa9q8LWbW2/Q603gx947s8yNqCMFsh0rFPNGhMPkZ2gZ0+fShy68lvZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210352; c=relaxed/simple;
	bh=bw7+i1UD0MAfvOfopIzB6rhAzNoqQf7IuyWnTz7YDoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irE5li+LW9dsKvYpwoFQqF4vI8ygb1wxawzsTJS6KBWPwAVvVRH4Ttnyadd8D6WAxcyTpDVeMb/4pJzkGs3vvfXblVYKuaYE1hV+nv0+uJwdUZ9SLbesJC4YPyVFoJ5PuKltLCZo+JJfpFhs8YsBuOtyd2ArWoPszXt2K+dDO9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p2Bo8o8G; arc=fail smtp.client-ip=40.92.19.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrZbCWdhVRxR+8IcTYtnDp20KKdPvY3ZwU4pyPjVofCd9gt4/MlBnO7UUueI8MUW+r+SmLopXIlarU7a+QRn8LEi4xKOHn79v0sJbrjz4Tcitp/T1sEDV+qqLQaxwF3HPKknYUEUiqykVqyurqBfXMUooFMEcSQQUP4J5XPpdwauZ023QNavW7k7h20CCtjBvaq39MF160hjLzPZpa/nKf2aAddl3TmCKezFVlOcFXySDf0yXkHg7y5VaCOUTC6AitmekdHL4yLUZRNmS4JY3k+z89ZRziqwmxx5TKsRSWUUN828npkMX6o2O7FlLFgdgVxtZBi35c9mJo89P2n1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mesu0LbCeV6mBmBxuoTj6NiNbLg7DWd1qlAy8D9CJkw=;
 b=FIirwuQz0NSkjf7gqBREj7qfgZs/dWmOeUiUBaWYABFp8PGdPXrX1N5SV75Bkz/WnKSq6oUzULHko5A6mVTT6/9G0Xey4bCtIrCtlCahr3VjbhADFC4GQqKH2T0HmZLPqKAy7F/XNeK8vBS+mvEdxhnOYnZPdPaeIYZfHRuxa8TNpOPO3H+pqXX6guDnQvVev9mD87M0ot2UDGzBoZg7X9IJVHdoRsm/vEDU1fHbx3eLbUO6IBEoy7QVMZxb+2rolaCvRwKuvnFSnOTy3e4orRtsbEDjEwClS+bCmxzRtXx/pLigtI3cXerFWOpaNFdyr03CZMajFyq6+oFE3z/lXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mesu0LbCeV6mBmBxuoTj6NiNbLg7DWd1qlAy8D9CJkw=;
 b=p2Bo8o8G7sQenMMM7W+Go/lH71VUYYolm4k3fV170rfE9eOWnZVShlTR+EeDAB9AZTxflwhfWT8qvBNWgtIeixk19DDqH/ZilrA0wU7KvR27MmjuscRWzEZFar6S0FT9/lVJtOEJVoMwHYtIzJCxlu8ZlOmTLDyCEbqjJvymVrLSzuK+mosi+PwSG/w4FCZznb8FgMW3dBjlIHV0EZoP2akou4rAuuiIXKdPorg/nCIIhNI7tD40NUmfAEM+niHv0rGxXSEQ27MJdahqq8V6iwYXXwBskG0AW8H0DSybH1Ue/QAI7wuTLLgYfaWq2nhRRtUt7CyLyOLnNJj9h8V6/Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6788.namprd02.prod.outlook.com (2603:10b6:a03:202::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 00:39:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 00:39:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>
CC: Allen Pais <apais@linux.microsoft.com>, Vikram Sethi <vsethi@nvidia.com>,
	Michael Frohlich <mfrohlich@microsoft.com>
Subject: RE: [PATCH] hv_balloon: Fallback to generic_online_page() for non-HV
 hot added mem
Thread-Topic: [PATCH] hv_balloon: Fallback to generic_online_page() for non-HV
 hot added mem
Thread-Index: AQHbXV7cvnO7Py2wZkeJ9HBbRxUAs7MKdfdA
Date: Tue, 7 Jan 2025 00:39:07 +0000
Message-ID:
 <SN6PR02MB4157AE0C00C9EE805A78D8D7D4112@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250102213940.413753-1-jacob.pan@linux.microsoft.com>
In-Reply-To: <20250102213940.413753-1-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6788:EE_
x-ms-office365-filtering-correlation-id: bb3b1404-182d-4c3c-97de-08dd2eb3b1ce
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|15080799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nOZUSVDIemlYKb1ioGdEbUTjZA4sgRq9FeLoG6fI+pZROEWRzbXybWSF9zc7?=
 =?us-ascii?Q?2v16pLpcx+4P9tDHDVk1k4KbLMkAlQKny57Mi6IB6HPn50YvwKqW0CxaIoIc?=
 =?us-ascii?Q?6zGA4UOSAzwbAy8zVZttDSTtboo2oYD5dC13mUXrtr39Dqd0JVgXKSmVUsjp?=
 =?us-ascii?Q?iggl2z88t1rIOguuLJFySUmS7EWoTWhDoJtjLv54m8U+MqXuWlnRwOw3B/E2?=
 =?us-ascii?Q?/sWPkHrwREe2nqeJVT2SXzCFd0CJyEG/4a+E20AybC1Z161f6JJI762cJp5B?=
 =?us-ascii?Q?cnXwKnjwp73YQvO5Lr3zNKmHXuSd9z1OiRR/W7HOV8X9TLktjgHgXi4hQIPk?=
 =?us-ascii?Q?uoSbfmOE2SRMS20Xy5ADzUSgOBNxSuHM/TY0PY+7JkcULSksL6BWV/6mlqqK?=
 =?us-ascii?Q?NLtpyVD1rdXnFR4C4InOwUygj5rgMYz9oVp+tdcyXvYN0CT61ozdLz6MkZWP?=
 =?us-ascii?Q?eGujZJ1qBAfK1dDYrtIfU6msFfvIqENAvlz+oF+eguNe7j/G/ogP+GkeUFZn?=
 =?us-ascii?Q?SFGfo+C2RCaC7HKgWBqqoToqbAeIGu9pNeNBcHnJQkqQxJ12JvnagnvHVBy7?=
 =?us-ascii?Q?f0ig5NdfqIxOg23wNdZDQ7NJH74STidYiTLpaMFBrjQet/DWMgZoqROGq9B6?=
 =?us-ascii?Q?C1J1uoE/HAjNj/Ttk/QxvZ66SLBv84qoyXhcdTMs8Wjs40/QYuo4AZAS6L4b?=
 =?us-ascii?Q?N0g5qlZPBDmizmzNVwZBmcJiBAjP8pj+LNuRk+1M+vSdAG4ypH7cYapXPrPD?=
 =?us-ascii?Q?1kphCFpEoSqHRMJ3bIH/dlWuH4R72v/kCF+QjyMVImJvVk7NK3Kgv20QbVHD?=
 =?us-ascii?Q?EElVk3Og7Tkan9Oet3ixtugtnmNZd7KvTtEItv/0dOwiEE61jMX3OaxD2L3O?=
 =?us-ascii?Q?X+zvWQE0CLrM2LP9DiCh/HPKeP1ClbREjBCP6knxpBYpNS+fRaBTZYQWRWRk?=
 =?us-ascii?Q?KTm9xonLyf3vgnHkp7dpu5jAh4qV5/EO5G480cU2Ea73FC+xy1dkeVQmbbQh?=
 =?us-ascii?Q?31m+Q3LJyWT/cN0WUmbTRnmCj5HnOEt8bMn6EA63J2tHSo8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?74BYLefMDWEqunYKOyK3IA8kkF1+093zjg2KehfYgjmppauZ9RDcgMQgDE/N?=
 =?us-ascii?Q?Uzk7gwclswZC0unPuDW+w9rHQzSEuNe3X1Yte+lpZ1ypsxAwShLfDgooJsre?=
 =?us-ascii?Q?Cl6ZIZIcfoYX4szNLBGGSm5ZEY9CezKXtK3jq1gqF+EJwmiV4mSr/xpkalLh?=
 =?us-ascii?Q?bnsvf1WOjBFZsjF00097XdsvNrIiZSVZT7iPCi0F+NEskocVSs2Z4zfFMvQ8?=
 =?us-ascii?Q?oJ4jcAys/lIhqkOMzVN28+0u1ktEbAe4waNRchDhQJC5Ofjmcpz3Iai9KBlL?=
 =?us-ascii?Q?TQDVDXIczs724XZM39jXXj2LioLmVeWt8Uf5kbFdEJqQ58iAVOevCIHoy3To?=
 =?us-ascii?Q?02cd2/P1uRc+pQuCEFvP7fRzsrBQ0zRl7kMY58URTPT8qg83c5p6pPNPpykG?=
 =?us-ascii?Q?U9v7Fk05CjLC8yXGEd5+dXzwptLyVVP2pVhN8zv859Z2tN5jxgHtBANEiNj8?=
 =?us-ascii?Q?Hv+QaZFryJEjGniwO+LFBF0nfDo6FFLyq19IW0e+dEbqUa/x/qBG4Jxqsfy+?=
 =?us-ascii?Q?u04UkPLT7F3rMO2T09a977YU6+lqyCMSyNKF5+dJAsN0RTTgIGA1tLAy+JTx?=
 =?us-ascii?Q?Jx820skdUDYwl6Rvm3hEYU7I3XzzSPE5yUBZYBkwJME1YbzMkHFFYQ5NE10m?=
 =?us-ascii?Q?qHaLGfV/Wrwu5ntb2BFmn2yKzOX7n2aX5sYGlwEouB4F+w7g7hBNdwnLwWCq?=
 =?us-ascii?Q?ixF6ug0hqPKTOItc5A2zbmbmCU5NEu0B5ycjx/jSd4vf/8po4wAZe1gXoNPq?=
 =?us-ascii?Q?A7cVDLfGa6Ig4rFm5j0f/ejC8deDl24klfBup7ImbIpL/sevsIdJuNWiPWEA?=
 =?us-ascii?Q?qfs4Vm2QHFTN1rbRhx0xl9BJE8jlumqQgJYvZ9qunD3AUNaztgSVemsGgpag?=
 =?us-ascii?Q?0z4hLQ9AqSzybyGoYpPE0Hquvdvs+NPIjw+fu5OHD4JNRtYAC7m6cSREcMUS?=
 =?us-ascii?Q?dsFFCWs0x8g78loi3J79NnPjbDRB4Jo8yFDghdxmhfyU0L2TgHvAcVU0Z7VH?=
 =?us-ascii?Q?rdcbH7hlFQmE//W9mpXoXFidPgiA/L87OVG3H9dQAaCqHCufpkwCiL6nS9cO?=
 =?us-ascii?Q?RmfEXNIviyybDcenVJn5rX3mItoRtlpWHfxQmUJlJqynU4Rgbfe3luwpfaBd?=
 =?us-ascii?Q?MFMHrpQeOIcAEi8ZrkwGobpOfm+IAG0UJUkjRZG8JOWoxqCUMNesryPCoqaT?=
 =?us-ascii?Q?wJTcqXAGYznWdotpYggEVm2WfozwzSqYSjjfwXQqLmhWwgQyvzCtHqaYF0s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3b1404-182d-4c3c-97de-08dd2eb3b1ce
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 00:39:07.3149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6788

From: Jacob Pan <jacob.pan@linux.microsoft.com> Sent: Thursday, January 2, =
2025 1:40 PM
>=20
> When device memory blocks are hot-added via add_memory_driver_managed(),
> the HV balloon driver intercepts them but fails to online these memory
> blocks. This could result in device driver initialization failures.
>=20
> To address this, fall back to the generic online callback for memory
> blocks not added by the HV balloon driver. Similar cases are handled the
> same way in virtio-mem driver.

I had a little bit of trouble figuring out what problem this patch is solvi=
ng.
Is this a correct description?

   The Hyper-V balloon driver installs a custom callback for handling page
   onlining operations performed by the memory hotplug subsystem. This
   custom callback is global, and overrides the default callback
   (generic_online_page) that Linux otherwise uses. The custom callback
   properly handles memory that is hot-added by the balloon driver as part
   of a Hyper-V hot-add region.

   But memory can also be hot-added directly by a device driver for a vPCI
   device, particularly GPUs. In such a case, the custom callback installed=
 by
   the balloon driver runs, but won't find the page in its hot-add region l=
ist
   and doesn't online it, which could cause driver initialization failures.

   Fix this by having the balloon custom callback run generic_online_page()
   when the page isn't part of a Hyper-V hot-add region, thereby doing the
   default Linux behavior. This allows device driver hot-adds to work
   properly. Similar cases are handled the same way in the virtio-mem drive=
r.

>=20
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Tested-by: Michael Frohlich <mfrohlich@microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index a99112e6f0b8..c999daf34108 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -766,16 +766,18 @@ static void hv_online_page(struct page *pg, unsigne=
d int
> order)
>  	struct hv_hotadd_state *has;
>  	unsigned long pfn =3D page_to_pfn(pg);
>=20
> -	guard(spinlock_irqsave)(&dm_device.ha_lock);
> -	list_for_each_entry(has, &dm_device.ha_region_list, list) {
> -		/* The page belongs to a different HAS. */
> -		if (pfn < has->start_pfn ||
> -		    (pfn + (1UL << order) > has->end_pfn))
> -			continue;
> +	scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +		list_for_each_entry(has, &dm_device.ha_region_list, list) {
> +			/* The page belongs to a different HAS. */
> +			if (pfn < has->start_pfn ||
> +				(pfn + (1UL << order) > has->end_pfn))
> +				continue;
>=20
> -		hv_bring_pgs_online(has, pfn, 1UL << order);
> -		break;
> +			hv_bring_pgs_online(has, pfn, 1UL << order);
> +			return;
> +		}
>  	}
> +	generic_online_page(pg, order);
>  }
>=20
>  static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
> --
> 2.34.1
>=20

The code LGTM. I'd suggest updating the commit message along the
lines of what I wrote. My descriptions can be a bit wordy, but
hopefully they add clarity on the overall picture.

In any case,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


