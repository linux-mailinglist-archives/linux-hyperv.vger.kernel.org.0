Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26B108544
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Nov 2019 23:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKXWTu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Nov 2019 17:19:50 -0500
Received: from mail-eopbgr740105.outbound.protection.outlook.com ([40.107.74.105]:19958
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfKXWTu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Nov 2019 17:19:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS4YGJhMPYBWcUl0cDVaa5a2ZInmsnszGbLy9d81d42yvDAeeQwU6KFEKaUrp14MC72myb4oCU2chvKLdJN6cw52vyxi5hMNU6T8EpK4awGJ0ENglY34u3nRckCeXIfkMg5xmn0Az65pcZRVyb1GyGXHzUGbbY1rs1SkFn1nqjx1tkqLoPMm8kEr4TTHgU8WNIJqJtalqEsph/ZpVT98XDp1eD0abs1MECFsItyYka6TcurRSxqPgrfPtHduC6yzqoEvwNP4eqcyTyEETk0S+8AM7AkF1zuTVk+v2y5gPWZ/kNuqba3y57hjssxItBAsxSUHK32tjA5PNfnUKTRl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7WdCeHGdt+oG6qInrDtRSsPqeBVRPxzPkxKsb36vl8=;
 b=Sbrz8y5JOlvX0sSuGuuz9sS23/PvaO2d1ezrVhEpP+5k3K0OrpCkpydVmyNeWsDB6IoQMXmZ354AUgPV/Zcl0rgBWkwJXnjvW68sJpa8DwTjpVTjQiflcSCrKh+ExU/bZ94+X7WRW/yKqCd81oh7LWnZtve5HNkZEpnl0glHhP2d3P4HeAHXbkUyTSvtzDLVTrvCMllddWoRtqnnaYZxrinFxdVXrTpvFet5WbJFDD3XJhzR/zOCWGrVgM5H1ob5aKmTGPc3ZO6jrS3hMg5J4KFaDQACGtturastTlX67/+yOdsDxb7xj1SzRltdViPvZpB8O4q8m5M4KReAu2frsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7WdCeHGdt+oG6qInrDtRSsPqeBVRPxzPkxKsb36vl8=;
 b=EKJAD5Cdn0fgzthPnflql5RoPCxJwNgqJy0BuYglUugIYoNpVSfLzTkyYGN/7ivXjKRdDHJjAV1XkRLGzv1qPVboUDiQxvkUGZb6KTuHqdba8B8H4S/24JX15Y3fZSlOR2Vdqe+MoNAcDRekI929m4eUe7mXzLpRbeLNy6ASXN0=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0504.namprd21.prod.outlook.com (10.172.122.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Sun, 24 Nov 2019 22:19:46 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.000; Sun, 24 Nov 2019
 22:19:46 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Thread-Topic: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Thread-Index: AQHVn3KL3T+sMyA2wkWbwY71t4G3oKeUTrMAgAB9sICAALa8gIAFY6iQ
Date:   Sun, 24 Nov 2019 22:19:46 +0000
Message-ID: <CY4PR21MB06290283219FC78C45688DC4D74B0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-3-git-send-email-decui@microsoft.com>
 <20191120172026.GE3279@e121166-lin.cambridge.arm.com>
 <PU1P153MB0169D0A99D5687FBDB02536BBF4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20191121114419.GA4318@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191121114419.GA4318@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-24T22:19:44.6881562Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=182cab51-21e1-4563-975d-fc796fe76cee;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00a52e1d-1717-4df8-6ff7-08d7712c6a1b
x-ms-traffictypediagnostic: CY4PR21MB0504:|CY4PR21MB0504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB050414BCC8FD1C2FE9696EF7D74B0@CY4PR21MB0504.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02318D10FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(54534003)(186003)(76176011)(6506007)(8990500004)(1511001)(52536014)(55016002)(66946007)(102836004)(9686003)(64756008)(71190400001)(25786009)(305945005)(71200400001)(66066001)(8936002)(14444005)(256004)(7736002)(74316002)(26005)(110136005)(33656002)(6436002)(86362001)(99286004)(446003)(66446008)(6116002)(3846002)(4326008)(5660300002)(81166006)(10090500001)(11346002)(229853002)(2906002)(7696005)(6246003)(478600001)(10290500003)(54906003)(8676002)(107886003)(66556008)(14454004)(76116006)(6636002)(22452003)(66476007)(81156014)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0504;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?y4OpiSR/XCfevG8Mstb7xECBFaKNos0KaxmaRhIXjmvZ373hp/eyaZv0UhYG?=
 =?us-ascii?Q?zrA+EVysuR4RrmctZ+p31kieHF7ljT+W4Pre5eQUcTQ1OxgYF8NI3SP5z8ch?=
 =?us-ascii?Q?4gPluGtx6j1Gdfa83NU3wCaxqsHPAzWuiUzHVQ/DsPIekNpf+5I83A0l0+gO?=
 =?us-ascii?Q?KPSTRertMl5r+Tc1Y8q837SmVD7VnP1g4YvPeWaGkpR9LfPtmzx6POoWDtXG?=
 =?us-ascii?Q?0VbpdmCOUUA/EiD2SQiUp114fHclSC8XHIaJBxCLBcz0hcOfD8yGfqPfkPF2?=
 =?us-ascii?Q?q+IOSmTEJzdk+Kuucq1gU528PG8H4odJ7T6Ocq+QmGtd8Lytjf3TMuNy0MCS?=
 =?us-ascii?Q?RNJFeZuufMEFfQ9mwYHRSk4ScLtpb4auG5FDB3EkYXick6BcRhthhXyBzq/F?=
 =?us-ascii?Q?CXOeI3beEWXSieCxxleq1j6bGEcIlrJO2MvBuvTIRDI+fOXXuON4i6AzctTe?=
 =?us-ascii?Q?/DDVCwiCZofGIUDDKR+pPx7sZCrcs0ELcXdbfrdvUV1U/4+Qxu7vRf1NL5UN?=
 =?us-ascii?Q?TvuJZIZH9J2NjDTdhc9INqr951k1vz9UmrwIxIIMUcjGfH0ut+qn/OHAM/gF?=
 =?us-ascii?Q?Kuuvcg/zEn4zq0n5HRkbbu7wNgqz8DMc/2yka3niMPZhO7Eh5P/Q4rFh5bfS?=
 =?us-ascii?Q?FDJrJEHqNIe4+PvtLpdpxK8toSEJdcOMvFnrMcLw83xVdlsFQacEWAXVQOVw?=
 =?us-ascii?Q?eRSWsNRykH10RApVWzhCya1Qxlt8o6Igw3e1jHmwrcsSJ4H+QE8714WCwzzq?=
 =?us-ascii?Q?8mN8HiNz/6LE69bqrfpVXTfr+fkeUzAXhRpSVOKf9BK5S7PYTjeZalunli8s?=
 =?us-ascii?Q?o80dV5a4R/BBHjXuFs2+xIY76hzT0neTZQ8OF1dfKE/yT3h0UHQ+lMwzZZbf?=
 =?us-ascii?Q?qYtfB2tL+0XGweJA1bB/EtJ861Yep3dDMfHoBDxXb5KTG/IqfvZuUr6DpIdh?=
 =?us-ascii?Q?jHkxKeY+VIap6obY3j6bwqu83W7Xpu7fQxfm2udxZwrSslD3fLVCAUONxds1?=
 =?us-ascii?Q?Am9RXeuosYyxKqCoN5F3yr5yt/arSDtOqUCDIHrX2ZIDrGl8HVOzIa6hHv4l?=
 =?us-ascii?Q?7JyO23VpYzR0Jvl2n4MGNSHQt4QOb0eQUeAAAQLg1aj7BIjEKVahOUNBaCeN?=
 =?us-ascii?Q?faaD6WQkr4VlLuElAE4NoIHZlskFDdVvS+or9/fAJ7D9e4T/+aRVkbnDa5ev?=
 =?us-ascii?Q?Q6fRQzNlkqsVPnMYvbGF0rSlrWV4cJwDG9xCr4yMZfuhqIUkMicjK44yK9+8?=
 =?us-ascii?Q?DdFT6TEgrWH/g+Jt1pbYZCkv800zx9yXE3y+YlaR03qYSK50ZbvB3En5NIqQ?=
 =?us-ascii?Q?PxR/IiINou/BP6Ne+6I0d51zJhGSpPZE0gYns9FxQpyzrAp0df0c+xmN2JbF?=
 =?us-ascii?Q?AEJsuj0lCGl1pUZ0zoseIzvJgYrPKrpxs5+MKDcFagcGMsJZBNB44Y+qTRrA?=
 =?us-ascii?Q?1SXxZBE90UdGEouSpapyrdkJovYV3lje6Tig6foUv+dasYyEZgZICAqCesEv?=
 =?us-ascii?Q?aDx0/SpdXcM3BwBfNMj9gdDJnDoGQp8SfMy9tnsx1JQyil7k1/uKASgSvzre?=
 =?us-ascii?Q?7XQc3mtqdDYFdOalC2KNWXjJRKVxa1L6skg5IOJ7ZHwBCjBS/9KxhsdEGbt/?=
 =?us-ascii?Q?3vLY39sV5XZtBuNkuHM63wDY3k8rYMptEYYKnczVni6vWDFHKaZVdIikdHaO?=
 =?us-ascii?Q?J85ABqLAe05WThnnM5f1nlV55CqQDlCE9/1saG19HSyiG0yVOZ2j7BgyI5vO?=
 =?us-ascii?Q?Eh4bKkrzPHzdRJcBh4RkAXpk6+j29tnjtyDjQp+SAk9lh6/gLaEcDKPbc9QT?=
 =?us-ascii?Q?6qe1v/eS/cNMeh9RvyKF5DX8zdakgs4WUTTL7zbPh3yPsXO9azy2vE3OiDwa?=
 =?us-ascii?Q?4ot7TIRr3kYd47/Ff58v9x0jFxolFqzvOakhU0V75haOHYvHlSKWi6+5+b02?=
 =?us-ascii?Q?VlLPrUgRSdd6UJopz5dEiQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a52e1d-1717-4df8-6ff7-08d7712c6a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2019 22:19:46.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWVgynZcOVkg4extZfyyWV5sBdiMDJgDmt0DVjV2kJv6iNyIfii4mVF52cVPPCqXe7hGIB3NtbM54Tb3zBTBavPl1tlgxWQ6BmFg5wJCTBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0504
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>  Sent: Thursday, Novemb=
er 21, 2019 3:44 AM
>=20
> On Thu, Nov 21, 2019 at 12:50:17AM +0000, Dexuan Cui wrote:
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: Wednesday, November 20, 2019 9:20 AM
> > >
> > > On Tue, Nov 19, 2019 at 11:16:56PM -0800, Dexuan Cui wrote:
> > > > Implement the suspend/resume callbacks.
> > > >
> > > > We must make sure there is no pending work items before we call
> > > > vmbus_close().
> > >
> > > Where ? Why ? Imagine a developer reading this log to try to understa=
nd
> > > why you made this change, do you really think this commit log is
> > > informative in its current form ?
> > >
> > > I am not asking a book but this is a significant feature please make
> > > an effort to explain it (I can update the log for you but please
> > > write one and I shall do it).
> > >
> > > Lorenzo
> >
> > Sorry for being sloppy on this patch's changelog! Can you please use th=
e
> > below? I can also post v3 with the new changelog if that's better.
>=20
> As you wish but more importantly get hyper-V maintainers to ACK these
> changes since time is running out for v5.5.
>=20
> Lorenzo
>=20
> > PCI: hv: Add the support of hibernation
> >
> > hv_pci_suspend() runs in a process context as a callback in dpm_suspend=
().
> > When it starts to run, the channel callback hv_pci_onchannelcallback(),
> > which runs in a tasklet context, can be still running concurrently and
> > scheduling new work items onto hbus->wq in hv_pci_devices_present() and
> > hv_pci_eject_device(), and the work item handlers can access the vmbus
> > channel, which can be being closed by hv_pci_suspend(), e.g. the work i=
tem
> > handler pci_devices_present_work() -> new_pcichild_device() writes to
> > the vmbus channel.
> >
> > To eliminate the race, hv_pci_suspend() disables the channel callback
> > tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the tas=
klet.
> >
> > This way, when hv_pci_suspend() proceeds, it knows that no new work ite=
m
> > can be scheduled, and then it flushes hbus->wq and safely closes the vm=
bus
> > channel.
> >
> > Thanks,
> > -- Dexuan

FWIW, I'd like to see the above level of detail also as comments in the cod=
e
Itself so that whoever next looks at the code sees the explanation directly
without having to review the commit logs.

Also, the commit message doesn't say what the commit actually does and
why.  I'd suggest the commit message along these lines:

Add suspend() and resume() functions so that Hyper-V virtual PCI devices ar=
e
handled properly when the VM hibernates and resumes from hibernation.

Note that the suspend() function must make sure there are no pending work
items before calling vmbus_close(), since it runs in a process context as a
callback in dpm_suspend().  When it starts to run, the channel callback
hv_pci_onchannelcallback(), which runs in a tasklet context, can be still r=
unning
concurrently and scheduling new work items onto hbus->wq in
hv_pci_devices_present() and hv_pci_eject_device(), and the work item=20
handlers can access the vmbus channel, which can be being closed by
hv_pci_suspend(), e.g. the work item handler pci_devices_present_work() ->
new_pcichild_device() writes to the vmbus channel.

To eliminate the race, hv_pci_suspend() disables the channel callback
tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the tasklet=
.
This way, when hv_pci_suspend() proceeds, it knows that no new work item
can be scheduled, and then it flushes hbus->wq and safely closes the vmbus
channel.

Michael




