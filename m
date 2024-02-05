Return-Path: <linux-hyperv+bounces-1510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B95849F9C
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8ED1F20DD0
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FC37164;
	Mon,  5 Feb 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MjmVe/vE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2024.outbound.protection.outlook.com [40.92.19.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03BE28DD0;
	Mon,  5 Feb 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151007; cv=fail; b=Dw8oEx/maiJc6ToIrct/CUzQrHtns7EW+IOqTfRXfrBBE+wzmOezzK86IQrly2AtVHQWDtqtz5lbrMcKsldhvopkXavbYDYWUOaEQDGVnWzSr/e/y82CHtfzuEyN5Hrkcv0HzhXdBcSSOcZDGCOA2ESLbbrNveNjhztZILC9Lok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151007; c=relaxed/simple;
	bh=ZIzf/So5KNuU1pBKRC2nX1wuU8rihCH5ENL7M2ZBmYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PrHZz6M4yMUqayKCXrpIjPWFUQOqorOPiazEKZZ4vERPRHccuP936mKGAxkA+Zbu371OYTgd1SsC7kJKK1SFHFHsKead5E3UuxZwtQa9BN6XW0mpPzSGtP0jpXPUV7G8U2VFXXADeciAjBLyXJ8UlfPYq3qdfqYH53N84TEuwnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MjmVe/vE; arc=fail smtp.client-ip=40.92.19.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+yuURmygWDh1iG5/0bvJBTisWi4hBEdi5vYNgsz0sO4YSdCPSOWx+3FTjZDUrqz9p5OXey3/OjrINRqiSCt8+PlszzCY8Xh72b3hRELQKY41ouaFdTs2qKya+dFs4z3kM22r0ePJVZ6bGT65J5GJBWN+u+uzVrfzSG3Vnc2ag/Xfs9A4TLrq7YHP+t1BqlwF+okWj5DxIJzOR2upeAiSOp13Qw1uQhUMG26ip3sJxAf8HVyGhMyYW+G3t9hrF9GLFGMXAroAmTo05POmibh8TdUICAcXtATX3gWp2/craf5iKybTFkYJ/Yabb5Q/UYwj2QsXnE1XoESzdoQ1tfgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOrB8d7pxjx4ozp8Nrox5HCH+t4sCUzeE+hnz2jkZgU=;
 b=Q7k0DzctVfV04KkAzFVpPiCgcy30xooNa0OCqyc5k4QmMLPYIAScWUB3F2tibY1Q6YvriOzE6wb/31MOqAJn/RxZyWc6xRaVXE6CQe6X6r1Ap/3RZj6AP3u9na9f0mu1P+5dWmA7DDZNfTjWXNKF9a/479rTOxfOzzzQ2ziptrWkvD0ai9QI1Za1RskZ2WglvdR9Q3Jhhf36nljuBixDC6NNiLNfFCthYAWteze4eqpIHaFtbuQuvjvPkyWvF0xyf7GCvUoko5wsxoNmhBATribqYWSNj5hVX82PRMaRpDQPz8rwvjNmxKGNyGlGMyoiQikwF1TmP/4E7ByPeugOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOrB8d7pxjx4ozp8Nrox5HCH+t4sCUzeE+hnz2jkZgU=;
 b=MjmVe/vESULK1X4QLGaqiaSuxCOo40s+qjB5QpRBTkW/8eCOvM8Uj6b1l1IQJM7+stGn2SGzwB7Ebp7U9KvKAVA/9us6SrRdzdSQXimmqnFZB3p9F734i8SPjYcgzzZ9GNBnBcxRYgFOwEhTzmYrgWjk0dNHJLx5BV/eCpVT19vvxG1K6yINwbF5gTegIvyVn8mh+LIyFSVysb/fW+PqnzMbpFlJ3dWj12hJEdZv3cB6ner7bArB9NE2qsUhHhIZLaosg7ujLmbvD+OsRfptsjkV21j//l4Lxjmls+YW9R+SgDujVEvbH8xnFNyyNcV0/gdG1ExNUgGnTLawgihViA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9544.namprd02.prod.outlook.com (2603:10b6:930:76::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 16:36:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.027; Mon, 5 Feb 2024
 16:36:43 +0000
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
Subject: RE: [PATCH v2] x86/hyperv: Use per cpu initial stack for vtl context
Thread-Topic: [PATCH v2] x86/hyperv: Use per cpu initial stack for vtl context
Thread-Index: AQHaVadKGzigjB18WkOpXORqYUZ/WLD79PQg
Date: Mon, 5 Feb 2024 16:36:42 +0000
Message-ID:
 <SN6PR02MB41570D2084D1B0ACA988EA0FD4472@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1706857957-13857-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1706857957-13857-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Js0Zsf3hiQ4H9O9NNPuMBd9+JvAfKSy0]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9544:EE_
x-ms-office365-filtering-correlation-id: 8945577c-9597-46b8-85ca-08dc2668a2c8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pXabVALpRU9NgKhEm9pRfR5gIwe+3DzCAI9jydz/MsTTJQXo7KifWueCAwwjdHSyr2zBEEFWx590BmSDwKQsuWuxcsdmtisbY+lnRCz9OGgHdK+4q+jT0VDUYk1t+5UngkWy2DF1FB+zTRom7GZm2bDCbasKmtiDz0npCJDjhXqwvTCIA0RjORDr2jzQKLwIxsT5Vgm3ZLxtle9a4UU5q6Lf2QYWk5AHd+SpVwI46B/j+1OJUQoj4+yyWYnPbOpNZMnzO4bHDshjPsFpH1QSLze/zbWWasbhOsl4AtmTVf/1aePsYaGK1O5U8MWcGqPX2EI4RTrjb2dwTzidtq4kkUPf+khVGFOQ4v7+r8Fe54Z/sYATjJxI3GJ9jpQGysMFeqTYNcslSPrRcJkvYs/5aqCxyUpkOQigMt07//lwLQotWtZZ/buMk40VoYubk/mbo73RSYxIIrGhtZY4w5wy7ztS8d65nE4OAoCCQ+1kz5E7JvEFBaIGnRNpI6fudUacNe4DUS6LgSce66fOlL3pixm0J5j5jVNfaLi7g26BwBTISBp24+ZnWI3EGzZ0+/ab
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oQmCNX7d883RAbWNOhkPdM59EwAF2mtDihARf5FaoyrZKI37IUAOSd+vF/Cm?=
 =?us-ascii?Q?Y69jii8Cgc0ftCSObqdYboMA3vSkXtpOQXGQaBjx+xi8ifxVfRacZg+O1zIh?=
 =?us-ascii?Q?z26EsuSGIFnro0U2rJZXG/xL3GWXvzqA6cjqXtSyi++OD1qyIlRvmzfoaIdU?=
 =?us-ascii?Q?0dcuDrnD/+ueCEyTJVM9C4EbWEQTuQCnnvbbmDgkBfE3c/ITy7IG4TmW40IU?=
 =?us-ascii?Q?Pb2zEdh6H1qSu394NC/aHodAW8U1ADRy36/+Kjg828R8TQR8gLaWqmSQ8FgB?=
 =?us-ascii?Q?Gz8oPbC9e/IzamC7AIoMpTiA6uLTY5yhzZO8/w0BfPMmnAxXVrlPxFrtfxig?=
 =?us-ascii?Q?kaZrqBj2LRT8nJsM+Y3Vz16IQmo2cm67HTAc0X6MEDU5gsxRjEqjBs3sb8T/?=
 =?us-ascii?Q?QljsYvHiCUOiCZVU4JBvTOvlcjprel5KeEGFGc3+ZBdwBeBoYdJNGEadfXtA?=
 =?us-ascii?Q?FmtRJ9HAX3lNztDXD1iXZS2ZpfkZffnG9RVvunfrTaLOwWOZwELHekN4/QMU?=
 =?us-ascii?Q?RIaQNXCO1io2VdsD4xyxdhs/A5rAGhjMXzFOoloB9lrZuQu86BC0IDEuhcS6?=
 =?us-ascii?Q?6N0eZVTYZQBkC7O+M7zWe2ilOAs/nWB96iWuH2vamXNAhEfuJXHU/6pkmoaL?=
 =?us-ascii?Q?kfTyhqZlMyaLBTOifANRETF3hKqGvmuAEDFYUWo+PI3LF3IJWNCkaKsGEHrA?=
 =?us-ascii?Q?UqNH6EOKH++gspSv5QyPjqBIjwkNctqGX/OwQQXkv2T9PzIiGiOakTBvecOM?=
 =?us-ascii?Q?G3fuOMByfhHgkw5FAB4bwA+h55oYOX+ZWmFx68lIu7MxVvzD0d5loKbn6/+a?=
 =?us-ascii?Q?F7HMmlqN9SwyMMBKAqx03/veZSv1R01sP/RRtl3nrp+8LRfOowNakARND3FG?=
 =?us-ascii?Q?r5IMs4QL2aNKZ/RjeCCtBOkcEcem8GepK2LVnQHHDXXyLaZHvkVj7cmBtos2?=
 =?us-ascii?Q?P2uKRwem17pTgGPL1C7J96BUUZTSGm3A4iag59RDkNd7D6OwKv6GMqT6xyA+?=
 =?us-ascii?Q?2t3iKnryo7e0qfuKGKftuHIvVkw3AB2IhDXc2PvEDvMCN29yDENC++m1pPmt?=
 =?us-ascii?Q?dKrc9TgY9Zg3HXXVMntSDhz0ecRuFiQADnPzh6f5bbQ19p72W3N6IzNOlmdW?=
 =?us-ascii?Q?zu+1if1PNrktKxBy3Vb0z7S+dt7Uf6QSTOI6t8WNj4F9L0oUwlAMUoAb6FQ7?=
 =?us-ascii?Q?GaPYS/HvGp/fwf7lXPiqkggTpUXDBiJI3SJyBg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8945577c-9597-46b8-85ca-08dc2668a2c8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 16:36:42.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9544

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, February=
 1, 2024 11:13 PM
>=20
> Currently, the secondary CPUs in Hyper-V VTL context lack support for
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
>  arch/x86/hyperv/hv_vtl.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 96e6c51515f5..b0ab724def17 100644
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
> @@ -57,7 +58,7 @@ static void hv_vtl_ap_entry(void)
>  	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_par=
ams);
>  }
>=20
> -static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> +static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ign=
ored)
>  {
>  	u64 status;
>  	int ret =3D 0;
> @@ -71,7 +72,8 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64=
 eip_ignored)
>  	struct ldttss_desc *ldt;
>  	struct desc_struct *gdt;
>=20
> -	u64 rsp =3D current->thread.sp;
> +	struct task_struct *idle =3D idle_thread_get(cpu);
> +	u64 rsp =3D (unsigned long)idle->thread.sp;
>  	u64 rip =3D (u64)&hv_vtl_ap_entry;
>=20
>  	native_store_gdt(&gdt_ptr);
> @@ -198,7 +200,15 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>=20
>  static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip)
>  {
> -	int vp_id;
> +	int vp_id, cpu;
> +
> +	/* Find the logical CPU for the APIC ID */
> +	for_each_present_cpu(cpu) {
> +		if (arch_match_cpu_phys_id(cpu, apicid))
> +			break;
> +	}
> +	if (cpu >=3D nr_cpu_ids)
> +		return -EINVAL;
>=20
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>  	vp_id =3D hv_vtl_apicid_to_vp_id(apicid);
> @@ -212,7 +222,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, un=
signed long start_eip)
>  		return -EINVAL;
>  	}
>=20
> -	return hv_vtl_bringup_vcpu(vp_id, start_eip);
> +	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
>  }
>=20
>  int __init hv_vtl_early_init(void)
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


