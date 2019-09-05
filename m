Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3669A9DE9
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2019 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfIEJMA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 05:12:00 -0400
Received: from mail-eopbgr700111.outbound.protection.outlook.com ([40.107.70.111]:8801
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731167AbfIEJMA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 05:12:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmnpinzOu7HCXmxO2qL2UjzIPIYTxYpWUzldSPiPLOpbEyJxSc3ZTcitOMaZ0xM0/bAcPIL/f8BxsMQlNeh+mFCXrPfnY8mKM9NdLdoMolw8IxfzteDnHcee65tXgFeVSa/8hKn3axSV9QjWHdBXaM5fxXx4f6JbW1RYmHFujBgM9UF01FxajGt9eB52lKj7Jq/DgXNaaF9Bwp9zWh/p8lragmhHND0fMn25wbEu63RpkO01Bc8012x/silofibgy+dn64Vhd6/L12oRBunX4y8/kjNqHvQTCxdCSPiZDx68JXKszTSFS7H+DtjUxNaiA39MXCpG3qiTu2Ix4BwScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYMSQEz4Sv3yFw5DMmmsO3ZS25FSsCuxpgxZvYGJ7l8=;
 b=GNRVWNyZrkWJFJmPFvRq7bpkhZCK+TQq2kPX3F/yzyb2ktyUDMPRm+miFAPj70TC7zVfFCJuaVyA1u7/RGHypAa9QNJMan6HFIlbtvyn5FO3dyBvVz6/r5MX1wlhUWe1G8Zt/wjlYmo3cDL8IFTwB2T7/yw56DclxPRQ6YBP+EUbsh3HQ+A/FqOsNhB33jeeYj6QNihgPHbVLSmjBicxjD+3EM4EgU0rEa6+5GcqDX4zfYIWDRHrDLugdZJfWo3RTJV2qjRXsBTD20xyoXHUqf/cuQ5qDHYuDw4cB8BqjrVfIp/5qg63I2tXiNJbFXC8NODekU1aj1uYT32xve5e/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYMSQEz4Sv3yFw5DMmmsO3ZS25FSsCuxpgxZvYGJ7l8=;
 b=ag2HyVRicoG2RH9WoapKIBUNq1rQFauUVOounD8a/MNC0uSpwMZm4pRdgDjmoj1PGni2cJ/7UmJR5H32rFwYt419g7Xg0yppzRiRxQJm77I3/LdkghlJ6etRBKe0TfjdtTjqLXw+c79zzwwpGljvqPxDRAkbMpruXh3r5N+hjHE=
Received: from DM6PR21MB1401.namprd21.prod.outlook.com (10.255.109.88) by
 DM6PR21MB1321.namprd21.prod.outlook.com (20.179.53.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Thu, 5 Sep 2019 09:11:53 +0000
Received: from DM6PR21MB1401.namprd21.prod.outlook.com
 ([fe80::bd0e:e64e:a357:3759]) by DM6PR21MB1401.namprd21.prod.outlook.com
 ([fe80::bd0e:e64e:a357:3759%5]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 09:11:53 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     Wei Hu <weh@microsoft.com>, Iouri Tarassov <iourit@microsoft.com>
Subject: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution from
 Hyper-V host
Thread-Topic: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Index: AQHVY8n1ZHStyEKyQEWtq6qT8x1cIg==
Date:   Thu, 5 Sep 2019 09:11:53 +0000
Message-ID: <20190905091120.16761-1-weh@microsoft.com>
Reply-To: Wei Hu <weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0119.apcprd06.prod.outlook.com
 (2603:1096:1:1d::21) To DM6PR21MB1401.namprd21.prod.outlook.com
 (2603:10b6:5:22d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [167.220.255.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc7c4b5e-f1cd-4322-7be5-08d731e1176c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1321;
x-ms-traffictypediagnostic: DM6PR21MB1321:|DM6PR21MB1321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB13210DB90EF1141B5AAEF14BBBBB0@DM6PR21MB1321.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(6486002)(186003)(102836004)(7736002)(8676002)(14454004)(81166006)(81156014)(99286004)(6506007)(386003)(50226002)(3450700001)(43066004)(10290500003)(2501003)(66446008)(64756008)(66556008)(66476007)(66946007)(256004)(14444005)(10090500001)(8936002)(6636002)(478600001)(486006)(476003)(26005)(2616005)(52116002)(305945005)(4326008)(25786009)(6116002)(3846002)(6512007)(107886003)(2906002)(2201001)(316002)(110136005)(54906003)(86362001)(71200400001)(66066001)(71190400001)(22452003)(53936002)(6436002)(1076003)(36756003)(1511001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1321;H:DM6PR21MB1401.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nsbu6x50dRnmZEMoKmmhbfXet+LFs3QiCg3JtI9ZJWXl06e4WK4Qg3XyRnPRfPJSroh1n0IuZnUsrNzGer1YEozhoBjKTSAZwXBT01tdeIf0JinOYctm3EsRZpDse2jCxiLsR9iQ9q2sm5nSYTccwFWeJ8CvLASZjoHb3lilNudQDErOLYwqycG5SbsHzUEg/4qKG1B9s7+QPeUz2d1C0WmHCdxlWVCM2wZttepT+zctKpb8fDvgIDKYo6/xG+9zrluEK6OE9t6BFtXOG/5tuxNDxi+Ne+BwDrsWz74O+0+4wEPmtHz+KLE+PAtVGjilbtF05RhA2oo9atswVDJJLeJ+pDdfSYKuGvABv09TcEXVePLW7eA4eafARJmFmNZ0V9fasF4s1f4Eshpd4WoeF3dLaeFqRU641pG374tebQE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7c4b5e-f1cd-4322-7be5-08d731e1176c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 09:11:53.0515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0YFQZow2pzVKMZEQXa60m+exehBYGz71DzdOxbVo2jmT6+Co3M4CV4IRqqOeoaZZFmeHrBSQsyIlyqiQwTW3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1321
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Beginning from Windows 10 RS5+, VM screen resolution is obtained from host.
The "video=3Dhyperv_fb" boot time option is not needed, but still can be
used to overwrite what the host specifies. The VM resolution on the host
could be set by executing the powershell "set-vmvideo" command.

Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
Signed-off-by: Wei Hu <weh@microsoft.com>
---
    v2:
    - Implemented fallback when version negotiation failed.
    - Defined full size for supported_resolution array.

    v3:
    - Corrected the synthvid major and minor version comparison problem.

    v4:
    - Changed function name to synthvid_ver_ge().

 drivers/video/fbdev/hyperv_fb.c | 159 +++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_f=
b.c
index 00f5bdcc6c6f..fe319fc39bec 100644
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
@@ -44,6 +52,10 @@
 #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
+#define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
+
+#define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
+#define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
=20
 #define SYNTHVID_DEPTH_WIN7 16
 #define SYNTHVID_DEPTH_WIN8 32
@@ -82,16 +94,25 @@ enum synthvid_msg_type {
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
@@ -102,6 +123,19 @@ struct synthvid_version_resp {
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
@@ -187,6 +221,8 @@ struct synthvid_msg {
 		struct synthvid_pointer_shape ptr_shape;
 		struct synthvid_feature_change feature_chg;
 		struct synthvid_dirt dirt;
+		struct synthvid_supported_resolution_req resolution_req;
+		struct synthvid_supported_resolution_resp resolution_resp;
 	};
 } __packed;
=20
@@ -224,6 +260,8 @@ struct hvfb_par {
=20
 static uint screen_width =3D HVFB_WIDTH;
 static uint screen_height =3D HVFB_HEIGHT;
+static uint screen_width_max =3D HVFB_WIDTH;
+static uint screen_height_max =3D HVFB_HEIGHT;
 static uint screen_depth;
 static uint screen_fb_size;
=20
@@ -354,6 +392,7 @@ static void synthvid_recv_sub(struct hv_device *hdev)
=20
 	/* Complete the wait event */
 	if (msg->vid_hdr.type =3D=3D SYNTHVID_VERSION_RESPONSE ||
+	    msg->vid_hdr.type =3D=3D SYNTHVID_RESOLUTION_RESPONSE ||
 	    msg->vid_hdr.type =3D=3D SYNTHVID_VRAM_LOCATION_ACK) {
 		memcpy(par->init_buf, msg, MAX_VMBUS_PKT_SIZE);
 		complete(&par->wait);
@@ -400,6 +439,17 @@ static void synthvid_receive(void *ctx)
 	} while (bytes_recvd > 0 && ret =3D=3D 0);
 }
=20
+/* Check if the ver1 version is equal or greater than ver2 */
+static inline bool synthvid_ver_ge(u32 ver1, u32 ver2)
+{
+	if (SYNTHVID_VER_GET_MAJOR(ver1) > SYNTHVID_VER_GET_MAJOR(ver2) ||
+	    (SYNTHVID_VER_GET_MAJOR(ver1) =3D=3D SYNTHVID_VER_GET_MAJOR(ver2) &&
+	     SYNTHVID_VER_GET_MINOR(ver1) >=3D SYNTHVID_VER_GET_MINOR(ver2)))
+		return true;
+
+	return false;
+}
+
 /* Check synthetic video protocol version with the host */
 static int synthvid_negotiate_ver(struct hv_device *hdev, u32 ver)
 {
@@ -428,6 +478,64 @@ static int synthvid_negotiate_ver(struct hv_device *hd=
ev, u32 ver)
 	}
=20
 	par->synthvid_version =3D ver;
+	pr_info("Synthvid Version major %d, minor %d\n",
+		SYNTHVID_VER_GET_MAJOR(ver), SYNTHVID_VER_GET_MINOR(ver));
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
@@ -448,11 +556,27 @@ static int synthvid_connect_vsp(struct hv_device *hde=
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
@@ -464,6 +588,12 @@ static int synthvid_connect_vsp(struct hv_device *hdev=
)
 	else
 		screen_depth =3D SYNTHVID_DEPTH_WIN8;
=20
+	if (synthvid_ver_ge(par->synthvid_version, SYNTHVID_VERSION_WIN10)) {
+		ret =3D synthvid_get_supported_resolution(hdev);
+		if (ret)
+			pr_info("Failed to get supported resolution from host, use default\n");
+	}
+
 	screen_fb_size =3D hdev->channel->offermsg.offer.
 				mmio_megabytes * 1024 * 1024;
=20
@@ -653,6 +783,8 @@ static void hvfb_get_option(struct fb_info *info)
 	}
=20
 	if (x < HVFB_WIDTH_MIN || y < HVFB_HEIGHT_MIN ||
+	    (synthvid_ver_ge(par->synthvid_version, SYNTHVID_VERSION_WIN10) &&
+	    (x > screen_width_max || y > screen_height_max)) ||
 	    (par->synthvid_version =3D=3D SYNTHVID_VERSION_WIN8 &&
 	     x * y * screen_depth / 8 > SYNTHVID_FB_SIZE_WIN8) ||
 	    (par->synthvid_version =3D=3D SYNTHVID_VERSION_WIN7 &&
@@ -689,8 +821,12 @@ static int hvfb_getmem(struct hv_device *hdev, struct =
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
@@ -781,17 +917,16 @@ static int hvfb_probe(struct hv_device *hdev,
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

