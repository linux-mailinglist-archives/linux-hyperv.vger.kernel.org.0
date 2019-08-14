Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842278C529
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 02:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHNAi7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 20:38:59 -0400
Received: from mail-eopbgr780131.outbound.protection.outlook.com ([40.107.78.131]:32441
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfHNAi7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 20:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1aQKUWHCEKxjk/DjgrHZmpLeSRiWd0q1TkrG7iJ11YDWI4R9iFmYM+1WffOg6BmlKYJ8F3c4Ui17WJ13EOSGGY6/wAMr9l7gpXDLq08z08mmj7E451B/m891e0Mjnif0BfEQ/qk59Rk1WsFAsCAcd5CFTkvExsO4KRHpIlBIWF+4ys25qgDBChx0U54yMvDmcgz9mdxkI6IkALmmsDofFdo2mZumfaHk48Ik9rqQfvQzG2N/47BuRZdTyavVb/j2QbXKwuHR2rNQqMfvdF9l3OY94SSwQr/5tL7/UDU7W3q0CuqU9x9JG/icxa4ms13T3NvHJj5TRzY2GEKrPNJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdZQK5/4dLKNcFnSnS6D5aRm/B6m2U/qzvud3XhlVIE=;
 b=UlkfkIOCrRTztZSXtWktS0nlQol21uF2xjtm78hCN3yA0yEMvpQHdndaZfY4aXrfDdvWtn2mSVrhOad/yJdmQZ2OPPm9rV8g3901HVfg0QIJMdrxzx6U4WGiU/oarxvcMJDIesraLYEJmvfKfo0amUAnW/+JPIdT7X8m5+Q+HridtLDdRLld8fZhEpnXOu8TcO9MhRN5qQRltW4jXAQu68xehxMz9v26Lf9Xb8zFlLHfoDIS4NaEXK7VMV7dK7s1bYy4+3vr+ZEBQJBLX9vgpLyb11MahBe+rDTQ50e7zc5q8W76Ml1T/xsTMoX3LBQ3XkU+gPJGfIcpZ1WxwNBD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdZQK5/4dLKNcFnSnS6D5aRm/B6m2U/qzvud3XhlVIE=;
 b=VNos3mAYZiKtPV6oUMgwkFIaYvBN11JjLTWjxeLA/AekGbJXeGD+wgGKR1MJh4xk5C/8pqSzmR2rgWoMth426OYiOu1k+IgUZRBLTze38k2+tz9DIaN9FWcrxONRGuq9FWDtvANawS+4LHcHctur7yaXhN055Gy0OMP2hbaenNk=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1514.namprd21.prod.outlook.com (10.255.109.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.6; Wed, 14 Aug 2019 00:38:54 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726%9]) with mapi id 15.20.2178.006; Wed, 14 Aug 2019
 00:38:54 +0000
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
Subject: [PATCH v4,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v4,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVUjimvM3UBIvJXEiYaEn5NujA5w==
Date:   Wed, 14 Aug 2019 00:38:54 +0000
Message-ID: <1565743084-2069-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bbc62fd-4c25-4309-f935-08d7204fc8d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1514;
x-ms-traffictypediagnostic: DM6PR21MB1514:|DM6PR21MB1514:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1514A502C51199EDE3C086EAACAD0@DM6PR21MB1514.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(52116002)(10090500001)(10290500003)(8936002)(81156014)(8676002)(478600001)(6392003)(81166006)(6486002)(6436002)(71200400001)(7846003)(71190400001)(305945005)(186003)(14454004)(102836004)(6506007)(50226002)(7736002)(26005)(6512007)(386003)(6116002)(3846002)(66946007)(2906002)(64756008)(66556008)(66476007)(66446008)(66066001)(2201001)(4720700003)(5660300002)(256004)(316002)(14444005)(22452003)(2616005)(476003)(36756003)(486006)(2501003)(4326008)(53936002)(25786009)(110136005)(54906003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1514;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8Bqw36eISFyhz4dX7Fdv+RgVfo/mn4KlITl3TlnjKHwm+oyWDFXpaGkUaJayg6kYFL9AJetpt9az47/zNPbHTAusFIsvfvSH+e3yByn/wuKIya0t0IyrvIGRvKEdIvy6pfb0DGy1GVs5K8WCU0J+Igbd1wQRw2U0/yyfosDOFd3Nh+NMyUrw6wW77CKesRgcTPPWYwYcHoucoEYPIAIwPEjdZ0ma9sSgfGu8EIu0UW+nFNP5tYIlh4eve1tN3c/4L3jxZR0ecO9bWyMDOaupQ4UQQ5Q8M8/f5pv6P/3s09KUIK6o3s7+4raap9n/dQGeA2VhA88TPD6w92nCQl+JHtuVP1hR44UCcAOQcoMARBJIo5/ppbjKmNgpvsEvlWbDs5TRIVP9zK0ogJjm4iU2imbjnukGzDEcSQB3G5piDKA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbc62fd-4c25-4309-f935-08d7204fc8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 00:38:54.3506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+m59seTXP1gBthdbGey7OWqDqyWa4qZAUxT40ikyKmbuA3xEBcvJg+sU2Us7EbGPV+jwR4Un1ro/RJZjOB+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1514
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

