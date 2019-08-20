Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D2953C8
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfHTBwJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:09 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728890AbfHTBwI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIpzI4jAZ2NxJQ5AlhNi0MpnWz54wpe37HH0BLracXab61n+FQ5gD6wxQZv4vymKh3Hvq/3zqcpBKOjZClGTcy/LLkZW0q7MSKcNVdy43zqFAzn5nY0VtV2faYO7pweu0VJX4Sc43Y/A5CORdNpq0dcS2WBJAbVeIv+wK6cMi9xPzxwIxRs+fDNdJy3iaBiGtlACThJUADzXFDGWcbabn8LJu5ZcMunGaMaFEUBvT6ESK7w3ctI5RL+QtopNVJvo1zmxF9FB6GAMjk2V+rfRuKtLjrNUFEG5ujwtF+AZ8R/MPHhEtx7g6YarkQCPAQC+YoGJgk5cPjVOfVEtq9TWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdbl4Mr6/6tJasYiOiOMwwSMMYRGnhnEIC1pd3WvOvg=;
 b=IMiPrII0mQ8s+ShUIaP0NPhmci7+b6e7if/Hk7Qw+G8kpbaO4MJ8B28Rl+abX0ssmN9IiNXZyCni0j6v4Ctbf6cbF9XN4ANFjtBakI09CHK2TNQusXBwJ5vtccd5kt36iOUGa2AydU711Y4Sb116KCDhnUi4ltxdkge7gPn4szFndihJv2E3cXtIZm2F3Bh74bTSk44akJOu/Utc8OyJGZY71D+vWYPTy6GM5VQ8HCYLgaVYzbpR2kJqmLSLsv7o6WeQagjO4KOu+hiSTyVovnP3CryhKCjNi9Y+9d9B6F+JNoRfTDdNCv7PWR+9y68maiIk/1jGoaSDluuEeGDfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdbl4Mr6/6tJasYiOiOMwwSMMYRGnhnEIC1pd3WvOvg=;
 b=WPLhJCl1DtDptfa3hquzoVe3C7+q20mMSomhSv3xam86BsAf4vucw74qg1B8FGkYybSJnHAEBhLmlADaPxghdEi7Lk7zp1xaZ3SiMi8gOfiaxD3TWjU+Hx3iI6khq+1czwcFIVIIY3ixhjKXCc4yTe0hjO7luI9huSUI2WwMjME=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:04 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:04 +0000
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
Subject: [PATCH v3 07/12] Drivers: hv: vmbus: Implement suspend/resume for VSC
 drivers for hibernation
Thread-Topic: [PATCH v3 07/12] Drivers: hv: vmbus: Implement suspend/resume
 for VSC drivers for hibernation
Thread-Index: AQHVVvndaVzztvpnS0CmvODgNbf61Q==
Date:   Tue, 20 Aug 2019 01:52:04 +0000
Message-ID: <1566265863-21252-8-git-send-email-decui@microsoft.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54d62b02-fe18-4e13-936f-08d72510ffe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11331DD09D812E856A1FB315BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(5024004)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(15650500001)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3u3Df+zgCKn5aFtHewcn0DOK9LTYBSXLbDOLKh+Yk7uRTUzLYOjf/gQns7oW3qP28UTqREiDgCmSmAr1hxZYnEP0fwBhCiNl1cqZwV4q/IWBpkI3lBIfdLNirQfFE6iyaAcCNj75b1J5wgoxJzAyJ0SGdBuM5VlN/11SLLnFTK2qYEG/YsyPni0S1H/sly7PPOoHDVpiaxBO1lpeNePMlPUsLLqZM42RP/ZQXZ0UeEfRl2mWEBgXMS/qVAX9tjdkHNlmbE7reNu9V/WFQmGsa1peEmoXB3Xe1liOt9aqgqZ3608SDDNyOlvdLa3EAdw8SX4uprRrMd+kCG5xWni18pzkSVJbiOOPN3xzsqRC1CfElT4EFV+i0u+5k1DHRWGiqr9HthRejg1CVEHlLRH0X5WBTY4FAs8ElPvFILzmoq0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d62b02-fe18-4e13-936f-08d72510ffe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:04.0703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkoC7/PQCXawOEfYXH+Te94e0lxDOU4ZNxwPcrZA9Z1meRrY/0ZlqlZv/OpiNecGYYqxJHdla0CJpf16HkpK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
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

