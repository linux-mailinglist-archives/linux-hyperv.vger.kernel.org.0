Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4675BB99
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jul 2023 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGUAln (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Jul 2023 20:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGUAll (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Jul 2023 20:41:41 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E640A272E;
        Thu, 20 Jul 2023 17:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMHJGm3/+tWpqrS0UPAm/BwBAbhuCzh3erYugADqTk2YeG53UphmGV6HFgTje+1DLPRmDL9JWK+vfSGiF3bf+l+hWsv/12Z4VIQXA1KFaSpAVrTfNuF6nwexux3HQrN+5huxriT25W8r8I4Yhut+BBVffCkRjCHAJt/8fI6s1wMlPOnR+6wtgv9aOza3xsJgGGoOB4fskE3HbrCIKCS73c5ncb9gSAfgGgL3svvheYdcWRcvo3cjtyMPD+3t84agfIpyYlqL+ZMhimJh7wMZC9ZCepS0wu8d79VBXXI54rhic7FEMKp8toLvbAShOnJsE+WeLUTPmMNrVxa3AbA2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14428ok+AlOPlfmxzSRP32Bl3IXr6vYuFjpSbYsfKng=;
 b=Sj256mAPX6OlkJ6GMwZhqPi6QcO6CyEprrsAaa4kSyczQBAAHoN1z9Cfdy7hzL0dg28Dj/ykyTYYklL6qX3r15SvORmYznzJx5rmNwJsZ99GwxpxSvX4IYFXLC9gSRvzIIR3KwLSIHLK2/wCP5aqa53QrQz4mcM5qJsIUdDNpFVN6Ckx3u9kjCFVu02M5H3qbFO4Af0KII+G6lj7v1Pj6CcAuPaAosqGGphspK5dDF5nBWwUxd+mN8LPoL24R+ZsbPLDHPXcIb9L3GFtE9YmkrZcXVtX5yPmL78m6v53cWzsWbcQsncQyk05vaT/TgcOu+Snl7SYiD2K0PHawC7x/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14428ok+AlOPlfmxzSRP32Bl3IXr6vYuFjpSbYsfKng=;
 b=PjVDwFYCNOFrW3O31EIZbLNYVHs0XVkz1TN5YyyvBiivgE3u012eH7P4+JFt3NVDBYHhATspOTGNu4nJn4HZhPthIEmQ6WhiISJim6Zv8fcHeRQBAHi67xU0hW/WWcsixinUp4lYGmN0WFXhnmPtRzUK5iosX6xB9zwU2IW+Yms=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by MN2PR21MB1534.namprd21.prod.outlook.com
 (2603:10b6:208:202::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 00:41:35 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::a051:3119:93b5:33c7]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::a051:3119:93b5:33c7%3]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 00:41:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Topic: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Index: AQHZu0mXUyEtW9eyqkWnVGF605KOSq/DKCeAgAAzncA=
Date:   Fri, 21 Jul 2023 00:41:35 +0000
Message-ID: <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <1689885237-32662-1-git-send-email-mikelley@microsoft.com>
 <20230720211553.GA3615208@hirez.programming.kicks-ass.net>
In-Reply-To: <20230720211553.GA3615208@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b52301eb-604c-44e1-bf56-29beb984d9b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T00:20:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|MN2PR21MB1534:EE_
x-ms-office365-filtering-correlation-id: 0077d5ca-da5f-4c6e-2a43-08db89833cb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqPe+wYgT3YnCJl/kRvTfeLZKZQxezqoqi4+64aTIC3Asz+sKxmLvudd/GLsBT1sy2mpKYWQZFnCmt9a+LcEjWTIBULP7tXa/SsFreg/0pZ4sMGI8E/yFVXVQMLarnzF+WAcjmvy37j+4onyVVkJDKc+eu5ZRGOr9RfiygACEVHQsrJEJY64lYrZum94EMLEjZr8BD8oFQGgrOBKkNP1iDGlLdUY+9Gcv/KIV6p9ch6SUlMJW/BnqqKDTZYXosAYa6XeEkdU70FtYtaMIAtZpivQFRfMdMEFxBvPxEGM1iDvuw135SqX8zd6CQoJi+fOcAWbn8zA78nxZ3Dvmwof+hBCTaBQHhWzZHTcgSiAy9j7TJRAwglRtB6HW+k348vCkvt34iU0jkwRG1tGHmYpQGaZGGLHRIq6zvkGA09/9Ii7ZO7URh20QgIscT6tE96hYQywO8uLmpNMreUJe3I7kYNSuVyf15JJflzOgshODXidVpRKP1A8e+W00t6QN0xSHEhqZ1MliKcHcix66EP70U1uvAxqZ6hVYqRvz9NFizGvCMDFKfGhk6070EUFo0e7pZ3VtUX8jhVND3hJhAxwmE2zF2gkDaVv03gXy+D35UgBhTsKbVHsvRJ/a32xA0UTtfdxccoCWaYYDZwRkvjfKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(8936002)(8676002)(7416002)(2906002)(52536014)(8990500004)(5660300002)(316002)(41300700001)(7696005)(66446008)(64756008)(66476007)(6916009)(66556008)(66946007)(76116006)(4326008)(55016003)(54906003)(10290500003)(478600001)(71200400001)(33656002)(122000001)(38100700002)(9686003)(966005)(186003)(86362001)(26005)(82960400001)(82950400001)(83380400001)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xuyko5hmGm80yDVv2cm+eiPLkZ8WSNNvXjMmPLap9GmvrdSthfIlyaK8hFk0?=
 =?us-ascii?Q?9kOHZiU93bZtf4bdRYlbpVDj9VfHuYqiX94igpI5MdKXKNx38EcTkFCDjPqk?=
 =?us-ascii?Q?/IF9hEeqI29MjB/+QOpeO9axfEy0SF2ntI+iZL//PrO6N942FH2tnld7BdGs?=
 =?us-ascii?Q?4F0f9VIj/u+oRo7PqQtBXdpw68Pku3foZMeJSKymYWg534b0b7LUaZeKGMjl?=
 =?us-ascii?Q?SIS/tX3Y8asfOmaaRKO7aW/HznIUpw81u3zvfPrUyxcWKpxxeA/L3DShJ8Qe?=
 =?us-ascii?Q?ZqGtn4xMoiIxnegTT1i1tIl08lCENwXJKmuj4rGI3KE6IJEzuHpTb7p2hdF+?=
 =?us-ascii?Q?f81ohf/IXcJliWLA+XuKS8DT1NZitOoFrdr1eoGsNAqJPsW3GQ5rsdHUXc/P?=
 =?us-ascii?Q?9pcQ/xp11Be23WUnGvglcGqJe6ii3RtvNlpksh+riF865kLDfM3UuaK7iK0/?=
 =?us-ascii?Q?Adbkkf5ZrDV44P61+IwEQlUydoDsXvhEk0v+/f8bNwfBXQOGrBkel7zbIKM3?=
 =?us-ascii?Q?cWhUYleAdlpVc2hN5japHthLgkFNtrEGdF8WOM3Ck0m2VuImjHUMDcTenOU8?=
 =?us-ascii?Q?HtrOQj1xcAJ0MitalrLvkIskz9RcyPpylpGb+i3HKjvZ3ZNBJeY4iyUcJujl?=
 =?us-ascii?Q?7z5x3wl1UlZAZd4s3vlepvN95/lc4ARXryKItSvDq9wd73o/k20netFW9Uoq?=
 =?us-ascii?Q?4c+xjcuuJWwoCuA89J8Tgv0E8u4KE27LkH/lAMsIYq5FrpMfYbpO3TolBj1S?=
 =?us-ascii?Q?pW5CoYxM65Pz8c6uQmcO9MPk8u6Wkek9nJTKhxAhIdTwCSwq6xVZg4eaZZqB?=
 =?us-ascii?Q?aAlsdQDU4d0mfuD1hf+AmXQTFn5JdyrBODFH1f3yxsWnUJDapQztQU+cTUBO?=
 =?us-ascii?Q?rsGmRlRvT8zXOWgsIGZQ/IBCs+5cGVbSeA3EhJ09/9YLom/y4QBANXPteiLg?=
 =?us-ascii?Q?XrsdSp9hHz+eQ9Xdob8fH+PJMR3zHYGueXmDrAAH0EoczLxMv3Xopn1iYQCZ?=
 =?us-ascii?Q?RfANLtmNU0f7U/1ow9dD5NQ3c6b3XgYpK8pwp8h+IPK3lQGmeIGPOpwgzPZQ?=
 =?us-ascii?Q?a8bb3NpTU4d1OkHrEKNGOED4qwACQ6jMvhKC0RVVNwb8dN+eskdN8s9uM7g5?=
 =?us-ascii?Q?OuXv46gxcoUPq2kZHplikKyUDM4jLP7rj9HLTE7J427m0AzZ9wzGLhG7XCC5?=
 =?us-ascii?Q?JQUskcTzBeerhsAtC47P4nuVwAqQN3Ytx2rinExSWCSxJT5PF0SN6Xf8BWqQ?=
 =?us-ascii?Q?kvtjvpmCmZ2T7Ku4/DbXJR8Q5ZHaCnGpn2RwvSzQ0KlnnaA/vvn7Ftb5E2vZ?=
 =?us-ascii?Q?chh/cXyXt5GblYZfwg+R94xdKqX6PjOo65rZD/l3235Fw+sS9CgsdbXeRegm?=
 =?us-ascii?Q?Ui+y36lVpFfZwTXjBH5psJ4FzcvSYqoyq22PnTrbM+AvsbgRVBB8gGIKL8S1?=
 =?us-ascii?Q?Mx20udFe6BM/gfbT+aTes4pjJm0pKVULXvs7x3aUvlF0u3PhYq9YxkJVoVc/?=
 =?us-ascii?Q?QE/cCg5cfI5XAbtCByB4VfLVIhcnlG8keiOqY+CjfRCyrQkivGHDd3ThmWwU?=
 =?us-ascii?Q?SfH52W7zpMgMdiStTx+P93KPQZAXpE1sMV9UP9XLI4+R696vT5RDP+5I8t8z?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0077d5ca-da5f-4c6e-2a43-08db89833cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 00:41:35.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVPJ+/7EY15a/0JXEBxaCuT+Q8egDRX1Rmpzs5UkZXB0/5qIbcZqs/HpVRyAz4Sy+FEg2GDAVOfAIbzA3GdOhP5dwaWyc3vcMZN34Flx8Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1534
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org> Sent: Thursday, July 20, 2023 2=
:16 PM
>=20
> On Thu, Jul 20, 2023 at 01:33:57PM -0700, Michael Kelley wrote:
> > On hardware that supports Indirect Branch Tracking (IBT), Hyper-V VMs
> > with ConfigVersion 9.3 or later support IBT in the guest. However,
> > current versions of Hyper-V have a bug in that there's not an ENDBR64
> > instruction at the beginning of the hypercall page.
>=20
> Whoops :/
>=20
> > Since hypercalls are
> > made with an indirect call to the hypercall page, all hypercall attempt=
s
> > fail with an exception and Linux panics.
> >
> > A Hyper-V fix is in progress to add ENDBR64. But guard against the Linu=
x
> > panic by clearing X86_FEATURE_IBT if the hypercall page doesn't start
> > with ENDBR. The VM will boot and run without IBT.
> >
> > If future Linux 32-bit kernels were to support IBT, additional hypercal=
l
> > page hackery would be needed to make IBT work for such kernels in a
> > Hyper-V VM.
>=20
> There are currently no plans to add IBT support to 32bit.

That's what I thought.

>=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 6c04b52..5cbee24 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -14,6 +14,7 @@
> >  #include <asm/apic.h>
> >  #include <asm/desc.h>
> >  #include <asm/sev.h>
> > +#include <asm/ibt.h>
> >  #include <asm/hypervisor.h>
> >  #include <asm/hyperv-tlfs.h>
> >  #include <asm/mshyperv.h>
> > @@ -472,6 +473,26 @@ void __init hyperv_init(void)
> >  	}
> >
> >  	/*
> > +	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
> > +	 * in that there's no ENDBR64 instruction at the entry to the
> > +	 * hypercall page. Because hypercalls are invoked via an indirect cal=
l
> > +	 * to the hypercall page, all hypercall attempts fail when IBT is
> > +	 * enabled, and Linux panics. For such buggy versions, disable IBT.
> > +	 *
> > +	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
> > +	 * page, so if future Linux kernel versions enable IBT for 32-bit
> > +	 * builds, additional hypercall page hackery will be required here
> > +	 * to provide an ENDBR32.
> > +	 */
> > +#ifdef CONFIG_X86_KERNEL_IBT
> > +	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
> > +	    *(u32 *)hv_hypercall_pg !=3D gen_endbr()) {
> > +		setup_clear_cpu_cap(X86_FEATURE_IBT);
> > +		pr_info("Hyper-V: Disabling IBT because of Hyper-V bug\n");
> > +	}
> > +#endif
>=20
> pr_warn() perhaps?

I wanted pr_info() so there's an immediate way to check for this
case in the dmesg output if a user complains about IBT not being
enabled when he expects it.   In some sense, the message is temporary
because once the Hyper-V patch is available and users install it,
the message will go away.  The pipeline for the Hyper-V patch is a
bit long, so availability is at least several months away.  This Linux
workaround will be available much faster.  Once it is picked up on
stable branches, we will avoid the situations like we saw where
someone upgraded Fedora 38 from a 6.2 to a 6.3 kernel, and the 6.3
kernel wouldn't boot because it has kernel IBT enabled.

>=20
> Other than that, this seems fairly straight forward. One thing I
> wondered about; wouldn't it be possible to re-write the indirect
> hypercall thingies to a direct call? I mean, once we have the hypercall
> page mapped, the address is known right?

Yes, the address is known.  It does not change across things like
hibernation.  But the indirect call instruction is part of an inline assemb=
ly
sequence, so the call instructions that need re-writing are scattered
throughout the code. There's also the SEV-SNP case from the
latest version of Tianyu Lan's patch set [1] where vmmcall may be used
instead, based on your recent enhancement for nested ALTERNATIVE.
Re-writing seems like that's more complexity than warranted for a
mostly interim situation until the Hyper-V patch is available and
users install it.

Michael

[1] https://lore.kernel.org/lkml/20230718032304.136888-6-ltykernel@gmail.co=
m/
