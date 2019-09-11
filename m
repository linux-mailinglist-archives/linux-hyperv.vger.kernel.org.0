Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E29B060C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfIKXib (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:38:31 -0400
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:35718
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729345AbfIKXia (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:38:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHyuRCDV/MHXjio60hoc/4EROQdrXXfkYr3Zl00fQ2uLZwZZckcpl/+11Sag1bI+eKlZtJhg4P3JCB12aMJlx1RmL8ZGtRwhql1ornKOHTW0m7NUMpHsTVEkhuOGcNU2x/XkZcbWXMm5LyR0C7usJsqsiEVowAXzYYwiM1dupffzBDsopM+l0vSqAvLFm0pNPsMmKVjARuwwkyPEg+/KHKGUBno4m4VltpOZPZtqaKG2GE0rV5sOWFK6amoUCddiMyrs8XZLGdcDPmZhHjxwsTgbpAz3ERVl0iNQEr0HSI0Mei9I8jSf38TuuzExuqtKSIgMzRRD+PasXL/f/26vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwvGZPYQQ+QmtJQSstOMKl1M2qPluYhNpTF//MX3ZAI=;
 b=CO3nkfXHaEkmrYKS08UgpJYhfGoaxyivAuPrFNdD61X+pM6pI4eK7Ic+1aneo2ukIUZy/k8njmgOenQMJz4tjMEw+mH7EpVgBhDq7L0B42xrdiAsFG7bU87C0vgoDCsh0Zkl986j7g7EHgbH/5jQpWcPV0PN9SrB+zNwrZY97JWGqo9DUKE/u4xPz+49AghXdqS2yHqTA2KrtAVcvZpH7zlNsk8UQMQs/6XvIM6pDxRweT8Rh+QSPkg+BtXohiQ5gCZX12RckZI1f1QQY6LXe+GPUaejZ1KQB5m2tMZWPG92sxETMXbIMfp7ibKffyXFQmvNiuyyKdZXcvt8gMn/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwvGZPYQQ+QmtJQSstOMKl1M2qPluYhNpTF//MX3ZAI=;
 b=JP4xD+yPq0T0R8XR0ilgWl5rYix1a5s9HHNcZpMiegf93/cviFCRLhnnWyLqf1lZcQC1LBqJlTlZaVWXHliPj5OehIDOTK891WDcU2V8GVuEbziPdgEEcLcUoXjqGMxD1lYcAKzSf0ffAOQB123n46z3+laOAd2M6FMzetjTcss=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1087.namprd21.prod.outlook.com (52.132.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Wed, 11 Sep 2019 23:38:23 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:23 +0000
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
Subject: [PATCH 4/4] PCI: hv: Change pci_protocol_version to per-hbus
Thread-Topic: [PATCH 4/4] PCI: hv: Change pci_protocol_version to per-hbus
Thread-Index: AQHVaPoAFdEKC5iwakqGSO4n9CfPoQ==
Date:   Wed, 11 Sep 2019 23:38:23 +0000
Message-ID: <1568245086-70601-5-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 641a4b42-a458-4149-49b3-08d73711229b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1087;
x-ms-traffictypediagnostic: SN6PR2101MB1087:|SN6PR2101MB1087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1087039FAE0F890C29E414A7BFB10@SN6PR2101MB1087.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(10290500003)(11346002)(2201001)(2501003)(256004)(7736002)(6436002)(305945005)(2906002)(14454004)(3846002)(2616005)(81156014)(81166006)(8936002)(50226002)(66066001)(26005)(8676002)(5660300002)(110136005)(6116002)(316002)(6512007)(66556008)(186003)(66946007)(86362001)(446003)(66446008)(6486002)(64756008)(66476007)(22452003)(71200400001)(476003)(71190400001)(107886003)(43066004)(25786009)(478600001)(14444005)(102836004)(6636002)(99286004)(1511001)(36756003)(4326008)(486006)(76176011)(53936002)(52116002)(3450700001)(6506007)(386003)(4720700003)(10090500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1087;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1fxsbW9tHbAaMqi9QoRcz9jN++hBndQxKAC379aU9Jsv3wDqqnBmy/436IRhpJYgMQE9Z5PpwyL7CX+VkoO6RltNvsw6I6MjjiOI7XzNNz/KyLasfDjr6Eb54z40qej/QuKTI9oHxCQqVebma0VpqY/4yZyVHpB58LKYjDhSzKAr9LnRg1RPqVsvtg/OBSM12tltO9xVYcRq+TPnVLEtwtOTd7GrAeLtIn2LFrbYtw0JW8rUIQt12hbbPdJNK5uKXq7JDpyop5QmkW4bIuy7y+boGSxeC4vF8A6g8EIM4QsIbBwte6XXCe15pQKlbOc5ugIpb8BqWuZkq93fhdkt0pVsAn3GkhjrwnNA7D+TOo2gz2f6KqMcsArxxgAzPmWLlUbrC3MKNHplK8Q+mMOUcx+hr9w76/qJmfdyzW7BYqM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641a4b42-a458-4149-49b3-08d73711229b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:23.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbAnGWRftTKDca6wOOC0joVMLEU9fHHAs/gRbhEH8SpFt1fOsOQyJ/40lu7JvaYLIfWboujut2BtsXnX6/nz3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1087
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A VM can have multiple hbus. It looks incorrect for the second hbus's
hv_pci_protocol_negotiation() to set the global variable
'pci_protocol_version' (which was set by the first hbus), even if the
same value is written.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 2655df2..55730c5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -76,11 +76,6 @@ enum pci_protocol_version_t {
 	PCI_PROTOCOL_VERSION_1_1,
 };
=20
-/*
- * Protocol version negotiated by hv_pci_protocol_negotiation().
- */
-static enum pci_protocol_version_t pci_protocol_version;
-
 #define PCI_CONFIG_MMIO_LENGTH	0x2000
 #define CFG_PAGE_OFFSET 0x1000
 #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
@@ -429,6 +424,8 @@ enum hv_pcibus_state {
=20
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
+	/* Protocol version negotiated with the host */
+	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
 	refcount_t remove_lock;
 	struct hv_device *hdev;
@@ -942,7 +939,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	 * negative effect (yet?).
 	 */
=20
-	if (pci_protocol_version >=3D PCI_PROTOCOL_VERSION_1_2) {
+	if (hbus->protocol_version >=3D PCI_PROTOCOL_VERSION_1_2) {
 		/*
 		 * PCI_PROTOCOL_VERSION_1_2 supports the VP_SET version of the
 		 * HVCALL_RETARGET_INTERRUPT hypercall, which also coincides
@@ -1112,7 +1109,7 @@ static void hv_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 	ctxt.pci_pkt.completion_func =3D hv_pci_compose_compl;
 	ctxt.pci_pkt.compl_ctxt =3D &comp;
=20
-	switch (pci_protocol_version) {
+	switch (hbus->protocol_version) {
 	case PCI_PROTOCOL_VERSION_1_1:
 		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
 					dest,
@@ -2116,6 +2113,7 @@ static int hv_pci_protocol_negotiation(struct hv_devi=
ce *hdev,
 				       enum pci_protocol_version_t version[],
 				       int num_version)
 {
+	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
 	struct pci_version_request *version_req;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
@@ -2155,10 +2153,10 @@ static int hv_pci_protocol_negotiation(struct hv_de=
vice *hdev,
 		}
=20
 		if (comp_pkt.completion_status >=3D 0) {
-			pci_protocol_version =3D version[i];
+			hbus->protocol_version =3D version[i];
 			dev_info(&hdev->device,
 				"PCI VMBus probing: Using version %#x\n",
-				pci_protocol_version);
+				hbus->protocol_version);
 			goto exit;
 		}
=20
@@ -2442,7 +2440,7 @@ static int hv_send_resources_allocated(struct hv_devi=
ce *hdev)
 	u32 wslot;
 	int ret;
=20
-	size_res =3D (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2)
+	size_res =3D (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2)
 			? sizeof(*res_assigned) : sizeof(*res_assigned2);
=20
 	pkt =3D kmalloc(sizeof(*pkt) + size_res, GFP_KERNEL);
@@ -2461,7 +2459,7 @@ static int hv_send_resources_allocated(struct hv_devi=
ce *hdev)
 		pkt->completion_func =3D hv_pci_generic_compl;
 		pkt->compl_ctxt =3D &comp_pkt;
=20
-		if (pci_protocol_version < PCI_PROTOCOL_VERSION_1_2) {
+		if (hbus->protocol_version < PCI_PROTOCOL_VERSION_1_2) {
 			res_assigned =3D
 				(struct pci_resources_assigned *)&pkt->message;
 			res_assigned->message_type.type =3D
@@ -2812,7 +2810,7 @@ static int hv_pci_resume(struct hv_device *hdev)
 		return ret;
=20
 	/* Only use the version that was in use before hibernation. */
-	version[0] =3D pci_protocol_version;
+	version[0] =3D hbus->protocol_version;
 	ret =3D hv_pci_protocol_negotiation(hdev, version, 1);
 	if (ret)
 		goto out;
--=20
1.8.3.1

