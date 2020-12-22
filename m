Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E832E04C5
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 04:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLVDhM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Dec 2020 22:37:12 -0500
Received: from mail-co1nam11on2120.outbound.protection.outlook.com ([40.107.220.120]:26337
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbgLVDhL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Dec 2020 22:37:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhEQ+ABktzrXssWOYUFNvLR9MZKvc8DsWMdepXtFNQjQcSz/kMWtj63EExUVwyvY3TXb9c1szIGwpQA6YqbDMpLyrb7RdGY0sGKytRYMMOcAaOCYQZY+3rFgDta5duf0z1vDtLJyalaOZWTWbo37TrKl2uSI18B3aQOfiAJM3J12G7HiCeKcQQmw5lDlNX9C9B8m7akgwepbxC4RbDbgHdzdeaDHHnPPjV1vS+sfI9MI30VzB3gbKiekH6cB9I7j2sr6n24o/kjxwOVKWkiBIYoE1XRXE1ZWMtmgfod66XxkmUSrcoiv7ljdFRs8/s1v1VAiS9OmeTFckZk/gpQZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqTL9toNaYU5d+DCkslfYyA+e78yxWThi1RAVfuUH/g=;
 b=mx7XB9S5KMfBqSzbpLn7dGhG9Cmqnz+VNK41Cq5ZXZOQXbLo9TYLbHGALruqDM6xfvt4IPAcrB9xa2U7o9N0tfIHIZPSGyx4az6kn/1YKwtju3mSK2OV+irm/cxu6jsJk/VdOEiGrhxrY+PQ6hiVZVc5OjiIarN3CBKUu8W7crXJ6snWH6TrvlsA2Vl0GXmnzCpUolVIEAEc6rrm1mQ3oebjy0ZSeoIPLLHpDR2jY2ttflnwj9ltRuATtTLn1j5w26+CbakbZlgXBrb8D1//dd4vZRMDAfLu9nXayD+w3n+XjBzNRSIcxlnAdKajohu/9W48KNz6er+5/HErmn9Xng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqTL9toNaYU5d+DCkslfYyA+e78yxWThi1RAVfuUH/g=;
 b=ZRjZuNUGAYq8QqwPw4Xaq1+C0rmnc4iL2Ci8V09XweiKqC8TP4XFI/LP8xdWwkzIwjmYYWLEw4CtUqsHbJ7XYsN5qA79gApM/V5tu/hEOB5AglS5037zYJ7OKDgp2HR3HwTQ9Eq0FVz5me+/EmqlwqgqJFEojT7P+w/fPYWiGr0=
Received: from (2603:10b6:302:a::16) by
 MWHPR21MB0799.namprd21.prod.outlook.com (2603:10b6:300:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.8; Tue, 22 Dec
 2020 03:36:18 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 03:36:18 +0000
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
Thread-Index: AQHW1x+4gDeU8wnI6U2zhrRpW1B6M6oCL5eggAAJtpCAAD0rQA==
Date:   Tue, 22 Dec 2020 03:36:17 +0000
Message-ID: <MW2PR2101MB1052D798D9D292F6D43F85C4D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201220223014.14602-1-decui@microsoft.com>
 <MW2PR2101MB1052192A1BC63A1A3DC196C6D7C09@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <MW4PR21MB1857877C13551B1618852F59BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
In-Reply-To: <MW4PR21MB1857877C13551B1618852F59BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 22d57a4c-b281-4b31-7fec-08d8a62abe1c
x-ms-traffictypediagnostic: MWHPR21MB0799:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB079915E2057EBF3EB131B3F6D7DF9@MWHPR21MB0799.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9oUJ5+Q6S28PnF3kXUVCn+gEAof3w8PwNbyakrDD7/amZIQCIctF0pqOEkmztOqDuTJ5S9px4W7y/BWFA12Z+C2s86w8iteNpdCbsHTzHtv6GPZCBDE+WfftbDPv5T7YRxmX0JL3DjyBY49fmWm21BEr8IQdAok6zCmNgxu+K0VVoAhKv0FWE3cf94WEU6uvYdNtDqI2tI8zISnHO6PH2175D/4oA9KzaKnaXVvg/WHQiMw5s3IrPAyQlnSXBzbQol3oDLSd6Pt+TjgNWRsKFS7Fg6mK1VFE9v1Y/+0hQa7uAsJY5Wjq5jbg3M/HIH/CouAVCJuFmJjamDw/AWrA9+hFGZ+kKGdO/bgKpoqGMf9pNUUEQrDbzH0tg83/mf3oOcqJwSA7otHmUtnqnRR/SUsZ4Yatg6KlX/G9Fdj0Fkm93JzYx60pgtVYqgNnBih2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(921005)(107886003)(7696005)(86362001)(110136005)(5660300002)(4326008)(2906002)(71200400001)(478600001)(8936002)(9686003)(55016002)(10290500003)(82960400001)(6506007)(82950400001)(66446008)(66476007)(66556008)(26005)(33656002)(83380400001)(76116006)(8990500004)(64756008)(7416002)(54906003)(186003)(66946007)(52536014)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OD5lZKgrXrQ10i66tvFrH+vhsQ5UrFCsH8Q+gf9R1PkNUrwEeQ4K/TmogjyV?=
 =?us-ascii?Q?Ztkq6UftKb0oEN1mdWYaCZJDjHWES/Zw8LCpQsN6Qq4DwIvuIDXlcHxQPQC9?=
 =?us-ascii?Q?Y+7DfjUiFjuAQ6GJBBgLtI0QX6OuUAVu/7F5aWs+tZ2qYcJlP6O9GmV7Rj9G?=
 =?us-ascii?Q?36TMzTKJB0pY32o+/3gurCPIus8+vPuE3ORlkyIw76J5VNwzPA6+FqBAXU7X?=
 =?us-ascii?Q?4Wp2iaMUEp//LbTPa8tKYn6PwBJHkYkD0bo2wafUhTy35ROPNVP0v7i2/rSP?=
 =?us-ascii?Q?0tT/BsLpf6uXa1hmYiRrWhZ9wybMznjPZszP8HomupIhgHirQaXC8ZhDux0n?=
 =?us-ascii?Q?MAmt5UqXI5D9tlemBYzkq9jUD+s6x1nPcwnUSwfrC5bgXnLSU2vwYfzfZNd+?=
 =?us-ascii?Q?rUOAGywZ14iSRikKV4zkXp5xRO0h+zcznQWZ11X3cCof5UROH0G2D/bJuwVS?=
 =?us-ascii?Q?ut7B/pbLfOonVGXb1WPRr69omjQJpMBY0DK1H6xJqGvTt0p5t5VSZrtveyo/?=
 =?us-ascii?Q?2HEgSOVQEOVKNTAACiF2xBA4PHvh4NopxC53mtWkNApr1VZCBjTjcfBEyWRI?=
 =?us-ascii?Q?orIH4Iw7/ViA6BYsk3J+75ZNNiiaIWIkJLvlGxynaWbuQLxbH+VYgDwzfbVa?=
 =?us-ascii?Q?Z9e2ih85ZTe/UsaRKpNOnK+sjBNMdlX1i+YDPU7UW+AIg+APtxiYMTpvCn44?=
 =?us-ascii?Q?9DD553S27LK3pnsiJ1Tvi6cvhcvCt109t749iTClUthHBXHe3bPa4roxgv/n?=
 =?us-ascii?Q?UbNKn5U/N+3KnoADhdFBVGov/vHUG2PWqmEAQTTqJfEwOaIzThg0FYXbjUNp?=
 =?us-ascii?Q?VF5FFhgKR0rWb67CsxFB3gx1CiEbqpFrhSO4hXTaZpVn3yWZAJfSoOAGQSla?=
 =?us-ascii?Q?kBiu0D9wfLfUwu3RK8W7i0RkVUCS2qe5O3KIBOL+rJnrVv7vLecKfLzJtN2G?=
 =?us-ascii?Q?MhaazFpjpDGlszui9dei83suJ7RIFRPYzyaf492UHgg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d57a4c-b281-4b31-7fec-08d8a62abe1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 03:36:17.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBup4e9QIfeeoPZGMji72YTK7ucPB62wSrJG95iE1YlbOB9yH1gFSGYCMlwgfCihYrjmNeCT+6ckGU55jeYBL08+Qif4k/iTBox12mWaxt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0799
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Monday, December 21, 2020 5:0=
4 PM
>=20
> > From: Michael Kelley
> > Sent: Monday, December 21, 2020 3:33 PM
> > From: Dexuan Cui
> > Sent: Sunday, December 20, 2020 2:30 PM
> > >
> > > Currently the kexec kernel can panic or hang due to 2 causes:
> > >
> > > 1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts =
the
> > > VP Assist Pages when the kexec kernel runs. We ever fixed the same is=
sue
> >
> > Spurious word "ever".  And avoid first person "we".  Perhaps:
> >
> > The same issue is fixed for hibernation in commit ..... .  Now fix it f=
or
> > kexec.
>=20
> Thanks! Will use this in v2.
>=20
> > > for hibernation in
> > > commit 421f090c819d ("x86/hyperv: Suspend/resume the VP assist page f=
or
> > hibernation")
> > > and now let's fix it for kexec.
> >
> > Is the VP Assist Page getting cleared anywhere on the panic path?  We c=
an
>=20
> It's not.
>=20
> > only do it for the CPU that runs panic(), but I don't think it is getti=
ng cleared
> > even for that CPU.   It is cleared only in hv_cpu_die(), and that's not=
 called on
> > the panic path.
>=20
> IMO kdump is different from the non-kdump kexec in that the kdump kernel
> runs without depending on the memory used by the first kernel, so it look=
s
> unnecessary to clear the first kernel's VP Assist Page (and the hypercall=
page).
> According to my test, the second kernel can re-enble the VP Asist Page an=
d
> the hypercall page using different GPAs, without disabling the old pages =
first.

Ah yes.  You are right.  The kdump kernel must be using a disjoint area of
physical memory,  so not clearing these per-CPU overlay pages shouldn't
put the kdump kernel at risk.

> Of course, in the future Hyper-V may require the guest to disable the pag=
es first
> before trying to re-enabling them, so I agree we'd better clear the pages=
 in the
> first kernell like this:
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 4638a52d8eae..8022f51c9c05 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -202,7 +202,7 @@ void clear_hv_tscchange_cb(void)
>  }
>  EXPORT_SYMBOL_GPL(clear_hv_tscchange_cb);
>=20
> -static int hv_cpu_die(unsigned int cpu)
> +int hv_cpu_die(unsigned int cpu)
>  {
>         struct hv_reenlightenment_control re_ctrl;
>         unsigned int new_cpu;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 30f76b966857..d090e781d216 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -76,6 +76,8 @@ static inline void hv_disable_stimer0_percpu_irq(int ir=
q) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern int hyperv_init_cpuhp;
>=20
> +int hv_cpu_die(unsigned int cpu);
> +
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 43b54bef5448..e54f8262bfe0 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -156,6 +156,9 @@ static void hv_machine_crash_shutdown(struct pt_regs =
*regs)
>         if (hv_crash_handler)
>                 hv_crash_handler(regs);
>=20
> +       /* Only call this on the faulting CPU. */
> +       hv_cpu_die(raw_smp_processor_id());
> +
>         /* The function calls crash_smp_send_stop(). */
>         native_machine_crash_shutdown(regs);

Since we don't *need* to do this, I think it might be less risky to just le=
ave
the code "as is".   But I'm OK either way.

>=20
> > > 2) hyperv_cleanup() is called too early. In the kexec path, the other=
 CPUs
> > > are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
> > > between hv_kexec_handler() and native_machine_shutdown(), the other
> > CPUs
> > > can still try to access the hypercall page and cause panic. The worka=
round
> > > "hv_hypercall_pg =3D NULL;" in hyperv_cleanup() can't work reliably.
> >
> > I would note that the comment in hv_suspend() is also incorrect on this
> > point.  Setting hv_hypercall_pg to NULL does not cause subsequent
> > hypercalls to fail safely.  The fast hypercalls don't test for it, and =
even if they
> > did test like hv_do_hypercall(), the test just creates a race condition=
.
>=20
> The comment in hv_suspend() should be correct because hv_suspend()
> is only called during hibernation from the syscore_ops path where only
> one CPU is active, e.g. for the suspend operation, it's called from
> state_store
>   hibernate
>     hibernation_snapshot
>       create_image
>         suspend_disable_secondary_cpus
>         syscore_suspend
>           hv_suspend
>=20
> It's similar for the resume operation:
> resume_store
>   software_resume
>     load_image_and_restore
>       hibernation_restore
>         resume_target_kernel
>           hibernate_resume_nonboot_cpu_disable
>           syscore_suspend
>             hv_suspend

I agree the hv_suspend() code is correct.  I read the second sentence of
the comment as being a more general statement that hypercalls could be
cleanly stopped by setting hv_hypercall_pg to NULL, which isn't true.

>=20
> > >  static void hv_machine_crash_shutdown(struct pt_regs *regs)
> > >  {
> > >  	if (hv_crash_handler)
> > >  		hv_crash_handler(regs);
> > > +
> > > +	/* The function calls crash_smp_send_stop(). */
> >
> > Actually, crash_smp_send_stop() or smp_send_stop() has already been
> > called earlier by panic(),
>=20
> This is true only when the Hyper-V host supports the feature
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE. On an old Hyper-V host
> without the feature, ms_hyperv_init_platform() doesn't set
> crash_kexec_post_notifiers, so crash_kexec_post_notifiers keeps its
> initial value "false", and panic() calls smp_send_stop() *after*
> __crash_kexec() (which calls machine_crash_shutdown() ->
> hv_machine_crash_shutdown()).

OK, I see your point.

>=20
> >  so there's already only a single CPU running at
> > this point.  crash_smp_send_stop() is called again in
> > native_machine_crash_shutdown(), but it has a flag to prevent it from
> > running again.
> >
> > >  	native_machine_crash_shutdown(regs);
> > > +
> > > +	/* Disable the hypercall page when there is only 1 active CPU. */
> > > +	hyperv_cleanup();
> >
> > Moving the call to hyperv_cleanup() in the panic path is OK, and it mak=
es
> > the panic and kexec() paths more similar, but I don't think it is neces=
sary.
> > As noted above, the other CPUs have already been stopped, so they shoul=
dn't
> > be executing any hypercalls.
>=20
> As I explained above, it's necessary for old Hyper-V hosts. :-)

Agreed.
