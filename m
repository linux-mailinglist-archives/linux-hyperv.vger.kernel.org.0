Return-Path: <linux-hyperv+bounces-7115-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E40BBEC7C
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0AC18996E5
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0C22424E;
	Mon,  6 Oct 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZgHRxJNc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011080.outbound.protection.outlook.com [52.103.23.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A083221543;
	Mon,  6 Oct 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770551; cv=fail; b=PU4FLjmJHiXrpgpXzEi4UgXVRY0ESzDzZLK1sDonVInpC86A+grdu4oYtzfNTPZjRlVlNpvxkQ/OR63kL+5otaQHVVbG9zWZWDdHoLZRQ1AcmXVDXrJsjFaUWBBgtDUPyZPTfsaWBWwkzbNFFMQOmMu6RP97H0WIkkwJQDZ5hY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770551; c=relaxed/simple;
	bh=SSJt46qbGP3XgExTImqsDhB7nsXuIC30ce4FkRRk26o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KiiJifP5KqPpQXhIN3SvDVSTb7PZur28+1eDexk7RtOA/Asd7gTE85CFJFWQPkSRR1zTjGWyO8tGcVEn7/7ENS+Qfe4sb5xgWLd0/3kDIf93C3Ktd4OquZpXviZF2xbNPJSKuwfuf22awRATPf2USjS67XWqpzqeI3bA7QnQrww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZgHRxJNc; arc=fail smtp.client-ip=52.103.23.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS8W0XqnklXFdLTBA46rfATQmLW2fllrjihax3Hys6PVIjthphEDDK50hhI7oryJqGCbjrW4vyhRu3W8gWbjoUPs8G+Y7z+c754uA+U46KP8Yf/twT1vM51orgo3lpAVr4g/W4u6e6iXKN3Ba3u7ph0Ni1rzIE49aQaBrXUqC1q3gTuBdktjmYRaqMmbmEAB3F6/2iPSkKjt5RuM7+iI+7lIdaM+Dnicv9Q7MgVsY48JAqwiLSF8CipsdcaFQTlINs2NfsCdRiJ9QPKMX4seaL/Qvs+iq95nin35ZA8PfvlJs07iJXlR8k3IpP5bm0ZQOCGu8EjYhjjE4KUsbMxsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTEPERFVU42i7OIzP7nucHNgZgRXk88Ke13xN//nXZk=;
 b=K1kgSpHxebT37boBfVR67ucyLeOcZtgVVSsVo7rshb2lnyY9RDs4H+ziwjVtMroGs6hQRCJdCDjKJxX91OSsL9NfVTl6EznE/7XFhsTuIqiJSCvabGo3gwTFNyYnjMW3mFDlPYYTrvRlvb7YGI/eWSjed85PQBgwZnWvCmfqdBqBMReNKPoWRTP+MwYcebVCgseF41QdYvpH3jbFKA8CgL/cCdbCIiSze+avV2Vg6YaNAm1BW3R/L5vG2BnTfdegLzfZ40K3vglkultjPgBXI7EgNHLGCjk1mePEYpTt7Wm06Z9DeMbe3n+3zVvrtb1J6/zMZD0lbsk869jBiZ0YrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTEPERFVU42i7OIzP7nucHNgZgRXk88Ke13xN//nXZk=;
 b=ZgHRxJNclhDBRS0goOEf0mCEn/Pu90nTygt30K6iFfX2pzz5UOveHjZ00K74Hr+w35soBe3UUO6aQZK8jaOUMqdOXuGiA2L78VgJZPOB+gDKjtwJpTXRvlVkoPJ/FYMoeDMZbzVSJsNJNBS1rwGNMM6scdVCk5vw6FGMM+n5wrtkd+QNmT9bpHJUQL0S0uuQtnk96xCd/ENwoJGwkI/PUD1Nxsbs63NoT8MdrH5aUSGFuX2Kov1ZzZATmiTZAfdnfwwdWHQr+MWWNSP+4vUcVEXN2T+kRr+sQwq0GQzcjbwDAan066exSrllt94DFPPVIGIPqQF4NbxOMciq+87aQw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7186.namprd02.prod.outlook.com (2603:10b6:303:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 17:09:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 17:09:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] Drivers: hv: Batch GPA unmap operations to improve
 large region performance
Thread-Topic: [PATCH v4 3/5] Drivers: hv: Batch GPA unmap operations to
 improve large region performance
Thread-Index: AQHcNtLek7tWvuore02WjZDCwrJP3rS1Vo1Q
Date: Mon, 6 Oct 2025 17:09:07 +0000
Message-ID:
 <SN6PR02MB4157A4FBBF17A73E5D549DDFD4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <175976284493.16834.4572937416426518745.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <175976318688.16834.16198650808431263017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <175976318688.16834.16198650808431263017.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7186:EE_
x-ms-office365-filtering-correlation-id: fd0cd86a-70bc-4cd1-ad33-08de04fb0f73
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|19110799012|13091999003|15080799012|31061999003|12121999013|461199028|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XWT2sAg0Bm+5pgqB6hbF24W/o05Nf9Ex6ksLx/ndXqkVSnX2FXU4Y82mOUPi?=
 =?us-ascii?Q?bv5gqJN2ZmKEaIMHR8wJVpL30jNpweq3zKiEcU+NuJseVE/I/yEOoqjKND9z?=
 =?us-ascii?Q?+9NhGHzAoa+lJE12hvelcmxahKfphMx+L1VwbEccYiLEUDD33xFfh/W+tAp4?=
 =?us-ascii?Q?f2PIqhYqA8wjOtuwnVKBmEYVIqBoQ+v859GC8cdOGdl4ribeQTHqerhDMTIh?=
 =?us-ascii?Q?H6GqP6Bz9RooT0Jeux4AnsNZ0Aop+ncJqLAJuwBwXRnmtpVpXffV+ZeQ88nl?=
 =?us-ascii?Q?i9lOdrNPmw01CVyB/wCJ38fXcG4lKHridamoa/NVRE/1We+2Liqb+gJdzKyp?=
 =?us-ascii?Q?sIAT82p2XCeQ4CPnLE1VbxvRecxDfj4zXvaNZ2QzJMg2OFO0mW/qfm0FVpwY?=
 =?us-ascii?Q?+luUJuD558XROVHm2E174cbhDbtdQI5LeZgm3xxLAi+mgYA5pvWguAP+H91r?=
 =?us-ascii?Q?eohjTOqOiffMok0a/4EvHYbrWVIni3WExIdAzJXeap8EJ17bNPDPZ6CJGqqi?=
 =?us-ascii?Q?/MfoGIcTTDFAp7BzqJaoApfhw2tvtcNX1wbSOqFUztiZUezaa64E6UUE9wN4?=
 =?us-ascii?Q?E5e+Pz5lh6ndsE4pZufUdaAZ538Em/hB3EjlGjj9pkcTf5pffuMT3EYUuw4h?=
 =?us-ascii?Q?eHCsEOOv5B2Iy2JTtjQNfSRxSH0USNSW2dRFjhWb8zAs+lLpolCmqULE3wgB?=
 =?us-ascii?Q?Noi3O7GWofNWLkBrE7u7buR9eX43Q1T28iQn/OiPoXRh1XHf03F2JsHuyeXl?=
 =?us-ascii?Q?irYC772ZzpNXvmaeTLNS/WOl2jExZ/DyeyicTHHxc7/g6pLVAqACL86VlEYV?=
 =?us-ascii?Q?2rS8atWnml0mkaYH2peIKlfyTCS9O3IWQjZTdpDjEjXs5JQHNrhHw8qx4BrF?=
 =?us-ascii?Q?FB1oQP2poHMajNxHixF7LZK9+TpFU6PvZZxYL2Mwa89qkUqGDdeOARB9O2ZK?=
 =?us-ascii?Q?5E3u9SKK29pY5KMP8Qs1ljogxpIfLHU5YbxY8YXCeuseGzgMDxj5dLQGzt2z?=
 =?us-ascii?Q?PNlQ5tl8tX473lOraoMUQD4a+NsXVv18ic4heXsp94VSuc3xoLr2i3C5q7xr?=
 =?us-ascii?Q?wmsOVzEM38eq6V2bf2ozBmUFeNmU6kYHf55cHYjCE9wKZv6FQKePzn7oMptU?=
 =?us-ascii?Q?C9WaGeYKQQwGQr/h/DlejOmxi5ofdJY6BWN3hts90evbs7+YvjUS32M3PvFE?=
 =?us-ascii?Q?rbI23ygmex87WbrXn2hg7hUlf70rppvl1sBM/w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qOHW1D9DjKBXARi6SFTcjpTjBw8ZWAXhb12/AMGljCo+PplrpPgmiAZ4mdyD?=
 =?us-ascii?Q?27qrjohl5K1oHEV5cFdECwsVI1/IHLV1ciwypxOmXHUXW+QbwFKzl7cBTntN?=
 =?us-ascii?Q?Dw9N/VCNb3CqFP+yZXq9d6QSP6QWaalPkwhowTuKR0Tleo00WCzFS7hHQ3+M?=
 =?us-ascii?Q?BQPROktu6anES1ON27mGCFmVkpWcwYXKGMZ1+QlbgJ10vGepwDmQEzkvhnSJ?=
 =?us-ascii?Q?T4kcgwwdJUm39753rkaFpcwUeRaw1ZgpIMjkkHovABptVWpvXWl/8tHvjk3P?=
 =?us-ascii?Q?A7bdDKX8sWZ6XE0UzOucTojqEZBZhQ599J4hh0nl3ZRWqmPYE7HRw6OS8sCS?=
 =?us-ascii?Q?QxBviJu+ByQ6kjbwnw09MIbEnT152/5CmedLogOQOCaqW1rhRULdxUnmgOHG?=
 =?us-ascii?Q?mhYxuG62V5rsTF8Ogero+NZg2Zl1SZeOZxGvjzYxf3eRK15tw6aq8zjA4BGh?=
 =?us-ascii?Q?DRd68dSszI3fMQKGKqR5fzwk4v3kmgcMRIkhIDoq7OaNIMuXMvsaiX92f5oI?=
 =?us-ascii?Q?NG5rK9W1rikfzE5RxP0Oske6MhxvmaKiQR0aV6DNapZpKGHfbaKRIq3WjimX?=
 =?us-ascii?Q?2Ey3iEqdOb04U5UY/tHRShFWTrfKKvGtFE/Nl3XkfKG37A0hjskFj5+zvvm1?=
 =?us-ascii?Q?y7DWI/yCYXce9G6VficZx+T1jBehWsmJQAk+M5YrIyP4Kt4NFpjg2O/hVS7v?=
 =?us-ascii?Q?CNnNJQhJCyyQtEvBipatqPBWLdStrRmMj3aXZZTiVQ5GHY8ZTw8SRibGLV9t?=
 =?us-ascii?Q?h2Nu+7AjZnxxx4PFKefyn3yb9y057iv7zFRy163KNXSh7dUc6QCDq1B6VvuC?=
 =?us-ascii?Q?H2+wl20KZKKQqeaoi8jRHH5vvdyyiKek38Dq7WsLsJlKp4noXZxo/yMAzer6?=
 =?us-ascii?Q?j9o+fw71tJro6XgLaX/BlvlIUmRuru+m+sOCQ2zRiZ6FIEFp9YHDtmXHItY/?=
 =?us-ascii?Q?Zzq18Xwsq3lC9onrnUaL03s5VLZJOpb3P8vQk1za7TsjPcpAdADVu1jQS9NO?=
 =?us-ascii?Q?azWdbLFrO2UqUSMoAEx6Eh5fmQYeBMF9QgiSZWV6S65OygQJU+1w5Uw29DKz?=
 =?us-ascii?Q?/KyYNpiMAOp/S8I6cWzBaKi2YwxTlzjBO+Q1E5ZZ/nLbuqsHpW8KukbNNOE7?=
 =?us-ascii?Q?ZkrnGsJTwcdRZtkl7yBp43e2h71vBnS2ewUd/J5XcexpeTWJ61ika+XV7qIB?=
 =?us-ascii?Q?YZVnBykVIvQGs+LmTA3evRUnUnanif5Xgv+e4XUEg0dU78GKYwiCqzNDk4E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0cd86a-70bc-4cd1-ad33-08de04fb0f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 17:09:07.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7186

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, October 6, 2025 8:06 AM
>=20
> Reduce overhead when unmapping large memory regions by batching GPA unmap
> operations in 2MB-aligned chunks.
>=20
> Use a dedicated constant for batch size to improve code clarity and
> maintainability.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |    2 ++
>  drivers/hv/mshv_root_hv_call.c |    2 +-
>  drivers/hv/mshv_root_main.c    |   28 +++++++++++++++++++++++++---
>  3 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e3931b0f12693..97e64d5341b6e 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -32,6 +32,8 @@ static_assert(HV_HYP_PAGE_SIZE =3D=3D MSHV_HV_PAGE_SIZE=
);
>=20
>  #define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
>=20
> +#define MSHV_MAX_UNMAP_GPA_PAGES	512
> +
>  struct mshv_vp {
>  	u32 vp_index;
>  	struct mshv_partition *vp_partition;
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index c9c274f29c3c6..0696024ccfe31 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -17,7 +17,7 @@
>  /* Determined empirically */
>  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>  #define HV_MAP_GPA_DEPOSIT_PAGES	256
> -#define HV_UMAP_GPA_PAGES		512
> +#define HV_UMAP_GPA_PAGES		MSHV_MAX_UNMAP_GPA_PAGES
>=20
>  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 97e322f3c6b5e..b61bef6b9c132 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1378,6 +1378,7 @@ mshv_map_user_memory(struct mshv_partition *partiti=
on,
>  static void mshv_partition_destroy_region(struct mshv_mem_region *region=
)
>  {
>  	struct mshv_partition *partition =3D region->partition;
> +	u64 gfn, gfn_count, start_gfn, end_gfn;
>  	u32 unmap_flags =3D 0;
>  	int ret;
>=20
> @@ -1396,9 +1397,30 @@ static void mshv_partition_destroy_region(struct m=
shv_mem_region *region)
>  	if (region->flags.large_pages)
>  		unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
>=20
> -	/* ignore unmap failures and continue as process may be exiting */
> -	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
> -				region->nr_pages, unmap_flags);
> +	start_gfn =3D region->start_gfn;
> +	end_gfn =3D region->start_gfn + region->nr_pages;
> +
> +	for (gfn =3D start_gfn; gfn < end_gfn; gfn +=3D gfn_count) {
> +		if (gfn % MSHV_MAX_UNMAP_GPA_PAGES)
> +			gfn_count =3D ALIGN(gfn, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;
> +		else
> +			gfn_count =3D MSHV_MAX_UNMAP_GPA_PAGES;

You could do the entire if/else as:

		gfn_count =3D ALIGN(gfn + 1, MSHV_MAX_UNMAP_GPA_PAGES) - gfn;

Using "gfn + 1" handles the case where gfn is already aligned. Arguably, th=
is is a bit
more obscure, so it's just a suggestion.

> +
> +		if (gfn + gfn_count > end_gfn)
> +			gfn_count =3D end_gfn - gfn;

Or
		gfn_count =3D min(gfn_count, end_gfn - gfn);

I usually prefer the "min" function instead of an "if" statement if logical=
ly
the intent is to compute the minimum. But again, just a suggestion.

> +
> +		/* Skip if all pages in this range if none is mapped */
> +		if (!memchr_inv(region->pages + (gfn - start_gfn), 0,
> +				gfn_count * sizeof(struct page *)))
> +			continue;
> +
> +		ret =3D hv_call_unmap_gpa_pages(partition->pt_id, gfn,
> +					      gfn_count, unmap_flags);
> +		if (ret)
> +			pt_err(partition,
> +			       "Failed to unmap GPA pages %#llx-%#llx: %d\n",
> +			       gfn, gfn + gfn_count - 1, ret);
> +	}

Overall, I think this algorithm looks good and handles all the edge cases.

Michael

>=20
>  	mshv_region_invalidate(region);
>=20
>=20
>=20


