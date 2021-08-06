Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC673E316D
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Aug 2021 23:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhHFVwE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Aug 2021 17:52:04 -0400
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:14433
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245379AbhHFVwE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Aug 2021 17:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsMLZHviycuRIk+UDuWssAPUPp4JP8RFXvdsFJLFuiDQm8jViyKFGWe4H1kgOid0RZEAyhEIg0fJSXTg5u3iihmNefEjvNOupknhflh/UdKzFNebvQpZM58S4TPRZCZy2qd5E1N0Hv5cS5kyvuaRsuz1jJDtdMe/kADxYWY2tLf961F7QuZRLDnM4H0jCkSWXiIN+LudlGFEc/7Jc8LrUbBaqHy7ORbEcSoSzRquAXPARRy1jSkHbDdo2KXMpN23//MAejX478+jjBue2W+CbI4NNEdpefIurrvO05yCSfZjQiWNatc9xvFaLeO/iKg5CJR6fxtRJH/YeCYs1z6D8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgY13AHPrXlv4dU4zEw02sCOnR0rf53F75U8dN2YYeU=;
 b=V+h0QaS5xjKVIulXVBDTmmvlvpU0n96acUAKyEytXUyFr3EuXtKIJkrWaGilaFmC/8RP9XLqt1w9mDIwPqLAXtwBRCUYJyjIk8x25Bs3+CHcM1sYY45wj4l3ehWtqtWEcUeOHFPxh9cKdTPXGekKBugCcjphJSri7t4Ofj3k1jqCKF9FpCLvBGKy5f22JXY8sDt3GrTF/N29mp7nI9AN2MwjvihuhI+DPoI8EItc6kc0wr+e6/mXBcblVy55pEe4ZRFilM5wHFKDQay8/7DiP6UGqGa6gzAorHuq2TkyRsn/mImiBRO9Wf4G7Bm7j5xCKu+pqMadKoW868yMMTXbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgY13AHPrXlv4dU4zEw02sCOnR0rf53F75U8dN2YYeU=;
 b=N3SXp+V42TnINJUxAscA3Rkymwa++iFnWIawqbc16dCvBfQyffqu7orWxqZX0Q2LmG83ENmfhbsPxJ3Vhy3QNn/RoD8Ham7plLYH3+H4H8Tcju5tW2lVA9i/xUOExXW7jFnIF/ph7rNmuePUhQ9p8LPjFJjrkr/EkpQudIY1ZhA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1772.namprd21.prod.outlook.com (2603:10b6:302:c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Fri, 6 Aug
 2021 21:51:35 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4415.005; Fri, 6 Aug 2021
 21:51:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     =?windows-1255?B?+uXu+CDg4eXo4eXs?= <tomer432100@gmail.com>,
        David Mozes <david.mozes@silk.us>
CC:     David Moses <mosesster@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AQHXiqRED5Xjx5or60CuT0JToyz6HatmQkqQgAB7OICAAAfkgIAANwRQ
Date:   Fri, 6 Aug 2021 21:51:35 +0000
Message-ID: <MWHPR21MB15935468547C25294A253E0AD7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <CA+qYZY3a-FHfWNL2=na6O8TRJYu9kaeyp80VNDxaDTi2EBGoog@mail.gmail.com>
 <MWHPR21MB1593A75E765DBFFE2B12C627D7F39@MWHPR21MB1593.namprd21.prod.outlook.com>
 <VI1PR0401MB2415830F31160F734300C576F1F39@VI1PR0401MB2415.eurprd04.prod.outlook.com>
 <CAHkVu0-ZCXDRZL92d_G3oKpPuKvmY=YEbu9nbx9vkZHnhHFD8Q@mail.gmail.com>
In-Reply-To: <CAHkVu0-ZCXDRZL92d_G3oKpPuKvmY=YEbu9nbx9vkZHnhHFD8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4ff1eb6-e146-4e98-acdc-9935188359e4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-06T21:20:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b7c24ad-eb44-4869-efb1-08d959245ca3
x-ms-traffictypediagnostic: MW2PR2101MB1772:
x-microsoft-antispam-prvs: <MW2PR2101MB1772C6A82E2A47C754545886D7F39@MW2PR2101MB1772.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NNbpexhur0vpHM9Uqc9lHtutgN+hdGLoIz38Wh1qqUhhtl/d25jeRVBQzBTYjJYJ5ayk6TwwhG7+hbwUb+x8VCnIJh3CWK1SCIpwW+MA8bUpyCx8G/SNQLNvBjUCb0FFIiHzT/vDQsTnhZACLM/amfhxyTKZBKaNFSuFzn/opgKJhofo73qNmgTPZk7NILanabfbSLq6tZYfT4QCDVbMcpcuVJP8A8MthNOuAK/g0ja0v8qkqjnBatGBcj9KmihbK+B+rox8pu0EUJhVWL6jeYDUREcBtApjE5//j1uIY5BbwELkFUE9RM+Ti/O65bnBJ6uspyQ3Nd7dNzorDUs43kd8XLZymJLlTSUCqgb1yEEJeBc2FJ9rivL2B3vUQieql2Bnb0O+F6DQSLm1FRVbZGhcsPM/PKZAiVSn3XzG1CaTobnQJWmiMD9lZH66Pvpl7JbhjfdHtmeTG21PLqBbboz7RCjCzoxEx3R15HgSLe6nkM7y7tMNKKtvHQsRv1lIkre9I4OaLUGTr17ily4C7IwgVn/OLVOsYOCe/hl6crX90ZTnKO9xQUlo+y69uenbPUDvt5T65tZw/Tj0w5SDPEFItRzxqt3fiwPhxtwkKIe6s4eEJSYqhE6k+1EIQFNh1CidAnxGfiSeIzNa0WeHwAM58VV5h0XEuM8Rar/dAJXrtNhOdcwsYoPPUUQ7VlpQJqmi5jQbCKJJ8G429eZUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(54906003)(82950400001)(33656002)(82960400001)(71200400001)(4326008)(52536014)(8936002)(38100700002)(186003)(55016002)(8990500004)(9686003)(38070700005)(122000001)(8676002)(26005)(5660300002)(2906002)(83380400001)(6506007)(508600001)(10290500003)(66946007)(66476007)(66556008)(66446008)(110136005)(7696005)(316002)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1255?Q?MTmHSVTuap+InjtXPNeydgPveQYHWd4s+zqCiPPsEwr6kkpclANF4NYM?=
 =?windows-1255?Q?dqWz/QqNynHdJ+TBj2D7q4hhDKRrq9h2fmfuqwWv8pCbdS9U+c8S4Aop?=
 =?windows-1255?Q?We52Ln5SZTj1SoaTkwpO6jSZfHbTrJ9IeY8tQHZGdZ58nP8nk5kz8RZR?=
 =?windows-1255?Q?Ebb8uRjfDYVq9F665uC+DB1XWLbSpRzMNYUtnGyS7H+mMuHO4+7UKofM?=
 =?windows-1255?Q?/XO3SOpAThqQZVed0PR9m3118f0A9s9Z2P2L8sEzvFJhJ/0wS3LRFQ0I?=
 =?windows-1255?Q?u0PmbjJq4HsRFxNXYsDH8kbGqzVjA/T/ByOs6j+Pbu+iTWCvXLEqb3Et?=
 =?windows-1255?Q?t8bGRfYXRDGOA8WGwMD5CyYFRVdEOC1HUkPpw932WeNplycTj2Hc8U0V?=
 =?windows-1255?Q?/2n00ljIPTKnMViJL7vo7z4h4dckKKnlh7PiAPNW8HJRY/7lykxL4bHO?=
 =?windows-1255?Q?tHF6OcEOFoAYKci9niYPGk+hsvVozQUXkulFJHuoX2MYS5MqAYk+FuFc?=
 =?windows-1255?Q?91M9I6VSqNiZnKKhZC7NviGCU3Hlqm6kg6d/fEJfQqiPDqBYcyQID4QY?=
 =?windows-1255?Q?VNFB6nvXAKH+RwdrQaWh/vhni2fBdYvyfeFV4EvMshtMtl8t1ibt0/e4?=
 =?windows-1255?Q?WMzFISuMr9HLRj10UBUrjBWvIZBVW+XMGRaL7DSVSDSB/yQDtCxldNi5?=
 =?windows-1255?Q?0K3dPV1QZCeWoHZr7b5SpPbKT/uO83NQkU+ysiyVPCA/EADsOx3gyLeg?=
 =?windows-1255?Q?w8FAVEC6zhtM56aihGHTnQ81OoncD8JWezJFfrR6y4kDWZG0p0yfRpZ6?=
 =?windows-1255?Q?bvCKbmCjaKiwpn4zD0weOOQhsC25VI9OwAxuYOjC4luOw2MkA//XRsXv?=
 =?windows-1255?Q?KUzhMqDRbKPKDXIApcq4Ih8e/fVxPdBoq+O/W9hDDM3TwB9HjN/9setG?=
 =?windows-1255?Q?vmBSNDfuqE79+0nx7iDrHl/2ayJ7oFHlGhP33cz9waZfPYTKqyOtCqFE?=
 =?windows-1255?Q?83x/iBo4L9ANPTOJl3DGFB/PP2dJz0ZCa1zzJW1nNNIxHWOqxO6+XpzZ?=
 =?windows-1255?Q?WE+pIK9NDP9qiWVzoQ92bkvmeMz6cQAo21D5dOFfeGBgVNbQRtkmUocI?=
 =?windows-1255?Q?KnqRQ4Y6W4hVdxdB4EQeaHGd6sm5X3WbkQxR7T60GfRbxXi5e8JbPqqP?=
 =?windows-1255?Q?24OFHOHr3cLcogCS68iDkZG8pSmfGLo/m4/1Z3/ASlpEX9qH7S3UWz/K?=
 =?windows-1255?Q?fj1fiOzI7n22M9tmYq65FN0BvEl+sn+GGkUqfSYlxsnUVp9XfwWpQoMe?=
 =?windows-1255?Q?mYbrOK5AEiLB7gQ+bNH7pjuVkPkjiEP00NhyFOkUn8HeyKWsWi42PSzo?=
 =?windows-1255?Q?2s1DdvhwNklWioO57kUlZA9Qd33RSvaFwAbHFUUFHGFQ+hZ3M/2jeaVh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7c24ad-eb44-4869-efb1-08d959245ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 21:51:35.7108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJMRDe23N6gV4/kJ65mUNY/oPv7gFCF4BdX6ixDQSqGTNR7MXzmoMZ+hIdDduTbQU0xKpu0cbDtHMVJkdAx/zDfEaHniaT3sGLgYoFur2DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1772
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: =FA=E5=EE=F8 =E0=E1=E5=E8=E1=E5=EC <tomer432100@gmail.com>  Sent: Fri=
day, August 6, 2021 11:03 AM

> Attaching the patches Michael asked for debugging=20
> 1) Print the cpumask when < num_possible_cpus():
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index e666f7eaf32d..620f656d6195 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -60,6 +60,7 @@ static void hyperv_flush_tlb_others(const struct cpumas=
k *cpus,
> =A0 =A0 =A0 =A0 struct hv_tlb_flush *flush;
> =A0 =A0 =A0 =A0 u64 status =3D U64_MAX;
> =A0 =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned int cpu_last;
>
>=A0 =A0 =A0 =A0 trace_hyperv_mmu_flush_tlb_others(cpus, info);
>
> @@ -68,6 +69,11 @@ static void hyperv_flush_tlb_others(const struct cpuma=
sk *cpus,
>
>=A0 =A0 =A0 =A0 local_irq_save(flags);
>
> + =A0 =A0 =A0 cpu_last =3D cpumask_last(cpus);
> + =A0 =A0 =A0 if (cpu_last > num_possible_cpus()) {

I think this should be ">=3D" since cpus are numbered starting at zero.
In your VM with 64 CPUs, having CPU #64 in the list would be error.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_emerg("ERROR_HYPERV: cpu_last=3D%*pbl", =
cpumask_pr_args(cpus));
> + =A0 =A0 =A0 }
> +
>=A0 =A0 =A0 =A0 /*
>=A0 =A0 =A0 =A0 =A0* Only check the mask _after_ interrupt has been disabl=
ed to avoid the
>=A0 =A0 =A0 =A0 =A0* mask changing under our feet.
>
> 2) disable the Hyper-V specific flush routines:
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index e666f7eaf32d..8e77cc84775a 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -235,6 +235,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cp=
umask *cpus,
>
> void hyperv_setup_mmu_ops(void)
>=A0{
> + =A0return;
>=A0 =A0 =A0 =A0 if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDE=
D))
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

Otherwise, this code looks good to me and matches what I had in mind.

Note that the function native_flush_tlb_others() is used when the Hyper-V s=
pecific
flush function is disabled per patch #2 above, or when hv_cpu_to_vp_index()=
 returns
VP_INVALID.  In a quick glance through the code, it appears that native_flu=
sh_tlb_others()
will work even if there's a non-existent CPU in the cpumask that is passed =
as an argument.
So perhaps an immediate workaround is Patch #2 above. =20

Perhaps hyperv_flush_tlb_others() should be made equally tolerant of a non-=
existent
CPU being in the list. But if you are willing, I'm still interested in the =
results of an
experiment with just Patch #1.  I'm curious about what the CPU list looks l=
ike when
it has a non-existent CPU.  Is it complete garbage, or is there just one no=
n-existent
CPU?

The other curiosity is that I haven't seen this Linux panic reported by oth=
er users,
and I think it would have come to our attention if it were happening with a=
ny frequency.
You see the problem fairly regularly.  So I'm wondering what the difference=
 is.

Michael
