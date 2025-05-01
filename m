Return-Path: <linux-hyperv+bounces-5277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246CDAA5986
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 03:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB9C9A180E
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 01:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916FF22DFAA;
	Thu,  1 May 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BcX8acU8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010075.outbound.protection.outlook.com [52.103.2.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639A2144A8;
	Thu,  1 May 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746064575; cv=fail; b=vGkkAXN5gm//O7AtcFrtYB+ZZM5isEZesaPIG8CMPMaA32D7ScmRUZ7OhQoAYke/yFSfKJ6o1cVNAnqvsDiV1/S/D1Rv8TV6stDSzODorpLXIHRStfnDU7c9Q5nSljfh2OUkqt+/g1NT4IIya4TbdKWm5PyETLiXcvFnE0U4URk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746064575; c=relaxed/simple;
	bh=5s/sk4Yh4Nv4Ok5BEDt3+cufOaeS/gO9NOFAVHLAGFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgpRNCosPFO584FPLcRCXjhurxrfhGRNiSWxnRa56H+gYlJ6jJE3MOVh2vKd4fMHRcZ8ls8M4wDBOH7RNvYFeYl/74mbLQG1iNie5RwkjyfmYVdVJHoZbumsOrcx+7vFief7AJkIpw/w6PDp2Ezjx/a/hBrTEwzOW97WZFxdSvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BcX8acU8; arc=fail smtp.client-ip=52.103.2.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQDn0hpKtYFxaQLX7c51brApLTpuVV31wnpnKKomWnlJQHF5OAJv+nsXKwYD7lVRExZ3oC+0qQRdPKj29hHZbUUMQRiGkrM0J1u8Z8FNccbfHzl7Adz3CFYi/OwU6J3T6RhuAZU5UHmp/mzr8et/tvzfDlZE8XKqPWohX5ruZijJTWuek2cjS1WAoKr2mue35Ij5JA+CDT1Hrtiw5G8Tho91EnO4XSvCj+RUCtTgICwaEtGNSwfCnbIjveQjTHZGzm+OjUMF29mj0C7eFbIBbadSCvIbJhZXs1aVUKMF0sIL/XOJBGRYD/tg3zaFLaY/+JEJJv9vvrs0nMRBdqsegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbIKqOhy57JA93RFPi24eteNQBUfmXVNHx2tRMTEGT8=;
 b=yj0ceqPQlb/mqyDnand4zEInFMy4FFI1uUTN5WgygXxMm4XpLKIZ/SXfY1wnTbF3GMLN7aH/1jWP5GHjTSA8OWytlT4bfC3vBjsyESP2K17Ot1MOamngDAp3xkR94h3voZtkvJ8tx6fs652T8cQ0DeqoMmK61MYOrfOPJBp6WzQ3XlPHhLPGgpyEHm1GShkKcyHv14g1mjA1eIp4iVEmPgmLymQHZ0E1/V6OG3mpqRE1HFLXCOMCJ7cpM9042e7o5ag8CzMEWU4q0EyF9DvZPQNxYtFSEskFF8z4DiG5z5AE3mmXq5Tl8GduGyQOCUe6Ie4UQEyBnicvLKe9Ej23BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbIKqOhy57JA93RFPi24eteNQBUfmXVNHx2tRMTEGT8=;
 b=BcX8acU8b1jF9nkVm+BBtaOHYEeCpIEmfRn+NIhgf8VIsCqMgBsOaeyb3sLzlmmyHUO8vZZzaGpweqGgqGSfgqmErybFiBy3wG5futw9hrIQgQV1zazU+HQO0MxgIZ3/nm9poDD3InR7QBh22mrqMsDK4HR7XXTrZik84IbukRZQL4R9+7ibqq0G+H+0r5B5nT3ot8ipyIf4AXGQwA+v+o9GveSwInijGcRwNCXCZ6H2O29/yehqgPaORWBAwxPCJtO73rsSrm8a5i95d9S62gEN2+fAGkKy0+GjoeCwcqvt5Qwa09agjw6Lc/6YEdtUuNfNoqpWNE+VBssVbJI87w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10650.namprd02.prod.outlook.com (2603:10b6:208:506::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Thu, 1 May
 2025 01:56:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Thu, 1 May 2025
 01:56:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: RE: [Patch v2 4/4] Drivers: hv: Remove hv_free/alloc_* helpers
Thread-Topic: [Patch v2 4/4] Drivers: hv: Remove hv_free/alloc_* helpers
Thread-Index: AQHbuhw3SaP1tCI6qkOEUNdqU9wmm7O8/urA
Date: Thu, 1 May 2025 01:56:10 +0000
Message-ID:
 <SN6PR02MB4157FD8E8A3E45837BDE17B8D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
 <1746050758-6829-5-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746050758-6829-5-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10650:EE_
x-ms-office365-filtering-correlation-id: 1807beb3-99d9-4448-6c43-08dd885358ad
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPgu9FUvYZ88hunKvKD6srSctDIlB0lRO20sLJc3gtqtzx8ijYUD4aPP3LFPDek95tF54//mGt5VimtHkBsNs5DRfWUcDW0K4j2bm0frst3zAxvl0w0TateF+QrWePPS8b2s7ylesK3YyzPyvfFvDYTqotl4zBuk4AnLy9qcto3D8f2eFW5Bgque2tH/FCePNKYu2T3cxjOPxjBrA/aI80fNQ0Eg9bnyqxY6FxKnE9tF5xeBNxSUuPZm0i6NtH4G0k2Xb2eUkRSmJyvwmYsb1Hk8OGf/B0L/5ebhSGkVU9cc54Lz0Ek7CxXvJca7LdextTzM4ax+2j99mhdn6yoyn7HTmY59UVfF40ddcVzYHxv0kRxTIjlcbKlBGOLPJUTIerFW0fwxf2MhrmIMYTshKyQnyKQHYrAPZaNbaNuhdQp1XJj33Idb3swqO4TzH0gxi6LBysmkwwbbknu6IA/0bv4w87ii4fBvbPmsDazlDqpMqMh3VYasDx0MHi+0+W4y8YHWRV4OcQev4uR8lLNuWKQi0WL28UOUmKCklfnpYDyyLWcy+uR9FyLkTH0xEG8kqgEubehBXO5++1f06+e3gfzLecPlFPqAOiL6UgQbDp9jd5TgPPN9VaDtmWcqpnW5vTDBWjW45R8suLkzeE/er0hGvPKmL3UuLSaBwSRJBxc/hzDVpUiEl7INwmmw4n6fdtX2mDbyHNTg29k8oei8b5Gic7V3eQLhm4vhLSR93v3JLbP2OGqnRY2MycqbGemYro=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|8060799006|19110799003|461199028|102099032|440099028|3412199025|11031999003|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3sGoK7rth7W8e2EXsjEUXaE8AKjERGr2WjTUjvqQfLXEi5p1obGUkLTpzqVV?=
 =?us-ascii?Q?/5tdvfhpbES7TDnkvsLxuvx5KNwNvHS2gi7m5Xl1oQ1Ik1vSuDtEc6xnopsB?=
 =?us-ascii?Q?/Zc2TU6E1vEcUPFgzJvwY0na937KGC05E8oTpqPbrP2/RQun7K5vBblTanbD?=
 =?us-ascii?Q?IXDOn4MhNXfmlGjrvoiEsxpseardboXHlxC0shubo8TDhrlh+D9VxPDIjuN4?=
 =?us-ascii?Q?n1TC3xEc17tsonXX1tPreFik4Zuv2IvCSe1HEMnA7P6ZV3XzFD6Upy8m0VBA?=
 =?us-ascii?Q?t1xkK9I49z0aGIdFfjVkN01LFxTlSY+N4wBsiDuOInMuGc7rbNNDX8Qoggq1?=
 =?us-ascii?Q?HjMabF2+ERXkPdWGhKSX1/D8majiMnqkXYVbDT2wDfouDelQx36Afd8GbAlv?=
 =?us-ascii?Q?1erKfLlBDm7HI+8929neVcxL0ShzBIS5kqPdURDwRycuLSK+et5nZRZ4uAcz?=
 =?us-ascii?Q?SpCfTEpC9rnB58KrK34dtEm1U3MuuoG8ffIj4Anru88ViLYylT07Lf8QURsO?=
 =?us-ascii?Q?YhyYQInqONvwJulFCa4MQHhlir637KgTbnohyDyBhriHoVJT2xFYbXQ6mbA1?=
 =?us-ascii?Q?9NhEXizbeHwe6437Ew7l00jSXEvEw+N5k+nY6Y+gTuj3IXU/ho7VDLZUkleo?=
 =?us-ascii?Q?UaKsKBP5jDyvvmYvh3t8lUwrfXU6ti8cXSMj+b/47qEU2o3+YhwU1GqGOMHy?=
 =?us-ascii?Q?szScYmcdRlfbLg84gpUiD0qpr/9j8YmfJcuMOE4fK/yQnt/zJgSUDH/1w5aa?=
 =?us-ascii?Q?wUQ9p84nxXDTF73bDEqpdYh1w74/S/DV3s3TgTLPf4rwUkwnwV+NDvcQfn7g?=
 =?us-ascii?Q?rVpG+SBHn2no9qX7yLsQZq65kTsX5worldHjDSbUaMhMaL0IAmoaDgjiy+33?=
 =?us-ascii?Q?3c61U20isQqQ9r/f/IrQoFcBVN/kxGq8ewamX763/umVP5fEUgRfz/7cBqLf?=
 =?us-ascii?Q?oE4F6V6nQkKz2FnnuGMQRzTDGPC2xrM813O9Sn57WszujOT/mf/dM7HV3yZC?=
 =?us-ascii?Q?s4F0EugruIHyQB3b4BjEWI8zE3KSB6Ea+pawst3tYxhOzW46gJQ3KATPwRkJ?=
 =?us-ascii?Q?QhTvheNn0IVS92ht6st2OFrzHrwVOiVE9gwJ8jAXden9hXEoe8aotAGg2hZV?=
 =?us-ascii?Q?Y0idfPE4prg2CzmkWdx2hzSMXnH5I09e4zzezQ0WVnCgrW+gFbf0Ujo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Op8kKnPP0ZvLeQtOE1HvI0sXaSmErFxTANJn3GgFIas3Y9OOQ3yt6sgpIkYW?=
 =?us-ascii?Q?mEicCZxOshOzT/c5I/nCk9CDPihHIcY4u4mEY/y5QYcge/9kpB89ynvv8qnW?=
 =?us-ascii?Q?XdS4dcOWLmCJqWL6iJ8jtqGXpfhyeX3h6RvSL7j1e32l+PjBIv4jz10DwixX?=
 =?us-ascii?Q?F3uNhVoZJLHYL0wPfBof24dGjHPnJIb77xIQCHWEQK5RLuSpkR+GrErWFBQn?=
 =?us-ascii?Q?EpoC89rAJpKho0xxSoHYeXJbBWVq1upP4TEJaY7qgOi0YV7RxlEdljBV1YeR?=
 =?us-ascii?Q?DWIKN1mMu2LhXRiaMs9pCiuxi/9DMR31G4+aENW9freOSQXkVBdmNkdCwqY4?=
 =?us-ascii?Q?zgfoWYd3J4bTplEUBU0AfazmKxC3XShnm3JbcEx57OH7COrf4lyeI1wLbGVZ?=
 =?us-ascii?Q?3SDWuWbxoBpMT6mCp5ugmK02dYBAHjynCJtYz9cKgV2H5utDM4blU5xDteId?=
 =?us-ascii?Q?Epr7ySpJh87eDLfGZn1IDT8nYFuG6qbFy7y/7PAEG/riBlXzTpHNuYrwx9IE?=
 =?us-ascii?Q?8dCZUhmx6snlosJChuLWJn4dpcfEYHBa+p9YWO08N4JtWrNUl9cUm4MysxyO?=
 =?us-ascii?Q?vU++jsODbR+9iB4sh/OoPX/Dai/QovQ/LeYxzX0w10PMkJOqo/4K09Vz6XYK?=
 =?us-ascii?Q?TltvSm1UOs2OLOQUqZN6b9CTq4sUeL0DOz9NtSU8izzXr1llSYxbrJ/v+b5U?=
 =?us-ascii?Q?ytM/lLFQu3gdqw8XUhSy8D3x9dJ9XIbqKBjffxJ2wUjQCih+Nquk2sBTbUWF?=
 =?us-ascii?Q?eZkOOaPiampFCT+gdCsjuJn0v36mVNjW6BzRYynUhIq/7stoBbhrXMkmgSO8?=
 =?us-ascii?Q?nozEw25RHROwxkn5lRG9tuVhUtqO6Y2ipTOis/9gI4owXkxQOxOb4skk7Z/P?=
 =?us-ascii?Q?AAWNDTd1aVy9g0eItYz04d4Jncp4e2JZQVqQUntQVMVUyuHjGcGIPzIjLjK1?=
 =?us-ascii?Q?GzVt7/1tQaprVX/Xij4qrskq8zIT9T8vUWcbhw34mayVYss1PQTWPeo+YYnx?=
 =?us-ascii?Q?JUORQD3Fpv5hWbm51+nrNvjlZlHbEA6sS4Ma7N2myPIPFSgZ/EdJMR+T0ktM?=
 =?us-ascii?Q?dM3pY07hj2VpaLqNfa9pI7PagLNpoBhNCQmhQFBcxddhoRF6k9kTpsHV2lUF?=
 =?us-ascii?Q?ePXzArlRN9Z18UIn8T8XdNZiaJg4/pPPORR3TwDEfEVESVGEuBZ16dfZycUJ?=
 =?us-ascii?Q?eowyQYjVZ7cyllzQIYKxw9KIwvMaOV9q6ukzdulh6cUjxo7yDQUhweBRTr4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1807beb3-99d9-4448-6c43-08dd885358ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 01:56:10.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10650

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
April 30, 2025 3:06 PM
>=20
> Those helpers are simply wrappers for page allocations.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/connection.c        | 23 +++++++++++++++++------
>  drivers/hv/hv_common.c         | 24 ------------------------
>  include/asm-generic/mshyperv.h |  4 ----
>  3 files changed, 17 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 8351360bba16..a0160b73b593 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c

See my comment in Patch 1 of the series, suggesting that these
changes to connection.c move into Patch 1.

> @@ -206,11 +206,20 @@ int vmbus_connect(void)
>  	INIT_LIST_HEAD(&vmbus_connection.chn_list);
>  	mutex_init(&vmbus_connection.channel_mutex);
>=20
> +	/*
> +	 * The following Hyper-V interrupt and monitor pages can be used by
> +	 * UIO for mapping to user-space, it should always be allocated on

s/it should/so should/

> +	 * system page boundaries. We use page allocation functions to allocate
> +	 * those pages. We assume system page be bigger than Hyper-v page.

Instead of your last sentence above, say:

The system page size must be >=3D the Hyper-V page size.

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
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 297ccd7d4997..421376cea17e 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -105,30 +105,6 @@ void __init hv_common_free(void)
>  	hv_synic_eventring_tail =3D NULL;
>  }
>=20
> -/*
> - * A Hyper-V page can be used by UIO for mapping to user-space, it shoul=
d
> - * always be allocated on system page boundaries.
> - */
> -void *hv_alloc_hyperv_page(void)
> -{
> -	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> -	return (void *)__get_free_page(GFP_KERNEL);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> -
> -void *hv_alloc_hyperv_zeroed_page(void)
> -{
> -	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> -	return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> -
> -void hv_free_hyperv_page(void *addr)
> -{
> -	free_page((unsigned long)addr);
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


