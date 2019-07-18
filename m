Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07DF6C42D
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jul 2019 03:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfGRBWn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Jul 2019 21:22:43 -0400
Received: from mail-eopbgr1300120.outbound.protection.outlook.com ([40.107.130.120]:36552
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727487AbfGRBWm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Jul 2019 21:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR0UmS6QCqLmXUknHKN+LWfyTfsUcwn6ld3ijoh3RTDt0zk8e4l27LZ8CCuIo5/T9j57M6ZMMR3B7nlEahBESJIarWhAnIM9R0WevP2hYDoXyIMtO7tRq2+WjPUv2R9+0Ab5PXho28R3ej6hVqLs9nwco1/WgFYPLvX0EoH1/UYnu/o+eGAU0RACBHH4/LWOWpbga8JFjzo1/N55n1VI/NHwddtya/aR2fPsZcGGkvUzMO2U6vgTkr0SCAEe+eyFRN7NSevdafd65FeZ04bkOKvgPbx7fJRBsqC153eW5PAlhrlo6PbQsDvG8XW9H+ZsL6+9TMMu2XzION/UrYO/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INrghvx6QgGLPW0M1Vvb6Plp2C+EXbUyZnGTqOtgRPo=;
 b=lvx9F7i3PJQbpmx4yqX7we+2syS1kGs6EOobMgKoYVGv9Xia/YeVBUUoRd5C7gtI4Wf+YDB563u/PFrjpgFm6g5IiLs19CMzC7kf0AUfO8LFNpxPzvErWj1tU4LX3d48sRjxDnj+R5BQ6tj1dOlCVpnFJDKFDMwrNZ/FUH5zF543Q2eHZGkCIb0rfZJvnwTa7iBlhr3w+zEE0USlXqxaAEyav2f6LZwWS5e+SXrAjJpgT6P2mfQuWRlMbi2B3PxUn6r/sgqYVV+PlgtPZKMK6zp3c8jP5+Bcie/fdiW5CSCiLNj+OVd5M6kv5dMNMK3quuzUDKKyaeXvs/CIdH7FxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INrghvx6QgGLPW0M1Vvb6Plp2C+EXbUyZnGTqOtgRPo=;
 b=LMkaZKuozO9+ywQ832bS3NsQNsHOc1JT/iwy4ta4GULP4mwKeW1PJtlXkjlIeoHAzdePC+dGmSeNmPcexzxjaUfmZba+2Yo5e0mCgvsVcc+lkLjUjTzutBKEVF0Q6vEPzVJH1N7LFzphnQOdm2SgttyuYs+3cmDWclr/MVrjuMk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.0; Thu, 18 Jul 2019 01:22:16 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::383c:3887:faf8:650a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::383c:3887:faf8:650a%5]) with mapi id 15.20.2115.005; Thu, 18 Jul 2019
 01:22:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
Thread-Topic: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
Thread-Index: AdUyCb6p1/Ch6raqSV2uCwYf/NBGWgK6h7yAAAMgE9A=
Date:   Thu, 18 Jul 2019 01:22:16 +0000
Message-ID: <PU1P153MB01693AB444C4A432FBA2507BBFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1907180058210.1778@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907180058210.1778@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-18T01:22:12.0208587Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2a25d370-a8e8-4bca-8fb5-f9b262d22e21;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:1ae:f803:a045:b2c5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d00ea60-f617-4ac3-ac37-08d70b1e5eec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:|PU1P153MB0153:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01532DF79E6A39FF1C9184D4BFC80@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(54534003)(199004)(68736007)(6246003)(478600001)(53936002)(14444005)(446003)(476003)(7416002)(486006)(11346002)(10290500003)(256004)(6916009)(74316002)(8676002)(81156014)(81166006)(66556008)(64756008)(186003)(52536014)(66476007)(46003)(66946007)(66446008)(86362001)(10090500001)(5660300002)(8990500004)(76116006)(54906003)(22452003)(71190400001)(71200400001)(33656002)(102836004)(99286004)(7696005)(316002)(76176011)(6506007)(53546011)(6116002)(305945005)(6436002)(8936002)(14454004)(2906002)(7736002)(229853002)(4326008)(25786009)(9686003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rJMjGD+JGNxSp2bGmacSaqKyraMDHHA98WM/0KaJe6kC9aIY3IGn0DmQT/z3pkaVEQ4pz8yOQdcy2AuTfl4Vq/Cg7OwsMZ3pKhzC7GEnt5HQz80czda7QZlbSNCEihGyupawmIYR9npBJeq9OQlvFPXJVQct5cY+j6goe0IZCFj069JIBxngodRxx8g782YLZ3ZoTjlCrojnJK7pHIj+dsAT0UAG3KyEgpSWJi0ZDqRe/CA1VNSU9ZMi0zSm8Tso/jO4ppR9Ol1dTiugFX/BXhnfPcJ8IqrLXch/SbHE9rJYgV3BYIh3O0kmaUyXPeuq/ANyJ6nuCwZncBPFgT4cOlNuNni0Yyizo0cKncfU48Fo/res5wktIEyFQs8vREAsCf2UpM+XHEV56Eij80jpgIoWS+0eNASoEhGCzBpZM3E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d00ea60-f617-4ac3-ac37-08d70b1e5eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 01:22:16.0750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, July 17, 2019 4:04 PM
> To: Dexuan Cui <decui@microsoft.com>
> ...
> On Thu, 4 Jul 2019, Dexuan Cui wrote:
> > When a CPU is being offlined, the CPU usually still receives a few
> > interrupts (e.g. reschedule IPIs), after hv_cpu_die() disables the
> > HV_X64_MSR_VP_ASSIST_PAGE, so hv_apic_eoi_write() may not write=20
> > the EOI MSR, if the apic_assist field's bit0 happens to be 1; as a resu=
lt,
> > Hyper-V may not be able to deliver all the interrupts to the CPU, and t=
he
> > CPU may not be stopped, and the kernel will hang soon.
> >
> > The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
> > 5.2.1 "GPA Overlay Pages"), so with this fix we're sure the apic_assist
> > field is still zero, after the VP ASSIST PAGE is disabled.
> >
> > Fixes: ba696429d290 ("x86/hyper-v: Implement EOI assist")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> >=20
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 0e033ef11a9f..db51a301f759 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -60,8 +60,14 @@ static int hv_cpu_init(unsigned int cpu)
> >  	if (!hv_vp_assist_page)
> >  		return 0;
> >
> > +	/*
> > +	 * The ZERO flag is necessary, because in the case of CPU offlining
> > +	 * the page can still be used by hv_apic_eoi_write() for a while,
> > +	 * after the VP ASSIST PAGE is disabled in hv_cpu_die().
> > +	 */
> >  	if (!*hvp)
> > -		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
> > +		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
> > +				 PAGE_KERNEL);
>=20
> This is the allocation when the CPU is brought online for the first
> time. So what effect has zeroing at allocation time vs. offlining and
> potentially receiving IPIs? That allocation is never freed.
>=20
> Neither the comment nor the changelog make any sense to me.
> 	tglx

That allocation was introduced by the commit
a46d15cc1ae5 ("x86/hyper-v: allocate and use Virtual Processor Assist Pages=
").

I think it's ok to not free the page when a CPU is offlined: every
CPU uses only 1 page and CPU offlining is not really a very usual
operation except for the scenario of hibernation (and suspend-to-memory),=20
where the CPUs are quickly onlined again, when we resume from hibernation.
IMO Vitaly intentionally decided to not free the page for simplicity of the
code.

When a CPU (e.g. CPU1) is being onlined, in hv_cpu_init(), we allocate the
VP_ASSIST_PAGE page and enable the PV EOI optimization for this CPU by
writing the MSR HV_X64_MSR_VP_ASSIST_PAGE. From now on, this CPU
*always* uses hvp->apic_assist (which is updated by the hypervisor) to
decide if it needs to write the EOI MSR:

static void hv_apic_eoi_write(u32 reg, u32 val)
{
        struct hv_vp_assist_page *hvp =3D hv_vp_assist_page[smp_processor_i=
d()];

        if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
                return;

        wrmsr(HV_X64_MSR_EOI, val, 0);
}

When a CPU (e.g. CPU1) is being offlined, on this CPU, we do:
1. in hv_cpu_die(), we disable the PV EOI optimizaton for this CPU;
2. we finish the remaining work of stopping this CPU;
3. this CPU is completed stopped.

Between 1 and 3, this CPU can still receive interrupts (e.g. IPIs from CPU0=
,
and Local APIC timer interrupts), and this CPU *must* write the EOI MSR for
every interrupt received, otherwise the hypervisor may not deliver further
interrupts, which may be needed to stop this CPU completely.

So we need to make sure hvp->apic_assist.bit0 is zero, after we run the lin=
e
"wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);" in hv_cpu_die(). The easiest
way is what I do in this patch. Alternatively, we can use the below patch:

@@ -188,8 +188,12 @@ static int hv_cpu_die(unsigned int cpu)
        local_irq_restore(flags);
        free_page((unsigned long)input_pg);

-       if (hv_vp_assist_page && hv_vp_assist_page[cpu])
+       if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
+               local_irq_save(flags);
                wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
+               hvp->apic_assist &=3D ~1;
+               local_irq_restore(flags);
+       }

        if (hv_reenlightenment_cb =3D=3D NULL)
                return 0;

This second version needs 3+ lines, so I prefer the one-line version. :-)

Thanks,
-- Dexuan
