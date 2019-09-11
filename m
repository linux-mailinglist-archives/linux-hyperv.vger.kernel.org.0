Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B02B0603
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfIKXiX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:38:23 -0400
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:35718
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727659AbfIKXiX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:38:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEzCjtxWldot3KedsGRWpZCtt4JfUvWqfDm9JATtpu9+GVokpdqzQKv8kXDk0DNl4xPiRpm67RncvvpJwOmPm35h45OdFWF5kDrDubRd1///e9KavFVJIPh1uTBpCIk7x1PsBgWHUWKm6cGrW9wCCL41zQexQ4e/Gzy/h4DRtpiYfQeCZ7uHkXk2o+YrcVnPK64xbyUEUGz4KkgdIBHqotVycx+ZHHZCxf8ocYyuT0rOwH5yCPL7lpPFv5qOuyIDA5brHwyXWT//64plaMB8o74b5ZiaEupGLr1gh42lu+B36Mw8ujW5l1O3O+VJ4NB+WrvaeOeGz8KNX9ALd8Yoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DlLZwW6isbPdVbDQ4/oJebPTV6kdXee37ZfWpTsV9w=;
 b=GzqQBZWxN2c4y5701rJZaozHm/wUANcfOCXWN18m98nOVkqmnWMLWjg7upkwdjBAbXi56FGTYSkt5bHhGxpOc6puyYr2WAe0KPnPcwzYZW3UeMUT7FHTufPvJBUDthWQDsip7KX/3YdSCmOWA2js2L6amcuRNmeO5S3dk0309K83gWSbG+f2YRzE8+5FMIJaRI51GLvc8tzPiAGmKpMuqxizDTiVusexRnrYlEQSidgxJ1mAStAXOuiZsc/zFzR7K5yjwO8sRdaM+C7Z+gB6RbQiqevs7cb7Y44UYcaU9nt5Km5KnkXjBkDFhwzbUDBD8soOhVPbVfuviaiUS+7baA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DlLZwW6isbPdVbDQ4/oJebPTV6kdXee37ZfWpTsV9w=;
 b=ZUPgw+pAaLlHvQJgqdk0rt1yqXuTEHuBCOubP/EapG6jhgHkQgWXbHHvbAdKqzF2/nUJ6EBAl7lRFg8j/aA79aLl3ml4y3ycFJi53s3/KD8Us0eMtZ0UQuZFoTeuGyTQJArr2IyLAwU/nsubTjwfylebUvWvqT78VeQXCJf4DDw=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1087.namprd21.prod.outlook.com (52.132.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Wed, 11 Sep 2019 23:38:19 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:19 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 1/4] PCI: hv: Reorganize the code in preparation of
 hibernation
Thread-Topic: [PATCH 1/4] PCI: hv: Reorganize the code in preparation of
 hibernation
Thread-Index: AQHVaPn9aDMSJjZvRECnLTtcPvbeMw==
Date:   Wed, 11 Sep 2019 23:38:19 +0000
Message-ID: <1568245086-70601-2-git-send-email-decui@microsoft.com>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568245086-70601-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:300:94::34) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d46f05-0466-4555-fbad-08d737111fae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1087;
x-ms-traffictypediagnostic: SN6PR2101MB1087:|SN6PR2101MB1087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB108724B6D163DD8E0C1DFD57BFB10@SN6PR2101MB1087.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(10290500003)(11346002)(2201001)(2501003)(256004)(7736002)(6436002)(305945005)(2906002)(14454004)(3846002)(2616005)(81156014)(81166006)(8936002)(50226002)(66066001)(26005)(8676002)(5660300002)(110136005)(6116002)(316002)(6512007)(66556008)(186003)(66946007)(86362001)(446003)(66446008)(6486002)(64756008)(66476007)(22452003)(71200400001)(476003)(71190400001)(107886003)(43066004)(25786009)(478600001)(14444005)(102836004)(6636002)(99286004)(1511001)(36756003)(4326008)(486006)(76176011)(53936002)(52116002)(3450700001)(6506007)(386003)(4720700003)(10090500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1087;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9VkZEHZKjS9yme7oudYBU9tNos9D7wPPeNDgYnCpSkNetxYqRP3txARQog8IBQzJj/hbrt8rOHpXhMZ2hEdAV5Fpcjtj/+HBb7NMF59KYrHg+eUVI24g0wMrqV98/qJaS2+HZ/VaK0V5A+cQZT+gJx7BqVZV3TVvzZMeeFFsj4TRm9tKS2YYvpHxoKfFKcsZbFtSImefARdVAf45EjoQsnfaof3Ze9nzImu+jUTfd49OIj8/vPQBrJiTgCTNiXus+ZanXsrPS3DY/C5I5kSqaWWHjoPx/B9gVoGuZDh7a/5JKHWK503LavIWwLI2NDEeL95tNXNtQYP3eGVtYR2aRHKd+WPfqTZRXoTjYXDO6UtKPkc0Mn8wFv6vReOskYu3VpHAh8zrl2rpXRyKyd0BFhHodw/m3DiQdAPsa674Dyk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d46f05-0466-4555-fbad-08d737111fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:19.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KC0Dk1XhguFdXL5oRVO2QIEqdppNojxZzJBep7LRyxluxQsy4lTlZh2X3VJfd+xtkxRjIVU0VEKd1IeGe55TGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1087
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no functional change. This is just preparatory to a later
patch which adds the hibernation support for the pci-hyperv driver.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 43 ++++++++++++++++++++++++---------=
----
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 40b6254..03fa039 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2080,7 +2080,9 @@ static void hv_pci_onchannelcallback(void *context)
  * failing if the host doesn't support the necessary protocol
  * level.
  */
-static int hv_pci_protocol_negotiation(struct hv_device *hdev)
+static int hv_pci_protocol_negotiation(struct hv_device *hdev,
+				       enum pci_protocol_version_t version[],
+				       int num_version)
 {
 	struct pci_version_request *version_req;
 	struct hv_pci_compl comp_pkt;
@@ -2104,8 +2106,8 @@ static int hv_pci_protocol_negotiation(struct hv_devi=
ce *hdev)
 	version_req =3D (struct pci_version_request *)&pkt->message;
 	version_req->message_type.type =3D PCI_QUERY_PROTOCOL_VERSION;
=20
-	for (i =3D 0; i < ARRAY_SIZE(pci_protocol_versions); i++) {
-		version_req->protocol_version =3D pci_protocol_versions[i];
+	for (i =3D 0; i < num_version; i++) {
+		version_req->protocol_version =3D version[i];
 		ret =3D vmbus_sendpacket(hdev->channel, version_req,
 				sizeof(struct pci_version_request),
 				(unsigned long)pkt, VM_PKT_DATA_INBAND,
@@ -2121,7 +2123,7 @@ static int hv_pci_protocol_negotiation(struct hv_devi=
ce *hdev)
 		}
=20
 		if (comp_pkt.completion_status >=3D 0) {
-			pci_protocol_version =3D pci_protocol_versions[i];
+			pci_protocol_version =3D version[i];
 			dev_info(&hdev->device,
 				"PCI VMBus probing: Using version %#x\n",
 				pci_protocol_version);
@@ -2572,7 +2574,8 @@ static int hv_pci_probe(struct hv_device *hdev,
=20
 	hv_set_drvdata(hdev, hbus);
=20
-	ret =3D hv_pci_protocol_negotiation(hdev);
+	ret =3D hv_pci_protocol_negotiation(hdev, pci_protocol_versions,
+					  ARRAY_SIZE(pci_protocol_versions));
 	if (ret)
 		goto close;
=20
@@ -2644,7 +2647,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	return ret;
 }
=20
-static void hv_pci_bus_exit(struct hv_device *hdev)
+static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
 {
 	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
 	struct {
@@ -2660,16 +2663,20 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 	 * access the per-channel ringbuffer any longer.
 	 */
 	if (hdev->channel->rescind)
-		return;
+		return 0;
=20
-	/* Delete any children which might still exist. */
-	memset(&relations, 0, sizeof(relations));
-	hv_pci_devices_present(hbus, &relations);
+	if (!hibernating) {
+		/* Delete any children which might still exist. */
+		memset(&relations, 0, sizeof(relations));
+		hv_pci_devices_present(hbus, &relations);
+	}
=20
 	ret =3D hv_send_resources_released(hdev);
-	if (ret)
+	if (ret) {
 		dev_err(&hdev->device,
 			"Couldn't send resources released packet(s)\n");
+		return ret;
+	}
=20
 	memset(&pkt.teardown_packet, 0, sizeof(pkt.teardown_packet));
 	init_completion(&comp_pkt.host_event);
@@ -2682,8 +2689,13 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 			       (unsigned long)&pkt.teardown_packet,
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
-	if (!ret)
-		wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ);
+	if (ret)
+		return ret;
+
+	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) =3D=3D 0)
+		return -ETIMEDOUT;
+
+	return 0;
 }
=20
 /**
@@ -2695,6 +2707,7 @@ static void hv_pci_bus_exit(struct hv_device *hdev)
 static int hv_pci_remove(struct hv_device *hdev)
 {
 	struct hv_pcibus_device *hbus;
+	int ret;
=20
 	hbus =3D hv_get_drvdata(hdev);
 	if (hbus->state =3D=3D hv_pcibus_installed) {
@@ -2707,7 +2720,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		hbus->state =3D hv_pcibus_removed;
 	}
=20
-	hv_pci_bus_exit(hdev);
+	ret =3D hv_pci_bus_exit(hdev, false);
=20
 	vmbus_close(hdev->channel);
=20
@@ -2721,7 +2734,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	wait_for_completion(&hbus->remove_event);
 	destroy_workqueue(hbus->wq);
 	free_page((unsigned long)hbus);
-	return 0;
+	return ret;
 }
=20
 static const struct hv_vmbus_device_id hv_pci_id_table[] =3D {
--=20
1.8.3.1

