Return-Path: <linux-hyperv+bounces-7014-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DDDBAA3CE
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919E11923175
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E121D5AF;
	Mon, 29 Sep 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uj/5q6jw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011009.outbound.protection.outlook.com [52.103.1.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1933086;
	Mon, 29 Sep 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168607; cv=fail; b=YTah5HdAneeBhib8QbwyLXBooZshA5qipvAVgh7HM1Ko/UhMO2GlNKlfXTewV40PnaQ3HYH+sYPNWtxDE+76bqJq1whkCpl6SD/UGSOjM7wFJgDxUPUUDMsmDk1Jvn8VrAVoKb8adTs40CIZxUCfcO7xoZ78BeHJ1UAFcmubuPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168607; c=relaxed/simple;
	bh=/PrBFliS2Cza/B87KvxpJ3qBcjJDiMN228tZzGNuGTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=csz7c4HOc0vJVf7c3bimEk1YLP/es8W8wN8S55frynUwqJXjIUUa+t0BHvHx7OnaMux7wWLPu3mRalCkWGxnMUfqf4b6vOl7c3yAirbtN6/JGQpipKo55lCQ2/e5usdRugk/Pjcj036zi5rvQn26WZTzwD+gPa9BetuqQ2uVxxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uj/5q6jw; arc=fail smtp.client-ip=52.103.1.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upIb6RtlXRjUFpp/mZKYtMo9bAci4LkAtqsVsMfl/z6ItQtqQyGW8YQQWyamNo5rFCVBuaOA+XGH/DrLRtLGvNSRnZYOwKf6zT2uJ84vKXnaIIHLxuRBbV3HQmadBbzigxa9JlMK9lqZxP8HY/2Y6QTyX/PNi0/gM17TQtQqfqnYnIMdGjURz1BmZgLjBjdr3AmaJbpZ1Hp/WD2IHnR1zkJh8qpKEYUwIKzAgS2bje8QF1VXsYZIvZX2EuxrVRcPNy8hKXRwlViBiV98kVXgFBaS6wt+6JdVM3nUUMn8VFwaSmmNpzNcva0mFK2eShlsTtNERcmksL47lEHSJod53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgO/gdog21+87LW2fg2wMBhmeHaz3OcMJxY76aOj4es=;
 b=sv8G/+UO31YHkcB3rB89p8UYQUXaLfUrXerM4TJDpNm1iiJ47wUBj+NJ3UvhJkJHBobKjDwxr4eGqj4yIiqxyy9+vfwkoaEYX9TrEcfWlYqE7yb2lZ8E9oQTyV51C95N/yeOgfCUY9Ng7Kn7qoTtTRTwi7GyqI56R3OTCF8PfNNVEPezZ7Epb8a6AylP4uWNo1fjDSM1n/7e+ki34g+EdohDIUdVfWp41iMNUn2bwX0VJw9/uyseBmz9onDE66jcox6L/MfVE0ZJuriQ3XQr0eNyh5UAnDpbhGFYIDXnoOaiUouXUd0qlQVSBsWZUuN2BASusqBc1qnHx7vUZkKMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgO/gdog21+87LW2fg2wMBhmeHaz3OcMJxY76aOj4es=;
 b=uj/5q6jwp+WPM8CdWV/K03eIgpFQbsEfQshHPDkAkvOGDwY5aizwnv0+dWuMbNMVyZ0rj5JD96Xr3mrUj9CoeKXOsXRDJ30hPZ49uaIIfDzeU2xuZENLvCPC46t0xBdMUQ54HkX1nOqwFCHLDwdlH/X25qmAEkQs9KQFOUJwB93kjJO+04QK8k4G7V6qVNNQMqc+CQcHBGmXI7F7Of/khtkWxhIFpUP9AWxnmnJrgwH5HOASjgEZHb100mRHorEAP7hhyEHhZwvByKLF+hrQHgUtpe7yQtcrASG7cuvZvMqIYH29aYQn9OG02CXrCs/IHwUzHl7heiwNvBmd8nOwbA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9897.namprd02.prod.outlook.com (2603:10b6:208:489::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 17:56:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 17:56:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"paekkaladevi@linux.microsoft.com" <paekkaladevi@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, Jinank Jain
	<jinankjain@linux.microsoft.com>
Subject: RE: [PATCH v4 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
Thread-Topic: [PATCH v4 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
Thread-Index: AQHcLwIJ67Rvwcf9OU+03OvTNyRllLSqZUqQ
Date: Mon, 29 Sep 2025 17:56:38 +0000
Message-ID:
 <SN6PR02MB4157E95BDC70A1F91228DAF7D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1758903795-18636-5-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9897:EE_
x-ms-office365-filtering-correlation-id: 716d6c01-3ffa-407c-8fd8-08ddff818a22
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|19110799012|13091999003|41001999006|15080799012|12121999013|8062599012|8060799015|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?l85kKRBZNM3bpVHEZSPY5g95cQGYWQN0MDMKXieNCGYmSSVWrNHKouxSsq+o?=
 =?us-ascii?Q?EmGI9/boart/iLVdwwRA5yfnrOSHRRPE9n9aQrcL3s0jQaQzkCwBWgHFQCvF?=
 =?us-ascii?Q?uZLVVIsRAlyo8P4W90wm+TsaevJ8Zz8Pc6OVF8RisBWr8WEHrR5NqDrvvg9+?=
 =?us-ascii?Q?WGq7zpNk33rHL2bI2PWZNtv03SQm1UwsfAVNsU9oW2aLL5kDAP/4OqYEPHrD?=
 =?us-ascii?Q?HMPDVTQ7kJ4OQxz+du7oDaAvgf635vMiewFQ6GCkasjRCaOGyU6AIY7BCiDB?=
 =?us-ascii?Q?tEk6ruRodVsHR0E2l8rjo3vlXQS+GDxOfXeOCMUvY+Ip6SFCDfT/oLAbgmj2?=
 =?us-ascii?Q?QmPOuv4J5ShbWOE60Dvqkb3iUYW1dv5OGg1oxSa/HfZJdQXEPdB619G3BrvH?=
 =?us-ascii?Q?7Yc14Tmd1qRX145fJYILPCnE8DM1/cUpkgBOGWpbyuLb/HvPcRyecmnqPg+8?=
 =?us-ascii?Q?hb6LWchQsJgy6ONlBpqpRWLOTjYWHDpiDw8nBSLCmHzB9FWtrIqdIatur56z?=
 =?us-ascii?Q?xhG1q3v9z9bpZ58M+p/yg0wY1OwlTLjgSbmgdvIjxhnYEPteQsyrFLtOheQp?=
 =?us-ascii?Q?t9qAfnC7/LbCmrQeJtFypvJVuZ7Z1DpTTRkqtXncz0Lh4PVYvu1fUs/IWf1l?=
 =?us-ascii?Q?QpF66O/u9ovyDefS62GA14mXj5zO/OsFtiS47ENuTUhhTldgXXjWEiGVodWB?=
 =?us-ascii?Q?naxha1QFy7rnybcPBEN1/8Zbm3kROBCwg790R+WhFrXVN5skzYOx8M2QseKB?=
 =?us-ascii?Q?rAgFSXD+TplM4YSYTnhOSTHM6KRY6tjR08PRw2JqqmMFQdeFbCam3+K1SQZA?=
 =?us-ascii?Q?HXJvZgy17VdPb7PfcA01dJeiFY4MrhlyElWB3Ff0IiC9kDUixAoXgJuO042g?=
 =?us-ascii?Q?YznhXtn0zu6vWgD0DwuhxWu1J54n6DbDUsztqy1BoY5x9D5ZsIS6rAIKCJ8/?=
 =?us-ascii?Q?IWMYq7WemJ5k4SJLguZ/MAwS6+9g4xZadu7kQPcAMoMcz5PLYmfNt1agHMYb?=
 =?us-ascii?Q?SGe3MRrqbzSenpNeJXwIj2xXJvzG5cN7fT++5P42HO/k/acpIS36hCpfWlZi?=
 =?us-ascii?Q?P0t/7CuOdEHKrF2uJzN5S55miBlVQvdkvSmzDCieB0mnBKubQCQhJPSpRvy3?=
 =?us-ascii?Q?yqwC7RxDlvupKjBTerItFGKCZvLwkF5TlAZKPv71InF81oZopH6wXGr6yteZ?=
 =?us-ascii?Q?n/Rgm3j35KjVE+39SZjo9SZ0DQJNkhVQEgIvo5AkOiej4GMUm6lzXQlcPL2G?=
 =?us-ascii?Q?EQQGIVPot1ND2+J7F0xtfH9/fwYJNcRqC3JhUlZslQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ts3Tqqm2Qhu3zU5cNVnKnHf9x/ZWOnqa6cq+0hmvL5hSvnwkPnJYCowcPM3Z?=
 =?us-ascii?Q?+RyZYqBgxgcySul0HnKl7SohAh2by16jU4x8WOJLfrS81I5arBkTeWKDilIE?=
 =?us-ascii?Q?Q571gIqnINrGPFBSK4Yhw0YHecQnYtpym/JEe0tgT3Q8Uw9+mwHYu41uQUmh?=
 =?us-ascii?Q?YQ/xh7yn+JlEE2BEdn+LfJnN/+RTBWxd1WdB37z1n6OZgys2tmHuNVupwEza?=
 =?us-ascii?Q?sJzCHo8eAzioWR7sNseLwqzK28TPappTFRUSHNsPDyqyn8dnVwgOdsg00qRr?=
 =?us-ascii?Q?D84smyQzY5zzyUWUaxvUBT11tV4qGLsJYiWDPyedKOVxCKNmHjWRfUCkxnHf?=
 =?us-ascii?Q?+WSK2bT3jvH/Kqbm7RpCBSIgH5Uar6Y42MdC/zeuzJiFtaSDN65sYK9POed6?=
 =?us-ascii?Q?xwBWM/zf287X7JWSYPZh4HtVMFYKvMD/JeNU2QkmYT3a4bzyFto99vzJbaEe?=
 =?us-ascii?Q?Y8Y60qzUXtW6lfSnazTpprSkNCBfjfIrDhfkauKPC/+iM9E90bhzFJz8sY2a?=
 =?us-ascii?Q?fqVrOnN0h9cRjcjP5ad84+glGBaJ91mkEDA5+mYywbXA3kIe7WPA694m+zCj?=
 =?us-ascii?Q?ZeAvwkI/l2DkM8wyxxY9hbIuu9pA2L2EaqrnLtrf5v31md4z6WUFHFpL+evF?=
 =?us-ascii?Q?AY+wLcIMzzNi/fvQ+152dK+yv8/zNMgBBIQaMRCdpMNbxtGTCaBNpM1Lr7dz?=
 =?us-ascii?Q?7iuNy4eiwt3v5UQALtYa/mLb3Xm3Hgtfv1SqLw4ybKKczbrdzYjdfiawaZDI?=
 =?us-ascii?Q?zU2ccUpqRHwUUMmyLmnfQsZ0g/hhbJ5CwQpWOyf47g1OqWiEflB0/aZCKgDG?=
 =?us-ascii?Q?lbWdN0zHO07Hfpr8TCRuiyPh7jmfyT6LIoSMlBlovEbk6fnbKj2ytU/fgva9?=
 =?us-ascii?Q?i86NSbqdN6oMMKi0j3CN+xF40GSYzYTQk87M4vfPMHyQ1tCYMVt9G1PzTE/a?=
 =?us-ascii?Q?jMIc2el3/Qv2q9RoqucvHh6fK2ca/NFJW0d2Hlu8JBM5T97yR7jxi+VgdFo8?=
 =?us-ascii?Q?U/PZJVH8szhXCsZ0/XoixHcxgGxCXiWTL0WcXce60PiX0GLrAbWs9EeA64XN?=
 =?us-ascii?Q?7JXUTY14LiYyXROSsU5y1Uiy2eG9IDSmdkfEh+wFolLaQcDLK1vGrnDpBTYo?=
 =?us-ascii?Q?4a1eB95FBw/gOTMHEcQkgxjJC45VAUVcC/umG0T4bWzH90u+K8FftBzjnHN/?=
 =?us-ascii?Q?db3hVjp6KZqYU66l0vm5yRszGdIbVnMQe0XvsKGPnORmksFfqctDTEV57z4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 716d6c01-3ffa-407c-8fd8-08ddff818a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 17:56:38.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9897

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Septe=
mber 26, 2025 9:23 AM
>=20
> From: Jinank Jain <jinankjain@linux.microsoft.com>
>=20
> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
> allocated and passed to the hypervisor to map VP state pages. This is
> only needed on L1VH, and only on some (newer) versions of the
> hypervisor, hence the need to check vmm_capabilities.
>=20
> Introduce functions hv_map/unmap_vp_state_page() to handle the
> allocation and freeing.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_root.h         | 11 ++---
>  drivers/hv/mshv_root_hv_call.c | 61 ++++++++++++++++++++++++---
>  drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++-----------------
>  3 files changed, 98 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 0cb1e2589fe1..dbe2d1d0b22f 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 partitio=
n_id,
>  			 /* Choose between pages and bytes */
>  			 struct hv_vp_state_data state_data, u64 page_count,
>  			 struct page **pages, u32 num_bytes, u8 *bytes);
> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -			      union hv_input_vtl input_vtl,
> -			      struct page **state_page);
> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type=
,
> -				union hv_input_vtl input_vtl);
> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			 union hv_input_vtl input_vtl,
> +			 struct page **state_page);
> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			   struct page *state_page,
> +			   union hv_input_vtl input_vtl);
>  int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>  			u64 connection_partition_id, struct hv_port_info *port_info,
>  			u8 port_vtl, u8 min_connection_vtl, int node);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index 3fd3cce23f69..98c6278ff151 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_=
id,
>  	return ret;
>  }
>=20
> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -			      union hv_input_vtl input_vtl,
> -			      struct page **state_page)
> +static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32=
 type,
> +				     union hv_input_vtl input_vtl,
> +				     struct page **state_page)
>  {
>  	struct hv_input_map_vp_state_page *input;
>  	struct hv_output_map_vp_state_page *output;
> @@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 =
vp_index, u32 type,
>  		input->type =3D type;
>  		input->input_vtl =3D input_vtl;
>=20
> -		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);

This function must zero the input area before using it. Otherwise,
flags.map_location_provided is uninitialized when *state_page is NULL. It w=
ill
have whatever value was left by the previous user of hyperv_pcpu_input_arg,
potentially producing bizarre results. And there's a reserved field that wo=
n't be
set to zero.

> +		if (*state_page) {
> +			input->flags.map_location_provided =3D 1;
> +			input->requested_map_location =3D
> +				page_to_pfn(*state_page);

Technically, this should be page_to_hvpfn() since the PFN value is being se=
nt to
Hyper-V. I know root (and L1VH?) partitions must run with the same page siz=
e
as the Hyper-V host, but it's better to not leave code buried here that wil=
l blow
up if the "same page size requirement" should ever change.

And after making the hypercall, there's an invocation of pfn_to_page(), whi=
ch
should account for the same. Unfortunately, there's not an existing hvpfn_t=
o_page()
function.

> +		}
> +
> +		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input,
> +					 output);
>=20
>  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>  			if (hv_result_success(status))
> @@ -565,8 +572,39 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 =
vp_index, u32 type,
>  	return ret;
>  }
>=20
> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type=
,
> -				union hv_input_vtl input_vtl)
> +static bool mshv_use_overlay_gpfn(void)
> +{
> +	return hv_l1vh_partition() &&
> +	       mshv_root.vmm_caps.vmm_can_provide_overlay_gpfn;
> +}
> +
> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			 union hv_input_vtl input_vtl,
> +			 struct page **state_page)
> +{
> +	int ret =3D 0;
> +	struct page *allocated_page =3D NULL;
> +
> +	if (mshv_use_overlay_gpfn()) {
> +		allocated_page =3D alloc_page(GFP_KERNEL);
> +		if (!allocated_page)
> +			return -ENOMEM;
> +		*state_page =3D allocated_page;
> +	} else {
> +		*state_page =3D NULL;
> +	}
> +
> +	ret =3D hv_call_map_vp_state_page(partition_id, vp_index, type, input_v=
tl,
> +					state_page);
> +
> +	if (ret && allocated_page)
> +		__free_page(allocated_page);

For robustness, you might want to set *state_page =3D NULL here so the
caller doesn't have a reference to the page that has been freed. I didn't
see any cases where the caller incorrectly checks the returned
*state_page value after an error, so the current code isn't broken.

> +
> +	return ret;
> +}
> +
> +static int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u=
32 type,
> +				       union hv_input_vtl input_vtl)
>  {
>  	unsigned long flags;
>  	u64 status;
> @@ -590,6 +628,17 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u3=
2 vp_index, u32 type,
>  	return hv_result_to_errno(status);
>  }
>=20
> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +			   struct page *state_page, union hv_input_vtl input_vtl)
> +{
> +	int ret =3D hv_call_unmap_vp_state_page(partition_id, vp_index, type, i=
nput_vtl);
> +
> +	if (mshv_use_overlay_gpfn() && state_page)
> +		__free_page(state_page);
> +
> +	return ret;
> +}
> +
>  int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e,
>  				      u64 arg, void *property_value,
>  				      size_t property_value_sz)
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e199770ecdfa..2d0ad17acde6 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -890,7 +890,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition
> *partition,
>  {
>  	struct mshv_create_vp args;
>  	struct mshv_vp *vp;
> -	struct page *intercept_message_page, *register_page, *ghcb_page;
> +	struct page *intercept_msg_page, *register_page, *ghcb_page;
>  	void *stats_pages[2];
>  	long ret;
>=20
> @@ -908,28 +908,25 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> -					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> -					input_vtl_zero,
> -					&intercept_message_page);
> +	ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
> +				   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +				   input_vtl_zero, &intercept_msg_page);
>  	if (ret)
>  		goto destroy_vp;
>=20
>  	if (!mshv_partition_encrypted(partition)) {
> -		ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> -						HV_VP_STATE_PAGE_REGISTERS,
> -						input_vtl_zero,
> -						&register_page);
> +		ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
> +					   HV_VP_STATE_PAGE_REGISTERS,
> +					   input_vtl_zero, &register_page);
>  		if (ret)
>  			goto unmap_intercept_message_page;
>  	}
>=20
>  	if (mshv_partition_encrypted(partition) &&
>  	    is_ghcb_mapping_available()) {
> -		ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> -						HV_VP_STATE_PAGE_GHCB,
> -						input_vtl_normal,
> -						&ghcb_page);
> +		ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
> +					   HV_VP_STATE_PAGE_GHCB,
> +					   input_vtl_normal, &ghcb_page);
>  		if (ret)
>  			goto unmap_register_page;
>  	}
> @@ -960,7 +957,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition =
*partition,
>  	atomic64_set(&vp->run.vp_signaled_count, 0);
>=20
>  	vp->vp_index =3D args.vp_index;
> -	vp->vp_intercept_msg_page =3D page_to_virt(intercept_message_page);
> +	vp->vp_intercept_msg_page =3D page_to_virt(intercept_msg_page);
>  	if (!mshv_partition_encrypted(partition))
>  		vp->vp_register_page =3D page_to_virt(register_page);
>=20
> @@ -993,21 +990,19 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>  	if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
>  		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>  unmap_ghcb_page:
> -	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())=
 {
> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> -					    HV_VP_STATE_PAGE_GHCB,
> -					    input_vtl_normal);
> -	}
> +	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +				       HV_VP_STATE_PAGE_GHCB, ghcb_page,
> +				       input_vtl_normal);
>  unmap_register_page:
> -	if (!mshv_partition_encrypted(partition)) {
> -		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> -					    HV_VP_STATE_PAGE_REGISTERS,
> -					    input_vtl_zero);
> -	}
> +	if (!mshv_partition_encrypted(partition))
> +		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +				       HV_VP_STATE_PAGE_REGISTERS,
> +				       register_page, input_vtl_zero);
>  unmap_intercept_message_page:
> -	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> -				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> -				    input_vtl_zero);
> +	hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +			       HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +			       intercept_msg_page, input_vtl_zero);
>  destroy_vp:
>  	hv_call_delete_vp(partition->pt_id, args.vp_index);
>  	return ret;
> @@ -1748,24 +1743,27 @@ static void destroy_partition(struct mshv_partiti=
on *partition)
>  				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
>=20
>  			if (vp->vp_register_page) {
> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> -								  vp->vp_index,
> - 								  HV_VP_STATE_PAGE_REGISTERS,
> -								  input_vtl_zero);
> +				(void)hv_unmap_vp_state_page(partition->pt_id,
> +							     vp->vp_index,
> +							     HV_VP_STATE_PAGE_REGISTERS,
> +							     virt_to_page(vp->vp_register_page),
> +							     input_vtl_zero);
>  				vp->vp_register_page =3D NULL;
>  			}
>=20
> -			(void)hv_call_unmap_vp_state_page(partition->pt_id,
> -							  vp->vp_index,
> -							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> -							  input_vtl_zero);
> +			(void)hv_unmap_vp_state_page(partition->pt_id,
> +						     vp->vp_index,
> +						     HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +						     virt_to_page(vp->vp_intercept_msg_page),
> +						     input_vtl_zero);
>  			vp->vp_intercept_msg_page =3D NULL;
>=20
>  			if (vp->vp_ghcb_page) {
> -				(void)hv_call_unmap_vp_state_page(partition->pt_id,
> -								  vp->vp_index,
> -								  HV_VP_STATE_PAGE_GHCB,
> -								  input_vtl_normal);
> +				(void)hv_unmap_vp_state_page(partition->pt_id,
> +							     vp->vp_index,
> +							     HV_VP_STATE_PAGE_GHCB,
> +							     virt_to_page(vp->vp_ghcb_page),
> +							     input_vtl_normal);
>  				vp->vp_ghcb_page =3D NULL;
>  			}
>=20
> --
> 2.34.1
>=20


