Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4E62FF7
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfGIF3i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:29:38 -0400
Received: from mail-eopbgr720099.outbound.protection.outlook.com ([40.107.72.99]:55635
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727373AbfGIF3h (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INIocVZ4SfKqZJrPM864RgWjPpiVkyJOZr6yIiX/XzyEatxBvGiWi1LdM9+AulQOekizWLHIgp4qgiywUNZq8iyiITAKAF4+pmLdPHF3ERBF3++DS3P5rwZ48lwoWmJ0qHD+yQvBtJ2gNU80AE1EjlyQ16smrfObGBKTogAYPHGYDAFeKCYIk9rzjhAK8m59yUD8TVQV+r/x5COx2NFgCR3S6HgMjt7vqdLFYFnuqsRTPsSaXR2w+u8o20l7L/tn3d+HKxPuCPL1W9deUMARp5At4reRVlmmkyXs5DnIS72IrvL4w1lQxKVwDRGE8x3+Y+WBKvCZwcJKpeBZFbCdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvWBZR5xTsd/UoWD8u0c6uIlYMkCouyA2qe/AcDJyo0=;
 b=OCjR6y4vPponGH/Jvt26mZR7IyWDeTApataIAQJidj7YFiBd7UA3XoUA6zxrXZaIRKXjPjXdYKDCU3C+0NtYNWLOcRoZbGp9/kmIcr5vMzKlbHf3EjGx5EjVonIBrlIjYkZzz5O9498ReAcivErgG2kh8bWdLU17v/Fadn1BPl6ilSUNGMmSvDHHyU2Im9qhosDvI2XPhAaW+Dmr4japNPw01UhrzNuDvYXiqQhVtTvIqyRMMUH3yCv7B0uifbh3fB3U5dp2IK3M+XK2HHDztJbOGEzSJj2NYApnbfQjo0iJ7Zd4mnz8FHhPtLblwoO3FYgYr04VAC0iD6enCepoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvWBZR5xTsd/UoWD8u0c6uIlYMkCouyA2qe/AcDJyo0=;
 b=QW0mlGJHZ2z4UtK8GXf1mKbSXdPX68x+hrondsmyhSA/E68/H3pwsV7ukIg7eWUeKtdTyxReWMgR1jp9qFHU4jHCM9iXWSA6gV6YngysUqkf3u0csH7E/pqu2ifNyBJIg0ZtCOm4ktQ87u5sIbaGhg0/1FlqjQLbHquRSZTae44=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1358.namprd21.prod.outlook.com (20.178.200.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:31 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 7/7] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Topic: [PATCH 7/7] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Index: AQHVNhdJ4hVzL0roO0+FWkmCs00hUQ==
Date:   Tue, 9 Jul 2019 05:29:31 +0000
Message-ID: <1562650084-99874-8-git-send-email-decui@microsoft.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7b0d9a3-e254-4210-786f-08d7042e6b61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1358;
x-ms-traffictypediagnostic: SN6PR2101MB1358:|SN6PR2101MB1358:
x-microsoft-antispam-prvs: <SN6PR2101MB1358FE66BB370D989FCA0EE5BFF10@SN6PR2101MB1358.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(86362001)(6512007)(4326008)(53936002)(110136005)(25786009)(66066001)(4720700003)(1511001)(107886003)(15650500001)(52116002)(99286004)(6116002)(3846002)(316002)(22452003)(54906003)(43066004)(50226002)(2906002)(3450700001)(6436002)(6486002)(6506007)(386003)(66476007)(68736007)(76176011)(186003)(10090500001)(102836004)(26005)(5024004)(14444005)(2501003)(256004)(5660300002)(64756008)(66556008)(10290500003)(305945005)(7736002)(36756003)(73956011)(478600001)(66946007)(66446008)(81166006)(8936002)(11346002)(446003)(2616005)(476003)(14454004)(71190400001)(486006)(8676002)(71200400001)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1358;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xVrKCjIH+ueVMip1rS88X8/FT8cRZVspbH0gtS4YCXrt8jWVYA35oIT+PvYgZnbWxNpDgo1/LysaY2+EjCfKcNf1dGW190fgMx/uRD6+TudYsyCSzXcMwi2ki9XEH/bG97fWo6ZEn0Jt1u4MISIBNB3B7b6Q/AcIHlkfp39Gbrdz/JUULVFKHoXXKUU7KRsPuDAmRmYdVFS0VvvsJs6L6IzsKw9VG7+VFPPod2B+yBLXYAC2TFZjGx6xC/XdDay+RySaKNFHS9iF2ZVaRI+BKLL+qACnim8+stjsqqPESw1i0K4Jd90wrkHJ4FE1Ji80yYNvkY3zBHMp5+hQomfej/F8Bn5yKEiATkqhCjPiLVJqMOYoEjbsIIFcHKzRiR9aUHHLLUrdS0tseSRheXYUECfob3vwbH2/zWcYPHA+Zpo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b0d9a3-e254-4210-786f-08d7042e6b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:31.4620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmldc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1358
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The high-level VSC drivers will implement device-specific callbacks.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1730e7b..e29e2171 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -911,6 +911,43 @@ static void vmbus_shutdown(struct device *child_device=
)
 		drv->shutdown(dev);
 }
=20
+/*
+ * vmbus_suspend - Suspend a vmbus device
+ */
+static int vmbus_suspend(struct device *child_device)
+{
+	struct hv_driver *drv;
+	struct hv_device *dev =3D device_to_hv_device(child_device);
+
+	/* The device may not be attached yet */
+	if (!child_device->driver)
+		return 0;
+
+	drv =3D drv_to_hv_drv(child_device->driver);
+	if (!drv->suspend)
+		return -EOPNOTSUPP;
+
+	return drv->suspend(dev);
+}
+
+/*
+ * vmbus_resume - Resume a vmbus device
+ */
+static int vmbus_resume(struct device *child_device)
+{
+	struct hv_driver *drv;
+	struct hv_device *dev =3D device_to_hv_device(child_device);
+
+	/* The device may not be attached yet */
+	if (!child_device->driver)
+		return 0;
+
+	drv =3D drv_to_hv_drv(child_device->driver);
+	if (!drv->resume)
+		return -EOPNOTSUPP;
+
+	return drv->resume(dev);
+}
=20
 /*
  * vmbus_device_release - Final callback release of the vmbus child device
@@ -926,6 +963,10 @@ static void vmbus_device_release(struct device *device=
)
 	kfree(hv_dev);
 }
=20
+static const struct dev_pm_ops vmbus_pm =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(vmbus_suspend, vmbus_resume)
+};
+
 /* The one and only one */
 static struct bus_type  hv_bus =3D {
 	.name =3D		"vmbus",
@@ -936,6 +977,7 @@ static void vmbus_device_release(struct device *device)
 	.uevent =3D		vmbus_uevent,
 	.dev_groups =3D		vmbus_dev_groups,
 	.drv_groups =3D		vmbus_drv_groups,
+	.pm =3D			&vmbus_pm,
 };
=20
 struct onmessage_work_context {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6256cc3..94443c4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1149,6 +1149,9 @@ struct hv_driver {
 	int (*remove)(struct hv_device *);
 	void (*shutdown)(struct hv_device *);
=20
+	int (*suspend)(struct hv_device *);
+	int (*resume)(struct hv_device *);
+
 };
=20
 /* Base device object */
--=20
1.8.3.1

