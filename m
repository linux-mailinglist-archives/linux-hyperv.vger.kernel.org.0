Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3940C467B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFNSmh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 14:42:37 -0400
Received: from mail-eopbgr700108.outbound.protection.outlook.com ([40.107.70.108]:34944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfFNSmh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 14:42:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=pDMyphXviXTMC8Fgvv7/M5TJcHYmei0cD7dwBqpwCf0/bpGPoRXfXj+Bq+t3VsoQgmVaG1/61Cv1e51uM/uSL/hQj9NFksQWwBe6NwlpY/YJppaADjSoXuka2x9Lcu+ImCo4zjZVRXzJawjEXjGjwXmyC/wY+X5dM0kSzSwCop4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQwAwWZkrhhmfnkBohe54zAymyIHql0usuBRu16rX8s=;
 b=lZQNeQkSXRHxbd982nsEe/3tj9fI2OmIdbYQn7wuB+8as8LoUArSEBxQDE1LYGe7wbkl9I2Ssyu0RerJ4IWyky4kSlSMNXi4cxCiwlReGahcpBuNchovKgc5G8JHS33QYrjKKLc72fRL0u3nmfiLb0X4VpfU01qmmcD+OZ0jqnw=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQwAwWZkrhhmfnkBohe54zAymyIHql0usuBRu16rX8s=;
 b=IdGJ/3c5+h4/OSq2nCSYatNe1w0SFaIINgmT3EGWt2v5VClSdGYfa0NGMZdLdcp6zX/N8S2LGJ7J+pjYezsJ8niSTtEH8AxQbRxC67117T0Np8spsY/m2N5FmH/EH6g4Vh5qU/x4w45N02WUhA7tECwD/jPPLfwvjDVRmlfsXkM=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19)
 by SN6PR2101MB1056.namprd21.prod.outlook.com (2603:10b6:805:6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.2; Fri, 14 Jun
 2019 18:42:30 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d8f0:bc1e:20d2:9bf6]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d8f0:bc1e:20d2:9bf6%3]) with mapi id 15.20.2008.002; Fri, 14 Jun 2019
 18:42:30 +0000
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
Subject: [PATCH 2/2] hv_balloon: Reorganize the probe function
Thread-Topic: [PATCH 2/2] hv_balloon: Reorganize the probe function
Thread-Index: AQHVIuDrNYUlem/dBUyF1q61Womn+g==
Date:   Fri, 14 Jun 2019 18:42:30 +0000
Message-ID: <1560537692-37400-2-git-send-email-decui@microsoft.com>
References: <1560537692-37400-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1560537692-37400-1-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: a7ecb8f3-9b9b-4a37-5c29-08d6f0f80dfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1056;
x-ms-traffictypediagnostic: SN6PR2101MB1056:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB1056A1F580A91A01EBC7EBE4BFEE0@SN6PR2101MB1056.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(446003)(66446008)(8936002)(66476007)(256004)(10290500003)(71190400001)(50226002)(305945005)(86362001)(5660300002)(14454004)(73956011)(14444005)(476003)(25786009)(6506007)(6512007)(6116002)(66556008)(3450700001)(64756008)(66946007)(110136005)(54906003)(71200400001)(76176011)(478600001)(6636002)(10090500001)(102836004)(2616005)(386003)(81156014)(36756003)(81166006)(186003)(6486002)(107886003)(99286004)(316002)(7736002)(2501003)(3846002)(22452003)(1511001)(2906002)(68736007)(66066001)(4720700003)(53936002)(52116002)(6436002)(8676002)(52396003)(43066004)(11346002)(26005)(486006)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1056;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wz6WFawMLpAGkSs7RlmAo9v3uiPZj2EihS18j1kgMF+jji5U/L5b6Uvh2wjfBcB5Y5oHDoWVvsd7htZgeTnqZlP1GTfC+ArUcZci++rYeGjcazRTd/dYMlHO7MjFsnoNN2WtQSry6Cms8/khrasauoX+U2Ok7r6WOcmdSJ4OB2aUbdCdCeJu8TCH7MV9uclvR5pAzl46Gse7fvj7eJV2t3dP3JOK+cwtWWIuiP1DS2vdiOSh90YviXyN4DJ6DUoWw/UO5g/HRLsGMtsME+8R0/cmPN0jA7Rn2qrU88ZGILqvE+FJ3G8aJOQKLkIigx8kdKmQ2N9cOrJAxQzQQBQj4MnjEAOZdSXgY0UiU9mpOdRFrfmO1UThnwGNZpmhmzZg1wB7qgzMN9rJpjBvZLdovRmLOFFuaJ2BWsak92FrvDY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ecb8f3-9b9b-4a37-5c29-08d6f0f80dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 18:42:30.0704
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

TW92ZSB0aGUgY29kZSB0aGF0IG5lZ290aWF0ZXMgd2l0aCB0aGUgaG9zdCB0byBhIG5ldyBmdW5j
dGlvbg0KYmFsbG9vbl9jb25uZWN0X3ZzcCgpIGFuZCBpbXByb3ZlIHRoZSBlcnJvciBoYW5kbGlu
Zy4NCg0KVGhpcyBtYWtlcyB0aGUgY29kZSBtb3JlIHJlYWRhYmxlIGFuZCBwYXZlcyB0aGUgd2F5
IGZvciB0aGUNCnN1cHBvcnQgb2YgaGliZXJuYXRpb24gaW4gZnV0dXJlLg0KDQpNYWtlcyBubyBy
ZWFsIGxvZ2ljIGNoYW5nZSBoZXJlLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1
aUBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9odi9odl9iYWxsb29uLmMgfCAxMjQgKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2
NiBpbnNlcnRpb25zKCspLCA1OCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aHYvaHZfYmFsbG9vbi5jIGIvZHJpdmVycy9odi9odl9iYWxsb29uLmMNCmluZGV4IDEzMzgxZWEz
ZTNlNy4uMTExZWEzNTk5NjU5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9odi9odl9iYWxsb29uLmMN
CisrKyBiL2RyaXZlcnMvaHYvaHZfYmFsbG9vbi5jDQpAQCAtMTU3NCw1MCArMTU3NCwxOCBAQCBz
dGF0aWMgdm9pZCBiYWxsb29uX29uY2hhbm5lbGNhbGxiYWNrKHZvaWQgKmNvbnRleHQpDQogDQog
fQ0KIA0KLXN0YXRpYyBpbnQgYmFsbG9vbl9wcm9iZShzdHJ1Y3QgaHZfZGV2aWNlICpkZXYsDQot
CQkJY29uc3Qgc3RydWN0IGh2X3ZtYnVzX2RldmljZV9pZCAqZGV2X2lkKQ0KK3N0YXRpYyBpbnQg
YmFsbG9vbl9jb25uZWN0X3ZzcChzdHJ1Y3QgaHZfZGV2aWNlICpkZXYpDQogew0KLQlpbnQgcmV0
Ow0KLQl1bnNpZ25lZCBsb25nIHQ7DQogCXN0cnVjdCBkbV92ZXJzaW9uX3JlcXVlc3QgdmVyc2lv
bl9yZXE7DQogCXN0cnVjdCBkbV9jYXBhYmlsaXRpZXMgY2FwX21zZzsNCi0NCi0jaWZkZWYgQ09O
RklHX01FTU9SWV9IT1RQTFVHDQotCWRvX2hvdF9hZGQgPSBob3RfYWRkOw0KLSNlbHNlDQotCWRv
X2hvdF9hZGQgPSBmYWxzZTsNCi0jZW5kaWYNCisJdW5zaWduZWQgbG9uZyB0Ow0KKwlpbnQgcmV0
Ow0KIA0KIAlyZXQgPSB2bWJ1c19vcGVuKGRldi0+Y2hhbm5lbCwgZG1fcmluZ19zaXplLCBkbV9y
aW5nX3NpemUsIE5VTEwsIDAsDQotCQkJYmFsbG9vbl9vbmNoYW5uZWxjYWxsYmFjaywgZGV2KTsN
Ci0NCisJCQkgYmFsbG9vbl9vbmNoYW5uZWxjYWxsYmFjaywgZGV2KTsNCiAJaWYgKHJldCkNCiAJ
CXJldHVybiByZXQ7DQogDQotCWRtX2RldmljZS5kZXYgPSBkZXY7DQotCWRtX2RldmljZS5zdGF0
ZSA9IERNX0lOSVRJQUxJWklORzsNCi0JZG1fZGV2aWNlLm5leHRfdmVyc2lvbiA9IERZTk1FTV9Q
Uk9UT0NPTF9WRVJTSU9OX1dJTjg7DQotCWluaXRfY29tcGxldGlvbigmZG1fZGV2aWNlLmhvc3Rf
ZXZlbnQpOw0KLQlpbml0X2NvbXBsZXRpb24oJmRtX2RldmljZS5jb25maWdfZXZlbnQpOw0KLQlJ
TklUX0xJU1RfSEVBRCgmZG1fZGV2aWNlLmhhX3JlZ2lvbl9saXN0KTsNCi0Jc3Bpbl9sb2NrX2lu
aXQoJmRtX2RldmljZS5oYV9sb2NrKTsNCi0JSU5JVF9XT1JLKCZkbV9kZXZpY2UuYmFsbG9vbl93
cmsud3JrLCBiYWxsb29uX3VwKTsNCi0JSU5JVF9XT1JLKCZkbV9kZXZpY2UuaGFfd3JrLndyaywg
aG90X2FkZF9yZXEpOw0KLQlkbV9kZXZpY2UuaG9zdF9zcGVjaWZpZWRfaGFfcmVnaW9uID0gZmFs
c2U7DQotDQotCWRtX2RldmljZS50aHJlYWQgPQ0KLQkJIGt0aHJlYWRfcnVuKGRtX3RocmVhZF9m
dW5jLCAmZG1fZGV2aWNlLCAiaHZfYmFsbG9vbiIpOw0KLQlpZiAoSVNfRVJSKGRtX2RldmljZS50
aHJlYWQpKSB7DQotCQlyZXQgPSBQVFJfRVJSKGRtX2RldmljZS50aHJlYWQpOw0KLQkJZ290byBw
cm9iZV9lcnJvcjE7DQotCX0NCi0NCi0jaWZkZWYgQ09ORklHX01FTU9SWV9IT1RQTFVHDQotCXNl
dF9vbmxpbmVfcGFnZV9jYWxsYmFjaygmaHZfb25saW5lX3BhZ2UpOw0KLQlyZWdpc3Rlcl9tZW1v
cnlfbm90aWZpZXIoJmh2X21lbW9yeV9uYik7DQotI2VuZGlmDQotDQotCWh2X3NldF9kcnZkYXRh
KGRldiwgJmRtX2RldmljZSk7DQogCS8qDQogCSAqIEluaXRpYXRlIHRoZSBoYW5kIHNoYWtlIHdp
dGggdGhlIGhvc3QgYW5kIG5lZ290aWF0ZQ0KIAkgKiBhIHZlcnNpb24gdGhhdCB0aGUgaG9zdCBj
YW4gc3VwcG9ydC4gV2Ugc3RhcnQgd2l0aCB0aGUNCkBAIC0xNjMzLDE2ICsxNjAxLDE1IEBAIHN0
YXRpYyBpbnQgYmFsbG9vbl9wcm9iZShzdHJ1Y3QgaHZfZGV2aWNlICpkZXYsDQogCWRtX2Rldmlj
ZS52ZXJzaW9uID0gdmVyc2lvbl9yZXEudmVyc2lvbi52ZXJzaW9uOw0KIA0KIAlyZXQgPSB2bWJ1
c19zZW5kcGFja2V0KGRldi0+Y2hhbm5lbCwgJnZlcnNpb25fcmVxLA0KLQkJCQlzaXplb2Yoc3Ry
dWN0IGRtX3ZlcnNpb25fcmVxdWVzdCksDQotCQkJCSh1bnNpZ25lZCBsb25nKU5VTEwsDQotCQkJ
CVZNX1BLVF9EQVRBX0lOQkFORCwgMCk7DQorCQkJICAgICAgIHNpemVvZihzdHJ1Y3QgZG1fdmVy
c2lvbl9yZXF1ZXN0KSwNCisJCQkgICAgICAgKHVuc2lnbmVkIGxvbmcpTlVMTCwgVk1fUEtUX0RB
VEFfSU5CQU5ELCAwKTsNCiAJaWYgKHJldCkNCi0JCWdvdG8gcHJvYmVfZXJyb3IyOw0KKwkJZ290
byBvdXQ7DQogDQogCXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmRtX2RldmljZS5o
b3N0X2V2ZW50LCA1KkhaKTsNCiAJaWYgKHQgPT0gMCkgew0KIAkJcmV0ID0gLUVUSU1FRE9VVDsN
Ci0JCWdvdG8gcHJvYmVfZXJyb3IyOw0KKwkJZ290byBvdXQ7DQogCX0NCiANCiAJLyoNCkBAIC0x
NjUwLDggKzE2MTcsOCBAQCBzdGF0aWMgaW50IGJhbGxvb25fcHJvYmUoc3RydWN0IGh2X2Rldmlj
ZSAqZGV2LA0KIAkgKiBmYWlsIHRoZSBwcm9iZSBmdW5jdGlvbi4NCiAJICovDQogCWlmIChkbV9k
ZXZpY2Uuc3RhdGUgPT0gRE1fSU5JVF9FUlJPUikgew0KLQkJcmV0ID0gLUVUSU1FRE9VVDsNCi0J
CWdvdG8gcHJvYmVfZXJyb3IyOw0KKwkJcmV0ID0gLUVQUk9UTzsNCisJCWdvdG8gb3V0Ow0KIAl9
DQogDQogCXByX2luZm8oIlVzaW5nIER5bmFtaWMgTWVtb3J5IHByb3RvY29sIHZlcnNpb24gJXUu
JXVcbiIsDQpAQCAtMTY4NCwxNiArMTY1MSwxNSBAQCBzdGF0aWMgaW50IGJhbGxvb25fcHJvYmUo
c3RydWN0IGh2X2RldmljZSAqZGV2LA0KIAljYXBfbXNnLm1heF9wYWdlX251bWJlciA9IC0xOw0K
IA0KIAlyZXQgPSB2bWJ1c19zZW5kcGFja2V0KGRldi0+Y2hhbm5lbCwgJmNhcF9tc2csDQotCQkJ
CXNpemVvZihzdHJ1Y3QgZG1fY2FwYWJpbGl0aWVzKSwNCi0JCQkJKHVuc2lnbmVkIGxvbmcpTlVM
TCwNCi0JCQkJVk1fUEtUX0RBVEFfSU5CQU5ELCAwKTsNCisJCQkgICAgICAgc2l6ZW9mKHN0cnVj
dCBkbV9jYXBhYmlsaXRpZXMpLA0KKwkJCSAgICAgICAodW5zaWduZWQgbG9uZylOVUxMLCBWTV9Q
S1RfREFUQV9JTkJBTkQsIDApOw0KIAlpZiAocmV0KQ0KLQkJZ290byBwcm9iZV9lcnJvcjI7DQor
CQlnb3RvIG91dDsNCiANCiAJdCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZG1fZGV2
aWNlLmhvc3RfZXZlbnQsIDUqSFopOw0KIAlpZiAodCA9PSAwKSB7DQogCQlyZXQgPSAtRVRJTUVE
T1VUOw0KLQkJZ290byBwcm9iZV9lcnJvcjI7DQorCQlnb3RvIG91dDsNCiAJfQ0KIA0KIAkvKg0K
QEAgLTE3MDEsMjMgKzE2NjcsNjUgQEAgc3RhdGljIGludCBiYWxsb29uX3Byb2JlKHN0cnVjdCBo
dl9kZXZpY2UgKmRldiwNCiAJICogZmFpbCB0aGUgcHJvYmUgZnVuY3Rpb24uDQogCSAqLw0KIAlp
ZiAoZG1fZGV2aWNlLnN0YXRlID09IERNX0lOSVRfRVJST1IpIHsNCi0JCXJldCA9IC1FVElNRURP
VVQ7DQotCQlnb3RvIHByb2JlX2Vycm9yMjsNCisJCXJldCA9IC1FUFJPVE87DQorCQlnb3RvIG91
dDsNCiAJfQ0KIA0KKwlyZXR1cm4gMDsNCitvdXQ6DQorCXZtYnVzX2Nsb3NlKGRldi0+Y2hhbm5l
bCk7DQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRpYyBpbnQgYmFsbG9vbl9wcm9iZShzdHJ1
Y3QgaHZfZGV2aWNlICpkZXYsDQorCQkJIGNvbnN0IHN0cnVjdCBodl92bWJ1c19kZXZpY2VfaWQg
KmRldl9pZCkNCit7DQorCWludCByZXQ7DQorDQorI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExV
Rw0KKwlkb19ob3RfYWRkID0gaG90X2FkZDsNCisjZWxzZQ0KKwlkb19ob3RfYWRkID0gZmFsc2U7
DQorI2VuZGlmDQorCWRtX2RldmljZS5kZXYgPSBkZXY7DQorCWRtX2RldmljZS5zdGF0ZSA9IERN
X0lOSVRJQUxJWklORzsNCisJZG1fZGV2aWNlLm5leHRfdmVyc2lvbiA9IERZTk1FTV9QUk9UT0NP
TF9WRVJTSU9OX1dJTjg7DQorCWluaXRfY29tcGxldGlvbigmZG1fZGV2aWNlLmhvc3RfZXZlbnQp
Ow0KKwlpbml0X2NvbXBsZXRpb24oJmRtX2RldmljZS5jb25maWdfZXZlbnQpOw0KKwlJTklUX0xJ
U1RfSEVBRCgmZG1fZGV2aWNlLmhhX3JlZ2lvbl9saXN0KTsNCisJc3Bpbl9sb2NrX2luaXQoJmRt
X2RldmljZS5oYV9sb2NrKTsNCisJSU5JVF9XT1JLKCZkbV9kZXZpY2UuYmFsbG9vbl93cmsud3Jr
LCBiYWxsb29uX3VwKTsNCisJSU5JVF9XT1JLKCZkbV9kZXZpY2UuaGFfd3JrLndyaywgaG90X2Fk
ZF9yZXEpOw0KKwlkbV9kZXZpY2UuaG9zdF9zcGVjaWZpZWRfaGFfcmVnaW9uID0gZmFsc2U7DQor
DQorI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExVRw0KKwlzZXRfb25saW5lX3BhZ2VfY2FsbGJh
Y2soJmh2X29ubGluZV9wYWdlKTsNCisJcmVnaXN0ZXJfbWVtb3J5X25vdGlmaWVyKCZodl9tZW1v
cnlfbmIpOw0KKyNlbmRpZg0KKw0KKwlodl9zZXRfZHJ2ZGF0YShkZXYsICZkbV9kZXZpY2UpOw0K
Kw0KKwlyZXQgPSBiYWxsb29uX2Nvbm5lY3RfdnNwKGRldik7DQorCWlmIChyZXQgIT0gMCkNCisJ
CXJldHVybiByZXQ7DQorDQogCWRtX2RldmljZS5zdGF0ZSA9IERNX0lOSVRJQUxJWkVEOw0KLQls
YXN0X3Bvc3RfdGltZSA9IGppZmZpZXM7DQorDQorCWRtX2RldmljZS50aHJlYWQgPQ0KKwkJIGt0
aHJlYWRfcnVuKGRtX3RocmVhZF9mdW5jLCAmZG1fZGV2aWNlLCAiaHZfYmFsbG9vbiIpOw0KKwlp
ZiAoSVNfRVJSKGRtX2RldmljZS50aHJlYWQpKSB7DQorCQlyZXQgPSBQVFJfRVJSKGRtX2Rldmlj
ZS50aHJlYWQpOw0KKwkJZ290byBwcm9iZV9lcnJvcjsNCisJfQ0KIA0KIAlyZXR1cm4gMDsNCiAN
Ci1wcm9iZV9lcnJvcjI6DQorcHJvYmVfZXJyb3I6DQorCXZtYnVzX2Nsb3NlKGRldi0+Y2hhbm5l
bCk7DQogI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExVRw0KKwl1bnJlZ2lzdGVyX21lbW9yeV9u
b3RpZmllcigmaHZfbWVtb3J5X25iKTsNCiAJcmVzdG9yZV9vbmxpbmVfcGFnZV9jYWxsYmFjaygm
aHZfb25saW5lX3BhZ2UpOw0KICNlbmRpZg0KLQlrdGhyZWFkX3N0b3AoZG1fZGV2aWNlLnRocmVh
ZCk7DQotDQotcHJvYmVfZXJyb3IxOg0KLQl2bWJ1c19jbG9zZShkZXYtPmNoYW5uZWwpOw0KIAly
ZXR1cm4gcmV0Ow0KIH0NCiANCkBAIC0xNzM0LDExICsxNzQyLDExIEBAIHN0YXRpYyBpbnQgYmFs
bG9vbl9yZW1vdmUoc3RydWN0IGh2X2RldmljZSAqZGV2KQ0KIAljYW5jZWxfd29ya19zeW5jKCZk
bS0+YmFsbG9vbl93cmsud3JrKTsNCiAJY2FuY2VsX3dvcmtfc3luYygmZG0tPmhhX3dyay53cmsp
Ow0KIA0KLQl2bWJ1c19jbG9zZShkZXYtPmNoYW5uZWwpOw0KIAlrdGhyZWFkX3N0b3AoZG0tPnRo
cmVhZCk7DQorCXZtYnVzX2Nsb3NlKGRldi0+Y2hhbm5lbCk7DQogI2lmZGVmIENPTkZJR19NRU1P
UllfSE9UUExVRw0KLQlyZXN0b3JlX29ubGluZV9wYWdlX2NhbGxiYWNrKCZodl9vbmxpbmVfcGFn
ZSk7DQogCXVucmVnaXN0ZXJfbWVtb3J5X25vdGlmaWVyKCZodl9tZW1vcnlfbmIpOw0KKwlyZXN0
b3JlX29ubGluZV9wYWdlX2NhbGxiYWNrKCZodl9vbmxpbmVfcGFnZSk7DQogI2VuZGlmDQogCXNw
aW5fbG9ja19pcnFzYXZlKCZkbV9kZXZpY2UuaGFfbG9jaywgZmxhZ3MpOw0KIAlsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmUoaGFzLCB0bXAsICZkbS0+aGFfcmVnaW9uX2xpc3QsIGxpc3QpIHsNCi0t
IA0KMi4xOS4xDQoNCg==
