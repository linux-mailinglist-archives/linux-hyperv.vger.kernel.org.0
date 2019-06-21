Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1C4EF2B
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2019 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUTCe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jun 2019 15:02:34 -0400
Received: from mail-eopbgr1320133.outbound.protection.outlook.com ([40.107.132.133]:60144
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfFUTCe (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jun 2019 15:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDaMtZi/QwUXoC+M1UYtbzTmm7qrCIDkyB37qG+E7Bfx0L8//QX5s3PIJSMU16o4oS46IREBNZSdxKEZCBJLl84apq8K2YZNE3r2MDO4AfR9zdBiKbwTST7nVpzFiW4LADK8ybHVYTNgZfMBjdEZraE3yBDNU/9d2To2ks6PcLrtTW9yRhzhX3X8AYmUizi/jIzUVf9DSFl9YPCXiQ2ll6QCA0O530kznjKbWxoo1Yyda61nisvhHKrWn4zA/Z2VmPj59kv0utvX5CI0H/0fUpocucnJy/um7iR6Y2+hM4s/q5Pl2gIEeoVlgBjIibJHdxv80Pxw/3GVas31OJQ7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Se5EY7Y81SLhNmiQoAQNry2oIQW0BuLMxLF7yrKO4=;
 b=EV0Unj5HH27SAHVXXI249B3MQrsjiBJI0r86ndZfDC6ujUWkU1G6E+NJS1+nmm45caIe8gX/4g01dxYZ4vbDY8RWF9yASxdXtEh7qM+QhtE8+HpSJYnW2sBL4rE1oxMmC8DLQAZ1ahL4Y7GloX6+jUl6FrpzwuCrWellpKW4id8pKOZxPqPREpvrmu9e1P42efguSFtOYCQIvetH8jhG/rfE6Gxa/I5cVh4PBLzqdcInjcj70JEKHOmjmT8AW/21WOMrnf8v0QnIkVQny8qIRa2geL9A/WYfHrMi0k3e8zMq/CwnCzFapQ4ZtqwPi+WL37gmzltJPjrDI0A1jHL8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Se5EY7Y81SLhNmiQoAQNry2oIQW0BuLMxLF7yrKO4=;
 b=erbjy02+hvg3qi4l59YaitjMZUDIKZj2V6lV1f8hbhaXOVr0P7hmAsCLMjqvPPh3+Ubb1SbrMRPH/COeRs0TOhg2knD9oToVqGAYube+NNejzdQzCX8LP8O7W1uZlMMRJnnEtBYlELbsqUNAS9qZdlJ9+uVZfOyD5VgVg5OYQz0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0170.APCP153.PROD.OUTLOOK.COM (10.170.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.7; Fri, 21 Jun 2019 19:02:26 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b%5]) with mapi id 15.20.2032.008; Fri, 21 Jun 2019
 19:02:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: [PATCH] PCI: hv: Fix a use-after-free bug in hv_eject_device_work()
Thread-Topic: [PATCH] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Index: AdUoYqahDsLeDiTlTqKiO6h8RAkcdg==
Date:   Fri, 21 Jun 2019 19:02:26 +0000
Message-ID: <PU1P153MB01691036654142C7972F3ACDBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-21T19:02:22.0981116Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f5ac9eff-e920-4812-8c36-4a93f3cf745c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:3a2e:2bcf:5c00:8eef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c95d47dd-709c-4d00-8692-08d6f67b005c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0170;
x-ms-traffictypediagnostic: PU1P153MB0170:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01706EC4FACF0639DF52A278BFE70@PU1P153MB0170.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(5660300002)(2201001)(2906002)(86362001)(73956011)(64756008)(66446008)(66946007)(66556008)(66476007)(10290500003)(55016002)(76116006)(478600001)(6506007)(7416002)(8990500004)(33656002)(102836004)(7696005)(14454004)(2501003)(6116002)(6636002)(6436002)(99286004)(52536014)(186003)(71190400001)(8936002)(316002)(22452003)(110136005)(71200400001)(53936002)(486006)(476003)(8676002)(256004)(14444005)(54906003)(10090500001)(46003)(81156014)(81166006)(68736007)(1511001)(25786009)(9686003)(74316002)(4326008)(305945005)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0170;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eYT/ENOz9MMirqvWun6JqJM3dl31B/JhFsOuXwXycHb0nUMPa2C6K9YzaCakXz9pHU9c/oIUpFayiqn1KTWM4LpG99Rngeu3bid3VJdbGyPCoD3nnZKpBO+8YhoN4PCFkhICs/24QTNAFp4caomKCewPOvqb/79Chqj7IbxkzMMiIrRsGndM6U9EU1CNKRbQuDEBj3tSmCZu1ESH8BTNqUH1r/AK8VZuUGCjoAvbNKtI2jDwlb0vyr9i76QmizQNZxt6EDWQYSWFYtgYQunzu8K1bnNg1Ut/z6tlcOG4xBczKSyXk/uW5FIkmntNNXJpgqYSbBeI9EHR7ROP7/cKk5PuuQi+vvfT8KgBcLGkqEactK06RrIFYN4W7JX0T5/UfPWsIfRaQqPq+56fB8fpiczfCHMgO3WOf27oamghABc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95d47dd-709c-4d00-8692-08d6f67b005c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 19:02:26.2150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0170
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


The commit 05f151a73ec2 itself is correct, but it exposes this
use-after-free bug, which is caught by some memory debug options.

Add the Fixes tag to indicate the dependency.

Fixes: 05f151a73ec2 ("PCI: hv: Fix a memory leak in hv_eject_device_work()"=
)
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
---
Sorry for not spotting the bug when sending 05f151a73ec2.=20

Now I have enabled the mm debug options to help catch such mistakes in futu=
re.

 drivers/pci/controller/pci-hyperv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 808a182830e5..42ace1a690f9 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1880,6 +1880,7 @@ static void hv_pci_devices_present(struct hv_pcibus_d=
evice *hbus,
 static void hv_eject_device_work(struct work_struct *work)
 {
 	struct pci_eject_response *ejct_pkt;
+	struct hv_pcibus_device *hbus;
 	struct hv_pci_dev *hpdev;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1890,6 +1891,7 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	} ctxt;
=20
 	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
+	hbus =3D hpdev->hbus;
=20
 	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
=20
@@ -1929,7 +1931,9 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	/* For the two refs got in new_pcichild_device() */
 	put_pcichild(hpdev);
 	put_pcichild(hpdev);
-	put_hvpcibus(hpdev->hbus);
+	/* hpdev has been freed. Do not use it any more. */
+
+	put_hvpcibus(hbus);
 }
=20
 /**
--=20
2.17.1

