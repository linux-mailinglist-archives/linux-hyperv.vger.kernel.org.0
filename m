Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687143D0456
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 00:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhGTVb6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 17:31:58 -0400
Received: from mail-dm6nam12on2110.outbound.protection.outlook.com ([40.107.243.110]:31835
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231702AbhGTVbo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 17:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzTcHlbKD0dN/Jo/GK3VAriRr2+ce/FnqdTt6D3hqKwMM3NcPnb0DeaUr6JgcND9D1xgoe/p4X0fsKHAabTNkLjrh3vXzupy+ksYfzz0oMFQrs6GBY62hwNkoPjwMzvGcNKtt78MLmUM9NOly36FiR3O654jWDU7noE7SpycBM/seD7v7X2Mio7bABqDjBO2z4iHovvb5vucTpYhIIc35GRss3i94K3lK3RT5yueVC4AE/CJGJ3ImIGPIutU+Vmwage8h6Buo3RonOzJ0Rbyod+ozxhN8MgY3OvG6aHwCvCk+qSS9uZT/cDW/EmsWEnWNfSKFKueUGWwaeibEaMX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeULuOqifQAojlTc/nJ8EgALsbv5pPouQ8n+lUPR7Y4=;
 b=U75GHHt5chqfF9QjPMcX/oQMCl+s1cmiVWZdDWEcUGSgCRwocBfYPMMKSCaZJikMYBlDJEBxzqXPDV6TV51xxAKuKCFp72hvRlu5Lm1zZ5yYjJRlmSYAWHKu+Qw4yVna1BwCVbpWD129o8pSKOnRAmEPJGfZZ5uJgtD3Ky5eJhueWG/z69bQCFoiD9MzeF5LTqzqqRabJyRfVYgE9Ijb4wW+3VvwVssYfLE6YkjLPdZ3hnamJ1nbV69PrhJu7FT4sl1uATqq3S0JKLbaDX83ilrRlYBXe+kFlqsNc3QWWJ42gzw/ubqKhAdhB/jFXb95z9d03n1TAOLhiOCWBW0JjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeULuOqifQAojlTc/nJ8EgALsbv5pPouQ8n+lUPR7Y4=;
 b=eyT4vgqcdgOOY3aWmn7oc1ZA/iofzjtdkSztNwYPfSTQ6LfBZDtTeudHR/LJwkdMjc5b334mn8pgTVGG93n8bW8nMXUjpNp3hueY6LrUsg0pL/Usc0GehtliToBVc36/NpEkZ+ef83/S08a0iMyooKD1Dd7GVa5h+6dw02wg9oI=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1669.namprd21.prod.outlook.com (2603:10b6:a02:be::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.6; Tue, 20 Jul
 2021 22:12:19 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07%8]) with mapi id 15.20.4373.006; Tue, 20 Jul 2021
 22:12:19 +0000
From:   Long Li <longli@microsoft.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXfRfGpWx8JX5XBkGm4J8f9X8COatLtWUAgAC0zpA=
Date:   Tue, 20 Jul 2021 22:12:18 +0000
Message-ID: <BY5PR21MB15069D0519AD92773355FCF6CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
 <90ed52d3-5095-9789-53f0-477ba70edc3b@kernel.org>
In-Reply-To: <90ed52d3-5095-9789-53f0-477ba70edc3b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37bdcd41-ad74-4147-85e4-c6b5c5c95e6f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-20T21:57:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f558d41d-a8d7-4cf8-d3c5-08d94bcb70bf
x-ms-traffictypediagnostic: BYAPR21MB1669:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1669F1EF9349B93B37BAA767CEE29@BYAPR21MB1669.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qf0RxXHasB38zGKCO0t7bdYHtmQ5NmR+JouYhHH8NeDUBB7TMenpiOFAlRsG/6LsRLgCywWMrIXCYmXfcKbFIaZMrQ0qCnLC5x2+KoY5fUV/okoZG1so6huWdT+BYcA1nhVVl+L12xRv7QTGNdnAtr9/ARLgM5zRrWZFabBEOjG9mJam0VRnbI/b2ykh2IVLzugDQBmbhr0UMc+h6Ft2F2Gqjr1AAJgjpbUtPRNwFc7/dRrkqc39AGySeU/MjBO0RNyfKw5tDBjBUSpT9s8tev0UplEf2kLV7KjyKCo19VaX87pbfFdH58JDQ3dr9UWBP26+AE+sHUL8MxSaASlVmoyKCzp5lBd6VvFRq9SkIPmwuMKrZWMKdTFXGw7bLEneWbNHER0DvCKAkXj3aihVpbf2qFiaiHodxs3kky6uMFPEmMP4msSVuSYdgqNU9wpiXTCGVbTv8bXQCvwKJOv034xbSEmV0rbG6IReRS3L30I9IJCPU/JAbL6grKhhD+BE4qbVfW5YH+Ue8AfsamXbb2Ca6AfV6WOcZsbGZ2h5y/F5+hSD7wcvCW7CpJ6n8m8jofY4NAMBniUeLmhEfM+NudPpF4cthZxO9nKJ+v+VJPoWEhEyV2Sms+sPDpEZ+aYjdbhechBrdyQpqhWcNH9wwSnTCIPKIax/ynCfEwCRzuNFvUdsiSqyQeI44CB92a5pc9QuaZ6tuyhyR8vmrH/eHoiM+6GJjMLSHzu2Jfx5Spuflsw7LrTGAKP2bM0wdh5eQDP9K5RZO7VdQ5ngQgC4o1wXODnf2o28JuOqYdrZF/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(110136005)(9686003)(55016002)(4326008)(66946007)(66446008)(316002)(66476007)(66556008)(64756008)(52536014)(186003)(54906003)(86362001)(83380400001)(26005)(76116006)(10290500003)(6506007)(2906002)(5660300002)(71200400001)(33656002)(508600001)(8990500004)(82950400001)(966005)(82960400001)(8676002)(7416002)(8936002)(38100700002)(122000001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXLx2DLTeKvf6DSLecUZxtXXMFnjo1qpkYYGhJQ87R3NIEGxPztdRhugsDmr?=
 =?us-ascii?Q?2k/DD6aw3OCm8YiuF4ua1ti9sG02LkPgdBMYVA3pqUqjWLukgDQcaFB6ruyn?=
 =?us-ascii?Q?eB75ZsUcDPh6o0L2GzSsREn6F7scC+LOWHWp4gi53nJ91Mn2wSqF9FtXM0wV?=
 =?us-ascii?Q?vHKmierJk+KgHVdnBvq6JQkQuzH+nkx+c1lfimbif/zDIVXDnvPlr/dI/WZb?=
 =?us-ascii?Q?5nHNZHlB6hUc9kGq/2YBSjvSAeXUkZhyn3O8wusgIQyCZpbwX8xqFIh4bWcp?=
 =?us-ascii?Q?Ijr7dqDX+jyNo0lfh8TwW31koJ9Czi9oKIQxeFL7JzJqlRbhesMr1dM00tm4?=
 =?us-ascii?Q?ATRa9U6pxbFnRb2S3mQjebpbMNiiRs2KyZ4P59RtvItW/MLH2713MiGcB2R9?=
 =?us-ascii?Q?FySSLN4CULfWzvYV3373BaaHXnbdQYWQCOtYqL1wY1I24HQQ7nQzA1aE+QE+?=
 =?us-ascii?Q?J3I+rRh50255lK1CJk1YBp8Lvmbxiur500Z7wmr39bFV7LtMY4P/HioV2sxI?=
 =?us-ascii?Q?mOp55aAv4nD00ihhY5Kp6K3QqpFFFmBe7cpw4pnS339fQCI7u7czvZeCkGc2?=
 =?us-ascii?Q?B8LwvbfjEcuLg5p7/fWrOKVMw4boXgdXjUXYsWkuzhk7cMopNO1WCxgKVOE8?=
 =?us-ascii?Q?0qToDyq3iAGtTO4mXSCGLDORsA/vHYJIYD9LanceMAgDf13Pq+3VcJO/gF/a?=
 =?us-ascii?Q?9cHhMm3hSvIWQeM6wwQigLmDSedK3WtoKzvRicZqTiJOKsiGbqA8xqj3oe0d?=
 =?us-ascii?Q?hQcZ+45g96nWGTfBTSCCFPP2DbRpki5VHT6wzaZmNI+gX5ecMcOjXI6CUdg7?=
 =?us-ascii?Q?KnEirajfAtjbu0nCiMp12/ezz1G8e5oBA6j0p6svFtn/RYFIfL8fPT+EXBRH?=
 =?us-ascii?Q?uHZKC+BH3tZ9qwfr1WB/+Z1JAVX2QGXhdftgAkK55ty89iDg9ex1KupcGlsR?=
 =?us-ascii?Q?YsTvymJB8SOK8RWvfovQ8UyRCfpu4n1cvF1HqYZrJl8JQTWRvzrf9OvojNfy?=
 =?us-ascii?Q?tTrpveMBfCL4zOfWd4QQhToj1zHgwD9VsB3YO235sug2D/W/esTz8d9YQaYR?=
 =?us-ascii?Q?gqJ0NKFcP7EzwnX89kVRZq2FNYYqotMvu1EaPtRKi1HC/z+Ji6+Tkiboc6C5?=
 =?us-ascii?Q?ERpk48h+2LnRTojARAjsXwhR0seZdnrpeXjKjOaUf4gInQVGtPrUkEQT9NQ4?=
 =?us-ascii?Q?mI6DYvL0qbnNIZwpEFYBEPdtr5x8lSV/hJmX82OSR/FwodJ1Xtv02QqNmp7/?=
 =?us-ascii?Q?VAbgoE33zAigzKUVD0RpAVdk0gbKBnEz9BMYdtIj8eGZX9eHUOQzKcmk3ix7?=
 =?us-ascii?Q?rO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f558d41d-a8d7-4cf8-d3c5-08d94bcb70bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 22:12:18.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRWWFlflc6KfX0VKEwF8mQnB3dNCOzFzvsfDyrSxAE1jy2XgVOCOgfjjgpkp6Um0P5BXOjwMZ7p4iokZhQSSIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1669
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
>=20
> On 20. 07. 21, 5:31, longli@linuxonhyperv.com wrote:
> > --- /dev/null
> > +++ b/include/uapi/misc/hv_azure_blob.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +/* Copyright (c) 2021 Microsoft Corporation. */
> > +
> > +#ifndef _AZ_BLOB_H
> > +#define _AZ_BLOB_H
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/uuid.h>
>=20
> Quoting from
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flinux-
> doc%2FMWHPR21MB159375586D810EC5DCB66AF0D7039%40MWHPR21MB1
> 593.namprd21.prod.outlook.com%2F&amp;data=3D04%7C01%7Clongli%40micr
> osoft.com%7C7fdf2d6ed15d4d4122a308d94b6eeed0%7C72f988bf86f141af91
> ab2d7cd011db47%7C1%7C0%7C637623762292949381%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000&amp;sdata=3Dkv0ZkU1QL6TxlJJZEQEsT7aqLFL9lmP2SStz8k
> U5sIs%3D&amp;reserved=3D0:
> =3D=3D=3D=3D=3D
> Seems like a #include of asm/ioctl.h (or something similar) is needed so =
that
> _IOWR is defined.  Also, a #include is needed for __u32, __aligned_u64,
> guid_t, etc.
> =3D=3D=3D=3D=3D

The user-space code includes "sys/ioctl.h" for calling into ioctl(). "sys/i=
octl.h"
includes <linux/ioctl.h>, so it has no problem finding _IOWR.

guid_t is defined in <uapi/linux/uuid.h>, included from <linux/uuid.h> (in =
this file)
__u32 and __aligned_u64 are defined in <uapi/linux/types.>, which is includ=
ed from <linux/kernel.h> (in this file)




>=20
> Why was no include added?
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
> >
>=20
> thanks,
> --
> js
> suse labs
