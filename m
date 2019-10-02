Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A65C492E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Oct 2019 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfJBIJq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Oct 2019 04:09:46 -0400
Received: from mail-eopbgr1320137.outbound.protection.outlook.com ([40.107.132.137]:30736
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfJBIJq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Oct 2019 04:09:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMrnildEcgRFlJjgowOrvGM5vM413b34K1ldkkVuXMBvhaQAz60lkhxGKGjI0IjReDH/O6gS+BMrI9WzsGl6y71jJaJOSAArzOlgrZH/nkS5luP0l4XIGXuyFlKLiZt1YuA7OMthY8lPWnz+J01TuvuF9HUEO2li9ahdJPUQcFIhJ3PyCx+qKcFbsNFWJFjOg6T0FD5jKHTY0MEnilB7oSK+B0z0vam6Y8bB+IXLiL/en8QRoZ0DtTT/wFzOO9Kn2IiFztpAFxWgST15v8Ano0LNdGvF2UfjSRN34G6kHDVK1j4KMuu+jf1kiUyQGt07Vt74pNiWgZChLN98SsGC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJwVl3WJYnafSgffs3DQz3Z0TI04pDwpTp1DXjtOEMU=;
 b=MPLJ27ClyRT5sAUYnJdBVUoUaV3YdkMpWKRNkn5OpFvgb6s9V1so65InQcLNVJ5SUjSFqMrHOd/NnIBE3Lzyt54qQm9oyjpdF0YBbM1TRgYes/souWHizagelP/6rlugtRQT5kN37SZUMjT4dXuQxHXvrUjOcV44Yqnp84WW2pwHk9aU0XTuWdzIxy4XYNb7idPyvjmzPXM6pX9oYvXtWApHZ1Qxzn+mdvaVKTKr7q2t05ERZEADIcRnVbdA/s+49vifog4QWL0r61UpUiEKRnoXmygXCagdaeU6GB535BCtGyw73tmmyjNLC00dHjPadwjFvvoopu+v44W0uEW4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJwVl3WJYnafSgffs3DQz3Z0TI04pDwpTp1DXjtOEMU=;
 b=RD4k1dukXwNu7p0R/BbsLaUWdYHKvXQq8IBmN/5Cf8Xyi1jg4QBA0i6n5QFfjw8p6eBqF4YPSEU2gbrnnBjCjgIV1FdBsYlRtnBcaF5SHBzhXeCRES+POMgQPTArxfHR0PwQ3j9F+VB9iN70r05GvAqq41s2ZUe4TRi4IQJqJk8=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0105.APCP153.PROD.OUTLOOK.COM (10.170.188.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.5; Wed, 2 Oct 2019 08:09:41 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Wed, 2 Oct 2019
 08:09:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Wei Hu <weh@microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "info@metux.net" <info@metux.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Topic: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVeIjQ21J2EyXx3k2x6FCXKaeI5qdG+8Hg
Date:   Wed, 2 Oct 2019 08:09:41 +0000
Message-ID: <PU1P153MB0169811097EA55DF795888B2BF9C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190918060227.6834-1-weh@microsoft.com>
 <DM5PR21MB0137DA408FE59E8C1171CFFCD78E0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <DM5PR21MB01375E8543451D4550D622CDD7880@DM5PR21MB0137.namprd21.prod.outlook.com>
 <20191001184828.GF8171@sasha-vm>
In-Reply-To: <20191001184828.GF8171@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-02T08:09:39.9301205Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=91d0fc58-9008-4c8a-bfab-da233f5ee236;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:24b0:cdff:a7c5:c70f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74787cce-d125-49d6-55dd-08d7470fe0dc
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0105:|PU1P153MB0105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0105F0A00A1F11A5D842A1BFBF9C0@PU1P153MB0105.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(13464003)(66476007)(76116006)(7736002)(66556008)(5660300002)(54906003)(6246003)(107886003)(229853002)(4326008)(256004)(10290500003)(110136005)(55016002)(1511001)(22452003)(316002)(66446008)(64756008)(9686003)(52536014)(14444005)(478600001)(66946007)(8990500004)(8936002)(8676002)(81166006)(81156014)(10090500001)(446003)(6636002)(6436002)(6116002)(7416002)(11346002)(74316002)(2906002)(476003)(14454004)(6506007)(99286004)(25786009)(102836004)(46003)(76176011)(33656002)(7696005)(186003)(71200400001)(71190400001)(305945005)(486006)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0105;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+EtooMTeXaMqNDi9YllcOTa9sdLXuxoHWfeX0zMnPBUyL4gHJiL1xbwO5Slu46pjX3ZTLzUdriAoAr8PvvW2laWgQdH8bmElXRNk/2mY9INakwWLuh52NbnJA8oW/vKrJHkRLS5kFZUKS8wqMgXasR6IYqNOZI5WaCxVh4C++4AgKITgJ+o4z0HdOdDgGqRegr03Fj1QWGNvPQ7NdCYQfh7nlY/LOt8qs3vEVrRZH42tTgVym4HSWm8/3UmTF78KX6JbUNfh8wN8xAW4pHWtZJ4uAPVSxD674ewJe0HCb7iXzpm1gwjEd0hGymd1pBa/u+4wSIypyjhJZhAGcqGYO0QPMPSMkkNmLVvQzSwPy2oIuq1CY7erlQrd/cISFvl58RPMr+dmqBQ9F8v64efYqTJ+N8s+JP9MtW4ht/hA5Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74787cce-d125-49d6-55dd-08d7470fe0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 08:09:41.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQkI60V2i6Y1/HoDD7fdYEexYnKH33ZuvWsTLFmRKOyUCRAbDmErVpwHKqKLxwNbNotweBwsyXFAxMWxXfhUEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0105
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Tuesday, October 1, 2019 11:48 AM
>=20
> On Fri, Sep 20, 2019 at 05:26:34PM +0000, Michael Kelley wrote:
> >From: Michael Kelley <mikelley@microsoft.com>  Sent: Wednesday,
> September 18, 2019 2:48 PM
> >> >
> >> > Without deferred IO support, hyperv_fb driver informs the host to re=
fresh
> >> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter=
 there
> >> > is screen update or not. This patch supports deferred IO for screens=
 in
> >> > graphics mode and also enables the frame buffer on-demand refresh. T=
he
> >> > highest refresh rate is still set at 20Hz.
> >> >
> >> > Currently Hyper-V only takes a physical address from guest as the st=
arting
> >> > address of frame buffer. This implies the guest must allocate contig=
uous
> >> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs onl=
y
> >> > accept address from MMIO region as frame buffer address. Due to thes=
e
> >> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
> >> > in the guest. This means one more copy of the dirty rectangle inside
> >> > guest when doing the on-demand refresh. This can be optimized in the
> >> > future with help from host. For now the host performance gain from
> deferred
> >> > IO outweighs the shadow copy impact in the guest.
> >> >
> >> > Signed-off-by: Wei Hu <weh@microsoft.com>
> >
> >Sasha -- this patch and one other from Wei Hu for the Hyper-V frame buff=
er
> >driver should be ready.  Both patches affect only the Hyper-V frame buff=
er
> >driver so can go through the Hyper-V tree.  Can you pick these up?  Thx.
>=20
> I can't get this to apply anywhere, what tree is it based on?
>=20
> --
> Thanks,
> Sasha

Hi Sasha,
Today's hyperv/linux.git's hyperv-next branch's top commit is
    48b72a2697d5 ("hv_netvsc: Add the support of hibernation").

Please pick up two patches from Wei Hu:
#1: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution from Hype=
r-V host
#2: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V fr=
ame buffer driver

I can apply the 2 patches on the hyperv-next branch (the top commit is 48b7=
2a2697d5):

[decui@localhost linux]$ patch -p1 < 1.diff
patching file drivers/video/fbdev/hyperv_fb.c
Hunk #2 succeeded at 53 (offset 1 line).
Hunk #3 succeeded at 95 (offset 1 line).
Hunk #4 succeeded at 124 (offset 1 line).
Hunk #5 succeeded at 222 (offset 1 line).
Hunk #6 succeeded at 262 (offset 2 lines).
Hunk #7 succeeded at 394 (offset 2 lines).
Hunk #8 succeeded at 441 (offset 2 lines).
Hunk #9 succeeded at 480 (offset 2 lines).
Hunk #10 succeeded at 558 (offset 2 lines).
Hunk #11 succeeded at 590 (offset 2 lines).
Hunk #12 succeeded at 785 (offset 2 lines).
Hunk #13 succeeded at 823 (offset 2 lines).

[decui@localhost linux]$ patch -p1 < 2.diff
patching file drivers/video/fbdev/Kconfig
Hunk #1 succeeded at 2214 (offset -27 lines).
patching file drivers/video/fbdev/hyperv_fb.c
Hunk #1 succeeded at 238 (offset 1 line).
Hunk #2 succeeded at 259 (offset 2 lines).
Hunk #3 succeeded at 277 (offset 2 lines).
Hunk #4 succeeded at 364 (offset 2 lines).
Hunk #5 succeeded at 692 (offset 2 lines).
Hunk #6 succeeded at 702 (offset 2 lines).
Hunk #7 succeeded at 719 (offset 2 lines).
Hunk #8 succeeded at 801 (offset 2 lines).
Hunk #9 succeeded at 863 (offset 2 lines).
Hunk #10 succeeded at 876 (offset 2 lines).
Hunk #11 succeeded at 889 (offset 2 lines).
Hunk #12 succeeded at 951 (offset 2 lines).
Hunk #13 succeeded at 988 (offset 2 lines).
Hunk #14 succeeded at 1007 (offset 2 lines).
Hunk #15 succeeded at 1041 (offset 2 lines).

Thanks,
-- Dexuan

