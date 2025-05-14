Return-Path: <linux-hyperv+bounces-5511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0157AB71FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D6D1B6837C
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94AE27A905;
	Wed, 14 May 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="S1Ap3Ld0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2035.outbound.protection.outlook.com [40.92.41.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50219AD89;
	Wed, 14 May 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241683; cv=fail; b=LdTYRQJi84ssrN0FZ70x5ggdQ8LYrdp4cTGcaTnvfmwHocoT/rfL7FsL2ELPBvEUaTkgNJJfgX4zDS45v2HhZXFs4VHElRctN2sfl/5/0ACZphKMOluVFooYCC6PpfcOpWHFqze67VifBp0YGO5a2B80A3bg3BNNSGql9+zI+8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241683; c=relaxed/simple;
	bh=cOiCBUR2COerFlaO1P4KfV2SER2qXXgpQjiKXicwVr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tu+4nm33H904UW+irX1xPwibRv165J01bwtXSxgb+rzNUFRI4b1P0SuecLzhSgfP6Kbq/5xGVXloG0nolRyTV2Jhw28NvZ1+KiW1ugmGKidRUcxfInIAJkToJ/HPkNkcpsjH8eHpLLq342xdyF0MlhcGIDOO6+DDP66E35bj4Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=S1Ap3Ld0; arc=fail smtp.client-ip=40.92.41.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaUQjhhKuCLW4tChlb8dx7linSOuacwnQt33QRJOWRdkYDFVvgXIOgQ9OuOKpav6Def2Z5EJobRt//04mNAmSaOZDDZ5GwJfiNUYcaw8WaJl7i8SkPaPQ9Zbz5dP3LHRZ9Uq2VmMQbbSYxgLIkLAjXsWeI5uHQx9pL+tWQabTKGz0sXo5XZHDYhxQ/le8X7dWhmYU4zpAznG1IzzIdhdMkaqafvd8qPpzD5925YJ6ph39Bs/h0aswT0h/7aDshbQRju+hDMuY+vtycwLvGYb492tsy3dg/QM3GZa5YCsmKFHQjYw7i637IrMouDba4qVRM2EsCZIgLu0ZbxtehZZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBEPt6YWFDg7AcZ+JKbhKXVV8FugaoxrOQUA0EItfhA=;
 b=B6h3lzDH7Vp6u2cwCiK8MOPTmufjgR0SJoYRxe3r/jSL5NBKjVwXozUzh1PUIXruzfhP8nAGASoJCuXZPDskUM+wiod8FHW0frjrdQF/ep43Rc4Uxh5nrktlab4tt9yADL9Wt0xPoar1je0zM+ATfM5QMIlQrvb50+iaJtcYS2IGfKNfTdmD3M6HFDQQdyfYmoY82miev4bURVD3uk6jRzGKPjSbFus5VhHyUo99B9vtG7SW/vx7GteQ4MCZTKsWn6uRYAZTJcMIZmoxrFXfW3+py4Ca1F44bX5Tba99HX7RahGZxswzOjDj9klnAAS8fPeuXt6bTEDfab7TwpGhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBEPt6YWFDg7AcZ+JKbhKXVV8FugaoxrOQUA0EItfhA=;
 b=S1Ap3Ld0rjMviTelk+UVKbDh92IevtxCBSohxmKIV6GCTe2dmRZDez7oomBIYZxDdqpbY9SnHuln1rH6J9C7/zeXnbk3c9jVHuE871mYSlX2jr6dqoSd0XefK4SgHs4rLRmPJ8Gq96tpuSjxkWyiSBcmJtC89cgxHeFd7D2U02SuVCl7hPrye6h4NZPCeItT6ChwVEG9QhWcHOnvObazVGQV9V6Hh6SImRx0m21O5ezVkABs5gKydhExT7T5HYmhJc5AO2RRXa0GO/gpSi7ufMj1kMx/O7cNQXwaJW+ut2Ei0bkhhIQhomQU4cSr+a4vo84ZnPMZfn55BJ4ZVTQrSQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 16:54:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:54:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com"
	<Neeraj.Upadhyay@amd.com>, "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"kvijayab@amd.com" <kvijayab@amd.com>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"tiala@microsoft.com" <tiala@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 4/6] x86/Hyper-V: Allow Hyper-V to inject Hyper-V
 vectors
Thread-Topic: [RFC PATCH 4/6] x86/Hyper-V: Allow Hyper-V to inject Hyper-V
 vectors
Thread-Index: AQHbvofvqlIWcSu0NEqC37/TA8/yIbPSXY/g
Date: Wed, 14 May 2025 16:54:39 +0000
Message-ID:
 <SN6PR02MB41576BE5D8E86D8F3B75E11AD491A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250506130712.156583-1-ltykernel@gmail.com>
 <20250506130712.156583-5-ltykernel@gmail.com>
In-Reply-To: <20250506130712.156583-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: cc368df2-c324-4710-84b4-08dd930803fd
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3mDoogZiIYtj6aHx7ik50F0T1zOcrYBeqsryOEj8n/WmT5kw+qYfaICrA739qJ2o3iX3CiO0P2xywWXDQ+2Kz4hhzrWlkg6YcwUwKKuqIMvr9XQ5qxCkK4yC0aq3JEhD0mcrm2fmRcOoZ1C+AMxkyAxMnpYwrcNgaIOjj81Ar4Y6GDNmuHZck1O9WpgkBSV0Pe2bZrnf4iUUuW0EoFO1qWQpP19XQoxS+2Bh8iNMKRK79WxAXQwPltngvaLrI3Rwl9v7936Bi8zs0+tbRopw+FVQG0/OPgWHwn6AFHRjjeXLeo5IxfzhF5BMmF6HRRcDqt4PMBFP5uvFDdvc24bKx/TKoki5Iib34xa5ydlr0beXv/D+2sAk8a1giJA32nxl7JW+FqwGhGjCrSme5KKUN98t2VWbw8I5cKXNfRD974blwNf4hLS70DQVp05canAklo8vnAuk/MRLM+oGM0vRQa/kFsM76pJY79HDxD6e3Odo2PLqbASLG5nhagax91BhDeJYlWE0SREOXym+B/ZULj0lC+OzC+Fikc/WB5HNoIacIpijcN3RZyDI3u53mavHM1eef4UJYVTAnwAViDETFkk83kD6MpTroxy/16sxdqnmNMt2bH6mF3rg4+8L+M/zKA6Cb3b0fMq8EhkPkNbI+2l3XyIbPKBJAHKgaOTVSUVb04aAGo3DUM0vLGJAByvdfg7yDbFh/PgW4himf62iSXY/d/Abn91/+4hWu9pbW7PQChxrkMKSRYs6CCoJZ4NOId9LKnQ7HXj82nOgspZShma
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799009|8060799009|19110799006|8062599006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O0dCfhZEEZTSL4EaADVNMcaww980cNd5C3zyNlgxpgZfwhhCNIy/KB2kwlhb?=
 =?us-ascii?Q?77TIJhnAf+CITepezx2HNLa7aGzYnPQxujoA/Y4bXjxTeclO36nA86v4L0Y9?=
 =?us-ascii?Q?hWiAD42z6ivo94vaIU5gBLwiPdMwFZL9G0ks9ya5sXBVwG35ErQF53ZVgAQm?=
 =?us-ascii?Q?qVeslz8LxWpqMQfXPjyxFDKhhXCu+afXIxPIp8waCoHMRjR4vqD8K0xDW/jN?=
 =?us-ascii?Q?916Y5ORccqA/+T/aO3C8GHH9nniaWHF8nJDAXAZVntdnOlzENI05VAO3DkMe?=
 =?us-ascii?Q?wvOQ8t6waU/EWpNLYsu+W+MFaAkx2dtdcQhQXJ4tzDsMerAmDVsgfwaeqRJY?=
 =?us-ascii?Q?rIfGaFCbpE73oE3kJIr7hU9ZjnTcPnkwYL4j2DB/7ZtyRXmSGaMEVF2dGIFL?=
 =?us-ascii?Q?EXtRL98BIyNhZGPm18S5iYxwZVGT/9QpR27V47UZgCMOMDafeCPTRwagZ3d/?=
 =?us-ascii?Q?SzM6SsSpA0U2yp6L+wgGD2hSYvCNZad3vgurIdv5/OIjMITgHNSLN/cHG6n3?=
 =?us-ascii?Q?CZzYuM029SIebjOCZ9/B8+9Z1sMPbflRnJ5du7YisWN9ad30ciiWWiMfpUwP?=
 =?us-ascii?Q?+Yf+SC9RFSbPmPPfuWovxN94/VCp0y8fLiNSVeO6nhEPKoXhed/INkA6nRQj?=
 =?us-ascii?Q?yIkmZ+uqEoZsJn3vPvY98+pqOkxjiIn9jJ1fs53XXvRMPYN+85KTJQqJA80Y?=
 =?us-ascii?Q?UNf+2R60Drcdx1DjJmKIL8HlN9EXrwFLiJcQgFwi9ukK/xgYh0mMc+TVdMow?=
 =?us-ascii?Q?xdjA5Fl+xH8cya+rEdqo2QfegLAeeCI7f1WGmOfQ3JBqX2Pw0CjNJp+mls+5?=
 =?us-ascii?Q?aqsSCV/tUubhX/g+nac4BkkiBsZ+qSSkrVjbSlcqOh2SNU3c82NqUxELr5Ud?=
 =?us-ascii?Q?ye+NU5gFtj0YchDvqGQSQwDaBxVQBDv6JZtechZufPDZPIMdZif93OXlxnGa?=
 =?us-ascii?Q?PJVjDm42/EYnYuz+EaNYp5XgSsf0uuGYog2KA6/XE5/ED2hSsopUYmeRiE7I?=
 =?us-ascii?Q?2AA04y4W7sAAzK+3Ws9Csjp47KqtRBUGkg8GP/wREOGGmkA4BS83rRkSIPRg?=
 =?us-ascii?Q?L4+AyuHsy5LjHfXPQwy7cE4RB++vkBYxu0GqBNtLFYe/QcaQ/dM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Oroz8s6In7wNcnrNRE5u3QdyVBg1MrXZqXOVb3N3e3mU4qOgjv09ixoneLoU?=
 =?us-ascii?Q?UIDVPA9wnJVyQi63hCWIiVtXUJkivrAzySel7/EQ+BU40UTtChP+fb7zA5Ot?=
 =?us-ascii?Q?RpoWxaWYS9rXdbKwPEi/tOv8DKzpkMIfXXIkZ0saCboEV4Vgb6qwyB+zE85q?=
 =?us-ascii?Q?pbAbBnGv/h4IbLR1EhHh7ioA5vyXxoWUjjdmyONtPDhFwBKY0AD+KfRGNXNG?=
 =?us-ascii?Q?4aXWwurDH2Mk+WOYOOaFXg/3RRbWPM6IyxLQ3xmZvj2QHDjX9274xmXBA+cA?=
 =?us-ascii?Q?OpI1FXaDcTg45lx45XGicazIwv1GfmtMZEK0NdAdhX5HgSbbxthWVwQugKHC?=
 =?us-ascii?Q?1wwEQNjHaei/PRRzZAfCvgc+dUHuit3smFdVH0djE/KZbPE02oTIw3mieXgm?=
 =?us-ascii?Q?TuvedR/ObySoYJCfwARUER5v1+V4WvmlMEgevI4K2ZHGKJpESRX1OFbIqLgC?=
 =?us-ascii?Q?yqMnMES2sEJVdJRRleoU0Cv4CQmv79VeO2ar1CqGm1KKoAl2YYFZ+NnGs5nM?=
 =?us-ascii?Q?7CMrUUu+n5UiTVo2bMyl8W8XJeaj0pvZ7hgOdsbKg16pTv30s9nmMjKBUvoA?=
 =?us-ascii?Q?mrhIHhYeCmmYZ7/IvS5xjEzqfsfkNHdLG0tn+N39ANtEfS6mXuGnsM6D4MbE?=
 =?us-ascii?Q?gAJw1Gpi973o3wPf3Ml0Bvvuvv1Y7W3XK9RnCQy6hCB4vJ75o3FrZwoBXr/H?=
 =?us-ascii?Q?uyrGGpgLB/LdF/yEqp+xeRf+xO6v2yfjz0refbkhSnnfQvoMhjowFz8iaK+x?=
 =?us-ascii?Q?zcIH0cTCoaK4ccubkbu3geLa5NfdbVSzRM/XRHPurdEydEl4tt2vaonpfQ3R?=
 =?us-ascii?Q?diXKMsdhKsPfdpP2IVKr2C5BcYakpHhGmNBlvR7DIqRaXDDZZqS4VfqrphW7?=
 =?us-ascii?Q?7+sl4GKNHRfpYrmLzSGKLT/DxGdedJa1l6wB7IZgimxdkCTLF37burHTmXw3?=
 =?us-ascii?Q?bxP2+KOCKucHn4B8oj6Odzo2JFrzBHiSZTAACe4hPKdSenxQiL1SvyO/ApQV?=
 =?us-ascii?Q?ALU1DJ0XUbaEQpNAI4T4i2ExAPtFcCVjPwX2sj6N0thc8tEXrvqs4r9qPWe7?=
 =?us-ascii?Q?OOi/I21vM+B46JGt8H1wysc07kkHa9M5qeGSQAA1m/kTOtVZ2QEL33bZl5qF?=
 =?us-ascii?Q?z0NBsZo5xw2VC+lhqcRn5jzyNA2eq7RX1S6i4TLKlqs0NRYTmTpDdX2ASlXe?=
 =?us-ascii?Q?pSWF7rziQ6hAt4khdRGrKN7R6Pij5L6hqXWgmWxVQUii0TNi2XVQnOcvgtk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc368df2-c324-4710-84b4-08dd930803fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 16:54:39.2357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, May 6, 2025 6:07 AM
>=20

Update Subject prefix to "x86/hyperv".

> When Secure AVIC is enabled, call Secure AVIC
> function to allow Hyper-V to inject REENLIGHTENMENT,
> STIMER0 and CALLBACK vectors.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ddeb40930bc8..d75df5c3965d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -131,6 +131,18 @@ static int hv_cpu_init(unsigned int cpu)
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  	}
>=20
> +	/* Allow Hyper-V vector to be injected from Hypervisor. */
> +	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT)
> +		x2apic_savic_update_vector(cpu,
> +					   HYPERV_REENLIGHTENMENT_VECTOR, true);

This will allow Hyper-V to submit the re-enlightenment interrupt on
any vCPU, even though the Linux guest has programmed the interrupt
to only arrive to a particular vCPU.  That selected vCPU is set up in
set_hv_tscchange_cb(), and maintained in clear_hv_tscchange_cb()
and in hv_cpu_die(). I'm not super familiar with the re-enlightenment
code, but I don't see a problem if Hyper-V sends the interrupt on an
unexpected vCPU.  So it's probably OK to enable this interrupt vector
on all vCPUs.

> +
> +	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
> +		x2apic_savic_update_vector(cpu,
> +					   HYPERV_STIMER0_VECTOR, true);
> +
> +	x2apic_savic_update_vector(cpu, HYPERVISOR_CALLBACK_VECTOR, true);

This is redundant with Patch 3 of your patch set. In Patch 3, vmbus_interru=
pt
is set to HYPERVISOR_CALLBACK_VECTOR.

> +
> +
>  	return hyperv_init_ghcb();
>  }
>=20
> --
> 2.25.1
>=20


