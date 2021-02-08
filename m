Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2E313F98
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 20:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhBHTvw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 14:51:52 -0500
Received: from mail-bn8nam11on2133.outbound.protection.outlook.com ([40.107.236.133]:18417
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236572AbhBHTuh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 14:50:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khOD/+fHRm4dmnSIfE25BUUWhVfr9FOIq//5tvCpdADhm2QOE0ZTR3Rz60JzkADXuvdL8PgIZGOG/C6PJbObVG5IPWt3j9P4XzopfciselrwrpjjPmXzmO+V4nGLWqLSTd2FMz4y2KRAZvDxFfdSx1nVqXd0KwJRhcs8il/ekLB5tBRxRHIxYpbeRARr+wGYJy8eMDEISF+trBQSvY/9eiKDyinOm9WUIln4PX6pv2lia9+JMuByhcw9ff8sLscbBhuWOXxOutR2vZpIWrhjFRLTpgjcbasAnXws+uQX9dB8OQblixMubLd4LaSzyEiqIx1FaUD1s4aJoYhBVof6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrK9s0qovrnCIai7oGMc/QOE6SzKrzHn1VuOXy1R0tk=;
 b=O9MesNmB1Y4ZbczNVV68XBh64CdGYgyQn93QSmdovGUQyh2d71Xpzbv+ZII9MlERe8yZkJ6ehrcY3IFPna1spZMYiXzYr7Z5w6b2o479tZGmZN+MDwqn3gTdJdfMc/HXbS5VM66/e3F6z2AXMBJISzdgXjvVvu2hq46zydnrgRH/FkssbppQc9NzXczYCFQE1sCUlykVP9pp2XAzZu7aZ/ynOLaACUZat0jKr0KZPaIZpJvvB1CGuez80/7zYxPu9Z6hTGJnf3cITAeLDz/RNUpMCGqZbetviqYxFBr5a+3Em12Xejx/j0ZRO6vnqY/VA+Yb5GfQEp1q5UD4sBOIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrK9s0qovrnCIai7oGMc/QOE6SzKrzHn1VuOXy1R0tk=;
 b=Hb2w8yhJLsiSvGb+/csRUdmkZsL0ryuXbL/kiLrTZdCp0mYA1yRV/yXXtW7ScQV4uHMJUaGkkTzngFXxI0gPWqimIQx7wUSEd4Vd9WZkMInefR6X9ah51PYa+qOYcnveiTd6NA4oGF/WyWyrTijMYn1b+WMUVDt86otybcHU4hs=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Mon, 8 Feb
 2021 19:49:11 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:49:11 +0000
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
Subject: RE: [RFC PATCH 16/18] virt/mshv: mmap vp register page
Thread-Topic: [RFC PATCH 16/18] virt/mshv: mmap vp register page
Thread-Index: AQHWv52SmSGO9AbD9EqvA6uvipw2mKpPAcRQ
Date:   Mon, 8 Feb 2021 19:49:11 +0000
Message-ID: <MWHPR21MB15937352FFE4CE51DC54191BD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-17-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-17-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:49:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e3e2b713-5f81-459f-9e0a-98cd4b8fada3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9661d89a-a12a-464e-0601-08d8cc6a9b40
x-ms-traffictypediagnostic: MWHPR21MB1546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB154642D98C73288A0E43113DD78F9@MWHPR21MB1546.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:109;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKMVAKKp1x9hFyUozNDSEuzAfAhZD5gpHvFipv16fXJfZ+72q2Tg/BEl4lLsHAM8W6H0liMrn5SA8UcEHYwy4uVWymMNW7EGnaSPcvHflgCE2bnEi1qFwX7KF+PcMFQn7Vlk4azvlAU8ocM+hRF/kNIs8qU02k6dzwck6unUBayd7DCGPgrFywR8hOcZC3GiuTVQLjlGBnTsp57Gq0PbJpnx/HWdZ9Gctd27jcL/e8p6zl88ojlFwsX87flyjEvO1K8ps+jvxEh5H3wNW1IGQgtpgKA0OhilQpcs7VNrkrXeJWniY8eQMDqfXQDOemRVFo6/KJKB9F1H6PNzXWxIEVCnGzBuoK9xIsy4wp/lTiIiCUAMp8OfzhTHrobYiqPrcsy+AiC8TalB4gPU/fQSBBRzeCe5HMxPBy6vdzny/lgfBHpuIOM9p7jPj9GfHtSl1Q8PIRT2kCtPxVv5vxd+gkWXQjlFh5J6gSqH/u20LCxgpDoUVJs8OitS0y41hVRjGnukfuYCqV14/QuqCEUoVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(7696005)(64756008)(76116006)(6506007)(83380400001)(82960400001)(10290500003)(66446008)(66556008)(86362001)(4326008)(66946007)(54906003)(110136005)(107886003)(8676002)(5660300002)(33656002)(8936002)(2906002)(26005)(316002)(66476007)(186003)(52536014)(478600001)(8990500004)(71200400001)(82950400001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DbB6imuQSbau5rcT5C33D837ZJ6sWcMRk7e3eDTemPj0oRSsUoGIuBFF4t+R?=
 =?us-ascii?Q?ahMHj3SizY0Wz8YtcoVJa0fBUnEl8rFxZmGSZBIWyXt15GQIuhATgt9wO7z2?=
 =?us-ascii?Q?nMZvI+GzXLXq7/lrR3o6PRKOGCjDORzGraDOuvp21BAZ1AxOvrC53a++u8up?=
 =?us-ascii?Q?VPZDzTugTcrVcOhjSTG27mUKzc4etV4g5zIZYg/T3E0+5NfNLYN/xBpFlurc?=
 =?us-ascii?Q?dvcUxK8b2Q9qWUFrycJs56JLqmZCt9FW1WUQWd/VnYuBbSFn+p1gofXrHslV?=
 =?us-ascii?Q?3YcG0ebQ8FrRmk1GkQTekXzrhhsJkBqUxDEmqrzX8U1c4HGQd/kgHdP5ZK6I?=
 =?us-ascii?Q?2AP9NGHobl9ArJNw4itMHXNHf6OkHPlmenF26yU8gti0Tu0WawaDqZWRM4qn?=
 =?us-ascii?Q?V95Rt5BgmjLVZ87fQk4HIgcnMWeJzOXTdQmHyDj+73Ah/Zq0QbK6b4xAaobj?=
 =?us-ascii?Q?P+QBUjS8zpyNQBbpqnz2CIwZs7UUDQF8+owH49QIDmV5OEFcoyL/CUsMTAFH?=
 =?us-ascii?Q?UafSLilo9w7vq2jrybGlAQYq72j+g58stWm/3R1ToJiFKo728o7PqUOvBM2n?=
 =?us-ascii?Q?P68LYbaX/hS5RUphMDIZLEDoZIZiXfSlz/rfiwTdYNhWSgtmnskAYdU2Ax5g?=
 =?us-ascii?Q?/XRp0eJASZIw4L9xNlAtRj8UV8FlDp0TWrtajT3atHSIE10g9e8Nz6NeUQv7?=
 =?us-ascii?Q?THOh93VOyJZUWAuwEsQTsqAg/SZUA75Y2rWLALA7mwXEHK4gbIbzUSzQyACI?=
 =?us-ascii?Q?DEVxS6aY7sfPmW6FupTLewNcOueQE1F0weNb8NCcjfZKpxG2oTS2wePEt85T?=
 =?us-ascii?Q?Y3Wcu8j90G7tQ94GYA370Mmyx0TcCCUYcngdHW7eMSMznVY3WvWyPyWwPrtC?=
 =?us-ascii?Q?b1lg85dsdyYBGMyV6ziDZCyGp6CYrvHaY/7uJ0ksEukqBHlqK0tB/R8avbLm?=
 =?us-ascii?Q?seID7JdnCGq+OBIN2irGo6nNv7Kz4BKxBuBNYE1hT2YO4CrEXe3G5aAC5cDh?=
 =?us-ascii?Q?RephbnN5iFvFfh1n2bXkmQXzcAxA+oGin82NAFB5YItbSXK50OVu4vCYrzJW?=
 =?us-ascii?Q?u/TbLK7lamFdLQK2UeiUv9IEiUZHiSDBkjNY+wzi+d73qvrBSigXaBbvn5Kx?=
 =?us-ascii?Q?m7W4hTnDowMXs7D9BQX7KB3ifVjJ96n5QpL0g+j5EP3UPvIt4uvYrnJ9rKUm?=
 =?us-ascii?Q?sOWwokCm0i14GG9YrSv3R1uiTy52pIKBl3DEHxuyxkqebnjWkocOprfprRyK?=
 =?us-ascii?Q?Azgj7pk6iMhKZ/tSM+etAidw79h39gk7/0XLBVQY12h347+7NeIycJAwlZoB?=
 =?us-ascii?Q?4u+cYNkXjiuBJKYYX/EOe+TL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9661d89a-a12a-464e-0601-08d8cc6a9b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:49:11.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mL/6sw+smd4r7BCi3LabNum4ZRNvQyjr5Ij1TEfMyvdcJjqV0SlDTFRQ9k/aW61H5CHsijp7pX0LY3evGoKa0nAzaV8FgULfmnlDb0f0VgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1546
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Novem=
ber 20, 2020 4:31 PM
>=20
> Introduce mmap interface for a virtual processor, exposing a page for
> setting and getting common registers while the VP is suspended.
>=20
> This provides a more performant and convenient way to get and set these
> registers in the context of a vmm's run-loop.
>=20
> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  Documentation/virt/mshv/api.rst         | 11 ++++
>  arch/x86/include/uapi/asm/hyperv-tlfs.h | 74 ++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h       | 10 +++
>  include/linux/mshv.h                    |  1 +
>  include/uapi/asm-generic/hyperv-tlfs.h  |  5 ++
>  include/uapi/linux/mshv.h               | 12 ++++
>  virt/mshv/mshv_main.c                   | 82 +++++++++++++++++++++++++
>  7 files changed, 195 insertions(+)
>=20
> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/ap=
i.rst
> index 7fd75f248eff..89c276a8778f 100644
> --- a/Documentation/virt/mshv/api.rst
> +++ b/Documentation/virt/mshv/api.rst
> @@ -149,3 +149,14 @@ HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED
>  Get/set various vp state. Currently these can be used to get and set
>  emulated LAPIC state, and xsave data.
>=20
> +3.10 mmap(vp)
> +-------------
> +:Type: vp mmap
> +:Parameters: offset should be HV_VP_MMAP_REGISTERS_OFFSET
> +:Returns: 0 on success
> +
> +Maps a page into userspace that can be used to get and set common regist=
ers
> +while the vp is suspended.
> +The page is laid out in struct hv_vp_register_page in asm/hyperv-tlfs.h.
> +

I'm assuming there's no support for the corresponding munmap().
What happens if munmap is called?  Does it just fail and the page remains
mapped?

> +
> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/u=
api/asm/hyperv-
> tlfs.h
> index 78758aedf23e..a241178567ff 100644
> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
> @@ -1110,4 +1110,78 @@ struct hv_vp_state_data_xsave {
>  	union hv_x64_xsave_xfem_register states;
>  };
>=20
> +/* Bits for dirty mask of hv_vp_register_page */
> +#define HV_X64_REGISTER_CLASS_GENERAL	0
> +#define HV_X64_REGISTER_CLASS_IP	1
> +#define HV_X64_REGISTER_CLASS_XMM	2
> +#define HV_X64_REGISTER_CLASS_SEGMENT	3
> +#define HV_X64_REGISTER_CLASS_FLAGS	4
> +
> +#define HV_VP_REGISTER_PAGE_VERSION_1	1u
> +
> +struct hv_vp_register_page {
> +	__u16 version;
> +	bool isvalid;

Like enum, avoid type "bool" in data structures shared with
Hyper-V.

> +	__u8 rsvdz;
> +	__u32 dirty;
> +	union {
> +		struct {
> +			__u64 rax;
> +			__u64 rcx;
> +			__u64 rdx;
> +			__u64 rbx;
> +			__u64 rsp;
> +			__u64 rbp;
> +			__u64 rsi;
> +			__u64 rdi;
> +			__u64 r8;
> +			__u64 r9;
> +			__u64 r10;
> +			__u64 r11;
> +			__u64 r12;
> +			__u64 r13;
> +			__u64 r14;
> +			__u64 r15;
> +		};
> +
> +		__u64 gp_registers[16];
> +	};
> +	__u64 rip;
> +	__u64 rflags;
> +	union {
> +		struct {
> +			struct hv_u128 xmm0;
> +			struct hv_u128 xmm1;
> +			struct hv_u128 xmm2;
> +			struct hv_u128 xmm3;
> +			struct hv_u128 xmm4;
> +			struct hv_u128 xmm5;
> +		};
> +
> +		struct hv_u128 xmm_registers[6];
> +	};
> +	union {
> +		struct {
> +			struct hv_x64_segment_register es;
> +			struct hv_x64_segment_register cs;
> +			struct hv_x64_segment_register ss;
> +			struct hv_x64_segment_register ds;
> +			struct hv_x64_segment_register fs;
> +			struct hv_x64_segment_register gs;
> +		};
> +
> +		struct hv_x64_segment_register segment_registers[6];
> +	};
> +	/* read only */
> +	__u64 cr0;
> +	__u64 cr3;
> +	__u64 cr4;
> +	__u64 cr8;
> +	__u64 efer;
> +	__u64 dr7;
> +	union hv_x64_pending_interruption_register pending_interruption;
> +	union hv_x64_interrupt_state_register interrupt_state;
> +	__u64 instruction_emulation_hints;
> +};
> +
>  #endif
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 4bc59a0344ce..9eed4b869110 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -837,4 +837,14 @@ struct hv_set_vp_state_in {
>  	union hv_input_set_vp_state_data data[];
>  };
>=20
> +struct hv_map_vp_state_page_in {
> +	u64 partition_id;
> +	u32 vp_index;
> +	enum hv_vp_state_page_type type;
> +};
> +
> +struct hv_map_vp_state_page_out {
> +	u64 map_location; /* page number */
> +};
> +
>  #endif
> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
> index 3933d80294f1..33f4d0cfee11 100644
> --- a/include/linux/mshv.h
> +++ b/include/linux/mshv.h
> @@ -20,6 +20,7 @@ struct mshv_vp {
>  	u32 index;
>  	struct mshv_partition *partition;
>  	struct mutex mutex;
> +	struct page *register_page;
>  	struct {
>  		struct semaphore sem;
>  		struct task_struct *task;
> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-ge=
neric/hyperv-
> tlfs.h
> index b3c84c69b73f..a747f39b132a 100644
> --- a/include/uapi/asm-generic/hyperv-tlfs.h
> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
> @@ -92,4 +92,9 @@ enum hv_get_set_vp_state_type {
>  	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS	=3D 4,
>  };
>=20
> +enum hv_vp_state_page_type {
> +	HV_VP_STATE_PAGE_REGISTERS =3D 0,
> +	HV_VP_STATE_PAGE_COUNT
> +};
> +
>  #endif
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index ae0bb64bbec3..8537ff29aee5 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -13,6 +13,8 @@
>=20
>  #define MSHV_VERSION	0x0
>=20
> +#define MSHV_VP_MMAP_REGISTERS_OFFSET (HV_VP_STATE_PAGE_REGISTERS * 0x10=
00)
> +
>  struct mshv_create_partition {
>  	__u64 flags;
>  	struct hv_partition_creation_properties partition_creation_properties;
> @@ -84,4 +86,14 @@ struct mshv_vp_state {
>  #define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
>  #define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
>=20
> +/* register page mapping example:
> + * struct hv_vp_register_page *regs =3D mmap(NULL,
> + *					   4096,
> + *					   PROT_READ | PROT_WRITE,
> + *					   MAP_SHARED,
> + *					   vp_fd,
> + *					   HV_VP_MMAP_REGISTERS_OFFSET);
> + * munmap(regs, 4096);
> + */
> +
>  #endif
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index 70172d9488de..a597254fa4f4 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -43,11 +43,18 @@ static long mshv_partition_ioctl(struct file *filp, u=
nsigned int ioctl,
> unsigned
>  static int mshv_dev_open(struct inode *inode, struct file *filp);
>  static int mshv_dev_release(struct inode *inode, struct file *filp);
>  static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsign=
ed long arg);
> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
> +
> +static const struct vm_operations_struct mshv_vp_vm_ops =3D {
> +	.fault =3D mshv_vp_fault,
> +};
>=20
>  static const struct file_operations mshv_vp_fops =3D {
>  	.release =3D mshv_vp_release,
>  	.unlocked_ioctl =3D mshv_vp_ioctl,
>  	.llseek =3D noop_llseek,
> +	.mmap =3D mshv_vp_mmap,
>  };
>=20
>  static const struct file_operations mshv_partition_fops =3D {
> @@ -499,6 +506,47 @@ hv_call_set_vp_registers(u32 vp_index,
>  	return -hv_status_to_errno(status);
>  }
>=20
> +static int
> +hv_call_map_vp_state_page(u32 vp_index, u64 partition_id,
> +			  struct page **state_page)
> +{
> +	struct hv_map_vp_state_page_in *input;
> +	struct hv_map_vp_state_page_out *output;
> +	int status;
> +	int ret;
> +	unsigned long flags;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D (struct hv_map_vp_state_page_in *)(*this_cpu_ptr(
> +			hyperv_pcpu_input_arg));
> +		output =3D (struct hv_map_vp_state_page_out *)(*this_cpu_ptr(
> +			hyperv_pcpu_output_arg));
> +
> +		input->partition_id =3D partition_id;
> +		input->vp_index =3D vp_index;
> +		input->type =3D HV_VP_STATE_PAGE_REGISTERS;
> +		status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE,
> +						   input, output);
> +
> +		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status =3D=3D HV_STATUS_SUCCESS)
> +				*state_page =3D pfn_to_page(output->map_location);
> +			else
> +				pr_err("%s: %s\n", __func__,
> +				       hv_status_to_string(status));
> +			local_irq_restore(flags);
> +			ret =3D -hv_status_to_errno(status);
> +			break;
> +		}
> +		local_irq_restore(flags);
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
>  static void
>  mshv_isr(void)
>  {
> @@ -1155,6 +1203,40 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioct=
l, unsigned long
> arg)
>  	return r;
>  }
>=20
> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
> +{
> +	struct mshv_vp *vp =3D vmf->vma->vm_file->private_data;
> +
> +	vmf->page =3D vp->register_page;
> +
> +	return 0;
> +}
> +
> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	int ret;
> +	struct mshv_vp *vp =3D file->private_data;
> +
> +	if (vma->vm_pgoff !=3D MSHV_VP_MMAP_REGISTERS_OFFSET)
> +		return -EINVAL;
> +
> +	if (mutex_lock_killable(&vp->mutex))
> +		return -EINTR;
> +
> +	if (!vp->register_page) {
> +		ret =3D hv_call_map_vp_state_page(vp->index,
> +						vp->partition->id,
> +						&vp->register_page);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	mutex_unlock(&vp->mutex);
> +
> +	vma->vm_ops =3D &mshv_vp_vm_ops;
> +	return 0;
> +}
> +
>  static int
>  mshv_vp_release(struct inode *inode, struct file *filp)
>  {
> --
> 2.25.1

