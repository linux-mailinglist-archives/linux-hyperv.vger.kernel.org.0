Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD348D77C
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfHNPwX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Aug 2019 11:52:23 -0400
Received: from mail-eopbgr750114.outbound.protection.outlook.com ([40.107.75.114]:7566
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbfHNPwW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Aug 2019 11:52:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAXscnedWhC2qqNtiZfeP7Ih8PJ5czMmGcb8ypO01DMR8UDoisYdNKDSkwHfWXPTW/qVHhP4MDFIeqXbgAIEFPwZu++QjTvdZANt13eMn4dqyHgZMcTy8eFNxISsu7/rZD67BwE/aQ7NvI67uFEUR3L/fivzhG8Be17TsRGnLVP1rwGoJt0EXMhAlkymWiBiejmylbFkTlWfEKEWuSm2THm4PSO3hhJWahZI12qOtL2zyaBWl8MudLros/iEnmhh4ypDBmIjwUnRnKcC39z/nTpu79zwF/Omy/+Ob9NGDXV2R/BgSUPwpWtDedC9D0lLUiILN9Mr2KBT3g4W6zIF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgcDpRUMjuJAWhzK2bog4nWoAxxCJh2WjK3u6Upsg9s=;
 b=bnCS1yWGLV4c177mVq/ihnPDzVTPi+LQAT1oEepG5HbLVkfEvi9KLd1IRrrem5cMBfmyOwCjxlSjY2rBWtzcngOnR/Y6NV0HdLWXZcI/bfIxQDbvJne3d9ptowTGKU0bribUqkQhICCnGo3nbB6pS3zgaQT6nNTPW4N9EybxqjX/5Y4NTIBCk6a/dqRkK+kZAj4+mOkQnoMyH4gjtlnL7qldLFR1SsWZ1G22n1TqjOy+MHO798KZqM5AQCMODg7Az3t8/mTpLWDxXOfBaI6FLH9DtC/wyZKG4R4G7mVOvgrwSIpJOquZBavuecNqjn4zbj5OB8EtkmOy/gAtzvUA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgcDpRUMjuJAWhzK2bog4nWoAxxCJh2WjK3u6Upsg9s=;
 b=XqpmcZ/Q9gt3AmA163eJM23SqAVpzWabYXw3UXfSShYL/dh19fxlIpdLI+7UiJtSA+6biH627rYx1lFL0e+35U1to+Ogp5phLTCzYeaG1IsoTnE3W4MNqe2NQ9Do4tA3J36hwKsEb4VXXFthRhRdKT7PrMR8mJAo6Ap2tl73yuY=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1260.namprd21.prod.outlook.com (20.179.50.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 14 Aug 2019 15:52:18 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726%9]) with mapi id 15.20.2178.006; Wed, 14 Aug 2019
 15:52:18 +0000
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
Subject: [PATCH v5,2/2] PCI: hv: Use bytes 4 and 5 from instance ID as the PCI
 domain numbers
Thread-Topic: [PATCH v5,2/2] PCI: hv: Use bytes 4 and 5 from instance ID as
 the PCI domain numbers
Thread-Index: AQHVUrhALX2IOb29DE2lLjUka1KXKQ==
Date:   Wed, 14 Aug 2019 15:52:18 +0000
Message-ID: <1565797908-5970-2-git-send-email-haiyangz@microsoft.com>
References: <1565797908-5970-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1565797908-5970-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:300:93::26) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a9bf0e9-dcb7-4766-0b44-08d720cf62bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600158)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1260;
x-ms-traffictypediagnostic: DM6PR21MB1260:|DM6PR21MB1260:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB12608693194024C5282314E6ACAD0@DM6PR21MB1260.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(6392003)(71190400001)(53936002)(305945005)(3846002)(50226002)(76176011)(186003)(5660300002)(14444005)(54906003)(22452003)(81156014)(256004)(6116002)(102836004)(386003)(26005)(7846003)(110136005)(99286004)(6436002)(71200400001)(6512007)(316002)(4720700003)(52116002)(6486002)(66446008)(478600001)(66476007)(10290500003)(10090500001)(8936002)(66556008)(64756008)(6506007)(2501003)(36756003)(25786009)(66946007)(2906002)(486006)(2616005)(476003)(81166006)(11346002)(8676002)(2201001)(7736002)(446003)(14454004)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1260;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D2lzQHkSrmFB4Umkbw6tInS47IUG+uwWG1Glg1RRI2Seecz6gF5GG3nHLBpXBgL2jDcrB1bcPocomOSnV9Se2Gw6Nid1i5Chbfi5zFEjToHtFyTzkp+tzsdNO/eBDaSmLvHxKFgNdApx8sOmZ6JSbYucpLesk8CRZ/4Id0Ot085nkS7BzpgluT+ynCfAjQ3tZA9sCBppBmGh9m8scNdfTkJmvMqUiHImhZycDKHeeCoFAI2gcg5yBARwKmeJRl59i1NuhZFgAKoEOMtUbjcO/ryRnOAgNDQErE0Z9iTk9UhH+KD1+7rA6t2Ra0SVUdugrBP9JzvKbY7K4IajWu7sjzQ1HbV5ObeJA/DnY9nrMl/3V9cVnOY55dCFu5zQq7LWmV+zixa3j5cXv59hmGqAaXOZ3JviU0A30eALhOFUgCA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9bf0e9-dcb7-4766-0b44-08d720cf62bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 15:52:18.5689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9pDMepyBNmOUCNHhJPXAcScCer4dPh5kZdS2vwh1a2I7TtLBFfYbcExQmLBVSCnF3DHZOES3MtlCpVMWKiJtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1260
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

As recommended by Azure host team, the bytes 4, 5 have more uniqueness
(info entropy) than bytes 8, 9. So now we use bytes 4, 5 as the PCI domain
numbers. On older hosts, bytes 4, 5 can also be used -- no backward
compatibility issues here. The chance of collision is greatly reduced.

In the rare cases of collision, the driver code detects and finds another
number that is not in use.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Acked-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 31b8fd5..4f3d97e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2590,7 +2590,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 * (2) There will be no overlap between domains (after fixing possible
 	 * collisions) in the same VM.
 	 */
-	dom_req =3D hdev->dev_instance.b[8] << 8 | hdev->dev_instance.b[9];
+	dom_req =3D hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
 	dom =3D hv_get_dom_num(dom_req);
=20
 	if (dom =3D=3D HVPCI_DOM_INVALID) {
--=20
1.8.3.1

