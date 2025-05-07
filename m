Return-Path: <linux-hyperv+bounces-5406-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33036AAE541
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CD3507C20
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E728B7EE;
	Wed,  7 May 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oaihHAt9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012040.outbound.protection.outlook.com [52.103.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5528B7D3;
	Wed,  7 May 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632826; cv=fail; b=iOA4Sl6rzn0b5hySxJaJ1+NXx4H7Ga1vUNE0clN9FHu2FsOQbELw6pc0Py0PtFnQzi8epIlb/xBW8fSJnq3VhMk9gWwaDl1qDFZEvuwScQit9OMRVxyPsoXhVaJ/pNaD9YeTW+mG9eojvSv8GITuGXmJxr2/jY4gfcT/PTqy53Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632826; c=relaxed/simple;
	bh=RRWr5825lgj72o45UTGGxj4oX91td/S92d01weZnIDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fMiElwL4MIlWWNuoDujymeIPYq/qH9H+o3BaDL9jqaeJcx3kxZjsjieEuTB7TIT521fmsRlIMekJ6g+Ou6lpTEfNlulftPagVObqyxJ+afq7bYe5NmTimEz9hIbw8rg7YoApQpN7BidFfmXBhebD2KZgjfrr7n8QFJZZO7ddpiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oaihHAt9; arc=fail smtp.client-ip=52.103.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGxiC1F9NjYxl2OxDcR8y94PH2i5CJEQVVPwiNNagWOUqyR3tkSzJsv5jNOFgSfRMzaBsSyjOm918SaD2t1N2xt3zUy1GCv7N2LKN5BtLfrw8Ab6fxEdHekjZgfkFrrH5gHch78fK9YKou+28Wv+6vI+gwB6cQkMz1hko31A/xwH6iXUYLczeKM/z1IjKHqdP37d92aF9rlPzyT4M4QKIxT5QwTNIUUwcPIvHUJib8yILor5TznyiJJat0jI5cuc12Gk+r4LrmM8+EAHDizQhT32mLbNm5RIVM6oqXJHk9BBug3EKs0KfHVxuNhd/2LtdFEZEWUAGlFyy7K/eVQAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc/UuXz46DX3Y74tBS3fF2dD4HB6s6Z/etZZNo6cVhY=;
 b=ANwpWMDiMcUfZTv6Q5QAQVcbjsxv061rNBd6MERTVpzfuhEs1gc8hHe8phMen6bu9vZYke5JeODNTc6TfM9r9UZvPob1+RzF1tL8DX6wl0YhwrJJp3JWhJYxhj7ZQcLzZ4SB533Y8qBTp/Qc7hE01M9hxZQrElbVXY9H3JWC0aHDhv4u19LqyGLiC6xE2XSDFyJF5kcyVolC6S4l1JbnjvASamF9BkLz5wABadbU8Go8Va6qg468QjdMQVDP5grKN8bf0eBfcvyPFbd4PreT1C7rENFYkbFGsRlV6pD3kEp3Tv22CwSR68tCygaoMfh+602efKcyqDjnoYmg3gjnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc/UuXz46DX3Y74tBS3fF2dD4HB6s6Z/etZZNo6cVhY=;
 b=oaihHAt90tHddrFkP4dTtzvWdpioR5wuKKb6Ca+WHq39OLPJ6iha7bnUTcGJNGAPReln/WKCnvgpOhekdntMl5R+4p4WjMqVdZqc7NJsXFsoOrfBmd6yrV+ONeJY8w9ycfxNVZD9K6qHZhTimcfEEG371MieUXLT83fUVF+ssvoTRKKUUeDfe4CYjUvGtkhO+AZveYciXdPhBEy6+13Qlvb59wk1T3vlqNH9iU/6VV9kZKfSN8ISjB6VpaLj5RduMm/t5mH5twXQGqIHl2qp9m56ddr9zdY6NQZ+r9utnE+6xA0YwSHSjenYx5azN7dcqiUehKsOMzGmUMoTgzns1w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8989.namprd02.prod.outlook.com (2603:10b6:930:3a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.13; Wed, 7 May
 2025 15:47:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:47:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Patch v3 1/5] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Topic: [Patch v3 1/5] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Index: AQHbvlIQSYTtRW7n4kOvNwRljEHHVLPHUZPw
Date: Wed, 7 May 2025 15:47:02 +0000
Message-ID:
 <SN6PR02MB4157DC938A00F0B57780A117D488A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
 <1746492997-4599-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746492997-4599-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8989:EE_
x-ms-office365-filtering-correlation-id: 1270773a-a900-4cee-8952-08dd8d7e6910
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6eredufKlHx3shQhUbyqdtF72ZGqvs1SGg8dtRD0qym+fb5m9B+RBOLjsgP5KHqkSvY1kDlZA/BRor20JEcYD6Cpn7BMZUSl2kzlAZaz4ISUCNVr8aZn0xAJ25Xis04JkwYVUKqzTyPNl077JIQwJ7Hqywdo/G/1N8QiHTyWuzUusvpX2ont/SiSJbQ4+O3LAqTsNe6Jgca1VUmsq93AmybfYRmQBZRqwEcTojg9DADwMrs3O4fCs7YeVy+QJWeXtEi+rXH08CI7cvbmNncRnkGoGH8vTJAeARMwTFqB8NBtNknAprPajxWrR08AC9gOPskQzT5XuZNO6V27XaP9qmOZ5AZHVjNZDnx77Mp/EOCKr+ZAFwTxIPPy4byf79wgFMUaJ34J5hD76WM1bib8u3KTL92cT5TfynAjl8Rzw+SqN/jnBgV7h+pfmKmmdF8HROw9+YJrgYkHGvXTcq+OzY+TiPrfkAmM4zivtlD3mI1rJxVZAJ6VV0X78gZxlfWrwF/pfda1clKZL1p/uJH5sF65yklS82PmFXwH064ibqrXEt3ncxyC4BfbBxM9psFuhqH2EJ5rhZ4Qnk8jVTu815dpluv9uh234h+Qb2mF7Jdq32Nx/iOtsm9k5frSYYbp1nzRumkzJkCZDej9Iqr1q/ouPIvpBcRAoSJ6Yso5u7ojjAKVl45w6iXY+MWNrtCGW974aBhNdipZVHKXsS01CIcnvFkQuLvKbjMePgjXbVWOi/1Y/VIoBUX7mDLHRJx1J0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799009|8062599006|8060799009|19110799006|102099032|3412199025|440099028|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?etNYOk8N/7w1rAJRsMo66TEjGSRDlZEsYLkJxITOSugZzQgqr2VkZ3qf5cLr?=
 =?us-ascii?Q?DI43s6T8Kei/ZKefTvDB8j1nyI4onKcrgmGvquPyV9Zy/rI3HUdya6xlZp85?=
 =?us-ascii?Q?qLjqbPYsn6ZNR0DEo8+cUwBSTS/1cu7sUfahA72OMExW9T0AeIojxmIsxwkF?=
 =?us-ascii?Q?4gks4uE5OI/Z+kHLgqSwIOmOX+rK9y7+eifFbhqo4kBRJqRQHVcwvL1xlQzC?=
 =?us-ascii?Q?hl0bZfyr41AMcpm+mAra+FceRTMELH9Ig5JKJ6DLFd0OTEaZqWbTZfdCGn5O?=
 =?us-ascii?Q?lsfswxLZ4smKaO8q4lwQDT05O5nSxAhjXfk/9I1qHakvXmv53ihsbixgx6+U?=
 =?us-ascii?Q?3YN938NonzL2AQLARP/ckmoNnreHCTxutY6TrLjop4dxp1aTC3tiUfgs+xYA?=
 =?us-ascii?Q?494oKQURNXyUdpaPgBaGYDZ6cXZf2UssDXPFJgE7/dadVD45E3wB9UZML5cR?=
 =?us-ascii?Q?plkMzL9JcHbqM9xwZpeZ6FL8MrwHblSgx5GZyzcu8KM7kBOwO0IgWQrtZPDg?=
 =?us-ascii?Q?bPUufLqobVgMbqkWVF6QmKmwUUMqxogsMk1qXalSSq4GCBRaxcROEhDflJXs?=
 =?us-ascii?Q?9vKXGEMTzcuk7PPmUI3mNYySRd1yNQCBJvwn5+cQG+YTRVdMEKl3QeOXQhbp?=
 =?us-ascii?Q?53wjmNr79b0XOrRnTnfOUND3lP6Jc5LcbPJ1zU9ZtRCEOSmMUJ78Spbxm+0R?=
 =?us-ascii?Q?rrq8sVc42Idh6/u2pLFmytE+svFR4wR3ZqyyJeLd8DQVJuiJx1iuTd/3iEwW?=
 =?us-ascii?Q?wA0djDDzzpP1EJrFQ3pqBCXXMh5bGBKE0v4Pk3GDEAViPpdwlAFgqaVUAil3?=
 =?us-ascii?Q?N7DL1Gtw+R/9LtCzV04Nueg8mBVwDed/G9MjOTmRXCxJ2JUNtwlh6bKzv2zK?=
 =?us-ascii?Q?MOrKodypXT3hUAqIGrr6IgqySoO9wr+AXGSSPeIinTT+SJWtVHPJrZ8lRTpo?=
 =?us-ascii?Q?aRgJmICKazzafFfzq4BkAXPrHwi236eBTu7fUn49kSZxvEI8Ei3xf59oSEa9?=
 =?us-ascii?Q?wkeDZzapgpcha3cCtvQdmX4hYksYFtYqUGUjTnPMe1Sun2bAvBoVJnYYfKBM?=
 =?us-ascii?Q?xHmBrLkcVJuFwQu/IXafo3rwXRFclzY0HErr/JV0FY5a09S1cBP+syOcqyZu?=
 =?us-ascii?Q?e5oHhPf39+bipmYJKqZtGM2EXYxdwksvbA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W29Npv7rvoy1aS9eNV3Y9cFZnYMGpWeSZwvYWFXaA6NRz7v+8RGv6gTlzucj?=
 =?us-ascii?Q?UbBS5MzXPB8tZbN8iksucmQixvLzyosUZa/u384ol8oK24X5V5YFP54wgHzZ?=
 =?us-ascii?Q?pCG9Uli4gyXs6D5WUcJT1ZGjauSiFqVP6DTDSoOm6mONTsHR37W7BV2mntXN?=
 =?us-ascii?Q?sgDLwjUXmTYVP5xdD1R+9PCqCqJnd1ovr69JhoENv+cbuVR9XRTlrq4Hg0aK?=
 =?us-ascii?Q?z+9B7Pje5y3X+DgmTQWjF4Z0f8bqtO0mrnMhNG5b9THzKQvFL45g2HCBN59W?=
 =?us-ascii?Q?GeJNCMWG2CM/AIJncTKRlrD9rqnI+0o068As630PM/lLumKCAtUcb1uymcLa?=
 =?us-ascii?Q?n6Ag05mWW5TCBUPM1r7GC6oCZrxJbIuL2nI/OPCOtzA4PujcOlKyguxfL6bj?=
 =?us-ascii?Q?Q4tmJUQJdskaMdO4cAs9CuSFKV8pymQpkx/o6E4icssPuY7BmScBIWfVVOZ4?=
 =?us-ascii?Q?p4+OsdU4K/jGZhvSS+ep3o9pc8IcO2FXABWQI4BIemS3z3LMxJPCO+W5xrkr?=
 =?us-ascii?Q?0IE16yANiT1Rw7HTZnaDdfhqfw+PKRWgkMYbWvRIJlyY45YRMsJHF5Hae0C4?=
 =?us-ascii?Q?so6nTb9+bUefYwQVh8rw11jenzh+ddfjbW2oVWopEXVYq78N+oFOe0zlwQn3?=
 =?us-ascii?Q?eti3QZ4bVXNiw1hkwObjhHQugeAwCveCMUIqXpPv61yjQjx74myxcvAJogTT?=
 =?us-ascii?Q?9rD96etdQjhIy4y1NvlsDaKXwl6gknHftVNyX/gesm4TEXeKVc65zxAPVFol?=
 =?us-ascii?Q?Qk12akjyqDH46HU9WAK5/ZMXyvwGcYvlMJo2nHiUE5q6omJOolf9TyVIMf88?=
 =?us-ascii?Q?p/kv0RAxM/OjQxk/VHrE4mjAvVSenU2UQV5aynzKlsf925sc1zhJtnW6hBqk?=
 =?us-ascii?Q?CWoqrC/igPjLzcSduJXVh9WSkOysIqGrSFCYptRPQq1c57+Zxs89x9mM+fbA?=
 =?us-ascii?Q?big/vJZSxGli/wCmaR0kHUA0R/cLaOI+DB22wOX2Ab2qoJcvw2prR2QlZGVe?=
 =?us-ascii?Q?aU1fSx/dldjsrTPtjT0sSWuk+1E+tVmXXX1nxF1J38bG5AIRUMGKSfoEidfm?=
 =?us-ascii?Q?Txr+kxXHpeYzc5+RIA1umOOXfLNrTSjwD51Qjze1LVLFWGqDyVAmF34+GmPg?=
 =?us-ascii?Q?SF7a7iAuvpD0miT48cLTLbwGKXZeEKQCybKSQuGvlPidW3Qio4b4ZV1vzzOY?=
 =?us-ascii?Q?hJZbVsNND9w7z2Iwpocmfk1TYawfpXGAh8Ys9HKuObL/rh82NADgkZB7PVE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1270773a-a900-4cee-8952-08dd8d7e6910
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 15:47:02.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8989

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, May=
 5, 2025 5:57 PM
>=20
> There are use cases that interrupt and monitor pages are mapped to
> user-mode through UIO, so they need to be system page aligned. Some
> Hyper-V allocation APIs introduced earlier broke those requirements.
>=20
> Fix this by using page allocation functions directly for interrupt
> and monitor pages.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca48739e59df ("Drivers: hv: vmbus: Move Hyper-V page allocator to =
arch neutral code")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/connection.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 8351360bba16..be490c598785 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -206,11 +206,20 @@ int vmbus_connect(void)
>  	INIT_LIST_HEAD(&vmbus_connection.chn_list);
>  	mutex_init(&vmbus_connection.channel_mutex);
>=20
> +	/*
> +	 * The following Hyper-V interrupt and monitor pages can be used by
> +	 * UIO for mapping to user-space, so they should always be allocated on
> +	 * system page boundaries. The system page size must be >=3D the Hyper-=
V
> +	 * page size.
> +	 */
> +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> +
>  	/*
>  	 * Setup the vmbus event connection for channel interrupt
>  	 * abstraction stuff
>  	 */
> -	vmbus_connection.int_page =3D hv_alloc_hyperv_zeroed_page();
> +	vmbus_connection.int_page =3D
> +		(void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>  	if (vmbus_connection.int_page =3D=3D NULL) {
>  		ret =3D -ENOMEM;
>  		goto cleanup;
> @@ -225,8 +234,8 @@ int vmbus_connect(void)
>  	 * Setup the monitor notification facility. The 1st page for
>  	 * parent->child and the 2nd page for child->parent
>  	 */
> -	vmbus_connection.monitor_pages[0] =3D hv_alloc_hyperv_page();
> -	vmbus_connection.monitor_pages[1] =3D hv_alloc_hyperv_page();
> +	vmbus_connection.monitor_pages[0] =3D (void *)__get_free_page(GFP_KERNE=
L);
> +	vmbus_connection.monitor_pages[1] =3D (void *)__get_free_page(GFP_KERNE=
L);
>  	if ((vmbus_connection.monitor_pages[0] =3D=3D NULL) ||
>  	    (vmbus_connection.monitor_pages[1] =3D=3D NULL)) {
>  		ret =3D -ENOMEM;
> @@ -342,21 +351,23 @@ void vmbus_disconnect(void)
>  		destroy_workqueue(vmbus_connection.work_queue);
>=20
>  	if (vmbus_connection.int_page) {
> -		hv_free_hyperv_page(vmbus_connection.int_page);
> +		free_page((unsigned long)vmbus_connection.int_page);
>  		vmbus_connection.int_page =3D NULL;
>  	}
>=20
>  	if (vmbus_connection.monitor_pages[0]) {
>  		if (!set_memory_encrypted(
>  			(unsigned long)vmbus_connection.monitor_pages[0], 1))
> -			hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
> +			free_page((unsigned long)
> +				vmbus_connection.monitor_pages[0]);
>  		vmbus_connection.monitor_pages[0] =3D NULL;
>  	}
>=20
>  	if (vmbus_connection.monitor_pages[1]) {
>  		if (!set_memory_encrypted(
>  			(unsigned long)vmbus_connection.monitor_pages[1], 1))
> -			hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
> +			free_page((unsigned long)
> +				vmbus_connection.monitor_pages[1]);
>  		vmbus_connection.monitor_pages[1] =3D NULL;
>  	}
>  }
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

