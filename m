Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642D754B739
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jun 2022 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbiFNRCV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Jun 2022 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356985AbiFNRCE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Jun 2022 13:02:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61414D31
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Jun 2022 10:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVuanzMEpSdq0BJ8snC331Xl+RZpRKTX43Ahez8AxcDlyu7/Vw94xrim0djwZOqNpFA+0Vg2IG73Wh+KPnKuPsS7qNDNc8ZFptBcsflg0fD1HmiGUHOsExPHEKMPf+1HB4dHP3lGz7ZPfueFtIG56y5yyGGzgNWtGmfUz/5jaeXpBzKOvkqQgsZkiiUWh0g7yFO9MQommJi1JV1n8Kfr/BgD7h5eXuhnLudIp3I4GpkxnFhE2ej0sqGdthDJXUZ9XJyvdUPDtEnE0Yk7O9EhRf4MqnNE7nvhRSQoX3q80Yk25tPdQYBlAxRCOnRjoA1G5UyFdVWNXBJo5Xy7m7lkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7TmyY8Rqw12Tjil55fktUtZf4OmeTil+vI6YLDXXkc=;
 b=HCJzeEy8fkJm4dhb8Wv4+c3e68hN5okC964xkwjTbv3XoQ82EZxRWc22a4XDrmry9cSdZ6d15uPxmGdd+l7mA8cM6CFd2EzcSQ1Z0Hu3vz2Veky9dtiXaoZ9vb2rcHCsbK+2T6HpalJAzYMpKh8bI2wnUjm8Cvno2MJMPfvC6JjSP6goPcUB85Uv1Uxhxia1vEnpTuSv5q9rEnRK2U1usbLD4WSdInFmRwwUxKKQLGS6YMh2dbKG8VFkZMYWx38V3KosMaKoAryCIQ1dkThYeV02NGRSXoahcwyyfw7jv5bMfxlQ/BQbgaMTHH1vtOAOXUnT9II5IZkItKDhSVTtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7TmyY8Rqw12Tjil55fktUtZf4OmeTil+vI6YLDXXkc=;
 b=eVbxWMLsz0DvC/f3MxDmS4Crmy8x5FgyJZYCRyFffF55eYpS63dJor6sX248bAVDz6tpwKupUy9B8TTCJ6vm6/vN+YmUOB4AVbPCTekPvwhPRtWsedAb1tktXAyQbNdI3yDZj/PE998FEYxDD2gh/We3zHvsSs0Kl2fICCd9mqo=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by CH2PR21MB1493.namprd21.prod.outlook.com (2603:10b6:610:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.8; Tue, 14 Jun
 2022 17:01:46 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::68ad:e4ac:8035:900e%4]) with mapi id 15.20.5373.006; Tue, 14 Jun 2022
 17:01:45 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Florian M?ller <max06.net@outlook.com>,
        vkuznets <vkuznets@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>
Subject: RE: hv_balloon: Only works in ubuntu
Thread-Topic: hv_balloon: Only works in ubuntu
Thread-Index: AQHYfamAAWvh3ZSqEEGxb5JpUeTQGq1Kc/WAgAAHN5CAABp5wIAAAvTQgAHnZtCAAHuLgIAAC5sQgABYZfCAAAKrwIABwYCA
Date:   Tue, 14 Jun 2022 17:01:45 +0000
Message-ID: <PH0PR21MB3025CD5206C3F35C2E709F25D7AA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <DB3PR0602MB3674BB09316BB82B4116F27DFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302513B8500C25CEADA56718D7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB3674E1BD958D00FC4B9124ADFFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB30252F8660A16DE36206B0EBD7A99@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36740EE00B8BA3B897BCB7C0FFA99@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <BY3PR21MB3033FBB3CF2011B1D0DA2978D7AB9@BY3PR21MB3033.namprd21.prod.outlook.com>
 <87r13tj8ou.fsf@redhat.com>
 <DB3PR0602MB3674C185377647FDBBEEDDDCFFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
 <PH0PR21MB302540EAB2DF0A368AF4BC57D7AB9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <DB3PR0602MB36748AD171E0F1501C7D1898FFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
In-Reply-To: <DB3PR0602MB36748AD171E0F1501C7D1898FFAB9@DB3PR0602MB3674.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d8924997-2e35-416d-8590-e2f0c0c9a36d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-13T13:56:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a075cee3-f8da-48e1-9955-08da4e278fdc
x-ms-traffictypediagnostic: CH2PR21MB1493:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CH2PR21MB1493DFBBA4922E23CC1BC71DD7AA9@CH2PR21MB1493.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWQOgNE+UNFEBZCIHCfFQdtujp5/OU26A8c01rDK6VPPMbklMNcVnfUcpIqICYPuLTmtItZiigl6JSPg9o9TRCfRqmhJuC2wJePqlIdWgK/fytGsrtlzgdaRJ9Gpfeo5+4xX/HQupvcKqdIussJivILwFJOngZppzubyZjU0VXi0gJaEXxoMXhxbyCuUsuLG0hzrh4MTOU/MicStHIxnGHQNLwZ0HfNMCpPnakqYkbpGnLC2Mgdi2ZMwHbBfXn6AiOOCJZOoJ5NPC1QBPeSirBVGCopvNt5C/xw3RYFBi77WszToM/d7MopVnYfLQMTDriUBRfjuV00LX5QZi0kuUNlRy2Bxt8Y/DZ23n5Bq4UpNgi1cvVyv8PvuP4mszy9tq12k/bugQr7DWfDOiWEWddQjfbMyOaAhLqWSI48IKkiRHCisMHk4btty5eokP29cpqCYc7wdDuPyhMAz2H7j8ZOyn/LO1GElE1nCW9mdSjSHs3daLhI+kG2Afu7Qj2pOlyc5exrfpgD1hxEdDdTAuGzYNBiU+/NlbR4WMGMHZ6Ut1DeOsC3UPI9SYl+Yb3hnyd+GEZICyvJfwUxDA09gWP8L64lcqtqq+pwthZQweYbOpRWaW7zZIN8uueu2fdP0nUBbWPY1vjNG1/IWE3SzRHZvK3pqL5VezIw0r3po7115qM9pbBeunKnRW4hIjnrzNWl32dQhH82UCPCR8BvsPx69DSZUo6pH8OcWb8akHRqajDLpPfnak5pfiGKdnBsw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(451199009)(8936002)(38100700002)(9686003)(26005)(52536014)(8990500004)(186003)(83380400001)(33656002)(55016003)(82960400001)(82950400001)(71200400001)(86362001)(122000001)(10290500003)(66556008)(110136005)(66476007)(316002)(2906002)(66446008)(8676002)(6506007)(64756008)(54906003)(4326008)(5660300002)(7696005)(508600001)(76116006)(66946007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d4/uREO62G/nwvIJP22YtyQea47RKKf9QkD7qJ7gZx8a6eNti+YCqaycAJIc?=
 =?us-ascii?Q?HPOqC59azvx+Rr5k0lc7icsaXKwb/oQU4FJDjDJCYKSxqDrZF3oqIRi13PSi?=
 =?us-ascii?Q?kf5oWhpX9zNW0aFWbdb95Db1qHauZwWRr42kNg9gPKc2UoaESbfQPZvTMOoL?=
 =?us-ascii?Q?xN1yLSDzeM9QlPPr/9wG5iWgiEji/RZ2QBj4B2wxqs86nPPIPXxDsB6El7m3?=
 =?us-ascii?Q?5T6cpNoDKWkuHFmjRaqddbh123Dxtskfg0IZZ6eaq6yR3z83tOu1Mt6skgLQ?=
 =?us-ascii?Q?ajEoyUF8k1v3j5pjxwBzByiwqJ8z3vG3IqD780xG46n36r5BPWV88v12L1Zh?=
 =?us-ascii?Q?8DrzwIE7w2/0I4BD4yB2exYWjaa+Q9f9b90qxGlLFNvve71HaNQNJjdBkF4/?=
 =?us-ascii?Q?YprwnMJ+J65rh1hxd4OpvTV82OT9S4NAmnfVkzBAtZkec7EZeQ4Fr06/xU99?=
 =?us-ascii?Q?o0OoUjA6Bi9uKMCLBm3TEjjKYDVgk6ZON7gzJuWyrI2QNPtgPPqJ4dybxfV8?=
 =?us-ascii?Q?EFsrq+EVYNEKmd02ef+RviL/6NI4r0jIcNAzjl/GcYr6xtir36pkohFkZ/Z+?=
 =?us-ascii?Q?DO7EnmXN8L3kE7WvTsjD57wEQvEcGIct7gLl7Tp0jyjJW0quipk03dSpITu6?=
 =?us-ascii?Q?hmmP0WldCi7sZFiWLB1SB5NEP9sggPK2p4g2WkddHzrXBJlfmJnOxPaJl8jc?=
 =?us-ascii?Q?xzURIBVoGjh2ptoN21eS/0m0WUm8EjGlcz87MpMnjbSeHlOEs0GiI85G0uvW?=
 =?us-ascii?Q?3QtASf9e59oCeWz4q3rkpbqp7WQB6KTNLDJoDdAweI/oOQFZrs05acjwFWDb?=
 =?us-ascii?Q?b6ceMQR85MMxkkNc4jzI2OdzloBV70ffeGjqtMpWYR0bOhqYUnSE6NB7ibgU?=
 =?us-ascii?Q?PmkU/tOtKEpFXsSZb1JBcFxZfGMwD8dTBjyn/uC6XBFzo5WXiHwbJLKFOrrW?=
 =?us-ascii?Q?deAcum8XFI1IxeVVCVCMGEqXAQ/Zf+s81Sa3+Bj0yvxg9zpBHBfngi9lYRms?=
 =?us-ascii?Q?xZtfGy5bzbqzjR43BWTOwPmZ5UamPL1Mf0xO8oUdk0crjih3UH+qgh5Uh7jz?=
 =?us-ascii?Q?ZLrU8XHQP1Z/h2Kl82BZ0LivPyxgcRh54ox+sQN+vyCd+gXB+2wjxWD2jJDt?=
 =?us-ascii?Q?7+lVsR2yGKUEOMm86WsP4CMwwis1BgfHIzqgbIO1igEnMJ2E0oP8AUc/N/5l?=
 =?us-ascii?Q?ydGLitsIMUmDOXucN2AMko/XiEeBKgKxlCTmKf07U7jClJcip2vAeGMd1OoF?=
 =?us-ascii?Q?rVk/fyecoLJQEZBz2vC/nct5GuhSLc4c/jPc+Mle7OiXaMF6Atbx1qD1D7tT?=
 =?us-ascii?Q?yfjdTR35/qtPdLFqz1pL/tv7LsIixAU143y54tryl8+n0h4xjASAPXrMut1g?=
 =?us-ascii?Q?1y9HTHqv8FUnSEVMD389wdw2LDdicsxZ3wNU8p40ETIlFo39f5zkYOek3BKa?=
 =?us-ascii?Q?0ddf2psROo3uLkQg3kZG1P1kowT63ZUcR57i01biNcoiU0mdiiq2fQWj7gXU?=
 =?us-ascii?Q?kulYMhUev71kVkOKP5GF70Db15fWFVemYb3E/3v0zo41sA2ORN63LNnBda7t?=
 =?us-ascii?Q?HMcBVodUE0nUQa+49xfGrlgnT62gibhvqvJtEzYSg7eSwratcJ+S3mrv9JwT?=
 =?us-ascii?Q?e7DN6+4YTBD3vgbEP87+sbPF6+qw54Lg20kaSDlCEKfJ/E5tMxBeKdppLtYe?=
 =?us-ascii?Q?/EQupQsVkCjfp2tZHEG7sZghXCXwO1eNNeZuehQktol3E26g2WcmIJBBsvEr?=
 =?us-ascii?Q?KO1qo0toH/a/u0rG4w7wsK6Rbn1wmG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a075cee3-f8da-48e1-9955-08da4e278fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 17:01:45.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mxiyLIbjI28j9Sw8GEMBxVomWPzlxULZonOUVT9Kvy5m3Xjpe5H+EmON5b1tao859hKxpWXC14dy3u/zxR9cdVns+WuzVkcDZG2ZSnpF8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1493
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Florian M?ller <max06.net@outlook.com>
>=20
> > Von: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > > > >> > > > >
> > > > >> > > > > Issues showed up when I set up a Kali Linux Guest. I
> > > > >> > > > > missed the memory configuration before booting up the
> > > > >> > > > > instance, so it started with 1GB of memory, and
> > > > >> > > > > ballooning active between 512MB and several TB of memory=
.
> > > > >> > > > > Hyper-V started to allocate more and more memory to this
> > > > >> > > > > guest since the reported memory requirements also
> > > > >> > > > > increased. The guest kernel didn't see any of that alloc=
ated
> > memory, as far as I can tell.
> > >
> > > Please do not forget about this: (emoji-pointing-up)
> > >
> >
> > Hmmm.  Right off the bat, I don't know how to fix this.  Hyper-V tells =
the
> > guest "Here is more memory".  The hv_balloon driver adds the memory (bu=
t
> > doesn't mark it "online"), and sends a positive ACK to Hyper-V.
> > From Hyper-V's standpoint, it has successfully given the memory to the
> > guest. But if the guest hasn't onlined the memory and isn't using it, t=
he guest
> > continues to report high memory pressure.  Hyper-V assigns yet more
> > memory to the guest, still to no effect.  Having the hv_balloon driver =
delay
> > the ACK until the memory comes online is fraught with problems, and of
> > course Hyper-V has no visibility into whether the guest has onlined the
> > memory.
> >
> > This may be one where the guest configuration really must be
> > correct.   But I'm open to other suggestions for a possible solution.
> >
> > Michael
>=20
> From checking the drivers code, it looks like the guest tells only the fr=
ee and committed
> memory, not the total. I can also see considerations about num_pages_onli=
ned in the
> committed-calculation.
>=20
> I see 2 possible options at the moment: Adding num_total to the message (=
changing the
> protocol), or stop reporting if the guest fails to online memory after th=
e first increase. A
> third, more complicated option would be checking for not onlined pages (I=
've seen
> functions for that in the code) and adding them to the free value in the =
report.
>=20

Changing the protocol with the Hyper-V host probably isn't practical.  This
wouldn't be a high enough priority issue for the Hyper-V team to make the
needed changes on their side.  The second option also has problems.  We rea=
lly
don't want to just stop reporting (and I'm not sure what Hyper-V does if th=
e
guest stops reporting), and it's always hard to know how long to wait for u=
ser
space to do something.  The third option sounds feasible, though I haven't
looked at the details.

> I'd love to write a patch for this if I had a clue how to test and debug =
it without
> rebuilding my kernel all the time.
>=20

Feel free to have at it. :-)   I can also put the third option on our list =
of things to
look at, but it will be in the "when we can get to it" category.

Michael



