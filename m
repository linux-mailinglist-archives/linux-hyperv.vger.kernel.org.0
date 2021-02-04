Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2C3100C8
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Feb 2021 00:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBDXgp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 18:36:45 -0500
Received: from mail-dm6nam10on2093.outbound.protection.outlook.com ([40.107.93.93]:20448
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230039AbhBDXgp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 18:36:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR6UUYTOZPdNjq1V8arHB3Q6ZMPsp2jZktaCgXrRR9IAXvhuuHINsygHiBpplGyaxySbqPcG4sWjjgf9bicBRvRTqcACA95FABEZrHW0mrOe9J7s4EEkWx6SEDF1VtDP0tmIJgj6aYbBzceYGnWzfXEOTqSa7wqqgIUfP58a4jv5C68Yg3p8lRxle4i0LowbxNN9JmXF87LfxkxPKVL9BCLZeN2rICJiK+jcBW08IorHiee+4VofVomQNwfRjVE+Twhh71MRk4geEP/Dl8AII1UFuS1HKnTJEz8nWwGJdNJUyitRmqS0yXbBZebY84g5UyNjIZGfAOXeL5g7smfMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN08JaZdk6qCugX1MOsDt4Yphe49Z4293AaZaqJBnZI=;
 b=acqQ9y5tSYy2QEYA49cTCsCCl6mjQv+xymXRUgJ1wSwhP3YPYon6uUSf6Iqjd02o0lveP0nOMAZsRTYD3s8jJgBUv7NxHvDm3cgl585B4njAbXsSLtkzcm4RqIAYJBIoj2Sqq6DFaflDnoUmW6fB3+yy5qTTkrut68MNr0zzuHRGaGB423eWBBl3QlwsO3BRKeZvta8dMziQUxlnRob7KyYxayjBSO21rNlXJjfE3XbYpu12jBGtY1Q5Tt2Y2ZKNomIKJvIJ29L2Ua01IxcABgCcxUMWzi/LXAMLrtncOX9+IYBUd1WxunN3P3rejLkhNSJ7aEQEp8ZFmThS9FA4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN08JaZdk6qCugX1MOsDt4Yphe49Z4293AaZaqJBnZI=;
 b=IsZ99vCgkXgl0m4yrMg/kgajI/2znyvaqB8ROBWBAeBIATqrZ7dUK9r+Vduc3ZjQ3kH34XEwWiXHs+fudpZm+6xdVmZQVasx2iIQa6BEjH8v4oABiLTIik8hWsVvITaQQ0VpZgj2jBtgOgVrMhfjUrisFoF3NoY9wo21zV7kS6E=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB0939.namprd21.prod.outlook.com (2603:10b6:302:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.1; Thu, 4 Feb
 2021 23:35:54 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 23:35:54 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v3] x86/Hyper-V: Support for free page reporting
Thread-Index: Adbkgi7u1VztxegUSBO0uPzYUvP03gWw0bww
Date:   Thu, 4 Feb 2021 23:35:54 +0000
Message-ID: <MWHPR21MB159313CE5C5ACEC4F94D8090D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880CA1C933184498DF1F595C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB0880CA1C933184498DF1F595C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T23:35:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=03e0cf99-fbde-437d-a81b-3887d9699748;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9ea31b4-96c5-43f3-dafd-08d8c9659d88
x-ms-traffictypediagnostic: MW2PR2101MB0939:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0939CF05AB9D21BBE847CB02D7B39@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgHBhSSGfwFExnRJ1O1HkRJHSm0WrxDS+K7y9HFarc4pF2fO71NDB6Hl96JWZUXJ5VjGTSMxnB3tnQQ9wH4AW3bzkzzjrr5hf+ocvpp2JhXLOVK+AeS9zf81tlq8Uavs1hHIsWjlj+8J/de25VNBrYS052dl6URoWd/ChfGh1k8go1FZBR6KcZQDqtpfdPZU5XJ49LETCmW0ozCJTzzcTNZrpUoVNxrqVtgqTR2UkrcUP7D5jomPCWc9BwJkDglc1kOF+9eMAaWBvbq3VB34DVvlebBzIlqQXvPofV4dBX9oYm3Wpyh3dXfQ0D+4TsfMkHXRe+qtS7bjTdVdaSa7ArQxjAc6bjdYRTnTzRtzjhLVbcHTeVY4bs0WSupmOhT7m88wcek34Tm/x7BWwKZwnI9iTqyLSisxTnDjS1YeqYqvplc3tFLppQVdGNhUjsivqAok0SGsx2ywcMrQvhJMD5AgghUOgHqp5SbFaKqz9GGci+RY1s99J8ZtvpcFVZxgertEkS4+dJqMHkqo9HU2XHXH3XMiNsGaF6NDCwI44+fcV611ElHHT0PiNLs3wZj+dVZCH8yJfAMLkyi4XdEYXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(64756008)(9686003)(6506007)(66476007)(52536014)(66446008)(7696005)(82960400001)(8676002)(76116006)(54906003)(4326008)(66556008)(478600001)(110136005)(55016002)(5660300002)(316002)(186003)(10290500003)(8936002)(30864003)(82950400001)(71200400001)(2906002)(8990500004)(33656002)(26005)(66946007)(83380400001)(86362001)(21314003)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5+YZCn9qqV+vnGd/98WLdfsErCYKY+knak8FTCA96ZtGhqqj5V2hyHyzcF5e?=
 =?us-ascii?Q?DrkdZbRF6UA7GN64PKpDddcWn04yTU8DfOEKQ6+YmvrGTnjU0/WTxHHTldDm?=
 =?us-ascii?Q?FpXo1HRP9PV8HGFgjb1+QtYs2mCmZVPTX9NqA4REAFAU6chshezk5m9+CaGx?=
 =?us-ascii?Q?ZQgweupahbLqcw2s2znN12fdVz14m/BB8L24h98KSterQW5h4n4qsiWCjWx0?=
 =?us-ascii?Q?8DTTozUt+2WD65tSYNK/jZY1bmHx/2G0DOrMe3cn7qcsPpXZD3+kyAuDWV1c?=
 =?us-ascii?Q?IB67/dDznIeUzypjmNfTPng3XXiDDlwkGwJY28udxKyKcMipfMyLQsVsKoZV?=
 =?us-ascii?Q?lAIPTLCCBe3TkPaLE8kyPMAIjIw3sXBDRVwfdFBDoa4xAm7blcrsJRDP2e3N?=
 =?us-ascii?Q?D0EIaEXQufVxEej50PjRphDkivepAw0+4kgQBApJsPX0a88wCo5ERvXTeyWI?=
 =?us-ascii?Q?w+Z3AL0GOg95kfy+QGdgUUfMu9i31f6ghwQuFOpantRCl4VWvsrcfd0wHXGK?=
 =?us-ascii?Q?V2gQnCUhu7T2mCtYksYLXuoUB8tNGQn61CTcwGPZVoAw+HkD4XsJjfZ9JUuA?=
 =?us-ascii?Q?s8CDj7+1xY1bNUOm0nryCdJaDxwX615mlSMw2TNsG1R3WautfJyLIsb/5kuf?=
 =?us-ascii?Q?w3sN/edqLaN1Uq0NOwpOdkylBj2O9aXsOMXwwWQErRKKASdAURdBCVAH425f?=
 =?us-ascii?Q?/detYfgYmCXsNB4ZXUqf3Ply3OmllRTjbRW5gZ17UeGXzNGaTpDZfXj7Q+qO?=
 =?us-ascii?Q?7amxaolIiXfVaqfoquC3vN/W42/Bb2H1CEqx4U/ze5UkTf2c/1s4ahfbbjU+?=
 =?us-ascii?Q?CLpLhgwn8odK3gHiQ8yCLnvRf8iNdgZKI2rQjkE4vGsZyPc3zRf/FcnofVLg?=
 =?us-ascii?Q?mQqUEGzVeabR49yv3Fs628at0Ho2QPadggOy4innCaW90XLh7epZFLY7OKVL?=
 =?us-ascii?Q?4jt1ik90J9OpU9cxPWSbrtK1uSv17z6bvAlXDFSf8UURPHQzLaF0pjWFNrJH?=
 =?us-ascii?Q?R3DZBXd9k22oGiSeusvCe5e7vLwrh2yPvCGNhoe4vdA4TXiBOqCbVr96uLvY?=
 =?us-ascii?Q?dDMdMC1LEO0O2+nLR5uc+iX96iwbdyqwauXMJ0JpR3KPaZDKWyvPFwj4QCaA?=
 =?us-ascii?Q?P7GV5OpJOVGEc3RG3J8u+WSuPPysB0fnuKAnpeBZlkRud/O9FdzGvOPRCbNX?=
 =?us-ascii?Q?WRrAzQYgccij+t0xuSTpoR7XPfeXekZHknXC4uAbfV9/VxvZNq2oyJ7pEZn/?=
 =?us-ascii?Q?CrH10/TOvnWHi12bcHVUnQRsQYcNOVcjPur5n5HJytEj8C1298G6jg6szMLn?=
 =?us-ascii?Q?2EyEjVlRl215n6yAB1sP8HV4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ea31b4-96c5-43f3-dafd-08d8c9659d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 23:35:54.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsqxx5pRv4P2InhAuacKioSOs+65/MWhyz0Z+8QOMEqdotLlvNksTpLKBs0F10AR4wPZg1GI5NUi+ALHbeQMtOzjt+XN1uC2p9+yOXNdPzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Wednesday, January 6,=
 2021 3:21 PM
>=20
> Linux has support for free page reporting now (36e66c554b5c) for
> virtualized environment. On Hyper-V when virtually backed VMs are
> configured, Hyper-V will advertise cold memory discard capability,
> when supported. This patch adds the support to hook into the free
> page reporting infrastructure and leverage the Hyper-V cold memory
> discard hint hypercall to report/free these pages back to the host.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Tested-by: Matheus Castello <matheus@castello.eng.br>
> ---
> In V2:
> - Addressed feedback comments
> - Added page reporting config option tied to hyper-v balloon config
>=20
> In V3:
> - Addressed feedback from Vitaly
> ---
>  arch/x86/hyperv/hv_init.c         | 31 +++++++++++
>  arch/x86/kernel/cpu/mshyperv.c    |  6 +-
>  drivers/hv/Kconfig                |  1 +
>  drivers/hv/hv_balloon.c           | 93 +++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h | 32 ++++++++++-
>  include/asm-generic/mshyperv.h    |  2 +
>  6 files changed, 162 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27..5b610e47d091 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -528,3 +528,34 @@ bool hv_is_hibernation_supported(void)
>  	return acpi_sleep_state_supported(ACPI_STATE_S4);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> +
> +/* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_x=
xx */
> +bool hv_query_ext_cap(u64 cap_query)
> +{
> +	u64 *cap;
> +	unsigned long flags;
> +	u64 ext_cap =3D 0;
> +
> +	/*
> +	 * Querying extended capabilities is an extended hypercall. Check if th=
e
> +	 * partition supports extended hypercall, first.
> +	 */
> +	if (!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
> +		return 0;

Return 'false' since the function is declared as bool?

> +
> +	/*
> +	 * Repurpose the input page arg to accept output from Hyper-V for
> +	 * now because this is the only call that needs output from the
> +	 * hypervisor. It should be fixed properly by introducing an
> +	 * output arg once we have more places that require output.
> +	 */
> +	local_irq_save(flags);
> +	cap =3D *(u64 **)this_cpu_ptr(hyperv_pcpu_input_arg);
> +	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) =3D=3D
> +	    HV_STATUS_SUCCESS)

Need to mask before checking for HV_STATUS_SUCCESS.  With regard to the
reserved fields in the returned 64 bit status, the TLFS says "Callers shoul=
d ignore the
value in these bits".  There's no promise that they are zero.

> +		ext_cap =3D *cap;
> +
> +	local_irq_restore(flags);
> +	return ext_cap & cap_query;
> +}

As I noted in a review comment back in May, the output arg here is
only 64 bits in size and could just live on the stack with assurance that
it won't cross a page boundary.  So the code could be:

bool hv_query_ext_cap(u64 cap_query)
{
	u64	cap;
	u64	status;

	if(!(ms_hyperv.priv_high & HV_ENABLE_EXTENDED_HYPERCALLS))
		return false;

	status =3D hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, &cap);
	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS)
		cap =3D 0;

	return extcap & cap;
}

But if you think there's value in using the designated page for hypercall a=
rgs,
I'm OK with just fixing the testing of the status.

> +EXPORT_SYMBOL_GPL(hv_query_ext_cap);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 05ef1f4550cb..f4c0d69c61ae 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -225,11 +225,13 @@ static void __init ms_hyperv_init_platform(void)
>  	 * Extract the features and hints
>  	 */
>  	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.priv_high =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>=20
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +	pr_info("Hyper-V: privilege flags low:0x%x, high:0x%x, hints:0x%x, misc=
:0x%x\n",

Nit.  Could we just use a space instead of a colon before each of the print=
ed hex values?

> +		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> +		ms_hyperv.misc_features);
>=20
>  	ms_hyperv.max_vp_index =3D cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>  	ms_hyperv.max_lp_index =3D cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 79e5356a737a..66c794d92391 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -23,6 +23,7 @@ config HYPERV_UTILS
>  config HYPERV_BALLOON
>  	tristate "Microsoft Hyper-V Balloon driver"
>  	depends on HYPERV
> +	select PAGE_REPORTING

With this selection made, are the #ifdef CONFIG_PAGE_REPORTING occurrences
below really needed?  I looked at the virtio balloon driver, which is also =
does
"select PAGE_REPORTING", and it does not have any #ifdef's.

>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 8c471823a5af..c0ff0a48f540 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -21,6 +21,7 @@
>  #include <linux/memory.h>
>  #include <linux/notifier.h>
>  #include <linux/percpu_counter.h>
> +#include <linux/page_reporting.h>
>=20
>  #include <linux/hyperv.h>
>  #include <asm/hyperv-tlfs.h>
> @@ -563,6 +564,10 @@ struct hv_dynmem_device {
>  	 * The negotiated version agreed by host.
>  	 */
>  	__u32 version;
> +
> +#ifdef CONFIG_PAGE_REPORTING
> +	struct page_reporting_dev_info pr_dev_info;
> +#endif
>  };
>=20
>  static struct hv_dynmem_device dm_device;
> @@ -1568,6 +1573,84 @@ static void balloon_onchannelcallback(void *contex=
t)
>=20
>  }
>=20
> +#ifdef CONFIG_PAGE_REPORTING
> +/* Hyper-V only supports reporting 2MB pages or higher */

I'm guessing the above is the same on ARM64 where the guest is using 16K
or 64K page size, because Hyper-V always uses 4K pages and expects all gues=
t
communication to be in units of 4K pages.

> +#define HV_MIN_PAGE_REPORTING_ORDER	9
> +#define HV_MIN_PAGE_REPORTING_LEN (HV_HYP_PAGE_SIZE << HV_MIN_PAGE_REPOR=
TING_ORDER)
> +static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_in=
fo,
> +		    struct scatterlist *sgl, unsigned int nents)
> +{
> +	unsigned long flags;
> +	struct hv_memory_hint *hint;
> +	int i;
> +	u64 status;
> +	struct scatterlist *sg;
> +
> +	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
> +	local_irq_save(flags);
> +	hint =3D *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg)=
;
> +	if (!hint) {
> +		local_irq_restore(flags);
> +		return -ENOSPC;
> +	}
> +
> +	hint->type =3D HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
> +	hint->reserved =3D 0;
> +	for_each_sg(sgl, sg, nents, i) {
> +		union hv_gpa_page_range *range;
> +
> +		range =3D &hint->ranges[i];
> +		range->address_space =3D 0;
> +		/* page reportting only reports 2MB pages or higher */
> +		range->page.largepage =3D 1;
> +		range->page.additional_pages =3D
> +			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;

Perhaps verify that sg->length is at least 2 Meg? (similar to verifying tha=
t nents
isn't too big).  If it isn't at least 2 Meg, then additional_pages will get=
 set to -1,
and I suspect weird things will happen.

I was also thinking about whether sg->length could be big enough to overflo=
w
the additional_pages field.  sg->length is an unsigned int, so I don't thin=
k so.

> +		range->base_large_pfn =3D
> +			page_to_pfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;

page_to_pfn() will do the wrong thing on ARM64 with 16K or 64K pages.
Use page_to_hvpfn() instead.

> +	}
> +
> +	status =3D hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
> +				     hint, NULL);
> +	local_irq_restore(flags);
> +	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS) {
> +		pr_err("Cold memory discard hypercall failed with status %llx\n",
> +			status);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void enable_page_reporting(void)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(pageblock_order < HV_MIN_PAGE_REPORTING_ORDER);

The BUILD_BUG_ON won't work in the case where pageblock_order is
actually a variable rather than a constant, though that's currently only ia=
64 and
powerpc, which we don't directly care about.  Nonetheless, this would break=
 if
pageblock_order were to become a variable.

> +	if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
> +		pr_debug("Cold memory discard hint not supported by Hyper-V\n");
> +		return;
> +	}
> +
> +	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MEMORY_HINT_MAX_GPA_PAGE_RANG=
ES);
> +	dm_device.pr_dev_info.report =3D hv_free_page_report;
> +	ret =3D page_reporting_register(&dm_device.pr_dev_info);
> +	if (ret < 0) {
> +		dm_device.pr_dev_info.report =3D NULL;
> +		pr_err("Failed to enable cold memory discard: %d\n", ret);
> +	} else {
> +		pr_info("Cold memory discard hint enabled\n");
> +	}

Should the above two messages be prefixed with "Hyper-V: "?

> +}
> +
> +static void disable_page_reporting(void)
> +{
> +	if (dm_device.pr_dev_info.report) {
> +		page_reporting_unregister(&dm_device.pr_dev_info);
> +		dm_device.pr_dev_info.report =3D NULL;
> +	}
> +}
> +#endif /* CONFIG_PAGE_REPORTING */
> +
>  static int balloon_connect_vsp(struct hv_device *dev)
>  {
>  	struct dm_version_request version_req;
> @@ -1713,6 +1796,10 @@ static int balloon_probe(struct hv_device *dev,
>  	if (ret !=3D 0)
>  		return ret;
>=20
> +#ifdef CONFIG_PAGE_REPORTING
> +	enable_page_reporting();
> +#endif
> +
>  	dm_device.state =3D DM_INITIALIZED;
>=20
>  	dm_device.thread =3D
> @@ -1731,6 +1818,9 @@ static int balloon_probe(struct hv_device *dev,
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> +#endif
> +#ifdef CONFIG_PAGE_REPORTING
> +	disable_page_reporting();
>  #endif

Nit:  Typically the error path undoes things in the reverse order. So
the disable_page_reporting() would occur before the call to
vmbus_close().

>  	return ret;
>  }
> @@ -1753,6 +1843,9 @@ static int balloon_remove(struct hv_device *dev)
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> +#endif
> +#ifdef CONFIG_PAGE_REPORTING
> +	disable_page_reporting();
>  #endif

Same here regarding the ordering.

>  	spin_lock_irqsave(&dm_device.ha_lock, flags);
>  	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index e73a11850055..75c20be2cc44 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -89,6 +89,7 @@
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
>  #define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
>=20
>=20
>  /*
> @@ -152,11 +153,18 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>=20
> +/* Extended hypercalls */
> +#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
> +#define HV_EXT_CALL_MEMORY_HEAT_HINT		0x8003
> +
>  #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
>  #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
>  #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
>  #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
>=20
> +/* Extended capability bits */
> +#define HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT BIT(8)
> +
>  enum HV_GENERIC_SET_FORMAT {
>  	HV_GENERIC_SET_SPARSE_4K,
>  	HV_GENERIC_SET_ALL,
> @@ -367,7 +375,7 @@ struct hv_guest_mapping_flush {
>   */
>  #define HV_MAX_FLUSH_PAGES (2048)
>=20
> -/* HvFlushGuestPhysicalAddressList hypercall */
> +/* HvFlushGuestPhysicalAddressList, HvExtCallMemoryHeatHint hypercall */
>  union hv_gpa_page_range {
>  	u64 address_space;
>  	struct {
> @@ -375,6 +383,12 @@ union hv_gpa_page_range {
>  		u64 largepage:1;
>  		u64 basepfn:52;
>  	} page;
> +	struct {
> +		u64 reserved:12;
> +		u64 page_size:1;
> +		u64 reserved1:8;
> +		u64 base_large_pfn:43;
> +	};
>  };
>=20
>  /*
> @@ -494,4 +508,20 @@ struct hv_set_vp_registers_input {
>  	} element[];
>  } __packed;
>=20
> +/*
> + * The whole argument should fit in a page to be able to pass to the hyp=
ervisor
> + * in one hypercall.
> + */
> +#define HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES  \
> +	((PAGE_SIZE - sizeof(struct hv_memory_hint)) / \

Use HV_HYP_PAGE_SIZE instead of PAGE_SIZE.

> +		sizeof(union hv_gpa_page_range))
> +
> +/* HvExtCallMemoryHeatHint hypercall */
> +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> +struct hv_memory_hint {
> +	u64 type:2;
> +	u64 reserved:62;
> +	union hv_gpa_page_range ranges[];
> +} __packed;
> +
>  #endif
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index c57799684170..93c1303f5e00 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -27,6 +27,7 @@
>=20
>  struct ms_hyperv_info {
>  	u32 features;
> +	u32 priv_high;
>  	u32 misc_features;
>  	u32 hints;
>  	u32 nested_features;
> @@ -170,6 +171,7 @@ void hyperv_report_panic_msg(phys_addr_t pa, size_t s=
ize);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
>  void hyperv_cleanup(void);
> +bool hv_query_ext_cap(u64 cap_query);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }
> --
> 2.17.1

