Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E119B05E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfIKXeP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:34:15 -0400
Received: from mail-eopbgr720123.outbound.protection.outlook.com ([40.107.72.123]:63793
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfIKXeP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:34:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxRvxv4iilQcIEmDBY5ORSBkTu4wgfWwFzmhswY3S+MhzDgOWVEaKcOyp0kfHLXmJ0cMon17ERMilPhz8yd49bfk76LIH646ifFSr5YxcF4x2vaf6Q1v3RzFvy5/MCdLq+hFG1MVHpZmtMABWw69SoZUl3RN8DwJhjri1lc6HnBHwXYHd7eWbxQFiiItTjbpMnl4HVtzpWEalirdcjkiB9OYb4cPP6yLlT6M/r8rsBLe/vXmPMK9LmCfSpnx/48Web5/Z8S3+cPi/fQbe8caY91w/oOBOmu4ZTNLZzaMJgvAH8hr+sgfSeuPnjpO1g6O315KVYsL19nFoqVrWbBwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i0TtoMANsDUuR3gA1tMLi1H40lAHbI+cepHWyW1JFY=;
 b=EBykw5Tgjicp/X85eAa8lESrxgdYLFJHGOsHTYBT0SOJ2E2B8Mu2XhxmPYHI2Z4WouJVth/TNh2Pt7QlwP6wp/DeWoojzdLUklFmytuVZioDortPRGTKrU9QtihV3ZUK1q0HgyeRUiUy2uKORxO2qAG69CtyhZ4BeVtI8RhwURW02X8WWCCEVuNE0sjETIyCB8ZVRgNDcWeAKVq9jY3RKIaccdfMj7Si3QEEZIJYRtXhRMYmkVzUdGhh/yOjqnY6uvw88hkqZPQtGNGXvmhhmIwK+Y5zoDSfMEeQ3o58pBWDYxgBNx2lPlqbMoFAsYorDNvhUU9uuS0LEEf2O12fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i0TtoMANsDUuR3gA1tMLi1H40lAHbI+cepHWyW1JFY=;
 b=RpJbnd3o1DAkH5qeX+QTwQJyLEgH/4WuSX7cW9tC2j/p+Sz0iwK9sZv+0glAE4v08iin/ottFUPDpyxxLZ4Lu0cKHFvbZr4p/ohuJp5R23Ay26eUpRuP6UtEuHkH8PrlmRsUv7q34w2DpKab29Z+O1ji/qQxuPY5TG6wZY8bXZY=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0928.namprd21.prod.outlook.com (52.132.117.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.5; Wed, 11 Sep 2019 23:34:12 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:34:12 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] video: hyperv_fb: Add the support of hibernation
Thread-Topic: [PATCH] video: hyperv_fb: Add the support of hibernation
Thread-Index: AQHVaPlpoGmoU9RhmUGZUZsMyZEthw==
Date:   Wed, 11 Sep 2019 23:34:10 +0000
Message-ID: <1568244833-66476-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:301:60::46) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f1bbde1-400d-466f-b660-08d737108c2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0928;
x-ms-traffictypediagnostic: SN6PR2101MB0928:|SN6PR2101MB0928:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB09283DFA890F3B80771C916ABFB10@SN6PR2101MB0928.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(189003)(256004)(14444005)(476003)(2616005)(71200400001)(71190400001)(486006)(66556008)(1511001)(14454004)(66446008)(64756008)(66476007)(36756003)(66946007)(52116002)(110136005)(81156014)(50226002)(2501003)(8936002)(6506007)(386003)(81166006)(186003)(8676002)(66066001)(305945005)(316002)(10090500001)(7736002)(10290500003)(102836004)(26005)(5660300002)(22452003)(6512007)(6306002)(53936002)(2201001)(3450700001)(6486002)(6436002)(478600001)(43066004)(99286004)(966005)(6636002)(107886003)(4720700003)(6116002)(4326008)(86362001)(25786009)(3846002)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0928;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /a1DryAih0s377TX92sTzxaz3V6wlH165CXfVXjo1B7bKS0lXc2jmSvlpeIYs1MoOcZTNrQJIsjwEF447pkI4fv6PmZ9+zU6tri/8IEFmEUFWqTCedqmGbDbJ216LhkULbp/P5l7tgSYGSqTocF4EWvU6TbvqyrjdvPC0fgVh37G/a1b3cBBBwpFAsUq4KLsvDVi3buMFhexikfGKq0lCTZUgOt1A7GJxbDEq8fuI7AjSxwByG0OlL3HRPsYm98Am/XnJvP3vy7BKODQ+PlNPgN3wTnbtoGN5ZW7ePr3VrvE6VWWULWwzXk/ieu1TtkPEINDfcMXFQVQABHFD2mfUg/380mWyr/+jj72YX0b4YT7LMgbwHFsKY73Xb74KVQ89U4ylxnafa7N0CxMHWJoLCuTZBF8JZDFW24SxFtCiNU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1bbde1-400d-466f-b660-08d737108c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:34:12.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzU1sJ8FNNZJAUpRS52fHkIUd9UTxq/1/oG/7ZO6u/P1axiWoFIE72OUIoV3BKE+V8X3rLX5KRJP5v7cn6XOHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0928
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch depends on the vmbus side change of the definition of
struct hv_driver.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
fbdev tree.

 drivers/video/fbdev/hyperv_fb.c | 59 +++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_f=
b.c
index 2dcb7c5..fe4731f 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -34,6 +34,7 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/efi.h>
+#include <linux/console.h>
=20
 #include <linux/hyperv.h>
=20
@@ -211,6 +212,7 @@ struct hvfb_par {
=20
 	struct delayed_work dwork;
 	bool update;
+	bool update_saved; /* The value of 'update' before hibernation */
=20
 	u32 pseudo_palette[16];
 	u8 init_buf[MAX_VMBUS_PKT_SIZE];
@@ -878,6 +880,61 @@ static int hvfb_remove(struct hv_device *hdev)
 	return 0;
 }
=20
+static int hvfb_suspend(struct hv_device *hdev)
+{
+	struct fb_info *info =3D hv_get_drvdata(hdev);
+	struct hvfb_par *par =3D info->par;
+
+	console_lock();
+
+	/* 1 means do suspend */
+	fb_set_suspend(info, 1);
+
+	cancel_delayed_work_sync(&par->dwork);
+
+	par->update_saved =3D par->update;
+	par->update =3D false;
+	par->fb_ready =3D false;
+
+	vmbus_close(hdev->channel);
+
+	console_unlock();
+
+	return 0;
+}
+
+static int hvfb_resume(struct hv_device *hdev)
+{
+	struct fb_info *info =3D hv_get_drvdata(hdev);
+	struct hvfb_par *par =3D info->par;
+	int ret;
+
+	console_lock();
+
+	ret =3D synthvid_connect_vsp(hdev);
+	if (ret !=3D 0)
+		goto out;
+
+	ret =3D synthvid_send_config(hdev);
+	if (ret !=3D 0) {
+		vmbus_close(hdev->channel);
+		goto out;
+	}
+
+	par->fb_ready =3D true;
+	par->update =3D par->update_saved;
+
+	schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
+
+	/* 0 means do resume */
+	fb_set_suspend(info, 0);
+
+out:
+	console_unlock();
+
+	return ret;
+}
+
=20
 static const struct pci_device_id pci_stub_id_table[] =3D {
 	{
@@ -901,6 +958,8 @@ static int hvfb_remove(struct hv_device *hdev)
 	.id_table =3D id_table,
 	.probe =3D hvfb_probe,
 	.remove =3D hvfb_remove,
+	.suspend =3D hvfb_suspend,
+	.resume =3D hvfb_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
--=20
1.8.3.1

