Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05C446770
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFNSTs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 14:19:48 -0400
Received: from mail-eopbgr710136.outbound.protection.outlook.com ([40.107.71.136]:44189
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfFNSTr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 14:19:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=JKim6Gk3e54uBoMi1zB0p1QrU8S5HlLWGqvIBfwsYk9bp8TLEENa0ekZNi3B8jgeTzUHvUvWNBNvwapRSmVv85LVx9vFNQByDPQjYYYB1juUVYONqS/2KL6bxba9RzN+5L4azgqF2aLQcx7rcRJebs5iUo0XUIlQBxuXi3xnRao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfnSm+uyDSk/87q8SgbHR6zZYTWV63CAj8z/ql0Ki1Y=;
 b=L/tPJDK5YRQOvs3Ge4lknEHDR9JJTG3WfdkwmTOMHdd8N+qq/o+p1d1oAXy0m4dftX0uSJXaQCZWDCIJ9fTIhN8XPcVSODMCc1fDyvO+ZiZHFjPcLRzcFIzUMGqw+PnO1JSYfz4D2TobaLuHTIBBzVL/vCu6gmFK6EpDgMQrvQ0=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfnSm+uyDSk/87q8SgbHR6zZYTWV63CAj8z/ql0Ki1Y=;
 b=JP8YVs6CBdnLeaNQF8uaaP+U6RnuupmaRjQ7zHXMdr8bhULHlqJJAqVx7FjELLPwA4rfcjIqf4xXGgd/QU2mCm4WEU81m6XWAdmS8lWDqKmlw0Wsc/Bwm/r/rBNNlJonBwkGHOcmysnuKrwA+a4Lcioj/0lx4ymauwb+AEXY/wg=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19)
 by SN6PR2101MB1085.namprd21.prod.outlook.com (2603:10b6:805:6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.2; Fri, 14 Jun
 2019 18:19:04 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d8f0:bc1e:20d2:9bf6]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d8f0:bc1e:20d2:9bf6%3]) with mapi id 15.20.2008.002; Fri, 14 Jun 2019
 18:19:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] ACPI: PM: Export the function acpi_sleep_state_supported()
Thread-Topic: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Index: AQHVIt2lUviLbUjfZEmzRslUu7e03g==
Date:   Fri, 14 Jun 2019 18:19:04 +0000
Message-ID: <1560536224-35338-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21)
 To SN6PR2101MB0942.namprd21.prod.outlook.com (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f371868e-e028-41f3-102c-08d6f0f4c807
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1085;
x-ms-traffictypediagnostic: SN6PR2101MB1085:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB10852A5E231210CC27D3D94ABFEE0@SN6PR2101MB1085.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(53936002)(478600001)(2616005)(6512007)(10090500001)(476003)(5660300002)(486006)(14454004)(68736007)(107886003)(4720700003)(50226002)(4326008)(8676002)(6636002)(2501003)(3846002)(6116002)(6486002)(7736002)(305945005)(81156014)(8936002)(81166006)(25786009)(66066001)(7416002)(256004)(14444005)(26005)(71190400001)(10290500003)(6506007)(3450700001)(2906002)(316002)(2201001)(54906003)(110136005)(86362001)(6436002)(22452003)(186003)(1511001)(99286004)(71200400001)(386003)(36756003)(52116002)(52396003)(73956011)(43066004)(66556008)(66476007)(64756008)(66946007)(66446008)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1085;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X5xGRrHxVFUTTUcYUe4+9L1TLAO/JTpBPJcBa/AgsUtILDS18sMFSR54C1K0tsYdY6qoxG8JRKheGyCVnbe1zKLohxnlK2lvXdUTqeYxAzsGjmpAd/6P5bQQyIOOaUiwrM/fuu7TDl8UB+CINEvCmvOj7HJ4gyq0+L6yUi7FcnaH/kUcJ86m0ABA5SbsGN9xez8sa+RIncpO/Jvaq1KDdPnEl8yTI3SPRIYsN7L+GAsjNnWks0daDRSmYiObu+RZGwSoQwAn5XrNE54GAeTTBe4epwOb1eJT13pbozrIjeocYcE+xvnx33Bkv7Jt7k0pFqrMNPe35KG1sdGuIfEhq1td8fvsylHFk7m7L2pnhUlDXty0/zjr58vgoUqORW2bcQa6dKKqsgjYEeorFl2pG2jxKXVrabweY/nluvhCTHg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f371868e-e028-41f3-102c-08d6f0f4c807
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 18:19:04.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmldc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1085
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

SW4gYSBMaW51eCBWTSBydW5uaW5nIG9uIEh5cGVyLVYsIHdoZW4gQUNQSSBTNCBpcyBlbmFibGVk
LCB0aGUgYmFsbG9vbg0KZHJpdmVyIChkcml2ZXJzL2h2L2h2X2JhbGxvb24uYykgbmVlZHMgdG8g
YXNrIHRoZSBob3N0IG5vdCB0byBkbyBtZW1vcnkNCmhvdC1hZGQvcmVtb3ZlLg0KDQpTbyBsZXQn
cyBleHBvcnQgYWNwaV9zbGVlcF9zdGF0ZV9zdXBwb3J0ZWQoKSBmb3IgdGhlIGh2X2JhbGxvb24g
ZHJpdmVyLg0KVGhpcyBtaWdodCBhbHNvIGJlIHVzZWZ1bCB0byB0aGUgb3RoZXIgZHJpdmVycyBp
biB0aGUgZnV0dXJlLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3Nv
ZnQuY29tPg0KLS0tDQogZHJpdmVycy9hY3BpL3NsZWVwLmMgICAgfCAzICsrLQ0KIGluY2x1ZGUv
YWNwaS9hY3BpX2J1cy5oIHwgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvc2xlZXAuYyBiL2Ry
aXZlcnMvYWNwaS9zbGVlcC5jDQppbmRleCBhMzRkZWNjZDczMTcuLjY5NzU1NDExZTAwOCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvYWNwaS9zbGVlcC5jDQorKysgYi9kcml2ZXJzL2FjcGkvc2xlZXAu
Yw0KQEAgLTc5LDcgKzc5LDcgQEAgc3RhdGljIGludCBhY3BpX3NsZWVwX3ByZXBhcmUodTMyIGFj
cGlfc3RhdGUpDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMgYm9vbCBhY3BpX3NsZWVwX3N0
YXRlX3N1cHBvcnRlZCh1OCBzbGVlcF9zdGF0ZSkNCitib29sIGFjcGlfc2xlZXBfc3RhdGVfc3Vw
cG9ydGVkKHU4IHNsZWVwX3N0YXRlKQ0KIHsNCiAJYWNwaV9zdGF0dXMgc3RhdHVzOw0KIAl1OCB0
eXBlX2EsIHR5cGVfYjsNCkBAIC04OSw2ICs4OSw3IEBAIHN0YXRpYyBib29sIGFjcGlfc2xlZXBf
c3RhdGVfc3VwcG9ydGVkKHU4IHNsZWVwX3N0YXRlKQ0KIAkJfHwgKGFjcGlfZ2JsX0ZBRFQuc2xl
ZXBfY29udHJvbC5hZGRyZXNzDQogCQkJJiYgYWNwaV9nYmxfRkFEVC5zbGVlcF9zdGF0dXMuYWRk
cmVzcykpOw0KIH0NCitFWFBPUlRfU1lNQk9MX0dQTChhY3BpX3NsZWVwX3N0YXRlX3N1cHBvcnRl
ZCk7DQogDQogI2lmZGVmIENPTkZJR19BQ1BJX1NMRUVQDQogc3RhdGljIHUzMiBhY3BpX3Rhcmdl
dF9zbGVlcF9zdGF0ZSA9IEFDUElfU1RBVEVfUzA7DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY3Bp
L2FjcGlfYnVzLmggYi9pbmNsdWRlL2FjcGkvYWNwaV9idXMuaA0KaW5kZXggMzFiNmM4N2Q2MjQw
Li41YjEwMmU3YmJmMjUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2FjcGkvYWNwaV9idXMuaA0KKysr
IGIvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgNCkBAIC02NTEsNiArNjUxLDggQEAgc3RhdGljIGlu
bGluZSBpbnQgYWNwaV9wbV9zZXRfYnJpZGdlX3dha2V1cChzdHJ1Y3QgZGV2aWNlICpkZXYsIGJv
b2wgZW5hYmxlKQ0KIH0NCiAjZW5kaWYNCiANCitib29sIGFjcGlfc2xlZXBfc3RhdGVfc3VwcG9y
dGVkKHU4IHNsZWVwX3N0YXRlKTsNCisNCiAjaWZkZWYgQ09ORklHX0FDUElfU0xFRVANCiB1MzIg
YWNwaV90YXJnZXRfc3lzdGVtX3N0YXRlKHZvaWQpOw0KICNlbHNlDQotLSANCjIuMTkuMQ0KDQo=
