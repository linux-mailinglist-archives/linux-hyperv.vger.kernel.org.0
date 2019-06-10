Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C09B3BDC3
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jun 2019 22:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfFJUtD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jun 2019 16:49:03 -0400
Received: from mail-eopbgr800137.outbound.protection.outlook.com ([40.107.80.137]:56544
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbfFJUtD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jun 2019 16:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Pt+ys4dZ90RPw8wZ/JkD0YceRc9UpNZaqJqYRorVKJ9+XSrIm27IigzoGQu45h6QLv5/tAkNu3aHU4/ilzaoMOZQBS83FJcPCB9VHDVftS0X0vxKMA0yLr4evhNOR/CQjoKNxzQBUq67Ygt/0StUgb7w8QUVnyXcfyN9A6IAxwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeL0vvoCA7S5fA05kZ2XiOJ/w+mfnMktNYiM8ehy95U=;
 b=jvIMYDFnMvd62QodzATHTzw+nCxYvb55/zNdvsx950D7uO58pedIyOerEX44HNO16l1UlApfVKg2cx36pxqwMxRuViLZ+9EyC8uV2ZmDrkh2/kfdOBLT0SJaHZekGtRCCZH/8cxUjbkbr7roiGtEES5QacXQmWPirPH9xcBokSI=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeL0vvoCA7S5fA05kZ2XiOJ/w+mfnMktNYiM8ehy95U=;
 b=WNzFAASsevSrd3qvrotby09eKkKtb2N7yqmDHeNFL4whVhYnZEmHY6fK5yhMCS60+GBudl2kxCOIvaG57NL8N7YKlSSatFlM3n1y45RzIvNBYFsCThi82EU1dC6exoQoe6dOCmdJytUThyDtHUSh0SI2dwYdFqaLQ4saOlSRIBg=
Received: from DM6PR21MB1242.namprd21.prod.outlook.com (2603:10b6:5:169::22)
 by DM6PR21MB1353.namprd21.prod.outlook.com (2603:10b6:5:175::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.0; Mon, 10 Jun
 2019 20:49:00 +0000
Received: from DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::b825:2209:d3e2:8f11]) by DM6PR21MB1242.namprd21.prod.outlook.com
 ([fe80::b825:2209:d3e2:8f11%8]) with mapi id 15.20.2008.002; Mon, 10 Jun 2019
 20:49:00 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH hyperv-fixes] hv_netvsc: Set probe mode to sync
Thread-Topic: [PATCH hyperv-fixes] hv_netvsc: Set probe mode to sync
Thread-Index: AQHVH83uUShjEVupf06mW38xrZET1g==
Date:   Mon, 10 Jun 2019 20:49:00 +0000
Message-ID: <1560199685-13447-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0040.namprd14.prod.outlook.com
 (2603:10b6:300:12b::26) To DM6PR21MB1242.namprd21.prod.outlook.com
 (2603:10b6:5:169::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dd72015-aacb-45de-848a-08d6ede510b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1353;
x-ms-traffictypediagnostic: DM6PR21MB1353:
x-microsoft-antispam-prvs: <DM6PR21MB13532018064C78957BB56398AC130@DM6PR21MB1353.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(366004)(136003)(376002)(189003)(199004)(4744005)(110136005)(6436002)(54906003)(4720700003)(6486002)(3846002)(486006)(6116002)(7846003)(53936002)(10290500003)(6392003)(386003)(102836004)(36756003)(99286004)(71190400001)(6506007)(52396003)(71200400001)(52116002)(6512007)(2616005)(476003)(66476007)(26005)(186003)(66446008)(478600001)(5660300002)(64756008)(66556008)(25786009)(14454004)(14444005)(66066001)(81166006)(107886003)(66946007)(68736007)(256004)(73956011)(50226002)(7736002)(2906002)(4326008)(81156014)(8936002)(8676002)(305945005)(10090500001)(2501003)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1353;H:DM6PR21MB1242.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zW8dFNSFUjawzF8eFf9Tc7ihA/69v6+CxOGgT0TKvEGqc8FeZSk2zOcMuyEo5+nzZcptO3w/eaIEEU7Wkk/ruKuf1aJ0Tk8ea3djyrZYFmlhgx87rbeMTnjhmPX2v1/T5lvZVP/9AZlwSvNRBL71bf6EIyMNVmFUMxqPbwMMvDZWLYDLT5PEEI8LadcVK9SY1Yf5IAU+6upJ7j8JmYo0TJap9a9B5BsZd8RgS+UG9uakdUoMTaTTMbx30lOsiJ9KCd/APudJUl/bvZulHZTImy6nMSWCOlJ/n7phm0kdOQ0X2QleJcx5BlAVtbRFdhrDto3348Ue2NHCLQS654/Tv+ACnstCWtGEDSCCkl3/mAPooCXLeSRsLBwxXyTjGCj2uk6A2Yqr34CPw31bmjIs51/Rc6MKg5r0j+M160OV3tc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd72015-aacb-45de-848a-08d6ede510b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 20:49:00.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmlhyz@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1353
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Rm9yIGJldHRlciBjb25zaXN0ZW5jeSBvZiBzeW50aGV0aWMgTklDIG5hbWVzLCB3ZSBzZXQgdGhl
IHByb2JlIG1vZGUgdG8NClBST0JFX0ZPUkNFX1NZTkNIUk9OT1VTLiBTbyB0aGUgbmFtZXMgY2Fu
IGJlIGFsaWduZWQgd2l0aCB0aGUgdm1idXMNCmNoYW5uZWwgb2ZmZXIgc2VxdWVuY2UuDQoNClNp
Z25lZC1vZmYtYnk6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQotLS0N
CiBkcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjX2Rydi5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvaHlwZXJ2L25ldHZzY19kcnYuYyBiL2RyaXZlcnMvbmV0L2h5cGVydi9uZXR2c2NfZHJ2LmMN
CmluZGV4IDAzZWE1YTcuLmFmZGNjNTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9oeXBlcnYv
bmV0dnNjX2Rydi5jDQorKysgYi9kcml2ZXJzL25ldC9oeXBlcnYvbmV0dnNjX2Rydi5jDQpAQCAt
MjQwNyw3ICsyNDA3LDcgQEAgc3RhdGljIGludCBuZXR2c2NfcmVtb3ZlKHN0cnVjdCBodl9kZXZp
Y2UgKmRldikNCiAJLnByb2JlID0gbmV0dnNjX3Byb2JlLA0KIAkucmVtb3ZlID0gbmV0dnNjX3Jl
bW92ZSwNCiAJLmRyaXZlciA9IHsNCi0JCS5wcm9iZV90eXBlID0gUFJPQkVfUFJFRkVSX0FTWU5D
SFJPTk9VUywNCisJCS5wcm9iZV90eXBlID0gUFJPQkVfRk9SQ0VfU1lOQ0hST05PVVMsDQogCX0s
DQogfTsNCiANCi0tIA0KMS44LjMuMQ0KDQo=
