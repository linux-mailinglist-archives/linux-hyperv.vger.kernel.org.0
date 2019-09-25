Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2378ABE5E0
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2019 21:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfIYTtq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 15:49:46 -0400
Received: from mail-eopbgr1300113.outbound.protection.outlook.com ([40.107.130.113]:59860
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728074AbfIYTtq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 15:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA181yZylugyOlj6EuHfv6g8K4QfIWTJMHGcumaI5WP4aFmTmq+hePnarymDSFU912iGE68N41f8IpegZVVQVlnQqrE1c0c2QlRiiZqbeTQjQHu+Wd5sTx4Mr0CNp/f1QKvXkqRgdEJU6jyL7mpTUwI7N1jCMChDpqTs6qtAwBCa/wWpDAyP7AD+kla2ag8bibqOr0tEp6yG47qq2idZx6xaCLkq7W6BkWmsT+jiskz3QGAcFwDmaOOnWYXbGGT3kzyo/3BaSiNSf/jOlZPrQidR2V32pM63ra0J2YufU7M7lPdhVV51hR8s3PDntnGVCaiIzR3/l4NRM/J6AhbFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bfskzjJLR15mRWsaz/k8Oftg6hIZR+y3dvCVwvkIYA=;
 b=iBUNIp1J22Hy0kT/iigjvBtbgGowVWWUCDXQwsXwfcc6oRPhR2S1U3gsCPY9/r5AHGoDGrG0b+g/LU8r0GR/Ofdh+UTMMG5WYDE3oa5J8GErRcye0CpNx04tv3BFjuEJUNXMp8McLCZ6WiQIEGXI8z3JSt5lWK+ICr03JrjpQ/1mzWuJoqh0zjHD3lDZrIFD1zKBkwpkBvSYwlIDQhg3CmLGEoqDcxex9wrzLFYxTRAAIpUf0Vwiu/9yFovISxe54iXkdr1lSwyEdowPbKGpjIB5Om+WhnFdQasqN25GSl+Yu6HG9d8BVSnneEwi32Ht7Ts+NHPiGM3nFiP6ud6vEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bfskzjJLR15mRWsaz/k8Oftg6hIZR+y3dvCVwvkIYA=;
 b=HqgulWK3EazpKWY2lFl36pNYKcrEBmrGizgfp8FUtqrGFYVWtd4Xs3+P8sX9PyYAXSCEHoMOPt2XOCGrZNMtcdXkgt52lAP4l8V1bvjoZHoehHmw1L7d2YfRK5yN72rnML+gFKJtxJx9+OWiCOfDFflOxREiVGwgTjagfmN4uz4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0171.APCP153.PROD.OUTLOOK.COM (10.170.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.6; Wed, 25 Sep 2019 19:49:40 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 19:49:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
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
Thread-Index: AQHVbwXQRPtGDntMcU+sv4R8q5dPMac1q4VggAcpuMA=
Date:   Wed, 25 Sep 2019 19:49:40 +0000
Message-ID: <PU1P153MB01698478F34A45271B11D1CCBF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
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
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57c78eac-a195-433e-41f6-08d741f1816a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0171:|PU1P153MB0171:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB0171FB5DBA6047615A3A651BBF870@PU1P153MB0171.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(54534003)(6116002)(102836004)(14454004)(966005)(478600001)(54906003)(110136005)(10290500003)(486006)(10090500001)(52536014)(476003)(316002)(86362001)(8990500004)(446003)(66476007)(66446008)(11346002)(81166006)(81156014)(1511001)(8676002)(22452003)(66946007)(76116006)(8936002)(66556008)(64756008)(71200400001)(2906002)(107886003)(99286004)(9686003)(2501003)(14444005)(6506007)(7696005)(53546011)(76176011)(256004)(6246003)(7736002)(46003)(55016002)(25786009)(6436002)(5660300002)(4326008)(305945005)(71190400001)(6306002)(186003)(74316002)(229853002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0171;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oRmrNcDkEPjgc/K2Fu/AKaPQbLg2pVYE8yMohZr+Z7WCa1MpuDlsOI4PWQeTS5OIfbfnoV0PWzIp5mdaZbjuvUoqgj4980pvqbgWj44JzqwMWT1n8OdjnZd64EfqtrU/Z04xCU29nWVrGowXl0D26U0OuxS4yKS2T0JgrhIoeK/lH5ZImTXf0We2ewy58+aepNDxStg/TFqnOpB6XMPNHAum05f43DeRz9ewGIKfDQ/eN2idF4cKJvfPSFDl+uanlG+aywE1JiYOE93VY9Hz9x5/3mCmLnQ3m1XyogFE5QR44apTgS58NGehRzg+SAixCfwZ+mMC8qcCtn5GyaXGYsMMbf6uLolpY0/ho0C2xv2MPSLomh5qg7NT27U5STbNFwpI3ldBD1LYh/Vzi7HHB6TNlmqXbY7JNzCNnefy10hcry4fK1wr2xl3XhPxM7zSGYRSDzoYvuqSpUpW/R3zRw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c78eac-a195-433e-41f6-08d741f1816a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:49:40.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNdj5679NIsIrreTuJneaQYQ6u30KRTy5JuqqD7t0H/3nL57NLG4ZClwjWl4KozfVxuTbigXsoGMf5G3zLYaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0171
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
> Sent: Friday, September 20, 2019 11:56 PM
> To: dmitry.torokhov@gmail.com
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; sashal@kernel.org;
> linux-hyperv@vger.kernel.org; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>
> Subject: RE: [PATCH] Input: hyperv-keyboard: Add the support of hibernati=
on
>=20
> > From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
> > Sent: Thursday, September 19, 2019 9:18 AM
> >
> > Hi Dexuan,
> >
> > On Wed, Sep 11, 2019 at 11:36:20PM +0000, Dexuan Cui wrote:
> > > We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event()
> > call
> > > does not prevent the system from entering hibernation: the hibernatio=
n
> > > is a relatively long process, which can be aborted by the call
> > > pm_wakeup_hard_event(), which is invoked upon keyboard events.
> > >
> > > diff --git a/drivers/input/serio/hyperv-keyboard.c
> > b/drivers/input/serio/hyperv-keyboard.c
> > > index 88ae7c2..277dc4c 100644
> > > --- a/drivers/input/serio/hyperv-keyboard.c
> > > +++ b/drivers/input/serio/hyperv-keyboard.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/hyperv.h>
> > >  #include <linux/serio.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/suspend.h>
> > >
> > >  /*
> > >   * Current version 1.0
> > > @@ -95,6 +96,9 @@ struct hv_kbd_dev {
> > >  	struct completion wait_event;
> > >  	spinlock_t lock; /* protects 'started' field */
> > >  	bool started;
> > > +
> > > +	struct notifier_block pm_nb;
> > > +	bool hibernation_in_progress;
> >
> > Why do you use notifier block instead of exposing proper PM methods if
> > you want to support hibernation?
> >
> > Dmitry
>=20
> Hi,
> In the patch I do implement hv_kbd_suspend() and hv_kbd_resume(), and
> add them into the hv_kbd_drv struct:
>=20
> @@ -416,6 +472,8 @@ static struct  hv_driver hv_kbd_drv =3D {
>         .id_table =3D id_table,
>         .probe =3D hv_kbd_probe,
>         .remove =3D hv_kbd_remove,
> +       .suspend =3D hv_kbd_suspend,
> +       .resume =3D hv_kbd_resume,
>=20
> The .suspend and .resume callbacks are inroduced by another patch (which
> uses the dev_pm_ops struct):
> 271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC
> drivers for hibernation")
> (which is on the Hyper-V tree's hyperv-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?=
h=3Dhyperv-next&id=3D271b2224d42f88870e6b060924ee374871c131fc
> )
>=20
> The only purpose of the notifier is to set the variable
> kbd_dev->hibernation_in_progress to true during the hibernation process.
>=20
> As I explained in the changelog, the hibernation is a long process (which
> can take 10+ seconds), during which the user may unintentionally touch
> the keyboard, causing key up/down events, which are still handled by
> hv_kbd_on_receive(), which calls pm_wakeup_hard_event(), which
> calls some other functions which increase the global counter
> "pm_abort_suspend", and hence pm_wakeup_pending() becomes true.
>=20
> pm_wakeup_pending() is tested in a lot of places in the suspend
> process and eventually an unintentional keystroke (or mouse movement,
> when it comes to the Hyper-V mouse driver drivers/hid/hid-hyperv.c)
> causes the whole hibernation process to be aborted. Usually this
> behavior is not expected by the user, I think.
>=20
> So, I use the notifier to set the flag variable and with it the driver ca=
n
> know when it should not call pm_wakeup_hard_event().
>=20
> -- Dexuan

Hi Dmitry,
Does my answer make sense? If yes, can I have an Acked-by from you?

Thanks,
-- Dexuan
