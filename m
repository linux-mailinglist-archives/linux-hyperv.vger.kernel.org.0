Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1310B0614
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfIKXjD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:39:03 -0400
Received: from mail-eopbgr770133.outbound.protection.outlook.com ([40.107.77.133]:6560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729483AbfIKXjC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx8AI1+4bG6JPGuPTGyfOE5ReNVvBsB8RHqY/2Dt5+P7Yn2zDadH84CtvHv4LKGAQHuA976pAWuza82twrE0NjsuZffs6Srkl+eLqD2H5JViFAHyFQAobC1WYEOG65npZ0zF9k3qH1UGWUFtj71m9UxNpCCw/dfZczZGE4jBWykcOviQaTmUb1X7LuJpHp81r4+FOIQWJlGmt328HvKDgCdNcx4g2/XqS/Om+XgoRLO+4deASZoJoEyD3rDrttnwO9l6ONA0/BhJ7T2iKu6Q/7V4hy1cznoavz8hjyFA476SJ2jPqdSkTFhTyE93zTXVtSSWT2Ogda2Y401hx+FI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0a8YT9qYnTSQd07OZoRLmu9Rs90WdyruX3T4r75af0=;
 b=BI5lLVOSD7uDxgA45BWPmIqFZJ3XFxu5uKggxfGTmZoclFVGuvz3W/mztnUugtoIowhtPDEKIXTkWy3zJRyfEjokpXjaOtGfpY9rqdKkQj8vX2XwIfiRkLmY0iZo/83YY+VsyvIQd1DvbgJZcF5W6wtgaI2MccM/Yzd2/gN0zVP54vOzVInKXoIs6QM0/BVNXx9e48SrAQ7jlC40f4ef/FAxF6epf4y9GbSjH45TuZmrCJLvPV24+PXBTIGJpl+h/vO0djeEg7BkwRGAQtSHmC83vR9atdoZSkJTRmvfxl2ueY2sI7jEicXaa6BGGrI7fv3+iiXn82Gmdyynt/JNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0a8YT9qYnTSQd07OZoRLmu9Rs90WdyruX3T4r75af0=;
 b=KtaVDLaSA3NwNmugHBC4kLJQTaIoK9Lfsttd+432ZY/Y/OHkZmi+5U9G8xvM0r5xjStlzPsgh8Lgc+tizJz0N0iQFndPa1nnxrXVsAw2Uy0liPO43Do/YgRDTNbLDAr+l0OnU5NH6/+7CEWJakxC9J25BrcF3Rt0FOpKiYJhS1s=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:39:00 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:39:00 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 3/3] hv_utils: Support host-initiated restart request
Thread-Topic: [PATCH 3/3] hv_utils: Support host-initiated restart request
Thread-Index: AQHVaPoWJ9Nerb38pEGczASsy3S74w==
Date:   Wed, 11 Sep 2019 23:39:00 +0000
Message-ID: <1568245130-70712-4-git-send-email-decui@microsoft.com>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568245130-70712-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:300:c0::33) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d56f99b-2290-4f50-8bfc-08d7371138e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB090984F87983728A72E656FEBFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(446003)(11346002)(3450700001)(6512007)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(76176011)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XHuPbetlaQghEffJwKw4EKSsQjtB8w5onwFIm779JwB7NsVM2EDqgcmISkBOY8Q2NfZoA/IUbNSEQ+q5V02vXAL2FAOU35NYUQsoUSk2fr/HKQWqxRoZWlE8s+NS00uZ50N9t/gleZvX8YFZz65Ox75jI8x/CCK7iAjvePkNJ/PbkY5mgGDnCQxzsTnYhQOOkBYx+Xmx+TADmbRv5AlNEOiBLQD3b32mo71/MrxAvBtcMQqMYEvcXQTbWQyHua/Zj61MmouIr9g5zNl9JOwZ+2q28cdi4t+r0iuF9x3U9cRNFBXyMqBfwg13C2C5sqpLr0qbcLgtEYkzR6T/YR1bXDqReNXJAkGI8mRDEcSgNEefKx8Whz3e2bDAFCjJW4wYu6Tf+uVWtnsrpX8fjPtfe1GlMoC2dEPxyZIzEXqH3QM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d56f99b-2290-4f50-8bfc-08d7371138e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:39:00.7005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWuacxTesW92bS7Gl8aOSa15sNghPxGoEeP9+oAXQL0KXr7EJENzLkneqoZSCBsThla0VQhcr2ktzd5gxNTCsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

To test the code, we should run this command on the host:

Restart-VM $vm -Type Reboot

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_util.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 9e98c5d..6d642f5 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -24,7 +24,9 @@
=20
 #define SD_MAJOR	3
 #define SD_MINOR	0
+#define SD_MINOR_1	1
 #define SD_MINOR_2	2
+#define SD_VERSION_3_1	(SD_MAJOR << 16 | SD_MINOR_1)
 #define SD_VERSION_3_2	(SD_MAJOR << 16 | SD_MINOR_2)
 #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
=20
@@ -52,9 +54,10 @@
 static int ts_srv_version;
 static int hb_srv_version;
=20
-#define SD_VER_COUNT 3
+#define SD_VER_COUNT 4
 static const int sd_versions[] =3D {
 	SD_VERSION_3_2,
+	SD_VERSION_3_1,
 	SD_VERSION,
 	SD_VERSION_1
 };
@@ -147,6 +150,11 @@ static void perform_shutdown(struct work_struct *dummy=
)
 	orderly_poweroff(true);
 }
=20
+static void perform_restart(struct work_struct *dummy)
+{
+	orderly_reboot();
+}
+
 static void perform_hibernation(struct work_struct *dummy)
 {
 	/*
@@ -175,6 +183,11 @@ static void perform_hibernation(struct work_struct *du=
mmy)
 static DECLARE_WORK(shutdown_work, perform_shutdown);
=20
 /*
+ * Perform the restart operation in a thread context.
+ */
+static DECLARE_WORK(restart_work, perform_restart);
+
+/*
  * Perform the hibernation operation in a thread context.
  */
 static DECLARE_WORK(hibernate_work, perform_hibernation);
@@ -222,6 +235,14 @@ static void shutdown_onchannelcallback(void *context)
 				pr_info("Shutdown request received -"
 					    " graceful shutdown initiated\n");
 				break;
+			case 2:
+			case 3:
+				pr_info("Restart request received -"
+					    " graceful restart initiated\n");
+				icmsghdrp->status =3D HV_S_OK;
+
+				schedule_work(&restart_work);
+				break;
 			case 4:
 			case 5:
 				pr_info("Hibernation request received -"
--=20
1.8.3.1

