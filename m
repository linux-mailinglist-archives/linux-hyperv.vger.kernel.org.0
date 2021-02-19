Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E901A31FD20
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Feb 2021 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBSQc4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Feb 2021 11:32:56 -0500
Received: from mail-mw2nam10on2090.outbound.protection.outlook.com ([40.107.94.90]:24064
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229546AbhBSQcz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Feb 2021 11:32:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeZc9Ox0qHgvzt4tUg9iIJchdqKt2k4ksaWOn/68fAfEpv4WX/Cg3cnmU8fFD+yEgFej/MAh8K1tc1H9l+RbyFgSMr2Op6NedBGoMlOiXT+nE0s26Q8lvClfWB8JHoiMmfhWehwdC9FHKhJer3mrnpsgMviGXduokuG2BTSZyD1Rrj/ePkaoclbjxSe/RWQl2fTfp8b+zkGGYj9Vd0chbJfKG4laueTpf+E0Uuj797mMlSjSSsb3rfHFToajn+zIxoCuAO0UbYZ5uuQSQxayIhalVDWyZcQlNI4oxE3b5B8HIIWwS/BE6NA4com1dgUMXaSsrVfw34bERmaj9YIYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOdDvB0uhj2KN6WDgqt4TTSaDZeiEDPmNhgb+G+qeJQ=;
 b=OnyCGOS+SBobhwlne8DPb2k5o80bqlhMyp1wCKxO4bn6A+/KjO8A64ecvqbal5eLDb17Msn0yWu6Se4/oMwuvHynAMWPUsAjORkTii5gow1Czu/KAOGVEHlGaMJ3rexrWxMusGHvy46/DiEwNTAW4ifl/EjnHESjssN5ePr0l79yNxOxje78KFBx5K0hBkjH/VIEEenJy4vtY2sTzGTAsV5RTXC7avy6IyaKu107aewFYoNjD+9Sl/ObvCjAnc3mx/PFh5JC1OminZqpmy4JFzQhXguORvieyGCUtWPqQYDQ0m4RRrQnYDQDvlqQ3/P/c5pAkcx2o9sOrPzSofQBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOdDvB0uhj2KN6WDgqt4TTSaDZeiEDPmNhgb+G+qeJQ=;
 b=bLXCRGX5BauKAs+NLb6Z+2yaA9x0K0KIPQHrLeL4OLPjdp3FBHCvk9TuBPJ1noKBsc+4nA+LrWmGHirshm0pKiJOX59UIAlPEIj/CR1PcsFS0l+tkyAeVSbHUycngbj/lMozsg7hhv2cyXaZcrPk3XIXaoM/c5nyNKcE8toKvKs=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0479.namprd21.prod.outlook.com (2603:10b6:300:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.5; Fri, 19 Feb
 2021 16:32:05 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3890.013; Fri, 19 Feb 2021
 16:32:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vasanth <vasanth3g@gmail.com>, KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: hv: channel: fixed a tab having spaces before
        hv: connection: fixed required space for "=" sign before.
Thread-Topic: [PATCH] drivers: hv: channel: fixed a tab having spaces before
        hv: connection: fixed required space for "=" sign before.
Thread-Index: AQHXBfaGrIwAQZ7Zwk22Xl9vkHF1EapfqPvw
Date:   Fri, 19 Feb 2021 16:32:05 +0000
Message-ID: <MWHPR21MB1593FF42E1BD760509942F9ED7849@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210218111522.398170-1-vasanth3g@gmail.com>
In-Reply-To: <20210218111522.398170-1-vasanth3g@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-19T16:32:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=519a3c9d-3438-47fb-ab4c-eaaeb4448317;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7af5770a-877c-46f9-5074-08d8d4f3e523
x-ms-traffictypediagnostic: MWHPR21MB0479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB04796972BCC55AF60E78B30BD7849@MWHPR21MB0479.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H28KgsCsFmDdMGlYA9sUhrWVYVL7AkEiR1YUtoN/x8e4FwJ5DhVEp4zSzrVJ5z/t8K1lCgpJr5Rvfrkd6tC2opZP2ELsCIf7AuYa0qWEzsUi+a93LIMMSgaFHXqP4z+nHAaziuC+2wHkZqeKvb4Ol49/bVCQJc62ckXrtauOOh+Bz2Fxjflda8IxooQQdYOygik3+SslVtO2mAGNIlezR4/3iedUxuxIGH8DlWZNnBV8BecJX5+cBuKs9zoUMAHGzUix9DzoivG6OSe7x6a0Cr1K1BB0yxJy2LED/OVjqHbaCjUGIsbipIXX82Y6kJC3RUcJguzwiC3lWGzruqwr8x4b7/48lhxCxnoDJ3jQn4wZASsAVPYvBe3hEzKDBw62q3ludwph9A09V8Z4Z9sH6KZIHauCGugzb/hZ5Gp1voQ/vV1TwhqU1C1DJFLSdw5cqW4sNNeBIzBHmp5+bVZMUrowkIq7UGV68Rca0iXg3Nv5tTd998bFQdVFLfnS/e9amsC04LJJ9xpx9lOlxmqs8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(82950400001)(66946007)(8990500004)(66556008)(6636002)(64756008)(7696005)(71200400001)(52536014)(6506007)(66476007)(9686003)(76116006)(26005)(66446008)(4326008)(316002)(55016002)(5660300002)(86362001)(82960400001)(8936002)(10290500003)(8676002)(33656002)(54906003)(478600001)(83380400001)(2906002)(110136005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yPNFu5Om9ANbGM5HZEf0YOYScS0PCjP8kO/sPpR4DIGTg7W8pem08NVAQv7R?=
 =?us-ascii?Q?B1ZajiaCRGZ0UYLYwEPcPgHoqN8yr7v5qc33o1DNWP6bIKN6i6tKCCHVEV3y?=
 =?us-ascii?Q?rIP7S9XJMP7xFtBKTwIXEDIC3RNu3KKIUHMi1QM7KtBa9yU7sEzVhiuWal9w?=
 =?us-ascii?Q?3WqBH8eNFh7dYpGyfHAZHXuyIwP9K6MlK+c5YjAF8t7zPQmSMqznqx4hTPEQ?=
 =?us-ascii?Q?mE6cQBolgfXgz6geMKco8meQJ4e5HX47p2cifCgPOBukiTZuryCcQhpamTMa?=
 =?us-ascii?Q?cnNyUi4L8sumGcOsrsHAwbkpHzLAfR16dk/rm1x1MpkiCQxkfTrDpYGPYN+s?=
 =?us-ascii?Q?wz7qNlSRQII58U/gQqL7zF89bGiuwagbGG8f5x+cMq/w6iC4TvvLJIl61mww?=
 =?us-ascii?Q?YRboZ8oF9ngULRuTiMd9M9iyTBKKIFMxgY/KLdsxvuSs609iFTHSNlqjDlZ9?=
 =?us-ascii?Q?DAj7FVT+AAgakoNHWFjDhawAjaszdkNHSCQfe98MHhWRZpyiTsJClLflUF0/?=
 =?us-ascii?Q?/POLqMz44qeBTvKiyTl+8MSznHhAep2PR1uXtS2E7LHSn24+XjQN9WIZtPRf?=
 =?us-ascii?Q?lOcQ5sZEIKIfEclXLo6i79jUMQpuZKv6Qiouron5ijsj9zvNVg98TPMexiUo?=
 =?us-ascii?Q?hFQxFYVnq+lOiBuT6NBkv0jTxzZckSpDeWJeiaJ5wviGce1Sy7pHGmpTfYE1?=
 =?us-ascii?Q?ew8YGmdmVxEN+1DqVWmefbuAAD8HUkP6jE8e7JpDeEplR0aSzNqyH8q+xGyP?=
 =?us-ascii?Q?Rwn0hXoMLPEGlxlu9oqyUEcKLSUFRMP1eNbBHqxbABFIj1xBO+FuOXgpSkBu?=
 =?us-ascii?Q?XjdgXoZw8fR8CUiol2yqtlKJ0HGT3VU1iGpJK8XQK9BEzH5mDO/T1FhDKtQo?=
 =?us-ascii?Q?OiU4skHNaGh2QcVkpcZ/4hZ5O+jDTXL4wWnwp8y8FwcFJPcT7TUPtTYX3rgL?=
 =?us-ascii?Q?vyKFk/mRjU2DmkpjNWZyvjE9iBpSvVpEWYpdZdN15sLrSHDROpTI1u7ltNqY?=
 =?us-ascii?Q?zprduKod39KiH1D6JtotLX6CrjfLSHRmS2LRV5ufZ8z98AYCmsebIoRch9L/?=
 =?us-ascii?Q?UKDCV28eU2uVEsk2HR8LxuUujHVL/ifXVPtUvQ/tIN+/DzxPj78zQZSopgAO?=
 =?us-ascii?Q?xjuLoFhftmU8Lfp6hZARHh8i9vDnTSpFRxEZ5Qccp8R3pmFeseCiz7b2wHZZ?=
 =?us-ascii?Q?vcFdeSh7wW521ljEgtO4UjZbH8oIByyvOJTqIUEPevY6AoEpdsyoB6gTTQ2T?=
 =?us-ascii?Q?0d2jmWrGWDEXSxirCLJV36aUA00YZdQeHCgdSQjLWQg2/6MEJy1dVdHPi04O?=
 =?us-ascii?Q?BzE98lFmB+pcgII4H9zxfaJw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af5770a-877c-46f9-5074-08d8d4f3e523
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 16:32:05.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPkUEQN11JMkFYrxSE6prA8E23HLlbTSrWxDFBZzIrLNEUETulV0zHdUw3CiBxQ941jNwAgnWkyOcrEQLBNmb6E2lmkH9h6UU0uxY0ipF10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0479
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vasanth <vasanth3g@gmail.com> Sent: Thursday, February 18, 2021 3:15 =
AM
>=20
> Fixed checkpatch warning: Tab space before having normal space.
>=20
> Fixed checkpatch error: Required space for "=3D" sign before.
>=20

I think this commit message is appropriate.  But I would still suggest
simplifying the "Subject" line.  The Subject line should ideally be no
more than about 70 characters, and just needs to summarize.  So
go with something like:

[PATCH] drivers: hv: Fix whitespace errors

Or:

[PATCH] drivers: hv: Fix whitespace errors from checkpatch

The "drivers: hv:" portion just identifies the general area of the
kernel that is affected by the patch, and doesn't need to identify
every file that is touched.  And when someone is scanning through a
list of commits and looking at the commit titles, the words "Fix
whitespace errors" will be a perfect summary.  The person will know
that the commit probably didn't fix whatever bug they are chasing
down. :-)

One other thing:  When sending an updated version of a patch,
it is customary to add a version number, even if the change is just
to the Subject or the commit message.  So your Subject could
have been:

[PATCH v2] drivers: hv: Fix whitespace errors

When you send your next version, calling it "v3" would be
OK.

> Signed-off-by: Vasanth <vasanth3g@gmail.com>
> ---

The text below the "---" does *not* get included in the
official commit message when a patch is accepted.  Submitters
usually use this area for a bit of a revision history when a patch
is revised and a new version produced.  So your revision history
might look like this:

Changes in v2:
*  Added commit message
*  Revised Subject

For a small patch like yours, such a revision history isn't
super important, but it is still a good practice.  The revision
history is much more important for a large patch.  Somebody
might spend 30 minutes carefully reviewing v3 of a large patch,
and provide comments.  When the creator sends v4 of the patch,
the reviewer would really like to know what changed, so he
doesn't necessarily have to review the entire patch again
from scratch.

I would suggest looking through other patches submitted to
the Linux Kernel Mailing List.  You'll see examples of adding
"v2", "v3", etc. as well as examples of the revision history.

Michael

>  drivers/hv/channel.c    | 2 +-
>  drivers/hv/connection.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 6fb0c76bfbf8..587234065e37 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -385,7 +385,7 @@ static int create_gpadl_header(enum hv_gpadl_type typ=
e, void
> *kbuffer,
>   * @kbuffer: from kmalloc or vmalloc
>   * @size: page-size multiple
>   * @send_offset: the offset (in bytes) where the send ring buffer starts=
,
> - * 		 should be 0 for BUFFER type gpadl
> + *              should be 0 for BUFFER type gpadl
>   * @gpadl_handle: some funky thing
>   */
>  static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 11170d9a2e1a..3760cbb6ffaf 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -28,7 +28,7 @@ struct vmbus_connection vmbus_connection =3D {
>  	.conn_state		=3D DISCONNECTED,
>  	.next_gpadl_handle	=3D ATOMIC_INIT(0xE1E10),
>=20
> -	.ready_for_suspend_event=3D COMPLETION_INITIALIZER(
> +	.ready_for_suspend_event =3D COMPLETION_INITIALIZER(
>  				  vmbus_connection.ready_for_suspend_event),
>  	.ready_for_resume_event	=3D COMPLETION_INITIALIZER(
>  				  vmbus_connection.ready_for_resume_event),
> --
> 2.25.1

