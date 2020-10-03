Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112272825A9
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Oct 2020 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgJCRkT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 3 Oct 2020 13:40:19 -0400
Received: from mail-eopbgr760097.outbound.protection.outlook.com ([40.107.76.97]:47227
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgJCRkS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 3 Oct 2020 13:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRruLF+PVzfmaYR79mYqya5GWim/9ttHMw5Sr6jgGBKW63OCsWtARVc7LsbinYd5/YI9mZheUyCflKzAOhDkger8gWwKsSfXqvr/vaO1fjWgTWlwyRHIY92POcWBXGWONx6dwFCEIGz2euoOa0e9WEd8LSKWUQkXs+RGFU8Ucqe7NI8X9g0GdS0DyRWZCs/ynt3rprKRJG3j6KfS2juru0i+AMmZqRNpfZzTH6yLYZBwZrVez7qBva5RA3ht2brUTVuLCTgZHyKVKDn5vw1h+nHEqmi7+f1m33URxMeAQ6ACTIc2bi8u1CFWueFoEwjWIv9RvZXxx3y/fXf3LMT4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEg7Avg16aTWL7rr5jZlVHObufidXtLCAQ/kKb+70tQ=;
 b=I8p3DKpVWwPDo60cahomadGHiqaqEpxCJYqVtyyM6Z1KB7TF2ZaQKr07IIXXls0qPgxLKXzcs2wFWYGtvwrifySdC3HRuo40JCBPwaoXoCstoMui2XJVecEwtEH+uJ1AeY9w2KVwR07TN/Px3lPsqOkfEE/P/sB7Gjoq5s429ObPXoVwY8LUKNzDcqSBDQcbpP86nNo6dam4R97sHY5jssSIVuw5WrtDfd64cvvJAFzHMAR4ckeGhLna7tVefq0Lidi8K0xOjqCbJetFf9r4mmt4NjxHUwu0R7YY1B4gIJEjBfbVHqyVxyYlWCg+7U3oA7YauJM2mVt9d9EzjuFmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEg7Avg16aTWL7rr5jZlVHObufidXtLCAQ/kKb+70tQ=;
 b=epJ81wlWZYReFpUvRlYtYt5pgZKaBvIdQqzVMFwU95th+OzDTsDoFF5oXr4B85KeDt6wHhsKjCXPeVHVh3pCTlYpoP3BGYGjXBJL+UwVmkI8falKhtVOzzhAWelpvnj1je/YonOVeRZ9wXlo6hYlv2lD8L2qoLuJBLRK040Bw+A=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW4PR21MB1906.namprd21.prod.outlook.com (2603:10b6:303:67::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.7; Sat, 3 Oct
 2020 17:40:15 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::6484:cb0:bdff:edf7]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::6484:cb0:bdff:edf7%7]) with mapi id 15.20.3455.009; Sat, 3 Oct 2020
 17:40:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>, Wei Liu <wei.liu@kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
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
Thread-Index: AQHWl5OP3rUdVDGds0iX7OGOajEVWKmCfoYAgAAla4CAABOQAIADbQWg
Date:   Sat, 3 Oct 2020 17:40:15 +0000
Message-ID: <MW2PR2101MB105242653A8D5C7DD9DF1062D70E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201001013814.2435935-1-sashal@kernel.org>
 <87o8lm9te3.fsf@vitty.brq.redhat.com>
 <20201001115359.6jhhrybemnhizgok@liuwe-devbox-debian-v2>
 <20201001130400.GE2415204@sasha-vm>
In-Reply-To: <20201001130400.GE2415204@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-03T17:40:13Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=282b1f8c-038c-45c3-bbab-b78df23a5f1f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 846f2496-7d4d-4ac1-24fc-08d867c3634c
x-ms-traffictypediagnostic: MW4PR21MB1906:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1906DB68E791E1A238038978D70E0@MW4PR21MB1906.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJjLTwazSchpYVnvPUmxWRRtC2oC+t2ysI/FFKNP+nzU9PI2Vm4FGem/AYjJ8qmixLSGlEHY5wrWmKN801yesgJXo7ZB501tDTVObgo3H/wbrVoZMWNvoE+d7Jk3+yfai1HGJJVByVTFiAkXZsiTGnZUhh7e9+zyy9XpoqQgKVK09OxL8uKUBmGUQ0t7znzTEnWuE9WuzOMIypTIzdlk/gAK9+r2fLuwMUD60C2a2Fxw7qinq9EPJ7wT5O0ejYS0PsqOTBHsn5H30W1Mati1FXnuEFF6S7tii+rIko35i6vZuKmvjBfgqREOyhQET46WgU/ufDITgrrJ8FwMfpDTaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(86362001)(66946007)(9686003)(26005)(8676002)(186003)(5660300002)(83380400001)(107886003)(7416002)(66556008)(66446008)(66476007)(71200400001)(64756008)(8936002)(2906002)(478600001)(10290500003)(76116006)(82950400001)(8990500004)(55016002)(4326008)(33656002)(82960400001)(54906003)(110136005)(52536014)(6506007)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: orXYrnFf/hFNwUuEAwjHwAQ2r7gCTvTKPTufbaB/F3TgMxogD+yyeDqruIg4ODRZ0a/78UsMPINup1f1i6t8LbUAAX1qvOGd871KXuqLITrhnru+9/Fy9PY04PJBa0BqF8gpA05ixYcgroSPyaaqG+y1CXMMx6UHVO7j8phoES9z26csep+RMmWw8vvjT5xpUawtTBxaL3g5eV6ZmECh3AfGOgFKElPJfHQj2VKb/5GGky9l/XFZv6VM9PEP9VyW3lc9CRapHYyrAIKdvbWrTdwfRHrHxmgX9/743hLHdKETQJvg5vRGSJTKQ87qvbPrZNRaY0A9dLuBbIQun0TLXRCU35aut8HEN4MkFcnF5mawuM82AY94GMj4XmQmgt3O1mQvMe3SgtBlL8L/5PAXH5mHtrxEOG2w9ik/YHMDiXh3p6MA0tyFrcp6x3w55Tjz0HNpzhJ4G0ECKa0/5WCOeMxPU0oES5fL/nyIzpQEXACetEiRsg14vC1X6xRtSWhxbMXZNJF2wS32935Xw6gtEKcGal6gwQO0ZdsF6Clz+B9CFWPR4stdXEqTNwG899wvsNSplyXEC0GOHPWcYWWPUqBnig/QzwC5OlfFYR6MPA8Lks/viQG85IIyhL94mF0N83B3HbawRbTborjEodbD9Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846f2496-7d4d-4ac1-24fc-08d867c3634c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2020 17:40:15.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRmba270MV+w/F4/Hv1m1iBXrlDj5cEGjdKlbXTQYxyZb3QBL4G/LpD8xFKOgBh7OL02cSl3WmLl/acLNPxfqfmhgyYyoUbkM5G2YAm4+jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1906
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sasha Levin <sashal@kernel.org>  Sent: Thursday, October 1, 2020 6:04=
 AM
>=20
> On Thu, Oct 01, 2020 at 11:53:59AM +0000, Wei Liu wrote:
> >On Thu, Oct 01, 2020 at 11:40:04AM +0200, Vitaly Kuznetsov wrote:
> >> Sasha Levin <sashal@kernel.org> writes:
> >>
> >> > cpumask can change underneath us, which is generally safe except whe=
n we
> >> > call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we =
pass
> >> > num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to =
read
> >> > garbage. As reported by KASAN:
> >> >
> >> > [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_ot=
hers
> (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> >> > [   83.908636] Read of size 4 at addr ffff888267c01370 by task kwork=
er/u8:2/106
> >> > [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        =
W         5.4.60 #1
> >> > [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/=
Virtual Machine,
> BIOS 090008  12/07/2018
> >> > [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
> >> > [   84.196669] Call Trace:
> >> > [   84.196669] dump_stack (lib/dump_stack.c:120)
> >> > [   84.196669] print_address_description.constprop.0 (mm/kasan/repor=
t.c:375)
> >> > [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
> >> > [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71
> mm/kasan/common.c:635)
> >> > [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv=
.h:128
> arch/x86/hyperv/mmu.c:112)
> >> > [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:6=
8
> arch/x86/mm/tlb.c:798)
> >> > [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586=
 mm/pgtable-
> generic.c:88)
> >> >
> >> > Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper
> HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
> >> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> > Cc: stable@kernel.org
> >> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> > ---
> >> >  arch/x86/hyperv/mmu.c | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> >> > index 5208ba49c89a9..b1d6afc5fc4a3 100644
> >> > --- a/arch/x86/hyperv/mmu.c
> >> > +++ b/arch/x86/hyperv/mmu.c
> >> > @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct=
 cpumask
> *cpus,
> >> >  		 * must. We will also check all VP numbers when walking the
> >> >  		 * supplied CPU set to remain correct in all cases.
> >> >  		 */
> >> > -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >=3D 64)
> >> > +		int last =3D cpumask_last(cpus);
> >> > +
> >> > +		if (last < num_possible_cpus() && hv_cpu_number_to_vp_number(last=
) >=3D
> 64)
> >> >  			goto do_ex_hypercall;
> >>
> >> In case 'cpus' can end up being empty (I'm genuinely suprised it can)
>=20
> I was just as surprised as you and spent the good part of a day
> debugging this. However, a:
>=20
> 	WARN_ON(cpumask_empty(cpus));
>=20
> triggers at that line of code even though we check for cpumask_empty()
> at the entry of the function.

What does the call stack look like when this triggers?  I'm curious about
the path where the 'cpus' could be changing while the flush call is in
progress.

I wonder if CPUs could ever be added to the mask?  Removing CPUs can
be handled with some care because an unnecessary flush doesn't hurt
anything.   But adding CPUs has serious correctness problems.

>=20
> >> the check is mandatory indeed. I would, however, just return directly =
in
> >> this case:
>=20
> Makes sense.

But need to do a local_irq_restore() before returning.

>=20
> >> if (last < num_possible_cpus())
> >> 	return;
> >
> >I think you want
> >
> >   last >=3D num_possible_cpus()
> >
> >here?

Yes, but also the && must become ||=20

> >
> >A more important question is, if the mask can change willy-nilly, what
> >is stopping it from changing between these checks? I.e. is there still a
> >windows that hv_cpu_number_to_vp_number(last) can return garbage?
>=20
> It's not that hv_cpu_number_to_vp_number() returns garbage, the issue is
> that we feed it garbage.
>=20
> hv_cpu_number_to_vp_number() expects that the input would be in the
> range of 0 <=3D X < num_possible_cpus(), and here if 'cpus' was empty we
> would pass in X=3D=3Dnum_possible_cpus() making it read out of bound.
>=20
> Maybe it's worthwhile to add a WARN_ON() into
> hv_cpu_number_to_vp_number() to assert as well.

If the input cpumask can be changing, the other risk is the for_each_cpu()
loop, which also has a call to hv_cpu_number_to_vp_number().  But looking a=
t
the implementation of for_each_cpu(), it will always return an in-bounds va=
lue,
so everything should be OK.

>=20
> --
> Thanks,
> Sasha
