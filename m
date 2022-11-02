Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5A616FB2
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 22:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKBV1S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKBV1Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 17:27:16 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021014.outbound.protection.outlook.com [52.101.52.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE769E02D;
        Wed,  2 Nov 2022 14:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTLaGJFcMwQTP3F+LVpl5S88i6YwfP+KFU3TMoyArVvBHko36eoAVfIPuDzip6AykQjkAog9mC02GH6OmJ7l6uX4nYxYuzXZC90y1MQeNNhfg2Pq56KP6hi/hdDdY2/kCuQ6afoUR15wsjtHwpiWvbYu7qAtOlqkr87/sTiRQ/Ka5Y31skpwuvJGBKAjuF48afqqApwjElwfaQugfygwwnqtTftenglZeco0z22ER0gNu4LhvzTrSYWiC3SthsUuVTApBa/40iI3tVw7pA2u3iQKx1cKwOKiV1fqEWOu8bv7anspnkCD710T27WNE4tCojDjUyYU3hSAJ/APLcUr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lym0FUYkv1k3WIqOtAylhejjJdhzJLqVjfNfDqsvm84=;
 b=PciYrDgDmC4ZHzPTzwyq47OWNFiS0GPcOFsKHbkPVUFSPGN1WC5pE+mL9u0f0XB8LGb8O9o11z0J03V2PCCQy7wZ8TwM5oxoNJs6HP2hCmYHXgpRE7iNR8gs7Nz4FjNsosYIZn5OkA2ok4S3ZAC41UXT32zMtyle7g07ox57jzTBPFP+O6RMyxFSORS0XwKCLzLf3/qUe+X+iYwU4AOa9FspDMMh3h6wdANnV+XFDVMtytAoPpNg36PhRsCly8gI3Bt4YCuFyVxzYLESoKoPEmvt1YJ939o7Z/TUI13Zk2QkJDE7SdxfzjNGlAd32br5EQ/bMy0oScziH0fFxbhS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lym0FUYkv1k3WIqOtAylhejjJdhzJLqVjfNfDqsvm84=;
 b=NyoFBbz+cY1fhm/rYLUhO/jJh5E1pqW2Py1De6vQwzlVwbgUp6GLmZy86L95obhzvX01pE2Rmvvq4woYOvAO2xqjT/EV9khbED/1tEpIhMoUN6+Em8BJ+vItn/poDayL+bwpSKY8uswL7fQ0sDQjrMln/7o9kY20K5msK3j//xQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3710.namprd21.prod.outlook.com (2603:10b6:930:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.4; Wed, 2 Nov
 2022 21:27:07 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 21:27:07 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Thread-Topic: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Thread-Index: AQHY7hfGdFg8W+TW4UePjgHc2LBts64r/kcQgAAHSwCAAA0egIAADK+AgAAFBAA=
Date:   Wed, 2 Nov 2022 21:27:07 +0000
Message-ID: <BYAPR21MB1688B5A6005EAA6980E07DA2D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB1688C426F44E40E1415DCD21D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CA+DrgLzYpFHUzYmvP_qhTMkaYhjRsgW3eaQfMYYpGiE2AHzjLw@mail.gmail.com>
 <BYAPR21MB1688D5D33AC0D7D88AF6FD7BD7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CA+DrgLzLATDPvO-Ngi5O5kMx-zqBVYtx+GmM=8E5y3P1X0fMsw@mail.gmail.com>
In-Reply-To: <CA+DrgLzLATDPvO-Ngi5O5kMx-zqBVYtx+GmM=8E5y3P1X0fMsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d06a8be-b48d-42be-9f49-3cb43bfbd030;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T21:15:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3710:EE_
x-ms-office365-filtering-correlation-id: 6c049bd3-0c29-41b4-8801-08dabd18fecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMyA2DtFAQnOPnS7x1ds+2yjyUHb7kC+gZafN6BjY0T+Guy0egjzTHLR1+9PB5FOsOLyyUzPvMq3n+wRZitV0UbOwIDJUs8Zx8uj77aCL7Tv+tDWpJ7V9/qnsxvWLZFbe6L38zzApa3c2ykqr7geJJVRB/25OJ4/+KtTHD94O88ixBBrvu78f7V2ko0n9fIbQkAbB+sSZe1/4GxImzO2x5IZOZV5hN4lEoOcAW7AtKRrFpWJLOiN8YcXwzGf5me8rWy5LQiWaogRTsuTn/6gSMNMhlEGx4XV0dpcOxQc5Vjn+ZGHUW60O4zsO6IeEucHm7AW4o87illmWqPlBfIV0zFSXEvShPC7d8QsWnHubT5aDsWS8Uyo8exqFYr4Xvr984ai6jciFigSV/XXyr+WS+CqwkagrAD0obST4SPS2u3Hvr/RxY2SD5WGiHup5dRCb2WWv0XCSJQxEooscGXXsnfTHtV4gUZ4khMikb1LIe4CF/YQNmatKWs6Ruvsah8jQ0YMzYDnR5DFKHG+mm8YfwRL+ZgnxLDm7rAHOlKnxphRpeQJHFFg3qhFey7AWoNPosFUgf9l+TJy7tTeCZKVO5TCvay32GbzrPqDgrNl4mRRlhjbgYStFQMwmfZYp7EGc6ygskBtqQ6wIjSjbBRiHWcXeluqp5tN/JjB3NlPesX3iknWKzHxsHc44hHARK4pcH1UKwgYl0EvrmowyHHc4RbzlXsjGn2aebRC7Z19Lvr9U1xgqhB+OGCcqrx2KrOaxJb/CbHMCC3BWOVQq89g3Fy5iHtyEX4YcAtrhiGY/VZN+eJ10DxFYRbvmDUHD2VK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(5660300002)(8936002)(186003)(66899015)(41300700001)(8990500004)(83380400001)(26005)(2906002)(9686003)(38100700002)(316002)(86362001)(110136005)(82960400001)(54906003)(478600001)(82950400001)(4326008)(122000001)(55016003)(38070700005)(64756008)(6506007)(66476007)(66556008)(76116006)(52536014)(66946007)(7696005)(66446008)(8676002)(10290500003)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?tOKHJZ57tdsD9d/g7AwH6bHTEi3YgFZInGLHugAdJ16s/uPfkUPV4yqM0VltfP?=
 =?koi8-r?Q?GTr7oEdcLlDIVTqksAFmjW7CGPSe+LzLIBNNdnPleubIzc0XZ1Bc0DwYjK2xjq?=
 =?koi8-r?Q?YnIX27SXIIuUzx/xf4Us/RUgr6l1u/PKjdSnuzS9nRKaMwyATLE4YbPbRzH/6G?=
 =?koi8-r?Q?ULTMyCNPCrnnGRMRdIn06tZjrxT3Fp645UBumwB/ftzC3bZ1uBQsbKXlWH5K1N?=
 =?koi8-r?Q?q66MFCYDzzImz5vadO60OJpNt72zJtqkENM4ob9F88S06TtoF6BKDxb6lt28kP?=
 =?koi8-r?Q?YBNpH3MPjTDTIgYdy02nAlocjxIU57Tl3AgSgxdOONApVbV/2r8MYGn4OxOXlB?=
 =?koi8-r?Q?YPtDqtFOsIW+b7rtYBhRFC2UDIq9T3bVaomZlaz48JJgxhVu/vY42/SS1/skcf?=
 =?koi8-r?Q?ZnRNfc6E1XVMUUJBMYZfaPu1Vp2S5V1QL4QwBh+7DgXWIVqbD0aVpeJB0sNnJs?=
 =?koi8-r?Q?exN9Z4YZnz1FqTcVXxUrhBlcPOvPJ3MAkwejX608y72gaMxkrP8AwQWEC8mizE?=
 =?koi8-r?Q?vmyMfQwrJqEah1HJCRyclXDt4tn9Q+JXSvHURunQOQOgnVQI4VwMa/JujdKB26?=
 =?koi8-r?Q?ogGnkvA78xm9qNY2QZCDVifTR/CWK9qi56vyzV4O+oesipH6HhbfYb7jRMwUD2?=
 =?koi8-r?Q?VlSfKfa9XYNB1nTIk8I93IovOkbRN+a+JEqizcvEZ1JcoCcQ+hwIsloyvjZoxe?=
 =?koi8-r?Q?+59J15ei8BZxqAI49jfWIxA4ztz7UQgObbKKf9mw78inpPBG7htHfRyJzQD9H/?=
 =?koi8-r?Q?fnokRv/Ngzra4OaoSMEaxKm92jYsInDOirUlBhsxutSLcYelGIpee8JH/LCpaJ?=
 =?koi8-r?Q?Nk6Lg1HSwCewSg2JWftpKysB+2biwIsEEC7taoQJQ7Je7hioyKd605tlvaxQT2?=
 =?koi8-r?Q?Q4Rk7Q9HdWgvk1anv/C1sodqDHsCte4npD9qAIl7eOvYtYKbZXGOq6MqZf048y?=
 =?koi8-r?Q?BANCGwOIUIffrtDwFDTwdGJf9T5mp1f1XTls75IfDw9OTibugEjfAdNIJB7mL/?=
 =?koi8-r?Q?HdhGzvlAKtBE7dcIzfggqsqArD2MCzLIEF33LP+yYS/BUAKZk97WiBwFABOh9h?=
 =?koi8-r?Q?8FbsSwl5M6XgNUp93ebC7fAK280s5ov5ruSLthAXuCMEJ6iPfxjUienCoPA4y7?=
 =?koi8-r?Q?cEnaqfym88CRxnaNDtk5+1TNsNQIFNcKgasgh1abqpaD0NplmSwt6kS7Nr2XA2?=
 =?koi8-r?Q?LBjRLj8UccK0mEVbwNqQNLS5hTz4fUANArn9kH9yAIw4u+0zoG/2ZI1uSDxxQa?=
 =?koi8-r?Q?RecOdlaxGSjfNHdYbqXSmLeEC+Vq0KXry2YdnZ+ONGnf/V4k1xI0aEufKQ+t4S?=
 =?koi8-r?Q?tqg2c3Hj0wzvu1nBnOqd1sVPE78gyqD2BAaMMmA0wd4yD9CJ7Xf+4neFCchWOC?=
 =?koi8-r?Q?kNvKuX/qjwGDk595P/C+9nqKNH5vg0Wtv6n8NOWg20+dddNBZzmSZkd9P/EhB0?=
 =?koi8-r?Q?W3p834fkOG0RxUjefh9Na0f00WqBes/JXvtGZUqZLA2kQQCiPHGq6IK1LMobkw?=
 =?koi8-r?Q?9FZlgQIXKTaYBW08Fvx3miS1B2785oAWhKdOfm9Ht6/V6WQWCuWlfofWrjwXnl?=
 =?koi8-r?Q?Yhxu5JHJpA=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c049bd3-0c29-41b4-8801-08dabd18fecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 21:27:07.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRZ9C41sSrtqCvmbQsh1+u0H/uVFHP2SZS31uA5jvC977v5Wi7FIid4usIt3gqGCm4NGM+XK2pYF2JWuLN78YdZRnZX96AijtpDm7G8iXZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>  Sent: Wednes=
day, November 2, 2022 1:58 PM

>  =D3=D2, 2 =CE=CF=D1=C2. 2022 =C7. =D7 13:30, Michael Kelley (LINUX) <mai=
lto:mikelley@microsoft.com>:
> From: Stanislav Kinsburskiy <mailto:stanislav.kinsburskiy@gmail.com>=9A S=
ent: Wednesday, November 2, 2022 12:26 PM
>
> > > It makes sense to have the tsc_page global variable so that we can
> > > handle the root partition and guest partition cases with common code,
> > > even though the TSC page memory originates differently in the two cas=
es.
> > >
> > > But do we also need a tsc_pfn global variable and getter function?=9A=
 When
> > > the PFN is needed, conversion from the tsc_page virtual address to th=
e PFN
> > > isn't hard, and such a conversion is needed in only a couple of place=
s.=9A To me,
> > > it's simpler to keep a single global variable and getter function (i.=
e.,
> > > hv_get_tsc_page), and do the conversions where needed.=9A =9AAdding t=
sc_pfn
> > > and the getter function introduces a fair amount of code churn for no=
t much
> > > benefit.=9A It's a judgment call, but that's my $.02.
> >
> > As I replied to Anirudh , AFAIK virt_to_phys doesn't work for remapped =
pages.
> > Another option would be to read the MSR each time PFN has to be returne=
d to
> > the vvar mapping function (i.e. on every fork), which introduces unnece=
ssary
> > performance regression..
> > Another modification would be to make pfn a static variable and initial=
ize it
> > once in hv_get_tsc_pfn() on first access. But I like this implementatio=
n=9Aless.

> > Valid point about virt_to_phys().=9A But virt_to_hvpfn() does the right=
 thing.=9A It
> > distinguishes between kernel addresses in the main linear mapping and
> > vmalloc() addresses, which is what you get from memremap().=9A But I ha=
ven't
> > looked through all the places virt_to_hvpfn() would be needed to make s=
ure
> > it's safe to use.
>
> Yeah, I guess virt_to_hvpfn() will do.
> But I'm not sure it the current code should be reworked to use it: it wou=
ld save only a
> few lines of code, but will remove the explicit distinguishment between r=
oot and guest
> partitions,=9Acurrently reflected in the code.
> Please, let me know if you insist on reworking the series to use virt_to_=
hvpfn().

Your call.  I'm OK with leaving things "as is" due to the additional comple=
xity
of dealing with the vmalloc() address that comes from memremap().
=9A
> > However, thinking about virt_to_hvpfn(), there's a problem with Anirudh=
's
> > earlier patch set that started using __phys_to_pfn().=9A That won't wor=
k correctly
> > if the guest page size is not 4K because it will return a PFN based on =
the guest
> > page size, not based on Hyper-V's expectation that the PFN is based on =
a
> > 4K page size.=9A So that needs to be fixed either way.

> Could you elaborate more on the problem?=9A
=9A
The key is to recognize that PFNs are inherently interpreted in the context
of the page size.  Consider Guest Physical Address (GPA)  0x12340000.
If the page size is 4096, the PFN is 0x12340.  If the page size is 64K, the=
 PFN
is 0x1234.  Hyper-V is always expecting PFNs in the context of a page size
of 4096.  But Linux guests running on Hyper-V on ARM64 could have a
guest page size of 64K, even though Hyper-V itself is using a page size
of 4096.  For my example, in an ARM64 VM with 64K page size,
__phys_to_pfn(0x12340000) would return 0x1234.  If that value is
stored in the PFN field of the MSR, Hyper-V will think the GPA is
0x1234000 when it should be 0x12340000.

Michael
=9A
