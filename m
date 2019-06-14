Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792C8467B7
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFNSmU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 14:42:20 -0400
Received: from mail-eopbgr700109.outbound.protection.outlook.com ([40.107.70.109]:24673
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfFNSmU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 14:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=VbFWkM++5VZwbil8F0LJiaL4g2ZBpoMeyyi0OMzipEel8S6VAj8x3cUt0Iqqma4zgLx8uaY+g4TQ3iW2y6jAeXoV2CUr9dkf3G9Avr+a7zQBnQWHOMVFGXdUhtmNVXy24ekYj3zYlQ0RRSxbgylxFyINjFhufWDs986YQdyc2NU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHUT39YEn8t6g1BMeeEW2O+kkjs65rFDJZDSf4i4byM=;
 b=qmSQsGqdhjLwIDjAJ1IuZC0Me6NpJ9BO2ebRaJ2kTr1wB2jqwZBCXScU1sSOxdfCNS91LXz5WL1ZObRQghutoiYptE3Gp8Tmm8oDqLkKm2RzTIljq+VNFMggUErlyet7crbGq49rVjW5Y3ZIuuYQwIUJgBlr8Kd4+25yZ78/98A=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHUT39YEn8t6g1BMeeEW2O+kkjs65rFDJZDSf4i4byM=;
 b=TahaLHYTTjx73HWu1sq1tkFWtuCoq+zK/UH3hf7yqFabEIVeSRUunHCaT56jfPpB8uYNHJt8dHz/PB/bFhWiGi+0PpxZoQgAsJC8LyXvsEFCmXCarzHJ6ZfiXSZbz7ElxaynxE9ttltS1sPMqGohJizNmNOY4XplU5OK0RJg6YA=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19)
 by SN6PR2101MB1056.namprd21.prod.outlook.com (2603:10b6:805:6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.2; Fri, 14 Jun
 2019 18:42:17 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d8f0:bc1e:20d2:9bf6]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d8f0:bc1e:20d2:9bf6%3]) with mapi id 15.20.2008.002; Fri, 14 Jun 2019
 18:42:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 1/2] hv_balloon: Use a static page for the balloon_up send
 buffer
Thread-Topic: [PATCH 1/2] hv_balloon: Use a static page for the balloon_up
 send buffer
Thread-Index: AQHVIuDkOmV0qWRnFkKsFEp6e9leVg==
Date:   Fri, 14 Jun 2019 18:42:17 +0000
Message-ID: <1560537692-37400-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14)
 To SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8e44370-a4f1-4b5f-200d-08d6f0f80647
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1056;
x-ms-traffictypediagnostic: SN6PR2101MB1056:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB1056DAC1CACD4E6E6DFE72D4BFEE0@SN6PR2101MB1056.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(66446008)(8936002)(66476007)(256004)(10290500003)(71190400001)(50226002)(305945005)(86362001)(5660300002)(14454004)(73956011)(14444005)(476003)(25786009)(6506007)(6512007)(6116002)(66556008)(3450700001)(64756008)(66946007)(110136005)(54906003)(71200400001)(478600001)(6636002)(10090500001)(102836004)(2616005)(386003)(81156014)(36756003)(81166006)(186003)(6486002)(107886003)(99286004)(316002)(7736002)(2501003)(3846002)(22452003)(1511001)(2906002)(68736007)(66066001)(4720700003)(53936002)(52116002)(6436002)(8676002)(52396003)(43066004)(26005)(486006)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1056;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TjKcaYoR/HOjlAe/OkaP20rkKhT9DIqVDeBItpbacMkUx/7VvEVE1ip9G1Xc8FXCVW3hDu4H2bXZDt4P+VV6PBX9fVpzBCV7sYA0Hi9r3F/bJpkJW8pF6wxtUYgprdDn6pSWdtblqjUisWlGHwd4lPjZqateKt+G3Qv1WFPLW/Cduek8XIqUaWt/fbn+si7Anm3XnR91yUD78OeaSQBMnv6mII7ER6YEOaM/80G1A/L1eVykplSUH/jDvJ8s168hYyAxijJ5OsvHEabFaB+gjX3bmTE77wkPG0LQLp9HTJmP+i9bWqYAUMwSyORfFep+anfVKm+bz81/V+2KGhvGYdProX5pAbEz5Ocuf4SMPyGIPS5HWln4ybSG8lFJ6lyRRxv6uU0mJ+0w76mzn+qwkLFxv/fSGxB055/v9cCeaHM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e44370-a4f1-4b5f-200d-08d6f0f80647
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 18:42:17.2500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmldc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1056
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

SXQncyB1bm5lY2Vzc2FyeSB0byBkeW5hbWljYWxseSBhbGxvY2F0ZSB0aGUgYnVmZmVyLg0KDQpT
aWduZWQtb2ZmLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJp
dmVycy9odi9odl9iYWxsb29uLmMgfCAxOSArKysrLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2h2L2h2X2JhbGxvb24uYyBiL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5jDQppbmRleCBk
ZDQ3NWYzYmNjOGEuLjEzMzgxZWEzZTNlNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaHYvaHZfYmFs
bG9vbi5jDQorKysgYi9kcml2ZXJzL2h2L2h2X2JhbGxvb24uYw0KQEAgLTUwNCw3ICs1MDQsNyBA
QCBlbnVtIGh2X2RtX3N0YXRlIHsNCiANCiANCiBzdGF0aWMgX191OCByZWN2X2J1ZmZlcltQQUdF
X1NJWkVdOw0KLXN0YXRpYyBfX3U4ICpzZW5kX2J1ZmZlcjsNCitzdGF0aWMgX191OCBiYWxsb29u
X3VwX3NlbmRfYnVmZmVyW1BBR0VfU0laRV07DQogI2RlZmluZSBQQUdFU19JTl8yTQk1MTINCiAj
ZGVmaW5lIEhBX0NIVU5LICgzMiAqIDEwMjQpDQogDQpAQCAtMTMwMiw4ICsxMzAyLDggQEAgc3Rh
dGljIHZvaWQgYmFsbG9vbl91cChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKmR1bW15KQ0KIAl9DQogDQog
CXdoaWxlICghZG9uZSkgew0KLQkJYmxfcmVzcCA9IChzdHJ1Y3QgZG1fYmFsbG9vbl9yZXNwb25z
ZSAqKXNlbmRfYnVmZmVyOw0KLQkJbWVtc2V0KHNlbmRfYnVmZmVyLCAwLCBQQUdFX1NJWkUpOw0K
KwkJbWVtc2V0KGJhbGxvb25fdXBfc2VuZF9idWZmZXIsIDAsIFBBR0VfU0laRSk7DQorCQlibF9y
ZXNwID0gKHN0cnVjdCBkbV9iYWxsb29uX3Jlc3BvbnNlICopYmFsbG9vbl91cF9zZW5kX2J1ZmZl
cjsNCiAJCWJsX3Jlc3AtPmhkci50eXBlID0gRE1fQkFMTE9PTl9SRVNQT05TRTsNCiAJCWJsX3Jl
c3AtPmhkci5zaXplID0gc2l6ZW9mKHN0cnVjdCBkbV9iYWxsb29uX3Jlc3BvbnNlKTsNCiAJCWJs
X3Jlc3AtPm1vcmVfcGFnZXMgPSAxOw0KQEAgLTE1ODgsMTkgKzE1ODgsMTEgQEAgc3RhdGljIGlu
dCBiYWxsb29uX3Byb2JlKHN0cnVjdCBodl9kZXZpY2UgKmRldiwNCiAJZG9faG90X2FkZCA9IGZh
bHNlOw0KICNlbmRpZg0KIA0KLQkvKg0KLQkgKiBGaXJzdCBhbGxvY2F0ZSBhIHNlbmQgYnVmZmVy
Lg0KLQkgKi8NCi0NCi0Jc2VuZF9idWZmZXIgPSBrbWFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5F
TCk7DQotCWlmICghc2VuZF9idWZmZXIpDQotCQlyZXR1cm4gLUVOT01FTTsNCi0NCiAJcmV0ID0g
dm1idXNfb3BlbihkZXYtPmNoYW5uZWwsIGRtX3Jpbmdfc2l6ZSwgZG1fcmluZ19zaXplLCBOVUxM
LCAwLA0KIAkJCWJhbGxvb25fb25jaGFubmVsY2FsbGJhY2ssIGRldik7DQogDQogCWlmIChyZXQp
DQotCQlnb3RvIHByb2JlX2Vycm9yMDsNCisJCXJldHVybiByZXQ7DQogDQogCWRtX2RldmljZS5k
ZXYgPSBkZXY7DQogCWRtX2RldmljZS5zdGF0ZSA9IERNX0lOSVRJQUxJWklORzsNCkBAIC0xNzI2
LDggKzE3MTgsNiBAQCBzdGF0aWMgaW50IGJhbGxvb25fcHJvYmUoc3RydWN0IGh2X2RldmljZSAq
ZGV2LA0KIA0KIHByb2JlX2Vycm9yMToNCiAJdm1idXNfY2xvc2UoZGV2LT5jaGFubmVsKTsNCi1w
cm9iZV9lcnJvcjA6DQotCWtmcmVlKHNlbmRfYnVmZmVyKTsNCiAJcmV0dXJuIHJldDsNCiB9DQog
DQpAQCAtMTc0Niw3ICsxNzM2LDYgQEAgc3RhdGljIGludCBiYWxsb29uX3JlbW92ZShzdHJ1Y3Qg
aHZfZGV2aWNlICpkZXYpDQogDQogCXZtYnVzX2Nsb3NlKGRldi0+Y2hhbm5lbCk7DQogCWt0aHJl
YWRfc3RvcChkbS0+dGhyZWFkKTsNCi0Ja2ZyZWUoc2VuZF9idWZmZXIpOw0KICNpZmRlZiBDT05G
SUdfTUVNT1JZX0hPVFBMVUcNCiAJcmVzdG9yZV9vbmxpbmVfcGFnZV9jYWxsYmFjaygmaHZfb25s
aW5lX3BhZ2UpOw0KIAl1bnJlZ2lzdGVyX21lbW9yeV9ub3RpZmllcigmaHZfbWVtb3J5X25iKTsN
Ci0tIA0KMi4xOS4xDQoNCg==
