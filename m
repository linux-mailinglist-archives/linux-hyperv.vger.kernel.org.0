Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42F5B83A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403943AbfISVqU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 17:46:20 -0400
Received: from mail-eopbgr730115.outbound.protection.outlook.com ([40.107.73.115]:42268
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403799AbfISVqT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 17:46:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1mw7IWCnSdGo7Id3fiZUVDAWv9lB6bGSzUWvYdyeSVkLVoshlLEx3yWbTboNiTYsmVtQ7WijYwDw/l18gfnFN/15k/5sCi5ZUSOldSu1bamnxgxxiK9pJhuYqlMGvLlfzfVsI/vW06f12GJln5vGS60W4A4NeNG4DuFmdpt0N1QvNdydh2vphgNH47PpjR9INxV68mB+Sycpnjg20gb26jrguVqGse4S2gvQnaJ68HuEgstHfOdUe8syprCEb+YwPQ90UflFgroBpu4sgnuJqPbpkHraopqwJMNqLnoUSbv8CkCqINB/nF4om5tOcMRaP2JLfpAqnCAYfgYSkK2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcJ4GYYCYznLUjHpJArbXKnXw5TV4914/d0wALog7V4=;
 b=eINBvi5pMswtoMo8f5trJ2XDHEmiT/jL/gsGg77NSGdpRDQ5SpSTygPx3DTFEEcFs6bt2HlJobt+b6wMCK7uAUAHbZfnK03xraM4PgkirY0MqMvdihHILmBmwyHedlgrgnE6koBV/JvXIctH2DVf/BpyuX0XABLuLiPjnu7nbe/fIDc9R8L/v9VnZqCtqz6GtcAUzAs5nurv2LH46ILQjahYcozMZmTiqU/yQ+cKU9lpuXXhnp9tt7iocNzzuVjSvniU7Dn/js+cefv5J8yWRlmgvRxcL/vqT6jp6u+ScTFQ8VBYyD8Svv1OgieXO31ZgqUtizR4BSoFGb/EWPX0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcJ4GYYCYznLUjHpJArbXKnXw5TV4914/d0wALog7V4=;
 b=GoERXF8xG7Wa7gQ/FTERalmA3S/sAm95UJAU5+33gogdopp7QxyH6ulMLIW26T6I1t7AuwP/dHwwzlLj0Y02sGyfYVcmFVGwLJxbWJyx6PXtnhGDqwWCOcLryHNjnzo0t6OCZq6bBu8fU0xuKNu0/iM6ApGqptGoq4J4ngH3j08=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.4; Thu, 19 Sep 2019 21:46:14 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383%9]) with mapi id 15.20.2305.000; Thu, 19 Sep 2019
 21:46:13 +0000
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
Subject: [PATCH v2] Drivers: hv: vmbus: Fix harmless building warnings without
 CONFIG_PM_SLEEP
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM_SLEEP
Thread-Index: AQHVbzOn66tbgs3I5Ui535QUQicqZA==
Date:   Thu, 19 Sep 2019 21:46:12 +0000
Message-ID: <1568929540-116670-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:300:ed::26) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d074d2ef-7c69-4305-9648-08d73d4ac9e4
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB0909C45A94BB123FE578B7BCBF890@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(22452003)(256004)(3846002)(305945005)(2201001)(2906002)(8676002)(66476007)(66556008)(64756008)(3450700001)(6116002)(7736002)(8936002)(71190400001)(71200400001)(66446008)(14454004)(81166006)(81156014)(5660300002)(14444005)(66946007)(102836004)(26005)(386003)(52116002)(25786009)(6486002)(10090500001)(99286004)(486006)(2616005)(6512007)(4326008)(6506007)(36756003)(316002)(186003)(50226002)(86362001)(107886003)(110136005)(476003)(1511001)(43066004)(66066001)(6436002)(10290500003)(478600001)(2501003)(4720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +aZqXBtos2vjtiR6RJUe2+ycGsBQOE4rXH8666Y2ODVNQyARayTq2/HzNTohoZLM/ERjr90fyupC4NannSAqkDpr1fnyNG0jXljILd2e2rqj2fhRf3AS5uQCX8iceBqL+t0hCulD9qOEq+aSvFg8CKES20iX0YaawjKsesGMEWL4J6ZhS5jGCjosb4KJiCmSjcKuCc704NrX3UKYLkXZmxRi9mEWuiMrpbCICRykJLOEFfEgzFniiRkbYK4CcNXzy69MHmzkG2rJxMJvnZf8RAcWmwRTrOeRfjrOOs+QlA+eWjDU/KUWzdiHe1T1MckHTBKcC+p0CV4dAwZk2ViI9U4NWGvsa6BPHTPlumcwjJdPFjzIz7KVqndRvTQ2mfuzro96QyXDgh9U2zi2aUzm0teV9UTrDuUCldcELx2dplY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE973C329B10A544AD7D4FBBBE87579D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d074d2ef-7c69-4305-9648-08d73d4ac9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 21:46:12.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ax68cX73LeHXkhDcHtxLwJ+uRW0Vjdg60lr6kAszfRvuZyYkcJCLdtSabhPf9igPyAl2BODUpTsK8RORNVScPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
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
cm5kQGFybmRiLmRlPg0KU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0
LmNvbT4NCi0tLQ0KDQpJbiB2MjoNCgl0ZXN0IENPTkZJR19QTV9TTEVFUCByYXRoZXIgdGhhbiBD
T05GSUdfUE0uIFRoYW5rcywgQXJuZCENCg0KIGRyaXZlcnMvaHYvdm1idXNfZHJ2LmMgfCA2ICsr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaHYvdm1idXNfZHJ2LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQppbmRleCAzOTFm
MGIyMjVjOWEuLjUzYTYwYzgxZTIyMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2
LmMNCisrKyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCkBAIC05MTIsNiArOTEyLDcgQEAgc3Rh
dGljIHZvaWQgdm1idXNfc2h1dGRvd24oc3RydWN0IGRldmljZSAqY2hpbGRfZGV2aWNlKQ0KIAkJ
ZHJ2LT5zaHV0ZG93bihkZXYpOw0KIH0NCiANCisjaWZkZWYgQ09ORklHX1BNX1NMRUVQDQogLyoN
CiAgKiB2bWJ1c19zdXNwZW5kIC0gU3VzcGVuZCBhIHZtYnVzIGRldmljZQ0KICAqLw0KQEAgLTk0
OSw2ICs5NTAsNyBAQCBzdGF0aWMgaW50IHZtYnVzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpjaGls
ZF9kZXZpY2UpDQogDQogCXJldHVybiBkcnYtPnJlc3VtZShkZXYpOw0KIH0NCisjZW5kaWYgLyog
Q09ORklHX1BNX1NMRUVQICovDQogDQogLyoNCiAgKiB2bWJ1c19kZXZpY2VfcmVsZWFzZSAtIEZp
bmFsIGNhbGxiYWNrIHJlbGVhc2Ugb2YgdGhlIHZtYnVzIGNoaWxkIGRldmljZQ0KQEAgLTEwNzAs
NiArMTA3Miw3IEBAIHZvaWQgdm1idXNfb25fbXNnX2RwYyh1bnNpZ25lZCBsb25nIGRhdGEpDQog
CXZtYnVzX3NpZ25hbF9lb20obXNnLCBtZXNzYWdlX3R5cGUpOw0KIH0NCiANCisjaWZkZWYgQ09O
RklHX1BNX1NMRUVQDQogLyoNCiAgKiBGYWtlIFJFU0NJTkRfQ0hBTk5FTCBtZXNzYWdlcyB0byBj
bGVhbiB1cCBodl9zb2NrIGNoYW5uZWxzIGJ5IGZvcmNlIGZvcg0KICAqIGhpYmVybmF0aW9uLCBi
ZWNhdXNlIGh2X3NvY2sgY29ubmVjdGlvbnMgY2FuIG5vdCBwZXJzaXN0IGFjcm9zcyBoaWJlcm5h
dGlvbi4NCkBAIC0xMTA1LDYgKzExMDgsNyBAQCBzdGF0aWMgdm9pZCB2bWJ1c19mb3JjZV9jaGFu
bmVsX3Jlc2NpbmRlZChzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hhbm5lbCkNCiAJCSAgICAgIHZt
YnVzX2Nvbm5lY3Rpb24ud29ya19xdWV1ZSwNCiAJCSAgICAgICZjdHgtPndvcmspOw0KIH0NCisj
ZW5kaWYgLyogQ09ORklHX1BNX1NMRUVQICovDQogDQogLyoNCiAgKiBEaXJlY3QgY2FsbGJhY2sg
Zm9yIGNoYW5uZWxzIHVzaW5nIG90aGVyIGRlZmVycmVkIHByb2Nlc3NpbmcNCkBAIC0yMTI1LDYg
KzIxMjksNyBAQCBzdGF0aWMgaW50IHZtYnVzX2FjcGlfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAq
ZGV2aWNlKQ0KIAlyZXR1cm4gcmV0X3ZhbDsNCiB9DQogDQorI2lmZGVmIENPTkZJR19QTV9TTEVF
UA0KIHN0YXRpYyBpbnQgdm1idXNfYnVzX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsN
CiAJc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwsICpzYzsNCkBAIC0yMjQ3LDYgKzIyNTIs
NyBAQCBzdGF0aWMgaW50IHZtYnVzX2J1c19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KIA0K
IAlyZXR1cm4gMDsNCiB9DQorI2VuZGlmIC8qIENPTkZJR19QTV9TTEVFUCAqLw0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgdm1idXNfYWNwaV9kZXZpY2VfaWRzW10gPSB7
DQogCXsiVk1CVVMiLCAwfSwNCi0tIA0KMi4xOS4xDQoNCg==
