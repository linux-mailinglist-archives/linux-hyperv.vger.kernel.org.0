Return-Path: <linux-hyperv+bounces-7426-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E1C3B6AF
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D27E502C92
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C230EF9F;
	Thu,  6 Nov 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nzCQMtYk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012051.outbound.protection.outlook.com [52.103.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20B308F1E;
	Thu,  6 Nov 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436308; cv=fail; b=eR6JU9+J8hKgjybzQaGyHNP5MAz5/1wEeFNHjrctFmeM+UzsQqwDDH/MIO9yv0/CG90rVWMh8JoCQNGO0uLpw403pMMNSl3iFVH2MTJfBIWoPohiMcpzBmckECnYeJ1+qgQDSbSm6Q3BnPG9rFsiTVi9gHUE5hx7XOn8ne6DX38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436308; c=relaxed/simple;
	bh=03dqNFnp3LskKN+TmdWjwidNPwdupSBbCVXdSF9f0ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/EP74RT/4jlBMX/Sw2HXTBerT5VPuYbM1chfDdecONwTL70JqTwQtTAZxpJihmkOCQP2sw78kOGfg2k74ySlZcPHK2XllqcLhpetMw+gh+covKf3CLpBC2h0II0ZD5gEzkv5SQTtR82MCN37vT5Kc8KmBOhM6KXIs0XNa4pKRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nzCQMtYk; arc=fail smtp.client-ip=52.103.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNwBdX+h8fpEJxLXXwm8Szi+GASg3gs4DA61isB5TsidfBSXi4L6WMthwFNvDjKDz5LrhKGte2hyWpXmlXvq1r/CF2CcB94oI8I07U1waMBkMreTR4n+mEfZ06bdjxmZh9jD4k+Z50fHv9VBQPQ3S7wkynMgCUIPz8VpzOde3jZtkixaSe//76qF4BASqJEu2L7grknW8o6fmQ1SD7lgTtcb4n2uSODU6ssyxhqYNsM/F+MFNKPrv5Fbag897hqeG2WnMdZDfEjOmfJFIp0tJlD2yV6KtJHANh0N12D/+jo6tG4lgCB70VAMdk2i8tRCjftYTc1bzIPE4UnBFTNaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcvCmu0+70EKIp46ZTRDgzfSndHe1mdfLmVFJqyVa+w=;
 b=ufSB4zD/fxYaGOdSmof0B+5rYZygUKnJzvsZUx0P3twfHzWKcL7+9kiGGO/dcZ8f8gpqUv9BctFdEHxxNvYc8xWnOaktHqLax1h32t9xNsTryNVMGUwLW0ajAg0LoLjIXv92IPjQV9e7vBdoxTq32SMIdvmiUC3IrT0NDnsvxKVsK0wyRbAKPqTnA0QkPjHzWoBz65YW+H2Nod3PLNw1kfBbhBDWI9OsFyB5BxUR7CcSJU3sVvKRlGhU5g8ccQHAcUP6uIsaAGbLTCGSwKqEJeBEQHIxKP7k/Xk+in3mTPUIIG6tlnfIAYsitrk/TkB3kcu5vAiO7BWn/V2/SGinIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcvCmu0+70EKIp46ZTRDgzfSndHe1mdfLmVFJqyVa+w=;
 b=nzCQMtYknCzXE8FhEbNft7pMhf2U1c6Su5HgbaWzCJ7yFh5rrWKOiFu1FS8gIgnqT9NSOmyHIHZVpqZeoCKEcd9ehXToo9rw3fjp41YL0+lrfHD+0oF4gwnhRNvrnjdBzr54J0q6JEWEaJGSDqajLxUkTVJ9v31UxTfJwvgAj1h4YaZgIlXTtTkD27tIavrs6fzCAQ0FNOjgqKIX0MdyEVHcMSQPj19jOME0PNVucDNh2Ot21ZDu+u+4G88tCLq6KcyE9BXxb2S+QxM+Up2KrsvuTM0cf+NjV6BrtlmgGchAamPyvj9Wej/WRgSx38hbQ5nd7mjxCu7Y6YF3x3B20w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7041.namprd02.prod.outlook.com (2603:10b6:a03:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 13:38:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 13:38:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"magnuskulke@linux.microsoft.com" <magnuskulke@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>
Subject: RE: [PATCH] mshv: Allow mappings that overlap in uaddr
Thread-Topic: [PATCH] mshv: Allow mappings that overlap in uaddr
Thread-Index: AQHcTdkFsEXUvWoq/USXKjSKH+xDSLTlpNrg
Date: Thu, 6 Nov 2025 13:38:24 +0000
Message-ID:
 <SN6PR02MB41575BE0406D3AB22E1D7DB5D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1762294728-21721-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1762294728-21721-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7041:EE_
x-ms-office365-filtering-correlation-id: 37bf45ce-62a4-4831-8bb8-08de1d39c22d
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8060799015|41001999006|8062599012|31061999003|461199028|15080799012|12121999013|440099028|3412199025|40105399003|51005399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?87ybQ8NeiLnI4snb2nnh7jzavBXCNyeULRtSoDyel7wdrWQpJzat+SV3IqWn?=
 =?us-ascii?Q?wbXVsf7An7wdfVz+LAwVQpwU2q8X6ax3Ld0PyQnHMPqRO6PCh0YrJLwU8DBP?=
 =?us-ascii?Q?Ag2LKwOB9cd9cIU1c4Kp9tCOk3LxmKz+e8vuO9ARO7RXjKcNRDRtlsuWedQy?=
 =?us-ascii?Q?tFNPevyOjAAgn5qTf5Dz6HXfzpa93AwZXbuSEW9ClEmIex6Y6uDeT3hTMNcP?=
 =?us-ascii?Q?XXYuk98EdJNY9FFgNOznrvNNZplP+w7j3PQkuMccaiLpNG6c+aRF8fxqxxxp?=
 =?us-ascii?Q?OuT8bUAgIlssrYSur8PAyrsOJesMRyJjyp1SWK2UzQ04Qau6euEd2CGrHasp?=
 =?us-ascii?Q?mveY9jPLkJmE+xPG0J/tUjWMvfXkq1REUPoLAX1L7JyrS0oLIlK9SAceshae?=
 =?us-ascii?Q?d6ofW9/3WIMCvoR7SuohSv53klk2PvxPrh/cpRXIvBxYsqsV9wl4cOXO2aUj?=
 =?us-ascii?Q?Bz6DPMX2iT8wh32+T/SA9gnEedWaozy/JbHuizOyTx28oRfzTssDXYGMg2qi?=
 =?us-ascii?Q?YhuVOAajPP1XJIrIEwfjWaWWEEm4Fc+3SKkBmeHKJL6rRlfTSAIJHxLhDcRq?=
 =?us-ascii?Q?CkhsarWaV7PrAdMcJIkvsjby7HRELPxST8Yxi6cAl/escncUkYjIbuDvp7NO?=
 =?us-ascii?Q?AWBkWPF0mq222QItd7BKOJWFv3mfE7hJGBLXKTJujAuXI0k8EkBqgk9HhQrO?=
 =?us-ascii?Q?zRtRHikdziqi5UsiZ5M4BgwwzZAZN9soJbV8P7eSyrY7TLuHNKIeHzrKBkIw?=
 =?us-ascii?Q?ldO/8wNII4EdGxx7txSS2Zh5nMVBVUf1ajwQ7ZcffeaiM2+4hVCAqiQJN6LY?=
 =?us-ascii?Q?WA/QLvlEAR0NsmvJg2l7zrlloXawkEOQAl8LPeC537tPW9zaAalftbQbFRgu?=
 =?us-ascii?Q?hA37QqG7db/Ku9SYsk85RCx6WgE+T9hegtFNyi3psD2935jjyMlCOL2DxYpl?=
 =?us-ascii?Q?0eOg/IxPo6Ksc6J1NI+bnX6cJJcqvmRJGbreulSt2hz7oaK2N4XYE7P9ue05?=
 =?us-ascii?Q?nBpJ/pxHPA9yIN6ysr6QNHD/SBMyW+jRboWkw8smiQweXaIhR3X0eENsnkQf?=
 =?us-ascii?Q?AgnRzp0ZsiQaWjphHuO8+hcQG+ePRdO50izHTuStamGPX9HYpbOuzTVlfDyS?=
 =?us-ascii?Q?VJtrcLD18bSDEFslsjypNu8WFUpDkNs7LNp6KYl/FIhTv2Lb5cLe1hjBZC83?=
 =?us-ascii?Q?Xbb2xNa9PF9tZxsBW/jFPr3cWgFG+EcCRku8lAJjhQ0yZBUeFFShABN1D1pZ?=
 =?us-ascii?Q?pCLKOOVevyptvQvV0c/GJaiFuXtBj/fQPRiHM2W0gg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1TgjLRb3gAEFI1K3ejUYN+s/aa1OfpW1WTnA3R7wiP7qI6X9Qgd2i0W+IhSd?=
 =?us-ascii?Q?uLkvQny/eVbF1dU3WstqghH4V2Fn7qSUTYUdZWPFGwZWcStN8sjydB3g1XqZ?=
 =?us-ascii?Q?UcPaThwPc+5+nBzWaT9L/S4B4uZQHm7ypzVTJL8XpVkVb1Ds/8d/gqZd11en?=
 =?us-ascii?Q?eB6llMzn+2HHx48NYLshOawv5NUL6TN2P96zefnTP7JMD3OlmucfHHAEHn8u?=
 =?us-ascii?Q?iUTYyUrQOxxrllgBvl7YQlY62+nt8T2bY1Ka720xbOJhzjxdVYTNAkI0mwQ8?=
 =?us-ascii?Q?CyvzHD2lbBVNE6Bp1FGgjSm6ENA84tGXGg/zveJtM082edfV4zxszhcfSV59?=
 =?us-ascii?Q?nKg+AlMD4u4pRydwVE1GT92nAjG0c6J0KL/i83KxU43OVHfHZLTrE9Q52z1L?=
 =?us-ascii?Q?Y7BNvwqJS9VLnzVh2P0fGB8QRrKYxv8bOHKHKUvPcj23Go6IrC2Icf1cNKIO?=
 =?us-ascii?Q?ZYJJTTFkWbZgoKtAVmQngqBgMwJb4pJshyZABxRfGgbJ9EW+AHfBA4A9E8ql?=
 =?us-ascii?Q?lwhVrQdm5wMzlu8rU5zlpvbzgNYTNDZsCOVTOSSLx+LetHj9pIreygl5FzW5?=
 =?us-ascii?Q?yjbZV90XwatX1lDxW55oew2ZNl4lTkOap1fCOVnLYpWzT8/Djo6T4D1dquau?=
 =?us-ascii?Q?QykzeSNojLhnnREOryiUtCo1Qh9CL3qsCJ9Pufh0HsGCMxPkrco+OLE9qNTC?=
 =?us-ascii?Q?UjtZY62VGHn/Umei7GBMWbEu66bNbVbuPhctVImviHa3GZBeSKM9MK3Jw6kh?=
 =?us-ascii?Q?8DCgQ1HNzVeusNMHnqIHKmoi793SN8YophmmmPdREIGffEYqhp77k8dKyG5Y?=
 =?us-ascii?Q?EkTkTdqCG4UwKXyHdnPMBhWIRjU3Y/DIr2O1PEQXx/0LtRNCW6Q5Q4JuvcV4?=
 =?us-ascii?Q?mlOj9SePAurvUEhylD6SFK8RXOFXu7ir1gSaeHLwAMYlRsYNEuQgzHU6TnQ5?=
 =?us-ascii?Q?rIgVe1nqPfCRZDLjMRa0deB9/ifNUbZM+PduygsmThmp+TRYx/7FpzdnEjqF?=
 =?us-ascii?Q?MibWGlsB4nuJXNZSOscFrgawAOaTdYcRCFRaVXEsET2B6J2yptNokCu6k0bv?=
 =?us-ascii?Q?g1HtMLVEBUVffvTyD9uctrxFg0a8uwrtdJCOroIVpnwRRyP4k/Qo6q8NSa4S?=
 =?us-ascii?Q?lsFlwezcKKPglJm9fM7xGNIyyoYBt/e/b9A9ARWVXv/9ifS168JyveEEgoVZ?=
 =?us-ascii?Q?jS1weXzxP6dqwqZS7zBvYdHvpUBBo4cD6LXphc38SM3bFIUH2Ca2nk0BDVs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bf45ce-62a4-4831-8bb8-08de1d39c22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 13:38:24.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7041

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Nove=
mber 4, 2025 2:19 PM
>=20
> Currently the MSHV driver rejects mappings that would overlap in
> userspace.
>=20
> Some VMMs require the same memory to be mapped to different parts of
> the guest's address space, and so working around this restriction is
> difficult.
>=20
> The hypervisor itself doesn't prohibit mappings that overlap in uaddr,
> (really in SPA: system physical addresses), so supporting this in the
> driver doesn't require any extra work, only the checks need to be
> removed.
>=20
> Since no userspace code up until has been able to overlap regions in
> userspace, relaxing this constraint can't break any existing code.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 19 +------------------
>  include/uapi/linux/mshv.h   |  2 +-
>  2 files changed, 2 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 814465a0912d..e5da5f2ab6f7 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1206,21 +1206,6 @@ mshv_partition_region_by_gfn(struct mshv_partition=
 *partition, u64 gfn)
>  	return NULL;
>  }
>=20
> -static struct mshv_mem_region *
> -mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uad=
dr)
> -{
> -	struct mshv_mem_region *region;
> -
> -	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
> -		if (uaddr >=3D region->start_uaddr &&
> -		    uaddr < region->start_uaddr +
> -			    (region->nr_pages << HV_HYP_PAGE_SHIFT))
> -			return region;
> -	}
> -
> -	return NULL;
> -}
> -
>  /*
>   * NB: caller checks and makes sure mem->size is page aligned
>   * Returns: 0 with regionpp updated on success, or -errno
> @@ -1235,9 +1220,7 @@ static int mshv_partition_create_region(struct mshv=
_partition *partition,
>=20
>  	/* Reject overlapping regions */
>  	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
> -	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages -=
 1) ||
> -	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
> -	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem=
->size - 1))
> +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages -=
 1))
>  		return -EEXIST;

This existing code (and after this patch) checks for overlap by seeing if t=
he
requested starting and ending GFNs are already in some existing region. But
is this really sufficient to detect overlap? Consider this example:

1. Three regions exist covering these GFNs respectively:  100 thru 199,
300 thru 399, and 500 thru 599.
2. A request is made to create a new region for GFNs 250 thru 449.

This new request would pass the check, but would still overlap. Or is there
something that prevents this scenario?

>=20
>  	region =3D vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 9091946cba23..b10c8d1cb2ad 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -123,7 +123,7 @@ enum {
>   * @rsvd: MBZ
>   *
>   * Map or unmap a region of userspace memory to Guest Physical Addresses=
 (GPA).
> - * Mappings can't overlap in GPA space or userspace.
> + * Mappings can't overlap in GPA space.
>   * To unmap, these fields must match an existing mapping.
>   */
>  struct mshv_user_mem_region {
> --
> 2.34.1

I've given my Reviewed-by: narrowly for this patch, since it appears to be
correct for what it does. But if the approach for detecting overlap really
is faulty, an additional patch is needed that might supersede this one.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

