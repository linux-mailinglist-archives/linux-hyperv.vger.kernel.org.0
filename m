Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFA3B69E5
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Jun 2021 22:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhF1Uwo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Jun 2021 16:52:44 -0400
Received: from mail-oln040093003014.outbound.protection.outlook.com ([40.93.3.14]:4741
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236264AbhF1Uwn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Jun 2021 16:52:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsKnxin8fLXGvyKPb9g1gwOIPwE1nBq4NJPIIW3ApOzCjceRwcKj0Mo6fr5afzbK8q10P+Kn0QSqIISgN5oH3G9VvCLHW8anOael22c8YJ5oL1Drmfs0dZTyn2HWAGVTFD4M+KHMIAO9TRapIyjPxS4AmjdEzfklYvYI4tKHwJgvNACkV4o0rDEjqEVwwH78oYfoJQ2NBNkGrbnyMVpf/ziLa1MKjKFHcb/pn+cMB6f3genivpbR8rwYNVRTgI6vqGKU7IixR6XEGZsWVAjUDgaxchrs9FnRW3BLqRQBe9luaTGbfeTVA7E8U/a7laMlNSSgPBeYn9Tex+duc32Jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufLuw8c26928VwZ0i/pvL0hh6kZfhSFsQo/poud4H9Q=;
 b=i/veZbph/19/sAiBq/gYEwQucctQqEx1D7StR1kE3UqetpiA1IiEu+sIBtDRmye+qs16KdLRvj31m7efy4ksrNC/1ffY76pCsuTDZzok4mjgyIDzRb/6vq1L6LIplbZERCvog74isT5GbYkKYwAXwXylxDiQjqMsf2ncwVE920LXv4iy5GKqqeAwpTwoqq4ywzfapj8JBBk7LrDtLeZ5J/KCmoNd8yymKUeuc5J09DrK/+0hStQ35dNk4UeQYf9VEZj+fycZQBaLNHSlH4NfEJF/WfRNqQcBUWNf0ZZXZrtgPlvT9jrx0uXGNxpbXIba7rJ42saJbpOImMvZ6cAZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufLuw8c26928VwZ0i/pvL0hh6kZfhSFsQo/poud4H9Q=;
 b=YS9mpUIFD4k5m7ycicRU/oXCG3O3Wmud5ZCRcrwzRCqo42BGh6FvR+WaSavM6yNKXhEZQ8i/+bzV4qjkDTDJH5REqoLt+dj2aKeXG+13YXTblrzlCjwTuF9nHv+fBM7J6n0pDakzmXHKgvxHqV9t2JFaJX9YlBpXPv2egN4gw3U=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0285.namprd21.prod.outlook.com (2603:10b6:300:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.4; Mon, 28 Jun
 2021 20:50:10 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07%6]) with mapi id 15.20.4308.006; Mon, 28 Jun 2021
 20:50:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
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
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTRwSwb8zgU/UyKv3LljLGzrasphsOQ
Date:   Mon, 28 Jun 2021 20:50:10 +0000
Message-ID: <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34b74f3b-f78a-4066-9c87-8e11622defa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T14:56:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8cabb55-b9f2-4e98-fefe-08d93a7651e2
x-ms-traffictypediagnostic: MWHPR21MB0285:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB028591FD5883B82862F243D6D7039@MWHPR21MB0285.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zerCkU7Z4s/7EKn0gwJHxVnh1hLa7uE4G6d9C0syFwQGWPD46I2Llti5jcFVThODmm78lGGnqOgcYjxvrcgWN7ffUEhP4rQWFi9mWN9yGzyPc/EtaC0XVzixFPsewFSV74s8yAkhHb5Z2+/4EzTUdips7c+NiLgBHHr23P+1qqlQLqNi7AIiz5n6ahqPxATvU5Ixk4LvxEcgSpg4QKD82DcSCTJhca4ooq2q2EuR/NJlamuKvHN0r2oSSx08ieonfHtgvSPtcM/yLsM11ehtTsdKiQuhl9yBnxUzbs0hw2331PoabqHM6MvHh1L2PmqqPKWjXuCqtRjb+GbZpHQYjik5AX+t3uneHdRyONcNKo9fks2IttJj+OR0bkQAeJecoeAl4yInBW1qXNklOTWxBnVJak9IifPt6Mhh0vWLM16G+m2fdG5+Vxk+6vbuI72bWMXaS14ZxccN+sKsVZM/yfMYT2sMVQCbdTzjk4W2b9TGq5//K6eZ3Kkm317vWQz6EFWpxtSC/4Eyf5rQjzghn0YngkaE0p6xgkL77svEc3UX/A0TSi744+T8QmzrtUbvqdal7XcJCrl1mGm6r/OmcR4gMb5BWuR0aMQkDjFUMhrzTsYTC7xSm3sRV3+UaZtPRpR4ZcriN0yNS7KLUUb0E5Zyj3ZtgUUo62xNNDNPYdPoJHSxNAdBd2SYpqXW4k+cJniT0Ts+zJoC4xRLA44c6gvXDGkYsx8pqRfWiOOYP4YEGk1+ReVsVCA3LkNKf+TCR2D3fdXVwyboJUcSIEqN3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(8990500004)(8936002)(8676002)(30864003)(6506007)(83380400001)(10290500003)(7696005)(26005)(55016002)(82960400001)(64756008)(186003)(478600001)(4326008)(52536014)(7416002)(316002)(110136005)(38100700002)(54906003)(33656002)(2906002)(66476007)(9686003)(5660300002)(66446008)(71200400001)(122000001)(76116006)(66946007)(82950400001)(66556008)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mnOdtHDMkdxdN1TrSxCbiyDXiPjYPwIEOUHU5LCfU1IRS48vUhwkIy2ldc6r?=
 =?us-ascii?Q?l0Hjar+erbwW+M5w0d5pL7IMnyv+FEYa9rzztzCfctbbep4F0/ph6SXnkaxz?=
 =?us-ascii?Q?iMNCs5OkU55ZMcJ8q18dsOrVNR4hlNi/neYvROp2UMM2Jo1eaQKjDNNVZvBY?=
 =?us-ascii?Q?zAKqch7EJAsu2ijlgkA0a5h0dReyRPhul5ypDrqL6rmQYqH+lQtfpVV2ABJq?=
 =?us-ascii?Q?Ff+QBGHnH1esXFwFxVP62XCD1Zm+pJQb9FGEstGiJG/j/EkyAe/hU2dzBZyv?=
 =?us-ascii?Q?uVSR0qQzuK0UmWTnPqtWSzc7xmKGOiRZEVTr6qTSs4B+MgKYvkYaQxEuXg82?=
 =?us-ascii?Q?4lIHqCu4o5aj3g0PvNFM7pPMOdDVdp8/Ijcz3xl9Cvmnab+C6K5K0RpT1xYY?=
 =?us-ascii?Q?FI3JDqmjSXotnuY7cCRZiWY3cbRhn3b1egOQ0HCJgA+b7lJIGN6A7k8KSF0m?=
 =?us-ascii?Q?7PzHdAYxuO+MTgdNCRzxs9wY6Hw670qVjBSyEQWl2+vrQqSjPkLez3T+kI0H?=
 =?us-ascii?Q?jvcaILl5VCeJ7nqynpPjwWOf5lOgpICY0UHSSp+eLvHS2MDlGu9tNkmrfUqr?=
 =?us-ascii?Q?IhAoav6naRSLg8eYl/M+MS40aTU72PW91Lx46OaCfZZXPCg7YDAVVV4HoP3v?=
 =?us-ascii?Q?n4OD6tSVN3ceTPAAdMgVlOUvMevSBn3xO9U8GM3K0Qu1iWXCma7ogw2loF07?=
 =?us-ascii?Q?47WDuuBH7aG6ac2KYSzjvC+0ZD5F6o7Z4XZaWC93Pq7e84dfs7oMK3JR3LsB?=
 =?us-ascii?Q?EqfJS9TlgqFv7K4U9kam2f9Xce3NlnRjadWakwTq+OlkIarzsQtsHqUlqsbt?=
 =?us-ascii?Q?HYss5yrq3OPNeDXeFMIDyblM5k7ZcJvvvD84SwTIIaeGELd8vlNCCyATHwLr?=
 =?us-ascii?Q?8o4/CdEPd1EcIJtNxfl3WGwUIiK8S7+ska2AnD3xmo67w/j6+deHJ2mVHg+q?=
 =?us-ascii?Q?9WD9X0F7hU78y7LZuh74uesJcV9sUhLg73qKlRVTyGofVFYxYfdC4HCcTdLs?=
 =?us-ascii?Q?NDemltA9vQbXPYhBVVc2OO3Sn+jNP4o9Ik2Jcc2J2/bZDWErrUlR/KVt+a62?=
 =?us-ascii?Q?hrZ04s9rJzPsewpBc+sB/qFJP/J+4lspjoMhGJMVGCP+HROZXq1VkE6TK8yV?=
 =?us-ascii?Q?/XA07fIrHE6/uOvPVYuS/tXcth2iCdaJrBVPupHTiW/uGYXVqmbwtkMKmZZc?=
 =?us-ascii?Q?N8nCGrR1dKliAO4/5pbXyUoKv9c4IwjESrEd52WB2Y0fnV6tz9JQIMBDKA2P?=
 =?us-ascii?Q?4vsBQGBlVxUf+Z3iMUtSeOkDeXmS0mDNQPyee+cBb9qAwwH1rVR4mnWPhLbV?=
 =?us-ascii?Q?qy6B7Ybe8u0hNdzc9MWqTjoU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cabb55-b9f2-4e98-fefe-08d93a7651e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 20:50:10.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfKNI3nM1fzCgJbokycXPRXEjmSxMyzaOuAUeBoQKu1FIyYCFb10SjeWr7MjR3zghqhp9aawt+28I0Ia20KD5boeeCsbZ0TIf/ZtYEJvnQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0285
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Friday, Jun=
e 25, 2021 11:30 PM
>=20
> Azure Blob storage provides scalable and durable data storage for Azure.
> (https://azure.microsoft.com/en-us/services/storage/blobs/)
>=20
> This driver adds support for accelerated access to Azure Blob storage. As=
 an
> alternative to REST APIs, it provides a fast data path that uses host nat=
ive
> network stack and secure direct data link for storage server access.
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
>  drivers/hv/Kconfig                                 |  10 +
>  drivers/hv/Makefile                                |   1 +
>  drivers/hv/azure_blob.c                            | 655 +++++++++++++++=
++++++
>  drivers/hv/channel_mgmt.c                          |   7 +
>  include/linux/hyperv.h                             |   9 +
>  include/uapi/misc/azure_blob.h                     |  31 +
>  7 files changed, 715 insertions(+)
>  create mode 100644 drivers/hv/azure_blob.c
>  create mode 100644 include/uapi/misc/azure_blob.h
>=20
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documen=
tation/userspace-api/ioctl/ioctl-number.rst
> index 9bfc2b5..d3c2a90 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -180,6 +180,8 @@ Code  Seq#    Include File                           =
                Comments
>  'R'   01     linux/rfkill.h                                          con=
flict!
>  'R'   C0-DF  net/bluetooth/rfcomm.h
>  'R'   E0     uapi/linux/fsl_mc.h
> +'R'   F0-FF  uapi/misc/azure_blob.h                                  Mic=
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
> index 66c794d..e08b8d3 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -27,4 +27,14 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config HYPERV_AZURE_BLOB
> +	tristate "Microsoft Azure Blob driver"
> +	depends on HYPERV && X86_64
> +	help
> +	  Select this option to enable Microsoft Azure Blob driver.
> +
> +	  This driver supports accelerated Microsoft Azure Blob access.
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called azure_blob.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 94daf82..a322575 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
> +obj-$(CONFIG_HYPERV_AZURE_BLOB)	+=3D azure_blob.o
>=20
>  CFLAGS_hv_trace.o =3D -I$(src)
>  CFLAGS_hv_balloon.o =3D -I$(src)
> diff --git a/drivers/hv/azure_blob.c b/drivers/hv/azure_blob.c
> new file mode 100644
> index 0000000..6c8f957
> --- /dev/null
> +++ b/drivers/hv/azure_blob.c
> @@ -0,0 +1,655 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright (c) 2021, Microsoft Corporation. */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/cred.h>
> +#include <linux/debugfs.h>
> +#include <linux/pagemap.h>
> +#include <linux/hyperv.h>
> +#include <linux/miscdevice.h>
> +#include <linux/uio.h>
> +#include <uapi/misc/azure_blob.h>
> +
> +struct az_blob_device {
> +	struct hv_device *device;
> +
> +	/* Opened files maintained by this device */
> +	struct list_head file_list;
> +	spinlock_t file_lock;
> +	wait_queue_head_t file_wait;
> +
> +	bool removing;
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
> +	struct list_head list;
> +	struct completion wait_vsp;
> +	struct az_blob_request_sync *request;
> +};
> +
> +struct az_blob_file_ctx {
> +	struct list_head list;
> +
> +	/* List of pending requests to VSP */
> +	struct list_head vsp_pending_requests;
> +	spinlock_t vsp_pending_lock;
> +	wait_queue_head_t wait_vsp_pending;
> +};
> +
> +/* The maximum number of pages we can pass to VSP in a single packet */
> +#define AZ_BLOB_MAX_PAGES 8192
> +
> +#ifdef CONFIG_DEBUG_FS
> +struct dentry *az_blob_debugfs_root;
> +#endif
> +
> +static struct az_blob_device az_blob_dev;
> +
> +static int az_blob_ringbuffer_size =3D (128 * 1024);
> +module_param(az_blob_ringbuffer_size, int, 0444);
> +MODULE_PARM_DESC(az_blob_ringbuffer_size, "Ring buffer size (bytes)");
> +
> +static const struct hv_vmbus_device_id id_table[] =3D {
> +	{ HV_AZURE_BLOB_GUID,
> +	  .driver_data =3D 0
> +	},
> +	{ },
> +};
> +
> +#define AZ_ERR 0
> +#define AZ_WARN 1
> +#define AZ_DBG 2
> +static int log_level =3D AZ_ERR;
> +module_param(log_level, int, 0644);
> +MODULE_PARM_DESC(log_level,
> +	"Log level: 0 - Error (default), 1 - Warning, 2 - Debug.");
> +
> +static uint device_queue_depth =3D 1024;
> +module_param(device_queue_depth, uint, 0444);
> +MODULE_PARM_DESC(device_queue_depth,
> +	"System level max queue depth for this device");
> +
> +#define az_blob_log(level, fmt, args...)	\
> +do {	\
> +	if (level <=3D log_level)	\
> +		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
> +} while (0)
> +
> +#define az_blob_dbg(fmt, args...) az_blob_log(AZ_DBG, fmt, ##args)
> +#define az_blob_warn(fmt, args...) az_blob_log(AZ_WARN, fmt, ##args)
> +#define az_blob_err(fmt, args...) az_blob_log(AZ_ERR, fmt, ##args)
> +
> +static void az_blob_on_channel_callback(void *context)
> +{
> +	struct vmbus_channel *channel =3D (struct vmbus_channel *)context;
> +	const struct vmpacket_descriptor *desc;
> +
> +	az_blob_dbg("entering interrupt from vmbus\n");
> +	foreach_vmbus_pkt(desc, channel) {
> +		struct az_blob_vsp_request_ctx *request_ctx;
> +		struct az_blob_vsp_response *response;
> +		u64 cmd_rqst =3D vmbus_request_addr(&channel->requestor,
> +					desc->trans_id);
> +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> +			az_blob_err("incorrect transaction id %llu\n",
> +				desc->trans_id);
> +			continue;
> +		}
> +		request_ctx =3D (struct az_blob_vsp_request_ctx *) cmd_rqst;
> +		response =3D hv_pkt_data(desc);
> +
> +		az_blob_dbg("got response for request %pUb status %u "
> +			"response_len %u\n",
> +			&request_ctx->request->guid, response->error,
> +			response->response_len);
> +		request_ctx->request->response.status =3D response->error;
> +		request_ctx->request->response.response_len =3D
> +			response->response_len;
> +		complete(&request_ctx->wait_vsp);
> +	}
> +
> +}
> +
> +static int az_blob_fop_open(struct inode *inode, struct file *file)
> +{
> +	struct az_blob_file_ctx *file_ctx;
> +	unsigned long flags;
> +
> +
> +	file_ctx =3D kzalloc(sizeof(*file_ctx), GFP_KERNEL);
> +	if (!file_ctx)
> +		return -ENOMEM;
> +
> +
> +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> +	if (az_blob_dev.removing) {
> +		spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> +		kfree(file_ctx);
> +		return -ENODEV;
> +	}
> +	list_add_tail(&file_ctx->list, &az_blob_dev.file_list);
> +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> +
> +	INIT_LIST_HEAD(&file_ctx->vsp_pending_requests);
> +	init_waitqueue_head(&file_ctx->wait_vsp_pending);

It feels a little weird to be initializing fields in the file_ctx
*after* it has been added to the file list.  But I guess it's
OK since no requests can be issued and the file can't be
closed until after this open call completes.

> +	file->private_data =3D file_ctx;
> +
> +	return 0;
> +}
> +
> +static int az_blob_fop_release(struct inode *inode, struct file *file)
> +{
> +	struct az_blob_file_ctx *file_ctx =3D file->private_data;
> +	unsigned long flags;
> +
> +	wait_event(file_ctx->wait_vsp_pending,
> +		list_empty(&file_ctx->vsp_pending_requests));
> +
> +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> +	list_del(&file_ctx->list);
> +	if (list_empty(&az_blob_dev.file_list))
> +		wake_up(&az_blob_dev.file_wait);
> +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> +
> +	return 0;
> +}
> +
> +static inline bool az_blob_safe_file_access(struct file *file)
> +{
> +	return file->f_cred =3D=3D current_cred() && !uaccess_kernel();
> +}
> +
> +static int get_buffer_pages(int rw, void __user *buffer, u32 buffer_len,
> +	struct page ***ppages, size_t *start, size_t *num_pages)
> +{
> +	struct iovec iov;
> +	struct iov_iter iter;
> +	int ret;
> +	ssize_t result;
> +	struct page **pages;
> +
> +	ret =3D import_single_range(rw, buffer, buffer_len, &iov, &iter);
> +	if (ret) {
> +		az_blob_dbg("request buffer access error %d\n", ret);
> +		return ret;
> +	}
> +	az_blob_dbg("iov_iter type %d offset %lu count %lu nr_segs %lu\n",
> +		iter.type, iter.iov_offset, iter.count, iter.nr_segs);
> +
> +	result =3D iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start);
> +	if (result < 0) {
> +		az_blob_dbg("failed to pin user pages result=3D%ld\n", result);
> +		return result;
> +	}
> +	if (result !=3D buffer_len) {
> +		az_blob_dbg("can't pin user pages requested %d got %ld\n",
> +			buffer_len, result);
> +		return -EFAULT;
> +	}
> +
> +	*ppages =3D pages;
> +	*num_pages =3D (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
> +	return 0;
> +}
> +
> +static void fill_in_page_buffer(u64 *pfn_array,
> +	int *index, struct page **pages, unsigned long num_pages)
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
> +		if (pages[i])
> +			put_page(pages[i]);
> +	kvfree(pages);
> +}
> +
> +static long az_blob_ioctl_user_request(struct file *filp, unsigned long =
arg)
> +{
> +	struct az_blob_device *dev =3D &az_blob_dev;
> +	struct az_blob_file_ctx *file_ctx =3D filp->private_data;
> +	char __user *argp =3D (char __user *) arg;
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
> +	/* Fast fail if device is being removed */
> +	if (dev->removing)
> +		return -ENODEV;
> +
> +	if (!az_blob_safe_file_access(filp)) {
> +		az_blob_dbg("process %d(%s) changed security contexts after"
> +			" opening file descriptor\n",
> +			task_tgid_vnr(current), current->comm);
> +		return -EACCES;
> +	}
> +
> +	if (copy_from_user(&request, argp, sizeof(request))) {
> +		az_blob_dbg("don't have permission to user provided buffer\n");
> +		return -EFAULT;
> +	}
> +
> +	az_blob_dbg("az_blob ioctl request guid %pUb timeout %u request_len %u"
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
> +	init_completion(&request_ctx.wait_vsp);
> +	request_ctx.request =3D &request;
> +
> +	/*
> +	 * Need to set rw to READ to have page table set up for passing to VSP.
> +	 * Setting it to WRITE will cause the page table entry not allocated
> +	 * as it's waiting on Copy-On-Write on next page fault. This doesn't
> +	 * work in this scenario because VSP wants all the pages to be present.
> +	 */
> +	ret =3D get_buffer_pages(READ, (void __user *) request.request_buffer,
> +		request.request_len, &request_pages, &request_start,
> +		&request_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	ret =3D get_buffer_pages(READ, (void __user *) request.response_buffer,
> +		request.response_len, &response_pages, &response_start,
> +		&response_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	if (request.data_len) {
> +		ret =3D get_buffer_pages(READ,
> +			(void __user *) request.data_buffer, request.data_len,
> +			&data_pages, &data_start, &data_num_pages);
> +		if (ret)
> +			goto get_user_page_failed;
> +	}

It still seems to me that request.request_len, request.response_len, and
request.data_len should be validated *before* get_buffer_pages() is called.
While the total number of pages that pinned is validated below against
AZ_BLOB_MAX_PAGES, bad values in the *_len fields could pin up to
12 Gbytes of memory before the check against AZ_BLOB_MAX_PAGES
happens.   The pre-validation would make sure that each *_len value
is less than AZ_BLOB_MAX_PAGES, so that the max amount of memory
that could get pinned is 96 Mbytes.

Also, are the *_len values required to be a multiple of PAGE_SIZE?
I'm assuming not, and that any number of bytes is acceptable.  If there
is some requirement such as being a multiple of 512 or something like
that, it should also be part of the pre-validation.

> +
> +	total_num_pages =3D request_num_pages + response_num_pages +
> +				data_num_pages;
> +	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
> +		az_blob_dbg("number of DMA pages %lu buffer exceeding %u\n",
> +			total_num_pages, AZ_BLOB_MAX_PAGES);
> +		ret =3D -EINVAL;
> +		goto get_user_page_failed;
> +	}
> +
> +	/* Construct a VMBUS packet and send it over to VSP */
> +	desc_size =3D sizeof(struct vmbus_packet_mpb_array) +
> +			sizeof(u64) * total_num_pages;
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

The range.len value is always a multiple of PAGE_SIZE.  Assuming that
the request.*_len values are not required to be multiples of PAGE_SIZE,
then the sum of the buffer_length fields in the vsp_request may not
add up to range.len.  Presumably the VSP is OK with that ....

> +	pfn_array =3D desc->range.pfn_array;
> +	page_idx =3D 0;
> +
> +	if (request.data_len) {
> +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> +			data_num_pages);
> +		vsp_request->data_buffer_offset =3D data_start;
> +		vsp_request->data_buffer_length =3D request.data_len;
> +		vsp_request->data_buffer_valid =3D request.data_valid;
> +	}
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> +		request_num_pages);
> +	vsp_request->request_buffer_offset =3D request_start +
> +						data_num_pages * PAGE_SIZE;
> +	vsp_request->request_buffer_length =3D request.request_len;
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> +		response_num_pages);
> +	vsp_request->response_buffer_offset =3D response_start +
> +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> +	vsp_request->response_buffer_length =3D request.response_len;

Interestingly, if any of the data or request or response are adjacent in us=
er
memory, but the boundary is not on a page boundary, the same page
may appear in two successive pfn_array entries.  Again, I'm assuming that's
OK with the VSP.  It appears that the VSP just treats the three memory
areas as completely independent of each other but defined by sequential
entries in the pfn_array.

> +
> +	vsp_request->version =3D 0;
> +	vsp_request->timeout_ms =3D request.timeout;
> +	vsp_request->operation_type =3D AZ_BLOB_DRIVER_USER_REQUEST;
> +	guid_copy(&vsp_request->transaction_id, &request.guid);
> +
> +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> +	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
> +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
> +
> +	az_blob_dbg("sending request to VSP\n");
> +	az_blob_dbg("desc_size %u desc->range.len %u desc->range.offset %u\n",
> +		desc_size, desc->range.len, desc->range.offset);
> +	az_blob_dbg("vsp_request data_buffer_offset %u data_buffer_length %u "
> +		"data_buffer_valid %u request_buffer_offset %u "
> +		"request_buffer_length %u response_buffer_offset %u "
> +		"response_buffer_length %u\n",
> +		vsp_request->data_buffer_offset,
> +		vsp_request->data_buffer_length,
> +		vsp_request->data_buffer_valid,
> +		vsp_request->request_buffer_offset,
> +		vsp_request->request_buffer_length,
> +		vsp_request->response_buffer_offset,
> +		vsp_request->response_buffer_length);
> +
> +	ret =3D vmbus_sendpacket_mpb_desc(dev->device->channel, desc, desc_size=
,
> +		vsp_request, sizeof(*vsp_request), (u64) &request_ctx);
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
> +	if (copy_to_user(argp +
> +			offsetof(struct az_blob_request_sync,
> +				response.status),
> +			&request.response.status,
> +			sizeof(request.response.status))) {
> +		ret =3D -EFAULT;
> +		goto vmbus_send_failed;
> +	}
> +
> +	if (copy_to_user(argp +
> +			offsetof(struct az_blob_request_sync,
> +				response.response_len),
> +			&request.response.response_len,
> +			sizeof(request.response.response_len)))
> +		ret =3D -EFAULT;
> +
> +vmbus_send_failed:
> +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> +	list_del(&request_ctx.list);
> +	if (list_empty(&file_ctx->vsp_pending_requests))
> +		wake_up(&file_ctx->wait_vsp_pending);
> +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
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
> +	unsigned long arg)
> +{
> +	long ret =3D -EIO;
> +
> +	switch (cmd) {
> +	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
> +		if (_IOC_SIZE(cmd) !=3D sizeof(struct az_blob_request_sync))
> +			return -EINVAL;
> +		ret =3D az_blob_ioctl_user_request(filp, arg);
> +		break;
> +
> +	default:
> +		az_blob_dbg("unrecognized IOCTL code %u\n", cmd);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations az_blob_client_fops =3D {
> +	.owner	=3D THIS_MODULE,
> +	.open	=3D az_blob_fop_open,
> +	.unlocked_ioctl =3D az_blob_fop_ioctl,
> +	.release =3D az_blob_fop_release,
> +};
> +
> +static struct miscdevice az_blob_misc_device =3D {
> +	MISC_DYNAMIC_MINOR,
> +	"azure_blob",
> +	&az_blob_client_fops,
> +};
> +
> +static int az_blob_show_pending_requests(struct seq_file *m, void *v)
> +{
> +	unsigned long flags, flags2;
> +	struct az_blob_vsp_request_ctx *request_ctx;
> +	struct az_blob_file_ctx *file_ctx;
> +
> +	seq_puts(m, "List of pending requests\n");
> +	seq_puts(m, "UUID request_len response_len data_len "
> +		"request_buffer response_buffer data_buffer\n");
> +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> +	list_for_each_entry(file_ctx, &az_blob_dev.file_list, list) {
> +		spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags2);
> +		list_for_each_entry(request_ctx,
> +				&file_ctx->vsp_pending_requests, list) {
> +			seq_printf(m, "%pUb ", &request_ctx->request->guid);
> +			seq_printf(m, "%u ", request_ctx->request->request_len);
> +			seq_printf(m,
> +				"%u ", request_ctx->request->response_len);
> +			seq_printf(m, "%u ", request_ctx->request->data_len);
> +			seq_printf(m,
> +				"%llx ", request_ctx->request->request_buffer);
> +			seq_printf(m,
> +				"%llx ", request_ctx->request->response_buffer);
> +			seq_printf(m,
> +				"%llx\n", request_ctx->request->data_buffer);
> +		}
> +		spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags2);
> +	}
> +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int az_blob_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, az_blob_show_pending_requests, NULL);
> +}
> +
> +static const struct file_operations az_blob_debugfs_fops =3D {
> +	.open		=3D az_blob_debugfs_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D seq_release
> +};
> +
> +static void az_blob_remove_device(struct az_blob_device *dev)
> +{
> +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> +	misc_deregister(&az_blob_misc_device);
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_remove_recursive(az_blob_debugfs_root);
> +#endif
> +	/* At this point, we won't get any requests from user-mode */
> +}
> +
> +static int az_blob_create_device(struct az_blob_device *dev)
> +{
> +	int rc;
> +	struct dentry *d;
> +
> +	rc =3D misc_register(&az_blob_misc_device);
> +	if (rc) {
> +		az_blob_err("misc_register failed rc %d\n", rc);
> +		return rc;
> +	}
> +
> +#ifdef CONFIG_DEBUG_FS
> +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
> +		d =3D debugfs_create_file("pending_requests", 0400,
> +			az_blob_debugfs_root, NULL,
> +			&az_blob_debugfs_fops);
> +		if (IS_ERR_OR_NULL(d)) {
> +			az_blob_warn("failed to create debugfs file\n");
> +			debugfs_remove_recursive(az_blob_debugfs_root);
> +			az_blob_debugfs_root =3D NULL;
> +		}
> +	} else
> +		az_blob_warn("failed to create debugfs root\n");
> +#endif
> +
> +	return 0;
> +}
> +
> +static int az_blob_connect_to_vsp(struct hv_device *device, u32 ring_siz=
e)
> +{
> +	int ret;
> +
> +	spin_lock_init(&az_blob_dev.file_lock);

I'd argue that the spin lock should not be re-initialized here.  Here's
the sequence where things go wrong:

1) The driver is unbound, so az_blob_remove() is called.
2) az_blob_remove() sets the "removing" flag to true, and calls
az_blob_remove_device().
3) az_blob_remove_device() waits for the file_list to become empty.
4) After the file_list becomes empty, but before misc_deregister()
is called, a separate thread opens the device again.
5) In the separate thread, az_blob_fop_open() obtains the file_lock
spin lock.
6) Before az_blob_fop_open() releases the spin lock, az
block_remove_device() completes, along with az_blob_remove().
7) Then the device gets rebound, and az_blob_connect_to_vsp()
gets called, all while az_blob_fop_open() still holds the spin
lock.  So the spin lock get re-initialized while it is held.

This is admittedly a far-fetched scenario, but stranger things
have happened. :-)  The issue is that you are counting on
the az_blob_dev structure to persist and have a valid file_lock,
even while the device is unbound.  So any initialization
should only happen in az_blob_drv_init().

> +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> +	init_waitqueue_head(&az_blob_dev.file_wait);
> +
> +	az_blob_dev.removing =3D false;
> +
> +	az_blob_dev.device =3D device;
> +	device->channel->rqstor_size =3D device_queue_depth;
> +
> +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> +			az_blob_on_channel_callback, device->channel);
> +
> +	if (ret) {
> +		az_blob_err("failed to connect to VSP ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	hv_set_drvdata(device, &az_blob_dev);
> +
> +	return ret;
> +}
> +
> +static void az_blob_remove_vmbus(struct hv_device *device)
> +{
> +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> +	hv_set_drvdata(device, NULL);
> +	vmbus_close(device->channel);
> +}
> +
> +static int az_blob_probe(struct hv_device *device,
> +			const struct hv_vmbus_device_id *dev_id)
> +{
> +	int rc;
> +
> +	az_blob_dbg("probing device\n");
> +
> +	rc =3D az_blob_connect_to_vsp(device, az_blob_ringbuffer_size);
> +	if (rc) {
> +		az_blob_err("error connecting to VSP rc %d\n", rc);
> +		return rc;
> +	}
> +
> +	// create user-mode client library facing device
> +	rc =3D az_blob_create_device(&az_blob_dev);
> +	if (rc) {
> +		az_blob_remove_vmbus(device);
> +		return rc;
> +	}
> +
> +	az_blob_dbg("successfully probed device\n");
> +	return 0;
> +}
> +
> +static int az_blob_remove(struct hv_device *dev)
> +{
> +	struct az_blob_device *device =3D hv_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&device->file_lock, flags);
> +	device->removing =3D true;
> +	spin_unlock_irqrestore(&device->file_lock, flags);
> +
> +	az_blob_remove_device(device);
> +	az_blob_remove_vmbus(dev);
> +	return 0;
> +}
> +
> +static struct hv_driver az_blob_drv =3D {
> +	.name =3D KBUILD_MODNAME,
> +	.id_table =3D id_table,
> +	.probe =3D az_blob_probe,
> +	.remove =3D az_blob_remove,
> +	.driver =3D {
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +
> +static int __init az_blob_drv_init(void)
> +{
> +	int ret;
> +
> +	ret =3D vmbus_driver_register(&az_blob_drv);
> +	return ret;
> +}
> +
> +static void __exit az_blob_drv_exit(void)
> +{
> +	vmbus_driver_unregister(&az_blob_drv);
> +}
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("Microsoft Azure Blob driver");
> +module_init(az_blob_drv_init);
> +module_exit(az_blob_drv_exit);
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 0c75662..436fdeb 100644
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
> diff --git a/include/uapi/misc/azure_blob.h b/include/uapi/misc/azure_blo=
b.h
> new file mode 100644
> index 0000000..29413fc
> --- /dev/null
> +++ b/include/uapi/misc/azure_blob.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/* Copyright (c) 2021, Microsoft Corporation. */
> +
> +#ifndef _AZ_BLOB_H
> +#define _AZ_BLOB_H

Seems like a #include of asm/ioctl.h (or something similar)
is needed so that _IOWR is defined.  Also, a #include
is needed for __u32, __aligned_u64, guid_t, etc.

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

