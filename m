Return-Path: <linux-hyperv+bounces-3554-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA49FE017
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Dec 2024 18:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA267188224C
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Dec 2024 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7318BC3F;
	Sun, 29 Dec 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jyf8sT1+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2092.outbound.protection.outlook.com [40.92.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46043259497;
	Sun, 29 Dec 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735494411; cv=fail; b=i5/cN0huKObKDQ7OS+/5A/el47zAMtN4DDp20cZ3K8VsSOwkMbRECpoU+KbczlQFVkUdfLtks0V30ejGACZiRZ0xPcwTcdQYt9/tBkxPFNCXzSf+Wnn4QHYLkIHIasHmS5CJ8Ffeq06u1cj6cRIjsvpo3nqn9vnfAW4u3FdX078=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735494411; c=relaxed/simple;
	bh=fiuJCK+Nwvi8FmnUWp/xK+hZK+XRlf+7HtnwGRnRe94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AeBpN7eJKR7b4Y0kflOAsSsnj4b2VgizxdnwUhFotHXXqGZpThQ50KKvgEASMk/YHJlJ3ESFWecOf4FB/TRF0a+FDDmRPP3cQHL39+4mvnQk4FHepUmre1bXQR9qPQCWO4kuPapYyYVmXG5mg5x9Fzu2DqEYD0Q2MjUdG0/GdPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jyf8sT1+; arc=fail smtp.client-ip=40.92.21.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES2KmUNLmL483yYN46jicm2VfVwrkBgndHGghRYH6CwU7h+yH8o0Z48EVTQFmhzvuGd40BubUgBJY/pPfPl77BT31Sw5fpEA8QLQzyAArs7bAC2gcIUYkuPBB2v1s/nvvn+SnTE0JrSS+3eFMxgvoMC607yRJ6haDThRhwlN7p89ZWD00hH1XwFeEuWyzeAR6/3NnoQm/dhDFB1Wky8H3MZ4UBLlbTwuzzXFO+tyDaomwGAGhAXRV8tkNiIrB7ZjMx8Di/7b6hqDTmgCvEoFAxf2yUAGU+KtxQKTg04MKvusX89dnuwiuXApRcnsma2Mp1IZt7mWYCN6BsnhCsS5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8pJb4CuCuklFUJpVAk6pYqjWA8SEAqB+AUn5QH1Pls=;
 b=VMdzdhsUbNgZL9Xu7RIjcrdgegCjXzrPO9d7p14lLras1IrgyDOTVdXAlLbWJjK8P+u0YVhssSjyKrcR2zP4MLukAhRTnvOYQKxjG0FBlfhV8M7eouWSNh6U3EgF3n7DV6ZrTQ1/Grevwit8WQGUbt4X5Mx01t8NOPkqNZtXkPQdknulqIhzRiS/6cw5qKQp+RuStjGM2PhghXMu7c+W7uDzYEI886cB17zxTmgP9lHOSewnlXjMKPh+R7gW0EomcQLq9msUwQLDMQsnmJavYjqANrcF7wVjsvLdEaefD2yyzTdwkv8dIJINlArwsPvBvA4Z4IvhwFSqyRrohQks4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8pJb4CuCuklFUJpVAk6pYqjWA8SEAqB+AUn5QH1Pls=;
 b=jyf8sT1+ei8AYIl9cXX5d3AvsAwgJGrSIxycE3i7I70nb4WLWlSkj/m3nWGz/DGg80J6D+bLnB2CmjZg2KdLuZ2ZUs9uoifrQCfZbP49aY4T4Re6mc2PEyeMMWgu6HJkb99c4XAHhFdVtSRk78OdW2ier7C7jTbOAfMIVGnlMl4gEIQ2/RgBJZMjEXwt9lx9VkVZCOP/KGHT+RjLN1ENNhMlQxlNCJuj8mtOrR78SxfO9TVx7oSDzygvQ616diZNf+E2ZSodOWjjQ5czHmpWx8TazFJMtWDW2Bq914t2uF2gsqho2SnvnlvoxeteHRcyZoWsYi2DqG/WpnjSQfVPBQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB9959.namprd02.prod.outlook.com (2603:10b6:408:198::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sun, 29 Dec
 2024 17:46:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.8293.000; Sun, 29 Dec 2024
 17:46:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v4 1/5] hyperv: Define struct hv_output_get_vp_registers
Thread-Topic: [PATCH v4 1/5] hyperv: Define struct hv_output_get_vp_registers
Thread-Index: AQHbWI2fZmfD6sc7hEy7yyG/ozet1bL9fqsA
Date: Sun, 29 Dec 2024 17:46:46 +0000
Message-ID:
 <SN6PR02MB4157B61822D138A0E0401C1AD4082@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241227183155.122827-1-romank@linux.microsoft.com>
 <20241227183155.122827-2-romank@linux.microsoft.com>
In-Reply-To: <20241227183155.122827-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB9959:EE_
x-ms-office365-filtering-correlation-id: 13356c0e-a5dc-4e26-912e-08dd2830c39d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|8060799006|461199028|19110799003|102099032|10035399004|3412199025|440099028|4302099013|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZRfuV10sawXgqFN16fr07+VtNl2p+3NeX4j/X7wiOXq+D8eTI+Ew2E8IW2as?=
 =?us-ascii?Q?+ipl+LIPkmf8Q905HTC1xykNR5fBiHHZ2GK9+ovh36a0wzEis+KyMEzAzeXF?=
 =?us-ascii?Q?vysFhkBhFNtslqIJttTx6KFAsbl2ry6c4u87IAyowOixhOh1B/uDpVwzwHGG?=
 =?us-ascii?Q?iWg/KHDGE+b0moIhCxnyyI0wljqK5F8Jsy3q0RvAYQ+C70fzWP9eQjF1qP7P?=
 =?us-ascii?Q?YwqsJ8NYOdsdVsCrXPC6cSByFAFHTzVT10TB/noPinD+nhXZ4I2rBvwhapdX?=
 =?us-ascii?Q?5hYgu+Tr0yYgxOwUUH5GfeGtTqj882QwLkZM0iwPkKIK/Xn2xnl5HuHnccfp?=
 =?us-ascii?Q?Kc77vdZlPirtusOQ2+ZaUapOh0SedQSw4DISUwT2tKjZIibGmQTnVI6W+Y5Z?=
 =?us-ascii?Q?0k0UMTwATYe/VCDNGG2qtjnXhVMGnOdfFxftsAy69SKzDXEz+ADdBjOSIxfA?=
 =?us-ascii?Q?AdYqugYMkCuTr5DwStqitIW9/OF7kQlizI5rxolni7SzDBBQwUXtAoTPxh2u?=
 =?us-ascii?Q?7h7geNxYxErHEknXnDbdGX78VNOI6xqEBShVnAWoMogyyUigYNEjuppGwvLA?=
 =?us-ascii?Q?G71oDTbu2z76CeaGPmt8ZUGAEPuae2xnMW7HO6XqTQRjsv7EMUt+VqJtedCo?=
 =?us-ascii?Q?ON9cQ3N4vrhLtlT8EqdgzRDPdAUluYwEd49pUg+GK/vT8gpLg4JmZtNjPoWB?=
 =?us-ascii?Q?2IvpgwjO5iXc6S1saKfGIPi2EIUG8/gRTCmgKrueH1z2ScaFq2oPZ+9kT8tl?=
 =?us-ascii?Q?yVyVxQQxrw4Mf7DXY/4bFDB8mrgvTtEzAFIsHAxEqgJI+40OlOWACj04f4vo?=
 =?us-ascii?Q?XRB1jeqshZMjp/3lSiZ/+DKnm+9Z1o+mXeG5J/fkvF+QAuocyth+Zh8XvLrK?=
 =?us-ascii?Q?J4+64lRlxWYmIOfZCwd8ABxZ1NOnrLx3/HxjlK0et28zpjrjsRNSPPL8lhoR?=
 =?us-ascii?Q?gW3r0yXpbe9JsC8PJbyGMVA3sWkr7aanqKgsyh12CpU/Gii6JT0In2iz9cy0?=
 =?us-ascii?Q?CkmwomDck/pUXNt3YiQqkr/OHRKwvBBBthqvh8ZrAHR/p0AaBQRZvPbg4G/m?=
 =?us-ascii?Q?l0kpCo6YYwhxljjHlJYUoMLuigmwhpxVEqCZqtAeiMOd+ioC4Sl8KO/vpFsp?=
 =?us-ascii?Q?c6uhZDROHmnLk+Ru2wUUJLctgjAlTJWr2SMu/zjeXjgh9VfZIeHkoZKE9wWY?=
 =?us-ascii?Q?UnFiEpoAIP7ULbNP8+DzSRUTGgIqwv3zg5Cjuw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?klKDGxoNuOQ27eMmkXiyrbrbK6EZZwyw0qWV8SwbBFCeCk3JdQSqLfUQV6Fs?=
 =?us-ascii?Q?zmk+Owodn7QLuAx7E+IXbFViuX3UPwM6/HIr82ld/oDX2t1Qqgm7bSGBDajl?=
 =?us-ascii?Q?RFipTMuHnxbytmoPBpih7NV3/aD4S6h0xp5GhogsTEKJRWLk1Y7QEJQBUrX/?=
 =?us-ascii?Q?ppmVcFhdvU54LUYixhXwlFd2QFBYogZ+wkaJCzgtVzEXbByiRUTm2hDlrBdp?=
 =?us-ascii?Q?qTNXVa3ZTg5+yvamaGi/5eo21agUtlav4HHo+RFb9cpvr/i4Ngy1DJgSoz41?=
 =?us-ascii?Q?pXw0Zs0GFoN56AM0XNtt69dPbohie02a3oYBl8HsjLZpJb1GSuPylzGXBHVT?=
 =?us-ascii?Q?mmClq8aGzg557Y98npQ3MBTodCGVxeZ21CWKXsZHeaFy57/vh5SeJn8cri8b?=
 =?us-ascii?Q?BMnEo1TkifaCmd1FloWCKJVnJcnAIqCbfrwQzkijuwxSKsLc/vTB2nl0hBV2?=
 =?us-ascii?Q?dW47R/3sU/5LfaG4dMApO1utsLNCWSKx2fCNYzodySTjGqM5RMB+RnzlgqO+?=
 =?us-ascii?Q?avaVrH80ZqhnvXZA4P5gyKt0rz366PWjAol1yy01LVh/dyhaQyQ6GBcVp2Gn?=
 =?us-ascii?Q?gIxorZCFLVWidfedu3ZFUmX8bovY1iVRNCGTYugwNjSCr9xsin25cduF9YwF?=
 =?us-ascii?Q?Ex0ht3j+FErkmdws64mxHQwCnIdEqmti9gVOBUlghngPS/jVx6aBfOSlgbFc?=
 =?us-ascii?Q?zbWgMBe0iLm3Fsm3Pl16gcgQjSLv2iuz6OX4iB0nImG1mUW2b7/wgXAazoYS?=
 =?us-ascii?Q?0K7bdLwZmgbv8WP7rc0myZm1EIkiqMz2xmVxN2sMDrt2TVxHowLILF9lsAIB?=
 =?us-ascii?Q?3bbs/eshmi2XIRx5mijzL8TIQqzz6CzUKo+hxKXGwhDd17L3n/mytdZb0VFq?=
 =?us-ascii?Q?2vrzsbmtR4aOc0aeLf0YkBvbD1HnhxckwgyLAUvNMuwGfSx7yNaz2Z9dpQnk?=
 =?us-ascii?Q?3SU46MFaCV3q0H/EJ3uJYqMX/G8+/7JvLq6+oiaFZD5eIt6deYyvBchZYgrX?=
 =?us-ascii?Q?aJF6B31DVHkp4ESXYI67Y75OxWlgG/2/9ohrvtcWvOeDxWQ796/I/zBqNZYZ?=
 =?us-ascii?Q?Fte9woZ36MFeDd4QA/ZcQGeuXzays8FDJAk7JtrrynYA+THz3GBdQU4IEOGG?=
 =?us-ascii?Q?SHZepjfisIb3S8RZFu9hS7X9kfxOXjVcGEK7u6MlvPJoV+2AyZSWYvyTk0gn?=
 =?us-ascii?Q?N/MPwOpjEnVfFNAXgKyjwwR0YZ/29OMS9h3BjUYRNmX9xnAzQQIANMnhd0U?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 13356c0e-a5dc-4e26-912e-08dd2830c39d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2024 17:46:46.1637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB9959

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, December 27, 2=
024 10:32 AM
>=20
> There is no definition of the output structure for the
> GetVpRegisters hypercall. Hence, using the hypercall
> is not possible when the output value has some structure
> to it. Even getting a datum of a primitive type reads
> as ad-hoc without that definition.
>=20
> Define struct hv_output_get_vp_registers to enable using
> the GetVpRegisters hypercall. Make provisions for all
> supported architectures. No functional changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h | 65 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index db3d1aaf7330..c2f5cc231dce 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -781,6 +781,8 @@ struct hv_timer_message_payload {
>  	__u64 delivery_time;	/* When the message was delivered */
>  } __packed;
>=20
> +#if defined(CONFIG_X86)
> +

From a thread [1] with Nuno, my understanding is that the
include/hyperv/* files should *not* use #ifdef <arch> unless
strictly necessary because a structure or symbol is used in
arch neutral code and has a different definition for each arch.

When the structure or symbol definition name contains "x64"
or "arm64", such conflicts won't occur, and the #ifdef isn't
needed. This does means that when compiling for either
x86 or arm64, the symbols from both architectures will be
visible in the symbol namespace, but that shouldn't cause any=20
problems.

So it looks to me like none of the #ifdef's in this patch are
needed. Nuno -- please jump in if I have misunderstood.

Michael

[1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157AA30A9F27ECCAE202BC2D=
4582@SN6PR02MB4157.namprd02.prod.outlook.com/

>  struct hv_x64_segment_register {
>  	u64 base;
>  	u32 limit;
> @@ -807,6 +809,8 @@ struct hv_x64_table_register {
>  	u64 base;
>  } __packed;
>=20
> +#endif
> +
>  union hv_input_vtl {
>  	u8 as_uint8;
>  	struct {
> @@ -1068,6 +1072,41 @@ union hv_dispatch_suspend_register {
>  	} __packed;
>  };
>=20
> +#if defined(CONFIG_ARM64)
> +
> +union hv_arm64_pending_interruption_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 interruption_pending : 1;
> +		u64 interruption_type : 1;
> +		u64 reserved : 30;
> +		u32 error_code;
> +	} __packed;
> +};
> +
> +union hv_arm64_interrupt_state_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 interrupt_shadow : 1;
> +		u64 reserved : 63;
> +	} __packed;
> +};
> +
> +union hv_arm64_pending_synthetic_exception_event {
> +	u64 as_uint64[2];
> +	struct {
> +		u32 event_pending : 1;
> +		u32 event_type : 3;
> +		u32 reserved : 4;
> +		u32 exception_type;
> +		u64 context;
> +	} __packed;
> +};
> +
> +#endif
> +
> +#if defined(CONFIG_X86)
> +
>  union hv_x64_interrupt_state_register {
>  	u64 as_uint64;
>  	struct {
> @@ -1091,6 +1130,8 @@ union hv_x64_pending_interruption_register {
>  	} __packed;
>  };
>=20
> +#endif
> +
>  union hv_register_value {
>  	struct hv_u128 reg128;
>  	u64 reg64;
> @@ -1098,13 +1139,33 @@ union hv_register_value {
>  	u16 reg16;
>  	u8 reg8;
>=20
> -	struct hv_x64_segment_register segment;
> -	struct hv_x64_table_register table;
>  	union hv_explicit_suspend_register explicit_suspend;
>  	union hv_intercept_suspend_register intercept_suspend;
>  	union hv_dispatch_suspend_register dispatch_suspend;
> +#if defined(CONFIG_X86)
> +	struct hv_x64_segment_register segment;
> +	struct hv_x64_table_register table;
>  	union hv_x64_interrupt_state_register interrupt_state;
>  	union hv_x64_pending_interruption_register pending_interruption;
> +#endif
> +#if defined(CONFIG_ARM64)
> +	union hv_arm64_pending_interruption_register pending_interruption;
> +	union hv_arm64_interrupt_state_register interrupt_state;
> +	union hv_arm64_pending_synthetic_exception_event
> pending_synthetic_exception_event;
> +#endif
> +};
> +
> +/*
> + * NOTE: Linux helper struct - NOT from Hyper-V code.
> + * DECLARE_FLEX_ARRAY() needs to be wrapped into
> + * a structure and have at least one more member besides
> + * DECLARE_FLEX_ARRAY.
> + */
> +struct hv_output_get_vp_registers {
> +	struct {
> +		DECLARE_FLEX_ARRAY(union hv_register_value, values);
> +		struct {} values_end;
> +	};
>  };
>=20
>  #if defined(CONFIG_ARM64)
> --
> 2.34.1


