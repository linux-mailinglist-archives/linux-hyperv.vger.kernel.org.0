Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74333A5E83
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfICAXd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:33 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbfICAXc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXeXnuNnTS4eCBOUlVVuHLoWjd6HwvGjSBJm2hMwsxOTnrDRj8/Mz6rTvYjx614dg1AtRhWucugoubSZdXb2uWMKZaCZARCeLWl920rxVgRrZoI2UzHa8T1ZdU2p+w9mbAtk1CsXdKu8c9FwCVbASejGMqrW9hsLd71RVfz+TT3h323EUvJFdDn/TfjOSnfffnNsTkJ9gHMebjpR2JxpjM0nrivPPQGvwzLWDMIXSPzXYnSg6LtAN2qV7wJ4frqigH2tBj+dx8iXm5umMYtLlCb4HEswux0JKpotp3eTaeebYPE+LlDKxq7AxKd9fBllUU0up47/VWyJOdT8dBgpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB8dWMA5ZHkvUBXJrCZ9+x4SbYLIqw8xH3dAoHEVa6s=;
 b=h9sUq23QnuYEhuFYXlgdn60UyjLJagImF1jVA2upX7OCJhG9xTh/X5qX++DEmvqVfPyi8mbEalLv+ChtwzpcjZwMvMYhwIVdRU+9GTVOYcr6KAZo7h8PLja/SBAqLCzd8FUCbZa6jf53R5BN7YgJOK9N2YPp7o2upndHAVYF3h6xb6voYWYWd390kdSmi9CrzZpbpBQSIBNlslI17AWRTLZpfgIySj1T9yBsQaEHC+G4gCv190/cA38Yhopyrw0V7pnv+G7j/gVqkCRcJiOmesRRrgWdO+bxZifFm5aIjK3yE1qZZgLSEJHmReAh/UoqdjMWKg1W0qTzRhmiRYEfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LB8dWMA5ZHkvUBXJrCZ9+x4SbYLIqw8xH3dAoHEVa6s=;
 b=ld9n6la5BLITyPIMVrlV3WA8+XSwk3UBrMmMZp5VFBjhu+2v1KVCnTYFcZHHMltysJJZnh8JGowijJ8jRTa/4nQtyZRkepY3ro/sd+iXI9Uvcr7Ui62ofx3HxSTLeBIYIIvpZV0HqiW+QGQiwjJghE9UaGo44rD2FrsNh+q1Nr8=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:23 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:23 +0000
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
Subject: [PATCH v4 09/12] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Topic: [PATCH v4 09/12] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Index: AQHVYe3M26JThr30bk2d0875UaIgmA==
Date:   Tue, 3 Sep 2019 00:23:23 +0000
Message-ID: <1567470139-119355-10-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 14047024-6702-4175-680f-08d73004ee92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10543BC684885E3649CE76E4BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(15650500001)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ZoLxOZxrm9uh0UawgY+dEJa8jHqZm0fxKoi+vjaqeXotFLzU9m/RDl+3wkdL2PNq6Nsri3l51RDjIRH6SJeJT12n7hUUVqRGi2YnUTTQDpBsjUePkFetReYCjKVGLggF02c1g7Wu168HEbCEzjGzZu+hQPXamf8d8449ve7ViABUuYsV0kOjH1DPj9vJ+pcFt+1u6moU/ZRAeoJGwF6gTmy9A+2cTFAKItd19HjJh7vWP5DeMZESmd8cOlZyGQYgK/rRNE2PweTk2cfdBSuquOHsloPAQmWgLbIMClms2BxBvdBZTCJVvkGfBpc1mQj6dEjEk0eLAY4oRqwqsSl0IRVbPevjAlwrcRgDFtHZo/Zy90YrFfV2b28o3I3pWNgVo4i3uxBKv584t238UruLLMqXPptb88lBejds+bBcWk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14047024-6702-4175-680f-08d73004ee92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:23.8528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOiuGW8ybk2j4xJ/f2ep7rtGIwS8sbWWo6lxB1n/x3gzPSOOLR38yJVol1zlJPpgBykRYDMBYVbHmldchBSU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Before Linux enters hibernation, it sends the CHANNELMSG_UNLOAD message to
the host so all the offers are gone. After hibernation, Linux needs to
re-negotiate with the host using the same vmbus protocol version (which
was in use before hibernation), and ask the host to re-offer the vmbus
devices.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/connection.c   |  3 +--
 drivers/hv/hyperv_vmbus.h |  2 ++
 drivers/hv/vmbus_drv.c    | 59 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 62 insertions(+), 2 deletions(-)

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
index 9f7fb6d..613888e 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -272,6 +272,8 @@ struct vmbus_msginfo {
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
index a30c70a..ce9974b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2089,6 +2089,51 @@ static int vmbus_acpi_add(struct acpi_device *device=
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
+	/*
+	 * We only use the 'vmbus_proto_version', which was in use before
+	 * hibernation, to re-negotiate with the host.
+	 */
+	if (vmbus_proto_version =3D=3D VERSION_INVAL ||
+	    vmbus_proto_version =3D=3D 0) {
+		pr_err("Invalid proto version =3D 0x%x\n", vmbus_proto_version);
+		return -EINVAL;
+	}
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
@@ -2096,6 +2141,19 @@ static int vmbus_acpi_add(struct acpi_device *device=
)
 };
 MODULE_DEVICE_TABLE(acpi, vmbus_acpi_device_ids);
=20
+/*
+ * Note: we must use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS rather than
+ * SET_SYSTEM_SLEEP_PM_OPS, otherwise NIC SR-IOV can not work, because the
+ * "pci_dev_pm_ops" uses the "noirq" callbacks: in the resume path, the
+ * pci "noirq" restore callback runs before "non-noirq" callbacks (see
+ * resume_target_kernel() -> dpm_resume_start(), and hibernation_restore()=
 ->
+ * dpm_resume_end()). This means vmbus_bus_resume() and the pci-hyperv's
+ * resume callback must also run via the "noirq" callbacks.
+ */
+static const struct dev_pm_ops vmbus_bus_pm =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(vmbus_bus_suspend, vmbus_bus_resume)
+};
+
 static struct acpi_driver vmbus_acpi_driver =3D {
 	.name =3D "vmbus",
 	.ids =3D vmbus_acpi_device_ids,
@@ -2103,6 +2161,7 @@ static int vmbus_acpi_add(struct acpi_device *device)
 		.add =3D vmbus_acpi_add,
 		.remove =3D vmbus_acpi_remove,
 	},
+	.drv.pm =3D &vmbus_bus_pm,
 };
=20
 static void hv_kexec_handler(void)
--=20
1.8.3.1

