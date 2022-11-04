Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABCE618DB7
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 02:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiKDBoR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 21:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKDBoQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 21:44:16 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022016.outbound.protection.outlook.com [52.101.53.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182522B14;
        Thu,  3 Nov 2022 18:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJcc0HxWaNxba0ofrXv5Zkaj/YLyb3LIxTNxsRdB4o9G1cFzParWhOeCwpCRHMNx0dkR8OxL5bVU+8WWbKL6w2uSZs/jaZMkibR2+PAYlBOZM0HNb1weR+t9A8qJ/QFspPP1WE9QubqJCjyWPeockeHE/xPl79n9MZr8j81DhuNc5Sfj3yUNVS92iXtqoy8goOAZkZ7jf3WsRmxb+sLcD6AbqEh9N09HUXq2WLsSqGaSsDLdVGBBTNooYxske3XGGB5GBCxLIUwjWkGOSPpORUFqhWWPfahnOZ6IQlE3tIsns/ja3ikw15fDYlQ4zdQItf4Iy1LtfpSBTl1Ara4f8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyBRaJz835koOxRt2BJWqo74im4qta5IRSaJ7a7btiI=;
 b=cs+D4fnznmIokPgo+jn+bGtZSRjfS+svGnQRqupRvE8rkF+9a9j+58lJ+I9vBO5jP5nSw9h3Yk6TcxI9GJNsAk30/2KP4DmBqVCXcYwz5PPEDv9lwYiLnU+Xm7IlXP2EQwdV/XAofJScEnF4cjulnmpVErhu002DaxciY8W58HWURUOa3cXapW04SiyZ+7oexJR45XsbniBfVK2IelacuBwFEEQIeSMxkwOdlgAzuhARk4BfXxLQgzJrDAudwNW6y7/l+K9b8WMVlfDLGi6KA/ZXFDqjBnmeUfNF6f+undioHqHVPIHjXEZJk6JZCbWKv0aZARbmWqTDQyXjCNbw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyBRaJz835koOxRt2BJWqo74im4qta5IRSaJ7a7btiI=;
 b=YBcfFlhXFQznjeOA2qcBtILwESEwybLx73neSCMffpvoFO1i7E+CboZ39K7BuLom5mX3E2AaP1YDhDGdGLtWqDwUpbwrNt2JFJ+XKUbjSLgO0orO/HwGwucCoglFfhYvGy0M8KQybxHqtRq/0REAF+NWKG5xbkYR61T31+eFWS4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3523.namprd21.prod.outlook.com (2603:10b6:208:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.4; Fri, 4 Nov
 2022 01:44:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 01:44:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Topic: [PATCH v3 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Index: AQHY7635pOXjdMrlWEeUmnmc1+6tfq4toZHA//7IoYCAAZK6cA==
Date:   Fri, 4 Nov 2022 01:44:09 +0000
Message-ID: <BYAPR21MB1688D81DEFA482E52653955FD73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166749827889.218190.12775118554387271641.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166749834466.218190.3482871684875422987.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB1688F63C2410904F92B1F75FD7389@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20221103013705.GA1922@skinsburskii.localdomain>
In-Reply-To: <20221103013705.GA1922@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7265db2c-a1c7-4e04-a975-3bf64b32e302;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-04T01:38:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3523:EE_
x-ms-office365-filtering-correlation-id: 61710f1e-bccc-49a0-ebfd-08dabe061137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPtzviCcAeJZphAzVaia/n2geH0A1UF4GGfcCzROK7Wwbb0XVaerii7wgmebBMSEJ43mUiRq1Xn72pMz8eucSuPsOILc+ArMNteQEm2ejlfWN7azXVynxX63VDIm5SE4/YyXpB5878F9rBX1XQqMov1ZghJcdYCwm3XgRtWYK8ZmkYlu2ev0ltj6HxallNlVYY7A9c7ikFR0qGDqP23o7V+kxnkRSuYtCSGk1vRO40ce+uUMtfDmu6v9BrtW2v57I96nKYVpBmtrgswhuGgd7jd23W9o8WCjLJPE97j00eSurjCkAL05FqAaTLLxRBBXmqQz89vxOV1LvkHCIe0nAT/DO3hMllzQ8eXBvacJAEBKaRCZrAz5y2buD8U984pIHFCWo/AlSX6uhtt9xyMf2eaMvPqSFx9fKF0i7gMhTBgsetwCgADH3tuxUE36b6UhkpQScNK1furPs1q+vOZac2RlkfynFm5H8wcDEf0dXtp9f0nwEv1/jJijHP93XBIwo/gbytWJSSihSFbDmB/rUlvkjKjd6NyJ5ZlqGV2XZVQoDH2BjLkZDNaqrGG3yVmB6TcQDheUfLb5DrMAQuI8Ioao7pJ1k0IKX1WYI/hD/1LJEBxXNB0aMyhiwig2Fuk0jmVTK5BwNwHoBPPrbUDVzwUmRjfH2Gx497XGbTub0d7Cx2+dOmfpTtPYwSurIi0YT2dNGs2PVvmvcICP6aVf7c4OouqV1B7pRlzMF/l3Vxz+f5LzKnDjrIdUyIxLKDOsIwbhRxvgV6anJa0RzbH78ixbFHoDSfrkrfFw9jQ2pJlJY94+XFI7pd7qvLyRa4jp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(316002)(186003)(122000001)(41300700001)(66899015)(10290500003)(7696005)(8990500004)(6506007)(54906003)(26005)(86362001)(7416002)(2906002)(38070700005)(82950400001)(33656002)(9686003)(478600001)(5660300002)(52536014)(6862004)(82960400001)(55016003)(71200400001)(76116006)(66946007)(83380400001)(38100700002)(66476007)(66556008)(66446008)(4326008)(8936002)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5i7n9MqxWQMBBh25oY9AdIPWf5lbfrwfXQLQAle3/644yHcMaPIRbe/YRFH6?=
 =?us-ascii?Q?jAdCDWPyPZ6VozLZ3DUTGByTPvpy3EHylxlpDLZPEtiFsrZ0kRQmA+72Hqp0?=
 =?us-ascii?Q?3TK41J+wMUn3OwyE+S10vMYCQwmT2m7FpRDEf2YEx2WbE7mussBG7PDlP4DS?=
 =?us-ascii?Q?pfPGzQeVTJ8BGBuEMx6xR1ez1z4JQeNyaN66332zfRvOGQIIfs5JYetOOPb4?=
 =?us-ascii?Q?b3JsnZ3D1QQdDYcBxnCteMinQB0kssU/esZSib3VAAbZGMaS+rxgS2nI577h?=
 =?us-ascii?Q?Na7kwAc3FjCeI1ankeh+/rRi5WD7SazSp1PIDbaIsBjqPRvLcaMBaNNcRBtv?=
 =?us-ascii?Q?zoqoMewvY1tW6FvMdVHlJrgA1J3X8VllqJayD8cHD/nk2qi/I6Bp0b59j/ZP?=
 =?us-ascii?Q?F9Io8P5UVv0beBoJii8nVrWO5kPkY8CXYB8InVDXIVJJfBweupY2MYfEqjXY?=
 =?us-ascii?Q?+OWVvC1h0SVS2Z+vA81cby8a0EJmZf/ihvw5vjIxa1G8Rqsp1To922I0X4CP?=
 =?us-ascii?Q?hXJudqv5nIklMBFXsnl/p+JKpLETv617U+BbODpGbn8VBqQYwFufKfVuZ4i8?=
 =?us-ascii?Q?uuZl4NpmGrh4uLm3yJhNtxZjTGrKm0QKAKDVRXYnzEm1v2E8R6+gYCWsOE7i?=
 =?us-ascii?Q?lkbuQtQdzJI5kWB9OFRpK18PJA+ayHvyXrC/6e6P2K2Pso9DjNBlbBPwu9sZ?=
 =?us-ascii?Q?6Nlg0NYWcGmQ3AQ2IIMafyj6Bof0qhKSH6289JnsdBlhlJJfc2cXi79wdNyR?=
 =?us-ascii?Q?h214eJ2nfr2iwl/VksolGGc2Jqihw2gstNaUClYGcldUnjmeGx07756FtKw0?=
 =?us-ascii?Q?XFzcZF9mhRQs2PfCq28gh+jSc6b7/CAfV+x9RaLjDlWy9UVwgPfFU2/dgijZ?=
 =?us-ascii?Q?PXUohQgwgVP+s6mksX0CBb29VchtMD/HYXj7z3rL6c1jAH4EXhA0aM5hSy0h?=
 =?us-ascii?Q?3kOzUes/oiOMC/G/S+Eirf+8PqeIkFrXzAYI6FtAXAeGFFIroQ5PdSqr8AXd?=
 =?us-ascii?Q?+LcpYksuszW8emX5KxPQH70U8PT79YbdqOiFEY+oYfsPv8Pl6RNeIn5JOG3U?=
 =?us-ascii?Q?1ybCnL0RPCPYnNr4UG384DRbCDTK/xP1dM0YSo17lxWvrp5fw7sIEIKZN5k4?=
 =?us-ascii?Q?fc9SWQBayUnZTN+2arlg0NrwAmzsfycKxdq4HFPLOEuBY99OtuYvt6E+UH+K?=
 =?us-ascii?Q?RYzbG+qMMLtAqw3iu4lgmKM/8UwT7+Wv4NVdZnnUbV7MsRubMpgJYLIGoi08?=
 =?us-ascii?Q?EaqeklUXTkEPwqGj/jVRZekfW/F4REWzz/E4ORoKSZw6Wo6TLDNF68IsrEWH?=
 =?us-ascii?Q?pGy86eVUABXihjSo2+lzqwEPH1o3czcGTYCc57yP5K/PrypqBFBLZ58iZVGk?=
 =?us-ascii?Q?cA7F0g4ApTpaiFL+ItB3oOQYBYeag75q0YLDGbglhVPHdFwzbC0KMvSCBPDI?=
 =?us-ascii?Q?nD1RPhnB0YEoI/FEhn6r6iH9R5fSyLhmsqmPW2Sm0Jo4/CNIgDd1XRuymlam?=
 =?us-ascii?Q?E0aqqGswHt8uXvMBN6DhkecDCrKc5UR+6ckJ6DreaGJct5ZSnfMR58iJG0T6?=
 =?us-ascii?Q?mLeCcfrnsB3EzIGZslNHsl1K/CwdJQ3/5KlRke2Fbwx+CYigFPfEncH/4tjY?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61710f1e-bccc-49a0-ebfd-08dabe061137
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 01:44:09.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNHsqqxWOS5oqxC5A+C2KSBLpRQumpd410hYq8I86OBIxyvE1uKHnDfzDQ0b6PSbAUJih3+RLIu7VPyPkAYBQZBKmiVASJyNQgYy4hf7W1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3523
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednes=
day, November 2, 2022 6:37 PM
>=20
> On Thu, Nov 03, 2022 at 08:33:40PM +0000, Michael Kelley (LINUX) wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Th=
ursday,
> November 3, 2022 10:59 AM
> > >
> > > Microsoft Hypervisor root partition has to map the TSC page specified
> > > by the hypervisor, instead of providing the page to the hypervisor li=
ke
> > > it's done in the guest partitions.
> > >
> > > However, it's too early to map the page when the clock is initialized=
, so, the
> > > actual mapping is happening later.
> > >
> > > Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com=
>
> > > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > > CC: Haiyang Zhang <haiyangz@microsoft.com>
> > > CC: Wei Liu <wei.liu@kernel.org>
> > > CC: Dexuan Cui <decui@microsoft.com>
> > > CC: Thomas Gleixner <tglx@linutronix.de>
> > > CC: Ingo Molnar <mingo@redhat.com>
> > > CC: Borislav Petkov <bp@alien8.de>
> > > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > > CC: x86@kernel.org
> > > CC: "H. Peter Anvin" <hpa@zytor.com>
> > > CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > CC: linux-hyperv@vger.kernel.org
> > > CC: linux-kernel@vger.kernel.org
> > > ---
> > >  arch/x86/hyperv/hv_init.c          |    2 ++
> > >  drivers/clocksource/hyperv_timer.c |   38 ++++++++++++++++++++++++++=
+------
> ---
> > >  include/clocksource/hyperv_timer.h |    1 +
> > >  3 files changed, 32 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > index f49bc3ec76e6..89954490af93 100644
> > > --- a/arch/x86/hyperv/hv_init.c
> > > +++ b/arch/x86/hyperv/hv_init.c
> > > @@ -464,6 +464,8 @@ void __init hyperv_init(void)
> > >  		BUG_ON(!src);
> > >  		memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
> > >  		memunmap(src);
> > > +
> > > +		hv_remap_tsc_clocksource();
> > >  	} else {
> > >  		hypercall_msr.guest_physical_address =3D
> > > vmalloc_to_pfn(hv_hypercall_pg);
> > >  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > > diff --git a/drivers/clocksource/hyperv_timer.c
> b/drivers/clocksource/hyperv_timer.c
> > > index 9445a1558fe9..dec7ad3b85ba 100644
> > > --- a/drivers/clocksource/hyperv_timer.c
> > > +++ b/drivers/clocksource/hyperv_timer.c
> > > @@ -509,9 +509,6 @@ static bool __init hv_init_tsc_clocksource(void)
> > >  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> > >  		return false;
> > >
> > > -	if (hv_root_partition)
> > > -		return false;
> > > -
> > >  	/*
> > >  	 * If Hyper-V offers TSC_INVARIANT, then the virtualized TSC correc=
tly
> > >  	 * handles frequency and offset changes due to live migration,
> > > @@ -529,16 +526,22 @@ static bool __init hv_init_tsc_clocksource(void=
)
> > >  	}
> > >
> > >  	hv_read_reference_counter =3D read_hv_clock_tsc;
> > > -	tsc_pfn =3D HVPFN_DOWN(virt_to_phys(tsc_page));
> > >
> > >  	/*
> > > -	 * The Hyper-V TLFS specifies to preserve the value of reserved
> > > -	 * bits in registers. So read the existing value, preserve the
> > > -	 * low order 12 bits, and add in the guest physical address
> > > -	 * (which already has at least the low 12 bits set to zero since
> > > -	 * it is page aligned). Also set the "enable" bit, which is bit 0.
> > > +	 * TSC page mapping works differently in root compared to guest.
> > > +	 * - In guest partition the guest PFN has to be passed to the
> > > +	 *   hypervisor.
> > > +	 * - In root partition it's other way around: it has to map the PFN
> > > +	 *   provided by the hypervisor.
> > > +	 *   But it can't be mapped right here as it's too early and MMU is=
n't
> > > +	 *   ready yet. So, we only set the enable bit here and will remap =
the
> > > +	 *   page later in hv_remap_tsc_clocksource().
> > >  	 */
> > >  	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
> > > +	if (hv_root_partition)
> > > +		tsc_pfn =3D tsc_msr.pfn;
> > > +	else
> > > +		tsc_pfn =3D HVPFN_DOWN(virt_to_phys(tsc_page));
> > >  	tsc_msr.enable =3D 1;
> > >  	tsc_msr.pfn =3D tsc_pfn;
> > >  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >
> > There's a subtlety here that was nagging me, and I think I see it now.
> >
> > At this point, the code has enabled the Reference TSC, and if we're the=
 root
> > partition, the Reference TSC Page is the page supplied by the hyperviso=
r.
> > tsc_pfn has been updated to reflect that hypervisor supplied page.
> >
> > But tsc_page has not been updated to be in sync with tsc_pfn because we
> > can't do the memremap() here.  tsc_page still points to tsc_pg, which i=
s a
> > global variable in Linux.  tsc_page and tsc_pfn will be out-of- sync un=
til
> > hv_remap_tsc_clocksource() is called later in the boot process.  During
> > this interval, calls to get the Hyper-V Reference TSC value will use ts=
c_pg,
> > not on the Reference TSC Page that the hypervisor is using.  Fortunatel=
y,
> > the function hv_read_tsc_page_tsc(), which actually reads the Reference
> > TSC Page, treats a zero value for tsc_sequence as a special case meanin=
g
> > that the Reference TSC page isn't valid.  read_hv_clock_tsc() then fall=
s
> > back to reading a hypervisor provided synthetic MSR to get the correct
> > Reference TSC value.  That fallback is fine -- it's just slower because=
 it
> > traps to the hypervisor.  And the fallback will no longer be used once
> > tsc_page is updated by hv_remap_tsc_clocksource().
> >
> > So the code works. Presumably this subtlety was already understood, but
> > it really should be called out in a comment, as it is far from obvious.=
  I
> > know this code pretty well and I just figured it out. :-(
> >
>=20
> You are absolutely right in everything above.
> Moreover, this imlementation will update the tsc_pfn early and will keep
> it the same regardless of the result of the memremap call in
> hv_remap_tsc_clocksource().
>=20
> This in turn can lead to an interesting (although quite unprobable)
> situation: kernel fails to remap TSC page (and thus use MSR registers as
> fallback), while user space process can successfully map the TSC page
> and use it instead.

I'm not really worried about this scenario.  If the remap fails,  there's
a broader problem somewhere and the VM isn't likely to live long.

>=20
> The code can be changed to be, I'd say, more evident (by assigning
> tsc_pfn to the hypervisor PFN only if remapping succeede), but the curren=
t
> implementation is the most efficient from the performance point of view,
> so I'd keep it as is (even so it's not very obvious).
>=20

I'm good with the code in your patch in its current form.  But add a
comment in the code (maybe where tsc_pfn is set) explaining what's going
on and that correct operation is dependent on the empty TSC page being
treated as invalid so that the fallback to the MSR occurs.  The next new
person who looks at this code will thank you. :-)  Then I'll give my
"Reviewed-by:".

Michael
