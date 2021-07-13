Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD5F3C7678
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGMSdU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 14:33:20 -0400
Received: from mail-dm3nam07on2127.outbound.protection.outlook.com ([40.107.95.127]:46113
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhGMSdU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 14:33:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmWtYReBWe2TF/G/07DnRkzOxOazaViyG9lZ4uXtTnJky/XiN0tXeg5ylDXkytCrrjF9Y5a4MFNZ/2Sff/+Y+pkyWZLjBsRBdpdv1L+L0ccFsYisgLEyKB4jI0udwEogSNB2gEby2oi1qdWu6Fj4+XJrMZWKJ7hs3LP1VWAboDIxNkOqp/SqZ5kckRsJ+kF7QTqpCOpM/U7dcqNWhQ1wGZgYnfOw9RofwxmzWvFO9hFVcODUJANwHF5548pEGBaET01GQx5N0ahCTJd92Jdl1xWAvc5/YgO75iiRkitm6OKMVqGSzClx98YWMROaDWlhG9WqY2qfKjJtb5HwEQliEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rfGdeW+jLuJ1F5BTTkzvLbwYz2UUQ+0osR9wpNiD9k=;
 b=gvW7MxLRZDk3mdo8UA1mmgDJI2JHhUW4UudH53wV1avhGsKnH8OTnjLaWY7+iDw8pA3NTSVdCPt8lupC7qcYZb6FMUsIB+cVgDjdDEJwRQUbmkDtcQmcUDwK7tr2WMgKdAeEt3sEjp9jGPDGBnlW0bTMCc08TBkK/7VSsKKZGQb7Vx3uO92xS8+U8sSpNoDCarC71SWMMm9xz3QoWCvM8j7oBbcRzSFrBzpDpjE0nUhe1MFLxorPAMOK+4qKoQam+r/FU5yLlRgHyvyDrkVwPFqaSFMy2eWgGGVluX0z8hu+78O1hUBc53AuUqM7L/Jtz6PpODFE808vbN/cKbK8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rfGdeW+jLuJ1F5BTTkzvLbwYz2UUQ+0osR9wpNiD9k=;
 b=Q388I4lHb2hV+JvLCQVL2SyNCAzlO/zuiqXdpPYOzB9nzvC7KvE+83h6GyLXSoGtOd3sXcdfecU3pEI2EYec0e8IW6S2KY1QQ7cUBnb9AMa6ZSMos2cwgi9fsOC8kT0L2+SAcpl7myOWH6GCSuENhdSA4WQ6L495QOdF+hDxeP4=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by CY4PR2101MB0801.namprd21.prod.outlook.com (2603:10b6:910:8d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.4; Tue, 13 Jul
 2021 18:30:27 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3583:7ddf:dc7c:b25f]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3583:7ddf:dc7c:b25f%4]) with mapi id 15.20.4352.008; Tue, 13 Jul 2021
 18:30:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ani Sinha <ani@anisinha.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anirban.sinha@nokia.com" <anirban.sinha@nokia.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Thread-Topic: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Thread-Index: AQHXd5QA/Pf4lQTVX0uoJvEieLSplatBKDfAgAAHSQCAAAruoA==
Date:   Tue, 13 Jul 2021 18:30:27 +0000
Message-ID: <CY4PR21MB1586E7C0820C257A1D57B462D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <20210713030522.1714803-1-ani@anisinha.ca>
 <CY4PR21MB15866351E83212975EA02C34D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
 <alpine.DEB.2.22.394.2107132306310.2140183@anisinha-lenovo>
In-Reply-To: <alpine.DEB.2.22.394.2107132306310.2140183@anisinha-lenovo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b1ae3566-bc58-4a99-aa38-5a1575615069;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-13T18:27:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b3a6ba7-6bb6-4395-878b-08d9462c4954
x-ms-traffictypediagnostic: CY4PR2101MB0801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR2101MB0801ECFB329AA90782D4CE87D7149@CY4PR2101MB0801.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2oOgKGaFFmGH3JTsXRCI2B+pKE+ZVd7ES0H01hfrdLZZOSiCZCy9JgLcHBCqtHSBikJ4z0py4HP+9zG3/yybjiePPooe+lACRsVzo8eE6WydCInzFbGXS0j2xzH2m21PFSumPmk18koDg1e86H9Vp997njIOHmcsKUZJX2M8UepbUQjcIFFQtSWHJNu+L6jpuZlHXfa1vEusVzYj44Wb26ff4NDNKq0TR+WbZf0dHTxg5JoqFIALVb8828HckP9UActBBQnKij5nH6nK6V6S/ympjJ6I5pIVqAKRYIt3ZTp6txktyKNWpu6EAJCXq5fbXphsz4y7hjKKAmFQvXVpL/tBdwZxP9n9/fGOpow9xcydVxaPYv7ituBHmeswuRzvSYegq5CNlk6vnhogFNyFoBfBGmdGmq5wlp6c5Ds5E6lU+AeE5C/2Q+3Hssq3Mj962SDiwcxCxa4ZJWkjhEJmQYpkrGzibe7PKPmf5AFxHPwA3yidad7Fd+PkFbGf5RcF/ta+JIleyLfd3tvkFbFLJ5cvEUeRyyN3mhGWCkjYZ6JGlptzUuutKBoo7EEMQBQCSHDWf+8eMDdINEdb9zn0CEfHgfFVOMLg7MxPG7YW9bvhFw9eGoYVmSC6ao8zW7tLKZSS2HSuehSt8x05NCAjPG+aSXbEQueJ/t/MD5e1BujABZVfIXYwqhWy4OdjEIGwgW7CGdzB+1UXjyItQmnwsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8676002)(66446008)(55016002)(9686003)(64756008)(4326008)(7696005)(8936002)(54906003)(66946007)(33656002)(2906002)(66556008)(66476007)(7416002)(8990500004)(86362001)(52536014)(122000001)(76116006)(38100700002)(71200400001)(10290500003)(82950400001)(26005)(6506007)(83380400001)(186003)(6916009)(82960400001)(5660300002)(478600001)(26123001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jolhc5Y4PylUlzi+qfI25t6/BryVm/8bcNSiRKpZ8jxypPazc2wuOcjGjr0H?=
 =?us-ascii?Q?5Scsb61m9mbdwOqxC8hEA4b+g/MII4RNRY74Muc8sazV7sQqV5bKLqF1dua+?=
 =?us-ascii?Q?sARYlbCRj/dFd/3EQRzNpVcKjg5q2IsA9KqvY6ZLSVy+lvJHfOxHs+66LjGu?=
 =?us-ascii?Q?9d+pNZxy7OSGQvajME127uTfgLo3diSX9F6GZ8ktDrfo8LdLO+BPcY+fbfrI?=
 =?us-ascii?Q?bN41GeGXk7iMceQlQC6fk8xKc+nxth9JyfYmJKuLbpRwmibM1xIJzd14Svtm?=
 =?us-ascii?Q?oOBQ8uAEb5B7FJFsiU4dTll2iwOp027MAXW9UGC2aqEdR1FhDHY3+TRfCPfY?=
 =?us-ascii?Q?zhMNAVA/Sn02F6Jn3Pwu3rmr+FK0zVkWQv7EKe/1kTEM01zbkNe5FUL15Dp7?=
 =?us-ascii?Q?UpvvhYxGLNJS4r/H0HEHmp8O2kxgdizYNmMAhVuEIQwVE1sT90+Tjf6SOCCv?=
 =?us-ascii?Q?0ifioQJpGys1E9ugvmRdWxjHLhuw2yoVysGi2R1mrQDDU2qHy3l91zaq7cRX?=
 =?us-ascii?Q?l3XKAvMReRvu6zqTuCgQ0wk1GCqJfq+YKxWtXGxCs1BnwYyzaFP33ZGH2FyP?=
 =?us-ascii?Q?Vd1OwGArmL8NRUQPDfhnUeKJVwK0clkCnWRR1fQ8ZXgKtqMOhBhseUd0ZH4y?=
 =?us-ascii?Q?H7pQ+0gKffvRjrsZW65Q9fm7nH8y96yu71q9lqkrRk0/1njHiqkN4E4av5t1?=
 =?us-ascii?Q?7DP98uHUpa8HjkOnuJM3EXYwK0WZd1d9yL96AzjsYJ7deMf5lyzEIS4ZIfTk?=
 =?us-ascii?Q?at3sXtGXANXqdhke1TTS8dBj0rK9Yf43MohloJfXXVtG+b8OX8GLaQAZ4mbU?=
 =?us-ascii?Q?PmqjCmgYwAOzTPHP4yfwIuFSn8rTny/O2ialyMkv2qxXpxGgrAmq8XG83Ir/?=
 =?us-ascii?Q?EUvRD4GBw6vjqhe5R1diKDmtlN2xkBJXrkwuFQxP8WUp5xmd85kvZmxXKLJR?=
 =?us-ascii?Q?X0vCsa0FF0ipxdQbAdKwlvTqbYjwsNqOrGVYvvXjG4Af73nlC3Lm/lRpBJ9L?=
 =?us-ascii?Q?dppOxkucgBaHa2MVAR/ejETJSuEDOM/vwKe6wIjy2vpo0tgr9wrdPCgZrjrD?=
 =?us-ascii?Q?cEf6kQOjo77lwQONNCnE6bdiadxoHiITIiNcH9AG1abreWW6e3JzK/QJUWXc?=
 =?us-ascii?Q?J8SEjeUWxeaBC63Jwo/QIST/qutp6Dml2WXye/FPBIGA7kADhs14hujp881X?=
 =?us-ascii?Q?9Ok/7N0D+QlPk8nmBOuIMr9SdjKp4oIz5UXCoPewmwI5vFfuw8y6PR7Uevh9?=
 =?us-ascii?Q?ApCgi4uWtwZPKMCVL0o2kj3ZqQtat6VuI++0RGvPZ+dSPfrMsfDm6lanp2b4?=
 =?us-ascii?Q?R6ou4gx7fNuIbaw8jGSVcfCO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3a6ba7-6bb6-4395-878b-08d9462c4954
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 18:30:27.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKhvcAxdnKBTYMKFYfs4K9zT3Xt7idB7XXbLwQEfM3W1E2WyRPwPYhcGuvCPsFz4MtSbGcunTk5vp8kvqLnwFRH3Uh1bph9l24fjv+Gs02Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0801
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ani Sinha <ani@anisinha.ca> Sent: Tuesday, July 13, 2021 10:49 AM
>=20
> On Tue, 13 Jul 2021, Michael Kelley wrote:
>=20
> > From: Ani Sinha <ani@anisinha.ca> Sent: Monday, July 12, 2021 8:05 PM
> > >
> > > Marking TSC as unstable has a side effect of marking sched_clock as
> > > unstable when TSC is still being used as the sched_clock. This is not
> > > desirable. Hyper-V ultimately uses a paravirtualized clock source tha=
t
> > > provides a stable scheduler clock even on systems without TscInvarian=
t
> > > CPU capability. Hence, mark_tsc_unstable() call should be called _aft=
er_
> > > scheduler clock has been changed to the paravirtualized clocksource. =
This
> > > will prevent any unwanted manipulation of the sched_clock. Only TSC w=
ill
> > > be correctly marked as unstable.
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > ---
> > >  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/msh=
yperv.c
> > > index 22f13343b5da..715458b7729a 100644
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -370,8 +370,6 @@ static void __init ms_hyperv_init_platform(void)
> > >  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> > >  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
> > >  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > > -	} else {
> > > -		mark_tsc_unstable("running on Hyper-V");
> > >  	}
> > >
> > >  	/*
> > > @@ -432,6 +430,12 @@ static void __init ms_hyperv_init_platform(void)
> > >  	/* Register Hyper-V specific clocksource */
> > >  	hv_init_clocksource();
> > >  #endif
> > > +	/* TSC should be marked as unstable only after Hyper-V
> > > +	 * clocksource has been initialized. This ensures that the
> > > +	 * stability of the sched_clock is not altered.
> > > +	 */
> >
> > For multi-line comments like the above, the first comment line
> > should just be "/*".  So:
>=20
> Hmm, checkpatch.pl in kernel tree did not complain :
>=20
> total: 0 errors, 0 warnings, 20 lines checked
>=20
> 0001-Hyper-V-fix-for-unwanted-manipulation-of-sched_clock.patch has no
> obvious style problems and is ready for submission.
>=20
> However, I do know from my experience of submitting Qemu patches last
> year that this is a requirement imposed by the Qemu community as
> checkpatch.pl in qemu tree would complain otherwise. I also took a peek a=
t
> the Qemu git history. It seems they imported this check from the kernel's
> checkpatch.pl with this commit in Qemu tree:
>=20
> commit 8c06fbdf36bf4d4d486116200248730887a4d7d6
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Fri Dec 14 13:30:48 2018 +0000
>=20
>     scripts/checkpatch.pl: Enforce multiline comment syntax
>=20
> Which adds this rule:
>=20
> +               # Block comments use /* on a line of its own
> +               if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&      #inline /=
*...*/
> +                   $rawline =3D~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* o=
r /** non-blank
> +                       WARN("Block comments use a leading /* on a separa=
te line\n" . $herecurr);
> +               }
>=20
>=20
> But in kernel there is no such rule. Hmm. strange!
>=20
>=20

See section 8 of "Documentation/process/coding-style.rst" in a Linux kernel
source code tree. :-)

Michael=20
