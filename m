Return-Path: <linux-hyperv+bounces-5573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D1ABDF37
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AC24E3862
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063362638B2;
	Tue, 20 May 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BUtWBVuM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010017.outbound.protection.outlook.com [52.103.2.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF225FA29;
	Tue, 20 May 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754827; cv=fail; b=uVfzolA58lswJh8G/wa9RTwh1tSLzkz5KavLAQG5ax/xzVhYpR14P+pTrND10pNNrZov+30TByRuntfTKtZGS6AqQZIvNb14vAc94cddPgGzJZKXjcF17YhfsGIyjv0WWTwffSsGtKJXo8c1Un/lcSZ9HcnJsbCmF0qubO4h39c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754827; c=relaxed/simple;
	bh=jP4t54txtf5gKaosC1kz+W4UgFzBK5vfwrBUZNbSqPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ukZ8Z/43tNJzZMs03zS1Z4cYXgSDxaeEiZW44qfXRMdVZ2ItEidRBJPBBRBvaDqTLMihK8/x3LtUQfYyO0XYap4RQcqBZLUsW1l7gpRjWCmMVnaluoxRZ1NkcNYtWvtq/LC7PAabs2B8uI52xlcWT+f1BY8wRhbTTmro/86QMvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BUtWBVuM; arc=fail smtp.client-ip=52.103.2.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4UgypQ3iEhXj5fUuBGbHN9h4HbuQrqErRLXevmCEF9zQCjVrKnwWn2FuVTLUUdCYV8LiOgH+qM4fEMg9/mciIUc8yv8GDi8V9/AK1owTmAE0kQ3iUyJwxaof+2bkhvOi0ZaEkoC5oP/QsjXjdZpJs7TtY93cbePssk0Qi1i6oQ+9PKTVx9nrPn+ZieOfQ2cod9DMjsWDD91mf4t/XuO86Z9v9EXqrQSaolZfCZwnXNPBID4tRdd6+FilJ1VhPjUtS7sooaZNHhKfH9XoMt8u0tK5P/ypG01lU2baj+Ccj5cdmI2xZ3s7oUUo1Fw8J3HEeXxxrdU3/pzJ+tLwJznyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTt+dPUzsBnn1ej+S2opiB7X0h5dPvCRAowZgFZz2Cg=;
 b=Ykp4sG6X+msNRKLEhUpoQh3q+ElSiQOwwuMR/lPage1M5fulu+hKRT8MB9QATYES0CaF6HQMk/m/80P6fvMxVpKqFVb4/5FQOvXlWkeqFUh/X6OeXnDEZXwHgeriCRIBAJRfKAS4l1k7eYVFJg31hxhGlOAPWB+gQTdgP4y0c+kj/rnxiJPnlQvAyAUM7yucej0iI0T32yjSmDP6TO2p88FDJYn5HI1Dp4ZCfUaJuNkMae+ayQSMHMO5QVxx7mTWWi3WapZJixAtT9jnCXAuRl8UhxZU8hx682j4XZkna6r7HQGL5MXP22teumD8RYEpSJpWPiXiIcp+Gr2HkCoT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTt+dPUzsBnn1ej+S2opiB7X0h5dPvCRAowZgFZz2Cg=;
 b=BUtWBVuMRap466t1neW8DJCv4KQ9GpyuRPL7ZVWCC98kUL8dFocQpAWmsYfnkVAVHStp1Qiop+BBsQGteZX8jcby4LkOACt33KGw2pykGNCv4NQfcXVPEkISNQWrjXCH3U3rbEyqo416898cz2PV96utn9Tu5l/Y+BXSvBui8KXFLzUxpSfD32Kj5C/5WCDA2OXC0hV1rzXcoffCD6caCw+5GHxIK35eyQYhCuu+CAyDA2WDeeekr/mvSBrmi5cH2bgH3P9QSxbAuq/gHSUaDkVhayWZsGmSYUelfO8xGbT2PMFJcULUqvVQUJFkGuaLBL5NElGm9oUMo3JEtFe/fA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8677.namprd02.prod.outlook.com (2603:10b6:510:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Tue, 20 May
 2025 15:27:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 15:27:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/3] x86/mm: Unexport tlb_state_shared
Thread-Topic: [PATCH 1/3] x86/mm: Unexport tlb_state_shared
Thread-Index: AQHbyXeXt51CfrLeLE6hxhOvDAu24LPbog3w
Date: Tue, 20 May 2025 15:27:01 +0000
Message-ID:
 <SN6PR02MB4157DEDFD687C0EF20A2864DD49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250520105542.283166629@infradead.org>
 <20250520110632.054673615@infradead.org>
In-Reply-To: <20250520110632.054673615@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8677:EE_
x-ms-office365-filtering-correlation-id: 7bc9a4ea-b85c-4d7b-f858-08dd97b2c4e4
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|41001999006|8062599006|12121999007|8060799009|19110799006|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NA0WhjG0+IVIxrkUKtENRBgZcIXMAS2nnTGISv0plqY7Dq5ezILjgqWFZMOU?=
 =?us-ascii?Q?bK1J9MTQrU30DaY/8UbyeiGCj2Xt64BJXJCTHILKiWDmSvts564BMaxvlK3U?=
 =?us-ascii?Q?LOtG1Q8m8DW3/iinZ2D+ZLxPCLRXgJpCdK7nVkLwZzRykDp7CEjEqgT+w3Dj?=
 =?us-ascii?Q?auyUBotVAdjnJaYnDYWRMnN5iV00DGqXGl9hPWgUpKQ2IVN9dDEkknOZlKZ+?=
 =?us-ascii?Q?e0YKsFWKzgOgwGf7uNB8ntTPeB7cR52/mNuuT623i4KPPumv3eOCrJ36MVwP?=
 =?us-ascii?Q?QPT4aKNrMW2GKjKK/52WYT1qdEuBJ9GieCN2UuVZXQQk2dV+05qaGnDdzRF+?=
 =?us-ascii?Q?Nsvhn5UbzxpzuR92dlWdDRuXJa2NC3WBf5VV1ornH94rp7eFz9z/xLIlxcNn?=
 =?us-ascii?Q?kSjoafXk1arf+XKmB1dXvAdvUtGEbV6L0GaQf62xVM7yK5PSUx2mwsY6nDTx?=
 =?us-ascii?Q?DuNqYBkytH/usmBCdKzMmBX63SbECploym8oGtBmsRwybALorJi0M5SfanN6?=
 =?us-ascii?Q?Rf8DdaVZnKGNNCSUM6MNmC7bbySM3bVVr6dr5IYD7C0hZ541n2z/ffN143jI?=
 =?us-ascii?Q?BypNH/2ITQ/ESPBc692zPTkNviWA6IibG+0niY65vwM4EYuTM1EnXr9oOf7K?=
 =?us-ascii?Q?lLnEpr5i2UP8XCaKPTgH2DhVDfB5r6MU+4jPgOovULt33wH9p03m0Ap+nIqx?=
 =?us-ascii?Q?PBZsevI4u+T9/o286MSgJVSy1k2lGabqgItiLLdX1zMKUG/b9Ax5Dk7m8Dve?=
 =?us-ascii?Q?6VPAWGMYMB3hcKP/CrPhUq5CSgcGhVbrT5dXkeTHC1HjFZrffKaxQfh9f3c1?=
 =?us-ascii?Q?Qkkog06Ad9rqsuEqeub8ldAR9xY9vjZfH4oJS+movkfTXogu7ntjMaMHCcPJ?=
 =?us-ascii?Q?/ePdmNepCIF+RuFDwRd9ZDxRPtlsYFbLdzB195Y5sgua/guhz9f5BQNEkMPh?=
 =?us-ascii?Q?wE1IJKFPPs8y2p5Si5c9OF7pKDCNBH4feFDyoTP+RxfHsVY/8LHkjLWoWsBG?=
 =?us-ascii?Q?KLtpVWhIJa+VTSOn8J+ZrCY3WjdTI5NYakBJel3qbNGkT6LYheliy3V2uFmZ?=
 =?us-ascii?Q?I2z0xkAEN5rYPIzk15XXcfrH/Ib15bZp3CcTs/B6hGcIX8/BKrjhRKxiSVd2?=
 =?us-ascii?Q?ye8wNBx5wIg4tlsXMN6KCnjFJtg7+HWkmw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kXhnlawxcxwJptH1kl+rQkBnTs8k4cmd8pcSRzwXmnYU8w6FuZwX0oSBMwQe?=
 =?us-ascii?Q?TL6e/p2/2HLuBtB2TV4iMMwEiqkIyami0frsQT+ivpfiVAPt5eDSx6G1Foaw?=
 =?us-ascii?Q?iEzRLMOChe5lCEwyaKSLZJc8a1uTJaoCR+f7s/BNXPxvqgLNrTaCuD49PFjG?=
 =?us-ascii?Q?G24fu/YD1YVT99HUReCHWZXzHM0v04gi3zxm135raoRslrA3q+aDvRW8LlQP?=
 =?us-ascii?Q?UiHrV6kBmZMvChHw9bSrqRyaxLRYg/WTRyhcyawLnWSN1YeFu7fsITX5FVgK?=
 =?us-ascii?Q?SgJL7iPCXtoUm+ucEh/ctIn1rFSlQCwwITYzwx7FNZmonezixv928ZGFqMEM?=
 =?us-ascii?Q?X4vCnZi3XWtv1WFkul4wcrWp71+cH5Y/0fBdCKGLvuA6qbp+XpWl7ghMqx9p?=
 =?us-ascii?Q?Ez27P38r3aFZlV+ODE9RIL/JrtxJPmgA4uD/BIXqinzua0vikdL41j7alqtt?=
 =?us-ascii?Q?bvi/lHO/EH26Qqyh1G384wrTXcgCIDuA9g1hUnSHDsP5qrl1KDmFMzY72nSG?=
 =?us-ascii?Q?PJpjqBA/zd9OerZ1rEcu/1ZK4fUPg2QGPe6PLKHxT+iuG0Fblxd+lPRmbe76?=
 =?us-ascii?Q?r475oVMFgqRtoMuwVOkfkMkD7aVfSL28lPceqD6N/OOyi0na/vNyPWELjq3G?=
 =?us-ascii?Q?lQ6xCKcdLoSyMIPdBfhQKomZjwQC9ZM6ZdnZGaSmBmD8/bvrROLNFEWPPbPI?=
 =?us-ascii?Q?845CtLK6fddn/aEIdkBR5K4HDFcnreJFJvaV8eWPttzrlZdC4r6utawTCOHM?=
 =?us-ascii?Q?eIYB3IImXS5K6mSWbFIYa5yCs/NFHoj6BdsutyK22sfA35xlwVGQEywc43F2?=
 =?us-ascii?Q?E+j4VcZAd/5oJCgVKzxx3b18/axmtsj7nr66hJSzBRcyApP8sIvWOGlCD2zF?=
 =?us-ascii?Q?CoLYUw1VEmGxXCpnVitz5xGTAorCxwYiY3ZWOiApCaJ/dVTerp+wRdy8u+V0?=
 =?us-ascii?Q?bRkQIqZFTAMe0Rj3awy904GnqVJAHsJoVgizNGlg0/dkYy8+S9tFU6bjr8kQ?=
 =?us-ascii?Q?lVHV5G09ERcm/KkaIzYM0Thd/+Bq/+Ibt6HGGIUHmYXGw2ind4J1OBkgyk1/?=
 =?us-ascii?Q?/sVxCpT1kbE4cJAub9kY34EHxJmguWPljEe/mYIs7gd2Iye4KWJmqroWJnga?=
 =?us-ascii?Q?cLMxDLR6j3Wmn3WtvS8fqWd9wwjGvQhogJ8XHwrqK6M/cE0jLZ9dy4fajbbz?=
 =?us-ascii?Q?b9gVDCOYUQG6Fgi7B1WXKqUaOGnEBwwY/uVGMDJAmXeZYB9NZ4snnOuYwrg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc9a4ea-b85c-4d7b-f858-08dd97b2c4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 15:27:01.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8677

From: Peter Zijlstra <peterz@infradead.org> Sent: Tuesday, May 20, 2025 3:5=
6 AM
>=20
> Never export data; modules have no business being able to change tlb
> state.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/hyperv/mmu.c           |    9 ++-------
>  arch/x86/include/asm/tlbflush.h |    2 ++
>  arch/x86/mm/tlb.c               |    7 ++++++-
>  3 files changed, 10 insertions(+), 8 deletions(-)
>=20
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -51,11 +51,6 @@ static inline int fill_gva_list(u64 gva_
>  	return gva_n - offset;
>  }
>=20
> -static bool cpu_is_lazy(int cpu)
> -{
> -	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> -}
> -
>  static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
>  				   const struct flush_tlb_info *info)
>  {
> @@ -113,7 +108,7 @@ static void hyperv_flush_tlb_multi(const
>  			goto do_ex_hypercall;
>=20
>  		for_each_cpu(cpu, cpus) {
> -			if (do_lazy && cpu_is_lazy(cpu))
> +			if (do_lazy && cpu_tlbstate_is_lazy(cpu))
>  				continue;
>  			vcpu =3D hv_cpu_number_to_vp_number(cpu);
>  			if (vcpu =3D=3D VP_INVAL) {
> @@ -198,7 +193,7 @@ static u64 hyperv_flush_tlb_others_ex(co
>=20
>  	flush->hv_vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
>  	nr_bank =3D cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
> -			info->freed_tables ? NULL : cpu_is_lazy);
> +			info->freed_tables ? NULL : cpu_tlbstate_is_lazy);
>  	if (nr_bank < 0)
>  		return HV_STATUS_INVALID_PARAMETER;
>=20
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -172,6 +172,8 @@ struct tlb_state_shared {
>  };
>  DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_sha=
red);
>=20
> +bool cpu_tlbstate_is_lazy(int cpu);
> +
>  bool nmi_uaccess_okay(void);
>  #define nmi_uaccess_okay nmi_uaccess_okay
>=20
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1322,7 +1322,12 @@ static bool should_trim_cpumask(struct m
>  }
>=20
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shar=
ed);
> -EXPORT_PER_CPU_SYMBOL(cpu_tlbstate_shared);

FWIW, this EXPORT wasn't there for Hyper-V code. The EXPORT was
added in commit 2f4305b19fe6a, and it's not clear why. That commit
was 2 years before the Hyper-V MMU code started checking the lazy
flag.

> +
> +bool cpu_tlbstate_is_lazy(int cpu)
> +{
> +	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpu_tlbstate_is_lazy);

This EXPORT isn't needed for Hyper-V. The Hyper-V MMU code is
never built as a module, even if CONFIG_HYPERV=3Dm. And I can't
see any other reason the EXPORT would be needed.

In any case,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>=20
>  STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
>  					 const struct flush_tlb_info *info)
>=20
>=20


