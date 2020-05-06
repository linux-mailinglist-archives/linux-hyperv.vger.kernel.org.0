Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE251C7891
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2020 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgEFRtK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 May 2020 13:49:10 -0400
Received: from mail-bn8nam12on2096.outbound.protection.outlook.com ([40.107.237.96]:13793
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730086AbgEFRtI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 May 2020 13:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPZRF100BOlH88B84Isxq/s1Mi5A3RhX9bXgXxbChvxI+ZsGp6mWp7/CAZwSntBfD2GQJJsQYQE3m/xA/Uvrx4stKoT3aJZWWjlupwPuByXWMbFCzvoolXpHg6arkoooVONx/G8QZXUpDHvGane0vYqaO8/cIp5GzPGJIKDjvm3bEA/2F3SBmz3jFCGbTGCD6xiWD2UzBX5oT6G3mAixEAPnl8z4CPqK2sHuqEDc7bs3UlQkimfWqalur6C8u2ddaamhqYl3WME99RDV6aLNg6tF6ry+i5S+QCWWl27w7gf3hvepidfC7eTO8EvHyi/TYEge5D3nmzNSsYjue8JHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA/RO1QiGRQrx072R+/N02IPuUeey0ZRUNl7BD+XDIU=;
 b=RHPwBDbGlmSapDBIEUrfR7lg2SUXXELdrvha4zxcCX3A7uqC3MoZnACXvoCihZzDBwke/3GcHYsjnj0VYv+U4blJILua4hPfSQPXNyFeC0Bj/0DZD7gmfLoNu5+g7MSPqnovCdp/mPPsE908sH2fzBDnrwhyjzyhbnab8+lnnv/5pkAy/CGZZr7q6fQOawhyW/AoPWEiPHSN2Aw52F5N54XjduARIua20uCewU15hB9QM1tXUhvKueAbsnOIGibPUEmPDjY7rBpVP8Pr458TcwU2EjPfp2tIWTnvgb9YCxvC/oche2squ71w98rtlXS+M4SaDnpiRvruT0s0WvmtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA/RO1QiGRQrx072R+/N02IPuUeey0ZRUNl7BD+XDIU=;
 b=jaOdeQ9ZUBm4zw6yV3UDCoQQghS9fs0HBn1rh0fQ65JLyB5jSC5fvXrkBU/derZGZL+jd/+GNIzYOhN1LJS1vQNxK/7/6cHi9KZ9tFFi2bHPvjYM60TVgqwWy2a3FAygnywT/3z9kxszvkfn/GZl+f6fhs64nWUQtwmWqgn1a+k=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0891.namprd21.prod.outlook.com (2603:10b6:302:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.10; Wed, 6 May
 2020 17:49:05 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%5]) with mapi id 15.20.3000.007; Wed, 6 May 2020
 17:49:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH] Driver: hv: vmbus: drop a no long applicable comment
Thread-Topic: [PATCH] Driver: hv: vmbus: drop a no long applicable comment
Thread-Index: AQHWI8CKerzRxJCJrUmcevNBXmtiR6ibVZnA
Date:   Wed, 6 May 2020 17:49:05 +0000
Message-ID: <MW2PR2101MB10521E94593C54B9E806CCBDD7A40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200506160806.118965-1-wei.liu@kernel.org>
In-Reply-To: <20200506160806.118965-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-06T17:49:03.4277014Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7717b587-6875-4647-978e-e3c84aeb45da;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cba79f8f-341f-46a7-7465-08d7f1e5c51e
x-ms-traffictypediagnostic: MW2PR2101MB0891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0891CB7544A35B0F1BB20E31D7A40@MW2PR2101MB0891.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNz9GNG943XJh/L3oLJ9FSlA4Dd+hjMlUF0n2MBo/1zoTy/XiPF7XgZZ/ao6EHhBvzMFdbMaHDc5RRntnaOmPJzvIQOatRjwSxpti0nv9ixGJeE2Bfp0vOpYx4bANhkpQ8N7lcsxeSFJzij33YEy7fU4yWfezTtk/6xGU6eskZBJZf2clVCHkB7SF+o+kIdMCZg7NURML+9cvsaUYl6A0cOJMR3k6jrVtspEIYww77Moofa/2cBEvGrMcFoqS8dISMCLeSnplDqx3Hn4p89bp1YUKTtlCTEoOiFGw7O1SXaruovm9LfGVpm1wMmtDry5BJ/yND7qlyQ7sLQpa2pqPemwUteuW67cGlpzc7q1J7CmvOudiuiVNzpSkjk9Zl8a9OBvZro7VkzpNYm/4wOIsm9T40pcFu32hxVp9ZpuuiJLRIDmXUm2vXY7f2DL2Nm2rTYp6CouHbrYyGHD2iSbluLoZJVYLjnluHNlaWEuAPg27f1uVNhiVaMDxSdNIQaAWXYgnsIl4usDtPROTzma1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(33430700001)(186003)(6506007)(52536014)(316002)(55016002)(26005)(2906002)(9686003)(86362001)(7696005)(71200400001)(82960400001)(33440700001)(82950400001)(110136005)(5660300002)(54906003)(10290500003)(8936002)(76116006)(8676002)(8990500004)(66946007)(33656002)(66446008)(107886003)(66476007)(66556008)(478600001)(64756008)(4326008)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bCTs2hphCdyM6PFHsbc6Er6WyRWzoOTGjto9LPrOjKkTGMHobtfChfsdC1phkZiUWsTJ2PYGX54RExrkAlpb3pBqBvyvBM5jUb0ReofPyESYOXj2BSp18PQGCL/B05WcTv7/hfobsxZb4SdC95hJgWMmG4KqVUkHT9jH9mjZuMvLH+ozBkjzbr9siGHQ8D2oUV1uZ2HHI2ZT6R51AU0ckvnSIkPv6OSALOymyctSS9/yPSudibfQxbyZ0hIi+ZXvpZJkA40gQ3RYBmk2MD4t42NY1ZFcLAZwTZ8t8eGwZmTYDEWl8s98w17x1Cc5uSjM2Yaadw5oGgmCWiRh+Ug+uLWZLt6SChbXFSdXPjff+aPX49TgEw6qurpI0Ko9To5qaod3uEv/JTLIeRln02m+bIjllJLU5uf1Mz+yeFE3dcxpQOaX0uV10D2sXshRALahOfskD7S85sopFupT5267iwOJeb+zZo/+WUJpm2e6B8wCe8WVCw0yAjKdx4PA7ksq9QmXVAxHin0lwh2ku4Vd4qQIwPjXqaBqcl6DZC3TToT6Pg6LdZNgiQmWU9eOqklCOdNfkEXw5Zzuuai1AZC6IyfTYj3y5QjXlKjMuzYUkThw0/NE1oGUTLWRe4XD9dpaNgcOtzOnUhjpMlkQGUwdy2Kkl4p4viriJCv2qPqgSW+xmNt5Lw5vt9wyN6JfbzS3OPv/8QTCK0DVA37gZI7F83WFuXWcVteWhfiiS5qiC/CZLU0unhZr9bXfAZGOonkKMyvMA43O0JzbydaR6ngaHL4gqeOv/RnOPJxlGTIp1kU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba79f8f-341f-46a7-7465-08d7f1e5c51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 17:49:05.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txwkPVYNqgQHtO39YAR/GpJ0yotp2qdWWRUhXgrtkeVh8vuGolY2Mad0KtcNKWfY+o1lIK6YAWrMJZCXtMe19bKujJ4Ee2ptxmJX0cyd/FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0891
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, May 6, 2020 9:08 AM
>=20
> None of the things mentioned in the comment is initialized in hv_init.
> They've been moved elsewhere.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/vmbus_drv.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3a27f6c5f3de..7efdcadc335e 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1396,7 +1396,6 @@ static int vmbus_bus_init(void)
>  {
>  	int ret;
>=20
> -	/* Hypervisor initialization...setup hypercall page..etc */
>  	ret =3D hv_init();
>  	if (ret !=3D 0) {
>  		pr_err("Unable to initialize the hypervisor - 0x%x\n", ret);
> --
> 2.20.1

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

