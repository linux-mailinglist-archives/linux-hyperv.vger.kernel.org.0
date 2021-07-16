Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109353CBC7B
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 21:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhGPT3q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 15:29:46 -0400
Received: from mail-mw2nam08on2117.outbound.protection.outlook.com ([40.107.101.117]:61057
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232146AbhGPT3o (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 15:29:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJxnw740pSLMKIK1adFyFdTICZnxaBYBlKXtFozzU3jbE7cwMn+grm2IWDrhciugs+M4mxEKtBnDBQC+cK8YeNAO1OrbExluCSwZetq/4sc3yowyvV2r1Gyc8T2tUbJ7mf6G30KhKbZRSnbeL63h/QM8FwtDXBILXx99bvfGf0O7BBPrYs7Z4pUF0J/Gt9eS9qL4ubErocHFB/GEfO2sTJi678A9XjRoIT3aWeoOx3jg2D34l3ldIHwoUwFHx5Epi2XnymEl3l5yPTQiLFlJhF9cbg8IIKoF7ebJe0hvheFAvLLGRO6T9be1i4/NI0Gtz145IzRnxLsody7w1F8rRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc79xr+TKmmUURBI7YIrsU5SzJsUJHBjVxGOO+kFOWs=;
 b=IQvLwN7Nh0I+CNX3V0MnpWoYqQ5XvpCEPSaSPXcF54FXTBDqOzuoxV3kgbRwdsYsqpVVwhmwXvjybJmSzcSJ9qT2A87C9m+Rd5Gv5GuSQb7OozthJzeJ4lWKogMZAAWz8MtS2nJROFYowoW4VRIu67U8ZRWazjnY9MpOu9p7Xamd4+HiJ1RaR76seTv5fdIZvXl7v5Axlt+iAT5LN1hFqFo26T8d2SEhBXbtJ6nnPWLCSC6KfUI2XptxFUzwbUUTYFpi6SNoIpuUqvfreagCc0PrfDG2PBgKctV3DREdBsIhuwSJeCQ8Nss2BQlsnvRVgV4nV0+/xWPhQG1JSaf2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc79xr+TKmmUURBI7YIrsU5SzJsUJHBjVxGOO+kFOWs=;
 b=HxcpgEkp09ZlKu3328u2HH/WIjwdReFGnW8zVFQljLC+zlPzfY9KAj2Jl/eCMxM6rUyl9iMHAEd/h+wmd5sVRMd8SD99leC4oPjjBf8gVUAC+eXsZeervjnlWlP1Pk/wZR7cWs0S+XFM9oZrvFtAvm3fUeKn7Cg9QJ3xqOxtC/8=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1311.namprd21.prod.outlook.com (2603:10b6:a03:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.14; Fri, 16 Jul
 2021 19:26:42 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::ec21:a9f8:7e74:5e1b%8]) with mapi id 15.20.4352.011; Fri, 16 Jul 2021
 19:26:42 +0000
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
Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXeFpU0avVPr6X1EyU3ZDtwXfEcKtFxYAAgAAlVyA=
Date:   Fri, 16 Jul 2021 19:26:42 +0000
Message-ID: <BY5PR21MB15062B99587CDDCC126DDD87CE119@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=637f0e51-bd6a-4fba-b81c-288709d0b198;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T14:43:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec874dfa-bb6c-4a29-d2bf-08d9488fa49d
x-ms-traffictypediagnostic: SJ0PR21MB1311:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB131169541D9F1F3152C8C123CE119@SJ0PR21MB1311.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKr50xTFmsP6pcSKjUwtOsjnHgRN4h55hRrVIg1+VSSGsjNNnfkKRpH1XrLinbSpgDqq69+vl6MvZSjvrN6kanjYBq3njI/zwav6+QVepaRxXTn+wFXHDAvTjxPGbmcVENAxIJYMwOT6jaajv/e/STxnyIccq/0LOpJvd/FO3x/pjBr59Woyvr4ateSWTEvgLP/uW2DctndLXm2M+Lwn+5ra8MD0NrAruPHN7qPe9tYnfXOqZc5hwaj5aISRxxrlGQXlkJxmwX0UWdFFQ0DZGxjbop8yCGxM6CauSfZNFqdL5h3GkSnHQ1bpXtGmr2BkUGlevuDbbzYhgCpHTJftH2SgO9VdNUe8ftSQ20BR6sZLqFo73xP061pnyIZoO5n23hCOyTlRmsGG7u277MENJfo8T3+Gsr6Y1iov8BC8+FXiClT2s3h6ab/OK6PG8YBjM39HHzjHLJLxFLcd7sYc+KoGslHnVEiqUNDCNQTadouSpbAaVBHIFxQUoqP4kdBxgEzF/JCfskNbeJzYLjPz/UOqpIFjoupTXf2cDTMqs8LYSgJ/LgzU/kWgSuGc7gsa7k4xBbGL1xQuAhwJdeCxxcVj48iti8UT/fek+RZyyYMoaUDD2br2zrBMuhegsdIaDE6vj+wtpjyzVqwxUcC3i0ypJcoPVNM9TKk3Tn+VWbM/fb23gRjFu3RT1WkVMYcEhaJgFTp37RCT1TBYqHy//j48eENTAX7EKKh6NwaKmKWmc/apznjb1S91V8qEPE7ZnmrXHs5qn/Y7wafxDk5iWj7NNUOsuOfO95HtfhqZxwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(55016002)(26005)(66476007)(76116006)(5660300002)(7416002)(186003)(2906002)(4326008)(86362001)(8990500004)(66556008)(71200400001)(66946007)(83380400001)(9686003)(52536014)(8936002)(110136005)(54906003)(508600001)(122000001)(8676002)(10290500003)(64756008)(316002)(30864003)(7696005)(82950400001)(66446008)(82960400001)(33656002)(38100700002)(38070700004)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bFagfd9W/cowMvI0iVwpho3c5IkxrkHRCegp8V8gU+o9920fHzxNWOaYKAwr?=
 =?us-ascii?Q?Tom5C2qC7BgeKMmWagBtQCj64qfJ3G/73uMCFw7VKUvGNEt02mf2MDPwBw/I?=
 =?us-ascii?Q?nIKp3Uv2cm9PqvRJLO8JBar+ZitdMIpS6fNbYoBufiDyiAJp4sKfIhFH6DBl?=
 =?us-ascii?Q?9VJ+mDfE+0Ve2MfVL24K69EHT9o2zqCh+IAzaeXyIInAMMEUAzP4lT/c5/x0?=
 =?us-ascii?Q?YEU9G9XORRQ20seuT0Wgz3LnjYKAD0IP61NPqeLweTn8Zt1PsrbdV7kaLL4j?=
 =?us-ascii?Q?cBJHSMxol4T8X1Ioy/ibM+mbGIyrYiGIQpChd7QQAJEdIAtf/6UDRF4TYbNp?=
 =?us-ascii?Q?bdeyMHs1gMBCxVdUYfLP6HPQUgkf6FpENk20Cm6Y2azOl5yiYR614qD8k5B9?=
 =?us-ascii?Q?gBRivBdncfnDTQONRuLun3OooF5amlNNTpBaHEFgWuKYzcf0MMRaFMic+iyG?=
 =?us-ascii?Q?ntABoDs9B3pm3QJSFX4qvA2swhPRwzYQnFIAuxhufNhb5gPoegSlLoA+Fx16?=
 =?us-ascii?Q?fMEHCLjMJFdyEev3ye55sNT6czigRU9sB3xjBb2BscHArkXJePHMQ8C+Ffee?=
 =?us-ascii?Q?699fssvOdmDamgqdNq12R3ude2Z54osNER58rca9cV63l93bVRvuWJM6BofN?=
 =?us-ascii?Q?bn+PvNaxyZR5SJyucGynppNaAlCYDQDsDJqQXda2Z7rQx1STTXHb5iH7vWSS?=
 =?us-ascii?Q?UCcpQOUXziXbCFMTQ0lZ9WISNIi9AJHNPwsAuZEK7Tr+UMoRQquPE9BoK44D?=
 =?us-ascii?Q?MBaCDMqESnZDmN1vgroWxJw/LvMTaumEKOyxljJL4Q4MkgYS3QlIhJ8i0eDt?=
 =?us-ascii?Q?zuw21liYXot6vZZvdAstOh6DRFUMgIcmtWkc67Lful8pf17NQwF9vlJOUlEj?=
 =?us-ascii?Q?j7QsIDjyZvmCC4lDImMdWY/9RMXtNjCdmv7EoO6vzEXChiQx+AdsYw3Xf4gs?=
 =?us-ascii?Q?a1UeHuWfocDjcNPZnspGt7jaLju+jjd/kwtpbxRrIfSMU7l6FpIwY76WZR3g?=
 =?us-ascii?Q?lv5QKj771RaG9BvgMDSLwNPOYB7PVgyBb6TI9tlOOeS2qqdo5GyzJDWCAKmZ?=
 =?us-ascii?Q?eVeyfWqLosdUTKO1q77MHG9KW54aNHPGsOhzWMwWEXBPMP/GA9sMXc+WAJvD?=
 =?us-ascii?Q?yY+xG/q5A3bKu/NhcJEoxV0anK5MXtBTbo1sDIvqnZYP6FUwtynP5HdmDJ/J?=
 =?us-ascii?Q?z/xeEm1r2BP77L+HP7PKeB33xl3RDmkG+ZkuOUQnenjifYQc+JXgmXJ04Zx2?=
 =?us-ascii?Q?g1qSYefNse7k6fMeC+2ZnnI1iqK6aIf8xc1M+hQtlGOyg+VGJqiic18Be7cp?=
 =?us-ascii?Q?TL0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec874dfa-bb6c-4a29-d2bf-08d9488fa49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 19:26:42.6755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2czVJO1zzcpJHJ0J+ISmMZQKI7IqUcLENYtwPa+tI0py1n9ggw4CWDWuNeYZFs0+QXAcBvlsmRWMrsdsfeE+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1311
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent:
> Tuesday, July 13, 2021 7:45 PM
> >
> > Azure Blob storage provides scalable and durable data storage for Azure=
.
> >
> (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fazu
> > re.microsoft.com%2Fen-
> us%2Fservices%2Fstorage%2Fblobs%2F&amp;data=3D04%7
> >
> C01%7Clongli%40microsoft.com%7C852590ffe972466d24b308d948723d8c%7C
> 72f9
> >
> 88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637620477769866945%7CUnk
> nown%7C
> >
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVC
> >
> I6Mn0%3D%7C1000&amp;sdata=3DPZYfSVoLanlTv%2Fi%2Bks4a1IMM0cMiRxP2
> poypgs20
> > S7c%3D&amp;reserved=3D0)
> >
> > This driver adds support for accelerated access to Azure Blob storage.
> > As an alternative to REST APIs, it provides a fast data path that uses
> > host native network stack and secure direct data link for storage serve=
r
> access.
> >
> > This driver will be ported to FreeBSD. It's dual licensed for BSD and G=
PL.
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
> > file mode 100644 index 0000000..5367d5e
> > --- /dev/null
> > +++ b/drivers/hv/azure_blob.c
> > @@ -0,0 +1,625 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH
> > +Linux-syscall-note
> > +/* Copyright (c) Microsoft Corporation. */
> > +
> > +#include <uapi/misc/azure_blob.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/cred.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/hyperv.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/uio.h>
> > +
> > +struct az_blob_device {
> > +	struct hv_device *device;
> > +
> > +	/* Opened files maintained by this device */
> > +	struct list_head file_list;
> > +	/* Lock for protecting file_list */
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
> > +	/* Lock for protecting vsp_pending_requests */
> > +	spinlock_t vsp_pending_lock;
> > +	wait_queue_head_t wait_vsp_pending;
> > +};
> > +
> > +/* The maximum number of pages we can pass to VSP in a single packet
> > +*/ #define AZ_BLOB_MAX_PAGES 8192
> > +
> > +/* The one and only one */
> > +static struct az_blob_device az_blob_dev;
> > +
> > +/* Ring buffer size in bytes */
> > +#define AZ_BLOB_RING_SIZE (128 * 1024)
> > +
> > +/* System wide device queue depth */
> > +#define AZ_BLOB_QUEUE_DEPTH 1024
> > +
> > +static const struct hv_vmbus_device_id id_table[] =3D {
> > +	{ HV_AZURE_BLOB_GUID,
> > +	  .driver_data =3D 0
> > +	},
> > +	{ },
> > +};
> > +
> > +#define az_blob_dbg(fmt, args...)
> > +dev_dbg(&az_blob_dev.device->device, fmt, ##args) #define
> > +az_blob_info(fmt, args...) dev_info(&az_blob_dev.device->device, fmt,
> > +##args) #define az_blob_warn(fmt, args...)
> > +dev_warn(&az_blob_dev.device->device, fmt, ##args) #define
> > +az_blob_err(fmt, args...) dev_err(&az_blob_dev.device->device, fmt,
> > +##args)
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
> > +						  desc->trans_id);
> > +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> > +			az_blob_err("incorrect transaction id %llu\n",
> > +				    desc->trans_id);
> > +			continue;
> > +		}
> > +		request_ctx =3D (struct az_blob_vsp_request_ctx *)cmd_rqst;
> > +		response =3D hv_pkt_data(desc);
> > +
> > +		az_blob_dbg("got response for request %pUb status %u "
> > +			    "response_len %u\n",
> > +			    &request_ctx->request->guid, response->error,
> > +			    response->response_len);
> > +		request_ctx->request->response.status =3D response->error;
> > +		request_ctx->request->response.response_len =3D
> > +			response->response_len;
> > +		complete(&request_ctx->wait_vsp);
> > +	}
> > +}
> > +
> > +static int az_blob_fop_open(struct inode *inode, struct file *file) {
> > +	struct az_blob_file_ctx *file_ctx;
> > +	unsigned long flags;
> > +
> > +	file_ctx =3D kzalloc(sizeof(*file_ctx), GFP_KERNEL);
> > +	if (!file_ctx)
> > +		return -ENOMEM;
> > +
> > +	rcu_read_lock();
> > +
> > +	if (az_blob_dev.removing) {
> > +		rcu_read_unlock();
> > +		kfree(file_ctx);
> > +		return -ENODEV;
> > +	}
> > +
> > +	INIT_LIST_HEAD(&file_ctx->vsp_pending_requests);
> > +	init_waitqueue_head(&file_ctx->wait_vsp_pending);
> > +	spin_lock_init(&file_ctx->vsp_pending_lock);
> > +	file->private_data =3D file_ctx;
> > +
> > +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> > +	list_add_tail(&file_ctx->list, &az_blob_dev.file_list);
> > +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
>=20
> I would think that this function is never called with interrupts disabled=
, so the
> simpler spin_lock()/spin_unlock() functions could be used.
>=20
> > +
> > +	rcu_read_unlock();
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
> > +		   list_empty(&file_ctx->vsp_pending_requests));
> > +
> > +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> > +	list_del(&file_ctx->list);
> > +	if (list_empty(&az_blob_dev.file_list))
> > +		wake_up(&az_blob_dev.file_wait);
> > +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
>=20
> I would think that this function is never called with interrupts disabled=
, so the
> simpler spin_lock()/spin_unlock() functions could be used.
>=20
> > +
> > +	kfree(file_ctx);
> > +
> > +	return 0;
> > +}
> > +
> > +static inline bool az_blob_safe_file_access(struct file *file) {
> > +	return file->f_cred =3D=3D current_cred() && !uaccess_kernel(); }
> > +
> > +static int get_buffer_pages(int rw, void __user *buffer, u32 buffer_le=
n,
> > +			    struct page ***ppages, size_t *start,
> > +			    size_t *num_pages)
> > +{
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
> > +		    iter.type, iter.iov_offset, iter.count, iter.nr_segs);
> > +
> > +	result =3D iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start)=
;
> > +	if (result < 0) {
> > +		az_blob_dbg("failed to pin user pages result=3D%ld\n", result);
> > +		return result;
> > +	}
> > +	if (result !=3D buffer_len) {
> > +		az_blob_dbg("can't pin user pages requested %d got %ld\n",
> > +			    buffer_len, result);
> > +		return -EFAULT;
> > +	}
> > +
> > +	*ppages =3D pages;
> > +	*num_pages =3D (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
> > +	return 0;
> > +}
> > +
> > +static void fill_in_page_buffer(u64 *pfn_array, int *index,
> > +				struct page **pages, unsigned long
> num_pages) {
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
> > +	struct az_blob_request_sync __user *request_user =3D
> > +		(struct az_blob_request_sync __user *)arg;
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
> > +			    " opening file descriptor\n",
> > +			    task_tgid_vnr(current), current->comm);
> > +		return -EACCES;
> > +	}
> > +
> > +	if (copy_from_user(&request, request_user, sizeof(request))) {
> > +		az_blob_dbg("don't have permission to user provided
> buffer\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	az_blob_dbg("az_blob ioctl request guid %pUb timeout %u
> request_len %u"
> > +		    " response_len %u data_len %u request_buffer %llx "
> > +		    "response_buffer %llx data_buffer %llx\n",
> > +		    &request.guid, request.timeout, request.request_len,
> > +		    request.response_len, request.data_len,
> request.request_buffer,
> > +		    request.response_buffer, request.data_buffer);
> > +
> > +	if (!request.request_len || !request.response_len)
> > +		return -EINVAL;
> > +
> > +	if (request.data_len && request.data_len < request.data_valid)
> > +		return -EINVAL;
> > +
> > +	if (request.data_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
> > +	    request.request_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
> > +	    request.response_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES)
> > +		return -EINVAL;
> > +
> > +	init_completion(&request_ctx.wait_vsp);
> > +	request_ctx.request =3D &request;
> > +
> > +	/*
> > +	 * Need to set rw to READ to have page table set up for passing to
> VSP.
> > +	 * Setting it to WRITE will cause the page table entry not allocated
> > +	 * as it's waiting on Copy-On-Write on next page fault. This doesn't
> > +	 * work in this scenario because VSP wants all the pages to be
> present.
> > +	 */
> > +	ret =3D get_buffer_pages(READ, (void __user
> *)request.request_buffer,
> > +			       request.request_len, &request_pages,
> > +			       &request_start, &request_num_pages);
> > +	if (ret)
> > +		goto get_user_page_failed;
> > +
> > +	ret =3D get_buffer_pages(READ, (void __user
> *)request.response_buffer,
> > +			       request.response_len, &response_pages,
> > +			       &response_start, &response_num_pages);
> > +	if (ret)
> > +		goto get_user_page_failed;
> > +
> > +	if (request.data_len) {
> > +		ret =3D get_buffer_pages(READ,
> > +				       (void __user *)request.data_buffer,
> > +				       request.data_len, &data_pages,
> > +				       &data_start, &data_num_pages);
> > +		if (ret)
> > +			goto get_user_page_failed;
> > +	}
> > +
> > +	total_num_pages =3D request_num_pages + response_num_pages +
> > +				data_num_pages;
> > +	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
> > +		az_blob_dbg("number of DMA pages %lu buffer
> exceeding %u\n",
> > +			    total_num_pages, AZ_BLOB_MAX_PAGES);
> > +		ret =3D -EINVAL;
> > +		goto get_user_page_failed;
> > +	}
> > +
> > +	/* Construct a VMBUS packet and send it over to VSP */
> > +	desc_size =3D struct_size(desc, range.pfn_array, total_num_pages);
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
> > +				    data_num_pages);
> > +		vsp_request->data_buffer_offset =3D data_start;
> > +		vsp_request->data_buffer_length =3D request.data_len;
> > +		vsp_request->data_buffer_valid =3D request.data_valid;
> > +	}
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> > +			    request_num_pages);
> > +	vsp_request->request_buffer_offset =3D request_start +
> > +						data_num_pages *
> PAGE_SIZE;
> > +	vsp_request->request_buffer_length =3D request.request_len;
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> > +			    response_num_pages);
> > +	vsp_request->response_buffer_offset =3D response_start +
> > +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> > +	vsp_request->response_buffer_length =3D request.response_len;
> > +
> > +	vsp_request->version =3D 0;
> > +	vsp_request->timeout_ms =3D request.timeout;
> > +	vsp_request->operation_type =3D AZ_BLOB_DRIVER_USER_REQUEST;
> > +	guid_copy(&vsp_request->transaction_id, &request.guid);
> > +
> > +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> > +	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
> > +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
>=20
> I would think that this function is never called with interrupts disabled=
, so the
> simpler spin_lock()/spin_unlock() functions could be used.
>=20
> > +
> > +	az_blob_dbg("sending request to VSP\n");
> > +	az_blob_dbg("desc_size %u desc->range.len %u desc-
> >range.offset %u\n",
> > +		    desc_size, desc->range.len, desc->range.offset);
> > +	az_blob_dbg("vsp_request data_buffer_offset %u
> data_buffer_length %u "
> > +		    "data_buffer_valid %u request_buffer_offset %u "
> > +		    "request_buffer_length %u response_buffer_offset %u "
> > +		    "response_buffer_length %u\n",
> > +		    vsp_request->data_buffer_offset,
> > +		    vsp_request->data_buffer_length,
> > +		    vsp_request->data_buffer_valid,
> > +		    vsp_request->request_buffer_offset,
> > +		    vsp_request->request_buffer_length,
> > +		    vsp_request->response_buffer_offset,
> > +		    vsp_request->response_buffer_length);
> > +
> > +	ret =3D vmbus_sendpacket_mpb_desc(dev->device->channel, desc,
> desc_size,
> > +					vsp_request, sizeof(*vsp_request),
> > +					(u64)&request_ctx);
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
> > +	if (copy_to_user(&request_user->response, &request.response,
> > +			 sizeof(request.response)))
> > +		ret =3D -EFAULT;
> > +
> > +vmbus_send_failed:
> > +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> > +	list_del(&request_ctx.list);
> > +	if (list_empty(&file_ctx->vsp_pending_requests))
> > +		wake_up(&file_ctx->wait_vsp_pending);
> > +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
>=20
> I would think that this function is never called with interrupts disabled=
, so the
> simpler spin_lock()/spin_unlock() functions could be used.
>=20
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
> > +			      unsigned long arg)
> > +{
> > +	switch (cmd) {
> > +	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
> > +		return az_blob_ioctl_user_request(filp, arg);
> > +
> > +	default:
> > +		az_blob_dbg("unrecognized IOCTL code %u\n", cmd);
> > +	}
> > +
> > +	return -EINVAL;
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
> > +				    &file_ctx->vsp_pending_requests, list) {
> > +			seq_printf(m, "%pUb ", &request_ctx->request-
> >guid);
> > +			seq_printf(m, "%u ", request_ctx->request-
> >request_len);
> > +			seq_printf(m, "%u ",
> > +				   request_ctx->request->response_len);
> > +			seq_printf(m, "%u ", request_ctx->request-
> >data_len);
> > +			seq_printf(m, "%llx ",
> > +				   request_ctx->request->request_buffer);
> > +			seq_printf(m, "%llx ",
> > +				   request_ctx->request->response_buffer);
> > +			seq_printf(m, "%llx\n",
> > +				   request_ctx->request->data_buffer);
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
> > +static void az_blob_remove_device(void) {
> > +	struct dentry *debugfs_root =3D debugfs_lookup("az_blob", NULL);
> > +
> > +	misc_deregister(&az_blob_misc_device);
> > +	debugfs_remove_recursive(debugfs_lookup("pending_requests",
> > +						debugfs_root));
> > +	debugfs_remove_recursive(debugfs_root);
> > +	/* At this point, we won't get any requests from user-mode */ }
> > +
> > +static int az_blob_create_device(struct az_blob_device *dev) {
> > +	int ret;
> > +	struct dentry *debugfs_root;
> > +
> > +	ret =3D misc_register(&az_blob_misc_device);
> > +	if (ret)
> > +		return ret;
> > +
> > +	debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> > +	debugfs_create_file("pending_requests", 0400, debugfs_root, NULL,
> > +			    &az_blob_debugfs_fops);
> > +
> > +	return 0;
> > +}
> > +
> > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > +ring_size) {
> > +	int ret;
> > +
> > +	spin_lock_init(&az_blob_dev.file_lock);
> > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > +
> > +	az_blob_dev.device =3D device;
> > +	device->channel->rqstor_size =3D AZ_BLOB_QUEUE_DEPTH;
> > +
> > +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> > +			 az_blob_on_channel_callback, device->channel);
> > +
> > +	if (ret)
> > +		return ret;
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
> > +			 const struct hv_vmbus_device_id *dev_id) {
> > +	int ret;
> > +
> > +	ret =3D az_blob_connect_to_vsp(device, AZ_BLOB_RING_SIZE);
> > +	if (ret) {
> > +		az_blob_err("error connecting to VSP ret=3D%d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	// create user-mode client library facing device
> > +	ret =3D az_blob_create_device(&az_blob_dev);
> > +	if (ret) {
> > +		az_blob_err("failed to create device ret=3D%d\n", ret);
> > +		az_blob_remove_vmbus(device);
> > +		return ret;
> > +	}
> > +
> > +	az_blob_dev.removing =3D false;
>=20
> This line seems misplaced.  As soon as az_blob_create_device() returns,
> some other thread could find the device and open it.  You don't want the
> az_blob_fop_open() function to find the "removing"
> flag set to true.  So I think this line should go *before* the call to
> az_blob_create_device().
>=20
> > +	az_blob_info("successfully probed device\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int az_blob_remove(struct hv_device *dev) {
> > +	az_blob_dev.removing =3D true;
> > +	/*
> > +	 * RCU lock guarantees that any future calls to az_blob_fop_open()
> > +	 * can not use device resources while the inode reference of
> > +	 * /dev/azure_blob is being held for that open, and device file is
> > +	 * being removed from /dev.
> > +	 */
> > +	synchronize_rcu();
>=20
> I don't think this works as you have described.  While it will ensure tha=
t any
> in-progress RCU read-side critical sections have completed (i.e., in
> az_blob_fop_open() ), it does not prevent new read-side critical sections
> from being started.  So as soon as synchronize_rcu() is finished, another
> thread could find and open the device, and be executing in
> az_blob_fop_open().
>=20
> But it's not clear to me that this (and the rcu_read_locks in
> az_blob_fop_open) are really needed anyway.  If az_blob_remove_device()
> is called while one or more threads have it open, I think that's OK.  Or =
is there
> a scenario that I'm missing?

I was trying to address your comment earlier. Here were your comments (1 - =
7):

1) The driver is unbound, so az_blob_remove() is called.
2) az_blob_remove() sets the "removing" flag to true, and calls az_blob_rem=
ove_device().
3) az_blob_remove_device() waits for the file_list to become empty.
4) After the file_list becomes empty, but before misc_deregister() is calle=
d, a separate thread opens the device again.
5) In the separate thread, az_blob_fop_open() obtains the file_lock spin lo=
ck.
6) Before az_blob_fop_open() releases the spin lock, az
block_remove_device() completes, along with az_blob_remove().
7) Then the device gets rebound, and az_blob_connect_to_vsp() gets called, =
all while az_blob_fop_open() still holds the spin lock.  So the spin lock g=
et re-initialized while it is held.

Between step 4 and step 5, I don't see any guarantee that az_blob_fop_open(=
) can't run concurrently on another CPU after misc_deregister() finishes. m=
isc_deregister() calls devtmpfs_delete_node() to remove the device file fro=
m /dev/*, but it doesn't check the return value, so the inode reference num=
ber can be non-zero after it returns, somebody may still try to open it. Th=
is check guarantees that the code can't reference any driver's internal dat=
a structures. az_blob_dev.removing is set so this code can't be entered. Re=
setting it after az_blob_create_device() is also for this purpose.

>=20
> > +
> > +	az_blob_info("removing device\n");
> > +	az_blob_remove_device();
> > +
> > +	/*
> > +	 * At this point, it's not possible to open more files.
> > +	 * Wait for all the opened files to be released.
> > +	 */
> > +	wait_event(az_blob_dev.file_wait,
> > +list_empty(&az_blob_dev.file_list));
>=20
> As mentioned in my most recent comments on the previous version of the
> code, I'm concerned about waiting for all open files to be released in th=
e case
> of a VMbus rescind.  We definitely have to wait for all VSP operations to
> complete, but that's different from waiting for the files to be closed.  =
The
> former depends on Hyper-V being well-behaved and will presumably
> happen quickly in the case of a rescind.  But the latter depends entirely=
 on
> user space code that is out of the kernel's control.  The user space proc=
ess
> could hang around for hours or days with the file still open, which would
> block this function from completing, and hence block the global work queu=
e.
>=20
> Thinking about this, the core issue may be that having a single static in=
stance
> of az_blob_device is problematic if we allow the device to be removed
> (either explicitly with an unbind, or implicitly with a VMbus
> rescind) and then re-added.  Perhaps what needs to happen is that the
> removed device is allowed to continue to exist as long as user space
> processes have an open file handle, but they can't perform any operations
> because the "removing" flag is set (and stays set).
> If the device is re-added, then a new instance of az_blob_device should b=
e
> created, and whether or not the old instance is still hanging around is
> irrelevant.

I agree dynamic device objects is the way to go. Will implement this.

>=20
> > +
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
> > +	return vmbus_driver_register(&az_blob_drv);
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
> > index 705e95d..3095611 100644
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
> > 0000000..f4168679
> > --- /dev/null
> > +++ b/include/uapi/misc/azure_blob.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH
> > +Linux-syscall-note */
> > +/* Copyright (c) Microsoft Corporation. */
> > +
> > +#ifndef _AZ_BLOB_H
> > +#define _AZ_BLOB_H
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/uuid.h>
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
>=20
> Is there an implied 32-bit padding field before "request_buffer"?
> It seems like "yes", since there are five 32-bit field preceding.
> Would it be better to explicitly list that padding field?
>=20
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

