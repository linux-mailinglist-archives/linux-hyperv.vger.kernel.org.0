Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5025B5EB21
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2019 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCSGq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jul 2019 14:06:46 -0400
Received: from mail-eopbgr810110.outbound.protection.outlook.com ([40.107.81.110]:46893
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfGCSGp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jul 2019 14:06:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH7ehJQznznf4vspSj3ZvCZem+SK4KIK7PnEYohWIiPZmmfiAEg7zpq3AAc9FtxLA0PFyNl9AAvAadKWlSswZpwKi5WCcX6O8IP1Ds/wkf6zvmi5glZHY0Qb2Kvf0BCgw84oFQ/jrmTmpTqR25BVef6OuPoIYmMEH0DtJPSPxOUGvB/P4gyJcoH3qh2obOI3BWaDAaHrZqHP7poFJfb/Bh3qmUNhG/3CswlHfaCvWi+437+o4f0olsiI78LlBa51ekQtunMCC0SZZhw7vuJlseI+SmGEwQhV7OLduivPJ8xZGNXPlD4nI2X3M1FZrzSb23sqHoDtjpTAog2MvfcOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLwivD5rLTVUq5TEwouPslFWzQKwN6Efw95Q2tT2RzQ=;
 b=XPHVJNYs7RWVssnACmFqDWCpob+ZjwURwF35Z89sgAwdzyPHmUQvt4sPDNeAaQHiPtvUcoh+g4qkN0NvOBE1ZD9jCANscMz0IyVRUktlAkB5n1L7GQUltpooKzK0j3kgxAfNvikFz4LAQcUuWkJku79HJCUF5kVB7brrsJeYPbo7Q3ewzkccqTEjZ2kkXsZP9Gbw4fSjKgUPdKwGoLrA+d4W3m9xrBGD+615qHX5hzzVxkJWxcMituoQ25z67UpM4FE13x1FQGCtP4jQ6Up/YNpi6RzzE0hCF7RfHSegd/B7dkTtr+a1oQ9xhs9D5amLwPrCGtxddqBCRvuJHM1emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLwivD5rLTVUq5TEwouPslFWzQKwN6Efw95Q2tT2RzQ=;
 b=dLZKlmaFibO+zEFYq6TCkB7AG9gSYtkqDjlSwGhmjG+Mgvbv7A2QTJizon+3M8V2kzueeN7Ft6AuS0kJJ2jsdgY+oJk0NlVoPUGxliIbc9zdHgy2JOViHPIy9fvZ0AO5k2nj7aGb8X7i9WDHIqfcUY0wuVaOsa/nYxWvNvbejic=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (2603:10b6:5:175::16)
 by DM6PR21MB1307.namprd21.prod.outlook.com (2603:10b6:5:171::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.2; Wed, 3 Jul
 2019 18:06:39 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a9cb:1d2b:e8d8:573e]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::a9cb:1d2b:e8d8:573e%5]) with mapi id 15.20.2008.014; Wed, 3 Jul 2019
 18:06:39 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Yuehaibing <yuehaibing@huawei.com>
Subject: RE: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
Thread-Topic: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
Thread-Index: AQHVMcCvLptiLG1oikynzb1OHeKdE6a5LkYQ
Date:   Wed, 3 Jul 2019 18:06:39 +0000
Message-ID: <DM6PR21MB13373F2B76558930CC368E17CAFB0@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <535f212f-e111-399d-4ad0-82d2ae505e48@infradead.org>
In-Reply-To: <535f212f-e111-399d-4ad0-82d2ae505e48@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: sthemmin@microsoft.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-03T18:06:38.2187008Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d9dcb44b-3635-4ab5-a3b7-496c8172d17f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61ed75e2-2b7f-4e54-af87-08d6ffe13274
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1307;
x-ms-traffictypediagnostic: DM6PR21MB1307:|DM6PR21MB1307:
x-microsoft-antispam-prvs: <DM6PR21MB1307AE86356599E75BBE8AD0CAFB0@DM6PR21MB1307.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(189003)(13464003)(199004)(40224003)(6636002)(6506007)(53546011)(26005)(22452003)(71190400001)(4326008)(102836004)(7696005)(76176011)(14454004)(52396003)(71200400001)(74316002)(186003)(99286004)(1511001)(316002)(66446008)(66946007)(76116006)(64756008)(66476007)(73956011)(66556008)(54906003)(68736007)(7736002)(5660300002)(305945005)(66066001)(8676002)(52536014)(10090500001)(229853002)(8990500004)(3846002)(11346002)(446003)(8936002)(478600001)(6436002)(86362001)(6116002)(81156014)(81166006)(486006)(476003)(53936002)(10290500003)(14444005)(256004)(55016002)(2906002)(33656002)(110136005)(9686003)(25786009)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1307;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xjq5Qx+EI6ZAQGToF1+AMD1sggA2OBTvRtVeggUGOo9uzFTzY3voED4YD1e6UgAd3rMKZGKqlLiPWFSbxBNjYX2m0+5mpoTmVXxI4bva3S/096cTROX1LZTt0RiWrbg0zCVuMLPUpjCjsn5+RAIiApVXtuwLRsRdY5us8yUljCLi3p5B0VGcUzcKG+BHetSVGWmDLV1FX+tI8t6HvMCXYlpZW1UPYOUl7UvEIrNjiGnxvAYs8KjOhXRKpfXpHVW/2udOe0U11bvSk2daRBsp/DLcaIB5phO5NrFpvKEyRrYlw0NCwXENOHWIU1iw1GPR8RjrOc9kMb2VvluIj4eWwGAK0YWFDmIvpkRh4GRub4VIp9m066X6FtBkea+VS9kU+eROHHD0F9Bmskyk/U921lCg41/LrTxzw8UTQpaUxw4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ed75e2-2b7f-4e54-af87-08d6ffe13274
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 18:06:39.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haiyangz@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1307
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAzLCAyMDE5IDEy
OjU5IFBNDQo+IFRvOiBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgt
cGNpIDxsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZz4NCj4gQ2M6IE1hdHRoZXcgV2lsY294
IDx3aWxseUBpbmZyYWRlYWQub3JnPjsgSmFrZSBPc2hpbnMNCj4gPGpha2VvQG1pY3Jvc29mdC5j
b20+OyBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47IEhhaXlhbmcNCj4gWmhhbmcg
PGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBTdGVwaGVuIEhlbW1pbmdlcg0KPiA8c3RoZW1taW5A
bWljcm9zb2Z0LmNvbT47IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz47IEJqb3JuDQo+
IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwu
b3JnOyBEZXh1YW4NCj4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsgWXVlaGFpYmluZyA8eXVl
aGFpYmluZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIFBDSTogaHY6IGZpeCBw
Y2ktaHlwZXJ2IGJ1aWxkIHdoZW4gU1lTRlMgbm90IGVuYWJsZWQNCj4gDQo+IEZyb206IFJhbmR5
IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gRml4IGJ1aWxkIG9mIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5vIHdoZW4NCj4gQ09ORklHX1NZU0ZTIGlzIG5v
dCBzZXQvZW5hYmxlZCBieSBhZGRpbmcgc3R1YnMgZm9yDQo+IHBjaV9jcmVhdGVfc2xvdCgpIGFu
ZCBwY2lfZGVzdHJveV9zbG90KCkuDQo+IA0KPiBGaXhlcyB0aGVzZSBidWlsZCBlcnJvcnM6DQo+
IA0KPiBFUlJPUjogInBjaV9kZXN0cm95X3Nsb3QiIFtkcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aS1oeXBlcnYua29dIHVuZGVmaW5lZCENCj4gRVJST1I6ICJwY2lfY3JlYXRlX3Nsb3QiIFtkcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYua29dIHVuZGVmaW5lZCENCj4gDQo+IEZpeGVz
OiBhMTVmMmMwOGM3MDggKCJQQ0k6IGh2OiBzdXBwb3J0IHJlcG9ydGluZyBzZXJpYWwgbnVtYmVy
IGFzIHNsb3QNCj4gaW5mb3JtYXRpb24iKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVu
bGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBNYXR0aGV3IFdpbGNveCA8d2lsbHlA
aW5mcmFkZWFkLm9yZz4NCj4gQ2M6IEpha2UgT3NoaW5zIDxqYWtlb0BtaWNyb3NvZnQuY29tPg0K
PiBDYzogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IEhhaXlh
bmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQo+IENjOiBTdGVwaGVuIEhlbW1pbmdl
ciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IFNhc2hhIExldmluIDxzYXNoYWxAa2Vy
bmVsLm9yZz4NCj4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IENj
OiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1oeXBlcnZAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiBDYzogWXVl
aGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gdjI6DQo+IC0gcHJvdmlk
ZSBub24tQ09ORklHX1NZU0ZTIHN0dWJzIGZvciBwY2lfY3JlYXRlX3Nsb3QoKSBhbmQNCj4gICBw
Y2lfZGVzdHJveV9zbG90KCkgW3N1Z2dlc3RlZCBieSBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5m
cmFkZWFkLm9yZz5dDQo+IC0gdXNlIHRoZSBjb3JyZWN0IEZpeGVzOiB0YWcgW0RleHVhbiBDdWkg
PGRlY3VpQG1pY3Jvc29mdC5jb20+XQ0KPiANCj4gIGluY2x1ZGUvbGludXgvcGNpLmggfCAgIDEy
ICsrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiAtLS0gbG54LTUyLXJjNy5vcmlnL2luY2x1ZGUvbGludXgvcGNpLmgN
Cj4gKysrIGxueC01Mi1yYzcvaW5jbHVkZS9saW51eC9wY2kuaA0KPiBAQCAtMjUsNiArMjUsNyBA
QA0KPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2xpc3Qu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2Vy
ci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQo+ICAjaW5jbHVkZSA8bGludXgva29i
amVjdC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2F0b21pYy5oPg0KPiBAQCAtOTQ3LDE0ICs5NDgs
MjEgQEAgaW50IHBjaV9zY2FuX3Jvb3RfYnVzX2JyaWRnZShzdHJ1Y3QgcGNpXw0KPiAgc3RydWN0
IHBjaV9idXMgKnBjaV9hZGRfbmV3X2J1cyhzdHJ1Y3QgcGNpX2J1cyAqcGFyZW50LCBzdHJ1Y3Qg
cGNpX2Rldg0KPiAqZGV2LA0KPiAgCQkJCWludCBidXNucik7DQo+ICB2b2lkIHBjaWVfdXBkYXRl
X2xpbmtfc3BlZWQoc3RydWN0IHBjaV9idXMgKmJ1cywgdTE2IGxpbmtfc3RhdHVzKTsNCj4gKyNp
ZmRlZiBDT05GSUdfU1lTRlMNCj4gK3ZvaWQgcGNpX2Rldl9hc3NpZ25fc2xvdChzdHJ1Y3QgcGNp
X2RldiAqZGV2KTsNCj4gIHN0cnVjdCBwY2lfc2xvdCAqcGNpX2NyZWF0ZV9zbG90KHN0cnVjdCBw
Y2lfYnVzICpwYXJlbnQsIGludCBzbG90X25yLA0KPiAgCQkJCSBjb25zdCBjaGFyICpuYW1lLA0K
PiAgCQkJCSBzdHJ1Y3QgaG90cGx1Z19zbG90ICpob3RwbHVnKTsNCj4gIHZvaWQgcGNpX2Rlc3Ry
b3lfc2xvdChzdHJ1Y3QgcGNpX3Nsb3QgKnNsb3QpOw0KPiAtI2lmZGVmIENPTkZJR19TWVNGUw0K
PiAtdm9pZCBwY2lfZGV2X2Fzc2lnbl9zbG90KHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0KPiAgI2Vs
c2UNCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBwY2lfZGV2X2Fzc2lnbl9zbG90KHN0cnVjdCBwY2lf
ZGV2ICpkZXYpIHsgfQ0KPiArc3RhdGljIGlubGluZSBzdHJ1Y3QgcGNpX3Nsb3QgKnBjaV9jcmVh
dGVfc2xvdChzdHJ1Y3QgcGNpX2J1cyAqcGFyZW50LA0KPiArCQkJCQkgICAgICAgaW50IHNsb3Rf
bnIsDQo+ICsJCQkJCSAgICAgICBjb25zdCBjaGFyICpuYW1lLA0KPiArCQkJCQkgICAgICAgc3Ry
dWN0IGhvdHBsdWdfc2xvdCAqaG90cGx1Zykgew0KPiArCXJldHVybiBFUlJfUFRSKC1FSU5WQUwp
Ow0KPiArfQ0KPiArc3RhdGljIGlubGluZSB2b2lkIHBjaV9kZXN0cm95X3Nsb3Qoc3RydWN0IHBj
aV9zbG90ICpzbG90KSB7IH0NCj4gICNlbmRpZg0KPiAgaW50IHBjaV9zY2FuX3Nsb3Qoc3RydWN0
IHBjaV9idXMgKmJ1cywgaW50IGRldmZuKTsNCj4gIHN0cnVjdCBwY2lfZGV2ICpwY2lfc2Nhbl9z
aW5nbGVfZGV2aWNlKHN0cnVjdCBwY2lfYnVzICpidXMsIGludCBkZXZmbik7DQo+IA0KDQpUaGUg
c2VyaWFsIG51bWJlciBpbiBzbG90IGluZm8gaXMgdXNlZCB0byBtYXRjaCBWRiBOSUMgd2l0aCBT
eW50aGV0aWMgTklDLg0KV2l0aG91dCBzZWxlY3RpbmcgU1lTRlMsIHRoZSBTUklPViBmZWF0dXJl
IHdpbGwgZmFpbCBvbiBWTSBvbiBIeXBlci1WIGFuZA0KQXp1cmUuIFRoZSBmaXJzdCB2ZXJzaW9u
IG9mIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIHVzZWQuDQoNCkBTdGVwaGVuIEhlbW1pbmdlciBob3cg
ZG8geW91IHRoaW5rPw0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg==
