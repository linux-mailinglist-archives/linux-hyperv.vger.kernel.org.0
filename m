Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6E736318
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jun 2023 07:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjFTFTZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jun 2023 01:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFTFTX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jun 2023 01:19:23 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020017.outbound.protection.outlook.com [52.101.128.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90411A8;
        Mon, 19 Jun 2023 22:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3VbwAMeMwKyoxshTm8ORAgWCklL2EJekheIyj5FsSuVAvlbTRgPi2qUDC2lyoMML231tRv8lX20s2Us+qcP6oqbBi76Q19cnU2WWG3xfSHrm7VI329H3gI42o6jo8liAMO3fFQLuYtyBhTTgCFep14er01DRmBOBWWb5UWXqFgdCSHLA8bmbHxRHPrjhFMxomo6YMevHtSny+W42+QHS0hNuKjhlhiUhC+wP0tEs5c9qFIm+uZxwiCYbGh5pGZTazWR9IPcy7CMIsk0be5x4ZjdqmKVmw/JfEInY0jVRAUocsSlQUonWpYTb5+um29gEE8HnjTUeTWbyl1A8RTiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXOKJAdJjIv28XgoQkhdoCB2FayfH2T7O5Ubmk1q8ew=;
 b=KnP1jtp5mC4CE4owCrp0556rvMnf9Elm//xvqPHx/VLeM47HkfKrtkX+51MMyDOhUPEStjd2ORmrZzY6+zBBoWCoLOAFLaJ/ecsn1pIW6ht/uih1+sIa0SaFM8gDWF3tVp5as6DWHQ/qFE1pyvSByEGP1t7LDT/iNuJg2YHQmp1ynRr0S8Jmbi1EyD20ochxdrPMm+nbgzsDVIjK7q410xZJHZ5WIGWBP7meTB7Bp6X5SYXn4J4zUkrCR+I9sgaqYhnD2LxOEhs0n5vtXlUNPG1peT48xVedBSvgHa8OaH3KRjx/1oT8mQjty2rl4wM287lZA+ZnPyU9ACyjPBq0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXOKJAdJjIv28XgoQkhdoCB2FayfH2T7O5Ubmk1q8ew=;
 b=MucwqzRnPUKQ3/qaF88CMsLGtnZBt8Cu7eWqgEpuUQb3MEszOqZujjSp4qabiGgP1v5HPw1jCp+SkHQLoQ8YuNDs7+fdpg1dVw+OGUfbh90Rs/V6griAcwDLLC2sPrfvk9DaWylJNPbmqShl6jDKcBFRF/w3orB6Dnp/L8cKvT8=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TYZP153MB0740.APCP153.PROD.OUTLOOK.COM (2603:1096:400:258::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.16; Tue, 20 Jun 2023 05:19:15 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6521.013; Tue, 20 Jun 2023
 05:19:15 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/5] uio: Add hv_vmbus_client driver
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/5] uio: Add hv_vmbus_client driver
Thread-Index: AQHZnwURGv1AAiMyG0eDJttQESSN76+TLQsg
Date:   Tue, 20 Jun 2023 05:19:14 +0000
Message-ID: <PUZP153MB07490FDBBB8CC3099CFF126BBE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-2-git-send-email-ssengar@linux.microsoft.com>
 <2023061419-probe-velocity-b276@gregkh>
In-Reply-To: <2023061419-probe-velocity-b276@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=92d7d703-fc27-4d25-bee2-869046fa4b77;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-20T05:10:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TYZP153MB0740:EE_
x-ms-office365-filtering-correlation-id: 449cb811-7ff3-480d-2b0b-08db714de3b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QqhKUFp4yZdbQnL6jqz2MXX4YRkNe8uSvrkHOtipS6yDYOPBGurTxfumrLOnwgGHxzm5c7K1ap3HFPiZDYT6zcRUyTryE5atEhfb//yhPFo7P8nKqwfLp1qX2+a7yQ+vXBO7D1YFNb2e+ZfAV5H9hbKLXso/PTKwCvDOyFPMuEtg2qJVzM9KKbO6PJjWUDa/rREqlD1xyyYOwvy7t25DMbsyzFYZrsNd6SmCZlIMftRQyPj7dSKncsfjGN2nYcPvwW83Bgse6WQYNtZ9Eoa1cS82yB0K+hzG3azX/5ckCIhbrPlPf53s8tUiGJuQaLkwmwKmZFrTcNnXf53A5YaFZcmhBvEnL3wioCFbqO1ZAs0XhAzURHpdBjwtIWZxoVUF1+Mc7r3IjCwErc7cxBxcHRRG29r/h1ZFzvIz+mlZOdbFkKGT1wT1kgIVEZ26cK2ByceFuHmcUZG/ul6WVIpUOYfvTENb1V6wiepg5p38IG/fNuGjJxNiwe4Z4UPCtWc05RZbmZMUWRt62cJ7kj3wjnqdkYUIL+QzQBNGbNP+49vLrIHlXWH9lWp6j/YZl/7D9JXsYmpFFDKYZ8wYBcclswlZJ5rQkhZLpFfm9kpbz9jcvDSy9X4SZ3Deo2X/lw5weR/XZu9oM3Y2wTGdebDaQvsaW1jIv36av3fcoxMFT0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(122000001)(55016003)(8990500004)(82960400001)(82950400001)(478600001)(33656002)(71200400001)(7696005)(53546011)(9686003)(6506007)(10290500003)(86362001)(110136005)(54906003)(186003)(38070700005)(83380400001)(8676002)(41300700001)(8936002)(316002)(52536014)(38100700002)(5660300002)(4326008)(76116006)(2906002)(66946007)(66476007)(64756008)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UN8ti5300nP5cxBb5+kPcCFd3kdJWfz9HMl5cI4Vjfr6eBuxVgNGw3rojWQc?=
 =?us-ascii?Q?TeiS8FYQxLMBbdfajnmvHn8rOHcP7tvpS8sfnMZacuyh18DkDAEPKOsZkUky?=
 =?us-ascii?Q?mtYXsxpnTEORCM6D4dffmTjNDBc9j7zZGindE6npnUTcfv7Bod301b/IXL6N?=
 =?us-ascii?Q?KJHou8HYxMnzEnntg2Mo5n00EjBgIE2B0/F+/MQMRml/5eNoA2yXn4yICBJe?=
 =?us-ascii?Q?w306RMvLSFQ5UsX6hOOIIpHeBRtCx4OqBm0YyQkXptsAO/1hhgzLRyozFAn3?=
 =?us-ascii?Q?Uf7IBtFDX2VLg303+WRjnBWXUro/PhBEMEiqeoINHIebzCs8zO+wH7PJERtw?=
 =?us-ascii?Q?fd2O+6j8w4TeQJCJRBV99Hi58YNZF+880X7UE3YSqaqAo8KONOVJ5ON2iC9I?=
 =?us-ascii?Q?3Q2Vq1Ba/o+6jMNYTJriqQCfjHl5SmeZQzgSR9jx/Cc8XniiOA4KP5gNVwOm?=
 =?us-ascii?Q?QQQI/EuZL7gG6Zwi3dY8PFvTUg7AMGbH4Lk5cygHVlxRx36eFEcYqgfa7CZr?=
 =?us-ascii?Q?ITRCzeNPx+9OWtoGLyTZtmWRPtKluBo/g6jk4vmMo+5LkUqNMlpxI/r6abV6?=
 =?us-ascii?Q?+2XqKXnvFiU+xCOR1c2sBBrI7XKJuD9X3m9Ghb6/WXqQ3yDg6y7IpObDwQG5?=
 =?us-ascii?Q?ehFI0vWoWgIlQQNxR1niAfuHf14/kXti8wfgqBNiOX3jROC0N0aboqfKSnV4?=
 =?us-ascii?Q?ZiUBmCk4+REd1lvmyOJALDOgr9X3+z1ukfEnhnBt72av3z7akukKhEgqtO0V?=
 =?us-ascii?Q?PHuha05IT8RW6z2WfXph+tt0ZyZj9jcQvQtL/aBT+KF/1UUwo0uKjnKHCrck?=
 =?us-ascii?Q?pHH2FLak2RIhDC0mgLdxhHIi/e+Ge7uHaQGqR58iGGe9rmJBYfHcAsYAdsPU?=
 =?us-ascii?Q?h6WNiHkxcO99iM480LKNAQySpLYhUV9M3b6mVGwHbhPy/7Lg2k3EqO9dQ891?=
 =?us-ascii?Q?6AMLhyglp5PotUYpkn6F20jvv2TRQP6YSerbJB2q3GMC4oTfqZzR8qyuXOIM?=
 =?us-ascii?Q?VkrkoHInOD7AsTAEhuuJAIM703Ph3kMPvoESL2x0nMvuvXAf9aAMqTCXvB2b?=
 =?us-ascii?Q?WtKe+1tIL5qP94YbE0taMI3SC2aglkEtjTV8ONcJ6d47hDtXWQKaIoaKQqkm?=
 =?us-ascii?Q?iM0eV37kL7DneDvzI3gVuA1Ybivw3z+GpTdBL69L/jWjUkf4QJ7v22g9hH0e?=
 =?us-ascii?Q?xmwPm2oU1Hu2+4/NCN9dFfzrUMchD5dsKU16aVEtJSHTRO/+K+340F7mESQl?=
 =?us-ascii?Q?m/teerN0o793ELcYTT2yTpJkEArVIVgwd82xJuJxZJJ1D/fHj9Osrpi+wocq?=
 =?us-ascii?Q?eLhhzALFw8w5JCtg0MHQPlP8HGCgRW0dOU3qCelbivMuR5HMLCz7qivUufpb?=
 =?us-ascii?Q?/xTlYpdBcWEM6CYIz4lqTiDoaXRE6K9XSFTucTteATnLdSy7nOv20PHfjvA/?=
 =?us-ascii?Q?B2z8Rzlq1fxT4/4ndCjSe1plaEFdOtjRv5SQ8cZmcc+lZhUzT9XH2+ixhfty?=
 =?us-ascii?Q?Rmtua+Qvl9ZsikFNUq/l9E5czlm207RzsbvbZHqKbeAS9wXTw0SWp9MKI6fU?=
 =?us-ascii?Q?HSFDyu3P+I+HphAY2tHgrWPktbFzOwhmqOwcDV3X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 449cb811-7ff3-480d-2b0b-08db714de3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:19:14.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ixqWF64S2h8atIqss45XaZ+uQNAoqIoUTZ0uIso59RlV/zcE7cUZ01fd9+dDR6rgSkyUP/U8Ub6C1gU5LZOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 15, 2023 2:43 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> corbet@lwn.net; linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.or=
g;
> linux-doc@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v2 1/5] uio: Add hv_vmbus_client driver
>=20
> On Wed, Jun 14, 2023 at 11:15:08AM -0700, Saurabh Sengar wrote:
> > --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> > +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> > @@ -153,6 +153,13 @@ Contact:	Stephen Hemminger
> <sthemmin@microsoft.com>
> >  Description:	Binary file created by uio_hv_generic for ring buffer
> >  Users:		Userspace drivers
> >
> > +What:		/sys/bus/vmbus/devices/<UUID>/ring_size
> > +Date:		June. 2023
>=20
> No need for the "."

OK

>=20
> > +KernelVersion:	6.4
>=20
> 6.4 will be released without this, sorry.

Ok will change it to 6.5.

>=20
> > +Contact:	Saurabh Sengar <ssengar@microsoft.com>
> > +Description:	File created by uio_hv_vmbus_client for setting device ri=
ng
> buffer size
> > +Users:		Userspace drivers
> > +
> >  What:           /sys/bus/vmbus/devices/<UUID>/channels/<N>/intr_in_ful=
l
> >  Date:           February 2019
> >  KernelVersion:  5.0
> > diff --git a/Documentation/driver-api/uio-howto.rst
> > b/Documentation/driver-api/uio-howto.rst
> > index 907ffa3b38f5..33b67f876b96 100644
> > --- a/Documentation/driver-api/uio-howto.rst
> > +++ b/Documentation/driver-api/uio-howto.rst
> > @@ -722,6 +722,52 @@ For example::
> >
> >
> > /sys/bus/vmbus/devices/3811fe4d-0fa0-4b62-981a-
> 74fc1084c757/channels/2
> > 1/ring
> >
> > +Generic Hyper-V driver for low speed devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The generic driver is a kernel module named uio_hv_vmbus_client. It
> > +supports slow devices on the Hyper-V VMBus similar to uio_hv_generic
> > +for faster devices. This driver also gives flexibility of customized
> > +ring buffer sizes.
> > +
> > +Making the driver recognize the device
> > +--------------------------------------
> > +
> > +Since the driver does not declare any device GUID's, it will not get
> > +loaded automatically and will not automatically bind to any devices,
> > +you must load it and allocate id to the driver yourself. For example,
> > +to use the fcopy device class GUID::
> > +
> > +        DEV_UUID=3Deb765408-105f-49b6-b4aa-c123b64d17d4
> > +        driverctl -b vmbus set-override $DEV_UUID uio_hv_vmbus_client
>=20
> Why are you adding a dependancy on a 300 line bash script that is not use=
d
> by most distros?
>=20
> Why not just show the "real" commands that you can use here that don't
> require an external tool not controlled by the kernel at all.

Ok will mention the regular  "echo" commands as you suggested.

>=20
> > --- /dev/null
> > +++ b/drivers/uio/uio_hv_vmbus_client.c
> > @@ -0,0 +1,217 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * uio_hv_vmbus_client - UIO driver for low speed VMBus devices
> > + *
> > + * Copyright (c) 2023, Microsoft Corporation.
> > + *
> > + * Authors:
> > + *   Saurabh Sengar <ssengar@microsoft.com>
> > + *
> > + * Since the driver does not declare any device ids, you must
> > +allocate
> > + * id and bind the device to the driver yourself.  For example:
> > + * driverctl -b vmbus set-override <dev uuid> uio_hv_vmbus_client
>=20
> Again, no need to discuss driverctl.

Noted.

>=20
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/uio_driver.h>
> > +#include <linux/hyperv.h>
> > +
> > +#define DRIVER_AUTHOR	"Saurabh Sengar <ssengar@microsoft.com>"
> > +#define DRIVER_DESC	"Generic UIO driver for low speed VMBus
> devices"
>=20
> You only use these defines in one place, so why not just spell them out t=
here,
> no need for 2 extra lines, right?

Sure, will fix

>=20
> > +
> > +#define DEFAULT_HV_RING_SIZE	VMBUS_RING_SIZE(3 *
> HV_HYP_PAGE_SIZE)
> > +static int ring_size =3D DEFAULT_HV_RING_SIZE;
>=20
> You only use that #define in one place, why have it at all?

Ok, will fix

>=20
> And you are defining a "global" variable that can be modified by an indiv=
idual
> sysfs file for ANY device bound to this driver, messing with the other de=
vice's
> ring buffer size, right?  This needs to be per-device, or explain in huge=
 detail
> here why not.

The global variable is expected to be set by userspace per device before op=
ening, the
particular uio device. For a particular Hyper-v device this value be same, =
and once
device is open the ring buffer is allocated and there won't be any impact a=
fterwards
changing it. I can elaborate more of this in sysfs documentation.

>=20
> > +
> > +struct uio_hv_vmbus_dev {
> > +	struct uio_info info;
> > +	struct hv_device *device;
> > +};
> > +
> > +/* Sysfs API to allow mmap of the ring buffers */ static int
> > +uio_hv_vmbus_mmap(struct file *filp, struct kobject *kobj,
> > +			     struct bin_attribute *attr, struct vm_area_struct
> *vma) {
> > +	struct device *dev =3D container_of(kobj, struct device, kobj);
> > +	struct hv_device *hv_dev =3D container_of(dev, struct hv_device,
> device);
> > +	struct vmbus_channel *channel =3D hv_dev->channel;
> > +	void *ring_buffer =3D page_address(channel->ringbuffer_page);
> > +
> > +	return vm_iomap_memory(vma, virt_to_phys(ring_buffer),
> > +			       channel->ringbuffer_pagecount << PAGE_SHIFT); }
> > +
> > +static const struct bin_attribute ring_buffer_bin_attr =3D {
> > +	.attr =3D {
> > +		.name =3D "ringbuffer",
> > +		.mode =3D 0600,
> > +	},
> > +	.mmap =3D uio_hv_vmbus_mmap,
> > +};
> > +
> > +/*
> > + * This is the irqcontrol callback to be registered to uio_info.
> > + * It can be used to disable/enable interrupt from user space processe=
s.
> > + *
> > + * @param info
> > + *  pointer to uio_info.
> > + * @param irq_state
> > + *  state value. 1 to enable interrupt, 0 to disable interrupt.
> > + */
> > +static int uio_hv_vmbus_irqcontrol(struct uio_info *info, s32
> > +irq_state) {
> > +	struct uio_hv_vmbus_dev *pdata =3D info->priv;
> > +	struct hv_device *hv_dev =3D pdata->device;
> > +
> > +	/* Issue a full memory barrier before triggering the notification */
> > +	virt_mb();
> > +
> > +	vmbus_setevent(hv_dev->channel);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Callback from vmbus_event when something is in inbound ring.
> > + */
> > +static void uio_hv_vmbus_channel_cb(void *context) {
> > +	struct uio_hv_vmbus_dev *pdata =3D context;
> > +
> > +	/* Issue a full memory barrier before sending the event to userspace
> */
> > +	virt_mb();
> > +
> > +	uio_event_notify(&pdata->info);
> > +}
> > +
> > +static int uio_hv_vmbus_open(struct uio_info *info, struct inode
> > +*inode) {
> > +	struct uio_hv_vmbus_dev *pdata =3D container_of(info, struct
> uio_hv_vmbus_dev, info);
> > +	struct hv_device *hv_dev =3D pdata->device;
> > +	struct vmbus_channel *channel =3D hv_dev->channel;
> > +	int ret;
> > +
> > +	ret =3D vmbus_open(channel, ring_size, ring_size, NULL, 0,
> > +			 uio_hv_vmbus_channel_cb, pdata);
> > +	if (ret) {
> > +		dev_err(&hv_dev->device, "error %d when opening the
> channel\n", ret);
> > +		return ret;
> > +	}
> > +	channel->inbound.ring_buffer->interrupt_mask =3D 0;
> > +	set_channel_read_mode(channel, HV_CALL_ISR);
> > +
> > +	ret =3D device_create_bin_file(&hv_dev->device,
> &ring_buffer_bin_attr);
> > +	if (ret)
> > +		dev_err(&hv_dev->device, "sysfs create ring bin file failed;
> %d\n",
> > +ret);
> > +
> > +	return ret;
> > +}
> > +
> > +/* VMbus primary channel is closed on last close */ static int
> > +uio_hv_vmbus_release(struct uio_info *info, struct inode *inode) {
> > +	struct uio_hv_vmbus_dev *pdata =3D container_of(info, struct
> uio_hv_vmbus_dev, info);
> > +	struct hv_device *hv_dev =3D pdata->device;
> > +	struct vmbus_channel *channel =3D hv_dev->channel;
> > +
> > +	device_remove_bin_file(&hv_dev->device, &ring_buffer_bin_attr);
> > +	vmbus_close(channel);
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t ring_size_show(struct device *dev, struct device_attrib=
ute
> *attr,
> > +			      char *buf)
> > +{
> > +	return sysfs_emit(buf, "%d\n", ring_size); }
> > +
> > +static ssize_t ring_size_store(struct device *dev, struct device_attri=
bute
> *attr,
> > +			       const char *buf, size_t count) {
> > +	unsigned int val;
> > +
> > +	if (kstrtouint(buf, 0, &val) < 0)
> > +		return -EINVAL;
> > +
> > +	if (val < HV_HYP_PAGE_SIZE)
> > +		return -EINVAL;
> > +
> > +	ring_size =3D val;
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(ring_size);
> > +
> > +static struct attribute *uio_hv_vmbus_client_attrs[] =3D {
> > +	&dev_attr_ring_size.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(uio_hv_vmbus_client);
> > +
> > +static int uio_hv_vmbus_probe(struct hv_device *dev, const struct
> > +hv_vmbus_device_id *dev_id) {
> > +	struct uio_hv_vmbus_dev *pdata;
> > +	int ret;
> > +	char *name =3D NULL;
> > +
> > +	pdata =3D devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return -ENOMEM;
> > +
> > +	name =3D kasprintf(GFP_KERNEL, "%pUl", &dev->dev_instance);
> > +
> > +	/* Fill general uio info */
> > +	pdata->info.name =3D name; /* /sys/class/uio/uioX/name */
> > +	pdata->info.version =3D "1";
> > +	pdata->info.irqcontrol =3D uio_hv_vmbus_irqcontrol;
> > +	pdata->info.open =3D uio_hv_vmbus_open;
> > +	pdata->info.release =3D uio_hv_vmbus_release;
> > +	pdata->info.irq =3D UIO_IRQ_CUSTOM;
> > +	pdata->info.priv =3D pdata;
> > +	pdata->device =3D dev;
> > +
> > +	ret =3D uio_register_device(&dev->device, &pdata->info);
> > +	if (ret) {
> > +		dev_err(&dev->device, "uio_hv_vmbus register failed\n");
> > +		return ret;
> > +	}
> > +
> > +	hv_set_drvdata(dev, pdata);
> > +
> > +	return 0;
> > +}
> > +
> > +static void uio_hv_vmbus_remove(struct hv_device *dev) {
> > +	struct uio_hv_vmbus_dev *pdata =3D hv_get_drvdata(dev);
> > +
> > +	if (pdata)
> > +		uio_unregister_device(&pdata->info);
> > +}
> > +
> > +static struct hv_driver uio_hv_vmbus_drv =3D {
> > +	.driver.dev_groups =3D uio_hv_vmbus_client_groups,
> > +	.name =3D "uio_hv_vmbus_client",
> > +	.id_table =3D NULL, /* only dynamic id's */
>=20
> No need to set this if it's NULL.

Ok.

Thanks for your review.
- Saurabh

>=20
> thanks,
>=20
> greg k-h
