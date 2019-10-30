Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB97EA4FC
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Oct 2019 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfJ3UvG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Oct 2019 16:51:06 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:50887
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfJ3UvG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Oct 2019 16:51:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mi2fkpvHtm7tMZJ4IO7Tt7F16IGDr2rVZaQwK/OGKMc/9OY6NJEAj2OIbupMnjJCPSWZzT2Sa6MEgAnQpp0ROqGYdb5r8RfJhNG1DQyxYf8xeU27k9He3jKZTFNaDcHy1QdiGWBJ2dMNVGhPjurFvtrDRlhq0KVVnCnNOhYNl3L1amdBw/4ZliuIi1MO99RsSGfX52AUH4/ErOBd2BbnZ1s+mc/1/Ep9kgDcADUDXcD8FlqLFkoKZ4GN5z3Ehi9aZ2aJyvDU5zrG1G7EvckIPW4LVuTrxLIURadKTLwP9NTHu++8/1AEVB8dadc5a+kRjlTYaYkngfxnQfOAh799gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGLih9z0gESmcZuMMyhO2NfSMF56bdmPeKpHceVZ9vw=;
 b=ZlaAIRQB2kzTHyLdNq8W4mvn8Yga+ZmiaMTPKz4p+SLjfCd5fWPxXXyfVUw3GqG60rbjUgrrMfxsXNwwLjQw61oBJllvHPqNDyCIf5MiYfYmNB5tAId4aNAQ5EbotBOK9gfCHsmhgPwGudxiJwQ/Xk4/1MXexdXoQM/3jzavmyMXq9b74FdaQLXdYAoaBlFes5MqHhwK9nnT6DocMjf0AAZQE0fLpuHn96FeldpjpY+OWBKgrjLrjaop4doKYFSRIK14dK3/IbaTsHPc97KnFLQOVZFDn8sqtyzer/AWnfkzRtqEWArRQ/HbTp0iedZIqX65gid16gIiUtnM+z63UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGLih9z0gESmcZuMMyhO2NfSMF56bdmPeKpHceVZ9vw=;
 b=K1wKIsExi5KeaQ3jRbBMwjmkzvyNUqsgN58YBvs5BMd+JGC6SVbIF8X763ZFyRhTzxTwUvsVjwmzrR2AfJ4/rqb9RUKiR5UzRY9Q66TfUvP5vibNKTPUnMsDBy/C+7xwhkJ1EI3gMSr8PNr3032+Fp1nQluIpA/QWdselLQwmz8=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0281.namprd21.prod.outlook.com (10.173.174.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.8; Wed, 30 Oct 2019 20:50:57 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9cc3:f167:bb63:799]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9cc3:f167:bb63:799%5]) with mapi id 15.20.2408.018; Wed, 30 Oct 2019
 20:50:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "Ganapatrao.Kulkarni@cavium.com" <Ganapatrao.Kulkarni@cavium.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "josephl@nvidia.com" <josephl@nvidia.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Topic: [PATCH 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Index: AQHVjTTCcywpG+T+tUGFemPgvP9gmKdx7AXggAG1ZsA=
Date:   Wed, 30 Oct 2019 20:50:57 +0000
Message-ID: <DM5PR21MB0137E1981E548E540E3D215ED7600@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1572228459-10550-1-git-send-email-mikelley@microsoft.com>
 <PU1P153MB0169592424FCCD3226B88BEFBF610@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169592424FCCD3226B88BEFBF610@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-29T20:33:43.0988779Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c0fa1d8b-e2ac-449b-a836-39e1450d2dd9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb80a5b6-c0da-4714-6087-08d75d7add5f
x-ms-traffictypediagnostic: DM5PR21MB0281:|DM5PR21MB0281:|DM5PR21MB0281:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB02812E6060FBF1656439642BD7600@DM5PR21MB0281.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(346002)(366004)(51914003)(199004)(189003)(55016002)(3846002)(25786009)(6506007)(6116002)(66446008)(66556008)(64756008)(7696005)(6436002)(66946007)(66476007)(2201001)(76176011)(76116006)(14454004)(446003)(229853002)(71200400001)(11346002)(476003)(478600001)(71190400001)(102836004)(14444005)(86362001)(256004)(26005)(9686003)(10090500001)(186003)(6246003)(10290500003)(7416002)(110136005)(2501003)(81156014)(22452003)(5660300002)(8676002)(316002)(1511001)(7736002)(52536014)(305945005)(74316002)(66066001)(2906002)(8936002)(33656002)(99286004)(81166006)(486006)(8990500004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0281;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMPGgMKCwYda4bvsQv3C9z21isiGzocW7g8gnyXZ0BIeZdz+vAcAm3VPcWD1dvoCA05oJKHsVVkadrz0WMydElaD2E66+2SeaXSRVLnooa4gpM6oDyWD44qFzBsoUX9qzDkhBqGNO0FpuG3uaB+7Hdp9CdBSEDKuM5+pOZb+C39Lcgo6wdxzpqS+51U9YTyBT0GO0VGrIIZv/MgfVjtCHtYNeHs3XNKumT4lBlkh4Wkm/+DN0wC4bUOF8D30p2FHlFld68NQUetb3f0BTGUHui1PwqBPxPUVXP/igXMYilmi7ZkYtcz+j0NSM3wZBSWLEQ2cnYs/4rAOUWBp0HyjWENWvI8mhDi1s7OPay1sdZPvbqrNHFSH/MXlSUe0LJ2B5FSsV6LHelKNvYpSGDxwFaNE/cTpfrFGwdh3E7AsTjGImfcj6cRqq36kwCWWqlwi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb80a5b6-c0da-4714-6087-08d75d7add5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 20:50:57.5424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7kQSqVRPT1I06L9eZ0FUqg/dNHmFOipIC0yCyTrAq47263PRDG8Kvp+OxX/LuluLu+d0064oGGuP6o+0GZi1acG6W4zV2UuPqK/zCdvtrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0281
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, October 29, 2019 1:34=
 PM
>=20
> Should we add the 2 lines:
>=20
> Cc: stable@vger.kernel.org
> Fixes: fd1fea6834d0 ("clocksource/drivers: Make Hyper-V clocksource ISA a=
gnostic")
>=20
> fd1fea6834d0() removes the clockevents_unbind_device() call and this patc=
h adds it back.

I thought about this, but the changes in this patch seem more extensive tha=
n
we might want to take as a stable fix.  The previous removal of
clockevents_unbind_device() does not have any negative effects except on
the in-progress hibernation work.  We really want to have this patch
go with the hibernation patches, so backporting these changes to stable
isn't necessary for hibernation support.  But whether to backport to
stable is a judgment call, and I'm open to arguments in favor.

>=20
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -323,8 +323,15 @@ void __init hyperv_init(void)
> >
> >  	x86_init.pci.arch_init =3D hv_pci_init;
> >
> > +	if (hv_stimer_alloc())
> > +		goto remove_hypercall_page;
> > +
>=20
> The error handling is imperfect here: when I force hv_stimer_alloc() to r=
eturn
> -ENOMEM, I get a panic in hv_apic_eoi_write(). It looks it is because we =
have cleared
> the pointer 'hv_vp_assist_page' to NULL, but hv_apic_eoi_write() is still=
 in-use.

This can be fixed by doing hv_stimer_alloc() before the call to hv_apic_ini=
t().
>=20
> In case hv_stimer_alloc() fails, can we set 'direct_mode_enabled' to fals=
e
> and go on with the legacy Hyper-V timer or LAPIC timer? If not, maybe
> we can use a BUG_ON() to explicitly panic?

I'll look into what can be done here.

>=20
> >  	return;
> >
> > +remove_hypercall_page:
> > +	hypercall_msr.as_uint64 =3D 0;
> > +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > +	hv_hypercall_pg =3D NULL;
> >  remove_cpuhp_state:
> >  	cpuhp_remove_state(cpuhp);
> >  free_vp_assist_page:
>=20
> > -void hv_stimer_cleanup(unsigned int cpu)
> > +static int hv_stimer_cleanup(unsigned int cpu)
> >  {
> >  	struct clock_event_device *ce;
> >
> >  	/* Turn off clockevent device */
> >  	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> >  		ce =3D per_cpu_ptr(hv_clock_event, cpu);
> > +
> > +		/*
> > +		 * In the legacy case where Direct Mode is not enabled
> > +		 * (which can only be on x86/64), stimer cleanup happens
> > +		 * relatively early in the CPU offlining process. We
> > +		 * must unbind the stimer-based clockevent device so
> > +		 * that the LAPIC timer can take over until clockevents
> > +		 * are no longer needed in the offlining process. The
> > +		 * unbind should not be done when Direct Mode is enabled
> > +		 * because we may be on an architecture where there are
> > +		 * no other clockevents devices to fallback to.
> > +		 */
> > +		if (!direct_mode_enabled)
> > +			clockevents_unbind_device(ce, cpu);
> >  		hv_ce_shutdown(ce);
>=20
> In the legacy stimer0 mode, IMO this hv_ce_shutdown() is unnecessary,
> because "clockevents_unbind_device(ce, cpu)" automatically calls
> ce->set_state_shutdown(), if ce is active:
> clockevents_unbind
>    __clockevents_unbind
>     clockevents_replace
>       tick_install_replacement
>         clockevents_exchange_device
>           clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED)
>             __clockevents_switch_state

Agreed.  This is a carryover from even before reorganizing the code
into the separate Hyper-V clocksource driver, where this code was
present in hv_synic_cleanup():

	/* Turn off clockevent device */
	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
		struct hv_per_cpu_context *hv_cpu
			=3D this_cpu_ptr(hv_context.cpu_context);

		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
		hv_ce_shutdown(hv_cpu->clk_evt);
	}

But I'll fix it.

>=20
> And, in both modes (legacy mode and direct mode), it looks incorrect to
> call hv_ce_shutdown() if the current processid id !=3D 'cpu', because
> hv_ce_shutdown() -> hv_init_timer() can only access the current CPU's
> MSR. Maybe we should use an IPI to run hv_ce_shutdown() on the target
> CPU in direct mode?

Agreed.  I'll figure out a fix.

>=20
> > -int hv_stimer_alloc(int sint)
> > +int hv_stimer_alloc(void)
> > ...
> > +		ret =3D cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
> > +				"clockevents/hyperv/stimer:starting",
> > +				hv_stimer_init, hv_stimer_cleanup);
> > +		if (ret < 0)
> > +			goto free_stimer0_irq;
> > +		stimer0_cpuhp =3D ret;
> >  	}
> > +	return ret;
>=20
> stimer0_cpuhp is 0 when the call is successful, so IMO the logic in
> hv_stimer_free() is incorrect. Please see below.
>=20
> >  void hv_stimer_free(void)
> >  {
> > -	if (direct_mode_enabled && (stimer0_irq !=3D 0)) {
> > -		hv_remove_stimer0_irq(stimer0_irq);
> > -		stimer0_irq =3D 0;
> > +	if (direct_mode_enabled) {
> > +		if (stimer0_cpuhp) {
> > +			cpuhp_remove_state(stimer0_cpuhp);
> > +			stimer0_cpuhp =3D 0;
> > +		}
> > +		if (stimer0_irq) {
> > +			hv_remove_stimer0_irq(stimer0_irq);
> > +			stimer0_irq =3D 0;
> > +		}
> >  	}
>=20
> IMO this should be
> if (direct_mode_enabled) {
>         if (stimer0_cpuhp =3D=3D 0)
>                 cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);
>=20
>         if (stimer0_irq) {
>                 hv_remove_stimer0_irq(stimer0_irq);
>                 stimer0_irq =3D 0;
>         }
> }
>=20
> BTW, the default value of 'stimer0_cpuhp' is 0, which means success.
> Should we change the default value to a non-zero value, e.g. -1 ?

Indeed, you are correct.  I was treating the return value from=20
cphup_setup_state() like the case when the state is
CPUHP_AP_ONLINE_DYN.  I'll fix it.

>=20
> >  	free_percpu(hv_clock_event);
> >  	hv_clock_event =3D NULL;
> > @@ -190,14 +274,11 @@ void hv_stimer_free(void)
> >  void hv_stimer_global_cleanup(void)
> >  {
> >  	int	cpu;
> > -	struct clock_event_device *ce;
> >
> > -	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> > -		for_each_present_cpu(cpu) {
> > -			ce =3D per_cpu_ptr(hv_clock_event, cpu);
> > -			clockevents_unbind_device(ce, cpu);
> > -		}
> > +	for_each_present_cpu(cpu) {
> > +		hv_stimer_cleanup(cpu);
>=20
> hv_stimer_cleanup() -> hv_ce_shutdown() -> hv_init_timer() can not
> access a remote CPU's MSR.

Agreed, per above.

>=20
> > @@ -2310,7 +2305,6 @@ static void hv_crash_handler(struct pt_regs *regs=
)
> >  	 */
> >  	vmbus_connection.conn_state =3D DISCONNECTED;
> >  	cpu =3D smp_processor_id();
> > -	hv_stimer_cleanup(cpu);
> >  	hv_synic_cleanup(cpu);
> >  	hyperv_cleanup();
>=20
> Why should we remove the line hv_stimer_cleanup() in the crash handler?
> In the crash handler, IMO we'd better disable the timer before we proceed=
.

With the stimer in legacy mode, the cleanup should happen in
hv_synic_cleanup().  But that actually highlights a previously unrecognized
problem in that hv_synic_cleanup() usually doesn't do anything because it
returns -EBUSY if there is a channel interrupt assigned to "cpu".  So even
in the older code before the clock/timer reorg, none of the timers or
other synic functionality actually got cleaned up.

With the stimer in DirectMode, the cleanup should probably happen in
hyperv_cleanup(), to mirror the initialization in hyperv_init().  I'll make
that change.  Fixing the legacy path is probably a separate patch
because we'll need fix the synic cleanup problem by distinguishing
between a normal cleanup due to CPU offlining or hibernation, and the
crash path.

Thanks for the careful review!

Michael
