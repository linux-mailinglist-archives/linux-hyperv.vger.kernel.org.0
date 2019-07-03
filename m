Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF95DD79
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2019 06:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfGCEdo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jul 2019 00:33:44 -0400
Received: from mail-eopbgr1320090.outbound.protection.outlook.com ([40.107.132.90]:23729
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfGCEdo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jul 2019 00:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CokxuYIp9e0PDfG3p6VgtgjEMrQlDZy7ai/9gnJbJXZW90gM5OfTw+gdhvh6nfAu2oCSPsQsvp4QihC9UI0IVjNqp5GPiwuItmtczHjHJ2ItbmyBaL71LnGqkvuLGb2n14D4dubEkC4QluLD51w/vjEVptdPP1C5Omm5jdJ9Dg9/lgGybQnXrPUJdebBtI5HOxr6CXKRv/0rfljuuN9ewtvcnT5oWZWogmzhhBNCq3acFcV0RfG6jCldI+to9FyDMfkoyATDa5YAKRO3Q+0WkEXTae2DvDuaZ2lTQ9TG3odl65Pnh39KQznKrGj7EPcxka7oMHrqZxxPvQil0LNU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzzjFg1Hpow6AfdxC+hgrwzsVDK+0OEGJLmHoRu8I8Q=;
 b=IzBupTxkUQW2IAQN4YF2XExu8gdJjKGdbS0DOmatqvCoA4atQDSo1yIGGlYWwENLmbysiuGLkEm1T5ENY2ffHwJo4pZkdq9mvoTjdwzhlfSkPp6xYsSHpRbWsU/LflGk8wITqi1bNrd64LfzVtJS25m5supJVL61E2+mrU+xizK2H3arB3xvIICTYM+cILNEhozjapdrusy3tDZLUccLJEzWKTAynLjL6KFpS1W7+SRNjnifgsqy0f0ND/f4nj1RXMO19ywVNvBfxxcOWb5HkeD48vqLF2FVWC1kRCE1BMx8zFEcVl/r/OsDSRCgAB42NnF/ndGL12mhg+RY8TlAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzzjFg1Hpow6AfdxC+hgrwzsVDK+0OEGJLmHoRu8I8Q=;
 b=TRBBCFo30tuN9K5iI5soUw279M3yhUN6JEatvl2zpayh6nV7MwsEr43Z+xoSdXgDnKl2Y0Bw11vwXMSauEQegnxiGkmu1kYAc3lErx9dw5C1zN3QIZYrMbVy5x+2NE52WDdB4X2bOK8IZpyXWW24MMVwGnq3PeyfjChGFC1tbrY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Wed, 3 Jul 2019 04:33:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b%9]) with mapi id 15.20.2073.001; Wed, 3 Jul 2019
 04:33:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
Thread-Topic: [PATCH] PCI: hv: fix pci-hyperv build, depends on SYSFS
Thread-Index: AQHVMT9Pxn4hFFa0E0C7KQrPGKhKRaa4TZog
Date:   Wed, 3 Jul 2019 04:33:35 +0000
Message-ID: <PU1P153MB016931FDE7BF095FB85783EEBFFB0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
In-Reply-To: <69c25bc3-da00-2758-92ee-13c82b51fc45@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-03T04:33:33.7810112Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6cd3a633-0885-4f0a-8027-204a6539ea71;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:78d7:890f:ef80:9f4a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12f34d20-1409-4238-8ad7-08d6ff6f9d35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0201;
x-ms-traffictypediagnostic: PU1P153MB0201:|PU1P153MB0201:
x-microsoft-antispam-prvs: <PU1P153MB02010F1FA998D090EBAEB112BFFB0@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(40224003)(25786009)(446003)(256004)(52536014)(8990500004)(2501003)(54906003)(6246003)(316002)(22452003)(10090500001)(305945005)(6436002)(46003)(486006)(55016002)(186003)(229853002)(7696005)(76176011)(6506007)(4326008)(476003)(11346002)(102836004)(2906002)(10290500003)(74316002)(9686003)(8676002)(81166006)(81156014)(64756008)(99286004)(33656002)(53936002)(8936002)(6116002)(86362001)(478600001)(14454004)(5660300002)(4744005)(71190400001)(71200400001)(76116006)(73956011)(66446008)(66556008)(66476007)(7736002)(66946007)(110136005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Cr9EWuDTANvyOwqKFAYMHarxzDAa9pr7+JmRZfcosxkgaqs+Lerv9gezRNVEiggEk0IYEqD/W/6phygZDVkt1b7yDJAFJJ4s6YtGLjj5Gam8aUcPTeyDJpF369rGFlqfOIYvM2GtWHKdlimmQxWiTIAJfSEYHDPuw1aIfDJb/6JTIFJjnMMRbjXhyRMtt6katPXnUp9s0kCGMkWX8vVm5X6oVeABqDG9R852HrZMvDLhUnKroifQEzZ/9Kw+dPgsRQaP22Fu+BxGELpx0KPvqH7KA7dUeZzBcYZ9GoxyUvPri27Yii7IYK9/6KSHobSXyrZiHfbT/MTLAdHOp7T2gSXfRWrfmnvkKTzZjYmFiC4HBOjNAS9ad8Tg5z0ESKusIp+TlaB2lXYDFqiffSatS88XpMCIC0YgoM2+3BQocs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f34d20-1409-4238-8ad7-08d6ff6f9d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 04:33:35.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBsaW51eC1oeXBlcnYtb3duZXJAdmdlci5rZXJuZWwub3JnDQo+IDxsaW51eC1oeXBl
cnYtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgUmFuZHkgRHVubGFwDQo+IFNl
bnQ6IFR1ZXNkYXksIEp1bHkgMiwgMjAxOSA0OjI1IFBNDQo+IEVSUk9SOiAicGNpX2Rlc3Ryb3lf
c2xvdCIgW2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5rb10gdW5kZWZpbmVkIQ0K
PiBFUlJPUjogInBjaV9jcmVhdGVfc2xvdCIgW2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5
cGVydi5rb10gdW5kZWZpbmVkIQ0KPiANCj4gZHJpdmVycy9wY2kvc2xvdC5vIGlzIG9ubHkgYnVp
bHQgd2hlbiBTWVNGUyBpcyBlbmFibGVkLCBzbw0KPiBwY2ktaHlwZXJ2Lm8gaGFzIGFuIGltcGxp
Y2l0IGRlcGVuZGVuY3kgb24gU1lTRlMuDQo+IE1ha2UgdGhhdCBleHBsaWNpdC4NCj4gDQo+IEFs
c28sIGRlcGVuZGluZyBvbiBYODYgJiYgWDg2XzY0IGlzIG5vdCBuZWVkZWQsIHNvIGp1c3QgY2hh
bmdlIHRoYXQNCj4gdG8gZGVwZW5kIG9uIFg4Nl82NC4NCj4gDQo+IEZpeGVzOiA0ZGFhY2UwZDhj
ZTggKCJQQ0k6IGh2OiBBZGQgcGFyYXZpcnR1YWwgUENJIGZyb250LWVuZCBmb3IgTWljcm9zb2Z0
DQo+IEh5cGVyLVYgVk1zIikNCg0KSSB0aGluayB0aGUgRml4ZXMgdGFnIHNob3VsZCBiZToNCkZp
eGVzOiBhMTVmMmMwOGM3MDggKCJQQ0k6IGh2OiBzdXBwb3J0IHJlcG9ydGluZyBzZXJpYWwgbnVt
YmVyIGFzIHNsb3QgaW5mb3JtYXRpb24iKQ0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg==
