Return-Path: <linux-hyperv+bounces-7015-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BCBAA3DB
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 19:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007B316A972
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CAE21D5AF;
	Mon, 29 Sep 2025 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="USg4wdET"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013040.outbound.protection.outlook.com [52.103.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA133086;
	Mon, 29 Sep 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168644; cv=fail; b=PE4Gn5xAZA9OU33SqaJl9fJ/czmerrMpi9aGx5f/qYDw0QTK9YhbLwKyB3jNZG0yqrTNpEVOunLzlwKlTPq95RpcyyAjgHxduKQ2W5QwliSN0J+rvpljUUXLDSzzRYHW/pE2oxEo00I4/L8Lx+zWxFb5HwQ28MwEBHzfKPZ/hpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168644; c=relaxed/simple;
	bh=ywKNJWHPX7iU1roJlN7ENJhKlyLeElBa4xyYeAImKGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XzBhpSNIhsDRNdqPGEe/XKAusMp8q+vqb4+oXRTMF5KKOY2mdLmGUHOzB8LW2fjHSTJm0WnKchhv/iyBkFwAct6sfXFEuk+TJRnP6eXozhh0x9UIct1TWO+a3nhOiiyCZOYlcCTdlQWriivLkpwsF9mn40t3YjG45G3ZIAKq0Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=USg4wdET; arc=fail smtp.client-ip=52.103.14.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4GqHmTxcXDHuVjA1/qJXeJo6o4zQZenMmW0iOGVz+4cW3viROnb894eZSZ+pmoea86Py77HiTHzyMPg84oMuusKcBzB4cu1d5x8E+o3+ghOrMX3zsOnPtGRWP+Ocn04xKl/8T9DsW2lDk1H3xkrhM9rVtQtypJIiG48m0hUcPNSolCed6pyrl5nkD3aocj0ZdfIiLDiIr3FmxrL3yDUJKyKchkz+zecL0Nc3VixX7cl/Fazwky/UtD2jwzt7WPHn7lwLUWzYLIF/+t5+2ZZowDlGIiiARkIf7I5JZ2/7HZ5kAUoTruyFtzPp18NwGBUEhI4XpwO9cEEfa3CqWFCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfRFcqSakbHnBdi8/1oGbQY0K3aVYAOzUSF/R1WnnjE=;
 b=RRxOpC8wkxXStHeli4qeoA5KhqWCUqeg1ocHRRoM8WxN4Cbxfc8hJFKwD6mNrZw4joIilVodwCvRLLyVm84KOdAOdJ3FC3IBvwB4W17Ts3TL9Ru9eXvCklxrS6WraqiolOwCmQUj7pTxVl3Qe/QLa1wgkaagUUIfGiXPgGo9mjPApx0hhNUcYBgssBwcSAhQB+X3WTzNxV3AlFJhVvvdCfXc+Pkxt9m5jdErJyBFHIdjyroIpma3dwleqYZLGqws5Ig4gmiwe8dlPvjNojMP6zDQk+3PJBVhX8TaKNWEFGlbZrpjz7KLEkXp+6wusX8FqYqSPx16ogV6v6vQs/Cb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfRFcqSakbHnBdi8/1oGbQY0K3aVYAOzUSF/R1WnnjE=;
 b=USg4wdET8Iyka+g2v5XEOgy9W/FpApbplLuUftwYNJ4V9X+KqOo9mlFTtWlo8kyDdC5HLheMVgLhPEUU7BBzsGPxUR0TB5ib0C/TMsxIj9kh86gzXivgavOFVdEuqZYtgwViu68LSdbtez56kJUC6V/oib01knHxKQ8/c+JOLb3rmZo9xs79ND3TikN+wy/X+xJjNgxntdiCmj1zneCpVMMiwgCXKUTQf97WqMK992vO6cOsLBoaUfzLJND7zrYu7dovQGSEPdwB8LK1brKfDGO0EMAfeXYWfFNlgcrSLYb6kYximbRB9jZrFWVzVDvIuwQBG0BOAEsQINsgpt4bqQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9897.namprd02.prod.outlook.com (2603:10b6:208:489::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 17:57:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 17:57:18 +0000
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
Subject: RE: [PATCH v4 5/5] mshv: Introduce new hypercall to map stats page
 for L1VH partitions
Thread-Topic: [PATCH v4 5/5] mshv: Introduce new hypercall to map stats page
 for L1VH partitions
Thread-Index: AQHcLwIHG1YIGU2MWk2ynUAG26qFG7SqbO+w
Date: Mon, 29 Sep 2025 17:57:18 +0000
Message-ID:
 <SN6PR02MB41571CB74AAAB29181443EE9D41BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-6-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1758903795-18636-6-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9897:EE_
x-ms-office365-filtering-correlation-id: 4104e688-dd23-4342-c011-08ddff81a1eb
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|19110799012|13091999003|41001999006|15080799012|12121999013|8062599012|8060799015|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vTflqqqKVOSHfhD4RMQfTnerTfdjsJ4iq9a5FrtmCUmb9R20k/Xf0EMiHc0K?=
 =?us-ascii?Q?rSp5gkYu2w+j5QSQLOm1iXiccXFWh3p1x3aKXpXUpzvRpPN0np0kQVlAGCXj?=
 =?us-ascii?Q?k942HNhJ63RfgnBS+tPKnRCKx79wUlfyp8kjNWYF4EWqm/bnIlZXwLHoXwEX?=
 =?us-ascii?Q?nl09pDidW9kcy26M+gRjSQ71cS3Nbi63mMMr1kRFiYje4ixit6vBFMJW4XHn?=
 =?us-ascii?Q?WevyRn9PJz2X0Vgp9QmjjY01Z6Z/uhs7gzm3ZBFctQ0JEPt2uAHkgsl7Mj41?=
 =?us-ascii?Q?IUA7tskcjoArFSL8SuYAc4Db5l4vxYHGJSECJT/babHfdtJv0WC3hAFWxyMo?=
 =?us-ascii?Q?IlxIpDHGRW2X22a8dVm6QT5Xpi2rdGbdpw0awlWreditV6T1YHfXCozlPgG+?=
 =?us-ascii?Q?m9iLs8qfsA7LUudTi/0dSt5WX1aKdCqstKmFj5CMB4l6qaJuzm3vL9i6DVIH?=
 =?us-ascii?Q?ykLJuKVUBrVnaexme3ZxUB7ChZLN+buqYnjYv2pcEcac89ptKltny1bXZ8x/?=
 =?us-ascii?Q?TKPnqtbBYV/xs02ltHRiQfqCobH96oU7p22EYKgu2yWHs3R14qvcebIv8gDW?=
 =?us-ascii?Q?EThO6Po/vstpxp3rT8M5Pxd0W3iecbso1BsL36jXbBZO9qZFY/tyUOqAZ955?=
 =?us-ascii?Q?0rGuF8sfd7tO2skBC8fj0jbqyqnEKoy9devbE8yGplXGYylFvYPv+ngJRJcu?=
 =?us-ascii?Q?0RYlATwNLFpe8bO0Y1NNIOg7Y1rIXYCfT96FvqVnm+f1hYkvqAiFoZy1L//H?=
 =?us-ascii?Q?WkEZo+NQEJO3ma3wx89R1RGhE4OgqCgYVPiO3oLB5ZGVohuMq3V62RvyJVou?=
 =?us-ascii?Q?s5kqSmt6BoY22w7HaqEIv73VSjOwWviZHGu/3kNGZc+03BUz2Xj5TfaKoWf6?=
 =?us-ascii?Q?GSaV6ldJQwjnUx9/ASrpaenFX+3mGIwGpCVHbBM4gd6PTZlshaGunj+RjWqs?=
 =?us-ascii?Q?ZR6/fPpPbFMbNgik+5jUsR5rvcbftqWdB5c4uIi4sdQrZrmQ0lx3eFTMPAdr?=
 =?us-ascii?Q?NBgvVMcoYU1CSEdFFz6CNeGEUwJ7IjC/vq08/m4VcaZOhWpiqIgtnsAFak4W?=
 =?us-ascii?Q?iz0Ilcv6+uEqwhq1QlJ2tftCUY53zGuwRdusOFgwvThHFf6Pa7jPOmF5lN0v?=
 =?us-ascii?Q?LNy/mr1bZcDyIkbYJXtNQFscOgNygTPQhY3Fx4tQ5PYfqohG533D/gYj8LqZ?=
 =?us-ascii?Q?oJBVMow0UEgF+7iEbt3x7JmXqrfLHAYuBpwF9lPWB7J0Ms1nUkeyYQrG82/f?=
 =?us-ascii?Q?qSVnvEsyjagHxApsCJl3WMGmTceQeaFNQjKYCWMirA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JMt05eWXJPj6eQ6bsI6WDZhG23nL3znzj0U0lZjk+9HOzBDZ2yPbJLZLLXl0?=
 =?us-ascii?Q?1gYwoXnLziXULnLbZBC5Dx/SAQS7K1gaoxNy5Un1r3BnLt+G4KtCbXzg4Yfo?=
 =?us-ascii?Q?cV9P00aDG1kSlWZytXpasKg2qbXliK2s51hMX2iG2UCLoDpAwVPxQJ0E7NfD?=
 =?us-ascii?Q?l8Ewojt6tsnXw5mWbDdRiNqdhk16CoRBVGaFdZp1zFGPB6LM9I4Mi4UXB92T?=
 =?us-ascii?Q?rrjXH8eYr6VpfUGZsVRNptAxwVhuvDx2IplsPGN1T9p3VngVF4W9+JhaqNEi?=
 =?us-ascii?Q?tZIr4dQCXzbO/qFGHzDZCe6oJhxlPlPY26tQUCCYQNgxt+ZbayNM8j5StOkE?=
 =?us-ascii?Q?WK9u2efaIcbUo9RM7Srn96LO82ZYfL4vd5BbYqvIneATtCoXUDoFJerUJpLd?=
 =?us-ascii?Q?Rcb/jl0vC6OLTNZBvFD/5TROOxOqJsfOk/R0u5CeaGf8O7b2za9tjEtiqPtb?=
 =?us-ascii?Q?sp6B8t5Ck4sgQEE3rKjIJw869neNegdkxJbGFd+CbP7hDPWxddeBfXlw9kBu?=
 =?us-ascii?Q?IP9yblrqhWelQxK/Mim+dwGYZ1McElNV4BZcMoSraIwnzaOYNPxEOdlWt6VO?=
 =?us-ascii?Q?ZU+AmP60iN59ZWxytizzaSYJU1Fj1XlxEX74Tb2bvk6rh9CN/0T7SjxrDhEV?=
 =?us-ascii?Q?GoA9TxtSOaNudwGOE5M6ev4PHm9pCkq3yebyV1Q4bAyGIFT7mg6IjAg+Dx1u?=
 =?us-ascii?Q?po+j+dq7/aBG0iSwpk+US55skSyJZlC9TKwrfwwEFLR0d64YUbQ7O6OpAAar?=
 =?us-ascii?Q?oloZTuT52W6+2q4m3V4RAtea/dQRq5Uy8P0x9vodxCJuFyyhnr9DbWqQx8gi?=
 =?us-ascii?Q?y6MPV/x1iRPNzMrX4FLANM7zabdbKX2nozgx3ylTfYnmj+6v5y0yvflL85F3?=
 =?us-ascii?Q?AtiJ+jG7aFx+2k85AsrPzHPQrdecMUTwF37JZhX1f/rPVwoKbF5KfmoOUsKq?=
 =?us-ascii?Q?4+ErfHlMH/jHooio3HEroJP+53PRY6NCs6618QMHQbatyqEKKcvLqo2jScel?=
 =?us-ascii?Q?cwWOzqwT3HJwCKo5yLwDaUeQdMqzpVxbeHSVqN5q2nRqOW8nJYPxkcNK4RFq?=
 =?us-ascii?Q?JHMELf478Yo374/SjTipOIOBjZxdQu/9Z7LJVWzeQEBoWj6pSra7R+zp7zWf?=
 =?us-ascii?Q?IdvvooY3MAtIF0heoSr50xVvCsBg7q8/BvPwaIEQ0ISuz78ldSRL9CHNf1p4?=
 =?us-ascii?Q?QOk9tBq/l6hk6IYn8Ti2Pay0Z81ZcDXAtACIkkgZSQ5HMOeuMqPKpuB1K8Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4104e688-dd23-4342-c011-08ddff81a1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 17:57:18.8843
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
> Introduce HVCALL_MAP_STATS_PAGE2 which provides a map location (GPFN)
> to map the stats to. This hypercall is required for L1VH partitions,
> depending on the hypervisor version. This uses the same check as the
> state page map location; mshv_use_overlay_gpfn().
>=20
> Add mshv_map_vp_state_page() helpers to use this new hypercall or the
> old one depending on availability.
>=20
> For unmapping, the original HVCALL_UNMAP_STATS_PAGE works for both
> cases.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         | 10 ++--
>  drivers/hv/mshv_root_hv_call.c | 93 ++++++++++++++++++++++++++++++++--
>  drivers/hv/mshv_root_main.c    | 22 ++++----
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk_mini.h    |  7 +++
>  5 files changed, 113 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index dbe2d1d0b22f..0dfccfbe6123 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -297,11 +297,11 @@ int hv_call_connect_port(u64 port_partition_id, uni=
on hv_port_id port_id,
>  int hv_call_disconnect_port(u64 connection_partition_id,
>  			    union hv_connection_id connection_id);
>  int hv_call_notify_port_ring_empty(u32 sint_index);
> -int hv_call_map_stat_page(enum hv_stats_object_type type,
> -			  const union hv_stats_object_identity *identity,
> -			  void **addr);
> -int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> -			    const union hv_stats_object_identity *identity);
> +int hv_map_stats_page(enum hv_stats_object_type type,
> +		      const union hv_stats_object_identity *identity,
> +		      void **addr);
> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
> +			const union hv_stats_object_identity *identity);
>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
>  				   u64 page_struct_count, u32 host_access,
>  				   u32 flags, u8 acquire);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index 98c6278ff151..5a805b3dec0b 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -804,9 +804,51 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>  	return hv_result_to_errno(status);
>  }
>=20
> -int hv_call_map_stat_page(enum hv_stats_object_type type,
> -			  const union hv_stats_object_identity *identity,
> -			  void **addr)
> +static int hv_call_map_stats_page2(enum hv_stats_object_type type,
> +				   const union hv_stats_object_identity *identity,
> +				   u64 map_location)
> +{
> +	unsigned long flags;
> +	struct hv_input_map_stats_page2 *input;
> +	u64 status;
> +	int ret;
> +
> +	if (!map_location || !mshv_use_overlay_gpfn())
> +		return -EINVAL;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		memset(input, 0, sizeof(*input));
> +		input->type =3D type;
> +		input->identity =3D *identity;
> +		input->map_location =3D map_location;
> +
> +		status =3D hv_do_hypercall(HVCALL_MAP_STATS_PAGE2, input, NULL);
> +
> +		local_irq_restore(flags);
> +
> +		ret =3D hv_result_to_errno(status);
> +
> +		if (!ret)
> +			break;

This logic is incorrect. If the hypercall returns=20
HV_STATUS_INSUFFICIENT_MEMORY, then errno -ENOMEM is immediately
returned to the caller without any opportunity to do hv_call_deposit_pages(=
).

> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			hv_status_debug(status, "\n");
> +			break;
> +		}
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    hv_current_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +static int hv_call_map_stats_page(enum hv_stats_object_type type,
> +				  const union hv_stats_object_identity *identity,
> +				  void **addr)
>  {
>  	unsigned long flags;
>  	struct hv_input_map_stats_page *input;
> @@ -845,8 +887,36 @@ int hv_call_map_stat_page(enum hv_stats_object_type =
type,
>  	return ret;
>  }
>=20
> -int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> -			    const union hv_stats_object_identity *identity)
> +int hv_map_stats_page(enum hv_stats_object_type type,
> +		      const union hv_stats_object_identity *identity,
> +		      void **addr)
> +{
> +	int ret;
> +	struct page *allocated_page =3D NULL;
> +
> +	if (!addr)
> +		return -EINVAL;
> +
> +	if (mshv_use_overlay_gpfn()) {
> +		allocated_page =3D alloc_page(GFP_KERNEL);
> +		if (!allocated_page)
> +			return -ENOMEM;
> +
> +		ret =3D hv_call_map_stats_page2(type, identity,
> +					      page_to_pfn(allocated_page));

This should use page_to_hvpfn() per my comments in Patch 4 of this series.

> +		*addr =3D page_address(allocated_page);
> +	} else {
> +		ret =3D hv_call_map_stats_page(type, identity, addr);
> +	}
> +
> +	if (ret && allocated_page)
> +		__free_page(allocated_page);

Might want to do *addr =3D NULL after freeing the page so that the caller
can't erroneously reference the free page. Again, the current caller doesn'=
t
do that, so current code isn't broken.

> +
> +	return ret;
> +}
> +
> +static int hv_call_unmap_stats_page(enum hv_stats_object_type type,
> +				    const union hv_stats_object_identity *identity)
>  {
>  	unsigned long flags;
>  	struct hv_input_unmap_stats_page *input;
> @@ -865,6 +935,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_typ=
e type,
>  	return hv_result_to_errno(status);
>  }
>=20
> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
> +			const union hv_stats_object_identity *identity)
> +{
> +	int ret;
> +
> +	ret =3D hv_call_unmap_stats_page(type, identity);
> +
> +	if (mshv_use_overlay_gpfn() && page_addr)
> +		__free_page(virt_to_page(page_addr));
> +
> +	return ret;
> +}
> +
>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
>  				   u64 page_struct_count, u32 host_access,
>  				   u32 flags, u8 acquire)
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 2d0ad17acde6..71a8ab5db3b8 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -841,7 +841,8 @@ mshv_vp_release(struct inode *inode, struct file *fil=
p)
>  	return 0;
>  }
>=20
> -static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
> +static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index,
> +				void *stats_pages[])
>  {
>  	union hv_stats_object_identity identity =3D {
>  		.vp.partition_id =3D partition_id,
> @@ -849,10 +850,10 @@ static void mshv_vp_stats_unmap(u64 partition_id, u=
32 vp_index)
>  	};
>=20
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>=20
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>  }
>=20
>  static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
> @@ -865,14 +866,14 @@ static int mshv_vp_stats_map(u64 partition_id, u32 =
vp_index,
>  	int err;
>=20
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> -	err =3D hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
> -				    &stats_pages[HV_STATS_AREA_SELF]);
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
> +				&stats_pages[HV_STATS_AREA_SELF]);
>  	if (err)
>  		return err;
>=20
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_PARENT;
> -	err =3D hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
> -				    &stats_pages[HV_STATS_AREA_PARENT]);
> +	err =3D hv_map_stats_page(HV_STATS_OBJECT_VP, &identity,
> +				&stats_pages[HV_STATS_AREA_PARENT]);
>  	if (err)
>  		goto unmap_self;
>=20
> @@ -880,7 +881,7 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp=
_index,
>=20
>  unmap_self:
>  	identity.vp.stats_area_type =3D HV_STATS_AREA_SELF;
> -	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
> +	hv_unmap_stats_page(HV_STATS_OBJECT_VP, NULL, &identity);
>  	return err;
>  }
>=20
> @@ -988,7 +989,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition =
*partition,
>  	kfree(vp);
>  unmap_stats_pages:
>  	if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> -		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
> +		mshv_vp_stats_unmap(partition->pt_id, args.vp_index, stats_pages);
>  unmap_ghcb_page:
>  	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
>  		hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> @@ -1740,7 +1741,8 @@ static void destroy_partition(struct mshv_partition=
 *partition)
>  				continue;
>=20
>  			if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> -				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
> +				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index,
> +						    (void **)vp->vp_stats_pages);
>=20
>  			if (vp->vp_register_page) {
>  				(void)hv_unmap_vp_state_page(partition->pt_id,
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index ff4325fb623a..f66565106d21 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -493,6 +493,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_PARTITION_PROPERTY_EX		0x0101
>  #define HVCALL_MMIO_READ				0x0106
>  #define HVCALL_MMIO_WRITE				0x0107
> +#define HVCALL_MAP_STATS_PAGE2				0x0131
>=20
>  /* HV_HYPERCALL_INPUT */
>  #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index bf2ce27dfcc5..064bf735cab6 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -177,6 +177,13 @@ struct hv_input_map_stats_page {
>  	union hv_stats_object_identity identity;
>  } __packed;
>=20
> +struct hv_input_map_stats_page2 {
> +	u32 type; /* enum hv_stats_object_type */
> +	u32 padding;
> +	union hv_stats_object_identity identity;
> +	u64 map_location;
> +} __packed;
> +
>  struct hv_output_map_stats_page {
>  	u64 map_location;
>  } __packed;
> --
> 2.34.1
>=20


