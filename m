Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945FAE90D5
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2019 21:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfJ2Ufk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Oct 2019 16:35:40 -0400
Received: from mail-eopbgr1300090.outbound.protection.outlook.com ([40.107.130.90]:9568
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfJ2Ufk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Oct 2019 16:35:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1tYbms5fbQirDHDEUAIsA50fGY4ywTdG45wtlS1u7J3bvch1QasoteKRLtoMtAERaFr7QtgseULNi/6DKSCLt0RqDW8rub80LLBN8i1vcD66Sx6CacBxFTPJaVlmpjpXCbB909bRIInpOaJp9zx9eUS1jriPohDw56E54LU2R0kvWKXZ1+c+OKHlN9suRD8b86dOIGARD+2xigHIcDzMemnP1THYhfonHxRlgTg8JQPfX0pHeDZfzAS7p6j0ciWFw0Q8/57/ECGysrD0rHZz7NltQLvnX7QdWLDaQ+i4e0bJw0jOqP5YciRHwad653A6srzLENYTqWteHiQMD2uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Pc/y84ms+LINoM7P53jhItcF0pSiiIH1nV50ZtbHgY=;
 b=od3hmuxhh3mIQkM068UXoQD055iZBkVNqFhrazJ8NcEDO3BjvvWPjcW8VbP44KWgdgqPfRel+fI/ItVRTn1kyjoh767M1JJLqQ/Wh7TO9E8IPaP88PoeBpb/q7bP0EQbBqlbfyLA5s0xfpyPxBTsV7rixgt/KfFYdnpoiqt3tbInJHeBvC02vTDzIiPR+7ZSiei849jato2+elfEJpKlqb7iij9GnGrFwW/+hXGCGUIzPSw7bGPj46rRhFmvyR6Hmndaf29UTvUpVBd0Y6LGO7tfanWg+JTGJOZGJEClTI/5ahmmJeBnP76rEoJkNsuHNh7Jn0dwbCrXwtX8GKFVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Pc/y84ms+LINoM7P53jhItcF0pSiiIH1nV50ZtbHgY=;
 b=ae149p71W+xMVLN+2ctjO54vapdjbAQDREtD08sUj5px6fXgysb8sB2/yswMr4v86yEPAEgaiu1H6RbanIn3jlpcYY2adfDrFv4+t2CioDE9geHmY6xveSBlAtOHiHPgsE/5bnwR3D0G6XZTs8fMrb+nqWcQd+qJSZPeFDOjoFw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0187.APCP153.PROD.OUTLOOK.COM (10.170.188.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.8; Tue, 29 Oct 2019 20:33:46 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809%2]) with mapi id 15.20.2408.014; Tue, 29 Oct 2019
 20:33:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
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
        "m.szyprowski@samsumg.com" <m.szyprowski@samsumg.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Topic: [PATCH 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Index: AQHVjTTCcywpG+T+tUGFemPgvP9gmKdx7AXg
Date:   Tue, 29 Oct 2019 20:33:46 +0000
Message-ID: <PU1P153MB0169592424FCCD3226B88BEFBF610@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1572228459-10550-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1572228459-10550-1-git-send-email-mikelley@microsoft.com>
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
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:bd0f:4dcd:2cf8:bf81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b266981f-c948-4748-8474-08d75caf4c78
x-ms-traffictypediagnostic: PU1P153MB0187:|PU1P153MB0187:|PU1P153MB0187:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01875C58E9D6E15AC6735B27BF610@PU1P153MB0187.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(476003)(11346002)(10290500003)(2201001)(446003)(8676002)(81166006)(81156014)(8936002)(25786009)(478600001)(316002)(86362001)(6246003)(14454004)(22452003)(46003)(486006)(33656002)(10090500001)(6436002)(8990500004)(229853002)(6116002)(110136005)(74316002)(99286004)(102836004)(2501003)(6506007)(14444005)(55016002)(7696005)(9686003)(256004)(186003)(7736002)(66446008)(66556008)(1511001)(76116006)(52536014)(305945005)(64756008)(76176011)(66946007)(71190400001)(66476007)(2906002)(71200400001)(5660300002)(7416002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0187;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FrdJk77NEpAYc5nVmZwTktgr1V8xM6KpZ+o+Nmz+hVUw9N39gQzHVuMn0B4GiTQiypOZriRIzl5YaRttNhPoUqjarJ3cUJdPNHCGEgBOJbZRXs0youo5qdQLXyYVOudB89+dJFQCGrNu+GsXyb7XWaQYrQHxCSElqUQU6GdP+sSElLXLONFUX2jEDYwzIlsXM/aTbkdviIDfXlH9Y0TZ9S+eF+ywEJzDq0gYfd0MEi5IHyuf+l4Nt681HsyyVLgWa7+LX6GucGp7P77o9vg96d0Hwy4ftsaQWLe7mfLY7F5mJaOBcbcxFxP1SCzWvGWbw0XpzjWn6PDDqjd2KQFNL0vQZqqzS18Rk8GxvkOJ37oE7YRWfkgobE9CV+DBx8x+BbCrc5cysvRyn+TH7FFzg2uT8vdI0WDeQHf4pUjgOgstrAVjnjCcedWvobg5c4Ce
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b266981f-c948-4748-8474-08d75caf4c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 20:33:46.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryEL13LhFPJcuXTaBdYOq9O719OFeoRk1FhrN9uRyG3z+/xgWlhS7pbB9uakqahLXdjm2L5oBjne5BXnxgX9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0187
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Sunday, October 27, 2019 7:10 PM
> ...
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Should we add the 2 lines:

Cc: stable@vger.kernel.org
Fixes: fd1fea6834d0 ("clocksource/drivers: Make Hyper-V clocksource ISA agn=
ostic")

fd1fea6834d0() removes the clockevents_unbind_device() call and this patch =
adds it back.

> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -323,8 +323,15 @@ void __init hyperv_init(void)
>=20
>  	x86_init.pci.arch_init =3D hv_pci_init;
>=20
> +	if (hv_stimer_alloc())
> +		goto remove_hypercall_page;
> +

The error handling is imperfect here: when I force hv_stimer_alloc() to ret=
urn
-ENOMEM, I get a panic in hv_apic_eoi_write(). It looks it is because we ha=
ve cleared=20
the pointer 'hv_vp_assist_page' to NULL, but hv_apic_eoi_write() is still i=
n-use.

In case hv_stimer_alloc() fails, can we set 'direct_mode_enabled' to false
and go on with the legacy Hyper-V timer or LAPIC timer? If not, maybe
we can use a BUG_ON() to explicitly panic?

>  	return;
>=20
> +remove_hypercall_page:
> +	hypercall_msr.as_uint64 =3D 0;
> +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hv_hypercall_pg =3D NULL;
>  remove_cpuhp_state:
>  	cpuhp_remove_state(cpuhp);
>  free_vp_assist_page:

> -void hv_stimer_cleanup(unsigned int cpu)
> +static int hv_stimer_cleanup(unsigned int cpu)
>  {
>  	struct clock_event_device *ce;
>=20
>  	/* Turn off clockevent device */
>  	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
>  		ce =3D per_cpu_ptr(hv_clock_event, cpu);
> +
> +		/*
> +		 * In the legacy case where Direct Mode is not enabled
> +		 * (which can only be on x86/64), stimer cleanup happens
> +		 * relatively early in the CPU offlining process. We
> +		 * must unbind the stimer-based clockevent device so
> +		 * that the LAPIC timer can take over until clockevents
> +		 * are no longer needed in the offlining process. The
> +		 * unbind should not be done when Direct Mode is enabled
> +		 * because we may be on an architecture where there are
> +		 * no other clockevents devices to fallback to.
> +		 */
> +		if (!direct_mode_enabled)
> +			clockevents_unbind_device(ce, cpu);
>  		hv_ce_shutdown(ce);

In the legacy stimer0 mode, IMO this hv_ce_shutdown() is unnecessary,=20
because "clockevents_unbind_device(ce, cpu)" automatically calls=20
ce->set_state_shutdown(), if ce is active:
clockevents_unbind
   __clockevents_unbind
    clockevents_replace
      tick_install_replacement
        clockevents_exchange_device
          clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED)
            __clockevents_switch_state

And, in both modes (legacy mode and direct mode), it looks incorrect to
call hv_ce_shutdown() if the current processid id !=3D 'cpu', because
hv_ce_shutdown() -> hv_init_timer() can only access the current CPU's
MSR. Maybe we should use an IPI to run hv_ce_shutdown() on the target
CPU in direct mode?

> -int hv_stimer_alloc(int sint)
> +int hv_stimer_alloc(void)
> ...
> +		ret =3D cpuhp_setup_state(CPUHP_AP_HYPERV_TIMER_STARTING,
> +				"clockevents/hyperv/stimer:starting",
> +				hv_stimer_init, hv_stimer_cleanup);
> +		if (ret < 0)
> +			goto free_stimer0_irq;
> +		stimer0_cpuhp =3D ret;
>  	}
> +	return ret;

stimer0_cpuhp is 0 when the call is successful, so IMO the logic in=20
hv_stimer_free() is incorrect. Please see below.

>  void hv_stimer_free(void)
>  {
> -	if (direct_mode_enabled && (stimer0_irq !=3D 0)) {
> -		hv_remove_stimer0_irq(stimer0_irq);
> -		stimer0_irq =3D 0;
> +	if (direct_mode_enabled) {
> +		if (stimer0_cpuhp) {
> +			cpuhp_remove_state(stimer0_cpuhp);
> +			stimer0_cpuhp =3D 0;
> +		}
> +		if (stimer0_irq) {
> +			hv_remove_stimer0_irq(stimer0_irq);
> +			stimer0_irq =3D 0;
> +		}
>  	}

IMO this should be=20
if (direct_mode_enabled) {
        if (stimer0_cpuhp =3D=3D 0)
                cpuhp_remove_state(CPUHP_AP_HYPERV_TIMER_STARTING);

        if (stimer0_irq) {
                hv_remove_stimer0_irq(stimer0_irq);
                stimer0_irq =3D 0;
        }
}

BTW, the default value of 'stimer0_cpuhp' is 0, which means success.
Should we change the default value to a non-zero value, e.g. -1 ?

>  	free_percpu(hv_clock_event);
>  	hv_clock_event =3D NULL;
> @@ -190,14 +274,11 @@ void hv_stimer_free(void)
>  void hv_stimer_global_cleanup(void)
>  {
>  	int	cpu;
> -	struct clock_event_device *ce;
>=20
> -	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> -		for_each_present_cpu(cpu) {
> -			ce =3D per_cpu_ptr(hv_clock_event, cpu);
> -			clockevents_unbind_device(ce, cpu);
> -		}
> +	for_each_present_cpu(cpu) {
> +		hv_stimer_cleanup(cpu);

hv_stimer_cleanup() -> hv_ce_shutdown() -> hv_init_timer() can not
access a remote CPU's MSR.

> @@ -2310,7 +2305,6 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	 */
>  	vmbus_connection.conn_state =3D DISCONNECTED;
>  	cpu =3D smp_processor_id();
> -	hv_stimer_cleanup(cpu);
>  	hv_synic_cleanup(cpu);
>  	hyperv_cleanup();

Why should we remove the line hv_stimer_cleanup() in the crash handler?
In the crash handler, IMO we'd better disable the timer before we proceed.

Thanks,
-- Dexuan
