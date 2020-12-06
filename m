Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02C62D0628
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgLFRAX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 12:00:23 -0500
Received: from mail-mw2nam12on2103.outbound.protection.outlook.com ([40.107.244.103]:65249
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgLFRAV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 12:00:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz57Mn+vHXqaNdpnObQ2dBt1Des5+DQ2hvJse2+I2ARMeZ+h3WeuJAq7Fi941gLxag7KwSFz+1hBEWUs+sliLhLPYmW4O7WxU9oyd+JxJMjk1qb73C0y33mpDAktE5KjwHDqIuWResdYHwl92DeTzVY25SPKRM0LnkNKT295b3bRp/evoKFk8+tKrbuKlAQWxDWuuIE4n7XVB7cR3CbJxp7wI1FKCG8G6UweI7ejv2I+5M+S5EmG9LnNrnSYb6mL2dqiLQulIRbjqJ79khnA0ZaE6rZyA/7lxwjKK1QrqEQGk6FZOMGGRBvFAN04RVyxFn9XaqUWucXsN/PO9pdKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2myRDxwx7hpmS/RqPcyIejNdeYhFHXWGSO09YpWlTQ=;
 b=TnGcy1yl/w+YU1wouixNa1S6yKV3P0NtFAXkXXH/+O34COmFJ/rlTtvk82zBKZuBUQLHj9PbtjobaohJJlG9O7V/XUVvwVp4Z2kLpNgqFhU1LIqe0VjMBKGv0aptzdtEO8NW0v7hQKF2fV0Df/Yw7jRZNiRy8jirlFEv8VPm58/r4GSwA/k368S5kD/a5Sh6rRv9KzviZEODVhXfuzu5mXcdnij2M7oE64aQaQnv0zn35sPwBOjYe28wi0Dnn50qDXMcAvbpi+VscxrEljhq+UjxXcqxl2FR0bIPw/14Mirj4wMCGcJPF9qb6ojtW4rjxzqWbORSxjiaRRUTxHEGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2myRDxwx7hpmS/RqPcyIejNdeYhFHXWGSO09YpWlTQ=;
 b=WMwO67CQzPnhUNPaj07SMIz5Su7RohGHYBIU5biXrnsx6YyTdIJZnTMK9xywAe18g5zCutuY1tgXNqz3ZUM37FPg1TgZ++TH2IPGwofBNuv5YiU/kN2CbbKFyZp/WyKhMtMX4f9hPSbER1DcEupdo8qAK9x+m5sZG09d6U0P2qY=
Received: from (2603:10b6:302:a::16) by
 MWHPR21MB0144.namprd21.prod.outlook.com (2603:10b6:300:78::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.2; Sun, 6 Dec 2020 16:59:32 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Sun, 6 Dec 2020
 16:59:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH 1/6] Drivers: hv: vmbus: Initialize memory to be sent to
 the host
Thread-Topic: [PATCH 1/6] Drivers: hv: vmbus: Initialize memory to be sent to
 the host
Thread-Index: AQHWvbhfIlsgN9ieYkSnpYC2ht99ZanqZDJw
Date:   Sun, 6 Dec 2020 16:59:32 +0000
Message-ID: <MW2PR2101MB1052B9BAFF7876427746F596D7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-2-parri.andrea@gmail.com>
In-Reply-To: <20201118143649.108465-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-06T16:59:31Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=08b515a6-9764-4fd8-bd12-6ca1bb5736cf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2a61a97-af29-40e7-391e-08d89a084dce
x-ms-traffictypediagnostic: MWHPR21MB0144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB01446221DB0208CE6A6F4413D7CF1@MWHPR21MB0144.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vh3l9labk0IgesngzyPhTO3k8F+cbgLMKKQcHg3w9/vBRQ6t+pGzl0zMwXanq4qp6hg1U6naVFMItGyGioHYuHqdUgcFKNg8TsBF34PBBI+amM0CuCCxePD+x7TmbmpN6QcSsSoyH3OXOS80nSz3Gp9bmbXuh72CXfB2Dg1OTUWZadbJrm7z83CRX8PIF/ZaQ8VRBh8O8+hYl407nlKf8pbkVZm7jE1WhkxXf2PH6LJ1GXZiW+OuPoOcsTQQJ/jAeUE0dUKcyXFzaGYaOabywJA8n1WIoIzMi8IO8orGSKttF4+EUSDUw+80KvFVwHFu6ftGt+HRbxPMqfclznn5bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(107886003)(4326008)(86362001)(82960400001)(66446008)(66946007)(71200400001)(8676002)(478600001)(33656002)(7696005)(82950400001)(52536014)(55016002)(2906002)(10290500003)(26005)(54906003)(110136005)(6506007)(5660300002)(76116006)(8990500004)(66556008)(316002)(83380400001)(8936002)(186003)(64756008)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iZDjTWaUyIjmAH8f3fjtwPbqyOYdPDoNKDZRzJiXrytMn1iDMBc3DguWSv/2?=
 =?us-ascii?Q?38YA46uKjPD3mF/Qq9K78hSLay0SXGQ6ljPEE4fUyqYbsedUytQWzvELZaHO?=
 =?us-ascii?Q?VS2cFdxPTXMDpgEo6Un/UcE7HnWEElW1VlrQgg6t5SR1R+Ghb3nymi2sGEN6?=
 =?us-ascii?Q?LWsg+BnklsfJ4enlZj9tEmFJKCqtO/a8PEGqXgYDjcjNWkJYpPAKgNSnPuyN?=
 =?us-ascii?Q?eCWZ1bh44apgZdwxPYhd2Nzk+FKwkTeO0uoU6gS53blf9HuFBeBJRh65JREt?=
 =?us-ascii?Q?wX9i6rPTjJzAtfM3ZLYeFpIi3l3wirEobetI7zea9CN9uBL48qCIeuQ8bS7H?=
 =?us-ascii?Q?NIHMmElZy6IGWNXd0TKorcjZLoam6vdqXi2KIzEDqV3glVBlGs9lV7L5/veH?=
 =?us-ascii?Q?QUNM9y+rhNevBdGvbsMbuXmboRSBVC8APBPnS6DW7G2SunZXMEfnTMmuGWP5?=
 =?us-ascii?Q?S2849+MSNxVV9U9WdN0JYCxNWuafny34oh+CPh9omTUmqf6U+OCr2o9pdPSd?=
 =?us-ascii?Q?TxdT5Lcxhlj3OVK8hfLwqoQ+FiDO+CI1Gjq76pOq+bHdX7n+26b+vtwltSw9?=
 =?us-ascii?Q?xpKLk+tSlvXEOgbMBrtITk9DCKO9FZmMlMfh9CoqfwM/Go+WDol2Fq9fTFLX?=
 =?us-ascii?Q?2os8cxRknuBSkuPKBEwgCoytebEuaHDVpUctsK4/l8eLuBGufRcUfk5gu8kA?=
 =?us-ascii?Q?omkTYakHlQ7dwP+CV2F/wEx6F5Q7Y9rQkAswwQ1R6oJ/cWHX/ZCfk6PzLFnF?=
 =?us-ascii?Q?lq2xS17Vh5vwjTMAaU8sryP4CVv7pUw8ZA88tXIC+DYE7/FDOu+dbie96SZJ?=
 =?us-ascii?Q?EqMAUE7l3vRH2SXIqBjfddSq8jNUN3dpHNPcUqTjVmTs8/0/0M9FcR3npUof?=
 =?us-ascii?Q?pMc93cFhGhY6fWYPKzNUYzA5w/4VyO4Qg5CYapwKIXgaKplRpRCLEVyhF5Ys?=
 =?us-ascii?Q?NigyXsZJtjmugsEZGfLA9gDZ5ts2FRaAYfY+cznAEr8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a61a97-af29-40e7-391e-08d89a084dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 16:59:32.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H92QaUOapnsBEzVy9dr3DfXLlzEtTswHmw2TqeVH2LSWgWAjBgdppW4lIaO1laS8AGoExy1VZVTWeTl5m5eWh0TFIh/5b5gh4pBiVrqhx54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0144
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, No=
vember 18, 2020 6:37 AM
>=20
> __vmbus_open() and vmbus_teardown_gpadl() do not inizialite the memory
> for the vmbus_channel_open_channel and the vmbus_channel_gpadl_teardown
> objects they allocate respectively.  These objects contain padding bytes
> and fields that are left uninitialized and that are later sent to the
> host, potentially leaking guest data.  Zero initialize such fields to
> avoid leaking sensitive information to the host.
>=20
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 0d63862d65518..9aa789e5f22bb 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -621,7 +621,7 @@ static int __vmbus_open(struct vmbus_channel *newchan=
nel,
>  		goto error_clean_ring;
>=20
>  	/* Create and init the channel open message */
> -	open_info =3D kmalloc(sizeof(*open_info) +
> +	open_info =3D kzalloc(sizeof(*open_info) +
>  			   sizeof(struct vmbus_channel_open_channel),
>  			   GFP_KERNEL);
>  	if (!open_info) {
> @@ -748,7 +748,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channe=
l, u32
> gpadl_handle)
>  	unsigned long flags;
>  	int ret;
>=20
> -	info =3D kmalloc(sizeof(*info) +
> +	info =3D kzalloc(sizeof(*info) +
>  		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> --
> 2.25.1

This change is actually zero'ing more memory than is necessary.  Only the
'msg' portion is sent to Hyper-V, so that's all that needs to be zero'ed.
But this code is not performance sensitive, and doing the tighter zero'ing
would add lines of code with no real value.  So,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
