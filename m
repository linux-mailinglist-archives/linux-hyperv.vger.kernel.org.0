Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2A1802F7
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Aug 2019 00:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfHBWu2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 18:50:28 -0400
Received: from mail-eopbgr1310111.outbound.protection.outlook.com ([40.107.131.111]:24992
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728242AbfHBWu2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 18:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZpj3xiYWqAXJYkfFSg66zoQp+TP3xNGNWX02d7JhW2WO9MPJcH/btcq3u7fm9sO+gBzj51aQx6E50lSKxvOqXCi1rCE33VjDTKKV8nv+Vsd5IGnbJObVTcKtgMPv/L/3RMBqWUN3zHRKwfVOVD+eHB/GxzqqzMMYnid8wlaZBSUGqlwM1/RP5hXPy4c2911eNVmaeB4G81m9ugh73BdEQxCQW/fDpZsNj8AIMmv12bz4VygwC+sqMBpWmnibS3srcQbPaEOKuzBQ+dPRN7Olz0MzS2wU5XJUX5YE0eYT2/fxa3cQThDkmabhgmnNzjRAFaxzZWKmfCRhB2iOED29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEoVPnmO3JxhE0nF6jREGy77cqKv65QzLFWHO2SQY74=;
 b=aJYCXeIzqWQxQU4kpzL29Zu1Qa2u6Pe2MUHAj6Ahgy8VxcY71y0PeDWzahFosA77EueQhBN8R8EMVya+xpBagxYAPeO955QLoChnxv3jOUAuO57Znlpv77T/HBjSngogGdXbWTDlMogU4Rylx9/dRQD8f86MBMCD+Jjn9AVVD6wlF8NSdKaOrF0bMWoPQITckbwRuU4zmm7AQJCIdiqrtWx0Lh8ib6RhRSXYQUuFfgpnuJyFglmhh2HGrrOgl8czblMMA8MnnGCCfEoOZJdr3WEOd2YXUzfGebXHKkftyJjBMb+Lta0VMvWxbdroHgPBbjoL665agdd+OaToo3ZhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEoVPnmO3JxhE0nF6jREGy77cqKv65QzLFWHO2SQY74=;
 b=K7UQc5TLGPg5Dvcd8DjQO9siXzY8WuTn67VKEV1AieoFQIfn0Chj78swZDfBg7yXN2+xfHJxs8cRSoeobpA1ZDbID85Hm3tisyFCAWiU5eeSYmXxXfF9GSXV4d+iato/aKn6S17c7Q9vBDW9NeYa0olBbZ52fijP9avBZTF36Vk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0105.APCP153.PROD.OUTLOOK.COM (10.170.188.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Fri, 2 Aug 2019 22:50:21 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%7]) with mapi id 15.20.2157.001; Fri, 2 Aug 2019
 22:50:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Thread-Topic: [PATCH v2] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Thread-Index: AdVJg/VErstT3ocmRgK9bYa/R2iIzA==
Date:   Fri, 2 Aug 2019 22:50:20 +0000
Message-ID: <PU1P153MB01693F32F6BB02F9655CC84EBFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-02T22:50:18.0174061Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=72f415c9-f574-414f-b43f-00fa1f90d651;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:71c8:ee0a:27d:d7aa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a14aa9b9-639c-43f7-597e-08d7179bcc68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0105;
x-ms-traffictypediagnostic: PU1P153MB0105:|PU1P153MB0105:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0105CC9A7F7A1EAF38AD6E16BFD90@PU1P153MB0105.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(54534003)(14454004)(486006)(5660300002)(52536014)(8676002)(966005)(478600001)(10090500001)(8936002)(4326008)(2201001)(10290500003)(71200400001)(74316002)(64756008)(33656002)(7696005)(53936002)(102836004)(66446008)(2501003)(99286004)(66556008)(186003)(66946007)(6636002)(6506007)(81156014)(81166006)(7736002)(55016002)(1511001)(68736007)(256004)(14444005)(107886003)(2906002)(66476007)(76116006)(6306002)(9686003)(7416002)(110136005)(8990500004)(6436002)(305945005)(25786009)(476003)(54906003)(316002)(6116002)(46003)(86362001)(22452003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0105;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cmjGBKpE/l+VDInHfIMOQDyOdGLFpnPNg8G9nQo2S0f55/fdd9hugEVGAPeV8LUM26hAsZkt0+KoAr+nr9EyjlL2uepR/pkrP8LzHrHpQTreDeaXJ+w3p3tGw3APbQL4eYHHqx+2IGJhcXrBY8T2sXU7Dn0KLSliviKjNuB6z0ER61Bgh+MgER64te8BDsAXmIi1Ab1/8uCQswqRAUBlAGm9zL/rZ07244MUCx5/+wbcJCUtMqKFcD0uRVLVCtdYpwtynQl7t46N21gZv34oW9GtHQNY5SpCf52Yaugpma+RFB4OPqwH12QzxDBhQRA0cb/Non8F87uyDNH5ZWYXg89VlOlrRsY1dQvC653WrmIAQgMEDgyc/AJpU65It4NpTPrFDtcOi1FFxguBrW3cT7URDpVVlBDL9rxGPYGKOmc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14aa9b9-639c-43f7-597e-08d7179bcc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 22:50:20.8477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjAFy6/HYkz/NnbomXVaBxtYA46fm8x6UfEx5VvkuJHaj5unJPtrdAQORuUHvMJ53UgQY2L3lH8ITZ4RTDL9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0105
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


The slot must be removed before the pci_dev is removed, otherwise a panic
can happen due to use-after-free.

Fixes: 15becc2b56c6 ("PCI: hv: Add hv_pci_remove_slots() when we unload the=
 driver")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
---

Changes in v2:
  Improved the changelog accordign to the discussion with Bjorn Helgaas:
	  https://lkml.org/lkml/2019/8/1/1173
	  https://lkml.org/lkml/2019/8/2/1559

 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 6b9cc6e60a..68c611d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2757,8 +2757,8 @@ static int hv_pci_remove(struct hv_device *hdev)
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
 		pci_stop_root_bus(hbus->pci_bus);
-		pci_remove_root_bus(hbus->pci_bus);
 		hv_pci_remove_slots(hbus);
+		pci_remove_root_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
 		hbus->state =3D hv_pcibus_removed;
 	}
--=20
1.8.3.1

