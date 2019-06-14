Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22E446C45
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2019 00:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfFNWTW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 18:19:22 -0400
Received: from mail-eopbgr1310130.outbound.protection.outlook.com ([40.107.131.130]:21920
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfFNWTV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 18:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ogeGsfe+ZtMT16Q/r4haEFDZtxbS4J8d92FYF+ZvYw7qjoHkYfmb4cXEjh7Qm+s9GXDquE0hN99EeWqP7AxSVby6PX4kuy4+leL4bHXdp6ZPr3/13BKJM6YxiNdzNWDwYPrB/Pb/d5ejr95kwBcoYRmGDpJtTF/R+wyCFZ1TnH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUDi3W1CBUPbXEsYkrtO70MRx+jfZ4Ts9Y5Wx6bRtzE=;
 b=lyhGLtlYv0JMdIWqsID8sOY0ySabAVU19cfUO8Lv7Ri+0gQeh6whO8Mzw9z5f2vULqn4zH2EyrCUQq/xb0Ug6Mb2lN16FvwwRT4Umlfq+UXEsk0t90x/P8oatHrFkgmXIqBxYfzQ2k8e5Cu8ckecHq2a5wCb0mqIqnJvlOSYR74=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUDi3W1CBUPbXEsYkrtO70MRx+jfZ4Ts9Y5Wx6bRtzE=;
 b=VvD/+D5JMLTwwnzciAiWqx8EZ9PP/f86MWprMX7DecZZlWq60BK/cKN4xFX24lbILd7CPq4S9ijJRQrP74xr8oWsTgzajONIrg+ZYuwPYoVZYS8HnlfuqpMWQVmZN4mbW+2UpK9apkm9sU6vL8zBnKBLv+OAnorpkiOjlGdVsVo=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0204.APCP153.PROD.OUTLOOK.COM (52.133.194.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.0; Fri, 14 Jun 2019 22:19:03 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04%4]) with mapi id 15.20.2008.007; Fri, 14 Jun 2019
 22:19:03 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Topic: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Index: AQHVIt2lUviLbUjfZEmzRslUu7e03qabnRQggAAYmbA=
Date:   Fri, 14 Jun 2019 22:19:02 +0000
Message-ID: <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-14T20:48:03.8463956Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e15e098-66cc-41b5-9a88-268aec453091;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:a444:4515:ca58:8eeb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcc86434-2de0-4844-a738-08d6f1164ef8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0204;
x-ms-traffictypediagnostic: PU1P153MB0204:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0204332A65A3D6ACA3F8CB3EBFEE0@PU1P153MB0204.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(346002)(396003)(13464003)(189003)(199004)(478600001)(2501003)(5660300002)(486006)(52536014)(54906003)(10290500003)(99286004)(316002)(186003)(11346002)(22452003)(2906002)(7696005)(8990500004)(256004)(14444005)(446003)(68736007)(476003)(33656002)(110136005)(14454004)(46003)(6116002)(66946007)(73956011)(66446008)(66476007)(66556008)(64756008)(76116006)(8676002)(229853002)(1511001)(71190400001)(8936002)(7416002)(10090500001)(55016002)(81166006)(81156014)(71200400001)(2201001)(74316002)(102836004)(305945005)(86362001)(76176011)(7736002)(53546011)(6506007)(9686003)(53936002)(6436002)(4326008)(25786009)(6246003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0204;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gH4thvTIx9QbHRNzzVbsY775i4gIgTVa26pRxnZrnu/qpw7aZ+fe03+iwZTOvx3ei3GR0eAwiACwG7WAYlcLUAmVSRlsI52YkFlKVnvW9DBePGx/qz74/z9C4Lu9UDci/BstM11A5yDw2rIGKO+HYMSocsaUmf7I/bkX5e8WvIYOrZ1X0cVNOVJIOnbbwva0NFZZSESv5UknZ/2zs6ZDXW8A6lHPKIbf4S8W7jR0Y4aWPq8SmnEvkI6oVWoaJivIZRJrKv6OGJPggtPt1qu/kR8pLI1uq0zlNYwEVg2WWVFoQuGzSe/3vY7WEy/4ECYi2rhxIM+atgzZDymC0gzY9BiornAQ7SsB2rrTBUMcog8ydDX42to/X9Ja/8scsxv8n5N6JIewiN/9itjQxHp3v3ugwhssNBna7F5cfHmhcSQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc86434-2de0-4844-a738-08d6f1164ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 22:19:02.9820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0204
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIEtlbGxleSA8bWlr
ZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDE0LCAyMDE5IDE6NDgg
UE0NCj4gVG86IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+OyBsaW51eC1hY3BpQHZn
ZXIua2VybmVsLm9yZzsNCj4gcmp3QHJqd3lzb2NraS5uZXQ7IGxlbmJAa2VybmVsLm9yZzsgcm9i
ZXJ0Lm1vb3JlQGludGVsLmNvbTsNCj4gZXJpay5zY2htYXVzc0BpbnRlbC5jb20NCj4gQ2M6IGxp
bnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEtZIFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPjsgU3RlcGhlbiBIZW1taW5nZXIg
PHN0aGVtbWluQG1pY3Jvc29mdC5jb20+Ow0KPiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNy
b3NvZnQuY29tPjsgU2FzaGEgTGV2aW4NCj4gPEFsZXhhbmRlci5MZXZpbkBtaWNyb3NvZnQuY29t
Pjsgb2xhZkBhZXBmbGUuZGU7IGFwd0BjYW5vbmljYWwuY29tOw0KPiBqYXNvd2FuZ0ByZWRoYXQu
Y29tOyB2a3V6bmV0cyA8dmt1em5ldHNAcmVkaGF0LmNvbT47DQo+IG1hcmNlbG8uY2VycmlAY2Fu
b25pY2FsLmNvbQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBBQ1BJOiBQTTogRXhwb3J0IHRoZSBm
dW5jdGlvbg0KPiBhY3BpX3NsZWVwX3N0YXRlX3N1cHBvcnRlZCgpDQo+IA0KPiBGcm9tOiBEZXh1
YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPiAgU2VudDogRnJpZGF5LCBKdW5lIDE0LCAyMDE5
IDExOjE5DQo+IEFNDQo+ID4NCj4gPiBJbiBhIExpbnV4IFZNIHJ1bm5pbmcgb24gSHlwZXItViwg
d2hlbiBBQ1BJIFM0IGlzIGVuYWJsZWQsIHRoZSBiYWxsb29uDQo+ID4gZHJpdmVyIChkcml2ZXJz
L2h2L2h2X2JhbGxvb24uYykgbmVlZHMgdG8gYXNrIHRoZSBob3N0IG5vdCB0byBkbyBtZW1vcnkN
Cj4gPiBob3QtYWRkL3JlbW92ZS4NCj4gPg0KPiA+IFNvIGxldCdzIGV4cG9ydCBhY3BpX3NsZWVw
X3N0YXRlX3N1cHBvcnRlZCgpIGZvciB0aGUgaHZfYmFsbG9vbiBkcml2ZXIuDQo+ID4gVGhpcyBt
aWdodCBhbHNvIGJlIHVzZWZ1bCB0byB0aGUgb3RoZXIgZHJpdmVycyBpbiB0aGUgZnV0dXJlLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hY3BpL3NsZWVwLmMgICAgfCAzICsrLQ0KPiA+ICBpbmNs
dWRlL2FjcGkvYWNwaV9idXMuaCB8IDIgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Fj
cGkvc2xlZXAuYyBiL2RyaXZlcnMvYWNwaS9zbGVlcC5jDQo+ID4gaW5kZXggYTM0ZGVjY2Q3MzE3
Li42OTc1NTQxMWUwMDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL3NsZWVwLmMNCj4g
PiArKysgYi9kcml2ZXJzL2FjcGkvc2xlZXAuYw0KPiA+IEBAIC03OSw3ICs3OSw3IEBAIHN0YXRp
YyBpbnQgYWNwaV9zbGVlcF9wcmVwYXJlKHUzMiBhY3BpX3N0YXRlKQ0KPiA+ICAJcmV0dXJuIDA7
DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMgYm9vbCBhY3BpX3NsZWVwX3N0YXRlX3N1cHBvcnRl
ZCh1OCBzbGVlcF9zdGF0ZSkNCj4gPiArYm9vbCBhY3BpX3NsZWVwX3N0YXRlX3N1cHBvcnRlZCh1
OCBzbGVlcF9zdGF0ZSkNCj4gPiAgew0KPiA+ICAJYWNwaV9zdGF0dXMgc3RhdHVzOw0KPiA+ICAJ
dTggdHlwZV9hLCB0eXBlX2I7DQo+ID4gQEAgLTg5LDYgKzg5LDcgQEAgc3RhdGljIGJvb2wgYWNw
aV9zbGVlcF9zdGF0ZV9zdXBwb3J0ZWQodTggc2xlZXBfc3RhdGUpDQo+ID4gIAkJfHwgKGFjcGlf
Z2JsX0ZBRFQuc2xlZXBfY29udHJvbC5hZGRyZXNzDQo+ID4gIAkJCSYmIGFjcGlfZ2JsX0ZBRFQu
c2xlZXBfc3RhdHVzLmFkZHJlc3MpKTsNCj4gPiAgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChh
Y3BpX3NsZWVwX3N0YXRlX3N1cHBvcnRlZCk7DQo+ID4NCj4gPiAgI2lmZGVmIENPTkZJR19BQ1BJ
X1NMRUVQDQo+ID4gIHN0YXRpYyB1MzIgYWNwaV90YXJnZXRfc2xlZXBfc3RhdGUgPSBBQ1BJX1NU
QVRFX1MwOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvYWNwaV9idXMuaCBiL2luY2x1
ZGUvYWNwaS9hY3BpX2J1cy5oDQo+ID4gaW5kZXggMzFiNmM4N2Q2MjQwLi41YjEwMmU3YmJmMjUg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgNCj4gPiArKysgYi9pbmNs
dWRlL2FjcGkvYWNwaV9idXMuaA0KPiA+IEBAIC02NTEsNiArNjUxLDggQEAgc3RhdGljIGlubGlu
ZSBpbnQgYWNwaV9wbV9zZXRfYnJpZGdlX3dha2V1cChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsDQo+
ID4gYm9vbCBlbmFibGUpDQo+ID4gIH0NCj4gPiAgI2VuZGlmDQo+ID4NCj4gPiArYm9vbCBhY3Bp
X3NsZWVwX3N0YXRlX3N1cHBvcnRlZCh1OCBzbGVlcF9zdGF0ZSk7DQo+ID4gKw0KPiA+ICAjaWZk
ZWYgQ09ORklHX0FDUElfU0xFRVANCj4gPiAgdTMyIGFjcGlfdGFyZ2V0X3N5c3RlbV9zdGF0ZSh2
b2lkKTsNCj4gPiAgI2Vsc2UNCj4gPiAtLQ0KPiA+IDIuMTkuMQ0KPiANCj4gSXQgc2VlbXMgdGhh
dCBzbGVlcC5jIGlzbid0IGJ1aWx0IHdoZW4gb24gdGhlIEFSTTY0IGFyY2hpdGVjdHVyZS4gIFVz
aW5nDQo+IGFjcGlfc2xlZXBfc3RhdGVfc3VwcG9ydGVkKCkgZGlyZWN0bHkgaW4gaHZfYmFsbG9v
bi5jIHdpbGwgYmUgcHJvYmxlbWF0aWMNCj4gc2luY2UgaHZfYmFsbG9vbi5jIG5lZWRzIHRvIGJl
IGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudCB3aGVuIHRoZQ0KPiBIeXBlci1WIEFSTTY0IHN1cHBv
cnQgaXMgYWRkZWQuICBJZiB0aGF0IGRvZXNuJ3QgY2hhbmdlLCBhIHBlci1hcmNoaXRlY3R1cmUN
Cj4gd3JhcHBlciB3aWxsIGJlIG5lZWRlZCB0byBnaXZlIGh2X2JhbGxvb24uYyB0aGUgY29ycmVj
dCBpbmZvcm1hdGlvbi4gIFRoaXMNCj4gbWF5IGFmZmVjdCB3aGV0aGVyIGFjcGlfc2xlZXBfc3Rh
dGVfc3VwcG9ydGVkKCkgbmVlZHMgdG8gYmUgZXhwb3J0ZWQgdnMuDQo+IGp1c3QgcmVtb3Zpbmcg
dGhlICJzdGF0aWMiLiAgIEknbSBub3Qgc3VyZSB3aGF0IHRoZSBiZXN0IGFwcHJvYWNoIGlzLg0K
PiANCj4gTWljaGFlbA0KDQorIHNvbWUgQVJNIGV4cGVydHMgd2hvIHdvcmtlZCBvbiBhcmNoL2Fy
bS9rZXJuZWwvaGliZXJuYXRlLmMuDQoNCmRyaXZlcnMvYWNwaS9zbGVlcC5jIGlzIG9ubHkgYnVp
bHQgaWYgQUNQSV9TWVNURU1fUE9XRVJfU1RBVEVTX1NVUFBPUlQNCmlzIGRlZmluZWQsIGJ1dCBp
dCBsb29rcyB0aGlzIG9wdGlvbiBpcyBub3QgZGVmaW5lZCBvbiBBUk0uDQoNCkl0IGxvb2tzIEFS
TSBkb2VzIG5vdCBzdXBwb3J0IHRoZSBBQ1BJIFM0IHN0YXRlLCB0aGVuIGhvdyBkbyB3ZSBrbm93
IA0KaWYgYW4gQVJNIGhvc3Qgc3VwcG9ydHMgaGliZXJuYXRpb24gb3Igbm90Pw0KDQpUaGFua3Ms
DQotLSBEZXh1YW4NCg==
