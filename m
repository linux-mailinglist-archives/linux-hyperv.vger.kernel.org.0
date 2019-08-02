Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C08007B
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHBSxA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 14:53:00 -0400
Received: from mail-eopbgr760123.outbound.protection.outlook.com ([40.107.76.123]:39462
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfHBSw7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 14:52:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZJoGKHDPAh0p4GWTICjQSiHX2lz8yRGEaIuBC3pH2zXFpTB3zBln7pO7ZAVV0g3wZgiGyP6pIbs9HW81Hb6kkvuHhUFBQRlqJcoqqjKzOyv3m0Ts75Zd+IODpvZal21z+pEm/5uNbzz9HYAX4FfTZ0XM0gCV+XmvsODcQBouaIJTKv4ro/5iM6gxP8J+MASZo4aGGvovmJAvVgNpmuwwmAdsQB2OpJlbLe185Cvz480mTXEik5KssYClC817zZbGpr62WQ5HFlDCAybob1jPH2mrByulUrf+KWicMuIAexad2sADBXUiBgPwT+UpfysCCO+7npoh2g0MMmzJQJVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RkJeqOvtS7OHB511f9Duvlm60YsovTRKO4dKRZwkzE=;
 b=JLh2XbbBseCZakSsDJKZtmwu9ZebkWvC1RuhjM2WcYp9LEgpRuJK64wrFMiQLsT2rGHf6qN1vaQk2GqchnlnDaFh54kQV3uGKZ0lfuzYOjqa+J7BTekvjSMstCp89yeUM0Lwv9JynZroOc1xstegNiJd7sStVPJYUnoPTiqbjUcBBJsonHquLU+iaz1dh4JJ34mEj4Vv92yTQUwW9yAWf9o6mVaIJZjimI79W1YUk5YEYqQvAC2yL6D6lEPis58TCMjMpwXWipggsniARQQEwFFGb0jEg0pSAaFWrRssjwm1R8XUBzntrKyfH0DgBlu08PygQBFufkgFMOI9CcOdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RkJeqOvtS7OHB511f9Duvlm60YsovTRKO4dKRZwkzE=;
 b=AABuxeNktUBIc5/J7i2Gh5bGRvMAQ6YrIYsoaQNMuqLq8OzWzwNSKL4w4zqWBt5oLFIcZFoYhvFUbYNR98fMVz/jWO02ZOY459eaK6fnQGehcthyb1h5vUpf6ybZAQ6rcWEpoBMUV3YW3wxTUO4c3CX+pBVfh2xvk/HNfXWzJlA=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1193.namprd21.prod.outlook.com (20.179.49.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Fri, 2 Aug 2019 18:52:56 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::6055:de8a:48c1:4271]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::6055:de8a:48c1:4271%5]) with mapi id 15.20.2157.001; Fri, 2 Aug 2019
 18:52:56 +0000
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
Subject: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number collision
Thread-Topic: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVSWN/lxoIKIL/NkaM6ZIBa0Xgpw==
Date:   Fri, 2 Aug 2019 18:52:56 +0000
Message-ID: <1564771954-9181-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:104:4::31) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec105316-18d9-4d6d-98c4-08d7177aa1a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1193;
x-ms-traffictypediagnostic: DM6PR21MB1193:|DM6PR21MB1193:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1193E309922ADC8249133C57ACD90@DM6PR21MB1193.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(6116002)(110136005)(4326008)(3846002)(68736007)(53936002)(66446008)(2501003)(66066001)(81156014)(54906003)(8676002)(50226002)(81166006)(52116002)(71190400001)(6506007)(102836004)(99286004)(26005)(316002)(22452003)(71200400001)(14454004)(2616005)(10290500003)(8936002)(2906002)(486006)(14444005)(7846003)(476003)(7736002)(4720700003)(6486002)(64756008)(6436002)(256004)(186003)(66476007)(305945005)(36756003)(386003)(25786009)(66946007)(5660300002)(2201001)(6512007)(10090500001)(66556008)(478600001)(6392003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1193;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8R3Vlogst0QDhupTPfs2P3b5bVCjS3/KxWs9ilZRn0RTR1Icab8XdK6BWwqv/+OS2TQ7c1htyPBSRkN6wkx7zG5Nk+nGOGY7T2mLW3idKAmMFpSgQXY5Fqr6X5bMLThgOk/Laa+aLMOVbwYA+yoE8ghCdqdAqvKwJOCt69IysYjMoXx/qCb7PzxS1zmnhaA9cDbfHoxOAPTx3XQCJJ7BljTvKsU+f2gLWZPTY02+NHhfzv8WPxUeUoIUkXifrUJ345pbBg5aPFxeKFsZeXKnuFHmH3RzDehnc37TVMgBJ8gA9I6XDW64W160R+TLJLMlBu/G6gNP2CwbT1ew/fHCupzY03sMzS+gswzTMD8LrvRXkINcyzL6aCE+q1SXI4SXpMrvMl4aQ0M94/9uV5sR2m4g+Icwn0U3DuouBkDNCLA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec105316-18d9-4d6d-98c4-08d7177aa1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 18:52:56.3490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7ozA2Lte2gYgTTsyq9boOaQ7kNgDrRLjJV0CJJ0sc8fPgbmE3qPWvEbQ4W6FaaPAaDwp+wjMKKPH9t2WI8k3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1193
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Due to Azure host agent settings, the device instance ID's bytes 8 and 9
are no longer unique. This causes some of the PCI devices not showing up
in VMs with multiple passthrough devices, such as GPUs. So, as recommended
by Azure host team, we now use the bytes 4 and 5 which usually provide
unique numbers.

In the rare cases of collision, we will detect and find another number
that is not in use.
Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 91 +++++++++++++++++++++++++++++++--=
----
 1 file changed, 78 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 82acd61..6b9cc6e60a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -37,6 +37,8 @@
  * the PCI back-end driver in Hyper-V.
  */
=20
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -2507,6 +2509,47 @@ static void put_hvpcibus(struct hv_pcibus_device *hb=
us)
 		complete(&hbus->remove_event);
 }
=20
+#define HVPCI_DOM_MAP_SIZE (64 * 1024)
+static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
+
+/* PCI domain number 0 is used by emulated devices on Gen1 VMs, so define =
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
@@ -2518,6 +2561,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
 	struct hv_pcibus_device *hbus;
+	u16 dom_req, dom;
 	int ret;
=20
 	/*
@@ -2532,19 +2576,32 @@ static int hv_pci_probe(struct hv_device *hdev,
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
+		pr_err("Unable to use dom# 0x%hx or other numbers",
+		       dom_req);
+		ret =3D -EINVAL;
+		goto free_bus;
+	}
+
+	if (dom !=3D dom_req)
+		pr_info("PCI dom# 0x%hx has collision, using 0x%hx",
+			dom_req, dom);
+
+	hbus->sysdata.domain =3D dom;
=20
 	hbus->hdev =3D hdev;
 	refcount_set(&hbus->remove_lock, 1);
@@ -2559,7 +2616,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 					   hbus->sysdata.domain);
 	if (!hbus->wq) {
 		ret =3D -ENOMEM;
-		goto free_bus;
+		goto free_dom;
 	}
=20
 	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
@@ -2636,6 +2693,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	vmbus_close(hdev->channel);
 destroy_wq:
 	destroy_workqueue(hbus->wq);
+free_dom:
+	hv_put_dom_num(hbus->sysdata.domain);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2717,6 +2776,9 @@ static int hv_pci_remove(struct hv_device *hdev)
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
 	destroy_workqueue(hbus->wq);
+
+	hv_put_dom_num(hbus->sysdata.domain);
+
 	free_page((unsigned long)hbus);
 	return 0;
 }
@@ -2744,6 +2806,9 @@ static void __exit exit_hv_pci_drv(void)
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

