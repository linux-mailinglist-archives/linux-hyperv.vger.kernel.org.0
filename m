Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141ADBE4D6
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2019 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443272AbfIYSoB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 14:44:01 -0400
Received: from mail-eopbgr770138.outbound.protection.outlook.com ([40.107.77.138]:22295
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2443246AbfIYSoA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 14:44:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AenTYgbSHYYjwRxEPphsfditXs285K2dyZO1iUBY0keOf6UxgOkLXHxllpb05bNVw9mJzTiktCSUfgL7ufkidpaFgMFYbr1uuetE3MMvMo6tL01TrsPCyeUidAay2Mm05mTvbhoMag/wogSesMY/+izdc/nujfM8edC5wg/s3GevF/VSMd9IBTWqmwfPw0iaLswY5m7eALVDlf9yFxZ8so+9EnMKOkLHgQFpW5wIbsMGXy3P5SgTqtPC8WLJoxMSfnutg7ykyOQLmHPZJw+wChUmXSObb/6U8UWBrMV71CT3dyIfsQpPQMnc3vLJ+bzvjSlCj1A2c1F4iJJTHHTHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9i0IDR4i3vLZBG9VEbs3HpnUjGGE+4+pQ9p42kKAFc=;
 b=BjGUw8vfkyzRSHimvS3iuiXDziBwyUoxGMCb0x/obqWPhD3+/Gwhqe1PxIq1lS+HKMpoUhBcA8e52zq3MUhQ2B7AYRhKoVb0SmzXpHNJPTnNPuLZgJvuxNT0qHkMrfECVuqhxRhFREQ7YJoVKkPCyej1CGhPDT+F1RKu/NbRlmDHAtzRDVoiZUu7cEZqStUjSZBdz1dlbevVD2/QVawjNMaIzkRfGeyfTcO9fz8MQFYDbsYV3d1GZxXgCYWZw0J9/LpGDfKRDhfbhAx68VpQ20OXuG0A/RL5CZNslALK3Z1SO4kRKYrA2cSQDKHaftokq3iVJqtTzXayOdjkjtcrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9i0IDR4i3vLZBG9VEbs3HpnUjGGE+4+pQ9p42kKAFc=;
 b=K2adgvYyvbbCoccZb7RULPanIMdDPgtjU676QzLOlvZHE2YYkRDvFLCLmhJZg/IXpJkymNkGnFbEL38GMl2+x9IkWDS44CO9pyD5S/Dsc7c59fz3kL9rOQ1T4UPZbODeXFEroZt2NOwytKVvD8XFZ0w8IiAYidCpkQVhRhGfj2s=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0895.namprd21.prod.outlook.com (52.132.116.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.3; Wed, 25 Sep 2019 18:43:58 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383%9]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 18:43:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3] Drivers: hv: vmbus: Fix harmless building warnings without
 CONFIG_PM_SLEEP
Thread-Topic: [PATCH v3] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM_SLEEP
Thread-Index: AQHVc9Ew6ma/FG7fcEi3EqlsYUS2JA==
Date:   Wed, 25 Sep 2019 18:43:57 +0000
Message-ID: <1569436998-130708-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR06CA0073.namprd06.prod.outlook.com
 (2603:10b6:104:3::31) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18e0c7b3-70f9-4624-dbd7-08d741e852ec
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR2101MB0895:|SN6PR2101MB0895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB0895D2990559F312B82FA016BF870@SN6PR2101MB0895.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(476003)(26005)(25786009)(7736002)(102836004)(107886003)(6506007)(66476007)(478600001)(4326008)(386003)(14454004)(64756008)(316002)(256004)(22452003)(36756003)(14444005)(43066004)(6116002)(66946007)(66556008)(6436002)(2906002)(110136005)(66446008)(10090500001)(1511001)(86362001)(6486002)(8936002)(81156014)(2616005)(10290500003)(5660300002)(2501003)(71190400001)(6512007)(66066001)(186003)(99286004)(305945005)(3846002)(52116002)(2201001)(8676002)(81166006)(486006)(71200400001)(4720700003)(3450700001)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0895;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4s82ulJIoYpCJmCglzAlkfNkQjix9zO/5ZGY8WsxRXxHLz15BGAEqpM1zR0Pj3UNh8Uk/1KY1xq5DH2WidVMUJuwjUkluH0l/PiSqqJvNwo7DwI4uaWcE48HnEaAQYuFS+CGbUv1tlqSex5Ga2KquookdprRkOc1GUxaHANE+IF4UciR+CEID3+yF2+mD/J52pZ7S7gymuFFs9ySipew29ZXGnA6Jd+hJVC5bFjmWxp/JGrs4KTs4x6wIZRakRw5Rz6JddDZcRBA/Uj9FZuV/PaP30ADvG/tp0Kyc+h9VrE2qskXnP4rKGI8VtY62PU/rRbwyzJDjilWHne140/fQiOOJg0D9Nc/dak6fxxskjaWz4K6OiGr+lxTDoZduPNquRpsBn8amEZBRcsiVpBp20xTRCVWK/1XCjIR2v76Lho=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A836407DFAEA8946A92A7BBB5166D6BA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e0c7b3-70f9-4624-dbd7-08d741e852ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 18:43:58.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIwOZKgqGc6IjJPjt8skr5qmdeWqTulRGlyFMCAC5lZspGtdcvtur0k3b8PcPKSVv14Py3TbLgcExTGafijrBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0895
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

SWYgQ09ORklHX1BNX1NMRUVQIGlzIG5vdCBzZXQsIHdlIGNhbiBjb21tZW50IG91dCB0aGVzZSBm
dW5jdGlvbnMgdG8gYXZvaWQNCnRoZSBiZWxvdyB3YXJuaW5nczoNCg0KZHJpdmVycy9odi92bWJ1
c19kcnYuYzoyMjA4OjEyOiB3YXJuaW5nOiDigJh2bWJ1c19idXNfcmVzdW1l4oCZIGRlZmluZWQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCmRyaXZlcnMvaHYvdm1idXNfZHJ2LmM6
MjEyODoxMjogd2FybmluZzog4oCYdm1idXNfYnVzX3N1c3BlbmTigJkgZGVmaW5lZCBidXQgbm90
IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQ0KZHJpdmVycy9odi92bWJ1c19kcnYuYzo5Mzc6MTI6
IHdhcm5pbmc6IOKAmHZtYnVzX3Jlc3VtZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtZnVuY3Rpb25dDQpkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jOjkxODoxMjogd2FybmluZzog4oCY
dm1idXNfc3VzcGVuZOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25d
DQoNCkZpeGVzOiAyNzFiMjIyNGQ0MmYgKCJEcml2ZXJzOiBodjogdm1idXM6IEltcGxlbWVudCBz
dXNwZW5kL3Jlc3VtZSBmb3IgVlNDIGRyaXZlcnMgZm9yIGhpYmVybmF0aW9uIikNCkZpeGVzOiBm
NTMzMzVlMzI4OWYgKCJEcml2ZXJzOiBodjogdm1idXM6IFN1c3BlbmQvcmVzdW1lIHRoZSB2bWJ1
cyBpdHNlbGYgZm9yIGhpYmVybmF0aW9uIikNClJlcG9ydGVkLWJ5OiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGFybmRiLmRlPg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNy
b3NvZnQuY29tPg0KU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNv
bT4NCi0tLQ0KDQpJbiB2MjoNCgl0ZXN0IENPTkZJR19QTV9TTEVFUCByYXRoZXIgdGhhbiBDT05G
SUdfUE0uIFRoYW5rcywgQXJuZCENCg0KSW4gdjM6DQoJQWRkIE1pY2hhZWwncyBSZXZpZXdlZC1i
eS4NCglObyBvdGhlciBjaGFuZ2UuDQoNCiBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIHwgNiArKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2h2L3ZtYnVzX2Rydi5jIGIvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KaW5kZXggMzkxZjBi
MjI1YzlhLi41M2E2MGM4MWUyMjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5j
DQorKysgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQpAQCAtOTEyLDYgKzkxMiw3IEBAIHN0YXRp
YyB2b2lkIHZtYnVzX3NodXRkb3duKHN0cnVjdCBkZXZpY2UgKmNoaWxkX2RldmljZSkNCiAJCWRy
di0+c2h1dGRvd24oZGV2KTsNCiB9DQogDQorI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KIC8qDQog
ICogdm1idXNfc3VzcGVuZCAtIFN1c3BlbmQgYSB2bWJ1cyBkZXZpY2UNCiAgKi8NCkBAIC05NDks
NiArOTUwLDcgQEAgc3RhdGljIGludCB2bWJ1c19yZXN1bWUoc3RydWN0IGRldmljZSAqY2hpbGRf
ZGV2aWNlKQ0KIA0KIAlyZXR1cm4gZHJ2LT5yZXN1bWUoZGV2KTsNCiB9DQorI2VuZGlmIC8qIENP
TkZJR19QTV9TTEVFUCAqLw0KIA0KIC8qDQogICogdm1idXNfZGV2aWNlX3JlbGVhc2UgLSBGaW5h
bCBjYWxsYmFjayByZWxlYXNlIG9mIHRoZSB2bWJ1cyBjaGlsZCBkZXZpY2UNCkBAIC0xMDcwLDYg
KzEwNzIsNyBAQCB2b2lkIHZtYnVzX29uX21zZ19kcGModW5zaWduZWQgbG9uZyBkYXRhKQ0KIAl2
bWJ1c19zaWduYWxfZW9tKG1zZywgbWVzc2FnZV90eXBlKTsNCiB9DQogDQorI2lmZGVmIENPTkZJ
R19QTV9TTEVFUA0KIC8qDQogICogRmFrZSBSRVNDSU5EX0NIQU5ORUwgbWVzc2FnZXMgdG8gY2xl
YW4gdXAgaHZfc29jayBjaGFubmVscyBieSBmb3JjZSBmb3INCiAgKiBoaWJlcm5hdGlvbiwgYmVj
YXVzZSBodl9zb2NrIGNvbm5lY3Rpb25zIGNhbiBub3QgcGVyc2lzdCBhY3Jvc3MgaGliZXJuYXRp
b24uDQpAQCAtMTEwNSw2ICsxMTA4LDcgQEAgc3RhdGljIHZvaWQgdm1idXNfZm9yY2VfY2hhbm5l
bF9yZXNjaW5kZWQoc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwpDQogCQkgICAgICB2bWJ1
c19jb25uZWN0aW9uLndvcmtfcXVldWUsDQogCQkgICAgICAmY3R4LT53b3JrKTsNCiB9DQorI2Vu
ZGlmIC8qIENPTkZJR19QTV9TTEVFUCAqLw0KIA0KIC8qDQogICogRGlyZWN0IGNhbGxiYWNrIGZv
ciBjaGFubmVscyB1c2luZyBvdGhlciBkZWZlcnJlZCBwcm9jZXNzaW5nDQpAQCAtMjEyNSw2ICsy
MTI5LDcgQEAgc3RhdGljIGludCB2bWJ1c19hY3BpX2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRl
dmljZSkNCiAJcmV0dXJuIHJldF92YWw7DQogfQ0KIA0KKyNpZmRlZiBDT05GSUdfUE1fU0xFRVAN
CiBzdGF0aWMgaW50IHZtYnVzX2J1c19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCiB7DQog
CXN0cnVjdCB2bWJ1c19jaGFubmVsICpjaGFubmVsLCAqc2M7DQpAQCAtMjI0Nyw2ICsyMjUyLDcg
QEAgc3RhdGljIGludCB2bWJ1c19idXNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiANCiAJ
cmV0dXJuIDA7DQogfQ0KKyNlbmRpZiAvKiBDT05GSUdfUE1fU0xFRVAgKi8NCiANCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIHZtYnVzX2FjcGlfZGV2aWNlX2lkc1tdID0gew0K
IAl7IlZNQlVTIiwgMH0sDQotLSANCjIuMTkuMQ0KDQo=
