Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08938A58E
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Aug 2019 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfHLSU6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Aug 2019 14:20:58 -0400
Received: from mail-eopbgr730128.outbound.protection.outlook.com ([40.107.73.128]:18624
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfHLSU5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Aug 2019 14:20:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfnrkIe5s2QuaZwJ+sgJ6uisgdyCNLByLQ630S03vMBT3ryogUWySX3wPTEL7JUWqYHQB9F3r2TGWazVwNQmd6606A7boX9LJjsSsgcBcgSNdtCHpSncgxdAsumzZx2xKJVuoFdyW0WibG8kxIKtqHob65DoOfLYfk2klCakyRpcIyuCDLFeT5W8+bhHiv/cKtPY+SGGIKluzSBb8+aLaR4iRTrAIuhMDHhYSGIVf+jlrSKB0XnTA3cC6XzSeFWAmv51130mGFRJMn8XnjKg2S1gvxnR9fxSagLUyBVBjg65uSMC+L2jLLzIcJke9zl4gFwm2O5QJ6Xmt8O+YBimHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf4KyVwcAvNntoEj21P2H/GFPThcxmHUEFT5P6Kj6OM=;
 b=VlOWcYXvEQiboPY0DwAN54fIgH8E9r1V9nvTp/VAQ+vE4Afu+Xzu11xBTcG6k+5iHbwOdIrEB5BHQxPJ/yUXXP+gcu+8SJvPlIXM63odxAknZiXTLHpJO/oBwHx2skEUiu8PHBJr34aieRNJIbi62JIYsxnY+bm02V+B2kQJAdxOyo4wzEQy3crnqIK7791FN3mOYBPUu7DnVEdIaZTAtEewXhyfPU9W+9BiHNrztEoCGCVtWZpcucfTRj6CzCedJfrliToKRSgW52Ex73q8BCIhODFFiIDgM3Os7Wiqfc/O2WYpOghNTNTZnimX4SG/4TMbgCZ1Y8y7eoaQzftOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf4KyVwcAvNntoEj21P2H/GFPThcxmHUEFT5P6Kj6OM=;
 b=WOPKJU09z+luAT1P5UtFDlL+vTDgb72pIYikcV9QTws7DYUGI3/syTCEtO47GPiqDdjfbaubJJ/hoDn0zUfNBWFZA4tbDtjmjhYS1gDMng2Yj1HEUbxJeYr+zF4hew+6zLJ7qNZvjmGTkRfbrY4OZUGK3R3q7nsUpUWKxCtkmGY=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1196.namprd21.prod.outlook.com (20.179.49.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Mon, 12 Aug 2019 18:20:54 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726%9]) with mapi id 15.20.2178.006; Mon, 12 Aug 2019
 18:20:54 +0000
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
Subject: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v3] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVUTqte27Lajt/EEyKPTfwyVUozw==
Date:   Mon, 12 Aug 2019 18:20:53 +0000
Message-ID: <1565634013-19404-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:102:1::44) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 142f42cb-29d3-4c0b-5583-08d71f51cfe9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1196;
x-ms-traffictypediagnostic: DM6PR21MB1196:|DM6PR21MB1196:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1196B43A23B5ED9DD791BEB3ACD30@DM6PR21MB1196.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(36756003)(66946007)(6436002)(386003)(476003)(6506007)(66066001)(4326008)(53936002)(14454004)(50226002)(25786009)(66446008)(6392003)(7846003)(71190400001)(102836004)(71200400001)(6486002)(2201001)(6512007)(66476007)(26005)(64756008)(305945005)(5660300002)(22452003)(110136005)(81156014)(316002)(99286004)(10090500001)(14444005)(2906002)(52116002)(6116002)(3846002)(81166006)(66556008)(478600001)(2501003)(10290500003)(256004)(7736002)(486006)(2616005)(54906003)(186003)(8936002)(4720700003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1196;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JkCbnkWv30vfUBeD4xEyTkOS6uWSpljYN/FjRPgwKGRa+j0LI2eKOO2gZDoHR0bP0Z2RuR2mcRexGKJ7ou95OfL42Ui9opdSx/8u5JJgi2rbz0KgZ62P7eer9tT6DSO/Rb4vWWcykFp32kKEN3keDW91NFlJdLEqUF3ap5NArL4jGoZ0x3E4xs8dWuki0XbLWvrZzHS7gbQc0lsNrjc7syMPdt1LeKbHIMe76k9UHmv2LpYxSSb1bhqhhae7eEnu2nZ+W5YH+4NoGZWEULzQjVXAOTRQejtNWzaxlMo4jTp9DyiDKVROzEZLm8/bP3Ka+V1E0p2wuh00t0pHLonmpR/oPHjG3yHFZN5RoiX+MNLNerXS6AuXXVR42ubtmudNGacLLfDPLODFnFLobfqPwE1NC7hHaXFY3ZbsLDDmhAc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142f42cb-29d3-4c0b-5583-08d71f51cfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 18:20:53.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teM4ich8tl42SdXcPpcZkgN5VV69/CiB7H1iBkfqi3/CQHfbC+gJ/uYvK+MN5equA35rMkDxdom+q2ybk77zxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1196
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently in Azure cloud, for passthrough devices including GPU, the host
sets the device instance ID's bytes 8 - 15 to a value derived from the host
HWID, which is the same on all devices in a VM. So, the device instance
ID's bytes 8 and 9 provided by the host are no longer unique. This can
cause device passthrough to VMs to fail because the bytes 8 and 9 are used
as PCI domain number. Collision of domain numbers will cause the second
device with the same domain number fail to load.

As recommended by Azure host team, the bytes 4, 5 have more uniqueness
(info entropy) than bytes 8, 9. So now we use bytes 4, 5 as the PCI domain
numbers. On older hosts, bytes 4, 5 can also be used -- no backward
compatibility issues here. The chance of collision is greatly reduced. In
the rare cases of collision, we will detect and find another number that is
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
index 40b6254..4f3d97e 100644
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
+	dom_req =3D hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
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

