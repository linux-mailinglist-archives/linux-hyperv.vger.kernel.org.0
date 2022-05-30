Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8884537368
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 May 2022 03:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiE3BvZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 May 2022 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiE3BvY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 May 2022 21:51:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2105.outbound.protection.outlook.com [40.107.93.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412615A32;
        Sun, 29 May 2022 18:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikEP8CkEPxWf+haw25aphwbrBrnAxnQyNEI5DMXni+OrUigxvqh3ywtFXs1liraSngnkrcR9SXBNcF0W9gFHLHutXFnAq5CWmTrXQuZMTZR6bczjyKrbqM9ptZE+YAKmbXgs4HguKHS9Se+wMBnGpN7wmCwbNG98UJTb/mt9I6q/6moqV0G+sniKy/Vf90MhsjvwwH+CD79sAD+BuqGNBsC1xyEv9SYsblpYyeuYA8gzjDP004+6R3h/tJ0zaNho+OEGCiB9ysnt/G7UgaIhzRKWHqwCaH1R5cRHzvX2An6hInRpGELxIzudRkEPoJZfaJ9p+wUiQ/RdsaWvRx0yAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4hiACvb0AEoSH44Xd0UDMC9an+Z/qkaBoc5Mwtgz70=;
 b=cm3b6bmUAjnt85GpwTFeGGtQYoqXi+mmJsjtkfh+FoYOOL3aXGtumuAZ2XSbnkpWmD8NsEEqIJ+ytEm15BTagDzHFsrUfPgpU3uIC5odI9lD8dEG3xjveHFpy6U19yJpZc/RMAeDdMX4HJIVVnVldVmTDoJHhusQlpbyZCv4Y6jaWKpuf82qcqOC/g24M9gJxS4s6fn/dAE4jahNC5/SdOfziInrHLTtG1fYUm1B9DeboVSW9rKJqwSCmSp0+ng8qYB1PKl9eTMUtxqCPbd9vXjftHzJujCvOV5aJtttVUC4V6fVLjx087hhhAsTW91QKKhJ1G5SYiq6O1l31GWeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4hiACvb0AEoSH44Xd0UDMC9an+Z/qkaBoc5Mwtgz70=;
 b=AdZDwjwrH/hCpoBbt6AtTiDFUJ18VQk//B+xTmciiLuEAGw35/fYPddoLCCFxBIETdRQ4MmLzxqiAmPerlNvKTUhOh9BtLDs1KXtGCl1q5lXs543MnEs3NMFiUL1HhAKJFR39JRpY7CwLapnOPUOKXpxItFM2SR9BLPO2fk09o4=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SA1PR21MB2033.namprd21.prod.outlook.com (2603:10b6:806:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.1; Mon, 30 May
 2022 01:51:19 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.001; Mon, 30 May 2022
 01:51:18 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Mark Rutland <Mark.Rutland@arm.com>, vkuznets <vkuznets@redhat.com>
CC:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: Should arm64 have a custom crash shutdown handler?
Thread-Topic: Should arm64 have a custom crash shutdown handler?
Thread-Index: AQHYX/GxujbHBQtBJEmfRmGGexueBq0P47kAgABYF4CAAAKAAIAAA1YAgAANKACAAAsMAIAABZQAgAFR8oCAJQEPMA==
Date:   Mon, 30 May 2022 01:51:18 +0000
Message-ID: <PH0PR21MB30250B4F25FF4F40436F2E53D7DD9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
 <92645c41-96fd-2755-552f-133675721a24@igalia.com>
 <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
 <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com> <878rrg13zb.fsf@redhat.com>
 <YnPf3KPBXDNTpQoG@FVFF77S0Q05N.cambridge.arm.com> <87y1zgyqut.fsf@redhat.com>
 <YnUAB9gkv5SBk4p6@FVFF77S0Q05N>
In-Reply-To: <YnUAB9gkv5SBk4p6@FVFF77S0Q05N>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8b0b6df2-277d-4d87-99c3-d40e057dbc48;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-30T00:06:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a597a0d7-1f5c-44d3-ee14-08da41dee3dc
x-ms-traffictypediagnostic: SA1PR21MB2033:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SA1PR21MB2033C768543D7C01FDF60A05D7DD9@SA1PR21MB2033.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQuVI+udSEJL8NBjJDldrtrgsCSilFseFforzN51b0GVApitb/xzBO6pwV8aPEH9T41xaot95eJ+GqASiqaFKNKXYzzQFgFXAxTy3pOlU1DJPwh4jJFkHnDU+R+J51l9jZx+eu5836QCmw+KjqyC3xhlI32+S5gQn05PCenQPES5Smgvc5E9H4IJ80CczY+QmPvx6gDFOO+LMybsl2VOrdWKbiiLRoiczconfFEWeSBpW9A6CQbOKwMT8EBvYFQX9XZmuyGSxWU7I1uyDG3zNgOO1DAxYOvRlaPVwmtUTos5i4dBlxzF+BphNcHHBx1DTo/GRSty60v2YvV59UkZkljoWq5YKVwzDfpWrz2Y457GGs7oQMm3/rXRFw1/OBPADIxM5rR8/PHPhisCBSZTT87HlqFVLMQRV7F7bttT9uYHX5uh2cnC81OhIHIU8abBXy9kiBAdUbnVx8jy1arTGwFWi61Dv6jted2ovSiTsC3bV65oZ3zWN9hdKv8/KWu4NMNT2Sx1Bezzg3uTtQwQAQO/qblJxGK8+bHYdnlemRhgRGBL/Rgv8YL795nHAPvsXOK33azsJ0W958k7NZoYlup5PoHRnwfMQFNtlcAR32+DoA7LcIZNRVjQntVcVIgRzXMBTSH1b75GmnUCVkp4PW7Rw7XKfbfkgzaiKz1ku5c8gf4Vrg5mVVem2EMPNPjEZKL1THdLgQi42Ir7ADYmBpJb50ULXVZf1Qg9uEwAZm0YjtDyfC9up8KBSSqfGfGM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(55016003)(66476007)(64756008)(66556008)(66446008)(10290500003)(54906003)(508600001)(53546011)(26005)(8676002)(4326008)(76116006)(86362001)(66946007)(7416002)(110136005)(8936002)(186003)(83380400001)(316002)(38100700002)(2906002)(52536014)(82960400001)(82950400001)(122000001)(38070700005)(6506007)(9686003)(7696005)(8990500004)(33656002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GGI9m5VHdS8B3o+w12unxDBzgOf+qWqzR9GG60vezvwKmUJDSjPVe1jjaAuN?=
 =?us-ascii?Q?LI74ZNxkwzxaaSjelJ+yls4oRGgACwT3lMiIPs51kKu7eql6QLa8QOIHDFf/?=
 =?us-ascii?Q?1MNCUTtJlQaEJcTyVzcNYsWDiP+xabUWXNLjZOVJjk7PEKiJ7WSAYtpQ2xJG?=
 =?us-ascii?Q?u/6cwuEv38rZv+mKDsO6SPrT0NMGpnyxYUaMIGtl+S5XU2qcWqJ1NVLQ164K?=
 =?us-ascii?Q?Tm5oKmbxpEtf+P7XdZ4GMbjpPYv0BSkSpx+mMQvOw+hSLI3o5D4p7cwhsLaJ?=
 =?us-ascii?Q?WH5a0JfaI9VDcTaLzLU+3XEeosBh8HQ2Vy6Omw156Uo8NUa97RBA3xlCj2eN?=
 =?us-ascii?Q?2JHeh9mlC8uDbsjyBU6uggskM6wUFfscwT873O8xhNTE1NZt0k1USQn9+8hI?=
 =?us-ascii?Q?I1tMXWo1o1ygMlrN8yzL7K0LwuiKMR7cnVCMK6RP14qldOovMNqjkXR6kNaO?=
 =?us-ascii?Q?bxdWGwet6o1WCKWitoDlFZ0ouKYUYObgoh5oXq+aczd2ZYIHGY95YeKkulF3?=
 =?us-ascii?Q?8BeqffhhvVtV8uEXaPONYjCIDkmdWIii6/pQR42uthqJF1sYgM9/s8zVEG4w?=
 =?us-ascii?Q?B4aKZP9sGL1m5pMPGh40Oh6NdYfnegGSqnVQeMYe208GAFmTXME7UWZ1rw3e?=
 =?us-ascii?Q?aeUON0Cu4ezVdfFcIf0B4qP3ESEpOR4DnsoPz4kjLsT8xFwrnBy0sqed5i3L?=
 =?us-ascii?Q?msTO+xSp3+OJ1wuh3rgYpUEdLW5XCLSU3OpGCUzVd/MBx71NUQ5I7fptmchZ?=
 =?us-ascii?Q?LNliET6nlKHPL8WI8twdbjW6R32px4NP+zbCEO1MrxnUzmdl3c9aWGSLdvIa?=
 =?us-ascii?Q?wFQAL/zMBGUNcmGYBa28aD+df6IUEylZA+xb3LH7FT/f1YK9ca64UhBI/T4V?=
 =?us-ascii?Q?vDPDm0ISvxJ3xq2bFhEKMQaCNAewoIQ6DrfHMK+F2jwe54JaERfEoxzw92o/?=
 =?us-ascii?Q?RPIN50decva2Cgv9t4Um0SSKh+wv7GXtu//N6HTJwnKG6R1cpH0mHhGN7MpX?=
 =?us-ascii?Q?74dTwdqSxZu7H913PzAZ9TTCzohbbcSatktzzpv40XWouG9vsASf4njEcegN?=
 =?us-ascii?Q?CcdcG3pWB5deeL1L3DHl+nYI/taiUetvt6k6BzyegIiA4iRZKQE3K30I7q0r?=
 =?us-ascii?Q?qK4TNcswgz3QxtSrBa1Tg4r3hlVpIIR3Sem7YSSnIuUyIGUM/J3uXrePqGmb?=
 =?us-ascii?Q?azRsXDXQenm+QYy0k6eMSTtR2++qtUGArDkRyTIbRw3hjoUv5sTM7FzWOlWQ?=
 =?us-ascii?Q?tT+HoMzuJpQp8qpRbX5ghsoETK4lBoCi20utvSUJH2+Sx8JSA9/zjRqC2L0C?=
 =?us-ascii?Q?b8Dzorkio11gSCRSlBPZNDLk74LeUruyEz4pPSJ4fQ/dlN0vb//p5XRo9v8M?=
 =?us-ascii?Q?RG+2mh6ZHZAoXD0AYI9/YZ4dEZL5hcajyiDykPlKzQDGvIew9Q5G0+cRTLRw?=
 =?us-ascii?Q?hEs3nnPe1aY99tYNKeEuR8XA17ZSwjWMU2kRCtCKfhWTO/ZAC6Usy4AEFRCD?=
 =?us-ascii?Q?9Gp17Bi3BZyXBu6QbS8m4aD7A/yVKPl1bRJjJB1Z+Tb4gaz5AjiXST4Y0JKt?=
 =?us-ascii?Q?9gXVObrgSpBgPFDnaCSl83RFvlaly8DGzDFfgjK0RDRE4ZIgYXDFrOO3c5JC?=
 =?us-ascii?Q?GnAziQSU3dDvUFmu2RrkXRe22M65ROI45z8dcrZnlyp4Wqv7qaZcKKX6ivcH?=
 =?us-ascii?Q?iXB7aJHa1AZ6yN3bNqfksS7ukbmeoF/o5TCZjmOMagJDnG7hbLJ/lFW+J5DX?=
 =?us-ascii?Q?pqMSgYg60+A1DY7z9fhWyL5QXBRRQp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a597a0d7-1f5c-44d3-ee14-08da41dee3dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 01:51:18.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFKIjKRUN3Ak615/My0fCLQFk+XZsSQxb5rICEnG6q8o537bC5QA6bjC3T01zT2w/09F5s5j46ewbaK06sN7PCCJytb08cUNZ5ItW+rqpcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2033
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com> Sent: Friday, May 6, 2022 4:01 AM
>=20
> On Thu, May 05, 2022 at 04:51:54PM +0200, Vitaly Kuznetsov wrote:
> > Mark Rutland <mark.rutland@arm.com> writes:
> >
> > > On Thu, May 05, 2022 at 03:52:24PM +0200, Vitaly Kuznetsov wrote:
> > >> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> > >>
> > >> > On 05/05/2022 09:53, Mark Rutland wrote:
> > >> >> [...]
> > >> >> Looking at those, the cleanup work is all arch-specific. What exa=
ctly would we
> > >> >> need to do on arm64, and why does it need to happen at that point=
 specifically?
> > >> >> On arm64 we don't expect as much paravirtualization as on x86, so=
 it's not
> > >> >> clear to me whether we need anything at all.
> > >> >>
> > >> >>> Anyway, the idea here was to gather a feedback on how "receptive=
" arm64
> > >> >>> community would be to allow such customization, appreciated your=
 feedback =3D)
> > >> >>
> > >> >> ... and are you trying to do this for Hyper-V or just using that =
as an example?
> > >> >>
> > >> >> I think we're not going to be very receptive without a more concr=
ete example of
> > >> >> what you want.
> > >> >>
> > >> >> What exactly do *you* need, and *why*? Is that for Hyper-V or ano=
ther hypervisor?
> > >> >>
> > >> >> Thanks
> > >> >> Mark.
> > >> >
> > >> > Hi Mark, my plan would be doing that for Hyper-V - kind of the sam=
e
> > >> > code, almost. For example, in hv_crash_handler() there is a stimer
> > >> > clean-up and the vmbus unload - my understanding is that this same=
 code
> > >> > would need to run in arm64. Michael Kelley is CCed, he was discuss=
ing
> > >> > with me in the panic notifiers thread and may elaborate more on th=
e needs.
> > >> >
> > >> > But also (not related with my specific plan), I've seen KVM quiesc=
e code
> > >> > on x86 as well [see kvm_crash_shutdown() on arch/x86] , I'm not su=
re if
> > >> > this is necessary for arm64 or if this already executing in some
> > >> > abstracted form, I didn't dig deep - probably Vitaly is aware of t=
hat,
> > >> > hence I've CCed him here.
> > >>
> > >> Speaking about the difference between reboot notifiers call chain an=
d
> > >> machine_ops.crash_shutdown for KVM/x86, the main difference is that
> > >> reboot notifier is called on some CPU while the VM is fully function=
al,
> > >> this way we may e.g. still use IPIs (see kvm_pv_reboot_notify() doin=
g
> > >> on_each_cpu()). When we're in a crash situation,
> > >> machine_ops.crash_shutdown is called on the CPU which crashed. We ca=
n't
> > >> count on IPIs still being functional so we do the very basic minimum=
 so
> > >> *this* CPU can boot kdump kernel. There's no guarantee other CPUs ca=
n
> > >> still boot but normally we do kdump with 'nprocs=3D1'.
> > >
> > > Sure; IIUC the IPI problem doesn't apply to arm64, though, since that=
 doesn't
> > > use a PV mechanism (and practically speaking will either be GICv2 or =
GICv3).
> > >
> >
> > This isn't really about PV: when the kernel is crashing, you have no
> > idea what's going on on other CPUs, they may be crashing too, locked in
> > a tight loop, ... so sending an IPI there to do some work and expecting
> > it to report back is dangerous.
>=20
> Sorry, I misunderstood what you meant about IPIs. I thought you meant tha=
t some
> enlightened IPI mechanism might be broken, rather than you simply cannot =
rely
> on secondary CPUs to do anything (which is true regardless of whether the
> kernel is running under a hypervisor).
>=20
> So I understand not calling all the regular reboot notifiers in case they=
 do
> something like that, but it seems like we should be able to do that with =
a
> panic notifier, since that could *should* follow the principle that you c=
an't
> rely on a working IPI.
>=20
> [...]
>=20
> > >> There's a crash_kexec_post_notifiers mechanism which can be used ins=
tead
> > >> but it's disabled by default so using machine_ops.crash_shutdown is
> > >> better.
> > >
> > > Another option is to defer this to the kdump kernel. On arm64 at leas=
t, we know
> > > if we're in a kdump kernel early on, and can reset some state based u=
pon that.
> > >
> > > Looking at x86's hyperv_cleanup(), everything relevant to arm64 can b=
e deferred
> > > to just before the kdump kernel detects and initializes anything rela=
ting to
> > > hyperv. So AFAICT we could have hyperv_init() check is_kdump_kernel()=
 prior to
> > > the first hypercall, and do the cleanup/reset there.
> >
> > In theory yes, it is possible to try sending CHANNELMSG_UNLOAD on kdump
> > kernel boot and not upon crash, I don't remember if this approach was
> > tried in the past.
> >
> > > Maybe we need more data for the vmbus bits? ... if so it seems that c=
ould blow
> > > up anyway when the first kernel was tearing down.
> >
> > Not sure I understood what you mean... From what I remember, there were
> > issues with CHANNELMSG_UNLOAD handling on the Hyper-V host side in the
> > past (it was taking *minutes* for the host to reply) but this is
> > orthogonal to the fact that we need to do this cleanup so kdump kernel
> > is able to connect to Vmbus devices again.
>=20
> I was thinking that if it was necessary to have some context (e.g. pointe=
rs to
> buffers which are active) in order to do the teardown, it might be painfu=
l to
> do that in the kdump kernel itself.
>=20
> Otherwise, I think doing the teardown in the kdump kernel itself would be
> preferable, since there's a greater likelihood that kernel infrastructure=
 will
> work relative to doing that in the kernel which crashed, and it gives the=
 kdump
> kernel the option to detect when something cannot be torn down, and not u=
se
> that feature.
>=20

Apologies for the delay in joining this thread.  In addition to being out o=
n
vacation, I've been doing some further investigation to make sure I have
my info right.

The idea of doing the VMbus teardown in the kdump kernel itself is intrigui=
ng,
but has its own problems.  Sending the CHANNELMSG_UNLOAD in the kdump
kernel should work OK.  But Hyper-V will ack the command, the ack comes
back into a queue in the original kernel memory.  We can't re-initiate the
VMbus connection in the kdump kernel until we have the ack.  We don't need
any data from the ack, so we *could* just wait 100 seconds and assume the
ack has come in (in unusual cases, the ack really can take that long for
reasons documented in the code).  Given a choice of doing the VMbus
teardown in the kdump kernel (including waiting an extra 100 seconds) vs.
doing the teardown in a panic notifier in the original kernel, I think the =
panic
notifier approach is preferable.  The risk of a failure that prevents kdump
from working seems only very slightly higher when the teardown is done in
the original kernel.

The bigger problem is with a normal kexec().   On x86/x64, we depend on
the machine_ops.shutdown() to run the code to do the VMbus teardown.
Today, the teardown isn't happening at all on ARM64, leaving kexec() at ris=
k
of a variety of failures.  kexec() shuts down all devices, so individual VM=
bus
synthetic devices get properly shutdown.  But VMbus is bus, not a device,
and the VMbus connection is managed by the VMbus bus driver.  From what
I can see, there's no mechanism to explicitly shut down busses upon kexec()=
.

Just brainstorming, I'm wondering if we could create a dummy VMbus
device that would teardown the VMbus connection in the case of a kexec().
Kexec() appears to explicitly shutdown devices in reverse order, which woul=
d
work since the dummy device can be created before any of the other
synthetic VMbus devices show up.

I'm open to other ideas as well.  I understand the desire not to open
floodgates by adding the equivalent of machine_ops on the ARM64 side.

Michael
