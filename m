Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D988918BBDF
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 17:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCSQHd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 12:07:33 -0400
Received: from mail-bn8nam12on2091.outbound.protection.outlook.com ([40.107.237.91]:50011
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbgCSQHc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 12:07:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FahaU6QLBCgpGQxi7QDw2RsZge6bBpy3JEniLZGaxP067VtWzKAxeolP1N5qgi8jshUiX3TB5Pwc834HuifK3nlgAzTg0uLSSi0p1ckxMd2zY53oyDP0giwM4RJ2tahU0PVh/nIzEOksC1kfzEza45nBDhUO6xyYWq3rYVqVXnU3apNJlPpyYpHJ0AcE1qMKd6Pp8cTguo8LTjl3+iHjLPfuAtfqGgaXwwbS2KjncL+CAvRZRmMGWsLMt7oExJosoUTBxilnyOPgH+/2rVSTieBy3WqeVgkD3ZPV4RmLznKKXMEn4GQbWbbLc3UDWDp0MISL6jBPksYJ1fMtIUeKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n/ATR6OtbanbCeMRJjDYdVdLjMOVd/QSAsMfGoeCyk=;
 b=YWvBTMWJqEJ6LzFyQBJW7jvxO3Ykl0ocUU5qPAw7oTi5UJtkVsP1vB+faIR0EFLys6GN4+x+u0pSMFnhH84h4d85cWloZ/i6TenKpkZ5xtM+T9SZLROawBwsD7nB7nCiaemRmmkZ/QFog3E/5rDj3lIxNANXorRLGhHmaSmQeVUOdeqksU2bvnLLyYkYx1yG0JljZpHI5YNTHHKIGZR4USPErWVSH12GfCov779vJNDcOuZORdo2Qd3JW2dwQz5hfU6ByxJuh16UA/+fYWp7gGW6W3pdl0rMIMR7hbH9KLVyN9WoFFpZais9Afvv+BEIyqJtlncl0EZksM9+XGEn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n/ATR6OtbanbCeMRJjDYdVdLjMOVd/QSAsMfGoeCyk=;
 b=YGFEUBzlxq61sIM9l7kGMsEA5IpKlltjWsoZC0k48zjPF+exVxZ3Q1E6OTwkgDP71y+2IOygaPoU1N+U49qo7iLTx64SpCI00N4NM7oSQJxyKomfUdsryv+xQ91dZjVZxZit4cdUYdoa45I9gmjtt8vVL9DA2+l6MTrn/oj+k80=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0940.namprd21.prod.outlook.com (2603:10b6:302:4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.2; Thu, 19 Mar
 2020 16:07:28 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.003; Thu, 19 Mar 2020
 16:07:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 0/4] x86/Hyper-V: Panic code path fixes
Thread-Topic: [PATCH 0/4] x86/Hyper-V: Panic code path fixes
Thread-Index: AQHV/F+JseEF95+YQU+g3MTcEXvX1qhPGEGQgADeooCAABDCQIAADzQw
Date:   Thu, 19 Mar 2020 16:07:28 +0000
Message-ID: <MW2PR2101MB1052A7AFC5222CC9D78FA77ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1052F185AF4134EB2BB9ECBFD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <1d1bc90c-7fbe-6123-eeea-5f9a5aad77e4@gmail.com>
 <MW2PR2101MB10524F27F366005959A1007FD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10524F27F366005959A1007FD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T15:14:44.6827766Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e59e626b-b660-4973-ae54-19d0fbe28147;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 370c11b2-fe06-44ae-1cdd-08d7cc1f9f58
x-ms-traffictypediagnostic: MW2PR2101MB0940:|MW2PR2101MB0940:|MW2PR2101MB0940:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09402A22F0F2D908CED25A58D7F40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(81166006)(4326008)(5660300002)(66946007)(66556008)(186003)(76116006)(64756008)(2906002)(66446008)(10290500003)(33656002)(71200400001)(316002)(66476007)(86362001)(8936002)(54906003)(9686003)(7696005)(55016002)(81156014)(26005)(6506007)(8676002)(478600001)(8990500004)(110136005)(52536014)(2940100002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kQ3JsAi6Xn93mc30EBc+zCSeC/pqVhcmlJeWd2ZFTC/EntQ8Ylt1k2VptFKJ3epNJMyYssCNFztWjYTK/sxL703UuFg68m2GvifWmQXYmnOQ54oT8tDr0Xe/mSN+9TLMZeIzf+HrzLDnZGXNxVpK/h4wNgj1Rv0PX+VNirxMXtFYPMe+EHPm3GSvTBp8pL3Sb1CtG+EM2kXzQKkFitKxKPatXgbJfqMNHfJseCjxCyqUVIAYQsnCWORg7qx2zfvD+g+geeV//LuL8TzEgwEbykRFneyWCp1A9BBWhj+GubK+EbjHz5vp3jh+R3gKK6OmbeQXzxEjDc4m17JSfzzha+lLHn/VxDln33QI8320kdp+nTTG9+d0oza7iPavFh9S31Eh5Vdvyvi3xy4VSRsj6aUbDqRAPumX4FTw+kURrFg0Ryw5oz+Ikl6yRaVNKpZ0Buu99eAXncyT75hhDCiEjJFYVhDJUf3/ny+B/YtJ4ndXLe3P5dh7ajf2S4gp3N6
x-ms-exchange-antispam-messagedata: vSvTDxQWZIwetHEwP7vt+Q71dMus2ClJZ3M7nKG34udJdm0GgZTJsDWynNJsqUKqw3UeYdElfJ46T3t/82xZn/OQ4rTy+HeEWFYp+8lgasOmbude95XqkzWOYJlD1VrH8QyD/53ByqubEWcdTG0IQg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370c11b2-fe06-44ae-1cdd-08d7cc1f9f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 16:07:28.4869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4NCnX0PjwnAxQdAZGFLGZeizfuSVJWF+LbXDDVIj2LCx4GMsXWb5krunW/zhx9dqWKj4bK4LYWe+4g+Q0hlYo/y2aCqnKik7RYLctTxpMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+IFNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCAxOSwgMjAyMCA4OjE1IEFNDQo+IA0KPiBGcm9tOiBUaWFueXUgTGFuIDxUaWFu
eXUuTGFuQG1pY3Jvc29mdC5jb20+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxOSwgMjAyMCA3OjA4
IEFNDQo+ID4gPj4NCj4gPiA+PiBUaGlzIHBhdGNoc2V0IGZpeGVzIHNvbWUgaXNzdWVzIGluIHRo
ZSBIeXBlci1WIHBhbmljIGNvZGUgcGF0aC4NCj4gPiA+PiBQYXRjaCAxIHJlc29sdmVzIGlzc3Vl
IHRoYXQgcGFuaWMgc3lzdGVtIHN0aWxsIHJlc3BvbnNlcyBuZXR3b3JrDQo+ID4gPj4gcGFja2V0
cy4NCj4gPiA+PiBQYXRjaCAyLTMgcmVzb2x2ZXMgY3Jhc2ggZW5saWdodGVubWVudCBpc3N1ZXMu
DQo+ID4gPj4gUGF0Y2ggNCBpcyB0byBzZXQgY3Jhc2hfa2V4ZWNfcG9zdF9ub3RpZmllcnMgdG8g
dHJ1ZSBmb3IgSHlwZXItVg0KPiA+ID4+IFZNIGluIG9yZGVyIHRvIHJlcG9ydCBjcmFzaCBkYXRh
IG9yIGttc2cgdG8gaG9zdCBiZWZvcmUgcnVubmluZw0KPiA+ID4+IGtkdW1wIGtlcm5lbC4NCj4g
PiA+DQo+ID4gPiBJIHN0aWxsIHNlZSBhbiBpc3N1ZSB0aGF0IGlzbid0IGFkZHJlc3NlZCBieSB0
aGVzZSBwYXRjaGVzLiAgVGhlIFZNYnVzDQo+ID4gPiBkcml2ZXIgcmVnaXN0ZXJzIGEgImRpZSBu
b3RpZmllciIgYW5kIGEgInBhbmljIG5vdGlmaWVyIi4gICBCdXQgZGllKCkgd2lsbA0KPiA+ID4g
ZXZlbnR1YWxseSBjYWxsIHBhbmljKCkgaWYgcGFuaWNfb25fb29wcyBpcyBzZXQgKHdoaWNoIEkg
dGhpbmsgaXQgdHlwaWNhbGx5DQo+ID4gPiBpcykuICBJZiB0aGUgQ1JBU0hfTk9USUZZX01TRyBv
cHRpb24gaXMgKm5vdCogZW5hYmxlZCwgdGhlbg0KPiA+ID4gaHlwZXJ2X3JlcG9ydF9wYW5pYygp
IGNvdWxkIGdldCBjYWxsZWQgYnkgdGhlIGRpZSBub3RpZmllciwgYW5kIHRoZW4NCj4gPiA+IGFn
YWluIGJ5IHRoZSBwYW5pYyBub3RpZmllci4NCj4gPiA+DQo+ID4gPiBEbyB3ZSBldmVuIG5lZWQg
dGhlICJkaWUgbm90aWZpZXIiPyAgSWYgaXQgd2FzIHJlbW92ZWQsIHRoZXJlIHdvdWxkDQo+ID4g
PiBub3QgYmUgYW55IG5vdGlmaWNhdGlvbiB0byBIeXBlci1WIHZpYSB0aGUgZGllKCkgcGF0aCB1
bmxlc3MgcGFuaWNfb25fb29wcw0KPiA+ID4gaXMgc2V0LCB3aGljaCBJIHRoaW5rIGlzIGFjdHVh
bGx5IHRoZSBjb3JyZWN0IGJlaGF2aW9yLiAgSSdtIG5vdA0KPiA+ID4gY29tcGxldGVseSBjbGVh
ciBvbiB3aGF0IGlzIHN1cHBvc2VkIHRvIGhhcHBlbiBpbiBnZW5lcmFsIHRvIHRoZQ0KPiA+ID4g
TGludXgga2VybmVsIGlmIHBhbmljX29uX29vcHMgaXMgbm90IHNldC4gRG9lcyBpdCB0cnkgdG8g
Y29udGludWUgdG8gcnVuPw0KPiA+ID4gSWYgc28sIHRoZW4gd2Ugc2hvdWxkIG5vdCBiZSBub3Rp
ZnlpbmcgSHlwZXItViBpZiBwYW5pY19vbl9vb3BzIGlzIG5vdA0KPiA+ID4gc2V0LCBhbmQgcmVt
b3ZpbmcgdGhlIGRpZSBub3RpZmllciBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uDQo+ID4gPg0K
PiA+DQo+ID4gaHlwZXJ2X3JlcG9ydF9wYW5pYygpIGhhcyByZS1lbnRlciBjaGVjayBpbnNpZGUg
YW5kIHNvIGtlcm5lbCBvbmx5DQo+ID4gcmVwb3J0cyBjcmFzaCByZWdpc3RlciBkYXRhIG9uY2Ug
ZHVyaW5nIGRpZSgpLg0KPiANCj4gQWgsIHllcywgeW91IGFyZSByaWdodC4NCj4gDQo+ID4gRnJv
bSBjb21tZW50IGluIHRoZQ0KPiA+IGh5cGVydl9yZXBvcnRfcGFuaWMoKSwgcmVnaXN0ZXIgdmFs
dWUgcmVwb3J0ZWQgaW4gZGllIGNoYWluIGlzIG1vcmUNCj4gPiBleGFjdCB0aGFuIHZhbHVlIGlu
IHBhbmljIGNoYWluLiBUaGUgcmVnaXN0ZXIgdmFsdWUgaW4gZGllIGNoYWluIGlzDQo+ID4gcGFz
c2VkIGJ5IGRpZSgpIGNhbGxlci4gUmVnaXN0ZXIgdmFsdWUgcmVwb3J0ZWQgaW4gcGFuaWMgY2hh
aW4NCj4gPiBpcyBjb2xsZWN0ZWQgaW4gdGhlIGh5cGVydl9wYW5pY19ldmVudCgpLg0KPiA+DQo+
ID4gSWYgcGFuaWNfb25fb29wcyBpcyBub3Qgc2V0LCB0aGUgdGFzayBzaG91bGQgYmUga2lsbGVk
IGFuZCBrZXJuZWwNCj4gPiBzdGlsbCBydW5zLiBJbiB0aGlzIGNhc2UsIHdlIG1heSBub3QgdHJp
Z2dlciBjcmFzaCBlbmxpZ2h0ZW5tZW50Lg0KPiANCj4gSSdtIG5vdCBjb21wbGV0ZWx5IGNsZWFy
IG9uIHlvdXIgbGFzdCBzdGF0ZW1lbnQuICAgSXQgc2VlbXMgbGlrZSB0aGVyZQ0KPiBpcyBzdGls
bCBhIHByb2JsZW0gaW4gdGhhdCBkaWUoKSB3aWxsIGNhbGwgaHlwZXJ2X3JlcG9ydF9wYW5pYygp
IGV2ZW4gaWYNCj4gcGFuaWNfb25fb29wcyBpcyBub3Qgc2V0LiAgV2Ugd2lsbCBoYXZlIHJlcG9y
dGVkIGEgcGFuaWMgdG8gSHlwZXItVg0KPiBldmVuIHRob3VnaCB0aGUgVk0gZGlkIG5vdCBzdG9w
IHJ1bm5pbmcuDQo+IA0KPiBNaWNoYWVsDQoNClRoZXJlJ3Mgb25lIG1vcmUgaXNzdWUgdG8gY29u
c2lkZXIuICBodl9rbXNnX2R1bXAoKSBza2lwcyBjYWxsaW5nDQpoeXBlcnZfcmVwb3J0X3Bhbmlj
X21zZygpIGlmIHN5c2N0bF9yZWNvcmRfcGFuaWNfbXNnIGhhcyBiZWVuIGNsZWFyZWQNCmJ5IGEg
c3lzY3RsIGNvbW1hbmQuICAoVGhpcyBzeXNjdGwgb3B0aW9uIGdpdmVzIGEgY3VzdG9tZXIgdGhl
IGFiaWxpdHkgdG8gDQppbmNyZWFzZSBwcml2YWN5IGJ5IG5vdCBoYXZpbmcgdGhlIFZNJ3MgZG1l
c2cgY29udGVudHMgc2VudCB0byBIeXBlci1WLikNCkluIHRoaXMgY2FzZSwgdGhlIGVhcmxpZXIg
aHlwZXJ2X3JlcG9ydF9wYW5pYygpIGNhbGwgc2hvdWxkIGJlIHVzZWQuICBPdGhlcndpc2UsDQp0
aGVyZSB3b3VsZCBub3QgYmUgYW55IG5vdGlmaWNhdGlvbiB0byBIeXBlci1WIGFib3V0IHRoZSBw
YW5pYy4NCg0KTWljaGFlbA0K
