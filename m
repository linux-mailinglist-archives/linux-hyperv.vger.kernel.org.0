Return-Path: <linux-hyperv+bounces-1480-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B805B84265B
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 14:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCC21C2404E
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jan 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6896D1C4;
	Tue, 30 Jan 2024 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KpVMjUOb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE86D1B8;
	Tue, 30 Jan 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622237; cv=fail; b=ZTg08bc1j+bqrPjhLuTWQ9KPfY8HezBdzfneriLKz1pSEExwfQVA6YlWn4Ap5GooKxSjDeA3aSk4YRorZk/ojb0CwLc8HyFCiYXn8XDIh8b6XZWZyG4e6MTpZvqahWad5NEgd5pCxcQIYlBJ2ZTo3gMlgYMdkSPd+BSTYx9Q/xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622237; c=relaxed/simple;
	bh=jQj0bxIBNXkbJrlm9SLlyyGWXf9vWu2Vei5oo8rGH/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SjDB1Bg9JlkF1ifXF/R6vySYvV+cCYK1vwK6mCb3imeiaBoxt1SV6goUMethcZgp9WZAk4igl9fZHchcfFxpwqRHkyN9KkIkO5JZlyV9cva+i5XapNwuz/ID1BdODntKdjcR0HQBTBzHqQZSNCRyxGcn/CAK6Dx9NxOczNnB+b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KpVMjUOb; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSCfG2oCHNePWaza3Xzxl1SYQQsEjme2TojiMexjXb9fhO04QKmCdwPJLd6hQAyRoCMLF5yQbUzskDGTUvAOnsNFQpIhiYSTYQcj7ZYWhAc+5NimPdJD6mNDtdX6UB/r8fU1OZUeiF293PJEESpmMNtX843UWc5WdGIuSGP65Nhag528UJgxs5wk1F4txcbbkvhfMRH7hAO00/C7qVroH2AvU4A771QYrWWl74er8UoUsK68+of8E8c4q4uNicC41bIALo8WtIMPa20LNutVWVH7w6UuUdEN6lMjcXm/4XNW3zlrlGB/1dNHXhsGlFIx/pSIER2ilk7haJYdu35AGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF+zcgpws8wqxykBVrS84XOPQP1hUIzaaARXPWPxlIo=;
 b=Keg7t83Eh8JKcgm5FUYceVf4nU1I2X1wJVaG4AY0Lm0UmUfMvzpRNZgpywyBEgS+8S+J5c7l91dxm15GbY+kIQWo5YU5AanvqJ9upSPbrndCd4JsyFtkM+Y+eswfhphSLtBjbDkpjnUXSmZUGexD8XxuIwEAfeRp3SCK4DiZfdCz0vdWg/TKz+AUkCmkZ6NDkkJZ416yt6brGfOCcz5liXkXKC7SZ6LlxMg9yxsKtkDoNURXIabrsYsZS0BZNTmCjKGjUvBWWJWkm7PxIIfOLmWBWC3gFjiqAe9F6UZiLZejZi4Akf7WxOz1hxsu3uetYzrnTfw6QnUDjP8GlttWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF+zcgpws8wqxykBVrS84XOPQP1hUIzaaARXPWPxlIo=;
 b=KpVMjUObd3TgYf0g1NHgoP5UpMSDXE040d03W9N2ZeBTBcMs9EMCt0Nj/aHEuGE4yX79D6FFF58zAB8gLJ9WCOv7MOlOeAshvhzyKxHKi+Kvm2S1XRFh75/GTTvh7gYFL9sAp0f6RH6JOq1XyCySu9f3G2ElW6LnrN3nyQ1bDU0=
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 (2603:10b6:2c:400:0:3:0:10) by CH2PR21MB1478.namprd21.prod.outlook.com
 (2603:10b6:610:5f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Tue, 30 Jan
 2024 13:43:51 +0000
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45]) by DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45%8]) with mapi id 15.20.7249.015; Tue, 30 Jan 2024
 13:43:51 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaU0yZNOZ7/lEXVUScWvjgIg8G/LDyXV5A
Date: Tue, 30 Jan 2024 13:43:51 +0000
Message-ID:
 <DS1PEPF00012A5F768C4AED4E00327DE243CA7D2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7c45964a-50ca-44e7-bf0d-86e4d8257ad5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-30T13:41:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PEPF00012A5F:EE_|CH2PR21MB1478:EE_
x-ms-office365-filtering-correlation-id: 53eed0c3-d819-4402-4cb9-08dc21997e57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FzNKAWiO6ajH0mX5UN5WNkoQUph55WDcq7Xd9MLz3hlvmRNpBjb+y7rJ64pU/eu47pDdnFinvtBBVgMw96rJeHQhy+L2ZNHLS89dC7Ma4DpfdW/OGIkonq6dYKJgUoOP7SktuuPbQt9nQPdAmBZvxmxOD3G+3CyUYI+J2OzJvje/vnRpeA6zEVnAT+/i/MRE9o2jJoAgtCkEJ37QMPVtmQrEZjocJzp4t8RA/PJo7Tha73RXlCFn+YZXnZn1CVRDap84L6fTVE3I7II5jYhL5MiXfBiPvM2z/wDNwZaG7GWaee3CURqxm8cYr2LntwHY6G0qI31ujRFYSZH7DxjFKe4sgrc1yhdA/uaC7MeAx0/1DplF6n/EdoslXAjPdW7Hnk3E6wxdk1Dqe/+L6fHN+9gXn9ZJcn7CeujT1WU7X/1dbaZXG1kY5a2ZNrrTmCBECr1HwP6u6WZi4UfrQ4hq7qS3vxM54xcEfzII3WlH5sMGNTRjqXd+QAk+TI1/Ow1+IjKeWYWeqGH3Q7VhvtQqipRUsZXdts4IUK9+aJD99aufSt0O4Oqf1DKYSez9W8GUsWAiavWRO8DsylmXSrwh6iyxYEPzLF3LShYtnlPzafo1aQnv9fWHwZlgvHhX4bff
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PEPF00012A5F.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(41300700001)(921011)(55016003)(8990500004)(38070700009)(478600001)(7696005)(6506007)(9686003)(10290500003)(71200400001)(83380400001)(38100700002)(53546011)(82950400001)(122000001)(82960400001)(86362001)(33656002)(7416002)(5660300002)(316002)(54906003)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(110136005)(2906002)(4326008)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FzdRwXoxs86/Rf/TbrHvzw2MXvaMAA/mPjnRTZysgzBHXFYtIup7g/TKrOE4?=
 =?us-ascii?Q?ZdEACiP2Jf0ubYx41vO7RHkES1OcTyTVYgsb28mnLtg/DFU5r/3IhSl2PI1P?=
 =?us-ascii?Q?Z+PQrZyNNUwsZSNRSrK9M8agIyP4r0pcWD4Lxx5X27McONBc1soyNrbGj2EY?=
 =?us-ascii?Q?4uAnUmlfl4r9dn/YuzOJv3l27kmZj5zzlMv5eDcfIcnQ6WhxIkRk4rKeHyoT?=
 =?us-ascii?Q?CorbCvA4/s3Ovd3Zl9Ti1aOm1DsYcoKY+DbUhDGkT+BWainLMoXoE7Iy/HCf?=
 =?us-ascii?Q?xtDmSFN4zxGNixccgdyt8GQQISIubpXlZcpZUoR47M0wI6uQOXImkcOodYaC?=
 =?us-ascii?Q?l/bvJn3/u0iru4XfhuIj5X5tMiAeiwiI7ioHgocXV3jw8p8mCTl8YYHDwrQ5?=
 =?us-ascii?Q?rDdShChyHVgY/WNuQm34ga3W859w/frdxu8PZNUXMD+xYWg6tSxXjuQwvPBz?=
 =?us-ascii?Q?fUxNVsSfURt8Wo5AUPNOiv3IgkOVIxeedpYYiJKGi30jT/eRj/bFi6dvBxxP?=
 =?us-ascii?Q?i3Ck62gwaoT17K/siTLxNSy8/+7xCIHUPtCJkvz+SHs6gYbTcljCfYd1tgbU?=
 =?us-ascii?Q?zUN8J7TSukjEWSoQ74eJqTwMSjyARJADeZ3eEe01uEFC4u4u8zjf3qi2pC99?=
 =?us-ascii?Q?mU4F/C2nLUPKfe4LBWnShPJY9Vw+f6q9OXvpa7HCiGWbpZsyFDG6UMw2Qalt?=
 =?us-ascii?Q?PTow82OnZfsCEJjXb10KCenHYojURpPwNEhcmkz8fPUa6ie6z3AAxdSNszez?=
 =?us-ascii?Q?ea0W/T4nTD8ZRqWKM/z7HuRzMvkgnGV5gvq0p2lFee3rdj/QkyI2S05TIhBl?=
 =?us-ascii?Q?vphH04L6ceHK+f1UpOLGulvSwUaXWf5OIUA8+HQNxLo3d0bc0pPv2rF6XVTr?=
 =?us-ascii?Q?6ZN3W6Y16TJdW+sjdeXyqarcBruW6+PSo89nEhZnXOgyMRK9DSUuyWmEbZTW?=
 =?us-ascii?Q?1GATD9GOoQ2nqeVpF3VFGOTImpCk6RzYuiVG2M+prUUPknu3cojMKaomiifp?=
 =?us-ascii?Q?DjANlms7mFXza8Y+5qrITVhZp7IwfVqo7BJ6oT6iCKWSYke7zmfNRQQAelyo?=
 =?us-ascii?Q?5oSKYUKswaA0WH6mesDLgv0s16J4urTNgKuWdGWWMdN3AtJ+ZX07JGjOrvpC?=
 =?us-ascii?Q?/CFJza1P8ypWmMYLcvX+SuqZXadeCFVE3GI5OQHWsjWp50ro/5xhJYBstcWl?=
 =?us-ascii?Q?WTvMVv8fxyX3yxNR9hY83yRa0rLKk1LLvLaBAwRyViYea7lV7rCaVp0xPQdQ?=
 =?us-ascii?Q?7/eTarGO1RbTtB+/VCScbiU3VZOm3cw+724b1xNMouuBRHffhosH4x2JPdD+?=
 =?us-ascii?Q?h3/CVOBSERzSpjdZu4sBlPjLBIKyGMyTlZbRsSpA0bMfG8cqmSbZSvltp9Ox?=
 =?us-ascii?Q?a7Q42Fxotchu096DiJ3tQTEFdbQDUtd1uY9IGq7lQ8cE8ji5kS3/G0MpIk9H?=
 =?us-ascii?Q?68Tbdt4uamSPVYVmw1PIm9TTdr73sOYw2O302XBgX4SJYZi3akzQzfXNvo2P?=
 =?us-ascii?Q?1Jvpz2jx2P80x30jHe8dVK6O5SpCSrQ5CW7jEzLQz5XN3jW2e4oAUZru13/1?=
 =?us-ascii?Q?dDmXXodf6juNDRQOsbEIcai8PYD4eZDk/7BraRDx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00012A5F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53eed0c3-d819-4402-4cb9-08dc21997e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 13:43:51.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQ/MRpYiOSVcyCAtdCZcWB+J+Docjj2QXdNx8nRF/SUam15g9EVm5Qqsb1jjN6xXM+0zrAGDejTuw07wjwi0wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1478



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Tuesday, January 30, 2024 2:19 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Wojciech Drewek <wojciech.drewek@intel.com>;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@microsoft.com>; stable@vger.kernel.org
> Subject: [PATCH] hv_netvsc:Register VF in netvsc_probe if
> NET_DEVICE_REGISTER missed
>=20
> If hv_netvsc driver is removed and reloaded, the NET_DEVICE_REGISTER
> handler cannot perform VF register successfully as the register call
> is received before netvsc_probe is finished. This is because we
> register register_netdevice_notifier() very early(even before
> vmbus_driver_register()).
> To fix this, we try to register each such matching VF( if it is visible
> as a netdevice) at the end of netvsc_probe.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 85520856466e ("hv_netvsc: Fix race of register_netdevice_notifier
> and VF register")
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Tested-on: Ubuntu22
> Testcases: LISA testsuites
> 	   verify_reload_hyperv_modules, perf_tcp_ntttcp_sriov
> ---
>  drivers/net/hyperv/netvsc_drv.c | 49 ++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc_drv.c
> b/drivers/net/hyperv/netvsc_drv.c
> index 706ea5263e87..25c4dc9cc4bd 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -42,6 +42,10 @@
>  #define LINKCHANGE_INT (2 * HZ)
>  #define VF_TAKEOVER_INT (HZ / 10)
>=20
> +/* Macros to define the context of vf registration */
> +#define VF_REG_IN_PROBE		1
> +#define VF_REG_IN_RECV_CBACK	2
> +
>  static unsigned int ring_size __ro_after_init =3D 128;
>  module_param(ring_size, uint, 0444);
>  MODULE_PARM_DESC(ring_size, "Ring buffer size (# of pages)");
> @@ -2183,7 +2187,7 @@ static rx_handler_result_t
> netvsc_vf_handle_frame(struct sk_buff **pskb)
>  }
>=20
>  static int netvsc_vf_join(struct net_device *vf_netdev,
> -			  struct net_device *ndev)
> +			  struct net_device *ndev, int context)
>  {
>  	struct net_device_context *ndev_ctx =3D netdev_priv(ndev);
>  	int ret;
> @@ -2205,8 +2209,11 @@ static int netvsc_vf_join(struct net_device
> *vf_netdev,
>  			   ndev->name, ret);
>  		goto upper_link_failed;
>  	}
> -
> -	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
> +	/* If this registration is called from probe context vf_takeover
> +	 * is taken care of later in probe itself.
> +	 */
> +	if (context =3D=3D VF_REG_IN_RECV_CBACK)
> +		schedule_delayed_work(&ndev_ctx->vf_takeover,
> VF_TAKEOVER_INT);
>=20
>  	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
>=20
> @@ -2344,7 +2351,7 @@ static int netvsc_prepare_bonding(struct net_device
> *vf_netdev)
>  	return NOTIFY_DONE;
>  }
>=20
> -static int netvsc_register_vf(struct net_device *vf_netdev)
> +static int netvsc_register_vf(struct net_device *vf_netdev, int context)
>  {
>  	struct net_device_context *net_device_ctx;
>  	struct netvsc_device *netvsc_dev;
> @@ -2384,7 +2391,7 @@ static int netvsc_register_vf(struct net_device
> *vf_netdev)
>=20
>  	netdev_info(ndev, "VF registering: %s\n", vf_netdev->name);
>=20
> -	if (netvsc_vf_join(vf_netdev, ndev) !=3D 0)
> +	if (netvsc_vf_join(vf_netdev, ndev, context) !=3D 0)
>  		return NOTIFY_DONE;
>=20
>  	dev_hold(vf_netdev);
> @@ -2485,7 +2492,7 @@ static int netvsc_unregister_vf(struct net_device
> *vf_netdev)
>  static int netvsc_probe(struct hv_device *dev,
>  			const struct hv_vmbus_device_id *dev_id)
>  {
> -	struct net_device *net =3D NULL;
> +	struct net_device *net =3D NULL, *vf_netdev;
>  	struct net_device_context *net_device_ctx;
>  	struct netvsc_device_info *device_info =3D NULL;
>  	struct netvsc_device *nvdev;
> @@ -2597,6 +2604,34 @@ static int netvsc_probe(struct hv_device *dev,
>  	}
>=20
>  	list_add(&net_device_ctx->list, &netvsc_dev_list);
> +
> +	/* When the hv_netvsc driver is removed and readded, the
> +	 * NET_DEVICE_REGISTER for the vf device is replayed before probe
> +	 * is complete. This is because register_netdevice_notifier() gets
> +	 * registered before vmbus_driver_register() so that callback func
> +	 * is set before probe and we don't miss events like
> NETDEV_POST_INIT
> +	 * So, in this section we try to register each matching
> +	 * vf device that is present as a netdevice, knowing that it's
> register
> +	 * call is not processed in the netvsc_netdev_notifier(as probing
> is
> +	 * progress and get_netvsc_byslot fails).
> +	 */
> +	for_each_netdev(dev_net(net), vf_netdev) {
> +		if (vf_netdev->netdev_ops =3D=3D &device_ops)
> +			continue;
> +
> +		if (vf_netdev->type !=3D ARPHRD_ETHER)
> +			continue;
> +
> +		if (is_vlan_dev(vf_netdev))
> +			continue;
> +
> +		if (netif_is_bond_master(vf_netdev))
> +			continue;
> +
> +		netvsc_prepare_bonding(vf_netdev);
> +		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
> +		__netvsc_vf_setup(net, vf_netdev);
> +	}
>  	rtnl_unlock();
>=20
>  	netvsc_devinfo_put(device_info);
> @@ -2773,7 +2808,7 @@ static int netvsc_netdev_event(struct
> notifier_block *this,
>  	case NETDEV_POST_INIT:
>  		return netvsc_prepare_bonding(event_dev);
>  	case NETDEV_REGISTER:
> -		return netvsc_register_vf(event_dev);
> +		return netvsc_register_vf(event_dev, VF_REG_IN_RECV_CBACK);
>  	case NETDEV_UNREGISTER:
>  		return netvsc_unregister_vf(event_dev);
>  	case NETDEV_UP:
> --
> 2.34.1

Please use [PATCH net] on the subject to specify the branch.

Everything else looks fine.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


