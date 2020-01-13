Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA81393F6
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 15:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgAMOtz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 09:49:55 -0500
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:30216
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbgAMOtu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 09:49:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG4wSDopWDVUqUd49a2vQDljBFzPYYQ4BfdllJxVgfgSCjopZhZj5TSVLWW5VgW480fRh9rmwkU+X6j4HthxD3gEnUndBDu5nu39jd83aObJAHC/cMsVc9CceHi/qMmMDjJD1jXOcpIWWJuINDtEiiqeLS+XkTP7qULyFmZt7491daFuNDb9k/50B9QPy7nV4+Q2E3mN6fAb4RIdKdgHafE41WCJkEJbZpwvFzFOThANzwuIpNTKHgw565+5cr/skohIuZwMFMl6p9lw7aGJrOQbpZcB+1q0h4hlpa+E7u1IM/q81KxdYLbctbc7Y9rA6yzlSnikyeoek1N93PVLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYK0mntyGytJIB1/2aqSA4dPqXfPMRI76GIkg/pDN2c=;
 b=by3NeSdYhQDZcBldN4c79DEGVsK0B/oUM+SZ2nKS4KrOTXWntZhO6nSsbvv5PM10DMHkfDOLx1TSTedUDYdT50zrNeaINOnUWaqDu4RS7FaeHiP+yZ3rFLFngd+Psfqkmfbwj9SBLM6AGmGsPlRXayeerPPp/rhfJxzBC8a4slDHa5suCjnU6B5SP0cn8wnbQyUUQ2ck5t3Llq7VBqWQBNNd2upZZSJ+Hurxjg6c4QhtIbYDIpvge7Hqi43Xo1rF4+MAJ8F/txwMmb896rXAIcXfUttquGchAig9eISFaRqWhmqic67cL2U0PIxj5uSSoDAWVQLj2sZfV7I1DfQsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYK0mntyGytJIB1/2aqSA4dPqXfPMRI76GIkg/pDN2c=;
 b=cBWJlJ7Dfp+NdK4fL2PUbV9binH8NYwHtB14IOi0y1FimPodAjJC+juFnETr2jcOWXtR69LED8R1UIWx9X7yJea/yPkIZmtWKUnotTUvRZbQE7Vbsw1yTfZWmhIDE/gjlHfK7K9yahBhGIVgRmISow7GVQw66BpQZcsWFsAnVaU=
Received: from SG2P153MB0349.APCP153.PROD.OUTLOOK.COM (52.132.233.84) by
 SG2P153MB0350.APCP153.PROD.OUTLOOK.COM (52.132.233.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.1; Mon, 13 Jan 2020 14:49:39 +0000
Received: from SG2P153MB0349.APCP153.PROD.OUTLOOK.COM
 ([fe80::cce1:5261:6c2:51a9]) by SG2P153MB0349.APCP153.PROD.OUTLOOK.COM
 ([fe80::cce1:5261:6c2:51a9%8]) with mapi id 15.20.2644.015; Mon, 13 Jan 2020
 14:49:39 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        vkuznets <vkuznets@redhat.com>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>
Subject: RE: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose
 is_mem_section_removable() symbol
Thread-Topic: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose
 is_mem_section_removable() symbol
Thread-Index: AQHVxV94OmmoHHYtiky82H1ysWWO7qfj7JsAgAS1vtA=
Date:   Mon, 13 Jan 2020 14:49:38 +0000
Message-ID: <SG2P153MB0349F85FB0C1C02F55391F6D92350@SG2P153MB0349.APCP153.PROD.OUTLOOK.COM>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-3-Tianyu.Lan@microsoft.com>
 <20200107133623.GJ32178@dhcp22.suse.cz>
 <99a6db0c-6d73-d982-58b3-7a0172748ae4@redhat.com>
In-Reply-To: <99a6db0c-6d73-d982-58b3-7a0172748ae4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T14:49:35.5863663Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=839a5a22-6b22-45c5-8fad-86981e3dc02c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d1eb10e-9d0b-44e0-e59c-08d79837d0e1
x-ms-traffictypediagnostic: SG2P153MB0350:|SG2P153MB0350:|SG2P153MB0350:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SG2P153MB0350FC0B68AC9CB197DDC87092350@SG2P153MB0350.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(110136005)(54906003)(8676002)(2906002)(81166006)(8936002)(4326008)(81156014)(8990500004)(86362001)(71200400001)(7416002)(66446008)(5660300002)(66556008)(55016002)(64756008)(66476007)(52536014)(186003)(498600001)(66946007)(9686003)(7696005)(6506007)(76116006)(26005)(53546011)(10290500003)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P153MB0350;H:SG2P153MB0349.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UonD3Is0u7MP2s5m/rIYEvRd4KAxY3MSM2X5/KqFBwRxkDALmSkA5qk3RCI4BA20zWUCQkLzMIYwwIXM60cUQYBfOkQRFrKRIA12mI87AFuGrK5Lo7q+7o0Nqw+EfVyNw9AIKf7JH8dO4U+WFFwx9SloXiuYIsKS8ervpNf0x7ICibyNVP6wHJm0wt0wnoGTakpt0Yo9rBXH0ucpHBoGt+84c4MIM8fHXA9jCVdwxh2sWvvF9pfGRp3s2R1yj4NV+UXci18OHImyl2gF2uW6LjWKT1++JD1MDMLTZVoJhX/4ba8W/2Ht1MsxZhSi9nAlOZwrre/sbjfRbJfsWrISyHh1NnZC3k524bz76bUbQiWa+MzVYehqe2TTT2BgweBV1estfNawPXMELP/7dkbrm6xaSkXfZmQhilQ8XoOTbArgVFhxRcZXUDsa8XN1I3Ea
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1eb10e-9d0b-44e0-e59c-08d79837d0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 14:49:38.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tXfxBuFFz4PzQTIV9etBSoPIYVSMKMyUqfx3KWslqf5+E5lqcUtT+p45MhaoyZhqSuCxFtl1poQKr+rGTY91g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0350
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: David Hildenbrand <david@redhat.com>
> Sent: Friday, January 10, 2020 9:42 PM
> To: Michal Hocko <mhocko@kernel.org>; lantianyu1986@gmail.com
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> sashal@kernel.org; akpm@linux-foundation.org; Michael Kelley
> <mikelley@microsoft.com>; Tianyu Lan <Tianyu.Lan@microsoft.com>; linux-
> hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> vkuznets <vkuznets@redhat.com>; eric.devolder@oracle.com; vbabka@suse.cz;
> osalvador@suse.de; Pasha Tatashin <Pavel.Tatashin@microsoft.com>;
> rppt@linux.ibm.com
> Subject: [EXTERNAL] Re: [RFC PATCH V2 2/10] mm: expose
> is_mem_section_removable() symbol
>=20
> On 07.01.20 14:36, Michal Hocko wrote:
> > On Tue 07-01-20 21:09:42, lantianyu1986@gmail.com wrote:
> >> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >>
> >> Hyper-V balloon driver will use is_mem_section_removable() to check
> >> whether memory block is removable or not when receive memory hot
> >> remove msg. Expose it.
> >
> > I do not think this is a good idea. The check is inherently racy. Why
> > cannot the balloon driver simply hotremove the region when asked?
> >
>=20
> It's not only racy, it also gives no guarantees. False postives and false=
 negatives
> are possible.
>=20
> If you want to avoid having to loop forever trying to offline when callin=
g
> offline_and_remove_memory(), you could try to
> alloc_contig_range() the memory first and then play the PG_offline+notifi=
er
> game like virtio-mem.
>=20
> I don't remember clearly, but I think pinned pages can make offlining loo=
p for a
> long time. And I remember there were other scenarios as well (including o=
ut of
> memory conditions and similar).
>=20
> I sent an RFC [1] for powerpc/memtrace that does the same (just error
> handling is more complicated as it wants to offline and remove multiple
> consecutive memory blocks) - if you want to try to go down that path.
>=20
Hi David & Michal:
	Thanks for your review. Some memory blocks are not suitable for hot-plug.
If not check memory block's removable, offline_pages() will report some fai=
lure error
e.g, "failed due to memory holes" and  "failure to isolate range". I think =
the check maybe
added into offline_and_remove_memory()? This may help to not create/expose =
a new
interface to do such check in module.


