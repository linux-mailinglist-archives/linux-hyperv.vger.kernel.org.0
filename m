Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60437978B4
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfHUL71 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 07:59:27 -0400
Received: from mail-eopbgr1300103.outbound.protection.outlook.com ([40.107.130.103]:21422
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfHUL70 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 07:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcbQLRXhUhHYmsNavmspj0qGsQOFs3PfMP6ny9rKqSMc0FyQRYtH26AmS4nfV6mYGvsU7anYRdnHAAIOaJ6+QV2i7VCkqYG3IOWBvpf3tmjc70hnAgkVTK7POdMApLY+45S5LmUESbQvwTfnafeHnLAOBfvsZrPa8zC1DCDBLM39hv/P51F7MNcg+xMfG+C0OebE/gbnK9uKa2zylYfJNIemkJh7un9RLkORQXJ/FQ1FTYWivNzWFlCNdLXhxeCfKll5EKLpef82VFdsG/g802Fygn6iIOVxO/Zkb/Sw9rUIYubhJTTX26zVqRsq86/qQPrLBbWJ4JXgCQ263GmqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEL/B5T9Yj9wDNOmaX9FT8+AevNZ785C9cgfOJceSYM=;
 b=XnkTQbu9aRaODhLwTMCqwO8OoERvO7RZkVVuER+OsTx8TEMdkgBIM/BuX6MnYyZCYmhKZ6Br6VJp6T1cT9Yo7WotmxkSSvllmEzSZnu6JQJpF+76tpQWNXpNbIBGSTuDUJZemPIq0bDpxzduSJvTlQQ8rnCnWAvfsIjH2A5SO1KS50smau7IGmD7BqIhQn9VeLZHKOo0ITz/wScQ0B1yeCAeg7sgdnU1twtg1lKNXnFbhenW0CkGRRw+oDE++8aiwstgYrfw4gUnwDXCY32byMcMrPbGuK2IMEr1gcmJO+K3dB8WZaEUeRDaIVvZ/qKeY9wRQzjXKTG4MelO6LHVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEL/B5T9Yj9wDNOmaX9FT8+AevNZ785C9cgfOJceSYM=;
 b=d1CR/CaKVt0lr+Xq/woGPfBw4kEOoZyiRV7o22cihKzci2oF3mBdiTVba9KTW+TE0lk58myuLOX519wqq8Hxc71B3pzRc+otDsSNq5AWUJ1rthrLNS73B26uRSPDaLKUvz5JDky6Dnp2hkZQAiBqsD6pa4XFndjbCH+qglOI2HA=
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM (52.132.240.17) by
 KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM (52.132.242.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Wed, 21 Aug 2019 11:59:19 +0000
Received: from KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e]) by KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM
 ([fe80::c402:2ce2:cafa:8b1e%8]) with mapi id 15.20.2220.000; Wed, 21 Aug 2019
 11:59:19 +0000
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
        Dexuan Cui <decui@microsoft.com>,
        Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V
 frame buffer driver
Thread-Topic: [PATCH] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVUcL5xwYcgiTbLE2rph4+nLCFt6cBbYBAgAQTWPA=
Date:   Wed, 21 Aug 2019 11:59:18 +0000
Message-ID: <KL1P15301MB026487D86E439FA67B25C42CBBAA0@KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM>
References: <20190813103548.2008-1-weh@microsoft.com>
 <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
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
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.255.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d91bb9a-d139-481a-737b-08d7262eff75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:KL1P15301MB0343;
x-ms-traffictypediagnostic: KL1P15301MB0343:|KL1P15301MB0343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1P15301MB0343FAC996A3DBA52B81518DBBAA0@KL1P15301MB0343.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(13464003)(199004)(189003)(6436002)(8990500004)(102836004)(7416002)(66476007)(11346002)(8676002)(53546011)(9686003)(55016002)(10290500003)(33656002)(2501003)(66446008)(76116006)(64756008)(81166006)(81156014)(74316002)(71200400001)(1250700005)(66946007)(25786009)(86362001)(71190400001)(66556008)(305945005)(2201001)(7736002)(5660300002)(14444005)(256004)(486006)(66066001)(110136005)(6246003)(53936002)(476003)(446003)(14454004)(99286004)(26005)(8936002)(22452003)(186003)(316002)(2906002)(52536014)(76176011)(3846002)(6116002)(7696005)(229853002)(6636002)(478600001)(6506007)(10090500001)(1511001)(241875001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0343;H:KL1P15301MB0264.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: raHwhlIaoGzzFSiic1z47czlX67l2UC31Hy3Ia7gsHrfFbpUqrtPMcK6K64JIJAimYK439gZxhjvGbU23GUGgQiOlVEol0hxxzzFF5sfW3q0qAXDkaghpowCcjjaoCulLt/R1IhaJklNwbNbjRAnRVNV8aSlviAMu/WKsAg40nVtiEAkpIJxenoXhjApvEl+tY9z5SjRBzFH6BHl2ddVVtthfizS7dOv+2/jPUAbi8a7M0Sqwp1tJ+RbiRdRnmsHPZOWhh6pJbtvkNUeVZ34JadSV29RTLMhp1ZqC/5uiMp6+Q1UitoZnlwRsiwbNaN76IIEHWlgY7CH8OO/XNxB8S/7/QvsqnEpqGVvdnaFU4UbemaXjI5gyE47WaS1OfAHK2XH7eulmRvzQKTt4jWcKnQ3GovwtP2zYhyysfHwfyk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d91bb9a-d139-481a-737b-08d7262eff75
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 11:59:18.7715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fn5VbpxX0LES9eFSvaac6mP9UWLqCclAbwmZvma2iPCXFep8PQXYo7aPkoNrmcanQm/JoJ7za7+nuzlbRLzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0343
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks Michael. See my reply inline to some of your comments.

> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Monday, August 19, 2019 6:41 AM
> To: Wei Hu <weh@microsoft.com>; rdunlap@infradead.org; shc_work@mail.ru;

> > -	msg.dirt.rect[0].x1 =3D 0;
> > -	msg.dirt.rect[0].y1 =3D 0;
> > -	msg.dirt.rect[0].x2 =3D info->var.xres;
> > -	msg.dirt.rect[0].y2 =3D info->var.yres;
> > +	msg.dirt.rect[0].x1 =3D (x1 < 0 || x1 > x2) ? 0 : x1;
> > +	msg.dirt.rect[0].y1 =3D (y2 < 0 || y1 > y2) ? 0 : y1;
>=20
> This should be:
>=20
> 	msg.dirt.rect[0].y1 =3D (y1 < 0 || y1 > y2) ? 0 : y1;
>=20
> Also, throughout the code, I don't think there are any places where
> x or y coordinate values are ever negative.  INT_MAX or 0 is used as the
> sentinel value indicating "not set".  So can all the tests for less than =
0
> now be eliminated, both in this function and in other functions?
>=20
> > +	msg.dirt.rect[0].x2 =3D
> > +		(x2 < x1 || x2 > info->var.xres) ? info->var.xres : x2;
> > +	msg.dirt.rect[0].y2 =3D
> > +		(y2 < y1 || y2 > info->var.yres) ? info->var.yres : y2;
>=20
> How exactly is the dirty rectangle specified to Hyper-V?  Suppose the fra=
me
> buffer resolution is 100x200.  If you want to specify the entire rectangl=
e, the
> first coordinate is (0, 0).  But what is the second coordinate?  Should i=
t be
> (99, 199) or (100, 200)?  The above code (and original code) implies it
> should specified as (100, 200), which is actually a point outside the
> maximum resolution, which is counter-intuitive and makes me wonder
> if the code is correct.
>=20
[Wei Hu]=20
The current code treat the entire framebuffer rectangle as (0,0) -> (var.xr=
es, var.yres).
Every time it sends refresh request, these are two points sent to host and =
host
seems accept it. See the above (x1, y1) and (x2, y2)  in the deleted lines.

So in your example the second coordinate is (100, 200).=20


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
> > +	list_for_each_entry(page, pagelist, lru) {
> > +		start =3D page->index << PAGE_SHIFT;
> > +		end =3D start + PAGE_SIZE - 1;
> > +		y1 =3D start / p->fix.line_length;
> > +		y2 =3D end / p->fix.line_length;
>=20
> The above division rounds down because any remainder is discarded.  I
> wondered whether rounding down is correct, which got me to thinking
> about how the dirty rectangle is specified.  Is y2 the index of the last
> dirty row?  If so, that's not consistent with the code in synthvid_update=
(),
> which might choose var.yres as y2, and that's the index of a row outside
> of the frame buffer.
>=20
[Wei Hu]=20
In this place we try to figure out and merge all the faulted pages into one
big dirty rectangle. A page in memory represents one or multiple lines in
frame buffer. For example, one faulted page could represent all the linear=
=20
pixels from (x, y) to (x-1, y+1). In this case we just form the dirty recta=
ngle
as (0, y) -> (var.xres, y+1). Also keep in mind we need to merge multiple
pages. That's why in the end the dirty rectangle is (0, miny) -> (var.xres,=
 maxy).


> > +		if (y2 > p->var.yres)
> > +			y2 =3D p->var.yres;
> > +		miny =3D min_t(int, miny, y1);
> > +		maxy =3D max_t(int, maxy, y2);
> > +
> > +		/* Copy from dio space to mmio address */
> > +		if (par->fb_ready) {
> > +			spin_lock_irqsave(&par->docopy_lock, flags);
> > +			hvfb_docopy(par, start, PAGE_SIZE);
> > +			spin_unlock_irqrestore(&par->docopy_lock, flags);
> > +		}
> > +	}
> > +
> > +	if (par->fb_ready)
> > +		synthvid_update(p, 0, miny, p->var.xres, maxy);
> > +}




> > +
> > +		if (j =3D=3D info->var.yres)
> > +			break;
> > +		hvfb_docopy(par,
> > +			    j * info->fix.line_length +
> > +			    (x1 * screen_depth / 8),
> > +			    (x2 - x1 + 1) * screen_depth / 8);
>=20
> Whether the +1 is needed above gets back to the question I
> raised earlier about how to interpret the coordinates -- whether
> the (x2, y2) coordinate is just outside the dirty rectangle or
> just inside the dirty rectangle.  Most of the code seems to treat
> it as being just outside the dirty rectangle, in which case the +1
> should not be used.
>=20
[Wei Hu]=20
This dirty rectangle is not from page fault, but rather from frame buffer
framework when the screen is in text mode. I am not 100% sure if the dirty
rectangle given from kernel includes on extra line outside or not.  Here I=
=20
just play it safe by copying one extra line in the worst case.

Suppose dirty rectangle only contain one pixel, for example (0,0) is the on=
ly
pixel changed in the entire frame buffer. If kernel sends me dirty rectangl=
e as
(0, 0) -> (0, 0), the above function works correctly. If the kernel sends
 (0, 0) -> (1, 1), then the above function just copies one extra row and on=
e extra
column, which should also be fine. The hvfb_docopy() takes care of the=20
edge cases.

Thanks,
Wei
