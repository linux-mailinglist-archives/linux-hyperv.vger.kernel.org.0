Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5653D7B4F
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhG0Qp2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 12:45:28 -0400
Received: from mail-dm6nam12on2110.outbound.protection.outlook.com ([40.107.243.110]:63585
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229532AbhG0Qp1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 12:45:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtgUfTsnRHlQus1hx8IpxgvmSoM9DfjcSXJsYa62TKEMo6ZGUZAwNjPZwmM3a/eV5m23fzcOWmJ74qsJw/DQR3iX31/DTIeMNnIjxC7cEbq4NoRCgBu9dBobOFfrY0gDR7ccgGHNllEHB4SF33v6lTWc6r7F8R4py9OTvhx56Ysl1NjL8J5FwUW1R3HJY1OD84/FG65dLHpn6j3LxQhfBIZwhXaDkPanEkFUqVirLbx1h+ARfYznkNqpX6e3fD6kB0xF3q0gdUcZ+FXtmnugmYhzVP903l3D2kKvGuSmgBa5yJTqo/cO8t3kEAG+P76Tgzd1HoHNdNJ4SwEHJ207HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7BnGrLhxGisa7dA8rFP26Z5uvsXDEWtNLjd+6r+pX0=;
 b=avHzAPuldzZvYr3hQp/4k7RstFFRUUHvyigyC7VH40NgYNf3q8WHmVPq4l76vkFJ3VppzdTYTY861E2i09aHFHKG9p/ICBZ0OvKZBkMgGnWvC1jQLhmNaCilNEt9O2+RgA2ELaMMh7nTUoE8ZNMYO7yzgF+2xyb7AkQ08SW/da/EG2J1HShha0ASbUMiIjO0NDBAm3RR08mQLdd4pTRayz1v/+N1Erk3S7fPyy244aT8EjeQKWr6T6yyfS+A7uJnh9Lf3x0rf4k22oMC9foFZVC7DZx0ousPHR6M7EDyFlredoLc1dBRSl8D0M3RPyXuVShR5THpRPPYltHPXEJ/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7BnGrLhxGisa7dA8rFP26Z5uvsXDEWtNLjd+6r+pX0=;
 b=M6eot1/BtAEIoubWosM+DN2qRADAZCfwOfkSESxZbB5L45gd0J8/vDF4eHkErEerut0utWfizITX+/6EL3NaiuDSfSi4OtZbFQCZzPP/DHcHiFyzP1jMnkMj77tJbkem50snM8pCakYDOBMN2B8FoWea2F6peASSUhe/nFzrfSc=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW4PR21MB1940.namprd21.prod.outlook.com (2603:10b6:303:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2; Tue, 27 Jul
 2021 16:45:25 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51%4]) with mapi id 15.20.4394.005; Tue, 27 Jul 2021
 16:45:24 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
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
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH v3] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH v3] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Thread-Index: AQHXgtPz/n7CxiZ6zUi9GbDbsi36lqtW+2kQ
Date:   Tue, 27 Jul 2021 16:45:24 +0000
Message-ID: <MW4PR21MB20021A51BE9960E10C08FE6FC0E99@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
In-Reply-To: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fb21c1d-ec57-41d1-2ecf-08d9511deeae
x-ms-traffictypediagnostic: MW4PR21MB1940:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1940E7817C1A5E3A9A3269C4C0E99@MW4PR21MB1940.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXWngEjGRFHsmlL0mpJHakD4jgyolLGWKWhtsiByyZtE6Y2q8pI6sTmKrtDq7no0uw9BuYPAiK7jGrW9F+qBFVppCfzD3IbX5VpocrH0L3XRlbv+b+aNRDbjtMIgQ8dfRpnaGmjXH2lT0iPmcPa8lVmcaESblYeHj8QItTKH2LhEzgO3QDX4Xh7rF7JbcRylAEJtkeBFuTBL1ycpvGer+SrfPpS9C/NtE2S2OD3YD8ZEVd/+ywHNjsOzXyOeCjeU57nU8eHXFFwnbu070/Ymtovq1UH9i7EmX3mIgHdNOxEuYFM9/G9AnZXbif7ZpjUQbVQUpERzwQ1KrFDFyO2dkeKefrvJ+4suYVm525obB2ZBeMZ/09cosNxuo+vdyzKdKmtdhMLbCrVCEqQ2LdJFwphxbe823bgiaUPOI5WMmq5DUWAK61hC1WyVJ3z6os/4Ol9YYRmGsThANmT5aopuYwcRZLYCoS3gUqGHRUTZv3LuZCBW4QDEQJiZ8sb0zQbjuezFcfBM2fKGRHYd8uNstjrIlRZ3n6WdCvm78P/ZHKVUvLMr+7jkM0whgBGFpVDsCpUMJfRvSWZDx+UTsz5YtWWbwEgk2s+q2hA0D844JPNrC1eZ1HWpLulplF6RIOUpEsqvBqHXnBlPbyCA0HvOHMZPBmHzxm24sUuUY1q4zpowxafdYajL+w+6HP51T+VrRKDgAIg1RCpUPn4OyoD9qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(82960400001)(64756008)(66446008)(8936002)(38100700002)(76116006)(71200400001)(2906002)(86362001)(66556008)(508600001)(107886003)(186003)(110136005)(8676002)(82950400001)(8990500004)(6506007)(83380400001)(5660300002)(52536014)(7696005)(9686003)(122000001)(33656002)(55016002)(66476007)(4326008)(316002)(10290500003)(66946007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BTPdrkGE+Bau/5P4lkXCe/Tlzv0qv8Xmwfqh109btMr+TQCAS8KYkZvcrva8?=
 =?us-ascii?Q?UdezZsBfDIqqkFnzrXtCBXqqLx03tslixlMfVYyULEVVtcri34oIABaK2FG+?=
 =?us-ascii?Q?ytyFRCV2Gngmg2weUEDcc8tg5jBNeL9OLuZTQRIKX0gc+78qQnayVUKMpb/1?=
 =?us-ascii?Q?e7/tSqRDI8WZ6LcdwrQJgW+7GBUP9D2ZjD+QLGdcu/E1PC0MwP+AdecizD/w?=
 =?us-ascii?Q?xtLfDn2EgdFXOaPPRBJG8kr895SX1iVbP+UOX46x4pms4rucLMZuvD4VPfg+?=
 =?us-ascii?Q?OxPWmfsIbJlrNlzL4L0CQ52X984w4exO8BTg2Sf2JNjS+6OM2A7xHL6w3mSr?=
 =?us-ascii?Q?SUasr0mGIySr1anSEqiT8r92XbaLgSrTHmF9GDQVqsdPqrOrc7AhZzSX4Flv?=
 =?us-ascii?Q?dcw1vFmO++KjmV+fvVJEGHvjQmyS+7aXHDddHbNbSVsv6z8TTABsJzkiGfxd?=
 =?us-ascii?Q?CUpEjm/kyLw1qYpyi+SqAh9ujnO2UkCkz5maB2p7Q3gIWZjMemjS2t+b+jlY?=
 =?us-ascii?Q?g7/xJpsu7tbxPxB7MvGVK1T1QKINyEzz6JMnw7TCx2/NqAcH5rmKczVlCFbC?=
 =?us-ascii?Q?Grp2qfHtDScvXZvwJ2rIKDUJy9gF0AVlFaCyPyI/Ipp3T/u63YrL/E5HI1Wn?=
 =?us-ascii?Q?Xy59g4tCXEdLJTQlNd+OU2nlIpJnVXa6a9Rnapvgcej9yhr+tfAivhNFsrMF?=
 =?us-ascii?Q?e54yvmMMe3z5HXiGBJnColaUjwbpghMkFtwbqsTC5HV+D9LXDcbuyrhPB6+c?=
 =?us-ascii?Q?56zobORVj+fAuKamkZY+0SPPT/wD1PoMQroR2FksWyxycWT5JMvbSOhVS/s2?=
 =?us-ascii?Q?bO2e8VqKo4tpKgfHY8+TUIpFoU/N0NLAFaqRaiOHHnVWuw7Y79ZDs3psv44q?=
 =?us-ascii?Q?pPIaf9peCnLbSs/QpcrAMV14JZw8ok07TOvr09phx1C2WxoGY6WFgGuWQlAm?=
 =?us-ascii?Q?kyl3msYDkv/yTZule83G3LENV5QqRxa20nvOtxSOFj/xVM4ZM5U/bnW7Bw7/?=
 =?us-ascii?Q?YNpWqmV9roAP/AEss5MVuNuLS2aYvin/vmazsainaIDV4uDKcoPbiBLMDLwC?=
 =?us-ascii?Q?LhOQ+6RhOdSUyhTrcm5oKEPKV5SheLPCt6kEVbi1fRboKFXUt55ympyL5F4i?=
 =?us-ascii?Q?DtP2WLSYnawJcLd3TB8tCjsPkqAHdXTEIOQXiLEzXVpH92+4zxpaJSSy0+0P?=
 =?us-ascii?Q?okyzrh80p5VMFz6A8zxl+tNin9bcOeL9ss09z/ZWYhArU+mm5dNapjvJOT/k?=
 =?us-ascii?Q?UF8T+9lMzAO2E/F3WkIDff93HR9cbHQZdJFOwJ6tj+zCGWrNcra+lAvmUjpO?=
 =?us-ascii?Q?ntCNmDRCS1HuZRDNXbvaHzowkGhDbtnQt0MiUdmPTMQ8ki2wc0UoUARpH8W4?=
 =?us-ascii?Q?uHNy0ZgzuNSLXyTiUg6gTO0dzqLf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb21c1d-ec57-41d1-2ecf-08d9511deeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:45:24.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAK3jAcF5uvrlDRLy02rzQ3E6q6SaVSovgJ1J+3s4vWLK0DSxawSa7U0pn1NejlG5cRdP+Wl1m4DsN+ccrLiS+fuspF1HcyoqePmGtO3KGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1940
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Praveen Kumar <kumarpraveen@linux.microsoft.com> Sent: Tuesday, July =
27, 2021 3:41 AM
>
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

Not related to this code, but I am not sure about the usefulness of this NU=
LL check as
we have already accessed this pointer above. If it was NULL, things would a=
lready
blow up.

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

Better to leave out comments that are obvious from the code.

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

It's better to move this above in the else section where we are 'vmalloc' t=
he page.
If you just check for the NULL for the page above and return if NULL, that =
should
clean up the code as well.

>=20
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +		msr.enable =3D 1;

We should also set the reserved bits to 0.

> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
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

Its better to read the MSR, set the enable bit to 0 and write it back.

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

For the guest case, where are we freeing the page?

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


This field contains the page frame number and not the physical address. It =
is also
better to drop the phrase 'guest' from the name as this applies to root as =
well.

- Sunil
