Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D77487ACD
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jan 2022 17:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbiAGQ4f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Jan 2022 11:56:35 -0500
Received: from mail-centralusazon11021020.outbound.protection.outlook.com ([52.101.62.20]:50774
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240168AbiAGQ4d (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Jan 2022 11:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpafGYz/GdfugOSfQeEVgooICh8GnVTjF7INQfaDYfgJmnFYWuLizke4JrEb8fc0Y1dXpsMQ4gZXl/+KfPIRRXPwEDNc5sNrYR6t0DAlYxXPdcw/4DyAS28k96z5mVEyask1OAgfzQZDzmXY2bEpJMU9P9l+4gBGrlKp727OlbvB3fGS165vqdBwjN2NitAsVPjkWEgK73TUwL4tm45bQ+3MP1hTJpiPpxRvQJDj6iURq36Rn7oNvxEtuvM+ZwlH3kccHS9VXKyrqt+C640uu0Awf/9VBrRDvw0hlqsRKWIq+zyJaBeNilOdRvHoIg7amDSB1N1Hee7FJV4J1W0hwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWfBdG/2/Zizie5ypXO9AR02tDETtz8NHEK0vdnR9XI=;
 b=CKMSUV9uQnzoTmsKHoHBOEUtezBCFYr3R3S8oFIxFwqTDFv2SUTxkntxVoNLxO8/dDTVSzk8/T9Rn4luL2OKX1D5nVNIrs3XDypgsYWOGS32bAvJxFfIkDgsP6QCNEvtxi7OXMOw9x3/W/mwhpkzy92MqsXAPoE3Cztte/AYGzUTsrwUzZBJgkTeDDUF5rL9C33izSrKgcAnPUxJSsVFiGoFwks5OBPxeth2J0egtJuGs8KMK/xYSw42uolvN/wrK6ijLtVyiDUynDeifmW4j2nrAGU4u3SpCQVfLjVeB+jJF9Xurp1pcNbkNPXlQVsOUDxFPkgTKlBP6O5kF5iX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWfBdG/2/Zizie5ypXO9AR02tDETtz8NHEK0vdnR9XI=;
 b=HU6vVMl4FJ297fze+pOcAVx0l9yxv9xbVxM99VX4koU8riW00/WXz21tA+yYd5avIuUDtYFuxlmr07BJNH0XFX6HYiorWMheo9S13VFKtV3r+nC5ehXui9rjencokMlF3UGmYiU3+0xdO2+KdznW8yvv+EYUUf5gL4R8Xf0m9XI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM6PR21MB1339.namprd21.prod.outlook.com (2603:10b6:5:175::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.7; Fri, 7 Jan
 2022 16:56:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d%7]) with mapi id 15.20.4888.007; Fri, 7 Jan 2022
 16:56:30 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: Properly deal with empty cpumasks in
 hyperv_flush_tlb_multi()
Thread-Topic: [PATCH] x86/hyperv: Properly deal with empty cpumasks in
 hyperv_flush_tlb_multi()
Thread-Index: AQHYAuJFPsgoT/Z2D0CkJlxoZXJAKaxXyDoA
Date:   Fri, 7 Jan 2022 16:56:29 +0000
Message-ID: <MWHPR21MB15938ED874CF437A9C540050D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220106094611.1404218-1-vkuznets@redhat.com>
In-Reply-To: <20220106094611.1404218-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e9f2b78-3495-498d-9e69-4e30d9622fd4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T16:52:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99342aa2-4c9c-4195-cc18-08d9d1fea6ef
x-ms-traffictypediagnostic: DM6PR21MB1339:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB1339BC4B3F19EC88019907C2D74D9@DM6PR21MB1339.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7LnTHB5EDZrthSV3dItkuRKL2BK3ZNLphCcP0Brqm1HgI8D7t1ByhbY15b5xd14cWkW/qhdTs5KK9wyfirhnRlgQ2ZOTc15NuJdjJcYTnAVZhvDvOLIJysW04yztVb8jb/Px6HPKzuRh/tRFBCY9W4vHn6oe9g2MdYKRLIE8LQAa8Ga+bRbPCrnxMB26Gg+25vfo4vEHGErjz2rezp3Q9nOVDnwMnTMeM6zLTU6rAMlxqeenn2wT4xsWXbBLGSPo6G+o9C7n1it9p12IlC32rBjV9wfxkEZE1Y2eUuNedV0Vkg60oiSmU9p5cC1uIVQ2u65yrxeCTxniV23NBa+yGQOaaz9VKlVwMjaYOdmP2LUlL9RPoJpnZx2w2e4Ua8b6XmMk5PQZOsYvdptUJ0HoKoL1sCpu3MuzIq28LqIZHuaG9O6SP5En2eVfTWbuW+UZ9nfESw9dokB4rAPhXnT9ktFFTI4bZc5UUdsYcOZyehKyPRQEbimpPkJz1joe16FrcopH/HCVs5+Ar5WeslJE5E3R+kmherh9WDEqMRm86DpeNqHCGaZvnpHK/+ket5NgCU9X6K6RUPVf1yDamU/V6PjliOIK8YV/aB/ktKD3qZd/N3A+l8CN8hEH/bFsctW2ZZkQz4QRb4v9O+aRfiSItRY2fZX4TGlfTQZ3FYHcTsrq5rFNELNIwA6qN4jWALFj+gpBOW6zt4uP50zfe+Y5IE4NOVdXEhBGphICCvK8ndnKDLuqXzef1P+0tSPVBNm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(54906003)(66476007)(66556008)(66446008)(316002)(33656002)(64756008)(66946007)(55016003)(8936002)(4326008)(8676002)(76116006)(2906002)(5660300002)(8990500004)(52536014)(9686003)(82960400001)(38070700005)(10290500003)(7696005)(71200400001)(508600001)(6506007)(86362001)(186003)(26005)(83380400001)(122000001)(38100700002)(82950400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0t8ohEajt661iG/dVUosyoW3jKFzgxazE72kbqXJidrCfV4KsRvl96r/XE8?=
 =?us-ascii?Q?6HnK0OqAjPXui5/xyJjBRj7PSCZsFzW7CHh+tZtOd/IRfSispMql6Ut1dSP4?=
 =?us-ascii?Q?iulaBqqr7GDtg87twrcilbO/xblmxobSJmU8O82XYzsoRnXJ09xWtPQAozfS?=
 =?us-ascii?Q?LiF0r4a+k36xJnGniPcB0Ao/2A1OfkZFS9EZ4JpjyIcidPBB913iWWDMEHSB?=
 =?us-ascii?Q?zVPzs5iIXJigMRKNEnosqWZ9+Oysmh2O8dt+8WAb/Gg6q3w9zINh/PMP/x9j?=
 =?us-ascii?Q?Nb5ObRbnkJD1V+73vAps7rV6Fni6u3Irci5YO41PRhzpubjSW1T9ETrKpGRz?=
 =?us-ascii?Q?+8qoCjZa6KPO8lZQC3AxA9NjQTLUndDZo3cqHLwIFteTfBcInzXw/DaX6bSx?=
 =?us-ascii?Q?Q1lnTh5sS5U1emQH3cF6wY0Y29xfZzxM+Ed0jEPq6NGUlsLdA7U439Fo7X8P?=
 =?us-ascii?Q?CQy/vsBgwplZ4fdJ4poMgK3yGZNC7h/A7S5ZKvaFNVnwivHcBcNLEE3VvbYj?=
 =?us-ascii?Q?NAJ/+DTE+uRG/Yct+35t7F5P6PQ1JBCZlYCfCqXfKF/4c71UhPwtROSbBVee?=
 =?us-ascii?Q?Z0eWGhIoDtysavcHkNiUfqti4iJLut6xLExjCAZBnSoEwh6IZ4hSmnhM6o6V?=
 =?us-ascii?Q?TrQyKLHdNr5Tv4HafGZpz53H/9DCNXQzlg7ESsZX3PjxbTN0Vbmh4Z7oxbqK?=
 =?us-ascii?Q?TfZelWjQcYuWg175ic1IWe1KmQ/ZKVF48PtUZzRTch4Taq3bV91tjYd77WCG?=
 =?us-ascii?Q?A35YgIe5ws6oWFDD016xXB7+BoFocguJunZg00/ESF2yP6ETJJ3DndR5xf+a?=
 =?us-ascii?Q?vtUFWRcDjxLk8kToD8WHoiKx2ARuxm+7+q+z9DychT7CYNQsFc46EdDpSsW/?=
 =?us-ascii?Q?fnigeaGo5XtGHhyt/GtJhB4Tbc0cxY+/hGytDCHmLef6pMG8B0FPywMdLdLr?=
 =?us-ascii?Q?IzPAbW/JZl8hpT5LJJMZqJeJS8C6YbrAML81/fFYvWfNiTfZk4MWQtXu+1+H?=
 =?us-ascii?Q?JWE+HRkI2ydC5qR9CMMAVlmKvNcntAnTpaW3mTA8N5FVW9XHBp8cI7R/bfT+?=
 =?us-ascii?Q?7hqcRt1tPfTR/nLbowFF6292PkqaDkpHq7hERcDfcqOaMiaE9xzLkQUn8Edh?=
 =?us-ascii?Q?DYkpmRLFArpPbT68fWC8WlH6cdROnTQTdrvCUJBAQPmC7kAkth5jyAXmmiL4?=
 =?us-ascii?Q?ZaQX5nQ+g7YgsCzjGAnlFPCUlsrOjt5iq4N8My3YpMzUR2feYd8TbODqQOlQ?=
 =?us-ascii?Q?w/BRFAmz+JsmYk4XevTYBULvI/bBX5X251A7SQqfesW10Jk6LI9iuC6XC4C3?=
 =?us-ascii?Q?CBHALUwFaPE9ASRj5OZEXQW7JjTGyoQIxl2LrawgXLNXOInooNe3qIVhZ5dS?=
 =?us-ascii?Q?1zgtERv9EsTHwvhavpfmlGavFhz+vl6OjisNKvFRrHt+rnnY4p0twlUMwwbW?=
 =?us-ascii?Q?5UAslcVy2k+PhYZgNeuaz1yEb0gzcxk/bAw7HYxKEKYZsynItPBhOlWEp5PF?=
 =?us-ascii?Q?9t9Vbh5pySqSsLs3VtY7e0VTYKSKJmHci0GW7Az3j0Tcjwe6hlWi/i36K5kF?=
 =?us-ascii?Q?Se/KmR8mK8ipsEgu1CEKZPC79N3wofRT7m5zKmz9sjQQ05BnfNaRoBZXJPFq?=
 =?us-ascii?Q?YZfaSTD2iyMclgNLn+OzNc9Qakznw70Ij/3vmDP7dzkiCDdHni9pivzwarWM?=
 =?us-ascii?Q?DDUeLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99342aa2-4c9c-4195-cc18-08d9d1fea6ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 16:56:29.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XL1s5vLYyFvkblJdRL/LqaHdUX2WH4IvznJRKwov/Lu2eUlh0AW3DMbmayAe7FfaAZLzviP1CdVa0PV9SJHO5BLUFjSMojCBtlB3qG5LwUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1339
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, January 6, 202=
2 1:46 AM
>=20
> KASAN detected the following issue:
>=20
>  BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_multi+0xf88/0x1060
>  Read of size 4 at addr ffff8880011ccbc0 by task kcompactd0/33
>=20
>  CPU: 1 PID: 33 Comm: kcompactd0 Not tainted 5.14.0-39.el9.x86_64+debug #=
1
>  Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine,
>      BIOS Hyper-V UEFI Release v4.0 12/17/2019
>  Call Trace:
>   dump_stack_lvl+0x57/0x7d
>   print_address_description.constprop.0+0x1f/0x140
>   ? hyperv_flush_tlb_multi+0xf88/0x1060
>   __kasan_report.cold+0x7f/0x11e
>   ? hyperv_flush_tlb_multi+0xf88/0x1060
>   kasan_report+0x38/0x50
>   hyperv_flush_tlb_multi+0xf88/0x1060
>   flush_tlb_mm_range+0x1b1/0x200
>   ptep_clear_flush+0x10e/0x150
> ...
>  Allocated by task 0:
>   kasan_save_stack+0x1b/0x40
>   __kasan_kmalloc+0x7c/0x90
>   hv_common_init+0xae/0x115
>   hyperv_init+0x97/0x501
>   apic_intr_mode_init+0xb3/0x1e0
>   x86_late_time_init+0x92/0xa2
>   start_kernel+0x338/0x3eb
>   secondary_startup_64_no_verify+0xc2/0xcb
>=20
>  The buggy address belongs to the object at ffff8880011cc800
>   which belongs to the cache kmalloc-1k of size 1024
>  The buggy address is located 960 bytes inside of
>   1024-byte region [ffff8880011cc800, ffff8880011ccc00)
>=20
> 'hyperv_flush_tlb_multi+0xf88/0x1060' points to
> hv_cpu_number_to_vp_number() and '960 bytes' means we're trying to get
> VP_INDEX for CPU#240. 'nr_cpus' here is exactly 240 so we're trying to
> access past hv_vp_index's last element. This can (and will) happen
> when 'cpus' mask is empty and cpumask_last() will return '>=3Dnr_cpus'.
>=20
> Commit ad0a6bad4475 ("x86/hyperv: check cpu mask after interrupt has
> been disabled") tried to deal with empty cpumask situation but
> apparently didn't fully fix the issue.
>=20
> 'cpus' cpumask which is passed to hyperv_flush_tlb_multi() is
> 'mm_cpumask(mm)' (which is '&mm->cpu_bitmap'). This mask changes every
> time the particular mm is scheduled/unscheduled on some CPU (see
> switch_mm_irqs_off()), disabling IRQs on the CPU which is performing remo=
te
> TLB flush has zero influence on whether the particular process can get
> scheduled/unscheduled on _other_ CPUs so e.g. in the case where the mm wa=
s
> scheduled on one other CPU and got unscheduled during
> hyperv_flush_tlb_multi()'s execution will lead to cpumask becoming empty.
>=20
> It doesn't seem that there's a good way to protect 'mm_cpumask(mm)'
> from changing during hyperv_flush_tlb_multi()'s execution. It would be
> possible to copy it in the very beginning of the function but this is a
> waste. It seems we can deal with changing cpumask just fine.
>=20
> When 'cpus' cpumask changes during hyperv_flush_tlb_multi()'s
> execution, there are two possible issues:
> - 'Under-flushing': we will not flush TLB on a CPU which got added to
> the mask while hyperv_flush_tlb_multi() was already running. This is
> not a problem as this is equal to mm getting scheduled on that CPU
> right after TLB flush.
> - 'Over-flushing': we may flush TLB on a CPU which is already cleared
> from the mask. First, extra TLB flush preserves correctness. Second,
> Hyper-V's TLB flush hypercall takes 'mm->pgd' argument so Hyper-V may
> avoid the flush if CR3 doesn't match.
>=20
> Fix the immediate issue with
> cpumask_last()/hv_cpu_number_to_vp_number()
> and remove the pointless cpumask_empty() check from the beginning of the
> function as it really doesn't protect anything. Also, avoid the hypercall
> altogether when 'flush->processor_mask' ends up being empty.
>=20
> Fixes: ad0a6bad4475 ("x86/hyperv: check cpu mask after interrupt has been=
 disabled")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/mmu.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index bd13736d0c05..0ad2378fe6ad 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -68,15 +68,6 @@ static void hyperv_flush_tlb_multi(const struct cpumas=
k *cpus,
>=20
>  	local_irq_save(flags);
>=20
> -	/*
> -	 * Only check the mask _after_ interrupt has been disabled to avoid the
> -	 * mask changing under our feet.
> -	 */
> -	if (cpumask_empty(cpus)) {
> -		local_irq_restore(flags);
> -		return;
> -	}
> -
>  	flush_pcpu =3D (struct hv_tlb_flush **)
>  		     this_cpu_ptr(hyperv_pcpu_input_arg);
>=20
> @@ -115,7 +106,9 @@ static void hyperv_flush_tlb_multi(const struct cpuma=
sk *cpus,
>  		 * must. We will also check all VP numbers when walking the
>  		 * supplied CPU set to remain correct in all cases.
>  		 */
> -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >=3D 64)
> +		cpu =3D cpumask_last(cpus);
> +
> +		if (cpu < nr_cpumask_bits && hv_cpu_number_to_vp_number(cpu) >=3D 64)
>  			goto do_ex_hypercall;
>=20
>  		for_each_cpu(cpu, cpus) {
> @@ -131,6 +124,12 @@ static void hyperv_flush_tlb_multi(const struct cpum=
ask *cpus,
>  			__set_bit(vcpu, (unsigned long *)
>  				  &flush->processor_mask);
>  		}
> +
> +		/* nothing to flush if 'processor_mask' ends up being empty */
> +		if (!flush->processor_mask) {
> +			local_irq_restore(flags);
> +			return;
> +		}
>  	}
>=20
>  	/*
> --
> 2.33.1

Thanks for figuring out the core issue with the cpumask changing and
doing what should be the definitive solution!

Reviewed-by: Michael Kelley <mikelley@microsoft.com>




