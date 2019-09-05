Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA82AAEDD
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391356AbfIEXB2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:28 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389666AbfIEXB1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STO5RZ4cGbVKFRXBzzxht3vKE6kqQgjJWAbkrCBga6Eu35p9Dvzx6trikNAyOFpRfA1WdO40BdtOSBAAgEp+nsFZrjqWXPrixVQ6w5DYUJ06fX3hiSPNwwekv3sQLM5SuZknPooIzFzCYzKw+XXSrarqpeDUStg7r9n4u046h9jxVIftSIImntLju9zSx97MUOpH/Ye5zL8B17B71eswXAylxHJ6w9R5l7oZAlQTu0PLBrawPtQyyrvjsBqq6qOmXHwB20k3foyPoZh8I4gTVvt8aGR4Ksa7hUur5e6yxycoxpWEeFPiGwzzdG4kaLWcjqS2zNvBUtWZiCDmIsyv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDQL47Obz9qLdX9kqrsbhoodsVUqAN/2EGMDc6DU0Ec=;
 b=RuElDWTJAIl4CEwJPUPRTd+hEmjeGYyuqAs/DkNPwVfVkgcNrW7eXSW52fV8oba/r8KsYTmpOJzbGNWykVHiQErSxw5Z6WvUoy/4OTmCZDd+GzAa1lkj56cXEWPm+3bxmDESy6XuakpDWzLxv6JvPpHCuOUVSl9TT/NXmhaLLnKOjnYHW9QZwhQsoQ4KtU/Yk5303BxleOl+PaBtHQVYXS/h7X+Ql7YoQruBexos7uLx7DrWmi1Gua20wSQbYpKL1J4Hgf2INi7Ywk62Vg2mJymnx8ZWP1PPFP+kq4l6CqR2WTk4Na4JEGLHT5VOdOrR5UIAfw4wej2t9GgbOMuL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDQL47Obz9qLdX9kqrsbhoodsVUqAN/2EGMDc6DU0Ec=;
 b=KwGe9GeKPBh/0V77x5HdVEbeRqm9e9I9Or1XTUzD4F6m3a3jp6DUwRabO+c6PT+Eo3FgyppYU8DnIKNRFQqfKs2QwZqlOsplBLuj3zTBNN2G/LuJrLSjDnCxeg2lbJk1m6jkOrankmkFcFwxiGkWIL43SLjRPtaKVURlwSVIvtQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:20 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:20 +0000
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
Subject: [PATCH v5 6/9] Drivers: hv: vmbus: Suspend/resume the vmbus itself
 for hibernation
Thread-Topic: [PATCH v5 6/9] Drivers: hv: vmbus: Suspend/resume the vmbus
 itself for hibernation
Thread-Index: AQHVZD3UFEOseB0gRU+reD9zfGQl7Q==
Date:   Thu, 5 Sep 2019 23:01:19 +0000
Message-ID: <1567724446-30990-7-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: e9cb8299-d0ea-4724-058b-08d73254f6b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1038FB546851E9554B8675B6BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(15650500001)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VemsxEICkdZJOZtIRTLi4j7+Je8a1rYTJgECcNZnaWR1EEgG2613n+l0r0qRxZTU+BQzuO//U4HR/ra+O54QUrKCv+6uE9tr28gIRcK2kOFL8Atl45MMyUmE4vQWBOaDNZUz/dnO9g+HM4w3yJUGazJK35hyzLaZlKHryCyov2e5H8/OLcn9Kxel9ApSWvK5HFDrceeqsfJajHnqhgbAc0pwCgXumwO6ueR9eRBUOtydZGKEDjJzeta42h7q9oFBuZkIkGWFvb9abtUuuccalqMvnsWFYO7EsNtXpPcbEeUUjNyYKrslocKQyj7Vx5xh8jHSY9nsa6etoSoZGg5EQqIc3Fa1JfzAozvFM7IN7S6GcyMh1VtnzWYRE59kYx+1eJ8Eh2DD4v9Tj6p7U0JlIsUfks2t0oSKiCa8xW8eokI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cb8299-d0ea-4724-058b-08d73254f6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:19.5588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfHkIPkfHKeHDkpJKeREXgwaa1u1uTaXv8AEYX5Ce6xRnZBwh8QaK3QtKXsggdYjTbC8aYZ3vDTNM0H4wVeRYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
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

