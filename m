Return-Path: <linux-hyperv+bounces-7463-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E24C40921
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 16:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 744524F1529
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25032A3C6;
	Fri,  7 Nov 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d7NYzyUi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010037.outbound.protection.outlook.com [52.103.10.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4D188735;
	Fri,  7 Nov 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529055; cv=fail; b=cSDJXQINeDYIZC+BgLGDk4xW60fRPM0ck6YCG46C5E9AThBhu4TLFpFkObOwVdGTtDc7UiTtoOg0tiGxdtp0NoqyUHZyhw4j3FCFWzmFV1fSjpKtMyQersZATCREvx5gXGvLpWdE2QN6tgD18u2cOEg+37cLAHMYDhvs1oDkxXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529055; c=relaxed/simple;
	bh=6mPNmtG2Ljmv4h2Y70eurPCgYgmTpOALPPKh416WL10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIvEqhFTkl8wtin62OoM0JlN/Klh01j9mcy58yBwnBU8GdE2iXnlzBDlBMZy3Bsl5Ga8uCy+5J2n8iJiem+JCN8oYz7q+XRinmR8b59WirBGDqdoTyii/8v6VkPBF6d43586ppjCAgcLM/74kp7shz1Be+sohWz3TLWcn50nNMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d7NYzyUi; arc=fail smtp.client-ip=52.103.10.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLJDZOqbf2gqM1KkfC2I3Cu2XVNvmHi+WP1zOqn7eHsW/YVecEpvG5NTgNMKh88raQrg3kd2IYLbuGKwx38ZmD/OPZ2ZTt2qipJU0ybVW+A+7qXKGOWqGi2QeO/rvMxPKNFdRgsCp32Evx+ifnOdgVa3cNrwEcvACZttE6LraHEhr0OD/a/J/q7ET47+llf4/A+fYA5oiXyHabMvHw09pvvSNN8YA3rzKq7L8eaUqTZzm1xrS2uzGd24yaAGUaGIxvBUMjS238KAvyAfhu8/52uygfI3kB34EudsB+y8o+MEentP7o7P99EPB/Nf0KqamdkZJ3/FQMBAV4p0X1i1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMYGetG/4m+zgz1109ilgVubWB3AGs4fjiDwfh0svR0=;
 b=cyGDU9BskPwBYZ+c9+yszvUhMWShyA2lbVuhyeH+pe0Lt8k0SRRsseTcozCNG6J/Czk65elHIKhiQ+xoDBf8AWwrS4pcRlIoF1VM2zNqOmcBzLFUPM49pF4i8dj6e5baFPvgjui+iwyqPrlz5l7yYL4rH2Qv7NzfX0iflLMN6j0YixsuPHKKuY2PRwzS5I8lT6/r3RSt03dywFP1n99cum2In25A2PEvOJmVTZY4gKO+FJnG4cZijALdUeCfyGW4aJpsC7saYFiBIIZkM5ySfhjrL6KjKoFp4vcqvwzl6xcOJJmRSKMpkbHorRsEIApc2Y2ybtBYcalUojG5zn16cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMYGetG/4m+zgz1109ilgVubWB3AGs4fjiDwfh0svR0=;
 b=d7NYzyUiJwHBjIJMEQBNCrq8NKK41C+8XnmklZ93nzUCxifuyBwSA4aM2hp9Fc65IM/D7Nn9LYkY5ld3TXJrMHiVnttN3AAmnqjBTI20iuUzn4rLTZnQKYLm947dQzL9Ua2lZLuqynpTiby8SUn0bC/EJ2crjI+UfYttr979IvE0GSasEf7VQYs6OVQn3lMsmpU9gRCQaMynfuWhlpmEu0D9m4bi0y2WOHPo/o5Yd70UwWxy9vuRMJhIe+CcXaeLj3PWm0AEkd7MHWIUABWeeL5iDgYOdchH+wUv4FPCpim8wwnAD8kcGlg+OOco/qZQUFnK0pK9ltZNgeH7oQbCZg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8799.namprd02.prod.outlook.com (2603:10b6:a03:3d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 15:24:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 15:24:11 +0000
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
Subject: RE: [PATCH v2 1/2] mshv: Fix create memory region overlap check
Thread-Topic: [PATCH v2 1/2] mshv: Fix create memory region overlap check
Thread-Index: AQHcT2qZ/RQ3tZ6NR02V/B4zCuFBGrTnVZUQ
Date: Fri, 7 Nov 2025 15:24:10 +0000
Message-ID:
 <SN6PR02MB41573BC7E8A4407A06B563A3D4C3A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1762467211-8213-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1762467211-8213-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8799:EE_
x-ms-office365-filtering-correlation-id: 576ad91d-99d9-472f-6441-08de1e11b3a5
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8060799015|8062599012|41001999006|12121999013|15080799012|51005399006|461199028|31061999003|1602099012|40105399003|10035399007|4302099013|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iwDrnKKbEXmUUhpu0wDoQSE7Th4UcR9IMxoBD5ldOJs1bh4NQsFMqziEgc4o?=
 =?us-ascii?Q?jvfmlu+XfRzsm9B2dSkAlvgQuxij4lpTCtioFwErPugFmpzhDCY8g7z+SVnF?=
 =?us-ascii?Q?kyOKgT97lZ5zqlSkpBo1kEXl1vkt9htuKrtxCm/9Rfv7MYDkfHAKypCnPZUl?=
 =?us-ascii?Q?11RS/Lg6As8buzd6tFElOdKize+cFEUADqEodQmFisja/dqznfBD7yrVO/9A?=
 =?us-ascii?Q?2iMQrPWOqFZ3SQbkLc76LFbQE+V7aMsGPyj3wyHR1J29PcR/wTGieFamlSyJ?=
 =?us-ascii?Q?XmXkALeDutTclY5inxEpJL2sKNY3GLHmnSdP7y+2w5tAeaeHXRnzKlKsJrRV?=
 =?us-ascii?Q?RurEVMMxAhtvlTlOrjZtYHJqr5KG7gu9h6xSx3jWiAEvR0RglBVrGP1jZSnF?=
 =?us-ascii?Q?gW75UvLIaXcMAybq2NY0FKjW2Pnqjdhcj54YC1pRoydT9dU1LqeKMEUfR7In?=
 =?us-ascii?Q?/b9/Z3h++7SsPUDeHw6/NEKg4kCSWxOZgHyi+bkqpzuGVVNKNxYscZJSvXQE?=
 =?us-ascii?Q?ZqeUzHWJARhe9A6GcbC7aizV1uRolXo4zRgc8Me8CpRSuOewGqHBsj986skD?=
 =?us-ascii?Q?m1tJwewWUMGDrc8/5DeAc3y16yxcpQkgdSH3WaL8L3a+xwz+0TDGF1T4D9/j?=
 =?us-ascii?Q?NqyHh/lF5f7AFAtpbz5x16ACDOuLxqIcaXU3j3uGoGOuUaD8owoBrLoXLkBL?=
 =?us-ascii?Q?A2rebP0NR3ZWC4cQAysvNFzOIhfnMYTzkc6Iv7XpioLMoSvCtng5vZ1PloVO?=
 =?us-ascii?Q?5sRjHOE1CjV3NMCLFK2DSjvu2v4Uo8B20WklTf2f0d99avXAEdZ2ZF19Z1Dw?=
 =?us-ascii?Q?u0vhjOBswvyygVw76kNsIAbHvC+AK4rb0QUfMVWOeaP8HDy9MqJFMzQqAOPP?=
 =?us-ascii?Q?8zO+RSSRSPjHCtnKjNlKMzlBwyKu1PU0wEBP51cMx45drBVsLhDwmf10nf1W?=
 =?us-ascii?Q?3lN272zfLSXjPgNVZIdzyJED/yErMWKDBsTCzal/RvdseIruKgJroKzOxXWA?=
 =?us-ascii?Q?58q/feJlXgR1W/ed0EpafQAh4GG9GVDIvwRDZ+jYs0kif3S6ue3EbxULmxwJ?=
 =?us-ascii?Q?AS1ipq8HGPc17mIG8u5ShFkSYo2kwEukq3mGcC/zZWsYwqEPD2Z7l2QF0RmQ?=
 =?us-ascii?Q?+xYxOm/yER38JV/8orVRZ149n2NpQ+YxA513riuvI58c2m8YJRrTUDlSXvtN?=
 =?us-ascii?Q?bRqhwKZ4cvWxL0wJR9KHkRd/HVsfi7QtyPr7NxF0oaNcju3Mbq9tU59f8Ejp?=
 =?us-ascii?Q?eZf5gfm+q6UcDK8mkVStot/h276GOwnQlf/7urJzyn8HX5h5XYkH4Y6ppP90?=
 =?us-ascii?Q?WM+ib/GaLhSL4kFoLbUYdQDERuLBoILetXb+pPc+DADUGZPyNPTvZky4wSzk?=
 =?us-ascii?Q?CJEO1Mn0inJEholifxejhOYynWYd6cqAMNgTlCeJTYiOwRIQOA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?92FUTHHGn5KjRDHaGVUT2xXMVewzxesSgb3Weo9EwM+xeRz0TiSQ8YPFaLf2?=
 =?us-ascii?Q?pap/qwigUqmwrjzMZrY+YcjZtSeVKYeZk1RThZ0nO4y4aOfhTn1v0w3V3TjR?=
 =?us-ascii?Q?4XV6Fa6oeEUTA8wUHNaQDhves+saZP3Kb5w8HAH1H5DmIErskqpcbui4uFYY?=
 =?us-ascii?Q?tUljVR83blq2J/0H3cK0PIuRVp9PdYXczqgcnFlmHNjibZZeL4TjtaD4qCvS?=
 =?us-ascii?Q?iWjbjcUXc9T3dSKcF4RTYJXyaAYpvktGaT+Rxpemc54NYX6ZKRPs9YYfk/lY?=
 =?us-ascii?Q?McRKCVUO+sCueMF9dTnERRfUenrEtDP2O8aBXw8x23O+tijLQDv7elih0UDk?=
 =?us-ascii?Q?ULR5tkxqjvHB5AsyP3YLzGmabIYqLuYOyvdcmYJhRiZwMek9/xOCk4102dHO?=
 =?us-ascii?Q?h78wV4Mvp1xnV20t23eKenMyHk7rBHHEYy1iDTjDFBGSn6DszWnBqgGwgHIm?=
 =?us-ascii?Q?mEzqeFAsX4gCfZBWUTrcvFbT8R8T2ev2adyPBmWVGC6IeXWNuts3jeGOVjCG?=
 =?us-ascii?Q?X9KQsJ7xhJ5SQHI52DnG+1ntATqLaMOFR00ZuC+DC8MWyu+ZBGJVHXYNV1cH?=
 =?us-ascii?Q?MVXyNnylLJc55mlIFr0d4v79qfEh+ScJMNlFRyWCwaieWSBP02pC8EZi186w?=
 =?us-ascii?Q?zUBHeH8ydoovs10fshTxQL/27pltJslNUnqSVImZxuX1lnH51MFtlxd2V0cA?=
 =?us-ascii?Q?ENhT7rKQ0hnWTK4O6K7ddY3tGsWs7FFNVcoGhC3lVy+XjWHvhjyMniGABBC3?=
 =?us-ascii?Q?w7IUooj1hHqAoXOvQOtiGdBntltLU5YdSDV+Wi6aapMsLGqSaWMlWvLmK7DA?=
 =?us-ascii?Q?KApCoOoTiMBSed3OTWbL3odX2gK+SutQBbZL1dWfvAqPMzQIQ0qtZb+fu45i?=
 =?us-ascii?Q?CH9YxC7CvHdNDuEV0J3tJydG1ZLG97GoXtoEq5RkP7Z/sMbLyLWs9jn/9Oyg?=
 =?us-ascii?Q?M03r5TEEcSPAJlJI7t9I2bwYuVyjeSdwjU5726Wzb/GOJYpAVwVvXpxyOdoB?=
 =?us-ascii?Q?QLusW7X2uyIB0lAQw/y1vODJN36azS7TEQNbB+6ywxTGp/Z9d3S/OPS5gRGu?=
 =?us-ascii?Q?gTBniyJBGQ1giSlo9eNIHNeEs4YfrL+i5eB2wfw62VeZ07JtV1w7Bd0DgKYG?=
 =?us-ascii?Q?89hHBiKV7X/1xwbGDSgmmIFpv1L5aWmP4myj8WFEgkYy4dFpp2s5KjOuv/EV?=
 =?us-ascii?Q?nhhf8qi2+VTwXSwHGAeJq1HWzz26YjhZQNa1pTxKJYTcVFyZr+sJlAdX8bg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 576ad91d-99d9-472f-6441-08de1e11b3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 15:24:11.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8799

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Nov=
ember 6, 2025 2:14 PM
>=20
> The current check is incorrect; it only checks if the beginning or end
> of a region is within an existing region. This doesn't account for
> userspace specifying a region that begins before and ends after an
> existing region.
>=20
> Change the logic to a range intersection check against gfns and uaddrs
> for each region.
>=20
> Remove mshv_partition_region_by_uaddr() as it is no longer used.
>=20
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /=
dev/mshv to VMMs")
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Closes: https://lore.kernel.org/linux-hyperv/SN6PR02MB41575BE0406D3AB22E1=
D7DB5D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com/
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 814465a0912d..25a68912a78d 100644
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
> @@ -1230,15 +1215,21 @@ static int mshv_partition_create_region(struct ms=
hv_partition *partition,
>  					struct mshv_mem_region **regionpp,
>  					bool is_mmio)
>  {
> -	struct mshv_mem_region *region;
> +	struct mshv_mem_region *region, *rg;
>  	u64 nr_pages =3D HVPFN_DOWN(mem->size);
>=20
>  	/* Reject overlapping regions */
> -	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
> -	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages -=
 1) ||
> -	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
> -	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem=
->size - 1))
> +	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
> +		u64 rg_size =3D rg->nr_pages << HV_HYP_PAGE_SHIFT;
> +
> +		if ((mem->guest_pfn + nr_pages <=3D rg->start_gfn ||
> +		     rg->start_gfn + rg->nr_pages <=3D mem->guest_pfn) &&
> +		    (mem->userspace_addr + mem->size <=3D rg->start_uaddr ||
> +		     rg->start_uaddr + rg_size <=3D mem->userspace_addr))
> +			continue;
> +
>  		return -EEXIST;
> +	}
>=20
>  	region =3D vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
>  	if (!region)
> --
> 2.34.1

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


