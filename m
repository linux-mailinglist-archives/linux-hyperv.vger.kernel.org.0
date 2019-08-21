Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2B977BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Aug 2019 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfHULKs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 07:10:48 -0400
Received: from mail-eopbgr790127.outbound.protection.outlook.com ([40.107.79.127]:13408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfHULKs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 07:10:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDjYDoRPtThWxZ+tPPrKYvKNGxN83h11AC6g2e3J5mCZOYjwqOk+prynvWeVMznM0TMrfOr5ZNilRJq0kp7AXxMb8l4VCgzffFjJM887js0hP+iHIjAHxD53ujZPAd0BBPAxBWk4uTYP3VA4wWV8fVhw+gmN7bnzDKAMdXFnMz/Vnw/YuTWI1JdzIwX7MUgHXh8H4/tc0acZ3jq7w45ekSadLWSGo3lZy/iFDHNpe6tzByVQygydwqg0oIiu4HVnplaVsdBMiboUgda22ICM7Of2cjrIxVqFLrzHJ7UGqc/Yay09l10nxQ1P8GTHm5foVYEJemU5hQE8u3B6aM19nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFwqJqmi3VWlAjKn8bGhvKp40LtK6G3E/qCkg7LgE18=;
 b=OWd1coSs3GB2HXbnwmow7ePxEW+OTSAbJstXJSgIQn5emaEkCxnEN417yFX0Aer3MfK5DYITyRo6DIJw8YikSkhw4E3gyt/ogY8O69Yl3oOKZ8PrJGKjXMf8rKHYnPJN8D1tI3tQhcp6rGMA+YxYYhGEzDejHVXfEuyfaGeTyrncx7bEXmVMMVXwrOUoy+LHhWGSQ52qZvhFwOLvmwgy41CWiXWcIus5Rw4EBFBpjNe7aJSXVwvaF0J+iULv8zO5uoDM/pB8OWOJu2sEt0IrJfhHtShFyb3a1NL/yq4axhui4GjE5QTPqzlQ/QX4BLNK4AWsIvAJ1uiIg9QXiebToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFwqJqmi3VWlAjKn8bGhvKp40LtK6G3E/qCkg7LgE18=;
 b=GILnvQVB2ZY7zlY+IkNdBfoKQS8UblnPt3k/a6luhyfRHMETscPWuOt/f7Swz0UGZempRoEndZJzdrZD5z7XMS4euNOncBqbm5yRIsFggH2goRxgrwkDAE3n7NxR+0jABNrsDyY+PJiSw/HaLE+Zdqs71N7OL1p5Xr22kc9Ns7c=
Received: from DM6PR21MB1401.namprd21.prod.outlook.com (10.255.109.88) by
 DM6PR21MB1354.namprd21.prod.outlook.com (20.179.53.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Wed, 21 Aug 2019 11:10:44 +0000
Received: from DM6PR21MB1401.namprd21.prod.outlook.com
 ([fe80::bd0e:e64e:a357:3759]) by DM6PR21MB1401.namprd21.prod.outlook.com
 ([fe80::bd0e:e64e:a357:3759%5]) with mapi id 15.20.2220.000; Wed, 21 Aug 2019
 11:10:44 +0000
From:   Wei Hu <weh@microsoft.com>
To:     "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Wei Hu <weh@microsoft.com>, Iouri Tarassov <iourit@microsoft.com>
Subject: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution from
 Hyper-V host
Thread-Topic: [PATCH v2] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Index: AQHVWBETUUvEuW2UmUKx6Ya3YUCalA==
Date:   Wed, 21 Aug 2019 11:10:43 +0000
Message-ID: <20190821111007.3490-1-weh@microsoft.com>
Reply-To: Wei Hu <weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To DM6PR21MB1401.namprd21.prod.outlook.com
 (2603:10b6:5:22d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [167.220.255.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22874b3d-3415-4969-3f5c-08d7262835b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1354;
x-ms-traffictypediagnostic: DM6PR21MB1354:|DM6PR21MB1354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB1354F03140DB4DF678328D9CBBAA0@DM6PR21MB1354.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(25786009)(14454004)(66446008)(66476007)(66556008)(64756008)(66946007)(186003)(52116002)(1076003)(10090500001)(6512007)(36756003)(305945005)(6436002)(2616005)(10290500003)(476003)(99286004)(6116002)(3846002)(66066001)(1511001)(6486002)(386003)(102836004)(2501003)(26005)(486006)(6636002)(5660300002)(2906002)(7736002)(478600001)(107886003)(6506007)(71200400001)(3450700001)(53936002)(86362001)(2201001)(8936002)(22452003)(8676002)(71190400001)(256004)(14444005)(110136005)(81166006)(81156014)(4326008)(54906003)(43066004)(50226002)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1354;H:DM6PR21MB1401.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tbbtsrzJjSw236iAmqTDh3kGR1OwEp3bWxGHdXJHPLc5s5kR7N5Kqrnwkan4wvIRHxVjg/mQBpq+uGjFlNXzOpMrrfNwZOqAcjKW0y16bzzDln1UTjEA8R3eQ+feAOrUPRjo2oszovCp0kn1SPSc5IPf30aqgO598JUsaW6OLjj2S4dCBUg8gOCk42buRb59C2sDY3ty1Qu9yVN5gnmgzlUH0UMAW29tOOJzJZyGxJrhbH/AR+KqaYl1pVmHyBl9t5fagdQDbyAzJVfT5w96bPwensu3z2n05iDJpkib1LNxLYRWiQGZLKoj0Htz2BNsM+ZpY9oaUq4NH6Ii8I2iovhvO54ZCEf3bjnq6YFxxXPBjLZRzAg/msrj3uuiwyZU6nyV/fH6dZueZPhHZ1d9WumIFHNQOA6izjDDvbnW2cE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22874b3d-3415-4969-3f5c-08d7262835b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 11:10:43.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8KDqmbqgXl/lBH282OUDjt0U7gZO80nwkuFCZzXQZtFNsLaERUdwcY/gXTrQZd2rd/w48WZ9f1bL1UsaGH6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1354
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Beginning from Windows 10 RS5+, VM screen resolution is obtained from host.
The "video=3Dhyperv_fb" boot time option is not needed, but still can be
used to overwrite what the host specifies. The VM resolution on the host
could be set by executing the powershell "set-vmvideo" command.

v2:
- Implemented fallback when version negotiation failed.
- Defined full size for supported_resolution array.

Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
Signed-off-by: Wei Hu <weh@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/video/fbdev/hyperv_fb.c | 145 +++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_f=
b.c
index 00f5bdcc6c6f..2ca400c0d621 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -23,6 +23,14 @@
  *
  * Portrait orientation is also supported:
  *     For example: video=3Dhyperv_fb:864x1152
+ *
+ * When a Windows 10 RS5+ host is used, the virtual machine screen
+ * resolution is obtained from the host. The "video=3Dhyperv_fb" option is
+ * not needed, but still can be used to overwrite what the host specifies.
+ * The VM resolution on the host could be set by executing the powershell
+ * "set-vmvideo" command. For example
+ *     set-vmvideo -vmname name -horizontalresolution:1920 \
+ * -verticalresolution:1200 -resolutiontype single
  */
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -44,6 +52,7 @@
 #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
+#define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
=20
 #define SYNTHVID_DEPTH_WIN7 16
 #define SYNTHVID_DEPTH_WIN8 32
@@ -82,16 +91,25 @@ enum synthvid_msg_type {
 	SYNTHVID_POINTER_SHAPE		=3D 8,
 	SYNTHVID_FEATURE_CHANGE		=3D 9,
 	SYNTHVID_DIRT			=3D 10,
+	SYNTHVID_RESOLUTION_REQUEST	=3D 13,
+	SYNTHVID_RESOLUTION_RESPONSE	=3D 14,
=20
-	SYNTHVID_MAX			=3D 11
+	SYNTHVID_MAX			=3D 15
 };
=20
+#define		SYNTHVID_EDID_BLOCK_SIZE	128
+#define		SYNTHVID_MAX_RESOLUTION_COUNT	64
+
+struct hvd_screen_info {
+	u16 width;
+	u16 height;
+} __packed;
+
 struct synthvid_msg_hdr {
 	u32 type;
 	u32 size;  /* size of this header + payload after this field*/
 } __packed;
=20
-
 struct synthvid_version_req {
 	u32 version;
 } __packed;
@@ -102,6 +120,19 @@ struct synthvid_version_resp {
 	u8 max_video_outputs;
 } __packed;
=20
+struct synthvid_supported_resolution_req {
+	u8 maximum_resolution_count;
+} __packed;
+
+struct synthvid_supported_resolution_resp {
+	u8 edid_block[SYNTHVID_EDID_BLOCK_SIZE];
+	u8 resolution_count;
+	u8 default_resolution_index;
+	u8 is_standard;
+	struct hvd_screen_info
+		supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT];
+} __packed;
+
 struct synthvid_vram_location {
 	u64 user_ctx;
 	u8 is_vram_gpa_specified;
@@ -187,6 +218,8 @@ struct synthvid_msg {
 		struct synthvid_pointer_shape ptr_shape;
 		struct synthvid_feature_change feature_chg;
 		struct synthvid_dirt dirt;
+		struct synthvid_supported_resolution_req resolution_req;
+		struct synthvid_supported_resolution_resp resolution_resp;
 	};
 } __packed;
=20
@@ -224,6 +257,8 @@ struct hvfb_par {
=20
 static uint screen_width =3D HVFB_WIDTH;
 static uint screen_height =3D HVFB_HEIGHT;
+static uint screen_width_max =3D HVFB_WIDTH;
+static uint screen_height_max =3D HVFB_HEIGHT;
 static uint screen_depth;
 static uint screen_fb_size;
=20
@@ -354,6 +389,7 @@ static void synthvid_recv_sub(struct hv_device *hdev)
=20
 	/* Complete the wait event */
 	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
+	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
 	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
 		memcpy(par->init_buf, msg, MAX_VMBUS_PKT_SIZE);
 		complete(&par->wait);
@@ -428,6 +464,64 @@ static int synthvid_negotiate_ver(struct hv_device *hd=
ev, u32 ver)
 	}
=20
 	par->synthvid_version =3D ver;
+	pr_info("Synthvid Version major %d, minor %d\n",
+		ver & 0x0000ffff, (ver & 0xffff0000) >> 16);
+
+out:
+	return ret;
+}
+
+/* Get current resolution from the host */
+static int synthvid_get_supported_resolution(struct hv_device *hdev)
+{
+	struct fb_info *info =3D hv_get_drvdata(hdev);
+	struct hvfb_par *par =3D info->par;
+	struct synthvid_msg *msg =3D (struct synthvid_msg *)par->init_buf;
+	int ret =3D 0;
+	unsigned long t;
+	u8 index;
+	int i;
+
+	memset(msg, 0, sizeof(struct synthvid_msg));
+	msg->vid_hdr.type =3D SYNTHVID_RESOLUTION_REQUEST;
+	msg->vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
+		sizeof(struct synthvid_supported_resolution_req);
+
+	msg->resolution_req.maximum_resolution_count =3D
+		SYNTHVID_MAX_RESOLUTION_COUNT;
+	synthvid_send(hdev, msg);
+
+	t =3D wait_for_completion_timeout(&par->wait, VSP_TIMEOUT);
+	if (!t) {
+		pr_err("Time out on waiting resolution response\n");
+			ret =3D -ETIMEDOUT;
+			goto out;
+	}
+
+	if (msg->resolution_resp.resolution_count =3D=3D 0) {
+		pr_err("No supported resolutions\n");
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	index =3D msg->resolution_resp.default_resolution_index;
+	if (index >=3D msg->resolution_resp.resolution_count) {
+		pr_err("Invalid resolution index: %d\n", index);
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	for (i =3D 0; i < msg->resolution_resp.resolution_count; i++) {
+		screen_width_max =3D max_t(unsigned int, screen_width_max,
+		    msg->resolution_resp.supported_resolution[i].width);
+		screen_height_max =3D max_t(unsigned int, screen_height_max,
+		    msg->resolution_resp.supported_resolution[i].height);
+	}
+
+	screen_width =3D
+		msg->resolution_resp.supported_resolution[index].width;
+	screen_height =3D
+		msg->resolution_resp.supported_resolution[index].height;
=20
 out:
 	return ret;
@@ -448,11 +542,27 @@ static int synthvid_connect_vsp(struct hv_device *hde=
v)
 	}
=20
 	/* Negotiate the protocol version with host */
-	if (vmbus_proto_version =3D=3D VERSION_WS2008 ||
-	    vmbus_proto_version =3D=3D VERSION_WIN7)
-		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
-	else
+	switch (vmbus_proto_version) {
+	case VERSION_WIN10:
+	case VERSION_WIN10_V5:
+		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
+		if (!ret)
+			break;
+		/* Fallthrough */
+	case VERSION_WIN8:
+	case VERSION_WIN8_1:
 		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
+		if (!ret)
+			break;
+		/* Fallthrough */
+	case VERSION_WS2008:
+	case VERSION_WIN7:
+		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
+		break;
+	default:
+		ret =3D synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
+		break;
+	}
=20
 	if (ret) {
 		pr_err("Synthetic video device version not accepted\n");
@@ -464,6 +574,12 @@ static int synthvid_connect_vsp(struct hv_device *hdev=
)
 	else
 		screen_depth =3D SYNTHVID_DEPTH_WIN8;
=20
+	if (par->synthvid_version >=3D SYNTHVID_VERSION_WIN10) {
+		ret =3D synthvid_get_supported_resolution(hdev);
+		if (ret)
+			pr_info("Failed to get supported resolution from host, use default\n");
+	}
+
 	screen_fb_size =3D hdev->channel->offermsg.offer.
 				mmio_megabytes * 1024 * 1024;
=20
@@ -653,6 +769,8 @@ static void hvfb_get_option(struct fb_info *info)
 	}
=20
 	if (x < HVFB_WIDTH_MIN || y < HVFB_HEIGHT_MIN ||
+	    (par->synthvid_version >=3D SYNTHVID_VERSION_WIN10 &&
+	    (x > screen_width_max || y > screen_height_max)) ||
 	    (par->synthvid_version =3D=3D SYNTHVID_VERSION_WIN8 &&
 	     x * y * screen_depth / 8 > SYNTHVID_FB_SIZE_WIN8) ||
 	    (par->synthvid_version =3D=3D SYNTHVID_VERSION_WIN7 &&
@@ -689,8 +807,12 @@ static int hvfb_getmem(struct hv_device *hdev, struct =
fb_info *info)
 		}
=20
 		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
-		    pci_resource_len(pdev, 0) < screen_fb_size)
+		    pci_resource_len(pdev, 0) < screen_fb_size) {
+			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
+			       (unsigned long) pci_resource_len(pdev, 0),
+			       (unsigned long) screen_fb_size);
 			goto err1;
+		}
=20
 		pot_end =3D pci_resource_end(pdev, 0);
 		pot_start =3D pot_end - screen_fb_size + 1;
@@ -781,17 +903,16 @@ static int hvfb_probe(struct hv_device *hdev,
 		goto error1;
 	}
=20
+	hvfb_get_option(info);
+	pr_info("Screen resolution: %dx%d, Color depth: %d\n",
+		screen_width, screen_height, screen_depth);
+
 	ret =3D hvfb_getmem(hdev, info);
 	if (ret) {
 		pr_err("No memory for framebuffer\n");
 		goto error2;
 	}
=20
-	hvfb_get_option(info);
-	pr_info("Screen resolution: %dx%d, Color depth: %d\n",
-		screen_width, screen_height, screen_depth);
-
-
 	/* Set up fb_info */
 	info->flags =3D FBINFO_DEFAULT;
=20
--=20
2.20.1

