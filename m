Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B537F8C6
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 May 2021 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhEMNad (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 May 2021 09:30:33 -0400
Received: from mail-dm6nam11on2093.outbound.protection.outlook.com ([40.107.223.93]:15464
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233682AbhEMNa0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 May 2021 09:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxx2s0b0M4AIPqQyR2a9X8uvMbICAKYVTOyJ8fUW0Xnqtej2H5W3Il9IMIs/MtSI5QSOPSmd4KJVnT/1CP3cZOTxJdWLw4+YJEa/VBQsJ1gglmh49UbS90gA24sEjX+VMubn9Bwp9QXbMA7nxlleXB17zSPiyC3X3xAUJWXOI9qtJKl2J9eEL7orDn5uWZHb6j0pbeRj5gR0zG9DpACTpL7Gwepys+vnjCtcOTJR81GiwdjDjAWNZkNSbRYwDRoc4RjZa95ms0HuvQAgeU4dpT8+B0LeuPqldirtG1wK4AaqpAMH5ltPcozSMzsJWJGQMly21mlgfXk7wqVAn9cIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BimLK9ORUWDcrfDs6YAMxjSFv5lD8rK0xVQ5rTGJ4ZE=;
 b=RMCGPZTJVijA7+WW/v4d3du1v+5tlRuz9SLH25q3Lmsl93pAu7wOMyDQMQ9P/PBGdlh3aZ/QMHAefQHt4bNUOHcSV6GZPFzXGHtlDhbxnFDsSahpk0OVrAnaInF3cmlqy7e1q8AeyP2qtsNBYFae1b6ccNfDE+uOcyfCweSultbbzeJ4qapVBWWf6lfBdOx804Wg4Tc2tceMRt2/nRaTdI4ILD2UEqqHguVe+BACsTBfqbquHSWat55Tv/TOM3v8CX1HAeXO4U8nYuLBYC1MhphHVhlaeYTmJhpZstLVKKtNn0CoD0bZ1XclzbJN5mz6bfwgZz26qYkPvqnf1yVxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BimLK9ORUWDcrfDs6YAMxjSFv5lD8rK0xVQ5rTGJ4ZE=;
 b=eUjNArdLG02uqAeduIWnzpdVl+vEF31ipKLoHFsdfcV9rWQ17m2nr4+4xw4I9WJXVdqrrba4+5vRndogS/adcxpqqMEq1AsTge5q1OpwdNUdRj8wmKYp8feuF3k/e7FT+mlsrJi4oV4ni7c7EGlooPXWHXtmvAwKdQWxAQkiQmc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0479.namprd21.prod.outlook.com (2603:10b6:300:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.4; Thu, 13 May
 2021 13:29:12 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4129.023; Thu, 13 May 2021
 13:29:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mohammed Gamal <mgamal@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
Thread-Topic: [PATCH v2] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
Thread-Index: AQHXR8o0RJ8YAiwgrESS6i4iXccGgarhZ+3w
Date:   Thu, 13 May 2021 13:29:12 +0000
Message-ID: <MWHPR21MB15932C5EC2FA75D50B268951D7519@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210513073246.1715070-1-vkuznets@redhat.com>
In-Reply-To: <20210513073246.1715070-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c66f6c1-eef1-4cc4-8cf4-0d54d5b0de89;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-13T13:27:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e4423ab-02d7-4ab6-2804-08d9161318a9
x-ms-traffictypediagnostic: MWHPR21MB0479:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB047935C363DF344EE26E78DFD7519@MWHPR21MB0479.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81P2RmFvuBBLe4Pua3JwQPLfu31I4P7+w3hGWekVjpYGCc2kzBvnsFfIiGKVdEwjZWU8p2ebzD84C6/vaw9MQv0FZV4Xfk3+A03Yfrv5QuoXlOSfxYD2pJQZg2ZAf1T1nImY3wBc3oJHJRqXdnb/jySL9xP7i+NlHfPuTs3NDQ7U1Pm2FbCxjaSlNw2RvZOKsFc0uP6pQEIstc53buU+4jgxG121D5Ols1C3L9+kG+6FBKmJb5pidNEJgyIffS6oFRCAd01p0c66seg7MHlDfL+WN7Lwl1LCcwpN3xk2FFhdMzyNcrZ/e/jioNqWQuXD1DDLDLuyqZMaEqYBfpF7mfo+jfihHqnjrDfeBC/jb3NAwiOQSUb4eqetFdjtuDK+rQO70H/3c6+VPefKj6RngF2QAEPjfQy+2gjT+A+Bjy62GcH0yDltqn+rKKPfz2N3Uq+yGTe0+CbauOKEfonNle0/3D9hnqaW9T1jR8+JSvGyUXu7rrHQZ6mM8+y56JWG2u81asp4cmhDoZcnbCqd2XzXf5EwqtstwGlVgpkIjIQkEm28TtUBF0vmF70SarhcpqWYNOQLjRvGkggpTLT1HLfSw62bTaPjG8O+z1tEVk89gR8KotyUuTWyvio3j4FwLmLmodqyf6gV4vqV3YGmg56HeoRBn0+btsOxY2w/VjDj3DIMWYwmqm6oCjui0H8Db2uQUGC8yoQX4k9YhFNqqxOkXxDJTojVRCZZy5yXVqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(186003)(66556008)(66946007)(8936002)(64756008)(76116006)(5660300002)(55016002)(9686003)(52536014)(82950400001)(82960400001)(6506007)(2906002)(8676002)(33656002)(66446008)(110136005)(122000001)(38100700002)(86362001)(498600001)(8990500004)(10290500003)(26005)(7696005)(4326008)(71200400001)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U51pOGybax9tcjD9EqyQuSjtz+XK8IwQ2OBLCzcZMz50BbJBnq5ibshwSojU?=
 =?us-ascii?Q?ia0WVTS8GWZW36S4Vh+4Ok2v24d98AwlfnyZ9Ts5bNlc+POPgtJX2D9eR5g+?=
 =?us-ascii?Q?18JNtAutNoyzqzXAAOD6vac+eerFKvXPydfBGbjnTLw/br5hwWRKdC3hbvMN?=
 =?us-ascii?Q?E+l0q9a+jsFS88PV5NRBpudUxbxKgUkJRtQQHeZlpEmzqeSAvikSCZS9yC+T?=
 =?us-ascii?Q?XmH40GT3Dwh7JmHF8p7DIfbT0Ba7plXTDyRxzZMc8zdi4E5kGi7gZ0yggoz8?=
 =?us-ascii?Q?EFFUa1Dq3ThygX7bxp/RpM1xmwVg7qEAkIZCgeIR529ZMSycmQtdHlqbDo10?=
 =?us-ascii?Q?6C8WucwRPW2MQyxvk8QcYHK3S3oWW8rOAUsezWTA7yDFOhtObTnS5lc5m9AG?=
 =?us-ascii?Q?BiPDDR9NLQNTnv+uXKTOlve77Ho3hLUny8gT1U97CRYFnRhRYZZm8k4pw+rH?=
 =?us-ascii?Q?h6siNgI19ZaA3ln8wGhpTxXWSiP2dectrpMAH8donxfu1jOlvGLShv/MtTaH?=
 =?us-ascii?Q?MkWgKK5kiypEWiyBW/HbDf93Z+hJ5RQl3KhF70lqcplkBFI4BR3MD7oe0+G2?=
 =?us-ascii?Q?IMLeev+7mTAMZHw6i0rnHDJlAdjPo0GWCgHi60l8GaehssFLutnFCRqQidgm?=
 =?us-ascii?Q?gIyhLPtts9TBw5MGk6mCGunF7p0jN3EifdAbBp+IomqD9F5HRuALMrbb53jb?=
 =?us-ascii?Q?woxDTPe9rtSjUjXuvnXiiPmisbAPeIfYveAtNPEwICoc0zMFa8x+XUystZNK?=
 =?us-ascii?Q?HmGODHslBWciywL5gmFw2t0X12g97kX+u6ENy/QNZhb/TwG1f8g6fv6d70I8?=
 =?us-ascii?Q?yKvgM1vIxk4vZSW2/XuQY3H6w1tpzt5F/C1zuXHN1brF8YgCu6lF9r3SDTin?=
 =?us-ascii?Q?Nbp0wCitFXNAaoS40kELL11GdlwAr7xNMKn6/pCybvUE6vKLSkXKRMsim3DG?=
 =?us-ascii?Q?KG8PYDpR/kMtOwZoRtOYhDnbfWq83GhRo7dczwcx?=
x-ms-exchange-antispam-messagedata-1: BlT9eL/KG9O2gYJG+7w9AvtzKOL3VwKRoEzvjAaMo17vfkjbWnbCrzkxDXqHyV8ltHdjIAu+4lY/3j6iUDtnO3g/Kt/MNycKQ0IdMHVszxt/5Wni/WXAvmRHmVWULuod894CxtOXYza7Aky8E26+WGjUlkCyZgG18WsRt4yqpm4OVbsopH42j4sfPDQFsHIcWyf1ppw/dItgk5xV5SkbTTpwUu/jZhVdL1J15QEuRoi3guQXz3SphZescRzcRcUOJ8smHFmqWujaORlLguvDo0rSsw0F1hhmfz11A48OSW02EFWGmI4BuFSEmXMIDy8xxXtSUcxOmjAZ2+Bwdtg7Pixn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4423ab-02d7-4ab6-2804-08d9161318a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 13:29:12.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mo9yDSTE+lzPxlc+nX+hrrrlAnFdWAs7qil4lo4Pi2FJLGFEcCLQGGg34Gdt8zyJK07Hvm+0gj65RfI909dQNhtwRjoIFsfQqTvmyT1TGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0479
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, May 13, 2021 1=
2:33 AM
>=20
> Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=3D213029)
> the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
> differences inline") broke vDSO on x86. The problem appears to be that
> VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
> '#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
> a define). Use a dedicated HAVE_VDSO_CLOCKMODE_HVCLOCK define instead.
>=20
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Mohammed Gamal <mgamal@redhat.com>
> Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO difference=
s inline")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/vdso/clocksource.h | 2 ++
>  drivers/clocksource/hyperv_timer.c      | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/vdso/clocksource.h
> b/arch/x86/include/asm/vdso/clocksource.h
> index 119ac8612d89..136e5e57cfe1 100644
> --- a/arch/x86/include/asm/vdso/clocksource.h
> +++ b/arch/x86/include/asm/vdso/clocksource.h
> @@ -7,4 +7,6 @@
>  	VDSO_CLOCKMODE_PVCLOCK,	\
>  	VDSO_CLOCKMODE_HVCLOCK
>=20
> +#define HAVE_VDSO_CLOCKMODE_HVCLOCK
> +
>  #endif /* __ASM_VDSO_CLOCKSOURCE_H */
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index 977fd05ac35f..d6ece7bbce89 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *a=
rg)
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  }
>=20
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>  static int hv_cs_enable(struct clocksource *cs)
>  {
>  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> @@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc =3D {
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
>  	.suspend=3D suspend_hv_clock_tsc,
>  	.resume	=3D resume_hv_clock_tsc,
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
>  	.enable =3D hv_cs_enable,
>  	.vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK,
>  #else
> --
> 2.31.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

