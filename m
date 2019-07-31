Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2333D7CAEE
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfGaRwK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:10 -0400
Received: from mail-eopbgr810135.outbound.protection.outlook.com ([40.107.81.135]:36140
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729677AbfGaRwJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLpUHkUvadtckW7fQ7ZdD8BKc77Ys8gYgNiMNyXqmMgAvWFrXK4sY9bqOR0WELTJY1SAR2x7RjY2TwjCLjcwb507fnH+9EehZ3SwxhknokYAECpi4PpTapF/i+YlL6IgYGMWgtHmtmFMwDFF45FtGvV5zENEZg/VfSJSCVUgViSO8dOpnYpxxEJCyhea+RwFduOZJeQ4pi1ASdztaWLsNit5k0x64OulXJvqgJe79V9EZ6MDvmTs3AEQaEZfsSzzA0CInRsY9dRhguyJUqFOKZvmv++hEHfzV3/aH3lAfDXwUWEhi2LkZtdwstadNYCla6DBjhjglAvSPZJ3JQchJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrmgrUw3LKxyVpxPgS377oXQDpxf8EHtIYKQrZvEUZ4=;
 b=KisM9eqXMa8M1X7jEWMmYRuij7XpYVnRsIuOvX2maCJRQO4+OBSx2XGx0MK2yU8S9HJcoWGcSFE2CLdRcAgGVKPkEGubhKpTGoK0qgIj8d3sXO1f/6o1OjmZgaRr1fqZmStPw0IwOCRU5q7dKKptYysupViTEGEi9b8gz+JM/QfmoJWCZAk7a+QtNFGoK2Vmi2dN1+/r2ibJKh8bTit2zpFC5+bYYDJKC1vKMJ3IRtDegUCNZ0nG+5gDkZzIG3SxXexoHOY0PoQXIrmjnsG7y29m3IcICcw/OTiv4Hr0rHeKxPe7Q+KtF0zUB85KT+bfDgNfgb45hKGftOaRmFgWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrmgrUw3LKxyVpxPgS377oXQDpxf8EHtIYKQrZvEUZ4=;
 b=dryg3ubCiNN1/44PGhhFpJnIScIvunK1vCwsOkDh3mGKl5snzv/w4Udu9G6IGYCF+R7n51EFuIyy5OwYzCs0VhLFJERVRpIFG7TnZVsQZDdlQiCLkJGF7iIRgtvm08agb8s3kxwCduaR8v/8V6jO8xcobsKZKHeKHe0UTwYgzyk=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1085.namprd21.prod.outlook.com (52.132.115.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:07 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:07 +0000
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
Subject: [PATCH v2 7/7] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Topic: [PATCH v2 7/7] Drivers: hv: vmbus: Implement suspend/resume for
 VSC drivers for hibernation
Thread-Index: AQHVR8irVHxoPGRIEkOkK4NNsUPg/Q==
Date:   Wed, 31 Jul 2019 17:52:07 +0000
Message-ID: <1564595464-56520-8-git-send-email-decui@microsoft.com>
References: <1564595464-56520-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1564595464-56520-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0011.namprd13.prod.outlook.com
 (2603:10b6:301:29::24) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bd7953c-4f09-4984-081c-08d715dfcdf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1085;
x-ms-traffictypediagnostic: SN6PR2101MB1085:|SN6PR2101MB1085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1085B4588541925E9581F9E9BFDF0@SN6PR2101MB1085.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(8676002)(5660300002)(4326008)(305945005)(10090500001)(8936002)(15650500001)(107886003)(53936002)(81156014)(81166006)(7736002)(14444005)(5024004)(50226002)(66946007)(256004)(478600001)(10290500003)(66066001)(66556008)(64756008)(66476007)(66446008)(68736007)(86362001)(11346002)(2616005)(476003)(486006)(446003)(1511001)(4720700003)(71190400001)(71200400001)(6512007)(2906002)(3846002)(110136005)(99286004)(2501003)(386003)(52116002)(6506007)(54906003)(102836004)(26005)(43066004)(76176011)(6116002)(14454004)(186003)(316002)(6436002)(25786009)(3450700001)(36756003)(22452003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1085;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1pOXJUSAlfu/WmDCZCWpJ89CBY7Aw1rf91LAXszNPlGTseU/yyWHJxyRH9A39huItgGRI40LJCIUn+O22f02xDWVV6HFiuaqBsL3Z5XosUTBUhbB9YPd6Ek+s0S5CnVxuWBsfPz2wwjE44yDppMluEqNd4aJ1qYI7HGW9XaQHYJInZ8NS4khi49R/RsMLf4L1Ls16Uz5+bHFl3VdYx9K0+qHjVVxenoaHMqHMBJ+yIVZM1n88V0C3vMokauRhD31SmJ7PATyiUkIsBefDBR7OeQ1jnQN4xQ/QKBau5W4NKn/J7Mdq7CzWC/nK1qnrRjfpTG4I3dK3LKsn81Q/3Tx9WcQAgtTu9AdEqYlON8bfUHHI/ZQI/f6G34cU2Wpitm3hCAxBoivTDmtgtHiRetXpUYSXh6ckHdgCKo2OlKrmQM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd7953c-4f09-4984-081c-08d715dfcdf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:07.5211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NldUL/i0cFXIVk7ydSZwMAPu35f4Z9GBVdQkJ2EWqQlqb5eDc/SmvwMGDgt57I5KY2FZcs4bpjAaapCG/eYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1085
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The high-level VSC drivers will implement device-specific callbacks.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/hyperv.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ca6f4c8..337ecce 100644
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

