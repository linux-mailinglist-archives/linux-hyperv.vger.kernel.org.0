Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EA3B23B5
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jun 2021 00:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWXBb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Jun 2021 19:01:31 -0400
Received: from mail-sn1anam02on2104.outbound.protection.outlook.com ([40.107.96.104]:32415
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229688AbhFWXBb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Jun 2021 19:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFSovTR65j+nbjSsqCvF3LwAiffbCPuMGa+LYv/7aqK4GDj5oIL5OW0UMum8oS9mRIc5XFIXxoUokdL+TwJEoaejXgbO+z94AHRM7RH3/aE204mpgPp1/CswH4T038cGFy+U7B3qjt8ob/pQ3saAnWZZeyC+2tuPUFdJOz2Frb3OcN8YrwJp1QEAOFVXJtVaRDVpXY77WZlnRlYUDk57hglDVogNQL70MRKZAIa72SzHziHn4eCW+ER1vWeHRVurkoF7r0HymtbcAqqeempCDrOshI8N9WGN6sMFjF3Mk0TIHiL5zSgfQBnU5tCRZcwj9MT/jVMeCat4grac8wY1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DlINqS7KRp0gB7/YjDOJ2BEcp3ZuOfrWDtM+Krpt04=;
 b=JpKzl0SPXFDcX/1seUTHDHfTXouqn4T6kscngZpuBAm+vFp00y7zzi/69KX6GHZPqAmoiSMkYtyEcbZInKD+XyMd+Mh3eEr1q11RIQ57GJZ91hYm4fDHnYghUdxhWI7PLUP4XGfiV2cuXUlU7/73A5vBx1Zzr6Y5EIHMg4uIvd1sIwlHz0CkRdBNToEIdzMkglcHgKI2hNtjHJIoBipNndU7HD0aSgFDiOls2SvxTY2b2UCS7FSNHpHAFmm6Q6AmjFmsvT8tovnPbCtkgSwUixm/SGaY8W6xo+4sW7kNxHd7CIIqMZYKqZYDpYJ1UdlkamuxHQ7PtgjbVQmuLTePjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DlINqS7KRp0gB7/YjDOJ2BEcp3ZuOfrWDtM+Krpt04=;
 b=SKr5H3Ltaun6Ay2SjpbmT5bKxb4tK146hTLFm3/zIknNLzjRbE9IyCP2L5stPPis3M3w2h3dKNjBCbbKdXKAiFb0XkFPXfmRyPyrh8JiU9t/HHJTlYbvZ+q/rtELwLBb5nlnYqydhevFfZhXDEjtFNtgQ4B84g+y1UDTHg5rGwU=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BY5PR21MB1409.namprd21.prod.outlook.com (2603:10b6:a03:234::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8; Wed, 23 Jun
 2021 22:59:09 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52%6]) with mapi id 15.20.4287.008; Wed, 23 Jun 2021
 22:59:09 +0000
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
Thread-Index: AQHXXAJKewe2lsBf2kyeTA3xSHDQt6se2UMAgAMjv5CAAEGvgIAAC3wA
Date:   Wed, 23 Jun 2021 22:59:08 +0000
Message-ID: <BY5PR21MB1506412BC2AB188D44EA981BCE089@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
 <1623114276-11696-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15931C10916D27DB73CA5026D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506187A82B88BBFECB2A884CE089@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593A5DE463C2DC61586ACAED7089@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593A5DE463C2DC61586ACAED7089@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=464ecde1-0565-4b1b-9de4-468a9f34be83;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-20T02:28:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1bce301-3265-48f6-16cb-08d9369a8263
x-ms-traffictypediagnostic: BY5PR21MB1409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR21MB1409634F5C130334A255C5BDCE089@BY5PR21MB1409.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7t00+CXOGLpTumLbHZDSPtTHJGkFM9vjoJVGv/xfDSQOp2ncQV9862/5GitJ2arJdJqnZpmMGUAOkO6sEgGaEGefJOoGyuV33rkXOTbwiBkuBrBwD3073d9bIPem5AgIZsxJ/E4N5IW464LxQTjdDZrB+0pwbpTWEYGqvL+2insqpmbu/RDwmOt+u67DdUwsJGB1ug0w80OP8VstOlwWqu8/r1ZuJ9dYXijOo6lRrfptwV4u7jY6chCQ1ssvWXRRLw8+Sc+ynmoZKVgqDekpF25veDbHiBZ2CKunQt5x74BSWXc9SynTokSiUpWPxzJqmeWZzd2IOdfp4GSQz0JLDqD/up7CzA+DDmBEm9ge2rlquzmH/zbCfWyWqtq/XI/ittE7N/rgD+R6toOrvFrykfrzr7NflvAcjFpfrqVY4eWyqUCJOxhoJ9yC275JQmIPMvlyKWi2Z0OK04PK4BvL+adpvskADbJ4xAALpHk99m79P1udg1R9laD+onxlfs5axP/iirRnEIVcp7xar8NiCyYRL1bk8V7uLk5TlSppYU3LBffzdjz3x7XhNw8iz91j4jopfaFUTEZPydSfpjdawR8AbhzSa+Qz1bgFYEB31n/ks23mSmDK+AVTbTTBdvH5ykf9j03HHGg+/Z3efdKlSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(8676002)(110136005)(316002)(10290500003)(107886003)(55016002)(8990500004)(7696005)(9686003)(30864003)(38100700002)(122000001)(26005)(186003)(52536014)(6506007)(478600001)(54906003)(4326008)(5660300002)(2906002)(82960400001)(82950400001)(71200400001)(83380400001)(86362001)(33656002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S5l3a6g7wtFWbfiEvKW27aG6ee3wtHKhLM6l4CBPLlLi4IFeGy4qZ4FTQUIQ?=
 =?us-ascii?Q?V/61WenQRlaF3Qs7XCUZcYkNtPjVsSTP6D3PpMykzzcIfyGgSetbzvW+ZCTs?=
 =?us-ascii?Q?YyzSFv40uIeYLJbNvfV0HRi0lVMtzLtKKNHGSdWUUtMey7TpmIZUA/TWhN+j?=
 =?us-ascii?Q?iJaF056n5JMmzHG8mbVwizVaxWXDEFznV+jDh45kba7RcDWf+E+V+FCXSnQ1?=
 =?us-ascii?Q?i4ERZbCpysWHZsPJE7vFgUIxFCTJeLSODxLO82DOtd9pLSVE0w4zcRRrzFGJ?=
 =?us-ascii?Q?37U1HoVGNtmar6VNVqvzPAQN9slqEbUUWAPQ46KKkr0VBwX042FH2l2eMObU?=
 =?us-ascii?Q?SDrrFjvQEJu5kBCuVZjK6Y2D03c7wNydQ0hC8hvL4a/FkICJGCeVIKa5VNgf?=
 =?us-ascii?Q?kWV+u9BAUYN/alOrfce4a0H3H1MKZdrvDBsMZKziPB/ulOzS+w+FNtYMbHfV?=
 =?us-ascii?Q?RgN3lKSnmf/WyNojJsGDD4iIw2BiOvgz8VNzZ8sx2vNFJDSLokiTzcishSkK?=
 =?us-ascii?Q?hacQKrbcz4ZkxitE5jfVY6RK9Zk7lmc4qiJ4xgIIiaR92QpdKK6JAs5QsivY?=
 =?us-ascii?Q?7dk0mILIi/7teedpi6VJx7JZBER6EBgrGnKdarbdg8ACX9CcVX7MQPgs5nqu?=
 =?us-ascii?Q?AHLWRuhPbE9oKMjBm0a53RB4sYjx9c6Ls8Jt4IhQZGIKy970hCiDI6Je7YLB?=
 =?us-ascii?Q?KsQtET0uONydn26R2toaCTDKHsTOdZL7LjbY8Q29QFiJGR+5DCED7iiQw2kH?=
 =?us-ascii?Q?rgMQ3B7Lpnmyt0YuGqhRJwvTukQSyNzy44ImF9HnWbiVM38WzPpESMgiFWZB?=
 =?us-ascii?Q?eXy78IXrsD7bNWWgprWQSzKZ563S/EGDNWsF+QfStGlUqoNfu/9vMZkmuVnV?=
 =?us-ascii?Q?upEDIXPWfvPYqHw8GPu1t0p3dNxfcPbBfUJiwzImiB/lFUoVs3iRWcCjjY/o?=
 =?us-ascii?Q?yBztMwJn9iZAMnUNYkqhZ2FjUOy/crJ1WGPTB4J80dgiqD5le5oDZiFxd02b?=
 =?us-ascii?Q?2ZidTF7IDgbBwNg0JJndAx6n/9ApqNIEolkzVEC2MsWrR+GEiyI+N/wroN2g?=
 =?us-ascii?Q?fac4RJFUOC+3RwCRYC24HoSQcHuW0IMxPBpBPscz4j1gDGDe1p6HJUj+zSIV?=
 =?us-ascii?Q?2E+MPe78AdX6QowCc5gQIoLzlTyKR/ViR24bzBBv2gIV9STODLOQ67VBfNah?=
 =?us-ascii?Q?B+r2jzt9VKfw8jxMQkjI3fFJp6KucqTvoWomA7xSGP6gVHW3X9J0I8aDYkB4?=
 =?us-ascii?Q?pKfY0nYbzdI/4a0rPyq3JE4hX20/DT4EnONLdWCflSZugNZn1OMk6tuykKkL?=
 =?us-ascii?Q?ZD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bce301-3265-48f6-16cb-08d9369a8263
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 22:59:08.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YR5bNafD2HxuV3DTc4Y4xrhAaM8evgebaoDKMP+bD/ULqy5/DwTm7AmjYbzGt5Xlz93VInR/AMhfIKKg4K8gJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1409
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
>=20
> From: Long Li <longli@microsoft.com> Sent: Wednesday, June 23, 2021 12:21
> PM
> > >
> > > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> > > Monday, June 7, 2021 6:05 PM
> > > >
> > > > Add XStore Fastpath driver to support accelerated access to Azure
> > > > Blob Storage Services.
> > > >
> > > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > Cc: Wei Liu <wei.liu@kernel.org>
> > > > Cc: Dexuan Cui <decui@microsoft.com>
> > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > ---
> > > >  MAINTAINERS                 |   1 +
> > > >  drivers/hv/Kconfig          |  11 +
> > > >  drivers/hv/Makefile         |   1 +
> > > >  drivers/hv/channel_mgmt.c   |   6 +
> > > >  drivers/hv/hv_xs_fastpath.c | 579
> > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/hv/hv_xs_fastpath.h |  82 +++++++
> > > >  include/linux/hyperv.h      |   9 +
> > > >  7 files changed, 689 insertions(+)  create mode 100644
> > > > drivers/hv/hv_xs_fastpath.c  create mode 100644
> > > > drivers/hv/hv_xs_fastpath.h
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS index 9487061..b547eb9
> > > > 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -8440,6 +8440,7 @@ M:	Haiyang Zhang
> <haiyangz@microsoft.com>
> > > >  M:	Stephen Hemminger <sthemmin@microsoft.com>
> > > >  M:	Wei Liu <wei.liu@kernel.org>
> > > >  M:	Dexuan Cui <decui@microsoft.com>
> > > > +M:	Long Li <longli@microsoft.com>
> > > >  L:	linux-hyperv@vger.kernel.org
> > > >  S:	Supported
> > > >  T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> > >
> > > Seems like adding you to the Hyper-V maintainers list should be a
> > > separate patch.  Having "maintainer" status is unrelated to adding th=
is
> new driver.
> >
> > There was a warning from checkpatch.pl. It asks me to add to
> > maintainers in the same patch of the driver.
> >
>=20
> I've also seen this warning when adding a new file.  I think it is just a=
sking you
> to check if the new file is already covered by a maintainer.
> For any files added to the drivers/hv directory, like here, we already ha=
ve
> maintainers specified, and the warning can be ignored.  The logic in
> checkpatch.pl isn't sophisticated enough to figure out for sure whether t=
here
> are already maintainers specified.
>=20
> > >
> > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
> > > > 66c794d..2128a8b 100644
> > > > --- a/drivers/hv/Kconfig
> > > > +++ b/drivers/hv/Kconfig
> > > > @@ -27,4 +27,15 @@ config HYPERV_BALLOON
> > > >  	help
> > > >  	  Select this option to enable Hyper-V Balloon driver.
> > > >
> > > > +config HYPERV_XS_FASTPATH
> > > > +	tristate "Microsoft Azure XStore Fastpath driver"
> > > > +	depends on HYPERV && X86_64
> > > > +	help
> > > > +	  Select this option to enable Microsoft Azure XStore Fastpath dr=
iver.
> > > > +
> > > > +	  This driver supports accelerated Microsoft Azure XStore Blob ac=
cess.
> > > > +	  To compile this driver as a module, choose M here. The module w=
ill
> be
> > > > +	  called hv_xs_fastpath.
> > > > +
> > > > +
> > > >  endmenu
> > > > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile index
> > > > 94daf82..080fe88 100644
> > > > --- a/drivers/hv/Makefile
> > > > +++ b/drivers/hv/Makefile
> > > > @@ -2,6 +2,7 @@
> > > >  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
> > > >  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
> > > >  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> > > > +obj-$(CONFIG_HYPERV_XS_FASTPATH)+=3D hv_xs_fastpath.o
> > > >
> > > >  CFLAGS_hv_trace.o =3D -I$(src)
> > > >  CFLAGS_hv_balloon.o =3D -I$(src)
> > > > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > > > index 6fd7ae5..a3f156e 100644
> > > > --- a/drivers/hv/channel_mgmt.c
> > > > +++ b/drivers/hv/channel_mgmt.c
> > > > @@ -153,6 +153,12 @@
> > > >  	  .allowed_in_isolated =3D false,
> > > >  	},
> > > >
> > > > +	/* XStore Fastpath */
> > > > +	{ .dev_type =3D HV_XS_FASTPATH,
> > > > +	  HV_XS_FASTPATH_GUID,
> > > > +	  .perf_device =3D true,
> > >
> > > I'm curious about setting .perf_device=3Dtrue.  The other perf device=
s
> > > are those that support multiple VMbus channels, but this device has
> > > only a single channel.  Is there another reason to set .perf_device=
=3Dtrue?
> > >
> > > Also set .allowed_in_isolated to "false" so that it is explicitly
> > > called out like the other entries in the table.
> >
> > Will fix this.
> >
> > >
> > > > +	},
> > > > +
> > > >  	/* Unknown GUID */
> > > >  	{ .dev_type =3D HV_UNKNOWN,
> > > >  	  .perf_device =3D false,
> > > > diff --git a/drivers/hv/hv_xs_fastpath.c
> > > > b/drivers/hv/hv_xs_fastpath.c new file mode 100644 index
> > > > 0000000..ee4152e
> > > > --- /dev/null
> > > > +++ b/drivers/hv/hv_xs_fastpath.c
> > > > @@ -0,0 +1,579 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > >
> > > Let's have an offline discussion about the license choice here and
> > > in hv_xs_fastpath.h.
> > >
> > > > +/*
> > > > + * Copyright (c) 2021, Microsoft Corporation.
> > > > + *
> > > > + * Authors:
> > > > + *   Long Li <longli@microsoft.com>
> > > > + */
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/cred.h>
> > > > +#include <linux/debugfs.h>
> > > > +#include <linux/pagemap.h>
> > > > +#include "hv_xs_fastpath.h"
> > > > +
> > > > +#ifdef CONFIG_DEBUG_FS
> > > > +struct dentry *xs_fastpath_debugfs_root; #endif
> > > > +
> > > > +static struct xs_fastpath_device xs_fastpath_dev;
> > > > +
> > > > +static int xs_fastpath_ringbuffer_size =3D (128 * 1024);
> > > > +module_param(xs_fastpath_ringbuffer_size, int, 0444);
> > > > +MODULE_PARM_DESC(xs_fastpath_ringbuffer_size, "Ring buffer size
> > > > +(bytes)");
> > > > +
> > > > +static const struct hv_vmbus_device_id id_table[] =3D {
> > > > +	{ HV_XS_FASTPATH_GUID,
> > > > +	  .driver_data =3D 0
> > > > +	},
> > > > +	{ },
> > > > +};
> > > > +
> > > > +#define XS_ERR 0
> > > > +#define XS_WARN 1
> > > > +#define XS_DBG 2
> > > > +static int log_level =3D XS_WARN;
> > > > +module_param(log_level, int, 0644);
> > > > +MODULE_PARM_DESC(logging_level,
> > >
> > > s/logging_level/log_level/
> > >
> > > > +	"Log level, 0 - Error, 1 - Warning (default), 3 - Debug.");
> > >
> > > s/Log level, 0/Log level: 0/
> > > s/3 - Debug/2 - Debug/
> > >
> > > > +
> > > > +#define xs_fastpath_log(level, fmt, args...)	\
> > > > +do {	\
> > > > +	if (level <=3D log_level)	\
> > > > +		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
> > > > +} while (0)
> > > > +
> > > > +#define xs_fastpath_dbg(fmt, args...) xs_fastpath_log(XS_DBG,
> > > > +fmt,
> > > > +##args) #define xs_fastpath_warn(fmt, args...)
> > > > +xs_fastpath_log(XS_WARN, fmt, ##args) #define
> > > > +xs_fastpath_err(fmt,
> > > > +args...) xs_fastpath_log(XS_ERR, fmt, ##args)
> > > > +
> > > > +struct xs_fastpath_vsp_request_ctx {
> > > > +	struct list_head list;
> > > > +	struct completion wait_vsp;
> > > > +	struct xs_fastpath_request_sync *request; };
> > >
> > > Any reason for this structure definition to be here instead of in
> > > hv_xs_fastpath.h?
> >
> > I will restructure the code and move most driver private data structure=
s
> to .c file.
> >
> > >
> > > > +
> > > > +static void xs_fastpath_on_channel_callback(void *context) {
> > > > +	struct vmbus_channel *channel =3D (struct vmbus_channel *)context=
;
> > > > +	const struct vmpacket_descriptor *desc;
> > > > +
> > > > +	xs_fastpath_dbg("entering interrupt from vmbus\n");
> > > > +	foreach_vmbus_pkt(desc, channel) {
> > > > +		struct xs_fastpath_vsp_request_ctx *request_ctx;
> > > > +		struct xs_fastpath_vsp_response *response;
> > > > +		u64 cmd_rqst =3D vmbus_request_addr(&channel->requestor,
> > > > +					desc->trans_id);
> > > > +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> > > > +			xs_fastpath_err("Incorrect transaction id %llu\n",
> > > > +				desc->trans_id);
> > > > +			continue;
> > > > +		}
> > > > +		request_ctx =3D (struct xs_fastpath_vsp_request_ctx
> *)cmd_rqst;
> > > > +		response =3D hv_pkt_data(desc);
> > > > +
> > > > +		xs_fastpath_dbg("got response for request %pUb status %u"
> > > > +			"response_len %u\n",
> > > > +			&request_ctx->request->guid, response->error,
> > > > +			response->response_len);
> > > > +		request_ctx->request->response.status =3D response->error;
> > > > +		request_ctx->request->response.response_len =3D
> > > > +			response->response_len;
> > > > +		complete(&request_ctx->wait_vsp);
> > > > +	}
> > >
> > > This for loop could potentially go on for a long time if there were
> > > lots of responses in the ring buffer, or responses being added while
> > > this loop is running.  It seems like there should be some timeout,
> > > and the remaining work rescheduled to prevent it from running too
> > > long.  I know this code is just like the code in storvsc, but
> > > storvsc_on_channel_callback() has the same problem, which is on my li=
st
> to fix.
> >
> > This is a good point. I don't think this is a problem for remote
> > storage drivers, as they are on request-response protocol, and
> > completions can't stall the CPU. Other storage drivers like NVMe is usi=
ng a
> similar loop in nvme_process_cq().
> >
> > >
> > > > +
> > > > +}
> > > > +
> > > > +static int xs_fastpath_fop_open(struct inode *inode, struct file
> > > > +*file) {
> > > > +	atomic_inc(&xs_fastpath_dev.file_count);
> > > > +	if (xs_fastpath_dev.removing) {
> > > > +		if (atomic_dec_and_test(&xs_fastpath_dev.file_count))
> > > > +			wake_up(&xs_fastpath_dev.wait_files);
> > > > +		return -ENODEV;
> > > > +	}
> > > > +
> > > > +	file->private_data =3D &xs_fastpath_dev;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xs_fastpath_fop_release(struct inode *inode, struct
> > > > +file
> > > > +*file) {
> > > > +	if (atomic_dec_and_test(&xs_fastpath_dev.file_count))
> > > > +		wake_up(&xs_fastpath_dev.wait_files);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static inline bool xs_fastpath_safe_file_access(struct file *file)=
 {
> > > > +	return file->f_cred =3D=3D current_cred() && !uaccess_kernel(); }
> > > > +
> > > > +static int get_buffer_pages(int rw, void __user *buffer, u32
> buffer_len,
> > > > +	struct page ***ppages, size_t *start, size_t *num_pages) {
> > > > +	struct iovec iov;
> > > > +	struct iov_iter iter;
> > > > +	int ret;
> > > > +	ssize_t result;
> > > > +	struct page **pages;
> > > > +
> > > > +	ret =3D import_single_range(rw, buffer, buffer_len, &iov, &iter);
> > > > +	if (ret) {
> > > > +		xs_fastpath_err("request buffer access error %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +	xs_fastpath_dbg("iov_iter type %d offset %lu count %lu
> nr_segs %lu\n",
> > > > +		iter.type, iter.iov_offset, iter.count, iter.nr_segs);
> > > > +
> > > > +	result =3D iov_iter_get_pages_alloc(&iter, &pages, buffer_len, st=
art);
> > > > +	if (result < 0) {
> > > > +		xs_fastpath_err("failed to ping user pages result=3D%ld\n",
> > > > +result);
> > >
> > > s/ping/pin/   [??]
> > >
> > > > +		return result;
> > > > +	}
> > > > +	if (result !=3D buffer_len) {
> > > > +		xs_fastpath_err("can't ping user pages requested %d
> got %ld\n",
> > >
> > > s/ping/pin/   [??]
> > >
> > > > +			buffer_len, result);
> > > > +		return -EFAULT;
> > > > +	}
> > > > +
> > > > +	*ppages =3D pages;
> > > > +	*num_pages =3D (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
> > > > +	return 0;
> > > > +}
> > >
> > > Can any of the xs_fastpath_err() calls be caused by a user error,
> > > such as passing in bad values on an ioctl call?  If so, we probably
> > > want to not print a console message in those cases.
> > >
> > > > +
> > > > +static void fill_in_page_buffer(u64 *pfn_array,
> > > > +	int *index, struct page **pages, unsigned long num_pages) {
> > > > +	int i, page_idx =3D *index;
> > > > +
> > > > +	for (i =3D 0; i < num_pages; i++)
> > > > +		pfn_array[page_idx++] =3D page_to_pfn(pages[i]);
> > > > +	*index =3D page_idx;
> > > > +}
> > >
> > > See notes below.  Filling in the pfn_array needs to account for
> > > running on an
> > > ARM64 system where PAGE_SIZE !=3D HV_HYP_PAGE_SIZE.
> >
> > The driver is currently conditioned on X86_64 in kconfig, as there is
> > no host driver and no way to test it on ARM64. I suggest adding support=
 to
> ARM64 if needed in future.
>=20
> I'm not completely in agreement with the idea of solving the issues with
> different PAGE_SIZE later, but as you say, the driver is conditioned on
> X86_64 in Kconfig, so I won't argue the point.
>=20
> >
> > >
> > > > +
> > > > +static void free_buffer_pages(size_t num_pages, struct page
> > > > +**pages) {
> > > > +	unsigned long i;
> > > > +
> > > > +	for (i =3D 0; i < num_pages; i++)
> > > > +		if (pages[i])
> > > > +			put_page(pages[i]);
> > > > +	kfree(pages);
> > >
> > > Doesn't this need to be kvfree()?  'pages' is allocated with
> > > kvmalloc(), which could return vmalloc memory.
> >
> > Will fix this.
> >
> > >
> > > > +}
> > > > +
> > > > +static long xs_fastpath_ioctl_user_request(struct file *filp,
> > > > +unsigned long arg) {
> > > > +	struct xs_fastpath_device *dev =3D filp->private_data;
> > > > +	char __user *argp =3D (char __user *) arg;
> > > > +	struct xs_fastpath_request_sync request;
> > > > +	struct xs_fastpath_vsp_request_ctx *request_ctx;
> > > > +	unsigned long flags;
> > > > +	int ret;
> > > > +	size_t request_start, request_num_pages =3D 0;
> > > > +	size_t response_start, response_num_pages =3D 0;
> > > > +	size_t data_start, data_num_pages =3D 0, total_num_pages;
> > > > +	struct page **request_pages =3D NULL, **response_pages =3D NULL;
> > > > +	struct page **data_pages =3D NULL;
> > > > +	struct vmbus_packet_mpb_array *desc;
> > > > +	u64 *pfn_array;
> > > > +	int desc_size;
> > > > +	int page_idx;
> > > > +	struct xs_fastpath_vsp_request *vsp_request;
> > > > +
> > > > +	if (dev->removing)
> > > > +		return -ENODEV;
> > >
> > > I think this test is just to avoid starting a new request if we know
> > > that the device has been marked for removing.  But because there's
> > > no synchronization, it's possible for the "removing" flag to be set
> > > immediately after the test has passed.
> >
> > The usage of this flag "removing" here is to provide a fast failure
> > path if a user-mode keeps requesting while the device is being
> > removed, thus saving CPU cycles if a malicious user- mode is doing
> > this. It's okay to remove the check of this flag and it doesn't affect =
the
> correctness of the device removal logic. I prefer to leave the check as i=
s.
> >
> > >
> > > > +
> > > > +	if (!xs_fastpath_safe_file_access(filp)) {
> > > > +		xs_fastpath_err("process %d(%s) changed security contexts
> after"
> > > > +			" opening file descriptor\n",
> > > > +			task_tgid_vnr(current), current->comm);
> > >
> > > I don't think we should produce a console message, at least not a "er=
r"
> > > level.  It gives a user the ability to generate an arbitrary number
> > > of console messages.  Maybe "dbg" level would be OK.
> > >
> > > > +		return -EACCES;
> > > > +	}
> > > > +
> > > > +	if (!access_ok(argp, sizeof(struct xs_fastpath_request_sync))) {
> > > > +
> > > > +		xs_fastpath_err("don't have permission to user provide
> buffer\n");
> > > > +		return -EFAULT;
> > > > +	}
> > >
> > > Is this check needed at all?  Again, we don't want to generate a
> > > console message due to a user error, and copy_from_user() below
> > > will validate that the access is OK.   A "dbg" level message would be
> > > OK.
> >
> > Yes, this can be removed as copy_from_user() will guarantee permission =
is
> correct.
> >
> > >
> > > > +
> > > > +	if (copy_from_user(&request, argp, sizeof(request)))
> > > > +		return -EFAULT;
> > > > +
> > > > +	xs_fastpath_dbg("xs_fastpath ioctl request guid %pUb timeout %u
> request_len %u"
> > > > +		" response_len %u data_len %u request_buffer %llx "
> > > > +		"response_buffer %llx data_buffer %llx\n",
> > > > +		&request.guid, request.timeout, request.request_len,
> > > > +		request.response_len, request.data_len,
> request.request_buffer,
> > > > +		request.response_buffer, request.data_buffer);
> > > > +
> > > > +	if (!request.request_len || !request.response_len)
> > > > +		return -EINVAL;
> > > > +
> > > > +	request_ctx =3D kzalloc(sizeof(*request_ctx), GFP_KERNEL);
> > > > +	if (!request_ctx)
> > > > +		return -ENOMEM;
> > >
> > > Could the request_ctx just be on the stack?  Below, it stores a
> > > pointer to the request, which is on the stack, and the request is
> > > accessed on the onchannel_callback function.
> > > So having request_ctx on the stack wouldn't be the only usage of a
> > > stack variable in the onchannel_callback function.
> >
> > I can move to request_ctx to stack.
> >
> > >
> > > > +
> > > > +	init_completion(&request_ctx->wait_vsp);
> > > > +	request_ctx->request =3D &request;
> > > > +
> > > > +	/*
> > > > +	 * Need to set rw to READ to have page table set up for passing t=
o
> VSP.
> > > > +	 * Setting it to WRITE will cause the page table entry not alloca=
ted
> > > > +	 * as it's waiting on Copy-On-Write on next page fault. This does=
n't
> > > > +	 * work in this scenario because VSP wants all the pages to be
> present.
> > > > +	 */
> > > > +	ret =3D get_buffer_pages(READ, (void __user
> *)request.request_buffer,
> > > > +		request.request_len, &request_pages, &request_start,
> > > > +		&request_num_pages);
> > > > +	if (ret)
> > > > +		goto get_user_page_failed;
> > > > +
> > > > +	ret =3D get_buffer_pages(READ, (void __user
> *)request.response_buffer,
> > > > +		request.response_len, &response_pages, &response_start,
> > > > +		&response_num_pages);
> > > > +	if (ret)
> > > > +		goto get_user_page_failed;
> > > > +
> > > > +	if (request.data_len) {
> > > > +		ret =3D get_buffer_pages(READ,
> > > > +			(void __user *) request.data_buffer,
> request.data_len,
> > > > +			&data_pages, &data_start, &data_num_pages);
> > > > +		if (ret)
> > > > +			goto get_user_page_failed;
> > > > +	}
> > >
> > > Do the request_len, response_len, and data_len need to be validated
> > > before being passed to get_buffer_pages() since they are passed in
> > > from user space?  The fields are 32 bits, so the max value is 4
> > > Gbytes, which maybe is OK.  But with XS_FASTPATH_MAX_PAGES set to
> > > 8192, the maximum size is
> > > 32 Mbytes with a 4K page size, and 512 Mbytes with a 64K page size.
> >
> > The VSP support a maximum of 32MB of buffer pages combined, so
> > XS_FASTPATH_MAX_PAGES is set to 8192. The check is done to make sure
> > we don't pass excessive pages to VSP. I'll check on request_len,
> > response_len and data_len before allocating pages.
> >
>=20
> Got it.  But since the VSP limit is based on size (32 MB), not pages, cou=
ld the
> check be done based on size rather than page count?  This would be one le=
ss
> thing to fix later to handle ARM64 page sizes.
>=20
> > >
> > > > +
> > > > +	total_num_pages =3D request_num_pages + response_num_pages +
> > > > +				data_num_pages;
> > > > +	if (total_num_pages > XS_FASTPATH_MAX_PAGES) {
> > >
> > > Note that this check imposes different limits depending on PAGE_SIZE.
> > > Is the value XS_FASTPATH_MAX_PAGES governed by the largest
> > > vmbus_packet_mpb_array that Hyper-V will accept?  If not, does there
> > > need to be a check against the max vmbus_packet_mpb_array size?
> > > (I don't know what the Hyper-V limit is.)
> > >
> > > > +		xs_fastpath_err("number of DMA pages %lu buffer
> exceeding %u\n",
> > > > +			total_num_pages, XS_FASTPATH_MAX_PAGES);
> > > > +		ret =3D -EINVAL;
> > > > +		goto get_user_page_failed;
> > > > +	}
> > > > +
> > > > +	/* Construct a VMBUS packet and send it over to VSP */
> > > > +	desc_size =3D sizeof(struct vmbus_packet_mpb_array) +
> > > > +			sizeof(u64) * total_num_pages;
> > >
> > > The above doesn't handle the case where the guest PAGE_SIZE is
> > > different from the Hyper-V page size (HV_HYP_PAGE_SIZE), as can
> happen on ARM64.
> > >
> > > > +	desc =3D kzalloc(desc_size, GFP_KERNEL);
> > > > +	vsp_request =3D kzalloc(sizeof(*vsp_request), GFP_KERNEL);
> > > > +	if (!desc || !vsp_request) {
> > > > +		kfree(desc);
> > > > +		kfree(vsp_request);
> > > > +		ret =3D -ENOMEM;
> > > > +		goto get_user_page_failed;
> > > > +	}
> > > > +
> > > > +	desc->range.offset =3D 0;
> > > > +	desc->range.len =3D total_num_pages * PAGE_SIZE;
> > > > +	pfn_array =3D desc->range.pfn_array;
> > > > +	page_idx =3D 0;
> > > > +
> > > > +	if (request.data_len) {
> > > > +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> > > > +			data_num_pages);
> > > > +		vsp_request->data_buffer_offset =3D data_start;
> > > > +		vsp_request->data_buffer_length =3D request.data_len;
> > > > +		vsp_request->data_buffer_valid =3D 1;
> > > > +	}
> > > > +
> > > > +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> > > > +		request_num_pages);
> > > > +	vsp_request->request_buffer_offset =3D request_start +
> > > > +						data_num_pages *
> PAGE_SIZE;
> > > > +	vsp_request->request_buffer_length =3D request.request_len;
> > > > +
> > > > +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> > > > +		response_num_pages);
> > > > +	vsp_request->response_buffer_offset =3D response_start +
> > > > +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> > > > +	vsp_request->response_buffer_length =3D request.response_len;
> > >
> > > All of the above that is filling in the pfn_array needs to handle
> > > the case where PAGE_SIZE !=3D HV_HYP_PAGE_SIZE.
> > >
> > > > +
> > > > +	vsp_request->version =3D 0;
> > > > +	vsp_request->timeout_ms =3D request.timeout;
> > >
> > > Does the request.timeout value from user space need to be validated?
> > > I'm thinking about a value of 0, or a really small value like 1 ms,
> > > or a really large value that effectively means no timeout.
> >
> > The timeout is not used by the VSC/VSP kernel mode, so we don't mess up
> with it.
>=20
> In that case, would it be better to just pass zero as the timeout in the =
VSP
> request?

Checked with VSP guy, I got it wrong in the previous email. VSP kernel-mode=
 does use this timeout to decide when to cancel the I/O. Accounting for CPU=
 usage, the VSC is guaranteed to get a response back in timeout (+ some del=
ays).

But I don't know how we can check this value in the VSC. A value of 0 means=
 waiting forever at VSP, and a user-mode can choose whatever timeout it wan=
ts.

>=20
> >
> > >
> > > > +	vsp_request->operation_type =3D
> XS_FASTPATH_DRIVER_USER_REQUEST;
> > > > +	guid_copy(&vsp_request->transaction_id, &request.guid);
> > > > +
> > > > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > > > +	list_add_tail(&request_ctx->list, &dev->vsp_pending_list);
> > > > +	spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > > > +
> > > > +	xs_fastpath_dbg("sending request to VSP\n");
> > > > +	xs_fastpath_dbg("desc_size %u desc->range.len %u desc-
> range.offset %u\n",
> > > > +		desc_size, desc->range.len, desc->range.offset);
> > > > +	xs_fastpath_dbg("vsp_request data_buffer_offset %u
> data_buffer_length %u "
> > > > +		"data_buffer_valid %u request_buffer_offset %u "
> > > > +		"request_buffer_length %u response_buffer_offset %u "
> > > > +		"response_buffer_length %u\n",
> > > > +		vsp_request->data_buffer_offset,
> > > > +		vsp_request->data_buffer_length,
> > > > +		vsp_request->data_buffer_valid,
> > > > +		vsp_request->request_buffer_offset,
> > > > +		vsp_request->request_buffer_length,
> > > > +		vsp_request->response_buffer_offset,
> > > > +		vsp_request->response_buffer_length);
> > > > +
> > > > +	ret =3D vmbus_sendpacket_mpb_desc(dev->device->channel, desc,
> desc_size,
> > > > +		vsp_request, sizeof(*vsp_request), (u64) request_ctx);
> > > > +
> > > > +	kfree(desc);
> > > > +	kfree(vsp_request);
> > > > +	if (ret)
> > > > +		goto vmbus_send_failed;
> > > > +
> > > > +	wait_for_completion(&request_ctx->wait_vsp);
> > >
> > > This is a "wait forever", which exists in other places in the
> > > Hyper-V drivers, but we've learned that might not be a good idea.
> > > It's more complicated to deal with a timeout, and the potential for
> > > the Hyper-V response to come in after the timeout, but that would be
> > > the most robust approach.  Maybe we can live with the "wait forever"
> > > approach for now, but in the long run we'll probably want something l=
ike
> a 30 second or 60 second timeout.
> > >
> > > > +
> > > > +	/*
> > > > +	 * At this point, the response is already written to request
> > > > +	 * by VMBUS completion handler, copy them to user-mode buffers
> > > > +	 * and return to user-mode
> > > > +	 */
> > > > +	if (copy_to_user(argp +
> > > > +			offsetof(struct xs_fastpath_request_sync,
> > > > +				response.status),
> > > > +			&request.response.status,
> > > > +			sizeof(request.response.status))) {
> > > > +		ret =3D -EFAULT;
> > > > +		goto vmbus_send_failed;
> > > > +	}
> > > > +
> > > > +	if (copy_to_user(argp +
> > > > +			offsetof(struct xs_fastpath_request_sync,
> > > > +				response.response_len),
> > > > +			&request.response.response_len,
> > > > +			sizeof(request.response.response_len)))
> > > > +		ret =3D -EFAULT;
> > > > +
> > > > +vmbus_send_failed:
> > > > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > > > +	list_del(&request_ctx->list);
> > > > +	if (list_empty(&dev->vsp_pending_list))
> > > > +		wake_up(&dev->wait_vsp);
> > > > +	spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > > > +
> > > > +get_user_page_failed:
> > > > +	free_buffer_pages(request_num_pages, request_pages);
> > > > +	free_buffer_pages(response_num_pages, response_pages);
> > > > +	free_buffer_pages(data_num_pages, data_pages);
> > > > +
> > > > +	kfree(request_ctx);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static long xs_fastpath_fop_ioctl(struct file *filp, unsigned int =
cmd,
> > > > +	unsigned long arg)
> > > > +{
> > > > +	long ret =3D -EIO;
> > > > +
> > > > +	switch (cmd) {
> > > > +	case IOCTL_XS_FASTPATH_DRIVER_USER_REQUEST:
> > > > +		if (_IOC_SIZE(cmd) !=3D sizeof(struct
> xs_fastpath_request_sync))
> > > > +			return -EINVAL;
> > > > +		ret =3D xs_fastpath_ioctl_user_request(filp, arg);
> > > > +		break;
> > > > +
> > > > +	default:
> > > > +		xs_fastpath_err("unrecognized IOCTL code %u\n", cmd);
> > >
> > > Again, probably don't want to output a console message just because
> > > user space passed a bad ioctl code.
> > >
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static const struct file_operations xs_fastpath_client_fops =3D {
> > > > +	.owner	=3D THIS_MODULE,
> > > > +	.open	=3D xs_fastpath_fop_open,
> > > > +	.unlocked_ioctl =3D xs_fastpath_fop_ioctl,
> > > > +	.release =3D xs_fastpath_fop_release, };
> > > > +
> > > > +static struct miscdevice xs_fastpath_misc_device =3D {
> > > > +	MISC_DYNAMIC_MINOR,
> > > > +	"azure_xs_fastpath",
> > > > +	&xs_fastpath_client_fops,
> > > > +};
> > > > +
> > > > +static int xs_fastpath_show_pending_requests(struct seq_file *m,
> > > > +void
> > > > +*v) {
> > > > +	unsigned long flags;
> > > > +	struct xs_fastpath_vsp_request_ctx *request_ctx;
> > > > +
> > > > +	seq_puts(m, "List of pending requests\n");
> > > > +	seq_puts(m, "UUID request_len response_len data_len "
> > > > +		"request_buffer response_buffer data_buffer\n");
> > > > +	spin_lock_irqsave(&xs_fastpath_dev.vsp_pending_lock, flags);
> > > > +	list_for_each_entry(request_ctx,
> &xs_fastpath_dev.vsp_pending_list, list) {
> > > > +		seq_printf(m, "%pUb ", &request_ctx->request->guid);
> > > > +		seq_printf(m, "%u ", request_ctx->request->request_len);
> > > > +		seq_printf(m, "%u ", request_ctx->request->response_len);
> > > > +		seq_printf(m, "%u ", request_ctx->request->data_len);
> > > > +		seq_printf(m, "%llx ", request_ctx->request-request_buffer);
> > > > +		seq_printf(m, "%llx ", request_ctx->request-
> response_buffer);
> > > > +		seq_printf(m, "%llx\n", request_ctx->request->data_buffer);
> > > > +	}
> > > > +	spin_unlock_irqrestore(&xs_fastpath_dev.vsp_pending_lock,
> > > > +flags);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xs_fastpath_debugfs_open(struct inode *inode, struct
> > > > +file
> > > > +*file) {
> > > > +	return single_open(file, xs_fastpath_show_pending_requests,
> > > > +NULL); }
> > > > +
> > > > +static const struct file_operations xs_fastpath_debugfs_fops =3D {
> > > > +	.open		=3D xs_fastpath_debugfs_open,
> > > > +	.read		=3D seq_read,
> > > > +	.llseek		=3D seq_lseek,
> > > > +	.release	=3D seq_release
> > > > +};
> > > > +
> > > > +static void xs_fastpath_remove_device(struct xs_fastpath_device
> > > > +*dev) {
> > > > +	wait_event(dev->wait_files, atomic_read(&dev->file_count) =3D=3D =
0);
> > >
> > > After this wait_event() completes, but before misc_deregister()
> > > completes, the device can still be found and opened.  Because the
> > > removing flag is set,
> > > xs_fastpath_fop_open() won't do anything but increment the
> > > file_count, then decrement it again, and call wake_up().  That all
> > > works with xs_fastpath_dev as a static variable.  But it might not
> > > work if xs_fastpath_dev was dynamically allocated, as would be the
> > > case if multiple such devices were supported.  So I'm wondering if
> > > this code really should do the
> > > misc_deregister() and debugfs_remove_recursive() first, and then to
> > > the wait_event().  When done in that order, you know that the device
> > > can't be found again after the wait_event() completes.  Then the
> > > "removing" flag is not even needed.
> >
> > I don't think it's safe to call misc_deregister() while there are
> > files opened and I/O ongoing on the device. If you see we have this
> > guarantee from misc_deregister() to not mess up with ongoing I/O, pleas=
e
> point me to the code.
>=20
> But your code doesn't provide this safety because immediately after
> wait_event() returns due to the file_count being 0, another process could
> open the /dev device and have it open at least for a short duration of ti=
me
> while it is checking the removing flag.  So misc_deregister() could be
> happening in parallel with the /dev device being open (though not with I/=
Os
> being in progress).

The purpose is to prevent I/O in progress as it guarantees no file handles =
can be used to issue I/O. In async mode, the driver must return I/O respons=
e to user-mode and this shouldn't happen while misc_deregister() is in prog=
ress.

>=20
> I don't think there is any way for this driver (or any driver) to provide=
 the kind
> of safety you describe, which is why I think misc_deregister() must handl=
e it,
> though I haven't gone and looked specifically for the code that does so.
>=20
> >
> > I don't see the need for supporting multiple xs_fastpath_dev. It is
> > dynamically allocated on vmbus probe, currently there can be only one
> such device on the system.
>=20
> OK
>=20
> >
> > >
> > > > +	misc_deregister(&xs_fastpath_misc_device);
> > > > +#ifdef CONFIG_DEBUG_FS
> > > > +	debugfs_remove_recursive(xs_fastpath_debugfs_root);
> > > > +#endif
> > > > +	/* At this point, we won't get any requests from user-mode */ }
> > > > +
> > > > +static int xs_fastpath_create_device(struct xs_fastpath_device
> > > > +*dev) {
> > > > +	int rc;
> > > > +	struct dentry *d;
> > > > +
> > > > +	atomic_set(&xs_fastpath_dev.file_count, 0);
> > > > +	init_waitqueue_head(&xs_fastpath_dev.wait_files);
> > > > +	rc =3D misc_register(&xs_fastpath_misc_device);
> > > > +	if (rc) {
> > > > +		xs_fastpath_err("misc_register failed rc %d\n", rc);
> > > > +		return rc;
> > > > +	}
> > > > +
> > > > +#ifdef CONFIG_DEBUG_FS
> > > > +	xs_fastpath_debugfs_root =3D debugfs_create_dir("xs_fastpath",
> NULL);
> > > > +	if (!IS_ERR_OR_NULL(xs_fastpath_debugfs_root)) {
> > > > +		d =3D debugfs_create_file("pending_requests", 0400,
> > > > +			xs_fastpath_debugfs_root, NULL,
> > > > +			&xs_fastpath_debugfs_fops);
> > > > +		if (IS_ERR_OR_NULL(d)) {
> > > > +			xs_fastpath_err("failed to create debugfs file\n");
> > > > +
> 	debugfs_remove_recursive(xs_fastpath_debugfs_root);
> > > > +			xs_fastpath_debugfs_root =3D NULL;
> > > > +		}
> > > > +	} else
> > > > +		xs_fastpath_err("failed to create debugfs root\n"); #endif
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xs_fastpath_connect_to_vsp(struct hv_device *device,
> > > > +u32
> > > > +ring_size) {
> > > > +	int ret;
> > > > +
> > > > +	spin_lock_init(&xs_fastpath_dev.vsp_pending_lock);
> > > > +	INIT_LIST_HEAD(&xs_fastpath_dev.vsp_pending_list);
> > > > +	init_waitqueue_head(&xs_fastpath_dev.wait_vsp);
> > > > +	xs_fastpath_dev.removing =3D false;
> > > > +
> > > > +	xs_fastpath_dev.device =3D device;
> > > > +	device->channel->rqstor_size =3D xs_fastpath_ringbuffer_size /
> > > > +		sizeof(struct xs_fastpath_vsp_request);
> > >
> > > That setting probably isn't correct.  Presumably the Hyper-V VSP can
> > > hold a certain number of requests that it has already removed the
> > > guest->host ring buffer.  So the max number of in-flight requests
> > > would be that Hyper-V VSP count, plus the number of requests that
> > > will fit in the ring buffer.
> > >
> > > Independent of this setting, the ioctl's are synchronous, so the
> > > total number of in-flight requests will be the number of threads
> > > making requests.   Note that these ioctl calls include all blobs
> > > being accessed using this method by all users running in the VM.
> > > Nonetheless, it might be reasonable to just put a fixed cap on that
> number.
> > > Perhaps something like 1024?  If the limit is exceeded, the calls to
> > > vmbus_sendpacket_mpb_desc() will start failing because of being
> > > unable to allocate a requestID.
> >
> > The VSC is designed to support asynchronous I/O requests, so this
> > number can be potentially large. The reason why I put the largest
> > possible number for rqstor_size (based on ring buffer) is not having it=
 limit
> other queue depths in the Fastpath code path.
>=20
> I don't understand why the rqstor_size would be based on the ring buffer
> size.  rqstor_size needs to accommodate all in-flight requests, including=
 those
> that the VSP may have already removed from the ring buffer but which are
> not yet complete.

This makes sense, I'll introduce a queue depth for the device and use that =
for rqstor_size.

>=20
> >
> > >
> > > Presumably the memory management subsystem will also limit the
> > > amount of memory being pinned by the ioctl calls, which could also
> > > cause the ioctl calls to return an error.
> > >
> > >
> > > > +
> > > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0=
,
> > > > +			xs_fastpath_on_channel_callback, device->channel);
> > > > +
> > > > +	if (ret) {
> > > > +		xs_fastpath_err("failed to connect to VSP ret %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	hv_set_drvdata(device, &xs_fastpath_dev);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void xs_fastpath_remove_vmbus(struct hv_device *device) {
> > > > +	struct xs_fastpath_device *dev =3D hv_get_drvdata(device);
> > > > +	unsigned long flags;
> > > > +
> > > > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > > > +	if (!list_empty(&dev->vsp_pending_list)) {
> > >
> > > I don't think this can ever happen.  If the device has already been
> > > removed by xs_fastpath_remove_device(), then we know that the
> device
> > > isn't open in any processes, so there can't be any ioctl's in
> > > progress that would have entries in the vsp_pending_list.
> >
> > The VSC is designed to support asynchronous I/O (while not implemented
> > in this version), so vsp_pending_list is needed if a user-mode decides
> > to close the file and not waiting for I/O.
> >
> > >
> > > > +		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > > > +		xs_fastpath_dbg("wait for vsp_pending_list\n");
> > > > +		wait_event(dev->wait_vsp,
> > > > +			list_empty(&dev->vsp_pending_list));
> > > > +	} else
> > > > +		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > > > +
> > > > +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> > > > +	hv_set_drvdata(device, NULL);
> > > > +	vmbus_close(device->channel);
> > > > +}
> > > > +
> > > > +static int xs_fastpath_probe(struct hv_device *device,
> > > > +			const struct hv_vmbus_device_id *dev_id) {
> > > > +	int rc;
> > > > +
> > > > +	xs_fastpath_dbg("probing device\n");
> > > > +
> > > > +	rc =3D xs_fastpath_connect_to_vsp(device,
> xs_fastpath_ringbuffer_size);
> > > > +	if (rc) {
> > > > +		xs_fastpath_err("error connecting to VSP rc %d\n", rc);
> > > > +		return rc;
> > > > +	}
> > > > +
> > > > +	// create user-mode client library facing device
> > > > +	rc =3D xs_fastpath_create_device(&xs_fastpath_dev);
> > > > +	if (rc) {
> > > > +		xs_fastpath_remove_vmbus(device);
> > > > +		return rc;
> > > > +	}
> > > > +
> > > > +	xs_fastpath_dbg("successfully probed device\n");
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xs_fastpath_remove(struct hv_device *dev) {
> > > > +	struct xs_fastpath_device *device =3D hv_get_drvdata(dev);
> > > > +
> > > > +	device->removing =3D true;
> > > > +	xs_fastpath_remove_device(device);
> > > > +	xs_fastpath_remove_vmbus(dev);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static struct hv_driver xs_fastpath_drv =3D {
> > > > +	.name =3D KBUILD_MODNAME,
> > > > +	.id_table =3D id_table,
> > > > +	.probe =3D xs_fastpath_probe,
> > > > +	.remove =3D xs_fastpath_remove,
> > > > +	.driver =3D {
> > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > +	},
> > > > +};
> > > > +
> > > > +static int __init xs_fastpath_drv_init(void) {
> > > > +	int ret;
> > > > +
> > > > +	ret =3D vmbus_driver_register(&xs_fastpath_drv);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void __exit xs_fastpath_drv_exit(void) {
> > > > +	vmbus_driver_unregister(&xs_fastpath_drv);
> > > > +}
> > > > +
> > > > +MODULE_LICENSE("GPL");
> > >
> > > Let's discuss the license choice offline.
> > >
> > > > +MODULE_DESCRIPTION("Microsoft Azure XStore Storage Fastpath
> > > driver");
> > >
> > > The word "Storage" seems unnecessary.  Everywhere else the name is
> > > just "Azure Xstore Fastpath".
> > >
> > > > +module_init(xs_fastpath_drv_init);
> > > > +module_exit(xs_fastpath_drv_exit);
> > > > diff --git a/drivers/hv/hv_xs_fastpath.h
> > > > b/drivers/hv/hv_xs_fastpath.h new file mode 100644 index
> > > > 0000000..6db1904
> > > > --- /dev/null
> > > > +++ b/drivers/hv/hv_xs_fastpath.h
> > > > @@ -0,0 +1,82 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Copyright (c) 2021, Microsoft Corporation.
> > > > + *
> > > > + * Authors:
> > > > + *   Long Li <longli@microsoft.com>
> > > > + */
> > > > +#ifndef _XS_FASTPATH_H
> > > > +#define _XS_FASTPATH_H
> > > > +
> > > > +#include <linux/hyperv.h>
> > > > +#include <linux/miscdevice.h>
> > > > +#include <linux/hashtable.h>
> > > > +#include <linux/uio.h>
> > > > +
> > > > +struct xs_fastpath_device {
> > > > +	struct hv_device *device;
> > > > +	bool removing;
> > > > +
> > > > +	struct list_head vsp_pending_list;
> > > > +	spinlock_t vsp_pending_lock;
> > > > +	wait_queue_head_t wait_vsp;
> > > > +
> > > > +	wait_queue_head_t wait_files;
> > > > +	atomic_t file_count;
> > > > +};
> > > > +
> > > > +/* user-mode sync request sent through ioctl */ struct
> > > > +xs_fastpath_request_sync_response {
> > > > +	__u32 status;
> > > > +	__u32 response_len;
> > > > +};
> > > > +
> > > > +struct xs_fastpath_request_sync {
> > > > +	guid_t guid;
> > > > +	__u32 timeout;
> > > > +	__u32 request_len;
> > > > +	__u32 response_len;
> > > > +	__u32 data_len;
> > > > +	__aligned_u64 request_buffer;
> > > > +	__aligned_u64 response_buffer;
> > > > +	__aligned_u64 data_buffer;
> > > > +	struct xs_fastpath_request_sync_response response; };
> > >
> > > Wouldn't the structures used by user space need to go in a uapi heade=
r
> file?
> >
> > I will move those to uapi.
> >
> > >
> > > > +
> > > > +/* VSP messages */
> > > > +enum xs_fastpath_vsp_request_type {
> > > > +	XS_FASTPATH_DRIVER_REQUEST_FIRST     =3D 0x100,
> > > > +	XS_FASTPATH_DRIVER_USER_REQUEST      =3D 0x100,
> > > > +	XS_FASTPATH_DRIVER_REGISTER_BUFFER   =3D 0x101,
> > > > +	XS_FASTPATH_DRIVER_DEREGISTER_BUFFER =3D 0x102,
> > > > +	XS_FASTPATH_DRIVER_REQUEST_MAX       =3D 0x103
> > >
> > > Most of these don't seem to be used in the code.  And it seems a bit
> > > unexpected for the MAX value to not be the same as the last value
> > > (DEREGISTER_BUFFER).
> >
> > Some are not used in this version of the driver; they are placed here
> > for protocol completeness.
> >
> > >
> > > > +};
> > > > +
> > > > +/* VSC->VSP request */
> > > > +struct xs_fastpath_vsp_request {
> > > > +	u32 version;
> > > > +	u32 timeout_ms;
> > > > +	u32 data_buffer_offset;
> > > > +	u32 data_buffer_length;
> > > > +	u32 data_buffer_valid;
> > > > +	u32 operation_type;
> > > > +	u32 request_buffer_offset;
> > > > +	u32 request_buffer_length;
> > > > +	u32 response_buffer_offset;
> > > > +	u32 response_buffer_length;
> > > > +	guid_t transaction_id;
> > > > +} __packed;
> > > > +
> > > > +/* VSP->VSC response */
> > > > +struct xs_fastpath_vsp_response {
> > > > +	u32 length;
> > > > +	u32 error;
> > > > +	u32 response_len;
> > > > +} __packed;
> > > > +
> > > > +#define IOCTL_XS_FASTPATH_DRIVER_USER_REQUEST \
> > > > +		_IOWR('R', 10, struct xs_fastpath_request_sync)
> > >
> > > How was the ioctl code decided?  Using 'R' and '10' seems to be in
> > > the range assigned to /dev/random, per the file
> > > Documentation/userspace- api/ioctl/ioctl-number.rst.
> > >
> > > Does this also need to go in a uapi header file?
> >
> > Will fix this.
> >
> > >
> > > > +
> > > > +#define XS_FASTPATH_MAX_PAGES 8192
> > >
> > > How was this value determined?  Would be good to leave a comment,
> > > and the comment should speak to how the limit is handled when
> > > PAGE_SIZE varies on different architectures.
> > >
> > > > +
> > > > +#endif /* define _XS_FASTPATH_H */
> > > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > > > d1e59db..a1730c4 100644
> > > > --- a/include/linux/hyperv.h
> > > > +++ b/include/linux/hyperv.h
> > > > @@ -772,6 +772,7 @@ enum vmbus_device_type {
> > > >  	HV_FCOPY,
> > > >  	HV_BACKUP,
> > > >  	HV_DM,
> > > > +	HV_XS_FASTPATH,
> > > >  	HV_UNKNOWN,
> > > >  };
> > > >
> > > > @@ -1350,6 +1351,14 @@ int vmbus_allocate_mmio(struct resource
> > > **new,
> > > > struct hv_device *device_obj,
> > > >  			  0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f)
> > > >
> > > >  /*
> > > > + * XStore Fastpath GUID
> > > > + * {0590b792-db64-45cc-81db-b8d70c577c9e}
> > > > + */
> > > > +#define HV_XS_FASTPATH_GUID \
> > > > +	.guid =3D GUID_INIT(0x0590b792, 0xdb64, 0x45cc, 0x81, 0xdb, \
> > > > +			  0xb8, 0xd7, 0x0c, 0x57, 0x7c, 0x9e)
> > > > +
> > > > +/*
> > > >   * Shutdown GUID
> > > >   * {0e0b6031-5213-4934-818b-38d90ced39db}
> > > >   */
> > > > --
> > > > 1.8.3.1
> >
> > I will address of rest of the comments.
