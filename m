Return-Path: <linux-hyperv+bounces-7464-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9739C4092A
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 16:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BF2B4E14A3
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4F31A065;
	Fri,  7 Nov 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kl2eyM0b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011063.outbound.protection.outlook.com [52.103.14.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638143AA6;
	Fri,  7 Nov 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529117; cv=fail; b=cdGxjMpphVcPvon8MFB38LutR7M+DLN+9pstqNwlngWIyIGcZTzuzqbRTf6FxqIhTITNQYJukQxkuuzrhraEJPjkKk7xkT3qmvJ9pE9MrejsdeEKVYn+CKJS3bwV3Taqcf+kdoG/U+vZ+PtusEz8KXGwx2U38ITb4qxmiSPp/qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529117; c=relaxed/simple;
	bh=tNcS7KOg/i+5uepQrpOZzrGuvDc/7lDR2XmRNQ32pG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rg298e1xMTV5HT1X5d2x4MobDhkZpEj31y7DbFoyZn2KbrmUReng3wiWMstyUFkVsI+dDrE5fPpPkKL1qmzADFXXnHhE1iTYJJg6qLIr1cvZTZqyj34Oz5WP5xkfjGeduGmogKvmQJ9nzTtWF86VSQg0+7sneJPn10KgfEgQqUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kl2eyM0b; arc=fail smtp.client-ip=52.103.14.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wueNIoDe3fSFuPfLFrS/mVP0gUTwXU5qpxBSP6Q9guY0Hx6CqzHf+zZHOBcWdHMAjJHFMQ4wc10j+7IV/Lpa+29T7Aw4ptGFmVF1zkAgTNSjeriD33szij+3ZKblPb08pM+c1HCZwQqqC6eSCJ0q8CuFtzpvhlzZ9cNYATwQAax1FL2z/BJVY+Sahs2LfUJ6I3EogvAuZTVx2mLMggElTNQgodow/GM7lWk7JPpXQFTglimR+e0Yf3iLc46eRD1Cvbj6ZJEtmduOf6ZNYmzMZOGtGWz+mLydtde2TeleoHC3UPrgOIQJS4u46nclzSd9+glZ8iCkO1jPPs4bYGIGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLG7V3tVM8MOc6zo+xywFFUsBpS+bi1ndUj1ABYaagc=;
 b=yzgTwIGjFnurxwG6tYinX2MQXiQ8u5TzsN72nU40OcnzQcmhUtjcCqLkvSjeAElzo68BpgeNkRYxwINEp+XDUzwjl09zZAPx8v9JhO+maMDsQ38ZosChcj2LwT+8D9OF8WpJZ1touyJwWewpCus6VU1GltnRyCY1hnS+azuLS9hLOf1Fvl9NjaROgWUC/bkvb+H/bToVwyfRW1f3iwFFJiW1A7Rh3eXkpuKybW00mpGO1bnyYeScQY5yrpSloV24rMSMlp7FSv2k3MK/NJskOOroCf9eVW5IviqbSO3QxdtfYpucPTStE+eXw+XZEzIn41Y/ya5EmG5LEdgVDoxEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLG7V3tVM8MOc6zo+xywFFUsBpS+bi1ndUj1ABYaagc=;
 b=kl2eyM0b15s1Rx2wGs8f7j3ryMKpCYsrVzdA3sSkmwy114cMG72acE0447/1WK8Ohj5SJGl1HnflF1TsZT85rwDpphsvQxXd6pWP6OXsut8wDvhOYBoBpAr6FQPQ7Qi+izCf3+WbEGQqFAWBC2fccbY+j8rFKosfgObtK4E6ZrZQLUJGhxu/Bl4rF9wKaQHzrXT8pH3VFR3L15b+IZB1KwiXHNny4Z/bNzwGz8UtZWxtmUpkwRNx5x8aNQA2bB/7hZiizYYi5PoD8BZl7F0EfRd/4qL5dfu2X7EAWZmpq+d/u4XyfkEJf6MqollkYQNnvIfKcbk072KMo/M4SbwyVA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8799.namprd02.prod.outlook.com (2603:10b6:a03:3d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 15:25:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 15:25:12 +0000
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
Subject: RE: [PATCH v2 2/2] mshv: Allow mappings that overlap in uaddr
Thread-Topic: [PATCH v2 2/2] mshv: Allow mappings that overlap in uaddr
Thread-Index: AQHcT2qZsouJr58XzEGD06aDR9Q7lLTnVk0A
Date: Fri, 7 Nov 2025 15:25:12 +0000
Message-ID:
 <SN6PR02MB41571611B46C233A6CFC86E4D4C3A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1762467211-8213-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1762467211-8213-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8799:EE_
x-ms-office365-filtering-correlation-id: 2933652a-c22b-4308-990d-08de1e11d84d
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8060799015|8062599012|41001999006|15080799012|51005399006|461199028|31061999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CSHYqRDdmzs9QAUkOk5klrkmngR3dspvt/eZWVx71G0wuUcFG9KCwAju3Za5?=
 =?us-ascii?Q?sQ13Jczgqi2WcEUX17NrZhgkMetA/LWcl5GyCSoFTcO/rwleJ3IgRkaHjiJ9?=
 =?us-ascii?Q?1ef7q6JZClow13naMyiGKoSn5N48qVDjWqoUC+l1FQewnDeu6bO5nSYuuHN2?=
 =?us-ascii?Q?Jeivy42pVKAjy1mOsCd8KXBq8CZIiL+jubaWiJoAsSEfoVxVRi4sQCLjrywR?=
 =?us-ascii?Q?2zeEdDaBM0OH+lJca4Vx0QxCZ/PeNesW62xd9FpBthNZjqXO3jWpJzRGND7+?=
 =?us-ascii?Q?YdWrqtVsoCanxaILNBt1lwIljvSLH+swvGJnj9J1vommFNHOnrdHzMvZN4R4?=
 =?us-ascii?Q?oW1pv+GGYfMvb8ye//JaLEeAXQhJEdygANgP8jmwAMog8WPUs3hw6du42yyJ?=
 =?us-ascii?Q?QQ9sB5fAGbwo3gkXrR6rA2WcfDq5iB05ac54FtX82qvY3JL9b7RQqVfd3zl0?=
 =?us-ascii?Q?4n4ooew8uKli57L4OKw7tzugpAxZtrNvsFeUBSAMl6WY8hr9JDrC6hvvmx7K?=
 =?us-ascii?Q?dcl79A5GI65YwkK2HaYntSjKeH/6PmCiyM1eyPTLKJyRqE4PizKKFRl4yGSp?=
 =?us-ascii?Q?C0xmIYhFYgnYmbjT/nIW9ccEynz+A6pHW9Q3cGaJ4NUtLsGQ5jw5NcsyI6Rw?=
 =?us-ascii?Q?zZyFxrHsRxPGYzjmF9/Iptq1SSCnWQQ20DHApj/PA2nyEskDo2gXeVF8xQSV?=
 =?us-ascii?Q?hXp/rRv3H09ysRey8v6otupL7xiGjd0upC9vy5LrShHVRPkqjPuqyxLC2gCB?=
 =?us-ascii?Q?X/XX/ajEWqa7Er/S0T7tUa+X4NKExlyo9EuWRhpgVLdJ1oV54G+K4DPjj3Zm?=
 =?us-ascii?Q?bi4vFICqrYNwZrzW3YSydPf57J7ecBX8GsJGGHsGaaGLxPkg34yG7LZVcE3h?=
 =?us-ascii?Q?5QDrbUM598wmoPH50kyhXJXhxE+ANTvA+akfAl1nMPEYhhoVaOE/94TIXdnb?=
 =?us-ascii?Q?tP6ihc+gEzW4yYX8TIeNS6cdEm1TBluX4I2ahx5mL1fo1LyGdNSGeN8rLnLc?=
 =?us-ascii?Q?BQQhrm3ECO5pz+6kTcw8d+R1npasQHkv7rDBYgWLzjVd+BbKdBYbcIVoxsZh?=
 =?us-ascii?Q?0k/Cu6kgVC2xjFvQWu8nHiZhUjWDH5pTAd2XrIchmkvVLHqdYrxmlylL0oGn?=
 =?us-ascii?Q?EdJhkWe3zeRC9zGPqs8ue3kYzvJftIaFXZvJkYEf26Y2NWuyWM2+qEAL20rC?=
 =?us-ascii?Q?9JXQeIhPTF1ESjNSZbBKtfHvDkyjyzoiZUKp7SRlhFtiwos4R59yeuioIzA?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QMIkW3rHgu5/BTuCDg2++Q+jjkDSFAngteUtLq7vfQ07hVCoMrFZ7/e5qTdx?=
 =?us-ascii?Q?5p5GVJrzgknqZ0rMe8ith4UAhovxpGiIr2XpWY4JJTSHN517e1Xd+5wzFN4X?=
 =?us-ascii?Q?qHQK+tS3hA4MgzULnfrjKBYG0b9IwcyGvzSdcu4qvkkvC5j47ngAhSSx3HFE?=
 =?us-ascii?Q?hf7ZeWdq/rDiwrw1ZtiygSnIjX1a11lDaS2S4XLze1PL75rB+CJjQpe86+sU?=
 =?us-ascii?Q?jS+N5eFlhceyxd0mRm8esTw9osqyYEIHS6kN6eK/OuXMmEX6ydJwf4XvzGJz?=
 =?us-ascii?Q?INmAPNJfe0Cyc/9WTqE7kAquSelagWIwrys740eVBIMmLMEXcdq9HC7KuTxU?=
 =?us-ascii?Q?7owr86BiaryTCAOBgg5bMs9MYMcidWGPTCaAZvsknw3ygqc9kAQuE3chWfyM?=
 =?us-ascii?Q?g5ma1P47a+l3xwTr+p6zffONJmgCHKtqzpFWKe/0/S07BQXKg1b+CPJbBW5H?=
 =?us-ascii?Q?dqQxZAYHN7ij3nkOK/DPVSVNtkJZLJ7qSVaHL184Mw46vLWDaOGr/B7Pd993?=
 =?us-ascii?Q?slsxjAo9Cq4kTrubuvxY67Mp8hwroF8ZoHPvibo47ohRhpdOGrsEgLL5bnIK?=
 =?us-ascii?Q?hHIzMbNHypEZVjdtJr1D4vM3Oi2AB+9TAfJ7a8L7/0B4G4GCnAur1JFZ+4fM?=
 =?us-ascii?Q?whfOMEtBE+SwnkEN5DZuQF7u+2tjHw2Uqs3YX10MM6Ggfq+FrQyC8sRJ9Te4?=
 =?us-ascii?Q?f8vwsHE2jVG4Ld/5lUYZsuzKdj9N4uP3L3LMR1fx+bm5qBVP9LJZoFhiuNN5?=
 =?us-ascii?Q?kkBSdFZKMnxVAW2uvzzwIwgcGmB3icgpw9e20sruD7jR1bNs6wDtyFbjTYzI?=
 =?us-ascii?Q?z+n+F3eyzLU9ZItVIIHlL/QZxahH1vj8zNP8IBQvsVINl1sZPGDctRGtS8J0?=
 =?us-ascii?Q?nxYpk+1IlRDpMNrTlPz5mE5Pa2mCKaphhLmxWTQVIJxaJe2B1/G5Y1tvJfhf?=
 =?us-ascii?Q?m25Zhf3YTpvpLjn0Bpwb3jPzitKBE67rSjLc5JFe6FZfFsXDxa6HI8w/Az6z?=
 =?us-ascii?Q?lSXlTvba7v8MlwRdNNRTfVm+yePQ4julhpJfF+WTbWAjbld/z3D9fZcrhI81?=
 =?us-ascii?Q?3D4O+qDLov64TE4zbCQZhtPeojrju/WaQY6cRyN7hkLzGuMmBOpt2+7S8Nhz?=
 =?us-ascii?Q?DzDvnI9Zw1sWQiCvb0mbe+cZcgdWhSuXJqQ2g0gzeGUTz1wOW9W0/jL/oROW?=
 =?us-ascii?Q?oXCYYoODJjhSmjCR0UqTkThG53vzQVT7Wq9pcLMNU+J4r/IpmGV+cU3hmbk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2933652a-c22b-4308-990d-08de1e11d84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 15:25:12.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8799

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Nov=
ember 6, 2025 2:14 PM
>=20
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>=20
> Currently the MSHV driver rejects mappings that would overlap in
> userspace.
>=20
> Some VMMs require the same memory to be mapped to different parts of
> the guest's address space, and so working around this restriction is
> difficult.
>=20
> The hypervisor itself doesn't prohibit mappings that overlap in uaddr,
> (really in SPA; system physical addresses), so supporting this in the
> driver doesn't require any extra work: only the checks need to be
> removed.
>=20
> Since no userspace code until now has been able to overlap regions in
> userspace, relaxing this constraint can't break any existing code.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 8 ++------
>  include/uapi/linux/mshv.h   | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 25a68912a78d..b1821b18fa09 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1220,12 +1220,8 @@ static int mshv_partition_create_region(struct msh=
v_partition *partition,
>=20
>  	/* Reject overlapping regions */
>  	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
> -		u64 rg_size =3D rg->nr_pages << HV_HYP_PAGE_SHIFT;
> -
> -		if ((mem->guest_pfn + nr_pages <=3D rg->start_gfn ||
> -		     rg->start_gfn + rg->nr_pages <=3D mem->guest_pfn) &&
> -		    (mem->userspace_addr + mem->size <=3D rg->start_uaddr ||
> -		     rg->start_uaddr + rg_size <=3D mem->userspace_addr))
> +		if (mem->guest_pfn + nr_pages <=3D rg->start_gfn ||
> +		    rg->start_gfn + rg->nr_pages <=3D mem->guest_pfn)
>  			continue;
>=20
>  		return -EEXIST;
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


