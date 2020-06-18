Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8521FF6D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 17:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgFRP3t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 11:29:49 -0400
Received: from mail-eopbgr770119.outbound.protection.outlook.com ([40.107.77.119]:4740
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731634AbgFRP3m (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 11:29:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkRypKB6kro3b6BgxefSRIvdo+ZiC42Y6SpdrODNizPuwlqcJWLo3C6whUQhAl/AwzFqrsHMg1v1wtZq+AQbaDltl9AiX4Ums7/NM4lpgTpe4FEC7UOgtfxyLyBbsW7D7fxitwV5b8jpW+2nWmJRV68Ikhe7485B0hP4XJy23GllRlUGSqooHml75OGriTZki505Kd8pKhScYqlpVVO/UCqa2N+3ifb3/Qtuc/lTMHqr/2qvD1XLZ34M5x0p3Xa94qfD2MvuCorcgPcpG8TyZ4xCigZqpzY/kjWk3ClTvNMuNa9tWwUsorpsEfesRgj1pZPqyCZsMZXm1miBqjmA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaFH/C6EUU/wUD2c1qkE1k1z3OLf44X07g0B6FlQ7JE=;
 b=RzVpBkojxzNF6JfKz6p+SEfpNs5pt7yroBxPxT2W69zsSoD/h179LkAZnVVi0hhUvIxTJnUZfuuYgAYlSLqXsJQB934k+7beMiKDU0SF5ZaQ8QPhJHhw02HaJoxiw55nauQxrW7w7dkFdQfGQQv87fqNaYKFdaYIGBL2WHCXg576FgoKRQ9VsDW3D+foXCIWtFjfp7oxsqHixwSNehV2AdHNPyqBcCtTpuzsesEFytDA3gft/I4cYEhV6UYWvOz0kV4aVNB5b55F+hVewCqxuWBlea+zvpXs7mUJlvwxOkNHWbhD2RJsU5lOxqVX+33n8Sbtedd5mygN9HgQBAEpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaFH/C6EUU/wUD2c1qkE1k1z3OLf44X07g0B6FlQ7JE=;
 b=Z/LjGSNC6grglNDdYwlYCHCfYnQNBWssaKf8RqlnnY5IVhr0zoiaxsNyuQZR8pN+z1eES805PR09V5Lt9XeQw8l74tOgf8evXdodG4sldiA4dBUlpmJO0lLv4uKECLmzQXxPIXztuA1ea1OtRmAYU9Hk+76QBZS9OEGDQ+ehYmw=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM6PR21MB1290.namprd21.prod.outlook.com (2603:10b6:5:170::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12; Thu, 18 Jun
 2020 15:29:39 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 15:29:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] Drivers: hv: vmbus: Remove unnecessary channel->lock
 critical sections (sc_list readers)
Thread-Topic: [PATCH 4/8] Drivers: hv: vmbus: Remove unnecessary channel->lock
 critical sections (sc_list readers)
Thread-Index: AQHWRMcPN9oLSAEi5E+L17Xv7AjRlajegHmg
Date:   Thu, 18 Jun 2020 15:29:39 +0000
Message-ID: <DM5PR2101MB104702727705ED512CE747F9D79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-5-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-5-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T15:29:37Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e7b4c0a-3dcd-4c5c-bea9-e14cceb6e120;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 116835b8-24e6-4288-c423-08d8139c6a53
x-ms-traffictypediagnostic: DM6PR21MB1290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB129075FF82E0C9614D66A027D79B0@DM6PR21MB1290.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NW5opoBbsSlVgz5KOrsoCXULqUG9yfJRGBNlh8J8rIbzTq0sbI4cUSAqdbGeIyvTJCfvpfzFN0TwFnUHC6xFZD8N6FahO/29A3n0p3VKQ9qr2cd6x01IWcEgVC48DSUsPNhX/WARqR0sbKFotl1DA09TASjNXxUDOm/U47tVeRMC26TiuUlIlC4ub4bOPUD9881o9GwNyJ0HsaumM6CHTR1fIOtrmXXhleYnlMdqXY//ICEHT/s19bwvfk3wsFcOGOoH5iDgKsdkCAt6kppVCt3L8tDrUtrAyVRZEILw2CWjx7+sLbBxHepQzxnkXaNjz45ikh86pk3V+nyLcUlEDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(2906002)(52536014)(5660300002)(33656002)(8936002)(4744005)(66556008)(54906003)(64756008)(66946007)(83380400001)(66446008)(66476007)(55016002)(76116006)(86362001)(110136005)(9686003)(6506007)(82960400001)(82950400001)(71200400001)(478600001)(186003)(4326008)(8990500004)(8676002)(316002)(7696005)(10290500003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T7Vvv+0tmofdnzi5kMt52OrCkkU2VC9BShQAeLlp2DyJ0PwT30PrxRwfa6s6Zi2v5Ha9AXMx7EtG4liG9fp0pTzJbzZhA4I/4s7UHErSjFQcoA7PmAb8batmGfNSkNepS/e8znI089zER/tXg+OoOmO+PYNVjmheVFuK7J+p/xNkgcTApmy2DuFRMWyWSYgGDVmwWC4+2zN6DYJ5Sg9Jx32jI8uTa5Dnt04R9St9U64XbCczPnaNDwrr1N1sso6kUu7P79FKLsQiDXhRHD1o83h4mG7q0b9ykNm4E4pm1k25JmoSxr3u2KsUTbztya5bFXJ7CiykQ0wgYGWzMZ9XlrKJXpiaPZTMXtcNxbLsbaM+EozJmU4Ne+XJjEhcLTAHdn5SrgCsjh1noRo66HxuQUG4fvhMofsKCOxXQJlUk5JXevjtXC8ITCk4A43p+pmXGN3Al+VOkf07ZONHV7g/co1zZhhGq1sJwml7GyEZAvZq0wpWkmOno4z/gphsJigK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116835b8-24e6-4288-c423-08d8139c6a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:29:39.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvoAW4fmyeBOHH+93YmnWoUtBnUO35XTJNHObHDkfBDhw9TWstmW4y9Q2TJs/zbv3SsFAIt8I64C9UKMg7t7Bn4puEGGF3b01fB+4KeubdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1290
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>  Sent: Wednesday, J=
une 17, 2020 9:47 AM
>=20
> Additions/deletions to/from sc_list (as well as modifications of
> target_cpu(s)) are protected by channel_mutex, which hv_synic_cleanup()
> and vmbus_bus_suspend() own for the duration of the channel->lock
> critical section in question.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/hv.c        | 3 ---
>  drivers/hv/vmbus_drv.c | 3 ---
>  2 files changed, 6 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
