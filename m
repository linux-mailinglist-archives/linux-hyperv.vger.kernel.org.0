Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25440707A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Sep 2021 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhIJR0d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Sep 2021 13:26:33 -0400
Received: from mail-oln040093003012.outbound.protection.outlook.com ([40.93.3.12]:30622
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229664AbhIJR0b (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Sep 2021 13:26:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxvKzTW3Iu62VvrXK0f7sEDqfUNzTOOaG9Gl99Ai8wjw/h2vIonfZD5C8f2EEuXJPvzfhT03VyUQv0jiOZKaKOGd0Do9UelItlQXBoB30FbzVpcabCyLtcGth1YwudD0jLLHgTtSYachPnRM8l8VQngJbNsabOz00AMCYCFOkvtsS8H4fDZqjtnTHB3vmTjAdgImA3whLVm3AAaDga8h9eFIPzydVpfxW+F6sVCzAs6GFeYd1C94XEN6ZNzp/ZtSB1gl2BwFaznBfhuRUEdzFtt/RlubIKtuIyzX/Hm0tD3JdXOcjJ84ixoRjBTUe3tsh23ei2uK+tMHPacSESKCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fD2Z0fu2oKBh6MbyzWyV391PA7YXTAWFPpiu0MQ9GSg=;
 b=ZIWYVv8UKNnG01B/tyiniAamwPAm/pNLuMuB/VccJuKBYotYHrUy9j/GMKJ+7JkLLP/cfYNPXDgra7yH3afhJjAXVUrbyWj2ZgOc00bTEui0qn1lSNkYazWwYw1UXGJUzfAw8GZezk7S5klaMtWDGm9dQGxU8iMtb4H/aXtivkl7Lw7sjsCJPQy+TVZ8Q7DFvoV1KrO9pcd2VWDxmG1o5cxtE7ekRoQaJkerT1aKCTeLX0YyGCI5Qc2m9R+Eeb7nND/Qi+dikyQRLDXtSTe25T44KZDBkHEl2ZzT1ukcmS/4YfotZnktEVD6RnEbvr+YqN1c5yJn9zZrDFRsTVpyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD2Z0fu2oKBh6MbyzWyV391PA7YXTAWFPpiu0MQ9GSg=;
 b=gbB7DoMT8y6n/zfZBjxfvZDKWtxRs7DQCS585is3g8pFU3W+OtCvSYKM8ZM1j72T15+QaFmQx3HRDn6qu/pn1Y1Yzgh+6hc1HCXph/FQFoPVVAjQxYINT5euA3tFx0qp3jENPnvuBbc6y+cTKQwMu+orpxNNKyML8cAWhSysT90=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1787.namprd21.prod.outlook.com (2603:10b6:302:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.1; Fri, 10 Sep
 2021 17:25:16 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202%6]) with mapi id 15.20.4523.008; Fri, 10 Sep 2021
 17:25:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
Thread-Topic: [PATCH 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
Thread-Index: AQHXpOm2+wS6++nat0SioP4s99uY86udgMhA
Date:   Fri, 10 Sep 2021 17:25:15 +0000
Message-ID: <MWHPR21MB1593AE1097D5312649A1D3B4D7D69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210908194243.238523-1-wei.liu@kernel.org>
 <20210908194243.238523-3-wei.liu@kernel.org>
In-Reply-To: <20210908194243.238523-3-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e7ae73ae-301e-4585-a40c-53ce12d305ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-10T17:00:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 230dc318-712e-4374-5f80-08d9747ff48b
x-ms-traffictypediagnostic: MW2PR2101MB1787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB17872333339624EAB480A69DD7D69@MW2PR2101MB1787.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6Asnyo4qOikwFXHlR8WHekYHNXtS3nqJXxCoFzpJoeY8yaKbXWvVAUjrlMUvgXNWj04Aqx5fADhUTezl+lKZPqEnDyopstA1U+NcWcb2e5AUX+XYtNGEOQv5Te10kxt/g79jQt/w4qPNDYr6ewVPq0gRiRtFiDyQQWIb4tC7+jz4UM1MpJrxzSBm9kG6XJgyQ/CihLqDhKW+99ARo8EZ96MSHTlScbJgMj98yvhUQbf5nKW5mhRMiq3kH6Lj/+WLtBAP5+dxkKK4BYWn2Kd7ZLOXHjsuAi8OwCYWfZD+sj6si6G8hvgtgdhbkKIq74zIRjEfG3Oe9s6xiaMZpbGIrIMjhNEOKVHh5PyBovnIQJZXBimvdO+32/qLcX3c6y6aLt/MVnOAdhvQMoTAcs7zz9VxSM7APXyps+dcwBFkplyApuL+U57sMTHCddMBsuE4iGVyCQrDXpa2UyAcRt0LcsYoXuUmpukjxnh6kl31fB4YgiPS2YRb2cA0jHbYr4fJlRq/Bfv64pgv2/EMBW0BFlCF9FPWdH4Wj4x1l7YB2+yOaAuTBQUPGcOd+ygbUA7m+ufCvEyMdHbkU+uzGfe89IXyYI3FFnu3Iu4o49C9hmaq8EjoVkpp8rKWe6Mgnra6HTf7QufwGrBheU8TVq12gOw/2djn4uFbkeWolRLsFcYSkLzjB4fbvoKmFuyGCteXrtrGnD9yP2ul4KbZS+7Fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(10290500003)(38070700005)(38100700002)(508600001)(76116006)(4326008)(186003)(8676002)(66946007)(66446008)(8936002)(9686003)(64756008)(66476007)(66556008)(52536014)(6506007)(7696005)(122000001)(316002)(26005)(86362001)(54906003)(110136005)(82960400001)(82950400001)(71200400001)(83380400001)(33656002)(8990500004)(5660300002)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oW6654deNjdEjpdPap1HgsnkNaRJ5GMAF64K9Jhejk8FlyNdUQkKhRxlA+vY?=
 =?us-ascii?Q?0UH4AcfZtYD9Oe/pfeNEtsxyizo+xYfLKf7o0u1B/Gr2/Mx2mQWbBfaBzeyG?=
 =?us-ascii?Q?gnoxqXJ8PZAfgU6xG4um3KAD4X3S+aaLJsZ++tbEH9R0QqxaqOmm7dDnQRLO?=
 =?us-ascii?Q?tsddO833xn/NszxoCJ8L+X7otv4yb3SAL/1aLyZvCgYO2S3a/tTBv/GK+ub4?=
 =?us-ascii?Q?1MnjsJhVvRolNeFlJ3RHcBf/UcQ3dx2TB1y3oNzT4B2LdcwtjxZhJf5WOfJv?=
 =?us-ascii?Q?P4LBRsXd9DffoQ9ZGDG3V2LKukM/b56//6uY15XcNM0liCR+tTCoM+/9WfQd?=
 =?us-ascii?Q?TuMo/vV3fiusk889+IrLVQ4fOPpVTEsEKqsG8UaZG+nyV1Bs+9/H0qb4Y2VO?=
 =?us-ascii?Q?GGvy5yTFEN+1tflIeKrHwqMZbXlueSsuRSkMDA4lIeI4ZwL346gixIm+f0K6?=
 =?us-ascii?Q?j5hGQGC7OE1onFL8x5WdEpYyQQZaCpuRPk9JxcFKZhFvHYxgzCMi1lMlX5Ng?=
 =?us-ascii?Q?lldsTPakanWlXpjqNR0XtPLPZ4fkGSi53q4nt/6xoz+ExPS/2Zi2+sXu32QI?=
 =?us-ascii?Q?2DfOLt0AWP/oLxofdS27D0pUQkFyRSqt/1YtM9LsDd8xEo4FPdONf0mvCTtb?=
 =?us-ascii?Q?RZMi3GEIkttNsY2GiLDCwzfZZoKjEMvU8ZX/rIlppuxkEhoEnNfOs/WZoIby?=
 =?us-ascii?Q?NZIVIr5hDBGz8esuiSHzs8Z4iVY7rNV2i7h1yRErF4MrgECXH/YS9T2LVeFE?=
 =?us-ascii?Q?12GPiHEq1jK4OgzaJGGpsxeDWKXGCJEpBNskj28CnJJ1ymLy7JFEbuKV1LbS?=
 =?us-ascii?Q?OjgiZSOhabVud9qVzR+Zmm26r1LFdY3ZvWXaMx6IOxJM1YZKlJFQwZgl4f5m?=
 =?us-ascii?Q?iiB3OkC8oLyJzwTuVHeNPnQfraZKyGK/4WvII8N00+O4u3h8n90UQ3XroVgN?=
 =?us-ascii?Q?ikh0MTrQ2QJHt9XGNZ1ZLD6zmcmilV986IN1orgvtYzbTGaZR7vr7BGkQUFN?=
 =?us-ascii?Q?Y5Rad6JaRpO9DF3qqVwBqeMKo4l7XgveZWobaXx3MTEvYiguDO9wJK4wXnou?=
 =?us-ascii?Q?tacPYo1fVEGNpryc3X6JdpS34Yixrs4l4LIomusoWnDjdXpDzIKFCrEvaGZh?=
 =?us-ascii?Q?H3HaFPy2BWKBBu6zdmO6NZXU2VQi9BG9UJsnk4QWo11Yv+BEqAFw7O22jIh+?=
 =?us-ascii?Q?XqtN8JIS+9etmBXLGZKCKiBk59XuJnhqHhOQwhvWIrOsWQXQZfjCpX1EEtW9?=
 =?us-ascii?Q?R6aZwYZ2qDhuJBvfTHUo9fbgGf9yIz1FLjKlyv3hatUVl6U7ciEhRTDXTpUr?=
 =?us-ascii?Q?b3ksUUc/1rkBIR1ogpHwIbsq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230dc318-712e-4374-5f80-08d9747ff48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 17:25:15.9790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tejxZyKvHpj/jwjjFw3fApAc9xLS0MUtUFBKFkzqNXe6MRc2UjqZcdyDgMI+CDa9T3+al1G9w96j/9ENiUAS/fGJlYfJlNnh7ODgXRCxDXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1787
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, September 8, 2021 12:43=
 PM
>=20
> It is not a good practice to allocate a cpumask on stack, given it may
> consume up to 1 kilobytes of stack space if the kernel is configured to
> have 8192 cpus.
>=20
> The internal helper functions __send_ipi_mask{,_ex} need to loop over
> the provided mask anyway, so it is not too difficult to skip `self'
> there. We can thus do away with the on-stack cpumask in
> hv_send_ipi_mask_allbutself.
>=20
> Adjust call sites of __send_ipi_mask as needed.
>=20
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 68bb7bfb7985d ("X86/Hyper-V: Enable IPI enlightenments")
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_apic.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 90e682a92820..911cd41d931c 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -99,7 +99,8 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
>  /*
>   * IPI implementation on Hyper-V.
>   */
> -static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> +static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
> +		bool exclude_self)
>  {
>  	struct hv_send_ipi_ex **arg;
>  	struct hv_send_ipi_ex *ipi_arg;
> @@ -123,7 +124,10 @@ static bool __send_ipi_mask_ex(const struct cpumask =
*mask, int vector)
>=20
>  	if (!cpumask_equal(mask, cpu_present_mask)) {
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
> -		nr_bank =3D cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> +		if (exclude_self)
> +			nr_bank =3D cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
> +		else
> +			nr_bank =3D cpumask_to_vpset(&(ipi_arg->vp_set), mask);
>  	}
>  	if (nr_bank < 0)
>  		goto ipi_mask_ex_done;
> @@ -138,9 +142,10 @@ static bool __send_ipi_mask_ex(const struct cpumask =
*mask, int vector)
>  	return hv_result_success(status);
>  }
>=20
> -static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> +static bool __send_ipi_mask(const struct cpumask *mask, int vector,
> +		bool exclude_self)
>  {
> -	int cur_cpu, vcpu;
> +	int cur_cpu, vcpu, this_cpu =3D smp_processor_id();
>  	struct hv_send_ipi ipi_arg;
>  	u64 status;
>=20
> @@ -172,6 +177,8 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int vector)
>  	ipi_arg.cpu_mask =3D 0;
>=20
>  	for_each_cpu(cur_cpu, mask) {
> +		if (exclude_self && cur_cpu =3D=3D this_cpu)
> +			continue;
>  		vcpu =3D hv_cpu_number_to_vp_number(cur_cpu);
>  		if (vcpu =3D=3D VP_INVAL)
>  			return false;
> @@ -191,7 +198,7 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int vector)
>  	return hv_result_success(status);
>=20
>  do_ex_hypercall:
> -	return __send_ipi_mask_ex(mask, vector);
> +	return __send_ipi_mask_ex(mask, vector, exclude_self);
>  }

This all looks correct to me, except for one difference compared with the
current code.  In the current code, if the cpumask passed to
hv_send_ipi_mask_allbutself() indicates only a single CPU that is "self",
__send_ipi_mask() will detect that the cpumask is now empty, and=20
correctly return success without making the hypercall.  But
the new code will make the hypercall with an empty input mask (both
in the SEND_IPI and SEND_IPI_EX cases).   The Hyper-V TLFS is silent
on whether such a hypercall is a no-op that returns success or is an
error.  We'll have a problem if it is an error.  I think the safest thing
is to enhance the cpumask_empty() test at the beginning of
__send_ipi_mask() to also detect the case where only a single CPU
is specified, and it is "self".   This could be done using cpumask_weight()
and checking for zero as the "empty" case.   Then check for "1", and if
exclude_self is set, check if it is the "self" CPU.

The check for VP number >=3D 64 could also give a false positive since
"self" isn't filtered out yet, but that's OK as all that will happen is usi=
ng
the _ex version where the non-ex version would have worked.

>=20
>  static bool __send_ipi_one(int cpu, int vector)
> @@ -208,7 +215,7 @@ static bool __send_ipi_one(int cpu, int vector)
>  		return false;
>=20
>  	if (vp >=3D 64)
> -		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
> +		return __send_ipi_mask_ex(cpumask_of(cpu), vector, false);
>=20
>  	status =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp))=
;
>  	return hv_result_success(status);
> @@ -222,20 +229,13 @@ static void hv_send_ipi(int cpu, int vector)
>=20
>  static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
>  {
> -	if (!__send_ipi_mask(mask, vector))
> +	if (!__send_ipi_mask(mask, vector, false))
>  		orig_apic.send_IPI_mask(mask, vector);
>  }
>=20
>  static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int =
vector)
>  {
> -	unsigned int this_cpu =3D smp_processor_id();
> -	struct cpumask new_mask;
> -	const struct cpumask *local_mask;
> -
> -	cpumask_copy(&new_mask, mask);
> -	cpumask_clear_cpu(this_cpu, &new_mask);
> -	local_mask =3D &new_mask;
> -	if (!__send_ipi_mask(local_mask, vector))
> +	if (!__send_ipi_mask(mask, vector, true))
>  		orig_apic.send_IPI_mask_allbutself(mask, vector);
>  }
>=20
> @@ -246,7 +246,7 @@ static void hv_send_ipi_allbutself(int vector)
>=20
>  static void hv_send_ipi_all(int vector)
>  {
> -	if (!__send_ipi_mask(cpu_online_mask, vector))
> +	if (!__send_ipi_mask(cpu_online_mask, vector, false))
>  		orig_apic.send_IPI_all(vector);
>  }
>=20
> --
> 2.30.2

