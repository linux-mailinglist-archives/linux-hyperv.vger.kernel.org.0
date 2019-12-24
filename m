Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855BB12A3CB
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Dec 2019 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLXSDR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Dec 2019 13:03:17 -0500
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:15073
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbfLXSDR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Dec 2019 13:03:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1dF81J6Evr/Z/e1NF1GX4KpnSpI+bLXIybuU8zxl+nVGAryQjBwl7VKRS+Q2JoWwYKtVtYb7YeF7k1LmlxGQs7+VNGzq590ED7i9rhCWPMa4kez761y1UtMjxGCMb8x0GDH6yK6Bok5tcNPpq2o8sNg7T13ZdfsKIxJl/Le39NFUeVlrgYTHQMXqw+OZrRBE2LI2soAd/AjANIikNhQDEtE2afzdkhoOGd/qCuXOy/Wa446cL6j46uHwVm0pLlqX/HxcK8CKQ1yQKCMhUgQtKif9MHD2aBoDHeXm/KcGVrUuEAmtH1BeI0dPfzvy4sRzfSsS1SxRC2TelojsEqvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqbJHT/aB/dtCjCC3fT8KvKlauun+xAijvryN4hDAus=;
 b=f5vgTtkRF85xzouaNUKfdUUavlw9ctcjvgIGMBX7sVsfFueX38EUYU/6yYqVPvomWu9Uiuk2gdKi1QVc05ypqPoqRdchRhn+RNYW1Uah3FnLOexA6+R8K6IQ+s6HFDH2R50jRNerU+sq/Ap2jCC+QJCPSlCHUcklRU3kOgbIq+VtbwjdiBgpF4n6BdGgb86oLpbs+XvBC/9OM/l3+cSlrJAyzDCZceQsfm2bVUEpXAURav7GiE9vHq9Q9hoQm599CbS7v8HkFRQqXLGW3QU+D2b8M5xKenDsDJjg+Z1ZyumbnWpfD80S9o03mhezVca1N73aAILSUgIENuRAfotWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqbJHT/aB/dtCjCC3fT8KvKlauun+xAijvryN4hDAus=;
 b=LmXN4pXo0/qZzkx5ew9oVW8XGEXvyq1X0mqg9sPMiPaWmnq0eumFLNZYcRljt3MxunmAPovxG1jZpOnc11dDOlOTMLTjgMzPh89eTrbmMkHY1mCLtmUwdFBmE5vZynfoA0awlLGhB6dvyjGJTFz/aJjyIDHfTYm+ImxhN792qiw=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.1; Tue, 24 Dec 2019 18:03:15 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::654d:8bdd:471:e0ac]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::654d:8bdd:471:e0ac%9]) with mapi id 15.20.2602.006; Tue, 24 Dec 2019
 18:03:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Roman Kagan <rkagan@virtuozzo.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: flow control in vmbus ring buffers
Thread-Topic: flow control in vmbus ring buffers
Thread-Index: AQHVuki/5e8dawcR8kGygRTboGxxoqfJecsAgAAYkzA=
Date:   Tue, 24 Dec 2019 18:03:15 +0000
Message-ID: <CY4PR21MB06295F8CEE034AD045EEBE79D7290@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <20191224105605.GA164618@rkaganb.sw.ru>
 <20191224162832.GA168681@rkaganb.sw.ru>
In-Reply-To: <20191224162832.GA168681@rkaganb.sw.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-24T18:03:13.2388567Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a171fc1d-c77c-4f9e-aa84-c5766394c574;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56df775a-7576-46db-61a2-08d7889b8c4f
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776477C4B8FE0A9D1EFDDDED7290@CY4PR21MB0776.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(7696005)(2906002)(8936002)(86362001)(186003)(26005)(71200400001)(6506007)(76116006)(33656002)(66946007)(66446008)(66556008)(64756008)(66476007)(52536014)(8676002)(316002)(81166006)(81156014)(110136005)(5660300002)(9686003)(8990500004)(55016002)(10290500003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +L8KXFNkYYri8OrqZky5aLQzeYjOUL5CPD0/KV87Hb2Jm2iJGlEfQPnMlwNxtE3RbmIo1i7iSLOHzMImJdo8AC3UIZx9YxRc8Unqmjj1xpsaNc77ZMMy0YZLd6Wwgqa+KubKl7qa5GYStd8sH0mLKMjHmoW6WsMHoFNkCOty43TVI9OOcJk8zZar6hHFAo9VWoiMQAEpHSTHh/YkWpkDlegprWgXCHmRMhzY60MJ0n2uQTlUAnFkdfMmx99IHaRP/3uhWgVchPVYrW5/uuaCUDFxNmZqUl7LSsKckl/rBTl0HCqn3kX/rYoujlcs7XGFUnsgZZ6wu8NTQG49f0URJhogXkpIvsmsE6HGhy6uZ6be2Tpo8mvFd+jxsmX7DImR7N3cjrNB4Y2v01GuhYJdJeAy9y5H8W0YBrqvMJFOU9V5BF8toZfIxPx19jXm44BH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56df775a-7576-46db-61a2-08d7889b8c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 18:03:15.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlLOYt7dVWicbTS1d+YDxriizWIOjf1sqXORiUn5u4P1Znho7kmLCYA38OT6L8aoN2dYTfiGCbd4+CRpek256zM+UjwAaVlhyUYxC6XJ20g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Roman Kagan <rkagan@virtuozzo.com> Sent: Tuesday, December 24, 2019 8=
:29 AM
>=20
> On Tue, Dec 24, 2019 at 10:56:08AM +0000, Roman Kagan wrote:
> > I'm trying to get my head around how the flow control in vmbus ring
> > buffers works.
> >
> > In particular, I'm failing to see how the following can be prevented:
> >
> >
> >      producer                     |       consumer
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > read read_index                   |
> > (enough room for packet)          |
> > write pending_send_sz =3D 0         |
> > write packet                      |
> > update write_index                |
> >                                   | read write_index
> > read read_index                   | read packet
> > (not enough room for packet)      | update read_index (=3D write_index)
> >                                   | read pending_send_sz =3D 0
> > write pending_send_sz =3D X         | skip notification
> > go to sleep                       | go to sleep
> >                                 stall
> >
> > Could anybody please shed some light on how it's supposed to work?
>=20
> Sorry to reply to myself, but looks like the answer is to re-read
> read_index on the producer side after setting pending_send_sz.
>=20

Are you seeing a problem in the Linux guest code in drivers/hv/ring_buffer.=
c?
The only time the Linux guest as the producer sets pending_send_sz is in th=
e
hv_socket code.  Or are you looking at the KVM code that does emulation of
Hyper-V, where KVM is acting as the producer?

Just curious as to what prompted your question.  I did the most recent fixe=
s a
couple years ago to the Linux guest code for handling the ring buffer inter=
action
with Hyper-V, and if there is still a problem, I'm super interested. :-)

Michael
