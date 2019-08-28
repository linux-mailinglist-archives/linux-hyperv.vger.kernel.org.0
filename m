Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635B59F727
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2019 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfH1AHa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Aug 2019 20:07:30 -0400
Received: from mail-eopbgr740094.outbound.protection.outlook.com ([40.107.74.94]:19258
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfH1AHa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Aug 2019 20:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5+Z+3MIJzHE70M9ocnH9pXqtQMVKAX6ZNug9KxTGMFrlDUN/z/RlL9kx1rt2hO+dr0qpOzPHgs2P0vC7iqCtPp4Dibex20v2l616U+yWKrPdhtgDUuNPWyccuOo8NtLy0+ILFmVMITkUYz9+yASbPy5asljMUF5I0Jj6YUKAy7bzBxuu1c1tDJ/skXjRciQCuxgwWQOcTWFzoTvYSyr1BFPMavH8TcaqkJranWdC+yqWEc9JKHIpZaGA6B/mtG523G88/bJoBDEJTlSS+H+M4fEdLsRXsUNIlqGAYNgagJquDH5twKfmOU8Mgesy2KqLeTZ4dvvAip4B9bjItmY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2iX+rK5E1wYIf01Pl2R/6XP61dLrx3AZivaxIRkgFs=;
 b=Qu3DCSzQIDHe+WKj8ajbbku+0IqFDIZlIrAdCiv1yab5a7S4eqS8KSiiYshjZ06Kjn85XV1nO9FfOM/Lql8p+zU6j020ofNxpL9aVLa8lvqZFavb6z8CbDXimQABA1z7EH5BVwEOAgVhuoA1mCmMZbI80TwAyqgSWYhCw6CQM2QXIhqxEZVgU0KjOgFuOV+dYajQNvGkv0fI7VCXTGCK8L+Hv5hMuYWdLrNjhL1hJTGHUvQ9AvY2zTj0ijC55ItWrcDf4xRaOFHvmgyMhcN5fZFe31S2tM/2rRFXgSjcMG7+wwH0lCMnASFyAmxT14tFy594NlsJL12OMyAoIC6Tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2iX+rK5E1wYIf01Pl2R/6XP61dLrx3AZivaxIRkgFs=;
 b=nhyxTCM2LGmwkA/6EEgWu2GwHz7g0vUdVR7lJFg3Sc9w7QaEpnyu9L79McAvQcwJ+p0tc8M59clUsmNmPk0wBSLxcErjovSZNy8rHM6iy2y4vhJLQbhJiRCcoxWe7wyc4knNYGxzUUML1PSIlS3RoXBAByedmjQ7c125C0A+SKg=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0473.namprd21.prod.outlook.com (10.172.92.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.1; Wed, 28 Aug 2019 00:07:21 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2241.000; Wed, 28 Aug 2019
 00:07:21 +0000
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
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATHC v2] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Topic: [PATHC v2] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVXMoQkghsJmF5GU+6GBoMEWqB8KcPrJWw
Date:   Wed, 28 Aug 2019 00:07:20 +0000
Message-ID: <DM5PR21MB0137969B8EB3146160C86A2DD7A30@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190827112421.2770-1-weh@microsoft.com>
In-Reply-To: <20190827112421.2770-1-weh@microsoft.com>
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
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:d0b9:e2d7:362d:146a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f10f638c-9f15-4bd8-5f18-08d72b4bb258
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0473;
x-ms-traffictypediagnostic: DM5PR21MB0473:|DM5PR21MB0473:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0473C2E862874362998B3516D7A30@DM5PR21MB0473.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(53936002)(46003)(7696005)(102836004)(74316002)(81156014)(81166006)(10290500003)(186003)(8676002)(6636002)(6246003)(2501003)(478600001)(1250700005)(446003)(11346002)(55016002)(476003)(6436002)(486006)(8936002)(9686003)(99286004)(7736002)(86362001)(76176011)(6506007)(1511001)(25786009)(305945005)(14454004)(2201001)(8990500004)(14444005)(6116002)(110136005)(256004)(229853002)(2906002)(66446008)(66556008)(76116006)(66946007)(64756008)(66476007)(10090500001)(5660300002)(22452003)(33656002)(316002)(7416002)(71200400001)(71190400001)(52536014)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0473;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JSlO/3GYY/FrniiwRzlDHfmber/pLkN3aOr82qxGJSxY1tFaO/s6HRtzy3iKg2MDUMfkH3NOXwsdzSS6TN0ssp6WQXp2aSfoMWoDDaMRpaqn9eSr6LkKEO45pxUZEIV9oi2iaVZhOTBy1LHjZKBT2a1dBcq+RrGzXS39LJQ2rXSwf5S5HsWHIv34ksxu3RF3HRZ3yPZouOGHYyVFdS3KwtvwvFjG8sVPkokJGSEGH5RjODBX02OPFtMpNbMunYWwjcGJDzpV/ZhmYReaLqokoXDof7+Ygl7hSwoUMpuZmKTN7PjyzX3C9eFB4KUqZNHppKABKFWSAeOsOuAum9T+dvz3Hbw6GzXljQ6vT95yoilZ9dmULdFXv95glH78nz5yz53r9snrr/HBzG72PFLUuaZO47I25zvi8IRz+YtW7NE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10f638c-9f15-4bd8-5f18-08d72b4bb258
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 00:07:20.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNLVrm5H4skYrkxc4MPLKxhMCxhKfa/HIImynzcBsC8+u7pJSdkXkaFLjXXmTgzpQWtZl5hM8DYjfHyVXoTxNptJEpt8S9kwWt+4iLyNXp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0473
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com>  Sent: Tuesday, August 27, 2019 4:25 AM
>=20
> Without deferred IO support, hyperv_fb driver informs the host to refresh
> the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter ther=
e
> is screen update or not. This patch supports deferred IO for screens in
> graphics mode and also enables the frame buffer on-demand refresh. The
> highest refresh rate is still set at 20Hz.
>=20
> Currently Hyper-V only takes a physical address from guest as the startin=
g
> address of frame buffer. This implies the guest must allocate contiguous
> physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> accept address from MMIO region as frame buffer address. Due to these
> limitations on Hyper-V host, we keep a shadow copy of frame buffer
> in the guest. This means one more copy of the dirty rectangle inside
> guest when doing the on-demand refresh. This can be optimized in the
> future with help from host. For now the host performance gain from deferr=
ed
> IO outweighs the shadow copy impact in the guest.
>=20
> v2: Incorporated review comments from Michael Kelley
> - Increased dirty rectangle by one row in deferred IO case when sending
> to Hyper-V.
> - Corrected the dirty rectangle size in the text mode.
> - Added more comments.
> - Other minor code cleanups.

Version history should go after the "---" below so it is not included in
the commit message.

>=20
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 221 +++++++++++++++++++++++++++++---
>  2 files changed, 202 insertions(+), 20 deletions(-)
>=20
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
> +	/*
> +	 * Merge dirty pages. It is possible that last page cross
> +	 * over the end of frame buffer row yres. This is taken care of
> +	 * in synthvid_update function by clamping the y2
> +	 * value to yres.
> +	 */
> +	list_for_each_entry(page, pagelist, lru) {
> +		start =3D page->index << PAGE_SHIFT;
> +		end =3D start + PAGE_SIZE - 1;
> +		y1 =3D start / p->fix.line_length;
> +		y2 =3D end / p->fix.line_length;
> +		if (y2 > p->var.yres)
> +			y2 =3D p->var.yres;

The above test seems contradictory to the comment that
says the clamping is done in synthvid_update().  Also, since
the above calculation of y2 is "inclusive", the clamping should
be done to yres - 1 in order to continue to be inclusive.  Then
when maxy + 1 is passed to synthvid_update() everything works
out correctly.

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
> +		synthvid_update(p, 0, miny, p->var.xres, maxy + 1);
> +}
> +
> +static struct fb_deferred_io synthvid_defio =3D {
> +	.delay		=3D HZ / 20,
> +	.deferred_io	=3D synthvid_deferred_io,
> +};
>=20
>  /*
>   * Actions on received messages from host:
> @@ -604,7 +683,7 @@ static int synthvid_send_config(struct hv_device *hde=
v)
>  	msg->vid_hdr.type =3D SYNTHVID_VRAM_LOCATION;
>  	msg->vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_vram_location);
> -	msg->vram.user_ctx =3D msg->vram.vram_gpa =3D info->fix.smem_start;
> +	msg->vram.user_ctx =3D msg->vram.vram_gpa =3D par->mmio_pp;
>  	msg->vram.is_vram_gpa_specified =3D 1;
>  	synthvid_send(hdev, msg);
>=20
> @@ -614,7 +693,7 @@ static int synthvid_send_config(struct hv_device *hde=
v)
>  		ret =3D -ETIMEDOUT;
>  		goto out;
>  	}
> -	if (msg->vram_ack.user_ctx !=3D info->fix.smem_start) {
> +	if (msg->vram_ack.user_ctx !=3D par->mmio_pp) {
>  		pr_err("Unable to set VRAM location\n");
>  		ret =3D -ENODEV;
>  		goto out;
> @@ -631,19 +710,82 @@ static int synthvid_send_config(struct hv_device *h=
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
> +
> +	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
>=20
> +	if (x1 < 0 || x1 > info->var.xres || x2 < 0 ||
> +	    x2 > info->var.xres || y1 < 0 || y1 > info->var.yres ||
> +	    y2 < 0 || y2 > info->var.yres || x2 <=3D x1)
> +		return;

Are the tests for less than 0 needed?  I think all possibility of
negative values has been eliminated.

> +
> +	/* Copy the dirty rectangle to frame buffer memory */
> +	spin_lock_irqsave(&par->docopy_lock, flags);
> +	for (j =3D y1; j < y2; j++) {
> +		if (j =3D=3D info->var.yres)
> +			break;

The above test isn't needed.  The maximum value that y2 can be
is yres (that is checked a few lines above in the big "if" statement).
Since j is always less than y2, j can never be equal to yres.

> +		hvfb_docopy(par,
> +			    j * info->fix.line_length +
> +			    (x1 * screen_depth / 8),
> +			    (x2 - x1) * screen_depth / 8);
> +	}
> +	spin_unlock_irqrestore(&par->docopy_lock, flags);
> +
> +	/* Refresh */
>  	if (par->fb_ready)
> -		synthvid_update(info);
> +		synthvid_update(info, x1, y1, x2, y2);
> +}
> +

Michael
