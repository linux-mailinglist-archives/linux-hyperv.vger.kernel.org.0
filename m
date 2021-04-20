Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B633661A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDTVao (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 17:30:44 -0400
Received: from mail-eopbgr770138.outbound.protection.outlook.com ([40.107.77.138]:21193
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233769AbhDTVam (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 17:30:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXfYYbCGNnnp4tdrHXp6lqgBVp5fVS2b7oFQxOjXlgtQNCc3jwghxlTg1fGAC1ngkQl8dTCyEoaJVONFtl8jyuYV4XvTgDkoHld63NCZHXYeC4iMGpPbmoiu0y+LjUfDT6wtdBqrjA+pznSgffSJ5qRQAhhvZ22Zc0Jj7WdzRAnUCY1Db7iG+CttiZpcfxbtg8HbmfAbQBJtQE1iKMQeKwbvg7Ml6e9mTYjVvS2RTdWI3rPBzH/ADNd4wcJf3xNTn4Cm3tG6b6MG65IT60m9a+X8z72mhFTWVu6qAJSdmUTZMMnmeUKJNiGhVOeDLZFcktE9cNjNQqhtYu0X0XebIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDPm8hWi+qaIay6AA0MgpP8ybkBzaKMUW8gzO5HjZGI=;
 b=XH1IYJngoDl2oCf9xb7eJnjuoQwffwImDmudmquHPyE+2XgwnnOoUhbHK1giWqlFwyhaYGEnbbCARoBL1ctlji5EWebUU63jcPy+My5E+STsETM3BdYfTgyFDZYqqUmIWwZGrMRayvBRSmJP58S8X2LvRE29AzbMyD3FinVS85QKL2gmwGU1qEn3X7qMdRO1UabN5/Zs1U5ncByFFGFP8pnf2NhW5rm4VQQmy4lhe/Dwn4XyZMuV5wmSqQawEqxBmdkbQJGoj3y4Q4k7oF4FysqX74ISHwjWiTKty+P5m3rYnYfUpZLeTXchTOEXlg5Jf3UbKGkvYh/e6XeGNdIvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDPm8hWi+qaIay6AA0MgpP8ybkBzaKMUW8gzO5HjZGI=;
 b=PCXA2Vch8TlNdYDFBK7qjWDBPmZXP4YmhXCrQutFTxQUqbcrD0mb1LTxJMsw/1yRvh7dwXO0JRPjjsdtqKqMjDXHEIXtKRPv8TFNB+llg8uNptdKzdVGc8VukM3ZE8h/U4MVbHwanTqd82YKSJvR1MuQwa0O7DpwiHkFkD1hyuo=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR2101MB0874.namprd21.prod.outlook.com (2603:10b6:301:7e::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5; Tue, 20 Apr
 2021 21:30:09 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%5]) with mapi id 15.20.4087.015; Tue, 20 Apr 2021
 21:30:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Joseph Salisbury <Joseph.Salisbury@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] drivers: hv: Create a consistent pattern for checking
 Hyper-V hypercall status 
Thread-Topic: [PATCH 2/2] drivers: hv: Create a consistent pattern for
 checking Hyper-V hypercall status 
Thread-Index: AQHXMyKmCOaK5Ql0dE+hFN81khu7Tqq98Rqg
Date:   Tue, 20 Apr 2021 21:30:08 +0000
Message-ID: <MWHPR21MB15936E55F2A6FD6994DC4F34D7489@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1618620183-9967-1-git-send-email-joseph.salisbury@linux.microsoft.com>
 <1618620183-9967-2-git-send-email-joseph.salisbury@linux.microsoft.com>
In-Reply-To: <1618620183-9967-2-git-send-email-joseph.salisbury@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=670fc9d3-ba50-43f2-aab9-170f029e3b1f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-20T21:25:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a513a45-a090-4a64-ae03-08d90443790a
x-ms-traffictypediagnostic: MWHPR2101MB0874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0874ACAA95FCBCA70173D183D7489@MWHPR2101MB0874.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 071F7icu5Fgrv+fuEcc9TwHAzRcKyk+GKEczFSDkkWIjuBgicBoosTEePfUG3K/kTeDRJhtUZVAE8G41UEs8dyWzdXbYT2VgXa65UKEFA6zChi3Y8bqQhXnInPlGYiU52gBk8SGRIeqDxwN0/iWSwM3IKN9ePETOuBcUUHignGOxfXNF110LXjfzOJ/IsE6gR62krPqu7LTiDGY9pSP96LOTOP8KvPA+APGEMZwadhSKf9B5VxrrSshhiR4a6M8kf5El421j0Go5cURRhBofg9/jD7tQI3kCGm7Wo6zJHM0iQ1Jcjiz5K87fPvIbRGrwFCghsxutEYPLlvk/GqoVW7dVIWeYLD3DDlVwio+BaZCxylcsjc1TE4hxqnV6EKroCCqPq0+ywExbDLZoAxHAVXlyMsQcV1MjCZl66dDBXxnooLFGgJ/8bjfQ86qj1Rqb5ET2aHMEc102D5V7gPw7ztSaxUlIphQHyEnQ+11ov3WjuppLajEHVsut1EqkXP8ut/9jyPfEf5JZM/I/hkXKY7yZjmWjCSknhwAM15oFSF2iq1RnuGVHVG7AJrLRScS+i6w4yfXwwSpXFz3HdE2VBi86IoP2fKxmH89vhRZDME4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(33656002)(8676002)(10290500003)(66946007)(66556008)(8936002)(7696005)(66476007)(4743002)(54906003)(9686003)(71200400001)(52536014)(4326008)(64756008)(186003)(26005)(110136005)(30864003)(6506007)(478600001)(2906002)(316002)(55016002)(83380400001)(82950400001)(76116006)(82960400001)(86362001)(38100700002)(8990500004)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?36NOnJhz8sAL5ZzJ0T9zDauzpp/5SczXlKdAehQrqUyO8PPOHEyejAEY+l3d?=
 =?us-ascii?Q?nHITmXuHepkbCDDhwaDitoxZ717f7QzCWffnC24E/eammc+zkuxTzo6c33Q/?=
 =?us-ascii?Q?Nl55kMuFiT2yZ49GQ2/lrC/vpH0OkXQ0Xx9AJDpIiKdqSLFUQx5bo5f8YHiz?=
 =?us-ascii?Q?6heFuIHvpZUxtIKimyO7PDUAQcEwITAo91vPFgoDZ5aMEv1yDEKTIZ1HPC5V?=
 =?us-ascii?Q?YV1V/kxWkoWD4YTtmpwd1+ueB1aM8sXcaGPft4xI7nkB38BQAAK2G0QtbyGE?=
 =?us-ascii?Q?+wXICV2wceDKiOslskS1UhR63L3gBSkhoy9XDRf1lAJtR6PUuww2EukHMxha?=
 =?us-ascii?Q?gYaFREVRrd01NLrNa0OhYYLto7cQn5o0xAhD8LVpxuKCS0vWpYs2eePYeqBB?=
 =?us-ascii?Q?tDNmCoraUAHSlinLKd5cTsilEoYq812OD+SYi/dvS1iFty+0Snl/+ihRW5G6?=
 =?us-ascii?Q?50TlMDVqRS4IvX7HgeABDUro5QsbNUNw8POyG0NMFzsr9u7NyIXnsTea7BsT?=
 =?us-ascii?Q?OKhpIqWL78PhLsop3DS6lH+dZVeqkHjVhXlUWEFi1kIUSC+HezE5WFAlrwFP?=
 =?us-ascii?Q?muZP3lsl7nl3fAv5cbC7QKlKDSrWGMKlvG3FbJLW9Ny4soV3q/fHslQeRPsk?=
 =?us-ascii?Q?GI2E3hjVQuajylBACRP88WjPatNpqjKrG+5Tjw0zmMZdd4YHgYqxBWmcY6GN?=
 =?us-ascii?Q?3m+DAytrz1aLTeUTD6FuHcUSLBHt5wZsrAzuFxvoCGXJTjrBa09orTgDhWrk?=
 =?us-ascii?Q?Oxg/vxMa9bxsu3kKEOCx5MbtohafPNOEPo+bqvqCx0NplfvDxK6R02lEZXPx?=
 =?us-ascii?Q?6fSN790wEOSag2HOvsym93fUuXMPzN4+2z9Te+DY7FV6Uv3waT7jCiFGcRp2?=
 =?us-ascii?Q?RH0coJ0+QxwxDchtGtNkpfzoIYBMae54DcybmT9idv/PoYlrvoNgta39btJj?=
 =?us-ascii?Q?rHtg/S8f47S+cIlvzEV6uX1p+rvE8BqUujTxxkln5fKNsvfPPH6vMvBOIHBL?=
 =?us-ascii?Q?lLwle6UB4LrHIfv9cLIX2ku8bv82ty4iLxsiJjsvJSFSU8PzokS+RNKdoYIl?=
 =?us-ascii?Q?35XkYe1w4Q6uFHwlPaVnfhLnBsYnAev5UwWK9yETll1jKK2+XgKRdCaGQout?=
 =?us-ascii?Q?51pBCXprgQ86Yw/hvqJ82/KKpaekp9H+VmCCg6zjhd0AmD2IkIlrUUD02Tay?=
 =?us-ascii?Q?ZpsmUxaVePT81JV1HJEGUNIOrqtKxdU4UpUPUsLhkDtpriz6tVJkFNKXWw9A?=
 =?us-ascii?Q?bPDkVL97C/5xjvOatx+dtICGWMNrIq54MjXFtT542JABFokGKO7mH7KIIR4f?=
 =?us-ascii?Q?yrCDPaRfndQO+n08FQpeTPNy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a513a45-a090-4a64-ae03-08d90443790a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 21:30:08.8869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rq2KgeIBlSBjVvNWW0VGe8nQ/m8eB0Xje31CHBXtIYf+OD3RURBeEpvmjRbZ9+8YNlPnze3K3ys0O5L2StgojU508fizJRVJhUEuWun3S04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0874
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Joseph Salisbury <joseph.salisbury@linux.microsoft.com> Sent: Friday,=
 April 16, 2021 5:43 PM
>=20
> There is not a consistent pattern for checking Hyper-V hypercall status.
> Existing code uses a number of variants.  The variants work, but a consis=
tent
> pattern would improve the readability of the code, and be more conformant
> to what the Hyper-V TLFS says about hypercall status.
>=20
> Implemented new helper functions hv_result(), hv_result_success(), and
> hv_repcomp().  Changed the places where hv_do_hypercall() and related var=
iants
> are used to use the helper functions.
>=20
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c           | 16 +++++++++-------
>  arch/x86/hyperv/hv_init.c           |  2 +-
>  arch/x86/hyperv/hv_proc.c           | 25 ++++++++++---------------
>  arch/x86/hyperv/irqdomain.c         |  6 +++---
>  arch/x86/hyperv/mmu.c               |  8 ++++----
>  arch/x86/hyperv/nested.c            |  8 ++++----
>  arch/x86/include/asm/mshyperv.h     |  1 +
>  drivers/hv/hv.c                     |  2 +-
>  drivers/pci/controller/pci-hyperv.c |  2 +-
>  include/asm-generic/mshyperv.h      | 25 ++++++++++++++++++++-----
>  10 files changed, 54 insertions(+), 41 deletions(-)

Wei -- I have gone through these changes reasonably carefully, but
your review of the Linux-in-the-root-partition changes would be a good
double-check.  It's too easy to get the sense of the tests backwards. :-(

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 284e73661a18..ca581b24974a 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -103,7 +103,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *=
mask, int
> vector)
>  	struct hv_send_ipi_ex *ipi_arg;
>  	unsigned long flags;
>  	int nr_bank =3D 0;
> -	int ret =3D 1;
> +	u64 status =3D HV_STATUS_INVALID_PARAMETER;
>=20
>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
>  		return false;
> @@ -128,19 +128,19 @@ static bool __send_ipi_mask_ex(const struct cpumask=
 *mask, int
> vector)
>  	if (!nr_bank)
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_ALL;
>=20
> -	ret =3D hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
> +	status =3D hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
>  			      ipi_arg, NULL);
>=20
>  ipi_mask_ex_done:
>  	local_irq_restore(flags);
> -	return ((ret =3D=3D 0) ? true : false);
> +	return hv_result_success(status);
>  }
>=20
>  static bool __send_ipi_mask(const struct cpumask *mask, int vector)
>  {
>  	int cur_cpu, vcpu;
>  	struct hv_send_ipi ipi_arg;
> -	int ret =3D 1;
> +	u64 status;
>=20
>  	trace_hyperv_send_ipi_mask(mask, vector);
>=20
> @@ -184,9 +184,9 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int
> vector)
>  		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
>  	}
>=20
> -	ret =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
> +	status =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
>  				     ipi_arg.cpu_mask);
> -	return ((ret =3D=3D 0) ? true : false);
> +	return hv_result_success(status);
>=20
>  do_ex_hypercall:
>  	return __send_ipi_mask_ex(mask, vector);
> @@ -195,6 +195,7 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int
> vector)
>  static bool __send_ipi_one(int cpu, int vector)
>  {
>  	int vp =3D hv_cpu_number_to_vp_number(cpu);
> +	u64 status;
>=20
>  	trace_hyperv_send_ipi_one(cpu, vector);
>=20
> @@ -207,7 +208,8 @@ static bool __send_ipi_one(int cpu, int vector)
>  	if (vp >=3D 64)
>  		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
>=20
> -	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
> +	status =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp))=
;
> +	return hv_result_success(status);
>  }
>=20
>  static void hv_send_ipi(int cpu, int vector)
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b81047dec1da..a5b73584e2cc 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -369,7 +369,7 @@ static void __init hv_get_partition_id(void)
>  	local_irq_save(flags);
>  	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
>  	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> -	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS) {
> +	if (!hv_result_success(status)) {
>  		/* No point in proceeding if this failed */
>  		pr_err("Failed to get partition ID: %lld\n", status);
>  		BUG();
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index 60461e598239..f16234aef358 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -93,10 +93,9 @@ int hv_call_deposit_pages(int node, u64 partition_id, =
u32
> num_pages)
>  	status =3D hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
>  				     page_count, 0, input_page, NULL);
>  	local_irq_restore(flags);
> -
> -	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS) {
> +	if (!hv_result_success(status)) {
>  		pr_err("Failed to deposit pages: %lld\n", status);
> -		ret =3D status;
> +		ret =3D hv_result(status);
>  		goto err_free_allocations;
>  	}
>=20
> @@ -122,7 +121,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, =
u32 apic_id)
>  	struct hv_add_logical_processor_out *output;
>  	u64 status;
>  	unsigned long flags;
> -	int ret =3D 0;
> +	int ret =3D HV_STATUS_SUCCESS;
>  	int pxm =3D node_to_pxm(node);
>=20
>  	/*
> @@ -148,13 +147,11 @@ int hv_call_add_logical_proc(int node, u32 lp_index=
, u32 apic_id)
>  					 input, output);
>  		local_irq_restore(flags);
>=20
> -		status &=3D HV_HYPERCALL_RESULT_MASK;
> -
> -		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> -			if (status !=3D HV_STATUS_SUCCESS) {
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (!hv_result_success(status)) {
>  				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
>  				       lp_index, apic_id, status);
> -				ret =3D status;
> +				ret =3D hv_result(status);
>  			}
>  			break;
>  		}
> @@ -169,7 +166,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32=
 vp_index, u32
> flags)
>  	struct hv_create_vp *input;
>  	u64 status;
>  	unsigned long irq_flags;
> -	int ret =3D 0;
> +	int ret =3D HV_STATUS_SUCCESS;
>  	int pxm =3D node_to_pxm(node);
>=20
>  	/* Root VPs don't seem to need pages deposited */
> @@ -200,13 +197,11 @@ int hv_call_create_vp(int node, u64 partition_id, u=
32 vp_index,
> u32 flags)
>  		status =3D hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
>  		local_irq_restore(irq_flags);
>=20
> -		status &=3D HV_HYPERCALL_RESULT_MASK;
> -
> -		if (status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> -			if (status !=3D HV_STATUS_SUCCESS) {
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (!hv_result_success(status)) {
>  				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
>  				       vp_index, flags, status);
> -				ret =3D status;
> +				ret =3D hv_result(status);
>  			}
>  			break;
>  		}
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 4421a8d92e23..514fc64e23d5 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -63,10 +63,10 @@ static int hv_map_interrupt(union hv_device_id device=
_id, bool
> level,
>=20
>  	local_irq_restore(flags);
>=20
> -	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS)
> +	if (!hv_result_success(status))
>  		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
>=20
> -	return status & HV_HYPERCALL_RESULT_MASK;
> +	return hv_result(status);
>  }
>=20
>  static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_ent=
ry)
> @@ -88,7 +88,7 @@ static int hv_unmap_interrupt(u64 id, struct hv_interru=
pt_entry
> *old_entry)
>  	status =3D hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
>  	local_irq_restore(flags);
>=20
> -	return status & HV_HYPERCALL_RESULT_MASK;
> +	return hv_result(status);
>  }
>=20
>  #ifdef CONFIG_PCI_MSI
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 2c87350c1fb0..c0ba8874d9cb 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -58,7 +58,7 @@ static void hyperv_flush_tlb_others(const struct cpumas=
k *cpus,
>  	int cpu, vcpu, gva_n, max_gvas;
>  	struct hv_tlb_flush **flush_pcpu;
>  	struct hv_tlb_flush *flush;
> -	u64 status =3D U64_MAX;
> +	u64 status;
>  	unsigned long flags;
>=20
>  	trace_hyperv_mmu_flush_tlb_others(cpus, info);
> @@ -161,7 +161,7 @@ static void hyperv_flush_tlb_others(const struct cpum=
ask *cpus,
>  check_status:
>  	local_irq_restore(flags);
>=20
> -	if (!(status & HV_HYPERCALL_RESULT_MASK))
> +	if (hv_result_success(status))
>  		return;
>  do_native:
>  	native_flush_tlb_others(cpus, info);
> @@ -176,7 +176,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cp=
umask *cpus,
>  	u64 status;
>=20
>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
> -		return U64_MAX;
> +		return HV_STATUS_INVALID_PARAMETER;
>=20
>  	flush_pcpu =3D (struct hv_tlb_flush_ex **)
>  		     this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -201,7 +201,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cp=
umask *cpus,
>  	flush->hv_vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
>  	nr_bank =3D cpumask_to_vpset(&(flush->hv_vp_set), cpus);
>  	if (nr_bank < 0)
> -		return U64_MAX;
> +		return HV_STATUS_INVALID_PARAMETER;
>=20
>  	/*
>  	 * We can flush not more than max_gvas with one hypercall. Flush the
> diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
> index dd0a843f766d..5d70968c8538 100644
> --- a/arch/x86/hyperv/nested.c
> +++ b/arch/x86/hyperv/nested.c
> @@ -47,7 +47,7 @@ int hyperv_flush_guest_mapping(u64 as)
>  				 flush, NULL);
>  	local_irq_restore(flags);
>=20
> -	if (!(status & HV_HYPERCALL_RESULT_MASK))
> +	if (hv_result_success(status))
>  		ret =3D 0;
>=20
>  fault:
> @@ -92,7 +92,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
>  {
>  	struct hv_guest_mapping_flush_list **flush_pcpu;
>  	struct hv_guest_mapping_flush_list *flush;
> -	u64 status =3D 0;
> +	u64 status;
>  	unsigned long flags;
>  	int ret =3D -ENOTSUPP;
>  	int gpa_n =3D 0;
> @@ -125,10 +125,10 @@ int hyperv_flush_guest_mapping_range(u64 as,
>=20
>  	local_irq_restore(flags);
>=20
> -	if (!(status & HV_HYPERCALL_RESULT_MASK))
> +	if (hv_result_success(status))
>  		ret =3D 0;
>  	else
> -		ret =3D status;
> +		ret =3D hv_result(status);
>  fault:
>  	trace_hyperv_nested_flush_guest_mapping_range(as, ret);
>  	return ret;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index bfc98b490f07..759136f98e19 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -9,6 +9,7 @@
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
> +#include <asm/mshyperv.h>
>=20
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index f202ac7f4b3d..307fe26dd81a 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -68,7 +68,7 @@ int hv_post_message(union hv_connection_id connection_i=
d,
>  	 */
>  	put_cpu_ptr(hv_cpu);
>=20
> -	return status & 0xFFFF;
> +	return hv_result(status);
>  }
>=20
>  int hv_synic_alloc(void)
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 27a17a1e4a7c..aa278005dea2 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1292,7 +1292,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  	 * resumes, hv_pci_restore_msi_state() is able to correctly restore
>  	 * the interrupt with the correct affinity.
>  	 */
> -	if (res && hbus->state !=3D hv_pcibus_removing)
> +	if (!hv_result_success(res) && hbus->state !=3D hv_pcibus_removing)
>  		dev_err(&hbus->hdev->device,
>  			"%s() failed: %#llx", __func__, res);
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a5246a6ea02d..27d85d675e9a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -41,6 +41,24 @@ extern struct ms_hyperv_info ms_hyperv;
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>=20
> +/* Helper functions that provide a consistent pattern for checking Hyper=
-V hypercall
> status. */
> +static inline int hv_result(u64 status)
> +{
> +	return status & HV_HYPERCALL_RESULT_MASK;
> +}
> +
> +static inline bool hv_result_success(u64 status)
> +{
> +	return hv_result(status) =3D=3D HV_STATUS_SUCCESS;
> +}
> +
> +static inline unsigned int hv_repcomp(u64 status)
> +{
> +	/* Bits [43:32] of status have 'Reps completed' data. */
> +	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
> +			 HV_HYPERCALL_REP_COMP_OFFSET;
> +}
> +
>  /*
>   * Rep hypercalls. Callers of this functions are supposed to ensure that
>   * rep_count and varhead_size comply with Hyper-V hypercall definition.
> @@ -57,12 +75,10 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 r=
ep_count, u16
> varhead_size,
>=20
>  	do {
>  		status =3D hv_do_hypercall(control, input, output);
> -		if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS)
> +		if (!hv_result_success(status))
>  			return status;
>=20
> -		/* Bits 32-43 of status have 'Reps completed' data. */
> -		rep_comp =3D (status & HV_HYPERCALL_REP_COMP_MASK) >>
> -			HV_HYPERCALL_REP_COMP_OFFSET;
> +		rep_comp =3D hv_repcomp(status);
>=20
>  		control &=3D ~HV_HYPERCALL_REP_START_MASK;
>  		control |=3D (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
> @@ -87,7 +103,6 @@ static inline  __u64 generate_guest_id(__u64 d_info1, =
__u64
> kernel_version,
>  	return guest_id;
>  }
>=20
> -
>  /* Free the message slot and signal end-of-message if required */
>  static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_=
type)
>  {
> --
> 2.17.1

