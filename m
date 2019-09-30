Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5C9C294F
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 00:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfI3WJh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Sep 2019 18:09:37 -0400
Received: from mail-eopbgr1320135.outbound.protection.outlook.com ([40.107.132.135]:3552
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729482AbfI3WJh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Sep 2019 18:09:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLzZV97UWdC4UUl014JzGRZbYpLvF1RlQruIFuw/L9/vwKEcP8XktTyCwHPy/GYyq82TFeG068/mtRYapFmJJ/g65YD3GyxuJWrgdXscMJogm2zi8cIg2QT03X8BbM34QZksd1MOhmuWfst2XFoPBiNWpYY4m/PhDig0sglUnMqpzVzZaQCAKOgy2qjmE7AI1dnitfIu2wb6CaTAmMd8MdWMSVbEPoOq0H0/Zkfblwz8jPo3j9AQtPmLUccoYOf2jOGd5BHohZVZBUXD9v9EGCaROTlANklkpdJ6JhXLWqGWKLmFA09vFWuVCVCO1t03qbZSmVIWbEWOxleRvvch3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0LDPIHGPzCVHxMX8kDMPPdCpOcpsoSoxn4IZGcWZvk=;
 b=cdO1hyCEkwrDU7Nvkba+M2iYEuuWI/kRJBNGSwPQisIjRLptbmubMvSKJ/AGH7WcpWEJELU4hzZassGu6aRdkDMrMlakCFbWhjPL3973QrEBaDdkEHVow4EKv9RhNqt6sFZ3jShvbialHQDNfvcBW2FEKSCv7p2i9/JKQL21UVxoxycHN52pex8a2k9dw0cPWX/a2G3ZVS5NihqK8XY3p/XOlP5pgmuRxSL80UyFfPeuEMNNVTL446xZrMtYY5S1ylmS1xmJ/LSEmGG66rEXAyA8qiZv7C4lzII7LAF5+r+AePqcxGp3r4/QBYi6XyUW/lgOo1IJsC/418d6ps/dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0LDPIHGPzCVHxMX8kDMPPdCpOcpsoSoxn4IZGcWZvk=;
 b=fE6JtvpBLqzhoUPdRlxD2w8UhT9ppd2V9h5xWXClhZm51kS4edH3c+x3HghoL5tKLRCpunXmzaP2ZabGZn0wkF9+eM1jh6HF22lNVHfrjftARZzcRMetI2Q/JgK7sjAPNQET2zvRQ+hSMgDFedTljf5T4BKvK5faEy46K2Kmkr4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0156.APCP153.PROD.OUTLOOK.COM (10.170.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.2; Mon, 30 Sep 2019 22:09:27 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Mon, 30 Sep 2019
 22:09:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Topic: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Index: AQHVbwXQRPtGDntMcU+sv4R8q5dPMac1q4VggAqesgCABFerkA==
Date:   Mon, 30 Sep 2019 22:09:27 +0000
Message-ID: <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
In-Reply-To: <20190928003156.GU237523@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-30T22:09:25.4119108Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=df2f87e7-a24c-48a1-a18a-a3dad1ec61f7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:d492:e91a:5e0:dd92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 123d5ca1-902d-4948-d2f3-08d745f2dc49
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0156:|PU1P153MB0156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB015692F008727CD7A712FCFBBF820@PU1P153MB0156.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(199004)(189003)(107886003)(71200400001)(229853002)(10290500003)(305945005)(2501003)(55016002)(6436002)(2906002)(10090500001)(6116002)(7696005)(8990500004)(6506007)(76176011)(6246003)(46003)(52536014)(99286004)(186003)(2351001)(7736002)(446003)(14444005)(486006)(5660300002)(5640700003)(54906003)(478600001)(256004)(66476007)(64756008)(66556008)(66946007)(66446008)(1361003)(76116006)(102836004)(25786009)(22452003)(74316002)(316002)(86362001)(476003)(33656002)(71190400001)(4326008)(11346002)(14454004)(8936002)(9686003)(8676002)(81166006)(6916009)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0156;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7yjgHPbq7WccIlEzwLzKjLcDGRKyKOJKf2V6va/D7dLKkMqr/xqXhAe6/gQOFzHMwDKEdpzo/rQuBQT3JtjgqjfBPi68uS9JsN1c2gx80xAIscH9OjpwfGJ4blMFMkSo0a8fbvISXkBF8VnZ7McHtBcoeDXWtTYX+A7iRewooTnorin707+FAxyxI33NLI3Zm9emcSbSgkqGl9GJMdwtr8rW19y3GCoi6YaGFTcXRqt1wLjSbeZOEYJLQS9O+p6E3KwycgxPLH+M0J4LbUmgL5+RqIFIobwM0H8oyxEfE8eYkBPhoRJX/v0o/S6oPo4Ls8jsdJVkVAuusCO2JRc5kxUeAiEECUFDsHNj7eb7/hbVVxAVn0TUHlgXMD11r4gxUkX3R0lYTRiGaOTcMva1CfRg+0OyFtNU76/ywBy6ps=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123d5ca1-902d-4948-d2f3-08d745f2dc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 22:09:27.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbpS9Qdn+I/mrm0mfL90jhb5SasA0psQ3Q68j9BH2PEZq0U3Wu6p0RO7AnLcCR5Xh1VNFnP7vU7X6MTiTr+RUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0156
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
> Sent: Friday, September 27, 2019 5:32 PM
> > ...
> > pm_wakeup_pending() is tested in a lot of places in the suspend
> > process and eventually an unintentional keystroke (or mouse movement,
> > when it comes to the Hyper-V mouse driver drivers/hid/hid-hyperv.c)
> > causes the whole hibernation process to be aborted. Usually this
> > behavior is not expected by the user, I think.
>=20
> Why not? If a device is configured as wakeup source, then it activity
> should wake up the system, unless you disable it.

Generally speaking, I agree, but compared to a physical machine, IMO=20
the scenario is a little differnet when it comes to a VM running on Hyper-V=
:
on the host there is a window that represents the VM, and the user can
unintentionally switch the keyboard input focus to the window (or move
the mouse/cursor over the window) and then the host automatically=20
sends some special keystrokes (and mouse events) , and this aborts the
hibernation process. =20

And, when it comes to the Hyper-V mouse device, IMO it's easy for the
user to unintentionally move the mouse after the "hibernation" button
is clicked. I suppose a physical machine would have the same issue, though.

> > So, I use the notifier to set the flag variable and with it the driver =
can
> > know when it should not call pm_wakeup_hard_event().
>=20
> No, please implement hibernation support properly, as notifier + flag is
> a hack.=20

The keyboard/mouse driver can avoid the flag by disabling the=20
keyboard/mouse event handling, but the problem is that they don't know
when exactly they should disable the event handling. I think the PM
notifier is the only way to tell the drivers a hibernation process is ongoi=
ng.

Do you think this idea (notifer + disabling event handling) is acceptable?

If not, then I'll have to remove the notifer completely, and document this =
as
a known issue to the user: when a hibernation process is started, be carefu=
l
to not switch input focus and not touch the keyboard/mouse until the
hibernation process is finished. :-)

> In this particular case you do not want to have your
> hv_kbd_resume() to be called in place of pm_ops->thaw() as that is what
> reenables the keyboard vmbus channel and causes the undesired wakeup
> events.=20

This is only part of the issues. Another example: before the
pm_ops()->freeze()'s of all the devices are called, pm_wakeup_pending()
is already tested in a lot of places (e.g. in try_to_freeze_tasks ()) in th=
e=20
suspend process, and can abort the whole suspend process upon the user's
unintentional input focus switch, keystroke and mouse movement.

> Your vmbus implementation should allow individual drivers to
> control the set of PM operations that they wish to use, instead of
> forcing everything through suspend/resume.
>=20
> Dmitry

Since the devices are pure software-emulated devices, no PM operation was
supported in the past, and now suspend/resume are the only two PM operation=
s
we're going to support. If the idea (notifer + disabling event handling) is=
 not
good enough, we'll have to document the issue to the user, as I described a=
bove.

Thanks,
-- Dexuan
