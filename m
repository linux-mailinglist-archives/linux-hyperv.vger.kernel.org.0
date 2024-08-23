Return-Path: <linux-hyperv+bounces-2824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D5495D39E
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E39284AA5
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D742F18A6C7;
	Fri, 23 Aug 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ouJYmfLI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010019.outbound.protection.outlook.com [52.103.2.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497A185E7B;
	Fri, 23 Aug 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431048; cv=fail; b=qH+6r0CWFuF97vB/vgkyv0eSkACVcmpGZv9rwd2Wbjcm7qcbcd4i7K6vqwCMtSrhcOBtahm11/8b5cUnT4MbmanDVV7CvP1/XZuKDZiM/892xhmQtG4E1LFIPMApuLYEAqakZFMN5BdtquJMjmHisk77PCcYPUWQ0MUl6YC7cwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431048; c=relaxed/simple;
	bh=MWP0yqaxyhGLyquekPHDjDrgqmtJjbwa1LURlAUPB2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGxGu4IAjdRtUydDax6oJ64syzOILm+0c9WrHGkyMJOA+iwVLDeXnBQU+o3G5Almuc4AxljcH/xpjOHGCG2aYruV3/lrvuFJseULpHjpW+gXM+XqzZZMg0Nj4lyJjSS6habN8rq2l+XeZ9mwHxAWDu1V2gBkw7/ICa9Kb+Pm8KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ouJYmfLI; arc=fail smtp.client-ip=52.103.2.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4EDbxD/j+ObV4LMz8FJekJrN9zkvOLMY40yWARpx1zs5tF+4APMsjLQgVDPyGcFPqzN6u5C7DQiGs3mEkOdHpXRdt+MLWMaFSm1Pwsf3oRRjDYQHAwDRG5FNoF/lmL02c6aMurrjyXKAVhZ5JNfNCGvGOtBBhd0dauy5PvFwOV5fO3a3psIbEJp90Ei+4+3beJAxWlsPzmdITztBTsPiu0VfmNBg3GDAFuQgn0OZAGcAmjJOCUMAuv+zWzDWUO64pjVOxYwqE7YF17UQZ8kyvCGtfSlhwb9VqRwJ/Qk2bGZQF/EKr6rYcVTpknve1rs/pL383bkiwGJbouhRpI++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H5JkeEdkSvrLVnJmaY4Mb4lnHiIlv3GW5kHz2W/moY=;
 b=Qq4H7bJrah9JyqUYsAN3ve/k/ly9q1qxVwmTs0DJu36Yiafv5BVbxc/lgQa80PhPS2IYauUQJMlDhOIFgcaf8rzRpnRHuzFLU+xA9c2p4JK+oHCVAkbFvQBAeo3SexyxPNQonS5gWzURQIw2EGzvUkk0VCrqTbRrO3IpbQEJrEHaKiNt+xQckI8ouH+y/9e7gJSUZ4Wu00BY2rpFiENGgkMFGaX/6WzG/HTJgITwxq9kFO63K4CbCd+xvDVszFRMnfVPQMvvGOrbK3P245Sk4tUDSb838xBshPHb8/UsS0M/utOPyWbXKbZHCIw/s3K+/ImJE12yvmagoABxjLnyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H5JkeEdkSvrLVnJmaY4Mb4lnHiIlv3GW5kHz2W/moY=;
 b=ouJYmfLIC0U5nEb+ajiigxkSQHNNVWpgVnJptSEcSgZSOxK5b+WDnCOOJjLNH2ozpPkIO0AETtn7JSAhtz/yToduEetYipyTMiXUUYdiZ2zA5zKgPg/o+HJvc3hJGpFVTWcyH56c0MsJSLWfilxnP8W+w6lVJmyDYSbzNz+4XgyWDaJOSP4alY84RYmgIm8qi3Y+AatqkAipxmuXNBNI6XHsRRia9WXRhBRb1mQfwq9N9qq/4Bo2JGd4auqIGfRqWNCqap8pMqQ1fULGH1vyQW7V3nVuE02n1MrcyKwT+8JPB7KPKbC39EywhW50k1tCk1agtg98NZlzvyHvPttwOw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7747.namprd02.prod.outlook.com (2603:10b6:303:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:37:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Fri, 23 Aug 2024
 16:37:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "ernis@microsoft.com" <ernis@microsoft.com>
Subject: RE: [PATCH v3] net: netvsc: Update default VMBus channels
Thread-Topic: [PATCH v3] net: netvsc: Update default VMBus channels
Thread-Index: AQHa9KTvo39C2dg7aUWe6oSNngL4P7I1BxSg
Date: Fri, 23 Aug 2024 16:37:17 +0000
Message-ID:
 <SN6PR02MB415769AD9CC9B1C9398DCC6CD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1724339168-20913-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1724339168-20913-1-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [wKntug/duKgSvzr14Xw5b+boN2MyBdU8]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7747:EE_
x-ms-office365-filtering-correlation-id: e3044b23-5d5a-43c2-2a7e-08dcc391d9e8
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|15080799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 +FR33NXlQdRVKOSEI1kbrEsnLabukklCm7gUSCd6RrcnUS6cGFMONH7TOgnxpeI5T7YMT+Q9O4ws+CYNFX7AQU0ZR0/Xbm7hdmT6DGOa+lwtZMG6h59BA5nzuotCyuQrD4nsqZxKZFZBGpTgQlT0i0qPe9oQydbCssE9WrPst8z+TrFIr2vOLMH7DhyMUf275Sr6dSQZMFqyNCPrILn/SedDzhzsxs08hXJ/R/RBaNv6J/U6fLamKfR7bjQBwnRoL16vMGUui/KDoEAzsmfwsj7MuKPorrdqNb9p0wgebNZyl2bAwBh9zG1TAibNTHRlOWmkrKAeTzWFBgpNU6TEvqFYsZgLbPhb3bVU3/Yin5cDJCi29nmsazH2QViYOKN1IhIOGUQqPF5yuarEwb+aaMBEvJRlTjSStcd9oIvBXTjD3H6zsK12EN/A15P2hQHAP6cUSRrdCPloWDPyBJ9EnCdHoX9h4hjqUuClFc3W9GfEpJKBikE6AHaK+ceJwl9Y0Ct+KY7CmccL1SWjYJ0GaxnWCP81Ds/9vrXOf+qU8AuGlbYq80K2fhK0CawdV1qZWAuJswuI0SnjLaL1EJnGfWKVgLvqlk4fVfi6FINDgn2av3znwO/XS7oK/yTCsXm4E07fpK5lOGEUjI3/THdJPBiqIZ/rayxXqC6y8pzCGFBBAM4E6TD/+i3vH8hbRLN2
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZGSqwtjxrFnU1cVvGFwFq0bN0uRriCUXbBpgujaToBSCvL9wjVIeQuYTtASW?=
 =?us-ascii?Q?9QM2ZtDU0lPRWTdq+wiWxlM/q5EKBlhhzck1M5tet/X1cpVbftiqZ6s8cItt?=
 =?us-ascii?Q?FgFxHbIuWm7rTxPTwo/BIXOUq/Vjs07Jlopbd26nkBDroakjBXwcetX4fnwV?=
 =?us-ascii?Q?vpaFdo8TUtF+ltZxONXetkbnmfF+vPSZcUwU9ZV7UqWtGsiIiaYK/SWiXfsX?=
 =?us-ascii?Q?ODV8i1hTTOZV/k4/Wa91lJlZ+RflgiJHV6aXN+QdQtB+K2fU67kYlG7qOCAr?=
 =?us-ascii?Q?PIGcLt7w7MFugotLjT4aF1o7T0VPo+Z+AEZlRQoK0Qr8S658800CqkaSZ4Qh?=
 =?us-ascii?Q?t2HNZW6kDnKOm+GDARHKGG4BMzBhok+ZzhQ1cSfAyoWzDV4ZWO5q9auDToXx?=
 =?us-ascii?Q?SZqOSLp6EwTbSCPwqv3lRQCMpnNKwVWrOjUq7DoSUKZhA9S1KTVsEnyGXtZ6?=
 =?us-ascii?Q?mz3REjIr+JIZHZvkZeekFtYRx+6mQYOBHqH+YSCMa975jDSYZUspz1oZiBtj?=
 =?us-ascii?Q?QNvzaAawKmLj6x/6i17k4+DQ5jE7U4ANstWqxHwyQ+6G1cDJbe5pT/OkJ8zU?=
 =?us-ascii?Q?8Ld8dX2/aOV3NM6JJ7CGPgHI8w3zmXNXwUTerHCadqemc8VO1+Mv6U8uQz+8?=
 =?us-ascii?Q?p7wY76QOqT8ZPMc1gKsrAQk3Xf7zx/NrxjvGZVy0Y1y658j2tYtBixZ6RMnp?=
 =?us-ascii?Q?mEh1I5LUv+lOBFIApTF/WgKZ5tHRYJhchoZaTwxYp5whjO1zNGYeQE7ZKv13?=
 =?us-ascii?Q?NgWs5bA72j+X1eiz/OELFY/dVsA2I/lFRPHsMzaI41i7f/wqZuZDhmOaFxdb?=
 =?us-ascii?Q?9yGDwv/OgLky6v1b7D/0TuPHczXtbVQ+qozNC2zVyLqff+R2zYjA+/fAfnvY?=
 =?us-ascii?Q?L7jO06mRXPFm8bFLHxmr/RMHxHzYNT3IVrxZryuQ1o/O6cjPeXhiTocVw4oy?=
 =?us-ascii?Q?ohlTtE/02gBc04Mf2SgKClnoCs0XEdvO4J2o7BDVOadvkpyw6xqbOBxILRmP?=
 =?us-ascii?Q?s8p9tNjKLrHTwTY1E4FC3us0bBKN/0dHKzWuU5aJ8QxjVEmzAznA1aNWCN5d?=
 =?us-ascii?Q?KXwb6//fwVaNJfsTTJyJQ+R3kmNhG5te/+mCXCaaRMIQC/UNJwUTGSt/B+3x?=
 =?us-ascii?Q?97lfFMoYQJ4fyjTYTk+7SI7hrrzF4v8BGEnybQURdi5LZ0jS3xHYZub34pF8?=
 =?us-ascii?Q?3kfpO20ZjNiDWwIlkgI91dICbPwuVgPFUDQ00nkbBhfeJiDcVOreG0vqwmE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3044b23-5d5a-43c2-2a7e-08dcc391d9e8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 16:37:17.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7747

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Thursday, Au=
gust 22, 2024 8:06 AM
>=20
> Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> Linux netvsc from 8 to 16 to align with Azure Windows VM
> and improve networking throughput.
>=20
> For VMs having less than 16 vCPUS, the channels depend
> on number of vCPUs. Between 16 to 64 vCPUs, the channels
> default to VRSS_CHANNEL_DEFAULT. For greater than 64 vCPUs,
> set the channels to number of physical cores / 2 returned by
> netif_get_num_default_rss_queues() as a way to optimize CPU
> resource utilization and scale for high-end processors with
> many cores. Due to hyper-threading, the number of
> physical cores =3D vCPUs/2.

But note that a given physical processor may or may not support
hyper-threading. For example, the physical processor used for
ARM64 VMs in Azure does not have hyper-threading. And even
if the physical processor supports hyper-threading, the VM might
not see hyper-threading as enabled. Many Azure GPU-based VM
sizes see only full cores, with no hyper-threading. It's also possible
to boot Linux with hyper-threading disabled even if the VM sees
hyper-threaded cores (the "nosmt" or "smt=3D1" kernel boot option).

Your code below probably isn't affected when hyper-threading
isn't present. But in the interest of accuracy, the discussion here
in the commit message should qualify the use of "vCPU/4" as
the number of channels. It might be "vCPU/2" when
hyper-threading isn't present or is disabled, and for vCPU
counts between 16 and 64, you'll get more than 16 channels.

> Maximum number of channels are by default set to 64.
>=20
> Based on this change the channel creation would change as follows:
>=20
> -------------------------------------------------------------
> | No. of vCPU	|  dev_info->num_chn	| channels created  |
> -------------------------------------------------------------
> |  0-16		|       16		|       vCPU        |

Nit: Presumably we won't ever have 0 vCPUs.  :-)

> | >16 & <=3D64	|       16		|       16          |
> | >64 & <=3D256	|       vCPU/4		|       vCPU/4      |
> | >256		|       vCPU/4		|       64          |
> -------------------------------------------------------------
>=20
> Performance tests showed significant improvement in throughput:
> - 0.54% for 16 vCPUs
> - 0.83% for 32 vCPUs
> - 0.86% for 48 vCPUs
> - 9.72% for 64 vCPUs
> - 13.57% for 96 vCPUs
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> Changes in v3:
> * Use netif_get_num_default_rss_queues() to set channels
> * Change terminology for channels in commit message
> ---
> Changes in v2:
> * Set dev_info->num_chn based on vCPU count.
> ---
>  drivers/net/hyperv/hyperv_net.h | 2 +-
>  drivers/net/hyperv/netvsc_drv.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_=
net.h
> index 810977952f95..e690b95b1bbb 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -882,7 +882,7 @@ struct nvsp_message {
>=20
>  #define VRSS_SEND_TAB_SIZE 16  /* must be power of 2 */
>  #define VRSS_CHANNEL_MAX 64
> -#define VRSS_CHANNEL_DEFAULT 8
> +#define VRSS_CHANNEL_DEFAULT 16
>=20
>  #define RNDIS_MAX_PKT_DEFAULT 8
>  #define RNDIS_PKT_ALIGN_DEFAULT 8
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index 44142245343d..a6482afe4217 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -987,7 +987,8 @@ struct netvsc_device_info *netvsc_devinfo_get(struct =
netvsc_device *nvdev)
>  			dev_info->bprog =3D prog;
>  		}
>  	} else {
> -		dev_info->num_chn =3D VRSS_CHANNEL_DEFAULT;
> +		dev_info->num_chn =3D max(VRSS_CHANNEL_DEFAULT,
> +					netif_get_num_default_rss_queues());
>  		dev_info->send_sections =3D NETVSC_DEFAULT_TX;
>  		dev_info->send_section_size =3D NETVSC_SEND_SECTION_SIZE;
>  		dev_info->recv_sections =3D NETVSC_DEFAULT_RX;
> --
> 2.34.1
>=20


