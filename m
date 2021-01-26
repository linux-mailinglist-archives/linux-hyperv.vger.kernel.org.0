Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4F3033EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jan 2021 06:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbhAZFIp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jan 2021 00:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbhAZBzJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jan 2021 20:55:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20725.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::725])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE81DC0611BD;
        Mon, 25 Jan 2021 16:56:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx4S+/Sro7nEk1rhLQVMzroTiqUoqZ2bCuZrj3XAd9sKkOyjS2FDEebBsRQNrLUSrTpw0zANZ6j28EIVs26PFV+lVXKA+fuuq/s8kANb8Cd00E5ZDOjULbl565OMLiZz67GgrnYGZkz58f+xxdUvjyJCcGb5cKlaa7kMoWcl+PMupcv/9SXsO7vGnaaaLp5sa9wqs2HYLaQbLJCXs+e1+v0qw7EdJ81mp94440/ktaTMUls4CQnpuvZr/o3M/anTlg+LmSaXeG0CgEYXDCBye2niNDjCWJB+2MdJ16cd5FBBrc1FkrMkx0aN0woqwreShCcIQN6ft2zcmRkhBelN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDBV2EGciBJHstewCD2rNWPp8xT7eKVaRVLi5OtlUx8=;
 b=D9dFua78rJEXBcfEA4Bk3x9ordEg13cy5JLfY41mjDysoRzBMfQM1OACtCLaGylxAk/GEPrn77LDe7fYVyafd/TA3jgwB13inxsctpxNvZT2h/P7gs6KCGBDEL2tpLH6rkXtFjveniXO9FsHxuCxonrpjbtQKbSATxBV8Di4E+3WtqNZnsFtHG7QzrFipnXVtTeqZP7eOKyD8HhrlpRMYrtDgNkJrPSKVC7ReIeDptdA3huhwZ5XjKxcM/lDoXXjuUQIvHO2TdDN7qi08Y8y1lzY/jjyZyRdlOYpydSVwsT9Lxssb8MBuQRW78nD98js5jiCzKoahxCNtksJeOcpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDBV2EGciBJHstewCD2rNWPp8xT7eKVaRVLi5OtlUx8=;
 b=Y3xEtYNTPVEqwujaIZSG3AASOgD/h66LwPJ+/81k27OxP5md5j0Oln34NGCdervivP24eRe84IfaLCnlaEGajaC/vtJ5b89dUEgRbVOHA8UA2tjoP/2MeBciKeEWB1Vu7iMN/E6GSPGcdoscwSebxo3MfRhtXzherAJxntgt5jA=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1873.namprd21.prod.outlook.com (2603:10b6:303:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Tue, 26 Jan 2021 00:49:42 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:49:41 +0000
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
Subject: RE: [PATCH v5 08/16] x86/hyperv: handling hypercall page setup for
 root
Thread-Topic: [PATCH v5 08/16] x86/hyperv: handling hypercall page setup for
 root
Thread-Index: AQHW7yPzzYYijWwcS0miZDMiMFfVn6o5G7Og
Date:   Tue, 26 Jan 2021 00:49:41 +0000
Message-ID: <MWHPR21MB159330C9B68EC00916FD1EC1D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-9-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-9-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:49:40Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb830b5e-014b-4766-8dc9-bcbb22a86751;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4db5d11d-d93e-4d8a-c975-08d8c1944462
x-ms-traffictypediagnostic: MW4PR21MB1873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1873E75E24176D7B6C565ADED7BC9@MW4PR21MB1873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mmk0ILlrWWtTDjrd0twtIQetZKNCxSxtQFpXrliZN2gYJBUoVKtuxL18+tanKq6NI0mFIbBwRi7EXgVaHwVpNN9SHOI9CjKY5NQTjpAURw/EaVab0tz8sSfjPBpKkXMj5b4fb1pey3IvNLhYSNyWdtJ4k1TCVDxadPtaOLRMbvkr+H0mCSXVd6wNyfanmawtAZotEcTlTH/7ylchMzUJEnFEXY9lvZh6mZmQuXjV49Cx1/ogDR79Wynd1T+wAVtiD2xeKj0REi4SLOuOuhsxChlP1CLI8a5wtgMb+vbc4XDQHddrG17Cmw2c0+TPplQ5Cz1Pc4NSxQhb42wxBS3Xw0/ixvx/jQq7Yo5KUGMQ9mSzkWqbhp1z1HIRVFQS9R1xNtiBY7VjzwTxFzdIKfazqvquMz1LCaY70Dnse+0605PunDAP8fCg7GTr054HVmNY9eY3EyLMaFuxGSyJMrtwQlfkPablhJnp5yE3vrrhXh3n9TytA2TzJjZl7nTxH6pf2szoCCsPhBpNZPiHZMK/hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(26005)(82950400001)(8990500004)(7416002)(83380400001)(82960400001)(7696005)(55016002)(9686003)(76116006)(6506007)(186003)(54906003)(316002)(71200400001)(478600001)(64756008)(110136005)(2906002)(66556008)(33656002)(52536014)(10290500003)(8676002)(66446008)(86362001)(66476007)(8936002)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iDw2Mu9x5PpUstN+d3QhqdB6wW5jeBMvV7gAmKFx4ed0nrQFRLPHxU121n6U?=
 =?us-ascii?Q?Xa54xmYjJE2Mp2Q+dN6iPgeOp6nU65K2AoYMsq4oq4QyUdgC+X6KEjXqKEt5?=
 =?us-ascii?Q?PAWdDHBKJ3mH0ufDGhwIu3vNOOt4T9n67UUosY913kSmNvM0iIqxxU3ASUKD?=
 =?us-ascii?Q?gDevLA2Aa1Xd1qRHcOozDq6WIeFW4ABP8sVD09PVxaMSVMUitQw+jkTIDgw/?=
 =?us-ascii?Q?iHwPQOJeBX/kKwt5iB6A8DuFYUxt2rqjGAcFiYRHj2g1gvv5aTqnFpSQatGo?=
 =?us-ascii?Q?AvkZn+JsbPKLDLT1vATTAVB2CReZdea6T6roRy15XU8B9vmso0iCz8QqdLix?=
 =?us-ascii?Q?ynbnkLl+IkEzBBjJBHjc1fIdhaYYENO29bH72MbNcLx9uLv3up2U9Hu/PLLu?=
 =?us-ascii?Q?5/Ud7FZTNJY8ukudVApbr+mpo5cBLHounD3iaNm76hCOSVxehxmsmdyOjEXO?=
 =?us-ascii?Q?NfwCv1I1Dxx9HWLdSfsU3RxE7cNtgRupuDHN89afGdZJkMQCkSSmqszuIJpR?=
 =?us-ascii?Q?YsGgonPX26zYXPsH960txg+1q4COFXGNbU6l7E+eYr0YerFSEKtS6we+ZZ8n?=
 =?us-ascii?Q?8qKBWbrMEIWTb4rfhsVhzgQqIaksLw2NmxPRoZENqD6DLwy0ukz5aiJx3y5j?=
 =?us-ascii?Q?uDd8K+GPk7DEy6JG1zoaKnfk65tiX+ZdL2YPpTPUSwviFDGN4uLoZfAAFDFr?=
 =?us-ascii?Q?hLRyvsaatanXK8AaNzD4FpfVRADJzr5GX/tJKQT63mCuB9msR8YZ6l7IZJGS?=
 =?us-ascii?Q?hJrcVSdi2wBeQoVc6r3Y4evILkrvK5oPZq66gWv7CmKJnVMveNMptPkA0Hzc?=
 =?us-ascii?Q?QqLjVLyDkJ3IQ8GFo8FCtpxYk09FPiNneaUxKHvdqOkm61hBc13cDu/hNAln?=
 =?us-ascii?Q?HYKOkIs1VR4/+jnk8ktlDYP0IPN2/sxdMs5fNQx8ODGcimUuJ5wjE1wJcFEq?=
 =?us-ascii?Q?Lx8XsLAOObFm15ABXfa6QyVeGxNYbtKKz2yh2J1AdUEQz7J5FbRCrB19c5kQ?=
 =?us-ascii?Q?H9QolAirI+/jimMgKEtXkOKGRc9j1rJAo73fpioVdSwBbcviu9T/+mDeWf/s?=
 =?us-ascii?Q?0hE5Me6a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db5d11d-d93e-4d8a-c975-08d8c1944462
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:49:41.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjrubffGFsp0EvBkh0Vy3eF0G5uJhlnT+ogeGLi/er9Z9cAhZf5L1jgU6IbbhKcvGVpyZjTwe9KXAV8hrWmCp4SvabqR0sNq5T+6E5U7fl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1873
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> When Linux is running as the root partition, the hypercall page will
> have already been setup by Hyper-V. Copy the content over to the
> allocated page.
>=20
> Add checks to hv_suspend & co to bail early because they are not
> supported in this setup yet.
>=20
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3:
> 1. Use HV_HYP_PAGE_SIZE.
> 2. Add checks to hv_suspend & co.
> ---
>  arch/x86/hyperv/hv_init.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index fc9941bd8653..ad8e77859b32 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -25,6 +25,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <linux/highmem.h>
>=20
>  u64 hv_current_partition_id =3D ~0ull;
>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
> @@ -283,6 +284,9 @@ static int hv_suspend(void)
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	int ret;
>=20
> +	if (hv_root_partition)
> +		return -EPERM;
> +
>  	/*
>  	 * Reset the hypercall page as it is going to be invalidated
>  	 * accross hibernation. Setting hv_hypercall_pg to NULL ensures
> @@ -433,8 +437,35 @@ void __init hyperv_init(void)
>=20
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	hypercall_msr.enable =3D 1;
> -	hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_pg=
);
> -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +	if (hv_root_partition) {
> +		struct page *pg;
> +		void *src, *dst;
> +
> +		/*
> +		 * For the root partition, the hypervisor will set up its
> +		 * hypercall page. The hypervisor guarantees it will not show
> +		 * up in the root's address space. The root can't change the
> +		 * location of the hypercall page.
> +		 *
> +		 * Order is important here. We must enable the hypercall page
> +		 * so it is populated with code, then copy the code to an
> +		 * executable page.
> +		 */
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +		pg =3D vmalloc_to_page(hv_hypercall_pg);
> +		dst =3D kmap(pg);
> +		src =3D memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT,
> PAGE_SIZE,
> +				MEMREMAP_WB);
> +		BUG_ON(!(src && dst));
> +		memcpy(dst, src, HV_HYP_PAGE_SIZE);
> +		memunmap(src);
> +		kunmap(pg);
> +	} else {
> +		hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_p=
g);
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	}
>=20
>  	/*
>  	 * Ignore any errors in setting up stimer clockevents
> @@ -577,6 +608,6 @@ EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
>=20
>  bool hv_is_hibernation_supported(void)
>  {
> -	return acpi_sleep_state_supported(ACPI_STATE_S4);
> +	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

