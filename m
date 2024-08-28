Return-Path: <linux-hyperv+bounces-2900-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CB962B4C
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 17:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F91F1C21695
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA716188CD3;
	Wed, 28 Aug 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lql1IU7E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010017.outbound.protection.outlook.com [52.103.2.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05D1A0B08;
	Wed, 28 Aug 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857704; cv=fail; b=YICrQDhEEi4m7vgfsm4avGAP4evIH12hMUUceG64ImXrqy00K1HZQWxhmPfNXYy25kORPpZlrciuGnyhTYsh9riazsAk3zq6BdffTrcUQftKOn/VpJRRmCg9/D1+nMCwXVqkdOH04SqNTooEMdtA/fRvUFlg4ZuBlEysyS9U5Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857704; c=relaxed/simple;
	bh=70kS9eIoQ/QnRKGCcY95bLsYbQW3bVLRefXgV3rCFow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YiBQKhfD1XRaXNQfzMt4iYupkPe+kROQud9h0d1+qIP9eAa0ARKtO788n/apXdDxtq+Fd5ZpTeBFpODCkLkVfzqNI6GuRQPL/Yb4hspjOaENz44Po4SoU/uN2C2Yx/UzW5bOSuB3Z0akRDjLy2Qj3otClPqMGT8C1xywuXINpWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lql1IU7E; arc=fail smtp.client-ip=52.103.2.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2SaMfNs9nCm1DOA3wWwZGmmVhkIoL/0d0EuT0XdkNVD92VLHnKUgXDRZxdAXp5FnhkPmIG9jSoM/DT7MDwXQSXwpd94GKO2Ijg8jeOcpgTci6VUEeF23Nv5vM543W0LGnw89i+hiirZZ2I62szC1jvCp8nvhPzAUGo3XSpCWd6QsGPmq0QXf99XPFAmrxfDmeXh/wOfbzc+ITKwsBXvAuu82NAHCiyGQPUniv9apOTBoFPP/2O8JWYBltYrXYH4faT+JjrRpmPdjY31QxrSVMGJiDabmBH7eAe+JbPhWKU+y9J0hRfwXZ8jA+4OEPPfcfVUMPyRLGPV5VoSuHVfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoSBeXJ2SorjUiSYs3wq2YeXv2hvHp9Lg5ZcR8z7JX4=;
 b=vGsIy5gJ3/0XOgurXQgnINuk7W41QIMH0Bm19wV8hLLz8rkNZ05ckbZHoqb62u4in/ZRdzL5xVWSSFrLn9OXep6ONS860QgSvnAOWjLd0jK3jAvo//rDHUWGDlMuaT0lOxL4qS+d/IicEK13iipueXHqDQTY6QI58X5B5eBRlxvfool9mfJJIr5MZXa8CIGtBRcMYwUdMhsiIgx8fBKh0+Zl8pP/TNkfFBoWXVXO1+8YH8WeqhuafL2fkXy6oaFeGv/I+DVaezbHyJ5n2zr4O6UXel89kre5KgIHmvVpzSXwZKu/2hVCOK/7FUgZ/z/5c9wBO8mEBkOlHOm4TT5k7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoSBeXJ2SorjUiSYs3wq2YeXv2hvHp9Lg5ZcR8z7JX4=;
 b=Lql1IU7EAscBYx62wCLSVw4jWYZsn0aHlBmQsgL96bhGZQeecCZN5xlyQj0ZcJro9ktMNttUh8TQwytA0j3SojclcRgTPHuIFamwZZVWz5GcuMaIxPsovwiHHbv0DOaGCa4Be/lBoGYLQmm1lAtkDB9nU8sH6GCALVq3mglUAAJZHT0X8aPv2fD9eF7WNchFVYJV2u7czHEyA4fTR3Zf50ilJSrEmPTYRN+RcF1sF2aXmyoMgfjQiKe+/tDjYbdB4Rxlj0upuTx+Vq/CvXbLwGOurcV5SaatqMnR82QkfWekLmDOyZP3hLe23/jaD1830JqOtdmiMZKy8Fy3IlWSMQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10308.namprd02.prod.outlook.com (2603:10b6:408:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 15:08:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Wed, 28 Aug 2024
 15:08:20 +0000
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
Subject: RE: [PATCH v4] net: netvsc: Update default VMBus channels
Thread-Topic: [PATCH v4] net: netvsc: Update default VMBus channels
Thread-Index: AQHa+EBXTldwhB2dH0W0CzyXLVvRKrI8xyfg
Date: Wed, 28 Aug 2024 15:08:20 +0000
Message-ID:
 <SN6PR02MB415702718E57A11B32CDB24CD4952@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1724735791-22815-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1724735791-22815-1-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [IK15oAQdi5x4hHpSAI83qNC4FxLRmPbS]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10308:EE_
x-ms-office365-filtering-correlation-id: e2a2b5b5-d4da-40db-ca3b-08dcc77340d6
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|15080799006|8060799006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 QBXrCR93O1QBX/tTGoZu8yk/Do/XXPTFloFbIhFU8/2KguAXlvHRa2i7exnvpRZ2DDI7rGFEm0Vi/1vE7p9ygwucWngFtcTh4LwkMJJmpJ34PAEBfCm8oDKPNgOMKbOAcXsrPyZDewb6pIUT/NtzDkWCXUdixs09K/+APbjtBgld5Prvmgv3N7un+lS85uiz4ZG+mKcQUS+3U3wbP4AVd1ZVRymzrT787VomOt9cpE+/FRm+FKPbJb5EETZW2wL17cCQz0D7L1rxZcrNXesijS9MhFj0gfDN64EDsd4/e9wd2Rv8Vul+50uyUXPDSvrcR6yKf13Ne9PWsQyUWqhKQTjQjASoqyMs4EAh2KzqO6eHfXT86ovp2ZB7WshUTFBwnKYLzKAtMIrwKyx2YthuKVQSVL7MF4OylOdoDiP5jMdVVCHdMNq+9qdOOSjMe5YC+/V72dNgLr6WA8Wdqo+B5Dre3OrkY3HnZZmZ13BZkvvzk4pJun1r/B+s/TC40+oqu7F1OJ9kKt8L/cnbiCI+2IEety4c+ex3T//ib1mRwbKyDOJpeQJXcKdhRYkApoP4BZCKTWrH9qzA+zCnO9a9IxtjGvDb516AFglMjRqQ4D/ZBWLtJPpPUw/qU9lHHarqgfJUDQau9NeQDQxyYf/Q8iJv3hMA0y69JGJSyBhgkz+/yHogIBq9ekPCA6ALlKlD
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hImsKDk/Wzm5560pDXHKNF5fjP4p0asBINodJJ8cklQEflKJ0HFWTDlku8BE?=
 =?us-ascii?Q?B+pKS6TsOJJ3dvhiM4ALeqwFUwofDwcvgYUD5l8rHUxY76HzOmwkrVadoJKO?=
 =?us-ascii?Q?pX5vsemWKgM3ipklzg/RGBhl3LXjVlqRzsuvnDwXEhneDV8kFEiXps3bj28A?=
 =?us-ascii?Q?UUk2doFWlx67jl6OGr/NYo0NgKTaHIGPTolOyZR5hiFcA2S8WnQNtd7pUAvh?=
 =?us-ascii?Q?vtn/3BjQK5i2/0MOLKC0NhM86VAaSsLJQRh06F1jJzv19WHniXzdUHhrt1Mp?=
 =?us-ascii?Q?hYprBvw0iO+gl6zfqYr6vTtXCDYcR3suREruL5FNOmVRyeSVpQgUESdKQnE1?=
 =?us-ascii?Q?9hRje1vqqQN7FbmtGJRwFIjHDktBC/zEqWWpYvGGQFtS+6ja+Veuv4EfLHb0?=
 =?us-ascii?Q?WQFqv4IUgYApGtThSKN+RcvQg8cyIo+2bb0sE6OmFs3sQvdSaLXMQvhttvxq?=
 =?us-ascii?Q?xELXX/0lN2FGxKzF4a3UJMLDIvsda//E5rEDcaODBHlXUaxvFRvHurcnw2Uq?=
 =?us-ascii?Q?7h650TjDt5dhz4pTx8InIryV5NuPK6qW06+EgK93CBxrKAdLCMdgwP2ybIxo?=
 =?us-ascii?Q?QnLmDA0omWIPEcIA/IfL198BVh7MJZeJiZKUbvwUbJlMQfoHdOcdMG6VDzd8?=
 =?us-ascii?Q?t59BvHlQZk6auH58uDIYvTdHsVgASEnM7/uvOCiB571N/P34q5ZPop/Phjtt?=
 =?us-ascii?Q?kVtrw8hX4Q2h/rrduDsPqcPTM4QXUvcR6KuyJpfuWU+7eOqYiI6nAxnKVZXq?=
 =?us-ascii?Q?atEVGwn+jJ/OVMLU9owvlXSb1uKZEddE75eFHbfu4E/hHaCWnJkOfgxRZ/Lo?=
 =?us-ascii?Q?1+07x88mrve7bhWVeaIvfrYqDbuNfxP6JjV0/sB7tmVBYm1OOehZa3LO9y8N?=
 =?us-ascii?Q?o2xAGYMteMZ4+RkmmMS1/fHH9mmH6+WnkzoJw7FP4786XJVW/BdYA/LD6QZq?=
 =?us-ascii?Q?ekX5rnByB3OrzcJPaV8oQqtu2cUScyJ5WSMb3Vnyo/hRo6llJ6D0txQelJwv?=
 =?us-ascii?Q?Kh0TiSOAnOkdEezNuiGx1ga6vziMEU8DnMm1n6H+Jq6fxaM8Sz9YHRiUTxg8?=
 =?us-ascii?Q?DaLNmPUYbgQSQtztUdJDXQMBCwcc752a+jrLVrFyLIasWDubYnmNDx9A4eJ3?=
 =?us-ascii?Q?nmDNaheax6bBaF4uEfqloKWN1BRmmm63yTbTLY9F15o3gqTBqSWsn6AooPiC?=
 =?us-ascii?Q?qhYSKDNZjbVZh1aVKbsZOx7bQb+Rgv06cZIxdJoh6d40jO55Jm13i7Bk8A0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a2b5b5-d4da-40db-ca3b-08dcc77340d6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 15:08:20.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10308

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Monday, Augu=
st 26, 2024 10:17 PM
>=20
> Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> Linux netvsc from 8 to 16 to align with Azure Windows VM
> and improve networking throughput.
>=20
> For VMs having less than 16 vCPUS, the channels depend
> on number of vCPUs. For greater than 16 vCPUs,
> set the channels to maximum of VRSS_CHANNEL_DEFAULT and
> number of physical cores / 2 which is returned by
> netif_get_num_default_rss_queues() as a way to optimize CPU
> resource utilization and scale for high-end processors with
> many cores.
> Maximum number of channels are by default set to 64.
>=20
> Based on this change the channel creation would change as follows:
>=20
> -----------------------------------------------------------------
> | No. of vCPU |  dev_info->num_chn |    channels created        |
> -----------------------------------------------------------------
> |    1-16     |        16	   |          vCPU              |
> |    >16      |  max(16,#cores/2)  | min(64 , max(16,#cores/2)) |
> -----------------------------------------------------------------
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
> Changes in v4:
> * Update commit message for channels created
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
> @@ -987,7 +987,8 @@ struct netvsc_device_info *netvsc_devinfo_get(struct
> netvsc_device *nvdev)
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

