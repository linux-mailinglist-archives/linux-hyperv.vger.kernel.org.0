Return-Path: <linux-hyperv+bounces-1501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A066784617E
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 20:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2AD1F276E1
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1424585278;
	Thu,  1 Feb 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dn/lIqqR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19010000.outbound.protection.outlook.com [52.103.14.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6985620;
	Thu,  1 Feb 2024 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817244; cv=fail; b=hCtov3Va9RadcsjQw32ZPXfm1pqyM76QVM5o8VmMecYwK89DkN/Xd+qrFajNy3r56vG+0RgOGZVC19gA8YEveDN1h28roPp3hevJELGHhspnn8MHRdja/IbtwMMgvvMky4jhH4VzQpLVKDaAsLdnBaJfF39Wew23BGUsJZvCmHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817244; c=relaxed/simple;
	bh=Gu5sGTr9Kg63dtcc1kpac7Siv84y490ngfDK9u5D+XA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hyrRxFTpOeRDW0tQpLko1LHIumrJwKIbcFrcgBJztgz83rXDr5MqsbDhU7dhcEPzXWh1Czhf8XvfFfj+n0OyTdvkbJHGDgG3LaY8Q1i3tIwwd9u3nB8qowNT22WWloihluqOj4yI9QZhsUXkhMko7irOsgRrL2Tw8Y2frdX4MA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dn/lIqqR; arc=fail smtp.client-ip=52.103.14.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ3NTYk5Siw2pjWvM6x/H6MKli4/ZmmVKygZdHEkqlUyEAqO9jJsrOKLZxo529mjKN+vufZ1YzMU3hgtVMcBB3lwEx6M/ok/AEZHzRJKmT62/uZivAFsoJq2nDulhFNM91ELc12dFsRHkptjT8WfGCk1wiemUUJ0Svrofx8ZZY2S6MEkUfNClTtKOXLYkDOhUMAW3B2kJ1IJxjT9mXQFUzitvIdWsIN3WVy1mCX8lnk8V/e8m6BNVp/tBm7oj0yoS8+BdtHqb9AgY6C8qhBq3XbYEjBR1GjJMJ66zyo8l2JFC/r6TzeEibjBXU09pGQZcpEvF36OycjL15ZUxg+HwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujFnGsqN+aqbuLBadlA57M862OmVSUw/pc5aT2AWQ9g=;
 b=F5IfCCBytaL8MN8Zs6AZvmcYg+3MdP0iy9IMsj9rjYxZNTZKVHjrMKiyraHrZGwYPVu5JmD4rvl6gJTI68/W9XOZN2mWggEmbcC1iK9W3pCFBzvetpU8cWgIOS3QFUsp8uxLea08k2Lo0g8Rd2bRWEYUO+jleEo2BDkiXybPBGTORaEG+tKdaUvOAQZIQBlFbudngd/T8V5l/EgCMJJc74qW/VWdfpFi9uyznxb+psBrSC9I1/UbVFJMdhMJf5gRlwh3zRrQJny8dp98hkiJi902PoUVzO7+VZI5maNwdI1AZC1fX7nA/OC4e0VSankddBJ0Hh+TN1rMKSMHrJn0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujFnGsqN+aqbuLBadlA57M862OmVSUw/pc5aT2AWQ9g=;
 b=dn/lIqqRRwabizjmFnyramTE2/cc7IBWHobHsKTVcs59uBVbdSDPVoU6eyer85V/zwFn89H5n+qjGgtLHa0B+e5i25+IapVAcmWMOQtTHtYy2IYqvgTpO1J4Ai0Sjf2x+Ob6+Ni2b0ndrSNCNe4Ccpr4tKTqRsG1RIVjiqorWDtTFV3ACLOekWGbdkNs9V3bWcaZg4F3Pwto0+EJRd5cEjTU/N2wVTRR7+GzhpoyZbnX9f1OEWNt0Vt3u79uFBTEQCauZptpbC21N9QT48IiPRaQdima90GkvONGe7l9DSFAZb7R2cwbfWoGjOYi7+CKDaNjnG2uaBqpN6eCziRlLg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB7055.namprd02.prod.outlook.com (2603:10b6:208:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 19:53:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 19:53:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: RE: [PATCH] x86/hyperv: Use per cpu initial stack for vtl context
Thread-Topic: [PATCH] x86/hyperv: Use per cpu initial stack for vtl context
Thread-Index: AQHaVTwzTTWwliUuVUe5IDDLZlv3X7D13i+w
Date: Thu, 1 Feb 2024 19:53:59 +0000
Message-ID:
 <SN6PR02MB415750EE9132ECB049D7B20AD4432@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1706811931-3579-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1706811931-3579-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [DorS0Kc3VQNqfEi5YYTX83/p9C12HmzF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB7055:EE_
x-ms-office365-filtering-correlation-id: 9e98cbbc-5508-4e2b-0690-08dc235f881d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eSQmWvrq0UTk4iwKC+pJpDKaXg5SPkP5i/2FRc+wexncs6wm3t5kalkh/TCpNLSXNFPD9ph+5LiS25lmdTzYz58hkyYNwHDyT3QMBViiZeU4C51ddiMXkFwUEsmuD5kAkaM5MM+AEFd9obrnfkFXc/qYInEaK2tUePK3tksn1buz7TsWimjtHB2tQFOlQipKEoMjeXuqZIVrLGn8hZBlQb2DG6FGUUf13+ytRs/iOeHf9JIyKEU07y8HGY5IiFdB8UXDAXTCIZm/qbaBj9Otq2e4ikfl8p1eanRSGCin+XFr2TcUs1FoGGfjBpn8wYIxzYtmR1psefiP5zvIJeO6Icq0OyH4XTyIDPZ6YplQS99+bkvuG1qKkF47ZYUKAaXa9psyj4vl+RH77ufDZEVWubHUhsuHC13LdIFYpenX5STw/80LELWVwokR0gvou6s/hOsFJ+rWM7EnkCLeBySQjNK5sAJ8nA3WhhRn0sK1xeMNDwdwR3wdTLhCB+8aNfdPUi6aBiNL6mogJMw2oi0W3sYO/s2Ig0LltTCYmauxA21YxcMvvAQaiqhHigHH5PBg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f/lqsx35OG0VNRT13AxfUhFd7wXtfPV9t5GhD/nrFKX2HWe02jVjdPXdbuUK?=
 =?us-ascii?Q?ANIID6Bg0EbgVw4COLXFUwpBTk2fW+U23D5doTdaR9H3ejsKRMvkqKh+Ju8k?=
 =?us-ascii?Q?cuY4UmojU1MruhMnPBrTEo1xxN4koEhS4cQdPVcQj/A2cqsd7qnmRsSdaF2C?=
 =?us-ascii?Q?qSmKfLHWX2hicFmWkhL+nz5z8zMZStIZMwDP8wWUiSj9EWe7Q8vu0bWPpP/j?=
 =?us-ascii?Q?/acTCnhLRstU1+bVc/uDcRstt6Xlc29H8i/MHIf16z1OzAza6op+t5T22glI?=
 =?us-ascii?Q?wtlWmcDowtDMTj/qFEVScVpJbprmqNxLtGACMWa8XLHebMlUYrDbT32SliEm?=
 =?us-ascii?Q?y/Oflc2bdewsWdRBoxULQcjhbibMbRiPSlvNIzECIVKlsWa4lfRnptD/ZVgh?=
 =?us-ascii?Q?yj29lmT6CHBjPF8fwbHzU4rphlLUuSo661cGeXsyg+dPSusZLbFpOq7bKeon?=
 =?us-ascii?Q?toygWEZwqtLtTVbkv2tZ8wNmye4CDMLpmG0oe2XrbPKzLeUZMtmdP23MTEYO?=
 =?us-ascii?Q?wVx/qDHiGto2RfObFMeU0dN7u5bf9BbOFnl/+XclBqOnPgGQyFxBcL7+a52i?=
 =?us-ascii?Q?tm7hz+n+IEN57kA4mcNtoffUSn8saqyCdbHusb69DnxfkQGQSstrMa1qm5bg?=
 =?us-ascii?Q?qi6ZYHZP0e1MSk0fL5QGphVonUKOPkMh09OQXWWJg8eKNtfRrL+hCHP0R7bf?=
 =?us-ascii?Q?HaG14t5QjYAAvT6hC5RzX8Ulz0fya2qUBnoqZ9FA1nqgnGmjDKAtIPAlmUi/?=
 =?us-ascii?Q?2CE0nas0ZcdCQfFnZWLaGTphQclVzi7pbL4UHzz1IyXXEiqH/Eso/HK1GEGJ?=
 =?us-ascii?Q?tZ6ae/grSCR3E2wXgT9mDPddoXwJUmdTWUM6W0BSYR5cdJVNPFpmRupC/Buw?=
 =?us-ascii?Q?++pr4oVbNDiF/zoqFacDYl8xM/2FZ9r/qzQ+kbRVbGx8Mbj/HYGCz7ER+qD7?=
 =?us-ascii?Q?czm9eHaXZ79hBQuI80I2M1Cny2JiV/b55b5agFZFqCasWrdxHfTKW678wYY/?=
 =?us-ascii?Q?GqHydMRW43eLOfrqvkYlyEL6ocCUVGurQEvu/bu5LZw0AJKbs78YVbj5TdQC?=
 =?us-ascii?Q?XePeqxIkZ3YuxAOzD8kdTMIqDDol5QlCmli0f83XeyOSTRK/Uu/47NhsmonO?=
 =?us-ascii?Q?AA5FEGahqCpV0MEv/anPXKBwtWXdb3mq4no68mnumpMn4EahyujUwuD6QJc7?=
 =?us-ascii?Q?OPNCT8tKz8GeuhCbcxJNftvFecohnnesfi5eHw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98cbbc-5508-4e2b-0690-08dc235f881d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 19:53:59.2071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7055

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, February=
 1, 2024 10:26 AM
>=20
> Currently, the secondary vCPUs in Hyper-V VTL context lack support for
> parallel startup. Therefore, relying on the single initial_stack fetched
> from the current task structure suffices for all vCPUs.
>=20
> However, common initial_stack risks stack corruption when parallel startu=
p
> is enabled. In order to facilitate parallel startup, use the initial_stac=
k
> from the per CPU idle thread instead of the current task.
>=20
> Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_B=
P_KICK_AP_STATE")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 96e6c51515f5..a54b46b673de 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -12,6 +12,7 @@
>  #include <asm/i8259.h>
>  #include <asm/mshyperv.h>
>  #include <asm/realmode.h>
> +#include <../kernel/smpboot.h>
>=20
>  extern struct boot_params boot_params;
>  static struct real_mode_header hv_vtl_real_mode_header;
> @@ -71,7 +72,8 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64=
 eip_ignored)
>  	struct ldttss_desc *ldt;
>  	struct desc_struct *gdt;
>=20
> -	u64 rsp =3D current->thread.sp;
> +	struct task_struct *idle =3D idle_thread_get(target_vp_index);

The "VP index" of a vCPU is a Hyper-V concept, and may not match
the Linux concept of a CPU number.   In most cases, they *do* match,
so your testing of this patch probably worked.  But there's no guarantee
that they match.  The Hyper-V TLFS does not even guarantee that VP
indices are dense or that they start with 0 (even though they do in
current versions of Hyper-V).

As a different kind of example, in a kdump kernel, Linux labels the
booting CPU as CPU 0, but it may not be the 0th CPU in the guest
VM, and hence may not have VP index of 0.  Of course, in a kdump
kernel nr_cpus is typically 1, so you aren't bringing up secondary
CPUs.  But sometimes kdump kernels boot with nr_cpus=3D2 or greater,
in which case the mismatch would occur.

This conceptual difference in VP index and Linux CPU numbers is why
the hv_vp_index array exists -- to map from a Linux CPU number to a
Hyper-V VP index, and thereby avoid assuming they are equal.

So before hv_vtl_wakeup_secondary_cpu() calls this function, it needs
to separately map the apicid to a Linux CPU number, which can then
be passed to idle_thread_get().

Michael

> +	u64 rsp =3D (unsigned long)idle->thread.sp;
>  	u64 rip =3D (u64)&hv_vtl_ap_entry;
>=20
>  	native_store_gdt(&gdt_ptr);
> --
> 2.34.1
>=20


