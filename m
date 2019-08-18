Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7371091A04
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Aug 2019 00:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfHRWlU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 18 Aug 2019 18:41:20 -0400
Received: from mail-eopbgr790104.outbound.protection.outlook.com ([40.107.79.104]:32768
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbfHRWlT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 18 Aug 2019 18:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFtzanRSoILM+jcYWaI4Z98Kz0xc3acHIgMevFpTaaw2ziWEiZAqvJ9xOc/4zwebCJrmHte+Swrx1XMzYbkA1LMaposJJQpLnOeBhH2HYQ4TcFn31Uuu/Yer14pNr5fCC1PQFzlQv7qWZ2DuHQKSbax3zE4AO4g1jbsyMtSw/A3mtX8uS636UwkrvYdvoDmHegP6sJ0iV+gi9xM3g8Az48G/NTR9HgpW9FwFnsN3QKT21nJNE18IBedfzkpPc0OttPOBw3Eh3Hkw3YZgVNRKZljeQxc8hfIdcTruShNDauRz36CFhynTPeOhpVZNH4PX01Q7OUMs7w7i4aPX1NopvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsJq5xbgoT8uxXmenQxkLM8x80sy+eJUDGFaKsdH00I=;
 b=lvzB5/eBxD8HebSi2rPbsbtjHY0YEHgK8GfZ5FW7j8DFG8ogTI4EprtKhyTWgQCAQIW65Nb3UTItkj0TPAH+6s7POTISZ8Y9+pBee8ZzH9mwpb0egWPuj2EewRZb+9awJ4nfW/KvfuldHhdkY5Tcrh4RF0iGqs7uui30gQR58aAgmyQ+sjYoN4Ii+qX3B+eTzPK3lFBA6IWrMhiSvux+HxUHqaISg2I4ZD7gAmqJeQbpWHXg5wjTfb6w0stypKaa+x4S9awRhYJtEagsjQWc+I3fjCs9S93VLrIwz/te/3PqcR9ORft5Pkbm9f6HGZdmGVjf6NOfaoD35CXK8f2IEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsJq5xbgoT8uxXmenQxkLM8x80sy+eJUDGFaKsdH00I=;
 b=A5eRq1r50ZmaLTiNbaR+h5/rY7vfKcvP/1jMwf4sSOSodutZBAjmv1vJWyO+W/zlTMSZsUl78KHDCcyhd6WKJWveH7EuQCRUf4h9mDKQbpW1xHOYXoWuRlXUGFuPvvGksU0rq3T4lWL143yOWOkcq9Denwqk44mYjWEseRjnMro=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0172.namprd21.prod.outlook.com (10.173.173.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.0; Sun, 18 Aug 2019 22:41:13 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Sun, 18 Aug 2019
 22:41:13 +0000
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
Thread-Index: AQHVUcL5xwYcgiTbLE2rph4+nLCFt6cBbYBA
Date:   Sun, 18 Aug 2019 22:41:13 +0000
Message-ID: <DM5PR21MB0137E0BB19D8A0E6385BB316D7A90@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190813103548.2008-1-weh@microsoft.com>
In-Reply-To: <20190813103548.2008-1-weh@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 51b8772e-56ff-4c8e-3457-08d7242d2ca4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0172;
x-ms-traffictypediagnostic: DM5PR21MB0172:|DM5PR21MB0172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB017270C6619E7E72FEFF9778D7A90@DM5PR21MB0172.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-forefront-prvs: 01334458E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(30864003)(486006)(446003)(25786009)(52536014)(7736002)(1511001)(2906002)(8936002)(3846002)(476003)(229853002)(6246003)(8676002)(1250700005)(53946003)(6116002)(305945005)(5660300002)(81156014)(6436002)(81166006)(76116006)(2501003)(74316002)(11346002)(33656002)(6636002)(8990500004)(10290500003)(22452003)(316002)(7416002)(110136005)(76176011)(7696005)(66066001)(186003)(99286004)(14444005)(86362001)(256004)(478600001)(66446008)(14454004)(26005)(64756008)(9686003)(71200400001)(71190400001)(66556008)(66476007)(55016002)(53936002)(66946007)(6506007)(2201001)(10090500001)(102836004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0172;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1qFOZYtl/r6lJSjyXtT84HZDLLuZxXG8vVpTCW32BkLlSvBUoVYzl3fV3Cb0l73mP+JhJU+FhxwxtrREzJsCjFzn326ImwuHPIudIJdi4qOJbjXozGmUcxLQInCunrXBJWeF5CmbFPv2REmK+P35gdU8y0WMEYwnFunvlAv3idacWtb2IJQ9VoPM+N4C+Ys2K6G3cC/WgLQ/JwDi/iVZQPixT94nWxnAXS2B+qbQZsFrsgp+/Bmc8SXMaHRWgff5lM3yEh686QeuZ8rzzMK1jXi4QtSsLbV6gUTLklWX0iM2lXAh17IPDOuqMnirzaIFSDGdqfEpiVg7nWPVer+cBe8T5L4tFR9/5/dsPbXOICpJM2waxw5rhWKMwVqStSHlFKfFgJsuIaq8xYdFl0lElDLeC4PaarN6TujAyLy5HDU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b8772e-56ff-4c8e-3457-08d7242d2ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2019 22:41:13.5182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUiet0Lb/XIPFVLnBBggGKsdtnXQRZ2oiV2eqqKdVM8oESv//QlR9Pijcn77dMNevdftzR5KcIV6D63AbznifluNqkKiKPFl/OXnyID6BCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0172
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Tuesday, August 13, 2019 3:37 AM
>=20
> Without deferred IO support, hyperv_fb driver informs the host to refresh
> the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter ther=
e
> is screen update or not. This patch supports defered IO for screens in

s/defered/deferred/

> graphic mode and also enables the framme buffer on-demand refresh. The

s/graphic/graphics/
s/framme/frame/

> highest refresh rate is still set at 20Hz.
>=20
> Due to limitation on Hyper-V host, we keep a shadow copy of frame buffer

I think it might be worthwhile to explain exactly what the issue is so that
there's a record kept.

> in the guest. This means one more copy of the dirty rectangle inside
> guest when doing the on-demand refresh. This can be optimized in the
> future with help from host. For now the host performance gain from deferr=
ed
> IO outweighs the shadow copy impact in the guest.
>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 217 +++++++++++++++++++++++++++++---
>  2 files changed, 198 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 1b2f5f31fb6f..e781f89a1824 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2241,6 +2241,7 @@ config FB_HYPERV
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select FB_DEFERRED_IO
>  	help
>  	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
>=20
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv=
_fb.c
> index 1042f3311fa2..85198a6ea8e7 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -233,6 +233,7 @@ struct synthvid_msg {
>  #define RING_BUFSIZE (256 * 1024)
>  #define VSP_TIMEOUT (10 * HZ)
>  #define HVFB_UPDATE_DELAY (HZ / 20)
> +#define HVFB_ONDEMAND_THROTTLE (HZ / 20)
>=20
>  struct hvfb_par {
>  	struct fb_info *info;
> @@ -252,6 +253,17 @@ struct hvfb_par {
>  	bool synchronous_fb;
>=20
>  	struct notifier_block hvfb_panic_nb;
> +
> +	/* Memory for deferred IO and frame buffer itself */
> +	unsigned char *dio_vp;
> +	unsigned char *mmio_vp;
> +	unsigned long mmio_pp;
> +	spinlock_t docopy_lock; /* Lock to protect memory copy */
> +
> +	/* Dirty rectangle, protected by delayed_refresh_lock */
> +	int x1, y1, x2, y2;
> +	bool delayed_refresh;
> +	spinlock_t delayed_refresh_lock;
>  };
>=20
>  static uint screen_width =3D HVFB_WIDTH;
> @@ -260,6 +272,7 @@ static uint screen_width_max =3D HVFB_WIDTH;
>  static uint screen_height_max =3D HVFB_HEIGHT;
>  static uint screen_depth;
>  static uint screen_fb_size;
> +static uint dio_fb_size; /* FB size for deferred IO */
>=20
>  /* Send message to Hyper-V host */
>  static inline int synthvid_send(struct hv_device *hdev,
> @@ -346,28 +359,88 @@ static int synthvid_send_ptr(struct hv_device *hdev=
)
>  }
>=20
>  /* Send updated screen area (dirty rectangle) location to host */
> -static int synthvid_update(struct fb_info *info)
> +static int
> +synthvid_update(struct fb_info *info, int x1, int y1, int x2, int y2)
>  {
>  	struct hv_device *hdev =3D device_to_hv_device(info->device);
>  	struct synthvid_msg msg;
>=20
>  	memset(&msg, 0, sizeof(struct synthvid_msg));
> +	if (x2 =3D=3D INT_MAX)
> +		x2 =3D info->var.xres;
> +	if (y2 =3D=3D INT_MAX)
> +		y2 =3D info->var.yres;
>=20
>  	msg.vid_hdr.type =3D SYNTHVID_DIRT;
>  	msg.vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_dirt);
>  	msg.dirt.video_output =3D 0;
>  	msg.dirt.dirt_count =3D 1;
> -	msg.dirt.rect[0].x1 =3D 0;
> -	msg.dirt.rect[0].y1 =3D 0;
> -	msg.dirt.rect[0].x2 =3D info->var.xres;
> -	msg.dirt.rect[0].y2 =3D info->var.yres;
> +	msg.dirt.rect[0].x1 =3D (x1 < 0 || x1 > x2) ? 0 : x1;
> +	msg.dirt.rect[0].y1 =3D (y2 < 0 || y1 > y2) ? 0 : y1;

This should be:

	msg.dirt.rect[0].y1 =3D (y1 < 0 || y1 > y2) ? 0 : y1;

Also, throughout the code, I don't think there are any places where
x or y coordinate values are ever negative.  INT_MAX or 0 is used as the
sentinel value indicating "not set".  So can all the tests for less than 0
now be eliminated, both in this function and in other functions?

> +	msg.dirt.rect[0].x2 =3D
> +		(x2 < x1 || x2 > info->var.xres) ? info->var.xres : x2;
> +	msg.dirt.rect[0].y2 =3D
> +		(y2 < y1 || y2 > info->var.yres) ? info->var.yres : y2;

How exactly is the dirty rectangle specified to Hyper-V?  Suppose the frame
buffer resolution is 100x200.  If you want to specify the entire rectangle,=
 the
first coordinate is (0, 0).  But what is the second coordinate?  Should it =
be
(99, 199) or (100, 200)?  The above code (and original code) implies it
should specified as (100, 200), which is actually a point outside the
maximum resolution, which is counter-intuitive and makes me wonder
if the code is correct.

>=20
>  	synthvid_send(hdev, &msg);
>=20
>  	return 0;
>  }
>=20
> +static void hvfb_docopy(struct hvfb_par *par,
> +			unsigned long offset,
> +			unsigned long size)
> +{
> +	if (!par || !par->mmio_vp || !par->dio_vp || !par->fb_ready ||
> +	    size =3D=3D 0 || offset >=3D dio_fb_size)
> +		return;
> +
> +	if (offset + size > dio_fb_size)
> +		size =3D dio_fb_size - offset;
> +
> +	memcpy(par->mmio_vp + offset, par->dio_vp + offset, size);
> +}
> +
> +/* Deferred IO callback */
> +static void synthvid_deferred_io(struct fb_info *p,
> +				 struct list_head *pagelist)
> +{
> +	struct hvfb_par *par =3D p->par;
> +	struct page *page;
> +	unsigned long start, end;
> +	int y1, y2, miny, maxy;
> +	unsigned long flags;
> +
> +	miny =3D INT_MAX;
> +	maxy =3D 0;
> +
> +	list_for_each_entry(page, pagelist, lru) {
> +		start =3D page->index << PAGE_SHIFT;
> +		end =3D start + PAGE_SIZE - 1;
> +		y1 =3D start / p->fix.line_length;
> +		y2 =3D end / p->fix.line_length;

The above division rounds down because any remainder is discarded.  I
wondered whether rounding down is correct, which got me to thinking
about how the dirty rectangle is specified.  Is y2 the index of the last
dirty row?  If so, that's not consistent with the code in synthvid_update()=
,
which might choose var.yres as y2, and that's the index of a row outside
of the frame buffer.

> +		if (y2 > p->var.yres)
> +			y2 =3D p->var.yres;
> +		miny =3D min_t(int, miny, y1);
> +		maxy =3D max_t(int, maxy, y2);
> +
> +		/* Copy from dio space to mmio address */
> +		if (par->fb_ready) {
> +			spin_lock_irqsave(&par->docopy_lock, flags);
> +			hvfb_docopy(par, start, PAGE_SIZE);
> +			spin_unlock_irqrestore(&par->docopy_lock, flags);
> +		}
> +	}
> +
> +	if (par->fb_ready)
> +		synthvid_update(p, 0, miny, p->var.xres, maxy);
> +}
> +
> +static struct fb_deferred_io synthvid_defio =3D {
> +	.delay		=3D HZ / 20,
> +	.deferred_io	=3D synthvid_deferred_io,
> +};
>=20
>  /*
>   * Actions on received messages from host:
> @@ -597,7 +670,7 @@ static int synthvid_send_config(struct hv_device *hde=
v)
>  	msg->vid_hdr.type =3D SYNTHVID_VRAM_LOCATION;
>  	msg->vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_vram_location);
> -	msg->vram.user_ctx =3D msg->vram.vram_gpa =3D info->fix.smem_start;
> +	msg->vram.user_ctx =3D msg->vram.vram_gpa =3D par->mmio_pp;
>  	msg->vram.is_vram_gpa_specified =3D 1;
>  	synthvid_send(hdev, msg);
>=20
> @@ -607,7 +680,7 @@ static int synthvid_send_config(struct hv_device *hde=
v)
>  		ret =3D -ETIMEDOUT;
>  		goto out;
>  	}
> -	if (msg->vram_ack.user_ctx !=3D info->fix.smem_start) {
> +	if (msg->vram_ack.user_ctx !=3D par->mmio_pp) {
>  		pr_err("Unable to set VRAM location\n");
>  		ret =3D -ENODEV;
>  		goto out;
> @@ -624,19 +697,85 @@ static int synthvid_send_config(struct hv_device *h=
dev)
>=20
>  /*
>   * Delayed work callback:
> - * It is called at HVFB_UPDATE_DELAY or longer time interval to process
> - * screen updates. It is re-scheduled if further update is necessary.
> + * It is scheduled to call whenever update request is received and it ha=
s
> + * not been called in last HVFB_ONDEMAND_THROTTLE time interval.
>   */
>  static void hvfb_update_work(struct work_struct *w)
>  {
>  	struct hvfb_par *par =3D container_of(w, struct hvfb_par, dwork.work);
>  	struct fb_info *info =3D par->info;
> +	unsigned long flags;
> +	int x1, x2, y1, y2;
> +	int j;
> +
> +	x1 =3D y1 =3D 0;
> +	x2 =3D y2 =3D INT_MAX;

The above two lines seem superfluous since all four values
are unconditionally set below when storing the dirty
rectangle to local variables.

> +
> +	spin_lock_irqsave(&par->delayed_refresh_lock, flags);
> +	/* Reset the request flag */
> +	par->delayed_refresh =3D false;
> +
> +	/* Store the dirty rectangle to local variables */
> +	x1 =3D par->x1;
> +	x2 =3D par->x2;
> +	y1 =3D par->y1;
> +	y2 =3D par->y2;
> +
> +	/* Clear dirty rectangle */
> +	par->x1 =3D par->y1 =3D INT_MAX;
> +	par->x2 =3D par->y2 =3D 0;
>=20
> +	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
> +
> +	if (x1 < 0 || x1 > info->var.xres || x2 < 0 ||
> +	    x2 > info->var.xres || y1 < 0 || y1 > info->var.yres ||
> +	    y2 < 0 || y2 > info->var.yres)
> +		return;
> +
> +	/* Copy the dirty rectangle to frame buffer memory */
> +	spin_lock_irqsave(&par->docopy_lock, flags);
> +	for (j =3D y1; j <=3D y2 && x1 < x2; j++) {

x1 < x2 doesn't seem to be needed as a loop control test as
neither value is changed in the loop.

> +		if (j =3D=3D info->var.yres)
> +			break;
> +		hvfb_docopy(par,
> +			    j * info->fix.line_length +
> +			    (x1 * screen_depth / 8),
> +			    (x2 - x1 + 1) * screen_depth / 8);

Whether the +1 is needed above gets back to the question I
raised earlier about how to interpret the coordinates -- whether
the (x2, y2) coordinate is just outside the dirty rectangle or
just inside the dirty rectangle.  Most of the code seems to treat
it as being just outside the dirty rectangle, in which case the +1
should not be used.

> +	}
> +	spin_unlock_irqrestore(&par->docopy_lock, flags);
> +
> +	/* Refresh */
>  	if (par->fb_ready)
> -		synthvid_update(info);
> +		synthvid_update(info, x1, y1, x2, y2);
> +}
> +
> +/*
> + * Control the on-demand refresh frequency. It schedules a delayed
> + * screen update if it has not yet.
> + */
> +static void hvfb_ondemand_refresh_throttle(struct hvfb_par *par,
> +					   int x1, int y1, int w, int h)
> +{
> +	unsigned long flags;
> +	int x2 =3D x1 + w;
> +	int y2 =3D y1 + h;
> +
> +	spin_lock_irqsave(&par->delayed_refresh_lock, flags);
> +
> +	/* Merge dirty rectangle */
> +	par->x1 =3D min_t(int, par->x1, x1);
> +	par->y1 =3D min_t(int, par->y1, y1);
> +	par->x2 =3D max_t(int, par->x2, x2);
> +	par->y2 =3D max_t(int, par->y2, y2);
> +
> +	/* Schedule a delayed screen update if not yet */
> +	if (par->delayed_refresh =3D=3D false) {
> +		schedule_delayed_work(&par->dwork,
> +				      HVFB_ONDEMAND_THROTTLE);
> +		par->delayed_refresh =3D true;
> +	}
>=20
> -	if (par->update)
> -		schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
> +	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
>  }
>=20
>  static int hvfb_on_panic(struct notifier_block *nb,
> @@ -648,7 +787,8 @@ static int hvfb_on_panic(struct notifier_block *nb,
>  	par =3D container_of(nb, struct hvfb_par, hvfb_panic_nb);
>  	par->synchronous_fb =3D true;
>  	info =3D par->info;
> -	synthvid_update(info);
> +	hvfb_docopy(par, 0, dio_fb_size);
> +	synthvid_update(info, 0, 0, INT_MAX, INT_MAX);
>=20
>  	return NOTIFY_DONE;
>  }
> @@ -709,7 +849,10 @@ static void hvfb_cfb_fillrect(struct fb_info *p,
>=20
>  	cfb_fillrect(p, rect);
>  	if (par->synchronous_fb)
> -		synthvid_update(p);
> +		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
> +	else
> +		hvfb_ondemand_refresh_throttle(par, rect->dx, rect->dy,
> +					       rect->width, rect->height);
>  }
>=20
>  static void hvfb_cfb_copyarea(struct fb_info *p,
> @@ -719,7 +862,10 @@ static void hvfb_cfb_copyarea(struct fb_info *p,
>=20
>  	cfb_copyarea(p, area);
>  	if (par->synchronous_fb)
> -		synthvid_update(p);
> +		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
> +	else
> +		hvfb_ondemand_refresh_throttle(par, area->dx, area->dy,
> +					       area->width, area->height);
>  }
>=20
>  static void hvfb_cfb_imageblit(struct fb_info *p,
> @@ -729,7 +875,10 @@ static void hvfb_cfb_imageblit(struct fb_info *p,
>=20
>  	cfb_imageblit(p, image);
>  	if (par->synchronous_fb)
> -		synthvid_update(p);
> +		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
> +	else
> +		hvfb_ondemand_refresh_throttle(par, image->dx, image->dy,
> +					       image->width, image->height);
>  }
>=20
>  static struct fb_ops hvfb_ops =3D {
> @@ -788,6 +937,9 @@ static int hvfb_getmem(struct hv_device *hdev, struct=
 fb_info
> *info)
>  	resource_size_t pot_start, pot_end;
>  	int ret;
>=20
> +	dio_fb_size =3D
> +		screen_width * screen_height * screen_depth / 8;
> +
>  	if (gen2vm) {
>  		pot_start =3D 0;
>  		pot_end =3D -1;
> @@ -822,9 +974,15 @@ static int hvfb_getmem(struct hv_device *hdev, struc=
t fb_info
> *info)
>  	if (!fb_virt)
>  		goto err2;
>=20
> +	/* Allocate memory for deferred IO */
> +	par->dio_vp =3D vzalloc(((dio_fb_size >> PAGE_SHIFT) + 1)
> +				 << PAGE_SHIFT);

I'd suggest using the round_up() function so that what you are doing
is explicit.

> +	if (par->dio_vp =3D=3D NULL)
> +		goto err3;
> +
>  	info->apertures =3D alloc_apertures(1);
>  	if (!info->apertures)
> -		goto err3;
> +		goto err4;
>=20
>  	if (gen2vm) {
>  		info->apertures->ranges[0].base =3D screen_info.lfb_base;
> @@ -836,16 +994,23 @@ static int hvfb_getmem(struct hv_device *hdev, stru=
ct fb_info
> *info)
>  		info->apertures->ranges[0].size =3D pci_resource_len(pdev, 0);
>  	}
>=20
> +	/* Physical address of FB device */
> +	par->mmio_pp =3D par->mem->start;
> +	/* Virtual address of FB device */
> +	par->mmio_vp =3D (unsigned char *) fb_virt;
> +
>  	info->fix.smem_start =3D par->mem->start;
> -	info->fix.smem_len =3D screen_fb_size;
> -	info->screen_base =3D fb_virt;
> -	info->screen_size =3D screen_fb_size;
> +	info->fix.smem_len =3D dio_fb_size;
> +	info->screen_base =3D par->dio_vp;
> +	info->screen_size =3D dio_fb_size;
>=20
>  	if (!gen2vm)
>  		pci_dev_put(pdev);
>=20
>  	return 0;
>=20
> +err4:
> +	vfree(par->dio_vp);
>  err3:
>  	iounmap(fb_virt);
>  err2:
> @@ -863,6 +1028,7 @@ static void hvfb_putmem(struct fb_info *info)
>  {
>  	struct hvfb_par *par =3D info->par;
>=20
> +	vfree(par->dio_vp);
>  	iounmap(info->screen_base);
>  	vmbus_free_mmio(par->mem->start, screen_fb_size);
>  	par->mem =3D NULL;
> @@ -888,6 +1054,12 @@ static int hvfb_probe(struct hv_device *hdev,
>  	init_completion(&par->wait);
>  	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
>=20
> +	par->delayed_refresh =3D false;
> +	spin_lock_init(&par->delayed_refresh_lock);
> +	spin_lock_init(&par->docopy_lock);
> +	par->x1 =3D par->y1 =3D INT_MAX;
> +	par->x2 =3D par->y2 =3D 0;
> +
>  	/* Connect to VSP */
>  	hv_set_drvdata(hdev, info);
>  	ret =3D synthvid_connect_vsp(hdev);
> @@ -939,6 +1111,10 @@ static int hvfb_probe(struct hv_device *hdev,
>  	info->fbops =3D &hvfb_ops;
>  	info->pseudo_palette =3D par->pseudo_palette;
>=20
> +	/* Initialize deferred IO */
> +	info->fbdefio =3D &synthvid_defio;
> +	fb_deferred_io_init(info);
> +
>  	/* Send config to host */
>  	ret =3D synthvid_send_config(hdev);
>  	if (ret)
> @@ -960,6 +1136,7 @@ static int hvfb_probe(struct hv_device *hdev,
>  	return 0;
>=20
>  error:
> +	fb_deferred_io_cleanup(info);
>  	hvfb_putmem(info);
>  error2:
>  	vmbus_close(hdev->channel);
> --
> 2.20.1

