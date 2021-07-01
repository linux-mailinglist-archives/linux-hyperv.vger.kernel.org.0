Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542AB3B8DE1
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhGAGyA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 02:54:00 -0400
Received: from mail-dm3nam07on2121.outbound.protection.outlook.com ([40.107.95.121]:22218
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234250AbhGAGx7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 02:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvUOc+sCuD5rimC3EOTqZowuVK+C+asqycFXrvi4bkLgQuoZV/C0Ao0Q+J73nkrXyXNCh1vW+/HAFnkjEMTZqnPDF0NJDOMGp7sELR78VclAqza4FbB1NRjs8A+JlH1HkBr+PxN+lG2byHDgJGl2LJTmDWXk39DrRhc/ulWadi9+AKzJrCzP6MrzY0g3xUvkOYsb6MX3gtQYO4l3rJ1RPZorrZMsAgIEOEgh1xc/E8ZEGGywzwUPsaCstvqBo/LXawv9mm0cUbdAR/EUfhGsFOCbXIxpJk+NaUxBaJoYalAbhOfgHotCpvmZX6p9WufBdgMUw1DUiA3ozIw0iemmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/eMdu+5inUTOVtDKfovm5MjF2+7j1hS6qNvTg34jD8=;
 b=N+iIQwQ2vAQ6EY6WTP2IrxAzyRR+OsAVSrKUqCuCvnu8WrPD9pj73Bfmbezklpg8yu6QGcn6PXn0U4g17jrgyb60RL8xZt8d7pC8/y6eE1/iXTYC51Ih9U1lrVAMverKwuSew2kd+lH2dkY05jZlhKylL5zLZ2usSLn/WCTVFjE1iKTnNDFFbLz3HI6x9XpImqHL4Z5X+tRzvnsDmlu/+k0guCgCHxAZOzOc4qdUMtnHg0feS36yVxkf2JnzjJQfApe9vxwoK7IcKzf3oD3bNJsHUBbvHx+Z3bL6YBFt7K8cNQ7sL9HkOtjqQHaKPrw95zqfeCn7cxDAc7Cl9SvpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/eMdu+5inUTOVtDKfovm5MjF2+7j1hS6qNvTg34jD8=;
 b=atR2qdgRbs+yCHTFuGhWpTXyOoMhGTJXJM4bp+rpkCJY/EvTOnEr7rM4PX+0upmbP8MbHrIIR+Mbqo/r3hPLXiX7YpZc+iB046HUF/2QWH9l8XShDkVuSTl9C0RubHG9lGs9TmSm4jDASj9iuRG0lxgrLHbYIdDF/Yls7d0ATdA=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1656.namprd21.prod.outlook.com (2603:10b6:a02:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.3; Thu, 1 Jul
 2021 06:51:25 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3%5]) with mapi id 15.20.4308.007; Thu, 1 Jul 2021
 06:51:25 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
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
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basp6bQAgAPHdaA=
Date:   Thu, 1 Jul 2021 06:51:25 +0000
Message-ID: <BY5PR21MB1506ACF89447B492B0F7E066CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34b74f3b-f78a-4066-9c87-8e11622defa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T14:56:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 737660c1-f473-4ecd-4b38-08d93c5ca549
x-ms-traffictypediagnostic: BYAPR21MB1656:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1656CBA773528C26EA2FF543CE009@BYAPR21MB1656.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KXrWH+Gu6xghxZMuTKkfQVSuGQUogB6SNuswm1a0XiLhzZla9kaquesaKk78ZQlHicNMtqDO0jKtcTuE2GOG57uHzptGal5bOUMzFOkTU1nvta3VMXNNSJduE+4E7QwkBnC2Va5kH8nQqjjP93b2aT/JeSEdKnXedMd7uheF1ydZ1HuWA7hhRFUMbmTDE+b4u9LN/PHKH+aQ2QIq7dvKHxqekEiEbikfqFmjg3mFgvTSrABdGvFNnOkT5poIo8s3dkfN+myDKF88h/lSPhsPqztC2Wb1NCy6a4pJ5yy8RNdfxmpnt9MHBL1ktmmXUtrkq/bSnSGZV+KZdIwJ2pllFdjHlaaurbhAJkqmaBzA+FVKwVic4UlnDoD00BIxAOYczHZdx+rn2Nqi20nZDBftY4gxpFCH+VX66AhIb56TgY+jDt80LToXzZjrhua1sjiHzBtVrsPvr7Mu7xcorR3MqWvs9yqsSfbi9lIqnZjvNQMY4ujl1X1QfcPIMTJB9FLZLbDk2xDUnrcRIs/YmD/RchLxhH+VdjcAhs3Ge3x/KBzX/SO6uhWVeXT21xN4yj6B5N3C1IELfUSKPDeCEng7stwnoczZ5BPohwSfITrsNgHh9EXfCFcQUJTa7B6n1x/h7o1oj4fqtTbMbCWNwvX8/iaPn2sWa3RtyqfcUf9Csmq4OHfUcfabRM3gkhgWfPNtyejG3wZ0V9md+O0sM+p5ZQvcBFFa+ulUVL3vuZXRVHpyCBsywknTTjyujtEMp08HB/QN4eyV1r++mKhKPRozw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(71200400001)(2906002)(38100700002)(8936002)(122000001)(5660300002)(478600001)(30864003)(10290500003)(8676002)(7696005)(83380400001)(26005)(54906003)(316002)(86362001)(66946007)(6506007)(76116006)(4326008)(33656002)(66476007)(110136005)(64756008)(9686003)(82960400001)(186003)(66556008)(55016002)(82950400001)(66446008)(8990500004)(52536014)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IG7GDDXWSSoXLZHd2sroZpJaOX8cIixij5x1H0fyTH3NSUd5M0yfjeouqHf1?=
 =?us-ascii?Q?MgseGtFPhlPNpjNoRiyoVJA2EyrLf45sumr3Moc/vA/+SgxxjDdBGwTPcIHr?=
 =?us-ascii?Q?SSnp1a04LdML9qytWaUku5Ocs5JCPfkbu8IltEKSoFT/goUdQCFpTvjdHf8H?=
 =?us-ascii?Q?J0JsKfjOYS4+6l4iTWIrk9JVPsva+sF7R677U+9AfBQXH7TEuhxvPl77jFnF?=
 =?us-ascii?Q?L+GYWoJxF/nKpNmK+TNZaqgnafJNBr+X8aGm6FuAj8Y+BK5CUR6LXflNtTsv?=
 =?us-ascii?Q?ATURCjM0uOmEvwYwHrg71y8FCviIz9poojjHk5By2VXtQ0zrpgalBjMIenN0?=
 =?us-ascii?Q?U+Y+gGU8cKBlkhzyEn/brWMwmhZQoiyeKDq3voA2+3uVZl0r00jkoXYsepkr?=
 =?us-ascii?Q?d111Za1p2vN/6qxMxerUQj1zVmWxifoB1mZWY+IsVhmLO6Guzh8iYV0YMFJR?=
 =?us-ascii?Q?y9nyJzTMRrMKyTmZBDp00wLKFfKeioQXVF6nfaZmvQBmjlE2W8g1mzuGwFJM?=
 =?us-ascii?Q?G5LqSj+jkNx2i5J/os4R1i56sxuyFL9UVGuHaXp2+7st0rd/gWjT3dqPqI6t?=
 =?us-ascii?Q?lFMmPqxLhQLeQiJmuYbvVrY1F1b711krsbusWnYnfq/NnrqhIcuwpcXtPKPY?=
 =?us-ascii?Q?N3JH7BSGeKNOY2dWJZnjWG1KOxd8WBVhBa/d2nblCreo5sxZj6ix3r5pvHTm?=
 =?us-ascii?Q?5LouF5iC4DnMdwfggv8tUrbWtbqTMKh0UkR4YZXwip2MjoM+8AVBNy0Ht9wC?=
 =?us-ascii?Q?j71SjyFMqJZr8fndbWUK/QeFQa5b6zMuKhdSqk6ZwVopHQP5hEUI06DreYeK?=
 =?us-ascii?Q?ZCJc85XeezhoUx8k1J2PL7SMn3vxQtw3LqRp2YKbI62ePyKRSVncK7Lus9NX?=
 =?us-ascii?Q?LDug0ISPjBPdcBBjlqRxOFc7ZUrZJpUYED3aagl6AkoorFLaL2nlZ1jFviLo?=
 =?us-ascii?Q?cZb+p/JBgBdCDDehdmfAL+z9V7Lktge1ycncgG+VVjVnSGeVyTgNAVfkVWWl?=
 =?us-ascii?Q?G6z5WKELz6ks3NPbPtfmlwlDtYRBCP6qz6vu5I2kFbejKZRX1FDhbUwtpRZh?=
 =?us-ascii?Q?alzjUgf79fl3ltUZH+x/ZigDMsGIV3YvZxKKuuRb2OE8pNjMqOVLd6GFOBQN?=
 =?us-ascii?Q?WTgNT5rbNP3hSwsUHOpIoqL2IAZPG/de/fuBD/9o6zcodPRPpPHf7zjWCWRv?=
 =?us-ascii?Q?DCvCqdl1xp4ZzCDvJCc7J61Oq3XlvGHO+1mBMN5UlkXwjQ0waa89n2KJSGqF?=
 =?us-ascii?Q?wcEZdIXfjhI5iHGdfdlnL+a+FmJ83GXB/I68hyheTg9pNjVyjfCOhQgcv6R2?=
 =?us-ascii?Q?NBDDBI9Vra/9Qz1DM741k/Ha?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737660c1-f473-4ecd-4b38-08d93c5ca549
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 06:51:25.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oi4uOh7gGv1/rNyzR3P8TiZC2KGRIPmDn/L7ilfK/6JaipeYH38IdxyRcMX1b8MGaCrcIcKnOy6oeckdMH+eSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1656
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Friday,
> June 25, 2021 11:30 PM
> >
> > Azure Blob storage provides scalable and durable data storage for Azure=
.
> > (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Faz=
u
> > re.microsoft.com%2Fen-
> us%2Fservices%2Fstorage%2Fblobs%2F&amp;data=3D04%7
> >
> C01%7Clongli%40microsoft.com%7Cd8cabb55b9f24e98fefe08d93a7651e2%
> 7C72f9
> >
> 88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637605102139607593%7C
> Unknown%7C
> >
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> XVC
> >
> I6Mn0%3D%7C1000&amp;sdata=3DGfpN0Gb5IkkdeSe4e0zaW3y7iRYAoRFVicYIy
> L4F9T8%
> > 3D&amp;reserved=3D0)
> >
> > This driver adds support for accelerated access to Azure Blob storage.
> > As an alternative to REST APIs, it provides a fast data path that uses
> > host native network stack and secure direct data link for storage serve=
r
> access.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Maximilian Luz <luzmaximilian@gmail.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Andra Paraschiv <andraprs@amazon.com>
> > Cc: Siddharth Gupta <sidgup@codeaurora.org>
> > Cc: Hannes Reinecke <hare@suse.de>
> > Cc: linux-doc@vger.kernel.org
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +
> >  drivers/hv/Kconfig                                 |  10 +
> >  drivers/hv/Makefile                                |   1 +
> >  drivers/hv/azure_blob.c                            | 655 +++++++++++++=
++++++++
> >  drivers/hv/channel_mgmt.c                          |   7 +
> >  include/linux/hyperv.h                             |   9 +
> >  include/uapi/misc/azure_blob.h                     |  31 +
> >  7 files changed, 715 insertions(+)
> >  create mode 100644 drivers/hv/azure_blob.c  create mode 100644
> > include/uapi/misc/azure_blob.h
> >
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 9bfc2b5..d3c2a90 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -180,6 +180,8 @@ Code  Seq#    Include File
> Comments
> >  'R'   01     linux/rfkill.h                                          c=
onflict!
> >  'R'   C0-DF  net/bluetooth/rfcomm.h
> >  'R'   E0     uapi/linux/fsl_mc.h
> > +'R'   F0-FF  uapi/misc/azure_blob.h                                  M=
icrosoft Azure Blob
> driver
> > +
> > +<mailto:longli@microsoft.com>
> >  'S'   all    linux/cdrom.h                                           c=
onflict!
> >  'S'   80-81  scsi/scsi_ioctl.h                                       c=
onflict!
> >  'S'   82-FF  scsi/scsi.h                                             c=
onflict!
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
> > 66c794d..e08b8d3 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -27,4 +27,14 @@ config HYPERV_BALLOON
> >  	help
> >  	  Select this option to enable Hyper-V Balloon driver.
> >
> > +config HYPERV_AZURE_BLOB
> > +	tristate "Microsoft Azure Blob driver"
> > +	depends on HYPERV && X86_64
> > +	help
> > +	  Select this option to enable Microsoft Azure Blob driver.
> > +
> > +	  This driver supports accelerated Microsoft Azure Blob access.
> > +	  To compile this driver as a module, choose M here. The module will
> be
> > +	  called azure_blob.
> > +
> >  endmenu
> > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile index
> > 94daf82..a322575 100644
> > --- a/drivers/hv/Makefile
> > +++ b/drivers/hv/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
> >  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
> >  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> > +obj-$(CONFIG_HYPERV_AZURE_BLOB)	+=3D azure_blob.o
> >
> >  CFLAGS_hv_trace.o =3D -I$(src)
> >  CFLAGS_hv_balloon.o =3D -I$(src)
> > diff --git a/drivers/hv/azure_blob.c b/drivers/hv/azure_blob.c new
> > file mode 100644 index 0000000..6c8f957
> > --- /dev/null
> > +++ b/drivers/hv/azure_blob.c
> > @@ -0,0 +1,655 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > +/* Copyright (c) 2021, Microsoft Corporation. */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/cred.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/hyperv.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/uio.h>
> > +#include <uapi/misc/azure_blob.h>
> > +
> > +struct az_blob_device {
> > +	struct hv_device *device;
> > +
> > +	/* Opened files maintained by this device */
> > +	struct list_head file_list;
> > +	spinlock_t file_lock;
> > +	wait_queue_head_t file_wait;
> > +
> > +	bool removing;
> > +};
> > +
> > +/* VSP messages */
> > +enum az_blob_vsp_request_type {
> > +	AZ_BLOB_DRIVER_REQUEST_FIRST     =3D 0x100,
> > +	AZ_BLOB_DRIVER_USER_REQUEST      =3D 0x100,
> > +	AZ_BLOB_DRIVER_REGISTER_BUFFER   =3D 0x101,
> > +	AZ_BLOB_DRIVER_DEREGISTER_BUFFER =3D 0x102, };
> > +
> > +/* VSC->VSP request */
> > +struct az_blob_vsp_request {
> > +	u32 version;
> > +	u32 timeout_ms;
> > +	u32 data_buffer_offset;
> > +	u32 data_buffer_length;
> > +	u32 data_buffer_valid;
> > +	u32 operation_type;
> > +	u32 request_buffer_offset;
> > +	u32 request_buffer_length;
> > +	u32 response_buffer_offset;
> > +	u32 response_buffer_length;
> > +	guid_t transaction_id;
> > +} __packed;
> > +
> > +/* VSP->VSC response */
> > +struct az_blob_vsp_response {
> > +	u32 length;
> > +	u32 error;
> > +	u32 response_len;
> > +} __packed;
> > +
> > +struct az_blob_vsp_request_ctx {
> > +	struct list_head list;
> > +	struct completion wait_vsp;
> > +	struct az_blob_request_sync *request; };
> > +
> > +struct az_blob_file_ctx {
> > +	struct list_head list;
> > +
> > +	/* List of pending requests to VSP */
> > +	struct list_head vsp_pending_requests;
> > +	spinlock_t vsp_pending_lock;
> > +	wait_queue_head_t wait_vsp_pending;
> > +};
> > +
> > +/* The maximum number of pages we can pass to VSP in a single packet
> > +*/ #define AZ_BLOB_MAX_PAGES 8192
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +struct dentry *az_blob_debugfs_root;
> > +#endif
> > +
> > +static struct az_blob_device az_blob_dev;
> > +
> > +static int az_blob_ringbuffer_size =3D (128 * 1024);
> > +module_param(az_blob_ringbuffer_size, int, 0444);
> > +MODULE_PARM_DESC(az_blob_ringbuffer_size, "Ring buffer size
> > +(bytes)");
> > +
> > +static const struct hv_vmbus_device_id id_table[] =3D {
> > +	{ HV_AZURE_BLOB_GUID,
> > +	  .driver_data =3D 0
> > +	},
> > +	{ },
> > +};
> > +
> > +#define AZ_ERR 0
> > +#define AZ_WARN 1
> > +#define AZ_DBG 2
> > +static int log_level =3D AZ_ERR;
> > +module_param(log_level, int, 0644);
> > +MODULE_PARM_DESC(log_level,
> > +	"Log level: 0 - Error (default), 1 - Warning, 2 - Debug.");
> > +
> > +static uint device_queue_depth =3D 1024;
> > +module_param(device_queue_depth, uint, 0444);
> > +MODULE_PARM_DESC(device_queue_depth,
> > +	"System level max queue depth for this device");
> > +
> > +#define az_blob_log(level, fmt, args...)	\
> > +do {	\
> > +	if (level <=3D log_level)	\
> > +		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
> > +} while (0)
> > +
> > +#define az_blob_dbg(fmt, args...) az_blob_log(AZ_DBG, fmt, ##args)
> > +#define az_blob_warn(fmt, args...) az_blob_log(AZ_WARN, fmt, ##args)
> > +#define az_blob_err(fmt, args...) az_blob_log(AZ_ERR, fmt, ##args)
> > +
> > +static void az_blob_on_channel_callback(void *context) {
> > +	struct vmbus_channel *channel =3D (struct vmbus_channel *)context;
> > +	const struct vmpacket_descriptor *desc;
> > +
> > +	az_blob_dbg("entering interrupt from vmbus\n");
> > +	foreach_vmbus_pkt(desc, channel) {
> > +		struct az_blob_vsp_request_ctx *request_ctx;
> > +		struct az_blob_vsp_response *response;
> > +		u64 cmd_rqst =3D vmbus_request_addr(&channel->requestor,
> > +					desc->trans_id);
> > +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> > +			az_blob_err("incorrect transaction id %llu\n",
> > +				desc->trans_id);
> > +			continue;
> > +		}
> > +		request_ctx =3D (struct az_blob_vsp_request_ctx *) cmd_rqst;
> > +		response =3D hv_pkt_data(desc);
> > +
> > +		az_blob_dbg("got response for request %pUb status %u "
> > +			"response_len %u\n",
> > +			&request_ctx->request->guid, response->error,
> > +			response->response_len);
> > +		request_ctx->request->response.status =3D response->error;
> > +		request_ctx->request->response.response_len =3D
> > +			response->response_len;
> > +		complete(&request_ctx->wait_vsp);
> > +	}
> > +
> > +}
> > +
> > +static int az_blob_fop_open(struct inode *inode, struct file *file) {
> > +	struct az_blob_file_ctx *file_ctx;
> > +	unsigned long flags;
> > +
> > +
> > +	file_ctx =3D kzalloc(sizeof(*file_ctx), GFP_KERNEL);
> > +	if (!file_ctx)
> > +		return -ENOMEM;
> > +
> > +
> > +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> > +	if (az_blob_dev.removing) {
> > +		spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> > +		kfree(file_ctx);
> > +		return -ENODEV;
> > +	}
> > +	list_add_tail(&file_ctx->list, &az_blob_dev.file_list);
> > +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> > +
> > +	INIT_LIST_HEAD(&file_ctx->vsp_pending_requests);
> > +	init_waitqueue_head(&file_ctx->wait_vsp_pending);
>=20
> It feels a little weird to be initializing fields in the file_ctx
> *after* it has been added to the file list.  But I guess it's OK since no=
 requests
> can be issued and the file can't be closed until after this open call com=
pletes.
>=20
> > +	file->private_data =3D file_ctx;
> > +
> > +	return 0;
> > +}
> > +
> > +static int az_blob_fop_release(struct inode *inode, struct file
> > +*file) {
> > +	struct az_blob_file_ctx *file_ctx =3D file->private_data;
> > +	unsigned long flags;
> > +
> > +	wait_event(file_ctx->wait_vsp_pending,
> > +		list_empty(&file_ctx->vsp_pending_requests));
> > +
> > +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> > +	list_del(&file_ctx->list);
> > +	if (list_empty(&az_blob_dev.file_list))
> > +		wake_up(&az_blob_dev.file_wait);
> > +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static inline bool az_blob_safe_file_access(struct file *file) {
> > +	return file->f_cred =3D=3D current_cred() && !uaccess_kernel(); }
> > +
> > +static int get_buffer_pages(int rw, void __user *buffer, u32 buffer_le=
n,
> > +	struct page ***ppages, size_t *start, size_t *num_pages) {
> > +	struct iovec iov;
> > +	struct iov_iter iter;
> > +	int ret;
> > +	ssize_t result;
> > +	struct page **pages;
> > +
> > +	ret =3D import_single_range(rw, buffer, buffer_len, &iov, &iter);
> > +	if (ret) {
> > +		az_blob_dbg("request buffer access error %d\n", ret);
> > +		return ret;
> > +	}
> > +	az_blob_dbg("iov_iter type %d offset %lu count %lu nr_segs %lu\n",
> > +		iter.type, iter.iov_offset, iter.count, iter.nr_segs);
> > +
> > +	result =3D iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start)=
;
> > +	if (result < 0) {
> > +		az_blob_dbg("failed to pin user pages result=3D%ld\n", result);
> > +		return result;
> > +	}
> > +	if (result !=3D buffer_len) {
> > +		az_blob_dbg("can't pin user pages requested %d got %ld\n",
> > +			buffer_len, result);
> > +		return -EFAULT;
> > +	}
> > +
> > +	*ppages =3D pages;
> > +	*num_pages =3D (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
> > +	return 0;
> > +}
> > +
> > +static void fill_in_page_buffer(u64 *pfn_array,
> > +	int *index, struct page **pages, unsigned long num_pages) {
> > +	int i, page_idx =3D *index;
> > +
> > +	for (i =3D 0; i < num_pages; i++)
> > +		pfn_array[page_idx++] =3D page_to_pfn(pages[i]);
> > +	*index =3D page_idx;
> > +}
> > +
> > +static void free_buffer_pages(size_t num_pages, struct page **pages)
> > +{
> > +	unsigned long i;
> > +
> > +	for (i =3D 0; i < num_pages; i++)
> > +		if (pages[i])
> > +			put_page(pages[i]);
> > +	kvfree(pages);
> > +}
> > +
> > +static long az_blob_ioctl_user_request(struct file *filp, unsigned
> > +long arg) {
> > +	struct az_blob_device *dev =3D &az_blob_dev;
> > +	struct az_blob_file_ctx *file_ctx =3D filp->private_data;
> > +	char __user *argp =3D (char __user *) arg;
> > +	struct az_blob_request_sync request;
> > +	struct az_blob_vsp_request_ctx request_ctx;
> > +	unsigned long flags;
> > +	int ret;
> > +	size_t request_start, request_num_pages =3D 0;
> > +	size_t response_start, response_num_pages =3D 0;
> > +	size_t data_start, data_num_pages =3D 0, total_num_pages;
> > +	struct page **request_pages =3D NULL, **response_pages =3D NULL;
> > +	struct page **data_pages =3D NULL;
> > +	struct vmbus_packet_mpb_array *desc;
> > +	u64 *pfn_array;
> > +	int desc_size;
> > +	int page_idx;
> > +	struct az_blob_vsp_request *vsp_request;
> > +
> > +	/* Fast fail if device is being removed */
> > +	if (dev->removing)
> > +		return -ENODEV;
> > +
> > +	if (!az_blob_safe_file_access(filp)) {
> > +		az_blob_dbg("process %d(%s) changed security contexts
> after"
> > +			" opening file descriptor\n",
> > +			task_tgid_vnr(current), current->comm);
> > +		return -EACCES;
> > +	}
> > +
> > +	if (copy_from_user(&request, argp, sizeof(request))) {
> > +		az_blob_dbg("don't have permission to user provided
> buffer\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	az_blob_dbg("az_blob ioctl request guid %pUb timeout %u
> request_len %u"
> > +		" response_len %u data_len %u request_buffer %llx "
> > +		"response_buffer %llx data_buffer %llx\n",
> > +		&request.guid, request.timeout, request.request_len,
> > +		request.response_len, request.data_len,
> request.request_buffer,
> > +		request.response_buffer, request.data_buffer);
> > +
> > +	if (!request.request_len || !request.response_len)
> > +		return -EINVAL;
> > +
> > +	if (request.data_len && request.data_len < request.data_valid)
> > +		return -EINVAL;
> > +
> > +	init_completion(&request_ctx.wait_vsp);
> > +	request_ctx.request =3D &request;
> > +
> > +	/*
> > +	 * Need to set rw to READ to have page table set up for passing to VS=
P.
> > +	 * Setting it to WRITE will cause the page table entry not allocated
> > +	 * as it's waiting on Copy-On-Write on next page fault. This doesn't
> > +	 * work in this scenario because VSP wants all the pages to be presen=
t.
> > +	 */
> > +	ret =3D get_buffer_pages(READ, (void __user *) request.request_buffer=
,
> > +		request.request_len, &request_pages, &request_start,
> > +		&request_num_pages);
> > +	if (ret)
> > +		goto get_user_page_failed;
> > +
> > +	ret =3D get_buffer_pages(READ, (void __user *)
> request.response_buffer,
> > +		request.response_len, &response_pages, &response_start,
> > +		&response_num_pages);
> > +	if (ret)
> > +		goto get_user_page_failed;
> > +
> > +	if (request.data_len) {
> > +		ret =3D get_buffer_pages(READ,
> > +			(void __user *) request.data_buffer, request.data_len,
> > +			&data_pages, &data_start, &data_num_pages);
> > +		if (ret)
> > +			goto get_user_page_failed;
> > +	}
>=20
> It still seems to me that request.request_len, request.response_len, and
> request.data_len should be validated *before* get_buffer_pages() is calle=
d.
> While the total number of pages that pinned is validated below against
> AZ_BLOB_MAX_PAGES, bad values in the *_len fields could pin up to
> 12 Gbytes of memory before the check against AZ_BLOB_MAX_PAGES
> happens.   The pre-validation would make sure that each *_len value
> is less than AZ_BLOB_MAX_PAGES, so that the max amount of memory that
> could get pinned is 96 Mbytes.
>=20
> Also, are the *_len values required to be a multiple of PAGE_SIZE?
> I'm assuming not, and that any number of bytes is acceptable.  If there i=
s some
> requirement such as being a multiple of 512 or something like that, it sh=
ould
> also be part of the pre-validation.

*len values are not required to be aligned to page size or 512.

Adding pre-validation to those *len is a good idea. I'll make changes.

>=20
> > +
> > +	total_num_pages =3D request_num_pages + response_num_pages +
> > +				data_num_pages;
> > +	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
> > +		az_blob_dbg("number of DMA pages %lu buffer
> exceeding %u\n",
> > +			total_num_pages, AZ_BLOB_MAX_PAGES);
> > +		ret =3D -EINVAL;
> > +		goto get_user_page_failed;
> > +	}
> > +
> > +	/* Construct a VMBUS packet and send it over to VSP */
> > +	desc_size =3D sizeof(struct vmbus_packet_mpb_array) +
> > +			sizeof(u64) * total_num_pages;
> > +	desc =3D kzalloc(desc_size, GFP_KERNEL);
> > +	vsp_request =3D kzalloc(sizeof(*vsp_request), GFP_KERNEL);
> > +	if (!desc || !vsp_request) {
> > +		kfree(desc);
> > +		kfree(vsp_request);
> > +		ret =3D -ENOMEM;
> > +		goto get_user_page_failed;
> > +	}
> > +
> > +	desc->range.offset =3D 0;
> > +	desc->range.len =3D total_num_pages * PAGE_SIZE;
>=20
> The range.len value is always a multiple of PAGE_SIZE.  Assuming that the
> request.*_len values are not required to be multiples of PAGE_SIZE, then =
the
> sum of the buffer_length fields in the vsp_request may not add up to
> range.len.  Presumably the VSP is OK with that ....

range.len describes the length of whole array of page buffers sent to the h=
ost, the individual buffers within the page buffers are described by *_offs=
et and *_length in the VSP packet.

>=20
> > +	pfn_array =3D desc->range.pfn_array;
> > +	page_idx =3D 0;
> > +
> > +	if (request.data_len) {
> > +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> > +			data_num_pages);
> > +		vsp_request->data_buffer_offset =3D data_start;
> > +		vsp_request->data_buffer_length =3D request.data_len;
> > +		vsp_request->data_buffer_valid =3D request.data_valid;
> > +	}
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> > +		request_num_pages);
> > +	vsp_request->request_buffer_offset =3D request_start +
> > +						data_num_pages * PAGE_SIZE;
> > +	vsp_request->request_buffer_length =3D request.request_len;
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> > +		response_num_pages);
> > +	vsp_request->response_buffer_offset =3D response_start +
> > +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> > +	vsp_request->response_buffer_length =3D request.response_len;
>=20
> Interestingly, if any of the data or request or response are adjacent in =
user
> memory, but the boundary is not on a page boundary, the same page may
> appear in two successive pfn_array entries.  Again, I'm assuming that's O=
K with
> the VSP.  It appears that the VSP just treats the three memory areas as
> completely independent of each other but defined by sequential entries in
> the pfn_array.

Yes the VSP is okay with that. We can send duplicate page numbers to the VS=
P if the buffers don't end with page boundary, and are next to each other.

>=20
> > +
> > +	vsp_request->version =3D 0;
> > +	vsp_request->timeout_ms =3D request.timeout;
> > +	vsp_request->operation_type =3D AZ_BLOB_DRIVER_USER_REQUEST;
> > +	guid_copy(&vsp_request->transaction_id, &request.guid);
> > +
> > +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> > +	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
> > +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
> > +
> > +	az_blob_dbg("sending request to VSP\n");
> > +	az_blob_dbg("desc_size %u desc->range.len %u desc-
> >range.offset %u\n",
> > +		desc_size, desc->range.len, desc->range.offset);
> > +	az_blob_dbg("vsp_request data_buffer_offset %u
> data_buffer_length %u "
> > +		"data_buffer_valid %u request_buffer_offset %u "
> > +		"request_buffer_length %u response_buffer_offset %u "
> > +		"response_buffer_length %u\n",
> > +		vsp_request->data_buffer_offset,
> > +		vsp_request->data_buffer_length,
> > +		vsp_request->data_buffer_valid,
> > +		vsp_request->request_buffer_offset,
> > +		vsp_request->request_buffer_length,
> > +		vsp_request->response_buffer_offset,
> > +		vsp_request->response_buffer_length);
> > +
> > +	ret =3D vmbus_sendpacket_mpb_desc(dev->device->channel, desc,
> desc_size,
> > +		vsp_request, sizeof(*vsp_request), (u64) &request_ctx);
> > +
> > +	kfree(desc);
> > +	kfree(vsp_request);
> > +	if (ret)
> > +		goto vmbus_send_failed;
> > +
> > +	wait_for_completion(&request_ctx.wait_vsp);
> > +
> > +	/*
> > +	 * At this point, the response is already written to request
> > +	 * by VMBUS completion handler, copy them to user-mode buffers
> > +	 * and return to user-mode
> > +	 */
> > +	if (copy_to_user(argp +
> > +			offsetof(struct az_blob_request_sync,
> > +				response.status),
> > +			&request.response.status,
> > +			sizeof(request.response.status))) {
> > +		ret =3D -EFAULT;
> > +		goto vmbus_send_failed;
> > +	}
> > +
> > +	if (copy_to_user(argp +
> > +			offsetof(struct az_blob_request_sync,
> > +				response.response_len),
> > +			&request.response.response_len,
> > +			sizeof(request.response.response_len)))
> > +		ret =3D -EFAULT;
> > +
> > +vmbus_send_failed:
> > +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> > +	list_del(&request_ctx.list);
> > +	if (list_empty(&file_ctx->vsp_pending_requests))
> > +		wake_up(&file_ctx->wait_vsp_pending);
> > +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
> > +
> > +get_user_page_failed:
> > +	free_buffer_pages(request_num_pages, request_pages);
> > +	free_buffer_pages(response_num_pages, response_pages);
> > +	free_buffer_pages(data_num_pages, data_pages);
> > +
> > +	return ret;
> > +}
> > +
> > +static long az_blob_fop_ioctl(struct file *filp, unsigned int cmd,
> > +	unsigned long arg)
> > +{
> > +	long ret =3D -EIO;
> > +
> > +	switch (cmd) {
> > +	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
> > +		if (_IOC_SIZE(cmd) !=3D sizeof(struct az_blob_request_sync))
> > +			return -EINVAL;
> > +		ret =3D az_blob_ioctl_user_request(filp, arg);
> > +		break;
> > +
> > +	default:
> > +		az_blob_dbg("unrecognized IOCTL code %u\n", cmd);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations az_blob_client_fops =3D {
> > +	.owner	=3D THIS_MODULE,
> > +	.open	=3D az_blob_fop_open,
> > +	.unlocked_ioctl =3D az_blob_fop_ioctl,
> > +	.release =3D az_blob_fop_release,
> > +};
> > +
> > +static struct miscdevice az_blob_misc_device =3D {
> > +	MISC_DYNAMIC_MINOR,
> > +	"azure_blob",
> > +	&az_blob_client_fops,
> > +};
> > +
> > +static int az_blob_show_pending_requests(struct seq_file *m, void *v)
> > +{
> > +	unsigned long flags, flags2;
> > +	struct az_blob_vsp_request_ctx *request_ctx;
> > +	struct az_blob_file_ctx *file_ctx;
> > +
> > +	seq_puts(m, "List of pending requests\n");
> > +	seq_puts(m, "UUID request_len response_len data_len "
> > +		"request_buffer response_buffer data_buffer\n");
> > +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> > +	list_for_each_entry(file_ctx, &az_blob_dev.file_list, list) {
> > +		spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags2);
> > +		list_for_each_entry(request_ctx,
> > +				&file_ctx->vsp_pending_requests, list) {
> > +			seq_printf(m, "%pUb ", &request_ctx->request->guid);
> > +			seq_printf(m, "%u ", request_ctx->request-
> >request_len);
> > +			seq_printf(m,
> > +				"%u ", request_ctx->request->response_len);
> > +			seq_printf(m, "%u ", request_ctx->request->data_len);
> > +			seq_printf(m,
> > +				"%llx ", request_ctx->request-
> >request_buffer);
> > +			seq_printf(m,
> > +				"%llx ", request_ctx->request-
> >response_buffer);
> > +			seq_printf(m,
> > +				"%llx\n", request_ctx->request->data_buffer);
> > +		}
> > +		spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags2);
> > +	}
> > +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int az_blob_debugfs_open(struct inode *inode, struct file
> > +*file) {
> > +	return single_open(file, az_blob_show_pending_requests, NULL); }
> > +
> > +static const struct file_operations az_blob_debugfs_fops =3D {
> > +	.open		=3D az_blob_debugfs_open,
> > +	.read		=3D seq_read,
> > +	.llseek		=3D seq_lseek,
> > +	.release	=3D seq_release
> > +};
> > +
> > +static void az_blob_remove_device(struct az_blob_device *dev) {
> > +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> > +	misc_deregister(&az_blob_misc_device);
> > +#ifdef CONFIG_DEBUG_FS
> > +	debugfs_remove_recursive(az_blob_debugfs_root);
> > +#endif
> > +	/* At this point, we won't get any requests from user-mode */ }
> > +
> > +static int az_blob_create_device(struct az_blob_device *dev) {
> > +	int rc;
> > +	struct dentry *d;
> > +
> > +	rc =3D misc_register(&az_blob_misc_device);
> > +	if (rc) {
> > +		az_blob_err("misc_register failed rc %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> > +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
> > +		d =3D debugfs_create_file("pending_requests", 0400,
> > +			az_blob_debugfs_root, NULL,
> > +			&az_blob_debugfs_fops);
> > +		if (IS_ERR_OR_NULL(d)) {
> > +			az_blob_warn("failed to create debugfs file\n");
> > +			debugfs_remove_recursive(az_blob_debugfs_root);
> > +			az_blob_debugfs_root =3D NULL;
> > +		}
> > +	} else
> > +		az_blob_warn("failed to create debugfs root\n"); #endif
> > +
> > +	return 0;
> > +}
> > +
> > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > +ring_size) {
> > +	int ret;
> > +
> > +	spin_lock_init(&az_blob_dev.file_lock);
>=20
> I'd argue that the spin lock should not be re-initialized here.  Here's t=
he
> sequence where things go wrong:
>=20
> 1) The driver is unbound, so az_blob_remove() is called.
> 2) az_blob_remove() sets the "removing" flag to true, and calls
> az_blob_remove_device().
> 3) az_blob_remove_device() waits for the file_list to become empty.
> 4) After the file_list becomes empty, but before misc_deregister() is cal=
led, a
> separate thread opens the device again.
> 5) In the separate thread, az_blob_fop_open() obtains the file_lock spin =
lock.
> 6) Before az_blob_fop_open() releases the spin lock, az
> block_remove_device() completes, along with az_blob_remove().
> 7) Then the device gets rebound, and az_blob_connect_to_vsp() gets called=
,
> all while az_blob_fop_open() still holds the spin lock.  So the spin lock=
 get re-
> initialized while it is held.
>=20
> This is admittedly a far-fetched scenario, but stranger things have
> happened. :-)  The issue is that you are counting on the az_blob_dev stru=
cture
> to persist and have a valid file_lock, even while the device is unbound. =
 So any
> initialization should only happen in az_blob_drv_init().

I'm not sure if az_blob_probe() and az_blob_remove() can be called at the s=
ame time, as az_blob_remove_vmbus() is called the last in az_blob_remove().=
 Is it possible for vmbus asking the driver to probe a new channel before t=
he old channel is closed? I expect the vmbus provide guarantee that those c=
alls are made in sequence.

>=20
> > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > +
> > +	az_blob_dev.removing =3D false;
> > +
> > +	az_blob_dev.device =3D device;
> > +	device->channel->rqstor_size =3D device_queue_depth;
> > +
> > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> > +			az_blob_on_channel_callback, device->channel);
> > +
> > +	if (ret) {
> > +		az_blob_err("failed to connect to VSP ret %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	hv_set_drvdata(device, &az_blob_dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static void az_blob_remove_vmbus(struct hv_device *device) {
> > +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> > +	hv_set_drvdata(device, NULL);
> > +	vmbus_close(device->channel);
> > +}
> > +
> > +static int az_blob_probe(struct hv_device *device,
> > +			const struct hv_vmbus_device_id *dev_id) {
> > +	int rc;
> > +
> > +	az_blob_dbg("probing device\n");
> > +
> > +	rc =3D az_blob_connect_to_vsp(device, az_blob_ringbuffer_size);
> > +	if (rc) {
> > +		az_blob_err("error connecting to VSP rc %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	// create user-mode client library facing device
> > +	rc =3D az_blob_create_device(&az_blob_dev);
> > +	if (rc) {
> > +		az_blob_remove_vmbus(device);
> > +		return rc;
> > +	}
> > +
> > +	az_blob_dbg("successfully probed device\n");
> > +	return 0;
> > +}
> > +
> > +static int az_blob_remove(struct hv_device *dev) {
> > +	struct az_blob_device *device =3D hv_get_drvdata(dev);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&device->file_lock, flags);
> > +	device->removing =3D true;
> > +	spin_unlock_irqrestore(&device->file_lock, flags);
> > +
> > +	az_blob_remove_device(device);
> > +	az_blob_remove_vmbus(dev);
> > +	return 0;
> > +}
> > +
> > +static struct hv_driver az_blob_drv =3D {
> > +	.name =3D KBUILD_MODNAME,
> > +	.id_table =3D id_table,
> > +	.probe =3D az_blob_probe,
> > +	.remove =3D az_blob_remove,
> > +	.driver =3D {
> > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> > +};
> > +
> > +static int __init az_blob_drv_init(void) {
> > +	int ret;
> > +
> > +	ret =3D vmbus_driver_register(&az_blob_drv);
> > +	return ret;
> > +}
> > +
> > +static void __exit az_blob_drv_exit(void) {
> > +	vmbus_driver_unregister(&az_blob_drv);
> > +}
> > +
> > +MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_DESCRIPTION("Microsoft Azure Blob driver");
> > +module_init(az_blob_drv_init); module_exit(az_blob_drv_exit);
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 0c75662..436fdeb 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -154,6 +154,13 @@
> >  	  .allowed_in_isolated =3D false,
> >  	},
> >
> > +	/* Azure Blob */
> > +	{ .dev_type =3D HV_AZURE_BLOB,
> > +	  HV_AZURE_BLOB_GUID,
> > +	  .perf_device =3D false,
> > +	  .allowed_in_isolated =3D false,
> > +	},
> > +
> >  	/* Unknown GUID */
> >  	{ .dev_type =3D HV_UNKNOWN,
> >  	  .perf_device =3D false,
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > d1e59db..ac31362 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -772,6 +772,7 @@ enum vmbus_device_type {
> >  	HV_FCOPY,
> >  	HV_BACKUP,
> >  	HV_DM,
> > +	HV_AZURE_BLOB,
> >  	HV_UNKNOWN,
> >  };
> >
> > @@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource
> **new, struct hv_device *device_obj,
> >  			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
> >
> >  /*
> > + * Azure Blob GUID
> > + * {0590b792-db64-45cc-81db-b8d70c577c9e}
> > + */
> > +#define HV_AZURE_BLOB_GUID \
> > +	.guid =3D GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
> > +			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
> > +
> > +/*
> >   * Shutdown GUID
> >   * {0e0b6031-5213-4934-818b-38d90ced39db}
> >   */
> > diff --git a/include/uapi/misc/azure_blob.h
> > b/include/uapi/misc/azure_blob.h new file mode 100644 index
> > 0000000..29413fc
> > --- /dev/null
> > +++ b/include/uapi/misc/azure_blob.h
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> > +/* Copyright (c) 2021, Microsoft Corporation. */
> > +
> > +#ifndef _AZ_BLOB_H
> > +#define _AZ_BLOB_H
>=20
> Seems like a #include of asm/ioctl.h (or something similar) is needed so =
that
> _IOWR is defined.  Also, a #include is needed for __u32, __aligned_u64,
> guid_t, etc.

Yes, somehow it can still compile because they are defined in azure_blob.c.=
 Will fix this.

>=20
> > +
> > +/* user-mode sync request sent through ioctl */ struct
> > +az_blob_request_sync_response {
> > +	__u32 status;
> > +	__u32 response_len;
> > +};
> > +
> > +struct az_blob_request_sync {
> > +	guid_t guid;
> > +	__u32 timeout;
> > +	__u32 request_len;
> > +	__u32 response_len;
> > +	__u32 data_len;
> > +	__u32 data_valid;
> > +	__aligned_u64 request_buffer;
> > +	__aligned_u64 response_buffer;
> > +	__aligned_u64 data_buffer;
> > +	struct az_blob_request_sync_response response; };
> > +
> > +#define AZ_BLOB_MAGIC_NUMBER	'R'
> > +#define IOCTL_AZ_BLOB_DRIVER_USER_REQUEST \
> > +		_IOWR(AZ_BLOB_MAGIC_NUMBER, 0xf0, \
> > +			struct az_blob_request_sync)
> > +
> > +#endif /* define _AZ_BLOB_H */
> > --
> > 1.8.3.1

