Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAE362389
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244908AbhDPPHw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 11:07:52 -0400
Received: from mail-bn8nam12on2138.outbound.protection.outlook.com ([40.107.237.138]:51264
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245035AbhDPPHt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 11:07:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn2HwbwGZqThMm4IZtmn+BTq3n1AF6vIAasU3f0GVmj0Rp8wJhn49Qr9wHnvPf4JoS8psuL2I9erE04jbGOQ7KLnGG6yiGqNbSG8rTYUvUpAyufshO6ADFTjIrM3hyrHN7n4CwI9O08iHwL8QaTjSOlZjI5u69cjqcwKUkPfn3cGxQ65NWMpbzy0aOCHLh6KFaKGZZz6Q/bWbmEBgPRuvRccWy7iPe1BWT7S2Ob/zGzTik2IXGOzDsy7q5aE+Rf9g0lN6PqNipXizeRjW1uclIfBXmoJC9XwWwJz1Wgxdoy469dFDtzmsMNyxL56GkZ6n0pD3RqAHdLXEStmnao0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XrwkC2y7LZo733d7qmkIrbk3BdeLDhODkxVJqSkOaw=;
 b=hwZKP82kPQ21TaGwOiBkVG2oCjAy14I/qQH+TiOfW6c3uwymd1/rUaIrQKjzvcQsew+gQL1ekXYkgf/hvHqBZK1v8o5TTeRGBpNc6PaIKID6N7gB2zWylpqMczUAp23Bz49YOLSIS9QQGYnB3d9uPUwu6k1ZonH+GsC2zb3Psx+xa/FOZjR8RLHTh1VEigfzhelq5Y9NR0R38wcBwaPwPUyMo1nIt2bVbo9EY7nJqWfOpJz5l38VIt466H8yY7QwlQEZmGtbxhM4N3dY6GpXFiw9ZTT3qTrcEwjGetr6oexxbg2G+UoPtkYMqb+Thu/Qswm9bFHB4ttKa0yzoNNYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XrwkC2y7LZo733d7qmkIrbk3BdeLDhODkxVJqSkOaw=;
 b=juzTpADxIR9gUQUqqPfdVa2iKYJjNvy8W4GmuVRYHF6smzNJSL5uTb1luwUluOrCc+LQcdI8WA8joCEuDXciMq8gD6Smyfvwoz6ZdqnWVeju2BJlngVsqdwHf5V6Ht+kL3reeyv3jpMyrnSnSBbWQXX7RT7ARs3nE3z4xBVbBTU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1954.namprd21.prod.outlook.com (2603:10b6:303:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.5; Fri, 16 Apr
 2021 15:07:22 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4065.010; Fri, 16 Apr 2021
 15:07:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] Drivers: hv: vmbus: Introduce and negotiate VMBus
 protocol version 5.3
Thread-Topic: [PATCH v3 1/3] Drivers: hv: vmbus: Introduce and negotiate VMBus
 protocol version 5.3
Thread-Index: AQHXMs25lUb45khFzEy+rtQkHPaX66q3Pn2A
Date:   Fri, 16 Apr 2021 15:07:22 +0000
Message-ID: <MWHPR21MB1593E28A4E7CDC94321BE341D74C9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210416143449.16185-1-parri.andrea@gmail.com>
 <20210416143449.16185-2-parri.andrea@gmail.com>
In-Reply-To: <20210416143449.16185-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=014c363c-d800-4372-ac59-083545c452e0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-16T15:06:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d72f2643-da03-40c6-5e40-08d900e9562b
x-ms-traffictypediagnostic: MW4PR21MB1954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB195437715492F6AE88A3A8BAD74C9@MW4PR21MB1954.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b989vwEyJygbI3hPatL9pze04cSc8Nk8zav/LGQdZK+pCoviMpfTvZG5GnPWwMjZpB/p7CObaaCmMDTvBgg7757o8qo8iQ/CrS3Fa60NY+XqDiqPkz+acgd+kLbUUH6PZaVP3RRiBmHF2xxt4WNI7KFR9nP+QSI6auQMHvCt66dJHqPJz8p4IqLQHLYnIal8T7gZQQfhMtXHUIzbv2AjPNC84Scx6TBL6g/m+De3kREicLW/ygvtrEQUGFIMyVHsJSq2S6XTmh8dG+K3hElzWj7auK1tHFXyfoMMPbRr/08IiLKuK/pzEsrqb3gFGcijN89cWuke06y12Mu08YF5GVmEMuAzrLR7rkJTkkUXgPf2gf2pNoA1mcepF7h4RMgwzhNnQFrCgShdA3CBhH6TfXD8yT2FxfgYzLOOIzU26+ihJ8+hWQMEXtCl9RR/XmWYOHGoMDnPLGw7m4w2HdlqIsB8iut/HD8cUesWWvYNLZdb6832UyB8ClK4RKnrTm9aW2vFW5qzK+3mMfVOONAht31TFnTgNTFWRtLfAqW8QtqGfQxNyMsiEgBelFf5Oz5ZPW8p+fdFbQesUOelJweuR5kTAjd535riAEFO+B9LWEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(64756008)(38100700002)(186003)(6506007)(66446008)(66476007)(316002)(82960400001)(26005)(8936002)(5660300002)(82950400001)(8990500004)(478600001)(66556008)(55016002)(83380400001)(52536014)(9686003)(2906002)(71200400001)(86362001)(110136005)(76116006)(122000001)(54906003)(10290500003)(66946007)(4326008)(33656002)(8676002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vdMESjsM0k5oxfpSDklSHVkJnXoNkmDJj9/f08KEvkJ5OMgwScXEDftB4+wb?=
 =?us-ascii?Q?xvo9e/LXONC1+EP6FtXqL+EB4FekbgWB2XKl3ITl79Lu9BDmygIKrjKdrhC8?=
 =?us-ascii?Q?jI2Urn4SuZFog7Fl4Ry2jjixK6B1ePrbvcl3QYoVG91XioGZ9IF9RhzjPmVu?=
 =?us-ascii?Q?qeqUFTjjDB0Nqes+5J1BkDMaqMJ6dQgAt7lGFpGAKdxDUeTHFySbySCF9FIu?=
 =?us-ascii?Q?9MdLXi/uN3nO5Bfj5BDW6in6WR/mlDwYuB8UKgdwwpzjS2cNPSfvAbfxkSN/?=
 =?us-ascii?Q?9890seiMoqdcBF3WP1ssaMcGraRcf8OdGVF6QUTRav71+ExEUS4DIYtqt6Y3?=
 =?us-ascii?Q?t8OjymGjOx/UYQtcJtlUk4gBhN3cPtLD9dbxpNxx6Nv1kEBivQN/Bfpz6f1C?=
 =?us-ascii?Q?hAkhBP7cuiOTeaHm3sh70I2MsCgZNmn0IuM2hzBtpoexH0PoopGTgbI82NuU?=
 =?us-ascii?Q?7LVk4s27aQyzus2Z64w78RskbsvshjYGrjqfE7m65shXEFaB+jb9T0rNaqN8?=
 =?us-ascii?Q?VousSvc5kmXuyTsLavbhNNFdIVQga6NxaliAZjLE6xLVKyj79L48V32PByr4?=
 =?us-ascii?Q?bGiCFXp9OKiPJzXcAFbHt0XG37weVEoTiLaTd/5joiboK01MusGjcCd9efW8?=
 =?us-ascii?Q?Ze0xDN4X0NHGMLDPozXxWlkm3kLbNG47w/wE+daf85C6J3iBAUkNLjUb+X+H?=
 =?us-ascii?Q?pIsAYhXgfYa6gV3DoycvvEdAMaav39NFnSla/05G59dachCsqASGQ2HBnvQw?=
 =?us-ascii?Q?20BLsJwLMENVLTj6lQCfH0dhdQkoTHK1o9/MDoeLm+ZhSX6Zt1CNOiUAOkaw?=
 =?us-ascii?Q?BKm9hn2DnL02woZMDMsmXU8BTZP51Sf366k57J6A0Xm7pxDvzeGJrRTJuIk3?=
 =?us-ascii?Q?RaUOZRTGztk9/8XP6By3vuRx4rMDvk5uSj161tKLjQNy3Crfl3XEvdDZfkh8?=
 =?us-ascii?Q?CnwC74MQqFTYlQCF7cGNyjwwraJsbTyTPKz162GGD7e8vnuFiofnwhjWB6M4?=
 =?us-ascii?Q?FbtmqcZw6q4sifrQPscQWwoNPbkQevU5l1aTw5Q/wkqs7oK8n7BiYdyrfIMr?=
 =?us-ascii?Q?gwN7pTCqI3EYo1SGfxK+Rz24U0AtEQE1mI1y8RBXXF7GcuY3pfvanVRwzl6u?=
 =?us-ascii?Q?gj5M4nqfLYv8WTQx5xI/J+o7N1sVlhVCS6HZiTKcM1eVQggJ0obF2xhSQnE4?=
 =?us-ascii?Q?luULdqs9hFmRROrA7tkG8mDz52eva56QpH8KedlPD2AWI6tALW0drynxE/5V?=
 =?us-ascii?Q?++o5bENewpCb87gKzcqI74TUw+D6qirndtg+mhPW2hNmOAYRo9KemJBvftJx?=
 =?us-ascii?Q?layTaM6uUGDcwVDjRPdKHEg4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72f2643-da03-40c6-5e40-08d900e9562b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 15:07:22.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWSVgi73DvOWRRcUz979OqCjECDm1CBYyb6mzTJVgTpnmn0VzbD4tYM4T096d8jpW4GALyh8pfY17FoaYZ4wsGirh/L7+igTst371A8YR2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1954
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, April=
 16, 2021 7:35 AM
>=20
> Hyper-V has added VMBus protocol version 5.3.  Allow Linux guests to
> negotiate the new version on version of Hyper-V that support it.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 3 ++-
>  include/linux/hyperv.h  | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 350e8c5cafa8c..dc19d5ae4373c 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -45,6 +45,7 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
>   * Table of VMBus versions listed from newest to oldest.
>   */
>  static __u32 vmbus_versions[] =3D {
> +	VERSION_WIN10_V5_3,
>  	VERSION_WIN10_V5_2,
>  	VERSION_WIN10_V5_1,
>  	VERSION_WIN10_V5,
> @@ -60,7 +61,7 @@ static __u32 vmbus_versions[] =3D {
>   * Maximal VMBus protocol version guests can negotiate.  Useful to cap t=
he
>   * VMBus version for testing and debugging purpose.
>   */
> -static uint max_version =3D VERSION_WIN10_V5_2;
> +static uint max_version =3D VERSION_WIN10_V5_3;
>=20
>  module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2c18c8e768efe..3ce36bbb398e9 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -234,6 +234,7 @@ static inline u32 hv_get_avail_to_write_percent(
>   * 5 . 0  (Newer Windows 10)
>   * 5 . 1  (Windows 10 RS4)
>   * 5 . 2  (Windows Server 2019, RS5)
> + * 5 . 3  (Windows Server 2022)
>   */
>=20
>  #define VERSION_WS2008  ((0 << 16) | (13))
> @@ -245,6 +246,7 @@ static inline u32 hv_get_avail_to_write_percent(
>  #define VERSION_WIN10_V5 ((5 << 16) | (0))
>  #define VERSION_WIN10_V5_1 ((5 << 16) | (1))
>  #define VERSION_WIN10_V5_2 ((5 << 16) | (2))
> +#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
>=20
>  /* Make maximum size of pipe payload of 16K */
>  #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
> --
> 2.25.1

