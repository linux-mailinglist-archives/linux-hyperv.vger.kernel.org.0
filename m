Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F89FE11
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2019 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfH1JMi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 05:12:38 -0400
Received: from mail-eopbgr1310123.outbound.protection.outlook.com ([40.107.131.123]:1680
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbfH1JMh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 05:12:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQkTe3PhcOVnvrN3XfNyKztTDHh4JuQpYg1CyZsr7jQWufm4yx3sE4V58wZ/u0/rUf1TodDuGoxK78MMmY/A4LwVrxmehi+/clj0qxbEDu7aBIohmoMC0ovri8sfweowCp5kvUl+hDK/VcwEtPvgTt3DmKsbP8RvFO2875DVPL5nuFDc9KyKlEbpcC1UlQM5VJ99J01RtKXfpCIjK99WbsR7zY9faPbtVeVdksTkceM9tcJWbCG0SFv+NZ00xuBgvG79f0idhE47u8FCJ35eX0/e/j37joOZs8xlYbThZY1OF8VEt23i6e/+YgyTl53JMgaKGVgVNgk0Zwht/Ua2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkoVukJyoJ+Behl1JHtmxjroUKALx6RWAo09tW5ko3E=;
 b=E2M6cAE92PdvMxTbvazzRPIeKvFGE89shPLbyYtum6ayM5k0P5C+wFRF9WlcmtoxuvZ8imEE8hVbMNvEIBMd4ChrZXHCOJq1HF0mha4XdpXhTwWlPSVcnyN0nOJdhTqCOnDKW2DqS4SmtMg6wsDy1rIZlJiBbvbqUq+r0fOXvWcYERTaBu3uV0tjM1MrGdM4VAaLo/IQU+Bu+hZOABnKq28S2uO9k5qm8RfHJkHajgnIBpvDow5vx/Iuh3o4+w6tR6PgIDjzDI5noThyb65TaAg9gDQGABDpgYwrrNpt2h0027A36Ij6Jdg2qPjTxS/hJr5NTOcRP0D2ndXp/bN9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkoVukJyoJ+Behl1JHtmxjroUKALx6RWAo09tW5ko3E=;
 b=UqVo5Swiq2fmGbXvk85uZ4VsHGAheV4ooehxHl89XQb63WGhuF6ZzQCI/R//Rqep/7u4eoJtxU9CsUv4sP2hw9jIYmjLt2LsyPUcbMnggYSClmZxL1Bj1kNd2StWVYBbi7UEPdqwYvE+f6bfOG6r9qtDvB7TK/Py9CGqjBSal/I=
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM (52.132.240.17) by
 KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.3; Wed, 28 Aug 2019 09:12:31 +0000
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e]) by KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e%9]) with mapi id 15.20.2241.000; Wed, 28 Aug 2019
 09:12:31 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "info@metux.net" <info@metux.net>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATHC v2] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Topic: [PATHC v2] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVXMoQkghsJmF5GU+6GBoMEWqB8KcPrJWwgACTu4A=
Date:   Wed, 28 Aug 2019 09:12:30 +0000
Message-ID: <KL1P15301MB026463D9F94CE517E7A63216BBA30@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
References: <20190827112421.2770-1-weh@microsoft.com>
 <DM5PR21MB0137969B8EB3146160C86A2DD7A30@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0137969B8EB3146160C86A2DD7A30@DM5PR21MB0137.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-28T00:07:19.1202362Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=87e41fa5-44a0-4c5f-8eea-bba2bafd67f3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.255.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a55a85ca-4de8-4418-e6d4-08d72b97db33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:KL1P15301MB0006;
x-ms-traffictypediagnostic: KL1P15301MB0006:|KL1P15301MB0006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1P15301MB0006D942EF1C5940189987B3BBA30@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(13464003)(189003)(81166006)(81156014)(8676002)(476003)(76116006)(229853002)(2201001)(7736002)(76176011)(26005)(256004)(22452003)(2501003)(14444005)(7696005)(7416002)(66066001)(2906002)(99286004)(1250700005)(186003)(66946007)(8936002)(66476007)(110136005)(64756008)(66556008)(1511001)(66446008)(316002)(33656002)(6246003)(71190400001)(53936002)(6636002)(25786009)(10090500001)(305945005)(5660300002)(52536014)(6506007)(102836004)(3846002)(6116002)(55016002)(9686003)(446003)(11346002)(478600001)(10290500003)(6436002)(486006)(86362001)(71200400001)(74316002)(14454004)(8990500004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0006;H:KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EMGJr0HT1ZjAsHGeY+xTzfgsDBKvoish+//9quWFPXjVJhY/c6RKr3wVcx/CBtG5Q/QyqpFOjaZQaVOtOJZZw7AoF80Blo5NqpHEGAMstCG7CRoqSjP/iXNTRW/N5BPUrL8KEVijNnZnNxHNqLXm8htNFYNJFOui+6VP2jRq6hhiMPTy3RNhFTnvZzMEUffQUKJt+KSkA5020P67pWpB5t2Ez3XezUHe9NECQhEinA7Dgnl2fTqoohTYg5t5HtoKhecLK6+uZNp4hyxEJOC5uOeqd2kFGRN44hmHx4XnDTvP8RGueRTZaEyW+HVYmQtvnGW1dxd0AaCJ67AkZ0vE+DQAeOI4autDDP4ADohezIf5j9chI6oMVw6M4YHptqU5QDYdqBYujzaxSru/lq9BgUmRq2oQf7hOeOYvwsPJEkE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55a85ca-4de8-4418-e6d4-08d72b97db33
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 09:12:30.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTcwVsIBhSYKpv4IoWzcxEm7m1WoYrBwJjA5CxLGYptNMR6T/8Qp/Ztg2rmQE/vGNrvBgvteSSPLcZwt4qzSxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0006
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
>=20
> From: Wei Hu <weh@microsoft.com>  Sent: Tuesday, August 27, 2019 4:25 AM
> >
> > Without deferred IO support, hyperv_fb driver informs the host to refre=
sh
> > the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter th=
ere
> > is screen update or not. This patch supports deferred IO for screens in
> > graphics mode and also enables the frame buffer on-demand refresh. The
> > highest refresh rate is still set at 20Hz.
> >
> > Currently Hyper-V only takes a physical address from guest as the start=
ing
> > address of frame buffer. This implies the guest must allocate contiguou=
s
> > physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> > accept address from MMIO region as frame buffer address. Due to these
> > limitations on Hyper-V host, we keep a shadow copy of frame buffer
> > in the guest. This means one more copy of the dirty rectangle inside
> > guest when doing the on-demand refresh. This can be optimized in the
> > future with help from host. For now the host performance gain from defe=
rred
> > IO outweighs the shadow copy impact in the guest.
> >
> > v2: Incorporated review comments from Michael Kelley
> > - Increased dirty rectangle by one row in deferred IO case when sending
> > to Hyper-V.
> > - Corrected the dirty rectangle size in the text mode.
> > - Added more comments.
> > - Other minor code cleanups.
>=20
> Version history should go after the "---" below so it is not included in
> the commit message.
>=20
[Wei Hu]=20
I saw version history in the commit logs.=20

> >
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >  drivers/video/fbdev/Kconfig     |   1 +
> >  drivers/video/fbdev/hyperv_fb.c | 221 +++++++++++++++++++++++++++++---
> >  2 files changed, 202 insertions(+), 20 deletions(-)
> >
> > +/* Deferred IO callback */
> > +static void synthvid_deferred_io(struct fb_info *p,
> > +				 struct list_head *pagelist)
> > +{
> > +	struct hvfb_par *par =3D p->par;
> > +	struct page *page;
> > +	unsigned long start, end;
> > +	int y1, y2, miny, maxy;
> > +	unsigned long flags;
> > +
> > +	miny =3D INT_MAX;
> > +	maxy =3D 0;
> > +
> > +	/*
> > +	 * Merge dirty pages. It is possible that last page cross
> > +	 * over the end of frame buffer row yres. This is taken care of
> > +	 * in synthvid_update function by clamping the y2
> > +	 * value to yres.
> > +	 */
> > +	list_for_each_entry(page, pagelist, lru) {
> > +		start =3D page->index << PAGE_SHIFT;
> > +		end =3D start + PAGE_SIZE - 1;
> > +		y1 =3D start / p->fix.line_length;
> > +		y2 =3D end / p->fix.line_length;
> > +		if (y2 > p->var.yres)
> > +			y2 =3D p->var.yres;
>=20
> The above test seems contradictory to the comment that
> says the clamping is done in synthvid_update().  Also, since
> the above calculation of y2 is "inclusive", the clamping should
> be done to yres - 1 in order to continue to be inclusive.  Then
> when maxy + 1 is passed to synthvid_update() everything works
> out correctly.
>
[Wei Hu]=20
Actually the original code I sent out just works correctly.  It always get
the inclusive rectangle in the above loop, and only send one more extra
line (if y2 =3D=3D yres) to sythvid_update() and it is clamped inside that=
=20
function. Changing it to yres -1 and sending maxy + 1 to sytnvid_update()
makes it the same as the original code in this case, and would end up=20
always copy and refresh one extra row when y2 < yres.

The comment I added was according to your last review comment asking
to add some comments explaining it. Maybe I mis-understood. I thought
since you wanted me to change to maxy + 1, the code could reach yres + 1
so it will be clamped in synthvid_update() to yres.

 Wei

