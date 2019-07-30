Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4627B59B
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 00:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfG3WT3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 18:19:29 -0400
Received: from mail-eopbgr770101.outbound.protection.outlook.com ([40.107.77.101]:39566
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727221AbfG3WT3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 18:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkbC6ru3eXfcTyngYExv7aIvLn4acJutz6scBVefejyRiD0+jJxsrj6jU4LGbrL77J6RB8XFVWs8W/HqDLEwe4HmOjJ5zpSbCy4vBspcP0HxtI6RH/Himv7/1ghq8wCLwYb1khCtUnmkah7fbm0KFMa752t9qpyYtxNHiLOo97Bzsla8XwL+JIjrxnmbJMUF04OK8R+m7Z+NwmTVxyRMRgMd7t8sj1IUIDzK9Y4Qzkf5p+7zVyVmqyuK8Gc+itnUiY6ZDpiCYCWw4Eb4+WmpenOlPhxIFxQObqkkp1Mo01XMts1ZOqkGnSVpz+CI35LCHXOw1X7j6iMzU2NF0XHCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILlD/M0iGaE4EZd0FclBI9B8rkVCtWFlbtpvrIe3RqE=;
 b=h8iwh0bYzdNKqQHfIrtwI41s0BzR7bEM8L00WZ1Tsw1gZ596V5ugVfDytSHlhFeoYPV1FMbg7BzRyWd9gVyyc21NjtbxtZk/TpAkemeZEipKw0ev72m/i2qyF3bAvkK9KlyHl0/gkEysUG3m4R1tnV7kaXYPNxV2j1komlT9cKgm7uAwTDNUH+5Nb5Hv+fH4MBrq2LOE+NdT2ZlU3NjtiG3U3irEcbudma1qLI7LYnh1LkNlho03JF2XIuqvnI7u9M79vCB/dbZKINCO1+roZOc1gzusU0W7GvB3s6yUHVR1v+cM/gMipadg625aHn2MLC9IzHrvcitUJmF/s0op3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILlD/M0iGaE4EZd0FclBI9B8rkVCtWFlbtpvrIe3RqE=;
 b=SqfYOiRl4C86TMvaQqrJDHYh8SbAfjqJ2ICQJmhH7Q/WSuX6cODDz2RQQi+1QszF6rGyYzqFbubKFWmX6IOo6wO6D/F4JDktvAJ1VlxOKRyQThGV1mDdYBFDwhgVIo+xAZ/dXp/uSdZNdCEknRdkDDiJZhJgNjKh8+VZ72fpWpc=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0480.namprd21.prod.outlook.com (10.172.102.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 30 Jul 2019 22:18:47 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82%5]) with mapi id 15.20.2157.001; Tue, 30 Jul 2019
 22:18:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH 1/7] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Index: AQHVNhdG1PV70hLFV02EnwqrSuKo7Kbj3P5w
Date:   Tue, 30 Jul 2019 22:18:46 +0000
Message-ID: <MWHPR21MB078457E7EE901901DB338627D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-2-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-2-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T22:18:45.2364978Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=63098153-3653-4bab-843d-dbcc52471da1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7589487-91c6-4d60-fe0a-08d7153be41a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0480;
x-ms-traffictypediagnostic: MWHPR21MB0480:|MWHPR21MB0480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB048043306854E0C46F195284D7DC0@MWHPR21MB0480.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(81156014)(55016002)(14454004)(4326008)(6246003)(3846002)(64756008)(76116006)(25786009)(66476007)(6116002)(2906002)(66446008)(9686003)(33656002)(5660300002)(52536014)(229853002)(66946007)(53936002)(66556008)(316002)(6436002)(110136005)(22452003)(486006)(476003)(6506007)(76176011)(186003)(26005)(68736007)(15650500001)(256004)(10090500001)(14444005)(10290500003)(478600001)(8990500004)(99286004)(71200400001)(71190400001)(7696005)(446003)(11346002)(7736002)(305945005)(8936002)(81166006)(2201001)(1511001)(74316002)(2501003)(102836004)(86362001)(8676002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0480;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R4JSbf1/T2HmnbvWZVWYmSJLD/Z1xXGSLRugt+M106emxzGseyvFG6SCzZEdUl1kO8yabWY8HjobR7zhPNnJZDnNPOkUGogBzEuRlfHU1hVUzeOXvbYhCHtnqyuvba/Ft6+/qVByDzWqJJ4YvG7CyxvdKq21h7f3ZXVobQb5fNpQg+T0FX8QMO/DDyIcn4LlIoBD6bwqc9Mo9fY/ZlwJrNiJ5omXAJ/+wgsRv4qtvizLA0e1qu6h8XOlu4jf1V+atfAC7DPMxCiFOORAUd3yN7QZZ2PbqEsy/YaCePmwFQfIk/Pb/5fum6Kri/FTEg4XkDBPJO6r3weqqLasm0jrzTUHU2VL6QbvL7AKc4YwMJoX4gpGdmr0v6D3uq0YoOSZ/9BVIhhEcecqH+jEf93raI2xSh00GXcjICREpUy/zMY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7589487-91c6-4d60-fe0a-08d7153be41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 22:18:46.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +V02nacHGqlKLhcGz8Y2Aco8Uq91FdMVzUDv99xK/aD+s0fW9RpYfEJ3zeKCFkHIU//m5akTssAxDMEFAYwq0EuMuBXXRNpRT5Vu2DkOdBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0480
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, July 8, 2019 10:29 PM
>=20
> This is needed for hibernation, e.g. when we resume the old kernel, we ne=
ed
> to disable the "current" kernel's hypercall page and then resume the old
> kernel's.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0e033ef..3005871 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -20,6 +20,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>=20
>  void *hv_hypercall_pg;
> @@ -214,6 +215,34 @@ static int __init hv_pci_init(void)
>  	return 1;
>  }
>=20
> +static int hv_suspend(void)
> +{
> +	union hv_x64_msr_hypercall_contents hypercall_msr;
> +
> +	/* Reset the hypercall page */
> +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hypercall_msr.enable =3D 0;
> +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +	return 0;
> +}
> +
> +static void hv_resume(void)
> +{
> +	union hv_x64_msr_hypercall_contents hypercall_msr;
> +
> +	/* Re-enable the hypercall page */
> +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hypercall_msr.enable =3D 1;
> +	hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_pg=
);
> +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +}
> +
> +static struct syscore_ops hv_syscore_ops =3D {
> +	.suspend =3D hv_suspend,
> +	.resume =3D hv_resume,
> +};
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -294,6 +323,9 @@ void __init hyperv_init(void)
>=20
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
> +
> +	register_syscore_ops(&hv_syscore_ops);
> +
>  	return;
>=20
>  remove_cpuhp_state:
> @@ -313,6 +345,8 @@ void hyperv_cleanup(void)
>  {
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>=20
> +	unregister_syscore_ops(&hv_syscore_ops);
> +
>  	/* Reset our OS id */
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>=20
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

