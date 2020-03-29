Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442D3196AE6
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Mar 2020 05:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC2DtM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 28 Mar 2020 23:49:12 -0400
Received: from mail-mw2nam10on2131.outbound.protection.outlook.com ([40.107.94.131]:4608
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgC2DtM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 28 Mar 2020 23:49:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlTscLzQHkPhJ5e702bgWeV6k0LewU/N6gCQTFQdEfPvnKF7oqoAck5IXcCKxLu/hYDJRtFwIAJ8IGgS1Po/uRCP6SIzG9zXh5OxlWtz9NWuaE/J/lWZ7h4n/Klkdqu5oCEWt14olWRzXVSfFgOXySlHg5LUGSERiIXkJ5IwxGudMEiPkdRm3/JEIijxFyPe03Z7YmfOOisUyrXbCK/pz6A3jK9f7iPjKtmzwer9FLRei+ue/yBbj81pLo4DnWdBybeMKg+QIUYYNuegHFSECC+jTew63s326w+UG6gNObbKZTfHTN2gv99PClRSYKKxg6OfpTuuyRdu6pzrlC6e3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUJQGZH1WHvybcDiZXPxvagzrgfXY32dKjHb674YKfw=;
 b=XsvtlOCK+ltJyAHXJIINBJUs9rH7MO3MnXmGG35oy9H89RYg43G/DLhRS3qFu/1LSKOHU6dFuV6WrpgRQnNISFEyW97wuOharHjIPkUMSpcbuPbZvhstGIGsp0k44vsm5+y6ZI9n3XrN0ErRJOUXy3PMWh9mUHYEDgI2WZqa/NceJ+Jna3g0JVSB+9DgGgDIMbamn5CJQD1S0deiKxrLRm223712S0RbXuzjZDMXtz1lDBtsvKvOudAltFWhWJrAlsGdQOblOQQS//WPr1TnKXcqQxUwLQJYpGEarhR1h/O/XupzbWlTDIKIjdeC8WjeXw71BL/jQ6QzNAUjWNt6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUJQGZH1WHvybcDiZXPxvagzrgfXY32dKjHb674YKfw=;
 b=dVpyXFVg4iAaAnr4IRzuRPxTufHZ7yl+WG+TJ7/BWmQMBwY9/5jMJpXRunqWPCaRvcdpwSnxwX5T4PTWEHaQyY/ZakyDMjf/pXfrKtRxDwoluMNGSQ0+uy98/D9YtxF7WG5LjkadjeCk4RPmj9dav6SoThLCjameompwzxCzYbU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0971.namprd21.prod.outlook.com (2603:10b6:302:4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.11; Sun, 29 Mar
 2020 03:49:06 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Sun, 29 Mar 2020
 03:49:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        vkuznets <vkuznets@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel
 lists with a global array of channels
Thread-Topic: [RFC PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU
 channel lists with a global array of channels
Thread-Index: AQHWAvico4ZmXIW+OUuJvbv+arPat6ha8H0AgAArBQCAAAqNAIADL3wAgACc9cA=
Date:   Sun, 29 Mar 2020 03:49:06 +0000
Message-ID: <MW2PR2101MB10521D93B6CDE4D7D9C435E3D7CA0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
 <20200325225505.23998-4-parri.andrea@gmail.com>
 <87y2rn4287.fsf@vitty.brq.redhat.com> <20200326170518.GA14314@andrea>
 <87pncz3tcn.fsf@vitty.brq.redhat.com> <20200328182148.GA11210@andrea>
In-Reply-To: <20200328182148.GA11210@andrea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-29T03:49:04.0457472Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7884bb8a-3bb6-4bfe-a2ef-c7cca989fdbc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b83ae07-9496-42b7-d6bc-08d7d3942133
x-ms-traffictypediagnostic: MW2PR2101MB0971:|MW2PR2101MB0971:|MW2PR2101MB0971:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0971FE06C4BDC772A26356DAD7CA0@MW2PR2101MB0971.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 035748864E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(26005)(6506007)(66946007)(8990500004)(316002)(33656002)(7696005)(54906003)(110136005)(82950400001)(478600001)(52536014)(66446008)(10290500003)(76116006)(64756008)(5660300002)(66556008)(4326008)(66476007)(8936002)(81166006)(9686003)(186003)(71200400001)(8676002)(81156014)(55016002)(86362001)(82960400001)(2906002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7OQODSsOKjEuZQAeGzF+hX2vgAAYEQIm/PoHDNnZF4rTh3FuOUQliPB0l8+dA1HLSko3Jy6bPKeeJPmJMZkfugnrwFhDU0JFONbyqMI9iIVk6COTf2BsbGmQJa0bc/A8hUKIQEpwo/k/loZVvxf6dGYeS308wQb8/71jHwqPsAg2xdDdid9uS8B7J9iaLxDBzNKJvo798ce1A4O1F+vq1xpdSTW6BuYcKxa1UVnC03pjUc8IUf8QCtti4ob9QfDzgMJlBXA1vtR3dB4kFWBNDYCdJlVNdwH63rT7SFibgt6hiYJGvQJcfrl8E3hE3i7uOPoms0P4mZrAwOMH2AiwrIKytjx5R7t1DtJ2jFhUC2UCPt+TqK1Xvun03OFuDYnwzRPuJXVkWr2erjHDXKm/rWXQAp3/CBflB8+swyulfpYFrjl3h/kep++r5Ko1a03E
x-ms-exchange-antispam-messagedata: YrnrubL5k0QfS+oSoNu8TXJWy9aPX6FFqaJK0JBvdWMUe/Z/8m29iHxcxlQjkdxPMnZChUVmVC9Q3Kp7WpX7QMcOQpvDIEjZnstBHV/JbR9oVNpl0GUqsyr0AwLv7jJQR3/c3xc9lb1QFYdr8J69GA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b83ae07-9496-42b7-d6bc-08d7d3942133
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2020 03:49:06.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yk8BW7I985oVuv5OBZfFA6msKX6125MZOZjtfI58Uypic5S0IAHC2fQtHwoeNPNIy/fHV3i2JufVH4SOxamumDyEC4Fx49DIRMJB8LagNpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0971
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Saturday, March 28, 2020 =
11:22 AM
>=20
> > Correct me if I'm wrong, but currently vmbus_chan_sched() accesses
> > per-cpu list of channels on the same CPU so we don't need a spinlock to
> > guarantee that during an interrupt we'll be able to see the update if i=
t
> > happened before the interrupt (in chronological order). With a global
> > list of relids, who guarantees that an interrupt handler on another CPU
> > will actually see the modified list?
>=20
> Thanks for pointing this out!
>=20
> The offer/resume path presents implicit full memory barriers, program
> -order after the array store which should guarantee the visibility of
> the store to *all* CPUs before the offer/resume can complete (c.f.,
>=20
>   tools/memory-model/Documentation/explanation.txt, Sect. #13
>=20
> and assuming that the offer/resume for a channel must complete before
> the corresponding handler, which seems to be the case considered that
> some essential channel fields are initialized only later...)
>=20
> IIUC, the spin lock approach you suggested will work and be "simpler";
> an obvious side effect would be, well, a global synchronization point
> in vmbus_chan_sched()...
>=20
> Thoughts?
>=20

Note that this global array is accessed overwhelmingly with reads.  Once
The system is initialized, channels only rarely come-or-go, so writes will
be rare.  So the array can be cached in all CPUs, and we need to avoid
any global synchronization points.  Leveraging the full semantics of the
memory model (across all architectures) seems like the right approach
to preserve a high level of concurrency.

Michael
