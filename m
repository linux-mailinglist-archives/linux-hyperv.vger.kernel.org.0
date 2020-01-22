Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA8145AA6
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2020 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVRQ1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jan 2020 12:16:27 -0500
Received: from mail-dm6nam10on2135.outbound.protection.outlook.com ([40.107.93.135]:46688
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbgAVRQ1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jan 2020 12:16:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaYTM0hVUjXQgO/x29Kd5UJQSFIOK2S4LbtvVMIsuLALay7dQKexsszhmTSd9Kj4TzPlxdrXXpGsdu5AaoTyf8yW538PiQt9T9yWIRB7EfZCYEi64t1pcwez8yr94Spqo2UTvh5BKw86jitHz4MEocztOMZw+//qVTDqrT3Z7clK755iMLLyqbpAr433njHvuwDmSwJ89XsudioqTT0qDd99oBPNOi1E7FhDylkaYBlXqRz0qXqqNHLpijqPgLubpLT6IpjOGKWe6glm6eBmwSfnkoKKttbxYnznw4BoNgIkicsyk4f0xc2OyW738ZO8rsFVY8lUSsDLmV2s/d+WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w/Lx95NUCSZ02ODeVYLtWY5IoyCu9UMu2Pb1f7hYs4=;
 b=mpGnLlHxoDLCWYWIkyLT+yJs6B4aTycjuRqZOUk96ykXm3JemBBqhs56KtP2tKz1ibwNBu3agQ0jd+/VtAJws0FLfciI3VZxzRkhavwlaUfgWd1jXaFO2nISZpMOSd2oIv8kzLRZ8go8ocHAzn8pNK7L1SOjt3ycummkWtrUMWO8M15gwIriZRcyTIrQwNrW7/Kz+FdYdz+jY+zxSbV+LkTcyITabiZszmYbM9MZz3rhlxohvUS73x+zP+DotRCQv9djKgFD+jFG4q8x1OmUGXLxRj7dAv+qOJ4ng5gz4rBnxYqYmbCx6D0zFe4aRUPDXe97iGQc9/vkygXbTfGZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w/Lx95NUCSZ02ODeVYLtWY5IoyCu9UMu2Pb1f7hYs4=;
 b=UKC9ia5buDitk1ECJd8xOo1SATsE46A4kfGffqWA1h4P11J/btj6qNzSlKoSGnsyo94s4bEe6NirrImRGHURXZp4B1JHs3c6NjU7DO7FJsmi8DK0r56svKjky+fmBt0/AunJO3JKwmbwHnYSg86ur8BupBwp0qs9GDRGjKt9XcU=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (52.132.128.16) by
 DM5PR2101MB1077.namprd21.prod.outlook.com (52.132.130.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.10; Wed, 22 Jan 2020 17:16:20 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43%5]) with mapi id 15.20.2686.008; Wed, 22 Jan 2020
 17:16:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] hv_utils: Support host-initiated restart request
Thread-Topic: [PATCH v2 2/4] hv_utils: Support host-initiated restart request
Thread-Index: AdXJ2v+CkGXQwSJARV+SWgYtZDG50AHatmlA
Date:   Wed, 22 Jan 2020 17:16:20 +0000
Message-ID: <DM5PR2101MB104763C3447F4BB9C163F8F0D70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <HK0P153MB01487F54363A856730BB13FDBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB01487F54363A856730BB13FDBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:30:56.6858983Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a12eb12-6152-4624-a9ab-f6645601545c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8d4f4e2-0ff7-49b8-a241-08d79f5eccdc
x-ms-traffictypediagnostic: DM5PR2101MB1077:|DM5PR2101MB1077:|DM5PR2101MB1077:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB107716E02B7AA1F07778F490D70C0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(8990500004)(64756008)(66476007)(5660300002)(52536014)(33656002)(66446008)(66556008)(66946007)(110136005)(478600001)(71200400001)(76116006)(10290500003)(316002)(81166006)(55016002)(81156014)(7696005)(9686003)(8676002)(8936002)(26005)(86362001)(186003)(6506007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1047.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dm+WHFu5nCp9mf/g7JKmfheIqOwo9EdpxM2QEWl7c5QS8gVF8dymbT99B8Vm9ThG1RVtmcgrVJAMoTtO7cDL8tQKYn7ORHs/ua6UI53UdAU0EHH9N9Fa5hiGn/dJ/gzJPIKu2gEJRXNmVsSDTl2xuN+n00HqDVzU9y1aVSn7utHEgYpjf2ShwOPsOCRTUJNRbkXcSn/b3cl4EjYbAsj+TeMjcneQrPFSRZ0lYZDtg9+s0DZnywVII/s8sdXTRw6tliYlU/3EsiC+s6zyTQgkJsMCMYqA4TcXV9JBCDqqYtw3ATVYmfk5MVBSoHKU4CB9DtbNSF2Whpw7czXBHsbJ+1OvzvKSHffvg9VHa1q+zbjAqHaD092x2Jg/kQBjURoAjI+mkSinmTWe7ANXOK5amjszdhaC0ML1HPOlScjNV5PM3zSciEnSWp5GoM0xdvPt
x-ms-exchange-antispam-messagedata: UiGCXVM3BkXjA4EmN0iAMfrKXzadmyCaiopv/UaFmB4l9/w8wtldtj8f13gEtPS/K8OLf1G5WLUkjgtWf6UOs/Us/WrorPDIi1EBHWFaBCxpQxVlUXVmvyGnSmivMTqYWFAuGXZ1GVUPNTVOpTdn5g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d4f4e2-0ff7-49b8-a241-08d79f5eccdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 17:16:20.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQ4uulRxbva365MattPqNy0P4l3T+hiwZo4GT5ttJwSO15ly+9wnfngse5MftfIGnZOC1qVS6z5zRd3/4Ubq7ScBLpHfqBn4qZthrnfJ2DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, January 12, 2020 10:31=
 PM
>=20
>=20
> To test the code, run this command on the host:
>=20
> Restart-VM $vm -Type Reboot
>

Need a better commit message here.  How about:

The hv_util driver currently supports a "shutdown" operation initiated from=
 the
Hyper-V host.  Newer versions of Hyper-V also support a "restart" operation=
.  So
add support for the updated protocol version that has "restart" support, an=
d
perform a clean reboot when such a message is received from Hyper-V.

To test the restart functionality, run this PowerShell command on the Hyper=
-V host:

Restart-VM  <vmname>  -Type Reboot

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/hv_util.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 766bd8457346..fe3a316380c2 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -24,6 +24,8 @@
>=20
>  #define SD_MAJOR	3
>  #define SD_MINOR	0
> +#define SD_MINOR_1	1
> +#define SD_VERSION_3_1	(SD_MAJOR << 16 | SD_MINOR_1)
>  #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
>=20
>  #define SD_MAJOR_1	1
> @@ -50,8 +52,9 @@ static int sd_srv_version;
>  static int ts_srv_version;
>  static int hb_srv_version;
>=20
> -#define SD_VER_COUNT 2
> +#define SD_VER_COUNT 3
>  static const int sd_versions[] =3D {
> +	SD_VERSION_3_1,
>  	SD_VERSION,
>  	SD_VERSION_1
>  };
> @@ -118,11 +121,21 @@ static void perform_shutdown(struct work_struct *du=
mmy)
>  	orderly_poweroff(true);
>  }
>=20
> +static void perform_restart(struct work_struct *dummy)
> +{
> +	orderly_reboot();
> +}
> +
>  /*
>   * Perform the shutdown operation in a thread context.
>   */
>  static DECLARE_WORK(shutdown_work, perform_shutdown);
>=20
> +/*
> + * Perform the restart operation in a thread context.
> + */
> +static DECLARE_WORK(restart_work, perform_restart);
> +
>  static void shutdown_onchannelcallback(void *context)
>  {
>  	struct vmbus_channel *channel =3D context;
> @@ -166,6 +179,14 @@ static void shutdown_onchannelcallback(void *context=
)
>  				pr_info("Shutdown request received -"
>  					    " graceful shutdown initiated\n");
>  				break;
> +			case 2:
> +			case 3:

How are the flags values 0, 1, 2, and 3 interpreted?  Perhaps a short comme=
nt
would be helpful.

> +				pr_info("Restart request received -"
> +					    " graceful restart initiated\n");
> +				icmsghdrp->status =3D HV_S_OK;
> +
> +				schedule_work(&restart_work);
> +				break;

For case 0 and 1 (shutdown), the schedule_work() call is performed only
after the response packet has been sent to the host.  Is there a reason the
new code for case 2 and 3 (restart) is doing it in the opposite order?

>  			default:
>  				icmsghdrp->status =3D HV_E_FAIL;
>  				execute_shutdown =3D false;
> --
> 2.19.1

