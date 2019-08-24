Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB809BF21
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2019 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHXSLU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Aug 2019 14:11:20 -0400
Received: from mail-eopbgr740131.outbound.protection.outlook.com ([40.107.74.131]:3766
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfHXSLT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Aug 2019 14:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfJmDKp1Cdq0RaZBjGx/vDQtArr9gdehRcuR/dQwWkxkHqOeAipiTNoa8cUB4F4uWyuDiVV/zAsMlw8YTNxddlacn/sAI+NZsI9sr0BWEltXMqmbVo3pwyeJlg4ibLbpwiW4Ef47CN/jKW/YV+F8GADNqq9RLK5EptIXTR85Jjn7Allustrvb4MsVrtQFzbTFIY3nFjXhYAx2O+XwfIXk+ROJWg+W2tElZKcl2RWVwsfpK8qAFxAqv9lBmcyI44fPNwuCbyGrYnOwPH9VmxG6q4VmSM4zDli+8bBWu0mxGudEx/yEAv/MLXshv/wBcqL4Hqk5BG1U6/22dgiHxZxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alpZXgu7ozOn+phu3TSVu2Ll1QISFKtN6xt/3m6PJIE=;
 b=WtS4ZcLH59u7rBEUClydom+kBaq3POInJpmSeB0I2qgeamJUCSsRo1pfQA1UCa3YosQ3Fc8lqsOTPrzOGQFhe4yWQZPDy6LK69KQz7hb1X91vLCMcwOzLdGoug6qnI/hoUWhbPpvfYUTaT5Kk2CX61VMJfAhVNAgGSIpz/xlUcD8zqxTuXMOSx3KhnGzusmJR81WgYVt9mCdsWfJfK/6+UzU/qsshfkmRa5upl0b4Ws76X1+9pKIYYjMikRwD1SYKFsmhCvMBteEedPRH6uM/Kozqfg84okx6Jfh2PmN78r2xOW4gyEL2f6WxTWMYGR5TtmigRjIH1xPsenUABi/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alpZXgu7ozOn+phu3TSVu2Ll1QISFKtN6xt/3m6PJIE=;
 b=H51/6P0afnqEiSXYsvoQFvf8IIDLxWVDBp5xQl04eRtlhpqgOOpu3xvCI5JN9/74jZHk13Ltxb00U9pInG1XcUZg0/vgIJOCGJcMH8/pwbaRon375nqFF9wHNi3YoUAg7jXrZPKwdS+u9CGnpOZGZY8Iu85R12+c1uxQb5s+w+k=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0474.namprd21.prod.outlook.com (10.172.92.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.11; Sat, 24 Aug 2019 18:11:11 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Sat, 24 Aug 2019
 18:11:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
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
        Dexuan Cui <decui@microsoft.com>,
        Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V
 frame buffer driver
Thread-Topic: [PATCH] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVUcL5xwYcgiTbLE2rph4+nLCFt6cBbYBAgAQTWPCAANHp8A==
Date:   Sat, 24 Aug 2019 18:11:11 +0000
Message-ID: <DM5PR21MB0137A956360B52118AF164EAD7A70@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190813103548.2008-1-weh@microsoft.com>
 <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
 <KL1P15301MB026487D86E439FA67B25C42CBBAA0@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB026487D86E439FA67B25C42CBBAA0@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-18T22:41:11.4651147Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ccd13015-0c82-412f-bb9a-41c31ca9a93d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92b13908-6c21-4d89-e323-08d728be71cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0474;
x-ms-traffictypediagnostic: DM5PR21MB0474:|DM5PR21MB0474:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0474386DFC74DDFB6DA6C6EBD7A70@DM5PR21MB0474.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(2501003)(229853002)(6436002)(10090500001)(66476007)(66946007)(6636002)(9686003)(25786009)(7416002)(1511001)(53936002)(66556008)(110136005)(1250700005)(14444005)(256004)(2906002)(6246003)(66066001)(2201001)(26005)(33656002)(8676002)(81156014)(81166006)(14454004)(99286004)(446003)(71200400001)(305945005)(6506007)(71190400001)(53546011)(76116006)(10290500003)(478600001)(186003)(102836004)(74316002)(316002)(3846002)(6116002)(8990500004)(22452003)(5660300002)(486006)(55016002)(7696005)(8936002)(76176011)(52536014)(86362001)(7736002)(66446008)(64756008)(11346002)(476003)(241875001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0474;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j4Jttv1kMqtSRFglfvLXoVf1SrWZ1pZKu7jpWWiUQJ14mpjzCFT9ECrLjRxslEcBXrQTJn+bFTXGkSgSY9a88XfT+wNkLAv4AulzUC3/EprKbtYmnruykXrftd92LPDp3SUSoV09vVa0fcSLpN5MQ5QvvLcI5Oytxw5vuTt0eb0B0SwLm0Rf1ZY8Yxrv71HBJ9IdNaKF4tnXyxW0zhbzc7l0wgeAaDWP0td3MNOgYRoRwe+MB5vy4BZG5h7xLjhvsZNLzRe6BTRFUeWfuPqMsFlY/NGxR25yb1/IPamJGANIySfNRNYuEJHHXiZxS09hBNI7CpxezHvgHBEYbv6O4v/jGsopQDylDQZ2yvCocGVRZ+WIHa4CkKo3z+Q9iMb6Jnz8nd0ZbU/ejUMAtbeUF6huuxDqU7fF2A+ayBemldE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b13908-6c21-4d89-e323-08d728be71cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 18:11:11.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pyrJzQICRPQ35A7lIupr9P0YbDFlSXAzm9GchwsuITqr+n89cZYlFYQMs0z/LTaflm/2X7zbp8rtsgYGAsQ/0IDeFv+1EUKaYwgWsoKBhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0474
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Wednesday, August 21, 2019 4:59 AM
>
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Monday, August 19, 2019 6:41 AM
> > To: Wei Hu <weh@microsoft.com>; rdunlap@infradead.org; shc_work@mail.ru=
;
>=20
> > > -	msg.dirt.rect[0].x1 =3D 0;
> > > -	msg.dirt.rect[0].y1 =3D 0;
> > > -	msg.dirt.rect[0].x2 =3D info->var.xres;
> > > -	msg.dirt.rect[0].y2 =3D info->var.yres;
> > > +	msg.dirt.rect[0].x1 =3D (x1 < 0 || x1 > x2) ? 0 : x1;
> > > +	msg.dirt.rect[0].y1 =3D (y2 < 0 || y1 > y2) ? 0 : y1;
> >
> > This should be:
> >
> > 	msg.dirt.rect[0].y1 =3D (y1 < 0 || y1 > y2) ? 0 : y1;
> >
> > Also, throughout the code, I don't think there are any places where
> > x or y coordinate values are ever negative.  INT_MAX or 0 is used as th=
e
> > sentinel value indicating "not set".  So can all the tests for less tha=
n 0
> > now be eliminated, both in this function and in other functions?
> >
> > > +	msg.dirt.rect[0].x2 =3D
> > > +		(x2 < x1 || x2 > info->var.xres) ? info->var.xres : x2;
> > > +	msg.dirt.rect[0].y2 =3D
> > > +		(y2 < y1 || y2 > info->var.yres) ? info->var.yres : y2;
> >
> > How exactly is the dirty rectangle specified to Hyper-V?  Suppose the f=
rame
> > buffer resolution is 100x200.  If you want to specify the entire rectan=
gle, the
> > first coordinate is (0, 0).  But what is the second coordinate?  Should=
 it be
> > (99, 199) or (100, 200)?  The above code (and original code) implies it
> > should specified as (100, 200), which is actually a point outside the
> > maximum resolution, which is counter-intuitive and makes me wonder
> > if the code is correct.
> >
> [Wei Hu]
> The current code treat the entire framebuffer rectangle as (0,0) -> (var.=
xres, var.yres).
> Every time it sends refresh request, these are two points sent to host an=
d host
> seems accept it. See the above (x1, y1) and (x2, y2)  in the deleted line=
s.
>=20
> So in your example the second coordinate is (100, 200).

OK, agreed.  I ran some experiments and confirmed that this is indeed the
Hyper-V behavior.

>=20
>=20
> > > +/* Deferred IO callback */
> > > +static void synthvid_deferred_io(struct fb_info *p,
> > > +				 struct list_head *pagelist)
> > > +{
> > > +	struct hvfb_par *par =3D p->par;
> > > +	struct page *page;
> > > +	unsigned long start, end;
> > > +	int y1, y2, miny, maxy;
> > > +	unsigned long flags;
> > > +
> > > +	miny =3D INT_MAX;
> > > +	maxy =3D 0;
> > > +
> > > +	list_for_each_entry(page, pagelist, lru) {
> > > +		start =3D page->index << PAGE_SHIFT;
> > > +		end =3D start + PAGE_SIZE - 1;
> > > +		y1 =3D start / p->fix.line_length;
> > > +		y2 =3D end / p->fix.line_length;
> >
> > The above division rounds down because any remainder is discarded.  I
> > wondered whether rounding down is correct, which got me to thinking
> > about how the dirty rectangle is specified.  Is y2 the index of the las=
t
> > dirty row?  If so, that's not consistent with the code in synthvid_upda=
te(),
> > which might choose var.yres as y2, and that's the index of a row outsid=
e
> > of the frame buffer.
> >
> [Wei Hu]
> In this place we try to figure out and merge all the faulted pages into o=
ne
> big dirty rectangle. A page in memory represents one or multiple lines in
> frame buffer. For example, one faulted page could represent all the linea=
r
> pixels from (x, y) to (x-1, y+1). In this case we just form the dirty rec=
tangle
> as (0, y) -> (var.xres, y+1). Also keep in mind we need to merge multiple
> pages. That's why in the end the dirty rectangle is (0, miny) -> (var.xre=
s, maxy).

Let me give an example of where I think the new code doesn't work.  Suppose
the frame buffer resolution is 1024x768.  With 4 bytes per pixel, each row
is 4096 bytes, or exactly one page.  So each page contains exactly one row =
of
pixels. For simplicity in my example, let's look at the case when this func=
tion
is called with only one dirty page.   The calculation of y1 will identify t=
he row
that is dirty.   The calculation of y2 will identify the same row.  So y1 w=
ill
equal y2, and miny will equal maxy.  Then when synthvid_update() is called,
Hyper-V will interpret the parameters as no rows needing to be updated.  In
a more complex case where the pagelist contains multiple dirty pages, maxy
also ends up one less than it needs to be.

I think passing 'maxy + 1' instead of 'maxy' to synthvid_update() will solv=
e
the problem.  It certainly warrants a comment that the calculation of maxy
is "inclusive", while synthvid_update() expects its parameters to be "exclu=
sive"
per Hyper-V's expectations.

There's also another interesting situation.  Suppose the resolution and pag=
e size
is such that a page contains multiple rows.  If the last page of the frame =
buffer
is dirty, this routine could calculate a y2 value identifying a "phantom" r=
ow
that is off the end of the frame buffer -- i.e., that is bigger than yres. =
 You
have synthvid_send() handling that case by clamping the y2 value to yres, b=
ut
it might be worth a comment here acknowledging the situation and how it is
handled.  I did a test, and it appears that Hyper-V does its own clamping o=
f
the values passed in, but we should not take a dependency on how Hyper-V
handles incorrect inputs.

>=20
>=20
> > > +		if (y2 > p->var.yres)
> > > +			y2 =3D p->var.yres;
> > > +		miny =3D min_t(int, miny, y1);
> > > +		maxy =3D max_t(int, maxy, y2);
> > > +
> > > +		/* Copy from dio space to mmio address */
> > > +		if (par->fb_ready) {
> > > +			spin_lock_irqsave(&par->docopy_lock, flags);
> > > +			hvfb_docopy(par, start, PAGE_SIZE);
> > > +			spin_unlock_irqrestore(&par->docopy_lock, flags);
> > > +		}
> > > +	}
> > > +
> > > +	if (par->fb_ready)
> > > +		synthvid_update(p, 0, miny, p->var.xres, maxy);
> > > +}
>=20
>=20
>=20
>=20
> > > +
> > > +	/* Copy the dirty rectangle to frame buffer memory */
> > > +	spin_lock_irqsave(&par->docopy_lock, flags);
> > > +	for (j =3D y1; j <=3D y2 && x1 < x2; j++) {
> > > +		if (j =3D=3D info->var.yres)
> > > +			break;
> > > +		hvfb_docopy(par,
> > > +			    j * info->fix.line_length +
> > > +			    (x1 * screen_depth / 8),
> > > +			    (x2 - x1 + 1) * screen_depth / 8);
> >
> > Whether the +1 is needed above gets back to the question I
> > raised earlier about how to interpret the coordinates -- whether
> > the (x2, y2) coordinate is just outside the dirty rectangle or
> > just inside the dirty rectangle.  Most of the code seems to treat
> > it as being just outside the dirty rectangle, in which case the +1
> > should not be used.
> >
> [Wei Hu]
> This dirty rectangle is not from page fault, but rather from frame buffer
> framework when the screen is in text mode. I am not 100% sure if the dirt=
y
> rectangle given from kernel includes on extra line outside or not.  Here =
I
> just play it safe by copying one extra line in the worst case.

Got it.  I was incorrectly conflating the two ways the frame buffer can get
updated.

I looked at the how x2 and y2 of the dirty rectangle get set in this case. =
 It
looks to me like it's always calculated as x1 + width, and y1 + height in
hvfb_ondemand_refresh_throttle().  If that's correct, then the dirty
rectangle coordinates are "exclusive", which is what Hyper-V wants.   And
indeed the call to synthvid_update() later in this function assumes the
"exclusive" format.  Also, the "j =3D=3D info->var.yres" test is correct on=
ly
if the y2 value is in the "exclusive" format.

With that being the case, the "for" loop control above should have j < y2
instead of j <=3D y2, as we don't need to copy the y2 row.  And the +1
isn't needed in the arguments to hvfb_docopy().

I really don't like the idea of copying an extra row, or an extra byte in a
row, "just in case".

Michael

>=20
> Suppose dirty rectangle only contain one pixel, for example (0,0) is the =
only
> pixel changed in the entire frame buffer. If kernel sends me dirty rectan=
gle as
> (0, 0) -> (0, 0), the above function works correctly. If the kernel sends
>  (0, 0) -> (1, 1), then the above function just copies one extra row and =
one extra
> column, which should also be fine. The hvfb_docopy() takes care of the
> edge cases.
>=20
> Thanks,
> Wei
