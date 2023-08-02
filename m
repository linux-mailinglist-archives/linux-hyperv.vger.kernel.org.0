Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9276D059
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjHBOna (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjHBOn2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 10:43:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2108.outbound.protection.outlook.com [40.107.223.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969201FC6;
        Wed,  2 Aug 2023 07:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNn3zR1agQhH9xOBuX8KXT6v52Ul39BQ0IM4NxqojYRPrNTjX1cYkEIm5wFXbvoMVJDZo83pP3u2EGxmHG4ZOdJ+74xTvNPCXVpLFzIIUCB5hqcamD20SYrM2oYqVJ1aLaNx6AMoNLL7hcl9xAg9pcnm3jIXmsZM4r2s/JxM6/zw2mQPEwoHL05wOYd1P/2VrJDRk7Bya9UsN9GBjgvzjwuZmsoC6mlohT1YEdev9tWVaD9Zj7DBFk6dXBA3VvxRkIHjJ39MgVO7GHHLWwG7zKNiIBVOpyWfvND/KtSkBc7C1vOVSVz8dBUR/hFhpeAShQ7y7g5ujC7tDDSLwnGa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTrNwHVDzUoXsoct3oYGNQHvzrTESaPdRSACIrlZn4E=;
 b=Ib6vt0IImY8lK6o7SHN6YxX3aQ4cUv8beGGtbkGef3Y3/4rmHozLJLxyGY0F2bP/mQ70nry6tUcaoRkteET4dHLrRKC5DHkY7RKoWKPnho04rE+TFERxULFp8zGv28jFJvTOtNtC2DjMXvuqpfq+Q0672uAbO+oywm/vU9Z1yMhTSYuMXVuL/LsQ4XmW3EkKxMkksQ1aCtkgkg9uYl4yhgbbPfLcL9h9h9rbGu3Uj6jYl0FDUAXxzotlA389eFB6VlSNFj9wOjiuk+VSI/xhpdiaFHp3WlmNCS0s3xSb5pPnX1ngkiUcBevJP2BJFHzCe0G8RqZP3Xls5CA5uhDYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTrNwHVDzUoXsoct3oYGNQHvzrTESaPdRSACIrlZn4E=;
 b=CQwLEFO98xelFRaL3ZC7BnKgrdne/AUpUnLcw4x1rypiGmhKZEjnIwMsrUWE4z3TXSfDnovkk/x+JpE4A+KXtm3PWYgL/D9wrwpRT4IYdByljmGZFf35lxxSGY+v/CPxqtoJAYshxiREvxRI60iFhVCT8EQRJ8XtRNIU7PCy3go=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA3PR21MB3960.namprd21.prod.outlook.com (2603:10b6:806:2fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Wed, 2 Aug
 2023 14:43:24 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 14:43:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZwU0WNJnrG48S4EOlGyY6cNlaEa/TN7UQgACcb4CAAA6xAIAAJKKAgAAGaoCAAFBRAIAABtHQgAAQnICAAZXTgIABDhqw
Date:   Wed, 2 Aug 2023 14:43:24 +0000
Message-ID: <BYAPR21MB168857260253C87A3BB46EE5D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
 <87sf94nlaq.ffs@tglx>
 <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87fs53n6xd.ffs@tglx>
 <BYAPR21MB1688CE738E6DB857031B829DD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <873513n31m.ffs@tglx> <87r0omjt8c.ffs@tglx>
In-Reply-To: <87r0omjt8c.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4e0e54c-ff17-429d-b296-b3b29980d71d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T14:31:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA3PR21MB3960:EE_
x-ms-office365-filtering-correlation-id: 821e3a52-d66f-4593-fee7-08db9366d32c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BQ08/O+vmE3JDnlqpNmBuV+yr51vPueP5e3sklEE0miznX+g1L50hr6HJGxF14LHg2fd5Pq70KVB/nZixD5epYwNld1+buT5Glp0ItFmzFu95MghQ/6REmlMHil9KrtdD1o3c+s+36i0ofbZF2OiSrnyEdZPA57i+mM4uWUUE9sr8G9oUlsm1t6JpkdWohI7dBKo0dvC3aB+r3xJ1GgPVT7yPAlki2pAkfTnoOtN7wCSZeXLhWik9d2hEVSj9Btt0xUUAhHZYl+qlWLBgVUCtfSPTxKiANJnrhbaL9/dVkS8i+9B1fLRTG1RG3fmFlF8swsnrNC+KCmtghEeHZRFC66oDhKBQmoQvSEgVj58uKDqtYV2QaO/xTtd91VgFDXb7MVXx61QUyI5Xp3h/rLRMApSbWrUaFNE1R0ioMXstlG3bJXs9H7Zr2Rycis18KsDcdLsCt3316m2vxsP4gzRPQatNcT6TTNU2YuWe4GhQy9t5UmvvYi0Ax+zU2zyVRlcttAjxDHoVAAAEKVFQA3TaScVrV+I2/zDuR9vVSUMIEGzpxdW4CXVyeX9T6aLarMgNEAgJNG8mLmsVPnJ4HFFSAPWyLX5afQ2HzHr+GC+qIHN5iUOI+mL++eiR32ZHDchEe1MsGbTqxND66ks5lf0AufVpuUnQD5uuDOdXqZ5cNw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(122000001)(82950400001)(82960400001)(33656002)(38070700005)(86362001)(66899021)(26005)(9686003)(55016003)(38100700002)(478600001)(5660300002)(7416002)(2906002)(71200400001)(7696005)(10290500003)(76116006)(64756008)(41300700001)(6506007)(8990500004)(8676002)(66476007)(66446008)(66556008)(186003)(54906003)(8936002)(110136005)(66946007)(4326008)(52536014)(83380400001)(786003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?saEGzPBLfl6npkDMWlT5LPlk0bBlRwshHud3N3qgIBlAhM1uhgKHYDh6kw8q?=
 =?us-ascii?Q?AZOydcmwhQrGOo92Z889Oy4RXRuRaShd5/pAXjj5cJmWEWdpMYrhn3M5tnel?=
 =?us-ascii?Q?KUyRFAlqrJAbiBBs3mlLdNehCjhb3M5NXWKJ9AK72BrAIfH4qeVAjW4OPj+N?=
 =?us-ascii?Q?fFnZOBXZorUMxEeggM9h8NN3up49o6wzw+yHh9nvAPSc8ppB6w6LTTgazYJL?=
 =?us-ascii?Q?ROQ6LJoexjfy9ZEGPYpHitrizc11/mPA2GsdxC9TulEXi/BUVfj1yXMUxWtB?=
 =?us-ascii?Q?UEU+lEhQsO420UvOG5eDeAPI+ib1EyXrIM4ddmrLENb2RmoDxljO074qkie3?=
 =?us-ascii?Q?LYmfBagB2eninO9GlY8vtpxlN25QeXqVEQ+FOQA88LwADu2EqTXPVFGPQ6GZ?=
 =?us-ascii?Q?8Ll+TCEUIgMJHIJgU3s+39OWQe4CBGuCfdE2hd6lUKd1m3oyHAqol2Nj/Ey2?=
 =?us-ascii?Q?fl0pqDGw0QQTbfg2aFcK0WSWw4iXAZtFij1Z4oRzqoQHjHK37tVUtvd+NIUv?=
 =?us-ascii?Q?bzQUsIiaYoKZj5y4RcJxWMg8KMSzHHQkBmdN5kgLA23907xDpFPqAAlP1A4D?=
 =?us-ascii?Q?yWMO3O7bBQJYHKhqHUBwy52g/kChzFP2FosUowUM7SM3JOSdMeH3Tfsd9Xxo?=
 =?us-ascii?Q?fLpLODqgZvWpbN1MzqgFKOZF3Bri8AE6pgl1PyQHDp8lDMt8TPT0LQMbZtyR?=
 =?us-ascii?Q?KJurqWsA5FwM4F5xqsZC0HLw3t0D6ZjsF3yrq8k2ablXRcR3cwou7rclj5W7?=
 =?us-ascii?Q?fo+8/nekPNnHwB0UoFj0MqSODgZ5m+dGlwsMhwxo3gQUIVZi5yNkfRLy5tiN?=
 =?us-ascii?Q?qPbvygb7OI8SliI4cuEFjbPhITyGzXKpJjXIUQKG850ifqDTeIPoW2jIpdzk?=
 =?us-ascii?Q?mcedbo3UWgCThH4N84aG6dYK3Vz3DSPMh2yPTHM0CyOgAlZFZ3PYZT+1+LHV?=
 =?us-ascii?Q?OmtOP0HazE63tinTSo/mi17Ynv5cnJ69vzikOsvu9GvOEpPev+3vpNHID0SA?=
 =?us-ascii?Q?HBh4r90MMH+yUr0/mNN3iukQMoBTWCUQymfQSwMam0vp91NHcSJUJZBKyK4T?=
 =?us-ascii?Q?rS5f9V+JDR6fm6YMeZC75B08k1QMypss7TKyXKHMA9ge+XLQsHBpLSH6IqWl?=
 =?us-ascii?Q?atEG5QaydH9YsMjITG/73WtcxgNVFjZEF4aKHNe88gj/NcOLSJCQMxrDT0Qm?=
 =?us-ascii?Q?ZhA0y0Gnf5hBdx7dZFCmFRd1US7YvPgkdu0x8/OrmS/KMfPZ9ELThknedbvk?=
 =?us-ascii?Q?s/VeS1Aqd5G6vk8Rrn8ysg993ypm/dQGqWZ/qHlhFJtW5/0HHeTPw3oUnLom?=
 =?us-ascii?Q?4jk4kDer5cqUX7iPZGTApnudBJ2288Y9MC36ZgAYkbpbB6lSlyEc80IMt1dj?=
 =?us-ascii?Q?TaNjnlznoY7y39smoEexW6oGkWf4X/ehTmECaG74JZ9h7kWML2V7v4mbZIzm?=
 =?us-ascii?Q?JYYkj+rhKsspTXl0d4zOo/GqFoC3Hqbr4V48c9CFFY11W4GPIV3ledMlOm44?=
 =?us-ascii?Q?95VkA/scpqGRf7/0zmuemPA8+vfYn6NTXA0XnCSs/IyUXnJpGhwKFBq2/HmI?=
 =?us-ascii?Q?Ojy9mOS5HKOtwN7I2mJScbKUji/p01vvz6lE8prFfTRAKyDr4jop6+JirSv2?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e3a52-d66f-4593-fee7-08db9366d32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 14:43:24.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ANLyEuqSUq9xOMnYekX5WKOmeJesUiyc1xVaQYf6kdUmKFURPu63NAQNmriDXon/PyF+3WIOLsQuiBpPxJB/dtbPFPlzLPZxpaVuWplVzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3960
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, August 1, 2023 3:=
25 PM
>=20
> Michael!
>=20
> On Tue, Aug 01 2023 at 00:12, Thomas Gleixner wrote:
> > On Mon, Jul 31 2023 at 21:27, Michael Kelley wrote:
> > Clearly the hyper-v BIOS people put a lot of thoughts into this:
> >
> >>    x2APIC features / processor topology (0xb):
> >>       extended APIC ID                      =3D 0
> >>       --- level 0 ---
> >>       level number                          =3D 0x0 (0)
> >>       level type                            =3D thread (1)
> >>       bit width of level                    =3D 0x1 (1)
> >>       number of logical processors at level =3D 0x2 (2)
> >>       --- level 1 ---
> >>       level number                          =3D 0x1 (1)
> >>       level type                            =3D core (2)
> >>       bit width of level                    =3D 0x6 (6)
> >>       number of logical processors at level =3D 0x40 (64)
> >
> > FAIL:                                           ^^^^^
> >
> > While that field is not meant for topology evaluation it is at least
> > expected to tell the actual number of logical processors at that level
> > which are actually available.
> >
> > The CPUID APIC ID aka initial_apicid clearly tells that the topology ha=
s
> > 36 logical CPUs in package 0 and 36 in package 1 according to your
> > table.
> >
> > On real hardware this looks like this:
> >
> >       --- level 1 ---
> >       level number                          =3D 0x1 (1)
> >       level type                            =3D core (2)
> >       bit width of level                    =3D 0x6 (6)
> >       number of logical processors at level =3D 0x38 (56)
> >
> > Which corresponds to reality and is consistent. But sure, consistency i=
s
> > overrated.
>=20
> So I looked really hard to find some hint how to detect this situation
> on the boot CPU, which allows us to mitigate it, but there is none at
> all.
>=20
> So we are caught between a rock and a hard place, which provides us two
> mutually exclusive options to chose from:
>=20
>   1) Have a sane topology evaluation mechanism which solves the known
>      problems of hybrid systems, wrong sizing estimates and other
>      unpleasantries.
>=20
>   2) Support the Hyper-V BIOS trainwreck forever.
>=20
> Unsurprisingly #2 is not really an option as #1 is a crucial issue for
> the kernel and we need it resolved urgently as of yesterday.
>=20
> So while I'm definitely a strong supporter of no-regression policy, I
> have to make an argument here why this particular issue is _not_
> covered:
>=20
>  1) Hyper-V BIOS/firmware violates the firmware specification and
>     requirements which are clearly spelled out in the SDM.
>=20
>  2) This violatation is reported on every boot with one promiment
>     message per brought up AP where the initial APIC ID as provided by
>     CPUID leaf 0xB deviates from the APIC ID read from "hardware", which =
is
>     also provided by MADT starting with CPU 36 in the provided example:
>=20
>     "[FIRMWARE BUG] CPU36: APIC id mismatch. Firmware: 40 APIC: 24"
>=20
>     repeating itself up to CPU71 with the relevant diverging APIC IDs.
>=20
>     At least that's what the upstream kernel produces according to
>     validate_apic_and_package_id() in such an situation.
>=20
>  3) This is known for years and the Hyper-V Linux team tried to get this
>     resolved, but obviously their arguments fell on deaf ears.
>=20
>     IOW, the firmware BUG message has been ignored willfully for years
>     due to "works for me, why should I care?" attitude.
>=20
> Seriously, kernel development cannot be held hostage forever by the
> wilful ignorance of a BIOS team, which refuses to adhere to
> specifications and defines their own world order.
>=20
> The x86 maintainer team is chosing the lesser of two evils and lets
> those who created the problem and refused to resolve it deal with the
> outcome.

Fair enough.  I don't have any basis to argue otherwise.  I'm in
discussions with the Hyper-V team about getting it fully fixed in
Hyper-V, and it looks like there's some movement to make it happen.

>=20
> Just to clarify. This is not preventing affected guests from booting.
> The worst consequence is a slight performance regression because the
> firmware provided topology information is not matching reality and
> therefore the scheduler placement vs. L3 affinity sucks. That's clearly
> not a kernel problem.

Yes, if Linux will still boots and runs, that helps.  Then it really is up =
the
(virtual) firmware in Hyper-V to provide the correct topology information
so performance is as expected.

>=20
> I'm happy to aid accelerating this thought process by elevating the
> existing pr_err(FW_BUG....) to a solid WARN_ON_ONCE(). See below.

Your choice.  In this particular case, it won't make a difference either
way.

Michael

>=20
> Thanks,
>=20
>         tglx
> ---
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1688,7 +1688,7 @@ static void validate_apic_and_package_id
>=20
>  	apicid =3D apic->cpu_present_to_apicid(cpu);
>=20
> -	if (apicid !=3D c->topo.apicid) {
> +	if (WARN_ON_ONCE(apicid !=3D c->topo.apicid)) {
>  		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
>  		       cpu, apicid, c->topo.initial_apicid);
>  	}
