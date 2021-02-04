Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BB930F8C3
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhBDQ4e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 11:56:34 -0500
Received: from mail-bn8nam08on2112.outbound.protection.outlook.com ([40.107.100.112]:59489
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238211AbhBDQxt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 11:53:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuvhSfa5haN3ralMcXRMUNPTRa2lw+rs3HR2byC9kD196mGlYTlUSSlbwigf9KpwHPTSBLOLs9jqD5JdjM/DM3qqH4QC0tZxrrZGp4aoQeqlaKaPgsaP1AMUZq9Ml/wFKdPFGiVZy2ePEUwK0qfVVFZhxaWIpmp/eXo4BRXA/TOb0RirVwsrODWCpJfrI7hvRBgf7HA75I7rlF30/+cMv4rmdut8WVTUOsUd25M8xT/eyy8l5HqOuO4ZrmwzxR/mBau8Aia6/Aa1ghlO6SEi/LScKFecsK2yhqBWvc72gojGp+u3LxYzHkENXKMkjSQcXxJnzygmkx2O4ivKM7YZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU9gadVnPszQqiMtOvtZNcdp2XJL4+vXL7UAjIiwPG8=;
 b=YPInCzxAEhRkhs69/rkFD74b5AOfnMfaQut9LcCkQDT4aMnZpUCvCJaiSwtZ5UvzA+XkWs5PqpzIW9gN0fLmeoqhnVNCKvhfh4TgbkqpYAp2gQtey9Mhnt/Cm9aagYDQgc/23I1wSCC9wVBOYM3LgWoTSUE9fRBtn6GbcbOjbRpysadHKqbe3Qx12ptacBRMo8yOLEZjoJ+HCLuqKDg3mihLSUvp09upnmvYzms5oJYhHvdadn+ZYUYJLCduWRGXAn/WGSKHqmOOvlpv11eezRS7X69o1OOaBvaqLfWGi3qKhh9y0M73/2AaRbY54c6rbpo0+NfKXZvOe/vkxsgDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU9gadVnPszQqiMtOvtZNcdp2XJL4+vXL7UAjIiwPG8=;
 b=WuMRd7mZrncnVJhOHBtSENGpneRaHnZ2DOC0WKFc8Q3DZxPa7emYAkf30Q8AsHqlqUq1oZNHlqvh9jxBVpOtUc315f53tGmup/FOpcY5zP3cD1Mzy3gaZEFff4VivZhAHpWrGW0n1JFO+gWDFDHxccD6BrWA24hkaccPvINV3MA=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Thu, 4 Feb 2021 16:52:59 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:52:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v6 05/16] x86/hyperv: allocate output arg pages if
 required
Thread-Topic: [PATCH v6 05/16] x86/hyperv: allocate output arg pages if
 required
Thread-Index: AQHW+j3p8GXZuFmxTk+bUjalsOY7l6pIN59g
Date:   Thu, 4 Feb 2021 16:52:59 +0000
Message-ID: <MWHPR21MB1593AF12B03D431705E1297BD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-6-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-6-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:52:57Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=161f2975-92f5-466b-bba5-0a5026db88cc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8e8d55d-8815-4aa6-da2c-08d8c92d5412
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19561B648A36198E9A38BC1DD7B39@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84Jf7HKFOYpwucszRdwo/Wb6VhUTOfG1MIo+gVYjsKRWSA4dTKq11ULo9R3Um8McNyiBjeESjCl5MTUicdzPryzVQ9xRi2VCN6FjiOHWXrQW+eH/wJxux+s5RioQ4lOH+DqWQDzOj17JMV74m6v1oPOtB/HZviI56B9ub6pF2NUEEsis4aBlFVcluMKF6jrIVdtYQ7yjJ18Pn0ySWXOl2YcMrTZeW/9+kTNkNOD9wMSrRvAw4WrfO6FahkyD2YWS/HeEfOUHxPW3OSN15ISPVT0tCYvk/lppfpK1wKdKpy5+WfdT0ZNVdXEpX2c9w8WHghl8wmTKjgQNq8DNa2dTcxxIsBc7DdWiTJ0crdjutj71L26rop+3qoReY/yWs46EI/WL9uOCayg+eoW3tIuVt54OZSuRhpaPbcOY7owMDngtnRYoPoHw52Dl02tuaH9DLMCWciW8/M7FdHOYptAyL4i/r3HaMhKXUBux0H59GAF8/tKk+GV1eXvY9vO62G279s6Sms1tERv0lbKpgmfpTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(66446008)(66946007)(5660300002)(8676002)(110136005)(66476007)(66556008)(26005)(64756008)(7696005)(55016002)(82950400001)(316002)(33656002)(82960400001)(8936002)(478600001)(54906003)(9686003)(186003)(2906002)(10290500003)(8990500004)(4326008)(76116006)(83380400001)(86362001)(52536014)(6506007)(71200400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rROek2bnlO+NnbuPZE5UG8eYSYM3HGtD4i7OAssqbydQda27+uuvQEYtI5iA?=
 =?us-ascii?Q?uHY+wfQ68S2Ed9J0XoV1KhrFgzJg+OReutkeFHkF/xcFteyqbN5QYj/3DtSD?=
 =?us-ascii?Q?hNVOImaqVOwY0Ay6RXkbhxx81FpyOf4go+een3gdEY8Pl2Vw0KTeYCgfdBF6?=
 =?us-ascii?Q?9qdq7rs/mP+3oKVosw7R/h4wb+JrE+/sEph9XVEMxPVw+4u/YagzoDSQcf0G?=
 =?us-ascii?Q?Myi/IPTjwnXrFWm5i9AoFrJdwTFEmfsNWg9Qj1gdSdi6Gf4BKmmNHjmqiDhb?=
 =?us-ascii?Q?0CXSjBYhwVSnmk8RR64XmW9jt9Fd6J/odWXQdj6xkyTg44ln8+1xod9LP5n8?=
 =?us-ascii?Q?H3VsCjUXcKlIdSas3+PatiB3yPJv0TWp2ASKWXDQEHv3Lb+fw9lJb/zfjom2?=
 =?us-ascii?Q?omi1ZxgF+7lDBkRlphe1p+7456+UHt0gn9eKTMhPJdSUfCj8ZfaCWTtCntHT?=
 =?us-ascii?Q?YysbookqMMYfdhtjRK1CNfTHQPByQAMrjRRRRG++Smc1kIX4xxetZsbe4EeR?=
 =?us-ascii?Q?PDAqFW71QS7JoIaP8bHuiWhitPy4Vsu5C9/ZbL+IpPrCW4QTw6YB7FCvMxOT?=
 =?us-ascii?Q?+sQcH9PDMDtMd2Zrvdjbr4CdLT7heoFbKJVHqcsvMCsj4wFjzBSv4hLcd2zl?=
 =?us-ascii?Q?Y4q7zmHQEPaEieSo4fZVu58gjJfNPnX1D3AOZL46fshV4PgB3wMDUwExn16p?=
 =?us-ascii?Q?P81DIKipnVZLU/g6x8279zeeFcHgf/I4YwObhvNLn60b1Gl8GFTlfDMIYA9f?=
 =?us-ascii?Q?PZmU23WnmGNOJAp6qU94uN08UmwR5Xp7Gcqp1PliNGBqnuiNOgp82/sZpVld?=
 =?us-ascii?Q?zl871E7ORJDS3QImaiuLfmpv1iJzkTFkGWrKtpNXxS201v9+7aODFZzzSzQ5?=
 =?us-ascii?Q?lBkwGXu/6vfcPa9JVbA+mg1SyvMyxQ28q5MjOcj2ZR/dkMueLVOYifF2ibQB?=
 =?us-ascii?Q?LPiKXdlH34J0ag1qQNyimCadPhaqX/ng9mNhEapbQkVXjW7aGq6+ydo6pZQx?=
 =?us-ascii?Q?9niO+2Mbk/9Jk05dkhGdpHt1GLi6Jal+n5CnW+WBbCxDcdeMjmvLr9JV4B40?=
 =?us-ascii?Q?a/G1J0pnuo5ufYfhp8IlhkMGSM2o5mLrRFOe2L54gZV6H/mvdlfP609/PVaf?=
 =?us-ascii?Q?qNIMtycqmanZEN2XT9/E6S9f3W5BIcT9XYIfM6Noy8kPxWVn0sYidN2mrE+P?=
 =?us-ascii?Q?8lLgddsUNdRp1sAeiZd/lDc6cWUYONSuzxKhTNq3Y6Z2Cjcs3wMw1aOkTaa9?=
 =?us-ascii?Q?R4BksRvu7kN3ECrK5Fh9DlaUR8FaIRA9nOSvrSrypUwgWKSVa5bPkve9ZEve?=
 =?us-ascii?Q?RaVBbEFJA/O1ZXngnNn1rSy2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e8d55d-8815-4aa6-da2c-08d8c92d5412
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:52:59.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+rZIII8xvSkyRfvihB8qQT/ILi3GYzRYI6f3u+j4HxqPlKRxAcLfFdy5bdWWHqTaYtIlQxZOC+pZ7HhXTv/5KPY6/6TQZY9EUJC3NWiT78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:04 A=
M
>=20
> When Linux runs as the root partition, it will need to make hypercalls
> which return data from the hypervisor.
>=20
> Allocate pages for storing results when Linux runs as the root
> partition.
>=20
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: Fix hv_cpu_die to use free_pages.
> v2: Address Vitaly's comments
> ---
>  arch/x86/hyperv/hv_init.c       | 35 ++++++++++++++++++++++++++++-----
>  arch/x86/include/asm/mshyperv.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27..6f4cb40e53fe 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -41,6 +41,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  void  __percpu **hyperv_pcpu_input_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>=20
> +void  __percpu **hyperv_pcpu_output_arg;
> +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
> +
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>=20
> @@ -73,12 +76,19 @@ static int hv_cpu_init(unsigned int cpu)
>  	void **input_arg;
>  	struct page *pg;
>=20
> -	input_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> -	pg =3D alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> +	pg =3D alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_p=
artition ? 1 : 0);
>  	if (unlikely(!pg))
>  		return -ENOMEM;
> +
> +	input_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	*input_arg =3D page_address(pg);
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg =3D page_address(pg + 1);
> +	}
>=20
>  	hv_get_vp_index(msr_vp_index);
>=20
> @@ -205,14 +215,23 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned int new_cpu;
>  	unsigned long flags;
>  	void **input_arg;
> -	void *input_pg =3D NULL;
> +	void *pg;
>=20
>  	local_irq_save(flags);
>  	input_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	input_pg =3D *input_arg;
> +	pg =3D *input_arg;
>  	*input_arg =3D NULL;
> +
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg =3D (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg =3D NULL;
> +	}
> +
>  	local_irq_restore(flags);
> -	free_page((unsigned long)input_pg);
> +
> +	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
>=20
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -346,6 +365,12 @@ void __init hyperv_init(void)
>=20
>  	BUG_ON(hyperv_pcpu_input_arg =3D=3D NULL);
>=20
> +	/* Allocate the per-CPU state for output arg for root */
> +	if (hv_root_partition) {
> +		hyperv_pcpu_output_arg =3D alloc_percpu(void *);
> +		BUG_ON(hyperv_pcpu_output_arg =3D=3D NULL);
> +	}
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index =3D kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index)=
,
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index ac2b0d110f03..62d9390f1ddf 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -76,6 +76,7 @@ static inline void hv_disable_stimer0_percpu_irq(int ir=
q) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
> +extern void  __percpu  **hyperv_pcpu_output_arg;
>=20
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output=
)
>  {
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

