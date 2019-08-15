Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE18F17D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2019 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfHORBs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Aug 2019 13:01:48 -0400
Received: from mail-eopbgr750131.outbound.protection.outlook.com ([40.107.75.131]:28414
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729157AbfHORBr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Aug 2019 13:01:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/Ypsij+LaKYHWY4ZL5QMpruMJoBKRy4DuuWwoPy3W6ybxBb+pKFBBLexkrYD4usEQE7y5ivxdtqraK+BtIzMLvp5g2vusFByEeq0lIdKZp/rvUfOxciMWQIoK1lLZI3RAG2TqF6KbglkB+FrLFqnl43wye27T1jU4Hqd3YgEtR+vlJgIhKZsw2tPRC49OQ9hgIhojISe0O3r5xV2MtCIo/1enqbNTDRTDBDspQX5JPh1TaiEMkxRajdVFF2WlgrvCbpw9QSRLmUR0ZNU9Pn/B3bI0l9nAT3/hQplPNXRRMISPN8GB3gzj40xMmEKPtPMP6idMcgrWDe9+mVw7Sacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgcDpRUMjuJAWhzK2bog4nWoAxxCJh2WjK3u6Upsg9s=;
 b=PBA/3RjIXWpQ+vxQnCY6RTyOd5J5FQRWA6mUQteJTGceeat+CKzVfuSj9zqMHdPcbN9rGT4eJctU2PWALMEM/QWUaL8/lETie7v1KfbzLKwchSS405UDheftXcVbLBQ23UiV+OOyUukCq7MrWgaCPUkvOnF2ulngkqa1qSExJQo1dO3DvQq0SVYmaOH3PjXIdTz94etxVobunhyjW+M8Z3e6KhZUQi6GcGeKx/BjLjtx5yGa0dmWCD9eh3iigfXsIzHRbPkUV1o/ZuR5J7Bk/QB9AyEVZhugIZ6IFP2Wi1weDrIJTWeCS8jaW1lRRInOwDo6mWRTEAi8DrbaDSi/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgcDpRUMjuJAWhzK2bog4nWoAxxCJh2WjK3u6Upsg9s=;
 b=UH1q53gXOETtBLTOUZUlUmj/CT8fhtVTmonnuANCw6npAfPmGROKoc6F8YfVxTL9rPNiUARQuctvau7sD46ZRa+ORyz2E7CHog+Mbir12MU+tUWcfY879V0OU+4WtzhRUPPp31unmny4/pOOMwMuX0tdVdpVxzYyvcf9v3+M1/E=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1306.namprd21.prod.outlook.com (20.179.52.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.11; Thu, 15 Aug 2019 17:01:45 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726%9]) with mapi id 15.20.2178.006; Thu, 15 Aug 2019
 17:01:45 +0000
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
Subject: [PATCH v6,2/2] PCI: hv: Use bytes 4 and 5 from instance ID as the PCI
 domain numbers
Thread-Topic: [PATCH v6,2/2] PCI: hv: Use bytes 4 and 5 from instance ID as
 the PCI domain numbers
Thread-Index: AQHVU4seoLCJ4XnpvECmtlYiCdCsfg==
Date:   Thu, 15 Aug 2019 17:01:45 +0000
Message-ID: <1565888460-38694-2-git-send-email-haiyangz@microsoft.com>
References: <1565888460-38694-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1565888460-38694-1-git-send-email-haiyangz@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 10df0480-5fc3-44e9-9e5a-08d721a23fd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1306;
x-ms-traffictypediagnostic: DM6PR21MB1306:|DM6PR21MB1306:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB13061F2327E38A65553A4FB5ACAC0@DM6PR21MB1306.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(52116002)(6506007)(26005)(2501003)(76176011)(6512007)(110136005)(316002)(66946007)(54906003)(7736002)(305945005)(22452003)(66556008)(4720700003)(6486002)(64756008)(8676002)(102836004)(3846002)(66446008)(99286004)(66476007)(6392003)(7846003)(6436002)(14454004)(6116002)(386003)(2906002)(476003)(2616005)(486006)(446003)(11346002)(36756003)(25786009)(10290500003)(81166006)(478600001)(81156014)(66066001)(256004)(14444005)(50226002)(2201001)(5660300002)(186003)(8936002)(10090500001)(53936002)(71200400001)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1306;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WPhcGPc8764MwueafTvc+/BPlDOJUjWHWnH/tgcWykB+f+rKpis8CB6U7HeLGZpOgDc6QepQ9UiDtTFNeIrurzDds2QyGaucpw7ZT7/biVAfDreBcKTwhNYyCCwSWzyDjabWfnBEtTBhTYy0Uzmqjsndq6+m2tKuPkiTy98SE07BBqn0OrraFFspiH+5OScuNvoa7OGoJUQQ00pirBm8zP5wPj/uufjMEIz8ea8LbFiqIjLn3joC2MWsLGgRvZ6ak3ZyGp0F5d1RlY26lz2oluCglnYwmjWNxICUjVKhe03ojiPnjJHqmD9HHHuQKSHJA4qxRHDVe39KMJv5LDDlvVIs5/z7oSrLRwsE85i3vs8l6Vau1lC/7vWLg9J//iuQUP88MHBgTK9vxuWhtT0ligfv/uUvPs0xWeXVv3zA7Cw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10df0480-5fc3-44e9-9e5a-08d721a23fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 17:01:45.0698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySmzuOeHv4FtjLGB/2aSg35cBH/nDIt8auJT7DSIGlD8f0tQbibwWCeDdZYeWBe1qbDzvG8Dua4TJmSCmSuhXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1306
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

