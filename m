Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1575F196ADF
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Mar 2020 05:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC2Dnb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Mar 2020 23:43:31 -0400
Received: from mail-mw2nam10on2101.outbound.protection.outlook.com ([40.107.94.101]:29248
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgC2Dnb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Mar 2020 23:43:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbjZlgjGQZ3KwAVJ3hWvnc8N80wOdR+I91q1kP6m1q27qxcvCE9cZjREQEc2RjGnqfEQiBJPj9f+UOoqINUtTyutbicZTk/VRjCj3StMRypNnI/MjA7aLBwy2YHV0AgvbC14GsCIEdayWGFTjY6Us2aIymN02jqIO0BuAWSlaWoXoniOYv0otP6Jmh7xRB5sKXhISJCdWGRLY68e4d7CySyqcwl8Ia5lFYV5FpADtQLypNTCkiF1B7tRUuKpR43vA/OYHhIhORwt6UsRoImndVZ/LMjP8kICQgzzY2v/5lH/FezwfuWDWdZnavasxL+kfC4vBkQOliuFGB6qA3dXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Ucq3xY4452P5O9w2Sv5WjT0RNmTJ09h5Rlj2VI5dU=;
 b=DBf70miBtcdMHxhOhnLKZwGxnAWvLm6wg1/W0t1CAnqCHYBVeuR5gYjdf3V3JvmjpvBtpi1feEmgpcS7xjYvMjr2bd5IDpHFPISY+Agl+V0PwxFt9o7E8JuSIuRDbGkJc+hjnnindDXOLb8nyVqlrcnT6StMdu4Dv8Pv9nWZCtHgjuoXIRRGcuLHX1yxWRd/qDNK4+frMK+reSFVdsVu63i+v08G0lBhYNilMXqyO8l68asC/ImD8lOmQhgFH5LJFJepF0k3OOcwzqKNEerM6+179uSjjwTCM4ayfzFgirzL+0GhR1oSXbg/FQlMNoLC9zBeSe7fkWMzr/E5hg4fcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Ucq3xY4452P5O9w2Sv5WjT0RNmTJ09h5Rlj2VI5dU=;
 b=HXP7wuhFHRG986UIsMqjqDr0rt9+Szw0GoyzMRigmdvvLnLA3EnLw1F8ssblzKtdQg4CxKbk8PnrIaQGlPNws8nqnQ802khA/KHilcaA+mHZ8msCjIaTK9xy/8xP68+arvdw7b+frllnh8AOKDPYdbiEmlaecY7uSaD0Zqa1kcc=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0971.namprd21.prod.outlook.com (2603:10b6:302:4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.11; Sun, 29 Mar
 2020 03:43:27 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Sun, 29 Mar 2020
 03:43:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        vkuznets <vkuznets@redhat.com>
CC:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the
 offer&rescind works to a specific CPU
Thread-Topic: [RFC PATCH 02/11] Drivers: hv: vmbus: Don't bind the
 offer&rescind works to a specific CPU
Thread-Index: AQHWAvib6zfTCyxILUyFKM4kLvY1Vqha7E2AgAAZYACAABvAgIADH6eAgACwUWA=
Date:   Sun, 29 Mar 2020 03:43:26 +0000
Message-ID: <MW2PR2101MB1052A2E44557B29C191F557DD7CA0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-3-parri.andrea@gmail.com>
 <871rpf5hhm.fsf@vitty.brq.redhat.com> <20200326154710.GA13711@andrea>
 <87sghv3u4a.fsf@vitty.brq.redhat.com> <20200328170833.GA10153@andrea>
In-Reply-To: <20200328170833.GA10153@andrea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-29T03:43:22.5061605Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a53363b-5a04-48ec-973e-0efbd02110e2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55bb00b0-3bca-4a7f-d132-08d7d393570c
x-ms-traffictypediagnostic: MW2PR2101MB0971:|MW2PR2101MB0971:|MW2PR2101MB0971:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB097169437C37E5407C86E0F9D7CA0@MW2PR2101MB0971.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 035748864E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(26005)(6506007)(66946007)(8990500004)(316002)(33656002)(7696005)(54906003)(110136005)(82950400001)(478600001)(52536014)(66446008)(10290500003)(76116006)(64756008)(5660300002)(66556008)(4326008)(66476007)(8936002)(81166006)(9686003)(186003)(71200400001)(8676002)(81156014)(55016002)(86362001)(82960400001)(2906002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dAhUivprGjTgGzyOXSNr7p1TPWH9Qly/F4IrXIDW34ValfBnkzPGW0eSIUU0JfnMbAebXHZOG8NCRNAsenzZ1X8HS56jWVGE4cdP0JtyxNt+/x5nEMeBoLzDYvZX2dz9v/S3GBN4umUbuZR0m3MTfyOpqaDoolSlwyWwAJAr/UM7UtvCu1SxQanxKzJZ5MnKG/YD70tOmB3hoZamkAb++dnwJO8qRHZcr/2nOSnVqHc0RPswzuyOoRmHCigXn5FekdWVJzoHSQlL/yrNuB1C7tF84GaGhnmGdG16uLOo6tCbUicAYceTVhDbAU8SQ8d+3JhUkjJEi+1VTgsIwUpw0bX3WRBiy0I3hymr8hAbZXLhg2u/QbXWYwuTzUaovRUexrxJY/tfUdfvpVikynEyT+A5xD55JgSIVPRuuENpNdqw/+SdqNkTw1b3dDHwXe7Y
x-ms-exchange-antispam-messagedata: aJFLBNt4ZeanSWRQy8BY8NAmkzcADy3sF7f4cu/hbPxHLONBVqn379cigy3R8J/cRoqsJ99/zswq9F09gMVVNAFHNuvsDIgHvg/cyyXW9EjkSqmqhDHRIG6cCMs+ydOF9+tUokkXR/OObYDLyGPNNg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bb00b0-3bca-4a7f-d132-08d7d393570c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2020 03:43:26.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COTryyYus9c0e5TxuDhYEbxf8MOQJuJKUoBOqc8AC5hyf1KuZVhXmBYARWA/An8RhrT0xpp+7oxYzLQlrSziJoTBs3/Kh/0O0CPd4HoCZzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0971
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Saturday, March 28, 2020 =
10:09 AM
>=20
> > In case we believe that OFFER -> RESCINF sequence is always ordered
> > by the host AND we don't care about other offers in the queue the
> > suggested locking is OK: we're guaranteed to process RESCIND after we
> > finished processing OFFER for the same channel. However, waiting for
> > 'offer_in_progress =3D=3D 0' looks fishy so I'd suggest we at least add=
 a
> > comment explaining that the wait is only needed to serialize us with
> > possible OFFER for the same channel - and nothing else. I'd personally
> > still slightly prefer the algorythm I suggested as it guarantees we tak=
e
> > channel_mutex with offer_in_progress =3D=3D 0 -- even if there are no i=
ssues
> > we can think of today (not strongly though).
>=20
> Does it?  offer_in_progress is incremented without channel_mutex...
>=20
> IAC, I have no objections to apply the changes you suggested.  To avoid
> misunderstandings: vmbus_bus_suspend() presents a similar usage...  Are
> you suggesting that I apply similar changes there?
>=20
> Alternatively:  FWIW, the comment in vmbus_onoffer_rescind() does refer
> to "The offer msg and the corresponding rescind msg...".  I am all ears
> if you have any concrete suggestions to improve these comments.
>=20

Given that waiting for 'offer_in_progress =3D=3D 0' is the current code, I =
think
there's an argument to made for not changing it if the change isn't strictl=
y
necessary.  This patch set introduces enough change that *is* necessary. :-=
)

Michael
