Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F6313F71
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 20:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhBHTrI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 14:47:08 -0500
Received: from mail-dm6nam08on2114.outbound.protection.outlook.com ([40.107.102.114]:13653
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236435AbhBHTqy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 14:46:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9Px6HSKZVTWVU0D49vHc6YxBEnJwD8tnFDFztZysbzioJGu6JeCeHlKSjBrnHJwgvGduo1UTir4KEa1oSQPwt2tNik4CQCQqQFmkIepraOPQFnD1C/vdbridWydeS0fuuQnAh4jsw+duCJhkxuLIrBks1amfVSwXZidEPBUQzqoBSf5Y6mRbfY3H4MKqGWCKcL6mXBCh4G7jB75K3g4s0hfEcwPcQbx7d11EZu9qSsbGqSzSS4LZInAywPBPmVHwWZBD3MSvnoybkyHogO67byy1yRVvgOmv1HfbrFMai2HllE6YmdMMU5MLnDg4i2R8LiJv4mmuK9s6U2G7B7v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPQTM745DyN6sRKFcrC9o1AP8irCe3bvIixXu7HxRnU=;
 b=JGK/MCtKGismBS4Tw2qxxU/IlxoKRXLPDyUegvE/Pv/QjHoYYoYr5K4n5muy2pSczaLihHupKVmRSQHdaY4se6skCHPtFGzw51u/QzYmo+lAV9dGjW1xappBP/n8lV73vDDwALVESg7kN7cDDikSpiOf1qC+8vtVNLcGGaHnjL68/UmMHTigfESkGP8wyru7SWPglj7G0DdonOq99VUTGDCh5XE+tP34kaLD+Thfiq2TAlKX9JrXtHRK/jFLp/KyNrU5lv4z0U7vJ+E255MpqVWuM+0YZVYBDUOH0Qq7CxwsNb1T1FPtDdrzKEIoxntr+eV1etkNvWGOCXgVS4T7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPQTM745DyN6sRKFcrC9o1AP8irCe3bvIixXu7HxRnU=;
 b=bhIQpGtK/jWK9hhTPgNzKrePfVoupm1v8im/YXzzLSsv5LWs9EkloQevMN/JIJLWn6QgZY4F/+piWqQffzKkK4ZazwS96WhH/js4pBla3NNfoz6CbNhbRXfqUiqYW7WmjZ6uniOCKtFkcpi0fmZYzdieyJHvysgAXvuy6Kw++NU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Mon, 8 Feb
 2021 19:45:57 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:45:57 +0000
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
Subject: RE: [RFC PATCH 08/18] virt/mshv: map and unmap guest memory
Thread-Topic: [RFC PATCH 08/18] virt/mshv: map and unmap guest memory
Thread-Index: AQHWv52Toe1LRVK2KUqT7h/r2T7yX6pMTc3A
Date:   Mon, 8 Feb 2021 19:45:57 +0000
Message-ID: <MWHPR21MB1593A5DAB7387BDF58B99056D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-9-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-9-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:45:54Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=55aebd9e-65d8-4140-ae75-44682b67777f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41b29b36-0162-4750-e4cf-08d8cc6a27ce
x-ms-traffictypediagnostic: MWHPR21MB1546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB1546414E8E4A7DC73B2B1EC7D78F9@MWHPR21MB1546.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRS32afZqn0lZF1Ai5Fl98e/b6vzq+uDYBfa698Ai9eAim6QuWqNnDTfCMQS/0WW1y+17X+PdIeNqYm3LcfVDYYQRLzIWpCdojExWi9I64jckv8kSuhAa/Qp9lhBIKhGYkEFHDjkkdhq9XBx9QY9NFGkjaT8VFwhvnVeUw+jYRdQDMlA4EyNxLz9Upp/sqpQtmLEcMhbNxhfp9XEagBqjSCuPOSBR62Vj7aRNJ8umZGKhcdgCTiuHWUfG0VlnvB3zKjlS0K/LbN7mEUk71Wn+AJEELbEO3GvOeaXw6rO0TZIFk0gmd1RLEPmibqZD9HlmOrht9EY3foyS5JxhVB1siOQ4PPAgfKb3DxX5OVS9qdnktiRjPA4N8Rw4MPoCfCL12BLMvKdTskxBzWgr77RikIolUvBmGNxYv20HpJ2tEM0aRcZI/RcHFhLfatd4ZXmcIGZHxearl3OZI6Ii0/tYwTaSoH4E1tO1mr+CjbwHp1rFdShSWMx3RbYDd1cHEz1rc2XURhbuzblfKo79UI8MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(7696005)(30864003)(64756008)(76116006)(6506007)(83380400001)(82960400001)(10290500003)(66446008)(66556008)(86362001)(4326008)(66946007)(54906003)(110136005)(107886003)(8676002)(5660300002)(33656002)(8936002)(2906002)(26005)(316002)(66476007)(186003)(52536014)(478600001)(8990500004)(71200400001)(82950400001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Usov8e6gKVDvEyPUY2lyprB1gZK9gBmRG+TbEWP1Gsbu6ofKWS3Hyl1i46xJ?=
 =?us-ascii?Q?TvisGxVy6fMdzXQ8Lr07/N9TKnxlm24r56JFfuyqC/AHARouiEjVofZs5rnV?=
 =?us-ascii?Q?eIWEEABX+CMezxnBKOqEjLN7aYwZF+WWPBmOIg+v0FxZwHMdgMHwZY9MivHM?=
 =?us-ascii?Q?vt0rDjsyc2gXrqhtvaeEmKzM6sCnOc8A1LqB26M5mIkmkZiZL+kd4X+YgpSN?=
 =?us-ascii?Q?s201oDuf7ToKKSJJ/k3+1DsqEMnKfflGmHs0ybbsIJ8YSG5Ufz+2iN/Zy1Df?=
 =?us-ascii?Q?h+SAU0qoEQbvKXOcQc/5U2oWHNS7HIFE//Oy1/GMxBL/G9IPVpaO9tiktJD3?=
 =?us-ascii?Q?8sxOcyJ7saoLJQ4Fb75v1zci6xCp0JP+2FxQTJh9MtS/Xle62sXuvB9+ber2?=
 =?us-ascii?Q?f6+F6tg5DuUjNj5fikEcKWdK3zK03RR0aezdmfyuJnlrDltfawL4DDPWbR2Y?=
 =?us-ascii?Q?UDfYCBrx5dGCAI0eys40tfrarf7inXX/Vlt4hUFuFh4dSY3f5DTC35djbV/M?=
 =?us-ascii?Q?LBWfm781sQ8SDdvLZOcW0sdnj4nZFBBYEkzqUoQX+Q/LNEBbFQZK5J1ku+Km?=
 =?us-ascii?Q?mAeWdCAP57F0a2opmmScPvM74L3dapK8JqAVVOfl37IRneSmpw2UPndwMbZj?=
 =?us-ascii?Q?AUhilNO1tpy0zVqfwh8j+Q6G8oJKSTx8qHaWiBF5iOhelcbB4ToPd8DE6TFb?=
 =?us-ascii?Q?U2tkVolYpUEtX3mQMXdm4vGHJD1az6sQdKz8DAp1ERlv6Ds6J2nrLoe2iGHy?=
 =?us-ascii?Q?1Yn2BE/zEI8KkKRlMWFRfuCg3P75oY+ufT9ABLa3690kS9mVF0MAz1WV6S8m?=
 =?us-ascii?Q?Iycl450ZnbvWQM7fkDyo78NedANTVEC1azUI2Fce7hxcBbVWRTtSesVRWmvJ?=
 =?us-ascii?Q?S2xZ4BZhtaMmqgr2cly/+wwn8KwsbzLpiTenocTYS44DwQ3z2FshseI9JadH?=
 =?us-ascii?Q?vnFlWj4KnjADJLbqtsdvJBW/JDdr6xIxZclBSiaAa5i8DKH50M+Hh9Dsx+wR?=
 =?us-ascii?Q?XrorLH4oriUM2iW+4v1G+BDEC1wZG6xepIWjckFz0y3AmkqCE2fIaYtkDpHc?=
 =?us-ascii?Q?VBvkjC2b80Ft7+jEYJawupduXRKk5lGbkelRs6eaAwkoLmuZhgBJcLXwoZPN?=
 =?us-ascii?Q?zr96l4/pSgdLM2w0oy3ZHHbqRLlisw/1mInB1tQ9N4O+eaMz11Mvd3kLxwUL?=
 =?us-ascii?Q?1rffM+QzeQCtpA+pVfMA70tH/nH5Crq9SaNiJxe0H1GqCX3BKlNaETKyX4Lu?=
 =?us-ascii?Q?rJpG5EB8byg3LOvkNSl56AUTWg2cXLhNkCGb7v3+MGPri1lMZzB0gKF0QtTF?=
 =?us-ascii?Q?n37tEFxgpVTG7woV9Y6/oN53?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b29b36-0162-4750-e4cf-08d8cc6a27ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:45:57.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKjIxtXGwn1BdrSqSR1btxTUuwHENGwyxuPD8gOJlHF+hMi2rh5BhgplUEtCYjKhx0mLlzcLoDeO6UJbs7Rs2QEUl4nqzetxPFZFSMX2l3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1546
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Novem=
ber 20, 2020 4:30 PM
>=20
> Introduce ioctls for mapping and unmapping regions of guest memory.
>=20
> Uses a table of memory 'slots' similar to KVM, but the slot
> number is not visible to userspace.
>=20
> For now, this simple implementation requires each new mapping to be
> disjoint - the underlying hypercalls have no such restriction, and
> implicitly overwrite any mappings on the pages in the specified regions.
>=20
> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  Documentation/virt/mshv/api.rst        |  15 ++
>  include/asm-generic/hyperv-tlfs.h      |  15 ++
>  include/linux/mshv.h                   |  14 ++
>  include/uapi/asm-generic/hyperv-tlfs.h |   9 +
>  include/uapi/linux/mshv.h              |  15 ++
>  virt/mshv/mshv_main.c                  | 322 ++++++++++++++++++++++++-
>  6 files changed, 388 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/ap=
i.rst
> index ce651a1738e0..530efc29d354 100644
> --- a/Documentation/virt/mshv/api.rst
> +++ b/Documentation/virt/mshv/api.rst
> @@ -72,3 +72,18 @@ it is open - this ioctl can only be called once per op=
en.
>  This ioctl creates a guest partition, returning a file descriptor to use=
 as a
>  handle for partition ioctls.
>=20
> +3.3 MSHV_MAP_GUEST_MEMORY and MSHV_UNMAP_GUEST_MEMORY
> +-----------------------------------------------------
> +:Type: partition ioctl
> +:Parameters: struct mshv_user_mem_region
> +:Returns: 0 on success
> +
> +Create a mapping from a region of process memory to a region of physical=
 memory
> +in a guest partition.

Just to be super explicit:

Create a mapping from memory in the user space of the calling process (runn=
ing
in the root partition) to a region of guest physical memory in a guest part=
ition.

> +
> +Mappings must be disjoint in process address space and guest address spa=
ce.
> +
> +Note: In the current implementation, this memory is pinned to stop the p=
ages
> +being moved by linux and subsequently clobbered by the hypervisor. So th=
e region
> +is backed by physical memory.

Again to be super explicit:

Note: In the current implementation, this memory is pinned to real physical
memory to stop the pages being moved by Linux in the root partition,
and subsequently being clobbered by the hypervisor.  So the region is backe=
d
by real physical memory.

> +
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 2a49503b7396..6e5072e29897 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -149,6 +149,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_DEPOSIT_MEMORY			0x0048
>  #define HVCALL_WITHDRAW_MEMORY			0x0049
> +#define HVCALL_MAP_GPA_PAGES			0x004b
> +#define HVCALL_UNMAP_GPA_PAGES			0x004c
>  #define HVCALL_CREATE_VP			0x004e
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
> @@ -827,4 +829,17 @@ struct hv_delete_partition {
>  	u64 partition_id;
>  };
>=20
> +struct hv_map_gpa_pages {
> +	u64 target_partition_id;
> +	u64 target_gpa_base;
> +	u32 map_flags;

Is there a reserved 32 bit field here?  Hyper-V always aligns
things on 64 bit boundaries.

> +	u64 source_gpa_page_list[];
> +};
> +
> +struct hv_unmap_gpa_pages {
> +	u64 target_partition_id;
> +	u64 target_gpa_base;
> +	u32 unmap_flags;

Is there a reserved 32 bit field here?  Hyper-V always aligns
things on 64 bit boundaries.

> +};

Add __packed to the above two structs after sorting out
the alignment issues.

> +
>  #endif
> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
> index fc4f35089b2c..91a742f37440 100644
> --- a/include/linux/mshv.h
> +++ b/include/linux/mshv.h
> @@ -7,13 +7,27 @@
>   */
>=20
>  #include <linux/spinlock.h>
> +#include <linux/mutex.h>
>  #include <uapi/linux/mshv.h>
>=20
>  #define MSHV_MAX_PARTITIONS		128
> +#define MSHV_MAX_MEM_REGIONS		64
> +
> +struct mshv_mem_region {
> +	u64 size; /* bytes */
> +	u64 guest_pfn;
> +	u64 userspace_addr; /* start of the userspace allocated memory */
> +	struct page **pages;
> +};
>=20
>  struct mshv_partition {
>  	u64 id;
>  	refcount_t ref_count;
> +	struct mutex mutex;
> +	struct {
> +		u32 count;
> +		struct mshv_mem_region slots[MSHV_MAX_MEM_REGIONS];
> +	} regions;
>  };
>=20
>  struct mshv {
> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-ge=
neric/hyperv-
> tlfs.h
> index 7a858226a9c5..e7b09b9f00de 100644
> --- a/include/uapi/asm-generic/hyperv-tlfs.h
> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
> @@ -12,4 +12,13 @@
>  #define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED          BIT(=
4)
>  #define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    BIT(=
13)
>=20
> +/* HV Map GPA (Guest Physical Address) Flags */
> +#define HV_MAP_GPA_PERMISSIONS_NONE     0x0
> +#define HV_MAP_GPA_READABLE             0x1
> +#define HV_MAP_GPA_WRITABLE             0x2
> +#define HV_MAP_GPA_KERNEL_EXECUTABLE    0x4
> +#define HV_MAP_GPA_USER_EXECUTABLE      0x8
> +#define HV_MAP_GPA_EXECUTABLE           0xC
> +#define HV_MAP_GPA_PERMISSIONS_MASK     0xF
> +
>  #endif
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 4f8da9a6fde2..47be03ef4e86 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -18,10 +18,25 @@ struct mshv_create_partition {
>  	struct hv_partition_creation_properties partition_creation_properties;
>  };
>=20
> +/*
> + * Mappings can't overlap in GPA space or userspace
> + * To unmap, these fields must match an existing mapping
> + */
> +struct mshv_user_mem_region {
> +	__u64 size;		/* bytes */
> +	__u64 guest_pfn;
> +	__u64 userspace_addr;	/* start of the userspace allocated memory */
> +	__u32 flags;		/* ignored on unmap */
> +};
> +
>  #define MSHV_IOCTL 0xB8
>=20
>  /* mshv device */
>  #define MSHV_REQUEST_VERSION	_IOW(MSHV_IOCTL, 0x00, __u32)
>  #define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x01, struct mshv_create_=
partition)
>=20
> +/* partition device */
> +#define MSHV_MAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x02, struct mshv_user_me=
m_region)
> +#define MSHV_UNMAP_GUEST_MEMORY	_IOW(MSHV_IOCTL, 0x03, struct mshv_user_=
mem_region)
> +
>  #endif
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index 162a1bb42a4a..ce480598e67f 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -60,6 +60,10 @@ static struct miscdevice mshv_dev =3D {
>=20
>  #define HV_WITHDRAW_BATCH_SIZE	(PAGE_SIZE / sizeof(u64))
>  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> +#define HV_MAP_GPA_MASK		(0x0000000FFFFFFFFFULL)
> +#define HV_MAP_GPA_BATCH_SIZE	\
> +		(PAGE_SIZE / sizeof(struct hv_map_gpa_pages) / sizeof(u64))

Hmmm. Shouldn't this be:

	((HV_HYP_PAGE_SIZE - sizeof(struct hv_map_gpa_pages))/sizeof(u64))


> +#define PIN_PAGES_BATCH_SIZE	(0x10000000 / PAGE_SIZE)
>=20
>  static int
>  hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
> @@ -245,16 +249,318 @@ hv_call_delete_partition(u64 partition_id)
>  	return -hv_status_to_errno(status);
>  }
>=20
> +static int
> +hv_call_map_gpa_pages(u64 partition_id,
> +		      u64 gpa_target,
> +		      u64 page_count, u32 flags,
> +		      struct page **pages)
> +{
> +	struct hv_map_gpa_pages *input_page;
> +	int status;
> +	int i;
> +	struct page **p;
> +	u32 completed =3D 0;
> +	u64 hypercall_status;
> +	unsigned long remaining =3D page_count;
> +	int rep_count;
> +	unsigned long irq_flags;
> +	int ret =3D 0;
> +
> +	while (remaining) {
> +
> +		rep_count =3D min(remaining, HV_MAP_GPA_BATCH_SIZE);
> +
> +		local_irq_save(irq_flags);
> +		input_page =3D (struct hv_map_gpa_pages *)(*this_cpu_ptr(
> +			hyperv_pcpu_input_arg));
> +
> +		input_page->target_partition_id =3D partition_id;
> +		input_page->target_gpa_base =3D gpa_target;
> +		input_page->map_flags =3D flags;
> +
> +		for (i =3D 0, p =3D pages; i < rep_count; i++, p++)
> +			input_page->source_gpa_page_list[i] =3D
> +				page_to_pfn(*p) & HV_MAP_GPA_MASK;

The masking seems a bit weird.  The mask allows for up to 64G page frames,
which is 256 Tbytes of total physical memory, which is probably the current
Hyper-V limit on memory size (48 bit physical address space, though 52 bit
physical address spaces are coming).  So the masking shouldn't ever be doin=
g
anything.   And if it was doing something, that probably should be treated =
as
an error rather than simply dropping the high bits.

Note that this code does not handle the case where PAGE_SIZE !=3D
HV_HYP_PAGE_SIZE.  But maybe we'll never run the root partition with a
page size other than 4K.

> +		hypercall_status =3D hv_do_rep_hypercall(
> +			HVCALL_MAP_GPA_PAGES, rep_count, 0, input_page, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		status =3D hypercall_status & HV_HYPERCALL_RESULT_MASK;
> +		completed =3D (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
> +				HV_HYPERCALL_REP_COMP_OFFSET;
> +
> +		if (status =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +						    partition_id, 256);

Why adding 256 pages?  I'm just contrasting with other places that add
1 page at a time.  Maybe a comment to explain ....

> +			if (ret)
> +				break;
> +		} else if (status !=3D HV_STATUS_SUCCESS) {
> +			pr_err("%s: completed %llu out of %llu, %s\n",
> +			       __func__,
> +			       page_count - remaining, page_count,
> +			       hv_status_to_string(status));
> +			ret =3D -hv_status_to_errno(status);
> +			break;
> +		}
> +
> +		pages +=3D completed;
> +		remaining -=3D completed;
> +		gpa_target +=3D completed;
> +	}
> +
> +	if (ret && completed) {

Is the above the right test?  Completed could be zero from the most
recent iteration, but still could be partially succeeded based on a previou=
s
successful iteration.   I think this needs to check whether remaining equal=
s
page_count.

> +		pr_err("%s: Partially succeeded; mapped regions may be in invalid stat=
e",
> +		       __func__);
> +		ret =3D -EBADFD;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +hv_call_unmap_gpa_pages(u64 partition_id,
> +			u64 gpa_target,
> +			u64 page_count, u32 flags)
> +{
> +	struct hv_unmap_gpa_pages *input_page;
> +	int status;
> +	int ret =3D 0;
> +	u32 completed =3D 0;
> +	u64 hypercall_status;
> +	unsigned long remaining =3D page_count;
> +	int rep_count;
> +	unsigned long irq_flags;
> +
> +	local_irq_save(irq_flags);
> +	input_page =3D (struct hv_unmap_gpa_pages *)(*this_cpu_ptr(
> +		hyperv_pcpu_input_arg));
> +
> +	input_page->target_partition_id =3D partition_id;
> +	input_page->target_gpa_base =3D gpa_target;
> +	input_page->unmap_flags =3D flags;
> +
> +	while (remaining) {
> +		rep_count =3D min(remaining, HV_MAP_GPA_BATCH_SIZE);
> +		hypercall_status =3D hv_do_rep_hypercall(
> +			HVCALL_UNMAP_GPA_PAGES, rep_count, 0, input_page, NULL);

Similarly, this code doesn't handle PAGE_SIZE !=3D HV_HYP_PAGE_SIZE.

> +		status =3D hypercall_status & HV_HYPERCALL_RESULT_MASK;
> +		completed =3D (hypercall_status & HV_HYPERCALL_REP_COMP_MASK) >>
> +				HV_HYPERCALL_REP_COMP_OFFSET;
> +		if (status !=3D HV_STATUS_SUCCESS) {
> +			pr_err("%s: completed %llu out of %llu, %s\n",
> +			       __func__,
> +			       page_count - remaining, page_count,
> +			       hv_status_to_string(status));
> +			ret =3D -hv_status_to_errno(status);
> +			break;
> +		}
> +
> +		remaining -=3D completed;
> +		gpa_target +=3D completed;
> +		input_page->target_gpa_base =3D gpa_target;
> +	}
> +	local_irq_restore(irq_flags);

I have some concern about holding interrupts disabled for this long.

> +
> +	if (ret && completed) {

Same comment as before.

> +		pr_err("%s: Partially succeeded; mapped regions may be in invalid stat=
e",
> +		       __func__);
> +		ret =3D -EBADFD;
> +	}
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_partition_ioctl_map_memory(struct mshv_partition *partition,
> +				struct mshv_user_mem_region __user *user_mem)
> +{
> +	struct mshv_user_mem_region mem;
> +	struct mshv_mem_region *region;
> +	int completed;
> +	unsigned long remaining, batch_size;
> +	int i;
> +	struct page **pages;
> +	u64 page_count, user_start, user_end, gpfn_start, gpfn_end;
> +	u64 region_page_count, region_user_start, region_user_end;
> +	u64 region_gpfn_start, region_gpfn_end;
> +	long ret =3D 0;
> +
> +	/* Check we have enough slots*/
> +	if (partition->regions.count =3D=3D MSHV_MAX_MEM_REGIONS) {
> +		pr_err("%s: not enough memory region slots\n", __func__);
> +		return -ENOSPC;
> +	}
> +
> +	if (copy_from_user(&mem, user_mem, sizeof(mem)))
> +		return -EFAULT;
> +
> +	if (!mem.size ||
> +	    mem.size & (PAGE_SIZE - 1) ||
> +	    mem.userspace_addr & (PAGE_SIZE - 1) ||

There's a PAGE_ALIGNED macro that expresses exactly what
each of the previous two tests is doing.

> +	    !access_ok(mem.userspace_addr, mem.size))
> +		return -EINVAL;
> +
> +	/* Reject overlapping regions */
> +	page_count =3D mem.size >> PAGE_SHIFT;
> +	user_start =3D mem.userspace_addr;
> +	user_end =3D mem.userspace_addr + mem.size;
> +	gpfn_start =3D mem.guest_pfn;
> +	gpfn_end =3D mem.guest_pfn + page_count;
> +	for (i =3D 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
> +		region =3D &partition->regions.slots[i];
> +		if (!region->size)
> +			continue;
> +		region_page_count =3D region->size >> PAGE_SHIFT;
> +		region_user_start =3D region->userspace_addr;
> +		region_user_end =3D region->userspace_addr + region->size;
> +		region_gpfn_start =3D region->guest_pfn;
> +		region_gpfn_end =3D region->guest_pfn + region_page_count;
> +
> +		if (!(
> +		     (user_end <=3D region_user_start) ||
> +		     (region_user_end <=3D user_start))) {
> +			return -EEXIST;
> +		}
> +		if (!(
> +		     (gpfn_end <=3D region_gpfn_start) ||
> +		     (region_gpfn_end <=3D gpfn_start))) {
> +			return -EEXIST;

You could apply De Morgan's theorem to the conditions
in each "if" statement and get rid of the "!".  That might make
these slightly easier to understand, but I have no strong
preference.

> +		}
> +	}
> +
> +	/* Pin the userspace pages */
> +	pages =3D vzalloc(sizeof(struct page *) * page_count);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	remaining =3D page_count;
> +	while (remaining) {
> +		/*
> +		 * We need to batch this, as pin_user_pages_fast with the
> +		 * FOLL_LONGTERM flag does a big temporary allocation
> +		 * of contiguous memory
> +		 */
> +		batch_size =3D min(remaining, PIN_PAGES_BATCH_SIZE);
> +		completed =3D pin_user_pages_fast(
> +				mem.userspace_addr +
> +					(page_count - remaining) * PAGE_SIZE,
> +				batch_size,
> +				FOLL_WRITE | FOLL_LONGTERM,
> +				&pages[page_count - remaining]);
> +		if (completed < 0) {
> +			pr_err("%s: failed to pin user pages error %i\n",
> +			       __func__,
> +			       completed);
> +			ret =3D completed;
> +			goto err_unpin_pages;
> +		}
> +		remaining -=3D completed;
> +	}
> +
> +	/* Map the pages to GPA pages */
> +	ret =3D hv_call_map_gpa_pages(partition->id, mem.guest_pfn,
> +				    page_count, mem.flags, pages);
> +	if (ret)
> +		goto err_unpin_pages;
> +
> +	/* Install the new region */
> +	for (i =3D 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
> +		if (!partition->regions.slots[i].size) {
> +			region =3D &partition->regions.slots[i];
> +			break;
> +		}
> +	}
> +	region->pages =3D pages;
> +	region->size =3D mem.size;
> +	region->guest_pfn =3D mem.guest_pfn;
> +	region->userspace_addr =3D mem.userspace_addr;
> +
> +	partition->regions.count++;
> +
> +	return 0;
> +
> +err_unpin_pages:
> +	unpin_user_pages(pages, page_count - remaining);
> +	vfree(pages);
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_partition_ioctl_unmap_memory(struct mshv_partition *partition,
> +				  struct mshv_user_mem_region __user *user_mem)
> +{
> +	struct mshv_user_mem_region mem;
> +	struct mshv_mem_region *region_ptr;
> +	int i;
> +	u64 page_count;
> +	long ret;
> +
> +	if (!partition->regions.count)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&mem, user_mem, sizeof(mem)))
> +		return -EFAULT;
> +
> +	/* Find matching region */
> +	for (i =3D 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
> +		if (!partition->regions.slots[i].size)
> +			continue;
> +		region_ptr =3D &partition->regions.slots[i];
> +		if (region_ptr->userspace_addr =3D=3D mem.userspace_addr &&
> +		    region_ptr->size =3D=3D mem.size &&
> +		    region_ptr->guest_pfn =3D=3D mem.guest_pfn)
> +			break;
> +	}
> +
> +	if (i =3D=3D MSHV_MAX_MEM_REGIONS)
> +		return -EINVAL;
> +
> +	page_count =3D region_ptr->size >> PAGE_SHIFT;
> +	ret =3D hv_call_unmap_gpa_pages(partition->id, region_ptr->guest_pfn,
> +				      page_count, 0);
> +	if (ret)
> +		return ret;
> +
> +	unpin_user_pages(region_ptr->pages, page_count);
> +	vfree(region_ptr->pages);
> +	memset(region_ptr, 0, sizeof(*region_ptr));
> +	partition->regions.count--;
> +
> +	return 0;
> +}
> +
>  static long
>  mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned lon=
g arg)
>  {
> -	return -ENOTTY;
> +	struct mshv_partition *partition =3D filp->private_data;
> +	long ret;
> +
> +	if (mutex_lock_killable(&partition->mutex))
> +		return -EINTR;
> +
> +	switch (ioctl) {
> +	case MSHV_MAP_GUEST_MEMORY:
> +		ret =3D mshv_partition_ioctl_map_memory(partition,
> +							(void __user *)arg);
> +		break;
> +	case MSHV_UNMAP_GUEST_MEMORY:
> +		ret =3D mshv_partition_ioctl_unmap_memory(partition,
> +							(void __user *)arg);
> +		break;
> +	default:
> +		ret =3D -ENOTTY;
> +	}
> +
> +	mutex_unlock(&partition->mutex);
> +	return ret;
>  }
>=20
>  static void
>  destroy_partition(struct mshv_partition *partition)
>  {
> -	unsigned long flags;
> +	unsigned long flags, page_count;
> +	struct mshv_mem_region *region;
>  	int i;
>=20
>  	/* Remove from list of partitions */
> @@ -286,6 +592,16 @@ destroy_partition(struct mshv_partition *partition)
>=20
>  	hv_call_delete_partition(partition->id);
>=20
> +	/* Remove regions and unpin the pages */
> +	for (i =3D 0; i < MSHV_MAX_MEM_REGIONS; ++i) {
> +		region =3D &partition->regions.slots[i];
> +		if (!region->size)
> +			continue;
> +		page_count =3D region->size >> PAGE_SHIFT;
> +		unpin_user_pages(region->pages, page_count);
> +		vfree(region->pages);
> +	}
> +
>  	kfree(partition);
>  }
>=20
> @@ -353,6 +669,8 @@ mshv_ioctl_create_partition(void __user *user_arg)
>  	if (!partition)
>  		return -ENOMEM;
>=20
> +	mutex_init(&partition->mutex);
> +
>  	fd =3D get_unused_fd_flags(O_CLOEXEC);
>  	if (fd < 0) {
>  		ret =3D fd;
> --
> 2.25.1

