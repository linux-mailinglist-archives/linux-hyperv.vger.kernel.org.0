Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC92EB0C6
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbhAERAB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 12:00:01 -0500
Received: from mail-bn8nam11on2130.outbound.protection.outlook.com ([40.107.236.130]:15776
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728897AbhAERAA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 12:00:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNcLkpmSazr+WoZjS06DQ1adfF/7nwsK2TpNSujdDB26C2Bv8Zl4Nfc3bJudPzvNDdkh4CTjq6ZIPDLKhXNo96YRnrRMe92aMmURf6QCUiBrtHSplMU72LQIcy0NBCqVmPiZAUdGyodrXLXfLZrTfTg9b08T4NgjXDVA5NOTW+e4/kp3K9RqGLGOO56RVchqS4e6xW4Q8grP4Ck/0Nae1lr/anQwpeTBDd+dn61M2XKJoeNaPIDpbTE0xrHGkekns36dj3b6XAewUskwDZeIzbmoqtuq6vAbMkXmCcYsSTEdt2vzY0xrcK6sV9S10JMwvl7kpotuMjLswopNUVNAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHuwLMWS/rhQFZ4c/nGZMEwqRRcsqhvRaeMP60lic5U=;
 b=dztjREVAj6LrNLFnceh9Is93Ngjk0UJnZdXo2U4wgSgNnY8nQxBdCF8Jr1Y7+1DmH/5u7l4CAZ4852pL3OL+vsB3MJwPHqA3D07dPKrc/pWRkMg5ib4HY8CoCY5u4hlQekWaSbxkbMBbZsJdexCFR8W/gWF/j1jC0/QGhB3jnJ2FvIXV/2aGwAnLGoL4bFvgD3AAwnntp7AeBD9ETgGHYQbdozURWIsKeb5K3G/6ZkfMHc7RW3d0JUxTUByI3cSVudMGoM+CM2c49ipInZ0aEIjeug5vmnkUD21nTW9O9HE0+Ny+Bhqr2Protz3xR1cDr0RxN2zqovZa8M7C0krXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHuwLMWS/rhQFZ4c/nGZMEwqRRcsqhvRaeMP60lic5U=;
 b=Zu+NtU++HFJAm7RGcGeSnd3eSePOiWTW0HOrK0sry18ZCdbR6TW6ZDkUkrjaRTEaamXRd30PFl9SQCtwk5Dr1JewMN4AP1/zcUE6hjp888rCkc+UUdV1+grsx+74+rEXmbhwV/CLgzXqQu4q70yG7+oKr73fsq8MnDGnsfkZloQ=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Tue, 5 Jan 2021 16:59:10 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e%5]) with mapi id 15.20.3763.002; Tue, 5 Jan 2021
 16:59:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Sasha Levin <sashal@kernel.org>, vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AQHWl5OP3rUdVDGds0iX7OGOajEVWKmCfoYAgAAla4CAABOQAIADbQWggAL8ZYCAkLahwA==
Date:   Tue, 5 Jan 2021 16:59:10 +0000
Message-ID: <MWHPR21MB1593B4387204C522536F80CCD7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20201001013814.2435935-1-sashal@kernel.org>
 <87o8lm9te3.fsf@vitty.brq.redhat.com>
 <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
 <20201001130400.GE2415204@sasha-vm>
 <MW2PR2101MB105242653A8D5C7DD9DF1062D70E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <20201005145851.hdyaeqo3celt2wtr@liuwe-devbox-debian-v2>
In-Reply-To: <20201005145851.hdyaeqo3celt2wtr@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-05T16:59:07Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64f53dd1-5ee4-4719-9fe0-1525d9e25249;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31c38c20-2380-4650-8e0e-08d8b19b38d7
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1956BC8064B8507BD8024744D7D19@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlv8ALO3/JjOtX/FwOpk8T2EV11edOxOJQNxV5mZK/95RcpLpokTw1RnPtBhwNiTsvEGATmPdph2lyfeMGv6C/tbLfqzZH8jN7Agfhh2uW4t5/XM3E1hyRh+6IgAPWxVG9wLgojKYVxmZwkiTimXNXN4JyLmKQXD9Lj9vw8CZ5o87vtHRLTv4X9K4ZsGQ8yzb5J84gz9mE38EqTiAuRdh3fQWR4nwctehFW1UqAI76f8VLLkOihH9K9LEieCu4p1JiB4aBUlVPqy4Pj8GAEYCEX7mDVXDQ+/6wmCOLLwsUOaB8MDoKkpt6N12z/BvljZlRgraK7v34PGsXy6ggcDkv/qNVF9deMv4bt7nq3coNx/xMiS7iuOfMdwEcjYppLmsRFwmlzRR5fMyegA/qqyuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(66946007)(86362001)(4326008)(54906003)(76116006)(6916009)(498600001)(10290500003)(66446008)(5660300002)(8676002)(71200400001)(82950400001)(66476007)(82960400001)(33656002)(64756008)(2906002)(7696005)(8936002)(9686003)(66556008)(55016002)(26005)(52536014)(8990500004)(6506007)(7416002)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xYOqJlJu9of9+qx2GYYotkm6j3izFihBKGBQktfkW2cs39LfAAYFEIpaxsyz?=
 =?us-ascii?Q?1nIKwel4WIAhoKAY2o1obahdjHs0JX3p/6pnhyUB/siwgE0gFCLZTs0at3NJ?=
 =?us-ascii?Q?gZtRmaQcSk5Pj6pjauRWrYvi77ee6fX9t94xodTWXtGCWgGPmKwdYE0n0tFt?=
 =?us-ascii?Q?fg+UtkxZlsfqc8sDCkd757AuUxyENSDEluRz7gYq26WeC/UogF/HKNFH7Cdp?=
 =?us-ascii?Q?8Mg5oKikLFZTsxrsXDYtrsDJ3sD+GeyYbYCTPJA5q3RB7L7n4jwuUVf5/cUT?=
 =?us-ascii?Q?lOf25z4/33XxIR8QY+V/csoloXx4ZfKJNDSDldSUS+qUcqVTJUgjVk2guMFz?=
 =?us-ascii?Q?zFiQ+lt1lJWlVC+USDZ7SeT3+sTAkw7/nFesmGvPBRJUu+0kupNWx8BpSNG0?=
 =?us-ascii?Q?QwbIqklmJbmzi0CK3q7ksgIXSZ3n/f4VRn5MZfw7+afw+jiX03r/eE5URPAV?=
 =?us-ascii?Q?LWWAemt4uvBigm7XtxoEfaqkPo3QSpHxK2SAwJ5W925KFEb+QPc0RiykQ/Bx?=
 =?us-ascii?Q?ekPKkrrX5lM3vPh/qBR3RhfW2rColSWOOerUZSP+6/IJxc4rxaixSvB778ht?=
 =?us-ascii?Q?/Yd8o0TPZk0ndxKlXRPBP7Rw9ArftAw5oWGqCgmv2h8YnNjQcUit5HoZ/onA?=
 =?us-ascii?Q?L94wzQNT72nYTjDU9vk85nGBqMhid/e+aVYw1EaVIX1CFdEmq3FVHjXX6YfC?=
 =?us-ascii?Q?FLCCQiVET1qKwUoFU5oBQv/ev7H55Ko1BEB/Ta2Ukvgja5DWi2b7Pi2DwqCP?=
 =?us-ascii?Q?4wctGRCczgQg8ql0qa0dwFxpFWv53ZKkZgHLJSmtY0MKESL7/5qnzmWxpo3Z?=
 =?us-ascii?Q?FtvgvEnvErl3//LrEQZ3yz9cbXooxmNhKc/hG3hw4vegZKkQj4hCjtR6ZBQ/?=
 =?us-ascii?Q?L45cLdSyfKwF569RpisDipkkwfZ1zFkl48JprKz3RpvJo0gWRcroxnA9wzXa?=
 =?us-ascii?Q?ZN5pE3FeThUJw46MfX8bcfXq87TPnzW8wfFg6CIuIO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c38c20-2380-4650-8e0e-08d8b19b38d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 16:59:10.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKkscg7thfLL6v5VlL4uSibK0i1deUvEml4qfRKtpnJnDZT8dVdHN8zMqLRsdd7S+yvIdbTE7n2+5TJ8x64VGvFAsa3YwaakxyLCo909nfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Monday, October 5, 2020 7:59 AM
>=20
> On Sat, Oct 03, 2020 at 05:40:15PM +0000, Michael Kelley wrote:
> > From: Sasha Levin <sashal@kernel.org>  Sent: Thursday, October 1, 2020 =
6:04 AM
> > >
> > > On Thu, Oct 01, 2020 at 11:53:59AM +0000, Wei Liu wrote:
> > > >On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
> > > >> Sasha Levin <sashal@kernel.org> writes:
> > > >>
> > > >> > cpumask can change underneath us, which is generally safe except=
 when we
> > > >> > call into hv_cpu_number_to_vp_number(): if cpumask ends up empty=
 we pass
> > > >> > num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it=
 to read
> > > >> > garbage. As reported by KASAN:
> > > >> >
> > > >> > [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tl=
b_others
> > > (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> > > >> > [   83.908636] Read of size 4 at addr ffff888267c01370 by task k=
worker/u8:2/106
> > > >> > [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G    =
    W         5.4.60 #1
> > > >> > [   84.196669] Hardware name: Microsoft Corporation Virtual Mach=
ine/Virtual
> Machine,
> > > BIOS 090008  12/07/2018
> > > >> > [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
> > > >> > [   84.196669] Call Trace:
> > > >> > [   84.196669] dump_stack (lib/dump_stack.c:120)
> > > >> > [   84.196669] print_address_description.constprop.0 (mm/kasan/r=
eport.c:375)
> > > >> > [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
> > > >> > [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71
> > > mm/kasan/common.c:635)
> > > >> > [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshy=
perv.h:128
> > > arch/x86/hyperv/mmu.c:112)
> > > >> > [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt=
.h:68
> > > arch/x86/mm/tlb.c:798)
> > > >> > [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h=
:586 mm/pgtable-
> > > generic.c:88)
> > > >> >
> > > >> > Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper
> > > HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
> > > >> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > >> > Cc: stable@kernel.org
> > > >> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > >> > ---
> > > >> >  arch/x86/hyperv/mmu.c | 4 +++-
> > > >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >> >
> > > >> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> > > >> > index 5208ba49c89a9..b1d6afc5fc4a3 100644
> > > >> > --- a/arch/x86/hyperv/mmu.c
> > > >> > +++ b/arch/x86/hyperv/mmu.c
> > > >> > @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const st=
ruct cpumask
> > > *cpus,
> > > >> >  		 * must. We will also check all VP numbers when walking the
> > > >> >  		 * supplied CPU set to remain correct in all cases.
> > > >> >  		 */
> > > >> > -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >=3D 64)
> > > >> > +		int last =3D cpumask_last(cpus);
> > > >> > +
> > > >> > +		if (last < num_possible_cpus() &&
> hv_cpu_number_to_vp_number(last) >=3D
> > > 64)
> > > >> >  			goto do_ex_hypercall;
> > > >>
> > > >> In case 'cpus' can end up being empty (I'm genuinely suprised it c=
an)
> > >
> > > I was just as surprised as you and spent the good part of a day
> > > debugging this. However, a:
> > >
> > > 	WARN_ON(cpumask_empty(cpus));
> > >
> > > triggers at that line of code even though we check for cpumask_empty(=
)
> > > at the entry of the function.
> >
> > What does the call stack look like when this triggers?  I'm curious abo=
ut
> > the path where the 'cpus' could be changing while the flush call is in
> > progress.
> >
> > I wonder if CPUs could ever be added to the mask?  Removing CPUs can
> > be handled with some care because an unnecessary flush doesn't hurt
> > anything.   But adding CPUs has serious correctness problems.
> >
>=20
> The cpumask_empty check is done before disabling irq. Is it possible
> the mask is modified by an interrupt?
>=20
> If there is a reliable way to trigger this bug, we may be able to test
> the following patch.
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 5208ba49c89a..23fa08d24c1a 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -66,11 +66,13 @@ static void hyperv_flush_tlb_others(const struct cpum=
ask *cpus,
>         if (!hv_hypercall_pg)
>                 goto do_native;
>=20
> -       if (cpumask_empty(cpus))
> -               return;
> -
>         local_irq_save(flags);
>=20
> +       if (cpumask_empty(cpus)) {
> +               local_irq_restore(flags);
> +               return;
> +       }
> +
>         flush_pcpu =3D (struct hv_tlb_flush **)
>                      this_cpu_ptr(hyperv_pcpu_input_arg);

This thread died out 3 months ago without any patches being taken.
I recently hit the problem again at random, though not in a
reproducible way.

I'd like to take Wei Liu's latest proposal to check for an empty
cpumask *after* interrupts are disabled.   I think this will almost
certainly solve the problem, and in a cleaner way than Sasha's
proposal.  I'd also suggest adding a comment in the code to note
the importance of the ordering.

Michael




