Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7043DC82C
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jul 2021 22:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGaUgt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 31 Jul 2021 16:36:49 -0400
Received: from mail-bn8nam12on2112.outbound.protection.outlook.com ([40.107.237.112]:19200
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229560AbhGaUgt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 31 Jul 2021 16:36:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvrKsqHyIL61FVprPJJ95qOShgD17SYNt2j/ZzC2xhh9e2qMUCOXYdjZatjOG4i17XdvMxpEfxqqkooF1WX2pcjNkGVx/fUr/qMp49qeeYAN78EfapUBhnTZRWLW2E4701PSMg61MOzFqemZ8+tmc2eRVujdxdXRtVcCmfZaaZT06/022c2OgXoU6TZH2FkNNjDYp5Yy15PAyLhYAhTKQEgsa5ULOrihLAgrSGzJesqgLWVbSbJ5B3WcCyu0IKMxUIEIW7PHF4sydg2Lf9dARKp3VFebZJmui8gZ8o03jHwDdROjbLUNjCJ+xJpMFPMCSvSisaUnn6N5Wh1XcbYayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bg+cN6Pr7mqG2A2iyBK5CfCs8Rz025x3oH4T3aQvSE=;
 b=JexW2PNx4pShoMArNk1oi4XUOA7c/nawMCUcP8EOuDA3nxJsby8tIwELoGzBwOOpUAaRIinhcw8loQ3dhgcY3zjNLmPCmZBMKlMXj8dRZoDiKNPaCYtGewbwyB8atO7yemk1NuW7KqiJpDSdFaJdy3AJLfc962nLP/RjWkCQr1tPh43tr1kF5k8nxVnbCUi72gYdhMHJf7c+0WV2LF+30YLr26nXxZWEqhUaQnyQATHCB2VKuCxmKH/HxFjoEoVXK1nkdxPPBU5uRb384eGBK6bUMwsorVxmUWcc66lAhfpJTWgo7/oDkWXD5B5IivF8mAsJevBk2brKSsSwhFPtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bg+cN6Pr7mqG2A2iyBK5CfCs8Rz025x3oH4T3aQvSE=;
 b=Fxh4mYiBjcngFlsYREjXvT9/Kluyf2gKbOsdfy56p+aNK2KzP1uoO+1Iuo9zjzjfNWEZOub8zl8bT1vU5jC5fjfgLOsn6yXtUHYM2SQPmHeOdJ0Cyh/3KBQUtuPruQ/ECWKjs80f0g7sXOpI6uzwsdVvEMMk00Sd9iM6UKRX0zg=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0829.namprd21.prod.outlook.com (2603:10b6:300:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.11; Sat, 31 Jul
 2021 20:36:39 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::601a:d59b:f64e:5433%7]) with mapi id 15.20.4415.001; Sat, 31 Jul 2021
 20:36:39 +0000
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
Subject: RE: [PATCH v5] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH v5] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Thread-Index: AQHXhgRi9VkW0Z/FOUWxjTerh/knP6tdiy6Q
Date:   Sat, 31 Jul 2021 20:36:39 +0000
Message-ID: <MW4PR21MB20020E5A5C33831B4FB20AC9C0ED9@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <20210731120519.17154-1-kumarpraveen@linux.microsoft.com>
In-Reply-To: <20210731120519.17154-1-kumarpraveen@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5d13c90-72d8-46bf-62f5-08d95462e618
x-ms-traffictypediagnostic: MWHPR21MB0829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB082946FCBF5B43A7856CCD34C0ED9@MWHPR21MB0829.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIunhBve8RVBvNZGi1Tq/Cw+/Kvi9e3fgN4xRjZTEvq0fyTpMyeS+waDO4Vyi0StvhsB7ZbTz+W0X9cMg6yhvyBle+yi5SMs9MBywOwB+7II1QiwmM+Q7GaOaKygER4adV7tkYDhmBIGrtBL/IOSIDhT+cSob2mxCSBXmraHq3kzP+jw8k8skpi9kdmtKhOZf8Uk0zYRlhlOvEofbrGPcRbtu1eDjU9vXg4dhS1/mrOcq999LDCPwBrpM5b+QV3n3+O2WFSoRzpx+oLYgITt6YRBdg52FwM4BiL2TpYtEVgKMyYP2eevLCAi4wMgvsoru+2rS2xxUyP9v5zVjRKIzfV5ebS5vpY3kmfytSboqLT7lse2EzgDuRyQ5fVC6zKUwu3D+3slLUY7Iemt75sA3C1y+5cOibCJ6/K1jS97rkDiXeecIvsiePp+xEKlDB1zMUvpXo+9Glzi6DN1VWdJruUNYmVhOhjlfRzbsKcDud3JaQSv1X1SvHNXBK6Bh+6jtcASYrWZQ9eVcg8JhKmmgt08vL/tNW9RGBdeHgq2RimuVxbUCYcj4gNQtzNGS5tRRCAM2epkuNZgX+KZ7KHG6b2kjiwEaRt/Jj4kwIVFKKZUltD7ZO+VbyOUCmvjYLQ62qiwPt/evUvAOiMUR/M37VQR+C4nxv6wkp8PdlA9m0XFMid4w0rLuIjddsItQ/MzIYIPgwTkvenAl1LpgR8dEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(4326008)(2906002)(52536014)(8936002)(8990500004)(55016002)(76116006)(110136005)(66946007)(107886003)(66476007)(66446008)(9686003)(38100700002)(10290500003)(316002)(86362001)(83380400001)(71200400001)(122000001)(64756008)(66556008)(82960400001)(6506007)(7696005)(5660300002)(38070700005)(33656002)(82950400001)(8676002)(186003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ShJ4S0xVESVjtZC/y/vyRDq/yKgLjaXZSLiZgGeF6JaIKbHjcmekni++kIE3?=
 =?us-ascii?Q?b3VVJwLYL9Y9dIVybJuIQCmRr96RijB79vazKMNiQArT48LFTRy8By634y8a?=
 =?us-ascii?Q?bMKThw/0ku4Cg/4zViaFIwEnDuCqClUsoF1aMLWYYjZhZANYN1lCGbl2PqVs?=
 =?us-ascii?Q?LjL0l4UN3NLJkrtMiE3stafK0e3DE7zQSdWDzLJY/GMro5Ab+c2MoqhPruQe?=
 =?us-ascii?Q?LcglBn+p1YG1wn4W3nLS50hTloOSNCDDX4HV4OmaDI9PcGGVX1s/ZFv5dI/9?=
 =?us-ascii?Q?xyHg/lui1ezAqV50H6xbbI6dot4+vVvNfxC65LUC/J092i8pZUGqfND8C9xx?=
 =?us-ascii?Q?5mJDNR+IFfrUAxydfBBUxa2N6dX/Dw4409iUvul0LBGnQLK2bBfoomjOTLwf?=
 =?us-ascii?Q?NmTgNjVSxAJ9AeCcR132t1Njn1J+F2QrbXgT07bRHuFzzxqQT5R+IHfP1HcC?=
 =?us-ascii?Q?dXO4f9lOslc2jobAoVlj8w01O/CrMjIB6nOu263MY8ZxODIYoarSmrS6yoz9?=
 =?us-ascii?Q?3gyMqsYGizUsbmrtEYbE5cUfTZDqWbzX60SELjrAG5ZfwY3pTbBXMxh2O6yK?=
 =?us-ascii?Q?LnX/WljHo6SRUvguSfcxQtU+f75T6A2ppKyJx+HOjkK17v9kiTYsqux/4xQO?=
 =?us-ascii?Q?SmDaSgTETCFNcn42TEfwUErCDTt5U6s4gSDNjP8Ws7USK5eT+P8r86jCtI/Y?=
 =?us-ascii?Q?b3S9tVPvvrhwdb0ywvjUgv1uiIFiFT+KUnab82sEJJYnxhoX8vFIOT8qNApk?=
 =?us-ascii?Q?m7sjuPB81SAQMSH1U/sur5ZU4XKWUMKmAtkzsKGknus7hYQiCQaXHWn0aWvZ?=
 =?us-ascii?Q?VZDp00eYaY2AMWlleAWX+SDC1ymwIN2T+m2JZTC2Z+dj92TydsxLcuw2oj6x?=
 =?us-ascii?Q?p3CRFqn/9kmbECwhw3F7YJvWu16AcYbhrlZ9i785rrDba4Fq1XoHerA47aWY?=
 =?us-ascii?Q?uPZqmPaT1Ek2DmH5mJt+J+zZdh7RH7wIk5c5AWh6UBwLDJlFcP7bhUulGCDP?=
 =?us-ascii?Q?qWvibZLYKq5ZBZq46/E1xx1PbVxR15EnmELC1pzjxDYXkw/rlcfVVlxZ/rEA?=
 =?us-ascii?Q?guQbOSPt3518UImV61oOrAVR7B/PawF44cbS5vYOKO7UWf+blLP16gmwT872?=
 =?us-ascii?Q?bbUdZMHDq+aytmfL5UspYP0TVQySGJ+2W5B+vR8dq/o0cYR7GjB43IIbMnPE?=
 =?us-ascii?Q?xZDnF9VRLZSBkTN8XCoQ6YSH6GB8uXEdrgS2GvsRUKz4khaprUj0iMtPTm+r?=
 =?us-ascii?Q?WQhPo9UBMdGQlz+yDU14sfMhTzawSDInWO6NOibv9C0olBNwBojt8nYZysO4?=
 =?us-ascii?Q?q+YVao1FRsJdXTT8ez9De1z5faw4NvrGSytj0BDiTFI22c0llIyXgcRfpOP/?=
 =?us-ascii?Q?io4eFXr95w9MQwD1QddO0ZsuMcrH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d13c90-72d8-46bf-62f5-08d95462e618
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2021 20:36:39.1998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjAEmsouwZe4KaiOYsoa+kanQ5VkSz4JoLp5aSCjJZ8thSO0drwIcS94ULGcLba8BYDf1tMgacGW5FPNVI3GoR1wd9aH8+T285pxkvSycAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0829
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

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
>  arch/x86/hyperv/hv_init.c          | 64 ++++++++++++++++++++----------
>  arch/x86/include/asm/hyperv-tlfs.h |  9 +++++
>  2 files changed, 53 insertions(+), 20 deletions(-)
>=20
> changelog:
> v1: initial patch
> v2: commit message changes, removal of HV_MSR_APIC_ACCESS_AVAILABLE
>     check and addition of null check before reading the VP assist MSR
>     for root partition
> v3: added new data structure to handle VP ASSIST MSR page and done
>     handling in hv_cpu_init and hv_cpu_die
> v4: better code alignment, VP ASSIST handling correction for root
>     partition in hv_cpu_die and renaming of hv_vp_assist_msr_contents
>     attribute
> v5: disable VP ASSIST page for root partition during hv_cpu_die
> ---
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6f247e7e07eb..a46bd92c532a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -44,6 +44,7 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>=20
>  static int hv_cpu_init(unsigned int cpu)
>  {
> +	union hv_vp_assist_msr_contents msr =3D {0};
>  	struct hv_vp_assist_page **hvp =3D &hv_vp_assist_page[smp_processor_id(=
)];
>  	int ret;
>=20
> @@ -54,25 +55,34 @@ static int hv_cpu_init(unsigned int cpu)
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
>  	if (!*hvp) {
> -		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> -	}
> -
> -	if (*hvp) {
> -		u64 val;
> -
> -		val =3D vmalloc_to_pfn(*hvp);
> -		val =3D (val << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) |
> -			HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
> -
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
> +		if (hv_root_partition) {
> +			/*
> +			 * For Root partition we get the hypervisor provided VP ASSIST
> +			 * PAGE, instead of allocating a new page.
> +			 */
> +			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +			*hvp =3D memremap(msr.pfn <<
> +					HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> +					PAGE_SIZE, MEMREMAP_WB);
> +		} else {
> +			/*
> +			 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's
> +			 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> +			 * out to make sure we always write the EOI MSR in
> +			 * hv_apic_eoi_write() *after* theEOI optimization is disabled
> +			 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> +			 * case of CPU offlining and the VM will hang.
> +			 */
> +			*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> +			if (*hvp)
> +				msr.pfn =3D vmalloc_to_pfn(*hvp);
> +		}
> +		WARN_ON(!(*hvp));
> +		if (*hvp) {
> +			msr.enable =3D 1;
> +			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +		}
>  	}
>=20
>  	return 0;
> @@ -170,8 +180,22 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	hv_common_cpu_die(cpu);
>=20
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +		union hv_vp_assist_msr_contents msr =3D {0};
> +		if (hv_root_partition) {
> +			/*
> +			 * For Root partition the VP ASSIST page is mapped to
> +			 * hypervisor provided page, and thus, we unmap the
> +			 * page here and nullify it, so that in future we have
> +			 * correct page address mapped in hv_cpu_init.
> +			 */
> +			memunmap(hv_vp_assist_page[cpu]);
> +			hv_vp_assist_page[cpu] =3D NULL;
> +			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +			msr.enable =3D 0;
> +		}
> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +	}
>=20
>  	if (hv_reenlightenment_cb =3D=3D NULL)
>  		return 0;
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index f1366ce609e3..2322d6bd5883 100644
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
> +		u64 pfn:52;
> +	} __packed;
> +};
> +
>  struct hv_reenlightenment_control {
>  	__u64 vector:8;
>  	__u64 reserved1:8;
> --
> 2.25.1

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
