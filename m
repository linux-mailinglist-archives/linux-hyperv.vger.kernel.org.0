Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E18313F93
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 20:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhBHTvZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 14:51:25 -0500
Received: from mail-dm6nam08on2105.outbound.protection.outlook.com ([40.107.102.105]:50029
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236559AbhBHTuH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 14:50:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5gbW3qTQf8grEWNdHYFLXsbAZJ7z1PVhGBNlOxowIVH79Lr1hOYE9du+hdWVFIdS8Wfb+SrDC3WycUw4EiA342sVr1CtFAwQxen5KFJDIKh7JM0a5Z64sT94rnokTq1knuT3Ef8OYpkCqw/Ya2lie15nEtHPBzTs5pm33Ey70CTb0NX4jEYu/53bxn8XaU5eXXodtJTiWvFHuv77aDNbpYE54ib//KQj6I8BzIQoSwL+g4H9MCHy3Wjf6g38pQUF+7agreGsu/razeqADiLjxVLVyDnsCBzECL6iASfRdXG1mxP0+A0KHIN5r7mT7lSdPc8l5HXSCuCjYFQdkfUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udHVZ4JSY3K/M1fAIEjD7goHCpjJMVbwKsT2J9IGPmo=;
 b=azetRuTBYmyUbDVQJzaiHC1DIG2zcgMsaGybcuLjDal8usg+jwf1rxXPl+8U4ftJ82tCYyIWwqX6sad6hbav3+fWyC7D5JOSGQbX/AaXA2AELX65o6uYNS7IttzGFVVltK0bBHRkUJ9LcT6QCtBgv6+pvvvIB8nnnjhqCH1PkJ1bi+rCqAQTv8N0IHtHhgnnVIbzKm8/OJlu506CrfVObubuXhS650f/VzYeX0QRAxM9x9xO23m5LhQjNwv0V/U5EVsSUsKe172ZrRKk0I0kfK0QvtzbV7VyjCUwdpAmAV5Y97oEfb73eyvhaF/oy5OKaLIB648I6fnSEiBVXXP/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udHVZ4JSY3K/M1fAIEjD7goHCpjJMVbwKsT2J9IGPmo=;
 b=dUdzkeLavXBcV538V0m3iWGrVGuXZNcZnD1aSPlwOJVlTHMkS7I+skiusV3gZhcKS7UD71Y8HT/b6H7RF0mQ3Mo/EDIC0OcT/HboUyoIy1ABXoel9xDKeyJ3h1NIsjv6mUdks9hkz/8rWe6XHudrmMcmq28wQLHKZQ3Cg1QGR9c=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Mon, 8 Feb
 2021 19:48:41 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:48:41 +0000
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
Subject: RE: [RFC PATCH 15/18] virt/mshv: get and set vp state ioctls
Thread-Topic: [RFC PATCH 15/18] virt/mshv: get and set vp state ioctls
Thread-Index: AQHWv52R00EpTnFYh0K5/8xYFtXcEKpO+q/w
Date:   Mon, 8 Feb 2021 19:48:41 +0000
Message-ID: <MWHPR21MB1593B7D15C0607464B9394E5D78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-16-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-16-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:48:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d2b80f17-76a8-4bb4-b0da-d2e7d6bb48be;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fb1d31f-0e48-4221-d718-08d8cc6a898f
x-ms-traffictypediagnostic: MWHPR21MB1546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB1546B3A6BF7B9A575CDFE46CD78F9@MWHPR21MB1546.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnyhTlcTrrwuIMllnBnUVXC+Tjhc8ir3/FI+n1Etm3YIPzTKcz3LM8kE8QfEep2kBgfdU/uonJeKDQ/MNmnF3iAmR1lb/doesXw5jv28epQXPp/Hb4p9VeftopyqqnQQX7b4a6RTGntyqUaaubqpEbu7t9NsAeh2AjIObf3KVdaSVezCUA64Q3oZIa2W/gZoUwO5NqzemM1G8Z/Jyed6XoXdeDPSx2IZFV9Y1iEeop8vqZF7CzzmcGvwgParC13BlYyZyPbl14gqXGz4ArIBINO/g32Zh8Od7mzZAe4zpm+FzdrCXaYsu4uK0myDyg9zqJN5x89aOT7BohdrMen683+vjMPeYqAgq5R5B8fyYi+n8mj+Jtwk0xpBcWJLfypx/Gs7YqnirYM/xMsoEyshDnW9rVjiVWOypQJ+EEdl676zrOH/sw+bJvLUId3WBgWViHTLso13tnuDT7ioQFQxSXPS5FMJzgduoR1dGq1wh083NaJJ0cZZHmJZZ4uD8cBfLcPAttrkasNGombHBa6cEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(53546011)(7696005)(30864003)(64756008)(76116006)(6506007)(83380400001)(82960400001)(10290500003)(66446008)(66556008)(86362001)(4326008)(66946007)(54906003)(110136005)(107886003)(8676002)(5660300002)(33656002)(8936002)(2906002)(26005)(316002)(66476007)(186003)(52536014)(478600001)(8990500004)(71200400001)(82950400001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v1XeX+wKLNGihSjqA65UEEGBmDbvwrIj6H89ia3nXGjiN4bZ4GydEaef41cP?=
 =?us-ascii?Q?SJoUVNJGtT2Iv6WUFKlQ0GXLmd6pDTmEvwX7EQ5ppQoAZknNmJdavqPccj1c?=
 =?us-ascii?Q?8+wXIjEqxQbVbOwCmdKB7Rx0p7ZRbHomEYk+53JFNzllNtoTFwOUeTngYak3?=
 =?us-ascii?Q?9Ao88Rv4Nh8G+NsU/NBULI0CgHYha4F0w+Xl5CFK4IA5Z8WxUOMu4a/JXP4O?=
 =?us-ascii?Q?1OBVqGiG6Xn4LuY/ovkkkW5CGOGTKFSLqTErOPaFhySE0HewG+dhawOHFeN9?=
 =?us-ascii?Q?kr8bRv1xKrH1LUVCjMSGdF4mhWvJPu9WmNBfx+A6yXqYdaqU5QlcI9pF9jPY?=
 =?us-ascii?Q?4VP0gwWRTN8OV8FO+UVK2PHJMJ+kpYiVW3Xj5oUD29WY7l/LkKmVlm/zTFF2?=
 =?us-ascii?Q?I48//dzhNSqumICRE1uTZzxF5Gd3k/ckjiR/Oz0KyP1tV/OjNDFasQV/9gdh?=
 =?us-ascii?Q?fN6v90geEEfmck4X80NK4fujbD5yckF9zvPBySrNzh+VqYGLI+F3Mf3y+t5J?=
 =?us-ascii?Q?DsYamQlIcW8vPYpfAOaSFpNg6QiEHt/RJ2uBf2gfgeYci00s5CA/GviEcSz5?=
 =?us-ascii?Q?y4Ddxv4aWPfoC5Mubs63v8G2CKxUiUSL6qcPCD1n4qtLGyJq66OdGTv19LmJ?=
 =?us-ascii?Q?H+PBRp/V5U32pLNmAvLdlXFf/vSB0UICDF58n/DxnD0l7tAodAX6d2jwum/o?=
 =?us-ascii?Q?3PTqW/9j5x1xvpHoNIoNYomGMZ3aZavOSauoOG4D0zVhVkAzplmp1F2Iz5gE?=
 =?us-ascii?Q?vmxPWccTajr54Urmm//D8xn4JTOBIgcjG235jlGtLzXpwAQsofQxEBPDQFe9?=
 =?us-ascii?Q?cnZEDH1mU1nKWLqJBxNH3Vry0gFhKaklRrbp7rBj62lQzQRdcBV4lxSPje3g?=
 =?us-ascii?Q?SP2+yZihAayOJ2t1R02QVOfEISdzjFH1TF6Wa5A8XqAVb+//MxeSJLOpNfaK?=
 =?us-ascii?Q?MANzeWJRoIX5z6HQMQQp4Y8qnaPPHd9sjXbm2Xpx2PTpbk8r68i3S8ZWVh0T?=
 =?us-ascii?Q?MR7gtPtsSDyn26girohZTGQhRPUwJrX5ci+KUGJgYij7QnjaY1IxYCE8QZsk?=
 =?us-ascii?Q?D+GrU6Dlqt330LGXVgbOZ2/Orfr2rj/Fqjt4FSQ84MDHq9J5Nc+mCu9KSG+3?=
 =?us-ascii?Q?JNX0UB5CrrZSkrmbgVb7lM5x16x8cZeAgQDyaiwT/wtzDgbmECeh963ZtiN+?=
 =?us-ascii?Q?70h2yVT+W5pOAIkbLfub69dQ1NUQOpWq49N2IzFtVz9TAVtSnOY9iE1OOv8j?=
 =?us-ascii?Q?RN1sS9ur0Ri60KLN5m9yNlbqt6lAa3SxTmTuXYYy6v6TjvkCTRFLRrWjyjrZ?=
 =?us-ascii?Q?QhGWN8SzXPhT/PoCaB8B0vDO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb1d31f-0e48-4221-d718-08d8cc6a898f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:48:41.8620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+6wulNZe+Nf0/k2kDNo0knesJaNxpiXkbq/nzqD+2gXbYn2ENdiuYs2BM2cu5tuxfDd7HKzLPmI6ErtRtN8vmR9PXw3MVuHpgnjmNebYak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1546
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Novem=
ber 20, 2020 4:31 PM
> To: linux-hyperv@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.o=
rg; Michael Kelley
> <mikelley@microsoft.com>; viremana@linux.microsoft.com; Sunil Muthuswamy
> <sunilmut@microsoft.com>; nunodasneves@linux.microsoft.com; wei.liu@kerne=
l.org;
> Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>
> Subject: [RFC PATCH 15/18] virt/mshv: get and set vp state ioctls
>=20
> Introduce ioctls for getting and setting guest vcpu emulated LAPIC
> state, and xsave data.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  Documentation/virt/mshv/api.rst         |   8 +
>  arch/x86/include/uapi/asm/hyperv-tlfs.h |  59 ++++++
>  include/asm-generic/hyperv-tlfs.h       |  41 ++++
>  include/uapi/asm-generic/hyperv-tlfs.h  |  28 +++
>  include/uapi/linux/mshv.h               |  13 ++
>  virt/mshv/mshv_main.c                   | 262 ++++++++++++++++++++++++
>  6 files changed, 411 insertions(+)
>=20
> diff --git a/Documentation/virt/mshv/api.rst b/Documentation/virt/mshv/ap=
i.rst
> index 694f978131f9..7fd75f248eff 100644
> --- a/Documentation/virt/mshv/api.rst
> +++ b/Documentation/virt/mshv/api.rst
> @@ -140,4 +140,12 @@ Assert interrupts in partitions that use Microsoft H=
ypervisor's
> internal
>  emulated LAPIC. This must be enabled on partition creation with the flag=
:
>  HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED
>=20
> +3.9 MSHV_GET_VP_STATE and MSHV_SET_VP_STATE
> +--------------------------
> +:Type: vp ioctl
> +:Parameters: struct mshv_vp_state
> +:Returns: 0 on success
> +
> +Get/set various vp state. Currently these can be used to get and set
> +emulated LAPIC state, and xsave data.
>=20
> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/u=
api/asm/hyperv-
> tlfs.h
> index 5478d4943bfc..78758aedf23e 100644
> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
> @@ -1051,4 +1051,63 @@ union hv_interrupt_control {
>  	__u64 as_uint64;
>  };
>=20
> +struct hv_local_interrupt_controller_state {
> +	__u32 apic_id;
> +	__u32 apic_version;
> +	__u32 apic_ldr;
> +	__u32 apic_dfr;
> +	__u32 apic_spurious;
> +	__u32 apic_isr[8];
> +	__u32 apic_tmr[8];
> +	__u32 apic_irr[8];
> +	__u32 apic_esr;
> +	__u32 apic_icr_high;
> +	__u32 apic_icr_low;
> +	__u32 apic_lvt_timer;
> +	__u32 apic_lvt_thermal;
> +	__u32 apic_lvt_perfmon;
> +	__u32 apic_lvt_lint0;
> +	__u32 apic_lvt_lint1;
> +	__u32 apic_lvt_error;
> +	__u32 apic_lvt_cmci;
> +	__u32 apic_error_status;
> +	__u32 apic_initial_count;
> +	__u32 apic_counter_value;
> +	__u32 apic_divide_configuration;
> +	__u32 apic_remote_read;
> +};
> +
> +#define HV_XSAVE_DATA_NO_XMM_REGISTERS 1
> +
> +union hv_x64_xsave_xfem_register {
> +	__u64 as_uint64;
> +	struct {
> +		__u32 low_uint32;
> +		__u32 high_uint32;
> +	};
> +	struct {
> +		__u64 legacy_x87: 1;
> +		__u64 legacy_sse: 1;
> +		__u64 avx: 1;
> +		__u64 mpx_bndreg: 1;
> +		__u64 mpx_bndcsr: 1;
> +		__u64 avx_512_op_mask: 1;
> +		__u64 avx_512_zmmhi: 1;
> +		__u64 avx_512_zmm16_31: 1;
> +		__u64 rsvd8_9: 2;
> +		__u64 pasid: 1;
> +		__u64 cet_u: 1;
> +		__u64 cet_s: 1;
> +		__u64 rsvd13_16: 4;
> +		__u64 xtile_cfg: 1;
> +		__u64 xtile_data: 1;
> +		__u64 rsvd19_63: 45;
> +	};
> +};
> +
> +struct hv_vp_state_data_xsave {
> +	__u64 flags;
> +	union hv_x64_xsave_xfem_register states;
> +};
> +
>  #endif
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 2cd46241c545..4bc59a0344ce 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -167,6 +167,9 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> +#define HVCALL_MAP_VP_STATE_PAGE			0x00e1
> +#define HVCALL_GET_VP_STATE				0x00e3
> +#define HVCALL_SET_VP_STATE				0x00e4
>=20
>  #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
>  #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
> @@ -796,4 +799,42 @@ struct hv_assert_virtual_interrupt {
>  	u16 rsvd_z1;
>  };
>=20
> +struct hv_vp_state_data {
> +	enum hv_get_set_vp_state_type type;
> +	u32 rsvd;
> +	struct hv_vp_state_data_xsave xsave;
> +
> +};
> +
> +struct hv_get_vp_state_in {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 input_vtl;
> +	u8 rsvd0;
> +	u16 rsvd1;
> +	struct hv_vp_state_data state_data;
> +	u64 output_data_pfns[];
> +};
> +
> +union hv_get_vp_state_out {
> +	struct hv_local_interrupt_controller_state interrupt_controller_state;
> +	/* Not supported yet */
> +	/* struct hv_synthetic_timers_state synthetic_timers_state; */
> +};
> +
> +union hv_input_set_vp_state_data {
> +	u64 pfns;
> +	u8 bytes;
> +};
> +
> +struct hv_set_vp_state_in {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 input_vtl;
> +	u8 rsvd0;
> +	u16 rsvd1;
> +	struct hv_vp_state_data state_data;
> +	union hv_input_set_vp_state_data data[];
> +};
> +
>  #endif
> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-ge=
neric/hyperv-
> tlfs.h
> index e87389054b68..b3c84c69b73f 100644
> --- a/include/uapi/asm-generic/hyperv-tlfs.h
> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
> @@ -64,4 +64,32 @@ struct hv_message {
>  #define HV_MAP_GPA_EXECUTABLE           0xC
>  #define HV_MAP_GPA_PERMISSIONS_MASK     0xF
>=20
> +/*
> + * For getting and setting VP state, there are two options based on the =
state type:
> + *
> + *     1.) Data that is accessed by PFNs in the input hypercall page. Th=
is is used
> + *         for state which may not fit into the hypercall pages.
> + *     2.) Data that is accessed directly in the input\output hypercall =
pages.
> + *         This is used for state that will always fit into the hypercal=
l pages.
> + *
> + * In the future this could be dynamic based on the size if needed.
> + *
> + * Note these hypercalls have an 8-byte aligned variable header size as =
per the tlfs
> + */
> +
> +#define HV_GET_SET_VP_STATE_TYPE_PFN	BIT(31)
> +
> +enum hv_get_set_vp_state_type {
> +	HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE =3D 0,
> +
> +	HV_GET_SET_VP_STATE_XSAVE		=3D 1 |
> HV_GET_SET_VP_STATE_TYPE_PFN,
> +	/* Synthetic message page */
> +	HV_GET_SET_VP_STATE_SIM_PAGE		=3D 2 |
> HV_GET_SET_VP_STATE_TYPE_PFN,
> +	/* Synthetic interrupt event flags page. */
> +	HV_GET_SET_VP_STATE_SIEF_PAGE		=3D 3 |
> HV_GET_SET_VP_STATE_TYPE_PFN,
> +
> +	/* Synthetic timers. */
> +	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS	=3D 4,
> +};
> +
>  #endif
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index faed9d065bb7..ae0bb64bbec3 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -53,6 +53,17 @@ struct mshv_assert_interrupt {
>  	__u32 vector;
>  };
>=20
> +struct mshv_vp_state {
> +	enum hv_get_set_vp_state_type type;
> +	struct hv_vp_state_data_xsave xsave; /* only for xsave request */
> +
> +	__u64 buf_size; /* If xsave, must be page-aligned */
> +	union {
> +		struct hv_local_interrupt_controller_state *lapic;
> +		__u8 *bytes; /* Xsave data. must be page-aligned */
> +	} buf;
> +};
> +
>  #define MSHV_IOCTL 0xB8
>=20
>  /* mshv device */
> @@ -70,5 +81,7 @@ struct mshv_assert_interrupt {
>  #define MSHV_GET_VP_REGISTERS   _IOWR(MSHV_IOCTL, 0x05, struct
> mshv_vp_registers)
>  #define MSHV_SET_VP_REGISTERS   _IOW(MSHV_IOCTL, 0x06, struct mshv_vp_re=
gisters)
>  #define MSHV_RUN_VP		_IOR(MSHV_IOCTL, 0x07, struct hv_message)
> +#define MSHV_GET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0A, struct mshv_vp_state)
> +#define MSHV_SET_VP_STATE	_IOWR(MSHV_IOCTL, 0x0B, struct mshv_vp_state)
>=20
>  #endif
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index 9cf236ade50a..70172d9488de 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -864,6 +864,262 @@ mshv_vp_ioctl_set_regs(struct mshv_vp *vp, void __u=
ser
> *user_args)
>  	return ret;
>  }
>=20
> +static int
> +hv_call_get_vp_state(u32 vp_index,
> +		     u64 partition_id,
> +		     enum hv_get_set_vp_state_type type,
> +		     struct hv_vp_state_data_xsave xsave,
> +		    /* Choose between pages and ret_output */
> +		     u64 page_count,
> +		     struct page **pages,
> +		     union hv_get_vp_state_out *ret_output)
> +{
> +	struct hv_get_vp_state_in *input;
> +	union hv_get_vp_state_out *output;
> +	int status;
> +	int i;
> +	u64 control;
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	if (sizeof(*input) + (page_count * sizeof(u64)) > PAGE_SIZE)
> +		return -EINVAL;

Nit:  Stylistically, you are handling this differently from the BATCH_SIZE
macros, which are essentially doing the same thing of calculating
how many entries will fit in the input page.   Note to use
HV_HYP_PAGE_SIZE.

> +
> +	if (!page_count && !ret_output)
> +		return -EINVAL;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D (struct hv_get_vp_state_in *)
> +				(*this_cpu_ptr(hyperv_pcpu_input_arg));
> +		output =3D (union hv_get_vp_state_out *)
> +				(*this_cpu_ptr(hyperv_pcpu_output_arg));
> +		memset(input, 0, sizeof(*input));
> +		memset(output, 0, sizeof(*output));
> +
> +		input->partition_id =3D partition_id;
> +		input->vp_index =3D vp_index;
> +		input->state_data.type =3D type;
> +		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
> +		for (i =3D 0; i < page_count; i++)
> +			input->output_data_pfns[i] =3D
> +				page_to_pfn(pages[i]) & HV_MAP_GPA_MASK;
> +
> +		control =3D (HVCALL_GET_VP_STATE) |
> +			  (page_count << HV_HYPERCALL_VARHEAD_OFFSET);
> +
> +		status =3D hv_do_hypercall(control, input, output) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +
> +		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status !=3D HV_STATUS_SUCCESS)
> +				pr_err("%s: %s\n", __func__,
> +				       hv_status_to_string(status));
> +			else if (ret_output)
> +				memcpy(ret_output, output, sizeof(*output));
> +
> +			local_irq_restore(flags);
> +			ret =3D -hv_status_to_errno(status);
> +			break;
> +		}
> +		local_irq_restore(flags);
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +static int
> +hv_call_set_vp_state(u32 vp_index,
> +		     u64 partition_id,
> +		     enum hv_get_set_vp_state_type type,
> +		     struct hv_vp_state_data_xsave xsave,
> +		    /* Choose between pages and bytes */
> +		     u64 page_count,
> +		     struct page **pages,
> +		     u32 num_bytes,
> +		     u8 *bytes)
> +{
> +	struct hv_set_vp_state_in *input;
> +	int status;
> +	int i;
> +	u64 control;
> +	unsigned long flags;
> +	int ret =3D 0;
> +	u16 varhead_sz;
> +
> +	if (sizeof(*input) + (page_count * sizeof(u64)) > PAGE_SIZE)

Same comment as above.

> +		return -EINVAL;
> +	if (sizeof(*input) + num_bytes > PAGE_SIZE)

Use HV_HYP_PAGE_SIZE.

> +		return -EINVAL;
> +
> +	if (num_bytes)
> +		/* round up to 8 and divide by 8 */
> +		varhead_sz =3D (num_bytes + 7) >> 3;
> +	else if (page_count)
> +		varhead_sz =3D  page_count;
> +	else
> +		return -EINVAL;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D (struct hv_set_vp_state_in *)
> +				(*this_cpu_ptr(hyperv_pcpu_input_arg));
> +		memset(input, 0, sizeof(*input));
> +
> +		input->partition_id =3D partition_id;
> +		input->vp_index =3D vp_index;
> +		input->state_data.type =3D type;
> +		memcpy(&input->state_data.xsave, &xsave, sizeof(xsave));
> +		if (num_bytes) {
> +			memcpy((u8 *)input->data, bytes, num_bytes);
> +		} else {
> +			for (i =3D 0; i < page_count; i++)
> +				input->data[i].pfns =3D
> +					page_to_pfn(pages[i]) & HV_MAP_GPA_MASK;

Same comment as in earlier patch about GPA_MASK.  Also, this doesn't work
if PAGE_SIZE !=3D HV_HYP_PAGE_SIZE, though it may be fine to not handle tha=
t case
for now.

> +		}
> +
> +		control =3D (HVCALL_SET_VP_STATE) |
> +			  (varhead_sz << HV_HYPERCALL_VARHEAD_OFFSET);
> +
> +		status =3D hv_do_hypercall(control, input, NULL) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +
> +		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status !=3D HV_STATUS_SUCCESS)
> +				pr_err("%s: %s\n", __func__,
> +				       hv_status_to_string(status));
> +
> +			local_irq_restore(flags);
> +			ret =3D -hv_status_to_errno(status);
> +			break;
> +		}
> +		local_irq_restore(flags);
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +static long
> +mshv_vp_ioctl_get_set_state_pfn(struct mshv_vp *vp,
> +				struct mshv_vp_state *args,
> +				bool is_set)
> +{
> +	u64 page_count, remaining;
> +	int completed;
> +	struct page **pages;
> +	long ret;
> +	unsigned long u_buf;
> +
> +	/* Buffer must be page aligned */
> +	if (args->buf_size & (PAGE_SIZE - 1) ||
> +	    (u64)args->buf.bytes & (PAGE_SIZE - 1))
> +		return -EINVAL;

Use PAGE_ALIGNED macro.

> +
> +	if (!access_ok(args->buf.bytes, args->buf_size))
> +		return -EFAULT;
> +
> +	/* Pin user pages so hypervisor can copy directly to them */
> +	page_count =3D args->buf_size >> PAGE_SHIFT;
> +	pages =3D kcalloc(page_count, sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	remaining =3D page_count;
> +	u_buf =3D (unsigned long)args->buf.bytes;
> +	while (remaining) {
> +		completed =3D pin_user_pages_fast(
> +				u_buf,
> +				remaining,
> +				FOLL_WRITE,
> +				&pages[page_count - remaining]);
> +		if (completed < 0) {
> +			pr_err("%s: failed to pin user pages error %i\n",
> +			       __func__, completed);
> +			ret =3D completed;
> +			goto unpin_pages;
> +		}
> +		remaining -=3D completed;
> +		u_buf +=3D completed * PAGE_SIZE;
> +	}
> +
> +	if (is_set)
> +		ret =3D hv_call_set_vp_state(vp->index,
> +					   vp->partition->id,
> +					   args->type, args->xsave,
> +					   page_count, pages,
> +					   0, NULL);
> +	else
> +		ret =3D hv_call_get_vp_state(vp->index,
> +					   vp->partition->id,
> +					   args->type, args->xsave,
> +					   page_count, pages,
> +					   NULL);
> +
> +unpin_pages:
> +	unpin_user_pages(pages, page_count - remaining);
> +	kfree(pages);
> +	return ret;
> +}
> +
> +static long
> +mshv_vp_ioctl_get_set_state(struct mshv_vp *vp, void __user *user_args, =
bool is_set)
> +{
> +	struct mshv_vp_state args;
> +	long ret =3D 0;
> +	union hv_get_vp_state_out vp_state;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	/* For now just support these */
> +	if (args.type !=3D HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE=
 &&
> +	    args.type !=3D HV_GET_SET_VP_STATE_XSAVE)
> +		return -EINVAL;
> +
> +	/* If we need to pin pfns, delegate to helper */
> +	if (args.type & HV_GET_SET_VP_STATE_TYPE_PFN)
> +		return mshv_vp_ioctl_get_set_state_pfn(vp, &args, is_set);
> +
> +	if (args.buf_size < sizeof(vp_state))
> +		return -EINVAL;
> +
> +	if (is_set) {
> +		if (copy_from_user(
> +				&vp_state,
> +				args.buf.lapic,
> +				sizeof(vp_state)))
> +			return -EFAULT;
> +
> +		return hv_call_set_vp_state(vp->index,
> +					    vp->partition->id,
> +					    args.type, args.xsave,
> +					    0, NULL,
> +					    sizeof(vp_state),
> +					    (u8 *)&vp_state);
> +	}
> +
> +	ret =3D hv_call_get_vp_state(vp->index,
> +				   vp->partition->id,
> +				   args.type, args.xsave,
> +				   0, NULL,
> +				   &vp_state);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user(args.buf.lapic,
> +			 &vp_state.interrupt_controller_state,
> +			 sizeof(vp_state.interrupt_controller_state)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
>=20
>  static long
>  mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> @@ -884,6 +1140,12 @@ mshv_vp_ioctl(struct file *filp, unsigned int ioctl=
, unsigned long
> arg)
>  	case MSHV_SET_VP_REGISTERS:
>  		r =3D mshv_vp_ioctl_set_regs(vp, (void __user *)arg);
>  		break;
> +	case MSHV_GET_VP_STATE:
> +		r =3D mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, false);
> +		break;
> +	case MSHV_SET_VP_STATE:
> +		r =3D mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
> +		break;
>  	default:
>  		r =3D -ENOTTY;
>  		break;
> --
> 2.25.1

