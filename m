Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7161E1498CF
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 05:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAZE5D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 23:57:03 -0500
Received: from mail-co1nam11on2112.outbound.protection.outlook.com ([40.107.220.112]:33249
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729014AbgAZE5D (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 23:57:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0Qs/P4gLhvje5A5Qml1WrRzGISav1U7u1l1D5264IktS3FCValzCUahQj2wTFrd8ORfsCLlMswGtLSlXYu9jkRwNOll9cKISZTHqMyFwp9qZXK5l/lGR992COCf9nblicm3FjzkY7/trOe/V+knsR2N3UCnzzFau9GYME8hCYLnQp6+nAg6LyGztDtCko3RJXlj7L++xIDdsmNHvKgVNvWRXDy20S6I9XamQ5B1G+dTr0FwrOCFw6PloczA2kQmOBKQ4E/Th5+NQX1BTdkE8nc8taAw3XSJwfs/fyU0M6RXPdMiY1ki7Eh9qpRtZBFrFT2KgQgk2gxvowB33nddjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj+BVgpHmgRaM8WAvqxUjXyN00plAGndnHvFw37aJZE=;
 b=behrOCg5w5Y5zM0ZQlxH3grATQH1FvJ92uQRRxm2i0W4eV+jnnhQVDOHJr9bO1tQlHrcae59GWGiDK7JLcI494RTb3/JJWJ4tCj4FqosJbmP4vQqH4KnEQIoh2cg5pJuwhmhHua4j1FJ1LBBsxvs2Gv0pw3paGc4OdZRC7ERj9pP0chzPJZf4NuHVKcgXtDiV99GriBr2/IewZOS5WWZIu08Q5DCEg4EkarLYDRDuJbyXLmLHm9KxlZ8dQvjNUmEg/Ze7DGYPpvRVmKd+dSUittZgEQZdyDk1dsYtX5EGYKlqBOJHweC6yoLBTAUAIJnfVOHhIIIK09REEpsykALhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj+BVgpHmgRaM8WAvqxUjXyN00plAGndnHvFw37aJZE=;
 b=fNH3YeQ2/afpjGPKHGLt2evLhQpfaWBuckI+mNTwgF65+Pz3eTfJEhfJvmUqKjag/HOwZ/nA9gfdmsPBeZTwmXRBcLksIMvuDJkOP3MCakm1PkLPVwiIkG+b3Xp6x/pLq2SW7CrYaBIsDhT0Rx70KydVOozp93LqDssuKYjDEWY=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1129.namprd21.prod.outlook.com (52.132.146.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Sun, 26 Jan 2020 04:57:00 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe%9]) with mapi id 15.20.2686.013; Sun, 26 Jan 2020
 04:57:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v3 2/4] hv_utils: Support host-initiated restart request
Thread-Topic: [PATCH v3 2/4] hv_utils: Support host-initiated restart request
Thread-Index: AQHV07lWZvLQXaSX3027E1rxrSU606f8YKbg
Date:   Sun, 26 Jan 2020 04:57:00 +0000
Message-ID: <MW2PR2101MB10527D5A3D4F7E52568D119DD7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
 <1579982036-121722-3-git-send-email-decui@microsoft.com>
In-Reply-To: <1579982036-121722-3-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-26T04:56:57.5354335Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bd2cd39-837a-4776-b220-3ec15095a9d8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afd0ad45-16ba-430c-1977-08d7a21c2d8f
x-ms-traffictypediagnostic: MW2PR2101MB1129:|MW2PR2101MB1129:|MW2PR2101MB1129:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB11297A8E3B35220589409AF4D7080@MW2PR2101MB1129.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(8676002)(2906002)(81156014)(81166006)(8936002)(316002)(33656002)(6506007)(110136005)(7696005)(9686003)(5660300002)(55016002)(52536014)(71200400001)(8990500004)(478600001)(86362001)(186003)(76116006)(26005)(10290500003)(66946007)(66556008)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1129;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vil5Hiz+i0dFwqKEz2XzKoycS6lAMMbXikh4uAV782TiZUg9IyQc3lJWFQ2Zd0l77Zbw/A1XluBPKf96Ae3snu9wlu21sqxuLXaQtE6zeVuzT8patfWTL3jHnj8F+uFaj2mq4DYcpSthh+UXLsCQX6jsKc+R+zNuq8b8wqIsgSIeoT5oY/EEfj7t9Q54ld2M5lO58Kvv2XhcHPbnZX9Cb+3Xjwk8U/bHAjygu0hQK/XHyYvGZGjCPkYqO2Bedy0xpAkCqGy0D4GDSNVVovQZJrjMqd8+MFIyLKmpKo6qgU06xYK8dvEZA68eLwUh2v/Prc2Sze+taeH5EwLdcOT7phUel92NNoSt9bOdYUXqZ+5u4KlYYBOxWJGbwCAdwnjXRplTOykCQTRjfQbKLboxhLVqP1MK5CiJnFdTTJcFZhCOGxU7Wx1YkCMDdnUAq/LC
x-ms-exchange-antispam-messagedata: LgAirGmHBaEeERV5QEmAuVTMC1tY1jtEDZRlrjhXS1pPqsESRg3AX/abGhiYGXJXBXGYHb+NJfYrtl8X4fsDYmx7UsQB9L8y4siCbUL328p9NQM7tJbFP2qMVPF9MVcCy37aEX6hMn1keBlkGvP9Mw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd0ad45-16ba-430c-1977-08d7a21c2d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 04:57:00.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpRUKZ7jeJFo1JRTsIEk1cnzxWa9hfDjqb/3mIATn0ct2RndmwqJ4kqdPoxvkaMW0B6syYUcWiv3cqhuz0wQX8COoCQYlCQmiE/cxUUPamw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1129
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 25, 2020 11:=
54 AM
>
> The hv_utils driver currently supports a "shutdown" operation initiated
> from the Hyper-V host. Newer versions of Hyper-V also support a "restart"
> operation. So add support for the updated protocol version that has
> "restart" support, and perform a clean reboot when such a message is
> received from Hyper-V.
>=20
> To test the restart functionality, run this PowerShell command on the
> Hyper-V host:
>=20
> Restart-VM  <vmname>  -Type Reboot
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> ---
> Changes in v2:
>    It's the same as v1.
>=20
> Changes in v3 (I addressed Michael's comments):
>     Used a better version of changelog from  Michael.
>     Added a comment about the meaning of shutdown_msg->flags.
>     Call schedule_work() at the end of the function for consistency.
>=20
>  drivers/hv/hv_util.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 766bd8457346..d815bea0fda3 100644
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
> @@ -118,17 +121,28 @@ static void perform_shutdown(struct work_struct *du=
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
>  	u32 recvlen;
>  	u64 requestid;
>  	bool execute_shutdown =3D false;
> +	bool execute_reboot =3D false;
>  	u8  *shut_txf_buf =3D util_shutdown.recv_buffer;
>=20
>  	struct shutdown_msg_data *shutdown_msg;
> @@ -157,6 +171,12 @@ static void shutdown_onchannelcallback(void *context=
)
>  					sizeof(struct vmbuspipe_hdr) +
>  					sizeof(struct icmsg_hdr)];
>=20
> +			/*
> +			 * shutdown_msg->flags can be 0 (shut down), 2(reboot),
> +			 * or 4(hibernate). It may bitwise-OR 1, which means
> +			 * performing the request by force. Linux always tries
> +			 * to perform the request by force.
> +			 */
>  			switch (shutdown_msg->flags) {
>  			case 0:
>  			case 1:
> @@ -166,6 +186,14 @@ static void shutdown_onchannelcallback(void *context=
)
>  				pr_info("Shutdown request received -"
>  					    " graceful shutdown initiated\n");
>  				break;
> +			case 2:
> +			case 3:
> +				icmsghdrp->status =3D HV_S_OK;
> +				execute_reboot =3D true;
> +
> +				pr_info("Restart request received -"
> +					    " graceful restart initiated\n");
> +				break;
>  			default:
>  				icmsghdrp->status =3D HV_E_FAIL;
>  				execute_shutdown =3D false;
> @@ -186,6 +214,8 @@ static void shutdown_onchannelcallback(void *context)
>=20
>  	if (execute_shutdown =3D=3D true)
>  		schedule_work(&shutdown_work);
> +	if (execute_reboot =3D=3D true)
> +		schedule_work(&restart_work);

This works, and responds to my comment.  But FWIW, a more compact
approach would be to drop the boolean execute_shutdown, execute_restart,
etc. local variables and have just this local variable:

	struct work_struct *work_to_do =3D NULL;

In the "case" branches do:

	work_to_do =3D &shutdown_work;

or
	work_to_do =3D &restart_work;

Then at the bottom of the function, just do:

	if (work_to_do)
		schedule_work(work_to_do);

Patch 3 of this series would then be a little simpler as well.

>  }
>=20
>  /*
> --
> 2.19.1

