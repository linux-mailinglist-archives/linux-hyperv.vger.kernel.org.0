Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB77745234
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Jul 2023 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGBUSb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 2 Jul 2023 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGBUSa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 2 Jul 2023 16:18:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2126.outbound.protection.outlook.com [40.107.93.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B563CE6;
        Sun,  2 Jul 2023 13:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIvRlYsPoe/Ffc3ko/yLs/P8saJ+tI+bLKVMGNqG7jF9Z3BWwkwcKERDdvTZXNwMJ5iW1rnSCHGqpSKLKbJpms5IqvEBEIWBhbys6QofIgO4p5B6Q550/VLpufRQiuGqZmDMt51DA3WoSl/E505R/bdmasuWVEH4UM01GPzu2UOix0dazhQMefm7Y4ELHdPv8gtObTw12jjtOt/PEE1GFtZppso199ULJMg2Ee22oAl75YsvRYGS5YYWzs/+hocsNVBDzXOrMDrAuoN7ji4VUg/sROWBoJ+crvvc50Dl+VuOAA3Wkul/Adquilb0/jW8SCOF2CRtvc80DvghBFbbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae9pCR41KGi96RyWJZAutlWmd4OfiGq0zvdeO02ncuE=;
 b=Xlbi9FhngeyIn6xgUkw3PXf+8SEXz8ZX+bx9xSqOkjpVLr67DJAp4ucGUGMd4uLxSDhZkEIa1+7D717Go8monXuqwPDtSWBC+xFrB7MYBfpnvNC0Sp0jOSwhkSq+T5q/4qDmSXKbi9GqDv6IWOGZD09TH5jlDUBszJaBcsbmM+5nrhFZceaxPvkMZvrwWRcKfhG/hJz8zlWkpLeXwl5kzW//ZMTsPJiJxjkGlp4R6opFnEBSZPO74zi0iDTgCXejttn1p4p5SXtN6sp15dA9X/ZPjdLnb/LCE8yY9UT34PBHJ/jarwqfIyhFzL9o2Npd93uKsvHK2xb44h0NuLh9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae9pCR41KGi96RyWJZAutlWmd4OfiGq0zvdeO02ncuE=;
 b=LltgDm3+Y2QdQ4s1hFxLfFyw/+l/XLrespkvtOWjczlbW6/MOr02mcBWat5wT0eIeVUscUOxp1/sr/Oc9qLGj/X3uyGOIAFT/5t4TBg86us7VJCr6FYcpRMoh0h5YvAn+o4mkmGGYwwLRXOQV0Hwm8K8VZ4lSQwQKl5Ckm2zNPE=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MN0PR21MB3777.namprd21.prod.outlook.com (2603:10b6:208:3d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Sun, 2 Jul
 2023 20:18:26 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374%5]) with mapi id 15.20.6544.002; Sun, 2 Jul 2023
 20:18:25 +0000
From:   Long Li <longli@microsoft.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZqInuIa+OQxGM80ioo4gKQGwCLa+hejgAgACaBvCAARhFAIAAZi9AgAAzZwCAAA42kIAAMnKAgALheSA=
Date:   Sun, 2 Jul 2023 20:18:25 +0000
Message-ID: <PH7PR21MB3263ED62B45BF78370350AD7CE28A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
        <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
        <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
        <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
        <PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
        <2023063001-agenda-spent-83c6@gregkh>
        <PH7PR21MB3263330E6A32D81D52B955FBCE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
 <20230630163805.79c0bdf5@kernel.org>
In-Reply-To: <20230630163805.79c0bdf5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1bc70928-8933-4b96-8045-3ce8f4624187;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-02T19:37:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MN0PR21MB3777:EE_
x-ms-office365-filtering-correlation-id: 08c4c288-1f33-4cc7-15ea-08db7b397d84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcQXn2TEL6vp733wqjyuYwp6/rdM/OExjVx1+4XnGmY5JrJOXEa6E93yHuAUZLfXNz5yX7V73254ocbNoUH0l49uTqaREQ1LMrbP12wOTaALWN36zoFJKEpo9mJItzoh0uOJhK7btXhuZWqQXSLsdy/dX7ZgoMrEIohj2GNCS3DVlyqCwNQinLYVUzqsIuj9EYmS59EOH9xb2Dv+tzjTCTQGLOLOURm/7Hc7v4JzO6XrSl6JPGKBEXNBseNn6ZrvR8DjhrUl5jcTYaUDtvL8x5oQuYKm6UgkeTQah3E4s62QN6lPGyZYwGm5r8142F4fqTbbO4jVpkDtWKQu9jYE7xA1Vxggtf5vtiu1kH8CDtPM0U7UeM90C4R16QIoZ4GUdT8aAFo/dYiAoZL7Jlm2jJjjArd+mNYEQiNoTyVgHAbRL38G6pC1+IR0pKhKPa1EUH8xiw/4FElIRRpVHuCCa5iKcKRl+Eo1edGxgw3/LNzOWOBlfh1q54WRnEi5vmWYjZmupWHfPL5Qq0+b2brRkGNDE0IOTcuVL1nsyxQspHJsXB98pHRDgU04F1MMzAZIwjjmRkE7587TD0mKf/QyOghyWDZKW9tRYaMk8hJouGNp5PQCQbG7sOXZLqKWXa8yRAcvRgoa4u54WrpnRJC77XbgJ4lxJBjA9LeIecx9SVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(4326008)(54906003)(71200400001)(8676002)(8936002)(5660300002)(478600001)(6916009)(66946007)(7696005)(10290500003)(64756008)(66476007)(76116006)(66556008)(66446008)(316002)(41300700001)(38100700002)(122000001)(82950400001)(82960400001)(55016003)(83380400001)(52536014)(186003)(7416002)(26005)(9686003)(6506007)(8990500004)(86362001)(38070700005)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WzItWFwIAZ0aON+aY3RTH4Lq9oGV3JLYf9yk+AymM6xd5pyJeIe833YleWu?=
 =?us-ascii?Q?DmgusEuFsi0KL2i9WKcPyGqe4Sz7X7pT2vWGkmivTnLWvWPt8HoVWBZTrira?=
 =?us-ascii?Q?U/TCfgN4k8YzhSYJLYNc0WnCkUQg34BmFXaY/2IjSj76AupH5hQwHnICEDAs?=
 =?us-ascii?Q?YIodrTvCX/QEqHDfXHtWt0j3oAaftOctrkQoXrSQK3Sz4usCXNJBl0eo1uIj?=
 =?us-ascii?Q?eb8+E1brCo8ZlF3yvgYHbMLz/D1nhV5CqbaP4HX20LKFkaBbTI+ftRrS4ZvK?=
 =?us-ascii?Q?dB7cynOIgSMFboDi6iPNWLO7xjQk8LKbgqg9VaezOSROMjVJLN44WBB6FZcg?=
 =?us-ascii?Q?nEtizovHTd7X2YL1OJLu/QkxD8HHvos3ZjUSPRRDe0m7xbRF7Q7muPx5QZYo?=
 =?us-ascii?Q?80fvt/xzbVHlz5aNB0v1Ghfm++bjUwUHiCICsYz8+vW0K9CX1LjFl+b8RqRx?=
 =?us-ascii?Q?friKzJVcObFb2YtxOBvwlnkie/Qtu1onwUWs81LV754MpioggAO76wei2D/2?=
 =?us-ascii?Q?gO34QSUlEu+m7UdHT5nRHonDZsJMS+41CFxrzawo60iNNMh17Dz8R/OVPGF1?=
 =?us-ascii?Q?o3gLn35E7nThvKwN6lIEnXBe6PUUGbR6PpAqiRcRCwwa2RvScRFmCDBkeY6r?=
 =?us-ascii?Q?uJXIp3H9r0c3lcNyMI6rAB8mM3LWsINf43poB5bosyCUfD4i99+sebbsvoli?=
 =?us-ascii?Q?5nbij8dAssmCuHpizfix6IrJXLzbWE3u0OSP1qlv9wSKNHvyEaivapccHbeH?=
 =?us-ascii?Q?tpRE2pHDj/uL0Eu4si6W3LGNxAGisEaRv5b8wbdQzQF9Gz57gz7YWY40xw05?=
 =?us-ascii?Q?8g63HYDK0+speFZyyF39YTwI4akGp/tIH/afQ8tQTQBPCl4PLKnBz29POmMZ?=
 =?us-ascii?Q?rdpCNgBtFZgqGpaDAUsoQulHpO8P6Eifx4w2o0WgvWea8MBWK3bi8i2UZqJ4?=
 =?us-ascii?Q?8fR31y73YPYjMO2lVbsBUP45dhoWm2r5shtizk1cjfLk59HfqRe5Gx7QFUAr?=
 =?us-ascii?Q?nS/8/QT1e6PtDIj2bmZnmrW7ZQ9yxyQnx+m/VRD/kOuULHvWVwgFxj7N7jyS?=
 =?us-ascii?Q?wSv1LMKkohuxezOy6CxvUavcJ2hYocY1AZGxCTBiMMwytNb24VYerjFN7nPW?=
 =?us-ascii?Q?97aZ7VZLIVRNSN6F3mZVswgCsfMQrZfeUgwFsQb1ZQl1CVtO9WPChC7ZlExL?=
 =?us-ascii?Q?FPZmKH0GbifUS0bXEfJFCeWmpnkmO153OF4QJ4bSHXinNZntD9X2Ksnz2TPG?=
 =?us-ascii?Q?ZT5wRs7FOnJAQuiWUQvMUG0LANFUWM/UyFzqHaD4SwTDXNU4Mu4JXeovVyws?=
 =?us-ascii?Q?tH/GTyTHnUPt/x+0A/LxtHnXDVhfxuTpOehU0VVEnZwLxkolH3GTRe60klYa?=
 =?us-ascii?Q?6a/jxhhX8afXBUYW2TdxqnQchJD8bxutd0tQ1J/JTYoW/tjcQFQxbAwe62Cf?=
 =?us-ascii?Q?um0chdY1FTumY55YLv0lvr0LMnlnl7FLcYDKl5ygK77Z3cWXP4a+vc/O2SyG?=
 =?us-ascii?Q?rww9rkuOE15aUPHJEUVxlQartt0lZ1g0AqIl9CNW9CIkg12cd2kKfU+6l1tk?=
 =?us-ascii?Q?XT8Ovq8N1Wd1fzdgYH7019H6gstcH261dbnG2uVD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c4c288-1f33-4cc7-15ea-08db7b397d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2023 20:18:25.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSw1Dws+91w6xBfTmh9WNM3TafgeWbnoi2PyZy1kLHTMf5l15KwBOXdf8sGdVJK/CvWpEqKjXhSr7UpPCanJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3777
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on rec=
eiving
> packets
>=20
> On Fri, 30 Jun 2023 20:42:28 +0000 Long Li wrote:
> > > > 5.15 and kernel 6.1. (those kernels are longterm) They need this
> > > > fix to achieve the performance target.
> > >
> > > Why can't they be upgraded to get that performance target, and all
> > > the other goodness that those kernels have?  We don't normally
> > > backport new features, right?
> >
> > I think this should be considered as a fix, not a new feature.
> >
> > MANA is designed to be 200GB full duplex at the start.  Due to lack of
> > hardware testing capability at early stage of the project, we could
> > only test 100GB for the Linux driver. When hardware is fully capable
> > of reaching designed spec, this bug in the Linux driver shows up.
>=20
> That part we understand.
>=20
> If I were you I'd try to convince Greg and Paolo that the change is small=
 and
> significant for user experience. And answer Greg's question why upgrading=
 the
> kernel past 6.1 is a challenge in your environment.

I was under the impression that this patch was considered to be a feature,=
=20
not a bug fix. I was trying to justify that the "Fixes:" tag was needed.=20

I apologize for misunderstanding this.

Without this fix, it's not possible to run a typical workload designed for =
200Gb
physical link speed.

We see a large number of customers and Linux distributions committed on 5.1=
5=20
and 6.1 kernels. They planned the product cycles and certification processe=
s=20
around these longterm kernel versions. It's difficult for them to upgrade t=
o newer
kernel versions.

Thanks,

Long
