Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054A616EC5
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiKBUah (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiKBUae (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 16:30:34 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021024.outbound.protection.outlook.com [52.101.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9A6352;
        Wed,  2 Nov 2022 13:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYxSfXf506ibw89XotgnCgexicUkPbsVSfdCS0P99Y8pH1p2N8u2nh4qh82P4vrYNP/eIu2LxG6wi+Vba0x7cGGEZ9Pd5Mu9fORyRqj9knpcmIMsbHyie870mQR2Symn6IRnvagVx1tQMYD7VqE/U/zkxjIt1EyV1cDBI3Y1WPfuKKroONg1+5RMZ3dsYp5KHy00L7/1U727hqI4+vX90XIuSWPf2wMvAqd568jkKCqT7z8CVzUv5z/seQBBsSWiZI4rjszUzk+y5FSd58Q4uekKjvwekE8bIrTo637kbNcJe1+QaomnlNxemrC21LNb4iPz8s2qtbDeBt580F2kcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HadpKihS6HN1hgXwk9/RyX14irQx1UKlWy4uaiTDtE=;
 b=Y8dg9XmoArWjau8ue/jOHTZ9NWi/ITdwgEmm9TetOcaoxm7v+2Bi2UzaTXmXcWSBrmsQ3wPX+wnupZ1RFQuMX2CEcanMubERTaHfAHYh3hr3vHiFQvzBAmg6jOprr2ke232JhT0TAS2y3em67978lkMCcvOMexTO7DkVU/ho16/N6kefle/6BPkeK4mk3zxdk9VBe98s8aSzii/3mLae9huhWf4b9/yW8boMToLMlmISjynuIDQFC1WStX68gbyOecfmoDWMrVokab5a/qB+WPutnFfY+n/50jIybTHJ8hNi6TeENEQ4BrSs5EGV7Ncw0qLI+YJsMrtunpq1J34+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HadpKihS6HN1hgXwk9/RyX14irQx1UKlWy4uaiTDtE=;
 b=fMSzsoyEkC3lDAPcE49IJjvYrsS53xxYuw514Rh+IQZWX1OQ+1MjGNsMu07CmUKKCsVlxGZ+h3DIwx55j7oBS0gVdkPaH862Klus/OtrTHvZhc/pReSrcZmc/UxzY1EnDGuIvljo3xxc533eH2l1rPe1S6Z7MKfAEA6Z/V2vbz8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1919.namprd21.prod.outlook.com (2603:10b6:a03:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5; Wed, 2 Nov
 2022 20:30:27 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 20:30:27 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>
CC:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
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
Thread-Index: AQHY7hfGdFg8W+TW4UePjgHc2LBts64r/kcQgAAHSwCAAA0egA==
Date:   Wed, 2 Nov 2022 20:30:27 +0000
Message-ID: <BYAPR21MB1688D5D33AC0D7D88AF6FD7BD7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB1688C426F44E40E1415DCD21D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CA+DrgLzYpFHUzYmvP_qhTMkaYhjRsgW3eaQfMYYpGiE2AHzjLw@mail.gmail.com>
In-Reply-To: <CA+DrgLzYpFHUzYmvP_qhTMkaYhjRsgW3eaQfMYYpGiE2AHzjLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=95265299-ccff-42b0-8e05-631f31879814;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T20:12:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1919:EE_
x-ms-office365-filtering-correlation-id: fc315271-3b76-4e53-1819-08dabd111423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBbiqZ4LPXJLmpZDI3ibl49J0bOxYyDaUp8pBmdpvuyh3ClBJ5EK+M3K0yin8gtwqK4CtVTqN7nItaUCMByLb9sVg8PkdoQupVDbry73h4mI4XbvHg6V0o+3CD83HbPuIDV4DNfQDVP/wWU4NyovySSX3PDO6a0t2G4Jnf2ZeuzuWHLJXmyzsAM36AIRdavuyC38XeldTw30exs41LdOsDRmkf1u+VKINxg1v3bvdvfO67AgwXLW6RL2fvwg44cHTg0CPE8wjaWDN8jRJ4z1PIqeyV5APofN6Nj8vjZIC6FlSzsQ/OmnHlXAlY1ekHWbxBxlgs5qErqaaGzVShd6Aycoh9kTTSbW8sVBqU2g/Q9PuQkcrqMmfUwOw1pVLXdmILCXV18FBaVUlvowbdjRk8nk0YUpdJ8YZ8XUGmoq7rsUC/tg9irpvX+lxNP1XRreK4O5z4fgOA/KTLz2lsE6Cvv23eKGxUAmLb3QuNWesnptDRhdVT+8zlYhABN7RTWxAeSexmYa00/1HoZVcP18KTVpAoX9qAOZq9uKLVnxky9VvFNDDsUHDyrZThcP5XqQbgYBrU/PceM+fixUrlQZu5K5KvjOHbdm30nZpSRcVvzgsD+GmK2VxWuxBIbjHLMAuKSlTwDBA0nbp+tGJfwzGwLdygxm2TjLHMSdtERGueKuFEZA28JPhS8QOjkwdsNSV7eDZt7H/nEB74EhU26I9qfC1TocGiYqo8teW/gM1OoYbynOwBA4P2qTw6a8zFC8/vsSTPVhMUgK+g/hrW4dJ6kTUNETGpZIDqMnHMzWGtIk/xma9+oUhdY9b/gclCrQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(8990500004)(64756008)(66556008)(54906003)(316002)(66476007)(8676002)(110136005)(38100700002)(38070700005)(122000001)(2906002)(66446008)(41300700001)(8936002)(5660300002)(55016003)(52536014)(66946007)(4326008)(76116006)(10290500003)(71200400001)(33656002)(186003)(83380400001)(6506007)(82950400001)(9686003)(82960400001)(7696005)(86362001)(478600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?vsk7vyWFkq4+aBpNiERCS6glLUoI2cjfBQvPsgQHNeG9Fu9Na7lDqHYmMSxS8J?=
 =?koi8-r?Q?JbkvJ4bkD4zsfo6dC+SEo2Yfu8FfLH5DL57Nx25RqXrvTAdYc6YRpksZafLP7E?=
 =?koi8-r?Q?ImHzX7xakN+zaSY0P3rQw9U+4doibN+jSPdkECQ+7pjE3pZw2r2gvkhuTkqFqO?=
 =?koi8-r?Q?NhHMn+5ywJT2lVXnLEh1pjCWYm6JSu4M5rwwTiCg/sHKeZpqoPXhs9JoyOX6gr?=
 =?koi8-r?Q?HRuh1H+HEe02VlEupkrY7ZxyMQ+3xUa0xYs+03aokUfKCL+/esv6AZmz7cltMz?=
 =?koi8-r?Q?LeQu8to5oD3bQoRFtoz/e3gwvcNfocs0WIFcgdnE+mwbkQzKJlDX1x4AF46KXG?=
 =?koi8-r?Q?hqzarGF80v9k0cctWF54l4yjfaJ72nlAHn7dJrkl3saixAse+XBht44qWdJ/Aa?=
 =?koi8-r?Q?29QMhXHnSmJKhxxtA89W0ycrnKhVQzKh5T91RCDYg3A8ousxR4AsnvmIlzzq/r?=
 =?koi8-r?Q?mc9WTZSw7L1QPSBj8OQpzP+e9/vx9fihxZv2hW3X52bjDBB4t5XAKAMuAf+Rv0?=
 =?koi8-r?Q?0ZDktEgKdvq2ixuHHn6l+WTHOIL0/wTX0jSTFsKBaKNuNTn5bWPxP8EzOaRcvd?=
 =?koi8-r?Q?RHggCJuKiUml/QoC+kVcSWrQ4rQIXE0dpV0eRRNVUx8zOtkUpXND07UQVfLna8?=
 =?koi8-r?Q?ZvgnF6Lq6SqXDiMcfs5sqmHkfzVu9QfeSCZkrft7Ale1N1PylctBWxh+kweXv1?=
 =?koi8-r?Q?9pCNT+mLqoKrnBqdCoEwGzU9zovbIbF9jsjyVrT1ochMc2mVnLh635I/lTMaqF?=
 =?koi8-r?Q?KoxPBX7d5k+DQMw5cHJgwCnf4xyRdF4/V4YuKRRy4EAjO3ST6a03zwd1Mq6s0A?=
 =?koi8-r?Q?KvSuyjiJ9lAY61DP6Zdl1fFokl5lZidd4rYBmqBUF30Ecdp58+dDKUax0VK/E5?=
 =?koi8-r?Q?RaYOsps/XgFlqp1tFPJvqv+DyfcMZ+o0VZ6Y30lcdwjIZ57IXB1jAnLJgHqxb9?=
 =?koi8-r?Q?53uyWOxCVKtrdYHklPAbWZ6A6MYx99U3sIx3b1Zywx84nf0Or3sjON+MnRuJ0m?=
 =?koi8-r?Q?K+7ycuOpNCRIRhj5TmgckfpJPsI1lnWj5jMbMmDb5CfowvoMD4StPFDODb356x?=
 =?koi8-r?Q?0wEX5rvNLrVMyBwdolWnk8wtereyA2zO7q7E/dfMkDJtq7yo8vv+h8QxjyOmce?=
 =?koi8-r?Q?njEYSXNmkgu0Uw3fN7PPWV0vRYymNV4PEwnQQPtw/RkfV9jjA4QW6ILXiTe8li?=
 =?koi8-r?Q?nPTLuMvpuBwJZbP7OW2780a073BAHDq0W6IEMFfltRiYse/YiYqtToRjJGhKre?=
 =?koi8-r?Q?bxHfTYrRi4eKYAD5vvGLVBDjWRNAycljStnOfT4d1Eu6EZihdPE1pztEUrvnJm?=
 =?koi8-r?Q?qwJn+4vXLwqKHTAjGbDpQtk9z45nmEoAM3yUNdYJ+cJS+dbfc4RGsYvQo7K52S?=
 =?koi8-r?Q?LbMM26yHEI+ekAwVYXURu7nVt0ZSlu4nkVcUajha/nT2DzoOGMSIlfmou5Xdw1?=
 =?koi8-r?Q?+yGdvOIaZ40R+CQRDj+wKeURf6wxxmnlqGqw26o/iuh+0RgcHEDwFAEQJVdveN?=
 =?koi8-r?Q?P8P3rM8uW+HI7N0ndFPazqi+TH04QPAhS5iPLo2L0GQFiCXE1a1jziq/f6KHAz?=
 =?koi8-r?Q?tQQ0OF9sFw=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc315271-3b76-4e53-1819-08dabd111423
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 20:30:27.5971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3HBMCn2Gh2Vt1LXMakHgl7cmJmuKWLSiD97S/Q0X+E0QUl6heVhXR9bBTQR/wZiGdaHLzQaiqUM2abyY8A8EDc1UJUcCePim6itFNn/L3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1919
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
day, November 2, 2022 12:26 PM

> =D3=D2, 2 =CE=CF=D1=C2. 2022 =C7. =D7 12:07, Michael Kelley (LINUX) <mail=
to:mikelley@microsoft.com>:
> From: Stanislav Kinsburskii <mailto:skinsburskii@linux.microsoft.com> Sen=
t: Tuesday, November 1, 2022 10:31 AM
> >=20
> > And rework the code to use it instead of the physical address.
> > This is a cleanup and precursor patch for upcoming support for TSC page
> > mapping into hyper-v root partition.
> >=20
> >=9A drivers/clocksource/hyperv_timer.c |=9A =9A14 +++++++++-----
> >=9A 1 file changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/h=
yperv_timer.c
> > index c4dbf40a3d3e..d447bc99a399 100644
> > --- a/drivers/clocksource/hyperv_timer.c
> > +++ b/drivers/clocksource/hyperv_timer.c
> > @@ -367,6 +367,12 @@ static union {
> >=9A } tsc_pg __aligned(PAGE_SIZE);
> >=20
> >=9A static struct ms_hyperv_tsc_page *tsc_page =3D &tsc_pg.page;
> > +static unsigned long tsc_pfn;
> > +
> > +static unsigned long hv_get_tsc_pfn(void)
> > +{
> > +=9A =9A =9Areturn tsc_pfn;
> > +}
>
> > It makes sense to have the tsc_page global variable so that we can
> > handle the root partition and guest partition cases with common code,
> > even though the TSC page memory originates differently in the two cases=
.
> >
> > But do we also need a tsc_pfn global variable and getter function?=9A W=
hen
> > the PFN is needed, conversion from the tsc_page virtual address to the =
PFN
> > isn't hard, and such a conversion is needed in only a couple of places.=
=9A To me,
> > it's simpler to keep a single global variable and getter function (i.e.=
,
> > hv_get_tsc_page), and do the conversions where needed.=9A =9AAdding tsc=
_pfn
> > and the getter function introduces a fair amount of code churn for not =
much
> > benefit.=9A It's a judgment call, but that's my $.02.
>
> As I replied to Anirudh , AFAIK virt_to_phys doesn't work for remapped pa=
ges.
> Another option would be to read the MSR each time PFN has to be returned =
to
> the vvar mapping function (i.e. on every fork), which introduces unnecess=
ary
> performance regression..
> Another modification would be to make pfn a static variable and initializ=
e it
> once in hv_get_tsc_pfn() on first access. But I like this implementation=
=9Aless.

Valid point about virt_to_phys().  But virt_to_hvpfn() does the right thing=
.  It
distinguishes between kernel addresses in the main linear mapping and
vmalloc() addresses, which is what you get from memremap().  But I haven't
looked through all the places virt_to_hvpfn() would be needed to make sure
it's safe to use.

However, thinking about virt_to_hvpfn(), there's a problem with Anirudh's
earlier patch set that started using __phys_to_pfn().  That won't work corr=
ectly
if the guest page size is not 4K because it will return a PFN based on the =
guest
page size, not based on Hyper-V's expectation that the PFN is based on a
4K page size.  So that needs to be fixed either way.

Michael

=9A
