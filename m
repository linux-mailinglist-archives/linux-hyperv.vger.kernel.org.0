Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CEE138BD6
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 07:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbgAMGbG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 01:31:06 -0500
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:22292
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgAMGbG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 01:31:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXmIA93krHNViH1QYhxTw1EFlQEJ3I2LcxiCaVAN8YFouukQ/j6iqoj/O41KVaYUf65RUAmMdB0yEOnN7Q2eat4n8VfYz3536p/HyoKSSLmQqUFqNSj8vwkSFrDx5yiqcl3lj/5gUHC+SWCO3szD1vLkNABPR6b112dufo3aCW26FS95D6aRDRvtnSdHT/XbYdYeJqN27i7OBnQauhnUwmwTPYG2tGqyKsF1kBUcEOqCBGpMLh17+DHnJLVXuUFf9KF/up1fv6kGtwlpfNx7H5blncN6DwCJONfVZsrajlZstZFVPAras1TSv8U5P6ZcXA8jriRQoFBjeof6bCRd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8tqkotIIT2pEkduQV+oC7XbsMW0phpFy8dvhWAZ2p0=;
 b=ITcPS51zNArl0p/q1omq/k9B100mD6TSjdyZ+FDpTAPiJJccof6d9TbE2/AoI/Qm1OzvrYP3chGno5uhKj7tZo+A/iM12apBYskIjEMn9tKyEVAHzXjlczh6ccJvHr1sbjhFFtD2TJjjrZEk4WotEbYBTYFSJFi2/lmmP5yzaqv3Cnf7AV3nicUK+SHZSPtB+vZw8Ubb2UjB7UdLP2iScpq9ywxJq6Bac1woO7pLkacWp84OHq8Nh9Uc9MAe4CA1eEmNOqGgvHCFJrPjCpmX8Wwh/vqy23pAbw0Ac7UAYffIIZMRZocKul7WX021cKtE9YzG1V1V8n4zINNv5ILhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8tqkotIIT2pEkduQV+oC7XbsMW0phpFy8dvhWAZ2p0=;
 b=L+z3vMtd9FF5T9t5wunqt8qn0wow13M3Y0eQwdr/jhdaPKgio9OXVtMKYPur9Rd+3V7uUQOh2k8aZgLZA0rCAqdigd2AIQPUreKnWU0FlaPM5IvpTjYJWn+4t4dbTXrYQVjeDBdm4YrfsmbCMlIdm0NCVWkYn6DmmC4ctZOLMik=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0324.APCP153.PROD.OUTLOOK.COM (52.132.237.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.2; Mon, 13 Jan 2020 06:30:58 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7%7]) with mapi id 15.20.2644.014; Mon, 13 Jan 2020
 06:30:58 +0000
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
Subject: [PATCH v2 2/4] hv_utils: Support host-initiated restart request
Thread-Topic: [PATCH v2 2/4] hv_utils: Support host-initiated restart request
Thread-Index: AdXJ2v+CkGXQwSJARV+SWgYtZDG50A==
Date:   Mon, 13 Jan 2020 06:30:58 +0000
Message-ID: <HK0P153MB01487F54363A856730BB13FDBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:30:56.6858983Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a12eb12-6152-4624-a9ab-f6645601545c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:fa69:ae29:32b9:aa46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b771b6d7-02cf-4191-ee09-08d797f226e3
x-ms-traffictypediagnostic: HK0P153MB0324:|HK0P153MB0324:|HK0P153MB0324:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0324F112DF47B818320E96A6BF350@HK0P153MB0324.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(5660300002)(10290500003)(33656002)(186003)(7696005)(86362001)(2906002)(6506007)(52536014)(478600001)(81166006)(81156014)(110136005)(316002)(76116006)(8936002)(9686003)(64756008)(55016002)(8990500004)(66556008)(66476007)(66946007)(66446008)(8676002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0324;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLig1+LmNUGH/ebgXhVhkAa5zn2AOVPglBsxdpwrMa6JyaP9ia9GfpoesUhhYMqzZjXMkIh44PmeMv5MerthZqGdB1Rr7579yBuENSxTBQZGpwq39t4i7asb0CY5rkXQfZZCG8LHKc0LL/P0wG9hdRDwP5UNMaD98f+p8IpOzoXDF2pPo37Qcvyjn/IFp3N6826M3az2fQaMYAAIHdBvL3JcBoTkSy5t4vP2RnZRJaaNO/gjHgS1mszabE76mesW70n/FWVRT7Ea/4GYwwi1yp5RhJO0Q/eVnbXy64is5phl0R0o0TpKHlVCsid9GyBrYhd8hnkIPPFUZqKlc8HDhW34iLak+K3Tz0NWMDpjXmTZefH3MsK32CkF114WUFjQQ/lGjpSMCWjbMXHf3asufIWhcwataHbSpbunDMda0sZYYCBJNhzuGfmV4D8vUetj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b771b6d7-02cf-4191-ee09-08d797f226e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 06:30:58.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y7tVtx3qSlYHofaOW7YS74S3o4Kjy8tW96KVrIuZpzFVG4wJAl3reUDTPPgwquGNHGsnK5lsSkgM+Tq3mNRoxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0324
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


To test the code, run this command on the host:

Restart-VM $vm -Type Reboot

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_util.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 766bd8457346..fe3a316380c2 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -24,6 +24,8 @@
=20
 #define SD_MAJOR	3
 #define SD_MINOR	0
+#define SD_MINOR_1	1
+#define SD_VERSION_3_1	(SD_MAJOR << 16 | SD_MINOR_1)
 #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
=20
 #define SD_MAJOR_1	1
@@ -50,8 +52,9 @@ static int sd_srv_version;
 static int ts_srv_version;
 static int hb_srv_version;
=20
-#define SD_VER_COUNT 2
+#define SD_VER_COUNT 3
 static const int sd_versions[] =3D {
+	SD_VERSION_3_1,
 	SD_VERSION,
 	SD_VERSION_1
 };
@@ -118,11 +121,21 @@ static void perform_shutdown(struct work_struct *dumm=
y)
 	orderly_poweroff(true);
 }
=20
+static void perform_restart(struct work_struct *dummy)
+{
+	orderly_reboot();
+}
+
 /*
  * Perform the shutdown operation in a thread context.
  */
 static DECLARE_WORK(shutdown_work, perform_shutdown);
=20
+/*
+ * Perform the restart operation in a thread context.
+ */
+static DECLARE_WORK(restart_work, perform_restart);
+
 static void shutdown_onchannelcallback(void *context)
 {
 	struct vmbus_channel *channel =3D context;
@@ -166,6 +179,14 @@ static void shutdown_onchannelcallback(void *context)
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
 			default:
 				icmsghdrp->status =3D HV_E_FAIL;
 				execute_shutdown =3D false;
--=20
2.19.1

