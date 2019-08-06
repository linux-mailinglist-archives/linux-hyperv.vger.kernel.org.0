Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AD083E0A
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2019 01:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfHFXwR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Aug 2019 19:52:17 -0400
Received: from mail-eopbgr760105.outbound.protection.outlook.com ([40.107.76.105]:6036
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfHFXwR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Aug 2019 19:52:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkvaXponIbazxcyZ+pnXVHqwlFNF7nAjKaLwpe9IVa6sz8oM2sE37NXxERF/B3PHu19L6I4hck67a4pr+Fc9cxrIqMBAm3IPGdCbuxSSZ60Q0MvpiByOyyzxh72yPKwqjBe7sxDP+3mtjgDPaKoSim/DNkSMBp0Bq5afYQdQ+up9z+om6auNmpEgdnDMFvfffzfIt5kNXDCvxtwVNizEmdyEEWcXOvK18zR73h+N5tchTw+jc5T6LQNYv9tIplKrlQIWECroU9fzGBDkh7xHnhz8zSxAV9z8F7IOGEhqQibuP39G4WF9xWAF8sVPgr4INhMFOsFCD4UiQXb8qkehWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdGooF6lqIGjaxd5CDiKNX8zauUOGDGtFj2redNTTHk=;
 b=hyTlnl2WJ5GV+uDo5qklUKGlvcqheI/9toproHsoQOe3lC/Wh6i/NNvEDPZeHhq3Ym9DkFcBhQyvRIpNXtFEIO/A0hl0gZ6vXKZmIM9AqHtyiuhqI5RqwWYU6k1FL1E2QhEycebyDw/cCwAgkHFSdOh9i0zImfCQqWM2CIqOpIMyLF2zFqeSlpps9VB4lQivmsUJYLis3CSSSkSAwJvuUPaKd+K8iAouqm9aXEeOqY8JK7oTr2AQSQ+KcTfxLc81idxut0Pw23baTmkrPOGa2ue5juGkrlQ955EZXTMKv+OmXnhZ6zgbaUFEEKHiUVA4QSXV3BJ+nMt8RkbHfTWWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdGooF6lqIGjaxd5CDiKNX8zauUOGDGtFj2redNTTHk=;
 b=Va9aDLWB+UkfoAOVm1fEQb3roC4BAKpBMdR85ZHIEFrawpeHDDOp+/YSbZJM5hYPrlyL7Y0EzgLPHxbdW9SxQVz1rKCkZPFGHhTnU/cOPyZSMulxOg/mQewO9dnpAQM3OgE+/oLCJVs8TXMPBed0vIELgLbPEsdhaZPbM3PvAO4=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1322.namprd21.prod.outlook.com (20.179.53.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.8; Tue, 6 Aug 2019 23:52:11 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::6055:de8a:48c1:4271]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::6055:de8a:48c1:4271%5]) with mapi id 15.20.2157.001; Tue, 6 Aug 2019
 23:52:11 +0000
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
Subject: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVTLH3GagQ2bG1NUyV/+P043l1Zw==
Date:   Tue, 6 Aug 2019 23:52:11 +0000
Message-ID: <1565135484-31351-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0035.namprd02.prod.outlook.com
 (2603:10b6:301:74::48) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71584e17-55a7-40da-5269-08d71ac91987
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1322;
x-ms-traffictypediagnostic: DM6PR21MB1322:|DM6PR21MB1322:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB13223876D2E65DC5CE5499C1ACD50@DM6PR21MB1322.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(4720700003)(66066001)(5660300002)(8676002)(476003)(7736002)(50226002)(486006)(66446008)(66556008)(305945005)(53936002)(186003)(36756003)(66476007)(2616005)(64756008)(99286004)(26005)(81156014)(316002)(386003)(6506007)(10290500003)(4326008)(102836004)(66946007)(478600001)(2906002)(6486002)(6116002)(3846002)(2501003)(52116002)(14444005)(14454004)(110136005)(256004)(6436002)(25786009)(22452003)(6392003)(54906003)(7846003)(68736007)(8936002)(2201001)(6512007)(10090500001)(71200400001)(81166006)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1322;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DcPKfhxCDO5erbuAFjV9bEaqRK9RGCqYLDtvcUSwE6e5swVmcw+wcnkd6sG1wOjqwXNBqbrdosgz23xv4wiAu4op1NuprqBIsYacUewVDHlVx4AnB1mNXNVFF5iyzhnN5YHN90/A+Njmds/d/sbXb4jIRA0R/MzFzOvINUB9KrZWm4tzkWppYfNf1nL4HgRnN5RpuiAKthZ1sgBXpabh13owtdGAceWIbJHu5AFV9O4VFmUU+8pNrnxNv8r8QjZ0HX7qfe+r95UUGQS86RDcyfymsPs8XhwfdHLKEm4QjE6JWDvYg5ZQsp3lGCEfdmFZdNy5lZmWiASBMQkUpFYNW82S1CpUBsS5q5f4W05kR+cNyNVZcfklVVN1WrcgBZ22T/7dRBB5ikfroE6va7MjJ6xYrjsgQhfNulD5+BZDT18=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71584e17-55a7-40da-5269-08d71ac91987
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 23:52:11.7220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i67uNrdCbs7LkM4nYyVld3tTtQt7EQU77ZgC4yKVQ/Sn8zRZbVEGgK9OlCk5hsP5FYp1iz2jK+t8nLfTes5xpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1322
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently in Azure cloud, for passthrough devices including GPU, the
host sets the device instance ID's bytes 8 - 15 to a value derived from
the host HWID, which is the same on all devices in a VM. So, the device
instance ID's bytes 8 and 9 provided by the host are no longer unique.

This can cause device passthrough to VMs to fail because the bytes 8 and
9 is used as PCI domain number. So, as recommended by Azure host team,
we now use the bytes 4 and 5 which usually contain unique numbers as PCI
domain. The chance of collision is greatly reduced. In the rare cases of
collision, we will detect and find another number that is not in use.

Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea.

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

