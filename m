Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D262B7FF
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 May 2019 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfE0O7L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 May 2019 10:59:11 -0400
Received: from mail-eopbgr690108.outbound.protection.outlook.com ([40.107.69.108]:9750
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfE0O7L (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 May 2019 10:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=K7bk6mjGHdPEs9sk/AJliDTjXH3m7JXEhGjnRoesizLWVs/qPtjN6GUum+ckfFZCylDtW6lbboZ4F8Kq2EDGkbksjD99MxI1q13vFb2Yd6/LzXJtc0IImkgHQ64wDVjXbnDWk9MTlZCsOOav6saREntxhokrlZXEUFpGfdyRYzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx1McZV10Dbv50irNymIpxFfBXCU9xkf8rQKB2clnuw=;
 b=vzqb+9xlp9VLtz7qWvq9OP8bqpSIpyMiipnuqST+e7/04pV6gjwdYKPdy6c3gKx9H0v+LTYACVITTAqmOIHagjUBjGmVK8WMp82BEtvi6i7CX3fwTOHyMkU3B/t6Eg2YW7D/sa7sp+K6dXA+4FhveDZ3b3dNdlgmBEJE85lfp1g=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none
 action=none header.from=microsoft.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx1McZV10Dbv50irNymIpxFfBXCU9xkf8rQKB2clnuw=;
 b=g7AG4hW+cx4OLFS4fu22qFJspCKsIcPvak5ZJeoDV3gNgeSQknJMtfnRytymiEEAJajU8Cc0JbL7Ikrj0BjWCHxdl1TwhSElngTZmzxP+oXoLQwfDJ0+q1nbx2mcjnfhb15TRgtdSPGRQY6vvq1QWJbdb7VGULDaVzjR9ynmMq4=
Received: from DM6PR21MB1340.namprd21.prod.outlook.com (2603:10b6:5:175::19)
 by DM6PR21MB1339.namprd21.prod.outlook.com (2603:10b6:5:175::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.9; Mon, 27 May
 2019 14:59:07 +0000
Received: from DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::5057:9e3c:bcc5:9470]) by DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::5057:9e3c:bcc5:9470%3]) with mapi id 15.20.1943.006; Mon, 27 May 2019
 14:59:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: [PATCH v3 0/2] Drivers: hv: Move Hyper-V clock/timer code to separate
 clocksource driver
Thread-Topic: [PATCH v3 0/2] Drivers: hv: Move Hyper-V clock/timer code to
 separate clocksource driver
Thread-Index: AQHVFJy7sYXmZFrIlU+IOwEBipERmQ==
Date:   Mon, 27 May 2019 14:59:07 +0000
Message-ID: <1558969089-13204-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To DM6PR21MB1340.namprd21.prod.outlook.com
 (2603:10b6:5:175::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [167.220.2.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08501eb8-cf98-4489-1bb8-08d6e2b3ddd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1339;
x-ms-traffictypediagnostic: DM6PR21MB1339:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1339947EECA183DFC1B9CE89D71D0@DM6PR21MB1339.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(52116002)(7416002)(52396003)(64756008)(81166006)(14454004)(99286004)(6512007)(6436002)(2616005)(6636002)(71190400001)(256004)(53936002)(71200400001)(476003)(26005)(73956011)(66476007)(66446008)(6486002)(68736007)(8936002)(4720700003)(478600001)(1511001)(7736002)(66946007)(386003)(66066001)(66556008)(2501003)(2201001)(50226002)(54906003)(102836004)(22452003)(81156014)(305945005)(486006)(10090500001)(8676002)(186003)(316002)(25786009)(14444005)(3846002)(36756003)(4326008)(10290500003)(5660300002)(86362001)(110136005)(6116002)(86612001)(6506007)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1339;H:DM6PR21MB1340.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IG8cHeuFOe9Ty+IxWia9UPO0WOEupln0lvINV3Rs9K8AUzTUpQUknvmCEUm8j0Ee0iWEbAab/xbsmnqcL4kHe8xrN/rrDJ4j/obvVBOIyUFqY6tfbJOSppVjWSa6LryIBjeKjWHq1OL7H3oKE1u6boElIXGL18jMhCjiOOvnzgXoJGAxg4nu0j8B/tqovLX0R02le4HcEJNICZAuIYbBFheFaDVPVZMo5fVHA1lwfmcJEvH767fxH0SWpaSXHz0Q8nm1ku76xyL4OK9KDj38f0YsFr0bbJqSxNV3daQwdqOcLyVZR7wOxR/R4kbE9CVbwQMATN30qjZa4O43KXUIy71hzGDhKK6XdRgPRIOJTWlUIG2CkVpQrM2H4LP1csjPO4Wvd+vPpiPQyMolH+LY6aSgLvW+tcxzav0mOi+l73Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08501eb8-cf98-4489-1bb8-08d6e2b3ddd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 14:59:07.1266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1339
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgbW92ZXMgSHlwZXItViBjbG9jay90aW1lciBjb2RlIHRvIGEgc2Vw
YXJhdGUgSHlwZXItVg0KY2xvY2tzb3VyY2UgZHJpdmVyLiBQcmV2aW91c2x5LCBIeXBlci1WIGNs
b2NrL3RpbWVyIGNvZGUgYW5kIGRhdGENCnN0cnVjdHVyZXMgd2VyZSBtaXhlZCBpbiB3aXRoIG90
aGVyIEh5cGVyLVYgY29kZSBpbiB0aGUgSVNBIGluZGVwZW5kZW50DQpkcml2ZXJzL2h2IGNvZGUg
YXMgd2VsbCBhcyBpbiBhcmNoIGRlcGVuZGVudCBjb2RlLiBUaGUgbmV3IEh5cGVyLVYNCmNsb2Nr
c291cmNlIGRyaXZlciBpcyBJU0EgaW5kZXBlbmRlbnQsIHdpdGggYSBqdXN0IGZldyBkZXBlbmRl
bmNpZXMgb24NCmFyY2ggc3BlY2lmaWMgZnVuY3Rpb25zLiBUaGUgcGF0Y2ggc2VyaWVzIGRvZXMg
bm90IGNoYW5nZSBhbnkgYmVoYXZpb3INCm9yIGZ1bmN0aW9uYWxpdHkgLS0gaXQgb25seSByZW9y
Z2FuaXplcyB0aGUgZXhpc3RpbmcgY29kZSBhbmQgZml4ZXMgdXANCnRoZSBsaW5rYWdlcy4gQSBm
ZXcgcGxhY2VzIG91dHNpZGUgb2YgSHlwZXItViBjb2RlIGFyZSBmaXhlZCB1cCB0byB1c2UNCnRo
ZSBuZXcgI2luY2x1ZGUgZmlsZSBzdHJ1Y3R1cmUuDQoNClRoaXMgcmVzdHJ1Y3R1cmluZyBpcyBp
biByZXNwb25zZSB0byBNYXJjIFp5bmdpZXIncyByZXZpZXcgY29tbWVudHMNCm9uIHN1cHBvcnRp
bmcgSHlwZXItViBydW5uaW5nIG9uIEFSTTY0LCBhbmQgaXMgYSBnb29kIGlkZWEgaW4gZ2VuZXJh
bC4NCkl0IGluY3JlYXNlcyB0aGUgYW1vdW50IG9mIGNvZGUgc2hhcmVkIGJldHdlZW4gdGhlIHg4
NiBhbmQgQVJNNjQNCmFyY2hpdGVjdHVyZXMsIGFuZCByZWR1Y2VzIHRoZSBzaXplIG9mIHRoZSBu
ZXcgY29kZSBmb3Igc3VwcG9ydGluZw0KSHlwZXItViBvbiBBUk02NC4gQSBuZXcgdmVyc2lvbiBv
ZiB0aGUgSHlwZXItViBvbiBBUk02NCBwYXRjaGVzIHdpbGwNCmZvbGxvdyBvbmNlIHRoaXMgY2xv
Y2tzb3VyY2UgcmVzdHJ1Y3R1cmluZyBpcyBhY2NlcHRlZC4NCg0KVGhlIGNvZGUgaXMgZGlmZidl
ZCBhZ2FpbnN0IExpbnV4IDUuMi4wLXJjMS1uZXh0LTIwMTkwNTI0Lg0KDQpDaGFuZ2VzIGluIHYz
Og0KKiBSZW1vdmVkIGJvb2xlYW4gYXJndW1lbnQgdG8gaHZfaW5pdF9jbG9ja3NvdXJjZSgpLiBB
bHdheXMgY2FsbA0Kc2NoZWRfY2xvY2tfcmVnaXN0ZXIsIHdoaWNoIGlzIG5lZWRlZCBvbiBBUk02
NCBidXQgYSBuby1vcCBvbiB4ODYuDQoqIFJlbW92ZWQgc2VwYXJhdGUgY3B1aHAgc2V0dXAgaW4g
aHZfc3RpbWVyX2FsbG9jKCkgYW5kIGluc3RlYWQNCmRpcmVjdGx5IGNhbGwgaHZfc3RpbWVyX2lu
aXQoKSBhbmQgaHZfc3RpbWVyX2NsZWFudXAoKSBmcm9tDQpjb3JyZXNwb25kaW5nIFZNYnVzIGZ1
bmN0aW9ucy4gIFRoaXMgbW9yZSBjbG9zZWx5IG1hdGNoZXMgb3JpZ2luYWwNCmNvZGUgYW5kIGF2
b2lkcyBjbG9ja3NvdXJjZSBzdG9wL3Jlc3RhcnQgcHJvYmxlbXMgb24gQVJNNjQgd2hlbg0KVk1i
dXMgY29kZSBkZW5pZXMgQ1BVIG9mZmxpbmluZyByZXF1ZXN0Lg0KDQpDaGFuZ2VzIGluIHYyOg0K
KiBSZXZpc2VkIGNvbW1pdCBzaG9ydCBkZXNjcmlwdGlvbnMgc28gdGhlIGRpc3RpbmN0aW9uIGJl
dHdlZW4NCnRoZSBmaXJzdCBhbmQgc2Vjb25kIHBhdGNoZXMgaXMgY2xlYXJlciBbR3JlZ0tIXQ0K
KiBSZW5hbWVkIG5ldyBjbG9ja3NvdXJjZSBkcml2ZXIgZmlsZXMgYW5kIGZ1bmN0aW9ucyB0byB1
c2UNCmV4aXN0aW5nICJ0aW1lciIgYW5kICJzdGltZXIiIG5hbWVzIGluc3RlYWQgb2YgaW50cm9k
dWNpbmcNCiJzeW50aW1lciIuIFtWaXRhbHkgS3V6bmV0c292XQ0KKiBJbnRyb2R1Y2VkIENPTkZJ
R19IWVBFUl9USU1FUiB0byBmaXggYnVpbGQgcHJvYmxlbSB3aGVuDQpDT05GSUdfSFlQRVJWPW0g
W1ZpdGFseSBLdXpuZXRzb3ZdDQoqIEFkZGVkICJTdWdnZXN0ZWQtYnk6IE1hcmMgWnluZ2llciIN
Cg0KTWljaGFlbCBLZWxsZXkgKDIpOg0KICBEcml2ZXJzOiBodjogQ3JlYXRlIEh5cGVyLVYgY2xv
Y2tzb3VyY2UgZHJpdmVyIGZyb20gZXhpc3RpbmcNCiAgICBjbG9ja2V2ZW50cyBjb2RlDQogIERy
aXZlcnM6IGh2OiBNb3ZlIEh5cGVyLVYgY2xvY2tzb3VyY2UgY29kZSB0byBuZXcgY2xvY2tzb3Vy
Y2UgZHJpdmVyDQoNCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIg
Kw0KIGFyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyB8ICAgMSArDQogYXJjaC94
ODYvZW50cnkvdmRzby92bWEuYyAgICAgICAgICAgIHwgICAyICstDQogYXJjaC94ODYvaHlwZXJ2
L2h2X2luaXQuYyAgICAgICAgICAgIHwgIDkxICstLS0tLS0tLS0NCiBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9oeXBlcnYtdGxmcy5oICAgfCAgIDYgKw0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlw
ZXJ2LmggICAgICB8ICA4MSArKy0tLS0tLS0NCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2
LmMgICAgICAgfCAgIDIgKw0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQogZHJpdmVycy9jbG9ja3NvdXJjZS9NYWtlZmlsZSAgICAgICAgIHwgICAxICsNCiBk
cml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jICAgfCAzMjEgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2h2L0tjb25maWcgICAgICAgICAgICAgICAg
ICAgfCAgIDMgKw0KIGRyaXZlcnMvaHYvaHYuYyAgICAgICAgICAgICAgICAgICAgICB8IDE1NiAr
LS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvaHYvaHZfdXRpbC5jICAgICAgICAgICAgICAgICB8
ICAgMSArDQogZHJpdmVycy9odi9oeXBlcnZfdm1idXMuaCAgICAgICAgICAgIHwgICAzIC0NCiBk
cml2ZXJzL2h2L3ZtYnVzX2Rydi5jICAgICAgICAgICAgICAgfCAgNDIgKystLS0NCiBpbmNsdWRl
L2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oICAgfCAxMDUgKysrKysrKysrKysrDQogMTYgZmls
ZXMgY2hhbmdlZCwgNDg0IGluc2VydGlvbnMoKyksIDMzNCBkZWxldGlvbnMoLSkNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYw0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oDQoNCi0tIA0KMS44
LjMuMQ0KDQo=
