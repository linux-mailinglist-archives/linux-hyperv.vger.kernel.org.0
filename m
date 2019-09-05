Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE2AAEDA
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390406AbfIEXBY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:24 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389666AbfIEXBX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiOFgZKD9OaLJAFEjAEYxlubCnFDXkNgwawwRcrM3MwZpZqErRELFB2fU9QM1O3dEkVKOkL4MYXzhqDDkRxgyITTLODvnBlDIu4ZwlclpK4FUcGwlj4oIPdm5hkUhVOwUoB/F/xldQemi8IjhJENNmaJQTa3WpNe7/3L9+B0wCmaW8jL0KX4fsHjYAMrYCVWSv0rndd5ffsdyYW6vxb55mYP4gChmqF1bb+bZ0/cs6XmyBWzq1XOGPK269d9il/VgqS5RAlEMVOmciIjmrSiKUnYj0vACoX2z1DgW+Iq560vpc2ydtdXKDRXNMhySghRVE/v3zaQOVRlh4HJ8FwGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdbl4Mr6/6tJasYiOiOMwwSMMYRGnhnEIC1pd3WvOvg=;
 b=EjLJauubQKTURaNVG/YJb1yGR/Xl0pYGFYYSJlGprEFNeSu5BfSf23GcFhqrk2ibI2SeAVsTXATWZhWnPT9pg2y305AUrHSbkShzoZzJKKibF5pxC6hSPqNzzfukjLmNMWZpRR00OyFbm7GC6UDl+CVFZEpeT4eZpmE3uGbHtW0xeY5bSOh3+VT/lWV6mlvK+mXIDfq+kwag5uTaSRWnffEsH2CvSpglRxpxDQ4k0XT8+7oFU1qoYVnblQ7H8yigUuiLbYa5L64WB2W5Ak++azEtZF4lWrs01TAWoMdTT5BDS8NXtTxyRyFIYEeXo+HBNsn0DgNaVceUf44u3xLwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdbl4Mr6/6tJasYiOiOMwwSMMYRGnhnEIC1pd3WvOvg=;
 b=JeJHFwNWdxXxlGXZR65lVDsruT/63945ErPOUPaL1GCJLi3PNLvMwre8CVPD2S2loG8JluZ9Qwc8uc6RNKB3JNOD9EySRMHn5wOPk/571eh2YuAoYWL/HjEFgxkUlgvvwndPi8ONFlZUniWTeuetRHBw4d47Bglby3xGK86l2IQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:19 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 4/9] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Topic: [PATCH v5 4/9] Drivers: hv: vmbus: Implement suspend/resume for
 VSC drivers for hibernation
Thread-Index: AQHVZD3TSgcM00JbJEK+uBOsXhhSqw==
Date:   Thu, 5 Sep 2019 23:01:17 +0000
Message-ID: <1567724446-30990-5-git-send-email-decui@microsoft.com>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567724446-30990-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfbd3e97-ef3c-4686-737f-08d73254f5a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10389358501E1579C94CBC5EBFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(5024004)(305945005)(15650500001)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eBkjgtsoTrAmFajFGAmvmZdJy/mTUFEVEo5CrifZjkJI/DWX/y6yI5H1LeREIRT9W3ymXkP5ibi4mYWuhO0xzG36QqSyzU+BgGoa6EXR/RkaAA7J+gEHoLFy1aHHwLx96Tuck6JRQR6pFt+ZtIzplX4px3E/Nzxp+ichhorb/WR8YQQateANnkxbv7aF6qx1j5jRqxZRqtI/fJ8NXdd9MS70rFhLL+1R+SfEiVJ/IetfT6fLhTY+HeD1Vb/3XAWmcVvTqHyMviTtdE2I2DeVFO44iYpG8glO07M+DISgjJgp59KRC/3FVObZEW6F5znnmmBX/ILyfvrkqXJO07H4noRqVBpdWEWAiMNGIX6LPqTk/b/Rv1nItS72zP8No9qyr31yijpyjbllfX5zh7SRB6CzPC25xH7rDbhPgLK/PLk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbd3e97-ef3c-4686-737f-08d73254f5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:17.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3FcxON5OOXvuS3mUL1cBwOSIoCS1tIsCFk4iBdre7iLZrTZjL6hs35+3M0aZj1rwCVh9pF85gxKS7/RGvguVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The high-level VSC drivers will implement device-specific callbacks.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2ef375c..a30c70a 100644
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
@@ -926,6 +963,14 @@ static void vmbus_device_release(struct device *device=
)
 	kfree(hv_dev);
 }
=20
+/*
+ * Note: we must use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS rather than
+ * SET_SYSTEM_SLEEP_PM_OPS: see the comment before vmbus_bus_pm.
+ */
+static const struct dev_pm_ops vmbus_pm =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(vmbus_suspend, vmbus_resume)
+};
+
 /* The one and only one */
 static struct bus_type  hv_bus =3D {
 	.name =3D		"vmbus",
@@ -936,6 +981,7 @@ static void vmbus_device_release(struct device *device)
 	.uevent =3D		vmbus_uevent,
 	.dev_groups =3D		vmbus_dev_groups,
 	.drv_groups =3D		vmbus_drv_groups,
+	.pm =3D			&vmbus_pm,
 };
=20
 struct onmessage_work_context {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2d39248..8a60e77 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1157,6 +1157,9 @@ struct hv_driver {
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

