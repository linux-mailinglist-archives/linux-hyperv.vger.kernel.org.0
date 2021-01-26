Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C3303165
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 02:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbhAZBmy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jan 2021 20:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbhAZBer (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 20:34:47 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20702.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::702])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D023C0698CC;
        Mon, 25 Jan 2021 17:21:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrXAFv09KZLS6+tMX5WRGKqqeY6Zfx0F/lBmPBrj0g+NgAGRUTG33Oa2BsQSo7iM8b2w38/ozvyQ3QIg5r96RIBbTCoW86FFW+WmTCyHYocrCoikDtm2LKoKuLx458pN6FIWiN76hmJ0oYGPdlgKHd6onzxpyt9CHj30MslXWJ+q1VO4fjfdAGXqkPiTy3XhyOi7BMRULkpjckKpu3iV8CdeMVyufRI/QsqbNxu8760hVKcinfZa5+Eh18eioCCTpBqGw5ZJUNt3VvPC8v0l0b/pi9mY1oM5wl+evDpRJT9l1MVLFN0eV6XV8WDKdCVc61GTe4/5fkcgRk5L+ZpdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPzgVaOwCGeNDgoqp1nDc20TcW78pTcwMsQO3SGfMSM=;
 b=eKFcnCKdZHu2WRlNoKGdJRNfvIW8TCifxKnK9r/E3KbSqCnrwJ9SSPpuTh/bIEXW4Qf92m0J3AbCzq+X0eyj7ie6xO/O+TQs0I/aLjDbcuNpR+RTJGwNd2/R0gkz86Ptas+FDfEoqknAQhZbDvdtBxA5BDkOpb00GEEnCoK89zgHCSTr50jWCf8tEkwJkwKwCo5sXUugmqQyS90JgcuFtzlXUziC3aJ5CuhhVwpSWr+x+nPqb2pV8Kprk2rIcZU1SQdnn/uTK9hiI7rhuWCxRwL6GLchQmAbZInuubLEcezbdWyidESy2QIp+03HYzhajzmJMRkficJmywzeVUW/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPzgVaOwCGeNDgoqp1nDc20TcW78pTcwMsQO3SGfMSM=;
 b=FRUCdsfKCjQcljmnvxH2njUVhB4PWT/ISj7i13DpbgnGccw2d9XcJCHd9Y90o4CEnqvcBJK0fQpn5yujqKjlSowHtX6dzITyMbjhJC+6nnWhR/zDUf8oOxl3jhyZskAhRushN1rZ3gDXLMCezhGoxVx6OHbrvkvFV5nOWYFZBvk=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Tue, 26 Jan
 2021 01:21:14 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 01:21:14 +0000
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
Subject: RE: [PATCH v5 10/16] x86/hyperv: implement and use
 hv_smp_prepare_cpus
Thread-Topic: [PATCH v5 10/16] x86/hyperv: implement and use
 hv_smp_prepare_cpus
Thread-Index: AQHW7yP27+zNdKWlU02NgaE0dmDREqo5JKOw
Date:   Tue, 26 Jan 2021 01:21:14 +0000
Message-ID: <MWHPR21MB159345C90D79F300DA05C588D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-11-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-11-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T01:21:12Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3b94c419-7738-4b95-91c9-ea76089aaef7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d81e41d5-9eb6-474c-b12a-08d8c198ac44
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB08737C1F3F8F86A9729E4B09D7BC9@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smjODyt3LtXSunW6KCooZpgHV6GAypoXTK0F2b4SgIvlbYA1DFcP17toBybMgyEpq2ueqaVVfS9SmC9GqYvDsmTISwXnaJjr8wgkrf75DnjRnERxPuQpbueS3N3+M+PPi/OMXv4NVWuiGmMTC0kRqSY8lTUwdCDoVvxXZayjKNMkO3KcU4J+kVemwmVTM5qhyD/fZT45HWf6O29ekD2+E9nAl9QJ/Rdm7i6a8cRoEXuR740RqaqpMlQ6TQYNFFOYQ4RFOj+mvVW28IJqPAb9JYxNTQMSVhQUwdzjgDKALhRFmI4xmleHwNLgbEtdaGc7DRjxFvSBMs699kPpRRqcfa1HUQ814NRg7s+RcX0lBhuvK3GY1uy54rtKJQqwxAfCVgWzRzv31cptTuSsy5Ssm8n/ijiebytF1Zli0GZVL/szAvpKN+4C/29FmmHX16qrw1Jm9e9c/01nRNpFMVJFA9xUHm8EkXB6eoiKNttRK5pWIg/Z2bHTVaQK5aSKMQiegOiqeISvn2pEvlMOQglcQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(478600001)(52536014)(66446008)(71200400001)(55016002)(8936002)(7416002)(54906003)(4326008)(66946007)(76116006)(64756008)(110136005)(83380400001)(9686003)(66476007)(66556008)(86362001)(7696005)(6506007)(8990500004)(82960400001)(82950400001)(33656002)(8676002)(26005)(186003)(316002)(10290500003)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oJJFEM0XJhtL/oA8Db6TNZgU3LP+vxAXIToaCTBFowdo8lcFTxjTqdiO+Jym?=
 =?us-ascii?Q?AdPcLfitshHjl1zHByjU5QP5hrNrfWyei/PTQ+6+YtN2X4kXVf0XbUKNaUIn?=
 =?us-ascii?Q?Vht4UlF+88pfhGuY1w/t5Huf64UvgRcgJMwjJiAvCsDxM/eqN1+RADGtz95d?=
 =?us-ascii?Q?+obIFdeyniP7gfjh1nN4FfkOSsiPpyiUaj2u+PrXqAwwMAaw522nYGzO7hR+?=
 =?us-ascii?Q?EKT0CyoY4ZLpftM2nhVHmx2y0dUCs1rneM4A9cy/Sz2NMOLqA9pfwhtEbld0?=
 =?us-ascii?Q?F4W9s+fiEaenINvo7hFYRLWVUtJ/tDEqXXK6GO4lPpyGKB2VYo5lya8o1NPa?=
 =?us-ascii?Q?xlbdTH1Dl42S0aOvqTOI+psQti52FWGGHYWD7T1Ayt/AbbQcRSiG+BFNUDX5?=
 =?us-ascii?Q?8Qo22DJdvVkBM5DpNT6za3Voq23y1I2RoIjwXfUBs7MPjrmZPHFJmKVqnJsK?=
 =?us-ascii?Q?vT9ZWhBho7wmAvIg1KYe7VaUaJVPhqfOrSICshJiFs7tJFK4BIWx3VgLQytL?=
 =?us-ascii?Q?bcwMERWuD1VTNhTPJLjKC1f2vhWWia4DmIDwCxGzPhvWc8edsmMr+f0ucKKw?=
 =?us-ascii?Q?ZKOCweTKuc+RP0R1om7k121M/CuwgDgxN4cM1rg+ZYLK9GdZLYxjnW/cERVq?=
 =?us-ascii?Q?ECN5u8QR4BfalF2o08DXlIvCs7vJcnThHQ53CWrEhaV43Vks9Rf7BmFUOb2F?=
 =?us-ascii?Q?ZP+ecQnqcmdqi0zkOaZo0metKVGckMSDssKd+f3FiKToTcKBn0ClcGex0vbV?=
 =?us-ascii?Q?tXweyIl4dIqSNBuaN9Cj+10XC32Cb4QyVYEDVhQMwl3w4vOKkmcCuG6W0dkH?=
 =?us-ascii?Q?djSW94s7DNHdLwYKtaQ67jlXf5S0PjGrjNMvjY0E8vcg29FyFFZyLNe6Clms?=
 =?us-ascii?Q?4j4owS5Qh0DZ1oftYgD8yLURfjWOSRorzuuSlfRnaSVsHnzAHg82rd5n8Acz?=
 =?us-ascii?Q?1Br+dbd1DoBiKVfLCD9T5q2G/bQqjy0tffc3oO45YzHJcZzWhg95PHBy/o6g?=
 =?us-ascii?Q?DApYvxMN9OFwj8R71tgqXzu1G1xvd0a5b4dssV6cfh2wuaOGuUWcM+78C2Ca?=
 =?us-ascii?Q?vUe2rBhq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81e41d5-9eb6-474c-b12a-08d8c198ac44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:21:14.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0ODB7oa/4kd6lUTvR1RdS5Rkh1uBURAo89mO/dfxqsCEJtukwvTqEUfEQQJ+6OdUL1MkilmiOFNgbQn7hjlVAEWPLjLjnKa3P+55WIcA1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> Microsoft Hypervisor requires the root partition to make a few
> hypercalls to setup application processors before they can be used.
>=20
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> CPU hotplug and unplug is not yet supported in this setup, so those
> paths remain untouched.
>=20
> v3: Always call native SMP preparation function.
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index c376d191a260..13d3b6dd21a3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -31,6 +31,7 @@
>  #include <asm/reboot.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <asm/numa.h>
>=20
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -212,6 +213,32 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  	hv_init_spinlocks();
>  #endif
>  }
> +
> +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +#ifdef CONFIG_X86_64
> +	int i;
> +	int ret;
> +#endif
> +
> +	native_smp_prepare_cpus(max_cpus);
> +
> +#ifdef CONFIG_X86_64
> +	for_each_present_cpu(i) {
> +		if (i =3D=3D 0)
> +			continue;
> +		ret =3D hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(=
i));
> +		BUG_ON(ret);
> +	}
> +
> +	for_each_present_cpu(i) {
> +		if (i =3D=3D 0)
> +			continue;
> +		ret =3D hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, i=
, i);
> +		BUG_ON(ret);
> +	}
> +#endif
> +}
>  #endif
>=20
>  static void __init ms_hyperv_init_platform(void)
> @@ -368,6 +395,8 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> +	if (hv_root_partition)
> +		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
>=20
>  	/*
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

