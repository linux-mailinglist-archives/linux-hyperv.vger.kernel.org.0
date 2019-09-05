Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2BDA9CF8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2019 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfIEI3J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 04:29:09 -0400
Received: from mail-eopbgr790130.outbound.protection.outlook.com ([40.107.79.130]:29334
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730780AbfIEI3J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 04:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA6He+G64eAtD1dga8mrd4mD5eFb+kxtWTo6DKD6tfMH77SWUe4LmIC4NiiwCURVLJREcVUbbascfDLX/CvqLS+n6YTjexV5uQqev9HBuiT1HOQZSJqE/yYH0T4tT3kK/3suEgkR9S5Phv8x39Who4SOuQC/WB0YhvQwA6XjI2VYMbLzo3xI09Ue3cWWovBTmgCRS3M1cSRa0UAYI1Ea2neepfIdd4eltuxEGCLpTSl+jNVDPHy27fWh5fa2II5HPjx5XhWu1H3e5q3Ri8X36WKK7Db4Mz2VEgsyJ12lldOuagJ1ziOLTeJf3mo2l8pWiLKkSE6JmpHAOnl6oisWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haH9JepbPcQOtePCWZKT5dLcP1YOXKm4gCWKb/AkfyI=;
 b=aZ7RMClAiTRpUQWlFhZh/VLVx/vgcZJp8Q7ce7i7tvEI4Seg/7ETb3xc1mi5/ONbLMzT2m0RHFBiXG0W+4snrTgGRZ2gLB+qqd8zpodusINLXTZTQ20w/kUqvN5hXqjIwxPtUny+tUQyu9jO/11fvocYQl8grH0/07jTeH7clfyHmmemkXPaCGcxpKJ5K8lce2bPXUXEHqFQmnMt9aRIpdbG9S/HFnDd1uT7yJp/apCtyciGG7fCWlYMor1fzBPNg/6YD2CeEYCCn93jLMoXueRqm6JHveF44Af0HELY99cO1jfM+gBo9/CSqXwrr/hrFKEBAIW2gRipJ37adxnyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haH9JepbPcQOtePCWZKT5dLcP1YOXKm4gCWKb/AkfyI=;
 b=F4qluKkx9CLjQxDvd/7QbvCBu4WwW/QwA02z8UNiUPEtn4iWJo/PVgqRJNAufUxT94LU5GQk5LE+ux5Ylp1JvKI7eAkV4znXYQnP93ey2I51TXmMQ/nAvlesW7SGpcJI1KBTb1a1APPTVNXyjQw5HD1Mmu3RbRDFJFd89wKJUCU=
Received: from BY5PR21MB1396.namprd21.prod.outlook.com (20.180.35.80) by
 BY5PR21MB1506.namprd21.prod.outlook.com (20.180.35.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.7; Thu, 5 Sep 2019 08:28:51 +0000
Received: from BY5PR21MB1396.namprd21.prod.outlook.com
 ([fe80::6c6e:de3d:cdbf:997f]) by BY5PR21MB1396.namprd21.prod.outlook.com
 ([fe80::6c6e:de3d:cdbf:997f%2]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 08:28:50 +0000
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
CC:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v3] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V
 frame buffer driver
Thread-Topic: [PATCH v3] video: hyperv: hyperv_fb: Support deferred IO for
 Hyper-V frame buffer driver
Thread-Index: AQHVY8PxCEaneStSU0CIK0oNOZcaZw==
Date:   Thu, 5 Sep 2019 08:28:50 +0000
Message-ID: <20190905082816.3612-1-weh@microsoft.com>
Reply-To: Wei Hu <weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0129.apcprd06.prod.outlook.com
 (2603:1096:1:1d::31) To BY5PR21MB1396.namprd21.prod.outlook.com
 (2603:10b6:a03:23d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [167.220.255.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a64de68-bc49-45cd-6426-08d731db1439
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BY5PR21MB1506;
x-ms-traffictypediagnostic: BY5PR21MB1506:|BY5PR21MB1506:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR21MB15060CFDBB12FA66EEBDD420BBBB0@BY5PR21MB1506.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(199004)(189003)(2201001)(478600001)(36756003)(86362001)(7416002)(30864003)(6636002)(81166006)(10290500003)(6506007)(1076003)(50226002)(386003)(81156014)(3450700001)(8676002)(52116002)(8936002)(14454004)(66066001)(43066004)(99286004)(1511001)(5660300002)(186003)(486006)(25786009)(4326008)(476003)(10090500001)(2906002)(3846002)(107886003)(2616005)(53936002)(6512007)(256004)(2501003)(14444005)(6436002)(1250700005)(26005)(66556008)(305945005)(71190400001)(71200400001)(6116002)(316002)(7736002)(102836004)(110136005)(6486002)(22452003)(66476007)(64756008)(66446008)(66946007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR21MB1506;H:BY5PR21MB1396.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sobgKV55C5Ibe9rFSN6Hh7HYNVIqtJ5Sa1ZZfslEX7yfarKDMQDe6zPu5jB/ZC0DfXwtxhy5sjqRQFS4JRTkc169AXXJv+X9ysnPJC9J8r1oFymhB9xITMVk+BbLpaDm0xu/KBLhZXAmgcqa7NNOIJAJy2DQBQz7Q93//8bW00cNXuLgbbTdGS4DVUvZNWsGSornXYE6v8Ilv13BJJvIIYvbY/LlRb/b+0hIzClKwRCB6ylf5OAi4AvRq3bELhOoOEWeKGHe+3HGv89JyE8XTHl1rVCaZ9S5eQ/XK0i4gkRyFZ4WacyNzrHh+Z7e4VJGb0nJ/becVGYVFSF0SRUB7Bmx10usA/gsQFtbfEDYYpzul2602GVShQo/EX8RNGRPVWC+tikHk5n+xcoZpa782l6HFH3BXIeQ+E/liwqAyCo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a64de68-bc49-45cd-6426-08d731db1439
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 08:28:50.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/p2zn/H6XfEIbLyqOuMn8ye65qPzOv8UOxihQEez3UxyFUrRNxpRRhJWBbOtyKMz/+6ltN/m+pl4escTI51IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1506
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Without deferred IO support, hyperv_fb driver informs the host to refresh
the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
is screen update or not. This patch supports deferred IO for screens in
graphics mode and also enables the frame buffer on-demand refresh. The
highest refresh rate is still set at 20Hz.

Currently Hyper-V only takes a physical address from guest as the starting
address of frame buffer. This implies the guest must allocate contiguous
physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
accept address from MMIO region as frame buffer address. Due to these
limitations on Hyper-V host, we keep a shadow copy of frame buffer
in the guest. This means one more copy of the dirty rectangle inside
guest when doing the on-demand refresh. This can be optimized in the
future with help from host. For now the host performance gain from deferred
IO outweighs the shadow copy impact in the guest.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
    v2: Incorporated review comments from Michael Kelley
    - Increased dirty rectangle by one row in deferred IO case when sending
    to Hyper-V.
    - Corrected the dirty rectangle size in the text mode.
    - Added more comments.
    - Other minor code cleanups.

    v3: Incorporated more review comments
    - Removed a few unnecessary variable tests

 drivers/video/fbdev/Kconfig     |   1 +
 drivers/video/fbdev/hyperv_fb.c | 216 +++++++++++++++++++++++++++++---
 2 files changed, 197 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 1b2f5f31fb6f..e781f89a1824 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2241,6 +2241,7 @@ config FB_HYPERV
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_DEFERRED_IO
 	help
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
=20
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_f=
b.c
index 1464c6f14687..63bfd35e392c 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -237,6 +237,7 @@ struct synthvid_msg {
 #define RING_BUFSIZE (256 * 1024)
 #define VSP_TIMEOUT (10 * HZ)
 #define HVFB_UPDATE_DELAY (HZ / 20)
+#define HVFB_ONDEMAND_THROTTLE (HZ / 20)
=20
 struct hvfb_par {
 	struct fb_info *info;
@@ -256,6 +257,17 @@ struct hvfb_par {
 	bool synchronous_fb;
=20
 	struct notifier_block hvfb_panic_nb;
+
+	/* Memory for deferred IO and frame buffer itself */
+	unsigned char *dio_vp;
+	unsigned char *mmio_vp;
+	unsigned long mmio_pp;
+	spinlock_t docopy_lock; /* Lock to protect memory copy */
+
+	/* Dirty rectangle, protected by delayed_refresh_lock */
+	int x1, y1, x2, y2;
+	bool delayed_refresh;
+	spinlock_t delayed_refresh_lock;
 };
=20
 static uint screen_width =3D HVFB_WIDTH;
@@ -264,6 +276,7 @@ static uint screen_width_max =3D HVFB_WIDTH;
 static uint screen_height_max =3D HVFB_HEIGHT;
 static uint screen_depth;
 static uint screen_fb_size;
+static uint dio_fb_size; /* FB size for deferred IO */
=20
 /* Send message to Hyper-V host */
 static inline int synthvid_send(struct hv_device *hdev,
@@ -350,28 +363,92 @@ static int synthvid_send_ptr(struct hv_device *hdev)
 }
=20
 /* Send updated screen area (dirty rectangle) location to host */
-static int synthvid_update(struct fb_info *info)
+static int
+synthvid_update(struct fb_info *info, int x1, int y1, int x2, int y2)
 {
 	struct hv_device *hdev =3D device_to_hv_device(info->device);
 	struct synthvid_msg msg;
=20
 	memset(&msg, 0, sizeof(struct synthvid_msg));
+	if (x2 =3D=3D INT_MAX)
+		x2 =3D info->var.xres;
+	if (y2 =3D=3D INT_MAX)
+		y2 =3D info->var.yres;
=20
 	msg.vid_hdr.type =3D SYNTHVID_DIRT;
 	msg.vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
 		sizeof(struct synthvid_dirt);
 	msg.dirt.video_output =3D 0;
 	msg.dirt.dirt_count =3D 1;
-	msg.dirt.rect[0].x1 =3D 0;
-	msg.dirt.rect[0].y1 =3D 0;
-	msg.dirt.rect[0].x2 =3D info->var.xres;
-	msg.dirt.rect[0].y2 =3D info->var.yres;
+	msg.dirt.rect[0].x1 =3D (x1 > x2) ? 0 : x1;
+	msg.dirt.rect[0].y1 =3D (y1 > y2) ? 0 : y1;
+	msg.dirt.rect[0].x2 =3D
+		(x2 < x1 || x2 > info->var.xres) ? info->var.xres : x2;
+	msg.dirt.rect[0].y2 =3D
+		(y2 < y1 || y2 > info->var.yres) ? info->var.yres : y2;
=20
 	synthvid_send(hdev, &msg);
=20
 	return 0;
 }
=20
+static void hvfb_docopy(struct hvfb_par *par,
+			unsigned long offset,
+			unsigned long size)
+{
+	if (!par || !par->mmio_vp || !par->dio_vp || !par->fb_ready ||
+	    size =3D=3D 0 || offset >=3D dio_fb_size)
+		return;
+
+	if (offset + size > dio_fb_size)
+		size =3D dio_fb_size - offset;
+
+	memcpy(par->mmio_vp + offset, par->dio_vp + offset, size);
+}
+
+/* Deferred IO callback */
+static void synthvid_deferred_io(struct fb_info *p,
+				 struct list_head *pagelist)
+{
+	struct hvfb_par *par =3D p->par;
+	struct page *page;
+	unsigned long start, end;
+	int y1, y2, miny, maxy;
+	unsigned long flags;
+
+	miny =3D INT_MAX;
+	maxy =3D 0;
+
+	/*
+	 * Merge dirty pages. It is possible that last page cross
+	 * over the end of frame buffer row yres. This is taken care of
+	 * in synthvid_update function by clamping the y2
+	 * value to yres.
+	 */
+	list_for_each_entry(page, pagelist, lru) {
+		start =3D page->index << PAGE_SHIFT;
+		end =3D start + PAGE_SIZE - 1;
+		y1 =3D start / p->fix.line_length;
+		y2 =3D end / p->fix.line_length;
+		miny =3D min_t(int, miny, y1);
+		maxy =3D max_t(int, maxy, y2);
+
+		/* Copy from dio space to mmio address */
+		if (par->fb_ready) {
+			spin_lock_irqsave(&par->docopy_lock, flags);
+			hvfb_docopy(par, start, PAGE_SIZE);
+			spin_unlock_irqrestore(&par->docopy_lock, flags);
+		}
+	}
+
+	if (par->fb_ready)
+		synthvid_update(p, 0, miny, p->var.xres, maxy + 1);
+}
+
+static struct fb_deferred_io synthvid_defio =3D {
+	.delay		=3D HZ / 20,
+	.deferred_io	=3D synthvid_deferred_io,
+};
=20
 /*
  * Actions on received messages from host:
@@ -618,7 +695,7 @@ static int synthvid_send_config(struct hv_device *hdev)
 	msg->vid_hdr.type =3D SYNTHVID_VRAM_LOCATION;
 	msg->vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
 		sizeof(struct synthvid_vram_location);
-	msg->vram.user_ctx =3D msg->vram.vram_gpa =3D info->fix.smem_start;
+	msg->vram.user_ctx =3D msg->vram.vram_gpa =3D par->mmio_pp;
 	msg->vram.is_vram_gpa_specified =3D 1;
 	synthvid_send(hdev, msg);
=20
@@ -628,7 +705,7 @@ static int synthvid_send_config(struct hv_device *hdev)
 		ret =3D -ETIMEDOUT;
 		goto out;
 	}
-	if (msg->vram_ack.user_ctx !=3D info->fix.smem_start) {
+	if (msg->vram_ack.user_ctx !=3D par->mmio_pp) {
 		pr_err("Unable to set VRAM location\n");
 		ret =3D -ENODEV;
 		goto out;
@@ -645,19 +722,79 @@ static int synthvid_send_config(struct hv_device *hde=
v)
=20
 /*
  * Delayed work callback:
- * It is called at HVFB_UPDATE_DELAY or longer time interval to process
- * screen updates. It is re-scheduled if further update is necessary.
+ * It is scheduled to call whenever update request is received and it has
+ * not been called in last HVFB_ONDEMAND_THROTTLE time interval.
  */
 static void hvfb_update_work(struct work_struct *w)
 {
 	struct hvfb_par *par =3D container_of(w, struct hvfb_par, dwork.work);
 	struct fb_info *info =3D par->info;
+	unsigned long flags;
+	int x1, x2, y1, y2;
+	int j;
+
+	spin_lock_irqsave(&par->delayed_refresh_lock, flags);
+	/* Reset the request flag */
+	par->delayed_refresh =3D false;
+
+	/* Store the dirty rectangle to local variables */
+	x1 =3D par->x1;
+	x2 =3D par->x2;
+	y1 =3D par->y1;
+	y2 =3D par->y2;
+
+	/* Clear dirty rectangle */
+	par->x1 =3D par->y1 =3D INT_MAX;
+	par->x2 =3D par->y2 =3D 0;
+
+	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
=20
+	if (x1 > info->var.xres || x2 > info->var.xres ||
+	    y1 > info->var.yres || y2 > info->var.yres || x2 <=3D x1)
+		return;
+
+	/* Copy the dirty rectangle to frame buffer memory */
+	spin_lock_irqsave(&par->docopy_lock, flags);
+	for (j =3D y1; j < y2; j++) {
+		hvfb_docopy(par,
+			    j * info->fix.line_length +
+			    (x1 * screen_depth / 8),
+			    (x2 - x1) * screen_depth / 8);
+	}
+	spin_unlock_irqrestore(&par->docopy_lock, flags);
+
+	/* Refresh */
 	if (par->fb_ready)
-		synthvid_update(info);
+		synthvid_update(info, x1, y1, x2, y2);
+}
=20
-	if (par->update)
-		schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
+/*
+ * Control the on-demand refresh frequency. It schedules a delayed
+ * screen update if it has not yet.
+ */
+static void hvfb_ondemand_refresh_throttle(struct hvfb_par *par,
+					   int x1, int y1, int w, int h)
+{
+	unsigned long flags;
+	int x2 =3D x1 + w;
+	int y2 =3D y1 + h;
+
+	spin_lock_irqsave(&par->delayed_refresh_lock, flags);
+
+	/* Merge dirty rectangle */
+	par->x1 =3D min_t(int, par->x1, x1);
+	par->y1 =3D min_t(int, par->y1, y1);
+	par->x2 =3D max_t(int, par->x2, x2);
+	par->y2 =3D max_t(int, par->y2, y2);
+
+	/* Schedule a delayed screen update if not yet */
+	if (par->delayed_refresh =3D=3D false) {
+		schedule_delayed_work(&par->dwork,
+				      HVFB_ONDEMAND_THROTTLE);
+		par->delayed_refresh =3D true;
+	}
+
+	spin_unlock_irqrestore(&par->delayed_refresh_lock, flags);
 }
=20
 static int hvfb_on_panic(struct notifier_block *nb,
@@ -669,7 +806,8 @@ static int hvfb_on_panic(struct notifier_block *nb,
 	par =3D container_of(nb, struct hvfb_par, hvfb_panic_nb);
 	par->synchronous_fb =3D true;
 	info =3D par->info;
-	synthvid_update(info);
+	hvfb_docopy(par, 0, dio_fb_size);
+	synthvid_update(info, 0, 0, INT_MAX, INT_MAX);
=20
 	return NOTIFY_DONE;
 }
@@ -730,7 +868,10 @@ static void hvfb_cfb_fillrect(struct fb_info *p,
=20
 	cfb_fillrect(p, rect);
 	if (par->synchronous_fb)
-		synthvid_update(p);
+		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
+	else
+		hvfb_ondemand_refresh_throttle(par, rect->dx, rect->dy,
+					       rect->width, rect->height);
 }
=20
 static void hvfb_cfb_copyarea(struct fb_info *p,
@@ -740,7 +881,10 @@ static void hvfb_cfb_copyarea(struct fb_info *p,
=20
 	cfb_copyarea(p, area);
 	if (par->synchronous_fb)
-		synthvid_update(p);
+		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
+	else
+		hvfb_ondemand_refresh_throttle(par, area->dx, area->dy,
+					       area->width, area->height);
 }
=20
 static void hvfb_cfb_imageblit(struct fb_info *p,
@@ -750,7 +894,10 @@ static void hvfb_cfb_imageblit(struct fb_info *p,
=20
 	cfb_imageblit(p, image);
 	if (par->synchronous_fb)
-		synthvid_update(p);
+		synthvid_update(p, 0, 0, INT_MAX, INT_MAX);
+	else
+		hvfb_ondemand_refresh_throttle(par, image->dx, image->dy,
+					       image->width, image->height);
 }
=20
 static struct fb_ops hvfb_ops =3D {
@@ -809,6 +956,9 @@ static int hvfb_getmem(struct hv_device *hdev, struct f=
b_info *info)
 	resource_size_t pot_start, pot_end;
 	int ret;
=20
+	dio_fb_size =3D
+		screen_width * screen_height * screen_depth / 8;
+
 	if (gen2vm) {
 		pot_start =3D 0;
 		pot_end =3D -1;
@@ -843,9 +993,14 @@ static int hvfb_getmem(struct hv_device *hdev, struct =
fb_info *info)
 	if (!fb_virt)
 		goto err2;
=20
+	/* Allocate memory for deferred IO */
+	par->dio_vp =3D vzalloc(round_up(dio_fb_size, PAGE_SIZE));
+	if (par->dio_vp =3D=3D NULL)
+		goto err3;
+
 	info->apertures =3D alloc_apertures(1);
 	if (!info->apertures)
-		goto err3;
+		goto err4;
=20
 	if (gen2vm) {
 		info->apertures->ranges[0].base =3D screen_info.lfb_base;
@@ -857,16 +1012,23 @@ static int hvfb_getmem(struct hv_device *hdev, struc=
t fb_info *info)
 		info->apertures->ranges[0].size =3D pci_resource_len(pdev, 0);
 	}
=20
+	/* Physical address of FB device */
+	par->mmio_pp =3D par->mem->start;
+	/* Virtual address of FB device */
+	par->mmio_vp =3D (unsigned char *) fb_virt;
+
 	info->fix.smem_start =3D par->mem->start;
-	info->fix.smem_len =3D screen_fb_size;
-	info->screen_base =3D fb_virt;
-	info->screen_size =3D screen_fb_size;
+	info->fix.smem_len =3D dio_fb_size;
+	info->screen_base =3D par->dio_vp;
+	info->screen_size =3D dio_fb_size;
=20
 	if (!gen2vm)
 		pci_dev_put(pdev);
=20
 	return 0;
=20
+err4:
+	vfree(par->dio_vp);
 err3:
 	iounmap(fb_virt);
 err2:
@@ -884,6 +1046,7 @@ static void hvfb_putmem(struct fb_info *info)
 {
 	struct hvfb_par *par =3D info->par;
=20
+	vfree(par->dio_vp);
 	iounmap(info->screen_base);
 	vmbus_free_mmio(par->mem->start, screen_fb_size);
 	par->mem =3D NULL;
@@ -909,6 +1072,12 @@ static int hvfb_probe(struct hv_device *hdev,
 	init_completion(&par->wait);
 	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
=20
+	par->delayed_refresh =3D false;
+	spin_lock_init(&par->delayed_refresh_lock);
+	spin_lock_init(&par->docopy_lock);
+	par->x1 =3D par->y1 =3D INT_MAX;
+	par->x2 =3D par->y2 =3D 0;
+
 	/* Connect to VSP */
 	hv_set_drvdata(hdev, info);
 	ret =3D synthvid_connect_vsp(hdev);
@@ -960,6 +1129,10 @@ static int hvfb_probe(struct hv_device *hdev,
 	info->fbops =3D &hvfb_ops;
 	info->pseudo_palette =3D par->pseudo_palette;
=20
+	/* Initialize deferred IO */
+	info->fbdefio =3D &synthvid_defio;
+	fb_deferred_io_init(info);
+
 	/* Send config to host */
 	ret =3D synthvid_send_config(hdev);
 	if (ret)
@@ -981,6 +1154,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	return 0;
=20
 error:
+	fb_deferred_io_cleanup(info);
 	hvfb_putmem(info);
 error2:
 	vmbus_close(hdev->channel);
@@ -1003,6 +1177,8 @@ static int hvfb_remove(struct hv_device *hdev)
 	par->update =3D false;
 	par->fb_ready =3D false;
=20
+	fb_deferred_io_cleanup(info);
+
 	unregister_framebuffer(info);
 	cancel_delayed_work_sync(&par->dwork);
=20
--=20
2.20.1

