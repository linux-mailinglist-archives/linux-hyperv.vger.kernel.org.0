Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C079917492B
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 Feb 2020 21:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgB2UUK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 29 Feb 2020 15:20:10 -0500
Received: from mail-dm6nam10on2124.outbound.protection.outlook.com ([40.107.93.124]:51966
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727327AbgB2UUK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 29 Feb 2020 15:20:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgKZEgpP9y43+h8nT/vsILaoNSeuYtCVtMrwQlQ6u8S5kuriXy5HjrAB/1OdwD1Y2WAp0BPMI8tpab3DHkvokwSisX9tfDGdtYKtn7Rxjum/pmm2ai1K63wd7eXwdUtAPov45KYxJ+/0nmmv59SmqW6HVffsM0if6kX6bEjTPe2/x3lKVWD8H3Ej10B7Jsm+0G4fZRmkMExxRZrAwmaruolKDP4c7hXq59jAL8lSecTwrIGgBTm7G4jqntHosIxpQXAb4Xa6f6anuzN8pvBPxstCOjf9a42eZAeQwYDogytnI3oLlyc6dzbswxMrpv5I8bnxWzLo/waBk/yYcD1sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I3D8vdzn4J0FvBh7iAv5G0yZzumZkJKxJeFBdadMmE=;
 b=JtNkbpxxkOxFUHAvMhzttQJCmhPh1+ZRGiyGEOnrC8b1t66o5gq+D+0qnIxI2lK+ZFvTSHxU1uzIsw3FYXAzhMaHGWVfLWqMvTuvOomtQ7meCVHZO3Zlwd2R3q5UTiAwEaATaqSfOvVkaagqeor43hOkU0G5OGguwbUEplZXzQeSHxcgudf5jrPwLMwVe9pXaSP80TUxE8OcHPafieutdN58sPmt4tUUAzMjbyY5GDF5EYt3rplb/rR1cafp9ss9wEqmm2VvM8evCSLl6zjrhpkvdFSShBXeNAVgbAD0mZUjOgCDd/Xo7HBnesl0t2PxZ2FCK51DsSwX0fAXFiPyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I3D8vdzn4J0FvBh7iAv5G0yZzumZkJKxJeFBdadMmE=;
 b=TY9kU/LEZkgXsfeOQn5fF0O6Ih1Qb7637WTGUH+cnwBT3Uq3SWeTgSnqPmppRLFa+NlMg8GeJe0D7z7f+TSQa8k6dmyAw5QwUMXG+4cTIOTYFBQHbysdRzl4TkQbpvcFiTJjl1xf7J3u2zK6P8TRayFR9J3AK24esv/HFL9Eh0M=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB1127.namprd21.prod.outlook.com (2603:10b6:4:a7::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.4; Sat, 29 Feb
 2020 20:20:07 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::70ca:9966:4651:6e48]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::70ca:9966:4651:6e48%5]) with mapi id 15.20.2772.010; Sat, 29 Feb 2020
 20:20:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Lucas Tanure <tanure@linux.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
Thread-Topic: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
Thread-Index: AQHV7yXqbbfxNHQRAECv2dHESdUyNKgynJFw
Date:   Sat, 29 Feb 2020 20:20:07 +0000
Message-ID: <DM5PR2101MB10472B84AF391205091D03B1D7E90@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200229173007.61838-1-tanure@linux.com>
In-Reply-To: <20200229173007.61838-1-tanure@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-29T20:20:05.3650060Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=edd023e8-1a01-4118-bd24-a3302499c14f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fbc36c0-40cb-4d2e-bd90-08d7bd54c4e0
x-ms-traffictypediagnostic: DM5PR2101MB1127:|DM5PR2101MB1127:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR2101MB1127B896CEEC3E7BFC75884BD7E90@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:517;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(64756008)(52536014)(66476007)(66556008)(5660300002)(66946007)(66446008)(76116006)(10290500003)(7696005)(55016002)(8936002)(8676002)(81156014)(478600001)(8990500004)(81166006)(2906002)(9686003)(33656002)(71200400001)(6506007)(186003)(86362001)(26005)(316002)(110136005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1047.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ld8tjRXXJq6pVHycpil13rfEiXuXEBW5AuWCKx10DeZFPTI9dfuvVcDy9/u1LIvXTsZrsPvi93Vpo9TMWdjnymYX/UADTiq/bOh+noAJeZKNo84+CEjkC/KeGHghhxvBjNZg9yv+LRuNv716C28wrwZjXivbEsuK1a3cFcrra1699+SeR0cK+lkGHh/j9md8M01hOmXkdiIAd2N1vp85vjzQh3qrnxRvVdrGUNNT34+GzMT7N8ABj5YVVWPqM1muSTgCbBCZT/qwW2Oh1SCa/ypzNCX5ujvrxFEWUVlmyvNnP0B9Ou7OwgKYtjrdZEgvu+XGMnO2eK+AI7Vpa48T5wiV6B5/Ge13yyczDZEa4ogRS3b6FF+KkeeFu0+/k5GDPbBLAIqFILmeWxbQyVCHcPvsf2eXhnHTtsrYyTPaxCFF+jpLzgccZ3pg3kYNrF9z2J/W6i3xqAqxxU8V8Tg9/RVeJPLrRsq332eBaBZIAyLzuQ2yxhiODvTM38VlgZ9
x-ms-exchange-antispam-messagedata: RS8nOTJmIDzbyT8Z3sHPWk/RCy1gG+V8ZwX/TRvKOYjUgkjBUxGzFNziT+gwDPRD8l2UVwC6XKa1PXKWrH3lRX/57rN1NxdNLZbu+SdSUE82DJCH+i3C3a6g5rOwJGKyPgmIsNQdFW1GyKigmzG5Hw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbc36c0-40cb-4d2e-bd90-08d7bd54c4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 20:20:07.2460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mavdP+MBwB4ytGnb4WjUY3M1FP8sijH9gpyFoG7xZ/YCgj5yPHAF26EVlUSuC263cXFFvaPsk49lvFZgrzIUD9zOfNTr0XyXaR3kODu4HGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lucas Tanure <tanure@linux.com> Sent: Saturday, February 29, 2020 9:3=
0 AM
>=20
> Fix below warnings reported by coccicheck:
> drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing=
 functions is
> not needed.
> drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing=
 functions is
> not needed.
>=20
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/hid/hid-hyperv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index dddfca555df9..0b6ee1dee625 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -193,8 +193,7 @@ static void mousevsc_on_receive_device_info(struct mo=
usevsc_dev
> *input_device,
>  		goto cleanup;
>=20
>  	/* The pointer is not NULL when we resume from hibernation */
> -	if (input_device->hid_desc !=3D NULL)
> -		kfree(input_device->hid_desc);
> +	kfree(input_device->hid_desc);
>  	input_device->hid_desc =3D kmemdup(desc, desc->bLength, GFP_ATOMIC);
>=20
>  	if (!input_device->hid_desc)
> @@ -207,8 +206,7 @@ static void mousevsc_on_receive_device_info(struct mo=
usevsc_dev
> *input_device,
>  	}
>=20
>  	/* The pointer is not NULL when we resume from hibernation */
> -	if (input_device->report_desc !=3D NULL)
> -		kfree(input_device->report_desc);
> +	kfree(input_device->report_desc);
>  	input_device->report_desc =3D kzalloc(input_device->report_desc_size,
>  					  GFP_ATOMIC);
>=20
> --
> 2.25.1

