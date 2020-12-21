Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9F2E02EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 00:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLUXeE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Dec 2020 18:34:04 -0500
Received: from mail-dm6nam10on2118.outbound.protection.outlook.com ([40.107.93.118]:53984
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgLUXeD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Dec 2020 18:34:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iASYgVZEIs5v1kQDEdCzp9HyKobEtFZcoIufFTCzcvXgBat30Ra5YiEGlZDc2KGyd5SvPgSx/mqyCkuBuh2mn0oOtgV6JhTFI1AxOm9QkZhGv6Hi20Nd8iPLOxExv/tJd5FInMxIi6NkZyJ6DCS/GwYorvNxuCaQpe0BLN5IXFEA85KGkrJ845d+8siwFIUwpZ7H1RQ0zRM4zoHa3ZPCiPdQ8S0zLgojTgMQjCmPyAbY8CONFtooTZvouJVji7SpEQfoWhMdYRkdIUfBSrEYkKk20226QLNIgYKD+ZriYMNqb4iD/C4FK11BL6Jk8a2jG/tLkZfsP/i8FNRzQ/Ub/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmkTBLEs6+oWeh/BxwS99/VtUsR7KxCU2Q3kLEOjYoM=;
 b=F+XsOoi2zBi12qFLPXQhNCNX4qPLcyuCX+PkK7VuOAIU8M44lKRgTJeKFvUTGgBAoaDhaHHd0+7clzobA8A5EHOqA0NBmpsI0cu1Ogda8K4hgjdHoYsS0ET/qQfsbcO6liM9RLXeMXEAG1yplx2R8v4Znz/Ri+xecMy1HoBiUGeuHy7gK/u5JQ+GMoIK8Y0rJinGhlE2Wmjc78d5WOiyxuJcn4rFQCihGjHH2jvDIFNCmvOHP17EtpoSmmtbjdLdjRqMBuvEDesc2uERHq32l3zljeFIHIX+CtsX8uWvfjdLV6jKO/mq1eYpGHuGfDGnEyS/TfUDSxaxeG9Unlmujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmkTBLEs6+oWeh/BxwS99/VtUsR7KxCU2Q3kLEOjYoM=;
 b=fwKkhomEo3jzk76nWGajepalnajXf+0CFbF06/UXP5qV68XXnZbVsi00CoHBrAygH7dumb5DLM5aqxf/v52j46C77gPH7dioyOt4XajsmanKqofAw5TPQF8WI5i8UP4bXPkIdN2Xo+nOA96BYGWtqHsUA8Yk2CpYbNpLmMQBQW8=
Received: from (2603:10b6:302:a::16) by
 MW4PR21MB1857.namprd21.prod.outlook.com (2603:10b6:303:74::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.7; Mon, 21 Dec 2020 23:33:13 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3721.008; Mon, 21 Dec 2020
 23:33:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "jwiesner@suse.com" <jwiesner@suse.com>,
        "ohering@suse.com" <ohering@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] x86/hyperv: Fix kexec panic/hang issues
Thread-Topic: [PATCH] x86/hyperv: Fix kexec panic/hang issues
Thread-Index: AQHW1x+4gDeU8wnI6U2zhrRpW1B6M6oCL5eg
Date:   Mon, 21 Dec 2020 23:33:13 +0000
Message-ID: <MW2PR2101MB1052192A1BC63A1A3DC196C6D7C09@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201220223014.14602-1-decui@microsoft.com>
In-Reply-To: <20201220223014.14602-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-21T23:33:11Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8aad501-3bf8-45a1-8f2a-10c18630a334;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fea8009-4eda-4c4f-0a37-08d8a608c8fe
x-ms-traffictypediagnostic: MW4PR21MB1857:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB18572F2E17331BE7C5C96867D7C09@MW4PR21MB1857.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xFGDulSbsj9Hg+SdXyeUY6WJrHoB1J7VS8QuGgk2dgAARQVZ7eUkZVINqcFUgXjqzk73BHph+wGlopgF2Pv0j5ujEynMM3UD/SE1uhWMQgF8Qq+0+8NL8eqzxcvadChPrRdZiu0YagA7ZT83mxNmfThpHZVyixmWv7oieqBjcAo4gbAzeu5kW5tqAycIXLUolqMMwD0+TtkGKuqIzsWHt6Imql0whBr/eGFCy6QfVntlbjppacHLuFFQtjiv0vnUrMy2LfQs+ojbZCGGPcFeV2WE5eIyG8e1b4fCnMeLOOUb6DSzX12zBRAgOPEfCjGG7KuY7Ne72Q2uSF+vnyyHcrTzRugWXdGgBqpw9EENoPAxl/KyGfTFcmfCfp32LLQOBD6b4nqUzKrELMHL1zTTOD80YsiIvqIsWodJa7mXETtU9rhI5DdejBXQQl3GBMqE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(52536014)(54906003)(6506007)(9686003)(110136005)(82960400001)(921005)(66946007)(76116006)(10290500003)(66476007)(83380400001)(4326008)(2906002)(107886003)(316002)(82950400001)(55016002)(7696005)(86362001)(26005)(66446008)(8990500004)(186003)(8676002)(66556008)(64756008)(33656002)(7416002)(71200400001)(5660300002)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?71xFpGDLDwI/n4KldqyRqWfb0/HTrlpN+ZqkBXoPx/thJfmYC0pGpHZhr99E?=
 =?us-ascii?Q?NI0gNC/8gNIMEfIBOwHgfRGbS6VuH23aceCYqU7LYnh2vVcnoQHzuxkUCxYb?=
 =?us-ascii?Q?3tND8U3d7RT0+cyKDLQuq/v/y8gJI8PJy+7qJuoQY18jFYmP1NtOZX3cGC8S?=
 =?us-ascii?Q?7wjUA9QxX0Ty94TN6VZFoIna3JFTAmechtnpyXUl7iWEgA677S3gT/S282pg?=
 =?us-ascii?Q?BgKj/+gv5RxTLkbhabafyGI1OOFuLQUjc7wQ91RXq2wNh60Ld8SIKMAlzHnQ?=
 =?us-ascii?Q?A2Z65oRKKL1goNHbTHx7nwg48iX18BxX2WkB/M+zoDaYtD5E/ISXpPdyMN/X?=
 =?us-ascii?Q?qYeFo1rTg/Vy+yvYnjmzeucHkPiEaLkUqWMF1TESPuS9auel71htC/ZAIKSA?=
 =?us-ascii?Q?3Jzp9o4JgJaNs7eiDUZHImDZZipUnhaDjYWqQfivxLWkYbeEXmet2K1toQg0?=
 =?us-ascii?Q?Ju6yNbE6Gv6dKQxcMK1rhozHfkE47CDLzlxdnPhaj4d63+0QpiXThRJvb2ZG?=
 =?us-ascii?Q?7gEqD4WOfv7ggEFQ0w5t2X35/dhVmwI7LFKOnqaYJdGxpSs2Emwx0QJO80AG?=
 =?us-ascii?Q?EQbN33xkM30dINIgDKYF9jgiwMhDWXuJV+krmmSUjPFiztfWYI8/qWo6aNfG?=
 =?us-ascii?Q?p5StccFzElEFIGbIPvrcy+6ULWMlmbKhUc+Fgs2O8Pf+/biu64Lb3dEFWPLU?=
 =?us-ascii?Q?3dpvcJMglozzT1m9Bm7aP5fchhFTDUVskmT3FE6JqjwlLR102khE7pfuj9Xx?=
 =?us-ascii?Q?Ty3FS9M0OYavMP7duvHjh1oBsVNpTlVY+4GLrRkt1XYfkYKJaIpBOvcakWut?=
 =?us-ascii?Q?Vo5ddy3VpGJbfQDN44oyYelerzZ2AvNdVmYV0aaZazQ34/jC4um2DKTI53M/?=
 =?us-ascii?Q?3Pi+cGn2t3MOc0rc2dK46/MyW6RvkN5mnsIIBvXTMDEMZOWiQhlf1P7yiEIH?=
 =?us-ascii?Q?9ZPtW+ctws9hODmc6oo0YtOZ/4o4ibolO1hgpaWLM6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fea8009-4eda-4c4f-0a37-08d8a608c8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 23:33:13.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qg0BrBEO526rP+UUM7UKIz/nXCkaYL1+cpmwkxFqQ6rz5EixQjM2vqjOrhAy8vz93hWQQk2OzXTWL1/U7/CNzZCSQCw13hPjTzsx+OVC3Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1857
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, December 20, 2020 2:30=
 PM
>=20
> Currently the kexec kernel can panic or hang due to 2 causes:
>=20
> 1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts the
> VP Assist Pages when the kexec kernel runs. We ever fixed the same issue

Spurious word "ever".  And avoid first person "we".  Perhaps:

     The same issue is fixed for hibernation in commit ..... .  Now fix it =
for kexec.

> for hibernation in
> commit 421f090c819d ("x86/hyperv: Suspend/resume the VP assist page for h=
ibernation")
> and now let's fix it for kexec.

Is the VP Assist Page getting cleared anywhere on the panic path?  We can
only do it for the CPU that runs panic(), but I don't think it is getting c=
leared
even for that CPU.   It is cleared only in hv_cpu_die(), and that's not cal=
led on
the panic path.

>=20
> 2) hyperv_cleanup() is called too early. In the kexec path, the other CPU=
s
> are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
> between hv_kexec_handler() and native_machine_shutdown(), the other CPUs
> can still try to access the hypercall page and cause panic. The workaroun=
d
> "hv_hypercall_pg =3D NULL;" in hyperv_cleanup() can't work reliably.

I would note that the comment in hv_suspend() is also incorrect on this
point.  Setting hv_hypercall_pg to NULL does not cause subsequent
hypercalls to fail safely.  The fast hypercalls don't test for it, and even=
 if they
did test like hv_do_hypercall(), the test just creates a race condition.

> Move hyperv_cleanup() to the right place.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |  4 ++++
>  arch/x86/include/asm/mshyperv.h |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c  | 18 ++++++++++++++++++
>  drivers/hv/vmbus_drv.c          |  2 --
>  4 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27..4638a52d8eae 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -16,6 +16,7 @@
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
> +#include <linux/kexec.h>
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
> @@ -26,6 +27,8 @@
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>=20
> +int hyperv_init_cpuhp;
> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>=20
> @@ -401,6 +404,7 @@ void __init hyperv_init(void)
>=20
>  	register_syscore_ops(&hv_syscore_ops);
>=20
> +	hyperv_init_cpuhp =3D cpuhp;
>  	return;
>=20
>  remove_cpuhp_state:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index ffc289992d1b..30f76b966857 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -74,6 +74,8 @@ static inline void hv_disable_stimer0_percpu_irq(int ir=
q) {}
>=20
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
> +extern int hyperv_init_cpuhp;
> +
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f628e3dc150f..43b54bef5448 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -135,14 +135,32 @@ static void hv_machine_shutdown(void)
>  {
>  	if (kexec_in_progress && hv_kexec_handler)
>  		hv_kexec_handler();
> +
> +	/*
> +	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
> +	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
> +	 */
> +	if (kexec_in_progress && hyperv_init_cpuhp > 0)
> +		cpuhp_remove_state(hyperv_init_cpuhp);
> +
> +	/* The function calls stop_other_cpus(). */
>  	native_machine_shutdown();
> +
> +	/* Disable the hypercall page when there is only 1 active CPU. */
> +	if (kexec_in_progress)
> +		hyperv_cleanup();
>  }
>=20
>  static void hv_machine_crash_shutdown(struct pt_regs *regs)
>  {
>  	if (hv_crash_handler)
>  		hv_crash_handler(regs);
> +
> +	/* The function calls crash_smp_send_stop(). */

Actually, crash_smp_send_stop() or smp_send_stop() has already been
called earlier by panic(), so there's already only a single CPU running at
this point.  crash_smp_send_stop() is called again in
native_machine_crash_shutdown(), but it has a flag to prevent it from
running again.

>  	native_machine_crash_shutdown(regs);
> +
> +	/* Disable the hypercall page when there is only 1 active CPU. */
> +	hyperv_cleanup();

Moving the call to hyperv_cleanup() in the panic path is OK, and it makes
the panic and kexec() paths more similar, but I don't think it is necessary=
.
As noted above, the other CPUs have already been stopped, so they shouldn't
be executing any hypercalls. =20

>  }
>  #endif /* CONFIG_KEXEC_CORE */
>  #endif /* CONFIG_HYPERV */
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 502f8cd95f6d..d491fdcee61f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2550,7 +2550,6 @@ static void hv_kexec_handler(void)
>  	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
>  	mb();
>  	cpuhp_remove_state(hyperv_cpuhp_online);
> -	hyperv_cleanup();
>  };
>=20
>  static void hv_crash_handler(struct pt_regs *regs)
> @@ -2566,7 +2565,6 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	cpu =3D smp_processor_id();
>  	hv_stimer_cleanup(cpu);
>  	hv_synic_disable_regs(cpu);
> -	hyperv_cleanup();
>  };
>=20
>  static int hv_synic_suspend(void)
> --
> 2.19.1
