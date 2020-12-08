Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559D52D2FB5
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Dec 2020 17:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgLHQau (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Dec 2020 11:30:50 -0500
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:31072
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbgLHQau (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Dec 2020 11:30:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li3HPu6YKFNDCb7385ifWatY0yW2VnJAuChD3OYJOKmtgM7b19BrJjFTobfc0PVT+330IJ6Upvf5uJQ5xDjb6XMwL3jteIZT0k5/lRVI2w8BN2A+AWXyAvCv5SP+n7ofU7hsjLUAaevv9AJVbbxYEyG12FbRaBEUVgk8KkRExo5c+lX6tXJNph+ZadRC//zB1SDieqmz4J0pwzqAxJYkB4u/sRFTl9/ZqJQia3D/yyQ6JddHpqzU6U6fklVKZ2ikGB9Abz7dwrwRgHF3GVo5BkyF5eWU8MSsWGrvRag3CQudtq8Mwu6m2tB64K/GO4O6m3K3QgA28KayS1DWJoZ5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ATqYt+i4EYKelfUq06susMRgdpqZ1TeGueMy2qmfR4=;
 b=acwK265NIx9ZS357mmvdfCW3d1Kw1xgzzKDxHWrQiLbE6Bm2QG1CVKlGlGGC6+dCWMhwHz8VXN67QeRaxhtZ464IoZI3BNTdI6YUAnzY0e36BpktTkOtR1fA5K25bpz7EDFXyZvwm21DyNGGjmkZirjTPzsi89waYCK9wXjqt0hGqufrbSBdwm+0sHgzm3LokKnj4QD054yf8p3n2+kidvKeWgzn3THWW5R1KSM+gt17YnOGDpZVzSS4KJD2Q8wqD4Q9Bkkzcxg41ktMw1CI1xeDqyuV+dg+41KhRARsdIzJbS0ve5utXjUM0iyvgnmOx4hLPXiKdwCZRTCPShOxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ATqYt+i4EYKelfUq06susMRgdpqZ1TeGueMy2qmfR4=;
 b=IJLE8RCeoGrJhnCD81geYoWFy3i0sUGsvIQJgN06GO6ZzdnWJH/VaY88sn/YIhL66JQ3U88uyr8tnFMq4NTp5Fb4hycyNsSlbdR3mybTmAs4zLa2hQ8galfZSVFEFzBn0AHOGjIzCwMuK4qjIAKVkgPdVIUfQToXkRPRub+7SXU=
Received: from (2603:10b6:303:7a::15) by
 MW4PR21MB1908.namprd21.prod.outlook.com (2603:10b6:303:7b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.3; Tue, 8 Dec 2020 16:30:01 +0000
Received: from MW4PR21MB1860.namprd21.prod.outlook.com
 ([fe80::bca7:6c8d:8df0:bfe1]) by MW4PR21MB1860.namprd21.prod.outlook.com
 ([fe80::bca7:6c8d:8df0:bfe1%3]) with mapi id 15.20.3654.003; Tue, 8 Dec 2020
 16:30:01 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/1] scsi: Fix possible buffer overflows in
 storvsc_queuecommand
Thread-Topic: [EXTERNAL] [PATCH 1/1] scsi: Fix possible buffer overflows in
 storvsc_queuecommand
Thread-Index: AQHWzWTRxBnrkVn9uUeS8hL1fcJMJKntYokQ
Date:   Tue, 8 Dec 2020 16:30:01 +0000
Message-ID: <MW4PR21MB186053CCB0D774831A3B9501A0CD1@MW4PR21MB1860.namprd21.prod.outlook.com>
References: <20201208131918.31534-1-ruc_zhangxiaohui@163.com>
In-Reply-To: <20201208131918.31534-1-ruc_zhangxiaohui@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b75e7c58-a8c3-47a3-b65d-0409b213bdbb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-08T16:24:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a27f:86b0:15a4:1ab8:b79c:38e5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ed09bea-5e5b-4b75-4a15-08d89b9682f2
x-ms-traffictypediagnostic: MW4PR21MB1908:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1908CFAA0D6CDC0DB1C49DFDA0CD1@MW4PR21MB1908.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AE8FUr9z+VCqtHCQUvaOqhevNyS6mFvmaXbA6cjNGTNYcd5odDMAH+nYcAmAOczUxNJpF+TD7ssGZSao1rjANw2u0pY0HZmKs/816WZvLvRaja5kUo0Rtc2hzlz9tVA7dmSdpA7/nCuLXtSzqX8XlPtmrgVIk7VXy2ipW1rNZa9gfiljg1q3JSgM2EniAsdqyy16tlufEnxDKsZfWUmGMXsuYzIZpc6wRBivUE+NIXTDb2BGAIOJNxGz9sebTCjXXeI4mTTGV98bCrZMsjw2pQItTmX79RdqtJQcT9UwhMyZbAoM487p5/nxk4lUNtaQpgasoaMBeGZ4JV+NOPWoLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1860.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(55016002)(9686003)(2906002)(82950400001)(82960400001)(10290500003)(8936002)(83380400001)(478600001)(8676002)(33656002)(86362001)(7696005)(52536014)(316002)(5660300002)(71200400001)(6506007)(110136005)(53546011)(64756008)(186003)(66476007)(66556008)(66446008)(8990500004)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UDXKHYS5r0J5XmNEu7ZqS23Rzx4CGwEXH/Vr9PZeO1oP8BSh/MQeYLgfbX0L?=
 =?us-ascii?Q?7F4yoUlGcqXtqbMRfUpsvdBFMTbxuVKuLLWEq2O+HcP1OS3ZW5CnKVl5VUiO?=
 =?us-ascii?Q?h3S46wN2UoSHRjco9RphBentlWROTXGQrQdpgSM+ef8zWZCBg6x7CmPNZSLd?=
 =?us-ascii?Q?VJu7sNschxBYicA2QD+lcRewyUaHNpx/LmxC3P9qd9OGXEcXFbFE3F4QX0hC?=
 =?us-ascii?Q?qGmGHC1aF2rk+Chh+8h1RtnjTmYFd4G0ahIATI3kkBYBa5BwwwnBhExT/4wl?=
 =?us-ascii?Q?y3S3Q81iT+itSFfT4YXl14PYWGZE3Wr6PObwDHYQewUPjzBFeoByPBASCygB?=
 =?us-ascii?Q?aZ4NAlXZxRYFNJSiz0JTs5jh8TAcT4EQGsFcoayHTwYLVPJfa1ZSnbYbrh+5?=
 =?us-ascii?Q?3fkziBSAzPIqKWZUPHxm2czHM9JyfU4KJQ+CtHIKrP5HlFwrT9iVxZJJf5SG?=
 =?us-ascii?Q?dKfSzZQEWZ4XzAhHHm30lrgPxr+EHYRveSa21c3ljeVYLlAInfpiqAYKEUE6?=
 =?us-ascii?Q?IXkFF90IlRjjrL4xIMFj5UAUcEBSLxKRcNYGwvLYXrjK5SjbAucJs5b1jzyq?=
 =?us-ascii?Q?TeI0jFxVfQp47ckRdMaKBJbbmM3wwawurOFW4lQ9dEv2o56YymwHyGe6ITU4?=
 =?us-ascii?Q?0nOp4VS05/rtKwnOsw4VlXa5AaOPmpsKWM1cJ7eLGxwse55yajNsX7miT0cq?=
 =?us-ascii?Q?6/uwc22K0wr2cRuNuLPm9LDhx60RunmBA269d3NQJUnsCdH8QpTVB7+8zdK5?=
 =?us-ascii?Q?CvBUUxi0WLYYNKfbSJ7+cDKuv6FaMUmGiTpxU62IkodU3DrN8sEIlsInrzDA?=
 =?us-ascii?Q?W0xQz2deTGcRmHvs3C7Fcm9jj4KvgJEIFAHsyF+p9mNpRH246KDhaKhgR6Te?=
 =?us-ascii?Q?FuzQPi8WKrcITBhf8NWZHosa/3AWVzDfpb1u2IpmryvdsDj4bsMewe5GegZ7?=
 =?us-ascii?Q?UlDdw7/0RiMQQxtLowV0My+Gpl1AVLnSALaNmqyYluCCnf3JMyrIUACSsMvE?=
 =?us-ascii?Q?EcNtP/Awz/7BgbWbgSo96u7KqSiG/6QMydF6NE5WlIRuN8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1860.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed09bea-5e5b-4b75-4a15-08d89b9682f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 16:30:01.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GW/7UNSfL8zXJIOGjffL3MZs5DptUmuQ+1+flcDXH6MymU0E55toV8pYo8hePt+xUPKvMB7iek2bOA69/zmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1908
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Xiaohui Zhang <ruc_zhangxiaohui@163.com>
> Sent: Tuesday, December 8, 2020 5:19 AM
> To: Xiaohui Zhang <ruc_zhangxiaohui@163.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> James E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; linux-hyperv@vger.kernel.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] [PATCH 1/1] scsi: Fix possible buffer overflows in
> storvsc_queuecommand
>=20
> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
>=20
> storvsc_queuecommand() calls memcpy() without checking the destination si=
ze
> may trigger a buffer overflower, which a local user could use to cause de=
nial of
> service or the execution of arbitrary code.
> Fix it by putting the length check before calling memcpy().
>=20
> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> ---
>  drivers/scsi/storvsc_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> 0c65fbd41..09b60a4c0 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1729,6 +1729,8 @@ static int storvsc_queuecommand(struct Scsi_Host
> *host, struct scsi_cmnd *scmnd)
>=20
>  	vm_srb->cdb_length =3D scmnd->cmd_len;
>=20
> +	if (vm_srb->cdb_length > STORVSC_MAX_CMD_LEN)
> +		vm_srb->cdb_length =3D STORVSC_MAX_CMD_LEN;
>  	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);

The data  structure is sized correctly to handle the max command length. Be=
sides
your check is bogus - you cannot truncate the command!

K. Y
>=20
>  	sgl =3D (struct scatterlist *)scsi_sglist(scmnd);
> --
> 2.17.1

