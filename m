Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D1B0616
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfIKXjH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:39:07 -0400
Received: from mail-eopbgr770133.outbound.protection.outlook.com ([40.107.77.133]:6560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbfIKXjB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9x9pThfFty9XfPJ2KE3yKVunStzBUY87wf/zmEYH1g3U67vqyKSbI4croHdN1aX3xYe5coEVSq8c0WMRJ1Dk568CAXmJdSaklzalBPsWA2yRG2NPun4kKAFSAUyel1d6caa2mRADQtlgc2iS5TMghbMJEnMmbhUxRGcc/ts3q3GQc5Q3qkf0/kBq1TUX24UVhl/6RentcZ1Fkr/k/j9TidxQEUAJYoIMLKliR93UdjbsE7sOHgz73I/QbJYDSFmpnFfQqOcC/L6Zy2p6whdt1ZkF2Z18qWZCj3J/3Wfnx3HsB9yVspxILaE2k66+ibztkuhIdmdhPc4CG5aqRfxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5aSmeOWb0Td5IXAtnWCOJyPQ79flRSOAMu4R91kQjo=;
 b=if5F3+vfmd56L/lNjg8b/WHdtLI1+d4GY5p7m9NnAZ9KEcaKNVoJfRw0FlqyHf8C80InEs85nizI8b8F7gDDhN4cOHVBst5MbnE9GIyZIEsO2rGZ8DoGh1D+lxr+ghfLk/5ZGqclHDF57Z2p2jZndSnHvXOB1mGy0WNc4QoMjYMVRQlnPDYPQ2Q0vIE6soGoR1RCgbzB2eFRTmsQlXOoNowqbQJYN+NpXJDjgVH4UaHMz21GfwPxrkH711HfyEnSfXQoaBQLFXAzAKu5VwPWespuajd+FhXe+OMHWkRhr06W5lB4zoNjYItZ7RHLUaaaIyJxKjztD1P1bnxqXcmiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5aSmeOWb0Td5IXAtnWCOJyPQ79flRSOAMu4R91kQjo=;
 b=RHRKfHeed7awamh3NdaxW5X8rSCfg1iTaqy05m6URJ9HI/cL8ujf3OYMUQuuIlYQQNzGcBfePEhpY7fSYenLY2XlkTb8Mk7xZhvh2Are+dYBa3OxrYnni2iJeYtKdGF6jqR7rGVJlLSzyI1gp/CZJJAzH4U5tNpBw/NvQx8WOv0=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:38:59 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:59 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 2/3] hv_utils: Support host-initiated hibernation request
Thread-Topic: [PATCH 2/3] hv_utils: Support host-initiated hibernation request
Thread-Index: AQHVaPoViku3GXbel0uocpNnfWlsyg==
Date:   Wed, 11 Sep 2019 23:38:59 +0000
Message-ID: <1568245130-70712-3-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 9a61170f-4f19-4aa8-508d-08d737113823
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB0909A8F0B5242DED7E71752DBFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(446003)(11346002)(3450700001)(6512007)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(76176011)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y12uS4wCEnyLiokOfbsocQvFcnKZkqZ3nWh2tNIHhl/xxW2LCDR3Gf3nT0N8Qal+dEjOMlDO6DTpqOulwMcL/QjYQ5HF4lQa6iIkue53p0Hh299zrvJ2F49UOmJClMpE3PuZdx8wx/gHPC7Zmnjog5bDNCGh56eLgWOfIda5jNoC2VwajLaqYq77GmIutFR8r/Bs24UJmP/Scvc7fAoeps9dsU8TgnU2tNA/Vjba+6MzO9xg2wsAC2pZiuLAWoaSodBhQmsf6srYGR8cogFv06e6Vi1q9Y9evWIMkI+wR38KM0zuX9SHsDB9qM9N1qNuIhbqtrq7v8O064NfWb+XaFuphzqdTFBjSt3HeuowKmme/eu4wWbSyENIkHfAk3D2lLLeyOYUe7FyPwdS8h9VE+cj+sVJgE20RgPy44mxhQc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a61170f-4f19-4aa8-508d-08d737113823
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:59.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJR+A2ichjAnM4nNkazoYYpz/jH5YppqobexUc5ZTizudbyh3incoCdxzY9uFKbXVAQf7jTAlxHWWPJs60R9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Update the Shutdown IC version to 3.2, which is required for the host to
send the hibernation request.

The user is expected to create the program "/sbin/hyperv-hibernate", which
is called on the host-initiated hibernation request.

The program can be a script like

 test@localhost:~$ cat /sbin/hyperv-hibernate
 #!/bin/bash
 echo disk > /sys/power/state

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_util.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 039c752..9e98c5d 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -24,6 +24,8 @@
=20
 #define SD_MAJOR	3
 #define SD_MINOR	0
+#define SD_MINOR_2	2
+#define SD_VERSION_3_2	(SD_MAJOR << 16 | SD_MINOR_2)
 #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
=20
 #define SD_MAJOR_1	1
@@ -50,8 +52,9 @@
 static int ts_srv_version;
 static int hb_srv_version;
=20
-#define SD_VER_COUNT 2
+#define SD_VER_COUNT 3
 static const int sd_versions[] =3D {
+	SD_VERSION_3_2,
 	SD_VERSION,
 	SD_VERSION_1
 };
@@ -75,9 +78,30 @@
 	UTIL_WS2K8_FW_VERSION
 };
=20
+static bool execute_hibernate;
+static int hv_shutdown_init(struct hv_util_service *srv)
+{
+#if 0
+	/*
+	 * The patch to implement hv_is_hibernation_supported() is going
+	 * through the tip tree. For now, let's hardcode execute_hibernate
+	 * to true -- this doesn't break anything since hibernation for
+	 * Linux VM on Hyper-V never worked before. We'll remove the
+	 * conditional compilation as soon as hv_is_hibernation_supported()
+	 * is available in the mainline tree.
+	 */
+	execute_hibernate =3D hv_is_hibernation_supported();
+#else
+	execute_hibernate =3D true;
+#endif
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
@@ -123,11 +147,38 @@ static void perform_shutdown(struct work_struct *dumm=
y)
 	orderly_poweroff(true);
 }
=20
+static void perform_hibernation(struct work_struct *dummy)
+{
+	/*
+	 * The user is expected to create the program, which can be a simple
+	 * script containing two lines:
+	 * #!/bin/bash
+	 * echo disk > /sys/power/state
+	 */
+	static char hibernate_cmd[PATH_MAX] =3D "/sbin/hyperv-hibernate";
+
+	static char *envp[] =3D {
+		NULL,
+	};
+
+	static char *argv[] =3D {
+		hibernate_cmd,
+		NULL,
+	};
+
+	call_usermodehelper(hibernate_cmd, argv, envp, UMH_NO_WAIT);
+}
+
 /*
  * Perform the shutdown operation in a thread context.
  */
 static DECLARE_WORK(shutdown_work, perform_shutdown);
=20
+/*
+ * Perform the hibernation operation in a thread context.
+ */
+static DECLARE_WORK(hibernate_work, perform_hibernation);
+
 static void shutdown_onchannelcallback(void *context)
 {
 	struct vmbus_channel *channel =3D context;
@@ -171,6 +222,19 @@ static void shutdown_onchannelcallback(void *context)
 				pr_info("Shutdown request received -"
 					    " graceful shutdown initiated\n");
 				break;
+			case 4:
+			case 5:
+				pr_info("Hibernation request received -"
+					    " hibernation %sinitiated\n",
+					execute_hibernate ? "" : "not ");
+
+				if (execute_hibernate) {
+					icmsghdrp->status =3D HV_S_OK;
+					schedule_work(&hibernate_work);
+				} else {
+					icmsghdrp->status =3D HV_E_FAIL;
+				}
+				break;
 			default:
 				icmsghdrp->status =3D HV_E_FAIL;
 				execute_shutdown =3D false;
--=20
1.8.3.1

