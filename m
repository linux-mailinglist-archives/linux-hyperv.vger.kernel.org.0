Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6691A5E7D
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfICAX3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:29 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbfICAX2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAMXqsY9ughRdnq38VHq6k27zs+/hkdZEDI+4QhUhTLkQacEpOQc3YPsTkt86JU5TuMK9iiMWIe6MkLnZJL40KR7FFMsriSMcuErKWfuaXcdU26KiWq16KdrjzloSe+9UeIhaxhz6MzmMEgBdRVzjIH+zsQT+ChNN16ia1+UPp/AAa+IQ8jJmGaUssQvzHsbUOtreepl0yfQlRIvv5EN+YvOCfWDcFYiiJs61ZnCmdzSlYruSCEY2fUDnOc4m/mJv1yjjFlYLt69u9FK/KOc30jwZuK4CVJ+2E2YGoWQJ7y+z2E9RqWfMuzyjI2flqhY6TVxCK71kGWE94xbelnTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdbl4Mr6/6tJasYiOiOMwwSMMYRGnhnEIC1pd3WvOvg=;
 b=kfJ5TNdOBwKlGp6pKSFfLqDK/9m+F5M5b1jb0sC9hIyvcSh7b50pandxYrEzAjnS03n5zF/lRrEY1PiJF1xzcdAus3/KBD0ywdhjrmdw8Ma75+FR5R3lwP72m+DNv/3/5Mvful7sETqjJPXS6Gl00BJHeYeaWWR7ZUbGh1XS8ui+pSbwopXis/rnDEcv6jzOsmTnxmTCTVMMLmZ3QtxG3sHxMnT/p+0v9g/HVC7sOpLZq1lq2obpilNJtHyozzklJeYMsJedcc5qq+ejfPM3SGKun/BKpTZqYJwxZudUMT+Zi/HUbZlIZYbzUCF+tUB9xhHB9AYkYkECwMV1xBWjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdbl4Mr6/6tJasYiOiOMwwSMMYRGnhnEIC1pd3WvOvg=;
 b=lgUgkqbP04TLV+hyz8TY72xTXxsVZveoqnwb5T30CdRvqRRMJgK3Fqrp/imaNdGp5taCkzlA3WvjVGaAXdXYneFUGC6sCDblMvCbFVkTct4q2DcXitJxTK245UixP5s4FtftiQFNy5avORc+zX8i9bU1GF4OEib6iOcqGYfokCA=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:22 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:22 +0000
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
Subject: [PATCH v4 07/12] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Topic: [PATCH v4 07/12] Drivers: hv: vmbus: Implement suspend/resume
 for VSC drivers for hibernation
Thread-Index: AQHVYe3Lq151OnHmPEO0ia4skdvz/A==
Date:   Tue, 3 Sep 2019 00:23:22 +0000
Message-ID: <1567470139-119355-8-git-send-email-decui@microsoft.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:301:1::15) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29046f9b-7578-492a-4b1b-08d73004ed91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10547FAC5EF1FC7ED8AE3DCABFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(15650500001)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(5024004)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HNyBmJgH3Rip9VjnrRfdQ8pih7NHEaIrLa2Zhv1MKxnr3mmes1/bSbNKwxp1xxSH9CKqjIwCAY4lsy0FaVxlsuw9+OD8y5WsoB1E1RR35pTCNNe1GbWW+dwau0BqSEUe5drk/7X9icTkWOVdekgiYQ+0Rw7eTZXZ+JIReXHMc85Kvj6fEnhOIsarFBnYMzw9wq9zbZ1+3Oyh/VWAX4+8NjUzUegs6Z2EkewKbBV2BB4wK7AxWOm3y1uEUCnEBx+7KH/ZlLpdJMgboLNurSlCfUebJasVTlTv5HOoqy5cQ3XEnA2skBoG2itG/77BFYrnn7KGPrTiQK7Fq93ox0p5/OVmrzXPHt4oswzDAohmy5PpstkAYqNH6xQoS4iRmqs/ACRISwRVHkUCZ6y1tggVC1IzXorTtyLcErDlcvSM+4w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29046f9b-7578-492a-4b1b-08d73004ed91
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:22.1208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yB+YFlsZlh9TIPB+8fl3Iz78wTFD4jpO5vsndBXcp9nW+ac7BlQVxwMBvUeDTb+lDsNvPDpU9bJk0Z+HsfQyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
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

