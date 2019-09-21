Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF792B9CCA
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Sep 2019 08:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437309AbfIUG4P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 21 Sep 2019 02:56:15 -0400
Received: from mail-eopbgr1320128.outbound.protection.outlook.com ([40.107.132.128]:6126
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728865AbfIUG4P (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 21 Sep 2019 02:56:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWv6XMcA/CsBCkuTRSQTHRdUgUoUjP3ZsJMTH/XhbXwts8M7F4BSuz8XTJu+PCr5s38N9pKJ05xbM5psfyCrDYYEQ0Rm8rLR+gIWUUec2CntzHIydiM9/8jU97J4OzbDF/JXpA93sW8A3SEtruCAtYBOJEiZaJWDd7MSR+/2evyaPdsiflaF9xUTrLAfKyfpi2Xh50kyKNVRkXQxO+9xCtNR/Lgeg+JBpUSjOQT5AszLdWUaS1rW0AU6fjXnD1KM5Xo03FwADh1UXuKBE9VQnV6YrgxAhECrHReCLpVISGFdr8fLNeLRnJEaeAIFyc7dSe5MajW2fc1D0glmxg4P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ1YMaSMqYcjvsDV326jsZkOahmM/bqbC2EWNgU8dvA=;
 b=V4SFWwem/6HSQNGJXDHI4fQ1n+A2QlrJGTx3VTAnHoMR1dIA83IOkVeBsT6l7xl0sewJ/k0PD0sqEgT9YvTWo6OTPXTrFCiOri1Ds4FEEpLuBuf1hy3h5uGWP43Rbi/VDiR3vkx2gonpRpTkV4Z9YVTpIC418uvO1OI2nLT/0qM3uyQ9tT4g8KvR9H3EBmvY5V7Xz6HS/hlGZ1Nf5Xc7aQ2Y20saX06FUWgco664QwoBjxe/3eCCXgkqseT3L0v3d9csuFSfSakVd+GA6ciV7y24KepAUtuFnGTJhou6aEYhL3H45fa1C4y6nX/txal2clsWOBJr+uJc6klWGwocsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ1YMaSMqYcjvsDV326jsZkOahmM/bqbC2EWNgU8dvA=;
 b=aKoeW6NUvpkMYr/O6toHJi7OfIpA5Vw6Ts7+fSUc0fnXT4/ba5HV3Okj7zUEtGyf8MEczflUDdHVG/WKrq96PQhRxvasR3degNE5+Lht6ZRAjK5itgGYfZt3cGzBoGlQdtgpKuRfqY/0l08t7EVfSboac016JqHs0A9Bz+MEXgs=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0121.APCP153.PROD.OUTLOOK.COM (10.170.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Sat, 21 Sep 2019 06:56:05 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%8]) with mapi id 15.20.2305.011; Sat, 21 Sep 2019
 06:56:05 +0000
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
Thread-Index: AQHVbwXQRPtGDntMcU+sv4R8q5dPMac1q4Vg
Date:   Sat, 21 Sep 2019 06:56:04 +0000
Message-ID: <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
In-Reply-To: <20190919161752.GS237523@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-21T06:56:02.6456740Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b53eb3e-4c5d-47b9-a0ce-d9a5b854d83d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:54b9:c9c3:20f2:72c9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 451547b9-7cec-4dca-42b5-08d73e60c5ad
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0121:|PU1P153MB0121:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB012177465E2764334002DAB5BF8B0@PU1P153MB0121.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0167DB5752
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(54534003)(189003)(199004)(66446008)(22452003)(486006)(52536014)(74316002)(66476007)(66556008)(86362001)(305945005)(8990500004)(76116006)(33656002)(5660300002)(7736002)(66946007)(64756008)(6916009)(10090500001)(2351001)(476003)(76176011)(4326008)(6436002)(446003)(2501003)(966005)(7696005)(11346002)(55016002)(25786009)(6306002)(5640700003)(186003)(71190400001)(256004)(229853002)(14454004)(9686003)(14444005)(10290500003)(46003)(316002)(71200400001)(478600001)(54906003)(102836004)(6506007)(1361003)(6246003)(81156014)(107886003)(2906002)(6116002)(99286004)(8936002)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0121;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DULxSz2P3QqQXZ1KwQ4CrN/51JAHFM7ZZ14sfSR5jAc2mccE9fXopZhiLiHyK6F3busyeFXwWNFD97Cx5GVejdY4L2Jyz+1VloLrirLTfw47zl4cQl7SEGFzYOymeanS2QV9oXzooxPJgOMULRv8LJOMadP6lh6x+xf8M0vh4BZ2pDPsjOHzXilFY3W5H3abea32UI/fvfBOOv6Swf0DPicWvgUvSACPMRS770L6EVldgglwzKHPJ6EAjJSQIwHV/LYMK6WlqtYbZc5pZwVzgLWtgrNjxMARzyoZmP+/e49ZjdcBKJZVEWIwlYIK+3l+23xE1TjgRq3hFdwg6chIOvKlQxz0iJwTW5WQgaXxSV45fPSpFfAhxxeLwh2ktKFQXkM1Hn6BpHT2b6/KdDhAH+XS00YYnbYZgImCWCA/zIQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451547b9-7cec-4dca-42b5-08d73e60c5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2019 06:56:04.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkHp83C7cIOtqvAsigtKIVt/Kz1xa6pXR+LWUIaxfjQJuqqGQGPcHE7l6uAsE0qMZEYFbygbOxgIWZV17nd6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0121
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
> Sent: Thursday, September 19, 2019 9:18 AM
>=20
> Hi Dexuan,
>=20
> On Wed, Sep 11, 2019 at 11:36:20PM +0000, Dexuan Cui wrote:
> > We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event()
> call
> > does not prevent the system from entering hibernation: the hibernation
> > is a relatively long process, which can be aborted by the call
> > pm_wakeup_hard_event(), which is invoked upon keyboard events.
> >
> > diff --git a/drivers/input/serio/hyperv-keyboard.c
> b/drivers/input/serio/hyperv-keyboard.c
> > index 88ae7c2..277dc4c 100644
> > --- a/drivers/input/serio/hyperv-keyboard.c
> > +++ b/drivers/input/serio/hyperv-keyboard.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/hyperv.h>
> >  #include <linux/serio.h>
> >  #include <linux/slab.h>
> > +#include <linux/suspend.h>
> >
> >  /*
> >   * Current version 1.0
> > @@ -95,6 +96,9 @@ struct hv_kbd_dev {
> >  	struct completion wait_event;
> >  	spinlock_t lock; /* protects 'started' field */
> >  	bool started;
> > +
> > +	struct notifier_block pm_nb;
> > +	bool hibernation_in_progress;
>=20
> Why do you use notifier block instead of exposing proper PM methods if
> you want to support hibernation?
>=20
> Dmitry

Hi,
In the patch I do implement hv_kbd_suspend() and hv_kbd_resume(), and
add them into the hv_kbd_drv struct:

@@ -416,6 +472,8 @@ static struct  hv_driver hv_kbd_drv =3D {
        .id_table =3D id_table,
        .probe =3D hv_kbd_probe,
        .remove =3D hv_kbd_remove,
+       .suspend =3D hv_kbd_suspend,
+       .resume =3D hv_kbd_resume,

The .suspend and .resume callbacks are inroduced by another patch (which
uses the dev_pm_ops struct):
271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC drivers=
 for hibernation")
(which is on the Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?h=
=3Dhyperv-next&id=3D271b2224d42f88870e6b060924ee374871c131fc )

The only purpose of the notifier is to set the variable=20
kbd_dev->hibernation_in_progress to true during the hibernation process.

As I explained in the changelog, the hibernation is a long process (which
can take 10+ seconds), during which the user may unintentionally touch
the keyboard, causing key up/down events, which are still handled by
hv_kbd_on_receive(), which calls pm_wakeup_hard_event(), which
calls some other functions which increase the global counter
"pm_abort_suspend", and hence pm_wakeup_pending() becomes true.

pm_wakeup_pending() is tested in a lot of places in the suspend
process and eventually an unintentional keystroke (or mouse movement,
when it comes to the Hyper-V mouse driver drivers/hid/hid-hyperv.c)
causes the whole hibernation process to be aborted. Usually this
behavior is not expected by the user, I think.

So, I use the notifier to set the flag variable and with it the driver can
know when it should not call pm_wakeup_hard_event().

Thanks,
-- Dexuan
