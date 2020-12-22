Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001222E03A0
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Dec 2020 02:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgLVBEv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Dec 2020 20:04:51 -0500
Received: from mail-dm6nam12on2090.outbound.protection.outlook.com ([40.107.243.90]:11469
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbgLVBEu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Dec 2020 20:04:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK8ZqXcrjzJwInj6i1IvXRhor6+LPKqCUHFcE+2BMP46cavi9+MyJ6rpNMpCg1ggqOQsVfVOsK7pPMDPe1mvIGbyo52a/poLtZjtpvDcP2Mic3Md+Zl72rlSMpIP0eq+ybwo8W2s5n/5JqAwD0eKOtv83JtzkVK8VVsmhx5I87+Mh4fk9uk89EXPYPIwQX/JYlQgUTz1tFmkCdb15vWxHLeqLqFjacLfyRW/rfy3Pzn4Dxueud4y3Iq/6/hPjm9zQ8CAm/3Kn5ILm+urhZ6ZrHtwxLVW0gqXmhlExIwVZae0F+yZXij7d1KUZpC3p/oDPNp1foUjPA1ESonFo2omJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EiaokHS+21aukhMU2ogp+bNyFp45BtgD07dFJNp3IQ=;
 b=h6zM/HKt/3xHFzzYbl/sObBR8lR9plV4Fj3R+6sntec48I4gsFu3FlvJju+B43M5jT4lIo0BBIvTXpz0eiOKs2uCGY1Eo2fxJXCexUwAtc3tdoglbDrqRaZV/HLgGCt2oNI75DlIGcDE5NeYLGP8u04F/aWrnWqDfDRuGxVljGrwaRQSzloWdsSZTh+tpE3Gz5ROts8Fewu2O8H+besr1phNccTzvzaFlQIQGAsJnnbdZNAzYbDLHqa2B2oJhZKxLwWxaynKsf+zHqxCdN+f/PVGOQi3tFtIPsfDOftrsYmWrUMTKDImhhPU9UuEhjAK0PWQrGBD0BbTHhmaHYg0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EiaokHS+21aukhMU2ogp+bNyFp45BtgD07dFJNp3IQ=;
 b=Fr2VU4NNtk5MIt+DqUHY8nOUqq4P7DM+owCCsz1KqgW5wINVh9YS8FpQRL1PXsfZUW02d18ixsZRviSzWwDVTsf8SKhyd57BHzPd/L4V5YXoOXAcdE2y404SAmqcbREiYVQ8QAvl0Jj81mZPxchK8V0h/+e/z/nj6W7ZP0YSZgQ=
Received: from (2603:10b6:303:74::12) by
 MW2PR2101MB1051.namprd21.prod.outlook.com (2603:10b6:302:a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.6; Tue, 22 Dec
 2020 01:04:00 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3721.008; Tue, 22 Dec 2020
 01:04:00 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
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
Thread-Index: AQHW1x+4gDeU8wnI6U2zhrRpW1B6M6oCL5eggAAJtpA=
Date:   Tue, 22 Dec 2020 01:03:59 +0000
Message-ID: <MW4PR21MB1857877C13551B1618852F59BFDF9@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <20201220223014.14602-1-decui@microsoft.com>
 <MW2PR2101MB1052192A1BC63A1A3DC196C6D7C09@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052192A1BC63A1A3DC196C6D7C09@MW2PR2101MB1052.namprd21.prod.outlook.com>
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
x-originating-ip: [2601:600:a280:7f70:3591:4820:2a8b:862]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0c5bf74-819c-42bf-91cc-08d8a6157763
x-ms-traffictypediagnostic: MW2PR2101MB1051:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB105114F54164CDB502CEF41DBFDF9@MW2PR2101MB1051.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kh0nsBLdjtaTkH76T8ehWtDfH/mEA1nSYfHNwsmDqQAg+EFFc6KzF4zMstpvPmo93q1xjefy6KH+Zwnp0aV8OJEsMcfzF/EQ/Y4RJpPVcg3JNrAk6Mcg5jUj2zB9h89m1Yp1b7mEhNmgAJxSfwCt/Lk+wk6e9t44UiSQL+wQ03j0CdjHRUtYJRIzUUGhsdtjtsW9dGsfHDfLgDGyrxalth+JQ4toFSL9aFU3vNpmdBkrEkTynhmmTbUZTa4mTCxNLAj+6DeYHm1NuAPj3T1d7sjODVZ5LahvgWxJVyWtCn3chS2Mk6SlAYhlwgAjCaNQaghcK4Vp6R2TtrdW3kp3ZWO4f4R7tcikNS3O8+K9ltKuv8xIQ1k+eUDk4h03iyDfmDGMNZpISVkIYo6NqFAsGtDFjI38tGhSuaFWAwhEDqz4P7vOIrM8k5/UMBMqzhdM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(7416002)(6506007)(55016002)(478600001)(83380400001)(9686003)(71200400001)(316002)(4326008)(10290500003)(8676002)(86362001)(8990500004)(52536014)(186003)(33656002)(66946007)(66446008)(2906002)(107886003)(110136005)(921005)(66556008)(54906003)(82950400001)(64756008)(7696005)(66476007)(8936002)(76116006)(82960400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PWmKqnijsFj1AxNuA97lcdGIrYL8CHuJoqFEgD8hh98GY36Df0rSHYK9ijQhHuKHEokk8zk0togiP7zVBz5OUz1YWWXB//ugkW4P0AJvsLVY5PyqNir1fdPLeTJKOIYPWS4t/0i0Wg/HNhtApQyRop5sZqqNtVKoYn0WFSrgc31NhGz8NPR09XCwOEPtc9Y1yyt3j6hgalKGdvKfOgDEndquWGoo/OB87J2UJ5JM9cYS3J3aS8kOqQkoYgrqkJXJGseVs4QyxAbfrTP6Zx411FIfZA0qwtxi59WACE33Rjq8G65ExyHx/oONM5A5cm1wdgTY3aPdIPta8GY/Ci8eNnEgscSH0LA4Hhzh/CVaTM9AHI95ab7rgS588nsZIunBcnDFKaSBD1vWp+IRbe28aNkexPBDETX3grRMxPlXGKDYPqoSCeYEgcFUpuRKwEkvVrorPNcUgmsKCUA6JKKs133YsdIRPUk5+FQwBt38xZpV2FfjOIrgdJgQ3LSXrHePqKezz72IZkXWy+N71F9v8cXr3Ru3oBhMfrlNsGhtjdJHoXNryj0A5HWYy3enCQpcBiskx4/MF1VatBYnarvXF2ykk2pjf3TDLvL0RJruzO9lxlNQiwJVMgMwxSbrUu21Dqt0g7h6XpykTbmgk+769QgW7LppbSy2yUcvu7etFUH19AbVSkI+EazhN5OWiwfzUHt5W2oQkWDv3XT4DIz6l+jw6hgDb1e8gVAGTa4plcBxzjeRyGCV9x6/4f9Pdh27B98JqvZDxGo1V81uttQ8zkj0h/SdYpNkj/+Wb3xUQTc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c5bf74-819c-42bf-91cc-08d8a6157763
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 01:03:59.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CC/y+X4V6/LNejES97tm9O8KArudU+AgD2X4ZgNeuwgTl4uXpzoStIRZy/vczwg2goqMPW/ck7HUfaSSArg1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1051
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley
> Sent: Monday, December 21, 2020 3:33 PM
> From: Dexuan Cui
> Sent: Sunday, December 20, 2020 2:30 PM
> >
> > Currently the kexec kernel can panic or hang due to 2 causes:
> >
> > 1) hv_cpu_die() is not called upon kexec, so the hypervisor corrupts th=
e
> > VP Assist Pages when the kexec kernel runs. We ever fixed the same issu=
e
>=20
> Spurious word "ever".  And avoid first person "we".  Perhaps:
>=20
> The same issue is fixed for hibernation in commit ..... .  Now fix it for
> kexec.

Thanks! Will use this in v2.

> > for hibernation in
> > commit 421f090c819d ("x86/hyperv: Suspend/resume the VP assist page for
> hibernation")
> > and now let's fix it for kexec.
>=20
> Is the VP Assist Page getting cleared anywhere on the panic path?  We can

It's not.

> only do it for the CPU that runs panic(), but I don't think it is getting=
 cleared
> even for that CPU.   It is cleared only in hv_cpu_die(), and that's not c=
alled on
> the panic path.

IMO kdump is different from the non-kdump kexec in that the kdump kernel
runs without depending on the memory used by the first kernel, so it looks=
=20
unnecessary to clear the first kernel's VP Assist Page (and the hypercallpa=
ge).
According to my test, the second kernel can re-enble the VP Asist Page and=
=20
the hypercall page using different GPAs, without disabling the old pages fi=
rst.
Of course, in the future Hyper-V may require the guest to disable the pages=
 first
before trying to re-enabling them, so I agree we'd better clear the pages i=
n the
first kernell like this:

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4638a52d8eae..8022f51c9c05 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -202,7 +202,7 @@ void clear_hv_tscchange_cb(void)
 }
 EXPORT_SYMBOL_GPL(clear_hv_tscchange_cb);

-static int hv_cpu_die(unsigned int cpu)
+int hv_cpu_die(unsigned int cpu)
 {
        struct hv_reenlightenment_control re_ctrl;
        unsigned int new_cpu;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index 30f76b966857..d090e781d216 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -76,6 +76,8 @@ static inline void hv_disable_stimer0_percpu_irq(int irq)=
 {}
 #if IS_ENABLED(CONFIG_HYPERV)
 extern int hyperv_init_cpuhp;

+int hv_cpu_die(unsigned int cpu);
+
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.=
c
index 43b54bef5448..e54f8262bfe0 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -156,6 +156,9 @@ static void hv_machine_crash_shutdown(struct pt_regs *r=
egs)
        if (hv_crash_handler)
                hv_crash_handler(regs);

+       /* Only call this on the faulting CPU. */
+       hv_cpu_die(raw_smp_processor_id());
+
        /* The function calls crash_smp_send_stop(). */
        native_machine_crash_shutdown(regs);

> > 2) hyperv_cleanup() is called too early. In the kexec path, the other C=
PUs
> > are stopped in hv_machine_shutdown() -> native_machine_shutdown(), so
> > between hv_kexec_handler() and native_machine_shutdown(), the other
> CPUs
> > can still try to access the hypercall page and cause panic. The workaro=
und
> > "hv_hypercall_pg =3D NULL;" in hyperv_cleanup() can't work reliably.
>=20
> I would note that the comment in hv_suspend() is also incorrect on this
> point.  Setting hv_hypercall_pg to NULL does not cause subsequent
> hypercalls to fail safely.  The fast hypercalls don't test for it, and ev=
en if they
> did test like hv_do_hypercall(), the test just creates a race condition.

The comment in hv_suspend() should be correct because hv_suspend()
is only called during hibernation from the syscore_ops path where only
one CPU is active, e.g. for the suspend operation, it's called from
state_store
  hibernate
    hibernation_snapshot
      create_image
        suspend_disable_secondary_cpus=20
        syscore_suspend
          hv_suspend

It's similar for the resume operation:
resume_store
  software_resume
    load_image_and_restore
      hibernation_restore
        resume_target_kernel
          hibernate_resume_nonboot_cpu_disable
          syscore_suspend
            hv_suspend
=20
> >  static void hv_machine_crash_shutdown(struct pt_regs *regs)
> >  {
> >  	if (hv_crash_handler)
> >  		hv_crash_handler(regs);
> > +
> > +	/* The function calls crash_smp_send_stop(). */
>=20
> Actually, crash_smp_send_stop() or smp_send_stop() has already been
> called earlier by panic(),

This is true only when the Hyper-V host supports the feature
HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE. On an old Hyper-V host=20
without the feature, ms_hyperv_init_platform() doesn't set
crash_kexec_post_notifiers, so crash_kexec_post_notifiers keeps its
initial value "false", and panic() calls smp_send_stop() *after*
__crash_kexec() (which calls machine_crash_shutdown() ->
hv_machine_crash_shutdown()).

>  so there's already only a single CPU running at
> this point.  crash_smp_send_stop() is called again in
> native_machine_crash_shutdown(), but it has a flag to prevent it from
> running again.
>=20
> >  	native_machine_crash_shutdown(regs);
> > +
> > +	/* Disable the hypercall page when there is only 1 active CPU. */
> > +	hyperv_cleanup();
>=20
> Moving the call to hyperv_cleanup() in the panic path is OK, and it makes
> the panic and kexec() paths more similar, but I don't think it is necessa=
ry.
> As noted above, the other CPUs have already been stopped, so they shouldn=
't
> be executing any hypercalls.

As I explained above, it's necessary for old Hyper-V hosts. :-)

Thanks,
-- Dexuan

