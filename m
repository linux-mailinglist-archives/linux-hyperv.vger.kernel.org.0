Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B452C7A1C
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Nov 2020 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgK2Qwg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 Nov 2020 11:52:36 -0500
Received: from mail-dm6nam12on2121.outbound.protection.outlook.com ([40.107.243.121]:18532
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbgK2Qwf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 Nov 2020 11:52:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVB5vNcgXc2IO1hs7G1VcNEa+yrCrrjmMOnIITmTlz/ESxC9xbnjXXoOzvkarU/YZ+GhPsqdAPEzbzSB5UST3DNUyjFoNRQCAlUqGhivwLkhPccRDT52AftvxJs+E8MDBGDT9uoB7hidvcO8AqYOcmNk4QNFQb6bzFl0pdbzVGCNTCjQBVHNFQyh26ezKIYvZP2t9vVcfUiLuSxoYTb5azfb0blr30A1Dtp1ifVmRMaw+h5fU8bpetUn++9B3u7H9AQBMNpLpb1/ccf0SpbfYZkhUBfqB91mnBKYmglxos+q45/qGa4S3EZQ5zKeMJVF+ylino+Znv5iJZx467jAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhkJeuxf/JcjHUW/yUfhOrRLGAkkyReUBdyBPcrHDiE=;
 b=cXb5mvSQyM1HlJxK2QelXm8NGS3BcdO1KuxbB5B7e6nNNUxCmhz2m/V7yU5QUhjnnHIkbmA6uUPH/viGjl473YT9i8+ga7LvPEWiDgiHAh64jtD0BkMFyhAQwMyd8ebppF78mLY7QEJ1bPsPkqUZmnT7TxIQxV98zZm9YEeFRzTHnR4Dt6gY+v+L/7WYQ4hQr3X3IyYHsXPSG6cotVzUJ8pgHS9JEIk+w1Ou9k4+1SuA6XSOebv5ZVYNwoUORS/1NMvBvuw19/xLBi2ek1+rgwU0Yc3TVt/QOgqho4JFYBDsoy3NaHK/cIQGxUlkO5AaAszEUNmeov9LsP4aiRfijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhkJeuxf/JcjHUW/yUfhOrRLGAkkyReUBdyBPcrHDiE=;
 b=K9gzfKIcM3hJqP6yQQIco/eOUEg1poIva4gQrNddA+5PXGRng1WzVpbHghM1zp6UnAzqy5AFocKQjJVod6UXQIiMxjZ2JfCoyJQYei2s4eW5VMJ7D5VXClEDS5RrxbkWpQULXajdO1yiFtd52jVVa5WvKPd+27zy93BAVB9c310=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW4PR21MB1908.namprd21.prod.outlook.com (2603:10b6:303:7b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.0; Sun, 29 Nov
 2020 16:51:47 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3632.010; Sun, 29 Nov 2020
 16:51:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "joe@perches.com" <joe@perches.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Thread-Topic: [PATCH v3 4/6] drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
Thread-Index: AQHWwttd4vjkeWZevkuliP185KleNanfWbbQ
Date:   Sun, 29 Nov 2020 16:51:47 +0000
Message-ID: <MW2PR2101MB105245D2BF9C9B5995D0188ED7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201125032926.17002-1-matheus@castello.eng.br>
In-Reply-To: <20201125032926.17002-1-matheus@castello.eng.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-29T16:51:46Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9e7dd952-d231-49ae-b87a-7da2a15e805d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: castello.eng.br; dkim=none (message not signed)
 header.d=none;castello.eng.br; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1db0303-37f4-49c5-14a9-08d894870fb6
x-ms-traffictypediagnostic: MW4PR21MB1908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB190874C293B964A617BD9B31D7F61@MW4PR21MB1908.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHWZsjlDvah0EqXIQEBNsBaVvJcpxmZSooFoFZeYGKNAzb2qqQrUYwdM3xLWi/rue1llLrR7wpmakcGIiSSY5qZ1poYe8xYlcTxnlRohSRUTzm3jqVFYkmLqt4QXscKidBZrjgLkrSS8tmijohWAynL2xiyB669dhg6x5jffl2Mc98EQ9UO9QMA7d1R5fwODgCgASW5A5IjS/+KrIM1MY53tioP6xCeSW46HDkttsZ+HtYzKvHEo7BxriFdPrPM5y+64OelBjR6NlznuQ4FZtL1h/d3fnlSNGCVSv6A8lv7E9QTXk259wI7PihTunlMk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(4326008)(76116006)(64756008)(66446008)(66556008)(478600001)(33656002)(66946007)(2906002)(8676002)(9686003)(8936002)(82960400001)(26005)(55016002)(66476007)(83380400001)(186003)(54906003)(110136005)(316002)(8990500004)(82950400001)(10290500003)(7696005)(5660300002)(6506007)(71200400001)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Nqpx5bzXSiHDxVs8byybZSymOsGPVlAfY4zAchvFuKlFPn2zjzrn8CAgcF8z?=
 =?us-ascii?Q?vU2bQh/4nJ0uir6xQFI2r5PrGLEnWAdbhS1YMlNb+GMqG1g/V1FZ9N9qnTyh?=
 =?us-ascii?Q?+5s9aAuufHxjvBBqJnwfy3aZqklenLLTXY4wISbROvdQEJyLDK+vXj99jgyC?=
 =?us-ascii?Q?zre08qMTIFsvRBoVI3iyuX1maEKzhijsFOgrOBxthSZ+TKZxCSKEl/0wPMZQ?=
 =?us-ascii?Q?GMVfgyAINdknsYKK2ARBdPECEJrctnNmXqpMkhkJ3zPUD0l541xTScib4pvP?=
 =?us-ascii?Q?Pdo6zvw/RGU5I5s9enUibPNE1pfxCaOtyqaY3YaLyYURlcsJTSw8RsPu1P/H?=
 =?us-ascii?Q?pSlfx9NR8V1/o0mO+zi61KML1ymz45LlLn4q9r/HkJ9cx0hTYTN50TmJSMjP?=
 =?us-ascii?Q?/mP4TTzwV/IiVBEoppNBkHTDM7rjomX1jJoFLQDtJH1THYn2Bzx8KoEQ0Ifl?=
 =?us-ascii?Q?nf1BQg27VeuC+8ecCiKr8IA3mtN715x4sr277P1hpZC8W2V8v0y/MVKYzMUb?=
 =?us-ascii?Q?bRzWkG/V+9qE8oAEuFClz9LIu8rj3CzZXTuIJTYPRU7o1gShfPt2a/PNbY4r?=
 =?us-ascii?Q?HWMGOR8TYc7+IGG/hbuIlrCmMRIb6gG2u7hDVV6vGt68Obx5ok8tOfE5z86d?=
 =?us-ascii?Q?UCbb2IYGDJqVX4gKOCgYIrHtPfW4jUnT224altp+TalrGPl8/0nRUPLN/QrJ?=
 =?us-ascii?Q?JpyS7ZEVZfkgTVxQ5RqsWZbsqfxth/xJK4OaOSOVx3r4laBG5w7UGVl+d0ch?=
 =?us-ascii?Q?cIGvJliwKycpNateJ5Wam9cZO+52z1RJdaU2rXMobP0CWznIcC9Msi9VM5Cf?=
 =?us-ascii?Q?F2w34Fxp0GggIXGjRv7qiKBCqz/k529XwzaoVZZsCi5tEozl/eYIlqCMX4Dx?=
 =?us-ascii?Q?7JABxWK7kSiaRi5RXLCQtwIk3j61eBFXF3aV07OKTbRDM6JY/JGQfx2BjDHk?=
 =?us-ascii?Q?Z6nPKfvdMWi5uEud8Af0WGGfE7Sy0fsaZ6vccNJTMGM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db0303-37f4-49c5-14a9-08d894870fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 16:51:47.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ojow7AL1NOr8GJTEx1EtSSgDSRJqqod+9IIcz/S9nux0Rs1VW+ra6DZt3u+W5akH7VvJDIfGZqu/69mW49GwsEiKN3hd4qGKVzMZdwLqgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1908
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Matheus Castello <matheus@castello.eng.br> Sent: Tuesday, November 24=
, 2020 7:29 PM
>=20
> Checkpatch emits WARNING: quoted string split across lines.
> To keep the code clean and with the 80 column length indentation the
> check and registration code for kmsg_dump_register has been transferred
> to a new function hv_kmsg_dump_register.
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
> This is the V3 of patch 4 of the series "Add improvements suggested by
> checkpatch for vmbus_drv" with the changes suggested by Michael Kelley an=
d
> Joe Perches. Thanks!
> ---
>  drivers/hv/vmbus_drv.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 61d28c743263..edcc419ba328 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1387,6 +1387,24 @@ static struct kmsg_dumper hv_kmsg_dumper =3D {
>  	.dump =3D hv_kmsg_dump,
>  };
>=20
> +static void hv_kmsg_dump_register(void)
> +{
> +	int ret;
> +
> +	hv_panic_page =3D (void *)hv_alloc_hyperv_zeroed_page();
> +	if (!hv_panic_page) {
> +		pr_err("Hyper-V: panic message page memory allocation failed\n");
> +		return;
> +	}
> +
> +	ret =3D kmsg_dump_register(&hv_kmsg_dumper);
> +	if (ret) {
> +		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
> +		hv_free_hyperv_page((unsigned long)hv_panic_page);
> +		hv_panic_page =3D NULL;
> +	}
> +}
> +
>  static struct ctl_table_header *hv_ctl_table_hdr;
>=20
>  /*
> @@ -1477,21 +1495,8 @@ static int vmbus_bus_init(void)
>  		 * capability is supported by the hypervisor.
>  		 */
>  		hv_get_crash_ctl(hyperv_crash_ctl);
> -		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
> -			hv_panic_page =3D (void *)hv_alloc_hyperv_zeroed_page();
> -			if (hv_panic_page) {
> -				ret =3D kmsg_dump_register(&hv_kmsg_dumper);
> -				if (ret) {
> -					pr_err("Hyper-V: kmsg dump register "
> -						"error 0x%x\n", ret);
> -					hv_free_hyperv_page(
> -					    (unsigned long)hv_panic_page);
> -					hv_panic_page =3D NULL;
> -				}
> -			} else
> -				pr_err("Hyper-V: panic message page memory "
> -					"allocation failed");
> -		}
> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> +			hv_kmsg_dump_register();
>=20
>  		register_die_notifier(&hyperv_die_block);
>  	}
> --
> 2.29.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

