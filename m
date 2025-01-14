Return-Path: <linux-hyperv+bounces-3680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C6A10609
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 12:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB3B7A2BAB
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC88229614;
	Tue, 14 Jan 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FQnzha7n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013065.outbound.protection.outlook.com [52.103.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F92361D4;
	Tue, 14 Jan 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855938; cv=fail; b=CM6Q7CDXcMI3HUwE433eDh9sp7t2+ewqp9mpsiFR34kzqCOv4xPlmnPqx8THc0vjFDHUP8MMntBMTHhBIw86bC4ztf/c1yvtJdXNV9WcLbGUuJQC25XAOB7bf3vzyet1ckkfn+i6xl5YFdOEby/ORZvYEchYtR/vmlUXaiJ/RgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855938; c=relaxed/simple;
	bh=cCBp+UPo9iVi+FO1kKhtCbwFDN+N+WJ5mUTcmhhay44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rmw2ndAsH0N8gn71MWDqrfwdpGEd/LYYnKPySaIr3mttqSxF4UaJW49w4XvJEXhT9l3DUn6Ye/voyQD52Dw7fOM7vUNKO0uj+HdDHT07JbqNFcVbg8rEu98SbU9Ku0qt0bD56D8xfjuv9/tm51WpCryIpjsSbDijR/vxbjSeUWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FQnzha7n; arc=fail smtp.client-ip=52.103.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT9zTGZBmxiYz3g/0HqHYvz/XMcdvVD5SJinCN8XUsYstvxijxgO5pU1G5sCCobPC7RLCQVsS7ng1LtEREtSlSEbDkZQzSxR/iNxKYroCzwZRfcP/Aepxo36t5y6wsF11TBgAgubFgIE3+JSTlY6yp1Fx2Ks2WQSzZu9RlK1VjZ8BJCGJP/Dm2oeSlLuR+YMpDbjHr3nEaprZVQ7FxfGw+Jom+29Ka86YKyw0PG2iOG3paYRK1bv0r/2zhKcWCAZL8RyoA64NxuecdR8BaEvkFvQHCRVYA92u3m4Yuo4fViCliF2zdj4gjmy4Si1vSm5MFo64uEaf16Y1Tf25Vi69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXFtxHpMk8Z6bftgzC9RUKsBGPeEdM8l0FZw0FjPyzw=;
 b=l0zJDg0M5ickAdvtfkRnIM7oBGQRrZ6AEvgEdOT3BlrfO+H4+OEiFAKRH9BEVIqHh/URvAkaNtqRkcCVp/RhzQfXJq78+8BHbX08uK6mrsqGujWT7PVU63vWgHwHG2pred4Fit77waG60CpYClb3jbRjRtm1JlePsdSkwdOwnR7/fES1M4t2yAAol+Q4bA5wYr5A2UMRWaEmiD+rHfvJuUOVCLl+DrG0+tXpm8vE7LdxD4NgAU+aKumjr/M30aY8KDA3Xd8jtI9M37K5vbiR/umN+fdgQwM97g3uIkm4Yjrgy8+ymkJ+yHA8dKv5zN8p6D30MW9lU0DSxmkNCiKy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXFtxHpMk8Z6bftgzC9RUKsBGPeEdM8l0FZw0FjPyzw=;
 b=FQnzha7n4nulBiTRaAbQ7/mP2ZvqsLkRsrnnspyboeWXvul2CVm/7YHT70ktNLx4+3QCP9anQZQ5UJ8LWHSG3UrxNGxXzaCWGQobCJyIvZM5TaevGtMbWisHtJ7ZdQ3pvZgSlV8tT3nZGnDsfZEXrL+ISOwZrGVWKUG6bdxlijr2Ys4M42XX2eGRHghNeWGvD+3bhLsDVVKQ1+rxOZ+qucgts6veq6rr0XTEtGvFIt9KXjs90OQA+JBzvW9q8KTxYve+62Fp+ltH/66F7Qr39zox5YPUE8Ab4JMxIxM2HW0GacoDTvEMHt2KJ0Y16HH+LLwXLooPpmALrRD8lpsJlg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10473.namprd02.prod.outlook.com (2603:10b6:303:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 11:58:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 11:58:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Breno Leitao <leitao@debian.org>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>, Hao Luo
	<haoluo@google.com>, Josh Don <joshdon@google.com>, Barret Rhoden
	<brho@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Crypto
 Mailing List <linux-crypto@vger.kernel.org>
Subject: RE: [v3 PATCH] rhashtable: Fix rhashtable_try_insert test
Thread-Topic: [v3 PATCH] rhashtable: Fix rhashtable_try_insert test
Thread-Index: AQHbZjKOzS8JRnQnb06t1/r8Yif4xbMWKXMw
Date: Tue, 14 Jan 2025 11:58:53 +0000
Message-ID:
 <SN6PR02MB415708E60D4941374BAF2F28D4182@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au> <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
 <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4XWx5X0doetOJni@gondor.apana.org.au>
In-Reply-To: <Z4XWx5X0doetOJni@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10473:EE_
x-ms-office365-filtering-correlation-id: 47f1a469-ec59-4db5-832e-08dd3492d10a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|8062599003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sO2FeNCV2UWf/3Spd8rI9pzg4XEyDMPmT1NV8qKYkIUSF9z2ux5oRHzhhWeB?=
 =?us-ascii?Q?e6leZu1oeG98XDDsipvU5CUk62kPFVGaVvGLiwiUh3r+cHIly7uyPWBVAZZH?=
 =?us-ascii?Q?ZhbBbAPKkmbxCHKgMeLiw82sJHZ2bzUa4TxmejwITfG4Dg2Z5+aNmKZD8+wD?=
 =?us-ascii?Q?KxoskUQUVE9C4oFn7LlT5ALjcqI4sdXWnnIgQvV+KFtw5mq6kk4Uiv1p7kWb?=
 =?us-ascii?Q?csWl5lYwh92BN9Uo87y+5UipBy40v2iXX6QBbRSKvet1mTyhmDWJmELK9tHX?=
 =?us-ascii?Q?mawj1NtpwlZQcERvCkjZSKsE5c/BrrlKhftfNhnfaeUHpG/V8dJmBO66c1mq?=
 =?us-ascii?Q?M9IEq/LFmQdBfLRiVevNEuNCkVlKJSnJPI5mKTcTwrdFavYEt/8OrrU+7NDB?=
 =?us-ascii?Q?OTcxnf3KGWVH2Eyag/Ob4Kr8xax9TAapZRwSQE9iVSzXZNVyA26G0FZzCm/Z?=
 =?us-ascii?Q?F98JseZaCcZAljWqx4JBfSCZ7jCagSuvjnDNBDY1h5t1QW4yJbyEo31XcYSa?=
 =?us-ascii?Q?5NFgsHlOLzgFabpoPv9k30+FqPlvI6SkCG7w4Bm81phXcEs2eQiAgTWDSgWs?=
 =?us-ascii?Q?i2LbPwheebbwsNn9IxFosen++WXa7LcrAPJMynq/4ThUEaMFBaCWYu7kwaRy?=
 =?us-ascii?Q?9AzVLw0UeJo32fWd84Vtgo/yfDZpfaypmJB+kRUJjcoMEzzkQaZAv7MP5Z96?=
 =?us-ascii?Q?X+4pI2CRMDnhmhWCqml7+KSHbQHwKTsY7JprFYQMjbkrF3w2BtFTBQagmnBu?=
 =?us-ascii?Q?XZvwRO7ud78P1ckP81qI+R8vgYDWAYqSej9vLHJSpCc2CfGW4s5HdkniB8Ju?=
 =?us-ascii?Q?U/YpEF5P/33HCQothg8fiY4iLQV1ZjQ+Op4IUjpCj07y3iDMbQcZlUjz4WQm?=
 =?us-ascii?Q?hF4G8pN5BcojSpXMgBWZMDBPJSNyiK+srVaxGrIdcbkIPmDa8nJADs1D/he7?=
 =?us-ascii?Q?OEaLkEOprxLNONsVZSuCazSJudxgL5Pl6nFCCk1BIVyBKIkebwcLSNhcop+Z?=
 =?us-ascii?Q?oLRXXebNiq+oIEyUqHwJBFfvWW/nx9gatdnrtiViYzeB/To=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5G+rbTvRuPh+kwLSCFFTJn85aCxrk7OhEpEH0q/CFVD8nxEOw63+RphUnfzZ?=
 =?us-ascii?Q?u6DmDjdLAmM949NgsiEupphB4K6J5FRJ/M4RVy+7X9bQRg/EvyqmJZSi4pEP?=
 =?us-ascii?Q?sixvGCUo5NFUYfrWhw7JyheU2oL6+GM3SbNryKHZl+QnXbm0ZMbKbi9tybYP?=
 =?us-ascii?Q?49lUBTqjCtSCAUEuSeI8J9Z1S9Ywh8nkbuUkmzLsk6aehSVp39pJ1YhyQd1Z?=
 =?us-ascii?Q?OtqJ4R2YUP292KT3Pk7Uw/nlSLEtffXsOIcp1COMB9XSvFY9GKkWiDBmjFOF?=
 =?us-ascii?Q?f6R1B6nHX6A/sacI71pOHmfceyojIcrXKq56ro6bXBGzcHh/cgyFlFoKdDIe?=
 =?us-ascii?Q?CrU6GqnypMX4LNz+li2hm7cpMQgWs3oRfA0Ggr80yIZ6TT+oQyqVFlLqhJ9V?=
 =?us-ascii?Q?MYxSKe0M3mBwc1P9qotegkJUgg8jgA5ihfQ7wvnCK1pceKjoTXtheXltGpFx?=
 =?us-ascii?Q?0ZraI4KcCz7bQ9DNZc7wFsS4AnAZ2ARAyH43ijqAbspCamadeE1vZLtxAX7Q?=
 =?us-ascii?Q?/zWKQW1eOK5dBTf3kmPl7tYKCi8HlCVAzjJ4zRbEADXprIjEV4kf84ENzlzt?=
 =?us-ascii?Q?lQsm2lg+ZCdcm5HN9cXvt3herSLz0W6OMEbiJUSFJNKYZmarUSGgxnPDHxVv?=
 =?us-ascii?Q?BdLZYQUd3PxRRUcmBxA1GtmOf5OH4c9gLnudT+beRMmmCX7Jg2AMhx7XtLW+?=
 =?us-ascii?Q?s2mMofjiZY9AoQ1lW5HWmbZV+PlGLJpQaAQDjpLRcZSl64CZeUa0eV00HSYg?=
 =?us-ascii?Q?GlnLnseHxHnH+QlFmFoZLlTKmVpwydjJidmDgD8EE06rD4XjGLj+5UjWo5h7?=
 =?us-ascii?Q?dik4fTIdxG2jkDg1bM7g4GcZo6vsPIQF9yAF7LpSgSBRfh8OGEgW0gBdW5Iy?=
 =?us-ascii?Q?MhADQpFR3i7S1wLCE6eA2ZHTg0M02GiSiystW9BuNZ8N3kN/E9F+Lxuw3/CC?=
 =?us-ascii?Q?57h7RNDEinpAgtTtgIrHS2K632ScMKHf77/40viqp5EW0YbDtKC9iNI3F7F6?=
 =?us-ascii?Q?uKQN5jMZIxSePZ/z0TvtduJz5u4xiG/W3Pm9dYok1BYcnVZNR3rCq+bqPlWB?=
 =?us-ascii?Q?y7w47y0DblnfBytrn8OAWITJHH8GrPpwiV3CGoASGEE86dwiPJdZCHIK+tq6?=
 =?us-ascii?Q?JRt8tZHRLC6mwIE/nLB7mVUo40XpAPLvdYWYqTKk38vnZ1cLb9w/B+4HOzrY?=
 =?us-ascii?Q?DOdX0LUl6l42kMrW7n0I20rX81qIDF3YIVKHXSG7lR06p+2sQH9rHskRfQI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f1a469-ec59-4db5-832e-08dd3492d10a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 11:58:53.3016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10473

From: Herbert Xu <herbert@gondor.apana.org.au> Sent: Monday, January 13, 20=
25 7:15 PM
>=20
> On Fri, Jan 10, 2025 at 06:22:40PM +0000, Michael Kelley wrote:
> >
> > This patch passes my tests. I'm doing a narrow test to verify that
> > the boot failure when opening the Mellanox NIC is no longer occurring.
> > I also unloaded/reloaded the mlx5 driver a couple of times. For good
> > measure, I then did a full Linux kernel build, and all is good. My test=
ing
> > does not broadly verify correct operation of rhashtable except as it
> > gets exercised implicitly by these basic tests.
>=20
> Thanks for testing! The patch needs one more change though as
> moving the atomic_inc outside of the lock was a bad idea on my
> part.  This could cause atomic_inc/atomic_dec to be reordered
> thus resulting in an underflow.
>=20
> Thanks,

I've tested this version of the fix in the same limited way as
before. All is good. I'm still testing against linux-next20250108
from a few days ago, but that should not make any difference.
I have *not* reviewed the code change itself.

Tested-by: Michael Kelley <mhklinux@outlook.com>

>=20
> ---8<---
> The test on whether rhashtable_insert_one did an insertion relies
> on the value returned by rhashtable_lookup_one.  Unfortunately that
> value is overwritten after rhashtable_insert_one returns.  Fix this
> by moving the test before data gets overwritten.
>=20
> Simplify the test as only data =3D=3D NULL matters.
>=20
> Finally move atomic_inc back within the lock as otherwise it may
> be reordered with the atomic_dec on the removal side, potentially
> leading to an underflow.
>=20
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedu=
le_work outside lock")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index bf956b85455a..0e9a1d4cf89b 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -611,21 +611,23 @@ static void *rhashtable_try_insert(struct rhashtabl=
e *ht,
> const void *key,
>  			new_tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);
>  			data =3D ERR_PTR(-EAGAIN);
>  		} else {
> +			bool inserted;
> +
>  			flags =3D rht_lock(tbl, bkt);
>  			data =3D rhashtable_lookup_one(ht, bkt, tbl,
>  						     hash, key, obj);
>  			new_tbl =3D rhashtable_insert_one(ht, bkt, tbl,
>  							hash, obj, data);
> +			inserted =3D data && !new_tbl;
> +			if (inserted)
> +				atomic_inc(&ht->nelems);
>  			if (PTR_ERR(new_tbl) !=3D -EEXIST)
>  				data =3D ERR_CAST(new_tbl);
>=20
>  			rht_unlock(tbl, bkt, flags);
>=20
> -			if (PTR_ERR(data) =3D=3D -ENOENT && !new_tbl) {
> -				atomic_inc(&ht->nelems);
> -				if (rht_grow_above_75(ht, tbl))
> -					schedule_work(&ht->run_work);
> -			}
> +			if (inserted && rht_grow_above_75(ht, tbl))
> +				schedule_work(&ht->run_work);
>  		}
>  	} while (!IS_ERR_OR_NULL(new_tbl));
>=20

