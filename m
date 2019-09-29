Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E9C1899
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Sep 2019 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfI2RoY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 Sep 2019 13:44:24 -0400
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:28944
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728576AbfI2RoY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 Sep 2019 13:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/DUIgBSEj6iCbrj7+gR6jhpbW0TFl1MFBhuz7QfRKbf1PCwN3jr4xmHzVsVL2fkULQopCxzo4DP7lLyoVMcuWqPudxZc3+jGBpVfceH8bX8dAIo6zwTb/Jtcmf/GF1aucC7jd6XmfHTpV4yVW+Wq7sh+L1ZQAV6rby7M3EFzXMBESI1j2frPSvEmNRj5TM2irKZbGaJsoQMc47zZ/EFI5XX/PrrbBTq1kRJyGJF1+KPQ7pC3YZbSOky7dC/MOdruwHgkvXF6oX/9TQEstu35a1zznKohrjlS4NvWjkbbwcDfEu6ZIFnncYkqTuVpRGzltLlG+5WDlq4BxNM06zuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG6F8Qmj3dxTMOQLAg0mctvFKmTjXFY9LGxT/ttbwxE=;
 b=g3zVRlAWqvb+XMIWMemrzUiFPz+K04WF1NJtRf1BCx7RMCB3JGE5IVvp6FYNgR48Rco3BD7lR3FhfZK5pwJtFvXGKF0Ph6+DmC8WAR4O7TRtDcgka0J+mxqiSiwBde8c6K+xBUlP93pT82MK8ROPt7IW0VCkGTwyJ/JwttB2DvIHL9LrB2qxF64+K5PXQnwxUHeDadAx4XODBaRaVoiv1x0c2ca6NJzEyXALK02QZF3GHhuF16cfldQXwwZeLpNAISGF+iEpj67GHWJ2WvV2jTtHUpYtiwOspBHwxCRiXNiptfHan0cN5u7pjw65jx+g24/6bISH5t0mTKyQu8sq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG6F8Qmj3dxTMOQLAg0mctvFKmTjXFY9LGxT/ttbwxE=;
 b=b2MqTkifBOMXSA0Zy54ExZ1fUbSQ2xC1YoKH17u961D1h0uF3hhIEsZDmIHulR6tJ0FVVy21ywQ0ETuvnuCxmwkR3vMt96Q0xk0ygqgbqbTQtEPQd05QrT31tpa4ym4706POxL8jI+c/AGcQuuJDRJApiPxjzcjSQhSzwxo7syg=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0105.APCP153.PROD.OUTLOOK.COM (10.170.188.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.5; Sun, 29 Sep 2019 17:44:10 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Sun, 29 Sep 2019
 17:44:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Jiri Kosina <jikos@kernel.org>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Topic: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Index: AQHVaPmqZINIgyUXxE2R4/KRfEe4oqc84yhwgAEls4CAAABQAIABEIwQgABr94CAA4KkgA==
Date:   Sun, 29 Sep 2019 17:44:09 +0000
Message-ID: <PU1P153MB01698048162343130F34DAE0BF830@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
 <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190927120513.GM8171@sasha-vm>
In-Reply-To: <20190927120513.GM8171@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-29T17:44:05.5467302Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9133849a-7cab-4f19-b59a-aed0a3aed70d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:f552:8d99:acf1:1120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ee66b3-2a03-40ac-28c6-08d74504a23e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0105:|PU1P153MB0105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB010595965F781D7EFCE0605ABF830@PU1P153MB0105.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 017589626D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(51914003)(189003)(199004)(6436002)(305945005)(74316002)(446003)(11346002)(46003)(102836004)(81156014)(81166006)(10090500001)(8676002)(6916009)(8936002)(186003)(7736002)(486006)(476003)(2906002)(7696005)(33656002)(6116002)(71190400001)(71200400001)(6506007)(53546011)(99286004)(14454004)(76176011)(25786009)(86362001)(54906003)(10290500003)(55016002)(66946007)(316002)(22452003)(229853002)(5660300002)(4326008)(256004)(107886003)(6246003)(76116006)(14444005)(9686003)(52536014)(478600001)(8990500004)(66446008)(64756008)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0105;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqJIvfTMxaWkYzV6uSQwupb72StnhBwJRt1uzLPyYSw5og21CRUCJ9AAOuFggeBON+MHB2Fg+baQa+ciRJUZgVgFUfikm0Ilfdxf2SqXdGr5c1Svfw7cK3dz4vWkJSiLMq1EeVk3jUUS4frDP0FCwlXY//ITks2ZfwBGYbJWw65sZMxLlcXYeidx8nHCZn78jr1e1seZ6ObydbI2P0PXXjDwl7BYebGHB4SnSP1N4tztmuJ/5+jZ1TBLcgLah9GjqWCUGmD6/0fku5Sy2SJqIlSU4TlDJs0lJrQNVMNY/LoaprK48Y4EUpK/BVxiahA5o7UGjxlVHNmsg0XTW6ST1j1wWB+fyGQIFJa4qIZzhj0s17hnDzYqGLkWzK73rj390I3kzGfrMnkiVpuklRKk3R+iXBA7dLF5HzNF5C8chAE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ee66b3-2a03-40ac-28c6-08d74504a23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2019 17:44:09.4376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAxPgTLN00QntE8cGjiQHK/T7h570iTDQyuehJ+h3lWh43zI9KvxpJYH5SHJzPzbvcgqmLwoxEDi4zGnQdfPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0105
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Friday, September 27, 2019 5:05 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Jiri Kosina <jikos@kernel.org>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; benjamin.tissoires@redhat.com;
> linux-hyperv@vger.kernel.org; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>
> Subject: Re: [PATCH] HID: hyperv: Add the support of hibernation
>=20
> On Fri, Sep 27, 2019 at 05:42:31AM +0000, Dexuan Cui wrote:
> >> From: Jiri Kosina <jikos@kernel.org>
> >> Sent: Thursday, September 26, 2019 6:23 AM
> >> To: Dexuan Cui <decui@microsoft.com>
> >>
> >> On Thu, 26 Sep 2019, Jiri Kosina wrote:
> >>
> >> > > > This patch is basically a pure Hyper-V specific change and it ha=
s a
> >> > > > build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus=
:
> >> > > > Implement
> >> > > > suspend/resume for VSC drivers for hibernation"), which is on Sa=
sha
> >> Levin's
> >> > > > Hyper-V tree's hyperv-next branch [ ... snipped ...]
> >> > > >
> >> > > > I request this patch should go through Sasha's tree rather than =
the
> >> > > > input subsystem's tree.
> >> > > >
> >> > > > Hi Jiri, Benjamin, can you please Ack?
> >> > >
> >> > > Hi Jiri, Benjamin,
> >> > > Can you please take a look at the patch?
> >> >
> >> > Hi Dexuan,
> >> >
> >> > I am planning to process it once 5.4 merge window is over and thus h=
id.git
> >> > is open again for 5.5 material.
> >>
> >> Ah, now I see you asked for this go through hyperv tree. For that, fee=
l
> >> free to add
> >> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> >> Jiri Kosina
> >
> >Thanks for the Ack, Jiri!
> >
> >I have a bunch of patches, including this one, to support Linux VM's
> hibernation
> >when the VM runs on Hyper-V. I just feel it would be better for all of t=
hem to
> >go through the Hyper-V tree. :-)
>=20
> Thank Dexuan, Jiri,
>=20
> Dexuan, I've been silently ignoring your patches for the past few weeks
> for the same reason as Jiri has mentioned. I'll pick them all up once
> the 5.4 merge window closes in a few days.
>=20
> Thanks,
> Sasha

Thanks, Sasha!

BTW, I'll post a v2 for this patch, as IMO I may be able to get rid of the
mousevsc_pm_notify in this patch by disabling the channel callback
in the suspend function.

Thanks,
-- Dexuan
