Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC811B728D
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 07:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfISFTS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 01:19:18 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:46065
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387576AbfISFTR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 01:19:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5Bw0Z8ZI+cjmEPFRZ+JOcrB0SVGB7JjgvedC8sEWI5zrJBNA04E5BBBbKjYU4ceWSoChCyk6GZk+Lx+RktWQBEcl/KzWka+RJMhAnrFMwgkDj5Bd7Hbnxm89Ymse/SWivfNo0YUStSTgRSOO7WAYd20MjWAAh/puly0V3EpgQzZKIEvlWiUpSzhXq9+JgEMnSzhOOhqS1yhAAzp1REu41WER5ONJs4G3/uVdGzTes0ZlJpp9pfXz9JoDm025Mb7XMpvspU+cKn0lqmEly+0Vrrw00FpjWbydhVm1sMpyHUEO2dWsMus4qq4OpN1ylcSKlhvYUYzXIktt+x8p2qFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVdLhnvC2LboEVFA17TX0R4DGm/M9CscwHgflRuNKC0=;
 b=msp5u/ejRSN3O943FS5ifTrT97xkij1vCOk6kSNpiDza2XspCzyKMfgNj/LdTZJviIgH3Wdp+vhQNx8kK8be1Jdn1bvugjhlv0oyIihjM/AiJ6bRPOqton7FQg72vMv0N7APULELDU1e7WCQDpmGqtEl5uGqF7O0W4h1Y4auxVQhY44jVqDUmTft1X3GbDvq3ba2NUzd7+dHbmv0EM3mieaaYvp26crOAeEhDg0idQYDK6E+n9MJb1T1emxoXyWXZ4Nv4m4aXn8KQqNMtS1X3uXmMfzJc9Vavy2d4DQob/pfxo+9MLXK6ACjXyKqFnwDHTgUGGnRbXspNXFM0AEy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVdLhnvC2LboEVFA17TX0R4DGm/M9CscwHgflRuNKC0=;
 b=SbkCLmIY7uK16Ez7a2S1f3GXOR6czObzk8CHn9GSwqrhv0nkMOP570mIsS/ZEnRS8RSWY7Xwx9F2Fbv4NWAmbjRdFrRy3cmi/bZhTI0blScT2T/dMoWH8+SPeTwYGyZXxaqwXlVJZ7Migtt4llwxxl+a+AxeeJH8NXy1Y/6UIPY=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0926.namprd21.prod.outlook.com (52.132.117.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.6; Thu, 19 Sep 2019 05:19:15 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::7d1a:ddb:3473:b383%9]) with mapi id 15.20.2305.000; Thu, 19 Sep 2019
 05:19:15 +0000
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
Subject: [PATCH] Drivers: hv: vmbus: Fix harmless building warnings without
 CONFIG_PM
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix harmless building warnings
 without CONFIG_PM
Thread-Index: AQHVbqnHI1Mc0HXAtE6Mh83Vyyvt0Q==
Date:   Thu, 19 Sep 2019 05:19:14 +0000
Message-ID: <1568870297-108679-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1001CA0009.namprd10.prod.outlook.com
 (2603:10b6:301:2a::22) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 579dc9d5-bd3a-4db0-eace-08d73cc0e997
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR2101MB0926:|SN6PR2101MB0926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB0926087DA6A7C371B7AD33E5BF890@SN6PR2101MB0926.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(6116002)(10090500001)(102836004)(14444005)(26005)(2501003)(256004)(99286004)(81166006)(478600001)(186003)(6512007)(6486002)(8676002)(86362001)(386003)(2201001)(25786009)(107886003)(50226002)(8936002)(52116002)(6506007)(6436002)(71190400001)(71200400001)(81156014)(10290500003)(66066001)(2906002)(4326008)(110136005)(66446008)(486006)(66946007)(1511001)(3846002)(5660300002)(64756008)(66556008)(66476007)(316002)(476003)(4720700003)(305945005)(2616005)(7736002)(36756003)(22452003)(43066004)(14454004)(3450700001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0926;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/QV0FGGHD7GD8sH3C4/N6xkcglY0xts+S9S2ORDMBFd1wLu66PYenpdkq1Dzny0AsVxW7IMKMhcWqLJQ3YEhgbFLQmjH+QuplCWOYML5PGWjQEgmKPkFaR++CALmSFVrvbgCC5XloRtbGgDr2sDDqsPudwusCT9k7zZi28Q7MS1v9gYVyqaHFQadgiGI5gBf1vKFzUOlOpXLAcAqdxG4FVlsPPB7PJ3/97DFfOY+G7bo3Rt8uR32hQcUqVqHa5pUXIHhD4bsqoV2X0Oei9Ki+JXSyBESMMnD02N7yKU/0T0kdMiobSKxg/veyp4f94UZTP89EwDp4AJodnA29G1rZReXIQ1be/bWgEp+ib3c4T6r9oi5gUISz6GxkOStRyWlIuXWmIktCfSFG2zuyTF3P0gN0DETuaJ4gMzPg1Or6s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B829FAAB87E5459823BE2EE9B4A294@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579dc9d5-bd3a-4db0-eace-08d73cc0e997
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 05:19:15.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxfeCCSY2VZmQwvfxmEPvtXn6Dv2DP3D377ADr1FmR1323kzHPRNyj7ddPpiNHwnOeS1vmn+doj6jRJb3Tleyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0926
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

SWYgQ09ORklHX1BNIGlzIG5vdCBzZXQsIHdlIGNhbiBjb21tZW50IG91dCB0aGVzZSBmdW5jdGlv
bnMgdG8gYXZvaWQgdGhlDQpiZWxvdyB3YXJuaW5nczoNCg0KZHJpdmVycy9odi92bWJ1c19kcnYu
YzoyMjA4OjEyOiB3YXJuaW5nOiDigJh2bWJ1c19idXNfcmVzdW1l4oCZIGRlZmluZWQgYnV0IG5v
dCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCmRyaXZlcnMvaHYvdm1idXNfZHJ2LmM6MjEyODox
Mjogd2FybmluZzog4oCYdm1idXNfYnVzX3N1c3BlbmTigJkgZGVmaW5lZCBidXQgbm90IHVzZWQg
Wy1XdW51c2VkLWZ1bmN0aW9uXQ0KZHJpdmVycy9odi92bWJ1c19kcnYuYzo5Mzc6MTI6IHdhcm5p
bmc6IOKAmHZtYnVzX3Jlc3VtZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVu
Y3Rpb25dDQpkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jOjkxODoxMjogd2FybmluZzog4oCYdm1idXNf
c3VzcGVuZOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQoNCkZp
eGVzOiAyNzFiMjIyNGQ0MmYgKCJEcml2ZXJzOiBodjogdm1idXM6IEltcGxlbWVudCBzdXNwZW5k
L3Jlc3VtZSBmb3IgVlNDIGRyaXZlcnMgZm9yIGhpYmVybmF0aW9uIikNCkZpeGVzOiBmNTMzMzVl
MzI4OWYgKCJEcml2ZXJzOiBodjogdm1idXM6IFN1c3BlbmQvcmVzdW1lIHRoZSB2bWJ1cyBpdHNl
bGYgZm9yIGhpYmVybmF0aW9uIikNClJlcG9ydGVkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPg0KU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvaHYvdm1idXNfZHJ2LmMgfCA2ICsrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMg
Yi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQppbmRleCAzOTFmMGIyMjVjOWEuLjhiZmIzNjY5NTQx
MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCisrKyBiL2RyaXZlcnMvaHYv
dm1idXNfZHJ2LmMNCkBAIC05MTIsNiArOTEyLDcgQEAgc3RhdGljIHZvaWQgdm1idXNfc2h1dGRv
d24oc3RydWN0IGRldmljZSAqY2hpbGRfZGV2aWNlKQ0KIAkJZHJ2LT5zaHV0ZG93bihkZXYpOw0K
IH0NCiANCisjaWZkZWYgQ09ORklHX1BNDQogLyoNCiAgKiB2bWJ1c19zdXNwZW5kIC0gU3VzcGVu
ZCBhIHZtYnVzIGRldmljZQ0KICAqLw0KQEAgLTk0OSw2ICs5NTAsNyBAQCBzdGF0aWMgaW50IHZt
YnVzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpjaGlsZF9kZXZpY2UpDQogDQogCXJldHVybiBkcnYt
PnJlc3VtZShkZXYpOw0KIH0NCisjZW5kaWYgLyogQ09ORklHX1BNICovDQogDQogLyoNCiAgKiB2
bWJ1c19kZXZpY2VfcmVsZWFzZSAtIEZpbmFsIGNhbGxiYWNrIHJlbGVhc2Ugb2YgdGhlIHZtYnVz
IGNoaWxkIGRldmljZQ0KQEAgLTEwNzAsNiArMTA3Miw3IEBAIHZvaWQgdm1idXNfb25fbXNnX2Rw
Yyh1bnNpZ25lZCBsb25nIGRhdGEpDQogCXZtYnVzX3NpZ25hbF9lb20obXNnLCBtZXNzYWdlX3R5
cGUpOw0KIH0NCiANCisjaWZkZWYgQ09ORklHX1BNDQogLyoNCiAgKiBGYWtlIFJFU0NJTkRfQ0hB
Tk5FTCBtZXNzYWdlcyB0byBjbGVhbiB1cCBodl9zb2NrIGNoYW5uZWxzIGJ5IGZvcmNlIGZvcg0K
ICAqIGhpYmVybmF0aW9uLCBiZWNhdXNlIGh2X3NvY2sgY29ubmVjdGlvbnMgY2FuIG5vdCBwZXJz
aXN0IGFjcm9zcyBoaWJlcm5hdGlvbi4NCkBAIC0xMTA1LDYgKzExMDgsNyBAQCBzdGF0aWMgdm9p
ZCB2bWJ1c19mb3JjZV9jaGFubmVsX3Jlc2NpbmRlZChzdHJ1Y3Qgdm1idXNfY2hhbm5lbCAqY2hh
bm5lbCkNCiAJCSAgICAgIHZtYnVzX2Nvbm5lY3Rpb24ud29ya19xdWV1ZSwNCiAJCSAgICAgICZj
dHgtPndvcmspOw0KIH0NCisjZW5kaWYgLyogQ09ORklHX1BNICovDQogDQogLyoNCiAgKiBEaXJl
Y3QgY2FsbGJhY2sgZm9yIGNoYW5uZWxzIHVzaW5nIG90aGVyIGRlZmVycmVkIHByb2Nlc3NpbmcN
CkBAIC0yMTI1LDYgKzIxMjksNyBAQCBzdGF0aWMgaW50IHZtYnVzX2FjcGlfYWRkKHN0cnVjdCBh
Y3BpX2RldmljZSAqZGV2aWNlKQ0KIAlyZXR1cm4gcmV0X3ZhbDsNCiB9DQogDQorI2lmZGVmIENP
TkZJR19QTQ0KIHN0YXRpYyBpbnQgdm1idXNfYnVzX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KIHsNCiAJc3RydWN0IHZtYnVzX2NoYW5uZWwgKmNoYW5uZWwsICpzYzsNCkBAIC0yMjQ3LDYg
KzIyNTIsNyBAQCBzdGF0aWMgaW50IHZtYnVzX2J1c19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2
KQ0KIA0KIAlyZXR1cm4gMDsNCiB9DQorI2VuZGlmIC8qIENPTkZJR19QTSAqLw0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgdm1idXNfYWNwaV9kZXZpY2VfaWRzW10gPSB7
DQogCXsiVk1CVVMiLCAwfSwNCi0tIA0KMi4xOS4xDQoNCg==
