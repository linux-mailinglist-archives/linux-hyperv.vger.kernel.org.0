Return-Path: <linux-hyperv+bounces-3662-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE7A09947
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 19:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED45188BA99
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DF2135C8;
	Fri, 10 Jan 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AAjTK68N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010077.outbound.protection.outlook.com [52.103.2.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3181213E77;
	Fri, 10 Jan 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533364; cv=fail; b=chHdm4YPA+k1mO93dElq18IXH2kKdJMjkziZtFEOXtuAdFrhU8ObVdp6rNsTVFj7i3zbj6uQrwbgf4SG9c620ArC4qhT7J5ntuau4iKW2Oj55fpnGCWmpfMkcxsSy8bb38nNtuRmyWGnx2X52QYp+u8RTlwy0oxcszF2bSAJ3B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533364; c=relaxed/simple;
	bh=EMu4zoHUDZtnVeMjFBsjoftAo1JJ/SbtE8RCHmZOVVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgRWvMGFVBOhS5jSi/NZygieOFtR1OUnUu3mB/Pwaxt9cKRXAPQKvLKw9NM7FSNvbSEDaFFkatJXBEgmiIf9TnNAESklIki7U+abP0GfYavAJKrWohuGBOTXM8g3vYZGXI+eLB/2GNJGfe5dZLIqAg/dneNAJAN3ON7cnSA9/8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AAjTK68N; arc=fail smtp.client-ip=52.103.2.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHuBv5c0zrhw3oekWpQfODpQCYVI2q8aeOkHxe6as7kswcj0okmDuKw8Ynx6+DssNrMYaLfeGBKaHXXIm2SjHYf/6mrC0tQEcl92OD5qe7R9d/kzndfXFwQGMpGq6azLZzGw84b7y+W0s9NLyvTrQYg0fWgteMl+2UJy8PNG9NNxhR270c4IuBJ+7B1a60Bp5kQAnkP9cCxvsppj7lE+SEM8y8T4nm6ZMGhVf/y6lbq+BMVgrYlwpuxUSazr5xJeBhDd2lUNNzuEMczdxp5gEb46pBjqOm9F0JYosVAerrLq5JIl/QVJxTRu+1fb/F5pf1oL1197TG6BlJ2c+1MKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHOvG1S0f9Ev2PimMw7YkrhiEtew2PFdG7INyLPjFks=;
 b=krdqZzQYk/fiYK2fPbyDUcY79UCJO9HNthL135PMoOHNIWvE77h9DYNflgu1ZWEqpbS7dmTwLsHKH8jHuFzgYlvrxAW8zcd3W48ulGDTjQ22zDFZlQHeXvYtWYvpg2y6UtkwqJ6Xw3bcM/c7s76aU73rOgQaTjaoly9vsi9CdYxSZgVxNRTAgGlDoNM5ql+nAbUo5MLokryV7XxpcSjycUnQaV3/F9O5BaFvIVehCkRw2gx9NTpnOIphw3AUGFXuvnyXD0i0DrBrwwhiZVTg1L/8t6TEIxcsT2IoTq4XRvVN413ykbnZnmfpPPFxQh5pPjdMpp1IUrJSmW+vxYXv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHOvG1S0f9Ev2PimMw7YkrhiEtew2PFdG7INyLPjFks=;
 b=AAjTK68N50Zs57igmec963jKSTCgF6zAEZXu8gWg4uqpnFWLZKiDXO9sgNVQI0vVbybY7hy/SuQOTKVe7u2AGRhZb2zwKZ5kuha1tGvMtOd6/q/E4jibHIjqrFT79iXKx+wUvQM5ptFjCN7rOVcFUv0ijKTEpL/S4avLcm9SqyNd8hIUS25RjNIk6SEaAFf7qFb4vGXtcLvadbGBB+Nlj4LObNghM7DnOXzQQU7PZ/F/YOzGsD36iGTzwTAL7aYDQAIJ/gj1rsordhRHVp5vDnImgsMtoaasRke35xPCJ710yPc/zkv1RfoglwrTzhHyI3agBNaFlOsFto8gK2y+vA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8175.namprd02.prod.outlook.com (2603:10b6:408:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 18:22:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 18:22:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Breno Leitao <leitao@debian.org>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>, Hao Luo
	<haoluo@google.com>, Josh Don <joshdon@google.com>, Barret Rhoden
	<brho@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v2 PATCH] rhashtable: Fix rhashtable_try_insert test
Thread-Topic: [v2 PATCH] rhashtable: Fix rhashtable_try_insert test
Thread-Index: AQHbY4R22n8scAonrE6mozAIuLs3n7MQTEjQ
Date: Fri, 10 Jan 2025 18:22:40 +0000
Message-ID:
 <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au> <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
In-Reply-To: <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8175:EE_
x-ms-office365-filtering-correlation-id: 97f2b04a-e39b-42e0-f59c-08dd31a3c494
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|461199028|15080799006|19110799003|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EBgjy+vcsr7bfXr8yT2UUXeX2OjKSsaeKcEEn1vJmG3Z4wmhlh/zU0xWjLru?=
 =?us-ascii?Q?V71QFQyvcX1/ekbQpDi0kAM8OO92xKmIezIpgA+8o54TVQRGQsEs97qOKS3C?=
 =?us-ascii?Q?Rzh99RySJQaiVr0wb4eWMF0P8vAI6WJEU+P074zojIQELx3Ey653HkGzxGcu?=
 =?us-ascii?Q?6jSgjiAs3s/1sRQAhSCUZkSpxNUKgQRj48iR8A/8/qJYsn7yXwdK8gvOjfHC?=
 =?us-ascii?Q?4gQphLhXCPfgnErsGmn7MeRQOkZSzOWf4i5Ro8kxMx4BZLQhMADCptlaHOCZ?=
 =?us-ascii?Q?rV3/q14wc0B1vZ2i6oWYANM9+72vH3XE12TcL1cv8unpVtqSFMfi7qiVrend?=
 =?us-ascii?Q?bPLM6l4DnWofKdbLvUnM5pGX6tl9cfhtAQQ9Otj2oHIkTET4jMxBY1g2iRhl?=
 =?us-ascii?Q?Tp7zXDDRMnwA6KPZ4c8O/Ap7TdfAYW0KNHalY7wKmwjW5a78nt48HafeOREE?=
 =?us-ascii?Q?9DxisO0DUabm1yvscxhs6eRJrqc+kN58RhqGUfOJZFN2hlQ44iYshVtLRwcH?=
 =?us-ascii?Q?LSRYadMSQOl9kVBISIUa5M6Rb9PHhJOD2CpxSSgraZG6K9lU7A7C2yYCrkJg?=
 =?us-ascii?Q?1KNm5R9ns0X6Z82VAADD+Fw3RS4i/wwIQtXTb6giPzKgNOPRB4ao2ftjN0VB?=
 =?us-ascii?Q?N7Qrg4q4Egjf89dfc3MSa0WPmDy7SMqO4ZW3AGwoX6zqMAdx9Fndec/u5Nbq?=
 =?us-ascii?Q?rAFENSGZmPETjMTq9xgtmeAkvlvIfe1gu6Qj0JcXllrQ5dBrHSLLIX1bGZJR?=
 =?us-ascii?Q?56IhWgxqwVNK73ARTaE9+94+CBhCwRWvf0o5Q4CRE4GKLHQ56jh2WlKBXplb?=
 =?us-ascii?Q?6oiSVuDT/jZOEeevMf1pcuUm+VDMhdKNox2W7inaQPlzuAmSptQFCSAl/Owr?=
 =?us-ascii?Q?Q1MJbH7uPSY3pCMj5n0jFMKnQEtADPi+MY2OLG4NobE1lt4azZoQW3SbJBkc?=
 =?us-ascii?Q?Qnw1HD1QREHNPo2iRLtwGvY8zd2vwQTpdGXqtVw3zYIFhG6rK9XC2Y841wBx?=
 =?us-ascii?Q?X2yQpHaifZGcQ5l5G0O4lrZ1vTyrXgdPgYpJ6fd1ewDhFcI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X9PjO6Il+gnnpFgfwibxAOYK53G6IiJuFOxBWZ4NADkyKDHh0d3wwIx/eRvN?=
 =?us-ascii?Q?LadSarQmCRz3qfXlIH0l/yKyjv7EzRaipeX3H7Z8+ovd5AnB2oIa3pEBHu3e?=
 =?us-ascii?Q?uxsZM/25Qiy3FGPTBfe0ggKwhCmAxTgHeXIAJbry6lRF5nE1KByJFHRoEjQZ?=
 =?us-ascii?Q?yWZ1bzxJwlU/9T58rMeA/ptVf3bmO3tE3gyEMYkE6Es90nuxr48hPFDJLExs?=
 =?us-ascii?Q?rbTnhX5ooNS/GTcP8gPGJwXmJiGzXHa2FjPmPZnNYfeMMXhr6w7Ad0XSgCYZ?=
 =?us-ascii?Q?Ub+grhcEuOBSjxc6qtUHsmChh+hSM1RDp/VkCTOF7X6xAI9HT3rJ3dlr4K0k?=
 =?us-ascii?Q?V7GUX4c7bUxpIKABRhC9gIAvtzTGsRGzeS+hlRGyX/4Uq5lZ//yUjzIwPFG4?=
 =?us-ascii?Q?2gk4SfjKcEWQwZle0w3dSJuwbbzGTvLhFElPUPjwjiZa+EqaR+wr6uk2njrU?=
 =?us-ascii?Q?ZwLGaGnTMn48l11f/FT0hrD/e4UR2KH4Fxd0j5hfaNjC8vW5JXEFTlxj3Mub?=
 =?us-ascii?Q?n5W+pGMdRKj18VvUIg/B6fep0loDIPvTBkgSq8xc1LcjoLdwjnLPKV1AiK87?=
 =?us-ascii?Q?3i9OqzJZ2cIVFYcoi0Gw77qU9m3ORxLcM9IuRX6XIte0hE78h5eRfqA9cc7V?=
 =?us-ascii?Q?6pLbTSLx3U9vt6QR8otlKflIVuZkJA9OfJl22ZRrMiZLlX80NuuM2xDTpDkB?=
 =?us-ascii?Q?AJCGpQm3SeMynJfavH76RFKj38k5s1w/9/nc/edFoWhuIJEPcEdf30YUGW67?=
 =?us-ascii?Q?tkxVXtP8N9U6ru1dfT2H+wqaYvxbd/tWuKWNz5UvC2/jdtxbaoIF6SadJ1++?=
 =?us-ascii?Q?74mbFR82pK3y0NQzOm0zm+0hUBxt+dYQT8lydIkvVNA/c0Q8vJTFb7LGKO4h?=
 =?us-ascii?Q?UmKr4j6pgHpU4eYkPiPsOc0RmV4OEiQ8d1p7ibOkv9hFchkkloSqI78zBrXN?=
 =?us-ascii?Q?kVrJmXytmDn0i0P9Zzl46vt32j1ncWFkIBRDZNoDhOSsaXqB25KlcC8/fjXW?=
 =?us-ascii?Q?MYxrdK4yQT0zVRWyaofpPOSf+jbtc/VVdn10NHuaw+WDkOv7V592Oa9yz+gh?=
 =?us-ascii?Q?tlUoJwaFZGvQy3RwWDBw8l3ZOPQqVRrrD5iiUNeV9Fr2zRgDIXoTfZA5VN8q?=
 =?us-ascii?Q?BtmQpF/uRuhMepufvyBNhIjW9sbYJJrywMUT1PZ7iajRUswgU7HrhxnQ971w?=
 =?us-ascii?Q?KqjCOggOamr3Ve+mijaKXlzrnxV7j7+cyYc0fUEVgszl7R8mosr6mLxZVOM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f2b04a-e39b-42e0-f59c-08dd31a3c494
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 18:22:40.3605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8175

From: Herbert Xu <herbert@gondor.apana.org.au> Sent: Friday, January 10, 20=
25 9:24 AM
>=20
> On Fri, Jan 10, 2025 at 04:59:28PM +0000, Michael Kelley wrote:
> >
> > This patch fixes the problem I saw with VMs in the Azure cloud.  Thanks=
!
>=20
> Sorry, but the test on data is needed after all (it was just
> buggy).  Otherwise we will break rhlist.  So please test this
> patch instead.
>=20
> ---8<---
> The test on whether rhashtable_insert_one did an insertion relies
> on the value returned by rhashtable_lookup_one.  Unfortunately that
> value is overwritten after rhashtable_insert_one returns.  Fix this
> by saving the old value.
>=20
> Also simplify the test as only data =3D=3D NULL matters.
>=20
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedu=
le_work
> outside lock")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index bf956b85455a..e36b36f3146d 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -611,17 +611,20 @@ static void *rhashtable_try_insert(struct rhashtabl=
e *ht,
> const void *key,
>  			new_tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);
>  			data =3D ERR_PTR(-EAGAIN);
>  		} else {
> +			void *odata;
> +
>  			flags =3D rht_lock(tbl, bkt);
>  			data =3D rhashtable_lookup_one(ht, bkt, tbl,
>  						     hash, key, obj);
>  			new_tbl =3D rhashtable_insert_one(ht, bkt, tbl,
>  							hash, obj, data);
> +			odata =3D data;
>  			if (PTR_ERR(new_tbl) !=3D -EEXIST)
>  				data =3D ERR_CAST(new_tbl);
>=20
>  			rht_unlock(tbl, bkt, flags);
>=20
> -			if (PTR_ERR(data) =3D=3D -ENOENT && !new_tbl) {
> +			if (odata && !new_tbl) {
>  				atomic_inc(&ht->nelems);
>  				if (rht_grow_above_75(ht, tbl))
>  					schedule_work(&ht->run_work);

This patch passes my tests. I'm doing a narrow test to verify that
the boot failure when opening the Mellanox NIC is no longer occurring.
I also unloaded/reloaded the mlx5 driver a couple of times. For good
measure, I then did a full Linux kernel build, and all is good. My testing
does not broadly verify correct operation of rhashtable except as it
gets exercised implicitly by these basic tests.

Michael

