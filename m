Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1677CAF4
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfGaRwV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:21 -0400
Received: from mail-eopbgr810135.outbound.protection.outlook.com ([40.107.81.135]:36140
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729664AbfGaRwI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcaWqxRA/cXsxQmv0XTBqO7WRi5YNapFAJwUGHxTQjQJAhgDOj+hT6olw73MJJq2/7yEmo+knX27O7n0mFNKWqMVE9TzC4bBvUgzWFROYr3JFixR0nTDppePl+Da4Ouaaww6f9hV7SdjvSm2iMdyvqTuZcR2W85ObRHd06IM7MNxjbckICcxNMUIZDAPwEf7iy7RoWdyVgPku8V/Ge6ym52gU83GhrMNK+5iKNBivPfjyCSsorlF3FLUytHF6+9b/ZHI39kVDSIoiIx771BUqSYlsM+l7Y1n43Qy6bVuNM+C7iOIMNIpTpYbLxRLoWhAin+9VHRdV9XCr9mOEzGHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9Dwj8pnl8zPsZLRNgRC19H9r4thxbSWEmgRsve3ALs=;
 b=fLbw3dwqKgztzhf8vTnLL++wTIcmFk5TMg8DuhfTv45NCTo2d0oJ0z3Pr3iTpvRxzbgw3EM5BDdaZjeTzG/8K+Cnw34Z8KjbLkEfsI3YBMrQ4gAR2pNBpNQUTANewte7k71CE+Z8nszmXU7eGcXZHlP4CkDnrq8eTyeaGnKe+BvHmMlYKgUFUQtXSrDLtgVklRMLwsre1UiR78/ViF8T+Fcl3GxrTjdvW4NDtJzCy0mpxRc6GlYwCzXbUBUzqVnSjOmBzD/wYU79Mj5NIAThGbd0fBEkWFMZte97P5CGlHDt6hk1OaBgq1ieP1yap35+n3bk+YjAi6YaGMGCW6buOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9Dwj8pnl8zPsZLRNgRC19H9r4thxbSWEmgRsve3ALs=;
 b=hay1rDZ/c4fXoRwHd9Wo93/ztwDCLZZfghnNiK15+dHcZ3gz9BtajiiOh8gwGm3Zzti6/4vgyk4BMD1NRAZCNVGPfgrXUZFF/0ZRsma/XoTFZRjisOxz99paHd8Oe84ICNPpfcYE9GgdytCjJarQV7M27D/tXSP4QoNzSu6cqZc=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1085.namprd21.prod.outlook.com (52.132.115.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:06 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:06 +0000
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
Subject: [PATCH v2 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Topic: [PATCH v2 6/7] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Index: AQHVR8irwKN9a9RM7USFJWvZUUrDhQ==
Date:   Wed, 31 Jul 2019 17:52:06 +0000
Message-ID: <1564595464-56520-7-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: ed774b39-0272-446e-f869-08d715dfcd67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1085;
x-ms-traffictypediagnostic: SN6PR2101MB1085:|SN6PR2101MB1085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB108599D5E14BB4E0FDF56FD1BFDF0@SN6PR2101MB1085.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(8676002)(5660300002)(4326008)(305945005)(10090500001)(8936002)(15650500001)(107886003)(53936002)(81156014)(81166006)(7736002)(14444005)(50226002)(66946007)(256004)(478600001)(10290500003)(66066001)(66556008)(64756008)(66476007)(66446008)(68736007)(86362001)(11346002)(2616005)(476003)(486006)(446003)(1511001)(4720700003)(71190400001)(71200400001)(6512007)(2906002)(3846002)(110136005)(99286004)(2501003)(386003)(52116002)(6506007)(54906003)(102836004)(26005)(43066004)(76176011)(6116002)(14454004)(186003)(316002)(6436002)(25786009)(3450700001)(36756003)(22452003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1085;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /AUAtKOAbWupI78MEVpJp6gisCt5+xyweRIRph+epqrj8samZzJeHsIvE94AMZv/sfLyZnzsp0PysuyEeym1chGVWqJtEkkbcXC2qUVjG6EVm9HkUqZKlVchNsEZbZhaQYZ9DUJ1bPJJrWv2Q55vfug+sgzK2OrlzbdL0x5iAaIO3Xx49MV2Iy821oBJGo0qarIohhj7VrkuBwemcF3ObgNZx+lbOxT1ZhndXN4/8VhldtLG0FrfLAAM6dHwroXILNiFcETsdaRRqRxZbbZB0Y6HufCzEvcHXXY7an1hXFEcJauqoD+iz8Z/SoYrCxmGUGpfBTI1R3O+iHm2YhT9s4Wi8tbNKqkMNSlYJhOtg3YTtGvBoAy8dmVTWprR/kcwVpUtFvxObxXfY9iNn7/SN2RqHPzSeRUWuksnp1ay3LI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed774b39-0272-446e-f869-08d715dfcd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:06.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aa3cE0gzKUobFFY4TtGDaIwNT9DvKueo7LEoO6SVYJCt9ofk5LlJm2JDx06qCDds7KZ0UXTwB3l/PD10Wbw2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1085
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
---
 drivers/hv/connection.c   |  3 +--
 drivers/hv/hyperv_vmbus.h |  2 ++
 drivers/hv/vmbus_drv.c    | 50 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 53 insertions(+), 2 deletions(-)

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
index 2ef375c..ca6f4c8 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2043,6 +2043,51 @@ static int vmbus_acpi_add(struct acpi_device *device=
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
@@ -2050,6 +2095,10 @@ static int vmbus_acpi_add(struct acpi_device *device=
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
@@ -2057,6 +2106,7 @@ static int vmbus_acpi_add(struct acpi_device *device)
 		.add =3D vmbus_acpi_add,
 		.remove =3D vmbus_acpi_remove,
 	},
+	.drv.pm =3D &vmbus_bus_pm,
 };
=20
 static void hv_kexec_handler(void)
--=20
1.8.3.1

