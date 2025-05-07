Return-Path: <linux-hyperv+bounces-5410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D7AAE57A
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AAC7BCA8E
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1A28C85E;
	Wed,  7 May 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Vgahu7nV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010022.outbound.protection.outlook.com [52.103.2.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5828C851;
	Wed,  7 May 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632983; cv=fail; b=j0/EGU6lRwpnIBWA/ki6T6+5ZNAmBz7bjHKp7LLOK6zdRUAmE0GU73NYJ5jJHEA0Sk5UjoyD7FNL7Omm2DuE/TcGAKSurgnJtBNqvECY4CHyw/nXtB/nEqfAWpF3W8iUceKFKE5m5iEJ0fpNypN3I1189l/Vz37aqcpqs2AOg2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632983; c=relaxed/simple;
	bh=1WRdiT2oXjv0kysEqBKrWsEYfvhAdmawiwjEoDfOFCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ds3aVMf2nG9ex8Lrl9op2ho/vp0XOeGfhgyXCX/LRshnrKGTusWV7aPouHQfAbBlvn063Ut1AU1zza3edXcz/aKkZCQBRj/4sJ4ZAvkEUfwpyPFh4lqmA46OglFr1+Az3dFK8wtcncGMMq0S2nEhzG0PPo9ofI0YwWDVfBq+hk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Vgahu7nV; arc=fail smtp.client-ip=52.103.2.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+a6T0J8IGJR3F9RZgGB+iTSBV9JfXADUNIHc/VueybRPgV+50/NwFzI3RRX/cZoqfZIJO1lzNtz1hCNw7OYX6P99xZL1ulH1NWiN/UdJyesSwNMnN/k7OJPVtPxBFCwlqTFUNAIvbHQxB3NiCH1b+poZrzFYk8N7n6lLOpGbKSG+hIO7kn0Pubq0nXzQXps+TTEiBpXFxRv1/ooxJ3O3Na9R34gafMbHevtU18oNAciXc02E7OkAbAwUe0cHvP59cexnisBrbpECt2NX714cNriE1XKTCPEmq7y6IM6wIg4LHbFhbmJ8S4BqbpkVsr+n1lxHvqKO0dWeAlOPNNWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMWHYICSPGPvBAfFQyI2boPTYTrohVKLjlAUhdLhNn0=;
 b=vVd5TbOXXT6tO1Ch2mUqOUTQvLI97jcVQsPBfHM2m69NwDfUUI8M6W1hjIbWJLcHgkVeRu6tK1MxZZcPUTrEUXUQ25qlntIGoXIyMSctFxjua+s1l9UEjkaYeu3rMQI59JS0tI1FNM2n4BQrpBTovV4p6AoS9RXnyRX9JMRzr0583nwzD1ZR/lXstdzt74L1v9KmNO/kOGCFuMUHSQ4ptFF1YP2uMeeTxJZKfwdNvmZAGGvCib46PFHQrv97BZADP87++5drw9WPkiyqhpg7gBfgTPZIB+wt4icWPHJF7xG96Oot95GGkNidcb4OeJ3X/m0CcViGx+22teddqpEvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMWHYICSPGPvBAfFQyI2boPTYTrohVKLjlAUhdLhNn0=;
 b=Vgahu7nVyBvV168hYyvUlD1luGfFGb7+CD1b1Kp6niY43bQ5hrIHJ/MO+A/CBxCfKrTpTD6OR7G9qthr2NBj6ocFJRlfIV4uYFjrwLRVxue4bcmTFh3vJzk6mpv/sJT262np2QBJ6yQNQLNImICxgLPpGLLZEj5vMN+WUSZEYJ8vjl8XAtY/sbiHksrcGx0ji2+FDCrp3Wn9jxcm0rgpKCX2FqgX9MnG/UvX4GQKIUo8CeO1ksoVOHmrOG8/MQLdPyz9K4ayLnRWxzhgURFug4gouum8R28bc75JLmbwOBy81gqqBLK3cUNOPz3m2QRDMnMmpJxFJCzWAf1W9ZobXQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8989.namprd02.prod.outlook.com (2603:10b6:930:3a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.13; Wed, 7 May
 2025 15:49:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:49:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [Patch v3 5/5] Drivers: hv: Remove hv_alloc/free_* helpers
Thread-Topic: [Patch v3 5/5] Drivers: hv: Remove hv_alloc/free_* helpers
Thread-Index: AQHbvlILMjyYe/F7qUatpmh9gliMfrPHUlqQ
Date: Wed, 7 May 2025 15:49:40 +0000
Message-ID:
 <SN6PR02MB4157F2F8FA4A882781BFB939D488A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
 <1746492997-4599-6-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746492997-4599-6-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8989:EE_
x-ms-office365-filtering-correlation-id: 6dc40fb3-d2be-47a1-bf86-08dd8d7ec725
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnauCsN3csxfCGbxqkgDzMEq0T2g2WNDUE1nz/gDXOOBIEFVNjNQDySpQYoNwKusj02LNNAbrzH4y7tou4f+G7vHDfehmImokjUdfnDdguQekJo3CPSo+x8MxSDgPbK3L3RJr1PZBjg93obym7K52vfYPHUw1dgJZaK/4JJmWkXoguQ5Eb/wSVJHGnZW5sOU6ItH8DBBrc0rRylwXz1yrgebOjtKNblna4zra+i/+aSteCQjVgqvNNIPheNuECddFvJ0pV10qJHUUMvYUz2o54hUimW4EecfmvsX11p5fxKLBEN23ieoUsYN1CvPvldpVTHQ/opZK5/+B2PosdlqY5YtXvmnzWzjHGqlkLH/SHRWrCtO9Uv6/LU41+NQUhkkX75Nv1gF9xtbZDRYhqXpdE92vUM+G1ZGx+AblZqdcz55VS82QVsV/ohQdWgxPQQeMMG7/a3ojIBSzth33Z/KAwC98s7rJ5NtZKj21PTn/3gXzyEbNlu+Aco500wlZJB3IP2OPP7lilO2qAM9JU7mb6Re9g4Bw7uDX0Zs2Z5nM6X8ygLw8mBXjgE6i2WtdfBOuD3zbPNnlqXo6t3p8YmIRhrGMyllmxGno8IiZBkyyc97ulNb3PkpiAw20OGTZHK5UvlCmRmFt9mZBen3IrcAKC+CvDnWA4mHNi+rmM488RR0QcmnqBPZMtCpWj9cLrT0ZecxsubGHexvnVt57SrwZ60h0P0u1Fjj3Nrm67tmBBOuQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799009|8062599006|8060799009|19110799006|102099032|3412199025|440099028|11031999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H50QheImN6UN2qRKAOQOuXfSJjyklEqCMy54kbjRoaArTu3BVsbCEv11xNbV?=
 =?us-ascii?Q?Adm4E16DAJs2I31nfrxxBl6q8ERnsnglWmE1+WBxyk/JzO5YpqxqPrb/ttfo?=
 =?us-ascii?Q?esLt/06IoRm4tFXf8lmW+BCv313j6r5bAMkECu6tHbyGeNGIL538GMXo5zzz?=
 =?us-ascii?Q?jCdc0z41vduo8v3ysyIyVrYN1d0qtmpbavNlFWwRZAy09kab2MS9UAD23TVf?=
 =?us-ascii?Q?T0bc9IV6EU+b21ClVl5nADous3P5lN4Pwaq6dkKbB4druI9lrKQMopc2cIxJ?=
 =?us-ascii?Q?V6ZPZVDbCk45RUeCYca18HoBgH5pLIrRahRDezW1d5l/ad7gpcYRE0bFav6z?=
 =?us-ascii?Q?5az6Q2J1ZPXCE43IXff46SVT2i+VT1PLNSzqvIJ0+Y6F/w+ROhlL4mdA6oBO?=
 =?us-ascii?Q?ZHtYV4dOsxG7QsoieJ5I0veCirVqph2e0/jM8NYvqKssVTKPoJZAc7A6xJs+?=
 =?us-ascii?Q?YOSW43xt1Yip30dbqu01vpGxMhqXBdZ/fXMtNuLrmsJt0AskalQLk1VcNiYX?=
 =?us-ascii?Q?VvLwTNpJndPfpKgL3v0Q+2b0iSINHrA4S1TqvCeRsRoYHtkctXt3adyih09A?=
 =?us-ascii?Q?/5ezc5j6SS14RVYFyedXzxewgsgAt13XXsvEhVwsHPx8lTAcaIIqASHunJEd?=
 =?us-ascii?Q?mDVj73pYUVu8SRn6MR3xOHAz6toFdWQ+8tbAu/TcxrhqmlSaJAXjFeKwJE2w?=
 =?us-ascii?Q?YqMRmwR/T9ebYEr9Q91GkwoNbRd4tdUh74OMBjYW3NFpvlU+tVfxBYzwvnLf?=
 =?us-ascii?Q?6SlOFrkDyaZrzlChDERTAReqzQ5BoEJBET/I+cUyaEUcaZcc6hM6vZ8HKtma?=
 =?us-ascii?Q?kRHbosMGUDFvCcgKNu7ZTSrv6zmT91eg+qAc8fdcV9aX/GsWf9QZBK7aEvMd?=
 =?us-ascii?Q?ZOUL+2pEhQyMzZq/DdzQiZ9qtYHqCCCBDwq+ijSskzXRoihoafVGkoPnl6af?=
 =?us-ascii?Q?pSfqT4D6HYww3WA+m8XQv8+Z9JCK9gJOTWhCd9hY3skWnq5+SG6mpjkc+TQ7?=
 =?us-ascii?Q?Z1B+zZaTT2hVsm3NBzk08NOsusevJwfR1xJNakxB+J37c7ZUIM+fqEFcKAnA?=
 =?us-ascii?Q?vhOW05VEvw0Vk1mrN5uKIGskKwQ1kiPj5IPD+3lXum0lz+jHoAx2eE3cNPNv?=
 =?us-ascii?Q?Od2mb8z0643ewYvskBmKYb7dqo4oWRdOYbBjfrVcPuZXwabX3F/42mGUy72E?=
 =?us-ascii?Q?7w8TTSWHFuz9Xlbf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?29rYrCEBOlUGYiGkcrjUAAnTxzA2jRoKS+E7rLP4+S7zug0Ik4ukgtcFbDFr?=
 =?us-ascii?Q?zH3PwtB3qM8hwcIJXhcPhPYGABza4mAfWtMo0qwVVrNsbqt4M55lK2yxYEMA?=
 =?us-ascii?Q?M3UC+cLUTAOVwfjsZL5p7zdt67p14WexA4aRBoZAKQ9rbbcMNude4fvlJtuL?=
 =?us-ascii?Q?GTXu06rpzkEBwWIFl8ZqorrWPWlGRFn9E1aV0EKkxNAkN5EANeDjNwb0kamm?=
 =?us-ascii?Q?4jAoaBZU0bK70wL/CX4mDqeFmffF+V0z62dfq5YdhI8tqCz/5KCt0BwsO64h?=
 =?us-ascii?Q?M40Iyqpsv5Z6xhk/9si4ZP3MzEZsNm8KCWg7TUQ7hUMklJSlnEhxsqHJjQsO?=
 =?us-ascii?Q?MVTSJtwT+kPGnCsudItbxCAMTgX5VoBrjkTEDC0LLhZsoHjMvwxskgyWRYuT?=
 =?us-ascii?Q?EFSCxd1eXHn1jXuVjkB52TpOLzbezbLLbeag0+SwaRcltGChacI1DTbeXfHa?=
 =?us-ascii?Q?ezxu8nhxqEKSl6dcgPnA1Qd/GYXC4T9XQtuXSYTji+KE5BvMLMGbSkBfmWks?=
 =?us-ascii?Q?ZBZvIEZu1Eh7RCx28r73mFRe5LTTBzfp7AKmXqrU5AGow/yvZXWDojyYjic3?=
 =?us-ascii?Q?vrGtBYzOTGtWJB5UMUWYgGnNt0Z+jqdgU7nTz59NNzAxRUragvE0alop1yWb?=
 =?us-ascii?Q?E4bMHVD8ynhIU3dPh6Z25K/xKLP5Kmn+vzaemp8MkrVNyVJPTt/i99CTvX1G?=
 =?us-ascii?Q?xwO2yQ3esT/qQ/QwRLSr6NTYtg89a1kLRm2ONCUl4hXqySLr58es+Av38oIX?=
 =?us-ascii?Q?C1e3tvTDNNENwXlH3tUP5TypquGJJJvS4nWntHXab4bItM1pNZMbRwEUdrl0?=
 =?us-ascii?Q?K0dkcRhYTYyR/HjDzdG3o9mnAPOZHok7o13hDNqpbooi1i8mt7dvScfbFyex?=
 =?us-ascii?Q?yYGZPW+/N/hzKOA8wAyOzhJ8kXFyyASm3yBt/EL24PNRl7l6Qclvao4qxuy4?=
 =?us-ascii?Q?DP26XPcrBpQkqmy3Tdw/+ay+r8v1oWNnlqBNEPAQxbda1yGTlO3EAtLMOMvu?=
 =?us-ascii?Q?3DXw2YqtgcvSNlodpb3yAycfGlAJBp8zKFhUIOsPlM8bO7SwNenWOwp3xfZY?=
 =?us-ascii?Q?gwuIrCv3ZtNQrVXjgfGfz1d0GBgntrwlXoDo92o/cqCmKRZXQuD6XK72h6Wr?=
 =?us-ascii?Q?FbfwHPwLljptUh7iLrFg4N/g1fs7sbUv96WZuH0SqhuzmunOSTigxr2GZGDA?=
 =?us-ascii?Q?6y4cCxpSwg9umPh+yGNOOThES8ngLZ7lTsd+VUg8FOvnlUYs/xbBz4xXBsU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc40fb3-d2be-47a1-bf86-08dd8d7ec725
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 15:49:40.2650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8989

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, May=
 5, 2025 5:57 PM
>=20
> There are no users for those functions, remove them.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/hv_common.c         | 39 ----------------------------------
>  include/asm-generic/mshyperv.h |  4 ----
>  2 files changed, 43 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index a5a6250b1a12..421376cea17e 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -105,45 +105,6 @@ void __init hv_common_free(void)
>  	hv_synic_eventring_tail =3D NULL;
>  }
>=20
> -/*
> - * Functions for allocating and freeing memory with size and
> - * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> - * the guest page size may not be the same as the Hyper-V page
> - * size. We depend upon kmalloc() aligning power-of-two size
> - * allocations to the allocation size boundary, so that the
> - * allocated memory appears to Hyper-V as a page of the size
> - * it expects.
> - */
> -
> -void *hv_alloc_hyperv_page(void)
> -{
> -	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> -
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL);
> -	else
> -		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> -
> -void *hv_alloc_hyperv_zeroed_page(void)
> -{
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -	else
> -		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> -
> -void hv_free_hyperv_page(void *addr)
> -{
> -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> -		free_page((unsigned long)addr);
> -	else
> -		kfree(addr);
> -}
> -EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> -
>  static void *hv_panic_page;
>=20
>  /*
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index ccccb1cbf7df..4033508fbb11 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -236,10 +236,6 @@ int hv_common_cpu_init(unsigned int cpu);
>  int hv_common_cpu_die(unsigned int cpu);
>  void hv_identify_partition_type(void);
>=20
> -void *hv_alloc_hyperv_page(void);
> -void *hv_alloc_hyperv_zeroed_page(void);
> -void hv_free_hyperv_page(void *addr);
> -
>  /**
>   * hv_cpu_number_to_vp_number() - Map CPU to VP.
>   * @cpu_number: CPU number in Linux terms
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


