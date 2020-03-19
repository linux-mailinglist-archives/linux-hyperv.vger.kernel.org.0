Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9218A9D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 01:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCSAdf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 20:33:35 -0400
Received: from mail-mw2nam12on2094.outbound.protection.outlook.com ([40.107.244.94]:27816
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCSAdf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 20:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCpzOrwUToEG8OYNoBsQUWnaFYsp5bLhFzYd37bFXEeQ4mm+/3gfjWA06G3gNTPqCiIH+Nmbf5n4kFt2LXfUXtDON6RUO4nncuzy6WrHGA/TvQHzEgiZwPGWbgoHZ7lJz8y9q48UUwAzZoLdGTbjdUlSWm/Q/3XZLplBafbrudhafgbnlSorVEmwHT3EhwHgvClTs0f03iUgAruX/7e9TARFkhOSdk8lQdb7A5096+cWoytPy+fK7IeGYpE1X9GjsWl9BRiNRdzUYP9ZpeY4AjNg0rmxFrhfmg/Ktf86fdqibqnMvSQUlTRCN1f89FnbKbv8qZyJBx2YxaSkUMf3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGQ9rPcviwP1sUkkPjsXxa6KW53C9WpgWl9o8192M+A=;
 b=Zy/sSYJ13BKc06CthylUG71zqO15/oL/rh65quzL2hXPygpUMNx3Bin8kANJe93LQ3Hxot0ntizZIhGL67L0cAtaR5ygVkyPFjsIbpExyTi0l406XBDXjyJj2fShKCNXCBfoYK9AhF+EBTBWNBeBIYQGXc5pNbbqL9vvcNOq91JAtGlpltAUflbqqd/KDh9Ev6JlF2WMCoaPNjhS0S+FAS73MvS869NzHjxtcsV1a3hKYrzhbqeD43tjPYrcs9/LUHUPwHjISb/lQym5WCuz/csILDgvwTjTREsfWSwYVIV4gR4fJw0nHA+sF4b5ZHBGaYjrw4xy7o80+8fcFEg6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGQ9rPcviwP1sUkkPjsXxa6KW53C9WpgWl9o8192M+A=;
 b=MPOSyktQrpCp2KRTTOyB/maxXYPDdT9O9we68oqD0VTbw1Q9sj65lCGa2CbQeMzMI/J7TSo7h0p20MsdT/EGB4BCYHcex74VFzTeTRy7+V6Ik4L7ivnJnrtJns8rQNVQ4aDW6hhrJOclfuM8MAsRhzAreOI9KKAJCPHZktaluwE=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1003.namprd21.prod.outlook.com (2603:10b6:302:4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.2; Thu, 19 Mar
 2020 00:33:18 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Thu, 19 Mar 2020
 00:33:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "ltykernel@gmail.com" <ltykernel@gmail.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Topic: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
Thread-Index: AQHV/F+NpF+arxPCF0mdiFS5UJm0vqhOg1uAgACKLMA=
Date:   Thu, 19 Mar 2020 00:33:18 +0000
Message-ID: <MW2PR2101MB10529A60AF5185BBD7B02E04D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
 <871rpp3ba8.fsf@vitty.brq.redhat.com>
In-Reply-To: <871rpp3ba8.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T00:33:16.6332132Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e8c80f8-f7ae-4bd4-82f2-c16c3419a7bd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62c123c6-b4f9-4353-26ec-08d7cb9d1ee3
x-ms-traffictypediagnostic: MW2PR2101MB1003:|MW2PR2101MB1003:|MW2PR2101MB1003:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1003EC9550879189AFB0261ED7F40@MW2PR2101MB1003.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(2906002)(8676002)(81166006)(81156014)(8936002)(478600001)(71200400001)(10290500003)(4326008)(9686003)(55016002)(7696005)(54906003)(316002)(110136005)(8990500004)(76116006)(33656002)(66556008)(86362001)(6506007)(66946007)(52536014)(5660300002)(66476007)(66446008)(26005)(186003)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1003;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7h737iLdvRLFtoOae5BXbGAVwfSU6EYcu09Gf0GHyTrAQNDsucCb2Qr3MoAMRfycH8MRghZmPQTN0d3TqyW/mcyNtDcQYfwmFH3tVER+ZMI8mHo56NeNoGebLO1GXGmpiHp0RfRTZEEpkH01bqKjkA1xeRopL8ZTnA4J3VjjMpjVJeft+OrpZ8crCKYkBRWxtSIbRNfiPCmx8QIXn+3pMOFjqwXILRxLT8/tFfP0gHBDYCFzVYxQTlvIRvnRi5MaPbQBWSXOauiTENDVknoAqdSYwW+oEHemCOkctOSyGBlVhO+X+dnaUrLxwlcQt7tDiYPXblIO/VZ04nKLXT0uPE6Izcx1c0SP4IS7WABPaxOfLqtxO1UF39Ky/+U5FEkN6NotyvgHzqvq2q6T+sZKJshlJLVSKIF4nQwn3JUREWZaAF43EbFiC8UpcTtEIR2
x-ms-exchange-antispam-messagedata: CAzU5osk4BiK+b4wPQEar2goiBXtH962JpoXSQEnhrrjUttjK4vQ9UP8aF8osc2iNknJc5QJw3SiBhkrBXbcvQbfs1jsT3RnWcaK0B8oplvR7fbQmzrqJMDQAsRhv/A8d9xRh1WdfDJwO9/iecQvjQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c123c6-b4f9-4353-26ec-08d7cb9d1ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 00:33:18.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28be3FgeblG3PdyrKH2/8ZfK2NzAnAfC3E8ynfcuqaviUaLBOGTfClr12utEQJdd2o2zRs9pD8iHt9H8Jige7ZN/NntB8dIZNOQhU9Bao/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1003
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogVml0YWx5IEt1em5ldHNvdiA8dmt1em5ldHNAcmVkaGF0LmNvbT4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAxOCwgMjAyMCA4OjU4IEFNDQo+IA0KPiBsdHlrZXJuZWxAZ21haWwuY29tIHdy
aXRlczoNCj4gDQo+ID4gRnJvbTogVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29t
Pg0KPiA+DQo+ID4gQ3VzdG9tZXIgcmVwb3J0ZWQgSHlwZXItViBWTSBzdGlsbCByZXNwb25kZWQg
bmV0d29yayB0cmFmZmljDQo+ID4gYWNrIHBhY2tldHMgYWZ0ZXIga2VybmVsIHBhbmljIHdpdGgg
a2VybmVsIHBhcmFtZXRlciAicGFuaWM9MOKAnS4NCj4gPiBUaGlzIGJlY2F1c2VzIHZtYnVzIGRy
aXZlciBpbnRlcnJ1cHQgaGFuZGxlciBzdGlsbCB3b3Jrcw0KPiA+IG9uIHRoZSBwYW5pYyBjcHUg
YWZ0ZXIga2VybmVsIHBhbmljLiBQYW5pYyBjcHUgZmFsbHMgaW50bw0KPiA+IGluZmluaXRlIGxv
b3Agb2YgcGFuaWMoKSB3aXRoIGludGVycnVwdCBlbmFibGVkIGF0IHRoYXQgcG9pbnQuDQo+ID4g
Vm1idXMgZHJpdmVyIGNhbiBzdGlsbCBoYW5kbGUgbmV0d29yayB0cmFmZmljLg0KPiA+DQo+ID4g
VGhpcyBjb25mdXNlcyByZW1vdGUgc2VydmljZSB0aGF0IHRoZSBwYW5pYyBzeXN0ZW0gaXMgc3Rp
bGwNCj4gPiBhbGl2ZSB3aGVuIGl0IGdldHMgYWNrIHBhY2tldHMuIFVubG9hZCB2bWJ1cyBjaGFu
bmVsIGluIGh2IHBhbmljDQo+ID4gY2FsbGJhY2sgYW5kIGZpeCBpdC4NCj4gPg0KPiA+IHZtYnVz
X2luaXRpYXRlX3VubG9hZCgpIG1heWJlIGRvdWJsZSBjYWxsZWQgZHVyaW5nIHBhbmljIHByb2Nl
c3MNCj4gPiAoZS5nLCBoeXBlcnZfcGFuaWNfZXZlbnQoKSBhbmQgaHZfY3Jhc2hfaGFuZGxlcigp
KS4gU28gY2hlY2sNCj4gPiBhbmQgc2V0IGNvbm5lY3Rpb24gc3RhdGUgaW4gdm1idXNfaW5pdGlh
dGVfdW5sb2FkKCkgdG8gcmVzb2x2ZQ0KPiA+IHJlZW50ZXIgaXNzdWUuDQoNCkxldCBtZSBzdWdn
ZXN0IGEgcmV2aXNlZCB2ZXJzaW9uIG9mIHRoZSBjb21taXQgbWVzc2FnZToNCg0KV2hlbiBrZHVt
cCBpcyBub3QgY29uZmlndXJlZCwgYSBIeXBlci1WIFZNIG1pZ2h0IHN0aWxsIHJlc3BvbmQgdG8N
Cm5ldHdvcmsgdHJhZmZpYyBhZnRlciBhIGtlcm5lbCBwYW5pYyB3aGVuIGtlcm5lbCBwYXJhbWV0
ZXIgcGFuaWM9MC4NClRoZSBwYW5pYyBDUFUgZ29lcyBpbnRvIGFuIGluZmluaXRlIGxvb3Agd2l0
aCBpbnRlcnJ1cHRzIGVuYWJsZWQsDQphbmQgdGhlIFZNYnVzIGRyaXZlciBpbnRlcnJ1cHQgaGFu
ZGxlciBzdGlsbCB3b3JrcyBiZWNhdXNlIHRoZSANClZNYnVzIGNvbm5lY3Rpb24gaXMgdW5sb2Fk
ZWQgb25seSBpbiB0aGUga2R1bXAgcGF0aC4gIFRoZSBuZXR3b3JrDQpyZXNwb25zZXMgbWFrZSB0
aGUgb3RoZXIgZW5kIG9mIHRoZSBjb25uZWN0aW9uIHRoaW5rIHRoZSBWTSBpcw0Kc3RpbGwgZnVu
Y3Rpb25hbCBldmVuIHRob3VnaCBpdCBoYXMgcGFuaWMnZWQsIHdoaWNoIGNvdWxkIGFmZmVjdCBh
bnkNCmZhaWxvdmVyIGFjdGlvbnMgdGhhdCBzaG91bGQgYmUgdGFrZW4uDQoNCkZpeCB0aGlzIGJ5
IHVubG9hZGluZyB0aGUgVk1idXMgY29ubmVjdGlvbiBkdXJpbmcgdGhlIHBhbmljIHByb2Nlc3Mu
DQp2bWJ1c19pbml0aWF0ZV91bmxvYWQoKSBjb3VsZCB0aGVuIGJlIGNhbGxlZCB0d2ljZSAoZS5n
LiwgYnkNCmh5cGVydl9wYW5pY19ldmVudCgpIGFuZCBodl9jcmFzaF9oYW5kbGVyKCksIHNvIHJl
c2V0IHRoZSBjb25uZWN0aW9uDQpzdGF0ZSBpbiB2bWJ1c19pbml0aWF0ZV91bmxvYWQoKSB0byBl
bnN1cmUgdGhlIHVubG9hZCBpcyBkb25lIG9ubHkNCm9uY2UuDQoNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRpYW55dSBMYW4gPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9odi9jaGFubmVsX21nbXQuYyB8ICA1ICsrKysrDQo+ID4gIGRyaXZlcnMvaHYv
dm1idXNfZHJ2LmMgICAgfCAxNyArKysrKysrKystLS0tLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9odi9jaGFubmVsX21nbXQuYyBiL2RyaXZlcnMvaHYvY2hhbm5lbF9tZ210LmMN
Cj4gPiBpbmRleCAwMzcwMzY0MTY5YzQuLjg5MzQ5M2YyYjQyMCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2h2L2NoYW5uZWxfbWdtdC5jDQo+ID4gKysrIGIvZHJpdmVycy9odi9jaGFubmVsX21n
bXQuYw0KPiA+IEBAIC04MzksNiArODM5LDkgQEAgdm9pZCB2bWJ1c19pbml0aWF0ZV91bmxvYWQo
Ym9vbCBjcmFzaCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IHZtYnVzX2NoYW5uZWxfbWVzc2FnZV9o
ZWFkZXIgaGRyOw0KPiA+DQo+ID4gKwlpZiAodm1idXNfY29ubmVjdGlvbi5jb25uX3N0YXRlID09
IERJU0NPTk5FQ1RFRCkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiANCj4gVG8gbWFrZSB0aGlz
IGxlc3MgcmFjeSwgY2FuIHdlIGRvIHNvbWV0aGluZyBsaWtlDQo+IA0KPiAJaWYgKHhjaGcoJnZt
YnVzX2Nvbm5lY3Rpb24uY29ubl9zdGF0ZSwgRElTQ09OTkVDVEVEKSA9PSBESVNDT05ORUNURUQp
DQo+IAkJcmV0dXJuOw0KPiANCj4gPw0KDQpJIHdhcyB0cnlpbmcgdG8gZGVjaWRlIGlmIHRoZXJl
IGNhbiBhY3R1YWxseSBiZSBhIHJhY2UuICBUaGUgcGFuaWMoKSBhbmQgZGllKCkNCmZ1bmN0aW9u
cyBib3RoIGVuc3VyZSB0aGF0IG9ubHkgYSBzaW5nbGUgQ1BVIGNhbiBleGVjdXRlIGluIHRob3Nl
IHBhdGhzIGF0IGFueQ0Kb25lIHRpbWUsIHRob3VnaCBtYXliZSBwYW5pYygpIGFuZCBkaWUoKSBj
b3VsZCBiZSBydW5uaW5nIGNvbmN1cnJlbnRseS4NCkFuZCB2bWJ1c19pbml0aWF0ZV91bmxvYWQo
KSBjYW4gYWxzbyBiZSBjYWxsZWQgaW4gdGhlIGhpYmVybmF0aW9uIHBhdGggaW4NCnZtYnVzX2J1
c19zdXNwZW5kKCksIHNvIHRoZXJlIGNvdWxkIGJlIGEgcmFjZS4gIERvaW5nIHRoZSB4Y2hnKCkg
bWFrZXMNCnNlbnNlLg0KDQo+IA0KPiA+ICAJLyogUHJlLVdpbjIwMTJSMiBob3N0cyBkb24ndCBz
dXBwb3J0IHJlY29ubmVjdCAqLw0KPiA+ICAJaWYgKHZtYnVzX3Byb3RvX3ZlcnNpb24gPCBWRVJT
SU9OX1dJTjhfMSkNCj4gPiAgCQlyZXR1cm47DQo+ID4gQEAgLTg1Nyw2ICs4NjAsOCBAQCB2b2lk
IHZtYnVzX2luaXRpYXRlX3VubG9hZChib29sIGNyYXNoKQ0KPiA+ICAJCXdhaXRfZm9yX2NvbXBs
ZXRpb24oJnZtYnVzX2Nvbm5lY3Rpb24udW5sb2FkX2V2ZW50KTsNCj4gPiAgCWVsc2UNCj4gPiAg
CQl2bWJ1c193YWl0X2Zvcl91bmxvYWQoKTsNCj4gPiArDQo+ID4gKwl2bWJ1c19jb25uZWN0aW9u
LmNvbm5fc3RhdGUgPSBESVNDT05ORUNURUQ7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9p
ZCBjaGVja19yZWFkeV9mb3JfcmVzdW1lX2V2ZW50KHZvaWQpDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaHYvdm1idXNfZHJ2LmMgYi9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jDQo+ID4gaW5kZXgg
MDI5Mzc4YzI3NDIxLi5iNTZiOWZiOWJkOTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9odi92
bWJ1c19kcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaHYvdm1idXNfZHJ2LmMNCj4gPiBAQCAtNTMs
OSArNTMsMTIgQEAgc3RhdGljIGludCBoeXBlcnZfcGFuaWNfZXZlbnQoc3RydWN0IG5vdGlmaWVy
X2Jsb2NrICpuYiwgdW5zaWduZWQNCj4gbG9uZyB2YWwsDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBw
dF9yZWdzICpyZWdzOw0KPiA+DQo+ID4gLQlyZWdzID0gY3VycmVudF9wdF9yZWdzKCk7DQo+ID4g
Kwl2bWJ1c19pbml0aWF0ZV91bmxvYWQodHJ1ZSk7DQo+ID4NCj4gPiAtCWh5cGVydl9yZXBvcnRf
cGFuaWMocmVncywgdmFsKTsNCj4gPiArCWlmIChtc19oeXBlcnYubWlzY19mZWF0dXJlcyAmIEhW
X0ZFQVRVUkVfR1VFU1RfQ1JBU0hfTVNSX0FWQUlMQUJMRSkgew0KPiANCj4gV2l0aCBNaWNoYWVs
J3MgZWZmb3JzIHRvIG1ha2UgY29kZSBpbiBkcml2ZXJzL2h2IGFyY2ggYWdub3N0aWMsIEkgdGhp
bmsNCj4gd2UgbmVlZCBhIGJldHRlciwgYXJjaC1uZXV0cmFsIHdheS4NCg0KVml0YWx5IC0tIGNv
dWxkIHlvdSBlbGFib3JhdGUgb24gd2hhdCBwYXJ0IGlzIG5vdCBhcmNoLW5ldXRyYWw/ICBJIGRv
bid0IHNlZQ0KYSBwcm9ibGVtLiAgbXNfaHlwZXJ2IGFuZCB0aGUgbWlzY19mZWF0dXJlcyBmaWVs
ZCBleGlzdCBmb3IgYm90aCB0aGUgeDg2DQphbmQgQVJNNjQgY29kZSBicmFuY2hlcy4gIEl0IHR1
cm5zIG91dCB0aGUgcGFydGljdWxhciBiaXQgZm9yDQpHVUVTVF9DUkFTSF9NU1JfQVZBSUxBQkxF
IGlzIGRpZmZlcmVudCBvbiB0aGUgdHdvIGFyY2hpdGVjdHVyZXMsIGJ1dA0KdGhlIGNvbXBpbGVy
IHdpbGwgZG8gdGhlIHJpZ2h0IHRoaW5nLg0KDQo+IA0KPiA+ICsJCXJlZ3MgPSBjdXJyZW50X3B0
X3JlZ3MoKTsNCj4gPiArCQloeXBlcnZfcmVwb3J0X3BhbmljKHJlZ3MsIHZhbCk7DQo+ID4gKwl9
DQo+ID4gIAlyZXR1cm4gTk9USUZZX0RPTkU7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC0xMzkxLDEw
ICsxMzk0LDEyIEBAIHN0YXRpYyBpbnQgdm1idXNfYnVzX2luaXQodm9pZCkNCj4gPiAgCQl9DQo+
ID4NCj4gPiAgCQlyZWdpc3Rlcl9kaWVfbm90aWZpZXIoJmh5cGVydl9kaWVfYmxvY2spOw0KPiA+
IC0JCWF0b21pY19ub3RpZmllcl9jaGFpbl9yZWdpc3RlcigmcGFuaWNfbm90aWZpZXJfbGlzdCwN
Cj4gPiAtCQkJCQkgICAgICAgJmh5cGVydl9wYW5pY19ibG9jayk7DQo+ID4gIAl9DQo+ID4NCj4g
PiArCS8qIFZtYnVzIGNoYW5uZWwgaXMgdW5sb2FkZWQgaW4gcGFuaWMgY2FsbGJhY2sgd2hlbiBw
YW5pYyBoYXBwZW5zLiovDQo+ID4gKwlhdG9taWNfbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIoJnBh
bmljX25vdGlmaWVyX2xpc3QsDQo+ID4gKwkJCSAgICAgICAmaHlwZXJ2X3BhbmljX2Jsb2NrKTsN
Cj4gPiArDQo+ID4gIAl2bWJ1c19yZXF1ZXN0X29mZmVycygpOw0KPiA+DQo+ID4gIAlyZXR1cm4g
MDsNCj4gPiBAQCAtMjIwNCw4ICsyMjA5LDYgQEAgc3RhdGljIGludCB2bWJ1c19idXNfc3VzcGVu
ZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4NCj4gPiAgCXZtYnVzX2luaXRpYXRlX3VubG9hZChm
YWxzZSk7DQo+ID4NCj4gPiAtCXZtYnVzX2Nvbm5lY3Rpb24uY29ubl9zdGF0ZSA9IERJU0NPTk5F
Q1RFRDsNCj4gPiAtDQo+ID4gIAkvKiBSZXNldCB0aGUgZXZlbnQgZm9yIHRoZSBuZXh0IHJlc3Vt
ZS4gKi8NCj4gPiAgCXJlaW5pdF9jb21wbGV0aW9uKCZ2bWJ1c19jb25uZWN0aW9uLnJlYWR5X2Zv
cl9yZXN1bWVfZXZlbnQpOw0KPiA+DQo+ID4gQEAgLTIyODksNyArMjI5Miw2IEBAIHN0YXRpYyB2
b2lkIGh2X2tleGVjX2hhbmRsZXIodm9pZCkNCj4gPiAgew0KPiA+ICAJaHZfc3RpbWVyX2dsb2Jh
bF9jbGVhbnVwKCk7DQo+ID4gIAl2bWJ1c19pbml0aWF0ZV91bmxvYWQoZmFsc2UpOw0KPiA+IC0J
dm1idXNfY29ubmVjdGlvbi5jb25uX3N0YXRlID0gRElTQ09OTkVDVEVEOw0KPiA+ICAJLyogTWFr
ZSBzdXJlIGNvbm5fc3RhdGUgaXMgc2V0IGFzIGh2X3N5bmljX2NsZWFudXAgY2hlY2tzIGZvciBp
dCAqLw0KPiA+ICAJbWIoKTsNCj4gPiAgCWNwdWhwX3JlbW92ZV9zdGF0ZShoeXBlcnZfY3B1aHBf
b25saW5lKTsNCj4gPiBAQCAtMjMwNiw3ICsyMzA4LDYgQEAgc3RhdGljIHZvaWQgaHZfY3Jhc2hf
aGFuZGxlcihzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gPiAgCSAqIGRvaW5nIHRoZSBjbGVhbnVw
IGZvciBjdXJyZW50IENQVSBvbmx5LiBUaGlzIHNob3VsZCBiZSBzdWZmaWNpZW50DQo+ID4gIAkg
KiBmb3Iga2R1bXAuDQo+ID4gIAkgKi8NCj4gPiAtCXZtYnVzX2Nvbm5lY3Rpb24uY29ubl9zdGF0
ZSA9IERJU0NPTk5FQ1RFRDsNCj4gPiAgCWNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsNCj4gPiAg
CWh2X3N0aW1lcl9jbGVhbnVwKGNwdSk7DQo+ID4gIAlodl9zeW5pY19kaXNhYmxlX3JlZ3MoY3B1
KTsNCj4gDQo+IC0tDQo+IFZpdGFseQ0KDQo=
