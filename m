Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65A33D7B0F
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhG0Qf0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 12:35:26 -0400
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com ([40.107.237.101]:14049
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhG0QfZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 12:35:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5hhr2/A/5Obsrcl3vf4cbOB8TkF82p8GSbc6lgr/3eIC39vXRbe8oMlFLSctGis1saGJ3MCNUBdXf/pWc1m+EeTkChSbkJvAzp113VG4J2UOi7A+D0WPccSoZ0cI1UKwZYFSoeuYE201Wcf3xSijEn//xE1iD9TI7naXKicEOlgiKxBzI02c3/aSHOybSeK9KgvihjZofSLUbkLJaWrIrPEn2JemZDLNa0XfJkq4HEEAr6wpJjfQQOfPPnG+880eA8WMem4UBbGjD98tO34aiUdUjfx0ZWp+Nw7Mtk4muGw5p7zh98scLKJSIgzMK4E1V/oS+clgF5RQtvtuLyEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4YKT81HPHxyjze0Pf11O4VSDt6GsaPqabHypTQYS4w=;
 b=Sw9TutphNozw937/M3Mcy/DRPB5Ygw8AUKo5KJmaHSPQwJwBvMdVauaXLaOsal/MaTDSQcWlhwRUgcvdoMG/AF4/jbypwKtnA9NjYHLgM44ch7uxdd8PgeDzszTgXAWZD1Pye/odNvTkpAlsmeEK1QHDyis0cupkUptyQmSa+bW5vlfTgot5oPjzEjVAy60C057vyRtk7ggLTs0iKZMJpE3xAuBrE8EDb6Rg0+Kd0+IAMDjcTNnGLtcjS0+Hjcc+fI5dhbcYPOiFmbxv5qgB27KPnnNvxdbo/MdhJw3Hb8PCNsY4TtoG723cj9QPCi+qMt0WPIqIneggkX8CyzKY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4YKT81HPHxyjze0Pf11O4VSDt6GsaPqabHypTQYS4w=;
 b=Y7ZpBtRofnBXo3fPyngQprIoo85xVJ1VfnNhw7FmTKOwYCHmerD/CPPQgI28d/+0GJ4a5r6pg1fnFdI+3slfHDTafuFYQ+sTcjAFoUt54eEyn9Q5dfL6ZTErjTSa0gVUK14lh1p1vXNbeRpfp7StO2pTBci/A+3CGdVtfeqNVwo=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1972.namprd21.prod.outlook.com (2603:10b6:303:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2; Tue, 27 Jul
 2021 16:35:22 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::312e:7352:96f5:6afa]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::312e:7352:96f5:6afa%9]) with mapi id 15.20.4394.005; Tue, 27 Jul 2021
 16:35:22 +0000
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
Subject: RE: [PATCH v3] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH v3] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Thread-Index: AQHXgtP03ve81SCEEEKls4yjlAThZqtXADlQ
Date:   Tue, 27 Jul 2021 16:35:22 +0000
Message-ID: <MWHPR21MB1593C1A51C6E812B0DA82ED5D7E99@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
In-Reply-To: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bbb7c5d6-6379-42c3-a4ab-d20d2ffa5317;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-27T16:17:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f06b4c-addd-4207-6a5f-08d9511c8782
x-ms-traffictypediagnostic: MW4PR21MB1972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1972AF14607A57D5E3A28630D7E99@MW4PR21MB1972.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oWhb/o2hzjhBkajj0wK5lxnJ7j5QS9kWkzSAhJ0f4MQMKAttgxPzDl5jga5bLyMg2AMUlSpQbnxtNNuSEJFClr/pZYlSIIzb4KpylBnttpQwptwfUR0waGfHHEEE1zuKuhCrsFxV4UjdcG4AeC5ltak7lgf31yL0BmL1zwvpX0kcD853ZSpuaqcp7+e3Xah9ro3DZioasLri7q7LE/h6E5ybJaMVkSmzr7z0zDboewJ3e/rzIT/CfErmCKI7kqi2brDPtJOJzVbSMWKDOedK56Lzie13BW1UDM6jS+3vFCW0hZ4b96Z5qGf4BClsTVVo/QtNFrrnji5SeOY6gXneKD5fAh14ZaQH1DaOm0B81ngbRbAKCKGUhKsoKUQyd0aiE6Her2pTkAI0nINajjvHIORyZYjEd3FF9d0RBDL6blX2TJCYxnySS9lM1d8xfRAcTK3f2JmxjU71yzRuOxiiTflLYplhYKEpFo6cZhwaLgt1ANPJOPz5kBg6iVMKIRoM44cGOOvoj17QwB3q4VX7Sk8v2cQldtmzhxmnwo+7G5al/FpPyA10ppAKtUvYdJNG9Lx81MdulMFyG4zfChVjDiGFaXDE10YYYsR4uRJ2wNz3MK70fyvSu1JrAGoSndPrKg4OF+kxJxkOrPbuyZD/UjnfDoRteMmdvWfc4cfo7TvJQiBLYCDb0/+itRujALjC9PHe2I+3jooyAYgJdHVRfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(82960400001)(508600001)(54906003)(8676002)(66946007)(122000001)(186003)(64756008)(5660300002)(66556008)(26005)(71200400001)(66476007)(55016002)(8936002)(9686003)(8990500004)(33656002)(4326008)(82950400001)(10290500003)(107886003)(6506007)(66446008)(110136005)(316002)(2906002)(83380400001)(52536014)(38100700002)(86362001)(7696005)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ztiSRG8nuVzoYc+nqY2Yu99ngO2oK7yQu5EexYPKU+e5JGK7+Ojw2JedJxbx?=
 =?us-ascii?Q?48JasLhGDiW0wGcJ7H9ZUVSsWGHUVzhRFnolTMP6ZmHyz8phk4p20SZm5Jwf?=
 =?us-ascii?Q?1TQLthPr85QA/SOL/TQ7mqqTaQKwQ05nNg8lXEcmsXNfPoceEQDIRZt6iA0w?=
 =?us-ascii?Q?0INXc8B23f/oaWiTEaZ3wMhC4WXSvOtJCZxiTSGkP4wo8hM3JYxmTF2RJ99t?=
 =?us-ascii?Q?uM2/FkMR5y85896m6EamSpWIA0mm34yinN6HHdFt4nlySThk+gdudp6p9r4v?=
 =?us-ascii?Q?F+cRmDay9dIpiTLifz/9xPcLksAzeSbJiK4qGlmNouI1LDRJ97SDCw7Il50E?=
 =?us-ascii?Q?Ikoyhdsu1MLjPGIVPHiW5cz4CAqtqDK9UU7xBdmC1lYlGORmTJwUReaZmmwP?=
 =?us-ascii?Q?q6ICfA9QFFEFUqaauQtW3IazDxwFA45gqfa58mUUKVXsEgxJOY7LZZWeFEie?=
 =?us-ascii?Q?Mt4t1KRigo9RcHvigx4NRHKefQeaKQrlIxxdVYlo7ho15QJHH225iBLbyK9C?=
 =?us-ascii?Q?QvAVMiPc88lJQysDZDAKxkYyVpfldtPInqW8uBym4mYMaXwMp9UF7j8vGAbj?=
 =?us-ascii?Q?u4ZaHTwaT6xE1F/sxRaX/rUL7WpViiXRSfUSV4Xl3YiXnoe2uX1EtBwQSVt3?=
 =?us-ascii?Q?UstZ7DaNOR64HUeSEXCGt1Ztnjf5U7oPYghdymBskufpTPGH9Pq6Wj6uZo7W?=
 =?us-ascii?Q?DoIasZEXHVHLsA18av1A9U2kyBQosaSjBUTnUXATEubrbet7k/ONPnQFk2eB?=
 =?us-ascii?Q?8hC9AoFhe5khVfk2p1TgNGUhFiCjfBlotRYLkCUES1inO4jyfmr8EcCh0ppy?=
 =?us-ascii?Q?Ar1aWjCSXrjNuiEIgLjGFhFCxLquVdwVML1RCdU/Jr6iY3CC9wpxh8cGWNgV?=
 =?us-ascii?Q?765bJOTR9vPJjo2SbvS4ekjyl07M+fxUGY0eX180v6oZVNp7YqlIByN0HXCc?=
 =?us-ascii?Q?lCVxyhxVZVLxpGmmOq3Avo2PcY+xWeLcptuoG2TqyKT/OjuJW7+h36TVd+2K?=
 =?us-ascii?Q?4/qdKp/T9ZspxB7QzliM6OlABzz3LUH4W9WVhJHeVcTFHejmYLB2l2PnyPkt?=
 =?us-ascii?Q?IWi2mIZBCpP8ElnzCxqycJu6JLMfGt90JjK9ETb4qzPj3l/1kfrci7w16HNZ?=
 =?us-ascii?Q?8cw3w3xxfq5gJ7DcVZxeoHFKZoxFC3jaUQENu/c8WIEUXo+7kc7sCI9joQNd?=
 =?us-ascii?Q?cCY0H6s/lQLfyqE3mNYGLwkkuiOdv4vhkfAFNddC56HLGG2P2Jq4twyNGUVW?=
 =?us-ascii?Q?2uHwyibSXx2yPg26OWZGYAtHjAJ/x2NhmPefQ1KFvY6ElKv+cOfGdZIkFCy0?=
 =?us-ascii?Q?qdoJXlwL3TIFA8TRzcf9VhcS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f06b4c-addd-4207-6a5f-08d9511c8782
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:35:22.2661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpW8Z9ESEMiEo07FWdgqWuA1Zw5RtNpn4AZXgMeTsflWTS1xyMRH0cj6C7VyYau7hzqU8RIVcLQ73RV3rPyrrMvcRdQp1VrCvZCyzIsptgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1972
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Praveen Kumar <kumarpraveen@linux.microsoft.com> Sent: Tuesday, July =
27, 2021 3:41 AM
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
> partition, we need to memremap the memory from hypervisor for root
> kernel to use. The mapping is done in hv_cpu_init during bringup and
> is unmaped in hv_cpu_die during teardown.
>=20
> Signed-off-by: Praveen Kumar <kumarpraveen@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          | 61 +++++++++++++++++++++---------
>  arch/x86/include/asm/hyperv-tlfs.h |  9 +++++
>  2 files changed, 53 insertions(+), 17 deletions(-)
>=20
> changelog:
> v1: initial patch
> v2: commit message changes, removal of HV_MSR_APIC_ACCESS_AVAILABLE
>     check and addition of null check before reading the VP assist MSR
>     for root partition
> v3: added new data structure to handle VP ASSIST MSR page and done
>     handling in hv_cpu_init and hv_cpu_die
>=20
> ---
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f247e7e07eb..b859e42b4943 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -44,6 +44,7 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>=20
>  static int hv_cpu_init(unsigned int cpu)
>  {
> +	union hv_vp_assist_msr_contents msr;
>  	struct hv_vp_assist_page **hvp =3D &hv_vp_assist_page[smp_processor_id(=
)];
>  	int ret;
>=20
> @@ -54,27 +55,41 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>=20
> -	/*
> -	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
> -	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
> -	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
> -	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
> -	 * not be stopped in the case of CPU offlining and the VM will hang.
> -	 */
> -	if (!*hvp) {
> -		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> +	if (hv_root_partition) {
> +		/*
> +		 * For Root partition we get the hypervisor provided VP ASSIST
> +		 * PAGE, instead of allocating a new page.
> +		 */
> +		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +
> +		/* remapping to root partition address space */
> +		if (!*hvp)
> +			*hvp =3D memremap(msr.guest_physical_address <<
> +					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> +					PAGE_SIZE, MEMREMAP_WB);
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
> +
>  	}

The tests here could be reversed to eliminate some duplication.  For exampl=
e:

	if(!*hvp) {
		if (hv_root_partition) {
			rdmsrl(....);
			*hvp =3D memremap( .....);
		} else {
			*hvp =3D __vmalloc(....);
		}
	}


>=20
> -	if (*hvp) {
> -		u64 val;
> +	WARN_ON(!(*hvp));
>=20
> -		val =3D vmalloc_to_pfn(*hvp);
> -		val =3D (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
> +	if (*hvp) {
> +		if (!hv_root_partition)
> +			msr.guest_physical_address =3D vmalloc_to_pfn(*hvp);
>=20
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +		msr.enable =3D 1;
> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);

This version has a substantive difference compared with previous versions
in that the "enable" bit is being set and written back to the MSR even when
running in the root partition.  Is that intentional?

>  	}
> -
>  	return 0;
>  }
>=20
> @@ -170,9 +185,21 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	hv_common_cpu_die(cpu);
>=20
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);

This will set the guest_physical_address in the MSR to zero,
even in the root partition case.  Is that OK?  It seems inconsistent
with hv_cpu_init() where the existing guest_physical_address
in the MSR is carefully preserved for the root partition case.
Or is the intent here simply to clear the "enable" flag?

>=20
> +		if (hv_root_partition) {
> +			/*
> +			 * For Root partition the VP ASSIST page is mapped to
> +			 * hypervisor provided page, and thus, we unmap the
> +			 * page here and nullify it, so that in future we have
> +			 * correct page address mapped in hv_cpu_init
> +			 */
> +			memunmap(hv_vp_assist_page[cpu]);
> +			hv_vp_assist_page[cpu] =3D NULL;
> +		}
> +	}
> +
>  	if (hv_reenlightenment_cb =3D=3D NULL)
>  		return 0;
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index f1366ce609e3..2e4e87046aa7 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -288,6 +288,15 @@ union hv_x64_msr_hypercall_contents {
>  	} __packed;
>  };
>=20
> +union hv_vp_assist_msr_contents {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable:1;
> +		u64 reserved:11;
> +		u64 guest_physical_address:52;

This field really should be named "guest_physical_page", as
it is a page number, not an address.  You've matched the
field names used in hv_x64_msr_hypercall_contents, which
is good for consistency, except that the field name is
wrong in hv_x64_msr_hypercall_contents. :-(   I think
the Hyper-V TLFS originally called it a "physical address", but
the TLFS has since been fixed to described it as a page number.
I'd suggest getting this one named correctly; fixing the field
name in hv_x64_msr_hypercall_contents is a separate cleanup
that doesn't need to be done now.

> +	} __packed;
> +};
> +
>  struct hv_reenlightenment_control {
>  	__u64 vector:8;
>  	__u64 reserved1:8;
> --
> 2.25.1

