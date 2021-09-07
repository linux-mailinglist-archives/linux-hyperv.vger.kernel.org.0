Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C8403069
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Sep 2021 23:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbhIGVnX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Sep 2021 17:43:23 -0400
Received: from mail-oln040093003010.outbound.protection.outlook.com ([40.93.3.10]:14463
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234307AbhIGVnW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Sep 2021 17:43:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFLSK38WIkdet3cKDsvxQKVxkGDA/LWMQ/eYpi/JyV0/BLSs/xUBeY5jBZsPp0TjflqlKzeameSHQawr2y43WuHJjPSs7kGEpnHnnb2U56NZe8USEzFGyHIy+52fmW5P8oM6GiqvXQOaggw2y6UVWxKFLqXXNGkifWxlV4WmfbnbGisBwLhEQDHaQJWp8gL3W+nZ4AerLDvG32zhC7IcqJUV+J4Fn2h9JWO/4Oux0Fv6nnyTCJaz236wftZ6d0ZXkOavA3rV1Aw3ZVW/FpRIWZ+jUO1lvzMlMm/Pt8ADLf9i3iYlsez9kJZY9KrzdULWQO6LlNjPk8xesRPoHM0gBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mOR7Xr9Dycf+3I8CvkMCXiYl2dhE7wuyTon2IWY62l8=;
 b=QTLfXnU38qVoEgFQNLrfOMlBq4dr/KHRnY2gmUOLQDjjxwRCFpEF10M/1jkiopy1feJd3oyrA9ImJTYJPs6p3GqhGVpSiupW39GMCKhCkMe2g6+ohaXOtUbttu9EaLwpC5UhfnmB7Qv3Pr7pxp6005KpPJRaYiLKpgPh04CMSP+7Q7CA4+rLTLIbICEuknDk46wcCZQyOw85c/ROsmvyzGMOatB330LGqvNip0sWpwFe+e717Jm8q79xdplxw2hZ06nTMX0Xmn0zS1n9iGr8N8qDgyJ109QOzXyXmQN1QUMKA89H+vdON4NgfYmgENqQ/KIjFjz3GWJMvHlOV8JzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOR7Xr9Dycf+3I8CvkMCXiYl2dhE7wuyTon2IWY62l8=;
 b=cZSemmgOOspaewyni3p7nFlZJYEuv1ICKTbLwyXqmFYW5PT28M7K7p2Lx0N45vK70zywsy8IVxLp6Yw2brr8deiauxrCq0cfAMyaZJUbeGtC+7kFFBkmRJQrPW28f4pVcJEipyOywX/l04NiUUhABwn1auCU3t+nsh4YVRuKzK8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1771.namprd21.prod.outlook.com (2603:10b6:302:7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.3; Tue, 7 Sep
 2021 21:42:11 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202%6]) with mapi id 15.20.4523.008; Tue, 7 Sep 2021
 21:42:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXiceiwexqAP+KGEeGrLW5lugsiauZNgPw
Date:   Tue, 7 Sep 2021 21:42:11 +0000
Message-ID: <MWHPR21MB1593A590DB88E2D81F0C2CF3D7D39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3a0ce3f2-d91e-4ee0-9e58-0b28f987ec71;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-07T20:13:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d77b3925-caf1-4720-cea5-08d97248596e
x-ms-traffictypediagnostic: MW2PR2101MB1771:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB17715A4F1FD0E3BAE542CD3AD7D39@MW2PR2101MB1771.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aqQLNJ5avAXuMvvxSNaRcTPoh0wNQj8017+9sC4PI86r97jaCICRZNUUBMQpdXDlh7tO6XLHS+ZmMfygUfhsT1G/OsTo47uLC4kdAYlWGdca08Z/8hngCD7BjtR8TaolyGLLFpmjS5RyhOML8oLpwxB9llPkgv4bEFYEvp62AeXXzfaIp5QRI52gADP59WFQ4cQYD/2Pf8tQKyXvWXT9m3Hs+xp5u/XG8p4DWdYvGCPnDAAHjCxqizLR3B1qkVGbjPAT7QKmovClu8bCERsGgqd13SOvBrZ2m4UiTO2jSHwOzgUlZOLU3F6kVf62sxfGlPsjXRIZNjhaYkK1BguFhKrUGGe5oVpliy8rG62giUD9sJv/bbI0Ny3iks2Uvu3nDtiKzESoZy8zUwQ556je3eleVG2qx5mGZGdJ6Vwqrrxp5TD/7xXsmdXcffk5sVUN31PPzDRS5AzRGqloT3Cp26Zltzhd+ZoFsCgFNIFkLHMMzUQB77OOTUt/tELcBhILzfVD3oiYXCfCPsbPDgxKh2W4Md5a8PYvL9xiFA5Aenfd9ekhLj9l3pYVAhJqQajz3dlBhwN4VlnxO1IqY9eVM7h5bFPD1CbN/8y+f8dIlTUZV+ZKSwofRFZE5bPb068M9hO3GAQHnDFXSbYxwTTTrmlj2DCYB9J+9iEQxTYKWYOgv3RLqfk2huAFqma2kzWiYgOkIs6nouT2SKvC1qshww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(10290500003)(71200400001)(5660300002)(52536014)(26005)(7416002)(33656002)(30864003)(83380400001)(186003)(7696005)(8990500004)(9686003)(76116006)(66446008)(316002)(66946007)(2906002)(86362001)(6506007)(508600001)(66556008)(8676002)(66574015)(82960400001)(82950400001)(4326008)(122000001)(66476007)(54906003)(38100700002)(64756008)(110136005)(38070700005)(55016002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZHaSwBbhf7YOmaibm5uMEnetfUf10n/NbAksIl0RF0368wgsKNv2IuHoQaZy?=
 =?us-ascii?Q?pnOQHSYNVBvC8lAF2MZHVxwhfxS72tdX8IqZK3sVEzlM3nINIFJW6EC0jwiO?=
 =?us-ascii?Q?j5NyTRwPWpY5qkDGeIzpLGd6qzuak00XGvOXh7bLjkktm0wUJKL7y98abpZJ?=
 =?us-ascii?Q?OrhukYFuMcie+xaV3TrhjT9C1szxs9PIpFKa0mgKRvmyKjrBRIgss4QBrZGI?=
 =?us-ascii?Q?Cb3G4WpbGfmH0O1oWsnCbXXUhoxKbrDDN9R+gVxgxDu0QOogIRWQfeI+UqDc?=
 =?us-ascii?Q?VQ2Qds4E53nfYsqA4wmhGR6Jsvy3rUMnmZ2kuVHer4Fjfb7M5Vng344rk+DC?=
 =?us-ascii?Q?LYkLjsBPvcNdfH4xe59Naz/LmIhSv/8mfdhfCxFjfHTdncrBLdeO5Kgc7fH5?=
 =?us-ascii?Q?IrtkhugIOOiAUKwoi4QFbNxzZ0ngwqt7pk62l6K+Q0Oc7snq2Q8tvzQ7an6l?=
 =?us-ascii?Q?wspCXiqOCzmK/c+kz58H/jRZboWIv3Cc5OeCRLKcZq/HehbH6v0bt0nFVu1n?=
 =?us-ascii?Q?6Eqw9ree0blM76afhVd6q9cOeVrCGWTote0HE7JSUvzcUK5xsgWltp3LccXL?=
 =?us-ascii?Q?/eh/OzsrodRW6EvNx4wM7aM280Rbwnm9yH3AS6Wg9zBgkTD4Oy0HV6ESnSOQ?=
 =?us-ascii?Q?DJ9j5ubPIsilpYsCYYrxwZGaox61SPV7Yf5L24abwtYaK46ldsAeo6vmyGr7?=
 =?us-ascii?Q?fDlGjS7Jc8dvvIcObMuvtIZL+oydZor27jgD13pnrv3TGtTpsHFEbORcgiSc?=
 =?us-ascii?Q?teAAg+Ia6qKbnnvSMnqdNXOzRdm2R0z/tKHTjgPS0oCAT4I5jApuvqpoXY/h?=
 =?us-ascii?Q?63j8T2rxLD4DMejbityUcdr+uOOApP5jeDidmfgXfYvGxXrBI+83ifEY7446?=
 =?us-ascii?Q?Yt69sGMfO6NIXxEMR0yqmALrZyo6ytUloSTmOutrpKG7xTZ73ygJEn2/yzLH?=
 =?us-ascii?Q?IFUBOzb879seEOSg0CbgdeZ5a+OpJ5VRlEONQ/TwA1/Rig6QgY54o6/JCVEM?=
 =?us-ascii?Q?fevlT0mgJQ9NXKZBkcgQjUvOUW4TUi+ATVXtak0AbyrJCu/pHdtHrf0gGWV1?=
 =?us-ascii?Q?hkHaAOjGltwT+T5mhOFHsowtO+VSNLr7T2GNxeCiodiC4NfKQBKf0uvAjEyD?=
 =?us-ascii?Q?pY9HUotzdR/V9lSeChBV0TdVFnxmoPATO79xnG4aazcuLu4doL3n0dijxnX9?=
 =?us-ascii?Q?d1kR7bKJcm+mPbOFD5giYchECXz+uJRoGYHGyzHfFFxQXXz/qAYUxHQQ62Nw?=
 =?us-ascii?Q?tqAbzvuSdxTFmn48tb+Nv8OPMxl/BwzveQiQA+pOf/NkUy/MNzaafHQkLhRg?=
 =?us-ascii?Q?5UD+zm6RdNHUtOYxQKpAGp76?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77b3925-caf1-4720-cea5-08d97248596e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 21:42:11.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LkenCzPdqgdSUb78w12vhqBRtjVFgelzBUWbUwKES1ASHBk88nvNiRsZsceMB3tYVHQJ+kEE/oGfkICX8p18qEM2X+0hYD9XqxHy9FP6En0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1771
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Thursday, A=
ugust 5, 2021 12:00 AM
>=20
> Azure Blob provides scalable, secure and shared storage services for the
> internet.
>=20
> This driver adds support for accelerated access to Azure Blob storage for
> Azure VMs. As an alternative to using REST APIs over HTTP for Blob access=
,
> an Azure VM can use this driver to send Blob requests to Azure host. Azur=
e
> host uses its native network to perform Blob requests directly to Blob
> servers.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Andra Paraschiv <andraprs@amazon.com>
> Cc: Siddharth Gupta <sidgup@codeaurora.org>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
>  drivers/hv/Kconfig                                 |  11 +
>  drivers/hv/Makefile                                |   1 +
>  drivers/hv/channel_mgmt.c                          |   7 +
>  drivers/hv/hv_azure_blob.c                         | 574 +++++++++++++++=
++++++
>  include/linux/hyperv.h                             |   9 +
>  include/uapi/misc/hv_azure_blob.h                  |  35 ++
>  7 files changed, 639 insertions(+)
>  create mode 100644 drivers/hv/hv_azure_blob.c
>  create mode 100644 include/uapi/misc/hv_azure_blob.h
>=20
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index 9bfc2b5..1ee8c0c7 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -180,6 +180,8 @@ Code  Seq#    Include File                           =
                Comments
>  'R'   01     linux/rfkill.h                                          con=
flict!
>  'R'   C0-DF  net/bluetooth/rfcomm.h
>  'R'   E0     uapi/linux/fsl_mc.h
> +'R'   F0-FF  uapi/misc/hv_azure_blob.h                               Mic=
rosoft Azure Blob driver
> +                                                                     <ma=
ilto:longli@microsoft.com>
>  'S'   all    linux/cdrom.h                                           con=
flict!
>  'S'   80-81  scsi/scsi_ioctl.h                                       con=
flict!
>  'S'   82-FF  scsi/scsi.h                                             con=
flict!
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 66c794d..53bebd0 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -27,4 +27,15 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config HYPERV_AZURE_BLOB
> +	tristate "Microsoft Azure Blob driver"
> +	depends on HYPERV && X86_64
> +	help
> +	  Select this option to enable Microsoft Azure Blob driver.
> +
> +	  This driver implements a fast datapath over Hyper-V to support
> +	  accelerated access to Microsoft Azure Blob services.
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called azure_blob.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 94daf82..2726445 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> +obj-$(CONFIG_HYPERV_AZURE_BLOB)	+=3D hv_azure_blob.o
>=20
>  CFLAGS_hv_trace.o =3D -I$(src)
>  CFLAGS_hv_balloon.o =3D -I$(src)
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 705e95d..3095611 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -154,6 +154,13 @@
>  	  .allowed_in_isolated =3D false,
>  	},
>=20
> +	/* Azure Blob */
> +	{ .dev_type =3D HV_AZURE_BLOB,
> +	  HV_AZURE_BLOB_GUID,
> +	  .perf_device =3D false,
> +	  .allowed_in_isolated =3D false,
> +	},
> +
>  	/* Unknown GUID */
>  	{ .dev_type =3D HV_UNKNOWN,
>  	  .perf_device =3D false,
> diff --git a/drivers/hv/hv_azure_blob.c b/drivers/hv/hv_azure_blob.c
> new file mode 100644
> index 0000000..3a1063f
> --- /dev/null
> +++ b/drivers/hv/hv_azure_blob.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021 Microsoft Corporation. */
> +
> +#include <uapi/misc/hv_azure_blob.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/cred.h>
> +#include <linux/debugfs.h>
> +#include <linux/pagemap.h>
> +#include <linux/hyperv.h>
> +#include <linux/miscdevice.h>
> +#include <linux/uio.h>
> +
> +struct az_blob_device {
> +	struct kref kref;
> +
> +	struct hv_device *device;
> +	struct miscdevice misc;
> +
> +	/* Lock for protecting pending_requests */
> +	spinlock_t request_lock;
> +	struct list_head pending_requests;
> +	wait_queue_head_t waiting_to_drain;
> +};
> +
> +/* VSP messages */
> +enum az_blob_vsp_request_type {
> +	AZ_BLOB_DRIVER_REQUEST_FIRST     =3D 0x100,
> +	AZ_BLOB_DRIVER_USER_REQUEST      =3D 0x100,
> +	AZ_BLOB_DRIVER_REGISTER_BUFFER   =3D 0x101,
> +	AZ_BLOB_DRIVER_DEREGISTER_BUFFER =3D 0x102,
> +};
> +
> +/* VSC->VSP request */
> +struct az_blob_vsp_request {
> +	u32 version;
> +	u32 timeout_ms;
> +	u32 data_buffer_offset;
> +	u32 data_buffer_length;
> +	u32 data_buffer_valid;
> +	u32 operation_type;
> +	u32 request_buffer_offset;
> +	u32 request_buffer_length;
> +	u32 response_buffer_offset;
> +	u32 response_buffer_length;
> +	guid_t transaction_id;
> +} __packed;
> +
> +/* VSP->VSC response */
> +struct az_blob_vsp_response {
> +	u32 length;
> +	u32 error;
> +	u32 response_len;
> +} __packed;
> +
> +struct az_blob_vsp_request_ctx {
> +	struct list_head list_device;
> +	struct completion wait_vsp;
> +	struct az_blob_request_sync *request;
> +};
> +
> +/* The maximum number of pages we can pass to VSP in a single packet */
> +#define AZ_BLOB_MAX_PAGES 8192
> +
> +/* Ring buffer size in bytes */
> +#define AZ_BLOB_RING_SIZE (128 * 1024)
> +
> +/* System wide device queue depth */
> +#define AZ_BLOB_QUEUE_DEPTH 1024
> +
> +/* The VSP protocol version this driver understands */
> +#define VSP_PROTOCOL_VERSION_V1 0
> +
> +static const struct hv_vmbus_device_id id_table[] =3D {
> +	{ HV_AZURE_BLOB_GUID,
> +	  .driver_data =3D 0
> +	},
> +	{ },
> +};
> +
> +static void az_blob_device_get(struct az_blob_device *dev)
> +{
> +	kref_get(&dev->kref);
> +}
> +
> +static void az_blob_release(struct kref *kref)
> +{
> +	struct az_blob_device *dev =3D
> +		container_of(kref, struct az_blob_device, kref);
> +
> +	kfree(dev);
> +}
> +
> +static void az_blob_device_put(struct az_blob_device *dev)
> +{
> +	kref_put(&dev->kref, az_blob_release);
> +}
> +
> +static void az_blob_on_channel_callback(void *context)
> +{
> +	struct vmbus_channel *channel =3D (struct vmbus_channel *)context;
> +	const struct vmpacket_descriptor *desc;
> +
> +	foreach_vmbus_pkt(desc, channel) {
> +		struct az_blob_vsp_request_ctx *request_ctx;
> +		struct az_blob_vsp_response *response;
> +		u64 cmd_rqst =3D vmbus_request_addr(&channel->requestor,
> +						  desc->trans_id);
> +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> +			dev_err(&channel->device_obj->device,
> +				"incorrect transaction id %llu\n",
> +				desc->trans_id);
> +			continue;
> +		}
> +		request_ctx =3D (struct az_blob_vsp_request_ctx *)cmd_rqst;
> +		response =3D hv_pkt_data(desc);
> +
> +		dev_dbg(&channel->device_obj->device,
> +			"response for request %pUb status %u "
> +			"response_len %u\n",
> +			&request_ctx->request->guid, response->error,
> +			response->response_len);
> +		request_ctx->request->response.status =3D response->error;
> +		request_ctx->request->response.response_len =3D
> +			response->response_len;
> +		complete(&request_ctx->wait_vsp);
> +	}
> +}
> +
> +static int az_blob_fop_open(struct inode *inode, struct file *file)
> +{
> +	struct az_blob_device *dev =3D
> +		container_of(file->private_data, struct az_blob_device, misc);
> +
> +	az_blob_device_get(dev);
> +
> +	return 0;
> +}
> +
> +static int az_blob_fop_release(struct inode *inode, struct file *file)
> +{
> +	struct az_blob_device *dev =3D
> +		container_of(file->private_data, struct az_blob_device, misc);
> +
> +	az_blob_device_put(dev);
> +
> +	return 0;
> +}
> +
> +static inline bool az_blob_safe_file_access(struct file *file)
> +{
> +	return file->f_cred =3D=3D current_cred() && !uaccess_kernel();
> +}
> +
> +/* Pin the user buffer pages into memory for passing to VSP */
> +static int get_buffer_pages(int rw, void __user *buffer, u32 buffer_len,
> +			    struct page ***ppages, size_t *start,
> +			    size_t *num_pages)
> +{
> +	struct iovec iov;
> +	struct iov_iter iter;
> +	int ret;
> +	ssize_t result;
> +	struct page **pages;
> +	int i;
> +
> +	ret =3D import_single_range(rw, buffer, buffer_len, &iov, &iter);
> +	if (ret)
> +		return ret;
> +
> +	result =3D iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start);
> +	if (result < 0)
> +		return result;
> +
> +	*num_pages =3D (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
> +	if (result !=3D buffer_len) {
> +		for (i =3D 0; i < *num_pages; i++)
> +			put_page(pages[i]);
> +		kvfree(pages);
> +		return -EFAULT;
> +	}
> +
> +	*ppages =3D pages;
> +	return 0;
> +}
> +
> +static void fill_in_page_buffer(u64 *pfn_array, int *index,
> +				struct page **pages, unsigned long num_pages)
> +{
> +	int i, page_idx =3D *index;
> +
> +	for (i =3D 0; i < num_pages; i++)
> +		pfn_array[page_idx++] =3D page_to_pfn(pages[i]);
> +	*index =3D page_idx;
> +}
> +
> +static void free_buffer_pages(size_t num_pages, struct page **pages)
> +{
> +	unsigned long i;
> +
> +	for (i =3D 0; i < num_pages; i++)
> +		if (pages && pages[i])
> +			put_page(pages[i]);
> +	kvfree(pages);
> +}
> +
> +static long az_blob_ioctl_user_request(struct file *filp, unsigned long =
arg)
> +{
> +	struct az_blob_device *dev =3D
> +		container_of(filp->private_data, struct az_blob_device, misc);
> +	struct az_blob_request_sync __user *request_user =3D
> +		(struct az_blob_request_sync __user *)arg;
> +	struct az_blob_request_sync request;
> +	struct az_blob_vsp_request_ctx request_ctx;
> +	unsigned long flags;
> +	int ret;
> +	size_t request_start, request_num_pages =3D 0;
> +	size_t response_start, response_num_pages =3D 0;
> +	size_t data_start, data_num_pages =3D 0, total_num_pages;
> +	struct page **request_pages =3D NULL, **response_pages =3D NULL;
> +	struct page **data_pages =3D NULL;
> +	struct vmbus_packet_mpb_array *desc;
> +	u64 *pfn_array;
> +	int desc_size;
> +	int page_idx;
> +	struct az_blob_vsp_request *vsp_request;
> +
> +	if (!az_blob_safe_file_access(filp)) {
> +		dev_dbg(&dev->device->device,
> +			"process %d(%s) changed security contexts after"
> +			" opening file descriptor\n",
> +			task_tgid_vnr(current), current->comm);
> +		return -EACCES;
> +	}
> +
> +	if (copy_from_user(&request, request_user, sizeof(request))) {
> +		dev_dbg(&dev->device->device,
> +			"don't have permission to user provided buffer\n");
> +		return -EFAULT;
> +	}
> +
> +	dev_dbg(&dev->device->device,
> +		"az_blob ioctl request guid %pUb timeout %u request_len %u"
> +		" response_len %u data_len %u request_buffer %llx "
> +		"response_buffer %llx data_buffer %llx\n",
> +		&request.guid, request.timeout, request.request_len,
> +		request.response_len, request.data_len, request.request_buffer,
> +		request.response_buffer, request.data_buffer);
> +
> +	if (!request.request_len || !request.response_len)
> +		return -EINVAL;
> +
> +	if (request.data_len && request.data_len < request.data_valid)
> +		return -EINVAL;
> +
> +	if (request.data_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
> +	    request.request_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
> +	    request.response_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES)
> +		return -EINVAL;
> +
> +	init_completion(&request_ctx.wait_vsp);
> +	request_ctx.request =3D &request;
> +
> +	ret =3D get_buffer_pages(READ, (void __user *)request.request_buffer,
> +			       request.request_len, &request_pages,
> +			       &request_start, &request_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	ret =3D get_buffer_pages(READ | WRITE,
> +			       (void __user *)request.response_buffer,
> +			       request.response_len, &response_pages,
> +			       &response_start, &response_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	if (request.data_len) {
> +		ret =3D get_buffer_pages(READ | WRITE,
> +				       (void __user *)request.data_buffer,
> +				       request.data_len, &data_pages,
> +				       &data_start, &data_num_pages);
> +		if (ret)
> +			goto get_user_page_failed;
> +	}
> +
> +	total_num_pages =3D request_num_pages + response_num_pages +
> +				data_num_pages;
> +	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
> +		dev_dbg(&dev->device->device,
> +			"number of DMA pages %lu buffer exceeding %u\n",
> +			total_num_pages, AZ_BLOB_MAX_PAGES);
> +		ret =3D -EINVAL;
> +		goto get_user_page_failed;
> +	}
> +
> +	/* Construct a VMBUS packet and send it over to VSP */
> +	desc_size =3D struct_size(desc, range.pfn_array, total_num_pages);
> +	desc =3D kzalloc(desc_size, GFP_KERNEL);
> +	vsp_request =3D kzalloc(sizeof(*vsp_request), GFP_KERNEL);
> +	if (!desc || !vsp_request) {
> +		kfree(desc);
> +		kfree(vsp_request);
> +		ret =3D -ENOMEM;
> +		goto get_user_page_failed;
> +	}
> +
> +	desc->range.offset =3D 0;
> +	desc->range.len =3D total_num_pages * PAGE_SIZE;
> +	pfn_array =3D desc->range.pfn_array;
> +	page_idx =3D 0;
> +
> +	if (request.data_len) {
> +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> +				    data_num_pages);
> +		vsp_request->data_buffer_offset =3D data_start;
> +		vsp_request->data_buffer_length =3D request.data_len;
> +		vsp_request->data_buffer_valid =3D request.data_valid;
> +	}
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> +			    request_num_pages);
> +	vsp_request->request_buffer_offset =3D request_start +
> +						data_num_pages * PAGE_SIZE;
> +	vsp_request->request_buffer_length =3D request.request_len;
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> +			    response_num_pages);
> +	vsp_request->response_buffer_offset =3D response_start +
> +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> +	vsp_request->response_buffer_length =3D request.response_len;
> +
> +	vsp_request->version =3D VSP_PROTOCOL_VERSION_V1;
> +	vsp_request->timeout_ms =3D request.timeout;
> +	vsp_request->operation_type =3D AZ_BLOB_DRIVER_USER_REQUEST;
> +	guid_copy(&vsp_request->transaction_id, &request.guid);
> +
> +	spin_lock_irqsave(&dev->request_lock, flags);
> +	list_add_tail(&request_ctx.list_device, &dev->pending_requests);
> +	spin_unlock_irqrestore(&dev->request_lock, flags);
> +
> +	ret =3D vmbus_sendpacket_mpb_desc(dev->device->channel, desc, desc_size=
,
> +					vsp_request, sizeof(*vsp_request),
> +					(u64)&request_ctx);
> +
> +	kfree(desc);
> +	kfree(vsp_request);
> +	if (ret)
> +		goto vmbus_send_failed;
> +
> +	wait_for_completion(&request_ctx.wait_vsp);
> +
> +	/*
> +	 * At this point, the response is already written to request
> +	 * by VMBUS completion handler, copy them to user-mode buffers
> +	 * and return to user-mode
> +	 */
> +	if (copy_to_user(&request_user->response, &request.response,
> +			 sizeof(request.response)))
> +		ret =3D -EFAULT;
> +
> +vmbus_send_failed:
> +
> +	spin_lock_irqsave(&dev->request_lock, flags);
> +	list_del(&request_ctx.list_device);
> +	if (list_empty(&dev->pending_requests))
> +		wake_up(&dev->waiting_to_drain);
> +	spin_unlock_irqrestore(&dev->request_lock, flags);
> +
> +get_user_page_failed:
> +	free_buffer_pages(request_num_pages, request_pages);
> +	free_buffer_pages(response_num_pages, response_pages);
> +	free_buffer_pages(data_num_pages, data_pages);
> +
> +	return ret;
> +}
> +
> +static long az_blob_fop_ioctl(struct file *filp, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	struct az_blob_device *dev =3D
> +		container_of(filp->private_data, struct az_blob_device, misc);
> +
> +	switch (cmd) {
> +	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
> +		return az_blob_ioctl_user_request(filp, arg);
> +
> +	default:
> +		dev_dbg(&dev->device->device,
> +			"unrecognized IOCTL code %u\n", cmd);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct file_operations az_blob_client_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D az_blob_fop_open,
> +	.unlocked_ioctl =3D az_blob_fop_ioctl,
> +	.release	=3D az_blob_fop_release,
> +};
> +
> +#if defined(CONFIG_DEBUG_FS)
> +static int az_blob_show_pending_requests(struct seq_file *m, void *v)
> +{
> +	unsigned long flags;
> +	struct az_blob_vsp_request_ctx *request_ctx;
> +	struct az_blob_device *dev =3D m->private;
> +
> +	seq_puts(m, "List of pending requests\n");
> +	seq_puts(m, "UUID request_len response_len data_len data_valid "
> +		"request_buffer response_buffer data_buffer\n");
> +	spin_lock_irqsave(&dev->request_lock, flags);
> +	list_for_each_entry(request_ctx, &dev->pending_requests, list_device) {
> +		seq_printf(m, "%pUb ", &request_ctx->request->guid);
> +		seq_printf(m, "%u ", request_ctx->request->request_len);
> +		seq_printf(m, "%u ", request_ctx->request->response_len);
> +		seq_printf(m, "%u ", request_ctx->request->data_len);
> +		seq_printf(m, "%u ", request_ctx->request->data_valid);
> +		seq_printf(m, "%llx ", request_ctx->request->request_buffer);
> +		seq_printf(m, "%llx ", request_ctx->request->response_buffer);
> +		seq_printf(m, "%llx\n", request_ctx->request->data_buffer);
> +	}
> +	spin_unlock_irqrestore(&dev->request_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int az_blob_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, az_blob_show_pending_requests,
> +			   inode->i_private);
> +}
> +
> +static const struct file_operations az_blob_debugfs_fops =3D {
> +	.open		=3D az_blob_debugfs_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D seq_release
> +};
> +#endif
> +
> +static void az_blob_remove_device(struct az_blob_device *dev)
> +{
> +	struct dentry *debugfs_root =3D debugfs_lookup("az_blob", NULL);
> +
> +	debugfs_remove_recursive(debugfs_root);
> +	misc_deregister(&dev->misc);
> +}
> +
> +static int az_blob_create_device(struct az_blob_device *dev)
> +{
> +	int ret;
> +	struct dentry *debugfs_root;
> +
> +	dev->misc.minor	=3D MISC_DYNAMIC_MINOR,
> +	dev->misc.name	=3D "azure_blob",
> +	dev->misc.fops	=3D &az_blob_client_fops,
> +
> +	ret =3D misc_register(&dev->misc);
> +	if (ret)
> +		return ret;
> +
> +	debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> +	debugfs_create_file("pending_requests", 0400, debugfs_root, dev,
> +			    &az_blob_debugfs_fops);
> +
> +	return 0;
> +}
> +
> +static int az_blob_connect_to_vsp(struct hv_device *device,
> +				  struct az_blob_device *dev, u32 ring_size)
> +{
> +	int ret;
> +
> +	dev->device =3D device;
> +	device->channel->rqstor_size =3D AZ_BLOB_QUEUE_DEPTH;
> +
> +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> +			 az_blob_on_channel_callback, device->channel);
> +
> +	if (ret)
> +		return ret;
> +
> +	hv_set_drvdata(device, dev);
> +
> +	return ret;
> +}
> +
> +static void az_blob_remove_vmbus(struct hv_device *device)
> +{
> +	hv_set_drvdata(device, NULL);
> +	vmbus_close(device->channel);
> +}
> +
> +static int az_blob_probe(struct hv_device *device,
> +			 const struct hv_vmbus_device_id *dev_id)
> +{
> +	int ret;
> +	struct az_blob_device *dev;
> +
> +	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&dev->request_lock);
> +	INIT_LIST_HEAD(&dev->pending_requests);
> +	init_waitqueue_head(&dev->waiting_to_drain);
> +
> +	kref_init(&dev->kref);
> +
> +	ret =3D az_blob_connect_to_vsp(device, dev, AZ_BLOB_RING_SIZE);
> +	if (ret)
> +		goto fail;
> +
> +	/* create user-mode client library facing device */
> +	ret =3D az_blob_create_device(dev);
> +	if (ret) {
> +		dev_err(&dev->device->device,
> +			"failed to create device ret=3D%d\n", ret);
> +		az_blob_remove_vmbus(device);
> +		goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	az_blob_device_put(dev);
> +	return ret;
> +}
> +
> +static int az_blob_remove(struct hv_device *device)
> +{
> +	struct az_blob_device *dev =3D hv_get_drvdata(device);
> +
> +	az_blob_remove_device(dev);
> +
> +	/*
> +	 * The Hyper-V VSP still owns the user buffers of those pending
> +	 * requests. Wait until all the user buffers are released to
> +	 * the original owner before proceeding to remove the bus device.
> +	 */
> +	wait_event(dev->waiting_to_drain, list_empty(&dev->pending_requests));

The only scenario is which there could still be pending requests is a
host-initiated rescind operation.   The host should also send completions f=
or
any pending requests, but the rescind message and the completion requests
come through different paths, so the rescind message could be processed
before the completions. So waiting here makes sense.

However, I'm concerned about user processes that have the device open at
the time of the rescind.  As stated in my comments on previous versions,  I=
'm
not an expert in this area, but I'm assuming that after az_blob_remove_devi=
ce()
completes, a user process cannot open the device.   But it's not 100% clear=
 to
me if az_blob_remove_device() waits for any existing opens of the device to=
 be
closed.  I'm assuming not. (If it does then we're back to the problem of th=
e rescind
processing waiting for user space.)  But assuming that existing opens remai=
n in
place, there's a race condition between such a user process and this path.
The user process could try to submit a new request to the VMbus channel
*after* this path has already found the pending_request list to be empty,
and closed and deleted the VMbus device and channel.

I think the easiest solution is to reintroduce the "removing" flag in the
az_blob_device structure.  The flag should be set in this path before calli=
ng
"wait_event()".  And the flag should be checked in az_blob_ioctl_user_reque=
st()
*after* the new request has been put on the pending queue but before
referencing the VMbus channel. If az_blob_ioctl_user_request() finds the
flag set at that point, it should clean up and exit without touching the
VMbus channel.  Note that the az_blob_device can't go away because the
user process will have bumped the reference count in az_blob_fop_open(),
so manipulating the pending_request queue and doing the wakeup on
waiting_to_drain is safe.  And the "removing" flag should be written and
read with WRITE_ONCE() and READ_ONCE() to ensure the compiler and
processor don't reorder the operations.

> +
> +	az_blob_remove_vmbus(device);
> +	az_blob_device_put(dev);
> +
> +	return 0;
> +}
> +
> +static struct hv_driver az_blob_drv =3D {
> +	.name		=3D KBUILD_MODNAME,
> +	.id_table	=3D id_table,
> +	.probe		=3D az_blob_probe,
> +	.remove		=3D az_blob_remove,
> +	.driver		=3D {
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +
> +static int __init az_blob_drv_init(void)
> +{
> +	return vmbus_driver_register(&az_blob_drv);
> +}
> +
> +static void __exit az_blob_drv_exit(void)
> +{
> +	vmbus_driver_unregister(&az_blob_drv);
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Azure Blob driver");
> +module_init(az_blob_drv_init);
> +module_exit(az_blob_drv_exit);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index d1e59db..ac31362 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -772,6 +772,7 @@ enum vmbus_device_type {
>  	HV_FCOPY,
>  	HV_BACKUP,
>  	HV_DM,
> +	HV_AZURE_BLOB,
>  	HV_UNKNOWN,
>  };
>=20
> @@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource **new, str=
uct hv_device *device_obj,
>  			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
>=20
>  /*
> + * Azure Blob GUID
> + * {0590b792-db64-45cc-81db-b8d70c577c9e}
> + */
> +#define HV_AZURE_BLOB_GUID \
> +	.guid =3D GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
> +			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
> +
> +/*
>   * Shutdown GUID
>   * {0e0b6031-5213-4934-818b-38d90ced39db}
>   */
> diff --git a/include/uapi/misc/hv_azure_blob.h b/include/uapi/misc/hv_azu=
re_blob.h
> new file mode 100644
> index 0000000..87a3f77
> --- /dev/null
> +++ b/include/uapi/misc/hv_azure_blob.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/* Copyright (c) 2021 Microsoft Corporation. */
> +
> +#ifndef _AZ_BLOB_H
> +#define _AZ_BLOB_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/uuid.h>
> +#include <linux/types.h>
> +
> +/* user-mode sync request sent through ioctl */
> +struct az_blob_request_sync_response {
> +	__u32 status;
> +	__u32 response_len;
> +};
> +
> +struct az_blob_request_sync {
> +	guid_t guid;
> +	__u32 timeout;
> +	__u32 request_len;
> +	__u32 response_len;
> +	__u32 data_len;
> +	__u32 data_valid;
> +	__aligned_u64 request_buffer;
> +	__aligned_u64 response_buffer;
> +	__aligned_u64 data_buffer;
> +	struct az_blob_request_sync_response response;
> +};
> +
> +#define AZ_BLOB_MAGIC_NUMBER	'R'
> +#define IOCTL_AZ_BLOB_DRIVER_USER_REQUEST \
> +		_IOWR(AZ_BLOB_MAGIC_NUMBER, 0xf0, \
> +			struct az_blob_request_sync)
> +
> +#endif /* define _AZ_BLOB_H */
> --
> 1.8.3.1

