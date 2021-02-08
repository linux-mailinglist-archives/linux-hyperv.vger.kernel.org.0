Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12137313F66
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 20:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhBHTph (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 14:45:37 -0500
Received: from mail-dm6nam11on2095.outbound.protection.outlook.com ([40.107.223.95]:24769
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235258AbhBHTpL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 14:45:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8Pwi79Upd1fxsOLLDWsUmTsow9kuty2M32ulF2qHQ+GtDiRnTur8npgXmYJyjcxXdnPXN6S/+EaE62L6muLgUYfv+Y8XJHZKadJAnF8JRpkbF0rQmTz4uPDXmD5DYRpR1hDg8RsRk7AKIjIUpQhVcUcVJ5sTCwHnR3T9MZ98vgAgfNU0m7fIk43gpkxZ4YpinP0GDrZGnuSbzZnNUEFa0lAnw4OvIKGtaaQJnSMUCwM9h6n2TPA6tQ5nI4xZjChX+b+i3AiN3Zzcvyrfb9cr45KkuG62SWyoT09EhLpa86mCy5o3J0Yj65CwUTmkH4SlF+B2o3+0Ouon6BZC9ICCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuZLAEw7z7b/7m/pteLBwYkUxoYeNwmEyQonfUtOKsg=;
 b=PdwKymLJ07QzvO584b9Li4MHU7cbGEbWCgjED7lof0J80dN15GXHTJ8lutzHCyqsrnDMWLCuCAdZd8TZxYvvjQWjIieTKU9gPFoZLm2Wl/7QV4PsbkjtNLgg8gTjEBiIuTNH0t1P5WRibh9tequVfAEo0rvm8cNelbzCt3UoVy3qZZYOCnbCTwb4UGQR2KxGAnfq3wTcdx1nu1hqIh4ri5wgHCj9HqqijIuUouJcvJnIjD1NyLE0uYQ3wV57GdAwMDvZOZv0Zvln/eJeyzU/+IX41aqHd63gfjFBJkIIcFVuKcZchxoVrCbKOZ5nFEXOULARGW9LHgbgOmlwGxYKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuZLAEw7z7b/7m/pteLBwYkUxoYeNwmEyQonfUtOKsg=;
 b=Q/FgBFIEy0/4WVZnBj8JIHDt3khlW7nUJ4B88g9nZ01kUTSfIGr/jalfOAjd3U7qlHAa04xYlnnGLrGjSzOTujIpPKX2K9llHc14Mxs0suO3oy5TWZ2LdQ3NCqFKPg02fkf9OqzMl++If6OpNJCIgwaahNMD+7eiARBfai2Q6Pc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1890.namprd21.prod.outlook.com (2603:10b6:303:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Mon, 8 Feb
 2021 19:41:13 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:41:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [RFC PATCH 04/18] virt/mshv: request version ioctl
Thread-Topic: [RFC PATCH 04/18] virt/mshv: request version ioctl
Thread-Index: AQHWv52RAl2SZzIaIk+NQ9FoT6YK5qpPIQcg
Date:   Mon, 8 Feb 2021 19:41:13 +0000
Message-ID: <MWHPR21MB1593E77D2E079F123AC1766DD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:41:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fa42680f-05b8-4fb3-b004-5245b7985b1d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b998b418-f510-491e-b5b2-08d8cc697e45
x-ms-traffictypediagnostic: MW4PR21MB1890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18908B1E1AD1987F1C2A0FEBD78F9@MW4PR21MB1890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIVnX6KVg+BZOSnjZttFDEF/5fCHuFGBxj4OCTUNQIUmbbgx+2nEqDJ4RChXx3vZTUy4IHSOjsAZ5lPGAHKlBLVO8JTtugbsHhOs+rDo8GqRR0rdc7a4qWxTZbabpebtvS1iULbamD3ERFdKoPLHZat7gee565/oIxw0ZG2C/qzOXyv8FTMUZWI4cSByG4yRnX9XwAmLcq7J3MF59mb3rQArLforoEJllHkqXjKLcLv1oYMIWkt8pAf3e0C86HeWykxcv0aK0yyEOe0hjFhpwLs9fq35FLBTqo2Mlwi/EgSQ/tEXbabVpBuYQa7HeL5t3BqG2JdbCgN/WpFBRpfB5acbCKXfGqFHB3hs2hKlrBnmspMWODdpMsWN/UafkDjLzZ9oj/t0v/809fEXbocx8M13LWr6vlwqeqCs1Cdn/At80KA4vnPYlfWjqyGMa4EtIFCMttXN3UYGl3D1FvFf7cbCrbfqDr6M84y+4tH9Uk9DTXEGTOhFDyWzE4d4yB5bZizqBhpj8/OmxIKluWPMCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(66446008)(8990500004)(66476007)(64756008)(186003)(83380400001)(8936002)(66556008)(33656002)(478600001)(2906002)(66946007)(52536014)(82960400001)(76116006)(7696005)(5660300002)(316002)(82950400001)(8676002)(107886003)(9686003)(55016002)(6506007)(110136005)(26005)(71200400001)(4326008)(10290500003)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uSLt4lOZPEUOMePttFzRZu8bMwhiH1TmkCk4Jk097xiSjhsCPgR+BeR7MJpy?=
 =?us-ascii?Q?/Iqd58XOhJomCnG3izkCq4IKkx0XwsgAFIijcx4dCz8r22jN6h+Yx9cQBWCu?=
 =?us-ascii?Q?v2UjVYGku1Nv0lfJPkzG2PhQGujr2jBocHhTTZKb0eniSf3TEysfJfyQp+pr?=
 =?us-ascii?Q?LLQ7uOuWSLl6twqfpKweRZKFCy9JIqn7DdPwXcTKkwSP6R9Jj36Bbmh6qCwd?=
 =?us-ascii?Q?c5jdLKGKxh80sN6HhnY9erRSn+pgOk5ZyveriNnTDkfJiCiLUs0oxCE/MT1C?=
 =?us-ascii?Q?fGACEg331gaWk7DWEXbK0Vw7RKOTZArjGfFEr6g/+3lEAeD23bTeONF4mKZs?=
 =?us-ascii?Q?J1jEa5q5jtIeTNLIYRPINJj0YGWJyXtaZHbnP4qcSiW2RlaTNqaXz1uoVYLF?=
 =?us-ascii?Q?hJanZmlj1Jofit0POPoeyOHUv8uUCrNMvJbBSnZCUlSCTD+nd6Vag7WJGimo?=
 =?us-ascii?Q?3M4of4SDSZJmzM1/SLj++ZnhiaXor3k36TJqSBlNqU51/U6Ww5iksspX/g8u?=
 =?us-ascii?Q?ddVXSMFV3P0VhBpykTZGOqqXwP3bs4nAXVkeX8Wl3cbqxl0AgS/Ze5DdB9wL?=
 =?us-ascii?Q?Q7hj+VFZlgGeDjM1SEqGI67r+mCFKWsQnGphYJVw2il22x+ks3vudfB9V87F?=
 =?us-ascii?Q?7hcugTMKhu49mpinxfP2H3BBDpvt7D35DqzILA1utRpYwFFx6M1feC25kXgn?=
 =?us-ascii?Q?U5BuBo0R3TEhFbLf9wM+KZYB8umsdbZbPg4yn0q0liGLSJRf0TDAW6Il6h4A?=
 =?us-ascii?Q?3fmkJ8co5oYGA2GoiLnyYUFhfvSW08u3QyiNaO8uXICQa7LwRw86dZ1tqiRj?=
 =?us-ascii?Q?7W6b8DnruvUdpp6hTxlTcjmEWzNAQyPuHvGJX7ykGUv2myWW0ijMhs4/FVst?=
 =?us-ascii?Q?ZfUXO8Zf86KfGldkcgvqgaR0G8zLoiX4nvAZC2VDuYTAYreNJaBQBTvL5JfM?=
 =?us-ascii?Q?JJ981/nus8cECaK4VUspg9+1DpsZxG+xqKXFq6k+HPsT3lcsVy19S2UhlQyt?=
 =?us-ascii?Q?9Y17by1r7GJamf4DdfPAeRus4VvQdGC/qI9wR1PRZqsXgmXDuvpKypdYHs9y?=
 =?us-ascii?Q?DTm+onSfPyxImTWbnSw37vK+R2qb3YRBpebCSk2izRyszeIjtGMhXQirL1Fx?=
 =?us-ascii?Q?n9OdrdVIRJsHt3qlTWvGWJp8Ctwa7+SpN2DPYMRT18kpS3SbqG5Lk3+B8nxW?=
 =?us-ascii?Q?acJy+OJ1OdGmmUVqwWPYuMepF0Q0lqZvoQ06a792k3zuMTVy1NI6UwqNdbC3?=
 =?us-ascii?Q?NqTFTApkOBO009a3U/7T4SqakPdBDqavIR4Xv6tFu7JyfxfaNK7JYsKHpExL?=
 =?us-ascii?Q?KEHdW6hNy8LVYoJX4cCLdnyX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b998b418-f510-491e-b5b2-08d8cc697e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:41:13.4145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmALwRu//6egwi9IztWKJxnEgjdQZ/JsMqWXCtmICM84C8nF7GNQ3unGefR4c6puqFzS0n73Lc7VJESUob7IVV4PXsdFCbcu621UNGoxwDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1890
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Novem=
ber 20, 2020 4:30 PM
>=20
> Reserve ioctl number in userpsace-api/ioctl/ioctl-number.rst
> Introduce MSHV_REQUEST_VERSION ioctl.
> Introduce documentation for /dev/mshv in Documentation/virt/mshv
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  2 +
>  Documentation/virt/mshv/api.rst               | 62 +++++++++++++++++++
>  include/linux/mshv.h                          | 11 ++++
>  include/uapi/linux/mshv.h                     | 19 ++++++
>  virt/mshv/mshv_main.c                         | 49 +++++++++++++++
>  5 files changed, 143 insertions(+)
>  create mode 100644 Documentation/virt/mshv/api.rst
>  create mode 100644 include/linux/mshv.h
>  create mode 100644 include/uapi/linux/mshv.h
>=20
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 55a2d9b2ce33..13a4d3ecafca 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -343,6 +343,8 @@ Code  Seq#    Include File                           =
                Comments
>  0xB5  00-0F  uapi/linux/rpmsg.h                                      <ma=
ilto:linux-
> remoteproc@vger.kernel.org>
>  0xB6  all    linux/fpga-dfl.h
>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <ma=
ilto:linux-
> remoteproc@vger.kernel.org>
> +0xB8  all    uapi/linux/mshv.h                                       Mic=
rosoft Hypervisor root partition APIs
> +                                                                     <ma=
ilto:linux-hyperv@vger.kernel.org>
>  0xC0  00-0F  linux/usb/iowarrior.h
>  0xCA  00-0F  uapi/misc/cxl.h
>  0xCA  10-2F  uapi/misc/ocxl.h
> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/ap=
i.rst
> new file mode 100644
> index 000000000000..82e32de48d03
> --- /dev/null
> +++ b/Documentation/virt/mshv/api.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Microsoft Hypervisor Root Partition API Documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +1. Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document describes APIs for creating and managing guest virtual mac=
hines
> +when running Linux as the root partition on the Microsoft Hypervisor.
> +
> +This API is not yet stable.
> +
> +2. Glossary/Terms
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +hv
> +--
> +Short for Hyper-V. This name is used in the kernel to describe interface=
s to
> +the Microsoft Hypervisor.
> +
> +mshv
> +----
> +Short for Microsoft Hypervisor. This is the name of the userland API mod=
ule
> +described in this document.
> +
> +Partition
> +---------
> +A virtual machine running on the Microsoft Hypervisor.
> +
> +Root Partition
> +--------------
> +The partition that is created and assumes control when the machine boots=
. The
> +root partition can use mshv APIs to create guest partitions.
> +
> +3. API description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The module is named mshv and can be configured with CONFIG_HYPERV_ROOT_A=
PI.
> +
> +Mshv is file descriptor-based, following a similar pattern to KVM.
> +
> +To get a handle to the mshv driver, use open("/dev/mshv").
> +
> +3.1 MSHV_REQUEST_VERSION
> +------------------------
> +:Type: /dev/mshv ioctl
> +:Parameters: pointer to a u32
> +:Returns: 0 on success
> +
> +Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be ca=
lled to
> +establish the interface version with the kernel module.
> +
> +The caller should pass the MSHV_VERSION as an argument.
> +
> +The kernel module will check which interface versions it supports and re=
turn 0
> +if one of them matches.
> +
> +This /dev/mshv file descriptor will remain 'locked' to that version as l=
ong as
> +it is open - this ioctl can only be called once per open.

To clarify the wording:

The caller should pass the requested version as an argument.  If the reques=
ted
version is one that the kernel module supports, the ioctl will return 0.  I=
f the
requested version is not supported by the kernel module, the caller may try
the ioctl repeatedly to find a version that the caller supports and that th=
e kernel
module supports.   Once a match is found, the /dev/mshv file descriptor is
'locked' to that version as long as it is open; i.e., the ioctl can succeed
only once per open.

> +
> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
> new file mode 100644
> index 000000000000..a0982fe2c0b8
> --- /dev/null
> +++ b/include/linux/mshv.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LINUX_MSHV_H
> +#define _LINUX_MSHV_H
> +
> +/*
> + * Microsoft Hypervisor root partition driver for /dev/mshv
> + */
> +
> +#include <uapi/linux/mshv.h>
> +
> +#endif
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> new file mode 100644
> index 000000000000..dd30fc2f0a80
> --- /dev/null
> +++ b/include/uapi/linux/mshv.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_MSHV_H
> +#define _UAPI_LINUX_MSHV_H
> +
> +/*
> + * Userspace interface for /dev/mshv
> + * Microsoft Hypervisor root partition APIs
> + */
> +
> +#include <linux/types.h>
> +
> +#define MSHV_VERSION	0x0
> +
> +#define MSHV_IOCTL 0xB8
> +
> +/* mshv device */
> +#define MSHV_REQUEST_VERSION	_IOW(MSHV_IOCTL, 0x00, __u32)
> +
> +#endif
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index ecb9089761fe..62f631f85301 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -11,25 +11,74 @@
>  #include <linux/module.h>
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
> +#include <linux/slab.h>
> +#include <linux/mshv.h>
>=20
>  MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>=20
> +#define MSHV_INVALID_VERSION	0xFFFFFFFF
> +#define MSHV_CURRENT_VERSION	MSHV_VERSION
> +
> +static u32 supported_versions[] =3D {
> +	MSHV_CURRENT_VERSION,
> +};

I'm not sure that the concept of "CURRENT_VERSION" makes sense
as a fixed constant.  We have an array of supported versions, any of
which are valid and supported by the kernel module.   The array
should list individual versions.   The current version is 0, which=20
might be labelled as MSHV_VERSION_PRERELEASE, or something
similar.  Then later we might have MSHV_VERSION_RELEASE_1,
HSMV_VERSION_RELEASE_2, as needed.  Or maybe the versions
are tied to releases of the Microsoft Hypervisor.

> +
> +static long
> +mshv_ioctl_request_version(u32 *version, void __user *user_arg)
> +{
> +	u32 arg;
> +	int i;
> +
> +	if (copy_from_user(&arg, user_arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(supported_versions); ++i) {
> +		if (supported_versions[i] =3D=3D arg) {
> +			*version =3D supported_versions[i];
> +			return 0;
> +		}
> +	}
> +	return -ENOTSUPP;
> +}
> +
>  static long
>  mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  {
> +	u32 *version =3D (u32 *)filp->private_data;
> +
> +	if (ioctl =3D=3D MSHV_REQUEST_VERSION) {
> +		/* Version can only be set once */
> +		if (*version !=3D MSHV_INVALID_VERSION)
> +			return -EBADFD;
> +
> +		return mshv_ioctl_request_version(version, (void __user *)arg);
> +	}
> +
> +	/* Version must be set before other ioctls can be called */
> +	if (*version =3D=3D MSHV_INVALID_VERSION)
> +		return -EBADFD;
> +
> +	/* TODO other ioctls */
> +
>  	return -ENOTTY;
>  }
>=20
>  static int
>  mshv_dev_open(struct inode *inode, struct file *filp)
>  {
> +	filp->private_data =3D kmalloc(sizeof(u32), GFP_KERNEL);
> +	if (!filp->private_data)
> +		return -ENOMEM;
> +	*(u32 *)filp->private_data =3D MSHV_INVALID_VERSION;
> +
>  	return 0;
>  }
>=20
>  static int
>  mshv_dev_release(struct inode *inode, struct file *filp)
>  {
> +	kfree(filp->private_data);
>  	return 0;
>  }
>=20
> --
> 2.25.1

