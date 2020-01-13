Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494E6138BD8
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 07:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgAMGbw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 01:31:52 -0500
Received: from mail-eopbgr1300094.outbound.protection.outlook.com ([40.107.130.94]:43648
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgAMGbw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 01:31:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsCGIt+t+tLM95eDRcpjucGiImtNBmuyLtPU8ARtnEE2Evvo6+VifsQjxs3z3Y+7CIFGtTk+nSFm1qgFZd6S4hQR2SFOOB7hU0T+eIVpIz+rPeHds6JswIjAVA+tPFTQRggOsE6R6lpuYnP8b6o+MEx0Ix8pUoOXkGLWgPvIHMuXp9xq01rfc5w2zEkRfAidUrSpsD6718cAZB/C3DkG4Uv4BxdiBgCTheM/BT9sBenfj+355mXaXDft1esHVtyql6dPN2dEr066SW4zKdt2IPrmFs8kVfFhnl9rjZ0GeOr70ua00720TMCabgvA2f1rgYijziFj47s9Ju4NqqAHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShsWVrNuBJhiyecvHlqM/cC4Qjs+35HaOw8ORiNvKuk=;
 b=TAZN37X1IryQt5y5AhzI7RkpqHkQynCSn5e0/rcGxZuNbxCXMF7hgMZHTL+ZDDYPahErKJVmIAqYW2PZqM1kClE6V4VzvnkKAn9JJNtoHeaVBUjnoHaVlFAQd/MK5DL7xhEoF+GB96F5KSaA5XUmWAkaolkqxy9uq2cVt06jl6JSBMkMYD8j2oQEqZNGO661dNiDKeaiNxmoyoTMZxzmIiiPoQl2O+JglWwybgEMt5SEmgu7Ouzb+8QGtI94+o4hBuDnOvxcryrmKGXYuTR6lFEIvd5OuklUfUhF1iDycRKc42L9iUBxENGUpYlInekRCqOi2V2JAqBP0Kdk09ijmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShsWVrNuBJhiyecvHlqM/cC4Qjs+35HaOw8ORiNvKuk=;
 b=aSwt0J+aHzMUOH7K1p2tGsAWa6ViQAHdSsjUqwrj+T6/Xfx0Tc1/zS26NXsBjx3P61wEwNKtJ9HeFkVSDdOOX7JJKDT8Iqtu2c79t01ELGqeLO27kCaCsmRYdhX+TrWx79gj9cJPMUdZIpgG/s9PRVJmUhpD59z4m/P9EbzONHw=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0324.APCP153.PROD.OUTLOOK.COM (52.132.237.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.2; Mon, 13 Jan 2020 06:31:44 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7%7]) with mapi id 15.20.2644.014; Mon, 13 Jan 2020
 06:31:44 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] hv_utils: Support host-initiated hibernation request
Thread-Topic: [PATCH v2 3/4] hv_utils: Support host-initiated hibernation
 request
Thread-Index: AdXJ2xmWH7nlZvI9QtW52nKT4iLjSA==
Date:   Mon, 13 Jan 2020 06:31:43 +0000
Message-ID: <HK0P153MB0148FDF9A3AF2352544E6DADBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:31:42.4306444Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90e4698e-3fc7-43d3-857c-c415f1813480;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:fa69:ae29:32b9:aa46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65375c6b-cac3-4df2-b48c-08d797f24236
x-ms-traffictypediagnostic: HK0P153MB0324:|HK0P153MB0324:|HK0P153MB0324:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB032461ADD6748A8606FA5E48BF350@HK0P153MB0324.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(5660300002)(10290500003)(33656002)(186003)(7696005)(86362001)(2906002)(6506007)(52536014)(478600001)(81166006)(81156014)(110136005)(316002)(76116006)(8936002)(9686003)(64756008)(55016002)(8990500004)(66556008)(66476007)(66946007)(66446008)(8676002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0324;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OmG+h/F+4Gscu846AaWe5sycTdBz3KO1da4nzcKANzI2EDjp0y9bAYmXzuQrKJOnBPShtiw5LRN5BFcCqGH7Xb8QX7VCUkFX0KerL+OLeRKRx4sBdsTppiWoFCX8fjDMqnoTXLjBMkwiy/zYdeDedRWl2vDcAli7XZMqSjPLXnYckpdscKvsu5Zdo6nlasEqEWcvwPbj0h8gHaiXZCoEm3lcBR8GOgBTcmZOteKGzEpGbwn2Yu9E7oHpFBuuftJCK2DJEaCoDSw1U6vQFvhEGhtheNCKw1ARoRhWQmG3gWj80WboKqbEmlATDmtWNY1x7JxcL30HcYDgZYjSq5jEfM9SkpX4BPG900MQWoEpmWRTces0gs7FmfnAO9VtjcCPIx5AklxSA0i9WlmyiaMxC5hqpUa9F6Os7TnykZD+60LeaV0PUEciysuywSVvy5yw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65375c6b-cac3-4df2-b48c-08d797f24236
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 06:31:44.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1GauCUw/7DNasmx2cmGel2IJ1iaAZ0feLwz3Wpa4AYkVTv6NTXgyJzc2Q1TkcujtemE5UqHBj8Emk5OYZSvLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0324
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Update the Shutdown IC version to 3.2, which is required for the host to
send the hibernation request.

The user is expected to create the below udev rule file, which is applied
upon the host-initiated hibernation request:

root@localhost:~# cat /usr/lib/udev/rules.d/40-vm-hibernation.rules
SUBSYSTEM=3D=3D"vmbus", ACTION=3D=3D"change", DRIVER=3D=3D"hv_utils", ENV{E=
VENT}=3D=3D"hibernate", RUN+=3D"/usr/bin/systemctl hibernate"

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_util.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index fe3a316380c2..d5216af62788 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -25,7 +25,9 @@
 #define SD_MAJOR	3
 #define SD_MINOR	0
 #define SD_MINOR_1	1
+#define SD_MINOR_2	2
 #define SD_VERSION_3_1	(SD_MAJOR << 16 | SD_MINOR_1)
+#define SD_VERSION_3_2	(SD_MAJOR << 16 | SD_MINOR_2)
 #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
=20
 #define SD_MAJOR_1	1
@@ -52,9 +54,10 @@ static int sd_srv_version;
 static int ts_srv_version;
 static int hb_srv_version;
=20
-#define SD_VER_COUNT 3
+#define SD_VER_COUNT 4
 static const int sd_versions[] =3D {
 	SD_VERSION_3_1,
+	SD_VERSION_3_2,
 	SD_VERSION,
 	SD_VERSION_1
 };
@@ -78,9 +81,45 @@ static const int fw_versions[] =3D {
 	UTIL_WS2K8_FW_VERSION
 };
=20
+/*
+ * Send the "hibernate" udev event in a thread context.
+ */
+struct hibernate_work_context {
+	struct work_struct work;
+	struct hv_device *dev;
+};
+
+static struct hibernate_work_context hibernate_context;
+static bool execute_hibernate;
+
+static void send_hibernate_uevent(struct work_struct *work)
+{
+	char *uevent_env[2] =3D { "EVENT=3Dhibernate", NULL };
+	struct hibernate_work_context *ctx;
+
+	ctx =3D container_of(work, struct hibernate_work_context, work);
+
+	kobject_uevent_env(&ctx->dev->device.kobj, KOBJ_CHANGE, uevent_env);
+
+	pr_info("Sent hibernation uevent\n");
+}
+
+static int hv_shutdown_init(struct hv_util_service *srv)
+{
+	struct vmbus_channel *channel =3D srv->channel;
+
+	INIT_WORK(&hibernate_context.work, send_hibernate_uevent);
+	hibernate_context.dev =3D channel->device_obj;
+
+	execute_hibernate =3D hv_is_hibernation_supported();
+
+	return 0;
+}
+
 static void shutdown_onchannelcallback(void *context);
 static struct hv_util_service util_shutdown =3D {
 	.util_cb =3D shutdown_onchannelcallback,
+	.util_init =3D hv_shutdown_init,
 };
=20
 static int hv_timesync_init(struct hv_util_service *srv);
@@ -187,6 +226,17 @@ static void shutdown_onchannelcallback(void *context)
=20
 				schedule_work(&restart_work);
 				break;
+			case 4:
+			case 5:
+				pr_info("Hibernation request received\n");
+
+				if (execute_hibernate) {
+					icmsghdrp->status =3D HV_S_OK;
+					schedule_work(&hibernate_context.work);
+				} else {
+					icmsghdrp->status =3D HV_E_FAIL;
+				}
+				break;
 			default:
 				icmsghdrp->status =3D HV_E_FAIL;
 				execute_shutdown =3D false;
--=20
2.19.1

