Return-Path: <linux-hyperv+bounces-5973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72261AE1106
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F913B5F84
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 02:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0482899;
	Fri, 20 Jun 2025 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EpAmINYI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2039.outbound.protection.outlook.com [40.92.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BEF28FD;
	Fri, 20 Jun 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385853; cv=fail; b=aQbc9ZOB/qiQMIjBFp7BGtdA5nMcuyqitQWHMUOf57P/kopsM3eHacF7/GBy3P+zMWe72/NNEsspskFOFojC6EirJG7TqLNMgRxa2SrY92nDgDpSTbv0/e6LupmH+9mON1r7SC142ZEPhcnaNPgSthF8UhjdZz5fnQkOiTwkTnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385853; c=relaxed/simple;
	bh=U+wAr4jIF5xe6/LeYmEHsxsQvoE64ll4Y8KM5kOYLOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glTsrtYiFFZz/OcS+uiSE2IqVAefdXqCsFO/dquvZhcVJeBowQGPEwsDARcj9DoqOGd2vIyMPdohDsSTnMJk4NeMDRB57gqyeJTV+chHlcwC8jnK525vU6Zm2NtjWkLaWOt+MxidG6m1V/6NGIr1Tj9FYfYXwaBuuaFf/KnqtdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EpAmINYI; arc=fail smtp.client-ip=40.92.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPXJfeCcX6aZu3DZ5HvO3ldw9ig5ObqqpAj1O+aVv2mKexN/7tLtW8bqiNcp7CZSe3F1FGu5EO0guHdjj3jKXheAT810kRtrFTNLs0Fyg1OhEn9Bs2E9LKgZbq16IDLqwO93SodXldtlzwS2iG2v0EvgG1/ctyZH+Er2P8rkmMH11T7sYUKLfFKPdSuLgqmbXmlcTc1Pqxhc6G0bWcnZL/ozpy8olBXzPehkc1zrRB3VfakH5laPyrGqWVJne2GBabyNgtZfccocjqEPzZQtHk4k3XZ79PenHdMuZOJ2yR9inL/S+i9d0HAhXdgRkOtbZiwFw6IgBZoIVdG0edCYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/dMnMW1c1YHSNS/4Q2OA/7ynBirmA4FIbKYAwY9N7k=;
 b=VXM87Fcrb7VjcwJHPw0HxLEHrYehJYhO869RKWmXNGgUN9GxxIAoUc0TCDLVLHZOM4Jank2m8cMFUxOFfEeoY/XyXU3bdq1pF15y7Q/gu98GMe7AeUg15xhcVgdBs9jlqhZpVJqb31lx2452x4YD+qkpGPW6ltx0Ylu0Vsc7GnuowzhebfFJ6/jmGWk/YLT4d3qbdS8Sv+Hqeg7cbyk3SQHKuv8of3wJmOeIR9ey4XheIEoALOjy3bBM/pgvlyG+PRN+KytaZy1f4uxOgy1qmGKiiYAXWEt7phOaeoesFrKKkKWZIZkmmNaExGrBuPv2jrKoim7ENQodFzKlHrz7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/dMnMW1c1YHSNS/4Q2OA/7ynBirmA4FIbKYAwY9N7k=;
 b=EpAmINYIT350Gxhbn+TNVdULH7XY/X0oa2i/tSvKGsBlrFbxoq9reP0t6857HqFMybBrvnyiKhrMTVfDaCXRF79QQ+FpzpN2Ep4w4DObBsSIb3CTQA+Nw2Ukxdso5vhB/kURAH0eCbgMgvTJfZAyZlob8bcM6QJdr6GlgGxG7tIhKUaIU/2I04HTOCMRcH8xxJkmUtFetnj5uetMHHf/oZHCoG9+RgRYQDtnUlWks4C+1/Rn5oiTETXau35VwjGIEMBbSkbPnL/WoaPWLgW1g+RNyK+Ch7KmwhcdsOSl2NL8OciMeAaQ86BRu3Xj/qK0/w3uZhLbdu+kYQth+CWOww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8206.namprd02.prod.outlook.com (2603:10b6:408:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 02:17:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 02:17:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kvijayab@amd.com"
	<kvijayab@amd.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch v2 2/4] drivers/hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Topic: [RFC Patch v2 2/4] drivers/hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Index: AQHb3FOm0KacYw5uUUmr+B+o2wYQyLQKrOhA
Date: Fri, 20 Jun 2025 02:17:28 +0000
Message-ID:
 <SN6PR02MB4157CE2673B36211FF3CF141D47CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250613110829.122371-1-ltykernel@gmail.com>
 <20250613110829.122371-3-ltykernel@gmail.com>
In-Reply-To: <20250613110829.122371-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8206:EE_
x-ms-office365-filtering-correlation-id: 637959e4-7260-440b-d530-08ddafa09b11
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvg+tg/MNoCQ4s7gWjgMwzwfQBpgotsvMxgXn1tSltfmEy7YaNozouDsHaylwUCNb2VF95IamZNRw/krAEUpTPRESM9Wu7HqEQVNGXCfhKp0txkJpj2c3n0nD2xpmS1cdz9qKzqDciu0Qqvn/rOjq0HQIk4YLIy2TL/I/gur4edaIjsbHB48bRPE7b1WAZ4spQnQ8zRFXaTnMzrDGRqw4fmCoWVfHJJKFjtQnHT0kCxZsLcdqx1EDqfPZiM7rUgdrFn1/CpvULtbyc8D7VUs/kH8vZZhhF5I+vXla+KoQLcFh+aOq0Ai7MiZhFpctuEziprmn/rcdz1WrdMc6R/KdHGelO5leTq/xVvuwDO/CcNrFsjMT1Ry0yueVmVZwFE9A1fp1Cl+XSx/qFUAka60G+z4oIQbELpWDHmJSbYjfS9UJ9wWTwkyw2/H3INz4/UwhmbVUK4hO2Giucu40AaZzhtVRn9K6zH6reHAIFMycfarxNfx6Inc7kLUSewyZZwR7iuX5CUTswqogWxTtUnP5mjIKbYhfCF4Vx7AWoAlIa4qc5fa0+qhjrN5ffSvDBdp06+6r9lUAfq79SNtFwX+VgMCZjI+L9Shc7z98EZeMm3ceOo0ZanJ6bmONcHr17wsXqJraiNfwnGi0cYzOMAKaYLL2r6jHEBms5d4FmR/Hu/UTaWHBUX1DQ/McUHRnXtYZLI0abOv7qrp7bIqP1TIhER9m8tIrdmG6tNavQVHhSu7uusrUAMvoFmiYLbC4pU5cVeVJPN7I7hsCiI/utXi+0I
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|15080799009|461199028|19110799006|8062599006|102099032|3412199025|40105399003|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SyXhhJ90C5iV7nL/9opQoIJv99vzKb3QWXx0ETfUPIqJ5llfUqKGYsllpr3Z?=
 =?us-ascii?Q?3/XlE65UrUTbR5DPZC/uXc4wXc3Wta4h/rQ1xTBmYdW81ff8e8Yuo6VQWy/p?=
 =?us-ascii?Q?TLFf9bfY/VeDjQEhfmWnHdHkqD4KujV6b9uoIXwBpyaCpMOELWaWpZy6cY8c?=
 =?us-ascii?Q?eOK2SUMAg74ziTga3R521ZmoiB1qA0WtBxii80nIAYk3selw2JJ76NcXeCnF?=
 =?us-ascii?Q?TrmRZ1dAHs/yK40AYzsQGVOSEqWDbL9QSRXfUsYGgvpBuSvf8pqmq2Diyr9u?=
 =?us-ascii?Q?887Tu+RUqD4mOIxPUECWD9cTgADr7xgbUN/DirmmvJ6oNIY9g+X7yny16kqc?=
 =?us-ascii?Q?5haYI1smrSa5EhVX7WauR9qrOFJCYQmGN0Ylik28GzaomkWd+TN+SL4l6zU7?=
 =?us-ascii?Q?ZWbl9E1BeoedjpAlwrivxDAJNp+ENieb2PAIEG0OinPnQZlx3iOWpFm5iZLC?=
 =?us-ascii?Q?/BnVW4DO6VlZUObnBqeEHg+6DZ+NFUTONNE+a7O6SmDjQaU+r+gNKAH17gnF?=
 =?us-ascii?Q?S4FeP8lFgfV0i6Qh1pU4WxfyhkKCGoDPffCOXHUOMde4dMF90f2WhvcquyfB?=
 =?us-ascii?Q?nIe2zjIB+mciVqtlrCo9x35osrBJ7isNcs64RGFl+6NcOssXCWzpTATH/UtJ?=
 =?us-ascii?Q?GiFHE/QowNNNdIUQ8Nj9J5XquUoeVdhlQmPzes8KMbZX28NRzfhq3jVN29oU?=
 =?us-ascii?Q?atDl+l7XJP3Aarp6B2/K4T7IXIOKqQjKTudE6NL8gfCvsbm0PoaJVFLxRVxx?=
 =?us-ascii?Q?suzRLBBh6pKoltx0cYXCgeMm5osMsH64avQNzTS99sTgyVFjjWgYMwoX4qna?=
 =?us-ascii?Q?NFKtS7KlgyjtQCkf6BKAhwYynp/bEbNHNWDpUPjT6I8kbHj0q35tOvkEsAg6?=
 =?us-ascii?Q?9ypAISOJF9Wehvx4APdiTYedCyfBqtFBt8RgOBLbuxYfpV836mtAznjx3LWO?=
 =?us-ascii?Q?ctZt2OjWevsIyvYafTVv1jWIGXdzBwllOQXfYQ98lVduhhmKXNWX5XvQHLdH?=
 =?us-ascii?Q?XUQwSLdkLOcVgg3WaHOvn7uhC3qDZP8xdbVE3baZPz5wNGPRrkrbYErrI0/W?=
 =?us-ascii?Q?qaiJy6MgLj3EXy5C7Gafdn5nTadOnXi5ygTgJs+VOCQzFFORt8M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vp77JSaV83iLJaUPAdvnjB+F4tZLTx2Akjxe2aIyPq/EUMaDt6WU+ybsOptB?=
 =?us-ascii?Q?PAMs7hvhRwvDMf0ANV7sXEWYnOFd5sDFwDze6plifWT4FMVpmfoOPOtqVLbC?=
 =?us-ascii?Q?9uqIE1Pr6c+xRD3nCmvpBIqtR8QhZZ1wAA3UFV2jsPtXx3rzFgW8bE+yk3I1?=
 =?us-ascii?Q?HFtC74c5n6MbB3YLydScgKNJ7gh6zrpKy8Mt1N58WeVG8V6cyD1WOrQt6ZLl?=
 =?us-ascii?Q?FLxLAW4/+JXPUsIlyZSk0FUvakvp3OyAmuo7tjnWbmo71aozeMNIL3q2w71b?=
 =?us-ascii?Q?GRrwT7AKviKs85gjOld3rAt2GWr2tgxDUrcw1ecCs62LNuSdwU1bgsRlSh3E?=
 =?us-ascii?Q?OsvAfchayKJTcLYVnf6I4SgL4vm6zRmA1XSjLh4lJWZG/QtV6Wf/9zpSdOOD?=
 =?us-ascii?Q?65yg4Ui86TKvxlnHdvSm1kOyqlIbDZxlCAWcQN9DeahvDkaIHlCiflUdv+Oz?=
 =?us-ascii?Q?E0RmLDZwKT25zW8x7Mwwx7zlfhJ4F4lC4QYFnVENjkja9c5jsEk5AHyKQWm6?=
 =?us-ascii?Q?JtliusxxPZaoXOif1PjndMk4emnVIlkFeCaFJCGmWQ9U3SHDfwANOz+w7RcA?=
 =?us-ascii?Q?QUqhZ3hqsHMWfoy5PeiDuQbpg8eLa+MZA9PAoQJfwQq98f+JiPJGum8MZfgc?=
 =?us-ascii?Q?OvEErpIjJIZawtqADxhmbpTI4rjEN7uo/sAKrUc8juWw7SUV9Yt4vDWi6XSU?=
 =?us-ascii?Q?iQvKs6fF1ezZ//aGDmlbEtjaN+txuGky7S5Td2BmPFe5KGZUtd6TAlqInU0O?=
 =?us-ascii?Q?8Pn4FrTYSctALg67a0lMNgqKwThHvFyX+kKk1a2twCXxHmDHz41wYdZLMgax?=
 =?us-ascii?Q?rfEtCIJ6F2iDvJ0Y2TDOLgfXcn91y97uPgZJ1nLFZ36CrpcSVK7AXBRWDpVq?=
 =?us-ascii?Q?d8CavQriHFICDTqE3hxbEz0qTk7zkAggt9u5G8CXP2ytuZYZ3mxYBohxA9d+?=
 =?us-ascii?Q?0vsfQcr4A7ckcVC7sZlvgOvFeubE8gn/h6qap5WpE0K1PfjTiqmdi1JnJb/5?=
 =?us-ascii?Q?mU5B8S2WU6yPSLIhCGRdWwJOXfZSbjione2hrXtVH6auPGZCdKzLzTGfROOV?=
 =?us-ascii?Q?gHxM6XX7KzBc7S0uDsZRLOAzCyhyYrqNkuD+sbJ/0yOUl2Pr1WFwP299y7TK?=
 =?us-ascii?Q?cXSNrbYW3WgMwtJSb0cr1ZElG+XG9vH3zzHXUxml5j52jxMdmKt8Lx20q0ee?=
 =?us-ascii?Q?UVPoqcS8iZZIlKI1HV2H2HrxVM7uy7gJ36H+G1pBqlfpDw3/XQ+rfb5eMdU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 637959e4-7260-440b-d530-08ddafa09b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 02:17:28.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8206

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, June 13, 2025 4:08 AM
>=20
> From: Tianyu Lan <tiala@microsoft.com>

For consistency with existing commits, use "Drivers: hv:" as the Subject pr=
efix.

>=20
> When Secure AVIC is enabled, Vmbus driver should

s/Vmbus/VMBus/

> call x2apic Secure AVIC interface to allow Hyper-V
> to inject Vmbus message interrupt.

s/Vmbus/VMBus/

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/hv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..f78b46c51d69 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -20,6 +20,7 @@
>  #include <linux/interrupt.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
> +#include <asm/apic.h>
>  #include <linux/set_memory.h>
>  #include "hyperv_vmbus.h"
>=20
> @@ -310,6 +311,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	if (vmbus_irq !=3D -1)
>  		enable_percpu_irq(vmbus_irq, 0);
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
> +	apic_update_vector(smp_processor_id(), vmbus_interrupt, true);

hv_synic_enable_regs() has an input parameter "cpu". Use that instead
of smp_processor_id().

Also, apic_update_vector() is an x86/x64 only function. But
hv_synic_enable_regs() is built for ARM64 as well, so there will be
a compile error on ARM64. We've worked hard to avoid adding
#ifdef CONFIG_X86 or #ifdef CONFIG_ARM64 in this source code, so
I don't like the idea of adding #ifdef around the call to
apic_update_vector().

A possible approach would be to create a wrapper function such as
"hv_enable_coco_interrupt()" with the same function signature as
apic_update_vector(). hv_enable_coco_interrupt() would go i
arch/x86/hyperv/hv_apic.c and would call apic_update_vector().
Then also implement a __weak stub in hv_common.c that does nothing.
hv_common.c already has several such stubs as a pattern to follow.
The stub would allow hv_synic_enable_regs() to compile on ARM64
without having to add #ifdef's. And perhaps in the future CoCo VMs
on Hyper-V ARM64 would need their own implementation of
hv_enable_coco_interrupt(), though I'm not familiar enough with the
ARM64 CCA architecture to know for sure.

Since hv_synic_enable_regs() is enabling the vmbus_interrupt
vector, should hv_synic_disable_regs() disable the vector? It seems
like there should be symmetry unless there is a good reason
otherwise.

>=20
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;
> --
> 2.25.1
>=20


