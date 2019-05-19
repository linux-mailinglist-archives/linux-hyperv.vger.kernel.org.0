Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EC122953
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2019 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfESW2m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 19 May 2019 18:28:42 -0400
Received: from mail-eopbgr760123.outbound.protection.outlook.com ([40.107.76.123]:40590
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfESW2l (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 19 May 2019 18:28:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=rEMp14igXQgK7DCdnuWvF6qPMMd6nhZjEMwxhbMYAtw+moZQ48LSGZQY7iADumeaUQQ7KPkStVJaOSLwb5obsQQOobvmj5PEVsX7Y8G6KTeXO65sqkEHjmTJkSnVfmRyt1vIc9cFJ+AUepIZdmRRnzTojKu6pj9qRmPrp++ZUO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIY2Wuf7nQ2iUXq4J0g5adPbzJJzHb7VWLYnHkwg8Lk=;
 b=XI9NI5L/eWqRsc8QzdLI/akDLSUqJImIvirK52NEvb4l7cFwlZBu/JaWpxCIfpgqc6eI7+fHuVQmETMgJU4f/b9zHhakmot18mviAzfEumQ1wBHxUAVqQruwQS+H5x/3uftw55Tr3ZbC4zlD8f4soy3vHgCJDi8ldVy1ghTS7s4=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIY2Wuf7nQ2iUXq4J0g5adPbzJJzHb7VWLYnHkwg8Lk=;
 b=CxAqMQm6KBx+WCcQRwYYcs781duXLtKp/7bNXdPAOF+t9/+TrleleLYPU9x/LeGN+i2RCM/rcUEgp7rkZ4DZH1SIo35oXrlXP5rl2MTEqzGEVikLLiRGjxaNMA4MexsKOn32rMnk4m74Wbw0gzgkCoiz4uMQ8C5IyKZIF+q9aiA=
Received: from BYAPR21MB1240.namprd21.prod.outlook.com (2603:10b6:a03:108::12)
 by BYAPR21MB1238.namprd21.prod.outlook.com (2603:10b6:a03:107::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.6; Sun, 19 May
 2019 22:28:37 +0000
Received: from BYAPR21MB1240.namprd21.prod.outlook.com
 ([fe80::4d4f:7413:1ec:d039]) by BYAPR21MB1240.namprd21.prod.outlook.com
 ([fe80::4d4f:7413:1ec:d039%8]) with mapi id 15.20.1922.013; Sun, 19 May 2019
 22:28:37 +0000
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
Thread-Index: AQHVDpIz+mZnowKmCU+oYiS1gYdC2A==
Date:   Sun, 19 May 2019 22:28:37 +0000
Message-ID: <1558304821-36038-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR18CA0046.namprd18.prod.outlook.com
 (2603:10b6:104:2::14) To BYAPR21MB1240.namprd21.prod.outlook.com
 (2603:10b6:a03:108::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lkmlhyz@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b51ce76-2bd2-4892-117e-08d6dca9558e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1238;
x-ms-traffictypediagnostic: BYAPR21MB1238:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1238C6119D946D6CD80F8FD5AC050@BYAPR21MB1238.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00429279BA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(2501003)(6116002)(186003)(3846002)(25786009)(5660300002)(10290500003)(22452003)(2201001)(71200400001)(4720700003)(8676002)(4326008)(478600001)(86612001)(52396003)(2906002)(6512007)(99286004)(486006)(71190400001)(6486002)(52116002)(316002)(110136005)(73956011)(54906003)(386003)(66476007)(68736007)(66556008)(66066001)(6506007)(50226002)(14444005)(64756008)(256004)(26005)(14454004)(66446008)(476003)(2616005)(81156014)(36756003)(102836004)(10090500001)(8936002)(305945005)(81166006)(7846003)(66946007)(6392003)(7736002)(6436002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1238;H:BYAPR21MB1240.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vmhUBJ1fF9SgD8DXxo7vjlNaDe+OKk3jh4TzA7HdK3ssK5AsOw0/qNjTqqIbCAzXWrmtJ9nWRZ/iQLWS6z4tZhUX3uj8aO85xxLALX5emwst5e3llFcJwuEG1+St/+zXqMYf/6aAcXiTaUt31qJi/thEfok2ySEtmCHbZ3Ev0qZjFAxxGzp8Zyg3ffP2gvUH8zUxNcy190sXuubIO9mLKki0wBLTpKXk3uw95sjQ0UZ3Kj1sSGCT9HmKEG3FyKsusfdap4MHxREM8eHVXKAPVXmCOs9VXY3nU6yiYsDS7KGdp1+hCMnj7cP2dsdoj168aZG9GbXHSD92o/4EqQCrkDDabQ3DlyQ5O4ziO+H/yHPrFhZJCj1yPCN2lSbyN1KCfikEFyAckUMoQTcgKAg8ESRFGx/X068xnQJ4RiB7vIA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b51ce76-2bd2-4892-117e-08d6dca9558e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2019 22:28:37.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmlhyz@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1238
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RHVlIHRvIEF6dXJlIGhvc3QgYWdlbnQgc2V0dGluZ3MsIHRoZSBkZXZpY2UgaW5zdGFuY2UgSUQn
cyBieXRlcyA4IGFuZCA5DQphcmUgbm8gbG9uZ2VyIHVuaXF1ZS4gVGhpcyBjYXVzZXMgc29tZSBv
ZiB0aGUgUENJIGRldmljZXMgbm90IHNob3dpbmcgdXANCmluIFZNcyB3aXRoIG11bHRpcGxlIHBh
c3N0aHJvdWdoIGRldmljZXMsIHN1Y2ggYXMgR1BVcy4gU28sIGFzIHJlY29tbWVuZGVkDQpieSBB
enVyZSBob3N0IHRlYW0sIHdlIG5vdyB1c2UgdGhlIGJ5dGVzIDQgYW5kIDUgd2hpY2ggdXN1YWxs
eSBwcm92aWRlDQp1bmlxdWUgbnVtYmVycy4NCg0KSW4gdGhlIHJhcmUgY2FzZXMgb2YgY29sbGlz
aW9uLCB3ZSB3aWxsIGRldGVjdCBhbmQgZmluZCBhbm90aGVyIG51bWJlcg0KdGhhdCBpcyBub3Qg
aW4gdXNlLg0KVGhhbmtzIHRvIE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29t
PiBmb3IgcHJvcG9zaW5nIHRoaXMgaWRlYS4NCg0KU2lnbmVkLW9mZi1ieTogSGFpeWFuZyBaaGFu
ZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpLWh5cGVydi5jIHwgOTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5jIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCmluZGV4IDgyYWNkNjEuLjZiOWNjNmU2MGEgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KKysrIGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCkBAIC0zNyw2ICszNyw4IEBADQogICog
dGhlIFBDSSBiYWNrLWVuZCBkcml2ZXIgaW4gSHlwZXItVi4NCiAgKi8NCiANCisjZGVmaW5lIHBy
X2ZtdChmbXQpIEtCVUlMRF9NT0ROQU1FICI6ICIgZm10DQorDQogI2luY2x1ZGUgPGxpbnV4L2tl
cm5lbC5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvcGNp
Lmg+DQpAQCAtMjUwNyw2ICsyNTA5LDQ3IEBAIHN0YXRpYyB2b2lkIHB1dF9odnBjaWJ1cyhzdHJ1
Y3QgaHZfcGNpYnVzX2RldmljZSAqaGJ1cykNCiAJCWNvbXBsZXRlKCZoYnVzLT5yZW1vdmVfZXZl
bnQpOw0KIH0NCiANCisjZGVmaW5lIEhWUENJX0RPTV9NQVBfU0laRSAoNjQgKiAxMDI0KQ0KK3N0
YXRpYyBERUNMQVJFX0JJVE1BUChodnBjaV9kb21fbWFwLCBIVlBDSV9ET01fTUFQX1NJWkUpOw0K
Kw0KKy8qIFBDSSBkb21haW4gbnVtYmVyIDAgaXMgdXNlZCBieSBlbXVsYXRlZCBkZXZpY2VzIG9u
IEdlbjEgVk1zLCBzbyBkZWZpbmUgMA0KKyAqIGFzIGludmFsaWQgZm9yIHBhc3N0aHJvdWdoIFBD
SSBkZXZpY2VzIG9mIHRoaXMgZHJpdmVyLg0KKyAqLw0KKyNkZWZpbmUgSFZQQ0lfRE9NX0lOVkFM
SUQgMA0KKw0KKy8qKg0KKyAqIGh2X2dldF9kb21fbnVtKCkgLSBHZXQgYSB2YWxpZCBQQ0kgZG9t
YWluIG51bWJlcg0KKyAqIENoZWNrIGlmIHRoZSBQQ0kgZG9tYWluIG51bWJlciBpcyBpbiB1c2Us
IGFuZCByZXR1cm4gYW5vdGhlciBudW1iZXIgaWYNCisgKiBpdCBpcyBpbiB1c2UuDQorICoNCisg
KiBAZG9tOiBSZXF1ZXN0ZWQgZG9tYWluIG51bWJlcg0KKyAqDQorICogcmV0dXJuOiBkb21haW4g
bnVtYmVyIG9uIHN1Y2Nlc3MsIEhWUENJX0RPTV9JTlZBTElEIG9uIGZhaWx1cmUNCisgKi8NCitz
dGF0aWMgdTE2IGh2X2dldF9kb21fbnVtKHUxNiBkb20pDQorew0KKwl1bnNpZ25lZCBpbnQgaTsN
CisNCisJaWYgKHRlc3RfYW5kX3NldF9iaXQoZG9tLCBodnBjaV9kb21fbWFwKSA9PSAwKQ0KKwkJ
cmV0dXJuIGRvbTsNCisNCisJZm9yX2VhY2hfY2xlYXJfYml0KGksIGh2cGNpX2RvbV9tYXAsIEhW
UENJX0RPTV9NQVBfU0laRSkgew0KKwkJaWYgKHRlc3RfYW5kX3NldF9iaXQoaSwgaHZwY2lfZG9t
X21hcCkgPT0gMCkNCisJCQlyZXR1cm4gaTsNCisJfQ0KKw0KKwlyZXR1cm4gSFZQQ0lfRE9NX0lO
VkFMSUQ7DQorfQ0KKw0KKy8qKg0KKyAqIGh2X3B1dF9kb21fbnVtKCkgLSBNYXJrIHRoZSBQQ0kg
ZG9tYWluIG51bWJlciBhcyBmcmVlDQorICogQGRvbTogRG9tYWluIG51bWJlciB0byBiZSBmcmVl
ZA0KKyAqLw0KK3N0YXRpYyB2b2lkIGh2X3B1dF9kb21fbnVtKHUxNiBkb20pDQorew0KKwljbGVh
cl9iaXQoZG9tLCBodnBjaV9kb21fbWFwKTsNCit9DQorDQogLyoqDQogICogaHZfcGNpX3Byb2Jl
KCkgLSBOZXcgVk1CdXMgY2hhbm5lbCBwcm9iZSwgZm9yIGEgcm9vdCBQQ0kgYnVzDQogICogQGhk
ZXY6CVZNQnVzJ3MgdHJhY2tpbmcgc3RydWN0IGZvciB0aGlzIHJvb3QgUENJIGJ1cw0KQEAgLTI1
MTgsNiArMjU2MSw3IEBAIHN0YXRpYyBpbnQgaHZfcGNpX3Byb2JlKHN0cnVjdCBodl9kZXZpY2Ug
KmhkZXYsDQogCQkJY29uc3Qgc3RydWN0IGh2X3ZtYnVzX2RldmljZV9pZCAqZGV2X2lkKQ0KIHsN
CiAJc3RydWN0IGh2X3BjaWJ1c19kZXZpY2UgKmhidXM7DQorCXUxNiBkb21fcmVxLCBkb207DQog
CWludCByZXQ7DQogDQogCS8qDQpAQCAtMjUzMiwxOSArMjU3NiwzMiBAQCBzdGF0aWMgaW50IGh2
X3BjaV9wcm9iZShzdHJ1Y3QgaHZfZGV2aWNlICpoZGV2LA0KIAloYnVzLT5zdGF0ZSA9IGh2X3Bj
aWJ1c19pbml0Ow0KIA0KIAkvKg0KLQkgKiBUaGUgUENJIGJ1cyAiZG9tYWluIiBpcyB3aGF0IGlz
IGNhbGxlZCAic2VnbWVudCIgaW4gQUNQSSBhbmQNCi0JICogb3RoZXIgc3BlY3MuICBQdWxsIGl0
IGZyb20gdGhlIGluc3RhbmNlIElELCB0byBnZXQgc29tZXRoaW5nDQotCSAqIHVuaXF1ZS4gIEJ5
dGVzIDggYW5kIDkgYXJlIHdoYXQgaXMgdXNlZCBpbiBXaW5kb3dzIGd1ZXN0cywgc28NCi0JICog
ZG8gdGhlIHNhbWUgdGhpbmcgZm9yIGNvbnNpc3RlbmN5LiAgTm90ZSB0aGF0LCBzaW5jZSB0aGlz
IGNvZGUNCi0JICogb25seSBydW5zIGluIGEgSHlwZXItViBWTSwgSHlwZXItViBjYW4gKGFuZCBk
b2VzKSBndWFyYW50ZWUNCi0JICogdGhhdCAoMSkgdGhlIG9ubHkgZG9tYWluIGluIHVzZSBmb3Ig
c29tZXRoaW5nIHRoYXQgbG9va3MgbGlrZQ0KLQkgKiBhIHBoeXNpY2FsIFBDSSBidXMgKHdoaWNo
IGlzIGFjdHVhbGx5IGVtdWxhdGVkIGJ5IHRoZQ0KLQkgKiBoeXBlcnZpc29yKSBpcyBkb21haW4g
MCBhbmQgKDIpIHRoZXJlIHdpbGwgYmUgbm8gb3ZlcmxhcA0KLQkgKiBiZXR3ZWVuIGRvbWFpbnMg
ZGVyaXZlZCBmcm9tIHRoZXNlIGluc3RhbmNlIElEcyBpbiB0aGUgc2FtZQ0KLQkgKiBWTS4NCisJ
ICogVGhlIFBDSSBidXMgImRvbWFpbiIgaXMgd2hhdCBpcyBjYWxsZWQgInNlZ21lbnQiIGluIEFD
UEkgYW5kIG90aGVyDQorCSAqIHNwZWNzLiBQdWxsIGl0IGZyb20gdGhlIGluc3RhbmNlIElELCB0
byBnZXQgc29tZXRoaW5nIHVzdWFsbHkNCisJICogdW5pcXVlLiBJbiByYXJlIGNhc2VzIG9mIGNv
bGxpc2lvbiwgd2Ugd2lsbCBmaW5kIG91dCBhbm90aGVyIG51bWJlcg0KKwkgKiBub3QgaW4gdXNl
Lg0KKwkgKiBOb3RlIHRoYXQsIHNpbmNlIHRoaXMgY29kZSBvbmx5IHJ1bnMgaW4gYSBIeXBlci1W
IFZNLCBIeXBlci1WDQorCSAqIHRvZ2V0aGVyIHdpdGggdGhpcyBndWVzdCBkcml2ZXIgY2FuIGd1
YXJhbnRlZSB0aGF0ICgxKSBUaGUgb25seQ0KKwkgKiBkb21haW4gdXNlZCBieSBHZW4xIFZNcyBm
b3Igc29tZXRoaW5nIHRoYXQgbG9va3MgbGlrZSBhIHBoeXNpY2FsDQorCSAqIFBDSSBidXMgKHdo
aWNoIGlzIGFjdHVhbGx5IGVtdWxhdGVkIGJ5IHRoZSBoeXBlcnZpc29yKSBpcyBkb21haW4gMC4N
CisJICogKDIpIFRoZXJlIHdpbGwgYmUgbm8gb3ZlcmxhcCBiZXR3ZWVuIGRvbWFpbnMgKGFmdGVy
IGZpeGluZyBwb3NzaWJsZQ0KKwkgKiBjb2xsaXNpb25zKSBpbiB0aGUgc2FtZSBWTS4NCiAJICov
DQotCWhidXMtPnN5c2RhdGEuZG9tYWluID0gaGRldi0+ZGV2X2luc3RhbmNlLmJbOV0gfA0KLQkJ
CSAgICAgICBoZGV2LT5kZXZfaW5zdGFuY2UuYls4XSA8PCA4Ow0KKwlkb21fcmVxID0gaGRldi0+
ZGV2X2luc3RhbmNlLmJbNV0gPDwgOCB8IGhkZXYtPmRldl9pbnN0YW5jZS5iWzRdOw0KKwlkb20g
PSBodl9nZXRfZG9tX251bShkb21fcmVxKTsNCisNCisJaWYgKGRvbSA9PSBIVlBDSV9ET01fSU5W
QUxJRCkgew0KKwkJcHJfZXJyKCJVbmFibGUgdG8gdXNlIGRvbSMgMHglaHggb3Igb3RoZXIgbnVt
YmVycyIsDQorCQkgICAgICAgZG9tX3JlcSk7DQorCQlyZXQgPSAtRUlOVkFMOw0KKwkJZ290byBm
cmVlX2J1czsNCisJfQ0KKw0KKwlpZiAoZG9tICE9IGRvbV9yZXEpDQorCQlwcl9pbmZvKCJQQ0kg
ZG9tIyAweCVoeCBoYXMgY29sbGlzaW9uLCB1c2luZyAweCVoeCIsDQorCQkJZG9tX3JlcSwgZG9t
KTsNCisNCisJaGJ1cy0+c3lzZGF0YS5kb21haW4gPSBkb207DQogDQogCWhidXMtPmhkZXYgPSBo
ZGV2Ow0KIAlyZWZjb3VudF9zZXQoJmhidXMtPnJlbW92ZV9sb2NrLCAxKTsNCkBAIC0yNTU5LDcg
KzI2MTYsNyBAQCBzdGF0aWMgaW50IGh2X3BjaV9wcm9iZShzdHJ1Y3QgaHZfZGV2aWNlICpoZGV2
LA0KIAkJCQkJICAgaGJ1cy0+c3lzZGF0YS5kb21haW4pOw0KIAlpZiAoIWhidXMtPndxKSB7DQog
CQlyZXQgPSAtRU5PTUVNOw0KLQkJZ290byBmcmVlX2J1czsNCisJCWdvdG8gZnJlZV9kb207DQog
CX0NCiANCiAJcmV0ID0gdm1idXNfb3BlbihoZGV2LT5jaGFubmVsLCBwY2lfcmluZ19zaXplLCBw
Y2lfcmluZ19zaXplLCBOVUxMLCAwLA0KQEAgLTI2MzYsNiArMjY5Myw4IEBAIHN0YXRpYyBpbnQg
aHZfcGNpX3Byb2JlKHN0cnVjdCBodl9kZXZpY2UgKmhkZXYsDQogCXZtYnVzX2Nsb3NlKGhkZXYt
PmNoYW5uZWwpOw0KIGRlc3Ryb3lfd3E6DQogCWRlc3Ryb3lfd29ya3F1ZXVlKGhidXMtPndxKTsN
CitmcmVlX2RvbToNCisJaHZfcHV0X2RvbV9udW0oaGJ1cy0+c3lzZGF0YS5kb21haW4pOw0KIGZy
ZWVfYnVzOg0KIAlmcmVlX3BhZ2UoKHVuc2lnbmVkIGxvbmcpaGJ1cyk7DQogCXJldHVybiByZXQ7
DQpAQCAtMjcxNyw2ICsyNzc2LDkgQEAgc3RhdGljIGludCBodl9wY2lfcmVtb3ZlKHN0cnVjdCBo
dl9kZXZpY2UgKmhkZXYpDQogCXB1dF9odnBjaWJ1cyhoYnVzKTsNCiAJd2FpdF9mb3JfY29tcGxl
dGlvbigmaGJ1cy0+cmVtb3ZlX2V2ZW50KTsNCiAJZGVzdHJveV93b3JrcXVldWUoaGJ1cy0+d3Ep
Ow0KKw0KKwlodl9wdXRfZG9tX251bShoYnVzLT5zeXNkYXRhLmRvbWFpbik7DQorDQogCWZyZWVf
cGFnZSgodW5zaWduZWQgbG9uZyloYnVzKTsNCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTI3NDQsNiAr
MjgwNiw5IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCBleGl0X2h2X3BjaV9kcnYodm9pZCkNCiANCiBz
dGF0aWMgaW50IF9faW5pdCBpbml0X2h2X3BjaV9kcnYodm9pZCkNCiB7DQorCS8qIFNldCB0aGUg
aW52YWxpZCBkb21haW4gbnVtYmVyJ3MgYml0LCBzbyBpdCB3aWxsIG5vdCBiZSB1c2VkICovDQor
CXNldF9iaXQoSFZQQ0lfRE9NX0lOVkFMSUQsIGh2cGNpX2RvbV9tYXApOw0KKw0KIAlyZXR1cm4g
dm1idXNfZHJpdmVyX3JlZ2lzdGVyKCZodl9wY2lfZHJ2KTsNCiB9DQogDQotLSANCjEuOC4zLjEN
Cg0K
