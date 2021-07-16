Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05E3CBA2D
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 17:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhGPP7U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 11:59:20 -0400
Received: from mail-bn7nam10on2093.outbound.protection.outlook.com ([40.107.92.93]:35040
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240672AbhGPP7N (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 11:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuQDrdzbBarxz3HFjsgQgSnaihYWXZYnW7z4iUSa6uSen3LbpxVOMEvSv07aEq8vg7ffs92QMa8h5LVNCRkeijx/x/KKkZXXiOYNNH6OzwfG7whNkTYvpC0Jw+dZ+9S7XPu9JddiM52IddP2uafGJUBKGtZNqccCPKw4wSUR0r+bcTYabY0qjjeqJYTnb4thh+9Q39FfryKgbuxMxga3ty7T9iEhvg/cSMsRjGxKzoMr0ufQE7EeS+xC1hjO3E8Y7P2eSLYMieyicoSbcu0cNw2N5QofO/infz07KFnb9ob0fb+5fJj4ikZftKCiP4Ifmmy8Vmr+WYOcKEe8D/+iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arMJW2+Zxt4tzV6h7HRaNEcTSfvdLfWB9wfeAOrgaII=;
 b=Le5cRIXmtOYLnGYS9l11djItjsy9qDZ+qC02UGFOeIhw0+/C9g0gdVn5mHtS2wk+bV6FP+O9ziwKtypolWI89aLJTk9o44Gd5vB8xAiAjK9I5LVIptGmFj1JdI6w4NiO+wBCgu0VAKaY4xoNb9JDHzw2WNlVSrRpSR6OMjHtp2wFtQdZ2bGfGylcArmFHduC+76Lf3HkI4DEz5pqLiVZJk0hbT9+4Mu+3UvkeUfBWGjdie+Vgl35l9Nl9ChKqayK0FP9lj2M9DiT7CQZwIS/i2cDjCBD2fUPujJlm1BBkiD9lEv0l+Oid5jBHD0gfv6lEwk0RtvQ2D3bL+MKNnPuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arMJW2+Zxt4tzV6h7HRaNEcTSfvdLfWB9wfeAOrgaII=;
 b=RTUAe+T/+YwjDYcV0CIh/sMXKhiLnxW/It09faUVDfSbp5KbSSgqzCEL1+2h1wmMqtN5MMACBabQmtC0p43TugKZHRVotH6/LJsEE2heg3VxO1StVOeBQF767SOI/HvxN8CAel/zZL/Yp4+HD2z+XVxcyUzLc4OqkBqTwQ0/k2k=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0864.namprd21.prod.outlook.com (2603:10b6:300:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4; Fri, 16 Jul
 2021 15:56:14 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.021; Fri, 16 Jul 2021
 15:56:14 +0000
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
Subject: RE: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXeFpYCjxW1LHgzk+I9msc1XWXVqtFsSrA
Date:   Fri, 16 Jul 2021 15:56:14 +0000
Message-ID: <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=637f0e51-bd6a-4fba-b81c-288709d0b198;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-16T14:43:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 852590ff-e972-466d-24b3-08d948723d8c
x-ms-traffictypediagnostic: MWHPR21MB0864:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB08646BFBE93493ECED2C2C74D7119@MWHPR21MB0864.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utYOmpOYjM/4dAbMSxQs4h3NCvg9aGWjYxcpmwk5By9brOFu2bSvjJYbzWK573Jw7W26NscxH3EF2M/FNKnA9Cdo+uXJXVauI6QXWyFKejrm+DDjnDDzz8arygx++Qe2kf60AW/rjPqnkup8C22Upvy6nq/vxMp4ior6vVTWeabgA/mx+/LGfLPTAP6czGqF83j6W3uFL0Mqig8NSeuQcgoRW4BnnGPu7wkXNg6nF7dA+OtNpfsLLyWxHHmxD+zB8XZEhxq5DHANaw9Kan62QJ4y4gCbeygHkYp8J/NQ0qEmOUzfZN2pcGuPiSQVlYyfqvR4O0SncW7vqLySeVORAoQFjDXu12Ul5UGqj3BQ7tYfw4YHk/RkE5cZPj5Vz7aL9yo1Nv6TAW7h1N7J3GTTht4FaVLJr3DzRIEoWFcYEgarvUhVZG72QFwd/kkO2VekIiKSUPGLQQ5Ww8UCnvpZUUBaCN0GV5v0aTlFBbR1TACfH7iNJzLRxUaovSGCD4SU6ytg0HFFTPPpSuFL0UdPZ0i+37SR/2PRzMJB/M/rRrKX0L80rjSkhpMgU1pHCfxZya9pmG/SKPhSAWRagBWs3/lwVgpj3Q8ERPqegJE+MrQZD2rllsmx/SkPXCzZFRmUnTGVKMu8X+sObKXxfKqIy3OYSxWG1iVop08CJAVlBQcoMvmf07YHsu7NnxccMpEz6qbt2uZjceXR2utOdc1nHixwtVju6L4Vdu4IR2prck1NVb1rK9g7Ka+b60oHZ0IOaFm3rb2h/UBJZsgjSj77DaUfwn3ahs/YzL8O4rEzcdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(110136005)(30864003)(5660300002)(38100700002)(71200400001)(55016002)(316002)(26005)(186003)(10290500003)(508600001)(8990500004)(8676002)(52536014)(4326008)(83380400001)(86362001)(66446008)(64756008)(82950400001)(82960400001)(122000001)(66476007)(66556008)(66946007)(9686003)(76116006)(54906003)(2906002)(6506007)(7416002)(33656002)(7696005)(38070700004)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SIVVz2JELPj607KZTbMjdm2d+e85hetR93wR0jhELBZhvHHXJOPgWSjGfGVh?=
 =?us-ascii?Q?cx1yOhup69N3NHxsM4tS2AjaaRiPz366SDlTIfUCIlXloreF8rlXG2+0K9M9?=
 =?us-ascii?Q?ACL5c4HC/gjGuIfBRTi0cwbEk3YkpAoZ+fqfKROkV3z8hR5NC027IMqi6cMk?=
 =?us-ascii?Q?6F9xW7TkkmTPUQtsHrDVWk0N44fhGFjkNoNQ9BNPK6LK7ixevQNYxmgvYAYT?=
 =?us-ascii?Q?qazHeg+mZ2zckXGaAMbVt+RllBr08DRhLOnmFRHCWz8QZWefGKpLeSNdsSaM?=
 =?us-ascii?Q?olzHp8mxvt/cEolN7TqOl/cyVcot3BxnLGDw7uCLhZQM1XOKmq7EIHgSYRL8?=
 =?us-ascii?Q?euec+7rdpKtINrNVJHKBq24H0fHakcARdPaH8je6R8Ns3aFUZwz1vhH742zj?=
 =?us-ascii?Q?re/pmy3aHuwcBe71yYcu9o1aEsrD4CUz/Ut6L2bpSuJKtq5kU0qUy13HptLy?=
 =?us-ascii?Q?3Ej/4ebZMpofjziqGzzG+5Gg5WLaT+vUAWJgGYka87spwPcmb8zYxlJvGhkp?=
 =?us-ascii?Q?/5ZKXMGl5nj6a45qHMUH8/YubMT3VYIukdh7K6ZKYZjnSoQaq9ovend5cjEj?=
 =?us-ascii?Q?uufVvJMTCKG3Tr582lSQykc+fDjujX/YHyQ4wSuMQLpu5eyBQGfWLhVQtLGp?=
 =?us-ascii?Q?FxdEj+gwkqjeP6Jhg2ZvXnU7gUmMnxWF0ZexD8QNe4dr+OOQYmgNNqZkuGAC?=
 =?us-ascii?Q?xnvO6TY5bDJXGxfHxn+ZEA2MgvkO9b97yFgNLaFXD+vizHW4+2eAghiDnYPX?=
 =?us-ascii?Q?rrTzGNWXsYH+deq4DXN+9m4aOJtZMTFhwE/pwtAUppEhqeB4Ea0uJ4xi2Ci+?=
 =?us-ascii?Q?McsUb63iEnnHP7OMeiEShj4PzLqVwzWyKSPYg2+isiVhW0ThGZGXl/WQNUZy?=
 =?us-ascii?Q?K46/S7IEQnGDtIucHPv/76OMhXG2f5KCNU6v4A6B4DqrGuK48Wj/be1jie3c?=
 =?us-ascii?Q?duHoHuk9c007ezDRS+36t7Ew2M6An+gwF0ReyRogiaqhEppqbokIrck2Srh9?=
 =?us-ascii?Q?gitAWuoQBsyeKiV07N/4gpZ04ygsYpO7Iqrj8h9ZfDejaTZYeXYRjaKI1jhp?=
 =?us-ascii?Q?nAireqkvMgcXBrPRJs42Fb94Lb2JyYnHd2xRFgEyXfsHLg8U1NvaEohS9DTn?=
 =?us-ascii?Q?xcPF0Cwb2cAhQbGAirWiTn2OzD7fgdhWOYjZU7qXrwcWO1nOM4YGsve7UjJd?=
 =?us-ascii?Q?mJtIlk2IYLnMa4ctFYZ6OydPKvs+MOXPv1g73GYe5MkdNVS1E8GwMZjjv95i?=
 =?us-ascii?Q?2B59BlXH2AVxlrVYCEOJMHKp3xZa25QBbXq4trwrqDylTZ6yXpycr+pOq/yL?=
 =?us-ascii?Q?GyMYXAdgiAWir8O9UrSK4g1Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852590ff-e972-466d-24b3-08d948723d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 15:56:14.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6oIf7N9i1MMvQQ4qqR8YYWS+orlprlhsQON3y2jJG+tZQusnv8K4pb6RDhrPT17ZJTWyHLXGB1bNPjG0BlopPypwMlUVMhNjF8nVotBPmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0864
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Tuesday, Ju=
ly 13, 2021 7:45 PM
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
> This driver will be ported to FreeBSD. It's dual licensed for BSD and GPL=
.
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
>  drivers/hv/azure_blob.c                            | 625 +++++++++++++++=
++++++
>  drivers/hv/channel_mgmt.c                          |   7 +
>  include/linux/hyperv.h                             |   9 +
>  include/uapi/misc/azure_blob.h                     |  34 ++
>  7 files changed, 688 insertions(+)
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
> index 0000000..5367d5e
> --- /dev/null
> +++ b/drivers/hv/azure_blob.c
> @@ -0,0 +1,625 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH Linux-sysc=
all-note
> +/* Copyright (c) Microsoft Corporation. */
> +
> +#include <uapi/misc/azure_blob.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/cred.h>
> +#include <linux/debugfs.h>
> +#include <linux/pagemap.h>
> +#include <linux/hyperv.h>
> +#include <linux/miscdevice.h>
> +#include <linux/uio.h>
> +
> +struct az_blob_device {
> +	struct hv_device *device;
> +
> +	/* Opened files maintained by this device */
> +	struct list_head file_list;
> +	/* Lock for protecting file_list */
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
> +	/* Lock for protecting vsp_pending_requests */
> +	spinlock_t vsp_pending_lock;
> +	wait_queue_head_t wait_vsp_pending;
> +};
> +
> +/* The maximum number of pages we can pass to VSP in a single packet */
> +#define AZ_BLOB_MAX_PAGES 8192
> +
> +/* The one and only one */
> +static struct az_blob_device az_blob_dev;
> +
> +/* Ring buffer size in bytes */
> +#define AZ_BLOB_RING_SIZE (128 * 1024)
> +
> +/* System wide device queue depth */
> +#define AZ_BLOB_QUEUE_DEPTH 1024
> +
> +static const struct hv_vmbus_device_id id_table[] =3D {
> +	{ HV_AZURE_BLOB_GUID,
> +	  .driver_data =3D 0
> +	},
> +	{ },
> +};
> +
> +#define az_blob_dbg(fmt, args...) dev_dbg(&az_blob_dev.device->device, f=
mt, ##args)
> +#define az_blob_info(fmt, args...) dev_info(&az_blob_dev.device->device,=
 fmt, ##args)
> +#define az_blob_warn(fmt, args...) dev_warn(&az_blob_dev.device->device,=
 fmt, ##args)
> +#define az_blob_err(fmt, args...) dev_err(&az_blob_dev.device->device, f=
mt, ##args)
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
> +						  desc->trans_id);
> +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> +			az_blob_err("incorrect transaction id %llu\n",
> +				    desc->trans_id);
> +			continue;
> +		}
> +		request_ctx =3D (struct az_blob_vsp_request_ctx *)cmd_rqst;
> +		response =3D hv_pkt_data(desc);
> +
> +		az_blob_dbg("got response for request %pUb status %u "
> +			    "response_len %u\n",
> +			    &request_ctx->request->guid, response->error,
> +			    response->response_len);
> +		request_ctx->request->response.status =3D response->error;
> +		request_ctx->request->response.response_len =3D
> +			response->response_len;
> +		complete(&request_ctx->wait_vsp);
> +	}
> +}
> +
> +static int az_blob_fop_open(struct inode *inode, struct file *file)
> +{
> +	struct az_blob_file_ctx *file_ctx;
> +	unsigned long flags;
> +
> +	file_ctx =3D kzalloc(sizeof(*file_ctx), GFP_KERNEL);
> +	if (!file_ctx)
> +		return -ENOMEM;
> +
> +	rcu_read_lock();
> +
> +	if (az_blob_dev.removing) {
> +		rcu_read_unlock();
> +		kfree(file_ctx);
> +		return -ENODEV;
> +	}
> +
> +	INIT_LIST_HEAD(&file_ctx->vsp_pending_requests);
> +	init_waitqueue_head(&file_ctx->wait_vsp_pending);
> +	spin_lock_init(&file_ctx->vsp_pending_lock);
> +	file->private_data =3D file_ctx;
> +
> +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> +	list_add_tail(&file_ctx->list, &az_blob_dev.file_list);
> +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);

I would think that this function is never called with interrupts
disabled, so the simpler spin_lock()/spin_unlock() functions
could be used.

> +
> +	rcu_read_unlock();
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
> +		   list_empty(&file_ctx->vsp_pending_requests));
> +
> +	spin_lock_irqsave(&az_blob_dev.file_lock, flags);
> +	list_del(&file_ctx->list);
> +	if (list_empty(&az_blob_dev.file_list))
> +		wake_up(&az_blob_dev.file_wait);
> +	spin_unlock_irqrestore(&az_blob_dev.file_lock, flags);

I would think that this function is never called with interrupts
disabled, so the simpler spin_lock()/spin_unlock() functions
could be used.

> +
> +	kfree(file_ctx);
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
> +			    struct page ***ppages, size_t *start,
> +			    size_t *num_pages)
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
> +		    iter.type, iter.iov_offset, iter.count, iter.nr_segs);
> +
> +	result =3D iov_iter_get_pages_alloc(&iter, &pages, buffer_len, start);
> +	if (result < 0) {
> +		az_blob_dbg("failed to pin user pages result=3D%ld\n", result);
> +		return result;
> +	}
> +	if (result !=3D buffer_len) {
> +		az_blob_dbg("can't pin user pages requested %d got %ld\n",
> +			    buffer_len, result);
> +		return -EFAULT;
> +	}
> +
> +	*ppages =3D pages;
> +	*num_pages =3D (result + *start + PAGE_SIZE - 1) / PAGE_SIZE;
> +	return 0;
> +}
> +
> +static void fill_in_page_buffer(u64 *pfn_array, int *index,
> +				struct page **pages, unsigned long num_pages)
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
> +	struct az_blob_request_sync __user *request_user =3D
> +		(struct az_blob_request_sync __user *)arg;
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
> +			    " opening file descriptor\n",
> +			    task_tgid_vnr(current), current->comm);
> +		return -EACCES;
> +	}
> +
> +	if (copy_from_user(&request, request_user, sizeof(request))) {
> +		az_blob_dbg("don't have permission to user provided buffer\n");
> +		return -EFAULT;
> +	}
> +
> +	az_blob_dbg("az_blob ioctl request guid %pUb timeout %u request_len %u"
> +		    " response_len %u data_len %u request_buffer %llx "
> +		    "response_buffer %llx data_buffer %llx\n",
> +		    &request.guid, request.timeout, request.request_len,
> +		    request.response_len, request.data_len, request.request_buffer,
> +		    request.response_buffer, request.data_buffer);
> +
> +	if (!request.request_len || !request.response_len)
> +		return -EINVAL;
> +
> +	if (request.data_len && request.data_len < request.data_valid)
> +		return -EINVAL;
> +
> +	if (request.data_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
> +	    request.request_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES ||
> +	    request.response_len > PAGE_SIZE * AZ_BLOB_MAX_PAGES)
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
> +	ret =3D get_buffer_pages(READ, (void __user *)request.request_buffer,
> +			       request.request_len, &request_pages,
> +			       &request_start, &request_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	ret =3D get_buffer_pages(READ, (void __user *)request.response_buffer,
> +			       request.response_len, &response_pages,
> +			       &response_start, &response_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	if (request.data_len) {
> +		ret =3D get_buffer_pages(READ,
> +				       (void __user *)request.data_buffer,
> +				       request.data_len, &data_pages,
> +				       &data_start, &data_num_pages);
> +		if (ret)
> +			goto get_user_page_failed;
> +	}
> +
> +	total_num_pages =3D request_num_pages + response_num_pages +
> +				data_num_pages;
> +	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
> +		az_blob_dbg("number of DMA pages %lu buffer exceeding %u\n",
> +			    total_num_pages, AZ_BLOB_MAX_PAGES);
> +		ret =3D -EINVAL;
> +		goto get_user_page_failed;
> +	}
> +
> +	/* Construct a VMBUS packet and send it over to VSP */
> +	desc_size =3D struct_size(desc, range.pfn_array, total_num_pages);
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
> +	pfn_array =3D desc->range.pfn_array;
> +	page_idx =3D 0;
> +
> +	if (request.data_len) {
> +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> +				    data_num_pages);
> +		vsp_request->data_buffer_offset =3D data_start;
> +		vsp_request->data_buffer_length =3D request.data_len;
> +		vsp_request->data_buffer_valid =3D request.data_valid;
> +	}
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> +			    request_num_pages);
> +	vsp_request->request_buffer_offset =3D request_start +
> +						data_num_pages * PAGE_SIZE;
> +	vsp_request->request_buffer_length =3D request.request_len;
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> +			    response_num_pages);
> +	vsp_request->response_buffer_offset =3D response_start +
> +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> +	vsp_request->response_buffer_length =3D request.response_len;
> +
> +	vsp_request->version =3D 0;
> +	vsp_request->timeout_ms =3D request.timeout;
> +	vsp_request->operation_type =3D AZ_BLOB_DRIVER_USER_REQUEST;
> +	guid_copy(&vsp_request->transaction_id, &request.guid);
> +
> +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> +	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
> +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);

I would think that this function is never called with interrupts
disabled, so the simpler spin_lock()/spin_unlock() functions
could be used.

> +
> +	az_blob_dbg("sending request to VSP\n");
> +	az_blob_dbg("desc_size %u desc->range.len %u desc->range.offset %u\n",
> +		    desc_size, desc->range.len, desc->range.offset);
> +	az_blob_dbg("vsp_request data_buffer_offset %u data_buffer_length %u "
> +		    "data_buffer_valid %u request_buffer_offset %u "
> +		    "request_buffer_length %u response_buffer_offset %u "
> +		    "response_buffer_length %u\n",
> +		    vsp_request->data_buffer_offset,
> +		    vsp_request->data_buffer_length,
> +		    vsp_request->data_buffer_valid,
> +		    vsp_request->request_buffer_offset,
> +		    vsp_request->request_buffer_length,
> +		    vsp_request->response_buffer_offset,
> +		    vsp_request->response_buffer_length);
> +
> +	ret =3D vmbus_sendpacket_mpb_desc(dev->device->channel, desc, desc_size=
,
> +					vsp_request, sizeof(*vsp_request),
> +					(u64)&request_ctx);
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
> +	if (copy_to_user(&request_user->response, &request.response,
> +			 sizeof(request.response)))
> +		ret =3D -EFAULT;
> +
> +vmbus_send_failed:
> +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> +	list_del(&request_ctx.list);
> +	if (list_empty(&file_ctx->vsp_pending_requests))
> +		wake_up(&file_ctx->wait_vsp_pending);
> +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);

I would think that this function is never called with interrupts
disabled, so the simpler spin_lock()/spin_unlock() functions
could be used.

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
> +			      unsigned long arg)
> +{
> +	switch (cmd) {
> +	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
> +		return az_blob_ioctl_user_request(filp, arg);
> +
> +	default:
> +		az_blob_dbg("unrecognized IOCTL code %u\n", cmd);
> +	}
> +
> +	return -EINVAL;
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
> +				    &file_ctx->vsp_pending_requests, list) {
> +			seq_printf(m, "%pUb ", &request_ctx->request->guid);
> +			seq_printf(m, "%u ", request_ctx->request->request_len);
> +			seq_printf(m, "%u ",
> +				   request_ctx->request->response_len);
> +			seq_printf(m, "%u ", request_ctx->request->data_len);
> +			seq_printf(m, "%llx ",
> +				   request_ctx->request->request_buffer);
> +			seq_printf(m, "%llx ",
> +				   request_ctx->request->response_buffer);
> +			seq_printf(m, "%llx\n",
> +				   request_ctx->request->data_buffer);
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
> +static void az_blob_remove_device(void)
> +{
> +	struct dentry *debugfs_root =3D debugfs_lookup("az_blob", NULL);
> +
> +	misc_deregister(&az_blob_misc_device);
> +	debugfs_remove_recursive(debugfs_lookup("pending_requests",
> +						debugfs_root));
> +	debugfs_remove_recursive(debugfs_root);
> +	/* At this point, we won't get any requests from user-mode */
> +}
> +
> +static int az_blob_create_device(struct az_blob_device *dev)
> +{
> +	int ret;
> +	struct dentry *debugfs_root;
> +
> +	ret =3D misc_register(&az_blob_misc_device);
> +	if (ret)
> +		return ret;
> +
> +	debugfs_root =3D debugfs_create_dir("az_blob", NULL);
> +	debugfs_create_file("pending_requests", 0400, debugfs_root, NULL,
> +			    &az_blob_debugfs_fops);
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
> +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> +	init_waitqueue_head(&az_blob_dev.file_wait);
> +
> +	az_blob_dev.device =3D device;
> +	device->channel->rqstor_size =3D AZ_BLOB_QUEUE_DEPTH;
> +
> +	ret =3D vmbus_open(device->channel, ring_size, ring_size, NULL, 0,
> +			 az_blob_on_channel_callback, device->channel);
> +
> +	if (ret)
> +		return ret;
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
> +			 const struct hv_vmbus_device_id *dev_id)
> +{
> +	int ret;
> +
> +	ret =3D az_blob_connect_to_vsp(device, AZ_BLOB_RING_SIZE);
> +	if (ret) {
> +		az_blob_err("error connecting to VSP ret=3D%d\n", ret);
> +		return ret;
> +	}
> +
> +	// create user-mode client library facing device
> +	ret =3D az_blob_create_device(&az_blob_dev);
> +	if (ret) {
> +		az_blob_err("failed to create device ret=3D%d\n", ret);
> +		az_blob_remove_vmbus(device);
> +		return ret;
> +	}
> +
> +	az_blob_dev.removing =3D false;

This line seems misplaced.  As soon as az_blob_create_device()
returns, some other thread could find the device and open it.  You
don't want the az_blob_fop_open() function to find the "removing"
flag set to true.  So I think this line should go *before* the call to
az_blob_create_device().

> +	az_blob_info("successfully probed device\n");
> +
> +	return 0;
> +}
> +
> +static int az_blob_remove(struct hv_device *dev)
> +{
> +	az_blob_dev.removing =3D true;
> +	/*
> +	 * RCU lock guarantees that any future calls to az_blob_fop_open()
> +	 * can not use device resources while the inode reference of
> +	 * /dev/azure_blob is being held for that open, and device file is
> +	 * being removed from /dev.
> +	 */
> +	synchronize_rcu();

I don't think this works as you have described.  While it will ensure that
any in-progress RCU read-side critical sections have completed (i.e.,
in az_blob_fop_open() ), it does not prevent new read-side critical section=
s
from being started.  So as soon as synchronize_rcu() is finished, another
thread could find and open the device, and be executing in
az_blob_fop_open().

But it's not clear to me that this (and the rcu_read_locks in az_blob_fop_o=
pen)
are really needed anyway.  If az_blob_remove_device() is called while one o=
r more
threads have it open, I think that's OK.  Or is there a scenario that I'm m=
issing?

> +
> +	az_blob_info("removing device\n");
> +	az_blob_remove_device();
> +
> +	/*
> +	 * At this point, it's not possible to open more files.
> +	 * Wait for all the opened files to be released.
> +	 */
> +	wait_event(az_blob_dev.file_wait, list_empty(&az_blob_dev.file_list));

As mentioned in my most recent comments on the previous version of the
code, I'm concerned about waiting for all open files to be released in the =
case
of a VMbus rescind.  We definitely have to wait for all VSP operations to
complete, but that's different from waiting for the files to be closed.  Th=
e former
depends on Hyper-V being well-behaved and will presumably happen quickly
in the case of a rescind.  But the latter depends entirely on user space co=
de
that is out of the kernel's control.  The user space process could hang aro=
und
for hours or days with the file still open, which would block this function
from completing, and hence block the global work queue.

Thinking about this, the core issue may be that having a single static
instance of az_blob_device is problematic if we allow the device to be
removed (either explicitly with an unbind, or implicitly with a VMbus
rescind) and then re-added.  Perhaps what needs to happen is that
the removed device is allowed to continue to exist as long as user
space processes have an open file handle, but they can't perform
any operations because the "removing" flag is set (and stays set).
If the device is re-added, then a new instance of az_blob_device
should be created, and whether or not the old instance is still
hanging around is irrelevant.

> +
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
> +	return vmbus_driver_register(&az_blob_drv);
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
> index 705e95d..3095611 100644
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
> index 0000000..f4168679
> --- /dev/null
> +++ b/include/uapi/misc/azure_blob.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only WITH Linux-sysc=
all-note */
> +/* Copyright (c) Microsoft Corporation. */
> +
> +#ifndef _AZ_BLOB_H
> +#define _AZ_BLOB_H
> +
> +#include <linux/kernel.h>
> +#include <linux/uuid.h>
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

Is there an implied 32-bit padding field before "request_buffer"?
It seems like "yes", since there are five 32-bit field preceding.
Would it be better to explicitly list that padding field?

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

