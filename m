Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225498C52C
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 02:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfHNAji (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 20:39:38 -0400
Received: from mail-eopbgr780101.outbound.protection.outlook.com ([40.107.78.101]:60864
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfHNAji (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 20:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz00UJyUylrWyXs7D9aIVzdmKGASZnpc44MWZm5iEougLVbcrW9GEr6lRKku77yxqPbXX4xczhOT069LmQ3MnAQL8DLG+MEXsG3g9z2eyUD6F3Q269dPcL3BKEDbA57fX+oRhvAK7kNEt/Deh58r5Xnrbx9q3cy8zd2wC1XCGK4sv5ChViDAiFj6tlRHoYvc8LI7iyj1uPNTn6DFOLz5Hg6b5u1GRfYGqhyBKhDo3ZIdWk50FOpEN8OTf8vAbhizCB8TddI2qAXWitrp18xEj4ot9ZBBhdKLaA5D7TtDtiI+N2ECYZ9k3dt++4+DGe5XJ7q1pS1rw9ylmHF8UOtuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgcDpRUMjuJAWhzK2bog4nWoAxxCJh2WjK3u6Upsg9s=;
 b=iZH32LebEKOcXb0Irvhl2PhdPBk3mPWG1k+dGcMZG3RVM0QRNZPlpKnVy67tKOzEYumQWjeJSJ+z2DlKhD22hzbSDI3muctTuGbcx3hlE653nn8JTcoQCgmdfH3F6ch/MRMMquCGPokzXd1TuNAvR8kki3nN68mB2PLDKH3oGHR2SxvDxEI0Jn9o2cmogss6E1JrIJGhWsP4DlUhxYObeCrHTAbPIyqAmG02dwW2SKWql2Rfa3zVtsCytQWDwAqfQ50w01+Si7v2Wm/BRDiaiE/tSNKpGD8He5jihIa4WC72HbSP8x82Z/fjSQVW8s1x479MH/lG5xf+uuS0hR+qVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgcDpRUMjuJAWhzK2bog4nWoAxxCJh2WjK3u6Upsg9s=;
 b=k13l2VgoelDvCvlgOZ0J7ytpXj1gugHt1iS2qak0cg07VPXeV2aDJMAXk6HMPqLwFA0++PC0BLFt6zaiNme3wO8eIqDACroBha/VhpBj6KAHPgHlVOl1R1V0EpjLVZX5foM0GgebVZanH/SIGfsj0m1key2wMXS4srUnMeIDV6U=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (20.179.50.86) by
 DM6PR21MB1514.namprd21.prod.outlook.com (10.255.109.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.6; Wed, 14 Aug 2019 00:39:35 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::ddd:8e5b:2930:6726%9]) with mapi id 15.20.2178.006; Wed, 14 Aug 2019
 00:39:35 +0000
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
Subject: [PATCH v4,2/2] PCI: hv: Use bytes 4 and 5 from instance ID as the PCI
 domain numbers
Thread-Topic: [PATCH v4,2/2] PCI: hv: Use bytes 4 and 5 from instance ID as
 the PCI domain numbers
Thread-Index: AQHVUji/yqFsDJoFh0+QlpM5gVx5RQ==
Date:   Wed, 14 Aug 2019 00:39:35 +0000
Message-ID: <1565743084-2069-2-git-send-email-haiyangz@microsoft.com>
References: <1565743084-2069-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1565743084-2069-1-git-send-email-haiyangz@microsoft.com>
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
x-ms-office365-filtering-correlation-id: a52eee8f-0d18-41ff-5183-08d7204fe151
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1514;
x-ms-traffictypediagnostic: DM6PR21MB1514:|DM6PR21MB1514:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1514745CADCA94BE937951FDACAD0@DM6PR21MB1514.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(189003)(199004)(2201001)(5660300002)(4720700003)(11346002)(66946007)(2906002)(66066001)(66476007)(66556008)(64756008)(66446008)(25786009)(2501003)(53936002)(4326008)(99286004)(54906003)(110136005)(14444005)(22452003)(256004)(316002)(486006)(36756003)(476003)(2616005)(7846003)(71200400001)(71190400001)(6486002)(6436002)(446003)(10290500003)(10090500001)(52116002)(81156014)(8936002)(76176011)(81166006)(8676002)(6392003)(478600001)(6116002)(3846002)(14454004)(186003)(102836004)(6506007)(305945005)(386003)(7736002)(50226002)(6512007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1514;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rOMuuDZ9Ftt7yfXrinWvFcZPvdpLY1ctnmZKydvVO0/yRD0qxbrM3TSkJYkA96MiSWfxF2ZvWEEf8skDNeuCk+c3UFEpiY1NFlDX/K4MA2V51uJs0FJi1fv/xohUqAVthd3T8UnClf4hjGY31ZVC1tEw5QQ7Ny+1HG/nhtlynVvEDJ+rkXEnvF0ay2LmSnlYQo3Q2k8R8F9iZ/GWqLynH+nvYWbkJXOXdtFSaFXua5fQmcF2tASHWEOgdFgPbd63s2BqIu64ezYNRVBLGR+puOyD5jBHjzFi9d+rAj0qOAb/BYZ42SHji+cl6v3Us2ap2B7Ojvx0mBFuxGcHYPQ2gnjvPbOVRRe0UOz4dPM8cxuVRFx+Ad05U+X25DP/pRrLK3OsWjBcdfklOHxot94jqLXUsVJujDIQfe+AW7KUMI4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52eee8f-0d18-41ff-5183-08d7204fe151
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 00:39:35.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgUnUeThPuhifhE4pBH7MCT3GyvySKkRfUL2HQ/q80FVk1PJMB0/7di6L8oZ5ENTjGZ8kJp/7zIq6jXHCWRyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1514
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

