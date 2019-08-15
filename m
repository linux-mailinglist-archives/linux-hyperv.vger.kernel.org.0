Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6E8F17C
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2019 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfHORBo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Aug 2019 13:01:44 -0400
Received: from mail-eopbgr750113.outbound.protection.outlook.com ([40.107.75.113]:62849
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729157AbfHORBn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Aug 2019 13:01:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be5QrdWuZvCKXcbZm+tfPCsnJhN0uCthgV4u7QqyNE5P+VIqKqdp239lBhBQAfdCaOisWHN3XZYBjxLXyLN+HdBjs6GRUuf+dkGauHvEUJOcv6PvGZvgy7vrTD9UmKJA5uILINb55gtCuUs8eSnSo+shmbjPjjBITjHoUaOXZbG9xKolOiplRYpxuAu18zOHBspDpNLQGvM5DFMiMpCsfgCw+89XIXOXBvKqPECVj6JDD87FpQkjGQ6X/vYXhQ3Mo2WyMwOVCVnBFc1D2FQwTlwowWlGQAIQo+PqDA2qfu6R+G025j6l3HtlGCL4ejeOkerIH7FLO0YmfgJfAY/b7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYXLB9QH03DRrt/g7GmMnFuBvrhmdPH6xDGeDeuFD6o=;
 b=KNcA4Ds/4yZF2zpb8T8hhOrgmRYnzshp4U0HqeXN0rCZIKUqYmAxSSI/9ncZEdnIqMepNEWA/s1Phdd+wyMk/IZmeCcseF9XVvQnEvXvhIexWSdlrdkChrWbqD+3PWfYrrvyohZR5US/2UL0I3eDZVDFBPLXZy6aYRyP0S3zyzFIEwM1VqGSPDPlCPbuSYsAAvUyuGqtR03TgIF2D1Zu6LliLrWq99RKbYFl1gJIgE6DRNS8uFPIxgr8qJI+eXKBdLudC7rN8NH4CeWSD7V3ciANta6yCoDRCgJNA/qEUpaQQE+r7b20mMkZGyQtMaZm6J+qQ/12tFNQ/FTC9iQbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYXLB9QH03DRrt/g7GmMnFuBvrhmdPH6xDGeDeuFD6o=;
 b=IQ6BfTgK339I0Mk02eEU+y66tW1aQPjYOqN98YrgE/MsmakkqD2OKd3lJnaH2rSrbjK3TPRrUEfa5lzsshB3tuN/d5aFHHg/qIEYdzzE2gDMp+hUQtKnsZdbX55Rs/NciI10OaAytlAnWyneOJRwM1DCcMZms9n8m5WqptFJk6k=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1306.namprd21.prod.outlook.com (20.179.52.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.11; Thu, 15 Aug 2019 17:01:38 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726%9]) with mapi id 15.20.2178.006; Thu, 15 Aug 2019
 17:01:38 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v6,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v6,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVU4sZzIMW0sD7mkCdS1T3X/90YA==
Date:   Thu, 15 Aug 2019 17:01:37 +0000
Message-ID: <1565888460-38694-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:300:16::18) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5635d337-877d-4e1a-3c80-08d721a23c16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1306;
x-ms-traffictypediagnostic: DM6PR21MB1306:|DM6PR21MB1306:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB13069787B449E4B550E4941FACAC0@DM6PR21MB1306.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(52116002)(6506007)(26005)(2501003)(6512007)(110136005)(316002)(66946007)(54906003)(7736002)(305945005)(22452003)(66556008)(4720700003)(6486002)(64756008)(8676002)(102836004)(3846002)(66446008)(99286004)(66476007)(6392003)(7846003)(6436002)(14454004)(6116002)(386003)(2906002)(476003)(2616005)(486006)(36756003)(25786009)(10290500003)(81166006)(478600001)(81156014)(66066001)(256004)(14444005)(50226002)(2201001)(5660300002)(186003)(8936002)(10090500001)(53936002)(71200400001)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1306;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FB8DZNjBVkWTTo2uSIRKEWsFw1g5lIQNH7TdY/ZrOP795hAsihFUPn/Ri4yEx0K+P8qmKivjJ4PjdXzXcwxmVfc9W0tSNKs6PxGN7OB5NetMYJ+sJRT+DU/hiPeR6yvmqiST9aTUx4FssvX3sRJZjzd933hU5EMcrgMkhX5dmpWwAcUSUHlWH+TjQJLxzVk3a/nFhik/APjV9vcT5eKO/dSbkxTm8kULsO2LluV8rYiL5UkGzuQk6MCnpoQwJSe9SGF4MZwyJl/btUzjhu1Nfrolvphcvb5kUc5yLdTTCyY5VNIiVnvTivoaC/33cTNMlEVn3mrGJZtOi1TBgj3XqHxN9Lw3Z7M6QEDi0m3Yuhou15bomNiEFYBi3N8ZT5Ews/jL+crLWMf0XYlVPBkONgCzLVPhoepOXBrwgog0A/M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5635d337-877d-4e1a-3c80-08d721a23c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 17:01:37.9499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmWRZLT2a6HQU/C5dMVhCgz62i2leGnVi1NuDaqbXSE3MeWpZ/lvXL6kT0ggox5H2UbYuFo08uLTHYRBCbN06g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1306
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently in Azure cloud, for passthrough devices, the host sets the device
instance ID's bytes 8 - 15 to a value derived from the host HWID, which is
the same on all devices in a VM. So, the device instance ID's bytes 8 and 9
provided by the host are no longer unique. This affects all Azure hosts
since July 2018, and can cause device passthrough to VMs to fail because
the bytes 8 and 9 are used as PCI domain number. Collision of domain
numbers will cause the second device with the same domain number fail to
load.

In the cases of collision, we will detect and find another number that is
not in use.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Acked-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 92 +++++++++++++++++++++++++++++++--=
----
 1 file changed, 79 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 40b6254..31b8fd5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2510,6 +2510,48 @@ static void put_hvpcibus(struct hv_pcibus_device *hb=
us)
 		complete(&hbus->remove_event);
 }
=20
+#define HVPCI_DOM_MAP_SIZE (64 * 1024)
+static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
+
+/*
+ * PCI domain number 0 is used by emulated devices on Gen1 VMs, so define =
0
+ * as invalid for passthrough PCI devices of this driver.
+ */
+#define HVPCI_DOM_INVALID 0
+
+/**
+ * hv_get_dom_num() - Get a valid PCI domain number
+ * Check if the PCI domain number is in use, and return another number if
+ * it is in use.
+ *
+ * @dom: Requested domain number
+ *
+ * return: domain number on success, HVPCI_DOM_INVALID on failure
+ */
+static u16 hv_get_dom_num(u16 dom)
+{
+	unsigned int i;
+
+	if (test_and_set_bit(dom, hvpci_dom_map) =3D=3D 0)
+		return dom;
+
+	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
+		if (test_and_set_bit(i, hvpci_dom_map) =3D=3D 0)
+			return i;
+	}
+
+	return HVPCI_DOM_INVALID;
+}
+
+/**
+ * hv_put_dom_num() - Mark the PCI domain number as free
+ * @dom: Domain number to be freed
+ */
+static void hv_put_dom_num(u16 dom)
+{
+	clear_bit(dom, hvpci_dom_map);
+}
+
 /**
  * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
  * @hdev:	VMBus's tracking struct for this root PCI bus
@@ -2521,6 +2563,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
 	struct hv_pcibus_device *hbus;
+	u16 dom_req, dom;
 	int ret;
=20
 	/*
@@ -2535,19 +2578,34 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus->state =3D hv_pcibus_init;
=20
 	/*
-	 * The PCI bus "domain" is what is called "segment" in ACPI and
-	 * other specs.  Pull it from the instance ID, to get something
-	 * unique.  Bytes 8 and 9 are what is used in Windows guests, so
-	 * do the same thing for consistency.  Note that, since this code
-	 * only runs in a Hyper-V VM, Hyper-V can (and does) guarantee
-	 * that (1) the only domain in use for something that looks like
-	 * a physical PCI bus (which is actually emulated by the
-	 * hypervisor) is domain 0 and (2) there will be no overlap
-	 * between domains derived from these instance IDs in the same
-	 * VM.
+	 * The PCI bus "domain" is what is called "segment" in ACPI and other
+	 * specs. Pull it from the instance ID, to get something usually
+	 * unique. In rare cases of collision, we will find out another number
+	 * not in use.
+	 *
+	 * Note that, since this code only runs in a Hyper-V VM, Hyper-V
+	 * together with this guest driver can guarantee that (1) The only
+	 * domain used by Gen1 VMs for something that looks like a physical
+	 * PCI bus (which is actually emulated by the hypervisor) is domain 0.
+	 * (2) There will be no overlap between domains (after fixing possible
+	 * collisions) in the same VM.
 	 */
-	hbus->sysdata.domain =3D hdev->dev_instance.b[9] |
-			       hdev->dev_instance.b[8] << 8;
+	dom_req =3D hdev->dev_instance.b[8] << 8 | hdev->dev_instance.b[9];
+	dom =3D hv_get_dom_num(dom_req);
+
+	if (dom =3D=3D HVPCI_DOM_INVALID) {
+		dev_err(&hdev->device,
+			"Unable to use dom# 0x%hx or other numbers", dom_req);
+		ret =3D -EINVAL;
+		goto free_bus;
+	}
+
+	if (dom !=3D dom_req)
+		dev_info(&hdev->device,
+			 "PCI dom# 0x%hx has collision, using 0x%hx",
+			 dom_req, dom);
+
+	hbus->sysdata.domain =3D dom;
=20
 	hbus->hdev =3D hdev;
 	refcount_set(&hbus->remove_lock, 1);
@@ -2562,7 +2620,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 					   hbus->sysdata.domain);
 	if (!hbus->wq) {
 		ret =3D -ENOMEM;
-		goto free_bus;
+		goto free_dom;
 	}
=20
 	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
@@ -2639,6 +2697,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	vmbus_close(hdev->channel);
 destroy_wq:
 	destroy_workqueue(hbus->wq);
+free_dom:
+	hv_put_dom_num(hbus->sysdata.domain);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2720,6 +2780,9 @@ static int hv_pci_remove(struct hv_device *hdev)
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
 	destroy_workqueue(hbus->wq);
+
+	hv_put_dom_num(hbus->sysdata.domain);
+
 	free_page((unsigned long)hbus);
 	return 0;
 }
@@ -2747,6 +2810,9 @@ static void __exit exit_hv_pci_drv(void)
=20
 static int __init init_hv_pci_drv(void)
 {
+	/* Set the invalid domain number's bit, so it will not be used */
+	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
+
 	return vmbus_driver_register(&hv_pci_drv);
 }
=20
--=20
1.8.3.1

