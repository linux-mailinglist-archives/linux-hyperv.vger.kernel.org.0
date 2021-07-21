Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546FD3D134C
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhGUP1T (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 11:27:19 -0400
Received: from mail-dm6nam10on2114.outbound.protection.outlook.com ([40.107.93.114]:63008
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229484AbhGUP1S (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 11:27:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS1WSwmnTFwByb07iPN7/Mt95J07NauOUFc4CV0bLI6TLK0WGpPsCa3Qyqc2LyX/9cz1WKKeZs7g4dU2nwDDlILlgAepvmoiQhjEHa9LAUnls8IO5N2Y9gKVX7/t4knGY/+DWCGImSzJGdDvLUbGIjLynAwvPJh87lItWo8jn4+TqdWQKotlPCiLl9I6E0FU8Zuda186BuJ8Abhme5j8o/IL5h8i/nRcZoMIJQUkbhgdvWPr0huq+xPlm++t77De9lMgBYh50ghP0YKH7eRYUwl/g8VFyCz4ueSw0D6KUWMelK7wP+n2aWtPzgEF3IiEtFAmMprLhD71RccXj/P+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI79aeubYn0CcVbbAzNmQ3IdLegidWSASn1beQbkzsE=;
 b=U+0WfvPPjpGwHfKISspoHL8rOFW/SbVmdd+KxwnxXmlvM+gri2RE9lmFtRvI/NQUjTqpae++ap9BJ8/FBqSjKrhJsTWdz/eV//iNCVuJIpXxDnBIaTuvXbcL3SfKtZOXWLRUpKmvrsOsJTMFneP0/dJs/DAO/3N1oeQpq+fRn2S2M/HtBPSne7b5sQwJIp/iWgQVWjCpRURXq7NuH3jCqkveCilWeS3crBu4vbARCpB5z6BXOqF7DjovSunOvVOUJ3uOkTUWuaKJabN3oIz5KmZ8O/JxB0JwOG3UuTB/Ex8EdygUI0KJSD3aVtxbrjrTKshaxz27dNDjGTKpjL8tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI79aeubYn0CcVbbAzNmQ3IdLegidWSASn1beQbkzsE=;
 b=Kdb0Jw6EbxgZiWBsuzURUEf9UaFiBLfDm9BwRlAR2n8h5BTl20QOH0Evt00A9IbiWBgJiG8LkMHJQ7STpRWb+AY+ketmypqG9xOQumFX+iDLoB+esOcnRwyU60COvQiGDG8koyvX4DpDQnU9Z5Na1dwa6rUYSjXJxF7UagqMfJg=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1295.namprd21.prod.outlook.com (2603:10b6:a03:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Wed, 21 Jul
 2021 16:07:52 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07%8]) with mapi id 15.20.4373.007; Wed, 21 Jul 2021
 16:07:52 +0000
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
Thread-Index: AQHXfRfGpWx8JX5XBkGm4J8f9X8COatLtWUAgAC0zpCAAHVUAIAAu1Pw
Date:   Wed, 21 Jul 2021 16:07:52 +0000
Message-ID: <BY5PR21MB1506F9C0C510433A4FD0EFEECEE39@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
 <90ed52d3-5095-9789-53f0-477ba70edc3b@kernel.org>
 <BY5PR21MB15069D0519AD92773355FCF6CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <5c5dd1e5-2639-b293-b2e0-d7cfd5ca3c0c@kernel.org>
In-Reply-To: <5c5dd1e5-2639-b293-b2e0-d7cfd5ca3c0c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d0b5ca0-1a5d-4baa-adc2-8d2c01e504aa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-21T16:07:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb537771-3def-4e1e-8bc8-08d94c61b1bf
x-ms-traffictypediagnostic: SJ0PR21MB1295:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB1295EDC864E339639CFF84B9CEE39@SJ0PR21MB1295.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S91pFEQxvHmHXEUh8LLmpcZjeTwrW1tJSf4qWzD3PQ1OA8QZkWFvHps61no+zLfhSlgWsLffCPBP7OVSAwECNPrlNmLM78Ad1O9rAJB4vGRnVmA5M3KzJk3/77IPs8i9lP8W48vdwzMv1FwjWoPex18d0cMlyfzwowtjllKJ3BgBy2XUhvwSk+wBpSXz0dB5wWhqDRiVIneqpDhIvaonobaTrMTtYLoUrQvhcyWppVP/PsjmYxm8uUQZoyx+4bLTIICno/1qCZ3CsR2OTuhNarNQvwj8FJ2wstkGp9fwpzRpWr3eIWxMOtWDm8i2m3DG01UxvBY+tC4mYc6EY3371cHHSrZczzvlrgqHcZ6PLNQGNuGtikniOh5yVdic98K2SEjf8wWfXcvJIGFgBMOloD8BUzYRyNQb0TPiifUJL3zISnLIth1IDh9rLUOPhRog0OsZTSJr3Ctu5meaSPu1Yp6N4oVhdBj93hZZOtOlhi+X6H/B61vV9W55L0lih/neG5OoMuJ/0jbS1l9bWGFa0iYZqKgoD0i10zpVy2NMKeCWiQaY4LX8VUeKX5mwYUkjglfP2+YwBntGVbhqCCQWtXo/WV5vxciqj8bq72bJfrLRTBs/V4axWQ/J6ozZX/WwRR9dBfn1rMS5wSDIkWS5c1bgnAFUL+BunGLyE4vAI6kDglojjWBKBu+R6xbpOdEfYgKmO5KX5bId+fHguneNFqCI2sB8KNu6i5dyOoHaxaK9p8A2JnNYsw8cWtFisQkPduT/fr2jtMIVhqHurdwLz6OfzbH7FIEleAAemhYQktM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(5660300002)(86362001)(10290500003)(7416002)(508600001)(110136005)(6506007)(7696005)(4326008)(8676002)(55016002)(66946007)(66476007)(8990500004)(54906003)(966005)(66556008)(26005)(316002)(186003)(66446008)(64756008)(82960400001)(33656002)(8936002)(82950400001)(71200400001)(52536014)(2906002)(122000001)(38100700002)(9686003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sdE8t5+IF/3yxSZWwZ/9eWTunJUg7RBa+CwHc8rtkZLVhCD8NPx4CShQj70N?=
 =?us-ascii?Q?In5hJVELWWnzFrXItoVmA/cAEb+3WgFvk4eIk0JGy8zzUTbn3s2cM3Jzxz8b?=
 =?us-ascii?Q?by3dJFYoZ7yTL0+x53RgRiGRDiu7hcKy0vHE1dAZjg9SsVMtbkaTXI6ufA25?=
 =?us-ascii?Q?ah6qel9RGhy51QsDfvWlfIidif4MD8ivQ5GsHZleXcdMEZuvRKMN0TPHVVkW?=
 =?us-ascii?Q?dN2z8nItMCZjNIDTfwDS9dmXnkcfaJ+zWkfEEP2wBCuu2xWip+/JeD6o5YqF?=
 =?us-ascii?Q?moUy2WvYoIo0oELBpEzZ6rT2zP6AzMyFNcVuVkF2pLHIFHDUqh7yL4bD9sKX?=
 =?us-ascii?Q?t+iejwTJ/qksmRwHvS9EqBv0S1ZninNB9zhl/ZyfkvNh3GxN5uk9kzAzCekf?=
 =?us-ascii?Q?inTrr/ApPCmbTm6kukx5sNlc64N8i1qVmLgS3GGuEr21GubGyney12iPVKUr?=
 =?us-ascii?Q?3Xo37ulCvJo7BjKK07uNApkHOv8g0UIOEcwPfog6dY2vG1sGG/t8OO8DhEGZ?=
 =?us-ascii?Q?FGrnqyVaDYCVjJe9t+kxnhMFQDyFPYNOIbEZP9yYi/2yA9RV98SXotnQEPu7?=
 =?us-ascii?Q?RsYok/s+cJ4TvIUWHkg7crnozus1Un/FH9F6QhVLU8xDWXqj8XkmoxmaIg9q?=
 =?us-ascii?Q?9m7JG+IxX+gX/B49gHX9rkq52MjD7WxcNFUZmahJoOGzSBQvZIy8Pu6szRKB?=
 =?us-ascii?Q?BB9SZ0WrYCIVnI3NzRcBUCeVWFU6o3vOukXhvTwUqoUSiSY3JvchiNt8eTjQ?=
 =?us-ascii?Q?E1qkOhQJ3yEQ9CYS0rxpxtF1X7moLZ4HBTBJQ9exxLhoRl2yXQPCpyJ+3pyL?=
 =?us-ascii?Q?6jxxnxZndBYV7qt7+SdYvVHPXgI95ieRPof3RE3G3QXcu2asBorB2uHkMZte?=
 =?us-ascii?Q?U12MKPePwIx/E/uUbjD4Hv/jMx+XVmikCtZtlj5DhWyTyWLeVSYY9N3T/UH7?=
 =?us-ascii?Q?dKjXTqRRtxeLwGWtS8JEj8OjnLWnvhb8G25TsljmvB9pFal7Hu2mDXA0NN7d?=
 =?us-ascii?Q?22S7PaSb3tuTouqt04fUDZTtSeXr7XBG03u3BlMMcDep4Lc93eL1Ey248EPo?=
 =?us-ascii?Q?YT6WpsYWP/yUPdhE/U54rqK+pvjqDxaFPzrGCN0eJeubWsBUrbVKR7SqWYTI?=
 =?us-ascii?Q?ftPjkv+TDZu7uVgKCLfiwMEthfKdWERQUTs++4W/eqX7Fnn2TJst8T/UpFQ1?=
 =?us-ascii?Q?TEAre6fO515GWiLnY+ZzJ7WKrLztWlbIReMIGF7PsDrtezXlFMdTI9wI4vr1?=
 =?us-ascii?Q?EMs2BhpEJ9AucFrMvLq21hEKgkdpCmHSI7PzbMUXBXz/+bO0Zbgup2shVQld?=
 =?us-ascii?Q?tS2Hj+N9NKLiGkXCUTLfFIb4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb537771-3def-4e1e-8bc8-08d94c61b1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 16:07:52.4706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNhxhOB2XeHBF6I8sA4QkjpVu5Xy9ntXN8FnZT8F+49VKqR6vbbPLvjRMzTsssSdlZJAPz66fF4JTKA3pGEF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1295
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
>=20
> On 21. 07. 21, 0:12, Long Li wrote:
> >> Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
> >>
> >> On 20. 07. 21, 5:31, longli@linuxonhyperv.com wrote:
> >>> --- /dev/null
> >>> +++ b/include/uapi/misc/hv_azure_blob.h
> >>> @@ -0,0 +1,34 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> >>> +/* Copyright (c) 2021 Microsoft Corporation. */
> >>> +
> >>> +#ifndef _AZ_BLOB_H
> >>> +#define _AZ_BLOB_H
> >>> +
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/uuid.h>
> >>
> >> Quoting from
> >>
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> >> kernel.org%2Flinux-
> >>
> doc%2FMWHPR21MB159375586D810EC5DCB66AF0D7039%40MWHPR21M
> B1
> >>
> 593.namprd21.prod.outlook.com%2F&amp;data=3D04%7C01%7Clongli%40micr
> >>
> osoft.com%7C7fdf2d6ed15d4d4122a308d94b6eeed0%7C72f988bf86f141af
> 91
> >>
> ab2d7cd011db47%7C1%7C0%7C637623762292949381%7CUnknown%7CTW
> Fp
> >>
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> >>
> I6Mn0%3D%7C3000&amp;sdata=3Dkv0ZkU1QL6TxlJJZEQEsT7aqLFL9lmP2SStz8k
> >> U5sIs%3D&amp;reserved=3D0:
> >> =3D=3D=3D=3D=3D
> >> Seems like a #include of asm/ioctl.h (or something similar) is needed
> >> so that _IOWR is defined.  Also, a #include is needed for __u32,
> >> __aligned_u64, guid_t, etc.
> >> =3D=3D=3D=3D=3D
> >
> > The user-space code includes "sys/ioctl.h" for calling into ioctl(). "s=
ys/ioctl.h"
> > includes <linux/ioctl.h>, so it has no problem finding _IOWR.
> >
> > guid_t is defined in <uapi/linux/uuid.h>, included from <linux/uuid.h>
> > (in this file)
> > __u32 and __aligned_u64 are defined in <uapi/linux/types.>, which is
> > included from <linux/kernel.h> (in this file)
>=20
> No, please don't rely on implicit include chains. Nor that userspace solv=
es the
> includes for you.

Will fix this.

>=20
> thanks,
> --
> js
> suse labs
