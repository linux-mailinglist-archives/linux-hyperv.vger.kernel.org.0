Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38F3D1DC4
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 07:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGVFMp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 01:12:45 -0400
Received: from mail-bn1nam07on2129.outbound.protection.outlook.com ([40.107.212.129]:2638
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhGVFMo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 01:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvDtdI5wDHiOcwAFlcnD6wkCHd1tCY3vq5zKYOA/Y7DB2IUZ13t4oLD1pT1wm9/S4jJd7ZQUa4r7GtLfOJb9XIZm7GZfd9pNac7BjfYYrTe+mQ65CDanv5FtIbiRREFtfyEjAxR1j2taLcFa+Xnd2bAzxfsp57v6BcT/DXBF/T+JNlgnr2iwhiUnLBnLsQ49Qb108ncM9tsVQBwj7rR8cszIlwK3xFs7v7JkxYw3bdZeqUwODfVSDQLV2UKnF6Ib0Klz61dWdlduji5Wfzhuj3pKBpOZ2XIZpRgXF4FioU2M5pAJS6C+X4BmpyV3RYQVhd4li/dUJGcVFAUj9kjjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoQPQtncyQkNnzsHdVHin+nQvpaEGrkNGMJRVle6E/o=;
 b=L1re8pm+TkoU+i9NwQQK0rtNf4M4ABN9pw6q7+26mNSTJXaMMpvp7Qs7SWUQiJqeRW+dOlB2Y8q4bSAxXE5jXT+V6BAhmFDgEeoR2D9LmU8NOrEOjcecwc9o/qQowPT2fIVWMeZbn8XXx2iJzGUlcmyVYQvVW7xgAv0Nvb5IM7EmqzS2x529AV3pAk0KOqR5XnDnasDEjNe77IEZ0dlNSCTAUKF6+rtSB65xnR932HSF9Shfu87F/oThEWefd9oUvdoTCe82tdaQf2ut/FcFB0JQLQ5HhjnMJn8laFDPP8uHIb79EnWLZ71IGSmu/usMs/9my0dryoVBTV4i8M95EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoQPQtncyQkNnzsHdVHin+nQvpaEGrkNGMJRVle6E/o=;
 b=LVGubskh0/SFN98SgLEKJZX3UvZSLfiLgv2buS9YCwi1QIdedSmwDSwlihn6x2KuzXaR3CcA50Y79yV6tqc0zUtQdowNNhzTQw93pEH4oRchmjnGqBjT3KoeYAK8lTbzk9DJDPs+gG5DSOhHsDBM+vRysszUYo/tshfdsQ3KqcU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2025.namprd21.prod.outlook.com (2603:10b6:303:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.2; Thu, 22 Jul
 2021 05:53:17 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6%6]) with mapi id 15.20.4373.005; Thu, 22 Jul 2021
 05:53:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH v2] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH v2] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Thread-Index: AQHXflrRy8cubGTIiUy0u2ResSeyhatOejGA
Date:   Thu, 22 Jul 2021 05:53:17 +0000
Message-ID: <MWHPR21MB1593E0C67C48F800DC83F6CBD7E49@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210721180302.18764-1-kumarpraveen@linux.microsoft.com>
In-Reply-To: <20210721180302.18764-1-kumarpraveen@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=086bd09e-5d1c-4898-a9a3-d3910ada4740;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-22T05:35:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f88e74b-f56d-467a-6b9a-08d94cd500ba
x-ms-traffictypediagnostic: MW4PR21MB2025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB2025D086A851531886F9D71BD7E49@MW4PR21MB2025.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fu23qY57XDcCjnPx4soGK9Afd0MXPnanNtGSbZfxg8V862TuKM5ZoYhK29A3kSh3HFRadZ0Zcc+A7muk46il093KbT1BCKWUzZzYQ5Hlb4vIEnqAIgH5TmyHuV1l9KO4fA2Xp5yU1NmzdP3v8GhhM9ITm+/umdMo3nn0jjebuXHFAV40r1hb+AeZooqcVViiNmSMK1x3ycU1JMD11pgZrxZVzop3Ped7V3idn9R4+ouBEHwIrImXr5ijW8J+utUWj2vtNUq+wQU6E8hZ75h/Rrh6E9/mNg8G4i2vZzmeH1Bqd7hyMPbMzVCFKVKC2p2GY5DIKBFbgeWPuiutBr4FoGuUDk4orwWwKwAt94LOpVLch7BKiiPXZLngNVevYqZdjJUe4eFSbEiEUTTM69k2t8zRuBsPEt9XJ+tq4OfUzI1A1Q9gpFiVYXDa/eogHTOmezb+4YEzDbEqGj/vbki70oaNOCLyPjWBx1BP94C8IRCmilKK8mmWiPEAb+WDHBJV30emtEVs21HOirEfKf6iChfl4W23oMtlDuQ+ZItUwH1PH6J1BNe+Bf8JgUWffUt7rAyZnfKl6IuOpGVxYcr6d6m8lCCPnJyehpKNb9/0hnUMRbfC8baS89AragBkjzpigM/weQCn3a9M4u34K1WmgZ5cYyadkYLjs2FyE0LaUmHQ11zE9EFTfP0GHsIbYuJNRAOMAdnIciXcw2pn9nn/eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(4326008)(52536014)(186003)(6506007)(122000001)(8990500004)(38100700002)(8676002)(55016002)(8936002)(107886003)(9686003)(76116006)(508600001)(83380400001)(110136005)(66446008)(64756008)(66476007)(66556008)(33656002)(5660300002)(316002)(82960400001)(54906003)(71200400001)(10290500003)(26005)(66946007)(86362001)(82950400001)(2906002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8+7LtwNdiQR7uq3S+fBWhklN8QubLFU/rA6F9oJIhRzUTTeIcmRT9GgOQKcq?=
 =?us-ascii?Q?TfdwLujV0GgTxQHQcK1EuYpgqoAOXo/ppvSVpyyJiZxLKxgys8XjE26ARr8y?=
 =?us-ascii?Q?5AmuJV/rJVs71eaThXJWIOGnM1rYuCRMb3+KTnuQ8P5rTLVO561jh3zdtMi2?=
 =?us-ascii?Q?H8P5+Yqi747LOtw3JWXLN5T3o5iw3fZ5gvH6RpVDwqcGICjA+i1Zfc0h9lX+?=
 =?us-ascii?Q?tc3b2Ob0Fk3dkLlVFVxNlRgXehxxfXAbvMOvQ1FBNDFaztseEXgq4LHxjArC?=
 =?us-ascii?Q?o+kfRV6xA0qfdfi/NgxSYHzvM5Cje7tiiXRj3/c3yHR248/HMNNWT1EweKqN?=
 =?us-ascii?Q?cRKeQAuL3D6jgCUgJ+iR4txL16M2+lwl0w3+5FVUh9bjpGngtIQiLG7O+Cjt?=
 =?us-ascii?Q?aOwkFq3sGa7Y0eSGY3LIdHSrUt30UpV0UjS+E2mSlhFcO3bSIWmv67WdNSkQ?=
 =?us-ascii?Q?NGeRlCAVdBn6XagI5cbj1a3wUiG0yvFr1LFU6pAT/5KMqX6bYVWF31IeyjY+?=
 =?us-ascii?Q?/ex4XzlwMmbKY0AzXPtjY4ZIir7TV+mVimByWCf0LCjG9k8TwUd4LrSLB/UO?=
 =?us-ascii?Q?xHGIG12IGnKk9KcwVAxiXq8GEx15eP72ArFGdUdXl+jccFXju3XUNqnVl7Li?=
 =?us-ascii?Q?pGTYPFwqfjyFztyPtRd459rcqHSHZNu1M2d75MVqJOVlNgtRvIKLiNTz8t3J?=
 =?us-ascii?Q?NBbbg9nBySgd7TApxeEZLcbfT1TTiNP9kiESsbOOycwx1K+khDzkov3vA6f1?=
 =?us-ascii?Q?WQLpV0LifoCHyVcDxCyMCw2XGavibjL1uFKCWX5C2rAEJ6eNXhd0LF6U1/ZL?=
 =?us-ascii?Q?ZYCbxj2eGjeGpB+YcDAsxtz3gBjyDIKW/EJyuue7zu+swP/jfp6848OSfQJ6?=
 =?us-ascii?Q?n9gvJ5LyxZgikp22EkSDUiyTSVEzbFxvhKBFGWLmhu2KwqMukuIQQ4LEr0Ly?=
 =?us-ascii?Q?qvWBQza+3kxCdBCY3H7qUD2JxTx0XO1hg9ZsNCzZXlRj+VON9wS5gIt5PNwD?=
 =?us-ascii?Q?+HjsOzPOtgDtxcDXdaYRVMyyGeNcSjpS0pg8D+H8xoJD54P7evyTZf4Fa6QH?=
 =?us-ascii?Q?q5e/qJE3BmxR9FjS7OfjCTjVGfAFW13cQXbH5wC0+nU+t/2SA9Jkv4gYW2Kp?=
 =?us-ascii?Q?5fLa/nxGr38XN/vcvIjBHTufN1EbVKMyTN+bCMZ/j0nBhqzgXrNy4Rs5xK2C?=
 =?us-ascii?Q?q6eNS8e2Tgw5gjhyxIhDZmF5701omRES5vpIsIShsWBlrkXu90gsgc+qj1x5?=
 =?us-ascii?Q?PZQUppLLGUAaSqQE7ZuFOZxVZEBtWiD15fDNRRR0xqibXyVSFq2Ol16UuNRR?=
 =?us-ascii?Q?5wuFNKX3jsa3n+N4TNrD37Zv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f88e74b-f56d-467a-6b9a-08d94cd500ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 05:53:17.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxqCiKfnkfOB94e3Us3TEXT3FLejFvDb4iwYvrGZIrGdPm9wzcbo7LsRXQKprAPrw0RLoUQw5NWaleAPS5OTE5pofVnJpOnvSYdjrqcx4nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2025
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Praveen Kumar <kumarpraveen@linux.microsoft.com> Sent: Wednesday, Jul=
y 21, 2021 11:03 AM
>=20
> For Root partition the VP assist pages are pre-determined by the
> hypervisor. The Root kernel is not allowed to change them to
> different locations. And thus, we are getting below stack as in
> current implementation Root is trying to perform write to specific
> MSR.
>=20
> [ 2.778197] unchecked MSR access error: WRMSR to 0x40000073 (tried to
> write 0x0000000145ac5001) at rIP: 0xffffffff810c1084
> (native_write_msr+0x4/0x30)
> [ 2.784867] Call Trace:
> [ 2.791507] hv_cpu_init+0xf1/0x1c0
> [ 2.798144] ? hyperv_report_panic+0xd0/0xd0
> [ 2.804806] cpuhp_invoke_callback+0x11a/0x440
> [ 2.811465] ? hv_resume+0x90/0x90
> [ 2.818137] cpuhp_issue_call+0x126/0x130
> [ 2.824782] __cpuhp_setup_state_cpuslocked+0x102/0x2b0
> [ 2.831427] ? hyperv_report_panic+0xd0/0xd0
> [ 2.838075] ? hyperv_report_panic+0xd0/0xd0
> [ 2.844723] ? hv_resume+0x90/0x90
> [ 2.851375] __cpuhp_setup_state+0x3d/0x90
> [ 2.858030] hyperv_init+0x14e/0x410
> [ 2.864689] ? enable_IR_x2apic+0x190/0x1a0
> [ 2.871349] apic_intr_mode_init+0x8b/0x100
> [ 2.878017] x86_late_time_init+0x20/0x30
> [ 2.884675] start_kernel+0x459/0x4fb
> [ 2.891329] secondary_startup_64_no_verify+0xb0/0xbb
>=20
> Since, the hypervisor already provides the VP assist page for root
> partition, we need to memremaps the memory from hypervisor for root

s/memremaps/memremap/

> kernel to use. The mapping is done in hv_cpu_init during bringup and
> is unmaped in hv_cpu_die during teardown.
>=20
> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 53 ++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
>=20
> changelog:
> v1: initial patch
> v2: commit message changes, removal of HV_MSR_APIC_ACCESS_AVAILABLE
>     check and addition of null check before reading the VP assist MSR
>     for root partition
>=20
> ---
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f247e7e07eb..ffd3d3b37235 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -55,26 +55,41 @@ static int hv_cpu_init(unsigned int cpu)
>  		return 0;
>=20
>  	/*
> -	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
> -	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
> -	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
> -	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
> -	 * not be stopped in the case of CPU offlining and the VM will hang.
> +	 * For Root partition we need to map the hypervisor VP ASSIST PAGE
> +	 * instead of allocating a new page.
>  	 */
> -	if (!*hvp) {
> -		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> -	}
> +	if (hv_root_partition) {
> +		union hv_x64_msr_hypercall_contents hypercall_msr;

This isn't the correct variable type to be using here.  Union
hv_x64_msr_hypercall_contents is specifically for HV_X64_MSR_HYPERCALL.
It also happens to be correct for HV_X64_MSR_VP_ASSIST_PAGE, but the
layout of the two MSRs could diverge in the future.  Instead of using this =
union,
I would suggest just reading into a u64, and then mask as needed.  The code=
 in
the non-root-partition branch of the 'if' statement is similarly open codin=
g
the needed shifting/masking to construct the value to write.

Or you could define another union specifically for the VP Assist page MSR.
I'm OK with either approach.

Michael

> +
> +		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, hypercall_msr.as_uint64);
> +		/* remapping to root partition address space */
> +		if (!*hvp)
> +			*hvp =3D memremap(hypercall_msr.guest_physical_address <<
> +					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> +					PAGE_SIZE, MEMREMAP_WB);
> +		WARN_ON(!(*hvp));
> +	} else {
> +		/*
> +		 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's
> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> +		 * out to make sure we always write the EOI MSR in
> +		 * hv_apic_eoi_write() *after* theEOI optimization is disabled
> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> +		 * case of CPU offlining and the VM will hang.
> +		 */
> +		if (!*hvp)
> +			*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
>=20
> -	if (*hvp) {
> -		u64 val;
> +		if (*hvp) {
> +			u64 val;
>=20
> -		val =3D vmalloc_to_pfn(*hvp);
> -		val =3D (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
> +			val =3D vmalloc_to_pfn(*hvp);
> +			val =3D (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> +				HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
>=20
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +		}
>  	}
> -
>  	return 0;
>  }
>=20
> @@ -170,8 +185,12 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	hv_common_cpu_die(cpu);
>=20
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +		if (hv_root_partition)
> +			memunmap(hv_vp_assist_page[cpu]);
> +		else
> +			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +	}
>=20
>  	if (hv_reenlightenment_cb =3D=3D NULL)
>  		return 0;
> --
> 2.25.1

