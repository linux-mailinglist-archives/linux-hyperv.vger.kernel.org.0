Return-Path: <linux-hyperv+bounces-6416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D897B12D1F
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Jul 2025 01:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357694E245A
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Jul 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09B21C16B;
	Sat, 26 Jul 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i4QEtnlE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013073.outbound.protection.outlook.com [52.103.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810421B8E7;
	Sat, 26 Jul 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573844; cv=fail; b=edlLGbEfwNlmIWXUrCgkRzhAucohX3cU9SbtDLpkptCn6uiTU3xnrdv2t44fUAnoJvrKcVYzMOv8gAq/WDUe7Bp+1UaJ9wKTn7aCHWdMJYqIk3xX+Bc0uDgwDCBoWEG18InPMnBo8K4tywDjAfwUcWQh41aWpB9HNng1pCDz47Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573844; c=relaxed/simple;
	bh=OpQkpolKU0NKKsM3S3uvLJJ0KDTiPzIMlo7RZDriMAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCy5wXcJepbKH1LA2LwxEhTSwp3VZKdlo+0CJjvDFLT6DyTzQwvwVqIjr2PFO4r4FLxGA0GXeJyKvRXPUs/9TxtqjbGPJw/N+gHk0Gf+EpWMMwssh3KALjbDtyXvCk7yCC4kPvczWtepUiFmr82veU/UscaGr548tjmEnrss73A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i4QEtnlE; arc=fail smtp.client-ip=52.103.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gX/HrdIVdrzs0aBCpuQ4kduw7VXKVTyGbY52/3AQ0jk7JTpMFV3JQsg7hY+JTKa/NxZOE1kswq5hewZ1pTrRy0Uwe3HpUg08/++ZQELPX7Mz3p8nNOpCFQkrUqAV1OggALDwMYk0GZJcTsV51KjzxrueG5za9MCXhpag3c7+R4tSNmgGJSEFjiS9uUNL6tl2I4av5jlYBDAheUamM/KiHOUp1CpiQ8K2m7UWHl7Wn1+u2xUZHm4PkPBX4AZlPBuSSjVDfMBMz4ixzjxefYb/eIyyF3ZByUfbdB7OrfnKPRS5nPnhKehHux+EzwbJSQPUMEGJWD2bbM+D4kfXg5VAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvsGjZ55AatX/zvt2uz3z83S8fDx2dtEjd4nM5NhBYo=;
 b=Xkj2hTZqzMSMngQhyWrt3SVL0Y8KKY9vakSqhsm6cALa/guXSjZXucrTq4M2KGpGrrdM4VfZKGd8eFFn0fZpREdhIpitrJl/SOJP0ugTNB5btiscHv9ASX0cpK0w1DDRAkWD62jx5wjh5UuKkz7tDUlgrV7QLtFK5TnNm3GMdIFmh8mZWNf2RjEbvLMWvO7TptI3+DlWjGcovNGqb8okuZhlFPR4ic9CZD9UqzP+muyrSHIk4CNGFNklEJfUxt57hGaIuSg975rqnQMk/Xo9jq5nqZhv4g2R08DrvuKeKMbB5sc3Y+n2YRFpSSKI2BQ/pB3kwn9176zvXBaPDzYzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvsGjZ55AatX/zvt2uz3z83S8fDx2dtEjd4nM5NhBYo=;
 b=i4QEtnlEyv56qiXl6wHWWhCqHpVX/gaYJUuyjgOpPBAeVpzGGOxdmNhG0b6uJqfnx6IKqeVRz4eMsI3UMCL8LInj15tQogrim95AqTcZoZUK5d+o8U7yjF1DMjLt5BI8wiMZVkgtOTjuhFMFL0pOe6FszrYfYGcczvellP9kdHu0aqQJfhhvRCgTyjfsgaZfXZw+1vQkCzTFlwhq7AOFqJhha8u1f5E+/bdOaCv/EuXEejT+JuvwfSSB3vR84KNB4BXkk301e46Lfk9XLa9HGuXTKuj0c+sXqyRqdSrdaE3ughLOQuZBjoG1CqLAeYly+nWVidQe5d56HS2eZl3KQA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10163.namprd02.prod.outlook.com (2603:10b6:806:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sat, 26 Jul
 2025 23:50:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8964.023; Sat, 26 Jul 2025
 23:50:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Markus Elfring <Markus.Elfring@web.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHb/HScy3plG5a+z0miuAOMHd2V/bRFEyOQ
Date: Sat, 26 Jul 2025 23:50:40 +0000
Message-ID:
 <SN6PR02MB4157495A60189FB3D9A7C5CAD458A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <20250724082547.195235-3-namjain@linux.microsoft.com>
In-Reply-To: <20250724082547.195235-3-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10163:EE_
x-ms-office365-filtering-correlation-id: cff83ebb-6b21-4a33-0497-08ddcc9f3a27
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|19110799012|8060799015|8062599012|41001999006|102099032|40105399003|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bSnhui8fM2HX0enfsn76bQKIz9UQhTjMYl5UooJ8JiDDJ4V5YermsBaPDM2O?=
 =?us-ascii?Q?8yMTZgvRpNBxO5/HJfeywCuA/59jG1Vs1ISCnkmai7x9Ez+xa5CLKP8Fcg0n?=
 =?us-ascii?Q?sKuxqOS3KX+Gnsr/z8dgk507wTs7M+jLKN9SNv06whQZ4dp8hF2l2RC2Z2qE?=
 =?us-ascii?Q?n7OVq4fqAgy8R1LgdcmGrqeAGsZ2MeLfHfhg5bDct9UHiNjs5QHDtynKl4BI?=
 =?us-ascii?Q?+eSf4lZPPibjBTBbM7iJatfE+Cqs0HKgnDFXNTjhR9CUb4pwTf4L7++qL4QL?=
 =?us-ascii?Q?09LfweAgOz89BXPI7oKmmQYlsEh53nR/eKkuM33xXRtYOZhNYcS7X71Eynwe?=
 =?us-ascii?Q?K95++DLpEN93Ovn3TwQmJzeDYNAn9U4w2G24nEmzOWVJBUgvrP1DImSLvykD?=
 =?us-ascii?Q?dLXPALPZ0jlzhc6wSJg1fwxtHAElZAwGdHU6w1yFiQv3hl6/hm7XfrJfdd9y?=
 =?us-ascii?Q?jw6mjJ83rb7DzqMQLozhQNcj2EXw3XcCwerrZrZkTp7+MexoBA9yr0kodfvo?=
 =?us-ascii?Q?IL3QpaIIaJVAi9SlVkwAvun0AdUrdTZ9r08qiVdhMhlIhbtJ4/6XpAyHYN9V?=
 =?us-ascii?Q?/xSkMc7tUPiRYWSS3uit1eNR3N2OQ9eA804cSVfTdvEbw14+0x4mS8gNztek?=
 =?us-ascii?Q?K+dSZ345HQyd/AP5XfyyDweNCLxV8DnnCyOtVAFnCOjbKYTuMmB/UYanAJLc?=
 =?us-ascii?Q?03ZR1gzwTEKqIXRI553AZWCkdXdNcHFwOTJOOcD+DdEQioA3rSnQE53Ws83a?=
 =?us-ascii?Q?TjlfN6IJlEGWsWH4Tv0oLGHeNn2dMJrvCd7SFJ7oAl5UuD95uCiR+CIcHwbz?=
 =?us-ascii?Q?eFtbA6ktaU17UhEVKOJHjlQs9re3QGes66jmvyDVpxwMw60ibDJdMkrQLoAR?=
 =?us-ascii?Q?YBynv+s7j+zDGObH8kWhszhmDgMKEPuhdnGTbcFoggcvB9xsHPT7K3wav++3?=
 =?us-ascii?Q?elX5Dfu0RA9v/c1CvEsRuxbz7QkLTGYgFAsBOXwPEANfKrU2HnCQs56nmwGs?=
 =?us-ascii?Q?6DU7p4iOC2YTpvOHWGAe8G3ZCmfiaZ+/EawA02UwR+B7579b3Pe/04AuslC8?=
 =?us-ascii?Q?EUxw/ZHwnOmGLqkXWHI/aWFdf+26552lJ3NIJ8alwoZ1fMDY6PFvKBxPX0rY?=
 =?us-ascii?Q?02OHY6O0bicPnOMlRC79qWdBApqEKyIAzg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3cT9aDfZxDa00tMTErjBWmLD/0kfcbfIfhFG0EaguezGGeJh/I+5NGgb0DKv?=
 =?us-ascii?Q?IcTugdcglxkKys2LIGkJVGN613bK+suQEjsRhlwXw/1WgABPPaPW0jPcn+5K?=
 =?us-ascii?Q?AdUVy4cZUsCV2B871kr3Ct1KheY4bH5WeIZZlb8RUe//Up5XKhLcmRdUWXF5?=
 =?us-ascii?Q?IMhTWpb36u18IhQbvpDWXvNvQdD9PXihieFfmK1uvKU7ODLaANpkuRqCezeL?=
 =?us-ascii?Q?0t66BuhS0FCGh4qfBguQTrod28mX49QAHmPxS17srOlpR18CVABxlqWTDVFm?=
 =?us-ascii?Q?/XcbhfgG/HyIIpumvqvs1hnhem2MCKkDhtgtz4xjp4qv0pTlz5MHu+i1/kDx?=
 =?us-ascii?Q?m/q096NjmIezHVEbrCKgCeAbmbgUiyzzrYvGUEa4MAtWa2aeL92VVsF69ci7?=
 =?us-ascii?Q?pWE5PHZB9Ph/BrxN65EP+c2dg9ROOopR5iHM7smWjkEjWzaJ8z3+jZL9VT/K?=
 =?us-ascii?Q?Y2KtPI/Ef19BkSPvIH5w/5h7JmcL4KXI4xCSIJH0dTAD94sM+YXC5o83/r7Y?=
 =?us-ascii?Q?Re3JQIVkyxN8ziNYfXAUFTSObxZB1wch8RBnbBcQOm73l/xsuiD2OxnpE9NH?=
 =?us-ascii?Q?cfHTFCayV+Hw3xIOgerXvF3dcoFZApzoxxcfhBKy++Ccm1OUr+RoBGravrdu?=
 =?us-ascii?Q?XdlYRjTutigz/beVM1jH5hQ/eHSfTpToj0gnmjN3r0fUq6NXUtUa11mgIRBA?=
 =?us-ascii?Q?bh9GjTHy5U97qGkOkUrDY5EXnlyBpwuP2D/jOeRhbKzUkdvLcR/t0dk6bkyP?=
 =?us-ascii?Q?e4CWP9ub3mfJtQatghlRsTcbzXmB8pAsm419yVG4888LTwQZqEnHhNkYOm74?=
 =?us-ascii?Q?l7LMz3DgXL/pFrxw7Rf39kVp+MbkxMrE0tgX+E6BRgYHpYtfW6vP/JIAoq2z?=
 =?us-ascii?Q?NlOQBM9qdVfzeWcu3yp6zwOKyo/TAeGlq5ibIuX2P29PXm0JSVPF3sEWEBx4?=
 =?us-ascii?Q?tjnS9nXGiV8jwq23tOPNqndqsvXJ2QfSykJGfwLgVr40xbOhOoSGyYYGS8tI?=
 =?us-ascii?Q?rPbAvyP4VfoYqrVXEDMTXBZgJUp5WdV8UBOclHF/03mzChYI4F3ErT04qp4Q?=
 =?us-ascii?Q?wLtMyY2EI4sKBESXF5fj89ojj89KeqjCfMdX9Y+wPVrGe+GN+FiGQuXESygK?=
 =?us-ascii?Q?hlJLHLLNnWTtPWRBrciLShQ+jmlDKWWtiauu0mWBWgmPSq/zQjEVZvUy+ZvC?=
 =?us-ascii?Q?AwEbcQbgpG3t0J1QAlwT+umDgtueAB+NOz/d3JNJ2w258gDwuCjz8pJjEkM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cff83ebb-6b21-4a33-0497-08ddcc9f3a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2025 23:50:40.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10163

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 24, 202=
5 1:26 AM
>=20
> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
>=20
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |   22 +
>  drivers/hv/Makefile         |    7 +-
>  drivers/hv/mshv_vtl.h       |   52 ++
>  drivers/hv/mshv_vtl_main.c  | 1508 +++++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h |  106 +++
>  include/uapi/linux/mshv.h   |   80 ++
>  6 files changed, 1774 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>

[snip]

> +
> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
> +{
> +	u64 reg64;
> +	enum hv_register_name gpr_name;
> +	int i;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D regs->value.reg64;
> +
> +	/* Search for the register in the table */
> +	for (i =3D 0; i < ARRAY_SIZE(reg_table); i++) {
> +		if (reg_table[i].reg_name =3D=3D gpr_name) {
> +			if (reg_table[i].debug_reg_num !=3D -1) {
> +				/* Handle debug registers */
> +				if (gpr_name =3D=3D HV_X64_REGISTER_DR6 &&
> +				    !mshv_vsm_capabilities.dr6_shared)
> +					goto hypercall;
> +				native_set_debugreg(reg_table[i].debug_reg_num, reg64);
> +			} else {
> +				/* Handle MSRs */
> +				wrmsrl(reg_table[i].msr_addr, reg64);
> +			}
> +			return 0;
> +		}
> +	}
> +
> +hypercall:
> +	return 1;
> +}
> +
> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
> +{
> +	u64 *reg64;
> +	enum hv_register_name gpr_name;
> +	int i;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D (u64 *)&regs->value.reg64;
> +
> +	/* Search for the register in the table */
> +	for (i =3D 0; i < ARRAY_SIZE(reg_table); i++) {
> +		if (reg_table[i].reg_name =3D=3D gpr_name) {
> +			if (reg_table[i].debug_reg_num !=3D -1) {
> +				/* Handle debug registers */
> +				if (gpr_name =3D=3D HV_X64_REGISTER_DR6 &&
> +				    !mshv_vsm_capabilities.dr6_shared)
> +					goto hypercall;
> +				*reg64 =3D native_get_debugreg(reg_table[i].debug_reg_num);
> +			} else {
> +				/* Handle MSRs */
> +				rdmsrl(reg_table[i].msr_addr, *reg64);
> +			}
> +			return 0;
> +		}
> +	}
> +
> +hypercall:
> +	return 1;
> +}
> +

One more comment on this patch. What do you think about
combining mshv_vtl_set_reg() and mshv_vtl_get_reg() into a single
function? The two functions have a lot code duplication that could be
avoided. Here's my untested version (not even compile tested):

+static int mshv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set)
+{
+	u64 *reg64;
+	enum hv_register_name gpr_name;
+	int i;
+
+	gpr_name =3D regs->name;
+	reg64 =3D &regs->value.reg64;
+
+	/* Search for the register in the table */
+	for (i =3D 0; i < ARRAY_SIZE(reg_table); i++) {
+		if (reg_table[i].reg_name !=3D gpr_name)
+			continue;
+		if (reg_table[i].debug_reg_num !=3D -1) {
+			/* Handle debug registers */
+			if (gpr_name =3D=3D HV_X64_REGISTER_DR6 &&
+			    !mshv_vsm_capabilities.dr6_shared)
+				goto hypercall;
+			if (set)
+				native_set_debugreg(reg_table[i].debug_reg_num, *reg64);
+			else
+				*reg64 =3D native_get_debugreg(reg_table[i].debug_reg_num);
+		} else {
+			/* Handle MSRs */
+			if (set)
+				wrmsrl(reg_table[i].msr_addr, *reg64);
+			else
+				rdmsrl(reg_table[i].msr_addr, *reg64);
+		}
+		return 0;
+	}
+
+hypercall:
+	return 1;
+}
+

Two call sites would need to be updated to pass "true" and "false",
respectively, for the "set" parameter.

I changed the gpr_name matching to do "continue" on a mismatch
just to avoid a level of indentation. It's functionally the same as your
code.

Michael

