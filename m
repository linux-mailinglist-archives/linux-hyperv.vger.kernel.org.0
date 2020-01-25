Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18BB1492D8
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2020 02:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbgAYB7J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Jan 2020 20:59:09 -0500
Received: from mail-eopbgr1310129.outbound.protection.outlook.com ([40.107.131.129]:39616
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387608AbgAYB7J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Jan 2020 20:59:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRsdIEE8EL5MqyeVPtfPcaU2/lJTasB139n6SZS6YO47i4RnyxtuFWdJvakQexAcpD8thqI/XfSNuMlLmbUqo8nt06V4kjEmxEDwIwyrQb+QZLLQkDYfVJ8jx7ZJz1m0ezgfcXc89xFzSDUqzmL5rlJ7I4FGc1zyCIfQAycFAMjWTC9arsmOCfNvbEKNbOAGy5XsxMB8KXR6aT1wrfJmTitb4olMnAqORBH0oj5mFw6ggdjq1y6xMutf+jZom1oq+BvyH0qJ0a34w18WeijbfkVYEV/bBpj6wEzkqkeAjcOAnOrkHB3mTITswLVf+mk5wp939dg6fY5SP4qyX0ql6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSCy2Uy7Ii9m+DanAQQSHGc3Enl/XkXaR8uF/aocOrM=;
 b=Cc6rJXAjNrn9AJaetMSslo4479SfN11qFipGQiXMw92k5YUFsx4MLCiDwwYRHRIWbPSFrZkS3v6ve3PsU9CUd+KLW6ZpoYkuRKsP/9Q6cVDy9mnryhqlQdysRkuphCpwT9fGZEz1M+5xT3xVe9FYKD1has2oPujf/OTczqmmo40BJVgu6evbuiqSbm0NvKgfaOd4BoXH8qEnl8w7BvyC/5Qek3OA+4JybtpGy0VU5Jq4c2RLSS8qiQtLEtXE5KOSInoO+roswxOdbDddiWwnLE1UcBeG0qvLYJRxkHnMlsN48lvuBDBIkmwV618wx+y4RoQ6/PT9C++Wa+3J6Ma05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSCy2Uy7Ii9m+DanAQQSHGc3Enl/XkXaR8uF/aocOrM=;
 b=E4YCedBnh/O8lBkDj08/s/tYdAbOw+z9n1vCdtrocYTnFbXGhHuZleNfLL359qMM/2ETZEzrKS16yp53ysieQ+VNzmUjzvykqaFYE1oR3dsmiqzbvzoRcSdgAt/W+C+0+XoujuJdfIh33rOTwaKrRAxyERq3TAS4t6TiUdSSEiY=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.0; Sat, 25 Jan 2020 01:59:03 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2707.000; Sat, 25 Jan 2020
 01:59:03 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of
 hibernation
Thread-Topic: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of
 hibernation
Thread-Index: AQHVyJv2n9lkqyt02Uq48kiJZ1WZDqfsKE6wgA6IxeA=
Date:   Sat, 25 Jan 2020 01:59:03 +0000
Message-ID: <HK0P153MB01489C2ABCFF40822EC8B695BF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <1578350444-129991-1-git-send-email-decui@microsoft.com>
 <20200111162657.GJ1706@sasha-vm>
 <KU1P153MB01505A56BACA9DA4AF0E7BABBF370@KU1P153MB0150.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB01505A56BACA9DA4AF0E7BABBF370@KU1P153MB0150.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-15T19:52:59.5901958Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9ed1895c-1d7e-4989-a476-4e14ba31c7e4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:20cd:da83:19e9:3198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb80d8f2-2873-469a-4124-08d7a13a2769
x-ms-traffictypediagnostic: HK0P153MB0148:|HK0P153MB0148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB01486026F3A5EBD36440E9C6BF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(33656002)(4326008)(110136005)(81156014)(186003)(966005)(7696005)(478600001)(10290500003)(81166006)(9686003)(52536014)(316002)(107886003)(76116006)(8676002)(64756008)(66556008)(8990500004)(66946007)(66476007)(8936002)(6506007)(66446008)(86362001)(71200400001)(5660300002)(2906002)(54906003)(55016002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0148;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtJ6qFmbbWbqKqKfVBytn6wgjGOCfMbsOoTzo7GL6cOkAhYCkd4wvVkE3i7H/dFEkhLm1I0ZUYiFiN+8cutGa6BF8P4O7mFOOap71thTlOlQFS7Y509d3dY6QYFOEN66LazPPd/uxCNeNPiM2C7I1lXTd5U1VzsmrAzVB1h1h4AyVAKAl82SDtNtRGw1QxwBYiBuSlHFMlf0E0gUZTDjApQ6ORW7pyMDT41cDMQMskyMkUzuUWf6BQ7Qu1K6bRozvyCQxpDQEfYx/cBo2JLSA1S0FXf3Nx2yh+tbbewss81JPsJBLvQBQBBxq/Xft5tzhHWXVi451gcWS5IkonlNMO0h20nmHpahNnh3m9tZC0nfEbWZ//ub4oQqSD9BbfIuPmyBy7wIZTs+i3AvIEyFw6qdBJu27Y9xbzMYl6114fsFteXLeJ4euy0cHQUZCsISA1coar7VzzUk/0DkA3Agn6L+JcOj8h663StF9J3gwnTvz0JD7UyZEbMNZjLAwHVBMbiddJT+MdsYSUvihNcA80j93Q0ld1e7CHwocthjhbpR2CaTicIexav0ZTy50KsF
x-ms-exchange-antispam-messagedata: c2EtfjDMF43vF+T+qXPmOtmAK1BA5yaUGBqX/lAj2BB/uTvRWurVwsAETOzZ4CUh/m4p77nT0PNWcvg9AefpBi1LPBslZ087oKztaGMuA3YcgGL5TmKCoMRRvbt5RQwBKhcL+MKJHTXajg1DhnBF0yd8neMsjhGDMMcTjllYGNCYj5NGcmCGaGV9PVwZ9jRf6C/TPsXmfbLn6b1o7lG49w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb80d8f2-2873-469a-4124-08d7a13a2769
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 01:59:03.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBqSGcC/g/ODW0OSZ5AY4epkNEseU1OqXSPTCEQwS0bWmGH0sabKK+17bvywCPjskzCidW1/QeUTzCXtd1u3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0148
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Dexuan Cui
> Sent: Wednesday, January 15, 2020 11:53 AM
> > ...
> > On Mon, Jan 06, 2020 at 02:40:44PM -0800, Dexuan Cui wrote:
> > >Add suspend() and resume() functions so the Hyper-V virtual keyboard
> > >can participate in VM hibernation.
> > >
> > >Note that the keyboard is a "wakeup" device that could abort an in-pro=
gress
> > >hibernation if there is keyboard event.  No attempt is made to suppres=
s
> > this
> > >behavior.  If desired, a sysadmin can disable the keyboard as a wakeup
> > device
> > >using standard mechanisms such as:
> > >
> > >echo disabled >
> > /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
> > >(where XXX is the device's GUID)
> > >
> > >Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
> > >Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > >---
> > >
> > >This is a RESEND of https://lkml.org/lkml/2019/11/24/115 .
> >
> > >Please review.
> > >
> > >If it looks good, Sasha Levin, can you please pick it up via the
> > >hyperv/linux.git tree, as you did last time for this driver?
> >
> > This will need an ack from the input driver maintainers, unless they
> > want to give a blanket ack to this type of patches.
> >
> > Thanks,
> > Sasha
>=20
> Hi Dmitry,
> May I have your Acked-by for this patch?
>=20
> Thanks
> -- Dexuan

It looks Dmitry may be on leave and there is no ACK from any input driver
maintainers. :-(

Sasha, for this patch, I would suggest it may as well go directly through t=
he
Hyper-V tree because
1. It's really small and it's a pure Hyper-V change.
2. This is for a new functionality and it can not break any existing code.
3. I'm pretty sure it can not cause any merge conflict or build failure.

It's still wonderful to get an Ack or some comment from the input driver
maintainer(s), so maybe let's wait more time (e.g. a week?) and then I
suggust we proceed.

Thanks,
-- Dexuan
