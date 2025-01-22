Return-Path: <linux-hyperv+bounces-3742-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE20A19570
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2025 16:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CF91607AB
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2025 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971982147FB;
	Wed, 22 Jan 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mLNoTIHy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2077.outbound.protection.outlook.com [40.92.41.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31532147FD;
	Wed, 22 Jan 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560269; cv=fail; b=kgD043FgUyCX+FnRtrmbl3eUwFj3F84sKGvzz6rwhDgLoWv50XagyzeVjx4uoF9xK4ElhprrezMFOz7idvVsvL+fHTyFRnUdHTn1CYbcfI5SQ999qxYVmaQb33EUkCS7Hyf//hg3OP2Js/Qp1TEexTj2FO8seVlXehUWjT3YWCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560269; c=relaxed/simple;
	bh=7AWza94Mk/CkvTRBFMA2YT9HIugY329JBw1aFwQjVtw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zo96t6YUEK5+QMe1VSN0dGco1AWZWSjJ9mOu0OY5fghrYRbH2oRdIinjJZhdyN6sO7yXGOkhXc6RvE1NI/3EZXK7BKh4CNLcShJLcVCtTUa7dEYyz1CyRx/ghW+V2ZaotZ6XnUD5Fg8blk8kgRknhAqRu32IbMbWMSBoJzjyt8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mLNoTIHy; arc=fail smtp.client-ip=40.92.41.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBX7w0yn29+xf0N9HM49sdSM6hxUSzmHMS/gddrF9l0gtjMwwkosDvbxloSarCHImpFTf+bLOMdUM/1OXG0tSzDItLAKXwr/yFh8HKPhHkZyUZFFvjlQR1v9Tj394Fz6Ez1CHSquX6VzcHowhXhkz8M13Hx6nAt6tslDxXB0lTfhU628rBVkr419hgPYIMHWfzD2URw4V3PjKfQjpBSaNYDzggfI94Vy8FBJOjUBmORXheZt5qoVdsnhz8iwGwaoWPWHK5YeKCbPimAFxwx1VhEY/oo4v+jPMXSCjnZczw8CvRyRo/uMtLR6YDdd+Cn5KwNtxVzr2bGHjm1lrLRQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eExs/rZxi3mwlOucqcBBqHf5+WMQM+DtBlqNurPE4DM=;
 b=DBJmxoDTkcQhqYoqXa0IzJ6ED8BKzZBTvgTbNSymTVIhcP4bem6fIp0C8hWeQ2NVLIQweHyvhWvaLkh5EM1NCZFdbiU5KafrL6ICEb4XJvF9VZM+dj1O2n+mDGpKWzF8CiNYnWlpun9mWAsk9FRlWhBWlMk8MHAs1XTH7gzOe81YxplMX63zqw80R0INSiIbuJGBBLT0BK9Yu3JlI1Tj02EJv6VTOT11ztbQ8cbt5rlIRhlbeuMgnKSGY503AzfmLbP9ownqSrUXdzitb8ctVnXxKaw21WPzoD0iTO+EjFXnH3N6QnBI8K+HeRHFCjfsU5VVUhFjpbOznLS3OVP5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eExs/rZxi3mwlOucqcBBqHf5+WMQM+DtBlqNurPE4DM=;
 b=mLNoTIHys1TaEC0RDqq+VlBRVaXBM8QmXbjFtANFyh1rkbE6Q45N+Dqg+JIf4bC2JUqBOJs2F0nnmb4ju6scACLl5zwBG+lhEfncc7MBkJVMXr86dVB6X2GEUsD7kufnT0igVVyzJB8DNV2YNgsHk7CFHFGQi3F/c9fTeN/NmNh9FZ6Hgxe/MRs1arIUMbD/5CV71SeEMQHkmoSzlfD5r+2z1xuO2nuy1AIOScZktGjUojjuNX0tZwNP1CJoOwB75SvO8eyv/HselqgYD7zgCXuc+axfQBJBk5pl+F00OkkAyHxP+fbptddF4JEKICBlitKKeNnUZsISfrHwYsvBhw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB9998.namprd02.prod.outlook.com (2603:10b6:408:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 15:37:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:37:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] cpu: export lockdep_assert_cpus_held()
Thread-Topic: [PATCH v5 1/3] cpu: export lockdep_assert_cpus_held()
Thread-Index: AQHbaR8W79gP9OwDa0G0XlP9VsSgvLMi86pA
Date: Wed, 22 Jan 2025 15:37:44 +0000
Message-ID:
 <SN6PR02MB41574DAE9F22C9D67D66B5F7D4E12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB9998:EE_
x-ms-office365-filtering-correlation-id: 68ef10fb-0616-4ba3-155e-08dd3afab73c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8062599003|19110799003|8060799006|102099032|440099028|3412199025|19061999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H2W033YGgzIECAjWbnQSuyPx6lEJaYhDWZZ7MlkEoZQy7d+x5fVBJldyh0K8?=
 =?us-ascii?Q?0Ns131IGfoAfNwciAL0b0rkKTc5fURla5M3HhkhP2i2LSbgXo32NO9l29Dos?=
 =?us-ascii?Q?XeK3DfjyJKjjhJPxwPQWr+L5G6hL6beh0oOpmdNhSwhzgtCG7QN5F4s7Z5aX?=
 =?us-ascii?Q?D2dB0znYv92M39cVDUsMSQQ4HmNuz2v0B+WBnOHQUek08AhsF+zm9oJxQAmt?=
 =?us-ascii?Q?1jnpSK7vrhoexC5/Gh/9KIAd5QzJtlHC8VfTU+W6QXBwoYBlHF/ZZ50B1npg?=
 =?us-ascii?Q?/rKsjQTzbr/oAyUx05W2UCO6mMTuzi+PKAifZ7pr9puuBTKaYJmWBf82pfJ5?=
 =?us-ascii?Q?Ijos8uisIQuUJRUyprl4pdA5qoHYBoYTiVxzw9gqPi8zHPt45r8VaeY8Tv/3?=
 =?us-ascii?Q?lOGiBMEsvbHV7dcDRhlCZUYzdfG2z3oHJkPecu9eWb5WCaxYZSzq/pct9Hsy?=
 =?us-ascii?Q?t6lBaIie+kjGP7aKHSA5ffiY417op3APloemya/bBDfTZQCr0pSMcfasUIlQ?=
 =?us-ascii?Q?8vZbCP0tpP244hlaGHLZ9ZsHjaoh4PXsSMKyWe3urJx32ryKPsromG3bQrDW?=
 =?us-ascii?Q?qlKt2V0ipUFw2uGGdueFTzLapmLyAkz7RugahEe28yBILnyJthQwrRJEr6pv?=
 =?us-ascii?Q?iI/Boseq+SyitHrA3JZ1BkTry1Uqf2JikROzp9jB+/ptDTEwxmvBmdt7iBXG?=
 =?us-ascii?Q?9eQGinkKyh91hj2ihkNaikeY6FUQ8vELLNsZ1hITqyXCzxZPgsZEs9JSnCpK?=
 =?us-ascii?Q?sFOCz7N7xxpUyxY6q+rH96yvG4tIfdvcRLWQeD+c1gZXRDDPU78Eis72puNk?=
 =?us-ascii?Q?8j/Hx1F4bol8qmteiJbiH0De727xU3yrKUJjcDZXg1UQkIK8soOsLCBwP/Cn?=
 =?us-ascii?Q?aqVVtyIXHfG3JY5qdUdAr6SGTVr+gS37gsdN+xHUOxxYjTrqpg9+oIWdxFMQ?=
 =?us-ascii?Q?PWuVi9NnOBh8sdGdicCQTQPajOXJ8zzEBQQhQznPhzS4wvA+qHJXOY3/mNxw?=
 =?us-ascii?Q?APcNXj0uIzk8pOR85DStOqlXCjR1RXL2LT0q0LENHZ7902Gygu1BoUjRVMI3?=
 =?us-ascii?Q?ecUkzd4TwB+7zJxNElZMlQX1ybTQSg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tobdE9wfOmNEzm5pFYyvRvkpNrHUD1CQyILjIAHat9RaJ7Cb3oTQl9abes92?=
 =?us-ascii?Q?XEdFPVz7MJWfX/+ITGiwhJHJdh35D+dRKr4611ENjAyTJ2iC/A+K76bFmBjz?=
 =?us-ascii?Q?pzd4n0cvQQ0CaWTZfPB6VOlNZhna0DyROOrVF2D5qLsYWwd1Fp2tIalQpeO8?=
 =?us-ascii?Q?q7KH15zAxd2+IXzmzPvnpHrvI7Gs7PbMrm8qfWcIJspHOhOrAvoUwG9LsFiZ?=
 =?us-ascii?Q?pivLT/n6EitH4b38zRsjhrto3Yzw2MSD8dbsw8Oa2jDPMzFFHhxOYZWYOYhY?=
 =?us-ascii?Q?0rz/EtCuovlsJbOVgnH1PbyqDkgAzfoDX8PQb33X0M9dQF1eX1OnVQbWtOr5?=
 =?us-ascii?Q?AxFRMKuakS8etFUkljSR1UkCPKh0frQZSHB3Jeb6G/+OkaDyf3kRmG6Wxlzw?=
 =?us-ascii?Q?4ve1dHkrahAPjHPmx5iXlF1Mnf+FBfiiM3djOpWlCVr1nJd51JFdLoDq+Xhf?=
 =?us-ascii?Q?Pq+0EfRlC3rQyuxms6OH6kFTIxk8XipOeecihT9KYI71f0tsykkNimNrYBbG?=
 =?us-ascii?Q?Va9pDVEiGndlEbbfhtj+TZesYOvqrLnbu34wRiA1CVTosZKBsAyMUeqaeTSX?=
 =?us-ascii?Q?h0yKTtRbnk3kmeSoPwH8f0MzhERlxA0r8X0bBQmIltMK+r5E4wQfbOIsopLX?=
 =?us-ascii?Q?uYqxUFudWEs+Jpygw8FX+Fot80vsK5bNfwZlIVqhbsqOUf0qLeAF7FqCvpMX?=
 =?us-ascii?Q?GD8Txtr7zuOCoSmEvUxzjCeRr3PaBwOLidsEioTpsSTqBrRKglwZT1eOdXbi?=
 =?us-ascii?Q?o3Uv/6Q1tUyGIcH5oZCYst9pLklByt4G3glguk/nB+i31Daiydd5AoaQyWbO?=
 =?us-ascii?Q?C+YOyfNXLiBdeGka9yfq6UFx3OVVBahADZZ769ZvaWtkPNPNnnZ8n9O8Pfts?=
 =?us-ascii?Q?1/GTjy15M26azt4fE/NT39ri2wSLSgjyGlYqwU8H+jr45yNxYUo5q/FMAub+?=
 =?us-ascii?Q?U+RRZ2T/EBFdOe37WZLXZQ55XQgWBUeUhW0jQ3hOMRZF/nV1s8e7oB58SCud?=
 =?us-ascii?Q?GdF7etu/F6dIjlObBjQslyh4QDWY1sM6IsNmLcAKU49IDHaJtu2xaZ37Xr+K?=
 =?us-ascii?Q?Wq37FikuOeH5o96IpBs9TErUnPr86wkS4sg7m2rTvE+5ej+9Kv1ZtWcOyRFh?=
 =?us-ascii?Q?kVGY4429gViq0REzxoMRvNqcsrflWdEXB2bHbLXnZsyaarDt7hRNiCub/jsH?=
 =?us-ascii?Q?R4xsLPxTRChW+CwgPEGpqDSBL3qXHnGShpy9M5rB98jZZoQotgi6wEUZtH8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ef10fb-0616-4ba3-155e-08dd3afab73c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 15:37:44.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9998

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Januar=
y 17, 2025 12:33 PM
>=20
> If CONFIG_HYPERV=3Dm, lockdep_assert_cpus_held() is undefined for HyperV.
> So, export the function so that GPL drivers can use it more broadly.
>=20
> Cc: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
> v5: new to the series
> ---
>  kernel/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index b605334f8ee6..d3c848d66908 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -526,6 +526,7 @@ void lockdep_assert_cpus_held(void)
>=20
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(lockdep_assert_cpus_held);
>=20
>  #ifdef CONFIG_LOCKDEP
>  int lockdep_is_cpus_held(void)
> --
> 2.47.1

This series should have been posted as "v6" since "v5" was posted on
January 16th.  That notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


