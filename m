Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA81549791
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jun 2022 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346740AbiFMQN7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jun 2022 12:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiFMQM5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jun 2022 12:12:57 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB323BC2
        for <linux-hyperv@vger.kernel.org>; Mon, 13 Jun 2022 07:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf/RFVHQypgEAAuJMh/g5OjzNzVYr+gVOTrZ2kz6UjXBG77dX5EaA2QPfwpeQ5y+KO+IFMahd5Jum6ComP3yvbNxTXJVeo9d2WTEPwLcTqBuv0M3ai2Kkvd9BQtkqn1fouNfI8cKqDwjl6z8iLvsFCiC1SdWMhEJScKC5ecPEWF+JWBB1f0JstdR0zDwmq3fTR/7Do3vpBxv/KK/eD4Znla6+jOpmT2woqErHpH6lEmnS+9f8Pazq1lQBum+DJwd9KbisPeQFRZOB6UGcNDKLtgq6TqSYqspDsepami2YMTiCUlFp3EDBvXw0CrK9Jg6w1f4lVqYVqZGErVQKM561A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl1JnYN5jxxN40mCAaTlNOy6A6luwzX1F541Ei9WF2c=;
 b=hQz+8zWc4UNLMeGtxReRuJLnM8tM0/zqfwhCaEdPixkZFwzVGi6rTMnoelnV54bUpFFLzfPD1SIOh9+WJBA9nfb7NJcheOuuQS7mnidTvIDOWtoPNN/ouNFmxshmbtOlMg9TL6kUXW4Z9T9DLH6dBehY3EwFItCTzzwm39XffjvSP0KSHPjMDPE1hLvPehWMWSPNr/xeTEHHZUGFqRjL0vu33JlkBrLgmACNAm9OqHJeM4LEaX/fLUr0YEJCV7fNuwmLtRKJVT8OTzsT39gz2cHj9sP2s57+Cxb9nxl4CQKIkVjWpXCPBOdO3OxiIkM1wLNUGGa/yOv2DLJajeDzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl1JnYN5jxxN40mCAaTlNOy6A6luwzX1F541Ei9WF2c=;
 b=QRwoQRHM2kkbWmotkToaOJyrZTh8L/vBEML4s4O/+cR1H00jF/fcv+4uU4hzlUxYcd/X0Iy3i7fkNDJv5/Cu1jC43lANg+U8ALjCeZReXRnO66LseBxnScc04kZI7jAE2oXG2PiA4f6FNO2RAC/Gf/A9GmaNhyF6Wa3M0JND9GM=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MN2PR21MB1424.namprd21.prod.outlook.com (2603:10b6:208:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.7; Mon, 13 Jun
 2022 14:04:31 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e%4]) with mapi id 15.20.5373.006; Mon, 13 Jun 2022
 14:04:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Florian M?ller <max06.net@outlook.com>,
        vkuznets <vkuznets@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>
Subject: RE: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5CAABp5wIAAAvTQgAHnZtCAAHuLgIAAC5sQgABYZfA=
Date:   Mon, 13 Jun 2022 14:04:31 +0000
Message-ID: <PH0PR21MB302540EAB2DF0A368AF4BC57D7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
 <87r13tj8ou.fsf@redhat.com>
 <DB3PR0602MB3674C185377647FDBBEEDDDCFFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
In-Reply-To: <DB3PR0602MB3674C185377647FDBBEEDDDCFFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d8924997-2e35-416d-8590-e2f0c0c9a36d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-13T13:56:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57fbeb63-00e9-4a06-3f17-08da4d45a37e
x-ms-traffictypediagnostic: MN2PR21MB1424:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MN2PR21MB1424E86B75A46B3C8CAECE84D7AB9@MN2PR21MB1424.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q5Viw+fiHcmKUjEpJcjTAAft6JXPCRHaYpa/01otdmS1z34T2sW6EA44f6fLDm0e3zUpko+YPzjqbZkiJLgEF3DPGMlyIBZLe77bHlSQlOzw4sIqOliGlf2ipEXT6gDJ5zzzpEhn7tJP7Oek0uGBOu2XkSIjWM+K7+/Y65dKO1Y+jhACRq8/Pzesg6TwQGv3Y8LomuALXWyxHjYnxdr7SqzBLpWUlYpk9yt0k7H3Hwt/+XZM5xbQh/K7JKhu53SmNX2uv97Eq4u0VLOBO11fmtysAdv5AWxxBGCkJ3XcGjm+4LP4uC3dU+/UKgobgdDqv47B7gb2eMxLo45471sj4OJ9G0svJq3roxB2bWQxCi/SxgAzMuf7p5EUHvKcWtS5YIvvrqCobN7XZrEAEVFxPvYgg3UpBgy5mKxQRa+HJk6N9ElEt1J6rpEF0p6jb33ePsFFjb0dNrLe/Ox9m464Amhlp0ttBK9I7RSBNbDGIIAI8CEVi5HWPMTmEcImelpH+UnW/oDxyR5vBH1tqS/C2f6QSuklVNhCY4o83MTUqyLMY2DdfeV2Gojz53j1HpOwxbjvM/hbWKHq3/5P4UtSVaCvXAlh3kglShyZyBkkNo62K/ptr9Vp5OWWvK07/EM15HieiadLbCLmPcKSdXnwwy4q8D6Hn2IqMpOsdNb30anJ3GdwNSYh8jSSTPxRekQL6CehTxTdCX76Q7b27jJjFAZ8Hv4lIRDtLWq5BZBGX+HHuacLXSYAbV6zCVaTAKV0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(38070700005)(82960400001)(54906003)(110136005)(122000001)(316002)(26005)(7696005)(8990500004)(82950400001)(10290500003)(76116006)(52536014)(71200400001)(33656002)(8936002)(66476007)(4326008)(8676002)(64756008)(66446008)(83380400001)(66946007)(66556008)(186003)(9686003)(508600001)(5660300002)(55016003)(38100700002)(2906002)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?93IxS1vUGifKE+iIkz5ot3siSC8MOdc/cyaTe9nPRrQoophwh3PJWSH/on6j?=
 =?us-ascii?Q?QF1Afr8lgE8cI+djNT0NpKCL9yUczPXVjPox+XWjdFIp1t1Dqw3gNIzNbRkz?=
 =?us-ascii?Q?ImSehelZ3vOcylj+DPuMLExlKlez80ljojdmxzVGcggq0DH/Yt04seySN+Ew?=
 =?us-ascii?Q?QAVvSH9p2ZNyv5CKBfGC8leWQUQq0gO9dZN/DhMRbzs8WflG4oN5Kh55XVD+?=
 =?us-ascii?Q?WwqbAISHdjpoAv1qkiFrWKVrdwIPmvi+N4A0Ub3HznDg3A9CWhIww5BGkK5P?=
 =?us-ascii?Q?wYYcjxgpLMY2Sj3mBZiE12V6VteOvYBW9F7RU6XODc+3T4rG/4aZ1gaIrInh?=
 =?us-ascii?Q?uHnwInz5QfMf1xZthssOK1C2hWbYoxIQi1ceIt2pV25jOReIW81qi7yz9WZK?=
 =?us-ascii?Q?sVM6OmdU3i8ToZm+iTSBwz4udcpvxCQ7wEqUkccWojl//FfhmX7rKcCv+cM4?=
 =?us-ascii?Q?PMtblcNjO2nxQoKZDPRgYMmLIbYr02kEYiqUTZBUgXmpz4UQKuqoj/gUPeue?=
 =?us-ascii?Q?IEMYdP7jJ09p5JRf09Gp0Dy1PWpKjPqkgB1GnWMtNEy4FMIdozS3b4PhSBjb?=
 =?us-ascii?Q?8R6Bj0boWd0gu6Q5Y2XcGBwwJzGOCBpdY7YX6rKLlb5ydaGApkohHh1PYXyI?=
 =?us-ascii?Q?0ngwIWp4lShdv/Pd9qQw8tKPNWedfWCyWt+AGfKMrdZmmqw406CGaEN5f1FG?=
 =?us-ascii?Q?Xe9A861jdRg53FcL6vXpe4B6DDo4G9mtYU63Utmk/EyoB+0o/ZC6xp8ZaMt1?=
 =?us-ascii?Q?zo54S8T8rVnDA02yp7ygRZfbcfsCwUpQv7EGc1k14Tfi4vfOBr7pp2ZfQNo2?=
 =?us-ascii?Q?4IacgZddLNh6EUfEtomM81hwsZj6riwXtDRVJ+1G6MYBwUnmv/3xJjN1BTod?=
 =?us-ascii?Q?1u8J0jyDxpBIr1EDzgxhFNV9zwI5OR8o81p8tMi8klVOMoSa3NALtrwYBgvW?=
 =?us-ascii?Q?BPO02BZESpnZ6oOvQQ6s2CjaRb6X3l88PL1rKjYI+DaVTvUEOT9YjVBxhQVT?=
 =?us-ascii?Q?TZPOe98wsbaKYgj0TB2/bwvvcyvA2OeIbAjrFrwS4p9lbyox+mJ7IMvsRVu3?=
 =?us-ascii?Q?a+mL1/MJv69K/NUQwXaE0L/zTTSec36NXpGPUk5a9jboC3E5tCJCsbJZJvXN?=
 =?us-ascii?Q?0I7cxYMOIcmbkda5i4Fv6+kAMi/s/ftJxVuWHcDCUf+qTIbALlweBMSgPB1v?=
 =?us-ascii?Q?wJ5VXyCSfXI6CkGd1hZBC71cxBHP31vpKaCGUgiN7aWM6ohH/OcZqdUiktqB?=
 =?us-ascii?Q?+SmTums1NGSiuXnxZnpHuiUaU4MrghNuTNH9qHyAlKyJJFbSRZeiBBnnBh30?=
 =?us-ascii?Q?FANRsyGxSnxLiXh5UrxIZhTdF0+yz3c/4C/9jkW+FFmsL5174U76kJAaU5KA?=
 =?us-ascii?Q?u/j8K982djIY+riDi7SMKbyT1PHwszv9KC+P8jjTThVDVZMqqx6NP+ezX4df?=
 =?us-ascii?Q?VihSjnWMtg+h4xL9Ftv849ZSCjVRVVNY59FUmP69ENLJ8qf+FmG0ZLsbAMkW?=
 =?us-ascii?Q?Yqm9i1hOOl3KqBVnwb7Mj5O1oKpXKiB3oSDlchJyQnwMbagDkZhpsaMOVNy0?=
 =?us-ascii?Q?/Fx47QO2i6ssPjYsK+c0uAeTYp0mVN+Zs/MagGMuamo9NEX0InqzBxnCr3+3?=
 =?us-ascii?Q?vmirOdmH4/3o3e3qa0WUcTF8fFwUHLH3Ue46OZ+B6wI5/TD41t8nIRKug3hZ?=
 =?us-ascii?Q?M6AFK80f75Hy+ebNNh1YmM1Mgj6DU9zpWBuef56gFwMhwiipyLze24/zKcCh?=
 =?us-ascii?Q?dgMGmiMeqXG6fK/FQvNhvNHo8uuvZbM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fbeb63-00e9-4a06-3f17-08da4d45a37e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 14:04:31.6919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDWUAwXYxFQH35Cl9MyidAmmXrSgEoejBzTmd0pHOOYI32Jkr4u9HbDpXsk0yUCL5g18J7ow7CC61CJ5SZbS3pLMT+rkcsW7yl2bV63FtIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1424
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Florian M?ller <max06.net@outlook.com> Sent: Monday, June 13, 2022 1:=
53 AM
>=20
> > >> > > > >
> > >> > > > > Issues showed up when I set up a Kali Linux Guest. I missed
> > >> > > > > the memory configuration before booting up the instance, so
> > >> > > > > it started with 1GB of memory, and ballooning active between
> > >> > > > > 512MB and several TB of memory. Hyper-V started to allocate
> > >> > > > > more and more memory to this guest since the reported memory
> > >> > > > > requirements also increased. The guest kernel didn't see any
> > >> > > > > of that allocated memory, as far as I can tell.
>=20
> Please do not forget about this: (emoji-pointing-up)
>=20

Hmmm.  Right off the bat, I don't know how to fix this.  Hyper-V tells the
guest "Here is more memory".  The hv_balloon driver adds the memory
(but doesn't mark it "online"), and sends a positive ACK to Hyper-V.=20
From Hyper-V's standpoint, it has successfully given the memory to the
guest. But if the guest hasn't onlined the memory and isn't using it, the
guest continues to report high memory pressure.  Hyper-V assigns yet
more memory to the guest, still to no effect.  Having the hv_balloon
driver delay the ACK until the memory comes online is fraught with
problems, and of course Hyper-V has no visibility into whether the guest
has onlined the memory.

This may be one where the guest configuration really must be
correct.   But I'm open to other suggestions for a possible solution.

Michael
