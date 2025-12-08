Return-Path: <linux-hyperv+bounces-7992-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF66CAD898
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Dec 2025 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C45AA30191AD
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Dec 2025 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0850B24677A;
	Mon,  8 Dec 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mOr3RrkH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010019.outbound.protection.outlook.com [52.103.7.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCA2236FD;
	Mon,  8 Dec 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765206828; cv=fail; b=ghTg0eM0SjWnB1jZ6ayHxPw2aUswg3xEtJq45lIMnDC52kkuWOtYE8LoEpR7S+spB26fIGXv2cNc5dApJG9zdCyxPcnbaQc8stgcgxdF85JKNN21rQn0OfEYwXNVqav7orRoJI3KsXh6nKHibNxSnsHeMOjhooaiEUtxd1oSReI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765206828; c=relaxed/simple;
	bh=7zcJPltH59fQ4gRo1yLdNS+TeoV9EWAXZQWjRcu6TCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jCazgLz5SDr/PbS393f6cEGYbEFLOi24eM7j47PUmHJ3idcGLycW17W/u8jvQa7vcwf2ft22sLp9xLu4c4rOIPcVBrG8dULnVeT3EveqFEtonqOIn9Yz5p/pnMlT+kyCWxE6bGuTA92Eh4345ZnsaZNMMslfMKbHLWSgcoUbnA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mOr3RrkH; arc=fail smtp.client-ip=52.103.7.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT9PQpsFQKYE+20P6edNGdbzseBPMXoecdQi3JNd92S7056mJ6BmCS6TyBqMtOmqknvGG2m/X6dzrH3MK2hiZWOHogxf66bX5XkIOKnvMHhhovARnJXnG/BTcFUEuXsobDSkmHXpTfB7kvTte8ywAD/9MzZ20+X3uEWKzGvnJz3TNWOX2aZ5YewTlKaikJCS0eH8Wb9sIn5iCNn4MrqozuPo2fXifnMVbYTUDnZ3qWbplz6heZKMMtToFwO3z46EjpOCRea/SJSefN0NQsx6AZaBn2LXsG9nw00IRN8PzjK/pFXyb8EG8lSLR5cYxs4FN/aQ19AphTDVOleclYRRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etif2h3/Dne2I9mW6szWwcS4pp+1IhYc/jCOWIyXrz4=;
 b=QNG+wJ+h9n0feMg+Cf2G9GIJVooJ8BItvZkubCwd2i5530DYc+fv6SUNgMR5YRUsojzbu8qTVjfijkpozeYRIllWJcHaWGeSh6Vpa7OBhTwVyUVjZ7i0kyGyrVSOZ64Wr+IrEFJXFD+Md/wdfdqS3YSbYaiWokt6AbIhIz+07M/O8revmTdLwTwJwtHVVwXjqvItqTo6SjfVCtMPoX3YBPD9FMcU3FTGOX1nLRbcF+KiUwHNkvsaLyNDkLNrsphgnE/FJulQ2szAOeM0OObZZvniylGiXOwGOZwS+K3sUp7DsidgvYEHHTk9LR+eKeyaSQV60cm1pQglTUx1qxheVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etif2h3/Dne2I9mW6szWwcS4pp+1IhYc/jCOWIyXrz4=;
 b=mOr3RrkHDf3vTzVHTPHqCD9cFMdI4PwQXEH0LhhUZntFBdSfEe3vz5vvg4dEKO8WkrDus2OHd13y0j359DuDt/Qxy+CraxVYJxJQRtrJ+y38H1+ldvSIrKi9B6P56T+6FsSq/KmfVKKrU3aU5R5QUhrFIAvLtzJyQ0pKqG2hbXTVEB/LdxrM9cBYz7xSOHvhSxrNREXieSZJEYrKDVkVagU/LjQ85uc9UVcAueI4pxmrePHe/l3Cp2UkBdPZKcozSYZ+PkncfNZK/dSCB83TqmpF0NsJEfOEIdFMl6mEci9TJvP9cgwaB64UQ02Oiy9jGczS5Dr5uO4m9mgdON/s2w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB11197.namprd02.prod.outlook.com (2603:10b6:208:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:13:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:13:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "paekkaladevi@linux.microsoft.com"
	<paekkaladevi@linux.microsoft.com>
Subject: RE: [PATCH v2 2/3] mshv: Add definitions for stats pages
Thread-Topic: [PATCH v2 2/3] mshv: Add definitions for stats pages
Thread-Index: AQHcZhkxtkewBaG7AEGjoP4Wf6Bx8bUXOuIg
Date: Mon, 8 Dec 2025 15:13:44 +0000
Message-ID:
 <SN6PR02MB4157729608C3B15BA9442591D4A2A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1764961122-31679-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764961122-31679-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1764961122-31679-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB11197:EE_
x-ms-office365-filtering-correlation-id: 04c02c78-8ff8-4169-ee13-08de366c60e7
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayGKAlIIivN7fIKgPET+ZtPoh1bSLbUI75jK6ulQxzPieQB/CBAvNZJ1J6l7juhFYhFNjJ0wB5T7QVFVdPOPkx3JrIFeu5EDQWnpKg1MhMpv785i0Pc+PMX+N4FnWwb9nt1arHUOFU64dY3UY3QdL85Yy7yf/k36QZtggf5b3F5C8hxQNj5dBszEVOeWeMPJoohwJLV3Nfs6NurYfjuz1TQe59Y3YS9GHw2QAmDeajl7OIXP1aIbYUEg8gG8D0z8n3vVzoeVS69xxmFqApx9PTu7bNa3Ikm6Okgs5SBe8Cw24pXzeYWg9sesKsEA2ow4gRrRzoXpT2JqaHfx70MdopqmSPm7pRZodUaqg/n68iDc36QIYrkK0YkALhDaAw4W7RqG95fFK89jYqzuXO0youw7vpI5ZBqPR8v7driLUttdZxyqELQRi6h7yZZwwk4w157iXTaiPqkmCdwVlSwwrNRu9LYV7wtpXukbPvWKMupA7PhGXMQTSeJFG3pmUc0SGHEBul0S3WL62QgsfU9PFmKZjhq6NMaMDIzr9r0jyBEZj/9Lpixso3sgaS1xZ7J0RCb6KxyCpckQnEDOsOPFBWKJalSTun/SxwdsiV3u0i5KyKpz65MzeFmUX9aujSmUjqQySN5cftxkuZWH7MXFhXgmQLoBt1J2uhwp4ta4Gox+k1vav/17TkV7uc+pSM/xpP6upWmKl3ywZDBkqojhKL/xVIlXmNB1dqs=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|19110799012|13091999003|8062599012|8060799015|51005399006|15080799012|3412199025|440099028|40105399003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DffYaBCvgqfPKUhWV5PTvTFoZdWMVutLthK8NkybTl8lsKYLlCZAg3TfhaN4?=
 =?us-ascii?Q?35UP/cynwmny4jDagrYJ7mrCcCXEtp2584GTiqDayGhMOW9JwYu7bfTmpk+Q?=
 =?us-ascii?Q?/jSXfC/A7R/nsrb5JgxE0bzUBcrkvGmDGrlPejb/HVeorLU/l1D7Aa4oHKqV?=
 =?us-ascii?Q?Dvi60P7iZi6WrSJ9kwmtoNox1k02VHheLcHc9BqkiEnsVaLT7WOrCwtcMlsq?=
 =?us-ascii?Q?SmQ9aF8B3SWgKUDBYahklfEXok0VEAub+vSkk72l5B+7SPf6jqGdv3AW0pL3?=
 =?us-ascii?Q?ApKwWqCm/UIJrEDjV8XEhWFzGWZC2FrbmcAMngrmTrgeXVaMexerhLmZxnDt?=
 =?us-ascii?Q?D5KQ8WPnXYpFOV6k2aNYi7untafyvnlntyqyEVH7pEbd/75sj6PlXnQBqhPn?=
 =?us-ascii?Q?PJbYDJn7Ibx3TiUjzeubPLkFOYl15Sva7pKPRb13Y3CpgVASITrdm6j8ag2W?=
 =?us-ascii?Q?r3fsC/UZvytei+V5Xs7QxstR2DoWNotdibfP2mdIH5eqzbc0MTu/2SrsaUNc?=
 =?us-ascii?Q?o1iwVVm4rpVIuwRcYG4k/XCrzeGz0Xaiz0tyjUnOhO0ZN0uBWIotMuC9lFJb?=
 =?us-ascii?Q?gv3MMnb96XueAZf6LXYsJZVxCpjdDOqL5WB+kEg5SNxQLeDSA3867ZCXJ/5b?=
 =?us-ascii?Q?yxqYX+UntSrN96GY4UMRIqdF3RYzya0DHLkMdSa4zeCvyquUZYQbnYFpi0yr?=
 =?us-ascii?Q?hBERSSQdCSsP87IvBOdETz8Y25FxxX6JAqbaLBJp1GlGuPwwz/iN5+qCGX2Y?=
 =?us-ascii?Q?gla2V5EgZJpo83NjTJJP9T61t4/4mzkOWBBHkPBZBECvoiGngGeRz7MFP4xa?=
 =?us-ascii?Q?lJdZ7fUe7/HFHaOvFk9M87Zzf5VHxANFrdwE4mowAWig+BlK3nXf70VPCQ5x?=
 =?us-ascii?Q?kZlILMqmZSWcAdlnEQRcsIKgCsww+5HMNBfzJeAc++Kix69WHbS4dSd1mCcx?=
 =?us-ascii?Q?P/KzWckyKlR+jmZjH2MIiLM0t4sVoCbCedX8qNDb2/XFe48Fq4dIR009oBcg?=
 =?us-ascii?Q?s8uqRGmfb7LvAgpo8Ri0+8DfZRXOESY+T5BD0nqP6NdlC0LdZRMJvlM01EyZ?=
 =?us-ascii?Q?8S+oLnn0UyNZPMHCQTjFMdJCOYN2lEcLv7996NPQ8azQ7E8t7Rh0MUwD6qjE?=
 =?us-ascii?Q?W/rI5JLE0JWcHIofAehA1fjLR5rfaRFJlFUXcsbffIcLnzTJGZ5ZAWFSFr7+?=
 =?us-ascii?Q?/4MOWBp3Sn67A1wv1Hkja4rSJ543sAoUfH7jMA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AmivUfmO40VtwCxuKAERQiBu8pccNtLwSWCAPyZ3hWWNK4yYxksnk8Xce1+P?=
 =?us-ascii?Q?Mc/Wldk9/bBfQ82FLnZIr+1ygmWkAYcj1QGmmk+lqidmN1P7AFyBiVNrxSjb?=
 =?us-ascii?Q?8s3GiulYEjF7jFWkD128fXRftn0FTqRjc6FX2ykuqAOwNN+fUh3uM7BQwZSK?=
 =?us-ascii?Q?QNZepk55xCKWo0YubJPh7kcTzEo2CN5jX0gL/0xu8JEIZLT8R4EHmdJ+3Dal?=
 =?us-ascii?Q?HUuoW79J6dKrAMItu7HdcjpDR0yTBG0i7wEqQZKiaFC/3chGII1ewuP6+/c8?=
 =?us-ascii?Q?Z21t0PnXimLYagKyt7s6iQcgQoTpWfDoFe5rgm1X/Rg+i9/+o/7lakkauIfN?=
 =?us-ascii?Q?1tCIpNxPhlOzb8F5B3UfdXnJ7wGtAuptuQGZKCrx4KhWeEdLg0JT8M5DglqJ?=
 =?us-ascii?Q?HGw/TM7uYgFmGFveDwsP2rduBwCa1moSzL9FLcA2RFz/N8YFA31mkJnHkIfp?=
 =?us-ascii?Q?EYLJ8Frs19lS886G56wlza1oxraXvvJD8Yr80tnqFAhXvSd8w9e81I8jZknt?=
 =?us-ascii?Q?e0jowIlD08x2ilY3Sjtyk6ELace4z3EhdutYhnNel3xCmByjaz75kvdm4Jfv?=
 =?us-ascii?Q?w7hvykaHP2/B5mwPtKm3Hd54iIgb4NKSUfGyHgfhzd91BJ42yXgsD+gNOLd0?=
 =?us-ascii?Q?zTILFtzLWvGH+adobjw9pI0194eNm8TfRpKpyGUcTUrpXNZK6mRVioYV7DT1?=
 =?us-ascii?Q?HviklbM4gEw73jHrDvj4e3Sj00sM8AJ4QHC8h+9/PbFWsyP0GRUeIS7aB8bA?=
 =?us-ascii?Q?Hs+hAI+WNNdYaXyNshq499oEtoREEbaBvvtwLjAb3niEwXzpMUYBzblysrwe?=
 =?us-ascii?Q?aWAllQZxkPtK4d3I2W1HpyWzJOg0vpPZD7kdDeqN1/Qi5YvsMdNZfO33v2xe?=
 =?us-ascii?Q?Py+FXvYDEJ8f61j302biAN8FHwhI4wfsmu1Ey3QLcSKj7fuGjCM6KLE6PLpb?=
 =?us-ascii?Q?UEpIcStdiIpdi3xHrz+OZJDmbTF8b11TAA9HC4N3lXu654N/JBpqCcLqffv4?=
 =?us-ascii?Q?JfIZHw9JEdfMuqJs8Zn8bb6NDeK+gZclJG45gDZfA9hDCv5mpHji1inHY5g7?=
 =?us-ascii?Q?auL+w6CLP3WKBiYSZqbmRRiwjEFBo1Mmi2wQcWyzaHxRDdI0KUp0S9MpZAj9?=
 =?us-ascii?Q?RO09Op3zpNvfsy3o81XhmtdGIsllBI0dpqQVSmp/kq1NE59fgtLk7yxaSRjy?=
 =?us-ascii?Q?QS2mo5JlDR2f5ypfAoF7coPeRPo+ya6I8tz0LUORsgYFHgnx33IRyj7auCw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c02c78-8ff8-4169-ee13-08de366c60e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 15:13:44.3287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11197

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Decem=
ber 5, 2025 10:59 AM
>=20
> Add the definitions for hypervisor, logical processor, and partition
> stats pages.
>=20
> Move the definition for the VP stats page to its rightful place in
> hvhdk.h, and add the missing members.
>=20
> These enum members retain their CamelCase style, since they are imported
> directly from the hypervisor code They will be stringified when printing

Missing a '.' (period) after "hypervisor code".

> the stats out, and retain more readability in this form.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |  17 --
>  include/hyperv/hvhdk.h      | 437 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 437 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index f59a4ab47685..19006b788e85 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -38,23 +38,6 @@ MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface
> /dev/mshv");
>=20
> -/* TODO move this to another file when debugfs code is added */
> -enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> -#if defined(CONFIG_X86)
> -	VpRootDispatchThreadBlocked			=3D 202,
> -#elif defined(CONFIG_ARM64)
> -	VpRootDispatchThreadBlocked			=3D 94,
> -#endif
> -	VpStatsMaxCounter
> -};
> -
> -struct hv_stats_page {
> -	union {
> -		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> -		u8 data[HV_HYP_PAGE_SIZE];
> -	};
> -} __packed;
> -
>  struct mshv_root mshv_root;
>=20
>  enum hv_scheduler_type hv_scheduler_type;
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 469186df7826..51abbcd0ec37 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -10,6 +10,443 @@
>  #include "hvhdk_mini.h"
>  #include "hvgdk.h"
>=20
> +enum hv_stats_hypervisor_counters {		/* HV_HYPERVISOR_COUNTER */
> +	HvLogicalProcessors			=3D 1,
> +	HvPartitions				=3D 2,
> +	HvTotalPages				=3D 3,
> +	HvVirtualProcessors			=3D 4,
> +	HvMonitoredNotifications		=3D 5,
> +	HvModernStandbyEntries			=3D 6,
> +	HvPlatformIdleTransitions		=3D 7,
> +	HvHypervisorStartupCost			=3D 8,
> +	HvIOSpacePages				=3D 10,
> +	HvNonEssentialPagesForDump		=3D 11,
> +	HvSubsumedPages				=3D 12,
> +	HvStatsMaxCounter
> +};
> +
> +enum hv_stats_partition_counters {		/* HV_PROCESS_COUNTER */
> +	PartitionVirtualProcessors		=3D 1,
> +	PartitionTlbSize			=3D 3,
> +	PartitionAddressSpaces			=3D 4,
> +	PartitionDepositedPages			=3D 5,
> +	PartitionGpaPages			=3D 6,
> +	PartitionGpaSpaceModifications		=3D 7,
> +	PartitionVirtualTlbFlushEntires		=3D 8,
> +	PartitionRecommendedTlbSize		=3D 9,
> +	PartitionGpaPages4K			=3D 10,
> +	PartitionGpaPages2M			=3D 11,
> +	PartitionGpaPages1G			=3D 12,
> +	PartitionGpaPages512G			=3D 13,
> +	PartitionDevicePages4K			=3D 14,
> +	PartitionDevicePages2M			=3D 15,
> +	PartitionDevicePages1G			=3D 16,
> +	PartitionDevicePages512G		=3D 17,
> +	PartitionAttachedDevices		=3D 18,
> +	PartitionDeviceInterruptMappings	=3D 19,
> +	PartitionIoTlbFlushes			=3D 20,
> +	PartitionIoTlbFlushCost			=3D 21,
> +	PartitionDeviceInterruptErrors		=3D 22,
> +	PartitionDeviceDmaErrors		=3D 23,
> +	PartitionDeviceInterruptThrottleEvents	=3D 24,
> +	PartitionSkippedTimerTicks		=3D 25,
> +	PartitionPartitionId			=3D 26,
> +#if IS_ENABLED(CONFIG_X86_64)
> +	PartitionNestedTlbSize			=3D 27,
> +	PartitionRecommendedNestedTlbSize	=3D 28,
> +	PartitionNestedTlbFreeListSize		=3D 29,
> +	PartitionNestedTlbTrimmedPages		=3D 30,
> +	PartitionPagesShattered			=3D 31,
> +	PartitionPagesRecombined		=3D 32,
> +	PartitionHwpRequestValue		=3D 33,
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	PartitionHwpRequestValue		=3D 27,
> +#endif
> +	PartitionStatsMaxCounter
> +};
> +
> +enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> +	VpTotalRunTime					=3D 1,
> +	VpHypervisorRunTime				=3D 2,
> +	VpRemoteNodeRunTime				=3D 3,
> +	VpNormalizedRunTime				=3D 4,
> +	VpIdealCpu					=3D 5,
> +	VpHypercallsCount				=3D 7,
> +	VpHypercallsTime				=3D 8,
> +#if IS_ENABLED(CONFIG_X86_64)
> +	VpPageInvalidationsCount			=3D 9,
> +	VpPageInvalidationsTime				=3D 10,
> +	VpControlRegisterAccessesCount			=3D 11,
> +	VpControlRegisterAccessesTime			=3D 12,
> +	VpIoInstructionsCount				=3D 13,
> +	VpIoInstructionsTime				=3D 14,
> +	VpHltInstructionsCount				=3D 15,
> +	VpHltInstructionsTime				=3D 16,
> +	VpMwaitInstructionsCount			=3D 17,
> +	VpMwaitInstructionsTime				=3D 18,
> +	VpCpuidInstructionsCount			=3D 19,
> +	VpCpuidInstructionsTime				=3D 20,
> +	VpMsrAccessesCount				=3D 21,
> +	VpMsrAccessesTime				=3D 22,
> +	VpOtherInterceptsCount				=3D 23,
> +	VpOtherInterceptsTime				=3D 24,
> +	VpExternalInterruptsCount			=3D 25,
> +	VpExternalInterruptsTime			=3D 26,
> +	VpPendingInterruptsCount			=3D 27,
> +	VpPendingInterruptsTime				=3D 28,
> +	VpEmulatedInstructionsCount			=3D 29,
> +	VpEmulatedInstructionsTime			=3D 30,
> +	VpDebugRegisterAccessesCount			=3D 31,
> +	VpDebugRegisterAccessesTime			=3D 32,
> +	VpPageFaultInterceptsCount			=3D 33,
> +	VpPageFaultInterceptsTime			=3D 34,
> +	VpGuestPageTableMaps				=3D 35,
> +	VpLargePageTlbFills				=3D 36,
> +	VpSmallPageTlbFills				=3D 37,
> +	VpReflectedGuestPageFaults			=3D 38,
> +	VpApicMmioAccesses				=3D 39,
> +	VpIoInterceptMessages				=3D 40,
> +	VpMemoryInterceptMessages			=3D 41,
> +	VpApicEoiAccesses				=3D 42,
> +	VpOtherMessages					=3D 43,
> +	VpPageTableAllocations				=3D 44,
> +	VpLogicalProcessorMigrations			=3D 45,
> +	VpAddressSpaceEvictions				=3D 46,
> +	VpAddressSpaceSwitches				=3D 47,
> +	VpAddressDomainFlushes				=3D 48,
> +	VpAddressSpaceFlushes				=3D 49,
> +	VpGlobalGvaRangeFlushes				=3D 50,
> +	VpLocalGvaRangeFlushes				=3D 51,
> +	VpPageTableEvictions				=3D 52,
> +	VpPageTableReclamations				=3D 53,
> +	VpPageTableResets				=3D 54,
> +	VpPageTableValidations				=3D 55,
> +	VpApicTprAccesses				=3D 56,
> +	VpPageTableWriteIntercepts			=3D 57,
> +	VpSyntheticInterrupts				=3D 58,
> +	VpVirtualInterrupts				=3D 59,
> +	VpApicIpisSent					=3D 60,
> +	VpApicSelfIpisSent				=3D 61,
> +	VpGpaSpaceHypercalls				=3D 62,
> +	VpLogicalProcessorHypercalls			=3D 63,
> +	VpLongSpinWaitHypercalls			=3D 64,
> +	VpOtherHypercalls				=3D 65,
> +	VpSyntheticInterruptHypercalls			=3D 66,
> +	VpVirtualInterruptHypercalls			=3D 67,
> +	VpVirtualMmuHypercalls				=3D 68,
> +	VpVirtualProcessorHypercalls			=3D 69,
> +	VpHardwareInterrupts				=3D 70,
> +	VpNestedPageFaultInterceptsCount		=3D 71,
> +	VpNestedPageFaultInterceptsTime			=3D 72,
> +	VpPageScans					=3D 73,
> +	VpLogicalProcessorDispatches			=3D 74,
> +	VpWaitingForCpuTime				=3D 75,
> +	VpExtendedHypercalls				=3D 76,
> +	VpExtendedHypercallInterceptMessages		=3D 77,
> +	VpMbecNestedPageTableSwitches			=3D 78,
> +	VpOtherReflectedGuestExceptions			=3D 79,
> +	VpGlobalIoTlbFlushes				=3D 80,
> +	VpGlobalIoTlbFlushCost				=3D 81,
> +	VpLocalIoTlbFlushes				=3D 82,
> +	VpLocalIoTlbFlushCost				=3D 83,
> +	VpHypercallsForwardedCount			=3D 84,
> +	VpHypercallsForwardingTime			=3D 85,
> +	VpPageInvalidationsForwardedCount		=3D 86,
> +	VpPageInvalidationsForwardingTime		=3D 87,
> +	VpControlRegisterAccessesForwardedCount		=3D 88,
> +	VpControlRegisterAccessesForwardingTime		=3D 89,
> +	VpIoInstructionsForwardedCount			=3D 90,
> +	VpIoInstructionsForwardingTime			=3D 91,
> +	VpHltInstructionsForwardedCount			=3D 92,
> +	VpHltInstructionsForwardingTime			=3D 93,
> +	VpMwaitInstructionsForwardedCount		=3D 94,
> +	VpMwaitInstructionsForwardingTime		=3D 95,
> +	VpCpuidInstructionsForwardedCount		=3D 96,
> +	VpCpuidInstructionsForwardingTime		=3D 97,
> +	VpMsrAccessesForwardedCount			=3D 98,
> +	VpMsrAccessesForwardingTime			=3D 99,
> +	VpOtherInterceptsForwardedCount			=3D 100,
> +	VpOtherInterceptsForwardingTime			=3D 101,
> +	VpExternalInterruptsForwardedCount		=3D 102,
> +	VpExternalInterruptsForwardingTime		=3D 103,
> +	VpPendingInterruptsForwardedCount		=3D 104,
> +	VpPendingInterruptsForwardingTime		=3D 105,
> +	VpEmulatedInstructionsForwardedCount		=3D 106,
> +	VpEmulatedInstructionsForwardingTime		=3D 107,
> +	VpDebugRegisterAccessesForwardedCount		=3D 108,
> +	VpDebugRegisterAccessesForwardingTime		=3D 109,
> +	VpPageFaultInterceptsForwardedCount		=3D 110,
> +	VpPageFaultInterceptsForwardingTime		=3D 111,
> +	VpVmclearEmulationCount				=3D 112,
> +	VpVmclearEmulationTime				=3D 113,
> +	VpVmptrldEmulationCount				=3D 114,
> +	VpVmptrldEmulationTime				=3D 115,
> +	VpVmptrstEmulationCount				=3D 116,
> +	VpVmptrstEmulationTime				=3D 117,
> +	VpVmreadEmulationCount				=3D 118,
> +	VpVmreadEmulationTime				=3D 119,
> +	VpVmwriteEmulationCount				=3D 120,
> +	VpVmwriteEmulationTime				=3D 121,
> +	VpVmxoffEmulationCount				=3D 122,
> +	VpVmxoffEmulationTime				=3D 123,
> +	VpVmxonEmulationCount				=3D 124,
> +	VpVmxonEmulationTime				=3D 125,
> +	VpNestedVMEntriesCount				=3D 126,
> +	VpNestedVMEntriesTime				=3D 127,
> +	VpNestedSLATSoftPageFaultsCount			=3D 128,
> +	VpNestedSLATSoftPageFaultsTime			=3D 129,
> +	VpNestedSLATHardPageFaultsCount			=3D 130,
> +	VpNestedSLATHardPageFaultsTime			=3D 131,
> +	VpInvEptAllContextEmulationCount		=3D 132,
> +	VpInvEptAllContextEmulationTime			=3D 133,
> +	VpInvEptSingleContextEmulationCount		=3D 134,
> +	VpInvEptSingleContextEmulationTime		=3D 135,
> +	VpInvVpidAllContextEmulationCount		=3D 136,
> +	VpInvVpidAllContextEmulationTime		=3D 137,
> +	VpInvVpidSingleContextEmulationCount		=3D 138,
> +	VpInvVpidSingleContextEmulationTime		=3D 139,
> +	VpInvVpidSingleAddressEmulationCount		=3D 140,
> +	VpInvVpidSingleAddressEmulationTime		=3D 141,
> +	VpNestedTlbPageTableReclamations		=3D 142,
> +	VpNestedTlbPageTableEvictions			=3D 143,
> +	VpFlushGuestPhysicalAddressSpaceHypercalls	=3D 144,
> +	VpFlushGuestPhysicalAddressListHypercalls	=3D 145,
> +	VpPostedInterruptNotifications			=3D 146,
> +	VpPostedInterruptScans				=3D 147,
> +	VpTotalCoreRunTime				=3D 148,
> +	VpMaximumRunTime				=3D 149,
> +	VpHwpRequestContextSwitches			=3D 150,
> +	VpWaitingForCpuTimeBucket0			=3D 151,
> +	VpWaitingForCpuTimeBucket1			=3D 152,
> +	VpWaitingForCpuTimeBucket2			=3D 153,
> +	VpWaitingForCpuTimeBucket3			=3D 154,
> +	VpWaitingForCpuTimeBucket4			=3D 155,
> +	VpWaitingForCpuTimeBucket5			=3D 156,
> +	VpWaitingForCpuTimeBucket6			=3D 157,
> +	VpVmloadEmulationCount				=3D 158,
> +	VpVmloadEmulationTime				=3D 159,
> +	VpVmsaveEmulationCount				=3D 160,
> +	VpVmsaveEmulationTime				=3D 161,
> +	VpGifInstructionEmulationCount			=3D 162,
> +	VpGifInstructionEmulationTime			=3D 163,
> +	VpEmulatedErrataSvmInstructions			=3D 164,
> +	VpPlaceholder1					=3D 165,
> +	VpPlaceholder2					=3D 166,
> +	VpPlaceholder3					=3D 167,
> +	VpPlaceholder4					=3D 168,
> +	VpPlaceholder5					=3D 169,
> +	VpPlaceholder6					=3D 170,
> +	VpPlaceholder7					=3D 171,
> +	VpPlaceholder8					=3D 172,
> +	VpPlaceholder9					=3D 173,
> +	VpPlaceholder10					=3D 174,
> +	VpSchedulingPriority				=3D 175,
> +	VpRdpmcInstructionsCount			=3D 176,
> +	VpRdpmcInstructionsTime				=3D 177,
> +	VpPerfmonPmuMsrAccessesCount			=3D 178,
> +	VpPerfmonLbrMsrAccessesCount			=3D 179,
> +	VpPerfmonIptMsrAccessesCount			=3D 180,
> +	VpPerfmonInterruptCount				=3D 181,
> +	VpVtl1DispatchCount				=3D 182,
> +	VpVtl2DispatchCount				=3D 183,
> +	VpVtl2DispatchBucket0				=3D 184,
> +	VpVtl2DispatchBucket1				=3D 185,
> +	VpVtl2DispatchBucket2				=3D 186,
> +	VpVtl2DispatchBucket3				=3D 187,
> +	VpVtl2DispatchBucket4				=3D 188,
> +	VpVtl2DispatchBucket5				=3D 189,
> +	VpVtl2DispatchBucket6				=3D 190,
> +	VpVtl1RunTime					=3D 191,
> +	VpVtl2RunTime					=3D 192,
> +	VpIommuHypercalls				=3D 193,
> +	VpCpuGroupHypercalls				=3D 194,
> +	VpVsmHypercalls					=3D 195,
> +	VpEventLogHypercalls				=3D 196,
> +	VpDeviceDomainHypercalls			=3D 197,
> +	VpDepositHypercalls				=3D 198,
> +	VpSvmHypercalls					=3D 199,
> +	VpBusLockAcquisitionCount			=3D 200,
> +	VpUnused					=3D 201,
> +	VpRootDispatchThreadBlocked			=3D 202,
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	VpSysRegAccessesCount				=3D 9,
> +	VpSysRegAccessesTime				=3D 10,
> +	VpSmcInstructionsCount				=3D 11,
> +	VpSmcInstructionsTime				=3D 12,
> +	VpOtherInterceptsCount				=3D 13,
> +	VpOtherInterceptsTime				=3D 14,
> +	VpExternalInterruptsCount			=3D 15,
> +	VpExternalInterruptsTime			=3D 16,
> +	VpPendingInterruptsCount			=3D 17,
> +	VpPendingInterruptsTime				=3D 18,
> +	VpGuestPageTableMaps				=3D 19,
> +	VpLargePageTlbFills				=3D 20,
> +	VpSmallPageTlbFills				=3D 21,
> +	VpReflectedGuestPageFaults			=3D 22,
> +	VpMemoryInterceptMessages			=3D 23,
> +	VpOtherMessages					=3D 24,
> +	VpLogicalProcessorMigrations			=3D 25,
> +	VpAddressDomainFlushes				=3D 26,
> +	VpAddressSpaceFlushes				=3D 27,
> +	VpSyntheticInterrupts				=3D 28,
> +	VpVirtualInterrupts				=3D 29,
> +	VpApicSelfIpisSent				=3D 30,
> +	VpGpaSpaceHypercalls				=3D 31,
> +	VpLogicalProcessorHypercalls			=3D 32,
> +	VpLongSpinWaitHypercalls			=3D 33,
> +	VpOtherHypercalls				=3D 34,
> +	VpSyntheticInterruptHypercalls			=3D 35,
> +	VpVirtualInterruptHypercalls			=3D 36,
> +	VpVirtualMmuHypercalls				=3D 37,
> +	VpVirtualProcessorHypercalls			=3D 38,
> +	VpHardwareInterrupts				=3D 39,
> +	VpNestedPageFaultInterceptsCount		=3D 40,
> +	VpNestedPageFaultInterceptsTime			=3D 41,
> +	VpLogicalProcessorDispatches			=3D 42,
> +	VpWaitingForCpuTime				=3D 43,
> +	VpExtendedHypercalls				=3D 44,
> +	VpExtendedHypercallInterceptMessages		=3D 45,
> +	VpMbecNestedPageTableSwitches			=3D 46,
> +	VpOtherReflectedGuestExceptions			=3D 47,
> +	VpGlobalIoTlbFlushes				=3D 48,
> +	VpGlobalIoTlbFlushCost				=3D 49,
> +	VpLocalIoTlbFlushes				=3D 50,
> +	VpLocalIoTlbFlushCost				=3D 51,
> +	VpFlushGuestPhysicalAddressSpaceHypercalls	=3D 52,
> +	VpFlushGuestPhysicalAddressListHypercalls	=3D 53,
> +	VpPostedInterruptNotifications			=3D 54,
> +	VpPostedInterruptScans				=3D 55,
> +	VpTotalCoreRunTime				=3D 56,
> +	VpMaximumRunTime				=3D 57,
> +	VpWaitingForCpuTimeBucket0			=3D 58,
> +	VpWaitingForCpuTimeBucket1			=3D 59,
> +	VpWaitingForCpuTimeBucket2			=3D 60,
> +	VpWaitingForCpuTimeBucket3			=3D 61,
> +	VpWaitingForCpuTimeBucket4			=3D 62,
> +	VpWaitingForCpuTimeBucket5			=3D 63,
> +	VpWaitingForCpuTimeBucket6			=3D 64,
> +	VpHwpRequestContextSwitches			=3D 65,
> +	VpPlaceholder2					=3D 66,
> +	VpPlaceholder3					=3D 67,
> +	VpPlaceholder4					=3D 68,
> +	VpPlaceholder5					=3D 69,
> +	VpPlaceholder6					=3D 70,
> +	VpPlaceholder7					=3D 71,
> +	VpPlaceholder8					=3D 72,
> +	VpContentionTime				=3D 73,
> +	VpWakeUpTime					=3D 74,
> +	VpSchedulingPriority				=3D 75,
> +	VpVtl1DispatchCount				=3D 76,
> +	VpVtl2DispatchCount				=3D 77,
> +	VpVtl2DispatchBucket0				=3D 78,
> +	VpVtl2DispatchBucket1				=3D 79,
> +	VpVtl2DispatchBucket2				=3D 80,
> +	VpVtl2DispatchBucket3				=3D 81,
> +	VpVtl2DispatchBucket4				=3D 82,
> +	VpVtl2DispatchBucket5				=3D 83,
> +	VpVtl2DispatchBucket6				=3D 84,
> +	VpVtl1RunTime					=3D 85,
> +	VpVtl2RunTime					=3D 86,
> +	VpIommuHypercalls				=3D 87,
> +	VpCpuGroupHypercalls				=3D 88,
> +	VpVsmHypercalls					=3D 89,
> +	VpEventLogHypercalls				=3D 90,
> +	VpDeviceDomainHypercalls			=3D 91,
> +	VpDepositHypercalls				=3D 92,
> +	VpSvmHypercalls					=3D 93,
> +	VpLoadAvg					=3D 94,
> +	VpRootDispatchThreadBlocked			=3D 95,

In current code, VpRootDispatchThreadBlocked on ARM64 is 94. Is that an
error that is being corrected by this patch?

> +#endif
> +	VpStatsMaxCounter
> +};
> +
> +enum hv_stats_lp_counters {			/* HV_CPU_COUNTER */
> +	LpGlobalTime				=3D 1,
> +	LpTotalRunTime				=3D 2,
> +	LpHypervisorRunTime			=3D 3,
> +	LpHardwareInterrupts			=3D 4,
> +	LpContextSwitches			=3D 5,
> +	LpInterProcessorInterrupts		=3D 6,
> +	LpSchedulerInterrupts			=3D 7,
> +	LpTimerInterrupts			=3D 8,
> +	LpInterProcessorInterruptsSent		=3D 9,
> +	LpProcessorHalts			=3D 10,
> +	LpMonitorTransitionCost			=3D 11,
> +	LpContextSwitchTime			=3D 12,
> +	LpC1TransitionsCount			=3D 13,
> +	LpC1RunTime				=3D 14,
> +	LpC2TransitionsCount			=3D 15,
> +	LpC2RunTime				=3D 16,
> +	LpC3TransitionsCount			=3D 17,
> +	LpC3RunTime				=3D 18,
> +	LpRootVpIndex				=3D 19,
> +	LpIdleSequenceNumber			=3D 20,
> +	LpGlobalTscCount			=3D 21,
> +	LpActiveTscCount			=3D 22,
> +	LpIdleAccumulation			=3D 23,
> +	LpReferenceCycleCount0			=3D 24,
> +	LpActualCycleCount0			=3D 25,
> +	LpReferenceCycleCount1			=3D 26,
> +	LpActualCycleCount1			=3D 27,
> +	LpProximityDomainId			=3D 28,
> +	LpPostedInterruptNotifications		=3D 29,
> +	LpBranchPredictorFlushes		=3D 30,
> +#if IS_ENABLED(CONFIG_X86_64)
> +	LpL1DataCacheFlushes			=3D 31,
> +	LpImmediateL1DataCacheFlushes		=3D 32,
> +	LpMbFlushes				=3D 33,
> +	LpCounterRefreshSequenceNumber		=3D 34,
> +	LpCounterRefreshReferenceTime		=3D 35,
> +	LpIdleAccumulationSnapshot		=3D 36,
> +	LpActiveTscCountSnapshot		=3D 37,
> +	LpHwpRequestContextSwitches		=3D 38,
> +	LpPlaceholder1				=3D 39,
> +	LpPlaceholder2				=3D 40,
> +	LpPlaceholder3				=3D 41,
> +	LpPlaceholder4				=3D 42,
> +	LpPlaceholder5				=3D 43,
> +	LpPlaceholder6				=3D 44,
> +	LpPlaceholder7				=3D 45,
> +	LpPlaceholder8				=3D 46,
> +	LpPlaceholder9				=3D 47,
> +	LpPlaceholder10				=3D 48,
> +	LpReserveGroupId			=3D 49,
> +	LpRunningPriority			=3D 50,
> +	LpPerfmonInterruptCount			=3D 51,
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	LpCounterRefreshSequenceNumber		=3D 31,
> +	LpCounterRefreshReferenceTime		=3D 32,
> +	LpIdleAccumulationSnapshot		=3D 33,
> +	LpActiveTscCountSnapshot		=3D 34,
> +	LpHwpRequestContextSwitches		=3D 35,
> +	LpPlaceholder2				=3D 36,
> +	LpPlaceholder3				=3D 37,
> +	LpPlaceholder4				=3D 38,
> +	LpPlaceholder5				=3D 39,
> +	LpPlaceholder6				=3D 40,
> +	LpPlaceholder7				=3D 41,
> +	LpPlaceholder8				=3D 42,
> +	LpPlaceholder9				=3D 43,
> +	LpSchLocalRunListSize			=3D 44,
> +	LpReserveGroupId			=3D 45,
> +	LpRunningPriority			=3D 46,
> +#endif
> +	LpStatsMaxCounter
> +};
> +
> +/*
> + * Hypervisor statsitics page format

s/statsitics/statistics/

> + */
> +struct hv_stats_page {
> +	union {
> +		u64 hv_cntrs[HvStatsMaxCounter];		/* Hypervisor counters
> */
> +		u64 pt_cntrs[PartitionStatsMaxCounter];		/* Partition
> counters */
> +		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> +		u64 lp_cntrs[LpStatsMaxCounter];		/* LP counters */
> +		u8 data[HV_HYP_PAGE_SIZE];
> +	};
> +} __packed;
> +
>  /* Bits for dirty mask of hv_vp_register_page */
>  #define HV_X64_REGISTER_CLASS_GENERAL	0
>  #define HV_X64_REGISTER_CLASS_IP	1
> --
> 2.34.1


