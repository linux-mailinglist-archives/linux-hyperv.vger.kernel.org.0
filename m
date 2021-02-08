Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D767D313F8B
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 20:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhBHTvO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 14:51:14 -0500
Received: from mail-bn8nam11on2102.outbound.protection.outlook.com ([40.107.236.102]:16195
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235417AbhBHTtZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 14:49:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvKQCtR8cP6OMVo3CUlOuCVLl0PVKoIC3NggBlz71tTfWkdtW8PUE0HlwjLJqSE1DfPa5z2fQgMQToz5+I5jNEX0NpgP84LPmpG/wOZpHk9+cKTkgh2sITY2gcZgZJoNWa+uaX0CZBjxCl1QDvkzeYjAFYyt9yO6nMqgi4FfaCAyh/nxzsnFeSxXLRX5CI161O5NNHkHc3c4no+Kvox8II9zDGN6WEQZr9iNV4IfuODuBHaKgKO0bnuJurYA2mbOfMxhOINtaeFgwke49AhhfDbikA5PpKf2VUrytMDJZ9HHzUOZP2LUN2TBZPd59bae8dVJjiPxn+QDVW57L4iDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gimXZ9dERR19yLG5TCMBJ+ZLY16t4AXeklfy0xUU6ow=;
 b=YxYFGyiCb+QKQAj41O31z4sDP0Yh7ZF/hgLxsu1Db6WIqT6Fkgnr5BGt67lbPXkmtfj2omWl/4PWNkP5XvainfVOKl1ypwnkRpZOWRi0PMq8OiUMFoPmwcCUgVYeAEZARQbDs7yH6cLJBTcdKzolgUUoohGX0R/UXWsORtx7Dupc5FmyYbe5/XqnP/iTYn9DiQ9BTLTOVbnOsTGCylMyJcKkxCkw/pDci3BI0eoRbzEM0n2vS7pByzWPs4ME8LwFFjnQIc1/zKucEAn8Q0ygXbk9LHXDJ7bLL09LDuz6PIWbHIKWghcdqOw2ZuHUAYeaZHO9qxOyR+eX/kxyM9SZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gimXZ9dERR19yLG5TCMBJ+ZLY16t4AXeklfy0xUU6ow=;
 b=S9awQM+kJzImTWkxWQYtUTPg39UejrT3ZcwTBA72VJ+7mqOlT49UwdyaWo1cJjSm6zBlUoCz0xFNUXYtytoi1rJE0uZWmXZH2nBGxXTVPK8fjw/hlvJRMMp+nLgw9YS7Z0eNC5gIOrgXL5bkoPG/UCXdaoAXOvoPOBVoBTAZcPc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB1546.namprd21.prod.outlook.com (2603:10b6:301:7c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.5; Mon, 8 Feb
 2021 19:47:49 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3868.006; Mon, 8 Feb 2021
 19:47:49 +0000
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
Subject: RE: [RFC PATCH 11/18] virt/mshv: set up synic pages for intercept
 messages
Thread-Topic: [RFC PATCH 11/18] virt/mshv: set up synic pages for intercept
 messages
Thread-Index: AQHWv52Sf16Ua5UbGEyERkZGDy8rgqpN98MA
Date:   Mon, 8 Feb 2021 19:47:49 +0000
Message-ID: <MWHPR21MB1593EC8F1ACA57299AB5016AD78F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-12-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1605918637-12192-12-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-08T19:47:46Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7a78d0f5-5ff4-45bf-a87e-cae321a981f4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1409a21-4af0-4d95-a082-08d8cc6a6a3c
x-ms-traffictypediagnostic: MWHPR21MB1546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB15469A92542A98263C140333D78F9@MWHPR21MB1546.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9q7RzSDQr54M9es98HLaxJmg27yx++cNdp1P+Wi1YxnICulLxHL5zzrMsbDLOLiEQ//vVHTOXkjjgG8X0bhhJAE279cYNHU8PaQ7GLNzWxCEvwxH7+PFBNG8774JU5eXhTQ3hxi5oiy6FNhxcabNP0KRVXIpgxTUOOmBFdqwidFanvezTAAK4ziuuujtVJ5elInv9YvUS/R7yZyHEGt5NlgwbWk0tNCcnjC0Kb2DpGlhgQZ4Hlrx+yRsGG9CU1bMxqN6oEwDI8xo+JcBkLhpvwkLPf4S05U1zjGNqf7giBPPP4R5PAR6OQA+fzNhSEvWTHBg0WCl65uNIY3GEmpF+WBUlumpFBRND+ibSMZRhssVaBllnb4XsS221wtsMHIRydMUNqIXEAVe9wV6Epw5gGL/QVV/WfSv2siqC/gN9gi+ITeYIn4zNl2/wEQr9IUX9yoz5xPG53H0Z+SDtl1F2gUh7rqL2zJaHbosjCi+bCu6FRKdErHFUl3huQLcHYxZrJBPbIfBcCyeD1UD9oSL8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(7696005)(30864003)(64756008)(76116006)(6506007)(83380400001)(82960400001)(10290500003)(66446008)(66556008)(86362001)(4326008)(66946007)(54906003)(110136005)(107886003)(8676002)(5660300002)(33656002)(8936002)(2906002)(26005)(316002)(66476007)(15650500001)(186003)(52536014)(478600001)(8990500004)(71200400001)(82950400001)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/CzvZhn9uF6WqvMIxlMqH363ODPcU+C3KbH0CaAmpUQN8mwRJN5DE/0jjoPM?=
 =?us-ascii?Q?Dpj8GzamGI05QTgt7kqAgL0u+mTDKOeWC84KJ/2L/ws2zsrLopoCLVF7ofI9?=
 =?us-ascii?Q?Z6DmZ05F2jOprZRgnq0nZVgmD1AGWQWfNhlp7Mp0wI2io7OMmRs0ZmlomdI+?=
 =?us-ascii?Q?SwfvZjlFyb3NUEPX50UV6CZkx/D5rXACfVR7IUDrxwg0le6o9oyg619JxMcv?=
 =?us-ascii?Q?TVIVFeMneFMamQPUQn0E1Uxu2pmjq3FKh/LpFYhw+C/kK1eiEPPk88cUSj9l?=
 =?us-ascii?Q?fTfULFvDIAg8TaK7gOs+dgFw8/3X9v81OlUGrdtYDp1kikkAyDk8zABi1ISJ?=
 =?us-ascii?Q?o9ii5Axsh4gK9c4OhKog+xscg5OIIfc9rzEjISVueFOsj4whfblxOYyvarFu?=
 =?us-ascii?Q?kcNClEIPesW7D0EQDt18EXdj7neOPrGte4yCy3dt9UvYUQdOAXxNZnraoHQR?=
 =?us-ascii?Q?jChDW600BQm6b9VsXqqtDw40PFIUaT73nbaX+giT/ElxFCWbm4uFyqht85j3?=
 =?us-ascii?Q?Vngfq7FnIdlvJBhWs+Vs3/fll1DA06RSI61WJJkTiyC04hla85D022p5tzfi?=
 =?us-ascii?Q?NCR1MP1b6gp+VfOtvAa5Z3bBKfqDLMQ3YKSn60ctkzJhrChhRnMbrz+Y3/21?=
 =?us-ascii?Q?bTECuqr2qq987q2mJKqU3sUiSpT+IBXH2L/iycxopJUXpuimK8vohOrfejcG?=
 =?us-ascii?Q?G/77J2ANMJUfX7RKw6nd64+jBtf17deAYU+zvWlUIFJbZWHTMbrP0nFNMpb6?=
 =?us-ascii?Q?B3oN00e57BKGeXK36XrhSVqxfEe5Yv99i9wR+40b9ZzgsKdvUAp1IdxChqKG?=
 =?us-ascii?Q?dm27VcSAnl6ZUoyzabA4An+kU8T+cw+2bU/bYUMKSYPnCVVFbsp0cWxV670D?=
 =?us-ascii?Q?lE0gU40c0hmERcobOFnUe6hiQaX5akmxvDPFZNvKenvpKFNQyYjgiUzvUZJm?=
 =?us-ascii?Q?mfrUTiYBb+FrGaHiHt/9CDDvFW1TH9f1U26ACn9DEBFoEFcNsYh70bcYgkLj?=
 =?us-ascii?Q?F58UZts2OQ2nkDeVaspJI7cSVSee3fqfyq6xGxlmZ/RniE76eBFljqTj003l?=
 =?us-ascii?Q?0zhqVH8JKytowUH8JFCZf1be9iYvcpA1PPt5sA47HG70RlsbtxkJJrMrLYTJ?=
 =?us-ascii?Q?UXKa9NHRra/n6m9XzaU7zHnyYX6dOW8w28f/S1GhXKmoJ6kIAGCHF9+trJZ9?=
 =?us-ascii?Q?4pQo6XzR3zljqM8Nj3XdCHnu0aLjWtTHb6I8/rQP7ViVGin9WkXVUX8U9yaN?=
 =?us-ascii?Q?LnsRfHG59xeLYLEWG/io//OmiPoHPWON3Vdzfe6UQ9v7y5FpwkCK60uLfyiO?=
 =?us-ascii?Q?ZaPXxJIGDmGFZNUCRH7yY85N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1409a21-4af0-4d95-a082-08d8cc6a6a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 19:47:49.2313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrjV/zvymMA0gWkE7TKacQ52p2WRAjTHrRY/twVa/rQfOUYYMrkbJPFjGDOwYcfjEsUvFQeEyako1+ZZ13N3bKEh0+rgwMZYVcr67lAxTVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1546
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Novem=
ber 20, 2020 4:31 PM
>=20
> Same idea as synic setup in drivers/hv/hv.c:hv_synic_enable_regs()
> and hv_synic_disable_regs().
> Setting up synic registers in both vmbus driver and mshv would clobber
> them, but the vmbus driver will not run in the root partition, so this
> is safe.
>=20
> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h      |  29 ---
>  arch/x86/include/uapi/asm/hyperv-tlfs.h | 264 ++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h       |  46 +----
>  include/linux/mshv.h                    |   1 +
>  include/uapi/asm-generic/hyperv-tlfs.h  |  43 ++++
>  virt/mshv/mshv_main.c                   |  98 ++++++++-
>  6 files changed, 404 insertions(+), 77 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 4cd44ae9bffb..c34a6bb4f457 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -267,35 +267,6 @@ struct hv_tsc_emulation_status {
>  #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
>  #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
>=20
> -
> -/* Define hypervisor message types. */
> -enum hv_message_type {
> -	HVMSG_NONE			=3D 0x00000000,
> -
> -	/* Memory access messages. */
> -	HVMSG_UNMAPPED_GPA		=3D 0x80000000,
> -	HVMSG_GPA_INTERCEPT		=3D 0x80000001,
> -
> -	/* Timer notification messages. */
> -	HVMSG_TIMER_EXPIRED		=3D 0x80000010,
> -
> -	/* Error messages. */
> -	HVMSG_INVALID_VP_REGISTER_VALUE	=3D 0x80000020,
> -	HVMSG_UNRECOVERABLE_EXCEPTION	=3D 0x80000021,
> -	HVMSG_UNSUPPORTED_FEATURE	=3D 0x80000022,
> -
> -	/* Trace buffer complete messages. */
> -	HVMSG_EVENTLOG_BUFFERCOMPLETE	=3D 0x80000040,
> -
> -	/* Platform-specific processor intercept messages. */
> -	HVMSG_X64_IOPORT_INTERCEPT	=3D 0x80010000,
> -	HVMSG_X64_MSR_INTERCEPT		=3D 0x80010001,
> -	HVMSG_X64_CPUID_INTERCEPT	=3D 0x80010002,
> -	HVMSG_X64_EXCEPTION_INTERCEPT	=3D 0x80010003,
> -	HVMSG_X64_APIC_EOI		=3D 0x80010004,
> -	HVMSG_X64_LEGACY_FP_ERROR	=3D 0x80010005
> -};
> -
>  struct hv_nested_enlightenments_control {
>  	struct {
>  		__u32 directhypercall:1;
> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/u=
api/asm/hyperv-
> tlfs.h
> index 2ff655962738..c6a27053f791 100644
> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
> @@ -722,4 +722,268 @@ union hv_register_value {
>  		pending_virtualization_fault_event;
>  };
>=20
> +/* Define hypervisor message types. */
> +enum hv_message_type {
> +	HVMSG_NONE				=3D 0x00000000,
> +
> +	/* Memory access messages. */
> +	HVMSG_UNMAPPED_GPA			=3D 0x80000000,
> +	HVMSG_GPA_INTERCEPT			=3D 0x80000001,
> +
> +	/* Timer notification messages. */
> +	HVMSG_TIMER_EXPIRED			=3D 0x80000010,
> +
> +	/* Error messages. */
> +	HVMSG_INVALID_VP_REGISTER_VALUE		=3D 0x80000020,
> +	HVMSG_UNRECOVERABLE_EXCEPTION		=3D 0x80000021,
> +	HVMSG_UNSUPPORTED_FEATURE		=3D 0x80000022,
> +
> +	/* Trace buffer complete messages. */
> +	HVMSG_EVENTLOG_BUFFERCOMPLETE		=3D 0x80000040,
> +
> +	/* Platform-specific processor intercept messages. */
> +	HVMSG_X64_IO_PORT_INTERCEPT		=3D 0x80010000,
> +	HVMSG_X64_MSR_INTERCEPT			=3D 0x80010001,
> +	HVMSG_X64_CPUID_INTERCEPT		=3D 0x80010002,
> +	HVMSG_X64_EXCEPTION_INTERCEPT		=3D 0x80010003,
> +	HVMSG_X64_APIC_EOI			=3D 0x80010004,
> +	HVMSG_X64_LEGACY_FP_ERROR		=3D 0x80010005,
> +	HVMSG_X64_IOMMU_PRQ			=3D 0x80010006,
> +	HVMSG_X64_HALT				=3D 0x80010007,
> +	HVMSG_X64_INTERRUPTION_DELIVERABLE	=3D 0x80010008,
> +	HVMSG_X64_SIPI_INTERCEPT		=3D 0x80010009,
> +};

I have a separate patch series that moves this enum to the
asm-generic portion of hyperv-tlfs.h because there's not a good way
to separate the arch neutral from arch dependent values.

> +
> +
> +union hv_x64_vp_execution_state {
> +	__u16 as_uint16;
> +	struct {
> +		__u16 cpl:2;
> +		__u16 cr0_pe:1;
> +		__u16 cr0_am:1;
> +		__u16 efer_lma:1;
> +		__u16 debug_active:1;
> +		__u16 interruption_pending:1;
> +		__u16 vtl:4;
> +		__u16 enclave_mode:1;
> +		__u16 interrupt_shadow:1;
> +		__u16 virtualization_fault_active:1;
> +		__u16 reserved:2;
> +	};
> +};
> +
> +/* Values for intercept_access_type field */
> +#define HV_INTERCEPT_ACCESS_READ	0
> +#define HV_INTERCEPT_ACCESS_WRITE	1
> +#define HV_INTERCEPT_ACCESS_EXECUTE	2
> +
> +struct hv_x64_intercept_message_header {
> +	__u32 vp_index;
> +	__u8 instruction_length:4;
> +	__u8 cr8:4; // only set for exo partitions
> +	__u8 intercept_access_type;
> +	union hv_x64_vp_execution_state execution_state;
> +	struct hv_x64_segment_register cs_segment;
> +	__u64 rip;
> +	__u64 rflags;
> +};
> +
> +#define HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS 6
> +
> +struct hv_x64_hypercall_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u64 rax;
> +	__u64 rbx;
> +	__u64 rcx;
> +	__u64 rdx;
> +	__u64 r8;
> +	__u64 rsi;
> +	__u64 rdi;
> +	struct hv_u128 xmmregisters[HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS];
> +	struct {
> +		__u32 isolated:1;
> +		__u32 reserved:31;
> +	};
> +};
> +
> +union hv_x64_register_access_info {
> +	union hv_register_value source_value;
> +	enum hv_register_name destination_register;
> +	__u64 source_address;
> +	__u64 destination_address;
> +};
> +
> +struct hv_x64_register_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	struct {
> +		__u8 is_memory_op:1;
> +		__u8 reserved:7;
> +	};
> +	__u8 reserved8;
> +	__u16 reserved16;
> +	enum hv_register_name register_name;
> +	union hv_x64_register_access_info access_info;
> +};
> +
> +union hv_x64_memory_access_info {
> +	__u8 as_uint8;
> +	struct {
> +		__u8 gva_valid:1;
> +		__u8 gva_gpa_valid:1;
> +		__u8 hypercall_output_pending:1;
> +		__u8 tlb_locked_no_overlay:1;
> +		__u8 reserved:4;
> +	};
> +};
> +
> +union hv_x64_io_port_access_info {
> +	__u8 as_uint8;
> +	struct {
> +		__u8 access_size:3;
> +		__u8 string_op:1;
> +		__u8 rep_prefix:1;
> +		__u8 reserved:3;
> +	};
> +};
> +
> +union hv_x64_exception_info {
> +	__u8 as_uint8;
> +	struct {
> +		__u8 error_code_valid:1;
> +		__u8 software_exception:1;
> +		__u8 reserved:6;
> +	};
> +};
> +
> +enum hv_cache_type {
> +	HV_CACHE_TYPE_UNCACHED	   =3D 0,
> +	HV_CACHE_TYPE_WRITE_COMBINING =3D 1,
> +	HV_CACHE_TYPE_WRITE_THROUGH   =3D 4,
> +	HV_CACHE_TYPE_WRITE_PROTECTED =3D 5,
> +	HV_CACHE_TYPE_WRITE_BACK	  =3D 6
> +};
> +
> +struct hv_x64_memory_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	enum hv_cache_type cache_type;
> +	__u8 instruction_byte_count;
> +	union hv_x64_memory_access_info memory_access_info;
> +	__u8 tpr_priority;
> +	__u8 reserved1;
> +	__u64 guest_virtual_address;
> +	__u64 guest_physical_address;
> +	__u8 instruction_bytes[16];
> +};
> +
> +struct hv_x64_cpuid_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u64 rax;
> +	__u64 rcx;
> +	__u64 rdx;
> +	__u64 rbx;
> +	__u64 default_result_rax;
> +	__u64 default_result_rcx;
> +	__u64 default_result_rdx;
> +	__u64 default_result_rbx;
> +};
> +
> +struct hv_x64_msr_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u32 msr_number;
> +	__u32 reserved;
> +	__u64 rdx;
> +	__u64 rax;
> +};
> +
> +struct hv_x64_io_port_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u16 port_number;
> +	union hv_x64_io_port_access_info access_info;
> +	__u8 instruction_byte_count;
> +	__u32 reserved;
> +	__u64 rax;
> +	__u8 instruction_bytes[16];
> +	struct hv_x64_segment_register ds_segment;
> +	struct hv_x64_segment_register es_segment;
> +	__u64 rcx;
> +	__u64 rsi;
> +	__u64 rdi;
> +};
> +
> +struct hv_x64_exception_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u16 exception_vector;
> +	union hv_x64_exception_info exception_info;
> +	__u8 instruction_byte_count;
> +	__u32 error_code;
> +	__u64 exception_parameter;
> +	__u64 reserved;
> +	__u8 instruction_bytes[16];
> +	struct hv_x64_segment_register ds_segment;
> +	struct hv_x64_segment_register ss_segment;
> +	__u64 rax;
> +	__u64 rcx;
> +	__u64 rdx;
> +	__u64 rbx;

Is the above the correct ordering (rax, rcd, rdx, rbx)?
It's just what you would expect ....

> +	__u64 rsp;
> +	__u64 rbp;
> +	__u64 rsi;
> +	__u64 rdi;
> +	__u64 r8;
> +	__u64 r9;
> +	__u64 r10;
> +	__u64 r11;
> +	__u64 r12;
> +	__u64 r13;
> +	__u64 r14;
> +	__u64 r15;
> +};
> +
> +struct hv_x64_invalid_vp_register_message {
> +	__u32 vp_index;
> +	__u32 reserved;
> +};
> +
> +struct hv_x64_unrecoverable_exception_message {
> +	struct hv_x64_intercept_message_header header;
> +};
> +
> +enum hv_x64_unsupported_feature_code {
> +	hv_unsupported_feature_intercept =3D 1,
> +	hv_unsupported_feature_task_switch_tss =3D 2
> +};
> +
> +struct hv_x64_unsupported_feature_message {
> +	__u32 vp_index;
> +	enum hv_x64_unsupported_feature_code feature_code;
> +	__u64 feature_parameter;
> +};
> +
> +struct hv_x64_halt_message {
> +	struct hv_x64_intercept_message_header header;
> +};
> +
> +enum hv_x64_pending_interruption_type {
> +	HV_X64_PENDING_INTERRUPT	=3D 0,
> +	HV_X64_PENDING_NMI		=3D 2,
> +	HV_X64_PENDING_EXCEPTION	=3D 3
> +};
> +
> +struct hv_x64_interruption_deliverable_message {
> +	struct hv_x64_intercept_message_header header;
> +	enum hv_x64_pending_interruption_type deliverable_type;
> +	__u32 rsvd;
> +};
> +
> +struct hv_x64_sipi_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u32 target_vp_index;
> +	__u32 interrupt_vector;
> +};
> +
> +struct hv_x64_apic_eoi_message {
> +	__u32 vp_index;
> +	__u32 interrupt_vector;
> +};

Same comments as before about enum types, not depending
on the compiler to add padding, and marking as __packed.

> +
>  #endif
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index b9295400c20b..e0185c3872a9 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -241,6 +241,8 @@ static inline const char *hv_status_to_string(enum hv=
_status status)
>  /* Valid SynIC vectors are 16-255. */
>  #define HV_SYNIC_FIRST_VALID_VECTOR	(16)
>=20
> +#define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
> +
>  #define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
>  #define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
>  #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
> @@ -250,49 +252,6 @@ static inline const char *hv_status_to_string(enum h=
v_status
> status)
>=20
>  #define HV_SYNIC_STIMER_COUNT		(4)
>=20
> -/* Define synthetic interrupt controller message constants. */
> -#define HV_MESSAGE_SIZE			(256)
> -#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
> -#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
> -
> -/* Define synthetic interrupt controller message flags. */
> -union hv_message_flags {
> -	__u8 asu8;
> -	struct {
> -		__u8 msg_pending:1;
> -		__u8 reserved:7;
> -	} __packed;
> -};
> -
> -/* Define port identifier type. */
> -union hv_port_id {
> -	__u32 asu32;
> -	struct {
> -		__u32 id:24;
> -		__u32 reserved:8;
> -	} __packed u;
> -};
> -
> -/* Define synthetic interrupt controller message header. */
> -struct hv_message_header {
> -	__u32 message_type;
> -	__u8 payload_size;
> -	union hv_message_flags message_flags;
> -	__u8 reserved[2];
> -	union {
> -		__u64 sender;
> -		union hv_port_id port;
> -	};
> -} __packed;
> -
> -/* Define synthetic interrupt controller message format. */
> -struct hv_message {
> -	struct hv_message_header header;
> -	union {
> -		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
> -	} u;
> -} __packed;
> -
>  /* Define the synthetic interrupt message page layout. */
>  struct hv_message_page {
>  	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
> @@ -306,7 +265,6 @@ struct hv_timer_message_payload {
>  	__u64 delivery_time;	/* When the message was delivered */
>  } __packed;
>=20
> -
>  /* Define synthetic interrupt controller flag constants. */
>  #define HV_EVENT_FLAGS_COUNT		(256 * 8)
>  #define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
> diff --git a/include/linux/mshv.h b/include/linux/mshv.h
> index dfe469f573f9..7709aaa1e064 100644
> --- a/include/linux/mshv.h
> +++ b/include/linux/mshv.h
> @@ -42,6 +42,7 @@ struct mshv_partition {
>  };
>=20
>  struct mshv {
> +	struct hv_message_page __percpu **synic_message_page;
>  	struct {
>  		spinlock_t lock;
>  		u64 count;
> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-ge=
neric/hyperv-
> tlfs.h
> index e7b09b9f00de..e87389054b68 100644
> --- a/include/uapi/asm-generic/hyperv-tlfs.h
> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
> @@ -6,6 +6,49 @@
>  #define BIT(X)	(1ULL << (X))
>  #endif
>=20
> +/* Define synthetic interrupt controller message constants. */
> +#define HV_MESSAGE_SIZE			(256)
> +#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
> +#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
> +
> +/* Define synthetic interrupt controller message flags. */
> +union hv_message_flags {
> +	__u8 asu8;
> +	struct {
> +		__u8 msg_pending:1;
> +		__u8 reserved:7;
> +	};
> +};
> +
> +/* Define port identifier type. */
> +union hv_port_id {
> +	__u32 asu32;
> +	struct {
> +		__u32 id:24;
> +		__u32 reserved:8;
> +	} u;
> +};
> +
> +/* Define synthetic interrupt controller message header. */
> +struct hv_message_header {
> +	enum hv_message_type message_type;
> +	__u8 payload_size;
> +	union hv_message_flags message_flags;
> +	__u8 reserved[2];
> +	union {
> +		__u64 sender;
> +		union hv_port_id port;
> +	};
> +};
> +
> +/* Define synthetic interrupt controller message format. */
> +struct hv_message {
> +	struct hv_message_header header;
> +	union {
> +		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
> +	} u;
> +};
> +
>  /* Userspace-visible partition creation flags */
>  #define HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST                BIT(=
0)
>  #define HV_PARTITION_CREATION_FLAG_GPA_LARGE_PAGES_DISABLED         BIT(=
3)
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index 2a10137a1e84..c9445d2edb37 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -15,6 +15,8 @@
>  #include <linux/file.h>
>  #include <linux/anon_inodes.h>
>  #include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/cpuhotplug.h>
>  #include <linux/mshv.h>
>  #include <asm/mshyperv.h>
>=20
> @@ -1152,23 +1154,111 @@ mshv_dev_release(struct inode *inode, struct fil=
e *filp)
>  	return 0;
>  }
>=20
> +static int
> +mshv_synic_init(unsigned int cpu)
> +{
> +	union hv_synic_simp simp;
> +	union hv_synic_sint sint;
> +	union hv_synic_scontrol sctrl;
> +	struct hv_message_page **msg_page =3D
> +			this_cpu_ptr(mshv.synic_message_page);
> +
> +	/* Setup the Synic's message page */
> +	hv_get_simp(simp.as_uint64);
> +	simp.simp_enabled =3D true;
> +	*msg_page =3D memremap(simp.base_simp_gpa << PAGE_SHIFT,
> +			     PAGE_SIZE, MEMREMAP_WB);

Use HV_HYP_PAGE_SHIFT and HV_HYP_PAGE_SIZE.

> +	if (!msg_page) {
> +		pr_err("%s: memremap failed\n", __func__);
> +		return -EFAULT;
> +	}
> +	hv_set_simp(simp.as_uint64);
> +
> +	/* Enable intercepts */
> +	sint.as_uint64 =3D 0;
> +	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked =3D false;
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +	hv_set_synint_state(HV_SYNIC_INTERCEPTION_SINT_INDEX, sint.as_uint64);
> +
> +	/* Enable global synic bit */
> +	hv_get_synic_state(sctrl.as_uint64);
> +	sctrl.enable =3D 1;
> +	hv_set_synic_state(sctrl.as_uint64);
> +
> +	return 0;
> +}
> +
> +static int
> +mshv_synic_cleanup(unsigned int cpu)
> +{
> +	union hv_synic_sint sint;
> +	union hv_synic_simp simp;
> +	union hv_synic_scontrol sctrl;
> +	struct hv_message_page **msg_page =3D
> +			this_cpu_ptr(mshv.synic_message_page);
> +
> +	/* Disable the interrupt */
> +	hv_get_synint_state(HV_SYNIC_INTERCEPTION_SINT_INDEX, sint.as_uint64);
> +	sint.masked =3D true;
> +	hv_set_synint_state(HV_SYNIC_INTERCEPTION_SINT_INDEX, sint.as_uint64);
> +
> +	/* Disable Synic's message page */
> +	hv_get_simp(simp.as_uint64);
> +	simp.simp_enabled =3D false;
> +	hv_set_simp(simp.as_uint64);
> +	memunmap(*msg_page);
> +
> +	/* Disable global synic bit */
> +	hv_get_synic_state(sctrl.as_uint64);
> +	sctrl.enable =3D 0;
> +	hv_set_synic_state(sctrl.as_uint64);
> +
> +	return 0;
> +}
> +
> +static int mshv_cpuhp_online;
> +
>  static int
>  __init mshv_init(void)
>  {
> -	int r;
> +	int ret;

Ideally, change the name of the variable in the earlier patch so this
one isn't cluttered with the change.

>=20
> -	r =3D misc_register(&mshv_dev);
> -	if (r)
> +	ret =3D misc_register(&mshv_dev);
> +	if (ret) {
>  		pr_err("%s: misc device register failed\n", __func__);
> +		return ret;
> +	}
> +	spin_lock_init(&mshv.partitions.lock);
>=20
> +	mshv.synic_message_page =3D alloc_percpu(struct hv_message_page *);
> +	if (!mshv.synic_message_page) {
> +		pr_err("%s: failed to allocate percpu synic page\n", __func__);
> +		misc_deregister(&mshv_dev);
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> +				mshv_synic_init,
> +				mshv_synic_cleanup);
> +	if (ret < 0) {
> +		pr_err("%s: failed to setup cpu hotplug state: %i\n",
> +		       __func__, ret);
> +		return ret;
> +	}
> +
> +	mshv_cpuhp_online =3D ret;
>  	spin_lock_init(&mshv.partitions.lock);

It looks like the spin lock is being initialized twice.

>=20
> -	return r;
> +	return 0;
>  }
>=20
>  static void
>  __exit mshv_exit(void)
>  {
> +	cpuhp_remove_state(mshv_cpuhp_online);
> +	free_percpu(mshv.synic_message_page);
> +
>  	misc_deregister(&mshv_dev);
>  }
>=20
> --
> 2.25.1

