Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D562FF5
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGIF3h (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:29:37 -0400
Received: from mail-eopbgr720099.outbound.protection.outlook.com ([40.107.72.99]:55635
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfGIF3g (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUQptm6n9q6cZWDUry98k4frdG4Qjhs0WzD5khd0AOHQhf7ZQSgYQ0dkPiP0ybSX/nQEp+qcOZ2NFkdlyug4ukpnMCVJAbfZjqtGX4HRH+fUXfO7U8LZMoISQtmJigE+wGI9Flaa7vRZGp+9616cvTcyjwK52m8TVj0Rwz5HrP8r4gkttF5Q3d08ySHQAXTWSh3kEpHmJNiTLZKrJmbr/e8tqLjSzhW3wJxMvEpHfex8M6IWMe5IJvsM33nxv7H6kdtQmk29XTarB8bNRizDKPOv5msBuLY2rIxcXu0ZPW2qY8O4RezcYK5d3PrP70IAy+aD/5MKixDD3BMkz9GNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br526JqVriplqZX5tyLLYPaTpEzoeF2R8HL/goCMxpw=;
 b=g6abPa8zVAmurbINmVHmScVrdnttw1x0ReAEhwQ7pY93XWFemc+wZ25qg55R1PdXbxr2/HKewR5zFqmcnZJzrgrFGXvELCBHEw4pq/3VbtL79bPmcgaT7tpuqZFona0B47FufWQWCJSthiVa8Mq88XVOKGWq2/4vfR0zCrbQwqLM5ypt1PGDERmOUnHqZd+8AmJe6tREE9QvAOk56yoo2iEry3ErFS1y+2s+MZ8ijGkvuJBMTO62ob8RBceuzsc9RSuLSCUX9bO570c1nHFwgaOevHjlzy4yGqgiw6o6NR6+CdU4qZ1kilw9lJ55Flt5DMp4SIhjFnr5I3qZ9M20SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br526JqVriplqZX5tyLLYPaTpEzoeF2R8HL/goCMxpw=;
 b=n6KNY/jeF7t51rkr2+Tbe3k0eHyNbSgJFVvprs5EFOc16ihFgXosS/FA6WpT3EVn4+/Zs0ZXyI9S0dce+0oWrAXaEB22mgIX6fg37zmTzysb4kLYQ4KIWBUoUmgayxokCC9eZGkz0HR2vBcsfAarog3R+qfZeEs4a5F/90Clvn8=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1358.namprd21.prod.outlook.com (20.178.200.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:30 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:30 +0000
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
Subject: [PATCH 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus itself for
 hibernation
Thread-Topic: [PATCH 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Index: AQHVNhdIaCRxdcnDs0SlXIWXfIwT/Q==
Date:   Tue, 9 Jul 2019 05:29:30 +0000
Message-ID: <1562650084-99874-7-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 799f113b-bcb6-40c4-e688-08d7042e6ad0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1358;
x-ms-traffictypediagnostic: SN6PR2101MB1358:|SN6PR2101MB1358:
x-microsoft-antispam-prvs: <SN6PR2101MB13587C159FF8BCCE1CE453CEBFF10@SN6PR2101MB1358.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(86362001)(6512007)(4326008)(53936002)(110136005)(25786009)(66066001)(4720700003)(1511001)(107886003)(52116002)(99286004)(6116002)(3846002)(316002)(22452003)(54906003)(43066004)(50226002)(2906002)(3450700001)(6436002)(6486002)(6506007)(386003)(66476007)(68736007)(76176011)(186003)(10090500001)(102836004)(26005)(14444005)(2501003)(256004)(5660300002)(64756008)(66556008)(10290500003)(305945005)(7736002)(36756003)(73956011)(478600001)(66946007)(66446008)(81166006)(8936002)(11346002)(446003)(2616005)(476003)(14454004)(71190400001)(486006)(8676002)(71200400001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1358;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HKgFHLjgwgWHu0rur8LkdDlzheIxD0ySR52oX4UXJ5yImy9B6uioG/Fh3KGzjrMKhtCO4am4mqJk6ONH+YsK69IG51PQxXAPVHHItL31aqubi2gusTqmB7Ys81oyhc00suV10XzsG4H/09D6jiKfh4LGwcyi3TQWTUYonX1x0WlKXNJDb/kL1PViaZ9TXrL1adLRnIY4L7wA4QBr4l3VhF6AgdOB9YdYW+UzHewO+COQBO2kHCQrx6IwaP0/kWXDyKipGQUCSZMMqtuwAN02GjC+P+YPSSFHc7LCKgP/D2ouhbT39rWbateZ+A8c8qqzXxZP79hX3zQwi9RevXM44spzuKsMiy3rXnQFRzt3d1k7OOFATjVg8bx0MaM79N6e+HgMHtF6j2MwMbb4l/gKTXjBC0OKtFKHzY+qrQB7ras=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799f113b-bcb6-40c4-e688-08d7042e6ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:30.5575
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

This is needed when we resume the old kernel from the "current" kernel.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/connection.c   |  3 +--
 drivers/hv/hyperv_vmbus.h |  2 ++
 drivers/hv/vmbus_drv.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 09829e1..806319c 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -59,8 +59,7 @@ static __u32 vmbus_get_next_version(__u32 current_version=
)
 	}
 }
=20
-static int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo,
-					__u32 version)
+int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 ver=
sion)
 {
 	int ret =3D 0;
 	unsigned int cur_cpu;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 26ea161..e657197 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -274,6 +274,8 @@ struct vmbus_msginfo {
=20
 extern struct vmbus_connection vmbus_connection;
=20
+int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 ver=
sion);
+
 static inline void vmbus_send_interrupt(u32 relid)
 {
 	sync_set_bit(relid, vmbus_connection.send_int_page);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1c2d935..1730e7b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2045,6 +2045,41 @@ static int vmbus_acpi_add(struct acpi_device *device=
)
 	return ret_val;
 }
=20
+static int vmbus_bus_suspend(struct device *dev)
+{
+	vmbus_initiate_unload(false);
+
+	vmbus_connection.conn_state =3D DISCONNECTED;
+
+	return 0;
+}
+
+static int vmbus_bus_resume(struct device *dev)
+{
+	struct vmbus_channel_msginfo *msginfo;
+	size_t msgsize;
+	int ret;
+
+	msgsize =3D sizeof(*msginfo) +
+		  sizeof(struct vmbus_channel_initiate_contact);
+
+	msginfo =3D kzalloc(msgsize, GFP_KERNEL);
+
+	if (msginfo =3D=3D NULL)
+		return -ENOMEM;
+
+	ret =3D vmbus_negotiate_version(msginfo, vmbus_proto_version);
+
+	kfree(msginfo);
+
+	if (ret !=3D 0)
+		return ret;
+
+	vmbus_request_offers();
+
+	return 0;
+}
+
 static const struct acpi_device_id vmbus_acpi_device_ids[] =3D {
 	{"VMBUS", 0},
 	{"VMBus", 0},
@@ -2052,6 +2087,10 @@ static int vmbus_acpi_add(struct acpi_device *device=
)
 };
 MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
=20
+static const struct dev_pm_ops vmbus_bus_pm =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(vmbus_bus_suspend, vmbus_bus_resume)
+};
+
 static struct acpi_driver vmbus_acpi_driver =3D {
 	.name =3D "vmbus",
 	.ids =3D vmbus_acpi_device_ids,
@@ -2059,6 +2098,7 @@ static int vmbus_acpi_add(struct acpi_device *device)
 		.add =3D vmbus_acpi_add,
 		.remove =3D vmbus_acpi_remove,
 	},
+	.drv.pm =3D &vmbus_bus_pm,
 };
=20
 static void hv_kexec_handler(void)
--=20
1.8.3.1

