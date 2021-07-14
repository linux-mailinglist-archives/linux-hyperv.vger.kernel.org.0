Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5C3C92DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhGNVRP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 17:17:15 -0400
Received: from mail-sn1anam02on2115.outbound.protection.outlook.com ([40.107.96.115]:64010
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234164AbhGNVRP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 17:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VERU7VdH4gfI+G7Xdkyc5B8TJ1cT4qj6uGdG5BMbqSHqpGHDktaaX2NfLq5uRejmMdMoDATp0yU0uVZY8oJZDN/fSCLqHtcVSaIulvRyv5Vr2O0PfQwMJQHvG27VbtUoSmHIkejIZn7CcwnKxhrb4xdoH5rZ5zdZmR+i8rn3+ZA+Jk+qjRkLrp1inoQsChjQcurXKGmHSS0ia/EJlfR57WNxVwe8QegMZwFGPpavHIFOJls6FgS2F2uIHHYpKdPTN8XIbqz1ELenRSTd4wrIANMDdkcMqUKiexsqVtWmJGRYGel7Ylk6yhw3Z9n42lj6q0t/VJ6s5SF7pxhx1pg18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGlDxEEskCofn5BzOHsYfyfey45uG7qXEehQWnCxXKE=;
 b=R84zCjeaOheLJTN/p7js7bDdayw0pu5/fBnkm9Kp7uQaPu5rRQx+hGoa6c3zGtBY+bMUPSQYPBrQ1JRyjv/HA6HBRTt9uCRdDKIP0usJcNan4z1LXqRo4V91HzB99RQKSABzQJqytzLvpK7fp0RqfnQxYnky4vB2CA2AOLoSsSFtjdYF8mAXwcOTdgArkT5R3EoVgpCaVvgNGl+ezG/xuHeFHr8H5s+tKGar7mR62/rsDKYdF47cMid2YnNAFM813bImBuWf7PfOT5geuZAmpvueaEeDY3TOphXWTQ6pSJEnxprdJ/YHKVqoRl79KQdL870i71tJBRkWJyWmWDzG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGlDxEEskCofn5BzOHsYfyfey45uG7qXEehQWnCxXKE=;
 b=XAh4ROkTXGSPHiCJ7J17PBuGbXMqHbE5C0xfQL9TjeGLZUpk0X8DcWkyemQmZPM/qfd6IJQqBeWyck1UKMXXvoXkRMniZpyUPGSpXI+ltZD++Ah/S/tjxC//mE8/5qBQZQsQqVrgAPnEIKdoS8aKbwT8uld6bxQ9p9hri/z31Ro=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1637.namprd21.prod.outlook.com (2603:10b6:a02:c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4; Wed, 14 Jul
 2021 21:14:14 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b%8]) with mapi id 15.20.4352.009; Wed, 14 Jul 2021
 21:14:14 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
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
Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXeFpU0avVPr6X1EyU3ZDtwXfEcKtCuRkAgAA6OzA=
Date:   Wed, 14 Jul 2021 21:14:13 +0000
Message-ID: <BY5PR21MB1506BDE89848097EF2488FB9CE139@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <YO8deHGP7GBYQp5x@kroah.com>
In-Reply-To: <YO8deHGP7GBYQp5x@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=02fdc037-3911-452d-973d-1949edb045b1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-14T20:51:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c3e7d61-6785-4db3-f827-08d9470c5506
x-ms-traffictypediagnostic: BYAPR21MB1637:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB16373EE2443F82EBCFFC18F3CE139@BYAPR21MB1637.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i34IjsUYWgwghxvHas9887Cxmep/B1tYRZ6FlG0x6U0iINMJElJvnN5EWP2s/cdWR9GRH+w3zfgnG84Y4zw5pg2nVbxGIVnY3DCFe57HCQs+yjcMr033iUj4qo7gGyWtsv/LP2L53f0Gr6jX8YGqRy8ld3nAzU0/7SLbwj5UHDwxULOdEALOfDW0nPJ+dDw4aKVTziml2PnjCT1mszlkd4HOyD3SIbuxVTYlNGczvhMo+eOEnDrgPlJ8dNG9ziOwRAAOwwExzB8FnNsan6zy+aB4/kiI7mNntk5Ad2ctydahUMz/KclUEhNNdt+cHbD3DXFw8M4uEF8SKUA7JOI1alDnmU0tZm70/Soi1AYtgjwndl0zvMzptsj3Uo0Wl270DGQzXxG6bSKrX2kXtiOcCCgIULWnMiNJFmcn5Oh1nKW2m4x9HNseLlGbEA2ql9wmjQ1YvEUw/C4b3xgEfcwXy208tMTf/GYIwRCMUY3tDiEM5XtoeYLPjUsLtKiJM6m5otcHv8kl5G+08WRjMlzCDlLZxKXl8HIKA7uqCKWDuKoz833RDkrq14dYprwY0LstIZLuUvgefEaZiZ1il4Bmql11D8TCbO5e6zXhsqYds/JssqSGdmkIFKfd0YaRVkM0BUAw+aRLlLKQAIwKQdLkM7QSyWYP9c6Smp/HRp9OWcb4NO8B7R2CvluJFLQ+9SLXxIj96/7MHmfG9O4TQrIZjG4iHDKVx+0HrVFheSx4htmbjF6kEV/PM/wmH2TIJbGIdeDwBeOvlABVYzOSmPcKHaJqc+IGHr4NlHZuVHJ8suYRinQIL5XQJNsKDwV3lp9nWXCuu/1P7FFLZgJY2IdFQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(82960400001)(82950400001)(66446008)(66476007)(5660300002)(478600001)(6506007)(316002)(9686003)(55016002)(7696005)(10290500003)(52536014)(8676002)(76116006)(66556008)(33656002)(66946007)(8990500004)(64756008)(83380400001)(86362001)(26005)(2906002)(71200400001)(7416002)(54906003)(966005)(186003)(4326008)(38100700002)(8936002)(122000001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u7B4PUu9bvNO00GSeT1V3LZDHb/dvcPZ9x6OL4sRMeBw7X+woJgev+v+k2ZA?=
 =?us-ascii?Q?wtpLLDJC5tmkCrLPkLMKY2AoadCxDxg7ud+pAA8QY3fjU0H8u5QvMd4zRWiw?=
 =?us-ascii?Q?Nwo4kaYofDwIxOZRZzEjxnS31JS2mwLi/IOgB+b4VCm4OxmqXNMHqVQDN/Iu?=
 =?us-ascii?Q?jOfbjISPVr/p0zMfvugwRwaeCxD/O7uqNoASbj6UGD/Ty3nV7QJXNycQ+Ibf?=
 =?us-ascii?Q?74OpzUAwtxNJ8izI03sdXdxZfzgIdVD4UIq+C1Wh+JaQMc6nYfHXPlXN49Bb?=
 =?us-ascii?Q?AQqdgyh88V93aQ/EEYUnHJuaYXVgOmaARhno/cq9VfYR2lyYVwjdq+4SvsA7?=
 =?us-ascii?Q?YdYbaUSbZv+FnO4gLx4L86ImwAEEu18GvN0Ha+dkoGOaQO9h4tv3tEkMc47N?=
 =?us-ascii?Q?P9Hnqi/edR8zbRxi4AjI5aVJKROyqkrqZYGqSIr68SiX0IY1xy3jyJAuNzuy?=
 =?us-ascii?Q?7jyo3unv7yZAl9Qm+EUrKNQcc8cws0JvPs0SZYBh05ahrPA0G0gqXQSJxsp/?=
 =?us-ascii?Q?uUh6T13snxIY8c+s8U60WSCJgOUcS4Vt4zM2+RRQWLBjkHr0ocN6nCJZ9A4p?=
 =?us-ascii?Q?RMeWU9ERnlGs7VOKBL2SD72Fcfnopj7zz1MfVzSikygI3MMX1LzexNkvQ5U5?=
 =?us-ascii?Q?hazvrVv+aZAflXE6sg3ozgSsK4VdJp9SIw9eEdgXiLESCuS6iETpIDu8cvn9?=
 =?us-ascii?Q?MGImp1jX1oL2yuTqkhyZvr3HaY7wArh5e461PvBVwlj3j/F0FICMOugpJMti?=
 =?us-ascii?Q?QFGFmD9A6VXecla4PpaLaVmxyzsiq0YeyXGIDrak+wAgxIBS4Wt7HbAHBTXz?=
 =?us-ascii?Q?B2lVJ5MBE1AyX3bAQDMpPUzbe1Jigp7ubrRo5RXyrVoTPZIEYNCHiypqWX0v?=
 =?us-ascii?Q?vogXZ4QaDxg1H7bqXvXascqvT/f9rPptG++2tUc+xom35yNib+O7EKvz5IBu?=
 =?us-ascii?Q?eRmlw1GquAj+IOqqzkTgU6vG07ZRZQDGyE9HX0Ic3a/Vn3i4tlsFSGN+hCKN?=
 =?us-ascii?Q?v81MisetQV+5rNRsH5r/IGEsxUvfdnBRa9IOmP1Z6LaHu6C+B+0CuqM2XvTZ?=
 =?us-ascii?Q?GNoaRFC1E7JqToudQLVfZLm7SxFquPSLhZVNEv+vYvYJ0ZXQFrrJ8atLLWPc?=
 =?us-ascii?Q?+tN3j79kHsiNnYlBoMx70SY26oz9/36ZwIlzgmZ0YPVJHsQ3vzfZ0kibDz+C?=
 =?us-ascii?Q?JKQm6Cyke/Qcpter8tJP2WgO7+TILScYuTPllG/7tWKdd/HOsz5uoqoPftLd?=
 =?us-ascii?Q?E3NLAIPnNN2EPhPyCPy3OPRUkGSWIEWKz0wo+OapSoZZkoTwTRFG8zrWhDkb?=
 =?us-ascii?Q?WvM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3e7d61-6785-4db3-f827-08d9470c5506
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 21:14:13.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3goSY7foTgSqmqA0yJ7Z34fDq3zmP5GG2vYelgWexcWH8QsRjWhiH0DHXus6tZ0NOmd2TPYQUdI74a1e8dn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1637
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > Azure Blob storage provides scalable and durable data storage for Azure=
.
> >
> (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fazu
> > re.microsoft.com%2Fen-
> us%2Fservices%2Fstorage%2Fblobs%2F&amp;data=3D04%7
> >
> C01%7Clongli%40microsoft.com%7C950a81a410c54c2475a308d946ec0c09%7C
> 72f9
> >
> 88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637618801920394272%7CUnk
> nown%7C
> >
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVC
> >
> I6Mn0%3D%7C1000&amp;sdata=3DiLDP6EYsoCDlLvToJB31hIQxW3NdCnR0UH31
> FRDwvRI%
> > 3D&amp;reserved=3D0)
> >
> > This driver adds support for accelerated access to Azure Blob storage.
> > As an alternative to REST APIs, it provides a fast data path that uses
> > host native network stack and secure direct data link for storage serve=
r
> access.
>=20
> So it goes around the block layer?  Why?

Azure Blob is object-oriented storage solution designed for cloud environme=
nts.
While it's entirely possible to go through block layer, it's not as efficie=
nt as using
its native APIs for data access. Some of the security features (authenticat=
ion,=20
tokens, lifecycle management) are not easily integrated into block layer. T=
he
object model in Azure Blob is designed to be scalable and doesn't have many
limitations that block layer enforces (e.g. number of sectors).

Please refer to this link for different storage models in Azure:
https://docs.microsoft.com/en-us/azure/storage/common/storage-introduction#=
core-storage-services

>=20
> > This driver will be ported to FreeBSD. It's dual licensed for BSD and G=
PL.
>=20
> Being the copyright holder, you are free to relicense this code to any ot=
her
> license you want to.  So why is this single HV driver different from all =
the
> other ones in this regard when it comes to the license?
>=20
> Given that this driver only works when talking to GPL-only symbols in the
> kernel, how could it be ported to freebsd as-is by anyone who is not the
> copyright holder?
>=20
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
> >  drivers/hv/azure_blob.c                            | 625 +++++++++++++=
++++++++
> >  drivers/hv/channel_mgmt.c                          |   7 +
> >  include/linux/hyperv.h                             |   9 +
> >  include/uapi/misc/azure_blob.h                     |  34 ++
> >  7 files changed, 688 insertions(+)
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
>=20
> No definition of what this is?
>=20
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
>=20
> Your naming scheme is different from the other hv modules, why?
>=20
> >
> >  CFLAGS_hv_trace.o =3D -I$(src)
> >  CFLAGS_hv_balloon.o =3D -I$(src)
> > diff --git a/drivers/hv/azure_blob.c b/drivers/hv/azure_blob.c new
> > file mode 100644 index 0000000..5367d5e
> > --- /dev/null
> > +++ b/drivers/hv/azure_blob.c
> > @@ -0,0 +1,625 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH
> > +Linux-syscall-note
>=20
> .c files can NOT have the syscall note license, as that makes no sense at=
 all.
>=20
> I'm stopping here.  Please go run this through your legal department and =
get
> them to sign off on this as it does not seem that you all understand the =
issues
> when it comes to licenses and the Linux kernel at all.  I want to see a l=
awyer
> sign off on this patch next time if you all want to attempt something cra=
zy like
> this.
>=20
> > +/* Copyright (c) Microsoft Corporation. */
>=20
> You forgot a date, your lawyers will be signing you up for some education
> classes now, have fun!
>=20
> gre gk-h

I will address your comments on licensing.

Long
