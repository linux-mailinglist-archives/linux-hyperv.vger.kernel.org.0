Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D801218BAC1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgCSPPK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 11:15:10 -0400
Received: from mail-mw2nam10on2093.outbound.protection.outlook.com ([40.107.94.93]:22337
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbgCSPPJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 11:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRrwNVpTR8GsXItabakCACYYZMrht1Sfqj7jwMlPGqHq7CBzNvOHsT86zOWvuoSrvMt7hXoTk8xvcsHZvt1UxgZxkhUX5+OjEvSqeDtk9G/BS8zrry+dOJse+Gq2E82WHnyBlndWpMw3kPxziK7xAbG9GGgGpkZ5W5WGcXPQ6GIdbysGsw6MYtWYcvxA2gvQJr8GrKeblJW9lErnq2uB7I6DD5oHqNw0OjQzKEagUTSL3bOMzNaoSs6hPoDjujGHUtX9PXi0iW1S6fVqdIBES8ArA356I4Hsj51+OjGNuINeOASq4IFH/4/rGLl3dh0i532IeCKUVyIUwgqJuSjY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHdRQRrsxETOyiSfx5GdTXR4bXba+PSLDtduEbN63jk=;
 b=V0khemAq68ef/40yoAmD6y3F+JC5FyzOMSgMMOh7Y5XN6DkxusgPEj58e+pwINj4qi5RROFcFE3I8I4xAOvtftzHxqcr1KJWEhRgDVKRjRlYUleNG3K5Rh+iiw/K4yqxYMM7FfVTq2JrRUubiqUz4uj4X/myCha5VCXTxItJSJ6KBZsLtXtWpN2d+jz2bWvCf1OU59fTwBgv4td7hDziwXEpvNV4UqdnosgDBhet2Fa4i8UHpKSJ7Y+oyR9dEjP4977ruZ5Lh5CmpUc7UnuhdyXV/tgo0rwb26I9jSvGP+0Q9shm9CHZs78PyoriOvALNzsnjy9B5ngzyJUi8BBh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHdRQRrsxETOyiSfx5GdTXR4bXba+PSLDtduEbN63jk=;
 b=ZtjuYHU0FsULBFj+Rz+Qn+aaZrs6GFmWDe7YZtzzKAUS2xF0558PXhKs5o9xf8g9jKT6Zlk0QCuq+Ve91yarF4tW9jGquFy5+4r3/g9NHwyKvcxoKmpq47e6BuAKhiZt2/4902p5zGMwj9s1xPiMxwijRJ6PPH6WpWgj6KodzHQ=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1001.namprd21.prod.outlook.com (2603:10b6:302:4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.3; Thu, 19 Mar
 2020 15:14:47 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.003; Thu, 19 Mar 2020
 15:14:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
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
Thread-Index: AQHV/F+JseEF95+YQU+g3MTcEXvX1qhPGEGQgADeooCAABDCQA==
Date:   Thu, 19 Mar 2020 15:14:47 +0000
Message-ID: <MW2PR2101MB10524F27F366005959A1007FD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1052F185AF4134EB2BB9ECBFD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <1d1bc90c-7fbe-6123-eeea-5f9a5aad77e4@gmail.com>
In-Reply-To: <1d1bc90c-7fbe-6123-eeea-5f9a5aad77e4@gmail.com>
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
x-ms-office365-filtering-correlation-id: 534dc0db-e1b7-4c9c-4d95-08d7cc1842f7
x-ms-traffictypediagnostic: MW2PR2101MB1001:|MW2PR2101MB1001:|MW2PR2101MB1001:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1001EA14BB894E81CA397894D7F40@MW2PR2101MB1001.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(8990500004)(110136005)(478600001)(66476007)(66946007)(76116006)(54906003)(4326008)(33656002)(8676002)(66556008)(81166006)(81156014)(8936002)(64756008)(66446008)(86362001)(26005)(55016002)(71200400001)(5660300002)(316002)(2906002)(6506007)(52536014)(9686003)(186003)(10290500003)(7696005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1001;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09D4rKkywUaq9pDs+SG/Mkg/hDPAJEhGfzL/X5Y4m8TegJ9YTHfX9AQiG7dei9ZQQSFw7QWUUJKARJZ/Y5gnBaA+ZNBO1SkYFDgjbPDrZUYCHPF/bevVq7VPLohqWZTwcqgp3tzUh+IgG4yiQNZMj6EBupNsNig3bR45ZEC2zUVVftv9sfy5FRU3azH2dgzlaTBQ9NwE66hqNtxNfKpvB/bFU18joqF+DLBBfNOCd2fWVrxgU8NSSebxLrak8WqTTjywfpAxH9+eso+IEijwoq5GcHFhwvY0qeASyDgjKkhOTdG+QKrxv/ejcQsdPN4E8aSjFh/pFNfHLVX/T1cMIc1yMwgMj6xanwajXkTl8BmrDjIt3pMSsZI+zXUlbJhZ1l/XB/hw67zaUJ7AkHFxAPQBJbR4k02jYUTvMvkTJN64cQCZnzZ6alm6VrC6ErXaRUHxI9NCWIg9rt+e0NPd5G+w933ay/bvP4cO5MXiU7IXhbMHCj/ziSL85qXMr5lN
x-ms-exchange-antispam-messagedata: DKYFxVbttH3EIA1jnGmo06SwXBlMbudQ9BaxXrra8PaCvd+5eS9i5uHBXG1qnId2E2XnRx/GDMRmq3C4I/7feywTTGwxQAbOprVIZ5V87swbdUV1pUufnJW4+S4LeB0EufJ2VBWJ1lRZ9myXanR3UQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534dc0db-e1b7-4c9c-4d95-08d7cc1842f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 15:14:47.0559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ja4MnUoOniZWqReKLwS9Q3szdWxXE/Ys8kQGqObdIw4Ts69dwWFrah3a2nfUslT7zdmK62aZTAmQlz3/dxK3He2M07BRR/Ag6hI26l9XKz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2Rh
eSwgTWFyY2ggMTksIDIwMjAgNzowOCBBTQ0KPiA+Pg0KPiA+PiBUaGlzIHBhdGNoc2V0IGZpeGVz
IHNvbWUgaXNzdWVzIGluIHRoZSBIeXBlci1WIHBhbmljIGNvZGUgcGF0aC4NCj4gPj4gUGF0Y2gg
MSByZXNvbHZlcyBpc3N1ZSB0aGF0IHBhbmljIHN5c3RlbSBzdGlsbCByZXNwb25zZXMgbmV0d29y
aw0KPiA+PiBwYWNrZXRzLg0KPiA+PiBQYXRjaCAyLTMgcmVzb2x2ZXMgY3Jhc2ggZW5saWdodGVu
bWVudCBpc3N1ZXMuDQo+ID4+IFBhdGNoIDQgaXMgdG8gc2V0IGNyYXNoX2tleGVjX3Bvc3Rfbm90
aWZpZXJzIHRvIHRydWUgZm9yIEh5cGVyLVYNCj4gPj4gVk0gaW4gb3JkZXIgdG8gcmVwb3J0IGNy
YXNoIGRhdGEgb3Iga21zZyB0byBob3N0IGJlZm9yZSBydW5uaW5nDQo+ID4+IGtkdW1wIGtlcm5l
bC4NCj4gPg0KPiA+IEkgc3RpbGwgc2VlIGFuIGlzc3VlIHRoYXQgaXNuJ3QgYWRkcmVzc2VkIGJ5
IHRoZXNlIHBhdGNoZXMuICBUaGUgVk1idXMNCj4gPiBkcml2ZXIgcmVnaXN0ZXJzIGEgImRpZSBu
b3RpZmllciIgYW5kIGEgInBhbmljIG5vdGlmaWVyIi4gICBCdXQgZGllKCkgd2lsbA0KPiA+IGV2
ZW50dWFsbHkgY2FsbCBwYW5pYygpIGlmIHBhbmljX29uX29vcHMgaXMgc2V0ICh3aGljaCBJIHRo
aW5rIGl0IHR5cGljYWxseQ0KPiA+IGlzKS4gIElmIHRoZSBDUkFTSF9OT1RJRllfTVNHIG9wdGlv
biBpcyAqbm90KiBlbmFibGVkLCB0aGVuDQo+ID4gaHlwZXJ2X3JlcG9ydF9wYW5pYygpIGNvdWxk
IGdldCBjYWxsZWQgYnkgdGhlIGRpZSBub3RpZmllciwgYW5kIHRoZW4NCj4gPiBhZ2FpbiBieSB0
aGUgcGFuaWMgbm90aWZpZXIuDQo+ID4NCj4gPiBEbyB3ZSBldmVuIG5lZWQgdGhlICJkaWUgbm90
aWZpZXIiPyAgSWYgaXQgd2FzIHJlbW92ZWQsIHRoZXJlIHdvdWxkDQo+ID4gbm90IGJlIGFueSBu
b3RpZmljYXRpb24gdG8gSHlwZXItViB2aWEgdGhlIGRpZSgpIHBhdGggdW5sZXNzIHBhbmljX29u
X29vcHMNCj4gPiBpcyBzZXQsIHdoaWNoIEkgdGhpbmsgaXMgYWN0dWFsbHkgdGhlIGNvcnJlY3Qg
YmVoYXZpb3IuICBJJ20gbm90DQo+ID4gY29tcGxldGVseSBjbGVhciBvbiB3aGF0IGlzIHN1cHBv
c2VkIHRvIGhhcHBlbiBpbiBnZW5lcmFsIHRvIHRoZQ0KPiA+IExpbnV4IGtlcm5lbCBpZiBwYW5p
Y19vbl9vb3BzIGlzIG5vdCBzZXQuIERvZXMgaXQgdHJ5IHRvIGNvbnRpbnVlIHRvIHJ1bj8NCj4g
PiBJZiBzbywgdGhlbiB3ZSBzaG91bGQgbm90IGJlIG5vdGlmeWluZyBIeXBlci1WIGlmIHBhbmlj
X29uX29vcHMgaXMgbm90DQo+ID4gc2V0LCBhbmQgcmVtb3ZpbmcgdGhlIGRpZSBub3RpZmllciBp
cyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uDQo+ID4NCj4gDQo+IGh5cGVydl9yZXBvcnRfcGFuaWMo
KSBoYXMgcmUtZW50ZXIgY2hlY2sgaW5zaWRlIGFuZCBzbyBrZXJuZWwgb25seQ0KPiByZXBvcnRz
IGNyYXNoIHJlZ2lzdGVyIGRhdGEgb25jZSBkdXJpbmcgZGllKCkuDQoNCkFoLCB5ZXMsIHlvdSBh
cmUgcmlnaHQuDQoNCj4gRnJvbSBjb21tZW50IGluIHRoZQ0KPiBoeXBlcnZfcmVwb3J0X3Bhbmlj
KCksIHJlZ2lzdGVyIHZhbHVlIHJlcG9ydGVkIGluIGRpZSBjaGFpbiBpcyBtb3JlDQo+IGV4YWN0
IHRoYW4gdmFsdWUgaW4gcGFuaWMgY2hhaW4uIFRoZSByZWdpc3RlciB2YWx1ZSBpbiBkaWUgY2hh
aW4gaXMNCj4gcGFzc2VkIGJ5IGRpZSgpIGNhbGxlci4gUmVnaXN0ZXIgdmFsdWUgcmVwb3J0ZWQg
aW4gcGFuaWMgY2hhaW4NCj4gaXMgY29sbGVjdGVkIGluIHRoZSBoeXBlcnZfcGFuaWNfZXZlbnQo
KS4gDQo+IA0KPiBJZiBwYW5pY19vbl9vb3BzIGlzIG5vdCBzZXQsIHRoZSB0YXNrIHNob3VsZCBi
ZSBraWxsZWQgYW5kIGtlcm5lbA0KPiBzdGlsbCBydW5zLiBJbiB0aGlzIGNhc2UsIHdlIG1heSBu
b3QgdHJpZ2dlciBjcmFzaCBlbmxpZ2h0ZW5tZW50Lg0KDQpJJ20gbm90IGNvbXBsZXRlbHkgY2xl
YXIgb24geW91ciBsYXN0IHN0YXRlbWVudC4gICBJdCBzZWVtcyBsaWtlIHRoZXJlDQppcyBzdGls
bCBhIHByb2JsZW0gaW4gdGhhdCBkaWUoKSB3aWxsIGNhbGwgaHlwZXJ2X3JlcG9ydF9wYW5pYygp
IGV2ZW4gaWYNCnBhbmljX29uX29vcHMgaXMgbm90IHNldC4gIFdlIHdpbGwgaGF2ZSByZXBvcnRl
ZCBhIHBhbmljIHRvIEh5cGVyLVYNCmV2ZW4gdGhvdWdoIHRoZSBWTSBkaWQgbm90IHN0b3AgcnVu
bmluZy4NCg0KTWljaGFlbA0K
