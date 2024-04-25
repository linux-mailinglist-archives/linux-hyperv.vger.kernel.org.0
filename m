Return-Path: <linux-hyperv+bounces-2045-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F28B2426
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Apr 2024 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2452C288424
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Apr 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574814A4DD;
	Thu, 25 Apr 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hNnxzVdP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2034.outbound.protection.outlook.com [40.92.42.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3541149DF3;
	Thu, 25 Apr 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055516; cv=fail; b=VscMVxqMZ4t5wDnOjo0v3gPI9uWHbYTta63wXEY25xn+rT94SrwQHoZ8LzsjZ2P/73/Y0r0SOsVs6WhLq3Rlz+t5Sn3Pl70LTg5pet2e9jt/JwPbCcwWmyjCnxnCCHE6TN7uqG7nDrplMCtwpxXYx71Ao8S7xxhjBcg5V+iDRvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055516; c=relaxed/simple;
	bh=6wlsv6RAv77UmYIhs/TSS6IEZZwcskak7Q3PR5JaA+A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bl3pnPBqwyT6mEkMBKTcqRaGS/XUPGwQ+aLbRk4k8+wNMeyHg9QRtQ4zTP/cly/xqTTiSILDcK30/f+q2G39juHsPtwpzD/AgOOoCURCIJ3Ex9rbU8hoNy1zcG/QPuIwjOTf57vx+ersz6VFHLqNTZdvATlWpOPCKvFMrrVt7/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hNnxzVdP; arc=fail smtp.client-ip=40.92.42.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwYUjdkW+I9WIIdWrCtJ8rIiABHBwaxs6h2GlbSRLkhHv2dOwm3cIHA2zH5wEwcLjAMeTl9PN5MINI378h9Eu97yyZo4P9EYo+3VKVKtzEJGcOcxZ8A3XUv6sZvvxt0h9ZY7B8z+uWeHQSdAHoH2eeAP6nkJW7DipUraiToBqSjwnOYxVJFzQMVVG39XHGotUNGnPTvXLlhg8AflYIIPFb4PU+3Y82X6IvUg+5+dUBocD8uIKzA2keQK/flvncXoOBXpkoiuLgb6HHHI36M3DOnCmpXTTYh5hIWTyNb+byufIO0DVOPhOVIHdmc5Q2/MPmIvFbYSACPsgoSG7cuQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTvWH0YS7g5jVUPdVFiqd/K7IpP3mrV3U0p2+0dw3ro=;
 b=cH4NkPQJ8sXmjXKA+89cJGiGYWQz3ekMv6l4VC2GadQOPmaAqh9al7mPKk9dDhr/rI0yoaymhWQupc3zsYUpwCeqwcBctgT1DT1i0OaegZPh/QnWg3EA2KBLOuJhJ3ZS93IYVjhhwYqhSLVZjUcsdH16BaJktAMIn0GgOupmgCQjuAqkDVuMgjVI3PqBt0vuUEM5dgPUKRM1ehwFu9p3pAzHbZWDiS4qTlrJrUxtq8jZQwpg/OpsIXs7tyU0Bo6+Ar41ZvIwqhwLei3El27ujTk0TAOI0poeTByC0mGTUNWE15Db5wMI81OeaHqjybKIkqvrop5QBZ54pMBmfJue0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTvWH0YS7g5jVUPdVFiqd/K7IpP3mrV3U0p2+0dw3ro=;
 b=hNnxzVdPlj9aIX54f33A7uM78GA4EkYESRXoyllHYaN8h/BnMC40o3YnTV3gJOm1wrix++c+10SprG+9uUpYpOj56iIRhc99ws7ZF8Ln2J7syjn9i5MrB2Fi8OUVe4Ri87CokHDsirdyTDnrCSlQ4orCgL9rO4z0zGmvuI8xc1nF1rknGbmU0UIO6UB0aC+Jz2eoRpE1xCg0MQZM4mhmBxpElSb3ETzue0K2oQRIUgRfcqCnMiDiVhv/USUyFgRyR2yBn7VNWpvSdik9Kw154gsviJ/6iyM4Dlrj2dgJKdxXvuzUpwOHdv4NJdk982VaBtXApk7HxPrgTvSZgAn+gQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7400.namprd02.prod.outlook.com (2603:10b6:510:8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 14:31:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 14:31:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] hv_balloon: Enable hot-add for memblock sizes > 128
 Mbytes
Thread-Topic: [PATCH 1/1] hv_balloon: Enable hot-add for memblock sizes > 128
 Mbytes
Thread-Index: AQHac9/FvegMInbDgEC8/Y4zZ5caUbF5UQNQ
Date: Thu, 25 Apr 2024 14:31:52 +0000
Message-ID:
 <SN6PR02MB4157F73AB998A1C247177609D4172@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240311181238.1241-1-mhklinux@outlook.com>
In-Reply-To: <20240311181238.1241-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [fOIdJtm+mqV8RrVmJNQMZ1NB6Yraca6K]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7400:EE_
x-ms-office365-filtering-correlation-id: b9586c7a-d93a-41d5-df5b-08dc65347305
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 plAgk5+IFRJFIcy36KGy/HRgsKzU4N4rSKf21qxoLPNJvWi6O36WqguDB1oGXwnkF/xXZxxYBS8NZ0LoxN3nBctsnctOwU1o/vee2igYK4rjFNUptos3LGLf+uuHJZcsM5/Kh3g7YUQhFne49MH3aF2Ax7jboDt4KlcAQMiBBzYmDys5DNDvKwn7n35bgqHqgb20mIm8aBPhU3NFqE+hMOsVfyrKmaAixh1grtQLvmfck5HbLbluoLnxRryN0f+eb5XJ5FMEr32SW3cOyIyuxAZ4s42euNYrj8XCRdMD+FbqN3iyNiOsbxhTU8haZMqZDPqsrDNrUB+7ijUBcKQJ//tRowUGYfgQ8nos1jcG8bSS56Tg703U3cVh0q+Zi1dydM/r55lohlzj5vA6rjLt0RQ7hw+G312cpM2Ln+E/oNA8QczqOXMLEcA3gdR9al5cmKjUhloMfl2cFHbZsQERJFRTqMQyDO5Sz7PEcopNbN3lnVrHQzid/vJbPBuBRnIp/yLz2dfzBhbMCQd88sXHB8M8Kw3oY+7P5of90v5ltT+bV+o07QkuFsl91CzFlhwAwyL87/XHtOVlXf3aoEgS6JY95F2qAnbCu/kOMFDVPfTRXgZWw1NWedNdFSrZVrkcTI61ej0fz/83eV+5xnj9+EKirXvz9GQ6gOFoJGXxNRbaW2WaybtWdpJrWtqGxeUhb9yQmZ0jC2d33+0oTykJsPtmjuvDPKQ6zpAnQC1FOWTpXOZucH4E6USsxxdYfEA8
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mm/qRYN43DwKOb6hMhSP45U4M0X47GFqNJsOm7BDqCGoMtKarcmK/fhUavA3?=
 =?us-ascii?Q?/is61JQMlmU6BFjQHNQVk+GY9vfa7oreIrTQM8ymeMZw7b3uPNuqYMDQSDH2?=
 =?us-ascii?Q?P0mC2Cbo8W0GZghCpk7nsLsYMFVTzP7frZ/0u/v5odrmCK2Hoh/jPV9sgeXe?=
 =?us-ascii?Q?P8dg3kha4CkRysVr+TINLYDB7iCBBUXAziGJRUaduJQxE/QTxNAvWoUtkPt3?=
 =?us-ascii?Q?PmK59f+eNm3GidJUIVCL74ANaTi7M8RA+nzv7xWEvvS+zxFheJwHIbdZdJnK?=
 =?us-ascii?Q?p5COL0fJqodkttj8vl+Tg9YljaLvOeQYX5ep+3tMouVJBirq1fjdbI4xzVlv?=
 =?us-ascii?Q?UFvO2VLyy52STC2yE9xa1gI8Mjs35rBlDJxfhETRTBgWcnvfF//spnszRHO2?=
 =?us-ascii?Q?2RBJak0/ecUWpZc1toh9u6OEx3aFjkrzrxUXAl41b+jwOe7FleThmJ3DM17L?=
 =?us-ascii?Q?XErey6kj1kQkPGfGAG+ODd3QLPvdYIeQACOxFw7Mn67dCI9B0wq9YI6Y1Vca?=
 =?us-ascii?Q?ie2gfysJ3r10njEgciKk9it1OX/ErqBoR+IDp+r/T1F4jgjrfrMZAFQD641y?=
 =?us-ascii?Q?A0XJgS96FzzY6oDzKUo2NG/EtluD/Iic6Ax6bAyuYJ8z9JCz0X8nn7O77iUD?=
 =?us-ascii?Q?IgahfhVUy1d2TRgzynCHi5IMyLHFo/3t8VRm0SE5FtmmeSyZvIcQ5xoi10iT?=
 =?us-ascii?Q?ggSDxXy/jLuGjqFLKES+1F0xIwDV4dlUzNCYYNa3v3Nj/cHpyVp/AilGhpuR?=
 =?us-ascii?Q?/RSpgmQjnyTG7coggj0rqeo+lvveY/1i7V1cggkpdICS7n54SHuK+E0v6LV6?=
 =?us-ascii?Q?TFCgtkdE6qoVMyVwd6FEd289dvAl948P99ViPFSZunZTjp7QuyrEYE7uJNg1?=
 =?us-ascii?Q?qVL5V3GCxTi9fRbLHOzEjuv6MmpjrIAjetfG1t23DJf/6OSKi+Ler5vGttps?=
 =?us-ascii?Q?LmhszAG7VWB47vQ7XYEq2jbqCYOk1IE3z49Qv7hQWfy+8FYnCbF+eMrMfArD?=
 =?us-ascii?Q?uU6vSZC62E8jZ3nvqsYygsMiv+p4hWItqgXQir3NkPRl5j7YBWGGCd1ECYTZ?=
 =?us-ascii?Q?j4B5IUImTl8vb5T4zUfx4dfz274gJ0iC02r4tyPqCrTGKdqDxfAq9zfPZ3zU?=
 =?us-ascii?Q?UURlFJ+u1Fzm9vYd0IeNi1mUsEphSbqXaR1+u3lRkk3D7YIKZ/q08+do9qev?=
 =?us-ascii?Q?wa8N7WeT1Eo7iBpBenXMgfnD5U76TXHqpsFWpQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9586c7a-d93a-41d5-df5b-08dc65347305
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 14:31:52.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7400

From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Monday, March 11, 2=
024 11:13 AM
>=20
> The Hyper-V balloon driver supports hot-add of memory in addition
> to ballooning. Current code hot-adds in fixed size chunks of
> 128 Mbytes (fixed constant HA_CHUNK in the code).  While this works
> in Hyper-V VMs with 64 Gbytes or less or memory where the Linux
> memblock size is 128 Mbytes, the hot-add fails for larger memblock
> sizes because add_memory() expects memory to be added in chunks
> that match the memblock size. Messages like the following are
> reported when Linux has a 256 Mbyte memblock size:
>=20
> [  312.668859] Block size [0x10000000] unaligned hotplug range:
>                start 0x310000000, size 0x8000000
> [  312.668880] hv_balloon: hot_add memory failed error is -22
> [  312.668984] hv_balloon: Memory hot add failed
>=20
> Larger memblock sizes are usually used in VMs with more than
> 64 Gbytes of memory, depending on the alignment of the VM's
> physical address space.
>=20
> Fix this problem by having the Hyper-V balloon driver determine
> the Linux memblock size, and process hot-add requests in that
> chunk size instead of a fixed 128 Mbytes. Also update the hot-add
> alignment requested of the Hyper-V host to match the memblock
> size instead of being a fixed 128 Mbytes.
>=20
> The code changes look significant, but in fact are just a
> simple text substitution of a new global variable for the
> previous HA_CHUNK constant. No algorithms are changed except
> to initialize the new global variable and to calculate the
> alignment value to pass to Hyper-V. Testing with memblock
> sizes of 256 Mbytes and 2 Gbytes shows correct operation.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Anyone interested in reviewing this patch?  It's not an urgent
issue, but as memory sizes get larger, someone might trip
over the problem.

FWIW, these changes conflict with some of Aditya Nagesh's
whitespace cleanup in patch [1].  I'll respin this one to
sync with those changes if Aditya's patch goes in first.

Michael

[1] https://lore.kernel.org/linux-hyperv/1713842326-25576-1-git-send-email-=
adityanagesh@linux.microsoft.com/

> ---
>  drivers/hv/hv_balloon.c | 64 ++++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index e000fa3b9f97..d3bfbf3d274a 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -425,11 +425,11 @@ struct dm_info_msg {
>   * The range start_pfn : end_pfn specifies the range
>   * that the host has asked us to hot add. The range
>   * start_pfn : ha_end_pfn specifies the range that we have
> - * currently hot added. We hot add in multiples of 128M
> - * chunks; it is possible that we may not be able to bring
> - * online all the pages in the region. The range
> + * currently hot added. We hot add in chunks equal to the
> + * memory block size; it is possible that we may not be able
> + * to bring online all the pages in the region. The range
>   * covered_start_pfn:covered_end_pfn defines the pages that can
> - * be brough online.
> + * be brought online.
>   */
>=20
>  struct hv_hotadd_state {
> @@ -505,8 +505,9 @@ enum hv_dm_state {
>=20
>  static __u8 recv_buffer[HV_HYP_PAGE_SIZE];
>  static __u8 balloon_up_send_buffer[HV_HYP_PAGE_SIZE];
> +static unsigned long ha_chunk_pgs;
> +
>  #define PAGES_IN_2M (2 * 1024 * 1024 / PAGE_SIZE)
> -#define HA_CHUNK (128 * 1024 * 1024 / PAGE_SIZE)
>=20
>  struct hv_dynmem_device {
>  	struct hv_device *dev;
> @@ -724,15 +725,15 @@ static void hv_mem_hot_add(unsigned long start, uns=
igned long size,
>  	unsigned long processed_pfn;
>  	unsigned long total_pfn =3D pfn_count;
>=20
> -	for (i =3D 0; i < (size/HA_CHUNK); i++) {
> -		start_pfn =3D start + (i * HA_CHUNK);
> +	for (i =3D 0; i < (size/ha_chunk_pgs); i++) {
> +		start_pfn =3D start + (i * ha_chunk_pgs);
>=20
>  		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> -			has->ha_end_pfn +=3D  HA_CHUNK;
> +			has->ha_end_pfn +=3D  ha_chunk_pgs;
>=20
> -			if (total_pfn > HA_CHUNK) {
> -				processed_pfn =3D HA_CHUNK;
> -				total_pfn -=3D HA_CHUNK;
> +			if (total_pfn > ha_chunk_pgs) {
> +				processed_pfn =3D ha_chunk_pgs;
> +				total_pfn -=3D ha_chunk_pgs;
>  			} else {
>  				processed_pfn =3D total_pfn;
>  				total_pfn =3D 0;
> @@ -745,7 +746,7 @@ static void hv_mem_hot_add(unsigned long start, unsig=
ned long size,
>=20
>  		nid =3D memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>  		ret =3D add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
> +				(ha_chunk_pgs << PAGE_SHIFT), MHP_MERGE_RESOURCE);
>=20
>  		if (ret) {
>  			pr_err("hot_add memory failed error is %d\n", ret);
> @@ -760,7 +761,7 @@ static void hv_mem_hot_add(unsigned long start, unsig=
ned long size,
>  				do_hot_add =3D false;
>  			}
>  			scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> -				has->ha_end_pfn -=3D HA_CHUNK;
> +				has->ha_end_pfn -=3D ha_chunk_pgs;
>  				has->covered_end_pfn -=3D  processed_pfn;
>  			}
>  			break;
> @@ -838,11 +839,11 @@ static int pfn_covered(unsigned long start_pfn, uns=
igned long pfn_cnt)
>  		if ((start_pfn + pfn_cnt) > has->end_pfn) {
>  			residual =3D (start_pfn + pfn_cnt - has->end_pfn);
>  			/*
> -			 * Extend the region by multiples of HA_CHUNK.
> +			 * Extend the region by multiples of ha_chunk_pgs.
>  			 */
> -			new_inc =3D (residual / HA_CHUNK) * HA_CHUNK;
> -			if (residual % HA_CHUNK)
> -				new_inc +=3D HA_CHUNK;
> +			new_inc =3D (residual / ha_chunk_pgs) * ha_chunk_pgs;
> +			if (residual % ha_chunk_pgs)
> +				new_inc +=3D ha_chunk_pgs;
>=20
>  			has->end_pfn +=3D new_inc;
>  		}
> @@ -910,14 +911,14 @@ static unsigned long handle_pg_range(unsigned long =
pg_start,
>  			 * We have some residual hot add range
>  			 * that needs to be hot added; hot add
>  			 * it now. Hot add a multiple of
> -			 * HA_CHUNK that fully covers the pages
> +			 * ha_chunk_pgs that fully covers the pages
>  			 * we have.
>  			 */
>  			size =3D (has->end_pfn - has->ha_end_pfn);
>  			if (pfn_cnt <=3D size) {
> -				size =3D ((pfn_cnt / HA_CHUNK) * HA_CHUNK);
> -				if (pfn_cnt % HA_CHUNK)
> -					size +=3D HA_CHUNK;
> +				size =3D ((pfn_cnt / ha_chunk_pgs) * ha_chunk_pgs);
> +				if (pfn_cnt % ha_chunk_pgs)
> +					size +=3D ha_chunk_pgs;
>  			} else {
>  				pfn_cnt =3D size;
>  			}
> @@ -1021,11 +1022,11 @@ static void hot_add_req(struct work_struct *dummy=
)
>  		 * that need to be hot-added while ensuring the alignment
>  		 * and size requirements of Linux as it relates to hot-add.
>  		 */
> -		region_size =3D (pfn_cnt / HA_CHUNK) * HA_CHUNK;
> -		if (pfn_cnt % HA_CHUNK)
> -			region_size +=3D HA_CHUNK;
> +		region_size =3D (pfn_cnt / ha_chunk_pgs) * ha_chunk_pgs;
> +		if (pfn_cnt % ha_chunk_pgs)
> +			region_size +=3D ha_chunk_pgs;
>=20
> -		region_start =3D (pg_start / HA_CHUNK) * HA_CHUNK;
> +		region_start =3D (pg_start / ha_chunk_pgs) * ha_chunk_pgs;
>=20
>  		rg_start =3D region_start;
>  		rg_sz =3D region_size;
> @@ -1832,9 +1833,12 @@ static int balloon_connect_vsp(struct hv_device *d=
ev)
>=20
>  	/*
>  	 * Specify our alignment requirements as it relates
> -	 * memory hot-add. Specify 128MB alignment.
> +	 * memory hot-add.  The value is the log base 2 of
> +	 * the number of megabytes in a chunk. For example,
> +	 * with 256 Mbyte chunks, the value is 8.
>  	 */
> -	cap_msg.caps.cap_bits.hot_add_alignment =3D 7;
> +	cap_msg.caps.cap_bits.hot_add_alignment =3D
> +			ilog2(ha_chunk_pgs >> (20 - PAGE_SHIFT));
>=20
>  	/*
>  	 * Currently the host does not use these
> @@ -2156,6 +2160,12 @@ static  struct hv_driver balloon_drv =3D {
>=20
>  static int __init init_balloon_drv(void)
>  {
> +	/*
> +	 * Hot-add must operate in chunks that are of size
> +	 * equal to the memory block size because that's
> +	 * what the core add_memory() interface requires.
> +	 */
> +	ha_chunk_pgs =3D memory_block_size_bytes() / PAGE_SIZE;
>=20
>  	return vmbus_driver_register(&balloon_drv);
>  }
> --
> 2.25.1
>=20


