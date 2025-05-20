Return-Path: <linux-hyperv+bounces-5561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF103ABCC49
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 03:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D95F1883B01
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 01:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75292253F35;
	Tue, 20 May 2025 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sOtKBDtT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2026.outbound.protection.outlook.com [40.92.19.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF25136327;
	Tue, 20 May 2025 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704717; cv=fail; b=FLeA1xaSEyX41Unu3IEUvMJH7l5pNgY3gslqb62bjA3HFJrP6rZHkUj0GAeKr/GmJDbCCrfPRpOrQJhvFAJngE/r7lez/Hvp4nBMhsS9mmjKePSCF/GurYsA2Ygw98zpoqWQmeEX+lFmSszzubyHjspirlsfR1kf0DUBUdAQ+mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704717; c=relaxed/simple;
	bh=odwH7l04xPZIJHMHFvqkJClK99z3vTxrvUsKhc53Xp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9YurX0uvfuwg6cSulCd85idj9JBCoraxvBmJHO5ck1ERbRI56bN828xC+S7aVLMHdIEGzvy32NsmxpzHpUJBEGPvYHDyIrng5xX6H7xXReEZL90WnFPFdb/6/1A91C/gzUk27ZDVVvwq426swBGtbaSYmdQCRtKkGSXxn0wqKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sOtKBDtT; arc=fail smtp.client-ip=40.92.19.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eifpRQ9FFkbAi9/k/vuMcenOETTYHdBbrf9mLfvRoi/RnfIKd80+XBSiQ6YQ13NKZFQY3aBcdphapT+hraxdR3oQA0hIMlnZ0O7Vl6q9302rnotjCa8ze9DkAArzcxeypOLm1SnBtoTXbqDYS4CvwKWqD6x/hqAIWobbD4ijczwSezqJqH+MSOGyunbbHMboZiXase4y6Ur5DqnkLFaISaGNu00wS+oQX8HAITBnrJpduudFosbwhcZSRNmsy+PKt+KX98Dg9z4sB1VYAq8KFC/uMpOAFjOul81cVnqx2Sx39zo44FwZUBAefVxWDoyJVzyEn0drGpuraRaLx2IeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzPNJvqm59vMSF7tAoeei6O89sqgifDHZSCtQAmSczE=;
 b=CFEUADqFcrRPkZr8FL5ccbDfNw5zIRhXaLkI/BvemyQuZYONG7QeDXsdK1eAblV+hYu5ORDEmhsVFBUPuJgg8/0XUvtvMsByPnE1ILNhw0Rn5MsJraUETZ8mhi5FrrlyUCH2ySnKUBYN1XlnR9gPu9HDOvkdJWlZI+84l6t/0HzvIsUGCY9+4SbkRy3kLHyYiXHXarcb0R7RDCdQuCd56Wlk5YWSYMgGPeA629P73DbykvycP107hE1K5ijt//MRB6utiMWKWQQ66MtkjrURuiaR6lOsr4D1PNMPT83xyc8qpcFD82uSKulyatLMKyoKBR0I8D0PMczrl/6S2QS0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzPNJvqm59vMSF7tAoeei6O89sqgifDHZSCtQAmSczE=;
 b=sOtKBDtTPFMqhg4Vsxu8eHfN/qQ0vYe8GdIeN2rtYuqvOzWRHB81xjT6pFsP1LTl9zMjy1IMZ7XAZByWgLux2jSpOLOFDQ0nWxofe7QcZZ3SdATPHX9idvDG13O0NhosbpksjNtC9Igxymy+S2gyFFFy68J6gfCWXJ/w5Rl5521U3+CBjdCz50ITwX8r4vfFILnb3K++Lrz3P9nGa9Z6UwrJR3hhNndUhFOmJwpSwPiSyPiHzcfEh09R2S/46edBHvITtjajI27d1g/W+9u9BnDPTB+IPtbbHuV4cUi23sKiyveMV7O3ajLMhp7o/idKvLYW14A2d5jKP+ZrAA5CTQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6735.namprd02.prod.outlook.com (2603:10b6:208:1d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 01:31:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 01:31:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: RE: [PATCH v3 10/13] x86/hyperv/vtl: Setup the 64-bit trampoline for
 TDX guests
Thread-Topic: [PATCH v3 10/13] x86/hyperv/vtl: Setup the 64-bit trampoline for
 TDX guests
Thread-Index: AQHbvF8Bj8ddcpulH0C1TkRUpTojIbPa1OyA
Date: Tue, 20 May 2025 01:31:53 +0000
Message-ID:
 <SN6PR02MB415740783351D43FDBFFE9CCD49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-11-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-11-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6735:EE_
x-ms-office365-filtering-correlation-id: d777e359-9846-456a-73e3-08dd973e19c7
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwVu6ov8hlKZu5ytU8AWxKlxFEWWI5kjZBMDrsmtOPkGeSykdaTnDNakDwn1AUr0i6O4oSZiLyd7qKYERgRUX6BL/kicOBiu5mk+0qeoSnSFzGH2+DOggJ1O7QVbYCGHKU01HUbDEOGA4ZkemBQFdNJzUjoldpC1jKNob6snwqg4EscgKttOJPzm7C/CbyXDwOH9ZoDABIpO+rEB1xk8hQz0FxaBIbNQu2L+HSu10OrG8MxO8cEa1g0iE5nphmsyWYY/eJ+6PAm2xpy6oD2kP8yhD/oWpx9Tx7rTjJP7Q60GLJXCQ86u3T/6yqJHF2piZKkwehiXLw6H9p1uUi4B/sfdSmVb537jYPZjlRPpq37kvUM52V6gx/wHi/g0PxRyZQjB+cUdJfGC7S3r49E6pUDXVIJP2FiNoBp3gfN2fBf68wk0jlS9C/5wZN5qHOz/21xOX4Ckox3itHWpdOgOC8LKbW0WSS1eJt9MKcbFgZZueVWmiVrnMyZJ0SeBgrC6EbOEW8cxZPoxdSwFWK7w8nL0zXWMJnCVmgFnVI26fL0iBkbyRjI3EevI65v2FuQx89SeKAYdO+dQqaBt38KklvhgvSA2a3nbnrxfcpFV0qHNU8DvoSF80kIE0VtmPqf71jJ3vQQpq8kqGl7sGEA80s5loRR+r1qotAP2YbozQLvH5MALN2mAvCBP8xqoWKzHAOUX7sfH6woaml3VnbjGp8a8zXz5IS30AcT5WEXw6o0VIKxmirav2CHWs41rx0VXia4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|12121999007|19110799006|15080799009|8060799009|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1MzN5bJGE1uqrmRFnAJaKCE/tC0btItNaj2METui67XXf1WNy5HbmfB9pPPd?=
 =?us-ascii?Q?4U4jbK4RMd6MSZ6QTsN66zB2DpAUA/nCzNFsZBpFV++fmaSpT+pPgLLA6KMd?=
 =?us-ascii?Q?s6cf7oCufXF0QtfkUoZxpV/dt+FYiim3cG2ciZlQwjhNgW70FhSBQkPYn4+F?=
 =?us-ascii?Q?Sr0JHc4G7jHXAh2NWivnM7zi0W6wycp1R2IR+s/ckf7VG/RJuYr6DYHu3qw6?=
 =?us-ascii?Q?f0eS71P7AwvjXDgurQe5/ugEpv02+xu24Oq34dX5gceNJ5DeH/Ml+HHDZktI?=
 =?us-ascii?Q?sKvty6rVva81hEM4kRtObQs7AyWsOxTZAqxIh+EyQfwzTPo4pPScgj50cH9w?=
 =?us-ascii?Q?Z+eLvSfFbuuNhBPW2CbBuPToMKLBbmJI7dgihUEQ44OFsg3RCZF9OSUSCLmo?=
 =?us-ascii?Q?ByuyYhgySczVMzQS4uAT2z40CKMxAq8diqGfwNpFzAMyNxElwfnKzNewg0vE?=
 =?us-ascii?Q?VbcYebNijEYeIEG+kq+Q9ZRwEhDrwiS75QC50004AJ0ge879kCHQctDpEpK9?=
 =?us-ascii?Q?fg7xDaqdkMXFmIfqMD5qP3f2dgDUodJR/1LsQNTrNbJIbeYsjaF6i/JdiGYw?=
 =?us-ascii?Q?QhOa5eREw9RpjkZlZTqufrvlJlJlODx5INRIS21E8ZamwnOI2Cj+OZo6ZrWX?=
 =?us-ascii?Q?pCEmBsn63Q0jX63cZL1PEg0Is0zmd8/ShZQSo2DxLNXwhAkqCmQoYMxng4Uw?=
 =?us-ascii?Q?9oLVKMZS5Rv86j2Zjb5965w3jE7uSUXK97UNdPx9TMs/3FAY1HVxM+z2KCKE?=
 =?us-ascii?Q?FKnyubX30WTDl6KaxDaVm+aug34+Rhw5c4cqv4UgthHgVm1nYwiUV5tBwWaL?=
 =?us-ascii?Q?cNjvONpOxEZ7WDv/cWZX6Y3A2Gqw0B9g15/aa93R6OjkoJfw6vLZbOv6AyVk?=
 =?us-ascii?Q?fIE1JMl4Jp5P4M9ROOf5u2y1jid/DBRAwcmMhxDjH843+4JKuUrLMMUokPmN?=
 =?us-ascii?Q?L5szY+e8QYDRA+Y8v6KpnEuhQ4DZQQ2AOsiJocXdeG0K4wNbp7P4nkKPVlDt?=
 =?us-ascii?Q?oropO4R0n5b/bI0j9CrM3GCQrirp+y1fczERafBL9PjgXIZZG/Ga77Rs+IK3?=
 =?us-ascii?Q?KE59jm+GosCoVb+0gma680FQkFb9/tvroO+ljdsxKOWbD4HNwVo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LbPofZtvv9C6N52Yrhr4nykJEHgN1TzgX2T1lfsvvA9Rn7sbdURwGFMOa7Kt?=
 =?us-ascii?Q?gmOpkvG1e8xqw04UNapN2SxLGujH94rmvdK/GJG70qDJq1DMByG1v+WfJv+k?=
 =?us-ascii?Q?DYZF3ZWuxCzgNpKs4dYIxx27wzX329SEp5z26O4dyMZS52rnJw5gBrW1B6od?=
 =?us-ascii?Q?smiQ4GbF3U7dWKFXcC1Q6yG6hbDbh2llDuX0XFVmPFuqU0edkvLYs6AnbiKv?=
 =?us-ascii?Q?Hcsk+YJY2iYIvEpepTd4IqmGh0PCeb7y6GLdgv7amQkr2fpvAZ6d75/0ZLB7?=
 =?us-ascii?Q?tJzNGpZpGeXvgHPQoFmukTHk3FAmuLZPUPLn2P+7F5yMfuEcupcnIn16AvDb?=
 =?us-ascii?Q?1kBq3Re+OgoVwfW4VLjozdyWlMAMQg0T61119s1/0bBKjoza1zXkM8MnP10l?=
 =?us-ascii?Q?BbedSYZg7QjWCwKDp3cLnsZmc1m5vF8kGl74BsEp3UgLmWUw8t8/h/G9xqIG?=
 =?us-ascii?Q?63BLWJHJy0zqnBUWBKOIlA4h9RZzVIrzyfv7yIIWsQRpYBmpOv4bUn4TO3zX?=
 =?us-ascii?Q?GLRt1Hq0ojYvpjQ53QrQyh6ndkKOi7SWUcVhD5nHbFrKErc6KmeS4WMZDXgp?=
 =?us-ascii?Q?PMFmqyV7HMORfoWltNgfO/a4gasvWv4rBaMfx3RBwa5eZiWYx3oDMUdqh9NE?=
 =?us-ascii?Q?5sHPjS2D2qJyTlXx8ti2DF8QEx2EYOZw+qbB/iyAzl5kasWDMFpgN6nsFU0j?=
 =?us-ascii?Q?7hwMVUHUKCTX6civxmxiaTxUHn7VR/arAEAg6CqjN2LFfsBAaW2lzMTJQBqo?=
 =?us-ascii?Q?xgNxQuFEdTBjVTt6zWhhpCvjs1rzMTza6Wk4WxXK0no6et81roZ7KTkbFhs+?=
 =?us-ascii?Q?nisphvasWnT1EE5Kt+XTQ+qDo/eLRHEOVbCBdW6NxLS5bgeOq00d5fSS8H3r?=
 =?us-ascii?Q?xomo8tpdkImAL/ZYbe39mVZYVodTYUDLSJlFlPNLF1pqYGFwDtsW2j711rkl?=
 =?us-ascii?Q?9mXfJfzjZL0o+Svutwld80LYpHDdBWZzagIcUiLIKqvzoncSo99D67v1l95r?=
 =?us-ascii?Q?ygqxMIkQxuZJIdXXjjeJ/rc7kLWORkqTDPDiLANpb7AI7Qw7G3xfnuoVvjhS?=
 =?us-ascii?Q?ib4xSAzACGQaFxv8R+XLezb51EezyHv1aMpqkHogLQussftIVV27EmwCcxgX?=
 =?us-ascii?Q?iqvoGTrBcij29nOOqzCb2YboizZn0iPxv34Tt/kav5wORrUzB7D2Bp9AUvmu?=
 =?us-ascii?Q?oHax1FDW78hN8gpqpqLB7zMVtOYOiemtA+0IJNiKLjOjMSFm3UnLVT1sFdE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d777e359-9846-456a-73e3-08dd973e19c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:31:53.2238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6735

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> Sent: Saturday, =
May 3, 2025 12:15 PM

>=20
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>=20
> The hypervisor is an untrusted entity for TDX guests. It cannot be used
> to boot secondary CPUs - neither via hypercalls not the INIT assert,
> de-assert plus Start-Up IPI messages.
>=20
> Instead, the platform virtual firmware boots the secondary CPUs and
> puts them in a state to transfer control to the kernel. This mechanism us=
es
> the wakeup mailbox described in the Multiprocessor Wakeup Structure of th=
e
> ACPI specification. The entry point to the kernel is trampoline_start64.
>=20
> Allocate and setup the trampoline using the default x86_platform callback=
s.
>=20
> The platform firmware configures the secondary CPUs in long mode. It is n=
o
> longer necessary to locate the trampoline under 1MB memory. After handoff
> from firmware, the trampoline code switches briefly to 32-bit addressing
> mode, which has an addressing limit of 4GB. Set the upper bound of the
> trampoline memory accordingly.
>=20
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Added a note regarding there is no need to check for a present
>    paravisor.
>  - Edited commit message for clarity.
>=20
> Changes since v1:
>  - Dropped the function hv_reserve_real_mode(). Instead, used the new
>    members realmode_limit and reserve_bios members of x86_init to
>    set the upper bound of the trampoline memory. (Thomas)
> ---
>  arch/x86/hyperv/hv_vtl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 6bd183ee484f..8b497c8292d3 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -58,9 +58,14 @@ void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>=20
> -	x86_platform.realmode_reserve =3D x86_init_noop;
> -	x86_platform.realmode_init =3D x86_init_noop;
> -	real_mode_header =3D &hv_vtl_real_mode_header;
> +	/* There is no paravisor present if we are here. */
> +	if (hv_isolation_type_tdx()) {
> +		x86_init.resources.realmode_limit =3D SZ_4G;
> +	} else {
> +		x86_platform.realmode_reserve =3D x86_init_noop;
> +		x86_platform.realmode_init =3D x86_init_noop;
> +		real_mode_header =3D &hv_vtl_real_mode_header;
> +	}
>  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
>  	x86_init.timers.timer_init =3D x86_init_noop;
>  	x86_init.resources.probe_roms =3D x86_init_noop;
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


