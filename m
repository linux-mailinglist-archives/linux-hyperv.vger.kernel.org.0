Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004443B210C
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jun 2021 21:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFWTXo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Jun 2021 15:23:44 -0400
Received: from mail-bn8nam12on2132.outbound.protection.outlook.com ([40.107.237.132]:25143
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230346AbhFWTXY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAI6b/oH26ZfNp2nJqIIaVt0oAKHy7txnbJC1F4rfPQgp90oxcQQ5I3fScWuyK6QVaWWZ9xt0hZ2T1dz7AFE5w91kN8wawAAPDCtTQUw42ZU7cvQ4rp//45Jj2jD1sY/yETjGVWpQderRf/0eri/vupPZrd6aZYz2q6SEt+HHT1HZzbd/1wi8S7d8HNE9ob0pwtX9GD0+zXY9rUOcP6ISE3IpMCK/RbroX19avt45V/8MRZJjpFK4Ui+ruRh2R2zLFBYW8iz/ANa1LTOarbSskNCSgI4A+qsRCkV0E3yBvIVvpyHWroJqzLWHhbvUz6P8s3V4us9TOOZWWftrFbOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2APr/pEy3CFLAgU+oHaO0IZZwnqtemoot2z8k1k6KcQ=;
 b=N7MnzS1jjhskErUD5DFGxHJ+Ffd/JfXL+3jIA03W9FJa/pFl/pk3qZWD1pcPt9KwSGMdn1L1fDm4BBPtB4jyebOP4SF8/mjENfwCsdHpF9DmRCgG7IW2MODH/ml6Rf3omWuXNsgJ0KeFmUbexNjoUAcKNzC7MvgFCW0e/qGBLnzp2o/2GRV5GbYqbfXDIwYYwOBVvhP+XbNadm9BdgZyFjOtBngjfO6zCKL6ExsOE2OYBuIcUFFk/3g/UpGZ899uk3vynce37xzy5/iYW9QOSxf0nAhFoaPbvdeL7RC+j0xojQ/Ps6UjTMSnPdLiwUGCimxLjhwLE0dWYA3ZTSeuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2APr/pEy3CFLAgU+oHaO0IZZwnqtemoot2z8k1k6KcQ=;
 b=e1atwC8qBiHVnV+akuJLowubgmWaz99R62RQ8T4CMKXD2CUdt0moFd6N+i++aqeJSMmZP6hX2rUoVb6ZUuOTQgn3sggH/szbBJBAYvLKciiEwIbex4LEZ5166HpjpzzQX2sKa3pGn9cWRrfZAwD9pConm+ZPiNSyzjTKXiMJ1og=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1224.namprd21.prod.outlook.com (2603:10b6:a03:10a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.5; Wed, 23 Jun
 2021 19:21:02 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52%6]) with mapi id 15.20.4287.008; Wed, 23 Jun 2021
 19:21:02 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
Thread-Topic: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
Thread-Index: AQHXXAJKewe2lsBf2kyeTA3xSHDQt6se2UMAgAMjv5A=
Date:   Wed, 23 Jun 2021 19:21:02 +0000
Message-ID: <BY5PR21MB1506187A82B88BBFECB2A884CE089@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
 <1623114276-11696-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15931C10916D27DB73CA5026D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15931C10916D27DB73CA5026D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=464ecde1-0565-4b1b-9de4-468a9f34be83;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-20T02:28:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 972f41f4-389a-4233-7bb2-08d9367c0a4a
x-ms-traffictypediagnostic: BYAPR21MB1224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB1224AA5CF163C830AA90454ACE089@BYAPR21MB1224.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cv8GYnBrVGTkOxrSM3gJBisuEhAwU2nyv86L139X5udjZXzCAIzh929Yn1wsm30OeWHKxjEEDYxyo5fhXDpwDz0FDkRMZZeIfUNZ8h7LCZq4fhc8J4suav5F2I0zyCublDRQDxcomvXjYglVXzQujn6rEs7u0VFa3orz5IapwFwBqeeyKEowqJMruA2mWW7LVywhIOIe3fVkKdNk3VAcDaS4XAkXagUX8PCPTIlxvcQfMnoyzC0M6iT8PD+3HIF2BCVNWVZDOuUDmNTHUpFnvbjHFlFoh1FOQkkgtUHFohEVO1Sg33ENWxY11ZMTwKK7pcCRMmGzpTIjBewNxD9JDLux1IaxQiY1KTBUc0JHvNnCgbQue6lmP2G4ArhBjXUEDNWHZN5snLDEwMliZKLyCPHpAHrL+ar/DUH7VDd0iDzFKnMxpcbIaKHdePxcKTQ6Z5cWNTUjdcGDm7ggKUQucIf4y+Ys2DlLoRyv9RMLR0TdxxHx+TjxBBxXPlEQPgSdoK707aROzIkizD+M7TmffMGB4r5rwjIApnyL7/8u4+g6cQAAcjRCBhTu/MbKcUrctPJZ261TFLZfpKScIxQkHGLiQV29zJrRZEjm+uTbnjCl3E7/A6KGRKTqctbKzytQH5HjnA9uqtWaXQzGH9hgTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(186003)(82950400001)(122000001)(82960400001)(6506007)(5660300002)(7696005)(9686003)(55016002)(316002)(38100700002)(10290500003)(33656002)(110136005)(54906003)(66946007)(107886003)(66446008)(66476007)(86362001)(2906002)(66556008)(64756008)(8936002)(71200400001)(26005)(8990500004)(30864003)(76116006)(52536014)(478600001)(8676002)(83380400001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kc0HJ9pbadf/QpSh7XWNnNn8ku2TXHd6Sk6W7HLUmgR0FhBx/ulEimUl2ujy?=
 =?us-ascii?Q?6eLTiGFG0q+qQPlFhVdoK6Jr6gMGGbV50GChJdO/m4uux1gt7joURl0bCMpA?=
 =?us-ascii?Q?pXQeSTB/Z6EiYalv6sAUP9Pp1KS7orbIPjyg3maV92/Bi5ct6IUL8oGjfm2u?=
 =?us-ascii?Q?sEq8gj3/8Hla/BKoMK5ur/GIjtKyT3Ilr8o1b+3E6iMNNb0LRxZYtdtrw30s?=
 =?us-ascii?Q?UdkU48it4fN2O52GDclTMIGdJ2Ezy48wc/iye169ZbNoVWQlnf/YbNBguVZw?=
 =?us-ascii?Q?olKnj2d3IZEn2BNstV/D+ePqVo8uk9LDzsCnMOK2p1yZuDzf1QbjNLAW1iwL?=
 =?us-ascii?Q?cFTEBzqe6cWXwHGb9RTpexKaXhgt9MXkzPYO6L0mJraysB3pMJy+lXbpAhSP?=
 =?us-ascii?Q?CZ+jgLsEiDIUdHORQaw/3JV94skMw66v8uTw4DVNVUXNkOiN/R2XSaeIDoKW?=
 =?us-ascii?Q?uYPxvUrrWF2l1OVj3TIb1GiCzx/Xz/NFLQGJgS5axpw7eWL/zRYf9MSmmen9?=
 =?us-ascii?Q?kP/w3TmZqvPftiCPWc3rQL3BSQ3SJmx8luCnwgtg10Wen2zSVAPcSfKt73Rf?=
 =?us-ascii?Q?ju4M+XZIlLMUjTwSIWCZmJ2EOs9zadyNDm6t4rBjmnDmLJ6l86Mv0rSK4gKD?=
 =?us-ascii?Q?uFu+Mi2kaBaIC+//R46lMkh0RflxapSBTJhO45v2WJjU72SW9XxwFrYc25kw?=
 =?us-ascii?Q?uR5HEJns3kyuUyA7gYWHycwRbdEoh4ep99AlUY6LThIb13vE7TFV4yLDDHDx?=
 =?us-ascii?Q?UKKXl09ekZtntJeTh9+GvLP29OF3zdr2vdcBGuQWiMWEaQnGbz2fbyJM1aXR?=
 =?us-ascii?Q?vhZI6M61OtdK1D+EbMv7BqDrhhG/IGzKvTM+u/10NkZLAj8pA4fMHIw0b9Mi?=
 =?us-ascii?Q?KAjrVAraLMvkP8yGNjTJmhVRbqdUI03CcWM/lQ6GnVNJUk58iV/BpdaHWX2Z?=
 =?us-ascii?Q?2u0vSjL6uWf90oAjB/Y50rt7ZqaqkUiVRETRTFxLvOYzqlQEmUjinRgEHliR?=
 =?us-ascii?Q?aGMn8dgl+tvOluA1TxIXpWPoW4jG7C4W+I11qvAJyOVDqsP+2CzccvfQTcdU?=
 =?us-ascii?Q?Ph1aEJaMY7PrvYV6fJvy/eV7bqvm1UzBQQC/2yMDkWnlX5fNTQd1ZFtQzqqv?=
 =?us-ascii?Q?7xV+syYOUmI349Ar87sEusMlEhrNoyALLrULDfZKWIgnAEorHl8jW6lOQM3d?=
 =?us-ascii?Q?6fi6ElVYob+EF2ZMWWFNRajK40ErDJWyzbsMNBrCqZOf8gXdaWKNftObyBz7?=
 =?us-ascii?Q?KRf8waFY1t6jabkG4hd4Yt2UpsBHAjP15fdITBI895xhXluy8YXaj4cwbxbG?=
 =?us-ascii?Q?3do=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972f41f4-389a-4233-7bb2-08d9367c0a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 19:21:02.3525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNJO2bd6kikyQMUGktjp3BGhHSGIxeWsqTiZ3Hua19frHU6aHNzzDtvFewK2NZrSfsyf5y+o0IL4FHKL8TjUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1224
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> Monday, June 7, 2021 6:05 PM
> >
> > Add XStore Fastpath driver to support accelerated access to Azure Blob
> > Storage Services.
> >
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  MAINTAINERS                 |   1 +
> >  drivers/hv/Kconfig          |  11 +
> >  drivers/hv/Makefile         |   1 +
> >  drivers/hv/channel_mgmt.c   |   6 +
> >  drivers/hv/hv_xs_fastpath.c | 579
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hv/hv_xs_fastpath.h |  82 +++++++
> >  include/linux/hyperv.h      |   9 +
> >  7 files changed, 689 insertions(+)
> >  create mode 100644 drivers/hv/hv_xs_fastpath.c  create mode 100644
> > drivers/hv/hv_xs_fastpath.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index 9487061..b547eb9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8440,6 +8440,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
> >  M:	Stephen Hemminger <sthemmin@microsoft.com>
> >  M:	Wei Liu <wei.liu@kernel.org>
> >  M:	Dexuan Cui <decui@microsoft.com>
> > +M:	Long Li <longli@microsoft.com>
> >  L:	linux-hyperv@vger.kernel.org
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>=20
> Seems like adding you to the Hyper-V maintainers list should be a separat=
e
> patch.  Having "maintainer" status is unrelated to adding this new driver=
.

There was a warning from checkpatch.pl. It asks me to add to maintainers in=
 the same patch of the driver.

>=20
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
> > 66c794d..2128a8b 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -27,4 +27,15 @@ config HYPERV_BALLOON
> >  	help
> >  	  Select this option to enable Hyper-V Balloon driver.
> >
> > +config HYPERV_XS_FASTPATH
> > +	tristate "Microsoft Azure XStore Fastpath driver"
> > +	depends on HYPERV && X86_64
> > +	help
> > +	  Select this option to enable Microsoft Azure XStore Fastpath driver=
.
> > +
> > +	  This driver supports accelerated Microsoft Azure XStore Blob access=
.
> > +	  To compile this driver as a module, choose M here. The module will
> be
> > +	  called hv_xs_fastpath.
> > +
> > +
> >  endmenu
> > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile index
> > 94daf82..080fe88 100644
> > --- a/drivers/hv/Makefile
> > +++ b/drivers/hv/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
> >  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
> >  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> > +obj-$(CONFIG_HYPERV_XS_FASTPATH)+=3D hv_xs_fastpath.o
> >
> >  CFLAGS_hv_trace.o =3D -I$(src)
> >  CFLAGS_hv_balloon.o =3D -I$(src)
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 6fd7ae5..a3f156e 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -153,6 +153,12 @@
> >  	  .allowed_in_isolated =3D false,
> >  	},
> >
> > +	/* XStore Fastpath */
> > +	{ .dev_type =3D HV_XS_FASTPATH,
> > +	  HV_XS_FASTPATH_GUID,
> > +	  .perf_device =3D true,
>=20
> I'm curious about setting .perf_device=3Dtrue.  The other perf devices ar=
e
> those that support multiple VMbus channels, but this device has only a si=
ngle
> channel.  Is there another reason to set .perf_device=3Dtrue?
>=20
> Also set .allowed_in_isolated to "false" so that it is explicitly called =
out like
> the other entries in the table.

Will fix this.

>=20
> > +	},
> > +
> >  	/* Unknown GUID */
> >  	{ .dev_type =3D HV_UNKNOWN,
> >  	  .perf_device =3D false,
> > diff --git a/drivers/hv/hv_xs_fastpath.c b/drivers/hv/hv_xs_fastpath.c
> > new file mode 100644 index 0000000..ee4152e
> > --- /dev/null
> > +++ b/drivers/hv/hv_xs_fastpath.c
> > @@ -0,0 +1,579 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
>=20
> Let's have an offline discussion about the license choice here and in
> hv_xs_fastpath.h.
>=20
> > +/*
> > + * Copyright (c) 2021, Microsoft Corporation.
> > + *
> > + * Authors:
> > + *   Long Li <longli@microsoft.com>
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/cred.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/pagemap.h>
> > +#include "hv_xs_fastpath.h"
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +struct dentry *xs_fastpath_debugfs_root; #endif
> > +
> > +static struct xs_fastpath_device xs_fastpath_dev;
> > +
> > +static int xs_fastpath_ringbuffer_size =3D (128 * 1024);
> > +module_param(xs_fastpath_ringbuffer_size, int, 0444);
> > +MODULE_PARM_DESC(xs_fastpath_ringbuffer_size, "Ring buffer size
> > +(bytes)");
> > +
> > +static const struct hv_vmbus_device_id id_table[] =3D {
> > +	{ HV_XS_FASTPATH_GUID,
> > +	  .driver_data =3D 0
> > +	},
> > +	{ },
> > +};
> > +
> > +#define XS_ERR 0
> > +#define XS_WARN 1
> > +#define XS_DBG 2
> > +static int log_level =3D XS_WARN;
> > +module_param(log_level, int, 0644);
> > +MODULE_PARM_DESC(logging_level,
>=20
> s/logging_level/log_level/
>=20
> > +	"Log level, 0 - Error, 1 - Warning (default), 3 - Debug.");
>=20
> s/Log level, 0/Log level: 0/
> s/3 - Debug/2 - Debug/
>=20
> > +
> > +#define xs_fastpath_log(level, fmt, args...)	\
> > +do {	\
> > +	if (level <=3D log_level)	\
> > +		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
> > +} while (0)
> > +
> > +#define xs_fastpath_dbg(fmt, args...) xs_fastpath_log(XS_DBG, fmt,
> > +##args) #define xs_fastpath_warn(fmt, args...)
> > +xs_fastpath_log(XS_WARN, fmt, ##args) #define xs_fastpath_err(fmt,
> > +args...) xs_fastpath_log(XS_ERR, fmt, ##args)
> > +
> > +struct xs_fastpath_vsp_request_ctx {
> > +	struct list_head list;
> > +	struct completion wait_vsp;
> > +	struct xs_fastpath_request_sync *request; };
>=20
> Any reason for this structure definition to be here instead of in
> hv_xs_fastpath.h?

I will restructure the code and move most driver private data structures to=
 .c file.

>=20
> > +
> > +static void xs_fastpath_on_channel_callback(void *context) {
> > +	struct vmbus_channel *channel =3D (struct vmbus_channel *)context;
> > +	const struct vmpacket_descriptor *desc;
> > +
> > +	xs_fastpath_dbg("entering interrupt from vmbus\n");
> > +	foreach_vmbus_pkt(desc, channel) {
> > +		struct xs_fastpath_vsp_request_ctx *request_ctx;
> > +		struct xs_fastpath_vsp_response *response;
> > +		u64 cmd_rqst =3D vmbus_request_addr(&channel->requestor,
> > +					desc->trans_id);
> > +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> > +			xs_fastpath_err("Incorrect transaction id %llu\n",
> > +				desc->trans_id);
> > +			continue;
> > +		}
> > +		request_ctx =3D (struct xs_fastpath_vsp_request_ctx *)
> cmd_rqst;
> > +		response =3D hv_pkt_data(desc);
> > +
> > +		xs_fastpath_dbg("got response for request %pUb status %u
> "
> > +			"response_len %u\n",
> > +			&request_ctx->request->guid, response->error,
> > +			response->response_len);
> > +		request_ctx->request->response.status =3D response->error;
> > +		request_ctx->request->response.response_len =3D
> > +			response->response_len;
> > +		complete(&request_ctx->wait_vsp);
> > +	}
>=20
> This for loop could potentially go on for a long time if there were lots =
of
> responses in the ring buffer, or responses being added while this loop is
> running.  It seems like there should be some timeout, and the remaining
> work rescheduled to prevent it from running too long.  I know this code i=
s
> just like the code in storvsc, but storvsc_on_channel_callback() has the =
same
> problem, which is on my list to fix.

This is a good point. I don't think this is a problem for remote storage dr=
ivers, as they are on request-response protocol, and completions can't stal=
l the CPU. Other storage drivers like NVMe is using a similar loop in nvme_=
process_cq().

>=20
> > +
> > +}
> > +
> > +static int xs_fastpath_fop_open(struct inode *inode, struct file
> > +*file) {
> > +	atomic_inc(&xs_fastpath_dev.file_count);
> > +	if (xs_fastpath_dev.removing) {
> > +		if (atomic_dec_and_test(&xs_fastpath_dev.file_count))
> > +			wake_up(&xs_fastpath_dev.wait_files);
> > +		return -ENODEV;
> > +	}
> > +
> > +	file->private_data =3D &xs_fastpath_dev;
> > +
> > +	return 0;
> > +}
> > +
> > +static int xs_fastpath_fop_release(struct inode *inode, struct file
> > +*file) {
> > +	if (atomic_dec_and_test(&xs_fastpath_dev.file_count))
> > +		wake_up(&xs_fastpath_dev.wait_files);
> > +	return 0;
> > +}
> > +
> > +static inline bool xs_fastpath_safe_file_access(struct file *file) {
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
> > +		xs_fastpath_err("request buffer access error %d\n", ret);
> > +		return ret;
> > +	}
> > +	xs_fastpath_dbg("iov_iter type %d offset %lu count %lu
> nr_segs %lu\n",
> > +		iter.type, iter.iov_offset, iter.count, iter.nr_segs);
> > +
> > +	result =3D iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start)=
;
> > +	if (result < 0) {
> > +		xs_fastpath_err("failed to ping user pages result=3D%ld\n",
> result);
>=20
> s/ping/pin/   [??]
>=20
> > +		return result;
> > +	}
> > +	if (result !=3D buffer_len) {
> > +		xs_fastpath_err("can't ping user pages requested %d
> got %ld\n",
>=20
> s/ping/pin/   [??]
>=20
> > +			buffer_len, result);
> > +		return -EFAULT;
> > +	}
> > +
> > +	*ppages =3D pages;
> > +	*num_pages =3D (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
> > +	return 0;
> > +}
>=20
> Can any of the xs_fastpath_err() calls be caused by a user error, such as
> passing in bad values on an ioctl call?  If so, we probably want to not p=
rint a
> console message in those cases.
>=20
> > +
> > +static void fill_in_page_buffer(u64 *pfn_array,
> > +	int *index, struct page **pages, unsigned long num_pages) {
> > +	int i, page_idx =3D *index;
> > +
> > +	for (i =3D 0; i < num_pages; i++)
> > +		pfn_array[page_idx++] =3D page_to_pfn(pages[i]);
> > +	*index =3D page_idx;
> > +}
>=20
> See notes below.  Filling in the pfn_array needs to account for running o=
n an
> ARM64 system where PAGE_SIZE !=3D HV_HYP_PAGE_SIZE.

The driver is currently conditioned on X86_64 in kconfig, as there is no ho=
st driver and no way to test it on ARM64. I suggest adding support to ARM64=
 if needed in future.

>=20
> > +
> > +static void free_buffer_pages(size_t num_pages, struct page **pages)
> > +{
> > +	unsigned long i;
> > +
> > +	for (i =3D 0; i < num_pages; i++)
> > +		if (pages[i])
> > +			put_page(pages[i]);
> > +	kfree(pages);
>=20
> Doesn't this need to be kvfree()?  'pages' is allocated with kvmalloc(), =
which
> could return vmalloc memory.

Will fix this.

>=20
> > +}
> > +
> > +static long xs_fastpath_ioctl_user_request(struct file *filp,
> > +unsigned long arg) {
> > +	struct xs_fastpath_device *dev =3D filp->private_data;
> > +	char __user *argp =3D (char __user *) arg;
> > +	struct xs_fastpath_request_sync request;
> > +	struct xs_fastpath_vsp_request_ctx *request_ctx;
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
> > +	struct xs_fastpath_vsp_request *vsp_request;
> > +
> > +	if (dev->removing)
> > +		return -ENODEV;
>=20
> I think this test is just to avoid starting a new request if we know that=
 the
> device has been marked for removing.  But because there's no
> synchronization, it's possible for the "removing" flag to be set immediat=
ely
> after the test has passed.

The usage of this flag "removing" here is to provide a fast failure path if=
 a user-mode keeps requesting while the device is being removed, thus savin=
g CPU cycles if a malicious user-mode is doing this. It's okay to remove th=
e check of this flag and it doesn't affect the correctness of the device re=
moval logic. I prefer to leave the check as is.

>=20
> > +
> > +	if (!xs_fastpath_safe_file_access(filp)) {
> > +		xs_fastpath_err("process %d(%s) changed security contexts
> after"
> > +			" opening file descriptor\n",
> > +			task_tgid_vnr(current), current->comm);
>=20
> I don't think we should produce a console message, at least not a "err"
> level.  It gives a user the ability to generate an arbitrary number of co=
nsole
> messages.  Maybe "dbg" level would be OK.
>=20
> > +		return -EACCES;
> > +	}
> > +
> > +	if (!access_ok(argp, sizeof(struct xs_fastpath_request_sync))) {
> > +
> > +		xs_fastpath_err("don't have permission to user provided
> buffer\n");
> > +		return -EFAULT;
> > +	}
>=20
> Is this check needed at all?  Again, we don't want to generate a console
> message due to a user error, and copy_from_user() below
> will validate that the access is OK.   A "dbg" level message would be
> OK.

Yes, this can be removed as copy_from_user() will guarantee permission is c=
orrect.

>=20
> > +
> > +	if (copy_from_user(&request, argp, sizeof(request)))
> > +		return -EFAULT;
> > +
> > +	xs_fastpath_dbg("xs_fastpath ioctl request guid %pUb timeout %u
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
> > +	request_ctx =3D kzalloc(sizeof(*request_ctx), GFP_KERNEL);
> > +	if (!request_ctx)
> > +		return -ENOMEM;
>=20
> Could the request_ctx just be on the stack?  Below, it stores a pointer t=
o the
> request, which is on the stack, and the request is accessed on the
> onchannel_callback function.
> So having request_ctx on the stack wouldn't be the only usage of a stack
> variable in the onchannel_callback function.

I can move to request_ctx to stack.

>=20
> > +
> > +	init_completion(&request_ctx->wait_vsp);
> > +	request_ctx->request =3D &request;
> > +
> > +	/*
> > +	 * Need to set rw to READ to have page table set up for passing to
> VSP.
> > +	 * Setting it to WRITE will cause the page table entry not allocated
> > +	 * as it's waiting on Copy-On-Write on next page fault. This doesn't
> > +	 * work in this scenario because VSP wants all the pages to be
> present.
> > +	 */
> > +	ret =3D get_buffer_pages(READ, (void __user *)
> request.request_buffer,
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
> > +			(void __user *) request.data_buffer,
> request.data_len,
> > +			&data_pages, &data_start, &data_num_pages);
> > +		if (ret)
> > +			goto get_user_page_failed;
> > +	}
>=20
> Do the request_len, response_len, and data_len need to be validated
> before being passed to get_buffer_pages() since they are passed in from
> user space?  The fields are 32 bits, so the max value is 4 Gbytes, which =
maybe
> is OK.  But with XS_FASTPATH_MAX_PAGES set to 8192, the maximum size is
> 32 Mbytes with a 4K page size, and 512 Mbytes with a 64K page size.

The VSP support a maximum of 32MB of buffer pages combined, so XS_FASTPATH_=
MAX_PAGES is set to 8192. The check is done to make sure we don't pass exce=
ssive pages to VSP. I'll check on request_len, response_len and data_len be=
fore allocating pages.

>=20
> > +
> > +	total_num_pages =3D request_num_pages + response_num_pages +
> > +				data_num_pages;
> > +	if (total_num_pages > XS_FASTPATH_MAX_PAGES) {
>=20
> Note that this check imposes different limits depending on PAGE_SIZE.
> Is the value XS_FASTPATH_MAX_PAGES governed by the largest
> vmbus_packet_mpb_array that Hyper-V will accept?  If not, does there need
> to be a check against the max vmbus_packet_mpb_array size?
> (I don't know what the Hyper-V limit is.)
>=20
> > +		xs_fastpath_err("number of DMA pages %lu buffer
> exceeding %u\n",
> > +			total_num_pages, XS_FASTPATH_MAX_PAGES);
> > +		ret =3D -EINVAL;
> > +		goto get_user_page_failed;
> > +	}
> > +
> > +	/* Construct a VMBUS packet and send it over to VSP */
> > +	desc_size =3D sizeof(struct vmbus_packet_mpb_array) +
> > +			sizeof(u64) * total_num_pages;
>=20
> The above doesn't handle the case where the guest PAGE_SIZE is different
> from the Hyper-V page size (HV_HYP_PAGE_SIZE), as can happen on ARM64.
>=20
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
> > +	pfn_array =3D desc->range.pfn_array;
> > +	page_idx =3D 0;
> > +
> > +	if (request.data_len) {
> > +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> > +			data_num_pages);
> > +		vsp_request->data_buffer_offset =3D data_start;
> > +		vsp_request->data_buffer_length =3D request.data_len;
> > +		vsp_request->data_buffer_valid =3D 1;
> > +	}
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> > +		request_num_pages);
> > +	vsp_request->request_buffer_offset =3D request_start +
> > +						data_num_pages *
> PAGE_SIZE;
> > +	vsp_request->request_buffer_length =3D request.request_len;
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> > +		response_num_pages);
> > +	vsp_request->response_buffer_offset =3D response_start +
> > +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> > +	vsp_request->response_buffer_length =3D request.response_len;
>=20
> All of the above that is filling in the pfn_array needs to handle the cas=
e
> where PAGE_SIZE !=3D HV_HYP_PAGE_SIZE.
>=20
> > +
> > +	vsp_request->version =3D 0;
> > +	vsp_request->timeout_ms =3D request.timeout;
>=20
> Does the request.timeout value from user space need to be validated?
> I'm thinking about a value of 0, or a really small value like 1 ms, or a =
really
> large value that effectively means no timeout.

The timeout is not used by the VSC/VSP kernel mode, so we don't mess up wit=
h it.

>=20
> > +	vsp_request->operation_type =3D
> XS_FASTPATH_DRIVER_USER_REQUEST;
> > +	guid_copy(&vsp_request->transaction_id, &request.guid);
> > +
> > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > +	list_add_tail(&request_ctx->list, &dev->vsp_pending_list);
> > +	spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > +
> > +	xs_fastpath_dbg("sending request to VSP\n");
> > +	xs_fastpath_dbg("desc_size %u desc->range.len %u desc-
> >range.offset %u\n",
> > +		desc_size, desc->range.len, desc->range.offset);
> > +	xs_fastpath_dbg("vsp_request data_buffer_offset %u
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
> > +		vsp_request, sizeof(*vsp_request), (u64) request_ctx);
> > +
> > +	kfree(desc);
> > +	kfree(vsp_request);
> > +	if (ret)
> > +		goto vmbus_send_failed;
> > +
> > +	wait_for_completion(&request_ctx->wait_vsp);
>=20
> This is a "wait forever", which exists in other places in the Hyper-V dri=
vers,
> but we've learned that might not be a good idea.  It's more complicated t=
o
> deal with a timeout, and the potential for the Hyper-V response to come i=
n
> after the timeout, but that would be the most robust approach.  Maybe we
> can live with the "wait forever" approach for now, but in the long run we=
'll
> probably want something like a 30 second or 60 second timeout.
>=20
> > +
> > +	/*
> > +	 * At this point, the response is already written to request
> > +	 * by VMBUS completion handler, copy them to user-mode buffers
> > +	 * and return to user-mode
> > +	 */
> > +	if (copy_to_user(argp +
> > +			offsetof(struct xs_fastpath_request_sync,
> > +				response.status),
> > +			&request.response.status,
> > +			sizeof(request.response.status))) {
> > +		ret =3D -EFAULT;
> > +		goto vmbus_send_failed;
> > +	}
> > +
> > +	if (copy_to_user(argp +
> > +			offsetof(struct xs_fastpath_request_sync,
> > +				response.response_len),
> > +			&request.response.response_len,
> > +			sizeof(request.response.response_len)))
> > +		ret =3D -EFAULT;
> > +
> > +vmbus_send_failed:
> > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > +	list_del(&request_ctx->list);
> > +	if (list_empty(&dev->vsp_pending_list))
> > +		wake_up(&dev->wait_vsp);
> > +	spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > +
> > +get_user_page_failed:
> > +	free_buffer_pages(request_num_pages, request_pages);
> > +	free_buffer_pages(response_num_pages, response_pages);
> > +	free_buffer_pages(data_num_pages, data_pages);
> > +
> > +	kfree(request_ctx);
> > +	return ret;
> > +}
> > +
> > +static long xs_fastpath_fop_ioctl(struct file *filp, unsigned int cmd,
> > +	unsigned long arg)
> > +{
> > +	long ret =3D -EIO;
> > +
> > +	switch (cmd) {
> > +	case IOCTL_XS_FASTPATH_DRIVER_USER_REQUEST:
> > +		if (_IOC_SIZE(cmd) !=3D sizeof(struct
> xs_fastpath_request_sync))
> > +			return -EINVAL;
> > +		ret =3D xs_fastpath_ioctl_user_request(filp, arg);
> > +		break;
> > +
> > +	default:
> > +		xs_fastpath_err("unrecognized IOCTL code %u\n", cmd);
>=20
> Again, probably don't want to output a console message just because user
> space passed a bad ioctl code.
>=20
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations xs_fastpath_client_fops =3D {
> > +	.owner	=3D THIS_MODULE,
> > +	.open	=3D xs_fastpath_fop_open,
> > +	.unlocked_ioctl =3D xs_fastpath_fop_ioctl,
> > +	.release =3D xs_fastpath_fop_release,
> > +};
> > +
> > +static struct miscdevice xs_fastpath_misc_device =3D {
> > +	MISC_DYNAMIC_MINOR,
> > +	"azure_xs_fastpath",
> > +	&xs_fastpath_client_fops,
> > +};
> > +
> > +static int xs_fastpath_show_pending_requests(struct seq_file *m, void
> > +*v) {
> > +	unsigned long flags;
> > +	struct xs_fastpath_vsp_request_ctx *request_ctx;
> > +
> > +	seq_puts(m, "List of pending requests\n");
> > +	seq_puts(m, "UUID request_len response_len data_len "
> > +		"request_buffer response_buffer data_buffer\n");
> > +	spin_lock_irqsave(&xs_fastpath_dev.vsp_pending_lock, flags);
> > +	list_for_each_entry(request_ctx,
> &xs_fastpath_dev.vsp_pending_list, list) {
> > +		seq_printf(m, "%pUb ", &request_ctx->request->guid);
> > +		seq_printf(m, "%u ", request_ctx->request->request_len);
> > +		seq_printf(m, "%u ", request_ctx->request->response_len);
> > +		seq_printf(m, "%u ", request_ctx->request->data_len);
> > +		seq_printf(m, "%llx ", request_ctx->request-
> >request_buffer);
> > +		seq_printf(m, "%llx ", request_ctx->request-
> >response_buffer);
> > +		seq_printf(m, "%llx\n", request_ctx->request->data_buffer);
> > +	}
> > +	spin_unlock_irqrestore(&xs_fastpath_dev.vsp_pending_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int xs_fastpath_debugfs_open(struct inode *inode, struct file
> > +*file) {
> > +	return single_open(file, xs_fastpath_show_pending_requests,
> NULL); }
> > +
> > +static const struct file_operations xs_fastpath_debugfs_fops =3D {
> > +	.open		=3D xs_fastpath_debugfs_open,
> > +	.read		=3D seq_read,
> > +	.llseek		=3D seq_lseek,
> > +	.release	=3D seq_release
> > +};
> > +
> > +static void xs_fastpath_remove_device(struct xs_fastpath_device *dev)
> > +{
> > +	wait_event(dev->wait_files, atomic_read(&dev->file_count) =3D=3D 0);
>=20
> After this wait_event() completes, but before misc_deregister() completes=
,
> the device can still be found and opened.  Because the removing flag is s=
et,
> xs_fastpath_fop_open() won't do anything but increment the file_count,
> then decrement it again, and call wake_up().  That all works with
> xs_fastpath_dev as a static variable.  But it might not work if xs_fastpa=
th_dev
> was dynamically allocated, as would be the case if multiple such devices =
were
> supported.  So I'm wondering if this code really should do the
> misc_deregister() and debugfs_remove_recursive() first, and then to the
> wait_event().  When done in that order, you know that the device can't be
> found again after the wait_event() completes.  Then the "removing" flag i=
s
> not even needed.

I don't think it's safe to call misc_deregister() while there are files ope=
ned and I/O ongoing on the device. If you see we have this guarantee from m=
isc_deregister() to not mess up with ongoing I/O, please point me to the co=
de.

I don't see the need for supporting multiple xs_fastpath_dev. It is dynamic=
ally allocated on vmbus probe, currently there can be only one such device =
on the system.

>=20
> > +	misc_deregister(&xs_fastpath_misc_device);
> > +#ifdef CONFIG_DEBUG_FS
> > +	debugfs_remove_recursive(xs_fastpath_debugfs_root);
> > +#endif
> > +	/* At this point, we won't get any requests from user-mode */ }
> > +
> > +static int xs_fastpath_create_device(struct xs_fastpath_device *dev)
> > +{
> > +	int rc;
> > +	struct dentry *d;
> > +
> > +	atomic_set(&xs_fastpath_dev.file_count, 0);
> > +	init_waitqueue_head(&xs_fastpath_dev.wait_files);
> > +	rc =3D misc_register(&xs_fastpath_misc_device);
> > +	if (rc) {
> > +		xs_fastpath_err("misc_register failed rc %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +	xs_fastpath_debugfs_root =3D debugfs_create_dir("xs_fastpath",
> NULL);
> > +	if (!IS_ERR_OR_NULL(xs_fastpath_debugfs_root)) {
> > +		d =3D debugfs_create_file("pending_requests", 0400,
> > +			xs_fastpath_debugfs_root, NULL,
> > +			&xs_fastpath_debugfs_fops);
> > +		if (IS_ERR_OR_NULL(d)) {
> > +			xs_fastpath_err("failed to create debugfs file\n");
> > +
> 	debugfs_remove_recursive(xs_fastpath_debugfs_root);
> > +			xs_fastpath_debugfs_root =3D NULL;
> > +		}
> > +	} else
> > +		xs_fastpath_err("failed to create debugfs root\n"); #endif
> > +
> > +	return 0;
> > +}
> > +
> > +static int xs_fastpath_connect_to_vsp(struct hv_device *device, u32
> > +ring_size) {
> > +	int ret;
> > +
> > +	spin_lock_init(&xs_fastpath_dev.vsp_pending_lock);
> > +	INIT_LIST_HEAD(&xs_fastpath_dev.vsp_pending_list);
> > +	init_waitqueue_head(&xs_fastpath_dev.wait_vsp);
> > +	xs_fastpath_dev.removing =3D false;
> > +
> > +	xs_fastpath_dev.device =3D device;
> > +	device->channel->rqstor_size =3D xs_fastpath_ringbuffer_size /
> > +		sizeof(struct xs_fastpath_vsp_request);
>=20
> That setting probably isn't correct.  Presumably the Hyper-V VSP can hold=
 a
> certain number of requests that it has already removed the
> guest->host ring buffer.  So the max number of in-flight requests
> would be that Hyper-V VSP count, plus the number of requests that will fi=
t in
> the ring buffer.
>=20
> Independent of this setting, the ioctl's are synchronous, so the total nu=
mber
> of in-flight requests will be the number of threads
> making requests.   Note that these ioctl calls include all blobs
> being accessed using this method by all users running in the VM.
> Nonetheless, it might be reasonable to just put a fixed cap on that numbe=
r.
> Perhaps something like 1024?  If the limit is exceeded, the calls to
> vmbus_sendpacket_mpb_desc() will start failing because of being unable to
> allocate a requestID.

The VSC is designed to support asynchronous I/O requests, so this number ca=
n be potentially large. The reason why I put the largest possible number fo=
r rqstor_size (based on ring buffer) is not having it limit other queue dep=
ths in the Fastpath code path.

>=20
> Presumably the memory management subsystem will also limit the amount
> of memory being pinned by the ioctl calls, which could also cause the ioc=
tl
> calls to return an error.
>=20
>=20
> > +
> > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> > +			xs_fastpath_on_channel_callback, device->channel);
> > +
> > +	if (ret) {
> > +		xs_fastpath_err("failed to connect to VSP ret %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	hv_set_drvdata(device, &xs_fastpath_dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static void xs_fastpath_remove_vmbus(struct hv_device *device) {
> > +	struct xs_fastpath_device *dev =3D hv_get_drvdata(device);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > +	if (!list_empty(&dev->vsp_pending_list)) {
>=20
> I don't think this can ever happen.  If the device has already been remov=
ed
> by xs_fastpath_remove_device(), then we know that the device isn't open
> in any processes, so there can't be any ioctl's in progress that would ha=
ve
> entries in the vsp_pending_list.

The VSC is designed to support asynchronous I/O (while not implemented in t=
his version), so vsp_pending_list is needed if a user-mode decides to close=
 the file and not waiting for I/O.

>=20
> > +		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > +		xs_fastpath_dbg("wait for vsp_pending_list\n");
> > +		wait_event(dev->wait_vsp,
> > +			list_empty(&dev->vsp_pending_list));
> > +	} else
> > +		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > +
> > +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> > +	hv_set_drvdata(device, NULL);
> > +	vmbus_close(device->channel);
> > +}
> > +
> > +static int xs_fastpath_probe(struct hv_device *device,
> > +			const struct hv_vmbus_device_id *dev_id) {
> > +	int rc;
> > +
> > +	xs_fastpath_dbg("probing device\n");
> > +
> > +	rc =3D xs_fastpath_connect_to_vsp(device,
> xs_fastpath_ringbuffer_size);
> > +	if (rc) {
> > +		xs_fastpath_err("error connecting to VSP rc %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	// create user-mode client library facing device
> > +	rc =3D xs_fastpath_create_device(&xs_fastpath_dev);
> > +	if (rc) {
> > +		xs_fastpath_remove_vmbus(device);
> > +		return rc;
> > +	}
> > +
> > +	xs_fastpath_dbg("successfully probed device\n");
> > +	return 0;
> > +}
> > +
> > +static int xs_fastpath_remove(struct hv_device *dev) {
> > +	struct xs_fastpath_device *device =3D hv_get_drvdata(dev);
> > +
> > +	device->removing =3D true;
> > +	xs_fastpath_remove_device(device);
> > +	xs_fastpath_remove_vmbus(dev);
> > +	return 0;
> > +}
> > +
> > +static struct hv_driver xs_fastpath_drv =3D {
> > +	.name =3D KBUILD_MODNAME,
> > +	.id_table =3D id_table,
> > +	.probe =3D xs_fastpath_probe,
> > +	.remove =3D xs_fastpath_remove,
> > +	.driver =3D {
> > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> > +};
> > +
> > +static int __init xs_fastpath_drv_init(void) {
> > +	int ret;
> > +
> > +	ret =3D vmbus_driver_register(&xs_fastpath_drv);
> > +	return ret;
> > +}
> > +
> > +static void __exit xs_fastpath_drv_exit(void) {
> > +	vmbus_driver_unregister(&xs_fastpath_drv);
> > +}
> > +
> > +MODULE_LICENSE("GPL");
>=20
> Let's discuss the license choice offline.
>=20
> > +MODULE_DESCRIPTION("Microsoft Azure XStore Storage Fastpath
> driver");
>=20
> The word "Storage" seems unnecessary.  Everywhere else the name is just
> "Azure Xstore Fastpath".
>=20
> > +module_init(xs_fastpath_drv_init);
> > +module_exit(xs_fastpath_drv_exit);
> > diff --git a/drivers/hv/hv_xs_fastpath.h b/drivers/hv/hv_xs_fastpath.h
> > new file mode 100644 index 0000000..6db1904
> > --- /dev/null
> > +++ b/drivers/hv/hv_xs_fastpath.h
> > @@ -0,0 +1,82 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2021, Microsoft Corporation.
> > + *
> > + * Authors:
> > + *   Long Li <longli@microsoft.com>
> > + */
> > +#ifndef _XS_FASTPATH_H
> > +#define _XS_FASTPATH_H
> > +
> > +#include <linux/hyperv.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/hashtable.h>
> > +#include <linux/uio.h>
> > +
> > +struct xs_fastpath_device {
> > +	struct hv_device *device;
> > +	bool removing;
> > +
> > +	struct list_head vsp_pending_list;
> > +	spinlock_t vsp_pending_lock;
> > +	wait_queue_head_t wait_vsp;
> > +
> > +	wait_queue_head_t wait_files;
> > +	atomic_t file_count;
> > +};
> > +
> > +/* user-mode sync request sent through ioctl */ struct
> > +xs_fastpath_request_sync_response {
> > +	__u32 status;
> > +	__u32 response_len;
> > +};
> > +
> > +struct xs_fastpath_request_sync {
> > +	guid_t guid;
> > +	__u32 timeout;
> > +	__u32 request_len;
> > +	__u32 response_len;
> > +	__u32 data_len;
> > +	__aligned_u64 request_buffer;
> > +	__aligned_u64 response_buffer;
> > +	__aligned_u64 data_buffer;
> > +	struct xs_fastpath_request_sync_response response; };
>=20
> Wouldn't the structures used by user space need to go in a uapi header fi=
le?

I will move those to uapi.

>=20
> > +
> > +/* VSP messages */
> > +enum xs_fastpath_vsp_request_type {
> > +	XS_FASTPATH_DRIVER_REQUEST_FIRST     =3D 0x100,
> > +	XS_FASTPATH_DRIVER_USER_REQUEST      =3D 0x100,
> > +	XS_FASTPATH_DRIVER_REGISTER_BUFFER   =3D 0x101,
> > +	XS_FASTPATH_DRIVER_DEREGISTER_BUFFER =3D 0x102,
> > +	XS_FASTPATH_DRIVER_REQUEST_MAX       =3D 0x103
>=20
> Most of these don't seem to be used in the code.  And it seems a bit
> unexpected for the MAX value to not be the same as the last value
> (DEREGISTER_BUFFER).

Some are not used in this version of the driver; they are placed here for p=
rotocol completeness.

>=20
> > +};
> > +
> > +/* VSC->VSP request */
> > +struct xs_fastpath_vsp_request {
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
> > +struct xs_fastpath_vsp_response {
> > +	u32 length;
> > +	u32 error;
> > +	u32 response_len;
> > +} __packed;
> > +
> > +#define IOCTL_XS_FASTPATH_DRIVER_USER_REQUEST \
> > +		_IOWR('R', 10, struct xs_fastpath_request_sync)
>=20
> How was the ioctl code decided?  Using 'R' and '10' seems to be in the ra=
nge
> assigned to /dev/random, per the file Documentation/userspace-
> api/ioctl/ioctl-number.rst.
>=20
> Does this also need to go in a uapi header file?

Will fix this.

>=20
> > +
> > +#define XS_FASTPATH_MAX_PAGES 8192
>=20
> How was this value determined?  Would be good to leave a comment, and
> the comment should speak to how the limit is handled when PAGE_SIZE
> varies on different architectures.
>=20
> > +
> > +#endif /* define _XS_FASTPATH_H */
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > d1e59db..a1730c4 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -772,6 +772,7 @@ enum vmbus_device_type {
> >  	HV_FCOPY,
> >  	HV_BACKUP,
> >  	HV_DM,
> > +	HV_XS_FASTPATH,
> >  	HV_UNKNOWN,
> >  };
> >
> > @@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource
> **new,
> > struct hv_device *device_obj,
> >  			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
> >
> >  /*
> > + * XStore Fastpath GUID
> > + * {0590b792-db64-45cc-81db-b8d70c577c9e}
> > + */
> > +#define HV_XS_FASTPATH_GUID \
> > +	.guid =3D GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
> > +			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
> > +
> > +/*
> >   * Shutdown GUID
> >   * {0e0b6031-5213-4934-818b-38d90ced39db}
> >   */
> > --
> > 1.8.3.1

I will address of rest of the comments.
