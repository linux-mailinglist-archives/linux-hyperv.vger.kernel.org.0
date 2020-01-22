Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216D2145AF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jan 2020 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVRjE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jan 2020 12:39:04 -0500
Received: from mail-bn7nam10on2130.outbound.protection.outlook.com ([40.107.92.130]:28097
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbgAVRjE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jan 2020 12:39:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAlRvPtJrxJHbTn0JpDXbKWoNi/xND8ZyMnokwUcn+4eio1wyYDtwiqNR6Wo6Sq2wmok6Dthkcx3tFQaVc0KTK1XziPof4vo+5/btG8MaQydLDdDz5PzWsR0DveTPHVigkygPYLJS7AEUWJS5HZo7Utx808iwgf08ES+a8a3FE0xYYSZNX2/t5CIV2Su7Ox38zks/hIm5QhTHVk2UCIGPSiC+PXdfA5jjSExs+i6jXUiN9leqnAop+VTyUwBlkcTrPkTpkIi0xN3JYLQYgZWqMJD1J3kOeNOr75jM4OSnlB+Mf45W4ncWyyXH+jRjf/q8LNqkdRIrMjZzGSV35c2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvau2sdYtRvun9lo6J8TiuyF81YwJKiFnPM/v8rZqpE=;
 b=GaTqrbY69RPeYPAI+nU5gIPEMd47uBlZZgS47Gzg6Xxgu5wDBGqswlveFk7Ap3PSI3LLDh8roKM64wJeGl99V89AHOPatAgaPq4LpV2BEIenrATVFNwaeubCcTpEQ47q4IISfNcBZ4CMv9y6ngtRSnRv2w740OMyGCm1CiPOx1HgPKXvUWPf8okss8Ueiw98jgJ+jt7IcV5JvgYlzJ9VGL8BsFRY/AYTw9TuSEsWtdehzlhrLLKJUUJfgR1TztG1zYHlMIbZ7Ut9OhcnBxpTMd389+Umvx4H0Xhn3A9AFG59yZerlZxAQS4zukb+M36MfJy/60/LrBJ77JF1j1y0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvau2sdYtRvun9lo6J8TiuyF81YwJKiFnPM/v8rZqpE=;
 b=YN5t9SG/hDMLrlixLHVVyEpm3eSH8XzyvJEE/cQoVIQdOZcugqD3cc9HN5rOKyCWTPZ2cbFI0ZY64iR5292nty3LI2rALCoVVxzf4O09ZKEBv36cf8WC+AlInWuv6WzJz1UEmavMyWmyynwwiZ56/InqC5K4qNJusG7x4Gbd97M=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (52.132.128.16) by
 DM5PR2101MB0965.namprd21.prod.outlook.com (52.132.133.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Wed, 22 Jan 2020 17:39:00 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::6495:1ae8:e21d:3b43%5]) with mapi id 15.20.2686.008; Wed, 22 Jan 2020
 17:39:00 +0000
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
Subject: RE: [PATCH v2 3/4] hv_utils: Support host-initiated hibernation
 request
Thread-Topic: [PATCH v2 3/4] hv_utils: Support host-initiated hibernation
 request
Thread-Index: AdXJ2xmWH7nlZvI9QtW52nKT4iLjSAHbmnJg
Date:   Wed, 22 Jan 2020 17:39:00 +0000
Message-ID: <DM5PR2101MB10477532BDC475656FA3817AD70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <HK0P153MB0148FDF9A3AF2352544E6DADBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB0148FDF9A3AF2352544E6DADBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:31:42.4306444Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90e4698e-3fc7-43d3-857c-c415f1813480;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a2f44e4-82c5-495f-ed93-08d79f61f776
x-ms-traffictypediagnostic: DM5PR2101MB0965:|DM5PR2101MB0965:|DM5PR2101MB0965:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB096527A85E11CCD4F9726106D70C0@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(2906002)(110136005)(55016002)(9686003)(478600001)(5660300002)(52536014)(10290500003)(316002)(7696005)(8990500004)(66946007)(66476007)(76116006)(86362001)(66446008)(64756008)(66556008)(81156014)(71200400001)(33656002)(8676002)(8936002)(6506007)(81166006)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1047.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n74/xyRAMbif3FJJVxicgOuJ9X2stSCA0u3wxB+rrDAmC0UIAJb664JeS7uO4ayjcNRb3CFFIR379oKY2e425IdlBwl1m7EybP+Lk4wHAjKuXCkenmaW9K8KicNgjOvUQcJ4/wiVyXb0Am1cuzTsyzEzm5n36DBeEUUZaTQnqC2MNF9me34jUNOOTLK34X//JxFiVxudDAn51JOPAz3AoY8z9GVsYHRRCBONEvZM9SaoYZKDM5iHELmCKHr3MIE1bD5QFruI3aJwUqlfdmfLvV+oPIO/eJ/Wwb2CoPlz1PfKTvhrAzJOUUYKESk8xxcMlMxUesTpSCZsTjbujop2enp+nLGgwngUKFnP699414zHIpp7Jl/5uxw12O6nP+e9Rod3votC1xTAK0WEtaO8R7fP6MzHW68mge04WhHHUEjViR+KaNK0EPjh2uHBR6Er
x-ms-exchange-antispam-messagedata: 2jnn7VTRlxs1cYFFoHJgSxobCEVWkY4BChrQxihKuwuzmGyfI4gBc1kCiuYnyO4ooI2vKF5vRKPModM88wFA8B6ne/UfeqGMOD7XaeTygb3qz8RJBvnendQlu3lIRN6KNhx9R+2VRHylSAr9C6gEzg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2f44e4-82c5-495f-ed93-08d79f61f776
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 17:39:00.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HT9EiaBt/+8Q3KaaQ4BUzpQtvXc5znIU9JDgcyKwsKMB4c8d1J7AqBIhU0AN4qAx83w3DYU9U0iKLZJAOT17gBiwwgemC5kcY6/qzCRbEww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, January 12, 2020 10:32=
 PM
>=20
> Update the Shutdown IC version to 3.2, which is required for the host to
> send the hibernation request.
>=20
> The user is expected to create the below udev rule file, which is applied
> upon the host-initiated hibernation request:
>=20
> root@localhost:~# cat /usr/lib/udev/rules.d/40-vm-hibernation.rules
> SUBSYSTEM=3D=3D"vmbus", ACTION=3D=3D"change", DRIVER=3D=3D"hv_utils",
> ENV{EVENT}=3D=3D"hibernate", RUN+=3D"/usr/bin/systemctl hibernate"
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/hv_util.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index fe3a316380c2..d5216af62788 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -25,7 +25,9 @@
>  #define SD_MAJOR	3
>  #define SD_MINOR	0
>  #define SD_MINOR_1	1
> +#define SD_MINOR_2	2
>  #define SD_VERSION_3_1	(SD_MAJOR << 16 | SD_MINOR_1)
> +#define SD_VERSION_3_2	(SD_MAJOR << 16 | SD_MINOR_2)
>  #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
>=20
>  #define SD_MAJOR_1	1
> @@ -52,9 +54,10 @@ static int sd_srv_version;
>  static int ts_srv_version;
>  static int hb_srv_version;
>=20
> -#define SD_VER_COUNT 3
> +#define SD_VER_COUNT 4
>  static const int sd_versions[] =3D {
>  	SD_VERSION_3_1,
> +	SD_VERSION_3_2,

I think these versions need to listed in descending order, so the new
SD_VERSION_3_2 should be listed first.  Otherwise a Hyper-V host that
supports both 3.1 and 3.2 might match on 3.1 first without ever checking
for a match with 3.2.

>  	SD_VERSION,
>  	SD_VERSION_1
>  };
> @@ -78,9 +81,45 @@ static const int fw_versions[] =3D {
>  	UTIL_WS2K8_FW_VERSION
>  };
>=20
> +/*
> + * Send the "hibernate" udev event in a thread context.
> + */
> +struct hibernate_work_context {
> +	struct work_struct work;
> +	struct hv_device *dev;
> +};
> +
> +static struct hibernate_work_context hibernate_context;
> +static bool execute_hibernate;
> +
> +static void send_hibernate_uevent(struct work_struct *work)
> +{
> +	char *uevent_env[2] =3D { "EVENT=3Dhibernate", NULL };
> +	struct hibernate_work_context *ctx;
> +
> +	ctx =3D container_of(work, struct hibernate_work_context, work);
> +
> +	kobject_uevent_env(&ctx->dev->device.kobj, KOBJ_CHANGE, uevent_env);
> +
> +	pr_info("Sent hibernation uevent\n");
> +}
> +
> +static int hv_shutdown_init(struct hv_util_service *srv)
> +{
> +	struct vmbus_channel *channel =3D srv->channel;
> +
> +	INIT_WORK(&hibernate_context.work, send_hibernate_uevent);
> +	hibernate_context.dev =3D channel->device_obj;
> +
> +	execute_hibernate =3D hv_is_hibernation_supported();
> +
> +	return 0;
> +}
> +
>  static void shutdown_onchannelcallback(void *context);
>  static struct hv_util_service util_shutdown =3D {
>  	.util_cb =3D shutdown_onchannelcallback,
> +	.util_init =3D hv_shutdown_init,
>  };
>=20
>  static int hv_timesync_init(struct hv_util_service *srv);
> @@ -187,6 +226,17 @@ static void shutdown_onchannelcallback(void *context=
)
>=20
>  				schedule_work(&restart_work);
>  				break;
> +			case 4:
> +			case 5:

As before, I'm wondering about the interpretation of these numbers.

> +				pr_info("Hibernation request received\n");
> +
> +				if (execute_hibernate) {
> +					icmsghdrp->status =3D HV_S_OK;
> +					schedule_work(&hibernate_context.work);

Same comment here about the ordering of the schedule_work() call and the
sending of the response message.  Seems like the code should be consistent
for all three cases -- shutdown, restart, and hibernate.

> +				} else {
> +					icmsghdrp->status =3D HV_E_FAIL;
> +				}
> +				break;
>  			default:
>  				icmsghdrp->status =3D HV_E_FAIL;
>  				execute_shutdown =3D false;
> --
> 2.19.1

